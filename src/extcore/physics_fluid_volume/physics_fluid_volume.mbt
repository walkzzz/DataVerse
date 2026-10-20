///===
/// extcore/physics_fluid_volume

pub(all) struct PhysicsfluidvolumePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_volume_make_point(x : Double, y : Double) -> PhysicsfluidvolumePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_volume_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidvolumePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidvolumePoint::x(self : PhysicsfluidvolumePoint) -> Double { self.x }

pub fn PhysicsfluidvolumePoint::y(self : PhysicsfluidvolumePoint) -> Double { self.y }

pub fn PhysicsfluidvolumePoint::z(self : PhysicsfluidvolumePoint) -> Double { self.z }

pub fn PhysicsfluidvolumePoint::label(self : PhysicsfluidvolumePoint) -> Int { self.label }

pub fn PhysicsfluidvolumePoint::dist(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidvolumePoint::add(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidvolumePoint::sub(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidvolumePoint::scale(self : PhysicsfluidvolumePoint, s : Double) -> PhysicsfluidvolumePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidvolumePoint::dot(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidvolumePoint::cross(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidvolumePoint::norm(self : PhysicsfluidvolumePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidvolumePoint::normalize(self : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidvolumePoint::negate(self : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidvolumePoint::mid(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidvolumePoint::lerp(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint, t : Double) -> PhysicsfluidvolumePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidvolumePoint::to_string(self : PhysicsfluidvolumePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_volume_make_series(vals : Array[Double], name : String) -> PhysicsfluidvolumeSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidvolumeSeries::len(self : PhysicsfluidvolumeSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidvolumeSeries::sum(self : PhysicsfluidvolumeSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidvolumeSeries::mean(self : PhysicsfluidvolumeSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidvolumeSeries::min(self : PhysicsfluidvolumeSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidvolumeSeries::max(self : PhysicsfluidvolumeSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidvolumeSeries::range(self : PhysicsfluidvolumeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidvolumeSeries::variance(self : PhysicsfluidvolumeSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidvolumeSeries::std(self : PhysicsfluidvolumeSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidvolumeSeries::median(self : PhysicsfluidvolumeSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidvolumeSeries::scale(self : PhysicsfluidvolumeSeries, f : Double) -> PhysicsfluidvolumeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidvolumeSeries::add(self : PhysicsfluidvolumeSeries, other : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidvolumeSeries::sub(self : PhysicsfluidvolumeSeries, other : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidvolumeSeries::normalize(self : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidvolumeSeries::cumsum(self : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidvolumeSeries::to_string(self : PhysicsfluidvolumeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidvolumeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_volume_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidvolumeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_volume_matrix_identity(n : Int) -> PhysicsfluidvolumeMatrix {
  let m = physics_fluid_volume_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidvolumeMatrix::get(self : PhysicsfluidvolumeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidvolumeMatrix::transpose(self : PhysicsfluidvolumeMatrix) -> PhysicsfluidvolumeMatrix {
  let result = physics_fluid_volume_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidvolumeMatrix::add(self : PhysicsfluidvolumeMatrix, other : PhysicsfluidvolumeMatrix) -> PhysicsfluidvolumeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_volume_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidvolumeMatrix::scale(self : PhysicsfluidvolumeMatrix, s : Double) -> PhysicsfluidvolumeMatrix {
  let result = physics_fluid_volume_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidvolumeMatrix::multiply(self : PhysicsfluidvolumeMatrix, other : PhysicsfluidvolumeMatrix) -> PhysicsfluidvolumeMatrix {
  if self.cols != other.rows { return physics_fluid_volume_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_volume_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluidvolumeMatrix::trace(self : PhysicsfluidvolumeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidvolumeMatrix::det(self : PhysicsfluidvolumeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidvolumeMatrix::norm(self : PhysicsfluidvolumeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidvolumeMatrix::to_string(self : PhysicsfluidvolumeMatrix) -> String {
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

pub(all) struct PhysicsfluidvolumeVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_volume_make_vector(comps : Array[Double]) -> PhysicsfluidvolumeVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_volume_vector_zero(dim : Int) -> PhysicsfluidvolumeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidvolumeVector::add(self : PhysicsfluidvolumeVector, other : PhysicsfluidvolumeVector) -> PhysicsfluidvolumeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidvolumeVector::sub(self : PhysicsfluidvolumeVector, other : PhysicsfluidvolumeVector) -> PhysicsfluidvolumeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidvolumeVector::scale(self : PhysicsfluidvolumeVector, s : Double) -> PhysicsfluidvolumeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidvolumeVector::dot(self : PhysicsfluidvolumeVector, other : PhysicsfluidvolumeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidvolumeVector::norm(self : PhysicsfluidvolumeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidvolumeVector::normalize(self : PhysicsfluidvolumeVector) -> PhysicsfluidvolumeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidvolumeVector::dist(self : PhysicsfluidvolumeVector, other : PhysicsfluidvolumeVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidvolumeVector::to_string(self : PhysicsfluidvolumeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidvolumeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_frame_make(size : Int) -> PhysicsfluidvolumeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeFrame::len(self : PhysicsfluidvolumeFrame) -> Int { self.size }

pub fn PhysicsfluidvolumeFrame::get(self : PhysicsfluidvolumeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeFrame::set(self : PhysicsfluidvolumeFrame, i : Int, v : Double) -> PhysicsfluidvolumeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeFrame::sum(self : PhysicsfluidvolumeFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeFrame::mean(self : PhysicsfluidvolumeFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeFrame::scale(self : PhysicsfluidvolumeFrame, f : Double) -> PhysicsfluidvolumeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeFrame::add(self : PhysicsfluidvolumeFrame, other : PhysicsfluidvolumeFrame) -> PhysicsfluidvolumeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeFrame::copy(self : PhysicsfluidvolumeFrame) -> PhysicsfluidvolumeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeFrame::fill(self : PhysicsfluidvolumeFrame, v : Double) -> PhysicsfluidvolumeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeFrame::min(self : PhysicsfluidvolumeFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeFrame::max(self : PhysicsfluidvolumeFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeFrame::to_string(self : PhysicsfluidvolumeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_table_make(size : Int) -> PhysicsfluidvolumeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeTable::len(self : PhysicsfluidvolumeTable) -> Int { self.size }

pub fn PhysicsfluidvolumeTable::get(self : PhysicsfluidvolumeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeTable::set(self : PhysicsfluidvolumeTable, i : Int, v : Double) -> PhysicsfluidvolumeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeTable::sum(self : PhysicsfluidvolumeTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeTable::mean(self : PhysicsfluidvolumeTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeTable::scale(self : PhysicsfluidvolumeTable, f : Double) -> PhysicsfluidvolumeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeTable::add(self : PhysicsfluidvolumeTable, other : PhysicsfluidvolumeTable) -> PhysicsfluidvolumeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeTable::copy(self : PhysicsfluidvolumeTable) -> PhysicsfluidvolumeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeTable::fill(self : PhysicsfluidvolumeTable, v : Double) -> PhysicsfluidvolumeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeTable::min(self : PhysicsfluidvolumeTable) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeTable::max(self : PhysicsfluidvolumeTable) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeTable::to_string(self : PhysicsfluidvolumeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_graphn_make(size : Int) -> PhysicsfluidvolumeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeGraphN::len(self : PhysicsfluidvolumeGraphN) -> Int { self.size }

pub fn PhysicsfluidvolumeGraphN::get(self : PhysicsfluidvolumeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeGraphN::set(self : PhysicsfluidvolumeGraphN, i : Int, v : Double) -> PhysicsfluidvolumeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeGraphN::sum(self : PhysicsfluidvolumeGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeGraphN::mean(self : PhysicsfluidvolumeGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeGraphN::scale(self : PhysicsfluidvolumeGraphN, f : Double) -> PhysicsfluidvolumeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeGraphN::add(self : PhysicsfluidvolumeGraphN, other : PhysicsfluidvolumeGraphN) -> PhysicsfluidvolumeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeGraphN::copy(self : PhysicsfluidvolumeGraphN) -> PhysicsfluidvolumeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeGraphN::fill(self : PhysicsfluidvolumeGraphN, v : Double) -> PhysicsfluidvolumeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeGraphN::min(self : PhysicsfluidvolumeGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeGraphN::max(self : PhysicsfluidvolumeGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeGraphN::to_string(self : PhysicsfluidvolumeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_node_make(size : Int) -> PhysicsfluidvolumeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeNode::len(self : PhysicsfluidvolumeNode) -> Int { self.size }

pub fn PhysicsfluidvolumeNode::get(self : PhysicsfluidvolumeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeNode::set(self : PhysicsfluidvolumeNode, i : Int, v : Double) -> PhysicsfluidvolumeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeNode::sum(self : PhysicsfluidvolumeNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeNode::mean(self : PhysicsfluidvolumeNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeNode::scale(self : PhysicsfluidvolumeNode, f : Double) -> PhysicsfluidvolumeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeNode::add(self : PhysicsfluidvolumeNode, other : PhysicsfluidvolumeNode) -> PhysicsfluidvolumeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeNode::copy(self : PhysicsfluidvolumeNode) -> PhysicsfluidvolumeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeNode::fill(self : PhysicsfluidvolumeNode, v : Double) -> PhysicsfluidvolumeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeNode::min(self : PhysicsfluidvolumeNode) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeNode::max(self : PhysicsfluidvolumeNode) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeNode::to_string(self : PhysicsfluidvolumeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_edge_make(size : Int) -> PhysicsfluidvolumeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeEdge::len(self : PhysicsfluidvolumeEdge) -> Int { self.size }

pub fn PhysicsfluidvolumeEdge::get(self : PhysicsfluidvolumeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeEdge::set(self : PhysicsfluidvolumeEdge, i : Int, v : Double) -> PhysicsfluidvolumeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeEdge::sum(self : PhysicsfluidvolumeEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeEdge::mean(self : PhysicsfluidvolumeEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeEdge::scale(self : PhysicsfluidvolumeEdge, f : Double) -> PhysicsfluidvolumeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeEdge::add(self : PhysicsfluidvolumeEdge, other : PhysicsfluidvolumeEdge) -> PhysicsfluidvolumeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeEdge::copy(self : PhysicsfluidvolumeEdge) -> PhysicsfluidvolumeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeEdge::fill(self : PhysicsfluidvolumeEdge, v : Double) -> PhysicsfluidvolumeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeEdge::min(self : PhysicsfluidvolumeEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeEdge::max(self : PhysicsfluidvolumeEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeEdge::to_string(self : PhysicsfluidvolumeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_path_make(size : Int) -> PhysicsfluidvolumePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumePath::len(self : PhysicsfluidvolumePath) -> Int { self.size }

pub fn PhysicsfluidvolumePath::get(self : PhysicsfluidvolumePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumePath::set(self : PhysicsfluidvolumePath, i : Int, v : Double) -> PhysicsfluidvolumePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumePath::sum(self : PhysicsfluidvolumePath) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumePath::mean(self : PhysicsfluidvolumePath) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumePath::scale(self : PhysicsfluidvolumePath, f : Double) -> PhysicsfluidvolumePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumePath::add(self : PhysicsfluidvolumePath, other : PhysicsfluidvolumePath) -> PhysicsfluidvolumePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumePath::copy(self : PhysicsfluidvolumePath) -> PhysicsfluidvolumePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumePath::fill(self : PhysicsfluidvolumePath, v : Double) -> PhysicsfluidvolumePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumePath::min(self : PhysicsfluidvolumePath) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumePath::max(self : PhysicsfluidvolumePath) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumePath::to_string(self : PhysicsfluidvolumePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_cluster_make(size : Int) -> PhysicsfluidvolumeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeCluster::len(self : PhysicsfluidvolumeCluster) -> Int { self.size }

pub fn PhysicsfluidvolumeCluster::get(self : PhysicsfluidvolumeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeCluster::set(self : PhysicsfluidvolumeCluster, i : Int, v : Double) -> PhysicsfluidvolumeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeCluster::sum(self : PhysicsfluidvolumeCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeCluster::mean(self : PhysicsfluidvolumeCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeCluster::scale(self : PhysicsfluidvolumeCluster, f : Double) -> PhysicsfluidvolumeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeCluster::add(self : PhysicsfluidvolumeCluster, other : PhysicsfluidvolumeCluster) -> PhysicsfluidvolumeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeCluster::copy(self : PhysicsfluidvolumeCluster) -> PhysicsfluidvolumeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeCluster::fill(self : PhysicsfluidvolumeCluster, v : Double) -> PhysicsfluidvolumeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeCluster::min(self : PhysicsfluidvolumeCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeCluster::max(self : PhysicsfluidvolumeCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeCluster::to_string(self : PhysicsfluidvolumeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_model_make(size : Int) -> PhysicsfluidvolumeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeModel::len(self : PhysicsfluidvolumeModel) -> Int { self.size }

pub fn PhysicsfluidvolumeModel::get(self : PhysicsfluidvolumeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeModel::set(self : PhysicsfluidvolumeModel, i : Int, v : Double) -> PhysicsfluidvolumeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeModel::sum(self : PhysicsfluidvolumeModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeModel::mean(self : PhysicsfluidvolumeModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeModel::scale(self : PhysicsfluidvolumeModel, f : Double) -> PhysicsfluidvolumeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeModel::add(self : PhysicsfluidvolumeModel, other : PhysicsfluidvolumeModel) -> PhysicsfluidvolumeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeModel::copy(self : PhysicsfluidvolumeModel) -> PhysicsfluidvolumeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeModel::fill(self : PhysicsfluidvolumeModel, v : Double) -> PhysicsfluidvolumeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeModel::min(self : PhysicsfluidvolumeModel) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeModel::max(self : PhysicsfluidvolumeModel) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeModel::to_string(self : PhysicsfluidvolumeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_layer_make(size : Int) -> PhysicsfluidvolumeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeLayer::len(self : PhysicsfluidvolumeLayer) -> Int { self.size }

pub fn PhysicsfluidvolumeLayer::get(self : PhysicsfluidvolumeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeLayer::set(self : PhysicsfluidvolumeLayer, i : Int, v : Double) -> PhysicsfluidvolumeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeLayer::sum(self : PhysicsfluidvolumeLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeLayer::mean(self : PhysicsfluidvolumeLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeLayer::scale(self : PhysicsfluidvolumeLayer, f : Double) -> PhysicsfluidvolumeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeLayer::add(self : PhysicsfluidvolumeLayer, other : PhysicsfluidvolumeLayer) -> PhysicsfluidvolumeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeLayer::copy(self : PhysicsfluidvolumeLayer) -> PhysicsfluidvolumeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeLayer::fill(self : PhysicsfluidvolumeLayer, v : Double) -> PhysicsfluidvolumeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeLayer::min(self : PhysicsfluidvolumeLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeLayer::max(self : PhysicsfluidvolumeLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeLayer::to_string(self : PhysicsfluidvolumeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_buffer_make(size : Int) -> PhysicsfluidvolumeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeBuffer::len(self : PhysicsfluidvolumeBuffer) -> Int { self.size }

pub fn PhysicsfluidvolumeBuffer::get(self : PhysicsfluidvolumeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeBuffer::set(self : PhysicsfluidvolumeBuffer, i : Int, v : Double) -> PhysicsfluidvolumeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeBuffer::sum(self : PhysicsfluidvolumeBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeBuffer::mean(self : PhysicsfluidvolumeBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeBuffer::scale(self : PhysicsfluidvolumeBuffer, f : Double) -> PhysicsfluidvolumeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeBuffer::add(self : PhysicsfluidvolumeBuffer, other : PhysicsfluidvolumeBuffer) -> PhysicsfluidvolumeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeBuffer::copy(self : PhysicsfluidvolumeBuffer) -> PhysicsfluidvolumeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeBuffer::fill(self : PhysicsfluidvolumeBuffer, v : Double) -> PhysicsfluidvolumeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeBuffer::min(self : PhysicsfluidvolumeBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeBuffer::max(self : PhysicsfluidvolumeBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeBuffer::to_string(self : PhysicsfluidvolumeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_cursor_make(size : Int) -> PhysicsfluidvolumeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeCursor::len(self : PhysicsfluidvolumeCursor) -> Int { self.size }

pub fn PhysicsfluidvolumeCursor::get(self : PhysicsfluidvolumeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeCursor::set(self : PhysicsfluidvolumeCursor, i : Int, v : Double) -> PhysicsfluidvolumeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeCursor::sum(self : PhysicsfluidvolumeCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeCursor::mean(self : PhysicsfluidvolumeCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeCursor::scale(self : PhysicsfluidvolumeCursor, f : Double) -> PhysicsfluidvolumeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeCursor::add(self : PhysicsfluidvolumeCursor, other : PhysicsfluidvolumeCursor) -> PhysicsfluidvolumeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeCursor::copy(self : PhysicsfluidvolumeCursor) -> PhysicsfluidvolumeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeCursor::fill(self : PhysicsfluidvolumeCursor, v : Double) -> PhysicsfluidvolumeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeCursor::min(self : PhysicsfluidvolumeCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeCursor::max(self : PhysicsfluidvolumeCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeCursor::to_string(self : PhysicsfluidvolumeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_view_make(size : Int) -> PhysicsfluidvolumeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeView::len(self : PhysicsfluidvolumeView) -> Int { self.size }

pub fn PhysicsfluidvolumeView::get(self : PhysicsfluidvolumeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeView::set(self : PhysicsfluidvolumeView, i : Int, v : Double) -> PhysicsfluidvolumeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeView::sum(self : PhysicsfluidvolumeView) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeView::mean(self : PhysicsfluidvolumeView) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeView::scale(self : PhysicsfluidvolumeView, f : Double) -> PhysicsfluidvolumeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeView::add(self : PhysicsfluidvolumeView, other : PhysicsfluidvolumeView) -> PhysicsfluidvolumeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeView::copy(self : PhysicsfluidvolumeView) -> PhysicsfluidvolumeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeView::fill(self : PhysicsfluidvolumeView, v : Double) -> PhysicsfluidvolumeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeView::min(self : PhysicsfluidvolumeView) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeView::max(self : PhysicsfluidvolumeView) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeView::to_string(self : PhysicsfluidvolumeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_range_make(size : Int) -> PhysicsfluidvolumeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeRange::len(self : PhysicsfluidvolumeRange) -> Int { self.size }

pub fn PhysicsfluidvolumeRange::get(self : PhysicsfluidvolumeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeRange::set(self : PhysicsfluidvolumeRange, i : Int, v : Double) -> PhysicsfluidvolumeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeRange::sum(self : PhysicsfluidvolumeRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeRange::mean(self : PhysicsfluidvolumeRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeRange::scale(self : PhysicsfluidvolumeRange, f : Double) -> PhysicsfluidvolumeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeRange::add(self : PhysicsfluidvolumeRange, other : PhysicsfluidvolumeRange) -> PhysicsfluidvolumeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeRange::copy(self : PhysicsfluidvolumeRange) -> PhysicsfluidvolumeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeRange::fill(self : PhysicsfluidvolumeRange, v : Double) -> PhysicsfluidvolumeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeRange::min(self : PhysicsfluidvolumeRange) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeRange::max(self : PhysicsfluidvolumeRange) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeRange::to_string(self : PhysicsfluidvolumeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_slice_make(size : Int) -> PhysicsfluidvolumeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvolumeSlice::len(self : PhysicsfluidvolumeSlice) -> Int { self.size }

pub fn PhysicsfluidvolumeSlice::get(self : PhysicsfluidvolumeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvolumeSlice::set(self : PhysicsfluidvolumeSlice, i : Int, v : Double) -> PhysicsfluidvolumeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeSlice::sum(self : PhysicsfluidvolumeSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvolumeSlice::mean(self : PhysicsfluidvolumeSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvolumeSlice::scale(self : PhysicsfluidvolumeSlice, f : Double) -> PhysicsfluidvolumeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeSlice::add(self : PhysicsfluidvolumeSlice, other : PhysicsfluidvolumeSlice) -> PhysicsfluidvolumeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvolumeSlice::copy(self : PhysicsfluidvolumeSlice) -> PhysicsfluidvolumeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeSlice::fill(self : PhysicsfluidvolumeSlice, v : Double) -> PhysicsfluidvolumeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvolumeSlice::min(self : PhysicsfluidvolumeSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvolumeSlice::max(self : PhysicsfluidvolumeSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvolumeSlice::to_string(self : PhysicsfluidvolumeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

