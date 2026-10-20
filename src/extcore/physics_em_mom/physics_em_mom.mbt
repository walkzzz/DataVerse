///===
/// extcore/physics_em_mom

pub(all) struct PhysicsemmomPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_mom_make_point(x : Double, y : Double) -> PhysicsemmomPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_mom_make_point3(x : Double, y : Double, z : Double) -> PhysicsemmomPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemmomPoint::x(self : PhysicsemmomPoint) -> Double { self.x }

pub fn PhysicsemmomPoint::y(self : PhysicsemmomPoint) -> Double { self.y }

pub fn PhysicsemmomPoint::z(self : PhysicsemmomPoint) -> Double { self.z }

pub fn PhysicsemmomPoint::label(self : PhysicsemmomPoint) -> Int { self.label }

pub fn PhysicsemmomPoint::dist(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemmomPoint::add(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemmomPoint::sub(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemmomPoint::scale(self : PhysicsemmomPoint, s : Double) -> PhysicsemmomPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemmomPoint::dot(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemmomPoint::cross(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemmomPoint::norm(self : PhysicsemmomPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemmomPoint::normalize(self : PhysicsemmomPoint) -> PhysicsemmomPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemmomPoint::negate(self : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemmomPoint::mid(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemmomPoint::lerp(self : PhysicsemmomPoint, other : PhysicsemmomPoint, t : Double) -> PhysicsemmomPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemmomPoint::to_string(self : PhysicsemmomPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemmomSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_mom_make_series(vals : Array[Double], name : String) -> PhysicsemmomSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemmomSeries::len(self : PhysicsemmomSeries) -> Int { self.vals.length() }

pub fn PhysicsemmomSeries::sum(self : PhysicsemmomSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemmomSeries::mean(self : PhysicsemmomSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemmomSeries::min(self : PhysicsemmomSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemmomSeries::max(self : PhysicsemmomSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemmomSeries::range(self : PhysicsemmomSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemmomSeries::variance(self : PhysicsemmomSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemmomSeries::std(self : PhysicsemmomSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemmomSeries::median(self : PhysicsemmomSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemmomSeries::scale(self : PhysicsemmomSeries, f : Double) -> PhysicsemmomSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemmomSeries::add(self : PhysicsemmomSeries, other : PhysicsemmomSeries) -> PhysicsemmomSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemmomSeries::sub(self : PhysicsemmomSeries, other : PhysicsemmomSeries) -> PhysicsemmomSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemmomSeries::normalize(self : PhysicsemmomSeries) -> PhysicsemmomSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemmomSeries::cumsum(self : PhysicsemmomSeries) -> PhysicsemmomSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemmomSeries::to_string(self : PhysicsemmomSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemmomMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_mom_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemmomMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_mom_matrix_identity(n : Int) -> PhysicsemmomMatrix {
  let m = physics_em_mom_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemmomMatrix::get(self : PhysicsemmomMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemmomMatrix::transpose(self : PhysicsemmomMatrix) -> PhysicsemmomMatrix {
  let result = physics_em_mom_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemmomMatrix::add(self : PhysicsemmomMatrix, other : PhysicsemmomMatrix) -> PhysicsemmomMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_mom_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemmomMatrix::scale(self : PhysicsemmomMatrix, s : Double) -> PhysicsemmomMatrix {
  let result = physics_em_mom_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemmomMatrix::multiply(self : PhysicsemmomMatrix, other : PhysicsemmomMatrix) -> PhysicsemmomMatrix {
  if self.cols != other.rows { return physics_em_mom_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_mom_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsemmomMatrix::trace(self : PhysicsemmomMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemmomMatrix::det(self : PhysicsemmomMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemmomMatrix::norm(self : PhysicsemmomMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemmomMatrix::to_string(self : PhysicsemmomMatrix) -> String {
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

pub(all) struct PhysicsemmomVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_mom_make_vector(comps : Array[Double]) -> PhysicsemmomVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_mom_vector_zero(dim : Int) -> PhysicsemmomVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemmomVector::add(self : PhysicsemmomVector, other : PhysicsemmomVector) -> PhysicsemmomVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemmomVector::sub(self : PhysicsemmomVector, other : PhysicsemmomVector) -> PhysicsemmomVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemmomVector::scale(self : PhysicsemmomVector, s : Double) -> PhysicsemmomVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemmomVector::dot(self : PhysicsemmomVector, other : PhysicsemmomVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemmomVector::norm(self : PhysicsemmomVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemmomVector::normalize(self : PhysicsemmomVector) -> PhysicsemmomVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemmomVector::dist(self : PhysicsemmomVector, other : PhysicsemmomVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemmomVector::to_string(self : PhysicsemmomVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemmomFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_frame_make(size : Int) -> PhysicsemmomFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomFrame::len(self : PhysicsemmomFrame) -> Int { self.size }

pub fn PhysicsemmomFrame::get(self : PhysicsemmomFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomFrame::set(self : PhysicsemmomFrame, i : Int, v : Double) -> PhysicsemmomFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomFrame::sum(self : PhysicsemmomFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomFrame::mean(self : PhysicsemmomFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomFrame::scale(self : PhysicsemmomFrame, f : Double) -> PhysicsemmomFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomFrame::add(self : PhysicsemmomFrame, other : PhysicsemmomFrame) -> PhysicsemmomFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomFrame::copy(self : PhysicsemmomFrame) -> PhysicsemmomFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomFrame::fill(self : PhysicsemmomFrame, v : Double) -> PhysicsemmomFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomFrame::min(self : PhysicsemmomFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomFrame::max(self : PhysicsemmomFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomFrame::to_string(self : PhysicsemmomFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_table_make(size : Int) -> PhysicsemmomTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomTable::len(self : PhysicsemmomTable) -> Int { self.size }

pub fn PhysicsemmomTable::get(self : PhysicsemmomTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomTable::set(self : PhysicsemmomTable, i : Int, v : Double) -> PhysicsemmomTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomTable::sum(self : PhysicsemmomTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomTable::mean(self : PhysicsemmomTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomTable::scale(self : PhysicsemmomTable, f : Double) -> PhysicsemmomTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomTable::add(self : PhysicsemmomTable, other : PhysicsemmomTable) -> PhysicsemmomTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomTable::copy(self : PhysicsemmomTable) -> PhysicsemmomTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomTable::fill(self : PhysicsemmomTable, v : Double) -> PhysicsemmomTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomTable::min(self : PhysicsemmomTable) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomTable::max(self : PhysicsemmomTable) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomTable::to_string(self : PhysicsemmomTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_graphn_make(size : Int) -> PhysicsemmomGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomGraphN::len(self : PhysicsemmomGraphN) -> Int { self.size }

pub fn PhysicsemmomGraphN::get(self : PhysicsemmomGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomGraphN::set(self : PhysicsemmomGraphN, i : Int, v : Double) -> PhysicsemmomGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomGraphN::sum(self : PhysicsemmomGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomGraphN::mean(self : PhysicsemmomGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomGraphN::scale(self : PhysicsemmomGraphN, f : Double) -> PhysicsemmomGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomGraphN::add(self : PhysicsemmomGraphN, other : PhysicsemmomGraphN) -> PhysicsemmomGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomGraphN::copy(self : PhysicsemmomGraphN) -> PhysicsemmomGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomGraphN::fill(self : PhysicsemmomGraphN, v : Double) -> PhysicsemmomGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomGraphN::min(self : PhysicsemmomGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomGraphN::max(self : PhysicsemmomGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomGraphN::to_string(self : PhysicsemmomGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_node_make(size : Int) -> PhysicsemmomNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomNode::len(self : PhysicsemmomNode) -> Int { self.size }

pub fn PhysicsemmomNode::get(self : PhysicsemmomNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomNode::set(self : PhysicsemmomNode, i : Int, v : Double) -> PhysicsemmomNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomNode::sum(self : PhysicsemmomNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomNode::mean(self : PhysicsemmomNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomNode::scale(self : PhysicsemmomNode, f : Double) -> PhysicsemmomNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomNode::add(self : PhysicsemmomNode, other : PhysicsemmomNode) -> PhysicsemmomNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomNode::copy(self : PhysicsemmomNode) -> PhysicsemmomNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomNode::fill(self : PhysicsemmomNode, v : Double) -> PhysicsemmomNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomNode::min(self : PhysicsemmomNode) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomNode::max(self : PhysicsemmomNode) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomNode::to_string(self : PhysicsemmomNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_edge_make(size : Int) -> PhysicsemmomEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomEdge::len(self : PhysicsemmomEdge) -> Int { self.size }

pub fn PhysicsemmomEdge::get(self : PhysicsemmomEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomEdge::set(self : PhysicsemmomEdge, i : Int, v : Double) -> PhysicsemmomEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomEdge::sum(self : PhysicsemmomEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomEdge::mean(self : PhysicsemmomEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomEdge::scale(self : PhysicsemmomEdge, f : Double) -> PhysicsemmomEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomEdge::add(self : PhysicsemmomEdge, other : PhysicsemmomEdge) -> PhysicsemmomEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomEdge::copy(self : PhysicsemmomEdge) -> PhysicsemmomEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomEdge::fill(self : PhysicsemmomEdge, v : Double) -> PhysicsemmomEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomEdge::min(self : PhysicsemmomEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomEdge::max(self : PhysicsemmomEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomEdge::to_string(self : PhysicsemmomEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_path_make(size : Int) -> PhysicsemmomPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomPath::len(self : PhysicsemmomPath) -> Int { self.size }

pub fn PhysicsemmomPath::get(self : PhysicsemmomPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomPath::set(self : PhysicsemmomPath, i : Int, v : Double) -> PhysicsemmomPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomPath::sum(self : PhysicsemmomPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomPath::mean(self : PhysicsemmomPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomPath::scale(self : PhysicsemmomPath, f : Double) -> PhysicsemmomPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomPath::add(self : PhysicsemmomPath, other : PhysicsemmomPath) -> PhysicsemmomPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomPath::copy(self : PhysicsemmomPath) -> PhysicsemmomPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomPath::fill(self : PhysicsemmomPath, v : Double) -> PhysicsemmomPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomPath::min(self : PhysicsemmomPath) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomPath::max(self : PhysicsemmomPath) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomPath::to_string(self : PhysicsemmomPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_cluster_make(size : Int) -> PhysicsemmomCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomCluster::len(self : PhysicsemmomCluster) -> Int { self.size }

pub fn PhysicsemmomCluster::get(self : PhysicsemmomCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomCluster::set(self : PhysicsemmomCluster, i : Int, v : Double) -> PhysicsemmomCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomCluster::sum(self : PhysicsemmomCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomCluster::mean(self : PhysicsemmomCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomCluster::scale(self : PhysicsemmomCluster, f : Double) -> PhysicsemmomCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomCluster::add(self : PhysicsemmomCluster, other : PhysicsemmomCluster) -> PhysicsemmomCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomCluster::copy(self : PhysicsemmomCluster) -> PhysicsemmomCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomCluster::fill(self : PhysicsemmomCluster, v : Double) -> PhysicsemmomCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomCluster::min(self : PhysicsemmomCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomCluster::max(self : PhysicsemmomCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomCluster::to_string(self : PhysicsemmomCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_model_make(size : Int) -> PhysicsemmomModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomModel::len(self : PhysicsemmomModel) -> Int { self.size }

pub fn PhysicsemmomModel::get(self : PhysicsemmomModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomModel::set(self : PhysicsemmomModel, i : Int, v : Double) -> PhysicsemmomModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomModel::sum(self : PhysicsemmomModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomModel::mean(self : PhysicsemmomModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomModel::scale(self : PhysicsemmomModel, f : Double) -> PhysicsemmomModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomModel::add(self : PhysicsemmomModel, other : PhysicsemmomModel) -> PhysicsemmomModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomModel::copy(self : PhysicsemmomModel) -> PhysicsemmomModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomModel::fill(self : PhysicsemmomModel, v : Double) -> PhysicsemmomModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomModel::min(self : PhysicsemmomModel) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomModel::max(self : PhysicsemmomModel) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomModel::to_string(self : PhysicsemmomModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_layer_make(size : Int) -> PhysicsemmomLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomLayer::len(self : PhysicsemmomLayer) -> Int { self.size }

pub fn PhysicsemmomLayer::get(self : PhysicsemmomLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomLayer::set(self : PhysicsemmomLayer, i : Int, v : Double) -> PhysicsemmomLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomLayer::sum(self : PhysicsemmomLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomLayer::mean(self : PhysicsemmomLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomLayer::scale(self : PhysicsemmomLayer, f : Double) -> PhysicsemmomLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomLayer::add(self : PhysicsemmomLayer, other : PhysicsemmomLayer) -> PhysicsemmomLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomLayer::copy(self : PhysicsemmomLayer) -> PhysicsemmomLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomLayer::fill(self : PhysicsemmomLayer, v : Double) -> PhysicsemmomLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomLayer::min(self : PhysicsemmomLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomLayer::max(self : PhysicsemmomLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomLayer::to_string(self : PhysicsemmomLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_buffer_make(size : Int) -> PhysicsemmomBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomBuffer::len(self : PhysicsemmomBuffer) -> Int { self.size }

pub fn PhysicsemmomBuffer::get(self : PhysicsemmomBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomBuffer::set(self : PhysicsemmomBuffer, i : Int, v : Double) -> PhysicsemmomBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomBuffer::sum(self : PhysicsemmomBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomBuffer::mean(self : PhysicsemmomBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomBuffer::scale(self : PhysicsemmomBuffer, f : Double) -> PhysicsemmomBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomBuffer::add(self : PhysicsemmomBuffer, other : PhysicsemmomBuffer) -> PhysicsemmomBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomBuffer::copy(self : PhysicsemmomBuffer) -> PhysicsemmomBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomBuffer::fill(self : PhysicsemmomBuffer, v : Double) -> PhysicsemmomBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomBuffer::min(self : PhysicsemmomBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomBuffer::max(self : PhysicsemmomBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomBuffer::to_string(self : PhysicsemmomBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_cursor_make(size : Int) -> PhysicsemmomCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomCursor::len(self : PhysicsemmomCursor) -> Int { self.size }

pub fn PhysicsemmomCursor::get(self : PhysicsemmomCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomCursor::set(self : PhysicsemmomCursor, i : Int, v : Double) -> PhysicsemmomCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomCursor::sum(self : PhysicsemmomCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomCursor::mean(self : PhysicsemmomCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomCursor::scale(self : PhysicsemmomCursor, f : Double) -> PhysicsemmomCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomCursor::add(self : PhysicsemmomCursor, other : PhysicsemmomCursor) -> PhysicsemmomCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomCursor::copy(self : PhysicsemmomCursor) -> PhysicsemmomCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomCursor::fill(self : PhysicsemmomCursor, v : Double) -> PhysicsemmomCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomCursor::min(self : PhysicsemmomCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomCursor::max(self : PhysicsemmomCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomCursor::to_string(self : PhysicsemmomCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_view_make(size : Int) -> PhysicsemmomView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomView::len(self : PhysicsemmomView) -> Int { self.size }

pub fn PhysicsemmomView::get(self : PhysicsemmomView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomView::set(self : PhysicsemmomView, i : Int, v : Double) -> PhysicsemmomView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomView::sum(self : PhysicsemmomView) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomView::mean(self : PhysicsemmomView) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomView::scale(self : PhysicsemmomView, f : Double) -> PhysicsemmomView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomView::add(self : PhysicsemmomView, other : PhysicsemmomView) -> PhysicsemmomView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomView::copy(self : PhysicsemmomView) -> PhysicsemmomView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomView::fill(self : PhysicsemmomView, v : Double) -> PhysicsemmomView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomView::min(self : PhysicsemmomView) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomView::max(self : PhysicsemmomView) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomView::to_string(self : PhysicsemmomView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_range_make(size : Int) -> PhysicsemmomRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomRange::len(self : PhysicsemmomRange) -> Int { self.size }

pub fn PhysicsemmomRange::get(self : PhysicsemmomRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomRange::set(self : PhysicsemmomRange, i : Int, v : Double) -> PhysicsemmomRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomRange::sum(self : PhysicsemmomRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomRange::mean(self : PhysicsemmomRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomRange::scale(self : PhysicsemmomRange, f : Double) -> PhysicsemmomRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomRange::add(self : PhysicsemmomRange, other : PhysicsemmomRange) -> PhysicsemmomRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomRange::copy(self : PhysicsemmomRange) -> PhysicsemmomRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomRange::fill(self : PhysicsemmomRange, v : Double) -> PhysicsemmomRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomRange::min(self : PhysicsemmomRange) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomRange::max(self : PhysicsemmomRange) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomRange::to_string(self : PhysicsemmomRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_slice_make(size : Int) -> PhysicsemmomSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmomSlice::len(self : PhysicsemmomSlice) -> Int { self.size }

pub fn PhysicsemmomSlice::get(self : PhysicsemmomSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmomSlice::set(self : PhysicsemmomSlice, i : Int, v : Double) -> PhysicsemmomSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmomSlice::sum(self : PhysicsemmomSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmomSlice::mean(self : PhysicsemmomSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmomSlice::scale(self : PhysicsemmomSlice, f : Double) -> PhysicsemmomSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomSlice::add(self : PhysicsemmomSlice, other : PhysicsemmomSlice) -> PhysicsemmomSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmomSlice::copy(self : PhysicsemmomSlice) -> PhysicsemmomSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomSlice::fill(self : PhysicsemmomSlice, v : Double) -> PhysicsemmomSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmomSlice::min(self : PhysicsemmomSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsemmomSlice::max(self : PhysicsemmomSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsemmomSlice::to_string(self : PhysicsemmomSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

