///===
/// extcore/physics_em_high_freq

pub(all) struct PhysicsemhighfreqPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_high_freq_make_point(x : Double, y : Double) -> PhysicsemhighfreqPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_high_freq_make_point3(x : Double, y : Double, z : Double) -> PhysicsemhighfreqPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemhighfreqPoint::x(self : PhysicsemhighfreqPoint) -> Double { self.x }

pub fn PhysicsemhighfreqPoint::y(self : PhysicsemhighfreqPoint) -> Double { self.y }

pub fn PhysicsemhighfreqPoint::z(self : PhysicsemhighfreqPoint) -> Double { self.z }

pub fn PhysicsemhighfreqPoint::label(self : PhysicsemhighfreqPoint) -> Int { self.label }

pub fn PhysicsemhighfreqPoint::dist(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemhighfreqPoint::add(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemhighfreqPoint::sub(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemhighfreqPoint::scale(self : PhysicsemhighfreqPoint, s : Double) -> PhysicsemhighfreqPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemhighfreqPoint::dot(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemhighfreqPoint::cross(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemhighfreqPoint::norm(self : PhysicsemhighfreqPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemhighfreqPoint::normalize(self : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemhighfreqPoint::negate(self : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemhighfreqPoint::mid(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemhighfreqPoint::lerp(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint, t : Double) -> PhysicsemhighfreqPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemhighfreqPoint::to_string(self : PhysicsemhighfreqPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_high_freq_make_series(vals : Array[Double], name : String) -> PhysicsemhighfreqSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemhighfreqSeries::len(self : PhysicsemhighfreqSeries) -> Int { self.vals.length() }

pub fn PhysicsemhighfreqSeries::sum(self : PhysicsemhighfreqSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemhighfreqSeries::mean(self : PhysicsemhighfreqSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemhighfreqSeries::min(self : PhysicsemhighfreqSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemhighfreqSeries::max(self : PhysicsemhighfreqSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemhighfreqSeries::range(self : PhysicsemhighfreqSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemhighfreqSeries::variance(self : PhysicsemhighfreqSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemhighfreqSeries::std(self : PhysicsemhighfreqSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemhighfreqSeries::median(self : PhysicsemhighfreqSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemhighfreqSeries::scale(self : PhysicsemhighfreqSeries, f : Double) -> PhysicsemhighfreqSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemhighfreqSeries::add(self : PhysicsemhighfreqSeries, other : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemhighfreqSeries::sub(self : PhysicsemhighfreqSeries, other : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemhighfreqSeries::normalize(self : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemhighfreqSeries::cumsum(self : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemhighfreqSeries::to_string(self : PhysicsemhighfreqSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemhighfreqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_high_freq_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemhighfreqMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn physics_em_high_freq_matrix_identity(n : Int) -> PhysicsemhighfreqMatrix {
  let m = physics_em_high_freq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemhighfreqMatrix::get(self : PhysicsemhighfreqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemhighfreqMatrix::transpose(self : PhysicsemhighfreqMatrix) -> PhysicsemhighfreqMatrix {
  let result = physics_em_high_freq_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemhighfreqMatrix::add(self : PhysicsemhighfreqMatrix, other : PhysicsemhighfreqMatrix) -> PhysicsemhighfreqMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_high_freq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemhighfreqMatrix::scale(self : PhysicsemhighfreqMatrix, s : Double) -> PhysicsemhighfreqMatrix {
  let result = physics_em_high_freq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemhighfreqMatrix::multiply(self : PhysicsemhighfreqMatrix, other : PhysicsemhighfreqMatrix) -> PhysicsemhighfreqMatrix {
  if self.cols != other.rows { return physics_em_high_freq_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_high_freq_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsemhighfreqMatrix::trace(self : PhysicsemhighfreqMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemhighfreqMatrix::det(self : PhysicsemhighfreqMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemhighfreqMatrix::norm(self : PhysicsemhighfreqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemhighfreqMatrix::to_string(self : PhysicsemhighfreqMatrix) -> String {
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

pub(all) struct PhysicsemhighfreqVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_high_freq_make_vector(comps : Array[Double]) -> PhysicsemhighfreqVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_high_freq_vector_zero(dim : Int) -> PhysicsemhighfreqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemhighfreqVector::add(self : PhysicsemhighfreqVector, other : PhysicsemhighfreqVector) -> PhysicsemhighfreqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemhighfreqVector::sub(self : PhysicsemhighfreqVector, other : PhysicsemhighfreqVector) -> PhysicsemhighfreqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemhighfreqVector::scale(self : PhysicsemhighfreqVector, s : Double) -> PhysicsemhighfreqVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemhighfreqVector::dot(self : PhysicsemhighfreqVector, other : PhysicsemhighfreqVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemhighfreqVector::norm(self : PhysicsemhighfreqVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemhighfreqVector::normalize(self : PhysicsemhighfreqVector) -> PhysicsemhighfreqVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemhighfreqVector::dist(self : PhysicsemhighfreqVector, other : PhysicsemhighfreqVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemhighfreqVector::to_string(self : PhysicsemhighfreqVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemhighfreqFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_frame_make(size : Int) -> PhysicsemhighfreqFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqFrame::len(self : PhysicsemhighfreqFrame) -> Int { self.size }

pub fn PhysicsemhighfreqFrame::get(self : PhysicsemhighfreqFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqFrame::set(self : PhysicsemhighfreqFrame, i : Int, v : Double) -> PhysicsemhighfreqFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqFrame::sum(self : PhysicsemhighfreqFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqFrame::mean(self : PhysicsemhighfreqFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqFrame::scale(self : PhysicsemhighfreqFrame, f : Double) -> PhysicsemhighfreqFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqFrame::add(self : PhysicsemhighfreqFrame, other : PhysicsemhighfreqFrame) -> PhysicsemhighfreqFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqFrame::copy(self : PhysicsemhighfreqFrame) -> PhysicsemhighfreqFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqFrame::fill(self : PhysicsemhighfreqFrame, v : Double) -> PhysicsemhighfreqFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqFrame::min(self : PhysicsemhighfreqFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqFrame::max(self : PhysicsemhighfreqFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqFrame::to_string(self : PhysicsemhighfreqFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_table_make(size : Int) -> PhysicsemhighfreqTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqTable::len(self : PhysicsemhighfreqTable) -> Int { self.size }

pub fn PhysicsemhighfreqTable::get(self : PhysicsemhighfreqTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqTable::set(self : PhysicsemhighfreqTable, i : Int, v : Double) -> PhysicsemhighfreqTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqTable::sum(self : PhysicsemhighfreqTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqTable::mean(self : PhysicsemhighfreqTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqTable::scale(self : PhysicsemhighfreqTable, f : Double) -> PhysicsemhighfreqTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqTable::add(self : PhysicsemhighfreqTable, other : PhysicsemhighfreqTable) -> PhysicsemhighfreqTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqTable::copy(self : PhysicsemhighfreqTable) -> PhysicsemhighfreqTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqTable::fill(self : PhysicsemhighfreqTable, v : Double) -> PhysicsemhighfreqTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqTable::min(self : PhysicsemhighfreqTable) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqTable::max(self : PhysicsemhighfreqTable) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqTable::to_string(self : PhysicsemhighfreqTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_graphn_make(size : Int) -> PhysicsemhighfreqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqGraphN::len(self : PhysicsemhighfreqGraphN) -> Int { self.size }

pub fn PhysicsemhighfreqGraphN::get(self : PhysicsemhighfreqGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqGraphN::set(self : PhysicsemhighfreqGraphN, i : Int, v : Double) -> PhysicsemhighfreqGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqGraphN::sum(self : PhysicsemhighfreqGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqGraphN::mean(self : PhysicsemhighfreqGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqGraphN::scale(self : PhysicsemhighfreqGraphN, f : Double) -> PhysicsemhighfreqGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqGraphN::add(self : PhysicsemhighfreqGraphN, other : PhysicsemhighfreqGraphN) -> PhysicsemhighfreqGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqGraphN::copy(self : PhysicsemhighfreqGraphN) -> PhysicsemhighfreqGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqGraphN::fill(self : PhysicsemhighfreqGraphN, v : Double) -> PhysicsemhighfreqGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqGraphN::min(self : PhysicsemhighfreqGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqGraphN::max(self : PhysicsemhighfreqGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqGraphN::to_string(self : PhysicsemhighfreqGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_node_make(size : Int) -> PhysicsemhighfreqNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqNode::len(self : PhysicsemhighfreqNode) -> Int { self.size }

pub fn PhysicsemhighfreqNode::get(self : PhysicsemhighfreqNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqNode::set(self : PhysicsemhighfreqNode, i : Int, v : Double) -> PhysicsemhighfreqNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqNode::sum(self : PhysicsemhighfreqNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqNode::mean(self : PhysicsemhighfreqNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqNode::scale(self : PhysicsemhighfreqNode, f : Double) -> PhysicsemhighfreqNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqNode::add(self : PhysicsemhighfreqNode, other : PhysicsemhighfreqNode) -> PhysicsemhighfreqNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqNode::copy(self : PhysicsemhighfreqNode) -> PhysicsemhighfreqNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqNode::fill(self : PhysicsemhighfreqNode, v : Double) -> PhysicsemhighfreqNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqNode::min(self : PhysicsemhighfreqNode) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqNode::max(self : PhysicsemhighfreqNode) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqNode::to_string(self : PhysicsemhighfreqNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_edge_make(size : Int) -> PhysicsemhighfreqEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqEdge::len(self : PhysicsemhighfreqEdge) -> Int { self.size }

pub fn PhysicsemhighfreqEdge::get(self : PhysicsemhighfreqEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqEdge::set(self : PhysicsemhighfreqEdge, i : Int, v : Double) -> PhysicsemhighfreqEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqEdge::sum(self : PhysicsemhighfreqEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqEdge::mean(self : PhysicsemhighfreqEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqEdge::scale(self : PhysicsemhighfreqEdge, f : Double) -> PhysicsemhighfreqEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqEdge::add(self : PhysicsemhighfreqEdge, other : PhysicsemhighfreqEdge) -> PhysicsemhighfreqEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqEdge::copy(self : PhysicsemhighfreqEdge) -> PhysicsemhighfreqEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqEdge::fill(self : PhysicsemhighfreqEdge, v : Double) -> PhysicsemhighfreqEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqEdge::min(self : PhysicsemhighfreqEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqEdge::max(self : PhysicsemhighfreqEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqEdge::to_string(self : PhysicsemhighfreqEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_path_make(size : Int) -> PhysicsemhighfreqPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqPath::len(self : PhysicsemhighfreqPath) -> Int { self.size }

pub fn PhysicsemhighfreqPath::get(self : PhysicsemhighfreqPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqPath::set(self : PhysicsemhighfreqPath, i : Int, v : Double) -> PhysicsemhighfreqPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqPath::sum(self : PhysicsemhighfreqPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqPath::mean(self : PhysicsemhighfreqPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqPath::scale(self : PhysicsemhighfreqPath, f : Double) -> PhysicsemhighfreqPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqPath::add(self : PhysicsemhighfreqPath, other : PhysicsemhighfreqPath) -> PhysicsemhighfreqPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqPath::copy(self : PhysicsemhighfreqPath) -> PhysicsemhighfreqPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqPath::fill(self : PhysicsemhighfreqPath, v : Double) -> PhysicsemhighfreqPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqPath::min(self : PhysicsemhighfreqPath) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqPath::max(self : PhysicsemhighfreqPath) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqPath::to_string(self : PhysicsemhighfreqPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_cluster_make(size : Int) -> PhysicsemhighfreqCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqCluster::len(self : PhysicsemhighfreqCluster) -> Int { self.size }

pub fn PhysicsemhighfreqCluster::get(self : PhysicsemhighfreqCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqCluster::set(self : PhysicsemhighfreqCluster, i : Int, v : Double) -> PhysicsemhighfreqCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqCluster::sum(self : PhysicsemhighfreqCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqCluster::mean(self : PhysicsemhighfreqCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqCluster::scale(self : PhysicsemhighfreqCluster, f : Double) -> PhysicsemhighfreqCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqCluster::add(self : PhysicsemhighfreqCluster, other : PhysicsemhighfreqCluster) -> PhysicsemhighfreqCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqCluster::copy(self : PhysicsemhighfreqCluster) -> PhysicsemhighfreqCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqCluster::fill(self : PhysicsemhighfreqCluster, v : Double) -> PhysicsemhighfreqCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqCluster::min(self : PhysicsemhighfreqCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqCluster::max(self : PhysicsemhighfreqCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqCluster::to_string(self : PhysicsemhighfreqCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_model_make(size : Int) -> PhysicsemhighfreqModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqModel::len(self : PhysicsemhighfreqModel) -> Int { self.size }

pub fn PhysicsemhighfreqModel::get(self : PhysicsemhighfreqModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqModel::set(self : PhysicsemhighfreqModel, i : Int, v : Double) -> PhysicsemhighfreqModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqModel::sum(self : PhysicsemhighfreqModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqModel::mean(self : PhysicsemhighfreqModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqModel::scale(self : PhysicsemhighfreqModel, f : Double) -> PhysicsemhighfreqModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqModel::add(self : PhysicsemhighfreqModel, other : PhysicsemhighfreqModel) -> PhysicsemhighfreqModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqModel::copy(self : PhysicsemhighfreqModel) -> PhysicsemhighfreqModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqModel::fill(self : PhysicsemhighfreqModel, v : Double) -> PhysicsemhighfreqModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqModel::min(self : PhysicsemhighfreqModel) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqModel::max(self : PhysicsemhighfreqModel) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqModel::to_string(self : PhysicsemhighfreqModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_layer_make(size : Int) -> PhysicsemhighfreqLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqLayer::len(self : PhysicsemhighfreqLayer) -> Int { self.size }

pub fn PhysicsemhighfreqLayer::get(self : PhysicsemhighfreqLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqLayer::set(self : PhysicsemhighfreqLayer, i : Int, v : Double) -> PhysicsemhighfreqLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqLayer::sum(self : PhysicsemhighfreqLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqLayer::mean(self : PhysicsemhighfreqLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqLayer::scale(self : PhysicsemhighfreqLayer, f : Double) -> PhysicsemhighfreqLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqLayer::add(self : PhysicsemhighfreqLayer, other : PhysicsemhighfreqLayer) -> PhysicsemhighfreqLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqLayer::copy(self : PhysicsemhighfreqLayer) -> PhysicsemhighfreqLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqLayer::fill(self : PhysicsemhighfreqLayer, v : Double) -> PhysicsemhighfreqLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqLayer::min(self : PhysicsemhighfreqLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqLayer::max(self : PhysicsemhighfreqLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqLayer::to_string(self : PhysicsemhighfreqLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_buffer_make(size : Int) -> PhysicsemhighfreqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqBuffer::len(self : PhysicsemhighfreqBuffer) -> Int { self.size }

pub fn PhysicsemhighfreqBuffer::get(self : PhysicsemhighfreqBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqBuffer::set(self : PhysicsemhighfreqBuffer, i : Int, v : Double) -> PhysicsemhighfreqBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqBuffer::sum(self : PhysicsemhighfreqBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqBuffer::mean(self : PhysicsemhighfreqBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqBuffer::scale(self : PhysicsemhighfreqBuffer, f : Double) -> PhysicsemhighfreqBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqBuffer::add(self : PhysicsemhighfreqBuffer, other : PhysicsemhighfreqBuffer) -> PhysicsemhighfreqBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqBuffer::copy(self : PhysicsemhighfreqBuffer) -> PhysicsemhighfreqBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqBuffer::fill(self : PhysicsemhighfreqBuffer, v : Double) -> PhysicsemhighfreqBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqBuffer::min(self : PhysicsemhighfreqBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqBuffer::max(self : PhysicsemhighfreqBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqBuffer::to_string(self : PhysicsemhighfreqBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_cursor_make(size : Int) -> PhysicsemhighfreqCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqCursor::len(self : PhysicsemhighfreqCursor) -> Int { self.size }

pub fn PhysicsemhighfreqCursor::get(self : PhysicsemhighfreqCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqCursor::set(self : PhysicsemhighfreqCursor, i : Int, v : Double) -> PhysicsemhighfreqCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqCursor::sum(self : PhysicsemhighfreqCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqCursor::mean(self : PhysicsemhighfreqCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqCursor::scale(self : PhysicsemhighfreqCursor, f : Double) -> PhysicsemhighfreqCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqCursor::add(self : PhysicsemhighfreqCursor, other : PhysicsemhighfreqCursor) -> PhysicsemhighfreqCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqCursor::copy(self : PhysicsemhighfreqCursor) -> PhysicsemhighfreqCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqCursor::fill(self : PhysicsemhighfreqCursor, v : Double) -> PhysicsemhighfreqCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqCursor::min(self : PhysicsemhighfreqCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqCursor::max(self : PhysicsemhighfreqCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqCursor::to_string(self : PhysicsemhighfreqCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_view_make(size : Int) -> PhysicsemhighfreqView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqView::len(self : PhysicsemhighfreqView) -> Int { self.size }

pub fn PhysicsemhighfreqView::get(self : PhysicsemhighfreqView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqView::set(self : PhysicsemhighfreqView, i : Int, v : Double) -> PhysicsemhighfreqView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqView::sum(self : PhysicsemhighfreqView) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqView::mean(self : PhysicsemhighfreqView) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqView::scale(self : PhysicsemhighfreqView, f : Double) -> PhysicsemhighfreqView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqView::add(self : PhysicsemhighfreqView, other : PhysicsemhighfreqView) -> PhysicsemhighfreqView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqView::copy(self : PhysicsemhighfreqView) -> PhysicsemhighfreqView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqView::fill(self : PhysicsemhighfreqView, v : Double) -> PhysicsemhighfreqView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqView::min(self : PhysicsemhighfreqView) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqView::max(self : PhysicsemhighfreqView) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqView::to_string(self : PhysicsemhighfreqView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_range_make(size : Int) -> PhysicsemhighfreqRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqRange::len(self : PhysicsemhighfreqRange) -> Int { self.size }

pub fn PhysicsemhighfreqRange::get(self : PhysicsemhighfreqRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqRange::set(self : PhysicsemhighfreqRange, i : Int, v : Double) -> PhysicsemhighfreqRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqRange::sum(self : PhysicsemhighfreqRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqRange::mean(self : PhysicsemhighfreqRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqRange::scale(self : PhysicsemhighfreqRange, f : Double) -> PhysicsemhighfreqRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqRange::add(self : PhysicsemhighfreqRange, other : PhysicsemhighfreqRange) -> PhysicsemhighfreqRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqRange::copy(self : PhysicsemhighfreqRange) -> PhysicsemhighfreqRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqRange::fill(self : PhysicsemhighfreqRange, v : Double) -> PhysicsemhighfreqRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqRange::min(self : PhysicsemhighfreqRange) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqRange::max(self : PhysicsemhighfreqRange) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqRange::to_string(self : PhysicsemhighfreqRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_slice_make(size : Int) -> PhysicsemhighfreqSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemhighfreqSlice::len(self : PhysicsemhighfreqSlice) -> Int { self.size }

pub fn PhysicsemhighfreqSlice::get(self : PhysicsemhighfreqSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemhighfreqSlice::set(self : PhysicsemhighfreqSlice, i : Int, v : Double) -> PhysicsemhighfreqSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqSlice::sum(self : PhysicsemhighfreqSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsemhighfreqSlice::mean(self : PhysicsemhighfreqSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsemhighfreqSlice::scale(self : PhysicsemhighfreqSlice, f : Double) -> PhysicsemhighfreqSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqSlice::add(self : PhysicsemhighfreqSlice, other : PhysicsemhighfreqSlice) -> PhysicsemhighfreqSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemhighfreqSlice::copy(self : PhysicsemhighfreqSlice) -> PhysicsemhighfreqSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqSlice::fill(self : PhysicsemhighfreqSlice, v : Double) -> PhysicsemhighfreqSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemhighfreqSlice::min(self : PhysicsemhighfreqSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsemhighfreqSlice::max(self : PhysicsemhighfreqSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsemhighfreqSlice::to_string(self : PhysicsemhighfreqSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

