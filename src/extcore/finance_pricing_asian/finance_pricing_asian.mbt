///===
/// extcore/finance_pricing_asian

pub(all) struct FinancepricingasianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_asian_make_point(x : Double, y : Double) -> FinancepricingasianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_asian_make_point3(x : Double, y : Double, z : Double) -> FinancepricingasianPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingasianPoint::x(self : FinancepricingasianPoint) -> Double { self.x }

pub fn FinancepricingasianPoint::y(self : FinancepricingasianPoint) -> Double { self.y }

pub fn FinancepricingasianPoint::z(self : FinancepricingasianPoint) -> Double { self.z }

pub fn FinancepricingasianPoint::label(self : FinancepricingasianPoint) -> Int { self.label }

pub fn FinancepricingasianPoint::dist(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingasianPoint::add(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingasianPoint::sub(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingasianPoint::scale(self : FinancepricingasianPoint, s : Double) -> FinancepricingasianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingasianPoint::dot(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingasianPoint::cross(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingasianPoint::norm(self : FinancepricingasianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingasianPoint::normalize(self : FinancepricingasianPoint) -> FinancepricingasianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingasianPoint::negate(self : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingasianPoint::mid(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingasianPoint::lerp(self : FinancepricingasianPoint, other : FinancepricingasianPoint, t : Double) -> FinancepricingasianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingasianPoint::to_string(self : FinancepricingasianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingasianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_asian_make_series(vals : Array[Double], name : String) -> FinancepricingasianSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingasianSeries::len(self : FinancepricingasianSeries) -> Int { self.vals.length() }

pub fn FinancepricingasianSeries::sum(self : FinancepricingasianSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingasianSeries::mean(self : FinancepricingasianSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingasianSeries::min(self : FinancepricingasianSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingasianSeries::max(self : FinancepricingasianSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingasianSeries::range(self : FinancepricingasianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingasianSeries::variance(self : FinancepricingasianSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingasianSeries::std(self : FinancepricingasianSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingasianSeries::median(self : FinancepricingasianSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingasianSeries::scale(self : FinancepricingasianSeries, f : Double) -> FinancepricingasianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingasianSeries::add(self : FinancepricingasianSeries, other : FinancepricingasianSeries) -> FinancepricingasianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingasianSeries::sub(self : FinancepricingasianSeries, other : FinancepricingasianSeries) -> FinancepricingasianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingasianSeries::normalize(self : FinancepricingasianSeries) -> FinancepricingasianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingasianSeries::cumsum(self : FinancepricingasianSeries) -> FinancepricingasianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingasianSeries::to_string(self : FinancepricingasianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingasianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_asian_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingasianMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn finance_pricing_asian_matrix_identity(n : Int) -> FinancepricingasianMatrix {
  let m = finance_pricing_asian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingasianMatrix::get(self : FinancepricingasianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingasianMatrix::transpose(self : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  let result = finance_pricing_asian_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingasianMatrix::add(self : FinancepricingasianMatrix, other : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_asian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingasianMatrix::scale(self : FinancepricingasianMatrix, s : Double) -> FinancepricingasianMatrix {
  let result = finance_pricing_asian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingasianMatrix::multiply(self : FinancepricingasianMatrix, other : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  if self.cols != other.rows { return finance_pricing_asian_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_asian_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn FinancepricingasianMatrix::trace(self : FinancepricingasianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingasianMatrix::det(self : FinancepricingasianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingasianMatrix::norm(self : FinancepricingasianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingasianMatrix::to_string(self : FinancepricingasianMatrix) -> String {
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

pub(all) struct FinancepricingasianVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_asian_make_vector(comps : Array[Double]) -> FinancepricingasianVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_asian_vector_zero(dim : Int) -> FinancepricingasianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingasianVector::add(self : FinancepricingasianVector, other : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingasianVector::sub(self : FinancepricingasianVector, other : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingasianVector::scale(self : FinancepricingasianVector, s : Double) -> FinancepricingasianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingasianVector::dot(self : FinancepricingasianVector, other : FinancepricingasianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingasianVector::norm(self : FinancepricingasianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingasianVector::normalize(self : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingasianVector::dist(self : FinancepricingasianVector, other : FinancepricingasianVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingasianVector::to_string(self : FinancepricingasianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingasianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_frame_make(size : Int) -> FinancepricingasianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianFrame::len(self : FinancepricingasianFrame) -> Int { self.size }

pub fn FinancepricingasianFrame::get(self : FinancepricingasianFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianFrame::set(self : FinancepricingasianFrame, i : Int, v : Double) -> FinancepricingasianFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianFrame::sum(self : FinancepricingasianFrame) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianFrame::mean(self : FinancepricingasianFrame) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianFrame::scale(self : FinancepricingasianFrame, f : Double) -> FinancepricingasianFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianFrame::add(self : FinancepricingasianFrame, other : FinancepricingasianFrame) -> FinancepricingasianFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianFrame::copy(self : FinancepricingasianFrame) -> FinancepricingasianFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianFrame::fill(self : FinancepricingasianFrame, v : Double) -> FinancepricingasianFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianFrame::min(self : FinancepricingasianFrame) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianFrame::max(self : FinancepricingasianFrame) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianFrame::to_string(self : FinancepricingasianFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_table_make(size : Int) -> FinancepricingasianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianTable::len(self : FinancepricingasianTable) -> Int { self.size }

pub fn FinancepricingasianTable::get(self : FinancepricingasianTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianTable::set(self : FinancepricingasianTable, i : Int, v : Double) -> FinancepricingasianTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianTable::sum(self : FinancepricingasianTable) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianTable::mean(self : FinancepricingasianTable) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianTable::scale(self : FinancepricingasianTable, f : Double) -> FinancepricingasianTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianTable::add(self : FinancepricingasianTable, other : FinancepricingasianTable) -> FinancepricingasianTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianTable::copy(self : FinancepricingasianTable) -> FinancepricingasianTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianTable::fill(self : FinancepricingasianTable, v : Double) -> FinancepricingasianTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianTable::min(self : FinancepricingasianTable) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianTable::max(self : FinancepricingasianTable) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianTable::to_string(self : FinancepricingasianTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_graphn_make(size : Int) -> FinancepricingasianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianGraphN::len(self : FinancepricingasianGraphN) -> Int { self.size }

pub fn FinancepricingasianGraphN::get(self : FinancepricingasianGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianGraphN::set(self : FinancepricingasianGraphN, i : Int, v : Double) -> FinancepricingasianGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianGraphN::sum(self : FinancepricingasianGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianGraphN::mean(self : FinancepricingasianGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianGraphN::scale(self : FinancepricingasianGraphN, f : Double) -> FinancepricingasianGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianGraphN::add(self : FinancepricingasianGraphN, other : FinancepricingasianGraphN) -> FinancepricingasianGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianGraphN::copy(self : FinancepricingasianGraphN) -> FinancepricingasianGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianGraphN::fill(self : FinancepricingasianGraphN, v : Double) -> FinancepricingasianGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianGraphN::min(self : FinancepricingasianGraphN) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianGraphN::max(self : FinancepricingasianGraphN) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianGraphN::to_string(self : FinancepricingasianGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_node_make(size : Int) -> FinancepricingasianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianNode::len(self : FinancepricingasianNode) -> Int { self.size }

pub fn FinancepricingasianNode::get(self : FinancepricingasianNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianNode::set(self : FinancepricingasianNode, i : Int, v : Double) -> FinancepricingasianNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianNode::sum(self : FinancepricingasianNode) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianNode::mean(self : FinancepricingasianNode) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianNode::scale(self : FinancepricingasianNode, f : Double) -> FinancepricingasianNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianNode::add(self : FinancepricingasianNode, other : FinancepricingasianNode) -> FinancepricingasianNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianNode::copy(self : FinancepricingasianNode) -> FinancepricingasianNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianNode::fill(self : FinancepricingasianNode, v : Double) -> FinancepricingasianNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianNode::min(self : FinancepricingasianNode) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianNode::max(self : FinancepricingasianNode) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianNode::to_string(self : FinancepricingasianNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_edge_make(size : Int) -> FinancepricingasianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianEdge::len(self : FinancepricingasianEdge) -> Int { self.size }

pub fn FinancepricingasianEdge::get(self : FinancepricingasianEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianEdge::set(self : FinancepricingasianEdge, i : Int, v : Double) -> FinancepricingasianEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianEdge::sum(self : FinancepricingasianEdge) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianEdge::mean(self : FinancepricingasianEdge) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianEdge::scale(self : FinancepricingasianEdge, f : Double) -> FinancepricingasianEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianEdge::add(self : FinancepricingasianEdge, other : FinancepricingasianEdge) -> FinancepricingasianEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianEdge::copy(self : FinancepricingasianEdge) -> FinancepricingasianEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianEdge::fill(self : FinancepricingasianEdge, v : Double) -> FinancepricingasianEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianEdge::min(self : FinancepricingasianEdge) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianEdge::max(self : FinancepricingasianEdge) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianEdge::to_string(self : FinancepricingasianEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_path_make(size : Int) -> FinancepricingasianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianPath::len(self : FinancepricingasianPath) -> Int { self.size }

pub fn FinancepricingasianPath::get(self : FinancepricingasianPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianPath::set(self : FinancepricingasianPath, i : Int, v : Double) -> FinancepricingasianPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianPath::sum(self : FinancepricingasianPath) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianPath::mean(self : FinancepricingasianPath) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianPath::scale(self : FinancepricingasianPath, f : Double) -> FinancepricingasianPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianPath::add(self : FinancepricingasianPath, other : FinancepricingasianPath) -> FinancepricingasianPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianPath::copy(self : FinancepricingasianPath) -> FinancepricingasianPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianPath::fill(self : FinancepricingasianPath, v : Double) -> FinancepricingasianPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianPath::min(self : FinancepricingasianPath) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianPath::max(self : FinancepricingasianPath) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianPath::to_string(self : FinancepricingasianPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_cluster_make(size : Int) -> FinancepricingasianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianCluster::len(self : FinancepricingasianCluster) -> Int { self.size }

pub fn FinancepricingasianCluster::get(self : FinancepricingasianCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianCluster::set(self : FinancepricingasianCluster, i : Int, v : Double) -> FinancepricingasianCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianCluster::sum(self : FinancepricingasianCluster) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianCluster::mean(self : FinancepricingasianCluster) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianCluster::scale(self : FinancepricingasianCluster, f : Double) -> FinancepricingasianCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianCluster::add(self : FinancepricingasianCluster, other : FinancepricingasianCluster) -> FinancepricingasianCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianCluster::copy(self : FinancepricingasianCluster) -> FinancepricingasianCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianCluster::fill(self : FinancepricingasianCluster, v : Double) -> FinancepricingasianCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianCluster::min(self : FinancepricingasianCluster) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianCluster::max(self : FinancepricingasianCluster) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianCluster::to_string(self : FinancepricingasianCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_model_make(size : Int) -> FinancepricingasianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianModel::len(self : FinancepricingasianModel) -> Int { self.size }

pub fn FinancepricingasianModel::get(self : FinancepricingasianModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianModel::set(self : FinancepricingasianModel, i : Int, v : Double) -> FinancepricingasianModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianModel::sum(self : FinancepricingasianModel) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianModel::mean(self : FinancepricingasianModel) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianModel::scale(self : FinancepricingasianModel, f : Double) -> FinancepricingasianModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianModel::add(self : FinancepricingasianModel, other : FinancepricingasianModel) -> FinancepricingasianModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianModel::copy(self : FinancepricingasianModel) -> FinancepricingasianModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianModel::fill(self : FinancepricingasianModel, v : Double) -> FinancepricingasianModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianModel::min(self : FinancepricingasianModel) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianModel::max(self : FinancepricingasianModel) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianModel::to_string(self : FinancepricingasianModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_layer_make(size : Int) -> FinancepricingasianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianLayer::len(self : FinancepricingasianLayer) -> Int { self.size }

pub fn FinancepricingasianLayer::get(self : FinancepricingasianLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianLayer::set(self : FinancepricingasianLayer, i : Int, v : Double) -> FinancepricingasianLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianLayer::sum(self : FinancepricingasianLayer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianLayer::mean(self : FinancepricingasianLayer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianLayer::scale(self : FinancepricingasianLayer, f : Double) -> FinancepricingasianLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianLayer::add(self : FinancepricingasianLayer, other : FinancepricingasianLayer) -> FinancepricingasianLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianLayer::copy(self : FinancepricingasianLayer) -> FinancepricingasianLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianLayer::fill(self : FinancepricingasianLayer, v : Double) -> FinancepricingasianLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianLayer::min(self : FinancepricingasianLayer) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianLayer::max(self : FinancepricingasianLayer) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianLayer::to_string(self : FinancepricingasianLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_buffer_make(size : Int) -> FinancepricingasianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianBuffer::len(self : FinancepricingasianBuffer) -> Int { self.size }

pub fn FinancepricingasianBuffer::get(self : FinancepricingasianBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianBuffer::set(self : FinancepricingasianBuffer, i : Int, v : Double) -> FinancepricingasianBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianBuffer::sum(self : FinancepricingasianBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianBuffer::mean(self : FinancepricingasianBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianBuffer::scale(self : FinancepricingasianBuffer, f : Double) -> FinancepricingasianBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianBuffer::add(self : FinancepricingasianBuffer, other : FinancepricingasianBuffer) -> FinancepricingasianBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianBuffer::copy(self : FinancepricingasianBuffer) -> FinancepricingasianBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianBuffer::fill(self : FinancepricingasianBuffer, v : Double) -> FinancepricingasianBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianBuffer::min(self : FinancepricingasianBuffer) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianBuffer::max(self : FinancepricingasianBuffer) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianBuffer::to_string(self : FinancepricingasianBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_cursor_make(size : Int) -> FinancepricingasianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianCursor::len(self : FinancepricingasianCursor) -> Int { self.size }

pub fn FinancepricingasianCursor::get(self : FinancepricingasianCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianCursor::set(self : FinancepricingasianCursor, i : Int, v : Double) -> FinancepricingasianCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianCursor::sum(self : FinancepricingasianCursor) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianCursor::mean(self : FinancepricingasianCursor) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianCursor::scale(self : FinancepricingasianCursor, f : Double) -> FinancepricingasianCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianCursor::add(self : FinancepricingasianCursor, other : FinancepricingasianCursor) -> FinancepricingasianCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianCursor::copy(self : FinancepricingasianCursor) -> FinancepricingasianCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianCursor::fill(self : FinancepricingasianCursor, v : Double) -> FinancepricingasianCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianCursor::min(self : FinancepricingasianCursor) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianCursor::max(self : FinancepricingasianCursor) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianCursor::to_string(self : FinancepricingasianCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_view_make(size : Int) -> FinancepricingasianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianView::len(self : FinancepricingasianView) -> Int { self.size }

pub fn FinancepricingasianView::get(self : FinancepricingasianView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianView::set(self : FinancepricingasianView, i : Int, v : Double) -> FinancepricingasianView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianView::sum(self : FinancepricingasianView) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianView::mean(self : FinancepricingasianView) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianView::scale(self : FinancepricingasianView, f : Double) -> FinancepricingasianView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianView::add(self : FinancepricingasianView, other : FinancepricingasianView) -> FinancepricingasianView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianView::copy(self : FinancepricingasianView) -> FinancepricingasianView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianView::fill(self : FinancepricingasianView, v : Double) -> FinancepricingasianView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianView::min(self : FinancepricingasianView) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianView::max(self : FinancepricingasianView) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianView::to_string(self : FinancepricingasianView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_range_make(size : Int) -> FinancepricingasianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianRange::len(self : FinancepricingasianRange) -> Int { self.size }

pub fn FinancepricingasianRange::get(self : FinancepricingasianRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianRange::set(self : FinancepricingasianRange, i : Int, v : Double) -> FinancepricingasianRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianRange::sum(self : FinancepricingasianRange) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianRange::mean(self : FinancepricingasianRange) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianRange::scale(self : FinancepricingasianRange, f : Double) -> FinancepricingasianRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianRange::add(self : FinancepricingasianRange, other : FinancepricingasianRange) -> FinancepricingasianRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianRange::copy(self : FinancepricingasianRange) -> FinancepricingasianRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianRange::fill(self : FinancepricingasianRange, v : Double) -> FinancepricingasianRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianRange::min(self : FinancepricingasianRange) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianRange::max(self : FinancepricingasianRange) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianRange::to_string(self : FinancepricingasianRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_slice_make(size : Int) -> FinancepricingasianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingasianSlice::len(self : FinancepricingasianSlice) -> Int { self.size }

pub fn FinancepricingasianSlice::get(self : FinancepricingasianSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingasianSlice::set(self : FinancepricingasianSlice, i : Int, v : Double) -> FinancepricingasianSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingasianSlice::sum(self : FinancepricingasianSlice) -> Double { @_common.sum(self.data) }

pub fn FinancepricingasianSlice::mean(self : FinancepricingasianSlice) -> Double { @_common.mean(self.data) }

pub fn FinancepricingasianSlice::scale(self : FinancepricingasianSlice, f : Double) -> FinancepricingasianSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianSlice::add(self : FinancepricingasianSlice, other : FinancepricingasianSlice) -> FinancepricingasianSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingasianSlice::copy(self : FinancepricingasianSlice) -> FinancepricingasianSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianSlice::fill(self : FinancepricingasianSlice, v : Double) -> FinancepricingasianSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingasianSlice::min(self : FinancepricingasianSlice) -> Double { @_common.min(self.data) }

pub fn FinancepricingasianSlice::max(self : FinancepricingasianSlice) -> Double { @_common.max(self.data) }

pub fn FinancepricingasianSlice::to_string(self : FinancepricingasianSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

