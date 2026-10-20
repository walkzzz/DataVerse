///===
/// extcore/physics_mechanics_static

pub(all) struct PhysicsmechanicsstaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_static_make_point(x : Double, y : Double) -> PhysicsmechanicsstaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_static_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsstaticPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicsstaticPoint::x(self : PhysicsmechanicsstaticPoint) -> Double { self.x }

pub fn PhysicsmechanicsstaticPoint::y(self : PhysicsmechanicsstaticPoint) -> Double { self.y }

pub fn PhysicsmechanicsstaticPoint::z(self : PhysicsmechanicsstaticPoint) -> Double { self.z }

pub fn PhysicsmechanicsstaticPoint::label(self : PhysicsmechanicsstaticPoint) -> Int { self.label }

pub fn PhysicsmechanicsstaticPoint::dist(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicsstaticPoint::add(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::sub(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::scale(self : PhysicsmechanicsstaticPoint, s : Double) -> PhysicsmechanicsstaticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::dot(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicsstaticPoint::cross(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicsstaticPoint::norm(self : PhysicsmechanicsstaticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicsstaticPoint::normalize(self : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsstaticPoint::negate(self : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::mid(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::lerp(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint, t : Double) -> PhysicsmechanicsstaticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::to_string(self : PhysicsmechanicsstaticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_static_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsstaticSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicsstaticSeries::len(self : PhysicsmechanicsstaticSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicsstaticSeries::sum(self : PhysicsmechanicsstaticSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicsstaticSeries::mean(self : PhysicsmechanicsstaticSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicsstaticSeries::min(self : PhysicsmechanicsstaticSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicsstaticSeries::max(self : PhysicsmechanicsstaticSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicsstaticSeries::range(self : PhysicsmechanicsstaticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicsstaticSeries::variance(self : PhysicsmechanicsstaticSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicsstaticSeries::std(self : PhysicsmechanicsstaticSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicsstaticSeries::median(self : PhysicsmechanicsstaticSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicsstaticSeries::scale(self : PhysicsmechanicsstaticSeries, f : Double) -> PhysicsmechanicsstaticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicsstaticSeries::add(self : PhysicsmechanicsstaticSeries, other : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsstaticSeries::sub(self : PhysicsmechanicsstaticSeries, other : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsstaticSeries::normalize(self : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicsstaticSeries::cumsum(self : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicsstaticSeries::to_string(self : PhysicsmechanicsstaticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsstaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_static_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsstaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_static_matrix_identity(n : Int) -> PhysicsmechanicsstaticMatrix {
  let m = physics_mechanics_static_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicsstaticMatrix::get(self : PhysicsmechanicsstaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicsstaticMatrix::transpose(self : PhysicsmechanicsstaticMatrix) -> PhysicsmechanicsstaticMatrix {
  let result = physics_mechanics_static_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicsstaticMatrix::add(self : PhysicsmechanicsstaticMatrix, other : PhysicsmechanicsstaticMatrix) -> PhysicsmechanicsstaticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_static_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicsstaticMatrix::scale(self : PhysicsmechanicsstaticMatrix, s : Double) -> PhysicsmechanicsstaticMatrix {
  let result = physics_mechanics_static_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicsstaticMatrix::multiply(self : PhysicsmechanicsstaticMatrix, other : PhysicsmechanicsstaticMatrix) -> PhysicsmechanicsstaticMatrix {
  if self.cols != other.rows { return physics_mechanics_static_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_static_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsmechanicsstaticMatrix::trace(self : PhysicsmechanicsstaticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicsstaticMatrix::det(self : PhysicsmechanicsstaticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicsstaticMatrix::norm(self : PhysicsmechanicsstaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicsstaticMatrix::to_string(self : PhysicsmechanicsstaticMatrix) -> String {
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

pub(all) struct PhysicsmechanicsstaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_static_make_vector(comps : Array[Double]) -> PhysicsmechanicsstaticVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_static_vector_zero(dim : Int) -> PhysicsmechanicsstaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicsstaticVector::add(self : PhysicsmechanicsstaticVector, other : PhysicsmechanicsstaticVector) -> PhysicsmechanicsstaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsstaticVector::sub(self : PhysicsmechanicsstaticVector, other : PhysicsmechanicsstaticVector) -> PhysicsmechanicsstaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsstaticVector::scale(self : PhysicsmechanicsstaticVector, s : Double) -> PhysicsmechanicsstaticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicsstaticVector::dot(self : PhysicsmechanicsstaticVector, other : PhysicsmechanicsstaticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicsstaticVector::norm(self : PhysicsmechanicsstaticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicsstaticVector::normalize(self : PhysicsmechanicsstaticVector) -> PhysicsmechanicsstaticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsstaticVector::dist(self : PhysicsmechanicsstaticVector, other : PhysicsmechanicsstaticVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicsstaticVector::to_string(self : PhysicsmechanicsstaticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsstaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_frame_make(size : Int) -> PhysicsmechanicsstaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticFrame::len(self : PhysicsmechanicsstaticFrame) -> Int { self.size }

pub fn PhysicsmechanicsstaticFrame::get(self : PhysicsmechanicsstaticFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticFrame::set(self : PhysicsmechanicsstaticFrame, i : Int, v : Double) -> PhysicsmechanicsstaticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticFrame::sum(self : PhysicsmechanicsstaticFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticFrame::mean(self : PhysicsmechanicsstaticFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticFrame::scale(self : PhysicsmechanicsstaticFrame, f : Double) -> PhysicsmechanicsstaticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticFrame::add(self : PhysicsmechanicsstaticFrame, other : PhysicsmechanicsstaticFrame) -> PhysicsmechanicsstaticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticFrame::copy(self : PhysicsmechanicsstaticFrame) -> PhysicsmechanicsstaticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticFrame::fill(self : PhysicsmechanicsstaticFrame, v : Double) -> PhysicsmechanicsstaticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticFrame::min(self : PhysicsmechanicsstaticFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticFrame::max(self : PhysicsmechanicsstaticFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticFrame::to_string(self : PhysicsmechanicsstaticFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_table_make(size : Int) -> PhysicsmechanicsstaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticTable::len(self : PhysicsmechanicsstaticTable) -> Int { self.size }

pub fn PhysicsmechanicsstaticTable::get(self : PhysicsmechanicsstaticTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticTable::set(self : PhysicsmechanicsstaticTable, i : Int, v : Double) -> PhysicsmechanicsstaticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticTable::sum(self : PhysicsmechanicsstaticTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticTable::mean(self : PhysicsmechanicsstaticTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticTable::scale(self : PhysicsmechanicsstaticTable, f : Double) -> PhysicsmechanicsstaticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticTable::add(self : PhysicsmechanicsstaticTable, other : PhysicsmechanicsstaticTable) -> PhysicsmechanicsstaticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticTable::copy(self : PhysicsmechanicsstaticTable) -> PhysicsmechanicsstaticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticTable::fill(self : PhysicsmechanicsstaticTable, v : Double) -> PhysicsmechanicsstaticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticTable::min(self : PhysicsmechanicsstaticTable) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticTable::max(self : PhysicsmechanicsstaticTable) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticTable::to_string(self : PhysicsmechanicsstaticTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_graphn_make(size : Int) -> PhysicsmechanicsstaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticGraphN::len(self : PhysicsmechanicsstaticGraphN) -> Int { self.size }

pub fn PhysicsmechanicsstaticGraphN::get(self : PhysicsmechanicsstaticGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticGraphN::set(self : PhysicsmechanicsstaticGraphN, i : Int, v : Double) -> PhysicsmechanicsstaticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticGraphN::sum(self : PhysicsmechanicsstaticGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticGraphN::mean(self : PhysicsmechanicsstaticGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticGraphN::scale(self : PhysicsmechanicsstaticGraphN, f : Double) -> PhysicsmechanicsstaticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticGraphN::add(self : PhysicsmechanicsstaticGraphN, other : PhysicsmechanicsstaticGraphN) -> PhysicsmechanicsstaticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticGraphN::copy(self : PhysicsmechanicsstaticGraphN) -> PhysicsmechanicsstaticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticGraphN::fill(self : PhysicsmechanicsstaticGraphN, v : Double) -> PhysicsmechanicsstaticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticGraphN::min(self : PhysicsmechanicsstaticGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticGraphN::max(self : PhysicsmechanicsstaticGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticGraphN::to_string(self : PhysicsmechanicsstaticGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_node_make(size : Int) -> PhysicsmechanicsstaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticNode::len(self : PhysicsmechanicsstaticNode) -> Int { self.size }

pub fn PhysicsmechanicsstaticNode::get(self : PhysicsmechanicsstaticNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticNode::set(self : PhysicsmechanicsstaticNode, i : Int, v : Double) -> PhysicsmechanicsstaticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticNode::sum(self : PhysicsmechanicsstaticNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticNode::mean(self : PhysicsmechanicsstaticNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticNode::scale(self : PhysicsmechanicsstaticNode, f : Double) -> PhysicsmechanicsstaticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticNode::add(self : PhysicsmechanicsstaticNode, other : PhysicsmechanicsstaticNode) -> PhysicsmechanicsstaticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticNode::copy(self : PhysicsmechanicsstaticNode) -> PhysicsmechanicsstaticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticNode::fill(self : PhysicsmechanicsstaticNode, v : Double) -> PhysicsmechanicsstaticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticNode::min(self : PhysicsmechanicsstaticNode) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticNode::max(self : PhysicsmechanicsstaticNode) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticNode::to_string(self : PhysicsmechanicsstaticNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_edge_make(size : Int) -> PhysicsmechanicsstaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticEdge::len(self : PhysicsmechanicsstaticEdge) -> Int { self.size }

pub fn PhysicsmechanicsstaticEdge::get(self : PhysicsmechanicsstaticEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticEdge::set(self : PhysicsmechanicsstaticEdge, i : Int, v : Double) -> PhysicsmechanicsstaticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticEdge::sum(self : PhysicsmechanicsstaticEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticEdge::mean(self : PhysicsmechanicsstaticEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticEdge::scale(self : PhysicsmechanicsstaticEdge, f : Double) -> PhysicsmechanicsstaticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticEdge::add(self : PhysicsmechanicsstaticEdge, other : PhysicsmechanicsstaticEdge) -> PhysicsmechanicsstaticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticEdge::copy(self : PhysicsmechanicsstaticEdge) -> PhysicsmechanicsstaticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticEdge::fill(self : PhysicsmechanicsstaticEdge, v : Double) -> PhysicsmechanicsstaticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticEdge::min(self : PhysicsmechanicsstaticEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticEdge::max(self : PhysicsmechanicsstaticEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticEdge::to_string(self : PhysicsmechanicsstaticEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_path_make(size : Int) -> PhysicsmechanicsstaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticPath::len(self : PhysicsmechanicsstaticPath) -> Int { self.size }

pub fn PhysicsmechanicsstaticPath::get(self : PhysicsmechanicsstaticPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticPath::set(self : PhysicsmechanicsstaticPath, i : Int, v : Double) -> PhysicsmechanicsstaticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticPath::sum(self : PhysicsmechanicsstaticPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticPath::mean(self : PhysicsmechanicsstaticPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticPath::scale(self : PhysicsmechanicsstaticPath, f : Double) -> PhysicsmechanicsstaticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticPath::add(self : PhysicsmechanicsstaticPath, other : PhysicsmechanicsstaticPath) -> PhysicsmechanicsstaticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticPath::copy(self : PhysicsmechanicsstaticPath) -> PhysicsmechanicsstaticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticPath::fill(self : PhysicsmechanicsstaticPath, v : Double) -> PhysicsmechanicsstaticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticPath::min(self : PhysicsmechanicsstaticPath) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticPath::max(self : PhysicsmechanicsstaticPath) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticPath::to_string(self : PhysicsmechanicsstaticPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_cluster_make(size : Int) -> PhysicsmechanicsstaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticCluster::len(self : PhysicsmechanicsstaticCluster) -> Int { self.size }

pub fn PhysicsmechanicsstaticCluster::get(self : PhysicsmechanicsstaticCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticCluster::set(self : PhysicsmechanicsstaticCluster, i : Int, v : Double) -> PhysicsmechanicsstaticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticCluster::sum(self : PhysicsmechanicsstaticCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticCluster::mean(self : PhysicsmechanicsstaticCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticCluster::scale(self : PhysicsmechanicsstaticCluster, f : Double) -> PhysicsmechanicsstaticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticCluster::add(self : PhysicsmechanicsstaticCluster, other : PhysicsmechanicsstaticCluster) -> PhysicsmechanicsstaticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticCluster::copy(self : PhysicsmechanicsstaticCluster) -> PhysicsmechanicsstaticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticCluster::fill(self : PhysicsmechanicsstaticCluster, v : Double) -> PhysicsmechanicsstaticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticCluster::min(self : PhysicsmechanicsstaticCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticCluster::max(self : PhysicsmechanicsstaticCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticCluster::to_string(self : PhysicsmechanicsstaticCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_model_make(size : Int) -> PhysicsmechanicsstaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticModel::len(self : PhysicsmechanicsstaticModel) -> Int { self.size }

pub fn PhysicsmechanicsstaticModel::get(self : PhysicsmechanicsstaticModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticModel::set(self : PhysicsmechanicsstaticModel, i : Int, v : Double) -> PhysicsmechanicsstaticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticModel::sum(self : PhysicsmechanicsstaticModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticModel::mean(self : PhysicsmechanicsstaticModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticModel::scale(self : PhysicsmechanicsstaticModel, f : Double) -> PhysicsmechanicsstaticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticModel::add(self : PhysicsmechanicsstaticModel, other : PhysicsmechanicsstaticModel) -> PhysicsmechanicsstaticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticModel::copy(self : PhysicsmechanicsstaticModel) -> PhysicsmechanicsstaticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticModel::fill(self : PhysicsmechanicsstaticModel, v : Double) -> PhysicsmechanicsstaticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticModel::min(self : PhysicsmechanicsstaticModel) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticModel::max(self : PhysicsmechanicsstaticModel) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticModel::to_string(self : PhysicsmechanicsstaticModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_layer_make(size : Int) -> PhysicsmechanicsstaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticLayer::len(self : PhysicsmechanicsstaticLayer) -> Int { self.size }

pub fn PhysicsmechanicsstaticLayer::get(self : PhysicsmechanicsstaticLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticLayer::set(self : PhysicsmechanicsstaticLayer, i : Int, v : Double) -> PhysicsmechanicsstaticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticLayer::sum(self : PhysicsmechanicsstaticLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticLayer::mean(self : PhysicsmechanicsstaticLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticLayer::scale(self : PhysicsmechanicsstaticLayer, f : Double) -> PhysicsmechanicsstaticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticLayer::add(self : PhysicsmechanicsstaticLayer, other : PhysicsmechanicsstaticLayer) -> PhysicsmechanicsstaticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticLayer::copy(self : PhysicsmechanicsstaticLayer) -> PhysicsmechanicsstaticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticLayer::fill(self : PhysicsmechanicsstaticLayer, v : Double) -> PhysicsmechanicsstaticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticLayer::min(self : PhysicsmechanicsstaticLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticLayer::max(self : PhysicsmechanicsstaticLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticLayer::to_string(self : PhysicsmechanicsstaticLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_buffer_make(size : Int) -> PhysicsmechanicsstaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticBuffer::len(self : PhysicsmechanicsstaticBuffer) -> Int { self.size }

pub fn PhysicsmechanicsstaticBuffer::get(self : PhysicsmechanicsstaticBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticBuffer::set(self : PhysicsmechanicsstaticBuffer, i : Int, v : Double) -> PhysicsmechanicsstaticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticBuffer::sum(self : PhysicsmechanicsstaticBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticBuffer::mean(self : PhysicsmechanicsstaticBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticBuffer::scale(self : PhysicsmechanicsstaticBuffer, f : Double) -> PhysicsmechanicsstaticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticBuffer::add(self : PhysicsmechanicsstaticBuffer, other : PhysicsmechanicsstaticBuffer) -> PhysicsmechanicsstaticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticBuffer::copy(self : PhysicsmechanicsstaticBuffer) -> PhysicsmechanicsstaticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticBuffer::fill(self : PhysicsmechanicsstaticBuffer, v : Double) -> PhysicsmechanicsstaticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticBuffer::min(self : PhysicsmechanicsstaticBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticBuffer::max(self : PhysicsmechanicsstaticBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticBuffer::to_string(self : PhysicsmechanicsstaticBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_cursor_make(size : Int) -> PhysicsmechanicsstaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticCursor::len(self : PhysicsmechanicsstaticCursor) -> Int { self.size }

pub fn PhysicsmechanicsstaticCursor::get(self : PhysicsmechanicsstaticCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticCursor::set(self : PhysicsmechanicsstaticCursor, i : Int, v : Double) -> PhysicsmechanicsstaticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticCursor::sum(self : PhysicsmechanicsstaticCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticCursor::mean(self : PhysicsmechanicsstaticCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticCursor::scale(self : PhysicsmechanicsstaticCursor, f : Double) -> PhysicsmechanicsstaticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticCursor::add(self : PhysicsmechanicsstaticCursor, other : PhysicsmechanicsstaticCursor) -> PhysicsmechanicsstaticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticCursor::copy(self : PhysicsmechanicsstaticCursor) -> PhysicsmechanicsstaticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticCursor::fill(self : PhysicsmechanicsstaticCursor, v : Double) -> PhysicsmechanicsstaticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticCursor::min(self : PhysicsmechanicsstaticCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticCursor::max(self : PhysicsmechanicsstaticCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticCursor::to_string(self : PhysicsmechanicsstaticCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_view_make(size : Int) -> PhysicsmechanicsstaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticView::len(self : PhysicsmechanicsstaticView) -> Int { self.size }

pub fn PhysicsmechanicsstaticView::get(self : PhysicsmechanicsstaticView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticView::set(self : PhysicsmechanicsstaticView, i : Int, v : Double) -> PhysicsmechanicsstaticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticView::sum(self : PhysicsmechanicsstaticView) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticView::mean(self : PhysicsmechanicsstaticView) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticView::scale(self : PhysicsmechanicsstaticView, f : Double) -> PhysicsmechanicsstaticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticView::add(self : PhysicsmechanicsstaticView, other : PhysicsmechanicsstaticView) -> PhysicsmechanicsstaticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticView::copy(self : PhysicsmechanicsstaticView) -> PhysicsmechanicsstaticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticView::fill(self : PhysicsmechanicsstaticView, v : Double) -> PhysicsmechanicsstaticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticView::min(self : PhysicsmechanicsstaticView) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticView::max(self : PhysicsmechanicsstaticView) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticView::to_string(self : PhysicsmechanicsstaticView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_range_make(size : Int) -> PhysicsmechanicsstaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticRange::len(self : PhysicsmechanicsstaticRange) -> Int { self.size }

pub fn PhysicsmechanicsstaticRange::get(self : PhysicsmechanicsstaticRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticRange::set(self : PhysicsmechanicsstaticRange, i : Int, v : Double) -> PhysicsmechanicsstaticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticRange::sum(self : PhysicsmechanicsstaticRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticRange::mean(self : PhysicsmechanicsstaticRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticRange::scale(self : PhysicsmechanicsstaticRange, f : Double) -> PhysicsmechanicsstaticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticRange::add(self : PhysicsmechanicsstaticRange, other : PhysicsmechanicsstaticRange) -> PhysicsmechanicsstaticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticRange::copy(self : PhysicsmechanicsstaticRange) -> PhysicsmechanicsstaticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticRange::fill(self : PhysicsmechanicsstaticRange, v : Double) -> PhysicsmechanicsstaticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticRange::min(self : PhysicsmechanicsstaticRange) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticRange::max(self : PhysicsmechanicsstaticRange) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticRange::to_string(self : PhysicsmechanicsstaticRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_slice_make(size : Int) -> PhysicsmechanicsstaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsstaticSlice::len(self : PhysicsmechanicsstaticSlice) -> Int { self.size }

pub fn PhysicsmechanicsstaticSlice::get(self : PhysicsmechanicsstaticSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsstaticSlice::set(self : PhysicsmechanicsstaticSlice, i : Int, v : Double) -> PhysicsmechanicsstaticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticSlice::sum(self : PhysicsmechanicsstaticSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsstaticSlice::mean(self : PhysicsmechanicsstaticSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsstaticSlice::scale(self : PhysicsmechanicsstaticSlice, f : Double) -> PhysicsmechanicsstaticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticSlice::add(self : PhysicsmechanicsstaticSlice, other : PhysicsmechanicsstaticSlice) -> PhysicsmechanicsstaticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsstaticSlice::copy(self : PhysicsmechanicsstaticSlice) -> PhysicsmechanicsstaticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticSlice::fill(self : PhysicsmechanicsstaticSlice, v : Double) -> PhysicsmechanicsstaticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsstaticSlice::min(self : PhysicsmechanicsstaticSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsstaticSlice::max(self : PhysicsmechanicsstaticSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsstaticSlice::to_string(self : PhysicsmechanicsstaticSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

