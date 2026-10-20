///===
/// extcore/bio_struct_surface

pub(all) struct BiostructsurfacePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_surface_make_point(x : Double, y : Double) -> BiostructsurfacePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_surface_make_point3(x : Double, y : Double, z : Double) -> BiostructsurfacePoint {
  { x, y, z, label: 0 }
}

pub fn BiostructsurfacePoint::x(self : BiostructsurfacePoint) -> Double { self.x }

pub fn BiostructsurfacePoint::y(self : BiostructsurfacePoint) -> Double { self.y }

pub fn BiostructsurfacePoint::z(self : BiostructsurfacePoint) -> Double { self.z }

pub fn BiostructsurfacePoint::label(self : BiostructsurfacePoint) -> Int { self.label }

pub fn BiostructsurfacePoint::dist(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructsurfacePoint::add(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructsurfacePoint::sub(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructsurfacePoint::scale(self : BiostructsurfacePoint, s : Double) -> BiostructsurfacePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructsurfacePoint::dot(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructsurfacePoint::cross(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructsurfacePoint::norm(self : BiostructsurfacePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructsurfacePoint::normalize(self : BiostructsurfacePoint) -> BiostructsurfacePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructsurfacePoint::negate(self : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructsurfacePoint::mid(self : BiostructsurfacePoint, other : BiostructsurfacePoint) -> BiostructsurfacePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructsurfacePoint::lerp(self : BiostructsurfacePoint, other : BiostructsurfacePoint, t : Double) -> BiostructsurfacePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructsurfacePoint::to_string(self : BiostructsurfacePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructsurfaceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_surface_make_series(vals : Array[Double], name : String) -> BiostructsurfaceSeries {
  { vals, name, meta: 0 }
}

pub fn BiostructsurfaceSeries::len(self : BiostructsurfaceSeries) -> Int { self.vals.length() }

pub fn BiostructsurfaceSeries::sum(self : BiostructsurfaceSeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructsurfaceSeries::mean(self : BiostructsurfaceSeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructsurfaceSeries::min(self : BiostructsurfaceSeries) -> Double { @_common.min(self.vals) }

pub fn BiostructsurfaceSeries::max(self : BiostructsurfaceSeries) -> Double { @_common.max(self.vals) }

pub fn BiostructsurfaceSeries::range(self : BiostructsurfaceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructsurfaceSeries::variance(self : BiostructsurfaceSeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructsurfaceSeries::std(self : BiostructsurfaceSeries) -> Double { @_common.std(self.vals) }

pub fn BiostructsurfaceSeries::median(self : BiostructsurfaceSeries) -> Double { @_common.median(self.vals) }

pub fn BiostructsurfaceSeries::scale(self : BiostructsurfaceSeries, f : Double) -> BiostructsurfaceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructsurfaceSeries::add(self : BiostructsurfaceSeries, other : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructsurfaceSeries::sub(self : BiostructsurfaceSeries, other : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructsurfaceSeries::normalize(self : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructsurfaceSeries::cumsum(self : BiostructsurfaceSeries) -> BiostructsurfaceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructsurfaceSeries::to_string(self : BiostructsurfaceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructsurfaceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_surface_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructsurfaceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_surface_matrix_identity(n : Int) -> BiostructsurfaceMatrix {
  let m = bio_struct_surface_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructsurfaceMatrix::get(self : BiostructsurfaceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructsurfaceMatrix::transpose(self : BiostructsurfaceMatrix) -> BiostructsurfaceMatrix {
  let result = bio_struct_surface_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructsurfaceMatrix::add(self : BiostructsurfaceMatrix, other : BiostructsurfaceMatrix) -> BiostructsurfaceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_surface_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructsurfaceMatrix::scale(self : BiostructsurfaceMatrix, s : Double) -> BiostructsurfaceMatrix {
  let result = bio_struct_surface_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructsurfaceMatrix::multiply(self : BiostructsurfaceMatrix, other : BiostructsurfaceMatrix) -> BiostructsurfaceMatrix {
  if self.cols != other.rows { return bio_struct_surface_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_surface_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructsurfaceMatrix::trace(self : BiostructsurfaceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructsurfaceMatrix::det(self : BiostructsurfaceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructsurfaceMatrix::norm(self : BiostructsurfaceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructsurfaceMatrix::to_string(self : BiostructsurfaceMatrix) -> String {
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

pub(all) struct BiostructsurfaceVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_surface_make_vector(comps : Array[Double]) -> BiostructsurfaceVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_surface_vector_zero(dim : Int) -> BiostructsurfaceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructsurfaceVector::add(self : BiostructsurfaceVector, other : BiostructsurfaceVector) -> BiostructsurfaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructsurfaceVector::sub(self : BiostructsurfaceVector, other : BiostructsurfaceVector) -> BiostructsurfaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructsurfaceVector::scale(self : BiostructsurfaceVector, s : Double) -> BiostructsurfaceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructsurfaceVector::dot(self : BiostructsurfaceVector, other : BiostructsurfaceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructsurfaceVector::norm(self : BiostructsurfaceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructsurfaceVector::normalize(self : BiostructsurfaceVector) -> BiostructsurfaceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructsurfaceVector::dist(self : BiostructsurfaceVector, other : BiostructsurfaceVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructsurfaceVector::to_string(self : BiostructsurfaceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructsurfaceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_frame_make(size : Int) -> BiostructsurfaceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceFrame::len(self : BiostructsurfaceFrame) -> Int { self.size }

pub fn BiostructsurfaceFrame::get(self : BiostructsurfaceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceFrame::set(self : BiostructsurfaceFrame, i : Int, v : Double) -> BiostructsurfaceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceFrame::sum(self : BiostructsurfaceFrame) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceFrame::mean(self : BiostructsurfaceFrame) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceFrame::scale(self : BiostructsurfaceFrame, f : Double) -> BiostructsurfaceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceFrame::add(self : BiostructsurfaceFrame, other : BiostructsurfaceFrame) -> BiostructsurfaceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceFrame::copy(self : BiostructsurfaceFrame) -> BiostructsurfaceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceFrame::fill(self : BiostructsurfaceFrame, v : Double) -> BiostructsurfaceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceFrame::min(self : BiostructsurfaceFrame) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceFrame::max(self : BiostructsurfaceFrame) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceFrame::to_string(self : BiostructsurfaceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_table_make(size : Int) -> BiostructsurfaceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceTable::len(self : BiostructsurfaceTable) -> Int { self.size }

pub fn BiostructsurfaceTable::get(self : BiostructsurfaceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceTable::set(self : BiostructsurfaceTable, i : Int, v : Double) -> BiostructsurfaceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceTable::sum(self : BiostructsurfaceTable) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceTable::mean(self : BiostructsurfaceTable) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceTable::scale(self : BiostructsurfaceTable, f : Double) -> BiostructsurfaceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceTable::add(self : BiostructsurfaceTable, other : BiostructsurfaceTable) -> BiostructsurfaceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceTable::copy(self : BiostructsurfaceTable) -> BiostructsurfaceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceTable::fill(self : BiostructsurfaceTable, v : Double) -> BiostructsurfaceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceTable::min(self : BiostructsurfaceTable) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceTable::max(self : BiostructsurfaceTable) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceTable::to_string(self : BiostructsurfaceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_graphn_make(size : Int) -> BiostructsurfaceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceGraphN::len(self : BiostructsurfaceGraphN) -> Int { self.size }

pub fn BiostructsurfaceGraphN::get(self : BiostructsurfaceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceGraphN::set(self : BiostructsurfaceGraphN, i : Int, v : Double) -> BiostructsurfaceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceGraphN::sum(self : BiostructsurfaceGraphN) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceGraphN::mean(self : BiostructsurfaceGraphN) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceGraphN::scale(self : BiostructsurfaceGraphN, f : Double) -> BiostructsurfaceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceGraphN::add(self : BiostructsurfaceGraphN, other : BiostructsurfaceGraphN) -> BiostructsurfaceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceGraphN::copy(self : BiostructsurfaceGraphN) -> BiostructsurfaceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceGraphN::fill(self : BiostructsurfaceGraphN, v : Double) -> BiostructsurfaceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceGraphN::min(self : BiostructsurfaceGraphN) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceGraphN::max(self : BiostructsurfaceGraphN) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceGraphN::to_string(self : BiostructsurfaceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_node_make(size : Int) -> BiostructsurfaceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceNode::len(self : BiostructsurfaceNode) -> Int { self.size }

pub fn BiostructsurfaceNode::get(self : BiostructsurfaceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceNode::set(self : BiostructsurfaceNode, i : Int, v : Double) -> BiostructsurfaceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceNode::sum(self : BiostructsurfaceNode) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceNode::mean(self : BiostructsurfaceNode) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceNode::scale(self : BiostructsurfaceNode, f : Double) -> BiostructsurfaceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceNode::add(self : BiostructsurfaceNode, other : BiostructsurfaceNode) -> BiostructsurfaceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceNode::copy(self : BiostructsurfaceNode) -> BiostructsurfaceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceNode::fill(self : BiostructsurfaceNode, v : Double) -> BiostructsurfaceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceNode::min(self : BiostructsurfaceNode) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceNode::max(self : BiostructsurfaceNode) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceNode::to_string(self : BiostructsurfaceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_edge_make(size : Int) -> BiostructsurfaceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceEdge::len(self : BiostructsurfaceEdge) -> Int { self.size }

pub fn BiostructsurfaceEdge::get(self : BiostructsurfaceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceEdge::set(self : BiostructsurfaceEdge, i : Int, v : Double) -> BiostructsurfaceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceEdge::sum(self : BiostructsurfaceEdge) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceEdge::mean(self : BiostructsurfaceEdge) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceEdge::scale(self : BiostructsurfaceEdge, f : Double) -> BiostructsurfaceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceEdge::add(self : BiostructsurfaceEdge, other : BiostructsurfaceEdge) -> BiostructsurfaceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceEdge::copy(self : BiostructsurfaceEdge) -> BiostructsurfaceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceEdge::fill(self : BiostructsurfaceEdge, v : Double) -> BiostructsurfaceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceEdge::min(self : BiostructsurfaceEdge) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceEdge::max(self : BiostructsurfaceEdge) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceEdge::to_string(self : BiostructsurfaceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfacePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_path_make(size : Int) -> BiostructsurfacePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfacePath::len(self : BiostructsurfacePath) -> Int { self.size }

pub fn BiostructsurfacePath::get(self : BiostructsurfacePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfacePath::set(self : BiostructsurfacePath, i : Int, v : Double) -> BiostructsurfacePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfacePath::sum(self : BiostructsurfacePath) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfacePath::mean(self : BiostructsurfacePath) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfacePath::scale(self : BiostructsurfacePath, f : Double) -> BiostructsurfacePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfacePath::add(self : BiostructsurfacePath, other : BiostructsurfacePath) -> BiostructsurfacePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfacePath::copy(self : BiostructsurfacePath) -> BiostructsurfacePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfacePath::fill(self : BiostructsurfacePath, v : Double) -> BiostructsurfacePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfacePath::min(self : BiostructsurfacePath) -> Double { @_common.min(self.data) }

pub fn BiostructsurfacePath::max(self : BiostructsurfacePath) -> Double { @_common.max(self.data) }

pub fn BiostructsurfacePath::to_string(self : BiostructsurfacePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_cluster_make(size : Int) -> BiostructsurfaceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceCluster::len(self : BiostructsurfaceCluster) -> Int { self.size }

pub fn BiostructsurfaceCluster::get(self : BiostructsurfaceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceCluster::set(self : BiostructsurfaceCluster, i : Int, v : Double) -> BiostructsurfaceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceCluster::sum(self : BiostructsurfaceCluster) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceCluster::mean(self : BiostructsurfaceCluster) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceCluster::scale(self : BiostructsurfaceCluster, f : Double) -> BiostructsurfaceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceCluster::add(self : BiostructsurfaceCluster, other : BiostructsurfaceCluster) -> BiostructsurfaceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceCluster::copy(self : BiostructsurfaceCluster) -> BiostructsurfaceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceCluster::fill(self : BiostructsurfaceCluster, v : Double) -> BiostructsurfaceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceCluster::min(self : BiostructsurfaceCluster) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceCluster::max(self : BiostructsurfaceCluster) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceCluster::to_string(self : BiostructsurfaceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_model_make(size : Int) -> BiostructsurfaceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceModel::len(self : BiostructsurfaceModel) -> Int { self.size }

pub fn BiostructsurfaceModel::get(self : BiostructsurfaceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceModel::set(self : BiostructsurfaceModel, i : Int, v : Double) -> BiostructsurfaceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceModel::sum(self : BiostructsurfaceModel) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceModel::mean(self : BiostructsurfaceModel) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceModel::scale(self : BiostructsurfaceModel, f : Double) -> BiostructsurfaceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceModel::add(self : BiostructsurfaceModel, other : BiostructsurfaceModel) -> BiostructsurfaceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceModel::copy(self : BiostructsurfaceModel) -> BiostructsurfaceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceModel::fill(self : BiostructsurfaceModel, v : Double) -> BiostructsurfaceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceModel::min(self : BiostructsurfaceModel) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceModel::max(self : BiostructsurfaceModel) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceModel::to_string(self : BiostructsurfaceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_layer_make(size : Int) -> BiostructsurfaceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceLayer::len(self : BiostructsurfaceLayer) -> Int { self.size }

pub fn BiostructsurfaceLayer::get(self : BiostructsurfaceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceLayer::set(self : BiostructsurfaceLayer, i : Int, v : Double) -> BiostructsurfaceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceLayer::sum(self : BiostructsurfaceLayer) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceLayer::mean(self : BiostructsurfaceLayer) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceLayer::scale(self : BiostructsurfaceLayer, f : Double) -> BiostructsurfaceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceLayer::add(self : BiostructsurfaceLayer, other : BiostructsurfaceLayer) -> BiostructsurfaceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceLayer::copy(self : BiostructsurfaceLayer) -> BiostructsurfaceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceLayer::fill(self : BiostructsurfaceLayer, v : Double) -> BiostructsurfaceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceLayer::min(self : BiostructsurfaceLayer) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceLayer::max(self : BiostructsurfaceLayer) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceLayer::to_string(self : BiostructsurfaceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_buffer_make(size : Int) -> BiostructsurfaceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceBuffer::len(self : BiostructsurfaceBuffer) -> Int { self.size }

pub fn BiostructsurfaceBuffer::get(self : BiostructsurfaceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceBuffer::set(self : BiostructsurfaceBuffer, i : Int, v : Double) -> BiostructsurfaceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceBuffer::sum(self : BiostructsurfaceBuffer) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceBuffer::mean(self : BiostructsurfaceBuffer) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceBuffer::scale(self : BiostructsurfaceBuffer, f : Double) -> BiostructsurfaceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceBuffer::add(self : BiostructsurfaceBuffer, other : BiostructsurfaceBuffer) -> BiostructsurfaceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceBuffer::copy(self : BiostructsurfaceBuffer) -> BiostructsurfaceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceBuffer::fill(self : BiostructsurfaceBuffer, v : Double) -> BiostructsurfaceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceBuffer::min(self : BiostructsurfaceBuffer) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceBuffer::max(self : BiostructsurfaceBuffer) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceBuffer::to_string(self : BiostructsurfaceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_cursor_make(size : Int) -> BiostructsurfaceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceCursor::len(self : BiostructsurfaceCursor) -> Int { self.size }

pub fn BiostructsurfaceCursor::get(self : BiostructsurfaceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceCursor::set(self : BiostructsurfaceCursor, i : Int, v : Double) -> BiostructsurfaceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceCursor::sum(self : BiostructsurfaceCursor) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceCursor::mean(self : BiostructsurfaceCursor) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceCursor::scale(self : BiostructsurfaceCursor, f : Double) -> BiostructsurfaceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceCursor::add(self : BiostructsurfaceCursor, other : BiostructsurfaceCursor) -> BiostructsurfaceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceCursor::copy(self : BiostructsurfaceCursor) -> BiostructsurfaceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceCursor::fill(self : BiostructsurfaceCursor, v : Double) -> BiostructsurfaceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceCursor::min(self : BiostructsurfaceCursor) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceCursor::max(self : BiostructsurfaceCursor) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceCursor::to_string(self : BiostructsurfaceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_view_make(size : Int) -> BiostructsurfaceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceView::len(self : BiostructsurfaceView) -> Int { self.size }

pub fn BiostructsurfaceView::get(self : BiostructsurfaceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceView::set(self : BiostructsurfaceView, i : Int, v : Double) -> BiostructsurfaceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceView::sum(self : BiostructsurfaceView) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceView::mean(self : BiostructsurfaceView) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceView::scale(self : BiostructsurfaceView, f : Double) -> BiostructsurfaceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceView::add(self : BiostructsurfaceView, other : BiostructsurfaceView) -> BiostructsurfaceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceView::copy(self : BiostructsurfaceView) -> BiostructsurfaceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceView::fill(self : BiostructsurfaceView, v : Double) -> BiostructsurfaceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceView::min(self : BiostructsurfaceView) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceView::max(self : BiostructsurfaceView) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceView::to_string(self : BiostructsurfaceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_range_make(size : Int) -> BiostructsurfaceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceRange::len(self : BiostructsurfaceRange) -> Int { self.size }

pub fn BiostructsurfaceRange::get(self : BiostructsurfaceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceRange::set(self : BiostructsurfaceRange, i : Int, v : Double) -> BiostructsurfaceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceRange::sum(self : BiostructsurfaceRange) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceRange::mean(self : BiostructsurfaceRange) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceRange::scale(self : BiostructsurfaceRange, f : Double) -> BiostructsurfaceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceRange::add(self : BiostructsurfaceRange, other : BiostructsurfaceRange) -> BiostructsurfaceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceRange::copy(self : BiostructsurfaceRange) -> BiostructsurfaceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceRange::fill(self : BiostructsurfaceRange, v : Double) -> BiostructsurfaceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceRange::min(self : BiostructsurfaceRange) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceRange::max(self : BiostructsurfaceRange) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceRange::to_string(self : BiostructsurfaceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsurfaceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_surface_slice_make(size : Int) -> BiostructsurfaceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsurfaceSlice::len(self : BiostructsurfaceSlice) -> Int { self.size }

pub fn BiostructsurfaceSlice::get(self : BiostructsurfaceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsurfaceSlice::set(self : BiostructsurfaceSlice, i : Int, v : Double) -> BiostructsurfaceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceSlice::sum(self : BiostructsurfaceSlice) -> Double { @_common.sum(self.data) }

pub fn BiostructsurfaceSlice::mean(self : BiostructsurfaceSlice) -> Double { @_common.mean(self.data) }

pub fn BiostructsurfaceSlice::scale(self : BiostructsurfaceSlice, f : Double) -> BiostructsurfaceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceSlice::add(self : BiostructsurfaceSlice, other : BiostructsurfaceSlice) -> BiostructsurfaceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsurfaceSlice::copy(self : BiostructsurfaceSlice) -> BiostructsurfaceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceSlice::fill(self : BiostructsurfaceSlice, v : Double) -> BiostructsurfaceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsurfaceSlice::min(self : BiostructsurfaceSlice) -> Double { @_common.min(self.data) }

pub fn BiostructsurfaceSlice::max(self : BiostructsurfaceSlice) -> Double { @_common.max(self.data) }

pub fn BiostructsurfaceSlice::to_string(self : BiostructsurfaceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

