///===
/// extcore/finance_risk_scenario

pub(all) struct FinanceriskscenarioPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_scenario_make_point(x : Double, y : Double) -> FinanceriskscenarioPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_scenario_make_point3(x : Double, y : Double, z : Double) -> FinanceriskscenarioPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskscenarioPoint::x(self : FinanceriskscenarioPoint) -> Double { self.x }

pub fn FinanceriskscenarioPoint::y(self : FinanceriskscenarioPoint) -> Double { self.y }

pub fn FinanceriskscenarioPoint::z(self : FinanceriskscenarioPoint) -> Double { self.z }

pub fn FinanceriskscenarioPoint::label(self : FinanceriskscenarioPoint) -> Int { self.label }

pub fn FinanceriskscenarioPoint::dist(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskscenarioPoint::add(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskscenarioPoint::sub(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskscenarioPoint::scale(self : FinanceriskscenarioPoint, s : Double) -> FinanceriskscenarioPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskscenarioPoint::dot(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskscenarioPoint::cross(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskscenarioPoint::norm(self : FinanceriskscenarioPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskscenarioPoint::normalize(self : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskscenarioPoint::negate(self : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskscenarioPoint::mid(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskscenarioPoint::lerp(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint, t : Double) -> FinanceriskscenarioPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskscenarioPoint::to_string(self : FinanceriskscenarioPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskscenarioSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_scenario_make_series(vals : Array[Double], name : String) -> FinanceriskscenarioSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskscenarioSeries::len(self : FinanceriskscenarioSeries) -> Int { self.vals.length() }

pub fn FinanceriskscenarioSeries::sum(self : FinanceriskscenarioSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskscenarioSeries::mean(self : FinanceriskscenarioSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskscenarioSeries::min(self : FinanceriskscenarioSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskscenarioSeries::max(self : FinanceriskscenarioSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskscenarioSeries::range(self : FinanceriskscenarioSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskscenarioSeries::variance(self : FinanceriskscenarioSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskscenarioSeries::std(self : FinanceriskscenarioSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskscenarioSeries::median(self : FinanceriskscenarioSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskscenarioSeries::scale(self : FinanceriskscenarioSeries, f : Double) -> FinanceriskscenarioSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskscenarioSeries::add(self : FinanceriskscenarioSeries, other : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskscenarioSeries::sub(self : FinanceriskscenarioSeries, other : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskscenarioSeries::normalize(self : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskscenarioSeries::cumsum(self : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskscenarioSeries::to_string(self : FinanceriskscenarioSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskscenarioMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_scenario_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskscenarioMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn finance_risk_scenario_matrix_identity(n : Int) -> FinanceriskscenarioMatrix {
  let m = finance_risk_scenario_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskscenarioMatrix::get(self : FinanceriskscenarioMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskscenarioMatrix::transpose(self : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  let result = finance_risk_scenario_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskscenarioMatrix::add(self : FinanceriskscenarioMatrix, other : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_scenario_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskscenarioMatrix::scale(self : FinanceriskscenarioMatrix, s : Double) -> FinanceriskscenarioMatrix {
  let result = finance_risk_scenario_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskscenarioMatrix::multiply(self : FinanceriskscenarioMatrix, other : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  if self.cols != other.rows { return finance_risk_scenario_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_scenario_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn FinanceriskscenarioMatrix::trace(self : FinanceriskscenarioMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskscenarioMatrix::det(self : FinanceriskscenarioMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskscenarioMatrix::norm(self : FinanceriskscenarioMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskscenarioMatrix::to_string(self : FinanceriskscenarioMatrix) -> String {
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

pub(all) struct FinanceriskscenarioVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_scenario_make_vector(comps : Array[Double]) -> FinanceriskscenarioVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_scenario_vector_zero(dim : Int) -> FinanceriskscenarioVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskscenarioVector::add(self : FinanceriskscenarioVector, other : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskscenarioVector::sub(self : FinanceriskscenarioVector, other : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskscenarioVector::scale(self : FinanceriskscenarioVector, s : Double) -> FinanceriskscenarioVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskscenarioVector::dot(self : FinanceriskscenarioVector, other : FinanceriskscenarioVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskscenarioVector::norm(self : FinanceriskscenarioVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskscenarioVector::normalize(self : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskscenarioVector::dist(self : FinanceriskscenarioVector, other : FinanceriskscenarioVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskscenarioVector::to_string(self : FinanceriskscenarioVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskscenarioFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_frame_make(size : Int) -> FinanceriskscenarioFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioFrame::len(self : FinanceriskscenarioFrame) -> Int { self.size }

pub fn FinanceriskscenarioFrame::get(self : FinanceriskscenarioFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioFrame::set(self : FinanceriskscenarioFrame, i : Int, v : Double) -> FinanceriskscenarioFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioFrame::sum(self : FinanceriskscenarioFrame) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioFrame::mean(self : FinanceriskscenarioFrame) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioFrame::scale(self : FinanceriskscenarioFrame, f : Double) -> FinanceriskscenarioFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioFrame::add(self : FinanceriskscenarioFrame, other : FinanceriskscenarioFrame) -> FinanceriskscenarioFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioFrame::copy(self : FinanceriskscenarioFrame) -> FinanceriskscenarioFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioFrame::fill(self : FinanceriskscenarioFrame, v : Double) -> FinanceriskscenarioFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioFrame::min(self : FinanceriskscenarioFrame) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioFrame::max(self : FinanceriskscenarioFrame) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioFrame::to_string(self : FinanceriskscenarioFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_table_make(size : Int) -> FinanceriskscenarioTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioTable::len(self : FinanceriskscenarioTable) -> Int { self.size }

pub fn FinanceriskscenarioTable::get(self : FinanceriskscenarioTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioTable::set(self : FinanceriskscenarioTable, i : Int, v : Double) -> FinanceriskscenarioTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioTable::sum(self : FinanceriskscenarioTable) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioTable::mean(self : FinanceriskscenarioTable) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioTable::scale(self : FinanceriskscenarioTable, f : Double) -> FinanceriskscenarioTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioTable::add(self : FinanceriskscenarioTable, other : FinanceriskscenarioTable) -> FinanceriskscenarioTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioTable::copy(self : FinanceriskscenarioTable) -> FinanceriskscenarioTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioTable::fill(self : FinanceriskscenarioTable, v : Double) -> FinanceriskscenarioTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioTable::min(self : FinanceriskscenarioTable) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioTable::max(self : FinanceriskscenarioTable) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioTable::to_string(self : FinanceriskscenarioTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_graphn_make(size : Int) -> FinanceriskscenarioGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioGraphN::len(self : FinanceriskscenarioGraphN) -> Int { self.size }

pub fn FinanceriskscenarioGraphN::get(self : FinanceriskscenarioGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioGraphN::set(self : FinanceriskscenarioGraphN, i : Int, v : Double) -> FinanceriskscenarioGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioGraphN::sum(self : FinanceriskscenarioGraphN) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioGraphN::mean(self : FinanceriskscenarioGraphN) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioGraphN::scale(self : FinanceriskscenarioGraphN, f : Double) -> FinanceriskscenarioGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioGraphN::add(self : FinanceriskscenarioGraphN, other : FinanceriskscenarioGraphN) -> FinanceriskscenarioGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioGraphN::copy(self : FinanceriskscenarioGraphN) -> FinanceriskscenarioGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioGraphN::fill(self : FinanceriskscenarioGraphN, v : Double) -> FinanceriskscenarioGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioGraphN::min(self : FinanceriskscenarioGraphN) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioGraphN::max(self : FinanceriskscenarioGraphN) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioGraphN::to_string(self : FinanceriskscenarioGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_node_make(size : Int) -> FinanceriskscenarioNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioNode::len(self : FinanceriskscenarioNode) -> Int { self.size }

pub fn FinanceriskscenarioNode::get(self : FinanceriskscenarioNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioNode::set(self : FinanceriskscenarioNode, i : Int, v : Double) -> FinanceriskscenarioNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioNode::sum(self : FinanceriskscenarioNode) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioNode::mean(self : FinanceriskscenarioNode) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioNode::scale(self : FinanceriskscenarioNode, f : Double) -> FinanceriskscenarioNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioNode::add(self : FinanceriskscenarioNode, other : FinanceriskscenarioNode) -> FinanceriskscenarioNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioNode::copy(self : FinanceriskscenarioNode) -> FinanceriskscenarioNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioNode::fill(self : FinanceriskscenarioNode, v : Double) -> FinanceriskscenarioNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioNode::min(self : FinanceriskscenarioNode) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioNode::max(self : FinanceriskscenarioNode) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioNode::to_string(self : FinanceriskscenarioNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_edge_make(size : Int) -> FinanceriskscenarioEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioEdge::len(self : FinanceriskscenarioEdge) -> Int { self.size }

pub fn FinanceriskscenarioEdge::get(self : FinanceriskscenarioEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioEdge::set(self : FinanceriskscenarioEdge, i : Int, v : Double) -> FinanceriskscenarioEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioEdge::sum(self : FinanceriskscenarioEdge) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioEdge::mean(self : FinanceriskscenarioEdge) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioEdge::scale(self : FinanceriskscenarioEdge, f : Double) -> FinanceriskscenarioEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioEdge::add(self : FinanceriskscenarioEdge, other : FinanceriskscenarioEdge) -> FinanceriskscenarioEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioEdge::copy(self : FinanceriskscenarioEdge) -> FinanceriskscenarioEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioEdge::fill(self : FinanceriskscenarioEdge, v : Double) -> FinanceriskscenarioEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioEdge::min(self : FinanceriskscenarioEdge) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioEdge::max(self : FinanceriskscenarioEdge) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioEdge::to_string(self : FinanceriskscenarioEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_path_make(size : Int) -> FinanceriskscenarioPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioPath::len(self : FinanceriskscenarioPath) -> Int { self.size }

pub fn FinanceriskscenarioPath::get(self : FinanceriskscenarioPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioPath::set(self : FinanceriskscenarioPath, i : Int, v : Double) -> FinanceriskscenarioPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioPath::sum(self : FinanceriskscenarioPath) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioPath::mean(self : FinanceriskscenarioPath) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioPath::scale(self : FinanceriskscenarioPath, f : Double) -> FinanceriskscenarioPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioPath::add(self : FinanceriskscenarioPath, other : FinanceriskscenarioPath) -> FinanceriskscenarioPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioPath::copy(self : FinanceriskscenarioPath) -> FinanceriskscenarioPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioPath::fill(self : FinanceriskscenarioPath, v : Double) -> FinanceriskscenarioPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioPath::min(self : FinanceriskscenarioPath) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioPath::max(self : FinanceriskscenarioPath) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioPath::to_string(self : FinanceriskscenarioPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_cluster_make(size : Int) -> FinanceriskscenarioCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioCluster::len(self : FinanceriskscenarioCluster) -> Int { self.size }

pub fn FinanceriskscenarioCluster::get(self : FinanceriskscenarioCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioCluster::set(self : FinanceriskscenarioCluster, i : Int, v : Double) -> FinanceriskscenarioCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioCluster::sum(self : FinanceriskscenarioCluster) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioCluster::mean(self : FinanceriskscenarioCluster) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioCluster::scale(self : FinanceriskscenarioCluster, f : Double) -> FinanceriskscenarioCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioCluster::add(self : FinanceriskscenarioCluster, other : FinanceriskscenarioCluster) -> FinanceriskscenarioCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioCluster::copy(self : FinanceriskscenarioCluster) -> FinanceriskscenarioCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioCluster::fill(self : FinanceriskscenarioCluster, v : Double) -> FinanceriskscenarioCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioCluster::min(self : FinanceriskscenarioCluster) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioCluster::max(self : FinanceriskscenarioCluster) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioCluster::to_string(self : FinanceriskscenarioCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_model_make(size : Int) -> FinanceriskscenarioModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioModel::len(self : FinanceriskscenarioModel) -> Int { self.size }

pub fn FinanceriskscenarioModel::get(self : FinanceriskscenarioModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioModel::set(self : FinanceriskscenarioModel, i : Int, v : Double) -> FinanceriskscenarioModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioModel::sum(self : FinanceriskscenarioModel) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioModel::mean(self : FinanceriskscenarioModel) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioModel::scale(self : FinanceriskscenarioModel, f : Double) -> FinanceriskscenarioModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioModel::add(self : FinanceriskscenarioModel, other : FinanceriskscenarioModel) -> FinanceriskscenarioModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioModel::copy(self : FinanceriskscenarioModel) -> FinanceriskscenarioModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioModel::fill(self : FinanceriskscenarioModel, v : Double) -> FinanceriskscenarioModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioModel::min(self : FinanceriskscenarioModel) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioModel::max(self : FinanceriskscenarioModel) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioModel::to_string(self : FinanceriskscenarioModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_layer_make(size : Int) -> FinanceriskscenarioLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioLayer::len(self : FinanceriskscenarioLayer) -> Int { self.size }

pub fn FinanceriskscenarioLayer::get(self : FinanceriskscenarioLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioLayer::set(self : FinanceriskscenarioLayer, i : Int, v : Double) -> FinanceriskscenarioLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioLayer::sum(self : FinanceriskscenarioLayer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioLayer::mean(self : FinanceriskscenarioLayer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioLayer::scale(self : FinanceriskscenarioLayer, f : Double) -> FinanceriskscenarioLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioLayer::add(self : FinanceriskscenarioLayer, other : FinanceriskscenarioLayer) -> FinanceriskscenarioLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioLayer::copy(self : FinanceriskscenarioLayer) -> FinanceriskscenarioLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioLayer::fill(self : FinanceriskscenarioLayer, v : Double) -> FinanceriskscenarioLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioLayer::min(self : FinanceriskscenarioLayer) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioLayer::max(self : FinanceriskscenarioLayer) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioLayer::to_string(self : FinanceriskscenarioLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_buffer_make(size : Int) -> FinanceriskscenarioBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioBuffer::len(self : FinanceriskscenarioBuffer) -> Int { self.size }

pub fn FinanceriskscenarioBuffer::get(self : FinanceriskscenarioBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioBuffer::set(self : FinanceriskscenarioBuffer, i : Int, v : Double) -> FinanceriskscenarioBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioBuffer::sum(self : FinanceriskscenarioBuffer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioBuffer::mean(self : FinanceriskscenarioBuffer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioBuffer::scale(self : FinanceriskscenarioBuffer, f : Double) -> FinanceriskscenarioBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioBuffer::add(self : FinanceriskscenarioBuffer, other : FinanceriskscenarioBuffer) -> FinanceriskscenarioBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioBuffer::copy(self : FinanceriskscenarioBuffer) -> FinanceriskscenarioBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioBuffer::fill(self : FinanceriskscenarioBuffer, v : Double) -> FinanceriskscenarioBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioBuffer::min(self : FinanceriskscenarioBuffer) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioBuffer::max(self : FinanceriskscenarioBuffer) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioBuffer::to_string(self : FinanceriskscenarioBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_cursor_make(size : Int) -> FinanceriskscenarioCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioCursor::len(self : FinanceriskscenarioCursor) -> Int { self.size }

pub fn FinanceriskscenarioCursor::get(self : FinanceriskscenarioCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioCursor::set(self : FinanceriskscenarioCursor, i : Int, v : Double) -> FinanceriskscenarioCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioCursor::sum(self : FinanceriskscenarioCursor) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioCursor::mean(self : FinanceriskscenarioCursor) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioCursor::scale(self : FinanceriskscenarioCursor, f : Double) -> FinanceriskscenarioCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioCursor::add(self : FinanceriskscenarioCursor, other : FinanceriskscenarioCursor) -> FinanceriskscenarioCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioCursor::copy(self : FinanceriskscenarioCursor) -> FinanceriskscenarioCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioCursor::fill(self : FinanceriskscenarioCursor, v : Double) -> FinanceriskscenarioCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioCursor::min(self : FinanceriskscenarioCursor) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioCursor::max(self : FinanceriskscenarioCursor) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioCursor::to_string(self : FinanceriskscenarioCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_view_make(size : Int) -> FinanceriskscenarioView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioView::len(self : FinanceriskscenarioView) -> Int { self.size }

pub fn FinanceriskscenarioView::get(self : FinanceriskscenarioView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioView::set(self : FinanceriskscenarioView, i : Int, v : Double) -> FinanceriskscenarioView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioView::sum(self : FinanceriskscenarioView) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioView::mean(self : FinanceriskscenarioView) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioView::scale(self : FinanceriskscenarioView, f : Double) -> FinanceriskscenarioView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioView::add(self : FinanceriskscenarioView, other : FinanceriskscenarioView) -> FinanceriskscenarioView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioView::copy(self : FinanceriskscenarioView) -> FinanceriskscenarioView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioView::fill(self : FinanceriskscenarioView, v : Double) -> FinanceriskscenarioView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioView::min(self : FinanceriskscenarioView) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioView::max(self : FinanceriskscenarioView) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioView::to_string(self : FinanceriskscenarioView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_range_make(size : Int) -> FinanceriskscenarioRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioRange::len(self : FinanceriskscenarioRange) -> Int { self.size }

pub fn FinanceriskscenarioRange::get(self : FinanceriskscenarioRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioRange::set(self : FinanceriskscenarioRange, i : Int, v : Double) -> FinanceriskscenarioRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioRange::sum(self : FinanceriskscenarioRange) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioRange::mean(self : FinanceriskscenarioRange) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioRange::scale(self : FinanceriskscenarioRange, f : Double) -> FinanceriskscenarioRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioRange::add(self : FinanceriskscenarioRange, other : FinanceriskscenarioRange) -> FinanceriskscenarioRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioRange::copy(self : FinanceriskscenarioRange) -> FinanceriskscenarioRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioRange::fill(self : FinanceriskscenarioRange, v : Double) -> FinanceriskscenarioRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioRange::min(self : FinanceriskscenarioRange) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioRange::max(self : FinanceriskscenarioRange) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioRange::to_string(self : FinanceriskscenarioRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_slice_make(size : Int) -> FinanceriskscenarioSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskscenarioSlice::len(self : FinanceriskscenarioSlice) -> Int { self.size }

pub fn FinanceriskscenarioSlice::get(self : FinanceriskscenarioSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskscenarioSlice::set(self : FinanceriskscenarioSlice, i : Int, v : Double) -> FinanceriskscenarioSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioSlice::sum(self : FinanceriskscenarioSlice) -> Double { @_common.sum(self.data) }

pub fn FinanceriskscenarioSlice::mean(self : FinanceriskscenarioSlice) -> Double { @_common.mean(self.data) }

pub fn FinanceriskscenarioSlice::scale(self : FinanceriskscenarioSlice, f : Double) -> FinanceriskscenarioSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioSlice::add(self : FinanceriskscenarioSlice, other : FinanceriskscenarioSlice) -> FinanceriskscenarioSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskscenarioSlice::copy(self : FinanceriskscenarioSlice) -> FinanceriskscenarioSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioSlice::fill(self : FinanceriskscenarioSlice, v : Double) -> FinanceriskscenarioSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskscenarioSlice::min(self : FinanceriskscenarioSlice) -> Double { @_common.min(self.data) }

pub fn FinanceriskscenarioSlice::max(self : FinanceriskscenarioSlice) -> Double { @_common.max(self.data) }

pub fn FinanceriskscenarioSlice::to_string(self : FinanceriskscenarioSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

