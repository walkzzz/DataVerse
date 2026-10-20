///===
/// extcore/physics_mechanics_kinematic

pub(all) struct PhysicsmechanicskinematicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_kinematic_make_point(x : Double, y : Double) -> PhysicsmechanicskinematicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_kinematic_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicskinematicPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicskinematicPoint::x(self : PhysicsmechanicskinematicPoint) -> Double { self.x }

pub fn PhysicsmechanicskinematicPoint::y(self : PhysicsmechanicskinematicPoint) -> Double { self.y }

pub fn PhysicsmechanicskinematicPoint::z(self : PhysicsmechanicskinematicPoint) -> Double { self.z }

pub fn PhysicsmechanicskinematicPoint::label(self : PhysicsmechanicskinematicPoint) -> Int { self.label }

pub fn PhysicsmechanicskinematicPoint::dist(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicskinematicPoint::add(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::sub(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::scale(self : PhysicsmechanicskinematicPoint, s : Double) -> PhysicsmechanicskinematicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::dot(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicskinematicPoint::cross(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicskinematicPoint::norm(self : PhysicsmechanicskinematicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicskinematicPoint::normalize(self : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicskinematicPoint::negate(self : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::mid(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::lerp(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint, t : Double) -> PhysicsmechanicskinematicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::to_string(self : PhysicsmechanicskinematicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_kinematic_make_series(vals : Array[Double], name : String) -> PhysicsmechanicskinematicSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicskinematicSeries::len(self : PhysicsmechanicskinematicSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicskinematicSeries::sum(self : PhysicsmechanicskinematicSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicskinematicSeries::mean(self : PhysicsmechanicskinematicSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicskinematicSeries::min(self : PhysicsmechanicskinematicSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicskinematicSeries::max(self : PhysicsmechanicskinematicSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicskinematicSeries::range(self : PhysicsmechanicskinematicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicskinematicSeries::variance(self : PhysicsmechanicskinematicSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicskinematicSeries::std(self : PhysicsmechanicskinematicSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicskinematicSeries::median(self : PhysicsmechanicskinematicSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicskinematicSeries::scale(self : PhysicsmechanicskinematicSeries, f : Double) -> PhysicsmechanicskinematicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicskinematicSeries::add(self : PhysicsmechanicskinematicSeries, other : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicskinematicSeries::sub(self : PhysicsmechanicskinematicSeries, other : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicskinematicSeries::normalize(self : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicskinematicSeries::cumsum(self : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicskinematicSeries::to_string(self : PhysicsmechanicskinematicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicskinematicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_kinematic_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicskinematicMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn physics_mechanics_kinematic_matrix_identity(n : Int) -> PhysicsmechanicskinematicMatrix {
  let m = physics_mechanics_kinematic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicskinematicMatrix::get(self : PhysicsmechanicskinematicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicskinematicMatrix::transpose(self : PhysicsmechanicskinematicMatrix) -> PhysicsmechanicskinematicMatrix {
  let result = physics_mechanics_kinematic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicskinematicMatrix::add(self : PhysicsmechanicskinematicMatrix, other : PhysicsmechanicskinematicMatrix) -> PhysicsmechanicskinematicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_kinematic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicskinematicMatrix::scale(self : PhysicsmechanicskinematicMatrix, s : Double) -> PhysicsmechanicskinematicMatrix {
  let result = physics_mechanics_kinematic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicskinematicMatrix::multiply(self : PhysicsmechanicskinematicMatrix, other : PhysicsmechanicskinematicMatrix) -> PhysicsmechanicskinematicMatrix {
  if self.cols != other.rows { return physics_mechanics_kinematic_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_kinematic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsmechanicskinematicMatrix::trace(self : PhysicsmechanicskinematicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicskinematicMatrix::det(self : PhysicsmechanicskinematicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicskinematicMatrix::norm(self : PhysicsmechanicskinematicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicskinematicMatrix::to_string(self : PhysicsmechanicskinematicMatrix) -> String {
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

pub(all) struct PhysicsmechanicskinematicVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_kinematic_make_vector(comps : Array[Double]) -> PhysicsmechanicskinematicVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_kinematic_vector_zero(dim : Int) -> PhysicsmechanicskinematicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicskinematicVector::add(self : PhysicsmechanicskinematicVector, other : PhysicsmechanicskinematicVector) -> PhysicsmechanicskinematicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicskinematicVector::sub(self : PhysicsmechanicskinematicVector, other : PhysicsmechanicskinematicVector) -> PhysicsmechanicskinematicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicskinematicVector::scale(self : PhysicsmechanicskinematicVector, s : Double) -> PhysicsmechanicskinematicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicskinematicVector::dot(self : PhysicsmechanicskinematicVector, other : PhysicsmechanicskinematicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicskinematicVector::norm(self : PhysicsmechanicskinematicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicskinematicVector::normalize(self : PhysicsmechanicskinematicVector) -> PhysicsmechanicskinematicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicskinematicVector::dist(self : PhysicsmechanicskinematicVector, other : PhysicsmechanicskinematicVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicskinematicVector::to_string(self : PhysicsmechanicskinematicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicskinematicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_frame_make(size : Int) -> PhysicsmechanicskinematicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicFrame::len(self : PhysicsmechanicskinematicFrame) -> Int { self.size }

pub fn PhysicsmechanicskinematicFrame::get(self : PhysicsmechanicskinematicFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicFrame::set(self : PhysicsmechanicskinematicFrame, i : Int, v : Double) -> PhysicsmechanicskinematicFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicFrame::sum(self : PhysicsmechanicskinematicFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicFrame::mean(self : PhysicsmechanicskinematicFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicFrame::scale(self : PhysicsmechanicskinematicFrame, f : Double) -> PhysicsmechanicskinematicFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicFrame::add(self : PhysicsmechanicskinematicFrame, other : PhysicsmechanicskinematicFrame) -> PhysicsmechanicskinematicFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicFrame::copy(self : PhysicsmechanicskinematicFrame) -> PhysicsmechanicskinematicFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicFrame::fill(self : PhysicsmechanicskinematicFrame, v : Double) -> PhysicsmechanicskinematicFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicFrame::min(self : PhysicsmechanicskinematicFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicFrame::max(self : PhysicsmechanicskinematicFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicFrame::to_string(self : PhysicsmechanicskinematicFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_table_make(size : Int) -> PhysicsmechanicskinematicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicTable::len(self : PhysicsmechanicskinematicTable) -> Int { self.size }

pub fn PhysicsmechanicskinematicTable::get(self : PhysicsmechanicskinematicTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicTable::set(self : PhysicsmechanicskinematicTable, i : Int, v : Double) -> PhysicsmechanicskinematicTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicTable::sum(self : PhysicsmechanicskinematicTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicTable::mean(self : PhysicsmechanicskinematicTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicTable::scale(self : PhysicsmechanicskinematicTable, f : Double) -> PhysicsmechanicskinematicTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicTable::add(self : PhysicsmechanicskinematicTable, other : PhysicsmechanicskinematicTable) -> PhysicsmechanicskinematicTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicTable::copy(self : PhysicsmechanicskinematicTable) -> PhysicsmechanicskinematicTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicTable::fill(self : PhysicsmechanicskinematicTable, v : Double) -> PhysicsmechanicskinematicTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicTable::min(self : PhysicsmechanicskinematicTable) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicTable::max(self : PhysicsmechanicskinematicTable) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicTable::to_string(self : PhysicsmechanicskinematicTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_graphn_make(size : Int) -> PhysicsmechanicskinematicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicGraphN::len(self : PhysicsmechanicskinematicGraphN) -> Int { self.size }

pub fn PhysicsmechanicskinematicGraphN::get(self : PhysicsmechanicskinematicGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicGraphN::set(self : PhysicsmechanicskinematicGraphN, i : Int, v : Double) -> PhysicsmechanicskinematicGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicGraphN::sum(self : PhysicsmechanicskinematicGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicGraphN::mean(self : PhysicsmechanicskinematicGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicGraphN::scale(self : PhysicsmechanicskinematicGraphN, f : Double) -> PhysicsmechanicskinematicGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicGraphN::add(self : PhysicsmechanicskinematicGraphN, other : PhysicsmechanicskinematicGraphN) -> PhysicsmechanicskinematicGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicGraphN::copy(self : PhysicsmechanicskinematicGraphN) -> PhysicsmechanicskinematicGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicGraphN::fill(self : PhysicsmechanicskinematicGraphN, v : Double) -> PhysicsmechanicskinematicGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicGraphN::min(self : PhysicsmechanicskinematicGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicGraphN::max(self : PhysicsmechanicskinematicGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicGraphN::to_string(self : PhysicsmechanicskinematicGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_node_make(size : Int) -> PhysicsmechanicskinematicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicNode::len(self : PhysicsmechanicskinematicNode) -> Int { self.size }

pub fn PhysicsmechanicskinematicNode::get(self : PhysicsmechanicskinematicNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicNode::set(self : PhysicsmechanicskinematicNode, i : Int, v : Double) -> PhysicsmechanicskinematicNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicNode::sum(self : PhysicsmechanicskinematicNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicNode::mean(self : PhysicsmechanicskinematicNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicNode::scale(self : PhysicsmechanicskinematicNode, f : Double) -> PhysicsmechanicskinematicNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicNode::add(self : PhysicsmechanicskinematicNode, other : PhysicsmechanicskinematicNode) -> PhysicsmechanicskinematicNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicNode::copy(self : PhysicsmechanicskinematicNode) -> PhysicsmechanicskinematicNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicNode::fill(self : PhysicsmechanicskinematicNode, v : Double) -> PhysicsmechanicskinematicNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicNode::min(self : PhysicsmechanicskinematicNode) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicNode::max(self : PhysicsmechanicskinematicNode) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicNode::to_string(self : PhysicsmechanicskinematicNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_edge_make(size : Int) -> PhysicsmechanicskinematicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicEdge::len(self : PhysicsmechanicskinematicEdge) -> Int { self.size }

pub fn PhysicsmechanicskinematicEdge::get(self : PhysicsmechanicskinematicEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicEdge::set(self : PhysicsmechanicskinematicEdge, i : Int, v : Double) -> PhysicsmechanicskinematicEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicEdge::sum(self : PhysicsmechanicskinematicEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicEdge::mean(self : PhysicsmechanicskinematicEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicEdge::scale(self : PhysicsmechanicskinematicEdge, f : Double) -> PhysicsmechanicskinematicEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicEdge::add(self : PhysicsmechanicskinematicEdge, other : PhysicsmechanicskinematicEdge) -> PhysicsmechanicskinematicEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicEdge::copy(self : PhysicsmechanicskinematicEdge) -> PhysicsmechanicskinematicEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicEdge::fill(self : PhysicsmechanicskinematicEdge, v : Double) -> PhysicsmechanicskinematicEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicEdge::min(self : PhysicsmechanicskinematicEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicEdge::max(self : PhysicsmechanicskinematicEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicEdge::to_string(self : PhysicsmechanicskinematicEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_path_make(size : Int) -> PhysicsmechanicskinematicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicPath::len(self : PhysicsmechanicskinematicPath) -> Int { self.size }

pub fn PhysicsmechanicskinematicPath::get(self : PhysicsmechanicskinematicPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicPath::set(self : PhysicsmechanicskinematicPath, i : Int, v : Double) -> PhysicsmechanicskinematicPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicPath::sum(self : PhysicsmechanicskinematicPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicPath::mean(self : PhysicsmechanicskinematicPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicPath::scale(self : PhysicsmechanicskinematicPath, f : Double) -> PhysicsmechanicskinematicPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicPath::add(self : PhysicsmechanicskinematicPath, other : PhysicsmechanicskinematicPath) -> PhysicsmechanicskinematicPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicPath::copy(self : PhysicsmechanicskinematicPath) -> PhysicsmechanicskinematicPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicPath::fill(self : PhysicsmechanicskinematicPath, v : Double) -> PhysicsmechanicskinematicPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicPath::min(self : PhysicsmechanicskinematicPath) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicPath::max(self : PhysicsmechanicskinematicPath) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicPath::to_string(self : PhysicsmechanicskinematicPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_cluster_make(size : Int) -> PhysicsmechanicskinematicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicCluster::len(self : PhysicsmechanicskinematicCluster) -> Int { self.size }

pub fn PhysicsmechanicskinematicCluster::get(self : PhysicsmechanicskinematicCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicCluster::set(self : PhysicsmechanicskinematicCluster, i : Int, v : Double) -> PhysicsmechanicskinematicCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicCluster::sum(self : PhysicsmechanicskinematicCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicCluster::mean(self : PhysicsmechanicskinematicCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicCluster::scale(self : PhysicsmechanicskinematicCluster, f : Double) -> PhysicsmechanicskinematicCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicCluster::add(self : PhysicsmechanicskinematicCluster, other : PhysicsmechanicskinematicCluster) -> PhysicsmechanicskinematicCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicCluster::copy(self : PhysicsmechanicskinematicCluster) -> PhysicsmechanicskinematicCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicCluster::fill(self : PhysicsmechanicskinematicCluster, v : Double) -> PhysicsmechanicskinematicCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicCluster::min(self : PhysicsmechanicskinematicCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicCluster::max(self : PhysicsmechanicskinematicCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicCluster::to_string(self : PhysicsmechanicskinematicCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_model_make(size : Int) -> PhysicsmechanicskinematicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicModel::len(self : PhysicsmechanicskinematicModel) -> Int { self.size }

pub fn PhysicsmechanicskinematicModel::get(self : PhysicsmechanicskinematicModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicModel::set(self : PhysicsmechanicskinematicModel, i : Int, v : Double) -> PhysicsmechanicskinematicModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicModel::sum(self : PhysicsmechanicskinematicModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicModel::mean(self : PhysicsmechanicskinematicModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicModel::scale(self : PhysicsmechanicskinematicModel, f : Double) -> PhysicsmechanicskinematicModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicModel::add(self : PhysicsmechanicskinematicModel, other : PhysicsmechanicskinematicModel) -> PhysicsmechanicskinematicModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicModel::copy(self : PhysicsmechanicskinematicModel) -> PhysicsmechanicskinematicModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicModel::fill(self : PhysicsmechanicskinematicModel, v : Double) -> PhysicsmechanicskinematicModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicModel::min(self : PhysicsmechanicskinematicModel) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicModel::max(self : PhysicsmechanicskinematicModel) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicModel::to_string(self : PhysicsmechanicskinematicModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_layer_make(size : Int) -> PhysicsmechanicskinematicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicLayer::len(self : PhysicsmechanicskinematicLayer) -> Int { self.size }

pub fn PhysicsmechanicskinematicLayer::get(self : PhysicsmechanicskinematicLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicLayer::set(self : PhysicsmechanicskinematicLayer, i : Int, v : Double) -> PhysicsmechanicskinematicLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicLayer::sum(self : PhysicsmechanicskinematicLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicLayer::mean(self : PhysicsmechanicskinematicLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicLayer::scale(self : PhysicsmechanicskinematicLayer, f : Double) -> PhysicsmechanicskinematicLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicLayer::add(self : PhysicsmechanicskinematicLayer, other : PhysicsmechanicskinematicLayer) -> PhysicsmechanicskinematicLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicLayer::copy(self : PhysicsmechanicskinematicLayer) -> PhysicsmechanicskinematicLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicLayer::fill(self : PhysicsmechanicskinematicLayer, v : Double) -> PhysicsmechanicskinematicLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicLayer::min(self : PhysicsmechanicskinematicLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicLayer::max(self : PhysicsmechanicskinematicLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicLayer::to_string(self : PhysicsmechanicskinematicLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_buffer_make(size : Int) -> PhysicsmechanicskinematicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicBuffer::len(self : PhysicsmechanicskinematicBuffer) -> Int { self.size }

pub fn PhysicsmechanicskinematicBuffer::get(self : PhysicsmechanicskinematicBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicBuffer::set(self : PhysicsmechanicskinematicBuffer, i : Int, v : Double) -> PhysicsmechanicskinematicBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicBuffer::sum(self : PhysicsmechanicskinematicBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicBuffer::mean(self : PhysicsmechanicskinematicBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicBuffer::scale(self : PhysicsmechanicskinematicBuffer, f : Double) -> PhysicsmechanicskinematicBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicBuffer::add(self : PhysicsmechanicskinematicBuffer, other : PhysicsmechanicskinematicBuffer) -> PhysicsmechanicskinematicBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicBuffer::copy(self : PhysicsmechanicskinematicBuffer) -> PhysicsmechanicskinematicBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicBuffer::fill(self : PhysicsmechanicskinematicBuffer, v : Double) -> PhysicsmechanicskinematicBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicBuffer::min(self : PhysicsmechanicskinematicBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicBuffer::max(self : PhysicsmechanicskinematicBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicBuffer::to_string(self : PhysicsmechanicskinematicBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_cursor_make(size : Int) -> PhysicsmechanicskinematicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicCursor::len(self : PhysicsmechanicskinematicCursor) -> Int { self.size }

pub fn PhysicsmechanicskinematicCursor::get(self : PhysicsmechanicskinematicCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicCursor::set(self : PhysicsmechanicskinematicCursor, i : Int, v : Double) -> PhysicsmechanicskinematicCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicCursor::sum(self : PhysicsmechanicskinematicCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicCursor::mean(self : PhysicsmechanicskinematicCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicCursor::scale(self : PhysicsmechanicskinematicCursor, f : Double) -> PhysicsmechanicskinematicCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicCursor::add(self : PhysicsmechanicskinematicCursor, other : PhysicsmechanicskinematicCursor) -> PhysicsmechanicskinematicCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicCursor::copy(self : PhysicsmechanicskinematicCursor) -> PhysicsmechanicskinematicCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicCursor::fill(self : PhysicsmechanicskinematicCursor, v : Double) -> PhysicsmechanicskinematicCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicCursor::min(self : PhysicsmechanicskinematicCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicCursor::max(self : PhysicsmechanicskinematicCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicCursor::to_string(self : PhysicsmechanicskinematicCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_view_make(size : Int) -> PhysicsmechanicskinematicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicView::len(self : PhysicsmechanicskinematicView) -> Int { self.size }

pub fn PhysicsmechanicskinematicView::get(self : PhysicsmechanicskinematicView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicView::set(self : PhysicsmechanicskinematicView, i : Int, v : Double) -> PhysicsmechanicskinematicView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicView::sum(self : PhysicsmechanicskinematicView) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicView::mean(self : PhysicsmechanicskinematicView) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicView::scale(self : PhysicsmechanicskinematicView, f : Double) -> PhysicsmechanicskinematicView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicView::add(self : PhysicsmechanicskinematicView, other : PhysicsmechanicskinematicView) -> PhysicsmechanicskinematicView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicView::copy(self : PhysicsmechanicskinematicView) -> PhysicsmechanicskinematicView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicView::fill(self : PhysicsmechanicskinematicView, v : Double) -> PhysicsmechanicskinematicView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicView::min(self : PhysicsmechanicskinematicView) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicView::max(self : PhysicsmechanicskinematicView) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicView::to_string(self : PhysicsmechanicskinematicView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_range_make(size : Int) -> PhysicsmechanicskinematicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicRange::len(self : PhysicsmechanicskinematicRange) -> Int { self.size }

pub fn PhysicsmechanicskinematicRange::get(self : PhysicsmechanicskinematicRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicRange::set(self : PhysicsmechanicskinematicRange, i : Int, v : Double) -> PhysicsmechanicskinematicRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicRange::sum(self : PhysicsmechanicskinematicRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicRange::mean(self : PhysicsmechanicskinematicRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicRange::scale(self : PhysicsmechanicskinematicRange, f : Double) -> PhysicsmechanicskinematicRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicRange::add(self : PhysicsmechanicskinematicRange, other : PhysicsmechanicskinematicRange) -> PhysicsmechanicskinematicRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicRange::copy(self : PhysicsmechanicskinematicRange) -> PhysicsmechanicskinematicRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicRange::fill(self : PhysicsmechanicskinematicRange, v : Double) -> PhysicsmechanicskinematicRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicRange::min(self : PhysicsmechanicskinematicRange) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicRange::max(self : PhysicsmechanicskinematicRange) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicRange::to_string(self : PhysicsmechanicskinematicRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_slice_make(size : Int) -> PhysicsmechanicskinematicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicskinematicSlice::len(self : PhysicsmechanicskinematicSlice) -> Int { self.size }

pub fn PhysicsmechanicskinematicSlice::get(self : PhysicsmechanicskinematicSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicskinematicSlice::set(self : PhysicsmechanicskinematicSlice, i : Int, v : Double) -> PhysicsmechanicskinematicSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicSlice::sum(self : PhysicsmechanicskinematicSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicskinematicSlice::mean(self : PhysicsmechanicskinematicSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicskinematicSlice::scale(self : PhysicsmechanicskinematicSlice, f : Double) -> PhysicsmechanicskinematicSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicSlice::add(self : PhysicsmechanicskinematicSlice, other : PhysicsmechanicskinematicSlice) -> PhysicsmechanicskinematicSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicskinematicSlice::copy(self : PhysicsmechanicskinematicSlice) -> PhysicsmechanicskinematicSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicSlice::fill(self : PhysicsmechanicskinematicSlice, v : Double) -> PhysicsmechanicskinematicSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicskinematicSlice::min(self : PhysicsmechanicskinematicSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicskinematicSlice::max(self : PhysicsmechanicskinematicSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicskinematicSlice::to_string(self : PhysicsmechanicskinematicSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

