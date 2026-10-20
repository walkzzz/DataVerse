///===
/// extcore/finance_portfolio_markowitz

pub(all) struct FinanceportfoliomarkowitzPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_markowitz_make_point(x : Double, y : Double) -> FinanceportfoliomarkowitzPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_markowitz_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliomarkowitzPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfoliomarkowitzPoint::x(self : FinanceportfoliomarkowitzPoint) -> Double { self.x }

pub fn FinanceportfoliomarkowitzPoint::y(self : FinanceportfoliomarkowitzPoint) -> Double { self.y }

pub fn FinanceportfoliomarkowitzPoint::z(self : FinanceportfoliomarkowitzPoint) -> Double { self.z }

pub fn FinanceportfoliomarkowitzPoint::label(self : FinanceportfoliomarkowitzPoint) -> Int { self.label }

pub fn FinanceportfoliomarkowitzPoint::dist(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfoliomarkowitzPoint::add(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::sub(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::scale(self : FinanceportfoliomarkowitzPoint, s : Double) -> FinanceportfoliomarkowitzPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::dot(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfoliomarkowitzPoint::cross(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfoliomarkowitzPoint::norm(self : FinanceportfoliomarkowitzPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfoliomarkowitzPoint::normalize(self : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliomarkowitzPoint::negate(self : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::mid(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::lerp(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint, t : Double) -> FinanceportfoliomarkowitzPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::to_string(self : FinanceportfoliomarkowitzPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_markowitz_make_series(vals : Array[Double], name : String) -> FinanceportfoliomarkowitzSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfoliomarkowitzSeries::len(self : FinanceportfoliomarkowitzSeries) -> Int { self.vals.length() }

pub fn FinanceportfoliomarkowitzSeries::sum(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::mean(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::min(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::max(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::range(self : FinanceportfoliomarkowitzSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfoliomarkowitzSeries::variance(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::std(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::median(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::scale(self : FinanceportfoliomarkowitzSeries, f : Double) -> FinanceportfoliomarkowitzSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfoliomarkowitzSeries::add(self : FinanceportfoliomarkowitzSeries, other : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfoliomarkowitzSeries::sub(self : FinanceportfoliomarkowitzSeries, other : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfoliomarkowitzSeries::normalize(self : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfoliomarkowitzSeries::cumsum(self : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfoliomarkowitzSeries::to_string(self : FinanceportfoliomarkowitzSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliomarkowitzMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_markowitz_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliomarkowitzMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn finance_portfolio_markowitz_matrix_identity(n : Int) -> FinanceportfoliomarkowitzMatrix {
  let m = finance_portfolio_markowitz_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfoliomarkowitzMatrix::get(self : FinanceportfoliomarkowitzMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfoliomarkowitzMatrix::transpose(self : FinanceportfoliomarkowitzMatrix) -> FinanceportfoliomarkowitzMatrix {
  let result = finance_portfolio_markowitz_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfoliomarkowitzMatrix::add(self : FinanceportfoliomarkowitzMatrix, other : FinanceportfoliomarkowitzMatrix) -> FinanceportfoliomarkowitzMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_markowitz_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfoliomarkowitzMatrix::scale(self : FinanceportfoliomarkowitzMatrix, s : Double) -> FinanceportfoliomarkowitzMatrix {
  let result = finance_portfolio_markowitz_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfoliomarkowitzMatrix::multiply(self : FinanceportfoliomarkowitzMatrix, other : FinanceportfoliomarkowitzMatrix) -> FinanceportfoliomarkowitzMatrix {
  if self.cols != other.rows { return finance_portfolio_markowitz_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_markowitz_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn FinanceportfoliomarkowitzMatrix::trace(self : FinanceportfoliomarkowitzMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfoliomarkowitzMatrix::det(self : FinanceportfoliomarkowitzMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfoliomarkowitzMatrix::norm(self : FinanceportfoliomarkowitzMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfoliomarkowitzMatrix::to_string(self : FinanceportfoliomarkowitzMatrix) -> String {
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

pub(all) struct FinanceportfoliomarkowitzVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_markowitz_make_vector(comps : Array[Double]) -> FinanceportfoliomarkowitzVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_markowitz_vector_zero(dim : Int) -> FinanceportfoliomarkowitzVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfoliomarkowitzVector::add(self : FinanceportfoliomarkowitzVector, other : FinanceportfoliomarkowitzVector) -> FinanceportfoliomarkowitzVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliomarkowitzVector::sub(self : FinanceportfoliomarkowitzVector, other : FinanceportfoliomarkowitzVector) -> FinanceportfoliomarkowitzVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliomarkowitzVector::scale(self : FinanceportfoliomarkowitzVector, s : Double) -> FinanceportfoliomarkowitzVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfoliomarkowitzVector::dot(self : FinanceportfoliomarkowitzVector, other : FinanceportfoliomarkowitzVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfoliomarkowitzVector::norm(self : FinanceportfoliomarkowitzVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfoliomarkowitzVector::normalize(self : FinanceportfoliomarkowitzVector) -> FinanceportfoliomarkowitzVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliomarkowitzVector::dist(self : FinanceportfoliomarkowitzVector, other : FinanceportfoliomarkowitzVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfoliomarkowitzVector::to_string(self : FinanceportfoliomarkowitzVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliomarkowitzFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_frame_make(size : Int) -> FinanceportfoliomarkowitzFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzFrame::len(self : FinanceportfoliomarkowitzFrame) -> Int { self.size }

pub fn FinanceportfoliomarkowitzFrame::get(self : FinanceportfoliomarkowitzFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzFrame::set(self : FinanceportfoliomarkowitzFrame, i : Int, v : Double) -> FinanceportfoliomarkowitzFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzFrame::sum(self : FinanceportfoliomarkowitzFrame) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzFrame::mean(self : FinanceportfoliomarkowitzFrame) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzFrame::scale(self : FinanceportfoliomarkowitzFrame, f : Double) -> FinanceportfoliomarkowitzFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzFrame::add(self : FinanceportfoliomarkowitzFrame, other : FinanceportfoliomarkowitzFrame) -> FinanceportfoliomarkowitzFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzFrame::copy(self : FinanceportfoliomarkowitzFrame) -> FinanceportfoliomarkowitzFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzFrame::fill(self : FinanceportfoliomarkowitzFrame, v : Double) -> FinanceportfoliomarkowitzFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzFrame::min(self : FinanceportfoliomarkowitzFrame) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzFrame::max(self : FinanceportfoliomarkowitzFrame) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzFrame::to_string(self : FinanceportfoliomarkowitzFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_table_make(size : Int) -> FinanceportfoliomarkowitzTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzTable::len(self : FinanceportfoliomarkowitzTable) -> Int { self.size }

pub fn FinanceportfoliomarkowitzTable::get(self : FinanceportfoliomarkowitzTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzTable::set(self : FinanceportfoliomarkowitzTable, i : Int, v : Double) -> FinanceportfoliomarkowitzTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzTable::sum(self : FinanceportfoliomarkowitzTable) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzTable::mean(self : FinanceportfoliomarkowitzTable) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzTable::scale(self : FinanceportfoliomarkowitzTable, f : Double) -> FinanceportfoliomarkowitzTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzTable::add(self : FinanceportfoliomarkowitzTable, other : FinanceportfoliomarkowitzTable) -> FinanceportfoliomarkowitzTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzTable::copy(self : FinanceportfoliomarkowitzTable) -> FinanceportfoliomarkowitzTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzTable::fill(self : FinanceportfoliomarkowitzTable, v : Double) -> FinanceportfoliomarkowitzTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzTable::min(self : FinanceportfoliomarkowitzTable) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzTable::max(self : FinanceportfoliomarkowitzTable) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzTable::to_string(self : FinanceportfoliomarkowitzTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_graphn_make(size : Int) -> FinanceportfoliomarkowitzGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzGraphN::len(self : FinanceportfoliomarkowitzGraphN) -> Int { self.size }

pub fn FinanceportfoliomarkowitzGraphN::get(self : FinanceportfoliomarkowitzGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzGraphN::set(self : FinanceportfoliomarkowitzGraphN, i : Int, v : Double) -> FinanceportfoliomarkowitzGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzGraphN::sum(self : FinanceportfoliomarkowitzGraphN) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzGraphN::mean(self : FinanceportfoliomarkowitzGraphN) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzGraphN::scale(self : FinanceportfoliomarkowitzGraphN, f : Double) -> FinanceportfoliomarkowitzGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzGraphN::add(self : FinanceportfoliomarkowitzGraphN, other : FinanceportfoliomarkowitzGraphN) -> FinanceportfoliomarkowitzGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzGraphN::copy(self : FinanceportfoliomarkowitzGraphN) -> FinanceportfoliomarkowitzGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzGraphN::fill(self : FinanceportfoliomarkowitzGraphN, v : Double) -> FinanceportfoliomarkowitzGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzGraphN::min(self : FinanceportfoliomarkowitzGraphN) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzGraphN::max(self : FinanceportfoliomarkowitzGraphN) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzGraphN::to_string(self : FinanceportfoliomarkowitzGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_node_make(size : Int) -> FinanceportfoliomarkowitzNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzNode::len(self : FinanceportfoliomarkowitzNode) -> Int { self.size }

pub fn FinanceportfoliomarkowitzNode::get(self : FinanceportfoliomarkowitzNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzNode::set(self : FinanceportfoliomarkowitzNode, i : Int, v : Double) -> FinanceportfoliomarkowitzNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzNode::sum(self : FinanceportfoliomarkowitzNode) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzNode::mean(self : FinanceportfoliomarkowitzNode) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzNode::scale(self : FinanceportfoliomarkowitzNode, f : Double) -> FinanceportfoliomarkowitzNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzNode::add(self : FinanceportfoliomarkowitzNode, other : FinanceportfoliomarkowitzNode) -> FinanceportfoliomarkowitzNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzNode::copy(self : FinanceportfoliomarkowitzNode) -> FinanceportfoliomarkowitzNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzNode::fill(self : FinanceportfoliomarkowitzNode, v : Double) -> FinanceportfoliomarkowitzNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzNode::min(self : FinanceportfoliomarkowitzNode) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzNode::max(self : FinanceportfoliomarkowitzNode) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzNode::to_string(self : FinanceportfoliomarkowitzNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_edge_make(size : Int) -> FinanceportfoliomarkowitzEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzEdge::len(self : FinanceportfoliomarkowitzEdge) -> Int { self.size }

pub fn FinanceportfoliomarkowitzEdge::get(self : FinanceportfoliomarkowitzEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzEdge::set(self : FinanceportfoliomarkowitzEdge, i : Int, v : Double) -> FinanceportfoliomarkowitzEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzEdge::sum(self : FinanceportfoliomarkowitzEdge) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzEdge::mean(self : FinanceportfoliomarkowitzEdge) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzEdge::scale(self : FinanceportfoliomarkowitzEdge, f : Double) -> FinanceportfoliomarkowitzEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzEdge::add(self : FinanceportfoliomarkowitzEdge, other : FinanceportfoliomarkowitzEdge) -> FinanceportfoliomarkowitzEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzEdge::copy(self : FinanceportfoliomarkowitzEdge) -> FinanceportfoliomarkowitzEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzEdge::fill(self : FinanceportfoliomarkowitzEdge, v : Double) -> FinanceportfoliomarkowitzEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzEdge::min(self : FinanceportfoliomarkowitzEdge) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzEdge::max(self : FinanceportfoliomarkowitzEdge) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzEdge::to_string(self : FinanceportfoliomarkowitzEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_path_make(size : Int) -> FinanceportfoliomarkowitzPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzPath::len(self : FinanceportfoliomarkowitzPath) -> Int { self.size }

pub fn FinanceportfoliomarkowitzPath::get(self : FinanceportfoliomarkowitzPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzPath::set(self : FinanceportfoliomarkowitzPath, i : Int, v : Double) -> FinanceportfoliomarkowitzPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzPath::sum(self : FinanceportfoliomarkowitzPath) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzPath::mean(self : FinanceportfoliomarkowitzPath) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzPath::scale(self : FinanceportfoliomarkowitzPath, f : Double) -> FinanceportfoliomarkowitzPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzPath::add(self : FinanceportfoliomarkowitzPath, other : FinanceportfoliomarkowitzPath) -> FinanceportfoliomarkowitzPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzPath::copy(self : FinanceportfoliomarkowitzPath) -> FinanceportfoliomarkowitzPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzPath::fill(self : FinanceportfoliomarkowitzPath, v : Double) -> FinanceportfoliomarkowitzPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzPath::min(self : FinanceportfoliomarkowitzPath) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzPath::max(self : FinanceportfoliomarkowitzPath) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzPath::to_string(self : FinanceportfoliomarkowitzPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_cluster_make(size : Int) -> FinanceportfoliomarkowitzCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzCluster::len(self : FinanceportfoliomarkowitzCluster) -> Int { self.size }

pub fn FinanceportfoliomarkowitzCluster::get(self : FinanceportfoliomarkowitzCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzCluster::set(self : FinanceportfoliomarkowitzCluster, i : Int, v : Double) -> FinanceportfoliomarkowitzCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzCluster::sum(self : FinanceportfoliomarkowitzCluster) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzCluster::mean(self : FinanceportfoliomarkowitzCluster) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzCluster::scale(self : FinanceportfoliomarkowitzCluster, f : Double) -> FinanceportfoliomarkowitzCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzCluster::add(self : FinanceportfoliomarkowitzCluster, other : FinanceportfoliomarkowitzCluster) -> FinanceportfoliomarkowitzCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzCluster::copy(self : FinanceportfoliomarkowitzCluster) -> FinanceportfoliomarkowitzCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzCluster::fill(self : FinanceportfoliomarkowitzCluster, v : Double) -> FinanceportfoliomarkowitzCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzCluster::min(self : FinanceportfoliomarkowitzCluster) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzCluster::max(self : FinanceportfoliomarkowitzCluster) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzCluster::to_string(self : FinanceportfoliomarkowitzCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_model_make(size : Int) -> FinanceportfoliomarkowitzModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzModel::len(self : FinanceportfoliomarkowitzModel) -> Int { self.size }

pub fn FinanceportfoliomarkowitzModel::get(self : FinanceportfoliomarkowitzModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzModel::set(self : FinanceportfoliomarkowitzModel, i : Int, v : Double) -> FinanceportfoliomarkowitzModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzModel::sum(self : FinanceportfoliomarkowitzModel) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzModel::mean(self : FinanceportfoliomarkowitzModel) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzModel::scale(self : FinanceportfoliomarkowitzModel, f : Double) -> FinanceportfoliomarkowitzModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzModel::add(self : FinanceportfoliomarkowitzModel, other : FinanceportfoliomarkowitzModel) -> FinanceportfoliomarkowitzModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzModel::copy(self : FinanceportfoliomarkowitzModel) -> FinanceportfoliomarkowitzModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzModel::fill(self : FinanceportfoliomarkowitzModel, v : Double) -> FinanceportfoliomarkowitzModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzModel::min(self : FinanceportfoliomarkowitzModel) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzModel::max(self : FinanceportfoliomarkowitzModel) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzModel::to_string(self : FinanceportfoliomarkowitzModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_layer_make(size : Int) -> FinanceportfoliomarkowitzLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzLayer::len(self : FinanceportfoliomarkowitzLayer) -> Int { self.size }

pub fn FinanceportfoliomarkowitzLayer::get(self : FinanceportfoliomarkowitzLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzLayer::set(self : FinanceportfoliomarkowitzLayer, i : Int, v : Double) -> FinanceportfoliomarkowitzLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzLayer::sum(self : FinanceportfoliomarkowitzLayer) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzLayer::mean(self : FinanceportfoliomarkowitzLayer) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzLayer::scale(self : FinanceportfoliomarkowitzLayer, f : Double) -> FinanceportfoliomarkowitzLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzLayer::add(self : FinanceportfoliomarkowitzLayer, other : FinanceportfoliomarkowitzLayer) -> FinanceportfoliomarkowitzLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzLayer::copy(self : FinanceportfoliomarkowitzLayer) -> FinanceportfoliomarkowitzLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzLayer::fill(self : FinanceportfoliomarkowitzLayer, v : Double) -> FinanceportfoliomarkowitzLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzLayer::min(self : FinanceportfoliomarkowitzLayer) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzLayer::max(self : FinanceportfoliomarkowitzLayer) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzLayer::to_string(self : FinanceportfoliomarkowitzLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_buffer_make(size : Int) -> FinanceportfoliomarkowitzBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzBuffer::len(self : FinanceportfoliomarkowitzBuffer) -> Int { self.size }

pub fn FinanceportfoliomarkowitzBuffer::get(self : FinanceportfoliomarkowitzBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzBuffer::set(self : FinanceportfoliomarkowitzBuffer, i : Int, v : Double) -> FinanceportfoliomarkowitzBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzBuffer::sum(self : FinanceportfoliomarkowitzBuffer) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzBuffer::mean(self : FinanceportfoliomarkowitzBuffer) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzBuffer::scale(self : FinanceportfoliomarkowitzBuffer, f : Double) -> FinanceportfoliomarkowitzBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzBuffer::add(self : FinanceportfoliomarkowitzBuffer, other : FinanceportfoliomarkowitzBuffer) -> FinanceportfoliomarkowitzBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzBuffer::copy(self : FinanceportfoliomarkowitzBuffer) -> FinanceportfoliomarkowitzBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzBuffer::fill(self : FinanceportfoliomarkowitzBuffer, v : Double) -> FinanceportfoliomarkowitzBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzBuffer::min(self : FinanceportfoliomarkowitzBuffer) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzBuffer::max(self : FinanceportfoliomarkowitzBuffer) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzBuffer::to_string(self : FinanceportfoliomarkowitzBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_cursor_make(size : Int) -> FinanceportfoliomarkowitzCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzCursor::len(self : FinanceportfoliomarkowitzCursor) -> Int { self.size }

pub fn FinanceportfoliomarkowitzCursor::get(self : FinanceportfoliomarkowitzCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzCursor::set(self : FinanceportfoliomarkowitzCursor, i : Int, v : Double) -> FinanceportfoliomarkowitzCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzCursor::sum(self : FinanceportfoliomarkowitzCursor) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzCursor::mean(self : FinanceportfoliomarkowitzCursor) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzCursor::scale(self : FinanceportfoliomarkowitzCursor, f : Double) -> FinanceportfoliomarkowitzCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzCursor::add(self : FinanceportfoliomarkowitzCursor, other : FinanceportfoliomarkowitzCursor) -> FinanceportfoliomarkowitzCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzCursor::copy(self : FinanceportfoliomarkowitzCursor) -> FinanceportfoliomarkowitzCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzCursor::fill(self : FinanceportfoliomarkowitzCursor, v : Double) -> FinanceportfoliomarkowitzCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzCursor::min(self : FinanceportfoliomarkowitzCursor) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzCursor::max(self : FinanceportfoliomarkowitzCursor) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzCursor::to_string(self : FinanceportfoliomarkowitzCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_view_make(size : Int) -> FinanceportfoliomarkowitzView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzView::len(self : FinanceportfoliomarkowitzView) -> Int { self.size }

pub fn FinanceportfoliomarkowitzView::get(self : FinanceportfoliomarkowitzView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzView::set(self : FinanceportfoliomarkowitzView, i : Int, v : Double) -> FinanceportfoliomarkowitzView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzView::sum(self : FinanceportfoliomarkowitzView) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzView::mean(self : FinanceportfoliomarkowitzView) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzView::scale(self : FinanceportfoliomarkowitzView, f : Double) -> FinanceportfoliomarkowitzView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzView::add(self : FinanceportfoliomarkowitzView, other : FinanceportfoliomarkowitzView) -> FinanceportfoliomarkowitzView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzView::copy(self : FinanceportfoliomarkowitzView) -> FinanceportfoliomarkowitzView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzView::fill(self : FinanceportfoliomarkowitzView, v : Double) -> FinanceportfoliomarkowitzView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzView::min(self : FinanceportfoliomarkowitzView) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzView::max(self : FinanceportfoliomarkowitzView) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzView::to_string(self : FinanceportfoliomarkowitzView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_range_make(size : Int) -> FinanceportfoliomarkowitzRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzRange::len(self : FinanceportfoliomarkowitzRange) -> Int { self.size }

pub fn FinanceportfoliomarkowitzRange::get(self : FinanceportfoliomarkowitzRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzRange::set(self : FinanceportfoliomarkowitzRange, i : Int, v : Double) -> FinanceportfoliomarkowitzRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzRange::sum(self : FinanceportfoliomarkowitzRange) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzRange::mean(self : FinanceportfoliomarkowitzRange) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzRange::scale(self : FinanceportfoliomarkowitzRange, f : Double) -> FinanceportfoliomarkowitzRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzRange::add(self : FinanceportfoliomarkowitzRange, other : FinanceportfoliomarkowitzRange) -> FinanceportfoliomarkowitzRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzRange::copy(self : FinanceportfoliomarkowitzRange) -> FinanceportfoliomarkowitzRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzRange::fill(self : FinanceportfoliomarkowitzRange, v : Double) -> FinanceportfoliomarkowitzRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzRange::min(self : FinanceportfoliomarkowitzRange) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzRange::max(self : FinanceportfoliomarkowitzRange) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzRange::to_string(self : FinanceportfoliomarkowitzRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_slice_make(size : Int) -> FinanceportfoliomarkowitzSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliomarkowitzSlice::len(self : FinanceportfoliomarkowitzSlice) -> Int { self.size }

pub fn FinanceportfoliomarkowitzSlice::get(self : FinanceportfoliomarkowitzSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliomarkowitzSlice::set(self : FinanceportfoliomarkowitzSlice, i : Int, v : Double) -> FinanceportfoliomarkowitzSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzSlice::sum(self : FinanceportfoliomarkowitzSlice) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliomarkowitzSlice::mean(self : FinanceportfoliomarkowitzSlice) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliomarkowitzSlice::scale(self : FinanceportfoliomarkowitzSlice, f : Double) -> FinanceportfoliomarkowitzSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzSlice::add(self : FinanceportfoliomarkowitzSlice, other : FinanceportfoliomarkowitzSlice) -> FinanceportfoliomarkowitzSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzSlice::copy(self : FinanceportfoliomarkowitzSlice) -> FinanceportfoliomarkowitzSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzSlice::fill(self : FinanceportfoliomarkowitzSlice, v : Double) -> FinanceportfoliomarkowitzSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliomarkowitzSlice::min(self : FinanceportfoliomarkowitzSlice) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliomarkowitzSlice::max(self : FinanceportfoliomarkowitzSlice) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliomarkowitzSlice::to_string(self : FinanceportfoliomarkowitzSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

