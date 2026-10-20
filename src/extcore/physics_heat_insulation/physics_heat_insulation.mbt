///===
/// extcore/physics_heat_insulation

pub(all) struct PhysicsheatinsulationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_insulation_make_point(x : Double, y : Double) -> PhysicsheatinsulationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_insulation_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatinsulationPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatinsulationPoint::x(self : PhysicsheatinsulationPoint) -> Double { self.x }

pub fn PhysicsheatinsulationPoint::y(self : PhysicsheatinsulationPoint) -> Double { self.y }

pub fn PhysicsheatinsulationPoint::z(self : PhysicsheatinsulationPoint) -> Double { self.z }

pub fn PhysicsheatinsulationPoint::label(self : PhysicsheatinsulationPoint) -> Int { self.label }

pub fn PhysicsheatinsulationPoint::dist(self : PhysicsheatinsulationPoint, other : PhysicsheatinsulationPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatinsulationPoint::add(self : PhysicsheatinsulationPoint, other : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatinsulationPoint::sub(self : PhysicsheatinsulationPoint, other : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatinsulationPoint::scale(self : PhysicsheatinsulationPoint, s : Double) -> PhysicsheatinsulationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatinsulationPoint::dot(self : PhysicsheatinsulationPoint, other : PhysicsheatinsulationPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatinsulationPoint::cross(self : PhysicsheatinsulationPoint, other : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatinsulationPoint::norm(self : PhysicsheatinsulationPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatinsulationPoint::normalize(self : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatinsulationPoint::negate(self : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatinsulationPoint::mid(self : PhysicsheatinsulationPoint, other : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatinsulationPoint::lerp(self : PhysicsheatinsulationPoint, other : PhysicsheatinsulationPoint, t : Double) -> PhysicsheatinsulationPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatinsulationPoint::to_string(self : PhysicsheatinsulationPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_insulation_make_series(vals : Array[Double], name : String) -> PhysicsheatinsulationSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatinsulationSeries::len(self : PhysicsheatinsulationSeries) -> Int { self.vals.length() }

pub fn PhysicsheatinsulationSeries::sum(self : PhysicsheatinsulationSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatinsulationSeries::mean(self : PhysicsheatinsulationSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatinsulationSeries::min(self : PhysicsheatinsulationSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatinsulationSeries::max(self : PhysicsheatinsulationSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatinsulationSeries::range(self : PhysicsheatinsulationSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatinsulationSeries::variance(self : PhysicsheatinsulationSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatinsulationSeries::std(self : PhysicsheatinsulationSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatinsulationSeries::median(self : PhysicsheatinsulationSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatinsulationSeries::scale(self : PhysicsheatinsulationSeries, f : Double) -> PhysicsheatinsulationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatinsulationSeries::add(self : PhysicsheatinsulationSeries, other : PhysicsheatinsulationSeries) -> PhysicsheatinsulationSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatinsulationSeries::sub(self : PhysicsheatinsulationSeries, other : PhysicsheatinsulationSeries) -> PhysicsheatinsulationSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatinsulationSeries::normalize(self : PhysicsheatinsulationSeries) -> PhysicsheatinsulationSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatinsulationSeries::cumsum(self : PhysicsheatinsulationSeries) -> PhysicsheatinsulationSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatinsulationSeries::to_string(self : PhysicsheatinsulationSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatinsulationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_insulation_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatinsulationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_insulation_matrix_identity(n : Int) -> PhysicsheatinsulationMatrix {
  let m = physics_heat_insulation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatinsulationMatrix::get(self : PhysicsheatinsulationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatinsulationMatrix::transpose(self : PhysicsheatinsulationMatrix) -> PhysicsheatinsulationMatrix {
  let result = physics_heat_insulation_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatinsulationMatrix::add(self : PhysicsheatinsulationMatrix, other : PhysicsheatinsulationMatrix) -> PhysicsheatinsulationMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_insulation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatinsulationMatrix::scale(self : PhysicsheatinsulationMatrix, s : Double) -> PhysicsheatinsulationMatrix {
  let result = physics_heat_insulation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatinsulationMatrix::multiply(self : PhysicsheatinsulationMatrix, other : PhysicsheatinsulationMatrix) -> PhysicsheatinsulationMatrix {
  if self.cols != other.rows { return physics_heat_insulation_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_insulation_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsheatinsulationMatrix::trace(self : PhysicsheatinsulationMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatinsulationMatrix::det(self : PhysicsheatinsulationMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatinsulationMatrix::norm(self : PhysicsheatinsulationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatinsulationMatrix::to_string(self : PhysicsheatinsulationMatrix) -> String {
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

pub(all) struct PhysicsheatinsulationVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_insulation_make_vector(comps : Array[Double]) -> PhysicsheatinsulationVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_insulation_vector_zero(dim : Int) -> PhysicsheatinsulationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatinsulationVector::add(self : PhysicsheatinsulationVector, other : PhysicsheatinsulationVector) -> PhysicsheatinsulationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatinsulationVector::sub(self : PhysicsheatinsulationVector, other : PhysicsheatinsulationVector) -> PhysicsheatinsulationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatinsulationVector::scale(self : PhysicsheatinsulationVector, s : Double) -> PhysicsheatinsulationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatinsulationVector::dot(self : PhysicsheatinsulationVector, other : PhysicsheatinsulationVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatinsulationVector::norm(self : PhysicsheatinsulationVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatinsulationVector::normalize(self : PhysicsheatinsulationVector) -> PhysicsheatinsulationVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatinsulationVector::dist(self : PhysicsheatinsulationVector, other : PhysicsheatinsulationVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatinsulationVector::to_string(self : PhysicsheatinsulationVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatinsulationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_frame_make(size : Int) -> PhysicsheatinsulationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationFrame::len(self : PhysicsheatinsulationFrame) -> Int { self.size }

pub fn PhysicsheatinsulationFrame::get(self : PhysicsheatinsulationFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationFrame::set(self : PhysicsheatinsulationFrame, i : Int, v : Double) -> PhysicsheatinsulationFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationFrame::sum(self : PhysicsheatinsulationFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationFrame::mean(self : PhysicsheatinsulationFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationFrame::scale(self : PhysicsheatinsulationFrame, f : Double) -> PhysicsheatinsulationFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationFrame::add(self : PhysicsheatinsulationFrame, other : PhysicsheatinsulationFrame) -> PhysicsheatinsulationFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationFrame::copy(self : PhysicsheatinsulationFrame) -> PhysicsheatinsulationFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationFrame::fill(self : PhysicsheatinsulationFrame, v : Double) -> PhysicsheatinsulationFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationFrame::min(self : PhysicsheatinsulationFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationFrame::max(self : PhysicsheatinsulationFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationFrame::to_string(self : PhysicsheatinsulationFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_table_make(size : Int) -> PhysicsheatinsulationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationTable::len(self : PhysicsheatinsulationTable) -> Int { self.size }

pub fn PhysicsheatinsulationTable::get(self : PhysicsheatinsulationTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationTable::set(self : PhysicsheatinsulationTable, i : Int, v : Double) -> PhysicsheatinsulationTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationTable::sum(self : PhysicsheatinsulationTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationTable::mean(self : PhysicsheatinsulationTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationTable::scale(self : PhysicsheatinsulationTable, f : Double) -> PhysicsheatinsulationTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationTable::add(self : PhysicsheatinsulationTable, other : PhysicsheatinsulationTable) -> PhysicsheatinsulationTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationTable::copy(self : PhysicsheatinsulationTable) -> PhysicsheatinsulationTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationTable::fill(self : PhysicsheatinsulationTable, v : Double) -> PhysicsheatinsulationTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationTable::min(self : PhysicsheatinsulationTable) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationTable::max(self : PhysicsheatinsulationTable) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationTable::to_string(self : PhysicsheatinsulationTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_graphn_make(size : Int) -> PhysicsheatinsulationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationGraphN::len(self : PhysicsheatinsulationGraphN) -> Int { self.size }

pub fn PhysicsheatinsulationGraphN::get(self : PhysicsheatinsulationGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationGraphN::set(self : PhysicsheatinsulationGraphN, i : Int, v : Double) -> PhysicsheatinsulationGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationGraphN::sum(self : PhysicsheatinsulationGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationGraphN::mean(self : PhysicsheatinsulationGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationGraphN::scale(self : PhysicsheatinsulationGraphN, f : Double) -> PhysicsheatinsulationGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationGraphN::add(self : PhysicsheatinsulationGraphN, other : PhysicsheatinsulationGraphN) -> PhysicsheatinsulationGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationGraphN::copy(self : PhysicsheatinsulationGraphN) -> PhysicsheatinsulationGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationGraphN::fill(self : PhysicsheatinsulationGraphN, v : Double) -> PhysicsheatinsulationGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationGraphN::min(self : PhysicsheatinsulationGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationGraphN::max(self : PhysicsheatinsulationGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationGraphN::to_string(self : PhysicsheatinsulationGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_node_make(size : Int) -> PhysicsheatinsulationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationNode::len(self : PhysicsheatinsulationNode) -> Int { self.size }

pub fn PhysicsheatinsulationNode::get(self : PhysicsheatinsulationNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationNode::set(self : PhysicsheatinsulationNode, i : Int, v : Double) -> PhysicsheatinsulationNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationNode::sum(self : PhysicsheatinsulationNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationNode::mean(self : PhysicsheatinsulationNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationNode::scale(self : PhysicsheatinsulationNode, f : Double) -> PhysicsheatinsulationNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationNode::add(self : PhysicsheatinsulationNode, other : PhysicsheatinsulationNode) -> PhysicsheatinsulationNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationNode::copy(self : PhysicsheatinsulationNode) -> PhysicsheatinsulationNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationNode::fill(self : PhysicsheatinsulationNode, v : Double) -> PhysicsheatinsulationNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationNode::min(self : PhysicsheatinsulationNode) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationNode::max(self : PhysicsheatinsulationNode) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationNode::to_string(self : PhysicsheatinsulationNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_edge_make(size : Int) -> PhysicsheatinsulationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationEdge::len(self : PhysicsheatinsulationEdge) -> Int { self.size }

pub fn PhysicsheatinsulationEdge::get(self : PhysicsheatinsulationEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationEdge::set(self : PhysicsheatinsulationEdge, i : Int, v : Double) -> PhysicsheatinsulationEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationEdge::sum(self : PhysicsheatinsulationEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationEdge::mean(self : PhysicsheatinsulationEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationEdge::scale(self : PhysicsheatinsulationEdge, f : Double) -> PhysicsheatinsulationEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationEdge::add(self : PhysicsheatinsulationEdge, other : PhysicsheatinsulationEdge) -> PhysicsheatinsulationEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationEdge::copy(self : PhysicsheatinsulationEdge) -> PhysicsheatinsulationEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationEdge::fill(self : PhysicsheatinsulationEdge, v : Double) -> PhysicsheatinsulationEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationEdge::min(self : PhysicsheatinsulationEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationEdge::max(self : PhysicsheatinsulationEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationEdge::to_string(self : PhysicsheatinsulationEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_path_make(size : Int) -> PhysicsheatinsulationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationPath::len(self : PhysicsheatinsulationPath) -> Int { self.size }

pub fn PhysicsheatinsulationPath::get(self : PhysicsheatinsulationPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationPath::set(self : PhysicsheatinsulationPath, i : Int, v : Double) -> PhysicsheatinsulationPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationPath::sum(self : PhysicsheatinsulationPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationPath::mean(self : PhysicsheatinsulationPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationPath::scale(self : PhysicsheatinsulationPath, f : Double) -> PhysicsheatinsulationPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationPath::add(self : PhysicsheatinsulationPath, other : PhysicsheatinsulationPath) -> PhysicsheatinsulationPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationPath::copy(self : PhysicsheatinsulationPath) -> PhysicsheatinsulationPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationPath::fill(self : PhysicsheatinsulationPath, v : Double) -> PhysicsheatinsulationPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationPath::min(self : PhysicsheatinsulationPath) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationPath::max(self : PhysicsheatinsulationPath) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationPath::to_string(self : PhysicsheatinsulationPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_cluster_make(size : Int) -> PhysicsheatinsulationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationCluster::len(self : PhysicsheatinsulationCluster) -> Int { self.size }

pub fn PhysicsheatinsulationCluster::get(self : PhysicsheatinsulationCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationCluster::set(self : PhysicsheatinsulationCluster, i : Int, v : Double) -> PhysicsheatinsulationCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationCluster::sum(self : PhysicsheatinsulationCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationCluster::mean(self : PhysicsheatinsulationCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationCluster::scale(self : PhysicsheatinsulationCluster, f : Double) -> PhysicsheatinsulationCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationCluster::add(self : PhysicsheatinsulationCluster, other : PhysicsheatinsulationCluster) -> PhysicsheatinsulationCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationCluster::copy(self : PhysicsheatinsulationCluster) -> PhysicsheatinsulationCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationCluster::fill(self : PhysicsheatinsulationCluster, v : Double) -> PhysicsheatinsulationCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationCluster::min(self : PhysicsheatinsulationCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationCluster::max(self : PhysicsheatinsulationCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationCluster::to_string(self : PhysicsheatinsulationCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_model_make(size : Int) -> PhysicsheatinsulationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationModel::len(self : PhysicsheatinsulationModel) -> Int { self.size }

pub fn PhysicsheatinsulationModel::get(self : PhysicsheatinsulationModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationModel::set(self : PhysicsheatinsulationModel, i : Int, v : Double) -> PhysicsheatinsulationModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationModel::sum(self : PhysicsheatinsulationModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationModel::mean(self : PhysicsheatinsulationModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationModel::scale(self : PhysicsheatinsulationModel, f : Double) -> PhysicsheatinsulationModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationModel::add(self : PhysicsheatinsulationModel, other : PhysicsheatinsulationModel) -> PhysicsheatinsulationModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationModel::copy(self : PhysicsheatinsulationModel) -> PhysicsheatinsulationModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationModel::fill(self : PhysicsheatinsulationModel, v : Double) -> PhysicsheatinsulationModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationModel::min(self : PhysicsheatinsulationModel) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationModel::max(self : PhysicsheatinsulationModel) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationModel::to_string(self : PhysicsheatinsulationModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_layer_make(size : Int) -> PhysicsheatinsulationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationLayer::len(self : PhysicsheatinsulationLayer) -> Int { self.size }

pub fn PhysicsheatinsulationLayer::get(self : PhysicsheatinsulationLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationLayer::set(self : PhysicsheatinsulationLayer, i : Int, v : Double) -> PhysicsheatinsulationLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationLayer::sum(self : PhysicsheatinsulationLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationLayer::mean(self : PhysicsheatinsulationLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationLayer::scale(self : PhysicsheatinsulationLayer, f : Double) -> PhysicsheatinsulationLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationLayer::add(self : PhysicsheatinsulationLayer, other : PhysicsheatinsulationLayer) -> PhysicsheatinsulationLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationLayer::copy(self : PhysicsheatinsulationLayer) -> PhysicsheatinsulationLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationLayer::fill(self : PhysicsheatinsulationLayer, v : Double) -> PhysicsheatinsulationLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationLayer::min(self : PhysicsheatinsulationLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationLayer::max(self : PhysicsheatinsulationLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationLayer::to_string(self : PhysicsheatinsulationLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_buffer_make(size : Int) -> PhysicsheatinsulationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationBuffer::len(self : PhysicsheatinsulationBuffer) -> Int { self.size }

pub fn PhysicsheatinsulationBuffer::get(self : PhysicsheatinsulationBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationBuffer::set(self : PhysicsheatinsulationBuffer, i : Int, v : Double) -> PhysicsheatinsulationBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationBuffer::sum(self : PhysicsheatinsulationBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationBuffer::mean(self : PhysicsheatinsulationBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationBuffer::scale(self : PhysicsheatinsulationBuffer, f : Double) -> PhysicsheatinsulationBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationBuffer::add(self : PhysicsheatinsulationBuffer, other : PhysicsheatinsulationBuffer) -> PhysicsheatinsulationBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationBuffer::copy(self : PhysicsheatinsulationBuffer) -> PhysicsheatinsulationBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationBuffer::fill(self : PhysicsheatinsulationBuffer, v : Double) -> PhysicsheatinsulationBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationBuffer::min(self : PhysicsheatinsulationBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationBuffer::max(self : PhysicsheatinsulationBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationBuffer::to_string(self : PhysicsheatinsulationBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_cursor_make(size : Int) -> PhysicsheatinsulationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationCursor::len(self : PhysicsheatinsulationCursor) -> Int { self.size }

pub fn PhysicsheatinsulationCursor::get(self : PhysicsheatinsulationCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationCursor::set(self : PhysicsheatinsulationCursor, i : Int, v : Double) -> PhysicsheatinsulationCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationCursor::sum(self : PhysicsheatinsulationCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationCursor::mean(self : PhysicsheatinsulationCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationCursor::scale(self : PhysicsheatinsulationCursor, f : Double) -> PhysicsheatinsulationCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationCursor::add(self : PhysicsheatinsulationCursor, other : PhysicsheatinsulationCursor) -> PhysicsheatinsulationCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationCursor::copy(self : PhysicsheatinsulationCursor) -> PhysicsheatinsulationCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationCursor::fill(self : PhysicsheatinsulationCursor, v : Double) -> PhysicsheatinsulationCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationCursor::min(self : PhysicsheatinsulationCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationCursor::max(self : PhysicsheatinsulationCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationCursor::to_string(self : PhysicsheatinsulationCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_view_make(size : Int) -> PhysicsheatinsulationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationView::len(self : PhysicsheatinsulationView) -> Int { self.size }

pub fn PhysicsheatinsulationView::get(self : PhysicsheatinsulationView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationView::set(self : PhysicsheatinsulationView, i : Int, v : Double) -> PhysicsheatinsulationView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationView::sum(self : PhysicsheatinsulationView) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationView::mean(self : PhysicsheatinsulationView) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationView::scale(self : PhysicsheatinsulationView, f : Double) -> PhysicsheatinsulationView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationView::add(self : PhysicsheatinsulationView, other : PhysicsheatinsulationView) -> PhysicsheatinsulationView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationView::copy(self : PhysicsheatinsulationView) -> PhysicsheatinsulationView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationView::fill(self : PhysicsheatinsulationView, v : Double) -> PhysicsheatinsulationView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationView::min(self : PhysicsheatinsulationView) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationView::max(self : PhysicsheatinsulationView) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationView::to_string(self : PhysicsheatinsulationView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_range_make(size : Int) -> PhysicsheatinsulationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationRange::len(self : PhysicsheatinsulationRange) -> Int { self.size }

pub fn PhysicsheatinsulationRange::get(self : PhysicsheatinsulationRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationRange::set(self : PhysicsheatinsulationRange, i : Int, v : Double) -> PhysicsheatinsulationRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationRange::sum(self : PhysicsheatinsulationRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationRange::mean(self : PhysicsheatinsulationRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationRange::scale(self : PhysicsheatinsulationRange, f : Double) -> PhysicsheatinsulationRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationRange::add(self : PhysicsheatinsulationRange, other : PhysicsheatinsulationRange) -> PhysicsheatinsulationRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationRange::copy(self : PhysicsheatinsulationRange) -> PhysicsheatinsulationRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationRange::fill(self : PhysicsheatinsulationRange, v : Double) -> PhysicsheatinsulationRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationRange::min(self : PhysicsheatinsulationRange) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationRange::max(self : PhysicsheatinsulationRange) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationRange::to_string(self : PhysicsheatinsulationRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_slice_make(size : Int) -> PhysicsheatinsulationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatinsulationSlice::len(self : PhysicsheatinsulationSlice) -> Int { self.size }

pub fn PhysicsheatinsulationSlice::get(self : PhysicsheatinsulationSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatinsulationSlice::set(self : PhysicsheatinsulationSlice, i : Int, v : Double) -> PhysicsheatinsulationSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationSlice::sum(self : PhysicsheatinsulationSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatinsulationSlice::mean(self : PhysicsheatinsulationSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatinsulationSlice::scale(self : PhysicsheatinsulationSlice, f : Double) -> PhysicsheatinsulationSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationSlice::add(self : PhysicsheatinsulationSlice, other : PhysicsheatinsulationSlice) -> PhysicsheatinsulationSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatinsulationSlice::copy(self : PhysicsheatinsulationSlice) -> PhysicsheatinsulationSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationSlice::fill(self : PhysicsheatinsulationSlice, v : Double) -> PhysicsheatinsulationSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatinsulationSlice::min(self : PhysicsheatinsulationSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsheatinsulationSlice::max(self : PhysicsheatinsulationSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsheatinsulationSlice::to_string(self : PhysicsheatinsulationSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

