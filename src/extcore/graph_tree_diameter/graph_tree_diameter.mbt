///===
/// extcore/graph_tree_diameter

pub(all) struct GraphtreediameterPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_diameter_make_point(x : Double, y : Double) -> GraphtreediameterPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_diameter_make_point3(x : Double, y : Double, z : Double) -> GraphtreediameterPoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreediameterPoint::x(self : GraphtreediameterPoint) -> Double { self.x }

pub fn GraphtreediameterPoint::y(self : GraphtreediameterPoint) -> Double { self.y }

pub fn GraphtreediameterPoint::z(self : GraphtreediameterPoint) -> Double { self.z }

pub fn GraphtreediameterPoint::label(self : GraphtreediameterPoint) -> Int { self.label }

pub fn GraphtreediameterPoint::dist(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreediameterPoint::add(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> GraphtreediameterPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreediameterPoint::sub(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> GraphtreediameterPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreediameterPoint::scale(self : GraphtreediameterPoint, s : Double) -> GraphtreediameterPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreediameterPoint::dot(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreediameterPoint::cross(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> GraphtreediameterPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreediameterPoint::norm(self : GraphtreediameterPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreediameterPoint::normalize(self : GraphtreediameterPoint) -> GraphtreediameterPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreediameterPoint::negate(self : GraphtreediameterPoint) -> GraphtreediameterPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreediameterPoint::mid(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> GraphtreediameterPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreediameterPoint::lerp(self : GraphtreediameterPoint, other : GraphtreediameterPoint, t : Double) -> GraphtreediameterPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreediameterPoint::to_string(self : GraphtreediameterPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreediameterSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_diameter_make_series(vals : Array[Double], name : String) -> GraphtreediameterSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreediameterSeries::len(self : GraphtreediameterSeries) -> Int { self.vals.length() }

pub fn GraphtreediameterSeries::sum(self : GraphtreediameterSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreediameterSeries::mean(self : GraphtreediameterSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreediameterSeries::min(self : GraphtreediameterSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreediameterSeries::max(self : GraphtreediameterSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreediameterSeries::range(self : GraphtreediameterSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreediameterSeries::variance(self : GraphtreediameterSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreediameterSeries::std(self : GraphtreediameterSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreediameterSeries::median(self : GraphtreediameterSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreediameterSeries::scale(self : GraphtreediameterSeries, f : Double) -> GraphtreediameterSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreediameterSeries::add(self : GraphtreediameterSeries, other : GraphtreediameterSeries) -> GraphtreediameterSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreediameterSeries::sub(self : GraphtreediameterSeries, other : GraphtreediameterSeries) -> GraphtreediameterSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreediameterSeries::normalize(self : GraphtreediameterSeries) -> GraphtreediameterSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreediameterSeries::cumsum(self : GraphtreediameterSeries) -> GraphtreediameterSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreediameterSeries::to_string(self : GraphtreediameterSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreediameterMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_diameter_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreediameterMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn graph_tree_diameter_matrix_identity(n : Int) -> GraphtreediameterMatrix {
  let m = graph_tree_diameter_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreediameterMatrix::get(self : GraphtreediameterMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreediameterMatrix::transpose(self : GraphtreediameterMatrix) -> GraphtreediameterMatrix {
  let result = graph_tree_diameter_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreediameterMatrix::add(self : GraphtreediameterMatrix, other : GraphtreediameterMatrix) -> GraphtreediameterMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_diameter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreediameterMatrix::scale(self : GraphtreediameterMatrix, s : Double) -> GraphtreediameterMatrix {
  let result = graph_tree_diameter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreediameterMatrix::multiply(self : GraphtreediameterMatrix, other : GraphtreediameterMatrix) -> GraphtreediameterMatrix {
  if self.cols != other.rows { return graph_tree_diameter_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_diameter_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphtreediameterMatrix::trace(self : GraphtreediameterMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreediameterMatrix::det(self : GraphtreediameterMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreediameterMatrix::norm(self : GraphtreediameterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreediameterMatrix::to_string(self : GraphtreediameterMatrix) -> String {
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

pub(all) struct GraphtreediameterVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_diameter_make_vector(comps : Array[Double]) -> GraphtreediameterVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_diameter_vector_zero(dim : Int) -> GraphtreediameterVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreediameterVector::add(self : GraphtreediameterVector, other : GraphtreediameterVector) -> GraphtreediameterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreediameterVector::sub(self : GraphtreediameterVector, other : GraphtreediameterVector) -> GraphtreediameterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreediameterVector::scale(self : GraphtreediameterVector, s : Double) -> GraphtreediameterVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreediameterVector::dot(self : GraphtreediameterVector, other : GraphtreediameterVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreediameterVector::norm(self : GraphtreediameterVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreediameterVector::normalize(self : GraphtreediameterVector) -> GraphtreediameterVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreediameterVector::dist(self : GraphtreediameterVector, other : GraphtreediameterVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreediameterVector::to_string(self : GraphtreediameterVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreediameterFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_frame_make(size : Int) -> GraphtreediameterFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterFrame::len(self : GraphtreediameterFrame) -> Int { self.size }

pub fn GraphtreediameterFrame::get(self : GraphtreediameterFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterFrame::set(self : GraphtreediameterFrame, i : Int, v : Double) -> GraphtreediameterFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterFrame::sum(self : GraphtreediameterFrame) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterFrame::mean(self : GraphtreediameterFrame) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterFrame::scale(self : GraphtreediameterFrame, f : Double) -> GraphtreediameterFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterFrame::add(self : GraphtreediameterFrame, other : GraphtreediameterFrame) -> GraphtreediameterFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterFrame::copy(self : GraphtreediameterFrame) -> GraphtreediameterFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterFrame::fill(self : GraphtreediameterFrame, v : Double) -> GraphtreediameterFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterFrame::min(self : GraphtreediameterFrame) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterFrame::max(self : GraphtreediameterFrame) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterFrame::to_string(self : GraphtreediameterFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_table_make(size : Int) -> GraphtreediameterTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterTable::len(self : GraphtreediameterTable) -> Int { self.size }

pub fn GraphtreediameterTable::get(self : GraphtreediameterTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterTable::set(self : GraphtreediameterTable, i : Int, v : Double) -> GraphtreediameterTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterTable::sum(self : GraphtreediameterTable) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterTable::mean(self : GraphtreediameterTable) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterTable::scale(self : GraphtreediameterTable, f : Double) -> GraphtreediameterTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterTable::add(self : GraphtreediameterTable, other : GraphtreediameterTable) -> GraphtreediameterTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterTable::copy(self : GraphtreediameterTable) -> GraphtreediameterTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterTable::fill(self : GraphtreediameterTable, v : Double) -> GraphtreediameterTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterTable::min(self : GraphtreediameterTable) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterTable::max(self : GraphtreediameterTable) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterTable::to_string(self : GraphtreediameterTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_graphn_make(size : Int) -> GraphtreediameterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterGraphN::len(self : GraphtreediameterGraphN) -> Int { self.size }

pub fn GraphtreediameterGraphN::get(self : GraphtreediameterGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterGraphN::set(self : GraphtreediameterGraphN, i : Int, v : Double) -> GraphtreediameterGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterGraphN::sum(self : GraphtreediameterGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterGraphN::mean(self : GraphtreediameterGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterGraphN::scale(self : GraphtreediameterGraphN, f : Double) -> GraphtreediameterGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterGraphN::add(self : GraphtreediameterGraphN, other : GraphtreediameterGraphN) -> GraphtreediameterGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterGraphN::copy(self : GraphtreediameterGraphN) -> GraphtreediameterGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterGraphN::fill(self : GraphtreediameterGraphN, v : Double) -> GraphtreediameterGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterGraphN::min(self : GraphtreediameterGraphN) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterGraphN::max(self : GraphtreediameterGraphN) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterGraphN::to_string(self : GraphtreediameterGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_node_make(size : Int) -> GraphtreediameterNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterNode::len(self : GraphtreediameterNode) -> Int { self.size }

pub fn GraphtreediameterNode::get(self : GraphtreediameterNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterNode::set(self : GraphtreediameterNode, i : Int, v : Double) -> GraphtreediameterNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterNode::sum(self : GraphtreediameterNode) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterNode::mean(self : GraphtreediameterNode) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterNode::scale(self : GraphtreediameterNode, f : Double) -> GraphtreediameterNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterNode::add(self : GraphtreediameterNode, other : GraphtreediameterNode) -> GraphtreediameterNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterNode::copy(self : GraphtreediameterNode) -> GraphtreediameterNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterNode::fill(self : GraphtreediameterNode, v : Double) -> GraphtreediameterNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterNode::min(self : GraphtreediameterNode) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterNode::max(self : GraphtreediameterNode) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterNode::to_string(self : GraphtreediameterNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_edge_make(size : Int) -> GraphtreediameterEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterEdge::len(self : GraphtreediameterEdge) -> Int { self.size }

pub fn GraphtreediameterEdge::get(self : GraphtreediameterEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterEdge::set(self : GraphtreediameterEdge, i : Int, v : Double) -> GraphtreediameterEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterEdge::sum(self : GraphtreediameterEdge) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterEdge::mean(self : GraphtreediameterEdge) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterEdge::scale(self : GraphtreediameterEdge, f : Double) -> GraphtreediameterEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterEdge::add(self : GraphtreediameterEdge, other : GraphtreediameterEdge) -> GraphtreediameterEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterEdge::copy(self : GraphtreediameterEdge) -> GraphtreediameterEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterEdge::fill(self : GraphtreediameterEdge, v : Double) -> GraphtreediameterEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterEdge::min(self : GraphtreediameterEdge) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterEdge::max(self : GraphtreediameterEdge) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterEdge::to_string(self : GraphtreediameterEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_path_make(size : Int) -> GraphtreediameterPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterPath::len(self : GraphtreediameterPath) -> Int { self.size }

pub fn GraphtreediameterPath::get(self : GraphtreediameterPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterPath::set(self : GraphtreediameterPath, i : Int, v : Double) -> GraphtreediameterPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterPath::sum(self : GraphtreediameterPath) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterPath::mean(self : GraphtreediameterPath) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterPath::scale(self : GraphtreediameterPath, f : Double) -> GraphtreediameterPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterPath::add(self : GraphtreediameterPath, other : GraphtreediameterPath) -> GraphtreediameterPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterPath::copy(self : GraphtreediameterPath) -> GraphtreediameterPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterPath::fill(self : GraphtreediameterPath, v : Double) -> GraphtreediameterPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterPath::min(self : GraphtreediameterPath) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterPath::max(self : GraphtreediameterPath) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterPath::to_string(self : GraphtreediameterPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_cluster_make(size : Int) -> GraphtreediameterCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterCluster::len(self : GraphtreediameterCluster) -> Int { self.size }

pub fn GraphtreediameterCluster::get(self : GraphtreediameterCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterCluster::set(self : GraphtreediameterCluster, i : Int, v : Double) -> GraphtreediameterCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterCluster::sum(self : GraphtreediameterCluster) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterCluster::mean(self : GraphtreediameterCluster) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterCluster::scale(self : GraphtreediameterCluster, f : Double) -> GraphtreediameterCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterCluster::add(self : GraphtreediameterCluster, other : GraphtreediameterCluster) -> GraphtreediameterCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterCluster::copy(self : GraphtreediameterCluster) -> GraphtreediameterCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterCluster::fill(self : GraphtreediameterCluster, v : Double) -> GraphtreediameterCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterCluster::min(self : GraphtreediameterCluster) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterCluster::max(self : GraphtreediameterCluster) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterCluster::to_string(self : GraphtreediameterCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_model_make(size : Int) -> GraphtreediameterModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterModel::len(self : GraphtreediameterModel) -> Int { self.size }

pub fn GraphtreediameterModel::get(self : GraphtreediameterModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterModel::set(self : GraphtreediameterModel, i : Int, v : Double) -> GraphtreediameterModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterModel::sum(self : GraphtreediameterModel) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterModel::mean(self : GraphtreediameterModel) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterModel::scale(self : GraphtreediameterModel, f : Double) -> GraphtreediameterModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterModel::add(self : GraphtreediameterModel, other : GraphtreediameterModel) -> GraphtreediameterModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterModel::copy(self : GraphtreediameterModel) -> GraphtreediameterModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterModel::fill(self : GraphtreediameterModel, v : Double) -> GraphtreediameterModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterModel::min(self : GraphtreediameterModel) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterModel::max(self : GraphtreediameterModel) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterModel::to_string(self : GraphtreediameterModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_layer_make(size : Int) -> GraphtreediameterLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterLayer::len(self : GraphtreediameterLayer) -> Int { self.size }

pub fn GraphtreediameterLayer::get(self : GraphtreediameterLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterLayer::set(self : GraphtreediameterLayer, i : Int, v : Double) -> GraphtreediameterLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterLayer::sum(self : GraphtreediameterLayer) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterLayer::mean(self : GraphtreediameterLayer) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterLayer::scale(self : GraphtreediameterLayer, f : Double) -> GraphtreediameterLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterLayer::add(self : GraphtreediameterLayer, other : GraphtreediameterLayer) -> GraphtreediameterLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterLayer::copy(self : GraphtreediameterLayer) -> GraphtreediameterLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterLayer::fill(self : GraphtreediameterLayer, v : Double) -> GraphtreediameterLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterLayer::min(self : GraphtreediameterLayer) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterLayer::max(self : GraphtreediameterLayer) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterLayer::to_string(self : GraphtreediameterLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_buffer_make(size : Int) -> GraphtreediameterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterBuffer::len(self : GraphtreediameterBuffer) -> Int { self.size }

pub fn GraphtreediameterBuffer::get(self : GraphtreediameterBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterBuffer::set(self : GraphtreediameterBuffer, i : Int, v : Double) -> GraphtreediameterBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterBuffer::sum(self : GraphtreediameterBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterBuffer::mean(self : GraphtreediameterBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterBuffer::scale(self : GraphtreediameterBuffer, f : Double) -> GraphtreediameterBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterBuffer::add(self : GraphtreediameterBuffer, other : GraphtreediameterBuffer) -> GraphtreediameterBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterBuffer::copy(self : GraphtreediameterBuffer) -> GraphtreediameterBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterBuffer::fill(self : GraphtreediameterBuffer, v : Double) -> GraphtreediameterBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterBuffer::min(self : GraphtreediameterBuffer) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterBuffer::max(self : GraphtreediameterBuffer) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterBuffer::to_string(self : GraphtreediameterBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_cursor_make(size : Int) -> GraphtreediameterCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterCursor::len(self : GraphtreediameterCursor) -> Int { self.size }

pub fn GraphtreediameterCursor::get(self : GraphtreediameterCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterCursor::set(self : GraphtreediameterCursor, i : Int, v : Double) -> GraphtreediameterCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterCursor::sum(self : GraphtreediameterCursor) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterCursor::mean(self : GraphtreediameterCursor) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterCursor::scale(self : GraphtreediameterCursor, f : Double) -> GraphtreediameterCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterCursor::add(self : GraphtreediameterCursor, other : GraphtreediameterCursor) -> GraphtreediameterCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterCursor::copy(self : GraphtreediameterCursor) -> GraphtreediameterCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterCursor::fill(self : GraphtreediameterCursor, v : Double) -> GraphtreediameterCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterCursor::min(self : GraphtreediameterCursor) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterCursor::max(self : GraphtreediameterCursor) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterCursor::to_string(self : GraphtreediameterCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_view_make(size : Int) -> GraphtreediameterView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterView::len(self : GraphtreediameterView) -> Int { self.size }

pub fn GraphtreediameterView::get(self : GraphtreediameterView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterView::set(self : GraphtreediameterView, i : Int, v : Double) -> GraphtreediameterView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterView::sum(self : GraphtreediameterView) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterView::mean(self : GraphtreediameterView) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterView::scale(self : GraphtreediameterView, f : Double) -> GraphtreediameterView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterView::add(self : GraphtreediameterView, other : GraphtreediameterView) -> GraphtreediameterView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterView::copy(self : GraphtreediameterView) -> GraphtreediameterView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterView::fill(self : GraphtreediameterView, v : Double) -> GraphtreediameterView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterView::min(self : GraphtreediameterView) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterView::max(self : GraphtreediameterView) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterView::to_string(self : GraphtreediameterView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_range_make(size : Int) -> GraphtreediameterRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterRange::len(self : GraphtreediameterRange) -> Int { self.size }

pub fn GraphtreediameterRange::get(self : GraphtreediameterRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterRange::set(self : GraphtreediameterRange, i : Int, v : Double) -> GraphtreediameterRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterRange::sum(self : GraphtreediameterRange) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterRange::mean(self : GraphtreediameterRange) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterRange::scale(self : GraphtreediameterRange, f : Double) -> GraphtreediameterRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterRange::add(self : GraphtreediameterRange, other : GraphtreediameterRange) -> GraphtreediameterRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterRange::copy(self : GraphtreediameterRange) -> GraphtreediameterRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterRange::fill(self : GraphtreediameterRange, v : Double) -> GraphtreediameterRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterRange::min(self : GraphtreediameterRange) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterRange::max(self : GraphtreediameterRange) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterRange::to_string(self : GraphtreediameterRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_slice_make(size : Int) -> GraphtreediameterSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphtreediameterSlice::len(self : GraphtreediameterSlice) -> Int { self.size }

pub fn GraphtreediameterSlice::get(self : GraphtreediameterSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphtreediameterSlice::set(self : GraphtreediameterSlice, i : Int, v : Double) -> GraphtreediameterSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphtreediameterSlice::sum(self : GraphtreediameterSlice) -> Double { @_common.sum(self.data) }

pub fn GraphtreediameterSlice::mean(self : GraphtreediameterSlice) -> Double { @_common.mean(self.data) }

pub fn GraphtreediameterSlice::scale(self : GraphtreediameterSlice, f : Double) -> GraphtreediameterSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterSlice::add(self : GraphtreediameterSlice, other : GraphtreediameterSlice) -> GraphtreediameterSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphtreediameterSlice::copy(self : GraphtreediameterSlice) -> GraphtreediameterSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterSlice::fill(self : GraphtreediameterSlice, v : Double) -> GraphtreediameterSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphtreediameterSlice::min(self : GraphtreediameterSlice) -> Double { @_common.min(self.data) }

pub fn GraphtreediameterSlice::max(self : GraphtreediameterSlice) -> Double { @_common.max(self.data) }

pub fn GraphtreediameterSlice::to_string(self : GraphtreediameterSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

