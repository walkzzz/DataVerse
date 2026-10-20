///===
/// extcore/nlp_parse_cky

pub(all) struct NlpparseckyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_cky_make_point(x : Double, y : Double) -> NlpparseckyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_cky_make_point3(x : Double, y : Double, z : Double) -> NlpparseckyPoint {
  { x, y, z, label: 0 }
}

pub fn NlpparseckyPoint::x(self : NlpparseckyPoint) -> Double { self.x }

pub fn NlpparseckyPoint::y(self : NlpparseckyPoint) -> Double { self.y }

pub fn NlpparseckyPoint::z(self : NlpparseckyPoint) -> Double { self.z }

pub fn NlpparseckyPoint::label(self : NlpparseckyPoint) -> Int { self.label }

pub fn NlpparseckyPoint::dist(self : NlpparseckyPoint, other : NlpparseckyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpparseckyPoint::add(self : NlpparseckyPoint, other : NlpparseckyPoint) -> NlpparseckyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpparseckyPoint::sub(self : NlpparseckyPoint, other : NlpparseckyPoint) -> NlpparseckyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpparseckyPoint::scale(self : NlpparseckyPoint, s : Double) -> NlpparseckyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpparseckyPoint::dot(self : NlpparseckyPoint, other : NlpparseckyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpparseckyPoint::cross(self : NlpparseckyPoint, other : NlpparseckyPoint) -> NlpparseckyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpparseckyPoint::norm(self : NlpparseckyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpparseckyPoint::normalize(self : NlpparseckyPoint) -> NlpparseckyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparseckyPoint::negate(self : NlpparseckyPoint) -> NlpparseckyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpparseckyPoint::mid(self : NlpparseckyPoint, other : NlpparseckyPoint) -> NlpparseckyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpparseckyPoint::lerp(self : NlpparseckyPoint, other : NlpparseckyPoint, t : Double) -> NlpparseckyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpparseckyPoint::to_string(self : NlpparseckyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpparseckySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_cky_make_series(vals : Array[Double], name : String) -> NlpparseckySeries {
  { vals, name, meta: 0 }
}

pub fn NlpparseckySeries::len(self : NlpparseckySeries) -> Int { self.vals.length() }

pub fn NlpparseckySeries::sum(self : NlpparseckySeries) -> Double { @_common.sum(self.vals) }

pub fn NlpparseckySeries::mean(self : NlpparseckySeries) -> Double { @_common.mean(self.vals) }

pub fn NlpparseckySeries::min(self : NlpparseckySeries) -> Double { @_common.min(self.vals) }

pub fn NlpparseckySeries::max(self : NlpparseckySeries) -> Double { @_common.max(self.vals) }

pub fn NlpparseckySeries::range(self : NlpparseckySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpparseckySeries::variance(self : NlpparseckySeries) -> Double { @_common.variance(self.vals) }

pub fn NlpparseckySeries::std(self : NlpparseckySeries) -> Double { @_common.std(self.vals) }

pub fn NlpparseckySeries::median(self : NlpparseckySeries) -> Double { @_common.median(self.vals) }

pub fn NlpparseckySeries::scale(self : NlpparseckySeries, f : Double) -> NlpparseckySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpparseckySeries::add(self : NlpparseckySeries, other : NlpparseckySeries) -> NlpparseckySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpparseckySeries::sub(self : NlpparseckySeries, other : NlpparseckySeries) -> NlpparseckySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpparseckySeries::normalize(self : NlpparseckySeries) -> NlpparseckySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpparseckySeries::cumsum(self : NlpparseckySeries) -> NlpparseckySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpparseckySeries::to_string(self : NlpparseckySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparseckyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_cky_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparseckyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_cky_matrix_identity(n : Int) -> NlpparseckyMatrix {
  let m = nlp_parse_cky_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpparseckyMatrix::get(self : NlpparseckyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpparseckyMatrix::transpose(self : NlpparseckyMatrix) -> NlpparseckyMatrix {
  let result = nlp_parse_cky_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpparseckyMatrix::add(self : NlpparseckyMatrix, other : NlpparseckyMatrix) -> NlpparseckyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_parse_cky_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpparseckyMatrix::scale(self : NlpparseckyMatrix, s : Double) -> NlpparseckyMatrix {
  let result = nlp_parse_cky_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpparseckyMatrix::multiply(self : NlpparseckyMatrix, other : NlpparseckyMatrix) -> NlpparseckyMatrix {
  if self.cols != other.rows { return nlp_parse_cky_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_parse_cky_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpparseckyMatrix::trace(self : NlpparseckyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpparseckyMatrix::det(self : NlpparseckyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpparseckyMatrix::norm(self : NlpparseckyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpparseckyMatrix::to_string(self : NlpparseckyMatrix) -> String {
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

pub(all) struct NlpparseckyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_cky_make_vector(comps : Array[Double]) -> NlpparseckyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_cky_vector_zero(dim : Int) -> NlpparseckyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpparseckyVector::add(self : NlpparseckyVector, other : NlpparseckyVector) -> NlpparseckyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparseckyVector::sub(self : NlpparseckyVector, other : NlpparseckyVector) -> NlpparseckyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparseckyVector::scale(self : NlpparseckyVector, s : Double) -> NlpparseckyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpparseckyVector::dot(self : NlpparseckyVector, other : NlpparseckyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpparseckyVector::norm(self : NlpparseckyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpparseckyVector::normalize(self : NlpparseckyVector) -> NlpparseckyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparseckyVector::dist(self : NlpparseckyVector, other : NlpparseckyVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpparseckyVector::to_string(self : NlpparseckyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_cky_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_cky_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_cky_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_cky_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_cky_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_cky_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_cky_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_cky_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_cky_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_cky_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_cky_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_cky_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_cky_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_cky_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_cky_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_cky_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_cky_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_cky_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_cky_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_cky_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_cky_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_cky_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_cky_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_cky_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_cky_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_cky_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_cky_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_cky_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_cky_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparseckyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_frame_make(size : Int) -> NlpparseckyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_frame_len(s : NlpparseckyFrame) -> Int { s.size }

pub fn nlp_parse_cky_frame_get(s : NlpparseckyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_frame_set(s : NlpparseckyFrame, i : Int, v : Double) -> NlpparseckyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_frame_sum(s : NlpparseckyFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_frame_mean(s : NlpparseckyFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_frame_scale(s : NlpparseckyFrame, f : Double) -> NlpparseckyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_frame_add(a : NlpparseckyFrame, b : NlpparseckyFrame) -> NlpparseckyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_frame_copy(s : NlpparseckyFrame) -> NlpparseckyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_frame_fill(s : NlpparseckyFrame, v : Double) -> NlpparseckyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_frame_min(s : NlpparseckyFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_frame_max(s : NlpparseckyFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_frame_to_string(s : NlpparseckyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_table_make(size : Int) -> NlpparseckyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_table_len(s : NlpparseckyTable) -> Int { s.size }

pub fn nlp_parse_cky_table_get(s : NlpparseckyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_table_set(s : NlpparseckyTable, i : Int, v : Double) -> NlpparseckyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_table_sum(s : NlpparseckyTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_table_mean(s : NlpparseckyTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_table_scale(s : NlpparseckyTable, f : Double) -> NlpparseckyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_table_add(a : NlpparseckyTable, b : NlpparseckyTable) -> NlpparseckyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_table_copy(s : NlpparseckyTable) -> NlpparseckyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_table_fill(s : NlpparseckyTable, v : Double) -> NlpparseckyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_table_min(s : NlpparseckyTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_table_max(s : NlpparseckyTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_table_to_string(s : NlpparseckyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_graphn_make(size : Int) -> NlpparseckyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_graphn_len(s : NlpparseckyGraphN) -> Int { s.size }

pub fn nlp_parse_cky_graphn_get(s : NlpparseckyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_graphn_set(s : NlpparseckyGraphN, i : Int, v : Double) -> NlpparseckyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_graphn_sum(s : NlpparseckyGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_graphn_mean(s : NlpparseckyGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_graphn_scale(s : NlpparseckyGraphN, f : Double) -> NlpparseckyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_graphn_add(a : NlpparseckyGraphN, b : NlpparseckyGraphN) -> NlpparseckyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_graphn_copy(s : NlpparseckyGraphN) -> NlpparseckyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_graphn_fill(s : NlpparseckyGraphN, v : Double) -> NlpparseckyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_graphn_min(s : NlpparseckyGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_graphn_max(s : NlpparseckyGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_graphn_to_string(s : NlpparseckyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_node_make(size : Int) -> NlpparseckyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_node_len(s : NlpparseckyNode) -> Int { s.size }

pub fn nlp_parse_cky_node_get(s : NlpparseckyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_node_set(s : NlpparseckyNode, i : Int, v : Double) -> NlpparseckyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_node_sum(s : NlpparseckyNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_node_mean(s : NlpparseckyNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_node_scale(s : NlpparseckyNode, f : Double) -> NlpparseckyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_node_add(a : NlpparseckyNode, b : NlpparseckyNode) -> NlpparseckyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_node_copy(s : NlpparseckyNode) -> NlpparseckyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_node_fill(s : NlpparseckyNode, v : Double) -> NlpparseckyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_node_min(s : NlpparseckyNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_node_max(s : NlpparseckyNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_node_to_string(s : NlpparseckyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_edge_make(size : Int) -> NlpparseckyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_edge_len(s : NlpparseckyEdge) -> Int { s.size }

pub fn nlp_parse_cky_edge_get(s : NlpparseckyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_edge_set(s : NlpparseckyEdge, i : Int, v : Double) -> NlpparseckyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_edge_sum(s : NlpparseckyEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_edge_mean(s : NlpparseckyEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_edge_scale(s : NlpparseckyEdge, f : Double) -> NlpparseckyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_edge_add(a : NlpparseckyEdge, b : NlpparseckyEdge) -> NlpparseckyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_edge_copy(s : NlpparseckyEdge) -> NlpparseckyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_edge_fill(s : NlpparseckyEdge, v : Double) -> NlpparseckyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_edge_min(s : NlpparseckyEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_edge_max(s : NlpparseckyEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_edge_to_string(s : NlpparseckyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_path_make(size : Int) -> NlpparseckyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_path_len(s : NlpparseckyPath) -> Int { s.size }

pub fn nlp_parse_cky_path_get(s : NlpparseckyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_path_set(s : NlpparseckyPath, i : Int, v : Double) -> NlpparseckyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_path_sum(s : NlpparseckyPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_path_mean(s : NlpparseckyPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_path_scale(s : NlpparseckyPath, f : Double) -> NlpparseckyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_path_add(a : NlpparseckyPath, b : NlpparseckyPath) -> NlpparseckyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_path_copy(s : NlpparseckyPath) -> NlpparseckyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_path_fill(s : NlpparseckyPath, v : Double) -> NlpparseckyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_path_min(s : NlpparseckyPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_path_max(s : NlpparseckyPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_path_to_string(s : NlpparseckyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_cluster_make(size : Int) -> NlpparseckyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_cluster_len(s : NlpparseckyCluster) -> Int { s.size }

pub fn nlp_parse_cky_cluster_get(s : NlpparseckyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_cluster_set(s : NlpparseckyCluster, i : Int, v : Double) -> NlpparseckyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_cluster_sum(s : NlpparseckyCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_cluster_mean(s : NlpparseckyCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_cluster_scale(s : NlpparseckyCluster, f : Double) -> NlpparseckyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_cluster_add(a : NlpparseckyCluster, b : NlpparseckyCluster) -> NlpparseckyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_cluster_copy(s : NlpparseckyCluster) -> NlpparseckyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_cluster_fill(s : NlpparseckyCluster, v : Double) -> NlpparseckyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_cluster_min(s : NlpparseckyCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_cluster_max(s : NlpparseckyCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_cluster_to_string(s : NlpparseckyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_model_make(size : Int) -> NlpparseckyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_model_len(s : NlpparseckyModel) -> Int { s.size }

pub fn nlp_parse_cky_model_get(s : NlpparseckyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_model_set(s : NlpparseckyModel, i : Int, v : Double) -> NlpparseckyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_model_sum(s : NlpparseckyModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_model_mean(s : NlpparseckyModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_model_scale(s : NlpparseckyModel, f : Double) -> NlpparseckyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_model_add(a : NlpparseckyModel, b : NlpparseckyModel) -> NlpparseckyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_model_copy(s : NlpparseckyModel) -> NlpparseckyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_model_fill(s : NlpparseckyModel, v : Double) -> NlpparseckyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_model_min(s : NlpparseckyModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_model_max(s : NlpparseckyModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_model_to_string(s : NlpparseckyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_layer_make(size : Int) -> NlpparseckyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_layer_len(s : NlpparseckyLayer) -> Int { s.size }

pub fn nlp_parse_cky_layer_get(s : NlpparseckyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_layer_set(s : NlpparseckyLayer, i : Int, v : Double) -> NlpparseckyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_layer_sum(s : NlpparseckyLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_layer_mean(s : NlpparseckyLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_layer_scale(s : NlpparseckyLayer, f : Double) -> NlpparseckyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_layer_add(a : NlpparseckyLayer, b : NlpparseckyLayer) -> NlpparseckyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_layer_copy(s : NlpparseckyLayer) -> NlpparseckyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_layer_fill(s : NlpparseckyLayer, v : Double) -> NlpparseckyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_layer_min(s : NlpparseckyLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_layer_max(s : NlpparseckyLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_layer_to_string(s : NlpparseckyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_buffer_make(size : Int) -> NlpparseckyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_buffer_len(s : NlpparseckyBuffer) -> Int { s.size }

pub fn nlp_parse_cky_buffer_get(s : NlpparseckyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_buffer_set(s : NlpparseckyBuffer, i : Int, v : Double) -> NlpparseckyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_buffer_sum(s : NlpparseckyBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_buffer_mean(s : NlpparseckyBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_buffer_scale(s : NlpparseckyBuffer, f : Double) -> NlpparseckyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_buffer_add(a : NlpparseckyBuffer, b : NlpparseckyBuffer) -> NlpparseckyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_buffer_copy(s : NlpparseckyBuffer) -> NlpparseckyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_buffer_fill(s : NlpparseckyBuffer, v : Double) -> NlpparseckyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_buffer_min(s : NlpparseckyBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_buffer_max(s : NlpparseckyBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_buffer_to_string(s : NlpparseckyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_cursor_make(size : Int) -> NlpparseckyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_cursor_len(s : NlpparseckyCursor) -> Int { s.size }

pub fn nlp_parse_cky_cursor_get(s : NlpparseckyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_cursor_set(s : NlpparseckyCursor, i : Int, v : Double) -> NlpparseckyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_cursor_sum(s : NlpparseckyCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_cursor_mean(s : NlpparseckyCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_cursor_scale(s : NlpparseckyCursor, f : Double) -> NlpparseckyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_cursor_add(a : NlpparseckyCursor, b : NlpparseckyCursor) -> NlpparseckyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_cursor_copy(s : NlpparseckyCursor) -> NlpparseckyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_cursor_fill(s : NlpparseckyCursor, v : Double) -> NlpparseckyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_cursor_min(s : NlpparseckyCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_cursor_max(s : NlpparseckyCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_cursor_to_string(s : NlpparseckyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_view_make(size : Int) -> NlpparseckyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_view_len(s : NlpparseckyView) -> Int { s.size }

pub fn nlp_parse_cky_view_get(s : NlpparseckyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_view_set(s : NlpparseckyView, i : Int, v : Double) -> NlpparseckyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_view_sum(s : NlpparseckyView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_view_mean(s : NlpparseckyView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_view_scale(s : NlpparseckyView, f : Double) -> NlpparseckyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_view_add(a : NlpparseckyView, b : NlpparseckyView) -> NlpparseckyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_view_copy(s : NlpparseckyView) -> NlpparseckyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_view_fill(s : NlpparseckyView, v : Double) -> NlpparseckyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_view_min(s : NlpparseckyView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_view_max(s : NlpparseckyView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_view_to_string(s : NlpparseckyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_range_make(size : Int) -> NlpparseckyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_range_len(s : NlpparseckyRange) -> Int { s.size }

pub fn nlp_parse_cky_range_get(s : NlpparseckyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_range_set(s : NlpparseckyRange, i : Int, v : Double) -> NlpparseckyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_range_sum(s : NlpparseckyRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_range_mean(s : NlpparseckyRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_range_scale(s : NlpparseckyRange, f : Double) -> NlpparseckyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_range_add(a : NlpparseckyRange, b : NlpparseckyRange) -> NlpparseckyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_range_copy(s : NlpparseckyRange) -> NlpparseckyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_range_fill(s : NlpparseckyRange, v : Double) -> NlpparseckyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_range_min(s : NlpparseckyRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_range_max(s : NlpparseckyRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_range_to_string(s : NlpparseckyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseckySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cky_slice_make(size : Int) -> NlpparseckySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cky_slice_len(s : NlpparseckySlice) -> Int { s.size }

pub fn nlp_parse_cky_slice_get(s : NlpparseckySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cky_slice_set(s : NlpparseckySlice, i : Int, v : Double) -> NlpparseckySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_slice_sum(s : NlpparseckySlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cky_slice_mean(s : NlpparseckySlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cky_slice_scale(s : NlpparseckySlice, f : Double) -> NlpparseckySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_slice_add(a : NlpparseckySlice, b : NlpparseckySlice) -> NlpparseckySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cky_slice_copy(s : NlpparseckySlice) -> NlpparseckySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_slice_fill(s : NlpparseckySlice, v : Double) -> NlpparseckySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cky_slice_min(s : NlpparseckySlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cky_slice_max(s : NlpparseckySlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cky_slice_to_string(s : NlpparseckySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

