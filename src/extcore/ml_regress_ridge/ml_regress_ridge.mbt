///===
/// extcore/ml_regress_ridge

pub(all) struct MlregressridgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_ridge_make_point(x : Double, y : Double) -> MlregressridgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_ridge_make_point3(x : Double, y : Double, z : Double) -> MlregressridgePoint {
  { x, y, z, label: 0 }
}

pub fn MlregressridgePoint::x(self : MlregressridgePoint) -> Double { self.x }

pub fn MlregressridgePoint::y(self : MlregressridgePoint) -> Double { self.y }

pub fn MlregressridgePoint::z(self : MlregressridgePoint) -> Double { self.z }

pub fn MlregressridgePoint::label(self : MlregressridgePoint) -> Int { self.label }

pub fn MlregressridgePoint::dist(self : MlregressridgePoint, other : MlregressridgePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregressridgePoint::add(self : MlregressridgePoint, other : MlregressridgePoint) -> MlregressridgePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregressridgePoint::sub(self : MlregressridgePoint, other : MlregressridgePoint) -> MlregressridgePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregressridgePoint::scale(self : MlregressridgePoint, s : Double) -> MlregressridgePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregressridgePoint::dot(self : MlregressridgePoint, other : MlregressridgePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregressridgePoint::cross(self : MlregressridgePoint, other : MlregressridgePoint) -> MlregressridgePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregressridgePoint::norm(self : MlregressridgePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregressridgePoint::normalize(self : MlregressridgePoint) -> MlregressridgePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressridgePoint::negate(self : MlregressridgePoint) -> MlregressridgePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregressridgePoint::mid(self : MlregressridgePoint, other : MlregressridgePoint) -> MlregressridgePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregressridgePoint::lerp(self : MlregressridgePoint, other : MlregressridgePoint, t : Double) -> MlregressridgePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregressridgePoint::to_string(self : MlregressridgePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregressridgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_ridge_make_series(vals : Array[Double], name : String) -> MlregressridgeSeries {
  { vals, name, meta: 0 }
}

pub fn MlregressridgeSeries::len(self : MlregressridgeSeries) -> Int { self.vals.length() }

pub fn MlregressridgeSeries::sum(self : MlregressridgeSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregressridgeSeries::mean(self : MlregressridgeSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregressridgeSeries::min(self : MlregressridgeSeries) -> Double { @_common.min(self.vals) }

pub fn MlregressridgeSeries::max(self : MlregressridgeSeries) -> Double { @_common.max(self.vals) }

pub fn MlregressridgeSeries::range(self : MlregressridgeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregressridgeSeries::variance(self : MlregressridgeSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregressridgeSeries::std(self : MlregressridgeSeries) -> Double { @_common.std(self.vals) }

pub fn MlregressridgeSeries::median(self : MlregressridgeSeries) -> Double { @_common.median(self.vals) }

pub fn MlregressridgeSeries::scale(self : MlregressridgeSeries, f : Double) -> MlregressridgeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregressridgeSeries::add(self : MlregressridgeSeries, other : MlregressridgeSeries) -> MlregressridgeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregressridgeSeries::sub(self : MlregressridgeSeries, other : MlregressridgeSeries) -> MlregressridgeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregressridgeSeries::normalize(self : MlregressridgeSeries) -> MlregressridgeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregressridgeSeries::cumsum(self : MlregressridgeSeries) -> MlregressridgeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregressridgeSeries::to_string(self : MlregressridgeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressridgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_ridge_make_matrix(rows : Int, cols : Int, val : Double) -> MlregressridgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_ridge_matrix_identity(n : Int) -> MlregressridgeMatrix {
  let m = ml_regress_ridge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregressridgeMatrix::get(self : MlregressridgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregressridgeMatrix::transpose(self : MlregressridgeMatrix) -> MlregressridgeMatrix {
  let result = ml_regress_ridge_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregressridgeMatrix::add(self : MlregressridgeMatrix, other : MlregressridgeMatrix) -> MlregressridgeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_ridge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregressridgeMatrix::scale(self : MlregressridgeMatrix, s : Double) -> MlregressridgeMatrix {
  let result = ml_regress_ridge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregressridgeMatrix::multiply(self : MlregressridgeMatrix, other : MlregressridgeMatrix) -> MlregressridgeMatrix {
  if self.cols != other.rows { return ml_regress_ridge_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_ridge_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlregressridgeMatrix::trace(self : MlregressridgeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregressridgeMatrix::det(self : MlregressridgeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregressridgeMatrix::norm(self : MlregressridgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregressridgeMatrix::to_string(self : MlregressridgeMatrix) -> String {
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

pub(all) struct MlregressridgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_ridge_make_vector(comps : Array[Double]) -> MlregressridgeVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_ridge_vector_zero(dim : Int) -> MlregressridgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregressridgeVector::add(self : MlregressridgeVector, other : MlregressridgeVector) -> MlregressridgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressridgeVector::sub(self : MlregressridgeVector, other : MlregressridgeVector) -> MlregressridgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressridgeVector::scale(self : MlregressridgeVector, s : Double) -> MlregressridgeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregressridgeVector::dot(self : MlregressridgeVector, other : MlregressridgeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregressridgeVector::norm(self : MlregressridgeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregressridgeVector::normalize(self : MlregressridgeVector) -> MlregressridgeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressridgeVector::dist(self : MlregressridgeVector, other : MlregressridgeVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregressridgeVector::to_string(self : MlregressridgeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressridgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_frame_make(size : Int) -> MlregressridgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeFrame::len(self : MlregressridgeFrame) -> Int { self.size }

pub fn MlregressridgeFrame::get(self : MlregressridgeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeFrame::set(self : MlregressridgeFrame, i : Int, v : Double) -> MlregressridgeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeFrame::sum(self : MlregressridgeFrame) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeFrame::mean(self : MlregressridgeFrame) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeFrame::scale(self : MlregressridgeFrame, f : Double) -> MlregressridgeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeFrame::add(self : MlregressridgeFrame, other : MlregressridgeFrame) -> MlregressridgeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeFrame::copy(self : MlregressridgeFrame) -> MlregressridgeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeFrame::fill(self : MlregressridgeFrame, v : Double) -> MlregressridgeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeFrame::min(self : MlregressridgeFrame) -> Double { @_common.min(self.data) }

pub fn MlregressridgeFrame::max(self : MlregressridgeFrame) -> Double { @_common.max(self.data) }

pub fn MlregressridgeFrame::to_string(self : MlregressridgeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_table_make(size : Int) -> MlregressridgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeTable::len(self : MlregressridgeTable) -> Int { self.size }

pub fn MlregressridgeTable::get(self : MlregressridgeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeTable::set(self : MlregressridgeTable, i : Int, v : Double) -> MlregressridgeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeTable::sum(self : MlregressridgeTable) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeTable::mean(self : MlregressridgeTable) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeTable::scale(self : MlregressridgeTable, f : Double) -> MlregressridgeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeTable::add(self : MlregressridgeTable, other : MlregressridgeTable) -> MlregressridgeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeTable::copy(self : MlregressridgeTable) -> MlregressridgeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeTable::fill(self : MlregressridgeTable, v : Double) -> MlregressridgeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeTable::min(self : MlregressridgeTable) -> Double { @_common.min(self.data) }

pub fn MlregressridgeTable::max(self : MlregressridgeTable) -> Double { @_common.max(self.data) }

pub fn MlregressridgeTable::to_string(self : MlregressridgeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_graphn_make(size : Int) -> MlregressridgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeGraphN::len(self : MlregressridgeGraphN) -> Int { self.size }

pub fn MlregressridgeGraphN::get(self : MlregressridgeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeGraphN::set(self : MlregressridgeGraphN, i : Int, v : Double) -> MlregressridgeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeGraphN::sum(self : MlregressridgeGraphN) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeGraphN::mean(self : MlregressridgeGraphN) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeGraphN::scale(self : MlregressridgeGraphN, f : Double) -> MlregressridgeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeGraphN::add(self : MlregressridgeGraphN, other : MlregressridgeGraphN) -> MlregressridgeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeGraphN::copy(self : MlregressridgeGraphN) -> MlregressridgeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeGraphN::fill(self : MlregressridgeGraphN, v : Double) -> MlregressridgeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeGraphN::min(self : MlregressridgeGraphN) -> Double { @_common.min(self.data) }

pub fn MlregressridgeGraphN::max(self : MlregressridgeGraphN) -> Double { @_common.max(self.data) }

pub fn MlregressridgeGraphN::to_string(self : MlregressridgeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_node_make(size : Int) -> MlregressridgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeNode::len(self : MlregressridgeNode) -> Int { self.size }

pub fn MlregressridgeNode::get(self : MlregressridgeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeNode::set(self : MlregressridgeNode, i : Int, v : Double) -> MlregressridgeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeNode::sum(self : MlregressridgeNode) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeNode::mean(self : MlregressridgeNode) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeNode::scale(self : MlregressridgeNode, f : Double) -> MlregressridgeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeNode::add(self : MlregressridgeNode, other : MlregressridgeNode) -> MlregressridgeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeNode::copy(self : MlregressridgeNode) -> MlregressridgeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeNode::fill(self : MlregressridgeNode, v : Double) -> MlregressridgeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeNode::min(self : MlregressridgeNode) -> Double { @_common.min(self.data) }

pub fn MlregressridgeNode::max(self : MlregressridgeNode) -> Double { @_common.max(self.data) }

pub fn MlregressridgeNode::to_string(self : MlregressridgeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_edge_make(size : Int) -> MlregressridgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeEdge::len(self : MlregressridgeEdge) -> Int { self.size }

pub fn MlregressridgeEdge::get(self : MlregressridgeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeEdge::set(self : MlregressridgeEdge, i : Int, v : Double) -> MlregressridgeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeEdge::sum(self : MlregressridgeEdge) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeEdge::mean(self : MlregressridgeEdge) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeEdge::scale(self : MlregressridgeEdge, f : Double) -> MlregressridgeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeEdge::add(self : MlregressridgeEdge, other : MlregressridgeEdge) -> MlregressridgeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeEdge::copy(self : MlregressridgeEdge) -> MlregressridgeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeEdge::fill(self : MlregressridgeEdge, v : Double) -> MlregressridgeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeEdge::min(self : MlregressridgeEdge) -> Double { @_common.min(self.data) }

pub fn MlregressridgeEdge::max(self : MlregressridgeEdge) -> Double { @_common.max(self.data) }

pub fn MlregressridgeEdge::to_string(self : MlregressridgeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_path_make(size : Int) -> MlregressridgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgePath::len(self : MlregressridgePath) -> Int { self.size }

pub fn MlregressridgePath::get(self : MlregressridgePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgePath::set(self : MlregressridgePath, i : Int, v : Double) -> MlregressridgePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgePath::sum(self : MlregressridgePath) -> Double { @_common.sum(self.data) }

pub fn MlregressridgePath::mean(self : MlregressridgePath) -> Double { @_common.mean(self.data) }

pub fn MlregressridgePath::scale(self : MlregressridgePath, f : Double) -> MlregressridgePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgePath::add(self : MlregressridgePath, other : MlregressridgePath) -> MlregressridgePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgePath::copy(self : MlregressridgePath) -> MlregressridgePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgePath::fill(self : MlregressridgePath, v : Double) -> MlregressridgePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgePath::min(self : MlregressridgePath) -> Double { @_common.min(self.data) }

pub fn MlregressridgePath::max(self : MlregressridgePath) -> Double { @_common.max(self.data) }

pub fn MlregressridgePath::to_string(self : MlregressridgePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_cluster_make(size : Int) -> MlregressridgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeCluster::len(self : MlregressridgeCluster) -> Int { self.size }

pub fn MlregressridgeCluster::get(self : MlregressridgeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeCluster::set(self : MlregressridgeCluster, i : Int, v : Double) -> MlregressridgeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeCluster::sum(self : MlregressridgeCluster) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeCluster::mean(self : MlregressridgeCluster) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeCluster::scale(self : MlregressridgeCluster, f : Double) -> MlregressridgeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeCluster::add(self : MlregressridgeCluster, other : MlregressridgeCluster) -> MlregressridgeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeCluster::copy(self : MlregressridgeCluster) -> MlregressridgeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeCluster::fill(self : MlregressridgeCluster, v : Double) -> MlregressridgeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeCluster::min(self : MlregressridgeCluster) -> Double { @_common.min(self.data) }

pub fn MlregressridgeCluster::max(self : MlregressridgeCluster) -> Double { @_common.max(self.data) }

pub fn MlregressridgeCluster::to_string(self : MlregressridgeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_model_make(size : Int) -> MlregressridgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeModel::len(self : MlregressridgeModel) -> Int { self.size }

pub fn MlregressridgeModel::get(self : MlregressridgeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeModel::set(self : MlregressridgeModel, i : Int, v : Double) -> MlregressridgeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeModel::sum(self : MlregressridgeModel) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeModel::mean(self : MlregressridgeModel) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeModel::scale(self : MlregressridgeModel, f : Double) -> MlregressridgeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeModel::add(self : MlregressridgeModel, other : MlregressridgeModel) -> MlregressridgeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeModel::copy(self : MlregressridgeModel) -> MlregressridgeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeModel::fill(self : MlregressridgeModel, v : Double) -> MlregressridgeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeModel::min(self : MlregressridgeModel) -> Double { @_common.min(self.data) }

pub fn MlregressridgeModel::max(self : MlregressridgeModel) -> Double { @_common.max(self.data) }

pub fn MlregressridgeModel::to_string(self : MlregressridgeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_layer_make(size : Int) -> MlregressridgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeLayer::len(self : MlregressridgeLayer) -> Int { self.size }

pub fn MlregressridgeLayer::get(self : MlregressridgeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeLayer::set(self : MlregressridgeLayer, i : Int, v : Double) -> MlregressridgeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeLayer::sum(self : MlregressridgeLayer) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeLayer::mean(self : MlregressridgeLayer) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeLayer::scale(self : MlregressridgeLayer, f : Double) -> MlregressridgeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeLayer::add(self : MlregressridgeLayer, other : MlregressridgeLayer) -> MlregressridgeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeLayer::copy(self : MlregressridgeLayer) -> MlregressridgeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeLayer::fill(self : MlregressridgeLayer, v : Double) -> MlregressridgeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeLayer::min(self : MlregressridgeLayer) -> Double { @_common.min(self.data) }

pub fn MlregressridgeLayer::max(self : MlregressridgeLayer) -> Double { @_common.max(self.data) }

pub fn MlregressridgeLayer::to_string(self : MlregressridgeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_buffer_make(size : Int) -> MlregressridgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeBuffer::len(self : MlregressridgeBuffer) -> Int { self.size }

pub fn MlregressridgeBuffer::get(self : MlregressridgeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeBuffer::set(self : MlregressridgeBuffer, i : Int, v : Double) -> MlregressridgeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeBuffer::sum(self : MlregressridgeBuffer) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeBuffer::mean(self : MlregressridgeBuffer) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeBuffer::scale(self : MlregressridgeBuffer, f : Double) -> MlregressridgeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeBuffer::add(self : MlregressridgeBuffer, other : MlregressridgeBuffer) -> MlregressridgeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeBuffer::copy(self : MlregressridgeBuffer) -> MlregressridgeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeBuffer::fill(self : MlregressridgeBuffer, v : Double) -> MlregressridgeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeBuffer::min(self : MlregressridgeBuffer) -> Double { @_common.min(self.data) }

pub fn MlregressridgeBuffer::max(self : MlregressridgeBuffer) -> Double { @_common.max(self.data) }

pub fn MlregressridgeBuffer::to_string(self : MlregressridgeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_cursor_make(size : Int) -> MlregressridgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeCursor::len(self : MlregressridgeCursor) -> Int { self.size }

pub fn MlregressridgeCursor::get(self : MlregressridgeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeCursor::set(self : MlregressridgeCursor, i : Int, v : Double) -> MlregressridgeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeCursor::sum(self : MlregressridgeCursor) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeCursor::mean(self : MlregressridgeCursor) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeCursor::scale(self : MlregressridgeCursor, f : Double) -> MlregressridgeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeCursor::add(self : MlregressridgeCursor, other : MlregressridgeCursor) -> MlregressridgeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeCursor::copy(self : MlregressridgeCursor) -> MlregressridgeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeCursor::fill(self : MlregressridgeCursor, v : Double) -> MlregressridgeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeCursor::min(self : MlregressridgeCursor) -> Double { @_common.min(self.data) }

pub fn MlregressridgeCursor::max(self : MlregressridgeCursor) -> Double { @_common.max(self.data) }

pub fn MlregressridgeCursor::to_string(self : MlregressridgeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_view_make(size : Int) -> MlregressridgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeView::len(self : MlregressridgeView) -> Int { self.size }

pub fn MlregressridgeView::get(self : MlregressridgeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeView::set(self : MlregressridgeView, i : Int, v : Double) -> MlregressridgeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeView::sum(self : MlregressridgeView) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeView::mean(self : MlregressridgeView) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeView::scale(self : MlregressridgeView, f : Double) -> MlregressridgeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeView::add(self : MlregressridgeView, other : MlregressridgeView) -> MlregressridgeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeView::copy(self : MlregressridgeView) -> MlregressridgeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeView::fill(self : MlregressridgeView, v : Double) -> MlregressridgeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeView::min(self : MlregressridgeView) -> Double { @_common.min(self.data) }

pub fn MlregressridgeView::max(self : MlregressridgeView) -> Double { @_common.max(self.data) }

pub fn MlregressridgeView::to_string(self : MlregressridgeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_range_make(size : Int) -> MlregressridgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeRange::len(self : MlregressridgeRange) -> Int { self.size }

pub fn MlregressridgeRange::get(self : MlregressridgeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeRange::set(self : MlregressridgeRange, i : Int, v : Double) -> MlregressridgeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeRange::sum(self : MlregressridgeRange) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeRange::mean(self : MlregressridgeRange) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeRange::scale(self : MlregressridgeRange, f : Double) -> MlregressridgeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeRange::add(self : MlregressridgeRange, other : MlregressridgeRange) -> MlregressridgeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeRange::copy(self : MlregressridgeRange) -> MlregressridgeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeRange::fill(self : MlregressridgeRange, v : Double) -> MlregressridgeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeRange::min(self : MlregressridgeRange) -> Double { @_common.min(self.data) }

pub fn MlregressridgeRange::max(self : MlregressridgeRange) -> Double { @_common.max(self.data) }

pub fn MlregressridgeRange::to_string(self : MlregressridgeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlregressridgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_slice_make(size : Int) -> MlregressridgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlregressridgeSlice::len(self : MlregressridgeSlice) -> Int { self.size }

pub fn MlregressridgeSlice::get(self : MlregressridgeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlregressridgeSlice::set(self : MlregressridgeSlice, i : Int, v : Double) -> MlregressridgeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlregressridgeSlice::sum(self : MlregressridgeSlice) -> Double { @_common.sum(self.data) }

pub fn MlregressridgeSlice::mean(self : MlregressridgeSlice) -> Double { @_common.mean(self.data) }

pub fn MlregressridgeSlice::scale(self : MlregressridgeSlice, f : Double) -> MlregressridgeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlregressridgeSlice::add(self : MlregressridgeSlice, other : MlregressridgeSlice) -> MlregressridgeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlregressridgeSlice::copy(self : MlregressridgeSlice) -> MlregressridgeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlregressridgeSlice::fill(self : MlregressridgeSlice, v : Double) -> MlregressridgeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlregressridgeSlice::min(self : MlregressridgeSlice) -> Double { @_common.min(self.data) }

pub fn MlregressridgeSlice::max(self : MlregressridgeSlice) -> Double { @_common.max(self.data) }

pub fn MlregressridgeSlice::to_string(self : MlregressridgeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

