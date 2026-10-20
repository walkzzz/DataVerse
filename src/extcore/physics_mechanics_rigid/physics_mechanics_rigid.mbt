///===
/// extcore/physics_mechanics_rigid

pub(all) struct PhysicsmechanicsrigidPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_rigid_make_point(x : Double, y : Double) -> PhysicsmechanicsrigidPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_rigid_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsrigidPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicsrigidPoint::x(self : PhysicsmechanicsrigidPoint) -> Double { self.x }

pub fn PhysicsmechanicsrigidPoint::y(self : PhysicsmechanicsrigidPoint) -> Double { self.y }

pub fn PhysicsmechanicsrigidPoint::z(self : PhysicsmechanicsrigidPoint) -> Double { self.z }

pub fn PhysicsmechanicsrigidPoint::label(self : PhysicsmechanicsrigidPoint) -> Int { self.label }

pub fn PhysicsmechanicsrigidPoint::dist(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicsrigidPoint::add(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::sub(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::scale(self : PhysicsmechanicsrigidPoint, s : Double) -> PhysicsmechanicsrigidPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::dot(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicsrigidPoint::cross(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicsrigidPoint::norm(self : PhysicsmechanicsrigidPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicsrigidPoint::normalize(self : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsrigidPoint::negate(self : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::mid(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::lerp(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint, t : Double) -> PhysicsmechanicsrigidPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::to_string(self : PhysicsmechanicsrigidPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_rigid_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsrigidSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicsrigidSeries::len(self : PhysicsmechanicsrigidSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicsrigidSeries::sum(self : PhysicsmechanicsrigidSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicsrigidSeries::mean(self : PhysicsmechanicsrigidSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicsrigidSeries::min(self : PhysicsmechanicsrigidSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicsrigidSeries::max(self : PhysicsmechanicsrigidSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicsrigidSeries::range(self : PhysicsmechanicsrigidSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicsrigidSeries::variance(self : PhysicsmechanicsrigidSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicsrigidSeries::std(self : PhysicsmechanicsrigidSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicsrigidSeries::median(self : PhysicsmechanicsrigidSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicsrigidSeries::scale(self : PhysicsmechanicsrigidSeries, f : Double) -> PhysicsmechanicsrigidSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicsrigidSeries::add(self : PhysicsmechanicsrigidSeries, other : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsrigidSeries::sub(self : PhysicsmechanicsrigidSeries, other : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsrigidSeries::normalize(self : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicsrigidSeries::cumsum(self : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicsrigidSeries::to_string(self : PhysicsmechanicsrigidSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsrigidMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_rigid_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsrigidMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_rigid_matrix_identity(n : Int) -> PhysicsmechanicsrigidMatrix {
  let m = physics_mechanics_rigid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicsrigidMatrix::get(self : PhysicsmechanicsrigidMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicsrigidMatrix::transpose(self : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  let result = physics_mechanics_rigid_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicsrigidMatrix::add(self : PhysicsmechanicsrigidMatrix, other : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_rigid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicsrigidMatrix::scale(self : PhysicsmechanicsrigidMatrix, s : Double) -> PhysicsmechanicsrigidMatrix {
  let result = physics_mechanics_rigid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicsrigidMatrix::multiply(self : PhysicsmechanicsrigidMatrix, other : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  if self.cols != other.rows { return physics_mechanics_rigid_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_rigid_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsmechanicsrigidMatrix::trace(self : PhysicsmechanicsrigidMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicsrigidMatrix::det(self : PhysicsmechanicsrigidMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicsrigidMatrix::norm(self : PhysicsmechanicsrigidMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicsrigidMatrix::to_string(self : PhysicsmechanicsrigidMatrix) -> String {
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

pub(all) struct PhysicsmechanicsrigidVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_rigid_make_vector(comps : Array[Double]) -> PhysicsmechanicsrigidVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_rigid_vector_zero(dim : Int) -> PhysicsmechanicsrigidVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicsrigidVector::add(self : PhysicsmechanicsrigidVector, other : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsrigidVector::sub(self : PhysicsmechanicsrigidVector, other : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsrigidVector::scale(self : PhysicsmechanicsrigidVector, s : Double) -> PhysicsmechanicsrigidVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicsrigidVector::dot(self : PhysicsmechanicsrigidVector, other : PhysicsmechanicsrigidVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicsrigidVector::norm(self : PhysicsmechanicsrigidVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicsrigidVector::normalize(self : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsrigidVector::dist(self : PhysicsmechanicsrigidVector, other : PhysicsmechanicsrigidVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicsrigidVector::to_string(self : PhysicsmechanicsrigidVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsrigidFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_frame_make(size : Int) -> PhysicsmechanicsrigidFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidFrame::len(self : PhysicsmechanicsrigidFrame) -> Int { self.size }

pub fn PhysicsmechanicsrigidFrame::get(self : PhysicsmechanicsrigidFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidFrame::set(self : PhysicsmechanicsrigidFrame, i : Int, v : Double) -> PhysicsmechanicsrigidFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidFrame::sum(self : PhysicsmechanicsrigidFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidFrame::mean(self : PhysicsmechanicsrigidFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidFrame::scale(self : PhysicsmechanicsrigidFrame, f : Double) -> PhysicsmechanicsrigidFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidFrame::add(self : PhysicsmechanicsrigidFrame, other : PhysicsmechanicsrigidFrame) -> PhysicsmechanicsrigidFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidFrame::copy(self : PhysicsmechanicsrigidFrame) -> PhysicsmechanicsrigidFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidFrame::fill(self : PhysicsmechanicsrigidFrame, v : Double) -> PhysicsmechanicsrigidFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidFrame::min(self : PhysicsmechanicsrigidFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidFrame::max(self : PhysicsmechanicsrigidFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidFrame::to_string(self : PhysicsmechanicsrigidFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_table_make(size : Int) -> PhysicsmechanicsrigidTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidTable::len(self : PhysicsmechanicsrigidTable) -> Int { self.size }

pub fn PhysicsmechanicsrigidTable::get(self : PhysicsmechanicsrigidTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidTable::set(self : PhysicsmechanicsrigidTable, i : Int, v : Double) -> PhysicsmechanicsrigidTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidTable::sum(self : PhysicsmechanicsrigidTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidTable::mean(self : PhysicsmechanicsrigidTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidTable::scale(self : PhysicsmechanicsrigidTable, f : Double) -> PhysicsmechanicsrigidTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidTable::add(self : PhysicsmechanicsrigidTable, other : PhysicsmechanicsrigidTable) -> PhysicsmechanicsrigidTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidTable::copy(self : PhysicsmechanicsrigidTable) -> PhysicsmechanicsrigidTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidTable::fill(self : PhysicsmechanicsrigidTable, v : Double) -> PhysicsmechanicsrigidTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidTable::min(self : PhysicsmechanicsrigidTable) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidTable::max(self : PhysicsmechanicsrigidTable) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidTable::to_string(self : PhysicsmechanicsrigidTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_graphn_make(size : Int) -> PhysicsmechanicsrigidGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidGraphN::len(self : PhysicsmechanicsrigidGraphN) -> Int { self.size }

pub fn PhysicsmechanicsrigidGraphN::get(self : PhysicsmechanicsrigidGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidGraphN::set(self : PhysicsmechanicsrigidGraphN, i : Int, v : Double) -> PhysicsmechanicsrigidGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidGraphN::sum(self : PhysicsmechanicsrigidGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidGraphN::mean(self : PhysicsmechanicsrigidGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidGraphN::scale(self : PhysicsmechanicsrigidGraphN, f : Double) -> PhysicsmechanicsrigidGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidGraphN::add(self : PhysicsmechanicsrigidGraphN, other : PhysicsmechanicsrigidGraphN) -> PhysicsmechanicsrigidGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidGraphN::copy(self : PhysicsmechanicsrigidGraphN) -> PhysicsmechanicsrigidGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidGraphN::fill(self : PhysicsmechanicsrigidGraphN, v : Double) -> PhysicsmechanicsrigidGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidGraphN::min(self : PhysicsmechanicsrigidGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidGraphN::max(self : PhysicsmechanicsrigidGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidGraphN::to_string(self : PhysicsmechanicsrigidGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_node_make(size : Int) -> PhysicsmechanicsrigidNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidNode::len(self : PhysicsmechanicsrigidNode) -> Int { self.size }

pub fn PhysicsmechanicsrigidNode::get(self : PhysicsmechanicsrigidNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidNode::set(self : PhysicsmechanicsrigidNode, i : Int, v : Double) -> PhysicsmechanicsrigidNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidNode::sum(self : PhysicsmechanicsrigidNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidNode::mean(self : PhysicsmechanicsrigidNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidNode::scale(self : PhysicsmechanicsrigidNode, f : Double) -> PhysicsmechanicsrigidNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidNode::add(self : PhysicsmechanicsrigidNode, other : PhysicsmechanicsrigidNode) -> PhysicsmechanicsrigidNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidNode::copy(self : PhysicsmechanicsrigidNode) -> PhysicsmechanicsrigidNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidNode::fill(self : PhysicsmechanicsrigidNode, v : Double) -> PhysicsmechanicsrigidNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidNode::min(self : PhysicsmechanicsrigidNode) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidNode::max(self : PhysicsmechanicsrigidNode) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidNode::to_string(self : PhysicsmechanicsrigidNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_edge_make(size : Int) -> PhysicsmechanicsrigidEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidEdge::len(self : PhysicsmechanicsrigidEdge) -> Int { self.size }

pub fn PhysicsmechanicsrigidEdge::get(self : PhysicsmechanicsrigidEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidEdge::set(self : PhysicsmechanicsrigidEdge, i : Int, v : Double) -> PhysicsmechanicsrigidEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidEdge::sum(self : PhysicsmechanicsrigidEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidEdge::mean(self : PhysicsmechanicsrigidEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidEdge::scale(self : PhysicsmechanicsrigidEdge, f : Double) -> PhysicsmechanicsrigidEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidEdge::add(self : PhysicsmechanicsrigidEdge, other : PhysicsmechanicsrigidEdge) -> PhysicsmechanicsrigidEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidEdge::copy(self : PhysicsmechanicsrigidEdge) -> PhysicsmechanicsrigidEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidEdge::fill(self : PhysicsmechanicsrigidEdge, v : Double) -> PhysicsmechanicsrigidEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidEdge::min(self : PhysicsmechanicsrigidEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidEdge::max(self : PhysicsmechanicsrigidEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidEdge::to_string(self : PhysicsmechanicsrigidEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_path_make(size : Int) -> PhysicsmechanicsrigidPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidPath::len(self : PhysicsmechanicsrigidPath) -> Int { self.size }

pub fn PhysicsmechanicsrigidPath::get(self : PhysicsmechanicsrigidPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidPath::set(self : PhysicsmechanicsrigidPath, i : Int, v : Double) -> PhysicsmechanicsrigidPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidPath::sum(self : PhysicsmechanicsrigidPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidPath::mean(self : PhysicsmechanicsrigidPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidPath::scale(self : PhysicsmechanicsrigidPath, f : Double) -> PhysicsmechanicsrigidPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidPath::add(self : PhysicsmechanicsrigidPath, other : PhysicsmechanicsrigidPath) -> PhysicsmechanicsrigidPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidPath::copy(self : PhysicsmechanicsrigidPath) -> PhysicsmechanicsrigidPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidPath::fill(self : PhysicsmechanicsrigidPath, v : Double) -> PhysicsmechanicsrigidPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidPath::min(self : PhysicsmechanicsrigidPath) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidPath::max(self : PhysicsmechanicsrigidPath) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidPath::to_string(self : PhysicsmechanicsrigidPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_cluster_make(size : Int) -> PhysicsmechanicsrigidCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidCluster::len(self : PhysicsmechanicsrigidCluster) -> Int { self.size }

pub fn PhysicsmechanicsrigidCluster::get(self : PhysicsmechanicsrigidCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidCluster::set(self : PhysicsmechanicsrigidCluster, i : Int, v : Double) -> PhysicsmechanicsrigidCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidCluster::sum(self : PhysicsmechanicsrigidCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidCluster::mean(self : PhysicsmechanicsrigidCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidCluster::scale(self : PhysicsmechanicsrigidCluster, f : Double) -> PhysicsmechanicsrigidCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidCluster::add(self : PhysicsmechanicsrigidCluster, other : PhysicsmechanicsrigidCluster) -> PhysicsmechanicsrigidCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidCluster::copy(self : PhysicsmechanicsrigidCluster) -> PhysicsmechanicsrigidCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidCluster::fill(self : PhysicsmechanicsrigidCluster, v : Double) -> PhysicsmechanicsrigidCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidCluster::min(self : PhysicsmechanicsrigidCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidCluster::max(self : PhysicsmechanicsrigidCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidCluster::to_string(self : PhysicsmechanicsrigidCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_model_make(size : Int) -> PhysicsmechanicsrigidModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidModel::len(self : PhysicsmechanicsrigidModel) -> Int { self.size }

pub fn PhysicsmechanicsrigidModel::get(self : PhysicsmechanicsrigidModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidModel::set(self : PhysicsmechanicsrigidModel, i : Int, v : Double) -> PhysicsmechanicsrigidModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidModel::sum(self : PhysicsmechanicsrigidModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidModel::mean(self : PhysicsmechanicsrigidModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidModel::scale(self : PhysicsmechanicsrigidModel, f : Double) -> PhysicsmechanicsrigidModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidModel::add(self : PhysicsmechanicsrigidModel, other : PhysicsmechanicsrigidModel) -> PhysicsmechanicsrigidModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidModel::copy(self : PhysicsmechanicsrigidModel) -> PhysicsmechanicsrigidModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidModel::fill(self : PhysicsmechanicsrigidModel, v : Double) -> PhysicsmechanicsrigidModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidModel::min(self : PhysicsmechanicsrigidModel) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidModel::max(self : PhysicsmechanicsrigidModel) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidModel::to_string(self : PhysicsmechanicsrigidModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_layer_make(size : Int) -> PhysicsmechanicsrigidLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidLayer::len(self : PhysicsmechanicsrigidLayer) -> Int { self.size }

pub fn PhysicsmechanicsrigidLayer::get(self : PhysicsmechanicsrigidLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidLayer::set(self : PhysicsmechanicsrigidLayer, i : Int, v : Double) -> PhysicsmechanicsrigidLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidLayer::sum(self : PhysicsmechanicsrigidLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidLayer::mean(self : PhysicsmechanicsrigidLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidLayer::scale(self : PhysicsmechanicsrigidLayer, f : Double) -> PhysicsmechanicsrigidLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidLayer::add(self : PhysicsmechanicsrigidLayer, other : PhysicsmechanicsrigidLayer) -> PhysicsmechanicsrigidLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidLayer::copy(self : PhysicsmechanicsrigidLayer) -> PhysicsmechanicsrigidLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidLayer::fill(self : PhysicsmechanicsrigidLayer, v : Double) -> PhysicsmechanicsrigidLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidLayer::min(self : PhysicsmechanicsrigidLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidLayer::max(self : PhysicsmechanicsrigidLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidLayer::to_string(self : PhysicsmechanicsrigidLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_buffer_make(size : Int) -> PhysicsmechanicsrigidBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidBuffer::len(self : PhysicsmechanicsrigidBuffer) -> Int { self.size }

pub fn PhysicsmechanicsrigidBuffer::get(self : PhysicsmechanicsrigidBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidBuffer::set(self : PhysicsmechanicsrigidBuffer, i : Int, v : Double) -> PhysicsmechanicsrigidBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidBuffer::sum(self : PhysicsmechanicsrigidBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidBuffer::mean(self : PhysicsmechanicsrigidBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidBuffer::scale(self : PhysicsmechanicsrigidBuffer, f : Double) -> PhysicsmechanicsrigidBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidBuffer::add(self : PhysicsmechanicsrigidBuffer, other : PhysicsmechanicsrigidBuffer) -> PhysicsmechanicsrigidBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidBuffer::copy(self : PhysicsmechanicsrigidBuffer) -> PhysicsmechanicsrigidBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidBuffer::fill(self : PhysicsmechanicsrigidBuffer, v : Double) -> PhysicsmechanicsrigidBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidBuffer::min(self : PhysicsmechanicsrigidBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidBuffer::max(self : PhysicsmechanicsrigidBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidBuffer::to_string(self : PhysicsmechanicsrigidBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_cursor_make(size : Int) -> PhysicsmechanicsrigidCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidCursor::len(self : PhysicsmechanicsrigidCursor) -> Int { self.size }

pub fn PhysicsmechanicsrigidCursor::get(self : PhysicsmechanicsrigidCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidCursor::set(self : PhysicsmechanicsrigidCursor, i : Int, v : Double) -> PhysicsmechanicsrigidCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidCursor::sum(self : PhysicsmechanicsrigidCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidCursor::mean(self : PhysicsmechanicsrigidCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidCursor::scale(self : PhysicsmechanicsrigidCursor, f : Double) -> PhysicsmechanicsrigidCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidCursor::add(self : PhysicsmechanicsrigidCursor, other : PhysicsmechanicsrigidCursor) -> PhysicsmechanicsrigidCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidCursor::copy(self : PhysicsmechanicsrigidCursor) -> PhysicsmechanicsrigidCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidCursor::fill(self : PhysicsmechanicsrigidCursor, v : Double) -> PhysicsmechanicsrigidCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidCursor::min(self : PhysicsmechanicsrigidCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidCursor::max(self : PhysicsmechanicsrigidCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidCursor::to_string(self : PhysicsmechanicsrigidCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_view_make(size : Int) -> PhysicsmechanicsrigidView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidView::len(self : PhysicsmechanicsrigidView) -> Int { self.size }

pub fn PhysicsmechanicsrigidView::get(self : PhysicsmechanicsrigidView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidView::set(self : PhysicsmechanicsrigidView, i : Int, v : Double) -> PhysicsmechanicsrigidView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidView::sum(self : PhysicsmechanicsrigidView) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidView::mean(self : PhysicsmechanicsrigidView) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidView::scale(self : PhysicsmechanicsrigidView, f : Double) -> PhysicsmechanicsrigidView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidView::add(self : PhysicsmechanicsrigidView, other : PhysicsmechanicsrigidView) -> PhysicsmechanicsrigidView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidView::copy(self : PhysicsmechanicsrigidView) -> PhysicsmechanicsrigidView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidView::fill(self : PhysicsmechanicsrigidView, v : Double) -> PhysicsmechanicsrigidView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidView::min(self : PhysicsmechanicsrigidView) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidView::max(self : PhysicsmechanicsrigidView) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidView::to_string(self : PhysicsmechanicsrigidView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_range_make(size : Int) -> PhysicsmechanicsrigidRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidRange::len(self : PhysicsmechanicsrigidRange) -> Int { self.size }

pub fn PhysicsmechanicsrigidRange::get(self : PhysicsmechanicsrigidRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidRange::set(self : PhysicsmechanicsrigidRange, i : Int, v : Double) -> PhysicsmechanicsrigidRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidRange::sum(self : PhysicsmechanicsrigidRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidRange::mean(self : PhysicsmechanicsrigidRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidRange::scale(self : PhysicsmechanicsrigidRange, f : Double) -> PhysicsmechanicsrigidRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidRange::add(self : PhysicsmechanicsrigidRange, other : PhysicsmechanicsrigidRange) -> PhysicsmechanicsrigidRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidRange::copy(self : PhysicsmechanicsrigidRange) -> PhysicsmechanicsrigidRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidRange::fill(self : PhysicsmechanicsrigidRange, v : Double) -> PhysicsmechanicsrigidRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidRange::min(self : PhysicsmechanicsrigidRange) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidRange::max(self : PhysicsmechanicsrigidRange) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidRange::to_string(self : PhysicsmechanicsrigidRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_slice_make(size : Int) -> PhysicsmechanicsrigidSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsrigidSlice::len(self : PhysicsmechanicsrigidSlice) -> Int { self.size }

pub fn PhysicsmechanicsrigidSlice::get(self : PhysicsmechanicsrigidSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsrigidSlice::set(self : PhysicsmechanicsrigidSlice, i : Int, v : Double) -> PhysicsmechanicsrigidSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidSlice::sum(self : PhysicsmechanicsrigidSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsrigidSlice::mean(self : PhysicsmechanicsrigidSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsrigidSlice::scale(self : PhysicsmechanicsrigidSlice, f : Double) -> PhysicsmechanicsrigidSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidSlice::add(self : PhysicsmechanicsrigidSlice, other : PhysicsmechanicsrigidSlice) -> PhysicsmechanicsrigidSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsrigidSlice::copy(self : PhysicsmechanicsrigidSlice) -> PhysicsmechanicsrigidSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidSlice::fill(self : PhysicsmechanicsrigidSlice, v : Double) -> PhysicsmechanicsrigidSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsrigidSlice::min(self : PhysicsmechanicsrigidSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsrigidSlice::max(self : PhysicsmechanicsrigidSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsrigidSlice::to_string(self : PhysicsmechanicsrigidSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

