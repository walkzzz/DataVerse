///===
/// extcore/math_linear_prog

pub(all) struct MathlinearprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_linear_prog_make_point(x : Double, y : Double) -> MathlinearprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_linear_prog_make_point3(x : Double, y : Double, z : Double) -> MathlinearprogPoint {
  { x, y, z, label: 0 }
}

pub fn MathlinearprogPoint::x(self : MathlinearprogPoint) -> Double { self.x }

pub fn MathlinearprogPoint::y(self : MathlinearprogPoint) -> Double { self.y }

pub fn MathlinearprogPoint::z(self : MathlinearprogPoint) -> Double { self.z }

pub fn MathlinearprogPoint::label(self : MathlinearprogPoint) -> Int { self.label }

pub fn MathlinearprogPoint::dist(self : MathlinearprogPoint, other : MathlinearprogPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathlinearprogPoint::add(self : MathlinearprogPoint, other : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathlinearprogPoint::sub(self : MathlinearprogPoint, other : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathlinearprogPoint::scale(self : MathlinearprogPoint, s : Double) -> MathlinearprogPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathlinearprogPoint::dot(self : MathlinearprogPoint, other : MathlinearprogPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathlinearprogPoint::cross(self : MathlinearprogPoint, other : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathlinearprogPoint::norm(self : MathlinearprogPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathlinearprogPoint::normalize(self : MathlinearprogPoint) -> MathlinearprogPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathlinearprogPoint::negate(self : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathlinearprogPoint::mid(self : MathlinearprogPoint, other : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathlinearprogPoint::lerp(self : MathlinearprogPoint, other : MathlinearprogPoint, t : Double) -> MathlinearprogPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathlinearprogPoint::to_string(self : MathlinearprogPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathlinearprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_linear_prog_make_series(vals : Array[Double], name : String) -> MathlinearprogSeries {
  { vals, name, meta: 0 }
}

pub fn MathlinearprogSeries::len(self : MathlinearprogSeries) -> Int { self.vals.length() }

pub fn MathlinearprogSeries::sum(self : MathlinearprogSeries) -> Double { @_common.sum(self.vals) }

pub fn MathlinearprogSeries::mean(self : MathlinearprogSeries) -> Double { @_common.mean(self.vals) }

pub fn MathlinearprogSeries::min(self : MathlinearprogSeries) -> Double { @_common.min(self.vals) }

pub fn MathlinearprogSeries::max(self : MathlinearprogSeries) -> Double { @_common.max(self.vals) }

pub fn MathlinearprogSeries::range(self : MathlinearprogSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathlinearprogSeries::variance(self : MathlinearprogSeries) -> Double { @_common.variance(self.vals) }

pub fn MathlinearprogSeries::std(self : MathlinearprogSeries) -> Double { @_common.std(self.vals) }

pub fn MathlinearprogSeries::median(self : MathlinearprogSeries) -> Double { @_common.median(self.vals) }

pub fn MathlinearprogSeries::scale(self : MathlinearprogSeries, f : Double) -> MathlinearprogSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathlinearprogSeries::add(self : MathlinearprogSeries, other : MathlinearprogSeries) -> MathlinearprogSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathlinearprogSeries::sub(self : MathlinearprogSeries, other : MathlinearprogSeries) -> MathlinearprogSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathlinearprogSeries::normalize(self : MathlinearprogSeries) -> MathlinearprogSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathlinearprogSeries::cumsum(self : MathlinearprogSeries) -> MathlinearprogSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathlinearprogSeries::to_string(self : MathlinearprogSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathlinearprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_linear_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathlinearprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_linear_prog_matrix_identity(n : Int) -> MathlinearprogMatrix {
  let m = math_linear_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathlinearprogMatrix::get(self : MathlinearprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathlinearprogMatrix::transpose(self : MathlinearprogMatrix) -> MathlinearprogMatrix {
  let result = math_linear_prog_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathlinearprogMatrix::add(self : MathlinearprogMatrix, other : MathlinearprogMatrix) -> MathlinearprogMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_linear_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathlinearprogMatrix::scale(self : MathlinearprogMatrix, s : Double) -> MathlinearprogMatrix {
  let result = math_linear_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathlinearprogMatrix::multiply(self : MathlinearprogMatrix, other : MathlinearprogMatrix) -> MathlinearprogMatrix {
  if self.cols != other.rows { return math_linear_prog_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_linear_prog_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathlinearprogMatrix::trace(self : MathlinearprogMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathlinearprogMatrix::det(self : MathlinearprogMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathlinearprogMatrix::norm(self : MathlinearprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathlinearprogMatrix::to_string(self : MathlinearprogMatrix) -> String {
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

pub(all) struct MathlinearprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_linear_prog_make_vector(comps : Array[Double]) -> MathlinearprogVector {
  { comps, dim: comps.length() }
}

pub fn math_linear_prog_vector_zero(dim : Int) -> MathlinearprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathlinearprogVector::add(self : MathlinearprogVector, other : MathlinearprogVector) -> MathlinearprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathlinearprogVector::sub(self : MathlinearprogVector, other : MathlinearprogVector) -> MathlinearprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathlinearprogVector::scale(self : MathlinearprogVector, s : Double) -> MathlinearprogVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathlinearprogVector::dot(self : MathlinearprogVector, other : MathlinearprogVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathlinearprogVector::norm(self : MathlinearprogVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathlinearprogVector::normalize(self : MathlinearprogVector) -> MathlinearprogVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathlinearprogVector::dist(self : MathlinearprogVector, other : MathlinearprogVector) -> Double {
  self.sub(other).norm()
}

pub fn MathlinearprogVector::to_string(self : MathlinearprogVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathlinearprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_frame_make(size : Int) -> MathlinearprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogFrame::len(self : MathlinearprogFrame) -> Int { self.size }

pub fn MathlinearprogFrame::get(self : MathlinearprogFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogFrame::set(self : MathlinearprogFrame, i : Int, v : Double) -> MathlinearprogFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogFrame::sum(self : MathlinearprogFrame) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogFrame::mean(self : MathlinearprogFrame) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogFrame::scale(self : MathlinearprogFrame, f : Double) -> MathlinearprogFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogFrame::add(self : MathlinearprogFrame, other : MathlinearprogFrame) -> MathlinearprogFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogFrame::copy(self : MathlinearprogFrame) -> MathlinearprogFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogFrame::fill(self : MathlinearprogFrame, v : Double) -> MathlinearprogFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogFrame::min(self : MathlinearprogFrame) -> Double { @_common.min(self.data) }

pub fn MathlinearprogFrame::max(self : MathlinearprogFrame) -> Double { @_common.max(self.data) }

pub fn MathlinearprogFrame::to_string(self : MathlinearprogFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_table_make(size : Int) -> MathlinearprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogTable::len(self : MathlinearprogTable) -> Int { self.size }

pub fn MathlinearprogTable::get(self : MathlinearprogTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogTable::set(self : MathlinearprogTable, i : Int, v : Double) -> MathlinearprogTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogTable::sum(self : MathlinearprogTable) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogTable::mean(self : MathlinearprogTable) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogTable::scale(self : MathlinearprogTable, f : Double) -> MathlinearprogTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogTable::add(self : MathlinearprogTable, other : MathlinearprogTable) -> MathlinearprogTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogTable::copy(self : MathlinearprogTable) -> MathlinearprogTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogTable::fill(self : MathlinearprogTable, v : Double) -> MathlinearprogTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogTable::min(self : MathlinearprogTable) -> Double { @_common.min(self.data) }

pub fn MathlinearprogTable::max(self : MathlinearprogTable) -> Double { @_common.max(self.data) }

pub fn MathlinearprogTable::to_string(self : MathlinearprogTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_graphn_make(size : Int) -> MathlinearprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogGraphN::len(self : MathlinearprogGraphN) -> Int { self.size }

pub fn MathlinearprogGraphN::get(self : MathlinearprogGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogGraphN::set(self : MathlinearprogGraphN, i : Int, v : Double) -> MathlinearprogGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogGraphN::sum(self : MathlinearprogGraphN) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogGraphN::mean(self : MathlinearprogGraphN) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogGraphN::scale(self : MathlinearprogGraphN, f : Double) -> MathlinearprogGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogGraphN::add(self : MathlinearprogGraphN, other : MathlinearprogGraphN) -> MathlinearprogGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogGraphN::copy(self : MathlinearprogGraphN) -> MathlinearprogGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogGraphN::fill(self : MathlinearprogGraphN, v : Double) -> MathlinearprogGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogGraphN::min(self : MathlinearprogGraphN) -> Double { @_common.min(self.data) }

pub fn MathlinearprogGraphN::max(self : MathlinearprogGraphN) -> Double { @_common.max(self.data) }

pub fn MathlinearprogGraphN::to_string(self : MathlinearprogGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_node_make(size : Int) -> MathlinearprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogNode::len(self : MathlinearprogNode) -> Int { self.size }

pub fn MathlinearprogNode::get(self : MathlinearprogNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogNode::set(self : MathlinearprogNode, i : Int, v : Double) -> MathlinearprogNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogNode::sum(self : MathlinearprogNode) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogNode::mean(self : MathlinearprogNode) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogNode::scale(self : MathlinearprogNode, f : Double) -> MathlinearprogNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogNode::add(self : MathlinearprogNode, other : MathlinearprogNode) -> MathlinearprogNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogNode::copy(self : MathlinearprogNode) -> MathlinearprogNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogNode::fill(self : MathlinearprogNode, v : Double) -> MathlinearprogNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogNode::min(self : MathlinearprogNode) -> Double { @_common.min(self.data) }

pub fn MathlinearprogNode::max(self : MathlinearprogNode) -> Double { @_common.max(self.data) }

pub fn MathlinearprogNode::to_string(self : MathlinearprogNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_edge_make(size : Int) -> MathlinearprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogEdge::len(self : MathlinearprogEdge) -> Int { self.size }

pub fn MathlinearprogEdge::get(self : MathlinearprogEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogEdge::set(self : MathlinearprogEdge, i : Int, v : Double) -> MathlinearprogEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogEdge::sum(self : MathlinearprogEdge) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogEdge::mean(self : MathlinearprogEdge) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogEdge::scale(self : MathlinearprogEdge, f : Double) -> MathlinearprogEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogEdge::add(self : MathlinearprogEdge, other : MathlinearprogEdge) -> MathlinearprogEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogEdge::copy(self : MathlinearprogEdge) -> MathlinearprogEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogEdge::fill(self : MathlinearprogEdge, v : Double) -> MathlinearprogEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogEdge::min(self : MathlinearprogEdge) -> Double { @_common.min(self.data) }

pub fn MathlinearprogEdge::max(self : MathlinearprogEdge) -> Double { @_common.max(self.data) }

pub fn MathlinearprogEdge::to_string(self : MathlinearprogEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_path_make(size : Int) -> MathlinearprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogPath::len(self : MathlinearprogPath) -> Int { self.size }

pub fn MathlinearprogPath::get(self : MathlinearprogPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogPath::set(self : MathlinearprogPath, i : Int, v : Double) -> MathlinearprogPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogPath::sum(self : MathlinearprogPath) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogPath::mean(self : MathlinearprogPath) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogPath::scale(self : MathlinearprogPath, f : Double) -> MathlinearprogPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogPath::add(self : MathlinearprogPath, other : MathlinearprogPath) -> MathlinearprogPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogPath::copy(self : MathlinearprogPath) -> MathlinearprogPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogPath::fill(self : MathlinearprogPath, v : Double) -> MathlinearprogPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogPath::min(self : MathlinearprogPath) -> Double { @_common.min(self.data) }

pub fn MathlinearprogPath::max(self : MathlinearprogPath) -> Double { @_common.max(self.data) }

pub fn MathlinearprogPath::to_string(self : MathlinearprogPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_cluster_make(size : Int) -> MathlinearprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogCluster::len(self : MathlinearprogCluster) -> Int { self.size }

pub fn MathlinearprogCluster::get(self : MathlinearprogCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogCluster::set(self : MathlinearprogCluster, i : Int, v : Double) -> MathlinearprogCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogCluster::sum(self : MathlinearprogCluster) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogCluster::mean(self : MathlinearprogCluster) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogCluster::scale(self : MathlinearprogCluster, f : Double) -> MathlinearprogCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogCluster::add(self : MathlinearprogCluster, other : MathlinearprogCluster) -> MathlinearprogCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogCluster::copy(self : MathlinearprogCluster) -> MathlinearprogCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogCluster::fill(self : MathlinearprogCluster, v : Double) -> MathlinearprogCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogCluster::min(self : MathlinearprogCluster) -> Double { @_common.min(self.data) }

pub fn MathlinearprogCluster::max(self : MathlinearprogCluster) -> Double { @_common.max(self.data) }

pub fn MathlinearprogCluster::to_string(self : MathlinearprogCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_model_make(size : Int) -> MathlinearprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogModel::len(self : MathlinearprogModel) -> Int { self.size }

pub fn MathlinearprogModel::get(self : MathlinearprogModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogModel::set(self : MathlinearprogModel, i : Int, v : Double) -> MathlinearprogModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogModel::sum(self : MathlinearprogModel) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogModel::mean(self : MathlinearprogModel) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogModel::scale(self : MathlinearprogModel, f : Double) -> MathlinearprogModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogModel::add(self : MathlinearprogModel, other : MathlinearprogModel) -> MathlinearprogModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogModel::copy(self : MathlinearprogModel) -> MathlinearprogModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogModel::fill(self : MathlinearprogModel, v : Double) -> MathlinearprogModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogModel::min(self : MathlinearprogModel) -> Double { @_common.min(self.data) }

pub fn MathlinearprogModel::max(self : MathlinearprogModel) -> Double { @_common.max(self.data) }

pub fn MathlinearprogModel::to_string(self : MathlinearprogModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_layer_make(size : Int) -> MathlinearprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogLayer::len(self : MathlinearprogLayer) -> Int { self.size }

pub fn MathlinearprogLayer::get(self : MathlinearprogLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogLayer::set(self : MathlinearprogLayer, i : Int, v : Double) -> MathlinearprogLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogLayer::sum(self : MathlinearprogLayer) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogLayer::mean(self : MathlinearprogLayer) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogLayer::scale(self : MathlinearprogLayer, f : Double) -> MathlinearprogLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogLayer::add(self : MathlinearprogLayer, other : MathlinearprogLayer) -> MathlinearprogLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogLayer::copy(self : MathlinearprogLayer) -> MathlinearprogLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogLayer::fill(self : MathlinearprogLayer, v : Double) -> MathlinearprogLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogLayer::min(self : MathlinearprogLayer) -> Double { @_common.min(self.data) }

pub fn MathlinearprogLayer::max(self : MathlinearprogLayer) -> Double { @_common.max(self.data) }

pub fn MathlinearprogLayer::to_string(self : MathlinearprogLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_buffer_make(size : Int) -> MathlinearprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogBuffer::len(self : MathlinearprogBuffer) -> Int { self.size }

pub fn MathlinearprogBuffer::get(self : MathlinearprogBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogBuffer::set(self : MathlinearprogBuffer, i : Int, v : Double) -> MathlinearprogBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogBuffer::sum(self : MathlinearprogBuffer) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogBuffer::mean(self : MathlinearprogBuffer) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogBuffer::scale(self : MathlinearprogBuffer, f : Double) -> MathlinearprogBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogBuffer::add(self : MathlinearprogBuffer, other : MathlinearprogBuffer) -> MathlinearprogBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogBuffer::copy(self : MathlinearprogBuffer) -> MathlinearprogBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogBuffer::fill(self : MathlinearprogBuffer, v : Double) -> MathlinearprogBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogBuffer::min(self : MathlinearprogBuffer) -> Double { @_common.min(self.data) }

pub fn MathlinearprogBuffer::max(self : MathlinearprogBuffer) -> Double { @_common.max(self.data) }

pub fn MathlinearprogBuffer::to_string(self : MathlinearprogBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_cursor_make(size : Int) -> MathlinearprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogCursor::len(self : MathlinearprogCursor) -> Int { self.size }

pub fn MathlinearprogCursor::get(self : MathlinearprogCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogCursor::set(self : MathlinearprogCursor, i : Int, v : Double) -> MathlinearprogCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogCursor::sum(self : MathlinearprogCursor) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogCursor::mean(self : MathlinearprogCursor) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogCursor::scale(self : MathlinearprogCursor, f : Double) -> MathlinearprogCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogCursor::add(self : MathlinearprogCursor, other : MathlinearprogCursor) -> MathlinearprogCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogCursor::copy(self : MathlinearprogCursor) -> MathlinearprogCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogCursor::fill(self : MathlinearprogCursor, v : Double) -> MathlinearprogCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogCursor::min(self : MathlinearprogCursor) -> Double { @_common.min(self.data) }

pub fn MathlinearprogCursor::max(self : MathlinearprogCursor) -> Double { @_common.max(self.data) }

pub fn MathlinearprogCursor::to_string(self : MathlinearprogCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_view_make(size : Int) -> MathlinearprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogView::len(self : MathlinearprogView) -> Int { self.size }

pub fn MathlinearprogView::get(self : MathlinearprogView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogView::set(self : MathlinearprogView, i : Int, v : Double) -> MathlinearprogView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogView::sum(self : MathlinearprogView) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogView::mean(self : MathlinearprogView) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogView::scale(self : MathlinearprogView, f : Double) -> MathlinearprogView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogView::add(self : MathlinearprogView, other : MathlinearprogView) -> MathlinearprogView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogView::copy(self : MathlinearprogView) -> MathlinearprogView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogView::fill(self : MathlinearprogView, v : Double) -> MathlinearprogView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogView::min(self : MathlinearprogView) -> Double { @_common.min(self.data) }

pub fn MathlinearprogView::max(self : MathlinearprogView) -> Double { @_common.max(self.data) }

pub fn MathlinearprogView::to_string(self : MathlinearprogView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_range_make(size : Int) -> MathlinearprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogRange::len(self : MathlinearprogRange) -> Int { self.size }

pub fn MathlinearprogRange::get(self : MathlinearprogRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogRange::set(self : MathlinearprogRange, i : Int, v : Double) -> MathlinearprogRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogRange::sum(self : MathlinearprogRange) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogRange::mean(self : MathlinearprogRange) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogRange::scale(self : MathlinearprogRange, f : Double) -> MathlinearprogRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogRange::add(self : MathlinearprogRange, other : MathlinearprogRange) -> MathlinearprogRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogRange::copy(self : MathlinearprogRange) -> MathlinearprogRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogRange::fill(self : MathlinearprogRange, v : Double) -> MathlinearprogRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogRange::min(self : MathlinearprogRange) -> Double { @_common.min(self.data) }

pub fn MathlinearprogRange::max(self : MathlinearprogRange) -> Double { @_common.max(self.data) }

pub fn MathlinearprogRange::to_string(self : MathlinearprogRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathlinearprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_slice_make(size : Int) -> MathlinearprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathlinearprogSlice::len(self : MathlinearprogSlice) -> Int { self.size }

pub fn MathlinearprogSlice::get(self : MathlinearprogSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathlinearprogSlice::set(self : MathlinearprogSlice, i : Int, v : Double) -> MathlinearprogSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathlinearprogSlice::sum(self : MathlinearprogSlice) -> Double { @_common.sum(self.data) }

pub fn MathlinearprogSlice::mean(self : MathlinearprogSlice) -> Double { @_common.mean(self.data) }

pub fn MathlinearprogSlice::scale(self : MathlinearprogSlice, f : Double) -> MathlinearprogSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathlinearprogSlice::add(self : MathlinearprogSlice, other : MathlinearprogSlice) -> MathlinearprogSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathlinearprogSlice::copy(self : MathlinearprogSlice) -> MathlinearprogSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathlinearprogSlice::fill(self : MathlinearprogSlice, v : Double) -> MathlinearprogSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathlinearprogSlice::min(self : MathlinearprogSlice) -> Double { @_common.min(self.data) }

pub fn MathlinearprogSlice::max(self : MathlinearprogSlice) -> Double { @_common.max(self.data) }

pub fn MathlinearprogSlice::to_string(self : MathlinearprogSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

