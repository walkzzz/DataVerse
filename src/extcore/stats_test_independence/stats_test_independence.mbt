///===
/// extcore/stats_test_independence

pub(all) struct StatstestindependencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_independence_make_point(x : Double, y : Double) -> StatstestindependencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_independence_make_point3(x : Double, y : Double, z : Double) -> StatstestindependencePoint {
  { x, y, z, label: 0 }
}

pub fn StatstestindependencePoint::x(self : StatstestindependencePoint) -> Double { self.x }

pub fn StatstestindependencePoint::y(self : StatstestindependencePoint) -> Double { self.y }

pub fn StatstestindependencePoint::z(self : StatstestindependencePoint) -> Double { self.z }

pub fn StatstestindependencePoint::label(self : StatstestindependencePoint) -> Int { self.label }

pub fn StatstestindependencePoint::dist(self : StatstestindependencePoint, other : StatstestindependencePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestindependencePoint::add(self : StatstestindependencePoint, other : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestindependencePoint::sub(self : StatstestindependencePoint, other : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestindependencePoint::scale(self : StatstestindependencePoint, s : Double) -> StatstestindependencePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestindependencePoint::dot(self : StatstestindependencePoint, other : StatstestindependencePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestindependencePoint::cross(self : StatstestindependencePoint, other : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestindependencePoint::norm(self : StatstestindependencePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestindependencePoint::normalize(self : StatstestindependencePoint) -> StatstestindependencePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestindependencePoint::negate(self : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestindependencePoint::mid(self : StatstestindependencePoint, other : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestindependencePoint::lerp(self : StatstestindependencePoint, other : StatstestindependencePoint, t : Double) -> StatstestindependencePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestindependencePoint::to_string(self : StatstestindependencePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestindependenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_independence_make_series(vals : Array[Double], name : String) -> StatstestindependenceSeries {
  { vals, name, meta: 0 }
}

pub fn StatstestindependenceSeries::len(self : StatstestindependenceSeries) -> Int { self.vals.length() }

pub fn StatstestindependenceSeries::sum(self : StatstestindependenceSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestindependenceSeries::mean(self : StatstestindependenceSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestindependenceSeries::min(self : StatstestindependenceSeries) -> Double { @_common.min(self.vals) }

pub fn StatstestindependenceSeries::max(self : StatstestindependenceSeries) -> Double { @_common.max(self.vals) }

pub fn StatstestindependenceSeries::range(self : StatstestindependenceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestindependenceSeries::variance(self : StatstestindependenceSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestindependenceSeries::std(self : StatstestindependenceSeries) -> Double { @_common.std(self.vals) }

pub fn StatstestindependenceSeries::median(self : StatstestindependenceSeries) -> Double { @_common.median(self.vals) }

pub fn StatstestindependenceSeries::scale(self : StatstestindependenceSeries, f : Double) -> StatstestindependenceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestindependenceSeries::add(self : StatstestindependenceSeries, other : StatstestindependenceSeries) -> StatstestindependenceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestindependenceSeries::sub(self : StatstestindependenceSeries, other : StatstestindependenceSeries) -> StatstestindependenceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestindependenceSeries::normalize(self : StatstestindependenceSeries) -> StatstestindependenceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestindependenceSeries::cumsum(self : StatstestindependenceSeries) -> StatstestindependenceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestindependenceSeries::to_string(self : StatstestindependenceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestindependenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_independence_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestindependenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_independence_matrix_identity(n : Int) -> StatstestindependenceMatrix {
  let m = stats_test_independence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestindependenceMatrix::get(self : StatstestindependenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestindependenceMatrix::transpose(self : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  let result = stats_test_independence_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestindependenceMatrix::add(self : StatstestindependenceMatrix, other : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_independence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestindependenceMatrix::scale(self : StatstestindependenceMatrix, s : Double) -> StatstestindependenceMatrix {
  let result = stats_test_independence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestindependenceMatrix::multiply(self : StatstestindependenceMatrix, other : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  if self.cols != other.rows { return stats_test_independence_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_independence_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatstestindependenceMatrix::trace(self : StatstestindependenceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestindependenceMatrix::det(self : StatstestindependenceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestindependenceMatrix::norm(self : StatstestindependenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestindependenceMatrix::to_string(self : StatstestindependenceMatrix) -> String {
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

pub(all) struct StatstestindependenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_independence_make_vector(comps : Array[Double]) -> StatstestindependenceVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_independence_vector_zero(dim : Int) -> StatstestindependenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestindependenceVector::add(self : StatstestindependenceVector, other : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestindependenceVector::sub(self : StatstestindependenceVector, other : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestindependenceVector::scale(self : StatstestindependenceVector, s : Double) -> StatstestindependenceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestindependenceVector::dot(self : StatstestindependenceVector, other : StatstestindependenceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestindependenceVector::norm(self : StatstestindependenceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestindependenceVector::normalize(self : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestindependenceVector::dist(self : StatstestindependenceVector, other : StatstestindependenceVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestindependenceVector::to_string(self : StatstestindependenceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestindependenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_frame_make(size : Int) -> StatstestindependenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceFrame::len(self : StatstestindependenceFrame) -> Int { self.size }

pub fn StatstestindependenceFrame::get(self : StatstestindependenceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceFrame::set(self : StatstestindependenceFrame, i : Int, v : Double) -> StatstestindependenceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceFrame::sum(self : StatstestindependenceFrame) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceFrame::mean(self : StatstestindependenceFrame) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceFrame::scale(self : StatstestindependenceFrame, f : Double) -> StatstestindependenceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceFrame::add(self : StatstestindependenceFrame, other : StatstestindependenceFrame) -> StatstestindependenceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceFrame::copy(self : StatstestindependenceFrame) -> StatstestindependenceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceFrame::fill(self : StatstestindependenceFrame, v : Double) -> StatstestindependenceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceFrame::min(self : StatstestindependenceFrame) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceFrame::max(self : StatstestindependenceFrame) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceFrame::to_string(self : StatstestindependenceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_table_make(size : Int) -> StatstestindependenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceTable::len(self : StatstestindependenceTable) -> Int { self.size }

pub fn StatstestindependenceTable::get(self : StatstestindependenceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceTable::set(self : StatstestindependenceTable, i : Int, v : Double) -> StatstestindependenceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceTable::sum(self : StatstestindependenceTable) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceTable::mean(self : StatstestindependenceTable) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceTable::scale(self : StatstestindependenceTable, f : Double) -> StatstestindependenceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceTable::add(self : StatstestindependenceTable, other : StatstestindependenceTable) -> StatstestindependenceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceTable::copy(self : StatstestindependenceTable) -> StatstestindependenceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceTable::fill(self : StatstestindependenceTable, v : Double) -> StatstestindependenceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceTable::min(self : StatstestindependenceTable) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceTable::max(self : StatstestindependenceTable) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceTable::to_string(self : StatstestindependenceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_graphn_make(size : Int) -> StatstestindependenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceGraphN::len(self : StatstestindependenceGraphN) -> Int { self.size }

pub fn StatstestindependenceGraphN::get(self : StatstestindependenceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceGraphN::set(self : StatstestindependenceGraphN, i : Int, v : Double) -> StatstestindependenceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceGraphN::sum(self : StatstestindependenceGraphN) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceGraphN::mean(self : StatstestindependenceGraphN) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceGraphN::scale(self : StatstestindependenceGraphN, f : Double) -> StatstestindependenceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceGraphN::add(self : StatstestindependenceGraphN, other : StatstestindependenceGraphN) -> StatstestindependenceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceGraphN::copy(self : StatstestindependenceGraphN) -> StatstestindependenceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceGraphN::fill(self : StatstestindependenceGraphN, v : Double) -> StatstestindependenceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceGraphN::min(self : StatstestindependenceGraphN) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceGraphN::max(self : StatstestindependenceGraphN) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceGraphN::to_string(self : StatstestindependenceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_node_make(size : Int) -> StatstestindependenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceNode::len(self : StatstestindependenceNode) -> Int { self.size }

pub fn StatstestindependenceNode::get(self : StatstestindependenceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceNode::set(self : StatstestindependenceNode, i : Int, v : Double) -> StatstestindependenceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceNode::sum(self : StatstestindependenceNode) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceNode::mean(self : StatstestindependenceNode) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceNode::scale(self : StatstestindependenceNode, f : Double) -> StatstestindependenceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceNode::add(self : StatstestindependenceNode, other : StatstestindependenceNode) -> StatstestindependenceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceNode::copy(self : StatstestindependenceNode) -> StatstestindependenceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceNode::fill(self : StatstestindependenceNode, v : Double) -> StatstestindependenceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceNode::min(self : StatstestindependenceNode) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceNode::max(self : StatstestindependenceNode) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceNode::to_string(self : StatstestindependenceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_edge_make(size : Int) -> StatstestindependenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceEdge::len(self : StatstestindependenceEdge) -> Int { self.size }

pub fn StatstestindependenceEdge::get(self : StatstestindependenceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceEdge::set(self : StatstestindependenceEdge, i : Int, v : Double) -> StatstestindependenceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceEdge::sum(self : StatstestindependenceEdge) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceEdge::mean(self : StatstestindependenceEdge) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceEdge::scale(self : StatstestindependenceEdge, f : Double) -> StatstestindependenceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceEdge::add(self : StatstestindependenceEdge, other : StatstestindependenceEdge) -> StatstestindependenceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceEdge::copy(self : StatstestindependenceEdge) -> StatstestindependenceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceEdge::fill(self : StatstestindependenceEdge, v : Double) -> StatstestindependenceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceEdge::min(self : StatstestindependenceEdge) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceEdge::max(self : StatstestindependenceEdge) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceEdge::to_string(self : StatstestindependenceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_path_make(size : Int) -> StatstestindependencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependencePath::len(self : StatstestindependencePath) -> Int { self.size }

pub fn StatstestindependencePath::get(self : StatstestindependencePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependencePath::set(self : StatstestindependencePath, i : Int, v : Double) -> StatstestindependencePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependencePath::sum(self : StatstestindependencePath) -> Double { @_common.sum(self.data) }

pub fn StatstestindependencePath::mean(self : StatstestindependencePath) -> Double { @_common.mean(self.data) }

pub fn StatstestindependencePath::scale(self : StatstestindependencePath, f : Double) -> StatstestindependencePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependencePath::add(self : StatstestindependencePath, other : StatstestindependencePath) -> StatstestindependencePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependencePath::copy(self : StatstestindependencePath) -> StatstestindependencePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependencePath::fill(self : StatstestindependencePath, v : Double) -> StatstestindependencePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependencePath::min(self : StatstestindependencePath) -> Double { @_common.min(self.data) }

pub fn StatstestindependencePath::max(self : StatstestindependencePath) -> Double { @_common.max(self.data) }

pub fn StatstestindependencePath::to_string(self : StatstestindependencePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_cluster_make(size : Int) -> StatstestindependenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceCluster::len(self : StatstestindependenceCluster) -> Int { self.size }

pub fn StatstestindependenceCluster::get(self : StatstestindependenceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceCluster::set(self : StatstestindependenceCluster, i : Int, v : Double) -> StatstestindependenceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceCluster::sum(self : StatstestindependenceCluster) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceCluster::mean(self : StatstestindependenceCluster) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceCluster::scale(self : StatstestindependenceCluster, f : Double) -> StatstestindependenceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceCluster::add(self : StatstestindependenceCluster, other : StatstestindependenceCluster) -> StatstestindependenceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceCluster::copy(self : StatstestindependenceCluster) -> StatstestindependenceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceCluster::fill(self : StatstestindependenceCluster, v : Double) -> StatstestindependenceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceCluster::min(self : StatstestindependenceCluster) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceCluster::max(self : StatstestindependenceCluster) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceCluster::to_string(self : StatstestindependenceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_model_make(size : Int) -> StatstestindependenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceModel::len(self : StatstestindependenceModel) -> Int { self.size }

pub fn StatstestindependenceModel::get(self : StatstestindependenceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceModel::set(self : StatstestindependenceModel, i : Int, v : Double) -> StatstestindependenceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceModel::sum(self : StatstestindependenceModel) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceModel::mean(self : StatstestindependenceModel) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceModel::scale(self : StatstestindependenceModel, f : Double) -> StatstestindependenceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceModel::add(self : StatstestindependenceModel, other : StatstestindependenceModel) -> StatstestindependenceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceModel::copy(self : StatstestindependenceModel) -> StatstestindependenceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceModel::fill(self : StatstestindependenceModel, v : Double) -> StatstestindependenceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceModel::min(self : StatstestindependenceModel) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceModel::max(self : StatstestindependenceModel) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceModel::to_string(self : StatstestindependenceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_layer_make(size : Int) -> StatstestindependenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceLayer::len(self : StatstestindependenceLayer) -> Int { self.size }

pub fn StatstestindependenceLayer::get(self : StatstestindependenceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceLayer::set(self : StatstestindependenceLayer, i : Int, v : Double) -> StatstestindependenceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceLayer::sum(self : StatstestindependenceLayer) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceLayer::mean(self : StatstestindependenceLayer) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceLayer::scale(self : StatstestindependenceLayer, f : Double) -> StatstestindependenceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceLayer::add(self : StatstestindependenceLayer, other : StatstestindependenceLayer) -> StatstestindependenceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceLayer::copy(self : StatstestindependenceLayer) -> StatstestindependenceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceLayer::fill(self : StatstestindependenceLayer, v : Double) -> StatstestindependenceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceLayer::min(self : StatstestindependenceLayer) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceLayer::max(self : StatstestindependenceLayer) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceLayer::to_string(self : StatstestindependenceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_buffer_make(size : Int) -> StatstestindependenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceBuffer::len(self : StatstestindependenceBuffer) -> Int { self.size }

pub fn StatstestindependenceBuffer::get(self : StatstestindependenceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceBuffer::set(self : StatstestindependenceBuffer, i : Int, v : Double) -> StatstestindependenceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceBuffer::sum(self : StatstestindependenceBuffer) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceBuffer::mean(self : StatstestindependenceBuffer) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceBuffer::scale(self : StatstestindependenceBuffer, f : Double) -> StatstestindependenceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceBuffer::add(self : StatstestindependenceBuffer, other : StatstestindependenceBuffer) -> StatstestindependenceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceBuffer::copy(self : StatstestindependenceBuffer) -> StatstestindependenceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceBuffer::fill(self : StatstestindependenceBuffer, v : Double) -> StatstestindependenceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceBuffer::min(self : StatstestindependenceBuffer) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceBuffer::max(self : StatstestindependenceBuffer) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceBuffer::to_string(self : StatstestindependenceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_cursor_make(size : Int) -> StatstestindependenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceCursor::len(self : StatstestindependenceCursor) -> Int { self.size }

pub fn StatstestindependenceCursor::get(self : StatstestindependenceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceCursor::set(self : StatstestindependenceCursor, i : Int, v : Double) -> StatstestindependenceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceCursor::sum(self : StatstestindependenceCursor) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceCursor::mean(self : StatstestindependenceCursor) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceCursor::scale(self : StatstestindependenceCursor, f : Double) -> StatstestindependenceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceCursor::add(self : StatstestindependenceCursor, other : StatstestindependenceCursor) -> StatstestindependenceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceCursor::copy(self : StatstestindependenceCursor) -> StatstestindependenceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceCursor::fill(self : StatstestindependenceCursor, v : Double) -> StatstestindependenceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceCursor::min(self : StatstestindependenceCursor) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceCursor::max(self : StatstestindependenceCursor) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceCursor::to_string(self : StatstestindependenceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_view_make(size : Int) -> StatstestindependenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceView::len(self : StatstestindependenceView) -> Int { self.size }

pub fn StatstestindependenceView::get(self : StatstestindependenceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceView::set(self : StatstestindependenceView, i : Int, v : Double) -> StatstestindependenceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceView::sum(self : StatstestindependenceView) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceView::mean(self : StatstestindependenceView) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceView::scale(self : StatstestindependenceView, f : Double) -> StatstestindependenceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceView::add(self : StatstestindependenceView, other : StatstestindependenceView) -> StatstestindependenceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceView::copy(self : StatstestindependenceView) -> StatstestindependenceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceView::fill(self : StatstestindependenceView, v : Double) -> StatstestindependenceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceView::min(self : StatstestindependenceView) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceView::max(self : StatstestindependenceView) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceView::to_string(self : StatstestindependenceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_range_make(size : Int) -> StatstestindependenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceRange::len(self : StatstestindependenceRange) -> Int { self.size }

pub fn StatstestindependenceRange::get(self : StatstestindependenceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceRange::set(self : StatstestindependenceRange, i : Int, v : Double) -> StatstestindependenceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceRange::sum(self : StatstestindependenceRange) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceRange::mean(self : StatstestindependenceRange) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceRange::scale(self : StatstestindependenceRange, f : Double) -> StatstestindependenceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceRange::add(self : StatstestindependenceRange, other : StatstestindependenceRange) -> StatstestindependenceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceRange::copy(self : StatstestindependenceRange) -> StatstestindependenceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceRange::fill(self : StatstestindependenceRange, v : Double) -> StatstestindependenceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceRange::min(self : StatstestindependenceRange) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceRange::max(self : StatstestindependenceRange) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceRange::to_string(self : StatstestindependenceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_slice_make(size : Int) -> StatstestindependenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestindependenceSlice::len(self : StatstestindependenceSlice) -> Int { self.size }

pub fn StatstestindependenceSlice::get(self : StatstestindependenceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestindependenceSlice::set(self : StatstestindependenceSlice, i : Int, v : Double) -> StatstestindependenceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestindependenceSlice::sum(self : StatstestindependenceSlice) -> Double { @_common.sum(self.data) }

pub fn StatstestindependenceSlice::mean(self : StatstestindependenceSlice) -> Double { @_common.mean(self.data) }

pub fn StatstestindependenceSlice::scale(self : StatstestindependenceSlice, f : Double) -> StatstestindependenceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceSlice::add(self : StatstestindependenceSlice, other : StatstestindependenceSlice) -> StatstestindependenceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestindependenceSlice::copy(self : StatstestindependenceSlice) -> StatstestindependenceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceSlice::fill(self : StatstestindependenceSlice, v : Double) -> StatstestindependenceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestindependenceSlice::min(self : StatstestindependenceSlice) -> Double { @_common.min(self.data) }

pub fn StatstestindependenceSlice::max(self : StatstestindependenceSlice) -> Double { @_common.max(self.data) }

pub fn StatstestindependenceSlice::to_string(self : StatstestindependenceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

