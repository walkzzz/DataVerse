///|
///===
/// extcore/finance_portfolio_black_litterman
pub(all) struct FinanceportfolioblacklittermanPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_portfolio_black_litterman_make_point(
  x : Double,
  y : Double,
) -> FinanceportfolioblacklittermanPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_portfolio_black_litterman_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinanceportfolioblacklittermanPoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinanceportfolioblacklittermanPoint::x(
  self : FinanceportfolioblacklittermanPoint,
) -> Double {
  self.x
}

///|
pub fn FinanceportfolioblacklittermanPoint::y(
  self : FinanceportfolioblacklittermanPoint,
) -> Double {
  self.y
}

///|
pub fn FinanceportfolioblacklittermanPoint::z(
  self : FinanceportfolioblacklittermanPoint,
) -> Double {
  self.z
}

///|
pub fn FinanceportfolioblacklittermanPoint::label(
  self : FinanceportfolioblacklittermanPoint,
) -> Int32 {
  self.label
}

///|
pub fn FinanceportfolioblacklittermanPoint::dist(
  self : FinanceportfolioblacklittermanPoint,
  other : FinanceportfolioblacklittermanPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinanceportfolioblacklittermanPoint::add(
  self : FinanceportfolioblacklittermanPoint,
  other : FinanceportfolioblacklittermanPoint,
) -> FinanceportfolioblacklittermanPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinanceportfolioblacklittermanPoint::sub(
  self : FinanceportfolioblacklittermanPoint,
  other : FinanceportfolioblacklittermanPoint,
) -> FinanceportfolioblacklittermanPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinanceportfolioblacklittermanPoint::scale(
  self : FinanceportfolioblacklittermanPoint,
  s : Double,
) -> FinanceportfolioblacklittermanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinanceportfolioblacklittermanPoint::dot(
  self : FinanceportfolioblacklittermanPoint,
  other : FinanceportfolioblacklittermanPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinanceportfolioblacklittermanPoint::cross(
  self : FinanceportfolioblacklittermanPoint,
  other : FinanceportfolioblacklittermanPoint,
) -> FinanceportfolioblacklittermanPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinanceportfolioblacklittermanPoint::norm(
  self : FinanceportfolioblacklittermanPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinanceportfolioblacklittermanPoint::normalize(
  self : FinanceportfolioblacklittermanPoint,
) -> FinanceportfolioblacklittermanPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceportfolioblacklittermanPoint::negate(
  self : FinanceportfolioblacklittermanPoint,
) -> FinanceportfolioblacklittermanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinanceportfolioblacklittermanPoint::mid(
  self : FinanceportfolioblacklittermanPoint,
  other : FinanceportfolioblacklittermanPoint,
) -> FinanceportfolioblacklittermanPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinanceportfolioblacklittermanPoint::lerp(
  self : FinanceportfolioblacklittermanPoint,
  other : FinanceportfolioblacklittermanPoint,
  t : Double,
) -> FinanceportfolioblacklittermanPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinanceportfolioblacklittermanPoint::to_string(
  self : FinanceportfolioblacklittermanPoint,
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
pub(all) struct FinanceportfolioblacklittermanSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_portfolio_black_litterman_make_series(
  vals : Array[Double],
  name : String,
) -> FinanceportfolioblacklittermanSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinanceportfolioblacklittermanSeries::len(
  self : FinanceportfolioblacklittermanSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn FinanceportfolioblacklittermanSeries::sum(
  self : FinanceportfolioblacklittermanSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinanceportfolioblacklittermanSeries::mean(
  self : FinanceportfolioblacklittermanSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinanceportfolioblacklittermanSeries::min(
  self : FinanceportfolioblacklittermanSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinanceportfolioblacklittermanSeries::max(
  self : FinanceportfolioblacklittermanSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinanceportfolioblacklittermanSeries::range(
  self : FinanceportfolioblacklittermanSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinanceportfolioblacklittermanSeries::variance(
  self : FinanceportfolioblacklittermanSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinanceportfolioblacklittermanSeries::std(
  self : FinanceportfolioblacklittermanSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinanceportfolioblacklittermanSeries::median(
  self : FinanceportfolioblacklittermanSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinanceportfolioblacklittermanSeries::scale(
  self : FinanceportfolioblacklittermanSeries,
  f : Double,
) -> FinanceportfolioblacklittermanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinanceportfolioblacklittermanSeries::add(
  self : FinanceportfolioblacklittermanSeries,
  other : FinanceportfolioblacklittermanSeries,
) -> FinanceportfolioblacklittermanSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceportfolioblacklittermanSeries::sub(
  self : FinanceportfolioblacklittermanSeries,
  other : FinanceportfolioblacklittermanSeries,
) -> FinanceportfolioblacklittermanSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceportfolioblacklittermanSeries::normalize(
  self : FinanceportfolioblacklittermanSeries,
) -> FinanceportfolioblacklittermanSeries {
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
pub fn FinanceportfolioblacklittermanSeries::cumsum(
  self : FinanceportfolioblacklittermanSeries,
) -> FinanceportfolioblacklittermanSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinanceportfolioblacklittermanSeries::to_string(
  self : FinanceportfolioblacklittermanSeries,
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
pub(all) struct FinanceportfolioblacklittermanMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_portfolio_black_litterman_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinanceportfolioblacklittermanMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_portfolio_black_litterman_matrix_identity(
  n : Int32,
) -> FinanceportfolioblacklittermanMatrix {
  let m = finance_portfolio_black_litterman_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinanceportfolioblacklittermanMatrix::get(
  self : FinanceportfolioblacklittermanMatrix,
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
pub fn FinanceportfolioblacklittermanMatrix::transpose(
  self : FinanceportfolioblacklittermanMatrix,
) -> FinanceportfolioblacklittermanMatrix {
  let result = finance_portfolio_black_litterman_make_matrix(
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
pub fn FinanceportfolioblacklittermanMatrix::add(
  self : FinanceportfolioblacklittermanMatrix,
  other : FinanceportfolioblacklittermanMatrix,
) -> FinanceportfolioblacklittermanMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_portfolio_black_litterman_make_matrix(
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
pub fn FinanceportfolioblacklittermanMatrix::scale(
  self : FinanceportfolioblacklittermanMatrix,
  s : Double,
) -> FinanceportfolioblacklittermanMatrix {
  let result = finance_portfolio_black_litterman_make_matrix(
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
pub fn FinanceportfolioblacklittermanMatrix::multiply(
  self : FinanceportfolioblacklittermanMatrix,
  other : FinanceportfolioblacklittermanMatrix,
) -> FinanceportfolioblacklittermanMatrix {
  if self.cols != other.rows {
    return finance_portfolio_black_litterman_make_matrix(
      self.rows,
      other.cols,
      0.0,
    )
  }
  let result = finance_portfolio_black_litterman_make_matrix(
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
pub fn FinanceportfolioblacklittermanMatrix::trace(
  self : FinanceportfolioblacklittermanMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinanceportfolioblacklittermanMatrix::det(
  self : FinanceportfolioblacklittermanMatrix,
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
pub fn FinanceportfolioblacklittermanMatrix::norm(
  self : FinanceportfolioblacklittermanMatrix,
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
pub fn FinanceportfolioblacklittermanMatrix::to_string(
  self : FinanceportfolioblacklittermanMatrix,
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
pub(all) struct FinanceportfolioblacklittermanVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_portfolio_black_litterman_make_vector(
  comps : Array[Double],
) -> FinanceportfolioblacklittermanVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_portfolio_black_litterman_vector_zero(
  dim : Int32,
) -> FinanceportfolioblacklittermanVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinanceportfolioblacklittermanVector::add(
  self : FinanceportfolioblacklittermanVector,
  other : FinanceportfolioblacklittermanVector,
) -> FinanceportfolioblacklittermanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceportfolioblacklittermanVector::sub(
  self : FinanceportfolioblacklittermanVector,
  other : FinanceportfolioblacklittermanVector,
) -> FinanceportfolioblacklittermanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceportfolioblacklittermanVector::scale(
  self : FinanceportfolioblacklittermanVector,
  s : Double,
) -> FinanceportfolioblacklittermanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinanceportfolioblacklittermanVector::dot(
  self : FinanceportfolioblacklittermanVector,
  other : FinanceportfolioblacklittermanVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinanceportfolioblacklittermanVector::norm(
  self : FinanceportfolioblacklittermanVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinanceportfolioblacklittermanVector::normalize(
  self : FinanceportfolioblacklittermanVector,
) -> FinanceportfolioblacklittermanVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceportfolioblacklittermanVector::dist(
  self : FinanceportfolioblacklittermanVector,
  other : FinanceportfolioblacklittermanVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinanceportfolioblacklittermanVector::to_string(
  self : FinanceportfolioblacklittermanVector,
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
pub(all) struct FinanceportfolioblacklittermanFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_frame_make(
  size : Int32,
) -> FinanceportfolioblacklittermanFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanFrame::len(
  self : FinanceportfolioblacklittermanFrame,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanFrame::get(
  self : FinanceportfolioblacklittermanFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanFrame::set(
  self : FinanceportfolioblacklittermanFrame,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanFrame::sum(
  self : FinanceportfolioblacklittermanFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanFrame::mean(
  self : FinanceportfolioblacklittermanFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanFrame::scale(
  self : FinanceportfolioblacklittermanFrame,
  f : Double,
) -> FinanceportfolioblacklittermanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanFrame::add(
  self : FinanceportfolioblacklittermanFrame,
  other : FinanceportfolioblacklittermanFrame,
) -> FinanceportfolioblacklittermanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanFrame::copy(
  self : FinanceportfolioblacklittermanFrame,
) -> FinanceportfolioblacklittermanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanFrame::fill(
  self : FinanceportfolioblacklittermanFrame,
  v : Double,
) -> FinanceportfolioblacklittermanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanFrame::min(
  self : FinanceportfolioblacklittermanFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanFrame::max(
  self : FinanceportfolioblacklittermanFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanFrame::to_string(
  self : FinanceportfolioblacklittermanFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_table_make(
  size : Int32,
) -> FinanceportfolioblacklittermanTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanTable::len(
  self : FinanceportfolioblacklittermanTable,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanTable::get(
  self : FinanceportfolioblacklittermanTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanTable::set(
  self : FinanceportfolioblacklittermanTable,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanTable::sum(
  self : FinanceportfolioblacklittermanTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanTable::mean(
  self : FinanceportfolioblacklittermanTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanTable::scale(
  self : FinanceportfolioblacklittermanTable,
  f : Double,
) -> FinanceportfolioblacklittermanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanTable::add(
  self : FinanceportfolioblacklittermanTable,
  other : FinanceportfolioblacklittermanTable,
) -> FinanceportfolioblacklittermanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanTable::copy(
  self : FinanceportfolioblacklittermanTable,
) -> FinanceportfolioblacklittermanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanTable::fill(
  self : FinanceportfolioblacklittermanTable,
  v : Double,
) -> FinanceportfolioblacklittermanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanTable::min(
  self : FinanceportfolioblacklittermanTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanTable::max(
  self : FinanceportfolioblacklittermanTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanTable::to_string(
  self : FinanceportfolioblacklittermanTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_graphn_make(
  size : Int32,
) -> FinanceportfolioblacklittermanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanGraphN::len(
  self : FinanceportfolioblacklittermanGraphN,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanGraphN::get(
  self : FinanceportfolioblacklittermanGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanGraphN::set(
  self : FinanceportfolioblacklittermanGraphN,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanGraphN::sum(
  self : FinanceportfolioblacklittermanGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanGraphN::mean(
  self : FinanceportfolioblacklittermanGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanGraphN::scale(
  self : FinanceportfolioblacklittermanGraphN,
  f : Double,
) -> FinanceportfolioblacklittermanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanGraphN::add(
  self : FinanceportfolioblacklittermanGraphN,
  other : FinanceportfolioblacklittermanGraphN,
) -> FinanceportfolioblacklittermanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanGraphN::copy(
  self : FinanceportfolioblacklittermanGraphN,
) -> FinanceportfolioblacklittermanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanGraphN::fill(
  self : FinanceportfolioblacklittermanGraphN,
  v : Double,
) -> FinanceportfolioblacklittermanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanGraphN::min(
  self : FinanceportfolioblacklittermanGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanGraphN::max(
  self : FinanceportfolioblacklittermanGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanGraphN::to_string(
  self : FinanceportfolioblacklittermanGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_node_make(
  size : Int32,
) -> FinanceportfolioblacklittermanNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanNode::len(
  self : FinanceportfolioblacklittermanNode,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanNode::get(
  self : FinanceportfolioblacklittermanNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanNode::set(
  self : FinanceportfolioblacklittermanNode,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanNode::sum(
  self : FinanceportfolioblacklittermanNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanNode::mean(
  self : FinanceportfolioblacklittermanNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanNode::scale(
  self : FinanceportfolioblacklittermanNode,
  f : Double,
) -> FinanceportfolioblacklittermanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanNode::add(
  self : FinanceportfolioblacklittermanNode,
  other : FinanceportfolioblacklittermanNode,
) -> FinanceportfolioblacklittermanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanNode::copy(
  self : FinanceportfolioblacklittermanNode,
) -> FinanceportfolioblacklittermanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanNode::fill(
  self : FinanceportfolioblacklittermanNode,
  v : Double,
) -> FinanceportfolioblacklittermanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanNode::min(
  self : FinanceportfolioblacklittermanNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanNode::max(
  self : FinanceportfolioblacklittermanNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanNode::to_string(
  self : FinanceportfolioblacklittermanNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_edge_make(
  size : Int32,
) -> FinanceportfolioblacklittermanEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanEdge::len(
  self : FinanceportfolioblacklittermanEdge,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanEdge::get(
  self : FinanceportfolioblacklittermanEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanEdge::set(
  self : FinanceportfolioblacklittermanEdge,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanEdge::sum(
  self : FinanceportfolioblacklittermanEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanEdge::mean(
  self : FinanceportfolioblacklittermanEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanEdge::scale(
  self : FinanceportfolioblacklittermanEdge,
  f : Double,
) -> FinanceportfolioblacklittermanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanEdge::add(
  self : FinanceportfolioblacklittermanEdge,
  other : FinanceportfolioblacklittermanEdge,
) -> FinanceportfolioblacklittermanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanEdge::copy(
  self : FinanceportfolioblacklittermanEdge,
) -> FinanceportfolioblacklittermanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanEdge::fill(
  self : FinanceportfolioblacklittermanEdge,
  v : Double,
) -> FinanceportfolioblacklittermanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanEdge::min(
  self : FinanceportfolioblacklittermanEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanEdge::max(
  self : FinanceportfolioblacklittermanEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanEdge::to_string(
  self : FinanceportfolioblacklittermanEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_path_make(
  size : Int32,
) -> FinanceportfolioblacklittermanPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanPath::len(
  self : FinanceportfolioblacklittermanPath,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanPath::get(
  self : FinanceportfolioblacklittermanPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanPath::set(
  self : FinanceportfolioblacklittermanPath,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanPath::sum(
  self : FinanceportfolioblacklittermanPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanPath::mean(
  self : FinanceportfolioblacklittermanPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanPath::scale(
  self : FinanceportfolioblacklittermanPath,
  f : Double,
) -> FinanceportfolioblacklittermanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanPath::add(
  self : FinanceportfolioblacklittermanPath,
  other : FinanceportfolioblacklittermanPath,
) -> FinanceportfolioblacklittermanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanPath::copy(
  self : FinanceportfolioblacklittermanPath,
) -> FinanceportfolioblacklittermanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanPath::fill(
  self : FinanceportfolioblacklittermanPath,
  v : Double,
) -> FinanceportfolioblacklittermanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanPath::min(
  self : FinanceportfolioblacklittermanPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanPath::max(
  self : FinanceportfolioblacklittermanPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanPath::to_string(
  self : FinanceportfolioblacklittermanPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_cluster_make(
  size : Int32,
) -> FinanceportfolioblacklittermanCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanCluster::len(
  self : FinanceportfolioblacklittermanCluster,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanCluster::get(
  self : FinanceportfolioblacklittermanCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanCluster::set(
  self : FinanceportfolioblacklittermanCluster,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanCluster::sum(
  self : FinanceportfolioblacklittermanCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanCluster::mean(
  self : FinanceportfolioblacklittermanCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanCluster::scale(
  self : FinanceportfolioblacklittermanCluster,
  f : Double,
) -> FinanceportfolioblacklittermanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanCluster::add(
  self : FinanceportfolioblacklittermanCluster,
  other : FinanceportfolioblacklittermanCluster,
) -> FinanceportfolioblacklittermanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanCluster::copy(
  self : FinanceportfolioblacklittermanCluster,
) -> FinanceportfolioblacklittermanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanCluster::fill(
  self : FinanceportfolioblacklittermanCluster,
  v : Double,
) -> FinanceportfolioblacklittermanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanCluster::min(
  self : FinanceportfolioblacklittermanCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanCluster::max(
  self : FinanceportfolioblacklittermanCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanCluster::to_string(
  self : FinanceportfolioblacklittermanCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_model_make(
  size : Int32,
) -> FinanceportfolioblacklittermanModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanModel::len(
  self : FinanceportfolioblacklittermanModel,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanModel::get(
  self : FinanceportfolioblacklittermanModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanModel::set(
  self : FinanceportfolioblacklittermanModel,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanModel::sum(
  self : FinanceportfolioblacklittermanModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanModel::mean(
  self : FinanceportfolioblacklittermanModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanModel::scale(
  self : FinanceportfolioblacklittermanModel,
  f : Double,
) -> FinanceportfolioblacklittermanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanModel::add(
  self : FinanceportfolioblacklittermanModel,
  other : FinanceportfolioblacklittermanModel,
) -> FinanceportfolioblacklittermanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanModel::copy(
  self : FinanceportfolioblacklittermanModel,
) -> FinanceportfolioblacklittermanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanModel::fill(
  self : FinanceportfolioblacklittermanModel,
  v : Double,
) -> FinanceportfolioblacklittermanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanModel::min(
  self : FinanceportfolioblacklittermanModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanModel::max(
  self : FinanceportfolioblacklittermanModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanModel::to_string(
  self : FinanceportfolioblacklittermanModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_layer_make(
  size : Int32,
) -> FinanceportfolioblacklittermanLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanLayer::len(
  self : FinanceportfolioblacklittermanLayer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanLayer::get(
  self : FinanceportfolioblacklittermanLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanLayer::set(
  self : FinanceportfolioblacklittermanLayer,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanLayer::sum(
  self : FinanceportfolioblacklittermanLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanLayer::mean(
  self : FinanceportfolioblacklittermanLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanLayer::scale(
  self : FinanceportfolioblacklittermanLayer,
  f : Double,
) -> FinanceportfolioblacklittermanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanLayer::add(
  self : FinanceportfolioblacklittermanLayer,
  other : FinanceportfolioblacklittermanLayer,
) -> FinanceportfolioblacklittermanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanLayer::copy(
  self : FinanceportfolioblacklittermanLayer,
) -> FinanceportfolioblacklittermanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanLayer::fill(
  self : FinanceportfolioblacklittermanLayer,
  v : Double,
) -> FinanceportfolioblacklittermanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanLayer::min(
  self : FinanceportfolioblacklittermanLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanLayer::max(
  self : FinanceportfolioblacklittermanLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanLayer::to_string(
  self : FinanceportfolioblacklittermanLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_buffer_make(
  size : Int32,
) -> FinanceportfolioblacklittermanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanBuffer::len(
  self : FinanceportfolioblacklittermanBuffer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanBuffer::get(
  self : FinanceportfolioblacklittermanBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanBuffer::set(
  self : FinanceportfolioblacklittermanBuffer,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanBuffer::sum(
  self : FinanceportfolioblacklittermanBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanBuffer::mean(
  self : FinanceportfolioblacklittermanBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanBuffer::scale(
  self : FinanceportfolioblacklittermanBuffer,
  f : Double,
) -> FinanceportfolioblacklittermanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanBuffer::add(
  self : FinanceportfolioblacklittermanBuffer,
  other : FinanceportfolioblacklittermanBuffer,
) -> FinanceportfolioblacklittermanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanBuffer::copy(
  self : FinanceportfolioblacklittermanBuffer,
) -> FinanceportfolioblacklittermanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanBuffer::fill(
  self : FinanceportfolioblacklittermanBuffer,
  v : Double,
) -> FinanceportfolioblacklittermanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanBuffer::min(
  self : FinanceportfolioblacklittermanBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanBuffer::max(
  self : FinanceportfolioblacklittermanBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanBuffer::to_string(
  self : FinanceportfolioblacklittermanBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_cursor_make(
  size : Int32,
) -> FinanceportfolioblacklittermanCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanCursor::len(
  self : FinanceportfolioblacklittermanCursor,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanCursor::get(
  self : FinanceportfolioblacklittermanCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanCursor::set(
  self : FinanceportfolioblacklittermanCursor,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanCursor::sum(
  self : FinanceportfolioblacklittermanCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanCursor::mean(
  self : FinanceportfolioblacklittermanCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanCursor::scale(
  self : FinanceportfolioblacklittermanCursor,
  f : Double,
) -> FinanceportfolioblacklittermanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanCursor::add(
  self : FinanceportfolioblacklittermanCursor,
  other : FinanceportfolioblacklittermanCursor,
) -> FinanceportfolioblacklittermanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanCursor::copy(
  self : FinanceportfolioblacklittermanCursor,
) -> FinanceportfolioblacklittermanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanCursor::fill(
  self : FinanceportfolioblacklittermanCursor,
  v : Double,
) -> FinanceportfolioblacklittermanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanCursor::min(
  self : FinanceportfolioblacklittermanCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanCursor::max(
  self : FinanceportfolioblacklittermanCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanCursor::to_string(
  self : FinanceportfolioblacklittermanCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_view_make(
  size : Int32,
) -> FinanceportfolioblacklittermanView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanView::len(
  self : FinanceportfolioblacklittermanView,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanView::get(
  self : FinanceportfolioblacklittermanView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanView::set(
  self : FinanceportfolioblacklittermanView,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanView::sum(
  self : FinanceportfolioblacklittermanView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanView::mean(
  self : FinanceportfolioblacklittermanView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanView::scale(
  self : FinanceportfolioblacklittermanView,
  f : Double,
) -> FinanceportfolioblacklittermanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanView::add(
  self : FinanceportfolioblacklittermanView,
  other : FinanceportfolioblacklittermanView,
) -> FinanceportfolioblacklittermanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanView::copy(
  self : FinanceportfolioblacklittermanView,
) -> FinanceportfolioblacklittermanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanView::fill(
  self : FinanceportfolioblacklittermanView,
  v : Double,
) -> FinanceportfolioblacklittermanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanView::min(
  self : FinanceportfolioblacklittermanView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanView::max(
  self : FinanceportfolioblacklittermanView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanView::to_string(
  self : FinanceportfolioblacklittermanView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_range_make(
  size : Int32,
) -> FinanceportfolioblacklittermanRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanRange::len(
  self : FinanceportfolioblacklittermanRange,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanRange::get(
  self : FinanceportfolioblacklittermanRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanRange::set(
  self : FinanceportfolioblacklittermanRange,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanRange::sum(
  self : FinanceportfolioblacklittermanRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanRange::mean(
  self : FinanceportfolioblacklittermanRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanRange::scale(
  self : FinanceportfolioblacklittermanRange,
  f : Double,
) -> FinanceportfolioblacklittermanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanRange::add(
  self : FinanceportfolioblacklittermanRange,
  other : FinanceportfolioblacklittermanRange,
) -> FinanceportfolioblacklittermanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanRange::copy(
  self : FinanceportfolioblacklittermanRange,
) -> FinanceportfolioblacklittermanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanRange::fill(
  self : FinanceportfolioblacklittermanRange,
  v : Double,
) -> FinanceportfolioblacklittermanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanRange::min(
  self : FinanceportfolioblacklittermanRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanRange::max(
  self : FinanceportfolioblacklittermanRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanRange::to_string(
  self : FinanceportfolioblacklittermanRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioblacklittermanSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_black_litterman_slice_make(
  size : Int32,
) -> FinanceportfolioblacklittermanSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioblacklittermanSlice::len(
  self : FinanceportfolioblacklittermanSlice,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioblacklittermanSlice::get(
  self : FinanceportfolioblacklittermanSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioblacklittermanSlice::set(
  self : FinanceportfolioblacklittermanSlice,
  i : Int32,
  v : Double,
) -> FinanceportfolioblacklittermanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanSlice::sum(
  self : FinanceportfolioblacklittermanSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioblacklittermanSlice::mean(
  self : FinanceportfolioblacklittermanSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioblacklittermanSlice::scale(
  self : FinanceportfolioblacklittermanSlice,
  f : Double,
) -> FinanceportfolioblacklittermanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanSlice::add(
  self : FinanceportfolioblacklittermanSlice,
  other : FinanceportfolioblacklittermanSlice,
) -> FinanceportfolioblacklittermanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanSlice::copy(
  self : FinanceportfolioblacklittermanSlice,
) -> FinanceportfolioblacklittermanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanSlice::fill(
  self : FinanceportfolioblacklittermanSlice,
  v : Double,
) -> FinanceportfolioblacklittermanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioblacklittermanSlice::min(
  self : FinanceportfolioblacklittermanSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioblacklittermanSlice::max(
  self : FinanceportfolioblacklittermanSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioblacklittermanSlice::to_string(
  self : FinanceportfolioblacklittermanSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
