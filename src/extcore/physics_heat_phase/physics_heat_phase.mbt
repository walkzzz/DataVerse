///===
/// extcore/physics_heat_phase

pub(all) struct PhysicsheatphasePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_phase_make_point(x : Double, y : Double) -> PhysicsheatphasePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_phase_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatphasePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatphasePoint::x(self : PhysicsheatphasePoint) -> Double { self.x }

pub fn PhysicsheatphasePoint::y(self : PhysicsheatphasePoint) -> Double { self.y }

pub fn PhysicsheatphasePoint::z(self : PhysicsheatphasePoint) -> Double { self.z }

pub fn PhysicsheatphasePoint::label(self : PhysicsheatphasePoint) -> Int { self.label }

pub fn PhysicsheatphasePoint::dist(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatphasePoint::add(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatphasePoint::sub(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatphasePoint::scale(self : PhysicsheatphasePoint, s : Double) -> PhysicsheatphasePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatphasePoint::dot(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatphasePoint::cross(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatphasePoint::norm(self : PhysicsheatphasePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatphasePoint::normalize(self : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatphasePoint::negate(self : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatphasePoint::mid(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatphasePoint::lerp(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint, t : Double) -> PhysicsheatphasePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatphasePoint::to_string(self : PhysicsheatphasePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatphaseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_phase_make_series(vals : Array[Double], name : String) -> PhysicsheatphaseSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatphaseSeries::len(self : PhysicsheatphaseSeries) -> Int { self.vals.length() }

pub fn PhysicsheatphaseSeries::sum(self : PhysicsheatphaseSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatphaseSeries::mean(self : PhysicsheatphaseSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatphaseSeries::min(self : PhysicsheatphaseSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatphaseSeries::max(self : PhysicsheatphaseSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatphaseSeries::range(self : PhysicsheatphaseSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatphaseSeries::variance(self : PhysicsheatphaseSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatphaseSeries::std(self : PhysicsheatphaseSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatphaseSeries::median(self : PhysicsheatphaseSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatphaseSeries::scale(self : PhysicsheatphaseSeries, f : Double) -> PhysicsheatphaseSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatphaseSeries::add(self : PhysicsheatphaseSeries, other : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatphaseSeries::sub(self : PhysicsheatphaseSeries, other : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatphaseSeries::normalize(self : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatphaseSeries::cumsum(self : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatphaseSeries::to_string(self : PhysicsheatphaseSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatphaseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_phase_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatphaseMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn physics_heat_phase_matrix_identity(n : Int) -> PhysicsheatphaseMatrix {
  let m = physics_heat_phase_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatphaseMatrix::get(self : PhysicsheatphaseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatphaseMatrix::transpose(self : PhysicsheatphaseMatrix) -> PhysicsheatphaseMatrix {
  let result = physics_heat_phase_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatphaseMatrix::add(self : PhysicsheatphaseMatrix, other : PhysicsheatphaseMatrix) -> PhysicsheatphaseMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_phase_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatphaseMatrix::scale(self : PhysicsheatphaseMatrix, s : Double) -> PhysicsheatphaseMatrix {
  let result = physics_heat_phase_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatphaseMatrix::multiply(self : PhysicsheatphaseMatrix, other : PhysicsheatphaseMatrix) -> PhysicsheatphaseMatrix {
  if self.cols != other.rows { return physics_heat_phase_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_phase_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsheatphaseMatrix::trace(self : PhysicsheatphaseMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatphaseMatrix::det(self : PhysicsheatphaseMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatphaseMatrix::norm(self : PhysicsheatphaseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatphaseMatrix::to_string(self : PhysicsheatphaseMatrix) -> String {
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

pub(all) struct PhysicsheatphaseVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_phase_make_vector(comps : Array[Double]) -> PhysicsheatphaseVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_phase_vector_zero(dim : Int) -> PhysicsheatphaseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatphaseVector::add(self : PhysicsheatphaseVector, other : PhysicsheatphaseVector) -> PhysicsheatphaseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatphaseVector::sub(self : PhysicsheatphaseVector, other : PhysicsheatphaseVector) -> PhysicsheatphaseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatphaseVector::scale(self : PhysicsheatphaseVector, s : Double) -> PhysicsheatphaseVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatphaseVector::dot(self : PhysicsheatphaseVector, other : PhysicsheatphaseVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatphaseVector::norm(self : PhysicsheatphaseVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatphaseVector::normalize(self : PhysicsheatphaseVector) -> PhysicsheatphaseVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatphaseVector::dist(self : PhysicsheatphaseVector, other : PhysicsheatphaseVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatphaseVector::to_string(self : PhysicsheatphaseVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatphaseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_frame_make(size : Int) -> PhysicsheatphaseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseFrame::len(self : PhysicsheatphaseFrame) -> Int { self.size }

pub fn PhysicsheatphaseFrame::get(self : PhysicsheatphaseFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseFrame::set(self : PhysicsheatphaseFrame, i : Int, v : Double) -> PhysicsheatphaseFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseFrame::sum(self : PhysicsheatphaseFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseFrame::mean(self : PhysicsheatphaseFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseFrame::scale(self : PhysicsheatphaseFrame, f : Double) -> PhysicsheatphaseFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseFrame::add(self : PhysicsheatphaseFrame, other : PhysicsheatphaseFrame) -> PhysicsheatphaseFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseFrame::copy(self : PhysicsheatphaseFrame) -> PhysicsheatphaseFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseFrame::fill(self : PhysicsheatphaseFrame, v : Double) -> PhysicsheatphaseFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseFrame::min(self : PhysicsheatphaseFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseFrame::max(self : PhysicsheatphaseFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseFrame::to_string(self : PhysicsheatphaseFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_table_make(size : Int) -> PhysicsheatphaseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseTable::len(self : PhysicsheatphaseTable) -> Int { self.size }

pub fn PhysicsheatphaseTable::get(self : PhysicsheatphaseTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseTable::set(self : PhysicsheatphaseTable, i : Int, v : Double) -> PhysicsheatphaseTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseTable::sum(self : PhysicsheatphaseTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseTable::mean(self : PhysicsheatphaseTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseTable::scale(self : PhysicsheatphaseTable, f : Double) -> PhysicsheatphaseTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseTable::add(self : PhysicsheatphaseTable, other : PhysicsheatphaseTable) -> PhysicsheatphaseTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseTable::copy(self : PhysicsheatphaseTable) -> PhysicsheatphaseTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseTable::fill(self : PhysicsheatphaseTable, v : Double) -> PhysicsheatphaseTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseTable::min(self : PhysicsheatphaseTable) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseTable::max(self : PhysicsheatphaseTable) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseTable::to_string(self : PhysicsheatphaseTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_graphn_make(size : Int) -> PhysicsheatphaseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseGraphN::len(self : PhysicsheatphaseGraphN) -> Int { self.size }

pub fn PhysicsheatphaseGraphN::get(self : PhysicsheatphaseGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseGraphN::set(self : PhysicsheatphaseGraphN, i : Int, v : Double) -> PhysicsheatphaseGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseGraphN::sum(self : PhysicsheatphaseGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseGraphN::mean(self : PhysicsheatphaseGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseGraphN::scale(self : PhysicsheatphaseGraphN, f : Double) -> PhysicsheatphaseGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseGraphN::add(self : PhysicsheatphaseGraphN, other : PhysicsheatphaseGraphN) -> PhysicsheatphaseGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseGraphN::copy(self : PhysicsheatphaseGraphN) -> PhysicsheatphaseGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseGraphN::fill(self : PhysicsheatphaseGraphN, v : Double) -> PhysicsheatphaseGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseGraphN::min(self : PhysicsheatphaseGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseGraphN::max(self : PhysicsheatphaseGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseGraphN::to_string(self : PhysicsheatphaseGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_node_make(size : Int) -> PhysicsheatphaseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseNode::len(self : PhysicsheatphaseNode) -> Int { self.size }

pub fn PhysicsheatphaseNode::get(self : PhysicsheatphaseNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseNode::set(self : PhysicsheatphaseNode, i : Int, v : Double) -> PhysicsheatphaseNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseNode::sum(self : PhysicsheatphaseNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseNode::mean(self : PhysicsheatphaseNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseNode::scale(self : PhysicsheatphaseNode, f : Double) -> PhysicsheatphaseNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseNode::add(self : PhysicsheatphaseNode, other : PhysicsheatphaseNode) -> PhysicsheatphaseNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseNode::copy(self : PhysicsheatphaseNode) -> PhysicsheatphaseNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseNode::fill(self : PhysicsheatphaseNode, v : Double) -> PhysicsheatphaseNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseNode::min(self : PhysicsheatphaseNode) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseNode::max(self : PhysicsheatphaseNode) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseNode::to_string(self : PhysicsheatphaseNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_edge_make(size : Int) -> PhysicsheatphaseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseEdge::len(self : PhysicsheatphaseEdge) -> Int { self.size }

pub fn PhysicsheatphaseEdge::get(self : PhysicsheatphaseEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseEdge::set(self : PhysicsheatphaseEdge, i : Int, v : Double) -> PhysicsheatphaseEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseEdge::sum(self : PhysicsheatphaseEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseEdge::mean(self : PhysicsheatphaseEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseEdge::scale(self : PhysicsheatphaseEdge, f : Double) -> PhysicsheatphaseEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseEdge::add(self : PhysicsheatphaseEdge, other : PhysicsheatphaseEdge) -> PhysicsheatphaseEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseEdge::copy(self : PhysicsheatphaseEdge) -> PhysicsheatphaseEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseEdge::fill(self : PhysicsheatphaseEdge, v : Double) -> PhysicsheatphaseEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseEdge::min(self : PhysicsheatphaseEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseEdge::max(self : PhysicsheatphaseEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseEdge::to_string(self : PhysicsheatphaseEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphasePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_path_make(size : Int) -> PhysicsheatphasePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphasePath::len(self : PhysicsheatphasePath) -> Int { self.size }

pub fn PhysicsheatphasePath::get(self : PhysicsheatphasePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphasePath::set(self : PhysicsheatphasePath, i : Int, v : Double) -> PhysicsheatphasePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphasePath::sum(self : PhysicsheatphasePath) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphasePath::mean(self : PhysicsheatphasePath) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphasePath::scale(self : PhysicsheatphasePath, f : Double) -> PhysicsheatphasePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphasePath::add(self : PhysicsheatphasePath, other : PhysicsheatphasePath) -> PhysicsheatphasePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphasePath::copy(self : PhysicsheatphasePath) -> PhysicsheatphasePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphasePath::fill(self : PhysicsheatphasePath, v : Double) -> PhysicsheatphasePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphasePath::min(self : PhysicsheatphasePath) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphasePath::max(self : PhysicsheatphasePath) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphasePath::to_string(self : PhysicsheatphasePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_cluster_make(size : Int) -> PhysicsheatphaseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseCluster::len(self : PhysicsheatphaseCluster) -> Int { self.size }

pub fn PhysicsheatphaseCluster::get(self : PhysicsheatphaseCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseCluster::set(self : PhysicsheatphaseCluster, i : Int, v : Double) -> PhysicsheatphaseCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseCluster::sum(self : PhysicsheatphaseCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseCluster::mean(self : PhysicsheatphaseCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseCluster::scale(self : PhysicsheatphaseCluster, f : Double) -> PhysicsheatphaseCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseCluster::add(self : PhysicsheatphaseCluster, other : PhysicsheatphaseCluster) -> PhysicsheatphaseCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseCluster::copy(self : PhysicsheatphaseCluster) -> PhysicsheatphaseCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseCluster::fill(self : PhysicsheatphaseCluster, v : Double) -> PhysicsheatphaseCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseCluster::min(self : PhysicsheatphaseCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseCluster::max(self : PhysicsheatphaseCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseCluster::to_string(self : PhysicsheatphaseCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_model_make(size : Int) -> PhysicsheatphaseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseModel::len(self : PhysicsheatphaseModel) -> Int { self.size }

pub fn PhysicsheatphaseModel::get(self : PhysicsheatphaseModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseModel::set(self : PhysicsheatphaseModel, i : Int, v : Double) -> PhysicsheatphaseModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseModel::sum(self : PhysicsheatphaseModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseModel::mean(self : PhysicsheatphaseModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseModel::scale(self : PhysicsheatphaseModel, f : Double) -> PhysicsheatphaseModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseModel::add(self : PhysicsheatphaseModel, other : PhysicsheatphaseModel) -> PhysicsheatphaseModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseModel::copy(self : PhysicsheatphaseModel) -> PhysicsheatphaseModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseModel::fill(self : PhysicsheatphaseModel, v : Double) -> PhysicsheatphaseModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseModel::min(self : PhysicsheatphaseModel) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseModel::max(self : PhysicsheatphaseModel) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseModel::to_string(self : PhysicsheatphaseModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_layer_make(size : Int) -> PhysicsheatphaseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseLayer::len(self : PhysicsheatphaseLayer) -> Int { self.size }

pub fn PhysicsheatphaseLayer::get(self : PhysicsheatphaseLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseLayer::set(self : PhysicsheatphaseLayer, i : Int, v : Double) -> PhysicsheatphaseLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseLayer::sum(self : PhysicsheatphaseLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseLayer::mean(self : PhysicsheatphaseLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseLayer::scale(self : PhysicsheatphaseLayer, f : Double) -> PhysicsheatphaseLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseLayer::add(self : PhysicsheatphaseLayer, other : PhysicsheatphaseLayer) -> PhysicsheatphaseLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseLayer::copy(self : PhysicsheatphaseLayer) -> PhysicsheatphaseLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseLayer::fill(self : PhysicsheatphaseLayer, v : Double) -> PhysicsheatphaseLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseLayer::min(self : PhysicsheatphaseLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseLayer::max(self : PhysicsheatphaseLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseLayer::to_string(self : PhysicsheatphaseLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_buffer_make(size : Int) -> PhysicsheatphaseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseBuffer::len(self : PhysicsheatphaseBuffer) -> Int { self.size }

pub fn PhysicsheatphaseBuffer::get(self : PhysicsheatphaseBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseBuffer::set(self : PhysicsheatphaseBuffer, i : Int, v : Double) -> PhysicsheatphaseBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseBuffer::sum(self : PhysicsheatphaseBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseBuffer::mean(self : PhysicsheatphaseBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseBuffer::scale(self : PhysicsheatphaseBuffer, f : Double) -> PhysicsheatphaseBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseBuffer::add(self : PhysicsheatphaseBuffer, other : PhysicsheatphaseBuffer) -> PhysicsheatphaseBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseBuffer::copy(self : PhysicsheatphaseBuffer) -> PhysicsheatphaseBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseBuffer::fill(self : PhysicsheatphaseBuffer, v : Double) -> PhysicsheatphaseBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseBuffer::min(self : PhysicsheatphaseBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseBuffer::max(self : PhysicsheatphaseBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseBuffer::to_string(self : PhysicsheatphaseBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_cursor_make(size : Int) -> PhysicsheatphaseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseCursor::len(self : PhysicsheatphaseCursor) -> Int { self.size }

pub fn PhysicsheatphaseCursor::get(self : PhysicsheatphaseCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseCursor::set(self : PhysicsheatphaseCursor, i : Int, v : Double) -> PhysicsheatphaseCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseCursor::sum(self : PhysicsheatphaseCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseCursor::mean(self : PhysicsheatphaseCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseCursor::scale(self : PhysicsheatphaseCursor, f : Double) -> PhysicsheatphaseCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseCursor::add(self : PhysicsheatphaseCursor, other : PhysicsheatphaseCursor) -> PhysicsheatphaseCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseCursor::copy(self : PhysicsheatphaseCursor) -> PhysicsheatphaseCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseCursor::fill(self : PhysicsheatphaseCursor, v : Double) -> PhysicsheatphaseCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseCursor::min(self : PhysicsheatphaseCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseCursor::max(self : PhysicsheatphaseCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseCursor::to_string(self : PhysicsheatphaseCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_view_make(size : Int) -> PhysicsheatphaseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseView::len(self : PhysicsheatphaseView) -> Int { self.size }

pub fn PhysicsheatphaseView::get(self : PhysicsheatphaseView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseView::set(self : PhysicsheatphaseView, i : Int, v : Double) -> PhysicsheatphaseView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseView::sum(self : PhysicsheatphaseView) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseView::mean(self : PhysicsheatphaseView) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseView::scale(self : PhysicsheatphaseView, f : Double) -> PhysicsheatphaseView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseView::add(self : PhysicsheatphaseView, other : PhysicsheatphaseView) -> PhysicsheatphaseView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseView::copy(self : PhysicsheatphaseView) -> PhysicsheatphaseView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseView::fill(self : PhysicsheatphaseView, v : Double) -> PhysicsheatphaseView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseView::min(self : PhysicsheatphaseView) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseView::max(self : PhysicsheatphaseView) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseView::to_string(self : PhysicsheatphaseView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_range_make(size : Int) -> PhysicsheatphaseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseRange::len(self : PhysicsheatphaseRange) -> Int { self.size }

pub fn PhysicsheatphaseRange::get(self : PhysicsheatphaseRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseRange::set(self : PhysicsheatphaseRange, i : Int, v : Double) -> PhysicsheatphaseRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseRange::sum(self : PhysicsheatphaseRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseRange::mean(self : PhysicsheatphaseRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseRange::scale(self : PhysicsheatphaseRange, f : Double) -> PhysicsheatphaseRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseRange::add(self : PhysicsheatphaseRange, other : PhysicsheatphaseRange) -> PhysicsheatphaseRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseRange::copy(self : PhysicsheatphaseRange) -> PhysicsheatphaseRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseRange::fill(self : PhysicsheatphaseRange, v : Double) -> PhysicsheatphaseRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseRange::min(self : PhysicsheatphaseRange) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseRange::max(self : PhysicsheatphaseRange) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseRange::to_string(self : PhysicsheatphaseRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_slice_make(size : Int) -> PhysicsheatphaseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatphaseSlice::len(self : PhysicsheatphaseSlice) -> Int { self.size }

pub fn PhysicsheatphaseSlice::get(self : PhysicsheatphaseSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatphaseSlice::set(self : PhysicsheatphaseSlice, i : Int, v : Double) -> PhysicsheatphaseSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseSlice::sum(self : PhysicsheatphaseSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatphaseSlice::mean(self : PhysicsheatphaseSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatphaseSlice::scale(self : PhysicsheatphaseSlice, f : Double) -> PhysicsheatphaseSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseSlice::add(self : PhysicsheatphaseSlice, other : PhysicsheatphaseSlice) -> PhysicsheatphaseSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatphaseSlice::copy(self : PhysicsheatphaseSlice) -> PhysicsheatphaseSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseSlice::fill(self : PhysicsheatphaseSlice, v : Double) -> PhysicsheatphaseSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatphaseSlice::min(self : PhysicsheatphaseSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsheatphaseSlice::max(self : PhysicsheatphaseSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsheatphaseSlice::to_string(self : PhysicsheatphaseSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

