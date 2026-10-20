///===
/// extcore/ds_graph_directed

pub(all) struct DsgraphdirectedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_directed_make_point(x : Double, y : Double) -> DsgraphdirectedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_directed_make_point3(x : Double, y : Double, z : Double) -> DsgraphdirectedPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphdirectedPoint::x(self : DsgraphdirectedPoint) -> Double { self.x }

pub fn DsgraphdirectedPoint::y(self : DsgraphdirectedPoint) -> Double { self.y }

pub fn DsgraphdirectedPoint::z(self : DsgraphdirectedPoint) -> Double { self.z }

pub fn DsgraphdirectedPoint::label(self : DsgraphdirectedPoint) -> Int { self.label }

pub fn DsgraphdirectedPoint::dist(self : DsgraphdirectedPoint, other : DsgraphdirectedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphdirectedPoint::add(self : DsgraphdirectedPoint, other : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphdirectedPoint::sub(self : DsgraphdirectedPoint, other : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphdirectedPoint::scale(self : DsgraphdirectedPoint, s : Double) -> DsgraphdirectedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphdirectedPoint::dot(self : DsgraphdirectedPoint, other : DsgraphdirectedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphdirectedPoint::cross(self : DsgraphdirectedPoint, other : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphdirectedPoint::norm(self : DsgraphdirectedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphdirectedPoint::normalize(self : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphdirectedPoint::negate(self : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphdirectedPoint::mid(self : DsgraphdirectedPoint, other : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphdirectedPoint::lerp(self : DsgraphdirectedPoint, other : DsgraphdirectedPoint, t : Double) -> DsgraphdirectedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphdirectedPoint::to_string(self : DsgraphdirectedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphdirectedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_directed_make_series(vals : Array[Double], name : String) -> DsgraphdirectedSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphdirectedSeries::len(self : DsgraphdirectedSeries) -> Int { self.vals.length() }

pub fn DsgraphdirectedSeries::sum(self : DsgraphdirectedSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphdirectedSeries::mean(self : DsgraphdirectedSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphdirectedSeries::min(self : DsgraphdirectedSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphdirectedSeries::max(self : DsgraphdirectedSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphdirectedSeries::range(self : DsgraphdirectedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphdirectedSeries::variance(self : DsgraphdirectedSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphdirectedSeries::std(self : DsgraphdirectedSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphdirectedSeries::median(self : DsgraphdirectedSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphdirectedSeries::scale(self : DsgraphdirectedSeries, f : Double) -> DsgraphdirectedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphdirectedSeries::add(self : DsgraphdirectedSeries, other : DsgraphdirectedSeries) -> DsgraphdirectedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphdirectedSeries::sub(self : DsgraphdirectedSeries, other : DsgraphdirectedSeries) -> DsgraphdirectedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphdirectedSeries::normalize(self : DsgraphdirectedSeries) -> DsgraphdirectedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphdirectedSeries::cumsum(self : DsgraphdirectedSeries) -> DsgraphdirectedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphdirectedSeries::to_string(self : DsgraphdirectedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphdirectedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_directed_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphdirectedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_directed_matrix_identity(n : Int) -> DsgraphdirectedMatrix {
  let m = ds_graph_directed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphdirectedMatrix::get(self : DsgraphdirectedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphdirectedMatrix::transpose(self : DsgraphdirectedMatrix) -> DsgraphdirectedMatrix {
  let result = ds_graph_directed_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphdirectedMatrix::add(self : DsgraphdirectedMatrix, other : DsgraphdirectedMatrix) -> DsgraphdirectedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_directed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphdirectedMatrix::scale(self : DsgraphdirectedMatrix, s : Double) -> DsgraphdirectedMatrix {
  let result = ds_graph_directed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphdirectedMatrix::multiply(self : DsgraphdirectedMatrix, other : DsgraphdirectedMatrix) -> DsgraphdirectedMatrix {
  if self.cols != other.rows { return ds_graph_directed_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_directed_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DsgraphdirectedMatrix::trace(self : DsgraphdirectedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphdirectedMatrix::det(self : DsgraphdirectedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphdirectedMatrix::norm(self : DsgraphdirectedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphdirectedMatrix::to_string(self : DsgraphdirectedMatrix) -> String {
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

pub(all) struct DsgraphdirectedVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_directed_make_vector(comps : Array[Double]) -> DsgraphdirectedVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_directed_vector_zero(dim : Int) -> DsgraphdirectedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphdirectedVector::add(self : DsgraphdirectedVector, other : DsgraphdirectedVector) -> DsgraphdirectedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphdirectedVector::sub(self : DsgraphdirectedVector, other : DsgraphdirectedVector) -> DsgraphdirectedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphdirectedVector::scale(self : DsgraphdirectedVector, s : Double) -> DsgraphdirectedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphdirectedVector::dot(self : DsgraphdirectedVector, other : DsgraphdirectedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphdirectedVector::norm(self : DsgraphdirectedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphdirectedVector::normalize(self : DsgraphdirectedVector) -> DsgraphdirectedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphdirectedVector::dist(self : DsgraphdirectedVector, other : DsgraphdirectedVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphdirectedVector::to_string(self : DsgraphdirectedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphdirectedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_frame_make(size : Int) -> DsgraphdirectedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedFrame::len(self : DsgraphdirectedFrame) -> Int { self.size }

pub fn DsgraphdirectedFrame::get(self : DsgraphdirectedFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedFrame::set(self : DsgraphdirectedFrame, i : Int, v : Double) -> DsgraphdirectedFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedFrame::sum(self : DsgraphdirectedFrame) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedFrame::mean(self : DsgraphdirectedFrame) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedFrame::scale(self : DsgraphdirectedFrame, f : Double) -> DsgraphdirectedFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedFrame::add(self : DsgraphdirectedFrame, other : DsgraphdirectedFrame) -> DsgraphdirectedFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedFrame::copy(self : DsgraphdirectedFrame) -> DsgraphdirectedFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedFrame::fill(self : DsgraphdirectedFrame, v : Double) -> DsgraphdirectedFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedFrame::min(self : DsgraphdirectedFrame) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedFrame::max(self : DsgraphdirectedFrame) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedFrame::to_string(self : DsgraphdirectedFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_table_make(size : Int) -> DsgraphdirectedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedTable::len(self : DsgraphdirectedTable) -> Int { self.size }

pub fn DsgraphdirectedTable::get(self : DsgraphdirectedTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedTable::set(self : DsgraphdirectedTable, i : Int, v : Double) -> DsgraphdirectedTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedTable::sum(self : DsgraphdirectedTable) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedTable::mean(self : DsgraphdirectedTable) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedTable::scale(self : DsgraphdirectedTable, f : Double) -> DsgraphdirectedTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedTable::add(self : DsgraphdirectedTable, other : DsgraphdirectedTable) -> DsgraphdirectedTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedTable::copy(self : DsgraphdirectedTable) -> DsgraphdirectedTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedTable::fill(self : DsgraphdirectedTable, v : Double) -> DsgraphdirectedTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedTable::min(self : DsgraphdirectedTable) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedTable::max(self : DsgraphdirectedTable) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedTable::to_string(self : DsgraphdirectedTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_graphn_make(size : Int) -> DsgraphdirectedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedGraphN::len(self : DsgraphdirectedGraphN) -> Int { self.size }

pub fn DsgraphdirectedGraphN::get(self : DsgraphdirectedGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedGraphN::set(self : DsgraphdirectedGraphN, i : Int, v : Double) -> DsgraphdirectedGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedGraphN::sum(self : DsgraphdirectedGraphN) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedGraphN::mean(self : DsgraphdirectedGraphN) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedGraphN::scale(self : DsgraphdirectedGraphN, f : Double) -> DsgraphdirectedGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedGraphN::add(self : DsgraphdirectedGraphN, other : DsgraphdirectedGraphN) -> DsgraphdirectedGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedGraphN::copy(self : DsgraphdirectedGraphN) -> DsgraphdirectedGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedGraphN::fill(self : DsgraphdirectedGraphN, v : Double) -> DsgraphdirectedGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedGraphN::min(self : DsgraphdirectedGraphN) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedGraphN::max(self : DsgraphdirectedGraphN) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedGraphN::to_string(self : DsgraphdirectedGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_node_make(size : Int) -> DsgraphdirectedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedNode::len(self : DsgraphdirectedNode) -> Int { self.size }

pub fn DsgraphdirectedNode::get(self : DsgraphdirectedNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedNode::set(self : DsgraphdirectedNode, i : Int, v : Double) -> DsgraphdirectedNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedNode::sum(self : DsgraphdirectedNode) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedNode::mean(self : DsgraphdirectedNode) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedNode::scale(self : DsgraphdirectedNode, f : Double) -> DsgraphdirectedNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedNode::add(self : DsgraphdirectedNode, other : DsgraphdirectedNode) -> DsgraphdirectedNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedNode::copy(self : DsgraphdirectedNode) -> DsgraphdirectedNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedNode::fill(self : DsgraphdirectedNode, v : Double) -> DsgraphdirectedNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedNode::min(self : DsgraphdirectedNode) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedNode::max(self : DsgraphdirectedNode) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedNode::to_string(self : DsgraphdirectedNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_edge_make(size : Int) -> DsgraphdirectedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedEdge::len(self : DsgraphdirectedEdge) -> Int { self.size }

pub fn DsgraphdirectedEdge::get(self : DsgraphdirectedEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedEdge::set(self : DsgraphdirectedEdge, i : Int, v : Double) -> DsgraphdirectedEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedEdge::sum(self : DsgraphdirectedEdge) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedEdge::mean(self : DsgraphdirectedEdge) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedEdge::scale(self : DsgraphdirectedEdge, f : Double) -> DsgraphdirectedEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedEdge::add(self : DsgraphdirectedEdge, other : DsgraphdirectedEdge) -> DsgraphdirectedEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedEdge::copy(self : DsgraphdirectedEdge) -> DsgraphdirectedEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedEdge::fill(self : DsgraphdirectedEdge, v : Double) -> DsgraphdirectedEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedEdge::min(self : DsgraphdirectedEdge) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedEdge::max(self : DsgraphdirectedEdge) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedEdge::to_string(self : DsgraphdirectedEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_path_make(size : Int) -> DsgraphdirectedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedPath::len(self : DsgraphdirectedPath) -> Int { self.size }

pub fn DsgraphdirectedPath::get(self : DsgraphdirectedPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedPath::set(self : DsgraphdirectedPath, i : Int, v : Double) -> DsgraphdirectedPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedPath::sum(self : DsgraphdirectedPath) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedPath::mean(self : DsgraphdirectedPath) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedPath::scale(self : DsgraphdirectedPath, f : Double) -> DsgraphdirectedPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedPath::add(self : DsgraphdirectedPath, other : DsgraphdirectedPath) -> DsgraphdirectedPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedPath::copy(self : DsgraphdirectedPath) -> DsgraphdirectedPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedPath::fill(self : DsgraphdirectedPath, v : Double) -> DsgraphdirectedPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedPath::min(self : DsgraphdirectedPath) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedPath::max(self : DsgraphdirectedPath) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedPath::to_string(self : DsgraphdirectedPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_cluster_make(size : Int) -> DsgraphdirectedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedCluster::len(self : DsgraphdirectedCluster) -> Int { self.size }

pub fn DsgraphdirectedCluster::get(self : DsgraphdirectedCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedCluster::set(self : DsgraphdirectedCluster, i : Int, v : Double) -> DsgraphdirectedCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedCluster::sum(self : DsgraphdirectedCluster) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedCluster::mean(self : DsgraphdirectedCluster) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedCluster::scale(self : DsgraphdirectedCluster, f : Double) -> DsgraphdirectedCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedCluster::add(self : DsgraphdirectedCluster, other : DsgraphdirectedCluster) -> DsgraphdirectedCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedCluster::copy(self : DsgraphdirectedCluster) -> DsgraphdirectedCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedCluster::fill(self : DsgraphdirectedCluster, v : Double) -> DsgraphdirectedCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedCluster::min(self : DsgraphdirectedCluster) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedCluster::max(self : DsgraphdirectedCluster) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedCluster::to_string(self : DsgraphdirectedCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_model_make(size : Int) -> DsgraphdirectedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedModel::len(self : DsgraphdirectedModel) -> Int { self.size }

pub fn DsgraphdirectedModel::get(self : DsgraphdirectedModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedModel::set(self : DsgraphdirectedModel, i : Int, v : Double) -> DsgraphdirectedModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedModel::sum(self : DsgraphdirectedModel) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedModel::mean(self : DsgraphdirectedModel) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedModel::scale(self : DsgraphdirectedModel, f : Double) -> DsgraphdirectedModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedModel::add(self : DsgraphdirectedModel, other : DsgraphdirectedModel) -> DsgraphdirectedModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedModel::copy(self : DsgraphdirectedModel) -> DsgraphdirectedModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedModel::fill(self : DsgraphdirectedModel, v : Double) -> DsgraphdirectedModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedModel::min(self : DsgraphdirectedModel) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedModel::max(self : DsgraphdirectedModel) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedModel::to_string(self : DsgraphdirectedModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_layer_make(size : Int) -> DsgraphdirectedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedLayer::len(self : DsgraphdirectedLayer) -> Int { self.size }

pub fn DsgraphdirectedLayer::get(self : DsgraphdirectedLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedLayer::set(self : DsgraphdirectedLayer, i : Int, v : Double) -> DsgraphdirectedLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedLayer::sum(self : DsgraphdirectedLayer) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedLayer::mean(self : DsgraphdirectedLayer) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedLayer::scale(self : DsgraphdirectedLayer, f : Double) -> DsgraphdirectedLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedLayer::add(self : DsgraphdirectedLayer, other : DsgraphdirectedLayer) -> DsgraphdirectedLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedLayer::copy(self : DsgraphdirectedLayer) -> DsgraphdirectedLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedLayer::fill(self : DsgraphdirectedLayer, v : Double) -> DsgraphdirectedLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedLayer::min(self : DsgraphdirectedLayer) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedLayer::max(self : DsgraphdirectedLayer) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedLayer::to_string(self : DsgraphdirectedLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_buffer_make(size : Int) -> DsgraphdirectedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedBuffer::len(self : DsgraphdirectedBuffer) -> Int { self.size }

pub fn DsgraphdirectedBuffer::get(self : DsgraphdirectedBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedBuffer::set(self : DsgraphdirectedBuffer, i : Int, v : Double) -> DsgraphdirectedBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedBuffer::sum(self : DsgraphdirectedBuffer) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedBuffer::mean(self : DsgraphdirectedBuffer) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedBuffer::scale(self : DsgraphdirectedBuffer, f : Double) -> DsgraphdirectedBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedBuffer::add(self : DsgraphdirectedBuffer, other : DsgraphdirectedBuffer) -> DsgraphdirectedBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedBuffer::copy(self : DsgraphdirectedBuffer) -> DsgraphdirectedBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedBuffer::fill(self : DsgraphdirectedBuffer, v : Double) -> DsgraphdirectedBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedBuffer::min(self : DsgraphdirectedBuffer) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedBuffer::max(self : DsgraphdirectedBuffer) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedBuffer::to_string(self : DsgraphdirectedBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_cursor_make(size : Int) -> DsgraphdirectedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedCursor::len(self : DsgraphdirectedCursor) -> Int { self.size }

pub fn DsgraphdirectedCursor::get(self : DsgraphdirectedCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedCursor::set(self : DsgraphdirectedCursor, i : Int, v : Double) -> DsgraphdirectedCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedCursor::sum(self : DsgraphdirectedCursor) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedCursor::mean(self : DsgraphdirectedCursor) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedCursor::scale(self : DsgraphdirectedCursor, f : Double) -> DsgraphdirectedCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedCursor::add(self : DsgraphdirectedCursor, other : DsgraphdirectedCursor) -> DsgraphdirectedCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedCursor::copy(self : DsgraphdirectedCursor) -> DsgraphdirectedCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedCursor::fill(self : DsgraphdirectedCursor, v : Double) -> DsgraphdirectedCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedCursor::min(self : DsgraphdirectedCursor) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedCursor::max(self : DsgraphdirectedCursor) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedCursor::to_string(self : DsgraphdirectedCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_view_make(size : Int) -> DsgraphdirectedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedView::len(self : DsgraphdirectedView) -> Int { self.size }

pub fn DsgraphdirectedView::get(self : DsgraphdirectedView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedView::set(self : DsgraphdirectedView, i : Int, v : Double) -> DsgraphdirectedView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedView::sum(self : DsgraphdirectedView) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedView::mean(self : DsgraphdirectedView) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedView::scale(self : DsgraphdirectedView, f : Double) -> DsgraphdirectedView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedView::add(self : DsgraphdirectedView, other : DsgraphdirectedView) -> DsgraphdirectedView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedView::copy(self : DsgraphdirectedView) -> DsgraphdirectedView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedView::fill(self : DsgraphdirectedView, v : Double) -> DsgraphdirectedView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedView::min(self : DsgraphdirectedView) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedView::max(self : DsgraphdirectedView) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedView::to_string(self : DsgraphdirectedView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_range_make(size : Int) -> DsgraphdirectedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedRange::len(self : DsgraphdirectedRange) -> Int { self.size }

pub fn DsgraphdirectedRange::get(self : DsgraphdirectedRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedRange::set(self : DsgraphdirectedRange, i : Int, v : Double) -> DsgraphdirectedRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedRange::sum(self : DsgraphdirectedRange) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedRange::mean(self : DsgraphdirectedRange) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedRange::scale(self : DsgraphdirectedRange, f : Double) -> DsgraphdirectedRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedRange::add(self : DsgraphdirectedRange, other : DsgraphdirectedRange) -> DsgraphdirectedRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedRange::copy(self : DsgraphdirectedRange) -> DsgraphdirectedRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedRange::fill(self : DsgraphdirectedRange, v : Double) -> DsgraphdirectedRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedRange::min(self : DsgraphdirectedRange) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedRange::max(self : DsgraphdirectedRange) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedRange::to_string(self : DsgraphdirectedRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_slice_make(size : Int) -> DsgraphdirectedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdirectedSlice::len(self : DsgraphdirectedSlice) -> Int { self.size }

pub fn DsgraphdirectedSlice::get(self : DsgraphdirectedSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdirectedSlice::set(self : DsgraphdirectedSlice, i : Int, v : Double) -> DsgraphdirectedSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedSlice::sum(self : DsgraphdirectedSlice) -> Double { @_common.sum(self.data) }

pub fn DsgraphdirectedSlice::mean(self : DsgraphdirectedSlice) -> Double { @_common.mean(self.data) }

pub fn DsgraphdirectedSlice::scale(self : DsgraphdirectedSlice, f : Double) -> DsgraphdirectedSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedSlice::add(self : DsgraphdirectedSlice, other : DsgraphdirectedSlice) -> DsgraphdirectedSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdirectedSlice::copy(self : DsgraphdirectedSlice) -> DsgraphdirectedSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedSlice::fill(self : DsgraphdirectedSlice, v : Double) -> DsgraphdirectedSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdirectedSlice::min(self : DsgraphdirectedSlice) -> Double { @_common.min(self.data) }

pub fn DsgraphdirectedSlice::max(self : DsgraphdirectedSlice) -> Double { @_common.max(self.data) }

pub fn DsgraphdirectedSlice::to_string(self : DsgraphdirectedSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

