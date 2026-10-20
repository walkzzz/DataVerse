///===
/// extcore/finance_risk_cvar

pub(all) struct FinanceriskcvarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_cvar_make_point(x : Double, y : Double) -> FinanceriskcvarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_cvar_make_point3(x : Double, y : Double, z : Double) -> FinanceriskcvarPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskcvarPoint::x(self : FinanceriskcvarPoint) -> Double { self.x }

pub fn FinanceriskcvarPoint::y(self : FinanceriskcvarPoint) -> Double { self.y }

pub fn FinanceriskcvarPoint::z(self : FinanceriskcvarPoint) -> Double { self.z }

pub fn FinanceriskcvarPoint::label(self : FinanceriskcvarPoint) -> Int { self.label }

pub fn FinanceriskcvarPoint::dist(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskcvarPoint::add(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskcvarPoint::sub(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskcvarPoint::scale(self : FinanceriskcvarPoint, s : Double) -> FinanceriskcvarPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskcvarPoint::dot(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskcvarPoint::cross(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskcvarPoint::norm(self : FinanceriskcvarPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskcvarPoint::normalize(self : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskcvarPoint::negate(self : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskcvarPoint::mid(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskcvarPoint::lerp(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint, t : Double) -> FinanceriskcvarPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskcvarPoint::to_string(self : FinanceriskcvarPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskcvarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_cvar_make_series(vals : Array[Double], name : String) -> FinanceriskcvarSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskcvarSeries::len(self : FinanceriskcvarSeries) -> Int { self.vals.length() }

pub fn FinanceriskcvarSeries::sum(self : FinanceriskcvarSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskcvarSeries::mean(self : FinanceriskcvarSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskcvarSeries::min(self : FinanceriskcvarSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskcvarSeries::max(self : FinanceriskcvarSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskcvarSeries::range(self : FinanceriskcvarSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskcvarSeries::variance(self : FinanceriskcvarSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskcvarSeries::std(self : FinanceriskcvarSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskcvarSeries::median(self : FinanceriskcvarSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskcvarSeries::scale(self : FinanceriskcvarSeries, f : Double) -> FinanceriskcvarSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskcvarSeries::add(self : FinanceriskcvarSeries, other : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskcvarSeries::sub(self : FinanceriskcvarSeries, other : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskcvarSeries::normalize(self : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskcvarSeries::cumsum(self : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskcvarSeries::to_string(self : FinanceriskcvarSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskcvarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_cvar_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskcvarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_cvar_matrix_identity(n : Int) -> FinanceriskcvarMatrix {
  let m = finance_risk_cvar_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskcvarMatrix::get(self : FinanceriskcvarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskcvarMatrix::transpose(self : FinanceriskcvarMatrix) -> FinanceriskcvarMatrix {
  let result = finance_risk_cvar_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskcvarMatrix::add(self : FinanceriskcvarMatrix, other : FinanceriskcvarMatrix) -> FinanceriskcvarMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_cvar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskcvarMatrix::scale(self : FinanceriskcvarMatrix, s : Double) -> FinanceriskcvarMatrix {
  let result = finance_risk_cvar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskcvarMatrix::multiply(self : FinanceriskcvarMatrix, other : FinanceriskcvarMatrix) -> FinanceriskcvarMatrix {
  if self.cols != other.rows { return finance_risk_cvar_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_cvar_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceriskcvarMatrix::trace(self : FinanceriskcvarMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskcvarMatrix::det(self : FinanceriskcvarMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskcvarMatrix::norm(self : FinanceriskcvarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskcvarMatrix::to_string(self : FinanceriskcvarMatrix) -> String {
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

pub(all) struct FinanceriskcvarVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_cvar_make_vector(comps : Array[Double]) -> FinanceriskcvarVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_cvar_vector_zero(dim : Int) -> FinanceriskcvarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskcvarVector::add(self : FinanceriskcvarVector, other : FinanceriskcvarVector) -> FinanceriskcvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskcvarVector::sub(self : FinanceriskcvarVector, other : FinanceriskcvarVector) -> FinanceriskcvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskcvarVector::scale(self : FinanceriskcvarVector, s : Double) -> FinanceriskcvarVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskcvarVector::dot(self : FinanceriskcvarVector, other : FinanceriskcvarVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskcvarVector::norm(self : FinanceriskcvarVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskcvarVector::normalize(self : FinanceriskcvarVector) -> FinanceriskcvarVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskcvarVector::dist(self : FinanceriskcvarVector, other : FinanceriskcvarVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskcvarVector::to_string(self : FinanceriskcvarVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskcvarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_frame_make(size : Int) -> FinanceriskcvarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarFrame::len(self : FinanceriskcvarFrame) -> Int { self.size }

pub fn FinanceriskcvarFrame::get(self : FinanceriskcvarFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarFrame::set(self : FinanceriskcvarFrame, i : Int, v : Double) -> FinanceriskcvarFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarFrame::sum(self : FinanceriskcvarFrame) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarFrame::mean(self : FinanceriskcvarFrame) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarFrame::scale(self : FinanceriskcvarFrame, f : Double) -> FinanceriskcvarFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarFrame::add(self : FinanceriskcvarFrame, other : FinanceriskcvarFrame) -> FinanceriskcvarFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarFrame::copy(self : FinanceriskcvarFrame) -> FinanceriskcvarFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarFrame::fill(self : FinanceriskcvarFrame, v : Double) -> FinanceriskcvarFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarFrame::min(self : FinanceriskcvarFrame) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarFrame::max(self : FinanceriskcvarFrame) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarFrame::to_string(self : FinanceriskcvarFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_table_make(size : Int) -> FinanceriskcvarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarTable::len(self : FinanceriskcvarTable) -> Int { self.size }

pub fn FinanceriskcvarTable::get(self : FinanceriskcvarTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarTable::set(self : FinanceriskcvarTable, i : Int, v : Double) -> FinanceriskcvarTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarTable::sum(self : FinanceriskcvarTable) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarTable::mean(self : FinanceriskcvarTable) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarTable::scale(self : FinanceriskcvarTable, f : Double) -> FinanceriskcvarTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarTable::add(self : FinanceriskcvarTable, other : FinanceriskcvarTable) -> FinanceriskcvarTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarTable::copy(self : FinanceriskcvarTable) -> FinanceriskcvarTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarTable::fill(self : FinanceriskcvarTable, v : Double) -> FinanceriskcvarTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarTable::min(self : FinanceriskcvarTable) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarTable::max(self : FinanceriskcvarTable) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarTable::to_string(self : FinanceriskcvarTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_graphn_make(size : Int) -> FinanceriskcvarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarGraphN::len(self : FinanceriskcvarGraphN) -> Int { self.size }

pub fn FinanceriskcvarGraphN::get(self : FinanceriskcvarGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarGraphN::set(self : FinanceriskcvarGraphN, i : Int, v : Double) -> FinanceriskcvarGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarGraphN::sum(self : FinanceriskcvarGraphN) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarGraphN::mean(self : FinanceriskcvarGraphN) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarGraphN::scale(self : FinanceriskcvarGraphN, f : Double) -> FinanceriskcvarGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarGraphN::add(self : FinanceriskcvarGraphN, other : FinanceriskcvarGraphN) -> FinanceriskcvarGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarGraphN::copy(self : FinanceriskcvarGraphN) -> FinanceriskcvarGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarGraphN::fill(self : FinanceriskcvarGraphN, v : Double) -> FinanceriskcvarGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarGraphN::min(self : FinanceriskcvarGraphN) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarGraphN::max(self : FinanceriskcvarGraphN) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarGraphN::to_string(self : FinanceriskcvarGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_node_make(size : Int) -> FinanceriskcvarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarNode::len(self : FinanceriskcvarNode) -> Int { self.size }

pub fn FinanceriskcvarNode::get(self : FinanceriskcvarNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarNode::set(self : FinanceriskcvarNode, i : Int, v : Double) -> FinanceriskcvarNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarNode::sum(self : FinanceriskcvarNode) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarNode::mean(self : FinanceriskcvarNode) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarNode::scale(self : FinanceriskcvarNode, f : Double) -> FinanceriskcvarNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarNode::add(self : FinanceriskcvarNode, other : FinanceriskcvarNode) -> FinanceriskcvarNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarNode::copy(self : FinanceriskcvarNode) -> FinanceriskcvarNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarNode::fill(self : FinanceriskcvarNode, v : Double) -> FinanceriskcvarNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarNode::min(self : FinanceriskcvarNode) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarNode::max(self : FinanceriskcvarNode) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarNode::to_string(self : FinanceriskcvarNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_edge_make(size : Int) -> FinanceriskcvarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarEdge::len(self : FinanceriskcvarEdge) -> Int { self.size }

pub fn FinanceriskcvarEdge::get(self : FinanceriskcvarEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarEdge::set(self : FinanceriskcvarEdge, i : Int, v : Double) -> FinanceriskcvarEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarEdge::sum(self : FinanceriskcvarEdge) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarEdge::mean(self : FinanceriskcvarEdge) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarEdge::scale(self : FinanceriskcvarEdge, f : Double) -> FinanceriskcvarEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarEdge::add(self : FinanceriskcvarEdge, other : FinanceriskcvarEdge) -> FinanceriskcvarEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarEdge::copy(self : FinanceriskcvarEdge) -> FinanceriskcvarEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarEdge::fill(self : FinanceriskcvarEdge, v : Double) -> FinanceriskcvarEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarEdge::min(self : FinanceriskcvarEdge) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarEdge::max(self : FinanceriskcvarEdge) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarEdge::to_string(self : FinanceriskcvarEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_path_make(size : Int) -> FinanceriskcvarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarPath::len(self : FinanceriskcvarPath) -> Int { self.size }

pub fn FinanceriskcvarPath::get(self : FinanceriskcvarPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarPath::set(self : FinanceriskcvarPath, i : Int, v : Double) -> FinanceriskcvarPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarPath::sum(self : FinanceriskcvarPath) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarPath::mean(self : FinanceriskcvarPath) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarPath::scale(self : FinanceriskcvarPath, f : Double) -> FinanceriskcvarPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarPath::add(self : FinanceriskcvarPath, other : FinanceriskcvarPath) -> FinanceriskcvarPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarPath::copy(self : FinanceriskcvarPath) -> FinanceriskcvarPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarPath::fill(self : FinanceriskcvarPath, v : Double) -> FinanceriskcvarPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarPath::min(self : FinanceriskcvarPath) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarPath::max(self : FinanceriskcvarPath) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarPath::to_string(self : FinanceriskcvarPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_cluster_make(size : Int) -> FinanceriskcvarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarCluster::len(self : FinanceriskcvarCluster) -> Int { self.size }

pub fn FinanceriskcvarCluster::get(self : FinanceriskcvarCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarCluster::set(self : FinanceriskcvarCluster, i : Int, v : Double) -> FinanceriskcvarCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarCluster::sum(self : FinanceriskcvarCluster) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarCluster::mean(self : FinanceriskcvarCluster) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarCluster::scale(self : FinanceriskcvarCluster, f : Double) -> FinanceriskcvarCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarCluster::add(self : FinanceriskcvarCluster, other : FinanceriskcvarCluster) -> FinanceriskcvarCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarCluster::copy(self : FinanceriskcvarCluster) -> FinanceriskcvarCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarCluster::fill(self : FinanceriskcvarCluster, v : Double) -> FinanceriskcvarCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarCluster::min(self : FinanceriskcvarCluster) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarCluster::max(self : FinanceriskcvarCluster) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarCluster::to_string(self : FinanceriskcvarCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_model_make(size : Int) -> FinanceriskcvarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarModel::len(self : FinanceriskcvarModel) -> Int { self.size }

pub fn FinanceriskcvarModel::get(self : FinanceriskcvarModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarModel::set(self : FinanceriskcvarModel, i : Int, v : Double) -> FinanceriskcvarModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarModel::sum(self : FinanceriskcvarModel) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarModel::mean(self : FinanceriskcvarModel) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarModel::scale(self : FinanceriskcvarModel, f : Double) -> FinanceriskcvarModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarModel::add(self : FinanceriskcvarModel, other : FinanceriskcvarModel) -> FinanceriskcvarModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarModel::copy(self : FinanceriskcvarModel) -> FinanceriskcvarModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarModel::fill(self : FinanceriskcvarModel, v : Double) -> FinanceriskcvarModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarModel::min(self : FinanceriskcvarModel) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarModel::max(self : FinanceriskcvarModel) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarModel::to_string(self : FinanceriskcvarModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_layer_make(size : Int) -> FinanceriskcvarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarLayer::len(self : FinanceriskcvarLayer) -> Int { self.size }

pub fn FinanceriskcvarLayer::get(self : FinanceriskcvarLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarLayer::set(self : FinanceriskcvarLayer, i : Int, v : Double) -> FinanceriskcvarLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarLayer::sum(self : FinanceriskcvarLayer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarLayer::mean(self : FinanceriskcvarLayer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarLayer::scale(self : FinanceriskcvarLayer, f : Double) -> FinanceriskcvarLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarLayer::add(self : FinanceriskcvarLayer, other : FinanceriskcvarLayer) -> FinanceriskcvarLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarLayer::copy(self : FinanceriskcvarLayer) -> FinanceriskcvarLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarLayer::fill(self : FinanceriskcvarLayer, v : Double) -> FinanceriskcvarLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarLayer::min(self : FinanceriskcvarLayer) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarLayer::max(self : FinanceriskcvarLayer) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarLayer::to_string(self : FinanceriskcvarLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_buffer_make(size : Int) -> FinanceriskcvarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarBuffer::len(self : FinanceriskcvarBuffer) -> Int { self.size }

pub fn FinanceriskcvarBuffer::get(self : FinanceriskcvarBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarBuffer::set(self : FinanceriskcvarBuffer, i : Int, v : Double) -> FinanceriskcvarBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarBuffer::sum(self : FinanceriskcvarBuffer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarBuffer::mean(self : FinanceriskcvarBuffer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarBuffer::scale(self : FinanceriskcvarBuffer, f : Double) -> FinanceriskcvarBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarBuffer::add(self : FinanceriskcvarBuffer, other : FinanceriskcvarBuffer) -> FinanceriskcvarBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarBuffer::copy(self : FinanceriskcvarBuffer) -> FinanceriskcvarBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarBuffer::fill(self : FinanceriskcvarBuffer, v : Double) -> FinanceriskcvarBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarBuffer::min(self : FinanceriskcvarBuffer) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarBuffer::max(self : FinanceriskcvarBuffer) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarBuffer::to_string(self : FinanceriskcvarBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_cursor_make(size : Int) -> FinanceriskcvarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarCursor::len(self : FinanceriskcvarCursor) -> Int { self.size }

pub fn FinanceriskcvarCursor::get(self : FinanceriskcvarCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarCursor::set(self : FinanceriskcvarCursor, i : Int, v : Double) -> FinanceriskcvarCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarCursor::sum(self : FinanceriskcvarCursor) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarCursor::mean(self : FinanceriskcvarCursor) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarCursor::scale(self : FinanceriskcvarCursor, f : Double) -> FinanceriskcvarCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarCursor::add(self : FinanceriskcvarCursor, other : FinanceriskcvarCursor) -> FinanceriskcvarCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarCursor::copy(self : FinanceriskcvarCursor) -> FinanceriskcvarCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarCursor::fill(self : FinanceriskcvarCursor, v : Double) -> FinanceriskcvarCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarCursor::min(self : FinanceriskcvarCursor) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarCursor::max(self : FinanceriskcvarCursor) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarCursor::to_string(self : FinanceriskcvarCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_view_make(size : Int) -> FinanceriskcvarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarView::len(self : FinanceriskcvarView) -> Int { self.size }

pub fn FinanceriskcvarView::get(self : FinanceriskcvarView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarView::set(self : FinanceriskcvarView, i : Int, v : Double) -> FinanceriskcvarView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarView::sum(self : FinanceriskcvarView) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarView::mean(self : FinanceriskcvarView) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarView::scale(self : FinanceriskcvarView, f : Double) -> FinanceriskcvarView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarView::add(self : FinanceriskcvarView, other : FinanceriskcvarView) -> FinanceriskcvarView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarView::copy(self : FinanceriskcvarView) -> FinanceriskcvarView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarView::fill(self : FinanceriskcvarView, v : Double) -> FinanceriskcvarView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarView::min(self : FinanceriskcvarView) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarView::max(self : FinanceriskcvarView) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarView::to_string(self : FinanceriskcvarView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_range_make(size : Int) -> FinanceriskcvarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarRange::len(self : FinanceriskcvarRange) -> Int { self.size }

pub fn FinanceriskcvarRange::get(self : FinanceriskcvarRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarRange::set(self : FinanceriskcvarRange, i : Int, v : Double) -> FinanceriskcvarRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarRange::sum(self : FinanceriskcvarRange) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarRange::mean(self : FinanceriskcvarRange) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarRange::scale(self : FinanceriskcvarRange, f : Double) -> FinanceriskcvarRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarRange::add(self : FinanceriskcvarRange, other : FinanceriskcvarRange) -> FinanceriskcvarRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarRange::copy(self : FinanceriskcvarRange) -> FinanceriskcvarRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarRange::fill(self : FinanceriskcvarRange, v : Double) -> FinanceriskcvarRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarRange::min(self : FinanceriskcvarRange) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarRange::max(self : FinanceriskcvarRange) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarRange::to_string(self : FinanceriskcvarRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_slice_make(size : Int) -> FinanceriskcvarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcvarSlice::len(self : FinanceriskcvarSlice) -> Int { self.size }

pub fn FinanceriskcvarSlice::get(self : FinanceriskcvarSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcvarSlice::set(self : FinanceriskcvarSlice, i : Int, v : Double) -> FinanceriskcvarSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarSlice::sum(self : FinanceriskcvarSlice) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcvarSlice::mean(self : FinanceriskcvarSlice) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcvarSlice::scale(self : FinanceriskcvarSlice, f : Double) -> FinanceriskcvarSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarSlice::add(self : FinanceriskcvarSlice, other : FinanceriskcvarSlice) -> FinanceriskcvarSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcvarSlice::copy(self : FinanceriskcvarSlice) -> FinanceriskcvarSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarSlice::fill(self : FinanceriskcvarSlice, v : Double) -> FinanceriskcvarSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcvarSlice::min(self : FinanceriskcvarSlice) -> Double { @_common.min(self.data) }

pub fn FinanceriskcvarSlice::max(self : FinanceriskcvarSlice) -> Double { @_common.max(self.data) }

pub fn FinanceriskcvarSlice::to_string(self : FinanceriskcvarSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

