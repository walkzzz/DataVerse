///===
/// extcore/ds_graph_adj_matrix

pub(all) struct DsgraphadjmatrixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_adj_matrix_make_point(x : Double, y : Double) -> DsgraphadjmatrixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_adj_matrix_make_point3(x : Double, y : Double, z : Double) -> DsgraphadjmatrixPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphadjmatrixPoint::x(self : DsgraphadjmatrixPoint) -> Double { self.x }

pub fn DsgraphadjmatrixPoint::y(self : DsgraphadjmatrixPoint) -> Double { self.y }

pub fn DsgraphadjmatrixPoint::z(self : DsgraphadjmatrixPoint) -> Double { self.z }

pub fn DsgraphadjmatrixPoint::label(self : DsgraphadjmatrixPoint) -> Int { self.label }

pub fn DsgraphadjmatrixPoint::dist(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphadjmatrixPoint::add(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphadjmatrixPoint::sub(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphadjmatrixPoint::scale(self : DsgraphadjmatrixPoint, s : Double) -> DsgraphadjmatrixPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphadjmatrixPoint::dot(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphadjmatrixPoint::cross(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphadjmatrixPoint::norm(self : DsgraphadjmatrixPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphadjmatrixPoint::normalize(self : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphadjmatrixPoint::negate(self : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphadjmatrixPoint::mid(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphadjmatrixPoint::lerp(self : DsgraphadjmatrixPoint, other : DsgraphadjmatrixPoint, t : Double) -> DsgraphadjmatrixPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphadjmatrixPoint::to_string(self : DsgraphadjmatrixPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_adj_matrix_make_series(vals : Array[Double], name : String) -> DsgraphadjmatrixSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphadjmatrixSeries::len(self : DsgraphadjmatrixSeries) -> Int { self.vals.length() }

pub fn DsgraphadjmatrixSeries::sum(self : DsgraphadjmatrixSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphadjmatrixSeries::mean(self : DsgraphadjmatrixSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphadjmatrixSeries::min(self : DsgraphadjmatrixSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphadjmatrixSeries::max(self : DsgraphadjmatrixSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphadjmatrixSeries::range(self : DsgraphadjmatrixSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphadjmatrixSeries::variance(self : DsgraphadjmatrixSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphadjmatrixSeries::std(self : DsgraphadjmatrixSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphadjmatrixSeries::median(self : DsgraphadjmatrixSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphadjmatrixSeries::scale(self : DsgraphadjmatrixSeries, f : Double) -> DsgraphadjmatrixSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphadjmatrixSeries::add(self : DsgraphadjmatrixSeries, other : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphadjmatrixSeries::sub(self : DsgraphadjmatrixSeries, other : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphadjmatrixSeries::normalize(self : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphadjmatrixSeries::cumsum(self : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphadjmatrixSeries::to_string(self : DsgraphadjmatrixSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphadjmatrixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_adj_matrix_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphadjmatrixMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ds_graph_adj_matrix_matrix_identity(n : Int) -> DsgraphadjmatrixMatrix {
  let m = ds_graph_adj_matrix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphadjmatrixMatrix::get(self : DsgraphadjmatrixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphadjmatrixMatrix::transpose(self : DsgraphadjmatrixMatrix) -> DsgraphadjmatrixMatrix {
  let result = ds_graph_adj_matrix_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphadjmatrixMatrix::add(self : DsgraphadjmatrixMatrix, other : DsgraphadjmatrixMatrix) -> DsgraphadjmatrixMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_adj_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphadjmatrixMatrix::scale(self : DsgraphadjmatrixMatrix, s : Double) -> DsgraphadjmatrixMatrix {
  let result = ds_graph_adj_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphadjmatrixMatrix::multiply(self : DsgraphadjmatrixMatrix, other : DsgraphadjmatrixMatrix) -> DsgraphadjmatrixMatrix {
  if self.cols != other.rows { return ds_graph_adj_matrix_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_adj_matrix_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DsgraphadjmatrixMatrix::trace(self : DsgraphadjmatrixMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphadjmatrixMatrix::det(self : DsgraphadjmatrixMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphadjmatrixMatrix::norm(self : DsgraphadjmatrixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphadjmatrixMatrix::to_string(self : DsgraphadjmatrixMatrix) -> String {
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

pub(all) struct DsgraphadjmatrixVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_adj_matrix_make_vector(comps : Array[Double]) -> DsgraphadjmatrixVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_adj_matrix_vector_zero(dim : Int) -> DsgraphadjmatrixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphadjmatrixVector::add(self : DsgraphadjmatrixVector, other : DsgraphadjmatrixVector) -> DsgraphadjmatrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphadjmatrixVector::sub(self : DsgraphadjmatrixVector, other : DsgraphadjmatrixVector) -> DsgraphadjmatrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphadjmatrixVector::scale(self : DsgraphadjmatrixVector, s : Double) -> DsgraphadjmatrixVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphadjmatrixVector::dot(self : DsgraphadjmatrixVector, other : DsgraphadjmatrixVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphadjmatrixVector::norm(self : DsgraphadjmatrixVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphadjmatrixVector::normalize(self : DsgraphadjmatrixVector) -> DsgraphadjmatrixVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphadjmatrixVector::dist(self : DsgraphadjmatrixVector, other : DsgraphadjmatrixVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphadjmatrixVector::to_string(self : DsgraphadjmatrixVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphadjmatrixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_frame_make(size : Int) -> DsgraphadjmatrixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixFrame::len(self : DsgraphadjmatrixFrame) -> Int { self.size }

pub fn DsgraphadjmatrixFrame::get(self : DsgraphadjmatrixFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixFrame::set(self : DsgraphadjmatrixFrame, i : Int, v : Double) -> DsgraphadjmatrixFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixFrame::sum(self : DsgraphadjmatrixFrame) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixFrame::mean(self : DsgraphadjmatrixFrame) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixFrame::scale(self : DsgraphadjmatrixFrame, f : Double) -> DsgraphadjmatrixFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixFrame::add(self : DsgraphadjmatrixFrame, other : DsgraphadjmatrixFrame) -> DsgraphadjmatrixFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixFrame::copy(self : DsgraphadjmatrixFrame) -> DsgraphadjmatrixFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixFrame::fill(self : DsgraphadjmatrixFrame, v : Double) -> DsgraphadjmatrixFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixFrame::min(self : DsgraphadjmatrixFrame) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixFrame::max(self : DsgraphadjmatrixFrame) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixFrame::to_string(self : DsgraphadjmatrixFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_table_make(size : Int) -> DsgraphadjmatrixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixTable::len(self : DsgraphadjmatrixTable) -> Int { self.size }

pub fn DsgraphadjmatrixTable::get(self : DsgraphadjmatrixTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixTable::set(self : DsgraphadjmatrixTable, i : Int, v : Double) -> DsgraphadjmatrixTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixTable::sum(self : DsgraphadjmatrixTable) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixTable::mean(self : DsgraphadjmatrixTable) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixTable::scale(self : DsgraphadjmatrixTable, f : Double) -> DsgraphadjmatrixTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixTable::add(self : DsgraphadjmatrixTable, other : DsgraphadjmatrixTable) -> DsgraphadjmatrixTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixTable::copy(self : DsgraphadjmatrixTable) -> DsgraphadjmatrixTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixTable::fill(self : DsgraphadjmatrixTable, v : Double) -> DsgraphadjmatrixTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixTable::min(self : DsgraphadjmatrixTable) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixTable::max(self : DsgraphadjmatrixTable) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixTable::to_string(self : DsgraphadjmatrixTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_graphn_make(size : Int) -> DsgraphadjmatrixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixGraphN::len(self : DsgraphadjmatrixGraphN) -> Int { self.size }

pub fn DsgraphadjmatrixGraphN::get(self : DsgraphadjmatrixGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixGraphN::set(self : DsgraphadjmatrixGraphN, i : Int, v : Double) -> DsgraphadjmatrixGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixGraphN::sum(self : DsgraphadjmatrixGraphN) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixGraphN::mean(self : DsgraphadjmatrixGraphN) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixGraphN::scale(self : DsgraphadjmatrixGraphN, f : Double) -> DsgraphadjmatrixGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixGraphN::add(self : DsgraphadjmatrixGraphN, other : DsgraphadjmatrixGraphN) -> DsgraphadjmatrixGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixGraphN::copy(self : DsgraphadjmatrixGraphN) -> DsgraphadjmatrixGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixGraphN::fill(self : DsgraphadjmatrixGraphN, v : Double) -> DsgraphadjmatrixGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixGraphN::min(self : DsgraphadjmatrixGraphN) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixGraphN::max(self : DsgraphadjmatrixGraphN) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixGraphN::to_string(self : DsgraphadjmatrixGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_node_make(size : Int) -> DsgraphadjmatrixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixNode::len(self : DsgraphadjmatrixNode) -> Int { self.size }

pub fn DsgraphadjmatrixNode::get(self : DsgraphadjmatrixNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixNode::set(self : DsgraphadjmatrixNode, i : Int, v : Double) -> DsgraphadjmatrixNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixNode::sum(self : DsgraphadjmatrixNode) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixNode::mean(self : DsgraphadjmatrixNode) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixNode::scale(self : DsgraphadjmatrixNode, f : Double) -> DsgraphadjmatrixNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixNode::add(self : DsgraphadjmatrixNode, other : DsgraphadjmatrixNode) -> DsgraphadjmatrixNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixNode::copy(self : DsgraphadjmatrixNode) -> DsgraphadjmatrixNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixNode::fill(self : DsgraphadjmatrixNode, v : Double) -> DsgraphadjmatrixNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixNode::min(self : DsgraphadjmatrixNode) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixNode::max(self : DsgraphadjmatrixNode) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixNode::to_string(self : DsgraphadjmatrixNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_edge_make(size : Int) -> DsgraphadjmatrixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixEdge::len(self : DsgraphadjmatrixEdge) -> Int { self.size }

pub fn DsgraphadjmatrixEdge::get(self : DsgraphadjmatrixEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixEdge::set(self : DsgraphadjmatrixEdge, i : Int, v : Double) -> DsgraphadjmatrixEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixEdge::sum(self : DsgraphadjmatrixEdge) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixEdge::mean(self : DsgraphadjmatrixEdge) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixEdge::scale(self : DsgraphadjmatrixEdge, f : Double) -> DsgraphadjmatrixEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixEdge::add(self : DsgraphadjmatrixEdge, other : DsgraphadjmatrixEdge) -> DsgraphadjmatrixEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixEdge::copy(self : DsgraphadjmatrixEdge) -> DsgraphadjmatrixEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixEdge::fill(self : DsgraphadjmatrixEdge, v : Double) -> DsgraphadjmatrixEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixEdge::min(self : DsgraphadjmatrixEdge) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixEdge::max(self : DsgraphadjmatrixEdge) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixEdge::to_string(self : DsgraphadjmatrixEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_path_make(size : Int) -> DsgraphadjmatrixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixPath::len(self : DsgraphadjmatrixPath) -> Int { self.size }

pub fn DsgraphadjmatrixPath::get(self : DsgraphadjmatrixPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixPath::set(self : DsgraphadjmatrixPath, i : Int, v : Double) -> DsgraphadjmatrixPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixPath::sum(self : DsgraphadjmatrixPath) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixPath::mean(self : DsgraphadjmatrixPath) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixPath::scale(self : DsgraphadjmatrixPath, f : Double) -> DsgraphadjmatrixPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixPath::add(self : DsgraphadjmatrixPath, other : DsgraphadjmatrixPath) -> DsgraphadjmatrixPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixPath::copy(self : DsgraphadjmatrixPath) -> DsgraphadjmatrixPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixPath::fill(self : DsgraphadjmatrixPath, v : Double) -> DsgraphadjmatrixPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixPath::min(self : DsgraphadjmatrixPath) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixPath::max(self : DsgraphadjmatrixPath) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixPath::to_string(self : DsgraphadjmatrixPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_cluster_make(size : Int) -> DsgraphadjmatrixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixCluster::len(self : DsgraphadjmatrixCluster) -> Int { self.size }

pub fn DsgraphadjmatrixCluster::get(self : DsgraphadjmatrixCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixCluster::set(self : DsgraphadjmatrixCluster, i : Int, v : Double) -> DsgraphadjmatrixCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixCluster::sum(self : DsgraphadjmatrixCluster) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixCluster::mean(self : DsgraphadjmatrixCluster) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixCluster::scale(self : DsgraphadjmatrixCluster, f : Double) -> DsgraphadjmatrixCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixCluster::add(self : DsgraphadjmatrixCluster, other : DsgraphadjmatrixCluster) -> DsgraphadjmatrixCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixCluster::copy(self : DsgraphadjmatrixCluster) -> DsgraphadjmatrixCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixCluster::fill(self : DsgraphadjmatrixCluster, v : Double) -> DsgraphadjmatrixCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixCluster::min(self : DsgraphadjmatrixCluster) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixCluster::max(self : DsgraphadjmatrixCluster) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixCluster::to_string(self : DsgraphadjmatrixCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_model_make(size : Int) -> DsgraphadjmatrixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixModel::len(self : DsgraphadjmatrixModel) -> Int { self.size }

pub fn DsgraphadjmatrixModel::get(self : DsgraphadjmatrixModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixModel::set(self : DsgraphadjmatrixModel, i : Int, v : Double) -> DsgraphadjmatrixModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixModel::sum(self : DsgraphadjmatrixModel) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixModel::mean(self : DsgraphadjmatrixModel) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixModel::scale(self : DsgraphadjmatrixModel, f : Double) -> DsgraphadjmatrixModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixModel::add(self : DsgraphadjmatrixModel, other : DsgraphadjmatrixModel) -> DsgraphadjmatrixModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixModel::copy(self : DsgraphadjmatrixModel) -> DsgraphadjmatrixModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixModel::fill(self : DsgraphadjmatrixModel, v : Double) -> DsgraphadjmatrixModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixModel::min(self : DsgraphadjmatrixModel) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixModel::max(self : DsgraphadjmatrixModel) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixModel::to_string(self : DsgraphadjmatrixModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_layer_make(size : Int) -> DsgraphadjmatrixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixLayer::len(self : DsgraphadjmatrixLayer) -> Int { self.size }

pub fn DsgraphadjmatrixLayer::get(self : DsgraphadjmatrixLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixLayer::set(self : DsgraphadjmatrixLayer, i : Int, v : Double) -> DsgraphadjmatrixLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixLayer::sum(self : DsgraphadjmatrixLayer) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixLayer::mean(self : DsgraphadjmatrixLayer) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixLayer::scale(self : DsgraphadjmatrixLayer, f : Double) -> DsgraphadjmatrixLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixLayer::add(self : DsgraphadjmatrixLayer, other : DsgraphadjmatrixLayer) -> DsgraphadjmatrixLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixLayer::copy(self : DsgraphadjmatrixLayer) -> DsgraphadjmatrixLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixLayer::fill(self : DsgraphadjmatrixLayer, v : Double) -> DsgraphadjmatrixLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixLayer::min(self : DsgraphadjmatrixLayer) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixLayer::max(self : DsgraphadjmatrixLayer) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixLayer::to_string(self : DsgraphadjmatrixLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_buffer_make(size : Int) -> DsgraphadjmatrixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixBuffer::len(self : DsgraphadjmatrixBuffer) -> Int { self.size }

pub fn DsgraphadjmatrixBuffer::get(self : DsgraphadjmatrixBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixBuffer::set(self : DsgraphadjmatrixBuffer, i : Int, v : Double) -> DsgraphadjmatrixBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixBuffer::sum(self : DsgraphadjmatrixBuffer) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixBuffer::mean(self : DsgraphadjmatrixBuffer) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixBuffer::scale(self : DsgraphadjmatrixBuffer, f : Double) -> DsgraphadjmatrixBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixBuffer::add(self : DsgraphadjmatrixBuffer, other : DsgraphadjmatrixBuffer) -> DsgraphadjmatrixBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixBuffer::copy(self : DsgraphadjmatrixBuffer) -> DsgraphadjmatrixBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixBuffer::fill(self : DsgraphadjmatrixBuffer, v : Double) -> DsgraphadjmatrixBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixBuffer::min(self : DsgraphadjmatrixBuffer) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixBuffer::max(self : DsgraphadjmatrixBuffer) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixBuffer::to_string(self : DsgraphadjmatrixBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_cursor_make(size : Int) -> DsgraphadjmatrixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixCursor::len(self : DsgraphadjmatrixCursor) -> Int { self.size }

pub fn DsgraphadjmatrixCursor::get(self : DsgraphadjmatrixCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixCursor::set(self : DsgraphadjmatrixCursor, i : Int, v : Double) -> DsgraphadjmatrixCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixCursor::sum(self : DsgraphadjmatrixCursor) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixCursor::mean(self : DsgraphadjmatrixCursor) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixCursor::scale(self : DsgraphadjmatrixCursor, f : Double) -> DsgraphadjmatrixCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixCursor::add(self : DsgraphadjmatrixCursor, other : DsgraphadjmatrixCursor) -> DsgraphadjmatrixCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixCursor::copy(self : DsgraphadjmatrixCursor) -> DsgraphadjmatrixCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixCursor::fill(self : DsgraphadjmatrixCursor, v : Double) -> DsgraphadjmatrixCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixCursor::min(self : DsgraphadjmatrixCursor) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixCursor::max(self : DsgraphadjmatrixCursor) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixCursor::to_string(self : DsgraphadjmatrixCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_view_make(size : Int) -> DsgraphadjmatrixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixView::len(self : DsgraphadjmatrixView) -> Int { self.size }

pub fn DsgraphadjmatrixView::get(self : DsgraphadjmatrixView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixView::set(self : DsgraphadjmatrixView, i : Int, v : Double) -> DsgraphadjmatrixView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixView::sum(self : DsgraphadjmatrixView) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixView::mean(self : DsgraphadjmatrixView) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixView::scale(self : DsgraphadjmatrixView, f : Double) -> DsgraphadjmatrixView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixView::add(self : DsgraphadjmatrixView, other : DsgraphadjmatrixView) -> DsgraphadjmatrixView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixView::copy(self : DsgraphadjmatrixView) -> DsgraphadjmatrixView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixView::fill(self : DsgraphadjmatrixView, v : Double) -> DsgraphadjmatrixView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixView::min(self : DsgraphadjmatrixView) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixView::max(self : DsgraphadjmatrixView) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixView::to_string(self : DsgraphadjmatrixView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_range_make(size : Int) -> DsgraphadjmatrixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixRange::len(self : DsgraphadjmatrixRange) -> Int { self.size }

pub fn DsgraphadjmatrixRange::get(self : DsgraphadjmatrixRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixRange::set(self : DsgraphadjmatrixRange, i : Int, v : Double) -> DsgraphadjmatrixRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixRange::sum(self : DsgraphadjmatrixRange) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixRange::mean(self : DsgraphadjmatrixRange) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixRange::scale(self : DsgraphadjmatrixRange, f : Double) -> DsgraphadjmatrixRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixRange::add(self : DsgraphadjmatrixRange, other : DsgraphadjmatrixRange) -> DsgraphadjmatrixRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixRange::copy(self : DsgraphadjmatrixRange) -> DsgraphadjmatrixRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixRange::fill(self : DsgraphadjmatrixRange, v : Double) -> DsgraphadjmatrixRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixRange::min(self : DsgraphadjmatrixRange) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixRange::max(self : DsgraphadjmatrixRange) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixRange::to_string(self : DsgraphadjmatrixRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_slice_make(size : Int) -> DsgraphadjmatrixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphadjmatrixSlice::len(self : DsgraphadjmatrixSlice) -> Int { self.size }

pub fn DsgraphadjmatrixSlice::get(self : DsgraphadjmatrixSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphadjmatrixSlice::set(self : DsgraphadjmatrixSlice, i : Int, v : Double) -> DsgraphadjmatrixSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixSlice::sum(self : DsgraphadjmatrixSlice) -> Double { @_common.sum(self.data) }

pub fn DsgraphadjmatrixSlice::mean(self : DsgraphadjmatrixSlice) -> Double { @_common.mean(self.data) }

pub fn DsgraphadjmatrixSlice::scale(self : DsgraphadjmatrixSlice, f : Double) -> DsgraphadjmatrixSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixSlice::add(self : DsgraphadjmatrixSlice, other : DsgraphadjmatrixSlice) -> DsgraphadjmatrixSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphadjmatrixSlice::copy(self : DsgraphadjmatrixSlice) -> DsgraphadjmatrixSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixSlice::fill(self : DsgraphadjmatrixSlice, v : Double) -> DsgraphadjmatrixSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphadjmatrixSlice::min(self : DsgraphadjmatrixSlice) -> Double { @_common.min(self.data) }

pub fn DsgraphadjmatrixSlice::max(self : DsgraphadjmatrixSlice) -> Double { @_common.max(self.data) }

pub fn DsgraphadjmatrixSlice::to_string(self : DsgraphadjmatrixSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

