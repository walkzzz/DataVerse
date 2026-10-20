///===
/// extcore/nlp_parse_dependency

pub(all) struct NlpparsedependencyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_dependency_make_point(x : Double, y : Double) -> NlpparsedependencyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_dependency_make_point3(x : Double, y : Double, z : Double) -> NlpparsedependencyPoint {
  { x, y, z, label: 0 }
}

pub fn NlpparsedependencyPoint::x(self : NlpparsedependencyPoint) -> Double { self.x }

pub fn NlpparsedependencyPoint::y(self : NlpparsedependencyPoint) -> Double { self.y }

pub fn NlpparsedependencyPoint::z(self : NlpparsedependencyPoint) -> Double { self.z }

pub fn NlpparsedependencyPoint::label(self : NlpparsedependencyPoint) -> Int { self.label }

pub fn NlpparsedependencyPoint::dist(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpparsedependencyPoint::add(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpparsedependencyPoint::sub(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpparsedependencyPoint::scale(self : NlpparsedependencyPoint, s : Double) -> NlpparsedependencyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpparsedependencyPoint::dot(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpparsedependencyPoint::cross(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpparsedependencyPoint::norm(self : NlpparsedependencyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpparsedependencyPoint::normalize(self : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsedependencyPoint::negate(self : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpparsedependencyPoint::mid(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpparsedependencyPoint::lerp(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint, t : Double) -> NlpparsedependencyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpparsedependencyPoint::to_string(self : NlpparsedependencyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpparsedependencySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_dependency_make_series(vals : Array[Double], name : String) -> NlpparsedependencySeries {
  { vals, name, meta: 0 }
}

pub fn NlpparsedependencySeries::len(self : NlpparsedependencySeries) -> Int { self.vals.length() }

pub fn NlpparsedependencySeries::sum(self : NlpparsedependencySeries) -> Double { @_common.sum(self.vals) }

pub fn NlpparsedependencySeries::mean(self : NlpparsedependencySeries) -> Double { @_common.mean(self.vals) }

pub fn NlpparsedependencySeries::min(self : NlpparsedependencySeries) -> Double { @_common.min(self.vals) }

pub fn NlpparsedependencySeries::max(self : NlpparsedependencySeries) -> Double { @_common.max(self.vals) }

pub fn NlpparsedependencySeries::range(self : NlpparsedependencySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpparsedependencySeries::variance(self : NlpparsedependencySeries) -> Double { @_common.variance(self.vals) }

pub fn NlpparsedependencySeries::std(self : NlpparsedependencySeries) -> Double { @_common.std(self.vals) }

pub fn NlpparsedependencySeries::median(self : NlpparsedependencySeries) -> Double { @_common.median(self.vals) }

pub fn NlpparsedependencySeries::scale(self : NlpparsedependencySeries, f : Double) -> NlpparsedependencySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpparsedependencySeries::add(self : NlpparsedependencySeries, other : NlpparsedependencySeries) -> NlpparsedependencySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpparsedependencySeries::sub(self : NlpparsedependencySeries, other : NlpparsedependencySeries) -> NlpparsedependencySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpparsedependencySeries::normalize(self : NlpparsedependencySeries) -> NlpparsedependencySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpparsedependencySeries::cumsum(self : NlpparsedependencySeries) -> NlpparsedependencySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpparsedependencySeries::to_string(self : NlpparsedependencySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsedependencyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_dependency_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsedependencyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_dependency_matrix_identity(n : Int) -> NlpparsedependencyMatrix {
  let m = nlp_parse_dependency_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpparsedependencyMatrix::get(self : NlpparsedependencyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpparsedependencyMatrix::transpose(self : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  let result = nlp_parse_dependency_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpparsedependencyMatrix::add(self : NlpparsedependencyMatrix, other : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_parse_dependency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpparsedependencyMatrix::scale(self : NlpparsedependencyMatrix, s : Double) -> NlpparsedependencyMatrix {
  let result = nlp_parse_dependency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpparsedependencyMatrix::multiply(self : NlpparsedependencyMatrix, other : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  if self.cols != other.rows { return nlp_parse_dependency_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_parse_dependency_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpparsedependencyMatrix::trace(self : NlpparsedependencyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpparsedependencyMatrix::det(self : NlpparsedependencyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpparsedependencyMatrix::norm(self : NlpparsedependencyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpparsedependencyMatrix::to_string(self : NlpparsedependencyMatrix) -> String {
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

pub(all) struct NlpparsedependencyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_dependency_make_vector(comps : Array[Double]) -> NlpparsedependencyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_dependency_vector_zero(dim : Int) -> NlpparsedependencyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpparsedependencyVector::add(self : NlpparsedependencyVector, other : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsedependencyVector::sub(self : NlpparsedependencyVector, other : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsedependencyVector::scale(self : NlpparsedependencyVector, s : Double) -> NlpparsedependencyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpparsedependencyVector::dot(self : NlpparsedependencyVector, other : NlpparsedependencyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpparsedependencyVector::norm(self : NlpparsedependencyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpparsedependencyVector::normalize(self : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsedependencyVector::dist(self : NlpparsedependencyVector, other : NlpparsedependencyVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpparsedependencyVector::to_string(self : NlpparsedependencyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_dependency_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_dependency_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_dependency_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_dependency_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_dependency_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_dependency_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_dependency_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_dependency_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_dependency_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_dependency_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_dependency_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_dependency_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_dependency_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_dependency_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_dependency_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_dependency_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_dependency_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_dependency_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_dependency_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_dependency_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_dependency_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_dependency_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_dependency_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_dependency_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_dependency_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_dependency_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_dependency_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_dependency_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_dependency_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparsedependencyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_frame_make(size : Int) -> NlpparsedependencyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_frame_len(s : NlpparsedependencyFrame) -> Int { s.size }

pub fn nlp_parse_dependency_frame_get(s : NlpparsedependencyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_frame_set(s : NlpparsedependencyFrame, i : Int, v : Double) -> NlpparsedependencyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_frame_sum(s : NlpparsedependencyFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_frame_mean(s : NlpparsedependencyFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_frame_scale(s : NlpparsedependencyFrame, f : Double) -> NlpparsedependencyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_frame_add(a : NlpparsedependencyFrame, b : NlpparsedependencyFrame) -> NlpparsedependencyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_frame_copy(s : NlpparsedependencyFrame) -> NlpparsedependencyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_frame_fill(s : NlpparsedependencyFrame, v : Double) -> NlpparsedependencyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_frame_min(s : NlpparsedependencyFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_frame_max(s : NlpparsedependencyFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_frame_to_string(s : NlpparsedependencyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_table_make(size : Int) -> NlpparsedependencyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_table_len(s : NlpparsedependencyTable) -> Int { s.size }

pub fn nlp_parse_dependency_table_get(s : NlpparsedependencyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_table_set(s : NlpparsedependencyTable, i : Int, v : Double) -> NlpparsedependencyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_table_sum(s : NlpparsedependencyTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_table_mean(s : NlpparsedependencyTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_table_scale(s : NlpparsedependencyTable, f : Double) -> NlpparsedependencyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_table_add(a : NlpparsedependencyTable, b : NlpparsedependencyTable) -> NlpparsedependencyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_table_copy(s : NlpparsedependencyTable) -> NlpparsedependencyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_table_fill(s : NlpparsedependencyTable, v : Double) -> NlpparsedependencyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_table_min(s : NlpparsedependencyTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_table_max(s : NlpparsedependencyTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_table_to_string(s : NlpparsedependencyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_graphn_make(size : Int) -> NlpparsedependencyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_graphn_len(s : NlpparsedependencyGraphN) -> Int { s.size }

pub fn nlp_parse_dependency_graphn_get(s : NlpparsedependencyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_graphn_set(s : NlpparsedependencyGraphN, i : Int, v : Double) -> NlpparsedependencyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_graphn_sum(s : NlpparsedependencyGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_graphn_mean(s : NlpparsedependencyGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_graphn_scale(s : NlpparsedependencyGraphN, f : Double) -> NlpparsedependencyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_graphn_add(a : NlpparsedependencyGraphN, b : NlpparsedependencyGraphN) -> NlpparsedependencyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_graphn_copy(s : NlpparsedependencyGraphN) -> NlpparsedependencyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_graphn_fill(s : NlpparsedependencyGraphN, v : Double) -> NlpparsedependencyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_graphn_min(s : NlpparsedependencyGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_graphn_max(s : NlpparsedependencyGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_graphn_to_string(s : NlpparsedependencyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_node_make(size : Int) -> NlpparsedependencyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_node_len(s : NlpparsedependencyNode) -> Int { s.size }

pub fn nlp_parse_dependency_node_get(s : NlpparsedependencyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_node_set(s : NlpparsedependencyNode, i : Int, v : Double) -> NlpparsedependencyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_node_sum(s : NlpparsedependencyNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_node_mean(s : NlpparsedependencyNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_node_scale(s : NlpparsedependencyNode, f : Double) -> NlpparsedependencyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_node_add(a : NlpparsedependencyNode, b : NlpparsedependencyNode) -> NlpparsedependencyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_node_copy(s : NlpparsedependencyNode) -> NlpparsedependencyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_node_fill(s : NlpparsedependencyNode, v : Double) -> NlpparsedependencyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_node_min(s : NlpparsedependencyNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_node_max(s : NlpparsedependencyNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_node_to_string(s : NlpparsedependencyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_edge_make(size : Int) -> NlpparsedependencyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_edge_len(s : NlpparsedependencyEdge) -> Int { s.size }

pub fn nlp_parse_dependency_edge_get(s : NlpparsedependencyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_edge_set(s : NlpparsedependencyEdge, i : Int, v : Double) -> NlpparsedependencyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_edge_sum(s : NlpparsedependencyEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_edge_mean(s : NlpparsedependencyEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_edge_scale(s : NlpparsedependencyEdge, f : Double) -> NlpparsedependencyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_edge_add(a : NlpparsedependencyEdge, b : NlpparsedependencyEdge) -> NlpparsedependencyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_edge_copy(s : NlpparsedependencyEdge) -> NlpparsedependencyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_edge_fill(s : NlpparsedependencyEdge, v : Double) -> NlpparsedependencyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_edge_min(s : NlpparsedependencyEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_edge_max(s : NlpparsedependencyEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_edge_to_string(s : NlpparsedependencyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_path_make(size : Int) -> NlpparsedependencyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_path_len(s : NlpparsedependencyPath) -> Int { s.size }

pub fn nlp_parse_dependency_path_get(s : NlpparsedependencyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_path_set(s : NlpparsedependencyPath, i : Int, v : Double) -> NlpparsedependencyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_path_sum(s : NlpparsedependencyPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_path_mean(s : NlpparsedependencyPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_path_scale(s : NlpparsedependencyPath, f : Double) -> NlpparsedependencyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_path_add(a : NlpparsedependencyPath, b : NlpparsedependencyPath) -> NlpparsedependencyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_path_copy(s : NlpparsedependencyPath) -> NlpparsedependencyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_path_fill(s : NlpparsedependencyPath, v : Double) -> NlpparsedependencyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_path_min(s : NlpparsedependencyPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_path_max(s : NlpparsedependencyPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_path_to_string(s : NlpparsedependencyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_cluster_make(size : Int) -> NlpparsedependencyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_cluster_len(s : NlpparsedependencyCluster) -> Int { s.size }

pub fn nlp_parse_dependency_cluster_get(s : NlpparsedependencyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_cluster_set(s : NlpparsedependencyCluster, i : Int, v : Double) -> NlpparsedependencyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_cluster_sum(s : NlpparsedependencyCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_cluster_mean(s : NlpparsedependencyCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_cluster_scale(s : NlpparsedependencyCluster, f : Double) -> NlpparsedependencyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_cluster_add(a : NlpparsedependencyCluster, b : NlpparsedependencyCluster) -> NlpparsedependencyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_cluster_copy(s : NlpparsedependencyCluster) -> NlpparsedependencyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_cluster_fill(s : NlpparsedependencyCluster, v : Double) -> NlpparsedependencyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_cluster_min(s : NlpparsedependencyCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_cluster_max(s : NlpparsedependencyCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_cluster_to_string(s : NlpparsedependencyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_model_make(size : Int) -> NlpparsedependencyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_model_len(s : NlpparsedependencyModel) -> Int { s.size }

pub fn nlp_parse_dependency_model_get(s : NlpparsedependencyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_model_set(s : NlpparsedependencyModel, i : Int, v : Double) -> NlpparsedependencyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_model_sum(s : NlpparsedependencyModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_model_mean(s : NlpparsedependencyModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_model_scale(s : NlpparsedependencyModel, f : Double) -> NlpparsedependencyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_model_add(a : NlpparsedependencyModel, b : NlpparsedependencyModel) -> NlpparsedependencyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_model_copy(s : NlpparsedependencyModel) -> NlpparsedependencyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_model_fill(s : NlpparsedependencyModel, v : Double) -> NlpparsedependencyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_model_min(s : NlpparsedependencyModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_model_max(s : NlpparsedependencyModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_model_to_string(s : NlpparsedependencyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_layer_make(size : Int) -> NlpparsedependencyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_layer_len(s : NlpparsedependencyLayer) -> Int { s.size }

pub fn nlp_parse_dependency_layer_get(s : NlpparsedependencyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_layer_set(s : NlpparsedependencyLayer, i : Int, v : Double) -> NlpparsedependencyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_layer_sum(s : NlpparsedependencyLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_layer_mean(s : NlpparsedependencyLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_layer_scale(s : NlpparsedependencyLayer, f : Double) -> NlpparsedependencyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_layer_add(a : NlpparsedependencyLayer, b : NlpparsedependencyLayer) -> NlpparsedependencyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_layer_copy(s : NlpparsedependencyLayer) -> NlpparsedependencyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_layer_fill(s : NlpparsedependencyLayer, v : Double) -> NlpparsedependencyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_layer_min(s : NlpparsedependencyLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_layer_max(s : NlpparsedependencyLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_layer_to_string(s : NlpparsedependencyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_buffer_make(size : Int) -> NlpparsedependencyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_buffer_len(s : NlpparsedependencyBuffer) -> Int { s.size }

pub fn nlp_parse_dependency_buffer_get(s : NlpparsedependencyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_buffer_set(s : NlpparsedependencyBuffer, i : Int, v : Double) -> NlpparsedependencyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_buffer_sum(s : NlpparsedependencyBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_buffer_mean(s : NlpparsedependencyBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_buffer_scale(s : NlpparsedependencyBuffer, f : Double) -> NlpparsedependencyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_buffer_add(a : NlpparsedependencyBuffer, b : NlpparsedependencyBuffer) -> NlpparsedependencyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_buffer_copy(s : NlpparsedependencyBuffer) -> NlpparsedependencyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_buffer_fill(s : NlpparsedependencyBuffer, v : Double) -> NlpparsedependencyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_buffer_min(s : NlpparsedependencyBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_buffer_max(s : NlpparsedependencyBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_buffer_to_string(s : NlpparsedependencyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_cursor_make(size : Int) -> NlpparsedependencyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_cursor_len(s : NlpparsedependencyCursor) -> Int { s.size }

pub fn nlp_parse_dependency_cursor_get(s : NlpparsedependencyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_cursor_set(s : NlpparsedependencyCursor, i : Int, v : Double) -> NlpparsedependencyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_cursor_sum(s : NlpparsedependencyCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_cursor_mean(s : NlpparsedependencyCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_cursor_scale(s : NlpparsedependencyCursor, f : Double) -> NlpparsedependencyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_cursor_add(a : NlpparsedependencyCursor, b : NlpparsedependencyCursor) -> NlpparsedependencyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_cursor_copy(s : NlpparsedependencyCursor) -> NlpparsedependencyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_cursor_fill(s : NlpparsedependencyCursor, v : Double) -> NlpparsedependencyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_cursor_min(s : NlpparsedependencyCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_cursor_max(s : NlpparsedependencyCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_cursor_to_string(s : NlpparsedependencyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_view_make(size : Int) -> NlpparsedependencyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_view_len(s : NlpparsedependencyView) -> Int { s.size }

pub fn nlp_parse_dependency_view_get(s : NlpparsedependencyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_view_set(s : NlpparsedependencyView, i : Int, v : Double) -> NlpparsedependencyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_view_sum(s : NlpparsedependencyView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_view_mean(s : NlpparsedependencyView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_view_scale(s : NlpparsedependencyView, f : Double) -> NlpparsedependencyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_view_add(a : NlpparsedependencyView, b : NlpparsedependencyView) -> NlpparsedependencyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_view_copy(s : NlpparsedependencyView) -> NlpparsedependencyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_view_fill(s : NlpparsedependencyView, v : Double) -> NlpparsedependencyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_view_min(s : NlpparsedependencyView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_view_max(s : NlpparsedependencyView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_view_to_string(s : NlpparsedependencyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_range_make(size : Int) -> NlpparsedependencyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_range_len(s : NlpparsedependencyRange) -> Int { s.size }

pub fn nlp_parse_dependency_range_get(s : NlpparsedependencyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_range_set(s : NlpparsedependencyRange, i : Int, v : Double) -> NlpparsedependencyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_range_sum(s : NlpparsedependencyRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_range_mean(s : NlpparsedependencyRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_range_scale(s : NlpparsedependencyRange, f : Double) -> NlpparsedependencyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_range_add(a : NlpparsedependencyRange, b : NlpparsedependencyRange) -> NlpparsedependencyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_range_copy(s : NlpparsedependencyRange) -> NlpparsedependencyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_range_fill(s : NlpparsedependencyRange, v : Double) -> NlpparsedependencyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_range_min(s : NlpparsedependencyRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_range_max(s : NlpparsedependencyRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_range_to_string(s : NlpparsedependencyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_slice_make(size : Int) -> NlpparsedependencySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_slice_len(s : NlpparsedependencySlice) -> Int { s.size }

pub fn nlp_parse_dependency_slice_get(s : NlpparsedependencySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_slice_set(s : NlpparsedependencySlice, i : Int, v : Double) -> NlpparsedependencySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_slice_sum(s : NlpparsedependencySlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_slice_mean(s : NlpparsedependencySlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_slice_scale(s : NlpparsedependencySlice, f : Double) -> NlpparsedependencySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_slice_add(a : NlpparsedependencySlice, b : NlpparsedependencySlice) -> NlpparsedependencySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_dependency_slice_copy(s : NlpparsedependencySlice) -> NlpparsedependencySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_slice_fill(s : NlpparsedependencySlice, v : Double) -> NlpparsedependencySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_dependency_slice_min(s : NlpparsedependencySlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_slice_max(s : NlpparsedependencySlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_slice_to_string(s : NlpparsedependencySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

