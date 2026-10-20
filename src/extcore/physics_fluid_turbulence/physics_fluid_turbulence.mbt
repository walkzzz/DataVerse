///===
/// extcore/physics_fluid_turbulence

pub(all) struct PhysicsfluidturbulencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_turbulence_make_point(x : Double, y : Double) -> PhysicsfluidturbulencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_turbulence_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidturbulencePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidturbulencePoint::x(self : PhysicsfluidturbulencePoint) -> Double { self.x }

pub fn PhysicsfluidturbulencePoint::y(self : PhysicsfluidturbulencePoint) -> Double { self.y }

pub fn PhysicsfluidturbulencePoint::z(self : PhysicsfluidturbulencePoint) -> Double { self.z }

pub fn PhysicsfluidturbulencePoint::label(self : PhysicsfluidturbulencePoint) -> Int { self.label }

pub fn PhysicsfluidturbulencePoint::dist(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidturbulencePoint::add(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::sub(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::scale(self : PhysicsfluidturbulencePoint, s : Double) -> PhysicsfluidturbulencePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::dot(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidturbulencePoint::cross(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidturbulencePoint::norm(self : PhysicsfluidturbulencePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidturbulencePoint::normalize(self : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidturbulencePoint::negate(self : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::mid(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::lerp(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint, t : Double) -> PhysicsfluidturbulencePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::to_string(self : PhysicsfluidturbulencePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_turbulence_make_series(vals : Array[Double], name : String) -> PhysicsfluidturbulenceSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidturbulenceSeries::len(self : PhysicsfluidturbulenceSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidturbulenceSeries::sum(self : PhysicsfluidturbulenceSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidturbulenceSeries::mean(self : PhysicsfluidturbulenceSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidturbulenceSeries::min(self : PhysicsfluidturbulenceSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidturbulenceSeries::max(self : PhysicsfluidturbulenceSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidturbulenceSeries::range(self : PhysicsfluidturbulenceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidturbulenceSeries::variance(self : PhysicsfluidturbulenceSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidturbulenceSeries::std(self : PhysicsfluidturbulenceSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidturbulenceSeries::median(self : PhysicsfluidturbulenceSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidturbulenceSeries::scale(self : PhysicsfluidturbulenceSeries, f : Double) -> PhysicsfluidturbulenceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidturbulenceSeries::add(self : PhysicsfluidturbulenceSeries, other : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidturbulenceSeries::sub(self : PhysicsfluidturbulenceSeries, other : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidturbulenceSeries::normalize(self : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidturbulenceSeries::cumsum(self : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidturbulenceSeries::to_string(self : PhysicsfluidturbulenceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidturbulenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_turbulence_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidturbulenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_turbulence_matrix_identity(n : Int) -> PhysicsfluidturbulenceMatrix {
  let m = physics_fluid_turbulence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidturbulenceMatrix::get(self : PhysicsfluidturbulenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidturbulenceMatrix::transpose(self : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  let result = physics_fluid_turbulence_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidturbulenceMatrix::add(self : PhysicsfluidturbulenceMatrix, other : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_turbulence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidturbulenceMatrix::scale(self : PhysicsfluidturbulenceMatrix, s : Double) -> PhysicsfluidturbulenceMatrix {
  let result = physics_fluid_turbulence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidturbulenceMatrix::multiply(self : PhysicsfluidturbulenceMatrix, other : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  if self.cols != other.rows { return physics_fluid_turbulence_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_turbulence_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluidturbulenceMatrix::trace(self : PhysicsfluidturbulenceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidturbulenceMatrix::det(self : PhysicsfluidturbulenceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidturbulenceMatrix::norm(self : PhysicsfluidturbulenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidturbulenceMatrix::to_string(self : PhysicsfluidturbulenceMatrix) -> String {
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

pub(all) struct PhysicsfluidturbulenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_turbulence_make_vector(comps : Array[Double]) -> PhysicsfluidturbulenceVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_turbulence_vector_zero(dim : Int) -> PhysicsfluidturbulenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidturbulenceVector::add(self : PhysicsfluidturbulenceVector, other : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidturbulenceVector::sub(self : PhysicsfluidturbulenceVector, other : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidturbulenceVector::scale(self : PhysicsfluidturbulenceVector, s : Double) -> PhysicsfluidturbulenceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidturbulenceVector::dot(self : PhysicsfluidturbulenceVector, other : PhysicsfluidturbulenceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidturbulenceVector::norm(self : PhysicsfluidturbulenceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidturbulenceVector::normalize(self : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidturbulenceVector::dist(self : PhysicsfluidturbulenceVector, other : PhysicsfluidturbulenceVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidturbulenceVector::to_string(self : PhysicsfluidturbulenceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidturbulenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_frame_make(size : Int) -> PhysicsfluidturbulenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceFrame::len(self : PhysicsfluidturbulenceFrame) -> Int { self.size }

pub fn PhysicsfluidturbulenceFrame::get(self : PhysicsfluidturbulenceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceFrame::set(self : PhysicsfluidturbulenceFrame, i : Int, v : Double) -> PhysicsfluidturbulenceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceFrame::sum(self : PhysicsfluidturbulenceFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceFrame::mean(self : PhysicsfluidturbulenceFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceFrame::scale(self : PhysicsfluidturbulenceFrame, f : Double) -> PhysicsfluidturbulenceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceFrame::add(self : PhysicsfluidturbulenceFrame, other : PhysicsfluidturbulenceFrame) -> PhysicsfluidturbulenceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceFrame::copy(self : PhysicsfluidturbulenceFrame) -> PhysicsfluidturbulenceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceFrame::fill(self : PhysicsfluidturbulenceFrame, v : Double) -> PhysicsfluidturbulenceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceFrame::min(self : PhysicsfluidturbulenceFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceFrame::max(self : PhysicsfluidturbulenceFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceFrame::to_string(self : PhysicsfluidturbulenceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_table_make(size : Int) -> PhysicsfluidturbulenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceTable::len(self : PhysicsfluidturbulenceTable) -> Int { self.size }

pub fn PhysicsfluidturbulenceTable::get(self : PhysicsfluidturbulenceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceTable::set(self : PhysicsfluidturbulenceTable, i : Int, v : Double) -> PhysicsfluidturbulenceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceTable::sum(self : PhysicsfluidturbulenceTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceTable::mean(self : PhysicsfluidturbulenceTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceTable::scale(self : PhysicsfluidturbulenceTable, f : Double) -> PhysicsfluidturbulenceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceTable::add(self : PhysicsfluidturbulenceTable, other : PhysicsfluidturbulenceTable) -> PhysicsfluidturbulenceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceTable::copy(self : PhysicsfluidturbulenceTable) -> PhysicsfluidturbulenceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceTable::fill(self : PhysicsfluidturbulenceTable, v : Double) -> PhysicsfluidturbulenceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceTable::min(self : PhysicsfluidturbulenceTable) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceTable::max(self : PhysicsfluidturbulenceTable) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceTable::to_string(self : PhysicsfluidturbulenceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_graphn_make(size : Int) -> PhysicsfluidturbulenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceGraphN::len(self : PhysicsfluidturbulenceGraphN) -> Int { self.size }

pub fn PhysicsfluidturbulenceGraphN::get(self : PhysicsfluidturbulenceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceGraphN::set(self : PhysicsfluidturbulenceGraphN, i : Int, v : Double) -> PhysicsfluidturbulenceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceGraphN::sum(self : PhysicsfluidturbulenceGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceGraphN::mean(self : PhysicsfluidturbulenceGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceGraphN::scale(self : PhysicsfluidturbulenceGraphN, f : Double) -> PhysicsfluidturbulenceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceGraphN::add(self : PhysicsfluidturbulenceGraphN, other : PhysicsfluidturbulenceGraphN) -> PhysicsfluidturbulenceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceGraphN::copy(self : PhysicsfluidturbulenceGraphN) -> PhysicsfluidturbulenceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceGraphN::fill(self : PhysicsfluidturbulenceGraphN, v : Double) -> PhysicsfluidturbulenceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceGraphN::min(self : PhysicsfluidturbulenceGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceGraphN::max(self : PhysicsfluidturbulenceGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceGraphN::to_string(self : PhysicsfluidturbulenceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_node_make(size : Int) -> PhysicsfluidturbulenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceNode::len(self : PhysicsfluidturbulenceNode) -> Int { self.size }

pub fn PhysicsfluidturbulenceNode::get(self : PhysicsfluidturbulenceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceNode::set(self : PhysicsfluidturbulenceNode, i : Int, v : Double) -> PhysicsfluidturbulenceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceNode::sum(self : PhysicsfluidturbulenceNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceNode::mean(self : PhysicsfluidturbulenceNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceNode::scale(self : PhysicsfluidturbulenceNode, f : Double) -> PhysicsfluidturbulenceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceNode::add(self : PhysicsfluidturbulenceNode, other : PhysicsfluidturbulenceNode) -> PhysicsfluidturbulenceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceNode::copy(self : PhysicsfluidturbulenceNode) -> PhysicsfluidturbulenceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceNode::fill(self : PhysicsfluidturbulenceNode, v : Double) -> PhysicsfluidturbulenceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceNode::min(self : PhysicsfluidturbulenceNode) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceNode::max(self : PhysicsfluidturbulenceNode) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceNode::to_string(self : PhysicsfluidturbulenceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_edge_make(size : Int) -> PhysicsfluidturbulenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceEdge::len(self : PhysicsfluidturbulenceEdge) -> Int { self.size }

pub fn PhysicsfluidturbulenceEdge::get(self : PhysicsfluidturbulenceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceEdge::set(self : PhysicsfluidturbulenceEdge, i : Int, v : Double) -> PhysicsfluidturbulenceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceEdge::sum(self : PhysicsfluidturbulenceEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceEdge::mean(self : PhysicsfluidturbulenceEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceEdge::scale(self : PhysicsfluidturbulenceEdge, f : Double) -> PhysicsfluidturbulenceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceEdge::add(self : PhysicsfluidturbulenceEdge, other : PhysicsfluidturbulenceEdge) -> PhysicsfluidturbulenceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceEdge::copy(self : PhysicsfluidturbulenceEdge) -> PhysicsfluidturbulenceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceEdge::fill(self : PhysicsfluidturbulenceEdge, v : Double) -> PhysicsfluidturbulenceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceEdge::min(self : PhysicsfluidturbulenceEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceEdge::max(self : PhysicsfluidturbulenceEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceEdge::to_string(self : PhysicsfluidturbulenceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_path_make(size : Int) -> PhysicsfluidturbulencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulencePath::len(self : PhysicsfluidturbulencePath) -> Int { self.size }

pub fn PhysicsfluidturbulencePath::get(self : PhysicsfluidturbulencePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulencePath::set(self : PhysicsfluidturbulencePath, i : Int, v : Double) -> PhysicsfluidturbulencePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulencePath::sum(self : PhysicsfluidturbulencePath) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulencePath::mean(self : PhysicsfluidturbulencePath) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulencePath::scale(self : PhysicsfluidturbulencePath, f : Double) -> PhysicsfluidturbulencePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulencePath::add(self : PhysicsfluidturbulencePath, other : PhysicsfluidturbulencePath) -> PhysicsfluidturbulencePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulencePath::copy(self : PhysicsfluidturbulencePath) -> PhysicsfluidturbulencePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulencePath::fill(self : PhysicsfluidturbulencePath, v : Double) -> PhysicsfluidturbulencePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulencePath::min(self : PhysicsfluidturbulencePath) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulencePath::max(self : PhysicsfluidturbulencePath) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulencePath::to_string(self : PhysicsfluidturbulencePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_cluster_make(size : Int) -> PhysicsfluidturbulenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceCluster::len(self : PhysicsfluidturbulenceCluster) -> Int { self.size }

pub fn PhysicsfluidturbulenceCluster::get(self : PhysicsfluidturbulenceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceCluster::set(self : PhysicsfluidturbulenceCluster, i : Int, v : Double) -> PhysicsfluidturbulenceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceCluster::sum(self : PhysicsfluidturbulenceCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceCluster::mean(self : PhysicsfluidturbulenceCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceCluster::scale(self : PhysicsfluidturbulenceCluster, f : Double) -> PhysicsfluidturbulenceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceCluster::add(self : PhysicsfluidturbulenceCluster, other : PhysicsfluidturbulenceCluster) -> PhysicsfluidturbulenceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceCluster::copy(self : PhysicsfluidturbulenceCluster) -> PhysicsfluidturbulenceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceCluster::fill(self : PhysicsfluidturbulenceCluster, v : Double) -> PhysicsfluidturbulenceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceCluster::min(self : PhysicsfluidturbulenceCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceCluster::max(self : PhysicsfluidturbulenceCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceCluster::to_string(self : PhysicsfluidturbulenceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_model_make(size : Int) -> PhysicsfluidturbulenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceModel::len(self : PhysicsfluidturbulenceModel) -> Int { self.size }

pub fn PhysicsfluidturbulenceModel::get(self : PhysicsfluidturbulenceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceModel::set(self : PhysicsfluidturbulenceModel, i : Int, v : Double) -> PhysicsfluidturbulenceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceModel::sum(self : PhysicsfluidturbulenceModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceModel::mean(self : PhysicsfluidturbulenceModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceModel::scale(self : PhysicsfluidturbulenceModel, f : Double) -> PhysicsfluidturbulenceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceModel::add(self : PhysicsfluidturbulenceModel, other : PhysicsfluidturbulenceModel) -> PhysicsfluidturbulenceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceModel::copy(self : PhysicsfluidturbulenceModel) -> PhysicsfluidturbulenceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceModel::fill(self : PhysicsfluidturbulenceModel, v : Double) -> PhysicsfluidturbulenceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceModel::min(self : PhysicsfluidturbulenceModel) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceModel::max(self : PhysicsfluidturbulenceModel) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceModel::to_string(self : PhysicsfluidturbulenceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_layer_make(size : Int) -> PhysicsfluidturbulenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceLayer::len(self : PhysicsfluidturbulenceLayer) -> Int { self.size }

pub fn PhysicsfluidturbulenceLayer::get(self : PhysicsfluidturbulenceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceLayer::set(self : PhysicsfluidturbulenceLayer, i : Int, v : Double) -> PhysicsfluidturbulenceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceLayer::sum(self : PhysicsfluidturbulenceLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceLayer::mean(self : PhysicsfluidturbulenceLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceLayer::scale(self : PhysicsfluidturbulenceLayer, f : Double) -> PhysicsfluidturbulenceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceLayer::add(self : PhysicsfluidturbulenceLayer, other : PhysicsfluidturbulenceLayer) -> PhysicsfluidturbulenceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceLayer::copy(self : PhysicsfluidturbulenceLayer) -> PhysicsfluidturbulenceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceLayer::fill(self : PhysicsfluidturbulenceLayer, v : Double) -> PhysicsfluidturbulenceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceLayer::min(self : PhysicsfluidturbulenceLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceLayer::max(self : PhysicsfluidturbulenceLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceLayer::to_string(self : PhysicsfluidturbulenceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_buffer_make(size : Int) -> PhysicsfluidturbulenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceBuffer::len(self : PhysicsfluidturbulenceBuffer) -> Int { self.size }

pub fn PhysicsfluidturbulenceBuffer::get(self : PhysicsfluidturbulenceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceBuffer::set(self : PhysicsfluidturbulenceBuffer, i : Int, v : Double) -> PhysicsfluidturbulenceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceBuffer::sum(self : PhysicsfluidturbulenceBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceBuffer::mean(self : PhysicsfluidturbulenceBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceBuffer::scale(self : PhysicsfluidturbulenceBuffer, f : Double) -> PhysicsfluidturbulenceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceBuffer::add(self : PhysicsfluidturbulenceBuffer, other : PhysicsfluidturbulenceBuffer) -> PhysicsfluidturbulenceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceBuffer::copy(self : PhysicsfluidturbulenceBuffer) -> PhysicsfluidturbulenceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceBuffer::fill(self : PhysicsfluidturbulenceBuffer, v : Double) -> PhysicsfluidturbulenceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceBuffer::min(self : PhysicsfluidturbulenceBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceBuffer::max(self : PhysicsfluidturbulenceBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceBuffer::to_string(self : PhysicsfluidturbulenceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_cursor_make(size : Int) -> PhysicsfluidturbulenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceCursor::len(self : PhysicsfluidturbulenceCursor) -> Int { self.size }

pub fn PhysicsfluidturbulenceCursor::get(self : PhysicsfluidturbulenceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceCursor::set(self : PhysicsfluidturbulenceCursor, i : Int, v : Double) -> PhysicsfluidturbulenceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceCursor::sum(self : PhysicsfluidturbulenceCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceCursor::mean(self : PhysicsfluidturbulenceCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceCursor::scale(self : PhysicsfluidturbulenceCursor, f : Double) -> PhysicsfluidturbulenceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceCursor::add(self : PhysicsfluidturbulenceCursor, other : PhysicsfluidturbulenceCursor) -> PhysicsfluidturbulenceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceCursor::copy(self : PhysicsfluidturbulenceCursor) -> PhysicsfluidturbulenceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceCursor::fill(self : PhysicsfluidturbulenceCursor, v : Double) -> PhysicsfluidturbulenceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceCursor::min(self : PhysicsfluidturbulenceCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceCursor::max(self : PhysicsfluidturbulenceCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceCursor::to_string(self : PhysicsfluidturbulenceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_view_make(size : Int) -> PhysicsfluidturbulenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceView::len(self : PhysicsfluidturbulenceView) -> Int { self.size }

pub fn PhysicsfluidturbulenceView::get(self : PhysicsfluidturbulenceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceView::set(self : PhysicsfluidturbulenceView, i : Int, v : Double) -> PhysicsfluidturbulenceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceView::sum(self : PhysicsfluidturbulenceView) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceView::mean(self : PhysicsfluidturbulenceView) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceView::scale(self : PhysicsfluidturbulenceView, f : Double) -> PhysicsfluidturbulenceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceView::add(self : PhysicsfluidturbulenceView, other : PhysicsfluidturbulenceView) -> PhysicsfluidturbulenceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceView::copy(self : PhysicsfluidturbulenceView) -> PhysicsfluidturbulenceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceView::fill(self : PhysicsfluidturbulenceView, v : Double) -> PhysicsfluidturbulenceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceView::min(self : PhysicsfluidturbulenceView) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceView::max(self : PhysicsfluidturbulenceView) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceView::to_string(self : PhysicsfluidturbulenceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_range_make(size : Int) -> PhysicsfluidturbulenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceRange::len(self : PhysicsfluidturbulenceRange) -> Int { self.size }

pub fn PhysicsfluidturbulenceRange::get(self : PhysicsfluidturbulenceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceRange::set(self : PhysicsfluidturbulenceRange, i : Int, v : Double) -> PhysicsfluidturbulenceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceRange::sum(self : PhysicsfluidturbulenceRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceRange::mean(self : PhysicsfluidturbulenceRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceRange::scale(self : PhysicsfluidturbulenceRange, f : Double) -> PhysicsfluidturbulenceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceRange::add(self : PhysicsfluidturbulenceRange, other : PhysicsfluidturbulenceRange) -> PhysicsfluidturbulenceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceRange::copy(self : PhysicsfluidturbulenceRange) -> PhysicsfluidturbulenceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceRange::fill(self : PhysicsfluidturbulenceRange, v : Double) -> PhysicsfluidturbulenceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceRange::min(self : PhysicsfluidturbulenceRange) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceRange::max(self : PhysicsfluidturbulenceRange) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceRange::to_string(self : PhysicsfluidturbulenceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_slice_make(size : Int) -> PhysicsfluidturbulenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidturbulenceSlice::len(self : PhysicsfluidturbulenceSlice) -> Int { self.size }

pub fn PhysicsfluidturbulenceSlice::get(self : PhysicsfluidturbulenceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidturbulenceSlice::set(self : PhysicsfluidturbulenceSlice, i : Int, v : Double) -> PhysicsfluidturbulenceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceSlice::sum(self : PhysicsfluidturbulenceSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidturbulenceSlice::mean(self : PhysicsfluidturbulenceSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidturbulenceSlice::scale(self : PhysicsfluidturbulenceSlice, f : Double) -> PhysicsfluidturbulenceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceSlice::add(self : PhysicsfluidturbulenceSlice, other : PhysicsfluidturbulenceSlice) -> PhysicsfluidturbulenceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidturbulenceSlice::copy(self : PhysicsfluidturbulenceSlice) -> PhysicsfluidturbulenceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceSlice::fill(self : PhysicsfluidturbulenceSlice, v : Double) -> PhysicsfluidturbulenceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidturbulenceSlice::min(self : PhysicsfluidturbulenceSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidturbulenceSlice::max(self : PhysicsfluidturbulenceSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidturbulenceSlice::to_string(self : PhysicsfluidturbulenceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

