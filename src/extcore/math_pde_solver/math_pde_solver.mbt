///===
/// extcore/math_pde_solver

pub(all) struct MathpdesolverPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_pde_solver_make_point(x : Double, y : Double) -> MathpdesolverPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_pde_solver_make_point3(x : Double, y : Double, z : Double) -> MathpdesolverPoint {
  { x, y, z, label: 0 }
}

pub fn MathpdesolverPoint::x(self : MathpdesolverPoint) -> Double { self.x }

pub fn MathpdesolverPoint::y(self : MathpdesolverPoint) -> Double { self.y }

pub fn MathpdesolverPoint::z(self : MathpdesolverPoint) -> Double { self.z }

pub fn MathpdesolverPoint::label(self : MathpdesolverPoint) -> Int { self.label }

pub fn MathpdesolverPoint::dist(self : MathpdesolverPoint, other : MathpdesolverPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathpdesolverPoint::add(self : MathpdesolverPoint, other : MathpdesolverPoint) -> MathpdesolverPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathpdesolverPoint::sub(self : MathpdesolverPoint, other : MathpdesolverPoint) -> MathpdesolverPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathpdesolverPoint::scale(self : MathpdesolverPoint, s : Double) -> MathpdesolverPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathpdesolverPoint::dot(self : MathpdesolverPoint, other : MathpdesolverPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathpdesolverPoint::cross(self : MathpdesolverPoint, other : MathpdesolverPoint) -> MathpdesolverPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathpdesolverPoint::norm(self : MathpdesolverPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathpdesolverPoint::normalize(self : MathpdesolverPoint) -> MathpdesolverPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathpdesolverPoint::negate(self : MathpdesolverPoint) -> MathpdesolverPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathpdesolverPoint::mid(self : MathpdesolverPoint, other : MathpdesolverPoint) -> MathpdesolverPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathpdesolverPoint::lerp(self : MathpdesolverPoint, other : MathpdesolverPoint, t : Double) -> MathpdesolverPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathpdesolverPoint::to_string(self : MathpdesolverPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathpdesolverSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_pde_solver_make_series(vals : Array[Double], name : String) -> MathpdesolverSeries {
  { vals, name, meta: 0 }
}

pub fn MathpdesolverSeries::len(self : MathpdesolverSeries) -> Int { self.vals.length() }

pub fn MathpdesolverSeries::sum(self : MathpdesolverSeries) -> Double { @_common.sum(self.vals) }

pub fn MathpdesolverSeries::mean(self : MathpdesolverSeries) -> Double { @_common.mean(self.vals) }

pub fn MathpdesolverSeries::min(self : MathpdesolverSeries) -> Double { @_common.min(self.vals) }

pub fn MathpdesolverSeries::max(self : MathpdesolverSeries) -> Double { @_common.max(self.vals) }

pub fn MathpdesolverSeries::range(self : MathpdesolverSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathpdesolverSeries::variance(self : MathpdesolverSeries) -> Double { @_common.variance(self.vals) }

pub fn MathpdesolverSeries::std(self : MathpdesolverSeries) -> Double { @_common.std(self.vals) }

pub fn MathpdesolverSeries::median(self : MathpdesolverSeries) -> Double { @_common.median(self.vals) }

pub fn MathpdesolverSeries::scale(self : MathpdesolverSeries, f : Double) -> MathpdesolverSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathpdesolverSeries::add(self : MathpdesolverSeries, other : MathpdesolverSeries) -> MathpdesolverSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathpdesolverSeries::sub(self : MathpdesolverSeries, other : MathpdesolverSeries) -> MathpdesolverSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathpdesolverSeries::normalize(self : MathpdesolverSeries) -> MathpdesolverSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathpdesolverSeries::cumsum(self : MathpdesolverSeries) -> MathpdesolverSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathpdesolverSeries::to_string(self : MathpdesolverSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathpdesolverMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_pde_solver_make_matrix(rows : Int, cols : Int, val : Double) -> MathpdesolverMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_pde_solver_matrix_identity(n : Int) -> MathpdesolverMatrix {
  let m = math_pde_solver_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathpdesolverMatrix::get(self : MathpdesolverMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathpdesolverMatrix::transpose(self : MathpdesolverMatrix) -> MathpdesolverMatrix {
  let result = math_pde_solver_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathpdesolverMatrix::add(self : MathpdesolverMatrix, other : MathpdesolverMatrix) -> MathpdesolverMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_pde_solver_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathpdesolverMatrix::scale(self : MathpdesolverMatrix, s : Double) -> MathpdesolverMatrix {
  let result = math_pde_solver_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathpdesolverMatrix::multiply(self : MathpdesolverMatrix, other : MathpdesolverMatrix) -> MathpdesolverMatrix {
  if self.cols != other.rows { return math_pde_solver_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_pde_solver_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathpdesolverMatrix::trace(self : MathpdesolverMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathpdesolverMatrix::det(self : MathpdesolverMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathpdesolverMatrix::norm(self : MathpdesolverMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathpdesolverMatrix::to_string(self : MathpdesolverMatrix) -> String {
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

pub(all) struct MathpdesolverVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_pde_solver_make_vector(comps : Array[Double]) -> MathpdesolverVector {
  { comps, dim: comps.length() }
}

pub fn math_pde_solver_vector_zero(dim : Int) -> MathpdesolverVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathpdesolverVector::add(self : MathpdesolverVector, other : MathpdesolverVector) -> MathpdesolverVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathpdesolverVector::sub(self : MathpdesolverVector, other : MathpdesolverVector) -> MathpdesolverVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathpdesolverVector::scale(self : MathpdesolverVector, s : Double) -> MathpdesolverVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathpdesolverVector::dot(self : MathpdesolverVector, other : MathpdesolverVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathpdesolverVector::norm(self : MathpdesolverVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathpdesolverVector::normalize(self : MathpdesolverVector) -> MathpdesolverVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathpdesolverVector::dist(self : MathpdesolverVector, other : MathpdesolverVector) -> Double {
  self.sub(other).norm()
}

pub fn MathpdesolverVector::to_string(self : MathpdesolverVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathpdesolverFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_frame_make(size : Int) -> MathpdesolverFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverFrame::len(self : MathpdesolverFrame) -> Int { self.size }

pub fn MathpdesolverFrame::get(self : MathpdesolverFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverFrame::set(self : MathpdesolverFrame, i : Int, v : Double) -> MathpdesolverFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverFrame::sum(self : MathpdesolverFrame) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverFrame::mean(self : MathpdesolverFrame) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverFrame::scale(self : MathpdesolverFrame, f : Double) -> MathpdesolverFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverFrame::add(self : MathpdesolverFrame, other : MathpdesolverFrame) -> MathpdesolverFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverFrame::copy(self : MathpdesolverFrame) -> MathpdesolverFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverFrame::fill(self : MathpdesolverFrame, v : Double) -> MathpdesolverFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverFrame::min(self : MathpdesolverFrame) -> Double { @_common.min(self.data) }

pub fn MathpdesolverFrame::max(self : MathpdesolverFrame) -> Double { @_common.max(self.data) }

pub fn MathpdesolverFrame::to_string(self : MathpdesolverFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_table_make(size : Int) -> MathpdesolverTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverTable::len(self : MathpdesolverTable) -> Int { self.size }

pub fn MathpdesolverTable::get(self : MathpdesolverTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverTable::set(self : MathpdesolverTable, i : Int, v : Double) -> MathpdesolverTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverTable::sum(self : MathpdesolverTable) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverTable::mean(self : MathpdesolverTable) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverTable::scale(self : MathpdesolverTable, f : Double) -> MathpdesolverTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverTable::add(self : MathpdesolverTable, other : MathpdesolverTable) -> MathpdesolverTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverTable::copy(self : MathpdesolverTable) -> MathpdesolverTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverTable::fill(self : MathpdesolverTable, v : Double) -> MathpdesolverTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverTable::min(self : MathpdesolverTable) -> Double { @_common.min(self.data) }

pub fn MathpdesolverTable::max(self : MathpdesolverTable) -> Double { @_common.max(self.data) }

pub fn MathpdesolverTable::to_string(self : MathpdesolverTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_graphn_make(size : Int) -> MathpdesolverGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverGraphN::len(self : MathpdesolverGraphN) -> Int { self.size }

pub fn MathpdesolverGraphN::get(self : MathpdesolverGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverGraphN::set(self : MathpdesolverGraphN, i : Int, v : Double) -> MathpdesolverGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverGraphN::sum(self : MathpdesolverGraphN) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverGraphN::mean(self : MathpdesolverGraphN) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverGraphN::scale(self : MathpdesolverGraphN, f : Double) -> MathpdesolverGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverGraphN::add(self : MathpdesolverGraphN, other : MathpdesolverGraphN) -> MathpdesolverGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverGraphN::copy(self : MathpdesolverGraphN) -> MathpdesolverGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverGraphN::fill(self : MathpdesolverGraphN, v : Double) -> MathpdesolverGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverGraphN::min(self : MathpdesolverGraphN) -> Double { @_common.min(self.data) }

pub fn MathpdesolverGraphN::max(self : MathpdesolverGraphN) -> Double { @_common.max(self.data) }

pub fn MathpdesolverGraphN::to_string(self : MathpdesolverGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_node_make(size : Int) -> MathpdesolverNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverNode::len(self : MathpdesolverNode) -> Int { self.size }

pub fn MathpdesolverNode::get(self : MathpdesolverNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverNode::set(self : MathpdesolverNode, i : Int, v : Double) -> MathpdesolverNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverNode::sum(self : MathpdesolverNode) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverNode::mean(self : MathpdesolverNode) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverNode::scale(self : MathpdesolverNode, f : Double) -> MathpdesolverNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverNode::add(self : MathpdesolverNode, other : MathpdesolverNode) -> MathpdesolverNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverNode::copy(self : MathpdesolverNode) -> MathpdesolverNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverNode::fill(self : MathpdesolverNode, v : Double) -> MathpdesolverNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverNode::min(self : MathpdesolverNode) -> Double { @_common.min(self.data) }

pub fn MathpdesolverNode::max(self : MathpdesolverNode) -> Double { @_common.max(self.data) }

pub fn MathpdesolverNode::to_string(self : MathpdesolverNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_edge_make(size : Int) -> MathpdesolverEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverEdge::len(self : MathpdesolverEdge) -> Int { self.size }

pub fn MathpdesolverEdge::get(self : MathpdesolverEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverEdge::set(self : MathpdesolverEdge, i : Int, v : Double) -> MathpdesolverEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverEdge::sum(self : MathpdesolverEdge) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverEdge::mean(self : MathpdesolverEdge) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverEdge::scale(self : MathpdesolverEdge, f : Double) -> MathpdesolverEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverEdge::add(self : MathpdesolverEdge, other : MathpdesolverEdge) -> MathpdesolverEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverEdge::copy(self : MathpdesolverEdge) -> MathpdesolverEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverEdge::fill(self : MathpdesolverEdge, v : Double) -> MathpdesolverEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverEdge::min(self : MathpdesolverEdge) -> Double { @_common.min(self.data) }

pub fn MathpdesolverEdge::max(self : MathpdesolverEdge) -> Double { @_common.max(self.data) }

pub fn MathpdesolverEdge::to_string(self : MathpdesolverEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_path_make(size : Int) -> MathpdesolverPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverPath::len(self : MathpdesolverPath) -> Int { self.size }

pub fn MathpdesolverPath::get(self : MathpdesolverPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverPath::set(self : MathpdesolverPath, i : Int, v : Double) -> MathpdesolverPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverPath::sum(self : MathpdesolverPath) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverPath::mean(self : MathpdesolverPath) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverPath::scale(self : MathpdesolverPath, f : Double) -> MathpdesolverPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverPath::add(self : MathpdesolverPath, other : MathpdesolverPath) -> MathpdesolverPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverPath::copy(self : MathpdesolverPath) -> MathpdesolverPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverPath::fill(self : MathpdesolverPath, v : Double) -> MathpdesolverPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverPath::min(self : MathpdesolverPath) -> Double { @_common.min(self.data) }

pub fn MathpdesolverPath::max(self : MathpdesolverPath) -> Double { @_common.max(self.data) }

pub fn MathpdesolverPath::to_string(self : MathpdesolverPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_cluster_make(size : Int) -> MathpdesolverCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverCluster::len(self : MathpdesolverCluster) -> Int { self.size }

pub fn MathpdesolverCluster::get(self : MathpdesolverCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverCluster::set(self : MathpdesolverCluster, i : Int, v : Double) -> MathpdesolverCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverCluster::sum(self : MathpdesolverCluster) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverCluster::mean(self : MathpdesolverCluster) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverCluster::scale(self : MathpdesolverCluster, f : Double) -> MathpdesolverCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverCluster::add(self : MathpdesolverCluster, other : MathpdesolverCluster) -> MathpdesolverCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverCluster::copy(self : MathpdesolverCluster) -> MathpdesolverCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverCluster::fill(self : MathpdesolverCluster, v : Double) -> MathpdesolverCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverCluster::min(self : MathpdesolverCluster) -> Double { @_common.min(self.data) }

pub fn MathpdesolverCluster::max(self : MathpdesolverCluster) -> Double { @_common.max(self.data) }

pub fn MathpdesolverCluster::to_string(self : MathpdesolverCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_model_make(size : Int) -> MathpdesolverModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverModel::len(self : MathpdesolverModel) -> Int { self.size }

pub fn MathpdesolverModel::get(self : MathpdesolverModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverModel::set(self : MathpdesolverModel, i : Int, v : Double) -> MathpdesolverModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverModel::sum(self : MathpdesolverModel) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverModel::mean(self : MathpdesolverModel) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverModel::scale(self : MathpdesolverModel, f : Double) -> MathpdesolverModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverModel::add(self : MathpdesolverModel, other : MathpdesolverModel) -> MathpdesolverModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverModel::copy(self : MathpdesolverModel) -> MathpdesolverModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverModel::fill(self : MathpdesolverModel, v : Double) -> MathpdesolverModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverModel::min(self : MathpdesolverModel) -> Double { @_common.min(self.data) }

pub fn MathpdesolverModel::max(self : MathpdesolverModel) -> Double { @_common.max(self.data) }

pub fn MathpdesolverModel::to_string(self : MathpdesolverModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_layer_make(size : Int) -> MathpdesolverLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverLayer::len(self : MathpdesolverLayer) -> Int { self.size }

pub fn MathpdesolverLayer::get(self : MathpdesolverLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverLayer::set(self : MathpdesolverLayer, i : Int, v : Double) -> MathpdesolverLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverLayer::sum(self : MathpdesolverLayer) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverLayer::mean(self : MathpdesolverLayer) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverLayer::scale(self : MathpdesolverLayer, f : Double) -> MathpdesolverLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverLayer::add(self : MathpdesolverLayer, other : MathpdesolverLayer) -> MathpdesolverLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverLayer::copy(self : MathpdesolverLayer) -> MathpdesolverLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverLayer::fill(self : MathpdesolverLayer, v : Double) -> MathpdesolverLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverLayer::min(self : MathpdesolverLayer) -> Double { @_common.min(self.data) }

pub fn MathpdesolverLayer::max(self : MathpdesolverLayer) -> Double { @_common.max(self.data) }

pub fn MathpdesolverLayer::to_string(self : MathpdesolverLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_buffer_make(size : Int) -> MathpdesolverBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverBuffer::len(self : MathpdesolverBuffer) -> Int { self.size }

pub fn MathpdesolverBuffer::get(self : MathpdesolverBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverBuffer::set(self : MathpdesolverBuffer, i : Int, v : Double) -> MathpdesolverBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverBuffer::sum(self : MathpdesolverBuffer) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverBuffer::mean(self : MathpdesolverBuffer) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverBuffer::scale(self : MathpdesolverBuffer, f : Double) -> MathpdesolverBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverBuffer::add(self : MathpdesolverBuffer, other : MathpdesolverBuffer) -> MathpdesolverBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverBuffer::copy(self : MathpdesolverBuffer) -> MathpdesolverBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverBuffer::fill(self : MathpdesolverBuffer, v : Double) -> MathpdesolverBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverBuffer::min(self : MathpdesolverBuffer) -> Double { @_common.min(self.data) }

pub fn MathpdesolverBuffer::max(self : MathpdesolverBuffer) -> Double { @_common.max(self.data) }

pub fn MathpdesolverBuffer::to_string(self : MathpdesolverBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_cursor_make(size : Int) -> MathpdesolverCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverCursor::len(self : MathpdesolverCursor) -> Int { self.size }

pub fn MathpdesolverCursor::get(self : MathpdesolverCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverCursor::set(self : MathpdesolverCursor, i : Int, v : Double) -> MathpdesolverCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverCursor::sum(self : MathpdesolverCursor) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverCursor::mean(self : MathpdesolverCursor) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverCursor::scale(self : MathpdesolverCursor, f : Double) -> MathpdesolverCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverCursor::add(self : MathpdesolverCursor, other : MathpdesolverCursor) -> MathpdesolverCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverCursor::copy(self : MathpdesolverCursor) -> MathpdesolverCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverCursor::fill(self : MathpdesolverCursor, v : Double) -> MathpdesolverCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverCursor::min(self : MathpdesolverCursor) -> Double { @_common.min(self.data) }

pub fn MathpdesolverCursor::max(self : MathpdesolverCursor) -> Double { @_common.max(self.data) }

pub fn MathpdesolverCursor::to_string(self : MathpdesolverCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_view_make(size : Int) -> MathpdesolverView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverView::len(self : MathpdesolverView) -> Int { self.size }

pub fn MathpdesolverView::get(self : MathpdesolverView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverView::set(self : MathpdesolverView, i : Int, v : Double) -> MathpdesolverView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverView::sum(self : MathpdesolverView) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverView::mean(self : MathpdesolverView) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverView::scale(self : MathpdesolverView, f : Double) -> MathpdesolverView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverView::add(self : MathpdesolverView, other : MathpdesolverView) -> MathpdesolverView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverView::copy(self : MathpdesolverView) -> MathpdesolverView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverView::fill(self : MathpdesolverView, v : Double) -> MathpdesolverView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverView::min(self : MathpdesolverView) -> Double { @_common.min(self.data) }

pub fn MathpdesolverView::max(self : MathpdesolverView) -> Double { @_common.max(self.data) }

pub fn MathpdesolverView::to_string(self : MathpdesolverView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_range_make(size : Int) -> MathpdesolverRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverRange::len(self : MathpdesolverRange) -> Int { self.size }

pub fn MathpdesolverRange::get(self : MathpdesolverRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverRange::set(self : MathpdesolverRange, i : Int, v : Double) -> MathpdesolverRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverRange::sum(self : MathpdesolverRange) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverRange::mean(self : MathpdesolverRange) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverRange::scale(self : MathpdesolverRange, f : Double) -> MathpdesolverRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverRange::add(self : MathpdesolverRange, other : MathpdesolverRange) -> MathpdesolverRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverRange::copy(self : MathpdesolverRange) -> MathpdesolverRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverRange::fill(self : MathpdesolverRange, v : Double) -> MathpdesolverRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverRange::min(self : MathpdesolverRange) -> Double { @_common.min(self.data) }

pub fn MathpdesolverRange::max(self : MathpdesolverRange) -> Double { @_common.max(self.data) }

pub fn MathpdesolverRange::to_string(self : MathpdesolverRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathpdesolverSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_pde_solver_slice_make(size : Int) -> MathpdesolverSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathpdesolverSlice::len(self : MathpdesolverSlice) -> Int { self.size }

pub fn MathpdesolverSlice::get(self : MathpdesolverSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathpdesolverSlice::set(self : MathpdesolverSlice, i : Int, v : Double) -> MathpdesolverSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathpdesolverSlice::sum(self : MathpdesolverSlice) -> Double { @_common.sum(self.data) }

pub fn MathpdesolverSlice::mean(self : MathpdesolverSlice) -> Double { @_common.mean(self.data) }

pub fn MathpdesolverSlice::scale(self : MathpdesolverSlice, f : Double) -> MathpdesolverSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathpdesolverSlice::add(self : MathpdesolverSlice, other : MathpdesolverSlice) -> MathpdesolverSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathpdesolverSlice::copy(self : MathpdesolverSlice) -> MathpdesolverSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathpdesolverSlice::fill(self : MathpdesolverSlice, v : Double) -> MathpdesolverSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathpdesolverSlice::min(self : MathpdesolverSlice) -> Double { @_common.min(self.data) }

pub fn MathpdesolverSlice::max(self : MathpdesolverSlice) -> Double { @_common.max(self.data) }

pub fn MathpdesolverSlice::to_string(self : MathpdesolverSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

