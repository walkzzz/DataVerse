///===
/// extcore/graph_color_approx

pub(all) struct GraphcolorapproxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_approx_make_point(x : Double, y : Double) -> GraphcolorapproxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_approx_make_point3(x : Double, y : Double, z : Double) -> GraphcolorapproxPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorapproxPoint::x(self : GraphcolorapproxPoint) -> Double { self.x }

pub fn GraphcolorapproxPoint::y(self : GraphcolorapproxPoint) -> Double { self.y }

pub fn GraphcolorapproxPoint::z(self : GraphcolorapproxPoint) -> Double { self.z }

pub fn GraphcolorapproxPoint::label(self : GraphcolorapproxPoint) -> Int { self.label }

pub fn GraphcolorapproxPoint::dist(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorapproxPoint::add(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorapproxPoint::sub(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorapproxPoint::scale(self : GraphcolorapproxPoint, s : Double) -> GraphcolorapproxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorapproxPoint::dot(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorapproxPoint::cross(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorapproxPoint::norm(self : GraphcolorapproxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorapproxPoint::normalize(self : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorapproxPoint::negate(self : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorapproxPoint::mid(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorapproxPoint::lerp(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint, t : Double) -> GraphcolorapproxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorapproxPoint::to_string(self : GraphcolorapproxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorapproxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_approx_make_series(vals : Array[Double], name : String) -> GraphcolorapproxSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorapproxSeries::len(self : GraphcolorapproxSeries) -> Int { self.vals.length() }

pub fn GraphcolorapproxSeries::sum(self : GraphcolorapproxSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorapproxSeries::mean(self : GraphcolorapproxSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorapproxSeries::min(self : GraphcolorapproxSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorapproxSeries::max(self : GraphcolorapproxSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorapproxSeries::range(self : GraphcolorapproxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorapproxSeries::variance(self : GraphcolorapproxSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorapproxSeries::std(self : GraphcolorapproxSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorapproxSeries::median(self : GraphcolorapproxSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorapproxSeries::scale(self : GraphcolorapproxSeries, f : Double) -> GraphcolorapproxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorapproxSeries::add(self : GraphcolorapproxSeries, other : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorapproxSeries::sub(self : GraphcolorapproxSeries, other : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorapproxSeries::normalize(self : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorapproxSeries::cumsum(self : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorapproxSeries::to_string(self : GraphcolorapproxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorapproxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_approx_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorapproxMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn graph_color_approx_matrix_identity(n : Int) -> GraphcolorapproxMatrix {
  let m = graph_color_approx_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorapproxMatrix::get(self : GraphcolorapproxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorapproxMatrix::transpose(self : GraphcolorapproxMatrix) -> GraphcolorapproxMatrix {
  let result = graph_color_approx_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorapproxMatrix::add(self : GraphcolorapproxMatrix, other : GraphcolorapproxMatrix) -> GraphcolorapproxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_approx_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorapproxMatrix::scale(self : GraphcolorapproxMatrix, s : Double) -> GraphcolorapproxMatrix {
  let result = graph_color_approx_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorapproxMatrix::multiply(self : GraphcolorapproxMatrix, other : GraphcolorapproxMatrix) -> GraphcolorapproxMatrix {
  if self.cols != other.rows { return graph_color_approx_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_approx_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphcolorapproxMatrix::trace(self : GraphcolorapproxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorapproxMatrix::det(self : GraphcolorapproxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorapproxMatrix::norm(self : GraphcolorapproxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorapproxMatrix::to_string(self : GraphcolorapproxMatrix) -> String {
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

pub(all) struct GraphcolorapproxVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_approx_make_vector(comps : Array[Double]) -> GraphcolorapproxVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_approx_vector_zero(dim : Int) -> GraphcolorapproxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorapproxVector::add(self : GraphcolorapproxVector, other : GraphcolorapproxVector) -> GraphcolorapproxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorapproxVector::sub(self : GraphcolorapproxVector, other : GraphcolorapproxVector) -> GraphcolorapproxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorapproxVector::scale(self : GraphcolorapproxVector, s : Double) -> GraphcolorapproxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorapproxVector::dot(self : GraphcolorapproxVector, other : GraphcolorapproxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorapproxVector::norm(self : GraphcolorapproxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorapproxVector::normalize(self : GraphcolorapproxVector) -> GraphcolorapproxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorapproxVector::dist(self : GraphcolorapproxVector, other : GraphcolorapproxVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorapproxVector::to_string(self : GraphcolorapproxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorapproxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_frame_make(size : Int) -> GraphcolorapproxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxFrame::len(self : GraphcolorapproxFrame) -> Int { self.size }

pub fn GraphcolorapproxFrame::get(self : GraphcolorapproxFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxFrame::set(self : GraphcolorapproxFrame, i : Int, v : Double) -> GraphcolorapproxFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxFrame::sum(self : GraphcolorapproxFrame) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxFrame::mean(self : GraphcolorapproxFrame) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxFrame::scale(self : GraphcolorapproxFrame, f : Double) -> GraphcolorapproxFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxFrame::add(self : GraphcolorapproxFrame, other : GraphcolorapproxFrame) -> GraphcolorapproxFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxFrame::copy(self : GraphcolorapproxFrame) -> GraphcolorapproxFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxFrame::fill(self : GraphcolorapproxFrame, v : Double) -> GraphcolorapproxFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxFrame::min(self : GraphcolorapproxFrame) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxFrame::max(self : GraphcolorapproxFrame) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxFrame::to_string(self : GraphcolorapproxFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_table_make(size : Int) -> GraphcolorapproxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxTable::len(self : GraphcolorapproxTable) -> Int { self.size }

pub fn GraphcolorapproxTable::get(self : GraphcolorapproxTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxTable::set(self : GraphcolorapproxTable, i : Int, v : Double) -> GraphcolorapproxTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxTable::sum(self : GraphcolorapproxTable) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxTable::mean(self : GraphcolorapproxTable) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxTable::scale(self : GraphcolorapproxTable, f : Double) -> GraphcolorapproxTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxTable::add(self : GraphcolorapproxTable, other : GraphcolorapproxTable) -> GraphcolorapproxTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxTable::copy(self : GraphcolorapproxTable) -> GraphcolorapproxTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxTable::fill(self : GraphcolorapproxTable, v : Double) -> GraphcolorapproxTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxTable::min(self : GraphcolorapproxTable) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxTable::max(self : GraphcolorapproxTable) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxTable::to_string(self : GraphcolorapproxTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_graphn_make(size : Int) -> GraphcolorapproxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxGraphN::len(self : GraphcolorapproxGraphN) -> Int { self.size }

pub fn GraphcolorapproxGraphN::get(self : GraphcolorapproxGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxGraphN::set(self : GraphcolorapproxGraphN, i : Int, v : Double) -> GraphcolorapproxGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxGraphN::sum(self : GraphcolorapproxGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxGraphN::mean(self : GraphcolorapproxGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxGraphN::scale(self : GraphcolorapproxGraphN, f : Double) -> GraphcolorapproxGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxGraphN::add(self : GraphcolorapproxGraphN, other : GraphcolorapproxGraphN) -> GraphcolorapproxGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxGraphN::copy(self : GraphcolorapproxGraphN) -> GraphcolorapproxGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxGraphN::fill(self : GraphcolorapproxGraphN, v : Double) -> GraphcolorapproxGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxGraphN::min(self : GraphcolorapproxGraphN) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxGraphN::max(self : GraphcolorapproxGraphN) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxGraphN::to_string(self : GraphcolorapproxGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_node_make(size : Int) -> GraphcolorapproxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxNode::len(self : GraphcolorapproxNode) -> Int { self.size }

pub fn GraphcolorapproxNode::get(self : GraphcolorapproxNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxNode::set(self : GraphcolorapproxNode, i : Int, v : Double) -> GraphcolorapproxNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxNode::sum(self : GraphcolorapproxNode) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxNode::mean(self : GraphcolorapproxNode) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxNode::scale(self : GraphcolorapproxNode, f : Double) -> GraphcolorapproxNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxNode::add(self : GraphcolorapproxNode, other : GraphcolorapproxNode) -> GraphcolorapproxNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxNode::copy(self : GraphcolorapproxNode) -> GraphcolorapproxNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxNode::fill(self : GraphcolorapproxNode, v : Double) -> GraphcolorapproxNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxNode::min(self : GraphcolorapproxNode) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxNode::max(self : GraphcolorapproxNode) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxNode::to_string(self : GraphcolorapproxNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_edge_make(size : Int) -> GraphcolorapproxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxEdge::len(self : GraphcolorapproxEdge) -> Int { self.size }

pub fn GraphcolorapproxEdge::get(self : GraphcolorapproxEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxEdge::set(self : GraphcolorapproxEdge, i : Int, v : Double) -> GraphcolorapproxEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxEdge::sum(self : GraphcolorapproxEdge) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxEdge::mean(self : GraphcolorapproxEdge) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxEdge::scale(self : GraphcolorapproxEdge, f : Double) -> GraphcolorapproxEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxEdge::add(self : GraphcolorapproxEdge, other : GraphcolorapproxEdge) -> GraphcolorapproxEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxEdge::copy(self : GraphcolorapproxEdge) -> GraphcolorapproxEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxEdge::fill(self : GraphcolorapproxEdge, v : Double) -> GraphcolorapproxEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxEdge::min(self : GraphcolorapproxEdge) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxEdge::max(self : GraphcolorapproxEdge) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxEdge::to_string(self : GraphcolorapproxEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_path_make(size : Int) -> GraphcolorapproxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxPath::len(self : GraphcolorapproxPath) -> Int { self.size }

pub fn GraphcolorapproxPath::get(self : GraphcolorapproxPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxPath::set(self : GraphcolorapproxPath, i : Int, v : Double) -> GraphcolorapproxPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxPath::sum(self : GraphcolorapproxPath) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxPath::mean(self : GraphcolorapproxPath) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxPath::scale(self : GraphcolorapproxPath, f : Double) -> GraphcolorapproxPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxPath::add(self : GraphcolorapproxPath, other : GraphcolorapproxPath) -> GraphcolorapproxPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxPath::copy(self : GraphcolorapproxPath) -> GraphcolorapproxPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxPath::fill(self : GraphcolorapproxPath, v : Double) -> GraphcolorapproxPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxPath::min(self : GraphcolorapproxPath) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxPath::max(self : GraphcolorapproxPath) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxPath::to_string(self : GraphcolorapproxPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_cluster_make(size : Int) -> GraphcolorapproxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxCluster::len(self : GraphcolorapproxCluster) -> Int { self.size }

pub fn GraphcolorapproxCluster::get(self : GraphcolorapproxCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxCluster::set(self : GraphcolorapproxCluster, i : Int, v : Double) -> GraphcolorapproxCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxCluster::sum(self : GraphcolorapproxCluster) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxCluster::mean(self : GraphcolorapproxCluster) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxCluster::scale(self : GraphcolorapproxCluster, f : Double) -> GraphcolorapproxCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxCluster::add(self : GraphcolorapproxCluster, other : GraphcolorapproxCluster) -> GraphcolorapproxCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxCluster::copy(self : GraphcolorapproxCluster) -> GraphcolorapproxCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxCluster::fill(self : GraphcolorapproxCluster, v : Double) -> GraphcolorapproxCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxCluster::min(self : GraphcolorapproxCluster) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxCluster::max(self : GraphcolorapproxCluster) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxCluster::to_string(self : GraphcolorapproxCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_model_make(size : Int) -> GraphcolorapproxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxModel::len(self : GraphcolorapproxModel) -> Int { self.size }

pub fn GraphcolorapproxModel::get(self : GraphcolorapproxModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxModel::set(self : GraphcolorapproxModel, i : Int, v : Double) -> GraphcolorapproxModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxModel::sum(self : GraphcolorapproxModel) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxModel::mean(self : GraphcolorapproxModel) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxModel::scale(self : GraphcolorapproxModel, f : Double) -> GraphcolorapproxModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxModel::add(self : GraphcolorapproxModel, other : GraphcolorapproxModel) -> GraphcolorapproxModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxModel::copy(self : GraphcolorapproxModel) -> GraphcolorapproxModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxModel::fill(self : GraphcolorapproxModel, v : Double) -> GraphcolorapproxModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxModel::min(self : GraphcolorapproxModel) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxModel::max(self : GraphcolorapproxModel) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxModel::to_string(self : GraphcolorapproxModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_layer_make(size : Int) -> GraphcolorapproxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxLayer::len(self : GraphcolorapproxLayer) -> Int { self.size }

pub fn GraphcolorapproxLayer::get(self : GraphcolorapproxLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxLayer::set(self : GraphcolorapproxLayer, i : Int, v : Double) -> GraphcolorapproxLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxLayer::sum(self : GraphcolorapproxLayer) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxLayer::mean(self : GraphcolorapproxLayer) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxLayer::scale(self : GraphcolorapproxLayer, f : Double) -> GraphcolorapproxLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxLayer::add(self : GraphcolorapproxLayer, other : GraphcolorapproxLayer) -> GraphcolorapproxLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxLayer::copy(self : GraphcolorapproxLayer) -> GraphcolorapproxLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxLayer::fill(self : GraphcolorapproxLayer, v : Double) -> GraphcolorapproxLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxLayer::min(self : GraphcolorapproxLayer) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxLayer::max(self : GraphcolorapproxLayer) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxLayer::to_string(self : GraphcolorapproxLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_buffer_make(size : Int) -> GraphcolorapproxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxBuffer::len(self : GraphcolorapproxBuffer) -> Int { self.size }

pub fn GraphcolorapproxBuffer::get(self : GraphcolorapproxBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxBuffer::set(self : GraphcolorapproxBuffer, i : Int, v : Double) -> GraphcolorapproxBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxBuffer::sum(self : GraphcolorapproxBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxBuffer::mean(self : GraphcolorapproxBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxBuffer::scale(self : GraphcolorapproxBuffer, f : Double) -> GraphcolorapproxBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxBuffer::add(self : GraphcolorapproxBuffer, other : GraphcolorapproxBuffer) -> GraphcolorapproxBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxBuffer::copy(self : GraphcolorapproxBuffer) -> GraphcolorapproxBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxBuffer::fill(self : GraphcolorapproxBuffer, v : Double) -> GraphcolorapproxBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxBuffer::min(self : GraphcolorapproxBuffer) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxBuffer::max(self : GraphcolorapproxBuffer) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxBuffer::to_string(self : GraphcolorapproxBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_cursor_make(size : Int) -> GraphcolorapproxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxCursor::len(self : GraphcolorapproxCursor) -> Int { self.size }

pub fn GraphcolorapproxCursor::get(self : GraphcolorapproxCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxCursor::set(self : GraphcolorapproxCursor, i : Int, v : Double) -> GraphcolorapproxCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxCursor::sum(self : GraphcolorapproxCursor) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxCursor::mean(self : GraphcolorapproxCursor) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxCursor::scale(self : GraphcolorapproxCursor, f : Double) -> GraphcolorapproxCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxCursor::add(self : GraphcolorapproxCursor, other : GraphcolorapproxCursor) -> GraphcolorapproxCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxCursor::copy(self : GraphcolorapproxCursor) -> GraphcolorapproxCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxCursor::fill(self : GraphcolorapproxCursor, v : Double) -> GraphcolorapproxCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxCursor::min(self : GraphcolorapproxCursor) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxCursor::max(self : GraphcolorapproxCursor) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxCursor::to_string(self : GraphcolorapproxCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_view_make(size : Int) -> GraphcolorapproxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxView::len(self : GraphcolorapproxView) -> Int { self.size }

pub fn GraphcolorapproxView::get(self : GraphcolorapproxView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxView::set(self : GraphcolorapproxView, i : Int, v : Double) -> GraphcolorapproxView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxView::sum(self : GraphcolorapproxView) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxView::mean(self : GraphcolorapproxView) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxView::scale(self : GraphcolorapproxView, f : Double) -> GraphcolorapproxView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxView::add(self : GraphcolorapproxView, other : GraphcolorapproxView) -> GraphcolorapproxView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxView::copy(self : GraphcolorapproxView) -> GraphcolorapproxView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxView::fill(self : GraphcolorapproxView, v : Double) -> GraphcolorapproxView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxView::min(self : GraphcolorapproxView) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxView::max(self : GraphcolorapproxView) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxView::to_string(self : GraphcolorapproxView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_range_make(size : Int) -> GraphcolorapproxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxRange::len(self : GraphcolorapproxRange) -> Int { self.size }

pub fn GraphcolorapproxRange::get(self : GraphcolorapproxRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxRange::set(self : GraphcolorapproxRange, i : Int, v : Double) -> GraphcolorapproxRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxRange::sum(self : GraphcolorapproxRange) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxRange::mean(self : GraphcolorapproxRange) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxRange::scale(self : GraphcolorapproxRange, f : Double) -> GraphcolorapproxRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxRange::add(self : GraphcolorapproxRange, other : GraphcolorapproxRange) -> GraphcolorapproxRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxRange::copy(self : GraphcolorapproxRange) -> GraphcolorapproxRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxRange::fill(self : GraphcolorapproxRange, v : Double) -> GraphcolorapproxRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxRange::min(self : GraphcolorapproxRange) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxRange::max(self : GraphcolorapproxRange) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxRange::to_string(self : GraphcolorapproxRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_slice_make(size : Int) -> GraphcolorapproxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorapproxSlice::len(self : GraphcolorapproxSlice) -> Int { self.size }

pub fn GraphcolorapproxSlice::get(self : GraphcolorapproxSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorapproxSlice::set(self : GraphcolorapproxSlice, i : Int, v : Double) -> GraphcolorapproxSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxSlice::sum(self : GraphcolorapproxSlice) -> Double { @_common.sum(self.data) }

pub fn GraphcolorapproxSlice::mean(self : GraphcolorapproxSlice) -> Double { @_common.mean(self.data) }

pub fn GraphcolorapproxSlice::scale(self : GraphcolorapproxSlice, f : Double) -> GraphcolorapproxSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxSlice::add(self : GraphcolorapproxSlice, other : GraphcolorapproxSlice) -> GraphcolorapproxSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorapproxSlice::copy(self : GraphcolorapproxSlice) -> GraphcolorapproxSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxSlice::fill(self : GraphcolorapproxSlice, v : Double) -> GraphcolorapproxSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorapproxSlice::min(self : GraphcolorapproxSlice) -> Double { @_common.min(self.data) }

pub fn GraphcolorapproxSlice::max(self : GraphcolorapproxSlice) -> Double { @_common.max(self.data) }

pub fn GraphcolorapproxSlice::to_string(self : GraphcolorapproxSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

