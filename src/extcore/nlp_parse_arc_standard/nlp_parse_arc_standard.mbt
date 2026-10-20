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

pub fn NlpparsearcstandardFrame::len(self : NlpparsearcstandardFrame) -> Int { self.size }

pub fn NlpparsearcstandardFrame::get(self : NlpparsearcstandardFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardFrame::set(self : NlpparsearcstandardFrame, i : Int, v : Double) -> NlpparsearcstandardFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardFrame::sum(self : NlpparsearcstandardFrame) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardFrame::mean(self : NlpparsearcstandardFrame) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardFrame::scale(self : NlpparsearcstandardFrame, f : Double) -> NlpparsearcstandardFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardFrame::add(self : NlpparsearcstandardFrame, other : NlpparsearcstandardFrame) -> NlpparsearcstandardFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardFrame::copy(self : NlpparsearcstandardFrame) -> NlpparsearcstandardFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardFrame::fill(self : NlpparsearcstandardFrame, v : Double) -> NlpparsearcstandardFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardFrame::min(self : NlpparsearcstandardFrame) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardFrame::max(self : NlpparsearcstandardFrame) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardFrame::to_string(self : NlpparsearcstandardFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_table_make(size : Int) -> NlpparsearcstandardTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardTable::len(self : NlpparsearcstandardTable) -> Int { self.size }

pub fn NlpparsearcstandardTable::get(self : NlpparsearcstandardTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardTable::set(self : NlpparsearcstandardTable, i : Int, v : Double) -> NlpparsearcstandardTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardTable::sum(self : NlpparsearcstandardTable) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardTable::mean(self : NlpparsearcstandardTable) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardTable::scale(self : NlpparsearcstandardTable, f : Double) -> NlpparsearcstandardTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardTable::add(self : NlpparsearcstandardTable, other : NlpparsearcstandardTable) -> NlpparsearcstandardTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardTable::copy(self : NlpparsearcstandardTable) -> NlpparsearcstandardTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardTable::fill(self : NlpparsearcstandardTable, v : Double) -> NlpparsearcstandardTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardTable::min(self : NlpparsearcstandardTable) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardTable::max(self : NlpparsearcstandardTable) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardTable::to_string(self : NlpparsearcstandardTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_graphn_make(size : Int) -> NlpparsearcstandardGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardGraphN::len(self : NlpparsearcstandardGraphN) -> Int { self.size }

pub fn NlpparsearcstandardGraphN::get(self : NlpparsearcstandardGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardGraphN::set(self : NlpparsearcstandardGraphN, i : Int, v : Double) -> NlpparsearcstandardGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardGraphN::sum(self : NlpparsearcstandardGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardGraphN::mean(self : NlpparsearcstandardGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardGraphN::scale(self : NlpparsearcstandardGraphN, f : Double) -> NlpparsearcstandardGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardGraphN::add(self : NlpparsearcstandardGraphN, other : NlpparsearcstandardGraphN) -> NlpparsearcstandardGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardGraphN::copy(self : NlpparsearcstandardGraphN) -> NlpparsearcstandardGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardGraphN::fill(self : NlpparsearcstandardGraphN, v : Double) -> NlpparsearcstandardGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardGraphN::min(self : NlpparsearcstandardGraphN) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardGraphN::max(self : NlpparsearcstandardGraphN) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardGraphN::to_string(self : NlpparsearcstandardGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_node_make(size : Int) -> NlpparsearcstandardNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardNode::len(self : NlpparsearcstandardNode) -> Int { self.size }

pub fn NlpparsearcstandardNode::get(self : NlpparsearcstandardNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardNode::set(self : NlpparsearcstandardNode, i : Int, v : Double) -> NlpparsearcstandardNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardNode::sum(self : NlpparsearcstandardNode) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardNode::mean(self : NlpparsearcstandardNode) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardNode::scale(self : NlpparsearcstandardNode, f : Double) -> NlpparsearcstandardNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardNode::add(self : NlpparsearcstandardNode, other : NlpparsearcstandardNode) -> NlpparsearcstandardNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardNode::copy(self : NlpparsearcstandardNode) -> NlpparsearcstandardNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardNode::fill(self : NlpparsearcstandardNode, v : Double) -> NlpparsearcstandardNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardNode::min(self : NlpparsearcstandardNode) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardNode::max(self : NlpparsearcstandardNode) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardNode::to_string(self : NlpparsearcstandardNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_edge_make(size : Int) -> NlpparsearcstandardEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardEdge::len(self : NlpparsearcstandardEdge) -> Int { self.size }

pub fn NlpparsearcstandardEdge::get(self : NlpparsearcstandardEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardEdge::set(self : NlpparsearcstandardEdge, i : Int, v : Double) -> NlpparsearcstandardEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardEdge::sum(self : NlpparsearcstandardEdge) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardEdge::mean(self : NlpparsearcstandardEdge) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardEdge::scale(self : NlpparsearcstandardEdge, f : Double) -> NlpparsearcstandardEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardEdge::add(self : NlpparsearcstandardEdge, other : NlpparsearcstandardEdge) -> NlpparsearcstandardEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardEdge::copy(self : NlpparsearcstandardEdge) -> NlpparsearcstandardEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardEdge::fill(self : NlpparsearcstandardEdge, v : Double) -> NlpparsearcstandardEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardEdge::min(self : NlpparsearcstandardEdge) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardEdge::max(self : NlpparsearcstandardEdge) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardEdge::to_string(self : NlpparsearcstandardEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_path_make(size : Int) -> NlpparsearcstandardPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardPath::len(self : NlpparsearcstandardPath) -> Int { self.size }

pub fn NlpparsearcstandardPath::get(self : NlpparsearcstandardPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardPath::set(self : NlpparsearcstandardPath, i : Int, v : Double) -> NlpparsearcstandardPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardPath::sum(self : NlpparsearcstandardPath) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardPath::mean(self : NlpparsearcstandardPath) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardPath::scale(self : NlpparsearcstandardPath, f : Double) -> NlpparsearcstandardPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardPath::add(self : NlpparsearcstandardPath, other : NlpparsearcstandardPath) -> NlpparsearcstandardPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardPath::copy(self : NlpparsearcstandardPath) -> NlpparsearcstandardPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardPath::fill(self : NlpparsearcstandardPath, v : Double) -> NlpparsearcstandardPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardPath::min(self : NlpparsearcstandardPath) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardPath::max(self : NlpparsearcstandardPath) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardPath::to_string(self : NlpparsearcstandardPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_cluster_make(size : Int) -> NlpparsearcstandardCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardCluster::len(self : NlpparsearcstandardCluster) -> Int { self.size }

pub fn NlpparsearcstandardCluster::get(self : NlpparsearcstandardCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardCluster::set(self : NlpparsearcstandardCluster, i : Int, v : Double) -> NlpparsearcstandardCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardCluster::sum(self : NlpparsearcstandardCluster) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardCluster::mean(self : NlpparsearcstandardCluster) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardCluster::scale(self : NlpparsearcstandardCluster, f : Double) -> NlpparsearcstandardCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardCluster::add(self : NlpparsearcstandardCluster, other : NlpparsearcstandardCluster) -> NlpparsearcstandardCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardCluster::copy(self : NlpparsearcstandardCluster) -> NlpparsearcstandardCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardCluster::fill(self : NlpparsearcstandardCluster, v : Double) -> NlpparsearcstandardCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardCluster::min(self : NlpparsearcstandardCluster) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardCluster::max(self : NlpparsearcstandardCluster) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardCluster::to_string(self : NlpparsearcstandardCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_model_make(size : Int) -> NlpparsearcstandardModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardModel::len(self : NlpparsearcstandardModel) -> Int { self.size }

pub fn NlpparsearcstandardModel::get(self : NlpparsearcstandardModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardModel::set(self : NlpparsearcstandardModel, i : Int, v : Double) -> NlpparsearcstandardModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardModel::sum(self : NlpparsearcstandardModel) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardModel::mean(self : NlpparsearcstandardModel) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardModel::scale(self : NlpparsearcstandardModel, f : Double) -> NlpparsearcstandardModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardModel::add(self : NlpparsearcstandardModel, other : NlpparsearcstandardModel) -> NlpparsearcstandardModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardModel::copy(self : NlpparsearcstandardModel) -> NlpparsearcstandardModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardModel::fill(self : NlpparsearcstandardModel, v : Double) -> NlpparsearcstandardModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardModel::min(self : NlpparsearcstandardModel) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardModel::max(self : NlpparsearcstandardModel) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardModel::to_string(self : NlpparsearcstandardModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_layer_make(size : Int) -> NlpparsearcstandardLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardLayer::len(self : NlpparsearcstandardLayer) -> Int { self.size }

pub fn NlpparsearcstandardLayer::get(self : NlpparsearcstandardLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardLayer::set(self : NlpparsearcstandardLayer, i : Int, v : Double) -> NlpparsearcstandardLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardLayer::sum(self : NlpparsearcstandardLayer) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardLayer::mean(self : NlpparsearcstandardLayer) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardLayer::scale(self : NlpparsearcstandardLayer, f : Double) -> NlpparsearcstandardLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardLayer::add(self : NlpparsearcstandardLayer, other : NlpparsearcstandardLayer) -> NlpparsearcstandardLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardLayer::copy(self : NlpparsearcstandardLayer) -> NlpparsearcstandardLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardLayer::fill(self : NlpparsearcstandardLayer, v : Double) -> NlpparsearcstandardLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardLayer::min(self : NlpparsearcstandardLayer) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardLayer::max(self : NlpparsearcstandardLayer) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardLayer::to_string(self : NlpparsearcstandardLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_buffer_make(size : Int) -> NlpparsearcstandardBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardBuffer::len(self : NlpparsearcstandardBuffer) -> Int { self.size }

pub fn NlpparsearcstandardBuffer::get(self : NlpparsearcstandardBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardBuffer::set(self : NlpparsearcstandardBuffer, i : Int, v : Double) -> NlpparsearcstandardBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardBuffer::sum(self : NlpparsearcstandardBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardBuffer::mean(self : NlpparsearcstandardBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardBuffer::scale(self : NlpparsearcstandardBuffer, f : Double) -> NlpparsearcstandardBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardBuffer::add(self : NlpparsearcstandardBuffer, other : NlpparsearcstandardBuffer) -> NlpparsearcstandardBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardBuffer::copy(self : NlpparsearcstandardBuffer) -> NlpparsearcstandardBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardBuffer::fill(self : NlpparsearcstandardBuffer, v : Double) -> NlpparsearcstandardBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardBuffer::min(self : NlpparsearcstandardBuffer) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardBuffer::max(self : NlpparsearcstandardBuffer) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardBuffer::to_string(self : NlpparsearcstandardBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_cursor_make(size : Int) -> NlpparsearcstandardCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardCursor::len(self : NlpparsearcstandardCursor) -> Int { self.size }

pub fn NlpparsearcstandardCursor::get(self : NlpparsearcstandardCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardCursor::set(self : NlpparsearcstandardCursor, i : Int, v : Double) -> NlpparsearcstandardCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardCursor::sum(self : NlpparsearcstandardCursor) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardCursor::mean(self : NlpparsearcstandardCursor) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardCursor::scale(self : NlpparsearcstandardCursor, f : Double) -> NlpparsearcstandardCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardCursor::add(self : NlpparsearcstandardCursor, other : NlpparsearcstandardCursor) -> NlpparsearcstandardCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardCursor::copy(self : NlpparsearcstandardCursor) -> NlpparsearcstandardCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardCursor::fill(self : NlpparsearcstandardCursor, v : Double) -> NlpparsearcstandardCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardCursor::min(self : NlpparsearcstandardCursor) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardCursor::max(self : NlpparsearcstandardCursor) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardCursor::to_string(self : NlpparsearcstandardCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_view_make(size : Int) -> NlpparsearcstandardView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardView::len(self : NlpparsearcstandardView) -> Int { self.size }

pub fn NlpparsearcstandardView::get(self : NlpparsearcstandardView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardView::set(self : NlpparsearcstandardView, i : Int, v : Double) -> NlpparsearcstandardView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardView::sum(self : NlpparsearcstandardView) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardView::mean(self : NlpparsearcstandardView) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardView::scale(self : NlpparsearcstandardView, f : Double) -> NlpparsearcstandardView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardView::add(self : NlpparsearcstandardView, other : NlpparsearcstandardView) -> NlpparsearcstandardView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardView::copy(self : NlpparsearcstandardView) -> NlpparsearcstandardView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardView::fill(self : NlpparsearcstandardView, v : Double) -> NlpparsearcstandardView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardView::min(self : NlpparsearcstandardView) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardView::max(self : NlpparsearcstandardView) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardView::to_string(self : NlpparsearcstandardView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_range_make(size : Int) -> NlpparsearcstandardRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardRange::len(self : NlpparsearcstandardRange) -> Int { self.size }

pub fn NlpparsearcstandardRange::get(self : NlpparsearcstandardRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardRange::set(self : NlpparsearcstandardRange, i : Int, v : Double) -> NlpparsearcstandardRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardRange::sum(self : NlpparsearcstandardRange) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardRange::mean(self : NlpparsearcstandardRange) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardRange::scale(self : NlpparsearcstandardRange, f : Double) -> NlpparsearcstandardRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardRange::add(self : NlpparsearcstandardRange, other : NlpparsearcstandardRange) -> NlpparsearcstandardRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardRange::copy(self : NlpparsearcstandardRange) -> NlpparsearcstandardRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardRange::fill(self : NlpparsearcstandardRange, v : Double) -> NlpparsearcstandardRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardRange::min(self : NlpparsearcstandardRange) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardRange::max(self : NlpparsearcstandardRange) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardRange::to_string(self : NlpparsearcstandardRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_slice_make(size : Int) -> NlpparsearcstandardSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsearcstandardSlice::len(self : NlpparsearcstandardSlice) -> Int { self.size }

pub fn NlpparsearcstandardSlice::get(self : NlpparsearcstandardSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsearcstandardSlice::set(self : NlpparsearcstandardSlice, i : Int, v : Double) -> NlpparsearcstandardSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardSlice::sum(self : NlpparsearcstandardSlice) -> Double { @_common.sum(self.data) }

pub fn NlpparsearcstandardSlice::mean(self : NlpparsearcstandardSlice) -> Double { @_common.mean(self.data) }

pub fn NlpparsearcstandardSlice::scale(self : NlpparsearcstandardSlice, f : Double) -> NlpparsearcstandardSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardSlice::add(self : NlpparsearcstandardSlice, other : NlpparsearcstandardSlice) -> NlpparsearcstandardSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsearcstandardSlice::copy(self : NlpparsearcstandardSlice) -> NlpparsearcstandardSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardSlice::fill(self : NlpparsearcstandardSlice, v : Double) -> NlpparsearcstandardSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsearcstandardSlice::min(self : NlpparsearcstandardSlice) -> Double { @_common.min(self.data) }

pub fn NlpparsearcstandardSlice::max(self : NlpparsearcstandardSlice) -> Double { @_common.max(self.data) }

pub fn NlpparsearcstandardSlice::to_string(self : NlpparsearcstandardSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

