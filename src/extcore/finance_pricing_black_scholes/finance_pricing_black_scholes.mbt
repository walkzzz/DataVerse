///===
/// extcore/finance_pricing_black_scholes

pub(all) struct FinancepricingblackscholesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_black_scholes_make_point(x : Double, y : Double) -> FinancepricingblackscholesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_black_scholes_make_point3(x : Double, y : Double, z : Double) -> FinancepricingblackscholesPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingblackscholesPoint::x(self : FinancepricingblackscholesPoint) -> Double { self.x }

pub fn FinancepricingblackscholesPoint::y(self : FinancepricingblackscholesPoint) -> Double { self.y }

pub fn FinancepricingblackscholesPoint::z(self : FinancepricingblackscholesPoint) -> Double { self.z }

pub fn FinancepricingblackscholesPoint::label(self : FinancepricingblackscholesPoint) -> Int { self.label }

pub fn FinancepricingblackscholesPoint::dist(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingblackscholesPoint::add(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingblackscholesPoint::sub(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingblackscholesPoint::scale(self : FinancepricingblackscholesPoint, s : Double) -> FinancepricingblackscholesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingblackscholesPoint::dot(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingblackscholesPoint::cross(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingblackscholesPoint::norm(self : FinancepricingblackscholesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingblackscholesPoint::normalize(self : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingblackscholesPoint::negate(self : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingblackscholesPoint::mid(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingblackscholesPoint::lerp(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint, t : Double) -> FinancepricingblackscholesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingblackscholesPoint::to_string(self : FinancepricingblackscholesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_black_scholes_make_series(vals : Array[Double], name : String) -> FinancepricingblackscholesSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingblackscholesSeries::len(self : FinancepricingblackscholesSeries) -> Int { self.vals.length() }

pub fn FinancepricingblackscholesSeries::sum(self : FinancepricingblackscholesSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingblackscholesSeries::mean(self : FinancepricingblackscholesSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingblackscholesSeries::min(self : FinancepricingblackscholesSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingblackscholesSeries::max(self : FinancepricingblackscholesSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingblackscholesSeries::range(self : FinancepricingblackscholesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingblackscholesSeries::variance(self : FinancepricingblackscholesSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingblackscholesSeries::std(self : FinancepricingblackscholesSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingblackscholesSeries::median(self : FinancepricingblackscholesSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingblackscholesSeries::scale(self : FinancepricingblackscholesSeries, f : Double) -> FinancepricingblackscholesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingblackscholesSeries::add(self : FinancepricingblackscholesSeries, other : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingblackscholesSeries::sub(self : FinancepricingblackscholesSeries, other : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingblackscholesSeries::normalize(self : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingblackscholesSeries::cumsum(self : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingblackscholesSeries::to_string(self : FinancepricingblackscholesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingblackscholesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_black_scholes_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingblackscholesMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn finance_pricing_black_scholes_matrix_identity(n : Int) -> FinancepricingblackscholesMatrix {
  let m = finance_pricing_black_scholes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingblackscholesMatrix::get(self : FinancepricingblackscholesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingblackscholesMatrix::transpose(self : FinancepricingblackscholesMatrix) -> FinancepricingblackscholesMatrix {
  let result = finance_pricing_black_scholes_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingblackscholesMatrix::add(self : FinancepricingblackscholesMatrix, other : FinancepricingblackscholesMatrix) -> FinancepricingblackscholesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_black_scholes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingblackscholesMatrix::scale(self : FinancepricingblackscholesMatrix, s : Double) -> FinancepricingblackscholesMatrix {
  let result = finance_pricing_black_scholes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingblackscholesMatrix::multiply(self : FinancepricingblackscholesMatrix, other : FinancepricingblackscholesMatrix) -> FinancepricingblackscholesMatrix {
  if self.cols != other.rows { return finance_pricing_black_scholes_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_black_scholes_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn FinancepricingblackscholesMatrix::trace(self : FinancepricingblackscholesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingblackscholesMatrix::det(self : FinancepricingblackscholesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingblackscholesMatrix::norm(self : FinancepricingblackscholesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingblackscholesMatrix::to_string(self : FinancepricingblackscholesMatrix) -> String {
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

pub(all) struct FinancepricingblackscholesVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_black_scholes_make_vector(comps : Array[Double]) -> FinancepricingblackscholesVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_black_scholes_vector_zero(dim : Int) -> FinancepricingblackscholesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingblackscholesVector::add(self : FinancepricingblackscholesVector, other : FinancepricingblackscholesVector) -> FinancepricingblackscholesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingblackscholesVector::sub(self : FinancepricingblackscholesVector, other : FinancepricingblackscholesVector) -> FinancepricingblackscholesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingblackscholesVector::scale(self : FinancepricingblackscholesVector, s : Double) -> FinancepricingblackscholesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingblackscholesVector::dot(self : FinancepricingblackscholesVector, other : FinancepricingblackscholesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingblackscholesVector::norm(self : FinancepricingblackscholesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingblackscholesVector::normalize(self : FinancepricingblackscholesVector) -> FinancepricingblackscholesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingblackscholesVector::dist(self : FinancepricingblackscholesVector, other : FinancepricingblackscholesVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingblackscholesVector::to_string(self : FinancepricingblackscholesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingblackscholesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_frame_make(size : Int) -> FinancepricingblackscholesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesFrame::len(self : FinancepricingblackscholesFrame) -> Int { self.size }

pub fn FinancepricingblackscholesFrame::get(self : FinancepricingblackscholesFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesFrame::set(self : FinancepricingblackscholesFrame, i : Int, v : Double) -> FinancepricingblackscholesFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesFrame::sum(self : FinancepricingblackscholesFrame) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesFrame::mean(self : FinancepricingblackscholesFrame) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesFrame::scale(self : FinancepricingblackscholesFrame, f : Double) -> FinancepricingblackscholesFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesFrame::add(self : FinancepricingblackscholesFrame, other : FinancepricingblackscholesFrame) -> FinancepricingblackscholesFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesFrame::copy(self : FinancepricingblackscholesFrame) -> FinancepricingblackscholesFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesFrame::fill(self : FinancepricingblackscholesFrame, v : Double) -> FinancepricingblackscholesFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesFrame::min(self : FinancepricingblackscholesFrame) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesFrame::max(self : FinancepricingblackscholesFrame) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesFrame::to_string(self : FinancepricingblackscholesFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_table_make(size : Int) -> FinancepricingblackscholesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesTable::len(self : FinancepricingblackscholesTable) -> Int { self.size }

pub fn FinancepricingblackscholesTable::get(self : FinancepricingblackscholesTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesTable::set(self : FinancepricingblackscholesTable, i : Int, v : Double) -> FinancepricingblackscholesTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesTable::sum(self : FinancepricingblackscholesTable) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesTable::mean(self : FinancepricingblackscholesTable) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesTable::scale(self : FinancepricingblackscholesTable, f : Double) -> FinancepricingblackscholesTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesTable::add(self : FinancepricingblackscholesTable, other : FinancepricingblackscholesTable) -> FinancepricingblackscholesTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesTable::copy(self : FinancepricingblackscholesTable) -> FinancepricingblackscholesTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesTable::fill(self : FinancepricingblackscholesTable, v : Double) -> FinancepricingblackscholesTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesTable::min(self : FinancepricingblackscholesTable) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesTable::max(self : FinancepricingblackscholesTable) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesTable::to_string(self : FinancepricingblackscholesTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_graphn_make(size : Int) -> FinancepricingblackscholesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesGraphN::len(self : FinancepricingblackscholesGraphN) -> Int { self.size }

pub fn FinancepricingblackscholesGraphN::get(self : FinancepricingblackscholesGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesGraphN::set(self : FinancepricingblackscholesGraphN, i : Int, v : Double) -> FinancepricingblackscholesGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesGraphN::sum(self : FinancepricingblackscholesGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesGraphN::mean(self : FinancepricingblackscholesGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesGraphN::scale(self : FinancepricingblackscholesGraphN, f : Double) -> FinancepricingblackscholesGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesGraphN::add(self : FinancepricingblackscholesGraphN, other : FinancepricingblackscholesGraphN) -> FinancepricingblackscholesGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesGraphN::copy(self : FinancepricingblackscholesGraphN) -> FinancepricingblackscholesGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesGraphN::fill(self : FinancepricingblackscholesGraphN, v : Double) -> FinancepricingblackscholesGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesGraphN::min(self : FinancepricingblackscholesGraphN) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesGraphN::max(self : FinancepricingblackscholesGraphN) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesGraphN::to_string(self : FinancepricingblackscholesGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_node_make(size : Int) -> FinancepricingblackscholesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesNode::len(self : FinancepricingblackscholesNode) -> Int { self.size }

pub fn FinancepricingblackscholesNode::get(self : FinancepricingblackscholesNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesNode::set(self : FinancepricingblackscholesNode, i : Int, v : Double) -> FinancepricingblackscholesNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesNode::sum(self : FinancepricingblackscholesNode) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesNode::mean(self : FinancepricingblackscholesNode) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesNode::scale(self : FinancepricingblackscholesNode, f : Double) -> FinancepricingblackscholesNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesNode::add(self : FinancepricingblackscholesNode, other : FinancepricingblackscholesNode) -> FinancepricingblackscholesNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesNode::copy(self : FinancepricingblackscholesNode) -> FinancepricingblackscholesNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesNode::fill(self : FinancepricingblackscholesNode, v : Double) -> FinancepricingblackscholesNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesNode::min(self : FinancepricingblackscholesNode) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesNode::max(self : FinancepricingblackscholesNode) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesNode::to_string(self : FinancepricingblackscholesNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_edge_make(size : Int) -> FinancepricingblackscholesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesEdge::len(self : FinancepricingblackscholesEdge) -> Int { self.size }

pub fn FinancepricingblackscholesEdge::get(self : FinancepricingblackscholesEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesEdge::set(self : FinancepricingblackscholesEdge, i : Int, v : Double) -> FinancepricingblackscholesEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesEdge::sum(self : FinancepricingblackscholesEdge) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesEdge::mean(self : FinancepricingblackscholesEdge) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesEdge::scale(self : FinancepricingblackscholesEdge, f : Double) -> FinancepricingblackscholesEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesEdge::add(self : FinancepricingblackscholesEdge, other : FinancepricingblackscholesEdge) -> FinancepricingblackscholesEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesEdge::copy(self : FinancepricingblackscholesEdge) -> FinancepricingblackscholesEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesEdge::fill(self : FinancepricingblackscholesEdge, v : Double) -> FinancepricingblackscholesEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesEdge::min(self : FinancepricingblackscholesEdge) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesEdge::max(self : FinancepricingblackscholesEdge) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesEdge::to_string(self : FinancepricingblackscholesEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_path_make(size : Int) -> FinancepricingblackscholesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesPath::len(self : FinancepricingblackscholesPath) -> Int { self.size }

pub fn FinancepricingblackscholesPath::get(self : FinancepricingblackscholesPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesPath::set(self : FinancepricingblackscholesPath, i : Int, v : Double) -> FinancepricingblackscholesPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesPath::sum(self : FinancepricingblackscholesPath) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesPath::mean(self : FinancepricingblackscholesPath) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesPath::scale(self : FinancepricingblackscholesPath, f : Double) -> FinancepricingblackscholesPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesPath::add(self : FinancepricingblackscholesPath, other : FinancepricingblackscholesPath) -> FinancepricingblackscholesPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesPath::copy(self : FinancepricingblackscholesPath) -> FinancepricingblackscholesPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesPath::fill(self : FinancepricingblackscholesPath, v : Double) -> FinancepricingblackscholesPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesPath::min(self : FinancepricingblackscholesPath) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesPath::max(self : FinancepricingblackscholesPath) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesPath::to_string(self : FinancepricingblackscholesPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_cluster_make(size : Int) -> FinancepricingblackscholesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesCluster::len(self : FinancepricingblackscholesCluster) -> Int { self.size }

pub fn FinancepricingblackscholesCluster::get(self : FinancepricingblackscholesCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesCluster::set(self : FinancepricingblackscholesCluster, i : Int, v : Double) -> FinancepricingblackscholesCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesCluster::sum(self : FinancepricingblackscholesCluster) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesCluster::mean(self : FinancepricingblackscholesCluster) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesCluster::scale(self : FinancepricingblackscholesCluster, f : Double) -> FinancepricingblackscholesCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesCluster::add(self : FinancepricingblackscholesCluster, other : FinancepricingblackscholesCluster) -> FinancepricingblackscholesCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesCluster::copy(self : FinancepricingblackscholesCluster) -> FinancepricingblackscholesCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesCluster::fill(self : FinancepricingblackscholesCluster, v : Double) -> FinancepricingblackscholesCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesCluster::min(self : FinancepricingblackscholesCluster) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesCluster::max(self : FinancepricingblackscholesCluster) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesCluster::to_string(self : FinancepricingblackscholesCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_model_make(size : Int) -> FinancepricingblackscholesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesModel::len(self : FinancepricingblackscholesModel) -> Int { self.size }

pub fn FinancepricingblackscholesModel::get(self : FinancepricingblackscholesModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesModel::set(self : FinancepricingblackscholesModel, i : Int, v : Double) -> FinancepricingblackscholesModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesModel::sum(self : FinancepricingblackscholesModel) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesModel::mean(self : FinancepricingblackscholesModel) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesModel::scale(self : FinancepricingblackscholesModel, f : Double) -> FinancepricingblackscholesModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesModel::add(self : FinancepricingblackscholesModel, other : FinancepricingblackscholesModel) -> FinancepricingblackscholesModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesModel::copy(self : FinancepricingblackscholesModel) -> FinancepricingblackscholesModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesModel::fill(self : FinancepricingblackscholesModel, v : Double) -> FinancepricingblackscholesModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesModel::min(self : FinancepricingblackscholesModel) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesModel::max(self : FinancepricingblackscholesModel) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesModel::to_string(self : FinancepricingblackscholesModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_layer_make(size : Int) -> FinancepricingblackscholesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesLayer::len(self : FinancepricingblackscholesLayer) -> Int { self.size }

pub fn FinancepricingblackscholesLayer::get(self : FinancepricingblackscholesLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesLayer::set(self : FinancepricingblackscholesLayer, i : Int, v : Double) -> FinancepricingblackscholesLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesLayer::sum(self : FinancepricingblackscholesLayer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesLayer::mean(self : FinancepricingblackscholesLayer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesLayer::scale(self : FinancepricingblackscholesLayer, f : Double) -> FinancepricingblackscholesLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesLayer::add(self : FinancepricingblackscholesLayer, other : FinancepricingblackscholesLayer) -> FinancepricingblackscholesLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesLayer::copy(self : FinancepricingblackscholesLayer) -> FinancepricingblackscholesLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesLayer::fill(self : FinancepricingblackscholesLayer, v : Double) -> FinancepricingblackscholesLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesLayer::min(self : FinancepricingblackscholesLayer) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesLayer::max(self : FinancepricingblackscholesLayer) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesLayer::to_string(self : FinancepricingblackscholesLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_buffer_make(size : Int) -> FinancepricingblackscholesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesBuffer::len(self : FinancepricingblackscholesBuffer) -> Int { self.size }

pub fn FinancepricingblackscholesBuffer::get(self : FinancepricingblackscholesBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesBuffer::set(self : FinancepricingblackscholesBuffer, i : Int, v : Double) -> FinancepricingblackscholesBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesBuffer::sum(self : FinancepricingblackscholesBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesBuffer::mean(self : FinancepricingblackscholesBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesBuffer::scale(self : FinancepricingblackscholesBuffer, f : Double) -> FinancepricingblackscholesBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesBuffer::add(self : FinancepricingblackscholesBuffer, other : FinancepricingblackscholesBuffer) -> FinancepricingblackscholesBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesBuffer::copy(self : FinancepricingblackscholesBuffer) -> FinancepricingblackscholesBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesBuffer::fill(self : FinancepricingblackscholesBuffer, v : Double) -> FinancepricingblackscholesBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesBuffer::min(self : FinancepricingblackscholesBuffer) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesBuffer::max(self : FinancepricingblackscholesBuffer) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesBuffer::to_string(self : FinancepricingblackscholesBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_cursor_make(size : Int) -> FinancepricingblackscholesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesCursor::len(self : FinancepricingblackscholesCursor) -> Int { self.size }

pub fn FinancepricingblackscholesCursor::get(self : FinancepricingblackscholesCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesCursor::set(self : FinancepricingblackscholesCursor, i : Int, v : Double) -> FinancepricingblackscholesCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesCursor::sum(self : FinancepricingblackscholesCursor) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesCursor::mean(self : FinancepricingblackscholesCursor) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesCursor::scale(self : FinancepricingblackscholesCursor, f : Double) -> FinancepricingblackscholesCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesCursor::add(self : FinancepricingblackscholesCursor, other : FinancepricingblackscholesCursor) -> FinancepricingblackscholesCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesCursor::copy(self : FinancepricingblackscholesCursor) -> FinancepricingblackscholesCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesCursor::fill(self : FinancepricingblackscholesCursor, v : Double) -> FinancepricingblackscholesCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesCursor::min(self : FinancepricingblackscholesCursor) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesCursor::max(self : FinancepricingblackscholesCursor) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesCursor::to_string(self : FinancepricingblackscholesCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_view_make(size : Int) -> FinancepricingblackscholesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesView::len(self : FinancepricingblackscholesView) -> Int { self.size }

pub fn FinancepricingblackscholesView::get(self : FinancepricingblackscholesView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesView::set(self : FinancepricingblackscholesView, i : Int, v : Double) -> FinancepricingblackscholesView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesView::sum(self : FinancepricingblackscholesView) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesView::mean(self : FinancepricingblackscholesView) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesView::scale(self : FinancepricingblackscholesView, f : Double) -> FinancepricingblackscholesView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesView::add(self : FinancepricingblackscholesView, other : FinancepricingblackscholesView) -> FinancepricingblackscholesView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesView::copy(self : FinancepricingblackscholesView) -> FinancepricingblackscholesView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesView::fill(self : FinancepricingblackscholesView, v : Double) -> FinancepricingblackscholesView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesView::min(self : FinancepricingblackscholesView) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesView::max(self : FinancepricingblackscholesView) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesView::to_string(self : FinancepricingblackscholesView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_range_make(size : Int) -> FinancepricingblackscholesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesRange::len(self : FinancepricingblackscholesRange) -> Int { self.size }

pub fn FinancepricingblackscholesRange::get(self : FinancepricingblackscholesRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesRange::set(self : FinancepricingblackscholesRange, i : Int, v : Double) -> FinancepricingblackscholesRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesRange::sum(self : FinancepricingblackscholesRange) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesRange::mean(self : FinancepricingblackscholesRange) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesRange::scale(self : FinancepricingblackscholesRange, f : Double) -> FinancepricingblackscholesRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesRange::add(self : FinancepricingblackscholesRange, other : FinancepricingblackscholesRange) -> FinancepricingblackscholesRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesRange::copy(self : FinancepricingblackscholesRange) -> FinancepricingblackscholesRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesRange::fill(self : FinancepricingblackscholesRange, v : Double) -> FinancepricingblackscholesRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesRange::min(self : FinancepricingblackscholesRange) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesRange::max(self : FinancepricingblackscholesRange) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesRange::to_string(self : FinancepricingblackscholesRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_slice_make(size : Int) -> FinancepricingblackscholesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingblackscholesSlice::len(self : FinancepricingblackscholesSlice) -> Int { self.size }

pub fn FinancepricingblackscholesSlice::get(self : FinancepricingblackscholesSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingblackscholesSlice::set(self : FinancepricingblackscholesSlice, i : Int, v : Double) -> FinancepricingblackscholesSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesSlice::sum(self : FinancepricingblackscholesSlice) -> Double { @_common.sum(self.data) }

pub fn FinancepricingblackscholesSlice::mean(self : FinancepricingblackscholesSlice) -> Double { @_common.mean(self.data) }

pub fn FinancepricingblackscholesSlice::scale(self : FinancepricingblackscholesSlice, f : Double) -> FinancepricingblackscholesSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesSlice::add(self : FinancepricingblackscholesSlice, other : FinancepricingblackscholesSlice) -> FinancepricingblackscholesSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingblackscholesSlice::copy(self : FinancepricingblackscholesSlice) -> FinancepricingblackscholesSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesSlice::fill(self : FinancepricingblackscholesSlice, v : Double) -> FinancepricingblackscholesSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingblackscholesSlice::min(self : FinancepricingblackscholesSlice) -> Double { @_common.min(self.data) }

pub fn FinancepricingblackscholesSlice::max(self : FinancepricingblackscholesSlice) -> Double { @_common.max(self.data) }

pub fn FinancepricingblackscholesSlice::to_string(self : FinancepricingblackscholesSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

