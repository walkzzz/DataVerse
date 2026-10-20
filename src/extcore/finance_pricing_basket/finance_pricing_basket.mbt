///===
/// extcore/finance_pricing_basket

pub(all) struct FinancepricingbasketPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_basket_make_point(x : Double, y : Double) -> FinancepricingbasketPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_basket_make_point3(x : Double, y : Double, z : Double) -> FinancepricingbasketPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingbasketPoint::x(self : FinancepricingbasketPoint) -> Double { self.x }

pub fn FinancepricingbasketPoint::y(self : FinancepricingbasketPoint) -> Double { self.y }

pub fn FinancepricingbasketPoint::z(self : FinancepricingbasketPoint) -> Double { self.z }

pub fn FinancepricingbasketPoint::label(self : FinancepricingbasketPoint) -> Int { self.label }

pub fn FinancepricingbasketPoint::dist(self : FinancepricingbasketPoint, other : FinancepricingbasketPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingbasketPoint::add(self : FinancepricingbasketPoint, other : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingbasketPoint::sub(self : FinancepricingbasketPoint, other : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingbasketPoint::scale(self : FinancepricingbasketPoint, s : Double) -> FinancepricingbasketPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingbasketPoint::dot(self : FinancepricingbasketPoint, other : FinancepricingbasketPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingbasketPoint::cross(self : FinancepricingbasketPoint, other : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingbasketPoint::norm(self : FinancepricingbasketPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingbasketPoint::normalize(self : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingbasketPoint::negate(self : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingbasketPoint::mid(self : FinancepricingbasketPoint, other : FinancepricingbasketPoint) -> FinancepricingbasketPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingbasketPoint::lerp(self : FinancepricingbasketPoint, other : FinancepricingbasketPoint, t : Double) -> FinancepricingbasketPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingbasketPoint::to_string(self : FinancepricingbasketPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingbasketSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_basket_make_series(vals : Array[Double], name : String) -> FinancepricingbasketSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingbasketSeries::len(self : FinancepricingbasketSeries) -> Int { self.vals.length() }

pub fn FinancepricingbasketSeries::sum(self : FinancepricingbasketSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingbasketSeries::mean(self : FinancepricingbasketSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingbasketSeries::min(self : FinancepricingbasketSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingbasketSeries::max(self : FinancepricingbasketSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingbasketSeries::range(self : FinancepricingbasketSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingbasketSeries::variance(self : FinancepricingbasketSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingbasketSeries::std(self : FinancepricingbasketSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingbasketSeries::median(self : FinancepricingbasketSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingbasketSeries::scale(self : FinancepricingbasketSeries, f : Double) -> FinancepricingbasketSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingbasketSeries::add(self : FinancepricingbasketSeries, other : FinancepricingbasketSeries) -> FinancepricingbasketSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingbasketSeries::sub(self : FinancepricingbasketSeries, other : FinancepricingbasketSeries) -> FinancepricingbasketSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingbasketSeries::normalize(self : FinancepricingbasketSeries) -> FinancepricingbasketSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingbasketSeries::cumsum(self : FinancepricingbasketSeries) -> FinancepricingbasketSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingbasketSeries::to_string(self : FinancepricingbasketSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingbasketMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_basket_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingbasketMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_basket_matrix_identity(n : Int) -> FinancepricingbasketMatrix {
  let m = finance_pricing_basket_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingbasketMatrix::get(self : FinancepricingbasketMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingbasketMatrix::transpose(self : FinancepricingbasketMatrix) -> FinancepricingbasketMatrix {
  let result = finance_pricing_basket_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingbasketMatrix::add(self : FinancepricingbasketMatrix, other : FinancepricingbasketMatrix) -> FinancepricingbasketMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_basket_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingbasketMatrix::scale(self : FinancepricingbasketMatrix, s : Double) -> FinancepricingbasketMatrix {
  let result = finance_pricing_basket_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingbasketMatrix::multiply(self : FinancepricingbasketMatrix, other : FinancepricingbasketMatrix) -> FinancepricingbasketMatrix {
  if self.cols != other.rows { return finance_pricing_basket_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_basket_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricingbasketMatrix::trace(self : FinancepricingbasketMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingbasketMatrix::det(self : FinancepricingbasketMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingbasketMatrix::norm(self : FinancepricingbasketMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingbasketMatrix::to_string(self : FinancepricingbasketMatrix) -> String {
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

pub(all) struct FinancepricingbasketVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_basket_make_vector(comps : Array[Double]) -> FinancepricingbasketVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_basket_vector_zero(dim : Int) -> FinancepricingbasketVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingbasketVector::add(self : FinancepricingbasketVector, other : FinancepricingbasketVector) -> FinancepricingbasketVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingbasketVector::sub(self : FinancepricingbasketVector, other : FinancepricingbasketVector) -> FinancepricingbasketVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingbasketVector::scale(self : FinancepricingbasketVector, s : Double) -> FinancepricingbasketVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingbasketVector::dot(self : FinancepricingbasketVector, other : FinancepricingbasketVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingbasketVector::norm(self : FinancepricingbasketVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingbasketVector::normalize(self : FinancepricingbasketVector) -> FinancepricingbasketVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingbasketVector::dist(self : FinancepricingbasketVector, other : FinancepricingbasketVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingbasketVector::to_string(self : FinancepricingbasketVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingbasketFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_frame_make(size : Int) -> FinancepricingbasketFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketFrame::len(self : FinancepricingbasketFrame) -> Int { self.size }

pub fn FinancepricingbasketFrame::get(self : FinancepricingbasketFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketFrame::set(self : FinancepricingbasketFrame, i : Int, v : Double) -> FinancepricingbasketFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketFrame::sum(self : FinancepricingbasketFrame) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketFrame::mean(self : FinancepricingbasketFrame) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketFrame::scale(self : FinancepricingbasketFrame, f : Double) -> FinancepricingbasketFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketFrame::add(self : FinancepricingbasketFrame, other : FinancepricingbasketFrame) -> FinancepricingbasketFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketFrame::copy(self : FinancepricingbasketFrame) -> FinancepricingbasketFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketFrame::fill(self : FinancepricingbasketFrame, v : Double) -> FinancepricingbasketFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketFrame::min(self : FinancepricingbasketFrame) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketFrame::max(self : FinancepricingbasketFrame) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketFrame::to_string(self : FinancepricingbasketFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_table_make(size : Int) -> FinancepricingbasketTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketTable::len(self : FinancepricingbasketTable) -> Int { self.size }

pub fn FinancepricingbasketTable::get(self : FinancepricingbasketTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketTable::set(self : FinancepricingbasketTable, i : Int, v : Double) -> FinancepricingbasketTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketTable::sum(self : FinancepricingbasketTable) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketTable::mean(self : FinancepricingbasketTable) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketTable::scale(self : FinancepricingbasketTable, f : Double) -> FinancepricingbasketTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketTable::add(self : FinancepricingbasketTable, other : FinancepricingbasketTable) -> FinancepricingbasketTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketTable::copy(self : FinancepricingbasketTable) -> FinancepricingbasketTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketTable::fill(self : FinancepricingbasketTable, v : Double) -> FinancepricingbasketTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketTable::min(self : FinancepricingbasketTable) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketTable::max(self : FinancepricingbasketTable) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketTable::to_string(self : FinancepricingbasketTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_graphn_make(size : Int) -> FinancepricingbasketGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketGraphN::len(self : FinancepricingbasketGraphN) -> Int { self.size }

pub fn FinancepricingbasketGraphN::get(self : FinancepricingbasketGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketGraphN::set(self : FinancepricingbasketGraphN, i : Int, v : Double) -> FinancepricingbasketGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketGraphN::sum(self : FinancepricingbasketGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketGraphN::mean(self : FinancepricingbasketGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketGraphN::scale(self : FinancepricingbasketGraphN, f : Double) -> FinancepricingbasketGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketGraphN::add(self : FinancepricingbasketGraphN, other : FinancepricingbasketGraphN) -> FinancepricingbasketGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketGraphN::copy(self : FinancepricingbasketGraphN) -> FinancepricingbasketGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketGraphN::fill(self : FinancepricingbasketGraphN, v : Double) -> FinancepricingbasketGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketGraphN::min(self : FinancepricingbasketGraphN) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketGraphN::max(self : FinancepricingbasketGraphN) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketGraphN::to_string(self : FinancepricingbasketGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_node_make(size : Int) -> FinancepricingbasketNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketNode::len(self : FinancepricingbasketNode) -> Int { self.size }

pub fn FinancepricingbasketNode::get(self : FinancepricingbasketNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketNode::set(self : FinancepricingbasketNode, i : Int, v : Double) -> FinancepricingbasketNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketNode::sum(self : FinancepricingbasketNode) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketNode::mean(self : FinancepricingbasketNode) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketNode::scale(self : FinancepricingbasketNode, f : Double) -> FinancepricingbasketNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketNode::add(self : FinancepricingbasketNode, other : FinancepricingbasketNode) -> FinancepricingbasketNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketNode::copy(self : FinancepricingbasketNode) -> FinancepricingbasketNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketNode::fill(self : FinancepricingbasketNode, v : Double) -> FinancepricingbasketNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketNode::min(self : FinancepricingbasketNode) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketNode::max(self : FinancepricingbasketNode) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketNode::to_string(self : FinancepricingbasketNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_edge_make(size : Int) -> FinancepricingbasketEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketEdge::len(self : FinancepricingbasketEdge) -> Int { self.size }

pub fn FinancepricingbasketEdge::get(self : FinancepricingbasketEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketEdge::set(self : FinancepricingbasketEdge, i : Int, v : Double) -> FinancepricingbasketEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketEdge::sum(self : FinancepricingbasketEdge) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketEdge::mean(self : FinancepricingbasketEdge) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketEdge::scale(self : FinancepricingbasketEdge, f : Double) -> FinancepricingbasketEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketEdge::add(self : FinancepricingbasketEdge, other : FinancepricingbasketEdge) -> FinancepricingbasketEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketEdge::copy(self : FinancepricingbasketEdge) -> FinancepricingbasketEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketEdge::fill(self : FinancepricingbasketEdge, v : Double) -> FinancepricingbasketEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketEdge::min(self : FinancepricingbasketEdge) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketEdge::max(self : FinancepricingbasketEdge) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketEdge::to_string(self : FinancepricingbasketEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_path_make(size : Int) -> FinancepricingbasketPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketPath::len(self : FinancepricingbasketPath) -> Int { self.size }

pub fn FinancepricingbasketPath::get(self : FinancepricingbasketPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketPath::set(self : FinancepricingbasketPath, i : Int, v : Double) -> FinancepricingbasketPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketPath::sum(self : FinancepricingbasketPath) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketPath::mean(self : FinancepricingbasketPath) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketPath::scale(self : FinancepricingbasketPath, f : Double) -> FinancepricingbasketPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketPath::add(self : FinancepricingbasketPath, other : FinancepricingbasketPath) -> FinancepricingbasketPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketPath::copy(self : FinancepricingbasketPath) -> FinancepricingbasketPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketPath::fill(self : FinancepricingbasketPath, v : Double) -> FinancepricingbasketPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketPath::min(self : FinancepricingbasketPath) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketPath::max(self : FinancepricingbasketPath) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketPath::to_string(self : FinancepricingbasketPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_cluster_make(size : Int) -> FinancepricingbasketCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketCluster::len(self : FinancepricingbasketCluster) -> Int { self.size }

pub fn FinancepricingbasketCluster::get(self : FinancepricingbasketCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketCluster::set(self : FinancepricingbasketCluster, i : Int, v : Double) -> FinancepricingbasketCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketCluster::sum(self : FinancepricingbasketCluster) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketCluster::mean(self : FinancepricingbasketCluster) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketCluster::scale(self : FinancepricingbasketCluster, f : Double) -> FinancepricingbasketCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketCluster::add(self : FinancepricingbasketCluster, other : FinancepricingbasketCluster) -> FinancepricingbasketCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketCluster::copy(self : FinancepricingbasketCluster) -> FinancepricingbasketCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketCluster::fill(self : FinancepricingbasketCluster, v : Double) -> FinancepricingbasketCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketCluster::min(self : FinancepricingbasketCluster) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketCluster::max(self : FinancepricingbasketCluster) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketCluster::to_string(self : FinancepricingbasketCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_model_make(size : Int) -> FinancepricingbasketModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketModel::len(self : FinancepricingbasketModel) -> Int { self.size }

pub fn FinancepricingbasketModel::get(self : FinancepricingbasketModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketModel::set(self : FinancepricingbasketModel, i : Int, v : Double) -> FinancepricingbasketModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketModel::sum(self : FinancepricingbasketModel) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketModel::mean(self : FinancepricingbasketModel) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketModel::scale(self : FinancepricingbasketModel, f : Double) -> FinancepricingbasketModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketModel::add(self : FinancepricingbasketModel, other : FinancepricingbasketModel) -> FinancepricingbasketModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketModel::copy(self : FinancepricingbasketModel) -> FinancepricingbasketModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketModel::fill(self : FinancepricingbasketModel, v : Double) -> FinancepricingbasketModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketModel::min(self : FinancepricingbasketModel) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketModel::max(self : FinancepricingbasketModel) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketModel::to_string(self : FinancepricingbasketModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_layer_make(size : Int) -> FinancepricingbasketLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketLayer::len(self : FinancepricingbasketLayer) -> Int { self.size }

pub fn FinancepricingbasketLayer::get(self : FinancepricingbasketLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketLayer::set(self : FinancepricingbasketLayer, i : Int, v : Double) -> FinancepricingbasketLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketLayer::sum(self : FinancepricingbasketLayer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketLayer::mean(self : FinancepricingbasketLayer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketLayer::scale(self : FinancepricingbasketLayer, f : Double) -> FinancepricingbasketLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketLayer::add(self : FinancepricingbasketLayer, other : FinancepricingbasketLayer) -> FinancepricingbasketLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketLayer::copy(self : FinancepricingbasketLayer) -> FinancepricingbasketLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketLayer::fill(self : FinancepricingbasketLayer, v : Double) -> FinancepricingbasketLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketLayer::min(self : FinancepricingbasketLayer) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketLayer::max(self : FinancepricingbasketLayer) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketLayer::to_string(self : FinancepricingbasketLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_buffer_make(size : Int) -> FinancepricingbasketBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketBuffer::len(self : FinancepricingbasketBuffer) -> Int { self.size }

pub fn FinancepricingbasketBuffer::get(self : FinancepricingbasketBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketBuffer::set(self : FinancepricingbasketBuffer, i : Int, v : Double) -> FinancepricingbasketBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketBuffer::sum(self : FinancepricingbasketBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketBuffer::mean(self : FinancepricingbasketBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketBuffer::scale(self : FinancepricingbasketBuffer, f : Double) -> FinancepricingbasketBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketBuffer::add(self : FinancepricingbasketBuffer, other : FinancepricingbasketBuffer) -> FinancepricingbasketBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketBuffer::copy(self : FinancepricingbasketBuffer) -> FinancepricingbasketBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketBuffer::fill(self : FinancepricingbasketBuffer, v : Double) -> FinancepricingbasketBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketBuffer::min(self : FinancepricingbasketBuffer) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketBuffer::max(self : FinancepricingbasketBuffer) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketBuffer::to_string(self : FinancepricingbasketBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_cursor_make(size : Int) -> FinancepricingbasketCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketCursor::len(self : FinancepricingbasketCursor) -> Int { self.size }

pub fn FinancepricingbasketCursor::get(self : FinancepricingbasketCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketCursor::set(self : FinancepricingbasketCursor, i : Int, v : Double) -> FinancepricingbasketCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketCursor::sum(self : FinancepricingbasketCursor) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketCursor::mean(self : FinancepricingbasketCursor) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketCursor::scale(self : FinancepricingbasketCursor, f : Double) -> FinancepricingbasketCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketCursor::add(self : FinancepricingbasketCursor, other : FinancepricingbasketCursor) -> FinancepricingbasketCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketCursor::copy(self : FinancepricingbasketCursor) -> FinancepricingbasketCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketCursor::fill(self : FinancepricingbasketCursor, v : Double) -> FinancepricingbasketCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketCursor::min(self : FinancepricingbasketCursor) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketCursor::max(self : FinancepricingbasketCursor) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketCursor::to_string(self : FinancepricingbasketCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_view_make(size : Int) -> FinancepricingbasketView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketView::len(self : FinancepricingbasketView) -> Int { self.size }

pub fn FinancepricingbasketView::get(self : FinancepricingbasketView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketView::set(self : FinancepricingbasketView, i : Int, v : Double) -> FinancepricingbasketView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketView::sum(self : FinancepricingbasketView) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketView::mean(self : FinancepricingbasketView) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketView::scale(self : FinancepricingbasketView, f : Double) -> FinancepricingbasketView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketView::add(self : FinancepricingbasketView, other : FinancepricingbasketView) -> FinancepricingbasketView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketView::copy(self : FinancepricingbasketView) -> FinancepricingbasketView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketView::fill(self : FinancepricingbasketView, v : Double) -> FinancepricingbasketView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketView::min(self : FinancepricingbasketView) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketView::max(self : FinancepricingbasketView) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketView::to_string(self : FinancepricingbasketView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_range_make(size : Int) -> FinancepricingbasketRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketRange::len(self : FinancepricingbasketRange) -> Int { self.size }

pub fn FinancepricingbasketRange::get(self : FinancepricingbasketRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketRange::set(self : FinancepricingbasketRange, i : Int, v : Double) -> FinancepricingbasketRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketRange::sum(self : FinancepricingbasketRange) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketRange::mean(self : FinancepricingbasketRange) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketRange::scale(self : FinancepricingbasketRange, f : Double) -> FinancepricingbasketRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketRange::add(self : FinancepricingbasketRange, other : FinancepricingbasketRange) -> FinancepricingbasketRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketRange::copy(self : FinancepricingbasketRange) -> FinancepricingbasketRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketRange::fill(self : FinancepricingbasketRange, v : Double) -> FinancepricingbasketRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketRange::min(self : FinancepricingbasketRange) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketRange::max(self : FinancepricingbasketRange) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketRange::to_string(self : FinancepricingbasketRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbasketSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_basket_slice_make(size : Int) -> FinancepricingbasketSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbasketSlice::len(self : FinancepricingbasketSlice) -> Int { self.size }

pub fn FinancepricingbasketSlice::get(self : FinancepricingbasketSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbasketSlice::set(self : FinancepricingbasketSlice, i : Int, v : Double) -> FinancepricingbasketSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketSlice::sum(self : FinancepricingbasketSlice) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbasketSlice::mean(self : FinancepricingbasketSlice) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbasketSlice::scale(self : FinancepricingbasketSlice, f : Double) -> FinancepricingbasketSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketSlice::add(self : FinancepricingbasketSlice, other : FinancepricingbasketSlice) -> FinancepricingbasketSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbasketSlice::copy(self : FinancepricingbasketSlice) -> FinancepricingbasketSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketSlice::fill(self : FinancepricingbasketSlice, v : Double) -> FinancepricingbasketSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbasketSlice::min(self : FinancepricingbasketSlice) -> Double { @_common.min(self.data) }

pub fn FinancepricingbasketSlice::max(self : FinancepricingbasketSlice) -> Double { @_common.max(self.data) }

pub fn FinancepricingbasketSlice::to_string(self : FinancepricingbasketSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

