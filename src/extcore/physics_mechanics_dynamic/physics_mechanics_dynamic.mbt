///===
/// extcore/physics_mechanics_dynamic

pub(all) struct PhysicsmechanicsdynamicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_dynamic_make_point(x : Double, y : Double) -> PhysicsmechanicsdynamicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_dynamic_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsdynamicPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicsdynamicPoint::x(self : PhysicsmechanicsdynamicPoint) -> Double { self.x }

pub fn PhysicsmechanicsdynamicPoint::y(self : PhysicsmechanicsdynamicPoint) -> Double { self.y }

pub fn PhysicsmechanicsdynamicPoint::z(self : PhysicsmechanicsdynamicPoint) -> Double { self.z }

pub fn PhysicsmechanicsdynamicPoint::label(self : PhysicsmechanicsdynamicPoint) -> Int { self.label }

pub fn PhysicsmechanicsdynamicPoint::dist(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicsdynamicPoint::add(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::sub(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::scale(self : PhysicsmechanicsdynamicPoint, s : Double) -> PhysicsmechanicsdynamicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::dot(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicsdynamicPoint::cross(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicsdynamicPoint::norm(self : PhysicsmechanicsdynamicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicsdynamicPoint::normalize(self : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsdynamicPoint::negate(self : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::mid(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::lerp(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint, t : Double) -> PhysicsmechanicsdynamicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::to_string(self : PhysicsmechanicsdynamicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_dynamic_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsdynamicSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicsdynamicSeries::len(self : PhysicsmechanicsdynamicSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicsdynamicSeries::sum(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::mean(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::min(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::max(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::range(self : PhysicsmechanicsdynamicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicsdynamicSeries::variance(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::std(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::median(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::scale(self : PhysicsmechanicsdynamicSeries, f : Double) -> PhysicsmechanicsdynamicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicsdynamicSeries::add(self : PhysicsmechanicsdynamicSeries, other : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsdynamicSeries::sub(self : PhysicsmechanicsdynamicSeries, other : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsdynamicSeries::normalize(self : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicsdynamicSeries::cumsum(self : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicsdynamicSeries::to_string(self : PhysicsmechanicsdynamicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsdynamicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_dynamic_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsdynamicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_dynamic_matrix_identity(n : Int) -> PhysicsmechanicsdynamicMatrix {
  let m = physics_mechanics_dynamic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicsdynamicMatrix::get(self : PhysicsmechanicsdynamicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicsdynamicMatrix::transpose(self : PhysicsmechanicsdynamicMatrix) -> PhysicsmechanicsdynamicMatrix {
  let result = physics_mechanics_dynamic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicsdynamicMatrix::add(self : PhysicsmechanicsdynamicMatrix, other : PhysicsmechanicsdynamicMatrix) -> PhysicsmechanicsdynamicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_dynamic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicsdynamicMatrix::scale(self : PhysicsmechanicsdynamicMatrix, s : Double) -> PhysicsmechanicsdynamicMatrix {
  let result = physics_mechanics_dynamic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicsdynamicMatrix::multiply(self : PhysicsmechanicsdynamicMatrix, other : PhysicsmechanicsdynamicMatrix) -> PhysicsmechanicsdynamicMatrix {
  if self.cols != other.rows { return physics_mechanics_dynamic_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_dynamic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsmechanicsdynamicMatrix::trace(self : PhysicsmechanicsdynamicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicsdynamicMatrix::det(self : PhysicsmechanicsdynamicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicsdynamicMatrix::norm(self : PhysicsmechanicsdynamicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicsdynamicMatrix::to_string(self : PhysicsmechanicsdynamicMatrix) -> String {
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

pub(all) struct PhysicsmechanicsdynamicVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_dynamic_make_vector(comps : Array[Double]) -> PhysicsmechanicsdynamicVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_dynamic_vector_zero(dim : Int) -> PhysicsmechanicsdynamicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicsdynamicVector::add(self : PhysicsmechanicsdynamicVector, other : PhysicsmechanicsdynamicVector) -> PhysicsmechanicsdynamicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsdynamicVector::sub(self : PhysicsmechanicsdynamicVector, other : PhysicsmechanicsdynamicVector) -> PhysicsmechanicsdynamicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsdynamicVector::scale(self : PhysicsmechanicsdynamicVector, s : Double) -> PhysicsmechanicsdynamicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicsdynamicVector::dot(self : PhysicsmechanicsdynamicVector, other : PhysicsmechanicsdynamicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicsdynamicVector::norm(self : PhysicsmechanicsdynamicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicsdynamicVector::normalize(self : PhysicsmechanicsdynamicVector) -> PhysicsmechanicsdynamicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsdynamicVector::dist(self : PhysicsmechanicsdynamicVector, other : PhysicsmechanicsdynamicVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicsdynamicVector::to_string(self : PhysicsmechanicsdynamicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsdynamicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_frame_make(size : Int) -> PhysicsmechanicsdynamicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicFrame::len(self : PhysicsmechanicsdynamicFrame) -> Int { self.size }

pub fn PhysicsmechanicsdynamicFrame::get(self : PhysicsmechanicsdynamicFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicFrame::set(self : PhysicsmechanicsdynamicFrame, i : Int, v : Double) -> PhysicsmechanicsdynamicFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicFrame::sum(self : PhysicsmechanicsdynamicFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicFrame::mean(self : PhysicsmechanicsdynamicFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicFrame::scale(self : PhysicsmechanicsdynamicFrame, f : Double) -> PhysicsmechanicsdynamicFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicFrame::add(self : PhysicsmechanicsdynamicFrame, other : PhysicsmechanicsdynamicFrame) -> PhysicsmechanicsdynamicFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicFrame::copy(self : PhysicsmechanicsdynamicFrame) -> PhysicsmechanicsdynamicFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicFrame::fill(self : PhysicsmechanicsdynamicFrame, v : Double) -> PhysicsmechanicsdynamicFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicFrame::min(self : PhysicsmechanicsdynamicFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicFrame::max(self : PhysicsmechanicsdynamicFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicFrame::to_string(self : PhysicsmechanicsdynamicFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_table_make(size : Int) -> PhysicsmechanicsdynamicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicTable::len(self : PhysicsmechanicsdynamicTable) -> Int { self.size }

pub fn PhysicsmechanicsdynamicTable::get(self : PhysicsmechanicsdynamicTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicTable::set(self : PhysicsmechanicsdynamicTable, i : Int, v : Double) -> PhysicsmechanicsdynamicTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicTable::sum(self : PhysicsmechanicsdynamicTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicTable::mean(self : PhysicsmechanicsdynamicTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicTable::scale(self : PhysicsmechanicsdynamicTable, f : Double) -> PhysicsmechanicsdynamicTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicTable::add(self : PhysicsmechanicsdynamicTable, other : PhysicsmechanicsdynamicTable) -> PhysicsmechanicsdynamicTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicTable::copy(self : PhysicsmechanicsdynamicTable) -> PhysicsmechanicsdynamicTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicTable::fill(self : PhysicsmechanicsdynamicTable, v : Double) -> PhysicsmechanicsdynamicTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicTable::min(self : PhysicsmechanicsdynamicTable) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicTable::max(self : PhysicsmechanicsdynamicTable) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicTable::to_string(self : PhysicsmechanicsdynamicTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_graphn_make(size : Int) -> PhysicsmechanicsdynamicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicGraphN::len(self : PhysicsmechanicsdynamicGraphN) -> Int { self.size }

pub fn PhysicsmechanicsdynamicGraphN::get(self : PhysicsmechanicsdynamicGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicGraphN::set(self : PhysicsmechanicsdynamicGraphN, i : Int, v : Double) -> PhysicsmechanicsdynamicGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicGraphN::sum(self : PhysicsmechanicsdynamicGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicGraphN::mean(self : PhysicsmechanicsdynamicGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicGraphN::scale(self : PhysicsmechanicsdynamicGraphN, f : Double) -> PhysicsmechanicsdynamicGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicGraphN::add(self : PhysicsmechanicsdynamicGraphN, other : PhysicsmechanicsdynamicGraphN) -> PhysicsmechanicsdynamicGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicGraphN::copy(self : PhysicsmechanicsdynamicGraphN) -> PhysicsmechanicsdynamicGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicGraphN::fill(self : PhysicsmechanicsdynamicGraphN, v : Double) -> PhysicsmechanicsdynamicGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicGraphN::min(self : PhysicsmechanicsdynamicGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicGraphN::max(self : PhysicsmechanicsdynamicGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicGraphN::to_string(self : PhysicsmechanicsdynamicGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_node_make(size : Int) -> PhysicsmechanicsdynamicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicNode::len(self : PhysicsmechanicsdynamicNode) -> Int { self.size }

pub fn PhysicsmechanicsdynamicNode::get(self : PhysicsmechanicsdynamicNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicNode::set(self : PhysicsmechanicsdynamicNode, i : Int, v : Double) -> PhysicsmechanicsdynamicNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicNode::sum(self : PhysicsmechanicsdynamicNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicNode::mean(self : PhysicsmechanicsdynamicNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicNode::scale(self : PhysicsmechanicsdynamicNode, f : Double) -> PhysicsmechanicsdynamicNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicNode::add(self : PhysicsmechanicsdynamicNode, other : PhysicsmechanicsdynamicNode) -> PhysicsmechanicsdynamicNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicNode::copy(self : PhysicsmechanicsdynamicNode) -> PhysicsmechanicsdynamicNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicNode::fill(self : PhysicsmechanicsdynamicNode, v : Double) -> PhysicsmechanicsdynamicNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicNode::min(self : PhysicsmechanicsdynamicNode) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicNode::max(self : PhysicsmechanicsdynamicNode) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicNode::to_string(self : PhysicsmechanicsdynamicNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_edge_make(size : Int) -> PhysicsmechanicsdynamicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicEdge::len(self : PhysicsmechanicsdynamicEdge) -> Int { self.size }

pub fn PhysicsmechanicsdynamicEdge::get(self : PhysicsmechanicsdynamicEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicEdge::set(self : PhysicsmechanicsdynamicEdge, i : Int, v : Double) -> PhysicsmechanicsdynamicEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicEdge::sum(self : PhysicsmechanicsdynamicEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicEdge::mean(self : PhysicsmechanicsdynamicEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicEdge::scale(self : PhysicsmechanicsdynamicEdge, f : Double) -> PhysicsmechanicsdynamicEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicEdge::add(self : PhysicsmechanicsdynamicEdge, other : PhysicsmechanicsdynamicEdge) -> PhysicsmechanicsdynamicEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicEdge::copy(self : PhysicsmechanicsdynamicEdge) -> PhysicsmechanicsdynamicEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicEdge::fill(self : PhysicsmechanicsdynamicEdge, v : Double) -> PhysicsmechanicsdynamicEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicEdge::min(self : PhysicsmechanicsdynamicEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicEdge::max(self : PhysicsmechanicsdynamicEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicEdge::to_string(self : PhysicsmechanicsdynamicEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_path_make(size : Int) -> PhysicsmechanicsdynamicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicPath::len(self : PhysicsmechanicsdynamicPath) -> Int { self.size }

pub fn PhysicsmechanicsdynamicPath::get(self : PhysicsmechanicsdynamicPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicPath::set(self : PhysicsmechanicsdynamicPath, i : Int, v : Double) -> PhysicsmechanicsdynamicPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicPath::sum(self : PhysicsmechanicsdynamicPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicPath::mean(self : PhysicsmechanicsdynamicPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicPath::scale(self : PhysicsmechanicsdynamicPath, f : Double) -> PhysicsmechanicsdynamicPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicPath::add(self : PhysicsmechanicsdynamicPath, other : PhysicsmechanicsdynamicPath) -> PhysicsmechanicsdynamicPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicPath::copy(self : PhysicsmechanicsdynamicPath) -> PhysicsmechanicsdynamicPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicPath::fill(self : PhysicsmechanicsdynamicPath, v : Double) -> PhysicsmechanicsdynamicPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicPath::min(self : PhysicsmechanicsdynamicPath) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicPath::max(self : PhysicsmechanicsdynamicPath) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicPath::to_string(self : PhysicsmechanicsdynamicPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_cluster_make(size : Int) -> PhysicsmechanicsdynamicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicCluster::len(self : PhysicsmechanicsdynamicCluster) -> Int { self.size }

pub fn PhysicsmechanicsdynamicCluster::get(self : PhysicsmechanicsdynamicCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicCluster::set(self : PhysicsmechanicsdynamicCluster, i : Int, v : Double) -> PhysicsmechanicsdynamicCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicCluster::sum(self : PhysicsmechanicsdynamicCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicCluster::mean(self : PhysicsmechanicsdynamicCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicCluster::scale(self : PhysicsmechanicsdynamicCluster, f : Double) -> PhysicsmechanicsdynamicCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicCluster::add(self : PhysicsmechanicsdynamicCluster, other : PhysicsmechanicsdynamicCluster) -> PhysicsmechanicsdynamicCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicCluster::copy(self : PhysicsmechanicsdynamicCluster) -> PhysicsmechanicsdynamicCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicCluster::fill(self : PhysicsmechanicsdynamicCluster, v : Double) -> PhysicsmechanicsdynamicCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicCluster::min(self : PhysicsmechanicsdynamicCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicCluster::max(self : PhysicsmechanicsdynamicCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicCluster::to_string(self : PhysicsmechanicsdynamicCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_model_make(size : Int) -> PhysicsmechanicsdynamicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicModel::len(self : PhysicsmechanicsdynamicModel) -> Int { self.size }

pub fn PhysicsmechanicsdynamicModel::get(self : PhysicsmechanicsdynamicModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicModel::set(self : PhysicsmechanicsdynamicModel, i : Int, v : Double) -> PhysicsmechanicsdynamicModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicModel::sum(self : PhysicsmechanicsdynamicModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicModel::mean(self : PhysicsmechanicsdynamicModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicModel::scale(self : PhysicsmechanicsdynamicModel, f : Double) -> PhysicsmechanicsdynamicModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicModel::add(self : PhysicsmechanicsdynamicModel, other : PhysicsmechanicsdynamicModel) -> PhysicsmechanicsdynamicModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicModel::copy(self : PhysicsmechanicsdynamicModel) -> PhysicsmechanicsdynamicModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicModel::fill(self : PhysicsmechanicsdynamicModel, v : Double) -> PhysicsmechanicsdynamicModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicModel::min(self : PhysicsmechanicsdynamicModel) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicModel::max(self : PhysicsmechanicsdynamicModel) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicModel::to_string(self : PhysicsmechanicsdynamicModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_layer_make(size : Int) -> PhysicsmechanicsdynamicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicLayer::len(self : PhysicsmechanicsdynamicLayer) -> Int { self.size }

pub fn PhysicsmechanicsdynamicLayer::get(self : PhysicsmechanicsdynamicLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicLayer::set(self : PhysicsmechanicsdynamicLayer, i : Int, v : Double) -> PhysicsmechanicsdynamicLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicLayer::sum(self : PhysicsmechanicsdynamicLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicLayer::mean(self : PhysicsmechanicsdynamicLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicLayer::scale(self : PhysicsmechanicsdynamicLayer, f : Double) -> PhysicsmechanicsdynamicLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicLayer::add(self : PhysicsmechanicsdynamicLayer, other : PhysicsmechanicsdynamicLayer) -> PhysicsmechanicsdynamicLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicLayer::copy(self : PhysicsmechanicsdynamicLayer) -> PhysicsmechanicsdynamicLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicLayer::fill(self : PhysicsmechanicsdynamicLayer, v : Double) -> PhysicsmechanicsdynamicLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicLayer::min(self : PhysicsmechanicsdynamicLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicLayer::max(self : PhysicsmechanicsdynamicLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicLayer::to_string(self : PhysicsmechanicsdynamicLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_buffer_make(size : Int) -> PhysicsmechanicsdynamicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicBuffer::len(self : PhysicsmechanicsdynamicBuffer) -> Int { self.size }

pub fn PhysicsmechanicsdynamicBuffer::get(self : PhysicsmechanicsdynamicBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicBuffer::set(self : PhysicsmechanicsdynamicBuffer, i : Int, v : Double) -> PhysicsmechanicsdynamicBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicBuffer::sum(self : PhysicsmechanicsdynamicBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicBuffer::mean(self : PhysicsmechanicsdynamicBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicBuffer::scale(self : PhysicsmechanicsdynamicBuffer, f : Double) -> PhysicsmechanicsdynamicBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicBuffer::add(self : PhysicsmechanicsdynamicBuffer, other : PhysicsmechanicsdynamicBuffer) -> PhysicsmechanicsdynamicBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicBuffer::copy(self : PhysicsmechanicsdynamicBuffer) -> PhysicsmechanicsdynamicBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicBuffer::fill(self : PhysicsmechanicsdynamicBuffer, v : Double) -> PhysicsmechanicsdynamicBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicBuffer::min(self : PhysicsmechanicsdynamicBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicBuffer::max(self : PhysicsmechanicsdynamicBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicBuffer::to_string(self : PhysicsmechanicsdynamicBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_cursor_make(size : Int) -> PhysicsmechanicsdynamicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicCursor::len(self : PhysicsmechanicsdynamicCursor) -> Int { self.size }

pub fn PhysicsmechanicsdynamicCursor::get(self : PhysicsmechanicsdynamicCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicCursor::set(self : PhysicsmechanicsdynamicCursor, i : Int, v : Double) -> PhysicsmechanicsdynamicCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicCursor::sum(self : PhysicsmechanicsdynamicCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicCursor::mean(self : PhysicsmechanicsdynamicCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicCursor::scale(self : PhysicsmechanicsdynamicCursor, f : Double) -> PhysicsmechanicsdynamicCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicCursor::add(self : PhysicsmechanicsdynamicCursor, other : PhysicsmechanicsdynamicCursor) -> PhysicsmechanicsdynamicCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicCursor::copy(self : PhysicsmechanicsdynamicCursor) -> PhysicsmechanicsdynamicCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicCursor::fill(self : PhysicsmechanicsdynamicCursor, v : Double) -> PhysicsmechanicsdynamicCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicCursor::min(self : PhysicsmechanicsdynamicCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicCursor::max(self : PhysicsmechanicsdynamicCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicCursor::to_string(self : PhysicsmechanicsdynamicCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_view_make(size : Int) -> PhysicsmechanicsdynamicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicView::len(self : PhysicsmechanicsdynamicView) -> Int { self.size }

pub fn PhysicsmechanicsdynamicView::get(self : PhysicsmechanicsdynamicView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicView::set(self : PhysicsmechanicsdynamicView, i : Int, v : Double) -> PhysicsmechanicsdynamicView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicView::sum(self : PhysicsmechanicsdynamicView) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicView::mean(self : PhysicsmechanicsdynamicView) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicView::scale(self : PhysicsmechanicsdynamicView, f : Double) -> PhysicsmechanicsdynamicView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicView::add(self : PhysicsmechanicsdynamicView, other : PhysicsmechanicsdynamicView) -> PhysicsmechanicsdynamicView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicView::copy(self : PhysicsmechanicsdynamicView) -> PhysicsmechanicsdynamicView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicView::fill(self : PhysicsmechanicsdynamicView, v : Double) -> PhysicsmechanicsdynamicView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicView::min(self : PhysicsmechanicsdynamicView) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicView::max(self : PhysicsmechanicsdynamicView) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicView::to_string(self : PhysicsmechanicsdynamicView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_range_make(size : Int) -> PhysicsmechanicsdynamicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicRange::len(self : PhysicsmechanicsdynamicRange) -> Int { self.size }

pub fn PhysicsmechanicsdynamicRange::get(self : PhysicsmechanicsdynamicRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicRange::set(self : PhysicsmechanicsdynamicRange, i : Int, v : Double) -> PhysicsmechanicsdynamicRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicRange::sum(self : PhysicsmechanicsdynamicRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicRange::mean(self : PhysicsmechanicsdynamicRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicRange::scale(self : PhysicsmechanicsdynamicRange, f : Double) -> PhysicsmechanicsdynamicRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicRange::add(self : PhysicsmechanicsdynamicRange, other : PhysicsmechanicsdynamicRange) -> PhysicsmechanicsdynamicRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicRange::copy(self : PhysicsmechanicsdynamicRange) -> PhysicsmechanicsdynamicRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicRange::fill(self : PhysicsmechanicsdynamicRange, v : Double) -> PhysicsmechanicsdynamicRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicRange::min(self : PhysicsmechanicsdynamicRange) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicRange::max(self : PhysicsmechanicsdynamicRange) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicRange::to_string(self : PhysicsmechanicsdynamicRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_slice_make(size : Int) -> PhysicsmechanicsdynamicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsdynamicSlice::len(self : PhysicsmechanicsdynamicSlice) -> Int { self.size }

pub fn PhysicsmechanicsdynamicSlice::get(self : PhysicsmechanicsdynamicSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsdynamicSlice::set(self : PhysicsmechanicsdynamicSlice, i : Int, v : Double) -> PhysicsmechanicsdynamicSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicSlice::sum(self : PhysicsmechanicsdynamicSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsdynamicSlice::mean(self : PhysicsmechanicsdynamicSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsdynamicSlice::scale(self : PhysicsmechanicsdynamicSlice, f : Double) -> PhysicsmechanicsdynamicSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicSlice::add(self : PhysicsmechanicsdynamicSlice, other : PhysicsmechanicsdynamicSlice) -> PhysicsmechanicsdynamicSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicSlice::copy(self : PhysicsmechanicsdynamicSlice) -> PhysicsmechanicsdynamicSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicSlice::fill(self : PhysicsmechanicsdynamicSlice, v : Double) -> PhysicsmechanicsdynamicSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsdynamicSlice::min(self : PhysicsmechanicsdynamicSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsdynamicSlice::max(self : PhysicsmechanicsdynamicSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsdynamicSlice::to_string(self : PhysicsmechanicsdynamicSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

