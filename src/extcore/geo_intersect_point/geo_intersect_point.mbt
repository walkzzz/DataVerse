///===
/// extcore/geo_intersect_point

pub(all) struct GeointersectpointPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_point_make_point(x : Double, y : Double) -> GeointersectpointPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_point_make_point3(x : Double, y : Double, z : Double) -> GeointersectpointPoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectpointPoint::x(self : GeointersectpointPoint) -> Double { self.x }

pub fn GeointersectpointPoint::y(self : GeointersectpointPoint) -> Double { self.y }

pub fn GeointersectpointPoint::z(self : GeointersectpointPoint) -> Double { self.z }

pub fn GeointersectpointPoint::label(self : GeointersectpointPoint) -> Int { self.label }

pub fn GeointersectpointPoint::dist(self : GeointersectpointPoint, other : GeointersectpointPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectpointPoint::add(self : GeointersectpointPoint, other : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectpointPoint::sub(self : GeointersectpointPoint, other : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectpointPoint::scale(self : GeointersectpointPoint, s : Double) -> GeointersectpointPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectpointPoint::dot(self : GeointersectpointPoint, other : GeointersectpointPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectpointPoint::cross(self : GeointersectpointPoint, other : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectpointPoint::norm(self : GeointersectpointPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectpointPoint::normalize(self : GeointersectpointPoint) -> GeointersectpointPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectpointPoint::negate(self : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectpointPoint::mid(self : GeointersectpointPoint, other : GeointersectpointPoint) -> GeointersectpointPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectpointPoint::lerp(self : GeointersectpointPoint, other : GeointersectpointPoint, t : Double) -> GeointersectpointPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectpointPoint::to_string(self : GeointersectpointPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectpointSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_point_make_series(vals : Array[Double], name : String) -> GeointersectpointSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectpointSeries::len(self : GeointersectpointSeries) -> Int { self.vals.length() }

pub fn GeointersectpointSeries::sum(self : GeointersectpointSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectpointSeries::mean(self : GeointersectpointSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectpointSeries::min(self : GeointersectpointSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectpointSeries::max(self : GeointersectpointSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectpointSeries::range(self : GeointersectpointSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectpointSeries::variance(self : GeointersectpointSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectpointSeries::std(self : GeointersectpointSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectpointSeries::median(self : GeointersectpointSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectpointSeries::scale(self : GeointersectpointSeries, f : Double) -> GeointersectpointSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectpointSeries::add(self : GeointersectpointSeries, other : GeointersectpointSeries) -> GeointersectpointSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectpointSeries::sub(self : GeointersectpointSeries, other : GeointersectpointSeries) -> GeointersectpointSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectpointSeries::normalize(self : GeointersectpointSeries) -> GeointersectpointSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectpointSeries::cumsum(self : GeointersectpointSeries) -> GeointersectpointSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectpointSeries::to_string(self : GeointersectpointSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectpointMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_point_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectpointMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_intersect_point_matrix_identity(n : Int) -> GeointersectpointMatrix {
  let m = geo_intersect_point_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectpointMatrix::get(self : GeointersectpointMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectpointMatrix::transpose(self : GeointersectpointMatrix) -> GeointersectpointMatrix {
  let result = geo_intersect_point_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectpointMatrix::add(self : GeointersectpointMatrix, other : GeointersectpointMatrix) -> GeointersectpointMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_point_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectpointMatrix::scale(self : GeointersectpointMatrix, s : Double) -> GeointersectpointMatrix {
  let result = geo_intersect_point_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectpointMatrix::multiply(self : GeointersectpointMatrix, other : GeointersectpointMatrix) -> GeointersectpointMatrix {
  if self.cols != other.rows { return geo_intersect_point_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_point_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeointersectpointMatrix::trace(self : GeointersectpointMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectpointMatrix::det(self : GeointersectpointMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectpointMatrix::norm(self : GeointersectpointMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectpointMatrix::to_string(self : GeointersectpointMatrix) -> String {
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

pub(all) struct GeointersectpointVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_point_make_vector(comps : Array[Double]) -> GeointersectpointVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_point_vector_zero(dim : Int) -> GeointersectpointVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectpointVector::add(self : GeointersectpointVector, other : GeointersectpointVector) -> GeointersectpointVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectpointVector::sub(self : GeointersectpointVector, other : GeointersectpointVector) -> GeointersectpointVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectpointVector::scale(self : GeointersectpointVector, s : Double) -> GeointersectpointVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectpointVector::dot(self : GeointersectpointVector, other : GeointersectpointVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectpointVector::norm(self : GeointersectpointVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectpointVector::normalize(self : GeointersectpointVector) -> GeointersectpointVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectpointVector::dist(self : GeointersectpointVector, other : GeointersectpointVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectpointVector::to_string(self : GeointersectpointVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectpointFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_frame_make(size : Int) -> GeointersectpointFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointFrame::len(self : GeointersectpointFrame) -> Int { self.size }

pub fn GeointersectpointFrame::get(self : GeointersectpointFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointFrame::set(self : GeointersectpointFrame, i : Int, v : Double) -> GeointersectpointFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointFrame::sum(self : GeointersectpointFrame) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointFrame::mean(self : GeointersectpointFrame) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointFrame::scale(self : GeointersectpointFrame, f : Double) -> GeointersectpointFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointFrame::add(self : GeointersectpointFrame, other : GeointersectpointFrame) -> GeointersectpointFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointFrame::copy(self : GeointersectpointFrame) -> GeointersectpointFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointFrame::fill(self : GeointersectpointFrame, v : Double) -> GeointersectpointFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointFrame::min(self : GeointersectpointFrame) -> Double { @_common.min(self.data) }

pub fn GeointersectpointFrame::max(self : GeointersectpointFrame) -> Double { @_common.max(self.data) }

pub fn GeointersectpointFrame::to_string(self : GeointersectpointFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_table_make(size : Int) -> GeointersectpointTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointTable::len(self : GeointersectpointTable) -> Int { self.size }

pub fn GeointersectpointTable::get(self : GeointersectpointTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointTable::set(self : GeointersectpointTable, i : Int, v : Double) -> GeointersectpointTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointTable::sum(self : GeointersectpointTable) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointTable::mean(self : GeointersectpointTable) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointTable::scale(self : GeointersectpointTable, f : Double) -> GeointersectpointTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointTable::add(self : GeointersectpointTable, other : GeointersectpointTable) -> GeointersectpointTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointTable::copy(self : GeointersectpointTable) -> GeointersectpointTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointTable::fill(self : GeointersectpointTable, v : Double) -> GeointersectpointTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointTable::min(self : GeointersectpointTable) -> Double { @_common.min(self.data) }

pub fn GeointersectpointTable::max(self : GeointersectpointTable) -> Double { @_common.max(self.data) }

pub fn GeointersectpointTable::to_string(self : GeointersectpointTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_graphn_make(size : Int) -> GeointersectpointGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointGraphN::len(self : GeointersectpointGraphN) -> Int { self.size }

pub fn GeointersectpointGraphN::get(self : GeointersectpointGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointGraphN::set(self : GeointersectpointGraphN, i : Int, v : Double) -> GeointersectpointGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointGraphN::sum(self : GeointersectpointGraphN) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointGraphN::mean(self : GeointersectpointGraphN) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointGraphN::scale(self : GeointersectpointGraphN, f : Double) -> GeointersectpointGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointGraphN::add(self : GeointersectpointGraphN, other : GeointersectpointGraphN) -> GeointersectpointGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointGraphN::copy(self : GeointersectpointGraphN) -> GeointersectpointGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointGraphN::fill(self : GeointersectpointGraphN, v : Double) -> GeointersectpointGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointGraphN::min(self : GeointersectpointGraphN) -> Double { @_common.min(self.data) }

pub fn GeointersectpointGraphN::max(self : GeointersectpointGraphN) -> Double { @_common.max(self.data) }

pub fn GeointersectpointGraphN::to_string(self : GeointersectpointGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_node_make(size : Int) -> GeointersectpointNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointNode::len(self : GeointersectpointNode) -> Int { self.size }

pub fn GeointersectpointNode::get(self : GeointersectpointNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointNode::set(self : GeointersectpointNode, i : Int, v : Double) -> GeointersectpointNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointNode::sum(self : GeointersectpointNode) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointNode::mean(self : GeointersectpointNode) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointNode::scale(self : GeointersectpointNode, f : Double) -> GeointersectpointNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointNode::add(self : GeointersectpointNode, other : GeointersectpointNode) -> GeointersectpointNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointNode::copy(self : GeointersectpointNode) -> GeointersectpointNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointNode::fill(self : GeointersectpointNode, v : Double) -> GeointersectpointNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointNode::min(self : GeointersectpointNode) -> Double { @_common.min(self.data) }

pub fn GeointersectpointNode::max(self : GeointersectpointNode) -> Double { @_common.max(self.data) }

pub fn GeointersectpointNode::to_string(self : GeointersectpointNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_edge_make(size : Int) -> GeointersectpointEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointEdge::len(self : GeointersectpointEdge) -> Int { self.size }

pub fn GeointersectpointEdge::get(self : GeointersectpointEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointEdge::set(self : GeointersectpointEdge, i : Int, v : Double) -> GeointersectpointEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointEdge::sum(self : GeointersectpointEdge) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointEdge::mean(self : GeointersectpointEdge) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointEdge::scale(self : GeointersectpointEdge, f : Double) -> GeointersectpointEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointEdge::add(self : GeointersectpointEdge, other : GeointersectpointEdge) -> GeointersectpointEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointEdge::copy(self : GeointersectpointEdge) -> GeointersectpointEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointEdge::fill(self : GeointersectpointEdge, v : Double) -> GeointersectpointEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointEdge::min(self : GeointersectpointEdge) -> Double { @_common.min(self.data) }

pub fn GeointersectpointEdge::max(self : GeointersectpointEdge) -> Double { @_common.max(self.data) }

pub fn GeointersectpointEdge::to_string(self : GeointersectpointEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_path_make(size : Int) -> GeointersectpointPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointPath::len(self : GeointersectpointPath) -> Int { self.size }

pub fn GeointersectpointPath::get(self : GeointersectpointPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointPath::set(self : GeointersectpointPath, i : Int, v : Double) -> GeointersectpointPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointPath::sum(self : GeointersectpointPath) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointPath::mean(self : GeointersectpointPath) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointPath::scale(self : GeointersectpointPath, f : Double) -> GeointersectpointPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointPath::add(self : GeointersectpointPath, other : GeointersectpointPath) -> GeointersectpointPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointPath::copy(self : GeointersectpointPath) -> GeointersectpointPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointPath::fill(self : GeointersectpointPath, v : Double) -> GeointersectpointPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointPath::min(self : GeointersectpointPath) -> Double { @_common.min(self.data) }

pub fn GeointersectpointPath::max(self : GeointersectpointPath) -> Double { @_common.max(self.data) }

pub fn GeointersectpointPath::to_string(self : GeointersectpointPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_cluster_make(size : Int) -> GeointersectpointCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointCluster::len(self : GeointersectpointCluster) -> Int { self.size }

pub fn GeointersectpointCluster::get(self : GeointersectpointCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointCluster::set(self : GeointersectpointCluster, i : Int, v : Double) -> GeointersectpointCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointCluster::sum(self : GeointersectpointCluster) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointCluster::mean(self : GeointersectpointCluster) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointCluster::scale(self : GeointersectpointCluster, f : Double) -> GeointersectpointCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointCluster::add(self : GeointersectpointCluster, other : GeointersectpointCluster) -> GeointersectpointCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointCluster::copy(self : GeointersectpointCluster) -> GeointersectpointCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointCluster::fill(self : GeointersectpointCluster, v : Double) -> GeointersectpointCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointCluster::min(self : GeointersectpointCluster) -> Double { @_common.min(self.data) }

pub fn GeointersectpointCluster::max(self : GeointersectpointCluster) -> Double { @_common.max(self.data) }

pub fn GeointersectpointCluster::to_string(self : GeointersectpointCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_model_make(size : Int) -> GeointersectpointModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointModel::len(self : GeointersectpointModel) -> Int { self.size }

pub fn GeointersectpointModel::get(self : GeointersectpointModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointModel::set(self : GeointersectpointModel, i : Int, v : Double) -> GeointersectpointModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointModel::sum(self : GeointersectpointModel) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointModel::mean(self : GeointersectpointModel) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointModel::scale(self : GeointersectpointModel, f : Double) -> GeointersectpointModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointModel::add(self : GeointersectpointModel, other : GeointersectpointModel) -> GeointersectpointModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointModel::copy(self : GeointersectpointModel) -> GeointersectpointModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointModel::fill(self : GeointersectpointModel, v : Double) -> GeointersectpointModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointModel::min(self : GeointersectpointModel) -> Double { @_common.min(self.data) }

pub fn GeointersectpointModel::max(self : GeointersectpointModel) -> Double { @_common.max(self.data) }

pub fn GeointersectpointModel::to_string(self : GeointersectpointModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_layer_make(size : Int) -> GeointersectpointLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointLayer::len(self : GeointersectpointLayer) -> Int { self.size }

pub fn GeointersectpointLayer::get(self : GeointersectpointLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointLayer::set(self : GeointersectpointLayer, i : Int, v : Double) -> GeointersectpointLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointLayer::sum(self : GeointersectpointLayer) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointLayer::mean(self : GeointersectpointLayer) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointLayer::scale(self : GeointersectpointLayer, f : Double) -> GeointersectpointLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointLayer::add(self : GeointersectpointLayer, other : GeointersectpointLayer) -> GeointersectpointLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointLayer::copy(self : GeointersectpointLayer) -> GeointersectpointLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointLayer::fill(self : GeointersectpointLayer, v : Double) -> GeointersectpointLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointLayer::min(self : GeointersectpointLayer) -> Double { @_common.min(self.data) }

pub fn GeointersectpointLayer::max(self : GeointersectpointLayer) -> Double { @_common.max(self.data) }

pub fn GeointersectpointLayer::to_string(self : GeointersectpointLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_buffer_make(size : Int) -> GeointersectpointBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointBuffer::len(self : GeointersectpointBuffer) -> Int { self.size }

pub fn GeointersectpointBuffer::get(self : GeointersectpointBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointBuffer::set(self : GeointersectpointBuffer, i : Int, v : Double) -> GeointersectpointBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointBuffer::sum(self : GeointersectpointBuffer) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointBuffer::mean(self : GeointersectpointBuffer) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointBuffer::scale(self : GeointersectpointBuffer, f : Double) -> GeointersectpointBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointBuffer::add(self : GeointersectpointBuffer, other : GeointersectpointBuffer) -> GeointersectpointBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointBuffer::copy(self : GeointersectpointBuffer) -> GeointersectpointBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointBuffer::fill(self : GeointersectpointBuffer, v : Double) -> GeointersectpointBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointBuffer::min(self : GeointersectpointBuffer) -> Double { @_common.min(self.data) }

pub fn GeointersectpointBuffer::max(self : GeointersectpointBuffer) -> Double { @_common.max(self.data) }

pub fn GeointersectpointBuffer::to_string(self : GeointersectpointBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_cursor_make(size : Int) -> GeointersectpointCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointCursor::len(self : GeointersectpointCursor) -> Int { self.size }

pub fn GeointersectpointCursor::get(self : GeointersectpointCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointCursor::set(self : GeointersectpointCursor, i : Int, v : Double) -> GeointersectpointCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointCursor::sum(self : GeointersectpointCursor) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointCursor::mean(self : GeointersectpointCursor) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointCursor::scale(self : GeointersectpointCursor, f : Double) -> GeointersectpointCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointCursor::add(self : GeointersectpointCursor, other : GeointersectpointCursor) -> GeointersectpointCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointCursor::copy(self : GeointersectpointCursor) -> GeointersectpointCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointCursor::fill(self : GeointersectpointCursor, v : Double) -> GeointersectpointCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointCursor::min(self : GeointersectpointCursor) -> Double { @_common.min(self.data) }

pub fn GeointersectpointCursor::max(self : GeointersectpointCursor) -> Double { @_common.max(self.data) }

pub fn GeointersectpointCursor::to_string(self : GeointersectpointCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_view_make(size : Int) -> GeointersectpointView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointView::len(self : GeointersectpointView) -> Int { self.size }

pub fn GeointersectpointView::get(self : GeointersectpointView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointView::set(self : GeointersectpointView, i : Int, v : Double) -> GeointersectpointView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointView::sum(self : GeointersectpointView) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointView::mean(self : GeointersectpointView) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointView::scale(self : GeointersectpointView, f : Double) -> GeointersectpointView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointView::add(self : GeointersectpointView, other : GeointersectpointView) -> GeointersectpointView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointView::copy(self : GeointersectpointView) -> GeointersectpointView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointView::fill(self : GeointersectpointView, v : Double) -> GeointersectpointView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointView::min(self : GeointersectpointView) -> Double { @_common.min(self.data) }

pub fn GeointersectpointView::max(self : GeointersectpointView) -> Double { @_common.max(self.data) }

pub fn GeointersectpointView::to_string(self : GeointersectpointView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_range_make(size : Int) -> GeointersectpointRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointRange::len(self : GeointersectpointRange) -> Int { self.size }

pub fn GeointersectpointRange::get(self : GeointersectpointRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointRange::set(self : GeointersectpointRange, i : Int, v : Double) -> GeointersectpointRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointRange::sum(self : GeointersectpointRange) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointRange::mean(self : GeointersectpointRange) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointRange::scale(self : GeointersectpointRange, f : Double) -> GeointersectpointRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointRange::add(self : GeointersectpointRange, other : GeointersectpointRange) -> GeointersectpointRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointRange::copy(self : GeointersectpointRange) -> GeointersectpointRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointRange::fill(self : GeointersectpointRange, v : Double) -> GeointersectpointRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointRange::min(self : GeointersectpointRange) -> Double { @_common.min(self.data) }

pub fn GeointersectpointRange::max(self : GeointersectpointRange) -> Double { @_common.max(self.data) }

pub fn GeointersectpointRange::to_string(self : GeointersectpointRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectpointSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_point_slice_make(size : Int) -> GeointersectpointSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectpointSlice::len(self : GeointersectpointSlice) -> Int { self.size }

pub fn GeointersectpointSlice::get(self : GeointersectpointSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectpointSlice::set(self : GeointersectpointSlice, i : Int, v : Double) -> GeointersectpointSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectpointSlice::sum(self : GeointersectpointSlice) -> Double { @_common.sum(self.data) }

pub fn GeointersectpointSlice::mean(self : GeointersectpointSlice) -> Double { @_common.mean(self.data) }

pub fn GeointersectpointSlice::scale(self : GeointersectpointSlice, f : Double) -> GeointersectpointSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectpointSlice::add(self : GeointersectpointSlice, other : GeointersectpointSlice) -> GeointersectpointSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectpointSlice::copy(self : GeointersectpointSlice) -> GeointersectpointSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectpointSlice::fill(self : GeointersectpointSlice, v : Double) -> GeointersectpointSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectpointSlice::min(self : GeointersectpointSlice) -> Double { @_common.min(self.data) }

pub fn GeointersectpointSlice::max(self : GeointersectpointSlice) -> Double { @_common.max(self.data) }

pub fn GeointersectpointSlice::to_string(self : GeointersectpointSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

