///===
/// extcore/nlp_parse_constituency

pub(all) struct NlpparseconstituencyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_constituency_make_point(x : Double, y : Double) -> NlpparseconstituencyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_constituency_make_point3(x : Double, y : Double, z : Double) -> NlpparseconstituencyPoint {
  { x, y, z, label: 0 }
}

pub fn NlpparseconstituencyPoint::x(self : NlpparseconstituencyPoint) -> Double { self.x }

pub fn NlpparseconstituencyPoint::y(self : NlpparseconstituencyPoint) -> Double { self.y }

pub fn NlpparseconstituencyPoint::z(self : NlpparseconstituencyPoint) -> Double { self.z }

pub fn NlpparseconstituencyPoint::label(self : NlpparseconstituencyPoint) -> Int { self.label }

pub fn NlpparseconstituencyPoint::dist(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpparseconstituencyPoint::add(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpparseconstituencyPoint::sub(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpparseconstituencyPoint::scale(self : NlpparseconstituencyPoint, s : Double) -> NlpparseconstituencyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpparseconstituencyPoint::dot(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpparseconstituencyPoint::cross(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpparseconstituencyPoint::norm(self : NlpparseconstituencyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpparseconstituencyPoint::normalize(self : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparseconstituencyPoint::negate(self : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpparseconstituencyPoint::mid(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpparseconstituencyPoint::lerp(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint, t : Double) -> NlpparseconstituencyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpparseconstituencyPoint::to_string(self : NlpparseconstituencyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpparseconstituencySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_constituency_make_series(vals : Array[Double], name : String) -> NlpparseconstituencySeries {
  { vals, name, meta: 0 }
}

pub fn NlpparseconstituencySeries::len(self : NlpparseconstituencySeries) -> Int { self.vals.length() }

pub fn NlpparseconstituencySeries::sum(self : NlpparseconstituencySeries) -> Double { @_common.sum(self.vals) }

pub fn NlpparseconstituencySeries::mean(self : NlpparseconstituencySeries) -> Double { @_common.mean(self.vals) }

pub fn NlpparseconstituencySeries::min(self : NlpparseconstituencySeries) -> Double { @_common.min(self.vals) }

pub fn NlpparseconstituencySeries::max(self : NlpparseconstituencySeries) -> Double { @_common.max(self.vals) }

pub fn NlpparseconstituencySeries::range(self : NlpparseconstituencySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpparseconstituencySeries::variance(self : NlpparseconstituencySeries) -> Double { @_common.variance(self.vals) }

pub fn NlpparseconstituencySeries::std(self : NlpparseconstituencySeries) -> Double { @_common.std(self.vals) }

pub fn NlpparseconstituencySeries::median(self : NlpparseconstituencySeries) -> Double { @_common.median(self.vals) }

pub fn NlpparseconstituencySeries::scale(self : NlpparseconstituencySeries, f : Double) -> NlpparseconstituencySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpparseconstituencySeries::add(self : NlpparseconstituencySeries, other : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpparseconstituencySeries::sub(self : NlpparseconstituencySeries, other : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpparseconstituencySeries::normalize(self : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpparseconstituencySeries::cumsum(self : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpparseconstituencySeries::to_string(self : NlpparseconstituencySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparseconstituencyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_constituency_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparseconstituencyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_constituency_matrix_identity(n : Int) -> NlpparseconstituencyMatrix {
  let m = nlp_parse_constituency_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpparseconstituencyMatrix::get(self : NlpparseconstituencyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpparseconstituencyMatrix::transpose(self : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  let result = nlp_parse_constituency_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpparseconstituencyMatrix::add(self : NlpparseconstituencyMatrix, other : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_parse_constituency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpparseconstituencyMatrix::scale(self : NlpparseconstituencyMatrix, s : Double) -> NlpparseconstituencyMatrix {
  let result = nlp_parse_constituency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpparseconstituencyMatrix::multiply(self : NlpparseconstituencyMatrix, other : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  if self.cols != other.rows { return nlp_parse_constituency_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_parse_constituency_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpparseconstituencyMatrix::trace(self : NlpparseconstituencyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpparseconstituencyMatrix::det(self : NlpparseconstituencyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpparseconstituencyMatrix::norm(self : NlpparseconstituencyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpparseconstituencyMatrix::to_string(self : NlpparseconstituencyMatrix) -> String {
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

pub(all) struct NlpparseconstituencyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_constituency_make_vector(comps : Array[Double]) -> NlpparseconstituencyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_constituency_vector_zero(dim : Int) -> NlpparseconstituencyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpparseconstituencyVector::add(self : NlpparseconstituencyVector, other : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparseconstituencyVector::sub(self : NlpparseconstituencyVector, other : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparseconstituencyVector::scale(self : NlpparseconstituencyVector, s : Double) -> NlpparseconstituencyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpparseconstituencyVector::dot(self : NlpparseconstituencyVector, other : NlpparseconstituencyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpparseconstituencyVector::norm(self : NlpparseconstituencyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpparseconstituencyVector::normalize(self : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparseconstituencyVector::dist(self : NlpparseconstituencyVector, other : NlpparseconstituencyVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpparseconstituencyVector::to_string(self : NlpparseconstituencyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_constituency_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_constituency_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_constituency_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_constituency_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_constituency_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_constituency_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_constituency_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_constituency_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_constituency_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_constituency_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_constituency_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_constituency_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_constituency_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_constituency_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_constituency_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_constituency_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_constituency_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_constituency_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_constituency_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_constituency_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_constituency_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_constituency_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_constituency_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_constituency_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_constituency_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_constituency_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_constituency_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_constituency_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_constituency_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparseconstituencyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_frame_make(size : Int) -> NlpparseconstituencyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_frame_len(s : NlpparseconstituencyFrame) -> Int { s.size }

pub fn nlp_parse_constituency_frame_get(s : NlpparseconstituencyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_frame_set(s : NlpparseconstituencyFrame, i : Int, v : Double) -> NlpparseconstituencyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_frame_sum(s : NlpparseconstituencyFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_frame_mean(s : NlpparseconstituencyFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_frame_scale(s : NlpparseconstituencyFrame, f : Double) -> NlpparseconstituencyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_frame_add(a : NlpparseconstituencyFrame, b : NlpparseconstituencyFrame) -> NlpparseconstituencyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_frame_copy(s : NlpparseconstituencyFrame) -> NlpparseconstituencyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_frame_fill(s : NlpparseconstituencyFrame, v : Double) -> NlpparseconstituencyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_frame_min(s : NlpparseconstituencyFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_frame_max(s : NlpparseconstituencyFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_frame_to_string(s : NlpparseconstituencyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_table_make(size : Int) -> NlpparseconstituencyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_table_len(s : NlpparseconstituencyTable) -> Int { s.size }

pub fn nlp_parse_constituency_table_get(s : NlpparseconstituencyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_table_set(s : NlpparseconstituencyTable, i : Int, v : Double) -> NlpparseconstituencyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_table_sum(s : NlpparseconstituencyTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_table_mean(s : NlpparseconstituencyTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_table_scale(s : NlpparseconstituencyTable, f : Double) -> NlpparseconstituencyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_table_add(a : NlpparseconstituencyTable, b : NlpparseconstituencyTable) -> NlpparseconstituencyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_table_copy(s : NlpparseconstituencyTable) -> NlpparseconstituencyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_table_fill(s : NlpparseconstituencyTable, v : Double) -> NlpparseconstituencyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_table_min(s : NlpparseconstituencyTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_table_max(s : NlpparseconstituencyTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_table_to_string(s : NlpparseconstituencyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_graphn_make(size : Int) -> NlpparseconstituencyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_graphn_len(s : NlpparseconstituencyGraphN) -> Int { s.size }

pub fn nlp_parse_constituency_graphn_get(s : NlpparseconstituencyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_graphn_set(s : NlpparseconstituencyGraphN, i : Int, v : Double) -> NlpparseconstituencyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_graphn_sum(s : NlpparseconstituencyGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_graphn_mean(s : NlpparseconstituencyGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_graphn_scale(s : NlpparseconstituencyGraphN, f : Double) -> NlpparseconstituencyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_graphn_add(a : NlpparseconstituencyGraphN, b : NlpparseconstituencyGraphN) -> NlpparseconstituencyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_graphn_copy(s : NlpparseconstituencyGraphN) -> NlpparseconstituencyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_graphn_fill(s : NlpparseconstituencyGraphN, v : Double) -> NlpparseconstituencyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_graphn_min(s : NlpparseconstituencyGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_graphn_max(s : NlpparseconstituencyGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_graphn_to_string(s : NlpparseconstituencyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_node_make(size : Int) -> NlpparseconstituencyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_node_len(s : NlpparseconstituencyNode) -> Int { s.size }

pub fn nlp_parse_constituency_node_get(s : NlpparseconstituencyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_node_set(s : NlpparseconstituencyNode, i : Int, v : Double) -> NlpparseconstituencyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_node_sum(s : NlpparseconstituencyNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_node_mean(s : NlpparseconstituencyNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_node_scale(s : NlpparseconstituencyNode, f : Double) -> NlpparseconstituencyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_node_add(a : NlpparseconstituencyNode, b : NlpparseconstituencyNode) -> NlpparseconstituencyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_node_copy(s : NlpparseconstituencyNode) -> NlpparseconstituencyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_node_fill(s : NlpparseconstituencyNode, v : Double) -> NlpparseconstituencyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_node_min(s : NlpparseconstituencyNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_node_max(s : NlpparseconstituencyNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_node_to_string(s : NlpparseconstituencyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_edge_make(size : Int) -> NlpparseconstituencyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_edge_len(s : NlpparseconstituencyEdge) -> Int { s.size }

pub fn nlp_parse_constituency_edge_get(s : NlpparseconstituencyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_edge_set(s : NlpparseconstituencyEdge, i : Int, v : Double) -> NlpparseconstituencyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_edge_sum(s : NlpparseconstituencyEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_edge_mean(s : NlpparseconstituencyEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_edge_scale(s : NlpparseconstituencyEdge, f : Double) -> NlpparseconstituencyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_edge_add(a : NlpparseconstituencyEdge, b : NlpparseconstituencyEdge) -> NlpparseconstituencyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_edge_copy(s : NlpparseconstituencyEdge) -> NlpparseconstituencyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_edge_fill(s : NlpparseconstituencyEdge, v : Double) -> NlpparseconstituencyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_edge_min(s : NlpparseconstituencyEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_edge_max(s : NlpparseconstituencyEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_edge_to_string(s : NlpparseconstituencyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_path_make(size : Int) -> NlpparseconstituencyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_path_len(s : NlpparseconstituencyPath) -> Int { s.size }

pub fn nlp_parse_constituency_path_get(s : NlpparseconstituencyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_path_set(s : NlpparseconstituencyPath, i : Int, v : Double) -> NlpparseconstituencyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_path_sum(s : NlpparseconstituencyPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_path_mean(s : NlpparseconstituencyPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_path_scale(s : NlpparseconstituencyPath, f : Double) -> NlpparseconstituencyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_path_add(a : NlpparseconstituencyPath, b : NlpparseconstituencyPath) -> NlpparseconstituencyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_path_copy(s : NlpparseconstituencyPath) -> NlpparseconstituencyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_path_fill(s : NlpparseconstituencyPath, v : Double) -> NlpparseconstituencyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_path_min(s : NlpparseconstituencyPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_path_max(s : NlpparseconstituencyPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_path_to_string(s : NlpparseconstituencyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_cluster_make(size : Int) -> NlpparseconstituencyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_cluster_len(s : NlpparseconstituencyCluster) -> Int { s.size }

pub fn nlp_parse_constituency_cluster_get(s : NlpparseconstituencyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_cluster_set(s : NlpparseconstituencyCluster, i : Int, v : Double) -> NlpparseconstituencyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_cluster_sum(s : NlpparseconstituencyCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_cluster_mean(s : NlpparseconstituencyCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_cluster_scale(s : NlpparseconstituencyCluster, f : Double) -> NlpparseconstituencyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_cluster_add(a : NlpparseconstituencyCluster, b : NlpparseconstituencyCluster) -> NlpparseconstituencyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_cluster_copy(s : NlpparseconstituencyCluster) -> NlpparseconstituencyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_cluster_fill(s : NlpparseconstituencyCluster, v : Double) -> NlpparseconstituencyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_cluster_min(s : NlpparseconstituencyCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_cluster_max(s : NlpparseconstituencyCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_cluster_to_string(s : NlpparseconstituencyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_model_make(size : Int) -> NlpparseconstituencyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_model_len(s : NlpparseconstituencyModel) -> Int { s.size }

pub fn nlp_parse_constituency_model_get(s : NlpparseconstituencyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_model_set(s : NlpparseconstituencyModel, i : Int, v : Double) -> NlpparseconstituencyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_model_sum(s : NlpparseconstituencyModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_model_mean(s : NlpparseconstituencyModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_model_scale(s : NlpparseconstituencyModel, f : Double) -> NlpparseconstituencyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_model_add(a : NlpparseconstituencyModel, b : NlpparseconstituencyModel) -> NlpparseconstituencyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_model_copy(s : NlpparseconstituencyModel) -> NlpparseconstituencyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_model_fill(s : NlpparseconstituencyModel, v : Double) -> NlpparseconstituencyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_model_min(s : NlpparseconstituencyModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_model_max(s : NlpparseconstituencyModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_model_to_string(s : NlpparseconstituencyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_layer_make(size : Int) -> NlpparseconstituencyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_layer_len(s : NlpparseconstituencyLayer) -> Int { s.size }

pub fn nlp_parse_constituency_layer_get(s : NlpparseconstituencyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_layer_set(s : NlpparseconstituencyLayer, i : Int, v : Double) -> NlpparseconstituencyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_layer_sum(s : NlpparseconstituencyLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_layer_mean(s : NlpparseconstituencyLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_layer_scale(s : NlpparseconstituencyLayer, f : Double) -> NlpparseconstituencyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_layer_add(a : NlpparseconstituencyLayer, b : NlpparseconstituencyLayer) -> NlpparseconstituencyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_layer_copy(s : NlpparseconstituencyLayer) -> NlpparseconstituencyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_layer_fill(s : NlpparseconstituencyLayer, v : Double) -> NlpparseconstituencyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_layer_min(s : NlpparseconstituencyLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_layer_max(s : NlpparseconstituencyLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_layer_to_string(s : NlpparseconstituencyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_buffer_make(size : Int) -> NlpparseconstituencyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_buffer_len(s : NlpparseconstituencyBuffer) -> Int { s.size }

pub fn nlp_parse_constituency_buffer_get(s : NlpparseconstituencyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_buffer_set(s : NlpparseconstituencyBuffer, i : Int, v : Double) -> NlpparseconstituencyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_buffer_sum(s : NlpparseconstituencyBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_buffer_mean(s : NlpparseconstituencyBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_buffer_scale(s : NlpparseconstituencyBuffer, f : Double) -> NlpparseconstituencyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_buffer_add(a : NlpparseconstituencyBuffer, b : NlpparseconstituencyBuffer) -> NlpparseconstituencyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_buffer_copy(s : NlpparseconstituencyBuffer) -> NlpparseconstituencyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_buffer_fill(s : NlpparseconstituencyBuffer, v : Double) -> NlpparseconstituencyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_buffer_min(s : NlpparseconstituencyBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_buffer_max(s : NlpparseconstituencyBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_buffer_to_string(s : NlpparseconstituencyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_cursor_make(size : Int) -> NlpparseconstituencyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_cursor_len(s : NlpparseconstituencyCursor) -> Int { s.size }

pub fn nlp_parse_constituency_cursor_get(s : NlpparseconstituencyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_cursor_set(s : NlpparseconstituencyCursor, i : Int, v : Double) -> NlpparseconstituencyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_cursor_sum(s : NlpparseconstituencyCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_cursor_mean(s : NlpparseconstituencyCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_cursor_scale(s : NlpparseconstituencyCursor, f : Double) -> NlpparseconstituencyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_cursor_add(a : NlpparseconstituencyCursor, b : NlpparseconstituencyCursor) -> NlpparseconstituencyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_cursor_copy(s : NlpparseconstituencyCursor) -> NlpparseconstituencyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_cursor_fill(s : NlpparseconstituencyCursor, v : Double) -> NlpparseconstituencyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_cursor_min(s : NlpparseconstituencyCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_cursor_max(s : NlpparseconstituencyCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_cursor_to_string(s : NlpparseconstituencyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_view_make(size : Int) -> NlpparseconstituencyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_view_len(s : NlpparseconstituencyView) -> Int { s.size }

pub fn nlp_parse_constituency_view_get(s : NlpparseconstituencyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_view_set(s : NlpparseconstituencyView, i : Int, v : Double) -> NlpparseconstituencyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_view_sum(s : NlpparseconstituencyView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_view_mean(s : NlpparseconstituencyView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_view_scale(s : NlpparseconstituencyView, f : Double) -> NlpparseconstituencyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_view_add(a : NlpparseconstituencyView, b : NlpparseconstituencyView) -> NlpparseconstituencyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_view_copy(s : NlpparseconstituencyView) -> NlpparseconstituencyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_view_fill(s : NlpparseconstituencyView, v : Double) -> NlpparseconstituencyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_view_min(s : NlpparseconstituencyView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_view_max(s : NlpparseconstituencyView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_view_to_string(s : NlpparseconstituencyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_range_make(size : Int) -> NlpparseconstituencyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_range_len(s : NlpparseconstituencyRange) -> Int { s.size }

pub fn nlp_parse_constituency_range_get(s : NlpparseconstituencyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_range_set(s : NlpparseconstituencyRange, i : Int, v : Double) -> NlpparseconstituencyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_range_sum(s : NlpparseconstituencyRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_range_mean(s : NlpparseconstituencyRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_range_scale(s : NlpparseconstituencyRange, f : Double) -> NlpparseconstituencyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_range_add(a : NlpparseconstituencyRange, b : NlpparseconstituencyRange) -> NlpparseconstituencyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_range_copy(s : NlpparseconstituencyRange) -> NlpparseconstituencyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_range_fill(s : NlpparseconstituencyRange, v : Double) -> NlpparseconstituencyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_range_min(s : NlpparseconstituencyRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_range_max(s : NlpparseconstituencyRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_range_to_string(s : NlpparseconstituencyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_slice_make(size : Int) -> NlpparseconstituencySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_slice_len(s : NlpparseconstituencySlice) -> Int { s.size }

pub fn nlp_parse_constituency_slice_get(s : NlpparseconstituencySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_slice_set(s : NlpparseconstituencySlice, i : Int, v : Double) -> NlpparseconstituencySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_slice_sum(s : NlpparseconstituencySlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_slice_mean(s : NlpparseconstituencySlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_slice_scale(s : NlpparseconstituencySlice, f : Double) -> NlpparseconstituencySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_slice_add(a : NlpparseconstituencySlice, b : NlpparseconstituencySlice) -> NlpparseconstituencySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_constituency_slice_copy(s : NlpparseconstituencySlice) -> NlpparseconstituencySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_slice_fill(s : NlpparseconstituencySlice, v : Double) -> NlpparseconstituencySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_constituency_slice_min(s : NlpparseconstituencySlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_slice_max(s : NlpparseconstituencySlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_slice_to_string(s : NlpparseconstituencySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

