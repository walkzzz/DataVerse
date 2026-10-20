///===
/// extcore/graph_connect_strong

pub(all) struct GraphconnectstrongPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_strong_make_point(x : Double, y : Double) -> GraphconnectstrongPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_strong_make_point3(x : Double, y : Double, z : Double) -> GraphconnectstrongPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnectstrongPoint::x(self : GraphconnectstrongPoint) -> Double { self.x }

pub fn GraphconnectstrongPoint::y(self : GraphconnectstrongPoint) -> Double { self.y }

pub fn GraphconnectstrongPoint::z(self : GraphconnectstrongPoint) -> Double { self.z }

pub fn GraphconnectstrongPoint::label(self : GraphconnectstrongPoint) -> Int { self.label }

pub fn GraphconnectstrongPoint::dist(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnectstrongPoint::add(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnectstrongPoint::sub(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnectstrongPoint::scale(self : GraphconnectstrongPoint, s : Double) -> GraphconnectstrongPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnectstrongPoint::dot(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnectstrongPoint::cross(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnectstrongPoint::norm(self : GraphconnectstrongPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnectstrongPoint::normalize(self : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectstrongPoint::negate(self : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnectstrongPoint::mid(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnectstrongPoint::lerp(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint, t : Double) -> GraphconnectstrongPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnectstrongPoint::to_string(self : GraphconnectstrongPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnectstrongSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_strong_make_series(vals : Array[Double], name : String) -> GraphconnectstrongSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnectstrongSeries::len(self : GraphconnectstrongSeries) -> Int { self.vals.length() }

pub fn GraphconnectstrongSeries::sum(self : GraphconnectstrongSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnectstrongSeries::mean(self : GraphconnectstrongSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnectstrongSeries::min(self : GraphconnectstrongSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnectstrongSeries::max(self : GraphconnectstrongSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnectstrongSeries::range(self : GraphconnectstrongSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnectstrongSeries::variance(self : GraphconnectstrongSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnectstrongSeries::std(self : GraphconnectstrongSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnectstrongSeries::median(self : GraphconnectstrongSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnectstrongSeries::scale(self : GraphconnectstrongSeries, f : Double) -> GraphconnectstrongSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnectstrongSeries::add(self : GraphconnectstrongSeries, other : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnectstrongSeries::sub(self : GraphconnectstrongSeries, other : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnectstrongSeries::normalize(self : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnectstrongSeries::cumsum(self : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnectstrongSeries::to_string(self : GraphconnectstrongSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectstrongMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_strong_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectstrongMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn graph_connect_strong_matrix_identity(n : Int) -> GraphconnectstrongMatrix {
  let m = graph_connect_strong_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnectstrongMatrix::get(self : GraphconnectstrongMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnectstrongMatrix::transpose(self : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  let result = graph_connect_strong_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnectstrongMatrix::add(self : GraphconnectstrongMatrix, other : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_strong_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnectstrongMatrix::scale(self : GraphconnectstrongMatrix, s : Double) -> GraphconnectstrongMatrix {
  let result = graph_connect_strong_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnectstrongMatrix::multiply(self : GraphconnectstrongMatrix, other : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  if self.cols != other.rows { return graph_connect_strong_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_strong_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphconnectstrongMatrix::trace(self : GraphconnectstrongMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnectstrongMatrix::det(self : GraphconnectstrongMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnectstrongMatrix::norm(self : GraphconnectstrongMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnectstrongMatrix::to_string(self : GraphconnectstrongMatrix) -> String {
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

pub(all) struct GraphconnectstrongVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_strong_make_vector(comps : Array[Double]) -> GraphconnectstrongVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_strong_vector_zero(dim : Int) -> GraphconnectstrongVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnectstrongVector::add(self : GraphconnectstrongVector, other : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectstrongVector::sub(self : GraphconnectstrongVector, other : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectstrongVector::scale(self : GraphconnectstrongVector, s : Double) -> GraphconnectstrongVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnectstrongVector::dot(self : GraphconnectstrongVector, other : GraphconnectstrongVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnectstrongVector::norm(self : GraphconnectstrongVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnectstrongVector::normalize(self : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectstrongVector::dist(self : GraphconnectstrongVector, other : GraphconnectstrongVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnectstrongVector::to_string(self : GraphconnectstrongVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectstrongFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_frame_make(size : Int) -> GraphconnectstrongFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongFrame::len(self : GraphconnectstrongFrame) -> Int { self.size }

pub fn GraphconnectstrongFrame::get(self : GraphconnectstrongFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongFrame::set(self : GraphconnectstrongFrame, i : Int, v : Double) -> GraphconnectstrongFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongFrame::sum(self : GraphconnectstrongFrame) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongFrame::mean(self : GraphconnectstrongFrame) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongFrame::scale(self : GraphconnectstrongFrame, f : Double) -> GraphconnectstrongFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongFrame::add(self : GraphconnectstrongFrame, other : GraphconnectstrongFrame) -> GraphconnectstrongFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongFrame::copy(self : GraphconnectstrongFrame) -> GraphconnectstrongFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongFrame::fill(self : GraphconnectstrongFrame, v : Double) -> GraphconnectstrongFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongFrame::min(self : GraphconnectstrongFrame) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongFrame::max(self : GraphconnectstrongFrame) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongFrame::to_string(self : GraphconnectstrongFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_table_make(size : Int) -> GraphconnectstrongTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongTable::len(self : GraphconnectstrongTable) -> Int { self.size }

pub fn GraphconnectstrongTable::get(self : GraphconnectstrongTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongTable::set(self : GraphconnectstrongTable, i : Int, v : Double) -> GraphconnectstrongTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongTable::sum(self : GraphconnectstrongTable) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongTable::mean(self : GraphconnectstrongTable) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongTable::scale(self : GraphconnectstrongTable, f : Double) -> GraphconnectstrongTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongTable::add(self : GraphconnectstrongTable, other : GraphconnectstrongTable) -> GraphconnectstrongTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongTable::copy(self : GraphconnectstrongTable) -> GraphconnectstrongTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongTable::fill(self : GraphconnectstrongTable, v : Double) -> GraphconnectstrongTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongTable::min(self : GraphconnectstrongTable) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongTable::max(self : GraphconnectstrongTable) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongTable::to_string(self : GraphconnectstrongTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_graphn_make(size : Int) -> GraphconnectstrongGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongGraphN::len(self : GraphconnectstrongGraphN) -> Int { self.size }

pub fn GraphconnectstrongGraphN::get(self : GraphconnectstrongGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongGraphN::set(self : GraphconnectstrongGraphN, i : Int, v : Double) -> GraphconnectstrongGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongGraphN::sum(self : GraphconnectstrongGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongGraphN::mean(self : GraphconnectstrongGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongGraphN::scale(self : GraphconnectstrongGraphN, f : Double) -> GraphconnectstrongGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongGraphN::add(self : GraphconnectstrongGraphN, other : GraphconnectstrongGraphN) -> GraphconnectstrongGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongGraphN::copy(self : GraphconnectstrongGraphN) -> GraphconnectstrongGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongGraphN::fill(self : GraphconnectstrongGraphN, v : Double) -> GraphconnectstrongGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongGraphN::min(self : GraphconnectstrongGraphN) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongGraphN::max(self : GraphconnectstrongGraphN) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongGraphN::to_string(self : GraphconnectstrongGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_node_make(size : Int) -> GraphconnectstrongNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongNode::len(self : GraphconnectstrongNode) -> Int { self.size }

pub fn GraphconnectstrongNode::get(self : GraphconnectstrongNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongNode::set(self : GraphconnectstrongNode, i : Int, v : Double) -> GraphconnectstrongNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongNode::sum(self : GraphconnectstrongNode) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongNode::mean(self : GraphconnectstrongNode) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongNode::scale(self : GraphconnectstrongNode, f : Double) -> GraphconnectstrongNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongNode::add(self : GraphconnectstrongNode, other : GraphconnectstrongNode) -> GraphconnectstrongNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongNode::copy(self : GraphconnectstrongNode) -> GraphconnectstrongNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongNode::fill(self : GraphconnectstrongNode, v : Double) -> GraphconnectstrongNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongNode::min(self : GraphconnectstrongNode) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongNode::max(self : GraphconnectstrongNode) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongNode::to_string(self : GraphconnectstrongNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_edge_make(size : Int) -> GraphconnectstrongEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongEdge::len(self : GraphconnectstrongEdge) -> Int { self.size }

pub fn GraphconnectstrongEdge::get(self : GraphconnectstrongEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongEdge::set(self : GraphconnectstrongEdge, i : Int, v : Double) -> GraphconnectstrongEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongEdge::sum(self : GraphconnectstrongEdge) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongEdge::mean(self : GraphconnectstrongEdge) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongEdge::scale(self : GraphconnectstrongEdge, f : Double) -> GraphconnectstrongEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongEdge::add(self : GraphconnectstrongEdge, other : GraphconnectstrongEdge) -> GraphconnectstrongEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongEdge::copy(self : GraphconnectstrongEdge) -> GraphconnectstrongEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongEdge::fill(self : GraphconnectstrongEdge, v : Double) -> GraphconnectstrongEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongEdge::min(self : GraphconnectstrongEdge) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongEdge::max(self : GraphconnectstrongEdge) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongEdge::to_string(self : GraphconnectstrongEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_path_make(size : Int) -> GraphconnectstrongPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongPath::len(self : GraphconnectstrongPath) -> Int { self.size }

pub fn GraphconnectstrongPath::get(self : GraphconnectstrongPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongPath::set(self : GraphconnectstrongPath, i : Int, v : Double) -> GraphconnectstrongPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongPath::sum(self : GraphconnectstrongPath) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongPath::mean(self : GraphconnectstrongPath) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongPath::scale(self : GraphconnectstrongPath, f : Double) -> GraphconnectstrongPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongPath::add(self : GraphconnectstrongPath, other : GraphconnectstrongPath) -> GraphconnectstrongPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongPath::copy(self : GraphconnectstrongPath) -> GraphconnectstrongPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongPath::fill(self : GraphconnectstrongPath, v : Double) -> GraphconnectstrongPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongPath::min(self : GraphconnectstrongPath) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongPath::max(self : GraphconnectstrongPath) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongPath::to_string(self : GraphconnectstrongPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_cluster_make(size : Int) -> GraphconnectstrongCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongCluster::len(self : GraphconnectstrongCluster) -> Int { self.size }

pub fn GraphconnectstrongCluster::get(self : GraphconnectstrongCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongCluster::set(self : GraphconnectstrongCluster, i : Int, v : Double) -> GraphconnectstrongCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongCluster::sum(self : GraphconnectstrongCluster) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongCluster::mean(self : GraphconnectstrongCluster) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongCluster::scale(self : GraphconnectstrongCluster, f : Double) -> GraphconnectstrongCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongCluster::add(self : GraphconnectstrongCluster, other : GraphconnectstrongCluster) -> GraphconnectstrongCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongCluster::copy(self : GraphconnectstrongCluster) -> GraphconnectstrongCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongCluster::fill(self : GraphconnectstrongCluster, v : Double) -> GraphconnectstrongCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongCluster::min(self : GraphconnectstrongCluster) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongCluster::max(self : GraphconnectstrongCluster) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongCluster::to_string(self : GraphconnectstrongCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_model_make(size : Int) -> GraphconnectstrongModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongModel::len(self : GraphconnectstrongModel) -> Int { self.size }

pub fn GraphconnectstrongModel::get(self : GraphconnectstrongModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongModel::set(self : GraphconnectstrongModel, i : Int, v : Double) -> GraphconnectstrongModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongModel::sum(self : GraphconnectstrongModel) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongModel::mean(self : GraphconnectstrongModel) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongModel::scale(self : GraphconnectstrongModel, f : Double) -> GraphconnectstrongModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongModel::add(self : GraphconnectstrongModel, other : GraphconnectstrongModel) -> GraphconnectstrongModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongModel::copy(self : GraphconnectstrongModel) -> GraphconnectstrongModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongModel::fill(self : GraphconnectstrongModel, v : Double) -> GraphconnectstrongModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongModel::min(self : GraphconnectstrongModel) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongModel::max(self : GraphconnectstrongModel) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongModel::to_string(self : GraphconnectstrongModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_layer_make(size : Int) -> GraphconnectstrongLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongLayer::len(self : GraphconnectstrongLayer) -> Int { self.size }

pub fn GraphconnectstrongLayer::get(self : GraphconnectstrongLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongLayer::set(self : GraphconnectstrongLayer, i : Int, v : Double) -> GraphconnectstrongLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongLayer::sum(self : GraphconnectstrongLayer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongLayer::mean(self : GraphconnectstrongLayer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongLayer::scale(self : GraphconnectstrongLayer, f : Double) -> GraphconnectstrongLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongLayer::add(self : GraphconnectstrongLayer, other : GraphconnectstrongLayer) -> GraphconnectstrongLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongLayer::copy(self : GraphconnectstrongLayer) -> GraphconnectstrongLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongLayer::fill(self : GraphconnectstrongLayer, v : Double) -> GraphconnectstrongLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongLayer::min(self : GraphconnectstrongLayer) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongLayer::max(self : GraphconnectstrongLayer) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongLayer::to_string(self : GraphconnectstrongLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_buffer_make(size : Int) -> GraphconnectstrongBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongBuffer::len(self : GraphconnectstrongBuffer) -> Int { self.size }

pub fn GraphconnectstrongBuffer::get(self : GraphconnectstrongBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongBuffer::set(self : GraphconnectstrongBuffer, i : Int, v : Double) -> GraphconnectstrongBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongBuffer::sum(self : GraphconnectstrongBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongBuffer::mean(self : GraphconnectstrongBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongBuffer::scale(self : GraphconnectstrongBuffer, f : Double) -> GraphconnectstrongBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongBuffer::add(self : GraphconnectstrongBuffer, other : GraphconnectstrongBuffer) -> GraphconnectstrongBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongBuffer::copy(self : GraphconnectstrongBuffer) -> GraphconnectstrongBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongBuffer::fill(self : GraphconnectstrongBuffer, v : Double) -> GraphconnectstrongBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongBuffer::min(self : GraphconnectstrongBuffer) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongBuffer::max(self : GraphconnectstrongBuffer) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongBuffer::to_string(self : GraphconnectstrongBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_cursor_make(size : Int) -> GraphconnectstrongCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongCursor::len(self : GraphconnectstrongCursor) -> Int { self.size }

pub fn GraphconnectstrongCursor::get(self : GraphconnectstrongCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongCursor::set(self : GraphconnectstrongCursor, i : Int, v : Double) -> GraphconnectstrongCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongCursor::sum(self : GraphconnectstrongCursor) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongCursor::mean(self : GraphconnectstrongCursor) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongCursor::scale(self : GraphconnectstrongCursor, f : Double) -> GraphconnectstrongCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongCursor::add(self : GraphconnectstrongCursor, other : GraphconnectstrongCursor) -> GraphconnectstrongCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongCursor::copy(self : GraphconnectstrongCursor) -> GraphconnectstrongCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongCursor::fill(self : GraphconnectstrongCursor, v : Double) -> GraphconnectstrongCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongCursor::min(self : GraphconnectstrongCursor) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongCursor::max(self : GraphconnectstrongCursor) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongCursor::to_string(self : GraphconnectstrongCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_view_make(size : Int) -> GraphconnectstrongView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongView::len(self : GraphconnectstrongView) -> Int { self.size }

pub fn GraphconnectstrongView::get(self : GraphconnectstrongView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongView::set(self : GraphconnectstrongView, i : Int, v : Double) -> GraphconnectstrongView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongView::sum(self : GraphconnectstrongView) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongView::mean(self : GraphconnectstrongView) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongView::scale(self : GraphconnectstrongView, f : Double) -> GraphconnectstrongView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongView::add(self : GraphconnectstrongView, other : GraphconnectstrongView) -> GraphconnectstrongView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongView::copy(self : GraphconnectstrongView) -> GraphconnectstrongView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongView::fill(self : GraphconnectstrongView, v : Double) -> GraphconnectstrongView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongView::min(self : GraphconnectstrongView) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongView::max(self : GraphconnectstrongView) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongView::to_string(self : GraphconnectstrongView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_range_make(size : Int) -> GraphconnectstrongRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongRange::len(self : GraphconnectstrongRange) -> Int { self.size }

pub fn GraphconnectstrongRange::get(self : GraphconnectstrongRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongRange::set(self : GraphconnectstrongRange, i : Int, v : Double) -> GraphconnectstrongRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongRange::sum(self : GraphconnectstrongRange) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongRange::mean(self : GraphconnectstrongRange) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongRange::scale(self : GraphconnectstrongRange, f : Double) -> GraphconnectstrongRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongRange::add(self : GraphconnectstrongRange, other : GraphconnectstrongRange) -> GraphconnectstrongRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongRange::copy(self : GraphconnectstrongRange) -> GraphconnectstrongRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongRange::fill(self : GraphconnectstrongRange, v : Double) -> GraphconnectstrongRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongRange::min(self : GraphconnectstrongRange) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongRange::max(self : GraphconnectstrongRange) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongRange::to_string(self : GraphconnectstrongRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_slice_make(size : Int) -> GraphconnectstrongSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphconnectstrongSlice::len(self : GraphconnectstrongSlice) -> Int { self.size }

pub fn GraphconnectstrongSlice::get(self : GraphconnectstrongSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphconnectstrongSlice::set(self : GraphconnectstrongSlice, i : Int, v : Double) -> GraphconnectstrongSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongSlice::sum(self : GraphconnectstrongSlice) -> Double { @_common.sum(self.data) }

pub fn GraphconnectstrongSlice::mean(self : GraphconnectstrongSlice) -> Double { @_common.mean(self.data) }

pub fn GraphconnectstrongSlice::scale(self : GraphconnectstrongSlice, f : Double) -> GraphconnectstrongSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongSlice::add(self : GraphconnectstrongSlice, other : GraphconnectstrongSlice) -> GraphconnectstrongSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphconnectstrongSlice::copy(self : GraphconnectstrongSlice) -> GraphconnectstrongSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongSlice::fill(self : GraphconnectstrongSlice, v : Double) -> GraphconnectstrongSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphconnectstrongSlice::min(self : GraphconnectstrongSlice) -> Double { @_common.min(self.data) }

pub fn GraphconnectstrongSlice::max(self : GraphconnectstrongSlice) -> Double { @_common.max(self.data) }

pub fn GraphconnectstrongSlice::to_string(self : GraphconnectstrongSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

