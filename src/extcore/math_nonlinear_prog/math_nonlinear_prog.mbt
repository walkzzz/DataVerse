///===
/// extcore/math_nonlinear_prog

pub(all) struct MathnonlinearprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_nonlinear_prog_make_point(x : Double, y : Double) -> MathnonlinearprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_nonlinear_prog_make_point3(x : Double, y : Double, z : Double) -> MathnonlinearprogPoint {
  { x, y, z, label: 0 }
}

pub fn MathnonlinearprogPoint::x(self : MathnonlinearprogPoint) -> Double { self.x }

pub fn MathnonlinearprogPoint::y(self : MathnonlinearprogPoint) -> Double { self.y }

pub fn MathnonlinearprogPoint::z(self : MathnonlinearprogPoint) -> Double { self.z }

pub fn MathnonlinearprogPoint::label(self : MathnonlinearprogPoint) -> Int { self.label }

pub fn MathnonlinearprogPoint::dist(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathnonlinearprogPoint::add(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathnonlinearprogPoint::sub(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathnonlinearprogPoint::scale(self : MathnonlinearprogPoint, s : Double) -> MathnonlinearprogPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathnonlinearprogPoint::dot(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathnonlinearprogPoint::cross(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathnonlinearprogPoint::norm(self : MathnonlinearprogPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathnonlinearprogPoint::normalize(self : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnonlinearprogPoint::negate(self : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathnonlinearprogPoint::mid(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathnonlinearprogPoint::lerp(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint, t : Double) -> MathnonlinearprogPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathnonlinearprogPoint::to_string(self : MathnonlinearprogPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathnonlinearprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_nonlinear_prog_make_series(vals : Array[Double], name : String) -> MathnonlinearprogSeries {
  { vals, name, meta: 0 }
}

pub fn MathnonlinearprogSeries::len(self : MathnonlinearprogSeries) -> Int { self.vals.length() }

pub fn MathnonlinearprogSeries::sum(self : MathnonlinearprogSeries) -> Double { @_common.sum(self.vals) }

pub fn MathnonlinearprogSeries::mean(self : MathnonlinearprogSeries) -> Double { @_common.mean(self.vals) }

pub fn MathnonlinearprogSeries::min(self : MathnonlinearprogSeries) -> Double { @_common.min(self.vals) }

pub fn MathnonlinearprogSeries::max(self : MathnonlinearprogSeries) -> Double { @_common.max(self.vals) }

pub fn MathnonlinearprogSeries::range(self : MathnonlinearprogSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathnonlinearprogSeries::variance(self : MathnonlinearprogSeries) -> Double { @_common.variance(self.vals) }

pub fn MathnonlinearprogSeries::std(self : MathnonlinearprogSeries) -> Double { @_common.std(self.vals) }

pub fn MathnonlinearprogSeries::median(self : MathnonlinearprogSeries) -> Double { @_common.median(self.vals) }

pub fn MathnonlinearprogSeries::scale(self : MathnonlinearprogSeries, f : Double) -> MathnonlinearprogSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathnonlinearprogSeries::add(self : MathnonlinearprogSeries, other : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathnonlinearprogSeries::sub(self : MathnonlinearprogSeries, other : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathnonlinearprogSeries::normalize(self : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathnonlinearprogSeries::cumsum(self : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathnonlinearprogSeries::to_string(self : MathnonlinearprogSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnonlinearprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_nonlinear_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathnonlinearprogMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_nonlinear_prog_matrix_identity(n : Int) -> MathnonlinearprogMatrix {
  let m = math_nonlinear_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathnonlinearprogMatrix::get(self : MathnonlinearprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathnonlinearprogMatrix::transpose(self : MathnonlinearprogMatrix) -> MathnonlinearprogMatrix {
  let result = math_nonlinear_prog_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathnonlinearprogMatrix::add(self : MathnonlinearprogMatrix, other : MathnonlinearprogMatrix) -> MathnonlinearprogMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_nonlinear_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathnonlinearprogMatrix::scale(self : MathnonlinearprogMatrix, s : Double) -> MathnonlinearprogMatrix {
  let result = math_nonlinear_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathnonlinearprogMatrix::multiply(self : MathnonlinearprogMatrix, other : MathnonlinearprogMatrix) -> MathnonlinearprogMatrix {
  if self.cols != other.rows { return math_nonlinear_prog_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_nonlinear_prog_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathnonlinearprogMatrix::trace(self : MathnonlinearprogMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathnonlinearprogMatrix::det(self : MathnonlinearprogMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathnonlinearprogMatrix::norm(self : MathnonlinearprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathnonlinearprogMatrix::to_string(self : MathnonlinearprogMatrix) -> String {
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

pub(all) struct MathnonlinearprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_nonlinear_prog_make_vector(comps : Array[Double]) -> MathnonlinearprogVector {
  { comps, dim: comps.length() }
}

pub fn math_nonlinear_prog_vector_zero(dim : Int) -> MathnonlinearprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathnonlinearprogVector::add(self : MathnonlinearprogVector, other : MathnonlinearprogVector) -> MathnonlinearprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathnonlinearprogVector::sub(self : MathnonlinearprogVector, other : MathnonlinearprogVector) -> MathnonlinearprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathnonlinearprogVector::scale(self : MathnonlinearprogVector, s : Double) -> MathnonlinearprogVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathnonlinearprogVector::dot(self : MathnonlinearprogVector, other : MathnonlinearprogVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathnonlinearprogVector::norm(self : MathnonlinearprogVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathnonlinearprogVector::normalize(self : MathnonlinearprogVector) -> MathnonlinearprogVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnonlinearprogVector::dist(self : MathnonlinearprogVector, other : MathnonlinearprogVector) -> Double {
  self.sub(other).norm()
}

pub fn MathnonlinearprogVector::to_string(self : MathnonlinearprogVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnonlinearprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_frame_make(size : Int) -> MathnonlinearprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogFrame::len(self : MathnonlinearprogFrame) -> Int { self.size }

pub fn MathnonlinearprogFrame::get(self : MathnonlinearprogFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogFrame::set(self : MathnonlinearprogFrame, i : Int, v : Double) -> MathnonlinearprogFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogFrame::sum(self : MathnonlinearprogFrame) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogFrame::mean(self : MathnonlinearprogFrame) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogFrame::scale(self : MathnonlinearprogFrame, f : Double) -> MathnonlinearprogFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogFrame::add(self : MathnonlinearprogFrame, other : MathnonlinearprogFrame) -> MathnonlinearprogFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogFrame::copy(self : MathnonlinearprogFrame) -> MathnonlinearprogFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogFrame::fill(self : MathnonlinearprogFrame, v : Double) -> MathnonlinearprogFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogFrame::min(self : MathnonlinearprogFrame) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogFrame::max(self : MathnonlinearprogFrame) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogFrame::to_string(self : MathnonlinearprogFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_table_make(size : Int) -> MathnonlinearprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogTable::len(self : MathnonlinearprogTable) -> Int { self.size }

pub fn MathnonlinearprogTable::get(self : MathnonlinearprogTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogTable::set(self : MathnonlinearprogTable, i : Int, v : Double) -> MathnonlinearprogTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogTable::sum(self : MathnonlinearprogTable) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogTable::mean(self : MathnonlinearprogTable) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogTable::scale(self : MathnonlinearprogTable, f : Double) -> MathnonlinearprogTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogTable::add(self : MathnonlinearprogTable, other : MathnonlinearprogTable) -> MathnonlinearprogTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogTable::copy(self : MathnonlinearprogTable) -> MathnonlinearprogTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogTable::fill(self : MathnonlinearprogTable, v : Double) -> MathnonlinearprogTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogTable::min(self : MathnonlinearprogTable) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogTable::max(self : MathnonlinearprogTable) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogTable::to_string(self : MathnonlinearprogTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_graphn_make(size : Int) -> MathnonlinearprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogGraphN::len(self : MathnonlinearprogGraphN) -> Int { self.size }

pub fn MathnonlinearprogGraphN::get(self : MathnonlinearprogGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogGraphN::set(self : MathnonlinearprogGraphN, i : Int, v : Double) -> MathnonlinearprogGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogGraphN::sum(self : MathnonlinearprogGraphN) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogGraphN::mean(self : MathnonlinearprogGraphN) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogGraphN::scale(self : MathnonlinearprogGraphN, f : Double) -> MathnonlinearprogGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogGraphN::add(self : MathnonlinearprogGraphN, other : MathnonlinearprogGraphN) -> MathnonlinearprogGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogGraphN::copy(self : MathnonlinearprogGraphN) -> MathnonlinearprogGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogGraphN::fill(self : MathnonlinearprogGraphN, v : Double) -> MathnonlinearprogGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogGraphN::min(self : MathnonlinearprogGraphN) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogGraphN::max(self : MathnonlinearprogGraphN) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogGraphN::to_string(self : MathnonlinearprogGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_node_make(size : Int) -> MathnonlinearprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogNode::len(self : MathnonlinearprogNode) -> Int { self.size }

pub fn MathnonlinearprogNode::get(self : MathnonlinearprogNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogNode::set(self : MathnonlinearprogNode, i : Int, v : Double) -> MathnonlinearprogNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogNode::sum(self : MathnonlinearprogNode) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogNode::mean(self : MathnonlinearprogNode) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogNode::scale(self : MathnonlinearprogNode, f : Double) -> MathnonlinearprogNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogNode::add(self : MathnonlinearprogNode, other : MathnonlinearprogNode) -> MathnonlinearprogNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogNode::copy(self : MathnonlinearprogNode) -> MathnonlinearprogNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogNode::fill(self : MathnonlinearprogNode, v : Double) -> MathnonlinearprogNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogNode::min(self : MathnonlinearprogNode) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogNode::max(self : MathnonlinearprogNode) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogNode::to_string(self : MathnonlinearprogNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_edge_make(size : Int) -> MathnonlinearprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogEdge::len(self : MathnonlinearprogEdge) -> Int { self.size }

pub fn MathnonlinearprogEdge::get(self : MathnonlinearprogEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogEdge::set(self : MathnonlinearprogEdge, i : Int, v : Double) -> MathnonlinearprogEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogEdge::sum(self : MathnonlinearprogEdge) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogEdge::mean(self : MathnonlinearprogEdge) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogEdge::scale(self : MathnonlinearprogEdge, f : Double) -> MathnonlinearprogEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogEdge::add(self : MathnonlinearprogEdge, other : MathnonlinearprogEdge) -> MathnonlinearprogEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogEdge::copy(self : MathnonlinearprogEdge) -> MathnonlinearprogEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogEdge::fill(self : MathnonlinearprogEdge, v : Double) -> MathnonlinearprogEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogEdge::min(self : MathnonlinearprogEdge) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogEdge::max(self : MathnonlinearprogEdge) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogEdge::to_string(self : MathnonlinearprogEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_path_make(size : Int) -> MathnonlinearprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogPath::len(self : MathnonlinearprogPath) -> Int { self.size }

pub fn MathnonlinearprogPath::get(self : MathnonlinearprogPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogPath::set(self : MathnonlinearprogPath, i : Int, v : Double) -> MathnonlinearprogPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogPath::sum(self : MathnonlinearprogPath) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogPath::mean(self : MathnonlinearprogPath) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogPath::scale(self : MathnonlinearprogPath, f : Double) -> MathnonlinearprogPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogPath::add(self : MathnonlinearprogPath, other : MathnonlinearprogPath) -> MathnonlinearprogPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogPath::copy(self : MathnonlinearprogPath) -> MathnonlinearprogPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogPath::fill(self : MathnonlinearprogPath, v : Double) -> MathnonlinearprogPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogPath::min(self : MathnonlinearprogPath) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogPath::max(self : MathnonlinearprogPath) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogPath::to_string(self : MathnonlinearprogPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_cluster_make(size : Int) -> MathnonlinearprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogCluster::len(self : MathnonlinearprogCluster) -> Int { self.size }

pub fn MathnonlinearprogCluster::get(self : MathnonlinearprogCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogCluster::set(self : MathnonlinearprogCluster, i : Int, v : Double) -> MathnonlinearprogCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogCluster::sum(self : MathnonlinearprogCluster) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogCluster::mean(self : MathnonlinearprogCluster) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogCluster::scale(self : MathnonlinearprogCluster, f : Double) -> MathnonlinearprogCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogCluster::add(self : MathnonlinearprogCluster, other : MathnonlinearprogCluster) -> MathnonlinearprogCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogCluster::copy(self : MathnonlinearprogCluster) -> MathnonlinearprogCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogCluster::fill(self : MathnonlinearprogCluster, v : Double) -> MathnonlinearprogCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogCluster::min(self : MathnonlinearprogCluster) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogCluster::max(self : MathnonlinearprogCluster) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogCluster::to_string(self : MathnonlinearprogCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_model_make(size : Int) -> MathnonlinearprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogModel::len(self : MathnonlinearprogModel) -> Int { self.size }

pub fn MathnonlinearprogModel::get(self : MathnonlinearprogModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogModel::set(self : MathnonlinearprogModel, i : Int, v : Double) -> MathnonlinearprogModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogModel::sum(self : MathnonlinearprogModel) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogModel::mean(self : MathnonlinearprogModel) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogModel::scale(self : MathnonlinearprogModel, f : Double) -> MathnonlinearprogModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogModel::add(self : MathnonlinearprogModel, other : MathnonlinearprogModel) -> MathnonlinearprogModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogModel::copy(self : MathnonlinearprogModel) -> MathnonlinearprogModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogModel::fill(self : MathnonlinearprogModel, v : Double) -> MathnonlinearprogModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogModel::min(self : MathnonlinearprogModel) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogModel::max(self : MathnonlinearprogModel) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogModel::to_string(self : MathnonlinearprogModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_layer_make(size : Int) -> MathnonlinearprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogLayer::len(self : MathnonlinearprogLayer) -> Int { self.size }

pub fn MathnonlinearprogLayer::get(self : MathnonlinearprogLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogLayer::set(self : MathnonlinearprogLayer, i : Int, v : Double) -> MathnonlinearprogLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogLayer::sum(self : MathnonlinearprogLayer) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogLayer::mean(self : MathnonlinearprogLayer) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogLayer::scale(self : MathnonlinearprogLayer, f : Double) -> MathnonlinearprogLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogLayer::add(self : MathnonlinearprogLayer, other : MathnonlinearprogLayer) -> MathnonlinearprogLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogLayer::copy(self : MathnonlinearprogLayer) -> MathnonlinearprogLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogLayer::fill(self : MathnonlinearprogLayer, v : Double) -> MathnonlinearprogLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogLayer::min(self : MathnonlinearprogLayer) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogLayer::max(self : MathnonlinearprogLayer) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogLayer::to_string(self : MathnonlinearprogLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_buffer_make(size : Int) -> MathnonlinearprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogBuffer::len(self : MathnonlinearprogBuffer) -> Int { self.size }

pub fn MathnonlinearprogBuffer::get(self : MathnonlinearprogBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogBuffer::set(self : MathnonlinearprogBuffer, i : Int, v : Double) -> MathnonlinearprogBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogBuffer::sum(self : MathnonlinearprogBuffer) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogBuffer::mean(self : MathnonlinearprogBuffer) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogBuffer::scale(self : MathnonlinearprogBuffer, f : Double) -> MathnonlinearprogBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogBuffer::add(self : MathnonlinearprogBuffer, other : MathnonlinearprogBuffer) -> MathnonlinearprogBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogBuffer::copy(self : MathnonlinearprogBuffer) -> MathnonlinearprogBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogBuffer::fill(self : MathnonlinearprogBuffer, v : Double) -> MathnonlinearprogBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogBuffer::min(self : MathnonlinearprogBuffer) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogBuffer::max(self : MathnonlinearprogBuffer) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogBuffer::to_string(self : MathnonlinearprogBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_cursor_make(size : Int) -> MathnonlinearprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogCursor::len(self : MathnonlinearprogCursor) -> Int { self.size }

pub fn MathnonlinearprogCursor::get(self : MathnonlinearprogCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogCursor::set(self : MathnonlinearprogCursor, i : Int, v : Double) -> MathnonlinearprogCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogCursor::sum(self : MathnonlinearprogCursor) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogCursor::mean(self : MathnonlinearprogCursor) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogCursor::scale(self : MathnonlinearprogCursor, f : Double) -> MathnonlinearprogCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogCursor::add(self : MathnonlinearprogCursor, other : MathnonlinearprogCursor) -> MathnonlinearprogCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogCursor::copy(self : MathnonlinearprogCursor) -> MathnonlinearprogCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogCursor::fill(self : MathnonlinearprogCursor, v : Double) -> MathnonlinearprogCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogCursor::min(self : MathnonlinearprogCursor) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogCursor::max(self : MathnonlinearprogCursor) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogCursor::to_string(self : MathnonlinearprogCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_view_make(size : Int) -> MathnonlinearprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogView::len(self : MathnonlinearprogView) -> Int { self.size }

pub fn MathnonlinearprogView::get(self : MathnonlinearprogView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogView::set(self : MathnonlinearprogView, i : Int, v : Double) -> MathnonlinearprogView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogView::sum(self : MathnonlinearprogView) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogView::mean(self : MathnonlinearprogView) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogView::scale(self : MathnonlinearprogView, f : Double) -> MathnonlinearprogView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogView::add(self : MathnonlinearprogView, other : MathnonlinearprogView) -> MathnonlinearprogView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogView::copy(self : MathnonlinearprogView) -> MathnonlinearprogView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogView::fill(self : MathnonlinearprogView, v : Double) -> MathnonlinearprogView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogView::min(self : MathnonlinearprogView) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogView::max(self : MathnonlinearprogView) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogView::to_string(self : MathnonlinearprogView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_range_make(size : Int) -> MathnonlinearprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogRange::len(self : MathnonlinearprogRange) -> Int { self.size }

pub fn MathnonlinearprogRange::get(self : MathnonlinearprogRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogRange::set(self : MathnonlinearprogRange, i : Int, v : Double) -> MathnonlinearprogRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogRange::sum(self : MathnonlinearprogRange) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogRange::mean(self : MathnonlinearprogRange) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogRange::scale(self : MathnonlinearprogRange, f : Double) -> MathnonlinearprogRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogRange::add(self : MathnonlinearprogRange, other : MathnonlinearprogRange) -> MathnonlinearprogRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogRange::copy(self : MathnonlinearprogRange) -> MathnonlinearprogRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogRange::fill(self : MathnonlinearprogRange, v : Double) -> MathnonlinearprogRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogRange::min(self : MathnonlinearprogRange) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogRange::max(self : MathnonlinearprogRange) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogRange::to_string(self : MathnonlinearprogRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_slice_make(size : Int) -> MathnonlinearprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnonlinearprogSlice::len(self : MathnonlinearprogSlice) -> Int { self.size }

pub fn MathnonlinearprogSlice::get(self : MathnonlinearprogSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnonlinearprogSlice::set(self : MathnonlinearprogSlice, i : Int, v : Double) -> MathnonlinearprogSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogSlice::sum(self : MathnonlinearprogSlice) -> Double { @_common.sum(self.data) }

pub fn MathnonlinearprogSlice::mean(self : MathnonlinearprogSlice) -> Double { @_common.mean(self.data) }

pub fn MathnonlinearprogSlice::scale(self : MathnonlinearprogSlice, f : Double) -> MathnonlinearprogSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogSlice::add(self : MathnonlinearprogSlice, other : MathnonlinearprogSlice) -> MathnonlinearprogSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnonlinearprogSlice::copy(self : MathnonlinearprogSlice) -> MathnonlinearprogSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogSlice::fill(self : MathnonlinearprogSlice, v : Double) -> MathnonlinearprogSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnonlinearprogSlice::min(self : MathnonlinearprogSlice) -> Double { @_common.min(self.data) }

pub fn MathnonlinearprogSlice::max(self : MathnonlinearprogSlice) -> Double { @_common.max(self.data) }

pub fn MathnonlinearprogSlice::to_string(self : MathnonlinearprogSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

