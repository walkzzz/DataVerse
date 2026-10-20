///===
/// extcore/physics_em_wave

pub(all) struct PhysicsemwavePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_wave_make_point(x : Double, y : Double) -> PhysicsemwavePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_wave_make_point3(x : Double, y : Double, z : Double) -> PhysicsemwavePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemwavePoint::x(self : PhysicsemwavePoint) -> Double { self.x }

pub fn PhysicsemwavePoint::y(self : PhysicsemwavePoint) -> Double { self.y }

pub fn PhysicsemwavePoint::z(self : PhysicsemwavePoint) -> Double { self.z }

pub fn PhysicsemwavePoint::label(self : PhysicsemwavePoint) -> Int { self.label }

pub fn PhysicsemwavePoint::dist(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemwavePoint::add(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemwavePoint::sub(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemwavePoint::scale(self : PhysicsemwavePoint, s : Double) -> PhysicsemwavePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemwavePoint::dot(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemwavePoint::cross(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemwavePoint::norm(self : PhysicsemwavePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemwavePoint::normalize(self : PhysicsemwavePoint) -> PhysicsemwavePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemwavePoint::negate(self : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemwavePoint::mid(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemwavePoint::lerp(self : PhysicsemwavePoint, other : PhysicsemwavePoint, t : Double) -> PhysicsemwavePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemwavePoint::to_string(self : PhysicsemwavePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemwaveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_wave_make_series(vals : Array[Double], name : String) -> PhysicsemwaveSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemwaveSeries::len(self : PhysicsemwaveSeries) -> Int { self.vals.length() }

pub fn PhysicsemwaveSeries::sum(self : PhysicsemwaveSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemwaveSeries::mean(self : PhysicsemwaveSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemwaveSeries::min(self : PhysicsemwaveSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemwaveSeries::max(self : PhysicsemwaveSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemwaveSeries::range(self : PhysicsemwaveSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemwaveSeries::variance(self : PhysicsemwaveSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemwaveSeries::std(self : PhysicsemwaveSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemwaveSeries::median(self : PhysicsemwaveSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemwaveSeries::scale(self : PhysicsemwaveSeries, f : Double) -> PhysicsemwaveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemwaveSeries::add(self : PhysicsemwaveSeries, other : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemwaveSeries::sub(self : PhysicsemwaveSeries, other : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemwaveSeries::normalize(self : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemwaveSeries::cumsum(self : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemwaveSeries::to_string(self : PhysicsemwaveSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemwaveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_wave_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemwaveMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn physics_em_wave_matrix_identity(n : Int) -> PhysicsemwaveMatrix {
  let m = physics_em_wave_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemwaveMatrix::get(self : PhysicsemwaveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemwaveMatrix::transpose(self : PhysicsemwaveMatrix) -> PhysicsemwaveMatrix {
  let result = physics_em_wave_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemwaveMatrix::add(self : PhysicsemwaveMatrix, other : PhysicsemwaveMatrix) -> PhysicsemwaveMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_wave_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemwaveMatrix::scale(self : PhysicsemwaveMatrix, s : Double) -> PhysicsemwaveMatrix {
  let result = physics_em_wave_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemwaveMatrix::multiply(self : PhysicsemwaveMatrix, other : PhysicsemwaveMatrix) -> PhysicsemwaveMatrix {
  if self.cols != other.rows { return physics_em_wave_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_wave_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsemwaveMatrix::trace(self : PhysicsemwaveMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemwaveMatrix::det(self : PhysicsemwaveMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemwaveMatrix::norm(self : PhysicsemwaveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemwaveMatrix::to_string(self : PhysicsemwaveMatrix) -> String {
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

pub(all) struct PhysicsemwaveVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_wave_make_vector(comps : Array[Double]) -> PhysicsemwaveVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_wave_vector_zero(dim : Int) -> PhysicsemwaveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemwaveVector::add(self : PhysicsemwaveVector, other : PhysicsemwaveVector) -> PhysicsemwaveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemwaveVector::sub(self : PhysicsemwaveVector, other : PhysicsemwaveVector) -> PhysicsemwaveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemwaveVector::scale(self : PhysicsemwaveVector, s : Double) -> PhysicsemwaveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemwaveVector::dot(self : PhysicsemwaveVector, other : PhysicsemwaveVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemwaveVector::norm(self : PhysicsemwaveVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemwaveVector::normalize(self : PhysicsemwaveVector) -> PhysicsemwaveVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemwaveVector::dist(self : PhysicsemwaveVector, other : PhysicsemwaveVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemwaveVector::to_string(self : PhysicsemwaveVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemwaveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_frame_make(size : Int) -> PhysicsemwaveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveFrame::len(self : PhysicsemwaveFrame) -> Int { self.size }

pub fn PhysicsemwaveFrame::get(self : PhysicsemwaveFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveFrame::set(self : PhysicsemwaveFrame, i : Int, v : Double) -> PhysicsemwaveFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveFrame::sum(self : PhysicsemwaveFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveFrame::mean(self : PhysicsemwaveFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveFrame::scale(self : PhysicsemwaveFrame, f : Double) -> PhysicsemwaveFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveFrame::add(self : PhysicsemwaveFrame, other : PhysicsemwaveFrame) -> PhysicsemwaveFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveFrame::copy(self : PhysicsemwaveFrame) -> PhysicsemwaveFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveFrame::fill(self : PhysicsemwaveFrame, v : Double) -> PhysicsemwaveFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveFrame::min(self : PhysicsemwaveFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveFrame::max(self : PhysicsemwaveFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveFrame::to_string(self : PhysicsemwaveFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_table_make(size : Int) -> PhysicsemwaveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveTable::len(self : PhysicsemwaveTable) -> Int { self.size }

pub fn PhysicsemwaveTable::get(self : PhysicsemwaveTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveTable::set(self : PhysicsemwaveTable, i : Int, v : Double) -> PhysicsemwaveTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveTable::sum(self : PhysicsemwaveTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveTable::mean(self : PhysicsemwaveTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveTable::scale(self : PhysicsemwaveTable, f : Double) -> PhysicsemwaveTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveTable::add(self : PhysicsemwaveTable, other : PhysicsemwaveTable) -> PhysicsemwaveTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveTable::copy(self : PhysicsemwaveTable) -> PhysicsemwaveTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveTable::fill(self : PhysicsemwaveTable, v : Double) -> PhysicsemwaveTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveTable::min(self : PhysicsemwaveTable) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveTable::max(self : PhysicsemwaveTable) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveTable::to_string(self : PhysicsemwaveTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_graphn_make(size : Int) -> PhysicsemwaveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveGraphN::len(self : PhysicsemwaveGraphN) -> Int { self.size }

pub fn PhysicsemwaveGraphN::get(self : PhysicsemwaveGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveGraphN::set(self : PhysicsemwaveGraphN, i : Int, v : Double) -> PhysicsemwaveGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveGraphN::sum(self : PhysicsemwaveGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveGraphN::mean(self : PhysicsemwaveGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveGraphN::scale(self : PhysicsemwaveGraphN, f : Double) -> PhysicsemwaveGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveGraphN::add(self : PhysicsemwaveGraphN, other : PhysicsemwaveGraphN) -> PhysicsemwaveGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveGraphN::copy(self : PhysicsemwaveGraphN) -> PhysicsemwaveGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveGraphN::fill(self : PhysicsemwaveGraphN, v : Double) -> PhysicsemwaveGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveGraphN::min(self : PhysicsemwaveGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveGraphN::max(self : PhysicsemwaveGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveGraphN::to_string(self : PhysicsemwaveGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_node_make(size : Int) -> PhysicsemwaveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveNode::len(self : PhysicsemwaveNode) -> Int { self.size }

pub fn PhysicsemwaveNode::get(self : PhysicsemwaveNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveNode::set(self : PhysicsemwaveNode, i : Int, v : Double) -> PhysicsemwaveNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveNode::sum(self : PhysicsemwaveNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveNode::mean(self : PhysicsemwaveNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveNode::scale(self : PhysicsemwaveNode, f : Double) -> PhysicsemwaveNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveNode::add(self : PhysicsemwaveNode, other : PhysicsemwaveNode) -> PhysicsemwaveNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveNode::copy(self : PhysicsemwaveNode) -> PhysicsemwaveNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveNode::fill(self : PhysicsemwaveNode, v : Double) -> PhysicsemwaveNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveNode::min(self : PhysicsemwaveNode) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveNode::max(self : PhysicsemwaveNode) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveNode::to_string(self : PhysicsemwaveNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_edge_make(size : Int) -> PhysicsemwaveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveEdge::len(self : PhysicsemwaveEdge) -> Int { self.size }

pub fn PhysicsemwaveEdge::get(self : PhysicsemwaveEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveEdge::set(self : PhysicsemwaveEdge, i : Int, v : Double) -> PhysicsemwaveEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveEdge::sum(self : PhysicsemwaveEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveEdge::mean(self : PhysicsemwaveEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveEdge::scale(self : PhysicsemwaveEdge, f : Double) -> PhysicsemwaveEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveEdge::add(self : PhysicsemwaveEdge, other : PhysicsemwaveEdge) -> PhysicsemwaveEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveEdge::copy(self : PhysicsemwaveEdge) -> PhysicsemwaveEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveEdge::fill(self : PhysicsemwaveEdge, v : Double) -> PhysicsemwaveEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveEdge::min(self : PhysicsemwaveEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveEdge::max(self : PhysicsemwaveEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveEdge::to_string(self : PhysicsemwaveEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwavePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_path_make(size : Int) -> PhysicsemwavePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwavePath::len(self : PhysicsemwavePath) -> Int { self.size }

pub fn PhysicsemwavePath::get(self : PhysicsemwavePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwavePath::set(self : PhysicsemwavePath, i : Int, v : Double) -> PhysicsemwavePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwavePath::sum(self : PhysicsemwavePath) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwavePath::mean(self : PhysicsemwavePath) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwavePath::scale(self : PhysicsemwavePath, f : Double) -> PhysicsemwavePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwavePath::add(self : PhysicsemwavePath, other : PhysicsemwavePath) -> PhysicsemwavePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwavePath::copy(self : PhysicsemwavePath) -> PhysicsemwavePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwavePath::fill(self : PhysicsemwavePath, v : Double) -> PhysicsemwavePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwavePath::min(self : PhysicsemwavePath) -> Double { @_common.min(self.data) }

pub fn PhysicsemwavePath::max(self : PhysicsemwavePath) -> Double { @_common.max(self.data) }

pub fn PhysicsemwavePath::to_string(self : PhysicsemwavePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_cluster_make(size : Int) -> PhysicsemwaveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveCluster::len(self : PhysicsemwaveCluster) -> Int { self.size }

pub fn PhysicsemwaveCluster::get(self : PhysicsemwaveCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveCluster::set(self : PhysicsemwaveCluster, i : Int, v : Double) -> PhysicsemwaveCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveCluster::sum(self : PhysicsemwaveCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveCluster::mean(self : PhysicsemwaveCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveCluster::scale(self : PhysicsemwaveCluster, f : Double) -> PhysicsemwaveCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveCluster::add(self : PhysicsemwaveCluster, other : PhysicsemwaveCluster) -> PhysicsemwaveCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveCluster::copy(self : PhysicsemwaveCluster) -> PhysicsemwaveCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveCluster::fill(self : PhysicsemwaveCluster, v : Double) -> PhysicsemwaveCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveCluster::min(self : PhysicsemwaveCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveCluster::max(self : PhysicsemwaveCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveCluster::to_string(self : PhysicsemwaveCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_model_make(size : Int) -> PhysicsemwaveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveModel::len(self : PhysicsemwaveModel) -> Int { self.size }

pub fn PhysicsemwaveModel::get(self : PhysicsemwaveModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveModel::set(self : PhysicsemwaveModel, i : Int, v : Double) -> PhysicsemwaveModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveModel::sum(self : PhysicsemwaveModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveModel::mean(self : PhysicsemwaveModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveModel::scale(self : PhysicsemwaveModel, f : Double) -> PhysicsemwaveModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveModel::add(self : PhysicsemwaveModel, other : PhysicsemwaveModel) -> PhysicsemwaveModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveModel::copy(self : PhysicsemwaveModel) -> PhysicsemwaveModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveModel::fill(self : PhysicsemwaveModel, v : Double) -> PhysicsemwaveModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveModel::min(self : PhysicsemwaveModel) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveModel::max(self : PhysicsemwaveModel) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveModel::to_string(self : PhysicsemwaveModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_layer_make(size : Int) -> PhysicsemwaveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveLayer::len(self : PhysicsemwaveLayer) -> Int { self.size }

pub fn PhysicsemwaveLayer::get(self : PhysicsemwaveLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveLayer::set(self : PhysicsemwaveLayer, i : Int, v : Double) -> PhysicsemwaveLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveLayer::sum(self : PhysicsemwaveLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveLayer::mean(self : PhysicsemwaveLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveLayer::scale(self : PhysicsemwaveLayer, f : Double) -> PhysicsemwaveLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveLayer::add(self : PhysicsemwaveLayer, other : PhysicsemwaveLayer) -> PhysicsemwaveLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveLayer::copy(self : PhysicsemwaveLayer) -> PhysicsemwaveLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveLayer::fill(self : PhysicsemwaveLayer, v : Double) -> PhysicsemwaveLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveLayer::min(self : PhysicsemwaveLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveLayer::max(self : PhysicsemwaveLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveLayer::to_string(self : PhysicsemwaveLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_buffer_make(size : Int) -> PhysicsemwaveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveBuffer::len(self : PhysicsemwaveBuffer) -> Int { self.size }

pub fn PhysicsemwaveBuffer::get(self : PhysicsemwaveBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveBuffer::set(self : PhysicsemwaveBuffer, i : Int, v : Double) -> PhysicsemwaveBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveBuffer::sum(self : PhysicsemwaveBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveBuffer::mean(self : PhysicsemwaveBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveBuffer::scale(self : PhysicsemwaveBuffer, f : Double) -> PhysicsemwaveBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveBuffer::add(self : PhysicsemwaveBuffer, other : PhysicsemwaveBuffer) -> PhysicsemwaveBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveBuffer::copy(self : PhysicsemwaveBuffer) -> PhysicsemwaveBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveBuffer::fill(self : PhysicsemwaveBuffer, v : Double) -> PhysicsemwaveBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveBuffer::min(self : PhysicsemwaveBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveBuffer::max(self : PhysicsemwaveBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveBuffer::to_string(self : PhysicsemwaveBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_cursor_make(size : Int) -> PhysicsemwaveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveCursor::len(self : PhysicsemwaveCursor) -> Int { self.size }

pub fn PhysicsemwaveCursor::get(self : PhysicsemwaveCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveCursor::set(self : PhysicsemwaveCursor, i : Int, v : Double) -> PhysicsemwaveCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveCursor::sum(self : PhysicsemwaveCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveCursor::mean(self : PhysicsemwaveCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveCursor::scale(self : PhysicsemwaveCursor, f : Double) -> PhysicsemwaveCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveCursor::add(self : PhysicsemwaveCursor, other : PhysicsemwaveCursor) -> PhysicsemwaveCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveCursor::copy(self : PhysicsemwaveCursor) -> PhysicsemwaveCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveCursor::fill(self : PhysicsemwaveCursor, v : Double) -> PhysicsemwaveCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveCursor::min(self : PhysicsemwaveCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveCursor::max(self : PhysicsemwaveCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveCursor::to_string(self : PhysicsemwaveCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_view_make(size : Int) -> PhysicsemwaveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveView::len(self : PhysicsemwaveView) -> Int { self.size }

pub fn PhysicsemwaveView::get(self : PhysicsemwaveView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveView::set(self : PhysicsemwaveView, i : Int, v : Double) -> PhysicsemwaveView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveView::sum(self : PhysicsemwaveView) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveView::mean(self : PhysicsemwaveView) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveView::scale(self : PhysicsemwaveView, f : Double) -> PhysicsemwaveView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveView::add(self : PhysicsemwaveView, other : PhysicsemwaveView) -> PhysicsemwaveView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveView::copy(self : PhysicsemwaveView) -> PhysicsemwaveView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveView::fill(self : PhysicsemwaveView, v : Double) -> PhysicsemwaveView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveView::min(self : PhysicsemwaveView) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveView::max(self : PhysicsemwaveView) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveView::to_string(self : PhysicsemwaveView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_range_make(size : Int) -> PhysicsemwaveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveRange::len(self : PhysicsemwaveRange) -> Int { self.size }

pub fn PhysicsemwaveRange::get(self : PhysicsemwaveRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveRange::set(self : PhysicsemwaveRange, i : Int, v : Double) -> PhysicsemwaveRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveRange::sum(self : PhysicsemwaveRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveRange::mean(self : PhysicsemwaveRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveRange::scale(self : PhysicsemwaveRange, f : Double) -> PhysicsemwaveRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveRange::add(self : PhysicsemwaveRange, other : PhysicsemwaveRange) -> PhysicsemwaveRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveRange::copy(self : PhysicsemwaveRange) -> PhysicsemwaveRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveRange::fill(self : PhysicsemwaveRange, v : Double) -> PhysicsemwaveRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveRange::min(self : PhysicsemwaveRange) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveRange::max(self : PhysicsemwaveRange) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveRange::to_string(self : PhysicsemwaveRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_slice_make(size : Int) -> PhysicsemwaveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemwaveSlice::len(self : PhysicsemwaveSlice) -> Int { self.size }

pub fn PhysicsemwaveSlice::get(self : PhysicsemwaveSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemwaveSlice::set(self : PhysicsemwaveSlice, i : Int, v : Double) -> PhysicsemwaveSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveSlice::sum(self : PhysicsemwaveSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsemwaveSlice::mean(self : PhysicsemwaveSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsemwaveSlice::scale(self : PhysicsemwaveSlice, f : Double) -> PhysicsemwaveSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveSlice::add(self : PhysicsemwaveSlice, other : PhysicsemwaveSlice) -> PhysicsemwaveSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemwaveSlice::copy(self : PhysicsemwaveSlice) -> PhysicsemwaveSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveSlice::fill(self : PhysicsemwaveSlice, v : Double) -> PhysicsemwaveSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemwaveSlice::min(self : PhysicsemwaveSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsemwaveSlice::max(self : PhysicsemwaveSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsemwaveSlice::to_string(self : PhysicsemwaveSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

