///|
///===
/// extcore/finance_portfolio_factor
pub(all) struct FinanceportfoliofactorPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_portfolio_factor_make_point(
  x : Double,
  y : Double,
) -> FinanceportfoliofactorPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_portfolio_factor_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinanceportfoliofactorPoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinanceportfoliofactorPoint::x(
  self : FinanceportfoliofactorPoint,
) -> Double {
  self.x
}

///|
pub fn FinanceportfoliofactorPoint::y(
  self : FinanceportfoliofactorPoint,
) -> Double {
  self.y
}

///|
pub fn FinanceportfoliofactorPoint::z(
  self : FinanceportfoliofactorPoint,
) -> Double {
  self.z
}

///|
pub fn FinanceportfoliofactorPoint::label(
  self : FinanceportfoliofactorPoint,
) -> Int32 {
  self.label
}

///|
pub fn FinanceportfoliofactorPoint::dist(
  self : FinanceportfoliofactorPoint,
  other : FinanceportfoliofactorPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinanceportfoliofactorPoint::add(
  self : FinanceportfoliofactorPoint,
  other : FinanceportfoliofactorPoint,
) -> FinanceportfoliofactorPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliofactorPoint::sub(
  self : FinanceportfoliofactorPoint,
  other : FinanceportfoliofactorPoint,
) -> FinanceportfoliofactorPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliofactorPoint::scale(
  self : FinanceportfoliofactorPoint,
  s : Double,
) -> FinanceportfoliofactorPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinanceportfoliofactorPoint::dot(
  self : FinanceportfoliofactorPoint,
  other : FinanceportfoliofactorPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinanceportfoliofactorPoint::cross(
  self : FinanceportfoliofactorPoint,
  other : FinanceportfoliofactorPoint,
) -> FinanceportfoliofactorPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinanceportfoliofactorPoint::norm(
  self : FinanceportfoliofactorPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinanceportfoliofactorPoint::normalize(
  self : FinanceportfoliofactorPoint,
) -> FinanceportfoliofactorPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceportfoliofactorPoint::negate(
  self : FinanceportfoliofactorPoint,
) -> FinanceportfoliofactorPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinanceportfoliofactorPoint::mid(
  self : FinanceportfoliofactorPoint,
  other : FinanceportfoliofactorPoint,
) -> FinanceportfoliofactorPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliofactorPoint::lerp(
  self : FinanceportfoliofactorPoint,
  other : FinanceportfoliofactorPoint,
  t : Double,
) -> FinanceportfoliofactorPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliofactorPoint::to_string(
  self : FinanceportfoliofactorPoint,
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
pub(all) struct FinanceportfoliofactorSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_portfolio_factor_make_series(
  vals : Array[Double],
  name : String,
) -> FinanceportfoliofactorSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinanceportfoliofactorSeries::len(
  self : FinanceportfoliofactorSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn FinanceportfoliofactorSeries::sum(
  self : FinanceportfoliofactorSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinanceportfoliofactorSeries::mean(
  self : FinanceportfoliofactorSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinanceportfoliofactorSeries::min(
  self : FinanceportfoliofactorSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinanceportfoliofactorSeries::max(
  self : FinanceportfoliofactorSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinanceportfoliofactorSeries::range(
  self : FinanceportfoliofactorSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinanceportfoliofactorSeries::variance(
  self : FinanceportfoliofactorSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinanceportfoliofactorSeries::std(
  self : FinanceportfoliofactorSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinanceportfoliofactorSeries::median(
  self : FinanceportfoliofactorSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinanceportfoliofactorSeries::scale(
  self : FinanceportfoliofactorSeries,
  f : Double,
) -> FinanceportfoliofactorSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinanceportfoliofactorSeries::add(
  self : FinanceportfoliofactorSeries,
  other : FinanceportfoliofactorSeries,
) -> FinanceportfoliofactorSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceportfoliofactorSeries::sub(
  self : FinanceportfoliofactorSeries,
  other : FinanceportfoliofactorSeries,
) -> FinanceportfoliofactorSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceportfoliofactorSeries::normalize(
  self : FinanceportfoliofactorSeries,
) -> FinanceportfoliofactorSeries {
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
pub fn FinanceportfoliofactorSeries::cumsum(
  self : FinanceportfoliofactorSeries,
) -> FinanceportfoliofactorSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinanceportfoliofactorSeries::to_string(
  self : FinanceportfoliofactorSeries,
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
pub(all) struct FinanceportfoliofactorMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_portfolio_factor_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinanceportfoliofactorMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_portfolio_factor_matrix_identity(
  n : Int32,
) -> FinanceportfoliofactorMatrix {
  let m = finance_portfolio_factor_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinanceportfoliofactorMatrix::get(
  self : FinanceportfoliofactorMatrix,
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
pub fn FinanceportfoliofactorMatrix::transpose(
  self : FinanceportfoliofactorMatrix,
) -> FinanceportfoliofactorMatrix {
  let result = finance_portfolio_factor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceportfoliofactorMatrix::add(
  self : FinanceportfoliofactorMatrix,
  other : FinanceportfoliofactorMatrix,
) -> FinanceportfoliofactorMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_portfolio_factor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceportfoliofactorMatrix::scale(
  self : FinanceportfoliofactorMatrix,
  s : Double,
) -> FinanceportfoliofactorMatrix {
  let result = finance_portfolio_factor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn FinanceportfoliofactorMatrix::multiply(
  self : FinanceportfoliofactorMatrix,
  other : FinanceportfoliofactorMatrix,
) -> FinanceportfoliofactorMatrix {
  if self.cols != other.rows {
    return finance_portfolio_factor_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = finance_portfolio_factor_make_matrix(self.rows, other.cols, 0.0)
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
pub fn FinanceportfoliofactorMatrix::trace(
  self : FinanceportfoliofactorMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinanceportfoliofactorMatrix::det(
  self : FinanceportfoliofactorMatrix,
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
pub fn FinanceportfoliofactorMatrix::norm(
  self : FinanceportfoliofactorMatrix,
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
pub fn FinanceportfoliofactorMatrix::to_string(
  self : FinanceportfoliofactorMatrix,
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
pub(all) struct FinanceportfoliofactorVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_portfolio_factor_make_vector(
  comps : Array[Double],
) -> FinanceportfoliofactorVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_portfolio_factor_vector_zero(
  dim : Int32,
) -> FinanceportfoliofactorVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinanceportfoliofactorVector::add(
  self : FinanceportfoliofactorVector,
  other : FinanceportfoliofactorVector,
) -> FinanceportfoliofactorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceportfoliofactorVector::sub(
  self : FinanceportfoliofactorVector,
  other : FinanceportfoliofactorVector,
) -> FinanceportfoliofactorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceportfoliofactorVector::scale(
  self : FinanceportfoliofactorVector,
  s : Double,
) -> FinanceportfoliofactorVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinanceportfoliofactorVector::dot(
  self : FinanceportfoliofactorVector,
  other : FinanceportfoliofactorVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinanceportfoliofactorVector::norm(
  self : FinanceportfoliofactorVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinanceportfoliofactorVector::normalize(
  self : FinanceportfoliofactorVector,
) -> FinanceportfoliofactorVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceportfoliofactorVector::dist(
  self : FinanceportfoliofactorVector,
  other : FinanceportfoliofactorVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinanceportfoliofactorVector::to_string(
  self : FinanceportfoliofactorVector,
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
pub(all) struct FinanceportfoliofactorFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_frame_make(
  size : Int32,
) -> FinanceportfoliofactorFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorFrame::len(
  self : FinanceportfoliofactorFrame,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorFrame::get(
  self : FinanceportfoliofactorFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorFrame::set(
  self : FinanceportfoliofactorFrame,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorFrame::sum(
  self : FinanceportfoliofactorFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorFrame::mean(
  self : FinanceportfoliofactorFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorFrame::scale(
  self : FinanceportfoliofactorFrame,
  f : Double,
) -> FinanceportfoliofactorFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorFrame::add(
  self : FinanceportfoliofactorFrame,
  other : FinanceportfoliofactorFrame,
) -> FinanceportfoliofactorFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorFrame::copy(
  self : FinanceportfoliofactorFrame,
) -> FinanceportfoliofactorFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorFrame::fill(
  self : FinanceportfoliofactorFrame,
  v : Double,
) -> FinanceportfoliofactorFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorFrame::min(
  self : FinanceportfoliofactorFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorFrame::max(
  self : FinanceportfoliofactorFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorFrame::to_string(
  self : FinanceportfoliofactorFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_table_make(
  size : Int32,
) -> FinanceportfoliofactorTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorTable::len(
  self : FinanceportfoliofactorTable,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorTable::get(
  self : FinanceportfoliofactorTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorTable::set(
  self : FinanceportfoliofactorTable,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorTable::sum(
  self : FinanceportfoliofactorTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorTable::mean(
  self : FinanceportfoliofactorTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorTable::scale(
  self : FinanceportfoliofactorTable,
  f : Double,
) -> FinanceportfoliofactorTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorTable::add(
  self : FinanceportfoliofactorTable,
  other : FinanceportfoliofactorTable,
) -> FinanceportfoliofactorTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorTable::copy(
  self : FinanceportfoliofactorTable,
) -> FinanceportfoliofactorTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorTable::fill(
  self : FinanceportfoliofactorTable,
  v : Double,
) -> FinanceportfoliofactorTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorTable::min(
  self : FinanceportfoliofactorTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorTable::max(
  self : FinanceportfoliofactorTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorTable::to_string(
  self : FinanceportfoliofactorTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_graphn_make(
  size : Int32,
) -> FinanceportfoliofactorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorGraphN::len(
  self : FinanceportfoliofactorGraphN,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorGraphN::get(
  self : FinanceportfoliofactorGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorGraphN::set(
  self : FinanceportfoliofactorGraphN,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorGraphN::sum(
  self : FinanceportfoliofactorGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorGraphN::mean(
  self : FinanceportfoliofactorGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorGraphN::scale(
  self : FinanceportfoliofactorGraphN,
  f : Double,
) -> FinanceportfoliofactorGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorGraphN::add(
  self : FinanceportfoliofactorGraphN,
  other : FinanceportfoliofactorGraphN,
) -> FinanceportfoliofactorGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorGraphN::copy(
  self : FinanceportfoliofactorGraphN,
) -> FinanceportfoliofactorGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorGraphN::fill(
  self : FinanceportfoliofactorGraphN,
  v : Double,
) -> FinanceportfoliofactorGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorGraphN::min(
  self : FinanceportfoliofactorGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorGraphN::max(
  self : FinanceportfoliofactorGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorGraphN::to_string(
  self : FinanceportfoliofactorGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_node_make(
  size : Int32,
) -> FinanceportfoliofactorNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorNode::len(
  self : FinanceportfoliofactorNode,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorNode::get(
  self : FinanceportfoliofactorNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorNode::set(
  self : FinanceportfoliofactorNode,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorNode::sum(
  self : FinanceportfoliofactorNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorNode::mean(
  self : FinanceportfoliofactorNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorNode::scale(
  self : FinanceportfoliofactorNode,
  f : Double,
) -> FinanceportfoliofactorNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorNode::add(
  self : FinanceportfoliofactorNode,
  other : FinanceportfoliofactorNode,
) -> FinanceportfoliofactorNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorNode::copy(
  self : FinanceportfoliofactorNode,
) -> FinanceportfoliofactorNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorNode::fill(
  self : FinanceportfoliofactorNode,
  v : Double,
) -> FinanceportfoliofactorNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorNode::min(
  self : FinanceportfoliofactorNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorNode::max(
  self : FinanceportfoliofactorNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorNode::to_string(
  self : FinanceportfoliofactorNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_edge_make(
  size : Int32,
) -> FinanceportfoliofactorEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorEdge::len(
  self : FinanceportfoliofactorEdge,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorEdge::get(
  self : FinanceportfoliofactorEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorEdge::set(
  self : FinanceportfoliofactorEdge,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorEdge::sum(
  self : FinanceportfoliofactorEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorEdge::mean(
  self : FinanceportfoliofactorEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorEdge::scale(
  self : FinanceportfoliofactorEdge,
  f : Double,
) -> FinanceportfoliofactorEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorEdge::add(
  self : FinanceportfoliofactorEdge,
  other : FinanceportfoliofactorEdge,
) -> FinanceportfoliofactorEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorEdge::copy(
  self : FinanceportfoliofactorEdge,
) -> FinanceportfoliofactorEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorEdge::fill(
  self : FinanceportfoliofactorEdge,
  v : Double,
) -> FinanceportfoliofactorEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorEdge::min(
  self : FinanceportfoliofactorEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorEdge::max(
  self : FinanceportfoliofactorEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorEdge::to_string(
  self : FinanceportfoliofactorEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_path_make(
  size : Int32,
) -> FinanceportfoliofactorPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorPath::len(
  self : FinanceportfoliofactorPath,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorPath::get(
  self : FinanceportfoliofactorPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorPath::set(
  self : FinanceportfoliofactorPath,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorPath::sum(
  self : FinanceportfoliofactorPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorPath::mean(
  self : FinanceportfoliofactorPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorPath::scale(
  self : FinanceportfoliofactorPath,
  f : Double,
) -> FinanceportfoliofactorPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorPath::add(
  self : FinanceportfoliofactorPath,
  other : FinanceportfoliofactorPath,
) -> FinanceportfoliofactorPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorPath::copy(
  self : FinanceportfoliofactorPath,
) -> FinanceportfoliofactorPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorPath::fill(
  self : FinanceportfoliofactorPath,
  v : Double,
) -> FinanceportfoliofactorPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorPath::min(
  self : FinanceportfoliofactorPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorPath::max(
  self : FinanceportfoliofactorPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorPath::to_string(
  self : FinanceportfoliofactorPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_cluster_make(
  size : Int32,
) -> FinanceportfoliofactorCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorCluster::len(
  self : FinanceportfoliofactorCluster,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorCluster::get(
  self : FinanceportfoliofactorCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorCluster::set(
  self : FinanceportfoliofactorCluster,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorCluster::sum(
  self : FinanceportfoliofactorCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorCluster::mean(
  self : FinanceportfoliofactorCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorCluster::scale(
  self : FinanceportfoliofactorCluster,
  f : Double,
) -> FinanceportfoliofactorCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorCluster::add(
  self : FinanceportfoliofactorCluster,
  other : FinanceportfoliofactorCluster,
) -> FinanceportfoliofactorCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorCluster::copy(
  self : FinanceportfoliofactorCluster,
) -> FinanceportfoliofactorCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorCluster::fill(
  self : FinanceportfoliofactorCluster,
  v : Double,
) -> FinanceportfoliofactorCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorCluster::min(
  self : FinanceportfoliofactorCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorCluster::max(
  self : FinanceportfoliofactorCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorCluster::to_string(
  self : FinanceportfoliofactorCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_model_make(
  size : Int32,
) -> FinanceportfoliofactorModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorModel::len(
  self : FinanceportfoliofactorModel,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorModel::get(
  self : FinanceportfoliofactorModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorModel::set(
  self : FinanceportfoliofactorModel,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorModel::sum(
  self : FinanceportfoliofactorModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorModel::mean(
  self : FinanceportfoliofactorModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorModel::scale(
  self : FinanceportfoliofactorModel,
  f : Double,
) -> FinanceportfoliofactorModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorModel::add(
  self : FinanceportfoliofactorModel,
  other : FinanceportfoliofactorModel,
) -> FinanceportfoliofactorModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorModel::copy(
  self : FinanceportfoliofactorModel,
) -> FinanceportfoliofactorModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorModel::fill(
  self : FinanceportfoliofactorModel,
  v : Double,
) -> FinanceportfoliofactorModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorModel::min(
  self : FinanceportfoliofactorModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorModel::max(
  self : FinanceportfoliofactorModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorModel::to_string(
  self : FinanceportfoliofactorModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_layer_make(
  size : Int32,
) -> FinanceportfoliofactorLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorLayer::len(
  self : FinanceportfoliofactorLayer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorLayer::get(
  self : FinanceportfoliofactorLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorLayer::set(
  self : FinanceportfoliofactorLayer,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorLayer::sum(
  self : FinanceportfoliofactorLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorLayer::mean(
  self : FinanceportfoliofactorLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorLayer::scale(
  self : FinanceportfoliofactorLayer,
  f : Double,
) -> FinanceportfoliofactorLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorLayer::add(
  self : FinanceportfoliofactorLayer,
  other : FinanceportfoliofactorLayer,
) -> FinanceportfoliofactorLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorLayer::copy(
  self : FinanceportfoliofactorLayer,
) -> FinanceportfoliofactorLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorLayer::fill(
  self : FinanceportfoliofactorLayer,
  v : Double,
) -> FinanceportfoliofactorLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorLayer::min(
  self : FinanceportfoliofactorLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorLayer::max(
  self : FinanceportfoliofactorLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorLayer::to_string(
  self : FinanceportfoliofactorLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_buffer_make(
  size : Int32,
) -> FinanceportfoliofactorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorBuffer::len(
  self : FinanceportfoliofactorBuffer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorBuffer::get(
  self : FinanceportfoliofactorBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorBuffer::set(
  self : FinanceportfoliofactorBuffer,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorBuffer::sum(
  self : FinanceportfoliofactorBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorBuffer::mean(
  self : FinanceportfoliofactorBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorBuffer::scale(
  self : FinanceportfoliofactorBuffer,
  f : Double,
) -> FinanceportfoliofactorBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorBuffer::add(
  self : FinanceportfoliofactorBuffer,
  other : FinanceportfoliofactorBuffer,
) -> FinanceportfoliofactorBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorBuffer::copy(
  self : FinanceportfoliofactorBuffer,
) -> FinanceportfoliofactorBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorBuffer::fill(
  self : FinanceportfoliofactorBuffer,
  v : Double,
) -> FinanceportfoliofactorBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorBuffer::min(
  self : FinanceportfoliofactorBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorBuffer::max(
  self : FinanceportfoliofactorBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorBuffer::to_string(
  self : FinanceportfoliofactorBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_cursor_make(
  size : Int32,
) -> FinanceportfoliofactorCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorCursor::len(
  self : FinanceportfoliofactorCursor,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorCursor::get(
  self : FinanceportfoliofactorCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorCursor::set(
  self : FinanceportfoliofactorCursor,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorCursor::sum(
  self : FinanceportfoliofactorCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorCursor::mean(
  self : FinanceportfoliofactorCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorCursor::scale(
  self : FinanceportfoliofactorCursor,
  f : Double,
) -> FinanceportfoliofactorCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorCursor::add(
  self : FinanceportfoliofactorCursor,
  other : FinanceportfoliofactorCursor,
) -> FinanceportfoliofactorCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorCursor::copy(
  self : FinanceportfoliofactorCursor,
) -> FinanceportfoliofactorCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorCursor::fill(
  self : FinanceportfoliofactorCursor,
  v : Double,
) -> FinanceportfoliofactorCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorCursor::min(
  self : FinanceportfoliofactorCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorCursor::max(
  self : FinanceportfoliofactorCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorCursor::to_string(
  self : FinanceportfoliofactorCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_view_make(
  size : Int32,
) -> FinanceportfoliofactorView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorView::len(
  self : FinanceportfoliofactorView,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorView::get(
  self : FinanceportfoliofactorView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorView::set(
  self : FinanceportfoliofactorView,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorView::sum(
  self : FinanceportfoliofactorView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorView::mean(
  self : FinanceportfoliofactorView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorView::scale(
  self : FinanceportfoliofactorView,
  f : Double,
) -> FinanceportfoliofactorView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorView::add(
  self : FinanceportfoliofactorView,
  other : FinanceportfoliofactorView,
) -> FinanceportfoliofactorView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorView::copy(
  self : FinanceportfoliofactorView,
) -> FinanceportfoliofactorView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorView::fill(
  self : FinanceportfoliofactorView,
  v : Double,
) -> FinanceportfoliofactorView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorView::min(
  self : FinanceportfoliofactorView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorView::max(
  self : FinanceportfoliofactorView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorView::to_string(
  self : FinanceportfoliofactorView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_range_make(
  size : Int32,
) -> FinanceportfoliofactorRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorRange::len(
  self : FinanceportfoliofactorRange,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorRange::get(
  self : FinanceportfoliofactorRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorRange::set(
  self : FinanceportfoliofactorRange,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorRange::sum(
  self : FinanceportfoliofactorRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorRange::mean(
  self : FinanceportfoliofactorRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorRange::scale(
  self : FinanceportfoliofactorRange,
  f : Double,
) -> FinanceportfoliofactorRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorRange::add(
  self : FinanceportfoliofactorRange,
  other : FinanceportfoliofactorRange,
) -> FinanceportfoliofactorRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorRange::copy(
  self : FinanceportfoliofactorRange,
) -> FinanceportfoliofactorRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorRange::fill(
  self : FinanceportfoliofactorRange,
  v : Double,
) -> FinanceportfoliofactorRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorRange::min(
  self : FinanceportfoliofactorRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorRange::max(
  self : FinanceportfoliofactorRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorRange::to_string(
  self : FinanceportfoliofactorRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliofactorSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_factor_slice_make(
  size : Int32,
) -> FinanceportfoliofactorSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliofactorSlice::len(
  self : FinanceportfoliofactorSlice,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliofactorSlice::get(
  self : FinanceportfoliofactorSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliofactorSlice::set(
  self : FinanceportfoliofactorSlice,
  i : Int32,
  v : Double,
) -> FinanceportfoliofactorSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorSlice::sum(
  self : FinanceportfoliofactorSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliofactorSlice::mean(
  self : FinanceportfoliofactorSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliofactorSlice::scale(
  self : FinanceportfoliofactorSlice,
  f : Double,
) -> FinanceportfoliofactorSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorSlice::add(
  self : FinanceportfoliofactorSlice,
  other : FinanceportfoliofactorSlice,
) -> FinanceportfoliofactorSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorSlice::copy(
  self : FinanceportfoliofactorSlice,
) -> FinanceportfoliofactorSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorSlice::fill(
  self : FinanceportfoliofactorSlice,
  v : Double,
) -> FinanceportfoliofactorSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliofactorSlice::min(
  self : FinanceportfoliofactorSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliofactorSlice::max(
  self : FinanceportfoliofactorSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliofactorSlice::to_string(
  self : FinanceportfoliofactorSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
