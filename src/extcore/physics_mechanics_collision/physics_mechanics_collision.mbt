///===
/// extcore/physics_mechanics_collision

pub(all) struct PhysicsmechanicscollisionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_collision_make_point(x : Double, y : Double) -> PhysicsmechanicscollisionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_collision_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicscollisionPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicscollisionPoint::x(self : PhysicsmechanicscollisionPoint) -> Double { self.x }

pub fn PhysicsmechanicscollisionPoint::y(self : PhysicsmechanicscollisionPoint) -> Double { self.y }

pub fn PhysicsmechanicscollisionPoint::z(self : PhysicsmechanicscollisionPoint) -> Double { self.z }

pub fn PhysicsmechanicscollisionPoint::label(self : PhysicsmechanicscollisionPoint) -> Int { self.label }

pub fn PhysicsmechanicscollisionPoint::dist(self : PhysicsmechanicscollisionPoint, other : PhysicsmechanicscollisionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicscollisionPoint::add(self : PhysicsmechanicscollisionPoint, other : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicscollisionPoint::sub(self : PhysicsmechanicscollisionPoint, other : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicscollisionPoint::scale(self : PhysicsmechanicscollisionPoint, s : Double) -> PhysicsmechanicscollisionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicscollisionPoint::dot(self : PhysicsmechanicscollisionPoint, other : PhysicsmechanicscollisionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicscollisionPoint::cross(self : PhysicsmechanicscollisionPoint, other : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicscollisionPoint::norm(self : PhysicsmechanicscollisionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicscollisionPoint::normalize(self : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicscollisionPoint::negate(self : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicscollisionPoint::mid(self : PhysicsmechanicscollisionPoint, other : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicscollisionPoint::lerp(self : PhysicsmechanicscollisionPoint, other : PhysicsmechanicscollisionPoint, t : Double) -> PhysicsmechanicscollisionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicscollisionPoint::to_string(self : PhysicsmechanicscollisionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_collision_make_series(vals : Array[Double], name : String) -> PhysicsmechanicscollisionSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicscollisionSeries::len(self : PhysicsmechanicscollisionSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicscollisionSeries::sum(self : PhysicsmechanicscollisionSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicscollisionSeries::mean(self : PhysicsmechanicscollisionSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicscollisionSeries::min(self : PhysicsmechanicscollisionSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicscollisionSeries::max(self : PhysicsmechanicscollisionSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicscollisionSeries::range(self : PhysicsmechanicscollisionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicscollisionSeries::variance(self : PhysicsmechanicscollisionSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicscollisionSeries::std(self : PhysicsmechanicscollisionSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicscollisionSeries::median(self : PhysicsmechanicscollisionSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicscollisionSeries::scale(self : PhysicsmechanicscollisionSeries, f : Double) -> PhysicsmechanicscollisionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicscollisionSeries::add(self : PhysicsmechanicscollisionSeries, other : PhysicsmechanicscollisionSeries) -> PhysicsmechanicscollisionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicscollisionSeries::sub(self : PhysicsmechanicscollisionSeries, other : PhysicsmechanicscollisionSeries) -> PhysicsmechanicscollisionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicscollisionSeries::normalize(self : PhysicsmechanicscollisionSeries) -> PhysicsmechanicscollisionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicscollisionSeries::cumsum(self : PhysicsmechanicscollisionSeries) -> PhysicsmechanicscollisionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicscollisionSeries::to_string(self : PhysicsmechanicscollisionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicscollisionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_collision_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicscollisionMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn physics_mechanics_collision_matrix_identity(n : Int) -> PhysicsmechanicscollisionMatrix {
  let m = physics_mechanics_collision_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicscollisionMatrix::get(self : PhysicsmechanicscollisionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicscollisionMatrix::transpose(self : PhysicsmechanicscollisionMatrix) -> PhysicsmechanicscollisionMatrix {
  let result = physics_mechanics_collision_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicscollisionMatrix::add(self : PhysicsmechanicscollisionMatrix, other : PhysicsmechanicscollisionMatrix) -> PhysicsmechanicscollisionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_collision_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicscollisionMatrix::scale(self : PhysicsmechanicscollisionMatrix, s : Double) -> PhysicsmechanicscollisionMatrix {
  let result = physics_mechanics_collision_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicscollisionMatrix::multiply(self : PhysicsmechanicscollisionMatrix, other : PhysicsmechanicscollisionMatrix) -> PhysicsmechanicscollisionMatrix {
  if self.cols != other.rows { return physics_mechanics_collision_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_collision_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsmechanicscollisionMatrix::trace(self : PhysicsmechanicscollisionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicscollisionMatrix::det(self : PhysicsmechanicscollisionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicscollisionMatrix::norm(self : PhysicsmechanicscollisionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicscollisionMatrix::to_string(self : PhysicsmechanicscollisionMatrix) -> String {
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

pub(all) struct PhysicsmechanicscollisionVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_collision_make_vector(comps : Array[Double]) -> PhysicsmechanicscollisionVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_collision_vector_zero(dim : Int) -> PhysicsmechanicscollisionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicscollisionVector::add(self : PhysicsmechanicscollisionVector, other : PhysicsmechanicscollisionVector) -> PhysicsmechanicscollisionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicscollisionVector::sub(self : PhysicsmechanicscollisionVector, other : PhysicsmechanicscollisionVector) -> PhysicsmechanicscollisionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicscollisionVector::scale(self : PhysicsmechanicscollisionVector, s : Double) -> PhysicsmechanicscollisionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicscollisionVector::dot(self : PhysicsmechanicscollisionVector, other : PhysicsmechanicscollisionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicscollisionVector::norm(self : PhysicsmechanicscollisionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicscollisionVector::normalize(self : PhysicsmechanicscollisionVector) -> PhysicsmechanicscollisionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicscollisionVector::dist(self : PhysicsmechanicscollisionVector, other : PhysicsmechanicscollisionVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicscollisionVector::to_string(self : PhysicsmechanicscollisionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicscollisionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_frame_make(size : Int) -> PhysicsmechanicscollisionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionFrame::len(self : PhysicsmechanicscollisionFrame) -> Int { self.size }

pub fn PhysicsmechanicscollisionFrame::get(self : PhysicsmechanicscollisionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionFrame::set(self : PhysicsmechanicscollisionFrame, i : Int, v : Double) -> PhysicsmechanicscollisionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionFrame::sum(self : PhysicsmechanicscollisionFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionFrame::mean(self : PhysicsmechanicscollisionFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionFrame::scale(self : PhysicsmechanicscollisionFrame, f : Double) -> PhysicsmechanicscollisionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionFrame::add(self : PhysicsmechanicscollisionFrame, other : PhysicsmechanicscollisionFrame) -> PhysicsmechanicscollisionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionFrame::copy(self : PhysicsmechanicscollisionFrame) -> PhysicsmechanicscollisionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionFrame::fill(self : PhysicsmechanicscollisionFrame, v : Double) -> PhysicsmechanicscollisionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionFrame::min(self : PhysicsmechanicscollisionFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionFrame::max(self : PhysicsmechanicscollisionFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionFrame::to_string(self : PhysicsmechanicscollisionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_table_make(size : Int) -> PhysicsmechanicscollisionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionTable::len(self : PhysicsmechanicscollisionTable) -> Int { self.size }

pub fn PhysicsmechanicscollisionTable::get(self : PhysicsmechanicscollisionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionTable::set(self : PhysicsmechanicscollisionTable, i : Int, v : Double) -> PhysicsmechanicscollisionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionTable::sum(self : PhysicsmechanicscollisionTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionTable::mean(self : PhysicsmechanicscollisionTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionTable::scale(self : PhysicsmechanicscollisionTable, f : Double) -> PhysicsmechanicscollisionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionTable::add(self : PhysicsmechanicscollisionTable, other : PhysicsmechanicscollisionTable) -> PhysicsmechanicscollisionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionTable::copy(self : PhysicsmechanicscollisionTable) -> PhysicsmechanicscollisionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionTable::fill(self : PhysicsmechanicscollisionTable, v : Double) -> PhysicsmechanicscollisionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionTable::min(self : PhysicsmechanicscollisionTable) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionTable::max(self : PhysicsmechanicscollisionTable) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionTable::to_string(self : PhysicsmechanicscollisionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_graphn_make(size : Int) -> PhysicsmechanicscollisionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionGraphN::len(self : PhysicsmechanicscollisionGraphN) -> Int { self.size }

pub fn PhysicsmechanicscollisionGraphN::get(self : PhysicsmechanicscollisionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionGraphN::set(self : PhysicsmechanicscollisionGraphN, i : Int, v : Double) -> PhysicsmechanicscollisionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionGraphN::sum(self : PhysicsmechanicscollisionGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionGraphN::mean(self : PhysicsmechanicscollisionGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionGraphN::scale(self : PhysicsmechanicscollisionGraphN, f : Double) -> PhysicsmechanicscollisionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionGraphN::add(self : PhysicsmechanicscollisionGraphN, other : PhysicsmechanicscollisionGraphN) -> PhysicsmechanicscollisionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionGraphN::copy(self : PhysicsmechanicscollisionGraphN) -> PhysicsmechanicscollisionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionGraphN::fill(self : PhysicsmechanicscollisionGraphN, v : Double) -> PhysicsmechanicscollisionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionGraphN::min(self : PhysicsmechanicscollisionGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionGraphN::max(self : PhysicsmechanicscollisionGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionGraphN::to_string(self : PhysicsmechanicscollisionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_node_make(size : Int) -> PhysicsmechanicscollisionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionNode::len(self : PhysicsmechanicscollisionNode) -> Int { self.size }

pub fn PhysicsmechanicscollisionNode::get(self : PhysicsmechanicscollisionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionNode::set(self : PhysicsmechanicscollisionNode, i : Int, v : Double) -> PhysicsmechanicscollisionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionNode::sum(self : PhysicsmechanicscollisionNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionNode::mean(self : PhysicsmechanicscollisionNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionNode::scale(self : PhysicsmechanicscollisionNode, f : Double) -> PhysicsmechanicscollisionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionNode::add(self : PhysicsmechanicscollisionNode, other : PhysicsmechanicscollisionNode) -> PhysicsmechanicscollisionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionNode::copy(self : PhysicsmechanicscollisionNode) -> PhysicsmechanicscollisionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionNode::fill(self : PhysicsmechanicscollisionNode, v : Double) -> PhysicsmechanicscollisionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionNode::min(self : PhysicsmechanicscollisionNode) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionNode::max(self : PhysicsmechanicscollisionNode) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionNode::to_string(self : PhysicsmechanicscollisionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_edge_make(size : Int) -> PhysicsmechanicscollisionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionEdge::len(self : PhysicsmechanicscollisionEdge) -> Int { self.size }

pub fn PhysicsmechanicscollisionEdge::get(self : PhysicsmechanicscollisionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionEdge::set(self : PhysicsmechanicscollisionEdge, i : Int, v : Double) -> PhysicsmechanicscollisionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionEdge::sum(self : PhysicsmechanicscollisionEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionEdge::mean(self : PhysicsmechanicscollisionEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionEdge::scale(self : PhysicsmechanicscollisionEdge, f : Double) -> PhysicsmechanicscollisionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionEdge::add(self : PhysicsmechanicscollisionEdge, other : PhysicsmechanicscollisionEdge) -> PhysicsmechanicscollisionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionEdge::copy(self : PhysicsmechanicscollisionEdge) -> PhysicsmechanicscollisionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionEdge::fill(self : PhysicsmechanicscollisionEdge, v : Double) -> PhysicsmechanicscollisionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionEdge::min(self : PhysicsmechanicscollisionEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionEdge::max(self : PhysicsmechanicscollisionEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionEdge::to_string(self : PhysicsmechanicscollisionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_path_make(size : Int) -> PhysicsmechanicscollisionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionPath::len(self : PhysicsmechanicscollisionPath) -> Int { self.size }

pub fn PhysicsmechanicscollisionPath::get(self : PhysicsmechanicscollisionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionPath::set(self : PhysicsmechanicscollisionPath, i : Int, v : Double) -> PhysicsmechanicscollisionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionPath::sum(self : PhysicsmechanicscollisionPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionPath::mean(self : PhysicsmechanicscollisionPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionPath::scale(self : PhysicsmechanicscollisionPath, f : Double) -> PhysicsmechanicscollisionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionPath::add(self : PhysicsmechanicscollisionPath, other : PhysicsmechanicscollisionPath) -> PhysicsmechanicscollisionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionPath::copy(self : PhysicsmechanicscollisionPath) -> PhysicsmechanicscollisionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionPath::fill(self : PhysicsmechanicscollisionPath, v : Double) -> PhysicsmechanicscollisionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionPath::min(self : PhysicsmechanicscollisionPath) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionPath::max(self : PhysicsmechanicscollisionPath) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionPath::to_string(self : PhysicsmechanicscollisionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_cluster_make(size : Int) -> PhysicsmechanicscollisionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionCluster::len(self : PhysicsmechanicscollisionCluster) -> Int { self.size }

pub fn PhysicsmechanicscollisionCluster::get(self : PhysicsmechanicscollisionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionCluster::set(self : PhysicsmechanicscollisionCluster, i : Int, v : Double) -> PhysicsmechanicscollisionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionCluster::sum(self : PhysicsmechanicscollisionCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionCluster::mean(self : PhysicsmechanicscollisionCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionCluster::scale(self : PhysicsmechanicscollisionCluster, f : Double) -> PhysicsmechanicscollisionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionCluster::add(self : PhysicsmechanicscollisionCluster, other : PhysicsmechanicscollisionCluster) -> PhysicsmechanicscollisionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionCluster::copy(self : PhysicsmechanicscollisionCluster) -> PhysicsmechanicscollisionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionCluster::fill(self : PhysicsmechanicscollisionCluster, v : Double) -> PhysicsmechanicscollisionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionCluster::min(self : PhysicsmechanicscollisionCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionCluster::max(self : PhysicsmechanicscollisionCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionCluster::to_string(self : PhysicsmechanicscollisionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_model_make(size : Int) -> PhysicsmechanicscollisionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionModel::len(self : PhysicsmechanicscollisionModel) -> Int { self.size }

pub fn PhysicsmechanicscollisionModel::get(self : PhysicsmechanicscollisionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionModel::set(self : PhysicsmechanicscollisionModel, i : Int, v : Double) -> PhysicsmechanicscollisionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionModel::sum(self : PhysicsmechanicscollisionModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionModel::mean(self : PhysicsmechanicscollisionModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionModel::scale(self : PhysicsmechanicscollisionModel, f : Double) -> PhysicsmechanicscollisionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionModel::add(self : PhysicsmechanicscollisionModel, other : PhysicsmechanicscollisionModel) -> PhysicsmechanicscollisionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionModel::copy(self : PhysicsmechanicscollisionModel) -> PhysicsmechanicscollisionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionModel::fill(self : PhysicsmechanicscollisionModel, v : Double) -> PhysicsmechanicscollisionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionModel::min(self : PhysicsmechanicscollisionModel) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionModel::max(self : PhysicsmechanicscollisionModel) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionModel::to_string(self : PhysicsmechanicscollisionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_layer_make(size : Int) -> PhysicsmechanicscollisionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionLayer::len(self : PhysicsmechanicscollisionLayer) -> Int { self.size }

pub fn PhysicsmechanicscollisionLayer::get(self : PhysicsmechanicscollisionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionLayer::set(self : PhysicsmechanicscollisionLayer, i : Int, v : Double) -> PhysicsmechanicscollisionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionLayer::sum(self : PhysicsmechanicscollisionLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionLayer::mean(self : PhysicsmechanicscollisionLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionLayer::scale(self : PhysicsmechanicscollisionLayer, f : Double) -> PhysicsmechanicscollisionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionLayer::add(self : PhysicsmechanicscollisionLayer, other : PhysicsmechanicscollisionLayer) -> PhysicsmechanicscollisionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionLayer::copy(self : PhysicsmechanicscollisionLayer) -> PhysicsmechanicscollisionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionLayer::fill(self : PhysicsmechanicscollisionLayer, v : Double) -> PhysicsmechanicscollisionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionLayer::min(self : PhysicsmechanicscollisionLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionLayer::max(self : PhysicsmechanicscollisionLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionLayer::to_string(self : PhysicsmechanicscollisionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_buffer_make(size : Int) -> PhysicsmechanicscollisionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionBuffer::len(self : PhysicsmechanicscollisionBuffer) -> Int { self.size }

pub fn PhysicsmechanicscollisionBuffer::get(self : PhysicsmechanicscollisionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionBuffer::set(self : PhysicsmechanicscollisionBuffer, i : Int, v : Double) -> PhysicsmechanicscollisionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionBuffer::sum(self : PhysicsmechanicscollisionBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionBuffer::mean(self : PhysicsmechanicscollisionBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionBuffer::scale(self : PhysicsmechanicscollisionBuffer, f : Double) -> PhysicsmechanicscollisionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionBuffer::add(self : PhysicsmechanicscollisionBuffer, other : PhysicsmechanicscollisionBuffer) -> PhysicsmechanicscollisionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionBuffer::copy(self : PhysicsmechanicscollisionBuffer) -> PhysicsmechanicscollisionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionBuffer::fill(self : PhysicsmechanicscollisionBuffer, v : Double) -> PhysicsmechanicscollisionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionBuffer::min(self : PhysicsmechanicscollisionBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionBuffer::max(self : PhysicsmechanicscollisionBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionBuffer::to_string(self : PhysicsmechanicscollisionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_cursor_make(size : Int) -> PhysicsmechanicscollisionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionCursor::len(self : PhysicsmechanicscollisionCursor) -> Int { self.size }

pub fn PhysicsmechanicscollisionCursor::get(self : PhysicsmechanicscollisionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionCursor::set(self : PhysicsmechanicscollisionCursor, i : Int, v : Double) -> PhysicsmechanicscollisionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionCursor::sum(self : PhysicsmechanicscollisionCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionCursor::mean(self : PhysicsmechanicscollisionCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionCursor::scale(self : PhysicsmechanicscollisionCursor, f : Double) -> PhysicsmechanicscollisionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionCursor::add(self : PhysicsmechanicscollisionCursor, other : PhysicsmechanicscollisionCursor) -> PhysicsmechanicscollisionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionCursor::copy(self : PhysicsmechanicscollisionCursor) -> PhysicsmechanicscollisionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionCursor::fill(self : PhysicsmechanicscollisionCursor, v : Double) -> PhysicsmechanicscollisionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionCursor::min(self : PhysicsmechanicscollisionCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionCursor::max(self : PhysicsmechanicscollisionCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionCursor::to_string(self : PhysicsmechanicscollisionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_view_make(size : Int) -> PhysicsmechanicscollisionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionView::len(self : PhysicsmechanicscollisionView) -> Int { self.size }

pub fn PhysicsmechanicscollisionView::get(self : PhysicsmechanicscollisionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionView::set(self : PhysicsmechanicscollisionView, i : Int, v : Double) -> PhysicsmechanicscollisionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionView::sum(self : PhysicsmechanicscollisionView) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionView::mean(self : PhysicsmechanicscollisionView) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionView::scale(self : PhysicsmechanicscollisionView, f : Double) -> PhysicsmechanicscollisionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionView::add(self : PhysicsmechanicscollisionView, other : PhysicsmechanicscollisionView) -> PhysicsmechanicscollisionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionView::copy(self : PhysicsmechanicscollisionView) -> PhysicsmechanicscollisionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionView::fill(self : PhysicsmechanicscollisionView, v : Double) -> PhysicsmechanicscollisionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionView::min(self : PhysicsmechanicscollisionView) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionView::max(self : PhysicsmechanicscollisionView) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionView::to_string(self : PhysicsmechanicscollisionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_range_make(size : Int) -> PhysicsmechanicscollisionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionRange::len(self : PhysicsmechanicscollisionRange) -> Int { self.size }

pub fn PhysicsmechanicscollisionRange::get(self : PhysicsmechanicscollisionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionRange::set(self : PhysicsmechanicscollisionRange, i : Int, v : Double) -> PhysicsmechanicscollisionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionRange::sum(self : PhysicsmechanicscollisionRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionRange::mean(self : PhysicsmechanicscollisionRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionRange::scale(self : PhysicsmechanicscollisionRange, f : Double) -> PhysicsmechanicscollisionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionRange::add(self : PhysicsmechanicscollisionRange, other : PhysicsmechanicscollisionRange) -> PhysicsmechanicscollisionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionRange::copy(self : PhysicsmechanicscollisionRange) -> PhysicsmechanicscollisionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionRange::fill(self : PhysicsmechanicscollisionRange, v : Double) -> PhysicsmechanicscollisionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionRange::min(self : PhysicsmechanicscollisionRange) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionRange::max(self : PhysicsmechanicscollisionRange) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionRange::to_string(self : PhysicsmechanicscollisionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_slice_make(size : Int) -> PhysicsmechanicscollisionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicscollisionSlice::len(self : PhysicsmechanicscollisionSlice) -> Int { self.size }

pub fn PhysicsmechanicscollisionSlice::get(self : PhysicsmechanicscollisionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicscollisionSlice::set(self : PhysicsmechanicscollisionSlice, i : Int, v : Double) -> PhysicsmechanicscollisionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionSlice::sum(self : PhysicsmechanicscollisionSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicscollisionSlice::mean(self : PhysicsmechanicscollisionSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicscollisionSlice::scale(self : PhysicsmechanicscollisionSlice, f : Double) -> PhysicsmechanicscollisionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionSlice::add(self : PhysicsmechanicscollisionSlice, other : PhysicsmechanicscollisionSlice) -> PhysicsmechanicscollisionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicscollisionSlice::copy(self : PhysicsmechanicscollisionSlice) -> PhysicsmechanicscollisionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionSlice::fill(self : PhysicsmechanicscollisionSlice, v : Double) -> PhysicsmechanicscollisionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicscollisionSlice::min(self : PhysicsmechanicscollisionSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicscollisionSlice::max(self : PhysicsmechanicscollisionSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicscollisionSlice::to_string(self : PhysicsmechanicscollisionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

