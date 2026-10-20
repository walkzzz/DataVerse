///===
/// extcore/ds_graph_dynamic

pub(all) struct DsgraphdynamicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_dynamic_make_point(x : Double, y : Double) -> DsgraphdynamicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_dynamic_make_point3(x : Double, y : Double, z : Double) -> DsgraphdynamicPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphdynamicPoint::x(self : DsgraphdynamicPoint) -> Double { self.x }

pub fn DsgraphdynamicPoint::y(self : DsgraphdynamicPoint) -> Double { self.y }

pub fn DsgraphdynamicPoint::z(self : DsgraphdynamicPoint) -> Double { self.z }

pub fn DsgraphdynamicPoint::label(self : DsgraphdynamicPoint) -> Int { self.label }

pub fn DsgraphdynamicPoint::dist(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphdynamicPoint::add(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphdynamicPoint::sub(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphdynamicPoint::scale(self : DsgraphdynamicPoint, s : Double) -> DsgraphdynamicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphdynamicPoint::dot(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphdynamicPoint::cross(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphdynamicPoint::norm(self : DsgraphdynamicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphdynamicPoint::normalize(self : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphdynamicPoint::negate(self : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphdynamicPoint::mid(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphdynamicPoint::lerp(self : DsgraphdynamicPoint, other : DsgraphdynamicPoint, t : Double) -> DsgraphdynamicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphdynamicPoint::to_string(self : DsgraphdynamicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphdynamicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_dynamic_make_series(vals : Array[Double], name : String) -> DsgraphdynamicSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphdynamicSeries::len(self : DsgraphdynamicSeries) -> Int { self.vals.length() }

pub fn DsgraphdynamicSeries::sum(self : DsgraphdynamicSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphdynamicSeries::mean(self : DsgraphdynamicSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphdynamicSeries::min(self : DsgraphdynamicSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphdynamicSeries::max(self : DsgraphdynamicSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphdynamicSeries::range(self : DsgraphdynamicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphdynamicSeries::variance(self : DsgraphdynamicSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphdynamicSeries::std(self : DsgraphdynamicSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphdynamicSeries::median(self : DsgraphdynamicSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphdynamicSeries::scale(self : DsgraphdynamicSeries, f : Double) -> DsgraphdynamicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphdynamicSeries::add(self : DsgraphdynamicSeries, other : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphdynamicSeries::sub(self : DsgraphdynamicSeries, other : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphdynamicSeries::normalize(self : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphdynamicSeries::cumsum(self : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphdynamicSeries::to_string(self : DsgraphdynamicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphdynamicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_dynamic_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphdynamicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_dynamic_matrix_identity(n : Int) -> DsgraphdynamicMatrix {
  let m = ds_graph_dynamic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphdynamicMatrix::get(self : DsgraphdynamicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphdynamicMatrix::transpose(self : DsgraphdynamicMatrix) -> DsgraphdynamicMatrix {
  let result = ds_graph_dynamic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphdynamicMatrix::add(self : DsgraphdynamicMatrix, other : DsgraphdynamicMatrix) -> DsgraphdynamicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_dynamic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphdynamicMatrix::scale(self : DsgraphdynamicMatrix, s : Double) -> DsgraphdynamicMatrix {
  let result = ds_graph_dynamic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphdynamicMatrix::multiply(self : DsgraphdynamicMatrix, other : DsgraphdynamicMatrix) -> DsgraphdynamicMatrix {
  if self.cols != other.rows { return ds_graph_dynamic_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_dynamic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsgraphdynamicMatrix::trace(self : DsgraphdynamicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphdynamicMatrix::det(self : DsgraphdynamicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphdynamicMatrix::norm(self : DsgraphdynamicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphdynamicMatrix::to_string(self : DsgraphdynamicMatrix) -> String {
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

pub(all) struct DsgraphdynamicVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_dynamic_make_vector(comps : Array[Double]) -> DsgraphdynamicVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_dynamic_vector_zero(dim : Int) -> DsgraphdynamicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphdynamicVector::add(self : DsgraphdynamicVector, other : DsgraphdynamicVector) -> DsgraphdynamicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphdynamicVector::sub(self : DsgraphdynamicVector, other : DsgraphdynamicVector) -> DsgraphdynamicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphdynamicVector::scale(self : DsgraphdynamicVector, s : Double) -> DsgraphdynamicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphdynamicVector::dot(self : DsgraphdynamicVector, other : DsgraphdynamicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphdynamicVector::norm(self : DsgraphdynamicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphdynamicVector::normalize(self : DsgraphdynamicVector) -> DsgraphdynamicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphdynamicVector::dist(self : DsgraphdynamicVector, other : DsgraphdynamicVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphdynamicVector::to_string(self : DsgraphdynamicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphdynamicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_frame_make(size : Int) -> DsgraphdynamicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicFrame::len(self : DsgraphdynamicFrame) -> Int { self.size }

pub fn DsgraphdynamicFrame::get(self : DsgraphdynamicFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicFrame::set(self : DsgraphdynamicFrame, i : Int, v : Double) -> DsgraphdynamicFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicFrame::sum(self : DsgraphdynamicFrame) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicFrame::mean(self : DsgraphdynamicFrame) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicFrame::scale(self : DsgraphdynamicFrame, f : Double) -> DsgraphdynamicFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicFrame::add(self : DsgraphdynamicFrame, other : DsgraphdynamicFrame) -> DsgraphdynamicFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicFrame::copy(self : DsgraphdynamicFrame) -> DsgraphdynamicFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicFrame::fill(self : DsgraphdynamicFrame, v : Double) -> DsgraphdynamicFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicFrame::min(self : DsgraphdynamicFrame) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicFrame::max(self : DsgraphdynamicFrame) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicFrame::to_string(self : DsgraphdynamicFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_table_make(size : Int) -> DsgraphdynamicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicTable::len(self : DsgraphdynamicTable) -> Int { self.size }

pub fn DsgraphdynamicTable::get(self : DsgraphdynamicTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicTable::set(self : DsgraphdynamicTable, i : Int, v : Double) -> DsgraphdynamicTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicTable::sum(self : DsgraphdynamicTable) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicTable::mean(self : DsgraphdynamicTable) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicTable::scale(self : DsgraphdynamicTable, f : Double) -> DsgraphdynamicTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicTable::add(self : DsgraphdynamicTable, other : DsgraphdynamicTable) -> DsgraphdynamicTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicTable::copy(self : DsgraphdynamicTable) -> DsgraphdynamicTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicTable::fill(self : DsgraphdynamicTable, v : Double) -> DsgraphdynamicTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicTable::min(self : DsgraphdynamicTable) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicTable::max(self : DsgraphdynamicTable) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicTable::to_string(self : DsgraphdynamicTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_graphn_make(size : Int) -> DsgraphdynamicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicGraphN::len(self : DsgraphdynamicGraphN) -> Int { self.size }

pub fn DsgraphdynamicGraphN::get(self : DsgraphdynamicGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicGraphN::set(self : DsgraphdynamicGraphN, i : Int, v : Double) -> DsgraphdynamicGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicGraphN::sum(self : DsgraphdynamicGraphN) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicGraphN::mean(self : DsgraphdynamicGraphN) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicGraphN::scale(self : DsgraphdynamicGraphN, f : Double) -> DsgraphdynamicGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicGraphN::add(self : DsgraphdynamicGraphN, other : DsgraphdynamicGraphN) -> DsgraphdynamicGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicGraphN::copy(self : DsgraphdynamicGraphN) -> DsgraphdynamicGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicGraphN::fill(self : DsgraphdynamicGraphN, v : Double) -> DsgraphdynamicGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicGraphN::min(self : DsgraphdynamicGraphN) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicGraphN::max(self : DsgraphdynamicGraphN) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicGraphN::to_string(self : DsgraphdynamicGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_node_make(size : Int) -> DsgraphdynamicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicNode::len(self : DsgraphdynamicNode) -> Int { self.size }

pub fn DsgraphdynamicNode::get(self : DsgraphdynamicNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicNode::set(self : DsgraphdynamicNode, i : Int, v : Double) -> DsgraphdynamicNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicNode::sum(self : DsgraphdynamicNode) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicNode::mean(self : DsgraphdynamicNode) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicNode::scale(self : DsgraphdynamicNode, f : Double) -> DsgraphdynamicNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicNode::add(self : DsgraphdynamicNode, other : DsgraphdynamicNode) -> DsgraphdynamicNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicNode::copy(self : DsgraphdynamicNode) -> DsgraphdynamicNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicNode::fill(self : DsgraphdynamicNode, v : Double) -> DsgraphdynamicNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicNode::min(self : DsgraphdynamicNode) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicNode::max(self : DsgraphdynamicNode) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicNode::to_string(self : DsgraphdynamicNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_edge_make(size : Int) -> DsgraphdynamicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicEdge::len(self : DsgraphdynamicEdge) -> Int { self.size }

pub fn DsgraphdynamicEdge::get(self : DsgraphdynamicEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicEdge::set(self : DsgraphdynamicEdge, i : Int, v : Double) -> DsgraphdynamicEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicEdge::sum(self : DsgraphdynamicEdge) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicEdge::mean(self : DsgraphdynamicEdge) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicEdge::scale(self : DsgraphdynamicEdge, f : Double) -> DsgraphdynamicEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicEdge::add(self : DsgraphdynamicEdge, other : DsgraphdynamicEdge) -> DsgraphdynamicEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicEdge::copy(self : DsgraphdynamicEdge) -> DsgraphdynamicEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicEdge::fill(self : DsgraphdynamicEdge, v : Double) -> DsgraphdynamicEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicEdge::min(self : DsgraphdynamicEdge) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicEdge::max(self : DsgraphdynamicEdge) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicEdge::to_string(self : DsgraphdynamicEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_path_make(size : Int) -> DsgraphdynamicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicPath::len(self : DsgraphdynamicPath) -> Int { self.size }

pub fn DsgraphdynamicPath::get(self : DsgraphdynamicPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicPath::set(self : DsgraphdynamicPath, i : Int, v : Double) -> DsgraphdynamicPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicPath::sum(self : DsgraphdynamicPath) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicPath::mean(self : DsgraphdynamicPath) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicPath::scale(self : DsgraphdynamicPath, f : Double) -> DsgraphdynamicPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicPath::add(self : DsgraphdynamicPath, other : DsgraphdynamicPath) -> DsgraphdynamicPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicPath::copy(self : DsgraphdynamicPath) -> DsgraphdynamicPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicPath::fill(self : DsgraphdynamicPath, v : Double) -> DsgraphdynamicPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicPath::min(self : DsgraphdynamicPath) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicPath::max(self : DsgraphdynamicPath) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicPath::to_string(self : DsgraphdynamicPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_cluster_make(size : Int) -> DsgraphdynamicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicCluster::len(self : DsgraphdynamicCluster) -> Int { self.size }

pub fn DsgraphdynamicCluster::get(self : DsgraphdynamicCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicCluster::set(self : DsgraphdynamicCluster, i : Int, v : Double) -> DsgraphdynamicCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicCluster::sum(self : DsgraphdynamicCluster) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicCluster::mean(self : DsgraphdynamicCluster) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicCluster::scale(self : DsgraphdynamicCluster, f : Double) -> DsgraphdynamicCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicCluster::add(self : DsgraphdynamicCluster, other : DsgraphdynamicCluster) -> DsgraphdynamicCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicCluster::copy(self : DsgraphdynamicCluster) -> DsgraphdynamicCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicCluster::fill(self : DsgraphdynamicCluster, v : Double) -> DsgraphdynamicCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicCluster::min(self : DsgraphdynamicCluster) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicCluster::max(self : DsgraphdynamicCluster) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicCluster::to_string(self : DsgraphdynamicCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_model_make(size : Int) -> DsgraphdynamicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicModel::len(self : DsgraphdynamicModel) -> Int { self.size }

pub fn DsgraphdynamicModel::get(self : DsgraphdynamicModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicModel::set(self : DsgraphdynamicModel, i : Int, v : Double) -> DsgraphdynamicModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicModel::sum(self : DsgraphdynamicModel) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicModel::mean(self : DsgraphdynamicModel) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicModel::scale(self : DsgraphdynamicModel, f : Double) -> DsgraphdynamicModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicModel::add(self : DsgraphdynamicModel, other : DsgraphdynamicModel) -> DsgraphdynamicModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicModel::copy(self : DsgraphdynamicModel) -> DsgraphdynamicModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicModel::fill(self : DsgraphdynamicModel, v : Double) -> DsgraphdynamicModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicModel::min(self : DsgraphdynamicModel) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicModel::max(self : DsgraphdynamicModel) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicModel::to_string(self : DsgraphdynamicModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_layer_make(size : Int) -> DsgraphdynamicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicLayer::len(self : DsgraphdynamicLayer) -> Int { self.size }

pub fn DsgraphdynamicLayer::get(self : DsgraphdynamicLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicLayer::set(self : DsgraphdynamicLayer, i : Int, v : Double) -> DsgraphdynamicLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicLayer::sum(self : DsgraphdynamicLayer) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicLayer::mean(self : DsgraphdynamicLayer) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicLayer::scale(self : DsgraphdynamicLayer, f : Double) -> DsgraphdynamicLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicLayer::add(self : DsgraphdynamicLayer, other : DsgraphdynamicLayer) -> DsgraphdynamicLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicLayer::copy(self : DsgraphdynamicLayer) -> DsgraphdynamicLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicLayer::fill(self : DsgraphdynamicLayer, v : Double) -> DsgraphdynamicLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicLayer::min(self : DsgraphdynamicLayer) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicLayer::max(self : DsgraphdynamicLayer) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicLayer::to_string(self : DsgraphdynamicLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_buffer_make(size : Int) -> DsgraphdynamicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicBuffer::len(self : DsgraphdynamicBuffer) -> Int { self.size }

pub fn DsgraphdynamicBuffer::get(self : DsgraphdynamicBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicBuffer::set(self : DsgraphdynamicBuffer, i : Int, v : Double) -> DsgraphdynamicBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicBuffer::sum(self : DsgraphdynamicBuffer) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicBuffer::mean(self : DsgraphdynamicBuffer) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicBuffer::scale(self : DsgraphdynamicBuffer, f : Double) -> DsgraphdynamicBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicBuffer::add(self : DsgraphdynamicBuffer, other : DsgraphdynamicBuffer) -> DsgraphdynamicBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicBuffer::copy(self : DsgraphdynamicBuffer) -> DsgraphdynamicBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicBuffer::fill(self : DsgraphdynamicBuffer, v : Double) -> DsgraphdynamicBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicBuffer::min(self : DsgraphdynamicBuffer) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicBuffer::max(self : DsgraphdynamicBuffer) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicBuffer::to_string(self : DsgraphdynamicBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_cursor_make(size : Int) -> DsgraphdynamicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicCursor::len(self : DsgraphdynamicCursor) -> Int { self.size }

pub fn DsgraphdynamicCursor::get(self : DsgraphdynamicCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicCursor::set(self : DsgraphdynamicCursor, i : Int, v : Double) -> DsgraphdynamicCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicCursor::sum(self : DsgraphdynamicCursor) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicCursor::mean(self : DsgraphdynamicCursor) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicCursor::scale(self : DsgraphdynamicCursor, f : Double) -> DsgraphdynamicCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicCursor::add(self : DsgraphdynamicCursor, other : DsgraphdynamicCursor) -> DsgraphdynamicCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicCursor::copy(self : DsgraphdynamicCursor) -> DsgraphdynamicCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicCursor::fill(self : DsgraphdynamicCursor, v : Double) -> DsgraphdynamicCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicCursor::min(self : DsgraphdynamicCursor) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicCursor::max(self : DsgraphdynamicCursor) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicCursor::to_string(self : DsgraphdynamicCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_view_make(size : Int) -> DsgraphdynamicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicView::len(self : DsgraphdynamicView) -> Int { self.size }

pub fn DsgraphdynamicView::get(self : DsgraphdynamicView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicView::set(self : DsgraphdynamicView, i : Int, v : Double) -> DsgraphdynamicView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicView::sum(self : DsgraphdynamicView) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicView::mean(self : DsgraphdynamicView) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicView::scale(self : DsgraphdynamicView, f : Double) -> DsgraphdynamicView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicView::add(self : DsgraphdynamicView, other : DsgraphdynamicView) -> DsgraphdynamicView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicView::copy(self : DsgraphdynamicView) -> DsgraphdynamicView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicView::fill(self : DsgraphdynamicView, v : Double) -> DsgraphdynamicView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicView::min(self : DsgraphdynamicView) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicView::max(self : DsgraphdynamicView) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicView::to_string(self : DsgraphdynamicView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_range_make(size : Int) -> DsgraphdynamicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicRange::len(self : DsgraphdynamicRange) -> Int { self.size }

pub fn DsgraphdynamicRange::get(self : DsgraphdynamicRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicRange::set(self : DsgraphdynamicRange, i : Int, v : Double) -> DsgraphdynamicRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicRange::sum(self : DsgraphdynamicRange) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicRange::mean(self : DsgraphdynamicRange) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicRange::scale(self : DsgraphdynamicRange, f : Double) -> DsgraphdynamicRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicRange::add(self : DsgraphdynamicRange, other : DsgraphdynamicRange) -> DsgraphdynamicRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicRange::copy(self : DsgraphdynamicRange) -> DsgraphdynamicRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicRange::fill(self : DsgraphdynamicRange, v : Double) -> DsgraphdynamicRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicRange::min(self : DsgraphdynamicRange) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicRange::max(self : DsgraphdynamicRange) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicRange::to_string(self : DsgraphdynamicRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_slice_make(size : Int) -> DsgraphdynamicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphdynamicSlice::len(self : DsgraphdynamicSlice) -> Int { self.size }

pub fn DsgraphdynamicSlice::get(self : DsgraphdynamicSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphdynamicSlice::set(self : DsgraphdynamicSlice, i : Int, v : Double) -> DsgraphdynamicSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicSlice::sum(self : DsgraphdynamicSlice) -> Double { @_common.sum(self.data) }

pub fn DsgraphdynamicSlice::mean(self : DsgraphdynamicSlice) -> Double { @_common.mean(self.data) }

pub fn DsgraphdynamicSlice::scale(self : DsgraphdynamicSlice, f : Double) -> DsgraphdynamicSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicSlice::add(self : DsgraphdynamicSlice, other : DsgraphdynamicSlice) -> DsgraphdynamicSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphdynamicSlice::copy(self : DsgraphdynamicSlice) -> DsgraphdynamicSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicSlice::fill(self : DsgraphdynamicSlice, v : Double) -> DsgraphdynamicSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphdynamicSlice::min(self : DsgraphdynamicSlice) -> Double { @_common.min(self.data) }

pub fn DsgraphdynamicSlice::max(self : DsgraphdynamicSlice) -> Double { @_common.max(self.data) }

pub fn DsgraphdynamicSlice::to_string(self : DsgraphdynamicSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

