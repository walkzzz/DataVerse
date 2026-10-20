///===
/// extcore/nlp_parse_dependency

pub(all) struct NlpparsedependencyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_dependency_make_point(x : Double, y : Double) -> NlpparsedependencyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_dependency_make_point3(x : Double, y : Double, z : Double) -> NlpparsedependencyPoint {
  { x, y, z, label: 0 }
}

pub fn NlpparsedependencyPoint::x(self : NlpparsedependencyPoint) -> Double { self.x }

pub fn NlpparsedependencyPoint::y(self : NlpparsedependencyPoint) -> Double { self.y }

pub fn NlpparsedependencyPoint::z(self : NlpparsedependencyPoint) -> Double { self.z }

pub fn NlpparsedependencyPoint::label(self : NlpparsedependencyPoint) -> Int { self.label }

pub fn NlpparsedependencyPoint::dist(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpparsedependencyPoint::add(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpparsedependencyPoint::sub(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpparsedependencyPoint::scale(self : NlpparsedependencyPoint, s : Double) -> NlpparsedependencyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpparsedependencyPoint::dot(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpparsedependencyPoint::cross(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpparsedependencyPoint::norm(self : NlpparsedependencyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpparsedependencyPoint::normalize(self : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsedependencyPoint::negate(self : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpparsedependencyPoint::mid(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpparsedependencyPoint::lerp(self : NlpparsedependencyPoint, other : NlpparsedependencyPoint, t : Double) -> NlpparsedependencyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpparsedependencyPoint::to_string(self : NlpparsedependencyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpparsedependencySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_dependency_make_series(vals : Array[Double], name : String) -> NlpparsedependencySeries {
  { vals, name, meta: 0 }
}

pub fn NlpparsedependencySeries::len(self : NlpparsedependencySeries) -> Int { self.vals.length() }

pub fn NlpparsedependencySeries::sum(self : NlpparsedependencySeries) -> Double { @_common.sum(self.vals) }

pub fn NlpparsedependencySeries::mean(self : NlpparsedependencySeries) -> Double { @_common.mean(self.vals) }

pub fn NlpparsedependencySeries::min(self : NlpparsedependencySeries) -> Double { @_common.min(self.vals) }

pub fn NlpparsedependencySeries::max(self : NlpparsedependencySeries) -> Double { @_common.max(self.vals) }

pub fn NlpparsedependencySeries::range(self : NlpparsedependencySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpparsedependencySeries::variance(self : NlpparsedependencySeries) -> Double { @_common.variance(self.vals) }

pub fn NlpparsedependencySeries::std(self : NlpparsedependencySeries) -> Double { @_common.std(self.vals) }

pub fn NlpparsedependencySeries::median(self : NlpparsedependencySeries) -> Double { @_common.median(self.vals) }

pub fn NlpparsedependencySeries::scale(self : NlpparsedependencySeries, f : Double) -> NlpparsedependencySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpparsedependencySeries::add(self : NlpparsedependencySeries, other : NlpparsedependencySeries) -> NlpparsedependencySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpparsedependencySeries::sub(self : NlpparsedependencySeries, other : NlpparsedependencySeries) -> NlpparsedependencySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpparsedependencySeries::normalize(self : NlpparsedependencySeries) -> NlpparsedependencySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpparsedependencySeries::cumsum(self : NlpparsedependencySeries) -> NlpparsedependencySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpparsedependencySeries::to_string(self : NlpparsedependencySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsedependencyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_dependency_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsedependencyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_dependency_matrix_identity(n : Int) -> NlpparsedependencyMatrix {
  let m = nlp_parse_dependency_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpparsedependencyMatrix::get(self : NlpparsedependencyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpparsedependencyMatrix::transpose(self : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  let result = nlp_parse_dependency_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpparsedependencyMatrix::add(self : NlpparsedependencyMatrix, other : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_parse_dependency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpparsedependencyMatrix::scale(self : NlpparsedependencyMatrix, s : Double) -> NlpparsedependencyMatrix {
  let result = nlp_parse_dependency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpparsedependencyMatrix::multiply(self : NlpparsedependencyMatrix, other : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  if self.cols != other.rows { return nlp_parse_dependency_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_parse_dependency_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpparsedependencyMatrix::trace(self : NlpparsedependencyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpparsedependencyMatrix::det(self : NlpparsedependencyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpparsedependencyMatrix::norm(self : NlpparsedependencyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpparsedependencyMatrix::to_string(self : NlpparsedependencyMatrix) -> String {
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

pub(all) struct NlpparsedependencyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_dependency_make_vector(comps : Array[Double]) -> NlpparsedependencyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_dependency_vector_zero(dim : Int) -> NlpparsedependencyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpparsedependencyVector::add(self : NlpparsedependencyVector, other : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsedependencyVector::sub(self : NlpparsedependencyVector, other : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsedependencyVector::scale(self : NlpparsedependencyVector, s : Double) -> NlpparsedependencyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpparsedependencyVector::dot(self : NlpparsedependencyVector, other : NlpparsedependencyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpparsedependencyVector::norm(self : NlpparsedependencyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpparsedependencyVector::normalize(self : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsedependencyVector::dist(self : NlpparsedependencyVector, other : NlpparsedependencyVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpparsedependencyVector::to_string(self : NlpparsedependencyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsedependencyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_frame_make(size : Int) -> NlpparsedependencyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyFrame::len(self : NlpparsedependencyFrame) -> Int { self.size }

pub fn NlpparsedependencyFrame::get(self : NlpparsedependencyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyFrame::set(self : NlpparsedependencyFrame, i : Int, v : Double) -> NlpparsedependencyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyFrame::sum(self : NlpparsedependencyFrame) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyFrame::mean(self : NlpparsedependencyFrame) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyFrame::scale(self : NlpparsedependencyFrame, f : Double) -> NlpparsedependencyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyFrame::add(self : NlpparsedependencyFrame, other : NlpparsedependencyFrame) -> NlpparsedependencyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyFrame::copy(self : NlpparsedependencyFrame) -> NlpparsedependencyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyFrame::fill(self : NlpparsedependencyFrame, v : Double) -> NlpparsedependencyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyFrame::min(self : NlpparsedependencyFrame) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyFrame::max(self : NlpparsedependencyFrame) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyFrame::to_string(self : NlpparsedependencyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_table_make(size : Int) -> NlpparsedependencyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyTable::len(self : NlpparsedependencyTable) -> Int { self.size }

pub fn NlpparsedependencyTable::get(self : NlpparsedependencyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyTable::set(self : NlpparsedependencyTable, i : Int, v : Double) -> NlpparsedependencyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyTable::sum(self : NlpparsedependencyTable) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyTable::mean(self : NlpparsedependencyTable) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyTable::scale(self : NlpparsedependencyTable, f : Double) -> NlpparsedependencyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyTable::add(self : NlpparsedependencyTable, other : NlpparsedependencyTable) -> NlpparsedependencyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyTable::copy(self : NlpparsedependencyTable) -> NlpparsedependencyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyTable::fill(self : NlpparsedependencyTable, v : Double) -> NlpparsedependencyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyTable::min(self : NlpparsedependencyTable) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyTable::max(self : NlpparsedependencyTable) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyTable::to_string(self : NlpparsedependencyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_graphn_make(size : Int) -> NlpparsedependencyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyGraphN::len(self : NlpparsedependencyGraphN) -> Int { self.size }

pub fn NlpparsedependencyGraphN::get(self : NlpparsedependencyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyGraphN::set(self : NlpparsedependencyGraphN, i : Int, v : Double) -> NlpparsedependencyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyGraphN::sum(self : NlpparsedependencyGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyGraphN::mean(self : NlpparsedependencyGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyGraphN::scale(self : NlpparsedependencyGraphN, f : Double) -> NlpparsedependencyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyGraphN::add(self : NlpparsedependencyGraphN, other : NlpparsedependencyGraphN) -> NlpparsedependencyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyGraphN::copy(self : NlpparsedependencyGraphN) -> NlpparsedependencyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyGraphN::fill(self : NlpparsedependencyGraphN, v : Double) -> NlpparsedependencyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyGraphN::min(self : NlpparsedependencyGraphN) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyGraphN::max(self : NlpparsedependencyGraphN) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyGraphN::to_string(self : NlpparsedependencyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_node_make(size : Int) -> NlpparsedependencyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyNode::len(self : NlpparsedependencyNode) -> Int { self.size }

pub fn NlpparsedependencyNode::get(self : NlpparsedependencyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyNode::set(self : NlpparsedependencyNode, i : Int, v : Double) -> NlpparsedependencyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyNode::sum(self : NlpparsedependencyNode) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyNode::mean(self : NlpparsedependencyNode) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyNode::scale(self : NlpparsedependencyNode, f : Double) -> NlpparsedependencyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyNode::add(self : NlpparsedependencyNode, other : NlpparsedependencyNode) -> NlpparsedependencyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyNode::copy(self : NlpparsedependencyNode) -> NlpparsedependencyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyNode::fill(self : NlpparsedependencyNode, v : Double) -> NlpparsedependencyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyNode::min(self : NlpparsedependencyNode) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyNode::max(self : NlpparsedependencyNode) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyNode::to_string(self : NlpparsedependencyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_edge_make(size : Int) -> NlpparsedependencyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyEdge::len(self : NlpparsedependencyEdge) -> Int { self.size }

pub fn NlpparsedependencyEdge::get(self : NlpparsedependencyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyEdge::set(self : NlpparsedependencyEdge, i : Int, v : Double) -> NlpparsedependencyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyEdge::sum(self : NlpparsedependencyEdge) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyEdge::mean(self : NlpparsedependencyEdge) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyEdge::scale(self : NlpparsedependencyEdge, f : Double) -> NlpparsedependencyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyEdge::add(self : NlpparsedependencyEdge, other : NlpparsedependencyEdge) -> NlpparsedependencyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyEdge::copy(self : NlpparsedependencyEdge) -> NlpparsedependencyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyEdge::fill(self : NlpparsedependencyEdge, v : Double) -> NlpparsedependencyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyEdge::min(self : NlpparsedependencyEdge) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyEdge::max(self : NlpparsedependencyEdge) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyEdge::to_string(self : NlpparsedependencyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_path_make(size : Int) -> NlpparsedependencyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyPath::len(self : NlpparsedependencyPath) -> Int { self.size }

pub fn NlpparsedependencyPath::get(self : NlpparsedependencyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyPath::set(self : NlpparsedependencyPath, i : Int, v : Double) -> NlpparsedependencyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyPath::sum(self : NlpparsedependencyPath) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyPath::mean(self : NlpparsedependencyPath) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyPath::scale(self : NlpparsedependencyPath, f : Double) -> NlpparsedependencyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyPath::add(self : NlpparsedependencyPath, other : NlpparsedependencyPath) -> NlpparsedependencyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyPath::copy(self : NlpparsedependencyPath) -> NlpparsedependencyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyPath::fill(self : NlpparsedependencyPath, v : Double) -> NlpparsedependencyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyPath::min(self : NlpparsedependencyPath) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyPath::max(self : NlpparsedependencyPath) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyPath::to_string(self : NlpparsedependencyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_cluster_make(size : Int) -> NlpparsedependencyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyCluster::len(self : NlpparsedependencyCluster) -> Int { self.size }

pub fn NlpparsedependencyCluster::get(self : NlpparsedependencyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyCluster::set(self : NlpparsedependencyCluster, i : Int, v : Double) -> NlpparsedependencyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyCluster::sum(self : NlpparsedependencyCluster) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyCluster::mean(self : NlpparsedependencyCluster) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyCluster::scale(self : NlpparsedependencyCluster, f : Double) -> NlpparsedependencyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyCluster::add(self : NlpparsedependencyCluster, other : NlpparsedependencyCluster) -> NlpparsedependencyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyCluster::copy(self : NlpparsedependencyCluster) -> NlpparsedependencyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyCluster::fill(self : NlpparsedependencyCluster, v : Double) -> NlpparsedependencyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyCluster::min(self : NlpparsedependencyCluster) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyCluster::max(self : NlpparsedependencyCluster) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyCluster::to_string(self : NlpparsedependencyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_model_make(size : Int) -> NlpparsedependencyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyModel::len(self : NlpparsedependencyModel) -> Int { self.size }

pub fn NlpparsedependencyModel::get(self : NlpparsedependencyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyModel::set(self : NlpparsedependencyModel, i : Int, v : Double) -> NlpparsedependencyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyModel::sum(self : NlpparsedependencyModel) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyModel::mean(self : NlpparsedependencyModel) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyModel::scale(self : NlpparsedependencyModel, f : Double) -> NlpparsedependencyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyModel::add(self : NlpparsedependencyModel, other : NlpparsedependencyModel) -> NlpparsedependencyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyModel::copy(self : NlpparsedependencyModel) -> NlpparsedependencyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyModel::fill(self : NlpparsedependencyModel, v : Double) -> NlpparsedependencyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyModel::min(self : NlpparsedependencyModel) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyModel::max(self : NlpparsedependencyModel) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyModel::to_string(self : NlpparsedependencyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_layer_make(size : Int) -> NlpparsedependencyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyLayer::len(self : NlpparsedependencyLayer) -> Int { self.size }

pub fn NlpparsedependencyLayer::get(self : NlpparsedependencyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyLayer::set(self : NlpparsedependencyLayer, i : Int, v : Double) -> NlpparsedependencyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyLayer::sum(self : NlpparsedependencyLayer) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyLayer::mean(self : NlpparsedependencyLayer) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyLayer::scale(self : NlpparsedependencyLayer, f : Double) -> NlpparsedependencyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyLayer::add(self : NlpparsedependencyLayer, other : NlpparsedependencyLayer) -> NlpparsedependencyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyLayer::copy(self : NlpparsedependencyLayer) -> NlpparsedependencyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyLayer::fill(self : NlpparsedependencyLayer, v : Double) -> NlpparsedependencyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyLayer::min(self : NlpparsedependencyLayer) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyLayer::max(self : NlpparsedependencyLayer) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyLayer::to_string(self : NlpparsedependencyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_buffer_make(size : Int) -> NlpparsedependencyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyBuffer::len(self : NlpparsedependencyBuffer) -> Int { self.size }

pub fn NlpparsedependencyBuffer::get(self : NlpparsedependencyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyBuffer::set(self : NlpparsedependencyBuffer, i : Int, v : Double) -> NlpparsedependencyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyBuffer::sum(self : NlpparsedependencyBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyBuffer::mean(self : NlpparsedependencyBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyBuffer::scale(self : NlpparsedependencyBuffer, f : Double) -> NlpparsedependencyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyBuffer::add(self : NlpparsedependencyBuffer, other : NlpparsedependencyBuffer) -> NlpparsedependencyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyBuffer::copy(self : NlpparsedependencyBuffer) -> NlpparsedependencyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyBuffer::fill(self : NlpparsedependencyBuffer, v : Double) -> NlpparsedependencyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyBuffer::min(self : NlpparsedependencyBuffer) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyBuffer::max(self : NlpparsedependencyBuffer) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyBuffer::to_string(self : NlpparsedependencyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_cursor_make(size : Int) -> NlpparsedependencyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyCursor::len(self : NlpparsedependencyCursor) -> Int { self.size }

pub fn NlpparsedependencyCursor::get(self : NlpparsedependencyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyCursor::set(self : NlpparsedependencyCursor, i : Int, v : Double) -> NlpparsedependencyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyCursor::sum(self : NlpparsedependencyCursor) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyCursor::mean(self : NlpparsedependencyCursor) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyCursor::scale(self : NlpparsedependencyCursor, f : Double) -> NlpparsedependencyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyCursor::add(self : NlpparsedependencyCursor, other : NlpparsedependencyCursor) -> NlpparsedependencyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyCursor::copy(self : NlpparsedependencyCursor) -> NlpparsedependencyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyCursor::fill(self : NlpparsedependencyCursor, v : Double) -> NlpparsedependencyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyCursor::min(self : NlpparsedependencyCursor) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyCursor::max(self : NlpparsedependencyCursor) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyCursor::to_string(self : NlpparsedependencyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_view_make(size : Int) -> NlpparsedependencyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyView::len(self : NlpparsedependencyView) -> Int { self.size }

pub fn NlpparsedependencyView::get(self : NlpparsedependencyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyView::set(self : NlpparsedependencyView, i : Int, v : Double) -> NlpparsedependencyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyView::sum(self : NlpparsedependencyView) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyView::mean(self : NlpparsedependencyView) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyView::scale(self : NlpparsedependencyView, f : Double) -> NlpparsedependencyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyView::add(self : NlpparsedependencyView, other : NlpparsedependencyView) -> NlpparsedependencyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyView::copy(self : NlpparsedependencyView) -> NlpparsedependencyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyView::fill(self : NlpparsedependencyView, v : Double) -> NlpparsedependencyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyView::min(self : NlpparsedependencyView) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyView::max(self : NlpparsedependencyView) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyView::to_string(self : NlpparsedependencyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_range_make(size : Int) -> NlpparsedependencyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencyRange::len(self : NlpparsedependencyRange) -> Int { self.size }

pub fn NlpparsedependencyRange::get(self : NlpparsedependencyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencyRange::set(self : NlpparsedependencyRange, i : Int, v : Double) -> NlpparsedependencyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyRange::sum(self : NlpparsedependencyRange) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencyRange::mean(self : NlpparsedependencyRange) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencyRange::scale(self : NlpparsedependencyRange, f : Double) -> NlpparsedependencyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyRange::add(self : NlpparsedependencyRange, other : NlpparsedependencyRange) -> NlpparsedependencyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencyRange::copy(self : NlpparsedependencyRange) -> NlpparsedependencyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyRange::fill(self : NlpparsedependencyRange, v : Double) -> NlpparsedependencyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencyRange::min(self : NlpparsedependencyRange) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencyRange::max(self : NlpparsedependencyRange) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencyRange::to_string(self : NlpparsedependencyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_slice_make(size : Int) -> NlpparsedependencySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsedependencySlice::len(self : NlpparsedependencySlice) -> Int { self.size }

pub fn NlpparsedependencySlice::get(self : NlpparsedependencySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsedependencySlice::set(self : NlpparsedependencySlice, i : Int, v : Double) -> NlpparsedependencySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsedependencySlice::sum(self : NlpparsedependencySlice) -> Double { @_common.sum(self.data) }

pub fn NlpparsedependencySlice::mean(self : NlpparsedependencySlice) -> Double { @_common.mean(self.data) }

pub fn NlpparsedependencySlice::scale(self : NlpparsedependencySlice, f : Double) -> NlpparsedependencySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencySlice::add(self : NlpparsedependencySlice, other : NlpparsedependencySlice) -> NlpparsedependencySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsedependencySlice::copy(self : NlpparsedependencySlice) -> NlpparsedependencySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencySlice::fill(self : NlpparsedependencySlice, v : Double) -> NlpparsedependencySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsedependencySlice::min(self : NlpparsedependencySlice) -> Double { @_common.min(self.data) }

pub fn NlpparsedependencySlice::max(self : NlpparsedependencySlice) -> Double { @_common.max(self.data) }

pub fn NlpparsedependencySlice::to_string(self : NlpparsedependencySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

