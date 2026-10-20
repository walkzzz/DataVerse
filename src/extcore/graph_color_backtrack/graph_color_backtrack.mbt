///===
/// extcore/graph_color_backtrack

pub(all) struct GraphcolorbacktrackPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_backtrack_make_point(x : Double, y : Double) -> GraphcolorbacktrackPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_backtrack_make_point3(x : Double, y : Double, z : Double) -> GraphcolorbacktrackPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorbacktrackPoint::x(self : GraphcolorbacktrackPoint) -> Double { self.x }

pub fn GraphcolorbacktrackPoint::y(self : GraphcolorbacktrackPoint) -> Double { self.y }

pub fn GraphcolorbacktrackPoint::z(self : GraphcolorbacktrackPoint) -> Double { self.z }

pub fn GraphcolorbacktrackPoint::label(self : GraphcolorbacktrackPoint) -> Int { self.label }

pub fn GraphcolorbacktrackPoint::dist(self : GraphcolorbacktrackPoint, other : GraphcolorbacktrackPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorbacktrackPoint::add(self : GraphcolorbacktrackPoint, other : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorbacktrackPoint::sub(self : GraphcolorbacktrackPoint, other : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorbacktrackPoint::scale(self : GraphcolorbacktrackPoint, s : Double) -> GraphcolorbacktrackPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorbacktrackPoint::dot(self : GraphcolorbacktrackPoint, other : GraphcolorbacktrackPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorbacktrackPoint::cross(self : GraphcolorbacktrackPoint, other : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorbacktrackPoint::norm(self : GraphcolorbacktrackPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorbacktrackPoint::normalize(self : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorbacktrackPoint::negate(self : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorbacktrackPoint::mid(self : GraphcolorbacktrackPoint, other : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorbacktrackPoint::lerp(self : GraphcolorbacktrackPoint, other : GraphcolorbacktrackPoint, t : Double) -> GraphcolorbacktrackPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorbacktrackPoint::to_string(self : GraphcolorbacktrackPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_backtrack_make_series(vals : Array[Double], name : String) -> GraphcolorbacktrackSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorbacktrackSeries::len(self : GraphcolorbacktrackSeries) -> Int { self.vals.length() }

pub fn GraphcolorbacktrackSeries::sum(self : GraphcolorbacktrackSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorbacktrackSeries::mean(self : GraphcolorbacktrackSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorbacktrackSeries::min(self : GraphcolorbacktrackSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorbacktrackSeries::max(self : GraphcolorbacktrackSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorbacktrackSeries::range(self : GraphcolorbacktrackSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorbacktrackSeries::variance(self : GraphcolorbacktrackSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorbacktrackSeries::std(self : GraphcolorbacktrackSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorbacktrackSeries::median(self : GraphcolorbacktrackSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorbacktrackSeries::scale(self : GraphcolorbacktrackSeries, f : Double) -> GraphcolorbacktrackSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorbacktrackSeries::add(self : GraphcolorbacktrackSeries, other : GraphcolorbacktrackSeries) -> GraphcolorbacktrackSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorbacktrackSeries::sub(self : GraphcolorbacktrackSeries, other : GraphcolorbacktrackSeries) -> GraphcolorbacktrackSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorbacktrackSeries::normalize(self : GraphcolorbacktrackSeries) -> GraphcolorbacktrackSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorbacktrackSeries::cumsum(self : GraphcolorbacktrackSeries) -> GraphcolorbacktrackSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorbacktrackSeries::to_string(self : GraphcolorbacktrackSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorbacktrackMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_backtrack_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorbacktrackMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_backtrack_matrix_identity(n : Int) -> GraphcolorbacktrackMatrix {
  let m = graph_color_backtrack_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorbacktrackMatrix::get(self : GraphcolorbacktrackMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorbacktrackMatrix::transpose(self : GraphcolorbacktrackMatrix) -> GraphcolorbacktrackMatrix {
  let result = graph_color_backtrack_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorbacktrackMatrix::add(self : GraphcolorbacktrackMatrix, other : GraphcolorbacktrackMatrix) -> GraphcolorbacktrackMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_backtrack_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorbacktrackMatrix::scale(self : GraphcolorbacktrackMatrix, s : Double) -> GraphcolorbacktrackMatrix {
  let result = graph_color_backtrack_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorbacktrackMatrix::multiply(self : GraphcolorbacktrackMatrix, other : GraphcolorbacktrackMatrix) -> GraphcolorbacktrackMatrix {
  if self.cols != other.rows { return graph_color_backtrack_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_backtrack_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphcolorbacktrackMatrix::trace(self : GraphcolorbacktrackMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorbacktrackMatrix::det(self : GraphcolorbacktrackMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorbacktrackMatrix::norm(self : GraphcolorbacktrackMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorbacktrackMatrix::to_string(self : GraphcolorbacktrackMatrix) -> String {
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

pub(all) struct GraphcolorbacktrackVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_backtrack_make_vector(comps : Array[Double]) -> GraphcolorbacktrackVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_backtrack_vector_zero(dim : Int) -> GraphcolorbacktrackVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorbacktrackVector::add(self : GraphcolorbacktrackVector, other : GraphcolorbacktrackVector) -> GraphcolorbacktrackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorbacktrackVector::sub(self : GraphcolorbacktrackVector, other : GraphcolorbacktrackVector) -> GraphcolorbacktrackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorbacktrackVector::scale(self : GraphcolorbacktrackVector, s : Double) -> GraphcolorbacktrackVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorbacktrackVector::dot(self : GraphcolorbacktrackVector, other : GraphcolorbacktrackVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorbacktrackVector::norm(self : GraphcolorbacktrackVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorbacktrackVector::normalize(self : GraphcolorbacktrackVector) -> GraphcolorbacktrackVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorbacktrackVector::dist(self : GraphcolorbacktrackVector, other : GraphcolorbacktrackVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorbacktrackVector::to_string(self : GraphcolorbacktrackVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_backtrack_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_backtrack_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_backtrack_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_backtrack_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_backtrack_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_backtrack_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_backtrack_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_backtrack_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_backtrack_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_backtrack_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_backtrack_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_backtrack_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_backtrack_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_backtrack_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_backtrack_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_backtrack_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_backtrack_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_backtrack_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_backtrack_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_backtrack_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_backtrack_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_backtrack_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_backtrack_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_backtrack_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_backtrack_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_backtrack_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_backtrack_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_backtrack_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_backtrack_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorbacktrackFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_frame_make(size : Int) -> GraphcolorbacktrackFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_frame_len(s : GraphcolorbacktrackFrame) -> Int { s.size }

pub fn graph_color_backtrack_frame_get(s : GraphcolorbacktrackFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_frame_set(s : GraphcolorbacktrackFrame, i : Int, v : Double) -> GraphcolorbacktrackFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_frame_sum(s : GraphcolorbacktrackFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_frame_mean(s : GraphcolorbacktrackFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_frame_scale(s : GraphcolorbacktrackFrame, f : Double) -> GraphcolorbacktrackFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_frame_add(a : GraphcolorbacktrackFrame, b : GraphcolorbacktrackFrame) -> GraphcolorbacktrackFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_frame_copy(s : GraphcolorbacktrackFrame) -> GraphcolorbacktrackFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_frame_fill(s : GraphcolorbacktrackFrame, v : Double) -> GraphcolorbacktrackFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_frame_min(s : GraphcolorbacktrackFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_frame_max(s : GraphcolorbacktrackFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_frame_to_string(s : GraphcolorbacktrackFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_table_make(size : Int) -> GraphcolorbacktrackTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_table_len(s : GraphcolorbacktrackTable) -> Int { s.size }

pub fn graph_color_backtrack_table_get(s : GraphcolorbacktrackTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_table_set(s : GraphcolorbacktrackTable, i : Int, v : Double) -> GraphcolorbacktrackTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_table_sum(s : GraphcolorbacktrackTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_table_mean(s : GraphcolorbacktrackTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_table_scale(s : GraphcolorbacktrackTable, f : Double) -> GraphcolorbacktrackTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_table_add(a : GraphcolorbacktrackTable, b : GraphcolorbacktrackTable) -> GraphcolorbacktrackTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_table_copy(s : GraphcolorbacktrackTable) -> GraphcolorbacktrackTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_table_fill(s : GraphcolorbacktrackTable, v : Double) -> GraphcolorbacktrackTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_table_min(s : GraphcolorbacktrackTable) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_table_max(s : GraphcolorbacktrackTable) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_table_to_string(s : GraphcolorbacktrackTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_graphn_make(size : Int) -> GraphcolorbacktrackGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_graphn_len(s : GraphcolorbacktrackGraphN) -> Int { s.size }

pub fn graph_color_backtrack_graphn_get(s : GraphcolorbacktrackGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_graphn_set(s : GraphcolorbacktrackGraphN, i : Int, v : Double) -> GraphcolorbacktrackGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_graphn_sum(s : GraphcolorbacktrackGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_graphn_mean(s : GraphcolorbacktrackGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_graphn_scale(s : GraphcolorbacktrackGraphN, f : Double) -> GraphcolorbacktrackGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_graphn_add(a : GraphcolorbacktrackGraphN, b : GraphcolorbacktrackGraphN) -> GraphcolorbacktrackGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_graphn_copy(s : GraphcolorbacktrackGraphN) -> GraphcolorbacktrackGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_graphn_fill(s : GraphcolorbacktrackGraphN, v : Double) -> GraphcolorbacktrackGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_graphn_min(s : GraphcolorbacktrackGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_graphn_max(s : GraphcolorbacktrackGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_graphn_to_string(s : GraphcolorbacktrackGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_node_make(size : Int) -> GraphcolorbacktrackNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_node_len(s : GraphcolorbacktrackNode) -> Int { s.size }

pub fn graph_color_backtrack_node_get(s : GraphcolorbacktrackNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_node_set(s : GraphcolorbacktrackNode, i : Int, v : Double) -> GraphcolorbacktrackNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_node_sum(s : GraphcolorbacktrackNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_node_mean(s : GraphcolorbacktrackNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_node_scale(s : GraphcolorbacktrackNode, f : Double) -> GraphcolorbacktrackNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_node_add(a : GraphcolorbacktrackNode, b : GraphcolorbacktrackNode) -> GraphcolorbacktrackNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_node_copy(s : GraphcolorbacktrackNode) -> GraphcolorbacktrackNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_node_fill(s : GraphcolorbacktrackNode, v : Double) -> GraphcolorbacktrackNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_node_min(s : GraphcolorbacktrackNode) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_node_max(s : GraphcolorbacktrackNode) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_node_to_string(s : GraphcolorbacktrackNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_edge_make(size : Int) -> GraphcolorbacktrackEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_edge_len(s : GraphcolorbacktrackEdge) -> Int { s.size }

pub fn graph_color_backtrack_edge_get(s : GraphcolorbacktrackEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_edge_set(s : GraphcolorbacktrackEdge, i : Int, v : Double) -> GraphcolorbacktrackEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_edge_sum(s : GraphcolorbacktrackEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_edge_mean(s : GraphcolorbacktrackEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_edge_scale(s : GraphcolorbacktrackEdge, f : Double) -> GraphcolorbacktrackEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_edge_add(a : GraphcolorbacktrackEdge, b : GraphcolorbacktrackEdge) -> GraphcolorbacktrackEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_edge_copy(s : GraphcolorbacktrackEdge) -> GraphcolorbacktrackEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_edge_fill(s : GraphcolorbacktrackEdge, v : Double) -> GraphcolorbacktrackEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_edge_min(s : GraphcolorbacktrackEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_edge_max(s : GraphcolorbacktrackEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_edge_to_string(s : GraphcolorbacktrackEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_path_make(size : Int) -> GraphcolorbacktrackPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_path_len(s : GraphcolorbacktrackPath) -> Int { s.size }

pub fn graph_color_backtrack_path_get(s : GraphcolorbacktrackPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_path_set(s : GraphcolorbacktrackPath, i : Int, v : Double) -> GraphcolorbacktrackPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_path_sum(s : GraphcolorbacktrackPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_path_mean(s : GraphcolorbacktrackPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_path_scale(s : GraphcolorbacktrackPath, f : Double) -> GraphcolorbacktrackPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_path_add(a : GraphcolorbacktrackPath, b : GraphcolorbacktrackPath) -> GraphcolorbacktrackPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_path_copy(s : GraphcolorbacktrackPath) -> GraphcolorbacktrackPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_path_fill(s : GraphcolorbacktrackPath, v : Double) -> GraphcolorbacktrackPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_path_min(s : GraphcolorbacktrackPath) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_path_max(s : GraphcolorbacktrackPath) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_path_to_string(s : GraphcolorbacktrackPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_cluster_make(size : Int) -> GraphcolorbacktrackCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_cluster_len(s : GraphcolorbacktrackCluster) -> Int { s.size }

pub fn graph_color_backtrack_cluster_get(s : GraphcolorbacktrackCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_cluster_set(s : GraphcolorbacktrackCluster, i : Int, v : Double) -> GraphcolorbacktrackCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_cluster_sum(s : GraphcolorbacktrackCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_cluster_mean(s : GraphcolorbacktrackCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_cluster_scale(s : GraphcolorbacktrackCluster, f : Double) -> GraphcolorbacktrackCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_cluster_add(a : GraphcolorbacktrackCluster, b : GraphcolorbacktrackCluster) -> GraphcolorbacktrackCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_cluster_copy(s : GraphcolorbacktrackCluster) -> GraphcolorbacktrackCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_cluster_fill(s : GraphcolorbacktrackCluster, v : Double) -> GraphcolorbacktrackCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_cluster_min(s : GraphcolorbacktrackCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_cluster_max(s : GraphcolorbacktrackCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_cluster_to_string(s : GraphcolorbacktrackCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_model_make(size : Int) -> GraphcolorbacktrackModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_model_len(s : GraphcolorbacktrackModel) -> Int { s.size }

pub fn graph_color_backtrack_model_get(s : GraphcolorbacktrackModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_model_set(s : GraphcolorbacktrackModel, i : Int, v : Double) -> GraphcolorbacktrackModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_model_sum(s : GraphcolorbacktrackModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_model_mean(s : GraphcolorbacktrackModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_model_scale(s : GraphcolorbacktrackModel, f : Double) -> GraphcolorbacktrackModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_model_add(a : GraphcolorbacktrackModel, b : GraphcolorbacktrackModel) -> GraphcolorbacktrackModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_model_copy(s : GraphcolorbacktrackModel) -> GraphcolorbacktrackModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_model_fill(s : GraphcolorbacktrackModel, v : Double) -> GraphcolorbacktrackModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_model_min(s : GraphcolorbacktrackModel) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_model_max(s : GraphcolorbacktrackModel) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_model_to_string(s : GraphcolorbacktrackModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_layer_make(size : Int) -> GraphcolorbacktrackLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_layer_len(s : GraphcolorbacktrackLayer) -> Int { s.size }

pub fn graph_color_backtrack_layer_get(s : GraphcolorbacktrackLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_layer_set(s : GraphcolorbacktrackLayer, i : Int, v : Double) -> GraphcolorbacktrackLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_layer_sum(s : GraphcolorbacktrackLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_layer_mean(s : GraphcolorbacktrackLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_layer_scale(s : GraphcolorbacktrackLayer, f : Double) -> GraphcolorbacktrackLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_layer_add(a : GraphcolorbacktrackLayer, b : GraphcolorbacktrackLayer) -> GraphcolorbacktrackLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_layer_copy(s : GraphcolorbacktrackLayer) -> GraphcolorbacktrackLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_layer_fill(s : GraphcolorbacktrackLayer, v : Double) -> GraphcolorbacktrackLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_layer_min(s : GraphcolorbacktrackLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_layer_max(s : GraphcolorbacktrackLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_layer_to_string(s : GraphcolorbacktrackLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_buffer_make(size : Int) -> GraphcolorbacktrackBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_buffer_len(s : GraphcolorbacktrackBuffer) -> Int { s.size }

pub fn graph_color_backtrack_buffer_get(s : GraphcolorbacktrackBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_buffer_set(s : GraphcolorbacktrackBuffer, i : Int, v : Double) -> GraphcolorbacktrackBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_buffer_sum(s : GraphcolorbacktrackBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_buffer_mean(s : GraphcolorbacktrackBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_buffer_scale(s : GraphcolorbacktrackBuffer, f : Double) -> GraphcolorbacktrackBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_buffer_add(a : GraphcolorbacktrackBuffer, b : GraphcolorbacktrackBuffer) -> GraphcolorbacktrackBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_buffer_copy(s : GraphcolorbacktrackBuffer) -> GraphcolorbacktrackBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_buffer_fill(s : GraphcolorbacktrackBuffer, v : Double) -> GraphcolorbacktrackBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_buffer_min(s : GraphcolorbacktrackBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_buffer_max(s : GraphcolorbacktrackBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_buffer_to_string(s : GraphcolorbacktrackBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_cursor_make(size : Int) -> GraphcolorbacktrackCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_cursor_len(s : GraphcolorbacktrackCursor) -> Int { s.size }

pub fn graph_color_backtrack_cursor_get(s : GraphcolorbacktrackCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_cursor_set(s : GraphcolorbacktrackCursor, i : Int, v : Double) -> GraphcolorbacktrackCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_cursor_sum(s : GraphcolorbacktrackCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_cursor_mean(s : GraphcolorbacktrackCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_cursor_scale(s : GraphcolorbacktrackCursor, f : Double) -> GraphcolorbacktrackCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_cursor_add(a : GraphcolorbacktrackCursor, b : GraphcolorbacktrackCursor) -> GraphcolorbacktrackCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_cursor_copy(s : GraphcolorbacktrackCursor) -> GraphcolorbacktrackCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_cursor_fill(s : GraphcolorbacktrackCursor, v : Double) -> GraphcolorbacktrackCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_cursor_min(s : GraphcolorbacktrackCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_cursor_max(s : GraphcolorbacktrackCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_cursor_to_string(s : GraphcolorbacktrackCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_view_make(size : Int) -> GraphcolorbacktrackView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_view_len(s : GraphcolorbacktrackView) -> Int { s.size }

pub fn graph_color_backtrack_view_get(s : GraphcolorbacktrackView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_view_set(s : GraphcolorbacktrackView, i : Int, v : Double) -> GraphcolorbacktrackView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_view_sum(s : GraphcolorbacktrackView) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_view_mean(s : GraphcolorbacktrackView) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_view_scale(s : GraphcolorbacktrackView, f : Double) -> GraphcolorbacktrackView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_view_add(a : GraphcolorbacktrackView, b : GraphcolorbacktrackView) -> GraphcolorbacktrackView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_view_copy(s : GraphcolorbacktrackView) -> GraphcolorbacktrackView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_view_fill(s : GraphcolorbacktrackView, v : Double) -> GraphcolorbacktrackView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_view_min(s : GraphcolorbacktrackView) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_view_max(s : GraphcolorbacktrackView) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_view_to_string(s : GraphcolorbacktrackView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_range_make(size : Int) -> GraphcolorbacktrackRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_range_len(s : GraphcolorbacktrackRange) -> Int { s.size }

pub fn graph_color_backtrack_range_get(s : GraphcolorbacktrackRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_range_set(s : GraphcolorbacktrackRange, i : Int, v : Double) -> GraphcolorbacktrackRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_range_sum(s : GraphcolorbacktrackRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_range_mean(s : GraphcolorbacktrackRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_range_scale(s : GraphcolorbacktrackRange, f : Double) -> GraphcolorbacktrackRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_range_add(a : GraphcolorbacktrackRange, b : GraphcolorbacktrackRange) -> GraphcolorbacktrackRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_range_copy(s : GraphcolorbacktrackRange) -> GraphcolorbacktrackRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_range_fill(s : GraphcolorbacktrackRange, v : Double) -> GraphcolorbacktrackRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_range_min(s : GraphcolorbacktrackRange) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_range_max(s : GraphcolorbacktrackRange) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_range_to_string(s : GraphcolorbacktrackRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_slice_make(size : Int) -> GraphcolorbacktrackSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_slice_len(s : GraphcolorbacktrackSlice) -> Int { s.size }

pub fn graph_color_backtrack_slice_get(s : GraphcolorbacktrackSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_slice_set(s : GraphcolorbacktrackSlice, i : Int, v : Double) -> GraphcolorbacktrackSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_slice_sum(s : GraphcolorbacktrackSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_backtrack_slice_mean(s : GraphcolorbacktrackSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_backtrack_slice_scale(s : GraphcolorbacktrackSlice, f : Double) -> GraphcolorbacktrackSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_slice_add(a : GraphcolorbacktrackSlice, b : GraphcolorbacktrackSlice) -> GraphcolorbacktrackSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_backtrack_slice_copy(s : GraphcolorbacktrackSlice) -> GraphcolorbacktrackSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_slice_fill(s : GraphcolorbacktrackSlice, v : Double) -> GraphcolorbacktrackSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_backtrack_slice_min(s : GraphcolorbacktrackSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_backtrack_slice_max(s : GraphcolorbacktrackSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_backtrack_slice_to_string(s : GraphcolorbacktrackSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

