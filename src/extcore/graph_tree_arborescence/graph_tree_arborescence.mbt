///===
/// extcore/graph_tree_arborescence

pub(all) struct GraphtreearborescencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_arborescence_make_point(x : Double, y : Double) -> GraphtreearborescencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_arborescence_make_point3(x : Double, y : Double, z : Double) -> GraphtreearborescencePoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreearborescencePoint::x(self : GraphtreearborescencePoint) -> Double { self.x }

pub fn GraphtreearborescencePoint::y(self : GraphtreearborescencePoint) -> Double { self.y }

pub fn GraphtreearborescencePoint::z(self : GraphtreearborescencePoint) -> Double { self.z }

pub fn GraphtreearborescencePoint::label(self : GraphtreearborescencePoint) -> Int { self.label }

pub fn GraphtreearborescencePoint::dist(self : GraphtreearborescencePoint, other : GraphtreearborescencePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreearborescencePoint::add(self : GraphtreearborescencePoint, other : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreearborescencePoint::sub(self : GraphtreearborescencePoint, other : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreearborescencePoint::scale(self : GraphtreearborescencePoint, s : Double) -> GraphtreearborescencePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreearborescencePoint::dot(self : GraphtreearborescencePoint, other : GraphtreearborescencePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreearborescencePoint::cross(self : GraphtreearborescencePoint, other : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreearborescencePoint::norm(self : GraphtreearborescencePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreearborescencePoint::normalize(self : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreearborescencePoint::negate(self : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreearborescencePoint::mid(self : GraphtreearborescencePoint, other : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreearborescencePoint::lerp(self : GraphtreearborescencePoint, other : GraphtreearborescencePoint, t : Double) -> GraphtreearborescencePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreearborescencePoint::to_string(self : GraphtreearborescencePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreearborescenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_arborescence_make_series(vals : Array[Double], name : String) -> GraphtreearborescenceSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreearborescenceSeries::len(self : GraphtreearborescenceSeries) -> Int { self.vals.length() }

pub fn GraphtreearborescenceSeries::sum(self : GraphtreearborescenceSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreearborescenceSeries::mean(self : GraphtreearborescenceSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreearborescenceSeries::min(self : GraphtreearborescenceSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreearborescenceSeries::max(self : GraphtreearborescenceSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreearborescenceSeries::range(self : GraphtreearborescenceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreearborescenceSeries::variance(self : GraphtreearborescenceSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreearborescenceSeries::std(self : GraphtreearborescenceSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreearborescenceSeries::median(self : GraphtreearborescenceSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreearborescenceSeries::scale(self : GraphtreearborescenceSeries, f : Double) -> GraphtreearborescenceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreearborescenceSeries::add(self : GraphtreearborescenceSeries, other : GraphtreearborescenceSeries) -> GraphtreearborescenceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreearborescenceSeries::sub(self : GraphtreearborescenceSeries, other : GraphtreearborescenceSeries) -> GraphtreearborescenceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreearborescenceSeries::normalize(self : GraphtreearborescenceSeries) -> GraphtreearborescenceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreearborescenceSeries::cumsum(self : GraphtreearborescenceSeries) -> GraphtreearborescenceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreearborescenceSeries::to_string(self : GraphtreearborescenceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreearborescenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_arborescence_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreearborescenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_arborescence_matrix_identity(n : Int) -> GraphtreearborescenceMatrix {
  let m = graph_tree_arborescence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreearborescenceMatrix::get(self : GraphtreearborescenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreearborescenceMatrix::transpose(self : GraphtreearborescenceMatrix) -> GraphtreearborescenceMatrix {
  let result = graph_tree_arborescence_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreearborescenceMatrix::add(self : GraphtreearborescenceMatrix, other : GraphtreearborescenceMatrix) -> GraphtreearborescenceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_arborescence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreearborescenceMatrix::scale(self : GraphtreearborescenceMatrix, s : Double) -> GraphtreearborescenceMatrix {
  let result = graph_tree_arborescence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreearborescenceMatrix::multiply(self : GraphtreearborescenceMatrix, other : GraphtreearborescenceMatrix) -> GraphtreearborescenceMatrix {
  if self.cols != other.rows { return graph_tree_arborescence_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_arborescence_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphtreearborescenceMatrix::trace(self : GraphtreearborescenceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreearborescenceMatrix::det(self : GraphtreearborescenceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreearborescenceMatrix::norm(self : GraphtreearborescenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreearborescenceMatrix::to_string(self : GraphtreearborescenceMatrix) -> String {
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

pub(all) struct GraphtreearborescenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_arborescence_make_vector(comps : Array[Double]) -> GraphtreearborescenceVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_arborescence_vector_zero(dim : Int) -> GraphtreearborescenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreearborescenceVector::add(self : GraphtreearborescenceVector, other : GraphtreearborescenceVector) -> GraphtreearborescenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreearborescenceVector::sub(self : GraphtreearborescenceVector, other : GraphtreearborescenceVector) -> GraphtreearborescenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreearborescenceVector::scale(self : GraphtreearborescenceVector, s : Double) -> GraphtreearborescenceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreearborescenceVector::dot(self : GraphtreearborescenceVector, other : GraphtreearborescenceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreearborescenceVector::norm(self : GraphtreearborescenceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreearborescenceVector::normalize(self : GraphtreearborescenceVector) -> GraphtreearborescenceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreearborescenceVector::dist(self : GraphtreearborescenceVector, other : GraphtreearborescenceVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreearborescenceVector::to_string(self : GraphtreearborescenceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_arborescence_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_arborescence_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_arborescence_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_arborescence_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_arborescence_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_arborescence_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_arborescence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_arborescence_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_arborescence_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_arborescence_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_arborescence_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_arborescence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_arborescence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_arborescence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_arborescence_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_arborescence_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_arborescence_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_arborescence_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_arborescence_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_arborescence_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_arborescence_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_arborescence_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_arborescence_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_arborescence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_arborescence_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_arborescence_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_arborescence_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_arborescence_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_arborescence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreearborescenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_frame_make(size : Int) -> GraphtreearborescenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_frame_len(s : GraphtreearborescenceFrame) -> Int { s.size }

pub fn graph_tree_arborescence_frame_get(s : GraphtreearborescenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_frame_set(s : GraphtreearborescenceFrame, i : Int, v : Double) -> GraphtreearborescenceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_frame_sum(s : GraphtreearborescenceFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_frame_mean(s : GraphtreearborescenceFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_frame_scale(s : GraphtreearborescenceFrame, f : Double) -> GraphtreearborescenceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_frame_add(a : GraphtreearborescenceFrame, b : GraphtreearborescenceFrame) -> GraphtreearborescenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_frame_copy(s : GraphtreearborescenceFrame) -> GraphtreearborescenceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_frame_fill(s : GraphtreearborescenceFrame, v : Double) -> GraphtreearborescenceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_frame_min(s : GraphtreearborescenceFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_frame_max(s : GraphtreearborescenceFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_frame_to_string(s : GraphtreearborescenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_table_make(size : Int) -> GraphtreearborescenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_table_len(s : GraphtreearborescenceTable) -> Int { s.size }

pub fn graph_tree_arborescence_table_get(s : GraphtreearborescenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_table_set(s : GraphtreearborescenceTable, i : Int, v : Double) -> GraphtreearborescenceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_table_sum(s : GraphtreearborescenceTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_table_mean(s : GraphtreearborescenceTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_table_scale(s : GraphtreearborescenceTable, f : Double) -> GraphtreearborescenceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_table_add(a : GraphtreearborescenceTable, b : GraphtreearborescenceTable) -> GraphtreearborescenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_table_copy(s : GraphtreearborescenceTable) -> GraphtreearborescenceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_table_fill(s : GraphtreearborescenceTable, v : Double) -> GraphtreearborescenceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_table_min(s : GraphtreearborescenceTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_table_max(s : GraphtreearborescenceTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_table_to_string(s : GraphtreearborescenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_graphn_make(size : Int) -> GraphtreearborescenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_graphn_len(s : GraphtreearborescenceGraphN) -> Int { s.size }

pub fn graph_tree_arborescence_graphn_get(s : GraphtreearborescenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_graphn_set(s : GraphtreearborescenceGraphN, i : Int, v : Double) -> GraphtreearborescenceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_graphn_sum(s : GraphtreearborescenceGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_graphn_mean(s : GraphtreearborescenceGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_graphn_scale(s : GraphtreearborescenceGraphN, f : Double) -> GraphtreearborescenceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_graphn_add(a : GraphtreearborescenceGraphN, b : GraphtreearborescenceGraphN) -> GraphtreearborescenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_graphn_copy(s : GraphtreearborescenceGraphN) -> GraphtreearborescenceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_graphn_fill(s : GraphtreearborescenceGraphN, v : Double) -> GraphtreearborescenceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_graphn_min(s : GraphtreearborescenceGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_graphn_max(s : GraphtreearborescenceGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_graphn_to_string(s : GraphtreearborescenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_node_make(size : Int) -> GraphtreearborescenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_node_len(s : GraphtreearborescenceNode) -> Int { s.size }

pub fn graph_tree_arborescence_node_get(s : GraphtreearborescenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_node_set(s : GraphtreearborescenceNode, i : Int, v : Double) -> GraphtreearborescenceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_node_sum(s : GraphtreearborescenceNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_node_mean(s : GraphtreearborescenceNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_node_scale(s : GraphtreearborescenceNode, f : Double) -> GraphtreearborescenceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_node_add(a : GraphtreearborescenceNode, b : GraphtreearborescenceNode) -> GraphtreearborescenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_node_copy(s : GraphtreearborescenceNode) -> GraphtreearborescenceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_node_fill(s : GraphtreearborescenceNode, v : Double) -> GraphtreearborescenceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_node_min(s : GraphtreearborescenceNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_node_max(s : GraphtreearborescenceNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_node_to_string(s : GraphtreearborescenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_edge_make(size : Int) -> GraphtreearborescenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_edge_len(s : GraphtreearborescenceEdge) -> Int { s.size }

pub fn graph_tree_arborescence_edge_get(s : GraphtreearborescenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_edge_set(s : GraphtreearborescenceEdge, i : Int, v : Double) -> GraphtreearborescenceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_edge_sum(s : GraphtreearborescenceEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_edge_mean(s : GraphtreearborescenceEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_edge_scale(s : GraphtreearborescenceEdge, f : Double) -> GraphtreearborescenceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_edge_add(a : GraphtreearborescenceEdge, b : GraphtreearborescenceEdge) -> GraphtreearborescenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_edge_copy(s : GraphtreearborescenceEdge) -> GraphtreearborescenceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_edge_fill(s : GraphtreearborescenceEdge, v : Double) -> GraphtreearborescenceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_edge_min(s : GraphtreearborescenceEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_edge_max(s : GraphtreearborescenceEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_edge_to_string(s : GraphtreearborescenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_path_make(size : Int) -> GraphtreearborescencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_path_len(s : GraphtreearborescencePath) -> Int { s.size }

pub fn graph_tree_arborescence_path_get(s : GraphtreearborescencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_path_set(s : GraphtreearborescencePath, i : Int, v : Double) -> GraphtreearborescencePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_path_sum(s : GraphtreearborescencePath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_path_mean(s : GraphtreearborescencePath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_path_scale(s : GraphtreearborescencePath, f : Double) -> GraphtreearborescencePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_path_add(a : GraphtreearborescencePath, b : GraphtreearborescencePath) -> GraphtreearborescencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_path_copy(s : GraphtreearborescencePath) -> GraphtreearborescencePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_path_fill(s : GraphtreearborescencePath, v : Double) -> GraphtreearborescencePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_path_min(s : GraphtreearborescencePath) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_path_max(s : GraphtreearborescencePath) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_path_to_string(s : GraphtreearborescencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_cluster_make(size : Int) -> GraphtreearborescenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_cluster_len(s : GraphtreearborescenceCluster) -> Int { s.size }

pub fn graph_tree_arborescence_cluster_get(s : GraphtreearborescenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_cluster_set(s : GraphtreearborescenceCluster, i : Int, v : Double) -> GraphtreearborescenceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_cluster_sum(s : GraphtreearborescenceCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_cluster_mean(s : GraphtreearborescenceCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_cluster_scale(s : GraphtreearborescenceCluster, f : Double) -> GraphtreearborescenceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_cluster_add(a : GraphtreearborescenceCluster, b : GraphtreearborescenceCluster) -> GraphtreearborescenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_cluster_copy(s : GraphtreearborescenceCluster) -> GraphtreearborescenceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_cluster_fill(s : GraphtreearborescenceCluster, v : Double) -> GraphtreearborescenceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_cluster_min(s : GraphtreearborescenceCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_cluster_max(s : GraphtreearborescenceCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_cluster_to_string(s : GraphtreearborescenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_model_make(size : Int) -> GraphtreearborescenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_model_len(s : GraphtreearborescenceModel) -> Int { s.size }

pub fn graph_tree_arborescence_model_get(s : GraphtreearborescenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_model_set(s : GraphtreearborescenceModel, i : Int, v : Double) -> GraphtreearborescenceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_model_sum(s : GraphtreearborescenceModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_model_mean(s : GraphtreearborescenceModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_model_scale(s : GraphtreearborescenceModel, f : Double) -> GraphtreearborescenceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_model_add(a : GraphtreearborescenceModel, b : GraphtreearborescenceModel) -> GraphtreearborescenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_model_copy(s : GraphtreearborescenceModel) -> GraphtreearborescenceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_model_fill(s : GraphtreearborescenceModel, v : Double) -> GraphtreearborescenceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_model_min(s : GraphtreearborescenceModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_model_max(s : GraphtreearborescenceModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_model_to_string(s : GraphtreearborescenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_layer_make(size : Int) -> GraphtreearborescenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_layer_len(s : GraphtreearborescenceLayer) -> Int { s.size }

pub fn graph_tree_arborescence_layer_get(s : GraphtreearborescenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_layer_set(s : GraphtreearborescenceLayer, i : Int, v : Double) -> GraphtreearborescenceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_layer_sum(s : GraphtreearborescenceLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_layer_mean(s : GraphtreearborescenceLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_layer_scale(s : GraphtreearborescenceLayer, f : Double) -> GraphtreearborescenceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_layer_add(a : GraphtreearborescenceLayer, b : GraphtreearborescenceLayer) -> GraphtreearborescenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_layer_copy(s : GraphtreearborescenceLayer) -> GraphtreearborescenceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_layer_fill(s : GraphtreearborescenceLayer, v : Double) -> GraphtreearborescenceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_layer_min(s : GraphtreearborescenceLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_layer_max(s : GraphtreearborescenceLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_layer_to_string(s : GraphtreearborescenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_buffer_make(size : Int) -> GraphtreearborescenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_buffer_len(s : GraphtreearborescenceBuffer) -> Int { s.size }

pub fn graph_tree_arborescence_buffer_get(s : GraphtreearborescenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_buffer_set(s : GraphtreearborescenceBuffer, i : Int, v : Double) -> GraphtreearborescenceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_buffer_sum(s : GraphtreearborescenceBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_buffer_mean(s : GraphtreearborescenceBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_buffer_scale(s : GraphtreearborescenceBuffer, f : Double) -> GraphtreearborescenceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_buffer_add(a : GraphtreearborescenceBuffer, b : GraphtreearborescenceBuffer) -> GraphtreearborescenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_buffer_copy(s : GraphtreearborescenceBuffer) -> GraphtreearborescenceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_buffer_fill(s : GraphtreearborescenceBuffer, v : Double) -> GraphtreearborescenceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_buffer_min(s : GraphtreearborescenceBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_buffer_max(s : GraphtreearborescenceBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_buffer_to_string(s : GraphtreearborescenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_cursor_make(size : Int) -> GraphtreearborescenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_cursor_len(s : GraphtreearborescenceCursor) -> Int { s.size }

pub fn graph_tree_arborescence_cursor_get(s : GraphtreearborescenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_cursor_set(s : GraphtreearborescenceCursor, i : Int, v : Double) -> GraphtreearborescenceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_cursor_sum(s : GraphtreearborescenceCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_cursor_mean(s : GraphtreearborescenceCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_cursor_scale(s : GraphtreearborescenceCursor, f : Double) -> GraphtreearborescenceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_cursor_add(a : GraphtreearborescenceCursor, b : GraphtreearborescenceCursor) -> GraphtreearborescenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_cursor_copy(s : GraphtreearborescenceCursor) -> GraphtreearborescenceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_cursor_fill(s : GraphtreearborescenceCursor, v : Double) -> GraphtreearborescenceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_cursor_min(s : GraphtreearborescenceCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_cursor_max(s : GraphtreearborescenceCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_cursor_to_string(s : GraphtreearborescenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_view_make(size : Int) -> GraphtreearborescenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_view_len(s : GraphtreearborescenceView) -> Int { s.size }

pub fn graph_tree_arborescence_view_get(s : GraphtreearborescenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_view_set(s : GraphtreearborescenceView, i : Int, v : Double) -> GraphtreearborescenceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_view_sum(s : GraphtreearborescenceView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_view_mean(s : GraphtreearborescenceView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_view_scale(s : GraphtreearborescenceView, f : Double) -> GraphtreearborescenceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_view_add(a : GraphtreearborescenceView, b : GraphtreearborescenceView) -> GraphtreearborescenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_view_copy(s : GraphtreearborescenceView) -> GraphtreearborescenceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_view_fill(s : GraphtreearborescenceView, v : Double) -> GraphtreearborescenceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_view_min(s : GraphtreearborescenceView) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_view_max(s : GraphtreearborescenceView) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_view_to_string(s : GraphtreearborescenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_range_make(size : Int) -> GraphtreearborescenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_range_len(s : GraphtreearborescenceRange) -> Int { s.size }

pub fn graph_tree_arborescence_range_get(s : GraphtreearborescenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_range_set(s : GraphtreearborescenceRange, i : Int, v : Double) -> GraphtreearborescenceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_range_sum(s : GraphtreearborescenceRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_range_mean(s : GraphtreearborescenceRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_range_scale(s : GraphtreearborescenceRange, f : Double) -> GraphtreearborescenceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_range_add(a : GraphtreearborescenceRange, b : GraphtreearborescenceRange) -> GraphtreearborescenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_range_copy(s : GraphtreearborescenceRange) -> GraphtreearborescenceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_range_fill(s : GraphtreearborescenceRange, v : Double) -> GraphtreearborescenceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_range_min(s : GraphtreearborescenceRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_range_max(s : GraphtreearborescenceRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_range_to_string(s : GraphtreearborescenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_slice_make(size : Int) -> GraphtreearborescenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_slice_len(s : GraphtreearborescenceSlice) -> Int { s.size }

pub fn graph_tree_arborescence_slice_get(s : GraphtreearborescenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_slice_set(s : GraphtreearborescenceSlice, i : Int, v : Double) -> GraphtreearborescenceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_slice_sum(s : GraphtreearborescenceSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_arborescence_slice_mean(s : GraphtreearborescenceSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_arborescence_slice_scale(s : GraphtreearborescenceSlice, f : Double) -> GraphtreearborescenceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_slice_add(a : GraphtreearborescenceSlice, b : GraphtreearborescenceSlice) -> GraphtreearborescenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_arborescence_slice_copy(s : GraphtreearborescenceSlice) -> GraphtreearborescenceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_slice_fill(s : GraphtreearborescenceSlice, v : Double) -> GraphtreearborescenceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_arborescence_slice_min(s : GraphtreearborescenceSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_arborescence_slice_max(s : GraphtreearborescenceSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_arborescence_slice_to_string(s : GraphtreearborescenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

