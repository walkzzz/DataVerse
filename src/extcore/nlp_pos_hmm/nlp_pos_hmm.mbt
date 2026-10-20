///===
/// extcore/nlp_pos_hmm

pub(all) struct NlpposhmmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_hmm_make_point(x : Double, y : Double) -> NlpposhmmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_hmm_make_point3(x : Double, y : Double, z : Double) -> NlpposhmmPoint {
  { x, y, z, label: 0 }
}

pub fn NlpposhmmPoint::x(self : NlpposhmmPoint) -> Double { self.x }

pub fn NlpposhmmPoint::y(self : NlpposhmmPoint) -> Double { self.y }

pub fn NlpposhmmPoint::z(self : NlpposhmmPoint) -> Double { self.z }

pub fn NlpposhmmPoint::label(self : NlpposhmmPoint) -> Int { self.label }

pub fn NlpposhmmPoint::dist(self : NlpposhmmPoint, other : NlpposhmmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpposhmmPoint::add(self : NlpposhmmPoint, other : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpposhmmPoint::sub(self : NlpposhmmPoint, other : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpposhmmPoint::scale(self : NlpposhmmPoint, s : Double) -> NlpposhmmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpposhmmPoint::dot(self : NlpposhmmPoint, other : NlpposhmmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpposhmmPoint::cross(self : NlpposhmmPoint, other : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpposhmmPoint::norm(self : NlpposhmmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpposhmmPoint::normalize(self : NlpposhmmPoint) -> NlpposhmmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposhmmPoint::negate(self : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpposhmmPoint::mid(self : NlpposhmmPoint, other : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpposhmmPoint::lerp(self : NlpposhmmPoint, other : NlpposhmmPoint, t : Double) -> NlpposhmmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpposhmmPoint::to_string(self : NlpposhmmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpposhmmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_hmm_make_series(vals : Array[Double], name : String) -> NlpposhmmSeries {
  { vals, name, meta: 0 }
}

pub fn NlpposhmmSeries::len(self : NlpposhmmSeries) -> Int { self.vals.length() }

pub fn NlpposhmmSeries::sum(self : NlpposhmmSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpposhmmSeries::mean(self : NlpposhmmSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpposhmmSeries::min(self : NlpposhmmSeries) -> Double { @_common.min(self.vals) }

pub fn NlpposhmmSeries::max(self : NlpposhmmSeries) -> Double { @_common.max(self.vals) }

pub fn NlpposhmmSeries::range(self : NlpposhmmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpposhmmSeries::variance(self : NlpposhmmSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpposhmmSeries::std(self : NlpposhmmSeries) -> Double { @_common.std(self.vals) }

pub fn NlpposhmmSeries::median(self : NlpposhmmSeries) -> Double { @_common.median(self.vals) }

pub fn NlpposhmmSeries::scale(self : NlpposhmmSeries, f : Double) -> NlpposhmmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpposhmmSeries::add(self : NlpposhmmSeries, other : NlpposhmmSeries) -> NlpposhmmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpposhmmSeries::sub(self : NlpposhmmSeries, other : NlpposhmmSeries) -> NlpposhmmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpposhmmSeries::normalize(self : NlpposhmmSeries) -> NlpposhmmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpposhmmSeries::cumsum(self : NlpposhmmSeries) -> NlpposhmmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpposhmmSeries::to_string(self : NlpposhmmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposhmmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_hmm_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposhmmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_hmm_matrix_identity(n : Int) -> NlpposhmmMatrix {
  let m = nlp_pos_hmm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpposhmmMatrix::get(self : NlpposhmmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpposhmmMatrix::transpose(self : NlpposhmmMatrix) -> NlpposhmmMatrix {
  let result = nlp_pos_hmm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpposhmmMatrix::add(self : NlpposhmmMatrix, other : NlpposhmmMatrix) -> NlpposhmmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_hmm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpposhmmMatrix::scale(self : NlpposhmmMatrix, s : Double) -> NlpposhmmMatrix {
  let result = nlp_pos_hmm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpposhmmMatrix::multiply(self : NlpposhmmMatrix, other : NlpposhmmMatrix) -> NlpposhmmMatrix {
  if self.cols != other.rows { return nlp_pos_hmm_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_hmm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpposhmmMatrix::trace(self : NlpposhmmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpposhmmMatrix::det(self : NlpposhmmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpposhmmMatrix::norm(self : NlpposhmmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpposhmmMatrix::to_string(self : NlpposhmmMatrix) -> String {
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

pub(all) struct NlpposhmmVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_hmm_make_vector(comps : Array[Double]) -> NlpposhmmVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_hmm_vector_zero(dim : Int) -> NlpposhmmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpposhmmVector::add(self : NlpposhmmVector, other : NlpposhmmVector) -> NlpposhmmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposhmmVector::sub(self : NlpposhmmVector, other : NlpposhmmVector) -> NlpposhmmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposhmmVector::scale(self : NlpposhmmVector, s : Double) -> NlpposhmmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpposhmmVector::dot(self : NlpposhmmVector, other : NlpposhmmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpposhmmVector::norm(self : NlpposhmmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpposhmmVector::normalize(self : NlpposhmmVector) -> NlpposhmmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposhmmVector::dist(self : NlpposhmmVector, other : NlpposhmmVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpposhmmVector::to_string(self : NlpposhmmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_hmm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_hmm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_hmm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_hmm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_hmm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_hmm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_hmm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_hmm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_hmm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_hmm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_hmm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_hmm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_hmm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_hmm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_hmm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_hmm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_hmm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_hmm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_hmm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_hmm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_hmm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_hmm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_hmm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_hmm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_hmm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_hmm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_hmm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_hmm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_hmm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposhmmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_frame_make(size : Int) -> NlpposhmmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_frame_len(s : NlpposhmmFrame) -> Int { s.size }

pub fn nlp_pos_hmm_frame_get(s : NlpposhmmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_frame_set(s : NlpposhmmFrame, i : Int, v : Double) -> NlpposhmmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_frame_sum(s : NlpposhmmFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_frame_mean(s : NlpposhmmFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_frame_scale(s : NlpposhmmFrame, f : Double) -> NlpposhmmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_frame_add(a : NlpposhmmFrame, b : NlpposhmmFrame) -> NlpposhmmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_frame_copy(s : NlpposhmmFrame) -> NlpposhmmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_frame_fill(s : NlpposhmmFrame, v : Double) -> NlpposhmmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_frame_min(s : NlpposhmmFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_frame_max(s : NlpposhmmFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_frame_to_string(s : NlpposhmmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_table_make(size : Int) -> NlpposhmmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_table_len(s : NlpposhmmTable) -> Int { s.size }

pub fn nlp_pos_hmm_table_get(s : NlpposhmmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_table_set(s : NlpposhmmTable, i : Int, v : Double) -> NlpposhmmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_table_sum(s : NlpposhmmTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_table_mean(s : NlpposhmmTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_table_scale(s : NlpposhmmTable, f : Double) -> NlpposhmmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_table_add(a : NlpposhmmTable, b : NlpposhmmTable) -> NlpposhmmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_table_copy(s : NlpposhmmTable) -> NlpposhmmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_table_fill(s : NlpposhmmTable, v : Double) -> NlpposhmmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_table_min(s : NlpposhmmTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_table_max(s : NlpposhmmTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_table_to_string(s : NlpposhmmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_graphn_make(size : Int) -> NlpposhmmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_graphn_len(s : NlpposhmmGraphN) -> Int { s.size }

pub fn nlp_pos_hmm_graphn_get(s : NlpposhmmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_graphn_set(s : NlpposhmmGraphN, i : Int, v : Double) -> NlpposhmmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_graphn_sum(s : NlpposhmmGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_graphn_mean(s : NlpposhmmGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_graphn_scale(s : NlpposhmmGraphN, f : Double) -> NlpposhmmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_graphn_add(a : NlpposhmmGraphN, b : NlpposhmmGraphN) -> NlpposhmmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_graphn_copy(s : NlpposhmmGraphN) -> NlpposhmmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_graphn_fill(s : NlpposhmmGraphN, v : Double) -> NlpposhmmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_graphn_min(s : NlpposhmmGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_graphn_max(s : NlpposhmmGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_graphn_to_string(s : NlpposhmmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_node_make(size : Int) -> NlpposhmmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_node_len(s : NlpposhmmNode) -> Int { s.size }

pub fn nlp_pos_hmm_node_get(s : NlpposhmmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_node_set(s : NlpposhmmNode, i : Int, v : Double) -> NlpposhmmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_node_sum(s : NlpposhmmNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_node_mean(s : NlpposhmmNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_node_scale(s : NlpposhmmNode, f : Double) -> NlpposhmmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_node_add(a : NlpposhmmNode, b : NlpposhmmNode) -> NlpposhmmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_node_copy(s : NlpposhmmNode) -> NlpposhmmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_node_fill(s : NlpposhmmNode, v : Double) -> NlpposhmmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_node_min(s : NlpposhmmNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_node_max(s : NlpposhmmNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_node_to_string(s : NlpposhmmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_edge_make(size : Int) -> NlpposhmmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_edge_len(s : NlpposhmmEdge) -> Int { s.size }

pub fn nlp_pos_hmm_edge_get(s : NlpposhmmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_edge_set(s : NlpposhmmEdge, i : Int, v : Double) -> NlpposhmmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_edge_sum(s : NlpposhmmEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_edge_mean(s : NlpposhmmEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_edge_scale(s : NlpposhmmEdge, f : Double) -> NlpposhmmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_edge_add(a : NlpposhmmEdge, b : NlpposhmmEdge) -> NlpposhmmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_edge_copy(s : NlpposhmmEdge) -> NlpposhmmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_edge_fill(s : NlpposhmmEdge, v : Double) -> NlpposhmmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_edge_min(s : NlpposhmmEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_edge_max(s : NlpposhmmEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_edge_to_string(s : NlpposhmmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_path_make(size : Int) -> NlpposhmmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_path_len(s : NlpposhmmPath) -> Int { s.size }

pub fn nlp_pos_hmm_path_get(s : NlpposhmmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_path_set(s : NlpposhmmPath, i : Int, v : Double) -> NlpposhmmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_path_sum(s : NlpposhmmPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_path_mean(s : NlpposhmmPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_path_scale(s : NlpposhmmPath, f : Double) -> NlpposhmmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_path_add(a : NlpposhmmPath, b : NlpposhmmPath) -> NlpposhmmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_path_copy(s : NlpposhmmPath) -> NlpposhmmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_path_fill(s : NlpposhmmPath, v : Double) -> NlpposhmmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_path_min(s : NlpposhmmPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_path_max(s : NlpposhmmPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_path_to_string(s : NlpposhmmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_cluster_make(size : Int) -> NlpposhmmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_cluster_len(s : NlpposhmmCluster) -> Int { s.size }

pub fn nlp_pos_hmm_cluster_get(s : NlpposhmmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_cluster_set(s : NlpposhmmCluster, i : Int, v : Double) -> NlpposhmmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cluster_sum(s : NlpposhmmCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_cluster_mean(s : NlpposhmmCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_cluster_scale(s : NlpposhmmCluster, f : Double) -> NlpposhmmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cluster_add(a : NlpposhmmCluster, b : NlpposhmmCluster) -> NlpposhmmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_cluster_copy(s : NlpposhmmCluster) -> NlpposhmmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cluster_fill(s : NlpposhmmCluster, v : Double) -> NlpposhmmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cluster_min(s : NlpposhmmCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_cluster_max(s : NlpposhmmCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_cluster_to_string(s : NlpposhmmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_model_make(size : Int) -> NlpposhmmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_model_len(s : NlpposhmmModel) -> Int { s.size }

pub fn nlp_pos_hmm_model_get(s : NlpposhmmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_model_set(s : NlpposhmmModel, i : Int, v : Double) -> NlpposhmmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_model_sum(s : NlpposhmmModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_model_mean(s : NlpposhmmModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_model_scale(s : NlpposhmmModel, f : Double) -> NlpposhmmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_model_add(a : NlpposhmmModel, b : NlpposhmmModel) -> NlpposhmmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_model_copy(s : NlpposhmmModel) -> NlpposhmmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_model_fill(s : NlpposhmmModel, v : Double) -> NlpposhmmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_model_min(s : NlpposhmmModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_model_max(s : NlpposhmmModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_model_to_string(s : NlpposhmmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_layer_make(size : Int) -> NlpposhmmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_layer_len(s : NlpposhmmLayer) -> Int { s.size }

pub fn nlp_pos_hmm_layer_get(s : NlpposhmmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_layer_set(s : NlpposhmmLayer, i : Int, v : Double) -> NlpposhmmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_layer_sum(s : NlpposhmmLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_layer_mean(s : NlpposhmmLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_layer_scale(s : NlpposhmmLayer, f : Double) -> NlpposhmmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_layer_add(a : NlpposhmmLayer, b : NlpposhmmLayer) -> NlpposhmmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_layer_copy(s : NlpposhmmLayer) -> NlpposhmmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_layer_fill(s : NlpposhmmLayer, v : Double) -> NlpposhmmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_layer_min(s : NlpposhmmLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_layer_max(s : NlpposhmmLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_layer_to_string(s : NlpposhmmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_buffer_make(size : Int) -> NlpposhmmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_buffer_len(s : NlpposhmmBuffer) -> Int { s.size }

pub fn nlp_pos_hmm_buffer_get(s : NlpposhmmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_buffer_set(s : NlpposhmmBuffer, i : Int, v : Double) -> NlpposhmmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_buffer_sum(s : NlpposhmmBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_buffer_mean(s : NlpposhmmBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_buffer_scale(s : NlpposhmmBuffer, f : Double) -> NlpposhmmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_buffer_add(a : NlpposhmmBuffer, b : NlpposhmmBuffer) -> NlpposhmmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_buffer_copy(s : NlpposhmmBuffer) -> NlpposhmmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_buffer_fill(s : NlpposhmmBuffer, v : Double) -> NlpposhmmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_buffer_min(s : NlpposhmmBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_buffer_max(s : NlpposhmmBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_buffer_to_string(s : NlpposhmmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_cursor_make(size : Int) -> NlpposhmmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_cursor_len(s : NlpposhmmCursor) -> Int { s.size }

pub fn nlp_pos_hmm_cursor_get(s : NlpposhmmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_cursor_set(s : NlpposhmmCursor, i : Int, v : Double) -> NlpposhmmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cursor_sum(s : NlpposhmmCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_cursor_mean(s : NlpposhmmCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_cursor_scale(s : NlpposhmmCursor, f : Double) -> NlpposhmmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cursor_add(a : NlpposhmmCursor, b : NlpposhmmCursor) -> NlpposhmmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_cursor_copy(s : NlpposhmmCursor) -> NlpposhmmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cursor_fill(s : NlpposhmmCursor, v : Double) -> NlpposhmmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_cursor_min(s : NlpposhmmCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_cursor_max(s : NlpposhmmCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_cursor_to_string(s : NlpposhmmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_view_make(size : Int) -> NlpposhmmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_view_len(s : NlpposhmmView) -> Int { s.size }

pub fn nlp_pos_hmm_view_get(s : NlpposhmmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_view_set(s : NlpposhmmView, i : Int, v : Double) -> NlpposhmmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_view_sum(s : NlpposhmmView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_view_mean(s : NlpposhmmView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_view_scale(s : NlpposhmmView, f : Double) -> NlpposhmmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_view_add(a : NlpposhmmView, b : NlpposhmmView) -> NlpposhmmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_view_copy(s : NlpposhmmView) -> NlpposhmmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_view_fill(s : NlpposhmmView, v : Double) -> NlpposhmmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_view_min(s : NlpposhmmView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_view_max(s : NlpposhmmView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_view_to_string(s : NlpposhmmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_range_make(size : Int) -> NlpposhmmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_range_len(s : NlpposhmmRange) -> Int { s.size }

pub fn nlp_pos_hmm_range_get(s : NlpposhmmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_range_set(s : NlpposhmmRange, i : Int, v : Double) -> NlpposhmmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_range_sum(s : NlpposhmmRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_range_mean(s : NlpposhmmRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_range_scale(s : NlpposhmmRange, f : Double) -> NlpposhmmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_range_add(a : NlpposhmmRange, b : NlpposhmmRange) -> NlpposhmmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_range_copy(s : NlpposhmmRange) -> NlpposhmmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_range_fill(s : NlpposhmmRange, v : Double) -> NlpposhmmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_range_min(s : NlpposhmmRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_range_max(s : NlpposhmmRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_range_to_string(s : NlpposhmmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposhmmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_slice_make(size : Int) -> NlpposhmmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_hmm_slice_len(s : NlpposhmmSlice) -> Int { s.size }

pub fn nlp_pos_hmm_slice_get(s : NlpposhmmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_hmm_slice_set(s : NlpposhmmSlice, i : Int, v : Double) -> NlpposhmmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_slice_sum(s : NlpposhmmSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_hmm_slice_mean(s : NlpposhmmSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_hmm_slice_scale(s : NlpposhmmSlice, f : Double) -> NlpposhmmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_slice_add(a : NlpposhmmSlice, b : NlpposhmmSlice) -> NlpposhmmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_hmm_slice_copy(s : NlpposhmmSlice) -> NlpposhmmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_slice_fill(s : NlpposhmmSlice, v : Double) -> NlpposhmmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_hmm_slice_min(s : NlpposhmmSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_hmm_slice_max(s : NlpposhmmSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_hmm_slice_to_string(s : NlpposhmmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

