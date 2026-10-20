///===
/// extcore/finance_risk_es

pub(all) struct FinanceriskesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_es_make_point(x : Double, y : Double) -> FinanceriskesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_es_make_point3(x : Double, y : Double, z : Double) -> FinanceriskesPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskesPoint::x(self : FinanceriskesPoint) -> Double { self.x }

pub fn FinanceriskesPoint::y(self : FinanceriskesPoint) -> Double { self.y }

pub fn FinanceriskesPoint::z(self : FinanceriskesPoint) -> Double { self.z }

pub fn FinanceriskesPoint::label(self : FinanceriskesPoint) -> Int { self.label }

pub fn FinanceriskesPoint::dist(self : FinanceriskesPoint, other : FinanceriskesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskesPoint::add(self : FinanceriskesPoint, other : FinanceriskesPoint) -> FinanceriskesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskesPoint::sub(self : FinanceriskesPoint, other : FinanceriskesPoint) -> FinanceriskesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskesPoint::scale(self : FinanceriskesPoint, s : Double) -> FinanceriskesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskesPoint::dot(self : FinanceriskesPoint, other : FinanceriskesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskesPoint::cross(self : FinanceriskesPoint, other : FinanceriskesPoint) -> FinanceriskesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskesPoint::norm(self : FinanceriskesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskesPoint::normalize(self : FinanceriskesPoint) -> FinanceriskesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskesPoint::negate(self : FinanceriskesPoint) -> FinanceriskesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskesPoint::mid(self : FinanceriskesPoint, other : FinanceriskesPoint) -> FinanceriskesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskesPoint::lerp(self : FinanceriskesPoint, other : FinanceriskesPoint, t : Double) -> FinanceriskesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskesPoint::to_string(self : FinanceriskesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_es_make_series(vals : Array[Double], name : String) -> FinanceriskesSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskesSeries::len(self : FinanceriskesSeries) -> Int { self.vals.length() }

pub fn FinanceriskesSeries::sum(self : FinanceriskesSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskesSeries::mean(self : FinanceriskesSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskesSeries::min(self : FinanceriskesSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskesSeries::max(self : FinanceriskesSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskesSeries::range(self : FinanceriskesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskesSeries::variance(self : FinanceriskesSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskesSeries::std(self : FinanceriskesSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskesSeries::median(self : FinanceriskesSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskesSeries::scale(self : FinanceriskesSeries, f : Double) -> FinanceriskesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskesSeries::add(self : FinanceriskesSeries, other : FinanceriskesSeries) -> FinanceriskesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskesSeries::sub(self : FinanceriskesSeries, other : FinanceriskesSeries) -> FinanceriskesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskesSeries::normalize(self : FinanceriskesSeries) -> FinanceriskesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskesSeries::cumsum(self : FinanceriskesSeries) -> FinanceriskesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskesSeries::to_string(self : FinanceriskesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_es_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_es_matrix_identity(n : Int) -> FinanceriskesMatrix {
  let m = finance_risk_es_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskesMatrix::get(self : FinanceriskesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskesMatrix::transpose(self : FinanceriskesMatrix) -> FinanceriskesMatrix {
  let result = finance_risk_es_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskesMatrix::add(self : FinanceriskesMatrix, other : FinanceriskesMatrix) -> FinanceriskesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_es_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskesMatrix::scale(self : FinanceriskesMatrix, s : Double) -> FinanceriskesMatrix {
  let result = finance_risk_es_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskesMatrix::multiply(self : FinanceriskesMatrix, other : FinanceriskesMatrix) -> FinanceriskesMatrix {
  if self.cols != other.rows { return finance_risk_es_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_es_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceriskesMatrix::trace(self : FinanceriskesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskesMatrix::det(self : FinanceriskesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskesMatrix::norm(self : FinanceriskesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskesMatrix::to_string(self : FinanceriskesMatrix) -> String {
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

pub(all) struct FinanceriskesVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_es_make_vector(comps : Array[Double]) -> FinanceriskesVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_es_vector_zero(dim : Int) -> FinanceriskesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskesVector::add(self : FinanceriskesVector, other : FinanceriskesVector) -> FinanceriskesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskesVector::sub(self : FinanceriskesVector, other : FinanceriskesVector) -> FinanceriskesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskesVector::scale(self : FinanceriskesVector, s : Double) -> FinanceriskesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskesVector::dot(self : FinanceriskesVector, other : FinanceriskesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskesVector::norm(self : FinanceriskesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskesVector::normalize(self : FinanceriskesVector) -> FinanceriskesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskesVector::dist(self : FinanceriskesVector, other : FinanceriskesVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskesVector::to_string(self : FinanceriskesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_frame_make(size : Int) -> FinanceriskesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesFrame::len(self : FinanceriskesFrame) -> Int { self.size }

pub fn FinanceriskesFrame::get(self : FinanceriskesFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesFrame::set(self : FinanceriskesFrame, i : Int, v : Double) -> FinanceriskesFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesFrame::sum(self : FinanceriskesFrame) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesFrame::mean(self : FinanceriskesFrame) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesFrame::scale(self : FinanceriskesFrame, f : Double) -> FinanceriskesFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesFrame::add(self : FinanceriskesFrame, other : FinanceriskesFrame) -> FinanceriskesFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesFrame::copy(self : FinanceriskesFrame) -> FinanceriskesFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesFrame::fill(self : FinanceriskesFrame, v : Double) -> FinanceriskesFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesFrame::min(self : FinanceriskesFrame) -> Double { @_common.min(self.data) }

pub fn FinanceriskesFrame::max(self : FinanceriskesFrame) -> Double { @_common.max(self.data) }

pub fn FinanceriskesFrame::to_string(self : FinanceriskesFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_table_make(size : Int) -> FinanceriskesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesTable::len(self : FinanceriskesTable) -> Int { self.size }

pub fn FinanceriskesTable::get(self : FinanceriskesTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesTable::set(self : FinanceriskesTable, i : Int, v : Double) -> FinanceriskesTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesTable::sum(self : FinanceriskesTable) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesTable::mean(self : FinanceriskesTable) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesTable::scale(self : FinanceriskesTable, f : Double) -> FinanceriskesTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesTable::add(self : FinanceriskesTable, other : FinanceriskesTable) -> FinanceriskesTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesTable::copy(self : FinanceriskesTable) -> FinanceriskesTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesTable::fill(self : FinanceriskesTable, v : Double) -> FinanceriskesTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesTable::min(self : FinanceriskesTable) -> Double { @_common.min(self.data) }

pub fn FinanceriskesTable::max(self : FinanceriskesTable) -> Double { @_common.max(self.data) }

pub fn FinanceriskesTable::to_string(self : FinanceriskesTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_graphn_make(size : Int) -> FinanceriskesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesGraphN::len(self : FinanceriskesGraphN) -> Int { self.size }

pub fn FinanceriskesGraphN::get(self : FinanceriskesGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesGraphN::set(self : FinanceriskesGraphN, i : Int, v : Double) -> FinanceriskesGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesGraphN::sum(self : FinanceriskesGraphN) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesGraphN::mean(self : FinanceriskesGraphN) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesGraphN::scale(self : FinanceriskesGraphN, f : Double) -> FinanceriskesGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesGraphN::add(self : FinanceriskesGraphN, other : FinanceriskesGraphN) -> FinanceriskesGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesGraphN::copy(self : FinanceriskesGraphN) -> FinanceriskesGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesGraphN::fill(self : FinanceriskesGraphN, v : Double) -> FinanceriskesGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesGraphN::min(self : FinanceriskesGraphN) -> Double { @_common.min(self.data) }

pub fn FinanceriskesGraphN::max(self : FinanceriskesGraphN) -> Double { @_common.max(self.data) }

pub fn FinanceriskesGraphN::to_string(self : FinanceriskesGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_node_make(size : Int) -> FinanceriskesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesNode::len(self : FinanceriskesNode) -> Int { self.size }

pub fn FinanceriskesNode::get(self : FinanceriskesNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesNode::set(self : FinanceriskesNode, i : Int, v : Double) -> FinanceriskesNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesNode::sum(self : FinanceriskesNode) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesNode::mean(self : FinanceriskesNode) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesNode::scale(self : FinanceriskesNode, f : Double) -> FinanceriskesNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesNode::add(self : FinanceriskesNode, other : FinanceriskesNode) -> FinanceriskesNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesNode::copy(self : FinanceriskesNode) -> FinanceriskesNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesNode::fill(self : FinanceriskesNode, v : Double) -> FinanceriskesNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesNode::min(self : FinanceriskesNode) -> Double { @_common.min(self.data) }

pub fn FinanceriskesNode::max(self : FinanceriskesNode) -> Double { @_common.max(self.data) }

pub fn FinanceriskesNode::to_string(self : FinanceriskesNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_edge_make(size : Int) -> FinanceriskesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesEdge::len(self : FinanceriskesEdge) -> Int { self.size }

pub fn FinanceriskesEdge::get(self : FinanceriskesEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesEdge::set(self : FinanceriskesEdge, i : Int, v : Double) -> FinanceriskesEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesEdge::sum(self : FinanceriskesEdge) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesEdge::mean(self : FinanceriskesEdge) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesEdge::scale(self : FinanceriskesEdge, f : Double) -> FinanceriskesEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesEdge::add(self : FinanceriskesEdge, other : FinanceriskesEdge) -> FinanceriskesEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesEdge::copy(self : FinanceriskesEdge) -> FinanceriskesEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesEdge::fill(self : FinanceriskesEdge, v : Double) -> FinanceriskesEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesEdge::min(self : FinanceriskesEdge) -> Double { @_common.min(self.data) }

pub fn FinanceriskesEdge::max(self : FinanceriskesEdge) -> Double { @_common.max(self.data) }

pub fn FinanceriskesEdge::to_string(self : FinanceriskesEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_path_make(size : Int) -> FinanceriskesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesPath::len(self : FinanceriskesPath) -> Int { self.size }

pub fn FinanceriskesPath::get(self : FinanceriskesPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesPath::set(self : FinanceriskesPath, i : Int, v : Double) -> FinanceriskesPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesPath::sum(self : FinanceriskesPath) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesPath::mean(self : FinanceriskesPath) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesPath::scale(self : FinanceriskesPath, f : Double) -> FinanceriskesPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesPath::add(self : FinanceriskesPath, other : FinanceriskesPath) -> FinanceriskesPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesPath::copy(self : FinanceriskesPath) -> FinanceriskesPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesPath::fill(self : FinanceriskesPath, v : Double) -> FinanceriskesPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesPath::min(self : FinanceriskesPath) -> Double { @_common.min(self.data) }

pub fn FinanceriskesPath::max(self : FinanceriskesPath) -> Double { @_common.max(self.data) }

pub fn FinanceriskesPath::to_string(self : FinanceriskesPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_cluster_make(size : Int) -> FinanceriskesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesCluster::len(self : FinanceriskesCluster) -> Int { self.size }

pub fn FinanceriskesCluster::get(self : FinanceriskesCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesCluster::set(self : FinanceriskesCluster, i : Int, v : Double) -> FinanceriskesCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesCluster::sum(self : FinanceriskesCluster) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesCluster::mean(self : FinanceriskesCluster) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesCluster::scale(self : FinanceriskesCluster, f : Double) -> FinanceriskesCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesCluster::add(self : FinanceriskesCluster, other : FinanceriskesCluster) -> FinanceriskesCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesCluster::copy(self : FinanceriskesCluster) -> FinanceriskesCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesCluster::fill(self : FinanceriskesCluster, v : Double) -> FinanceriskesCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesCluster::min(self : FinanceriskesCluster) -> Double { @_common.min(self.data) }

pub fn FinanceriskesCluster::max(self : FinanceriskesCluster) -> Double { @_common.max(self.data) }

pub fn FinanceriskesCluster::to_string(self : FinanceriskesCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_model_make(size : Int) -> FinanceriskesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesModel::len(self : FinanceriskesModel) -> Int { self.size }

pub fn FinanceriskesModel::get(self : FinanceriskesModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesModel::set(self : FinanceriskesModel, i : Int, v : Double) -> FinanceriskesModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesModel::sum(self : FinanceriskesModel) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesModel::mean(self : FinanceriskesModel) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesModel::scale(self : FinanceriskesModel, f : Double) -> FinanceriskesModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesModel::add(self : FinanceriskesModel, other : FinanceriskesModel) -> FinanceriskesModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesModel::copy(self : FinanceriskesModel) -> FinanceriskesModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesModel::fill(self : FinanceriskesModel, v : Double) -> FinanceriskesModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesModel::min(self : FinanceriskesModel) -> Double { @_common.min(self.data) }

pub fn FinanceriskesModel::max(self : FinanceriskesModel) -> Double { @_common.max(self.data) }

pub fn FinanceriskesModel::to_string(self : FinanceriskesModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_layer_make(size : Int) -> FinanceriskesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesLayer::len(self : FinanceriskesLayer) -> Int { self.size }

pub fn FinanceriskesLayer::get(self : FinanceriskesLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesLayer::set(self : FinanceriskesLayer, i : Int, v : Double) -> FinanceriskesLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesLayer::sum(self : FinanceriskesLayer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesLayer::mean(self : FinanceriskesLayer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesLayer::scale(self : FinanceriskesLayer, f : Double) -> FinanceriskesLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesLayer::add(self : FinanceriskesLayer, other : FinanceriskesLayer) -> FinanceriskesLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesLayer::copy(self : FinanceriskesLayer) -> FinanceriskesLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesLayer::fill(self : FinanceriskesLayer, v : Double) -> FinanceriskesLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesLayer::min(self : FinanceriskesLayer) -> Double { @_common.min(self.data) }

pub fn FinanceriskesLayer::max(self : FinanceriskesLayer) -> Double { @_common.max(self.data) }

pub fn FinanceriskesLayer::to_string(self : FinanceriskesLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_buffer_make(size : Int) -> FinanceriskesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesBuffer::len(self : FinanceriskesBuffer) -> Int { self.size }

pub fn FinanceriskesBuffer::get(self : FinanceriskesBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesBuffer::set(self : FinanceriskesBuffer, i : Int, v : Double) -> FinanceriskesBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesBuffer::sum(self : FinanceriskesBuffer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesBuffer::mean(self : FinanceriskesBuffer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesBuffer::scale(self : FinanceriskesBuffer, f : Double) -> FinanceriskesBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesBuffer::add(self : FinanceriskesBuffer, other : FinanceriskesBuffer) -> FinanceriskesBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesBuffer::copy(self : FinanceriskesBuffer) -> FinanceriskesBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesBuffer::fill(self : FinanceriskesBuffer, v : Double) -> FinanceriskesBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesBuffer::min(self : FinanceriskesBuffer) -> Double { @_common.min(self.data) }

pub fn FinanceriskesBuffer::max(self : FinanceriskesBuffer) -> Double { @_common.max(self.data) }

pub fn FinanceriskesBuffer::to_string(self : FinanceriskesBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_cursor_make(size : Int) -> FinanceriskesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesCursor::len(self : FinanceriskesCursor) -> Int { self.size }

pub fn FinanceriskesCursor::get(self : FinanceriskesCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesCursor::set(self : FinanceriskesCursor, i : Int, v : Double) -> FinanceriskesCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesCursor::sum(self : FinanceriskesCursor) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesCursor::mean(self : FinanceriskesCursor) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesCursor::scale(self : FinanceriskesCursor, f : Double) -> FinanceriskesCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesCursor::add(self : FinanceriskesCursor, other : FinanceriskesCursor) -> FinanceriskesCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesCursor::copy(self : FinanceriskesCursor) -> FinanceriskesCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesCursor::fill(self : FinanceriskesCursor, v : Double) -> FinanceriskesCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesCursor::min(self : FinanceriskesCursor) -> Double { @_common.min(self.data) }

pub fn FinanceriskesCursor::max(self : FinanceriskesCursor) -> Double { @_common.max(self.data) }

pub fn FinanceriskesCursor::to_string(self : FinanceriskesCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_view_make(size : Int) -> FinanceriskesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesView::len(self : FinanceriskesView) -> Int { self.size }

pub fn FinanceriskesView::get(self : FinanceriskesView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesView::set(self : FinanceriskesView, i : Int, v : Double) -> FinanceriskesView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesView::sum(self : FinanceriskesView) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesView::mean(self : FinanceriskesView) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesView::scale(self : FinanceriskesView, f : Double) -> FinanceriskesView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesView::add(self : FinanceriskesView, other : FinanceriskesView) -> FinanceriskesView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesView::copy(self : FinanceriskesView) -> FinanceriskesView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesView::fill(self : FinanceriskesView, v : Double) -> FinanceriskesView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesView::min(self : FinanceriskesView) -> Double { @_common.min(self.data) }

pub fn FinanceriskesView::max(self : FinanceriskesView) -> Double { @_common.max(self.data) }

pub fn FinanceriskesView::to_string(self : FinanceriskesView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_range_make(size : Int) -> FinanceriskesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesRange::len(self : FinanceriskesRange) -> Int { self.size }

pub fn FinanceriskesRange::get(self : FinanceriskesRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesRange::set(self : FinanceriskesRange, i : Int, v : Double) -> FinanceriskesRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesRange::sum(self : FinanceriskesRange) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesRange::mean(self : FinanceriskesRange) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesRange::scale(self : FinanceriskesRange, f : Double) -> FinanceriskesRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesRange::add(self : FinanceriskesRange, other : FinanceriskesRange) -> FinanceriskesRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesRange::copy(self : FinanceriskesRange) -> FinanceriskesRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesRange::fill(self : FinanceriskesRange, v : Double) -> FinanceriskesRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesRange::min(self : FinanceriskesRange) -> Double { @_common.min(self.data) }

pub fn FinanceriskesRange::max(self : FinanceriskesRange) -> Double { @_common.max(self.data) }

pub fn FinanceriskesRange::to_string(self : FinanceriskesRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_slice_make(size : Int) -> FinanceriskesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskesSlice::len(self : FinanceriskesSlice) -> Int { self.size }

pub fn FinanceriskesSlice::get(self : FinanceriskesSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskesSlice::set(self : FinanceriskesSlice, i : Int, v : Double) -> FinanceriskesSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskesSlice::sum(self : FinanceriskesSlice) -> Double { @_common.sum(self.data) }

pub fn FinanceriskesSlice::mean(self : FinanceriskesSlice) -> Double { @_common.mean(self.data) }

pub fn FinanceriskesSlice::scale(self : FinanceriskesSlice, f : Double) -> FinanceriskesSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskesSlice::add(self : FinanceriskesSlice, other : FinanceriskesSlice) -> FinanceriskesSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskesSlice::copy(self : FinanceriskesSlice) -> FinanceriskesSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskesSlice::fill(self : FinanceriskesSlice, v : Double) -> FinanceriskesSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskesSlice::min(self : FinanceriskesSlice) -> Double { @_common.min(self.data) }

pub fn FinanceriskesSlice::max(self : FinanceriskesSlice) -> Double { @_common.max(self.data) }

pub fn FinanceriskesSlice::to_string(self : FinanceriskesSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

