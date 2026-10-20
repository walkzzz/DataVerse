///===
/// extcore/ds_graph_compact

pub(all) struct DsgraphcompactPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_compact_make_point(x : Double, y : Double) -> DsgraphcompactPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_compact_make_point3(x : Double, y : Double, z : Double) -> DsgraphcompactPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphcompactPoint::x(self : DsgraphcompactPoint) -> Double { self.x }

pub fn DsgraphcompactPoint::y(self : DsgraphcompactPoint) -> Double { self.y }

pub fn DsgraphcompactPoint::z(self : DsgraphcompactPoint) -> Double { self.z }

pub fn DsgraphcompactPoint::label(self : DsgraphcompactPoint) -> Int { self.label }

pub fn DsgraphcompactPoint::dist(self : DsgraphcompactPoint, other : DsgraphcompactPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphcompactPoint::add(self : DsgraphcompactPoint, other : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphcompactPoint::sub(self : DsgraphcompactPoint, other : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphcompactPoint::scale(self : DsgraphcompactPoint, s : Double) -> DsgraphcompactPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphcompactPoint::dot(self : DsgraphcompactPoint, other : DsgraphcompactPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphcompactPoint::cross(self : DsgraphcompactPoint, other : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphcompactPoint::norm(self : DsgraphcompactPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphcompactPoint::normalize(self : DsgraphcompactPoint) -> DsgraphcompactPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphcompactPoint::negate(self : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphcompactPoint::mid(self : DsgraphcompactPoint, other : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphcompactPoint::lerp(self : DsgraphcompactPoint, other : DsgraphcompactPoint, t : Double) -> DsgraphcompactPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphcompactPoint::to_string(self : DsgraphcompactPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphcompactSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_compact_make_series(vals : Array[Double], name : String) -> DsgraphcompactSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphcompactSeries::len(self : DsgraphcompactSeries) -> Int { self.vals.length() }

pub fn DsgraphcompactSeries::sum(self : DsgraphcompactSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphcompactSeries::mean(self : DsgraphcompactSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphcompactSeries::min(self : DsgraphcompactSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphcompactSeries::max(self : DsgraphcompactSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphcompactSeries::range(self : DsgraphcompactSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphcompactSeries::variance(self : DsgraphcompactSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphcompactSeries::std(self : DsgraphcompactSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphcompactSeries::median(self : DsgraphcompactSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphcompactSeries::scale(self : DsgraphcompactSeries, f : Double) -> DsgraphcompactSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphcompactSeries::add(self : DsgraphcompactSeries, other : DsgraphcompactSeries) -> DsgraphcompactSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphcompactSeries::sub(self : DsgraphcompactSeries, other : DsgraphcompactSeries) -> DsgraphcompactSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphcompactSeries::normalize(self : DsgraphcompactSeries) -> DsgraphcompactSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphcompactSeries::cumsum(self : DsgraphcompactSeries) -> DsgraphcompactSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphcompactSeries::to_string(self : DsgraphcompactSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphcompactMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_compact_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphcompactMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ds_graph_compact_matrix_identity(n : Int) -> DsgraphcompactMatrix {
  let m = ds_graph_compact_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphcompactMatrix::get(self : DsgraphcompactMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphcompactMatrix::transpose(self : DsgraphcompactMatrix) -> DsgraphcompactMatrix {
  let result = ds_graph_compact_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphcompactMatrix::add(self : DsgraphcompactMatrix, other : DsgraphcompactMatrix) -> DsgraphcompactMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_compact_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphcompactMatrix::scale(self : DsgraphcompactMatrix, s : Double) -> DsgraphcompactMatrix {
  let result = ds_graph_compact_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphcompactMatrix::multiply(self : DsgraphcompactMatrix, other : DsgraphcompactMatrix) -> DsgraphcompactMatrix {
  if self.cols != other.rows { return ds_graph_compact_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_compact_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DsgraphcompactMatrix::trace(self : DsgraphcompactMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphcompactMatrix::det(self : DsgraphcompactMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphcompactMatrix::norm(self : DsgraphcompactMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphcompactMatrix::to_string(self : DsgraphcompactMatrix) -> String {
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

pub(all) struct DsgraphcompactVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_compact_make_vector(comps : Array[Double]) -> DsgraphcompactVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_compact_vector_zero(dim : Int) -> DsgraphcompactVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphcompactVector::add(self : DsgraphcompactVector, other : DsgraphcompactVector) -> DsgraphcompactVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphcompactVector::sub(self : DsgraphcompactVector, other : DsgraphcompactVector) -> DsgraphcompactVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphcompactVector::scale(self : DsgraphcompactVector, s : Double) -> DsgraphcompactVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphcompactVector::dot(self : DsgraphcompactVector, other : DsgraphcompactVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphcompactVector::norm(self : DsgraphcompactVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphcompactVector::normalize(self : DsgraphcompactVector) -> DsgraphcompactVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphcompactVector::dist(self : DsgraphcompactVector, other : DsgraphcompactVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphcompactVector::to_string(self : DsgraphcompactVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphcompactFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_frame_make(size : Int) -> DsgraphcompactFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactFrame::len(self : DsgraphcompactFrame) -> Int { self.size }

pub fn DsgraphcompactFrame::get(self : DsgraphcompactFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactFrame::set(self : DsgraphcompactFrame, i : Int, v : Double) -> DsgraphcompactFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactFrame::sum(self : DsgraphcompactFrame) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactFrame::mean(self : DsgraphcompactFrame) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactFrame::scale(self : DsgraphcompactFrame, f : Double) -> DsgraphcompactFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactFrame::add(self : DsgraphcompactFrame, other : DsgraphcompactFrame) -> DsgraphcompactFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactFrame::copy(self : DsgraphcompactFrame) -> DsgraphcompactFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactFrame::fill(self : DsgraphcompactFrame, v : Double) -> DsgraphcompactFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactFrame::min(self : DsgraphcompactFrame) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactFrame::max(self : DsgraphcompactFrame) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactFrame::to_string(self : DsgraphcompactFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_table_make(size : Int) -> DsgraphcompactTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactTable::len(self : DsgraphcompactTable) -> Int { self.size }

pub fn DsgraphcompactTable::get(self : DsgraphcompactTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactTable::set(self : DsgraphcompactTable, i : Int, v : Double) -> DsgraphcompactTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactTable::sum(self : DsgraphcompactTable) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactTable::mean(self : DsgraphcompactTable) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactTable::scale(self : DsgraphcompactTable, f : Double) -> DsgraphcompactTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactTable::add(self : DsgraphcompactTable, other : DsgraphcompactTable) -> DsgraphcompactTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactTable::copy(self : DsgraphcompactTable) -> DsgraphcompactTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactTable::fill(self : DsgraphcompactTable, v : Double) -> DsgraphcompactTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactTable::min(self : DsgraphcompactTable) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactTable::max(self : DsgraphcompactTable) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactTable::to_string(self : DsgraphcompactTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_graphn_make(size : Int) -> DsgraphcompactGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactGraphN::len(self : DsgraphcompactGraphN) -> Int { self.size }

pub fn DsgraphcompactGraphN::get(self : DsgraphcompactGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactGraphN::set(self : DsgraphcompactGraphN, i : Int, v : Double) -> DsgraphcompactGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactGraphN::sum(self : DsgraphcompactGraphN) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactGraphN::mean(self : DsgraphcompactGraphN) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactGraphN::scale(self : DsgraphcompactGraphN, f : Double) -> DsgraphcompactGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactGraphN::add(self : DsgraphcompactGraphN, other : DsgraphcompactGraphN) -> DsgraphcompactGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactGraphN::copy(self : DsgraphcompactGraphN) -> DsgraphcompactGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactGraphN::fill(self : DsgraphcompactGraphN, v : Double) -> DsgraphcompactGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactGraphN::min(self : DsgraphcompactGraphN) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactGraphN::max(self : DsgraphcompactGraphN) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactGraphN::to_string(self : DsgraphcompactGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_node_make(size : Int) -> DsgraphcompactNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactNode::len(self : DsgraphcompactNode) -> Int { self.size }

pub fn DsgraphcompactNode::get(self : DsgraphcompactNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactNode::set(self : DsgraphcompactNode, i : Int, v : Double) -> DsgraphcompactNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactNode::sum(self : DsgraphcompactNode) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactNode::mean(self : DsgraphcompactNode) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactNode::scale(self : DsgraphcompactNode, f : Double) -> DsgraphcompactNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactNode::add(self : DsgraphcompactNode, other : DsgraphcompactNode) -> DsgraphcompactNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactNode::copy(self : DsgraphcompactNode) -> DsgraphcompactNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactNode::fill(self : DsgraphcompactNode, v : Double) -> DsgraphcompactNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactNode::min(self : DsgraphcompactNode) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactNode::max(self : DsgraphcompactNode) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactNode::to_string(self : DsgraphcompactNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_edge_make(size : Int) -> DsgraphcompactEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactEdge::len(self : DsgraphcompactEdge) -> Int { self.size }

pub fn DsgraphcompactEdge::get(self : DsgraphcompactEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactEdge::set(self : DsgraphcompactEdge, i : Int, v : Double) -> DsgraphcompactEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactEdge::sum(self : DsgraphcompactEdge) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactEdge::mean(self : DsgraphcompactEdge) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactEdge::scale(self : DsgraphcompactEdge, f : Double) -> DsgraphcompactEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactEdge::add(self : DsgraphcompactEdge, other : DsgraphcompactEdge) -> DsgraphcompactEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactEdge::copy(self : DsgraphcompactEdge) -> DsgraphcompactEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactEdge::fill(self : DsgraphcompactEdge, v : Double) -> DsgraphcompactEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactEdge::min(self : DsgraphcompactEdge) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactEdge::max(self : DsgraphcompactEdge) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactEdge::to_string(self : DsgraphcompactEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_path_make(size : Int) -> DsgraphcompactPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactPath::len(self : DsgraphcompactPath) -> Int { self.size }

pub fn DsgraphcompactPath::get(self : DsgraphcompactPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactPath::set(self : DsgraphcompactPath, i : Int, v : Double) -> DsgraphcompactPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactPath::sum(self : DsgraphcompactPath) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactPath::mean(self : DsgraphcompactPath) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactPath::scale(self : DsgraphcompactPath, f : Double) -> DsgraphcompactPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactPath::add(self : DsgraphcompactPath, other : DsgraphcompactPath) -> DsgraphcompactPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactPath::copy(self : DsgraphcompactPath) -> DsgraphcompactPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactPath::fill(self : DsgraphcompactPath, v : Double) -> DsgraphcompactPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactPath::min(self : DsgraphcompactPath) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactPath::max(self : DsgraphcompactPath) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactPath::to_string(self : DsgraphcompactPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_cluster_make(size : Int) -> DsgraphcompactCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactCluster::len(self : DsgraphcompactCluster) -> Int { self.size }

pub fn DsgraphcompactCluster::get(self : DsgraphcompactCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactCluster::set(self : DsgraphcompactCluster, i : Int, v : Double) -> DsgraphcompactCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactCluster::sum(self : DsgraphcompactCluster) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactCluster::mean(self : DsgraphcompactCluster) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactCluster::scale(self : DsgraphcompactCluster, f : Double) -> DsgraphcompactCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactCluster::add(self : DsgraphcompactCluster, other : DsgraphcompactCluster) -> DsgraphcompactCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactCluster::copy(self : DsgraphcompactCluster) -> DsgraphcompactCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactCluster::fill(self : DsgraphcompactCluster, v : Double) -> DsgraphcompactCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactCluster::min(self : DsgraphcompactCluster) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactCluster::max(self : DsgraphcompactCluster) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactCluster::to_string(self : DsgraphcompactCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_model_make(size : Int) -> DsgraphcompactModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactModel::len(self : DsgraphcompactModel) -> Int { self.size }

pub fn DsgraphcompactModel::get(self : DsgraphcompactModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactModel::set(self : DsgraphcompactModel, i : Int, v : Double) -> DsgraphcompactModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactModel::sum(self : DsgraphcompactModel) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactModel::mean(self : DsgraphcompactModel) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactModel::scale(self : DsgraphcompactModel, f : Double) -> DsgraphcompactModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactModel::add(self : DsgraphcompactModel, other : DsgraphcompactModel) -> DsgraphcompactModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactModel::copy(self : DsgraphcompactModel) -> DsgraphcompactModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactModel::fill(self : DsgraphcompactModel, v : Double) -> DsgraphcompactModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactModel::min(self : DsgraphcompactModel) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactModel::max(self : DsgraphcompactModel) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactModel::to_string(self : DsgraphcompactModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_layer_make(size : Int) -> DsgraphcompactLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactLayer::len(self : DsgraphcompactLayer) -> Int { self.size }

pub fn DsgraphcompactLayer::get(self : DsgraphcompactLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactLayer::set(self : DsgraphcompactLayer, i : Int, v : Double) -> DsgraphcompactLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactLayer::sum(self : DsgraphcompactLayer) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactLayer::mean(self : DsgraphcompactLayer) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactLayer::scale(self : DsgraphcompactLayer, f : Double) -> DsgraphcompactLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactLayer::add(self : DsgraphcompactLayer, other : DsgraphcompactLayer) -> DsgraphcompactLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactLayer::copy(self : DsgraphcompactLayer) -> DsgraphcompactLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactLayer::fill(self : DsgraphcompactLayer, v : Double) -> DsgraphcompactLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactLayer::min(self : DsgraphcompactLayer) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactLayer::max(self : DsgraphcompactLayer) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactLayer::to_string(self : DsgraphcompactLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_buffer_make(size : Int) -> DsgraphcompactBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactBuffer::len(self : DsgraphcompactBuffer) -> Int { self.size }

pub fn DsgraphcompactBuffer::get(self : DsgraphcompactBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactBuffer::set(self : DsgraphcompactBuffer, i : Int, v : Double) -> DsgraphcompactBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactBuffer::sum(self : DsgraphcompactBuffer) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactBuffer::mean(self : DsgraphcompactBuffer) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactBuffer::scale(self : DsgraphcompactBuffer, f : Double) -> DsgraphcompactBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactBuffer::add(self : DsgraphcompactBuffer, other : DsgraphcompactBuffer) -> DsgraphcompactBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactBuffer::copy(self : DsgraphcompactBuffer) -> DsgraphcompactBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactBuffer::fill(self : DsgraphcompactBuffer, v : Double) -> DsgraphcompactBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactBuffer::min(self : DsgraphcompactBuffer) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactBuffer::max(self : DsgraphcompactBuffer) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactBuffer::to_string(self : DsgraphcompactBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_cursor_make(size : Int) -> DsgraphcompactCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactCursor::len(self : DsgraphcompactCursor) -> Int { self.size }

pub fn DsgraphcompactCursor::get(self : DsgraphcompactCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactCursor::set(self : DsgraphcompactCursor, i : Int, v : Double) -> DsgraphcompactCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactCursor::sum(self : DsgraphcompactCursor) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactCursor::mean(self : DsgraphcompactCursor) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactCursor::scale(self : DsgraphcompactCursor, f : Double) -> DsgraphcompactCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactCursor::add(self : DsgraphcompactCursor, other : DsgraphcompactCursor) -> DsgraphcompactCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactCursor::copy(self : DsgraphcompactCursor) -> DsgraphcompactCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactCursor::fill(self : DsgraphcompactCursor, v : Double) -> DsgraphcompactCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactCursor::min(self : DsgraphcompactCursor) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactCursor::max(self : DsgraphcompactCursor) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactCursor::to_string(self : DsgraphcompactCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_view_make(size : Int) -> DsgraphcompactView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactView::len(self : DsgraphcompactView) -> Int { self.size }

pub fn DsgraphcompactView::get(self : DsgraphcompactView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactView::set(self : DsgraphcompactView, i : Int, v : Double) -> DsgraphcompactView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactView::sum(self : DsgraphcompactView) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactView::mean(self : DsgraphcompactView) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactView::scale(self : DsgraphcompactView, f : Double) -> DsgraphcompactView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactView::add(self : DsgraphcompactView, other : DsgraphcompactView) -> DsgraphcompactView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactView::copy(self : DsgraphcompactView) -> DsgraphcompactView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactView::fill(self : DsgraphcompactView, v : Double) -> DsgraphcompactView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactView::min(self : DsgraphcompactView) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactView::max(self : DsgraphcompactView) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactView::to_string(self : DsgraphcompactView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_range_make(size : Int) -> DsgraphcompactRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactRange::len(self : DsgraphcompactRange) -> Int { self.size }

pub fn DsgraphcompactRange::get(self : DsgraphcompactRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactRange::set(self : DsgraphcompactRange, i : Int, v : Double) -> DsgraphcompactRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactRange::sum(self : DsgraphcompactRange) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactRange::mean(self : DsgraphcompactRange) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactRange::scale(self : DsgraphcompactRange, f : Double) -> DsgraphcompactRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactRange::add(self : DsgraphcompactRange, other : DsgraphcompactRange) -> DsgraphcompactRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactRange::copy(self : DsgraphcompactRange) -> DsgraphcompactRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactRange::fill(self : DsgraphcompactRange, v : Double) -> DsgraphcompactRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactRange::min(self : DsgraphcompactRange) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactRange::max(self : DsgraphcompactRange) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactRange::to_string(self : DsgraphcompactRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_slice_make(size : Int) -> DsgraphcompactSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphcompactSlice::len(self : DsgraphcompactSlice) -> Int { self.size }

pub fn DsgraphcompactSlice::get(self : DsgraphcompactSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphcompactSlice::set(self : DsgraphcompactSlice, i : Int, v : Double) -> DsgraphcompactSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphcompactSlice::sum(self : DsgraphcompactSlice) -> Double { @_common.sum(self.data) }

pub fn DsgraphcompactSlice::mean(self : DsgraphcompactSlice) -> Double { @_common.mean(self.data) }

pub fn DsgraphcompactSlice::scale(self : DsgraphcompactSlice, f : Double) -> DsgraphcompactSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactSlice::add(self : DsgraphcompactSlice, other : DsgraphcompactSlice) -> DsgraphcompactSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphcompactSlice::copy(self : DsgraphcompactSlice) -> DsgraphcompactSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactSlice::fill(self : DsgraphcompactSlice, v : Double) -> DsgraphcompactSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphcompactSlice::min(self : DsgraphcompactSlice) -> Double { @_common.min(self.data) }

pub fn DsgraphcompactSlice::max(self : DsgraphcompactSlice) -> Double { @_common.max(self.data) }

pub fn DsgraphcompactSlice::to_string(self : DsgraphcompactSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

