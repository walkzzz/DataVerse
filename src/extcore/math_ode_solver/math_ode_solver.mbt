///===
/// extcore/math_ode_solver

pub(all) struct MathodesolverPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_ode_solver_make_point(x : Double, y : Double) -> MathodesolverPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_ode_solver_make_point3(x : Double, y : Double, z : Double) -> MathodesolverPoint {
  { x, y, z, label: 0 }
}

pub fn MathodesolverPoint::x(self : MathodesolverPoint) -> Double { self.x }

pub fn MathodesolverPoint::y(self : MathodesolverPoint) -> Double { self.y }

pub fn MathodesolverPoint::z(self : MathodesolverPoint) -> Double { self.z }

pub fn MathodesolverPoint::label(self : MathodesolverPoint) -> Int { self.label }

pub fn MathodesolverPoint::dist(self : MathodesolverPoint, other : MathodesolverPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathodesolverPoint::add(self : MathodesolverPoint, other : MathodesolverPoint) -> MathodesolverPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathodesolverPoint::sub(self : MathodesolverPoint, other : MathodesolverPoint) -> MathodesolverPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathodesolverPoint::scale(self : MathodesolverPoint, s : Double) -> MathodesolverPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathodesolverPoint::dot(self : MathodesolverPoint, other : MathodesolverPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathodesolverPoint::cross(self : MathodesolverPoint, other : MathodesolverPoint) -> MathodesolverPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathodesolverPoint::norm(self : MathodesolverPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathodesolverPoint::normalize(self : MathodesolverPoint) -> MathodesolverPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathodesolverPoint::negate(self : MathodesolverPoint) -> MathodesolverPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathodesolverPoint::mid(self : MathodesolverPoint, other : MathodesolverPoint) -> MathodesolverPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathodesolverPoint::lerp(self : MathodesolverPoint, other : MathodesolverPoint, t : Double) -> MathodesolverPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathodesolverPoint::to_string(self : MathodesolverPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathodesolverSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_ode_solver_make_series(vals : Array[Double], name : String) -> MathodesolverSeries {
  { vals, name, meta: 0 }
}

pub fn MathodesolverSeries::len(self : MathodesolverSeries) -> Int { self.vals.length() }

pub fn MathodesolverSeries::sum(self : MathodesolverSeries) -> Double { @_common.sum(self.vals) }

pub fn MathodesolverSeries::mean(self : MathodesolverSeries) -> Double { @_common.mean(self.vals) }

pub fn MathodesolverSeries::min(self : MathodesolverSeries) -> Double { @_common.min(self.vals) }

pub fn MathodesolverSeries::max(self : MathodesolverSeries) -> Double { @_common.max(self.vals) }

pub fn MathodesolverSeries::range(self : MathodesolverSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathodesolverSeries::variance(self : MathodesolverSeries) -> Double { @_common.variance(self.vals) }

pub fn MathodesolverSeries::std(self : MathodesolverSeries) -> Double { @_common.std(self.vals) }

pub fn MathodesolverSeries::median(self : MathodesolverSeries) -> Double { @_common.median(self.vals) }

pub fn MathodesolverSeries::scale(self : MathodesolverSeries, f : Double) -> MathodesolverSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathodesolverSeries::add(self : MathodesolverSeries, other : MathodesolverSeries) -> MathodesolverSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathodesolverSeries::sub(self : MathodesolverSeries, other : MathodesolverSeries) -> MathodesolverSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathodesolverSeries::normalize(self : MathodesolverSeries) -> MathodesolverSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathodesolverSeries::cumsum(self : MathodesolverSeries) -> MathodesolverSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathodesolverSeries::to_string(self : MathodesolverSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathodesolverMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_ode_solver_make_matrix(rows : Int, cols : Int, val : Double) -> MathodesolverMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_ode_solver_matrix_identity(n : Int) -> MathodesolverMatrix {
  let m = math_ode_solver_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathodesolverMatrix::get(self : MathodesolverMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathodesolverMatrix::transpose(self : MathodesolverMatrix) -> MathodesolverMatrix {
  let result = math_ode_solver_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathodesolverMatrix::add(self : MathodesolverMatrix, other : MathodesolverMatrix) -> MathodesolverMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_ode_solver_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathodesolverMatrix::scale(self : MathodesolverMatrix, s : Double) -> MathodesolverMatrix {
  let result = math_ode_solver_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathodesolverMatrix::multiply(self : MathodesolverMatrix, other : MathodesolverMatrix) -> MathodesolverMatrix {
  if self.cols != other.rows { return math_ode_solver_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_ode_solver_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathodesolverMatrix::trace(self : MathodesolverMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathodesolverMatrix::det(self : MathodesolverMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathodesolverMatrix::norm(self : MathodesolverMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathodesolverMatrix::to_string(self : MathodesolverMatrix) -> String {
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

pub(all) struct MathodesolverVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_ode_solver_make_vector(comps : Array[Double]) -> MathodesolverVector {
  { comps, dim: comps.length() }
}

pub fn math_ode_solver_vector_zero(dim : Int) -> MathodesolverVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathodesolverVector::add(self : MathodesolverVector, other : MathodesolverVector) -> MathodesolverVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathodesolverVector::sub(self : MathodesolverVector, other : MathodesolverVector) -> MathodesolverVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathodesolverVector::scale(self : MathodesolverVector, s : Double) -> MathodesolverVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathodesolverVector::dot(self : MathodesolverVector, other : MathodesolverVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathodesolverVector::norm(self : MathodesolverVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathodesolverVector::normalize(self : MathodesolverVector) -> MathodesolverVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathodesolverVector::dist(self : MathodesolverVector, other : MathodesolverVector) -> Double {
  self.sub(other).norm()
}

pub fn MathodesolverVector::to_string(self : MathodesolverVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathodesolverFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_frame_make(size : Int) -> MathodesolverFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverFrame::len(self : MathodesolverFrame) -> Int { self.size }

pub fn MathodesolverFrame::get(self : MathodesolverFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverFrame::set(self : MathodesolverFrame, i : Int, v : Double) -> MathodesolverFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverFrame::sum(self : MathodesolverFrame) -> Double { @_common.sum(self.data) }

pub fn MathodesolverFrame::mean(self : MathodesolverFrame) -> Double { @_common.mean(self.data) }

pub fn MathodesolverFrame::scale(self : MathodesolverFrame, f : Double) -> MathodesolverFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverFrame::add(self : MathodesolverFrame, other : MathodesolverFrame) -> MathodesolverFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverFrame::copy(self : MathodesolverFrame) -> MathodesolverFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverFrame::fill(self : MathodesolverFrame, v : Double) -> MathodesolverFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverFrame::min(self : MathodesolverFrame) -> Double { @_common.min(self.data) }

pub fn MathodesolverFrame::max(self : MathodesolverFrame) -> Double { @_common.max(self.data) }

pub fn MathodesolverFrame::to_string(self : MathodesolverFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_table_make(size : Int) -> MathodesolverTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverTable::len(self : MathodesolverTable) -> Int { self.size }

pub fn MathodesolverTable::get(self : MathodesolverTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverTable::set(self : MathodesolverTable, i : Int, v : Double) -> MathodesolverTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverTable::sum(self : MathodesolverTable) -> Double { @_common.sum(self.data) }

pub fn MathodesolverTable::mean(self : MathodesolverTable) -> Double { @_common.mean(self.data) }

pub fn MathodesolverTable::scale(self : MathodesolverTable, f : Double) -> MathodesolverTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverTable::add(self : MathodesolverTable, other : MathodesolverTable) -> MathodesolverTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverTable::copy(self : MathodesolverTable) -> MathodesolverTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverTable::fill(self : MathodesolverTable, v : Double) -> MathodesolverTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverTable::min(self : MathodesolverTable) -> Double { @_common.min(self.data) }

pub fn MathodesolverTable::max(self : MathodesolverTable) -> Double { @_common.max(self.data) }

pub fn MathodesolverTable::to_string(self : MathodesolverTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_graphn_make(size : Int) -> MathodesolverGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverGraphN::len(self : MathodesolverGraphN) -> Int { self.size }

pub fn MathodesolverGraphN::get(self : MathodesolverGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverGraphN::set(self : MathodesolverGraphN, i : Int, v : Double) -> MathodesolverGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverGraphN::sum(self : MathodesolverGraphN) -> Double { @_common.sum(self.data) }

pub fn MathodesolverGraphN::mean(self : MathodesolverGraphN) -> Double { @_common.mean(self.data) }

pub fn MathodesolverGraphN::scale(self : MathodesolverGraphN, f : Double) -> MathodesolverGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverGraphN::add(self : MathodesolverGraphN, other : MathodesolverGraphN) -> MathodesolverGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverGraphN::copy(self : MathodesolverGraphN) -> MathodesolverGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverGraphN::fill(self : MathodesolverGraphN, v : Double) -> MathodesolverGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverGraphN::min(self : MathodesolverGraphN) -> Double { @_common.min(self.data) }

pub fn MathodesolverGraphN::max(self : MathodesolverGraphN) -> Double { @_common.max(self.data) }

pub fn MathodesolverGraphN::to_string(self : MathodesolverGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_node_make(size : Int) -> MathodesolverNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverNode::len(self : MathodesolverNode) -> Int { self.size }

pub fn MathodesolverNode::get(self : MathodesolverNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverNode::set(self : MathodesolverNode, i : Int, v : Double) -> MathodesolverNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverNode::sum(self : MathodesolverNode) -> Double { @_common.sum(self.data) }

pub fn MathodesolverNode::mean(self : MathodesolverNode) -> Double { @_common.mean(self.data) }

pub fn MathodesolverNode::scale(self : MathodesolverNode, f : Double) -> MathodesolverNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverNode::add(self : MathodesolverNode, other : MathodesolverNode) -> MathodesolverNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverNode::copy(self : MathodesolverNode) -> MathodesolverNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverNode::fill(self : MathodesolverNode, v : Double) -> MathodesolverNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverNode::min(self : MathodesolverNode) -> Double { @_common.min(self.data) }

pub fn MathodesolverNode::max(self : MathodesolverNode) -> Double { @_common.max(self.data) }

pub fn MathodesolverNode::to_string(self : MathodesolverNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_edge_make(size : Int) -> MathodesolverEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverEdge::len(self : MathodesolverEdge) -> Int { self.size }

pub fn MathodesolverEdge::get(self : MathodesolverEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverEdge::set(self : MathodesolverEdge, i : Int, v : Double) -> MathodesolverEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverEdge::sum(self : MathodesolverEdge) -> Double { @_common.sum(self.data) }

pub fn MathodesolverEdge::mean(self : MathodesolverEdge) -> Double { @_common.mean(self.data) }

pub fn MathodesolverEdge::scale(self : MathodesolverEdge, f : Double) -> MathodesolverEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverEdge::add(self : MathodesolverEdge, other : MathodesolverEdge) -> MathodesolverEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverEdge::copy(self : MathodesolverEdge) -> MathodesolverEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverEdge::fill(self : MathodesolverEdge, v : Double) -> MathodesolverEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverEdge::min(self : MathodesolverEdge) -> Double { @_common.min(self.data) }

pub fn MathodesolverEdge::max(self : MathodesolverEdge) -> Double { @_common.max(self.data) }

pub fn MathodesolverEdge::to_string(self : MathodesolverEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_path_make(size : Int) -> MathodesolverPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverPath::len(self : MathodesolverPath) -> Int { self.size }

pub fn MathodesolverPath::get(self : MathodesolverPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverPath::set(self : MathodesolverPath, i : Int, v : Double) -> MathodesolverPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverPath::sum(self : MathodesolverPath) -> Double { @_common.sum(self.data) }

pub fn MathodesolverPath::mean(self : MathodesolverPath) -> Double { @_common.mean(self.data) }

pub fn MathodesolverPath::scale(self : MathodesolverPath, f : Double) -> MathodesolverPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverPath::add(self : MathodesolverPath, other : MathodesolverPath) -> MathodesolverPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverPath::copy(self : MathodesolverPath) -> MathodesolverPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverPath::fill(self : MathodesolverPath, v : Double) -> MathodesolverPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverPath::min(self : MathodesolverPath) -> Double { @_common.min(self.data) }

pub fn MathodesolverPath::max(self : MathodesolverPath) -> Double { @_common.max(self.data) }

pub fn MathodesolverPath::to_string(self : MathodesolverPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_cluster_make(size : Int) -> MathodesolverCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverCluster::len(self : MathodesolverCluster) -> Int { self.size }

pub fn MathodesolverCluster::get(self : MathodesolverCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverCluster::set(self : MathodesolverCluster, i : Int, v : Double) -> MathodesolverCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverCluster::sum(self : MathodesolverCluster) -> Double { @_common.sum(self.data) }

pub fn MathodesolverCluster::mean(self : MathodesolverCluster) -> Double { @_common.mean(self.data) }

pub fn MathodesolverCluster::scale(self : MathodesolverCluster, f : Double) -> MathodesolverCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverCluster::add(self : MathodesolverCluster, other : MathodesolverCluster) -> MathodesolverCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverCluster::copy(self : MathodesolverCluster) -> MathodesolverCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverCluster::fill(self : MathodesolverCluster, v : Double) -> MathodesolverCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverCluster::min(self : MathodesolverCluster) -> Double { @_common.min(self.data) }

pub fn MathodesolverCluster::max(self : MathodesolverCluster) -> Double { @_common.max(self.data) }

pub fn MathodesolverCluster::to_string(self : MathodesolverCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_model_make(size : Int) -> MathodesolverModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverModel::len(self : MathodesolverModel) -> Int { self.size }

pub fn MathodesolverModel::get(self : MathodesolverModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverModel::set(self : MathodesolverModel, i : Int, v : Double) -> MathodesolverModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverModel::sum(self : MathodesolverModel) -> Double { @_common.sum(self.data) }

pub fn MathodesolverModel::mean(self : MathodesolverModel) -> Double { @_common.mean(self.data) }

pub fn MathodesolverModel::scale(self : MathodesolverModel, f : Double) -> MathodesolverModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverModel::add(self : MathodesolverModel, other : MathodesolverModel) -> MathodesolverModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverModel::copy(self : MathodesolverModel) -> MathodesolverModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverModel::fill(self : MathodesolverModel, v : Double) -> MathodesolverModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverModel::min(self : MathodesolverModel) -> Double { @_common.min(self.data) }

pub fn MathodesolverModel::max(self : MathodesolverModel) -> Double { @_common.max(self.data) }

pub fn MathodesolverModel::to_string(self : MathodesolverModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_layer_make(size : Int) -> MathodesolverLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverLayer::len(self : MathodesolverLayer) -> Int { self.size }

pub fn MathodesolverLayer::get(self : MathodesolverLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverLayer::set(self : MathodesolverLayer, i : Int, v : Double) -> MathodesolverLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverLayer::sum(self : MathodesolverLayer) -> Double { @_common.sum(self.data) }

pub fn MathodesolverLayer::mean(self : MathodesolverLayer) -> Double { @_common.mean(self.data) }

pub fn MathodesolverLayer::scale(self : MathodesolverLayer, f : Double) -> MathodesolverLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverLayer::add(self : MathodesolverLayer, other : MathodesolverLayer) -> MathodesolverLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverLayer::copy(self : MathodesolverLayer) -> MathodesolverLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverLayer::fill(self : MathodesolverLayer, v : Double) -> MathodesolverLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverLayer::min(self : MathodesolverLayer) -> Double { @_common.min(self.data) }

pub fn MathodesolverLayer::max(self : MathodesolverLayer) -> Double { @_common.max(self.data) }

pub fn MathodesolverLayer::to_string(self : MathodesolverLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_buffer_make(size : Int) -> MathodesolverBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverBuffer::len(self : MathodesolverBuffer) -> Int { self.size }

pub fn MathodesolverBuffer::get(self : MathodesolverBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverBuffer::set(self : MathodesolverBuffer, i : Int, v : Double) -> MathodesolverBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverBuffer::sum(self : MathodesolverBuffer) -> Double { @_common.sum(self.data) }

pub fn MathodesolverBuffer::mean(self : MathodesolverBuffer) -> Double { @_common.mean(self.data) }

pub fn MathodesolverBuffer::scale(self : MathodesolverBuffer, f : Double) -> MathodesolverBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverBuffer::add(self : MathodesolverBuffer, other : MathodesolverBuffer) -> MathodesolverBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverBuffer::copy(self : MathodesolverBuffer) -> MathodesolverBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverBuffer::fill(self : MathodesolverBuffer, v : Double) -> MathodesolverBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverBuffer::min(self : MathodesolverBuffer) -> Double { @_common.min(self.data) }

pub fn MathodesolverBuffer::max(self : MathodesolverBuffer) -> Double { @_common.max(self.data) }

pub fn MathodesolverBuffer::to_string(self : MathodesolverBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_cursor_make(size : Int) -> MathodesolverCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverCursor::len(self : MathodesolverCursor) -> Int { self.size }

pub fn MathodesolverCursor::get(self : MathodesolverCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverCursor::set(self : MathodesolverCursor, i : Int, v : Double) -> MathodesolverCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverCursor::sum(self : MathodesolverCursor) -> Double { @_common.sum(self.data) }

pub fn MathodesolverCursor::mean(self : MathodesolverCursor) -> Double { @_common.mean(self.data) }

pub fn MathodesolverCursor::scale(self : MathodesolverCursor, f : Double) -> MathodesolverCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverCursor::add(self : MathodesolverCursor, other : MathodesolverCursor) -> MathodesolverCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverCursor::copy(self : MathodesolverCursor) -> MathodesolverCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverCursor::fill(self : MathodesolverCursor, v : Double) -> MathodesolverCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverCursor::min(self : MathodesolverCursor) -> Double { @_common.min(self.data) }

pub fn MathodesolverCursor::max(self : MathodesolverCursor) -> Double { @_common.max(self.data) }

pub fn MathodesolverCursor::to_string(self : MathodesolverCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_view_make(size : Int) -> MathodesolverView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverView::len(self : MathodesolverView) -> Int { self.size }

pub fn MathodesolverView::get(self : MathodesolverView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverView::set(self : MathodesolverView, i : Int, v : Double) -> MathodesolverView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverView::sum(self : MathodesolverView) -> Double { @_common.sum(self.data) }

pub fn MathodesolverView::mean(self : MathodesolverView) -> Double { @_common.mean(self.data) }

pub fn MathodesolverView::scale(self : MathodesolverView, f : Double) -> MathodesolverView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverView::add(self : MathodesolverView, other : MathodesolverView) -> MathodesolverView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverView::copy(self : MathodesolverView) -> MathodesolverView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverView::fill(self : MathodesolverView, v : Double) -> MathodesolverView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverView::min(self : MathodesolverView) -> Double { @_common.min(self.data) }

pub fn MathodesolverView::max(self : MathodesolverView) -> Double { @_common.max(self.data) }

pub fn MathodesolverView::to_string(self : MathodesolverView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_range_make(size : Int) -> MathodesolverRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverRange::len(self : MathodesolverRange) -> Int { self.size }

pub fn MathodesolverRange::get(self : MathodesolverRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverRange::set(self : MathodesolverRange, i : Int, v : Double) -> MathodesolverRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverRange::sum(self : MathodesolverRange) -> Double { @_common.sum(self.data) }

pub fn MathodesolverRange::mean(self : MathodesolverRange) -> Double { @_common.mean(self.data) }

pub fn MathodesolverRange::scale(self : MathodesolverRange, f : Double) -> MathodesolverRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverRange::add(self : MathodesolverRange, other : MathodesolverRange) -> MathodesolverRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverRange::copy(self : MathodesolverRange) -> MathodesolverRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverRange::fill(self : MathodesolverRange, v : Double) -> MathodesolverRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverRange::min(self : MathodesolverRange) -> Double { @_common.min(self.data) }

pub fn MathodesolverRange::max(self : MathodesolverRange) -> Double { @_common.max(self.data) }

pub fn MathodesolverRange::to_string(self : MathodesolverRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathodesolverSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_ode_solver_slice_make(size : Int) -> MathodesolverSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathodesolverSlice::len(self : MathodesolverSlice) -> Int { self.size }

pub fn MathodesolverSlice::get(self : MathodesolverSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathodesolverSlice::set(self : MathodesolverSlice, i : Int, v : Double) -> MathodesolverSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathodesolverSlice::sum(self : MathodesolverSlice) -> Double { @_common.sum(self.data) }

pub fn MathodesolverSlice::mean(self : MathodesolverSlice) -> Double { @_common.mean(self.data) }

pub fn MathodesolverSlice::scale(self : MathodesolverSlice, f : Double) -> MathodesolverSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathodesolverSlice::add(self : MathodesolverSlice, other : MathodesolverSlice) -> MathodesolverSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathodesolverSlice::copy(self : MathodesolverSlice) -> MathodesolverSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathodesolverSlice::fill(self : MathodesolverSlice, v : Double) -> MathodesolverSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathodesolverSlice::min(self : MathodesolverSlice) -> Double { @_common.min(self.data) }

pub fn MathodesolverSlice::max(self : MathodesolverSlice) -> Double { @_common.max(self.data) }

pub fn MathodesolverSlice::to_string(self : MathodesolverSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

