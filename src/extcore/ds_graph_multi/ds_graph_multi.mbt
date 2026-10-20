///===
/// extcore/ds_graph_multi

pub(all) struct DsgraphmultiPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_multi_make_point(x : Double, y : Double) -> DsgraphmultiPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_multi_make_point3(x : Double, y : Double, z : Double) -> DsgraphmultiPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphmultiPoint::x(self : DsgraphmultiPoint) -> Double { self.x }

pub fn DsgraphmultiPoint::y(self : DsgraphmultiPoint) -> Double { self.y }

pub fn DsgraphmultiPoint::z(self : DsgraphmultiPoint) -> Double { self.z }

pub fn DsgraphmultiPoint::label(self : DsgraphmultiPoint) -> Int { self.label }

pub fn DsgraphmultiPoint::dist(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphmultiPoint::add(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphmultiPoint::sub(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphmultiPoint::scale(self : DsgraphmultiPoint, s : Double) -> DsgraphmultiPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphmultiPoint::dot(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphmultiPoint::cross(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphmultiPoint::norm(self : DsgraphmultiPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphmultiPoint::normalize(self : DsgraphmultiPoint) -> DsgraphmultiPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphmultiPoint::negate(self : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphmultiPoint::mid(self : DsgraphmultiPoint, other : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphmultiPoint::lerp(self : DsgraphmultiPoint, other : DsgraphmultiPoint, t : Double) -> DsgraphmultiPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphmultiPoint::to_string(self : DsgraphmultiPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphmultiSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_multi_make_series(vals : Array[Double], name : String) -> DsgraphmultiSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphmultiSeries::len(self : DsgraphmultiSeries) -> Int { self.vals.length() }

pub fn DsgraphmultiSeries::sum(self : DsgraphmultiSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphmultiSeries::mean(self : DsgraphmultiSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphmultiSeries::min(self : DsgraphmultiSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphmultiSeries::max(self : DsgraphmultiSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphmultiSeries::range(self : DsgraphmultiSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphmultiSeries::variance(self : DsgraphmultiSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphmultiSeries::std(self : DsgraphmultiSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphmultiSeries::median(self : DsgraphmultiSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphmultiSeries::scale(self : DsgraphmultiSeries, f : Double) -> DsgraphmultiSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphmultiSeries::add(self : DsgraphmultiSeries, other : DsgraphmultiSeries) -> DsgraphmultiSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphmultiSeries::sub(self : DsgraphmultiSeries, other : DsgraphmultiSeries) -> DsgraphmultiSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphmultiSeries::normalize(self : DsgraphmultiSeries) -> DsgraphmultiSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphmultiSeries::cumsum(self : DsgraphmultiSeries) -> DsgraphmultiSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphmultiSeries::to_string(self : DsgraphmultiSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphmultiMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_multi_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphmultiMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ds_graph_multi_matrix_identity(n : Int) -> DsgraphmultiMatrix {
  let m = ds_graph_multi_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphmultiMatrix::get(self : DsgraphmultiMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphmultiMatrix::transpose(self : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  let result = ds_graph_multi_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphmultiMatrix::add(self : DsgraphmultiMatrix, other : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_multi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphmultiMatrix::scale(self : DsgraphmultiMatrix, s : Double) -> DsgraphmultiMatrix {
  let result = ds_graph_multi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphmultiMatrix::multiply(self : DsgraphmultiMatrix, other : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  if self.cols != other.rows { return ds_graph_multi_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_multi_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DsgraphmultiMatrix::trace(self : DsgraphmultiMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphmultiMatrix::det(self : DsgraphmultiMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphmultiMatrix::norm(self : DsgraphmultiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphmultiMatrix::to_string(self : DsgraphmultiMatrix) -> String {
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

pub(all) struct DsgraphmultiVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_multi_make_vector(comps : Array[Double]) -> DsgraphmultiVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_multi_vector_zero(dim : Int) -> DsgraphmultiVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphmultiVector::add(self : DsgraphmultiVector, other : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphmultiVector::sub(self : DsgraphmultiVector, other : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphmultiVector::scale(self : DsgraphmultiVector, s : Double) -> DsgraphmultiVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphmultiVector::dot(self : DsgraphmultiVector, other : DsgraphmultiVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphmultiVector::norm(self : DsgraphmultiVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphmultiVector::normalize(self : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphmultiVector::dist(self : DsgraphmultiVector, other : DsgraphmultiVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphmultiVector::to_string(self : DsgraphmultiVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphmultiFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_frame_make(size : Int) -> DsgraphmultiFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiFrame::len(self : DsgraphmultiFrame) -> Int { self.size }

pub fn DsgraphmultiFrame::get(self : DsgraphmultiFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiFrame::set(self : DsgraphmultiFrame, i : Int, v : Double) -> DsgraphmultiFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiFrame::sum(self : DsgraphmultiFrame) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiFrame::mean(self : DsgraphmultiFrame) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiFrame::scale(self : DsgraphmultiFrame, f : Double) -> DsgraphmultiFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiFrame::add(self : DsgraphmultiFrame, other : DsgraphmultiFrame) -> DsgraphmultiFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiFrame::copy(self : DsgraphmultiFrame) -> DsgraphmultiFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiFrame::fill(self : DsgraphmultiFrame, v : Double) -> DsgraphmultiFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiFrame::min(self : DsgraphmultiFrame) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiFrame::max(self : DsgraphmultiFrame) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiFrame::to_string(self : DsgraphmultiFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_table_make(size : Int) -> DsgraphmultiTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiTable::len(self : DsgraphmultiTable) -> Int { self.size }

pub fn DsgraphmultiTable::get(self : DsgraphmultiTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiTable::set(self : DsgraphmultiTable, i : Int, v : Double) -> DsgraphmultiTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiTable::sum(self : DsgraphmultiTable) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiTable::mean(self : DsgraphmultiTable) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiTable::scale(self : DsgraphmultiTable, f : Double) -> DsgraphmultiTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiTable::add(self : DsgraphmultiTable, other : DsgraphmultiTable) -> DsgraphmultiTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiTable::copy(self : DsgraphmultiTable) -> DsgraphmultiTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiTable::fill(self : DsgraphmultiTable, v : Double) -> DsgraphmultiTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiTable::min(self : DsgraphmultiTable) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiTable::max(self : DsgraphmultiTable) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiTable::to_string(self : DsgraphmultiTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_graphn_make(size : Int) -> DsgraphmultiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiGraphN::len(self : DsgraphmultiGraphN) -> Int { self.size }

pub fn DsgraphmultiGraphN::get(self : DsgraphmultiGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiGraphN::set(self : DsgraphmultiGraphN, i : Int, v : Double) -> DsgraphmultiGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiGraphN::sum(self : DsgraphmultiGraphN) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiGraphN::mean(self : DsgraphmultiGraphN) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiGraphN::scale(self : DsgraphmultiGraphN, f : Double) -> DsgraphmultiGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiGraphN::add(self : DsgraphmultiGraphN, other : DsgraphmultiGraphN) -> DsgraphmultiGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiGraphN::copy(self : DsgraphmultiGraphN) -> DsgraphmultiGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiGraphN::fill(self : DsgraphmultiGraphN, v : Double) -> DsgraphmultiGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiGraphN::min(self : DsgraphmultiGraphN) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiGraphN::max(self : DsgraphmultiGraphN) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiGraphN::to_string(self : DsgraphmultiGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_node_make(size : Int) -> DsgraphmultiNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiNode::len(self : DsgraphmultiNode) -> Int { self.size }

pub fn DsgraphmultiNode::get(self : DsgraphmultiNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiNode::set(self : DsgraphmultiNode, i : Int, v : Double) -> DsgraphmultiNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiNode::sum(self : DsgraphmultiNode) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiNode::mean(self : DsgraphmultiNode) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiNode::scale(self : DsgraphmultiNode, f : Double) -> DsgraphmultiNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiNode::add(self : DsgraphmultiNode, other : DsgraphmultiNode) -> DsgraphmultiNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiNode::copy(self : DsgraphmultiNode) -> DsgraphmultiNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiNode::fill(self : DsgraphmultiNode, v : Double) -> DsgraphmultiNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiNode::min(self : DsgraphmultiNode) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiNode::max(self : DsgraphmultiNode) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiNode::to_string(self : DsgraphmultiNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_edge_make(size : Int) -> DsgraphmultiEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiEdge::len(self : DsgraphmultiEdge) -> Int { self.size }

pub fn DsgraphmultiEdge::get(self : DsgraphmultiEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiEdge::set(self : DsgraphmultiEdge, i : Int, v : Double) -> DsgraphmultiEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiEdge::sum(self : DsgraphmultiEdge) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiEdge::mean(self : DsgraphmultiEdge) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiEdge::scale(self : DsgraphmultiEdge, f : Double) -> DsgraphmultiEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiEdge::add(self : DsgraphmultiEdge, other : DsgraphmultiEdge) -> DsgraphmultiEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiEdge::copy(self : DsgraphmultiEdge) -> DsgraphmultiEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiEdge::fill(self : DsgraphmultiEdge, v : Double) -> DsgraphmultiEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiEdge::min(self : DsgraphmultiEdge) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiEdge::max(self : DsgraphmultiEdge) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiEdge::to_string(self : DsgraphmultiEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_path_make(size : Int) -> DsgraphmultiPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiPath::len(self : DsgraphmultiPath) -> Int { self.size }

pub fn DsgraphmultiPath::get(self : DsgraphmultiPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiPath::set(self : DsgraphmultiPath, i : Int, v : Double) -> DsgraphmultiPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiPath::sum(self : DsgraphmultiPath) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiPath::mean(self : DsgraphmultiPath) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiPath::scale(self : DsgraphmultiPath, f : Double) -> DsgraphmultiPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiPath::add(self : DsgraphmultiPath, other : DsgraphmultiPath) -> DsgraphmultiPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiPath::copy(self : DsgraphmultiPath) -> DsgraphmultiPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiPath::fill(self : DsgraphmultiPath, v : Double) -> DsgraphmultiPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiPath::min(self : DsgraphmultiPath) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiPath::max(self : DsgraphmultiPath) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiPath::to_string(self : DsgraphmultiPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_cluster_make(size : Int) -> DsgraphmultiCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiCluster::len(self : DsgraphmultiCluster) -> Int { self.size }

pub fn DsgraphmultiCluster::get(self : DsgraphmultiCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiCluster::set(self : DsgraphmultiCluster, i : Int, v : Double) -> DsgraphmultiCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiCluster::sum(self : DsgraphmultiCluster) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiCluster::mean(self : DsgraphmultiCluster) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiCluster::scale(self : DsgraphmultiCluster, f : Double) -> DsgraphmultiCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiCluster::add(self : DsgraphmultiCluster, other : DsgraphmultiCluster) -> DsgraphmultiCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiCluster::copy(self : DsgraphmultiCluster) -> DsgraphmultiCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiCluster::fill(self : DsgraphmultiCluster, v : Double) -> DsgraphmultiCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiCluster::min(self : DsgraphmultiCluster) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiCluster::max(self : DsgraphmultiCluster) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiCluster::to_string(self : DsgraphmultiCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_model_make(size : Int) -> DsgraphmultiModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiModel::len(self : DsgraphmultiModel) -> Int { self.size }

pub fn DsgraphmultiModel::get(self : DsgraphmultiModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiModel::set(self : DsgraphmultiModel, i : Int, v : Double) -> DsgraphmultiModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiModel::sum(self : DsgraphmultiModel) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiModel::mean(self : DsgraphmultiModel) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiModel::scale(self : DsgraphmultiModel, f : Double) -> DsgraphmultiModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiModel::add(self : DsgraphmultiModel, other : DsgraphmultiModel) -> DsgraphmultiModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiModel::copy(self : DsgraphmultiModel) -> DsgraphmultiModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiModel::fill(self : DsgraphmultiModel, v : Double) -> DsgraphmultiModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiModel::min(self : DsgraphmultiModel) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiModel::max(self : DsgraphmultiModel) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiModel::to_string(self : DsgraphmultiModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_layer_make(size : Int) -> DsgraphmultiLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiLayer::len(self : DsgraphmultiLayer) -> Int { self.size }

pub fn DsgraphmultiLayer::get(self : DsgraphmultiLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiLayer::set(self : DsgraphmultiLayer, i : Int, v : Double) -> DsgraphmultiLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiLayer::sum(self : DsgraphmultiLayer) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiLayer::mean(self : DsgraphmultiLayer) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiLayer::scale(self : DsgraphmultiLayer, f : Double) -> DsgraphmultiLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiLayer::add(self : DsgraphmultiLayer, other : DsgraphmultiLayer) -> DsgraphmultiLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiLayer::copy(self : DsgraphmultiLayer) -> DsgraphmultiLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiLayer::fill(self : DsgraphmultiLayer, v : Double) -> DsgraphmultiLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiLayer::min(self : DsgraphmultiLayer) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiLayer::max(self : DsgraphmultiLayer) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiLayer::to_string(self : DsgraphmultiLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_buffer_make(size : Int) -> DsgraphmultiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiBuffer::len(self : DsgraphmultiBuffer) -> Int { self.size }

pub fn DsgraphmultiBuffer::get(self : DsgraphmultiBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiBuffer::set(self : DsgraphmultiBuffer, i : Int, v : Double) -> DsgraphmultiBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiBuffer::sum(self : DsgraphmultiBuffer) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiBuffer::mean(self : DsgraphmultiBuffer) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiBuffer::scale(self : DsgraphmultiBuffer, f : Double) -> DsgraphmultiBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiBuffer::add(self : DsgraphmultiBuffer, other : DsgraphmultiBuffer) -> DsgraphmultiBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiBuffer::copy(self : DsgraphmultiBuffer) -> DsgraphmultiBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiBuffer::fill(self : DsgraphmultiBuffer, v : Double) -> DsgraphmultiBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiBuffer::min(self : DsgraphmultiBuffer) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiBuffer::max(self : DsgraphmultiBuffer) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiBuffer::to_string(self : DsgraphmultiBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_cursor_make(size : Int) -> DsgraphmultiCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiCursor::len(self : DsgraphmultiCursor) -> Int { self.size }

pub fn DsgraphmultiCursor::get(self : DsgraphmultiCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiCursor::set(self : DsgraphmultiCursor, i : Int, v : Double) -> DsgraphmultiCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiCursor::sum(self : DsgraphmultiCursor) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiCursor::mean(self : DsgraphmultiCursor) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiCursor::scale(self : DsgraphmultiCursor, f : Double) -> DsgraphmultiCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiCursor::add(self : DsgraphmultiCursor, other : DsgraphmultiCursor) -> DsgraphmultiCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiCursor::copy(self : DsgraphmultiCursor) -> DsgraphmultiCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiCursor::fill(self : DsgraphmultiCursor, v : Double) -> DsgraphmultiCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiCursor::min(self : DsgraphmultiCursor) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiCursor::max(self : DsgraphmultiCursor) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiCursor::to_string(self : DsgraphmultiCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_view_make(size : Int) -> DsgraphmultiView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiView::len(self : DsgraphmultiView) -> Int { self.size }

pub fn DsgraphmultiView::get(self : DsgraphmultiView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiView::set(self : DsgraphmultiView, i : Int, v : Double) -> DsgraphmultiView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiView::sum(self : DsgraphmultiView) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiView::mean(self : DsgraphmultiView) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiView::scale(self : DsgraphmultiView, f : Double) -> DsgraphmultiView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiView::add(self : DsgraphmultiView, other : DsgraphmultiView) -> DsgraphmultiView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiView::copy(self : DsgraphmultiView) -> DsgraphmultiView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiView::fill(self : DsgraphmultiView, v : Double) -> DsgraphmultiView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiView::min(self : DsgraphmultiView) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiView::max(self : DsgraphmultiView) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiView::to_string(self : DsgraphmultiView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_range_make(size : Int) -> DsgraphmultiRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiRange::len(self : DsgraphmultiRange) -> Int { self.size }

pub fn DsgraphmultiRange::get(self : DsgraphmultiRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiRange::set(self : DsgraphmultiRange, i : Int, v : Double) -> DsgraphmultiRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiRange::sum(self : DsgraphmultiRange) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiRange::mean(self : DsgraphmultiRange) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiRange::scale(self : DsgraphmultiRange, f : Double) -> DsgraphmultiRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiRange::add(self : DsgraphmultiRange, other : DsgraphmultiRange) -> DsgraphmultiRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiRange::copy(self : DsgraphmultiRange) -> DsgraphmultiRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiRange::fill(self : DsgraphmultiRange, v : Double) -> DsgraphmultiRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiRange::min(self : DsgraphmultiRange) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiRange::max(self : DsgraphmultiRange) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiRange::to_string(self : DsgraphmultiRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_slice_make(size : Int) -> DsgraphmultiSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphmultiSlice::len(self : DsgraphmultiSlice) -> Int { self.size }

pub fn DsgraphmultiSlice::get(self : DsgraphmultiSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphmultiSlice::set(self : DsgraphmultiSlice, i : Int, v : Double) -> DsgraphmultiSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphmultiSlice::sum(self : DsgraphmultiSlice) -> Double { @_common.sum(self.data) }

pub fn DsgraphmultiSlice::mean(self : DsgraphmultiSlice) -> Double { @_common.mean(self.data) }

pub fn DsgraphmultiSlice::scale(self : DsgraphmultiSlice, f : Double) -> DsgraphmultiSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiSlice::add(self : DsgraphmultiSlice, other : DsgraphmultiSlice) -> DsgraphmultiSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphmultiSlice::copy(self : DsgraphmultiSlice) -> DsgraphmultiSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiSlice::fill(self : DsgraphmultiSlice, v : Double) -> DsgraphmultiSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphmultiSlice::min(self : DsgraphmultiSlice) -> Double { @_common.min(self.data) }

pub fn DsgraphmultiSlice::max(self : DsgraphmultiSlice) -> Double { @_common.max(self.data) }

pub fn DsgraphmultiSlice::to_string(self : DsgraphmultiSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

