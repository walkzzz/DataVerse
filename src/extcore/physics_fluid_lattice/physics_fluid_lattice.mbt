///===
/// extcore/physics_fluid_lattice

pub(all) struct PhysicsfluidlatticePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_lattice_make_point(x : Double, y : Double) -> PhysicsfluidlatticePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_lattice_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidlatticePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidlatticePoint::x(self : PhysicsfluidlatticePoint) -> Double { self.x }

pub fn PhysicsfluidlatticePoint::y(self : PhysicsfluidlatticePoint) -> Double { self.y }

pub fn PhysicsfluidlatticePoint::z(self : PhysicsfluidlatticePoint) -> Double { self.z }

pub fn PhysicsfluidlatticePoint::label(self : PhysicsfluidlatticePoint) -> Int { self.label }

pub fn PhysicsfluidlatticePoint::dist(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidlatticePoint::add(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidlatticePoint::sub(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidlatticePoint::scale(self : PhysicsfluidlatticePoint, s : Double) -> PhysicsfluidlatticePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidlatticePoint::dot(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidlatticePoint::cross(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidlatticePoint::norm(self : PhysicsfluidlatticePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidlatticePoint::normalize(self : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidlatticePoint::negate(self : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidlatticePoint::mid(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidlatticePoint::lerp(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint, t : Double) -> PhysicsfluidlatticePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidlatticePoint::to_string(self : PhysicsfluidlatticePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_lattice_make_series(vals : Array[Double], name : String) -> PhysicsfluidlatticeSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidlatticeSeries::len(self : PhysicsfluidlatticeSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidlatticeSeries::sum(self : PhysicsfluidlatticeSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidlatticeSeries::mean(self : PhysicsfluidlatticeSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidlatticeSeries::min(self : PhysicsfluidlatticeSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidlatticeSeries::max(self : PhysicsfluidlatticeSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidlatticeSeries::range(self : PhysicsfluidlatticeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidlatticeSeries::variance(self : PhysicsfluidlatticeSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidlatticeSeries::std(self : PhysicsfluidlatticeSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidlatticeSeries::median(self : PhysicsfluidlatticeSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidlatticeSeries::scale(self : PhysicsfluidlatticeSeries, f : Double) -> PhysicsfluidlatticeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidlatticeSeries::add(self : PhysicsfluidlatticeSeries, other : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidlatticeSeries::sub(self : PhysicsfluidlatticeSeries, other : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidlatticeSeries::normalize(self : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidlatticeSeries::cumsum(self : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidlatticeSeries::to_string(self : PhysicsfluidlatticeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidlatticeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_lattice_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidlatticeMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn physics_fluid_lattice_matrix_identity(n : Int) -> PhysicsfluidlatticeMatrix {
  let m = physics_fluid_lattice_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidlatticeMatrix::get(self : PhysicsfluidlatticeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidlatticeMatrix::transpose(self : PhysicsfluidlatticeMatrix) -> PhysicsfluidlatticeMatrix {
  let result = physics_fluid_lattice_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidlatticeMatrix::add(self : PhysicsfluidlatticeMatrix, other : PhysicsfluidlatticeMatrix) -> PhysicsfluidlatticeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_lattice_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidlatticeMatrix::scale(self : PhysicsfluidlatticeMatrix, s : Double) -> PhysicsfluidlatticeMatrix {
  let result = physics_fluid_lattice_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidlatticeMatrix::multiply(self : PhysicsfluidlatticeMatrix, other : PhysicsfluidlatticeMatrix) -> PhysicsfluidlatticeMatrix {
  if self.cols != other.rows { return physics_fluid_lattice_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_lattice_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsfluidlatticeMatrix::trace(self : PhysicsfluidlatticeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidlatticeMatrix::det(self : PhysicsfluidlatticeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidlatticeMatrix::norm(self : PhysicsfluidlatticeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidlatticeMatrix::to_string(self : PhysicsfluidlatticeMatrix) -> String {
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

pub(all) struct PhysicsfluidlatticeVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_lattice_make_vector(comps : Array[Double]) -> PhysicsfluidlatticeVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_lattice_vector_zero(dim : Int) -> PhysicsfluidlatticeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidlatticeVector::add(self : PhysicsfluidlatticeVector, other : PhysicsfluidlatticeVector) -> PhysicsfluidlatticeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidlatticeVector::sub(self : PhysicsfluidlatticeVector, other : PhysicsfluidlatticeVector) -> PhysicsfluidlatticeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidlatticeVector::scale(self : PhysicsfluidlatticeVector, s : Double) -> PhysicsfluidlatticeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidlatticeVector::dot(self : PhysicsfluidlatticeVector, other : PhysicsfluidlatticeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidlatticeVector::norm(self : PhysicsfluidlatticeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidlatticeVector::normalize(self : PhysicsfluidlatticeVector) -> PhysicsfluidlatticeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidlatticeVector::dist(self : PhysicsfluidlatticeVector, other : PhysicsfluidlatticeVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidlatticeVector::to_string(self : PhysicsfluidlatticeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidlatticeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_frame_make(size : Int) -> PhysicsfluidlatticeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeFrame::len(self : PhysicsfluidlatticeFrame) -> Int { self.size }

pub fn PhysicsfluidlatticeFrame::get(self : PhysicsfluidlatticeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeFrame::set(self : PhysicsfluidlatticeFrame, i : Int, v : Double) -> PhysicsfluidlatticeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeFrame::sum(self : PhysicsfluidlatticeFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeFrame::mean(self : PhysicsfluidlatticeFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeFrame::scale(self : PhysicsfluidlatticeFrame, f : Double) -> PhysicsfluidlatticeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeFrame::add(self : PhysicsfluidlatticeFrame, other : PhysicsfluidlatticeFrame) -> PhysicsfluidlatticeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeFrame::copy(self : PhysicsfluidlatticeFrame) -> PhysicsfluidlatticeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeFrame::fill(self : PhysicsfluidlatticeFrame, v : Double) -> PhysicsfluidlatticeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeFrame::min(self : PhysicsfluidlatticeFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeFrame::max(self : PhysicsfluidlatticeFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeFrame::to_string(self : PhysicsfluidlatticeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_table_make(size : Int) -> PhysicsfluidlatticeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeTable::len(self : PhysicsfluidlatticeTable) -> Int { self.size }

pub fn PhysicsfluidlatticeTable::get(self : PhysicsfluidlatticeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeTable::set(self : PhysicsfluidlatticeTable, i : Int, v : Double) -> PhysicsfluidlatticeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeTable::sum(self : PhysicsfluidlatticeTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeTable::mean(self : PhysicsfluidlatticeTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeTable::scale(self : PhysicsfluidlatticeTable, f : Double) -> PhysicsfluidlatticeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeTable::add(self : PhysicsfluidlatticeTable, other : PhysicsfluidlatticeTable) -> PhysicsfluidlatticeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeTable::copy(self : PhysicsfluidlatticeTable) -> PhysicsfluidlatticeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeTable::fill(self : PhysicsfluidlatticeTable, v : Double) -> PhysicsfluidlatticeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeTable::min(self : PhysicsfluidlatticeTable) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeTable::max(self : PhysicsfluidlatticeTable) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeTable::to_string(self : PhysicsfluidlatticeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_graphn_make(size : Int) -> PhysicsfluidlatticeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeGraphN::len(self : PhysicsfluidlatticeGraphN) -> Int { self.size }

pub fn PhysicsfluidlatticeGraphN::get(self : PhysicsfluidlatticeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeGraphN::set(self : PhysicsfluidlatticeGraphN, i : Int, v : Double) -> PhysicsfluidlatticeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeGraphN::sum(self : PhysicsfluidlatticeGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeGraphN::mean(self : PhysicsfluidlatticeGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeGraphN::scale(self : PhysicsfluidlatticeGraphN, f : Double) -> PhysicsfluidlatticeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeGraphN::add(self : PhysicsfluidlatticeGraphN, other : PhysicsfluidlatticeGraphN) -> PhysicsfluidlatticeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeGraphN::copy(self : PhysicsfluidlatticeGraphN) -> PhysicsfluidlatticeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeGraphN::fill(self : PhysicsfluidlatticeGraphN, v : Double) -> PhysicsfluidlatticeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeGraphN::min(self : PhysicsfluidlatticeGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeGraphN::max(self : PhysicsfluidlatticeGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeGraphN::to_string(self : PhysicsfluidlatticeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_node_make(size : Int) -> PhysicsfluidlatticeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeNode::len(self : PhysicsfluidlatticeNode) -> Int { self.size }

pub fn PhysicsfluidlatticeNode::get(self : PhysicsfluidlatticeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeNode::set(self : PhysicsfluidlatticeNode, i : Int, v : Double) -> PhysicsfluidlatticeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeNode::sum(self : PhysicsfluidlatticeNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeNode::mean(self : PhysicsfluidlatticeNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeNode::scale(self : PhysicsfluidlatticeNode, f : Double) -> PhysicsfluidlatticeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeNode::add(self : PhysicsfluidlatticeNode, other : PhysicsfluidlatticeNode) -> PhysicsfluidlatticeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeNode::copy(self : PhysicsfluidlatticeNode) -> PhysicsfluidlatticeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeNode::fill(self : PhysicsfluidlatticeNode, v : Double) -> PhysicsfluidlatticeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeNode::min(self : PhysicsfluidlatticeNode) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeNode::max(self : PhysicsfluidlatticeNode) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeNode::to_string(self : PhysicsfluidlatticeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_edge_make(size : Int) -> PhysicsfluidlatticeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeEdge::len(self : PhysicsfluidlatticeEdge) -> Int { self.size }

pub fn PhysicsfluidlatticeEdge::get(self : PhysicsfluidlatticeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeEdge::set(self : PhysicsfluidlatticeEdge, i : Int, v : Double) -> PhysicsfluidlatticeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeEdge::sum(self : PhysicsfluidlatticeEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeEdge::mean(self : PhysicsfluidlatticeEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeEdge::scale(self : PhysicsfluidlatticeEdge, f : Double) -> PhysicsfluidlatticeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeEdge::add(self : PhysicsfluidlatticeEdge, other : PhysicsfluidlatticeEdge) -> PhysicsfluidlatticeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeEdge::copy(self : PhysicsfluidlatticeEdge) -> PhysicsfluidlatticeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeEdge::fill(self : PhysicsfluidlatticeEdge, v : Double) -> PhysicsfluidlatticeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeEdge::min(self : PhysicsfluidlatticeEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeEdge::max(self : PhysicsfluidlatticeEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeEdge::to_string(self : PhysicsfluidlatticeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_path_make(size : Int) -> PhysicsfluidlatticePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticePath::len(self : PhysicsfluidlatticePath) -> Int { self.size }

pub fn PhysicsfluidlatticePath::get(self : PhysicsfluidlatticePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticePath::set(self : PhysicsfluidlatticePath, i : Int, v : Double) -> PhysicsfluidlatticePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticePath::sum(self : PhysicsfluidlatticePath) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticePath::mean(self : PhysicsfluidlatticePath) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticePath::scale(self : PhysicsfluidlatticePath, f : Double) -> PhysicsfluidlatticePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticePath::add(self : PhysicsfluidlatticePath, other : PhysicsfluidlatticePath) -> PhysicsfluidlatticePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticePath::copy(self : PhysicsfluidlatticePath) -> PhysicsfluidlatticePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticePath::fill(self : PhysicsfluidlatticePath, v : Double) -> PhysicsfluidlatticePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticePath::min(self : PhysicsfluidlatticePath) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticePath::max(self : PhysicsfluidlatticePath) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticePath::to_string(self : PhysicsfluidlatticePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_cluster_make(size : Int) -> PhysicsfluidlatticeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeCluster::len(self : PhysicsfluidlatticeCluster) -> Int { self.size }

pub fn PhysicsfluidlatticeCluster::get(self : PhysicsfluidlatticeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeCluster::set(self : PhysicsfluidlatticeCluster, i : Int, v : Double) -> PhysicsfluidlatticeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeCluster::sum(self : PhysicsfluidlatticeCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeCluster::mean(self : PhysicsfluidlatticeCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeCluster::scale(self : PhysicsfluidlatticeCluster, f : Double) -> PhysicsfluidlatticeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeCluster::add(self : PhysicsfluidlatticeCluster, other : PhysicsfluidlatticeCluster) -> PhysicsfluidlatticeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeCluster::copy(self : PhysicsfluidlatticeCluster) -> PhysicsfluidlatticeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeCluster::fill(self : PhysicsfluidlatticeCluster, v : Double) -> PhysicsfluidlatticeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeCluster::min(self : PhysicsfluidlatticeCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeCluster::max(self : PhysicsfluidlatticeCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeCluster::to_string(self : PhysicsfluidlatticeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_model_make(size : Int) -> PhysicsfluidlatticeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeModel::len(self : PhysicsfluidlatticeModel) -> Int { self.size }

pub fn PhysicsfluidlatticeModel::get(self : PhysicsfluidlatticeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeModel::set(self : PhysicsfluidlatticeModel, i : Int, v : Double) -> PhysicsfluidlatticeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeModel::sum(self : PhysicsfluidlatticeModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeModel::mean(self : PhysicsfluidlatticeModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeModel::scale(self : PhysicsfluidlatticeModel, f : Double) -> PhysicsfluidlatticeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeModel::add(self : PhysicsfluidlatticeModel, other : PhysicsfluidlatticeModel) -> PhysicsfluidlatticeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeModel::copy(self : PhysicsfluidlatticeModel) -> PhysicsfluidlatticeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeModel::fill(self : PhysicsfluidlatticeModel, v : Double) -> PhysicsfluidlatticeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeModel::min(self : PhysicsfluidlatticeModel) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeModel::max(self : PhysicsfluidlatticeModel) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeModel::to_string(self : PhysicsfluidlatticeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_layer_make(size : Int) -> PhysicsfluidlatticeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeLayer::len(self : PhysicsfluidlatticeLayer) -> Int { self.size }

pub fn PhysicsfluidlatticeLayer::get(self : PhysicsfluidlatticeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeLayer::set(self : PhysicsfluidlatticeLayer, i : Int, v : Double) -> PhysicsfluidlatticeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeLayer::sum(self : PhysicsfluidlatticeLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeLayer::mean(self : PhysicsfluidlatticeLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeLayer::scale(self : PhysicsfluidlatticeLayer, f : Double) -> PhysicsfluidlatticeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeLayer::add(self : PhysicsfluidlatticeLayer, other : PhysicsfluidlatticeLayer) -> PhysicsfluidlatticeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeLayer::copy(self : PhysicsfluidlatticeLayer) -> PhysicsfluidlatticeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeLayer::fill(self : PhysicsfluidlatticeLayer, v : Double) -> PhysicsfluidlatticeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeLayer::min(self : PhysicsfluidlatticeLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeLayer::max(self : PhysicsfluidlatticeLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeLayer::to_string(self : PhysicsfluidlatticeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_buffer_make(size : Int) -> PhysicsfluidlatticeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeBuffer::len(self : PhysicsfluidlatticeBuffer) -> Int { self.size }

pub fn PhysicsfluidlatticeBuffer::get(self : PhysicsfluidlatticeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeBuffer::set(self : PhysicsfluidlatticeBuffer, i : Int, v : Double) -> PhysicsfluidlatticeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeBuffer::sum(self : PhysicsfluidlatticeBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeBuffer::mean(self : PhysicsfluidlatticeBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeBuffer::scale(self : PhysicsfluidlatticeBuffer, f : Double) -> PhysicsfluidlatticeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeBuffer::add(self : PhysicsfluidlatticeBuffer, other : PhysicsfluidlatticeBuffer) -> PhysicsfluidlatticeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeBuffer::copy(self : PhysicsfluidlatticeBuffer) -> PhysicsfluidlatticeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeBuffer::fill(self : PhysicsfluidlatticeBuffer, v : Double) -> PhysicsfluidlatticeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeBuffer::min(self : PhysicsfluidlatticeBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeBuffer::max(self : PhysicsfluidlatticeBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeBuffer::to_string(self : PhysicsfluidlatticeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_cursor_make(size : Int) -> PhysicsfluidlatticeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeCursor::len(self : PhysicsfluidlatticeCursor) -> Int { self.size }

pub fn PhysicsfluidlatticeCursor::get(self : PhysicsfluidlatticeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeCursor::set(self : PhysicsfluidlatticeCursor, i : Int, v : Double) -> PhysicsfluidlatticeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeCursor::sum(self : PhysicsfluidlatticeCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeCursor::mean(self : PhysicsfluidlatticeCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeCursor::scale(self : PhysicsfluidlatticeCursor, f : Double) -> PhysicsfluidlatticeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeCursor::add(self : PhysicsfluidlatticeCursor, other : PhysicsfluidlatticeCursor) -> PhysicsfluidlatticeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeCursor::copy(self : PhysicsfluidlatticeCursor) -> PhysicsfluidlatticeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeCursor::fill(self : PhysicsfluidlatticeCursor, v : Double) -> PhysicsfluidlatticeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeCursor::min(self : PhysicsfluidlatticeCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeCursor::max(self : PhysicsfluidlatticeCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeCursor::to_string(self : PhysicsfluidlatticeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_view_make(size : Int) -> PhysicsfluidlatticeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeView::len(self : PhysicsfluidlatticeView) -> Int { self.size }

pub fn PhysicsfluidlatticeView::get(self : PhysicsfluidlatticeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeView::set(self : PhysicsfluidlatticeView, i : Int, v : Double) -> PhysicsfluidlatticeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeView::sum(self : PhysicsfluidlatticeView) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeView::mean(self : PhysicsfluidlatticeView) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeView::scale(self : PhysicsfluidlatticeView, f : Double) -> PhysicsfluidlatticeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeView::add(self : PhysicsfluidlatticeView, other : PhysicsfluidlatticeView) -> PhysicsfluidlatticeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeView::copy(self : PhysicsfluidlatticeView) -> PhysicsfluidlatticeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeView::fill(self : PhysicsfluidlatticeView, v : Double) -> PhysicsfluidlatticeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeView::min(self : PhysicsfluidlatticeView) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeView::max(self : PhysicsfluidlatticeView) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeView::to_string(self : PhysicsfluidlatticeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_range_make(size : Int) -> PhysicsfluidlatticeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeRange::len(self : PhysicsfluidlatticeRange) -> Int { self.size }

pub fn PhysicsfluidlatticeRange::get(self : PhysicsfluidlatticeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeRange::set(self : PhysicsfluidlatticeRange, i : Int, v : Double) -> PhysicsfluidlatticeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeRange::sum(self : PhysicsfluidlatticeRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeRange::mean(self : PhysicsfluidlatticeRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeRange::scale(self : PhysicsfluidlatticeRange, f : Double) -> PhysicsfluidlatticeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeRange::add(self : PhysicsfluidlatticeRange, other : PhysicsfluidlatticeRange) -> PhysicsfluidlatticeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeRange::copy(self : PhysicsfluidlatticeRange) -> PhysicsfluidlatticeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeRange::fill(self : PhysicsfluidlatticeRange, v : Double) -> PhysicsfluidlatticeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeRange::min(self : PhysicsfluidlatticeRange) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeRange::max(self : PhysicsfluidlatticeRange) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeRange::to_string(self : PhysicsfluidlatticeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_slice_make(size : Int) -> PhysicsfluidlatticeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidlatticeSlice::len(self : PhysicsfluidlatticeSlice) -> Int { self.size }

pub fn PhysicsfluidlatticeSlice::get(self : PhysicsfluidlatticeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidlatticeSlice::set(self : PhysicsfluidlatticeSlice, i : Int, v : Double) -> PhysicsfluidlatticeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeSlice::sum(self : PhysicsfluidlatticeSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidlatticeSlice::mean(self : PhysicsfluidlatticeSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidlatticeSlice::scale(self : PhysicsfluidlatticeSlice, f : Double) -> PhysicsfluidlatticeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeSlice::add(self : PhysicsfluidlatticeSlice, other : PhysicsfluidlatticeSlice) -> PhysicsfluidlatticeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidlatticeSlice::copy(self : PhysicsfluidlatticeSlice) -> PhysicsfluidlatticeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeSlice::fill(self : PhysicsfluidlatticeSlice, v : Double) -> PhysicsfluidlatticeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidlatticeSlice::min(self : PhysicsfluidlatticeSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidlatticeSlice::max(self : PhysicsfluidlatticeSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidlatticeSlice::to_string(self : PhysicsfluidlatticeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

