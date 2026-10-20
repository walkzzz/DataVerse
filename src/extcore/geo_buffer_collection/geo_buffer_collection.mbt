///===
/// extcore/geo_buffer_collection

pub(all) struct GeobuffercollectionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_collection_make_point(x : Double, y : Double) -> GeobuffercollectionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_collection_make_point3(x : Double, y : Double, z : Double) -> GeobuffercollectionPoint {
  { x, y, z, label: 0 }
}

pub fn GeobuffercollectionPoint::x(self : GeobuffercollectionPoint) -> Double { self.x }

pub fn GeobuffercollectionPoint::y(self : GeobuffercollectionPoint) -> Double { self.y }

pub fn GeobuffercollectionPoint::z(self : GeobuffercollectionPoint) -> Double { self.z }

pub fn GeobuffercollectionPoint::label(self : GeobuffercollectionPoint) -> Int { self.label }

pub fn GeobuffercollectionPoint::dist(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobuffercollectionPoint::add(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobuffercollectionPoint::sub(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobuffercollectionPoint::scale(self : GeobuffercollectionPoint, s : Double) -> GeobuffercollectionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobuffercollectionPoint::dot(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobuffercollectionPoint::cross(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobuffercollectionPoint::norm(self : GeobuffercollectionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobuffercollectionPoint::normalize(self : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffercollectionPoint::negate(self : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobuffercollectionPoint::mid(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobuffercollectionPoint::lerp(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint, t : Double) -> GeobuffercollectionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobuffercollectionPoint::to_string(self : GeobuffercollectionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobuffercollectionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_collection_make_series(vals : Array[Double], name : String) -> GeobuffercollectionSeries {
  { vals, name, meta: 0 }
}

pub fn GeobuffercollectionSeries::len(self : GeobuffercollectionSeries) -> Int { self.vals.length() }

pub fn GeobuffercollectionSeries::sum(self : GeobuffercollectionSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobuffercollectionSeries::mean(self : GeobuffercollectionSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobuffercollectionSeries::min(self : GeobuffercollectionSeries) -> Double { @_common.min(self.vals) }

pub fn GeobuffercollectionSeries::max(self : GeobuffercollectionSeries) -> Double { @_common.max(self.vals) }

pub fn GeobuffercollectionSeries::range(self : GeobuffercollectionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobuffercollectionSeries::variance(self : GeobuffercollectionSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobuffercollectionSeries::std(self : GeobuffercollectionSeries) -> Double { @_common.std(self.vals) }

pub fn GeobuffercollectionSeries::median(self : GeobuffercollectionSeries) -> Double { @_common.median(self.vals) }

pub fn GeobuffercollectionSeries::scale(self : GeobuffercollectionSeries, f : Double) -> GeobuffercollectionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobuffercollectionSeries::add(self : GeobuffercollectionSeries, other : GeobuffercollectionSeries) -> GeobuffercollectionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobuffercollectionSeries::sub(self : GeobuffercollectionSeries, other : GeobuffercollectionSeries) -> GeobuffercollectionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobuffercollectionSeries::normalize(self : GeobuffercollectionSeries) -> GeobuffercollectionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobuffercollectionSeries::cumsum(self : GeobuffercollectionSeries) -> GeobuffercollectionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobuffercollectionSeries::to_string(self : GeobuffercollectionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffercollectionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_collection_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffercollectionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_collection_matrix_identity(n : Int) -> GeobuffercollectionMatrix {
  let m = geo_buffer_collection_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobuffercollectionMatrix::get(self : GeobuffercollectionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobuffercollectionMatrix::transpose(self : GeobuffercollectionMatrix) -> GeobuffercollectionMatrix {
  let result = geo_buffer_collection_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobuffercollectionMatrix::add(self : GeobuffercollectionMatrix, other : GeobuffercollectionMatrix) -> GeobuffercollectionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_collection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobuffercollectionMatrix::scale(self : GeobuffercollectionMatrix, s : Double) -> GeobuffercollectionMatrix {
  let result = geo_buffer_collection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobuffercollectionMatrix::multiply(self : GeobuffercollectionMatrix, other : GeobuffercollectionMatrix) -> GeobuffercollectionMatrix {
  if self.cols != other.rows { return geo_buffer_collection_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_collection_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobuffercollectionMatrix::trace(self : GeobuffercollectionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobuffercollectionMatrix::det(self : GeobuffercollectionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobuffercollectionMatrix::norm(self : GeobuffercollectionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobuffercollectionMatrix::to_string(self : GeobuffercollectionMatrix) -> String {
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

pub(all) struct GeobuffercollectionVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_collection_make_vector(comps : Array[Double]) -> GeobuffercollectionVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_collection_vector_zero(dim : Int) -> GeobuffercollectionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobuffercollectionVector::add(self : GeobuffercollectionVector, other : GeobuffercollectionVector) -> GeobuffercollectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffercollectionVector::sub(self : GeobuffercollectionVector, other : GeobuffercollectionVector) -> GeobuffercollectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffercollectionVector::scale(self : GeobuffercollectionVector, s : Double) -> GeobuffercollectionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobuffercollectionVector::dot(self : GeobuffercollectionVector, other : GeobuffercollectionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobuffercollectionVector::norm(self : GeobuffercollectionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobuffercollectionVector::normalize(self : GeobuffercollectionVector) -> GeobuffercollectionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffercollectionVector::dist(self : GeobuffercollectionVector, other : GeobuffercollectionVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobuffercollectionVector::to_string(self : GeobuffercollectionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffercollectionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_frame_make(size : Int) -> GeobuffercollectionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionFrame::len(self : GeobuffercollectionFrame) -> Int { self.size }

pub fn GeobuffercollectionFrame::get(self : GeobuffercollectionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionFrame::set(self : GeobuffercollectionFrame, i : Int, v : Double) -> GeobuffercollectionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionFrame::sum(self : GeobuffercollectionFrame) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionFrame::mean(self : GeobuffercollectionFrame) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionFrame::scale(self : GeobuffercollectionFrame, f : Double) -> GeobuffercollectionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionFrame::add(self : GeobuffercollectionFrame, other : GeobuffercollectionFrame) -> GeobuffercollectionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionFrame::copy(self : GeobuffercollectionFrame) -> GeobuffercollectionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionFrame::fill(self : GeobuffercollectionFrame, v : Double) -> GeobuffercollectionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionFrame::min(self : GeobuffercollectionFrame) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionFrame::max(self : GeobuffercollectionFrame) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionFrame::to_string(self : GeobuffercollectionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_table_make(size : Int) -> GeobuffercollectionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionTable::len(self : GeobuffercollectionTable) -> Int { self.size }

pub fn GeobuffercollectionTable::get(self : GeobuffercollectionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionTable::set(self : GeobuffercollectionTable, i : Int, v : Double) -> GeobuffercollectionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionTable::sum(self : GeobuffercollectionTable) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionTable::mean(self : GeobuffercollectionTable) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionTable::scale(self : GeobuffercollectionTable, f : Double) -> GeobuffercollectionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionTable::add(self : GeobuffercollectionTable, other : GeobuffercollectionTable) -> GeobuffercollectionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionTable::copy(self : GeobuffercollectionTable) -> GeobuffercollectionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionTable::fill(self : GeobuffercollectionTable, v : Double) -> GeobuffercollectionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionTable::min(self : GeobuffercollectionTable) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionTable::max(self : GeobuffercollectionTable) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionTable::to_string(self : GeobuffercollectionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_graphn_make(size : Int) -> GeobuffercollectionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionGraphN::len(self : GeobuffercollectionGraphN) -> Int { self.size }

pub fn GeobuffercollectionGraphN::get(self : GeobuffercollectionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionGraphN::set(self : GeobuffercollectionGraphN, i : Int, v : Double) -> GeobuffercollectionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionGraphN::sum(self : GeobuffercollectionGraphN) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionGraphN::mean(self : GeobuffercollectionGraphN) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionGraphN::scale(self : GeobuffercollectionGraphN, f : Double) -> GeobuffercollectionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionGraphN::add(self : GeobuffercollectionGraphN, other : GeobuffercollectionGraphN) -> GeobuffercollectionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionGraphN::copy(self : GeobuffercollectionGraphN) -> GeobuffercollectionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionGraphN::fill(self : GeobuffercollectionGraphN, v : Double) -> GeobuffercollectionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionGraphN::min(self : GeobuffercollectionGraphN) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionGraphN::max(self : GeobuffercollectionGraphN) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionGraphN::to_string(self : GeobuffercollectionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_node_make(size : Int) -> GeobuffercollectionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionNode::len(self : GeobuffercollectionNode) -> Int { self.size }

pub fn GeobuffercollectionNode::get(self : GeobuffercollectionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionNode::set(self : GeobuffercollectionNode, i : Int, v : Double) -> GeobuffercollectionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionNode::sum(self : GeobuffercollectionNode) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionNode::mean(self : GeobuffercollectionNode) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionNode::scale(self : GeobuffercollectionNode, f : Double) -> GeobuffercollectionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionNode::add(self : GeobuffercollectionNode, other : GeobuffercollectionNode) -> GeobuffercollectionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionNode::copy(self : GeobuffercollectionNode) -> GeobuffercollectionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionNode::fill(self : GeobuffercollectionNode, v : Double) -> GeobuffercollectionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionNode::min(self : GeobuffercollectionNode) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionNode::max(self : GeobuffercollectionNode) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionNode::to_string(self : GeobuffercollectionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_edge_make(size : Int) -> GeobuffercollectionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionEdge::len(self : GeobuffercollectionEdge) -> Int { self.size }

pub fn GeobuffercollectionEdge::get(self : GeobuffercollectionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionEdge::set(self : GeobuffercollectionEdge, i : Int, v : Double) -> GeobuffercollectionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionEdge::sum(self : GeobuffercollectionEdge) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionEdge::mean(self : GeobuffercollectionEdge) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionEdge::scale(self : GeobuffercollectionEdge, f : Double) -> GeobuffercollectionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionEdge::add(self : GeobuffercollectionEdge, other : GeobuffercollectionEdge) -> GeobuffercollectionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionEdge::copy(self : GeobuffercollectionEdge) -> GeobuffercollectionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionEdge::fill(self : GeobuffercollectionEdge, v : Double) -> GeobuffercollectionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionEdge::min(self : GeobuffercollectionEdge) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionEdge::max(self : GeobuffercollectionEdge) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionEdge::to_string(self : GeobuffercollectionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_path_make(size : Int) -> GeobuffercollectionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionPath::len(self : GeobuffercollectionPath) -> Int { self.size }

pub fn GeobuffercollectionPath::get(self : GeobuffercollectionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionPath::set(self : GeobuffercollectionPath, i : Int, v : Double) -> GeobuffercollectionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionPath::sum(self : GeobuffercollectionPath) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionPath::mean(self : GeobuffercollectionPath) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionPath::scale(self : GeobuffercollectionPath, f : Double) -> GeobuffercollectionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionPath::add(self : GeobuffercollectionPath, other : GeobuffercollectionPath) -> GeobuffercollectionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionPath::copy(self : GeobuffercollectionPath) -> GeobuffercollectionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionPath::fill(self : GeobuffercollectionPath, v : Double) -> GeobuffercollectionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionPath::min(self : GeobuffercollectionPath) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionPath::max(self : GeobuffercollectionPath) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionPath::to_string(self : GeobuffercollectionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_cluster_make(size : Int) -> GeobuffercollectionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionCluster::len(self : GeobuffercollectionCluster) -> Int { self.size }

pub fn GeobuffercollectionCluster::get(self : GeobuffercollectionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionCluster::set(self : GeobuffercollectionCluster, i : Int, v : Double) -> GeobuffercollectionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionCluster::sum(self : GeobuffercollectionCluster) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionCluster::mean(self : GeobuffercollectionCluster) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionCluster::scale(self : GeobuffercollectionCluster, f : Double) -> GeobuffercollectionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionCluster::add(self : GeobuffercollectionCluster, other : GeobuffercollectionCluster) -> GeobuffercollectionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionCluster::copy(self : GeobuffercollectionCluster) -> GeobuffercollectionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionCluster::fill(self : GeobuffercollectionCluster, v : Double) -> GeobuffercollectionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionCluster::min(self : GeobuffercollectionCluster) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionCluster::max(self : GeobuffercollectionCluster) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionCluster::to_string(self : GeobuffercollectionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_model_make(size : Int) -> GeobuffercollectionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionModel::len(self : GeobuffercollectionModel) -> Int { self.size }

pub fn GeobuffercollectionModel::get(self : GeobuffercollectionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionModel::set(self : GeobuffercollectionModel, i : Int, v : Double) -> GeobuffercollectionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionModel::sum(self : GeobuffercollectionModel) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionModel::mean(self : GeobuffercollectionModel) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionModel::scale(self : GeobuffercollectionModel, f : Double) -> GeobuffercollectionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionModel::add(self : GeobuffercollectionModel, other : GeobuffercollectionModel) -> GeobuffercollectionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionModel::copy(self : GeobuffercollectionModel) -> GeobuffercollectionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionModel::fill(self : GeobuffercollectionModel, v : Double) -> GeobuffercollectionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionModel::min(self : GeobuffercollectionModel) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionModel::max(self : GeobuffercollectionModel) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionModel::to_string(self : GeobuffercollectionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_layer_make(size : Int) -> GeobuffercollectionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionLayer::len(self : GeobuffercollectionLayer) -> Int { self.size }

pub fn GeobuffercollectionLayer::get(self : GeobuffercollectionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionLayer::set(self : GeobuffercollectionLayer, i : Int, v : Double) -> GeobuffercollectionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionLayer::sum(self : GeobuffercollectionLayer) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionLayer::mean(self : GeobuffercollectionLayer) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionLayer::scale(self : GeobuffercollectionLayer, f : Double) -> GeobuffercollectionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionLayer::add(self : GeobuffercollectionLayer, other : GeobuffercollectionLayer) -> GeobuffercollectionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionLayer::copy(self : GeobuffercollectionLayer) -> GeobuffercollectionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionLayer::fill(self : GeobuffercollectionLayer, v : Double) -> GeobuffercollectionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionLayer::min(self : GeobuffercollectionLayer) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionLayer::max(self : GeobuffercollectionLayer) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionLayer::to_string(self : GeobuffercollectionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_buffer_make(size : Int) -> GeobuffercollectionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionBuffer::len(self : GeobuffercollectionBuffer) -> Int { self.size }

pub fn GeobuffercollectionBuffer::get(self : GeobuffercollectionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionBuffer::set(self : GeobuffercollectionBuffer, i : Int, v : Double) -> GeobuffercollectionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionBuffer::sum(self : GeobuffercollectionBuffer) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionBuffer::mean(self : GeobuffercollectionBuffer) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionBuffer::scale(self : GeobuffercollectionBuffer, f : Double) -> GeobuffercollectionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionBuffer::add(self : GeobuffercollectionBuffer, other : GeobuffercollectionBuffer) -> GeobuffercollectionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionBuffer::copy(self : GeobuffercollectionBuffer) -> GeobuffercollectionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionBuffer::fill(self : GeobuffercollectionBuffer, v : Double) -> GeobuffercollectionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionBuffer::min(self : GeobuffercollectionBuffer) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionBuffer::max(self : GeobuffercollectionBuffer) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionBuffer::to_string(self : GeobuffercollectionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_cursor_make(size : Int) -> GeobuffercollectionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionCursor::len(self : GeobuffercollectionCursor) -> Int { self.size }

pub fn GeobuffercollectionCursor::get(self : GeobuffercollectionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionCursor::set(self : GeobuffercollectionCursor, i : Int, v : Double) -> GeobuffercollectionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionCursor::sum(self : GeobuffercollectionCursor) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionCursor::mean(self : GeobuffercollectionCursor) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionCursor::scale(self : GeobuffercollectionCursor, f : Double) -> GeobuffercollectionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionCursor::add(self : GeobuffercollectionCursor, other : GeobuffercollectionCursor) -> GeobuffercollectionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionCursor::copy(self : GeobuffercollectionCursor) -> GeobuffercollectionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionCursor::fill(self : GeobuffercollectionCursor, v : Double) -> GeobuffercollectionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionCursor::min(self : GeobuffercollectionCursor) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionCursor::max(self : GeobuffercollectionCursor) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionCursor::to_string(self : GeobuffercollectionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_view_make(size : Int) -> GeobuffercollectionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionView::len(self : GeobuffercollectionView) -> Int { self.size }

pub fn GeobuffercollectionView::get(self : GeobuffercollectionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionView::set(self : GeobuffercollectionView, i : Int, v : Double) -> GeobuffercollectionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionView::sum(self : GeobuffercollectionView) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionView::mean(self : GeobuffercollectionView) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionView::scale(self : GeobuffercollectionView, f : Double) -> GeobuffercollectionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionView::add(self : GeobuffercollectionView, other : GeobuffercollectionView) -> GeobuffercollectionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionView::copy(self : GeobuffercollectionView) -> GeobuffercollectionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionView::fill(self : GeobuffercollectionView, v : Double) -> GeobuffercollectionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionView::min(self : GeobuffercollectionView) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionView::max(self : GeobuffercollectionView) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionView::to_string(self : GeobuffercollectionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_range_make(size : Int) -> GeobuffercollectionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionRange::len(self : GeobuffercollectionRange) -> Int { self.size }

pub fn GeobuffercollectionRange::get(self : GeobuffercollectionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionRange::set(self : GeobuffercollectionRange, i : Int, v : Double) -> GeobuffercollectionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionRange::sum(self : GeobuffercollectionRange) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionRange::mean(self : GeobuffercollectionRange) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionRange::scale(self : GeobuffercollectionRange, f : Double) -> GeobuffercollectionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionRange::add(self : GeobuffercollectionRange, other : GeobuffercollectionRange) -> GeobuffercollectionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionRange::copy(self : GeobuffercollectionRange) -> GeobuffercollectionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionRange::fill(self : GeobuffercollectionRange, v : Double) -> GeobuffercollectionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionRange::min(self : GeobuffercollectionRange) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionRange::max(self : GeobuffercollectionRange) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionRange::to_string(self : GeobuffercollectionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_slice_make(size : Int) -> GeobuffercollectionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercollectionSlice::len(self : GeobuffercollectionSlice) -> Int { self.size }

pub fn GeobuffercollectionSlice::get(self : GeobuffercollectionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercollectionSlice::set(self : GeobuffercollectionSlice, i : Int, v : Double) -> GeobuffercollectionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionSlice::sum(self : GeobuffercollectionSlice) -> Double { @_common.sum(self.data) }

pub fn GeobuffercollectionSlice::mean(self : GeobuffercollectionSlice) -> Double { @_common.mean(self.data) }

pub fn GeobuffercollectionSlice::scale(self : GeobuffercollectionSlice, f : Double) -> GeobuffercollectionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionSlice::add(self : GeobuffercollectionSlice, other : GeobuffercollectionSlice) -> GeobuffercollectionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercollectionSlice::copy(self : GeobuffercollectionSlice) -> GeobuffercollectionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionSlice::fill(self : GeobuffercollectionSlice, v : Double) -> GeobuffercollectionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercollectionSlice::min(self : GeobuffercollectionSlice) -> Double { @_common.min(self.data) }

pub fn GeobuffercollectionSlice::max(self : GeobuffercollectionSlice) -> Double { @_common.max(self.data) }

pub fn GeobuffercollectionSlice::to_string(self : GeobuffercollectionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

