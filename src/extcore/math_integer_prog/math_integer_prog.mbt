///===
/// extcore/math_integer_prog

pub(all) struct MathintegerprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_integer_prog_make_point(x : Double, y : Double) -> MathintegerprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_integer_prog_make_point3(x : Double, y : Double, z : Double) -> MathintegerprogPoint {
  { x, y, z, label: 0 }
}

pub fn MathintegerprogPoint::x(self : MathintegerprogPoint) -> Double { self.x }

pub fn MathintegerprogPoint::y(self : MathintegerprogPoint) -> Double { self.y }

pub fn MathintegerprogPoint::z(self : MathintegerprogPoint) -> Double { self.z }

pub fn MathintegerprogPoint::label(self : MathintegerprogPoint) -> Int { self.label }

pub fn MathintegerprogPoint::dist(self : MathintegerprogPoint, other : MathintegerprogPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathintegerprogPoint::add(self : MathintegerprogPoint, other : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathintegerprogPoint::sub(self : MathintegerprogPoint, other : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathintegerprogPoint::scale(self : MathintegerprogPoint, s : Double) -> MathintegerprogPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathintegerprogPoint::dot(self : MathintegerprogPoint, other : MathintegerprogPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathintegerprogPoint::cross(self : MathintegerprogPoint, other : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathintegerprogPoint::norm(self : MathintegerprogPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathintegerprogPoint::normalize(self : MathintegerprogPoint) -> MathintegerprogPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathintegerprogPoint::negate(self : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathintegerprogPoint::mid(self : MathintegerprogPoint, other : MathintegerprogPoint) -> MathintegerprogPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathintegerprogPoint::lerp(self : MathintegerprogPoint, other : MathintegerprogPoint, t : Double) -> MathintegerprogPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathintegerprogPoint::to_string(self : MathintegerprogPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathintegerprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_integer_prog_make_series(vals : Array[Double], name : String) -> MathintegerprogSeries {
  { vals, name, meta: 0 }
}

pub fn MathintegerprogSeries::len(self : MathintegerprogSeries) -> Int { self.vals.length() }

pub fn MathintegerprogSeries::sum(self : MathintegerprogSeries) -> Double { @_common.sum(self.vals) }

pub fn MathintegerprogSeries::mean(self : MathintegerprogSeries) -> Double { @_common.mean(self.vals) }

pub fn MathintegerprogSeries::min(self : MathintegerprogSeries) -> Double { @_common.min(self.vals) }

pub fn MathintegerprogSeries::max(self : MathintegerprogSeries) -> Double { @_common.max(self.vals) }

pub fn MathintegerprogSeries::range(self : MathintegerprogSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathintegerprogSeries::variance(self : MathintegerprogSeries) -> Double { @_common.variance(self.vals) }

pub fn MathintegerprogSeries::std(self : MathintegerprogSeries) -> Double { @_common.std(self.vals) }

pub fn MathintegerprogSeries::median(self : MathintegerprogSeries) -> Double { @_common.median(self.vals) }

pub fn MathintegerprogSeries::scale(self : MathintegerprogSeries, f : Double) -> MathintegerprogSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathintegerprogSeries::add(self : MathintegerprogSeries, other : MathintegerprogSeries) -> MathintegerprogSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathintegerprogSeries::sub(self : MathintegerprogSeries, other : MathintegerprogSeries) -> MathintegerprogSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathintegerprogSeries::normalize(self : MathintegerprogSeries) -> MathintegerprogSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathintegerprogSeries::cumsum(self : MathintegerprogSeries) -> MathintegerprogSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathintegerprogSeries::to_string(self : MathintegerprogSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathintegerprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_integer_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathintegerprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_integer_prog_matrix_identity(n : Int) -> MathintegerprogMatrix {
  let m = math_integer_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathintegerprogMatrix::get(self : MathintegerprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathintegerprogMatrix::transpose(self : MathintegerprogMatrix) -> MathintegerprogMatrix {
  let result = math_integer_prog_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathintegerprogMatrix::add(self : MathintegerprogMatrix, other : MathintegerprogMatrix) -> MathintegerprogMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_integer_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathintegerprogMatrix::scale(self : MathintegerprogMatrix, s : Double) -> MathintegerprogMatrix {
  let result = math_integer_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathintegerprogMatrix::multiply(self : MathintegerprogMatrix, other : MathintegerprogMatrix) -> MathintegerprogMatrix {
  if self.cols != other.rows { return math_integer_prog_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_integer_prog_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathintegerprogMatrix::trace(self : MathintegerprogMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathintegerprogMatrix::det(self : MathintegerprogMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathintegerprogMatrix::norm(self : MathintegerprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathintegerprogMatrix::to_string(self : MathintegerprogMatrix) -> String {
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

pub(all) struct MathintegerprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_integer_prog_make_vector(comps : Array[Double]) -> MathintegerprogVector {
  { comps, dim: comps.length() }
}

pub fn math_integer_prog_vector_zero(dim : Int) -> MathintegerprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathintegerprogVector::add(self : MathintegerprogVector, other : MathintegerprogVector) -> MathintegerprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathintegerprogVector::sub(self : MathintegerprogVector, other : MathintegerprogVector) -> MathintegerprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathintegerprogVector::scale(self : MathintegerprogVector, s : Double) -> MathintegerprogVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathintegerprogVector::dot(self : MathintegerprogVector, other : MathintegerprogVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathintegerprogVector::norm(self : MathintegerprogVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathintegerprogVector::normalize(self : MathintegerprogVector) -> MathintegerprogVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathintegerprogVector::dist(self : MathintegerprogVector, other : MathintegerprogVector) -> Double {
  self.sub(other).norm()
}

pub fn MathintegerprogVector::to_string(self : MathintegerprogVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathintegerprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_frame_make(size : Int) -> MathintegerprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogFrame::len(self : MathintegerprogFrame) -> Int { self.size }

pub fn MathintegerprogFrame::get(self : MathintegerprogFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogFrame::set(self : MathintegerprogFrame, i : Int, v : Double) -> MathintegerprogFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogFrame::sum(self : MathintegerprogFrame) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogFrame::mean(self : MathintegerprogFrame) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogFrame::scale(self : MathintegerprogFrame, f : Double) -> MathintegerprogFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogFrame::add(self : MathintegerprogFrame, other : MathintegerprogFrame) -> MathintegerprogFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogFrame::copy(self : MathintegerprogFrame) -> MathintegerprogFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogFrame::fill(self : MathintegerprogFrame, v : Double) -> MathintegerprogFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogFrame::min(self : MathintegerprogFrame) -> Double { @_common.min(self.data) }

pub fn MathintegerprogFrame::max(self : MathintegerprogFrame) -> Double { @_common.max(self.data) }

pub fn MathintegerprogFrame::to_string(self : MathintegerprogFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_table_make(size : Int) -> MathintegerprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogTable::len(self : MathintegerprogTable) -> Int { self.size }

pub fn MathintegerprogTable::get(self : MathintegerprogTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogTable::set(self : MathintegerprogTable, i : Int, v : Double) -> MathintegerprogTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogTable::sum(self : MathintegerprogTable) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogTable::mean(self : MathintegerprogTable) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogTable::scale(self : MathintegerprogTable, f : Double) -> MathintegerprogTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogTable::add(self : MathintegerprogTable, other : MathintegerprogTable) -> MathintegerprogTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogTable::copy(self : MathintegerprogTable) -> MathintegerprogTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogTable::fill(self : MathintegerprogTable, v : Double) -> MathintegerprogTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogTable::min(self : MathintegerprogTable) -> Double { @_common.min(self.data) }

pub fn MathintegerprogTable::max(self : MathintegerprogTable) -> Double { @_common.max(self.data) }

pub fn MathintegerprogTable::to_string(self : MathintegerprogTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_graphn_make(size : Int) -> MathintegerprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogGraphN::len(self : MathintegerprogGraphN) -> Int { self.size }

pub fn MathintegerprogGraphN::get(self : MathintegerprogGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogGraphN::set(self : MathintegerprogGraphN, i : Int, v : Double) -> MathintegerprogGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogGraphN::sum(self : MathintegerprogGraphN) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogGraphN::mean(self : MathintegerprogGraphN) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogGraphN::scale(self : MathintegerprogGraphN, f : Double) -> MathintegerprogGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogGraphN::add(self : MathintegerprogGraphN, other : MathintegerprogGraphN) -> MathintegerprogGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogGraphN::copy(self : MathintegerprogGraphN) -> MathintegerprogGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogGraphN::fill(self : MathintegerprogGraphN, v : Double) -> MathintegerprogGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogGraphN::min(self : MathintegerprogGraphN) -> Double { @_common.min(self.data) }

pub fn MathintegerprogGraphN::max(self : MathintegerprogGraphN) -> Double { @_common.max(self.data) }

pub fn MathintegerprogGraphN::to_string(self : MathintegerprogGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_node_make(size : Int) -> MathintegerprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogNode::len(self : MathintegerprogNode) -> Int { self.size }

pub fn MathintegerprogNode::get(self : MathintegerprogNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogNode::set(self : MathintegerprogNode, i : Int, v : Double) -> MathintegerprogNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogNode::sum(self : MathintegerprogNode) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogNode::mean(self : MathintegerprogNode) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogNode::scale(self : MathintegerprogNode, f : Double) -> MathintegerprogNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogNode::add(self : MathintegerprogNode, other : MathintegerprogNode) -> MathintegerprogNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogNode::copy(self : MathintegerprogNode) -> MathintegerprogNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogNode::fill(self : MathintegerprogNode, v : Double) -> MathintegerprogNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogNode::min(self : MathintegerprogNode) -> Double { @_common.min(self.data) }

pub fn MathintegerprogNode::max(self : MathintegerprogNode) -> Double { @_common.max(self.data) }

pub fn MathintegerprogNode::to_string(self : MathintegerprogNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_edge_make(size : Int) -> MathintegerprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogEdge::len(self : MathintegerprogEdge) -> Int { self.size }

pub fn MathintegerprogEdge::get(self : MathintegerprogEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogEdge::set(self : MathintegerprogEdge, i : Int, v : Double) -> MathintegerprogEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogEdge::sum(self : MathintegerprogEdge) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogEdge::mean(self : MathintegerprogEdge) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogEdge::scale(self : MathintegerprogEdge, f : Double) -> MathintegerprogEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogEdge::add(self : MathintegerprogEdge, other : MathintegerprogEdge) -> MathintegerprogEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogEdge::copy(self : MathintegerprogEdge) -> MathintegerprogEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogEdge::fill(self : MathintegerprogEdge, v : Double) -> MathintegerprogEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogEdge::min(self : MathintegerprogEdge) -> Double { @_common.min(self.data) }

pub fn MathintegerprogEdge::max(self : MathintegerprogEdge) -> Double { @_common.max(self.data) }

pub fn MathintegerprogEdge::to_string(self : MathintegerprogEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_path_make(size : Int) -> MathintegerprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogPath::len(self : MathintegerprogPath) -> Int { self.size }

pub fn MathintegerprogPath::get(self : MathintegerprogPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogPath::set(self : MathintegerprogPath, i : Int, v : Double) -> MathintegerprogPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogPath::sum(self : MathintegerprogPath) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogPath::mean(self : MathintegerprogPath) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogPath::scale(self : MathintegerprogPath, f : Double) -> MathintegerprogPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogPath::add(self : MathintegerprogPath, other : MathintegerprogPath) -> MathintegerprogPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogPath::copy(self : MathintegerprogPath) -> MathintegerprogPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogPath::fill(self : MathintegerprogPath, v : Double) -> MathintegerprogPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogPath::min(self : MathintegerprogPath) -> Double { @_common.min(self.data) }

pub fn MathintegerprogPath::max(self : MathintegerprogPath) -> Double { @_common.max(self.data) }

pub fn MathintegerprogPath::to_string(self : MathintegerprogPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_cluster_make(size : Int) -> MathintegerprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogCluster::len(self : MathintegerprogCluster) -> Int { self.size }

pub fn MathintegerprogCluster::get(self : MathintegerprogCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogCluster::set(self : MathintegerprogCluster, i : Int, v : Double) -> MathintegerprogCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogCluster::sum(self : MathintegerprogCluster) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogCluster::mean(self : MathintegerprogCluster) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogCluster::scale(self : MathintegerprogCluster, f : Double) -> MathintegerprogCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogCluster::add(self : MathintegerprogCluster, other : MathintegerprogCluster) -> MathintegerprogCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogCluster::copy(self : MathintegerprogCluster) -> MathintegerprogCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogCluster::fill(self : MathintegerprogCluster, v : Double) -> MathintegerprogCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogCluster::min(self : MathintegerprogCluster) -> Double { @_common.min(self.data) }

pub fn MathintegerprogCluster::max(self : MathintegerprogCluster) -> Double { @_common.max(self.data) }

pub fn MathintegerprogCluster::to_string(self : MathintegerprogCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_model_make(size : Int) -> MathintegerprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogModel::len(self : MathintegerprogModel) -> Int { self.size }

pub fn MathintegerprogModel::get(self : MathintegerprogModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogModel::set(self : MathintegerprogModel, i : Int, v : Double) -> MathintegerprogModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogModel::sum(self : MathintegerprogModel) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogModel::mean(self : MathintegerprogModel) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogModel::scale(self : MathintegerprogModel, f : Double) -> MathintegerprogModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogModel::add(self : MathintegerprogModel, other : MathintegerprogModel) -> MathintegerprogModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogModel::copy(self : MathintegerprogModel) -> MathintegerprogModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogModel::fill(self : MathintegerprogModel, v : Double) -> MathintegerprogModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogModel::min(self : MathintegerprogModel) -> Double { @_common.min(self.data) }

pub fn MathintegerprogModel::max(self : MathintegerprogModel) -> Double { @_common.max(self.data) }

pub fn MathintegerprogModel::to_string(self : MathintegerprogModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_layer_make(size : Int) -> MathintegerprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogLayer::len(self : MathintegerprogLayer) -> Int { self.size }

pub fn MathintegerprogLayer::get(self : MathintegerprogLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogLayer::set(self : MathintegerprogLayer, i : Int, v : Double) -> MathintegerprogLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogLayer::sum(self : MathintegerprogLayer) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogLayer::mean(self : MathintegerprogLayer) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogLayer::scale(self : MathintegerprogLayer, f : Double) -> MathintegerprogLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogLayer::add(self : MathintegerprogLayer, other : MathintegerprogLayer) -> MathintegerprogLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogLayer::copy(self : MathintegerprogLayer) -> MathintegerprogLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogLayer::fill(self : MathintegerprogLayer, v : Double) -> MathintegerprogLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogLayer::min(self : MathintegerprogLayer) -> Double { @_common.min(self.data) }

pub fn MathintegerprogLayer::max(self : MathintegerprogLayer) -> Double { @_common.max(self.data) }

pub fn MathintegerprogLayer::to_string(self : MathintegerprogLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_buffer_make(size : Int) -> MathintegerprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogBuffer::len(self : MathintegerprogBuffer) -> Int { self.size }

pub fn MathintegerprogBuffer::get(self : MathintegerprogBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogBuffer::set(self : MathintegerprogBuffer, i : Int, v : Double) -> MathintegerprogBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogBuffer::sum(self : MathintegerprogBuffer) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogBuffer::mean(self : MathintegerprogBuffer) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogBuffer::scale(self : MathintegerprogBuffer, f : Double) -> MathintegerprogBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogBuffer::add(self : MathintegerprogBuffer, other : MathintegerprogBuffer) -> MathintegerprogBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogBuffer::copy(self : MathintegerprogBuffer) -> MathintegerprogBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogBuffer::fill(self : MathintegerprogBuffer, v : Double) -> MathintegerprogBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogBuffer::min(self : MathintegerprogBuffer) -> Double { @_common.min(self.data) }

pub fn MathintegerprogBuffer::max(self : MathintegerprogBuffer) -> Double { @_common.max(self.data) }

pub fn MathintegerprogBuffer::to_string(self : MathintegerprogBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_cursor_make(size : Int) -> MathintegerprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogCursor::len(self : MathintegerprogCursor) -> Int { self.size }

pub fn MathintegerprogCursor::get(self : MathintegerprogCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogCursor::set(self : MathintegerprogCursor, i : Int, v : Double) -> MathintegerprogCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogCursor::sum(self : MathintegerprogCursor) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogCursor::mean(self : MathintegerprogCursor) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogCursor::scale(self : MathintegerprogCursor, f : Double) -> MathintegerprogCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogCursor::add(self : MathintegerprogCursor, other : MathintegerprogCursor) -> MathintegerprogCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogCursor::copy(self : MathintegerprogCursor) -> MathintegerprogCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogCursor::fill(self : MathintegerprogCursor, v : Double) -> MathintegerprogCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogCursor::min(self : MathintegerprogCursor) -> Double { @_common.min(self.data) }

pub fn MathintegerprogCursor::max(self : MathintegerprogCursor) -> Double { @_common.max(self.data) }

pub fn MathintegerprogCursor::to_string(self : MathintegerprogCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_view_make(size : Int) -> MathintegerprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogView::len(self : MathintegerprogView) -> Int { self.size }

pub fn MathintegerprogView::get(self : MathintegerprogView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogView::set(self : MathintegerprogView, i : Int, v : Double) -> MathintegerprogView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogView::sum(self : MathintegerprogView) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogView::mean(self : MathintegerprogView) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogView::scale(self : MathintegerprogView, f : Double) -> MathintegerprogView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogView::add(self : MathintegerprogView, other : MathintegerprogView) -> MathintegerprogView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogView::copy(self : MathintegerprogView) -> MathintegerprogView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogView::fill(self : MathintegerprogView, v : Double) -> MathintegerprogView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogView::min(self : MathintegerprogView) -> Double { @_common.min(self.data) }

pub fn MathintegerprogView::max(self : MathintegerprogView) -> Double { @_common.max(self.data) }

pub fn MathintegerprogView::to_string(self : MathintegerprogView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_range_make(size : Int) -> MathintegerprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogRange::len(self : MathintegerprogRange) -> Int { self.size }

pub fn MathintegerprogRange::get(self : MathintegerprogRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogRange::set(self : MathintegerprogRange, i : Int, v : Double) -> MathintegerprogRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogRange::sum(self : MathintegerprogRange) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogRange::mean(self : MathintegerprogRange) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogRange::scale(self : MathintegerprogRange, f : Double) -> MathintegerprogRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogRange::add(self : MathintegerprogRange, other : MathintegerprogRange) -> MathintegerprogRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogRange::copy(self : MathintegerprogRange) -> MathintegerprogRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogRange::fill(self : MathintegerprogRange, v : Double) -> MathintegerprogRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogRange::min(self : MathintegerprogRange) -> Double { @_common.min(self.data) }

pub fn MathintegerprogRange::max(self : MathintegerprogRange) -> Double { @_common.max(self.data) }

pub fn MathintegerprogRange::to_string(self : MathintegerprogRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathintegerprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_integer_prog_slice_make(size : Int) -> MathintegerprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathintegerprogSlice::len(self : MathintegerprogSlice) -> Int { self.size }

pub fn MathintegerprogSlice::get(self : MathintegerprogSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathintegerprogSlice::set(self : MathintegerprogSlice, i : Int, v : Double) -> MathintegerprogSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathintegerprogSlice::sum(self : MathintegerprogSlice) -> Double { @_common.sum(self.data) }

pub fn MathintegerprogSlice::mean(self : MathintegerprogSlice) -> Double { @_common.mean(self.data) }

pub fn MathintegerprogSlice::scale(self : MathintegerprogSlice, f : Double) -> MathintegerprogSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathintegerprogSlice::add(self : MathintegerprogSlice, other : MathintegerprogSlice) -> MathintegerprogSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathintegerprogSlice::copy(self : MathintegerprogSlice) -> MathintegerprogSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathintegerprogSlice::fill(self : MathintegerprogSlice, v : Double) -> MathintegerprogSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathintegerprogSlice::min(self : MathintegerprogSlice) -> Double { @_common.min(self.data) }

pub fn MathintegerprogSlice::max(self : MathintegerprogSlice) -> Double { @_common.max(self.data) }

pub fn MathintegerprogSlice::to_string(self : MathintegerprogSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

