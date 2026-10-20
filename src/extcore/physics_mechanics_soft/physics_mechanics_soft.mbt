///===
/// extcore/physics_mechanics_soft

pub(all) struct PhysicsmechanicssoftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_soft_make_point(x : Double, y : Double) -> PhysicsmechanicssoftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_soft_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicssoftPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicssoftPoint::x(self : PhysicsmechanicssoftPoint) -> Double { self.x }

pub fn PhysicsmechanicssoftPoint::y(self : PhysicsmechanicssoftPoint) -> Double { self.y }

pub fn PhysicsmechanicssoftPoint::z(self : PhysicsmechanicssoftPoint) -> Double { self.z }

pub fn PhysicsmechanicssoftPoint::label(self : PhysicsmechanicssoftPoint) -> Int { self.label }

pub fn PhysicsmechanicssoftPoint::dist(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicssoftPoint::add(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::sub(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::scale(self : PhysicsmechanicssoftPoint, s : Double) -> PhysicsmechanicssoftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::dot(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicssoftPoint::cross(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicssoftPoint::norm(self : PhysicsmechanicssoftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicssoftPoint::normalize(self : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicssoftPoint::negate(self : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::mid(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::lerp(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint, t : Double) -> PhysicsmechanicssoftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::to_string(self : PhysicsmechanicssoftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_soft_make_series(vals : Array[Double], name : String) -> PhysicsmechanicssoftSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicssoftSeries::len(self : PhysicsmechanicssoftSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicssoftSeries::sum(self : PhysicsmechanicssoftSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicssoftSeries::mean(self : PhysicsmechanicssoftSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicssoftSeries::min(self : PhysicsmechanicssoftSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicssoftSeries::max(self : PhysicsmechanicssoftSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicssoftSeries::range(self : PhysicsmechanicssoftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicssoftSeries::variance(self : PhysicsmechanicssoftSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicssoftSeries::std(self : PhysicsmechanicssoftSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicssoftSeries::median(self : PhysicsmechanicssoftSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicssoftSeries::scale(self : PhysicsmechanicssoftSeries, f : Double) -> PhysicsmechanicssoftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicssoftSeries::add(self : PhysicsmechanicssoftSeries, other : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicssoftSeries::sub(self : PhysicsmechanicssoftSeries, other : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicssoftSeries::normalize(self : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicssoftSeries::cumsum(self : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicssoftSeries::to_string(self : PhysicsmechanicssoftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicssoftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_soft_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicssoftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_soft_matrix_identity(n : Int) -> PhysicsmechanicssoftMatrix {
  let m = physics_mechanics_soft_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicssoftMatrix::get(self : PhysicsmechanicssoftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicssoftMatrix::transpose(self : PhysicsmechanicssoftMatrix) -> PhysicsmechanicssoftMatrix {
  let result = physics_mechanics_soft_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicssoftMatrix::add(self : PhysicsmechanicssoftMatrix, other : PhysicsmechanicssoftMatrix) -> PhysicsmechanicssoftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_soft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicssoftMatrix::scale(self : PhysicsmechanicssoftMatrix, s : Double) -> PhysicsmechanicssoftMatrix {
  let result = physics_mechanics_soft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicssoftMatrix::multiply(self : PhysicsmechanicssoftMatrix, other : PhysicsmechanicssoftMatrix) -> PhysicsmechanicssoftMatrix {
  if self.cols != other.rows { return physics_mechanics_soft_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_soft_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsmechanicssoftMatrix::trace(self : PhysicsmechanicssoftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicssoftMatrix::det(self : PhysicsmechanicssoftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicssoftMatrix::norm(self : PhysicsmechanicssoftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicssoftMatrix::to_string(self : PhysicsmechanicssoftMatrix) -> String {
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

pub(all) struct PhysicsmechanicssoftVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_soft_make_vector(comps : Array[Double]) -> PhysicsmechanicssoftVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_soft_vector_zero(dim : Int) -> PhysicsmechanicssoftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicssoftVector::add(self : PhysicsmechanicssoftVector, other : PhysicsmechanicssoftVector) -> PhysicsmechanicssoftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicssoftVector::sub(self : PhysicsmechanicssoftVector, other : PhysicsmechanicssoftVector) -> PhysicsmechanicssoftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicssoftVector::scale(self : PhysicsmechanicssoftVector, s : Double) -> PhysicsmechanicssoftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicssoftVector::dot(self : PhysicsmechanicssoftVector, other : PhysicsmechanicssoftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicssoftVector::norm(self : PhysicsmechanicssoftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicssoftVector::normalize(self : PhysicsmechanicssoftVector) -> PhysicsmechanicssoftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicssoftVector::dist(self : PhysicsmechanicssoftVector, other : PhysicsmechanicssoftVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicssoftVector::to_string(self : PhysicsmechanicssoftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicssoftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_frame_make(size : Int) -> PhysicsmechanicssoftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftFrame::len(self : PhysicsmechanicssoftFrame) -> Int { self.size }

pub fn PhysicsmechanicssoftFrame::get(self : PhysicsmechanicssoftFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftFrame::set(self : PhysicsmechanicssoftFrame, i : Int, v : Double) -> PhysicsmechanicssoftFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftFrame::sum(self : PhysicsmechanicssoftFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftFrame::mean(self : PhysicsmechanicssoftFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftFrame::scale(self : PhysicsmechanicssoftFrame, f : Double) -> PhysicsmechanicssoftFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftFrame::add(self : PhysicsmechanicssoftFrame, other : PhysicsmechanicssoftFrame) -> PhysicsmechanicssoftFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftFrame::copy(self : PhysicsmechanicssoftFrame) -> PhysicsmechanicssoftFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftFrame::fill(self : PhysicsmechanicssoftFrame, v : Double) -> PhysicsmechanicssoftFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftFrame::min(self : PhysicsmechanicssoftFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftFrame::max(self : PhysicsmechanicssoftFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftFrame::to_string(self : PhysicsmechanicssoftFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_table_make(size : Int) -> PhysicsmechanicssoftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftTable::len(self : PhysicsmechanicssoftTable) -> Int { self.size }

pub fn PhysicsmechanicssoftTable::get(self : PhysicsmechanicssoftTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftTable::set(self : PhysicsmechanicssoftTable, i : Int, v : Double) -> PhysicsmechanicssoftTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftTable::sum(self : PhysicsmechanicssoftTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftTable::mean(self : PhysicsmechanicssoftTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftTable::scale(self : PhysicsmechanicssoftTable, f : Double) -> PhysicsmechanicssoftTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftTable::add(self : PhysicsmechanicssoftTable, other : PhysicsmechanicssoftTable) -> PhysicsmechanicssoftTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftTable::copy(self : PhysicsmechanicssoftTable) -> PhysicsmechanicssoftTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftTable::fill(self : PhysicsmechanicssoftTable, v : Double) -> PhysicsmechanicssoftTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftTable::min(self : PhysicsmechanicssoftTable) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftTable::max(self : PhysicsmechanicssoftTable) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftTable::to_string(self : PhysicsmechanicssoftTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_graphn_make(size : Int) -> PhysicsmechanicssoftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftGraphN::len(self : PhysicsmechanicssoftGraphN) -> Int { self.size }

pub fn PhysicsmechanicssoftGraphN::get(self : PhysicsmechanicssoftGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftGraphN::set(self : PhysicsmechanicssoftGraphN, i : Int, v : Double) -> PhysicsmechanicssoftGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftGraphN::sum(self : PhysicsmechanicssoftGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftGraphN::mean(self : PhysicsmechanicssoftGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftGraphN::scale(self : PhysicsmechanicssoftGraphN, f : Double) -> PhysicsmechanicssoftGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftGraphN::add(self : PhysicsmechanicssoftGraphN, other : PhysicsmechanicssoftGraphN) -> PhysicsmechanicssoftGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftGraphN::copy(self : PhysicsmechanicssoftGraphN) -> PhysicsmechanicssoftGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftGraphN::fill(self : PhysicsmechanicssoftGraphN, v : Double) -> PhysicsmechanicssoftGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftGraphN::min(self : PhysicsmechanicssoftGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftGraphN::max(self : PhysicsmechanicssoftGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftGraphN::to_string(self : PhysicsmechanicssoftGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_node_make(size : Int) -> PhysicsmechanicssoftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftNode::len(self : PhysicsmechanicssoftNode) -> Int { self.size }

pub fn PhysicsmechanicssoftNode::get(self : PhysicsmechanicssoftNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftNode::set(self : PhysicsmechanicssoftNode, i : Int, v : Double) -> PhysicsmechanicssoftNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftNode::sum(self : PhysicsmechanicssoftNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftNode::mean(self : PhysicsmechanicssoftNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftNode::scale(self : PhysicsmechanicssoftNode, f : Double) -> PhysicsmechanicssoftNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftNode::add(self : PhysicsmechanicssoftNode, other : PhysicsmechanicssoftNode) -> PhysicsmechanicssoftNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftNode::copy(self : PhysicsmechanicssoftNode) -> PhysicsmechanicssoftNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftNode::fill(self : PhysicsmechanicssoftNode, v : Double) -> PhysicsmechanicssoftNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftNode::min(self : PhysicsmechanicssoftNode) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftNode::max(self : PhysicsmechanicssoftNode) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftNode::to_string(self : PhysicsmechanicssoftNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_edge_make(size : Int) -> PhysicsmechanicssoftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftEdge::len(self : PhysicsmechanicssoftEdge) -> Int { self.size }

pub fn PhysicsmechanicssoftEdge::get(self : PhysicsmechanicssoftEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftEdge::set(self : PhysicsmechanicssoftEdge, i : Int, v : Double) -> PhysicsmechanicssoftEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftEdge::sum(self : PhysicsmechanicssoftEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftEdge::mean(self : PhysicsmechanicssoftEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftEdge::scale(self : PhysicsmechanicssoftEdge, f : Double) -> PhysicsmechanicssoftEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftEdge::add(self : PhysicsmechanicssoftEdge, other : PhysicsmechanicssoftEdge) -> PhysicsmechanicssoftEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftEdge::copy(self : PhysicsmechanicssoftEdge) -> PhysicsmechanicssoftEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftEdge::fill(self : PhysicsmechanicssoftEdge, v : Double) -> PhysicsmechanicssoftEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftEdge::min(self : PhysicsmechanicssoftEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftEdge::max(self : PhysicsmechanicssoftEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftEdge::to_string(self : PhysicsmechanicssoftEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_path_make(size : Int) -> PhysicsmechanicssoftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftPath::len(self : PhysicsmechanicssoftPath) -> Int { self.size }

pub fn PhysicsmechanicssoftPath::get(self : PhysicsmechanicssoftPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftPath::set(self : PhysicsmechanicssoftPath, i : Int, v : Double) -> PhysicsmechanicssoftPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftPath::sum(self : PhysicsmechanicssoftPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftPath::mean(self : PhysicsmechanicssoftPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftPath::scale(self : PhysicsmechanicssoftPath, f : Double) -> PhysicsmechanicssoftPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftPath::add(self : PhysicsmechanicssoftPath, other : PhysicsmechanicssoftPath) -> PhysicsmechanicssoftPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftPath::copy(self : PhysicsmechanicssoftPath) -> PhysicsmechanicssoftPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftPath::fill(self : PhysicsmechanicssoftPath, v : Double) -> PhysicsmechanicssoftPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftPath::min(self : PhysicsmechanicssoftPath) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftPath::max(self : PhysicsmechanicssoftPath) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftPath::to_string(self : PhysicsmechanicssoftPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_cluster_make(size : Int) -> PhysicsmechanicssoftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftCluster::len(self : PhysicsmechanicssoftCluster) -> Int { self.size }

pub fn PhysicsmechanicssoftCluster::get(self : PhysicsmechanicssoftCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftCluster::set(self : PhysicsmechanicssoftCluster, i : Int, v : Double) -> PhysicsmechanicssoftCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftCluster::sum(self : PhysicsmechanicssoftCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftCluster::mean(self : PhysicsmechanicssoftCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftCluster::scale(self : PhysicsmechanicssoftCluster, f : Double) -> PhysicsmechanicssoftCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftCluster::add(self : PhysicsmechanicssoftCluster, other : PhysicsmechanicssoftCluster) -> PhysicsmechanicssoftCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftCluster::copy(self : PhysicsmechanicssoftCluster) -> PhysicsmechanicssoftCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftCluster::fill(self : PhysicsmechanicssoftCluster, v : Double) -> PhysicsmechanicssoftCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftCluster::min(self : PhysicsmechanicssoftCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftCluster::max(self : PhysicsmechanicssoftCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftCluster::to_string(self : PhysicsmechanicssoftCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_model_make(size : Int) -> PhysicsmechanicssoftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftModel::len(self : PhysicsmechanicssoftModel) -> Int { self.size }

pub fn PhysicsmechanicssoftModel::get(self : PhysicsmechanicssoftModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftModel::set(self : PhysicsmechanicssoftModel, i : Int, v : Double) -> PhysicsmechanicssoftModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftModel::sum(self : PhysicsmechanicssoftModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftModel::mean(self : PhysicsmechanicssoftModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftModel::scale(self : PhysicsmechanicssoftModel, f : Double) -> PhysicsmechanicssoftModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftModel::add(self : PhysicsmechanicssoftModel, other : PhysicsmechanicssoftModel) -> PhysicsmechanicssoftModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftModel::copy(self : PhysicsmechanicssoftModel) -> PhysicsmechanicssoftModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftModel::fill(self : PhysicsmechanicssoftModel, v : Double) -> PhysicsmechanicssoftModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftModel::min(self : PhysicsmechanicssoftModel) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftModel::max(self : PhysicsmechanicssoftModel) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftModel::to_string(self : PhysicsmechanicssoftModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_layer_make(size : Int) -> PhysicsmechanicssoftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftLayer::len(self : PhysicsmechanicssoftLayer) -> Int { self.size }

pub fn PhysicsmechanicssoftLayer::get(self : PhysicsmechanicssoftLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftLayer::set(self : PhysicsmechanicssoftLayer, i : Int, v : Double) -> PhysicsmechanicssoftLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftLayer::sum(self : PhysicsmechanicssoftLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftLayer::mean(self : PhysicsmechanicssoftLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftLayer::scale(self : PhysicsmechanicssoftLayer, f : Double) -> PhysicsmechanicssoftLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftLayer::add(self : PhysicsmechanicssoftLayer, other : PhysicsmechanicssoftLayer) -> PhysicsmechanicssoftLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftLayer::copy(self : PhysicsmechanicssoftLayer) -> PhysicsmechanicssoftLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftLayer::fill(self : PhysicsmechanicssoftLayer, v : Double) -> PhysicsmechanicssoftLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftLayer::min(self : PhysicsmechanicssoftLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftLayer::max(self : PhysicsmechanicssoftLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftLayer::to_string(self : PhysicsmechanicssoftLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_buffer_make(size : Int) -> PhysicsmechanicssoftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftBuffer::len(self : PhysicsmechanicssoftBuffer) -> Int { self.size }

pub fn PhysicsmechanicssoftBuffer::get(self : PhysicsmechanicssoftBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftBuffer::set(self : PhysicsmechanicssoftBuffer, i : Int, v : Double) -> PhysicsmechanicssoftBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftBuffer::sum(self : PhysicsmechanicssoftBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftBuffer::mean(self : PhysicsmechanicssoftBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftBuffer::scale(self : PhysicsmechanicssoftBuffer, f : Double) -> PhysicsmechanicssoftBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftBuffer::add(self : PhysicsmechanicssoftBuffer, other : PhysicsmechanicssoftBuffer) -> PhysicsmechanicssoftBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftBuffer::copy(self : PhysicsmechanicssoftBuffer) -> PhysicsmechanicssoftBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftBuffer::fill(self : PhysicsmechanicssoftBuffer, v : Double) -> PhysicsmechanicssoftBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftBuffer::min(self : PhysicsmechanicssoftBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftBuffer::max(self : PhysicsmechanicssoftBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftBuffer::to_string(self : PhysicsmechanicssoftBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_cursor_make(size : Int) -> PhysicsmechanicssoftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftCursor::len(self : PhysicsmechanicssoftCursor) -> Int { self.size }

pub fn PhysicsmechanicssoftCursor::get(self : PhysicsmechanicssoftCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftCursor::set(self : PhysicsmechanicssoftCursor, i : Int, v : Double) -> PhysicsmechanicssoftCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftCursor::sum(self : PhysicsmechanicssoftCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftCursor::mean(self : PhysicsmechanicssoftCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftCursor::scale(self : PhysicsmechanicssoftCursor, f : Double) -> PhysicsmechanicssoftCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftCursor::add(self : PhysicsmechanicssoftCursor, other : PhysicsmechanicssoftCursor) -> PhysicsmechanicssoftCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftCursor::copy(self : PhysicsmechanicssoftCursor) -> PhysicsmechanicssoftCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftCursor::fill(self : PhysicsmechanicssoftCursor, v : Double) -> PhysicsmechanicssoftCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftCursor::min(self : PhysicsmechanicssoftCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftCursor::max(self : PhysicsmechanicssoftCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftCursor::to_string(self : PhysicsmechanicssoftCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_view_make(size : Int) -> PhysicsmechanicssoftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftView::len(self : PhysicsmechanicssoftView) -> Int { self.size }

pub fn PhysicsmechanicssoftView::get(self : PhysicsmechanicssoftView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftView::set(self : PhysicsmechanicssoftView, i : Int, v : Double) -> PhysicsmechanicssoftView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftView::sum(self : PhysicsmechanicssoftView) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftView::mean(self : PhysicsmechanicssoftView) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftView::scale(self : PhysicsmechanicssoftView, f : Double) -> PhysicsmechanicssoftView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftView::add(self : PhysicsmechanicssoftView, other : PhysicsmechanicssoftView) -> PhysicsmechanicssoftView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftView::copy(self : PhysicsmechanicssoftView) -> PhysicsmechanicssoftView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftView::fill(self : PhysicsmechanicssoftView, v : Double) -> PhysicsmechanicssoftView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftView::min(self : PhysicsmechanicssoftView) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftView::max(self : PhysicsmechanicssoftView) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftView::to_string(self : PhysicsmechanicssoftView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_range_make(size : Int) -> PhysicsmechanicssoftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftRange::len(self : PhysicsmechanicssoftRange) -> Int { self.size }

pub fn PhysicsmechanicssoftRange::get(self : PhysicsmechanicssoftRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftRange::set(self : PhysicsmechanicssoftRange, i : Int, v : Double) -> PhysicsmechanicssoftRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftRange::sum(self : PhysicsmechanicssoftRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftRange::mean(self : PhysicsmechanicssoftRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftRange::scale(self : PhysicsmechanicssoftRange, f : Double) -> PhysicsmechanicssoftRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftRange::add(self : PhysicsmechanicssoftRange, other : PhysicsmechanicssoftRange) -> PhysicsmechanicssoftRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftRange::copy(self : PhysicsmechanicssoftRange) -> PhysicsmechanicssoftRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftRange::fill(self : PhysicsmechanicssoftRange, v : Double) -> PhysicsmechanicssoftRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftRange::min(self : PhysicsmechanicssoftRange) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftRange::max(self : PhysicsmechanicssoftRange) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftRange::to_string(self : PhysicsmechanicssoftRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_slice_make(size : Int) -> PhysicsmechanicssoftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicssoftSlice::len(self : PhysicsmechanicssoftSlice) -> Int { self.size }

pub fn PhysicsmechanicssoftSlice::get(self : PhysicsmechanicssoftSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicssoftSlice::set(self : PhysicsmechanicssoftSlice, i : Int, v : Double) -> PhysicsmechanicssoftSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftSlice::sum(self : PhysicsmechanicssoftSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicssoftSlice::mean(self : PhysicsmechanicssoftSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicssoftSlice::scale(self : PhysicsmechanicssoftSlice, f : Double) -> PhysicsmechanicssoftSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftSlice::add(self : PhysicsmechanicssoftSlice, other : PhysicsmechanicssoftSlice) -> PhysicsmechanicssoftSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicssoftSlice::copy(self : PhysicsmechanicssoftSlice) -> PhysicsmechanicssoftSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftSlice::fill(self : PhysicsmechanicssoftSlice, v : Double) -> PhysicsmechanicssoftSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicssoftSlice::min(self : PhysicsmechanicssoftSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicssoftSlice::max(self : PhysicsmechanicssoftSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicssoftSlice::to_string(self : PhysicsmechanicssoftSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

