///===
/// extcore/graph_search_bds

pub(all) struct GraphsearchbdsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_bds_make_point(x : Double, y : Double) -> GraphsearchbdsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_bds_make_point3(x : Double, y : Double, z : Double) -> GraphsearchbdsPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchbdsPoint::x(self : GraphsearchbdsPoint) -> Double { self.x }

pub fn GraphsearchbdsPoint::y(self : GraphsearchbdsPoint) -> Double { self.y }

pub fn GraphsearchbdsPoint::z(self : GraphsearchbdsPoint) -> Double { self.z }

pub fn GraphsearchbdsPoint::label(self : GraphsearchbdsPoint) -> Int { self.label }

pub fn GraphsearchbdsPoint::dist(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchbdsPoint::add(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchbdsPoint::sub(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchbdsPoint::scale(self : GraphsearchbdsPoint, s : Double) -> GraphsearchbdsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchbdsPoint::dot(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchbdsPoint::cross(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchbdsPoint::norm(self : GraphsearchbdsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchbdsPoint::normalize(self : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbdsPoint::negate(self : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchbdsPoint::mid(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchbdsPoint::lerp(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint, t : Double) -> GraphsearchbdsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchbdsPoint::to_string(self : GraphsearchbdsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchbdsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_bds_make_series(vals : Array[Double], name : String) -> GraphsearchbdsSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchbdsSeries::len(self : GraphsearchbdsSeries) -> Int { self.vals.length() }

pub fn GraphsearchbdsSeries::sum(self : GraphsearchbdsSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchbdsSeries::mean(self : GraphsearchbdsSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchbdsSeries::min(self : GraphsearchbdsSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchbdsSeries::max(self : GraphsearchbdsSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchbdsSeries::range(self : GraphsearchbdsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchbdsSeries::variance(self : GraphsearchbdsSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchbdsSeries::std(self : GraphsearchbdsSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchbdsSeries::median(self : GraphsearchbdsSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchbdsSeries::scale(self : GraphsearchbdsSeries, f : Double) -> GraphsearchbdsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchbdsSeries::add(self : GraphsearchbdsSeries, other : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchbdsSeries::sub(self : GraphsearchbdsSeries, other : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchbdsSeries::normalize(self : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchbdsSeries::cumsum(self : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchbdsSeries::to_string(self : GraphsearchbdsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbdsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_bds_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchbdsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_bds_matrix_identity(n : Int) -> GraphsearchbdsMatrix {
  let m = graph_search_bds_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchbdsMatrix::get(self : GraphsearchbdsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchbdsMatrix::transpose(self : GraphsearchbdsMatrix) -> GraphsearchbdsMatrix {
  let result = graph_search_bds_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchbdsMatrix::add(self : GraphsearchbdsMatrix, other : GraphsearchbdsMatrix) -> GraphsearchbdsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_bds_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchbdsMatrix::scale(self : GraphsearchbdsMatrix, s : Double) -> GraphsearchbdsMatrix {
  let result = graph_search_bds_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchbdsMatrix::multiply(self : GraphsearchbdsMatrix, other : GraphsearchbdsMatrix) -> GraphsearchbdsMatrix {
  if self.cols != other.rows { return graph_search_bds_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_bds_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchbdsMatrix::trace(self : GraphsearchbdsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchbdsMatrix::det(self : GraphsearchbdsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchbdsMatrix::norm(self : GraphsearchbdsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchbdsMatrix::to_string(self : GraphsearchbdsMatrix) -> String {
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

pub(all) struct GraphsearchbdsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_bds_make_vector(comps : Array[Double]) -> GraphsearchbdsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_bds_vector_zero(dim : Int) -> GraphsearchbdsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchbdsVector::add(self : GraphsearchbdsVector, other : GraphsearchbdsVector) -> GraphsearchbdsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbdsVector::sub(self : GraphsearchbdsVector, other : GraphsearchbdsVector) -> GraphsearchbdsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbdsVector::scale(self : GraphsearchbdsVector, s : Double) -> GraphsearchbdsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchbdsVector::dot(self : GraphsearchbdsVector, other : GraphsearchbdsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchbdsVector::norm(self : GraphsearchbdsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchbdsVector::normalize(self : GraphsearchbdsVector) -> GraphsearchbdsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbdsVector::dist(self : GraphsearchbdsVector, other : GraphsearchbdsVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchbdsVector::to_string(self : GraphsearchbdsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_bds_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_bds_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_bds_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_bds_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_bds_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_bds_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_bds_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_bds_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_bds_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_bds_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_bds_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_bds_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_bds_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_bds_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_bds_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_bds_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_bds_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_bds_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_bds_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_bds_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_bds_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_bds_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_bds_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_bds_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_bds_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_bds_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_bds_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_bds_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_bds_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchbdsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_frame_make(size : Int) -> GraphsearchbdsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsFrame::len(self : GraphsearchbdsFrame) -> Int { self.size }

pub fn GraphsearchbdsFrame::get(self : GraphsearchbdsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsFrame::set(self : GraphsearchbdsFrame, i : Int, v : Double) -> GraphsearchbdsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsFrame::sum(self : GraphsearchbdsFrame) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsFrame::mean(self : GraphsearchbdsFrame) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsFrame::scale(self : GraphsearchbdsFrame, f : Double) -> GraphsearchbdsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsFrame::add(self : GraphsearchbdsFrame, other : GraphsearchbdsFrame) -> GraphsearchbdsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsFrame::copy(self : GraphsearchbdsFrame) -> GraphsearchbdsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsFrame::fill(self : GraphsearchbdsFrame, v : Double) -> GraphsearchbdsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsFrame::min(self : GraphsearchbdsFrame) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsFrame::max(self : GraphsearchbdsFrame) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsFrame::to_string(self : GraphsearchbdsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_table_make(size : Int) -> GraphsearchbdsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsTable::len(self : GraphsearchbdsTable) -> Int { self.size }

pub fn GraphsearchbdsTable::get(self : GraphsearchbdsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsTable::set(self : GraphsearchbdsTable, i : Int, v : Double) -> GraphsearchbdsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsTable::sum(self : GraphsearchbdsTable) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsTable::mean(self : GraphsearchbdsTable) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsTable::scale(self : GraphsearchbdsTable, f : Double) -> GraphsearchbdsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsTable::add(self : GraphsearchbdsTable, other : GraphsearchbdsTable) -> GraphsearchbdsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsTable::copy(self : GraphsearchbdsTable) -> GraphsearchbdsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsTable::fill(self : GraphsearchbdsTable, v : Double) -> GraphsearchbdsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsTable::min(self : GraphsearchbdsTable) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsTable::max(self : GraphsearchbdsTable) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsTable::to_string(self : GraphsearchbdsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_graphn_make(size : Int) -> GraphsearchbdsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsGraphN::len(self : GraphsearchbdsGraphN) -> Int { self.size }

pub fn GraphsearchbdsGraphN::get(self : GraphsearchbdsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsGraphN::set(self : GraphsearchbdsGraphN, i : Int, v : Double) -> GraphsearchbdsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsGraphN::sum(self : GraphsearchbdsGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsGraphN::mean(self : GraphsearchbdsGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsGraphN::scale(self : GraphsearchbdsGraphN, f : Double) -> GraphsearchbdsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsGraphN::add(self : GraphsearchbdsGraphN, other : GraphsearchbdsGraphN) -> GraphsearchbdsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsGraphN::copy(self : GraphsearchbdsGraphN) -> GraphsearchbdsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsGraphN::fill(self : GraphsearchbdsGraphN, v : Double) -> GraphsearchbdsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsGraphN::min(self : GraphsearchbdsGraphN) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsGraphN::max(self : GraphsearchbdsGraphN) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsGraphN::to_string(self : GraphsearchbdsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_node_make(size : Int) -> GraphsearchbdsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsNode::len(self : GraphsearchbdsNode) -> Int { self.size }

pub fn GraphsearchbdsNode::get(self : GraphsearchbdsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsNode::set(self : GraphsearchbdsNode, i : Int, v : Double) -> GraphsearchbdsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsNode::sum(self : GraphsearchbdsNode) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsNode::mean(self : GraphsearchbdsNode) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsNode::scale(self : GraphsearchbdsNode, f : Double) -> GraphsearchbdsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsNode::add(self : GraphsearchbdsNode, other : GraphsearchbdsNode) -> GraphsearchbdsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsNode::copy(self : GraphsearchbdsNode) -> GraphsearchbdsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsNode::fill(self : GraphsearchbdsNode, v : Double) -> GraphsearchbdsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsNode::min(self : GraphsearchbdsNode) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsNode::max(self : GraphsearchbdsNode) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsNode::to_string(self : GraphsearchbdsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_edge_make(size : Int) -> GraphsearchbdsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsEdge::len(self : GraphsearchbdsEdge) -> Int { self.size }

pub fn GraphsearchbdsEdge::get(self : GraphsearchbdsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsEdge::set(self : GraphsearchbdsEdge, i : Int, v : Double) -> GraphsearchbdsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsEdge::sum(self : GraphsearchbdsEdge) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsEdge::mean(self : GraphsearchbdsEdge) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsEdge::scale(self : GraphsearchbdsEdge, f : Double) -> GraphsearchbdsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsEdge::add(self : GraphsearchbdsEdge, other : GraphsearchbdsEdge) -> GraphsearchbdsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsEdge::copy(self : GraphsearchbdsEdge) -> GraphsearchbdsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsEdge::fill(self : GraphsearchbdsEdge, v : Double) -> GraphsearchbdsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsEdge::min(self : GraphsearchbdsEdge) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsEdge::max(self : GraphsearchbdsEdge) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsEdge::to_string(self : GraphsearchbdsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_path_make(size : Int) -> GraphsearchbdsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsPath::len(self : GraphsearchbdsPath) -> Int { self.size }

pub fn GraphsearchbdsPath::get(self : GraphsearchbdsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsPath::set(self : GraphsearchbdsPath, i : Int, v : Double) -> GraphsearchbdsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsPath::sum(self : GraphsearchbdsPath) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsPath::mean(self : GraphsearchbdsPath) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsPath::scale(self : GraphsearchbdsPath, f : Double) -> GraphsearchbdsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsPath::add(self : GraphsearchbdsPath, other : GraphsearchbdsPath) -> GraphsearchbdsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsPath::copy(self : GraphsearchbdsPath) -> GraphsearchbdsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsPath::fill(self : GraphsearchbdsPath, v : Double) -> GraphsearchbdsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsPath::min(self : GraphsearchbdsPath) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsPath::max(self : GraphsearchbdsPath) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsPath::to_string(self : GraphsearchbdsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_cluster_make(size : Int) -> GraphsearchbdsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsCluster::len(self : GraphsearchbdsCluster) -> Int { self.size }

pub fn GraphsearchbdsCluster::get(self : GraphsearchbdsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsCluster::set(self : GraphsearchbdsCluster, i : Int, v : Double) -> GraphsearchbdsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsCluster::sum(self : GraphsearchbdsCluster) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsCluster::mean(self : GraphsearchbdsCluster) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsCluster::scale(self : GraphsearchbdsCluster, f : Double) -> GraphsearchbdsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsCluster::add(self : GraphsearchbdsCluster, other : GraphsearchbdsCluster) -> GraphsearchbdsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsCluster::copy(self : GraphsearchbdsCluster) -> GraphsearchbdsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsCluster::fill(self : GraphsearchbdsCluster, v : Double) -> GraphsearchbdsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsCluster::min(self : GraphsearchbdsCluster) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsCluster::max(self : GraphsearchbdsCluster) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsCluster::to_string(self : GraphsearchbdsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_model_make(size : Int) -> GraphsearchbdsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsModel::len(self : GraphsearchbdsModel) -> Int { self.size }

pub fn GraphsearchbdsModel::get(self : GraphsearchbdsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsModel::set(self : GraphsearchbdsModel, i : Int, v : Double) -> GraphsearchbdsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsModel::sum(self : GraphsearchbdsModel) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsModel::mean(self : GraphsearchbdsModel) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsModel::scale(self : GraphsearchbdsModel, f : Double) -> GraphsearchbdsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsModel::add(self : GraphsearchbdsModel, other : GraphsearchbdsModel) -> GraphsearchbdsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsModel::copy(self : GraphsearchbdsModel) -> GraphsearchbdsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsModel::fill(self : GraphsearchbdsModel, v : Double) -> GraphsearchbdsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsModel::min(self : GraphsearchbdsModel) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsModel::max(self : GraphsearchbdsModel) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsModel::to_string(self : GraphsearchbdsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_layer_make(size : Int) -> GraphsearchbdsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsLayer::len(self : GraphsearchbdsLayer) -> Int { self.size }

pub fn GraphsearchbdsLayer::get(self : GraphsearchbdsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsLayer::set(self : GraphsearchbdsLayer, i : Int, v : Double) -> GraphsearchbdsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsLayer::sum(self : GraphsearchbdsLayer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsLayer::mean(self : GraphsearchbdsLayer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsLayer::scale(self : GraphsearchbdsLayer, f : Double) -> GraphsearchbdsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsLayer::add(self : GraphsearchbdsLayer, other : GraphsearchbdsLayer) -> GraphsearchbdsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsLayer::copy(self : GraphsearchbdsLayer) -> GraphsearchbdsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsLayer::fill(self : GraphsearchbdsLayer, v : Double) -> GraphsearchbdsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsLayer::min(self : GraphsearchbdsLayer) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsLayer::max(self : GraphsearchbdsLayer) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsLayer::to_string(self : GraphsearchbdsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_buffer_make(size : Int) -> GraphsearchbdsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsBuffer::len(self : GraphsearchbdsBuffer) -> Int { self.size }

pub fn GraphsearchbdsBuffer::get(self : GraphsearchbdsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsBuffer::set(self : GraphsearchbdsBuffer, i : Int, v : Double) -> GraphsearchbdsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsBuffer::sum(self : GraphsearchbdsBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsBuffer::mean(self : GraphsearchbdsBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsBuffer::scale(self : GraphsearchbdsBuffer, f : Double) -> GraphsearchbdsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsBuffer::add(self : GraphsearchbdsBuffer, other : GraphsearchbdsBuffer) -> GraphsearchbdsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsBuffer::copy(self : GraphsearchbdsBuffer) -> GraphsearchbdsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsBuffer::fill(self : GraphsearchbdsBuffer, v : Double) -> GraphsearchbdsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsBuffer::min(self : GraphsearchbdsBuffer) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsBuffer::max(self : GraphsearchbdsBuffer) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsBuffer::to_string(self : GraphsearchbdsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_cursor_make(size : Int) -> GraphsearchbdsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsCursor::len(self : GraphsearchbdsCursor) -> Int { self.size }

pub fn GraphsearchbdsCursor::get(self : GraphsearchbdsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsCursor::set(self : GraphsearchbdsCursor, i : Int, v : Double) -> GraphsearchbdsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsCursor::sum(self : GraphsearchbdsCursor) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsCursor::mean(self : GraphsearchbdsCursor) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsCursor::scale(self : GraphsearchbdsCursor, f : Double) -> GraphsearchbdsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsCursor::add(self : GraphsearchbdsCursor, other : GraphsearchbdsCursor) -> GraphsearchbdsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsCursor::copy(self : GraphsearchbdsCursor) -> GraphsearchbdsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsCursor::fill(self : GraphsearchbdsCursor, v : Double) -> GraphsearchbdsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsCursor::min(self : GraphsearchbdsCursor) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsCursor::max(self : GraphsearchbdsCursor) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsCursor::to_string(self : GraphsearchbdsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_view_make(size : Int) -> GraphsearchbdsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsView::len(self : GraphsearchbdsView) -> Int { self.size }

pub fn GraphsearchbdsView::get(self : GraphsearchbdsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsView::set(self : GraphsearchbdsView, i : Int, v : Double) -> GraphsearchbdsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsView::sum(self : GraphsearchbdsView) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsView::mean(self : GraphsearchbdsView) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsView::scale(self : GraphsearchbdsView, f : Double) -> GraphsearchbdsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsView::add(self : GraphsearchbdsView, other : GraphsearchbdsView) -> GraphsearchbdsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsView::copy(self : GraphsearchbdsView) -> GraphsearchbdsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsView::fill(self : GraphsearchbdsView, v : Double) -> GraphsearchbdsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsView::min(self : GraphsearchbdsView) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsView::max(self : GraphsearchbdsView) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsView::to_string(self : GraphsearchbdsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_range_make(size : Int) -> GraphsearchbdsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsRange::len(self : GraphsearchbdsRange) -> Int { self.size }

pub fn GraphsearchbdsRange::get(self : GraphsearchbdsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsRange::set(self : GraphsearchbdsRange, i : Int, v : Double) -> GraphsearchbdsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsRange::sum(self : GraphsearchbdsRange) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsRange::mean(self : GraphsearchbdsRange) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsRange::scale(self : GraphsearchbdsRange, f : Double) -> GraphsearchbdsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsRange::add(self : GraphsearchbdsRange, other : GraphsearchbdsRange) -> GraphsearchbdsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsRange::copy(self : GraphsearchbdsRange) -> GraphsearchbdsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsRange::fill(self : GraphsearchbdsRange, v : Double) -> GraphsearchbdsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsRange::min(self : GraphsearchbdsRange) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsRange::max(self : GraphsearchbdsRange) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsRange::to_string(self : GraphsearchbdsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_slice_make(size : Int) -> GraphsearchbdsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbdsSlice::len(self : GraphsearchbdsSlice) -> Int { self.size }

pub fn GraphsearchbdsSlice::get(self : GraphsearchbdsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbdsSlice::set(self : GraphsearchbdsSlice, i : Int, v : Double) -> GraphsearchbdsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsSlice::sum(self : GraphsearchbdsSlice) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbdsSlice::mean(self : GraphsearchbdsSlice) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbdsSlice::scale(self : GraphsearchbdsSlice, f : Double) -> GraphsearchbdsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsSlice::add(self : GraphsearchbdsSlice, other : GraphsearchbdsSlice) -> GraphsearchbdsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbdsSlice::copy(self : GraphsearchbdsSlice) -> GraphsearchbdsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsSlice::fill(self : GraphsearchbdsSlice, v : Double) -> GraphsearchbdsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbdsSlice::min(self : GraphsearchbdsSlice) -> Double { @_common.min(self.data) }

pub fn GraphsearchbdsSlice::max(self : GraphsearchbdsSlice) -> Double { @_common.max(self.data) }

pub fn GraphsearchbdsSlice::to_string(self : GraphsearchbdsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

