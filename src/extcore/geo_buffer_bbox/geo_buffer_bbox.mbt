///===
/// extcore/geo_buffer_bbox

pub(all) struct GeobufferbboxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_bbox_make_point(x : Double, y : Double) -> GeobufferbboxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_bbox_make_point3(x : Double, y : Double, z : Double) -> GeobufferbboxPoint {
  { x, y, z, label: 0 }
}

pub fn GeobufferbboxPoint::x(self : GeobufferbboxPoint) -> Double { self.x }

pub fn GeobufferbboxPoint::y(self : GeobufferbboxPoint) -> Double { self.y }

pub fn GeobufferbboxPoint::z(self : GeobufferbboxPoint) -> Double { self.z }

pub fn GeobufferbboxPoint::label(self : GeobufferbboxPoint) -> Int { self.label }

pub fn GeobufferbboxPoint::dist(self : GeobufferbboxPoint, other : GeobufferbboxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobufferbboxPoint::add(self : GeobufferbboxPoint, other : GeobufferbboxPoint) -> GeobufferbboxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobufferbboxPoint::sub(self : GeobufferbboxPoint, other : GeobufferbboxPoint) -> GeobufferbboxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobufferbboxPoint::scale(self : GeobufferbboxPoint, s : Double) -> GeobufferbboxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobufferbboxPoint::dot(self : GeobufferbboxPoint, other : GeobufferbboxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobufferbboxPoint::cross(self : GeobufferbboxPoint, other : GeobufferbboxPoint) -> GeobufferbboxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobufferbboxPoint::norm(self : GeobufferbboxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobufferbboxPoint::normalize(self : GeobufferbboxPoint) -> GeobufferbboxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferbboxPoint::negate(self : GeobufferbboxPoint) -> GeobufferbboxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobufferbboxPoint::mid(self : GeobufferbboxPoint, other : GeobufferbboxPoint) -> GeobufferbboxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobufferbboxPoint::lerp(self : GeobufferbboxPoint, other : GeobufferbboxPoint, t : Double) -> GeobufferbboxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobufferbboxPoint::to_string(self : GeobufferbboxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobufferbboxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_bbox_make_series(vals : Array[Double], name : String) -> GeobufferbboxSeries {
  { vals, name, meta: 0 }
}

pub fn GeobufferbboxSeries::len(self : GeobufferbboxSeries) -> Int { self.vals.length() }

pub fn GeobufferbboxSeries::sum(self : GeobufferbboxSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobufferbboxSeries::mean(self : GeobufferbboxSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobufferbboxSeries::min(self : GeobufferbboxSeries) -> Double { @_common.min(self.vals) }

pub fn GeobufferbboxSeries::max(self : GeobufferbboxSeries) -> Double { @_common.max(self.vals) }

pub fn GeobufferbboxSeries::range(self : GeobufferbboxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobufferbboxSeries::variance(self : GeobufferbboxSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobufferbboxSeries::std(self : GeobufferbboxSeries) -> Double { @_common.std(self.vals) }

pub fn GeobufferbboxSeries::median(self : GeobufferbboxSeries) -> Double { @_common.median(self.vals) }

pub fn GeobufferbboxSeries::scale(self : GeobufferbboxSeries, f : Double) -> GeobufferbboxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobufferbboxSeries::add(self : GeobufferbboxSeries, other : GeobufferbboxSeries) -> GeobufferbboxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobufferbboxSeries::sub(self : GeobufferbboxSeries, other : GeobufferbboxSeries) -> GeobufferbboxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobufferbboxSeries::normalize(self : GeobufferbboxSeries) -> GeobufferbboxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobufferbboxSeries::cumsum(self : GeobufferbboxSeries) -> GeobufferbboxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobufferbboxSeries::to_string(self : GeobufferbboxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferbboxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_bbox_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferbboxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_bbox_matrix_identity(n : Int) -> GeobufferbboxMatrix {
  let m = geo_buffer_bbox_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobufferbboxMatrix::get(self : GeobufferbboxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobufferbboxMatrix::transpose(self : GeobufferbboxMatrix) -> GeobufferbboxMatrix {
  let result = geo_buffer_bbox_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobufferbboxMatrix::add(self : GeobufferbboxMatrix, other : GeobufferbboxMatrix) -> GeobufferbboxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_bbox_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobufferbboxMatrix::scale(self : GeobufferbboxMatrix, s : Double) -> GeobufferbboxMatrix {
  let result = geo_buffer_bbox_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobufferbboxMatrix::multiply(self : GeobufferbboxMatrix, other : GeobufferbboxMatrix) -> GeobufferbboxMatrix {
  if self.cols != other.rows { return geo_buffer_bbox_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_bbox_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobufferbboxMatrix::trace(self : GeobufferbboxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobufferbboxMatrix::det(self : GeobufferbboxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobufferbboxMatrix::norm(self : GeobufferbboxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobufferbboxMatrix::to_string(self : GeobufferbboxMatrix) -> String {
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

pub(all) struct GeobufferbboxVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_bbox_make_vector(comps : Array[Double]) -> GeobufferbboxVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_bbox_vector_zero(dim : Int) -> GeobufferbboxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobufferbboxVector::add(self : GeobufferbboxVector, other : GeobufferbboxVector) -> GeobufferbboxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferbboxVector::sub(self : GeobufferbboxVector, other : GeobufferbboxVector) -> GeobufferbboxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferbboxVector::scale(self : GeobufferbboxVector, s : Double) -> GeobufferbboxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobufferbboxVector::dot(self : GeobufferbboxVector, other : GeobufferbboxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobufferbboxVector::norm(self : GeobufferbboxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobufferbboxVector::normalize(self : GeobufferbboxVector) -> GeobufferbboxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferbboxVector::dist(self : GeobufferbboxVector, other : GeobufferbboxVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobufferbboxVector::to_string(self : GeobufferbboxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferbboxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_frame_make(size : Int) -> GeobufferbboxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxFrame::len(self : GeobufferbboxFrame) -> Int { self.size }

pub fn GeobufferbboxFrame::get(self : GeobufferbboxFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxFrame::set(self : GeobufferbboxFrame, i : Int, v : Double) -> GeobufferbboxFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxFrame::sum(self : GeobufferbboxFrame) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxFrame::mean(self : GeobufferbboxFrame) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxFrame::scale(self : GeobufferbboxFrame, f : Double) -> GeobufferbboxFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxFrame::add(self : GeobufferbboxFrame, other : GeobufferbboxFrame) -> GeobufferbboxFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxFrame::copy(self : GeobufferbboxFrame) -> GeobufferbboxFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxFrame::fill(self : GeobufferbboxFrame, v : Double) -> GeobufferbboxFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxFrame::min(self : GeobufferbboxFrame) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxFrame::max(self : GeobufferbboxFrame) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxFrame::to_string(self : GeobufferbboxFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_table_make(size : Int) -> GeobufferbboxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxTable::len(self : GeobufferbboxTable) -> Int { self.size }

pub fn GeobufferbboxTable::get(self : GeobufferbboxTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxTable::set(self : GeobufferbboxTable, i : Int, v : Double) -> GeobufferbboxTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxTable::sum(self : GeobufferbboxTable) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxTable::mean(self : GeobufferbboxTable) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxTable::scale(self : GeobufferbboxTable, f : Double) -> GeobufferbboxTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxTable::add(self : GeobufferbboxTable, other : GeobufferbboxTable) -> GeobufferbboxTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxTable::copy(self : GeobufferbboxTable) -> GeobufferbboxTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxTable::fill(self : GeobufferbboxTable, v : Double) -> GeobufferbboxTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxTable::min(self : GeobufferbboxTable) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxTable::max(self : GeobufferbboxTable) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxTable::to_string(self : GeobufferbboxTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_graphn_make(size : Int) -> GeobufferbboxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxGraphN::len(self : GeobufferbboxGraphN) -> Int { self.size }

pub fn GeobufferbboxGraphN::get(self : GeobufferbboxGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxGraphN::set(self : GeobufferbboxGraphN, i : Int, v : Double) -> GeobufferbboxGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxGraphN::sum(self : GeobufferbboxGraphN) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxGraphN::mean(self : GeobufferbboxGraphN) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxGraphN::scale(self : GeobufferbboxGraphN, f : Double) -> GeobufferbboxGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxGraphN::add(self : GeobufferbboxGraphN, other : GeobufferbboxGraphN) -> GeobufferbboxGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxGraphN::copy(self : GeobufferbboxGraphN) -> GeobufferbboxGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxGraphN::fill(self : GeobufferbboxGraphN, v : Double) -> GeobufferbboxGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxGraphN::min(self : GeobufferbboxGraphN) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxGraphN::max(self : GeobufferbboxGraphN) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxGraphN::to_string(self : GeobufferbboxGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_node_make(size : Int) -> GeobufferbboxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxNode::len(self : GeobufferbboxNode) -> Int { self.size }

pub fn GeobufferbboxNode::get(self : GeobufferbboxNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxNode::set(self : GeobufferbboxNode, i : Int, v : Double) -> GeobufferbboxNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxNode::sum(self : GeobufferbboxNode) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxNode::mean(self : GeobufferbboxNode) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxNode::scale(self : GeobufferbboxNode, f : Double) -> GeobufferbboxNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxNode::add(self : GeobufferbboxNode, other : GeobufferbboxNode) -> GeobufferbboxNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxNode::copy(self : GeobufferbboxNode) -> GeobufferbboxNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxNode::fill(self : GeobufferbboxNode, v : Double) -> GeobufferbboxNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxNode::min(self : GeobufferbboxNode) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxNode::max(self : GeobufferbboxNode) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxNode::to_string(self : GeobufferbboxNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_edge_make(size : Int) -> GeobufferbboxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxEdge::len(self : GeobufferbboxEdge) -> Int { self.size }

pub fn GeobufferbboxEdge::get(self : GeobufferbboxEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxEdge::set(self : GeobufferbboxEdge, i : Int, v : Double) -> GeobufferbboxEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxEdge::sum(self : GeobufferbboxEdge) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxEdge::mean(self : GeobufferbboxEdge) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxEdge::scale(self : GeobufferbboxEdge, f : Double) -> GeobufferbboxEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxEdge::add(self : GeobufferbboxEdge, other : GeobufferbboxEdge) -> GeobufferbboxEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxEdge::copy(self : GeobufferbboxEdge) -> GeobufferbboxEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxEdge::fill(self : GeobufferbboxEdge, v : Double) -> GeobufferbboxEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxEdge::min(self : GeobufferbboxEdge) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxEdge::max(self : GeobufferbboxEdge) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxEdge::to_string(self : GeobufferbboxEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_path_make(size : Int) -> GeobufferbboxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxPath::len(self : GeobufferbboxPath) -> Int { self.size }

pub fn GeobufferbboxPath::get(self : GeobufferbboxPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxPath::set(self : GeobufferbboxPath, i : Int, v : Double) -> GeobufferbboxPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxPath::sum(self : GeobufferbboxPath) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxPath::mean(self : GeobufferbboxPath) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxPath::scale(self : GeobufferbboxPath, f : Double) -> GeobufferbboxPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxPath::add(self : GeobufferbboxPath, other : GeobufferbboxPath) -> GeobufferbboxPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxPath::copy(self : GeobufferbboxPath) -> GeobufferbboxPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxPath::fill(self : GeobufferbboxPath, v : Double) -> GeobufferbboxPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxPath::min(self : GeobufferbboxPath) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxPath::max(self : GeobufferbboxPath) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxPath::to_string(self : GeobufferbboxPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_cluster_make(size : Int) -> GeobufferbboxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxCluster::len(self : GeobufferbboxCluster) -> Int { self.size }

pub fn GeobufferbboxCluster::get(self : GeobufferbboxCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxCluster::set(self : GeobufferbboxCluster, i : Int, v : Double) -> GeobufferbboxCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxCluster::sum(self : GeobufferbboxCluster) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxCluster::mean(self : GeobufferbboxCluster) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxCluster::scale(self : GeobufferbboxCluster, f : Double) -> GeobufferbboxCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxCluster::add(self : GeobufferbboxCluster, other : GeobufferbboxCluster) -> GeobufferbboxCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxCluster::copy(self : GeobufferbboxCluster) -> GeobufferbboxCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxCluster::fill(self : GeobufferbboxCluster, v : Double) -> GeobufferbboxCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxCluster::min(self : GeobufferbboxCluster) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxCluster::max(self : GeobufferbboxCluster) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxCluster::to_string(self : GeobufferbboxCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_model_make(size : Int) -> GeobufferbboxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxModel::len(self : GeobufferbboxModel) -> Int { self.size }

pub fn GeobufferbboxModel::get(self : GeobufferbboxModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxModel::set(self : GeobufferbboxModel, i : Int, v : Double) -> GeobufferbboxModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxModel::sum(self : GeobufferbboxModel) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxModel::mean(self : GeobufferbboxModel) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxModel::scale(self : GeobufferbboxModel, f : Double) -> GeobufferbboxModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxModel::add(self : GeobufferbboxModel, other : GeobufferbboxModel) -> GeobufferbboxModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxModel::copy(self : GeobufferbboxModel) -> GeobufferbboxModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxModel::fill(self : GeobufferbboxModel, v : Double) -> GeobufferbboxModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxModel::min(self : GeobufferbboxModel) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxModel::max(self : GeobufferbboxModel) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxModel::to_string(self : GeobufferbboxModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_layer_make(size : Int) -> GeobufferbboxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxLayer::len(self : GeobufferbboxLayer) -> Int { self.size }

pub fn GeobufferbboxLayer::get(self : GeobufferbboxLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxLayer::set(self : GeobufferbboxLayer, i : Int, v : Double) -> GeobufferbboxLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxLayer::sum(self : GeobufferbboxLayer) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxLayer::mean(self : GeobufferbboxLayer) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxLayer::scale(self : GeobufferbboxLayer, f : Double) -> GeobufferbboxLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxLayer::add(self : GeobufferbboxLayer, other : GeobufferbboxLayer) -> GeobufferbboxLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxLayer::copy(self : GeobufferbboxLayer) -> GeobufferbboxLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxLayer::fill(self : GeobufferbboxLayer, v : Double) -> GeobufferbboxLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxLayer::min(self : GeobufferbboxLayer) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxLayer::max(self : GeobufferbboxLayer) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxLayer::to_string(self : GeobufferbboxLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_buffer_make(size : Int) -> GeobufferbboxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxBuffer::len(self : GeobufferbboxBuffer) -> Int { self.size }

pub fn GeobufferbboxBuffer::get(self : GeobufferbboxBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxBuffer::set(self : GeobufferbboxBuffer, i : Int, v : Double) -> GeobufferbboxBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxBuffer::sum(self : GeobufferbboxBuffer) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxBuffer::mean(self : GeobufferbboxBuffer) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxBuffer::scale(self : GeobufferbboxBuffer, f : Double) -> GeobufferbboxBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxBuffer::add(self : GeobufferbboxBuffer, other : GeobufferbboxBuffer) -> GeobufferbboxBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxBuffer::copy(self : GeobufferbboxBuffer) -> GeobufferbboxBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxBuffer::fill(self : GeobufferbboxBuffer, v : Double) -> GeobufferbboxBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxBuffer::min(self : GeobufferbboxBuffer) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxBuffer::max(self : GeobufferbboxBuffer) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxBuffer::to_string(self : GeobufferbboxBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_cursor_make(size : Int) -> GeobufferbboxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxCursor::len(self : GeobufferbboxCursor) -> Int { self.size }

pub fn GeobufferbboxCursor::get(self : GeobufferbboxCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxCursor::set(self : GeobufferbboxCursor, i : Int, v : Double) -> GeobufferbboxCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxCursor::sum(self : GeobufferbboxCursor) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxCursor::mean(self : GeobufferbboxCursor) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxCursor::scale(self : GeobufferbboxCursor, f : Double) -> GeobufferbboxCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxCursor::add(self : GeobufferbboxCursor, other : GeobufferbboxCursor) -> GeobufferbboxCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxCursor::copy(self : GeobufferbboxCursor) -> GeobufferbboxCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxCursor::fill(self : GeobufferbboxCursor, v : Double) -> GeobufferbboxCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxCursor::min(self : GeobufferbboxCursor) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxCursor::max(self : GeobufferbboxCursor) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxCursor::to_string(self : GeobufferbboxCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_view_make(size : Int) -> GeobufferbboxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxView::len(self : GeobufferbboxView) -> Int { self.size }

pub fn GeobufferbboxView::get(self : GeobufferbboxView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxView::set(self : GeobufferbboxView, i : Int, v : Double) -> GeobufferbboxView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxView::sum(self : GeobufferbboxView) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxView::mean(self : GeobufferbboxView) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxView::scale(self : GeobufferbboxView, f : Double) -> GeobufferbboxView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxView::add(self : GeobufferbboxView, other : GeobufferbboxView) -> GeobufferbboxView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxView::copy(self : GeobufferbboxView) -> GeobufferbboxView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxView::fill(self : GeobufferbboxView, v : Double) -> GeobufferbboxView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxView::min(self : GeobufferbboxView) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxView::max(self : GeobufferbboxView) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxView::to_string(self : GeobufferbboxView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_range_make(size : Int) -> GeobufferbboxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxRange::len(self : GeobufferbboxRange) -> Int { self.size }

pub fn GeobufferbboxRange::get(self : GeobufferbboxRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxRange::set(self : GeobufferbboxRange, i : Int, v : Double) -> GeobufferbboxRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxRange::sum(self : GeobufferbboxRange) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxRange::mean(self : GeobufferbboxRange) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxRange::scale(self : GeobufferbboxRange, f : Double) -> GeobufferbboxRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxRange::add(self : GeobufferbboxRange, other : GeobufferbboxRange) -> GeobufferbboxRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxRange::copy(self : GeobufferbboxRange) -> GeobufferbboxRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxRange::fill(self : GeobufferbboxRange, v : Double) -> GeobufferbboxRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxRange::min(self : GeobufferbboxRange) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxRange::max(self : GeobufferbboxRange) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxRange::to_string(self : GeobufferbboxRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_slice_make(size : Int) -> GeobufferbboxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobufferbboxSlice::len(self : GeobufferbboxSlice) -> Int { self.size }

pub fn GeobufferbboxSlice::get(self : GeobufferbboxSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobufferbboxSlice::set(self : GeobufferbboxSlice, i : Int, v : Double) -> GeobufferbboxSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobufferbboxSlice::sum(self : GeobufferbboxSlice) -> Double { @_common.sum(self.data) }

pub fn GeobufferbboxSlice::mean(self : GeobufferbboxSlice) -> Double { @_common.mean(self.data) }

pub fn GeobufferbboxSlice::scale(self : GeobufferbboxSlice, f : Double) -> GeobufferbboxSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxSlice::add(self : GeobufferbboxSlice, other : GeobufferbboxSlice) -> GeobufferbboxSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobufferbboxSlice::copy(self : GeobufferbboxSlice) -> GeobufferbboxSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxSlice::fill(self : GeobufferbboxSlice, v : Double) -> GeobufferbboxSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobufferbboxSlice::min(self : GeobufferbboxSlice) -> Double { @_common.min(self.data) }

pub fn GeobufferbboxSlice::max(self : GeobufferbboxSlice) -> Double { @_common.max(self.data) }

pub fn GeobufferbboxSlice::to_string(self : GeobufferbboxSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

