///===
/// extcore/geo_intersect_circle

pub(all) struct GeointersectcirclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_circle_make_point(x : Double, y : Double) -> GeointersectcirclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_circle_make_point3(x : Double, y : Double, z : Double) -> GeointersectcirclePoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectcirclePoint::x(self : GeointersectcirclePoint) -> Double { self.x }

pub fn GeointersectcirclePoint::y(self : GeointersectcirclePoint) -> Double { self.y }

pub fn GeointersectcirclePoint::z(self : GeointersectcirclePoint) -> Double { self.z }

pub fn GeointersectcirclePoint::label(self : GeointersectcirclePoint) -> Int { self.label }

pub fn GeointersectcirclePoint::dist(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectcirclePoint::add(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectcirclePoint::sub(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectcirclePoint::scale(self : GeointersectcirclePoint, s : Double) -> GeointersectcirclePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectcirclePoint::dot(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectcirclePoint::cross(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectcirclePoint::norm(self : GeointersectcirclePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectcirclePoint::normalize(self : GeointersectcirclePoint) -> GeointersectcirclePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectcirclePoint::negate(self : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectcirclePoint::mid(self : GeointersectcirclePoint, other : GeointersectcirclePoint) -> GeointersectcirclePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectcirclePoint::lerp(self : GeointersectcirclePoint, other : GeointersectcirclePoint, t : Double) -> GeointersectcirclePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectcirclePoint::to_string(self : GeointersectcirclePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectcircleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_circle_make_series(vals : Array[Double], name : String) -> GeointersectcircleSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectcircleSeries::len(self : GeointersectcircleSeries) -> Int { self.vals.length() }

pub fn GeointersectcircleSeries::sum(self : GeointersectcircleSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectcircleSeries::mean(self : GeointersectcircleSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectcircleSeries::min(self : GeointersectcircleSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectcircleSeries::max(self : GeointersectcircleSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectcircleSeries::range(self : GeointersectcircleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectcircleSeries::variance(self : GeointersectcircleSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectcircleSeries::std(self : GeointersectcircleSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectcircleSeries::median(self : GeointersectcircleSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectcircleSeries::scale(self : GeointersectcircleSeries, f : Double) -> GeointersectcircleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectcircleSeries::add(self : GeointersectcircleSeries, other : GeointersectcircleSeries) -> GeointersectcircleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectcircleSeries::sub(self : GeointersectcircleSeries, other : GeointersectcircleSeries) -> GeointersectcircleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectcircleSeries::normalize(self : GeointersectcircleSeries) -> GeointersectcircleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectcircleSeries::cumsum(self : GeointersectcircleSeries) -> GeointersectcircleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectcircleSeries::to_string(self : GeointersectcircleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectcircleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_circle_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectcircleMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_intersect_circle_matrix_identity(n : Int) -> GeointersectcircleMatrix {
  let m = geo_intersect_circle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectcircleMatrix::get(self : GeointersectcircleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectcircleMatrix::transpose(self : GeointersectcircleMatrix) -> GeointersectcircleMatrix {
  let result = geo_intersect_circle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectcircleMatrix::add(self : GeointersectcircleMatrix, other : GeointersectcircleMatrix) -> GeointersectcircleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectcircleMatrix::scale(self : GeointersectcircleMatrix, s : Double) -> GeointersectcircleMatrix {
  let result = geo_intersect_circle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectcircleMatrix::multiply(self : GeointersectcircleMatrix, other : GeointersectcircleMatrix) -> GeointersectcircleMatrix {
  if self.cols != other.rows { return geo_intersect_circle_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_circle_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeointersectcircleMatrix::trace(self : GeointersectcircleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectcircleMatrix::det(self : GeointersectcircleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectcircleMatrix::norm(self : GeointersectcircleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectcircleMatrix::to_string(self : GeointersectcircleMatrix) -> String {
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

pub(all) struct GeointersectcircleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_circle_make_vector(comps : Array[Double]) -> GeointersectcircleVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_circle_vector_zero(dim : Int) -> GeointersectcircleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectcircleVector::add(self : GeointersectcircleVector, other : GeointersectcircleVector) -> GeointersectcircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectcircleVector::sub(self : GeointersectcircleVector, other : GeointersectcircleVector) -> GeointersectcircleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectcircleVector::scale(self : GeointersectcircleVector, s : Double) -> GeointersectcircleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectcircleVector::dot(self : GeointersectcircleVector, other : GeointersectcircleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectcircleVector::norm(self : GeointersectcircleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectcircleVector::normalize(self : GeointersectcircleVector) -> GeointersectcircleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectcircleVector::dist(self : GeointersectcircleVector, other : GeointersectcircleVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectcircleVector::to_string(self : GeointersectcircleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectcircleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_frame_make(size : Int) -> GeointersectcircleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleFrame::len(self : GeointersectcircleFrame) -> Int { self.size }

pub fn GeointersectcircleFrame::get(self : GeointersectcircleFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleFrame::set(self : GeointersectcircleFrame, i : Int, v : Double) -> GeointersectcircleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleFrame::sum(self : GeointersectcircleFrame) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleFrame::mean(self : GeointersectcircleFrame) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleFrame::scale(self : GeointersectcircleFrame, f : Double) -> GeointersectcircleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleFrame::add(self : GeointersectcircleFrame, other : GeointersectcircleFrame) -> GeointersectcircleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleFrame::copy(self : GeointersectcircleFrame) -> GeointersectcircleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleFrame::fill(self : GeointersectcircleFrame, v : Double) -> GeointersectcircleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleFrame::min(self : GeointersectcircleFrame) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleFrame::max(self : GeointersectcircleFrame) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleFrame::to_string(self : GeointersectcircleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_table_make(size : Int) -> GeointersectcircleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleTable::len(self : GeointersectcircleTable) -> Int { self.size }

pub fn GeointersectcircleTable::get(self : GeointersectcircleTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleTable::set(self : GeointersectcircleTable, i : Int, v : Double) -> GeointersectcircleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleTable::sum(self : GeointersectcircleTable) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleTable::mean(self : GeointersectcircleTable) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleTable::scale(self : GeointersectcircleTable, f : Double) -> GeointersectcircleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleTable::add(self : GeointersectcircleTable, other : GeointersectcircleTable) -> GeointersectcircleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleTable::copy(self : GeointersectcircleTable) -> GeointersectcircleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleTable::fill(self : GeointersectcircleTable, v : Double) -> GeointersectcircleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleTable::min(self : GeointersectcircleTable) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleTable::max(self : GeointersectcircleTable) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleTable::to_string(self : GeointersectcircleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_graphn_make(size : Int) -> GeointersectcircleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleGraphN::len(self : GeointersectcircleGraphN) -> Int { self.size }

pub fn GeointersectcircleGraphN::get(self : GeointersectcircleGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleGraphN::set(self : GeointersectcircleGraphN, i : Int, v : Double) -> GeointersectcircleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleGraphN::sum(self : GeointersectcircleGraphN) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleGraphN::mean(self : GeointersectcircleGraphN) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleGraphN::scale(self : GeointersectcircleGraphN, f : Double) -> GeointersectcircleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleGraphN::add(self : GeointersectcircleGraphN, other : GeointersectcircleGraphN) -> GeointersectcircleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleGraphN::copy(self : GeointersectcircleGraphN) -> GeointersectcircleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleGraphN::fill(self : GeointersectcircleGraphN, v : Double) -> GeointersectcircleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleGraphN::min(self : GeointersectcircleGraphN) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleGraphN::max(self : GeointersectcircleGraphN) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleGraphN::to_string(self : GeointersectcircleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_node_make(size : Int) -> GeointersectcircleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleNode::len(self : GeointersectcircleNode) -> Int { self.size }

pub fn GeointersectcircleNode::get(self : GeointersectcircleNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleNode::set(self : GeointersectcircleNode, i : Int, v : Double) -> GeointersectcircleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleNode::sum(self : GeointersectcircleNode) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleNode::mean(self : GeointersectcircleNode) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleNode::scale(self : GeointersectcircleNode, f : Double) -> GeointersectcircleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleNode::add(self : GeointersectcircleNode, other : GeointersectcircleNode) -> GeointersectcircleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleNode::copy(self : GeointersectcircleNode) -> GeointersectcircleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleNode::fill(self : GeointersectcircleNode, v : Double) -> GeointersectcircleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleNode::min(self : GeointersectcircleNode) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleNode::max(self : GeointersectcircleNode) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleNode::to_string(self : GeointersectcircleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_edge_make(size : Int) -> GeointersectcircleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleEdge::len(self : GeointersectcircleEdge) -> Int { self.size }

pub fn GeointersectcircleEdge::get(self : GeointersectcircleEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleEdge::set(self : GeointersectcircleEdge, i : Int, v : Double) -> GeointersectcircleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleEdge::sum(self : GeointersectcircleEdge) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleEdge::mean(self : GeointersectcircleEdge) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleEdge::scale(self : GeointersectcircleEdge, f : Double) -> GeointersectcircleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleEdge::add(self : GeointersectcircleEdge, other : GeointersectcircleEdge) -> GeointersectcircleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleEdge::copy(self : GeointersectcircleEdge) -> GeointersectcircleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleEdge::fill(self : GeointersectcircleEdge, v : Double) -> GeointersectcircleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleEdge::min(self : GeointersectcircleEdge) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleEdge::max(self : GeointersectcircleEdge) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleEdge::to_string(self : GeointersectcircleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcirclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_path_make(size : Int) -> GeointersectcirclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcirclePath::len(self : GeointersectcirclePath) -> Int { self.size }

pub fn GeointersectcirclePath::get(self : GeointersectcirclePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcirclePath::set(self : GeointersectcirclePath, i : Int, v : Double) -> GeointersectcirclePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcirclePath::sum(self : GeointersectcirclePath) -> Double { @_common.sum(self.data) }

pub fn GeointersectcirclePath::mean(self : GeointersectcirclePath) -> Double { @_common.mean(self.data) }

pub fn GeointersectcirclePath::scale(self : GeointersectcirclePath, f : Double) -> GeointersectcirclePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcirclePath::add(self : GeointersectcirclePath, other : GeointersectcirclePath) -> GeointersectcirclePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcirclePath::copy(self : GeointersectcirclePath) -> GeointersectcirclePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcirclePath::fill(self : GeointersectcirclePath, v : Double) -> GeointersectcirclePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcirclePath::min(self : GeointersectcirclePath) -> Double { @_common.min(self.data) }

pub fn GeointersectcirclePath::max(self : GeointersectcirclePath) -> Double { @_common.max(self.data) }

pub fn GeointersectcirclePath::to_string(self : GeointersectcirclePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_cluster_make(size : Int) -> GeointersectcircleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleCluster::len(self : GeointersectcircleCluster) -> Int { self.size }

pub fn GeointersectcircleCluster::get(self : GeointersectcircleCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleCluster::set(self : GeointersectcircleCluster, i : Int, v : Double) -> GeointersectcircleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleCluster::sum(self : GeointersectcircleCluster) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleCluster::mean(self : GeointersectcircleCluster) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleCluster::scale(self : GeointersectcircleCluster, f : Double) -> GeointersectcircleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleCluster::add(self : GeointersectcircleCluster, other : GeointersectcircleCluster) -> GeointersectcircleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleCluster::copy(self : GeointersectcircleCluster) -> GeointersectcircleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleCluster::fill(self : GeointersectcircleCluster, v : Double) -> GeointersectcircleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleCluster::min(self : GeointersectcircleCluster) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleCluster::max(self : GeointersectcircleCluster) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleCluster::to_string(self : GeointersectcircleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_model_make(size : Int) -> GeointersectcircleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleModel::len(self : GeointersectcircleModel) -> Int { self.size }

pub fn GeointersectcircleModel::get(self : GeointersectcircleModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleModel::set(self : GeointersectcircleModel, i : Int, v : Double) -> GeointersectcircleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleModel::sum(self : GeointersectcircleModel) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleModel::mean(self : GeointersectcircleModel) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleModel::scale(self : GeointersectcircleModel, f : Double) -> GeointersectcircleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleModel::add(self : GeointersectcircleModel, other : GeointersectcircleModel) -> GeointersectcircleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleModel::copy(self : GeointersectcircleModel) -> GeointersectcircleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleModel::fill(self : GeointersectcircleModel, v : Double) -> GeointersectcircleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleModel::min(self : GeointersectcircleModel) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleModel::max(self : GeointersectcircleModel) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleModel::to_string(self : GeointersectcircleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_layer_make(size : Int) -> GeointersectcircleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleLayer::len(self : GeointersectcircleLayer) -> Int { self.size }

pub fn GeointersectcircleLayer::get(self : GeointersectcircleLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleLayer::set(self : GeointersectcircleLayer, i : Int, v : Double) -> GeointersectcircleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleLayer::sum(self : GeointersectcircleLayer) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleLayer::mean(self : GeointersectcircleLayer) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleLayer::scale(self : GeointersectcircleLayer, f : Double) -> GeointersectcircleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleLayer::add(self : GeointersectcircleLayer, other : GeointersectcircleLayer) -> GeointersectcircleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleLayer::copy(self : GeointersectcircleLayer) -> GeointersectcircleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleLayer::fill(self : GeointersectcircleLayer, v : Double) -> GeointersectcircleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleLayer::min(self : GeointersectcircleLayer) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleLayer::max(self : GeointersectcircleLayer) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleLayer::to_string(self : GeointersectcircleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_buffer_make(size : Int) -> GeointersectcircleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleBuffer::len(self : GeointersectcircleBuffer) -> Int { self.size }

pub fn GeointersectcircleBuffer::get(self : GeointersectcircleBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleBuffer::set(self : GeointersectcircleBuffer, i : Int, v : Double) -> GeointersectcircleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleBuffer::sum(self : GeointersectcircleBuffer) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleBuffer::mean(self : GeointersectcircleBuffer) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleBuffer::scale(self : GeointersectcircleBuffer, f : Double) -> GeointersectcircleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleBuffer::add(self : GeointersectcircleBuffer, other : GeointersectcircleBuffer) -> GeointersectcircleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleBuffer::copy(self : GeointersectcircleBuffer) -> GeointersectcircleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleBuffer::fill(self : GeointersectcircleBuffer, v : Double) -> GeointersectcircleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleBuffer::min(self : GeointersectcircleBuffer) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleBuffer::max(self : GeointersectcircleBuffer) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleBuffer::to_string(self : GeointersectcircleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_cursor_make(size : Int) -> GeointersectcircleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleCursor::len(self : GeointersectcircleCursor) -> Int { self.size }

pub fn GeointersectcircleCursor::get(self : GeointersectcircleCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleCursor::set(self : GeointersectcircleCursor, i : Int, v : Double) -> GeointersectcircleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleCursor::sum(self : GeointersectcircleCursor) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleCursor::mean(self : GeointersectcircleCursor) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleCursor::scale(self : GeointersectcircleCursor, f : Double) -> GeointersectcircleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleCursor::add(self : GeointersectcircleCursor, other : GeointersectcircleCursor) -> GeointersectcircleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleCursor::copy(self : GeointersectcircleCursor) -> GeointersectcircleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleCursor::fill(self : GeointersectcircleCursor, v : Double) -> GeointersectcircleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleCursor::min(self : GeointersectcircleCursor) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleCursor::max(self : GeointersectcircleCursor) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleCursor::to_string(self : GeointersectcircleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_view_make(size : Int) -> GeointersectcircleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleView::len(self : GeointersectcircleView) -> Int { self.size }

pub fn GeointersectcircleView::get(self : GeointersectcircleView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleView::set(self : GeointersectcircleView, i : Int, v : Double) -> GeointersectcircleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleView::sum(self : GeointersectcircleView) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleView::mean(self : GeointersectcircleView) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleView::scale(self : GeointersectcircleView, f : Double) -> GeointersectcircleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleView::add(self : GeointersectcircleView, other : GeointersectcircleView) -> GeointersectcircleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleView::copy(self : GeointersectcircleView) -> GeointersectcircleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleView::fill(self : GeointersectcircleView, v : Double) -> GeointersectcircleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleView::min(self : GeointersectcircleView) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleView::max(self : GeointersectcircleView) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleView::to_string(self : GeointersectcircleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_range_make(size : Int) -> GeointersectcircleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleRange::len(self : GeointersectcircleRange) -> Int { self.size }

pub fn GeointersectcircleRange::get(self : GeointersectcircleRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleRange::set(self : GeointersectcircleRange, i : Int, v : Double) -> GeointersectcircleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleRange::sum(self : GeointersectcircleRange) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleRange::mean(self : GeointersectcircleRange) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleRange::scale(self : GeointersectcircleRange, f : Double) -> GeointersectcircleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleRange::add(self : GeointersectcircleRange, other : GeointersectcircleRange) -> GeointersectcircleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleRange::copy(self : GeointersectcircleRange) -> GeointersectcircleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleRange::fill(self : GeointersectcircleRange, v : Double) -> GeointersectcircleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleRange::min(self : GeointersectcircleRange) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleRange::max(self : GeointersectcircleRange) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleRange::to_string(self : GeointersectcircleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeointersectcircleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_circle_slice_make(size : Int) -> GeointersectcircleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeointersectcircleSlice::len(self : GeointersectcircleSlice) -> Int { self.size }

pub fn GeointersectcircleSlice::get(self : GeointersectcircleSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeointersectcircleSlice::set(self : GeointersectcircleSlice, i : Int, v : Double) -> GeointersectcircleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeointersectcircleSlice::sum(self : GeointersectcircleSlice) -> Double { @_common.sum(self.data) }

pub fn GeointersectcircleSlice::mean(self : GeointersectcircleSlice) -> Double { @_common.mean(self.data) }

pub fn GeointersectcircleSlice::scale(self : GeointersectcircleSlice, f : Double) -> GeointersectcircleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleSlice::add(self : GeointersectcircleSlice, other : GeointersectcircleSlice) -> GeointersectcircleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeointersectcircleSlice::copy(self : GeointersectcircleSlice) -> GeointersectcircleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleSlice::fill(self : GeointersectcircleSlice, v : Double) -> GeointersectcircleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeointersectcircleSlice::min(self : GeointersectcircleSlice) -> Double { @_common.min(self.data) }

pub fn GeointersectcircleSlice::max(self : GeointersectcircleSlice) -> Double { @_common.max(self.data) }

pub fn GeointersectcircleSlice::to_string(self : GeointersectcircleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

