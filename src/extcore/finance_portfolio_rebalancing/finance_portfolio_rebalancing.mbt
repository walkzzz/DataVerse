///|
///===
/// extcore/finance_portfolio_rebalancing
pub(all) struct FinanceportfoliorebalancingPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_portfolio_rebalancing_make_point(
  x : Double,
  y : Double,
) -> FinanceportfoliorebalancingPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_portfolio_rebalancing_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinanceportfoliorebalancingPoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinanceportfoliorebalancingPoint::x(
  self : FinanceportfoliorebalancingPoint,
) -> Double {
  self.x
}

///|
pub fn FinanceportfoliorebalancingPoint::y(
  self : FinanceportfoliorebalancingPoint,
) -> Double {
  self.y
}

///|
pub fn FinanceportfoliorebalancingPoint::z(
  self : FinanceportfoliorebalancingPoint,
) -> Double {
  self.z
}

///|
pub fn FinanceportfoliorebalancingPoint::label(
  self : FinanceportfoliorebalancingPoint,
) -> Int32 {
  self.label
}

///|
pub fn FinanceportfoliorebalancingPoint::dist(
  self : FinanceportfoliorebalancingPoint,
  other : FinanceportfoliorebalancingPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinanceportfoliorebalancingPoint::add(
  self : FinanceportfoliorebalancingPoint,
  other : FinanceportfoliorebalancingPoint,
) -> FinanceportfoliorebalancingPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliorebalancingPoint::sub(
  self : FinanceportfoliorebalancingPoint,
  other : FinanceportfoliorebalancingPoint,
) -> FinanceportfoliorebalancingPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliorebalancingPoint::scale(
  self : FinanceportfoliorebalancingPoint,
  s : Double,
) -> FinanceportfoliorebalancingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinanceportfoliorebalancingPoint::dot(
  self : FinanceportfoliorebalancingPoint,
  other : FinanceportfoliorebalancingPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinanceportfoliorebalancingPoint::cross(
  self : FinanceportfoliorebalancingPoint,
  other : FinanceportfoliorebalancingPoint,
) -> FinanceportfoliorebalancingPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinanceportfoliorebalancingPoint::norm(
  self : FinanceportfoliorebalancingPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinanceportfoliorebalancingPoint::normalize(
  self : FinanceportfoliorebalancingPoint,
) -> FinanceportfoliorebalancingPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceportfoliorebalancingPoint::negate(
  self : FinanceportfoliorebalancingPoint,
) -> FinanceportfoliorebalancingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinanceportfoliorebalancingPoint::mid(
  self : FinanceportfoliorebalancingPoint,
  other : FinanceportfoliorebalancingPoint,
) -> FinanceportfoliorebalancingPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliorebalancingPoint::lerp(
  self : FinanceportfoliorebalancingPoint,
  other : FinanceportfoliorebalancingPoint,
  t : Double,
) -> FinanceportfoliorebalancingPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliorebalancingPoint::to_string(
  self : FinanceportfoliorebalancingPoint,
) -> String {
  "(" +
  @_common.dbl(self.x) +
  ", " +
  @_common.dbl(self.y) +
  ", " +
  @_common.dbl(self.z) +
  ")[" +
  self.label.to_string() +
  "]"
}

///|
pub(all) struct FinanceportfoliorebalancingSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_portfolio_rebalancing_make_series(
  vals : Array[Double],
  name : String,
) -> FinanceportfoliorebalancingSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinanceportfoliorebalancingSeries::len(
  self : FinanceportfoliorebalancingSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn FinanceportfoliorebalancingSeries::sum(
  self : FinanceportfoliorebalancingSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinanceportfoliorebalancingSeries::mean(
  self : FinanceportfoliorebalancingSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinanceportfoliorebalancingSeries::min(
  self : FinanceportfoliorebalancingSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinanceportfoliorebalancingSeries::max(
  self : FinanceportfoliorebalancingSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinanceportfoliorebalancingSeries::range(
  self : FinanceportfoliorebalancingSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinanceportfoliorebalancingSeries::variance(
  self : FinanceportfoliorebalancingSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinanceportfoliorebalancingSeries::std(
  self : FinanceportfoliorebalancingSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinanceportfoliorebalancingSeries::median(
  self : FinanceportfoliorebalancingSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinanceportfoliorebalancingSeries::scale(
  self : FinanceportfoliorebalancingSeries,
  f : Double,
) -> FinanceportfoliorebalancingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinanceportfoliorebalancingSeries::add(
  self : FinanceportfoliorebalancingSeries,
  other : FinanceportfoliorebalancingSeries,
) -> FinanceportfoliorebalancingSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceportfoliorebalancingSeries::sub(
  self : FinanceportfoliorebalancingSeries,
  other : FinanceportfoliorebalancingSeries,
) -> FinanceportfoliorebalancingSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceportfoliorebalancingSeries::normalize(
  self : FinanceportfoliorebalancingSeries,
) -> FinanceportfoliorebalancingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 {
    self
  } else {
    let result = []
    for i in 0..<self.vals.length() {
      result.push((self.vals[i] - mn) / r)
    }
    { vals: result, name: self.name, meta: self.meta, }
  }
}

///|
pub fn FinanceportfoliorebalancingSeries::cumsum(
  self : FinanceportfoliorebalancingSeries,
) -> FinanceportfoliorebalancingSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinanceportfoliorebalancingSeries::to_string(
  self : FinanceportfoliorebalancingSeries,
) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + @_common.dbl(self.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub(all) struct FinanceportfoliorebalancingMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_portfolio_rebalancing_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinanceportfoliorebalancingMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_portfolio_rebalancing_matrix_identity(
  n : Int32,
) -> FinanceportfoliorebalancingMatrix {
  let m = finance_portfolio_rebalancing_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinanceportfoliorebalancingMatrix::get(
  self : FinanceportfoliorebalancingMatrix,
  i : Int32,
  j : Int32,
) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols {
    0.0
  } else {
    self.data[i][j]
  }
}

///|
pub fn FinanceportfoliorebalancingMatrix::transpose(
  self : FinanceportfoliorebalancingMatrix,
) -> FinanceportfoliorebalancingMatrix {
  let result = finance_portfolio_rebalancing_make_matrix(
    self.cols,
    self.rows,
    0.0,
  )
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceportfoliorebalancingMatrix::add(
  self : FinanceportfoliorebalancingMatrix,
  other : FinanceportfoliorebalancingMatrix,
) -> FinanceportfoliorebalancingMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_portfolio_rebalancing_make_matrix(
    self.rows,
    self.cols,
    0.0,
  )
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceportfoliorebalancingMatrix::scale(
  self : FinanceportfoliorebalancingMatrix,
  s : Double,
) -> FinanceportfoliorebalancingMatrix {
  let result = finance_portfolio_rebalancing_make_matrix(
    self.rows,
    self.cols,
    0.0,
  )
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn FinanceportfoliorebalancingMatrix::multiply(
  self : FinanceportfoliorebalancingMatrix,
  other : FinanceportfoliorebalancingMatrix,
) -> FinanceportfoliorebalancingMatrix {
  if self.cols != other.rows {
    return finance_portfolio_rebalancing_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = finance_portfolio_rebalancing_make_matrix(
    self.rows,
    other.cols,
    0.0,
  )
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols {
        result.data[i][j] = result.data[i][j] + v * other.data[k][j]
      }
    }
  }
  result
}

///|
pub fn FinanceportfoliorebalancingMatrix::trace(
  self : FinanceportfoliorebalancingMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinanceportfoliorebalancingMatrix::det(
  self : FinanceportfoliorebalancingMatrix,
) -> Double {
  if self.rows != self.cols {
    0.0
  } else if self.rows == 1 {
    self.data[0][0]
  } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] *
      (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] *
      (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] *
      (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else {
    0.0
  }
}

///|
pub fn FinanceportfoliorebalancingMatrix::norm(
  self : FinanceportfoliorebalancingMatrix,
) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn FinanceportfoliorebalancingMatrix::to_string(
  self : FinanceportfoliorebalancingMatrix,
) -> String {
  let mut result = "Mat(" +
    self.rows.to_string() +
    "x" +
    self.cols.to_string() +
    ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl {
      if j > 0 {
        result = result + ", "
      }
      result = result + @_common.dbl(self.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub(all) struct FinanceportfoliorebalancingVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_portfolio_rebalancing_make_vector(
  comps : Array[Double],
) -> FinanceportfoliorebalancingVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_portfolio_rebalancing_vector_zero(
  dim : Int32,
) -> FinanceportfoliorebalancingVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinanceportfoliorebalancingVector::add(
  self : FinanceportfoliorebalancingVector,
  other : FinanceportfoliorebalancingVector,
) -> FinanceportfoliorebalancingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceportfoliorebalancingVector::sub(
  self : FinanceportfoliorebalancingVector,
  other : FinanceportfoliorebalancingVector,
) -> FinanceportfoliorebalancingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceportfoliorebalancingVector::scale(
  self : FinanceportfoliorebalancingVector,
  s : Double,
) -> FinanceportfoliorebalancingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinanceportfoliorebalancingVector::dot(
  self : FinanceportfoliorebalancingVector,
  other : FinanceportfoliorebalancingVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinanceportfoliorebalancingVector::norm(
  self : FinanceportfoliorebalancingVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinanceportfoliorebalancingVector::normalize(
  self : FinanceportfoliorebalancingVector,
) -> FinanceportfoliorebalancingVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceportfoliorebalancingVector::dist(
  self : FinanceportfoliorebalancingVector,
  other : FinanceportfoliorebalancingVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinanceportfoliorebalancingVector::to_string(
  self : FinanceportfoliorebalancingVector,
) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + @_common.dbl(self.comps[i])
  }
  if self.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub(all) struct FinanceportfoliorebalancingFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_frame_make(
  size : Int32,
) -> FinanceportfoliorebalancingFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingFrame::len(
  self : FinanceportfoliorebalancingFrame,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingFrame::get(
  self : FinanceportfoliorebalancingFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingFrame::set(
  self : FinanceportfoliorebalancingFrame,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingFrame::sum(
  self : FinanceportfoliorebalancingFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingFrame::mean(
  self : FinanceportfoliorebalancingFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingFrame::scale(
  self : FinanceportfoliorebalancingFrame,
  f : Double,
) -> FinanceportfoliorebalancingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingFrame::add(
  self : FinanceportfoliorebalancingFrame,
  other : FinanceportfoliorebalancingFrame,
) -> FinanceportfoliorebalancingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingFrame::copy(
  self : FinanceportfoliorebalancingFrame,
) -> FinanceportfoliorebalancingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingFrame::fill(
  self : FinanceportfoliorebalancingFrame,
  v : Double,
) -> FinanceportfoliorebalancingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingFrame::min(
  self : FinanceportfoliorebalancingFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingFrame::max(
  self : FinanceportfoliorebalancingFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingFrame::to_string(
  self : FinanceportfoliorebalancingFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_table_make(
  size : Int32,
) -> FinanceportfoliorebalancingTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingTable::len(
  self : FinanceportfoliorebalancingTable,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingTable::get(
  self : FinanceportfoliorebalancingTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingTable::set(
  self : FinanceportfoliorebalancingTable,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingTable::sum(
  self : FinanceportfoliorebalancingTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingTable::mean(
  self : FinanceportfoliorebalancingTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingTable::scale(
  self : FinanceportfoliorebalancingTable,
  f : Double,
) -> FinanceportfoliorebalancingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingTable::add(
  self : FinanceportfoliorebalancingTable,
  other : FinanceportfoliorebalancingTable,
) -> FinanceportfoliorebalancingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingTable::copy(
  self : FinanceportfoliorebalancingTable,
) -> FinanceportfoliorebalancingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingTable::fill(
  self : FinanceportfoliorebalancingTable,
  v : Double,
) -> FinanceportfoliorebalancingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingTable::min(
  self : FinanceportfoliorebalancingTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingTable::max(
  self : FinanceportfoliorebalancingTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingTable::to_string(
  self : FinanceportfoliorebalancingTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_graphn_make(
  size : Int32,
) -> FinanceportfoliorebalancingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingGraphN::len(
  self : FinanceportfoliorebalancingGraphN,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingGraphN::get(
  self : FinanceportfoliorebalancingGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingGraphN::set(
  self : FinanceportfoliorebalancingGraphN,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingGraphN::sum(
  self : FinanceportfoliorebalancingGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingGraphN::mean(
  self : FinanceportfoliorebalancingGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingGraphN::scale(
  self : FinanceportfoliorebalancingGraphN,
  f : Double,
) -> FinanceportfoliorebalancingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingGraphN::add(
  self : FinanceportfoliorebalancingGraphN,
  other : FinanceportfoliorebalancingGraphN,
) -> FinanceportfoliorebalancingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingGraphN::copy(
  self : FinanceportfoliorebalancingGraphN,
) -> FinanceportfoliorebalancingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingGraphN::fill(
  self : FinanceportfoliorebalancingGraphN,
  v : Double,
) -> FinanceportfoliorebalancingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingGraphN::min(
  self : FinanceportfoliorebalancingGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingGraphN::max(
  self : FinanceportfoliorebalancingGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingGraphN::to_string(
  self : FinanceportfoliorebalancingGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_node_make(
  size : Int32,
) -> FinanceportfoliorebalancingNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingNode::len(
  self : FinanceportfoliorebalancingNode,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingNode::get(
  self : FinanceportfoliorebalancingNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingNode::set(
  self : FinanceportfoliorebalancingNode,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingNode::sum(
  self : FinanceportfoliorebalancingNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingNode::mean(
  self : FinanceportfoliorebalancingNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingNode::scale(
  self : FinanceportfoliorebalancingNode,
  f : Double,
) -> FinanceportfoliorebalancingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingNode::add(
  self : FinanceportfoliorebalancingNode,
  other : FinanceportfoliorebalancingNode,
) -> FinanceportfoliorebalancingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingNode::copy(
  self : FinanceportfoliorebalancingNode,
) -> FinanceportfoliorebalancingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingNode::fill(
  self : FinanceportfoliorebalancingNode,
  v : Double,
) -> FinanceportfoliorebalancingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingNode::min(
  self : FinanceportfoliorebalancingNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingNode::max(
  self : FinanceportfoliorebalancingNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingNode::to_string(
  self : FinanceportfoliorebalancingNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_edge_make(
  size : Int32,
) -> FinanceportfoliorebalancingEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingEdge::len(
  self : FinanceportfoliorebalancingEdge,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingEdge::get(
  self : FinanceportfoliorebalancingEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingEdge::set(
  self : FinanceportfoliorebalancingEdge,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingEdge::sum(
  self : FinanceportfoliorebalancingEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingEdge::mean(
  self : FinanceportfoliorebalancingEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingEdge::scale(
  self : FinanceportfoliorebalancingEdge,
  f : Double,
) -> FinanceportfoliorebalancingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingEdge::add(
  self : FinanceportfoliorebalancingEdge,
  other : FinanceportfoliorebalancingEdge,
) -> FinanceportfoliorebalancingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingEdge::copy(
  self : FinanceportfoliorebalancingEdge,
) -> FinanceportfoliorebalancingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingEdge::fill(
  self : FinanceportfoliorebalancingEdge,
  v : Double,
) -> FinanceportfoliorebalancingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingEdge::min(
  self : FinanceportfoliorebalancingEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingEdge::max(
  self : FinanceportfoliorebalancingEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingEdge::to_string(
  self : FinanceportfoliorebalancingEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_path_make(
  size : Int32,
) -> FinanceportfoliorebalancingPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingPath::len(
  self : FinanceportfoliorebalancingPath,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingPath::get(
  self : FinanceportfoliorebalancingPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingPath::set(
  self : FinanceportfoliorebalancingPath,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingPath::sum(
  self : FinanceportfoliorebalancingPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingPath::mean(
  self : FinanceportfoliorebalancingPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingPath::scale(
  self : FinanceportfoliorebalancingPath,
  f : Double,
) -> FinanceportfoliorebalancingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingPath::add(
  self : FinanceportfoliorebalancingPath,
  other : FinanceportfoliorebalancingPath,
) -> FinanceportfoliorebalancingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingPath::copy(
  self : FinanceportfoliorebalancingPath,
) -> FinanceportfoliorebalancingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingPath::fill(
  self : FinanceportfoliorebalancingPath,
  v : Double,
) -> FinanceportfoliorebalancingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingPath::min(
  self : FinanceportfoliorebalancingPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingPath::max(
  self : FinanceportfoliorebalancingPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingPath::to_string(
  self : FinanceportfoliorebalancingPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_cluster_make(
  size : Int32,
) -> FinanceportfoliorebalancingCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingCluster::len(
  self : FinanceportfoliorebalancingCluster,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingCluster::get(
  self : FinanceportfoliorebalancingCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingCluster::set(
  self : FinanceportfoliorebalancingCluster,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingCluster::sum(
  self : FinanceportfoliorebalancingCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingCluster::mean(
  self : FinanceportfoliorebalancingCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingCluster::scale(
  self : FinanceportfoliorebalancingCluster,
  f : Double,
) -> FinanceportfoliorebalancingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingCluster::add(
  self : FinanceportfoliorebalancingCluster,
  other : FinanceportfoliorebalancingCluster,
) -> FinanceportfoliorebalancingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingCluster::copy(
  self : FinanceportfoliorebalancingCluster,
) -> FinanceportfoliorebalancingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingCluster::fill(
  self : FinanceportfoliorebalancingCluster,
  v : Double,
) -> FinanceportfoliorebalancingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingCluster::min(
  self : FinanceportfoliorebalancingCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingCluster::max(
  self : FinanceportfoliorebalancingCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingCluster::to_string(
  self : FinanceportfoliorebalancingCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_model_make(
  size : Int32,
) -> FinanceportfoliorebalancingModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingModel::len(
  self : FinanceportfoliorebalancingModel,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingModel::get(
  self : FinanceportfoliorebalancingModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingModel::set(
  self : FinanceportfoliorebalancingModel,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingModel::sum(
  self : FinanceportfoliorebalancingModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingModel::mean(
  self : FinanceportfoliorebalancingModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingModel::scale(
  self : FinanceportfoliorebalancingModel,
  f : Double,
) -> FinanceportfoliorebalancingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingModel::add(
  self : FinanceportfoliorebalancingModel,
  other : FinanceportfoliorebalancingModel,
) -> FinanceportfoliorebalancingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingModel::copy(
  self : FinanceportfoliorebalancingModel,
) -> FinanceportfoliorebalancingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingModel::fill(
  self : FinanceportfoliorebalancingModel,
  v : Double,
) -> FinanceportfoliorebalancingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingModel::min(
  self : FinanceportfoliorebalancingModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingModel::max(
  self : FinanceportfoliorebalancingModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingModel::to_string(
  self : FinanceportfoliorebalancingModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_layer_make(
  size : Int32,
) -> FinanceportfoliorebalancingLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingLayer::len(
  self : FinanceportfoliorebalancingLayer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingLayer::get(
  self : FinanceportfoliorebalancingLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingLayer::set(
  self : FinanceportfoliorebalancingLayer,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingLayer::sum(
  self : FinanceportfoliorebalancingLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingLayer::mean(
  self : FinanceportfoliorebalancingLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingLayer::scale(
  self : FinanceportfoliorebalancingLayer,
  f : Double,
) -> FinanceportfoliorebalancingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingLayer::add(
  self : FinanceportfoliorebalancingLayer,
  other : FinanceportfoliorebalancingLayer,
) -> FinanceportfoliorebalancingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingLayer::copy(
  self : FinanceportfoliorebalancingLayer,
) -> FinanceportfoliorebalancingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingLayer::fill(
  self : FinanceportfoliorebalancingLayer,
  v : Double,
) -> FinanceportfoliorebalancingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingLayer::min(
  self : FinanceportfoliorebalancingLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingLayer::max(
  self : FinanceportfoliorebalancingLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingLayer::to_string(
  self : FinanceportfoliorebalancingLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_buffer_make(
  size : Int32,
) -> FinanceportfoliorebalancingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingBuffer::len(
  self : FinanceportfoliorebalancingBuffer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingBuffer::get(
  self : FinanceportfoliorebalancingBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingBuffer::set(
  self : FinanceportfoliorebalancingBuffer,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingBuffer::sum(
  self : FinanceportfoliorebalancingBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingBuffer::mean(
  self : FinanceportfoliorebalancingBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingBuffer::scale(
  self : FinanceportfoliorebalancingBuffer,
  f : Double,
) -> FinanceportfoliorebalancingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingBuffer::add(
  self : FinanceportfoliorebalancingBuffer,
  other : FinanceportfoliorebalancingBuffer,
) -> FinanceportfoliorebalancingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingBuffer::copy(
  self : FinanceportfoliorebalancingBuffer,
) -> FinanceportfoliorebalancingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingBuffer::fill(
  self : FinanceportfoliorebalancingBuffer,
  v : Double,
) -> FinanceportfoliorebalancingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingBuffer::min(
  self : FinanceportfoliorebalancingBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingBuffer::max(
  self : FinanceportfoliorebalancingBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingBuffer::to_string(
  self : FinanceportfoliorebalancingBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_cursor_make(
  size : Int32,
) -> FinanceportfoliorebalancingCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingCursor::len(
  self : FinanceportfoliorebalancingCursor,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingCursor::get(
  self : FinanceportfoliorebalancingCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingCursor::set(
  self : FinanceportfoliorebalancingCursor,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingCursor::sum(
  self : FinanceportfoliorebalancingCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingCursor::mean(
  self : FinanceportfoliorebalancingCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingCursor::scale(
  self : FinanceportfoliorebalancingCursor,
  f : Double,
) -> FinanceportfoliorebalancingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingCursor::add(
  self : FinanceportfoliorebalancingCursor,
  other : FinanceportfoliorebalancingCursor,
) -> FinanceportfoliorebalancingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingCursor::copy(
  self : FinanceportfoliorebalancingCursor,
) -> FinanceportfoliorebalancingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingCursor::fill(
  self : FinanceportfoliorebalancingCursor,
  v : Double,
) -> FinanceportfoliorebalancingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingCursor::min(
  self : FinanceportfoliorebalancingCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingCursor::max(
  self : FinanceportfoliorebalancingCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingCursor::to_string(
  self : FinanceportfoliorebalancingCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_view_make(
  size : Int32,
) -> FinanceportfoliorebalancingView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingView::len(
  self : FinanceportfoliorebalancingView,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingView::get(
  self : FinanceportfoliorebalancingView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingView::set(
  self : FinanceportfoliorebalancingView,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingView::sum(
  self : FinanceportfoliorebalancingView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingView::mean(
  self : FinanceportfoliorebalancingView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingView::scale(
  self : FinanceportfoliorebalancingView,
  f : Double,
) -> FinanceportfoliorebalancingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingView::add(
  self : FinanceportfoliorebalancingView,
  other : FinanceportfoliorebalancingView,
) -> FinanceportfoliorebalancingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingView::copy(
  self : FinanceportfoliorebalancingView,
) -> FinanceportfoliorebalancingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingView::fill(
  self : FinanceportfoliorebalancingView,
  v : Double,
) -> FinanceportfoliorebalancingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingView::min(
  self : FinanceportfoliorebalancingView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingView::max(
  self : FinanceportfoliorebalancingView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingView::to_string(
  self : FinanceportfoliorebalancingView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_range_make(
  size : Int32,
) -> FinanceportfoliorebalancingRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingRange::len(
  self : FinanceportfoliorebalancingRange,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingRange::get(
  self : FinanceportfoliorebalancingRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingRange::set(
  self : FinanceportfoliorebalancingRange,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingRange::sum(
  self : FinanceportfoliorebalancingRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingRange::mean(
  self : FinanceportfoliorebalancingRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingRange::scale(
  self : FinanceportfoliorebalancingRange,
  f : Double,
) -> FinanceportfoliorebalancingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingRange::add(
  self : FinanceportfoliorebalancingRange,
  other : FinanceportfoliorebalancingRange,
) -> FinanceportfoliorebalancingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingRange::copy(
  self : FinanceportfoliorebalancingRange,
) -> FinanceportfoliorebalancingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingRange::fill(
  self : FinanceportfoliorebalancingRange,
  v : Double,
) -> FinanceportfoliorebalancingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingRange::min(
  self : FinanceportfoliorebalancingRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingRange::max(
  self : FinanceportfoliorebalancingRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingRange::to_string(
  self : FinanceportfoliorebalancingRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliorebalancingSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_rebalancing_slice_make(
  size : Int32,
) -> FinanceportfoliorebalancingSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliorebalancingSlice::len(
  self : FinanceportfoliorebalancingSlice,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliorebalancingSlice::get(
  self : FinanceportfoliorebalancingSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliorebalancingSlice::set(
  self : FinanceportfoliorebalancingSlice,
  i : Int32,
  v : Double,
) -> FinanceportfoliorebalancingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingSlice::sum(
  self : FinanceportfoliorebalancingSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliorebalancingSlice::mean(
  self : FinanceportfoliorebalancingSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliorebalancingSlice::scale(
  self : FinanceportfoliorebalancingSlice,
  f : Double,
) -> FinanceportfoliorebalancingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingSlice::add(
  self : FinanceportfoliorebalancingSlice,
  other : FinanceportfoliorebalancingSlice,
) -> FinanceportfoliorebalancingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingSlice::copy(
  self : FinanceportfoliorebalancingSlice,
) -> FinanceportfoliorebalancingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingSlice::fill(
  self : FinanceportfoliorebalancingSlice,
  v : Double,
) -> FinanceportfoliorebalancingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliorebalancingSlice::min(
  self : FinanceportfoliorebalancingSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliorebalancingSlice::max(
  self : FinanceportfoliorebalancingSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliorebalancingSlice::to_string(
  self : FinanceportfoliorebalancingSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
