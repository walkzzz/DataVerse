///===
/// extcore/graph_connect_weak

pub(all) struct GraphconnectweakPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_weak_make_point(x : Double, y : Double) -> GraphconnectweakPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_weak_make_point3(x : Double, y : Double, z : Double) -> GraphconnectweakPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnectweakPoint::x(self : GraphconnectweakPoint) -> Double { self.x }

pub fn GraphconnectweakPoint::y(self : GraphconnectweakPoint) -> Double { self.y }

pub fn GraphconnectweakPoint::z(self : GraphconnectweakPoint) -> Double { self.z }

pub fn GraphconnectweakPoint::label(self : GraphconnectweakPoint) -> Int { self.label }

pub fn GraphconnectweakPoint::dist(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnectweakPoint::add(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnectweakPoint::sub(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnectweakPoint::scale(self : GraphconnectweakPoint, s : Double) -> GraphconnectweakPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnectweakPoint::dot(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnectweakPoint::cross(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnectweakPoint::norm(self : GraphconnectweakPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnectweakPoint::normalize(self : GraphconnectweakPoint) -> GraphconnectweakPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectweakPoint::negate(self : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnectweakPoint::mid(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnectweakPoint::lerp(self : GraphconnectweakPoint, other : GraphconnectweakPoint, t : Double) -> GraphconnectweakPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnectweakPoint::to_string(self : GraphconnectweakPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnectweakSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_weak_make_series(vals : Array[Double], name : String) -> GraphconnectweakSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnectweakSeries::len(self : GraphconnectweakSeries) -> Int { self.vals.length() }

pub fn GraphconnectweakSeries::sum(self : GraphconnectweakSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnectweakSeries::mean(self : GraphconnectweakSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnectweakSeries::min(self : GraphconnectweakSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnectweakSeries::max(self : GraphconnectweakSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnectweakSeries::range(self : GraphconnectweakSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnectweakSeries::variance(self : GraphconnectweakSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnectweakSeries::std(self : GraphconnectweakSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnectweakSeries::median(self : GraphconnectweakSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnectweakSeries::scale(self : GraphconnectweakSeries, f : Double) -> GraphconnectweakSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnectweakSeries::add(self : GraphconnectweakSeries, other : GraphconnectweakSeries) -> GraphconnectweakSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnectweakSeries::sub(self : GraphconnectweakSeries, other : GraphconnectweakSeries) -> GraphconnectweakSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnectweakSeries::normalize(self : GraphconnectweakSeries) -> GraphconnectweakSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnectweakSeries::cumsum(self : GraphconnectweakSeries) -> GraphconnectweakSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnectweakSeries::to_string(self : GraphconnectweakSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectweakMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_weak_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectweakMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn graph_connect_weak_matrix_identity(n : Int) -> GraphconnectweakMatrix {
  let m = graph_connect_weak_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnectweakMatrix::get(self : GraphconnectweakMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnectweakMatrix::transpose(self : GraphconnectweakMatrix) -> GraphconnectweakMatrix {
  let result = graph_connect_weak_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnectweakMatrix::add(self : GraphconnectweakMatrix, other : GraphconnectweakMatrix) -> GraphconnectweakMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_weak_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnectweakMatrix::scale(self : GraphconnectweakMatrix, s : Double) -> GraphconnectweakMatrix {
  let result = graph_connect_weak_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnectweakMatrix::multiply(self : GraphconnectweakMatrix, other : GraphconnectweakMatrix) -> GraphconnectweakMatrix {
  if self.cols != other.rows { return graph_connect_weak_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_weak_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphconnectweakMatrix::trace(self : GraphconnectweakMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnectweakMatrix::det(self : GraphconnectweakMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnectweakMatrix::norm(self : GraphconnectweakMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnectweakMatrix::to_string(self : GraphconnectweakMatrix) -> String {
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

pub(all) struct GraphconnectweakVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_weak_make_vector(comps : Array[Double]) -> GraphconnectweakVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_weak_vector_zero(dim : Int) -> GraphconnectweakVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnectweakVector::add(self : GraphconnectweakVector, other : GraphconnectweakVector) -> GraphconnectweakVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectweakVector::sub(self : GraphconnectweakVector, other : GraphconnectweakVector) -> GraphconnectweakVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectweakVector::scale(self : GraphconnectweakVector, s : Double) -> GraphconnectweakVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnectweakVector::dot(self : GraphconnectweakVector, other : GraphconnectweakVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnectweakVector::norm(self : GraphconnectweakVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnectweakVector::normalize(self : GraphconnectweakVector) -> GraphconnectweakVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectweakVector::dist(self : GraphconnectweakVector, other : GraphconnectweakVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnectweakVector::to_string(self : GraphconnectweakVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectweakFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_frame_make(size : Int) -> GraphconnectweakFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakFrame::len(self : GraphconnectweakFrame) -> Int { self.size }

pub fn GraphconnectweakFrame::get(self : GraphconnectweakFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakFrame::set(self : GraphconnectweakFrame, i : Int, v : Double) -> GraphconnectweakFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakFrame::sum(self : GraphconnectweakFrame) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakFrame::mean(self : GraphconnectweakFrame) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakFrame::scale(self : GraphconnectweakFrame, f : Double) -> GraphconnectweakFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakFrame::add(self : GraphconnectweakFrame, other : GraphconnectweakFrame) -> GraphconnectweakFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakFrame::copy(self : GraphconnectweakFrame) -> GraphconnectweakFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakFrame::fill(self : GraphconnectweakFrame, v : Double) -> GraphconnectweakFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakFrame::min(self : GraphconnectweakFrame) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakFrame::max(self : GraphconnectweakFrame) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakFrame::to_string(self : GraphconnectweakFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_table_make(size : Int) -> GraphconnectweakTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakTable::len(self : GraphconnectweakTable) -> Int { self.size }

pub fn GraphconnectweakTable::get(self : GraphconnectweakTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakTable::set(self : GraphconnectweakTable, i : Int, v : Double) -> GraphconnectweakTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakTable::sum(self : GraphconnectweakTable) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakTable::mean(self : GraphconnectweakTable) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakTable::scale(self : GraphconnectweakTable, f : Double) -> GraphconnectweakTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakTable::add(self : GraphconnectweakTable, other : GraphconnectweakTable) -> GraphconnectweakTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakTable::copy(self : GraphconnectweakTable) -> GraphconnectweakTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakTable::fill(self : GraphconnectweakTable, v : Double) -> GraphconnectweakTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakTable::min(self : GraphconnectweakTable) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakTable::max(self : GraphconnectweakTable) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakTable::to_string(self : GraphconnectweakTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_graphn_make(size : Int) -> GraphconnectweakGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakGraphN::len(self : GraphconnectweakGraphN) -> Int { self.size }

pub fn GraphconnectweakGraphN::get(self : GraphconnectweakGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakGraphN::set(self : GraphconnectweakGraphN, i : Int, v : Double) -> GraphconnectweakGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakGraphN::sum(self : GraphconnectweakGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakGraphN::mean(self : GraphconnectweakGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakGraphN::scale(self : GraphconnectweakGraphN, f : Double) -> GraphconnectweakGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakGraphN::add(self : GraphconnectweakGraphN, other : GraphconnectweakGraphN) -> GraphconnectweakGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakGraphN::copy(self : GraphconnectweakGraphN) -> GraphconnectweakGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakGraphN::fill(self : GraphconnectweakGraphN, v : Double) -> GraphconnectweakGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakGraphN::min(self : GraphconnectweakGraphN) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakGraphN::max(self : GraphconnectweakGraphN) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakGraphN::to_string(self : GraphconnectweakGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_node_make(size : Int) -> GraphconnectweakNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakNode::len(self : GraphconnectweakNode) -> Int { self.size }

pub fn GraphconnectweakNode::get(self : GraphconnectweakNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakNode::set(self : GraphconnectweakNode, i : Int, v : Double) -> GraphconnectweakNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakNode::sum(self : GraphconnectweakNode) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakNode::mean(self : GraphconnectweakNode) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakNode::scale(self : GraphconnectweakNode, f : Double) -> GraphconnectweakNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakNode::add(self : GraphconnectweakNode, other : GraphconnectweakNode) -> GraphconnectweakNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakNode::copy(self : GraphconnectweakNode) -> GraphconnectweakNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakNode::fill(self : GraphconnectweakNode, v : Double) -> GraphconnectweakNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakNode::min(self : GraphconnectweakNode) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakNode::max(self : GraphconnectweakNode) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakNode::to_string(self : GraphconnectweakNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_edge_make(size : Int) -> GraphconnectweakEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakEdge::len(self : GraphconnectweakEdge) -> Int { self.size }

pub fn GraphconnectweakEdge::get(self : GraphconnectweakEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakEdge::set(self : GraphconnectweakEdge, i : Int, v : Double) -> GraphconnectweakEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakEdge::sum(self : GraphconnectweakEdge) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakEdge::mean(self : GraphconnectweakEdge) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakEdge::scale(self : GraphconnectweakEdge, f : Double) -> GraphconnectweakEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakEdge::add(self : GraphconnectweakEdge, other : GraphconnectweakEdge) -> GraphconnectweakEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakEdge::copy(self : GraphconnectweakEdge) -> GraphconnectweakEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakEdge::fill(self : GraphconnectweakEdge, v : Double) -> GraphconnectweakEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakEdge::min(self : GraphconnectweakEdge) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakEdge::max(self : GraphconnectweakEdge) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakEdge::to_string(self : GraphconnectweakEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_path_make(size : Int) -> GraphconnectweakPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakPath::len(self : GraphconnectweakPath) -> Int { self.size }

pub fn GraphconnectweakPath::get(self : GraphconnectweakPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakPath::set(self : GraphconnectweakPath, i : Int, v : Double) -> GraphconnectweakPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakPath::sum(self : GraphconnectweakPath) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakPath::mean(self : GraphconnectweakPath) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakPath::scale(self : GraphconnectweakPath, f : Double) -> GraphconnectweakPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakPath::add(self : GraphconnectweakPath, other : GraphconnectweakPath) -> GraphconnectweakPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakPath::copy(self : GraphconnectweakPath) -> GraphconnectweakPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakPath::fill(self : GraphconnectweakPath, v : Double) -> GraphconnectweakPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakPath::min(self : GraphconnectweakPath) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakPath::max(self : GraphconnectweakPath) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakPath::to_string(self : GraphconnectweakPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_cluster_make(size : Int) -> GraphconnectweakCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakCluster::len(self : GraphconnectweakCluster) -> Int { self.size }

pub fn GraphconnectweakCluster::get(self : GraphconnectweakCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakCluster::set(self : GraphconnectweakCluster, i : Int, v : Double) -> GraphconnectweakCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakCluster::sum(self : GraphconnectweakCluster) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakCluster::mean(self : GraphconnectweakCluster) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakCluster::scale(self : GraphconnectweakCluster, f : Double) -> GraphconnectweakCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakCluster::add(self : GraphconnectweakCluster, other : GraphconnectweakCluster) -> GraphconnectweakCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakCluster::copy(self : GraphconnectweakCluster) -> GraphconnectweakCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakCluster::fill(self : GraphconnectweakCluster, v : Double) -> GraphconnectweakCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakCluster::min(self : GraphconnectweakCluster) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakCluster::max(self : GraphconnectweakCluster) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakCluster::to_string(self : GraphconnectweakCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_model_make(size : Int) -> GraphconnectweakModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakModel::len(self : GraphconnectweakModel) -> Int { self.size }

pub fn GraphconnectweakModel::get(self : GraphconnectweakModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakModel::set(self : GraphconnectweakModel, i : Int, v : Double) -> GraphconnectweakModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakModel::sum(self : GraphconnectweakModel) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakModel::mean(self : GraphconnectweakModel) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakModel::scale(self : GraphconnectweakModel, f : Double) -> GraphconnectweakModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakModel::add(self : GraphconnectweakModel, other : GraphconnectweakModel) -> GraphconnectweakModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakModel::copy(self : GraphconnectweakModel) -> GraphconnectweakModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakModel::fill(self : GraphconnectweakModel, v : Double) -> GraphconnectweakModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakModel::min(self : GraphconnectweakModel) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakModel::max(self : GraphconnectweakModel) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakModel::to_string(self : GraphconnectweakModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_layer_make(size : Int) -> GraphconnectweakLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakLayer::len(self : GraphconnectweakLayer) -> Int { self.size }

pub fn GraphconnectweakLayer::get(self : GraphconnectweakLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakLayer::set(self : GraphconnectweakLayer, i : Int, v : Double) -> GraphconnectweakLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakLayer::sum(self : GraphconnectweakLayer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakLayer::mean(self : GraphconnectweakLayer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakLayer::scale(self : GraphconnectweakLayer, f : Double) -> GraphconnectweakLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakLayer::add(self : GraphconnectweakLayer, other : GraphconnectweakLayer) -> GraphconnectweakLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakLayer::copy(self : GraphconnectweakLayer) -> GraphconnectweakLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakLayer::fill(self : GraphconnectweakLayer, v : Double) -> GraphconnectweakLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakLayer::min(self : GraphconnectweakLayer) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakLayer::max(self : GraphconnectweakLayer) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakLayer::to_string(self : GraphconnectweakLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_buffer_make(size : Int) -> GraphconnectweakBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakBuffer::len(self : GraphconnectweakBuffer) -> Int { self.size }

pub fn GraphconnectweakBuffer::get(self : GraphconnectweakBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakBuffer::set(self : GraphconnectweakBuffer, i : Int, v : Double) -> GraphconnectweakBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakBuffer::sum(self : GraphconnectweakBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakBuffer::mean(self : GraphconnectweakBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakBuffer::scale(self : GraphconnectweakBuffer, f : Double) -> GraphconnectweakBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakBuffer::add(self : GraphconnectweakBuffer, other : GraphconnectweakBuffer) -> GraphconnectweakBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakBuffer::copy(self : GraphconnectweakBuffer) -> GraphconnectweakBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakBuffer::fill(self : GraphconnectweakBuffer, v : Double) -> GraphconnectweakBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakBuffer::min(self : GraphconnectweakBuffer) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakBuffer::max(self : GraphconnectweakBuffer) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakBuffer::to_string(self : GraphconnectweakBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_cursor_make(size : Int) -> GraphconnectweakCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakCursor::len(self : GraphconnectweakCursor) -> Int { self.size }

pub fn GraphconnectweakCursor::get(self : GraphconnectweakCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakCursor::set(self : GraphconnectweakCursor, i : Int, v : Double) -> GraphconnectweakCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakCursor::sum(self : GraphconnectweakCursor) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakCursor::mean(self : GraphconnectweakCursor) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakCursor::scale(self : GraphconnectweakCursor, f : Double) -> GraphconnectweakCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakCursor::add(self : GraphconnectweakCursor, other : GraphconnectweakCursor) -> GraphconnectweakCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakCursor::copy(self : GraphconnectweakCursor) -> GraphconnectweakCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakCursor::fill(self : GraphconnectweakCursor, v : Double) -> GraphconnectweakCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakCursor::min(self : GraphconnectweakCursor) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakCursor::max(self : GraphconnectweakCursor) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakCursor::to_string(self : GraphconnectweakCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_view_make(size : Int) -> GraphconnectweakView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakView::len(self : GraphconnectweakView) -> Int { self.size }

pub fn GraphconnectweakView::get(self : GraphconnectweakView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakView::set(self : GraphconnectweakView, i : Int, v : Double) -> GraphconnectweakView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakView::sum(self : GraphconnectweakView) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakView::mean(self : GraphconnectweakView) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakView::scale(self : GraphconnectweakView, f : Double) -> GraphconnectweakView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakView::add(self : GraphconnectweakView, other : GraphconnectweakView) -> GraphconnectweakView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakView::copy(self : GraphconnectweakView) -> GraphconnectweakView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakView::fill(self : GraphconnectweakView, v : Double) -> GraphconnectweakView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakView::min(self : GraphconnectweakView) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakView::max(self : GraphconnectweakView) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakView::to_string(self : GraphconnectweakView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_range_make(size : Int) -> GraphconnectweakRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakRange::len(self : GraphconnectweakRange) -> Int { self.size }

pub fn GraphconnectweakRange::get(self : GraphconnectweakRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakRange::set(self : GraphconnectweakRange, i : Int, v : Double) -> GraphconnectweakRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakRange::sum(self : GraphconnectweakRange) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakRange::mean(self : GraphconnectweakRange) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakRange::scale(self : GraphconnectweakRange, f : Double) -> GraphconnectweakRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakRange::add(self : GraphconnectweakRange, other : GraphconnectweakRange) -> GraphconnectweakRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakRange::copy(self : GraphconnectweakRange) -> GraphconnectweakRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakRange::fill(self : GraphconnectweakRange, v : Double) -> GraphconnectweakRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakRange::min(self : GraphconnectweakRange) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakRange::max(self : GraphconnectweakRange) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakRange::to_string(self : GraphconnectweakRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_slice_make(size : Int) -> GraphconnectweakSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectweakSlice::len(self : GraphconnectweakSlice) -> Int { self.size }

pub fn GraphconnectweakSlice::get(self : GraphconnectweakSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectweakSlice::set(self : GraphconnectweakSlice, i : Int, v : Double) -> GraphconnectweakSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectweakSlice::sum(self : GraphconnectweakSlice) -> Double { @_common.sum(self.data) }

pub fn GraphconnectweakSlice::mean(self : GraphconnectweakSlice) -> Double { @_common.mean(self.data) }

pub fn GraphconnectweakSlice::scale(self : GraphconnectweakSlice, f : Double) -> GraphconnectweakSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakSlice::add(self : GraphconnectweakSlice, other : GraphconnectweakSlice) -> GraphconnectweakSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectweakSlice::copy(self : GraphconnectweakSlice) -> GraphconnectweakSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakSlice::fill(self : GraphconnectweakSlice, v : Double) -> GraphconnectweakSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectweakSlice::min(self : GraphconnectweakSlice) -> Double { @_common.min(self.data) }

pub fn GraphconnectweakSlice::max(self : GraphconnectweakSlice) -> Double { @_common.max(self.data) }

pub fn GraphconnectweakSlice::to_string(self : GraphconnectweakSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

