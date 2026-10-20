///===
/// extcore/graph_search_dfs

pub(all) struct GraphsearchdfsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_dfs_make_point(x : Double, y : Double) -> GraphsearchdfsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_dfs_make_point3(x : Double, y : Double, z : Double) -> GraphsearchdfsPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchdfsPoint::x(self : GraphsearchdfsPoint) -> Double { self.x }

pub fn GraphsearchdfsPoint::y(self : GraphsearchdfsPoint) -> Double { self.y }

pub fn GraphsearchdfsPoint::z(self : GraphsearchdfsPoint) -> Double { self.z }

pub fn GraphsearchdfsPoint::label(self : GraphsearchdfsPoint) -> Int { self.label }

pub fn GraphsearchdfsPoint::dist(self : GraphsearchdfsPoint, other : GraphsearchdfsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchdfsPoint::add(self : GraphsearchdfsPoint, other : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchdfsPoint::sub(self : GraphsearchdfsPoint, other : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchdfsPoint::scale(self : GraphsearchdfsPoint, s : Double) -> GraphsearchdfsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchdfsPoint::dot(self : GraphsearchdfsPoint, other : GraphsearchdfsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchdfsPoint::cross(self : GraphsearchdfsPoint, other : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchdfsPoint::norm(self : GraphsearchdfsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchdfsPoint::normalize(self : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchdfsPoint::negate(self : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchdfsPoint::mid(self : GraphsearchdfsPoint, other : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchdfsPoint::lerp(self : GraphsearchdfsPoint, other : GraphsearchdfsPoint, t : Double) -> GraphsearchdfsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchdfsPoint::to_string(self : GraphsearchdfsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchdfsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_dfs_make_series(vals : Array[Double], name : String) -> GraphsearchdfsSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchdfsSeries::len(self : GraphsearchdfsSeries) -> Int { self.vals.length() }

pub fn GraphsearchdfsSeries::sum(self : GraphsearchdfsSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchdfsSeries::mean(self : GraphsearchdfsSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchdfsSeries::min(self : GraphsearchdfsSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchdfsSeries::max(self : GraphsearchdfsSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchdfsSeries::range(self : GraphsearchdfsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchdfsSeries::variance(self : GraphsearchdfsSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchdfsSeries::std(self : GraphsearchdfsSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchdfsSeries::median(self : GraphsearchdfsSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchdfsSeries::scale(self : GraphsearchdfsSeries, f : Double) -> GraphsearchdfsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchdfsSeries::add(self : GraphsearchdfsSeries, other : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchdfsSeries::sub(self : GraphsearchdfsSeries, other : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchdfsSeries::normalize(self : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchdfsSeries::cumsum(self : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchdfsSeries::to_string(self : GraphsearchdfsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchdfsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_dfs_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchdfsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_dfs_matrix_identity(n : Int) -> GraphsearchdfsMatrix {
  let m = graph_search_dfs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchdfsMatrix::get(self : GraphsearchdfsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchdfsMatrix::transpose(self : GraphsearchdfsMatrix) -> GraphsearchdfsMatrix {
  let result = graph_search_dfs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchdfsMatrix::add(self : GraphsearchdfsMatrix, other : GraphsearchdfsMatrix) -> GraphsearchdfsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_dfs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchdfsMatrix::scale(self : GraphsearchdfsMatrix, s : Double) -> GraphsearchdfsMatrix {
  let result = graph_search_dfs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchdfsMatrix::multiply(self : GraphsearchdfsMatrix, other : GraphsearchdfsMatrix) -> GraphsearchdfsMatrix {
  if self.cols != other.rows { return graph_search_dfs_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_dfs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchdfsMatrix::trace(self : GraphsearchdfsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchdfsMatrix::det(self : GraphsearchdfsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchdfsMatrix::norm(self : GraphsearchdfsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchdfsMatrix::to_string(self : GraphsearchdfsMatrix) -> String {
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

pub(all) struct GraphsearchdfsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_dfs_make_vector(comps : Array[Double]) -> GraphsearchdfsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_dfs_vector_zero(dim : Int) -> GraphsearchdfsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchdfsVector::add(self : GraphsearchdfsVector, other : GraphsearchdfsVector) -> GraphsearchdfsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchdfsVector::sub(self : GraphsearchdfsVector, other : GraphsearchdfsVector) -> GraphsearchdfsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchdfsVector::scale(self : GraphsearchdfsVector, s : Double) -> GraphsearchdfsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchdfsVector::dot(self : GraphsearchdfsVector, other : GraphsearchdfsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchdfsVector::norm(self : GraphsearchdfsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchdfsVector::normalize(self : GraphsearchdfsVector) -> GraphsearchdfsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchdfsVector::dist(self : GraphsearchdfsVector, other : GraphsearchdfsVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchdfsVector::to_string(self : GraphsearchdfsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchdfsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_frame_make(size : Int) -> GraphsearchdfsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsFrame::len(self : GraphsearchdfsFrame) -> Int { self.size }

pub fn GraphsearchdfsFrame::get(self : GraphsearchdfsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsFrame::set(self : GraphsearchdfsFrame, i : Int, v : Double) -> GraphsearchdfsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsFrame::sum(self : GraphsearchdfsFrame) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsFrame::mean(self : GraphsearchdfsFrame) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsFrame::scale(self : GraphsearchdfsFrame, f : Double) -> GraphsearchdfsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsFrame::add(self : GraphsearchdfsFrame, other : GraphsearchdfsFrame) -> GraphsearchdfsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsFrame::copy(self : GraphsearchdfsFrame) -> GraphsearchdfsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsFrame::fill(self : GraphsearchdfsFrame, v : Double) -> GraphsearchdfsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsFrame::min(self : GraphsearchdfsFrame) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsFrame::max(self : GraphsearchdfsFrame) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsFrame::to_string(self : GraphsearchdfsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_table_make(size : Int) -> GraphsearchdfsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsTable::len(self : GraphsearchdfsTable) -> Int { self.size }

pub fn GraphsearchdfsTable::get(self : GraphsearchdfsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsTable::set(self : GraphsearchdfsTable, i : Int, v : Double) -> GraphsearchdfsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsTable::sum(self : GraphsearchdfsTable) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsTable::mean(self : GraphsearchdfsTable) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsTable::scale(self : GraphsearchdfsTable, f : Double) -> GraphsearchdfsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsTable::add(self : GraphsearchdfsTable, other : GraphsearchdfsTable) -> GraphsearchdfsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsTable::copy(self : GraphsearchdfsTable) -> GraphsearchdfsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsTable::fill(self : GraphsearchdfsTable, v : Double) -> GraphsearchdfsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsTable::min(self : GraphsearchdfsTable) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsTable::max(self : GraphsearchdfsTable) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsTable::to_string(self : GraphsearchdfsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_graphn_make(size : Int) -> GraphsearchdfsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsGraphN::len(self : GraphsearchdfsGraphN) -> Int { self.size }

pub fn GraphsearchdfsGraphN::get(self : GraphsearchdfsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsGraphN::set(self : GraphsearchdfsGraphN, i : Int, v : Double) -> GraphsearchdfsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsGraphN::sum(self : GraphsearchdfsGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsGraphN::mean(self : GraphsearchdfsGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsGraphN::scale(self : GraphsearchdfsGraphN, f : Double) -> GraphsearchdfsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsGraphN::add(self : GraphsearchdfsGraphN, other : GraphsearchdfsGraphN) -> GraphsearchdfsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsGraphN::copy(self : GraphsearchdfsGraphN) -> GraphsearchdfsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsGraphN::fill(self : GraphsearchdfsGraphN, v : Double) -> GraphsearchdfsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsGraphN::min(self : GraphsearchdfsGraphN) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsGraphN::max(self : GraphsearchdfsGraphN) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsGraphN::to_string(self : GraphsearchdfsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_node_make(size : Int) -> GraphsearchdfsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsNode::len(self : GraphsearchdfsNode) -> Int { self.size }

pub fn GraphsearchdfsNode::get(self : GraphsearchdfsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsNode::set(self : GraphsearchdfsNode, i : Int, v : Double) -> GraphsearchdfsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsNode::sum(self : GraphsearchdfsNode) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsNode::mean(self : GraphsearchdfsNode) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsNode::scale(self : GraphsearchdfsNode, f : Double) -> GraphsearchdfsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsNode::add(self : GraphsearchdfsNode, other : GraphsearchdfsNode) -> GraphsearchdfsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsNode::copy(self : GraphsearchdfsNode) -> GraphsearchdfsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsNode::fill(self : GraphsearchdfsNode, v : Double) -> GraphsearchdfsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsNode::min(self : GraphsearchdfsNode) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsNode::max(self : GraphsearchdfsNode) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsNode::to_string(self : GraphsearchdfsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_edge_make(size : Int) -> GraphsearchdfsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsEdge::len(self : GraphsearchdfsEdge) -> Int { self.size }

pub fn GraphsearchdfsEdge::get(self : GraphsearchdfsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsEdge::set(self : GraphsearchdfsEdge, i : Int, v : Double) -> GraphsearchdfsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsEdge::sum(self : GraphsearchdfsEdge) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsEdge::mean(self : GraphsearchdfsEdge) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsEdge::scale(self : GraphsearchdfsEdge, f : Double) -> GraphsearchdfsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsEdge::add(self : GraphsearchdfsEdge, other : GraphsearchdfsEdge) -> GraphsearchdfsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsEdge::copy(self : GraphsearchdfsEdge) -> GraphsearchdfsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsEdge::fill(self : GraphsearchdfsEdge, v : Double) -> GraphsearchdfsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsEdge::min(self : GraphsearchdfsEdge) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsEdge::max(self : GraphsearchdfsEdge) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsEdge::to_string(self : GraphsearchdfsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_path_make(size : Int) -> GraphsearchdfsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsPath::len(self : GraphsearchdfsPath) -> Int { self.size }

pub fn GraphsearchdfsPath::get(self : GraphsearchdfsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsPath::set(self : GraphsearchdfsPath, i : Int, v : Double) -> GraphsearchdfsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsPath::sum(self : GraphsearchdfsPath) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsPath::mean(self : GraphsearchdfsPath) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsPath::scale(self : GraphsearchdfsPath, f : Double) -> GraphsearchdfsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsPath::add(self : GraphsearchdfsPath, other : GraphsearchdfsPath) -> GraphsearchdfsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsPath::copy(self : GraphsearchdfsPath) -> GraphsearchdfsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsPath::fill(self : GraphsearchdfsPath, v : Double) -> GraphsearchdfsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsPath::min(self : GraphsearchdfsPath) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsPath::max(self : GraphsearchdfsPath) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsPath::to_string(self : GraphsearchdfsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_cluster_make(size : Int) -> GraphsearchdfsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsCluster::len(self : GraphsearchdfsCluster) -> Int { self.size }

pub fn GraphsearchdfsCluster::get(self : GraphsearchdfsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsCluster::set(self : GraphsearchdfsCluster, i : Int, v : Double) -> GraphsearchdfsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsCluster::sum(self : GraphsearchdfsCluster) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsCluster::mean(self : GraphsearchdfsCluster) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsCluster::scale(self : GraphsearchdfsCluster, f : Double) -> GraphsearchdfsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsCluster::add(self : GraphsearchdfsCluster, other : GraphsearchdfsCluster) -> GraphsearchdfsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsCluster::copy(self : GraphsearchdfsCluster) -> GraphsearchdfsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsCluster::fill(self : GraphsearchdfsCluster, v : Double) -> GraphsearchdfsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsCluster::min(self : GraphsearchdfsCluster) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsCluster::max(self : GraphsearchdfsCluster) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsCluster::to_string(self : GraphsearchdfsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_model_make(size : Int) -> GraphsearchdfsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsModel::len(self : GraphsearchdfsModel) -> Int { self.size }

pub fn GraphsearchdfsModel::get(self : GraphsearchdfsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsModel::set(self : GraphsearchdfsModel, i : Int, v : Double) -> GraphsearchdfsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsModel::sum(self : GraphsearchdfsModel) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsModel::mean(self : GraphsearchdfsModel) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsModel::scale(self : GraphsearchdfsModel, f : Double) -> GraphsearchdfsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsModel::add(self : GraphsearchdfsModel, other : GraphsearchdfsModel) -> GraphsearchdfsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsModel::copy(self : GraphsearchdfsModel) -> GraphsearchdfsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsModel::fill(self : GraphsearchdfsModel, v : Double) -> GraphsearchdfsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsModel::min(self : GraphsearchdfsModel) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsModel::max(self : GraphsearchdfsModel) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsModel::to_string(self : GraphsearchdfsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_layer_make(size : Int) -> GraphsearchdfsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsLayer::len(self : GraphsearchdfsLayer) -> Int { self.size }

pub fn GraphsearchdfsLayer::get(self : GraphsearchdfsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsLayer::set(self : GraphsearchdfsLayer, i : Int, v : Double) -> GraphsearchdfsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsLayer::sum(self : GraphsearchdfsLayer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsLayer::mean(self : GraphsearchdfsLayer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsLayer::scale(self : GraphsearchdfsLayer, f : Double) -> GraphsearchdfsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsLayer::add(self : GraphsearchdfsLayer, other : GraphsearchdfsLayer) -> GraphsearchdfsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsLayer::copy(self : GraphsearchdfsLayer) -> GraphsearchdfsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsLayer::fill(self : GraphsearchdfsLayer, v : Double) -> GraphsearchdfsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsLayer::min(self : GraphsearchdfsLayer) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsLayer::max(self : GraphsearchdfsLayer) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsLayer::to_string(self : GraphsearchdfsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_buffer_make(size : Int) -> GraphsearchdfsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsBuffer::len(self : GraphsearchdfsBuffer) -> Int { self.size }

pub fn GraphsearchdfsBuffer::get(self : GraphsearchdfsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsBuffer::set(self : GraphsearchdfsBuffer, i : Int, v : Double) -> GraphsearchdfsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsBuffer::sum(self : GraphsearchdfsBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsBuffer::mean(self : GraphsearchdfsBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsBuffer::scale(self : GraphsearchdfsBuffer, f : Double) -> GraphsearchdfsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsBuffer::add(self : GraphsearchdfsBuffer, other : GraphsearchdfsBuffer) -> GraphsearchdfsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsBuffer::copy(self : GraphsearchdfsBuffer) -> GraphsearchdfsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsBuffer::fill(self : GraphsearchdfsBuffer, v : Double) -> GraphsearchdfsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsBuffer::min(self : GraphsearchdfsBuffer) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsBuffer::max(self : GraphsearchdfsBuffer) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsBuffer::to_string(self : GraphsearchdfsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_cursor_make(size : Int) -> GraphsearchdfsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsCursor::len(self : GraphsearchdfsCursor) -> Int { self.size }

pub fn GraphsearchdfsCursor::get(self : GraphsearchdfsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsCursor::set(self : GraphsearchdfsCursor, i : Int, v : Double) -> GraphsearchdfsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsCursor::sum(self : GraphsearchdfsCursor) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsCursor::mean(self : GraphsearchdfsCursor) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsCursor::scale(self : GraphsearchdfsCursor, f : Double) -> GraphsearchdfsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsCursor::add(self : GraphsearchdfsCursor, other : GraphsearchdfsCursor) -> GraphsearchdfsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsCursor::copy(self : GraphsearchdfsCursor) -> GraphsearchdfsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsCursor::fill(self : GraphsearchdfsCursor, v : Double) -> GraphsearchdfsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsCursor::min(self : GraphsearchdfsCursor) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsCursor::max(self : GraphsearchdfsCursor) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsCursor::to_string(self : GraphsearchdfsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_view_make(size : Int) -> GraphsearchdfsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsView::len(self : GraphsearchdfsView) -> Int { self.size }

pub fn GraphsearchdfsView::get(self : GraphsearchdfsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsView::set(self : GraphsearchdfsView, i : Int, v : Double) -> GraphsearchdfsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsView::sum(self : GraphsearchdfsView) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsView::mean(self : GraphsearchdfsView) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsView::scale(self : GraphsearchdfsView, f : Double) -> GraphsearchdfsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsView::add(self : GraphsearchdfsView, other : GraphsearchdfsView) -> GraphsearchdfsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsView::copy(self : GraphsearchdfsView) -> GraphsearchdfsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsView::fill(self : GraphsearchdfsView, v : Double) -> GraphsearchdfsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsView::min(self : GraphsearchdfsView) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsView::max(self : GraphsearchdfsView) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsView::to_string(self : GraphsearchdfsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_range_make(size : Int) -> GraphsearchdfsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsRange::len(self : GraphsearchdfsRange) -> Int { self.size }

pub fn GraphsearchdfsRange::get(self : GraphsearchdfsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsRange::set(self : GraphsearchdfsRange, i : Int, v : Double) -> GraphsearchdfsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsRange::sum(self : GraphsearchdfsRange) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsRange::mean(self : GraphsearchdfsRange) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsRange::scale(self : GraphsearchdfsRange, f : Double) -> GraphsearchdfsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsRange::add(self : GraphsearchdfsRange, other : GraphsearchdfsRange) -> GraphsearchdfsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsRange::copy(self : GraphsearchdfsRange) -> GraphsearchdfsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsRange::fill(self : GraphsearchdfsRange, v : Double) -> GraphsearchdfsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsRange::min(self : GraphsearchdfsRange) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsRange::max(self : GraphsearchdfsRange) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsRange::to_string(self : GraphsearchdfsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_slice_make(size : Int) -> GraphsearchdfsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphsearchdfsSlice::len(self : GraphsearchdfsSlice) -> Int { self.size }

pub fn GraphsearchdfsSlice::get(self : GraphsearchdfsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphsearchdfsSlice::set(self : GraphsearchdfsSlice, i : Int, v : Double) -> GraphsearchdfsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsSlice::sum(self : GraphsearchdfsSlice) -> Double { @_common.sum(self.data) }

pub fn GraphsearchdfsSlice::mean(self : GraphsearchdfsSlice) -> Double { @_common.mean(self.data) }

pub fn GraphsearchdfsSlice::scale(self : GraphsearchdfsSlice, f : Double) -> GraphsearchdfsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsSlice::add(self : GraphsearchdfsSlice, other : GraphsearchdfsSlice) -> GraphsearchdfsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphsearchdfsSlice::copy(self : GraphsearchdfsSlice) -> GraphsearchdfsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsSlice::fill(self : GraphsearchdfsSlice, v : Double) -> GraphsearchdfsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphsearchdfsSlice::min(self : GraphsearchdfsSlice) -> Double { @_common.min(self.data) }

pub fn GraphsearchdfsSlice::max(self : GraphsearchdfsSlice) -> Double { @_common.max(self.data) }

pub fn GraphsearchdfsSlice::to_string(self : GraphsearchdfsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

