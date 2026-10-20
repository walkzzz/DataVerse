///===
/// extcore/finance_pricing_binomial

pub(all) struct FinancepricingbinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_binomial_make_point(x : Double, y : Double) -> FinancepricingbinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_binomial_make_point3(x : Double, y : Double, z : Double) -> FinancepricingbinomialPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingbinomialPoint::x(self : FinancepricingbinomialPoint) -> Double { self.x }

pub fn FinancepricingbinomialPoint::y(self : FinancepricingbinomialPoint) -> Double { self.y }

pub fn FinancepricingbinomialPoint::z(self : FinancepricingbinomialPoint) -> Double { self.z }

pub fn FinancepricingbinomialPoint::label(self : FinancepricingbinomialPoint) -> Int { self.label }

pub fn FinancepricingbinomialPoint::dist(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingbinomialPoint::add(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingbinomialPoint::sub(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingbinomialPoint::scale(self : FinancepricingbinomialPoint, s : Double) -> FinancepricingbinomialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingbinomialPoint::dot(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingbinomialPoint::cross(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingbinomialPoint::norm(self : FinancepricingbinomialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingbinomialPoint::normalize(self : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingbinomialPoint::negate(self : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingbinomialPoint::mid(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingbinomialPoint::lerp(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint, t : Double) -> FinancepricingbinomialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingbinomialPoint::to_string(self : FinancepricingbinomialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingbinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_binomial_make_series(vals : Array[Double], name : String) -> FinancepricingbinomialSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingbinomialSeries::len(self : FinancepricingbinomialSeries) -> Int { self.vals.length() }

pub fn FinancepricingbinomialSeries::sum(self : FinancepricingbinomialSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingbinomialSeries::mean(self : FinancepricingbinomialSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingbinomialSeries::min(self : FinancepricingbinomialSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingbinomialSeries::max(self : FinancepricingbinomialSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingbinomialSeries::range(self : FinancepricingbinomialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingbinomialSeries::variance(self : FinancepricingbinomialSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingbinomialSeries::std(self : FinancepricingbinomialSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingbinomialSeries::median(self : FinancepricingbinomialSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingbinomialSeries::scale(self : FinancepricingbinomialSeries, f : Double) -> FinancepricingbinomialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingbinomialSeries::add(self : FinancepricingbinomialSeries, other : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingbinomialSeries::sub(self : FinancepricingbinomialSeries, other : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingbinomialSeries::normalize(self : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingbinomialSeries::cumsum(self : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingbinomialSeries::to_string(self : FinancepricingbinomialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingbinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_binomial_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingbinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_binomial_matrix_identity(n : Int) -> FinancepricingbinomialMatrix {
  let m = finance_pricing_binomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingbinomialMatrix::get(self : FinancepricingbinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingbinomialMatrix::transpose(self : FinancepricingbinomialMatrix) -> FinancepricingbinomialMatrix {
  let result = finance_pricing_binomial_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingbinomialMatrix::add(self : FinancepricingbinomialMatrix, other : FinancepricingbinomialMatrix) -> FinancepricingbinomialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingbinomialMatrix::scale(self : FinancepricingbinomialMatrix, s : Double) -> FinancepricingbinomialMatrix {
  let result = finance_pricing_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingbinomialMatrix::multiply(self : FinancepricingbinomialMatrix, other : FinancepricingbinomialMatrix) -> FinancepricingbinomialMatrix {
  if self.cols != other.rows { return finance_pricing_binomial_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_binomial_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn FinancepricingbinomialMatrix::trace(self : FinancepricingbinomialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingbinomialMatrix::det(self : FinancepricingbinomialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingbinomialMatrix::norm(self : FinancepricingbinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingbinomialMatrix::to_string(self : FinancepricingbinomialMatrix) -> String {
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

pub(all) struct FinancepricingbinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_binomial_make_vector(comps : Array[Double]) -> FinancepricingbinomialVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_binomial_vector_zero(dim : Int) -> FinancepricingbinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingbinomialVector::add(self : FinancepricingbinomialVector, other : FinancepricingbinomialVector) -> FinancepricingbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingbinomialVector::sub(self : FinancepricingbinomialVector, other : FinancepricingbinomialVector) -> FinancepricingbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingbinomialVector::scale(self : FinancepricingbinomialVector, s : Double) -> FinancepricingbinomialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingbinomialVector::dot(self : FinancepricingbinomialVector, other : FinancepricingbinomialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingbinomialVector::norm(self : FinancepricingbinomialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingbinomialVector::normalize(self : FinancepricingbinomialVector) -> FinancepricingbinomialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingbinomialVector::dist(self : FinancepricingbinomialVector, other : FinancepricingbinomialVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingbinomialVector::to_string(self : FinancepricingbinomialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingbinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_frame_make(size : Int) -> FinancepricingbinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialFrame::len(self : FinancepricingbinomialFrame) -> Int { self.size }

pub fn FinancepricingbinomialFrame::get(self : FinancepricingbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialFrame::set(self : FinancepricingbinomialFrame, i : Int, v : Double) -> FinancepricingbinomialFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialFrame::sum(self : FinancepricingbinomialFrame) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialFrame::mean(self : FinancepricingbinomialFrame) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialFrame::scale(self : FinancepricingbinomialFrame, f : Double) -> FinancepricingbinomialFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialFrame::add(self : FinancepricingbinomialFrame, other : FinancepricingbinomialFrame) -> FinancepricingbinomialFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialFrame::copy(self : FinancepricingbinomialFrame) -> FinancepricingbinomialFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialFrame::fill(self : FinancepricingbinomialFrame, v : Double) -> FinancepricingbinomialFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialFrame::min(self : FinancepricingbinomialFrame) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialFrame::max(self : FinancepricingbinomialFrame) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialFrame::to_string(self : FinancepricingbinomialFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_table_make(size : Int) -> FinancepricingbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialTable::len(self : FinancepricingbinomialTable) -> Int { self.size }

pub fn FinancepricingbinomialTable::get(self : FinancepricingbinomialTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialTable::set(self : FinancepricingbinomialTable, i : Int, v : Double) -> FinancepricingbinomialTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialTable::sum(self : FinancepricingbinomialTable) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialTable::mean(self : FinancepricingbinomialTable) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialTable::scale(self : FinancepricingbinomialTable, f : Double) -> FinancepricingbinomialTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialTable::add(self : FinancepricingbinomialTable, other : FinancepricingbinomialTable) -> FinancepricingbinomialTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialTable::copy(self : FinancepricingbinomialTable) -> FinancepricingbinomialTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialTable::fill(self : FinancepricingbinomialTable, v : Double) -> FinancepricingbinomialTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialTable::min(self : FinancepricingbinomialTable) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialTable::max(self : FinancepricingbinomialTable) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialTable::to_string(self : FinancepricingbinomialTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_graphn_make(size : Int) -> FinancepricingbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialGraphN::len(self : FinancepricingbinomialGraphN) -> Int { self.size }

pub fn FinancepricingbinomialGraphN::get(self : FinancepricingbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialGraphN::set(self : FinancepricingbinomialGraphN, i : Int, v : Double) -> FinancepricingbinomialGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialGraphN::sum(self : FinancepricingbinomialGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialGraphN::mean(self : FinancepricingbinomialGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialGraphN::scale(self : FinancepricingbinomialGraphN, f : Double) -> FinancepricingbinomialGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialGraphN::add(self : FinancepricingbinomialGraphN, other : FinancepricingbinomialGraphN) -> FinancepricingbinomialGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialGraphN::copy(self : FinancepricingbinomialGraphN) -> FinancepricingbinomialGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialGraphN::fill(self : FinancepricingbinomialGraphN, v : Double) -> FinancepricingbinomialGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialGraphN::min(self : FinancepricingbinomialGraphN) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialGraphN::max(self : FinancepricingbinomialGraphN) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialGraphN::to_string(self : FinancepricingbinomialGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_node_make(size : Int) -> FinancepricingbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialNode::len(self : FinancepricingbinomialNode) -> Int { self.size }

pub fn FinancepricingbinomialNode::get(self : FinancepricingbinomialNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialNode::set(self : FinancepricingbinomialNode, i : Int, v : Double) -> FinancepricingbinomialNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialNode::sum(self : FinancepricingbinomialNode) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialNode::mean(self : FinancepricingbinomialNode) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialNode::scale(self : FinancepricingbinomialNode, f : Double) -> FinancepricingbinomialNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialNode::add(self : FinancepricingbinomialNode, other : FinancepricingbinomialNode) -> FinancepricingbinomialNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialNode::copy(self : FinancepricingbinomialNode) -> FinancepricingbinomialNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialNode::fill(self : FinancepricingbinomialNode, v : Double) -> FinancepricingbinomialNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialNode::min(self : FinancepricingbinomialNode) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialNode::max(self : FinancepricingbinomialNode) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialNode::to_string(self : FinancepricingbinomialNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_edge_make(size : Int) -> FinancepricingbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialEdge::len(self : FinancepricingbinomialEdge) -> Int { self.size }

pub fn FinancepricingbinomialEdge::get(self : FinancepricingbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialEdge::set(self : FinancepricingbinomialEdge, i : Int, v : Double) -> FinancepricingbinomialEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialEdge::sum(self : FinancepricingbinomialEdge) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialEdge::mean(self : FinancepricingbinomialEdge) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialEdge::scale(self : FinancepricingbinomialEdge, f : Double) -> FinancepricingbinomialEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialEdge::add(self : FinancepricingbinomialEdge, other : FinancepricingbinomialEdge) -> FinancepricingbinomialEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialEdge::copy(self : FinancepricingbinomialEdge) -> FinancepricingbinomialEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialEdge::fill(self : FinancepricingbinomialEdge, v : Double) -> FinancepricingbinomialEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialEdge::min(self : FinancepricingbinomialEdge) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialEdge::max(self : FinancepricingbinomialEdge) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialEdge::to_string(self : FinancepricingbinomialEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_path_make(size : Int) -> FinancepricingbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialPath::len(self : FinancepricingbinomialPath) -> Int { self.size }

pub fn FinancepricingbinomialPath::get(self : FinancepricingbinomialPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialPath::set(self : FinancepricingbinomialPath, i : Int, v : Double) -> FinancepricingbinomialPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialPath::sum(self : FinancepricingbinomialPath) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialPath::mean(self : FinancepricingbinomialPath) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialPath::scale(self : FinancepricingbinomialPath, f : Double) -> FinancepricingbinomialPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialPath::add(self : FinancepricingbinomialPath, other : FinancepricingbinomialPath) -> FinancepricingbinomialPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialPath::copy(self : FinancepricingbinomialPath) -> FinancepricingbinomialPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialPath::fill(self : FinancepricingbinomialPath, v : Double) -> FinancepricingbinomialPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialPath::min(self : FinancepricingbinomialPath) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialPath::max(self : FinancepricingbinomialPath) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialPath::to_string(self : FinancepricingbinomialPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_cluster_make(size : Int) -> FinancepricingbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialCluster::len(self : FinancepricingbinomialCluster) -> Int { self.size }

pub fn FinancepricingbinomialCluster::get(self : FinancepricingbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialCluster::set(self : FinancepricingbinomialCluster, i : Int, v : Double) -> FinancepricingbinomialCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialCluster::sum(self : FinancepricingbinomialCluster) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialCluster::mean(self : FinancepricingbinomialCluster) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialCluster::scale(self : FinancepricingbinomialCluster, f : Double) -> FinancepricingbinomialCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialCluster::add(self : FinancepricingbinomialCluster, other : FinancepricingbinomialCluster) -> FinancepricingbinomialCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialCluster::copy(self : FinancepricingbinomialCluster) -> FinancepricingbinomialCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialCluster::fill(self : FinancepricingbinomialCluster, v : Double) -> FinancepricingbinomialCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialCluster::min(self : FinancepricingbinomialCluster) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialCluster::max(self : FinancepricingbinomialCluster) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialCluster::to_string(self : FinancepricingbinomialCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_model_make(size : Int) -> FinancepricingbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialModel::len(self : FinancepricingbinomialModel) -> Int { self.size }

pub fn FinancepricingbinomialModel::get(self : FinancepricingbinomialModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialModel::set(self : FinancepricingbinomialModel, i : Int, v : Double) -> FinancepricingbinomialModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialModel::sum(self : FinancepricingbinomialModel) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialModel::mean(self : FinancepricingbinomialModel) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialModel::scale(self : FinancepricingbinomialModel, f : Double) -> FinancepricingbinomialModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialModel::add(self : FinancepricingbinomialModel, other : FinancepricingbinomialModel) -> FinancepricingbinomialModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialModel::copy(self : FinancepricingbinomialModel) -> FinancepricingbinomialModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialModel::fill(self : FinancepricingbinomialModel, v : Double) -> FinancepricingbinomialModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialModel::min(self : FinancepricingbinomialModel) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialModel::max(self : FinancepricingbinomialModel) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialModel::to_string(self : FinancepricingbinomialModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_layer_make(size : Int) -> FinancepricingbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialLayer::len(self : FinancepricingbinomialLayer) -> Int { self.size }

pub fn FinancepricingbinomialLayer::get(self : FinancepricingbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialLayer::set(self : FinancepricingbinomialLayer, i : Int, v : Double) -> FinancepricingbinomialLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialLayer::sum(self : FinancepricingbinomialLayer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialLayer::mean(self : FinancepricingbinomialLayer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialLayer::scale(self : FinancepricingbinomialLayer, f : Double) -> FinancepricingbinomialLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialLayer::add(self : FinancepricingbinomialLayer, other : FinancepricingbinomialLayer) -> FinancepricingbinomialLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialLayer::copy(self : FinancepricingbinomialLayer) -> FinancepricingbinomialLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialLayer::fill(self : FinancepricingbinomialLayer, v : Double) -> FinancepricingbinomialLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialLayer::min(self : FinancepricingbinomialLayer) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialLayer::max(self : FinancepricingbinomialLayer) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialLayer::to_string(self : FinancepricingbinomialLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_buffer_make(size : Int) -> FinancepricingbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialBuffer::len(self : FinancepricingbinomialBuffer) -> Int { self.size }

pub fn FinancepricingbinomialBuffer::get(self : FinancepricingbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialBuffer::set(self : FinancepricingbinomialBuffer, i : Int, v : Double) -> FinancepricingbinomialBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialBuffer::sum(self : FinancepricingbinomialBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialBuffer::mean(self : FinancepricingbinomialBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialBuffer::scale(self : FinancepricingbinomialBuffer, f : Double) -> FinancepricingbinomialBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialBuffer::add(self : FinancepricingbinomialBuffer, other : FinancepricingbinomialBuffer) -> FinancepricingbinomialBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialBuffer::copy(self : FinancepricingbinomialBuffer) -> FinancepricingbinomialBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialBuffer::fill(self : FinancepricingbinomialBuffer, v : Double) -> FinancepricingbinomialBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialBuffer::min(self : FinancepricingbinomialBuffer) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialBuffer::max(self : FinancepricingbinomialBuffer) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialBuffer::to_string(self : FinancepricingbinomialBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_cursor_make(size : Int) -> FinancepricingbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialCursor::len(self : FinancepricingbinomialCursor) -> Int { self.size }

pub fn FinancepricingbinomialCursor::get(self : FinancepricingbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialCursor::set(self : FinancepricingbinomialCursor, i : Int, v : Double) -> FinancepricingbinomialCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialCursor::sum(self : FinancepricingbinomialCursor) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialCursor::mean(self : FinancepricingbinomialCursor) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialCursor::scale(self : FinancepricingbinomialCursor, f : Double) -> FinancepricingbinomialCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialCursor::add(self : FinancepricingbinomialCursor, other : FinancepricingbinomialCursor) -> FinancepricingbinomialCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialCursor::copy(self : FinancepricingbinomialCursor) -> FinancepricingbinomialCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialCursor::fill(self : FinancepricingbinomialCursor, v : Double) -> FinancepricingbinomialCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialCursor::min(self : FinancepricingbinomialCursor) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialCursor::max(self : FinancepricingbinomialCursor) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialCursor::to_string(self : FinancepricingbinomialCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_view_make(size : Int) -> FinancepricingbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialView::len(self : FinancepricingbinomialView) -> Int { self.size }

pub fn FinancepricingbinomialView::get(self : FinancepricingbinomialView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialView::set(self : FinancepricingbinomialView, i : Int, v : Double) -> FinancepricingbinomialView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialView::sum(self : FinancepricingbinomialView) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialView::mean(self : FinancepricingbinomialView) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialView::scale(self : FinancepricingbinomialView, f : Double) -> FinancepricingbinomialView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialView::add(self : FinancepricingbinomialView, other : FinancepricingbinomialView) -> FinancepricingbinomialView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialView::copy(self : FinancepricingbinomialView) -> FinancepricingbinomialView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialView::fill(self : FinancepricingbinomialView, v : Double) -> FinancepricingbinomialView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialView::min(self : FinancepricingbinomialView) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialView::max(self : FinancepricingbinomialView) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialView::to_string(self : FinancepricingbinomialView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_range_make(size : Int) -> FinancepricingbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialRange::len(self : FinancepricingbinomialRange) -> Int { self.size }

pub fn FinancepricingbinomialRange::get(self : FinancepricingbinomialRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialRange::set(self : FinancepricingbinomialRange, i : Int, v : Double) -> FinancepricingbinomialRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialRange::sum(self : FinancepricingbinomialRange) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialRange::mean(self : FinancepricingbinomialRange) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialRange::scale(self : FinancepricingbinomialRange, f : Double) -> FinancepricingbinomialRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialRange::add(self : FinancepricingbinomialRange, other : FinancepricingbinomialRange) -> FinancepricingbinomialRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialRange::copy(self : FinancepricingbinomialRange) -> FinancepricingbinomialRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialRange::fill(self : FinancepricingbinomialRange, v : Double) -> FinancepricingbinomialRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialRange::min(self : FinancepricingbinomialRange) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialRange::max(self : FinancepricingbinomialRange) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialRange::to_string(self : FinancepricingbinomialRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_slice_make(size : Int) -> FinancepricingbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingbinomialSlice::len(self : FinancepricingbinomialSlice) -> Int { self.size }

pub fn FinancepricingbinomialSlice::get(self : FinancepricingbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingbinomialSlice::set(self : FinancepricingbinomialSlice, i : Int, v : Double) -> FinancepricingbinomialSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialSlice::sum(self : FinancepricingbinomialSlice) -> Double { @_common.sum(self.data) }

pub fn FinancepricingbinomialSlice::mean(self : FinancepricingbinomialSlice) -> Double { @_common.mean(self.data) }

pub fn FinancepricingbinomialSlice::scale(self : FinancepricingbinomialSlice, f : Double) -> FinancepricingbinomialSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialSlice::add(self : FinancepricingbinomialSlice, other : FinancepricingbinomialSlice) -> FinancepricingbinomialSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingbinomialSlice::copy(self : FinancepricingbinomialSlice) -> FinancepricingbinomialSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialSlice::fill(self : FinancepricingbinomialSlice, v : Double) -> FinancepricingbinomialSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingbinomialSlice::min(self : FinancepricingbinomialSlice) -> Double { @_common.min(self.data) }

pub fn FinancepricingbinomialSlice::max(self : FinancepricingbinomialSlice) -> Double { @_common.max(self.data) }

pub fn FinancepricingbinomialSlice::to_string(self : FinancepricingbinomialSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

