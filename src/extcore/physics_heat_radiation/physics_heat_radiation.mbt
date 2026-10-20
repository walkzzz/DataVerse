///===
/// extcore/physics_heat_radiation

pub(all) struct PhysicsheatradiationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_radiation_make_point(x : Double, y : Double) -> PhysicsheatradiationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_radiation_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatradiationPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatradiationPoint::x(self : PhysicsheatradiationPoint) -> Double { self.x }

pub fn PhysicsheatradiationPoint::y(self : PhysicsheatradiationPoint) -> Double { self.y }

pub fn PhysicsheatradiationPoint::z(self : PhysicsheatradiationPoint) -> Double { self.z }

pub fn PhysicsheatradiationPoint::label(self : PhysicsheatradiationPoint) -> Int { self.label }

pub fn PhysicsheatradiationPoint::dist(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatradiationPoint::add(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatradiationPoint::sub(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatradiationPoint::scale(self : PhysicsheatradiationPoint, s : Double) -> PhysicsheatradiationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatradiationPoint::dot(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatradiationPoint::cross(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatradiationPoint::norm(self : PhysicsheatradiationPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatradiationPoint::normalize(self : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatradiationPoint::negate(self : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatradiationPoint::mid(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint) -> PhysicsheatradiationPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatradiationPoint::lerp(self : PhysicsheatradiationPoint, other : PhysicsheatradiationPoint, t : Double) -> PhysicsheatradiationPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatradiationPoint::to_string(self : PhysicsheatradiationPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatradiationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_radiation_make_series(vals : Array[Double], name : String) -> PhysicsheatradiationSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatradiationSeries::len(self : PhysicsheatradiationSeries) -> Int { self.vals.length() }

pub fn PhysicsheatradiationSeries::sum(self : PhysicsheatradiationSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatradiationSeries::mean(self : PhysicsheatradiationSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatradiationSeries::min(self : PhysicsheatradiationSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatradiationSeries::max(self : PhysicsheatradiationSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatradiationSeries::range(self : PhysicsheatradiationSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatradiationSeries::variance(self : PhysicsheatradiationSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatradiationSeries::std(self : PhysicsheatradiationSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatradiationSeries::median(self : PhysicsheatradiationSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatradiationSeries::scale(self : PhysicsheatradiationSeries, f : Double) -> PhysicsheatradiationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatradiationSeries::add(self : PhysicsheatradiationSeries, other : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatradiationSeries::sub(self : PhysicsheatradiationSeries, other : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatradiationSeries::normalize(self : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatradiationSeries::cumsum(self : PhysicsheatradiationSeries) -> PhysicsheatradiationSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatradiationSeries::to_string(self : PhysicsheatradiationSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatradiationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_radiation_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatradiationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_radiation_matrix_identity(n : Int) -> PhysicsheatradiationMatrix {
  let m = physics_heat_radiation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatradiationMatrix::get(self : PhysicsheatradiationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatradiationMatrix::transpose(self : PhysicsheatradiationMatrix) -> PhysicsheatradiationMatrix {
  let result = physics_heat_radiation_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatradiationMatrix::add(self : PhysicsheatradiationMatrix, other : PhysicsheatradiationMatrix) -> PhysicsheatradiationMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_radiation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatradiationMatrix::scale(self : PhysicsheatradiationMatrix, s : Double) -> PhysicsheatradiationMatrix {
  let result = physics_heat_radiation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatradiationMatrix::multiply(self : PhysicsheatradiationMatrix, other : PhysicsheatradiationMatrix) -> PhysicsheatradiationMatrix {
  if self.cols != other.rows { return physics_heat_radiation_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_radiation_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsheatradiationMatrix::trace(self : PhysicsheatradiationMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatradiationMatrix::det(self : PhysicsheatradiationMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatradiationMatrix::norm(self : PhysicsheatradiationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatradiationMatrix::to_string(self : PhysicsheatradiationMatrix) -> String {
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

pub(all) struct PhysicsheatradiationVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_radiation_make_vector(comps : Array[Double]) -> PhysicsheatradiationVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_radiation_vector_zero(dim : Int) -> PhysicsheatradiationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatradiationVector::add(self : PhysicsheatradiationVector, other : PhysicsheatradiationVector) -> PhysicsheatradiationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatradiationVector::sub(self : PhysicsheatradiationVector, other : PhysicsheatradiationVector) -> PhysicsheatradiationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatradiationVector::scale(self : PhysicsheatradiationVector, s : Double) -> PhysicsheatradiationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatradiationVector::dot(self : PhysicsheatradiationVector, other : PhysicsheatradiationVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatradiationVector::norm(self : PhysicsheatradiationVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatradiationVector::normalize(self : PhysicsheatradiationVector) -> PhysicsheatradiationVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatradiationVector::dist(self : PhysicsheatradiationVector, other : PhysicsheatradiationVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatradiationVector::to_string(self : PhysicsheatradiationVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatradiationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_frame_make(size : Int) -> PhysicsheatradiationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationFrame::len(self : PhysicsheatradiationFrame) -> Int { self.size }

pub fn PhysicsheatradiationFrame::get(self : PhysicsheatradiationFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationFrame::set(self : PhysicsheatradiationFrame, i : Int, v : Double) -> PhysicsheatradiationFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationFrame::sum(self : PhysicsheatradiationFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationFrame::mean(self : PhysicsheatradiationFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationFrame::scale(self : PhysicsheatradiationFrame, f : Double) -> PhysicsheatradiationFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationFrame::add(self : PhysicsheatradiationFrame, other : PhysicsheatradiationFrame) -> PhysicsheatradiationFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationFrame::copy(self : PhysicsheatradiationFrame) -> PhysicsheatradiationFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationFrame::fill(self : PhysicsheatradiationFrame, v : Double) -> PhysicsheatradiationFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationFrame::min(self : PhysicsheatradiationFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationFrame::max(self : PhysicsheatradiationFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationFrame::to_string(self : PhysicsheatradiationFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_table_make(size : Int) -> PhysicsheatradiationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationTable::len(self : PhysicsheatradiationTable) -> Int { self.size }

pub fn PhysicsheatradiationTable::get(self : PhysicsheatradiationTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationTable::set(self : PhysicsheatradiationTable, i : Int, v : Double) -> PhysicsheatradiationTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationTable::sum(self : PhysicsheatradiationTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationTable::mean(self : PhysicsheatradiationTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationTable::scale(self : PhysicsheatradiationTable, f : Double) -> PhysicsheatradiationTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationTable::add(self : PhysicsheatradiationTable, other : PhysicsheatradiationTable) -> PhysicsheatradiationTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationTable::copy(self : PhysicsheatradiationTable) -> PhysicsheatradiationTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationTable::fill(self : PhysicsheatradiationTable, v : Double) -> PhysicsheatradiationTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationTable::min(self : PhysicsheatradiationTable) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationTable::max(self : PhysicsheatradiationTable) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationTable::to_string(self : PhysicsheatradiationTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_graphn_make(size : Int) -> PhysicsheatradiationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationGraphN::len(self : PhysicsheatradiationGraphN) -> Int { self.size }

pub fn PhysicsheatradiationGraphN::get(self : PhysicsheatradiationGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationGraphN::set(self : PhysicsheatradiationGraphN, i : Int, v : Double) -> PhysicsheatradiationGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationGraphN::sum(self : PhysicsheatradiationGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationGraphN::mean(self : PhysicsheatradiationGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationGraphN::scale(self : PhysicsheatradiationGraphN, f : Double) -> PhysicsheatradiationGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationGraphN::add(self : PhysicsheatradiationGraphN, other : PhysicsheatradiationGraphN) -> PhysicsheatradiationGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationGraphN::copy(self : PhysicsheatradiationGraphN) -> PhysicsheatradiationGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationGraphN::fill(self : PhysicsheatradiationGraphN, v : Double) -> PhysicsheatradiationGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationGraphN::min(self : PhysicsheatradiationGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationGraphN::max(self : PhysicsheatradiationGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationGraphN::to_string(self : PhysicsheatradiationGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_node_make(size : Int) -> PhysicsheatradiationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationNode::len(self : PhysicsheatradiationNode) -> Int { self.size }

pub fn PhysicsheatradiationNode::get(self : PhysicsheatradiationNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationNode::set(self : PhysicsheatradiationNode, i : Int, v : Double) -> PhysicsheatradiationNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationNode::sum(self : PhysicsheatradiationNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationNode::mean(self : PhysicsheatradiationNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationNode::scale(self : PhysicsheatradiationNode, f : Double) -> PhysicsheatradiationNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationNode::add(self : PhysicsheatradiationNode, other : PhysicsheatradiationNode) -> PhysicsheatradiationNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationNode::copy(self : PhysicsheatradiationNode) -> PhysicsheatradiationNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationNode::fill(self : PhysicsheatradiationNode, v : Double) -> PhysicsheatradiationNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationNode::min(self : PhysicsheatradiationNode) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationNode::max(self : PhysicsheatradiationNode) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationNode::to_string(self : PhysicsheatradiationNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_edge_make(size : Int) -> PhysicsheatradiationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationEdge::len(self : PhysicsheatradiationEdge) -> Int { self.size }

pub fn PhysicsheatradiationEdge::get(self : PhysicsheatradiationEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationEdge::set(self : PhysicsheatradiationEdge, i : Int, v : Double) -> PhysicsheatradiationEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationEdge::sum(self : PhysicsheatradiationEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationEdge::mean(self : PhysicsheatradiationEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationEdge::scale(self : PhysicsheatradiationEdge, f : Double) -> PhysicsheatradiationEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationEdge::add(self : PhysicsheatradiationEdge, other : PhysicsheatradiationEdge) -> PhysicsheatradiationEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationEdge::copy(self : PhysicsheatradiationEdge) -> PhysicsheatradiationEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationEdge::fill(self : PhysicsheatradiationEdge, v : Double) -> PhysicsheatradiationEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationEdge::min(self : PhysicsheatradiationEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationEdge::max(self : PhysicsheatradiationEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationEdge::to_string(self : PhysicsheatradiationEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_path_make(size : Int) -> PhysicsheatradiationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationPath::len(self : PhysicsheatradiationPath) -> Int { self.size }

pub fn PhysicsheatradiationPath::get(self : PhysicsheatradiationPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationPath::set(self : PhysicsheatradiationPath, i : Int, v : Double) -> PhysicsheatradiationPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationPath::sum(self : PhysicsheatradiationPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationPath::mean(self : PhysicsheatradiationPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationPath::scale(self : PhysicsheatradiationPath, f : Double) -> PhysicsheatradiationPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationPath::add(self : PhysicsheatradiationPath, other : PhysicsheatradiationPath) -> PhysicsheatradiationPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationPath::copy(self : PhysicsheatradiationPath) -> PhysicsheatradiationPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationPath::fill(self : PhysicsheatradiationPath, v : Double) -> PhysicsheatradiationPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationPath::min(self : PhysicsheatradiationPath) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationPath::max(self : PhysicsheatradiationPath) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationPath::to_string(self : PhysicsheatradiationPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_cluster_make(size : Int) -> PhysicsheatradiationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationCluster::len(self : PhysicsheatradiationCluster) -> Int { self.size }

pub fn PhysicsheatradiationCluster::get(self : PhysicsheatradiationCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationCluster::set(self : PhysicsheatradiationCluster, i : Int, v : Double) -> PhysicsheatradiationCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationCluster::sum(self : PhysicsheatradiationCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationCluster::mean(self : PhysicsheatradiationCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationCluster::scale(self : PhysicsheatradiationCluster, f : Double) -> PhysicsheatradiationCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationCluster::add(self : PhysicsheatradiationCluster, other : PhysicsheatradiationCluster) -> PhysicsheatradiationCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationCluster::copy(self : PhysicsheatradiationCluster) -> PhysicsheatradiationCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationCluster::fill(self : PhysicsheatradiationCluster, v : Double) -> PhysicsheatradiationCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationCluster::min(self : PhysicsheatradiationCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationCluster::max(self : PhysicsheatradiationCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationCluster::to_string(self : PhysicsheatradiationCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_model_make(size : Int) -> PhysicsheatradiationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationModel::len(self : PhysicsheatradiationModel) -> Int { self.size }

pub fn PhysicsheatradiationModel::get(self : PhysicsheatradiationModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationModel::set(self : PhysicsheatradiationModel, i : Int, v : Double) -> PhysicsheatradiationModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationModel::sum(self : PhysicsheatradiationModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationModel::mean(self : PhysicsheatradiationModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationModel::scale(self : PhysicsheatradiationModel, f : Double) -> PhysicsheatradiationModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationModel::add(self : PhysicsheatradiationModel, other : PhysicsheatradiationModel) -> PhysicsheatradiationModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationModel::copy(self : PhysicsheatradiationModel) -> PhysicsheatradiationModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationModel::fill(self : PhysicsheatradiationModel, v : Double) -> PhysicsheatradiationModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationModel::min(self : PhysicsheatradiationModel) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationModel::max(self : PhysicsheatradiationModel) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationModel::to_string(self : PhysicsheatradiationModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_layer_make(size : Int) -> PhysicsheatradiationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationLayer::len(self : PhysicsheatradiationLayer) -> Int { self.size }

pub fn PhysicsheatradiationLayer::get(self : PhysicsheatradiationLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationLayer::set(self : PhysicsheatradiationLayer, i : Int, v : Double) -> PhysicsheatradiationLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationLayer::sum(self : PhysicsheatradiationLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationLayer::mean(self : PhysicsheatradiationLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationLayer::scale(self : PhysicsheatradiationLayer, f : Double) -> PhysicsheatradiationLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationLayer::add(self : PhysicsheatradiationLayer, other : PhysicsheatradiationLayer) -> PhysicsheatradiationLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationLayer::copy(self : PhysicsheatradiationLayer) -> PhysicsheatradiationLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationLayer::fill(self : PhysicsheatradiationLayer, v : Double) -> PhysicsheatradiationLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationLayer::min(self : PhysicsheatradiationLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationLayer::max(self : PhysicsheatradiationLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationLayer::to_string(self : PhysicsheatradiationLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_buffer_make(size : Int) -> PhysicsheatradiationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationBuffer::len(self : PhysicsheatradiationBuffer) -> Int { self.size }

pub fn PhysicsheatradiationBuffer::get(self : PhysicsheatradiationBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationBuffer::set(self : PhysicsheatradiationBuffer, i : Int, v : Double) -> PhysicsheatradiationBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationBuffer::sum(self : PhysicsheatradiationBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationBuffer::mean(self : PhysicsheatradiationBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationBuffer::scale(self : PhysicsheatradiationBuffer, f : Double) -> PhysicsheatradiationBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationBuffer::add(self : PhysicsheatradiationBuffer, other : PhysicsheatradiationBuffer) -> PhysicsheatradiationBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationBuffer::copy(self : PhysicsheatradiationBuffer) -> PhysicsheatradiationBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationBuffer::fill(self : PhysicsheatradiationBuffer, v : Double) -> PhysicsheatradiationBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationBuffer::min(self : PhysicsheatradiationBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationBuffer::max(self : PhysicsheatradiationBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationBuffer::to_string(self : PhysicsheatradiationBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_cursor_make(size : Int) -> PhysicsheatradiationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationCursor::len(self : PhysicsheatradiationCursor) -> Int { self.size }

pub fn PhysicsheatradiationCursor::get(self : PhysicsheatradiationCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationCursor::set(self : PhysicsheatradiationCursor, i : Int, v : Double) -> PhysicsheatradiationCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationCursor::sum(self : PhysicsheatradiationCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationCursor::mean(self : PhysicsheatradiationCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationCursor::scale(self : PhysicsheatradiationCursor, f : Double) -> PhysicsheatradiationCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationCursor::add(self : PhysicsheatradiationCursor, other : PhysicsheatradiationCursor) -> PhysicsheatradiationCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationCursor::copy(self : PhysicsheatradiationCursor) -> PhysicsheatradiationCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationCursor::fill(self : PhysicsheatradiationCursor, v : Double) -> PhysicsheatradiationCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationCursor::min(self : PhysicsheatradiationCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationCursor::max(self : PhysicsheatradiationCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationCursor::to_string(self : PhysicsheatradiationCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_view_make(size : Int) -> PhysicsheatradiationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationView::len(self : PhysicsheatradiationView) -> Int { self.size }

pub fn PhysicsheatradiationView::get(self : PhysicsheatradiationView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationView::set(self : PhysicsheatradiationView, i : Int, v : Double) -> PhysicsheatradiationView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationView::sum(self : PhysicsheatradiationView) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationView::mean(self : PhysicsheatradiationView) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationView::scale(self : PhysicsheatradiationView, f : Double) -> PhysicsheatradiationView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationView::add(self : PhysicsheatradiationView, other : PhysicsheatradiationView) -> PhysicsheatradiationView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationView::copy(self : PhysicsheatradiationView) -> PhysicsheatradiationView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationView::fill(self : PhysicsheatradiationView, v : Double) -> PhysicsheatradiationView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationView::min(self : PhysicsheatradiationView) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationView::max(self : PhysicsheatradiationView) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationView::to_string(self : PhysicsheatradiationView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_range_make(size : Int) -> PhysicsheatradiationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationRange::len(self : PhysicsheatradiationRange) -> Int { self.size }

pub fn PhysicsheatradiationRange::get(self : PhysicsheatradiationRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationRange::set(self : PhysicsheatradiationRange, i : Int, v : Double) -> PhysicsheatradiationRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationRange::sum(self : PhysicsheatradiationRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationRange::mean(self : PhysicsheatradiationRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationRange::scale(self : PhysicsheatradiationRange, f : Double) -> PhysicsheatradiationRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationRange::add(self : PhysicsheatradiationRange, other : PhysicsheatradiationRange) -> PhysicsheatradiationRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationRange::copy(self : PhysicsheatradiationRange) -> PhysicsheatradiationRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationRange::fill(self : PhysicsheatradiationRange, v : Double) -> PhysicsheatradiationRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationRange::min(self : PhysicsheatradiationRange) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationRange::max(self : PhysicsheatradiationRange) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationRange::to_string(self : PhysicsheatradiationRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatradiationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_radiation_slice_make(size : Int) -> PhysicsheatradiationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatradiationSlice::len(self : PhysicsheatradiationSlice) -> Int { self.size }

pub fn PhysicsheatradiationSlice::get(self : PhysicsheatradiationSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatradiationSlice::set(self : PhysicsheatradiationSlice, i : Int, v : Double) -> PhysicsheatradiationSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationSlice::sum(self : PhysicsheatradiationSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatradiationSlice::mean(self : PhysicsheatradiationSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatradiationSlice::scale(self : PhysicsheatradiationSlice, f : Double) -> PhysicsheatradiationSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationSlice::add(self : PhysicsheatradiationSlice, other : PhysicsheatradiationSlice) -> PhysicsheatradiationSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatradiationSlice::copy(self : PhysicsheatradiationSlice) -> PhysicsheatradiationSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationSlice::fill(self : PhysicsheatradiationSlice, v : Double) -> PhysicsheatradiationSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatradiationSlice::min(self : PhysicsheatradiationSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsheatradiationSlice::max(self : PhysicsheatradiationSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsheatradiationSlice::to_string(self : PhysicsheatradiationSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

