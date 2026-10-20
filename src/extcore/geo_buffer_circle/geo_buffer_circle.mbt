///===
/// extcore/geo_buffer_circle

pub(all) struct GeobuffercirclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_circle_make_point(x : Double, y : Double) -> GeobuffercirclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_circle_make_point3(x : Double, y : Double, z : Double) -> GeobuffercirclePoint {
  { x, y, z, label: 0 }
}

pub fn GeobuffercirclePoint::x(self : GeobuffercirclePoint) -> Double { self.x }

pub fn GeobuffercirclePoint::y(self : GeobuffercirclePoint) -> Double { self.y }

pub fn GeobuffercirclePoint::z(self : GeobuffercirclePoint) -> Double { self.z }

pub fn GeobuffercirclePoint::label(self : GeobuffercirclePoint) -> Int { self.label }

pub fn GeobuffercirclePoint::dist(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobuffercirclePoint::add(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> GeobuffercirclePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobuffercirclePoint::sub(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> GeobuffercirclePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobuffercirclePoint::scale(self : GeobuffercirclePoint, s : Double) -> GeobuffercirclePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobuffercirclePoint::dot(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobuffercirclePoint::cross(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> GeobuffercirclePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobuffercirclePoint::norm(self : GeobuffercirclePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobuffercirclePoint::normalize(self : GeobuffercirclePoint) -> GeobuffercirclePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffercirclePoint::negate(self : GeobuffercirclePoint) -> GeobuffercirclePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobuffercirclePoint::mid(self : GeobuffercirclePoint, other : GeobuffercirclePoint) -> GeobuffercirclePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobuffercirclePoint::lerp(self : GeobuffercirclePoint, other : GeobuffercirclePoint, t : Double) -> GeobuffercirclePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobuffercirclePoint::to_string(self : GeobuffercirclePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobuffercircleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_circle_make_series(vals : Array[Double], name : String) -> GeobuffercircleSeries {
  { vals, name, meta: 0 }
}

pub fn GeobuffercircleSeries::len(self : GeobuffercircleSeries) -> Int { self.vals.length() }

pub fn GeobuffercircleSeries::sum(self : GeobuffercircleSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobuffercircleSeries::mean(self : GeobuffercircleSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobuffercircleSeries::min(self : GeobuffercircleSeries) -> Double { @_common.min(self.vals) }

pub fn GeobuffercircleSeries::max(self : GeobuffercircleSeries) -> Double { @_common.max(self.vals) }

pub fn GeobuffercircleSeries::range(self : GeobuffercircleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobuffercircleSeries::variance(self : GeobuffercircleSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobuffercircleSeries::std(self : GeobuffercircleSeries) -> Double { @_common.std(self.vals) }

pub fn GeobuffercircleSeries::median(self : GeobuffercircleSeries) -> Double { @_common.median(self.vals) }

pub fn GeobuffercircleSeries::scale(self : GeobuffercircleSeries, f : Double) -> GeobuffercircleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobuffercircleSeries::add(self : GeobuffercircleSeries, other : GeobuffercircleSeries) -> GeobuffercircleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobuffercircleSeries::sub(self : GeobuffercircleSeries, other : GeobuffercircleSeries) -> GeobuffercircleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobuffercircleSeries::normalize(self : GeobuffercircleSeries) -> GeobuffercircleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobuffercircleSeries::cumsum(self : GeobuffercircleSeries) -> GeobuffercircleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobuffercircleSeries::to_string(self : GeobuffercircleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffercircleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_circle_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffercircleMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_buffer_circle_matrix_identity(n : Int) -> GeobuffercircleMatrix {
  let m = geo_buffer_circle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobuffercircleMatrix::get(self : GeobuffercircleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobuffercircleMatrix::transpose(self : GeobuffercircleMatrix) -> GeobuffercircleMatrix {
  let result = geo_buffer_circle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobuffercircleMatrix::add(self : GeobuffercircleMatrix, other : GeobuffercircleMatrix) -> GeobuffercircleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobuffercircleMatrix::scale(self : GeobuffercircleMatrix, s : Double) -> GeobuffercircleMatrix {
  let result = geo_buffer_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobuffercircleMatrix::multiply(self : GeobuffercircleMatrix, other : GeobuffercircleMatrix) -> GeobuffercircleMatrix {
  if self.cols != other.rows { return geo_buffer_circle_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_circle_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeobuffercircleMatrix::trace(self : GeobuffercircleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobuffercircleMatrix::det(self : GeobuffercircleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobuffercircleMatrix::norm(self : GeobuffercircleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobuffercircleMatrix::to_string(self : GeobuffercircleMatrix) -> String {
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

pub(all) struct GeobuffercircleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_circle_make_vector(comps : Array[Double]) -> GeobuffercircleVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_circle_vector_zero(dim : Int) -> GeobuffercircleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobuffercircleVector::add(self : GeobuffercircleVector, other : GeobuffercircleVector) -> GeobuffercircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffercircleVector::sub(self : GeobuffercircleVector, other : GeobuffercircleVector) -> GeobuffercircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffercircleVector::scale(self : GeobuffercircleVector, s : Double) -> GeobuffercircleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobuffercircleVector::dot(self : GeobuffercircleVector, other : GeobuffercircleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobuffercircleVector::norm(self : GeobuffercircleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobuffercircleVector::normalize(self : GeobuffercircleVector) -> GeobuffercircleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffercircleVector::dist(self : GeobuffercircleVector, other : GeobuffercircleVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobuffercircleVector::to_string(self : GeobuffercircleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffercircleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_frame_make(size : Int) -> GeobuffercircleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleFrame::len(self : GeobuffercircleFrame) -> Int { self.size }

pub fn GeobuffercircleFrame::get(self : GeobuffercircleFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleFrame::set(self : GeobuffercircleFrame, i : Int, v : Double) -> GeobuffercircleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleFrame::sum(self : GeobuffercircleFrame) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleFrame::mean(self : GeobuffercircleFrame) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleFrame::scale(self : GeobuffercircleFrame, f : Double) -> GeobuffercircleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleFrame::add(self : GeobuffercircleFrame, other : GeobuffercircleFrame) -> GeobuffercircleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleFrame::copy(self : GeobuffercircleFrame) -> GeobuffercircleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleFrame::fill(self : GeobuffercircleFrame, v : Double) -> GeobuffercircleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleFrame::min(self : GeobuffercircleFrame) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleFrame::max(self : GeobuffercircleFrame) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleFrame::to_string(self : GeobuffercircleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_table_make(size : Int) -> GeobuffercircleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleTable::len(self : GeobuffercircleTable) -> Int { self.size }

pub fn GeobuffercircleTable::get(self : GeobuffercircleTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleTable::set(self : GeobuffercircleTable, i : Int, v : Double) -> GeobuffercircleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleTable::sum(self : GeobuffercircleTable) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleTable::mean(self : GeobuffercircleTable) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleTable::scale(self : GeobuffercircleTable, f : Double) -> GeobuffercircleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleTable::add(self : GeobuffercircleTable, other : GeobuffercircleTable) -> GeobuffercircleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleTable::copy(self : GeobuffercircleTable) -> GeobuffercircleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleTable::fill(self : GeobuffercircleTable, v : Double) -> GeobuffercircleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleTable::min(self : GeobuffercircleTable) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleTable::max(self : GeobuffercircleTable) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleTable::to_string(self : GeobuffercircleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_graphn_make(size : Int) -> GeobuffercircleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleGraphN::len(self : GeobuffercircleGraphN) -> Int { self.size }

pub fn GeobuffercircleGraphN::get(self : GeobuffercircleGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleGraphN::set(self : GeobuffercircleGraphN, i : Int, v : Double) -> GeobuffercircleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleGraphN::sum(self : GeobuffercircleGraphN) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleGraphN::mean(self : GeobuffercircleGraphN) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleGraphN::scale(self : GeobuffercircleGraphN, f : Double) -> GeobuffercircleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleGraphN::add(self : GeobuffercircleGraphN, other : GeobuffercircleGraphN) -> GeobuffercircleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleGraphN::copy(self : GeobuffercircleGraphN) -> GeobuffercircleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleGraphN::fill(self : GeobuffercircleGraphN, v : Double) -> GeobuffercircleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleGraphN::min(self : GeobuffercircleGraphN) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleGraphN::max(self : GeobuffercircleGraphN) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleGraphN::to_string(self : GeobuffercircleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_node_make(size : Int) -> GeobuffercircleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleNode::len(self : GeobuffercircleNode) -> Int { self.size }

pub fn GeobuffercircleNode::get(self : GeobuffercircleNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleNode::set(self : GeobuffercircleNode, i : Int, v : Double) -> GeobuffercircleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleNode::sum(self : GeobuffercircleNode) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleNode::mean(self : GeobuffercircleNode) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleNode::scale(self : GeobuffercircleNode, f : Double) -> GeobuffercircleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleNode::add(self : GeobuffercircleNode, other : GeobuffercircleNode) -> GeobuffercircleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleNode::copy(self : GeobuffercircleNode) -> GeobuffercircleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleNode::fill(self : GeobuffercircleNode, v : Double) -> GeobuffercircleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleNode::min(self : GeobuffercircleNode) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleNode::max(self : GeobuffercircleNode) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleNode::to_string(self : GeobuffercircleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_edge_make(size : Int) -> GeobuffercircleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleEdge::len(self : GeobuffercircleEdge) -> Int { self.size }

pub fn GeobuffercircleEdge::get(self : GeobuffercircleEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleEdge::set(self : GeobuffercircleEdge, i : Int, v : Double) -> GeobuffercircleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleEdge::sum(self : GeobuffercircleEdge) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleEdge::mean(self : GeobuffercircleEdge) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleEdge::scale(self : GeobuffercircleEdge, f : Double) -> GeobuffercircleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleEdge::add(self : GeobuffercircleEdge, other : GeobuffercircleEdge) -> GeobuffercircleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleEdge::copy(self : GeobuffercircleEdge) -> GeobuffercircleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleEdge::fill(self : GeobuffercircleEdge, v : Double) -> GeobuffercircleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleEdge::min(self : GeobuffercircleEdge) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleEdge::max(self : GeobuffercircleEdge) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleEdge::to_string(self : GeobuffercircleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercirclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_path_make(size : Int) -> GeobuffercirclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercirclePath::len(self : GeobuffercirclePath) -> Int { self.size }

pub fn GeobuffercirclePath::get(self : GeobuffercirclePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercirclePath::set(self : GeobuffercirclePath, i : Int, v : Double) -> GeobuffercirclePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercirclePath::sum(self : GeobuffercirclePath) -> Double { @_common.sum(self.data) }

pub fn GeobuffercirclePath::mean(self : GeobuffercirclePath) -> Double { @_common.mean(self.data) }

pub fn GeobuffercirclePath::scale(self : GeobuffercirclePath, f : Double) -> GeobuffercirclePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercirclePath::add(self : GeobuffercirclePath, other : GeobuffercirclePath) -> GeobuffercirclePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercirclePath::copy(self : GeobuffercirclePath) -> GeobuffercirclePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercirclePath::fill(self : GeobuffercirclePath, v : Double) -> GeobuffercirclePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercirclePath::min(self : GeobuffercirclePath) -> Double { @_common.min(self.data) }

pub fn GeobuffercirclePath::max(self : GeobuffercirclePath) -> Double { @_common.max(self.data) }

pub fn GeobuffercirclePath::to_string(self : GeobuffercirclePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_cluster_make(size : Int) -> GeobuffercircleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleCluster::len(self : GeobuffercircleCluster) -> Int { self.size }

pub fn GeobuffercircleCluster::get(self : GeobuffercircleCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleCluster::set(self : GeobuffercircleCluster, i : Int, v : Double) -> GeobuffercircleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleCluster::sum(self : GeobuffercircleCluster) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleCluster::mean(self : GeobuffercircleCluster) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleCluster::scale(self : GeobuffercircleCluster, f : Double) -> GeobuffercircleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleCluster::add(self : GeobuffercircleCluster, other : GeobuffercircleCluster) -> GeobuffercircleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleCluster::copy(self : GeobuffercircleCluster) -> GeobuffercircleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleCluster::fill(self : GeobuffercircleCluster, v : Double) -> GeobuffercircleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleCluster::min(self : GeobuffercircleCluster) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleCluster::max(self : GeobuffercircleCluster) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleCluster::to_string(self : GeobuffercircleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_model_make(size : Int) -> GeobuffercircleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleModel::len(self : GeobuffercircleModel) -> Int { self.size }

pub fn GeobuffercircleModel::get(self : GeobuffercircleModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleModel::set(self : GeobuffercircleModel, i : Int, v : Double) -> GeobuffercircleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleModel::sum(self : GeobuffercircleModel) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleModel::mean(self : GeobuffercircleModel) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleModel::scale(self : GeobuffercircleModel, f : Double) -> GeobuffercircleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleModel::add(self : GeobuffercircleModel, other : GeobuffercircleModel) -> GeobuffercircleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleModel::copy(self : GeobuffercircleModel) -> GeobuffercircleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleModel::fill(self : GeobuffercircleModel, v : Double) -> GeobuffercircleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleModel::min(self : GeobuffercircleModel) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleModel::max(self : GeobuffercircleModel) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleModel::to_string(self : GeobuffercircleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_layer_make(size : Int) -> GeobuffercircleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleLayer::len(self : GeobuffercircleLayer) -> Int { self.size }

pub fn GeobuffercircleLayer::get(self : GeobuffercircleLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleLayer::set(self : GeobuffercircleLayer, i : Int, v : Double) -> GeobuffercircleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleLayer::sum(self : GeobuffercircleLayer) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleLayer::mean(self : GeobuffercircleLayer) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleLayer::scale(self : GeobuffercircleLayer, f : Double) -> GeobuffercircleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleLayer::add(self : GeobuffercircleLayer, other : GeobuffercircleLayer) -> GeobuffercircleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleLayer::copy(self : GeobuffercircleLayer) -> GeobuffercircleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleLayer::fill(self : GeobuffercircleLayer, v : Double) -> GeobuffercircleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleLayer::min(self : GeobuffercircleLayer) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleLayer::max(self : GeobuffercircleLayer) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleLayer::to_string(self : GeobuffercircleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_buffer_make(size : Int) -> GeobuffercircleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleBuffer::len(self : GeobuffercircleBuffer) -> Int { self.size }

pub fn GeobuffercircleBuffer::get(self : GeobuffercircleBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleBuffer::set(self : GeobuffercircleBuffer, i : Int, v : Double) -> GeobuffercircleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleBuffer::sum(self : GeobuffercircleBuffer) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleBuffer::mean(self : GeobuffercircleBuffer) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleBuffer::scale(self : GeobuffercircleBuffer, f : Double) -> GeobuffercircleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleBuffer::add(self : GeobuffercircleBuffer, other : GeobuffercircleBuffer) -> GeobuffercircleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleBuffer::copy(self : GeobuffercircleBuffer) -> GeobuffercircleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleBuffer::fill(self : GeobuffercircleBuffer, v : Double) -> GeobuffercircleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleBuffer::min(self : GeobuffercircleBuffer) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleBuffer::max(self : GeobuffercircleBuffer) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleBuffer::to_string(self : GeobuffercircleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_cursor_make(size : Int) -> GeobuffercircleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleCursor::len(self : GeobuffercircleCursor) -> Int { self.size }

pub fn GeobuffercircleCursor::get(self : GeobuffercircleCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleCursor::set(self : GeobuffercircleCursor, i : Int, v : Double) -> GeobuffercircleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleCursor::sum(self : GeobuffercircleCursor) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleCursor::mean(self : GeobuffercircleCursor) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleCursor::scale(self : GeobuffercircleCursor, f : Double) -> GeobuffercircleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleCursor::add(self : GeobuffercircleCursor, other : GeobuffercircleCursor) -> GeobuffercircleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleCursor::copy(self : GeobuffercircleCursor) -> GeobuffercircleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleCursor::fill(self : GeobuffercircleCursor, v : Double) -> GeobuffercircleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleCursor::min(self : GeobuffercircleCursor) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleCursor::max(self : GeobuffercircleCursor) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleCursor::to_string(self : GeobuffercircleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_view_make(size : Int) -> GeobuffercircleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleView::len(self : GeobuffercircleView) -> Int { self.size }

pub fn GeobuffercircleView::get(self : GeobuffercircleView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleView::set(self : GeobuffercircleView, i : Int, v : Double) -> GeobuffercircleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleView::sum(self : GeobuffercircleView) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleView::mean(self : GeobuffercircleView) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleView::scale(self : GeobuffercircleView, f : Double) -> GeobuffercircleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleView::add(self : GeobuffercircleView, other : GeobuffercircleView) -> GeobuffercircleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleView::copy(self : GeobuffercircleView) -> GeobuffercircleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleView::fill(self : GeobuffercircleView, v : Double) -> GeobuffercircleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleView::min(self : GeobuffercircleView) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleView::max(self : GeobuffercircleView) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleView::to_string(self : GeobuffercircleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_range_make(size : Int) -> GeobuffercircleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleRange::len(self : GeobuffercircleRange) -> Int { self.size }

pub fn GeobuffercircleRange::get(self : GeobuffercircleRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleRange::set(self : GeobuffercircleRange, i : Int, v : Double) -> GeobuffercircleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleRange::sum(self : GeobuffercircleRange) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleRange::mean(self : GeobuffercircleRange) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleRange::scale(self : GeobuffercircleRange, f : Double) -> GeobuffercircleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleRange::add(self : GeobuffercircleRange, other : GeobuffercircleRange) -> GeobuffercircleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleRange::copy(self : GeobuffercircleRange) -> GeobuffercircleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleRange::fill(self : GeobuffercircleRange, v : Double) -> GeobuffercircleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleRange::min(self : GeobuffercircleRange) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleRange::max(self : GeobuffercircleRange) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleRange::to_string(self : GeobuffercircleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffercircleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_circle_slice_make(size : Int) -> GeobuffercircleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffercircleSlice::len(self : GeobuffercircleSlice) -> Int { self.size }

pub fn GeobuffercircleSlice::get(self : GeobuffercircleSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffercircleSlice::set(self : GeobuffercircleSlice, i : Int, v : Double) -> GeobuffercircleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffercircleSlice::sum(self : GeobuffercircleSlice) -> Double { @_common.sum(self.data) }

pub fn GeobuffercircleSlice::mean(self : GeobuffercircleSlice) -> Double { @_common.mean(self.data) }

pub fn GeobuffercircleSlice::scale(self : GeobuffercircleSlice, f : Double) -> GeobuffercircleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleSlice::add(self : GeobuffercircleSlice, other : GeobuffercircleSlice) -> GeobuffercircleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffercircleSlice::copy(self : GeobuffercircleSlice) -> GeobuffercircleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleSlice::fill(self : GeobuffercircleSlice, v : Double) -> GeobuffercircleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffercircleSlice::min(self : GeobuffercircleSlice) -> Double { @_common.min(self.data) }

pub fn GeobuffercircleSlice::max(self : GeobuffercircleSlice) -> Double { @_common.max(self.data) }

pub fn GeobuffercircleSlice::to_string(self : GeobuffercircleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

