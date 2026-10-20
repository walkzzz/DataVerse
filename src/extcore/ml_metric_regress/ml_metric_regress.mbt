///===
/// extcore/ml_metric_regress

pub(all) struct MlmetricregressPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_regress_make_point(x : Double, y : Double) -> MlmetricregressPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_regress_make_point3(x : Double, y : Double, z : Double) -> MlmetricregressPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricregressPoint::x(self : MlmetricregressPoint) -> Double { self.x }

pub fn MlmetricregressPoint::y(self : MlmetricregressPoint) -> Double { self.y }

pub fn MlmetricregressPoint::z(self : MlmetricregressPoint) -> Double { self.z }

pub fn MlmetricregressPoint::label(self : MlmetricregressPoint) -> Int { self.label }

pub fn MlmetricregressPoint::dist(self : MlmetricregressPoint, other : MlmetricregressPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricregressPoint::add(self : MlmetricregressPoint, other : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricregressPoint::sub(self : MlmetricregressPoint, other : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricregressPoint::scale(self : MlmetricregressPoint, s : Double) -> MlmetricregressPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricregressPoint::dot(self : MlmetricregressPoint, other : MlmetricregressPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricregressPoint::cross(self : MlmetricregressPoint, other : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricregressPoint::norm(self : MlmetricregressPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricregressPoint::normalize(self : MlmetricregressPoint) -> MlmetricregressPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricregressPoint::negate(self : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricregressPoint::mid(self : MlmetricregressPoint, other : MlmetricregressPoint) -> MlmetricregressPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricregressPoint::lerp(self : MlmetricregressPoint, other : MlmetricregressPoint, t : Double) -> MlmetricregressPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricregressPoint::to_string(self : MlmetricregressPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricregressSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_regress_make_series(vals : Array[Double], name : String) -> MlmetricregressSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricregressSeries::len(self : MlmetricregressSeries) -> Int { self.vals.length() }

pub fn MlmetricregressSeries::sum(self : MlmetricregressSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricregressSeries::mean(self : MlmetricregressSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricregressSeries::min(self : MlmetricregressSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricregressSeries::max(self : MlmetricregressSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricregressSeries::range(self : MlmetricregressSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricregressSeries::variance(self : MlmetricregressSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricregressSeries::std(self : MlmetricregressSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricregressSeries::median(self : MlmetricregressSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricregressSeries::scale(self : MlmetricregressSeries, f : Double) -> MlmetricregressSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricregressSeries::add(self : MlmetricregressSeries, other : MlmetricregressSeries) -> MlmetricregressSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricregressSeries::sub(self : MlmetricregressSeries, other : MlmetricregressSeries) -> MlmetricregressSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricregressSeries::normalize(self : MlmetricregressSeries) -> MlmetricregressSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricregressSeries::cumsum(self : MlmetricregressSeries) -> MlmetricregressSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricregressSeries::to_string(self : MlmetricregressSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricregressMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_regress_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricregressMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_regress_matrix_identity(n : Int) -> MlmetricregressMatrix {
  let m = ml_metric_regress_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricregressMatrix::get(self : MlmetricregressMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricregressMatrix::transpose(self : MlmetricregressMatrix) -> MlmetricregressMatrix {
  let result = ml_metric_regress_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricregressMatrix::add(self : MlmetricregressMatrix, other : MlmetricregressMatrix) -> MlmetricregressMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_regress_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricregressMatrix::scale(self : MlmetricregressMatrix, s : Double) -> MlmetricregressMatrix {
  let result = ml_metric_regress_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricregressMatrix::multiply(self : MlmetricregressMatrix, other : MlmetricregressMatrix) -> MlmetricregressMatrix {
  if self.cols != other.rows { return ml_metric_regress_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_regress_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlmetricregressMatrix::trace(self : MlmetricregressMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricregressMatrix::det(self : MlmetricregressMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricregressMatrix::norm(self : MlmetricregressMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricregressMatrix::to_string(self : MlmetricregressMatrix) -> String {
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

pub(all) struct MlmetricregressVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_regress_make_vector(comps : Array[Double]) -> MlmetricregressVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_regress_vector_zero(dim : Int) -> MlmetricregressVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricregressVector::add(self : MlmetricregressVector, other : MlmetricregressVector) -> MlmetricregressVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricregressVector::sub(self : MlmetricregressVector, other : MlmetricregressVector) -> MlmetricregressVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricregressVector::scale(self : MlmetricregressVector, s : Double) -> MlmetricregressVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricregressVector::dot(self : MlmetricregressVector, other : MlmetricregressVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricregressVector::norm(self : MlmetricregressVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricregressVector::normalize(self : MlmetricregressVector) -> MlmetricregressVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricregressVector::dist(self : MlmetricregressVector, other : MlmetricregressVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricregressVector::to_string(self : MlmetricregressVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_regress_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_regress_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_regress_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_regress_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_regress_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_regress_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_regress_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_regress_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_regress_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_regress_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_regress_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_regress_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_regress_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_regress_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_regress_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_regress_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_regress_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_regress_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_regress_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_regress_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_regress_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_regress_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_regress_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_regress_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_regress_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_regress_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_regress_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_regress_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_regress_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricregressFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_frame_make(size : Int) -> MlmetricregressFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_frame_len(s : MlmetricregressFrame) -> Int { s.size }

pub fn ml_metric_regress_frame_get(s : MlmetricregressFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_frame_set(s : MlmetricregressFrame, i : Int, v : Double) -> MlmetricregressFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_frame_sum(s : MlmetricregressFrame) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_frame_mean(s : MlmetricregressFrame) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_frame_scale(s : MlmetricregressFrame, f : Double) -> MlmetricregressFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_frame_add(a : MlmetricregressFrame, b : MlmetricregressFrame) -> MlmetricregressFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_frame_copy(s : MlmetricregressFrame) -> MlmetricregressFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_frame_fill(s : MlmetricregressFrame, v : Double) -> MlmetricregressFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_frame_min(s : MlmetricregressFrame) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_frame_max(s : MlmetricregressFrame) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_frame_to_string(s : MlmetricregressFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_table_make(size : Int) -> MlmetricregressTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_table_len(s : MlmetricregressTable) -> Int { s.size }

pub fn ml_metric_regress_table_get(s : MlmetricregressTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_table_set(s : MlmetricregressTable, i : Int, v : Double) -> MlmetricregressTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_table_sum(s : MlmetricregressTable) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_table_mean(s : MlmetricregressTable) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_table_scale(s : MlmetricregressTable, f : Double) -> MlmetricregressTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_table_add(a : MlmetricregressTable, b : MlmetricregressTable) -> MlmetricregressTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_table_copy(s : MlmetricregressTable) -> MlmetricregressTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_table_fill(s : MlmetricregressTable, v : Double) -> MlmetricregressTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_table_min(s : MlmetricregressTable) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_table_max(s : MlmetricregressTable) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_table_to_string(s : MlmetricregressTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_graphn_make(size : Int) -> MlmetricregressGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_graphn_len(s : MlmetricregressGraphN) -> Int { s.size }

pub fn ml_metric_regress_graphn_get(s : MlmetricregressGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_graphn_set(s : MlmetricregressGraphN, i : Int, v : Double) -> MlmetricregressGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_graphn_sum(s : MlmetricregressGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_graphn_mean(s : MlmetricregressGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_graphn_scale(s : MlmetricregressGraphN, f : Double) -> MlmetricregressGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_graphn_add(a : MlmetricregressGraphN, b : MlmetricregressGraphN) -> MlmetricregressGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_graphn_copy(s : MlmetricregressGraphN) -> MlmetricregressGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_graphn_fill(s : MlmetricregressGraphN, v : Double) -> MlmetricregressGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_graphn_min(s : MlmetricregressGraphN) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_graphn_max(s : MlmetricregressGraphN) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_graphn_to_string(s : MlmetricregressGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_node_make(size : Int) -> MlmetricregressNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_node_len(s : MlmetricregressNode) -> Int { s.size }

pub fn ml_metric_regress_node_get(s : MlmetricregressNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_node_set(s : MlmetricregressNode, i : Int, v : Double) -> MlmetricregressNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_node_sum(s : MlmetricregressNode) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_node_mean(s : MlmetricregressNode) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_node_scale(s : MlmetricregressNode, f : Double) -> MlmetricregressNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_node_add(a : MlmetricregressNode, b : MlmetricregressNode) -> MlmetricregressNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_node_copy(s : MlmetricregressNode) -> MlmetricregressNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_node_fill(s : MlmetricregressNode, v : Double) -> MlmetricregressNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_node_min(s : MlmetricregressNode) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_node_max(s : MlmetricregressNode) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_node_to_string(s : MlmetricregressNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_edge_make(size : Int) -> MlmetricregressEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_edge_len(s : MlmetricregressEdge) -> Int { s.size }

pub fn ml_metric_regress_edge_get(s : MlmetricregressEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_edge_set(s : MlmetricregressEdge, i : Int, v : Double) -> MlmetricregressEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_edge_sum(s : MlmetricregressEdge) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_edge_mean(s : MlmetricregressEdge) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_edge_scale(s : MlmetricregressEdge, f : Double) -> MlmetricregressEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_edge_add(a : MlmetricregressEdge, b : MlmetricregressEdge) -> MlmetricregressEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_edge_copy(s : MlmetricregressEdge) -> MlmetricregressEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_edge_fill(s : MlmetricregressEdge, v : Double) -> MlmetricregressEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_edge_min(s : MlmetricregressEdge) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_edge_max(s : MlmetricregressEdge) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_edge_to_string(s : MlmetricregressEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_path_make(size : Int) -> MlmetricregressPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_path_len(s : MlmetricregressPath) -> Int { s.size }

pub fn ml_metric_regress_path_get(s : MlmetricregressPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_path_set(s : MlmetricregressPath, i : Int, v : Double) -> MlmetricregressPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_path_sum(s : MlmetricregressPath) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_path_mean(s : MlmetricregressPath) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_path_scale(s : MlmetricregressPath, f : Double) -> MlmetricregressPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_path_add(a : MlmetricregressPath, b : MlmetricregressPath) -> MlmetricregressPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_path_copy(s : MlmetricregressPath) -> MlmetricregressPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_path_fill(s : MlmetricregressPath, v : Double) -> MlmetricregressPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_path_min(s : MlmetricregressPath) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_path_max(s : MlmetricregressPath) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_path_to_string(s : MlmetricregressPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_cluster_make(size : Int) -> MlmetricregressCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_cluster_len(s : MlmetricregressCluster) -> Int { s.size }

pub fn ml_metric_regress_cluster_get(s : MlmetricregressCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_cluster_set(s : MlmetricregressCluster, i : Int, v : Double) -> MlmetricregressCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_cluster_sum(s : MlmetricregressCluster) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_cluster_mean(s : MlmetricregressCluster) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_cluster_scale(s : MlmetricregressCluster, f : Double) -> MlmetricregressCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_cluster_add(a : MlmetricregressCluster, b : MlmetricregressCluster) -> MlmetricregressCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_cluster_copy(s : MlmetricregressCluster) -> MlmetricregressCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_cluster_fill(s : MlmetricregressCluster, v : Double) -> MlmetricregressCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_cluster_min(s : MlmetricregressCluster) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_cluster_max(s : MlmetricregressCluster) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_cluster_to_string(s : MlmetricregressCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_model_make(size : Int) -> MlmetricregressModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_model_len(s : MlmetricregressModel) -> Int { s.size }

pub fn ml_metric_regress_model_get(s : MlmetricregressModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_model_set(s : MlmetricregressModel, i : Int, v : Double) -> MlmetricregressModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_model_sum(s : MlmetricregressModel) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_model_mean(s : MlmetricregressModel) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_model_scale(s : MlmetricregressModel, f : Double) -> MlmetricregressModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_model_add(a : MlmetricregressModel, b : MlmetricregressModel) -> MlmetricregressModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_model_copy(s : MlmetricregressModel) -> MlmetricregressModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_model_fill(s : MlmetricregressModel, v : Double) -> MlmetricregressModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_model_min(s : MlmetricregressModel) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_model_max(s : MlmetricregressModel) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_model_to_string(s : MlmetricregressModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_layer_make(size : Int) -> MlmetricregressLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_layer_len(s : MlmetricregressLayer) -> Int { s.size }

pub fn ml_metric_regress_layer_get(s : MlmetricregressLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_layer_set(s : MlmetricregressLayer, i : Int, v : Double) -> MlmetricregressLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_layer_sum(s : MlmetricregressLayer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_layer_mean(s : MlmetricregressLayer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_layer_scale(s : MlmetricregressLayer, f : Double) -> MlmetricregressLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_layer_add(a : MlmetricregressLayer, b : MlmetricregressLayer) -> MlmetricregressLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_layer_copy(s : MlmetricregressLayer) -> MlmetricregressLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_layer_fill(s : MlmetricregressLayer, v : Double) -> MlmetricregressLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_layer_min(s : MlmetricregressLayer) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_layer_max(s : MlmetricregressLayer) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_layer_to_string(s : MlmetricregressLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_buffer_make(size : Int) -> MlmetricregressBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_buffer_len(s : MlmetricregressBuffer) -> Int { s.size }

pub fn ml_metric_regress_buffer_get(s : MlmetricregressBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_buffer_set(s : MlmetricregressBuffer, i : Int, v : Double) -> MlmetricregressBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_buffer_sum(s : MlmetricregressBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_buffer_mean(s : MlmetricregressBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_buffer_scale(s : MlmetricregressBuffer, f : Double) -> MlmetricregressBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_buffer_add(a : MlmetricregressBuffer, b : MlmetricregressBuffer) -> MlmetricregressBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_buffer_copy(s : MlmetricregressBuffer) -> MlmetricregressBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_buffer_fill(s : MlmetricregressBuffer, v : Double) -> MlmetricregressBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_buffer_min(s : MlmetricregressBuffer) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_buffer_max(s : MlmetricregressBuffer) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_buffer_to_string(s : MlmetricregressBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_cursor_make(size : Int) -> MlmetricregressCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_cursor_len(s : MlmetricregressCursor) -> Int { s.size }

pub fn ml_metric_regress_cursor_get(s : MlmetricregressCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_cursor_set(s : MlmetricregressCursor, i : Int, v : Double) -> MlmetricregressCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_cursor_sum(s : MlmetricregressCursor) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_cursor_mean(s : MlmetricregressCursor) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_cursor_scale(s : MlmetricregressCursor, f : Double) -> MlmetricregressCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_cursor_add(a : MlmetricregressCursor, b : MlmetricregressCursor) -> MlmetricregressCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_cursor_copy(s : MlmetricregressCursor) -> MlmetricregressCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_cursor_fill(s : MlmetricregressCursor, v : Double) -> MlmetricregressCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_cursor_min(s : MlmetricregressCursor) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_cursor_max(s : MlmetricregressCursor) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_cursor_to_string(s : MlmetricregressCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_view_make(size : Int) -> MlmetricregressView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_view_len(s : MlmetricregressView) -> Int { s.size }

pub fn ml_metric_regress_view_get(s : MlmetricregressView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_view_set(s : MlmetricregressView, i : Int, v : Double) -> MlmetricregressView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_view_sum(s : MlmetricregressView) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_view_mean(s : MlmetricregressView) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_view_scale(s : MlmetricregressView, f : Double) -> MlmetricregressView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_view_add(a : MlmetricregressView, b : MlmetricregressView) -> MlmetricregressView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_view_copy(s : MlmetricregressView) -> MlmetricregressView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_view_fill(s : MlmetricregressView, v : Double) -> MlmetricregressView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_view_min(s : MlmetricregressView) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_view_max(s : MlmetricregressView) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_view_to_string(s : MlmetricregressView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_range_make(size : Int) -> MlmetricregressRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_range_len(s : MlmetricregressRange) -> Int { s.size }

pub fn ml_metric_regress_range_get(s : MlmetricregressRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_range_set(s : MlmetricregressRange, i : Int, v : Double) -> MlmetricregressRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_range_sum(s : MlmetricregressRange) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_range_mean(s : MlmetricregressRange) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_range_scale(s : MlmetricregressRange, f : Double) -> MlmetricregressRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_range_add(a : MlmetricregressRange, b : MlmetricregressRange) -> MlmetricregressRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_range_copy(s : MlmetricregressRange) -> MlmetricregressRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_range_fill(s : MlmetricregressRange, v : Double) -> MlmetricregressRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_range_min(s : MlmetricregressRange) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_range_max(s : MlmetricregressRange) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_range_to_string(s : MlmetricregressRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricregressSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_regress_slice_make(size : Int) -> MlmetricregressSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_regress_slice_len(s : MlmetricregressSlice) -> Int { s.size }

pub fn ml_metric_regress_slice_get(s : MlmetricregressSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_regress_slice_set(s : MlmetricregressSlice, i : Int, v : Double) -> MlmetricregressSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_slice_sum(s : MlmetricregressSlice) -> Double { @_common.sum(s.data) }

pub fn ml_metric_regress_slice_mean(s : MlmetricregressSlice) -> Double { @_common.mean(s.data) }

pub fn ml_metric_regress_slice_scale(s : MlmetricregressSlice, f : Double) -> MlmetricregressSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_slice_add(a : MlmetricregressSlice, b : MlmetricregressSlice) -> MlmetricregressSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_regress_slice_copy(s : MlmetricregressSlice) -> MlmetricregressSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_slice_fill(s : MlmetricregressSlice, v : Double) -> MlmetricregressSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_regress_slice_min(s : MlmetricregressSlice) -> Double { @_common.min(s.data) }

pub fn ml_metric_regress_slice_max(s : MlmetricregressSlice) -> Double { @_common.max(s.data) }

pub fn ml_metric_regress_slice_to_string(s : MlmetricregressSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

