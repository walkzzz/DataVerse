///===
/// extcore/ml_feature_selection

pub(all) struct MlfeatureselectionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_selection_make_point(x : Double, y : Double) -> MlfeatureselectionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_selection_make_point3(x : Double, y : Double, z : Double) -> MlfeatureselectionPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeatureselectionPoint::x(self : MlfeatureselectionPoint) -> Double { self.x }

pub fn MlfeatureselectionPoint::y(self : MlfeatureselectionPoint) -> Double { self.y }

pub fn MlfeatureselectionPoint::z(self : MlfeatureselectionPoint) -> Double { self.z }

pub fn MlfeatureselectionPoint::label(self : MlfeatureselectionPoint) -> Int { self.label }

pub fn MlfeatureselectionPoint::dist(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeatureselectionPoint::add(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeatureselectionPoint::sub(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeatureselectionPoint::scale(self : MlfeatureselectionPoint, s : Double) -> MlfeatureselectionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeatureselectionPoint::dot(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeatureselectionPoint::cross(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeatureselectionPoint::norm(self : MlfeatureselectionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeatureselectionPoint::normalize(self : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureselectionPoint::negate(self : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeatureselectionPoint::mid(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeatureselectionPoint::lerp(self : MlfeatureselectionPoint, other : MlfeatureselectionPoint, t : Double) -> MlfeatureselectionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeatureselectionPoint::to_string(self : MlfeatureselectionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeatureselectionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_selection_make_series(vals : Array[Double], name : String) -> MlfeatureselectionSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeatureselectionSeries::len(self : MlfeatureselectionSeries) -> Int { self.vals.length() }

pub fn MlfeatureselectionSeries::sum(self : MlfeatureselectionSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeatureselectionSeries::mean(self : MlfeatureselectionSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeatureselectionSeries::min(self : MlfeatureselectionSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeatureselectionSeries::max(self : MlfeatureselectionSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeatureselectionSeries::range(self : MlfeatureselectionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeatureselectionSeries::variance(self : MlfeatureselectionSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeatureselectionSeries::std(self : MlfeatureselectionSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeatureselectionSeries::median(self : MlfeatureselectionSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeatureselectionSeries::scale(self : MlfeatureselectionSeries, f : Double) -> MlfeatureselectionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeatureselectionSeries::add(self : MlfeatureselectionSeries, other : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeatureselectionSeries::sub(self : MlfeatureselectionSeries, other : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeatureselectionSeries::normalize(self : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeatureselectionSeries::cumsum(self : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeatureselectionSeries::to_string(self : MlfeatureselectionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureselectionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_selection_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureselectionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_selection_matrix_identity(n : Int) -> MlfeatureselectionMatrix {
  let m = ml_feature_selection_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeatureselectionMatrix::get(self : MlfeatureselectionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeatureselectionMatrix::transpose(self : MlfeatureselectionMatrix) -> MlfeatureselectionMatrix {
  let result = ml_feature_selection_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeatureselectionMatrix::add(self : MlfeatureselectionMatrix, other : MlfeatureselectionMatrix) -> MlfeatureselectionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_selection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeatureselectionMatrix::scale(self : MlfeatureselectionMatrix, s : Double) -> MlfeatureselectionMatrix {
  let result = ml_feature_selection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeatureselectionMatrix::multiply(self : MlfeatureselectionMatrix, other : MlfeatureselectionMatrix) -> MlfeatureselectionMatrix {
  if self.cols != other.rows { return ml_feature_selection_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_selection_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeatureselectionMatrix::trace(self : MlfeatureselectionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeatureselectionMatrix::det(self : MlfeatureselectionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeatureselectionMatrix::norm(self : MlfeatureselectionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeatureselectionMatrix::to_string(self : MlfeatureselectionMatrix) -> String {
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

pub(all) struct MlfeatureselectionVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_selection_make_vector(comps : Array[Double]) -> MlfeatureselectionVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_selection_vector_zero(dim : Int) -> MlfeatureselectionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeatureselectionVector::add(self : MlfeatureselectionVector, other : MlfeatureselectionVector) -> MlfeatureselectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureselectionVector::sub(self : MlfeatureselectionVector, other : MlfeatureselectionVector) -> MlfeatureselectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureselectionVector::scale(self : MlfeatureselectionVector, s : Double) -> MlfeatureselectionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeatureselectionVector::dot(self : MlfeatureselectionVector, other : MlfeatureselectionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeatureselectionVector::norm(self : MlfeatureselectionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeatureselectionVector::normalize(self : MlfeatureselectionVector) -> MlfeatureselectionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureselectionVector::dist(self : MlfeatureselectionVector, other : MlfeatureselectionVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeatureselectionVector::to_string(self : MlfeatureselectionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_selection_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_selection_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_selection_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_selection_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_selection_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_selection_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_selection_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_selection_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_selection_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_selection_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_selection_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_selection_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_selection_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_selection_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_selection_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_selection_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_selection_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_selection_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_selection_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_selection_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_selection_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_selection_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_selection_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_selection_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_selection_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_selection_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_selection_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_selection_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_selection_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeatureselectionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_frame_make(size : Int) -> MlfeatureselectionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_frame_len(s : MlfeatureselectionFrame) -> Int { s.size }

pub fn ml_feature_selection_frame_get(s : MlfeatureselectionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_frame_set(s : MlfeatureselectionFrame, i : Int, v : Double) -> MlfeatureselectionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_frame_sum(s : MlfeatureselectionFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_frame_mean(s : MlfeatureselectionFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_frame_scale(s : MlfeatureselectionFrame, f : Double) -> MlfeatureselectionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_frame_add(a : MlfeatureselectionFrame, b : MlfeatureselectionFrame) -> MlfeatureselectionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_frame_copy(s : MlfeatureselectionFrame) -> MlfeatureselectionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_frame_fill(s : MlfeatureselectionFrame, v : Double) -> MlfeatureselectionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_frame_min(s : MlfeatureselectionFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_frame_max(s : MlfeatureselectionFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_frame_to_string(s : MlfeatureselectionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_table_make(size : Int) -> MlfeatureselectionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_table_len(s : MlfeatureselectionTable) -> Int { s.size }

pub fn ml_feature_selection_table_get(s : MlfeatureselectionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_table_set(s : MlfeatureselectionTable, i : Int, v : Double) -> MlfeatureselectionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_table_sum(s : MlfeatureselectionTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_table_mean(s : MlfeatureselectionTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_table_scale(s : MlfeatureselectionTable, f : Double) -> MlfeatureselectionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_table_add(a : MlfeatureselectionTable, b : MlfeatureselectionTable) -> MlfeatureselectionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_table_copy(s : MlfeatureselectionTable) -> MlfeatureselectionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_table_fill(s : MlfeatureselectionTable, v : Double) -> MlfeatureselectionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_table_min(s : MlfeatureselectionTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_table_max(s : MlfeatureselectionTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_table_to_string(s : MlfeatureselectionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_graphn_make(size : Int) -> MlfeatureselectionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_graphn_len(s : MlfeatureselectionGraphN) -> Int { s.size }

pub fn ml_feature_selection_graphn_get(s : MlfeatureselectionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_graphn_set(s : MlfeatureselectionGraphN, i : Int, v : Double) -> MlfeatureselectionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_graphn_sum(s : MlfeatureselectionGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_graphn_mean(s : MlfeatureselectionGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_graphn_scale(s : MlfeatureselectionGraphN, f : Double) -> MlfeatureselectionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_graphn_add(a : MlfeatureselectionGraphN, b : MlfeatureselectionGraphN) -> MlfeatureselectionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_graphn_copy(s : MlfeatureselectionGraphN) -> MlfeatureselectionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_graphn_fill(s : MlfeatureselectionGraphN, v : Double) -> MlfeatureselectionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_graphn_min(s : MlfeatureselectionGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_graphn_max(s : MlfeatureselectionGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_graphn_to_string(s : MlfeatureselectionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_node_make(size : Int) -> MlfeatureselectionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_node_len(s : MlfeatureselectionNode) -> Int { s.size }

pub fn ml_feature_selection_node_get(s : MlfeatureselectionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_node_set(s : MlfeatureselectionNode, i : Int, v : Double) -> MlfeatureselectionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_node_sum(s : MlfeatureselectionNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_node_mean(s : MlfeatureselectionNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_node_scale(s : MlfeatureselectionNode, f : Double) -> MlfeatureselectionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_node_add(a : MlfeatureselectionNode, b : MlfeatureselectionNode) -> MlfeatureselectionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_node_copy(s : MlfeatureselectionNode) -> MlfeatureselectionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_node_fill(s : MlfeatureselectionNode, v : Double) -> MlfeatureselectionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_node_min(s : MlfeatureselectionNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_node_max(s : MlfeatureselectionNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_node_to_string(s : MlfeatureselectionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_edge_make(size : Int) -> MlfeatureselectionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_edge_len(s : MlfeatureselectionEdge) -> Int { s.size }

pub fn ml_feature_selection_edge_get(s : MlfeatureselectionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_edge_set(s : MlfeatureselectionEdge, i : Int, v : Double) -> MlfeatureselectionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_edge_sum(s : MlfeatureselectionEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_edge_mean(s : MlfeatureselectionEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_edge_scale(s : MlfeatureselectionEdge, f : Double) -> MlfeatureselectionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_edge_add(a : MlfeatureselectionEdge, b : MlfeatureselectionEdge) -> MlfeatureselectionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_edge_copy(s : MlfeatureselectionEdge) -> MlfeatureselectionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_edge_fill(s : MlfeatureselectionEdge, v : Double) -> MlfeatureselectionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_edge_min(s : MlfeatureselectionEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_edge_max(s : MlfeatureselectionEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_edge_to_string(s : MlfeatureselectionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_path_make(size : Int) -> MlfeatureselectionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_path_len(s : MlfeatureselectionPath) -> Int { s.size }

pub fn ml_feature_selection_path_get(s : MlfeatureselectionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_path_set(s : MlfeatureselectionPath, i : Int, v : Double) -> MlfeatureselectionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_path_sum(s : MlfeatureselectionPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_path_mean(s : MlfeatureselectionPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_path_scale(s : MlfeatureselectionPath, f : Double) -> MlfeatureselectionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_path_add(a : MlfeatureselectionPath, b : MlfeatureselectionPath) -> MlfeatureselectionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_path_copy(s : MlfeatureselectionPath) -> MlfeatureselectionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_path_fill(s : MlfeatureselectionPath, v : Double) -> MlfeatureselectionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_path_min(s : MlfeatureselectionPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_path_max(s : MlfeatureselectionPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_path_to_string(s : MlfeatureselectionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_cluster_make(size : Int) -> MlfeatureselectionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_cluster_len(s : MlfeatureselectionCluster) -> Int { s.size }

pub fn ml_feature_selection_cluster_get(s : MlfeatureselectionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_cluster_set(s : MlfeatureselectionCluster, i : Int, v : Double) -> MlfeatureselectionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_cluster_sum(s : MlfeatureselectionCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_cluster_mean(s : MlfeatureselectionCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_cluster_scale(s : MlfeatureselectionCluster, f : Double) -> MlfeatureselectionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_cluster_add(a : MlfeatureselectionCluster, b : MlfeatureselectionCluster) -> MlfeatureselectionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_cluster_copy(s : MlfeatureselectionCluster) -> MlfeatureselectionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_cluster_fill(s : MlfeatureselectionCluster, v : Double) -> MlfeatureselectionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_cluster_min(s : MlfeatureselectionCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_cluster_max(s : MlfeatureselectionCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_cluster_to_string(s : MlfeatureselectionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_model_make(size : Int) -> MlfeatureselectionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_model_len(s : MlfeatureselectionModel) -> Int { s.size }

pub fn ml_feature_selection_model_get(s : MlfeatureselectionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_model_set(s : MlfeatureselectionModel, i : Int, v : Double) -> MlfeatureselectionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_model_sum(s : MlfeatureselectionModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_model_mean(s : MlfeatureselectionModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_model_scale(s : MlfeatureselectionModel, f : Double) -> MlfeatureselectionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_model_add(a : MlfeatureselectionModel, b : MlfeatureselectionModel) -> MlfeatureselectionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_model_copy(s : MlfeatureselectionModel) -> MlfeatureselectionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_model_fill(s : MlfeatureselectionModel, v : Double) -> MlfeatureselectionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_model_min(s : MlfeatureselectionModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_model_max(s : MlfeatureselectionModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_model_to_string(s : MlfeatureselectionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_layer_make(size : Int) -> MlfeatureselectionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_layer_len(s : MlfeatureselectionLayer) -> Int { s.size }

pub fn ml_feature_selection_layer_get(s : MlfeatureselectionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_layer_set(s : MlfeatureselectionLayer, i : Int, v : Double) -> MlfeatureselectionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_layer_sum(s : MlfeatureselectionLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_layer_mean(s : MlfeatureselectionLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_layer_scale(s : MlfeatureselectionLayer, f : Double) -> MlfeatureselectionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_layer_add(a : MlfeatureselectionLayer, b : MlfeatureselectionLayer) -> MlfeatureselectionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_layer_copy(s : MlfeatureselectionLayer) -> MlfeatureselectionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_layer_fill(s : MlfeatureselectionLayer, v : Double) -> MlfeatureselectionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_layer_min(s : MlfeatureselectionLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_layer_max(s : MlfeatureselectionLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_layer_to_string(s : MlfeatureselectionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_buffer_make(size : Int) -> MlfeatureselectionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_buffer_len(s : MlfeatureselectionBuffer) -> Int { s.size }

pub fn ml_feature_selection_buffer_get(s : MlfeatureselectionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_buffer_set(s : MlfeatureselectionBuffer, i : Int, v : Double) -> MlfeatureselectionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_buffer_sum(s : MlfeatureselectionBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_buffer_mean(s : MlfeatureselectionBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_buffer_scale(s : MlfeatureselectionBuffer, f : Double) -> MlfeatureselectionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_buffer_add(a : MlfeatureselectionBuffer, b : MlfeatureselectionBuffer) -> MlfeatureselectionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_buffer_copy(s : MlfeatureselectionBuffer) -> MlfeatureselectionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_buffer_fill(s : MlfeatureselectionBuffer, v : Double) -> MlfeatureselectionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_buffer_min(s : MlfeatureselectionBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_buffer_max(s : MlfeatureselectionBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_buffer_to_string(s : MlfeatureselectionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_cursor_make(size : Int) -> MlfeatureselectionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_cursor_len(s : MlfeatureselectionCursor) -> Int { s.size }

pub fn ml_feature_selection_cursor_get(s : MlfeatureselectionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_cursor_set(s : MlfeatureselectionCursor, i : Int, v : Double) -> MlfeatureselectionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_cursor_sum(s : MlfeatureselectionCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_cursor_mean(s : MlfeatureselectionCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_cursor_scale(s : MlfeatureselectionCursor, f : Double) -> MlfeatureselectionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_cursor_add(a : MlfeatureselectionCursor, b : MlfeatureselectionCursor) -> MlfeatureselectionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_cursor_copy(s : MlfeatureselectionCursor) -> MlfeatureselectionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_cursor_fill(s : MlfeatureselectionCursor, v : Double) -> MlfeatureselectionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_cursor_min(s : MlfeatureselectionCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_cursor_max(s : MlfeatureselectionCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_cursor_to_string(s : MlfeatureselectionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_view_make(size : Int) -> MlfeatureselectionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_view_len(s : MlfeatureselectionView) -> Int { s.size }

pub fn ml_feature_selection_view_get(s : MlfeatureselectionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_view_set(s : MlfeatureselectionView, i : Int, v : Double) -> MlfeatureselectionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_view_sum(s : MlfeatureselectionView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_view_mean(s : MlfeatureselectionView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_view_scale(s : MlfeatureselectionView, f : Double) -> MlfeatureselectionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_view_add(a : MlfeatureselectionView, b : MlfeatureselectionView) -> MlfeatureselectionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_view_copy(s : MlfeatureselectionView) -> MlfeatureselectionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_view_fill(s : MlfeatureselectionView, v : Double) -> MlfeatureselectionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_view_min(s : MlfeatureselectionView) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_view_max(s : MlfeatureselectionView) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_view_to_string(s : MlfeatureselectionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_range_make(size : Int) -> MlfeatureselectionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_range_len(s : MlfeatureselectionRange) -> Int { s.size }

pub fn ml_feature_selection_range_get(s : MlfeatureselectionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_range_set(s : MlfeatureselectionRange, i : Int, v : Double) -> MlfeatureselectionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_range_sum(s : MlfeatureselectionRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_range_mean(s : MlfeatureselectionRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_range_scale(s : MlfeatureselectionRange, f : Double) -> MlfeatureselectionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_range_add(a : MlfeatureselectionRange, b : MlfeatureselectionRange) -> MlfeatureselectionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_range_copy(s : MlfeatureselectionRange) -> MlfeatureselectionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_range_fill(s : MlfeatureselectionRange, v : Double) -> MlfeatureselectionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_range_min(s : MlfeatureselectionRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_range_max(s : MlfeatureselectionRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_range_to_string(s : MlfeatureselectionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_slice_make(size : Int) -> MlfeatureselectionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_slice_len(s : MlfeatureselectionSlice) -> Int { s.size }

pub fn ml_feature_selection_slice_get(s : MlfeatureselectionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_slice_set(s : MlfeatureselectionSlice, i : Int, v : Double) -> MlfeatureselectionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_slice_sum(s : MlfeatureselectionSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_selection_slice_mean(s : MlfeatureselectionSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_selection_slice_scale(s : MlfeatureselectionSlice, f : Double) -> MlfeatureselectionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_slice_add(a : MlfeatureselectionSlice, b : MlfeatureselectionSlice) -> MlfeatureselectionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_selection_slice_copy(s : MlfeatureselectionSlice) -> MlfeatureselectionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_slice_fill(s : MlfeatureselectionSlice, v : Double) -> MlfeatureselectionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_selection_slice_min(s : MlfeatureselectionSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_selection_slice_max(s : MlfeatureselectionSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_selection_slice_to_string(s : MlfeatureselectionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

