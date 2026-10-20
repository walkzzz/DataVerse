///===
/// extcore/stats_infer_bayesian

pub(all) struct StatsinferbayesianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_bayesian_make_point(x : Double, y : Double) -> StatsinferbayesianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_bayesian_make_point3(x : Double, y : Double, z : Double) -> StatsinferbayesianPoint {
  { x, y, z, label: 0 }
}

pub fn StatsinferbayesianPoint::x(self : StatsinferbayesianPoint) -> Double { self.x }

pub fn StatsinferbayesianPoint::y(self : StatsinferbayesianPoint) -> Double { self.y }

pub fn StatsinferbayesianPoint::z(self : StatsinferbayesianPoint) -> Double { self.z }

pub fn StatsinferbayesianPoint::label(self : StatsinferbayesianPoint) -> Int { self.label }

pub fn StatsinferbayesianPoint::dist(self : StatsinferbayesianPoint, other : StatsinferbayesianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsinferbayesianPoint::add(self : StatsinferbayesianPoint, other : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsinferbayesianPoint::sub(self : StatsinferbayesianPoint, other : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsinferbayesianPoint::scale(self : StatsinferbayesianPoint, s : Double) -> StatsinferbayesianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsinferbayesianPoint::dot(self : StatsinferbayesianPoint, other : StatsinferbayesianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsinferbayesianPoint::cross(self : StatsinferbayesianPoint, other : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsinferbayesianPoint::norm(self : StatsinferbayesianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsinferbayesianPoint::normalize(self : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferbayesianPoint::negate(self : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsinferbayesianPoint::mid(self : StatsinferbayesianPoint, other : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsinferbayesianPoint::lerp(self : StatsinferbayesianPoint, other : StatsinferbayesianPoint, t : Double) -> StatsinferbayesianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsinferbayesianPoint::to_string(self : StatsinferbayesianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsinferbayesianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_bayesian_make_series(vals : Array[Double], name : String) -> StatsinferbayesianSeries {
  { vals, name, meta: 0 }
}

pub fn StatsinferbayesianSeries::len(self : StatsinferbayesianSeries) -> Int { self.vals.length() }

pub fn StatsinferbayesianSeries::sum(self : StatsinferbayesianSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsinferbayesianSeries::mean(self : StatsinferbayesianSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsinferbayesianSeries::min(self : StatsinferbayesianSeries) -> Double { @_common.min(self.vals) }

pub fn StatsinferbayesianSeries::max(self : StatsinferbayesianSeries) -> Double { @_common.max(self.vals) }

pub fn StatsinferbayesianSeries::range(self : StatsinferbayesianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsinferbayesianSeries::variance(self : StatsinferbayesianSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsinferbayesianSeries::std(self : StatsinferbayesianSeries) -> Double { @_common.std(self.vals) }

pub fn StatsinferbayesianSeries::median(self : StatsinferbayesianSeries) -> Double { @_common.median(self.vals) }

pub fn StatsinferbayesianSeries::scale(self : StatsinferbayesianSeries, f : Double) -> StatsinferbayesianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsinferbayesianSeries::add(self : StatsinferbayesianSeries, other : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsinferbayesianSeries::sub(self : StatsinferbayesianSeries, other : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsinferbayesianSeries::normalize(self : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsinferbayesianSeries::cumsum(self : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsinferbayesianSeries::to_string(self : StatsinferbayesianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferbayesianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_bayesian_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferbayesianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_bayesian_matrix_identity(n : Int) -> StatsinferbayesianMatrix {
  let m = stats_infer_bayesian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsinferbayesianMatrix::get(self : StatsinferbayesianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsinferbayesianMatrix::transpose(self : StatsinferbayesianMatrix) -> StatsinferbayesianMatrix {
  let result = stats_infer_bayesian_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsinferbayesianMatrix::add(self : StatsinferbayesianMatrix, other : StatsinferbayesianMatrix) -> StatsinferbayesianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_infer_bayesian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsinferbayesianMatrix::scale(self : StatsinferbayesianMatrix, s : Double) -> StatsinferbayesianMatrix {
  let result = stats_infer_bayesian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsinferbayesianMatrix::multiply(self : StatsinferbayesianMatrix, other : StatsinferbayesianMatrix) -> StatsinferbayesianMatrix {
  if self.cols != other.rows { return stats_infer_bayesian_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_infer_bayesian_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsinferbayesianMatrix::trace(self : StatsinferbayesianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsinferbayesianMatrix::det(self : StatsinferbayesianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsinferbayesianMatrix::norm(self : StatsinferbayesianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsinferbayesianMatrix::to_string(self : StatsinferbayesianMatrix) -> String {
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

pub(all) struct StatsinferbayesianVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_bayesian_make_vector(comps : Array[Double]) -> StatsinferbayesianVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_bayesian_vector_zero(dim : Int) -> StatsinferbayesianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsinferbayesianVector::add(self : StatsinferbayesianVector, other : StatsinferbayesianVector) -> StatsinferbayesianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferbayesianVector::sub(self : StatsinferbayesianVector, other : StatsinferbayesianVector) -> StatsinferbayesianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferbayesianVector::scale(self : StatsinferbayesianVector, s : Double) -> StatsinferbayesianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsinferbayesianVector::dot(self : StatsinferbayesianVector, other : StatsinferbayesianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsinferbayesianVector::norm(self : StatsinferbayesianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsinferbayesianVector::normalize(self : StatsinferbayesianVector) -> StatsinferbayesianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferbayesianVector::dist(self : StatsinferbayesianVector, other : StatsinferbayesianVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsinferbayesianVector::to_string(self : StatsinferbayesianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferbayesianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_frame_make(size : Int) -> StatsinferbayesianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianFrame::len(self : StatsinferbayesianFrame) -> Int { self.size }

pub fn StatsinferbayesianFrame::get(self : StatsinferbayesianFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianFrame::set(self : StatsinferbayesianFrame, i : Int, v : Double) -> StatsinferbayesianFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianFrame::sum(self : StatsinferbayesianFrame) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianFrame::mean(self : StatsinferbayesianFrame) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianFrame::scale(self : StatsinferbayesianFrame, f : Double) -> StatsinferbayesianFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianFrame::add(self : StatsinferbayesianFrame, other : StatsinferbayesianFrame) -> StatsinferbayesianFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianFrame::copy(self : StatsinferbayesianFrame) -> StatsinferbayesianFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianFrame::fill(self : StatsinferbayesianFrame, v : Double) -> StatsinferbayesianFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianFrame::min(self : StatsinferbayesianFrame) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianFrame::max(self : StatsinferbayesianFrame) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianFrame::to_string(self : StatsinferbayesianFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_table_make(size : Int) -> StatsinferbayesianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianTable::len(self : StatsinferbayesianTable) -> Int { self.size }

pub fn StatsinferbayesianTable::get(self : StatsinferbayesianTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianTable::set(self : StatsinferbayesianTable, i : Int, v : Double) -> StatsinferbayesianTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianTable::sum(self : StatsinferbayesianTable) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianTable::mean(self : StatsinferbayesianTable) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianTable::scale(self : StatsinferbayesianTable, f : Double) -> StatsinferbayesianTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianTable::add(self : StatsinferbayesianTable, other : StatsinferbayesianTable) -> StatsinferbayesianTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianTable::copy(self : StatsinferbayesianTable) -> StatsinferbayesianTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianTable::fill(self : StatsinferbayesianTable, v : Double) -> StatsinferbayesianTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianTable::min(self : StatsinferbayesianTable) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianTable::max(self : StatsinferbayesianTable) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianTable::to_string(self : StatsinferbayesianTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_graphn_make(size : Int) -> StatsinferbayesianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianGraphN::len(self : StatsinferbayesianGraphN) -> Int { self.size }

pub fn StatsinferbayesianGraphN::get(self : StatsinferbayesianGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianGraphN::set(self : StatsinferbayesianGraphN, i : Int, v : Double) -> StatsinferbayesianGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianGraphN::sum(self : StatsinferbayesianGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianGraphN::mean(self : StatsinferbayesianGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianGraphN::scale(self : StatsinferbayesianGraphN, f : Double) -> StatsinferbayesianGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianGraphN::add(self : StatsinferbayesianGraphN, other : StatsinferbayesianGraphN) -> StatsinferbayesianGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianGraphN::copy(self : StatsinferbayesianGraphN) -> StatsinferbayesianGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianGraphN::fill(self : StatsinferbayesianGraphN, v : Double) -> StatsinferbayesianGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianGraphN::min(self : StatsinferbayesianGraphN) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianGraphN::max(self : StatsinferbayesianGraphN) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianGraphN::to_string(self : StatsinferbayesianGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_node_make(size : Int) -> StatsinferbayesianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianNode::len(self : StatsinferbayesianNode) -> Int { self.size }

pub fn StatsinferbayesianNode::get(self : StatsinferbayesianNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianNode::set(self : StatsinferbayesianNode, i : Int, v : Double) -> StatsinferbayesianNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianNode::sum(self : StatsinferbayesianNode) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianNode::mean(self : StatsinferbayesianNode) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianNode::scale(self : StatsinferbayesianNode, f : Double) -> StatsinferbayesianNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianNode::add(self : StatsinferbayesianNode, other : StatsinferbayesianNode) -> StatsinferbayesianNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianNode::copy(self : StatsinferbayesianNode) -> StatsinferbayesianNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianNode::fill(self : StatsinferbayesianNode, v : Double) -> StatsinferbayesianNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianNode::min(self : StatsinferbayesianNode) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianNode::max(self : StatsinferbayesianNode) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianNode::to_string(self : StatsinferbayesianNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_edge_make(size : Int) -> StatsinferbayesianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianEdge::len(self : StatsinferbayesianEdge) -> Int { self.size }

pub fn StatsinferbayesianEdge::get(self : StatsinferbayesianEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianEdge::set(self : StatsinferbayesianEdge, i : Int, v : Double) -> StatsinferbayesianEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianEdge::sum(self : StatsinferbayesianEdge) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianEdge::mean(self : StatsinferbayesianEdge) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianEdge::scale(self : StatsinferbayesianEdge, f : Double) -> StatsinferbayesianEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianEdge::add(self : StatsinferbayesianEdge, other : StatsinferbayesianEdge) -> StatsinferbayesianEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianEdge::copy(self : StatsinferbayesianEdge) -> StatsinferbayesianEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianEdge::fill(self : StatsinferbayesianEdge, v : Double) -> StatsinferbayesianEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianEdge::min(self : StatsinferbayesianEdge) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianEdge::max(self : StatsinferbayesianEdge) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianEdge::to_string(self : StatsinferbayesianEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_path_make(size : Int) -> StatsinferbayesianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianPath::len(self : StatsinferbayesianPath) -> Int { self.size }

pub fn StatsinferbayesianPath::get(self : StatsinferbayesianPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianPath::set(self : StatsinferbayesianPath, i : Int, v : Double) -> StatsinferbayesianPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianPath::sum(self : StatsinferbayesianPath) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianPath::mean(self : StatsinferbayesianPath) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianPath::scale(self : StatsinferbayesianPath, f : Double) -> StatsinferbayesianPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianPath::add(self : StatsinferbayesianPath, other : StatsinferbayesianPath) -> StatsinferbayesianPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianPath::copy(self : StatsinferbayesianPath) -> StatsinferbayesianPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianPath::fill(self : StatsinferbayesianPath, v : Double) -> StatsinferbayesianPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianPath::min(self : StatsinferbayesianPath) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianPath::max(self : StatsinferbayesianPath) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianPath::to_string(self : StatsinferbayesianPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_cluster_make(size : Int) -> StatsinferbayesianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianCluster::len(self : StatsinferbayesianCluster) -> Int { self.size }

pub fn StatsinferbayesianCluster::get(self : StatsinferbayesianCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianCluster::set(self : StatsinferbayesianCluster, i : Int, v : Double) -> StatsinferbayesianCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianCluster::sum(self : StatsinferbayesianCluster) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianCluster::mean(self : StatsinferbayesianCluster) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianCluster::scale(self : StatsinferbayesianCluster, f : Double) -> StatsinferbayesianCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianCluster::add(self : StatsinferbayesianCluster, other : StatsinferbayesianCluster) -> StatsinferbayesianCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianCluster::copy(self : StatsinferbayesianCluster) -> StatsinferbayesianCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianCluster::fill(self : StatsinferbayesianCluster, v : Double) -> StatsinferbayesianCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianCluster::min(self : StatsinferbayesianCluster) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianCluster::max(self : StatsinferbayesianCluster) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianCluster::to_string(self : StatsinferbayesianCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_model_make(size : Int) -> StatsinferbayesianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianModel::len(self : StatsinferbayesianModel) -> Int { self.size }

pub fn StatsinferbayesianModel::get(self : StatsinferbayesianModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianModel::set(self : StatsinferbayesianModel, i : Int, v : Double) -> StatsinferbayesianModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianModel::sum(self : StatsinferbayesianModel) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianModel::mean(self : StatsinferbayesianModel) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianModel::scale(self : StatsinferbayesianModel, f : Double) -> StatsinferbayesianModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianModel::add(self : StatsinferbayesianModel, other : StatsinferbayesianModel) -> StatsinferbayesianModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianModel::copy(self : StatsinferbayesianModel) -> StatsinferbayesianModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianModel::fill(self : StatsinferbayesianModel, v : Double) -> StatsinferbayesianModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianModel::min(self : StatsinferbayesianModel) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianModel::max(self : StatsinferbayesianModel) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianModel::to_string(self : StatsinferbayesianModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_layer_make(size : Int) -> StatsinferbayesianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianLayer::len(self : StatsinferbayesianLayer) -> Int { self.size }

pub fn StatsinferbayesianLayer::get(self : StatsinferbayesianLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianLayer::set(self : StatsinferbayesianLayer, i : Int, v : Double) -> StatsinferbayesianLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianLayer::sum(self : StatsinferbayesianLayer) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianLayer::mean(self : StatsinferbayesianLayer) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianLayer::scale(self : StatsinferbayesianLayer, f : Double) -> StatsinferbayesianLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianLayer::add(self : StatsinferbayesianLayer, other : StatsinferbayesianLayer) -> StatsinferbayesianLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianLayer::copy(self : StatsinferbayesianLayer) -> StatsinferbayesianLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianLayer::fill(self : StatsinferbayesianLayer, v : Double) -> StatsinferbayesianLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianLayer::min(self : StatsinferbayesianLayer) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianLayer::max(self : StatsinferbayesianLayer) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianLayer::to_string(self : StatsinferbayesianLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_buffer_make(size : Int) -> StatsinferbayesianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianBuffer::len(self : StatsinferbayesianBuffer) -> Int { self.size }

pub fn StatsinferbayesianBuffer::get(self : StatsinferbayesianBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianBuffer::set(self : StatsinferbayesianBuffer, i : Int, v : Double) -> StatsinferbayesianBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianBuffer::sum(self : StatsinferbayesianBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianBuffer::mean(self : StatsinferbayesianBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianBuffer::scale(self : StatsinferbayesianBuffer, f : Double) -> StatsinferbayesianBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianBuffer::add(self : StatsinferbayesianBuffer, other : StatsinferbayesianBuffer) -> StatsinferbayesianBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianBuffer::copy(self : StatsinferbayesianBuffer) -> StatsinferbayesianBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianBuffer::fill(self : StatsinferbayesianBuffer, v : Double) -> StatsinferbayesianBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianBuffer::min(self : StatsinferbayesianBuffer) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianBuffer::max(self : StatsinferbayesianBuffer) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianBuffer::to_string(self : StatsinferbayesianBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_cursor_make(size : Int) -> StatsinferbayesianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianCursor::len(self : StatsinferbayesianCursor) -> Int { self.size }

pub fn StatsinferbayesianCursor::get(self : StatsinferbayesianCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianCursor::set(self : StatsinferbayesianCursor, i : Int, v : Double) -> StatsinferbayesianCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianCursor::sum(self : StatsinferbayesianCursor) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianCursor::mean(self : StatsinferbayesianCursor) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianCursor::scale(self : StatsinferbayesianCursor, f : Double) -> StatsinferbayesianCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianCursor::add(self : StatsinferbayesianCursor, other : StatsinferbayesianCursor) -> StatsinferbayesianCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianCursor::copy(self : StatsinferbayesianCursor) -> StatsinferbayesianCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianCursor::fill(self : StatsinferbayesianCursor, v : Double) -> StatsinferbayesianCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianCursor::min(self : StatsinferbayesianCursor) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianCursor::max(self : StatsinferbayesianCursor) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianCursor::to_string(self : StatsinferbayesianCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_view_make(size : Int) -> StatsinferbayesianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianView::len(self : StatsinferbayesianView) -> Int { self.size }

pub fn StatsinferbayesianView::get(self : StatsinferbayesianView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianView::set(self : StatsinferbayesianView, i : Int, v : Double) -> StatsinferbayesianView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianView::sum(self : StatsinferbayesianView) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianView::mean(self : StatsinferbayesianView) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianView::scale(self : StatsinferbayesianView, f : Double) -> StatsinferbayesianView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianView::add(self : StatsinferbayesianView, other : StatsinferbayesianView) -> StatsinferbayesianView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianView::copy(self : StatsinferbayesianView) -> StatsinferbayesianView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianView::fill(self : StatsinferbayesianView, v : Double) -> StatsinferbayesianView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianView::min(self : StatsinferbayesianView) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianView::max(self : StatsinferbayesianView) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianView::to_string(self : StatsinferbayesianView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_range_make(size : Int) -> StatsinferbayesianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianRange::len(self : StatsinferbayesianRange) -> Int { self.size }

pub fn StatsinferbayesianRange::get(self : StatsinferbayesianRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianRange::set(self : StatsinferbayesianRange, i : Int, v : Double) -> StatsinferbayesianRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianRange::sum(self : StatsinferbayesianRange) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianRange::mean(self : StatsinferbayesianRange) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianRange::scale(self : StatsinferbayesianRange, f : Double) -> StatsinferbayesianRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianRange::add(self : StatsinferbayesianRange, other : StatsinferbayesianRange) -> StatsinferbayesianRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianRange::copy(self : StatsinferbayesianRange) -> StatsinferbayesianRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianRange::fill(self : StatsinferbayesianRange, v : Double) -> StatsinferbayesianRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianRange::min(self : StatsinferbayesianRange) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianRange::max(self : StatsinferbayesianRange) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianRange::to_string(self : StatsinferbayesianRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_slice_make(size : Int) -> StatsinferbayesianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferbayesianSlice::len(self : StatsinferbayesianSlice) -> Int { self.size }

pub fn StatsinferbayesianSlice::get(self : StatsinferbayesianSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferbayesianSlice::set(self : StatsinferbayesianSlice, i : Int, v : Double) -> StatsinferbayesianSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianSlice::sum(self : StatsinferbayesianSlice) -> Double { @_common.sum(self.data) }

pub fn StatsinferbayesianSlice::mean(self : StatsinferbayesianSlice) -> Double { @_common.mean(self.data) }

pub fn StatsinferbayesianSlice::scale(self : StatsinferbayesianSlice, f : Double) -> StatsinferbayesianSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianSlice::add(self : StatsinferbayesianSlice, other : StatsinferbayesianSlice) -> StatsinferbayesianSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferbayesianSlice::copy(self : StatsinferbayesianSlice) -> StatsinferbayesianSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianSlice::fill(self : StatsinferbayesianSlice, v : Double) -> StatsinferbayesianSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferbayesianSlice::min(self : StatsinferbayesianSlice) -> Double { @_common.min(self.data) }

pub fn StatsinferbayesianSlice::max(self : StatsinferbayesianSlice) -> Double { @_common.max(self.data) }

pub fn StatsinferbayesianSlice::to_string(self : StatsinferbayesianSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

