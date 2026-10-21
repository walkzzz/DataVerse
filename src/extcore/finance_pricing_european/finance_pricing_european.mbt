///|
///===
/// extcore/finance_pricing_european
pub(all) struct FinancepricingeuropeanPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_pricing_european_make_point(
  x : Double,
  y : Double,
) -> FinancepricingeuropeanPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_pricing_european_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinancepricingeuropeanPoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinancepricingeuropeanPoint::x(
  self : FinancepricingeuropeanPoint,
) -> Double {
  self.x
}

///|
pub fn FinancepricingeuropeanPoint::y(
  self : FinancepricingeuropeanPoint,
) -> Double {
  self.y
}

///|
pub fn FinancepricingeuropeanPoint::z(
  self : FinancepricingeuropeanPoint,
) -> Double {
  self.z
}

///|
pub fn FinancepricingeuropeanPoint::label(
  self : FinancepricingeuropeanPoint,
) -> Int32 {
  self.label
}

///|
pub fn FinancepricingeuropeanPoint::dist(
  self : FinancepricingeuropeanPoint,
  other : FinancepricingeuropeanPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinancepricingeuropeanPoint::add(
  self : FinancepricingeuropeanPoint,
  other : FinancepricingeuropeanPoint,
) -> FinancepricingeuropeanPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinancepricingeuropeanPoint::sub(
  self : FinancepricingeuropeanPoint,
  other : FinancepricingeuropeanPoint,
) -> FinancepricingeuropeanPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinancepricingeuropeanPoint::scale(
  self : FinancepricingeuropeanPoint,
  s : Double,
) -> FinancepricingeuropeanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinancepricingeuropeanPoint::dot(
  self : FinancepricingeuropeanPoint,
  other : FinancepricingeuropeanPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinancepricingeuropeanPoint::cross(
  self : FinancepricingeuropeanPoint,
  other : FinancepricingeuropeanPoint,
) -> FinancepricingeuropeanPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinancepricingeuropeanPoint::norm(
  self : FinancepricingeuropeanPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinancepricingeuropeanPoint::normalize(
  self : FinancepricingeuropeanPoint,
) -> FinancepricingeuropeanPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinancepricingeuropeanPoint::negate(
  self : FinancepricingeuropeanPoint,
) -> FinancepricingeuropeanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinancepricingeuropeanPoint::mid(
  self : FinancepricingeuropeanPoint,
  other : FinancepricingeuropeanPoint,
) -> FinancepricingeuropeanPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinancepricingeuropeanPoint::lerp(
  self : FinancepricingeuropeanPoint,
  other : FinancepricingeuropeanPoint,
  t : Double,
) -> FinancepricingeuropeanPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinancepricingeuropeanPoint::to_string(
  self : FinancepricingeuropeanPoint,
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
pub(all) struct FinancepricingeuropeanSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_pricing_european_make_series(
  vals : Array[Double],
  name : String,
) -> FinancepricingeuropeanSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinancepricingeuropeanSeries::len(
  self : FinancepricingeuropeanSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn FinancepricingeuropeanSeries::sum(
  self : FinancepricingeuropeanSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinancepricingeuropeanSeries::mean(
  self : FinancepricingeuropeanSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinancepricingeuropeanSeries::min(
  self : FinancepricingeuropeanSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinancepricingeuropeanSeries::max(
  self : FinancepricingeuropeanSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinancepricingeuropeanSeries::range(
  self : FinancepricingeuropeanSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinancepricingeuropeanSeries::variance(
  self : FinancepricingeuropeanSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinancepricingeuropeanSeries::std(
  self : FinancepricingeuropeanSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinancepricingeuropeanSeries::median(
  self : FinancepricingeuropeanSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinancepricingeuropeanSeries::scale(
  self : FinancepricingeuropeanSeries,
  f : Double,
) -> FinancepricingeuropeanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinancepricingeuropeanSeries::add(
  self : FinancepricingeuropeanSeries,
  other : FinancepricingeuropeanSeries,
) -> FinancepricingeuropeanSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinancepricingeuropeanSeries::sub(
  self : FinancepricingeuropeanSeries,
  other : FinancepricingeuropeanSeries,
) -> FinancepricingeuropeanSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinancepricingeuropeanSeries::normalize(
  self : FinancepricingeuropeanSeries,
) -> FinancepricingeuropeanSeries {
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
pub fn FinancepricingeuropeanSeries::cumsum(
  self : FinancepricingeuropeanSeries,
) -> FinancepricingeuropeanSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinancepricingeuropeanSeries::to_string(
  self : FinancepricingeuropeanSeries,
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
pub(all) struct FinancepricingeuropeanMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_pricing_european_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinancepricingeuropeanMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_pricing_european_matrix_identity(
  n : Int32,
) -> FinancepricingeuropeanMatrix {
  let m = finance_pricing_european_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinancepricingeuropeanMatrix::get(
  self : FinancepricingeuropeanMatrix,
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
pub fn FinancepricingeuropeanMatrix::transpose(
  self : FinancepricingeuropeanMatrix,
) -> FinancepricingeuropeanMatrix {
  let result = finance_pricing_european_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn FinancepricingeuropeanMatrix::add(
  self : FinancepricingeuropeanMatrix,
  other : FinancepricingeuropeanMatrix,
) -> FinancepricingeuropeanMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_pricing_european_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn FinancepricingeuropeanMatrix::scale(
  self : FinancepricingeuropeanMatrix,
  s : Double,
) -> FinancepricingeuropeanMatrix {
  let result = finance_pricing_european_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn FinancepricingeuropeanMatrix::multiply(
  self : FinancepricingeuropeanMatrix,
  other : FinancepricingeuropeanMatrix,
) -> FinancepricingeuropeanMatrix {
  if self.cols != other.rows {
    return finance_pricing_european_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = finance_pricing_european_make_matrix(self.rows, other.cols, 0.0)
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
pub fn FinancepricingeuropeanMatrix::trace(
  self : FinancepricingeuropeanMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinancepricingeuropeanMatrix::det(
  self : FinancepricingeuropeanMatrix,
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
pub fn FinancepricingeuropeanMatrix::norm(
  self : FinancepricingeuropeanMatrix,
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
pub fn FinancepricingeuropeanMatrix::to_string(
  self : FinancepricingeuropeanMatrix,
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
pub(all) struct FinancepricingeuropeanVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_pricing_european_make_vector(
  comps : Array[Double],
) -> FinancepricingeuropeanVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_pricing_european_vector_zero(
  dim : Int32,
) -> FinancepricingeuropeanVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinancepricingeuropeanVector::add(
  self : FinancepricingeuropeanVector,
  other : FinancepricingeuropeanVector,
) -> FinancepricingeuropeanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinancepricingeuropeanVector::sub(
  self : FinancepricingeuropeanVector,
  other : FinancepricingeuropeanVector,
) -> FinancepricingeuropeanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinancepricingeuropeanVector::scale(
  self : FinancepricingeuropeanVector,
  s : Double,
) -> FinancepricingeuropeanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinancepricingeuropeanVector::dot(
  self : FinancepricingeuropeanVector,
  other : FinancepricingeuropeanVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinancepricingeuropeanVector::norm(
  self : FinancepricingeuropeanVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinancepricingeuropeanVector::normalize(
  self : FinancepricingeuropeanVector,
) -> FinancepricingeuropeanVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinancepricingeuropeanVector::dist(
  self : FinancepricingeuropeanVector,
  other : FinancepricingeuropeanVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinancepricingeuropeanVector::to_string(
  self : FinancepricingeuropeanVector,
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
pub(all) struct FinancepricingeuropeanFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_frame_make(
  size : Int32,
) -> FinancepricingeuropeanFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanFrame::len(
  self : FinancepricingeuropeanFrame,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanFrame::get(
  self : FinancepricingeuropeanFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanFrame::set(
  self : FinancepricingeuropeanFrame,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanFrame::sum(
  self : FinancepricingeuropeanFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanFrame::mean(
  self : FinancepricingeuropeanFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanFrame::scale(
  self : FinancepricingeuropeanFrame,
  f : Double,
) -> FinancepricingeuropeanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanFrame::add(
  self : FinancepricingeuropeanFrame,
  other : FinancepricingeuropeanFrame,
) -> FinancepricingeuropeanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanFrame::copy(
  self : FinancepricingeuropeanFrame,
) -> FinancepricingeuropeanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanFrame::fill(
  self : FinancepricingeuropeanFrame,
  v : Double,
) -> FinancepricingeuropeanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanFrame::min(
  self : FinancepricingeuropeanFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanFrame::max(
  self : FinancepricingeuropeanFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanFrame::to_string(
  self : FinancepricingeuropeanFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_table_make(
  size : Int32,
) -> FinancepricingeuropeanTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanTable::len(
  self : FinancepricingeuropeanTable,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanTable::get(
  self : FinancepricingeuropeanTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanTable::set(
  self : FinancepricingeuropeanTable,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanTable::sum(
  self : FinancepricingeuropeanTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanTable::mean(
  self : FinancepricingeuropeanTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanTable::scale(
  self : FinancepricingeuropeanTable,
  f : Double,
) -> FinancepricingeuropeanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanTable::add(
  self : FinancepricingeuropeanTable,
  other : FinancepricingeuropeanTable,
) -> FinancepricingeuropeanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanTable::copy(
  self : FinancepricingeuropeanTable,
) -> FinancepricingeuropeanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanTable::fill(
  self : FinancepricingeuropeanTable,
  v : Double,
) -> FinancepricingeuropeanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanTable::min(
  self : FinancepricingeuropeanTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanTable::max(
  self : FinancepricingeuropeanTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanTable::to_string(
  self : FinancepricingeuropeanTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_graphn_make(
  size : Int32,
) -> FinancepricingeuropeanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanGraphN::len(
  self : FinancepricingeuropeanGraphN,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanGraphN::get(
  self : FinancepricingeuropeanGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanGraphN::set(
  self : FinancepricingeuropeanGraphN,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanGraphN::sum(
  self : FinancepricingeuropeanGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanGraphN::mean(
  self : FinancepricingeuropeanGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanGraphN::scale(
  self : FinancepricingeuropeanGraphN,
  f : Double,
) -> FinancepricingeuropeanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanGraphN::add(
  self : FinancepricingeuropeanGraphN,
  other : FinancepricingeuropeanGraphN,
) -> FinancepricingeuropeanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanGraphN::copy(
  self : FinancepricingeuropeanGraphN,
) -> FinancepricingeuropeanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanGraphN::fill(
  self : FinancepricingeuropeanGraphN,
  v : Double,
) -> FinancepricingeuropeanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanGraphN::min(
  self : FinancepricingeuropeanGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanGraphN::max(
  self : FinancepricingeuropeanGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanGraphN::to_string(
  self : FinancepricingeuropeanGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_node_make(
  size : Int32,
) -> FinancepricingeuropeanNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanNode::len(
  self : FinancepricingeuropeanNode,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanNode::get(
  self : FinancepricingeuropeanNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanNode::set(
  self : FinancepricingeuropeanNode,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanNode::sum(
  self : FinancepricingeuropeanNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanNode::mean(
  self : FinancepricingeuropeanNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanNode::scale(
  self : FinancepricingeuropeanNode,
  f : Double,
) -> FinancepricingeuropeanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanNode::add(
  self : FinancepricingeuropeanNode,
  other : FinancepricingeuropeanNode,
) -> FinancepricingeuropeanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanNode::copy(
  self : FinancepricingeuropeanNode,
) -> FinancepricingeuropeanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanNode::fill(
  self : FinancepricingeuropeanNode,
  v : Double,
) -> FinancepricingeuropeanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanNode::min(
  self : FinancepricingeuropeanNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanNode::max(
  self : FinancepricingeuropeanNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanNode::to_string(
  self : FinancepricingeuropeanNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_edge_make(
  size : Int32,
) -> FinancepricingeuropeanEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanEdge::len(
  self : FinancepricingeuropeanEdge,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanEdge::get(
  self : FinancepricingeuropeanEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanEdge::set(
  self : FinancepricingeuropeanEdge,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanEdge::sum(
  self : FinancepricingeuropeanEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanEdge::mean(
  self : FinancepricingeuropeanEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanEdge::scale(
  self : FinancepricingeuropeanEdge,
  f : Double,
) -> FinancepricingeuropeanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanEdge::add(
  self : FinancepricingeuropeanEdge,
  other : FinancepricingeuropeanEdge,
) -> FinancepricingeuropeanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanEdge::copy(
  self : FinancepricingeuropeanEdge,
) -> FinancepricingeuropeanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanEdge::fill(
  self : FinancepricingeuropeanEdge,
  v : Double,
) -> FinancepricingeuropeanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanEdge::min(
  self : FinancepricingeuropeanEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanEdge::max(
  self : FinancepricingeuropeanEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanEdge::to_string(
  self : FinancepricingeuropeanEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_path_make(
  size : Int32,
) -> FinancepricingeuropeanPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanPath::len(
  self : FinancepricingeuropeanPath,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanPath::get(
  self : FinancepricingeuropeanPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanPath::set(
  self : FinancepricingeuropeanPath,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanPath::sum(
  self : FinancepricingeuropeanPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanPath::mean(
  self : FinancepricingeuropeanPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanPath::scale(
  self : FinancepricingeuropeanPath,
  f : Double,
) -> FinancepricingeuropeanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanPath::add(
  self : FinancepricingeuropeanPath,
  other : FinancepricingeuropeanPath,
) -> FinancepricingeuropeanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanPath::copy(
  self : FinancepricingeuropeanPath,
) -> FinancepricingeuropeanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanPath::fill(
  self : FinancepricingeuropeanPath,
  v : Double,
) -> FinancepricingeuropeanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanPath::min(
  self : FinancepricingeuropeanPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanPath::max(
  self : FinancepricingeuropeanPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanPath::to_string(
  self : FinancepricingeuropeanPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_cluster_make(
  size : Int32,
) -> FinancepricingeuropeanCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanCluster::len(
  self : FinancepricingeuropeanCluster,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanCluster::get(
  self : FinancepricingeuropeanCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanCluster::set(
  self : FinancepricingeuropeanCluster,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanCluster::sum(
  self : FinancepricingeuropeanCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanCluster::mean(
  self : FinancepricingeuropeanCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanCluster::scale(
  self : FinancepricingeuropeanCluster,
  f : Double,
) -> FinancepricingeuropeanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanCluster::add(
  self : FinancepricingeuropeanCluster,
  other : FinancepricingeuropeanCluster,
) -> FinancepricingeuropeanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanCluster::copy(
  self : FinancepricingeuropeanCluster,
) -> FinancepricingeuropeanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanCluster::fill(
  self : FinancepricingeuropeanCluster,
  v : Double,
) -> FinancepricingeuropeanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanCluster::min(
  self : FinancepricingeuropeanCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanCluster::max(
  self : FinancepricingeuropeanCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanCluster::to_string(
  self : FinancepricingeuropeanCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_model_make(
  size : Int32,
) -> FinancepricingeuropeanModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanModel::len(
  self : FinancepricingeuropeanModel,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanModel::get(
  self : FinancepricingeuropeanModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanModel::set(
  self : FinancepricingeuropeanModel,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanModel::sum(
  self : FinancepricingeuropeanModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanModel::mean(
  self : FinancepricingeuropeanModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanModel::scale(
  self : FinancepricingeuropeanModel,
  f : Double,
) -> FinancepricingeuropeanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanModel::add(
  self : FinancepricingeuropeanModel,
  other : FinancepricingeuropeanModel,
) -> FinancepricingeuropeanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanModel::copy(
  self : FinancepricingeuropeanModel,
) -> FinancepricingeuropeanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanModel::fill(
  self : FinancepricingeuropeanModel,
  v : Double,
) -> FinancepricingeuropeanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanModel::min(
  self : FinancepricingeuropeanModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanModel::max(
  self : FinancepricingeuropeanModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanModel::to_string(
  self : FinancepricingeuropeanModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_layer_make(
  size : Int32,
) -> FinancepricingeuropeanLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanLayer::len(
  self : FinancepricingeuropeanLayer,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanLayer::get(
  self : FinancepricingeuropeanLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanLayer::set(
  self : FinancepricingeuropeanLayer,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanLayer::sum(
  self : FinancepricingeuropeanLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanLayer::mean(
  self : FinancepricingeuropeanLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanLayer::scale(
  self : FinancepricingeuropeanLayer,
  f : Double,
) -> FinancepricingeuropeanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanLayer::add(
  self : FinancepricingeuropeanLayer,
  other : FinancepricingeuropeanLayer,
) -> FinancepricingeuropeanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanLayer::copy(
  self : FinancepricingeuropeanLayer,
) -> FinancepricingeuropeanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanLayer::fill(
  self : FinancepricingeuropeanLayer,
  v : Double,
) -> FinancepricingeuropeanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanLayer::min(
  self : FinancepricingeuropeanLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanLayer::max(
  self : FinancepricingeuropeanLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanLayer::to_string(
  self : FinancepricingeuropeanLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_buffer_make(
  size : Int32,
) -> FinancepricingeuropeanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanBuffer::len(
  self : FinancepricingeuropeanBuffer,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanBuffer::get(
  self : FinancepricingeuropeanBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanBuffer::set(
  self : FinancepricingeuropeanBuffer,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanBuffer::sum(
  self : FinancepricingeuropeanBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanBuffer::mean(
  self : FinancepricingeuropeanBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanBuffer::scale(
  self : FinancepricingeuropeanBuffer,
  f : Double,
) -> FinancepricingeuropeanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanBuffer::add(
  self : FinancepricingeuropeanBuffer,
  other : FinancepricingeuropeanBuffer,
) -> FinancepricingeuropeanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanBuffer::copy(
  self : FinancepricingeuropeanBuffer,
) -> FinancepricingeuropeanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanBuffer::fill(
  self : FinancepricingeuropeanBuffer,
  v : Double,
) -> FinancepricingeuropeanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanBuffer::min(
  self : FinancepricingeuropeanBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanBuffer::max(
  self : FinancepricingeuropeanBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanBuffer::to_string(
  self : FinancepricingeuropeanBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_cursor_make(
  size : Int32,
) -> FinancepricingeuropeanCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanCursor::len(
  self : FinancepricingeuropeanCursor,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanCursor::get(
  self : FinancepricingeuropeanCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanCursor::set(
  self : FinancepricingeuropeanCursor,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanCursor::sum(
  self : FinancepricingeuropeanCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanCursor::mean(
  self : FinancepricingeuropeanCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanCursor::scale(
  self : FinancepricingeuropeanCursor,
  f : Double,
) -> FinancepricingeuropeanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanCursor::add(
  self : FinancepricingeuropeanCursor,
  other : FinancepricingeuropeanCursor,
) -> FinancepricingeuropeanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanCursor::copy(
  self : FinancepricingeuropeanCursor,
) -> FinancepricingeuropeanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanCursor::fill(
  self : FinancepricingeuropeanCursor,
  v : Double,
) -> FinancepricingeuropeanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanCursor::min(
  self : FinancepricingeuropeanCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanCursor::max(
  self : FinancepricingeuropeanCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanCursor::to_string(
  self : FinancepricingeuropeanCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_view_make(
  size : Int32,
) -> FinancepricingeuropeanView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanView::len(
  self : FinancepricingeuropeanView,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanView::get(
  self : FinancepricingeuropeanView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanView::set(
  self : FinancepricingeuropeanView,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanView::sum(
  self : FinancepricingeuropeanView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanView::mean(
  self : FinancepricingeuropeanView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanView::scale(
  self : FinancepricingeuropeanView,
  f : Double,
) -> FinancepricingeuropeanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanView::add(
  self : FinancepricingeuropeanView,
  other : FinancepricingeuropeanView,
) -> FinancepricingeuropeanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanView::copy(
  self : FinancepricingeuropeanView,
) -> FinancepricingeuropeanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanView::fill(
  self : FinancepricingeuropeanView,
  v : Double,
) -> FinancepricingeuropeanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanView::min(
  self : FinancepricingeuropeanView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanView::max(
  self : FinancepricingeuropeanView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanView::to_string(
  self : FinancepricingeuropeanView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_range_make(
  size : Int32,
) -> FinancepricingeuropeanRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanRange::len(
  self : FinancepricingeuropeanRange,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanRange::get(
  self : FinancepricingeuropeanRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanRange::set(
  self : FinancepricingeuropeanRange,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanRange::sum(
  self : FinancepricingeuropeanRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanRange::mean(
  self : FinancepricingeuropeanRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanRange::scale(
  self : FinancepricingeuropeanRange,
  f : Double,
) -> FinancepricingeuropeanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanRange::add(
  self : FinancepricingeuropeanRange,
  other : FinancepricingeuropeanRange,
) -> FinancepricingeuropeanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanRange::copy(
  self : FinancepricingeuropeanRange,
) -> FinancepricingeuropeanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanRange::fill(
  self : FinancepricingeuropeanRange,
  v : Double,
) -> FinancepricingeuropeanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanRange::min(
  self : FinancepricingeuropeanRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanRange::max(
  self : FinancepricingeuropeanRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanRange::to_string(
  self : FinancepricingeuropeanRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancepricingeuropeanSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_pricing_european_slice_make(
  size : Int32,
) -> FinancepricingeuropeanSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancepricingeuropeanSlice::len(
  self : FinancepricingeuropeanSlice,
) -> Int32 {
  self.size
}

///|
pub fn FinancepricingeuropeanSlice::get(
  self : FinancepricingeuropeanSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancepricingeuropeanSlice::set(
  self : FinancepricingeuropeanSlice,
  i : Int32,
  v : Double,
) -> FinancepricingeuropeanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanSlice::sum(
  self : FinancepricingeuropeanSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancepricingeuropeanSlice::mean(
  self : FinancepricingeuropeanSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancepricingeuropeanSlice::scale(
  self : FinancepricingeuropeanSlice,
  f : Double,
) -> FinancepricingeuropeanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanSlice::add(
  self : FinancepricingeuropeanSlice,
  other : FinancepricingeuropeanSlice,
) -> FinancepricingeuropeanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanSlice::copy(
  self : FinancepricingeuropeanSlice,
) -> FinancepricingeuropeanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanSlice::fill(
  self : FinancepricingeuropeanSlice,
  v : Double,
) -> FinancepricingeuropeanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancepricingeuropeanSlice::min(
  self : FinancepricingeuropeanSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancepricingeuropeanSlice::max(
  self : FinancepricingeuropeanSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancepricingeuropeanSlice::to_string(
  self : FinancepricingeuropeanSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
