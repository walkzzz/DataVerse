///===
/// extcore/graph_color_exact

pub(all) struct GraphcolorexactPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_exact_make_point(x : Double, y : Double) -> GraphcolorexactPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_exact_make_point3(x : Double, y : Double, z : Double) -> GraphcolorexactPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorexactPoint::x(self : GraphcolorexactPoint) -> Double { self.x }

pub fn GraphcolorexactPoint::y(self : GraphcolorexactPoint) -> Double { self.y }

pub fn GraphcolorexactPoint::z(self : GraphcolorexactPoint) -> Double { self.z }

pub fn GraphcolorexactPoint::label(self : GraphcolorexactPoint) -> Int { self.label }

pub fn GraphcolorexactPoint::dist(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorexactPoint::add(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorexactPoint::sub(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorexactPoint::scale(self : GraphcolorexactPoint, s : Double) -> GraphcolorexactPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorexactPoint::dot(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorexactPoint::cross(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorexactPoint::norm(self : GraphcolorexactPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorexactPoint::normalize(self : GraphcolorexactPoint) -> GraphcolorexactPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorexactPoint::negate(self : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorexactPoint::mid(self : GraphcolorexactPoint, other : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorexactPoint::lerp(self : GraphcolorexactPoint, other : GraphcolorexactPoint, t : Double) -> GraphcolorexactPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorexactPoint::to_string(self : GraphcolorexactPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorexactSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_exact_make_series(vals : Array[Double], name : String) -> GraphcolorexactSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorexactSeries::len(self : GraphcolorexactSeries) -> Int { self.vals.length() }

pub fn GraphcolorexactSeries::sum(self : GraphcolorexactSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorexactSeries::mean(self : GraphcolorexactSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorexactSeries::min(self : GraphcolorexactSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorexactSeries::max(self : GraphcolorexactSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorexactSeries::range(self : GraphcolorexactSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorexactSeries::variance(self : GraphcolorexactSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorexactSeries::std(self : GraphcolorexactSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorexactSeries::median(self : GraphcolorexactSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorexactSeries::scale(self : GraphcolorexactSeries, f : Double) -> GraphcolorexactSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorexactSeries::add(self : GraphcolorexactSeries, other : GraphcolorexactSeries) -> GraphcolorexactSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorexactSeries::sub(self : GraphcolorexactSeries, other : GraphcolorexactSeries) -> GraphcolorexactSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorexactSeries::normalize(self : GraphcolorexactSeries) -> GraphcolorexactSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorexactSeries::cumsum(self : GraphcolorexactSeries) -> GraphcolorexactSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorexactSeries::to_string(self : GraphcolorexactSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorexactMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_exact_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorexactMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_exact_matrix_identity(n : Int) -> GraphcolorexactMatrix {
  let m = graph_color_exact_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorexactMatrix::get(self : GraphcolorexactMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorexactMatrix::transpose(self : GraphcolorexactMatrix) -> GraphcolorexactMatrix {
  let result = graph_color_exact_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorexactMatrix::add(self : GraphcolorexactMatrix, other : GraphcolorexactMatrix) -> GraphcolorexactMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_exact_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorexactMatrix::scale(self : GraphcolorexactMatrix, s : Double) -> GraphcolorexactMatrix {
  let result = graph_color_exact_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorexactMatrix::multiply(self : GraphcolorexactMatrix, other : GraphcolorexactMatrix) -> GraphcolorexactMatrix {
  if self.cols != other.rows { return graph_color_exact_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_exact_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GraphcolorexactMatrix::trace(self : GraphcolorexactMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorexactMatrix::det(self : GraphcolorexactMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorexactMatrix::norm(self : GraphcolorexactMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorexactMatrix::to_string(self : GraphcolorexactMatrix) -> String {
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

pub(all) struct GraphcolorexactVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_exact_make_vector(comps : Array[Double]) -> GraphcolorexactVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_exact_vector_zero(dim : Int) -> GraphcolorexactVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorexactVector::add(self : GraphcolorexactVector, other : GraphcolorexactVector) -> GraphcolorexactVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorexactVector::sub(self : GraphcolorexactVector, other : GraphcolorexactVector) -> GraphcolorexactVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorexactVector::scale(self : GraphcolorexactVector, s : Double) -> GraphcolorexactVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorexactVector::dot(self : GraphcolorexactVector, other : GraphcolorexactVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorexactVector::norm(self : GraphcolorexactVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorexactVector::normalize(self : GraphcolorexactVector) -> GraphcolorexactVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorexactVector::dist(self : GraphcolorexactVector, other : GraphcolorexactVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorexactVector::to_string(self : GraphcolorexactVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorexactFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_frame_make(size : Int) -> GraphcolorexactFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactFrame::len(self : GraphcolorexactFrame) -> Int { self.size }

pub fn GraphcolorexactFrame::get(self : GraphcolorexactFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactFrame::set(self : GraphcolorexactFrame, i : Int, v : Double) -> GraphcolorexactFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactFrame::sum(self : GraphcolorexactFrame) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactFrame::mean(self : GraphcolorexactFrame) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactFrame::scale(self : GraphcolorexactFrame, f : Double) -> GraphcolorexactFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactFrame::add(self : GraphcolorexactFrame, other : GraphcolorexactFrame) -> GraphcolorexactFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactFrame::copy(self : GraphcolorexactFrame) -> GraphcolorexactFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactFrame::fill(self : GraphcolorexactFrame, v : Double) -> GraphcolorexactFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactFrame::min(self : GraphcolorexactFrame) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactFrame::max(self : GraphcolorexactFrame) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactFrame::to_string(self : GraphcolorexactFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_table_make(size : Int) -> GraphcolorexactTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactTable::len(self : GraphcolorexactTable) -> Int { self.size }

pub fn GraphcolorexactTable::get(self : GraphcolorexactTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactTable::set(self : GraphcolorexactTable, i : Int, v : Double) -> GraphcolorexactTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactTable::sum(self : GraphcolorexactTable) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactTable::mean(self : GraphcolorexactTable) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactTable::scale(self : GraphcolorexactTable, f : Double) -> GraphcolorexactTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactTable::add(self : GraphcolorexactTable, other : GraphcolorexactTable) -> GraphcolorexactTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactTable::copy(self : GraphcolorexactTable) -> GraphcolorexactTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactTable::fill(self : GraphcolorexactTable, v : Double) -> GraphcolorexactTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactTable::min(self : GraphcolorexactTable) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactTable::max(self : GraphcolorexactTable) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactTable::to_string(self : GraphcolorexactTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_graphn_make(size : Int) -> GraphcolorexactGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactGraphN::len(self : GraphcolorexactGraphN) -> Int { self.size }

pub fn GraphcolorexactGraphN::get(self : GraphcolorexactGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactGraphN::set(self : GraphcolorexactGraphN, i : Int, v : Double) -> GraphcolorexactGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactGraphN::sum(self : GraphcolorexactGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactGraphN::mean(self : GraphcolorexactGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactGraphN::scale(self : GraphcolorexactGraphN, f : Double) -> GraphcolorexactGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactGraphN::add(self : GraphcolorexactGraphN, other : GraphcolorexactGraphN) -> GraphcolorexactGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactGraphN::copy(self : GraphcolorexactGraphN) -> GraphcolorexactGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactGraphN::fill(self : GraphcolorexactGraphN, v : Double) -> GraphcolorexactGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactGraphN::min(self : GraphcolorexactGraphN) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactGraphN::max(self : GraphcolorexactGraphN) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactGraphN::to_string(self : GraphcolorexactGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_node_make(size : Int) -> GraphcolorexactNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactNode::len(self : GraphcolorexactNode) -> Int { self.size }

pub fn GraphcolorexactNode::get(self : GraphcolorexactNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactNode::set(self : GraphcolorexactNode, i : Int, v : Double) -> GraphcolorexactNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactNode::sum(self : GraphcolorexactNode) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactNode::mean(self : GraphcolorexactNode) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactNode::scale(self : GraphcolorexactNode, f : Double) -> GraphcolorexactNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactNode::add(self : GraphcolorexactNode, other : GraphcolorexactNode) -> GraphcolorexactNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactNode::copy(self : GraphcolorexactNode) -> GraphcolorexactNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactNode::fill(self : GraphcolorexactNode, v : Double) -> GraphcolorexactNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactNode::min(self : GraphcolorexactNode) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactNode::max(self : GraphcolorexactNode) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactNode::to_string(self : GraphcolorexactNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_edge_make(size : Int) -> GraphcolorexactEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactEdge::len(self : GraphcolorexactEdge) -> Int { self.size }

pub fn GraphcolorexactEdge::get(self : GraphcolorexactEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactEdge::set(self : GraphcolorexactEdge, i : Int, v : Double) -> GraphcolorexactEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactEdge::sum(self : GraphcolorexactEdge) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactEdge::mean(self : GraphcolorexactEdge) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactEdge::scale(self : GraphcolorexactEdge, f : Double) -> GraphcolorexactEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactEdge::add(self : GraphcolorexactEdge, other : GraphcolorexactEdge) -> GraphcolorexactEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactEdge::copy(self : GraphcolorexactEdge) -> GraphcolorexactEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactEdge::fill(self : GraphcolorexactEdge, v : Double) -> GraphcolorexactEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactEdge::min(self : GraphcolorexactEdge) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactEdge::max(self : GraphcolorexactEdge) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactEdge::to_string(self : GraphcolorexactEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_path_make(size : Int) -> GraphcolorexactPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactPath::len(self : GraphcolorexactPath) -> Int { self.size }

pub fn GraphcolorexactPath::get(self : GraphcolorexactPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactPath::set(self : GraphcolorexactPath, i : Int, v : Double) -> GraphcolorexactPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactPath::sum(self : GraphcolorexactPath) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactPath::mean(self : GraphcolorexactPath) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactPath::scale(self : GraphcolorexactPath, f : Double) -> GraphcolorexactPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactPath::add(self : GraphcolorexactPath, other : GraphcolorexactPath) -> GraphcolorexactPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactPath::copy(self : GraphcolorexactPath) -> GraphcolorexactPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactPath::fill(self : GraphcolorexactPath, v : Double) -> GraphcolorexactPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactPath::min(self : GraphcolorexactPath) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactPath::max(self : GraphcolorexactPath) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactPath::to_string(self : GraphcolorexactPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_cluster_make(size : Int) -> GraphcolorexactCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactCluster::len(self : GraphcolorexactCluster) -> Int { self.size }

pub fn GraphcolorexactCluster::get(self : GraphcolorexactCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactCluster::set(self : GraphcolorexactCluster, i : Int, v : Double) -> GraphcolorexactCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactCluster::sum(self : GraphcolorexactCluster) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactCluster::mean(self : GraphcolorexactCluster) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactCluster::scale(self : GraphcolorexactCluster, f : Double) -> GraphcolorexactCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactCluster::add(self : GraphcolorexactCluster, other : GraphcolorexactCluster) -> GraphcolorexactCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactCluster::copy(self : GraphcolorexactCluster) -> GraphcolorexactCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactCluster::fill(self : GraphcolorexactCluster, v : Double) -> GraphcolorexactCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactCluster::min(self : GraphcolorexactCluster) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactCluster::max(self : GraphcolorexactCluster) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactCluster::to_string(self : GraphcolorexactCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_model_make(size : Int) -> GraphcolorexactModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactModel::len(self : GraphcolorexactModel) -> Int { self.size }

pub fn GraphcolorexactModel::get(self : GraphcolorexactModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactModel::set(self : GraphcolorexactModel, i : Int, v : Double) -> GraphcolorexactModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactModel::sum(self : GraphcolorexactModel) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactModel::mean(self : GraphcolorexactModel) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactModel::scale(self : GraphcolorexactModel, f : Double) -> GraphcolorexactModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactModel::add(self : GraphcolorexactModel, other : GraphcolorexactModel) -> GraphcolorexactModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactModel::copy(self : GraphcolorexactModel) -> GraphcolorexactModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactModel::fill(self : GraphcolorexactModel, v : Double) -> GraphcolorexactModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactModel::min(self : GraphcolorexactModel) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactModel::max(self : GraphcolorexactModel) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactModel::to_string(self : GraphcolorexactModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_layer_make(size : Int) -> GraphcolorexactLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactLayer::len(self : GraphcolorexactLayer) -> Int { self.size }

pub fn GraphcolorexactLayer::get(self : GraphcolorexactLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactLayer::set(self : GraphcolorexactLayer, i : Int, v : Double) -> GraphcolorexactLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactLayer::sum(self : GraphcolorexactLayer) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactLayer::mean(self : GraphcolorexactLayer) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactLayer::scale(self : GraphcolorexactLayer, f : Double) -> GraphcolorexactLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactLayer::add(self : GraphcolorexactLayer, other : GraphcolorexactLayer) -> GraphcolorexactLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactLayer::copy(self : GraphcolorexactLayer) -> GraphcolorexactLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactLayer::fill(self : GraphcolorexactLayer, v : Double) -> GraphcolorexactLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactLayer::min(self : GraphcolorexactLayer) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactLayer::max(self : GraphcolorexactLayer) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactLayer::to_string(self : GraphcolorexactLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_buffer_make(size : Int) -> GraphcolorexactBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactBuffer::len(self : GraphcolorexactBuffer) -> Int { self.size }

pub fn GraphcolorexactBuffer::get(self : GraphcolorexactBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactBuffer::set(self : GraphcolorexactBuffer, i : Int, v : Double) -> GraphcolorexactBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactBuffer::sum(self : GraphcolorexactBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactBuffer::mean(self : GraphcolorexactBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactBuffer::scale(self : GraphcolorexactBuffer, f : Double) -> GraphcolorexactBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactBuffer::add(self : GraphcolorexactBuffer, other : GraphcolorexactBuffer) -> GraphcolorexactBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactBuffer::copy(self : GraphcolorexactBuffer) -> GraphcolorexactBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactBuffer::fill(self : GraphcolorexactBuffer, v : Double) -> GraphcolorexactBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactBuffer::min(self : GraphcolorexactBuffer) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactBuffer::max(self : GraphcolorexactBuffer) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactBuffer::to_string(self : GraphcolorexactBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_cursor_make(size : Int) -> GraphcolorexactCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactCursor::len(self : GraphcolorexactCursor) -> Int { self.size }

pub fn GraphcolorexactCursor::get(self : GraphcolorexactCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactCursor::set(self : GraphcolorexactCursor, i : Int, v : Double) -> GraphcolorexactCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactCursor::sum(self : GraphcolorexactCursor) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactCursor::mean(self : GraphcolorexactCursor) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactCursor::scale(self : GraphcolorexactCursor, f : Double) -> GraphcolorexactCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactCursor::add(self : GraphcolorexactCursor, other : GraphcolorexactCursor) -> GraphcolorexactCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactCursor::copy(self : GraphcolorexactCursor) -> GraphcolorexactCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactCursor::fill(self : GraphcolorexactCursor, v : Double) -> GraphcolorexactCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactCursor::min(self : GraphcolorexactCursor) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactCursor::max(self : GraphcolorexactCursor) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactCursor::to_string(self : GraphcolorexactCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_view_make(size : Int) -> GraphcolorexactView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactView::len(self : GraphcolorexactView) -> Int { self.size }

pub fn GraphcolorexactView::get(self : GraphcolorexactView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactView::set(self : GraphcolorexactView, i : Int, v : Double) -> GraphcolorexactView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactView::sum(self : GraphcolorexactView) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactView::mean(self : GraphcolorexactView) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactView::scale(self : GraphcolorexactView, f : Double) -> GraphcolorexactView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactView::add(self : GraphcolorexactView, other : GraphcolorexactView) -> GraphcolorexactView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactView::copy(self : GraphcolorexactView) -> GraphcolorexactView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactView::fill(self : GraphcolorexactView, v : Double) -> GraphcolorexactView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactView::min(self : GraphcolorexactView) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactView::max(self : GraphcolorexactView) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactView::to_string(self : GraphcolorexactView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_range_make(size : Int) -> GraphcolorexactRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactRange::len(self : GraphcolorexactRange) -> Int { self.size }

pub fn GraphcolorexactRange::get(self : GraphcolorexactRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactRange::set(self : GraphcolorexactRange, i : Int, v : Double) -> GraphcolorexactRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactRange::sum(self : GraphcolorexactRange) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactRange::mean(self : GraphcolorexactRange) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactRange::scale(self : GraphcolorexactRange, f : Double) -> GraphcolorexactRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactRange::add(self : GraphcolorexactRange, other : GraphcolorexactRange) -> GraphcolorexactRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactRange::copy(self : GraphcolorexactRange) -> GraphcolorexactRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactRange::fill(self : GraphcolorexactRange, v : Double) -> GraphcolorexactRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactRange::min(self : GraphcolorexactRange) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactRange::max(self : GraphcolorexactRange) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactRange::to_string(self : GraphcolorexactRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_slice_make(size : Int) -> GraphcolorexactSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphcolorexactSlice::len(self : GraphcolorexactSlice) -> Int { self.size }

pub fn GraphcolorexactSlice::get(self : GraphcolorexactSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphcolorexactSlice::set(self : GraphcolorexactSlice, i : Int, v : Double) -> GraphcolorexactSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphcolorexactSlice::sum(self : GraphcolorexactSlice) -> Double { @_common.sum(self.data) }

pub fn GraphcolorexactSlice::mean(self : GraphcolorexactSlice) -> Double { @_common.mean(self.data) }

pub fn GraphcolorexactSlice::scale(self : GraphcolorexactSlice, f : Double) -> GraphcolorexactSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactSlice::add(self : GraphcolorexactSlice, other : GraphcolorexactSlice) -> GraphcolorexactSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphcolorexactSlice::copy(self : GraphcolorexactSlice) -> GraphcolorexactSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactSlice::fill(self : GraphcolorexactSlice, v : Double) -> GraphcolorexactSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphcolorexactSlice::min(self : GraphcolorexactSlice) -> Double { @_common.min(self.data) }

pub fn GraphcolorexactSlice::max(self : GraphcolorexactSlice) -> Double { @_common.max(self.data) }

pub fn GraphcolorexactSlice::to_string(self : GraphcolorexactSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

