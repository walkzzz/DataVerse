///===
/// extcore/physics_em_fem

pub(all) struct PhysicsemfemPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_fem_make_point(x : Double, y : Double) -> PhysicsemfemPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_fem_make_point3(x : Double, y : Double, z : Double) -> PhysicsemfemPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemfemPoint::x(self : PhysicsemfemPoint) -> Double { self.x }

pub fn PhysicsemfemPoint::y(self : PhysicsemfemPoint) -> Double { self.y }

pub fn PhysicsemfemPoint::z(self : PhysicsemfemPoint) -> Double { self.z }

pub fn PhysicsemfemPoint::label(self : PhysicsemfemPoint) -> Int { self.label }

pub fn PhysicsemfemPoint::dist(self : PhysicsemfemPoint, other : PhysicsemfemPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemfemPoint::add(self : PhysicsemfemPoint, other : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemfemPoint::sub(self : PhysicsemfemPoint, other : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemfemPoint::scale(self : PhysicsemfemPoint, s : Double) -> PhysicsemfemPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemfemPoint::dot(self : PhysicsemfemPoint, other : PhysicsemfemPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemfemPoint::cross(self : PhysicsemfemPoint, other : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemfemPoint::norm(self : PhysicsemfemPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemfemPoint::normalize(self : PhysicsemfemPoint) -> PhysicsemfemPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemfemPoint::negate(self : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemfemPoint::mid(self : PhysicsemfemPoint, other : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemfemPoint::lerp(self : PhysicsemfemPoint, other : PhysicsemfemPoint, t : Double) -> PhysicsemfemPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemfemPoint::to_string(self : PhysicsemfemPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemfemSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_fem_make_series(vals : Array[Double], name : String) -> PhysicsemfemSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemfemSeries::len(self : PhysicsemfemSeries) -> Int { self.vals.length() }

pub fn PhysicsemfemSeries::sum(self : PhysicsemfemSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemfemSeries::mean(self : PhysicsemfemSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemfemSeries::min(self : PhysicsemfemSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemfemSeries::max(self : PhysicsemfemSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemfemSeries::range(self : PhysicsemfemSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemfemSeries::variance(self : PhysicsemfemSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemfemSeries::std(self : PhysicsemfemSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemfemSeries::median(self : PhysicsemfemSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemfemSeries::scale(self : PhysicsemfemSeries, f : Double) -> PhysicsemfemSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemfemSeries::add(self : PhysicsemfemSeries, other : PhysicsemfemSeries) -> PhysicsemfemSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemfemSeries::sub(self : PhysicsemfemSeries, other : PhysicsemfemSeries) -> PhysicsemfemSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemfemSeries::normalize(self : PhysicsemfemSeries) -> PhysicsemfemSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemfemSeries::cumsum(self : PhysicsemfemSeries) -> PhysicsemfemSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemfemSeries::to_string(self : PhysicsemfemSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemfemMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_fem_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemfemMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_fem_matrix_identity(n : Int) -> PhysicsemfemMatrix {
  let m = physics_em_fem_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemfemMatrix::get(self : PhysicsemfemMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemfemMatrix::transpose(self : PhysicsemfemMatrix) -> PhysicsemfemMatrix {
  let result = physics_em_fem_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemfemMatrix::add(self : PhysicsemfemMatrix, other : PhysicsemfemMatrix) -> PhysicsemfemMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_fem_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemfemMatrix::scale(self : PhysicsemfemMatrix, s : Double) -> PhysicsemfemMatrix {
  let result = physics_em_fem_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemfemMatrix::multiply(self : PhysicsemfemMatrix, other : PhysicsemfemMatrix) -> PhysicsemfemMatrix {
  if self.cols != other.rows { return physics_em_fem_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_fem_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsemfemMatrix::trace(self : PhysicsemfemMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemfemMatrix::det(self : PhysicsemfemMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemfemMatrix::norm(self : PhysicsemfemMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemfemMatrix::to_string(self : PhysicsemfemMatrix) -> String {
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

pub(all) struct PhysicsemfemVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_fem_make_vector(comps : Array[Double]) -> PhysicsemfemVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_fem_vector_zero(dim : Int) -> PhysicsemfemVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemfemVector::add(self : PhysicsemfemVector, other : PhysicsemfemVector) -> PhysicsemfemVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemfemVector::sub(self : PhysicsemfemVector, other : PhysicsemfemVector) -> PhysicsemfemVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemfemVector::scale(self : PhysicsemfemVector, s : Double) -> PhysicsemfemVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemfemVector::dot(self : PhysicsemfemVector, other : PhysicsemfemVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemfemVector::norm(self : PhysicsemfemVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemfemVector::normalize(self : PhysicsemfemVector) -> PhysicsemfemVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemfemVector::dist(self : PhysicsemfemVector, other : PhysicsemfemVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemfemVector::to_string(self : PhysicsemfemVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemfemFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_frame_make(size : Int) -> PhysicsemfemFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemFrame::len(self : PhysicsemfemFrame) -> Int { self.size }

pub fn PhysicsemfemFrame::get(self : PhysicsemfemFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemFrame::set(self : PhysicsemfemFrame, i : Int, v : Double) -> PhysicsemfemFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemFrame::sum(self : PhysicsemfemFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemFrame::mean(self : PhysicsemfemFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemFrame::scale(self : PhysicsemfemFrame, f : Double) -> PhysicsemfemFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemFrame::add(self : PhysicsemfemFrame, other : PhysicsemfemFrame) -> PhysicsemfemFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemFrame::copy(self : PhysicsemfemFrame) -> PhysicsemfemFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemFrame::fill(self : PhysicsemfemFrame, v : Double) -> PhysicsemfemFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemFrame::min(self : PhysicsemfemFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemFrame::max(self : PhysicsemfemFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemFrame::to_string(self : PhysicsemfemFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_table_make(size : Int) -> PhysicsemfemTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemTable::len(self : PhysicsemfemTable) -> Int { self.size }

pub fn PhysicsemfemTable::get(self : PhysicsemfemTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemTable::set(self : PhysicsemfemTable, i : Int, v : Double) -> PhysicsemfemTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemTable::sum(self : PhysicsemfemTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemTable::mean(self : PhysicsemfemTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemTable::scale(self : PhysicsemfemTable, f : Double) -> PhysicsemfemTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemTable::add(self : PhysicsemfemTable, other : PhysicsemfemTable) -> PhysicsemfemTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemTable::copy(self : PhysicsemfemTable) -> PhysicsemfemTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemTable::fill(self : PhysicsemfemTable, v : Double) -> PhysicsemfemTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemTable::min(self : PhysicsemfemTable) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemTable::max(self : PhysicsemfemTable) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemTable::to_string(self : PhysicsemfemTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_graphn_make(size : Int) -> PhysicsemfemGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemGraphN::len(self : PhysicsemfemGraphN) -> Int { self.size }

pub fn PhysicsemfemGraphN::get(self : PhysicsemfemGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemGraphN::set(self : PhysicsemfemGraphN, i : Int, v : Double) -> PhysicsemfemGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemGraphN::sum(self : PhysicsemfemGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemGraphN::mean(self : PhysicsemfemGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemGraphN::scale(self : PhysicsemfemGraphN, f : Double) -> PhysicsemfemGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemGraphN::add(self : PhysicsemfemGraphN, other : PhysicsemfemGraphN) -> PhysicsemfemGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemGraphN::copy(self : PhysicsemfemGraphN) -> PhysicsemfemGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemGraphN::fill(self : PhysicsemfemGraphN, v : Double) -> PhysicsemfemGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemGraphN::min(self : PhysicsemfemGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemGraphN::max(self : PhysicsemfemGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemGraphN::to_string(self : PhysicsemfemGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_node_make(size : Int) -> PhysicsemfemNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemNode::len(self : PhysicsemfemNode) -> Int { self.size }

pub fn PhysicsemfemNode::get(self : PhysicsemfemNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemNode::set(self : PhysicsemfemNode, i : Int, v : Double) -> PhysicsemfemNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemNode::sum(self : PhysicsemfemNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemNode::mean(self : PhysicsemfemNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemNode::scale(self : PhysicsemfemNode, f : Double) -> PhysicsemfemNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemNode::add(self : PhysicsemfemNode, other : PhysicsemfemNode) -> PhysicsemfemNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemNode::copy(self : PhysicsemfemNode) -> PhysicsemfemNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemNode::fill(self : PhysicsemfemNode, v : Double) -> PhysicsemfemNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemNode::min(self : PhysicsemfemNode) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemNode::max(self : PhysicsemfemNode) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemNode::to_string(self : PhysicsemfemNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_edge_make(size : Int) -> PhysicsemfemEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemEdge::len(self : PhysicsemfemEdge) -> Int { self.size }

pub fn PhysicsemfemEdge::get(self : PhysicsemfemEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemEdge::set(self : PhysicsemfemEdge, i : Int, v : Double) -> PhysicsemfemEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemEdge::sum(self : PhysicsemfemEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemEdge::mean(self : PhysicsemfemEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemEdge::scale(self : PhysicsemfemEdge, f : Double) -> PhysicsemfemEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemEdge::add(self : PhysicsemfemEdge, other : PhysicsemfemEdge) -> PhysicsemfemEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemEdge::copy(self : PhysicsemfemEdge) -> PhysicsemfemEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemEdge::fill(self : PhysicsemfemEdge, v : Double) -> PhysicsemfemEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemEdge::min(self : PhysicsemfemEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemEdge::max(self : PhysicsemfemEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemEdge::to_string(self : PhysicsemfemEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_path_make(size : Int) -> PhysicsemfemPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemPath::len(self : PhysicsemfemPath) -> Int { self.size }

pub fn PhysicsemfemPath::get(self : PhysicsemfemPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemPath::set(self : PhysicsemfemPath, i : Int, v : Double) -> PhysicsemfemPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemPath::sum(self : PhysicsemfemPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemPath::mean(self : PhysicsemfemPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemPath::scale(self : PhysicsemfemPath, f : Double) -> PhysicsemfemPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemPath::add(self : PhysicsemfemPath, other : PhysicsemfemPath) -> PhysicsemfemPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemPath::copy(self : PhysicsemfemPath) -> PhysicsemfemPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemPath::fill(self : PhysicsemfemPath, v : Double) -> PhysicsemfemPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemPath::min(self : PhysicsemfemPath) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemPath::max(self : PhysicsemfemPath) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemPath::to_string(self : PhysicsemfemPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_cluster_make(size : Int) -> PhysicsemfemCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemCluster::len(self : PhysicsemfemCluster) -> Int { self.size }

pub fn PhysicsemfemCluster::get(self : PhysicsemfemCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemCluster::set(self : PhysicsemfemCluster, i : Int, v : Double) -> PhysicsemfemCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemCluster::sum(self : PhysicsemfemCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemCluster::mean(self : PhysicsemfemCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemCluster::scale(self : PhysicsemfemCluster, f : Double) -> PhysicsemfemCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemCluster::add(self : PhysicsemfemCluster, other : PhysicsemfemCluster) -> PhysicsemfemCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemCluster::copy(self : PhysicsemfemCluster) -> PhysicsemfemCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemCluster::fill(self : PhysicsemfemCluster, v : Double) -> PhysicsemfemCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemCluster::min(self : PhysicsemfemCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemCluster::max(self : PhysicsemfemCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemCluster::to_string(self : PhysicsemfemCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_model_make(size : Int) -> PhysicsemfemModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemModel::len(self : PhysicsemfemModel) -> Int { self.size }

pub fn PhysicsemfemModel::get(self : PhysicsemfemModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemModel::set(self : PhysicsemfemModel, i : Int, v : Double) -> PhysicsemfemModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemModel::sum(self : PhysicsemfemModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemModel::mean(self : PhysicsemfemModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemModel::scale(self : PhysicsemfemModel, f : Double) -> PhysicsemfemModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemModel::add(self : PhysicsemfemModel, other : PhysicsemfemModel) -> PhysicsemfemModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemModel::copy(self : PhysicsemfemModel) -> PhysicsemfemModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemModel::fill(self : PhysicsemfemModel, v : Double) -> PhysicsemfemModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemModel::min(self : PhysicsemfemModel) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemModel::max(self : PhysicsemfemModel) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemModel::to_string(self : PhysicsemfemModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_layer_make(size : Int) -> PhysicsemfemLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemLayer::len(self : PhysicsemfemLayer) -> Int { self.size }

pub fn PhysicsemfemLayer::get(self : PhysicsemfemLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemLayer::set(self : PhysicsemfemLayer, i : Int, v : Double) -> PhysicsemfemLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemLayer::sum(self : PhysicsemfemLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemLayer::mean(self : PhysicsemfemLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemLayer::scale(self : PhysicsemfemLayer, f : Double) -> PhysicsemfemLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemLayer::add(self : PhysicsemfemLayer, other : PhysicsemfemLayer) -> PhysicsemfemLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemLayer::copy(self : PhysicsemfemLayer) -> PhysicsemfemLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemLayer::fill(self : PhysicsemfemLayer, v : Double) -> PhysicsemfemLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemLayer::min(self : PhysicsemfemLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemLayer::max(self : PhysicsemfemLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemLayer::to_string(self : PhysicsemfemLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_buffer_make(size : Int) -> PhysicsemfemBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemBuffer::len(self : PhysicsemfemBuffer) -> Int { self.size }

pub fn PhysicsemfemBuffer::get(self : PhysicsemfemBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemBuffer::set(self : PhysicsemfemBuffer, i : Int, v : Double) -> PhysicsemfemBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemBuffer::sum(self : PhysicsemfemBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemBuffer::mean(self : PhysicsemfemBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemBuffer::scale(self : PhysicsemfemBuffer, f : Double) -> PhysicsemfemBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemBuffer::add(self : PhysicsemfemBuffer, other : PhysicsemfemBuffer) -> PhysicsemfemBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemBuffer::copy(self : PhysicsemfemBuffer) -> PhysicsemfemBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemBuffer::fill(self : PhysicsemfemBuffer, v : Double) -> PhysicsemfemBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemBuffer::min(self : PhysicsemfemBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemBuffer::max(self : PhysicsemfemBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemBuffer::to_string(self : PhysicsemfemBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_cursor_make(size : Int) -> PhysicsemfemCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemCursor::len(self : PhysicsemfemCursor) -> Int { self.size }

pub fn PhysicsemfemCursor::get(self : PhysicsemfemCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemCursor::set(self : PhysicsemfemCursor, i : Int, v : Double) -> PhysicsemfemCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemCursor::sum(self : PhysicsemfemCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemCursor::mean(self : PhysicsemfemCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemCursor::scale(self : PhysicsemfemCursor, f : Double) -> PhysicsemfemCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemCursor::add(self : PhysicsemfemCursor, other : PhysicsemfemCursor) -> PhysicsemfemCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemCursor::copy(self : PhysicsemfemCursor) -> PhysicsemfemCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemCursor::fill(self : PhysicsemfemCursor, v : Double) -> PhysicsemfemCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemCursor::min(self : PhysicsemfemCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemCursor::max(self : PhysicsemfemCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemCursor::to_string(self : PhysicsemfemCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_view_make(size : Int) -> PhysicsemfemView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemView::len(self : PhysicsemfemView) -> Int { self.size }

pub fn PhysicsemfemView::get(self : PhysicsemfemView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemView::set(self : PhysicsemfemView, i : Int, v : Double) -> PhysicsemfemView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemView::sum(self : PhysicsemfemView) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemView::mean(self : PhysicsemfemView) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemView::scale(self : PhysicsemfemView, f : Double) -> PhysicsemfemView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemView::add(self : PhysicsemfemView, other : PhysicsemfemView) -> PhysicsemfemView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemView::copy(self : PhysicsemfemView) -> PhysicsemfemView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemView::fill(self : PhysicsemfemView, v : Double) -> PhysicsemfemView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemView::min(self : PhysicsemfemView) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemView::max(self : PhysicsemfemView) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemView::to_string(self : PhysicsemfemView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_range_make(size : Int) -> PhysicsemfemRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemRange::len(self : PhysicsemfemRange) -> Int { self.size }

pub fn PhysicsemfemRange::get(self : PhysicsemfemRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemRange::set(self : PhysicsemfemRange, i : Int, v : Double) -> PhysicsemfemRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemRange::sum(self : PhysicsemfemRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemRange::mean(self : PhysicsemfemRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemRange::scale(self : PhysicsemfemRange, f : Double) -> PhysicsemfemRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemRange::add(self : PhysicsemfemRange, other : PhysicsemfemRange) -> PhysicsemfemRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemRange::copy(self : PhysicsemfemRange) -> PhysicsemfemRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemRange::fill(self : PhysicsemfemRange, v : Double) -> PhysicsemfemRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemRange::min(self : PhysicsemfemRange) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemRange::max(self : PhysicsemfemRange) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemRange::to_string(self : PhysicsemfemRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_slice_make(size : Int) -> PhysicsemfemSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfemSlice::len(self : PhysicsemfemSlice) -> Int { self.size }

pub fn PhysicsemfemSlice::get(self : PhysicsemfemSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfemSlice::set(self : PhysicsemfemSlice, i : Int, v : Double) -> PhysicsemfemSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfemSlice::sum(self : PhysicsemfemSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfemSlice::mean(self : PhysicsemfemSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfemSlice::scale(self : PhysicsemfemSlice, f : Double) -> PhysicsemfemSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemSlice::add(self : PhysicsemfemSlice, other : PhysicsemfemSlice) -> PhysicsemfemSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfemSlice::copy(self : PhysicsemfemSlice) -> PhysicsemfemSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemSlice::fill(self : PhysicsemfemSlice, v : Double) -> PhysicsemfemSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfemSlice::min(self : PhysicsemfemSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsemfemSlice::max(self : PhysicsemfemSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsemfemSlice::to_string(self : PhysicsemfemSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

