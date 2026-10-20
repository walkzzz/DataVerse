///===
/// extcore/physics_mechanics_force

pub(all) struct PhysicsmechanicsforcePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_force_make_point(x : Double, y : Double) -> PhysicsmechanicsforcePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_force_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsforcePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicsforcePoint::x(self : PhysicsmechanicsforcePoint) -> Double { self.x }

pub fn PhysicsmechanicsforcePoint::y(self : PhysicsmechanicsforcePoint) -> Double { self.y }

pub fn PhysicsmechanicsforcePoint::z(self : PhysicsmechanicsforcePoint) -> Double { self.z }

pub fn PhysicsmechanicsforcePoint::label(self : PhysicsmechanicsforcePoint) -> Int { self.label }

pub fn PhysicsmechanicsforcePoint::dist(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicsforcePoint::add(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::sub(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::scale(self : PhysicsmechanicsforcePoint, s : Double) -> PhysicsmechanicsforcePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::dot(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicsforcePoint::cross(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicsforcePoint::norm(self : PhysicsmechanicsforcePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicsforcePoint::normalize(self : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsforcePoint::negate(self : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::mid(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::lerp(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint, t : Double) -> PhysicsmechanicsforcePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::to_string(self : PhysicsmechanicsforcePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_force_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsforceSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicsforceSeries::len(self : PhysicsmechanicsforceSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicsforceSeries::sum(self : PhysicsmechanicsforceSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicsforceSeries::mean(self : PhysicsmechanicsforceSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicsforceSeries::min(self : PhysicsmechanicsforceSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicsforceSeries::max(self : PhysicsmechanicsforceSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicsforceSeries::range(self : PhysicsmechanicsforceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicsforceSeries::variance(self : PhysicsmechanicsforceSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicsforceSeries::std(self : PhysicsmechanicsforceSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicsforceSeries::median(self : PhysicsmechanicsforceSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicsforceSeries::scale(self : PhysicsmechanicsforceSeries, f : Double) -> PhysicsmechanicsforceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicsforceSeries::add(self : PhysicsmechanicsforceSeries, other : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsforceSeries::sub(self : PhysicsmechanicsforceSeries, other : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsforceSeries::normalize(self : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicsforceSeries::cumsum(self : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicsforceSeries::to_string(self : PhysicsmechanicsforceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsforceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_force_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsforceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_force_matrix_identity(n : Int) -> PhysicsmechanicsforceMatrix {
  let m = physics_mechanics_force_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicsforceMatrix::get(self : PhysicsmechanicsforceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicsforceMatrix::transpose(self : PhysicsmechanicsforceMatrix) -> PhysicsmechanicsforceMatrix {
  let result = physics_mechanics_force_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicsforceMatrix::add(self : PhysicsmechanicsforceMatrix, other : PhysicsmechanicsforceMatrix) -> PhysicsmechanicsforceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_force_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicsforceMatrix::scale(self : PhysicsmechanicsforceMatrix, s : Double) -> PhysicsmechanicsforceMatrix {
  let result = physics_mechanics_force_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicsforceMatrix::multiply(self : PhysicsmechanicsforceMatrix, other : PhysicsmechanicsforceMatrix) -> PhysicsmechanicsforceMatrix {
  if self.cols != other.rows { return physics_mechanics_force_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_force_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsmechanicsforceMatrix::trace(self : PhysicsmechanicsforceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicsforceMatrix::det(self : PhysicsmechanicsforceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicsforceMatrix::norm(self : PhysicsmechanicsforceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicsforceMatrix::to_string(self : PhysicsmechanicsforceMatrix) -> String {
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

pub(all) struct PhysicsmechanicsforceVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_force_make_vector(comps : Array[Double]) -> PhysicsmechanicsforceVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_force_vector_zero(dim : Int) -> PhysicsmechanicsforceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicsforceVector::add(self : PhysicsmechanicsforceVector, other : PhysicsmechanicsforceVector) -> PhysicsmechanicsforceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsforceVector::sub(self : PhysicsmechanicsforceVector, other : PhysicsmechanicsforceVector) -> PhysicsmechanicsforceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsforceVector::scale(self : PhysicsmechanicsforceVector, s : Double) -> PhysicsmechanicsforceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicsforceVector::dot(self : PhysicsmechanicsforceVector, other : PhysicsmechanicsforceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicsforceVector::norm(self : PhysicsmechanicsforceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicsforceVector::normalize(self : PhysicsmechanicsforceVector) -> PhysicsmechanicsforceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsforceVector::dist(self : PhysicsmechanicsforceVector, other : PhysicsmechanicsforceVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicsforceVector::to_string(self : PhysicsmechanicsforceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsforceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_frame_make(size : Int) -> PhysicsmechanicsforceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceFrame::len(self : PhysicsmechanicsforceFrame) -> Int { self.size }

pub fn PhysicsmechanicsforceFrame::get(self : PhysicsmechanicsforceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceFrame::set(self : PhysicsmechanicsforceFrame, i : Int, v : Double) -> PhysicsmechanicsforceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceFrame::sum(self : PhysicsmechanicsforceFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceFrame::mean(self : PhysicsmechanicsforceFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceFrame::scale(self : PhysicsmechanicsforceFrame, f : Double) -> PhysicsmechanicsforceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceFrame::add(self : PhysicsmechanicsforceFrame, other : PhysicsmechanicsforceFrame) -> PhysicsmechanicsforceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceFrame::copy(self : PhysicsmechanicsforceFrame) -> PhysicsmechanicsforceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceFrame::fill(self : PhysicsmechanicsforceFrame, v : Double) -> PhysicsmechanicsforceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceFrame::min(self : PhysicsmechanicsforceFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceFrame::max(self : PhysicsmechanicsforceFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceFrame::to_string(self : PhysicsmechanicsforceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_table_make(size : Int) -> PhysicsmechanicsforceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceTable::len(self : PhysicsmechanicsforceTable) -> Int { self.size }

pub fn PhysicsmechanicsforceTable::get(self : PhysicsmechanicsforceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceTable::set(self : PhysicsmechanicsforceTable, i : Int, v : Double) -> PhysicsmechanicsforceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceTable::sum(self : PhysicsmechanicsforceTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceTable::mean(self : PhysicsmechanicsforceTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceTable::scale(self : PhysicsmechanicsforceTable, f : Double) -> PhysicsmechanicsforceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceTable::add(self : PhysicsmechanicsforceTable, other : PhysicsmechanicsforceTable) -> PhysicsmechanicsforceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceTable::copy(self : PhysicsmechanicsforceTable) -> PhysicsmechanicsforceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceTable::fill(self : PhysicsmechanicsforceTable, v : Double) -> PhysicsmechanicsforceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceTable::min(self : PhysicsmechanicsforceTable) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceTable::max(self : PhysicsmechanicsforceTable) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceTable::to_string(self : PhysicsmechanicsforceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_graphn_make(size : Int) -> PhysicsmechanicsforceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceGraphN::len(self : PhysicsmechanicsforceGraphN) -> Int { self.size }

pub fn PhysicsmechanicsforceGraphN::get(self : PhysicsmechanicsforceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceGraphN::set(self : PhysicsmechanicsforceGraphN, i : Int, v : Double) -> PhysicsmechanicsforceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceGraphN::sum(self : PhysicsmechanicsforceGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceGraphN::mean(self : PhysicsmechanicsforceGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceGraphN::scale(self : PhysicsmechanicsforceGraphN, f : Double) -> PhysicsmechanicsforceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceGraphN::add(self : PhysicsmechanicsforceGraphN, other : PhysicsmechanicsforceGraphN) -> PhysicsmechanicsforceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceGraphN::copy(self : PhysicsmechanicsforceGraphN) -> PhysicsmechanicsforceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceGraphN::fill(self : PhysicsmechanicsforceGraphN, v : Double) -> PhysicsmechanicsforceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceGraphN::min(self : PhysicsmechanicsforceGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceGraphN::max(self : PhysicsmechanicsforceGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceGraphN::to_string(self : PhysicsmechanicsforceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_node_make(size : Int) -> PhysicsmechanicsforceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceNode::len(self : PhysicsmechanicsforceNode) -> Int { self.size }

pub fn PhysicsmechanicsforceNode::get(self : PhysicsmechanicsforceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceNode::set(self : PhysicsmechanicsforceNode, i : Int, v : Double) -> PhysicsmechanicsforceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceNode::sum(self : PhysicsmechanicsforceNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceNode::mean(self : PhysicsmechanicsforceNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceNode::scale(self : PhysicsmechanicsforceNode, f : Double) -> PhysicsmechanicsforceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceNode::add(self : PhysicsmechanicsforceNode, other : PhysicsmechanicsforceNode) -> PhysicsmechanicsforceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceNode::copy(self : PhysicsmechanicsforceNode) -> PhysicsmechanicsforceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceNode::fill(self : PhysicsmechanicsforceNode, v : Double) -> PhysicsmechanicsforceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceNode::min(self : PhysicsmechanicsforceNode) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceNode::max(self : PhysicsmechanicsforceNode) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceNode::to_string(self : PhysicsmechanicsforceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_edge_make(size : Int) -> PhysicsmechanicsforceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceEdge::len(self : PhysicsmechanicsforceEdge) -> Int { self.size }

pub fn PhysicsmechanicsforceEdge::get(self : PhysicsmechanicsforceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceEdge::set(self : PhysicsmechanicsforceEdge, i : Int, v : Double) -> PhysicsmechanicsforceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceEdge::sum(self : PhysicsmechanicsforceEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceEdge::mean(self : PhysicsmechanicsforceEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceEdge::scale(self : PhysicsmechanicsforceEdge, f : Double) -> PhysicsmechanicsforceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceEdge::add(self : PhysicsmechanicsforceEdge, other : PhysicsmechanicsforceEdge) -> PhysicsmechanicsforceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceEdge::copy(self : PhysicsmechanicsforceEdge) -> PhysicsmechanicsforceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceEdge::fill(self : PhysicsmechanicsforceEdge, v : Double) -> PhysicsmechanicsforceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceEdge::min(self : PhysicsmechanicsforceEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceEdge::max(self : PhysicsmechanicsforceEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceEdge::to_string(self : PhysicsmechanicsforceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforcePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_path_make(size : Int) -> PhysicsmechanicsforcePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforcePath::len(self : PhysicsmechanicsforcePath) -> Int { self.size }

pub fn PhysicsmechanicsforcePath::get(self : PhysicsmechanicsforcePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforcePath::set(self : PhysicsmechanicsforcePath, i : Int, v : Double) -> PhysicsmechanicsforcePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforcePath::sum(self : PhysicsmechanicsforcePath) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforcePath::mean(self : PhysicsmechanicsforcePath) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforcePath::scale(self : PhysicsmechanicsforcePath, f : Double) -> PhysicsmechanicsforcePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforcePath::add(self : PhysicsmechanicsforcePath, other : PhysicsmechanicsforcePath) -> PhysicsmechanicsforcePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforcePath::copy(self : PhysicsmechanicsforcePath) -> PhysicsmechanicsforcePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforcePath::fill(self : PhysicsmechanicsforcePath, v : Double) -> PhysicsmechanicsforcePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforcePath::min(self : PhysicsmechanicsforcePath) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforcePath::max(self : PhysicsmechanicsforcePath) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforcePath::to_string(self : PhysicsmechanicsforcePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_cluster_make(size : Int) -> PhysicsmechanicsforceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceCluster::len(self : PhysicsmechanicsforceCluster) -> Int { self.size }

pub fn PhysicsmechanicsforceCluster::get(self : PhysicsmechanicsforceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceCluster::set(self : PhysicsmechanicsforceCluster, i : Int, v : Double) -> PhysicsmechanicsforceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceCluster::sum(self : PhysicsmechanicsforceCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceCluster::mean(self : PhysicsmechanicsforceCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceCluster::scale(self : PhysicsmechanicsforceCluster, f : Double) -> PhysicsmechanicsforceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceCluster::add(self : PhysicsmechanicsforceCluster, other : PhysicsmechanicsforceCluster) -> PhysicsmechanicsforceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceCluster::copy(self : PhysicsmechanicsforceCluster) -> PhysicsmechanicsforceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceCluster::fill(self : PhysicsmechanicsforceCluster, v : Double) -> PhysicsmechanicsforceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceCluster::min(self : PhysicsmechanicsforceCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceCluster::max(self : PhysicsmechanicsforceCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceCluster::to_string(self : PhysicsmechanicsforceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_model_make(size : Int) -> PhysicsmechanicsforceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceModel::len(self : PhysicsmechanicsforceModel) -> Int { self.size }

pub fn PhysicsmechanicsforceModel::get(self : PhysicsmechanicsforceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceModel::set(self : PhysicsmechanicsforceModel, i : Int, v : Double) -> PhysicsmechanicsforceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceModel::sum(self : PhysicsmechanicsforceModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceModel::mean(self : PhysicsmechanicsforceModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceModel::scale(self : PhysicsmechanicsforceModel, f : Double) -> PhysicsmechanicsforceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceModel::add(self : PhysicsmechanicsforceModel, other : PhysicsmechanicsforceModel) -> PhysicsmechanicsforceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceModel::copy(self : PhysicsmechanicsforceModel) -> PhysicsmechanicsforceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceModel::fill(self : PhysicsmechanicsforceModel, v : Double) -> PhysicsmechanicsforceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceModel::min(self : PhysicsmechanicsforceModel) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceModel::max(self : PhysicsmechanicsforceModel) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceModel::to_string(self : PhysicsmechanicsforceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_layer_make(size : Int) -> PhysicsmechanicsforceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceLayer::len(self : PhysicsmechanicsforceLayer) -> Int { self.size }

pub fn PhysicsmechanicsforceLayer::get(self : PhysicsmechanicsforceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceLayer::set(self : PhysicsmechanicsforceLayer, i : Int, v : Double) -> PhysicsmechanicsforceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceLayer::sum(self : PhysicsmechanicsforceLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceLayer::mean(self : PhysicsmechanicsforceLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceLayer::scale(self : PhysicsmechanicsforceLayer, f : Double) -> PhysicsmechanicsforceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceLayer::add(self : PhysicsmechanicsforceLayer, other : PhysicsmechanicsforceLayer) -> PhysicsmechanicsforceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceLayer::copy(self : PhysicsmechanicsforceLayer) -> PhysicsmechanicsforceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceLayer::fill(self : PhysicsmechanicsforceLayer, v : Double) -> PhysicsmechanicsforceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceLayer::min(self : PhysicsmechanicsforceLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceLayer::max(self : PhysicsmechanicsforceLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceLayer::to_string(self : PhysicsmechanicsforceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_buffer_make(size : Int) -> PhysicsmechanicsforceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceBuffer::len(self : PhysicsmechanicsforceBuffer) -> Int { self.size }

pub fn PhysicsmechanicsforceBuffer::get(self : PhysicsmechanicsforceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceBuffer::set(self : PhysicsmechanicsforceBuffer, i : Int, v : Double) -> PhysicsmechanicsforceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceBuffer::sum(self : PhysicsmechanicsforceBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceBuffer::mean(self : PhysicsmechanicsforceBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceBuffer::scale(self : PhysicsmechanicsforceBuffer, f : Double) -> PhysicsmechanicsforceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceBuffer::add(self : PhysicsmechanicsforceBuffer, other : PhysicsmechanicsforceBuffer) -> PhysicsmechanicsforceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceBuffer::copy(self : PhysicsmechanicsforceBuffer) -> PhysicsmechanicsforceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceBuffer::fill(self : PhysicsmechanicsforceBuffer, v : Double) -> PhysicsmechanicsforceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceBuffer::min(self : PhysicsmechanicsforceBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceBuffer::max(self : PhysicsmechanicsforceBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceBuffer::to_string(self : PhysicsmechanicsforceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_cursor_make(size : Int) -> PhysicsmechanicsforceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceCursor::len(self : PhysicsmechanicsforceCursor) -> Int { self.size }

pub fn PhysicsmechanicsforceCursor::get(self : PhysicsmechanicsforceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceCursor::set(self : PhysicsmechanicsforceCursor, i : Int, v : Double) -> PhysicsmechanicsforceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceCursor::sum(self : PhysicsmechanicsforceCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceCursor::mean(self : PhysicsmechanicsforceCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceCursor::scale(self : PhysicsmechanicsforceCursor, f : Double) -> PhysicsmechanicsforceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceCursor::add(self : PhysicsmechanicsforceCursor, other : PhysicsmechanicsforceCursor) -> PhysicsmechanicsforceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceCursor::copy(self : PhysicsmechanicsforceCursor) -> PhysicsmechanicsforceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceCursor::fill(self : PhysicsmechanicsforceCursor, v : Double) -> PhysicsmechanicsforceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceCursor::min(self : PhysicsmechanicsforceCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceCursor::max(self : PhysicsmechanicsforceCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceCursor::to_string(self : PhysicsmechanicsforceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_view_make(size : Int) -> PhysicsmechanicsforceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceView::len(self : PhysicsmechanicsforceView) -> Int { self.size }

pub fn PhysicsmechanicsforceView::get(self : PhysicsmechanicsforceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceView::set(self : PhysicsmechanicsforceView, i : Int, v : Double) -> PhysicsmechanicsforceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceView::sum(self : PhysicsmechanicsforceView) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceView::mean(self : PhysicsmechanicsforceView) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceView::scale(self : PhysicsmechanicsforceView, f : Double) -> PhysicsmechanicsforceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceView::add(self : PhysicsmechanicsforceView, other : PhysicsmechanicsforceView) -> PhysicsmechanicsforceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceView::copy(self : PhysicsmechanicsforceView) -> PhysicsmechanicsforceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceView::fill(self : PhysicsmechanicsforceView, v : Double) -> PhysicsmechanicsforceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceView::min(self : PhysicsmechanicsforceView) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceView::max(self : PhysicsmechanicsforceView) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceView::to_string(self : PhysicsmechanicsforceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_range_make(size : Int) -> PhysicsmechanicsforceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceRange::len(self : PhysicsmechanicsforceRange) -> Int { self.size }

pub fn PhysicsmechanicsforceRange::get(self : PhysicsmechanicsforceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceRange::set(self : PhysicsmechanicsforceRange, i : Int, v : Double) -> PhysicsmechanicsforceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceRange::sum(self : PhysicsmechanicsforceRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceRange::mean(self : PhysicsmechanicsforceRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceRange::scale(self : PhysicsmechanicsforceRange, f : Double) -> PhysicsmechanicsforceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceRange::add(self : PhysicsmechanicsforceRange, other : PhysicsmechanicsforceRange) -> PhysicsmechanicsforceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceRange::copy(self : PhysicsmechanicsforceRange) -> PhysicsmechanicsforceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceRange::fill(self : PhysicsmechanicsforceRange, v : Double) -> PhysicsmechanicsforceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceRange::min(self : PhysicsmechanicsforceRange) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceRange::max(self : PhysicsmechanicsforceRange) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceRange::to_string(self : PhysicsmechanicsforceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_slice_make(size : Int) -> PhysicsmechanicsforceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsforceSlice::len(self : PhysicsmechanicsforceSlice) -> Int { self.size }

pub fn PhysicsmechanicsforceSlice::get(self : PhysicsmechanicsforceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsforceSlice::set(self : PhysicsmechanicsforceSlice, i : Int, v : Double) -> PhysicsmechanicsforceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceSlice::sum(self : PhysicsmechanicsforceSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsforceSlice::mean(self : PhysicsmechanicsforceSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsforceSlice::scale(self : PhysicsmechanicsforceSlice, f : Double) -> PhysicsmechanicsforceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceSlice::add(self : PhysicsmechanicsforceSlice, other : PhysicsmechanicsforceSlice) -> PhysicsmechanicsforceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsforceSlice::copy(self : PhysicsmechanicsforceSlice) -> PhysicsmechanicsforceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceSlice::fill(self : PhysicsmechanicsforceSlice, v : Double) -> PhysicsmechanicsforceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsforceSlice::min(self : PhysicsmechanicsforceSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsforceSlice::max(self : PhysicsmechanicsforceSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsforceSlice::to_string(self : PhysicsmechanicsforceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

