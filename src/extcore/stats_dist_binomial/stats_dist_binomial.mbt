///===
/// extcore/stats_dist_binomial

pub(all) struct StatsdistbinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_binomial_make_point(x : Double, y : Double) -> StatsdistbinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_binomial_make_point3(x : Double, y : Double, z : Double) -> StatsdistbinomialPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistbinomialPoint::x(self : StatsdistbinomialPoint) -> Double { self.x }

pub fn StatsdistbinomialPoint::y(self : StatsdistbinomialPoint) -> Double { self.y }

pub fn StatsdistbinomialPoint::z(self : StatsdistbinomialPoint) -> Double { self.z }

pub fn StatsdistbinomialPoint::label(self : StatsdistbinomialPoint) -> Int { self.label }

pub fn StatsdistbinomialPoint::dist(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistbinomialPoint::add(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistbinomialPoint::sub(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistbinomialPoint::scale(self : StatsdistbinomialPoint, s : Double) -> StatsdistbinomialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistbinomialPoint::dot(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistbinomialPoint::cross(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistbinomialPoint::norm(self : StatsdistbinomialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistbinomialPoint::normalize(self : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistbinomialPoint::negate(self : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistbinomialPoint::mid(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint) -> StatsdistbinomialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistbinomialPoint::lerp(self : StatsdistbinomialPoint, other : StatsdistbinomialPoint, t : Double) -> StatsdistbinomialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistbinomialPoint::to_string(self : StatsdistbinomialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistbinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_binomial_make_series(vals : Array[Double], name : String) -> StatsdistbinomialSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistbinomialSeries::len(self : StatsdistbinomialSeries) -> Int { self.vals.length() }

pub fn StatsdistbinomialSeries::sum(self : StatsdistbinomialSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistbinomialSeries::mean(self : StatsdistbinomialSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistbinomialSeries::min(self : StatsdistbinomialSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistbinomialSeries::max(self : StatsdistbinomialSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistbinomialSeries::range(self : StatsdistbinomialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistbinomialSeries::variance(self : StatsdistbinomialSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistbinomialSeries::std(self : StatsdistbinomialSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistbinomialSeries::median(self : StatsdistbinomialSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistbinomialSeries::scale(self : StatsdistbinomialSeries, f : Double) -> StatsdistbinomialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistbinomialSeries::add(self : StatsdistbinomialSeries, other : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistbinomialSeries::sub(self : StatsdistbinomialSeries, other : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistbinomialSeries::normalize(self : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistbinomialSeries::cumsum(self : StatsdistbinomialSeries) -> StatsdistbinomialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistbinomialSeries::to_string(self : StatsdistbinomialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistbinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_binomial_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistbinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_binomial_matrix_identity(n : Int) -> StatsdistbinomialMatrix {
  let m = stats_dist_binomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistbinomialMatrix::get(self : StatsdistbinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistbinomialMatrix::transpose(self : StatsdistbinomialMatrix) -> StatsdistbinomialMatrix {
  let result = stats_dist_binomial_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistbinomialMatrix::add(self : StatsdistbinomialMatrix, other : StatsdistbinomialMatrix) -> StatsdistbinomialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistbinomialMatrix::scale(self : StatsdistbinomialMatrix, s : Double) -> StatsdistbinomialMatrix {
  let result = stats_dist_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistbinomialMatrix::multiply(self : StatsdistbinomialMatrix, other : StatsdistbinomialMatrix) -> StatsdistbinomialMatrix {
  if self.cols != other.rows { return stats_dist_binomial_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_binomial_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistbinomialMatrix::trace(self : StatsdistbinomialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistbinomialMatrix::det(self : StatsdistbinomialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistbinomialMatrix::norm(self : StatsdistbinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistbinomialMatrix::to_string(self : StatsdistbinomialMatrix) -> String {
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

pub(all) struct StatsdistbinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_binomial_make_vector(comps : Array[Double]) -> StatsdistbinomialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_binomial_vector_zero(dim : Int) -> StatsdistbinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistbinomialVector::add(self : StatsdistbinomialVector, other : StatsdistbinomialVector) -> StatsdistbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistbinomialVector::sub(self : StatsdistbinomialVector, other : StatsdistbinomialVector) -> StatsdistbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistbinomialVector::scale(self : StatsdistbinomialVector, s : Double) -> StatsdistbinomialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistbinomialVector::dot(self : StatsdistbinomialVector, other : StatsdistbinomialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistbinomialVector::norm(self : StatsdistbinomialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistbinomialVector::normalize(self : StatsdistbinomialVector) -> StatsdistbinomialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistbinomialVector::dist(self : StatsdistbinomialVector, other : StatsdistbinomialVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistbinomialVector::to_string(self : StatsdistbinomialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistbinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_frame_make(size : Int) -> StatsdistbinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialFrame::len(self : StatsdistbinomialFrame) -> Int { self.size }

pub fn StatsdistbinomialFrame::get(self : StatsdistbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialFrame::set(self : StatsdistbinomialFrame, i : Int, v : Double) -> StatsdistbinomialFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialFrame::sum(self : StatsdistbinomialFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialFrame::mean(self : StatsdistbinomialFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialFrame::scale(self : StatsdistbinomialFrame, f : Double) -> StatsdistbinomialFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialFrame::add(self : StatsdistbinomialFrame, other : StatsdistbinomialFrame) -> StatsdistbinomialFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialFrame::copy(self : StatsdistbinomialFrame) -> StatsdistbinomialFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialFrame::fill(self : StatsdistbinomialFrame, v : Double) -> StatsdistbinomialFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialFrame::min(self : StatsdistbinomialFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialFrame::max(self : StatsdistbinomialFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialFrame::to_string(self : StatsdistbinomialFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_table_make(size : Int) -> StatsdistbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialTable::len(self : StatsdistbinomialTable) -> Int { self.size }

pub fn StatsdistbinomialTable::get(self : StatsdistbinomialTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialTable::set(self : StatsdistbinomialTable, i : Int, v : Double) -> StatsdistbinomialTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialTable::sum(self : StatsdistbinomialTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialTable::mean(self : StatsdistbinomialTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialTable::scale(self : StatsdistbinomialTable, f : Double) -> StatsdistbinomialTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialTable::add(self : StatsdistbinomialTable, other : StatsdistbinomialTable) -> StatsdistbinomialTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialTable::copy(self : StatsdistbinomialTable) -> StatsdistbinomialTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialTable::fill(self : StatsdistbinomialTable, v : Double) -> StatsdistbinomialTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialTable::min(self : StatsdistbinomialTable) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialTable::max(self : StatsdistbinomialTable) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialTable::to_string(self : StatsdistbinomialTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_graphn_make(size : Int) -> StatsdistbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialGraphN::len(self : StatsdistbinomialGraphN) -> Int { self.size }

pub fn StatsdistbinomialGraphN::get(self : StatsdistbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialGraphN::set(self : StatsdistbinomialGraphN, i : Int, v : Double) -> StatsdistbinomialGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialGraphN::sum(self : StatsdistbinomialGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialGraphN::mean(self : StatsdistbinomialGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialGraphN::scale(self : StatsdistbinomialGraphN, f : Double) -> StatsdistbinomialGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialGraphN::add(self : StatsdistbinomialGraphN, other : StatsdistbinomialGraphN) -> StatsdistbinomialGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialGraphN::copy(self : StatsdistbinomialGraphN) -> StatsdistbinomialGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialGraphN::fill(self : StatsdistbinomialGraphN, v : Double) -> StatsdistbinomialGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialGraphN::min(self : StatsdistbinomialGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialGraphN::max(self : StatsdistbinomialGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialGraphN::to_string(self : StatsdistbinomialGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_node_make(size : Int) -> StatsdistbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialNode::len(self : StatsdistbinomialNode) -> Int { self.size }

pub fn StatsdistbinomialNode::get(self : StatsdistbinomialNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialNode::set(self : StatsdistbinomialNode, i : Int, v : Double) -> StatsdistbinomialNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialNode::sum(self : StatsdistbinomialNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialNode::mean(self : StatsdistbinomialNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialNode::scale(self : StatsdistbinomialNode, f : Double) -> StatsdistbinomialNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialNode::add(self : StatsdistbinomialNode, other : StatsdistbinomialNode) -> StatsdistbinomialNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialNode::copy(self : StatsdistbinomialNode) -> StatsdistbinomialNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialNode::fill(self : StatsdistbinomialNode, v : Double) -> StatsdistbinomialNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialNode::min(self : StatsdistbinomialNode) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialNode::max(self : StatsdistbinomialNode) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialNode::to_string(self : StatsdistbinomialNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_edge_make(size : Int) -> StatsdistbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialEdge::len(self : StatsdistbinomialEdge) -> Int { self.size }

pub fn StatsdistbinomialEdge::get(self : StatsdistbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialEdge::set(self : StatsdistbinomialEdge, i : Int, v : Double) -> StatsdistbinomialEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialEdge::sum(self : StatsdistbinomialEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialEdge::mean(self : StatsdistbinomialEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialEdge::scale(self : StatsdistbinomialEdge, f : Double) -> StatsdistbinomialEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialEdge::add(self : StatsdistbinomialEdge, other : StatsdistbinomialEdge) -> StatsdistbinomialEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialEdge::copy(self : StatsdistbinomialEdge) -> StatsdistbinomialEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialEdge::fill(self : StatsdistbinomialEdge, v : Double) -> StatsdistbinomialEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialEdge::min(self : StatsdistbinomialEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialEdge::max(self : StatsdistbinomialEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialEdge::to_string(self : StatsdistbinomialEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_path_make(size : Int) -> StatsdistbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialPath::len(self : StatsdistbinomialPath) -> Int { self.size }

pub fn StatsdistbinomialPath::get(self : StatsdistbinomialPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialPath::set(self : StatsdistbinomialPath, i : Int, v : Double) -> StatsdistbinomialPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialPath::sum(self : StatsdistbinomialPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialPath::mean(self : StatsdistbinomialPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialPath::scale(self : StatsdistbinomialPath, f : Double) -> StatsdistbinomialPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialPath::add(self : StatsdistbinomialPath, other : StatsdistbinomialPath) -> StatsdistbinomialPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialPath::copy(self : StatsdistbinomialPath) -> StatsdistbinomialPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialPath::fill(self : StatsdistbinomialPath, v : Double) -> StatsdistbinomialPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialPath::min(self : StatsdistbinomialPath) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialPath::max(self : StatsdistbinomialPath) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialPath::to_string(self : StatsdistbinomialPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_cluster_make(size : Int) -> StatsdistbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialCluster::len(self : StatsdistbinomialCluster) -> Int { self.size }

pub fn StatsdistbinomialCluster::get(self : StatsdistbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialCluster::set(self : StatsdistbinomialCluster, i : Int, v : Double) -> StatsdistbinomialCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialCluster::sum(self : StatsdistbinomialCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialCluster::mean(self : StatsdistbinomialCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialCluster::scale(self : StatsdistbinomialCluster, f : Double) -> StatsdistbinomialCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialCluster::add(self : StatsdistbinomialCluster, other : StatsdistbinomialCluster) -> StatsdistbinomialCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialCluster::copy(self : StatsdistbinomialCluster) -> StatsdistbinomialCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialCluster::fill(self : StatsdistbinomialCluster, v : Double) -> StatsdistbinomialCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialCluster::min(self : StatsdistbinomialCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialCluster::max(self : StatsdistbinomialCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialCluster::to_string(self : StatsdistbinomialCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_model_make(size : Int) -> StatsdistbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialModel::len(self : StatsdistbinomialModel) -> Int { self.size }

pub fn StatsdistbinomialModel::get(self : StatsdistbinomialModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialModel::set(self : StatsdistbinomialModel, i : Int, v : Double) -> StatsdistbinomialModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialModel::sum(self : StatsdistbinomialModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialModel::mean(self : StatsdistbinomialModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialModel::scale(self : StatsdistbinomialModel, f : Double) -> StatsdistbinomialModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialModel::add(self : StatsdistbinomialModel, other : StatsdistbinomialModel) -> StatsdistbinomialModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialModel::copy(self : StatsdistbinomialModel) -> StatsdistbinomialModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialModel::fill(self : StatsdistbinomialModel, v : Double) -> StatsdistbinomialModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialModel::min(self : StatsdistbinomialModel) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialModel::max(self : StatsdistbinomialModel) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialModel::to_string(self : StatsdistbinomialModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_layer_make(size : Int) -> StatsdistbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialLayer::len(self : StatsdistbinomialLayer) -> Int { self.size }

pub fn StatsdistbinomialLayer::get(self : StatsdistbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialLayer::set(self : StatsdistbinomialLayer, i : Int, v : Double) -> StatsdistbinomialLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialLayer::sum(self : StatsdistbinomialLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialLayer::mean(self : StatsdistbinomialLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialLayer::scale(self : StatsdistbinomialLayer, f : Double) -> StatsdistbinomialLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialLayer::add(self : StatsdistbinomialLayer, other : StatsdistbinomialLayer) -> StatsdistbinomialLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialLayer::copy(self : StatsdistbinomialLayer) -> StatsdistbinomialLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialLayer::fill(self : StatsdistbinomialLayer, v : Double) -> StatsdistbinomialLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialLayer::min(self : StatsdistbinomialLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialLayer::max(self : StatsdistbinomialLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialLayer::to_string(self : StatsdistbinomialLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_buffer_make(size : Int) -> StatsdistbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialBuffer::len(self : StatsdistbinomialBuffer) -> Int { self.size }

pub fn StatsdistbinomialBuffer::get(self : StatsdistbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialBuffer::set(self : StatsdistbinomialBuffer, i : Int, v : Double) -> StatsdistbinomialBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialBuffer::sum(self : StatsdistbinomialBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialBuffer::mean(self : StatsdistbinomialBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialBuffer::scale(self : StatsdistbinomialBuffer, f : Double) -> StatsdistbinomialBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialBuffer::add(self : StatsdistbinomialBuffer, other : StatsdistbinomialBuffer) -> StatsdistbinomialBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialBuffer::copy(self : StatsdistbinomialBuffer) -> StatsdistbinomialBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialBuffer::fill(self : StatsdistbinomialBuffer, v : Double) -> StatsdistbinomialBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialBuffer::min(self : StatsdistbinomialBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialBuffer::max(self : StatsdistbinomialBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialBuffer::to_string(self : StatsdistbinomialBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_cursor_make(size : Int) -> StatsdistbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialCursor::len(self : StatsdistbinomialCursor) -> Int { self.size }

pub fn StatsdistbinomialCursor::get(self : StatsdistbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialCursor::set(self : StatsdistbinomialCursor, i : Int, v : Double) -> StatsdistbinomialCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialCursor::sum(self : StatsdistbinomialCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialCursor::mean(self : StatsdistbinomialCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialCursor::scale(self : StatsdistbinomialCursor, f : Double) -> StatsdistbinomialCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialCursor::add(self : StatsdistbinomialCursor, other : StatsdistbinomialCursor) -> StatsdistbinomialCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialCursor::copy(self : StatsdistbinomialCursor) -> StatsdistbinomialCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialCursor::fill(self : StatsdistbinomialCursor, v : Double) -> StatsdistbinomialCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialCursor::min(self : StatsdistbinomialCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialCursor::max(self : StatsdistbinomialCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialCursor::to_string(self : StatsdistbinomialCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_view_make(size : Int) -> StatsdistbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialView::len(self : StatsdistbinomialView) -> Int { self.size }

pub fn StatsdistbinomialView::get(self : StatsdistbinomialView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialView::set(self : StatsdistbinomialView, i : Int, v : Double) -> StatsdistbinomialView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialView::sum(self : StatsdistbinomialView) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialView::mean(self : StatsdistbinomialView) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialView::scale(self : StatsdistbinomialView, f : Double) -> StatsdistbinomialView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialView::add(self : StatsdistbinomialView, other : StatsdistbinomialView) -> StatsdistbinomialView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialView::copy(self : StatsdistbinomialView) -> StatsdistbinomialView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialView::fill(self : StatsdistbinomialView, v : Double) -> StatsdistbinomialView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialView::min(self : StatsdistbinomialView) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialView::max(self : StatsdistbinomialView) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialView::to_string(self : StatsdistbinomialView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_range_make(size : Int) -> StatsdistbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialRange::len(self : StatsdistbinomialRange) -> Int { self.size }

pub fn StatsdistbinomialRange::get(self : StatsdistbinomialRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialRange::set(self : StatsdistbinomialRange, i : Int, v : Double) -> StatsdistbinomialRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialRange::sum(self : StatsdistbinomialRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialRange::mean(self : StatsdistbinomialRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialRange::scale(self : StatsdistbinomialRange, f : Double) -> StatsdistbinomialRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialRange::add(self : StatsdistbinomialRange, other : StatsdistbinomialRange) -> StatsdistbinomialRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialRange::copy(self : StatsdistbinomialRange) -> StatsdistbinomialRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialRange::fill(self : StatsdistbinomialRange, v : Double) -> StatsdistbinomialRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialRange::min(self : StatsdistbinomialRange) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialRange::max(self : StatsdistbinomialRange) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialRange::to_string(self : StatsdistbinomialRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_binomial_slice_make(size : Int) -> StatsdistbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistbinomialSlice::len(self : StatsdistbinomialSlice) -> Int { self.size }

pub fn StatsdistbinomialSlice::get(self : StatsdistbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistbinomialSlice::set(self : StatsdistbinomialSlice, i : Int, v : Double) -> StatsdistbinomialSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialSlice::sum(self : StatsdistbinomialSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistbinomialSlice::mean(self : StatsdistbinomialSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistbinomialSlice::scale(self : StatsdistbinomialSlice, f : Double) -> StatsdistbinomialSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialSlice::add(self : StatsdistbinomialSlice, other : StatsdistbinomialSlice) -> StatsdistbinomialSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistbinomialSlice::copy(self : StatsdistbinomialSlice) -> StatsdistbinomialSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialSlice::fill(self : StatsdistbinomialSlice, v : Double) -> StatsdistbinomialSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistbinomialSlice::min(self : StatsdistbinomialSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistbinomialSlice::max(self : StatsdistbinomialSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistbinomialSlice::to_string(self : StatsdistbinomialSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

