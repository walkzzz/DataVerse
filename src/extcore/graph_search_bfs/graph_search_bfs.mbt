///===
/// extcore/graph_search_bfs

pub(all) struct GraphsearchbfsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_bfs_make_point(x : Double, y : Double) -> GraphsearchbfsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_bfs_make_point3(x : Double, y : Double, z : Double) -> GraphsearchbfsPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchbfsPoint::x(self : GraphsearchbfsPoint) -> Double { self.x }

pub fn GraphsearchbfsPoint::y(self : GraphsearchbfsPoint) -> Double { self.y }

pub fn GraphsearchbfsPoint::z(self : GraphsearchbfsPoint) -> Double { self.z }

pub fn GraphsearchbfsPoint::label(self : GraphsearchbfsPoint) -> Int { self.label }

pub fn GraphsearchbfsPoint::dist(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchbfsPoint::add(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchbfsPoint::sub(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchbfsPoint::scale(self : GraphsearchbfsPoint, s : Double) -> GraphsearchbfsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchbfsPoint::dot(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchbfsPoint::cross(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchbfsPoint::norm(self : GraphsearchbfsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchbfsPoint::normalize(self : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbfsPoint::negate(self : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchbfsPoint::mid(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchbfsPoint::lerp(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint, t : Double) -> GraphsearchbfsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchbfsPoint::to_string(self : GraphsearchbfsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchbfsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_bfs_make_series(vals : Array[Double], name : String) -> GraphsearchbfsSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchbfsSeries::len(self : GraphsearchbfsSeries) -> Int { self.vals.length() }

pub fn GraphsearchbfsSeries::sum(self : GraphsearchbfsSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchbfsSeries::mean(self : GraphsearchbfsSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchbfsSeries::min(self : GraphsearchbfsSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchbfsSeries::max(self : GraphsearchbfsSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchbfsSeries::range(self : GraphsearchbfsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchbfsSeries::variance(self : GraphsearchbfsSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchbfsSeries::std(self : GraphsearchbfsSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchbfsSeries::median(self : GraphsearchbfsSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchbfsSeries::scale(self : GraphsearchbfsSeries, f : Double) -> GraphsearchbfsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchbfsSeries::add(self : GraphsearchbfsSeries, other : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchbfsSeries::sub(self : GraphsearchbfsSeries, other : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchbfsSeries::normalize(self : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchbfsSeries::cumsum(self : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchbfsSeries::to_string(self : GraphsearchbfsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbfsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_bfs_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchbfsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_bfs_matrix_identity(n : Int) -> GraphsearchbfsMatrix {
  let m = graph_search_bfs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchbfsMatrix::get(self : GraphsearchbfsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchbfsMatrix::transpose(self : GraphsearchbfsMatrix) -> GraphsearchbfsMatrix {
  let result = graph_search_bfs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchbfsMatrix::add(self : GraphsearchbfsMatrix, other : GraphsearchbfsMatrix) -> GraphsearchbfsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_bfs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchbfsMatrix::scale(self : GraphsearchbfsMatrix, s : Double) -> GraphsearchbfsMatrix {
  let result = graph_search_bfs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchbfsMatrix::multiply(self : GraphsearchbfsMatrix, other : GraphsearchbfsMatrix) -> GraphsearchbfsMatrix {
  if self.cols != other.rows { return graph_search_bfs_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_bfs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchbfsMatrix::trace(self : GraphsearchbfsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchbfsMatrix::det(self : GraphsearchbfsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchbfsMatrix::norm(self : GraphsearchbfsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchbfsMatrix::to_string(self : GraphsearchbfsMatrix) -> String {
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

pub(all) struct GraphsearchbfsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_bfs_make_vector(comps : Array[Double]) -> GraphsearchbfsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_bfs_vector_zero(dim : Int) -> GraphsearchbfsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchbfsVector::add(self : GraphsearchbfsVector, other : GraphsearchbfsVector) -> GraphsearchbfsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbfsVector::sub(self : GraphsearchbfsVector, other : GraphsearchbfsVector) -> GraphsearchbfsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbfsVector::scale(self : GraphsearchbfsVector, s : Double) -> GraphsearchbfsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchbfsVector::dot(self : GraphsearchbfsVector, other : GraphsearchbfsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchbfsVector::norm(self : GraphsearchbfsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchbfsVector::normalize(self : GraphsearchbfsVector) -> GraphsearchbfsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbfsVector::dist(self : GraphsearchbfsVector, other : GraphsearchbfsVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchbfsVector::to_string(self : GraphsearchbfsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbfsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_frame_make(size : Int) -> GraphsearchbfsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsFrame::len(self : GraphsearchbfsFrame) -> Int { self.size }

pub fn GraphsearchbfsFrame::get(self : GraphsearchbfsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsFrame::set(self : GraphsearchbfsFrame, i : Int, v : Double) -> GraphsearchbfsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsFrame::sum(self : GraphsearchbfsFrame) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsFrame::mean(self : GraphsearchbfsFrame) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsFrame::scale(self : GraphsearchbfsFrame, f : Double) -> GraphsearchbfsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsFrame::add(self : GraphsearchbfsFrame, other : GraphsearchbfsFrame) -> GraphsearchbfsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsFrame::copy(self : GraphsearchbfsFrame) -> GraphsearchbfsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsFrame::fill(self : GraphsearchbfsFrame, v : Double) -> GraphsearchbfsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsFrame::min(self : GraphsearchbfsFrame) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsFrame::max(self : GraphsearchbfsFrame) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsFrame::to_string(self : GraphsearchbfsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_table_make(size : Int) -> GraphsearchbfsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsTable::len(self : GraphsearchbfsTable) -> Int { self.size }

pub fn GraphsearchbfsTable::get(self : GraphsearchbfsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsTable::set(self : GraphsearchbfsTable, i : Int, v : Double) -> GraphsearchbfsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsTable::sum(self : GraphsearchbfsTable) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsTable::mean(self : GraphsearchbfsTable) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsTable::scale(self : GraphsearchbfsTable, f : Double) -> GraphsearchbfsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsTable::add(self : GraphsearchbfsTable, other : GraphsearchbfsTable) -> GraphsearchbfsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsTable::copy(self : GraphsearchbfsTable) -> GraphsearchbfsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsTable::fill(self : GraphsearchbfsTable, v : Double) -> GraphsearchbfsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsTable::min(self : GraphsearchbfsTable) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsTable::max(self : GraphsearchbfsTable) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsTable::to_string(self : GraphsearchbfsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_graphn_make(size : Int) -> GraphsearchbfsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsGraphN::len(self : GraphsearchbfsGraphN) -> Int { self.size }

pub fn GraphsearchbfsGraphN::get(self : GraphsearchbfsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsGraphN::set(self : GraphsearchbfsGraphN, i : Int, v : Double) -> GraphsearchbfsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsGraphN::sum(self : GraphsearchbfsGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsGraphN::mean(self : GraphsearchbfsGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsGraphN::scale(self : GraphsearchbfsGraphN, f : Double) -> GraphsearchbfsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsGraphN::add(self : GraphsearchbfsGraphN, other : GraphsearchbfsGraphN) -> GraphsearchbfsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsGraphN::copy(self : GraphsearchbfsGraphN) -> GraphsearchbfsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsGraphN::fill(self : GraphsearchbfsGraphN, v : Double) -> GraphsearchbfsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsGraphN::min(self : GraphsearchbfsGraphN) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsGraphN::max(self : GraphsearchbfsGraphN) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsGraphN::to_string(self : GraphsearchbfsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_node_make(size : Int) -> GraphsearchbfsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsNode::len(self : GraphsearchbfsNode) -> Int { self.size }

pub fn GraphsearchbfsNode::get(self : GraphsearchbfsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsNode::set(self : GraphsearchbfsNode, i : Int, v : Double) -> GraphsearchbfsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsNode::sum(self : GraphsearchbfsNode) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsNode::mean(self : GraphsearchbfsNode) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsNode::scale(self : GraphsearchbfsNode, f : Double) -> GraphsearchbfsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsNode::add(self : GraphsearchbfsNode, other : GraphsearchbfsNode) -> GraphsearchbfsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsNode::copy(self : GraphsearchbfsNode) -> GraphsearchbfsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsNode::fill(self : GraphsearchbfsNode, v : Double) -> GraphsearchbfsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsNode::min(self : GraphsearchbfsNode) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsNode::max(self : GraphsearchbfsNode) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsNode::to_string(self : GraphsearchbfsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_edge_make(size : Int) -> GraphsearchbfsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsEdge::len(self : GraphsearchbfsEdge) -> Int { self.size }

pub fn GraphsearchbfsEdge::get(self : GraphsearchbfsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsEdge::set(self : GraphsearchbfsEdge, i : Int, v : Double) -> GraphsearchbfsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsEdge::sum(self : GraphsearchbfsEdge) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsEdge::mean(self : GraphsearchbfsEdge) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsEdge::scale(self : GraphsearchbfsEdge, f : Double) -> GraphsearchbfsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsEdge::add(self : GraphsearchbfsEdge, other : GraphsearchbfsEdge) -> GraphsearchbfsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsEdge::copy(self : GraphsearchbfsEdge) -> GraphsearchbfsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsEdge::fill(self : GraphsearchbfsEdge, v : Double) -> GraphsearchbfsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsEdge::min(self : GraphsearchbfsEdge) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsEdge::max(self : GraphsearchbfsEdge) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsEdge::to_string(self : GraphsearchbfsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_path_make(size : Int) -> GraphsearchbfsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsPath::len(self : GraphsearchbfsPath) -> Int { self.size }

pub fn GraphsearchbfsPath::get(self : GraphsearchbfsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsPath::set(self : GraphsearchbfsPath, i : Int, v : Double) -> GraphsearchbfsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsPath::sum(self : GraphsearchbfsPath) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsPath::mean(self : GraphsearchbfsPath) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsPath::scale(self : GraphsearchbfsPath, f : Double) -> GraphsearchbfsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsPath::add(self : GraphsearchbfsPath, other : GraphsearchbfsPath) -> GraphsearchbfsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsPath::copy(self : GraphsearchbfsPath) -> GraphsearchbfsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsPath::fill(self : GraphsearchbfsPath, v : Double) -> GraphsearchbfsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsPath::min(self : GraphsearchbfsPath) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsPath::max(self : GraphsearchbfsPath) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsPath::to_string(self : GraphsearchbfsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_cluster_make(size : Int) -> GraphsearchbfsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsCluster::len(self : GraphsearchbfsCluster) -> Int { self.size }

pub fn GraphsearchbfsCluster::get(self : GraphsearchbfsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsCluster::set(self : GraphsearchbfsCluster, i : Int, v : Double) -> GraphsearchbfsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsCluster::sum(self : GraphsearchbfsCluster) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsCluster::mean(self : GraphsearchbfsCluster) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsCluster::scale(self : GraphsearchbfsCluster, f : Double) -> GraphsearchbfsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsCluster::add(self : GraphsearchbfsCluster, other : GraphsearchbfsCluster) -> GraphsearchbfsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsCluster::copy(self : GraphsearchbfsCluster) -> GraphsearchbfsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsCluster::fill(self : GraphsearchbfsCluster, v : Double) -> GraphsearchbfsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsCluster::min(self : GraphsearchbfsCluster) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsCluster::max(self : GraphsearchbfsCluster) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsCluster::to_string(self : GraphsearchbfsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_model_make(size : Int) -> GraphsearchbfsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsModel::len(self : GraphsearchbfsModel) -> Int { self.size }

pub fn GraphsearchbfsModel::get(self : GraphsearchbfsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsModel::set(self : GraphsearchbfsModel, i : Int, v : Double) -> GraphsearchbfsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsModel::sum(self : GraphsearchbfsModel) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsModel::mean(self : GraphsearchbfsModel) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsModel::scale(self : GraphsearchbfsModel, f : Double) -> GraphsearchbfsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsModel::add(self : GraphsearchbfsModel, other : GraphsearchbfsModel) -> GraphsearchbfsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsModel::copy(self : GraphsearchbfsModel) -> GraphsearchbfsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsModel::fill(self : GraphsearchbfsModel, v : Double) -> GraphsearchbfsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsModel::min(self : GraphsearchbfsModel) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsModel::max(self : GraphsearchbfsModel) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsModel::to_string(self : GraphsearchbfsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_layer_make(size : Int) -> GraphsearchbfsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsLayer::len(self : GraphsearchbfsLayer) -> Int { self.size }

pub fn GraphsearchbfsLayer::get(self : GraphsearchbfsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsLayer::set(self : GraphsearchbfsLayer, i : Int, v : Double) -> GraphsearchbfsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsLayer::sum(self : GraphsearchbfsLayer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsLayer::mean(self : GraphsearchbfsLayer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsLayer::scale(self : GraphsearchbfsLayer, f : Double) -> GraphsearchbfsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsLayer::add(self : GraphsearchbfsLayer, other : GraphsearchbfsLayer) -> GraphsearchbfsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsLayer::copy(self : GraphsearchbfsLayer) -> GraphsearchbfsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsLayer::fill(self : GraphsearchbfsLayer, v : Double) -> GraphsearchbfsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsLayer::min(self : GraphsearchbfsLayer) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsLayer::max(self : GraphsearchbfsLayer) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsLayer::to_string(self : GraphsearchbfsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_buffer_make(size : Int) -> GraphsearchbfsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsBuffer::len(self : GraphsearchbfsBuffer) -> Int { self.size }

pub fn GraphsearchbfsBuffer::get(self : GraphsearchbfsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsBuffer::set(self : GraphsearchbfsBuffer, i : Int, v : Double) -> GraphsearchbfsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsBuffer::sum(self : GraphsearchbfsBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsBuffer::mean(self : GraphsearchbfsBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsBuffer::scale(self : GraphsearchbfsBuffer, f : Double) -> GraphsearchbfsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsBuffer::add(self : GraphsearchbfsBuffer, other : GraphsearchbfsBuffer) -> GraphsearchbfsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsBuffer::copy(self : GraphsearchbfsBuffer) -> GraphsearchbfsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsBuffer::fill(self : GraphsearchbfsBuffer, v : Double) -> GraphsearchbfsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsBuffer::min(self : GraphsearchbfsBuffer) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsBuffer::max(self : GraphsearchbfsBuffer) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsBuffer::to_string(self : GraphsearchbfsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_cursor_make(size : Int) -> GraphsearchbfsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsCursor::len(self : GraphsearchbfsCursor) -> Int { self.size }

pub fn GraphsearchbfsCursor::get(self : GraphsearchbfsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsCursor::set(self : GraphsearchbfsCursor, i : Int, v : Double) -> GraphsearchbfsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsCursor::sum(self : GraphsearchbfsCursor) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsCursor::mean(self : GraphsearchbfsCursor) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsCursor::scale(self : GraphsearchbfsCursor, f : Double) -> GraphsearchbfsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsCursor::add(self : GraphsearchbfsCursor, other : GraphsearchbfsCursor) -> GraphsearchbfsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsCursor::copy(self : GraphsearchbfsCursor) -> GraphsearchbfsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsCursor::fill(self : GraphsearchbfsCursor, v : Double) -> GraphsearchbfsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsCursor::min(self : GraphsearchbfsCursor) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsCursor::max(self : GraphsearchbfsCursor) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsCursor::to_string(self : GraphsearchbfsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_view_make(size : Int) -> GraphsearchbfsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsView::len(self : GraphsearchbfsView) -> Int { self.size }

pub fn GraphsearchbfsView::get(self : GraphsearchbfsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsView::set(self : GraphsearchbfsView, i : Int, v : Double) -> GraphsearchbfsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsView::sum(self : GraphsearchbfsView) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsView::mean(self : GraphsearchbfsView) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsView::scale(self : GraphsearchbfsView, f : Double) -> GraphsearchbfsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsView::add(self : GraphsearchbfsView, other : GraphsearchbfsView) -> GraphsearchbfsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsView::copy(self : GraphsearchbfsView) -> GraphsearchbfsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsView::fill(self : GraphsearchbfsView, v : Double) -> GraphsearchbfsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsView::min(self : GraphsearchbfsView) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsView::max(self : GraphsearchbfsView) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsView::to_string(self : GraphsearchbfsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_range_make(size : Int) -> GraphsearchbfsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsRange::len(self : GraphsearchbfsRange) -> Int { self.size }

pub fn GraphsearchbfsRange::get(self : GraphsearchbfsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsRange::set(self : GraphsearchbfsRange, i : Int, v : Double) -> GraphsearchbfsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsRange::sum(self : GraphsearchbfsRange) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsRange::mean(self : GraphsearchbfsRange) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsRange::scale(self : GraphsearchbfsRange, f : Double) -> GraphsearchbfsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsRange::add(self : GraphsearchbfsRange, other : GraphsearchbfsRange) -> GraphsearchbfsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsRange::copy(self : GraphsearchbfsRange) -> GraphsearchbfsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsRange::fill(self : GraphsearchbfsRange, v : Double) -> GraphsearchbfsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsRange::min(self : GraphsearchbfsRange) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsRange::max(self : GraphsearchbfsRange) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsRange::to_string(self : GraphsearchbfsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_slice_make(size : Int) -> GraphsearchbfsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchbfsSlice::len(self : GraphsearchbfsSlice) -> Int { self.size }

pub fn GraphsearchbfsSlice::get(self : GraphsearchbfsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchbfsSlice::set(self : GraphsearchbfsSlice, i : Int, v : Double) -> GraphsearchbfsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsSlice::sum(self : GraphsearchbfsSlice) -> Double { @_common.sum(self.data) }

pub fn GraphsearchbfsSlice::mean(self : GraphsearchbfsSlice) -> Double { @_common.mean(self.data) }

pub fn GraphsearchbfsSlice::scale(self : GraphsearchbfsSlice, f : Double) -> GraphsearchbfsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsSlice::add(self : GraphsearchbfsSlice, other : GraphsearchbfsSlice) -> GraphsearchbfsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchbfsSlice::copy(self : GraphsearchbfsSlice) -> GraphsearchbfsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsSlice::fill(self : GraphsearchbfsSlice, v : Double) -> GraphsearchbfsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchbfsSlice::min(self : GraphsearchbfsSlice) -> Double { @_common.min(self.data) }

pub fn GraphsearchbfsSlice::max(self : GraphsearchbfsSlice) -> Double { @_common.max(self.data) }

pub fn GraphsearchbfsSlice::to_string(self : GraphsearchbfsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

