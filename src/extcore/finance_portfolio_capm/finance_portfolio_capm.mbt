///===
/// extcore/finance_portfolio_capm

pub(all) struct FinanceportfoliocapmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_capm_make_point(x : Double, y : Double) -> FinanceportfoliocapmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_capm_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliocapmPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfoliocapmPoint::x(self : FinanceportfoliocapmPoint) -> Double { self.x }

pub fn FinanceportfoliocapmPoint::y(self : FinanceportfoliocapmPoint) -> Double { self.y }

pub fn FinanceportfoliocapmPoint::z(self : FinanceportfoliocapmPoint) -> Double { self.z }

pub fn FinanceportfoliocapmPoint::label(self : FinanceportfoliocapmPoint) -> Int { self.label }

pub fn FinanceportfoliocapmPoint::dist(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfoliocapmPoint::add(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfoliocapmPoint::sub(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfoliocapmPoint::scale(self : FinanceportfoliocapmPoint, s : Double) -> FinanceportfoliocapmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfoliocapmPoint::dot(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfoliocapmPoint::cross(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfoliocapmPoint::norm(self : FinanceportfoliocapmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfoliocapmPoint::normalize(self : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliocapmPoint::negate(self : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfoliocapmPoint::mid(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfoliocapmPoint::lerp(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint, t : Double) -> FinanceportfoliocapmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfoliocapmPoint::to_string(self : FinanceportfoliocapmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_capm_make_series(vals : Array[Double], name : String) -> FinanceportfoliocapmSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfoliocapmSeries::len(self : FinanceportfoliocapmSeries) -> Int { self.vals.length() }

pub fn FinanceportfoliocapmSeries::sum(self : FinanceportfoliocapmSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfoliocapmSeries::mean(self : FinanceportfoliocapmSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfoliocapmSeries::min(self : FinanceportfoliocapmSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfoliocapmSeries::max(self : FinanceportfoliocapmSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfoliocapmSeries::range(self : FinanceportfoliocapmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfoliocapmSeries::variance(self : FinanceportfoliocapmSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfoliocapmSeries::std(self : FinanceportfoliocapmSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfoliocapmSeries::median(self : FinanceportfoliocapmSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfoliocapmSeries::scale(self : FinanceportfoliocapmSeries, f : Double) -> FinanceportfoliocapmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfoliocapmSeries::add(self : FinanceportfoliocapmSeries, other : FinanceportfoliocapmSeries) -> FinanceportfoliocapmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfoliocapmSeries::sub(self : FinanceportfoliocapmSeries, other : FinanceportfoliocapmSeries) -> FinanceportfoliocapmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfoliocapmSeries::normalize(self : FinanceportfoliocapmSeries) -> FinanceportfoliocapmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfoliocapmSeries::cumsum(self : FinanceportfoliocapmSeries) -> FinanceportfoliocapmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfoliocapmSeries::to_string(self : FinanceportfoliocapmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliocapmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_capm_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliocapmMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn finance_portfolio_capm_matrix_identity(n : Int) -> FinanceportfoliocapmMatrix {
  let m = finance_portfolio_capm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfoliocapmMatrix::get(self : FinanceportfoliocapmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfoliocapmMatrix::transpose(self : FinanceportfoliocapmMatrix) -> FinanceportfoliocapmMatrix {
  let result = finance_portfolio_capm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfoliocapmMatrix::add(self : FinanceportfoliocapmMatrix, other : FinanceportfoliocapmMatrix) -> FinanceportfoliocapmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_capm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfoliocapmMatrix::scale(self : FinanceportfoliocapmMatrix, s : Double) -> FinanceportfoliocapmMatrix {
  let result = finance_portfolio_capm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfoliocapmMatrix::multiply(self : FinanceportfoliocapmMatrix, other : FinanceportfoliocapmMatrix) -> FinanceportfoliocapmMatrix {
  if self.cols != other.rows { return finance_portfolio_capm_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_capm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn FinanceportfoliocapmMatrix::trace(self : FinanceportfoliocapmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfoliocapmMatrix::det(self : FinanceportfoliocapmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfoliocapmMatrix::norm(self : FinanceportfoliocapmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfoliocapmMatrix::to_string(self : FinanceportfoliocapmMatrix) -> String {
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

pub(all) struct FinanceportfoliocapmVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_capm_make_vector(comps : Array[Double]) -> FinanceportfoliocapmVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_capm_vector_zero(dim : Int) -> FinanceportfoliocapmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfoliocapmVector::add(self : FinanceportfoliocapmVector, other : FinanceportfoliocapmVector) -> FinanceportfoliocapmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliocapmVector::sub(self : FinanceportfoliocapmVector, other : FinanceportfoliocapmVector) -> FinanceportfoliocapmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliocapmVector::scale(self : FinanceportfoliocapmVector, s : Double) -> FinanceportfoliocapmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfoliocapmVector::dot(self : FinanceportfoliocapmVector, other : FinanceportfoliocapmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfoliocapmVector::norm(self : FinanceportfoliocapmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfoliocapmVector::normalize(self : FinanceportfoliocapmVector) -> FinanceportfoliocapmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliocapmVector::dist(self : FinanceportfoliocapmVector, other : FinanceportfoliocapmVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfoliocapmVector::to_string(self : FinanceportfoliocapmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliocapmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_frame_make(size : Int) -> FinanceportfoliocapmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmFrame::len(self : FinanceportfoliocapmFrame) -> Int { self.size }

pub fn FinanceportfoliocapmFrame::get(self : FinanceportfoliocapmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmFrame::set(self : FinanceportfoliocapmFrame, i : Int, v : Double) -> FinanceportfoliocapmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmFrame::sum(self : FinanceportfoliocapmFrame) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmFrame::mean(self : FinanceportfoliocapmFrame) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmFrame::scale(self : FinanceportfoliocapmFrame, f : Double) -> FinanceportfoliocapmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmFrame::add(self : FinanceportfoliocapmFrame, other : FinanceportfoliocapmFrame) -> FinanceportfoliocapmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmFrame::copy(self : FinanceportfoliocapmFrame) -> FinanceportfoliocapmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmFrame::fill(self : FinanceportfoliocapmFrame, v : Double) -> FinanceportfoliocapmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmFrame::min(self : FinanceportfoliocapmFrame) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmFrame::max(self : FinanceportfoliocapmFrame) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmFrame::to_string(self : FinanceportfoliocapmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_table_make(size : Int) -> FinanceportfoliocapmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmTable::len(self : FinanceportfoliocapmTable) -> Int { self.size }

pub fn FinanceportfoliocapmTable::get(self : FinanceportfoliocapmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmTable::set(self : FinanceportfoliocapmTable, i : Int, v : Double) -> FinanceportfoliocapmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmTable::sum(self : FinanceportfoliocapmTable) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmTable::mean(self : FinanceportfoliocapmTable) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmTable::scale(self : FinanceportfoliocapmTable, f : Double) -> FinanceportfoliocapmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmTable::add(self : FinanceportfoliocapmTable, other : FinanceportfoliocapmTable) -> FinanceportfoliocapmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmTable::copy(self : FinanceportfoliocapmTable) -> FinanceportfoliocapmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmTable::fill(self : FinanceportfoliocapmTable, v : Double) -> FinanceportfoliocapmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmTable::min(self : FinanceportfoliocapmTable) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmTable::max(self : FinanceportfoliocapmTable) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmTable::to_string(self : FinanceportfoliocapmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_graphn_make(size : Int) -> FinanceportfoliocapmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmGraphN::len(self : FinanceportfoliocapmGraphN) -> Int { self.size }

pub fn FinanceportfoliocapmGraphN::get(self : FinanceportfoliocapmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmGraphN::set(self : FinanceportfoliocapmGraphN, i : Int, v : Double) -> FinanceportfoliocapmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmGraphN::sum(self : FinanceportfoliocapmGraphN) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmGraphN::mean(self : FinanceportfoliocapmGraphN) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmGraphN::scale(self : FinanceportfoliocapmGraphN, f : Double) -> FinanceportfoliocapmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmGraphN::add(self : FinanceportfoliocapmGraphN, other : FinanceportfoliocapmGraphN) -> FinanceportfoliocapmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmGraphN::copy(self : FinanceportfoliocapmGraphN) -> FinanceportfoliocapmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmGraphN::fill(self : FinanceportfoliocapmGraphN, v : Double) -> FinanceportfoliocapmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmGraphN::min(self : FinanceportfoliocapmGraphN) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmGraphN::max(self : FinanceportfoliocapmGraphN) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmGraphN::to_string(self : FinanceportfoliocapmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_node_make(size : Int) -> FinanceportfoliocapmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmNode::len(self : FinanceportfoliocapmNode) -> Int { self.size }

pub fn FinanceportfoliocapmNode::get(self : FinanceportfoliocapmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmNode::set(self : FinanceportfoliocapmNode, i : Int, v : Double) -> FinanceportfoliocapmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmNode::sum(self : FinanceportfoliocapmNode) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmNode::mean(self : FinanceportfoliocapmNode) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmNode::scale(self : FinanceportfoliocapmNode, f : Double) -> FinanceportfoliocapmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmNode::add(self : FinanceportfoliocapmNode, other : FinanceportfoliocapmNode) -> FinanceportfoliocapmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmNode::copy(self : FinanceportfoliocapmNode) -> FinanceportfoliocapmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmNode::fill(self : FinanceportfoliocapmNode, v : Double) -> FinanceportfoliocapmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmNode::min(self : FinanceportfoliocapmNode) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmNode::max(self : FinanceportfoliocapmNode) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmNode::to_string(self : FinanceportfoliocapmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_edge_make(size : Int) -> FinanceportfoliocapmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmEdge::len(self : FinanceportfoliocapmEdge) -> Int { self.size }

pub fn FinanceportfoliocapmEdge::get(self : FinanceportfoliocapmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmEdge::set(self : FinanceportfoliocapmEdge, i : Int, v : Double) -> FinanceportfoliocapmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmEdge::sum(self : FinanceportfoliocapmEdge) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmEdge::mean(self : FinanceportfoliocapmEdge) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmEdge::scale(self : FinanceportfoliocapmEdge, f : Double) -> FinanceportfoliocapmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmEdge::add(self : FinanceportfoliocapmEdge, other : FinanceportfoliocapmEdge) -> FinanceportfoliocapmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmEdge::copy(self : FinanceportfoliocapmEdge) -> FinanceportfoliocapmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmEdge::fill(self : FinanceportfoliocapmEdge, v : Double) -> FinanceportfoliocapmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmEdge::min(self : FinanceportfoliocapmEdge) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmEdge::max(self : FinanceportfoliocapmEdge) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmEdge::to_string(self : FinanceportfoliocapmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_path_make(size : Int) -> FinanceportfoliocapmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmPath::len(self : FinanceportfoliocapmPath) -> Int { self.size }

pub fn FinanceportfoliocapmPath::get(self : FinanceportfoliocapmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmPath::set(self : FinanceportfoliocapmPath, i : Int, v : Double) -> FinanceportfoliocapmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmPath::sum(self : FinanceportfoliocapmPath) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmPath::mean(self : FinanceportfoliocapmPath) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmPath::scale(self : FinanceportfoliocapmPath, f : Double) -> FinanceportfoliocapmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmPath::add(self : FinanceportfoliocapmPath, other : FinanceportfoliocapmPath) -> FinanceportfoliocapmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmPath::copy(self : FinanceportfoliocapmPath) -> FinanceportfoliocapmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmPath::fill(self : FinanceportfoliocapmPath, v : Double) -> FinanceportfoliocapmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmPath::min(self : FinanceportfoliocapmPath) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmPath::max(self : FinanceportfoliocapmPath) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmPath::to_string(self : FinanceportfoliocapmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_cluster_make(size : Int) -> FinanceportfoliocapmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmCluster::len(self : FinanceportfoliocapmCluster) -> Int { self.size }

pub fn FinanceportfoliocapmCluster::get(self : FinanceportfoliocapmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmCluster::set(self : FinanceportfoliocapmCluster, i : Int, v : Double) -> FinanceportfoliocapmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmCluster::sum(self : FinanceportfoliocapmCluster) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmCluster::mean(self : FinanceportfoliocapmCluster) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmCluster::scale(self : FinanceportfoliocapmCluster, f : Double) -> FinanceportfoliocapmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmCluster::add(self : FinanceportfoliocapmCluster, other : FinanceportfoliocapmCluster) -> FinanceportfoliocapmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmCluster::copy(self : FinanceportfoliocapmCluster) -> FinanceportfoliocapmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmCluster::fill(self : FinanceportfoliocapmCluster, v : Double) -> FinanceportfoliocapmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmCluster::min(self : FinanceportfoliocapmCluster) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmCluster::max(self : FinanceportfoliocapmCluster) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmCluster::to_string(self : FinanceportfoliocapmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_model_make(size : Int) -> FinanceportfoliocapmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmModel::len(self : FinanceportfoliocapmModel) -> Int { self.size }

pub fn FinanceportfoliocapmModel::get(self : FinanceportfoliocapmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmModel::set(self : FinanceportfoliocapmModel, i : Int, v : Double) -> FinanceportfoliocapmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmModel::sum(self : FinanceportfoliocapmModel) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmModel::mean(self : FinanceportfoliocapmModel) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmModel::scale(self : FinanceportfoliocapmModel, f : Double) -> FinanceportfoliocapmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmModel::add(self : FinanceportfoliocapmModel, other : FinanceportfoliocapmModel) -> FinanceportfoliocapmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmModel::copy(self : FinanceportfoliocapmModel) -> FinanceportfoliocapmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmModel::fill(self : FinanceportfoliocapmModel, v : Double) -> FinanceportfoliocapmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmModel::min(self : FinanceportfoliocapmModel) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmModel::max(self : FinanceportfoliocapmModel) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmModel::to_string(self : FinanceportfoliocapmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_layer_make(size : Int) -> FinanceportfoliocapmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmLayer::len(self : FinanceportfoliocapmLayer) -> Int { self.size }

pub fn FinanceportfoliocapmLayer::get(self : FinanceportfoliocapmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmLayer::set(self : FinanceportfoliocapmLayer, i : Int, v : Double) -> FinanceportfoliocapmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmLayer::sum(self : FinanceportfoliocapmLayer) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmLayer::mean(self : FinanceportfoliocapmLayer) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmLayer::scale(self : FinanceportfoliocapmLayer, f : Double) -> FinanceportfoliocapmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmLayer::add(self : FinanceportfoliocapmLayer, other : FinanceportfoliocapmLayer) -> FinanceportfoliocapmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmLayer::copy(self : FinanceportfoliocapmLayer) -> FinanceportfoliocapmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmLayer::fill(self : FinanceportfoliocapmLayer, v : Double) -> FinanceportfoliocapmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmLayer::min(self : FinanceportfoliocapmLayer) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmLayer::max(self : FinanceportfoliocapmLayer) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmLayer::to_string(self : FinanceportfoliocapmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_buffer_make(size : Int) -> FinanceportfoliocapmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmBuffer::len(self : FinanceportfoliocapmBuffer) -> Int { self.size }

pub fn FinanceportfoliocapmBuffer::get(self : FinanceportfoliocapmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmBuffer::set(self : FinanceportfoliocapmBuffer, i : Int, v : Double) -> FinanceportfoliocapmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmBuffer::sum(self : FinanceportfoliocapmBuffer) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmBuffer::mean(self : FinanceportfoliocapmBuffer) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmBuffer::scale(self : FinanceportfoliocapmBuffer, f : Double) -> FinanceportfoliocapmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmBuffer::add(self : FinanceportfoliocapmBuffer, other : FinanceportfoliocapmBuffer) -> FinanceportfoliocapmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmBuffer::copy(self : FinanceportfoliocapmBuffer) -> FinanceportfoliocapmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmBuffer::fill(self : FinanceportfoliocapmBuffer, v : Double) -> FinanceportfoliocapmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmBuffer::min(self : FinanceportfoliocapmBuffer) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmBuffer::max(self : FinanceportfoliocapmBuffer) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmBuffer::to_string(self : FinanceportfoliocapmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_cursor_make(size : Int) -> FinanceportfoliocapmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmCursor::len(self : FinanceportfoliocapmCursor) -> Int { self.size }

pub fn FinanceportfoliocapmCursor::get(self : FinanceportfoliocapmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmCursor::set(self : FinanceportfoliocapmCursor, i : Int, v : Double) -> FinanceportfoliocapmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmCursor::sum(self : FinanceportfoliocapmCursor) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmCursor::mean(self : FinanceportfoliocapmCursor) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmCursor::scale(self : FinanceportfoliocapmCursor, f : Double) -> FinanceportfoliocapmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmCursor::add(self : FinanceportfoliocapmCursor, other : FinanceportfoliocapmCursor) -> FinanceportfoliocapmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmCursor::copy(self : FinanceportfoliocapmCursor) -> FinanceportfoliocapmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmCursor::fill(self : FinanceportfoliocapmCursor, v : Double) -> FinanceportfoliocapmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmCursor::min(self : FinanceportfoliocapmCursor) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmCursor::max(self : FinanceportfoliocapmCursor) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmCursor::to_string(self : FinanceportfoliocapmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_view_make(size : Int) -> FinanceportfoliocapmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmView::len(self : FinanceportfoliocapmView) -> Int { self.size }

pub fn FinanceportfoliocapmView::get(self : FinanceportfoliocapmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmView::set(self : FinanceportfoliocapmView, i : Int, v : Double) -> FinanceportfoliocapmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmView::sum(self : FinanceportfoliocapmView) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmView::mean(self : FinanceportfoliocapmView) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmView::scale(self : FinanceportfoliocapmView, f : Double) -> FinanceportfoliocapmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmView::add(self : FinanceportfoliocapmView, other : FinanceportfoliocapmView) -> FinanceportfoliocapmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmView::copy(self : FinanceportfoliocapmView) -> FinanceportfoliocapmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmView::fill(self : FinanceportfoliocapmView, v : Double) -> FinanceportfoliocapmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmView::min(self : FinanceportfoliocapmView) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmView::max(self : FinanceportfoliocapmView) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmView::to_string(self : FinanceportfoliocapmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_range_make(size : Int) -> FinanceportfoliocapmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmRange::len(self : FinanceportfoliocapmRange) -> Int { self.size }

pub fn FinanceportfoliocapmRange::get(self : FinanceportfoliocapmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmRange::set(self : FinanceportfoliocapmRange, i : Int, v : Double) -> FinanceportfoliocapmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmRange::sum(self : FinanceportfoliocapmRange) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmRange::mean(self : FinanceportfoliocapmRange) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmRange::scale(self : FinanceportfoliocapmRange, f : Double) -> FinanceportfoliocapmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmRange::add(self : FinanceportfoliocapmRange, other : FinanceportfoliocapmRange) -> FinanceportfoliocapmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmRange::copy(self : FinanceportfoliocapmRange) -> FinanceportfoliocapmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmRange::fill(self : FinanceportfoliocapmRange, v : Double) -> FinanceportfoliocapmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmRange::min(self : FinanceportfoliocapmRange) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmRange::max(self : FinanceportfoliocapmRange) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmRange::to_string(self : FinanceportfoliocapmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_slice_make(size : Int) -> FinanceportfoliocapmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliocapmSlice::len(self : FinanceportfoliocapmSlice) -> Int { self.size }

pub fn FinanceportfoliocapmSlice::get(self : FinanceportfoliocapmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliocapmSlice::set(self : FinanceportfoliocapmSlice, i : Int, v : Double) -> FinanceportfoliocapmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmSlice::sum(self : FinanceportfoliocapmSlice) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliocapmSlice::mean(self : FinanceportfoliocapmSlice) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliocapmSlice::scale(self : FinanceportfoliocapmSlice, f : Double) -> FinanceportfoliocapmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmSlice::add(self : FinanceportfoliocapmSlice, other : FinanceportfoliocapmSlice) -> FinanceportfoliocapmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliocapmSlice::copy(self : FinanceportfoliocapmSlice) -> FinanceportfoliocapmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmSlice::fill(self : FinanceportfoliocapmSlice, v : Double) -> FinanceportfoliocapmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliocapmSlice::min(self : FinanceportfoliocapmSlice) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliocapmSlice::max(self : FinanceportfoliocapmSlice) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliocapmSlice::to_string(self : FinanceportfoliocapmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

