///===
/// extcore/graph_color_dsatur

pub(all) struct GraphcolordsaturPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_dsatur_make_point(x : Double, y : Double) -> GraphcolordsaturPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_dsatur_make_point3(x : Double, y : Double, z : Double) -> GraphcolordsaturPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolordsaturPoint::x(self : GraphcolordsaturPoint) -> Double { self.x }

pub fn GraphcolordsaturPoint::y(self : GraphcolordsaturPoint) -> Double { self.y }

pub fn GraphcolordsaturPoint::z(self : GraphcolordsaturPoint) -> Double { self.z }

pub fn GraphcolordsaturPoint::label(self : GraphcolordsaturPoint) -> Int { self.label }

pub fn GraphcolordsaturPoint::dist(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolordsaturPoint::add(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolordsaturPoint::sub(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolordsaturPoint::scale(self : GraphcolordsaturPoint, s : Double) -> GraphcolordsaturPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolordsaturPoint::dot(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolordsaturPoint::cross(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolordsaturPoint::norm(self : GraphcolordsaturPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolordsaturPoint::normalize(self : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolordsaturPoint::negate(self : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolordsaturPoint::mid(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolordsaturPoint::lerp(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint, t : Double) -> GraphcolordsaturPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolordsaturPoint::to_string(self : GraphcolordsaturPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolordsaturSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_dsatur_make_series(vals : Array[Double], name : String) -> GraphcolordsaturSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolordsaturSeries::len(self : GraphcolordsaturSeries) -> Int { self.vals.length() }

pub fn GraphcolordsaturSeries::sum(self : GraphcolordsaturSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolordsaturSeries::mean(self : GraphcolordsaturSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolordsaturSeries::min(self : GraphcolordsaturSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolordsaturSeries::max(self : GraphcolordsaturSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolordsaturSeries::range(self : GraphcolordsaturSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolordsaturSeries::variance(self : GraphcolordsaturSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolordsaturSeries::std(self : GraphcolordsaturSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolordsaturSeries::median(self : GraphcolordsaturSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolordsaturSeries::scale(self : GraphcolordsaturSeries, f : Double) -> GraphcolordsaturSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolordsaturSeries::add(self : GraphcolordsaturSeries, other : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolordsaturSeries::sub(self : GraphcolordsaturSeries, other : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolordsaturSeries::normalize(self : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolordsaturSeries::cumsum(self : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolordsaturSeries::to_string(self : GraphcolordsaturSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolordsaturMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_dsatur_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolordsaturMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_dsatur_matrix_identity(n : Int) -> GraphcolordsaturMatrix {
  let m = graph_color_dsatur_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolordsaturMatrix::get(self : GraphcolordsaturMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolordsaturMatrix::transpose(self : GraphcolordsaturMatrix) -> GraphcolordsaturMatrix {
  let result = graph_color_dsatur_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolordsaturMatrix::add(self : GraphcolordsaturMatrix, other : GraphcolordsaturMatrix) -> GraphcolordsaturMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_dsatur_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolordsaturMatrix::scale(self : GraphcolordsaturMatrix, s : Double) -> GraphcolordsaturMatrix {
  let result = graph_color_dsatur_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolordsaturMatrix::multiply(self : GraphcolordsaturMatrix, other : GraphcolordsaturMatrix) -> GraphcolordsaturMatrix {
  if self.cols != other.rows { return graph_color_dsatur_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_dsatur_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphcolordsaturMatrix::trace(self : GraphcolordsaturMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolordsaturMatrix::det(self : GraphcolordsaturMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolordsaturMatrix::norm(self : GraphcolordsaturMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolordsaturMatrix::to_string(self : GraphcolordsaturMatrix) -> String {
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

pub(all) struct GraphcolordsaturVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_dsatur_make_vector(comps : Array[Double]) -> GraphcolordsaturVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_dsatur_vector_zero(dim : Int) -> GraphcolordsaturVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolordsaturVector::add(self : GraphcolordsaturVector, other : GraphcolordsaturVector) -> GraphcolordsaturVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolordsaturVector::sub(self : GraphcolordsaturVector, other : GraphcolordsaturVector) -> GraphcolordsaturVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolordsaturVector::scale(self : GraphcolordsaturVector, s : Double) -> GraphcolordsaturVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolordsaturVector::dot(self : GraphcolordsaturVector, other : GraphcolordsaturVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolordsaturVector::norm(self : GraphcolordsaturVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolordsaturVector::normalize(self : GraphcolordsaturVector) -> GraphcolordsaturVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolordsaturVector::dist(self : GraphcolordsaturVector, other : GraphcolordsaturVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolordsaturVector::to_string(self : GraphcolordsaturVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolordsaturFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_frame_make(size : Int) -> GraphcolordsaturFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturFrame::len(self : GraphcolordsaturFrame) -> Int { self.size }

pub fn GraphcolordsaturFrame::get(self : GraphcolordsaturFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturFrame::set(self : GraphcolordsaturFrame, i : Int, v : Double) -> GraphcolordsaturFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturFrame::sum(self : GraphcolordsaturFrame) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturFrame::mean(self : GraphcolordsaturFrame) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturFrame::scale(self : GraphcolordsaturFrame, f : Double) -> GraphcolordsaturFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturFrame::add(self : GraphcolordsaturFrame, other : GraphcolordsaturFrame) -> GraphcolordsaturFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturFrame::copy(self : GraphcolordsaturFrame) -> GraphcolordsaturFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturFrame::fill(self : GraphcolordsaturFrame, v : Double) -> GraphcolordsaturFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturFrame::min(self : GraphcolordsaturFrame) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturFrame::max(self : GraphcolordsaturFrame) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturFrame::to_string(self : GraphcolordsaturFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_table_make(size : Int) -> GraphcolordsaturTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturTable::len(self : GraphcolordsaturTable) -> Int { self.size }

pub fn GraphcolordsaturTable::get(self : GraphcolordsaturTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturTable::set(self : GraphcolordsaturTable, i : Int, v : Double) -> GraphcolordsaturTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturTable::sum(self : GraphcolordsaturTable) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturTable::mean(self : GraphcolordsaturTable) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturTable::scale(self : GraphcolordsaturTable, f : Double) -> GraphcolordsaturTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturTable::add(self : GraphcolordsaturTable, other : GraphcolordsaturTable) -> GraphcolordsaturTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturTable::copy(self : GraphcolordsaturTable) -> GraphcolordsaturTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturTable::fill(self : GraphcolordsaturTable, v : Double) -> GraphcolordsaturTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturTable::min(self : GraphcolordsaturTable) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturTable::max(self : GraphcolordsaturTable) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturTable::to_string(self : GraphcolordsaturTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_graphn_make(size : Int) -> GraphcolordsaturGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturGraphN::len(self : GraphcolordsaturGraphN) -> Int { self.size }

pub fn GraphcolordsaturGraphN::get(self : GraphcolordsaturGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturGraphN::set(self : GraphcolordsaturGraphN, i : Int, v : Double) -> GraphcolordsaturGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturGraphN::sum(self : GraphcolordsaturGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturGraphN::mean(self : GraphcolordsaturGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturGraphN::scale(self : GraphcolordsaturGraphN, f : Double) -> GraphcolordsaturGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturGraphN::add(self : GraphcolordsaturGraphN, other : GraphcolordsaturGraphN) -> GraphcolordsaturGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturGraphN::copy(self : GraphcolordsaturGraphN) -> GraphcolordsaturGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturGraphN::fill(self : GraphcolordsaturGraphN, v : Double) -> GraphcolordsaturGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturGraphN::min(self : GraphcolordsaturGraphN) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturGraphN::max(self : GraphcolordsaturGraphN) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturGraphN::to_string(self : GraphcolordsaturGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_node_make(size : Int) -> GraphcolordsaturNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturNode::len(self : GraphcolordsaturNode) -> Int { self.size }

pub fn GraphcolordsaturNode::get(self : GraphcolordsaturNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturNode::set(self : GraphcolordsaturNode, i : Int, v : Double) -> GraphcolordsaturNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturNode::sum(self : GraphcolordsaturNode) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturNode::mean(self : GraphcolordsaturNode) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturNode::scale(self : GraphcolordsaturNode, f : Double) -> GraphcolordsaturNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturNode::add(self : GraphcolordsaturNode, other : GraphcolordsaturNode) -> GraphcolordsaturNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturNode::copy(self : GraphcolordsaturNode) -> GraphcolordsaturNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturNode::fill(self : GraphcolordsaturNode, v : Double) -> GraphcolordsaturNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturNode::min(self : GraphcolordsaturNode) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturNode::max(self : GraphcolordsaturNode) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturNode::to_string(self : GraphcolordsaturNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_edge_make(size : Int) -> GraphcolordsaturEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturEdge::len(self : GraphcolordsaturEdge) -> Int { self.size }

pub fn GraphcolordsaturEdge::get(self : GraphcolordsaturEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturEdge::set(self : GraphcolordsaturEdge, i : Int, v : Double) -> GraphcolordsaturEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturEdge::sum(self : GraphcolordsaturEdge) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturEdge::mean(self : GraphcolordsaturEdge) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturEdge::scale(self : GraphcolordsaturEdge, f : Double) -> GraphcolordsaturEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturEdge::add(self : GraphcolordsaturEdge, other : GraphcolordsaturEdge) -> GraphcolordsaturEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturEdge::copy(self : GraphcolordsaturEdge) -> GraphcolordsaturEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturEdge::fill(self : GraphcolordsaturEdge, v : Double) -> GraphcolordsaturEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturEdge::min(self : GraphcolordsaturEdge) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturEdge::max(self : GraphcolordsaturEdge) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturEdge::to_string(self : GraphcolordsaturEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_path_make(size : Int) -> GraphcolordsaturPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturPath::len(self : GraphcolordsaturPath) -> Int { self.size }

pub fn GraphcolordsaturPath::get(self : GraphcolordsaturPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturPath::set(self : GraphcolordsaturPath, i : Int, v : Double) -> GraphcolordsaturPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturPath::sum(self : GraphcolordsaturPath) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturPath::mean(self : GraphcolordsaturPath) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturPath::scale(self : GraphcolordsaturPath, f : Double) -> GraphcolordsaturPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturPath::add(self : GraphcolordsaturPath, other : GraphcolordsaturPath) -> GraphcolordsaturPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturPath::copy(self : GraphcolordsaturPath) -> GraphcolordsaturPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturPath::fill(self : GraphcolordsaturPath, v : Double) -> GraphcolordsaturPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturPath::min(self : GraphcolordsaturPath) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturPath::max(self : GraphcolordsaturPath) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturPath::to_string(self : GraphcolordsaturPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_cluster_make(size : Int) -> GraphcolordsaturCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturCluster::len(self : GraphcolordsaturCluster) -> Int { self.size }

pub fn GraphcolordsaturCluster::get(self : GraphcolordsaturCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturCluster::set(self : GraphcolordsaturCluster, i : Int, v : Double) -> GraphcolordsaturCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturCluster::sum(self : GraphcolordsaturCluster) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturCluster::mean(self : GraphcolordsaturCluster) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturCluster::scale(self : GraphcolordsaturCluster, f : Double) -> GraphcolordsaturCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturCluster::add(self : GraphcolordsaturCluster, other : GraphcolordsaturCluster) -> GraphcolordsaturCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturCluster::copy(self : GraphcolordsaturCluster) -> GraphcolordsaturCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturCluster::fill(self : GraphcolordsaturCluster, v : Double) -> GraphcolordsaturCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturCluster::min(self : GraphcolordsaturCluster) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturCluster::max(self : GraphcolordsaturCluster) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturCluster::to_string(self : GraphcolordsaturCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_model_make(size : Int) -> GraphcolordsaturModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturModel::len(self : GraphcolordsaturModel) -> Int { self.size }

pub fn GraphcolordsaturModel::get(self : GraphcolordsaturModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturModel::set(self : GraphcolordsaturModel, i : Int, v : Double) -> GraphcolordsaturModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturModel::sum(self : GraphcolordsaturModel) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturModel::mean(self : GraphcolordsaturModel) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturModel::scale(self : GraphcolordsaturModel, f : Double) -> GraphcolordsaturModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturModel::add(self : GraphcolordsaturModel, other : GraphcolordsaturModel) -> GraphcolordsaturModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturModel::copy(self : GraphcolordsaturModel) -> GraphcolordsaturModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturModel::fill(self : GraphcolordsaturModel, v : Double) -> GraphcolordsaturModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturModel::min(self : GraphcolordsaturModel) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturModel::max(self : GraphcolordsaturModel) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturModel::to_string(self : GraphcolordsaturModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_layer_make(size : Int) -> GraphcolordsaturLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturLayer::len(self : GraphcolordsaturLayer) -> Int { self.size }

pub fn GraphcolordsaturLayer::get(self : GraphcolordsaturLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturLayer::set(self : GraphcolordsaturLayer, i : Int, v : Double) -> GraphcolordsaturLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturLayer::sum(self : GraphcolordsaturLayer) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturLayer::mean(self : GraphcolordsaturLayer) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturLayer::scale(self : GraphcolordsaturLayer, f : Double) -> GraphcolordsaturLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturLayer::add(self : GraphcolordsaturLayer, other : GraphcolordsaturLayer) -> GraphcolordsaturLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturLayer::copy(self : GraphcolordsaturLayer) -> GraphcolordsaturLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturLayer::fill(self : GraphcolordsaturLayer, v : Double) -> GraphcolordsaturLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturLayer::min(self : GraphcolordsaturLayer) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturLayer::max(self : GraphcolordsaturLayer) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturLayer::to_string(self : GraphcolordsaturLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_buffer_make(size : Int) -> GraphcolordsaturBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturBuffer::len(self : GraphcolordsaturBuffer) -> Int { self.size }

pub fn GraphcolordsaturBuffer::get(self : GraphcolordsaturBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturBuffer::set(self : GraphcolordsaturBuffer, i : Int, v : Double) -> GraphcolordsaturBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturBuffer::sum(self : GraphcolordsaturBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturBuffer::mean(self : GraphcolordsaturBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturBuffer::scale(self : GraphcolordsaturBuffer, f : Double) -> GraphcolordsaturBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturBuffer::add(self : GraphcolordsaturBuffer, other : GraphcolordsaturBuffer) -> GraphcolordsaturBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturBuffer::copy(self : GraphcolordsaturBuffer) -> GraphcolordsaturBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturBuffer::fill(self : GraphcolordsaturBuffer, v : Double) -> GraphcolordsaturBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturBuffer::min(self : GraphcolordsaturBuffer) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturBuffer::max(self : GraphcolordsaturBuffer) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturBuffer::to_string(self : GraphcolordsaturBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_cursor_make(size : Int) -> GraphcolordsaturCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturCursor::len(self : GraphcolordsaturCursor) -> Int { self.size }

pub fn GraphcolordsaturCursor::get(self : GraphcolordsaturCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturCursor::set(self : GraphcolordsaturCursor, i : Int, v : Double) -> GraphcolordsaturCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturCursor::sum(self : GraphcolordsaturCursor) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturCursor::mean(self : GraphcolordsaturCursor) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturCursor::scale(self : GraphcolordsaturCursor, f : Double) -> GraphcolordsaturCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturCursor::add(self : GraphcolordsaturCursor, other : GraphcolordsaturCursor) -> GraphcolordsaturCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturCursor::copy(self : GraphcolordsaturCursor) -> GraphcolordsaturCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturCursor::fill(self : GraphcolordsaturCursor, v : Double) -> GraphcolordsaturCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturCursor::min(self : GraphcolordsaturCursor) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturCursor::max(self : GraphcolordsaturCursor) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturCursor::to_string(self : GraphcolordsaturCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_view_make(size : Int) -> GraphcolordsaturView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturView::len(self : GraphcolordsaturView) -> Int { self.size }

pub fn GraphcolordsaturView::get(self : GraphcolordsaturView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturView::set(self : GraphcolordsaturView, i : Int, v : Double) -> GraphcolordsaturView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturView::sum(self : GraphcolordsaturView) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturView::mean(self : GraphcolordsaturView) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturView::scale(self : GraphcolordsaturView, f : Double) -> GraphcolordsaturView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturView::add(self : GraphcolordsaturView, other : GraphcolordsaturView) -> GraphcolordsaturView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturView::copy(self : GraphcolordsaturView) -> GraphcolordsaturView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturView::fill(self : GraphcolordsaturView, v : Double) -> GraphcolordsaturView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturView::min(self : GraphcolordsaturView) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturView::max(self : GraphcolordsaturView) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturView::to_string(self : GraphcolordsaturView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_range_make(size : Int) -> GraphcolordsaturRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturRange::len(self : GraphcolordsaturRange) -> Int { self.size }

pub fn GraphcolordsaturRange::get(self : GraphcolordsaturRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturRange::set(self : GraphcolordsaturRange, i : Int, v : Double) -> GraphcolordsaturRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturRange::sum(self : GraphcolordsaturRange) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturRange::mean(self : GraphcolordsaturRange) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturRange::scale(self : GraphcolordsaturRange, f : Double) -> GraphcolordsaturRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturRange::add(self : GraphcolordsaturRange, other : GraphcolordsaturRange) -> GraphcolordsaturRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturRange::copy(self : GraphcolordsaturRange) -> GraphcolordsaturRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturRange::fill(self : GraphcolordsaturRange, v : Double) -> GraphcolordsaturRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturRange::min(self : GraphcolordsaturRange) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturRange::max(self : GraphcolordsaturRange) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturRange::to_string(self : GraphcolordsaturRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_slice_make(size : Int) -> GraphcolordsaturSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolordsaturSlice::len(self : GraphcolordsaturSlice) -> Int { self.size }

pub fn GraphcolordsaturSlice::get(self : GraphcolordsaturSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolordsaturSlice::set(self : GraphcolordsaturSlice, i : Int, v : Double) -> GraphcolordsaturSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturSlice::sum(self : GraphcolordsaturSlice) -> Double { @_common.sum(self.data) }

pub fn GraphcolordsaturSlice::mean(self : GraphcolordsaturSlice) -> Double { @_common.mean(self.data) }

pub fn GraphcolordsaturSlice::scale(self : GraphcolordsaturSlice, f : Double) -> GraphcolordsaturSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturSlice::add(self : GraphcolordsaturSlice, other : GraphcolordsaturSlice) -> GraphcolordsaturSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolordsaturSlice::copy(self : GraphcolordsaturSlice) -> GraphcolordsaturSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturSlice::fill(self : GraphcolordsaturSlice, v : Double) -> GraphcolordsaturSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolordsaturSlice::min(self : GraphcolordsaturSlice) -> Double { @_common.min(self.data) }

pub fn GraphcolordsaturSlice::max(self : GraphcolordsaturSlice) -> Double { @_common.max(self.data) }

pub fn GraphcolordsaturSlice::to_string(self : GraphcolordsaturSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

