///===
/// extcore/ds_graph_weighted

pub(all) struct DsgraphweightedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_weighted_make_point(x : Double, y : Double) -> DsgraphweightedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_weighted_make_point3(x : Double, y : Double, z : Double) -> DsgraphweightedPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphweightedPoint::x(self : DsgraphweightedPoint) -> Double { self.x }

pub fn DsgraphweightedPoint::y(self : DsgraphweightedPoint) -> Double { self.y }

pub fn DsgraphweightedPoint::z(self : DsgraphweightedPoint) -> Double { self.z }

pub fn DsgraphweightedPoint::label(self : DsgraphweightedPoint) -> Int { self.label }

pub fn DsgraphweightedPoint::dist(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphweightedPoint::add(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphweightedPoint::sub(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphweightedPoint::scale(self : DsgraphweightedPoint, s : Double) -> DsgraphweightedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphweightedPoint::dot(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphweightedPoint::cross(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphweightedPoint::norm(self : DsgraphweightedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphweightedPoint::normalize(self : DsgraphweightedPoint) -> DsgraphweightedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphweightedPoint::negate(self : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphweightedPoint::mid(self : DsgraphweightedPoint, other : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphweightedPoint::lerp(self : DsgraphweightedPoint, other : DsgraphweightedPoint, t : Double) -> DsgraphweightedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphweightedPoint::to_string(self : DsgraphweightedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphweightedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_weighted_make_series(vals : Array[Double], name : String) -> DsgraphweightedSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphweightedSeries::len(self : DsgraphweightedSeries) -> Int { self.vals.length() }

pub fn DsgraphweightedSeries::sum(self : DsgraphweightedSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphweightedSeries::mean(self : DsgraphweightedSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphweightedSeries::min(self : DsgraphweightedSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphweightedSeries::max(self : DsgraphweightedSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphweightedSeries::range(self : DsgraphweightedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphweightedSeries::variance(self : DsgraphweightedSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphweightedSeries::std(self : DsgraphweightedSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphweightedSeries::median(self : DsgraphweightedSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphweightedSeries::scale(self : DsgraphweightedSeries, f : Double) -> DsgraphweightedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphweightedSeries::add(self : DsgraphweightedSeries, other : DsgraphweightedSeries) -> DsgraphweightedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphweightedSeries::sub(self : DsgraphweightedSeries, other : DsgraphweightedSeries) -> DsgraphweightedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphweightedSeries::normalize(self : DsgraphweightedSeries) -> DsgraphweightedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphweightedSeries::cumsum(self : DsgraphweightedSeries) -> DsgraphweightedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphweightedSeries::to_string(self : DsgraphweightedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphweightedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_weighted_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphweightedMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ds_graph_weighted_matrix_identity(n : Int) -> DsgraphweightedMatrix {
  let m = ds_graph_weighted_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphweightedMatrix::get(self : DsgraphweightedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphweightedMatrix::transpose(self : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  let result = ds_graph_weighted_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphweightedMatrix::add(self : DsgraphweightedMatrix, other : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_weighted_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphweightedMatrix::scale(self : DsgraphweightedMatrix, s : Double) -> DsgraphweightedMatrix {
  let result = ds_graph_weighted_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphweightedMatrix::multiply(self : DsgraphweightedMatrix, other : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  if self.cols != other.rows { return ds_graph_weighted_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_weighted_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DsgraphweightedMatrix::trace(self : DsgraphweightedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphweightedMatrix::det(self : DsgraphweightedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphweightedMatrix::norm(self : DsgraphweightedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphweightedMatrix::to_string(self : DsgraphweightedMatrix) -> String {
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

pub(all) struct DsgraphweightedVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_weighted_make_vector(comps : Array[Double]) -> DsgraphweightedVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_weighted_vector_zero(dim : Int) -> DsgraphweightedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphweightedVector::add(self : DsgraphweightedVector, other : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphweightedVector::sub(self : DsgraphweightedVector, other : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphweightedVector::scale(self : DsgraphweightedVector, s : Double) -> DsgraphweightedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphweightedVector::dot(self : DsgraphweightedVector, other : DsgraphweightedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphweightedVector::norm(self : DsgraphweightedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphweightedVector::normalize(self : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphweightedVector::dist(self : DsgraphweightedVector, other : DsgraphweightedVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphweightedVector::to_string(self : DsgraphweightedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphweightedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_frame_make(size : Int) -> DsgraphweightedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedFrame::len(self : DsgraphweightedFrame) -> Int { self.size }

pub fn DsgraphweightedFrame::get(self : DsgraphweightedFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedFrame::set(self : DsgraphweightedFrame, i : Int, v : Double) -> DsgraphweightedFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedFrame::sum(self : DsgraphweightedFrame) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedFrame::mean(self : DsgraphweightedFrame) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedFrame::scale(self : DsgraphweightedFrame, f : Double) -> DsgraphweightedFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedFrame::add(self : DsgraphweightedFrame, other : DsgraphweightedFrame) -> DsgraphweightedFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedFrame::copy(self : DsgraphweightedFrame) -> DsgraphweightedFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedFrame::fill(self : DsgraphweightedFrame, v : Double) -> DsgraphweightedFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedFrame::min(self : DsgraphweightedFrame) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedFrame::max(self : DsgraphweightedFrame) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedFrame::to_string(self : DsgraphweightedFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_table_make(size : Int) -> DsgraphweightedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedTable::len(self : DsgraphweightedTable) -> Int { self.size }

pub fn DsgraphweightedTable::get(self : DsgraphweightedTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedTable::set(self : DsgraphweightedTable, i : Int, v : Double) -> DsgraphweightedTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedTable::sum(self : DsgraphweightedTable) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedTable::mean(self : DsgraphweightedTable) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedTable::scale(self : DsgraphweightedTable, f : Double) -> DsgraphweightedTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedTable::add(self : DsgraphweightedTable, other : DsgraphweightedTable) -> DsgraphweightedTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedTable::copy(self : DsgraphweightedTable) -> DsgraphweightedTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedTable::fill(self : DsgraphweightedTable, v : Double) -> DsgraphweightedTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedTable::min(self : DsgraphweightedTable) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedTable::max(self : DsgraphweightedTable) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedTable::to_string(self : DsgraphweightedTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_graphn_make(size : Int) -> DsgraphweightedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedGraphN::len(self : DsgraphweightedGraphN) -> Int { self.size }

pub fn DsgraphweightedGraphN::get(self : DsgraphweightedGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedGraphN::set(self : DsgraphweightedGraphN, i : Int, v : Double) -> DsgraphweightedGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedGraphN::sum(self : DsgraphweightedGraphN) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedGraphN::mean(self : DsgraphweightedGraphN) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedGraphN::scale(self : DsgraphweightedGraphN, f : Double) -> DsgraphweightedGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedGraphN::add(self : DsgraphweightedGraphN, other : DsgraphweightedGraphN) -> DsgraphweightedGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedGraphN::copy(self : DsgraphweightedGraphN) -> DsgraphweightedGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedGraphN::fill(self : DsgraphweightedGraphN, v : Double) -> DsgraphweightedGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedGraphN::min(self : DsgraphweightedGraphN) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedGraphN::max(self : DsgraphweightedGraphN) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedGraphN::to_string(self : DsgraphweightedGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_node_make(size : Int) -> DsgraphweightedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedNode::len(self : DsgraphweightedNode) -> Int { self.size }

pub fn DsgraphweightedNode::get(self : DsgraphweightedNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedNode::set(self : DsgraphweightedNode, i : Int, v : Double) -> DsgraphweightedNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedNode::sum(self : DsgraphweightedNode) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedNode::mean(self : DsgraphweightedNode) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedNode::scale(self : DsgraphweightedNode, f : Double) -> DsgraphweightedNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedNode::add(self : DsgraphweightedNode, other : DsgraphweightedNode) -> DsgraphweightedNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedNode::copy(self : DsgraphweightedNode) -> DsgraphweightedNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedNode::fill(self : DsgraphweightedNode, v : Double) -> DsgraphweightedNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedNode::min(self : DsgraphweightedNode) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedNode::max(self : DsgraphweightedNode) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedNode::to_string(self : DsgraphweightedNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_edge_make(size : Int) -> DsgraphweightedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedEdge::len(self : DsgraphweightedEdge) -> Int { self.size }

pub fn DsgraphweightedEdge::get(self : DsgraphweightedEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedEdge::set(self : DsgraphweightedEdge, i : Int, v : Double) -> DsgraphweightedEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedEdge::sum(self : DsgraphweightedEdge) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedEdge::mean(self : DsgraphweightedEdge) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedEdge::scale(self : DsgraphweightedEdge, f : Double) -> DsgraphweightedEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedEdge::add(self : DsgraphweightedEdge, other : DsgraphweightedEdge) -> DsgraphweightedEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedEdge::copy(self : DsgraphweightedEdge) -> DsgraphweightedEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedEdge::fill(self : DsgraphweightedEdge, v : Double) -> DsgraphweightedEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedEdge::min(self : DsgraphweightedEdge) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedEdge::max(self : DsgraphweightedEdge) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedEdge::to_string(self : DsgraphweightedEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_path_make(size : Int) -> DsgraphweightedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedPath::len(self : DsgraphweightedPath) -> Int { self.size }

pub fn DsgraphweightedPath::get(self : DsgraphweightedPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedPath::set(self : DsgraphweightedPath, i : Int, v : Double) -> DsgraphweightedPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedPath::sum(self : DsgraphweightedPath) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedPath::mean(self : DsgraphweightedPath) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedPath::scale(self : DsgraphweightedPath, f : Double) -> DsgraphweightedPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedPath::add(self : DsgraphweightedPath, other : DsgraphweightedPath) -> DsgraphweightedPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedPath::copy(self : DsgraphweightedPath) -> DsgraphweightedPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedPath::fill(self : DsgraphweightedPath, v : Double) -> DsgraphweightedPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedPath::min(self : DsgraphweightedPath) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedPath::max(self : DsgraphweightedPath) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedPath::to_string(self : DsgraphweightedPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_cluster_make(size : Int) -> DsgraphweightedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedCluster::len(self : DsgraphweightedCluster) -> Int { self.size }

pub fn DsgraphweightedCluster::get(self : DsgraphweightedCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedCluster::set(self : DsgraphweightedCluster, i : Int, v : Double) -> DsgraphweightedCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedCluster::sum(self : DsgraphweightedCluster) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedCluster::mean(self : DsgraphweightedCluster) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedCluster::scale(self : DsgraphweightedCluster, f : Double) -> DsgraphweightedCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedCluster::add(self : DsgraphweightedCluster, other : DsgraphweightedCluster) -> DsgraphweightedCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedCluster::copy(self : DsgraphweightedCluster) -> DsgraphweightedCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedCluster::fill(self : DsgraphweightedCluster, v : Double) -> DsgraphweightedCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedCluster::min(self : DsgraphweightedCluster) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedCluster::max(self : DsgraphweightedCluster) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedCluster::to_string(self : DsgraphweightedCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_model_make(size : Int) -> DsgraphweightedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedModel::len(self : DsgraphweightedModel) -> Int { self.size }

pub fn DsgraphweightedModel::get(self : DsgraphweightedModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedModel::set(self : DsgraphweightedModel, i : Int, v : Double) -> DsgraphweightedModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedModel::sum(self : DsgraphweightedModel) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedModel::mean(self : DsgraphweightedModel) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedModel::scale(self : DsgraphweightedModel, f : Double) -> DsgraphweightedModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedModel::add(self : DsgraphweightedModel, other : DsgraphweightedModel) -> DsgraphweightedModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedModel::copy(self : DsgraphweightedModel) -> DsgraphweightedModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedModel::fill(self : DsgraphweightedModel, v : Double) -> DsgraphweightedModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedModel::min(self : DsgraphweightedModel) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedModel::max(self : DsgraphweightedModel) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedModel::to_string(self : DsgraphweightedModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_layer_make(size : Int) -> DsgraphweightedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedLayer::len(self : DsgraphweightedLayer) -> Int { self.size }

pub fn DsgraphweightedLayer::get(self : DsgraphweightedLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedLayer::set(self : DsgraphweightedLayer, i : Int, v : Double) -> DsgraphweightedLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedLayer::sum(self : DsgraphweightedLayer) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedLayer::mean(self : DsgraphweightedLayer) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedLayer::scale(self : DsgraphweightedLayer, f : Double) -> DsgraphweightedLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedLayer::add(self : DsgraphweightedLayer, other : DsgraphweightedLayer) -> DsgraphweightedLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedLayer::copy(self : DsgraphweightedLayer) -> DsgraphweightedLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedLayer::fill(self : DsgraphweightedLayer, v : Double) -> DsgraphweightedLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedLayer::min(self : DsgraphweightedLayer) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedLayer::max(self : DsgraphweightedLayer) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedLayer::to_string(self : DsgraphweightedLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_buffer_make(size : Int) -> DsgraphweightedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedBuffer::len(self : DsgraphweightedBuffer) -> Int { self.size }

pub fn DsgraphweightedBuffer::get(self : DsgraphweightedBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedBuffer::set(self : DsgraphweightedBuffer, i : Int, v : Double) -> DsgraphweightedBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedBuffer::sum(self : DsgraphweightedBuffer) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedBuffer::mean(self : DsgraphweightedBuffer) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedBuffer::scale(self : DsgraphweightedBuffer, f : Double) -> DsgraphweightedBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedBuffer::add(self : DsgraphweightedBuffer, other : DsgraphweightedBuffer) -> DsgraphweightedBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedBuffer::copy(self : DsgraphweightedBuffer) -> DsgraphweightedBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedBuffer::fill(self : DsgraphweightedBuffer, v : Double) -> DsgraphweightedBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedBuffer::min(self : DsgraphweightedBuffer) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedBuffer::max(self : DsgraphweightedBuffer) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedBuffer::to_string(self : DsgraphweightedBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_cursor_make(size : Int) -> DsgraphweightedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedCursor::len(self : DsgraphweightedCursor) -> Int { self.size }

pub fn DsgraphweightedCursor::get(self : DsgraphweightedCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedCursor::set(self : DsgraphweightedCursor, i : Int, v : Double) -> DsgraphweightedCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedCursor::sum(self : DsgraphweightedCursor) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedCursor::mean(self : DsgraphweightedCursor) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedCursor::scale(self : DsgraphweightedCursor, f : Double) -> DsgraphweightedCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedCursor::add(self : DsgraphweightedCursor, other : DsgraphweightedCursor) -> DsgraphweightedCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedCursor::copy(self : DsgraphweightedCursor) -> DsgraphweightedCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedCursor::fill(self : DsgraphweightedCursor, v : Double) -> DsgraphweightedCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedCursor::min(self : DsgraphweightedCursor) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedCursor::max(self : DsgraphweightedCursor) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedCursor::to_string(self : DsgraphweightedCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_view_make(size : Int) -> DsgraphweightedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedView::len(self : DsgraphweightedView) -> Int { self.size }

pub fn DsgraphweightedView::get(self : DsgraphweightedView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedView::set(self : DsgraphweightedView, i : Int, v : Double) -> DsgraphweightedView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedView::sum(self : DsgraphweightedView) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedView::mean(self : DsgraphweightedView) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedView::scale(self : DsgraphweightedView, f : Double) -> DsgraphweightedView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedView::add(self : DsgraphweightedView, other : DsgraphweightedView) -> DsgraphweightedView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedView::copy(self : DsgraphweightedView) -> DsgraphweightedView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedView::fill(self : DsgraphweightedView, v : Double) -> DsgraphweightedView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedView::min(self : DsgraphweightedView) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedView::max(self : DsgraphweightedView) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedView::to_string(self : DsgraphweightedView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_range_make(size : Int) -> DsgraphweightedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedRange::len(self : DsgraphweightedRange) -> Int { self.size }

pub fn DsgraphweightedRange::get(self : DsgraphweightedRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedRange::set(self : DsgraphweightedRange, i : Int, v : Double) -> DsgraphweightedRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedRange::sum(self : DsgraphweightedRange) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedRange::mean(self : DsgraphweightedRange) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedRange::scale(self : DsgraphweightedRange, f : Double) -> DsgraphweightedRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedRange::add(self : DsgraphweightedRange, other : DsgraphweightedRange) -> DsgraphweightedRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedRange::copy(self : DsgraphweightedRange) -> DsgraphweightedRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedRange::fill(self : DsgraphweightedRange, v : Double) -> DsgraphweightedRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedRange::min(self : DsgraphweightedRange) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedRange::max(self : DsgraphweightedRange) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedRange::to_string(self : DsgraphweightedRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_slice_make(size : Int) -> DsgraphweightedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphweightedSlice::len(self : DsgraphweightedSlice) -> Int { self.size }

pub fn DsgraphweightedSlice::get(self : DsgraphweightedSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphweightedSlice::set(self : DsgraphweightedSlice, i : Int, v : Double) -> DsgraphweightedSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphweightedSlice::sum(self : DsgraphweightedSlice) -> Double { @_common.sum(self.data) }

pub fn DsgraphweightedSlice::mean(self : DsgraphweightedSlice) -> Double { @_common.mean(self.data) }

pub fn DsgraphweightedSlice::scale(self : DsgraphweightedSlice, f : Double) -> DsgraphweightedSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedSlice::add(self : DsgraphweightedSlice, other : DsgraphweightedSlice) -> DsgraphweightedSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphweightedSlice::copy(self : DsgraphweightedSlice) -> DsgraphweightedSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedSlice::fill(self : DsgraphweightedSlice, v : Double) -> DsgraphweightedSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphweightedSlice::min(self : DsgraphweightedSlice) -> Double { @_common.min(self.data) }

pub fn DsgraphweightedSlice::max(self : DsgraphweightedSlice) -> Double { @_common.max(self.data) }

pub fn DsgraphweightedSlice::to_string(self : DsgraphweightedSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

