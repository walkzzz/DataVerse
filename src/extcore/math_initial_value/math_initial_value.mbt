///===
/// extcore/math_initial_value

pub(all) struct MathinitialvaluePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_initial_value_make_point(x : Double, y : Double) -> MathinitialvaluePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_initial_value_make_point3(x : Double, y : Double, z : Double) -> MathinitialvaluePoint {
  { x, y, z, label: 0 }
}

pub fn MathinitialvaluePoint::x(self : MathinitialvaluePoint) -> Double { self.x }

pub fn MathinitialvaluePoint::y(self : MathinitialvaluePoint) -> Double { self.y }

pub fn MathinitialvaluePoint::z(self : MathinitialvaluePoint) -> Double { self.z }

pub fn MathinitialvaluePoint::label(self : MathinitialvaluePoint) -> Int { self.label }

pub fn MathinitialvaluePoint::dist(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathinitialvaluePoint::add(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathinitialvaluePoint::sub(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathinitialvaluePoint::scale(self : MathinitialvaluePoint, s : Double) -> MathinitialvaluePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathinitialvaluePoint::dot(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathinitialvaluePoint::cross(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathinitialvaluePoint::norm(self : MathinitialvaluePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathinitialvaluePoint::normalize(self : MathinitialvaluePoint) -> MathinitialvaluePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathinitialvaluePoint::negate(self : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathinitialvaluePoint::mid(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathinitialvaluePoint::lerp(self : MathinitialvaluePoint, other : MathinitialvaluePoint, t : Double) -> MathinitialvaluePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathinitialvaluePoint::to_string(self : MathinitialvaluePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathinitialvalueSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_initial_value_make_series(vals : Array[Double], name : String) -> MathinitialvalueSeries {
  { vals, name, meta: 0 }
}

pub fn MathinitialvalueSeries::len(self : MathinitialvalueSeries) -> Int { self.vals.length() }

pub fn MathinitialvalueSeries::sum(self : MathinitialvalueSeries) -> Double { @_common.sum(self.vals) }

pub fn MathinitialvalueSeries::mean(self : MathinitialvalueSeries) -> Double { @_common.mean(self.vals) }

pub fn MathinitialvalueSeries::min(self : MathinitialvalueSeries) -> Double { @_common.min(self.vals) }

pub fn MathinitialvalueSeries::max(self : MathinitialvalueSeries) -> Double { @_common.max(self.vals) }

pub fn MathinitialvalueSeries::range(self : MathinitialvalueSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathinitialvalueSeries::variance(self : MathinitialvalueSeries) -> Double { @_common.variance(self.vals) }

pub fn MathinitialvalueSeries::std(self : MathinitialvalueSeries) -> Double { @_common.std(self.vals) }

pub fn MathinitialvalueSeries::median(self : MathinitialvalueSeries) -> Double { @_common.median(self.vals) }

pub fn MathinitialvalueSeries::scale(self : MathinitialvalueSeries, f : Double) -> MathinitialvalueSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathinitialvalueSeries::add(self : MathinitialvalueSeries, other : MathinitialvalueSeries) -> MathinitialvalueSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathinitialvalueSeries::sub(self : MathinitialvalueSeries, other : MathinitialvalueSeries) -> MathinitialvalueSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathinitialvalueSeries::normalize(self : MathinitialvalueSeries) -> MathinitialvalueSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathinitialvalueSeries::cumsum(self : MathinitialvalueSeries) -> MathinitialvalueSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathinitialvalueSeries::to_string(self : MathinitialvalueSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathinitialvalueMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_initial_value_make_matrix(rows : Int, cols : Int, val : Double) -> MathinitialvalueMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_initial_value_matrix_identity(n : Int) -> MathinitialvalueMatrix {
  let m = math_initial_value_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathinitialvalueMatrix::get(self : MathinitialvalueMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathinitialvalueMatrix::transpose(self : MathinitialvalueMatrix) -> MathinitialvalueMatrix {
  let result = math_initial_value_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathinitialvalueMatrix::add(self : MathinitialvalueMatrix, other : MathinitialvalueMatrix) -> MathinitialvalueMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_initial_value_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathinitialvalueMatrix::scale(self : MathinitialvalueMatrix, s : Double) -> MathinitialvalueMatrix {
  let result = math_initial_value_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathinitialvalueMatrix::multiply(self : MathinitialvalueMatrix, other : MathinitialvalueMatrix) -> MathinitialvalueMatrix {
  if self.cols != other.rows { return math_initial_value_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_initial_value_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathinitialvalueMatrix::trace(self : MathinitialvalueMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathinitialvalueMatrix::det(self : MathinitialvalueMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathinitialvalueMatrix::norm(self : MathinitialvalueMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathinitialvalueMatrix::to_string(self : MathinitialvalueMatrix) -> String {
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

pub(all) struct MathinitialvalueVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_initial_value_make_vector(comps : Array[Double]) -> MathinitialvalueVector {
  { comps, dim: comps.length() }
}

pub fn math_initial_value_vector_zero(dim : Int) -> MathinitialvalueVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathinitialvalueVector::add(self : MathinitialvalueVector, other : MathinitialvalueVector) -> MathinitialvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathinitialvalueVector::sub(self : MathinitialvalueVector, other : MathinitialvalueVector) -> MathinitialvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathinitialvalueVector::scale(self : MathinitialvalueVector, s : Double) -> MathinitialvalueVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathinitialvalueVector::dot(self : MathinitialvalueVector, other : MathinitialvalueVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathinitialvalueVector::norm(self : MathinitialvalueVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathinitialvalueVector::normalize(self : MathinitialvalueVector) -> MathinitialvalueVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathinitialvalueVector::dist(self : MathinitialvalueVector, other : MathinitialvalueVector) -> Double {
  self.sub(other).norm()
}

pub fn MathinitialvalueVector::to_string(self : MathinitialvalueVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathinitialvalueFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_frame_make(size : Int) -> MathinitialvalueFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueFrame::len(self : MathinitialvalueFrame) -> Int { self.size }

pub fn MathinitialvalueFrame::get(self : MathinitialvalueFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueFrame::set(self : MathinitialvalueFrame, i : Int, v : Double) -> MathinitialvalueFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueFrame::sum(self : MathinitialvalueFrame) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueFrame::mean(self : MathinitialvalueFrame) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueFrame::scale(self : MathinitialvalueFrame, f : Double) -> MathinitialvalueFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueFrame::add(self : MathinitialvalueFrame, other : MathinitialvalueFrame) -> MathinitialvalueFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueFrame::copy(self : MathinitialvalueFrame) -> MathinitialvalueFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueFrame::fill(self : MathinitialvalueFrame, v : Double) -> MathinitialvalueFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueFrame::min(self : MathinitialvalueFrame) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueFrame::max(self : MathinitialvalueFrame) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueFrame::to_string(self : MathinitialvalueFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_table_make(size : Int) -> MathinitialvalueTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueTable::len(self : MathinitialvalueTable) -> Int { self.size }

pub fn MathinitialvalueTable::get(self : MathinitialvalueTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueTable::set(self : MathinitialvalueTable, i : Int, v : Double) -> MathinitialvalueTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueTable::sum(self : MathinitialvalueTable) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueTable::mean(self : MathinitialvalueTable) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueTable::scale(self : MathinitialvalueTable, f : Double) -> MathinitialvalueTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueTable::add(self : MathinitialvalueTable, other : MathinitialvalueTable) -> MathinitialvalueTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueTable::copy(self : MathinitialvalueTable) -> MathinitialvalueTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueTable::fill(self : MathinitialvalueTable, v : Double) -> MathinitialvalueTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueTable::min(self : MathinitialvalueTable) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueTable::max(self : MathinitialvalueTable) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueTable::to_string(self : MathinitialvalueTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_graphn_make(size : Int) -> MathinitialvalueGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueGraphN::len(self : MathinitialvalueGraphN) -> Int { self.size }

pub fn MathinitialvalueGraphN::get(self : MathinitialvalueGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueGraphN::set(self : MathinitialvalueGraphN, i : Int, v : Double) -> MathinitialvalueGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueGraphN::sum(self : MathinitialvalueGraphN) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueGraphN::mean(self : MathinitialvalueGraphN) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueGraphN::scale(self : MathinitialvalueGraphN, f : Double) -> MathinitialvalueGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueGraphN::add(self : MathinitialvalueGraphN, other : MathinitialvalueGraphN) -> MathinitialvalueGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueGraphN::copy(self : MathinitialvalueGraphN) -> MathinitialvalueGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueGraphN::fill(self : MathinitialvalueGraphN, v : Double) -> MathinitialvalueGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueGraphN::min(self : MathinitialvalueGraphN) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueGraphN::max(self : MathinitialvalueGraphN) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueGraphN::to_string(self : MathinitialvalueGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_node_make(size : Int) -> MathinitialvalueNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueNode::len(self : MathinitialvalueNode) -> Int { self.size }

pub fn MathinitialvalueNode::get(self : MathinitialvalueNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueNode::set(self : MathinitialvalueNode, i : Int, v : Double) -> MathinitialvalueNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueNode::sum(self : MathinitialvalueNode) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueNode::mean(self : MathinitialvalueNode) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueNode::scale(self : MathinitialvalueNode, f : Double) -> MathinitialvalueNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueNode::add(self : MathinitialvalueNode, other : MathinitialvalueNode) -> MathinitialvalueNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueNode::copy(self : MathinitialvalueNode) -> MathinitialvalueNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueNode::fill(self : MathinitialvalueNode, v : Double) -> MathinitialvalueNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueNode::min(self : MathinitialvalueNode) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueNode::max(self : MathinitialvalueNode) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueNode::to_string(self : MathinitialvalueNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_edge_make(size : Int) -> MathinitialvalueEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueEdge::len(self : MathinitialvalueEdge) -> Int { self.size }

pub fn MathinitialvalueEdge::get(self : MathinitialvalueEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueEdge::set(self : MathinitialvalueEdge, i : Int, v : Double) -> MathinitialvalueEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueEdge::sum(self : MathinitialvalueEdge) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueEdge::mean(self : MathinitialvalueEdge) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueEdge::scale(self : MathinitialvalueEdge, f : Double) -> MathinitialvalueEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueEdge::add(self : MathinitialvalueEdge, other : MathinitialvalueEdge) -> MathinitialvalueEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueEdge::copy(self : MathinitialvalueEdge) -> MathinitialvalueEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueEdge::fill(self : MathinitialvalueEdge, v : Double) -> MathinitialvalueEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueEdge::min(self : MathinitialvalueEdge) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueEdge::max(self : MathinitialvalueEdge) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueEdge::to_string(self : MathinitialvalueEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvaluePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_path_make(size : Int) -> MathinitialvaluePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvaluePath::len(self : MathinitialvaluePath) -> Int { self.size }

pub fn MathinitialvaluePath::get(self : MathinitialvaluePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvaluePath::set(self : MathinitialvaluePath, i : Int, v : Double) -> MathinitialvaluePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvaluePath::sum(self : MathinitialvaluePath) -> Double { @_common.sum(self.data) }

pub fn MathinitialvaluePath::mean(self : MathinitialvaluePath) -> Double { @_common.mean(self.data) }

pub fn MathinitialvaluePath::scale(self : MathinitialvaluePath, f : Double) -> MathinitialvaluePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvaluePath::add(self : MathinitialvaluePath, other : MathinitialvaluePath) -> MathinitialvaluePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvaluePath::copy(self : MathinitialvaluePath) -> MathinitialvaluePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvaluePath::fill(self : MathinitialvaluePath, v : Double) -> MathinitialvaluePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvaluePath::min(self : MathinitialvaluePath) -> Double { @_common.min(self.data) }

pub fn MathinitialvaluePath::max(self : MathinitialvaluePath) -> Double { @_common.max(self.data) }

pub fn MathinitialvaluePath::to_string(self : MathinitialvaluePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_cluster_make(size : Int) -> MathinitialvalueCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueCluster::len(self : MathinitialvalueCluster) -> Int { self.size }

pub fn MathinitialvalueCluster::get(self : MathinitialvalueCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueCluster::set(self : MathinitialvalueCluster, i : Int, v : Double) -> MathinitialvalueCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueCluster::sum(self : MathinitialvalueCluster) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueCluster::mean(self : MathinitialvalueCluster) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueCluster::scale(self : MathinitialvalueCluster, f : Double) -> MathinitialvalueCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueCluster::add(self : MathinitialvalueCluster, other : MathinitialvalueCluster) -> MathinitialvalueCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueCluster::copy(self : MathinitialvalueCluster) -> MathinitialvalueCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueCluster::fill(self : MathinitialvalueCluster, v : Double) -> MathinitialvalueCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueCluster::min(self : MathinitialvalueCluster) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueCluster::max(self : MathinitialvalueCluster) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueCluster::to_string(self : MathinitialvalueCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_model_make(size : Int) -> MathinitialvalueModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueModel::len(self : MathinitialvalueModel) -> Int { self.size }

pub fn MathinitialvalueModel::get(self : MathinitialvalueModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueModel::set(self : MathinitialvalueModel, i : Int, v : Double) -> MathinitialvalueModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueModel::sum(self : MathinitialvalueModel) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueModel::mean(self : MathinitialvalueModel) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueModel::scale(self : MathinitialvalueModel, f : Double) -> MathinitialvalueModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueModel::add(self : MathinitialvalueModel, other : MathinitialvalueModel) -> MathinitialvalueModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueModel::copy(self : MathinitialvalueModel) -> MathinitialvalueModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueModel::fill(self : MathinitialvalueModel, v : Double) -> MathinitialvalueModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueModel::min(self : MathinitialvalueModel) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueModel::max(self : MathinitialvalueModel) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueModel::to_string(self : MathinitialvalueModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_layer_make(size : Int) -> MathinitialvalueLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueLayer::len(self : MathinitialvalueLayer) -> Int { self.size }

pub fn MathinitialvalueLayer::get(self : MathinitialvalueLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueLayer::set(self : MathinitialvalueLayer, i : Int, v : Double) -> MathinitialvalueLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueLayer::sum(self : MathinitialvalueLayer) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueLayer::mean(self : MathinitialvalueLayer) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueLayer::scale(self : MathinitialvalueLayer, f : Double) -> MathinitialvalueLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueLayer::add(self : MathinitialvalueLayer, other : MathinitialvalueLayer) -> MathinitialvalueLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueLayer::copy(self : MathinitialvalueLayer) -> MathinitialvalueLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueLayer::fill(self : MathinitialvalueLayer, v : Double) -> MathinitialvalueLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueLayer::min(self : MathinitialvalueLayer) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueLayer::max(self : MathinitialvalueLayer) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueLayer::to_string(self : MathinitialvalueLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_buffer_make(size : Int) -> MathinitialvalueBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueBuffer::len(self : MathinitialvalueBuffer) -> Int { self.size }

pub fn MathinitialvalueBuffer::get(self : MathinitialvalueBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueBuffer::set(self : MathinitialvalueBuffer, i : Int, v : Double) -> MathinitialvalueBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueBuffer::sum(self : MathinitialvalueBuffer) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueBuffer::mean(self : MathinitialvalueBuffer) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueBuffer::scale(self : MathinitialvalueBuffer, f : Double) -> MathinitialvalueBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueBuffer::add(self : MathinitialvalueBuffer, other : MathinitialvalueBuffer) -> MathinitialvalueBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueBuffer::copy(self : MathinitialvalueBuffer) -> MathinitialvalueBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueBuffer::fill(self : MathinitialvalueBuffer, v : Double) -> MathinitialvalueBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueBuffer::min(self : MathinitialvalueBuffer) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueBuffer::max(self : MathinitialvalueBuffer) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueBuffer::to_string(self : MathinitialvalueBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_cursor_make(size : Int) -> MathinitialvalueCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueCursor::len(self : MathinitialvalueCursor) -> Int { self.size }

pub fn MathinitialvalueCursor::get(self : MathinitialvalueCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueCursor::set(self : MathinitialvalueCursor, i : Int, v : Double) -> MathinitialvalueCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueCursor::sum(self : MathinitialvalueCursor) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueCursor::mean(self : MathinitialvalueCursor) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueCursor::scale(self : MathinitialvalueCursor, f : Double) -> MathinitialvalueCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueCursor::add(self : MathinitialvalueCursor, other : MathinitialvalueCursor) -> MathinitialvalueCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueCursor::copy(self : MathinitialvalueCursor) -> MathinitialvalueCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueCursor::fill(self : MathinitialvalueCursor, v : Double) -> MathinitialvalueCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueCursor::min(self : MathinitialvalueCursor) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueCursor::max(self : MathinitialvalueCursor) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueCursor::to_string(self : MathinitialvalueCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_view_make(size : Int) -> MathinitialvalueView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueView::len(self : MathinitialvalueView) -> Int { self.size }

pub fn MathinitialvalueView::get(self : MathinitialvalueView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueView::set(self : MathinitialvalueView, i : Int, v : Double) -> MathinitialvalueView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueView::sum(self : MathinitialvalueView) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueView::mean(self : MathinitialvalueView) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueView::scale(self : MathinitialvalueView, f : Double) -> MathinitialvalueView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueView::add(self : MathinitialvalueView, other : MathinitialvalueView) -> MathinitialvalueView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueView::copy(self : MathinitialvalueView) -> MathinitialvalueView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueView::fill(self : MathinitialvalueView, v : Double) -> MathinitialvalueView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueView::min(self : MathinitialvalueView) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueView::max(self : MathinitialvalueView) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueView::to_string(self : MathinitialvalueView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_range_make(size : Int) -> MathinitialvalueRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueRange::len(self : MathinitialvalueRange) -> Int { self.size }

pub fn MathinitialvalueRange::get(self : MathinitialvalueRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueRange::set(self : MathinitialvalueRange, i : Int, v : Double) -> MathinitialvalueRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueRange::sum(self : MathinitialvalueRange) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueRange::mean(self : MathinitialvalueRange) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueRange::scale(self : MathinitialvalueRange, f : Double) -> MathinitialvalueRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueRange::add(self : MathinitialvalueRange, other : MathinitialvalueRange) -> MathinitialvalueRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueRange::copy(self : MathinitialvalueRange) -> MathinitialvalueRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueRange::fill(self : MathinitialvalueRange, v : Double) -> MathinitialvalueRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueRange::min(self : MathinitialvalueRange) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueRange::max(self : MathinitialvalueRange) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueRange::to_string(self : MathinitialvalueRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_slice_make(size : Int) -> MathinitialvalueSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathinitialvalueSlice::len(self : MathinitialvalueSlice) -> Int { self.size }

pub fn MathinitialvalueSlice::get(self : MathinitialvalueSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathinitialvalueSlice::set(self : MathinitialvalueSlice, i : Int, v : Double) -> MathinitialvalueSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathinitialvalueSlice::sum(self : MathinitialvalueSlice) -> Double { @_common.sum(self.data) }

pub fn MathinitialvalueSlice::mean(self : MathinitialvalueSlice) -> Double { @_common.mean(self.data) }

pub fn MathinitialvalueSlice::scale(self : MathinitialvalueSlice, f : Double) -> MathinitialvalueSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueSlice::add(self : MathinitialvalueSlice, other : MathinitialvalueSlice) -> MathinitialvalueSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathinitialvalueSlice::copy(self : MathinitialvalueSlice) -> MathinitialvalueSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueSlice::fill(self : MathinitialvalueSlice, v : Double) -> MathinitialvalueSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathinitialvalueSlice::min(self : MathinitialvalueSlice) -> Double { @_common.min(self.data) }

pub fn MathinitialvalueSlice::max(self : MathinitialvalueSlice) -> Double { @_common.max(self.data) }

pub fn MathinitialvalueSlice::to_string(self : MathinitialvalueSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

