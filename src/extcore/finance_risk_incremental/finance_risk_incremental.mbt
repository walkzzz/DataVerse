///===
/// extcore/finance_risk_incremental

pub(all) struct FinanceriskincrementalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_incremental_make_point(x : Double, y : Double) -> FinanceriskincrementalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_incremental_make_point3(x : Double, y : Double, z : Double) -> FinanceriskincrementalPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskincrementalPoint::x(self : FinanceriskincrementalPoint) -> Double { self.x }

pub fn FinanceriskincrementalPoint::y(self : FinanceriskincrementalPoint) -> Double { self.y }

pub fn FinanceriskincrementalPoint::z(self : FinanceriskincrementalPoint) -> Double { self.z }

pub fn FinanceriskincrementalPoint::label(self : FinanceriskincrementalPoint) -> Int { self.label }

pub fn FinanceriskincrementalPoint::dist(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskincrementalPoint::add(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskincrementalPoint::sub(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskincrementalPoint::scale(self : FinanceriskincrementalPoint, s : Double) -> FinanceriskincrementalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskincrementalPoint::dot(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskincrementalPoint::cross(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskincrementalPoint::norm(self : FinanceriskincrementalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskincrementalPoint::normalize(self : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskincrementalPoint::negate(self : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskincrementalPoint::mid(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskincrementalPoint::lerp(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint, t : Double) -> FinanceriskincrementalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskincrementalPoint::to_string(self : FinanceriskincrementalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskincrementalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_incremental_make_series(vals : Array[Double], name : String) -> FinanceriskincrementalSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskincrementalSeries::len(self : FinanceriskincrementalSeries) -> Int { self.vals.length() }

pub fn FinanceriskincrementalSeries::sum(self : FinanceriskincrementalSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskincrementalSeries::mean(self : FinanceriskincrementalSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskincrementalSeries::min(self : FinanceriskincrementalSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskincrementalSeries::max(self : FinanceriskincrementalSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskincrementalSeries::range(self : FinanceriskincrementalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskincrementalSeries::variance(self : FinanceriskincrementalSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskincrementalSeries::std(self : FinanceriskincrementalSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskincrementalSeries::median(self : FinanceriskincrementalSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskincrementalSeries::scale(self : FinanceriskincrementalSeries, f : Double) -> FinanceriskincrementalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskincrementalSeries::add(self : FinanceriskincrementalSeries, other : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskincrementalSeries::sub(self : FinanceriskincrementalSeries, other : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskincrementalSeries::normalize(self : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskincrementalSeries::cumsum(self : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskincrementalSeries::to_string(self : FinanceriskincrementalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskincrementalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_incremental_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskincrementalMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn finance_risk_incremental_matrix_identity(n : Int) -> FinanceriskincrementalMatrix {
  let m = finance_risk_incremental_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskincrementalMatrix::get(self : FinanceriskincrementalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskincrementalMatrix::transpose(self : FinanceriskincrementalMatrix) -> FinanceriskincrementalMatrix {
  let result = finance_risk_incremental_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskincrementalMatrix::add(self : FinanceriskincrementalMatrix, other : FinanceriskincrementalMatrix) -> FinanceriskincrementalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_incremental_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskincrementalMatrix::scale(self : FinanceriskincrementalMatrix, s : Double) -> FinanceriskincrementalMatrix {
  let result = finance_risk_incremental_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskincrementalMatrix::multiply(self : FinanceriskincrementalMatrix, other : FinanceriskincrementalMatrix) -> FinanceriskincrementalMatrix {
  if self.cols != other.rows { return finance_risk_incremental_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_incremental_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn FinanceriskincrementalMatrix::trace(self : FinanceriskincrementalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskincrementalMatrix::det(self : FinanceriskincrementalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskincrementalMatrix::norm(self : FinanceriskincrementalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskincrementalMatrix::to_string(self : FinanceriskincrementalMatrix) -> String {
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

pub(all) struct FinanceriskincrementalVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_incremental_make_vector(comps : Array[Double]) -> FinanceriskincrementalVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_incremental_vector_zero(dim : Int) -> FinanceriskincrementalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskincrementalVector::add(self : FinanceriskincrementalVector, other : FinanceriskincrementalVector) -> FinanceriskincrementalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskincrementalVector::sub(self : FinanceriskincrementalVector, other : FinanceriskincrementalVector) -> FinanceriskincrementalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskincrementalVector::scale(self : FinanceriskincrementalVector, s : Double) -> FinanceriskincrementalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskincrementalVector::dot(self : FinanceriskincrementalVector, other : FinanceriskincrementalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskincrementalVector::norm(self : FinanceriskincrementalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskincrementalVector::normalize(self : FinanceriskincrementalVector) -> FinanceriskincrementalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskincrementalVector::dist(self : FinanceriskincrementalVector, other : FinanceriskincrementalVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskincrementalVector::to_string(self : FinanceriskincrementalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskincrementalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_frame_make(size : Int) -> FinanceriskincrementalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalFrame::len(self : FinanceriskincrementalFrame) -> Int { self.size }

pub fn FinanceriskincrementalFrame::get(self : FinanceriskincrementalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalFrame::set(self : FinanceriskincrementalFrame, i : Int, v : Double) -> FinanceriskincrementalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalFrame::sum(self : FinanceriskincrementalFrame) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalFrame::mean(self : FinanceriskincrementalFrame) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalFrame::scale(self : FinanceriskincrementalFrame, f : Double) -> FinanceriskincrementalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalFrame::add(self : FinanceriskincrementalFrame, other : FinanceriskincrementalFrame) -> FinanceriskincrementalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalFrame::copy(self : FinanceriskincrementalFrame) -> FinanceriskincrementalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalFrame::fill(self : FinanceriskincrementalFrame, v : Double) -> FinanceriskincrementalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalFrame::min(self : FinanceriskincrementalFrame) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalFrame::max(self : FinanceriskincrementalFrame) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalFrame::to_string(self : FinanceriskincrementalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_table_make(size : Int) -> FinanceriskincrementalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalTable::len(self : FinanceriskincrementalTable) -> Int { self.size }

pub fn FinanceriskincrementalTable::get(self : FinanceriskincrementalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalTable::set(self : FinanceriskincrementalTable, i : Int, v : Double) -> FinanceriskincrementalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalTable::sum(self : FinanceriskincrementalTable) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalTable::mean(self : FinanceriskincrementalTable) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalTable::scale(self : FinanceriskincrementalTable, f : Double) -> FinanceriskincrementalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalTable::add(self : FinanceriskincrementalTable, other : FinanceriskincrementalTable) -> FinanceriskincrementalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalTable::copy(self : FinanceriskincrementalTable) -> FinanceriskincrementalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalTable::fill(self : FinanceriskincrementalTable, v : Double) -> FinanceriskincrementalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalTable::min(self : FinanceriskincrementalTable) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalTable::max(self : FinanceriskincrementalTable) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalTable::to_string(self : FinanceriskincrementalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_graphn_make(size : Int) -> FinanceriskincrementalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalGraphN::len(self : FinanceriskincrementalGraphN) -> Int { self.size }

pub fn FinanceriskincrementalGraphN::get(self : FinanceriskincrementalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalGraphN::set(self : FinanceriskincrementalGraphN, i : Int, v : Double) -> FinanceriskincrementalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalGraphN::sum(self : FinanceriskincrementalGraphN) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalGraphN::mean(self : FinanceriskincrementalGraphN) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalGraphN::scale(self : FinanceriskincrementalGraphN, f : Double) -> FinanceriskincrementalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalGraphN::add(self : FinanceriskincrementalGraphN, other : FinanceriskincrementalGraphN) -> FinanceriskincrementalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalGraphN::copy(self : FinanceriskincrementalGraphN) -> FinanceriskincrementalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalGraphN::fill(self : FinanceriskincrementalGraphN, v : Double) -> FinanceriskincrementalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalGraphN::min(self : FinanceriskincrementalGraphN) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalGraphN::max(self : FinanceriskincrementalGraphN) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalGraphN::to_string(self : FinanceriskincrementalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_node_make(size : Int) -> FinanceriskincrementalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalNode::len(self : FinanceriskincrementalNode) -> Int { self.size }

pub fn FinanceriskincrementalNode::get(self : FinanceriskincrementalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalNode::set(self : FinanceriskincrementalNode, i : Int, v : Double) -> FinanceriskincrementalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalNode::sum(self : FinanceriskincrementalNode) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalNode::mean(self : FinanceriskincrementalNode) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalNode::scale(self : FinanceriskincrementalNode, f : Double) -> FinanceriskincrementalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalNode::add(self : FinanceriskincrementalNode, other : FinanceriskincrementalNode) -> FinanceriskincrementalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalNode::copy(self : FinanceriskincrementalNode) -> FinanceriskincrementalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalNode::fill(self : FinanceriskincrementalNode, v : Double) -> FinanceriskincrementalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalNode::min(self : FinanceriskincrementalNode) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalNode::max(self : FinanceriskincrementalNode) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalNode::to_string(self : FinanceriskincrementalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_edge_make(size : Int) -> FinanceriskincrementalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalEdge::len(self : FinanceriskincrementalEdge) -> Int { self.size }

pub fn FinanceriskincrementalEdge::get(self : FinanceriskincrementalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalEdge::set(self : FinanceriskincrementalEdge, i : Int, v : Double) -> FinanceriskincrementalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalEdge::sum(self : FinanceriskincrementalEdge) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalEdge::mean(self : FinanceriskincrementalEdge) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalEdge::scale(self : FinanceriskincrementalEdge, f : Double) -> FinanceriskincrementalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalEdge::add(self : FinanceriskincrementalEdge, other : FinanceriskincrementalEdge) -> FinanceriskincrementalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalEdge::copy(self : FinanceriskincrementalEdge) -> FinanceriskincrementalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalEdge::fill(self : FinanceriskincrementalEdge, v : Double) -> FinanceriskincrementalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalEdge::min(self : FinanceriskincrementalEdge) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalEdge::max(self : FinanceriskincrementalEdge) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalEdge::to_string(self : FinanceriskincrementalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_path_make(size : Int) -> FinanceriskincrementalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalPath::len(self : FinanceriskincrementalPath) -> Int { self.size }

pub fn FinanceriskincrementalPath::get(self : FinanceriskincrementalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalPath::set(self : FinanceriskincrementalPath, i : Int, v : Double) -> FinanceriskincrementalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalPath::sum(self : FinanceriskincrementalPath) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalPath::mean(self : FinanceriskincrementalPath) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalPath::scale(self : FinanceriskincrementalPath, f : Double) -> FinanceriskincrementalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalPath::add(self : FinanceriskincrementalPath, other : FinanceriskincrementalPath) -> FinanceriskincrementalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalPath::copy(self : FinanceriskincrementalPath) -> FinanceriskincrementalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalPath::fill(self : FinanceriskincrementalPath, v : Double) -> FinanceriskincrementalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalPath::min(self : FinanceriskincrementalPath) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalPath::max(self : FinanceriskincrementalPath) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalPath::to_string(self : FinanceriskincrementalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_cluster_make(size : Int) -> FinanceriskincrementalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalCluster::len(self : FinanceriskincrementalCluster) -> Int { self.size }

pub fn FinanceriskincrementalCluster::get(self : FinanceriskincrementalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalCluster::set(self : FinanceriskincrementalCluster, i : Int, v : Double) -> FinanceriskincrementalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalCluster::sum(self : FinanceriskincrementalCluster) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalCluster::mean(self : FinanceriskincrementalCluster) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalCluster::scale(self : FinanceriskincrementalCluster, f : Double) -> FinanceriskincrementalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalCluster::add(self : FinanceriskincrementalCluster, other : FinanceriskincrementalCluster) -> FinanceriskincrementalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalCluster::copy(self : FinanceriskincrementalCluster) -> FinanceriskincrementalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalCluster::fill(self : FinanceriskincrementalCluster, v : Double) -> FinanceriskincrementalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalCluster::min(self : FinanceriskincrementalCluster) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalCluster::max(self : FinanceriskincrementalCluster) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalCluster::to_string(self : FinanceriskincrementalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_model_make(size : Int) -> FinanceriskincrementalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalModel::len(self : FinanceriskincrementalModel) -> Int { self.size }

pub fn FinanceriskincrementalModel::get(self : FinanceriskincrementalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalModel::set(self : FinanceriskincrementalModel, i : Int, v : Double) -> FinanceriskincrementalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalModel::sum(self : FinanceriskincrementalModel) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalModel::mean(self : FinanceriskincrementalModel) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalModel::scale(self : FinanceriskincrementalModel, f : Double) -> FinanceriskincrementalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalModel::add(self : FinanceriskincrementalModel, other : FinanceriskincrementalModel) -> FinanceriskincrementalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalModel::copy(self : FinanceriskincrementalModel) -> FinanceriskincrementalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalModel::fill(self : FinanceriskincrementalModel, v : Double) -> FinanceriskincrementalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalModel::min(self : FinanceriskincrementalModel) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalModel::max(self : FinanceriskincrementalModel) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalModel::to_string(self : FinanceriskincrementalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_layer_make(size : Int) -> FinanceriskincrementalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalLayer::len(self : FinanceriskincrementalLayer) -> Int { self.size }

pub fn FinanceriskincrementalLayer::get(self : FinanceriskincrementalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalLayer::set(self : FinanceriskincrementalLayer, i : Int, v : Double) -> FinanceriskincrementalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalLayer::sum(self : FinanceriskincrementalLayer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalLayer::mean(self : FinanceriskincrementalLayer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalLayer::scale(self : FinanceriskincrementalLayer, f : Double) -> FinanceriskincrementalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalLayer::add(self : FinanceriskincrementalLayer, other : FinanceriskincrementalLayer) -> FinanceriskincrementalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalLayer::copy(self : FinanceriskincrementalLayer) -> FinanceriskincrementalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalLayer::fill(self : FinanceriskincrementalLayer, v : Double) -> FinanceriskincrementalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalLayer::min(self : FinanceriskincrementalLayer) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalLayer::max(self : FinanceriskincrementalLayer) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalLayer::to_string(self : FinanceriskincrementalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_buffer_make(size : Int) -> FinanceriskincrementalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalBuffer::len(self : FinanceriskincrementalBuffer) -> Int { self.size }

pub fn FinanceriskincrementalBuffer::get(self : FinanceriskincrementalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalBuffer::set(self : FinanceriskincrementalBuffer, i : Int, v : Double) -> FinanceriskincrementalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalBuffer::sum(self : FinanceriskincrementalBuffer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalBuffer::mean(self : FinanceriskincrementalBuffer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalBuffer::scale(self : FinanceriskincrementalBuffer, f : Double) -> FinanceriskincrementalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalBuffer::add(self : FinanceriskincrementalBuffer, other : FinanceriskincrementalBuffer) -> FinanceriskincrementalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalBuffer::copy(self : FinanceriskincrementalBuffer) -> FinanceriskincrementalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalBuffer::fill(self : FinanceriskincrementalBuffer, v : Double) -> FinanceriskincrementalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalBuffer::min(self : FinanceriskincrementalBuffer) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalBuffer::max(self : FinanceriskincrementalBuffer) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalBuffer::to_string(self : FinanceriskincrementalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_cursor_make(size : Int) -> FinanceriskincrementalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalCursor::len(self : FinanceriskincrementalCursor) -> Int { self.size }

pub fn FinanceriskincrementalCursor::get(self : FinanceriskincrementalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalCursor::set(self : FinanceriskincrementalCursor, i : Int, v : Double) -> FinanceriskincrementalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalCursor::sum(self : FinanceriskincrementalCursor) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalCursor::mean(self : FinanceriskincrementalCursor) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalCursor::scale(self : FinanceriskincrementalCursor, f : Double) -> FinanceriskincrementalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalCursor::add(self : FinanceriskincrementalCursor, other : FinanceriskincrementalCursor) -> FinanceriskincrementalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalCursor::copy(self : FinanceriskincrementalCursor) -> FinanceriskincrementalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalCursor::fill(self : FinanceriskincrementalCursor, v : Double) -> FinanceriskincrementalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalCursor::min(self : FinanceriskincrementalCursor) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalCursor::max(self : FinanceriskincrementalCursor) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalCursor::to_string(self : FinanceriskincrementalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_view_make(size : Int) -> FinanceriskincrementalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalView::len(self : FinanceriskincrementalView) -> Int { self.size }

pub fn FinanceriskincrementalView::get(self : FinanceriskincrementalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalView::set(self : FinanceriskincrementalView, i : Int, v : Double) -> FinanceriskincrementalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalView::sum(self : FinanceriskincrementalView) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalView::mean(self : FinanceriskincrementalView) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalView::scale(self : FinanceriskincrementalView, f : Double) -> FinanceriskincrementalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalView::add(self : FinanceriskincrementalView, other : FinanceriskincrementalView) -> FinanceriskincrementalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalView::copy(self : FinanceriskincrementalView) -> FinanceriskincrementalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalView::fill(self : FinanceriskincrementalView, v : Double) -> FinanceriskincrementalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalView::min(self : FinanceriskincrementalView) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalView::max(self : FinanceriskincrementalView) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalView::to_string(self : FinanceriskincrementalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_range_make(size : Int) -> FinanceriskincrementalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalRange::len(self : FinanceriskincrementalRange) -> Int { self.size }

pub fn FinanceriskincrementalRange::get(self : FinanceriskincrementalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalRange::set(self : FinanceriskincrementalRange, i : Int, v : Double) -> FinanceriskincrementalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalRange::sum(self : FinanceriskincrementalRange) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalRange::mean(self : FinanceriskincrementalRange) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalRange::scale(self : FinanceriskincrementalRange, f : Double) -> FinanceriskincrementalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalRange::add(self : FinanceriskincrementalRange, other : FinanceriskincrementalRange) -> FinanceriskincrementalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalRange::copy(self : FinanceriskincrementalRange) -> FinanceriskincrementalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalRange::fill(self : FinanceriskincrementalRange, v : Double) -> FinanceriskincrementalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalRange::min(self : FinanceriskincrementalRange) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalRange::max(self : FinanceriskincrementalRange) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalRange::to_string(self : FinanceriskincrementalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_slice_make(size : Int) -> FinanceriskincrementalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskincrementalSlice::len(self : FinanceriskincrementalSlice) -> Int { self.size }

pub fn FinanceriskincrementalSlice::get(self : FinanceriskincrementalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskincrementalSlice::set(self : FinanceriskincrementalSlice, i : Int, v : Double) -> FinanceriskincrementalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalSlice::sum(self : FinanceriskincrementalSlice) -> Double { @_common.sum(self.data) }

pub fn FinanceriskincrementalSlice::mean(self : FinanceriskincrementalSlice) -> Double { @_common.mean(self.data) }

pub fn FinanceriskincrementalSlice::scale(self : FinanceriskincrementalSlice, f : Double) -> FinanceriskincrementalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalSlice::add(self : FinanceriskincrementalSlice, other : FinanceriskincrementalSlice) -> FinanceriskincrementalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskincrementalSlice::copy(self : FinanceriskincrementalSlice) -> FinanceriskincrementalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalSlice::fill(self : FinanceriskincrementalSlice, v : Double) -> FinanceriskincrementalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskincrementalSlice::min(self : FinanceriskincrementalSlice) -> Double { @_common.min(self.data) }

pub fn FinanceriskincrementalSlice::max(self : FinanceriskincrementalSlice) -> Double { @_common.max(self.data) }

pub fn FinanceriskincrementalSlice::to_string(self : FinanceriskincrementalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

