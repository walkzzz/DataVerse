///===
/// extcore/ml_rl_qlearning

pub(all) struct MlrlqlearningPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_qlearning_make_point(x : Double, y : Double) -> MlrlqlearningPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_qlearning_make_point3(x : Double, y : Double, z : Double) -> MlrlqlearningPoint {
  { x, y, z, label: 0 }
}

pub fn MlrlqlearningPoint::x(self : MlrlqlearningPoint) -> Double { self.x }

pub fn MlrlqlearningPoint::y(self : MlrlqlearningPoint) -> Double { self.y }

pub fn MlrlqlearningPoint::z(self : MlrlqlearningPoint) -> Double { self.z }

pub fn MlrlqlearningPoint::label(self : MlrlqlearningPoint) -> Int { self.label }

pub fn MlrlqlearningPoint::dist(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrlqlearningPoint::add(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrlqlearningPoint::sub(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrlqlearningPoint::scale(self : MlrlqlearningPoint, s : Double) -> MlrlqlearningPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrlqlearningPoint::dot(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrlqlearningPoint::cross(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrlqlearningPoint::norm(self : MlrlqlearningPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrlqlearningPoint::normalize(self : MlrlqlearningPoint) -> MlrlqlearningPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlqlearningPoint::negate(self : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrlqlearningPoint::mid(self : MlrlqlearningPoint, other : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrlqlearningPoint::lerp(self : MlrlqlearningPoint, other : MlrlqlearningPoint, t : Double) -> MlrlqlearningPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrlqlearningPoint::to_string(self : MlrlqlearningPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrlqlearningSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_qlearning_make_series(vals : Array[Double], name : String) -> MlrlqlearningSeries {
  { vals, name, meta: 0 }
}

pub fn MlrlqlearningSeries::len(self : MlrlqlearningSeries) -> Int { self.vals.length() }

pub fn MlrlqlearningSeries::sum(self : MlrlqlearningSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrlqlearningSeries::mean(self : MlrlqlearningSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrlqlearningSeries::min(self : MlrlqlearningSeries) -> Double { @_common.min(self.vals) }

pub fn MlrlqlearningSeries::max(self : MlrlqlearningSeries) -> Double { @_common.max(self.vals) }

pub fn MlrlqlearningSeries::range(self : MlrlqlearningSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrlqlearningSeries::variance(self : MlrlqlearningSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrlqlearningSeries::std(self : MlrlqlearningSeries) -> Double { @_common.std(self.vals) }

pub fn MlrlqlearningSeries::median(self : MlrlqlearningSeries) -> Double { @_common.median(self.vals) }

pub fn MlrlqlearningSeries::scale(self : MlrlqlearningSeries, f : Double) -> MlrlqlearningSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrlqlearningSeries::add(self : MlrlqlearningSeries, other : MlrlqlearningSeries) -> MlrlqlearningSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrlqlearningSeries::sub(self : MlrlqlearningSeries, other : MlrlqlearningSeries) -> MlrlqlearningSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrlqlearningSeries::normalize(self : MlrlqlearningSeries) -> MlrlqlearningSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrlqlearningSeries::cumsum(self : MlrlqlearningSeries) -> MlrlqlearningSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrlqlearningSeries::to_string(self : MlrlqlearningSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlqlearningMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_qlearning_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlqlearningMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_qlearning_matrix_identity(n : Int) -> MlrlqlearningMatrix {
  let m = ml_rl_qlearning_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrlqlearningMatrix::get(self : MlrlqlearningMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrlqlearningMatrix::transpose(self : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  let result = ml_rl_qlearning_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrlqlearningMatrix::add(self : MlrlqlearningMatrix, other : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_qlearning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrlqlearningMatrix::scale(self : MlrlqlearningMatrix, s : Double) -> MlrlqlearningMatrix {
  let result = ml_rl_qlearning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrlqlearningMatrix::multiply(self : MlrlqlearningMatrix, other : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  if self.cols != other.rows { return ml_rl_qlearning_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_qlearning_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlrlqlearningMatrix::trace(self : MlrlqlearningMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrlqlearningMatrix::det(self : MlrlqlearningMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrlqlearningMatrix::norm(self : MlrlqlearningMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrlqlearningMatrix::to_string(self : MlrlqlearningMatrix) -> String {
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

pub(all) struct MlrlqlearningVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_qlearning_make_vector(comps : Array[Double]) -> MlrlqlearningVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_qlearning_vector_zero(dim : Int) -> MlrlqlearningVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrlqlearningVector::add(self : MlrlqlearningVector, other : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlqlearningVector::sub(self : MlrlqlearningVector, other : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlqlearningVector::scale(self : MlrlqlearningVector, s : Double) -> MlrlqlearningVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrlqlearningVector::dot(self : MlrlqlearningVector, other : MlrlqlearningVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrlqlearningVector::norm(self : MlrlqlearningVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrlqlearningVector::normalize(self : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlqlearningVector::dist(self : MlrlqlearningVector, other : MlrlqlearningVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrlqlearningVector::to_string(self : MlrlqlearningVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlqlearningFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_frame_make(size : Int) -> MlrlqlearningFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningFrame::len(self : MlrlqlearningFrame) -> Int { self.size }

pub fn MlrlqlearningFrame::get(self : MlrlqlearningFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningFrame::set(self : MlrlqlearningFrame, i : Int, v : Double) -> MlrlqlearningFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningFrame::sum(self : MlrlqlearningFrame) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningFrame::mean(self : MlrlqlearningFrame) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningFrame::scale(self : MlrlqlearningFrame, f : Double) -> MlrlqlearningFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningFrame::add(self : MlrlqlearningFrame, other : MlrlqlearningFrame) -> MlrlqlearningFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningFrame::copy(self : MlrlqlearningFrame) -> MlrlqlearningFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningFrame::fill(self : MlrlqlearningFrame, v : Double) -> MlrlqlearningFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningFrame::min(self : MlrlqlearningFrame) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningFrame::max(self : MlrlqlearningFrame) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningFrame::to_string(self : MlrlqlearningFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_table_make(size : Int) -> MlrlqlearningTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningTable::len(self : MlrlqlearningTable) -> Int { self.size }

pub fn MlrlqlearningTable::get(self : MlrlqlearningTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningTable::set(self : MlrlqlearningTable, i : Int, v : Double) -> MlrlqlearningTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningTable::sum(self : MlrlqlearningTable) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningTable::mean(self : MlrlqlearningTable) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningTable::scale(self : MlrlqlearningTable, f : Double) -> MlrlqlearningTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningTable::add(self : MlrlqlearningTable, other : MlrlqlearningTable) -> MlrlqlearningTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningTable::copy(self : MlrlqlearningTable) -> MlrlqlearningTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningTable::fill(self : MlrlqlearningTable, v : Double) -> MlrlqlearningTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningTable::min(self : MlrlqlearningTable) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningTable::max(self : MlrlqlearningTable) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningTable::to_string(self : MlrlqlearningTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_graphn_make(size : Int) -> MlrlqlearningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningGraphN::len(self : MlrlqlearningGraphN) -> Int { self.size }

pub fn MlrlqlearningGraphN::get(self : MlrlqlearningGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningGraphN::set(self : MlrlqlearningGraphN, i : Int, v : Double) -> MlrlqlearningGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningGraphN::sum(self : MlrlqlearningGraphN) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningGraphN::mean(self : MlrlqlearningGraphN) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningGraphN::scale(self : MlrlqlearningGraphN, f : Double) -> MlrlqlearningGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningGraphN::add(self : MlrlqlearningGraphN, other : MlrlqlearningGraphN) -> MlrlqlearningGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningGraphN::copy(self : MlrlqlearningGraphN) -> MlrlqlearningGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningGraphN::fill(self : MlrlqlearningGraphN, v : Double) -> MlrlqlearningGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningGraphN::min(self : MlrlqlearningGraphN) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningGraphN::max(self : MlrlqlearningGraphN) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningGraphN::to_string(self : MlrlqlearningGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_node_make(size : Int) -> MlrlqlearningNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningNode::len(self : MlrlqlearningNode) -> Int { self.size }

pub fn MlrlqlearningNode::get(self : MlrlqlearningNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningNode::set(self : MlrlqlearningNode, i : Int, v : Double) -> MlrlqlearningNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningNode::sum(self : MlrlqlearningNode) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningNode::mean(self : MlrlqlearningNode) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningNode::scale(self : MlrlqlearningNode, f : Double) -> MlrlqlearningNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningNode::add(self : MlrlqlearningNode, other : MlrlqlearningNode) -> MlrlqlearningNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningNode::copy(self : MlrlqlearningNode) -> MlrlqlearningNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningNode::fill(self : MlrlqlearningNode, v : Double) -> MlrlqlearningNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningNode::min(self : MlrlqlearningNode) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningNode::max(self : MlrlqlearningNode) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningNode::to_string(self : MlrlqlearningNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_edge_make(size : Int) -> MlrlqlearningEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningEdge::len(self : MlrlqlearningEdge) -> Int { self.size }

pub fn MlrlqlearningEdge::get(self : MlrlqlearningEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningEdge::set(self : MlrlqlearningEdge, i : Int, v : Double) -> MlrlqlearningEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningEdge::sum(self : MlrlqlearningEdge) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningEdge::mean(self : MlrlqlearningEdge) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningEdge::scale(self : MlrlqlearningEdge, f : Double) -> MlrlqlearningEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningEdge::add(self : MlrlqlearningEdge, other : MlrlqlearningEdge) -> MlrlqlearningEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningEdge::copy(self : MlrlqlearningEdge) -> MlrlqlearningEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningEdge::fill(self : MlrlqlearningEdge, v : Double) -> MlrlqlearningEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningEdge::min(self : MlrlqlearningEdge) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningEdge::max(self : MlrlqlearningEdge) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningEdge::to_string(self : MlrlqlearningEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_path_make(size : Int) -> MlrlqlearningPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningPath::len(self : MlrlqlearningPath) -> Int { self.size }

pub fn MlrlqlearningPath::get(self : MlrlqlearningPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningPath::set(self : MlrlqlearningPath, i : Int, v : Double) -> MlrlqlearningPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningPath::sum(self : MlrlqlearningPath) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningPath::mean(self : MlrlqlearningPath) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningPath::scale(self : MlrlqlearningPath, f : Double) -> MlrlqlearningPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningPath::add(self : MlrlqlearningPath, other : MlrlqlearningPath) -> MlrlqlearningPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningPath::copy(self : MlrlqlearningPath) -> MlrlqlearningPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningPath::fill(self : MlrlqlearningPath, v : Double) -> MlrlqlearningPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningPath::min(self : MlrlqlearningPath) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningPath::max(self : MlrlqlearningPath) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningPath::to_string(self : MlrlqlearningPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_cluster_make(size : Int) -> MlrlqlearningCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningCluster::len(self : MlrlqlearningCluster) -> Int { self.size }

pub fn MlrlqlearningCluster::get(self : MlrlqlearningCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningCluster::set(self : MlrlqlearningCluster, i : Int, v : Double) -> MlrlqlearningCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningCluster::sum(self : MlrlqlearningCluster) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningCluster::mean(self : MlrlqlearningCluster) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningCluster::scale(self : MlrlqlearningCluster, f : Double) -> MlrlqlearningCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningCluster::add(self : MlrlqlearningCluster, other : MlrlqlearningCluster) -> MlrlqlearningCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningCluster::copy(self : MlrlqlearningCluster) -> MlrlqlearningCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningCluster::fill(self : MlrlqlearningCluster, v : Double) -> MlrlqlearningCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningCluster::min(self : MlrlqlearningCluster) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningCluster::max(self : MlrlqlearningCluster) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningCluster::to_string(self : MlrlqlearningCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_model_make(size : Int) -> MlrlqlearningModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningModel::len(self : MlrlqlearningModel) -> Int { self.size }

pub fn MlrlqlearningModel::get(self : MlrlqlearningModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningModel::set(self : MlrlqlearningModel, i : Int, v : Double) -> MlrlqlearningModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningModel::sum(self : MlrlqlearningModel) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningModel::mean(self : MlrlqlearningModel) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningModel::scale(self : MlrlqlearningModel, f : Double) -> MlrlqlearningModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningModel::add(self : MlrlqlearningModel, other : MlrlqlearningModel) -> MlrlqlearningModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningModel::copy(self : MlrlqlearningModel) -> MlrlqlearningModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningModel::fill(self : MlrlqlearningModel, v : Double) -> MlrlqlearningModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningModel::min(self : MlrlqlearningModel) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningModel::max(self : MlrlqlearningModel) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningModel::to_string(self : MlrlqlearningModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_layer_make(size : Int) -> MlrlqlearningLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningLayer::len(self : MlrlqlearningLayer) -> Int { self.size }

pub fn MlrlqlearningLayer::get(self : MlrlqlearningLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningLayer::set(self : MlrlqlearningLayer, i : Int, v : Double) -> MlrlqlearningLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningLayer::sum(self : MlrlqlearningLayer) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningLayer::mean(self : MlrlqlearningLayer) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningLayer::scale(self : MlrlqlearningLayer, f : Double) -> MlrlqlearningLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningLayer::add(self : MlrlqlearningLayer, other : MlrlqlearningLayer) -> MlrlqlearningLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningLayer::copy(self : MlrlqlearningLayer) -> MlrlqlearningLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningLayer::fill(self : MlrlqlearningLayer, v : Double) -> MlrlqlearningLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningLayer::min(self : MlrlqlearningLayer) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningLayer::max(self : MlrlqlearningLayer) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningLayer::to_string(self : MlrlqlearningLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_buffer_make(size : Int) -> MlrlqlearningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningBuffer::len(self : MlrlqlearningBuffer) -> Int { self.size }

pub fn MlrlqlearningBuffer::get(self : MlrlqlearningBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningBuffer::set(self : MlrlqlearningBuffer, i : Int, v : Double) -> MlrlqlearningBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningBuffer::sum(self : MlrlqlearningBuffer) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningBuffer::mean(self : MlrlqlearningBuffer) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningBuffer::scale(self : MlrlqlearningBuffer, f : Double) -> MlrlqlearningBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningBuffer::add(self : MlrlqlearningBuffer, other : MlrlqlearningBuffer) -> MlrlqlearningBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningBuffer::copy(self : MlrlqlearningBuffer) -> MlrlqlearningBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningBuffer::fill(self : MlrlqlearningBuffer, v : Double) -> MlrlqlearningBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningBuffer::min(self : MlrlqlearningBuffer) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningBuffer::max(self : MlrlqlearningBuffer) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningBuffer::to_string(self : MlrlqlearningBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_cursor_make(size : Int) -> MlrlqlearningCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningCursor::len(self : MlrlqlearningCursor) -> Int { self.size }

pub fn MlrlqlearningCursor::get(self : MlrlqlearningCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningCursor::set(self : MlrlqlearningCursor, i : Int, v : Double) -> MlrlqlearningCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningCursor::sum(self : MlrlqlearningCursor) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningCursor::mean(self : MlrlqlearningCursor) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningCursor::scale(self : MlrlqlearningCursor, f : Double) -> MlrlqlearningCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningCursor::add(self : MlrlqlearningCursor, other : MlrlqlearningCursor) -> MlrlqlearningCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningCursor::copy(self : MlrlqlearningCursor) -> MlrlqlearningCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningCursor::fill(self : MlrlqlearningCursor, v : Double) -> MlrlqlearningCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningCursor::min(self : MlrlqlearningCursor) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningCursor::max(self : MlrlqlearningCursor) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningCursor::to_string(self : MlrlqlearningCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_view_make(size : Int) -> MlrlqlearningView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningView::len(self : MlrlqlearningView) -> Int { self.size }

pub fn MlrlqlearningView::get(self : MlrlqlearningView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningView::set(self : MlrlqlearningView, i : Int, v : Double) -> MlrlqlearningView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningView::sum(self : MlrlqlearningView) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningView::mean(self : MlrlqlearningView) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningView::scale(self : MlrlqlearningView, f : Double) -> MlrlqlearningView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningView::add(self : MlrlqlearningView, other : MlrlqlearningView) -> MlrlqlearningView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningView::copy(self : MlrlqlearningView) -> MlrlqlearningView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningView::fill(self : MlrlqlearningView, v : Double) -> MlrlqlearningView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningView::min(self : MlrlqlearningView) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningView::max(self : MlrlqlearningView) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningView::to_string(self : MlrlqlearningView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_range_make(size : Int) -> MlrlqlearningRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningRange::len(self : MlrlqlearningRange) -> Int { self.size }

pub fn MlrlqlearningRange::get(self : MlrlqlearningRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningRange::set(self : MlrlqlearningRange, i : Int, v : Double) -> MlrlqlearningRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningRange::sum(self : MlrlqlearningRange) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningRange::mean(self : MlrlqlearningRange) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningRange::scale(self : MlrlqlearningRange, f : Double) -> MlrlqlearningRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningRange::add(self : MlrlqlearningRange, other : MlrlqlearningRange) -> MlrlqlearningRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningRange::copy(self : MlrlqlearningRange) -> MlrlqlearningRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningRange::fill(self : MlrlqlearningRange, v : Double) -> MlrlqlearningRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningRange::min(self : MlrlqlearningRange) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningRange::max(self : MlrlqlearningRange) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningRange::to_string(self : MlrlqlearningRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_slice_make(size : Int) -> MlrlqlearningSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlqlearningSlice::len(self : MlrlqlearningSlice) -> Int { self.size }

pub fn MlrlqlearningSlice::get(self : MlrlqlearningSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlqlearningSlice::set(self : MlrlqlearningSlice, i : Int, v : Double) -> MlrlqlearningSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlqlearningSlice::sum(self : MlrlqlearningSlice) -> Double { @_common.sum(self.data) }

pub fn MlrlqlearningSlice::mean(self : MlrlqlearningSlice) -> Double { @_common.mean(self.data) }

pub fn MlrlqlearningSlice::scale(self : MlrlqlearningSlice, f : Double) -> MlrlqlearningSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningSlice::add(self : MlrlqlearningSlice, other : MlrlqlearningSlice) -> MlrlqlearningSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlqlearningSlice::copy(self : MlrlqlearningSlice) -> MlrlqlearningSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningSlice::fill(self : MlrlqlearningSlice, v : Double) -> MlrlqlearningSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlqlearningSlice::min(self : MlrlqlearningSlice) -> Double { @_common.min(self.data) }

pub fn MlrlqlearningSlice::max(self : MlrlqlearningSlice) -> Double { @_common.max(self.data) }

pub fn MlrlqlearningSlice::to_string(self : MlrlqlearningSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

