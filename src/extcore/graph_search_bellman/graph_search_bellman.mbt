///===
/// extcore/graph_search_bellman

pub(all) struct GraphsearchbellmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_bellman_make_point(x : Double, y : Double) -> GraphsearchbellmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_bellman_make_point3(x : Double, y : Double, z : Double) -> GraphsearchbellmanPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchbellmanPoint::x(self : GraphsearchbellmanPoint) -> Double { self.x }

pub fn GraphsearchbellmanPoint::y(self : GraphsearchbellmanPoint) -> Double { self.y }

pub fn GraphsearchbellmanPoint::z(self : GraphsearchbellmanPoint) -> Double { self.z }

pub fn GraphsearchbellmanPoint::label(self : GraphsearchbellmanPoint) -> Int { self.label }

pub fn GraphsearchbellmanPoint::dist(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchbellmanPoint::add(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchbellmanPoint::sub(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchbellmanPoint::scale(self : GraphsearchbellmanPoint, s : Double) -> GraphsearchbellmanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchbellmanPoint::dot(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchbellmanPoint::cross(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchbellmanPoint::norm(self : GraphsearchbellmanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchbellmanPoint::normalize(self : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbellmanPoint::negate(self : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchbellmanPoint::mid(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchbellmanPoint::lerp(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint, t : Double) -> GraphsearchbellmanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchbellmanPoint::to_string(self : GraphsearchbellmanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchbellmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_bellman_make_series(vals : Array[Double], name : String) -> GraphsearchbellmanSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchbellmanSeries::len(self : GraphsearchbellmanSeries) -> Int { self.vals.length() }

pub fn GraphsearchbellmanSeries::sum(self : GraphsearchbellmanSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchbellmanSeries::mean(self : GraphsearchbellmanSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchbellmanSeries::min(self : GraphsearchbellmanSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchbellmanSeries::max(self : GraphsearchbellmanSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchbellmanSeries::range(self : GraphsearchbellmanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchbellmanSeries::variance(self : GraphsearchbellmanSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchbellmanSeries::std(self : GraphsearchbellmanSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchbellmanSeries::median(self : GraphsearchbellmanSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchbellmanSeries::scale(self : GraphsearchbellmanSeries, f : Double) -> GraphsearchbellmanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchbellmanSeries::add(self : GraphsearchbellmanSeries, other : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchbellmanSeries::sub(self : GraphsearchbellmanSeries, other : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchbellmanSeries::normalize(self : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchbellmanSeries::cumsum(self : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchbellmanSeries::to_string(self : GraphsearchbellmanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbellmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_bellman_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchbellmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_bellman_matrix_identity(n : Int) -> GraphsearchbellmanMatrix {
  let m = graph_search_bellman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchbellmanMatrix::get(self : GraphsearchbellmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchbellmanMatrix::transpose(self : GraphsearchbellmanMatrix) -> GraphsearchbellmanMatrix {
  let result = graph_search_bellman_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchbellmanMatrix::add(self : GraphsearchbellmanMatrix, other : GraphsearchbellmanMatrix) -> GraphsearchbellmanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_bellman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchbellmanMatrix::scale(self : GraphsearchbellmanMatrix, s : Double) -> GraphsearchbellmanMatrix {
  let result = graph_search_bellman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchbellmanMatrix::multiply(self : GraphsearchbellmanMatrix, other : GraphsearchbellmanMatrix) -> GraphsearchbellmanMatrix {
  if self.cols != other.rows { return graph_search_bellman_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_bellman_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchbellmanMatrix::trace(self : GraphsearchbellmanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchbellmanMatrix::det(self : GraphsearchbellmanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchbellmanMatrix::norm(self : GraphsearchbellmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchbellmanMatrix::to_string(self : GraphsearchbellmanMatrix) -> String {
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

pub(all) struct GraphsearchbellmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_bellman_make_vector(comps : Array[Double]) -> GraphsearchbellmanVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_bellman_vector_zero(dim : Int) -> GraphsearchbellmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchbellmanVector::add(self : GraphsearchbellmanVector, other : GraphsearchbellmanVector) -> GraphsearchbellmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbellmanVector::sub(self : GraphsearchbellmanVector, other : GraphsearchbellmanVector) -> GraphsearchbellmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbellmanVector::scale(self : GraphsearchbellmanVector, s : Double) -> GraphsearchbellmanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchbellmanVector::dot(self : GraphsearchbellmanVector, other : GraphsearchbellmanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchbellmanVector::norm(self : GraphsearchbellmanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchbellmanVector::normalize(self : GraphsearchbellmanVector) -> GraphsearchbellmanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbellmanVector::dist(self : GraphsearchbellmanVector, other : GraphsearchbellmanVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchbellmanVector::to_string(self : GraphsearchbellmanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbellmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_frame_make(size : Int) -> GraphsearchbellmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanFrame::len(self : GraphsearchbellmanFrame) -> Int { self.size }

pub fn GraphsearchbellmanFrame::get(self : GraphsearchbellmanFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanFrame::set(self : GraphsearchbellmanFrame, i : Int, v : Double) -> GraphsearchbellmanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanFrame::sum(self : GraphsearchbellmanFrame) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanFrame::mean(self : GraphsearchbellmanFrame) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanFrame::scale(self : GraphsearchbellmanFrame, f : Double) -> GraphsearchbellmanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanFrame::add(self : GraphsearchbellmanFrame, other : GraphsearchbellmanFrame) -> GraphsearchbellmanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanFrame::copy(self : GraphsearchbellmanFrame) -> GraphsearchbellmanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanFrame::fill(self : GraphsearchbellmanFrame, v : Double) -> GraphsearchbellmanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanFrame::min(self : GraphsearchbellmanFrame) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanFrame::max(self : GraphsearchbellmanFrame) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanFrame::to_string(self : GraphsearchbellmanFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_table_make(size : Int) -> GraphsearchbellmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanTable::len(self : GraphsearchbellmanTable) -> Int { self.size }

pub fn GraphsearchbellmanTable::get(self : GraphsearchbellmanTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanTable::set(self : GraphsearchbellmanTable, i : Int, v : Double) -> GraphsearchbellmanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanTable::sum(self : GraphsearchbellmanTable) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanTable::mean(self : GraphsearchbellmanTable) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanTable::scale(self : GraphsearchbellmanTable, f : Double) -> GraphsearchbellmanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanTable::add(self : GraphsearchbellmanTable, other : GraphsearchbellmanTable) -> GraphsearchbellmanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanTable::copy(self : GraphsearchbellmanTable) -> GraphsearchbellmanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanTable::fill(self : GraphsearchbellmanTable, v : Double) -> GraphsearchbellmanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanTable::min(self : GraphsearchbellmanTable) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanTable::max(self : GraphsearchbellmanTable) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanTable::to_string(self : GraphsearchbellmanTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_graphn_make(size : Int) -> GraphsearchbellmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanGraphN::len(self : GraphsearchbellmanGraphN) -> Int { self.size }

pub fn GraphsearchbellmanGraphN::get(self : GraphsearchbellmanGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanGraphN::set(self : GraphsearchbellmanGraphN, i : Int, v : Double) -> GraphsearchbellmanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanGraphN::sum(self : GraphsearchbellmanGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanGraphN::mean(self : GraphsearchbellmanGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanGraphN::scale(self : GraphsearchbellmanGraphN, f : Double) -> GraphsearchbellmanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanGraphN::add(self : GraphsearchbellmanGraphN, other : GraphsearchbellmanGraphN) -> GraphsearchbellmanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanGraphN::copy(self : GraphsearchbellmanGraphN) -> GraphsearchbellmanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanGraphN::fill(self : GraphsearchbellmanGraphN, v : Double) -> GraphsearchbellmanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanGraphN::min(self : GraphsearchbellmanGraphN) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanGraphN::max(self : GraphsearchbellmanGraphN) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanGraphN::to_string(self : GraphsearchbellmanGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_node_make(size : Int) -> GraphsearchbellmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanNode::len(self : GraphsearchbellmanNode) -> Int { self.size }

pub fn GraphsearchbellmanNode::get(self : GraphsearchbellmanNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanNode::set(self : GraphsearchbellmanNode, i : Int, v : Double) -> GraphsearchbellmanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanNode::sum(self : GraphsearchbellmanNode) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanNode::mean(self : GraphsearchbellmanNode) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanNode::scale(self : GraphsearchbellmanNode, f : Double) -> GraphsearchbellmanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanNode::add(self : GraphsearchbellmanNode, other : GraphsearchbellmanNode) -> GraphsearchbellmanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanNode::copy(self : GraphsearchbellmanNode) -> GraphsearchbellmanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanNode::fill(self : GraphsearchbellmanNode, v : Double) -> GraphsearchbellmanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanNode::min(self : GraphsearchbellmanNode) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanNode::max(self : GraphsearchbellmanNode) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanNode::to_string(self : GraphsearchbellmanNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_edge_make(size : Int) -> GraphsearchbellmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanEdge::len(self : GraphsearchbellmanEdge) -> Int { self.size }

pub fn GraphsearchbellmanEdge::get(self : GraphsearchbellmanEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanEdge::set(self : GraphsearchbellmanEdge, i : Int, v : Double) -> GraphsearchbellmanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanEdge::sum(self : GraphsearchbellmanEdge) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanEdge::mean(self : GraphsearchbellmanEdge) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanEdge::scale(self : GraphsearchbellmanEdge, f : Double) -> GraphsearchbellmanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanEdge::add(self : GraphsearchbellmanEdge, other : GraphsearchbellmanEdge) -> GraphsearchbellmanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanEdge::copy(self : GraphsearchbellmanEdge) -> GraphsearchbellmanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanEdge::fill(self : GraphsearchbellmanEdge, v : Double) -> GraphsearchbellmanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanEdge::min(self : GraphsearchbellmanEdge) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanEdge::max(self : GraphsearchbellmanEdge) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanEdge::to_string(self : GraphsearchbellmanEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_path_make(size : Int) -> GraphsearchbellmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanPath::len(self : GraphsearchbellmanPath) -> Int { self.size }

pub fn GraphsearchbellmanPath::get(self : GraphsearchbellmanPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanPath::set(self : GraphsearchbellmanPath, i : Int, v : Double) -> GraphsearchbellmanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanPath::sum(self : GraphsearchbellmanPath) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanPath::mean(self : GraphsearchbellmanPath) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanPath::scale(self : GraphsearchbellmanPath, f : Double) -> GraphsearchbellmanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanPath::add(self : GraphsearchbellmanPath, other : GraphsearchbellmanPath) -> GraphsearchbellmanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanPath::copy(self : GraphsearchbellmanPath) -> GraphsearchbellmanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanPath::fill(self : GraphsearchbellmanPath, v : Double) -> GraphsearchbellmanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanPath::min(self : GraphsearchbellmanPath) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanPath::max(self : GraphsearchbellmanPath) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanPath::to_string(self : GraphsearchbellmanPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_cluster_make(size : Int) -> GraphsearchbellmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanCluster::len(self : GraphsearchbellmanCluster) -> Int { self.size }

pub fn GraphsearchbellmanCluster::get(self : GraphsearchbellmanCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanCluster::set(self : GraphsearchbellmanCluster, i : Int, v : Double) -> GraphsearchbellmanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanCluster::sum(self : GraphsearchbellmanCluster) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanCluster::mean(self : GraphsearchbellmanCluster) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanCluster::scale(self : GraphsearchbellmanCluster, f : Double) -> GraphsearchbellmanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanCluster::add(self : GraphsearchbellmanCluster, other : GraphsearchbellmanCluster) -> GraphsearchbellmanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanCluster::copy(self : GraphsearchbellmanCluster) -> GraphsearchbellmanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanCluster::fill(self : GraphsearchbellmanCluster, v : Double) -> GraphsearchbellmanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanCluster::min(self : GraphsearchbellmanCluster) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanCluster::max(self : GraphsearchbellmanCluster) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanCluster::to_string(self : GraphsearchbellmanCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_model_make(size : Int) -> GraphsearchbellmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanModel::len(self : GraphsearchbellmanModel) -> Int { self.size }

pub fn GraphsearchbellmanModel::get(self : GraphsearchbellmanModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanModel::set(self : GraphsearchbellmanModel, i : Int, v : Double) -> GraphsearchbellmanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanModel::sum(self : GraphsearchbellmanModel) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanModel::mean(self : GraphsearchbellmanModel) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanModel::scale(self : GraphsearchbellmanModel, f : Double) -> GraphsearchbellmanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanModel::add(self : GraphsearchbellmanModel, other : GraphsearchbellmanModel) -> GraphsearchbellmanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanModel::copy(self : GraphsearchbellmanModel) -> GraphsearchbellmanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanModel::fill(self : GraphsearchbellmanModel, v : Double) -> GraphsearchbellmanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanModel::min(self : GraphsearchbellmanModel) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanModel::max(self : GraphsearchbellmanModel) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanModel::to_string(self : GraphsearchbellmanModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_layer_make(size : Int) -> GraphsearchbellmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanLayer::len(self : GraphsearchbellmanLayer) -> Int { self.size }

pub fn GraphsearchbellmanLayer::get(self : GraphsearchbellmanLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanLayer::set(self : GraphsearchbellmanLayer, i : Int, v : Double) -> GraphsearchbellmanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanLayer::sum(self : GraphsearchbellmanLayer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanLayer::mean(self : GraphsearchbellmanLayer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanLayer::scale(self : GraphsearchbellmanLayer, f : Double) -> GraphsearchbellmanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanLayer::add(self : GraphsearchbellmanLayer, other : GraphsearchbellmanLayer) -> GraphsearchbellmanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanLayer::copy(self : GraphsearchbellmanLayer) -> GraphsearchbellmanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanLayer::fill(self : GraphsearchbellmanLayer, v : Double) -> GraphsearchbellmanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanLayer::min(self : GraphsearchbellmanLayer) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanLayer::max(self : GraphsearchbellmanLayer) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanLayer::to_string(self : GraphsearchbellmanLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_buffer_make(size : Int) -> GraphsearchbellmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanBuffer::len(self : GraphsearchbellmanBuffer) -> Int { self.size }

pub fn GraphsearchbellmanBuffer::get(self : GraphsearchbellmanBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanBuffer::set(self : GraphsearchbellmanBuffer, i : Int, v : Double) -> GraphsearchbellmanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanBuffer::sum(self : GraphsearchbellmanBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanBuffer::mean(self : GraphsearchbellmanBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanBuffer::scale(self : GraphsearchbellmanBuffer, f : Double) -> GraphsearchbellmanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanBuffer::add(self : GraphsearchbellmanBuffer, other : GraphsearchbellmanBuffer) -> GraphsearchbellmanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanBuffer::copy(self : GraphsearchbellmanBuffer) -> GraphsearchbellmanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanBuffer::fill(self : GraphsearchbellmanBuffer, v : Double) -> GraphsearchbellmanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanBuffer::min(self : GraphsearchbellmanBuffer) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanBuffer::max(self : GraphsearchbellmanBuffer) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanBuffer::to_string(self : GraphsearchbellmanBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_cursor_make(size : Int) -> GraphsearchbellmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanCursor::len(self : GraphsearchbellmanCursor) -> Int { self.size }

pub fn GraphsearchbellmanCursor::get(self : GraphsearchbellmanCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanCursor::set(self : GraphsearchbellmanCursor, i : Int, v : Double) -> GraphsearchbellmanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanCursor::sum(self : GraphsearchbellmanCursor) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanCursor::mean(self : GraphsearchbellmanCursor) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanCursor::scale(self : GraphsearchbellmanCursor, f : Double) -> GraphsearchbellmanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanCursor::add(self : GraphsearchbellmanCursor, other : GraphsearchbellmanCursor) -> GraphsearchbellmanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanCursor::copy(self : GraphsearchbellmanCursor) -> GraphsearchbellmanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanCursor::fill(self : GraphsearchbellmanCursor, v : Double) -> GraphsearchbellmanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanCursor::min(self : GraphsearchbellmanCursor) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanCursor::max(self : GraphsearchbellmanCursor) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanCursor::to_string(self : GraphsearchbellmanCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_view_make(size : Int) -> GraphsearchbellmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanView::len(self : GraphsearchbellmanView) -> Int { self.size }

pub fn GraphsearchbellmanView::get(self : GraphsearchbellmanView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanView::set(self : GraphsearchbellmanView, i : Int, v : Double) -> GraphsearchbellmanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanView::sum(self : GraphsearchbellmanView) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanView::mean(self : GraphsearchbellmanView) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanView::scale(self : GraphsearchbellmanView, f : Double) -> GraphsearchbellmanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanView::add(self : GraphsearchbellmanView, other : GraphsearchbellmanView) -> GraphsearchbellmanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanView::copy(self : GraphsearchbellmanView) -> GraphsearchbellmanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanView::fill(self : GraphsearchbellmanView, v : Double) -> GraphsearchbellmanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanView::min(self : GraphsearchbellmanView) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanView::max(self : GraphsearchbellmanView) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanView::to_string(self : GraphsearchbellmanView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_range_make(size : Int) -> GraphsearchbellmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanRange::len(self : GraphsearchbellmanRange) -> Int { self.size }

pub fn GraphsearchbellmanRange::get(self : GraphsearchbellmanRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanRange::set(self : GraphsearchbellmanRange, i : Int, v : Double) -> GraphsearchbellmanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanRange::sum(self : GraphsearchbellmanRange) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanRange::mean(self : GraphsearchbellmanRange) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanRange::scale(self : GraphsearchbellmanRange, f : Double) -> GraphsearchbellmanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanRange::add(self : GraphsearchbellmanRange, other : GraphsearchbellmanRange) -> GraphsearchbellmanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanRange::copy(self : GraphsearchbellmanRange) -> GraphsearchbellmanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanRange::fill(self : GraphsearchbellmanRange, v : Double) -> GraphsearchbellmanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanRange::min(self : GraphsearchbellmanRange) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanRange::max(self : GraphsearchbellmanRange) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanRange::to_string(self : GraphsearchbellmanRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_slice_make(size : Int) -> GraphsearchbellmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbellmanSlice::len(self : GraphsearchbellmanSlice) -> Int { self.size }

pub fn GraphsearchbellmanSlice::get(self : GraphsearchbellmanSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbellmanSlice::set(self : GraphsearchbellmanSlice, i : Int, v : Double) -> GraphsearchbellmanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanSlice::sum(self : GraphsearchbellmanSlice) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbellmanSlice::mean(self : GraphsearchbellmanSlice) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbellmanSlice::scale(self : GraphsearchbellmanSlice, f : Double) -> GraphsearchbellmanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanSlice::add(self : GraphsearchbellmanSlice, other : GraphsearchbellmanSlice) -> GraphsearchbellmanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbellmanSlice::copy(self : GraphsearchbellmanSlice) -> GraphsearchbellmanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanSlice::fill(self : GraphsearchbellmanSlice, v : Double) -> GraphsearchbellmanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbellmanSlice::min(self : GraphsearchbellmanSlice) -> Double { @_common.min(self.data) }

pub fn GraphsearchbellmanSlice::max(self : GraphsearchbellmanSlice) -> Double { @_common.max(self.data) }

pub fn GraphsearchbellmanSlice::to_string(self : GraphsearchbellmanSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

