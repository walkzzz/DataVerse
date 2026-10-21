///|
///===
/// extcore/finance_risk_marginal
pub(all) struct FinanceriskmarginalPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_risk_marginal_make_point(
  x : Double,
  y : Double,
) -> FinanceriskmarginalPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_risk_marginal_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinanceriskmarginalPoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinanceriskmarginalPoint::x(self : FinanceriskmarginalPoint) -> Double {
  self.x
}

///|
pub fn FinanceriskmarginalPoint::y(self : FinanceriskmarginalPoint) -> Double {
  self.y
}

///|
pub fn FinanceriskmarginalPoint::z(self : FinanceriskmarginalPoint) -> Double {
  self.z
}

///|
pub fn FinanceriskmarginalPoint::label(
  self : FinanceriskmarginalPoint,
) -> Int32 {
  self.label
}

///|
pub fn FinanceriskmarginalPoint::dist(
  self : FinanceriskmarginalPoint,
  other : FinanceriskmarginalPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinanceriskmarginalPoint::add(
  self : FinanceriskmarginalPoint,
  other : FinanceriskmarginalPoint,
) -> FinanceriskmarginalPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinanceriskmarginalPoint::sub(
  self : FinanceriskmarginalPoint,
  other : FinanceriskmarginalPoint,
) -> FinanceriskmarginalPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinanceriskmarginalPoint::scale(
  self : FinanceriskmarginalPoint,
  s : Double,
) -> FinanceriskmarginalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinanceriskmarginalPoint::dot(
  self : FinanceriskmarginalPoint,
  other : FinanceriskmarginalPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinanceriskmarginalPoint::cross(
  self : FinanceriskmarginalPoint,
  other : FinanceriskmarginalPoint,
) -> FinanceriskmarginalPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinanceriskmarginalPoint::norm(
  self : FinanceriskmarginalPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinanceriskmarginalPoint::normalize(
  self : FinanceriskmarginalPoint,
) -> FinanceriskmarginalPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceriskmarginalPoint::negate(
  self : FinanceriskmarginalPoint,
) -> FinanceriskmarginalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinanceriskmarginalPoint::mid(
  self : FinanceriskmarginalPoint,
  other : FinanceriskmarginalPoint,
) -> FinanceriskmarginalPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinanceriskmarginalPoint::lerp(
  self : FinanceriskmarginalPoint,
  other : FinanceriskmarginalPoint,
  t : Double,
) -> FinanceriskmarginalPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinanceriskmarginalPoint::to_string(
  self : FinanceriskmarginalPoint,
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
pub(all) struct FinanceriskmarginalSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_risk_marginal_make_series(
  vals : Array[Double],
  name : String,
) -> FinanceriskmarginalSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinanceriskmarginalSeries::len(
  self : FinanceriskmarginalSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn FinanceriskmarginalSeries::sum(
  self : FinanceriskmarginalSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinanceriskmarginalSeries::mean(
  self : FinanceriskmarginalSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinanceriskmarginalSeries::min(
  self : FinanceriskmarginalSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinanceriskmarginalSeries::max(
  self : FinanceriskmarginalSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinanceriskmarginalSeries::range(
  self : FinanceriskmarginalSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinanceriskmarginalSeries::variance(
  self : FinanceriskmarginalSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinanceriskmarginalSeries::std(
  self : FinanceriskmarginalSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinanceriskmarginalSeries::median(
  self : FinanceriskmarginalSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinanceriskmarginalSeries::scale(
  self : FinanceriskmarginalSeries,
  f : Double,
) -> FinanceriskmarginalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinanceriskmarginalSeries::add(
  self : FinanceriskmarginalSeries,
  other : FinanceriskmarginalSeries,
) -> FinanceriskmarginalSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceriskmarginalSeries::sub(
  self : FinanceriskmarginalSeries,
  other : FinanceriskmarginalSeries,
) -> FinanceriskmarginalSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceriskmarginalSeries::normalize(
  self : FinanceriskmarginalSeries,
) -> FinanceriskmarginalSeries {
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
pub fn FinanceriskmarginalSeries::cumsum(
  self : FinanceriskmarginalSeries,
) -> FinanceriskmarginalSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinanceriskmarginalSeries::to_string(
  self : FinanceriskmarginalSeries,
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
pub(all) struct FinanceriskmarginalMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_risk_marginal_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinanceriskmarginalMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_risk_marginal_matrix_identity(
  n : Int32,
) -> FinanceriskmarginalMatrix {
  let m = finance_risk_marginal_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinanceriskmarginalMatrix::get(
  self : FinanceriskmarginalMatrix,
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
pub fn FinanceriskmarginalMatrix::transpose(
  self : FinanceriskmarginalMatrix,
) -> FinanceriskmarginalMatrix {
  let result = finance_risk_marginal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceriskmarginalMatrix::add(
  self : FinanceriskmarginalMatrix,
  other : FinanceriskmarginalMatrix,
) -> FinanceriskmarginalMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_risk_marginal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceriskmarginalMatrix::scale(
  self : FinanceriskmarginalMatrix,
  s : Double,
) -> FinanceriskmarginalMatrix {
  let result = finance_risk_marginal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn FinanceriskmarginalMatrix::multiply(
  self : FinanceriskmarginalMatrix,
  other : FinanceriskmarginalMatrix,
) -> FinanceriskmarginalMatrix {
  if self.cols != other.rows {
    return finance_risk_marginal_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = finance_risk_marginal_make_matrix(self.rows, other.cols, 0.0)
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
pub fn FinanceriskmarginalMatrix::trace(
  self : FinanceriskmarginalMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinanceriskmarginalMatrix::det(
  self : FinanceriskmarginalMatrix,
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
pub fn FinanceriskmarginalMatrix::norm(
  self : FinanceriskmarginalMatrix,
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
pub fn FinanceriskmarginalMatrix::to_string(
  self : FinanceriskmarginalMatrix,
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
pub(all) struct FinanceriskmarginalVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_risk_marginal_make_vector(
  comps : Array[Double],
) -> FinanceriskmarginalVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_risk_marginal_vector_zero(
  dim : Int32,
) -> FinanceriskmarginalVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinanceriskmarginalVector::add(
  self : FinanceriskmarginalVector,
  other : FinanceriskmarginalVector,
) -> FinanceriskmarginalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceriskmarginalVector::sub(
  self : FinanceriskmarginalVector,
  other : FinanceriskmarginalVector,
) -> FinanceriskmarginalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceriskmarginalVector::scale(
  self : FinanceriskmarginalVector,
  s : Double,
) -> FinanceriskmarginalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinanceriskmarginalVector::dot(
  self : FinanceriskmarginalVector,
  other : FinanceriskmarginalVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinanceriskmarginalVector::norm(
  self : FinanceriskmarginalVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinanceriskmarginalVector::normalize(
  self : FinanceriskmarginalVector,
) -> FinanceriskmarginalVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceriskmarginalVector::dist(
  self : FinanceriskmarginalVector,
  other : FinanceriskmarginalVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinanceriskmarginalVector::to_string(
  self : FinanceriskmarginalVector,
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
pub(all) struct FinanceriskmarginalFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_frame_make(
  size : Int32,
) -> FinanceriskmarginalFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalFrame::len(self : FinanceriskmarginalFrame) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalFrame::get(
  self : FinanceriskmarginalFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalFrame::set(
  self : FinanceriskmarginalFrame,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalFrame::sum(self : FinanceriskmarginalFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalFrame::mean(
  self : FinanceriskmarginalFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalFrame::scale(
  self : FinanceriskmarginalFrame,
  f : Double,
) -> FinanceriskmarginalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalFrame::add(
  self : FinanceriskmarginalFrame,
  other : FinanceriskmarginalFrame,
) -> FinanceriskmarginalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalFrame::copy(
  self : FinanceriskmarginalFrame,
) -> FinanceriskmarginalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalFrame::fill(
  self : FinanceriskmarginalFrame,
  v : Double,
) -> FinanceriskmarginalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalFrame::min(self : FinanceriskmarginalFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalFrame::max(self : FinanceriskmarginalFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalFrame::to_string(
  self : FinanceriskmarginalFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_table_make(
  size : Int32,
) -> FinanceriskmarginalTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalTable::len(self : FinanceriskmarginalTable) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalTable::get(
  self : FinanceriskmarginalTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalTable::set(
  self : FinanceriskmarginalTable,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalTable::sum(self : FinanceriskmarginalTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalTable::mean(
  self : FinanceriskmarginalTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalTable::scale(
  self : FinanceriskmarginalTable,
  f : Double,
) -> FinanceriskmarginalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalTable::add(
  self : FinanceriskmarginalTable,
  other : FinanceriskmarginalTable,
) -> FinanceriskmarginalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalTable::copy(
  self : FinanceriskmarginalTable,
) -> FinanceriskmarginalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalTable::fill(
  self : FinanceriskmarginalTable,
  v : Double,
) -> FinanceriskmarginalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalTable::min(self : FinanceriskmarginalTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalTable::max(self : FinanceriskmarginalTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalTable::to_string(
  self : FinanceriskmarginalTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_graphn_make(
  size : Int32,
) -> FinanceriskmarginalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalGraphN::len(
  self : FinanceriskmarginalGraphN,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalGraphN::get(
  self : FinanceriskmarginalGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalGraphN::set(
  self : FinanceriskmarginalGraphN,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalGraphN::sum(
  self : FinanceriskmarginalGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalGraphN::mean(
  self : FinanceriskmarginalGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalGraphN::scale(
  self : FinanceriskmarginalGraphN,
  f : Double,
) -> FinanceriskmarginalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalGraphN::add(
  self : FinanceriskmarginalGraphN,
  other : FinanceriskmarginalGraphN,
) -> FinanceriskmarginalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalGraphN::copy(
  self : FinanceriskmarginalGraphN,
) -> FinanceriskmarginalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalGraphN::fill(
  self : FinanceriskmarginalGraphN,
  v : Double,
) -> FinanceriskmarginalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalGraphN::min(
  self : FinanceriskmarginalGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalGraphN::max(
  self : FinanceriskmarginalGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalGraphN::to_string(
  self : FinanceriskmarginalGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_node_make(size : Int32) -> FinanceriskmarginalNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalNode::len(self : FinanceriskmarginalNode) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalNode::get(
  self : FinanceriskmarginalNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalNode::set(
  self : FinanceriskmarginalNode,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalNode::sum(self : FinanceriskmarginalNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalNode::mean(self : FinanceriskmarginalNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalNode::scale(
  self : FinanceriskmarginalNode,
  f : Double,
) -> FinanceriskmarginalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalNode::add(
  self : FinanceriskmarginalNode,
  other : FinanceriskmarginalNode,
) -> FinanceriskmarginalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalNode::copy(
  self : FinanceriskmarginalNode,
) -> FinanceriskmarginalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalNode::fill(
  self : FinanceriskmarginalNode,
  v : Double,
) -> FinanceriskmarginalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalNode::min(self : FinanceriskmarginalNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalNode::max(self : FinanceriskmarginalNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalNode::to_string(
  self : FinanceriskmarginalNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_edge_make(size : Int32) -> FinanceriskmarginalEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalEdge::len(self : FinanceriskmarginalEdge) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalEdge::get(
  self : FinanceriskmarginalEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalEdge::set(
  self : FinanceriskmarginalEdge,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalEdge::sum(self : FinanceriskmarginalEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalEdge::mean(self : FinanceriskmarginalEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalEdge::scale(
  self : FinanceriskmarginalEdge,
  f : Double,
) -> FinanceriskmarginalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalEdge::add(
  self : FinanceriskmarginalEdge,
  other : FinanceriskmarginalEdge,
) -> FinanceriskmarginalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalEdge::copy(
  self : FinanceriskmarginalEdge,
) -> FinanceriskmarginalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalEdge::fill(
  self : FinanceriskmarginalEdge,
  v : Double,
) -> FinanceriskmarginalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalEdge::min(self : FinanceriskmarginalEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalEdge::max(self : FinanceriskmarginalEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalEdge::to_string(
  self : FinanceriskmarginalEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_path_make(size : Int32) -> FinanceriskmarginalPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalPath::len(self : FinanceriskmarginalPath) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalPath::get(
  self : FinanceriskmarginalPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalPath::set(
  self : FinanceriskmarginalPath,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalPath::sum(self : FinanceriskmarginalPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalPath::mean(self : FinanceriskmarginalPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalPath::scale(
  self : FinanceriskmarginalPath,
  f : Double,
) -> FinanceriskmarginalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalPath::add(
  self : FinanceriskmarginalPath,
  other : FinanceriskmarginalPath,
) -> FinanceriskmarginalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalPath::copy(
  self : FinanceriskmarginalPath,
) -> FinanceriskmarginalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalPath::fill(
  self : FinanceriskmarginalPath,
  v : Double,
) -> FinanceriskmarginalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalPath::min(self : FinanceriskmarginalPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalPath::max(self : FinanceriskmarginalPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalPath::to_string(
  self : FinanceriskmarginalPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_cluster_make(
  size : Int32,
) -> FinanceriskmarginalCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalCluster::len(
  self : FinanceriskmarginalCluster,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalCluster::get(
  self : FinanceriskmarginalCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalCluster::set(
  self : FinanceriskmarginalCluster,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalCluster::sum(
  self : FinanceriskmarginalCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalCluster::mean(
  self : FinanceriskmarginalCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalCluster::scale(
  self : FinanceriskmarginalCluster,
  f : Double,
) -> FinanceriskmarginalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalCluster::add(
  self : FinanceriskmarginalCluster,
  other : FinanceriskmarginalCluster,
) -> FinanceriskmarginalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalCluster::copy(
  self : FinanceriskmarginalCluster,
) -> FinanceriskmarginalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalCluster::fill(
  self : FinanceriskmarginalCluster,
  v : Double,
) -> FinanceriskmarginalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalCluster::min(
  self : FinanceriskmarginalCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalCluster::max(
  self : FinanceriskmarginalCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalCluster::to_string(
  self : FinanceriskmarginalCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_model_make(
  size : Int32,
) -> FinanceriskmarginalModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalModel::len(self : FinanceriskmarginalModel) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalModel::get(
  self : FinanceriskmarginalModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalModel::set(
  self : FinanceriskmarginalModel,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalModel::sum(self : FinanceriskmarginalModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalModel::mean(
  self : FinanceriskmarginalModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalModel::scale(
  self : FinanceriskmarginalModel,
  f : Double,
) -> FinanceriskmarginalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalModel::add(
  self : FinanceriskmarginalModel,
  other : FinanceriskmarginalModel,
) -> FinanceriskmarginalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalModel::copy(
  self : FinanceriskmarginalModel,
) -> FinanceriskmarginalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalModel::fill(
  self : FinanceriskmarginalModel,
  v : Double,
) -> FinanceriskmarginalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalModel::min(self : FinanceriskmarginalModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalModel::max(self : FinanceriskmarginalModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalModel::to_string(
  self : FinanceriskmarginalModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_layer_make(
  size : Int32,
) -> FinanceriskmarginalLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalLayer::len(self : FinanceriskmarginalLayer) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalLayer::get(
  self : FinanceriskmarginalLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalLayer::set(
  self : FinanceriskmarginalLayer,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalLayer::sum(self : FinanceriskmarginalLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalLayer::mean(
  self : FinanceriskmarginalLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalLayer::scale(
  self : FinanceriskmarginalLayer,
  f : Double,
) -> FinanceriskmarginalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalLayer::add(
  self : FinanceriskmarginalLayer,
  other : FinanceriskmarginalLayer,
) -> FinanceriskmarginalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalLayer::copy(
  self : FinanceriskmarginalLayer,
) -> FinanceriskmarginalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalLayer::fill(
  self : FinanceriskmarginalLayer,
  v : Double,
) -> FinanceriskmarginalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalLayer::min(self : FinanceriskmarginalLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalLayer::max(self : FinanceriskmarginalLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalLayer::to_string(
  self : FinanceriskmarginalLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_buffer_make(
  size : Int32,
) -> FinanceriskmarginalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalBuffer::len(
  self : FinanceriskmarginalBuffer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalBuffer::get(
  self : FinanceriskmarginalBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalBuffer::set(
  self : FinanceriskmarginalBuffer,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalBuffer::sum(
  self : FinanceriskmarginalBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalBuffer::mean(
  self : FinanceriskmarginalBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalBuffer::scale(
  self : FinanceriskmarginalBuffer,
  f : Double,
) -> FinanceriskmarginalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalBuffer::add(
  self : FinanceriskmarginalBuffer,
  other : FinanceriskmarginalBuffer,
) -> FinanceriskmarginalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalBuffer::copy(
  self : FinanceriskmarginalBuffer,
) -> FinanceriskmarginalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalBuffer::fill(
  self : FinanceriskmarginalBuffer,
  v : Double,
) -> FinanceriskmarginalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalBuffer::min(
  self : FinanceriskmarginalBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalBuffer::max(
  self : FinanceriskmarginalBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalBuffer::to_string(
  self : FinanceriskmarginalBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_cursor_make(
  size : Int32,
) -> FinanceriskmarginalCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalCursor::len(
  self : FinanceriskmarginalCursor,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalCursor::get(
  self : FinanceriskmarginalCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalCursor::set(
  self : FinanceriskmarginalCursor,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalCursor::sum(
  self : FinanceriskmarginalCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalCursor::mean(
  self : FinanceriskmarginalCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalCursor::scale(
  self : FinanceriskmarginalCursor,
  f : Double,
) -> FinanceriskmarginalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalCursor::add(
  self : FinanceriskmarginalCursor,
  other : FinanceriskmarginalCursor,
) -> FinanceriskmarginalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalCursor::copy(
  self : FinanceriskmarginalCursor,
) -> FinanceriskmarginalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalCursor::fill(
  self : FinanceriskmarginalCursor,
  v : Double,
) -> FinanceriskmarginalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalCursor::min(
  self : FinanceriskmarginalCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalCursor::max(
  self : FinanceriskmarginalCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalCursor::to_string(
  self : FinanceriskmarginalCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_view_make(size : Int32) -> FinanceriskmarginalView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalView::len(self : FinanceriskmarginalView) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalView::get(
  self : FinanceriskmarginalView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalView::set(
  self : FinanceriskmarginalView,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalView::sum(self : FinanceriskmarginalView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalView::mean(self : FinanceriskmarginalView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalView::scale(
  self : FinanceriskmarginalView,
  f : Double,
) -> FinanceriskmarginalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalView::add(
  self : FinanceriskmarginalView,
  other : FinanceriskmarginalView,
) -> FinanceriskmarginalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalView::copy(
  self : FinanceriskmarginalView,
) -> FinanceriskmarginalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalView::fill(
  self : FinanceriskmarginalView,
  v : Double,
) -> FinanceriskmarginalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalView::min(self : FinanceriskmarginalView) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalView::max(self : FinanceriskmarginalView) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalView::to_string(
  self : FinanceriskmarginalView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_range_make(
  size : Int32,
) -> FinanceriskmarginalRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalRange::len(self : FinanceriskmarginalRange) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalRange::get(
  self : FinanceriskmarginalRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalRange::set(
  self : FinanceriskmarginalRange,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalRange::sum(self : FinanceriskmarginalRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalRange::mean(
  self : FinanceriskmarginalRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalRange::scale(
  self : FinanceriskmarginalRange,
  f : Double,
) -> FinanceriskmarginalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalRange::add(
  self : FinanceriskmarginalRange,
  other : FinanceriskmarginalRange,
) -> FinanceriskmarginalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalRange::copy(
  self : FinanceriskmarginalRange,
) -> FinanceriskmarginalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalRange::fill(
  self : FinanceriskmarginalRange,
  v : Double,
) -> FinanceriskmarginalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalRange::min(self : FinanceriskmarginalRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalRange::max(self : FinanceriskmarginalRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalRange::to_string(
  self : FinanceriskmarginalRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskmarginalSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_marginal_slice_make(
  size : Int32,
) -> FinanceriskmarginalSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskmarginalSlice::len(self : FinanceriskmarginalSlice) -> Int32 {
  self.size
}

///|
pub fn FinanceriskmarginalSlice::get(
  self : FinanceriskmarginalSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskmarginalSlice::set(
  self : FinanceriskmarginalSlice,
  i : Int32,
  v : Double,
) -> FinanceriskmarginalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalSlice::sum(self : FinanceriskmarginalSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskmarginalSlice::mean(
  self : FinanceriskmarginalSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskmarginalSlice::scale(
  self : FinanceriskmarginalSlice,
  f : Double,
) -> FinanceriskmarginalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalSlice::add(
  self : FinanceriskmarginalSlice,
  other : FinanceriskmarginalSlice,
) -> FinanceriskmarginalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalSlice::copy(
  self : FinanceriskmarginalSlice,
) -> FinanceriskmarginalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalSlice::fill(
  self : FinanceriskmarginalSlice,
  v : Double,
) -> FinanceriskmarginalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskmarginalSlice::min(self : FinanceriskmarginalSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskmarginalSlice::max(self : FinanceriskmarginalSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskmarginalSlice::to_string(
  self : FinanceriskmarginalSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
