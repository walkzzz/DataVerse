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
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
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

pub(all) struct GraphtreearborescenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_frame_make(size : Int) -> GraphtreearborescenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceFrame::len(self : GraphtreearborescenceFrame) -> Int { self.size }

pub fn GraphtreearborescenceFrame::get(self : GraphtreearborescenceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceFrame::set(self : GraphtreearborescenceFrame, i : Int, v : Double) -> GraphtreearborescenceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceFrame::sum(self : GraphtreearborescenceFrame) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceFrame::mean(self : GraphtreearborescenceFrame) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceFrame::scale(self : GraphtreearborescenceFrame, f : Double) -> GraphtreearborescenceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceFrame::add(self : GraphtreearborescenceFrame, other : GraphtreearborescenceFrame) -> GraphtreearborescenceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceFrame::copy(self : GraphtreearborescenceFrame) -> GraphtreearborescenceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceFrame::fill(self : GraphtreearborescenceFrame, v : Double) -> GraphtreearborescenceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceFrame::min(self : GraphtreearborescenceFrame) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceFrame::max(self : GraphtreearborescenceFrame) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceFrame::to_string(self : GraphtreearborescenceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_table_make(size : Int) -> GraphtreearborescenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceTable::len(self : GraphtreearborescenceTable) -> Int { self.size }

pub fn GraphtreearborescenceTable::get(self : GraphtreearborescenceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceTable::set(self : GraphtreearborescenceTable, i : Int, v : Double) -> GraphtreearborescenceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceTable::sum(self : GraphtreearborescenceTable) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceTable::mean(self : GraphtreearborescenceTable) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceTable::scale(self : GraphtreearborescenceTable, f : Double) -> GraphtreearborescenceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceTable::add(self : GraphtreearborescenceTable, other : GraphtreearborescenceTable) -> GraphtreearborescenceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceTable::copy(self : GraphtreearborescenceTable) -> GraphtreearborescenceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceTable::fill(self : GraphtreearborescenceTable, v : Double) -> GraphtreearborescenceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceTable::min(self : GraphtreearborescenceTable) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceTable::max(self : GraphtreearborescenceTable) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceTable::to_string(self : GraphtreearborescenceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_graphn_make(size : Int) -> GraphtreearborescenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceGraphN::len(self : GraphtreearborescenceGraphN) -> Int { self.size }

pub fn GraphtreearborescenceGraphN::get(self : GraphtreearborescenceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceGraphN::set(self : GraphtreearborescenceGraphN, i : Int, v : Double) -> GraphtreearborescenceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceGraphN::sum(self : GraphtreearborescenceGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceGraphN::mean(self : GraphtreearborescenceGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceGraphN::scale(self : GraphtreearborescenceGraphN, f : Double) -> GraphtreearborescenceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceGraphN::add(self : GraphtreearborescenceGraphN, other : GraphtreearborescenceGraphN) -> GraphtreearborescenceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceGraphN::copy(self : GraphtreearborescenceGraphN) -> GraphtreearborescenceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceGraphN::fill(self : GraphtreearborescenceGraphN, v : Double) -> GraphtreearborescenceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceGraphN::min(self : GraphtreearborescenceGraphN) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceGraphN::max(self : GraphtreearborescenceGraphN) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceGraphN::to_string(self : GraphtreearborescenceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_node_make(size : Int) -> GraphtreearborescenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceNode::len(self : GraphtreearborescenceNode) -> Int { self.size }

pub fn GraphtreearborescenceNode::get(self : GraphtreearborescenceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceNode::set(self : GraphtreearborescenceNode, i : Int, v : Double) -> GraphtreearborescenceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceNode::sum(self : GraphtreearborescenceNode) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceNode::mean(self : GraphtreearborescenceNode) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceNode::scale(self : GraphtreearborescenceNode, f : Double) -> GraphtreearborescenceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceNode::add(self : GraphtreearborescenceNode, other : GraphtreearborescenceNode) -> GraphtreearborescenceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceNode::copy(self : GraphtreearborescenceNode) -> GraphtreearborescenceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceNode::fill(self : GraphtreearborescenceNode, v : Double) -> GraphtreearborescenceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceNode::min(self : GraphtreearborescenceNode) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceNode::max(self : GraphtreearborescenceNode) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceNode::to_string(self : GraphtreearborescenceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_edge_make(size : Int) -> GraphtreearborescenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceEdge::len(self : GraphtreearborescenceEdge) -> Int { self.size }

pub fn GraphtreearborescenceEdge::get(self : GraphtreearborescenceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceEdge::set(self : GraphtreearborescenceEdge, i : Int, v : Double) -> GraphtreearborescenceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceEdge::sum(self : GraphtreearborescenceEdge) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceEdge::mean(self : GraphtreearborescenceEdge) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceEdge::scale(self : GraphtreearborescenceEdge, f : Double) -> GraphtreearborescenceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceEdge::add(self : GraphtreearborescenceEdge, other : GraphtreearborescenceEdge) -> GraphtreearborescenceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceEdge::copy(self : GraphtreearborescenceEdge) -> GraphtreearborescenceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceEdge::fill(self : GraphtreearborescenceEdge, v : Double) -> GraphtreearborescenceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceEdge::min(self : GraphtreearborescenceEdge) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceEdge::max(self : GraphtreearborescenceEdge) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceEdge::to_string(self : GraphtreearborescenceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_path_make(size : Int) -> GraphtreearborescencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescencePath::len(self : GraphtreearborescencePath) -> Int { self.size }

pub fn GraphtreearborescencePath::get(self : GraphtreearborescencePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescencePath::set(self : GraphtreearborescencePath, i : Int, v : Double) -> GraphtreearborescencePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescencePath::sum(self : GraphtreearborescencePath) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescencePath::mean(self : GraphtreearborescencePath) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescencePath::scale(self : GraphtreearborescencePath, f : Double) -> GraphtreearborescencePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescencePath::add(self : GraphtreearborescencePath, other : GraphtreearborescencePath) -> GraphtreearborescencePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescencePath::copy(self : GraphtreearborescencePath) -> GraphtreearborescencePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescencePath::fill(self : GraphtreearborescencePath, v : Double) -> GraphtreearborescencePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescencePath::min(self : GraphtreearborescencePath) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescencePath::max(self : GraphtreearborescencePath) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescencePath::to_string(self : GraphtreearborescencePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_cluster_make(size : Int) -> GraphtreearborescenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceCluster::len(self : GraphtreearborescenceCluster) -> Int { self.size }

pub fn GraphtreearborescenceCluster::get(self : GraphtreearborescenceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceCluster::set(self : GraphtreearborescenceCluster, i : Int, v : Double) -> GraphtreearborescenceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceCluster::sum(self : GraphtreearborescenceCluster) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceCluster::mean(self : GraphtreearborescenceCluster) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceCluster::scale(self : GraphtreearborescenceCluster, f : Double) -> GraphtreearborescenceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceCluster::add(self : GraphtreearborescenceCluster, other : GraphtreearborescenceCluster) -> GraphtreearborescenceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceCluster::copy(self : GraphtreearborescenceCluster) -> GraphtreearborescenceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceCluster::fill(self : GraphtreearborescenceCluster, v : Double) -> GraphtreearborescenceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceCluster::min(self : GraphtreearborescenceCluster) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceCluster::max(self : GraphtreearborescenceCluster) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceCluster::to_string(self : GraphtreearborescenceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_model_make(size : Int) -> GraphtreearborescenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceModel::len(self : GraphtreearborescenceModel) -> Int { self.size }

pub fn GraphtreearborescenceModel::get(self : GraphtreearborescenceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceModel::set(self : GraphtreearborescenceModel, i : Int, v : Double) -> GraphtreearborescenceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceModel::sum(self : GraphtreearborescenceModel) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceModel::mean(self : GraphtreearborescenceModel) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceModel::scale(self : GraphtreearborescenceModel, f : Double) -> GraphtreearborescenceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceModel::add(self : GraphtreearborescenceModel, other : GraphtreearborescenceModel) -> GraphtreearborescenceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceModel::copy(self : GraphtreearborescenceModel) -> GraphtreearborescenceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceModel::fill(self : GraphtreearborescenceModel, v : Double) -> GraphtreearborescenceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceModel::min(self : GraphtreearborescenceModel) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceModel::max(self : GraphtreearborescenceModel) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceModel::to_string(self : GraphtreearborescenceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_layer_make(size : Int) -> GraphtreearborescenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceLayer::len(self : GraphtreearborescenceLayer) -> Int { self.size }

pub fn GraphtreearborescenceLayer::get(self : GraphtreearborescenceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceLayer::set(self : GraphtreearborescenceLayer, i : Int, v : Double) -> GraphtreearborescenceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceLayer::sum(self : GraphtreearborescenceLayer) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceLayer::mean(self : GraphtreearborescenceLayer) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceLayer::scale(self : GraphtreearborescenceLayer, f : Double) -> GraphtreearborescenceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceLayer::add(self : GraphtreearborescenceLayer, other : GraphtreearborescenceLayer) -> GraphtreearborescenceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceLayer::copy(self : GraphtreearborescenceLayer) -> GraphtreearborescenceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceLayer::fill(self : GraphtreearborescenceLayer, v : Double) -> GraphtreearborescenceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceLayer::min(self : GraphtreearborescenceLayer) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceLayer::max(self : GraphtreearborescenceLayer) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceLayer::to_string(self : GraphtreearborescenceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_buffer_make(size : Int) -> GraphtreearborescenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceBuffer::len(self : GraphtreearborescenceBuffer) -> Int { self.size }

pub fn GraphtreearborescenceBuffer::get(self : GraphtreearborescenceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceBuffer::set(self : GraphtreearborescenceBuffer, i : Int, v : Double) -> GraphtreearborescenceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceBuffer::sum(self : GraphtreearborescenceBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceBuffer::mean(self : GraphtreearborescenceBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceBuffer::scale(self : GraphtreearborescenceBuffer, f : Double) -> GraphtreearborescenceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceBuffer::add(self : GraphtreearborescenceBuffer, other : GraphtreearborescenceBuffer) -> GraphtreearborescenceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceBuffer::copy(self : GraphtreearborescenceBuffer) -> GraphtreearborescenceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceBuffer::fill(self : GraphtreearborescenceBuffer, v : Double) -> GraphtreearborescenceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceBuffer::min(self : GraphtreearborescenceBuffer) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceBuffer::max(self : GraphtreearborescenceBuffer) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceBuffer::to_string(self : GraphtreearborescenceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_cursor_make(size : Int) -> GraphtreearborescenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceCursor::len(self : GraphtreearborescenceCursor) -> Int { self.size }

pub fn GraphtreearborescenceCursor::get(self : GraphtreearborescenceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceCursor::set(self : GraphtreearborescenceCursor, i : Int, v : Double) -> GraphtreearborescenceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceCursor::sum(self : GraphtreearborescenceCursor) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceCursor::mean(self : GraphtreearborescenceCursor) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceCursor::scale(self : GraphtreearborescenceCursor, f : Double) -> GraphtreearborescenceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceCursor::add(self : GraphtreearborescenceCursor, other : GraphtreearborescenceCursor) -> GraphtreearborescenceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceCursor::copy(self : GraphtreearborescenceCursor) -> GraphtreearborescenceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceCursor::fill(self : GraphtreearborescenceCursor, v : Double) -> GraphtreearborescenceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceCursor::min(self : GraphtreearborescenceCursor) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceCursor::max(self : GraphtreearborescenceCursor) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceCursor::to_string(self : GraphtreearborescenceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_view_make(size : Int) -> GraphtreearborescenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceView::len(self : GraphtreearborescenceView) -> Int { self.size }

pub fn GraphtreearborescenceView::get(self : GraphtreearborescenceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceView::set(self : GraphtreearborescenceView, i : Int, v : Double) -> GraphtreearborescenceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceView::sum(self : GraphtreearborescenceView) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceView::mean(self : GraphtreearborescenceView) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceView::scale(self : GraphtreearborescenceView, f : Double) -> GraphtreearborescenceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceView::add(self : GraphtreearborescenceView, other : GraphtreearborescenceView) -> GraphtreearborescenceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceView::copy(self : GraphtreearborescenceView) -> GraphtreearborescenceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceView::fill(self : GraphtreearborescenceView, v : Double) -> GraphtreearborescenceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceView::min(self : GraphtreearborescenceView) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceView::max(self : GraphtreearborescenceView) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceView::to_string(self : GraphtreearborescenceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_range_make(size : Int) -> GraphtreearborescenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceRange::len(self : GraphtreearborescenceRange) -> Int { self.size }

pub fn GraphtreearborescenceRange::get(self : GraphtreearborescenceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceRange::set(self : GraphtreearborescenceRange, i : Int, v : Double) -> GraphtreearborescenceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceRange::sum(self : GraphtreearborescenceRange) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceRange::mean(self : GraphtreearborescenceRange) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceRange::scale(self : GraphtreearborescenceRange, f : Double) -> GraphtreearborescenceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceRange::add(self : GraphtreearborescenceRange, other : GraphtreearborescenceRange) -> GraphtreearborescenceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceRange::copy(self : GraphtreearborescenceRange) -> GraphtreearborescenceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceRange::fill(self : GraphtreearborescenceRange, v : Double) -> GraphtreearborescenceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceRange::min(self : GraphtreearborescenceRange) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceRange::max(self : GraphtreearborescenceRange) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceRange::to_string(self : GraphtreearborescenceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_slice_make(size : Int) -> GraphtreearborescenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreearborescenceSlice::len(self : GraphtreearborescenceSlice) -> Int { self.size }

pub fn GraphtreearborescenceSlice::get(self : GraphtreearborescenceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreearborescenceSlice::set(self : GraphtreearborescenceSlice, i : Int, v : Double) -> GraphtreearborescenceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceSlice::sum(self : GraphtreearborescenceSlice) -> Double { @_common.sum(self.data) }

pub fn GraphtreearborescenceSlice::mean(self : GraphtreearborescenceSlice) -> Double { @_common.mean(self.data) }

pub fn GraphtreearborescenceSlice::scale(self : GraphtreearborescenceSlice, f : Double) -> GraphtreearborescenceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceSlice::add(self : GraphtreearborescenceSlice, other : GraphtreearborescenceSlice) -> GraphtreearborescenceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreearborescenceSlice::copy(self : GraphtreearborescenceSlice) -> GraphtreearborescenceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceSlice::fill(self : GraphtreearborescenceSlice, v : Double) -> GraphtreearborescenceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreearborescenceSlice::min(self : GraphtreearborescenceSlice) -> Double { @_common.min(self.data) }

pub fn GraphtreearborescenceSlice::max(self : GraphtreearborescenceSlice) -> Double { @_common.max(self.data) }

pub fn GraphtreearborescenceSlice::to_string(self : GraphtreearborescenceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

