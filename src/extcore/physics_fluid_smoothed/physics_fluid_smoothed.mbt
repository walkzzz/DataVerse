///===
/// extcore/physics_fluid_smoothed

pub(all) struct PhysicsfluidsmoothedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_smoothed_make_point(x : Double, y : Double) -> PhysicsfluidsmoothedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_smoothed_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidsmoothedPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidsmoothedPoint::x(self : PhysicsfluidsmoothedPoint) -> Double { self.x }

pub fn PhysicsfluidsmoothedPoint::y(self : PhysicsfluidsmoothedPoint) -> Double { self.y }

pub fn PhysicsfluidsmoothedPoint::z(self : PhysicsfluidsmoothedPoint) -> Double { self.z }

pub fn PhysicsfluidsmoothedPoint::label(self : PhysicsfluidsmoothedPoint) -> Int { self.label }

pub fn PhysicsfluidsmoothedPoint::dist(self : PhysicsfluidsmoothedPoint, other : PhysicsfluidsmoothedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidsmoothedPoint::add(self : PhysicsfluidsmoothedPoint, other : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidsmoothedPoint::sub(self : PhysicsfluidsmoothedPoint, other : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidsmoothedPoint::scale(self : PhysicsfluidsmoothedPoint, s : Double) -> PhysicsfluidsmoothedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidsmoothedPoint::dot(self : PhysicsfluidsmoothedPoint, other : PhysicsfluidsmoothedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidsmoothedPoint::cross(self : PhysicsfluidsmoothedPoint, other : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidsmoothedPoint::norm(self : PhysicsfluidsmoothedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidsmoothedPoint::normalize(self : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidsmoothedPoint::negate(self : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidsmoothedPoint::mid(self : PhysicsfluidsmoothedPoint, other : PhysicsfluidsmoothedPoint) -> PhysicsfluidsmoothedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidsmoothedPoint::lerp(self : PhysicsfluidsmoothedPoint, other : PhysicsfluidsmoothedPoint, t : Double) -> PhysicsfluidsmoothedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidsmoothedPoint::to_string(self : PhysicsfluidsmoothedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_smoothed_make_series(vals : Array[Double], name : String) -> PhysicsfluidsmoothedSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidsmoothedSeries::len(self : PhysicsfluidsmoothedSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidsmoothedSeries::sum(self : PhysicsfluidsmoothedSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidsmoothedSeries::mean(self : PhysicsfluidsmoothedSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidsmoothedSeries::min(self : PhysicsfluidsmoothedSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidsmoothedSeries::max(self : PhysicsfluidsmoothedSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidsmoothedSeries::range(self : PhysicsfluidsmoothedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidsmoothedSeries::variance(self : PhysicsfluidsmoothedSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidsmoothedSeries::std(self : PhysicsfluidsmoothedSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidsmoothedSeries::median(self : PhysicsfluidsmoothedSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidsmoothedSeries::scale(self : PhysicsfluidsmoothedSeries, f : Double) -> PhysicsfluidsmoothedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidsmoothedSeries::add(self : PhysicsfluidsmoothedSeries, other : PhysicsfluidsmoothedSeries) -> PhysicsfluidsmoothedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidsmoothedSeries::sub(self : PhysicsfluidsmoothedSeries, other : PhysicsfluidsmoothedSeries) -> PhysicsfluidsmoothedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidsmoothedSeries::normalize(self : PhysicsfluidsmoothedSeries) -> PhysicsfluidsmoothedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidsmoothedSeries::cumsum(self : PhysicsfluidsmoothedSeries) -> PhysicsfluidsmoothedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidsmoothedSeries::to_string(self : PhysicsfluidsmoothedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidsmoothedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_smoothed_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidsmoothedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_smoothed_matrix_identity(n : Int) -> PhysicsfluidsmoothedMatrix {
  let m = physics_fluid_smoothed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidsmoothedMatrix::get(self : PhysicsfluidsmoothedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidsmoothedMatrix::transpose(self : PhysicsfluidsmoothedMatrix) -> PhysicsfluidsmoothedMatrix {
  let result = physics_fluid_smoothed_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidsmoothedMatrix::add(self : PhysicsfluidsmoothedMatrix, other : PhysicsfluidsmoothedMatrix) -> PhysicsfluidsmoothedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_smoothed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidsmoothedMatrix::scale(self : PhysicsfluidsmoothedMatrix, s : Double) -> PhysicsfluidsmoothedMatrix {
  let result = physics_fluid_smoothed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidsmoothedMatrix::multiply(self : PhysicsfluidsmoothedMatrix, other : PhysicsfluidsmoothedMatrix) -> PhysicsfluidsmoothedMatrix {
  if self.cols != other.rows { return physics_fluid_smoothed_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_smoothed_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluidsmoothedMatrix::trace(self : PhysicsfluidsmoothedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidsmoothedMatrix::det(self : PhysicsfluidsmoothedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidsmoothedMatrix::norm(self : PhysicsfluidsmoothedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidsmoothedMatrix::to_string(self : PhysicsfluidsmoothedMatrix) -> String {
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

pub(all) struct PhysicsfluidsmoothedVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_smoothed_make_vector(comps : Array[Double]) -> PhysicsfluidsmoothedVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_smoothed_vector_zero(dim : Int) -> PhysicsfluidsmoothedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidsmoothedVector::add(self : PhysicsfluidsmoothedVector, other : PhysicsfluidsmoothedVector) -> PhysicsfluidsmoothedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidsmoothedVector::sub(self : PhysicsfluidsmoothedVector, other : PhysicsfluidsmoothedVector) -> PhysicsfluidsmoothedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidsmoothedVector::scale(self : PhysicsfluidsmoothedVector, s : Double) -> PhysicsfluidsmoothedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidsmoothedVector::dot(self : PhysicsfluidsmoothedVector, other : PhysicsfluidsmoothedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidsmoothedVector::norm(self : PhysicsfluidsmoothedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidsmoothedVector::normalize(self : PhysicsfluidsmoothedVector) -> PhysicsfluidsmoothedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidsmoothedVector::dist(self : PhysicsfluidsmoothedVector, other : PhysicsfluidsmoothedVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidsmoothedVector::to_string(self : PhysicsfluidsmoothedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidsmoothedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_frame_make(size : Int) -> PhysicsfluidsmoothedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedFrame::len(self : PhysicsfluidsmoothedFrame) -> Int { self.size }

pub fn PhysicsfluidsmoothedFrame::get(self : PhysicsfluidsmoothedFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedFrame::set(self : PhysicsfluidsmoothedFrame, i : Int, v : Double) -> PhysicsfluidsmoothedFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedFrame::sum(self : PhysicsfluidsmoothedFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedFrame::mean(self : PhysicsfluidsmoothedFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedFrame::scale(self : PhysicsfluidsmoothedFrame, f : Double) -> PhysicsfluidsmoothedFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedFrame::add(self : PhysicsfluidsmoothedFrame, other : PhysicsfluidsmoothedFrame) -> PhysicsfluidsmoothedFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedFrame::copy(self : PhysicsfluidsmoothedFrame) -> PhysicsfluidsmoothedFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedFrame::fill(self : PhysicsfluidsmoothedFrame, v : Double) -> PhysicsfluidsmoothedFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedFrame::min(self : PhysicsfluidsmoothedFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedFrame::max(self : PhysicsfluidsmoothedFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedFrame::to_string(self : PhysicsfluidsmoothedFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_table_make(size : Int) -> PhysicsfluidsmoothedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedTable::len(self : PhysicsfluidsmoothedTable) -> Int { self.size }

pub fn PhysicsfluidsmoothedTable::get(self : PhysicsfluidsmoothedTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedTable::set(self : PhysicsfluidsmoothedTable, i : Int, v : Double) -> PhysicsfluidsmoothedTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedTable::sum(self : PhysicsfluidsmoothedTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedTable::mean(self : PhysicsfluidsmoothedTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedTable::scale(self : PhysicsfluidsmoothedTable, f : Double) -> PhysicsfluidsmoothedTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedTable::add(self : PhysicsfluidsmoothedTable, other : PhysicsfluidsmoothedTable) -> PhysicsfluidsmoothedTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedTable::copy(self : PhysicsfluidsmoothedTable) -> PhysicsfluidsmoothedTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedTable::fill(self : PhysicsfluidsmoothedTable, v : Double) -> PhysicsfluidsmoothedTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedTable::min(self : PhysicsfluidsmoothedTable) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedTable::max(self : PhysicsfluidsmoothedTable) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedTable::to_string(self : PhysicsfluidsmoothedTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_graphn_make(size : Int) -> PhysicsfluidsmoothedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedGraphN::len(self : PhysicsfluidsmoothedGraphN) -> Int { self.size }

pub fn PhysicsfluidsmoothedGraphN::get(self : PhysicsfluidsmoothedGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedGraphN::set(self : PhysicsfluidsmoothedGraphN, i : Int, v : Double) -> PhysicsfluidsmoothedGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedGraphN::sum(self : PhysicsfluidsmoothedGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedGraphN::mean(self : PhysicsfluidsmoothedGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedGraphN::scale(self : PhysicsfluidsmoothedGraphN, f : Double) -> PhysicsfluidsmoothedGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedGraphN::add(self : PhysicsfluidsmoothedGraphN, other : PhysicsfluidsmoothedGraphN) -> PhysicsfluidsmoothedGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedGraphN::copy(self : PhysicsfluidsmoothedGraphN) -> PhysicsfluidsmoothedGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedGraphN::fill(self : PhysicsfluidsmoothedGraphN, v : Double) -> PhysicsfluidsmoothedGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedGraphN::min(self : PhysicsfluidsmoothedGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedGraphN::max(self : PhysicsfluidsmoothedGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedGraphN::to_string(self : PhysicsfluidsmoothedGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_node_make(size : Int) -> PhysicsfluidsmoothedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedNode::len(self : PhysicsfluidsmoothedNode) -> Int { self.size }

pub fn PhysicsfluidsmoothedNode::get(self : PhysicsfluidsmoothedNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedNode::set(self : PhysicsfluidsmoothedNode, i : Int, v : Double) -> PhysicsfluidsmoothedNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedNode::sum(self : PhysicsfluidsmoothedNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedNode::mean(self : PhysicsfluidsmoothedNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedNode::scale(self : PhysicsfluidsmoothedNode, f : Double) -> PhysicsfluidsmoothedNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedNode::add(self : PhysicsfluidsmoothedNode, other : PhysicsfluidsmoothedNode) -> PhysicsfluidsmoothedNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedNode::copy(self : PhysicsfluidsmoothedNode) -> PhysicsfluidsmoothedNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedNode::fill(self : PhysicsfluidsmoothedNode, v : Double) -> PhysicsfluidsmoothedNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedNode::min(self : PhysicsfluidsmoothedNode) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedNode::max(self : PhysicsfluidsmoothedNode) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedNode::to_string(self : PhysicsfluidsmoothedNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_edge_make(size : Int) -> PhysicsfluidsmoothedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedEdge::len(self : PhysicsfluidsmoothedEdge) -> Int { self.size }

pub fn PhysicsfluidsmoothedEdge::get(self : PhysicsfluidsmoothedEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedEdge::set(self : PhysicsfluidsmoothedEdge, i : Int, v : Double) -> PhysicsfluidsmoothedEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedEdge::sum(self : PhysicsfluidsmoothedEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedEdge::mean(self : PhysicsfluidsmoothedEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedEdge::scale(self : PhysicsfluidsmoothedEdge, f : Double) -> PhysicsfluidsmoothedEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedEdge::add(self : PhysicsfluidsmoothedEdge, other : PhysicsfluidsmoothedEdge) -> PhysicsfluidsmoothedEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedEdge::copy(self : PhysicsfluidsmoothedEdge) -> PhysicsfluidsmoothedEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedEdge::fill(self : PhysicsfluidsmoothedEdge, v : Double) -> PhysicsfluidsmoothedEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedEdge::min(self : PhysicsfluidsmoothedEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedEdge::max(self : PhysicsfluidsmoothedEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedEdge::to_string(self : PhysicsfluidsmoothedEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_path_make(size : Int) -> PhysicsfluidsmoothedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedPath::len(self : PhysicsfluidsmoothedPath) -> Int { self.size }

pub fn PhysicsfluidsmoothedPath::get(self : PhysicsfluidsmoothedPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedPath::set(self : PhysicsfluidsmoothedPath, i : Int, v : Double) -> PhysicsfluidsmoothedPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedPath::sum(self : PhysicsfluidsmoothedPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedPath::mean(self : PhysicsfluidsmoothedPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedPath::scale(self : PhysicsfluidsmoothedPath, f : Double) -> PhysicsfluidsmoothedPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedPath::add(self : PhysicsfluidsmoothedPath, other : PhysicsfluidsmoothedPath) -> PhysicsfluidsmoothedPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedPath::copy(self : PhysicsfluidsmoothedPath) -> PhysicsfluidsmoothedPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedPath::fill(self : PhysicsfluidsmoothedPath, v : Double) -> PhysicsfluidsmoothedPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedPath::min(self : PhysicsfluidsmoothedPath) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedPath::max(self : PhysicsfluidsmoothedPath) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedPath::to_string(self : PhysicsfluidsmoothedPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_cluster_make(size : Int) -> PhysicsfluidsmoothedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedCluster::len(self : PhysicsfluidsmoothedCluster) -> Int { self.size }

pub fn PhysicsfluidsmoothedCluster::get(self : PhysicsfluidsmoothedCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedCluster::set(self : PhysicsfluidsmoothedCluster, i : Int, v : Double) -> PhysicsfluidsmoothedCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedCluster::sum(self : PhysicsfluidsmoothedCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedCluster::mean(self : PhysicsfluidsmoothedCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedCluster::scale(self : PhysicsfluidsmoothedCluster, f : Double) -> PhysicsfluidsmoothedCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedCluster::add(self : PhysicsfluidsmoothedCluster, other : PhysicsfluidsmoothedCluster) -> PhysicsfluidsmoothedCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedCluster::copy(self : PhysicsfluidsmoothedCluster) -> PhysicsfluidsmoothedCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedCluster::fill(self : PhysicsfluidsmoothedCluster, v : Double) -> PhysicsfluidsmoothedCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedCluster::min(self : PhysicsfluidsmoothedCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedCluster::max(self : PhysicsfluidsmoothedCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedCluster::to_string(self : PhysicsfluidsmoothedCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_model_make(size : Int) -> PhysicsfluidsmoothedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedModel::len(self : PhysicsfluidsmoothedModel) -> Int { self.size }

pub fn PhysicsfluidsmoothedModel::get(self : PhysicsfluidsmoothedModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedModel::set(self : PhysicsfluidsmoothedModel, i : Int, v : Double) -> PhysicsfluidsmoothedModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedModel::sum(self : PhysicsfluidsmoothedModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedModel::mean(self : PhysicsfluidsmoothedModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedModel::scale(self : PhysicsfluidsmoothedModel, f : Double) -> PhysicsfluidsmoothedModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedModel::add(self : PhysicsfluidsmoothedModel, other : PhysicsfluidsmoothedModel) -> PhysicsfluidsmoothedModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedModel::copy(self : PhysicsfluidsmoothedModel) -> PhysicsfluidsmoothedModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedModel::fill(self : PhysicsfluidsmoothedModel, v : Double) -> PhysicsfluidsmoothedModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedModel::min(self : PhysicsfluidsmoothedModel) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedModel::max(self : PhysicsfluidsmoothedModel) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedModel::to_string(self : PhysicsfluidsmoothedModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_layer_make(size : Int) -> PhysicsfluidsmoothedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedLayer::len(self : PhysicsfluidsmoothedLayer) -> Int { self.size }

pub fn PhysicsfluidsmoothedLayer::get(self : PhysicsfluidsmoothedLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedLayer::set(self : PhysicsfluidsmoothedLayer, i : Int, v : Double) -> PhysicsfluidsmoothedLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedLayer::sum(self : PhysicsfluidsmoothedLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedLayer::mean(self : PhysicsfluidsmoothedLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedLayer::scale(self : PhysicsfluidsmoothedLayer, f : Double) -> PhysicsfluidsmoothedLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedLayer::add(self : PhysicsfluidsmoothedLayer, other : PhysicsfluidsmoothedLayer) -> PhysicsfluidsmoothedLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedLayer::copy(self : PhysicsfluidsmoothedLayer) -> PhysicsfluidsmoothedLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedLayer::fill(self : PhysicsfluidsmoothedLayer, v : Double) -> PhysicsfluidsmoothedLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedLayer::min(self : PhysicsfluidsmoothedLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedLayer::max(self : PhysicsfluidsmoothedLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedLayer::to_string(self : PhysicsfluidsmoothedLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_buffer_make(size : Int) -> PhysicsfluidsmoothedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedBuffer::len(self : PhysicsfluidsmoothedBuffer) -> Int { self.size }

pub fn PhysicsfluidsmoothedBuffer::get(self : PhysicsfluidsmoothedBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedBuffer::set(self : PhysicsfluidsmoothedBuffer, i : Int, v : Double) -> PhysicsfluidsmoothedBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedBuffer::sum(self : PhysicsfluidsmoothedBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedBuffer::mean(self : PhysicsfluidsmoothedBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedBuffer::scale(self : PhysicsfluidsmoothedBuffer, f : Double) -> PhysicsfluidsmoothedBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedBuffer::add(self : PhysicsfluidsmoothedBuffer, other : PhysicsfluidsmoothedBuffer) -> PhysicsfluidsmoothedBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedBuffer::copy(self : PhysicsfluidsmoothedBuffer) -> PhysicsfluidsmoothedBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedBuffer::fill(self : PhysicsfluidsmoothedBuffer, v : Double) -> PhysicsfluidsmoothedBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedBuffer::min(self : PhysicsfluidsmoothedBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedBuffer::max(self : PhysicsfluidsmoothedBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedBuffer::to_string(self : PhysicsfluidsmoothedBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_cursor_make(size : Int) -> PhysicsfluidsmoothedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedCursor::len(self : PhysicsfluidsmoothedCursor) -> Int { self.size }

pub fn PhysicsfluidsmoothedCursor::get(self : PhysicsfluidsmoothedCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedCursor::set(self : PhysicsfluidsmoothedCursor, i : Int, v : Double) -> PhysicsfluidsmoothedCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedCursor::sum(self : PhysicsfluidsmoothedCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedCursor::mean(self : PhysicsfluidsmoothedCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedCursor::scale(self : PhysicsfluidsmoothedCursor, f : Double) -> PhysicsfluidsmoothedCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedCursor::add(self : PhysicsfluidsmoothedCursor, other : PhysicsfluidsmoothedCursor) -> PhysicsfluidsmoothedCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedCursor::copy(self : PhysicsfluidsmoothedCursor) -> PhysicsfluidsmoothedCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedCursor::fill(self : PhysicsfluidsmoothedCursor, v : Double) -> PhysicsfluidsmoothedCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedCursor::min(self : PhysicsfluidsmoothedCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedCursor::max(self : PhysicsfluidsmoothedCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedCursor::to_string(self : PhysicsfluidsmoothedCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_view_make(size : Int) -> PhysicsfluidsmoothedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedView::len(self : PhysicsfluidsmoothedView) -> Int { self.size }

pub fn PhysicsfluidsmoothedView::get(self : PhysicsfluidsmoothedView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedView::set(self : PhysicsfluidsmoothedView, i : Int, v : Double) -> PhysicsfluidsmoothedView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedView::sum(self : PhysicsfluidsmoothedView) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedView::mean(self : PhysicsfluidsmoothedView) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedView::scale(self : PhysicsfluidsmoothedView, f : Double) -> PhysicsfluidsmoothedView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedView::add(self : PhysicsfluidsmoothedView, other : PhysicsfluidsmoothedView) -> PhysicsfluidsmoothedView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedView::copy(self : PhysicsfluidsmoothedView) -> PhysicsfluidsmoothedView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedView::fill(self : PhysicsfluidsmoothedView, v : Double) -> PhysicsfluidsmoothedView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedView::min(self : PhysicsfluidsmoothedView) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedView::max(self : PhysicsfluidsmoothedView) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedView::to_string(self : PhysicsfluidsmoothedView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_range_make(size : Int) -> PhysicsfluidsmoothedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedRange::len(self : PhysicsfluidsmoothedRange) -> Int { self.size }

pub fn PhysicsfluidsmoothedRange::get(self : PhysicsfluidsmoothedRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedRange::set(self : PhysicsfluidsmoothedRange, i : Int, v : Double) -> PhysicsfluidsmoothedRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedRange::sum(self : PhysicsfluidsmoothedRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedRange::mean(self : PhysicsfluidsmoothedRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedRange::scale(self : PhysicsfluidsmoothedRange, f : Double) -> PhysicsfluidsmoothedRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedRange::add(self : PhysicsfluidsmoothedRange, other : PhysicsfluidsmoothedRange) -> PhysicsfluidsmoothedRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedRange::copy(self : PhysicsfluidsmoothedRange) -> PhysicsfluidsmoothedRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedRange::fill(self : PhysicsfluidsmoothedRange, v : Double) -> PhysicsfluidsmoothedRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedRange::min(self : PhysicsfluidsmoothedRange) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedRange::max(self : PhysicsfluidsmoothedRange) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedRange::to_string(self : PhysicsfluidsmoothedRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidsmoothedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_smoothed_slice_make(size : Int) -> PhysicsfluidsmoothedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidsmoothedSlice::len(self : PhysicsfluidsmoothedSlice) -> Int { self.size }

pub fn PhysicsfluidsmoothedSlice::get(self : PhysicsfluidsmoothedSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidsmoothedSlice::set(self : PhysicsfluidsmoothedSlice, i : Int, v : Double) -> PhysicsfluidsmoothedSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedSlice::sum(self : PhysicsfluidsmoothedSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidsmoothedSlice::mean(self : PhysicsfluidsmoothedSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidsmoothedSlice::scale(self : PhysicsfluidsmoothedSlice, f : Double) -> PhysicsfluidsmoothedSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedSlice::add(self : PhysicsfluidsmoothedSlice, other : PhysicsfluidsmoothedSlice) -> PhysicsfluidsmoothedSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidsmoothedSlice::copy(self : PhysicsfluidsmoothedSlice) -> PhysicsfluidsmoothedSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedSlice::fill(self : PhysicsfluidsmoothedSlice, v : Double) -> PhysicsfluidsmoothedSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidsmoothedSlice::min(self : PhysicsfluidsmoothedSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidsmoothedSlice::max(self : PhysicsfluidsmoothedSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidsmoothedSlice::to_string(self : PhysicsfluidsmoothedSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

