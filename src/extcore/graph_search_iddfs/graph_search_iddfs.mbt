///===
/// extcore/graph_search_iddfs

pub(all) struct GraphsearchiddfsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_iddfs_make_point(x : Double, y : Double) -> GraphsearchiddfsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_iddfs_make_point3(x : Double, y : Double, z : Double) -> GraphsearchiddfsPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchiddfsPoint::x(self : GraphsearchiddfsPoint) -> Double { self.x }

pub fn GraphsearchiddfsPoint::y(self : GraphsearchiddfsPoint) -> Double { self.y }

pub fn GraphsearchiddfsPoint::z(self : GraphsearchiddfsPoint) -> Double { self.z }

pub fn GraphsearchiddfsPoint::label(self : GraphsearchiddfsPoint) -> Int { self.label }

pub fn GraphsearchiddfsPoint::dist(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchiddfsPoint::add(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchiddfsPoint::sub(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchiddfsPoint::scale(self : GraphsearchiddfsPoint, s : Double) -> GraphsearchiddfsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchiddfsPoint::dot(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchiddfsPoint::cross(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchiddfsPoint::norm(self : GraphsearchiddfsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchiddfsPoint::normalize(self : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchiddfsPoint::negate(self : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchiddfsPoint::mid(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchiddfsPoint::lerp(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint, t : Double) -> GraphsearchiddfsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchiddfsPoint::to_string(self : GraphsearchiddfsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchiddfsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_iddfs_make_series(vals : Array[Double], name : String) -> GraphsearchiddfsSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchiddfsSeries::len(self : GraphsearchiddfsSeries) -> Int { self.vals.length() }

pub fn GraphsearchiddfsSeries::sum(self : GraphsearchiddfsSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchiddfsSeries::mean(self : GraphsearchiddfsSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchiddfsSeries::min(self : GraphsearchiddfsSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchiddfsSeries::max(self : GraphsearchiddfsSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchiddfsSeries::range(self : GraphsearchiddfsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchiddfsSeries::variance(self : GraphsearchiddfsSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchiddfsSeries::std(self : GraphsearchiddfsSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchiddfsSeries::median(self : GraphsearchiddfsSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchiddfsSeries::scale(self : GraphsearchiddfsSeries, f : Double) -> GraphsearchiddfsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchiddfsSeries::add(self : GraphsearchiddfsSeries, other : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchiddfsSeries::sub(self : GraphsearchiddfsSeries, other : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchiddfsSeries::normalize(self : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchiddfsSeries::cumsum(self : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchiddfsSeries::to_string(self : GraphsearchiddfsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchiddfsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_iddfs_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchiddfsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_iddfs_matrix_identity(n : Int) -> GraphsearchiddfsMatrix {
  let m = graph_search_iddfs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchiddfsMatrix::get(self : GraphsearchiddfsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchiddfsMatrix::transpose(self : GraphsearchiddfsMatrix) -> GraphsearchiddfsMatrix {
  let result = graph_search_iddfs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchiddfsMatrix::add(self : GraphsearchiddfsMatrix, other : GraphsearchiddfsMatrix) -> GraphsearchiddfsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_iddfs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchiddfsMatrix::scale(self : GraphsearchiddfsMatrix, s : Double) -> GraphsearchiddfsMatrix {
  let result = graph_search_iddfs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchiddfsMatrix::multiply(self : GraphsearchiddfsMatrix, other : GraphsearchiddfsMatrix) -> GraphsearchiddfsMatrix {
  if self.cols != other.rows { return graph_search_iddfs_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_iddfs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphsearchiddfsMatrix::trace(self : GraphsearchiddfsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchiddfsMatrix::det(self : GraphsearchiddfsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchiddfsMatrix::norm(self : GraphsearchiddfsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchiddfsMatrix::to_string(self : GraphsearchiddfsMatrix) -> String {
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

pub(all) struct GraphsearchiddfsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_iddfs_make_vector(comps : Array[Double]) -> GraphsearchiddfsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_iddfs_vector_zero(dim : Int) -> GraphsearchiddfsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchiddfsVector::add(self : GraphsearchiddfsVector, other : GraphsearchiddfsVector) -> GraphsearchiddfsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchiddfsVector::sub(self : GraphsearchiddfsVector, other : GraphsearchiddfsVector) -> GraphsearchiddfsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchiddfsVector::scale(self : GraphsearchiddfsVector, s : Double) -> GraphsearchiddfsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchiddfsVector::dot(self : GraphsearchiddfsVector, other : GraphsearchiddfsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchiddfsVector::norm(self : GraphsearchiddfsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchiddfsVector::normalize(self : GraphsearchiddfsVector) -> GraphsearchiddfsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchiddfsVector::dist(self : GraphsearchiddfsVector, other : GraphsearchiddfsVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchiddfsVector::to_string(self : GraphsearchiddfsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchiddfsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_frame_make(size : Int) -> GraphsearchiddfsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsFrame::len(self : GraphsearchiddfsFrame) -> Int { self.size }

pub fn GraphsearchiddfsFrame::get(self : GraphsearchiddfsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsFrame::set(self : GraphsearchiddfsFrame, i : Int, v : Double) -> GraphsearchiddfsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsFrame::sum(self : GraphsearchiddfsFrame) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsFrame::mean(self : GraphsearchiddfsFrame) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsFrame::scale(self : GraphsearchiddfsFrame, f : Double) -> GraphsearchiddfsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsFrame::add(self : GraphsearchiddfsFrame, other : GraphsearchiddfsFrame) -> GraphsearchiddfsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsFrame::copy(self : GraphsearchiddfsFrame) -> GraphsearchiddfsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsFrame::fill(self : GraphsearchiddfsFrame, v : Double) -> GraphsearchiddfsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsFrame::min(self : GraphsearchiddfsFrame) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsFrame::max(self : GraphsearchiddfsFrame) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsFrame::to_string(self : GraphsearchiddfsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_table_make(size : Int) -> GraphsearchiddfsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsTable::len(self : GraphsearchiddfsTable) -> Int { self.size }

pub fn GraphsearchiddfsTable::get(self : GraphsearchiddfsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsTable::set(self : GraphsearchiddfsTable, i : Int, v : Double) -> GraphsearchiddfsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsTable::sum(self : GraphsearchiddfsTable) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsTable::mean(self : GraphsearchiddfsTable) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsTable::scale(self : GraphsearchiddfsTable, f : Double) -> GraphsearchiddfsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsTable::add(self : GraphsearchiddfsTable, other : GraphsearchiddfsTable) -> GraphsearchiddfsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsTable::copy(self : GraphsearchiddfsTable) -> GraphsearchiddfsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsTable::fill(self : GraphsearchiddfsTable, v : Double) -> GraphsearchiddfsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsTable::min(self : GraphsearchiddfsTable) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsTable::max(self : GraphsearchiddfsTable) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsTable::to_string(self : GraphsearchiddfsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_graphn_make(size : Int) -> GraphsearchiddfsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsGraphN::len(self : GraphsearchiddfsGraphN) -> Int { self.size }

pub fn GraphsearchiddfsGraphN::get(self : GraphsearchiddfsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsGraphN::set(self : GraphsearchiddfsGraphN, i : Int, v : Double) -> GraphsearchiddfsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsGraphN::sum(self : GraphsearchiddfsGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsGraphN::mean(self : GraphsearchiddfsGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsGraphN::scale(self : GraphsearchiddfsGraphN, f : Double) -> GraphsearchiddfsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsGraphN::add(self : GraphsearchiddfsGraphN, other : GraphsearchiddfsGraphN) -> GraphsearchiddfsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsGraphN::copy(self : GraphsearchiddfsGraphN) -> GraphsearchiddfsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsGraphN::fill(self : GraphsearchiddfsGraphN, v : Double) -> GraphsearchiddfsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsGraphN::min(self : GraphsearchiddfsGraphN) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsGraphN::max(self : GraphsearchiddfsGraphN) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsGraphN::to_string(self : GraphsearchiddfsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_node_make(size : Int) -> GraphsearchiddfsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsNode::len(self : GraphsearchiddfsNode) -> Int { self.size }

pub fn GraphsearchiddfsNode::get(self : GraphsearchiddfsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsNode::set(self : GraphsearchiddfsNode, i : Int, v : Double) -> GraphsearchiddfsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsNode::sum(self : GraphsearchiddfsNode) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsNode::mean(self : GraphsearchiddfsNode) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsNode::scale(self : GraphsearchiddfsNode, f : Double) -> GraphsearchiddfsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsNode::add(self : GraphsearchiddfsNode, other : GraphsearchiddfsNode) -> GraphsearchiddfsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsNode::copy(self : GraphsearchiddfsNode) -> GraphsearchiddfsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsNode::fill(self : GraphsearchiddfsNode, v : Double) -> GraphsearchiddfsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsNode::min(self : GraphsearchiddfsNode) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsNode::max(self : GraphsearchiddfsNode) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsNode::to_string(self : GraphsearchiddfsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_edge_make(size : Int) -> GraphsearchiddfsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsEdge::len(self : GraphsearchiddfsEdge) -> Int { self.size }

pub fn GraphsearchiddfsEdge::get(self : GraphsearchiddfsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsEdge::set(self : GraphsearchiddfsEdge, i : Int, v : Double) -> GraphsearchiddfsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsEdge::sum(self : GraphsearchiddfsEdge) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsEdge::mean(self : GraphsearchiddfsEdge) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsEdge::scale(self : GraphsearchiddfsEdge, f : Double) -> GraphsearchiddfsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsEdge::add(self : GraphsearchiddfsEdge, other : GraphsearchiddfsEdge) -> GraphsearchiddfsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsEdge::copy(self : GraphsearchiddfsEdge) -> GraphsearchiddfsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsEdge::fill(self : GraphsearchiddfsEdge, v : Double) -> GraphsearchiddfsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsEdge::min(self : GraphsearchiddfsEdge) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsEdge::max(self : GraphsearchiddfsEdge) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsEdge::to_string(self : GraphsearchiddfsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_path_make(size : Int) -> GraphsearchiddfsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsPath::len(self : GraphsearchiddfsPath) -> Int { self.size }

pub fn GraphsearchiddfsPath::get(self : GraphsearchiddfsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsPath::set(self : GraphsearchiddfsPath, i : Int, v : Double) -> GraphsearchiddfsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsPath::sum(self : GraphsearchiddfsPath) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsPath::mean(self : GraphsearchiddfsPath) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsPath::scale(self : GraphsearchiddfsPath, f : Double) -> GraphsearchiddfsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsPath::add(self : GraphsearchiddfsPath, other : GraphsearchiddfsPath) -> GraphsearchiddfsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsPath::copy(self : GraphsearchiddfsPath) -> GraphsearchiddfsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsPath::fill(self : GraphsearchiddfsPath, v : Double) -> GraphsearchiddfsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsPath::min(self : GraphsearchiddfsPath) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsPath::max(self : GraphsearchiddfsPath) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsPath::to_string(self : GraphsearchiddfsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_cluster_make(size : Int) -> GraphsearchiddfsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsCluster::len(self : GraphsearchiddfsCluster) -> Int { self.size }

pub fn GraphsearchiddfsCluster::get(self : GraphsearchiddfsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsCluster::set(self : GraphsearchiddfsCluster, i : Int, v : Double) -> GraphsearchiddfsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsCluster::sum(self : GraphsearchiddfsCluster) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsCluster::mean(self : GraphsearchiddfsCluster) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsCluster::scale(self : GraphsearchiddfsCluster, f : Double) -> GraphsearchiddfsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsCluster::add(self : GraphsearchiddfsCluster, other : GraphsearchiddfsCluster) -> GraphsearchiddfsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsCluster::copy(self : GraphsearchiddfsCluster) -> GraphsearchiddfsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsCluster::fill(self : GraphsearchiddfsCluster, v : Double) -> GraphsearchiddfsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsCluster::min(self : GraphsearchiddfsCluster) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsCluster::max(self : GraphsearchiddfsCluster) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsCluster::to_string(self : GraphsearchiddfsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_model_make(size : Int) -> GraphsearchiddfsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsModel::len(self : GraphsearchiddfsModel) -> Int { self.size }

pub fn GraphsearchiddfsModel::get(self : GraphsearchiddfsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsModel::set(self : GraphsearchiddfsModel, i : Int, v : Double) -> GraphsearchiddfsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsModel::sum(self : GraphsearchiddfsModel) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsModel::mean(self : GraphsearchiddfsModel) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsModel::scale(self : GraphsearchiddfsModel, f : Double) -> GraphsearchiddfsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsModel::add(self : GraphsearchiddfsModel, other : GraphsearchiddfsModel) -> GraphsearchiddfsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsModel::copy(self : GraphsearchiddfsModel) -> GraphsearchiddfsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsModel::fill(self : GraphsearchiddfsModel, v : Double) -> GraphsearchiddfsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsModel::min(self : GraphsearchiddfsModel) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsModel::max(self : GraphsearchiddfsModel) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsModel::to_string(self : GraphsearchiddfsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_layer_make(size : Int) -> GraphsearchiddfsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsLayer::len(self : GraphsearchiddfsLayer) -> Int { self.size }

pub fn GraphsearchiddfsLayer::get(self : GraphsearchiddfsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsLayer::set(self : GraphsearchiddfsLayer, i : Int, v : Double) -> GraphsearchiddfsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsLayer::sum(self : GraphsearchiddfsLayer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsLayer::mean(self : GraphsearchiddfsLayer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsLayer::scale(self : GraphsearchiddfsLayer, f : Double) -> GraphsearchiddfsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsLayer::add(self : GraphsearchiddfsLayer, other : GraphsearchiddfsLayer) -> GraphsearchiddfsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsLayer::copy(self : GraphsearchiddfsLayer) -> GraphsearchiddfsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsLayer::fill(self : GraphsearchiddfsLayer, v : Double) -> GraphsearchiddfsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsLayer::min(self : GraphsearchiddfsLayer) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsLayer::max(self : GraphsearchiddfsLayer) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsLayer::to_string(self : GraphsearchiddfsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_buffer_make(size : Int) -> GraphsearchiddfsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsBuffer::len(self : GraphsearchiddfsBuffer) -> Int { self.size }

pub fn GraphsearchiddfsBuffer::get(self : GraphsearchiddfsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsBuffer::set(self : GraphsearchiddfsBuffer, i : Int, v : Double) -> GraphsearchiddfsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsBuffer::sum(self : GraphsearchiddfsBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsBuffer::mean(self : GraphsearchiddfsBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsBuffer::scale(self : GraphsearchiddfsBuffer, f : Double) -> GraphsearchiddfsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsBuffer::add(self : GraphsearchiddfsBuffer, other : GraphsearchiddfsBuffer) -> GraphsearchiddfsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsBuffer::copy(self : GraphsearchiddfsBuffer) -> GraphsearchiddfsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsBuffer::fill(self : GraphsearchiddfsBuffer, v : Double) -> GraphsearchiddfsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsBuffer::min(self : GraphsearchiddfsBuffer) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsBuffer::max(self : GraphsearchiddfsBuffer) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsBuffer::to_string(self : GraphsearchiddfsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_cursor_make(size : Int) -> GraphsearchiddfsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsCursor::len(self : GraphsearchiddfsCursor) -> Int { self.size }

pub fn GraphsearchiddfsCursor::get(self : GraphsearchiddfsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsCursor::set(self : GraphsearchiddfsCursor, i : Int, v : Double) -> GraphsearchiddfsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsCursor::sum(self : GraphsearchiddfsCursor) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsCursor::mean(self : GraphsearchiddfsCursor) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsCursor::scale(self : GraphsearchiddfsCursor, f : Double) -> GraphsearchiddfsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsCursor::add(self : GraphsearchiddfsCursor, other : GraphsearchiddfsCursor) -> GraphsearchiddfsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsCursor::copy(self : GraphsearchiddfsCursor) -> GraphsearchiddfsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsCursor::fill(self : GraphsearchiddfsCursor, v : Double) -> GraphsearchiddfsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsCursor::min(self : GraphsearchiddfsCursor) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsCursor::max(self : GraphsearchiddfsCursor) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsCursor::to_string(self : GraphsearchiddfsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_view_make(size : Int) -> GraphsearchiddfsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsView::len(self : GraphsearchiddfsView) -> Int { self.size }

pub fn GraphsearchiddfsView::get(self : GraphsearchiddfsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsView::set(self : GraphsearchiddfsView, i : Int, v : Double) -> GraphsearchiddfsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsView::sum(self : GraphsearchiddfsView) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsView::mean(self : GraphsearchiddfsView) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsView::scale(self : GraphsearchiddfsView, f : Double) -> GraphsearchiddfsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsView::add(self : GraphsearchiddfsView, other : GraphsearchiddfsView) -> GraphsearchiddfsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsView::copy(self : GraphsearchiddfsView) -> GraphsearchiddfsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsView::fill(self : GraphsearchiddfsView, v : Double) -> GraphsearchiddfsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsView::min(self : GraphsearchiddfsView) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsView::max(self : GraphsearchiddfsView) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsView::to_string(self : GraphsearchiddfsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_range_make(size : Int) -> GraphsearchiddfsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsRange::len(self : GraphsearchiddfsRange) -> Int { self.size }

pub fn GraphsearchiddfsRange::get(self : GraphsearchiddfsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsRange::set(self : GraphsearchiddfsRange, i : Int, v : Double) -> GraphsearchiddfsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsRange::sum(self : GraphsearchiddfsRange) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsRange::mean(self : GraphsearchiddfsRange) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsRange::scale(self : GraphsearchiddfsRange, f : Double) -> GraphsearchiddfsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsRange::add(self : GraphsearchiddfsRange, other : GraphsearchiddfsRange) -> GraphsearchiddfsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsRange::copy(self : GraphsearchiddfsRange) -> GraphsearchiddfsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsRange::fill(self : GraphsearchiddfsRange, v : Double) -> GraphsearchiddfsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsRange::min(self : GraphsearchiddfsRange) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsRange::max(self : GraphsearchiddfsRange) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsRange::to_string(self : GraphsearchiddfsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_slice_make(size : Int) -> GraphsearchiddfsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchiddfsSlice::len(self : GraphsearchiddfsSlice) -> Int { self.size }

pub fn GraphsearchiddfsSlice::get(self : GraphsearchiddfsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchiddfsSlice::set(self : GraphsearchiddfsSlice, i : Int, v : Double) -> GraphsearchiddfsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsSlice::sum(self : GraphsearchiddfsSlice) -> Double { @_common.sum(self.data) }

pub fn GraphsearchiddfsSlice::mean(self : GraphsearchiddfsSlice) -> Double { @_common.mean(self.data) }

pub fn GraphsearchiddfsSlice::scale(self : GraphsearchiddfsSlice, f : Double) -> GraphsearchiddfsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsSlice::add(self : GraphsearchiddfsSlice, other : GraphsearchiddfsSlice) -> GraphsearchiddfsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchiddfsSlice::copy(self : GraphsearchiddfsSlice) -> GraphsearchiddfsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsSlice::fill(self : GraphsearchiddfsSlice, v : Double) -> GraphsearchiddfsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchiddfsSlice::min(self : GraphsearchiddfsSlice) -> Double { @_common.min(self.data) }

pub fn GraphsearchiddfsSlice::max(self : GraphsearchiddfsSlice) -> Double { @_common.max(self.data) }

pub fn GraphsearchiddfsSlice::to_string(self : GraphsearchiddfsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

