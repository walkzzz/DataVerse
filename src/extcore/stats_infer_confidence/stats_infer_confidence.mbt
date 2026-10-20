///===
/// extcore/stats_infer_confidence

pub(all) struct StatsinferconfidencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_confidence_make_point(x : Double, y : Double) -> StatsinferconfidencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_confidence_make_point3(x : Double, y : Double, z : Double) -> StatsinferconfidencePoint {
  { x, y, z, label: 0 }
}

pub fn StatsinferconfidencePoint::x(self : StatsinferconfidencePoint) -> Double { self.x }

pub fn StatsinferconfidencePoint::y(self : StatsinferconfidencePoint) -> Double { self.y }

pub fn StatsinferconfidencePoint::z(self : StatsinferconfidencePoint) -> Double { self.z }

pub fn StatsinferconfidencePoint::label(self : StatsinferconfidencePoint) -> Int { self.label }

pub fn StatsinferconfidencePoint::dist(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsinferconfidencePoint::add(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsinferconfidencePoint::sub(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsinferconfidencePoint::scale(self : StatsinferconfidencePoint, s : Double) -> StatsinferconfidencePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsinferconfidencePoint::dot(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsinferconfidencePoint::cross(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsinferconfidencePoint::norm(self : StatsinferconfidencePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsinferconfidencePoint::normalize(self : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferconfidencePoint::negate(self : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsinferconfidencePoint::mid(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsinferconfidencePoint::lerp(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint, t : Double) -> StatsinferconfidencePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsinferconfidencePoint::to_string(self : StatsinferconfidencePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsinferconfidenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_confidence_make_series(vals : Array[Double], name : String) -> StatsinferconfidenceSeries {
  { vals, name, meta: 0 }
}

pub fn StatsinferconfidenceSeries::len(self : StatsinferconfidenceSeries) -> Int { self.vals.length() }

pub fn StatsinferconfidenceSeries::sum(self : StatsinferconfidenceSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsinferconfidenceSeries::mean(self : StatsinferconfidenceSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsinferconfidenceSeries::min(self : StatsinferconfidenceSeries) -> Double { @_common.min(self.vals) }

pub fn StatsinferconfidenceSeries::max(self : StatsinferconfidenceSeries) -> Double { @_common.max(self.vals) }

pub fn StatsinferconfidenceSeries::range(self : StatsinferconfidenceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsinferconfidenceSeries::variance(self : StatsinferconfidenceSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsinferconfidenceSeries::std(self : StatsinferconfidenceSeries) -> Double { @_common.std(self.vals) }

pub fn StatsinferconfidenceSeries::median(self : StatsinferconfidenceSeries) -> Double { @_common.median(self.vals) }

pub fn StatsinferconfidenceSeries::scale(self : StatsinferconfidenceSeries, f : Double) -> StatsinferconfidenceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsinferconfidenceSeries::add(self : StatsinferconfidenceSeries, other : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsinferconfidenceSeries::sub(self : StatsinferconfidenceSeries, other : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsinferconfidenceSeries::normalize(self : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsinferconfidenceSeries::cumsum(self : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsinferconfidenceSeries::to_string(self : StatsinferconfidenceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferconfidenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_confidence_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferconfidenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_confidence_matrix_identity(n : Int) -> StatsinferconfidenceMatrix {
  let m = stats_infer_confidence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsinferconfidenceMatrix::get(self : StatsinferconfidenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsinferconfidenceMatrix::transpose(self : StatsinferconfidenceMatrix) -> StatsinferconfidenceMatrix {
  let result = stats_infer_confidence_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsinferconfidenceMatrix::add(self : StatsinferconfidenceMatrix, other : StatsinferconfidenceMatrix) -> StatsinferconfidenceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_infer_confidence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsinferconfidenceMatrix::scale(self : StatsinferconfidenceMatrix, s : Double) -> StatsinferconfidenceMatrix {
  let result = stats_infer_confidence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsinferconfidenceMatrix::multiply(self : StatsinferconfidenceMatrix, other : StatsinferconfidenceMatrix) -> StatsinferconfidenceMatrix {
  if self.cols != other.rows { return stats_infer_confidence_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_infer_confidence_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsinferconfidenceMatrix::trace(self : StatsinferconfidenceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsinferconfidenceMatrix::det(self : StatsinferconfidenceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsinferconfidenceMatrix::norm(self : StatsinferconfidenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsinferconfidenceMatrix::to_string(self : StatsinferconfidenceMatrix) -> String {
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

pub(all) struct StatsinferconfidenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_confidence_make_vector(comps : Array[Double]) -> StatsinferconfidenceVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_confidence_vector_zero(dim : Int) -> StatsinferconfidenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsinferconfidenceVector::add(self : StatsinferconfidenceVector, other : StatsinferconfidenceVector) -> StatsinferconfidenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferconfidenceVector::sub(self : StatsinferconfidenceVector, other : StatsinferconfidenceVector) -> StatsinferconfidenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferconfidenceVector::scale(self : StatsinferconfidenceVector, s : Double) -> StatsinferconfidenceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsinferconfidenceVector::dot(self : StatsinferconfidenceVector, other : StatsinferconfidenceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsinferconfidenceVector::norm(self : StatsinferconfidenceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsinferconfidenceVector::normalize(self : StatsinferconfidenceVector) -> StatsinferconfidenceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferconfidenceVector::dist(self : StatsinferconfidenceVector, other : StatsinferconfidenceVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsinferconfidenceVector::to_string(self : StatsinferconfidenceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_infer_confidence_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_infer_confidence_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_infer_confidence_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_infer_confidence_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_infer_confidence_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_infer_confidence_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_infer_confidence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_infer_confidence_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_infer_confidence_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_infer_confidence_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_infer_confidence_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_infer_confidence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_infer_confidence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_infer_confidence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_infer_confidence_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_infer_confidence_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_infer_confidence_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_infer_confidence_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_infer_confidence_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_infer_confidence_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_infer_confidence_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_infer_confidence_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_infer_confidence_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_infer_confidence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_infer_confidence_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_infer_confidence_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_infer_confidence_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_infer_confidence_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_infer_confidence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsinferconfidenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_frame_make(size : Int) -> StatsinferconfidenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_frame_len(s : StatsinferconfidenceFrame) -> Int { s.size }

pub fn stats_infer_confidence_frame_get(s : StatsinferconfidenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_frame_set(s : StatsinferconfidenceFrame, i : Int, v : Double) -> StatsinferconfidenceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_frame_sum(s : StatsinferconfidenceFrame) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_frame_mean(s : StatsinferconfidenceFrame) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_frame_scale(s : StatsinferconfidenceFrame, f : Double) -> StatsinferconfidenceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_frame_add(a : StatsinferconfidenceFrame, b : StatsinferconfidenceFrame) -> StatsinferconfidenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_frame_copy(s : StatsinferconfidenceFrame) -> StatsinferconfidenceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_frame_fill(s : StatsinferconfidenceFrame, v : Double) -> StatsinferconfidenceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_frame_min(s : StatsinferconfidenceFrame) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_frame_max(s : StatsinferconfidenceFrame) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_frame_to_string(s : StatsinferconfidenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_table_make(size : Int) -> StatsinferconfidenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_table_len(s : StatsinferconfidenceTable) -> Int { s.size }

pub fn stats_infer_confidence_table_get(s : StatsinferconfidenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_table_set(s : StatsinferconfidenceTable, i : Int, v : Double) -> StatsinferconfidenceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_table_sum(s : StatsinferconfidenceTable) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_table_mean(s : StatsinferconfidenceTable) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_table_scale(s : StatsinferconfidenceTable, f : Double) -> StatsinferconfidenceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_table_add(a : StatsinferconfidenceTable, b : StatsinferconfidenceTable) -> StatsinferconfidenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_table_copy(s : StatsinferconfidenceTable) -> StatsinferconfidenceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_table_fill(s : StatsinferconfidenceTable, v : Double) -> StatsinferconfidenceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_table_min(s : StatsinferconfidenceTable) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_table_max(s : StatsinferconfidenceTable) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_table_to_string(s : StatsinferconfidenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_graphn_make(size : Int) -> StatsinferconfidenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_graphn_len(s : StatsinferconfidenceGraphN) -> Int { s.size }

pub fn stats_infer_confidence_graphn_get(s : StatsinferconfidenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_graphn_set(s : StatsinferconfidenceGraphN, i : Int, v : Double) -> StatsinferconfidenceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_graphn_sum(s : StatsinferconfidenceGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_graphn_mean(s : StatsinferconfidenceGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_graphn_scale(s : StatsinferconfidenceGraphN, f : Double) -> StatsinferconfidenceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_graphn_add(a : StatsinferconfidenceGraphN, b : StatsinferconfidenceGraphN) -> StatsinferconfidenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_graphn_copy(s : StatsinferconfidenceGraphN) -> StatsinferconfidenceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_graphn_fill(s : StatsinferconfidenceGraphN, v : Double) -> StatsinferconfidenceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_graphn_min(s : StatsinferconfidenceGraphN) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_graphn_max(s : StatsinferconfidenceGraphN) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_graphn_to_string(s : StatsinferconfidenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_node_make(size : Int) -> StatsinferconfidenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_node_len(s : StatsinferconfidenceNode) -> Int { s.size }

pub fn stats_infer_confidence_node_get(s : StatsinferconfidenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_node_set(s : StatsinferconfidenceNode, i : Int, v : Double) -> StatsinferconfidenceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_node_sum(s : StatsinferconfidenceNode) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_node_mean(s : StatsinferconfidenceNode) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_node_scale(s : StatsinferconfidenceNode, f : Double) -> StatsinferconfidenceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_node_add(a : StatsinferconfidenceNode, b : StatsinferconfidenceNode) -> StatsinferconfidenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_node_copy(s : StatsinferconfidenceNode) -> StatsinferconfidenceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_node_fill(s : StatsinferconfidenceNode, v : Double) -> StatsinferconfidenceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_node_min(s : StatsinferconfidenceNode) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_node_max(s : StatsinferconfidenceNode) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_node_to_string(s : StatsinferconfidenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_edge_make(size : Int) -> StatsinferconfidenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_edge_len(s : StatsinferconfidenceEdge) -> Int { s.size }

pub fn stats_infer_confidence_edge_get(s : StatsinferconfidenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_edge_set(s : StatsinferconfidenceEdge, i : Int, v : Double) -> StatsinferconfidenceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_edge_sum(s : StatsinferconfidenceEdge) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_edge_mean(s : StatsinferconfidenceEdge) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_edge_scale(s : StatsinferconfidenceEdge, f : Double) -> StatsinferconfidenceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_edge_add(a : StatsinferconfidenceEdge, b : StatsinferconfidenceEdge) -> StatsinferconfidenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_edge_copy(s : StatsinferconfidenceEdge) -> StatsinferconfidenceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_edge_fill(s : StatsinferconfidenceEdge, v : Double) -> StatsinferconfidenceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_edge_min(s : StatsinferconfidenceEdge) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_edge_max(s : StatsinferconfidenceEdge) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_edge_to_string(s : StatsinferconfidenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_path_make(size : Int) -> StatsinferconfidencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_path_len(s : StatsinferconfidencePath) -> Int { s.size }

pub fn stats_infer_confidence_path_get(s : StatsinferconfidencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_path_set(s : StatsinferconfidencePath, i : Int, v : Double) -> StatsinferconfidencePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_path_sum(s : StatsinferconfidencePath) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_path_mean(s : StatsinferconfidencePath) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_path_scale(s : StatsinferconfidencePath, f : Double) -> StatsinferconfidencePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_path_add(a : StatsinferconfidencePath, b : StatsinferconfidencePath) -> StatsinferconfidencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_path_copy(s : StatsinferconfidencePath) -> StatsinferconfidencePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_path_fill(s : StatsinferconfidencePath, v : Double) -> StatsinferconfidencePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_path_min(s : StatsinferconfidencePath) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_path_max(s : StatsinferconfidencePath) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_path_to_string(s : StatsinferconfidencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_cluster_make(size : Int) -> StatsinferconfidenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_cluster_len(s : StatsinferconfidenceCluster) -> Int { s.size }

pub fn stats_infer_confidence_cluster_get(s : StatsinferconfidenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_cluster_set(s : StatsinferconfidenceCluster, i : Int, v : Double) -> StatsinferconfidenceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cluster_sum(s : StatsinferconfidenceCluster) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_cluster_mean(s : StatsinferconfidenceCluster) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_cluster_scale(s : StatsinferconfidenceCluster, f : Double) -> StatsinferconfidenceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cluster_add(a : StatsinferconfidenceCluster, b : StatsinferconfidenceCluster) -> StatsinferconfidenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_cluster_copy(s : StatsinferconfidenceCluster) -> StatsinferconfidenceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cluster_fill(s : StatsinferconfidenceCluster, v : Double) -> StatsinferconfidenceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cluster_min(s : StatsinferconfidenceCluster) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_cluster_max(s : StatsinferconfidenceCluster) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_cluster_to_string(s : StatsinferconfidenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_model_make(size : Int) -> StatsinferconfidenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_model_len(s : StatsinferconfidenceModel) -> Int { s.size }

pub fn stats_infer_confidence_model_get(s : StatsinferconfidenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_model_set(s : StatsinferconfidenceModel, i : Int, v : Double) -> StatsinferconfidenceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_model_sum(s : StatsinferconfidenceModel) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_model_mean(s : StatsinferconfidenceModel) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_model_scale(s : StatsinferconfidenceModel, f : Double) -> StatsinferconfidenceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_model_add(a : StatsinferconfidenceModel, b : StatsinferconfidenceModel) -> StatsinferconfidenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_model_copy(s : StatsinferconfidenceModel) -> StatsinferconfidenceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_model_fill(s : StatsinferconfidenceModel, v : Double) -> StatsinferconfidenceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_model_min(s : StatsinferconfidenceModel) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_model_max(s : StatsinferconfidenceModel) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_model_to_string(s : StatsinferconfidenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_layer_make(size : Int) -> StatsinferconfidenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_layer_len(s : StatsinferconfidenceLayer) -> Int { s.size }

pub fn stats_infer_confidence_layer_get(s : StatsinferconfidenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_layer_set(s : StatsinferconfidenceLayer, i : Int, v : Double) -> StatsinferconfidenceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_layer_sum(s : StatsinferconfidenceLayer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_layer_mean(s : StatsinferconfidenceLayer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_layer_scale(s : StatsinferconfidenceLayer, f : Double) -> StatsinferconfidenceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_layer_add(a : StatsinferconfidenceLayer, b : StatsinferconfidenceLayer) -> StatsinferconfidenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_layer_copy(s : StatsinferconfidenceLayer) -> StatsinferconfidenceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_layer_fill(s : StatsinferconfidenceLayer, v : Double) -> StatsinferconfidenceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_layer_min(s : StatsinferconfidenceLayer) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_layer_max(s : StatsinferconfidenceLayer) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_layer_to_string(s : StatsinferconfidenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_buffer_make(size : Int) -> StatsinferconfidenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_buffer_len(s : StatsinferconfidenceBuffer) -> Int { s.size }

pub fn stats_infer_confidence_buffer_get(s : StatsinferconfidenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_buffer_set(s : StatsinferconfidenceBuffer, i : Int, v : Double) -> StatsinferconfidenceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_buffer_sum(s : StatsinferconfidenceBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_buffer_mean(s : StatsinferconfidenceBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_buffer_scale(s : StatsinferconfidenceBuffer, f : Double) -> StatsinferconfidenceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_buffer_add(a : StatsinferconfidenceBuffer, b : StatsinferconfidenceBuffer) -> StatsinferconfidenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_buffer_copy(s : StatsinferconfidenceBuffer) -> StatsinferconfidenceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_buffer_fill(s : StatsinferconfidenceBuffer, v : Double) -> StatsinferconfidenceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_buffer_min(s : StatsinferconfidenceBuffer) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_buffer_max(s : StatsinferconfidenceBuffer) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_buffer_to_string(s : StatsinferconfidenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_cursor_make(size : Int) -> StatsinferconfidenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_cursor_len(s : StatsinferconfidenceCursor) -> Int { s.size }

pub fn stats_infer_confidence_cursor_get(s : StatsinferconfidenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_cursor_set(s : StatsinferconfidenceCursor, i : Int, v : Double) -> StatsinferconfidenceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cursor_sum(s : StatsinferconfidenceCursor) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_cursor_mean(s : StatsinferconfidenceCursor) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_cursor_scale(s : StatsinferconfidenceCursor, f : Double) -> StatsinferconfidenceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cursor_add(a : StatsinferconfidenceCursor, b : StatsinferconfidenceCursor) -> StatsinferconfidenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_cursor_copy(s : StatsinferconfidenceCursor) -> StatsinferconfidenceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cursor_fill(s : StatsinferconfidenceCursor, v : Double) -> StatsinferconfidenceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_cursor_min(s : StatsinferconfidenceCursor) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_cursor_max(s : StatsinferconfidenceCursor) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_cursor_to_string(s : StatsinferconfidenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_view_make(size : Int) -> StatsinferconfidenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_view_len(s : StatsinferconfidenceView) -> Int { s.size }

pub fn stats_infer_confidence_view_get(s : StatsinferconfidenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_view_set(s : StatsinferconfidenceView, i : Int, v : Double) -> StatsinferconfidenceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_view_sum(s : StatsinferconfidenceView) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_view_mean(s : StatsinferconfidenceView) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_view_scale(s : StatsinferconfidenceView, f : Double) -> StatsinferconfidenceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_view_add(a : StatsinferconfidenceView, b : StatsinferconfidenceView) -> StatsinferconfidenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_view_copy(s : StatsinferconfidenceView) -> StatsinferconfidenceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_view_fill(s : StatsinferconfidenceView, v : Double) -> StatsinferconfidenceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_view_min(s : StatsinferconfidenceView) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_view_max(s : StatsinferconfidenceView) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_view_to_string(s : StatsinferconfidenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_range_make(size : Int) -> StatsinferconfidenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_range_len(s : StatsinferconfidenceRange) -> Int { s.size }

pub fn stats_infer_confidence_range_get(s : StatsinferconfidenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_range_set(s : StatsinferconfidenceRange, i : Int, v : Double) -> StatsinferconfidenceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_range_sum(s : StatsinferconfidenceRange) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_range_mean(s : StatsinferconfidenceRange) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_range_scale(s : StatsinferconfidenceRange, f : Double) -> StatsinferconfidenceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_range_add(a : StatsinferconfidenceRange, b : StatsinferconfidenceRange) -> StatsinferconfidenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_range_copy(s : StatsinferconfidenceRange) -> StatsinferconfidenceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_range_fill(s : StatsinferconfidenceRange, v : Double) -> StatsinferconfidenceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_range_min(s : StatsinferconfidenceRange) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_range_max(s : StatsinferconfidenceRange) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_range_to_string(s : StatsinferconfidenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_slice_make(size : Int) -> StatsinferconfidenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_confidence_slice_len(s : StatsinferconfidenceSlice) -> Int { s.size }

pub fn stats_infer_confidence_slice_get(s : StatsinferconfidenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_confidence_slice_set(s : StatsinferconfidenceSlice, i : Int, v : Double) -> StatsinferconfidenceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_slice_sum(s : StatsinferconfidenceSlice) -> Double { @_common.sum(s.data) }

pub fn stats_infer_confidence_slice_mean(s : StatsinferconfidenceSlice) -> Double { @_common.mean(s.data) }

pub fn stats_infer_confidence_slice_scale(s : StatsinferconfidenceSlice, f : Double) -> StatsinferconfidenceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_slice_add(a : StatsinferconfidenceSlice, b : StatsinferconfidenceSlice) -> StatsinferconfidenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_confidence_slice_copy(s : StatsinferconfidenceSlice) -> StatsinferconfidenceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_slice_fill(s : StatsinferconfidenceSlice, v : Double) -> StatsinferconfidenceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_confidence_slice_min(s : StatsinferconfidenceSlice) -> Double { @_common.min(s.data) }

pub fn stats_infer_confidence_slice_max(s : StatsinferconfidenceSlice) -> Double { @_common.max(s.data) }

pub fn stats_infer_confidence_slice_to_string(s : StatsinferconfidenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

