///===
/// extcore/ml_rl_policy_grad

pub(all) struct MlrlpolicygradPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_policy_grad_make_point(x : Double, y : Double) -> MlrlpolicygradPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_policy_grad_make_point3(x : Double, y : Double, z : Double) -> MlrlpolicygradPoint {
  { x, y, z, label: 0 }
}

pub fn MlrlpolicygradPoint::x(self : MlrlpolicygradPoint) -> Double { self.x }

pub fn MlrlpolicygradPoint::y(self : MlrlpolicygradPoint) -> Double { self.y }

pub fn MlrlpolicygradPoint::z(self : MlrlpolicygradPoint) -> Double { self.z }

pub fn MlrlpolicygradPoint::label(self : MlrlpolicygradPoint) -> Int { self.label }

pub fn MlrlpolicygradPoint::dist(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrlpolicygradPoint::add(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrlpolicygradPoint::sub(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrlpolicygradPoint::scale(self : MlrlpolicygradPoint, s : Double) -> MlrlpolicygradPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrlpolicygradPoint::dot(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrlpolicygradPoint::cross(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrlpolicygradPoint::norm(self : MlrlpolicygradPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrlpolicygradPoint::normalize(self : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlpolicygradPoint::negate(self : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrlpolicygradPoint::mid(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrlpolicygradPoint::lerp(self : MlrlpolicygradPoint, other : MlrlpolicygradPoint, t : Double) -> MlrlpolicygradPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrlpolicygradPoint::to_string(self : MlrlpolicygradPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrlpolicygradSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_policy_grad_make_series(vals : Array[Double], name : String) -> MlrlpolicygradSeries {
  { vals, name, meta: 0 }
}

pub fn MlrlpolicygradSeries::len(self : MlrlpolicygradSeries) -> Int { self.vals.length() }

pub fn MlrlpolicygradSeries::sum(self : MlrlpolicygradSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrlpolicygradSeries::mean(self : MlrlpolicygradSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrlpolicygradSeries::min(self : MlrlpolicygradSeries) -> Double { @_common.min(self.vals) }

pub fn MlrlpolicygradSeries::max(self : MlrlpolicygradSeries) -> Double { @_common.max(self.vals) }

pub fn MlrlpolicygradSeries::range(self : MlrlpolicygradSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrlpolicygradSeries::variance(self : MlrlpolicygradSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrlpolicygradSeries::std(self : MlrlpolicygradSeries) -> Double { @_common.std(self.vals) }

pub fn MlrlpolicygradSeries::median(self : MlrlpolicygradSeries) -> Double { @_common.median(self.vals) }

pub fn MlrlpolicygradSeries::scale(self : MlrlpolicygradSeries, f : Double) -> MlrlpolicygradSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrlpolicygradSeries::add(self : MlrlpolicygradSeries, other : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrlpolicygradSeries::sub(self : MlrlpolicygradSeries, other : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrlpolicygradSeries::normalize(self : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrlpolicygradSeries::cumsum(self : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrlpolicygradSeries::to_string(self : MlrlpolicygradSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlpolicygradMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_policy_grad_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlpolicygradMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_policy_grad_matrix_identity(n : Int) -> MlrlpolicygradMatrix {
  let m = ml_rl_policy_grad_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrlpolicygradMatrix::get(self : MlrlpolicygradMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrlpolicygradMatrix::transpose(self : MlrlpolicygradMatrix) -> MlrlpolicygradMatrix {
  let result = ml_rl_policy_grad_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrlpolicygradMatrix::add(self : MlrlpolicygradMatrix, other : MlrlpolicygradMatrix) -> MlrlpolicygradMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_policy_grad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrlpolicygradMatrix::scale(self : MlrlpolicygradMatrix, s : Double) -> MlrlpolicygradMatrix {
  let result = ml_rl_policy_grad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrlpolicygradMatrix::multiply(self : MlrlpolicygradMatrix, other : MlrlpolicygradMatrix) -> MlrlpolicygradMatrix {
  if self.cols != other.rows { return ml_rl_policy_grad_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_policy_grad_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlrlpolicygradMatrix::trace(self : MlrlpolicygradMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrlpolicygradMatrix::det(self : MlrlpolicygradMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrlpolicygradMatrix::norm(self : MlrlpolicygradMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrlpolicygradMatrix::to_string(self : MlrlpolicygradMatrix) -> String {
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

pub(all) struct MlrlpolicygradVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_policy_grad_make_vector(comps : Array[Double]) -> MlrlpolicygradVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_policy_grad_vector_zero(dim : Int) -> MlrlpolicygradVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrlpolicygradVector::add(self : MlrlpolicygradVector, other : MlrlpolicygradVector) -> MlrlpolicygradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlpolicygradVector::sub(self : MlrlpolicygradVector, other : MlrlpolicygradVector) -> MlrlpolicygradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlpolicygradVector::scale(self : MlrlpolicygradVector, s : Double) -> MlrlpolicygradVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrlpolicygradVector::dot(self : MlrlpolicygradVector, other : MlrlpolicygradVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrlpolicygradVector::norm(self : MlrlpolicygradVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrlpolicygradVector::normalize(self : MlrlpolicygradVector) -> MlrlpolicygradVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlpolicygradVector::dist(self : MlrlpolicygradVector, other : MlrlpolicygradVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrlpolicygradVector::to_string(self : MlrlpolicygradVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlpolicygradFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_frame_make(size : Int) -> MlrlpolicygradFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradFrame::len(self : MlrlpolicygradFrame) -> Int { self.size }

pub fn MlrlpolicygradFrame::get(self : MlrlpolicygradFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradFrame::set(self : MlrlpolicygradFrame, i : Int, v : Double) -> MlrlpolicygradFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradFrame::sum(self : MlrlpolicygradFrame) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradFrame::mean(self : MlrlpolicygradFrame) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradFrame::scale(self : MlrlpolicygradFrame, f : Double) -> MlrlpolicygradFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradFrame::add(self : MlrlpolicygradFrame, other : MlrlpolicygradFrame) -> MlrlpolicygradFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradFrame::copy(self : MlrlpolicygradFrame) -> MlrlpolicygradFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradFrame::fill(self : MlrlpolicygradFrame, v : Double) -> MlrlpolicygradFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradFrame::min(self : MlrlpolicygradFrame) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradFrame::max(self : MlrlpolicygradFrame) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradFrame::to_string(self : MlrlpolicygradFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_table_make(size : Int) -> MlrlpolicygradTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradTable::len(self : MlrlpolicygradTable) -> Int { self.size }

pub fn MlrlpolicygradTable::get(self : MlrlpolicygradTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradTable::set(self : MlrlpolicygradTable, i : Int, v : Double) -> MlrlpolicygradTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradTable::sum(self : MlrlpolicygradTable) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradTable::mean(self : MlrlpolicygradTable) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradTable::scale(self : MlrlpolicygradTable, f : Double) -> MlrlpolicygradTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradTable::add(self : MlrlpolicygradTable, other : MlrlpolicygradTable) -> MlrlpolicygradTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradTable::copy(self : MlrlpolicygradTable) -> MlrlpolicygradTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradTable::fill(self : MlrlpolicygradTable, v : Double) -> MlrlpolicygradTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradTable::min(self : MlrlpolicygradTable) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradTable::max(self : MlrlpolicygradTable) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradTable::to_string(self : MlrlpolicygradTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_graphn_make(size : Int) -> MlrlpolicygradGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradGraphN::len(self : MlrlpolicygradGraphN) -> Int { self.size }

pub fn MlrlpolicygradGraphN::get(self : MlrlpolicygradGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradGraphN::set(self : MlrlpolicygradGraphN, i : Int, v : Double) -> MlrlpolicygradGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradGraphN::sum(self : MlrlpolicygradGraphN) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradGraphN::mean(self : MlrlpolicygradGraphN) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradGraphN::scale(self : MlrlpolicygradGraphN, f : Double) -> MlrlpolicygradGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradGraphN::add(self : MlrlpolicygradGraphN, other : MlrlpolicygradGraphN) -> MlrlpolicygradGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradGraphN::copy(self : MlrlpolicygradGraphN) -> MlrlpolicygradGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradGraphN::fill(self : MlrlpolicygradGraphN, v : Double) -> MlrlpolicygradGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradGraphN::min(self : MlrlpolicygradGraphN) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradGraphN::max(self : MlrlpolicygradGraphN) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradGraphN::to_string(self : MlrlpolicygradGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_node_make(size : Int) -> MlrlpolicygradNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradNode::len(self : MlrlpolicygradNode) -> Int { self.size }

pub fn MlrlpolicygradNode::get(self : MlrlpolicygradNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradNode::set(self : MlrlpolicygradNode, i : Int, v : Double) -> MlrlpolicygradNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradNode::sum(self : MlrlpolicygradNode) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradNode::mean(self : MlrlpolicygradNode) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradNode::scale(self : MlrlpolicygradNode, f : Double) -> MlrlpolicygradNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradNode::add(self : MlrlpolicygradNode, other : MlrlpolicygradNode) -> MlrlpolicygradNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradNode::copy(self : MlrlpolicygradNode) -> MlrlpolicygradNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradNode::fill(self : MlrlpolicygradNode, v : Double) -> MlrlpolicygradNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradNode::min(self : MlrlpolicygradNode) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradNode::max(self : MlrlpolicygradNode) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradNode::to_string(self : MlrlpolicygradNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_edge_make(size : Int) -> MlrlpolicygradEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradEdge::len(self : MlrlpolicygradEdge) -> Int { self.size }

pub fn MlrlpolicygradEdge::get(self : MlrlpolicygradEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradEdge::set(self : MlrlpolicygradEdge, i : Int, v : Double) -> MlrlpolicygradEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradEdge::sum(self : MlrlpolicygradEdge) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradEdge::mean(self : MlrlpolicygradEdge) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradEdge::scale(self : MlrlpolicygradEdge, f : Double) -> MlrlpolicygradEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradEdge::add(self : MlrlpolicygradEdge, other : MlrlpolicygradEdge) -> MlrlpolicygradEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradEdge::copy(self : MlrlpolicygradEdge) -> MlrlpolicygradEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradEdge::fill(self : MlrlpolicygradEdge, v : Double) -> MlrlpolicygradEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradEdge::min(self : MlrlpolicygradEdge) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradEdge::max(self : MlrlpolicygradEdge) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradEdge::to_string(self : MlrlpolicygradEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_path_make(size : Int) -> MlrlpolicygradPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradPath::len(self : MlrlpolicygradPath) -> Int { self.size }

pub fn MlrlpolicygradPath::get(self : MlrlpolicygradPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradPath::set(self : MlrlpolicygradPath, i : Int, v : Double) -> MlrlpolicygradPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradPath::sum(self : MlrlpolicygradPath) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradPath::mean(self : MlrlpolicygradPath) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradPath::scale(self : MlrlpolicygradPath, f : Double) -> MlrlpolicygradPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradPath::add(self : MlrlpolicygradPath, other : MlrlpolicygradPath) -> MlrlpolicygradPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradPath::copy(self : MlrlpolicygradPath) -> MlrlpolicygradPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradPath::fill(self : MlrlpolicygradPath, v : Double) -> MlrlpolicygradPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradPath::min(self : MlrlpolicygradPath) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradPath::max(self : MlrlpolicygradPath) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradPath::to_string(self : MlrlpolicygradPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_cluster_make(size : Int) -> MlrlpolicygradCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradCluster::len(self : MlrlpolicygradCluster) -> Int { self.size }

pub fn MlrlpolicygradCluster::get(self : MlrlpolicygradCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradCluster::set(self : MlrlpolicygradCluster, i : Int, v : Double) -> MlrlpolicygradCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradCluster::sum(self : MlrlpolicygradCluster) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradCluster::mean(self : MlrlpolicygradCluster) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradCluster::scale(self : MlrlpolicygradCluster, f : Double) -> MlrlpolicygradCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradCluster::add(self : MlrlpolicygradCluster, other : MlrlpolicygradCluster) -> MlrlpolicygradCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradCluster::copy(self : MlrlpolicygradCluster) -> MlrlpolicygradCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradCluster::fill(self : MlrlpolicygradCluster, v : Double) -> MlrlpolicygradCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradCluster::min(self : MlrlpolicygradCluster) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradCluster::max(self : MlrlpolicygradCluster) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradCluster::to_string(self : MlrlpolicygradCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_model_make(size : Int) -> MlrlpolicygradModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradModel::len(self : MlrlpolicygradModel) -> Int { self.size }

pub fn MlrlpolicygradModel::get(self : MlrlpolicygradModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradModel::set(self : MlrlpolicygradModel, i : Int, v : Double) -> MlrlpolicygradModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradModel::sum(self : MlrlpolicygradModel) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradModel::mean(self : MlrlpolicygradModel) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradModel::scale(self : MlrlpolicygradModel, f : Double) -> MlrlpolicygradModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradModel::add(self : MlrlpolicygradModel, other : MlrlpolicygradModel) -> MlrlpolicygradModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradModel::copy(self : MlrlpolicygradModel) -> MlrlpolicygradModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradModel::fill(self : MlrlpolicygradModel, v : Double) -> MlrlpolicygradModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradModel::min(self : MlrlpolicygradModel) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradModel::max(self : MlrlpolicygradModel) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradModel::to_string(self : MlrlpolicygradModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_layer_make(size : Int) -> MlrlpolicygradLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradLayer::len(self : MlrlpolicygradLayer) -> Int { self.size }

pub fn MlrlpolicygradLayer::get(self : MlrlpolicygradLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradLayer::set(self : MlrlpolicygradLayer, i : Int, v : Double) -> MlrlpolicygradLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradLayer::sum(self : MlrlpolicygradLayer) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradLayer::mean(self : MlrlpolicygradLayer) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradLayer::scale(self : MlrlpolicygradLayer, f : Double) -> MlrlpolicygradLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradLayer::add(self : MlrlpolicygradLayer, other : MlrlpolicygradLayer) -> MlrlpolicygradLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradLayer::copy(self : MlrlpolicygradLayer) -> MlrlpolicygradLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradLayer::fill(self : MlrlpolicygradLayer, v : Double) -> MlrlpolicygradLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradLayer::min(self : MlrlpolicygradLayer) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradLayer::max(self : MlrlpolicygradLayer) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradLayer::to_string(self : MlrlpolicygradLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_buffer_make(size : Int) -> MlrlpolicygradBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradBuffer::len(self : MlrlpolicygradBuffer) -> Int { self.size }

pub fn MlrlpolicygradBuffer::get(self : MlrlpolicygradBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradBuffer::set(self : MlrlpolicygradBuffer, i : Int, v : Double) -> MlrlpolicygradBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradBuffer::sum(self : MlrlpolicygradBuffer) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradBuffer::mean(self : MlrlpolicygradBuffer) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradBuffer::scale(self : MlrlpolicygradBuffer, f : Double) -> MlrlpolicygradBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradBuffer::add(self : MlrlpolicygradBuffer, other : MlrlpolicygradBuffer) -> MlrlpolicygradBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradBuffer::copy(self : MlrlpolicygradBuffer) -> MlrlpolicygradBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradBuffer::fill(self : MlrlpolicygradBuffer, v : Double) -> MlrlpolicygradBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradBuffer::min(self : MlrlpolicygradBuffer) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradBuffer::max(self : MlrlpolicygradBuffer) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradBuffer::to_string(self : MlrlpolicygradBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_cursor_make(size : Int) -> MlrlpolicygradCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradCursor::len(self : MlrlpolicygradCursor) -> Int { self.size }

pub fn MlrlpolicygradCursor::get(self : MlrlpolicygradCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradCursor::set(self : MlrlpolicygradCursor, i : Int, v : Double) -> MlrlpolicygradCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradCursor::sum(self : MlrlpolicygradCursor) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradCursor::mean(self : MlrlpolicygradCursor) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradCursor::scale(self : MlrlpolicygradCursor, f : Double) -> MlrlpolicygradCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradCursor::add(self : MlrlpolicygradCursor, other : MlrlpolicygradCursor) -> MlrlpolicygradCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradCursor::copy(self : MlrlpolicygradCursor) -> MlrlpolicygradCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradCursor::fill(self : MlrlpolicygradCursor, v : Double) -> MlrlpolicygradCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradCursor::min(self : MlrlpolicygradCursor) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradCursor::max(self : MlrlpolicygradCursor) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradCursor::to_string(self : MlrlpolicygradCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_view_make(size : Int) -> MlrlpolicygradView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradView::len(self : MlrlpolicygradView) -> Int { self.size }

pub fn MlrlpolicygradView::get(self : MlrlpolicygradView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradView::set(self : MlrlpolicygradView, i : Int, v : Double) -> MlrlpolicygradView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradView::sum(self : MlrlpolicygradView) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradView::mean(self : MlrlpolicygradView) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradView::scale(self : MlrlpolicygradView, f : Double) -> MlrlpolicygradView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradView::add(self : MlrlpolicygradView, other : MlrlpolicygradView) -> MlrlpolicygradView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradView::copy(self : MlrlpolicygradView) -> MlrlpolicygradView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradView::fill(self : MlrlpolicygradView, v : Double) -> MlrlpolicygradView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradView::min(self : MlrlpolicygradView) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradView::max(self : MlrlpolicygradView) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradView::to_string(self : MlrlpolicygradView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_range_make(size : Int) -> MlrlpolicygradRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradRange::len(self : MlrlpolicygradRange) -> Int { self.size }

pub fn MlrlpolicygradRange::get(self : MlrlpolicygradRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradRange::set(self : MlrlpolicygradRange, i : Int, v : Double) -> MlrlpolicygradRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradRange::sum(self : MlrlpolicygradRange) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradRange::mean(self : MlrlpolicygradRange) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradRange::scale(self : MlrlpolicygradRange, f : Double) -> MlrlpolicygradRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradRange::add(self : MlrlpolicygradRange, other : MlrlpolicygradRange) -> MlrlpolicygradRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradRange::copy(self : MlrlpolicygradRange) -> MlrlpolicygradRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradRange::fill(self : MlrlpolicygradRange, v : Double) -> MlrlpolicygradRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradRange::min(self : MlrlpolicygradRange) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradRange::max(self : MlrlpolicygradRange) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradRange::to_string(self : MlrlpolicygradRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_slice_make(size : Int) -> MlrlpolicygradSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlpolicygradSlice::len(self : MlrlpolicygradSlice) -> Int { self.size }

pub fn MlrlpolicygradSlice::get(self : MlrlpolicygradSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlpolicygradSlice::set(self : MlrlpolicygradSlice, i : Int, v : Double) -> MlrlpolicygradSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradSlice::sum(self : MlrlpolicygradSlice) -> Double { @_common.sum(self.data) }

pub fn MlrlpolicygradSlice::mean(self : MlrlpolicygradSlice) -> Double { @_common.mean(self.data) }

pub fn MlrlpolicygradSlice::scale(self : MlrlpolicygradSlice, f : Double) -> MlrlpolicygradSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradSlice::add(self : MlrlpolicygradSlice, other : MlrlpolicygradSlice) -> MlrlpolicygradSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlpolicygradSlice::copy(self : MlrlpolicygradSlice) -> MlrlpolicygradSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradSlice::fill(self : MlrlpolicygradSlice, v : Double) -> MlrlpolicygradSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlpolicygradSlice::min(self : MlrlpolicygradSlice) -> Double { @_common.min(self.data) }

pub fn MlrlpolicygradSlice::max(self : MlrlpolicygradSlice) -> Double { @_common.max(self.data) }

pub fn MlrlpolicygradSlice::to_string(self : MlrlpolicygradSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

