///|
///===
/// extcore/finance_portfolio_apt
pub(all) struct FinanceportfolioaptPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_portfolio_apt_make_point(
  x : Double,
  y : Double,
) -> FinanceportfolioaptPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_portfolio_apt_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinanceportfolioaptPoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinanceportfolioaptPoint::x(self : FinanceportfolioaptPoint) -> Double {
  self.x
}

///|
pub fn FinanceportfolioaptPoint::y(self : FinanceportfolioaptPoint) -> Double {
  self.y
}

///|
pub fn FinanceportfolioaptPoint::z(self : FinanceportfolioaptPoint) -> Double {
  self.z
}

///|
pub fn FinanceportfolioaptPoint::label(
  self : FinanceportfolioaptPoint,
) -> Int32 {
  self.label
}

///|
pub fn FinanceportfolioaptPoint::dist(
  self : FinanceportfolioaptPoint,
  other : FinanceportfolioaptPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinanceportfolioaptPoint::add(
  self : FinanceportfolioaptPoint,
  other : FinanceportfolioaptPoint,
) -> FinanceportfolioaptPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinanceportfolioaptPoint::sub(
  self : FinanceportfolioaptPoint,
  other : FinanceportfolioaptPoint,
) -> FinanceportfolioaptPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinanceportfolioaptPoint::scale(
  self : FinanceportfolioaptPoint,
  s : Double,
) -> FinanceportfolioaptPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinanceportfolioaptPoint::dot(
  self : FinanceportfolioaptPoint,
  other : FinanceportfolioaptPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinanceportfolioaptPoint::cross(
  self : FinanceportfolioaptPoint,
  other : FinanceportfolioaptPoint,
) -> FinanceportfolioaptPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinanceportfolioaptPoint::norm(
  self : FinanceportfolioaptPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinanceportfolioaptPoint::normalize(
  self : FinanceportfolioaptPoint,
) -> FinanceportfolioaptPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceportfolioaptPoint::negate(
  self : FinanceportfolioaptPoint,
) -> FinanceportfolioaptPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinanceportfolioaptPoint::mid(
  self : FinanceportfolioaptPoint,
  other : FinanceportfolioaptPoint,
) -> FinanceportfolioaptPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinanceportfolioaptPoint::lerp(
  self : FinanceportfolioaptPoint,
  other : FinanceportfolioaptPoint,
  t : Double,
) -> FinanceportfolioaptPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinanceportfolioaptPoint::to_string(
  self : FinanceportfolioaptPoint,
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
pub(all) struct FinanceportfolioaptSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_portfolio_apt_make_series(
  vals : Array[Double],
  name : String,
) -> FinanceportfolioaptSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinanceportfolioaptSeries::len(
  self : FinanceportfolioaptSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn FinanceportfolioaptSeries::sum(
  self : FinanceportfolioaptSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinanceportfolioaptSeries::mean(
  self : FinanceportfolioaptSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinanceportfolioaptSeries::min(
  self : FinanceportfolioaptSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinanceportfolioaptSeries::max(
  self : FinanceportfolioaptSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinanceportfolioaptSeries::range(
  self : FinanceportfolioaptSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinanceportfolioaptSeries::variance(
  self : FinanceportfolioaptSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinanceportfolioaptSeries::std(
  self : FinanceportfolioaptSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinanceportfolioaptSeries::median(
  self : FinanceportfolioaptSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinanceportfolioaptSeries::scale(
  self : FinanceportfolioaptSeries,
  f : Double,
) -> FinanceportfolioaptSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinanceportfolioaptSeries::add(
  self : FinanceportfolioaptSeries,
  other : FinanceportfolioaptSeries,
) -> FinanceportfolioaptSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceportfolioaptSeries::sub(
  self : FinanceportfolioaptSeries,
  other : FinanceportfolioaptSeries,
) -> FinanceportfolioaptSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceportfolioaptSeries::normalize(
  self : FinanceportfolioaptSeries,
) -> FinanceportfolioaptSeries {
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
pub fn FinanceportfolioaptSeries::cumsum(
  self : FinanceportfolioaptSeries,
) -> FinanceportfolioaptSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinanceportfolioaptSeries::to_string(
  self : FinanceportfolioaptSeries,
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
pub(all) struct FinanceportfolioaptMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_portfolio_apt_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinanceportfolioaptMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_portfolio_apt_matrix_identity(
  n : Int32,
) -> FinanceportfolioaptMatrix {
  let m = finance_portfolio_apt_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinanceportfolioaptMatrix::get(
  self : FinanceportfolioaptMatrix,
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
pub fn FinanceportfolioaptMatrix::transpose(
  self : FinanceportfolioaptMatrix,
) -> FinanceportfolioaptMatrix {
  let result = finance_portfolio_apt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceportfolioaptMatrix::add(
  self : FinanceportfolioaptMatrix,
  other : FinanceportfolioaptMatrix,
) -> FinanceportfolioaptMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_portfolio_apt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceportfolioaptMatrix::scale(
  self : FinanceportfolioaptMatrix,
  s : Double,
) -> FinanceportfolioaptMatrix {
  let result = finance_portfolio_apt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn FinanceportfolioaptMatrix::multiply(
  self : FinanceportfolioaptMatrix,
  other : FinanceportfolioaptMatrix,
) -> FinanceportfolioaptMatrix {
  if self.cols != other.rows {
    return finance_portfolio_apt_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = finance_portfolio_apt_make_matrix(self.rows, other.cols, 0.0)
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
pub fn FinanceportfolioaptMatrix::trace(
  self : FinanceportfolioaptMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinanceportfolioaptMatrix::det(
  self : FinanceportfolioaptMatrix,
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
pub fn FinanceportfolioaptMatrix::norm(
  self : FinanceportfolioaptMatrix,
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
pub fn FinanceportfolioaptMatrix::to_string(
  self : FinanceportfolioaptMatrix,
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
pub(all) struct FinanceportfolioaptVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_portfolio_apt_make_vector(
  comps : Array[Double],
) -> FinanceportfolioaptVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_portfolio_apt_vector_zero(
  dim : Int32,
) -> FinanceportfolioaptVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinanceportfolioaptVector::add(
  self : FinanceportfolioaptVector,
  other : FinanceportfolioaptVector,
) -> FinanceportfolioaptVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceportfolioaptVector::sub(
  self : FinanceportfolioaptVector,
  other : FinanceportfolioaptVector,
) -> FinanceportfolioaptVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceportfolioaptVector::scale(
  self : FinanceportfolioaptVector,
  s : Double,
) -> FinanceportfolioaptVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinanceportfolioaptVector::dot(
  self : FinanceportfolioaptVector,
  other : FinanceportfolioaptVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinanceportfolioaptVector::norm(
  self : FinanceportfolioaptVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinanceportfolioaptVector::normalize(
  self : FinanceportfolioaptVector,
) -> FinanceportfolioaptVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceportfolioaptVector::dist(
  self : FinanceportfolioaptVector,
  other : FinanceportfolioaptVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinanceportfolioaptVector::to_string(
  self : FinanceportfolioaptVector,
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
pub(all) struct FinanceportfolioaptFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_frame_make(
  size : Int32,
) -> FinanceportfolioaptFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptFrame::len(self : FinanceportfolioaptFrame) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptFrame::get(
  self : FinanceportfolioaptFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptFrame::set(
  self : FinanceportfolioaptFrame,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptFrame::sum(self : FinanceportfolioaptFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptFrame::mean(
  self : FinanceportfolioaptFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptFrame::scale(
  self : FinanceportfolioaptFrame,
  f : Double,
) -> FinanceportfolioaptFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptFrame::add(
  self : FinanceportfolioaptFrame,
  other : FinanceportfolioaptFrame,
) -> FinanceportfolioaptFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptFrame::copy(
  self : FinanceportfolioaptFrame,
) -> FinanceportfolioaptFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptFrame::fill(
  self : FinanceportfolioaptFrame,
  v : Double,
) -> FinanceportfolioaptFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptFrame::min(self : FinanceportfolioaptFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptFrame::max(self : FinanceportfolioaptFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptFrame::to_string(
  self : FinanceportfolioaptFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_table_make(
  size : Int32,
) -> FinanceportfolioaptTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptTable::len(self : FinanceportfolioaptTable) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptTable::get(
  self : FinanceportfolioaptTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptTable::set(
  self : FinanceportfolioaptTable,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptTable::sum(self : FinanceportfolioaptTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptTable::mean(
  self : FinanceportfolioaptTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptTable::scale(
  self : FinanceportfolioaptTable,
  f : Double,
) -> FinanceportfolioaptTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptTable::add(
  self : FinanceportfolioaptTable,
  other : FinanceportfolioaptTable,
) -> FinanceportfolioaptTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptTable::copy(
  self : FinanceportfolioaptTable,
) -> FinanceportfolioaptTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptTable::fill(
  self : FinanceportfolioaptTable,
  v : Double,
) -> FinanceportfolioaptTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptTable::min(self : FinanceportfolioaptTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptTable::max(self : FinanceportfolioaptTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptTable::to_string(
  self : FinanceportfolioaptTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_graphn_make(
  size : Int32,
) -> FinanceportfolioaptGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptGraphN::len(
  self : FinanceportfolioaptGraphN,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptGraphN::get(
  self : FinanceportfolioaptGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptGraphN::set(
  self : FinanceportfolioaptGraphN,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptGraphN::sum(
  self : FinanceportfolioaptGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptGraphN::mean(
  self : FinanceportfolioaptGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptGraphN::scale(
  self : FinanceportfolioaptGraphN,
  f : Double,
) -> FinanceportfolioaptGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptGraphN::add(
  self : FinanceportfolioaptGraphN,
  other : FinanceportfolioaptGraphN,
) -> FinanceportfolioaptGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptGraphN::copy(
  self : FinanceportfolioaptGraphN,
) -> FinanceportfolioaptGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptGraphN::fill(
  self : FinanceportfolioaptGraphN,
  v : Double,
) -> FinanceportfolioaptGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptGraphN::min(
  self : FinanceportfolioaptGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptGraphN::max(
  self : FinanceportfolioaptGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptGraphN::to_string(
  self : FinanceportfolioaptGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_node_make(size : Int32) -> FinanceportfolioaptNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptNode::len(self : FinanceportfolioaptNode) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptNode::get(
  self : FinanceportfolioaptNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptNode::set(
  self : FinanceportfolioaptNode,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptNode::sum(self : FinanceportfolioaptNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptNode::mean(self : FinanceportfolioaptNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptNode::scale(
  self : FinanceportfolioaptNode,
  f : Double,
) -> FinanceportfolioaptNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptNode::add(
  self : FinanceportfolioaptNode,
  other : FinanceportfolioaptNode,
) -> FinanceportfolioaptNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptNode::copy(
  self : FinanceportfolioaptNode,
) -> FinanceportfolioaptNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptNode::fill(
  self : FinanceportfolioaptNode,
  v : Double,
) -> FinanceportfolioaptNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptNode::min(self : FinanceportfolioaptNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptNode::max(self : FinanceportfolioaptNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptNode::to_string(
  self : FinanceportfolioaptNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_edge_make(size : Int32) -> FinanceportfolioaptEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptEdge::len(self : FinanceportfolioaptEdge) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptEdge::get(
  self : FinanceportfolioaptEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptEdge::set(
  self : FinanceportfolioaptEdge,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptEdge::sum(self : FinanceportfolioaptEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptEdge::mean(self : FinanceportfolioaptEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptEdge::scale(
  self : FinanceportfolioaptEdge,
  f : Double,
) -> FinanceportfolioaptEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptEdge::add(
  self : FinanceportfolioaptEdge,
  other : FinanceportfolioaptEdge,
) -> FinanceportfolioaptEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptEdge::copy(
  self : FinanceportfolioaptEdge,
) -> FinanceportfolioaptEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptEdge::fill(
  self : FinanceportfolioaptEdge,
  v : Double,
) -> FinanceportfolioaptEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptEdge::min(self : FinanceportfolioaptEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptEdge::max(self : FinanceportfolioaptEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptEdge::to_string(
  self : FinanceportfolioaptEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_path_make(size : Int32) -> FinanceportfolioaptPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptPath::len(self : FinanceportfolioaptPath) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptPath::get(
  self : FinanceportfolioaptPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptPath::set(
  self : FinanceportfolioaptPath,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptPath::sum(self : FinanceportfolioaptPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptPath::mean(self : FinanceportfolioaptPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptPath::scale(
  self : FinanceportfolioaptPath,
  f : Double,
) -> FinanceportfolioaptPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptPath::add(
  self : FinanceportfolioaptPath,
  other : FinanceportfolioaptPath,
) -> FinanceportfolioaptPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptPath::copy(
  self : FinanceportfolioaptPath,
) -> FinanceportfolioaptPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptPath::fill(
  self : FinanceportfolioaptPath,
  v : Double,
) -> FinanceportfolioaptPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptPath::min(self : FinanceportfolioaptPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptPath::max(self : FinanceportfolioaptPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptPath::to_string(
  self : FinanceportfolioaptPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_cluster_make(
  size : Int32,
) -> FinanceportfolioaptCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptCluster::len(
  self : FinanceportfolioaptCluster,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptCluster::get(
  self : FinanceportfolioaptCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptCluster::set(
  self : FinanceportfolioaptCluster,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptCluster::sum(
  self : FinanceportfolioaptCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptCluster::mean(
  self : FinanceportfolioaptCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptCluster::scale(
  self : FinanceportfolioaptCluster,
  f : Double,
) -> FinanceportfolioaptCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptCluster::add(
  self : FinanceportfolioaptCluster,
  other : FinanceportfolioaptCluster,
) -> FinanceportfolioaptCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptCluster::copy(
  self : FinanceportfolioaptCluster,
) -> FinanceportfolioaptCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptCluster::fill(
  self : FinanceportfolioaptCluster,
  v : Double,
) -> FinanceportfolioaptCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptCluster::min(
  self : FinanceportfolioaptCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptCluster::max(
  self : FinanceportfolioaptCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptCluster::to_string(
  self : FinanceportfolioaptCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_model_make(
  size : Int32,
) -> FinanceportfolioaptModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptModel::len(self : FinanceportfolioaptModel) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptModel::get(
  self : FinanceportfolioaptModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptModel::set(
  self : FinanceportfolioaptModel,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptModel::sum(self : FinanceportfolioaptModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptModel::mean(
  self : FinanceportfolioaptModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptModel::scale(
  self : FinanceportfolioaptModel,
  f : Double,
) -> FinanceportfolioaptModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptModel::add(
  self : FinanceportfolioaptModel,
  other : FinanceportfolioaptModel,
) -> FinanceportfolioaptModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptModel::copy(
  self : FinanceportfolioaptModel,
) -> FinanceportfolioaptModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptModel::fill(
  self : FinanceportfolioaptModel,
  v : Double,
) -> FinanceportfolioaptModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptModel::min(self : FinanceportfolioaptModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptModel::max(self : FinanceportfolioaptModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptModel::to_string(
  self : FinanceportfolioaptModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_layer_make(
  size : Int32,
) -> FinanceportfolioaptLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptLayer::len(self : FinanceportfolioaptLayer) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptLayer::get(
  self : FinanceportfolioaptLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptLayer::set(
  self : FinanceportfolioaptLayer,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptLayer::sum(self : FinanceportfolioaptLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptLayer::mean(
  self : FinanceportfolioaptLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptLayer::scale(
  self : FinanceportfolioaptLayer,
  f : Double,
) -> FinanceportfolioaptLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptLayer::add(
  self : FinanceportfolioaptLayer,
  other : FinanceportfolioaptLayer,
) -> FinanceportfolioaptLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptLayer::copy(
  self : FinanceportfolioaptLayer,
) -> FinanceportfolioaptLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptLayer::fill(
  self : FinanceportfolioaptLayer,
  v : Double,
) -> FinanceportfolioaptLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptLayer::min(self : FinanceportfolioaptLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptLayer::max(self : FinanceportfolioaptLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptLayer::to_string(
  self : FinanceportfolioaptLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_buffer_make(
  size : Int32,
) -> FinanceportfolioaptBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptBuffer::len(
  self : FinanceportfolioaptBuffer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptBuffer::get(
  self : FinanceportfolioaptBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptBuffer::set(
  self : FinanceportfolioaptBuffer,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptBuffer::sum(
  self : FinanceportfolioaptBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptBuffer::mean(
  self : FinanceportfolioaptBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptBuffer::scale(
  self : FinanceportfolioaptBuffer,
  f : Double,
) -> FinanceportfolioaptBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptBuffer::add(
  self : FinanceportfolioaptBuffer,
  other : FinanceportfolioaptBuffer,
) -> FinanceportfolioaptBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptBuffer::copy(
  self : FinanceportfolioaptBuffer,
) -> FinanceportfolioaptBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptBuffer::fill(
  self : FinanceportfolioaptBuffer,
  v : Double,
) -> FinanceportfolioaptBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptBuffer::min(
  self : FinanceportfolioaptBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptBuffer::max(
  self : FinanceportfolioaptBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptBuffer::to_string(
  self : FinanceportfolioaptBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_cursor_make(
  size : Int32,
) -> FinanceportfolioaptCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptCursor::len(
  self : FinanceportfolioaptCursor,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptCursor::get(
  self : FinanceportfolioaptCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptCursor::set(
  self : FinanceportfolioaptCursor,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptCursor::sum(
  self : FinanceportfolioaptCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptCursor::mean(
  self : FinanceportfolioaptCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptCursor::scale(
  self : FinanceportfolioaptCursor,
  f : Double,
) -> FinanceportfolioaptCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptCursor::add(
  self : FinanceportfolioaptCursor,
  other : FinanceportfolioaptCursor,
) -> FinanceportfolioaptCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptCursor::copy(
  self : FinanceportfolioaptCursor,
) -> FinanceportfolioaptCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptCursor::fill(
  self : FinanceportfolioaptCursor,
  v : Double,
) -> FinanceportfolioaptCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptCursor::min(
  self : FinanceportfolioaptCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptCursor::max(
  self : FinanceportfolioaptCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptCursor::to_string(
  self : FinanceportfolioaptCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_view_make(size : Int32) -> FinanceportfolioaptView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptView::len(self : FinanceportfolioaptView) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptView::get(
  self : FinanceportfolioaptView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptView::set(
  self : FinanceportfolioaptView,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptView::sum(self : FinanceportfolioaptView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptView::mean(self : FinanceportfolioaptView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptView::scale(
  self : FinanceportfolioaptView,
  f : Double,
) -> FinanceportfolioaptView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptView::add(
  self : FinanceportfolioaptView,
  other : FinanceportfolioaptView,
) -> FinanceportfolioaptView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptView::copy(
  self : FinanceportfolioaptView,
) -> FinanceportfolioaptView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptView::fill(
  self : FinanceportfolioaptView,
  v : Double,
) -> FinanceportfolioaptView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptView::min(self : FinanceportfolioaptView) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptView::max(self : FinanceportfolioaptView) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptView::to_string(
  self : FinanceportfolioaptView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_range_make(
  size : Int32,
) -> FinanceportfolioaptRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptRange::len(self : FinanceportfolioaptRange) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptRange::get(
  self : FinanceportfolioaptRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptRange::set(
  self : FinanceportfolioaptRange,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptRange::sum(self : FinanceportfolioaptRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptRange::mean(
  self : FinanceportfolioaptRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptRange::scale(
  self : FinanceportfolioaptRange,
  f : Double,
) -> FinanceportfolioaptRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptRange::add(
  self : FinanceportfolioaptRange,
  other : FinanceportfolioaptRange,
) -> FinanceportfolioaptRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptRange::copy(
  self : FinanceportfolioaptRange,
) -> FinanceportfolioaptRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptRange::fill(
  self : FinanceportfolioaptRange,
  v : Double,
) -> FinanceportfolioaptRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptRange::min(self : FinanceportfolioaptRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptRange::max(self : FinanceportfolioaptRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptRange::to_string(
  self : FinanceportfolioaptRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfolioaptSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_apt_slice_make(
  size : Int32,
) -> FinanceportfolioaptSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfolioaptSlice::len(self : FinanceportfolioaptSlice) -> Int32 {
  self.size
}

///|
pub fn FinanceportfolioaptSlice::get(
  self : FinanceportfolioaptSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfolioaptSlice::set(
  self : FinanceportfolioaptSlice,
  i : Int32,
  v : Double,
) -> FinanceportfolioaptSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptSlice::sum(self : FinanceportfolioaptSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfolioaptSlice::mean(
  self : FinanceportfolioaptSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfolioaptSlice::scale(
  self : FinanceportfolioaptSlice,
  f : Double,
) -> FinanceportfolioaptSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptSlice::add(
  self : FinanceportfolioaptSlice,
  other : FinanceportfolioaptSlice,
) -> FinanceportfolioaptSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptSlice::copy(
  self : FinanceportfolioaptSlice,
) -> FinanceportfolioaptSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptSlice::fill(
  self : FinanceportfolioaptSlice,
  v : Double,
) -> FinanceportfolioaptSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfolioaptSlice::min(self : FinanceportfolioaptSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfolioaptSlice::max(self : FinanceportfolioaptSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfolioaptSlice::to_string(
  self : FinanceportfolioaptSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
