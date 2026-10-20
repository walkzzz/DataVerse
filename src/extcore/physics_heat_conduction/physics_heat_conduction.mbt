///===
/// extcore/physics_heat_conduction

pub(all) struct PhysicsheatconductionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_conduction_make_point(x : Double, y : Double) -> PhysicsheatconductionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_conduction_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatconductionPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatconductionPoint::x(self : PhysicsheatconductionPoint) -> Double { self.x }

pub fn PhysicsheatconductionPoint::y(self : PhysicsheatconductionPoint) -> Double { self.y }

pub fn PhysicsheatconductionPoint::z(self : PhysicsheatconductionPoint) -> Double { self.z }

pub fn PhysicsheatconductionPoint::label(self : PhysicsheatconductionPoint) -> Int { self.label }

pub fn PhysicsheatconductionPoint::dist(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatconductionPoint::add(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatconductionPoint::sub(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatconductionPoint::scale(self : PhysicsheatconductionPoint, s : Double) -> PhysicsheatconductionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatconductionPoint::dot(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatconductionPoint::cross(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatconductionPoint::norm(self : PhysicsheatconductionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatconductionPoint::normalize(self : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatconductionPoint::negate(self : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatconductionPoint::mid(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatconductionPoint::lerp(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint, t : Double) -> PhysicsheatconductionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatconductionPoint::to_string(self : PhysicsheatconductionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatconductionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_conduction_make_series(vals : Array[Double], name : String) -> PhysicsheatconductionSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatconductionSeries::len(self : PhysicsheatconductionSeries) -> Int { self.vals.length() }

pub fn PhysicsheatconductionSeries::sum(self : PhysicsheatconductionSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatconductionSeries::mean(self : PhysicsheatconductionSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatconductionSeries::min(self : PhysicsheatconductionSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatconductionSeries::max(self : PhysicsheatconductionSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatconductionSeries::range(self : PhysicsheatconductionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatconductionSeries::variance(self : PhysicsheatconductionSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatconductionSeries::std(self : PhysicsheatconductionSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatconductionSeries::median(self : PhysicsheatconductionSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatconductionSeries::scale(self : PhysicsheatconductionSeries, f : Double) -> PhysicsheatconductionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatconductionSeries::add(self : PhysicsheatconductionSeries, other : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatconductionSeries::sub(self : PhysicsheatconductionSeries, other : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatconductionSeries::normalize(self : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatconductionSeries::cumsum(self : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatconductionSeries::to_string(self : PhysicsheatconductionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatconductionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_conduction_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatconductionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_conduction_matrix_identity(n : Int) -> PhysicsheatconductionMatrix {
  let m = physics_heat_conduction_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatconductionMatrix::get(self : PhysicsheatconductionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatconductionMatrix::transpose(self : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  let result = physics_heat_conduction_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatconductionMatrix::add(self : PhysicsheatconductionMatrix, other : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_conduction_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatconductionMatrix::scale(self : PhysicsheatconductionMatrix, s : Double) -> PhysicsheatconductionMatrix {
  let result = physics_heat_conduction_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatconductionMatrix::multiply(self : PhysicsheatconductionMatrix, other : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  if self.cols != other.rows { return physics_heat_conduction_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_conduction_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsheatconductionMatrix::trace(self : PhysicsheatconductionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatconductionMatrix::det(self : PhysicsheatconductionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatconductionMatrix::norm(self : PhysicsheatconductionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatconductionMatrix::to_string(self : PhysicsheatconductionMatrix) -> String {
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

pub(all) struct PhysicsheatconductionVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_conduction_make_vector(comps : Array[Double]) -> PhysicsheatconductionVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_conduction_vector_zero(dim : Int) -> PhysicsheatconductionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatconductionVector::add(self : PhysicsheatconductionVector, other : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatconductionVector::sub(self : PhysicsheatconductionVector, other : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatconductionVector::scale(self : PhysicsheatconductionVector, s : Double) -> PhysicsheatconductionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatconductionVector::dot(self : PhysicsheatconductionVector, other : PhysicsheatconductionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatconductionVector::norm(self : PhysicsheatconductionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatconductionVector::normalize(self : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatconductionVector::dist(self : PhysicsheatconductionVector, other : PhysicsheatconductionVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatconductionVector::to_string(self : PhysicsheatconductionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatconductionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_frame_make(size : Int) -> PhysicsheatconductionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionFrame::len(self : PhysicsheatconductionFrame) -> Int { self.size }

pub fn PhysicsheatconductionFrame::get(self : PhysicsheatconductionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionFrame::set(self : PhysicsheatconductionFrame, i : Int, v : Double) -> PhysicsheatconductionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionFrame::sum(self : PhysicsheatconductionFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionFrame::mean(self : PhysicsheatconductionFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionFrame::scale(self : PhysicsheatconductionFrame, f : Double) -> PhysicsheatconductionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionFrame::add(self : PhysicsheatconductionFrame, other : PhysicsheatconductionFrame) -> PhysicsheatconductionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionFrame::copy(self : PhysicsheatconductionFrame) -> PhysicsheatconductionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionFrame::fill(self : PhysicsheatconductionFrame, v : Double) -> PhysicsheatconductionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionFrame::min(self : PhysicsheatconductionFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionFrame::max(self : PhysicsheatconductionFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionFrame::to_string(self : PhysicsheatconductionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_table_make(size : Int) -> PhysicsheatconductionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionTable::len(self : PhysicsheatconductionTable) -> Int { self.size }

pub fn PhysicsheatconductionTable::get(self : PhysicsheatconductionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionTable::set(self : PhysicsheatconductionTable, i : Int, v : Double) -> PhysicsheatconductionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionTable::sum(self : PhysicsheatconductionTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionTable::mean(self : PhysicsheatconductionTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionTable::scale(self : PhysicsheatconductionTable, f : Double) -> PhysicsheatconductionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionTable::add(self : PhysicsheatconductionTable, other : PhysicsheatconductionTable) -> PhysicsheatconductionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionTable::copy(self : PhysicsheatconductionTable) -> PhysicsheatconductionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionTable::fill(self : PhysicsheatconductionTable, v : Double) -> PhysicsheatconductionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionTable::min(self : PhysicsheatconductionTable) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionTable::max(self : PhysicsheatconductionTable) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionTable::to_string(self : PhysicsheatconductionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_graphn_make(size : Int) -> PhysicsheatconductionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionGraphN::len(self : PhysicsheatconductionGraphN) -> Int { self.size }

pub fn PhysicsheatconductionGraphN::get(self : PhysicsheatconductionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionGraphN::set(self : PhysicsheatconductionGraphN, i : Int, v : Double) -> PhysicsheatconductionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionGraphN::sum(self : PhysicsheatconductionGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionGraphN::mean(self : PhysicsheatconductionGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionGraphN::scale(self : PhysicsheatconductionGraphN, f : Double) -> PhysicsheatconductionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionGraphN::add(self : PhysicsheatconductionGraphN, other : PhysicsheatconductionGraphN) -> PhysicsheatconductionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionGraphN::copy(self : PhysicsheatconductionGraphN) -> PhysicsheatconductionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionGraphN::fill(self : PhysicsheatconductionGraphN, v : Double) -> PhysicsheatconductionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionGraphN::min(self : PhysicsheatconductionGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionGraphN::max(self : PhysicsheatconductionGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionGraphN::to_string(self : PhysicsheatconductionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_node_make(size : Int) -> PhysicsheatconductionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionNode::len(self : PhysicsheatconductionNode) -> Int { self.size }

pub fn PhysicsheatconductionNode::get(self : PhysicsheatconductionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionNode::set(self : PhysicsheatconductionNode, i : Int, v : Double) -> PhysicsheatconductionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionNode::sum(self : PhysicsheatconductionNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionNode::mean(self : PhysicsheatconductionNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionNode::scale(self : PhysicsheatconductionNode, f : Double) -> PhysicsheatconductionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionNode::add(self : PhysicsheatconductionNode, other : PhysicsheatconductionNode) -> PhysicsheatconductionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionNode::copy(self : PhysicsheatconductionNode) -> PhysicsheatconductionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionNode::fill(self : PhysicsheatconductionNode, v : Double) -> PhysicsheatconductionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionNode::min(self : PhysicsheatconductionNode) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionNode::max(self : PhysicsheatconductionNode) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionNode::to_string(self : PhysicsheatconductionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_edge_make(size : Int) -> PhysicsheatconductionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionEdge::len(self : PhysicsheatconductionEdge) -> Int { self.size }

pub fn PhysicsheatconductionEdge::get(self : PhysicsheatconductionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionEdge::set(self : PhysicsheatconductionEdge, i : Int, v : Double) -> PhysicsheatconductionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionEdge::sum(self : PhysicsheatconductionEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionEdge::mean(self : PhysicsheatconductionEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionEdge::scale(self : PhysicsheatconductionEdge, f : Double) -> PhysicsheatconductionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionEdge::add(self : PhysicsheatconductionEdge, other : PhysicsheatconductionEdge) -> PhysicsheatconductionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionEdge::copy(self : PhysicsheatconductionEdge) -> PhysicsheatconductionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionEdge::fill(self : PhysicsheatconductionEdge, v : Double) -> PhysicsheatconductionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionEdge::min(self : PhysicsheatconductionEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionEdge::max(self : PhysicsheatconductionEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionEdge::to_string(self : PhysicsheatconductionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_path_make(size : Int) -> PhysicsheatconductionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionPath::len(self : PhysicsheatconductionPath) -> Int { self.size }

pub fn PhysicsheatconductionPath::get(self : PhysicsheatconductionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionPath::set(self : PhysicsheatconductionPath, i : Int, v : Double) -> PhysicsheatconductionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionPath::sum(self : PhysicsheatconductionPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionPath::mean(self : PhysicsheatconductionPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionPath::scale(self : PhysicsheatconductionPath, f : Double) -> PhysicsheatconductionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionPath::add(self : PhysicsheatconductionPath, other : PhysicsheatconductionPath) -> PhysicsheatconductionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionPath::copy(self : PhysicsheatconductionPath) -> PhysicsheatconductionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionPath::fill(self : PhysicsheatconductionPath, v : Double) -> PhysicsheatconductionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionPath::min(self : PhysicsheatconductionPath) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionPath::max(self : PhysicsheatconductionPath) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionPath::to_string(self : PhysicsheatconductionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_cluster_make(size : Int) -> PhysicsheatconductionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionCluster::len(self : PhysicsheatconductionCluster) -> Int { self.size }

pub fn PhysicsheatconductionCluster::get(self : PhysicsheatconductionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionCluster::set(self : PhysicsheatconductionCluster, i : Int, v : Double) -> PhysicsheatconductionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionCluster::sum(self : PhysicsheatconductionCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionCluster::mean(self : PhysicsheatconductionCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionCluster::scale(self : PhysicsheatconductionCluster, f : Double) -> PhysicsheatconductionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionCluster::add(self : PhysicsheatconductionCluster, other : PhysicsheatconductionCluster) -> PhysicsheatconductionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionCluster::copy(self : PhysicsheatconductionCluster) -> PhysicsheatconductionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionCluster::fill(self : PhysicsheatconductionCluster, v : Double) -> PhysicsheatconductionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionCluster::min(self : PhysicsheatconductionCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionCluster::max(self : PhysicsheatconductionCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionCluster::to_string(self : PhysicsheatconductionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_model_make(size : Int) -> PhysicsheatconductionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionModel::len(self : PhysicsheatconductionModel) -> Int { self.size }

pub fn PhysicsheatconductionModel::get(self : PhysicsheatconductionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionModel::set(self : PhysicsheatconductionModel, i : Int, v : Double) -> PhysicsheatconductionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionModel::sum(self : PhysicsheatconductionModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionModel::mean(self : PhysicsheatconductionModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionModel::scale(self : PhysicsheatconductionModel, f : Double) -> PhysicsheatconductionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionModel::add(self : PhysicsheatconductionModel, other : PhysicsheatconductionModel) -> PhysicsheatconductionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionModel::copy(self : PhysicsheatconductionModel) -> PhysicsheatconductionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionModel::fill(self : PhysicsheatconductionModel, v : Double) -> PhysicsheatconductionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionModel::min(self : PhysicsheatconductionModel) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionModel::max(self : PhysicsheatconductionModel) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionModel::to_string(self : PhysicsheatconductionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_layer_make(size : Int) -> PhysicsheatconductionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionLayer::len(self : PhysicsheatconductionLayer) -> Int { self.size }

pub fn PhysicsheatconductionLayer::get(self : PhysicsheatconductionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionLayer::set(self : PhysicsheatconductionLayer, i : Int, v : Double) -> PhysicsheatconductionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionLayer::sum(self : PhysicsheatconductionLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionLayer::mean(self : PhysicsheatconductionLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionLayer::scale(self : PhysicsheatconductionLayer, f : Double) -> PhysicsheatconductionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionLayer::add(self : PhysicsheatconductionLayer, other : PhysicsheatconductionLayer) -> PhysicsheatconductionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionLayer::copy(self : PhysicsheatconductionLayer) -> PhysicsheatconductionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionLayer::fill(self : PhysicsheatconductionLayer, v : Double) -> PhysicsheatconductionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionLayer::min(self : PhysicsheatconductionLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionLayer::max(self : PhysicsheatconductionLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionLayer::to_string(self : PhysicsheatconductionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_buffer_make(size : Int) -> PhysicsheatconductionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionBuffer::len(self : PhysicsheatconductionBuffer) -> Int { self.size }

pub fn PhysicsheatconductionBuffer::get(self : PhysicsheatconductionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionBuffer::set(self : PhysicsheatconductionBuffer, i : Int, v : Double) -> PhysicsheatconductionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionBuffer::sum(self : PhysicsheatconductionBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionBuffer::mean(self : PhysicsheatconductionBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionBuffer::scale(self : PhysicsheatconductionBuffer, f : Double) -> PhysicsheatconductionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionBuffer::add(self : PhysicsheatconductionBuffer, other : PhysicsheatconductionBuffer) -> PhysicsheatconductionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionBuffer::copy(self : PhysicsheatconductionBuffer) -> PhysicsheatconductionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionBuffer::fill(self : PhysicsheatconductionBuffer, v : Double) -> PhysicsheatconductionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionBuffer::min(self : PhysicsheatconductionBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionBuffer::max(self : PhysicsheatconductionBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionBuffer::to_string(self : PhysicsheatconductionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_cursor_make(size : Int) -> PhysicsheatconductionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionCursor::len(self : PhysicsheatconductionCursor) -> Int { self.size }

pub fn PhysicsheatconductionCursor::get(self : PhysicsheatconductionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionCursor::set(self : PhysicsheatconductionCursor, i : Int, v : Double) -> PhysicsheatconductionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionCursor::sum(self : PhysicsheatconductionCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionCursor::mean(self : PhysicsheatconductionCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionCursor::scale(self : PhysicsheatconductionCursor, f : Double) -> PhysicsheatconductionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionCursor::add(self : PhysicsheatconductionCursor, other : PhysicsheatconductionCursor) -> PhysicsheatconductionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionCursor::copy(self : PhysicsheatconductionCursor) -> PhysicsheatconductionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionCursor::fill(self : PhysicsheatconductionCursor, v : Double) -> PhysicsheatconductionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionCursor::min(self : PhysicsheatconductionCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionCursor::max(self : PhysicsheatconductionCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionCursor::to_string(self : PhysicsheatconductionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_view_make(size : Int) -> PhysicsheatconductionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionView::len(self : PhysicsheatconductionView) -> Int { self.size }

pub fn PhysicsheatconductionView::get(self : PhysicsheatconductionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionView::set(self : PhysicsheatconductionView, i : Int, v : Double) -> PhysicsheatconductionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionView::sum(self : PhysicsheatconductionView) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionView::mean(self : PhysicsheatconductionView) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionView::scale(self : PhysicsheatconductionView, f : Double) -> PhysicsheatconductionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionView::add(self : PhysicsheatconductionView, other : PhysicsheatconductionView) -> PhysicsheatconductionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionView::copy(self : PhysicsheatconductionView) -> PhysicsheatconductionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionView::fill(self : PhysicsheatconductionView, v : Double) -> PhysicsheatconductionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionView::min(self : PhysicsheatconductionView) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionView::max(self : PhysicsheatconductionView) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionView::to_string(self : PhysicsheatconductionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_range_make(size : Int) -> PhysicsheatconductionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionRange::len(self : PhysicsheatconductionRange) -> Int { self.size }

pub fn PhysicsheatconductionRange::get(self : PhysicsheatconductionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionRange::set(self : PhysicsheatconductionRange, i : Int, v : Double) -> PhysicsheatconductionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionRange::sum(self : PhysicsheatconductionRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionRange::mean(self : PhysicsheatconductionRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionRange::scale(self : PhysicsheatconductionRange, f : Double) -> PhysicsheatconductionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionRange::add(self : PhysicsheatconductionRange, other : PhysicsheatconductionRange) -> PhysicsheatconductionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionRange::copy(self : PhysicsheatconductionRange) -> PhysicsheatconductionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionRange::fill(self : PhysicsheatconductionRange, v : Double) -> PhysicsheatconductionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionRange::min(self : PhysicsheatconductionRange) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionRange::max(self : PhysicsheatconductionRange) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionRange::to_string(self : PhysicsheatconductionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_slice_make(size : Int) -> PhysicsheatconductionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatconductionSlice::len(self : PhysicsheatconductionSlice) -> Int { self.size }

pub fn PhysicsheatconductionSlice::get(self : PhysicsheatconductionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatconductionSlice::set(self : PhysicsheatconductionSlice, i : Int, v : Double) -> PhysicsheatconductionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionSlice::sum(self : PhysicsheatconductionSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatconductionSlice::mean(self : PhysicsheatconductionSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatconductionSlice::scale(self : PhysicsheatconductionSlice, f : Double) -> PhysicsheatconductionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionSlice::add(self : PhysicsheatconductionSlice, other : PhysicsheatconductionSlice) -> PhysicsheatconductionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatconductionSlice::copy(self : PhysicsheatconductionSlice) -> PhysicsheatconductionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionSlice::fill(self : PhysicsheatconductionSlice, v : Double) -> PhysicsheatconductionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatconductionSlice::min(self : PhysicsheatconductionSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsheatconductionSlice::max(self : PhysicsheatconductionSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsheatconductionSlice::to_string(self : PhysicsheatconductionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

