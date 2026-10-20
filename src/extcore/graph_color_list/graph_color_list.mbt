///===
/// extcore/graph_color_list

pub(all) struct GraphcolorlistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_list_make_point(x : Double, y : Double) -> GraphcolorlistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_list_make_point3(x : Double, y : Double, z : Double) -> GraphcolorlistPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorlistPoint::x(self : GraphcolorlistPoint) -> Double { self.x }

pub fn GraphcolorlistPoint::y(self : GraphcolorlistPoint) -> Double { self.y }

pub fn GraphcolorlistPoint::z(self : GraphcolorlistPoint) -> Double { self.z }

pub fn GraphcolorlistPoint::label(self : GraphcolorlistPoint) -> Int { self.label }

pub fn GraphcolorlistPoint::dist(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorlistPoint::add(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorlistPoint::sub(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorlistPoint::scale(self : GraphcolorlistPoint, s : Double) -> GraphcolorlistPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorlistPoint::dot(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorlistPoint::cross(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorlistPoint::norm(self : GraphcolorlistPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorlistPoint::normalize(self : GraphcolorlistPoint) -> GraphcolorlistPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorlistPoint::negate(self : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorlistPoint::mid(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorlistPoint::lerp(self : GraphcolorlistPoint, other : GraphcolorlistPoint, t : Double) -> GraphcolorlistPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorlistPoint::to_string(self : GraphcolorlistPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorlistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_list_make_series(vals : Array[Double], name : String) -> GraphcolorlistSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorlistSeries::len(self : GraphcolorlistSeries) -> Int { self.vals.length() }

pub fn GraphcolorlistSeries::sum(self : GraphcolorlistSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorlistSeries::mean(self : GraphcolorlistSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorlistSeries::min(self : GraphcolorlistSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorlistSeries::max(self : GraphcolorlistSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorlistSeries::range(self : GraphcolorlistSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorlistSeries::variance(self : GraphcolorlistSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorlistSeries::std(self : GraphcolorlistSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorlistSeries::median(self : GraphcolorlistSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorlistSeries::scale(self : GraphcolorlistSeries, f : Double) -> GraphcolorlistSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorlistSeries::add(self : GraphcolorlistSeries, other : GraphcolorlistSeries) -> GraphcolorlistSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorlistSeries::sub(self : GraphcolorlistSeries, other : GraphcolorlistSeries) -> GraphcolorlistSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorlistSeries::normalize(self : GraphcolorlistSeries) -> GraphcolorlistSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorlistSeries::cumsum(self : GraphcolorlistSeries) -> GraphcolorlistSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorlistSeries::to_string(self : GraphcolorlistSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorlistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_list_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorlistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_list_matrix_identity(n : Int) -> GraphcolorlistMatrix {
  let m = graph_color_list_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorlistMatrix::get(self : GraphcolorlistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorlistMatrix::transpose(self : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  let result = graph_color_list_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorlistMatrix::add(self : GraphcolorlistMatrix, other : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorlistMatrix::scale(self : GraphcolorlistMatrix, s : Double) -> GraphcolorlistMatrix {
  let result = graph_color_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorlistMatrix::multiply(self : GraphcolorlistMatrix, other : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  if self.cols != other.rows { return graph_color_list_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_list_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphcolorlistMatrix::trace(self : GraphcolorlistMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorlistMatrix::det(self : GraphcolorlistMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorlistMatrix::norm(self : GraphcolorlistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorlistMatrix::to_string(self : GraphcolorlistMatrix) -> String {
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

pub(all) struct GraphcolorlistVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_list_make_vector(comps : Array[Double]) -> GraphcolorlistVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_list_vector_zero(dim : Int) -> GraphcolorlistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorlistVector::add(self : GraphcolorlistVector, other : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorlistVector::sub(self : GraphcolorlistVector, other : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorlistVector::scale(self : GraphcolorlistVector, s : Double) -> GraphcolorlistVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorlistVector::dot(self : GraphcolorlistVector, other : GraphcolorlistVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorlistVector::norm(self : GraphcolorlistVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorlistVector::normalize(self : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorlistVector::dist(self : GraphcolorlistVector, other : GraphcolorlistVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorlistVector::to_string(self : GraphcolorlistVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorlistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_frame_make(size : Int) -> GraphcolorlistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistFrame::len(self : GraphcolorlistFrame) -> Int { self.size }

pub fn GraphcolorlistFrame::get(self : GraphcolorlistFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistFrame::set(self : GraphcolorlistFrame, i : Int, v : Double) -> GraphcolorlistFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistFrame::sum(self : GraphcolorlistFrame) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistFrame::mean(self : GraphcolorlistFrame) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistFrame::scale(self : GraphcolorlistFrame, f : Double) -> GraphcolorlistFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistFrame::add(self : GraphcolorlistFrame, other : GraphcolorlistFrame) -> GraphcolorlistFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistFrame::copy(self : GraphcolorlistFrame) -> GraphcolorlistFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistFrame::fill(self : GraphcolorlistFrame, v : Double) -> GraphcolorlistFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistFrame::min(self : GraphcolorlistFrame) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistFrame::max(self : GraphcolorlistFrame) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistFrame::to_string(self : GraphcolorlistFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_table_make(size : Int) -> GraphcolorlistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistTable::len(self : GraphcolorlistTable) -> Int { self.size }

pub fn GraphcolorlistTable::get(self : GraphcolorlistTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistTable::set(self : GraphcolorlistTable, i : Int, v : Double) -> GraphcolorlistTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistTable::sum(self : GraphcolorlistTable) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistTable::mean(self : GraphcolorlistTable) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistTable::scale(self : GraphcolorlistTable, f : Double) -> GraphcolorlistTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistTable::add(self : GraphcolorlistTable, other : GraphcolorlistTable) -> GraphcolorlistTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistTable::copy(self : GraphcolorlistTable) -> GraphcolorlistTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistTable::fill(self : GraphcolorlistTable, v : Double) -> GraphcolorlistTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistTable::min(self : GraphcolorlistTable) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistTable::max(self : GraphcolorlistTable) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistTable::to_string(self : GraphcolorlistTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_graphn_make(size : Int) -> GraphcolorlistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistGraphN::len(self : GraphcolorlistGraphN) -> Int { self.size }

pub fn GraphcolorlistGraphN::get(self : GraphcolorlistGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistGraphN::set(self : GraphcolorlistGraphN, i : Int, v : Double) -> GraphcolorlistGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistGraphN::sum(self : GraphcolorlistGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistGraphN::mean(self : GraphcolorlistGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistGraphN::scale(self : GraphcolorlistGraphN, f : Double) -> GraphcolorlistGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistGraphN::add(self : GraphcolorlistGraphN, other : GraphcolorlistGraphN) -> GraphcolorlistGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistGraphN::copy(self : GraphcolorlistGraphN) -> GraphcolorlistGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistGraphN::fill(self : GraphcolorlistGraphN, v : Double) -> GraphcolorlistGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistGraphN::min(self : GraphcolorlistGraphN) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistGraphN::max(self : GraphcolorlistGraphN) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistGraphN::to_string(self : GraphcolorlistGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_node_make(size : Int) -> GraphcolorlistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistNode::len(self : GraphcolorlistNode) -> Int { self.size }

pub fn GraphcolorlistNode::get(self : GraphcolorlistNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistNode::set(self : GraphcolorlistNode, i : Int, v : Double) -> GraphcolorlistNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistNode::sum(self : GraphcolorlistNode) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistNode::mean(self : GraphcolorlistNode) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistNode::scale(self : GraphcolorlistNode, f : Double) -> GraphcolorlistNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistNode::add(self : GraphcolorlistNode, other : GraphcolorlistNode) -> GraphcolorlistNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistNode::copy(self : GraphcolorlistNode) -> GraphcolorlistNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistNode::fill(self : GraphcolorlistNode, v : Double) -> GraphcolorlistNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistNode::min(self : GraphcolorlistNode) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistNode::max(self : GraphcolorlistNode) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistNode::to_string(self : GraphcolorlistNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_edge_make(size : Int) -> GraphcolorlistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistEdge::len(self : GraphcolorlistEdge) -> Int { self.size }

pub fn GraphcolorlistEdge::get(self : GraphcolorlistEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistEdge::set(self : GraphcolorlistEdge, i : Int, v : Double) -> GraphcolorlistEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistEdge::sum(self : GraphcolorlistEdge) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistEdge::mean(self : GraphcolorlistEdge) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistEdge::scale(self : GraphcolorlistEdge, f : Double) -> GraphcolorlistEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistEdge::add(self : GraphcolorlistEdge, other : GraphcolorlistEdge) -> GraphcolorlistEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistEdge::copy(self : GraphcolorlistEdge) -> GraphcolorlistEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistEdge::fill(self : GraphcolorlistEdge, v : Double) -> GraphcolorlistEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistEdge::min(self : GraphcolorlistEdge) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistEdge::max(self : GraphcolorlistEdge) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistEdge::to_string(self : GraphcolorlistEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_path_make(size : Int) -> GraphcolorlistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistPath::len(self : GraphcolorlistPath) -> Int { self.size }

pub fn GraphcolorlistPath::get(self : GraphcolorlistPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistPath::set(self : GraphcolorlistPath, i : Int, v : Double) -> GraphcolorlistPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistPath::sum(self : GraphcolorlistPath) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistPath::mean(self : GraphcolorlistPath) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistPath::scale(self : GraphcolorlistPath, f : Double) -> GraphcolorlistPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistPath::add(self : GraphcolorlistPath, other : GraphcolorlistPath) -> GraphcolorlistPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistPath::copy(self : GraphcolorlistPath) -> GraphcolorlistPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistPath::fill(self : GraphcolorlistPath, v : Double) -> GraphcolorlistPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistPath::min(self : GraphcolorlistPath) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistPath::max(self : GraphcolorlistPath) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistPath::to_string(self : GraphcolorlistPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_cluster_make(size : Int) -> GraphcolorlistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistCluster::len(self : GraphcolorlistCluster) -> Int { self.size }

pub fn GraphcolorlistCluster::get(self : GraphcolorlistCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistCluster::set(self : GraphcolorlistCluster, i : Int, v : Double) -> GraphcolorlistCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistCluster::sum(self : GraphcolorlistCluster) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistCluster::mean(self : GraphcolorlistCluster) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistCluster::scale(self : GraphcolorlistCluster, f : Double) -> GraphcolorlistCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistCluster::add(self : GraphcolorlistCluster, other : GraphcolorlistCluster) -> GraphcolorlistCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistCluster::copy(self : GraphcolorlistCluster) -> GraphcolorlistCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistCluster::fill(self : GraphcolorlistCluster, v : Double) -> GraphcolorlistCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistCluster::min(self : GraphcolorlistCluster) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistCluster::max(self : GraphcolorlistCluster) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistCluster::to_string(self : GraphcolorlistCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_model_make(size : Int) -> GraphcolorlistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistModel::len(self : GraphcolorlistModel) -> Int { self.size }

pub fn GraphcolorlistModel::get(self : GraphcolorlistModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistModel::set(self : GraphcolorlistModel, i : Int, v : Double) -> GraphcolorlistModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistModel::sum(self : GraphcolorlistModel) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistModel::mean(self : GraphcolorlistModel) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistModel::scale(self : GraphcolorlistModel, f : Double) -> GraphcolorlistModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistModel::add(self : GraphcolorlistModel, other : GraphcolorlistModel) -> GraphcolorlistModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistModel::copy(self : GraphcolorlistModel) -> GraphcolorlistModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistModel::fill(self : GraphcolorlistModel, v : Double) -> GraphcolorlistModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistModel::min(self : GraphcolorlistModel) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistModel::max(self : GraphcolorlistModel) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistModel::to_string(self : GraphcolorlistModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_layer_make(size : Int) -> GraphcolorlistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistLayer::len(self : GraphcolorlistLayer) -> Int { self.size }

pub fn GraphcolorlistLayer::get(self : GraphcolorlistLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistLayer::set(self : GraphcolorlistLayer, i : Int, v : Double) -> GraphcolorlistLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistLayer::sum(self : GraphcolorlistLayer) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistLayer::mean(self : GraphcolorlistLayer) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistLayer::scale(self : GraphcolorlistLayer, f : Double) -> GraphcolorlistLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistLayer::add(self : GraphcolorlistLayer, other : GraphcolorlistLayer) -> GraphcolorlistLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistLayer::copy(self : GraphcolorlistLayer) -> GraphcolorlistLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistLayer::fill(self : GraphcolorlistLayer, v : Double) -> GraphcolorlistLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistLayer::min(self : GraphcolorlistLayer) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistLayer::max(self : GraphcolorlistLayer) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistLayer::to_string(self : GraphcolorlistLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_buffer_make(size : Int) -> GraphcolorlistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistBuffer::len(self : GraphcolorlistBuffer) -> Int { self.size }

pub fn GraphcolorlistBuffer::get(self : GraphcolorlistBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistBuffer::set(self : GraphcolorlistBuffer, i : Int, v : Double) -> GraphcolorlistBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistBuffer::sum(self : GraphcolorlistBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistBuffer::mean(self : GraphcolorlistBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistBuffer::scale(self : GraphcolorlistBuffer, f : Double) -> GraphcolorlistBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistBuffer::add(self : GraphcolorlistBuffer, other : GraphcolorlistBuffer) -> GraphcolorlistBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistBuffer::copy(self : GraphcolorlistBuffer) -> GraphcolorlistBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistBuffer::fill(self : GraphcolorlistBuffer, v : Double) -> GraphcolorlistBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistBuffer::min(self : GraphcolorlistBuffer) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistBuffer::max(self : GraphcolorlistBuffer) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistBuffer::to_string(self : GraphcolorlistBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_cursor_make(size : Int) -> GraphcolorlistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistCursor::len(self : GraphcolorlistCursor) -> Int { self.size }

pub fn GraphcolorlistCursor::get(self : GraphcolorlistCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistCursor::set(self : GraphcolorlistCursor, i : Int, v : Double) -> GraphcolorlistCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistCursor::sum(self : GraphcolorlistCursor) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistCursor::mean(self : GraphcolorlistCursor) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistCursor::scale(self : GraphcolorlistCursor, f : Double) -> GraphcolorlistCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistCursor::add(self : GraphcolorlistCursor, other : GraphcolorlistCursor) -> GraphcolorlistCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistCursor::copy(self : GraphcolorlistCursor) -> GraphcolorlistCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistCursor::fill(self : GraphcolorlistCursor, v : Double) -> GraphcolorlistCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistCursor::min(self : GraphcolorlistCursor) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistCursor::max(self : GraphcolorlistCursor) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistCursor::to_string(self : GraphcolorlistCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_view_make(size : Int) -> GraphcolorlistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistView::len(self : GraphcolorlistView) -> Int { self.size }

pub fn GraphcolorlistView::get(self : GraphcolorlistView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistView::set(self : GraphcolorlistView, i : Int, v : Double) -> GraphcolorlistView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistView::sum(self : GraphcolorlistView) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistView::mean(self : GraphcolorlistView) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistView::scale(self : GraphcolorlistView, f : Double) -> GraphcolorlistView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistView::add(self : GraphcolorlistView, other : GraphcolorlistView) -> GraphcolorlistView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistView::copy(self : GraphcolorlistView) -> GraphcolorlistView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistView::fill(self : GraphcolorlistView, v : Double) -> GraphcolorlistView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistView::min(self : GraphcolorlistView) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistView::max(self : GraphcolorlistView) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistView::to_string(self : GraphcolorlistView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_range_make(size : Int) -> GraphcolorlistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistRange::len(self : GraphcolorlistRange) -> Int { self.size }

pub fn GraphcolorlistRange::get(self : GraphcolorlistRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistRange::set(self : GraphcolorlistRange, i : Int, v : Double) -> GraphcolorlistRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistRange::sum(self : GraphcolorlistRange) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistRange::mean(self : GraphcolorlistRange) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistRange::scale(self : GraphcolorlistRange, f : Double) -> GraphcolorlistRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistRange::add(self : GraphcolorlistRange, other : GraphcolorlistRange) -> GraphcolorlistRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistRange::copy(self : GraphcolorlistRange) -> GraphcolorlistRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistRange::fill(self : GraphcolorlistRange, v : Double) -> GraphcolorlistRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistRange::min(self : GraphcolorlistRange) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistRange::max(self : GraphcolorlistRange) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistRange::to_string(self : GraphcolorlistRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_slice_make(size : Int) -> GraphcolorlistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorlistSlice::len(self : GraphcolorlistSlice) -> Int { self.size }

pub fn GraphcolorlistSlice::get(self : GraphcolorlistSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorlistSlice::set(self : GraphcolorlistSlice, i : Int, v : Double) -> GraphcolorlistSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorlistSlice::sum(self : GraphcolorlistSlice) -> Double { @_common.sum(self.data) }

pub fn GraphcolorlistSlice::mean(self : GraphcolorlistSlice) -> Double { @_common.mean(self.data) }

pub fn GraphcolorlistSlice::scale(self : GraphcolorlistSlice, f : Double) -> GraphcolorlistSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistSlice::add(self : GraphcolorlistSlice, other : GraphcolorlistSlice) -> GraphcolorlistSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorlistSlice::copy(self : GraphcolorlistSlice) -> GraphcolorlistSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistSlice::fill(self : GraphcolorlistSlice, v : Double) -> GraphcolorlistSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorlistSlice::min(self : GraphcolorlistSlice) -> Double { @_common.min(self.data) }

pub fn GraphcolorlistSlice::max(self : GraphcolorlistSlice) -> Double { @_common.max(self.data) }

pub fn GraphcolorlistSlice::to_string(self : GraphcolorlistSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

