///===
/// extcore/ds_graph_adj_list

pub(all) struct DsgraphadjlistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_adj_list_make_point(x : Double, y : Double) -> DsgraphadjlistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_adj_list_make_point3(x : Double, y : Double, z : Double) -> DsgraphadjlistPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphadjlistPoint::x(self : DsgraphadjlistPoint) -> Double { self.x }

pub fn DsgraphadjlistPoint::y(self : DsgraphadjlistPoint) -> Double { self.y }

pub fn DsgraphadjlistPoint::z(self : DsgraphadjlistPoint) -> Double { self.z }

pub fn DsgraphadjlistPoint::label(self : DsgraphadjlistPoint) -> Int { self.label }

pub fn DsgraphadjlistPoint::dist(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphadjlistPoint::add(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphadjlistPoint::sub(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphadjlistPoint::scale(self : DsgraphadjlistPoint, s : Double) -> DsgraphadjlistPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphadjlistPoint::dot(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphadjlistPoint::cross(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphadjlistPoint::norm(self : DsgraphadjlistPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphadjlistPoint::normalize(self : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphadjlistPoint::negate(self : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphadjlistPoint::mid(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint) -> DsgraphadjlistPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphadjlistPoint::lerp(self : DsgraphadjlistPoint, other : DsgraphadjlistPoint, t : Double) -> DsgraphadjlistPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphadjlistPoint::to_string(self : DsgraphadjlistPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphadjlistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_adj_list_make_series(vals : Array[Double], name : String) -> DsgraphadjlistSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphadjlistSeries::len(self : DsgraphadjlistSeries) -> Int { self.vals.length() }

pub fn DsgraphadjlistSeries::sum(self : DsgraphadjlistSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphadjlistSeries::mean(self : DsgraphadjlistSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphadjlistSeries::min(self : DsgraphadjlistSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphadjlistSeries::max(self : DsgraphadjlistSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphadjlistSeries::range(self : DsgraphadjlistSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphadjlistSeries::variance(self : DsgraphadjlistSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphadjlistSeries::std(self : DsgraphadjlistSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphadjlistSeries::median(self : DsgraphadjlistSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphadjlistSeries::scale(self : DsgraphadjlistSeries, f : Double) -> DsgraphadjlistSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphadjlistSeries::add(self : DsgraphadjlistSeries, other : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphadjlistSeries::sub(self : DsgraphadjlistSeries, other : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphadjlistSeries::normalize(self : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphadjlistSeries::cumsum(self : DsgraphadjlistSeries) -> DsgraphadjlistSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphadjlistSeries::to_string(self : DsgraphadjlistSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphadjlistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_adj_list_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphadjlistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_adj_list_matrix_identity(n : Int) -> DsgraphadjlistMatrix {
  let m = ds_graph_adj_list_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphadjlistMatrix::get(self : DsgraphadjlistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphadjlistMatrix::transpose(self : DsgraphadjlistMatrix) -> DsgraphadjlistMatrix {
  let result = ds_graph_adj_list_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphadjlistMatrix::add(self : DsgraphadjlistMatrix, other : DsgraphadjlistMatrix) -> DsgraphadjlistMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_adj_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphadjlistMatrix::scale(self : DsgraphadjlistMatrix, s : Double) -> DsgraphadjlistMatrix {
  let result = ds_graph_adj_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphadjlistMatrix::multiply(self : DsgraphadjlistMatrix, other : DsgraphadjlistMatrix) -> DsgraphadjlistMatrix {
  if self.cols != other.rows { return ds_graph_adj_list_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_adj_list_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DsgraphadjlistMatrix::trace(self : DsgraphadjlistMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphadjlistMatrix::det(self : DsgraphadjlistMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphadjlistMatrix::norm(self : DsgraphadjlistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphadjlistMatrix::to_string(self : DsgraphadjlistMatrix) -> String {
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

pub(all) struct DsgraphadjlistVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_adj_list_make_vector(comps : Array[Double]) -> DsgraphadjlistVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_adj_list_vector_zero(dim : Int) -> DsgraphadjlistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphadjlistVector::add(self : DsgraphadjlistVector, other : DsgraphadjlistVector) -> DsgraphadjlistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphadjlistVector::sub(self : DsgraphadjlistVector, other : DsgraphadjlistVector) -> DsgraphadjlistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphadjlistVector::scale(self : DsgraphadjlistVector, s : Double) -> DsgraphadjlistVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphadjlistVector::dot(self : DsgraphadjlistVector, other : DsgraphadjlistVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphadjlistVector::norm(self : DsgraphadjlistVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphadjlistVector::normalize(self : DsgraphadjlistVector) -> DsgraphadjlistVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphadjlistVector::dist(self : DsgraphadjlistVector, other : DsgraphadjlistVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphadjlistVector::to_string(self : DsgraphadjlistVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphadjlistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_frame_make(size : Int) -> DsgraphadjlistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistFrame::len(self : DsgraphadjlistFrame) -> Int { self.size }

pub fn DsgraphadjlistFrame::get(self : DsgraphadjlistFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistFrame::set(self : DsgraphadjlistFrame, i : Int, v : Double) -> DsgraphadjlistFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistFrame::sum(self : DsgraphadjlistFrame) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistFrame::mean(self : DsgraphadjlistFrame) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistFrame::scale(self : DsgraphadjlistFrame, f : Double) -> DsgraphadjlistFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistFrame::add(self : DsgraphadjlistFrame, other : DsgraphadjlistFrame) -> DsgraphadjlistFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistFrame::copy(self : DsgraphadjlistFrame) -> DsgraphadjlistFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistFrame::fill(self : DsgraphadjlistFrame, v : Double) -> DsgraphadjlistFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistFrame::min(self : DsgraphadjlistFrame) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistFrame::max(self : DsgraphadjlistFrame) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistFrame::to_string(self : DsgraphadjlistFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_table_make(size : Int) -> DsgraphadjlistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistTable::len(self : DsgraphadjlistTable) -> Int { self.size }

pub fn DsgraphadjlistTable::get(self : DsgraphadjlistTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistTable::set(self : DsgraphadjlistTable, i : Int, v : Double) -> DsgraphadjlistTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistTable::sum(self : DsgraphadjlistTable) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistTable::mean(self : DsgraphadjlistTable) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistTable::scale(self : DsgraphadjlistTable, f : Double) -> DsgraphadjlistTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistTable::add(self : DsgraphadjlistTable, other : DsgraphadjlistTable) -> DsgraphadjlistTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistTable::copy(self : DsgraphadjlistTable) -> DsgraphadjlistTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistTable::fill(self : DsgraphadjlistTable, v : Double) -> DsgraphadjlistTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistTable::min(self : DsgraphadjlistTable) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistTable::max(self : DsgraphadjlistTable) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistTable::to_string(self : DsgraphadjlistTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_graphn_make(size : Int) -> DsgraphadjlistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistGraphN::len(self : DsgraphadjlistGraphN) -> Int { self.size }

pub fn DsgraphadjlistGraphN::get(self : DsgraphadjlistGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistGraphN::set(self : DsgraphadjlistGraphN, i : Int, v : Double) -> DsgraphadjlistGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistGraphN::sum(self : DsgraphadjlistGraphN) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistGraphN::mean(self : DsgraphadjlistGraphN) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistGraphN::scale(self : DsgraphadjlistGraphN, f : Double) -> DsgraphadjlistGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistGraphN::add(self : DsgraphadjlistGraphN, other : DsgraphadjlistGraphN) -> DsgraphadjlistGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistGraphN::copy(self : DsgraphadjlistGraphN) -> DsgraphadjlistGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistGraphN::fill(self : DsgraphadjlistGraphN, v : Double) -> DsgraphadjlistGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistGraphN::min(self : DsgraphadjlistGraphN) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistGraphN::max(self : DsgraphadjlistGraphN) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistGraphN::to_string(self : DsgraphadjlistGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_node_make(size : Int) -> DsgraphadjlistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistNode::len(self : DsgraphadjlistNode) -> Int { self.size }

pub fn DsgraphadjlistNode::get(self : DsgraphadjlistNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistNode::set(self : DsgraphadjlistNode, i : Int, v : Double) -> DsgraphadjlistNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistNode::sum(self : DsgraphadjlistNode) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistNode::mean(self : DsgraphadjlistNode) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistNode::scale(self : DsgraphadjlistNode, f : Double) -> DsgraphadjlistNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistNode::add(self : DsgraphadjlistNode, other : DsgraphadjlistNode) -> DsgraphadjlistNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistNode::copy(self : DsgraphadjlistNode) -> DsgraphadjlistNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistNode::fill(self : DsgraphadjlistNode, v : Double) -> DsgraphadjlistNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistNode::min(self : DsgraphadjlistNode) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistNode::max(self : DsgraphadjlistNode) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistNode::to_string(self : DsgraphadjlistNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_edge_make(size : Int) -> DsgraphadjlistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistEdge::len(self : DsgraphadjlistEdge) -> Int { self.size }

pub fn DsgraphadjlistEdge::get(self : DsgraphadjlistEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistEdge::set(self : DsgraphadjlistEdge, i : Int, v : Double) -> DsgraphadjlistEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistEdge::sum(self : DsgraphadjlistEdge) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistEdge::mean(self : DsgraphadjlistEdge) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistEdge::scale(self : DsgraphadjlistEdge, f : Double) -> DsgraphadjlistEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistEdge::add(self : DsgraphadjlistEdge, other : DsgraphadjlistEdge) -> DsgraphadjlistEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistEdge::copy(self : DsgraphadjlistEdge) -> DsgraphadjlistEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistEdge::fill(self : DsgraphadjlistEdge, v : Double) -> DsgraphadjlistEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistEdge::min(self : DsgraphadjlistEdge) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistEdge::max(self : DsgraphadjlistEdge) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistEdge::to_string(self : DsgraphadjlistEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_path_make(size : Int) -> DsgraphadjlistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistPath::len(self : DsgraphadjlistPath) -> Int { self.size }

pub fn DsgraphadjlistPath::get(self : DsgraphadjlistPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistPath::set(self : DsgraphadjlistPath, i : Int, v : Double) -> DsgraphadjlistPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistPath::sum(self : DsgraphadjlistPath) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistPath::mean(self : DsgraphadjlistPath) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistPath::scale(self : DsgraphadjlistPath, f : Double) -> DsgraphadjlistPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistPath::add(self : DsgraphadjlistPath, other : DsgraphadjlistPath) -> DsgraphadjlistPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistPath::copy(self : DsgraphadjlistPath) -> DsgraphadjlistPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistPath::fill(self : DsgraphadjlistPath, v : Double) -> DsgraphadjlistPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistPath::min(self : DsgraphadjlistPath) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistPath::max(self : DsgraphadjlistPath) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistPath::to_string(self : DsgraphadjlistPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_cluster_make(size : Int) -> DsgraphadjlistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistCluster::len(self : DsgraphadjlistCluster) -> Int { self.size }

pub fn DsgraphadjlistCluster::get(self : DsgraphadjlistCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistCluster::set(self : DsgraphadjlistCluster, i : Int, v : Double) -> DsgraphadjlistCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistCluster::sum(self : DsgraphadjlistCluster) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistCluster::mean(self : DsgraphadjlistCluster) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistCluster::scale(self : DsgraphadjlistCluster, f : Double) -> DsgraphadjlistCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistCluster::add(self : DsgraphadjlistCluster, other : DsgraphadjlistCluster) -> DsgraphadjlistCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistCluster::copy(self : DsgraphadjlistCluster) -> DsgraphadjlistCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistCluster::fill(self : DsgraphadjlistCluster, v : Double) -> DsgraphadjlistCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistCluster::min(self : DsgraphadjlistCluster) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistCluster::max(self : DsgraphadjlistCluster) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistCluster::to_string(self : DsgraphadjlistCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_model_make(size : Int) -> DsgraphadjlistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistModel::len(self : DsgraphadjlistModel) -> Int { self.size }

pub fn DsgraphadjlistModel::get(self : DsgraphadjlistModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistModel::set(self : DsgraphadjlistModel, i : Int, v : Double) -> DsgraphadjlistModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistModel::sum(self : DsgraphadjlistModel) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistModel::mean(self : DsgraphadjlistModel) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistModel::scale(self : DsgraphadjlistModel, f : Double) -> DsgraphadjlistModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistModel::add(self : DsgraphadjlistModel, other : DsgraphadjlistModel) -> DsgraphadjlistModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistModel::copy(self : DsgraphadjlistModel) -> DsgraphadjlistModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistModel::fill(self : DsgraphadjlistModel, v : Double) -> DsgraphadjlistModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistModel::min(self : DsgraphadjlistModel) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistModel::max(self : DsgraphadjlistModel) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistModel::to_string(self : DsgraphadjlistModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_layer_make(size : Int) -> DsgraphadjlistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistLayer::len(self : DsgraphadjlistLayer) -> Int { self.size }

pub fn DsgraphadjlistLayer::get(self : DsgraphadjlistLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistLayer::set(self : DsgraphadjlistLayer, i : Int, v : Double) -> DsgraphadjlistLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistLayer::sum(self : DsgraphadjlistLayer) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistLayer::mean(self : DsgraphadjlistLayer) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistLayer::scale(self : DsgraphadjlistLayer, f : Double) -> DsgraphadjlistLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistLayer::add(self : DsgraphadjlistLayer, other : DsgraphadjlistLayer) -> DsgraphadjlistLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistLayer::copy(self : DsgraphadjlistLayer) -> DsgraphadjlistLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistLayer::fill(self : DsgraphadjlistLayer, v : Double) -> DsgraphadjlistLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistLayer::min(self : DsgraphadjlistLayer) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistLayer::max(self : DsgraphadjlistLayer) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistLayer::to_string(self : DsgraphadjlistLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_buffer_make(size : Int) -> DsgraphadjlistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistBuffer::len(self : DsgraphadjlistBuffer) -> Int { self.size }

pub fn DsgraphadjlistBuffer::get(self : DsgraphadjlistBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistBuffer::set(self : DsgraphadjlistBuffer, i : Int, v : Double) -> DsgraphadjlistBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistBuffer::sum(self : DsgraphadjlistBuffer) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistBuffer::mean(self : DsgraphadjlistBuffer) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistBuffer::scale(self : DsgraphadjlistBuffer, f : Double) -> DsgraphadjlistBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistBuffer::add(self : DsgraphadjlistBuffer, other : DsgraphadjlistBuffer) -> DsgraphadjlistBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistBuffer::copy(self : DsgraphadjlistBuffer) -> DsgraphadjlistBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistBuffer::fill(self : DsgraphadjlistBuffer, v : Double) -> DsgraphadjlistBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistBuffer::min(self : DsgraphadjlistBuffer) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistBuffer::max(self : DsgraphadjlistBuffer) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistBuffer::to_string(self : DsgraphadjlistBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_cursor_make(size : Int) -> DsgraphadjlistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistCursor::len(self : DsgraphadjlistCursor) -> Int { self.size }

pub fn DsgraphadjlistCursor::get(self : DsgraphadjlistCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistCursor::set(self : DsgraphadjlistCursor, i : Int, v : Double) -> DsgraphadjlistCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistCursor::sum(self : DsgraphadjlistCursor) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistCursor::mean(self : DsgraphadjlistCursor) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistCursor::scale(self : DsgraphadjlistCursor, f : Double) -> DsgraphadjlistCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistCursor::add(self : DsgraphadjlistCursor, other : DsgraphadjlistCursor) -> DsgraphadjlistCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistCursor::copy(self : DsgraphadjlistCursor) -> DsgraphadjlistCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistCursor::fill(self : DsgraphadjlistCursor, v : Double) -> DsgraphadjlistCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistCursor::min(self : DsgraphadjlistCursor) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistCursor::max(self : DsgraphadjlistCursor) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistCursor::to_string(self : DsgraphadjlistCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_view_make(size : Int) -> DsgraphadjlistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistView::len(self : DsgraphadjlistView) -> Int { self.size }

pub fn DsgraphadjlistView::get(self : DsgraphadjlistView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistView::set(self : DsgraphadjlistView, i : Int, v : Double) -> DsgraphadjlistView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistView::sum(self : DsgraphadjlistView) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistView::mean(self : DsgraphadjlistView) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistView::scale(self : DsgraphadjlistView, f : Double) -> DsgraphadjlistView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistView::add(self : DsgraphadjlistView, other : DsgraphadjlistView) -> DsgraphadjlistView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistView::copy(self : DsgraphadjlistView) -> DsgraphadjlistView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistView::fill(self : DsgraphadjlistView, v : Double) -> DsgraphadjlistView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistView::min(self : DsgraphadjlistView) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistView::max(self : DsgraphadjlistView) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistView::to_string(self : DsgraphadjlistView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_range_make(size : Int) -> DsgraphadjlistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistRange::len(self : DsgraphadjlistRange) -> Int { self.size }

pub fn DsgraphadjlistRange::get(self : DsgraphadjlistRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistRange::set(self : DsgraphadjlistRange, i : Int, v : Double) -> DsgraphadjlistRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistRange::sum(self : DsgraphadjlistRange) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistRange::mean(self : DsgraphadjlistRange) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistRange::scale(self : DsgraphadjlistRange, f : Double) -> DsgraphadjlistRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistRange::add(self : DsgraphadjlistRange, other : DsgraphadjlistRange) -> DsgraphadjlistRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistRange::copy(self : DsgraphadjlistRange) -> DsgraphadjlistRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistRange::fill(self : DsgraphadjlistRange, v : Double) -> DsgraphadjlistRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistRange::min(self : DsgraphadjlistRange) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistRange::max(self : DsgraphadjlistRange) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistRange::to_string(self : DsgraphadjlistRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjlistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_list_slice_make(size : Int) -> DsgraphadjlistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjlistSlice::len(self : DsgraphadjlistSlice) -> Int { self.size }

pub fn DsgraphadjlistSlice::get(self : DsgraphadjlistSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjlistSlice::set(self : DsgraphadjlistSlice, i : Int, v : Double) -> DsgraphadjlistSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistSlice::sum(self : DsgraphadjlistSlice) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjlistSlice::mean(self : DsgraphadjlistSlice) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjlistSlice::scale(self : DsgraphadjlistSlice, f : Double) -> DsgraphadjlistSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistSlice::add(self : DsgraphadjlistSlice, other : DsgraphadjlistSlice) -> DsgraphadjlistSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjlistSlice::copy(self : DsgraphadjlistSlice) -> DsgraphadjlistSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistSlice::fill(self : DsgraphadjlistSlice, v : Double) -> DsgraphadjlistSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjlistSlice::min(self : DsgraphadjlistSlice) -> Double { @_common.min(self.data) }

pub fn DsgraphadjlistSlice::max(self : DsgraphadjlistSlice) -> Double { @_common.max(self.data) }

pub fn DsgraphadjlistSlice::to_string(self : DsgraphadjlistSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

