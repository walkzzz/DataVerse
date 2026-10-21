///|
///===
/// extcore/finance_portfolio_hierarchical
pub(all) struct FinanceportfoliohierarchicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_portfolio_hierarchical_make_point(
  x : Double,
  y : Double,
) -> FinanceportfoliohierarchicalPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_portfolio_hierarchical_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinanceportfoliohierarchicalPoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinanceportfoliohierarchicalPoint::x(
  self : FinanceportfoliohierarchicalPoint,
) -> Double {
  self.x
}

///|
pub fn FinanceportfoliohierarchicalPoint::y(
  self : FinanceportfoliohierarchicalPoint,
) -> Double {
  self.y
}

///|
pub fn FinanceportfoliohierarchicalPoint::z(
  self : FinanceportfoliohierarchicalPoint,
) -> Double {
  self.z
}

///|
pub fn FinanceportfoliohierarchicalPoint::label(
  self : FinanceportfoliohierarchicalPoint,
) -> Int32 {
  self.label
}

///|
pub fn FinanceportfoliohierarchicalPoint::dist(
  self : FinanceportfoliohierarchicalPoint,
  other : FinanceportfoliohierarchicalPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinanceportfoliohierarchicalPoint::add(
  self : FinanceportfoliohierarchicalPoint,
  other : FinanceportfoliohierarchicalPoint,
) -> FinanceportfoliohierarchicalPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliohierarchicalPoint::sub(
  self : FinanceportfoliohierarchicalPoint,
  other : FinanceportfoliohierarchicalPoint,
) -> FinanceportfoliohierarchicalPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliohierarchicalPoint::scale(
  self : FinanceportfoliohierarchicalPoint,
  s : Double,
) -> FinanceportfoliohierarchicalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinanceportfoliohierarchicalPoint::dot(
  self : FinanceportfoliohierarchicalPoint,
  other : FinanceportfoliohierarchicalPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinanceportfoliohierarchicalPoint::cross(
  self : FinanceportfoliohierarchicalPoint,
  other : FinanceportfoliohierarchicalPoint,
) -> FinanceportfoliohierarchicalPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinanceportfoliohierarchicalPoint::norm(
  self : FinanceportfoliohierarchicalPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinanceportfoliohierarchicalPoint::normalize(
  self : FinanceportfoliohierarchicalPoint,
) -> FinanceportfoliohierarchicalPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceportfoliohierarchicalPoint::negate(
  self : FinanceportfoliohierarchicalPoint,
) -> FinanceportfoliohierarchicalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinanceportfoliohierarchicalPoint::mid(
  self : FinanceportfoliohierarchicalPoint,
  other : FinanceportfoliohierarchicalPoint,
) -> FinanceportfoliohierarchicalPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliohierarchicalPoint::lerp(
  self : FinanceportfoliohierarchicalPoint,
  other : FinanceportfoliohierarchicalPoint,
  t : Double,
) -> FinanceportfoliohierarchicalPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinanceportfoliohierarchicalPoint::to_string(
  self : FinanceportfoliohierarchicalPoint,
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
pub(all) struct FinanceportfoliohierarchicalSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_portfolio_hierarchical_make_series(
  vals : Array[Double],
  name : String,
) -> FinanceportfoliohierarchicalSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinanceportfoliohierarchicalSeries::len(
  self : FinanceportfoliohierarchicalSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn FinanceportfoliohierarchicalSeries::sum(
  self : FinanceportfoliohierarchicalSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinanceportfoliohierarchicalSeries::mean(
  self : FinanceportfoliohierarchicalSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinanceportfoliohierarchicalSeries::min(
  self : FinanceportfoliohierarchicalSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinanceportfoliohierarchicalSeries::max(
  self : FinanceportfoliohierarchicalSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinanceportfoliohierarchicalSeries::range(
  self : FinanceportfoliohierarchicalSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinanceportfoliohierarchicalSeries::variance(
  self : FinanceportfoliohierarchicalSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinanceportfoliohierarchicalSeries::std(
  self : FinanceportfoliohierarchicalSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinanceportfoliohierarchicalSeries::median(
  self : FinanceportfoliohierarchicalSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinanceportfoliohierarchicalSeries::scale(
  self : FinanceportfoliohierarchicalSeries,
  f : Double,
) -> FinanceportfoliohierarchicalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinanceportfoliohierarchicalSeries::add(
  self : FinanceportfoliohierarchicalSeries,
  other : FinanceportfoliohierarchicalSeries,
) -> FinanceportfoliohierarchicalSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceportfoliohierarchicalSeries::sub(
  self : FinanceportfoliohierarchicalSeries,
  other : FinanceportfoliohierarchicalSeries,
) -> FinanceportfoliohierarchicalSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceportfoliohierarchicalSeries::normalize(
  self : FinanceportfoliohierarchicalSeries,
) -> FinanceportfoliohierarchicalSeries {
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
pub fn FinanceportfoliohierarchicalSeries::cumsum(
  self : FinanceportfoliohierarchicalSeries,
) -> FinanceportfoliohierarchicalSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinanceportfoliohierarchicalSeries::to_string(
  self : FinanceportfoliohierarchicalSeries,
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
pub(all) struct FinanceportfoliohierarchicalMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_portfolio_hierarchical_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinanceportfoliohierarchicalMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_portfolio_hierarchical_matrix_identity(
  n : Int32,
) -> FinanceportfoliohierarchicalMatrix {
  let m = finance_portfolio_hierarchical_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinanceportfoliohierarchicalMatrix::get(
  self : FinanceportfoliohierarchicalMatrix,
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
pub fn FinanceportfoliohierarchicalMatrix::transpose(
  self : FinanceportfoliohierarchicalMatrix,
) -> FinanceportfoliohierarchicalMatrix {
  let result = finance_portfolio_hierarchical_make_matrix(
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
pub fn FinanceportfoliohierarchicalMatrix::add(
  self : FinanceportfoliohierarchicalMatrix,
  other : FinanceportfoliohierarchicalMatrix,
) -> FinanceportfoliohierarchicalMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_portfolio_hierarchical_make_matrix(
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
pub fn FinanceportfoliohierarchicalMatrix::scale(
  self : FinanceportfoliohierarchicalMatrix,
  s : Double,
) -> FinanceportfoliohierarchicalMatrix {
  let result = finance_portfolio_hierarchical_make_matrix(
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
pub fn FinanceportfoliohierarchicalMatrix::multiply(
  self : FinanceportfoliohierarchicalMatrix,
  other : FinanceportfoliohierarchicalMatrix,
) -> FinanceportfoliohierarchicalMatrix {
  if self.cols != other.rows {
    return finance_portfolio_hierarchical_make_matrix(
      self.rows,
      other.cols,
      0.0,
    )
  }
  let result = finance_portfolio_hierarchical_make_matrix(
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
pub fn FinanceportfoliohierarchicalMatrix::trace(
  self : FinanceportfoliohierarchicalMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinanceportfoliohierarchicalMatrix::det(
  self : FinanceportfoliohierarchicalMatrix,
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
pub fn FinanceportfoliohierarchicalMatrix::norm(
  self : FinanceportfoliohierarchicalMatrix,
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
pub fn FinanceportfoliohierarchicalMatrix::to_string(
  self : FinanceportfoliohierarchicalMatrix,
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
pub(all) struct FinanceportfoliohierarchicalVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_portfolio_hierarchical_make_vector(
  comps : Array[Double],
) -> FinanceportfoliohierarchicalVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_portfolio_hierarchical_vector_zero(
  dim : Int32,
) -> FinanceportfoliohierarchicalVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinanceportfoliohierarchicalVector::add(
  self : FinanceportfoliohierarchicalVector,
  other : FinanceportfoliohierarchicalVector,
) -> FinanceportfoliohierarchicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceportfoliohierarchicalVector::sub(
  self : FinanceportfoliohierarchicalVector,
  other : FinanceportfoliohierarchicalVector,
) -> FinanceportfoliohierarchicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceportfoliohierarchicalVector::scale(
  self : FinanceportfoliohierarchicalVector,
  s : Double,
) -> FinanceportfoliohierarchicalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinanceportfoliohierarchicalVector::dot(
  self : FinanceportfoliohierarchicalVector,
  other : FinanceportfoliohierarchicalVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinanceportfoliohierarchicalVector::norm(
  self : FinanceportfoliohierarchicalVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinanceportfoliohierarchicalVector::normalize(
  self : FinanceportfoliohierarchicalVector,
) -> FinanceportfoliohierarchicalVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceportfoliohierarchicalVector::dist(
  self : FinanceportfoliohierarchicalVector,
  other : FinanceportfoliohierarchicalVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinanceportfoliohierarchicalVector::to_string(
  self : FinanceportfoliohierarchicalVector,
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
pub(all) struct FinanceportfoliohierarchicalFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_frame_make(
  size : Int32,
) -> FinanceportfoliohierarchicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalFrame::len(
  self : FinanceportfoliohierarchicalFrame,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalFrame::get(
  self : FinanceportfoliohierarchicalFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalFrame::set(
  self : FinanceportfoliohierarchicalFrame,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalFrame::sum(
  self : FinanceportfoliohierarchicalFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalFrame::mean(
  self : FinanceportfoliohierarchicalFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalFrame::scale(
  self : FinanceportfoliohierarchicalFrame,
  f : Double,
) -> FinanceportfoliohierarchicalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalFrame::add(
  self : FinanceportfoliohierarchicalFrame,
  other : FinanceportfoliohierarchicalFrame,
) -> FinanceportfoliohierarchicalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalFrame::copy(
  self : FinanceportfoliohierarchicalFrame,
) -> FinanceportfoliohierarchicalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalFrame::fill(
  self : FinanceportfoliohierarchicalFrame,
  v : Double,
) -> FinanceportfoliohierarchicalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalFrame::min(
  self : FinanceportfoliohierarchicalFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalFrame::max(
  self : FinanceportfoliohierarchicalFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalFrame::to_string(
  self : FinanceportfoliohierarchicalFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_table_make(
  size : Int32,
) -> FinanceportfoliohierarchicalTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalTable::len(
  self : FinanceportfoliohierarchicalTable,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalTable::get(
  self : FinanceportfoliohierarchicalTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalTable::set(
  self : FinanceportfoliohierarchicalTable,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalTable::sum(
  self : FinanceportfoliohierarchicalTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalTable::mean(
  self : FinanceportfoliohierarchicalTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalTable::scale(
  self : FinanceportfoliohierarchicalTable,
  f : Double,
) -> FinanceportfoliohierarchicalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalTable::add(
  self : FinanceportfoliohierarchicalTable,
  other : FinanceportfoliohierarchicalTable,
) -> FinanceportfoliohierarchicalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalTable::copy(
  self : FinanceportfoliohierarchicalTable,
) -> FinanceportfoliohierarchicalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalTable::fill(
  self : FinanceportfoliohierarchicalTable,
  v : Double,
) -> FinanceportfoliohierarchicalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalTable::min(
  self : FinanceportfoliohierarchicalTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalTable::max(
  self : FinanceportfoliohierarchicalTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalTable::to_string(
  self : FinanceportfoliohierarchicalTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_graphn_make(
  size : Int32,
) -> FinanceportfoliohierarchicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalGraphN::len(
  self : FinanceportfoliohierarchicalGraphN,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalGraphN::get(
  self : FinanceportfoliohierarchicalGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalGraphN::set(
  self : FinanceportfoliohierarchicalGraphN,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalGraphN::sum(
  self : FinanceportfoliohierarchicalGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalGraphN::mean(
  self : FinanceportfoliohierarchicalGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalGraphN::scale(
  self : FinanceportfoliohierarchicalGraphN,
  f : Double,
) -> FinanceportfoliohierarchicalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalGraphN::add(
  self : FinanceportfoliohierarchicalGraphN,
  other : FinanceportfoliohierarchicalGraphN,
) -> FinanceportfoliohierarchicalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalGraphN::copy(
  self : FinanceportfoliohierarchicalGraphN,
) -> FinanceportfoliohierarchicalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalGraphN::fill(
  self : FinanceportfoliohierarchicalGraphN,
  v : Double,
) -> FinanceportfoliohierarchicalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalGraphN::min(
  self : FinanceportfoliohierarchicalGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalGraphN::max(
  self : FinanceportfoliohierarchicalGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalGraphN::to_string(
  self : FinanceportfoliohierarchicalGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_node_make(
  size : Int32,
) -> FinanceportfoliohierarchicalNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalNode::len(
  self : FinanceportfoliohierarchicalNode,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalNode::get(
  self : FinanceportfoliohierarchicalNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalNode::set(
  self : FinanceportfoliohierarchicalNode,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalNode::sum(
  self : FinanceportfoliohierarchicalNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalNode::mean(
  self : FinanceportfoliohierarchicalNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalNode::scale(
  self : FinanceportfoliohierarchicalNode,
  f : Double,
) -> FinanceportfoliohierarchicalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalNode::add(
  self : FinanceportfoliohierarchicalNode,
  other : FinanceportfoliohierarchicalNode,
) -> FinanceportfoliohierarchicalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalNode::copy(
  self : FinanceportfoliohierarchicalNode,
) -> FinanceportfoliohierarchicalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalNode::fill(
  self : FinanceportfoliohierarchicalNode,
  v : Double,
) -> FinanceportfoliohierarchicalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalNode::min(
  self : FinanceportfoliohierarchicalNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalNode::max(
  self : FinanceportfoliohierarchicalNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalNode::to_string(
  self : FinanceportfoliohierarchicalNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_edge_make(
  size : Int32,
) -> FinanceportfoliohierarchicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalEdge::len(
  self : FinanceportfoliohierarchicalEdge,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalEdge::get(
  self : FinanceportfoliohierarchicalEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalEdge::set(
  self : FinanceportfoliohierarchicalEdge,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalEdge::sum(
  self : FinanceportfoliohierarchicalEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalEdge::mean(
  self : FinanceportfoliohierarchicalEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalEdge::scale(
  self : FinanceportfoliohierarchicalEdge,
  f : Double,
) -> FinanceportfoliohierarchicalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalEdge::add(
  self : FinanceportfoliohierarchicalEdge,
  other : FinanceportfoliohierarchicalEdge,
) -> FinanceportfoliohierarchicalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalEdge::copy(
  self : FinanceportfoliohierarchicalEdge,
) -> FinanceportfoliohierarchicalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalEdge::fill(
  self : FinanceportfoliohierarchicalEdge,
  v : Double,
) -> FinanceportfoliohierarchicalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalEdge::min(
  self : FinanceportfoliohierarchicalEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalEdge::max(
  self : FinanceportfoliohierarchicalEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalEdge::to_string(
  self : FinanceportfoliohierarchicalEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_path_make(
  size : Int32,
) -> FinanceportfoliohierarchicalPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalPath::len(
  self : FinanceportfoliohierarchicalPath,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalPath::get(
  self : FinanceportfoliohierarchicalPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalPath::set(
  self : FinanceportfoliohierarchicalPath,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalPath::sum(
  self : FinanceportfoliohierarchicalPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalPath::mean(
  self : FinanceportfoliohierarchicalPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalPath::scale(
  self : FinanceportfoliohierarchicalPath,
  f : Double,
) -> FinanceportfoliohierarchicalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalPath::add(
  self : FinanceportfoliohierarchicalPath,
  other : FinanceportfoliohierarchicalPath,
) -> FinanceportfoliohierarchicalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalPath::copy(
  self : FinanceportfoliohierarchicalPath,
) -> FinanceportfoliohierarchicalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalPath::fill(
  self : FinanceportfoliohierarchicalPath,
  v : Double,
) -> FinanceportfoliohierarchicalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalPath::min(
  self : FinanceportfoliohierarchicalPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalPath::max(
  self : FinanceportfoliohierarchicalPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalPath::to_string(
  self : FinanceportfoliohierarchicalPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_cluster_make(
  size : Int32,
) -> FinanceportfoliohierarchicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalCluster::len(
  self : FinanceportfoliohierarchicalCluster,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalCluster::get(
  self : FinanceportfoliohierarchicalCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalCluster::set(
  self : FinanceportfoliohierarchicalCluster,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalCluster::sum(
  self : FinanceportfoliohierarchicalCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalCluster::mean(
  self : FinanceportfoliohierarchicalCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalCluster::scale(
  self : FinanceportfoliohierarchicalCluster,
  f : Double,
) -> FinanceportfoliohierarchicalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalCluster::add(
  self : FinanceportfoliohierarchicalCluster,
  other : FinanceportfoliohierarchicalCluster,
) -> FinanceportfoliohierarchicalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalCluster::copy(
  self : FinanceportfoliohierarchicalCluster,
) -> FinanceportfoliohierarchicalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalCluster::fill(
  self : FinanceportfoliohierarchicalCluster,
  v : Double,
) -> FinanceportfoliohierarchicalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalCluster::min(
  self : FinanceportfoliohierarchicalCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalCluster::max(
  self : FinanceportfoliohierarchicalCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalCluster::to_string(
  self : FinanceportfoliohierarchicalCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_model_make(
  size : Int32,
) -> FinanceportfoliohierarchicalModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalModel::len(
  self : FinanceportfoliohierarchicalModel,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalModel::get(
  self : FinanceportfoliohierarchicalModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalModel::set(
  self : FinanceportfoliohierarchicalModel,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalModel::sum(
  self : FinanceportfoliohierarchicalModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalModel::mean(
  self : FinanceportfoliohierarchicalModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalModel::scale(
  self : FinanceportfoliohierarchicalModel,
  f : Double,
) -> FinanceportfoliohierarchicalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalModel::add(
  self : FinanceportfoliohierarchicalModel,
  other : FinanceportfoliohierarchicalModel,
) -> FinanceportfoliohierarchicalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalModel::copy(
  self : FinanceportfoliohierarchicalModel,
) -> FinanceportfoliohierarchicalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalModel::fill(
  self : FinanceportfoliohierarchicalModel,
  v : Double,
) -> FinanceportfoliohierarchicalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalModel::min(
  self : FinanceportfoliohierarchicalModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalModel::max(
  self : FinanceportfoliohierarchicalModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalModel::to_string(
  self : FinanceportfoliohierarchicalModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_layer_make(
  size : Int32,
) -> FinanceportfoliohierarchicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalLayer::len(
  self : FinanceportfoliohierarchicalLayer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalLayer::get(
  self : FinanceportfoliohierarchicalLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalLayer::set(
  self : FinanceportfoliohierarchicalLayer,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalLayer::sum(
  self : FinanceportfoliohierarchicalLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalLayer::mean(
  self : FinanceportfoliohierarchicalLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalLayer::scale(
  self : FinanceportfoliohierarchicalLayer,
  f : Double,
) -> FinanceportfoliohierarchicalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalLayer::add(
  self : FinanceportfoliohierarchicalLayer,
  other : FinanceportfoliohierarchicalLayer,
) -> FinanceportfoliohierarchicalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalLayer::copy(
  self : FinanceportfoliohierarchicalLayer,
) -> FinanceportfoliohierarchicalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalLayer::fill(
  self : FinanceportfoliohierarchicalLayer,
  v : Double,
) -> FinanceportfoliohierarchicalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalLayer::min(
  self : FinanceportfoliohierarchicalLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalLayer::max(
  self : FinanceportfoliohierarchicalLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalLayer::to_string(
  self : FinanceportfoliohierarchicalLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_buffer_make(
  size : Int32,
) -> FinanceportfoliohierarchicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalBuffer::len(
  self : FinanceportfoliohierarchicalBuffer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalBuffer::get(
  self : FinanceportfoliohierarchicalBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalBuffer::set(
  self : FinanceportfoliohierarchicalBuffer,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalBuffer::sum(
  self : FinanceportfoliohierarchicalBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalBuffer::mean(
  self : FinanceportfoliohierarchicalBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalBuffer::scale(
  self : FinanceportfoliohierarchicalBuffer,
  f : Double,
) -> FinanceportfoliohierarchicalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalBuffer::add(
  self : FinanceportfoliohierarchicalBuffer,
  other : FinanceportfoliohierarchicalBuffer,
) -> FinanceportfoliohierarchicalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalBuffer::copy(
  self : FinanceportfoliohierarchicalBuffer,
) -> FinanceportfoliohierarchicalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalBuffer::fill(
  self : FinanceportfoliohierarchicalBuffer,
  v : Double,
) -> FinanceportfoliohierarchicalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalBuffer::min(
  self : FinanceportfoliohierarchicalBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalBuffer::max(
  self : FinanceportfoliohierarchicalBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalBuffer::to_string(
  self : FinanceportfoliohierarchicalBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_cursor_make(
  size : Int32,
) -> FinanceportfoliohierarchicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalCursor::len(
  self : FinanceportfoliohierarchicalCursor,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalCursor::get(
  self : FinanceportfoliohierarchicalCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalCursor::set(
  self : FinanceportfoliohierarchicalCursor,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalCursor::sum(
  self : FinanceportfoliohierarchicalCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalCursor::mean(
  self : FinanceportfoliohierarchicalCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalCursor::scale(
  self : FinanceportfoliohierarchicalCursor,
  f : Double,
) -> FinanceportfoliohierarchicalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalCursor::add(
  self : FinanceportfoliohierarchicalCursor,
  other : FinanceportfoliohierarchicalCursor,
) -> FinanceportfoliohierarchicalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalCursor::copy(
  self : FinanceportfoliohierarchicalCursor,
) -> FinanceportfoliohierarchicalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalCursor::fill(
  self : FinanceportfoliohierarchicalCursor,
  v : Double,
) -> FinanceportfoliohierarchicalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalCursor::min(
  self : FinanceportfoliohierarchicalCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalCursor::max(
  self : FinanceportfoliohierarchicalCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalCursor::to_string(
  self : FinanceportfoliohierarchicalCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_view_make(
  size : Int32,
) -> FinanceportfoliohierarchicalView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalView::len(
  self : FinanceportfoliohierarchicalView,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalView::get(
  self : FinanceportfoliohierarchicalView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalView::set(
  self : FinanceportfoliohierarchicalView,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalView::sum(
  self : FinanceportfoliohierarchicalView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalView::mean(
  self : FinanceportfoliohierarchicalView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalView::scale(
  self : FinanceportfoliohierarchicalView,
  f : Double,
) -> FinanceportfoliohierarchicalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalView::add(
  self : FinanceportfoliohierarchicalView,
  other : FinanceportfoliohierarchicalView,
) -> FinanceportfoliohierarchicalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalView::copy(
  self : FinanceportfoliohierarchicalView,
) -> FinanceportfoliohierarchicalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalView::fill(
  self : FinanceportfoliohierarchicalView,
  v : Double,
) -> FinanceportfoliohierarchicalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalView::min(
  self : FinanceportfoliohierarchicalView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalView::max(
  self : FinanceportfoliohierarchicalView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalView::to_string(
  self : FinanceportfoliohierarchicalView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_range_make(
  size : Int32,
) -> FinanceportfoliohierarchicalRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalRange::len(
  self : FinanceportfoliohierarchicalRange,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalRange::get(
  self : FinanceportfoliohierarchicalRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalRange::set(
  self : FinanceportfoliohierarchicalRange,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalRange::sum(
  self : FinanceportfoliohierarchicalRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalRange::mean(
  self : FinanceportfoliohierarchicalRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalRange::scale(
  self : FinanceportfoliohierarchicalRange,
  f : Double,
) -> FinanceportfoliohierarchicalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalRange::add(
  self : FinanceportfoliohierarchicalRange,
  other : FinanceportfoliohierarchicalRange,
) -> FinanceportfoliohierarchicalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalRange::copy(
  self : FinanceportfoliohierarchicalRange,
) -> FinanceportfoliohierarchicalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalRange::fill(
  self : FinanceportfoliohierarchicalRange,
  v : Double,
) -> FinanceportfoliohierarchicalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalRange::min(
  self : FinanceportfoliohierarchicalRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalRange::max(
  self : FinanceportfoliohierarchicalRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalRange::to_string(
  self : FinanceportfoliohierarchicalRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceportfoliohierarchicalSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_portfolio_hierarchical_slice_make(
  size : Int32,
) -> FinanceportfoliohierarchicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceportfoliohierarchicalSlice::len(
  self : FinanceportfoliohierarchicalSlice,
) -> Int32 {
  self.size
}

///|
pub fn FinanceportfoliohierarchicalSlice::get(
  self : FinanceportfoliohierarchicalSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceportfoliohierarchicalSlice::set(
  self : FinanceportfoliohierarchicalSlice,
  i : Int32,
  v : Double,
) -> FinanceportfoliohierarchicalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalSlice::sum(
  self : FinanceportfoliohierarchicalSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceportfoliohierarchicalSlice::mean(
  self : FinanceportfoliohierarchicalSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceportfoliohierarchicalSlice::scale(
  self : FinanceportfoliohierarchicalSlice,
  f : Double,
) -> FinanceportfoliohierarchicalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalSlice::add(
  self : FinanceportfoliohierarchicalSlice,
  other : FinanceportfoliohierarchicalSlice,
) -> FinanceportfoliohierarchicalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalSlice::copy(
  self : FinanceportfoliohierarchicalSlice,
) -> FinanceportfoliohierarchicalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalSlice::fill(
  self : FinanceportfoliohierarchicalSlice,
  v : Double,
) -> FinanceportfoliohierarchicalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceportfoliohierarchicalSlice::min(
  self : FinanceportfoliohierarchicalSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceportfoliohierarchicalSlice::max(
  self : FinanceportfoliohierarchicalSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceportfoliohierarchicalSlice::to_string(
  self : FinanceportfoliohierarchicalSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
