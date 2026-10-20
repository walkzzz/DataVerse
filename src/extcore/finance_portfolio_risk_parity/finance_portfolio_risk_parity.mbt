///===
/// extcore/finance_portfolio_risk_parity

pub(all) struct FinanceportfolioriskparityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_risk_parity_make_point(x : Double, y : Double) -> FinanceportfolioriskparityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_risk_parity_make_point3(x : Double, y : Double, z : Double) -> FinanceportfolioriskparityPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfolioriskparityPoint::x(self : FinanceportfolioriskparityPoint) -> Double { self.x }

pub fn FinanceportfolioriskparityPoint::y(self : FinanceportfolioriskparityPoint) -> Double { self.y }

pub fn FinanceportfolioriskparityPoint::z(self : FinanceportfolioriskparityPoint) -> Double { self.z }

pub fn FinanceportfolioriskparityPoint::label(self : FinanceportfolioriskparityPoint) -> Int { self.label }

pub fn FinanceportfolioriskparityPoint::dist(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfolioriskparityPoint::add(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::sub(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::scale(self : FinanceportfolioriskparityPoint, s : Double) -> FinanceportfolioriskparityPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::dot(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfolioriskparityPoint::cross(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfolioriskparityPoint::norm(self : FinanceportfolioriskparityPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfolioriskparityPoint::normalize(self : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioriskparityPoint::negate(self : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::mid(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::lerp(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint, t : Double) -> FinanceportfolioriskparityPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::to_string(self : FinanceportfolioriskparityPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_risk_parity_make_series(vals : Array[Double], name : String) -> FinanceportfolioriskparitySeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfolioriskparitySeries::len(self : FinanceportfolioriskparitySeries) -> Int { self.vals.length() }

pub fn FinanceportfolioriskparitySeries::sum(self : FinanceportfolioriskparitySeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfolioriskparitySeries::mean(self : FinanceportfolioriskparitySeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfolioriskparitySeries::min(self : FinanceportfolioriskparitySeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfolioriskparitySeries::max(self : FinanceportfolioriskparitySeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfolioriskparitySeries::range(self : FinanceportfolioriskparitySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfolioriskparitySeries::variance(self : FinanceportfolioriskparitySeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfolioriskparitySeries::std(self : FinanceportfolioriskparitySeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfolioriskparitySeries::median(self : FinanceportfolioriskparitySeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfolioriskparitySeries::scale(self : FinanceportfolioriskparitySeries, f : Double) -> FinanceportfolioriskparitySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfolioriskparitySeries::add(self : FinanceportfolioriskparitySeries, other : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfolioriskparitySeries::sub(self : FinanceportfolioriskparitySeries, other : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfolioriskparitySeries::normalize(self : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfolioriskparitySeries::cumsum(self : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfolioriskparitySeries::to_string(self : FinanceportfolioriskparitySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfolioriskparityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_risk_parity_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfolioriskparityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_risk_parity_matrix_identity(n : Int) -> FinanceportfolioriskparityMatrix {
  let m = finance_portfolio_risk_parity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfolioriskparityMatrix::get(self : FinanceportfolioriskparityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfolioriskparityMatrix::transpose(self : FinanceportfolioriskparityMatrix) -> FinanceportfolioriskparityMatrix {
  let result = finance_portfolio_risk_parity_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfolioriskparityMatrix::add(self : FinanceportfolioriskparityMatrix, other : FinanceportfolioriskparityMatrix) -> FinanceportfolioriskparityMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_risk_parity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfolioriskparityMatrix::scale(self : FinanceportfolioriskparityMatrix, s : Double) -> FinanceportfolioriskparityMatrix {
  let result = finance_portfolio_risk_parity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfolioriskparityMatrix::multiply(self : FinanceportfolioriskparityMatrix, other : FinanceportfolioriskparityMatrix) -> FinanceportfolioriskparityMatrix {
  if self.cols != other.rows { return finance_portfolio_risk_parity_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_risk_parity_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceportfolioriskparityMatrix::trace(self : FinanceportfolioriskparityMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfolioriskparityMatrix::det(self : FinanceportfolioriskparityMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfolioriskparityMatrix::norm(self : FinanceportfolioriskparityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfolioriskparityMatrix::to_string(self : FinanceportfolioriskparityMatrix) -> String {
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

pub(all) struct FinanceportfolioriskparityVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_risk_parity_make_vector(comps : Array[Double]) -> FinanceportfolioriskparityVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_risk_parity_vector_zero(dim : Int) -> FinanceportfolioriskparityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfolioriskparityVector::add(self : FinanceportfolioriskparityVector, other : FinanceportfolioriskparityVector) -> FinanceportfolioriskparityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioriskparityVector::sub(self : FinanceportfolioriskparityVector, other : FinanceportfolioriskparityVector) -> FinanceportfolioriskparityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioriskparityVector::scale(self : FinanceportfolioriskparityVector, s : Double) -> FinanceportfolioriskparityVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfolioriskparityVector::dot(self : FinanceportfolioriskparityVector, other : FinanceportfolioriskparityVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfolioriskparityVector::norm(self : FinanceportfolioriskparityVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfolioriskparityVector::normalize(self : FinanceportfolioriskparityVector) -> FinanceportfolioriskparityVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioriskparityVector::dist(self : FinanceportfolioriskparityVector, other : FinanceportfolioriskparityVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfolioriskparityVector::to_string(self : FinanceportfolioriskparityVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfolioriskparityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_frame_make(size : Int) -> FinanceportfolioriskparityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityFrame::len(self : FinanceportfolioriskparityFrame) -> Int { self.size }

pub fn FinanceportfolioriskparityFrame::get(self : FinanceportfolioriskparityFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityFrame::set(self : FinanceportfolioriskparityFrame, i : Int, v : Double) -> FinanceportfolioriskparityFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityFrame::sum(self : FinanceportfolioriskparityFrame) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityFrame::mean(self : FinanceportfolioriskparityFrame) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityFrame::scale(self : FinanceportfolioriskparityFrame, f : Double) -> FinanceportfolioriskparityFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityFrame::add(self : FinanceportfolioriskparityFrame, other : FinanceportfolioriskparityFrame) -> FinanceportfolioriskparityFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityFrame::copy(self : FinanceportfolioriskparityFrame) -> FinanceportfolioriskparityFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityFrame::fill(self : FinanceportfolioriskparityFrame, v : Double) -> FinanceportfolioriskparityFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityFrame::min(self : FinanceportfolioriskparityFrame) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityFrame::max(self : FinanceportfolioriskparityFrame) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityFrame::to_string(self : FinanceportfolioriskparityFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_table_make(size : Int) -> FinanceportfolioriskparityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityTable::len(self : FinanceportfolioriskparityTable) -> Int { self.size }

pub fn FinanceportfolioriskparityTable::get(self : FinanceportfolioriskparityTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityTable::set(self : FinanceportfolioriskparityTable, i : Int, v : Double) -> FinanceportfolioriskparityTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityTable::sum(self : FinanceportfolioriskparityTable) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityTable::mean(self : FinanceportfolioriskparityTable) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityTable::scale(self : FinanceportfolioriskparityTable, f : Double) -> FinanceportfolioriskparityTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityTable::add(self : FinanceportfolioriskparityTable, other : FinanceportfolioriskparityTable) -> FinanceportfolioriskparityTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityTable::copy(self : FinanceportfolioriskparityTable) -> FinanceportfolioriskparityTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityTable::fill(self : FinanceportfolioriskparityTable, v : Double) -> FinanceportfolioriskparityTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityTable::min(self : FinanceportfolioriskparityTable) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityTable::max(self : FinanceportfolioriskparityTable) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityTable::to_string(self : FinanceportfolioriskparityTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_graphn_make(size : Int) -> FinanceportfolioriskparityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityGraphN::len(self : FinanceportfolioriskparityGraphN) -> Int { self.size }

pub fn FinanceportfolioriskparityGraphN::get(self : FinanceportfolioriskparityGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityGraphN::set(self : FinanceportfolioriskparityGraphN, i : Int, v : Double) -> FinanceportfolioriskparityGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityGraphN::sum(self : FinanceportfolioriskparityGraphN) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityGraphN::mean(self : FinanceportfolioriskparityGraphN) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityGraphN::scale(self : FinanceportfolioriskparityGraphN, f : Double) -> FinanceportfolioriskparityGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityGraphN::add(self : FinanceportfolioriskparityGraphN, other : FinanceportfolioriskparityGraphN) -> FinanceportfolioriskparityGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityGraphN::copy(self : FinanceportfolioriskparityGraphN) -> FinanceportfolioriskparityGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityGraphN::fill(self : FinanceportfolioriskparityGraphN, v : Double) -> FinanceportfolioriskparityGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityGraphN::min(self : FinanceportfolioriskparityGraphN) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityGraphN::max(self : FinanceportfolioriskparityGraphN) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityGraphN::to_string(self : FinanceportfolioriskparityGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_node_make(size : Int) -> FinanceportfolioriskparityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityNode::len(self : FinanceportfolioriskparityNode) -> Int { self.size }

pub fn FinanceportfolioriskparityNode::get(self : FinanceportfolioriskparityNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityNode::set(self : FinanceportfolioriskparityNode, i : Int, v : Double) -> FinanceportfolioriskparityNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityNode::sum(self : FinanceportfolioriskparityNode) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityNode::mean(self : FinanceportfolioriskparityNode) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityNode::scale(self : FinanceportfolioriskparityNode, f : Double) -> FinanceportfolioriskparityNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityNode::add(self : FinanceportfolioriskparityNode, other : FinanceportfolioriskparityNode) -> FinanceportfolioriskparityNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityNode::copy(self : FinanceportfolioriskparityNode) -> FinanceportfolioriskparityNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityNode::fill(self : FinanceportfolioriskparityNode, v : Double) -> FinanceportfolioriskparityNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityNode::min(self : FinanceportfolioriskparityNode) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityNode::max(self : FinanceportfolioriskparityNode) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityNode::to_string(self : FinanceportfolioriskparityNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_edge_make(size : Int) -> FinanceportfolioriskparityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityEdge::len(self : FinanceportfolioriskparityEdge) -> Int { self.size }

pub fn FinanceportfolioriskparityEdge::get(self : FinanceportfolioriskparityEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityEdge::set(self : FinanceportfolioriskparityEdge, i : Int, v : Double) -> FinanceportfolioriskparityEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityEdge::sum(self : FinanceportfolioriskparityEdge) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityEdge::mean(self : FinanceportfolioriskparityEdge) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityEdge::scale(self : FinanceportfolioriskparityEdge, f : Double) -> FinanceportfolioriskparityEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityEdge::add(self : FinanceportfolioriskparityEdge, other : FinanceportfolioriskparityEdge) -> FinanceportfolioriskparityEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityEdge::copy(self : FinanceportfolioriskparityEdge) -> FinanceportfolioriskparityEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityEdge::fill(self : FinanceportfolioriskparityEdge, v : Double) -> FinanceportfolioriskparityEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityEdge::min(self : FinanceportfolioriskparityEdge) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityEdge::max(self : FinanceportfolioriskparityEdge) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityEdge::to_string(self : FinanceportfolioriskparityEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_path_make(size : Int) -> FinanceportfolioriskparityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityPath::len(self : FinanceportfolioriskparityPath) -> Int { self.size }

pub fn FinanceportfolioriskparityPath::get(self : FinanceportfolioriskparityPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityPath::set(self : FinanceportfolioriskparityPath, i : Int, v : Double) -> FinanceportfolioriskparityPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityPath::sum(self : FinanceportfolioriskparityPath) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityPath::mean(self : FinanceportfolioriskparityPath) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityPath::scale(self : FinanceportfolioriskparityPath, f : Double) -> FinanceportfolioriskparityPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityPath::add(self : FinanceportfolioriskparityPath, other : FinanceportfolioriskparityPath) -> FinanceportfolioriskparityPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityPath::copy(self : FinanceportfolioriskparityPath) -> FinanceportfolioriskparityPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityPath::fill(self : FinanceportfolioriskparityPath, v : Double) -> FinanceportfolioriskparityPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityPath::min(self : FinanceportfolioriskparityPath) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityPath::max(self : FinanceportfolioriskparityPath) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityPath::to_string(self : FinanceportfolioriskparityPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_cluster_make(size : Int) -> FinanceportfolioriskparityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityCluster::len(self : FinanceportfolioriskparityCluster) -> Int { self.size }

pub fn FinanceportfolioriskparityCluster::get(self : FinanceportfolioriskparityCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityCluster::set(self : FinanceportfolioriskparityCluster, i : Int, v : Double) -> FinanceportfolioriskparityCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityCluster::sum(self : FinanceportfolioriskparityCluster) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityCluster::mean(self : FinanceportfolioriskparityCluster) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityCluster::scale(self : FinanceportfolioriskparityCluster, f : Double) -> FinanceportfolioriskparityCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityCluster::add(self : FinanceportfolioriskparityCluster, other : FinanceportfolioriskparityCluster) -> FinanceportfolioriskparityCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityCluster::copy(self : FinanceportfolioriskparityCluster) -> FinanceportfolioriskparityCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityCluster::fill(self : FinanceportfolioriskparityCluster, v : Double) -> FinanceportfolioriskparityCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityCluster::min(self : FinanceportfolioriskparityCluster) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityCluster::max(self : FinanceportfolioriskparityCluster) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityCluster::to_string(self : FinanceportfolioriskparityCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_model_make(size : Int) -> FinanceportfolioriskparityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityModel::len(self : FinanceportfolioriskparityModel) -> Int { self.size }

pub fn FinanceportfolioriskparityModel::get(self : FinanceportfolioriskparityModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityModel::set(self : FinanceportfolioriskparityModel, i : Int, v : Double) -> FinanceportfolioriskparityModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityModel::sum(self : FinanceportfolioriskparityModel) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityModel::mean(self : FinanceportfolioriskparityModel) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityModel::scale(self : FinanceportfolioriskparityModel, f : Double) -> FinanceportfolioriskparityModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityModel::add(self : FinanceportfolioriskparityModel, other : FinanceportfolioriskparityModel) -> FinanceportfolioriskparityModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityModel::copy(self : FinanceportfolioriskparityModel) -> FinanceportfolioriskparityModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityModel::fill(self : FinanceportfolioriskparityModel, v : Double) -> FinanceportfolioriskparityModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityModel::min(self : FinanceportfolioriskparityModel) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityModel::max(self : FinanceportfolioriskparityModel) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityModel::to_string(self : FinanceportfolioriskparityModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_layer_make(size : Int) -> FinanceportfolioriskparityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityLayer::len(self : FinanceportfolioriskparityLayer) -> Int { self.size }

pub fn FinanceportfolioriskparityLayer::get(self : FinanceportfolioriskparityLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityLayer::set(self : FinanceportfolioriskparityLayer, i : Int, v : Double) -> FinanceportfolioriskparityLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityLayer::sum(self : FinanceportfolioriskparityLayer) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityLayer::mean(self : FinanceportfolioriskparityLayer) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityLayer::scale(self : FinanceportfolioriskparityLayer, f : Double) -> FinanceportfolioriskparityLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityLayer::add(self : FinanceportfolioriskparityLayer, other : FinanceportfolioriskparityLayer) -> FinanceportfolioriskparityLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityLayer::copy(self : FinanceportfolioriskparityLayer) -> FinanceportfolioriskparityLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityLayer::fill(self : FinanceportfolioriskparityLayer, v : Double) -> FinanceportfolioriskparityLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityLayer::min(self : FinanceportfolioriskparityLayer) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityLayer::max(self : FinanceportfolioriskparityLayer) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityLayer::to_string(self : FinanceportfolioriskparityLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_buffer_make(size : Int) -> FinanceportfolioriskparityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityBuffer::len(self : FinanceportfolioriskparityBuffer) -> Int { self.size }

pub fn FinanceportfolioriskparityBuffer::get(self : FinanceportfolioriskparityBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityBuffer::set(self : FinanceportfolioriskparityBuffer, i : Int, v : Double) -> FinanceportfolioriskparityBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityBuffer::sum(self : FinanceportfolioriskparityBuffer) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityBuffer::mean(self : FinanceportfolioriskparityBuffer) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityBuffer::scale(self : FinanceportfolioriskparityBuffer, f : Double) -> FinanceportfolioriskparityBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityBuffer::add(self : FinanceportfolioriskparityBuffer, other : FinanceportfolioriskparityBuffer) -> FinanceportfolioriskparityBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityBuffer::copy(self : FinanceportfolioriskparityBuffer) -> FinanceportfolioriskparityBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityBuffer::fill(self : FinanceportfolioriskparityBuffer, v : Double) -> FinanceportfolioriskparityBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityBuffer::min(self : FinanceportfolioriskparityBuffer) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityBuffer::max(self : FinanceportfolioriskparityBuffer) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityBuffer::to_string(self : FinanceportfolioriskparityBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_cursor_make(size : Int) -> FinanceportfolioriskparityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityCursor::len(self : FinanceportfolioriskparityCursor) -> Int { self.size }

pub fn FinanceportfolioriskparityCursor::get(self : FinanceportfolioriskparityCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityCursor::set(self : FinanceportfolioriskparityCursor, i : Int, v : Double) -> FinanceportfolioriskparityCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityCursor::sum(self : FinanceportfolioriskparityCursor) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityCursor::mean(self : FinanceportfolioriskparityCursor) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityCursor::scale(self : FinanceportfolioriskparityCursor, f : Double) -> FinanceportfolioriskparityCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityCursor::add(self : FinanceportfolioriskparityCursor, other : FinanceportfolioriskparityCursor) -> FinanceportfolioriskparityCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityCursor::copy(self : FinanceportfolioriskparityCursor) -> FinanceportfolioriskparityCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityCursor::fill(self : FinanceportfolioriskparityCursor, v : Double) -> FinanceportfolioriskparityCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityCursor::min(self : FinanceportfolioriskparityCursor) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityCursor::max(self : FinanceportfolioriskparityCursor) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityCursor::to_string(self : FinanceportfolioriskparityCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_view_make(size : Int) -> FinanceportfolioriskparityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityView::len(self : FinanceportfolioriskparityView) -> Int { self.size }

pub fn FinanceportfolioriskparityView::get(self : FinanceportfolioriskparityView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityView::set(self : FinanceportfolioriskparityView, i : Int, v : Double) -> FinanceportfolioriskparityView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityView::sum(self : FinanceportfolioriskparityView) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityView::mean(self : FinanceportfolioriskparityView) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityView::scale(self : FinanceportfolioriskparityView, f : Double) -> FinanceportfolioriskparityView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityView::add(self : FinanceportfolioriskparityView, other : FinanceportfolioriskparityView) -> FinanceportfolioriskparityView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityView::copy(self : FinanceportfolioriskparityView) -> FinanceportfolioriskparityView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityView::fill(self : FinanceportfolioriskparityView, v : Double) -> FinanceportfolioriskparityView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityView::min(self : FinanceportfolioriskparityView) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityView::max(self : FinanceportfolioriskparityView) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityView::to_string(self : FinanceportfolioriskparityView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_range_make(size : Int) -> FinanceportfolioriskparityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparityRange::len(self : FinanceportfolioriskparityRange) -> Int { self.size }

pub fn FinanceportfolioriskparityRange::get(self : FinanceportfolioriskparityRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparityRange::set(self : FinanceportfolioriskparityRange, i : Int, v : Double) -> FinanceportfolioriskparityRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityRange::sum(self : FinanceportfolioriskparityRange) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparityRange::mean(self : FinanceportfolioriskparityRange) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparityRange::scale(self : FinanceportfolioriskparityRange, f : Double) -> FinanceportfolioriskparityRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityRange::add(self : FinanceportfolioriskparityRange, other : FinanceportfolioriskparityRange) -> FinanceportfolioriskparityRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparityRange::copy(self : FinanceportfolioriskparityRange) -> FinanceportfolioriskparityRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityRange::fill(self : FinanceportfolioriskparityRange, v : Double) -> FinanceportfolioriskparityRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparityRange::min(self : FinanceportfolioriskparityRange) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparityRange::max(self : FinanceportfolioriskparityRange) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparityRange::to_string(self : FinanceportfolioriskparityRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_slice_make(size : Int) -> FinanceportfolioriskparitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioriskparitySlice::len(self : FinanceportfolioriskparitySlice) -> Int { self.size }

pub fn FinanceportfolioriskparitySlice::get(self : FinanceportfolioriskparitySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioriskparitySlice::set(self : FinanceportfolioriskparitySlice, i : Int, v : Double) -> FinanceportfolioriskparitySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparitySlice::sum(self : FinanceportfolioriskparitySlice) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioriskparitySlice::mean(self : FinanceportfolioriskparitySlice) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioriskparitySlice::scale(self : FinanceportfolioriskparitySlice, f : Double) -> FinanceportfolioriskparitySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparitySlice::add(self : FinanceportfolioriskparitySlice, other : FinanceportfolioriskparitySlice) -> FinanceportfolioriskparitySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioriskparitySlice::copy(self : FinanceportfolioriskparitySlice) -> FinanceportfolioriskparitySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparitySlice::fill(self : FinanceportfolioriskparitySlice, v : Double) -> FinanceportfolioriskparitySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioriskparitySlice::min(self : FinanceportfolioriskparitySlice) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioriskparitySlice::max(self : FinanceportfolioriskparitySlice) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioriskparitySlice::to_string(self : FinanceportfolioriskparitySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

