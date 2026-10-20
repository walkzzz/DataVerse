///===
/// extcore/graph_connect_components

pub(all) struct GraphconnectcomponentsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_components_make_point(x : Double, y : Double) -> GraphconnectcomponentsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_components_make_point3(x : Double, y : Double, z : Double) -> GraphconnectcomponentsPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnectcomponentsPoint::x(self : GraphconnectcomponentsPoint) -> Double { self.x }

pub fn GraphconnectcomponentsPoint::y(self : GraphconnectcomponentsPoint) -> Double { self.y }

pub fn GraphconnectcomponentsPoint::z(self : GraphconnectcomponentsPoint) -> Double { self.z }

pub fn GraphconnectcomponentsPoint::label(self : GraphconnectcomponentsPoint) -> Int { self.label }

pub fn GraphconnectcomponentsPoint::dist(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnectcomponentsPoint::add(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnectcomponentsPoint::sub(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnectcomponentsPoint::scale(self : GraphconnectcomponentsPoint, s : Double) -> GraphconnectcomponentsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnectcomponentsPoint::dot(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnectcomponentsPoint::cross(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnectcomponentsPoint::norm(self : GraphconnectcomponentsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnectcomponentsPoint::normalize(self : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectcomponentsPoint::negate(self : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnectcomponentsPoint::mid(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnectcomponentsPoint::lerp(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint, t : Double) -> GraphconnectcomponentsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnectcomponentsPoint::to_string(self : GraphconnectcomponentsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_components_make_series(vals : Array[Double], name : String) -> GraphconnectcomponentsSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnectcomponentsSeries::len(self : GraphconnectcomponentsSeries) -> Int { self.vals.length() }

pub fn GraphconnectcomponentsSeries::sum(self : GraphconnectcomponentsSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnectcomponentsSeries::mean(self : GraphconnectcomponentsSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnectcomponentsSeries::min(self : GraphconnectcomponentsSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnectcomponentsSeries::max(self : GraphconnectcomponentsSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnectcomponentsSeries::range(self : GraphconnectcomponentsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnectcomponentsSeries::variance(self : GraphconnectcomponentsSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnectcomponentsSeries::std(self : GraphconnectcomponentsSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnectcomponentsSeries::median(self : GraphconnectcomponentsSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnectcomponentsSeries::scale(self : GraphconnectcomponentsSeries, f : Double) -> GraphconnectcomponentsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnectcomponentsSeries::add(self : GraphconnectcomponentsSeries, other : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnectcomponentsSeries::sub(self : GraphconnectcomponentsSeries, other : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnectcomponentsSeries::normalize(self : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnectcomponentsSeries::cumsum(self : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnectcomponentsSeries::to_string(self : GraphconnectcomponentsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectcomponentsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_components_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectcomponentsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_components_matrix_identity(n : Int) -> GraphconnectcomponentsMatrix {
  let m = graph_connect_components_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnectcomponentsMatrix::get(self : GraphconnectcomponentsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnectcomponentsMatrix::transpose(self : GraphconnectcomponentsMatrix) -> GraphconnectcomponentsMatrix {
  let result = graph_connect_components_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnectcomponentsMatrix::add(self : GraphconnectcomponentsMatrix, other : GraphconnectcomponentsMatrix) -> GraphconnectcomponentsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_components_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnectcomponentsMatrix::scale(self : GraphconnectcomponentsMatrix, s : Double) -> GraphconnectcomponentsMatrix {
  let result = graph_connect_components_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnectcomponentsMatrix::multiply(self : GraphconnectcomponentsMatrix, other : GraphconnectcomponentsMatrix) -> GraphconnectcomponentsMatrix {
  if self.cols != other.rows { return graph_connect_components_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_components_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphconnectcomponentsMatrix::trace(self : GraphconnectcomponentsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnectcomponentsMatrix::det(self : GraphconnectcomponentsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnectcomponentsMatrix::norm(self : GraphconnectcomponentsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnectcomponentsMatrix::to_string(self : GraphconnectcomponentsMatrix) -> String {
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

pub(all) struct GraphconnectcomponentsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_components_make_vector(comps : Array[Double]) -> GraphconnectcomponentsVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_components_vector_zero(dim : Int) -> GraphconnectcomponentsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnectcomponentsVector::add(self : GraphconnectcomponentsVector, other : GraphconnectcomponentsVector) -> GraphconnectcomponentsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectcomponentsVector::sub(self : GraphconnectcomponentsVector, other : GraphconnectcomponentsVector) -> GraphconnectcomponentsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectcomponentsVector::scale(self : GraphconnectcomponentsVector, s : Double) -> GraphconnectcomponentsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnectcomponentsVector::dot(self : GraphconnectcomponentsVector, other : GraphconnectcomponentsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnectcomponentsVector::norm(self : GraphconnectcomponentsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnectcomponentsVector::normalize(self : GraphconnectcomponentsVector) -> GraphconnectcomponentsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectcomponentsVector::dist(self : GraphconnectcomponentsVector, other : GraphconnectcomponentsVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnectcomponentsVector::to_string(self : GraphconnectcomponentsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectcomponentsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_frame_make(size : Int) -> GraphconnectcomponentsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsFrame::len(self : GraphconnectcomponentsFrame) -> Int { self.size }

pub fn GraphconnectcomponentsFrame::get(self : GraphconnectcomponentsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsFrame::set(self : GraphconnectcomponentsFrame, i : Int, v : Double) -> GraphconnectcomponentsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsFrame::sum(self : GraphconnectcomponentsFrame) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsFrame::mean(self : GraphconnectcomponentsFrame) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsFrame::scale(self : GraphconnectcomponentsFrame, f : Double) -> GraphconnectcomponentsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsFrame::add(self : GraphconnectcomponentsFrame, other : GraphconnectcomponentsFrame) -> GraphconnectcomponentsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsFrame::copy(self : GraphconnectcomponentsFrame) -> GraphconnectcomponentsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsFrame::fill(self : GraphconnectcomponentsFrame, v : Double) -> GraphconnectcomponentsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsFrame::min(self : GraphconnectcomponentsFrame) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsFrame::max(self : GraphconnectcomponentsFrame) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsFrame::to_string(self : GraphconnectcomponentsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_table_make(size : Int) -> GraphconnectcomponentsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsTable::len(self : GraphconnectcomponentsTable) -> Int { self.size }

pub fn GraphconnectcomponentsTable::get(self : GraphconnectcomponentsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsTable::set(self : GraphconnectcomponentsTable, i : Int, v : Double) -> GraphconnectcomponentsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsTable::sum(self : GraphconnectcomponentsTable) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsTable::mean(self : GraphconnectcomponentsTable) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsTable::scale(self : GraphconnectcomponentsTable, f : Double) -> GraphconnectcomponentsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsTable::add(self : GraphconnectcomponentsTable, other : GraphconnectcomponentsTable) -> GraphconnectcomponentsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsTable::copy(self : GraphconnectcomponentsTable) -> GraphconnectcomponentsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsTable::fill(self : GraphconnectcomponentsTable, v : Double) -> GraphconnectcomponentsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsTable::min(self : GraphconnectcomponentsTable) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsTable::max(self : GraphconnectcomponentsTable) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsTable::to_string(self : GraphconnectcomponentsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_graphn_make(size : Int) -> GraphconnectcomponentsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsGraphN::len(self : GraphconnectcomponentsGraphN) -> Int { self.size }

pub fn GraphconnectcomponentsGraphN::get(self : GraphconnectcomponentsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsGraphN::set(self : GraphconnectcomponentsGraphN, i : Int, v : Double) -> GraphconnectcomponentsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsGraphN::sum(self : GraphconnectcomponentsGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsGraphN::mean(self : GraphconnectcomponentsGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsGraphN::scale(self : GraphconnectcomponentsGraphN, f : Double) -> GraphconnectcomponentsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsGraphN::add(self : GraphconnectcomponentsGraphN, other : GraphconnectcomponentsGraphN) -> GraphconnectcomponentsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsGraphN::copy(self : GraphconnectcomponentsGraphN) -> GraphconnectcomponentsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsGraphN::fill(self : GraphconnectcomponentsGraphN, v : Double) -> GraphconnectcomponentsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsGraphN::min(self : GraphconnectcomponentsGraphN) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsGraphN::max(self : GraphconnectcomponentsGraphN) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsGraphN::to_string(self : GraphconnectcomponentsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_node_make(size : Int) -> GraphconnectcomponentsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsNode::len(self : GraphconnectcomponentsNode) -> Int { self.size }

pub fn GraphconnectcomponentsNode::get(self : GraphconnectcomponentsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsNode::set(self : GraphconnectcomponentsNode, i : Int, v : Double) -> GraphconnectcomponentsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsNode::sum(self : GraphconnectcomponentsNode) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsNode::mean(self : GraphconnectcomponentsNode) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsNode::scale(self : GraphconnectcomponentsNode, f : Double) -> GraphconnectcomponentsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsNode::add(self : GraphconnectcomponentsNode, other : GraphconnectcomponentsNode) -> GraphconnectcomponentsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsNode::copy(self : GraphconnectcomponentsNode) -> GraphconnectcomponentsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsNode::fill(self : GraphconnectcomponentsNode, v : Double) -> GraphconnectcomponentsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsNode::min(self : GraphconnectcomponentsNode) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsNode::max(self : GraphconnectcomponentsNode) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsNode::to_string(self : GraphconnectcomponentsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_edge_make(size : Int) -> GraphconnectcomponentsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsEdge::len(self : GraphconnectcomponentsEdge) -> Int { self.size }

pub fn GraphconnectcomponentsEdge::get(self : GraphconnectcomponentsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsEdge::set(self : GraphconnectcomponentsEdge, i : Int, v : Double) -> GraphconnectcomponentsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsEdge::sum(self : GraphconnectcomponentsEdge) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsEdge::mean(self : GraphconnectcomponentsEdge) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsEdge::scale(self : GraphconnectcomponentsEdge, f : Double) -> GraphconnectcomponentsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsEdge::add(self : GraphconnectcomponentsEdge, other : GraphconnectcomponentsEdge) -> GraphconnectcomponentsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsEdge::copy(self : GraphconnectcomponentsEdge) -> GraphconnectcomponentsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsEdge::fill(self : GraphconnectcomponentsEdge, v : Double) -> GraphconnectcomponentsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsEdge::min(self : GraphconnectcomponentsEdge) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsEdge::max(self : GraphconnectcomponentsEdge) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsEdge::to_string(self : GraphconnectcomponentsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_path_make(size : Int) -> GraphconnectcomponentsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsPath::len(self : GraphconnectcomponentsPath) -> Int { self.size }

pub fn GraphconnectcomponentsPath::get(self : GraphconnectcomponentsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsPath::set(self : GraphconnectcomponentsPath, i : Int, v : Double) -> GraphconnectcomponentsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsPath::sum(self : GraphconnectcomponentsPath) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsPath::mean(self : GraphconnectcomponentsPath) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsPath::scale(self : GraphconnectcomponentsPath, f : Double) -> GraphconnectcomponentsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsPath::add(self : GraphconnectcomponentsPath, other : GraphconnectcomponentsPath) -> GraphconnectcomponentsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsPath::copy(self : GraphconnectcomponentsPath) -> GraphconnectcomponentsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsPath::fill(self : GraphconnectcomponentsPath, v : Double) -> GraphconnectcomponentsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsPath::min(self : GraphconnectcomponentsPath) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsPath::max(self : GraphconnectcomponentsPath) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsPath::to_string(self : GraphconnectcomponentsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_cluster_make(size : Int) -> GraphconnectcomponentsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsCluster::len(self : GraphconnectcomponentsCluster) -> Int { self.size }

pub fn GraphconnectcomponentsCluster::get(self : GraphconnectcomponentsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsCluster::set(self : GraphconnectcomponentsCluster, i : Int, v : Double) -> GraphconnectcomponentsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsCluster::sum(self : GraphconnectcomponentsCluster) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsCluster::mean(self : GraphconnectcomponentsCluster) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsCluster::scale(self : GraphconnectcomponentsCluster, f : Double) -> GraphconnectcomponentsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsCluster::add(self : GraphconnectcomponentsCluster, other : GraphconnectcomponentsCluster) -> GraphconnectcomponentsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsCluster::copy(self : GraphconnectcomponentsCluster) -> GraphconnectcomponentsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsCluster::fill(self : GraphconnectcomponentsCluster, v : Double) -> GraphconnectcomponentsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsCluster::min(self : GraphconnectcomponentsCluster) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsCluster::max(self : GraphconnectcomponentsCluster) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsCluster::to_string(self : GraphconnectcomponentsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_model_make(size : Int) -> GraphconnectcomponentsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsModel::len(self : GraphconnectcomponentsModel) -> Int { self.size }

pub fn GraphconnectcomponentsModel::get(self : GraphconnectcomponentsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsModel::set(self : GraphconnectcomponentsModel, i : Int, v : Double) -> GraphconnectcomponentsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsModel::sum(self : GraphconnectcomponentsModel) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsModel::mean(self : GraphconnectcomponentsModel) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsModel::scale(self : GraphconnectcomponentsModel, f : Double) -> GraphconnectcomponentsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsModel::add(self : GraphconnectcomponentsModel, other : GraphconnectcomponentsModel) -> GraphconnectcomponentsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsModel::copy(self : GraphconnectcomponentsModel) -> GraphconnectcomponentsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsModel::fill(self : GraphconnectcomponentsModel, v : Double) -> GraphconnectcomponentsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsModel::min(self : GraphconnectcomponentsModel) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsModel::max(self : GraphconnectcomponentsModel) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsModel::to_string(self : GraphconnectcomponentsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_layer_make(size : Int) -> GraphconnectcomponentsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsLayer::len(self : GraphconnectcomponentsLayer) -> Int { self.size }

pub fn GraphconnectcomponentsLayer::get(self : GraphconnectcomponentsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsLayer::set(self : GraphconnectcomponentsLayer, i : Int, v : Double) -> GraphconnectcomponentsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsLayer::sum(self : GraphconnectcomponentsLayer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsLayer::mean(self : GraphconnectcomponentsLayer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsLayer::scale(self : GraphconnectcomponentsLayer, f : Double) -> GraphconnectcomponentsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsLayer::add(self : GraphconnectcomponentsLayer, other : GraphconnectcomponentsLayer) -> GraphconnectcomponentsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsLayer::copy(self : GraphconnectcomponentsLayer) -> GraphconnectcomponentsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsLayer::fill(self : GraphconnectcomponentsLayer, v : Double) -> GraphconnectcomponentsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsLayer::min(self : GraphconnectcomponentsLayer) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsLayer::max(self : GraphconnectcomponentsLayer) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsLayer::to_string(self : GraphconnectcomponentsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_buffer_make(size : Int) -> GraphconnectcomponentsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsBuffer::len(self : GraphconnectcomponentsBuffer) -> Int { self.size }

pub fn GraphconnectcomponentsBuffer::get(self : GraphconnectcomponentsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsBuffer::set(self : GraphconnectcomponentsBuffer, i : Int, v : Double) -> GraphconnectcomponentsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsBuffer::sum(self : GraphconnectcomponentsBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsBuffer::mean(self : GraphconnectcomponentsBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsBuffer::scale(self : GraphconnectcomponentsBuffer, f : Double) -> GraphconnectcomponentsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsBuffer::add(self : GraphconnectcomponentsBuffer, other : GraphconnectcomponentsBuffer) -> GraphconnectcomponentsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsBuffer::copy(self : GraphconnectcomponentsBuffer) -> GraphconnectcomponentsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsBuffer::fill(self : GraphconnectcomponentsBuffer, v : Double) -> GraphconnectcomponentsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsBuffer::min(self : GraphconnectcomponentsBuffer) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsBuffer::max(self : GraphconnectcomponentsBuffer) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsBuffer::to_string(self : GraphconnectcomponentsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_cursor_make(size : Int) -> GraphconnectcomponentsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsCursor::len(self : GraphconnectcomponentsCursor) -> Int { self.size }

pub fn GraphconnectcomponentsCursor::get(self : GraphconnectcomponentsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsCursor::set(self : GraphconnectcomponentsCursor, i : Int, v : Double) -> GraphconnectcomponentsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsCursor::sum(self : GraphconnectcomponentsCursor) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsCursor::mean(self : GraphconnectcomponentsCursor) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsCursor::scale(self : GraphconnectcomponentsCursor, f : Double) -> GraphconnectcomponentsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsCursor::add(self : GraphconnectcomponentsCursor, other : GraphconnectcomponentsCursor) -> GraphconnectcomponentsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsCursor::copy(self : GraphconnectcomponentsCursor) -> GraphconnectcomponentsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsCursor::fill(self : GraphconnectcomponentsCursor, v : Double) -> GraphconnectcomponentsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsCursor::min(self : GraphconnectcomponentsCursor) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsCursor::max(self : GraphconnectcomponentsCursor) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsCursor::to_string(self : GraphconnectcomponentsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_view_make(size : Int) -> GraphconnectcomponentsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsView::len(self : GraphconnectcomponentsView) -> Int { self.size }

pub fn GraphconnectcomponentsView::get(self : GraphconnectcomponentsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsView::set(self : GraphconnectcomponentsView, i : Int, v : Double) -> GraphconnectcomponentsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsView::sum(self : GraphconnectcomponentsView) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsView::mean(self : GraphconnectcomponentsView) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsView::scale(self : GraphconnectcomponentsView, f : Double) -> GraphconnectcomponentsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsView::add(self : GraphconnectcomponentsView, other : GraphconnectcomponentsView) -> GraphconnectcomponentsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsView::copy(self : GraphconnectcomponentsView) -> GraphconnectcomponentsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsView::fill(self : GraphconnectcomponentsView, v : Double) -> GraphconnectcomponentsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsView::min(self : GraphconnectcomponentsView) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsView::max(self : GraphconnectcomponentsView) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsView::to_string(self : GraphconnectcomponentsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_range_make(size : Int) -> GraphconnectcomponentsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsRange::len(self : GraphconnectcomponentsRange) -> Int { self.size }

pub fn GraphconnectcomponentsRange::get(self : GraphconnectcomponentsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsRange::set(self : GraphconnectcomponentsRange, i : Int, v : Double) -> GraphconnectcomponentsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsRange::sum(self : GraphconnectcomponentsRange) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsRange::mean(self : GraphconnectcomponentsRange) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsRange::scale(self : GraphconnectcomponentsRange, f : Double) -> GraphconnectcomponentsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsRange::add(self : GraphconnectcomponentsRange, other : GraphconnectcomponentsRange) -> GraphconnectcomponentsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsRange::copy(self : GraphconnectcomponentsRange) -> GraphconnectcomponentsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsRange::fill(self : GraphconnectcomponentsRange, v : Double) -> GraphconnectcomponentsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsRange::min(self : GraphconnectcomponentsRange) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsRange::max(self : GraphconnectcomponentsRange) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsRange::to_string(self : GraphconnectcomponentsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_slice_make(size : Int) -> GraphconnectcomponentsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectcomponentsSlice::len(self : GraphconnectcomponentsSlice) -> Int { self.size }

pub fn GraphconnectcomponentsSlice::get(self : GraphconnectcomponentsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectcomponentsSlice::set(self : GraphconnectcomponentsSlice, i : Int, v : Double) -> GraphconnectcomponentsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsSlice::sum(self : GraphconnectcomponentsSlice) -> Double { @_common.sum(self.data) }

pub fn GraphconnectcomponentsSlice::mean(self : GraphconnectcomponentsSlice) -> Double { @_common.mean(self.data) }

pub fn GraphconnectcomponentsSlice::scale(self : GraphconnectcomponentsSlice, f : Double) -> GraphconnectcomponentsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsSlice::add(self : GraphconnectcomponentsSlice, other : GraphconnectcomponentsSlice) -> GraphconnectcomponentsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectcomponentsSlice::copy(self : GraphconnectcomponentsSlice) -> GraphconnectcomponentsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsSlice::fill(self : GraphconnectcomponentsSlice, v : Double) -> GraphconnectcomponentsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectcomponentsSlice::min(self : GraphconnectcomponentsSlice) -> Double { @_common.min(self.data) }

pub fn GraphconnectcomponentsSlice::max(self : GraphconnectcomponentsSlice) -> Double { @_common.max(self.data) }

pub fn GraphconnectcomponentsSlice::to_string(self : GraphconnectcomponentsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

