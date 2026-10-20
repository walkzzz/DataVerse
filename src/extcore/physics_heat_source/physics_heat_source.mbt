///===
/// extcore/physics_heat_source

pub(all) struct PhysicsheatsourcePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_source_make_point(x : Double, y : Double) -> PhysicsheatsourcePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_source_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatsourcePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatsourcePoint::x(self : PhysicsheatsourcePoint) -> Double { self.x }

pub fn PhysicsheatsourcePoint::y(self : PhysicsheatsourcePoint) -> Double { self.y }

pub fn PhysicsheatsourcePoint::z(self : PhysicsheatsourcePoint) -> Double { self.z }

pub fn PhysicsheatsourcePoint::label(self : PhysicsheatsourcePoint) -> Int { self.label }

pub fn PhysicsheatsourcePoint::dist(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatsourcePoint::add(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatsourcePoint::sub(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatsourcePoint::scale(self : PhysicsheatsourcePoint, s : Double) -> PhysicsheatsourcePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatsourcePoint::dot(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatsourcePoint::cross(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatsourcePoint::norm(self : PhysicsheatsourcePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatsourcePoint::normalize(self : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatsourcePoint::negate(self : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatsourcePoint::mid(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatsourcePoint::lerp(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint, t : Double) -> PhysicsheatsourcePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatsourcePoint::to_string(self : PhysicsheatsourcePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatsourceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_source_make_series(vals : Array[Double], name : String) -> PhysicsheatsourceSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatsourceSeries::len(self : PhysicsheatsourceSeries) -> Int { self.vals.length() }

pub fn PhysicsheatsourceSeries::sum(self : PhysicsheatsourceSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatsourceSeries::mean(self : PhysicsheatsourceSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatsourceSeries::min(self : PhysicsheatsourceSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatsourceSeries::max(self : PhysicsheatsourceSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatsourceSeries::range(self : PhysicsheatsourceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatsourceSeries::variance(self : PhysicsheatsourceSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatsourceSeries::std(self : PhysicsheatsourceSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatsourceSeries::median(self : PhysicsheatsourceSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatsourceSeries::scale(self : PhysicsheatsourceSeries, f : Double) -> PhysicsheatsourceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatsourceSeries::add(self : PhysicsheatsourceSeries, other : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatsourceSeries::sub(self : PhysicsheatsourceSeries, other : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatsourceSeries::normalize(self : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatsourceSeries::cumsum(self : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatsourceSeries::to_string(self : PhysicsheatsourceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatsourceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_source_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatsourceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_source_matrix_identity(n : Int) -> PhysicsheatsourceMatrix {
  let m = physics_heat_source_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatsourceMatrix::get(self : PhysicsheatsourceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatsourceMatrix::transpose(self : PhysicsheatsourceMatrix) -> PhysicsheatsourceMatrix {
  let result = physics_heat_source_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatsourceMatrix::add(self : PhysicsheatsourceMatrix, other : PhysicsheatsourceMatrix) -> PhysicsheatsourceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_source_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatsourceMatrix::scale(self : PhysicsheatsourceMatrix, s : Double) -> PhysicsheatsourceMatrix {
  let result = physics_heat_source_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatsourceMatrix::multiply(self : PhysicsheatsourceMatrix, other : PhysicsheatsourceMatrix) -> PhysicsheatsourceMatrix {
  if self.cols != other.rows { return physics_heat_source_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_source_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsheatsourceMatrix::trace(self : PhysicsheatsourceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatsourceMatrix::det(self : PhysicsheatsourceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatsourceMatrix::norm(self : PhysicsheatsourceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatsourceMatrix::to_string(self : PhysicsheatsourceMatrix) -> String {
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

pub(all) struct PhysicsheatsourceVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_source_make_vector(comps : Array[Double]) -> PhysicsheatsourceVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_source_vector_zero(dim : Int) -> PhysicsheatsourceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatsourceVector::add(self : PhysicsheatsourceVector, other : PhysicsheatsourceVector) -> PhysicsheatsourceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatsourceVector::sub(self : PhysicsheatsourceVector, other : PhysicsheatsourceVector) -> PhysicsheatsourceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatsourceVector::scale(self : PhysicsheatsourceVector, s : Double) -> PhysicsheatsourceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatsourceVector::dot(self : PhysicsheatsourceVector, other : PhysicsheatsourceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatsourceVector::norm(self : PhysicsheatsourceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatsourceVector::normalize(self : PhysicsheatsourceVector) -> PhysicsheatsourceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatsourceVector::dist(self : PhysicsheatsourceVector, other : PhysicsheatsourceVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatsourceVector::to_string(self : PhysicsheatsourceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatsourceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_frame_make(size : Int) -> PhysicsheatsourceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceFrame::len(self : PhysicsheatsourceFrame) -> Int { self.size }

pub fn PhysicsheatsourceFrame::get(self : PhysicsheatsourceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceFrame::set(self : PhysicsheatsourceFrame, i : Int, v : Double) -> PhysicsheatsourceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceFrame::sum(self : PhysicsheatsourceFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceFrame::mean(self : PhysicsheatsourceFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceFrame::scale(self : PhysicsheatsourceFrame, f : Double) -> PhysicsheatsourceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceFrame::add(self : PhysicsheatsourceFrame, other : PhysicsheatsourceFrame) -> PhysicsheatsourceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceFrame::copy(self : PhysicsheatsourceFrame) -> PhysicsheatsourceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceFrame::fill(self : PhysicsheatsourceFrame, v : Double) -> PhysicsheatsourceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceFrame::min(self : PhysicsheatsourceFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceFrame::max(self : PhysicsheatsourceFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceFrame::to_string(self : PhysicsheatsourceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_table_make(size : Int) -> PhysicsheatsourceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceTable::len(self : PhysicsheatsourceTable) -> Int { self.size }

pub fn PhysicsheatsourceTable::get(self : PhysicsheatsourceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceTable::set(self : PhysicsheatsourceTable, i : Int, v : Double) -> PhysicsheatsourceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceTable::sum(self : PhysicsheatsourceTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceTable::mean(self : PhysicsheatsourceTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceTable::scale(self : PhysicsheatsourceTable, f : Double) -> PhysicsheatsourceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceTable::add(self : PhysicsheatsourceTable, other : PhysicsheatsourceTable) -> PhysicsheatsourceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceTable::copy(self : PhysicsheatsourceTable) -> PhysicsheatsourceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceTable::fill(self : PhysicsheatsourceTable, v : Double) -> PhysicsheatsourceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceTable::min(self : PhysicsheatsourceTable) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceTable::max(self : PhysicsheatsourceTable) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceTable::to_string(self : PhysicsheatsourceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_graphn_make(size : Int) -> PhysicsheatsourceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceGraphN::len(self : PhysicsheatsourceGraphN) -> Int { self.size }

pub fn PhysicsheatsourceGraphN::get(self : PhysicsheatsourceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceGraphN::set(self : PhysicsheatsourceGraphN, i : Int, v : Double) -> PhysicsheatsourceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceGraphN::sum(self : PhysicsheatsourceGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceGraphN::mean(self : PhysicsheatsourceGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceGraphN::scale(self : PhysicsheatsourceGraphN, f : Double) -> PhysicsheatsourceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceGraphN::add(self : PhysicsheatsourceGraphN, other : PhysicsheatsourceGraphN) -> PhysicsheatsourceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceGraphN::copy(self : PhysicsheatsourceGraphN) -> PhysicsheatsourceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceGraphN::fill(self : PhysicsheatsourceGraphN, v : Double) -> PhysicsheatsourceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceGraphN::min(self : PhysicsheatsourceGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceGraphN::max(self : PhysicsheatsourceGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceGraphN::to_string(self : PhysicsheatsourceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_node_make(size : Int) -> PhysicsheatsourceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceNode::len(self : PhysicsheatsourceNode) -> Int { self.size }

pub fn PhysicsheatsourceNode::get(self : PhysicsheatsourceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceNode::set(self : PhysicsheatsourceNode, i : Int, v : Double) -> PhysicsheatsourceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceNode::sum(self : PhysicsheatsourceNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceNode::mean(self : PhysicsheatsourceNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceNode::scale(self : PhysicsheatsourceNode, f : Double) -> PhysicsheatsourceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceNode::add(self : PhysicsheatsourceNode, other : PhysicsheatsourceNode) -> PhysicsheatsourceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceNode::copy(self : PhysicsheatsourceNode) -> PhysicsheatsourceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceNode::fill(self : PhysicsheatsourceNode, v : Double) -> PhysicsheatsourceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceNode::min(self : PhysicsheatsourceNode) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceNode::max(self : PhysicsheatsourceNode) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceNode::to_string(self : PhysicsheatsourceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_edge_make(size : Int) -> PhysicsheatsourceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceEdge::len(self : PhysicsheatsourceEdge) -> Int { self.size }

pub fn PhysicsheatsourceEdge::get(self : PhysicsheatsourceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceEdge::set(self : PhysicsheatsourceEdge, i : Int, v : Double) -> PhysicsheatsourceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceEdge::sum(self : PhysicsheatsourceEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceEdge::mean(self : PhysicsheatsourceEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceEdge::scale(self : PhysicsheatsourceEdge, f : Double) -> PhysicsheatsourceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceEdge::add(self : PhysicsheatsourceEdge, other : PhysicsheatsourceEdge) -> PhysicsheatsourceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceEdge::copy(self : PhysicsheatsourceEdge) -> PhysicsheatsourceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceEdge::fill(self : PhysicsheatsourceEdge, v : Double) -> PhysicsheatsourceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceEdge::min(self : PhysicsheatsourceEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceEdge::max(self : PhysicsheatsourceEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceEdge::to_string(self : PhysicsheatsourceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourcePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_path_make(size : Int) -> PhysicsheatsourcePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourcePath::len(self : PhysicsheatsourcePath) -> Int { self.size }

pub fn PhysicsheatsourcePath::get(self : PhysicsheatsourcePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourcePath::set(self : PhysicsheatsourcePath, i : Int, v : Double) -> PhysicsheatsourcePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourcePath::sum(self : PhysicsheatsourcePath) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourcePath::mean(self : PhysicsheatsourcePath) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourcePath::scale(self : PhysicsheatsourcePath, f : Double) -> PhysicsheatsourcePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourcePath::add(self : PhysicsheatsourcePath, other : PhysicsheatsourcePath) -> PhysicsheatsourcePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourcePath::copy(self : PhysicsheatsourcePath) -> PhysicsheatsourcePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourcePath::fill(self : PhysicsheatsourcePath, v : Double) -> PhysicsheatsourcePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourcePath::min(self : PhysicsheatsourcePath) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourcePath::max(self : PhysicsheatsourcePath) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourcePath::to_string(self : PhysicsheatsourcePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_cluster_make(size : Int) -> PhysicsheatsourceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceCluster::len(self : PhysicsheatsourceCluster) -> Int { self.size }

pub fn PhysicsheatsourceCluster::get(self : PhysicsheatsourceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceCluster::set(self : PhysicsheatsourceCluster, i : Int, v : Double) -> PhysicsheatsourceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceCluster::sum(self : PhysicsheatsourceCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceCluster::mean(self : PhysicsheatsourceCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceCluster::scale(self : PhysicsheatsourceCluster, f : Double) -> PhysicsheatsourceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceCluster::add(self : PhysicsheatsourceCluster, other : PhysicsheatsourceCluster) -> PhysicsheatsourceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceCluster::copy(self : PhysicsheatsourceCluster) -> PhysicsheatsourceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceCluster::fill(self : PhysicsheatsourceCluster, v : Double) -> PhysicsheatsourceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceCluster::min(self : PhysicsheatsourceCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceCluster::max(self : PhysicsheatsourceCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceCluster::to_string(self : PhysicsheatsourceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_model_make(size : Int) -> PhysicsheatsourceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceModel::len(self : PhysicsheatsourceModel) -> Int { self.size }

pub fn PhysicsheatsourceModel::get(self : PhysicsheatsourceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceModel::set(self : PhysicsheatsourceModel, i : Int, v : Double) -> PhysicsheatsourceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceModel::sum(self : PhysicsheatsourceModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceModel::mean(self : PhysicsheatsourceModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceModel::scale(self : PhysicsheatsourceModel, f : Double) -> PhysicsheatsourceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceModel::add(self : PhysicsheatsourceModel, other : PhysicsheatsourceModel) -> PhysicsheatsourceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceModel::copy(self : PhysicsheatsourceModel) -> PhysicsheatsourceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceModel::fill(self : PhysicsheatsourceModel, v : Double) -> PhysicsheatsourceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceModel::min(self : PhysicsheatsourceModel) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceModel::max(self : PhysicsheatsourceModel) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceModel::to_string(self : PhysicsheatsourceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_layer_make(size : Int) -> PhysicsheatsourceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceLayer::len(self : PhysicsheatsourceLayer) -> Int { self.size }

pub fn PhysicsheatsourceLayer::get(self : PhysicsheatsourceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceLayer::set(self : PhysicsheatsourceLayer, i : Int, v : Double) -> PhysicsheatsourceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceLayer::sum(self : PhysicsheatsourceLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceLayer::mean(self : PhysicsheatsourceLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceLayer::scale(self : PhysicsheatsourceLayer, f : Double) -> PhysicsheatsourceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceLayer::add(self : PhysicsheatsourceLayer, other : PhysicsheatsourceLayer) -> PhysicsheatsourceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceLayer::copy(self : PhysicsheatsourceLayer) -> PhysicsheatsourceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceLayer::fill(self : PhysicsheatsourceLayer, v : Double) -> PhysicsheatsourceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceLayer::min(self : PhysicsheatsourceLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceLayer::max(self : PhysicsheatsourceLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceLayer::to_string(self : PhysicsheatsourceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_buffer_make(size : Int) -> PhysicsheatsourceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceBuffer::len(self : PhysicsheatsourceBuffer) -> Int { self.size }

pub fn PhysicsheatsourceBuffer::get(self : PhysicsheatsourceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceBuffer::set(self : PhysicsheatsourceBuffer, i : Int, v : Double) -> PhysicsheatsourceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceBuffer::sum(self : PhysicsheatsourceBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceBuffer::mean(self : PhysicsheatsourceBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceBuffer::scale(self : PhysicsheatsourceBuffer, f : Double) -> PhysicsheatsourceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceBuffer::add(self : PhysicsheatsourceBuffer, other : PhysicsheatsourceBuffer) -> PhysicsheatsourceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceBuffer::copy(self : PhysicsheatsourceBuffer) -> PhysicsheatsourceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceBuffer::fill(self : PhysicsheatsourceBuffer, v : Double) -> PhysicsheatsourceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceBuffer::min(self : PhysicsheatsourceBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceBuffer::max(self : PhysicsheatsourceBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceBuffer::to_string(self : PhysicsheatsourceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_cursor_make(size : Int) -> PhysicsheatsourceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceCursor::len(self : PhysicsheatsourceCursor) -> Int { self.size }

pub fn PhysicsheatsourceCursor::get(self : PhysicsheatsourceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceCursor::set(self : PhysicsheatsourceCursor, i : Int, v : Double) -> PhysicsheatsourceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceCursor::sum(self : PhysicsheatsourceCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceCursor::mean(self : PhysicsheatsourceCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceCursor::scale(self : PhysicsheatsourceCursor, f : Double) -> PhysicsheatsourceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceCursor::add(self : PhysicsheatsourceCursor, other : PhysicsheatsourceCursor) -> PhysicsheatsourceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceCursor::copy(self : PhysicsheatsourceCursor) -> PhysicsheatsourceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceCursor::fill(self : PhysicsheatsourceCursor, v : Double) -> PhysicsheatsourceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceCursor::min(self : PhysicsheatsourceCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceCursor::max(self : PhysicsheatsourceCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceCursor::to_string(self : PhysicsheatsourceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_view_make(size : Int) -> PhysicsheatsourceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceView::len(self : PhysicsheatsourceView) -> Int { self.size }

pub fn PhysicsheatsourceView::get(self : PhysicsheatsourceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceView::set(self : PhysicsheatsourceView, i : Int, v : Double) -> PhysicsheatsourceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceView::sum(self : PhysicsheatsourceView) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceView::mean(self : PhysicsheatsourceView) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceView::scale(self : PhysicsheatsourceView, f : Double) -> PhysicsheatsourceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceView::add(self : PhysicsheatsourceView, other : PhysicsheatsourceView) -> PhysicsheatsourceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceView::copy(self : PhysicsheatsourceView) -> PhysicsheatsourceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceView::fill(self : PhysicsheatsourceView, v : Double) -> PhysicsheatsourceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceView::min(self : PhysicsheatsourceView) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceView::max(self : PhysicsheatsourceView) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceView::to_string(self : PhysicsheatsourceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_range_make(size : Int) -> PhysicsheatsourceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceRange::len(self : PhysicsheatsourceRange) -> Int { self.size }

pub fn PhysicsheatsourceRange::get(self : PhysicsheatsourceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceRange::set(self : PhysicsheatsourceRange, i : Int, v : Double) -> PhysicsheatsourceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceRange::sum(self : PhysicsheatsourceRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceRange::mean(self : PhysicsheatsourceRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceRange::scale(self : PhysicsheatsourceRange, f : Double) -> PhysicsheatsourceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceRange::add(self : PhysicsheatsourceRange, other : PhysicsheatsourceRange) -> PhysicsheatsourceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceRange::copy(self : PhysicsheatsourceRange) -> PhysicsheatsourceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceRange::fill(self : PhysicsheatsourceRange, v : Double) -> PhysicsheatsourceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceRange::min(self : PhysicsheatsourceRange) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceRange::max(self : PhysicsheatsourceRange) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceRange::to_string(self : PhysicsheatsourceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_slice_make(size : Int) -> PhysicsheatsourceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsourceSlice::len(self : PhysicsheatsourceSlice) -> Int { self.size }

pub fn PhysicsheatsourceSlice::get(self : PhysicsheatsourceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsourceSlice::set(self : PhysicsheatsourceSlice, i : Int, v : Double) -> PhysicsheatsourceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceSlice::sum(self : PhysicsheatsourceSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsourceSlice::mean(self : PhysicsheatsourceSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsourceSlice::scale(self : PhysicsheatsourceSlice, f : Double) -> PhysicsheatsourceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceSlice::add(self : PhysicsheatsourceSlice, other : PhysicsheatsourceSlice) -> PhysicsheatsourceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsourceSlice::copy(self : PhysicsheatsourceSlice) -> PhysicsheatsourceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceSlice::fill(self : PhysicsheatsourceSlice, v : Double) -> PhysicsheatsourceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsourceSlice::min(self : PhysicsheatsourceSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsourceSlice::max(self : PhysicsheatsourceSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsourceSlice::to_string(self : PhysicsheatsourceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

