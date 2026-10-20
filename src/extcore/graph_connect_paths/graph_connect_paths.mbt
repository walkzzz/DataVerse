///===
/// extcore/graph_connect_paths

pub(all) struct GraphconnectpathsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_paths_make_point(x : Double, y : Double) -> GraphconnectpathsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_paths_make_point3(x : Double, y : Double, z : Double) -> GraphconnectpathsPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnectpathsPoint::x(self : GraphconnectpathsPoint) -> Double { self.x }

pub fn GraphconnectpathsPoint::y(self : GraphconnectpathsPoint) -> Double { self.y }

pub fn GraphconnectpathsPoint::z(self : GraphconnectpathsPoint) -> Double { self.z }

pub fn GraphconnectpathsPoint::label(self : GraphconnectpathsPoint) -> Int { self.label }

pub fn GraphconnectpathsPoint::dist(self : GraphconnectpathsPoint, other : GraphconnectpathsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnectpathsPoint::add(self : GraphconnectpathsPoint, other : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnectpathsPoint::sub(self : GraphconnectpathsPoint, other : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnectpathsPoint::scale(self : GraphconnectpathsPoint, s : Double) -> GraphconnectpathsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnectpathsPoint::dot(self : GraphconnectpathsPoint, other : GraphconnectpathsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnectpathsPoint::cross(self : GraphconnectpathsPoint, other : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnectpathsPoint::norm(self : GraphconnectpathsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnectpathsPoint::normalize(self : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectpathsPoint::negate(self : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnectpathsPoint::mid(self : GraphconnectpathsPoint, other : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnectpathsPoint::lerp(self : GraphconnectpathsPoint, other : GraphconnectpathsPoint, t : Double) -> GraphconnectpathsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnectpathsPoint::to_string(self : GraphconnectpathsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnectpathsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_paths_make_series(vals : Array[Double], name : String) -> GraphconnectpathsSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnectpathsSeries::len(self : GraphconnectpathsSeries) -> Int { self.vals.length() }

pub fn GraphconnectpathsSeries::sum(self : GraphconnectpathsSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnectpathsSeries::mean(self : GraphconnectpathsSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnectpathsSeries::min(self : GraphconnectpathsSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnectpathsSeries::max(self : GraphconnectpathsSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnectpathsSeries::range(self : GraphconnectpathsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnectpathsSeries::variance(self : GraphconnectpathsSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnectpathsSeries::std(self : GraphconnectpathsSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnectpathsSeries::median(self : GraphconnectpathsSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnectpathsSeries::scale(self : GraphconnectpathsSeries, f : Double) -> GraphconnectpathsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnectpathsSeries::add(self : GraphconnectpathsSeries, other : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnectpathsSeries::sub(self : GraphconnectpathsSeries, other : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnectpathsSeries::normalize(self : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnectpathsSeries::cumsum(self : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnectpathsSeries::to_string(self : GraphconnectpathsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectpathsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_paths_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectpathsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_paths_matrix_identity(n : Int) -> GraphconnectpathsMatrix {
  let m = graph_connect_paths_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnectpathsMatrix::get(self : GraphconnectpathsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnectpathsMatrix::transpose(self : GraphconnectpathsMatrix) -> GraphconnectpathsMatrix {
  let result = graph_connect_paths_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnectpathsMatrix::add(self : GraphconnectpathsMatrix, other : GraphconnectpathsMatrix) -> GraphconnectpathsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_paths_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnectpathsMatrix::scale(self : GraphconnectpathsMatrix, s : Double) -> GraphconnectpathsMatrix {
  let result = graph_connect_paths_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnectpathsMatrix::multiply(self : GraphconnectpathsMatrix, other : GraphconnectpathsMatrix) -> GraphconnectpathsMatrix {
  if self.cols != other.rows { return graph_connect_paths_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_paths_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphconnectpathsMatrix::trace(self : GraphconnectpathsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnectpathsMatrix::det(self : GraphconnectpathsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnectpathsMatrix::norm(self : GraphconnectpathsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnectpathsMatrix::to_string(self : GraphconnectpathsMatrix) -> String {
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

pub(all) struct GraphconnectpathsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_paths_make_vector(comps : Array[Double]) -> GraphconnectpathsVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_paths_vector_zero(dim : Int) -> GraphconnectpathsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnectpathsVector::add(self : GraphconnectpathsVector, other : GraphconnectpathsVector) -> GraphconnectpathsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectpathsVector::sub(self : GraphconnectpathsVector, other : GraphconnectpathsVector) -> GraphconnectpathsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectpathsVector::scale(self : GraphconnectpathsVector, s : Double) -> GraphconnectpathsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnectpathsVector::dot(self : GraphconnectpathsVector, other : GraphconnectpathsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnectpathsVector::norm(self : GraphconnectpathsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnectpathsVector::normalize(self : GraphconnectpathsVector) -> GraphconnectpathsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectpathsVector::dist(self : GraphconnectpathsVector, other : GraphconnectpathsVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnectpathsVector::to_string(self : GraphconnectpathsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectpathsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_frame_make(size : Int) -> GraphconnectpathsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsFrame::len(self : GraphconnectpathsFrame) -> Int { self.size }

pub fn GraphconnectpathsFrame::get(self : GraphconnectpathsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsFrame::set(self : GraphconnectpathsFrame, i : Int, v : Double) -> GraphconnectpathsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsFrame::sum(self : GraphconnectpathsFrame) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsFrame::mean(self : GraphconnectpathsFrame) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsFrame::scale(self : GraphconnectpathsFrame, f : Double) -> GraphconnectpathsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsFrame::add(self : GraphconnectpathsFrame, other : GraphconnectpathsFrame) -> GraphconnectpathsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsFrame::copy(self : GraphconnectpathsFrame) -> GraphconnectpathsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsFrame::fill(self : GraphconnectpathsFrame, v : Double) -> GraphconnectpathsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsFrame::min(self : GraphconnectpathsFrame) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsFrame::max(self : GraphconnectpathsFrame) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsFrame::to_string(self : GraphconnectpathsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_table_make(size : Int) -> GraphconnectpathsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsTable::len(self : GraphconnectpathsTable) -> Int { self.size }

pub fn GraphconnectpathsTable::get(self : GraphconnectpathsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsTable::set(self : GraphconnectpathsTable, i : Int, v : Double) -> GraphconnectpathsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsTable::sum(self : GraphconnectpathsTable) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsTable::mean(self : GraphconnectpathsTable) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsTable::scale(self : GraphconnectpathsTable, f : Double) -> GraphconnectpathsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsTable::add(self : GraphconnectpathsTable, other : GraphconnectpathsTable) -> GraphconnectpathsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsTable::copy(self : GraphconnectpathsTable) -> GraphconnectpathsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsTable::fill(self : GraphconnectpathsTable, v : Double) -> GraphconnectpathsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsTable::min(self : GraphconnectpathsTable) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsTable::max(self : GraphconnectpathsTable) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsTable::to_string(self : GraphconnectpathsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_graphn_make(size : Int) -> GraphconnectpathsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsGraphN::len(self : GraphconnectpathsGraphN) -> Int { self.size }

pub fn GraphconnectpathsGraphN::get(self : GraphconnectpathsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsGraphN::set(self : GraphconnectpathsGraphN, i : Int, v : Double) -> GraphconnectpathsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsGraphN::sum(self : GraphconnectpathsGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsGraphN::mean(self : GraphconnectpathsGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsGraphN::scale(self : GraphconnectpathsGraphN, f : Double) -> GraphconnectpathsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsGraphN::add(self : GraphconnectpathsGraphN, other : GraphconnectpathsGraphN) -> GraphconnectpathsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsGraphN::copy(self : GraphconnectpathsGraphN) -> GraphconnectpathsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsGraphN::fill(self : GraphconnectpathsGraphN, v : Double) -> GraphconnectpathsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsGraphN::min(self : GraphconnectpathsGraphN) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsGraphN::max(self : GraphconnectpathsGraphN) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsGraphN::to_string(self : GraphconnectpathsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_node_make(size : Int) -> GraphconnectpathsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsNode::len(self : GraphconnectpathsNode) -> Int { self.size }

pub fn GraphconnectpathsNode::get(self : GraphconnectpathsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsNode::set(self : GraphconnectpathsNode, i : Int, v : Double) -> GraphconnectpathsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsNode::sum(self : GraphconnectpathsNode) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsNode::mean(self : GraphconnectpathsNode) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsNode::scale(self : GraphconnectpathsNode, f : Double) -> GraphconnectpathsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsNode::add(self : GraphconnectpathsNode, other : GraphconnectpathsNode) -> GraphconnectpathsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsNode::copy(self : GraphconnectpathsNode) -> GraphconnectpathsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsNode::fill(self : GraphconnectpathsNode, v : Double) -> GraphconnectpathsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsNode::min(self : GraphconnectpathsNode) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsNode::max(self : GraphconnectpathsNode) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsNode::to_string(self : GraphconnectpathsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_edge_make(size : Int) -> GraphconnectpathsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsEdge::len(self : GraphconnectpathsEdge) -> Int { self.size }

pub fn GraphconnectpathsEdge::get(self : GraphconnectpathsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsEdge::set(self : GraphconnectpathsEdge, i : Int, v : Double) -> GraphconnectpathsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsEdge::sum(self : GraphconnectpathsEdge) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsEdge::mean(self : GraphconnectpathsEdge) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsEdge::scale(self : GraphconnectpathsEdge, f : Double) -> GraphconnectpathsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsEdge::add(self : GraphconnectpathsEdge, other : GraphconnectpathsEdge) -> GraphconnectpathsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsEdge::copy(self : GraphconnectpathsEdge) -> GraphconnectpathsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsEdge::fill(self : GraphconnectpathsEdge, v : Double) -> GraphconnectpathsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsEdge::min(self : GraphconnectpathsEdge) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsEdge::max(self : GraphconnectpathsEdge) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsEdge::to_string(self : GraphconnectpathsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_path_make(size : Int) -> GraphconnectpathsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsPath::len(self : GraphconnectpathsPath) -> Int { self.size }

pub fn GraphconnectpathsPath::get(self : GraphconnectpathsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsPath::set(self : GraphconnectpathsPath, i : Int, v : Double) -> GraphconnectpathsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsPath::sum(self : GraphconnectpathsPath) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsPath::mean(self : GraphconnectpathsPath) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsPath::scale(self : GraphconnectpathsPath, f : Double) -> GraphconnectpathsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsPath::add(self : GraphconnectpathsPath, other : GraphconnectpathsPath) -> GraphconnectpathsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsPath::copy(self : GraphconnectpathsPath) -> GraphconnectpathsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsPath::fill(self : GraphconnectpathsPath, v : Double) -> GraphconnectpathsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsPath::min(self : GraphconnectpathsPath) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsPath::max(self : GraphconnectpathsPath) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsPath::to_string(self : GraphconnectpathsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_cluster_make(size : Int) -> GraphconnectpathsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsCluster::len(self : GraphconnectpathsCluster) -> Int { self.size }

pub fn GraphconnectpathsCluster::get(self : GraphconnectpathsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsCluster::set(self : GraphconnectpathsCluster, i : Int, v : Double) -> GraphconnectpathsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsCluster::sum(self : GraphconnectpathsCluster) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsCluster::mean(self : GraphconnectpathsCluster) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsCluster::scale(self : GraphconnectpathsCluster, f : Double) -> GraphconnectpathsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsCluster::add(self : GraphconnectpathsCluster, other : GraphconnectpathsCluster) -> GraphconnectpathsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsCluster::copy(self : GraphconnectpathsCluster) -> GraphconnectpathsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsCluster::fill(self : GraphconnectpathsCluster, v : Double) -> GraphconnectpathsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsCluster::min(self : GraphconnectpathsCluster) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsCluster::max(self : GraphconnectpathsCluster) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsCluster::to_string(self : GraphconnectpathsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_model_make(size : Int) -> GraphconnectpathsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsModel::len(self : GraphconnectpathsModel) -> Int { self.size }

pub fn GraphconnectpathsModel::get(self : GraphconnectpathsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsModel::set(self : GraphconnectpathsModel, i : Int, v : Double) -> GraphconnectpathsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsModel::sum(self : GraphconnectpathsModel) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsModel::mean(self : GraphconnectpathsModel) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsModel::scale(self : GraphconnectpathsModel, f : Double) -> GraphconnectpathsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsModel::add(self : GraphconnectpathsModel, other : GraphconnectpathsModel) -> GraphconnectpathsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsModel::copy(self : GraphconnectpathsModel) -> GraphconnectpathsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsModel::fill(self : GraphconnectpathsModel, v : Double) -> GraphconnectpathsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsModel::min(self : GraphconnectpathsModel) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsModel::max(self : GraphconnectpathsModel) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsModel::to_string(self : GraphconnectpathsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_layer_make(size : Int) -> GraphconnectpathsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsLayer::len(self : GraphconnectpathsLayer) -> Int { self.size }

pub fn GraphconnectpathsLayer::get(self : GraphconnectpathsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsLayer::set(self : GraphconnectpathsLayer, i : Int, v : Double) -> GraphconnectpathsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsLayer::sum(self : GraphconnectpathsLayer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsLayer::mean(self : GraphconnectpathsLayer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsLayer::scale(self : GraphconnectpathsLayer, f : Double) -> GraphconnectpathsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsLayer::add(self : GraphconnectpathsLayer, other : GraphconnectpathsLayer) -> GraphconnectpathsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsLayer::copy(self : GraphconnectpathsLayer) -> GraphconnectpathsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsLayer::fill(self : GraphconnectpathsLayer, v : Double) -> GraphconnectpathsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsLayer::min(self : GraphconnectpathsLayer) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsLayer::max(self : GraphconnectpathsLayer) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsLayer::to_string(self : GraphconnectpathsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_buffer_make(size : Int) -> GraphconnectpathsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsBuffer::len(self : GraphconnectpathsBuffer) -> Int { self.size }

pub fn GraphconnectpathsBuffer::get(self : GraphconnectpathsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsBuffer::set(self : GraphconnectpathsBuffer, i : Int, v : Double) -> GraphconnectpathsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsBuffer::sum(self : GraphconnectpathsBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsBuffer::mean(self : GraphconnectpathsBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsBuffer::scale(self : GraphconnectpathsBuffer, f : Double) -> GraphconnectpathsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsBuffer::add(self : GraphconnectpathsBuffer, other : GraphconnectpathsBuffer) -> GraphconnectpathsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsBuffer::copy(self : GraphconnectpathsBuffer) -> GraphconnectpathsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsBuffer::fill(self : GraphconnectpathsBuffer, v : Double) -> GraphconnectpathsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsBuffer::min(self : GraphconnectpathsBuffer) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsBuffer::max(self : GraphconnectpathsBuffer) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsBuffer::to_string(self : GraphconnectpathsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_cursor_make(size : Int) -> GraphconnectpathsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsCursor::len(self : GraphconnectpathsCursor) -> Int { self.size }

pub fn GraphconnectpathsCursor::get(self : GraphconnectpathsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsCursor::set(self : GraphconnectpathsCursor, i : Int, v : Double) -> GraphconnectpathsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsCursor::sum(self : GraphconnectpathsCursor) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsCursor::mean(self : GraphconnectpathsCursor) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsCursor::scale(self : GraphconnectpathsCursor, f : Double) -> GraphconnectpathsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsCursor::add(self : GraphconnectpathsCursor, other : GraphconnectpathsCursor) -> GraphconnectpathsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsCursor::copy(self : GraphconnectpathsCursor) -> GraphconnectpathsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsCursor::fill(self : GraphconnectpathsCursor, v : Double) -> GraphconnectpathsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsCursor::min(self : GraphconnectpathsCursor) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsCursor::max(self : GraphconnectpathsCursor) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsCursor::to_string(self : GraphconnectpathsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_view_make(size : Int) -> GraphconnectpathsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsView::len(self : GraphconnectpathsView) -> Int { self.size }

pub fn GraphconnectpathsView::get(self : GraphconnectpathsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsView::set(self : GraphconnectpathsView, i : Int, v : Double) -> GraphconnectpathsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsView::sum(self : GraphconnectpathsView) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsView::mean(self : GraphconnectpathsView) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsView::scale(self : GraphconnectpathsView, f : Double) -> GraphconnectpathsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsView::add(self : GraphconnectpathsView, other : GraphconnectpathsView) -> GraphconnectpathsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsView::copy(self : GraphconnectpathsView) -> GraphconnectpathsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsView::fill(self : GraphconnectpathsView, v : Double) -> GraphconnectpathsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsView::min(self : GraphconnectpathsView) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsView::max(self : GraphconnectpathsView) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsView::to_string(self : GraphconnectpathsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_range_make(size : Int) -> GraphconnectpathsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsRange::len(self : GraphconnectpathsRange) -> Int { self.size }

pub fn GraphconnectpathsRange::get(self : GraphconnectpathsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsRange::set(self : GraphconnectpathsRange, i : Int, v : Double) -> GraphconnectpathsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsRange::sum(self : GraphconnectpathsRange) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsRange::mean(self : GraphconnectpathsRange) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsRange::scale(self : GraphconnectpathsRange, f : Double) -> GraphconnectpathsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsRange::add(self : GraphconnectpathsRange, other : GraphconnectpathsRange) -> GraphconnectpathsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsRange::copy(self : GraphconnectpathsRange) -> GraphconnectpathsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsRange::fill(self : GraphconnectpathsRange, v : Double) -> GraphconnectpathsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsRange::min(self : GraphconnectpathsRange) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsRange::max(self : GraphconnectpathsRange) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsRange::to_string(self : GraphconnectpathsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_slice_make(size : Int) -> GraphconnectpathsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectpathsSlice::len(self : GraphconnectpathsSlice) -> Int { self.size }

pub fn GraphconnectpathsSlice::get(self : GraphconnectpathsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectpathsSlice::set(self : GraphconnectpathsSlice, i : Int, v : Double) -> GraphconnectpathsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsSlice::sum(self : GraphconnectpathsSlice) -> Double { @_common.sum(self.data) }

pub fn GraphconnectpathsSlice::mean(self : GraphconnectpathsSlice) -> Double { @_common.mean(self.data) }

pub fn GraphconnectpathsSlice::scale(self : GraphconnectpathsSlice, f : Double) -> GraphconnectpathsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsSlice::add(self : GraphconnectpathsSlice, other : GraphconnectpathsSlice) -> GraphconnectpathsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectpathsSlice::copy(self : GraphconnectpathsSlice) -> GraphconnectpathsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsSlice::fill(self : GraphconnectpathsSlice, v : Double) -> GraphconnectpathsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectpathsSlice::min(self : GraphconnectpathsSlice) -> Double { @_common.min(self.data) }

pub fn GraphconnectpathsSlice::max(self : GraphconnectpathsSlice) -> Double { @_common.max(self.data) }

pub fn GraphconnectpathsSlice::to_string(self : GraphconnectpathsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

