///===
/// extcore/physics_fluid_euler

pub(all) struct PhysicsfluideulerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_euler_make_point(x : Double, y : Double) -> PhysicsfluideulerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_euler_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluideulerPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluideulerPoint::x(self : PhysicsfluideulerPoint) -> Double { self.x }

pub fn PhysicsfluideulerPoint::y(self : PhysicsfluideulerPoint) -> Double { self.y }

pub fn PhysicsfluideulerPoint::z(self : PhysicsfluideulerPoint) -> Double { self.z }

pub fn PhysicsfluideulerPoint::label(self : PhysicsfluideulerPoint) -> Int { self.label }

pub fn PhysicsfluideulerPoint::dist(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluideulerPoint::add(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluideulerPoint::sub(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluideulerPoint::scale(self : PhysicsfluideulerPoint, s : Double) -> PhysicsfluideulerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluideulerPoint::dot(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluideulerPoint::cross(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluideulerPoint::norm(self : PhysicsfluideulerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluideulerPoint::normalize(self : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluideulerPoint::negate(self : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluideulerPoint::mid(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluideulerPoint::lerp(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint, t : Double) -> PhysicsfluideulerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluideulerPoint::to_string(self : PhysicsfluideulerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluideulerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_euler_make_series(vals : Array[Double], name : String) -> PhysicsfluideulerSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluideulerSeries::len(self : PhysicsfluideulerSeries) -> Int { self.vals.length() }

pub fn PhysicsfluideulerSeries::sum(self : PhysicsfluideulerSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluideulerSeries::mean(self : PhysicsfluideulerSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluideulerSeries::min(self : PhysicsfluideulerSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluideulerSeries::max(self : PhysicsfluideulerSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluideulerSeries::range(self : PhysicsfluideulerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluideulerSeries::variance(self : PhysicsfluideulerSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluideulerSeries::std(self : PhysicsfluideulerSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluideulerSeries::median(self : PhysicsfluideulerSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluideulerSeries::scale(self : PhysicsfluideulerSeries, f : Double) -> PhysicsfluideulerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluideulerSeries::add(self : PhysicsfluideulerSeries, other : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluideulerSeries::sub(self : PhysicsfluideulerSeries, other : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluideulerSeries::normalize(self : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluideulerSeries::cumsum(self : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluideulerSeries::to_string(self : PhysicsfluideulerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluideulerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_euler_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluideulerMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn physics_fluid_euler_matrix_identity(n : Int) -> PhysicsfluideulerMatrix {
  let m = physics_fluid_euler_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluideulerMatrix::get(self : PhysicsfluideulerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluideulerMatrix::transpose(self : PhysicsfluideulerMatrix) -> PhysicsfluideulerMatrix {
  let result = physics_fluid_euler_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluideulerMatrix::add(self : PhysicsfluideulerMatrix, other : PhysicsfluideulerMatrix) -> PhysicsfluideulerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_euler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluideulerMatrix::scale(self : PhysicsfluideulerMatrix, s : Double) -> PhysicsfluideulerMatrix {
  let result = physics_fluid_euler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluideulerMatrix::multiply(self : PhysicsfluideulerMatrix, other : PhysicsfluideulerMatrix) -> PhysicsfluideulerMatrix {
  if self.cols != other.rows { return physics_fluid_euler_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_euler_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsfluideulerMatrix::trace(self : PhysicsfluideulerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluideulerMatrix::det(self : PhysicsfluideulerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluideulerMatrix::norm(self : PhysicsfluideulerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluideulerMatrix::to_string(self : PhysicsfluideulerMatrix) -> String {
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

pub(all) struct PhysicsfluideulerVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_euler_make_vector(comps : Array[Double]) -> PhysicsfluideulerVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_euler_vector_zero(dim : Int) -> PhysicsfluideulerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluideulerVector::add(self : PhysicsfluideulerVector, other : PhysicsfluideulerVector) -> PhysicsfluideulerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluideulerVector::sub(self : PhysicsfluideulerVector, other : PhysicsfluideulerVector) -> PhysicsfluideulerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluideulerVector::scale(self : PhysicsfluideulerVector, s : Double) -> PhysicsfluideulerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluideulerVector::dot(self : PhysicsfluideulerVector, other : PhysicsfluideulerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluideulerVector::norm(self : PhysicsfluideulerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluideulerVector::normalize(self : PhysicsfluideulerVector) -> PhysicsfluideulerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluideulerVector::dist(self : PhysicsfluideulerVector, other : PhysicsfluideulerVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluideulerVector::to_string(self : PhysicsfluideulerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluideulerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_frame_make(size : Int) -> PhysicsfluideulerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerFrame::len(self : PhysicsfluideulerFrame) -> Int { self.size }

pub fn PhysicsfluideulerFrame::get(self : PhysicsfluideulerFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerFrame::set(self : PhysicsfluideulerFrame, i : Int, v : Double) -> PhysicsfluideulerFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerFrame::sum(self : PhysicsfluideulerFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerFrame::mean(self : PhysicsfluideulerFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerFrame::scale(self : PhysicsfluideulerFrame, f : Double) -> PhysicsfluideulerFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerFrame::add(self : PhysicsfluideulerFrame, other : PhysicsfluideulerFrame) -> PhysicsfluideulerFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerFrame::copy(self : PhysicsfluideulerFrame) -> PhysicsfluideulerFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerFrame::fill(self : PhysicsfluideulerFrame, v : Double) -> PhysicsfluideulerFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerFrame::min(self : PhysicsfluideulerFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerFrame::max(self : PhysicsfluideulerFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerFrame::to_string(self : PhysicsfluideulerFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_table_make(size : Int) -> PhysicsfluideulerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerTable::len(self : PhysicsfluideulerTable) -> Int { self.size }

pub fn PhysicsfluideulerTable::get(self : PhysicsfluideulerTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerTable::set(self : PhysicsfluideulerTable, i : Int, v : Double) -> PhysicsfluideulerTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerTable::sum(self : PhysicsfluideulerTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerTable::mean(self : PhysicsfluideulerTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerTable::scale(self : PhysicsfluideulerTable, f : Double) -> PhysicsfluideulerTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerTable::add(self : PhysicsfluideulerTable, other : PhysicsfluideulerTable) -> PhysicsfluideulerTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerTable::copy(self : PhysicsfluideulerTable) -> PhysicsfluideulerTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerTable::fill(self : PhysicsfluideulerTable, v : Double) -> PhysicsfluideulerTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerTable::min(self : PhysicsfluideulerTable) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerTable::max(self : PhysicsfluideulerTable) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerTable::to_string(self : PhysicsfluideulerTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_graphn_make(size : Int) -> PhysicsfluideulerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerGraphN::len(self : PhysicsfluideulerGraphN) -> Int { self.size }

pub fn PhysicsfluideulerGraphN::get(self : PhysicsfluideulerGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerGraphN::set(self : PhysicsfluideulerGraphN, i : Int, v : Double) -> PhysicsfluideulerGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerGraphN::sum(self : PhysicsfluideulerGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerGraphN::mean(self : PhysicsfluideulerGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerGraphN::scale(self : PhysicsfluideulerGraphN, f : Double) -> PhysicsfluideulerGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerGraphN::add(self : PhysicsfluideulerGraphN, other : PhysicsfluideulerGraphN) -> PhysicsfluideulerGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerGraphN::copy(self : PhysicsfluideulerGraphN) -> PhysicsfluideulerGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerGraphN::fill(self : PhysicsfluideulerGraphN, v : Double) -> PhysicsfluideulerGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerGraphN::min(self : PhysicsfluideulerGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerGraphN::max(self : PhysicsfluideulerGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerGraphN::to_string(self : PhysicsfluideulerGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_node_make(size : Int) -> PhysicsfluideulerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerNode::len(self : PhysicsfluideulerNode) -> Int { self.size }

pub fn PhysicsfluideulerNode::get(self : PhysicsfluideulerNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerNode::set(self : PhysicsfluideulerNode, i : Int, v : Double) -> PhysicsfluideulerNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerNode::sum(self : PhysicsfluideulerNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerNode::mean(self : PhysicsfluideulerNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerNode::scale(self : PhysicsfluideulerNode, f : Double) -> PhysicsfluideulerNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerNode::add(self : PhysicsfluideulerNode, other : PhysicsfluideulerNode) -> PhysicsfluideulerNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerNode::copy(self : PhysicsfluideulerNode) -> PhysicsfluideulerNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerNode::fill(self : PhysicsfluideulerNode, v : Double) -> PhysicsfluideulerNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerNode::min(self : PhysicsfluideulerNode) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerNode::max(self : PhysicsfluideulerNode) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerNode::to_string(self : PhysicsfluideulerNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_edge_make(size : Int) -> PhysicsfluideulerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerEdge::len(self : PhysicsfluideulerEdge) -> Int { self.size }

pub fn PhysicsfluideulerEdge::get(self : PhysicsfluideulerEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerEdge::set(self : PhysicsfluideulerEdge, i : Int, v : Double) -> PhysicsfluideulerEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerEdge::sum(self : PhysicsfluideulerEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerEdge::mean(self : PhysicsfluideulerEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerEdge::scale(self : PhysicsfluideulerEdge, f : Double) -> PhysicsfluideulerEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerEdge::add(self : PhysicsfluideulerEdge, other : PhysicsfluideulerEdge) -> PhysicsfluideulerEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerEdge::copy(self : PhysicsfluideulerEdge) -> PhysicsfluideulerEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerEdge::fill(self : PhysicsfluideulerEdge, v : Double) -> PhysicsfluideulerEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerEdge::min(self : PhysicsfluideulerEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerEdge::max(self : PhysicsfluideulerEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerEdge::to_string(self : PhysicsfluideulerEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_path_make(size : Int) -> PhysicsfluideulerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerPath::len(self : PhysicsfluideulerPath) -> Int { self.size }

pub fn PhysicsfluideulerPath::get(self : PhysicsfluideulerPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerPath::set(self : PhysicsfluideulerPath, i : Int, v : Double) -> PhysicsfluideulerPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerPath::sum(self : PhysicsfluideulerPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerPath::mean(self : PhysicsfluideulerPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerPath::scale(self : PhysicsfluideulerPath, f : Double) -> PhysicsfluideulerPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerPath::add(self : PhysicsfluideulerPath, other : PhysicsfluideulerPath) -> PhysicsfluideulerPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerPath::copy(self : PhysicsfluideulerPath) -> PhysicsfluideulerPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerPath::fill(self : PhysicsfluideulerPath, v : Double) -> PhysicsfluideulerPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerPath::min(self : PhysicsfluideulerPath) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerPath::max(self : PhysicsfluideulerPath) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerPath::to_string(self : PhysicsfluideulerPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_cluster_make(size : Int) -> PhysicsfluideulerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerCluster::len(self : PhysicsfluideulerCluster) -> Int { self.size }

pub fn PhysicsfluideulerCluster::get(self : PhysicsfluideulerCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerCluster::set(self : PhysicsfluideulerCluster, i : Int, v : Double) -> PhysicsfluideulerCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerCluster::sum(self : PhysicsfluideulerCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerCluster::mean(self : PhysicsfluideulerCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerCluster::scale(self : PhysicsfluideulerCluster, f : Double) -> PhysicsfluideulerCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerCluster::add(self : PhysicsfluideulerCluster, other : PhysicsfluideulerCluster) -> PhysicsfluideulerCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerCluster::copy(self : PhysicsfluideulerCluster) -> PhysicsfluideulerCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerCluster::fill(self : PhysicsfluideulerCluster, v : Double) -> PhysicsfluideulerCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerCluster::min(self : PhysicsfluideulerCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerCluster::max(self : PhysicsfluideulerCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerCluster::to_string(self : PhysicsfluideulerCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_model_make(size : Int) -> PhysicsfluideulerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerModel::len(self : PhysicsfluideulerModel) -> Int { self.size }

pub fn PhysicsfluideulerModel::get(self : PhysicsfluideulerModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerModel::set(self : PhysicsfluideulerModel, i : Int, v : Double) -> PhysicsfluideulerModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerModel::sum(self : PhysicsfluideulerModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerModel::mean(self : PhysicsfluideulerModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerModel::scale(self : PhysicsfluideulerModel, f : Double) -> PhysicsfluideulerModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerModel::add(self : PhysicsfluideulerModel, other : PhysicsfluideulerModel) -> PhysicsfluideulerModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerModel::copy(self : PhysicsfluideulerModel) -> PhysicsfluideulerModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerModel::fill(self : PhysicsfluideulerModel, v : Double) -> PhysicsfluideulerModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerModel::min(self : PhysicsfluideulerModel) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerModel::max(self : PhysicsfluideulerModel) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerModel::to_string(self : PhysicsfluideulerModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_layer_make(size : Int) -> PhysicsfluideulerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerLayer::len(self : PhysicsfluideulerLayer) -> Int { self.size }

pub fn PhysicsfluideulerLayer::get(self : PhysicsfluideulerLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerLayer::set(self : PhysicsfluideulerLayer, i : Int, v : Double) -> PhysicsfluideulerLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerLayer::sum(self : PhysicsfluideulerLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerLayer::mean(self : PhysicsfluideulerLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerLayer::scale(self : PhysicsfluideulerLayer, f : Double) -> PhysicsfluideulerLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerLayer::add(self : PhysicsfluideulerLayer, other : PhysicsfluideulerLayer) -> PhysicsfluideulerLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerLayer::copy(self : PhysicsfluideulerLayer) -> PhysicsfluideulerLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerLayer::fill(self : PhysicsfluideulerLayer, v : Double) -> PhysicsfluideulerLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerLayer::min(self : PhysicsfluideulerLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerLayer::max(self : PhysicsfluideulerLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerLayer::to_string(self : PhysicsfluideulerLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_buffer_make(size : Int) -> PhysicsfluideulerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerBuffer::len(self : PhysicsfluideulerBuffer) -> Int { self.size }

pub fn PhysicsfluideulerBuffer::get(self : PhysicsfluideulerBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerBuffer::set(self : PhysicsfluideulerBuffer, i : Int, v : Double) -> PhysicsfluideulerBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerBuffer::sum(self : PhysicsfluideulerBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerBuffer::mean(self : PhysicsfluideulerBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerBuffer::scale(self : PhysicsfluideulerBuffer, f : Double) -> PhysicsfluideulerBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerBuffer::add(self : PhysicsfluideulerBuffer, other : PhysicsfluideulerBuffer) -> PhysicsfluideulerBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerBuffer::copy(self : PhysicsfluideulerBuffer) -> PhysicsfluideulerBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerBuffer::fill(self : PhysicsfluideulerBuffer, v : Double) -> PhysicsfluideulerBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerBuffer::min(self : PhysicsfluideulerBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerBuffer::max(self : PhysicsfluideulerBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerBuffer::to_string(self : PhysicsfluideulerBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_cursor_make(size : Int) -> PhysicsfluideulerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerCursor::len(self : PhysicsfluideulerCursor) -> Int { self.size }

pub fn PhysicsfluideulerCursor::get(self : PhysicsfluideulerCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerCursor::set(self : PhysicsfluideulerCursor, i : Int, v : Double) -> PhysicsfluideulerCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerCursor::sum(self : PhysicsfluideulerCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerCursor::mean(self : PhysicsfluideulerCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerCursor::scale(self : PhysicsfluideulerCursor, f : Double) -> PhysicsfluideulerCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerCursor::add(self : PhysicsfluideulerCursor, other : PhysicsfluideulerCursor) -> PhysicsfluideulerCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerCursor::copy(self : PhysicsfluideulerCursor) -> PhysicsfluideulerCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerCursor::fill(self : PhysicsfluideulerCursor, v : Double) -> PhysicsfluideulerCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerCursor::min(self : PhysicsfluideulerCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerCursor::max(self : PhysicsfluideulerCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerCursor::to_string(self : PhysicsfluideulerCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_view_make(size : Int) -> PhysicsfluideulerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerView::len(self : PhysicsfluideulerView) -> Int { self.size }

pub fn PhysicsfluideulerView::get(self : PhysicsfluideulerView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerView::set(self : PhysicsfluideulerView, i : Int, v : Double) -> PhysicsfluideulerView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerView::sum(self : PhysicsfluideulerView) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerView::mean(self : PhysicsfluideulerView) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerView::scale(self : PhysicsfluideulerView, f : Double) -> PhysicsfluideulerView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerView::add(self : PhysicsfluideulerView, other : PhysicsfluideulerView) -> PhysicsfluideulerView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerView::copy(self : PhysicsfluideulerView) -> PhysicsfluideulerView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerView::fill(self : PhysicsfluideulerView, v : Double) -> PhysicsfluideulerView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerView::min(self : PhysicsfluideulerView) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerView::max(self : PhysicsfluideulerView) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerView::to_string(self : PhysicsfluideulerView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_range_make(size : Int) -> PhysicsfluideulerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerRange::len(self : PhysicsfluideulerRange) -> Int { self.size }

pub fn PhysicsfluideulerRange::get(self : PhysicsfluideulerRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerRange::set(self : PhysicsfluideulerRange, i : Int, v : Double) -> PhysicsfluideulerRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerRange::sum(self : PhysicsfluideulerRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerRange::mean(self : PhysicsfluideulerRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerRange::scale(self : PhysicsfluideulerRange, f : Double) -> PhysicsfluideulerRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerRange::add(self : PhysicsfluideulerRange, other : PhysicsfluideulerRange) -> PhysicsfluideulerRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerRange::copy(self : PhysicsfluideulerRange) -> PhysicsfluideulerRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerRange::fill(self : PhysicsfluideulerRange, v : Double) -> PhysicsfluideulerRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerRange::min(self : PhysicsfluideulerRange) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerRange::max(self : PhysicsfluideulerRange) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerRange::to_string(self : PhysicsfluideulerRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_slice_make(size : Int) -> PhysicsfluideulerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluideulerSlice::len(self : PhysicsfluideulerSlice) -> Int { self.size }

pub fn PhysicsfluideulerSlice::get(self : PhysicsfluideulerSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluideulerSlice::set(self : PhysicsfluideulerSlice, i : Int, v : Double) -> PhysicsfluideulerSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerSlice::sum(self : PhysicsfluideulerSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluideulerSlice::mean(self : PhysicsfluideulerSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluideulerSlice::scale(self : PhysicsfluideulerSlice, f : Double) -> PhysicsfluideulerSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerSlice::add(self : PhysicsfluideulerSlice, other : PhysicsfluideulerSlice) -> PhysicsfluideulerSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluideulerSlice::copy(self : PhysicsfluideulerSlice) -> PhysicsfluideulerSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerSlice::fill(self : PhysicsfluideulerSlice, v : Double) -> PhysicsfluideulerSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluideulerSlice::min(self : PhysicsfluideulerSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsfluideulerSlice::max(self : PhysicsfluideulerSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsfluideulerSlice::to_string(self : PhysicsfluideulerSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

