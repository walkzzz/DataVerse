///===
/// extcore/graph_color_lawler

pub(all) struct GraphcolorlawlerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_lawler_make_point(x : Double, y : Double) -> GraphcolorlawlerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_lawler_make_point3(x : Double, y : Double, z : Double) -> GraphcolorlawlerPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorlawlerPoint::x(self : GraphcolorlawlerPoint) -> Double { self.x }

pub fn GraphcolorlawlerPoint::y(self : GraphcolorlawlerPoint) -> Double { self.y }

pub fn GraphcolorlawlerPoint::z(self : GraphcolorlawlerPoint) -> Double { self.z }

pub fn GraphcolorlawlerPoint::label(self : GraphcolorlawlerPoint) -> Int { self.label }

pub fn GraphcolorlawlerPoint::dist(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorlawlerPoint::add(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorlawlerPoint::sub(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorlawlerPoint::scale(self : GraphcolorlawlerPoint, s : Double) -> GraphcolorlawlerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorlawlerPoint::dot(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorlawlerPoint::cross(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorlawlerPoint::norm(self : GraphcolorlawlerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorlawlerPoint::normalize(self : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorlawlerPoint::negate(self : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorlawlerPoint::mid(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorlawlerPoint::lerp(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint, t : Double) -> GraphcolorlawlerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorlawlerPoint::to_string(self : GraphcolorlawlerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorlawlerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_lawler_make_series(vals : Array[Double], name : String) -> GraphcolorlawlerSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorlawlerSeries::len(self : GraphcolorlawlerSeries) -> Int { self.vals.length() }

pub fn GraphcolorlawlerSeries::sum(self : GraphcolorlawlerSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorlawlerSeries::mean(self : GraphcolorlawlerSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorlawlerSeries::min(self : GraphcolorlawlerSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorlawlerSeries::max(self : GraphcolorlawlerSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorlawlerSeries::range(self : GraphcolorlawlerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorlawlerSeries::variance(self : GraphcolorlawlerSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorlawlerSeries::std(self : GraphcolorlawlerSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorlawlerSeries::median(self : GraphcolorlawlerSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorlawlerSeries::scale(self : GraphcolorlawlerSeries, f : Double) -> GraphcolorlawlerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorlawlerSeries::add(self : GraphcolorlawlerSeries, other : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorlawlerSeries::sub(self : GraphcolorlawlerSeries, other : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorlawlerSeries::normalize(self : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorlawlerSeries::cumsum(self : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorlawlerSeries::to_string(self : GraphcolorlawlerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorlawlerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_lawler_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorlawlerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_lawler_matrix_identity(n : Int) -> GraphcolorlawlerMatrix {
  let m = graph_color_lawler_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorlawlerMatrix::get(self : GraphcolorlawlerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorlawlerMatrix::transpose(self : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  let result = graph_color_lawler_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorlawlerMatrix::add(self : GraphcolorlawlerMatrix, other : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_lawler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorlawlerMatrix::scale(self : GraphcolorlawlerMatrix, s : Double) -> GraphcolorlawlerMatrix {
  let result = graph_color_lawler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorlawlerMatrix::multiply(self : GraphcolorlawlerMatrix, other : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  if self.cols != other.rows { return graph_color_lawler_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_lawler_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphcolorlawlerMatrix::trace(self : GraphcolorlawlerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorlawlerMatrix::det(self : GraphcolorlawlerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorlawlerMatrix::norm(self : GraphcolorlawlerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorlawlerMatrix::to_string(self : GraphcolorlawlerMatrix) -> String {
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

pub(all) struct GraphcolorlawlerVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_lawler_make_vector(comps : Array[Double]) -> GraphcolorlawlerVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_lawler_vector_zero(dim : Int) -> GraphcolorlawlerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorlawlerVector::add(self : GraphcolorlawlerVector, other : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorlawlerVector::sub(self : GraphcolorlawlerVector, other : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorlawlerVector::scale(self : GraphcolorlawlerVector, s : Double) -> GraphcolorlawlerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorlawlerVector::dot(self : GraphcolorlawlerVector, other : GraphcolorlawlerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorlawlerVector::norm(self : GraphcolorlawlerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorlawlerVector::normalize(self : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorlawlerVector::dist(self : GraphcolorlawlerVector, other : GraphcolorlawlerVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorlawlerVector::to_string(self : GraphcolorlawlerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorlawlerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_frame_make(size : Int) -> GraphcolorlawlerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerFrame::len(self : GraphcolorlawlerFrame) -> Int { self.size }

pub fn GraphcolorlawlerFrame::get(self : GraphcolorlawlerFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerFrame::set(self : GraphcolorlawlerFrame, i : Int, v : Double) -> GraphcolorlawlerFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerFrame::sum(self : GraphcolorlawlerFrame) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerFrame::mean(self : GraphcolorlawlerFrame) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerFrame::scale(self : GraphcolorlawlerFrame, f : Double) -> GraphcolorlawlerFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerFrame::add(self : GraphcolorlawlerFrame, other : GraphcolorlawlerFrame) -> GraphcolorlawlerFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerFrame::copy(self : GraphcolorlawlerFrame) -> GraphcolorlawlerFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerFrame::fill(self : GraphcolorlawlerFrame, v : Double) -> GraphcolorlawlerFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerFrame::min(self : GraphcolorlawlerFrame) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerFrame::max(self : GraphcolorlawlerFrame) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerFrame::to_string(self : GraphcolorlawlerFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_table_make(size : Int) -> GraphcolorlawlerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerTable::len(self : GraphcolorlawlerTable) -> Int { self.size }

pub fn GraphcolorlawlerTable::get(self : GraphcolorlawlerTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerTable::set(self : GraphcolorlawlerTable, i : Int, v : Double) -> GraphcolorlawlerTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerTable::sum(self : GraphcolorlawlerTable) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerTable::mean(self : GraphcolorlawlerTable) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerTable::scale(self : GraphcolorlawlerTable, f : Double) -> GraphcolorlawlerTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerTable::add(self : GraphcolorlawlerTable, other : GraphcolorlawlerTable) -> GraphcolorlawlerTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerTable::copy(self : GraphcolorlawlerTable) -> GraphcolorlawlerTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerTable::fill(self : GraphcolorlawlerTable, v : Double) -> GraphcolorlawlerTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerTable::min(self : GraphcolorlawlerTable) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerTable::max(self : GraphcolorlawlerTable) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerTable::to_string(self : GraphcolorlawlerTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_graphn_make(size : Int) -> GraphcolorlawlerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerGraphN::len(self : GraphcolorlawlerGraphN) -> Int { self.size }

pub fn GraphcolorlawlerGraphN::get(self : GraphcolorlawlerGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerGraphN::set(self : GraphcolorlawlerGraphN, i : Int, v : Double) -> GraphcolorlawlerGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerGraphN::sum(self : GraphcolorlawlerGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerGraphN::mean(self : GraphcolorlawlerGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerGraphN::scale(self : GraphcolorlawlerGraphN, f : Double) -> GraphcolorlawlerGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerGraphN::add(self : GraphcolorlawlerGraphN, other : GraphcolorlawlerGraphN) -> GraphcolorlawlerGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerGraphN::copy(self : GraphcolorlawlerGraphN) -> GraphcolorlawlerGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerGraphN::fill(self : GraphcolorlawlerGraphN, v : Double) -> GraphcolorlawlerGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerGraphN::min(self : GraphcolorlawlerGraphN) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerGraphN::max(self : GraphcolorlawlerGraphN) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerGraphN::to_string(self : GraphcolorlawlerGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_node_make(size : Int) -> GraphcolorlawlerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerNode::len(self : GraphcolorlawlerNode) -> Int { self.size }

pub fn GraphcolorlawlerNode::get(self : GraphcolorlawlerNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerNode::set(self : GraphcolorlawlerNode, i : Int, v : Double) -> GraphcolorlawlerNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerNode::sum(self : GraphcolorlawlerNode) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerNode::mean(self : GraphcolorlawlerNode) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerNode::scale(self : GraphcolorlawlerNode, f : Double) -> GraphcolorlawlerNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerNode::add(self : GraphcolorlawlerNode, other : GraphcolorlawlerNode) -> GraphcolorlawlerNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerNode::copy(self : GraphcolorlawlerNode) -> GraphcolorlawlerNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerNode::fill(self : GraphcolorlawlerNode, v : Double) -> GraphcolorlawlerNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerNode::min(self : GraphcolorlawlerNode) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerNode::max(self : GraphcolorlawlerNode) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerNode::to_string(self : GraphcolorlawlerNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_edge_make(size : Int) -> GraphcolorlawlerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerEdge::len(self : GraphcolorlawlerEdge) -> Int { self.size }

pub fn GraphcolorlawlerEdge::get(self : GraphcolorlawlerEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerEdge::set(self : GraphcolorlawlerEdge, i : Int, v : Double) -> GraphcolorlawlerEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerEdge::sum(self : GraphcolorlawlerEdge) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerEdge::mean(self : GraphcolorlawlerEdge) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerEdge::scale(self : GraphcolorlawlerEdge, f : Double) -> GraphcolorlawlerEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerEdge::add(self : GraphcolorlawlerEdge, other : GraphcolorlawlerEdge) -> GraphcolorlawlerEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerEdge::copy(self : GraphcolorlawlerEdge) -> GraphcolorlawlerEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerEdge::fill(self : GraphcolorlawlerEdge, v : Double) -> GraphcolorlawlerEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerEdge::min(self : GraphcolorlawlerEdge) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerEdge::max(self : GraphcolorlawlerEdge) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerEdge::to_string(self : GraphcolorlawlerEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_path_make(size : Int) -> GraphcolorlawlerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerPath::len(self : GraphcolorlawlerPath) -> Int { self.size }

pub fn GraphcolorlawlerPath::get(self : GraphcolorlawlerPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerPath::set(self : GraphcolorlawlerPath, i : Int, v : Double) -> GraphcolorlawlerPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerPath::sum(self : GraphcolorlawlerPath) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerPath::mean(self : GraphcolorlawlerPath) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerPath::scale(self : GraphcolorlawlerPath, f : Double) -> GraphcolorlawlerPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerPath::add(self : GraphcolorlawlerPath, other : GraphcolorlawlerPath) -> GraphcolorlawlerPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerPath::copy(self : GraphcolorlawlerPath) -> GraphcolorlawlerPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerPath::fill(self : GraphcolorlawlerPath, v : Double) -> GraphcolorlawlerPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerPath::min(self : GraphcolorlawlerPath) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerPath::max(self : GraphcolorlawlerPath) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerPath::to_string(self : GraphcolorlawlerPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_cluster_make(size : Int) -> GraphcolorlawlerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerCluster::len(self : GraphcolorlawlerCluster) -> Int { self.size }

pub fn GraphcolorlawlerCluster::get(self : GraphcolorlawlerCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerCluster::set(self : GraphcolorlawlerCluster, i : Int, v : Double) -> GraphcolorlawlerCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerCluster::sum(self : GraphcolorlawlerCluster) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerCluster::mean(self : GraphcolorlawlerCluster) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerCluster::scale(self : GraphcolorlawlerCluster, f : Double) -> GraphcolorlawlerCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerCluster::add(self : GraphcolorlawlerCluster, other : GraphcolorlawlerCluster) -> GraphcolorlawlerCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerCluster::copy(self : GraphcolorlawlerCluster) -> GraphcolorlawlerCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerCluster::fill(self : GraphcolorlawlerCluster, v : Double) -> GraphcolorlawlerCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerCluster::min(self : GraphcolorlawlerCluster) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerCluster::max(self : GraphcolorlawlerCluster) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerCluster::to_string(self : GraphcolorlawlerCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_model_make(size : Int) -> GraphcolorlawlerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerModel::len(self : GraphcolorlawlerModel) -> Int { self.size }

pub fn GraphcolorlawlerModel::get(self : GraphcolorlawlerModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerModel::set(self : GraphcolorlawlerModel, i : Int, v : Double) -> GraphcolorlawlerModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerModel::sum(self : GraphcolorlawlerModel) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerModel::mean(self : GraphcolorlawlerModel) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerModel::scale(self : GraphcolorlawlerModel, f : Double) -> GraphcolorlawlerModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerModel::add(self : GraphcolorlawlerModel, other : GraphcolorlawlerModel) -> GraphcolorlawlerModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerModel::copy(self : GraphcolorlawlerModel) -> GraphcolorlawlerModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerModel::fill(self : GraphcolorlawlerModel, v : Double) -> GraphcolorlawlerModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerModel::min(self : GraphcolorlawlerModel) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerModel::max(self : GraphcolorlawlerModel) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerModel::to_string(self : GraphcolorlawlerModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_layer_make(size : Int) -> GraphcolorlawlerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerLayer::len(self : GraphcolorlawlerLayer) -> Int { self.size }

pub fn GraphcolorlawlerLayer::get(self : GraphcolorlawlerLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerLayer::set(self : GraphcolorlawlerLayer, i : Int, v : Double) -> GraphcolorlawlerLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerLayer::sum(self : GraphcolorlawlerLayer) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerLayer::mean(self : GraphcolorlawlerLayer) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerLayer::scale(self : GraphcolorlawlerLayer, f : Double) -> GraphcolorlawlerLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerLayer::add(self : GraphcolorlawlerLayer, other : GraphcolorlawlerLayer) -> GraphcolorlawlerLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerLayer::copy(self : GraphcolorlawlerLayer) -> GraphcolorlawlerLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerLayer::fill(self : GraphcolorlawlerLayer, v : Double) -> GraphcolorlawlerLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerLayer::min(self : GraphcolorlawlerLayer) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerLayer::max(self : GraphcolorlawlerLayer) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerLayer::to_string(self : GraphcolorlawlerLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_buffer_make(size : Int) -> GraphcolorlawlerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerBuffer::len(self : GraphcolorlawlerBuffer) -> Int { self.size }

pub fn GraphcolorlawlerBuffer::get(self : GraphcolorlawlerBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerBuffer::set(self : GraphcolorlawlerBuffer, i : Int, v : Double) -> GraphcolorlawlerBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerBuffer::sum(self : GraphcolorlawlerBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerBuffer::mean(self : GraphcolorlawlerBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerBuffer::scale(self : GraphcolorlawlerBuffer, f : Double) -> GraphcolorlawlerBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerBuffer::add(self : GraphcolorlawlerBuffer, other : GraphcolorlawlerBuffer) -> GraphcolorlawlerBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerBuffer::copy(self : GraphcolorlawlerBuffer) -> GraphcolorlawlerBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerBuffer::fill(self : GraphcolorlawlerBuffer, v : Double) -> GraphcolorlawlerBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerBuffer::min(self : GraphcolorlawlerBuffer) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerBuffer::max(self : GraphcolorlawlerBuffer) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerBuffer::to_string(self : GraphcolorlawlerBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_cursor_make(size : Int) -> GraphcolorlawlerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerCursor::len(self : GraphcolorlawlerCursor) -> Int { self.size }

pub fn GraphcolorlawlerCursor::get(self : GraphcolorlawlerCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerCursor::set(self : GraphcolorlawlerCursor, i : Int, v : Double) -> GraphcolorlawlerCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerCursor::sum(self : GraphcolorlawlerCursor) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerCursor::mean(self : GraphcolorlawlerCursor) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerCursor::scale(self : GraphcolorlawlerCursor, f : Double) -> GraphcolorlawlerCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerCursor::add(self : GraphcolorlawlerCursor, other : GraphcolorlawlerCursor) -> GraphcolorlawlerCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerCursor::copy(self : GraphcolorlawlerCursor) -> GraphcolorlawlerCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerCursor::fill(self : GraphcolorlawlerCursor, v : Double) -> GraphcolorlawlerCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerCursor::min(self : GraphcolorlawlerCursor) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerCursor::max(self : GraphcolorlawlerCursor) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerCursor::to_string(self : GraphcolorlawlerCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_view_make(size : Int) -> GraphcolorlawlerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerView::len(self : GraphcolorlawlerView) -> Int { self.size }

pub fn GraphcolorlawlerView::get(self : GraphcolorlawlerView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerView::set(self : GraphcolorlawlerView, i : Int, v : Double) -> GraphcolorlawlerView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerView::sum(self : GraphcolorlawlerView) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerView::mean(self : GraphcolorlawlerView) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerView::scale(self : GraphcolorlawlerView, f : Double) -> GraphcolorlawlerView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerView::add(self : GraphcolorlawlerView, other : GraphcolorlawlerView) -> GraphcolorlawlerView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerView::copy(self : GraphcolorlawlerView) -> GraphcolorlawlerView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerView::fill(self : GraphcolorlawlerView, v : Double) -> GraphcolorlawlerView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerView::min(self : GraphcolorlawlerView) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerView::max(self : GraphcolorlawlerView) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerView::to_string(self : GraphcolorlawlerView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_range_make(size : Int) -> GraphcolorlawlerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerRange::len(self : GraphcolorlawlerRange) -> Int { self.size }

pub fn GraphcolorlawlerRange::get(self : GraphcolorlawlerRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerRange::set(self : GraphcolorlawlerRange, i : Int, v : Double) -> GraphcolorlawlerRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerRange::sum(self : GraphcolorlawlerRange) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerRange::mean(self : GraphcolorlawlerRange) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerRange::scale(self : GraphcolorlawlerRange, f : Double) -> GraphcolorlawlerRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerRange::add(self : GraphcolorlawlerRange, other : GraphcolorlawlerRange) -> GraphcolorlawlerRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerRange::copy(self : GraphcolorlawlerRange) -> GraphcolorlawlerRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerRange::fill(self : GraphcolorlawlerRange, v : Double) -> GraphcolorlawlerRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerRange::min(self : GraphcolorlawlerRange) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerRange::max(self : GraphcolorlawlerRange) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerRange::to_string(self : GraphcolorlawlerRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_slice_make(size : Int) -> GraphcolorlawlerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlawlerSlice::len(self : GraphcolorlawlerSlice) -> Int { self.size }

pub fn GraphcolorlawlerSlice::get(self : GraphcolorlawlerSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlawlerSlice::set(self : GraphcolorlawlerSlice, i : Int, v : Double) -> GraphcolorlawlerSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerSlice::sum(self : GraphcolorlawlerSlice) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlawlerSlice::mean(self : GraphcolorlawlerSlice) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlawlerSlice::scale(self : GraphcolorlawlerSlice, f : Double) -> GraphcolorlawlerSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerSlice::add(self : GraphcolorlawlerSlice, other : GraphcolorlawlerSlice) -> GraphcolorlawlerSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlawlerSlice::copy(self : GraphcolorlawlerSlice) -> GraphcolorlawlerSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerSlice::fill(self : GraphcolorlawlerSlice, v : Double) -> GraphcolorlawlerSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlawlerSlice::min(self : GraphcolorlawlerSlice) -> Double { @_common.min(self.data) }

pub fn GraphcolorlawlerSlice::max(self : GraphcolorlawlerSlice) -> Double { @_common.max(self.data) }

pub fn GraphcolorlawlerSlice::to_string(self : GraphcolorlawlerSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

