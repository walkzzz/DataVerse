///===
/// extcore/finance_portfolio_black

pub(all) struct FinanceportfolioblackPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_black_make_point(x : Double, y : Double) -> FinanceportfolioblackPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_black_make_point3(x : Double, y : Double, z : Double) -> FinanceportfolioblackPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfolioblackPoint::x(self : FinanceportfolioblackPoint) -> Double { self.x }

pub fn FinanceportfolioblackPoint::y(self : FinanceportfolioblackPoint) -> Double { self.y }

pub fn FinanceportfolioblackPoint::z(self : FinanceportfolioblackPoint) -> Double { self.z }

pub fn FinanceportfolioblackPoint::label(self : FinanceportfolioblackPoint) -> Int { self.label }

pub fn FinanceportfolioblackPoint::dist(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfolioblackPoint::add(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfolioblackPoint::sub(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfolioblackPoint::scale(self : FinanceportfolioblackPoint, s : Double) -> FinanceportfolioblackPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfolioblackPoint::dot(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfolioblackPoint::cross(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfolioblackPoint::norm(self : FinanceportfolioblackPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfolioblackPoint::normalize(self : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioblackPoint::negate(self : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfolioblackPoint::mid(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfolioblackPoint::lerp(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint, t : Double) -> FinanceportfolioblackPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfolioblackPoint::to_string(self : FinanceportfolioblackPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfolioblackSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_black_make_series(vals : Array[Double], name : String) -> FinanceportfolioblackSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfolioblackSeries::len(self : FinanceportfolioblackSeries) -> Int { self.vals.length() }

pub fn FinanceportfolioblackSeries::sum(self : FinanceportfolioblackSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfolioblackSeries::mean(self : FinanceportfolioblackSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfolioblackSeries::min(self : FinanceportfolioblackSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfolioblackSeries::max(self : FinanceportfolioblackSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfolioblackSeries::range(self : FinanceportfolioblackSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfolioblackSeries::variance(self : FinanceportfolioblackSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfolioblackSeries::std(self : FinanceportfolioblackSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfolioblackSeries::median(self : FinanceportfolioblackSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfolioblackSeries::scale(self : FinanceportfolioblackSeries, f : Double) -> FinanceportfolioblackSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfolioblackSeries::add(self : FinanceportfolioblackSeries, other : FinanceportfolioblackSeries) -> FinanceportfolioblackSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfolioblackSeries::sub(self : FinanceportfolioblackSeries, other : FinanceportfolioblackSeries) -> FinanceportfolioblackSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfolioblackSeries::normalize(self : FinanceportfolioblackSeries) -> FinanceportfolioblackSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfolioblackSeries::cumsum(self : FinanceportfolioblackSeries) -> FinanceportfolioblackSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfolioblackSeries::to_string(self : FinanceportfolioblackSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfolioblackMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_black_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfolioblackMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_black_matrix_identity(n : Int) -> FinanceportfolioblackMatrix {
  let m = finance_portfolio_black_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfolioblackMatrix::get(self : FinanceportfolioblackMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfolioblackMatrix::transpose(self : FinanceportfolioblackMatrix) -> FinanceportfolioblackMatrix {
  let result = finance_portfolio_black_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfolioblackMatrix::add(self : FinanceportfolioblackMatrix, other : FinanceportfolioblackMatrix) -> FinanceportfolioblackMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_black_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfolioblackMatrix::scale(self : FinanceportfolioblackMatrix, s : Double) -> FinanceportfolioblackMatrix {
  let result = finance_portfolio_black_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfolioblackMatrix::multiply(self : FinanceportfolioblackMatrix, other : FinanceportfolioblackMatrix) -> FinanceportfolioblackMatrix {
  if self.cols != other.rows { return finance_portfolio_black_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_black_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceportfolioblackMatrix::trace(self : FinanceportfolioblackMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfolioblackMatrix::det(self : FinanceportfolioblackMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfolioblackMatrix::norm(self : FinanceportfolioblackMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfolioblackMatrix::to_string(self : FinanceportfolioblackMatrix) -> String {
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

pub(all) struct FinanceportfolioblackVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_black_make_vector(comps : Array[Double]) -> FinanceportfolioblackVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_black_vector_zero(dim : Int) -> FinanceportfolioblackVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfolioblackVector::add(self : FinanceportfolioblackVector, other : FinanceportfolioblackVector) -> FinanceportfolioblackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioblackVector::sub(self : FinanceportfolioblackVector, other : FinanceportfolioblackVector) -> FinanceportfolioblackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioblackVector::scale(self : FinanceportfolioblackVector, s : Double) -> FinanceportfolioblackVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfolioblackVector::dot(self : FinanceportfolioblackVector, other : FinanceportfolioblackVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfolioblackVector::norm(self : FinanceportfolioblackVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfolioblackVector::normalize(self : FinanceportfolioblackVector) -> FinanceportfolioblackVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioblackVector::dist(self : FinanceportfolioblackVector, other : FinanceportfolioblackVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfolioblackVector::to_string(self : FinanceportfolioblackVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfolioblackFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_frame_make(size : Int) -> FinanceportfolioblackFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackFrame::len(self : FinanceportfolioblackFrame) -> Int { self.size }

pub fn FinanceportfolioblackFrame::get(self : FinanceportfolioblackFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackFrame::set(self : FinanceportfolioblackFrame, i : Int, v : Double) -> FinanceportfolioblackFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackFrame::sum(self : FinanceportfolioblackFrame) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackFrame::mean(self : FinanceportfolioblackFrame) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackFrame::scale(self : FinanceportfolioblackFrame, f : Double) -> FinanceportfolioblackFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackFrame::add(self : FinanceportfolioblackFrame, other : FinanceportfolioblackFrame) -> FinanceportfolioblackFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackFrame::copy(self : FinanceportfolioblackFrame) -> FinanceportfolioblackFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackFrame::fill(self : FinanceportfolioblackFrame, v : Double) -> FinanceportfolioblackFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackFrame::min(self : FinanceportfolioblackFrame) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackFrame::max(self : FinanceportfolioblackFrame) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackFrame::to_string(self : FinanceportfolioblackFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_table_make(size : Int) -> FinanceportfolioblackTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackTable::len(self : FinanceportfolioblackTable) -> Int { self.size }

pub fn FinanceportfolioblackTable::get(self : FinanceportfolioblackTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackTable::set(self : FinanceportfolioblackTable, i : Int, v : Double) -> FinanceportfolioblackTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackTable::sum(self : FinanceportfolioblackTable) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackTable::mean(self : FinanceportfolioblackTable) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackTable::scale(self : FinanceportfolioblackTable, f : Double) -> FinanceportfolioblackTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackTable::add(self : FinanceportfolioblackTable, other : FinanceportfolioblackTable) -> FinanceportfolioblackTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackTable::copy(self : FinanceportfolioblackTable) -> FinanceportfolioblackTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackTable::fill(self : FinanceportfolioblackTable, v : Double) -> FinanceportfolioblackTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackTable::min(self : FinanceportfolioblackTable) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackTable::max(self : FinanceportfolioblackTable) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackTable::to_string(self : FinanceportfolioblackTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_graphn_make(size : Int) -> FinanceportfolioblackGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackGraphN::len(self : FinanceportfolioblackGraphN) -> Int { self.size }

pub fn FinanceportfolioblackGraphN::get(self : FinanceportfolioblackGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackGraphN::set(self : FinanceportfolioblackGraphN, i : Int, v : Double) -> FinanceportfolioblackGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackGraphN::sum(self : FinanceportfolioblackGraphN) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackGraphN::mean(self : FinanceportfolioblackGraphN) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackGraphN::scale(self : FinanceportfolioblackGraphN, f : Double) -> FinanceportfolioblackGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackGraphN::add(self : FinanceportfolioblackGraphN, other : FinanceportfolioblackGraphN) -> FinanceportfolioblackGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackGraphN::copy(self : FinanceportfolioblackGraphN) -> FinanceportfolioblackGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackGraphN::fill(self : FinanceportfolioblackGraphN, v : Double) -> FinanceportfolioblackGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackGraphN::min(self : FinanceportfolioblackGraphN) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackGraphN::max(self : FinanceportfolioblackGraphN) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackGraphN::to_string(self : FinanceportfolioblackGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_node_make(size : Int) -> FinanceportfolioblackNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackNode::len(self : FinanceportfolioblackNode) -> Int { self.size }

pub fn FinanceportfolioblackNode::get(self : FinanceportfolioblackNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackNode::set(self : FinanceportfolioblackNode, i : Int, v : Double) -> FinanceportfolioblackNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackNode::sum(self : FinanceportfolioblackNode) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackNode::mean(self : FinanceportfolioblackNode) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackNode::scale(self : FinanceportfolioblackNode, f : Double) -> FinanceportfolioblackNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackNode::add(self : FinanceportfolioblackNode, other : FinanceportfolioblackNode) -> FinanceportfolioblackNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackNode::copy(self : FinanceportfolioblackNode) -> FinanceportfolioblackNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackNode::fill(self : FinanceportfolioblackNode, v : Double) -> FinanceportfolioblackNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackNode::min(self : FinanceportfolioblackNode) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackNode::max(self : FinanceportfolioblackNode) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackNode::to_string(self : FinanceportfolioblackNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_edge_make(size : Int) -> FinanceportfolioblackEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackEdge::len(self : FinanceportfolioblackEdge) -> Int { self.size }

pub fn FinanceportfolioblackEdge::get(self : FinanceportfolioblackEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackEdge::set(self : FinanceportfolioblackEdge, i : Int, v : Double) -> FinanceportfolioblackEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackEdge::sum(self : FinanceportfolioblackEdge) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackEdge::mean(self : FinanceportfolioblackEdge) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackEdge::scale(self : FinanceportfolioblackEdge, f : Double) -> FinanceportfolioblackEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackEdge::add(self : FinanceportfolioblackEdge, other : FinanceportfolioblackEdge) -> FinanceportfolioblackEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackEdge::copy(self : FinanceportfolioblackEdge) -> FinanceportfolioblackEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackEdge::fill(self : FinanceportfolioblackEdge, v : Double) -> FinanceportfolioblackEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackEdge::min(self : FinanceportfolioblackEdge) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackEdge::max(self : FinanceportfolioblackEdge) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackEdge::to_string(self : FinanceportfolioblackEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_path_make(size : Int) -> FinanceportfolioblackPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackPath::len(self : FinanceportfolioblackPath) -> Int { self.size }

pub fn FinanceportfolioblackPath::get(self : FinanceportfolioblackPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackPath::set(self : FinanceportfolioblackPath, i : Int, v : Double) -> FinanceportfolioblackPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackPath::sum(self : FinanceportfolioblackPath) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackPath::mean(self : FinanceportfolioblackPath) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackPath::scale(self : FinanceportfolioblackPath, f : Double) -> FinanceportfolioblackPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackPath::add(self : FinanceportfolioblackPath, other : FinanceportfolioblackPath) -> FinanceportfolioblackPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackPath::copy(self : FinanceportfolioblackPath) -> FinanceportfolioblackPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackPath::fill(self : FinanceportfolioblackPath, v : Double) -> FinanceportfolioblackPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackPath::min(self : FinanceportfolioblackPath) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackPath::max(self : FinanceportfolioblackPath) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackPath::to_string(self : FinanceportfolioblackPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_cluster_make(size : Int) -> FinanceportfolioblackCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackCluster::len(self : FinanceportfolioblackCluster) -> Int { self.size }

pub fn FinanceportfolioblackCluster::get(self : FinanceportfolioblackCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackCluster::set(self : FinanceportfolioblackCluster, i : Int, v : Double) -> FinanceportfolioblackCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackCluster::sum(self : FinanceportfolioblackCluster) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackCluster::mean(self : FinanceportfolioblackCluster) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackCluster::scale(self : FinanceportfolioblackCluster, f : Double) -> FinanceportfolioblackCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackCluster::add(self : FinanceportfolioblackCluster, other : FinanceportfolioblackCluster) -> FinanceportfolioblackCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackCluster::copy(self : FinanceportfolioblackCluster) -> FinanceportfolioblackCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackCluster::fill(self : FinanceportfolioblackCluster, v : Double) -> FinanceportfolioblackCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackCluster::min(self : FinanceportfolioblackCluster) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackCluster::max(self : FinanceportfolioblackCluster) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackCluster::to_string(self : FinanceportfolioblackCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_model_make(size : Int) -> FinanceportfolioblackModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackModel::len(self : FinanceportfolioblackModel) -> Int { self.size }

pub fn FinanceportfolioblackModel::get(self : FinanceportfolioblackModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackModel::set(self : FinanceportfolioblackModel, i : Int, v : Double) -> FinanceportfolioblackModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackModel::sum(self : FinanceportfolioblackModel) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackModel::mean(self : FinanceportfolioblackModel) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackModel::scale(self : FinanceportfolioblackModel, f : Double) -> FinanceportfolioblackModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackModel::add(self : FinanceportfolioblackModel, other : FinanceportfolioblackModel) -> FinanceportfolioblackModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackModel::copy(self : FinanceportfolioblackModel) -> FinanceportfolioblackModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackModel::fill(self : FinanceportfolioblackModel, v : Double) -> FinanceportfolioblackModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackModel::min(self : FinanceportfolioblackModel) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackModel::max(self : FinanceportfolioblackModel) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackModel::to_string(self : FinanceportfolioblackModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_layer_make(size : Int) -> FinanceportfolioblackLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackLayer::len(self : FinanceportfolioblackLayer) -> Int { self.size }

pub fn FinanceportfolioblackLayer::get(self : FinanceportfolioblackLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackLayer::set(self : FinanceportfolioblackLayer, i : Int, v : Double) -> FinanceportfolioblackLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackLayer::sum(self : FinanceportfolioblackLayer) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackLayer::mean(self : FinanceportfolioblackLayer) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackLayer::scale(self : FinanceportfolioblackLayer, f : Double) -> FinanceportfolioblackLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackLayer::add(self : FinanceportfolioblackLayer, other : FinanceportfolioblackLayer) -> FinanceportfolioblackLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackLayer::copy(self : FinanceportfolioblackLayer) -> FinanceportfolioblackLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackLayer::fill(self : FinanceportfolioblackLayer, v : Double) -> FinanceportfolioblackLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackLayer::min(self : FinanceportfolioblackLayer) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackLayer::max(self : FinanceportfolioblackLayer) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackLayer::to_string(self : FinanceportfolioblackLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_buffer_make(size : Int) -> FinanceportfolioblackBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackBuffer::len(self : FinanceportfolioblackBuffer) -> Int { self.size }

pub fn FinanceportfolioblackBuffer::get(self : FinanceportfolioblackBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackBuffer::set(self : FinanceportfolioblackBuffer, i : Int, v : Double) -> FinanceportfolioblackBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackBuffer::sum(self : FinanceportfolioblackBuffer) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackBuffer::mean(self : FinanceportfolioblackBuffer) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackBuffer::scale(self : FinanceportfolioblackBuffer, f : Double) -> FinanceportfolioblackBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackBuffer::add(self : FinanceportfolioblackBuffer, other : FinanceportfolioblackBuffer) -> FinanceportfolioblackBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackBuffer::copy(self : FinanceportfolioblackBuffer) -> FinanceportfolioblackBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackBuffer::fill(self : FinanceportfolioblackBuffer, v : Double) -> FinanceportfolioblackBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackBuffer::min(self : FinanceportfolioblackBuffer) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackBuffer::max(self : FinanceportfolioblackBuffer) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackBuffer::to_string(self : FinanceportfolioblackBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_cursor_make(size : Int) -> FinanceportfolioblackCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackCursor::len(self : FinanceportfolioblackCursor) -> Int { self.size }

pub fn FinanceportfolioblackCursor::get(self : FinanceportfolioblackCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackCursor::set(self : FinanceportfolioblackCursor, i : Int, v : Double) -> FinanceportfolioblackCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackCursor::sum(self : FinanceportfolioblackCursor) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackCursor::mean(self : FinanceportfolioblackCursor) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackCursor::scale(self : FinanceportfolioblackCursor, f : Double) -> FinanceportfolioblackCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackCursor::add(self : FinanceportfolioblackCursor, other : FinanceportfolioblackCursor) -> FinanceportfolioblackCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackCursor::copy(self : FinanceportfolioblackCursor) -> FinanceportfolioblackCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackCursor::fill(self : FinanceportfolioblackCursor, v : Double) -> FinanceportfolioblackCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackCursor::min(self : FinanceportfolioblackCursor) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackCursor::max(self : FinanceportfolioblackCursor) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackCursor::to_string(self : FinanceportfolioblackCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_view_make(size : Int) -> FinanceportfolioblackView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackView::len(self : FinanceportfolioblackView) -> Int { self.size }

pub fn FinanceportfolioblackView::get(self : FinanceportfolioblackView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackView::set(self : FinanceportfolioblackView, i : Int, v : Double) -> FinanceportfolioblackView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackView::sum(self : FinanceportfolioblackView) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackView::mean(self : FinanceportfolioblackView) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackView::scale(self : FinanceportfolioblackView, f : Double) -> FinanceportfolioblackView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackView::add(self : FinanceportfolioblackView, other : FinanceportfolioblackView) -> FinanceportfolioblackView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackView::copy(self : FinanceportfolioblackView) -> FinanceportfolioblackView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackView::fill(self : FinanceportfolioblackView, v : Double) -> FinanceportfolioblackView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackView::min(self : FinanceportfolioblackView) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackView::max(self : FinanceportfolioblackView) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackView::to_string(self : FinanceportfolioblackView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_range_make(size : Int) -> FinanceportfolioblackRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackRange::len(self : FinanceportfolioblackRange) -> Int { self.size }

pub fn FinanceportfolioblackRange::get(self : FinanceportfolioblackRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackRange::set(self : FinanceportfolioblackRange, i : Int, v : Double) -> FinanceportfolioblackRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackRange::sum(self : FinanceportfolioblackRange) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackRange::mean(self : FinanceportfolioblackRange) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackRange::scale(self : FinanceportfolioblackRange, f : Double) -> FinanceportfolioblackRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackRange::add(self : FinanceportfolioblackRange, other : FinanceportfolioblackRange) -> FinanceportfolioblackRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackRange::copy(self : FinanceportfolioblackRange) -> FinanceportfolioblackRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackRange::fill(self : FinanceportfolioblackRange, v : Double) -> FinanceportfolioblackRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackRange::min(self : FinanceportfolioblackRange) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackRange::max(self : FinanceportfolioblackRange) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackRange::to_string(self : FinanceportfolioblackRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_slice_make(size : Int) -> FinanceportfolioblackSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfolioblackSlice::len(self : FinanceportfolioblackSlice) -> Int { self.size }

pub fn FinanceportfolioblackSlice::get(self : FinanceportfolioblackSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfolioblackSlice::set(self : FinanceportfolioblackSlice, i : Int, v : Double) -> FinanceportfolioblackSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackSlice::sum(self : FinanceportfolioblackSlice) -> Double { @_common.sum(self.data) }

pub fn FinanceportfolioblackSlice::mean(self : FinanceportfolioblackSlice) -> Double { @_common.mean(self.data) }

pub fn FinanceportfolioblackSlice::scale(self : FinanceportfolioblackSlice, f : Double) -> FinanceportfolioblackSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackSlice::add(self : FinanceportfolioblackSlice, other : FinanceportfolioblackSlice) -> FinanceportfolioblackSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfolioblackSlice::copy(self : FinanceportfolioblackSlice) -> FinanceportfolioblackSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackSlice::fill(self : FinanceportfolioblackSlice, v : Double) -> FinanceportfolioblackSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfolioblackSlice::min(self : FinanceportfolioblackSlice) -> Double { @_common.min(self.data) }

pub fn FinanceportfolioblackSlice::max(self : FinanceportfolioblackSlice) -> Double { @_common.max(self.data) }

pub fn FinanceportfolioblackSlice::to_string(self : FinanceportfolioblackSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

