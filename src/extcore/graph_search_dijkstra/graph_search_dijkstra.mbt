///===
/// extcore/graph_search_dijkstra

pub(all) struct GraphsearchdijkstraPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_dijkstra_make_point(x : Double, y : Double) -> GraphsearchdijkstraPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_dijkstra_make_point3(x : Double, y : Double, z : Double) -> GraphsearchdijkstraPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchdijkstraPoint::x(self : GraphsearchdijkstraPoint) -> Double { self.x }

pub fn GraphsearchdijkstraPoint::y(self : GraphsearchdijkstraPoint) -> Double { self.y }

pub fn GraphsearchdijkstraPoint::z(self : GraphsearchdijkstraPoint) -> Double { self.z }

pub fn GraphsearchdijkstraPoint::label(self : GraphsearchdijkstraPoint) -> Int { self.label }

pub fn GraphsearchdijkstraPoint::dist(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchdijkstraPoint::add(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchdijkstraPoint::sub(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchdijkstraPoint::scale(self : GraphsearchdijkstraPoint, s : Double) -> GraphsearchdijkstraPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchdijkstraPoint::dot(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchdijkstraPoint::cross(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchdijkstraPoint::norm(self : GraphsearchdijkstraPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchdijkstraPoint::normalize(self : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchdijkstraPoint::negate(self : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchdijkstraPoint::mid(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchdijkstraPoint::lerp(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint, t : Double) -> GraphsearchdijkstraPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchdijkstraPoint::to_string(self : GraphsearchdijkstraPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_dijkstra_make_series(vals : Array[Double], name : String) -> GraphsearchdijkstraSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchdijkstraSeries::len(self : GraphsearchdijkstraSeries) -> Int { self.vals.length() }

pub fn GraphsearchdijkstraSeries::sum(self : GraphsearchdijkstraSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchdijkstraSeries::mean(self : GraphsearchdijkstraSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchdijkstraSeries::min(self : GraphsearchdijkstraSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchdijkstraSeries::max(self : GraphsearchdijkstraSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchdijkstraSeries::range(self : GraphsearchdijkstraSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchdijkstraSeries::variance(self : GraphsearchdijkstraSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchdijkstraSeries::std(self : GraphsearchdijkstraSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchdijkstraSeries::median(self : GraphsearchdijkstraSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchdijkstraSeries::scale(self : GraphsearchdijkstraSeries, f : Double) -> GraphsearchdijkstraSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchdijkstraSeries::add(self : GraphsearchdijkstraSeries, other : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchdijkstraSeries::sub(self : GraphsearchdijkstraSeries, other : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchdijkstraSeries::normalize(self : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchdijkstraSeries::cumsum(self : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchdijkstraSeries::to_string(self : GraphsearchdijkstraSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchdijkstraMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_dijkstra_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchdijkstraMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_dijkstra_matrix_identity(n : Int) -> GraphsearchdijkstraMatrix {
  let m = graph_search_dijkstra_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchdijkstraMatrix::get(self : GraphsearchdijkstraMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchdijkstraMatrix::transpose(self : GraphsearchdijkstraMatrix) -> GraphsearchdijkstraMatrix {
  let result = graph_search_dijkstra_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchdijkstraMatrix::add(self : GraphsearchdijkstraMatrix, other : GraphsearchdijkstraMatrix) -> GraphsearchdijkstraMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_dijkstra_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchdijkstraMatrix::scale(self : GraphsearchdijkstraMatrix, s : Double) -> GraphsearchdijkstraMatrix {
  let result = graph_search_dijkstra_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchdijkstraMatrix::multiply(self : GraphsearchdijkstraMatrix, other : GraphsearchdijkstraMatrix) -> GraphsearchdijkstraMatrix {
  if self.cols != other.rows { return graph_search_dijkstra_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_dijkstra_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphsearchdijkstraMatrix::trace(self : GraphsearchdijkstraMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchdijkstraMatrix::det(self : GraphsearchdijkstraMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchdijkstraMatrix::norm(self : GraphsearchdijkstraMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchdijkstraMatrix::to_string(self : GraphsearchdijkstraMatrix) -> String {
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

pub(all) struct GraphsearchdijkstraVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_dijkstra_make_vector(comps : Array[Double]) -> GraphsearchdijkstraVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_dijkstra_vector_zero(dim : Int) -> GraphsearchdijkstraVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchdijkstraVector::add(self : GraphsearchdijkstraVector, other : GraphsearchdijkstraVector) -> GraphsearchdijkstraVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchdijkstraVector::sub(self : GraphsearchdijkstraVector, other : GraphsearchdijkstraVector) -> GraphsearchdijkstraVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchdijkstraVector::scale(self : GraphsearchdijkstraVector, s : Double) -> GraphsearchdijkstraVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchdijkstraVector::dot(self : GraphsearchdijkstraVector, other : GraphsearchdijkstraVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchdijkstraVector::norm(self : GraphsearchdijkstraVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchdijkstraVector::normalize(self : GraphsearchdijkstraVector) -> GraphsearchdijkstraVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchdijkstraVector::dist(self : GraphsearchdijkstraVector, other : GraphsearchdijkstraVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchdijkstraVector::to_string(self : GraphsearchdijkstraVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchdijkstraFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_frame_make(size : Int) -> GraphsearchdijkstraFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraFrame::len(self : GraphsearchdijkstraFrame) -> Int { self.size }

pub fn GraphsearchdijkstraFrame::get(self : GraphsearchdijkstraFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraFrame::set(self : GraphsearchdijkstraFrame, i : Int, v : Double) -> GraphsearchdijkstraFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraFrame::sum(self : GraphsearchdijkstraFrame) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraFrame::mean(self : GraphsearchdijkstraFrame) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraFrame::scale(self : GraphsearchdijkstraFrame, f : Double) -> GraphsearchdijkstraFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraFrame::add(self : GraphsearchdijkstraFrame, other : GraphsearchdijkstraFrame) -> GraphsearchdijkstraFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraFrame::copy(self : GraphsearchdijkstraFrame) -> GraphsearchdijkstraFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraFrame::fill(self : GraphsearchdijkstraFrame, v : Double) -> GraphsearchdijkstraFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraFrame::min(self : GraphsearchdijkstraFrame) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraFrame::max(self : GraphsearchdijkstraFrame) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraFrame::to_string(self : GraphsearchdijkstraFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_table_make(size : Int) -> GraphsearchdijkstraTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraTable::len(self : GraphsearchdijkstraTable) -> Int { self.size }

pub fn GraphsearchdijkstraTable::get(self : GraphsearchdijkstraTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraTable::set(self : GraphsearchdijkstraTable, i : Int, v : Double) -> GraphsearchdijkstraTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraTable::sum(self : GraphsearchdijkstraTable) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraTable::mean(self : GraphsearchdijkstraTable) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraTable::scale(self : GraphsearchdijkstraTable, f : Double) -> GraphsearchdijkstraTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraTable::add(self : GraphsearchdijkstraTable, other : GraphsearchdijkstraTable) -> GraphsearchdijkstraTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraTable::copy(self : GraphsearchdijkstraTable) -> GraphsearchdijkstraTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraTable::fill(self : GraphsearchdijkstraTable, v : Double) -> GraphsearchdijkstraTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraTable::min(self : GraphsearchdijkstraTable) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraTable::max(self : GraphsearchdijkstraTable) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraTable::to_string(self : GraphsearchdijkstraTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_graphn_make(size : Int) -> GraphsearchdijkstraGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraGraphN::len(self : GraphsearchdijkstraGraphN) -> Int { self.size }

pub fn GraphsearchdijkstraGraphN::get(self : GraphsearchdijkstraGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraGraphN::set(self : GraphsearchdijkstraGraphN, i : Int, v : Double) -> GraphsearchdijkstraGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraGraphN::sum(self : GraphsearchdijkstraGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraGraphN::mean(self : GraphsearchdijkstraGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraGraphN::scale(self : GraphsearchdijkstraGraphN, f : Double) -> GraphsearchdijkstraGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraGraphN::add(self : GraphsearchdijkstraGraphN, other : GraphsearchdijkstraGraphN) -> GraphsearchdijkstraGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraGraphN::copy(self : GraphsearchdijkstraGraphN) -> GraphsearchdijkstraGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraGraphN::fill(self : GraphsearchdijkstraGraphN, v : Double) -> GraphsearchdijkstraGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraGraphN::min(self : GraphsearchdijkstraGraphN) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraGraphN::max(self : GraphsearchdijkstraGraphN) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraGraphN::to_string(self : GraphsearchdijkstraGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_node_make(size : Int) -> GraphsearchdijkstraNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraNode::len(self : GraphsearchdijkstraNode) -> Int { self.size }

pub fn GraphsearchdijkstraNode::get(self : GraphsearchdijkstraNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraNode::set(self : GraphsearchdijkstraNode, i : Int, v : Double) -> GraphsearchdijkstraNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraNode::sum(self : GraphsearchdijkstraNode) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraNode::mean(self : GraphsearchdijkstraNode) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraNode::scale(self : GraphsearchdijkstraNode, f : Double) -> GraphsearchdijkstraNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraNode::add(self : GraphsearchdijkstraNode, other : GraphsearchdijkstraNode) -> GraphsearchdijkstraNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraNode::copy(self : GraphsearchdijkstraNode) -> GraphsearchdijkstraNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraNode::fill(self : GraphsearchdijkstraNode, v : Double) -> GraphsearchdijkstraNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraNode::min(self : GraphsearchdijkstraNode) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraNode::max(self : GraphsearchdijkstraNode) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraNode::to_string(self : GraphsearchdijkstraNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_edge_make(size : Int) -> GraphsearchdijkstraEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraEdge::len(self : GraphsearchdijkstraEdge) -> Int { self.size }

pub fn GraphsearchdijkstraEdge::get(self : GraphsearchdijkstraEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraEdge::set(self : GraphsearchdijkstraEdge, i : Int, v : Double) -> GraphsearchdijkstraEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraEdge::sum(self : GraphsearchdijkstraEdge) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraEdge::mean(self : GraphsearchdijkstraEdge) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraEdge::scale(self : GraphsearchdijkstraEdge, f : Double) -> GraphsearchdijkstraEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraEdge::add(self : GraphsearchdijkstraEdge, other : GraphsearchdijkstraEdge) -> GraphsearchdijkstraEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraEdge::copy(self : GraphsearchdijkstraEdge) -> GraphsearchdijkstraEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraEdge::fill(self : GraphsearchdijkstraEdge, v : Double) -> GraphsearchdijkstraEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraEdge::min(self : GraphsearchdijkstraEdge) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraEdge::max(self : GraphsearchdijkstraEdge) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraEdge::to_string(self : GraphsearchdijkstraEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_path_make(size : Int) -> GraphsearchdijkstraPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraPath::len(self : GraphsearchdijkstraPath) -> Int { self.size }

pub fn GraphsearchdijkstraPath::get(self : GraphsearchdijkstraPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraPath::set(self : GraphsearchdijkstraPath, i : Int, v : Double) -> GraphsearchdijkstraPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraPath::sum(self : GraphsearchdijkstraPath) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraPath::mean(self : GraphsearchdijkstraPath) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraPath::scale(self : GraphsearchdijkstraPath, f : Double) -> GraphsearchdijkstraPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraPath::add(self : GraphsearchdijkstraPath, other : GraphsearchdijkstraPath) -> GraphsearchdijkstraPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraPath::copy(self : GraphsearchdijkstraPath) -> GraphsearchdijkstraPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraPath::fill(self : GraphsearchdijkstraPath, v : Double) -> GraphsearchdijkstraPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraPath::min(self : GraphsearchdijkstraPath) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraPath::max(self : GraphsearchdijkstraPath) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraPath::to_string(self : GraphsearchdijkstraPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_cluster_make(size : Int) -> GraphsearchdijkstraCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraCluster::len(self : GraphsearchdijkstraCluster) -> Int { self.size }

pub fn GraphsearchdijkstraCluster::get(self : GraphsearchdijkstraCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraCluster::set(self : GraphsearchdijkstraCluster, i : Int, v : Double) -> GraphsearchdijkstraCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraCluster::sum(self : GraphsearchdijkstraCluster) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraCluster::mean(self : GraphsearchdijkstraCluster) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraCluster::scale(self : GraphsearchdijkstraCluster, f : Double) -> GraphsearchdijkstraCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraCluster::add(self : GraphsearchdijkstraCluster, other : GraphsearchdijkstraCluster) -> GraphsearchdijkstraCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraCluster::copy(self : GraphsearchdijkstraCluster) -> GraphsearchdijkstraCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraCluster::fill(self : GraphsearchdijkstraCluster, v : Double) -> GraphsearchdijkstraCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraCluster::min(self : GraphsearchdijkstraCluster) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraCluster::max(self : GraphsearchdijkstraCluster) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraCluster::to_string(self : GraphsearchdijkstraCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_model_make(size : Int) -> GraphsearchdijkstraModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraModel::len(self : GraphsearchdijkstraModel) -> Int { self.size }

pub fn GraphsearchdijkstraModel::get(self : GraphsearchdijkstraModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraModel::set(self : GraphsearchdijkstraModel, i : Int, v : Double) -> GraphsearchdijkstraModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraModel::sum(self : GraphsearchdijkstraModel) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraModel::mean(self : GraphsearchdijkstraModel) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraModel::scale(self : GraphsearchdijkstraModel, f : Double) -> GraphsearchdijkstraModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraModel::add(self : GraphsearchdijkstraModel, other : GraphsearchdijkstraModel) -> GraphsearchdijkstraModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraModel::copy(self : GraphsearchdijkstraModel) -> GraphsearchdijkstraModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraModel::fill(self : GraphsearchdijkstraModel, v : Double) -> GraphsearchdijkstraModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraModel::min(self : GraphsearchdijkstraModel) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraModel::max(self : GraphsearchdijkstraModel) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraModel::to_string(self : GraphsearchdijkstraModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_layer_make(size : Int) -> GraphsearchdijkstraLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraLayer::len(self : GraphsearchdijkstraLayer) -> Int { self.size }

pub fn GraphsearchdijkstraLayer::get(self : GraphsearchdijkstraLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraLayer::set(self : GraphsearchdijkstraLayer, i : Int, v : Double) -> GraphsearchdijkstraLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraLayer::sum(self : GraphsearchdijkstraLayer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraLayer::mean(self : GraphsearchdijkstraLayer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraLayer::scale(self : GraphsearchdijkstraLayer, f : Double) -> GraphsearchdijkstraLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraLayer::add(self : GraphsearchdijkstraLayer, other : GraphsearchdijkstraLayer) -> GraphsearchdijkstraLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraLayer::copy(self : GraphsearchdijkstraLayer) -> GraphsearchdijkstraLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraLayer::fill(self : GraphsearchdijkstraLayer, v : Double) -> GraphsearchdijkstraLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraLayer::min(self : GraphsearchdijkstraLayer) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraLayer::max(self : GraphsearchdijkstraLayer) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraLayer::to_string(self : GraphsearchdijkstraLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_buffer_make(size : Int) -> GraphsearchdijkstraBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraBuffer::len(self : GraphsearchdijkstraBuffer) -> Int { self.size }

pub fn GraphsearchdijkstraBuffer::get(self : GraphsearchdijkstraBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraBuffer::set(self : GraphsearchdijkstraBuffer, i : Int, v : Double) -> GraphsearchdijkstraBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraBuffer::sum(self : GraphsearchdijkstraBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraBuffer::mean(self : GraphsearchdijkstraBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraBuffer::scale(self : GraphsearchdijkstraBuffer, f : Double) -> GraphsearchdijkstraBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraBuffer::add(self : GraphsearchdijkstraBuffer, other : GraphsearchdijkstraBuffer) -> GraphsearchdijkstraBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraBuffer::copy(self : GraphsearchdijkstraBuffer) -> GraphsearchdijkstraBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraBuffer::fill(self : GraphsearchdijkstraBuffer, v : Double) -> GraphsearchdijkstraBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraBuffer::min(self : GraphsearchdijkstraBuffer) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraBuffer::max(self : GraphsearchdijkstraBuffer) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraBuffer::to_string(self : GraphsearchdijkstraBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_cursor_make(size : Int) -> GraphsearchdijkstraCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraCursor::len(self : GraphsearchdijkstraCursor) -> Int { self.size }

pub fn GraphsearchdijkstraCursor::get(self : GraphsearchdijkstraCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraCursor::set(self : GraphsearchdijkstraCursor, i : Int, v : Double) -> GraphsearchdijkstraCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraCursor::sum(self : GraphsearchdijkstraCursor) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraCursor::mean(self : GraphsearchdijkstraCursor) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraCursor::scale(self : GraphsearchdijkstraCursor, f : Double) -> GraphsearchdijkstraCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraCursor::add(self : GraphsearchdijkstraCursor, other : GraphsearchdijkstraCursor) -> GraphsearchdijkstraCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraCursor::copy(self : GraphsearchdijkstraCursor) -> GraphsearchdijkstraCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraCursor::fill(self : GraphsearchdijkstraCursor, v : Double) -> GraphsearchdijkstraCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraCursor::min(self : GraphsearchdijkstraCursor) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraCursor::max(self : GraphsearchdijkstraCursor) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraCursor::to_string(self : GraphsearchdijkstraCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_view_make(size : Int) -> GraphsearchdijkstraView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraView::len(self : GraphsearchdijkstraView) -> Int { self.size }

pub fn GraphsearchdijkstraView::get(self : GraphsearchdijkstraView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraView::set(self : GraphsearchdijkstraView, i : Int, v : Double) -> GraphsearchdijkstraView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraView::sum(self : GraphsearchdijkstraView) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraView::mean(self : GraphsearchdijkstraView) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraView::scale(self : GraphsearchdijkstraView, f : Double) -> GraphsearchdijkstraView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraView::add(self : GraphsearchdijkstraView, other : GraphsearchdijkstraView) -> GraphsearchdijkstraView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraView::copy(self : GraphsearchdijkstraView) -> GraphsearchdijkstraView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraView::fill(self : GraphsearchdijkstraView, v : Double) -> GraphsearchdijkstraView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraView::min(self : GraphsearchdijkstraView) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraView::max(self : GraphsearchdijkstraView) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraView::to_string(self : GraphsearchdijkstraView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_range_make(size : Int) -> GraphsearchdijkstraRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraRange::len(self : GraphsearchdijkstraRange) -> Int { self.size }

pub fn GraphsearchdijkstraRange::get(self : GraphsearchdijkstraRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraRange::set(self : GraphsearchdijkstraRange, i : Int, v : Double) -> GraphsearchdijkstraRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraRange::sum(self : GraphsearchdijkstraRange) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraRange::mean(self : GraphsearchdijkstraRange) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraRange::scale(self : GraphsearchdijkstraRange, f : Double) -> GraphsearchdijkstraRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraRange::add(self : GraphsearchdijkstraRange, other : GraphsearchdijkstraRange) -> GraphsearchdijkstraRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraRange::copy(self : GraphsearchdijkstraRange) -> GraphsearchdijkstraRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraRange::fill(self : GraphsearchdijkstraRange, v : Double) -> GraphsearchdijkstraRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraRange::min(self : GraphsearchdijkstraRange) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraRange::max(self : GraphsearchdijkstraRange) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraRange::to_string(self : GraphsearchdijkstraRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_slice_make(size : Int) -> GraphsearchdijkstraSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdijkstraSlice::len(self : GraphsearchdijkstraSlice) -> Int { self.size }

pub fn GraphsearchdijkstraSlice::get(self : GraphsearchdijkstraSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdijkstraSlice::set(self : GraphsearchdijkstraSlice, i : Int, v : Double) -> GraphsearchdijkstraSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraSlice::sum(self : GraphsearchdijkstraSlice) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdijkstraSlice::mean(self : GraphsearchdijkstraSlice) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdijkstraSlice::scale(self : GraphsearchdijkstraSlice, f : Double) -> GraphsearchdijkstraSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraSlice::add(self : GraphsearchdijkstraSlice, other : GraphsearchdijkstraSlice) -> GraphsearchdijkstraSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdijkstraSlice::copy(self : GraphsearchdijkstraSlice) -> GraphsearchdijkstraSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraSlice::fill(self : GraphsearchdijkstraSlice, v : Double) -> GraphsearchdijkstraSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdijkstraSlice::min(self : GraphsearchdijkstraSlice) -> Double { @_common.min(self.data) }

pub fn GraphsearchdijkstraSlice::max(self : GraphsearchdijkstraSlice) -> Double { @_common.max(self.data) }

pub fn GraphsearchdijkstraSlice::to_string(self : GraphsearchdijkstraSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

