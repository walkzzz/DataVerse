///===
/// extcore/graph_tree_mst

pub(all) struct GraphtreemstPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_mst_make_point(x : Double, y : Double) -> GraphtreemstPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_mst_make_point3(x : Double, y : Double, z : Double) -> GraphtreemstPoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreemstPoint::x(self : GraphtreemstPoint) -> Double { self.x }

pub fn GraphtreemstPoint::y(self : GraphtreemstPoint) -> Double { self.y }

pub fn GraphtreemstPoint::z(self : GraphtreemstPoint) -> Double { self.z }

pub fn GraphtreemstPoint::label(self : GraphtreemstPoint) -> Int { self.label }

pub fn GraphtreemstPoint::dist(self : GraphtreemstPoint, other : GraphtreemstPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreemstPoint::add(self : GraphtreemstPoint, other : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreemstPoint::sub(self : GraphtreemstPoint, other : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreemstPoint::scale(self : GraphtreemstPoint, s : Double) -> GraphtreemstPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreemstPoint::dot(self : GraphtreemstPoint, other : GraphtreemstPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreemstPoint::cross(self : GraphtreemstPoint, other : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreemstPoint::norm(self : GraphtreemstPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreemstPoint::normalize(self : GraphtreemstPoint) -> GraphtreemstPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreemstPoint::negate(self : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreemstPoint::mid(self : GraphtreemstPoint, other : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreemstPoint::lerp(self : GraphtreemstPoint, other : GraphtreemstPoint, t : Double) -> GraphtreemstPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreemstPoint::to_string(self : GraphtreemstPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreemstSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_mst_make_series(vals : Array[Double], name : String) -> GraphtreemstSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreemstSeries::len(self : GraphtreemstSeries) -> Int { self.vals.length() }

pub fn GraphtreemstSeries::sum(self : GraphtreemstSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreemstSeries::mean(self : GraphtreemstSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreemstSeries::min(self : GraphtreemstSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreemstSeries::max(self : GraphtreemstSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreemstSeries::range(self : GraphtreemstSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreemstSeries::variance(self : GraphtreemstSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreemstSeries::std(self : GraphtreemstSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreemstSeries::median(self : GraphtreemstSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreemstSeries::scale(self : GraphtreemstSeries, f : Double) -> GraphtreemstSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreemstSeries::add(self : GraphtreemstSeries, other : GraphtreemstSeries) -> GraphtreemstSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreemstSeries::sub(self : GraphtreemstSeries, other : GraphtreemstSeries) -> GraphtreemstSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreemstSeries::normalize(self : GraphtreemstSeries) -> GraphtreemstSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreemstSeries::cumsum(self : GraphtreemstSeries) -> GraphtreemstSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreemstSeries::to_string(self : GraphtreemstSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreemstMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_mst_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreemstMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn graph_tree_mst_matrix_identity(n : Int) -> GraphtreemstMatrix {
  let m = graph_tree_mst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreemstMatrix::get(self : GraphtreemstMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreemstMatrix::transpose(self : GraphtreemstMatrix) -> GraphtreemstMatrix {
  let result = graph_tree_mst_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreemstMatrix::add(self : GraphtreemstMatrix, other : GraphtreemstMatrix) -> GraphtreemstMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_mst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreemstMatrix::scale(self : GraphtreemstMatrix, s : Double) -> GraphtreemstMatrix {
  let result = graph_tree_mst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreemstMatrix::multiply(self : GraphtreemstMatrix, other : GraphtreemstMatrix) -> GraphtreemstMatrix {
  if self.cols != other.rows { return graph_tree_mst_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_mst_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphtreemstMatrix::trace(self : GraphtreemstMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreemstMatrix::det(self : GraphtreemstMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreemstMatrix::norm(self : GraphtreemstMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreemstMatrix::to_string(self : GraphtreemstMatrix) -> String {
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

pub(all) struct GraphtreemstVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_mst_make_vector(comps : Array[Double]) -> GraphtreemstVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_mst_vector_zero(dim : Int) -> GraphtreemstVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreemstVector::add(self : GraphtreemstVector, other : GraphtreemstVector) -> GraphtreemstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreemstVector::sub(self : GraphtreemstVector, other : GraphtreemstVector) -> GraphtreemstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreemstVector::scale(self : GraphtreemstVector, s : Double) -> GraphtreemstVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreemstVector::dot(self : GraphtreemstVector, other : GraphtreemstVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreemstVector::norm(self : GraphtreemstVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreemstVector::normalize(self : GraphtreemstVector) -> GraphtreemstVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreemstVector::dist(self : GraphtreemstVector, other : GraphtreemstVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreemstVector::to_string(self : GraphtreemstVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreemstFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_frame_make(size : Int) -> GraphtreemstFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstFrame::len(self : GraphtreemstFrame) -> Int { self.size }

pub fn GraphtreemstFrame::get(self : GraphtreemstFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstFrame::set(self : GraphtreemstFrame, i : Int, v : Double) -> GraphtreemstFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstFrame::sum(self : GraphtreemstFrame) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstFrame::mean(self : GraphtreemstFrame) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstFrame::scale(self : GraphtreemstFrame, f : Double) -> GraphtreemstFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstFrame::add(self : GraphtreemstFrame, other : GraphtreemstFrame) -> GraphtreemstFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstFrame::copy(self : GraphtreemstFrame) -> GraphtreemstFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstFrame::fill(self : GraphtreemstFrame, v : Double) -> GraphtreemstFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstFrame::min(self : GraphtreemstFrame) -> Double { @_common.min(self.data) }

pub fn GraphtreemstFrame::max(self : GraphtreemstFrame) -> Double { @_common.max(self.data) }

pub fn GraphtreemstFrame::to_string(self : GraphtreemstFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_table_make(size : Int) -> GraphtreemstTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstTable::len(self : GraphtreemstTable) -> Int { self.size }

pub fn GraphtreemstTable::get(self : GraphtreemstTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstTable::set(self : GraphtreemstTable, i : Int, v : Double) -> GraphtreemstTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstTable::sum(self : GraphtreemstTable) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstTable::mean(self : GraphtreemstTable) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstTable::scale(self : GraphtreemstTable, f : Double) -> GraphtreemstTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstTable::add(self : GraphtreemstTable, other : GraphtreemstTable) -> GraphtreemstTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstTable::copy(self : GraphtreemstTable) -> GraphtreemstTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstTable::fill(self : GraphtreemstTable, v : Double) -> GraphtreemstTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstTable::min(self : GraphtreemstTable) -> Double { @_common.min(self.data) }

pub fn GraphtreemstTable::max(self : GraphtreemstTable) -> Double { @_common.max(self.data) }

pub fn GraphtreemstTable::to_string(self : GraphtreemstTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_graphn_make(size : Int) -> GraphtreemstGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstGraphN::len(self : GraphtreemstGraphN) -> Int { self.size }

pub fn GraphtreemstGraphN::get(self : GraphtreemstGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstGraphN::set(self : GraphtreemstGraphN, i : Int, v : Double) -> GraphtreemstGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstGraphN::sum(self : GraphtreemstGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstGraphN::mean(self : GraphtreemstGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstGraphN::scale(self : GraphtreemstGraphN, f : Double) -> GraphtreemstGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstGraphN::add(self : GraphtreemstGraphN, other : GraphtreemstGraphN) -> GraphtreemstGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstGraphN::copy(self : GraphtreemstGraphN) -> GraphtreemstGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstGraphN::fill(self : GraphtreemstGraphN, v : Double) -> GraphtreemstGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstGraphN::min(self : GraphtreemstGraphN) -> Double { @_common.min(self.data) }

pub fn GraphtreemstGraphN::max(self : GraphtreemstGraphN) -> Double { @_common.max(self.data) }

pub fn GraphtreemstGraphN::to_string(self : GraphtreemstGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_node_make(size : Int) -> GraphtreemstNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstNode::len(self : GraphtreemstNode) -> Int { self.size }

pub fn GraphtreemstNode::get(self : GraphtreemstNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstNode::set(self : GraphtreemstNode, i : Int, v : Double) -> GraphtreemstNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstNode::sum(self : GraphtreemstNode) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstNode::mean(self : GraphtreemstNode) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstNode::scale(self : GraphtreemstNode, f : Double) -> GraphtreemstNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstNode::add(self : GraphtreemstNode, other : GraphtreemstNode) -> GraphtreemstNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstNode::copy(self : GraphtreemstNode) -> GraphtreemstNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstNode::fill(self : GraphtreemstNode, v : Double) -> GraphtreemstNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstNode::min(self : GraphtreemstNode) -> Double { @_common.min(self.data) }

pub fn GraphtreemstNode::max(self : GraphtreemstNode) -> Double { @_common.max(self.data) }

pub fn GraphtreemstNode::to_string(self : GraphtreemstNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_edge_make(size : Int) -> GraphtreemstEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstEdge::len(self : GraphtreemstEdge) -> Int { self.size }

pub fn GraphtreemstEdge::get(self : GraphtreemstEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstEdge::set(self : GraphtreemstEdge, i : Int, v : Double) -> GraphtreemstEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstEdge::sum(self : GraphtreemstEdge) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstEdge::mean(self : GraphtreemstEdge) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstEdge::scale(self : GraphtreemstEdge, f : Double) -> GraphtreemstEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstEdge::add(self : GraphtreemstEdge, other : GraphtreemstEdge) -> GraphtreemstEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstEdge::copy(self : GraphtreemstEdge) -> GraphtreemstEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstEdge::fill(self : GraphtreemstEdge, v : Double) -> GraphtreemstEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstEdge::min(self : GraphtreemstEdge) -> Double { @_common.min(self.data) }

pub fn GraphtreemstEdge::max(self : GraphtreemstEdge) -> Double { @_common.max(self.data) }

pub fn GraphtreemstEdge::to_string(self : GraphtreemstEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_path_make(size : Int) -> GraphtreemstPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstPath::len(self : GraphtreemstPath) -> Int { self.size }

pub fn GraphtreemstPath::get(self : GraphtreemstPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstPath::set(self : GraphtreemstPath, i : Int, v : Double) -> GraphtreemstPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstPath::sum(self : GraphtreemstPath) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstPath::mean(self : GraphtreemstPath) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstPath::scale(self : GraphtreemstPath, f : Double) -> GraphtreemstPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstPath::add(self : GraphtreemstPath, other : GraphtreemstPath) -> GraphtreemstPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstPath::copy(self : GraphtreemstPath) -> GraphtreemstPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstPath::fill(self : GraphtreemstPath, v : Double) -> GraphtreemstPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstPath::min(self : GraphtreemstPath) -> Double { @_common.min(self.data) }

pub fn GraphtreemstPath::max(self : GraphtreemstPath) -> Double { @_common.max(self.data) }

pub fn GraphtreemstPath::to_string(self : GraphtreemstPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_cluster_make(size : Int) -> GraphtreemstCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstCluster::len(self : GraphtreemstCluster) -> Int { self.size }

pub fn GraphtreemstCluster::get(self : GraphtreemstCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstCluster::set(self : GraphtreemstCluster, i : Int, v : Double) -> GraphtreemstCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstCluster::sum(self : GraphtreemstCluster) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstCluster::mean(self : GraphtreemstCluster) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstCluster::scale(self : GraphtreemstCluster, f : Double) -> GraphtreemstCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstCluster::add(self : GraphtreemstCluster, other : GraphtreemstCluster) -> GraphtreemstCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstCluster::copy(self : GraphtreemstCluster) -> GraphtreemstCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstCluster::fill(self : GraphtreemstCluster, v : Double) -> GraphtreemstCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstCluster::min(self : GraphtreemstCluster) -> Double { @_common.min(self.data) }

pub fn GraphtreemstCluster::max(self : GraphtreemstCluster) -> Double { @_common.max(self.data) }

pub fn GraphtreemstCluster::to_string(self : GraphtreemstCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_model_make(size : Int) -> GraphtreemstModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstModel::len(self : GraphtreemstModel) -> Int { self.size }

pub fn GraphtreemstModel::get(self : GraphtreemstModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstModel::set(self : GraphtreemstModel, i : Int, v : Double) -> GraphtreemstModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstModel::sum(self : GraphtreemstModel) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstModel::mean(self : GraphtreemstModel) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstModel::scale(self : GraphtreemstModel, f : Double) -> GraphtreemstModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstModel::add(self : GraphtreemstModel, other : GraphtreemstModel) -> GraphtreemstModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstModel::copy(self : GraphtreemstModel) -> GraphtreemstModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstModel::fill(self : GraphtreemstModel, v : Double) -> GraphtreemstModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstModel::min(self : GraphtreemstModel) -> Double { @_common.min(self.data) }

pub fn GraphtreemstModel::max(self : GraphtreemstModel) -> Double { @_common.max(self.data) }

pub fn GraphtreemstModel::to_string(self : GraphtreemstModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_layer_make(size : Int) -> GraphtreemstLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstLayer::len(self : GraphtreemstLayer) -> Int { self.size }

pub fn GraphtreemstLayer::get(self : GraphtreemstLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstLayer::set(self : GraphtreemstLayer, i : Int, v : Double) -> GraphtreemstLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstLayer::sum(self : GraphtreemstLayer) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstLayer::mean(self : GraphtreemstLayer) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstLayer::scale(self : GraphtreemstLayer, f : Double) -> GraphtreemstLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstLayer::add(self : GraphtreemstLayer, other : GraphtreemstLayer) -> GraphtreemstLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstLayer::copy(self : GraphtreemstLayer) -> GraphtreemstLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstLayer::fill(self : GraphtreemstLayer, v : Double) -> GraphtreemstLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstLayer::min(self : GraphtreemstLayer) -> Double { @_common.min(self.data) }

pub fn GraphtreemstLayer::max(self : GraphtreemstLayer) -> Double { @_common.max(self.data) }

pub fn GraphtreemstLayer::to_string(self : GraphtreemstLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_buffer_make(size : Int) -> GraphtreemstBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstBuffer::len(self : GraphtreemstBuffer) -> Int { self.size }

pub fn GraphtreemstBuffer::get(self : GraphtreemstBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstBuffer::set(self : GraphtreemstBuffer, i : Int, v : Double) -> GraphtreemstBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstBuffer::sum(self : GraphtreemstBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstBuffer::mean(self : GraphtreemstBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstBuffer::scale(self : GraphtreemstBuffer, f : Double) -> GraphtreemstBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstBuffer::add(self : GraphtreemstBuffer, other : GraphtreemstBuffer) -> GraphtreemstBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstBuffer::copy(self : GraphtreemstBuffer) -> GraphtreemstBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstBuffer::fill(self : GraphtreemstBuffer, v : Double) -> GraphtreemstBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstBuffer::min(self : GraphtreemstBuffer) -> Double { @_common.min(self.data) }

pub fn GraphtreemstBuffer::max(self : GraphtreemstBuffer) -> Double { @_common.max(self.data) }

pub fn GraphtreemstBuffer::to_string(self : GraphtreemstBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_cursor_make(size : Int) -> GraphtreemstCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstCursor::len(self : GraphtreemstCursor) -> Int { self.size }

pub fn GraphtreemstCursor::get(self : GraphtreemstCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstCursor::set(self : GraphtreemstCursor, i : Int, v : Double) -> GraphtreemstCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstCursor::sum(self : GraphtreemstCursor) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstCursor::mean(self : GraphtreemstCursor) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstCursor::scale(self : GraphtreemstCursor, f : Double) -> GraphtreemstCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstCursor::add(self : GraphtreemstCursor, other : GraphtreemstCursor) -> GraphtreemstCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstCursor::copy(self : GraphtreemstCursor) -> GraphtreemstCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstCursor::fill(self : GraphtreemstCursor, v : Double) -> GraphtreemstCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstCursor::min(self : GraphtreemstCursor) -> Double { @_common.min(self.data) }

pub fn GraphtreemstCursor::max(self : GraphtreemstCursor) -> Double { @_common.max(self.data) }

pub fn GraphtreemstCursor::to_string(self : GraphtreemstCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_view_make(size : Int) -> GraphtreemstView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstView::len(self : GraphtreemstView) -> Int { self.size }

pub fn GraphtreemstView::get(self : GraphtreemstView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstView::set(self : GraphtreemstView, i : Int, v : Double) -> GraphtreemstView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstView::sum(self : GraphtreemstView) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstView::mean(self : GraphtreemstView) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstView::scale(self : GraphtreemstView, f : Double) -> GraphtreemstView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstView::add(self : GraphtreemstView, other : GraphtreemstView) -> GraphtreemstView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstView::copy(self : GraphtreemstView) -> GraphtreemstView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstView::fill(self : GraphtreemstView, v : Double) -> GraphtreemstView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstView::min(self : GraphtreemstView) -> Double { @_common.min(self.data) }

pub fn GraphtreemstView::max(self : GraphtreemstView) -> Double { @_common.max(self.data) }

pub fn GraphtreemstView::to_string(self : GraphtreemstView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_range_make(size : Int) -> GraphtreemstRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstRange::len(self : GraphtreemstRange) -> Int { self.size }

pub fn GraphtreemstRange::get(self : GraphtreemstRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstRange::set(self : GraphtreemstRange, i : Int, v : Double) -> GraphtreemstRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstRange::sum(self : GraphtreemstRange) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstRange::mean(self : GraphtreemstRange) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstRange::scale(self : GraphtreemstRange, f : Double) -> GraphtreemstRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstRange::add(self : GraphtreemstRange, other : GraphtreemstRange) -> GraphtreemstRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstRange::copy(self : GraphtreemstRange) -> GraphtreemstRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstRange::fill(self : GraphtreemstRange, v : Double) -> GraphtreemstRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstRange::min(self : GraphtreemstRange) -> Double { @_common.min(self.data) }

pub fn GraphtreemstRange::max(self : GraphtreemstRange) -> Double { @_common.max(self.data) }

pub fn GraphtreemstRange::to_string(self : GraphtreemstRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreemstSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_slice_make(size : Int) -> GraphtreemstSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreemstSlice::len(self : GraphtreemstSlice) -> Int { self.size }

pub fn GraphtreemstSlice::get(self : GraphtreemstSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreemstSlice::set(self : GraphtreemstSlice, i : Int, v : Double) -> GraphtreemstSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreemstSlice::sum(self : GraphtreemstSlice) -> Double { @_common.sum(self.data) }

pub fn GraphtreemstSlice::mean(self : GraphtreemstSlice) -> Double { @_common.mean(self.data) }

pub fn GraphtreemstSlice::scale(self : GraphtreemstSlice, f : Double) -> GraphtreemstSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreemstSlice::add(self : GraphtreemstSlice, other : GraphtreemstSlice) -> GraphtreemstSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreemstSlice::copy(self : GraphtreemstSlice) -> GraphtreemstSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreemstSlice::fill(self : GraphtreemstSlice, v : Double) -> GraphtreemstSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreemstSlice::min(self : GraphtreemstSlice) -> Double { @_common.min(self.data) }

pub fn GraphtreemstSlice::max(self : GraphtreemstSlice) -> Double { @_common.max(self.data) }

pub fn GraphtreemstSlice::to_string(self : GraphtreemstSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

