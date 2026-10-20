///===
/// extcore/nlp_parse_arc_standard

pub(all) struct NlpparsearcstandardPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_arc_standard_make_point(x : Double, y : Double) -> NlpparsearcstandardPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_arc_standard_make_point3(x : Double, y : Double, z : Double) -> NlpparsearcstandardPoint {
  { x, y, z, label: 0 }
}

pub fn NlpparsearcstandardPoint::x(self : NlpparsearcstandardPoint) -> Double { self.x }

pub fn NlpparsearcstandardPoint::y(self : NlpparsearcstandardPoint) -> Double { self.y }

pub fn NlpparsearcstandardPoint::z(self : NlpparsearcstandardPoint) -> Double { self.z }

pub fn NlpparsearcstandardPoint::label(self : NlpparsearcstandardPoint) -> Int { self.label }

pub fn NlpparsearcstandardPoint::dist(self : NlpparsearcstandardPoint, other : NlpparsearcstandardPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpparsearcstandardPoint::add(self : NlpparsearcstandardPoint, other : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpparsearcstandardPoint::sub(self : NlpparsearcstandardPoint, other : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpparsearcstandardPoint::scale(self : NlpparsearcstandardPoint, s : Double) -> NlpparsearcstandardPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpparsearcstandardPoint::dot(self : NlpparsearcstandardPoint, other : NlpparsearcstandardPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpparsearcstandardPoint::cross(self : NlpparsearcstandardPoint, other : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpparsearcstandardPoint::norm(self : NlpparsearcstandardPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpparsearcstandardPoint::normalize(self : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsearcstandardPoint::negate(self : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpparsearcstandardPoint::mid(self : NlpparsearcstandardPoint, other : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpparsearcstandardPoint::lerp(self : NlpparsearcstandardPoint, other : NlpparsearcstandardPoint, t : Double) -> NlpparsearcstandardPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpparsearcstandardPoint::to_string(self : NlpparsearcstandardPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpparsearcstandardSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_arc_standard_make_series(vals : Array[Double], name : String) -> NlpparsearcstandardSeries {
  { vals, name, meta: 0 }
}

pub fn NlpparsearcstandardSeries::len(self : NlpparsearcstandardSeries) -> Int { self.vals.length() }

pub fn NlpparsearcstandardSeries::sum(self : NlpparsearcstandardSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpparsearcstandardSeries::mean(self : NlpparsearcstandardSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpparsearcstandardSeries::min(self : NlpparsearcstandardSeries) -> Double { @_common.min(self.vals) }

pub fn NlpparsearcstandardSeries::max(self : NlpparsearcstandardSeries) -> Double { @_common.max(self.vals) }

pub fn NlpparsearcstandardSeries::range(self : NlpparsearcstandardSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpparsearcstandardSeries::variance(self : NlpparsearcstandardSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpparsearcstandardSeries::std(self : NlpparsearcstandardSeries) -> Double { @_common.std(self.vals) }

pub fn NlpparsearcstandardSeries::median(self : NlpparsearcstandardSeries) -> Double { @_common.median(self.vals) }

pub fn NlpparsearcstandardSeries::scale(self : NlpparsearcstandardSeries, f : Double) -> NlpparsearcstandardSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpparsearcstandardSeries::add(self : NlpparsearcstandardSeries, other : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpparsearcstandardSeries::sub(self : NlpparsearcstandardSeries, other : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpparsearcstandardSeries::normalize(self : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpparsearcstandardSeries::cumsum(self : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpparsearcstandardSeries::to_string(self : NlpparsearcstandardSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsearcstandardMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_arc_standard_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsearcstandardMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_arc_standard_matrix_identity(n : Int) -> NlpparsearcstandardMatrix {
  let m = nlp_parse_arc_standard_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpparsearcstandardMatrix::get(self : NlpparsearcstandardMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpparsearcstandardMatrix::transpose(self : NlpparsearcstandardMatrix) -> NlpparsearcstandardMatrix {
  let result = nlp_parse_arc_standard_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpparsearcstandardMatrix::add(self : NlpparsearcstandardMatrix, other : NlpparsearcstandardMatrix) -> NlpparsearcstandardMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_parse_arc_standard_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpparsearcstandardMatrix::scale(self : NlpparsearcstandardMatrix, s : Double) -> NlpparsearcstandardMatrix {
  let result = nlp_parse_arc_standard_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpparsearcstandardMatrix::multiply(self : NlpparsearcstandardMatrix, other : NlpparsearcstandardMatrix) -> NlpparsearcstandardMatrix {
  if self.cols != other.rows { return nlp_parse_arc_standard_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_parse_arc_standard_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpparsearcstandardMatrix::trace(self : NlpparsearcstandardMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpparsearcstandardMatrix::det(self : NlpparsearcstandardMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpparsearcstandardMatrix::norm(self : NlpparsearcstandardMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpparsearcstandardMatrix::to_string(self : NlpparsearcstandardMatrix) -> String {
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

pub(all) struct NlpparsearcstandardVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_arc_standard_make_vector(comps : Array[Double]) -> NlpparsearcstandardVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_arc_standard_vector_zero(dim : Int) -> NlpparsearcstandardVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpparsearcstandardVector::add(self : NlpparsearcstandardVector, other : NlpparsearcstandardVector) -> NlpparsearcstandardVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsearcstandardVector::sub(self : NlpparsearcstandardVector, other : NlpparsearcstandardVector) -> NlpparsearcstandardVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsearcstandardVector::scale(self : NlpparsearcstandardVector, s : Double) -> NlpparsearcstandardVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpparsearcstandardVector::dot(self : NlpparsearcstandardVector, other : NlpparsearcstandardVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpparsearcstandardVector::norm(self : NlpparsearcstandardVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpparsearcstandardVector::normalize(self : NlpparsearcstandardVector) -> NlpparsearcstandardVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsearcstandardVector::dist(self : NlpparsearcstandardVector, other : NlpparsearcstandardVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpparsearcstandardVector::to_string(self : NlpparsearcstandardVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_arc_standard_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_arc_standard_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_arc_standard_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_arc_standard_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_arc_standard_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_arc_standard_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_arc_standard_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_arc_standard_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_arc_standard_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_arc_standard_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_arc_standard_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_arc_standard_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_arc_standard_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_arc_standard_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_arc_standard_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_arc_standard_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_arc_standard_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_arc_standard_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_arc_standard_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_arc_standard_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_arc_standard_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_arc_standard_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_arc_standard_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_arc_standard_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_arc_standard_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_arc_standard_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_arc_standard_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_arc_standard_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_arc_standard_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparsearcstandardFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_frame_make(size : Int) -> NlpparsearcstandardFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_frame_len(s : NlpparsearcstandardFrame) -> Int { s.size }

pub fn nlp_parse_arc_standard_frame_get(s : NlpparsearcstandardFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_frame_set(s : NlpparsearcstandardFrame, i : Int, v : Double) -> NlpparsearcstandardFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_frame_sum(s : NlpparsearcstandardFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_frame_mean(s : NlpparsearcstandardFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_frame_scale(s : NlpparsearcstandardFrame, f : Double) -> NlpparsearcstandardFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_frame_add(a : NlpparsearcstandardFrame, b : NlpparsearcstandardFrame) -> NlpparsearcstandardFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_frame_copy(s : NlpparsearcstandardFrame) -> NlpparsearcstandardFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_frame_fill(s : NlpparsearcstandardFrame, v : Double) -> NlpparsearcstandardFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_frame_min(s : NlpparsearcstandardFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_frame_max(s : NlpparsearcstandardFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_frame_to_string(s : NlpparsearcstandardFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_table_make(size : Int) -> NlpparsearcstandardTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_table_len(s : NlpparsearcstandardTable) -> Int { s.size }

pub fn nlp_parse_arc_standard_table_get(s : NlpparsearcstandardTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_table_set(s : NlpparsearcstandardTable, i : Int, v : Double) -> NlpparsearcstandardTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_table_sum(s : NlpparsearcstandardTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_table_mean(s : NlpparsearcstandardTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_table_scale(s : NlpparsearcstandardTable, f : Double) -> NlpparsearcstandardTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_table_add(a : NlpparsearcstandardTable, b : NlpparsearcstandardTable) -> NlpparsearcstandardTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_table_copy(s : NlpparsearcstandardTable) -> NlpparsearcstandardTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_table_fill(s : NlpparsearcstandardTable, v : Double) -> NlpparsearcstandardTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_table_min(s : NlpparsearcstandardTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_table_max(s : NlpparsearcstandardTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_table_to_string(s : NlpparsearcstandardTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_graphn_make(size : Int) -> NlpparsearcstandardGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_graphn_len(s : NlpparsearcstandardGraphN) -> Int { s.size }

pub fn nlp_parse_arc_standard_graphn_get(s : NlpparsearcstandardGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_graphn_set(s : NlpparsearcstandardGraphN, i : Int, v : Double) -> NlpparsearcstandardGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_graphn_sum(s : NlpparsearcstandardGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_graphn_mean(s : NlpparsearcstandardGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_graphn_scale(s : NlpparsearcstandardGraphN, f : Double) -> NlpparsearcstandardGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_graphn_add(a : NlpparsearcstandardGraphN, b : NlpparsearcstandardGraphN) -> NlpparsearcstandardGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_graphn_copy(s : NlpparsearcstandardGraphN) -> NlpparsearcstandardGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_graphn_fill(s : NlpparsearcstandardGraphN, v : Double) -> NlpparsearcstandardGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_graphn_min(s : NlpparsearcstandardGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_graphn_max(s : NlpparsearcstandardGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_graphn_to_string(s : NlpparsearcstandardGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_node_make(size : Int) -> NlpparsearcstandardNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_node_len(s : NlpparsearcstandardNode) -> Int { s.size }

pub fn nlp_parse_arc_standard_node_get(s : NlpparsearcstandardNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_node_set(s : NlpparsearcstandardNode, i : Int, v : Double) -> NlpparsearcstandardNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_node_sum(s : NlpparsearcstandardNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_node_mean(s : NlpparsearcstandardNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_node_scale(s : NlpparsearcstandardNode, f : Double) -> NlpparsearcstandardNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_node_add(a : NlpparsearcstandardNode, b : NlpparsearcstandardNode) -> NlpparsearcstandardNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_node_copy(s : NlpparsearcstandardNode) -> NlpparsearcstandardNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_node_fill(s : NlpparsearcstandardNode, v : Double) -> NlpparsearcstandardNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_node_min(s : NlpparsearcstandardNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_node_max(s : NlpparsearcstandardNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_node_to_string(s : NlpparsearcstandardNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_edge_make(size : Int) -> NlpparsearcstandardEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_edge_len(s : NlpparsearcstandardEdge) -> Int { s.size }

pub fn nlp_parse_arc_standard_edge_get(s : NlpparsearcstandardEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_edge_set(s : NlpparsearcstandardEdge, i : Int, v : Double) -> NlpparsearcstandardEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_edge_sum(s : NlpparsearcstandardEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_edge_mean(s : NlpparsearcstandardEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_edge_scale(s : NlpparsearcstandardEdge, f : Double) -> NlpparsearcstandardEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_edge_add(a : NlpparsearcstandardEdge, b : NlpparsearcstandardEdge) -> NlpparsearcstandardEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_edge_copy(s : NlpparsearcstandardEdge) -> NlpparsearcstandardEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_edge_fill(s : NlpparsearcstandardEdge, v : Double) -> NlpparsearcstandardEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_edge_min(s : NlpparsearcstandardEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_edge_max(s : NlpparsearcstandardEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_edge_to_string(s : NlpparsearcstandardEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_path_make(size : Int) -> NlpparsearcstandardPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_path_len(s : NlpparsearcstandardPath) -> Int { s.size }

pub fn nlp_parse_arc_standard_path_get(s : NlpparsearcstandardPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_path_set(s : NlpparsearcstandardPath, i : Int, v : Double) -> NlpparsearcstandardPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_path_sum(s : NlpparsearcstandardPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_path_mean(s : NlpparsearcstandardPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_path_scale(s : NlpparsearcstandardPath, f : Double) -> NlpparsearcstandardPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_path_add(a : NlpparsearcstandardPath, b : NlpparsearcstandardPath) -> NlpparsearcstandardPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_path_copy(s : NlpparsearcstandardPath) -> NlpparsearcstandardPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_path_fill(s : NlpparsearcstandardPath, v : Double) -> NlpparsearcstandardPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_path_min(s : NlpparsearcstandardPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_path_max(s : NlpparsearcstandardPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_path_to_string(s : NlpparsearcstandardPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_cluster_make(size : Int) -> NlpparsearcstandardCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_cluster_len(s : NlpparsearcstandardCluster) -> Int { s.size }

pub fn nlp_parse_arc_standard_cluster_get(s : NlpparsearcstandardCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_cluster_set(s : NlpparsearcstandardCluster, i : Int, v : Double) -> NlpparsearcstandardCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cluster_sum(s : NlpparsearcstandardCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_cluster_mean(s : NlpparsearcstandardCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_cluster_scale(s : NlpparsearcstandardCluster, f : Double) -> NlpparsearcstandardCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cluster_add(a : NlpparsearcstandardCluster, b : NlpparsearcstandardCluster) -> NlpparsearcstandardCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_cluster_copy(s : NlpparsearcstandardCluster) -> NlpparsearcstandardCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cluster_fill(s : NlpparsearcstandardCluster, v : Double) -> NlpparsearcstandardCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cluster_min(s : NlpparsearcstandardCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_cluster_max(s : NlpparsearcstandardCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_cluster_to_string(s : NlpparsearcstandardCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_model_make(size : Int) -> NlpparsearcstandardModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_model_len(s : NlpparsearcstandardModel) -> Int { s.size }

pub fn nlp_parse_arc_standard_model_get(s : NlpparsearcstandardModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_model_set(s : NlpparsearcstandardModel, i : Int, v : Double) -> NlpparsearcstandardModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_model_sum(s : NlpparsearcstandardModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_model_mean(s : NlpparsearcstandardModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_model_scale(s : NlpparsearcstandardModel, f : Double) -> NlpparsearcstandardModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_model_add(a : NlpparsearcstandardModel, b : NlpparsearcstandardModel) -> NlpparsearcstandardModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_model_copy(s : NlpparsearcstandardModel) -> NlpparsearcstandardModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_model_fill(s : NlpparsearcstandardModel, v : Double) -> NlpparsearcstandardModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_model_min(s : NlpparsearcstandardModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_model_max(s : NlpparsearcstandardModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_model_to_string(s : NlpparsearcstandardModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_layer_make(size : Int) -> NlpparsearcstandardLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_layer_len(s : NlpparsearcstandardLayer) -> Int { s.size }

pub fn nlp_parse_arc_standard_layer_get(s : NlpparsearcstandardLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_layer_set(s : NlpparsearcstandardLayer, i : Int, v : Double) -> NlpparsearcstandardLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_layer_sum(s : NlpparsearcstandardLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_layer_mean(s : NlpparsearcstandardLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_layer_scale(s : NlpparsearcstandardLayer, f : Double) -> NlpparsearcstandardLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_layer_add(a : NlpparsearcstandardLayer, b : NlpparsearcstandardLayer) -> NlpparsearcstandardLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_layer_copy(s : NlpparsearcstandardLayer) -> NlpparsearcstandardLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_layer_fill(s : NlpparsearcstandardLayer, v : Double) -> NlpparsearcstandardLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_layer_min(s : NlpparsearcstandardLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_layer_max(s : NlpparsearcstandardLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_layer_to_string(s : NlpparsearcstandardLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_buffer_make(size : Int) -> NlpparsearcstandardBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_buffer_len(s : NlpparsearcstandardBuffer) -> Int { s.size }

pub fn nlp_parse_arc_standard_buffer_get(s : NlpparsearcstandardBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_buffer_set(s : NlpparsearcstandardBuffer, i : Int, v : Double) -> NlpparsearcstandardBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_buffer_sum(s : NlpparsearcstandardBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_buffer_mean(s : NlpparsearcstandardBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_buffer_scale(s : NlpparsearcstandardBuffer, f : Double) -> NlpparsearcstandardBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_buffer_add(a : NlpparsearcstandardBuffer, b : NlpparsearcstandardBuffer) -> NlpparsearcstandardBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_buffer_copy(s : NlpparsearcstandardBuffer) -> NlpparsearcstandardBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_buffer_fill(s : NlpparsearcstandardBuffer, v : Double) -> NlpparsearcstandardBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_buffer_min(s : NlpparsearcstandardBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_buffer_max(s : NlpparsearcstandardBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_buffer_to_string(s : NlpparsearcstandardBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_cursor_make(size : Int) -> NlpparsearcstandardCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_cursor_len(s : NlpparsearcstandardCursor) -> Int { s.size }

pub fn nlp_parse_arc_standard_cursor_get(s : NlpparsearcstandardCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_cursor_set(s : NlpparsearcstandardCursor, i : Int, v : Double) -> NlpparsearcstandardCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cursor_sum(s : NlpparsearcstandardCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_cursor_mean(s : NlpparsearcstandardCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_cursor_scale(s : NlpparsearcstandardCursor, f : Double) -> NlpparsearcstandardCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cursor_add(a : NlpparsearcstandardCursor, b : NlpparsearcstandardCursor) -> NlpparsearcstandardCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_cursor_copy(s : NlpparsearcstandardCursor) -> NlpparsearcstandardCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cursor_fill(s : NlpparsearcstandardCursor, v : Double) -> NlpparsearcstandardCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_cursor_min(s : NlpparsearcstandardCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_cursor_max(s : NlpparsearcstandardCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_cursor_to_string(s : NlpparsearcstandardCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_view_make(size : Int) -> NlpparsearcstandardView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_view_len(s : NlpparsearcstandardView) -> Int { s.size }

pub fn nlp_parse_arc_standard_view_get(s : NlpparsearcstandardView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_view_set(s : NlpparsearcstandardView, i : Int, v : Double) -> NlpparsearcstandardView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_view_sum(s : NlpparsearcstandardView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_view_mean(s : NlpparsearcstandardView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_view_scale(s : NlpparsearcstandardView, f : Double) -> NlpparsearcstandardView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_view_add(a : NlpparsearcstandardView, b : NlpparsearcstandardView) -> NlpparsearcstandardView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_view_copy(s : NlpparsearcstandardView) -> NlpparsearcstandardView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_view_fill(s : NlpparsearcstandardView, v : Double) -> NlpparsearcstandardView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_view_min(s : NlpparsearcstandardView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_view_max(s : NlpparsearcstandardView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_view_to_string(s : NlpparsearcstandardView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_range_make(size : Int) -> NlpparsearcstandardRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_range_len(s : NlpparsearcstandardRange) -> Int { s.size }

pub fn nlp_parse_arc_standard_range_get(s : NlpparsearcstandardRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_range_set(s : NlpparsearcstandardRange, i : Int, v : Double) -> NlpparsearcstandardRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_range_sum(s : NlpparsearcstandardRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_range_mean(s : NlpparsearcstandardRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_range_scale(s : NlpparsearcstandardRange, f : Double) -> NlpparsearcstandardRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_range_add(a : NlpparsearcstandardRange, b : NlpparsearcstandardRange) -> NlpparsearcstandardRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_range_copy(s : NlpparsearcstandardRange) -> NlpparsearcstandardRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_range_fill(s : NlpparsearcstandardRange, v : Double) -> NlpparsearcstandardRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_range_min(s : NlpparsearcstandardRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_range_max(s : NlpparsearcstandardRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_range_to_string(s : NlpparsearcstandardRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_slice_make(size : Int) -> NlpparsearcstandardSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_slice_len(s : NlpparsearcstandardSlice) -> Int { s.size }

pub fn nlp_parse_arc_standard_slice_get(s : NlpparsearcstandardSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_slice_set(s : NlpparsearcstandardSlice, i : Int, v : Double) -> NlpparsearcstandardSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_slice_sum(s : NlpparsearcstandardSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_arc_standard_slice_mean(s : NlpparsearcstandardSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_arc_standard_slice_scale(s : NlpparsearcstandardSlice, f : Double) -> NlpparsearcstandardSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_slice_add(a : NlpparsearcstandardSlice, b : NlpparsearcstandardSlice) -> NlpparsearcstandardSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_arc_standard_slice_copy(s : NlpparsearcstandardSlice) -> NlpparsearcstandardSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_slice_fill(s : NlpparsearcstandardSlice, v : Double) -> NlpparsearcstandardSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_arc_standard_slice_min(s : NlpparsearcstandardSlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_arc_standard_slice_max(s : NlpparsearcstandardSlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_arc_standard_slice_to_string(s : NlpparsearcstandardSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

