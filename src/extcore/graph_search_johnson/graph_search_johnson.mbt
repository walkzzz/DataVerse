///===
/// extcore/graph_search_johnson

pub(all) struct GraphsearchjohnsonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_johnson_make_point(x : Double, y : Double) -> GraphsearchjohnsonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_johnson_make_point3(x : Double, y : Double, z : Double) -> GraphsearchjohnsonPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchjohnsonPoint::x(self : GraphsearchjohnsonPoint) -> Double { self.x }

pub fn GraphsearchjohnsonPoint::y(self : GraphsearchjohnsonPoint) -> Double { self.y }

pub fn GraphsearchjohnsonPoint::z(self : GraphsearchjohnsonPoint) -> Double { self.z }

pub fn GraphsearchjohnsonPoint::label(self : GraphsearchjohnsonPoint) -> Int { self.label }

pub fn GraphsearchjohnsonPoint::dist(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchjohnsonPoint::add(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchjohnsonPoint::sub(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchjohnsonPoint::scale(self : GraphsearchjohnsonPoint, s : Double) -> GraphsearchjohnsonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchjohnsonPoint::dot(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchjohnsonPoint::cross(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchjohnsonPoint::norm(self : GraphsearchjohnsonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchjohnsonPoint::normalize(self : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchjohnsonPoint::negate(self : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchjohnsonPoint::mid(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchjohnsonPoint::lerp(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint, t : Double) -> GraphsearchjohnsonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchjohnsonPoint::to_string(self : GraphsearchjohnsonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_johnson_make_series(vals : Array[Double], name : String) -> GraphsearchjohnsonSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchjohnsonSeries::len(self : GraphsearchjohnsonSeries) -> Int { self.vals.length() }

pub fn GraphsearchjohnsonSeries::sum(self : GraphsearchjohnsonSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchjohnsonSeries::mean(self : GraphsearchjohnsonSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchjohnsonSeries::min(self : GraphsearchjohnsonSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchjohnsonSeries::max(self : GraphsearchjohnsonSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchjohnsonSeries::range(self : GraphsearchjohnsonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchjohnsonSeries::variance(self : GraphsearchjohnsonSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchjohnsonSeries::std(self : GraphsearchjohnsonSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchjohnsonSeries::median(self : GraphsearchjohnsonSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchjohnsonSeries::scale(self : GraphsearchjohnsonSeries, f : Double) -> GraphsearchjohnsonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchjohnsonSeries::add(self : GraphsearchjohnsonSeries, other : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchjohnsonSeries::sub(self : GraphsearchjohnsonSeries, other : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchjohnsonSeries::normalize(self : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchjohnsonSeries::cumsum(self : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchjohnsonSeries::to_string(self : GraphsearchjohnsonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchjohnsonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_johnson_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchjohnsonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_johnson_matrix_identity(n : Int) -> GraphsearchjohnsonMatrix {
  let m = graph_search_johnson_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchjohnsonMatrix::get(self : GraphsearchjohnsonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchjohnsonMatrix::transpose(self : GraphsearchjohnsonMatrix) -> GraphsearchjohnsonMatrix {
  let result = graph_search_johnson_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchjohnsonMatrix::add(self : GraphsearchjohnsonMatrix, other : GraphsearchjohnsonMatrix) -> GraphsearchjohnsonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_johnson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchjohnsonMatrix::scale(self : GraphsearchjohnsonMatrix, s : Double) -> GraphsearchjohnsonMatrix {
  let result = graph_search_johnson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchjohnsonMatrix::multiply(self : GraphsearchjohnsonMatrix, other : GraphsearchjohnsonMatrix) -> GraphsearchjohnsonMatrix {
  if self.cols != other.rows { return graph_search_johnson_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_johnson_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchjohnsonMatrix::trace(self : GraphsearchjohnsonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchjohnsonMatrix::det(self : GraphsearchjohnsonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchjohnsonMatrix::norm(self : GraphsearchjohnsonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchjohnsonMatrix::to_string(self : GraphsearchjohnsonMatrix) -> String {
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

pub(all) struct GraphsearchjohnsonVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_johnson_make_vector(comps : Array[Double]) -> GraphsearchjohnsonVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_johnson_vector_zero(dim : Int) -> GraphsearchjohnsonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchjohnsonVector::add(self : GraphsearchjohnsonVector, other : GraphsearchjohnsonVector) -> GraphsearchjohnsonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchjohnsonVector::sub(self : GraphsearchjohnsonVector, other : GraphsearchjohnsonVector) -> GraphsearchjohnsonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchjohnsonVector::scale(self : GraphsearchjohnsonVector, s : Double) -> GraphsearchjohnsonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchjohnsonVector::dot(self : GraphsearchjohnsonVector, other : GraphsearchjohnsonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchjohnsonVector::norm(self : GraphsearchjohnsonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchjohnsonVector::normalize(self : GraphsearchjohnsonVector) -> GraphsearchjohnsonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchjohnsonVector::dist(self : GraphsearchjohnsonVector, other : GraphsearchjohnsonVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchjohnsonVector::to_string(self : GraphsearchjohnsonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_johnson_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_johnson_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_johnson_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_johnson_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_johnson_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_johnson_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_johnson_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_johnson_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_johnson_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_johnson_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_johnson_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_johnson_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_johnson_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_johnson_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_johnson_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_johnson_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_johnson_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_johnson_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_johnson_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_johnson_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_johnson_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_johnson_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_johnson_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_johnson_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_johnson_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_johnson_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_johnson_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_johnson_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_johnson_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchjohnsonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_frame_make(size : Int) -> GraphsearchjohnsonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonFrame::len(self : GraphsearchjohnsonFrame) -> Int { self.size }

pub fn GraphsearchjohnsonFrame::get(self : GraphsearchjohnsonFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonFrame::set(self : GraphsearchjohnsonFrame, i : Int, v : Double) -> GraphsearchjohnsonFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonFrame::sum(self : GraphsearchjohnsonFrame) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonFrame::mean(self : GraphsearchjohnsonFrame) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonFrame::scale(self : GraphsearchjohnsonFrame, f : Double) -> GraphsearchjohnsonFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonFrame::add(self : GraphsearchjohnsonFrame, other : GraphsearchjohnsonFrame) -> GraphsearchjohnsonFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonFrame::copy(self : GraphsearchjohnsonFrame) -> GraphsearchjohnsonFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonFrame::fill(self : GraphsearchjohnsonFrame, v : Double) -> GraphsearchjohnsonFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonFrame::min(self : GraphsearchjohnsonFrame) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonFrame::max(self : GraphsearchjohnsonFrame) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonFrame::to_string(self : GraphsearchjohnsonFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_table_make(size : Int) -> GraphsearchjohnsonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonTable::len(self : GraphsearchjohnsonTable) -> Int { self.size }

pub fn GraphsearchjohnsonTable::get(self : GraphsearchjohnsonTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonTable::set(self : GraphsearchjohnsonTable, i : Int, v : Double) -> GraphsearchjohnsonTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonTable::sum(self : GraphsearchjohnsonTable) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonTable::mean(self : GraphsearchjohnsonTable) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonTable::scale(self : GraphsearchjohnsonTable, f : Double) -> GraphsearchjohnsonTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonTable::add(self : GraphsearchjohnsonTable, other : GraphsearchjohnsonTable) -> GraphsearchjohnsonTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonTable::copy(self : GraphsearchjohnsonTable) -> GraphsearchjohnsonTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonTable::fill(self : GraphsearchjohnsonTable, v : Double) -> GraphsearchjohnsonTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonTable::min(self : GraphsearchjohnsonTable) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonTable::max(self : GraphsearchjohnsonTable) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonTable::to_string(self : GraphsearchjohnsonTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_graphn_make(size : Int) -> GraphsearchjohnsonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonGraphN::len(self : GraphsearchjohnsonGraphN) -> Int { self.size }

pub fn GraphsearchjohnsonGraphN::get(self : GraphsearchjohnsonGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonGraphN::set(self : GraphsearchjohnsonGraphN, i : Int, v : Double) -> GraphsearchjohnsonGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonGraphN::sum(self : GraphsearchjohnsonGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonGraphN::mean(self : GraphsearchjohnsonGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonGraphN::scale(self : GraphsearchjohnsonGraphN, f : Double) -> GraphsearchjohnsonGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonGraphN::add(self : GraphsearchjohnsonGraphN, other : GraphsearchjohnsonGraphN) -> GraphsearchjohnsonGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonGraphN::copy(self : GraphsearchjohnsonGraphN) -> GraphsearchjohnsonGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonGraphN::fill(self : GraphsearchjohnsonGraphN, v : Double) -> GraphsearchjohnsonGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonGraphN::min(self : GraphsearchjohnsonGraphN) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonGraphN::max(self : GraphsearchjohnsonGraphN) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonGraphN::to_string(self : GraphsearchjohnsonGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_node_make(size : Int) -> GraphsearchjohnsonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonNode::len(self : GraphsearchjohnsonNode) -> Int { self.size }

pub fn GraphsearchjohnsonNode::get(self : GraphsearchjohnsonNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonNode::set(self : GraphsearchjohnsonNode, i : Int, v : Double) -> GraphsearchjohnsonNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonNode::sum(self : GraphsearchjohnsonNode) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonNode::mean(self : GraphsearchjohnsonNode) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonNode::scale(self : GraphsearchjohnsonNode, f : Double) -> GraphsearchjohnsonNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonNode::add(self : GraphsearchjohnsonNode, other : GraphsearchjohnsonNode) -> GraphsearchjohnsonNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonNode::copy(self : GraphsearchjohnsonNode) -> GraphsearchjohnsonNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonNode::fill(self : GraphsearchjohnsonNode, v : Double) -> GraphsearchjohnsonNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonNode::min(self : GraphsearchjohnsonNode) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonNode::max(self : GraphsearchjohnsonNode) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonNode::to_string(self : GraphsearchjohnsonNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_edge_make(size : Int) -> GraphsearchjohnsonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonEdge::len(self : GraphsearchjohnsonEdge) -> Int { self.size }

pub fn GraphsearchjohnsonEdge::get(self : GraphsearchjohnsonEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonEdge::set(self : GraphsearchjohnsonEdge, i : Int, v : Double) -> GraphsearchjohnsonEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonEdge::sum(self : GraphsearchjohnsonEdge) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonEdge::mean(self : GraphsearchjohnsonEdge) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonEdge::scale(self : GraphsearchjohnsonEdge, f : Double) -> GraphsearchjohnsonEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonEdge::add(self : GraphsearchjohnsonEdge, other : GraphsearchjohnsonEdge) -> GraphsearchjohnsonEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonEdge::copy(self : GraphsearchjohnsonEdge) -> GraphsearchjohnsonEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonEdge::fill(self : GraphsearchjohnsonEdge, v : Double) -> GraphsearchjohnsonEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonEdge::min(self : GraphsearchjohnsonEdge) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonEdge::max(self : GraphsearchjohnsonEdge) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonEdge::to_string(self : GraphsearchjohnsonEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_path_make(size : Int) -> GraphsearchjohnsonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonPath::len(self : GraphsearchjohnsonPath) -> Int { self.size }

pub fn GraphsearchjohnsonPath::get(self : GraphsearchjohnsonPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonPath::set(self : GraphsearchjohnsonPath, i : Int, v : Double) -> GraphsearchjohnsonPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonPath::sum(self : GraphsearchjohnsonPath) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonPath::mean(self : GraphsearchjohnsonPath) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonPath::scale(self : GraphsearchjohnsonPath, f : Double) -> GraphsearchjohnsonPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonPath::add(self : GraphsearchjohnsonPath, other : GraphsearchjohnsonPath) -> GraphsearchjohnsonPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonPath::copy(self : GraphsearchjohnsonPath) -> GraphsearchjohnsonPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonPath::fill(self : GraphsearchjohnsonPath, v : Double) -> GraphsearchjohnsonPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonPath::min(self : GraphsearchjohnsonPath) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonPath::max(self : GraphsearchjohnsonPath) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonPath::to_string(self : GraphsearchjohnsonPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_cluster_make(size : Int) -> GraphsearchjohnsonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonCluster::len(self : GraphsearchjohnsonCluster) -> Int { self.size }

pub fn GraphsearchjohnsonCluster::get(self : GraphsearchjohnsonCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonCluster::set(self : GraphsearchjohnsonCluster, i : Int, v : Double) -> GraphsearchjohnsonCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonCluster::sum(self : GraphsearchjohnsonCluster) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonCluster::mean(self : GraphsearchjohnsonCluster) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonCluster::scale(self : GraphsearchjohnsonCluster, f : Double) -> GraphsearchjohnsonCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonCluster::add(self : GraphsearchjohnsonCluster, other : GraphsearchjohnsonCluster) -> GraphsearchjohnsonCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonCluster::copy(self : GraphsearchjohnsonCluster) -> GraphsearchjohnsonCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonCluster::fill(self : GraphsearchjohnsonCluster, v : Double) -> GraphsearchjohnsonCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonCluster::min(self : GraphsearchjohnsonCluster) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonCluster::max(self : GraphsearchjohnsonCluster) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonCluster::to_string(self : GraphsearchjohnsonCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_model_make(size : Int) -> GraphsearchjohnsonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonModel::len(self : GraphsearchjohnsonModel) -> Int { self.size }

pub fn GraphsearchjohnsonModel::get(self : GraphsearchjohnsonModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonModel::set(self : GraphsearchjohnsonModel, i : Int, v : Double) -> GraphsearchjohnsonModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonModel::sum(self : GraphsearchjohnsonModel) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonModel::mean(self : GraphsearchjohnsonModel) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonModel::scale(self : GraphsearchjohnsonModel, f : Double) -> GraphsearchjohnsonModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonModel::add(self : GraphsearchjohnsonModel, other : GraphsearchjohnsonModel) -> GraphsearchjohnsonModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonModel::copy(self : GraphsearchjohnsonModel) -> GraphsearchjohnsonModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonModel::fill(self : GraphsearchjohnsonModel, v : Double) -> GraphsearchjohnsonModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonModel::min(self : GraphsearchjohnsonModel) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonModel::max(self : GraphsearchjohnsonModel) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonModel::to_string(self : GraphsearchjohnsonModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_layer_make(size : Int) -> GraphsearchjohnsonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonLayer::len(self : GraphsearchjohnsonLayer) -> Int { self.size }

pub fn GraphsearchjohnsonLayer::get(self : GraphsearchjohnsonLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonLayer::set(self : GraphsearchjohnsonLayer, i : Int, v : Double) -> GraphsearchjohnsonLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonLayer::sum(self : GraphsearchjohnsonLayer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonLayer::mean(self : GraphsearchjohnsonLayer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonLayer::scale(self : GraphsearchjohnsonLayer, f : Double) -> GraphsearchjohnsonLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonLayer::add(self : GraphsearchjohnsonLayer, other : GraphsearchjohnsonLayer) -> GraphsearchjohnsonLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonLayer::copy(self : GraphsearchjohnsonLayer) -> GraphsearchjohnsonLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonLayer::fill(self : GraphsearchjohnsonLayer, v : Double) -> GraphsearchjohnsonLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonLayer::min(self : GraphsearchjohnsonLayer) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonLayer::max(self : GraphsearchjohnsonLayer) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonLayer::to_string(self : GraphsearchjohnsonLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_buffer_make(size : Int) -> GraphsearchjohnsonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonBuffer::len(self : GraphsearchjohnsonBuffer) -> Int { self.size }

pub fn GraphsearchjohnsonBuffer::get(self : GraphsearchjohnsonBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonBuffer::set(self : GraphsearchjohnsonBuffer, i : Int, v : Double) -> GraphsearchjohnsonBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonBuffer::sum(self : GraphsearchjohnsonBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonBuffer::mean(self : GraphsearchjohnsonBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonBuffer::scale(self : GraphsearchjohnsonBuffer, f : Double) -> GraphsearchjohnsonBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonBuffer::add(self : GraphsearchjohnsonBuffer, other : GraphsearchjohnsonBuffer) -> GraphsearchjohnsonBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonBuffer::copy(self : GraphsearchjohnsonBuffer) -> GraphsearchjohnsonBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonBuffer::fill(self : GraphsearchjohnsonBuffer, v : Double) -> GraphsearchjohnsonBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonBuffer::min(self : GraphsearchjohnsonBuffer) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonBuffer::max(self : GraphsearchjohnsonBuffer) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonBuffer::to_string(self : GraphsearchjohnsonBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_cursor_make(size : Int) -> GraphsearchjohnsonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonCursor::len(self : GraphsearchjohnsonCursor) -> Int { self.size }

pub fn GraphsearchjohnsonCursor::get(self : GraphsearchjohnsonCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonCursor::set(self : GraphsearchjohnsonCursor, i : Int, v : Double) -> GraphsearchjohnsonCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonCursor::sum(self : GraphsearchjohnsonCursor) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonCursor::mean(self : GraphsearchjohnsonCursor) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonCursor::scale(self : GraphsearchjohnsonCursor, f : Double) -> GraphsearchjohnsonCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonCursor::add(self : GraphsearchjohnsonCursor, other : GraphsearchjohnsonCursor) -> GraphsearchjohnsonCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonCursor::copy(self : GraphsearchjohnsonCursor) -> GraphsearchjohnsonCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonCursor::fill(self : GraphsearchjohnsonCursor, v : Double) -> GraphsearchjohnsonCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonCursor::min(self : GraphsearchjohnsonCursor) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonCursor::max(self : GraphsearchjohnsonCursor) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonCursor::to_string(self : GraphsearchjohnsonCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_view_make(size : Int) -> GraphsearchjohnsonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonView::len(self : GraphsearchjohnsonView) -> Int { self.size }

pub fn GraphsearchjohnsonView::get(self : GraphsearchjohnsonView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonView::set(self : GraphsearchjohnsonView, i : Int, v : Double) -> GraphsearchjohnsonView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonView::sum(self : GraphsearchjohnsonView) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonView::mean(self : GraphsearchjohnsonView) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonView::scale(self : GraphsearchjohnsonView, f : Double) -> GraphsearchjohnsonView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonView::add(self : GraphsearchjohnsonView, other : GraphsearchjohnsonView) -> GraphsearchjohnsonView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonView::copy(self : GraphsearchjohnsonView) -> GraphsearchjohnsonView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonView::fill(self : GraphsearchjohnsonView, v : Double) -> GraphsearchjohnsonView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonView::min(self : GraphsearchjohnsonView) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonView::max(self : GraphsearchjohnsonView) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonView::to_string(self : GraphsearchjohnsonView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_range_make(size : Int) -> GraphsearchjohnsonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonRange::len(self : GraphsearchjohnsonRange) -> Int { self.size }

pub fn GraphsearchjohnsonRange::get(self : GraphsearchjohnsonRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonRange::set(self : GraphsearchjohnsonRange, i : Int, v : Double) -> GraphsearchjohnsonRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonRange::sum(self : GraphsearchjohnsonRange) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonRange::mean(self : GraphsearchjohnsonRange) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonRange::scale(self : GraphsearchjohnsonRange, f : Double) -> GraphsearchjohnsonRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonRange::add(self : GraphsearchjohnsonRange, other : GraphsearchjohnsonRange) -> GraphsearchjohnsonRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonRange::copy(self : GraphsearchjohnsonRange) -> GraphsearchjohnsonRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonRange::fill(self : GraphsearchjohnsonRange, v : Double) -> GraphsearchjohnsonRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonRange::min(self : GraphsearchjohnsonRange) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonRange::max(self : GraphsearchjohnsonRange) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonRange::to_string(self : GraphsearchjohnsonRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_slice_make(size : Int) -> GraphsearchjohnsonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchjohnsonSlice::len(self : GraphsearchjohnsonSlice) -> Int { self.size }

pub fn GraphsearchjohnsonSlice::get(self : GraphsearchjohnsonSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchjohnsonSlice::set(self : GraphsearchjohnsonSlice, i : Int, v : Double) -> GraphsearchjohnsonSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonSlice::sum(self : GraphsearchjohnsonSlice) -> Double { @_common.sum(self.data) }

pub fn GraphsearchjohnsonSlice::mean(self : GraphsearchjohnsonSlice) -> Double { @_common.mean(self.data) }

pub fn GraphsearchjohnsonSlice::scale(self : GraphsearchjohnsonSlice, f : Double) -> GraphsearchjohnsonSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonSlice::add(self : GraphsearchjohnsonSlice, other : GraphsearchjohnsonSlice) -> GraphsearchjohnsonSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchjohnsonSlice::copy(self : GraphsearchjohnsonSlice) -> GraphsearchjohnsonSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonSlice::fill(self : GraphsearchjohnsonSlice, v : Double) -> GraphsearchjohnsonSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchjohnsonSlice::min(self : GraphsearchjohnsonSlice) -> Double { @_common.min(self.data) }

pub fn GraphsearchjohnsonSlice::max(self : GraphsearchjohnsonSlice) -> Double { @_common.max(self.data) }

pub fn GraphsearchjohnsonSlice::to_string(self : GraphsearchjohnsonSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

