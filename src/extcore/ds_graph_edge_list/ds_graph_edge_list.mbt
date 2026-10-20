///===
/// extcore/ds_graph_edge_list

pub(all) struct DsgraphedgelistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_edge_list_make_point(x : Double, y : Double) -> DsgraphedgelistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_edge_list_make_point3(x : Double, y : Double, z : Double) -> DsgraphedgelistPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphedgelistPoint::x(self : DsgraphedgelistPoint) -> Double { self.x }

pub fn DsgraphedgelistPoint::y(self : DsgraphedgelistPoint) -> Double { self.y }

pub fn DsgraphedgelistPoint::z(self : DsgraphedgelistPoint) -> Double { self.z }

pub fn DsgraphedgelistPoint::label(self : DsgraphedgelistPoint) -> Int { self.label }

pub fn DsgraphedgelistPoint::dist(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphedgelistPoint::add(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphedgelistPoint::sub(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphedgelistPoint::scale(self : DsgraphedgelistPoint, s : Double) -> DsgraphedgelistPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphedgelistPoint::dot(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphedgelistPoint::cross(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphedgelistPoint::norm(self : DsgraphedgelistPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphedgelistPoint::normalize(self : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphedgelistPoint::negate(self : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphedgelistPoint::mid(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphedgelistPoint::lerp(self : DsgraphedgelistPoint, other : DsgraphedgelistPoint, t : Double) -> DsgraphedgelistPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphedgelistPoint::to_string(self : DsgraphedgelistPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphedgelistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_edge_list_make_series(vals : Array[Double], name : String) -> DsgraphedgelistSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphedgelistSeries::len(self : DsgraphedgelistSeries) -> Int { self.vals.length() }

pub fn DsgraphedgelistSeries::sum(self : DsgraphedgelistSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphedgelistSeries::mean(self : DsgraphedgelistSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphedgelistSeries::min(self : DsgraphedgelistSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphedgelistSeries::max(self : DsgraphedgelistSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphedgelistSeries::range(self : DsgraphedgelistSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphedgelistSeries::variance(self : DsgraphedgelistSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphedgelistSeries::std(self : DsgraphedgelistSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphedgelistSeries::median(self : DsgraphedgelistSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphedgelistSeries::scale(self : DsgraphedgelistSeries, f : Double) -> DsgraphedgelistSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphedgelistSeries::add(self : DsgraphedgelistSeries, other : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphedgelistSeries::sub(self : DsgraphedgelistSeries, other : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphedgelistSeries::normalize(self : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphedgelistSeries::cumsum(self : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphedgelistSeries::to_string(self : DsgraphedgelistSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphedgelistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_edge_list_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphedgelistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_edge_list_matrix_identity(n : Int) -> DsgraphedgelistMatrix {
  let m = ds_graph_edge_list_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphedgelistMatrix::get(self : DsgraphedgelistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphedgelistMatrix::transpose(self : DsgraphedgelistMatrix) -> DsgraphedgelistMatrix {
  let result = ds_graph_edge_list_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphedgelistMatrix::add(self : DsgraphedgelistMatrix, other : DsgraphedgelistMatrix) -> DsgraphedgelistMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_edge_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphedgelistMatrix::scale(self : DsgraphedgelistMatrix, s : Double) -> DsgraphedgelistMatrix {
  let result = ds_graph_edge_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphedgelistMatrix::multiply(self : DsgraphedgelistMatrix, other : DsgraphedgelistMatrix) -> DsgraphedgelistMatrix {
  if self.cols != other.rows { return ds_graph_edge_list_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_edge_list_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DsgraphedgelistMatrix::trace(self : DsgraphedgelistMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphedgelistMatrix::det(self : DsgraphedgelistMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphedgelistMatrix::norm(self : DsgraphedgelistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphedgelistMatrix::to_string(self : DsgraphedgelistMatrix) -> String {
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

pub(all) struct DsgraphedgelistVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_edge_list_make_vector(comps : Array[Double]) -> DsgraphedgelistVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_edge_list_vector_zero(dim : Int) -> DsgraphedgelistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphedgelistVector::add(self : DsgraphedgelistVector, other : DsgraphedgelistVector) -> DsgraphedgelistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphedgelistVector::sub(self : DsgraphedgelistVector, other : DsgraphedgelistVector) -> DsgraphedgelistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphedgelistVector::scale(self : DsgraphedgelistVector, s : Double) -> DsgraphedgelistVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphedgelistVector::dot(self : DsgraphedgelistVector, other : DsgraphedgelistVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphedgelistVector::norm(self : DsgraphedgelistVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphedgelistVector::normalize(self : DsgraphedgelistVector) -> DsgraphedgelistVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphedgelistVector::dist(self : DsgraphedgelistVector, other : DsgraphedgelistVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphedgelistVector::to_string(self : DsgraphedgelistVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphedgelistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_frame_make(size : Int) -> DsgraphedgelistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistFrame::len(self : DsgraphedgelistFrame) -> Int { self.size }

pub fn DsgraphedgelistFrame::get(self : DsgraphedgelistFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistFrame::set(self : DsgraphedgelistFrame, i : Int, v : Double) -> DsgraphedgelistFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistFrame::sum(self : DsgraphedgelistFrame) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistFrame::mean(self : DsgraphedgelistFrame) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistFrame::scale(self : DsgraphedgelistFrame, f : Double) -> DsgraphedgelistFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistFrame::add(self : DsgraphedgelistFrame, other : DsgraphedgelistFrame) -> DsgraphedgelistFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistFrame::copy(self : DsgraphedgelistFrame) -> DsgraphedgelistFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistFrame::fill(self : DsgraphedgelistFrame, v : Double) -> DsgraphedgelistFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistFrame::min(self : DsgraphedgelistFrame) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistFrame::max(self : DsgraphedgelistFrame) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistFrame::to_string(self : DsgraphedgelistFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_table_make(size : Int) -> DsgraphedgelistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistTable::len(self : DsgraphedgelistTable) -> Int { self.size }

pub fn DsgraphedgelistTable::get(self : DsgraphedgelistTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistTable::set(self : DsgraphedgelistTable, i : Int, v : Double) -> DsgraphedgelistTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistTable::sum(self : DsgraphedgelistTable) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistTable::mean(self : DsgraphedgelistTable) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistTable::scale(self : DsgraphedgelistTable, f : Double) -> DsgraphedgelistTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistTable::add(self : DsgraphedgelistTable, other : DsgraphedgelistTable) -> DsgraphedgelistTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistTable::copy(self : DsgraphedgelistTable) -> DsgraphedgelistTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistTable::fill(self : DsgraphedgelistTable, v : Double) -> DsgraphedgelistTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistTable::min(self : DsgraphedgelistTable) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistTable::max(self : DsgraphedgelistTable) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistTable::to_string(self : DsgraphedgelistTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_graphn_make(size : Int) -> DsgraphedgelistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistGraphN::len(self : DsgraphedgelistGraphN) -> Int { self.size }

pub fn DsgraphedgelistGraphN::get(self : DsgraphedgelistGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistGraphN::set(self : DsgraphedgelistGraphN, i : Int, v : Double) -> DsgraphedgelistGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistGraphN::sum(self : DsgraphedgelistGraphN) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistGraphN::mean(self : DsgraphedgelistGraphN) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistGraphN::scale(self : DsgraphedgelistGraphN, f : Double) -> DsgraphedgelistGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistGraphN::add(self : DsgraphedgelistGraphN, other : DsgraphedgelistGraphN) -> DsgraphedgelistGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistGraphN::copy(self : DsgraphedgelistGraphN) -> DsgraphedgelistGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistGraphN::fill(self : DsgraphedgelistGraphN, v : Double) -> DsgraphedgelistGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistGraphN::min(self : DsgraphedgelistGraphN) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistGraphN::max(self : DsgraphedgelistGraphN) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistGraphN::to_string(self : DsgraphedgelistGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_node_make(size : Int) -> DsgraphedgelistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistNode::len(self : DsgraphedgelistNode) -> Int { self.size }

pub fn DsgraphedgelistNode::get(self : DsgraphedgelistNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistNode::set(self : DsgraphedgelistNode, i : Int, v : Double) -> DsgraphedgelistNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistNode::sum(self : DsgraphedgelistNode) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistNode::mean(self : DsgraphedgelistNode) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistNode::scale(self : DsgraphedgelistNode, f : Double) -> DsgraphedgelistNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistNode::add(self : DsgraphedgelistNode, other : DsgraphedgelistNode) -> DsgraphedgelistNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistNode::copy(self : DsgraphedgelistNode) -> DsgraphedgelistNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistNode::fill(self : DsgraphedgelistNode, v : Double) -> DsgraphedgelistNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistNode::min(self : DsgraphedgelistNode) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistNode::max(self : DsgraphedgelistNode) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistNode::to_string(self : DsgraphedgelistNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_edge_make(size : Int) -> DsgraphedgelistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistEdge::len(self : DsgraphedgelistEdge) -> Int { self.size }

pub fn DsgraphedgelistEdge::get(self : DsgraphedgelistEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistEdge::set(self : DsgraphedgelistEdge, i : Int, v : Double) -> DsgraphedgelistEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistEdge::sum(self : DsgraphedgelistEdge) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistEdge::mean(self : DsgraphedgelistEdge) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistEdge::scale(self : DsgraphedgelistEdge, f : Double) -> DsgraphedgelistEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistEdge::add(self : DsgraphedgelistEdge, other : DsgraphedgelistEdge) -> DsgraphedgelistEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistEdge::copy(self : DsgraphedgelistEdge) -> DsgraphedgelistEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistEdge::fill(self : DsgraphedgelistEdge, v : Double) -> DsgraphedgelistEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistEdge::min(self : DsgraphedgelistEdge) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistEdge::max(self : DsgraphedgelistEdge) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistEdge::to_string(self : DsgraphedgelistEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_path_make(size : Int) -> DsgraphedgelistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistPath::len(self : DsgraphedgelistPath) -> Int { self.size }

pub fn DsgraphedgelistPath::get(self : DsgraphedgelistPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistPath::set(self : DsgraphedgelistPath, i : Int, v : Double) -> DsgraphedgelistPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistPath::sum(self : DsgraphedgelistPath) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistPath::mean(self : DsgraphedgelistPath) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistPath::scale(self : DsgraphedgelistPath, f : Double) -> DsgraphedgelistPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistPath::add(self : DsgraphedgelistPath, other : DsgraphedgelistPath) -> DsgraphedgelistPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistPath::copy(self : DsgraphedgelistPath) -> DsgraphedgelistPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistPath::fill(self : DsgraphedgelistPath, v : Double) -> DsgraphedgelistPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistPath::min(self : DsgraphedgelistPath) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistPath::max(self : DsgraphedgelistPath) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistPath::to_string(self : DsgraphedgelistPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_cluster_make(size : Int) -> DsgraphedgelistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistCluster::len(self : DsgraphedgelistCluster) -> Int { self.size }

pub fn DsgraphedgelistCluster::get(self : DsgraphedgelistCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistCluster::set(self : DsgraphedgelistCluster, i : Int, v : Double) -> DsgraphedgelistCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistCluster::sum(self : DsgraphedgelistCluster) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistCluster::mean(self : DsgraphedgelistCluster) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistCluster::scale(self : DsgraphedgelistCluster, f : Double) -> DsgraphedgelistCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistCluster::add(self : DsgraphedgelistCluster, other : DsgraphedgelistCluster) -> DsgraphedgelistCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistCluster::copy(self : DsgraphedgelistCluster) -> DsgraphedgelistCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistCluster::fill(self : DsgraphedgelistCluster, v : Double) -> DsgraphedgelistCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistCluster::min(self : DsgraphedgelistCluster) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistCluster::max(self : DsgraphedgelistCluster) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistCluster::to_string(self : DsgraphedgelistCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_model_make(size : Int) -> DsgraphedgelistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistModel::len(self : DsgraphedgelistModel) -> Int { self.size }

pub fn DsgraphedgelistModel::get(self : DsgraphedgelistModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistModel::set(self : DsgraphedgelistModel, i : Int, v : Double) -> DsgraphedgelistModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistModel::sum(self : DsgraphedgelistModel) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistModel::mean(self : DsgraphedgelistModel) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistModel::scale(self : DsgraphedgelistModel, f : Double) -> DsgraphedgelistModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistModel::add(self : DsgraphedgelistModel, other : DsgraphedgelistModel) -> DsgraphedgelistModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistModel::copy(self : DsgraphedgelistModel) -> DsgraphedgelistModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistModel::fill(self : DsgraphedgelistModel, v : Double) -> DsgraphedgelistModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistModel::min(self : DsgraphedgelistModel) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistModel::max(self : DsgraphedgelistModel) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistModel::to_string(self : DsgraphedgelistModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_layer_make(size : Int) -> DsgraphedgelistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistLayer::len(self : DsgraphedgelistLayer) -> Int { self.size }

pub fn DsgraphedgelistLayer::get(self : DsgraphedgelistLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistLayer::set(self : DsgraphedgelistLayer, i : Int, v : Double) -> DsgraphedgelistLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistLayer::sum(self : DsgraphedgelistLayer) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistLayer::mean(self : DsgraphedgelistLayer) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistLayer::scale(self : DsgraphedgelistLayer, f : Double) -> DsgraphedgelistLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistLayer::add(self : DsgraphedgelistLayer, other : DsgraphedgelistLayer) -> DsgraphedgelistLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistLayer::copy(self : DsgraphedgelistLayer) -> DsgraphedgelistLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistLayer::fill(self : DsgraphedgelistLayer, v : Double) -> DsgraphedgelistLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistLayer::min(self : DsgraphedgelistLayer) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistLayer::max(self : DsgraphedgelistLayer) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistLayer::to_string(self : DsgraphedgelistLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_buffer_make(size : Int) -> DsgraphedgelistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistBuffer::len(self : DsgraphedgelistBuffer) -> Int { self.size }

pub fn DsgraphedgelistBuffer::get(self : DsgraphedgelistBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistBuffer::set(self : DsgraphedgelistBuffer, i : Int, v : Double) -> DsgraphedgelistBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistBuffer::sum(self : DsgraphedgelistBuffer) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistBuffer::mean(self : DsgraphedgelistBuffer) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistBuffer::scale(self : DsgraphedgelistBuffer, f : Double) -> DsgraphedgelistBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistBuffer::add(self : DsgraphedgelistBuffer, other : DsgraphedgelistBuffer) -> DsgraphedgelistBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistBuffer::copy(self : DsgraphedgelistBuffer) -> DsgraphedgelistBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistBuffer::fill(self : DsgraphedgelistBuffer, v : Double) -> DsgraphedgelistBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistBuffer::min(self : DsgraphedgelistBuffer) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistBuffer::max(self : DsgraphedgelistBuffer) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistBuffer::to_string(self : DsgraphedgelistBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_cursor_make(size : Int) -> DsgraphedgelistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistCursor::len(self : DsgraphedgelistCursor) -> Int { self.size }

pub fn DsgraphedgelistCursor::get(self : DsgraphedgelistCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistCursor::set(self : DsgraphedgelistCursor, i : Int, v : Double) -> DsgraphedgelistCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistCursor::sum(self : DsgraphedgelistCursor) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistCursor::mean(self : DsgraphedgelistCursor) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistCursor::scale(self : DsgraphedgelistCursor, f : Double) -> DsgraphedgelistCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistCursor::add(self : DsgraphedgelistCursor, other : DsgraphedgelistCursor) -> DsgraphedgelistCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistCursor::copy(self : DsgraphedgelistCursor) -> DsgraphedgelistCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistCursor::fill(self : DsgraphedgelistCursor, v : Double) -> DsgraphedgelistCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistCursor::min(self : DsgraphedgelistCursor) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistCursor::max(self : DsgraphedgelistCursor) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistCursor::to_string(self : DsgraphedgelistCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_view_make(size : Int) -> DsgraphedgelistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistView::len(self : DsgraphedgelistView) -> Int { self.size }

pub fn DsgraphedgelistView::get(self : DsgraphedgelistView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistView::set(self : DsgraphedgelistView, i : Int, v : Double) -> DsgraphedgelistView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistView::sum(self : DsgraphedgelistView) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistView::mean(self : DsgraphedgelistView) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistView::scale(self : DsgraphedgelistView, f : Double) -> DsgraphedgelistView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistView::add(self : DsgraphedgelistView, other : DsgraphedgelistView) -> DsgraphedgelistView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistView::copy(self : DsgraphedgelistView) -> DsgraphedgelistView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistView::fill(self : DsgraphedgelistView, v : Double) -> DsgraphedgelistView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistView::min(self : DsgraphedgelistView) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistView::max(self : DsgraphedgelistView) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistView::to_string(self : DsgraphedgelistView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_range_make(size : Int) -> DsgraphedgelistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistRange::len(self : DsgraphedgelistRange) -> Int { self.size }

pub fn DsgraphedgelistRange::get(self : DsgraphedgelistRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistRange::set(self : DsgraphedgelistRange, i : Int, v : Double) -> DsgraphedgelistRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistRange::sum(self : DsgraphedgelistRange) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistRange::mean(self : DsgraphedgelistRange) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistRange::scale(self : DsgraphedgelistRange, f : Double) -> DsgraphedgelistRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistRange::add(self : DsgraphedgelistRange, other : DsgraphedgelistRange) -> DsgraphedgelistRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistRange::copy(self : DsgraphedgelistRange) -> DsgraphedgelistRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistRange::fill(self : DsgraphedgelistRange, v : Double) -> DsgraphedgelistRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistRange::min(self : DsgraphedgelistRange) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistRange::max(self : DsgraphedgelistRange) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistRange::to_string(self : DsgraphedgelistRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_slice_make(size : Int) -> DsgraphedgelistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphedgelistSlice::len(self : DsgraphedgelistSlice) -> Int { self.size }

pub fn DsgraphedgelistSlice::get(self : DsgraphedgelistSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphedgelistSlice::set(self : DsgraphedgelistSlice, i : Int, v : Double) -> DsgraphedgelistSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistSlice::sum(self : DsgraphedgelistSlice) -> Double { @_common.sum(self.data) }

pub fn DsgraphedgelistSlice::mean(self : DsgraphedgelistSlice) -> Double { @_common.mean(self.data) }

pub fn DsgraphedgelistSlice::scale(self : DsgraphedgelistSlice, f : Double) -> DsgraphedgelistSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistSlice::add(self : DsgraphedgelistSlice, other : DsgraphedgelistSlice) -> DsgraphedgelistSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphedgelistSlice::copy(self : DsgraphedgelistSlice) -> DsgraphedgelistSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistSlice::fill(self : DsgraphedgelistSlice, v : Double) -> DsgraphedgelistSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphedgelistSlice::min(self : DsgraphedgelistSlice) -> Double { @_common.min(self.data) }

pub fn DsgraphedgelistSlice::max(self : DsgraphedgelistSlice) -> Double { @_common.max(self.data) }

pub fn DsgraphedgelistSlice::to_string(self : DsgraphedgelistSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

