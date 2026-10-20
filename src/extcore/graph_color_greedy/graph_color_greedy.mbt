///===
/// extcore/graph_color_greedy

pub(all) struct GraphcolorgreedyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_greedy_make_point(x : Double, y : Double) -> GraphcolorgreedyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_greedy_make_point3(x : Double, y : Double, z : Double) -> GraphcolorgreedyPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorgreedyPoint::x(self : GraphcolorgreedyPoint) -> Double { self.x }

pub fn GraphcolorgreedyPoint::y(self : GraphcolorgreedyPoint) -> Double { self.y }

pub fn GraphcolorgreedyPoint::z(self : GraphcolorgreedyPoint) -> Double { self.z }

pub fn GraphcolorgreedyPoint::label(self : GraphcolorgreedyPoint) -> Int { self.label }

pub fn GraphcolorgreedyPoint::dist(self : GraphcolorgreedyPoint, other : GraphcolorgreedyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorgreedyPoint::add(self : GraphcolorgreedyPoint, other : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorgreedyPoint::sub(self : GraphcolorgreedyPoint, other : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorgreedyPoint::scale(self : GraphcolorgreedyPoint, s : Double) -> GraphcolorgreedyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorgreedyPoint::dot(self : GraphcolorgreedyPoint, other : GraphcolorgreedyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorgreedyPoint::cross(self : GraphcolorgreedyPoint, other : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorgreedyPoint::norm(self : GraphcolorgreedyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorgreedyPoint::normalize(self : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorgreedyPoint::negate(self : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorgreedyPoint::mid(self : GraphcolorgreedyPoint, other : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorgreedyPoint::lerp(self : GraphcolorgreedyPoint, other : GraphcolorgreedyPoint, t : Double) -> GraphcolorgreedyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorgreedyPoint::to_string(self : GraphcolorgreedyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorgreedySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_greedy_make_series(vals : Array[Double], name : String) -> GraphcolorgreedySeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorgreedySeries::len(self : GraphcolorgreedySeries) -> Int { self.vals.length() }

pub fn GraphcolorgreedySeries::sum(self : GraphcolorgreedySeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorgreedySeries::mean(self : GraphcolorgreedySeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorgreedySeries::min(self : GraphcolorgreedySeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorgreedySeries::max(self : GraphcolorgreedySeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorgreedySeries::range(self : GraphcolorgreedySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorgreedySeries::variance(self : GraphcolorgreedySeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorgreedySeries::std(self : GraphcolorgreedySeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorgreedySeries::median(self : GraphcolorgreedySeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorgreedySeries::scale(self : GraphcolorgreedySeries, f : Double) -> GraphcolorgreedySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorgreedySeries::add(self : GraphcolorgreedySeries, other : GraphcolorgreedySeries) -> GraphcolorgreedySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorgreedySeries::sub(self : GraphcolorgreedySeries, other : GraphcolorgreedySeries) -> GraphcolorgreedySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorgreedySeries::normalize(self : GraphcolorgreedySeries) -> GraphcolorgreedySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorgreedySeries::cumsum(self : GraphcolorgreedySeries) -> GraphcolorgreedySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorgreedySeries::to_string(self : GraphcolorgreedySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorgreedyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_greedy_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorgreedyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_greedy_matrix_identity(n : Int) -> GraphcolorgreedyMatrix {
  let m = graph_color_greedy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorgreedyMatrix::get(self : GraphcolorgreedyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorgreedyMatrix::transpose(self : GraphcolorgreedyMatrix) -> GraphcolorgreedyMatrix {
  let result = graph_color_greedy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorgreedyMatrix::add(self : GraphcolorgreedyMatrix, other : GraphcolorgreedyMatrix) -> GraphcolorgreedyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_greedy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorgreedyMatrix::scale(self : GraphcolorgreedyMatrix, s : Double) -> GraphcolorgreedyMatrix {
  let result = graph_color_greedy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorgreedyMatrix::multiply(self : GraphcolorgreedyMatrix, other : GraphcolorgreedyMatrix) -> GraphcolorgreedyMatrix {
  if self.cols != other.rows { return graph_color_greedy_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_greedy_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphcolorgreedyMatrix::trace(self : GraphcolorgreedyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorgreedyMatrix::det(self : GraphcolorgreedyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorgreedyMatrix::norm(self : GraphcolorgreedyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorgreedyMatrix::to_string(self : GraphcolorgreedyMatrix) -> String {
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

pub(all) struct GraphcolorgreedyVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_greedy_make_vector(comps : Array[Double]) -> GraphcolorgreedyVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_greedy_vector_zero(dim : Int) -> GraphcolorgreedyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorgreedyVector::add(self : GraphcolorgreedyVector, other : GraphcolorgreedyVector) -> GraphcolorgreedyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorgreedyVector::sub(self : GraphcolorgreedyVector, other : GraphcolorgreedyVector) -> GraphcolorgreedyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorgreedyVector::scale(self : GraphcolorgreedyVector, s : Double) -> GraphcolorgreedyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorgreedyVector::dot(self : GraphcolorgreedyVector, other : GraphcolorgreedyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorgreedyVector::norm(self : GraphcolorgreedyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorgreedyVector::normalize(self : GraphcolorgreedyVector) -> GraphcolorgreedyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorgreedyVector::dist(self : GraphcolorgreedyVector, other : GraphcolorgreedyVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorgreedyVector::to_string(self : GraphcolorgreedyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorgreedyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_frame_make(size : Int) -> GraphcolorgreedyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyFrame::len(self : GraphcolorgreedyFrame) -> Int { self.size }

pub fn GraphcolorgreedyFrame::get(self : GraphcolorgreedyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyFrame::set(self : GraphcolorgreedyFrame, i : Int, v : Double) -> GraphcolorgreedyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyFrame::sum(self : GraphcolorgreedyFrame) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyFrame::mean(self : GraphcolorgreedyFrame) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyFrame::scale(self : GraphcolorgreedyFrame, f : Double) -> GraphcolorgreedyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyFrame::add(self : GraphcolorgreedyFrame, other : GraphcolorgreedyFrame) -> GraphcolorgreedyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyFrame::copy(self : GraphcolorgreedyFrame) -> GraphcolorgreedyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyFrame::fill(self : GraphcolorgreedyFrame, v : Double) -> GraphcolorgreedyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyFrame::min(self : GraphcolorgreedyFrame) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyFrame::max(self : GraphcolorgreedyFrame) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyFrame::to_string(self : GraphcolorgreedyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_table_make(size : Int) -> GraphcolorgreedyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyTable::len(self : GraphcolorgreedyTable) -> Int { self.size }

pub fn GraphcolorgreedyTable::get(self : GraphcolorgreedyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyTable::set(self : GraphcolorgreedyTable, i : Int, v : Double) -> GraphcolorgreedyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyTable::sum(self : GraphcolorgreedyTable) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyTable::mean(self : GraphcolorgreedyTable) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyTable::scale(self : GraphcolorgreedyTable, f : Double) -> GraphcolorgreedyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyTable::add(self : GraphcolorgreedyTable, other : GraphcolorgreedyTable) -> GraphcolorgreedyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyTable::copy(self : GraphcolorgreedyTable) -> GraphcolorgreedyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyTable::fill(self : GraphcolorgreedyTable, v : Double) -> GraphcolorgreedyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyTable::min(self : GraphcolorgreedyTable) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyTable::max(self : GraphcolorgreedyTable) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyTable::to_string(self : GraphcolorgreedyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_graphn_make(size : Int) -> GraphcolorgreedyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyGraphN::len(self : GraphcolorgreedyGraphN) -> Int { self.size }

pub fn GraphcolorgreedyGraphN::get(self : GraphcolorgreedyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyGraphN::set(self : GraphcolorgreedyGraphN, i : Int, v : Double) -> GraphcolorgreedyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyGraphN::sum(self : GraphcolorgreedyGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyGraphN::mean(self : GraphcolorgreedyGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyGraphN::scale(self : GraphcolorgreedyGraphN, f : Double) -> GraphcolorgreedyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyGraphN::add(self : GraphcolorgreedyGraphN, other : GraphcolorgreedyGraphN) -> GraphcolorgreedyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyGraphN::copy(self : GraphcolorgreedyGraphN) -> GraphcolorgreedyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyGraphN::fill(self : GraphcolorgreedyGraphN, v : Double) -> GraphcolorgreedyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyGraphN::min(self : GraphcolorgreedyGraphN) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyGraphN::max(self : GraphcolorgreedyGraphN) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyGraphN::to_string(self : GraphcolorgreedyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_node_make(size : Int) -> GraphcolorgreedyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyNode::len(self : GraphcolorgreedyNode) -> Int { self.size }

pub fn GraphcolorgreedyNode::get(self : GraphcolorgreedyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyNode::set(self : GraphcolorgreedyNode, i : Int, v : Double) -> GraphcolorgreedyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyNode::sum(self : GraphcolorgreedyNode) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyNode::mean(self : GraphcolorgreedyNode) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyNode::scale(self : GraphcolorgreedyNode, f : Double) -> GraphcolorgreedyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyNode::add(self : GraphcolorgreedyNode, other : GraphcolorgreedyNode) -> GraphcolorgreedyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyNode::copy(self : GraphcolorgreedyNode) -> GraphcolorgreedyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyNode::fill(self : GraphcolorgreedyNode, v : Double) -> GraphcolorgreedyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyNode::min(self : GraphcolorgreedyNode) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyNode::max(self : GraphcolorgreedyNode) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyNode::to_string(self : GraphcolorgreedyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_edge_make(size : Int) -> GraphcolorgreedyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyEdge::len(self : GraphcolorgreedyEdge) -> Int { self.size }

pub fn GraphcolorgreedyEdge::get(self : GraphcolorgreedyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyEdge::set(self : GraphcolorgreedyEdge, i : Int, v : Double) -> GraphcolorgreedyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyEdge::sum(self : GraphcolorgreedyEdge) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyEdge::mean(self : GraphcolorgreedyEdge) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyEdge::scale(self : GraphcolorgreedyEdge, f : Double) -> GraphcolorgreedyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyEdge::add(self : GraphcolorgreedyEdge, other : GraphcolorgreedyEdge) -> GraphcolorgreedyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyEdge::copy(self : GraphcolorgreedyEdge) -> GraphcolorgreedyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyEdge::fill(self : GraphcolorgreedyEdge, v : Double) -> GraphcolorgreedyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyEdge::min(self : GraphcolorgreedyEdge) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyEdge::max(self : GraphcolorgreedyEdge) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyEdge::to_string(self : GraphcolorgreedyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_path_make(size : Int) -> GraphcolorgreedyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyPath::len(self : GraphcolorgreedyPath) -> Int { self.size }

pub fn GraphcolorgreedyPath::get(self : GraphcolorgreedyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyPath::set(self : GraphcolorgreedyPath, i : Int, v : Double) -> GraphcolorgreedyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyPath::sum(self : GraphcolorgreedyPath) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyPath::mean(self : GraphcolorgreedyPath) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyPath::scale(self : GraphcolorgreedyPath, f : Double) -> GraphcolorgreedyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyPath::add(self : GraphcolorgreedyPath, other : GraphcolorgreedyPath) -> GraphcolorgreedyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyPath::copy(self : GraphcolorgreedyPath) -> GraphcolorgreedyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyPath::fill(self : GraphcolorgreedyPath, v : Double) -> GraphcolorgreedyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyPath::min(self : GraphcolorgreedyPath) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyPath::max(self : GraphcolorgreedyPath) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyPath::to_string(self : GraphcolorgreedyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_cluster_make(size : Int) -> GraphcolorgreedyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyCluster::len(self : GraphcolorgreedyCluster) -> Int { self.size }

pub fn GraphcolorgreedyCluster::get(self : GraphcolorgreedyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyCluster::set(self : GraphcolorgreedyCluster, i : Int, v : Double) -> GraphcolorgreedyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyCluster::sum(self : GraphcolorgreedyCluster) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyCluster::mean(self : GraphcolorgreedyCluster) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyCluster::scale(self : GraphcolorgreedyCluster, f : Double) -> GraphcolorgreedyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyCluster::add(self : GraphcolorgreedyCluster, other : GraphcolorgreedyCluster) -> GraphcolorgreedyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyCluster::copy(self : GraphcolorgreedyCluster) -> GraphcolorgreedyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyCluster::fill(self : GraphcolorgreedyCluster, v : Double) -> GraphcolorgreedyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyCluster::min(self : GraphcolorgreedyCluster) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyCluster::max(self : GraphcolorgreedyCluster) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyCluster::to_string(self : GraphcolorgreedyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_model_make(size : Int) -> GraphcolorgreedyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyModel::len(self : GraphcolorgreedyModel) -> Int { self.size }

pub fn GraphcolorgreedyModel::get(self : GraphcolorgreedyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyModel::set(self : GraphcolorgreedyModel, i : Int, v : Double) -> GraphcolorgreedyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyModel::sum(self : GraphcolorgreedyModel) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyModel::mean(self : GraphcolorgreedyModel) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyModel::scale(self : GraphcolorgreedyModel, f : Double) -> GraphcolorgreedyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyModel::add(self : GraphcolorgreedyModel, other : GraphcolorgreedyModel) -> GraphcolorgreedyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyModel::copy(self : GraphcolorgreedyModel) -> GraphcolorgreedyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyModel::fill(self : GraphcolorgreedyModel, v : Double) -> GraphcolorgreedyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyModel::min(self : GraphcolorgreedyModel) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyModel::max(self : GraphcolorgreedyModel) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyModel::to_string(self : GraphcolorgreedyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_layer_make(size : Int) -> GraphcolorgreedyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyLayer::len(self : GraphcolorgreedyLayer) -> Int { self.size }

pub fn GraphcolorgreedyLayer::get(self : GraphcolorgreedyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyLayer::set(self : GraphcolorgreedyLayer, i : Int, v : Double) -> GraphcolorgreedyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyLayer::sum(self : GraphcolorgreedyLayer) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyLayer::mean(self : GraphcolorgreedyLayer) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyLayer::scale(self : GraphcolorgreedyLayer, f : Double) -> GraphcolorgreedyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyLayer::add(self : GraphcolorgreedyLayer, other : GraphcolorgreedyLayer) -> GraphcolorgreedyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyLayer::copy(self : GraphcolorgreedyLayer) -> GraphcolorgreedyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyLayer::fill(self : GraphcolorgreedyLayer, v : Double) -> GraphcolorgreedyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyLayer::min(self : GraphcolorgreedyLayer) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyLayer::max(self : GraphcolorgreedyLayer) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyLayer::to_string(self : GraphcolorgreedyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_buffer_make(size : Int) -> GraphcolorgreedyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyBuffer::len(self : GraphcolorgreedyBuffer) -> Int { self.size }

pub fn GraphcolorgreedyBuffer::get(self : GraphcolorgreedyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyBuffer::set(self : GraphcolorgreedyBuffer, i : Int, v : Double) -> GraphcolorgreedyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyBuffer::sum(self : GraphcolorgreedyBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyBuffer::mean(self : GraphcolorgreedyBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyBuffer::scale(self : GraphcolorgreedyBuffer, f : Double) -> GraphcolorgreedyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyBuffer::add(self : GraphcolorgreedyBuffer, other : GraphcolorgreedyBuffer) -> GraphcolorgreedyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyBuffer::copy(self : GraphcolorgreedyBuffer) -> GraphcolorgreedyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyBuffer::fill(self : GraphcolorgreedyBuffer, v : Double) -> GraphcolorgreedyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyBuffer::min(self : GraphcolorgreedyBuffer) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyBuffer::max(self : GraphcolorgreedyBuffer) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyBuffer::to_string(self : GraphcolorgreedyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_cursor_make(size : Int) -> GraphcolorgreedyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyCursor::len(self : GraphcolorgreedyCursor) -> Int { self.size }

pub fn GraphcolorgreedyCursor::get(self : GraphcolorgreedyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyCursor::set(self : GraphcolorgreedyCursor, i : Int, v : Double) -> GraphcolorgreedyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyCursor::sum(self : GraphcolorgreedyCursor) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyCursor::mean(self : GraphcolorgreedyCursor) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyCursor::scale(self : GraphcolorgreedyCursor, f : Double) -> GraphcolorgreedyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyCursor::add(self : GraphcolorgreedyCursor, other : GraphcolorgreedyCursor) -> GraphcolorgreedyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyCursor::copy(self : GraphcolorgreedyCursor) -> GraphcolorgreedyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyCursor::fill(self : GraphcolorgreedyCursor, v : Double) -> GraphcolorgreedyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyCursor::min(self : GraphcolorgreedyCursor) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyCursor::max(self : GraphcolorgreedyCursor) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyCursor::to_string(self : GraphcolorgreedyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_view_make(size : Int) -> GraphcolorgreedyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyView::len(self : GraphcolorgreedyView) -> Int { self.size }

pub fn GraphcolorgreedyView::get(self : GraphcolorgreedyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyView::set(self : GraphcolorgreedyView, i : Int, v : Double) -> GraphcolorgreedyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyView::sum(self : GraphcolorgreedyView) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyView::mean(self : GraphcolorgreedyView) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyView::scale(self : GraphcolorgreedyView, f : Double) -> GraphcolorgreedyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyView::add(self : GraphcolorgreedyView, other : GraphcolorgreedyView) -> GraphcolorgreedyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyView::copy(self : GraphcolorgreedyView) -> GraphcolorgreedyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyView::fill(self : GraphcolorgreedyView, v : Double) -> GraphcolorgreedyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyView::min(self : GraphcolorgreedyView) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyView::max(self : GraphcolorgreedyView) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyView::to_string(self : GraphcolorgreedyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_range_make(size : Int) -> GraphcolorgreedyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedyRange::len(self : GraphcolorgreedyRange) -> Int { self.size }

pub fn GraphcolorgreedyRange::get(self : GraphcolorgreedyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedyRange::set(self : GraphcolorgreedyRange, i : Int, v : Double) -> GraphcolorgreedyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyRange::sum(self : GraphcolorgreedyRange) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedyRange::mean(self : GraphcolorgreedyRange) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedyRange::scale(self : GraphcolorgreedyRange, f : Double) -> GraphcolorgreedyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyRange::add(self : GraphcolorgreedyRange, other : GraphcolorgreedyRange) -> GraphcolorgreedyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedyRange::copy(self : GraphcolorgreedyRange) -> GraphcolorgreedyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyRange::fill(self : GraphcolorgreedyRange, v : Double) -> GraphcolorgreedyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedyRange::min(self : GraphcolorgreedyRange) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedyRange::max(self : GraphcolorgreedyRange) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedyRange::to_string(self : GraphcolorgreedyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_slice_make(size : Int) -> GraphcolorgreedySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorgreedySlice::len(self : GraphcolorgreedySlice) -> Int { self.size }

pub fn GraphcolorgreedySlice::get(self : GraphcolorgreedySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorgreedySlice::set(self : GraphcolorgreedySlice, i : Int, v : Double) -> GraphcolorgreedySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedySlice::sum(self : GraphcolorgreedySlice) -> Double { @_common.sum(self.data) }

pub fn GraphcolorgreedySlice::mean(self : GraphcolorgreedySlice) -> Double { @_common.mean(self.data) }

pub fn GraphcolorgreedySlice::scale(self : GraphcolorgreedySlice, f : Double) -> GraphcolorgreedySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedySlice::add(self : GraphcolorgreedySlice, other : GraphcolorgreedySlice) -> GraphcolorgreedySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorgreedySlice::copy(self : GraphcolorgreedySlice) -> GraphcolorgreedySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedySlice::fill(self : GraphcolorgreedySlice, v : Double) -> GraphcolorgreedySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorgreedySlice::min(self : GraphcolorgreedySlice) -> Double { @_common.min(self.data) }

pub fn GraphcolorgreedySlice::max(self : GraphcolorgreedySlice) -> Double { @_common.max(self.data) }

pub fn GraphcolorgreedySlice::to_string(self : GraphcolorgreedySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

