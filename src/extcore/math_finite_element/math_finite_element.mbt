///===
/// extcore/math_finite_element

pub(all) struct MathfiniteelementPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_finite_element_make_point(x : Double, y : Double) -> MathfiniteelementPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_finite_element_make_point3(x : Double, y : Double, z : Double) -> MathfiniteelementPoint {
  { x, y, z, label: 0 }
}

pub fn MathfiniteelementPoint::x(self : MathfiniteelementPoint) -> Double { self.x }

pub fn MathfiniteelementPoint::y(self : MathfiniteelementPoint) -> Double { self.y }

pub fn MathfiniteelementPoint::z(self : MathfiniteelementPoint) -> Double { self.z }

pub fn MathfiniteelementPoint::label(self : MathfiniteelementPoint) -> Int { self.label }

pub fn MathfiniteelementPoint::dist(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathfiniteelementPoint::add(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathfiniteelementPoint::sub(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathfiniteelementPoint::scale(self : MathfiniteelementPoint, s : Double) -> MathfiniteelementPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathfiniteelementPoint::dot(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathfiniteelementPoint::cross(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathfiniteelementPoint::norm(self : MathfiniteelementPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathfiniteelementPoint::normalize(self : MathfiniteelementPoint) -> MathfiniteelementPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathfiniteelementPoint::negate(self : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathfiniteelementPoint::mid(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathfiniteelementPoint::lerp(self : MathfiniteelementPoint, other : MathfiniteelementPoint, t : Double) -> MathfiniteelementPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathfiniteelementPoint::to_string(self : MathfiniteelementPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathfiniteelementSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_finite_element_make_series(vals : Array[Double], name : String) -> MathfiniteelementSeries {
  { vals, name, meta: 0 }
}

pub fn MathfiniteelementSeries::len(self : MathfiniteelementSeries) -> Int { self.vals.length() }

pub fn MathfiniteelementSeries::sum(self : MathfiniteelementSeries) -> Double { @_common.sum(self.vals) }

pub fn MathfiniteelementSeries::mean(self : MathfiniteelementSeries) -> Double { @_common.mean(self.vals) }

pub fn MathfiniteelementSeries::min(self : MathfiniteelementSeries) -> Double { @_common.min(self.vals) }

pub fn MathfiniteelementSeries::max(self : MathfiniteelementSeries) -> Double { @_common.max(self.vals) }

pub fn MathfiniteelementSeries::range(self : MathfiniteelementSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathfiniteelementSeries::variance(self : MathfiniteelementSeries) -> Double { @_common.variance(self.vals) }

pub fn MathfiniteelementSeries::std(self : MathfiniteelementSeries) -> Double { @_common.std(self.vals) }

pub fn MathfiniteelementSeries::median(self : MathfiniteelementSeries) -> Double { @_common.median(self.vals) }

pub fn MathfiniteelementSeries::scale(self : MathfiniteelementSeries, f : Double) -> MathfiniteelementSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathfiniteelementSeries::add(self : MathfiniteelementSeries, other : MathfiniteelementSeries) -> MathfiniteelementSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathfiniteelementSeries::sub(self : MathfiniteelementSeries, other : MathfiniteelementSeries) -> MathfiniteelementSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathfiniteelementSeries::normalize(self : MathfiniteelementSeries) -> MathfiniteelementSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathfiniteelementSeries::cumsum(self : MathfiniteelementSeries) -> MathfiniteelementSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathfiniteelementSeries::to_string(self : MathfiniteelementSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathfiniteelementMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_finite_element_make_matrix(rows : Int, cols : Int, val : Double) -> MathfiniteelementMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_finite_element_matrix_identity(n : Int) -> MathfiniteelementMatrix {
  let m = math_finite_element_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathfiniteelementMatrix::get(self : MathfiniteelementMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathfiniteelementMatrix::transpose(self : MathfiniteelementMatrix) -> MathfiniteelementMatrix {
  let result = math_finite_element_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathfiniteelementMatrix::add(self : MathfiniteelementMatrix, other : MathfiniteelementMatrix) -> MathfiniteelementMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_finite_element_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathfiniteelementMatrix::scale(self : MathfiniteelementMatrix, s : Double) -> MathfiniteelementMatrix {
  let result = math_finite_element_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathfiniteelementMatrix::multiply(self : MathfiniteelementMatrix, other : MathfiniteelementMatrix) -> MathfiniteelementMatrix {
  if self.cols != other.rows { return math_finite_element_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_finite_element_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathfiniteelementMatrix::trace(self : MathfiniteelementMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathfiniteelementMatrix::det(self : MathfiniteelementMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathfiniteelementMatrix::norm(self : MathfiniteelementMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathfiniteelementMatrix::to_string(self : MathfiniteelementMatrix) -> String {
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

pub(all) struct MathfiniteelementVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_finite_element_make_vector(comps : Array[Double]) -> MathfiniteelementVector {
  { comps, dim: comps.length() }
}

pub fn math_finite_element_vector_zero(dim : Int) -> MathfiniteelementVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathfiniteelementVector::add(self : MathfiniteelementVector, other : MathfiniteelementVector) -> MathfiniteelementVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathfiniteelementVector::sub(self : MathfiniteelementVector, other : MathfiniteelementVector) -> MathfiniteelementVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathfiniteelementVector::scale(self : MathfiniteelementVector, s : Double) -> MathfiniteelementVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathfiniteelementVector::dot(self : MathfiniteelementVector, other : MathfiniteelementVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathfiniteelementVector::norm(self : MathfiniteelementVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathfiniteelementVector::normalize(self : MathfiniteelementVector) -> MathfiniteelementVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathfiniteelementVector::dist(self : MathfiniteelementVector, other : MathfiniteelementVector) -> Double {
  self.sub(other).norm()
}

pub fn MathfiniteelementVector::to_string(self : MathfiniteelementVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathfiniteelementFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_frame_make(size : Int) -> MathfiniteelementFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementFrame::len(self : MathfiniteelementFrame) -> Int { self.size }

pub fn MathfiniteelementFrame::get(self : MathfiniteelementFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementFrame::set(self : MathfiniteelementFrame, i : Int, v : Double) -> MathfiniteelementFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementFrame::sum(self : MathfiniteelementFrame) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementFrame::mean(self : MathfiniteelementFrame) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementFrame::scale(self : MathfiniteelementFrame, f : Double) -> MathfiniteelementFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementFrame::add(self : MathfiniteelementFrame, other : MathfiniteelementFrame) -> MathfiniteelementFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementFrame::copy(self : MathfiniteelementFrame) -> MathfiniteelementFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementFrame::fill(self : MathfiniteelementFrame, v : Double) -> MathfiniteelementFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementFrame::min(self : MathfiniteelementFrame) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementFrame::max(self : MathfiniteelementFrame) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementFrame::to_string(self : MathfiniteelementFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_table_make(size : Int) -> MathfiniteelementTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementTable::len(self : MathfiniteelementTable) -> Int { self.size }

pub fn MathfiniteelementTable::get(self : MathfiniteelementTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementTable::set(self : MathfiniteelementTable, i : Int, v : Double) -> MathfiniteelementTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementTable::sum(self : MathfiniteelementTable) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementTable::mean(self : MathfiniteelementTable) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementTable::scale(self : MathfiniteelementTable, f : Double) -> MathfiniteelementTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementTable::add(self : MathfiniteelementTable, other : MathfiniteelementTable) -> MathfiniteelementTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementTable::copy(self : MathfiniteelementTable) -> MathfiniteelementTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementTable::fill(self : MathfiniteelementTable, v : Double) -> MathfiniteelementTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementTable::min(self : MathfiniteelementTable) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementTable::max(self : MathfiniteelementTable) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementTable::to_string(self : MathfiniteelementTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_graphn_make(size : Int) -> MathfiniteelementGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementGraphN::len(self : MathfiniteelementGraphN) -> Int { self.size }

pub fn MathfiniteelementGraphN::get(self : MathfiniteelementGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementGraphN::set(self : MathfiniteelementGraphN, i : Int, v : Double) -> MathfiniteelementGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementGraphN::sum(self : MathfiniteelementGraphN) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementGraphN::mean(self : MathfiniteelementGraphN) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementGraphN::scale(self : MathfiniteelementGraphN, f : Double) -> MathfiniteelementGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementGraphN::add(self : MathfiniteelementGraphN, other : MathfiniteelementGraphN) -> MathfiniteelementGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementGraphN::copy(self : MathfiniteelementGraphN) -> MathfiniteelementGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementGraphN::fill(self : MathfiniteelementGraphN, v : Double) -> MathfiniteelementGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementGraphN::min(self : MathfiniteelementGraphN) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementGraphN::max(self : MathfiniteelementGraphN) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementGraphN::to_string(self : MathfiniteelementGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_node_make(size : Int) -> MathfiniteelementNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementNode::len(self : MathfiniteelementNode) -> Int { self.size }

pub fn MathfiniteelementNode::get(self : MathfiniteelementNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementNode::set(self : MathfiniteelementNode, i : Int, v : Double) -> MathfiniteelementNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementNode::sum(self : MathfiniteelementNode) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementNode::mean(self : MathfiniteelementNode) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementNode::scale(self : MathfiniteelementNode, f : Double) -> MathfiniteelementNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementNode::add(self : MathfiniteelementNode, other : MathfiniteelementNode) -> MathfiniteelementNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementNode::copy(self : MathfiniteelementNode) -> MathfiniteelementNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementNode::fill(self : MathfiniteelementNode, v : Double) -> MathfiniteelementNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementNode::min(self : MathfiniteelementNode) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementNode::max(self : MathfiniteelementNode) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementNode::to_string(self : MathfiniteelementNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_edge_make(size : Int) -> MathfiniteelementEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementEdge::len(self : MathfiniteelementEdge) -> Int { self.size }

pub fn MathfiniteelementEdge::get(self : MathfiniteelementEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementEdge::set(self : MathfiniteelementEdge, i : Int, v : Double) -> MathfiniteelementEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementEdge::sum(self : MathfiniteelementEdge) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementEdge::mean(self : MathfiniteelementEdge) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementEdge::scale(self : MathfiniteelementEdge, f : Double) -> MathfiniteelementEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementEdge::add(self : MathfiniteelementEdge, other : MathfiniteelementEdge) -> MathfiniteelementEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementEdge::copy(self : MathfiniteelementEdge) -> MathfiniteelementEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementEdge::fill(self : MathfiniteelementEdge, v : Double) -> MathfiniteelementEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementEdge::min(self : MathfiniteelementEdge) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementEdge::max(self : MathfiniteelementEdge) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementEdge::to_string(self : MathfiniteelementEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_path_make(size : Int) -> MathfiniteelementPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementPath::len(self : MathfiniteelementPath) -> Int { self.size }

pub fn MathfiniteelementPath::get(self : MathfiniteelementPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementPath::set(self : MathfiniteelementPath, i : Int, v : Double) -> MathfiniteelementPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementPath::sum(self : MathfiniteelementPath) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementPath::mean(self : MathfiniteelementPath) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementPath::scale(self : MathfiniteelementPath, f : Double) -> MathfiniteelementPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementPath::add(self : MathfiniteelementPath, other : MathfiniteelementPath) -> MathfiniteelementPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementPath::copy(self : MathfiniteelementPath) -> MathfiniteelementPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementPath::fill(self : MathfiniteelementPath, v : Double) -> MathfiniteelementPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementPath::min(self : MathfiniteelementPath) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementPath::max(self : MathfiniteelementPath) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementPath::to_string(self : MathfiniteelementPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_cluster_make(size : Int) -> MathfiniteelementCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementCluster::len(self : MathfiniteelementCluster) -> Int { self.size }

pub fn MathfiniteelementCluster::get(self : MathfiniteelementCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementCluster::set(self : MathfiniteelementCluster, i : Int, v : Double) -> MathfiniteelementCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementCluster::sum(self : MathfiniteelementCluster) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementCluster::mean(self : MathfiniteelementCluster) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementCluster::scale(self : MathfiniteelementCluster, f : Double) -> MathfiniteelementCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementCluster::add(self : MathfiniteelementCluster, other : MathfiniteelementCluster) -> MathfiniteelementCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementCluster::copy(self : MathfiniteelementCluster) -> MathfiniteelementCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementCluster::fill(self : MathfiniteelementCluster, v : Double) -> MathfiniteelementCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementCluster::min(self : MathfiniteelementCluster) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementCluster::max(self : MathfiniteelementCluster) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementCluster::to_string(self : MathfiniteelementCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_model_make(size : Int) -> MathfiniteelementModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementModel::len(self : MathfiniteelementModel) -> Int { self.size }

pub fn MathfiniteelementModel::get(self : MathfiniteelementModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementModel::set(self : MathfiniteelementModel, i : Int, v : Double) -> MathfiniteelementModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementModel::sum(self : MathfiniteelementModel) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementModel::mean(self : MathfiniteelementModel) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementModel::scale(self : MathfiniteelementModel, f : Double) -> MathfiniteelementModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementModel::add(self : MathfiniteelementModel, other : MathfiniteelementModel) -> MathfiniteelementModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementModel::copy(self : MathfiniteelementModel) -> MathfiniteelementModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementModel::fill(self : MathfiniteelementModel, v : Double) -> MathfiniteelementModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementModel::min(self : MathfiniteelementModel) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementModel::max(self : MathfiniteelementModel) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementModel::to_string(self : MathfiniteelementModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_layer_make(size : Int) -> MathfiniteelementLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementLayer::len(self : MathfiniteelementLayer) -> Int { self.size }

pub fn MathfiniteelementLayer::get(self : MathfiniteelementLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementLayer::set(self : MathfiniteelementLayer, i : Int, v : Double) -> MathfiniteelementLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementLayer::sum(self : MathfiniteelementLayer) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementLayer::mean(self : MathfiniteelementLayer) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementLayer::scale(self : MathfiniteelementLayer, f : Double) -> MathfiniteelementLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementLayer::add(self : MathfiniteelementLayer, other : MathfiniteelementLayer) -> MathfiniteelementLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementLayer::copy(self : MathfiniteelementLayer) -> MathfiniteelementLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementLayer::fill(self : MathfiniteelementLayer, v : Double) -> MathfiniteelementLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementLayer::min(self : MathfiniteelementLayer) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementLayer::max(self : MathfiniteelementLayer) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementLayer::to_string(self : MathfiniteelementLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_buffer_make(size : Int) -> MathfiniteelementBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementBuffer::len(self : MathfiniteelementBuffer) -> Int { self.size }

pub fn MathfiniteelementBuffer::get(self : MathfiniteelementBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementBuffer::set(self : MathfiniteelementBuffer, i : Int, v : Double) -> MathfiniteelementBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementBuffer::sum(self : MathfiniteelementBuffer) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementBuffer::mean(self : MathfiniteelementBuffer) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementBuffer::scale(self : MathfiniteelementBuffer, f : Double) -> MathfiniteelementBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementBuffer::add(self : MathfiniteelementBuffer, other : MathfiniteelementBuffer) -> MathfiniteelementBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementBuffer::copy(self : MathfiniteelementBuffer) -> MathfiniteelementBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementBuffer::fill(self : MathfiniteelementBuffer, v : Double) -> MathfiniteelementBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementBuffer::min(self : MathfiniteelementBuffer) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementBuffer::max(self : MathfiniteelementBuffer) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementBuffer::to_string(self : MathfiniteelementBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_cursor_make(size : Int) -> MathfiniteelementCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementCursor::len(self : MathfiniteelementCursor) -> Int { self.size }

pub fn MathfiniteelementCursor::get(self : MathfiniteelementCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementCursor::set(self : MathfiniteelementCursor, i : Int, v : Double) -> MathfiniteelementCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementCursor::sum(self : MathfiniteelementCursor) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementCursor::mean(self : MathfiniteelementCursor) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementCursor::scale(self : MathfiniteelementCursor, f : Double) -> MathfiniteelementCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementCursor::add(self : MathfiniteelementCursor, other : MathfiniteelementCursor) -> MathfiniteelementCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementCursor::copy(self : MathfiniteelementCursor) -> MathfiniteelementCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementCursor::fill(self : MathfiniteelementCursor, v : Double) -> MathfiniteelementCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementCursor::min(self : MathfiniteelementCursor) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementCursor::max(self : MathfiniteelementCursor) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementCursor::to_string(self : MathfiniteelementCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_view_make(size : Int) -> MathfiniteelementView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementView::len(self : MathfiniteelementView) -> Int { self.size }

pub fn MathfiniteelementView::get(self : MathfiniteelementView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementView::set(self : MathfiniteelementView, i : Int, v : Double) -> MathfiniteelementView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementView::sum(self : MathfiniteelementView) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementView::mean(self : MathfiniteelementView) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementView::scale(self : MathfiniteelementView, f : Double) -> MathfiniteelementView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementView::add(self : MathfiniteelementView, other : MathfiniteelementView) -> MathfiniteelementView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementView::copy(self : MathfiniteelementView) -> MathfiniteelementView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementView::fill(self : MathfiniteelementView, v : Double) -> MathfiniteelementView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementView::min(self : MathfiniteelementView) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementView::max(self : MathfiniteelementView) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementView::to_string(self : MathfiniteelementView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_range_make(size : Int) -> MathfiniteelementRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementRange::len(self : MathfiniteelementRange) -> Int { self.size }

pub fn MathfiniteelementRange::get(self : MathfiniteelementRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementRange::set(self : MathfiniteelementRange, i : Int, v : Double) -> MathfiniteelementRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementRange::sum(self : MathfiniteelementRange) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementRange::mean(self : MathfiniteelementRange) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementRange::scale(self : MathfiniteelementRange, f : Double) -> MathfiniteelementRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementRange::add(self : MathfiniteelementRange, other : MathfiniteelementRange) -> MathfiniteelementRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementRange::copy(self : MathfiniteelementRange) -> MathfiniteelementRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementRange::fill(self : MathfiniteelementRange, v : Double) -> MathfiniteelementRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementRange::min(self : MathfiniteelementRange) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementRange::max(self : MathfiniteelementRange) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementRange::to_string(self : MathfiniteelementRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_slice_make(size : Int) -> MathfiniteelementSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathfiniteelementSlice::len(self : MathfiniteelementSlice) -> Int { self.size }

pub fn MathfiniteelementSlice::get(self : MathfiniteelementSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathfiniteelementSlice::set(self : MathfiniteelementSlice, i : Int, v : Double) -> MathfiniteelementSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathfiniteelementSlice::sum(self : MathfiniteelementSlice) -> Double { @_common.sum(self.data) }

pub fn MathfiniteelementSlice::mean(self : MathfiniteelementSlice) -> Double { @_common.mean(self.data) }

pub fn MathfiniteelementSlice::scale(self : MathfiniteelementSlice, f : Double) -> MathfiniteelementSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementSlice::add(self : MathfiniteelementSlice, other : MathfiniteelementSlice) -> MathfiniteelementSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathfiniteelementSlice::copy(self : MathfiniteelementSlice) -> MathfiniteelementSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementSlice::fill(self : MathfiniteelementSlice, v : Double) -> MathfiniteelementSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathfiniteelementSlice::min(self : MathfiniteelementSlice) -> Double { @_common.min(self.data) }

pub fn MathfiniteelementSlice::max(self : MathfiniteelementSlice) -> Double { @_common.max(self.data) }

pub fn MathfiniteelementSlice::to_string(self : MathfiniteelementSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

