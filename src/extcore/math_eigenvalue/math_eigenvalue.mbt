///===
/// extcore/math_eigenvalue

pub(all) struct MatheigenvaluePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_eigenvalue_make_point(x : Double, y : Double) -> MatheigenvaluePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_eigenvalue_make_point3(x : Double, y : Double, z : Double) -> MatheigenvaluePoint {
  { x, y, z, label: 0 }
}

pub fn MatheigenvaluePoint::x(self : MatheigenvaluePoint) -> Double { self.x }

pub fn MatheigenvaluePoint::y(self : MatheigenvaluePoint) -> Double { self.y }

pub fn MatheigenvaluePoint::z(self : MatheigenvaluePoint) -> Double { self.z }

pub fn MatheigenvaluePoint::label(self : MatheigenvaluePoint) -> Int { self.label }

pub fn MatheigenvaluePoint::dist(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MatheigenvaluePoint::add(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MatheigenvaluePoint::sub(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MatheigenvaluePoint::scale(self : MatheigenvaluePoint, s : Double) -> MatheigenvaluePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MatheigenvaluePoint::dot(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MatheigenvaluePoint::cross(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MatheigenvaluePoint::norm(self : MatheigenvaluePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MatheigenvaluePoint::normalize(self : MatheigenvaluePoint) -> MatheigenvaluePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MatheigenvaluePoint::negate(self : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MatheigenvaluePoint::mid(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MatheigenvaluePoint::lerp(self : MatheigenvaluePoint, other : MatheigenvaluePoint, t : Double) -> MatheigenvaluePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MatheigenvaluePoint::to_string(self : MatheigenvaluePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MatheigenvalueSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_eigenvalue_make_series(vals : Array[Double], name : String) -> MatheigenvalueSeries {
  { vals, name, meta: 0 }
}

pub fn MatheigenvalueSeries::len(self : MatheigenvalueSeries) -> Int { self.vals.length() }

pub fn MatheigenvalueSeries::sum(self : MatheigenvalueSeries) -> Double { @_common.sum(self.vals) }

pub fn MatheigenvalueSeries::mean(self : MatheigenvalueSeries) -> Double { @_common.mean(self.vals) }

pub fn MatheigenvalueSeries::min(self : MatheigenvalueSeries) -> Double { @_common.min(self.vals) }

pub fn MatheigenvalueSeries::max(self : MatheigenvalueSeries) -> Double { @_common.max(self.vals) }

pub fn MatheigenvalueSeries::range(self : MatheigenvalueSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MatheigenvalueSeries::variance(self : MatheigenvalueSeries) -> Double { @_common.variance(self.vals) }

pub fn MatheigenvalueSeries::std(self : MatheigenvalueSeries) -> Double { @_common.std(self.vals) }

pub fn MatheigenvalueSeries::median(self : MatheigenvalueSeries) -> Double { @_common.median(self.vals) }

pub fn MatheigenvalueSeries::scale(self : MatheigenvalueSeries, f : Double) -> MatheigenvalueSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MatheigenvalueSeries::add(self : MatheigenvalueSeries, other : MatheigenvalueSeries) -> MatheigenvalueSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MatheigenvalueSeries::sub(self : MatheigenvalueSeries, other : MatheigenvalueSeries) -> MatheigenvalueSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MatheigenvalueSeries::normalize(self : MatheigenvalueSeries) -> MatheigenvalueSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MatheigenvalueSeries::cumsum(self : MatheigenvalueSeries) -> MatheigenvalueSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MatheigenvalueSeries::to_string(self : MatheigenvalueSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MatheigenvalueMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_eigenvalue_make_matrix(rows : Int, cols : Int, val : Double) -> MatheigenvalueMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_eigenvalue_matrix_identity(n : Int) -> MatheigenvalueMatrix {
  let m = math_eigenvalue_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MatheigenvalueMatrix::get(self : MatheigenvalueMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MatheigenvalueMatrix::transpose(self : MatheigenvalueMatrix) -> MatheigenvalueMatrix {
  let result = math_eigenvalue_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MatheigenvalueMatrix::add(self : MatheigenvalueMatrix, other : MatheigenvalueMatrix) -> MatheigenvalueMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_eigenvalue_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MatheigenvalueMatrix::scale(self : MatheigenvalueMatrix, s : Double) -> MatheigenvalueMatrix {
  let result = math_eigenvalue_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MatheigenvalueMatrix::multiply(self : MatheigenvalueMatrix, other : MatheigenvalueMatrix) -> MatheigenvalueMatrix {
  if self.cols != other.rows { return math_eigenvalue_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_eigenvalue_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MatheigenvalueMatrix::trace(self : MatheigenvalueMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MatheigenvalueMatrix::det(self : MatheigenvalueMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MatheigenvalueMatrix::norm(self : MatheigenvalueMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MatheigenvalueMatrix::to_string(self : MatheigenvalueMatrix) -> String {
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

pub(all) struct MatheigenvalueVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_eigenvalue_make_vector(comps : Array[Double]) -> MatheigenvalueVector {
  { comps, dim: comps.length() }
}

pub fn math_eigenvalue_vector_zero(dim : Int) -> MatheigenvalueVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MatheigenvalueVector::add(self : MatheigenvalueVector, other : MatheigenvalueVector) -> MatheigenvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MatheigenvalueVector::sub(self : MatheigenvalueVector, other : MatheigenvalueVector) -> MatheigenvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MatheigenvalueVector::scale(self : MatheigenvalueVector, s : Double) -> MatheigenvalueVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MatheigenvalueVector::dot(self : MatheigenvalueVector, other : MatheigenvalueVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MatheigenvalueVector::norm(self : MatheigenvalueVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MatheigenvalueVector::normalize(self : MatheigenvalueVector) -> MatheigenvalueVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MatheigenvalueVector::dist(self : MatheigenvalueVector, other : MatheigenvalueVector) -> Double {
  self.sub(other).norm()
}

pub fn MatheigenvalueVector::to_string(self : MatheigenvalueVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MatheigenvalueFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_frame_make(size : Int) -> MatheigenvalueFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueFrame::len(self : MatheigenvalueFrame) -> Int { self.size }

pub fn MatheigenvalueFrame::get(self : MatheigenvalueFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueFrame::set(self : MatheigenvalueFrame, i : Int, v : Double) -> MatheigenvalueFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueFrame::sum(self : MatheigenvalueFrame) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueFrame::mean(self : MatheigenvalueFrame) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueFrame::scale(self : MatheigenvalueFrame, f : Double) -> MatheigenvalueFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueFrame::add(self : MatheigenvalueFrame, other : MatheigenvalueFrame) -> MatheigenvalueFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueFrame::copy(self : MatheigenvalueFrame) -> MatheigenvalueFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueFrame::fill(self : MatheigenvalueFrame, v : Double) -> MatheigenvalueFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueFrame::min(self : MatheigenvalueFrame) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueFrame::max(self : MatheigenvalueFrame) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueFrame::to_string(self : MatheigenvalueFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_table_make(size : Int) -> MatheigenvalueTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueTable::len(self : MatheigenvalueTable) -> Int { self.size }

pub fn MatheigenvalueTable::get(self : MatheigenvalueTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueTable::set(self : MatheigenvalueTable, i : Int, v : Double) -> MatheigenvalueTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueTable::sum(self : MatheigenvalueTable) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueTable::mean(self : MatheigenvalueTable) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueTable::scale(self : MatheigenvalueTable, f : Double) -> MatheigenvalueTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueTable::add(self : MatheigenvalueTable, other : MatheigenvalueTable) -> MatheigenvalueTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueTable::copy(self : MatheigenvalueTable) -> MatheigenvalueTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueTable::fill(self : MatheigenvalueTable, v : Double) -> MatheigenvalueTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueTable::min(self : MatheigenvalueTable) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueTable::max(self : MatheigenvalueTable) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueTable::to_string(self : MatheigenvalueTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_graphn_make(size : Int) -> MatheigenvalueGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueGraphN::len(self : MatheigenvalueGraphN) -> Int { self.size }

pub fn MatheigenvalueGraphN::get(self : MatheigenvalueGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueGraphN::set(self : MatheigenvalueGraphN, i : Int, v : Double) -> MatheigenvalueGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueGraphN::sum(self : MatheigenvalueGraphN) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueGraphN::mean(self : MatheigenvalueGraphN) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueGraphN::scale(self : MatheigenvalueGraphN, f : Double) -> MatheigenvalueGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueGraphN::add(self : MatheigenvalueGraphN, other : MatheigenvalueGraphN) -> MatheigenvalueGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueGraphN::copy(self : MatheigenvalueGraphN) -> MatheigenvalueGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueGraphN::fill(self : MatheigenvalueGraphN, v : Double) -> MatheigenvalueGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueGraphN::min(self : MatheigenvalueGraphN) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueGraphN::max(self : MatheigenvalueGraphN) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueGraphN::to_string(self : MatheigenvalueGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_node_make(size : Int) -> MatheigenvalueNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueNode::len(self : MatheigenvalueNode) -> Int { self.size }

pub fn MatheigenvalueNode::get(self : MatheigenvalueNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueNode::set(self : MatheigenvalueNode, i : Int, v : Double) -> MatheigenvalueNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueNode::sum(self : MatheigenvalueNode) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueNode::mean(self : MatheigenvalueNode) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueNode::scale(self : MatheigenvalueNode, f : Double) -> MatheigenvalueNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueNode::add(self : MatheigenvalueNode, other : MatheigenvalueNode) -> MatheigenvalueNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueNode::copy(self : MatheigenvalueNode) -> MatheigenvalueNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueNode::fill(self : MatheigenvalueNode, v : Double) -> MatheigenvalueNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueNode::min(self : MatheigenvalueNode) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueNode::max(self : MatheigenvalueNode) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueNode::to_string(self : MatheigenvalueNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_edge_make(size : Int) -> MatheigenvalueEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueEdge::len(self : MatheigenvalueEdge) -> Int { self.size }

pub fn MatheigenvalueEdge::get(self : MatheigenvalueEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueEdge::set(self : MatheigenvalueEdge, i : Int, v : Double) -> MatheigenvalueEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueEdge::sum(self : MatheigenvalueEdge) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueEdge::mean(self : MatheigenvalueEdge) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueEdge::scale(self : MatheigenvalueEdge, f : Double) -> MatheigenvalueEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueEdge::add(self : MatheigenvalueEdge, other : MatheigenvalueEdge) -> MatheigenvalueEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueEdge::copy(self : MatheigenvalueEdge) -> MatheigenvalueEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueEdge::fill(self : MatheigenvalueEdge, v : Double) -> MatheigenvalueEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueEdge::min(self : MatheigenvalueEdge) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueEdge::max(self : MatheigenvalueEdge) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueEdge::to_string(self : MatheigenvalueEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvaluePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_path_make(size : Int) -> MatheigenvaluePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvaluePath::len(self : MatheigenvaluePath) -> Int { self.size }

pub fn MatheigenvaluePath::get(self : MatheigenvaluePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvaluePath::set(self : MatheigenvaluePath, i : Int, v : Double) -> MatheigenvaluePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvaluePath::sum(self : MatheigenvaluePath) -> Double { @_common.sum(self.data) }

pub fn MatheigenvaluePath::mean(self : MatheigenvaluePath) -> Double { @_common.mean(self.data) }

pub fn MatheigenvaluePath::scale(self : MatheigenvaluePath, f : Double) -> MatheigenvaluePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvaluePath::add(self : MatheigenvaluePath, other : MatheigenvaluePath) -> MatheigenvaluePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvaluePath::copy(self : MatheigenvaluePath) -> MatheigenvaluePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvaluePath::fill(self : MatheigenvaluePath, v : Double) -> MatheigenvaluePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvaluePath::min(self : MatheigenvaluePath) -> Double { @_common.min(self.data) }

pub fn MatheigenvaluePath::max(self : MatheigenvaluePath) -> Double { @_common.max(self.data) }

pub fn MatheigenvaluePath::to_string(self : MatheigenvaluePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_cluster_make(size : Int) -> MatheigenvalueCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueCluster::len(self : MatheigenvalueCluster) -> Int { self.size }

pub fn MatheigenvalueCluster::get(self : MatheigenvalueCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueCluster::set(self : MatheigenvalueCluster, i : Int, v : Double) -> MatheigenvalueCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueCluster::sum(self : MatheigenvalueCluster) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueCluster::mean(self : MatheigenvalueCluster) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueCluster::scale(self : MatheigenvalueCluster, f : Double) -> MatheigenvalueCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueCluster::add(self : MatheigenvalueCluster, other : MatheigenvalueCluster) -> MatheigenvalueCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueCluster::copy(self : MatheigenvalueCluster) -> MatheigenvalueCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueCluster::fill(self : MatheigenvalueCluster, v : Double) -> MatheigenvalueCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueCluster::min(self : MatheigenvalueCluster) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueCluster::max(self : MatheigenvalueCluster) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueCluster::to_string(self : MatheigenvalueCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_model_make(size : Int) -> MatheigenvalueModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueModel::len(self : MatheigenvalueModel) -> Int { self.size }

pub fn MatheigenvalueModel::get(self : MatheigenvalueModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueModel::set(self : MatheigenvalueModel, i : Int, v : Double) -> MatheigenvalueModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueModel::sum(self : MatheigenvalueModel) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueModel::mean(self : MatheigenvalueModel) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueModel::scale(self : MatheigenvalueModel, f : Double) -> MatheigenvalueModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueModel::add(self : MatheigenvalueModel, other : MatheigenvalueModel) -> MatheigenvalueModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueModel::copy(self : MatheigenvalueModel) -> MatheigenvalueModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueModel::fill(self : MatheigenvalueModel, v : Double) -> MatheigenvalueModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueModel::min(self : MatheigenvalueModel) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueModel::max(self : MatheigenvalueModel) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueModel::to_string(self : MatheigenvalueModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_layer_make(size : Int) -> MatheigenvalueLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueLayer::len(self : MatheigenvalueLayer) -> Int { self.size }

pub fn MatheigenvalueLayer::get(self : MatheigenvalueLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueLayer::set(self : MatheigenvalueLayer, i : Int, v : Double) -> MatheigenvalueLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueLayer::sum(self : MatheigenvalueLayer) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueLayer::mean(self : MatheigenvalueLayer) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueLayer::scale(self : MatheigenvalueLayer, f : Double) -> MatheigenvalueLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueLayer::add(self : MatheigenvalueLayer, other : MatheigenvalueLayer) -> MatheigenvalueLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueLayer::copy(self : MatheigenvalueLayer) -> MatheigenvalueLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueLayer::fill(self : MatheigenvalueLayer, v : Double) -> MatheigenvalueLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueLayer::min(self : MatheigenvalueLayer) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueLayer::max(self : MatheigenvalueLayer) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueLayer::to_string(self : MatheigenvalueLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_buffer_make(size : Int) -> MatheigenvalueBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueBuffer::len(self : MatheigenvalueBuffer) -> Int { self.size }

pub fn MatheigenvalueBuffer::get(self : MatheigenvalueBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueBuffer::set(self : MatheigenvalueBuffer, i : Int, v : Double) -> MatheigenvalueBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueBuffer::sum(self : MatheigenvalueBuffer) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueBuffer::mean(self : MatheigenvalueBuffer) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueBuffer::scale(self : MatheigenvalueBuffer, f : Double) -> MatheigenvalueBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueBuffer::add(self : MatheigenvalueBuffer, other : MatheigenvalueBuffer) -> MatheigenvalueBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueBuffer::copy(self : MatheigenvalueBuffer) -> MatheigenvalueBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueBuffer::fill(self : MatheigenvalueBuffer, v : Double) -> MatheigenvalueBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueBuffer::min(self : MatheigenvalueBuffer) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueBuffer::max(self : MatheigenvalueBuffer) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueBuffer::to_string(self : MatheigenvalueBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_cursor_make(size : Int) -> MatheigenvalueCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueCursor::len(self : MatheigenvalueCursor) -> Int { self.size }

pub fn MatheigenvalueCursor::get(self : MatheigenvalueCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueCursor::set(self : MatheigenvalueCursor, i : Int, v : Double) -> MatheigenvalueCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueCursor::sum(self : MatheigenvalueCursor) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueCursor::mean(self : MatheigenvalueCursor) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueCursor::scale(self : MatheigenvalueCursor, f : Double) -> MatheigenvalueCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueCursor::add(self : MatheigenvalueCursor, other : MatheigenvalueCursor) -> MatheigenvalueCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueCursor::copy(self : MatheigenvalueCursor) -> MatheigenvalueCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueCursor::fill(self : MatheigenvalueCursor, v : Double) -> MatheigenvalueCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueCursor::min(self : MatheigenvalueCursor) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueCursor::max(self : MatheigenvalueCursor) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueCursor::to_string(self : MatheigenvalueCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_view_make(size : Int) -> MatheigenvalueView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueView::len(self : MatheigenvalueView) -> Int { self.size }

pub fn MatheigenvalueView::get(self : MatheigenvalueView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueView::set(self : MatheigenvalueView, i : Int, v : Double) -> MatheigenvalueView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueView::sum(self : MatheigenvalueView) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueView::mean(self : MatheigenvalueView) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueView::scale(self : MatheigenvalueView, f : Double) -> MatheigenvalueView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueView::add(self : MatheigenvalueView, other : MatheigenvalueView) -> MatheigenvalueView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueView::copy(self : MatheigenvalueView) -> MatheigenvalueView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueView::fill(self : MatheigenvalueView, v : Double) -> MatheigenvalueView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueView::min(self : MatheigenvalueView) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueView::max(self : MatheigenvalueView) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueView::to_string(self : MatheigenvalueView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_range_make(size : Int) -> MatheigenvalueRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueRange::len(self : MatheigenvalueRange) -> Int { self.size }

pub fn MatheigenvalueRange::get(self : MatheigenvalueRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueRange::set(self : MatheigenvalueRange, i : Int, v : Double) -> MatheigenvalueRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueRange::sum(self : MatheigenvalueRange) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueRange::mean(self : MatheigenvalueRange) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueRange::scale(self : MatheigenvalueRange, f : Double) -> MatheigenvalueRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueRange::add(self : MatheigenvalueRange, other : MatheigenvalueRange) -> MatheigenvalueRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueRange::copy(self : MatheigenvalueRange) -> MatheigenvalueRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueRange::fill(self : MatheigenvalueRange, v : Double) -> MatheigenvalueRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueRange::min(self : MatheigenvalueRange) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueRange::max(self : MatheigenvalueRange) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueRange::to_string(self : MatheigenvalueRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_slice_make(size : Int) -> MatheigenvalueSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MatheigenvalueSlice::len(self : MatheigenvalueSlice) -> Int { self.size }

pub fn MatheigenvalueSlice::get(self : MatheigenvalueSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MatheigenvalueSlice::set(self : MatheigenvalueSlice, i : Int, v : Double) -> MatheigenvalueSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MatheigenvalueSlice::sum(self : MatheigenvalueSlice) -> Double { @_common.sum(self.data) }

pub fn MatheigenvalueSlice::mean(self : MatheigenvalueSlice) -> Double { @_common.mean(self.data) }

pub fn MatheigenvalueSlice::scale(self : MatheigenvalueSlice, f : Double) -> MatheigenvalueSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueSlice::add(self : MatheigenvalueSlice, other : MatheigenvalueSlice) -> MatheigenvalueSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MatheigenvalueSlice::copy(self : MatheigenvalueSlice) -> MatheigenvalueSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueSlice::fill(self : MatheigenvalueSlice, v : Double) -> MatheigenvalueSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MatheigenvalueSlice::min(self : MatheigenvalueSlice) -> Double { @_common.min(self.data) }

pub fn MatheigenvalueSlice::max(self : MatheigenvalueSlice) -> Double { @_common.max(self.data) }

pub fn MatheigenvalueSlice::to_string(self : MatheigenvalueSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

