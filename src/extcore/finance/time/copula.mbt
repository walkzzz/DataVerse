///|
///===
/// extcore/finance_time_copula
pub(all) struct FinancetimecopulaPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_time_copula_make_point(
  x : Double,
  y : Double,
) -> FinancetimecopulaPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_time_copula_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinancetimecopulaPoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinancetimecopulaPoint::x(self : FinancetimecopulaPoint) -> Double {
  self.x
}

///|
pub fn FinancetimecopulaPoint::y(self : FinancetimecopulaPoint) -> Double {
  self.y
}

///|
pub fn FinancetimecopulaPoint::z(self : FinancetimecopulaPoint) -> Double {
  self.z
}

///|
pub fn FinancetimecopulaPoint::label(self : FinancetimecopulaPoint) -> Int32 {
  self.label
}

///|
pub fn FinancetimecopulaPoint::dist(
  self : FinancetimecopulaPoint,
  other : FinancetimecopulaPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinancetimecopulaPoint::add(
  self : FinancetimecopulaPoint,
  other : FinancetimecopulaPoint,
) -> FinancetimecopulaPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinancetimecopulaPoint::sub(
  self : FinancetimecopulaPoint,
  other : FinancetimecopulaPoint,
) -> FinancetimecopulaPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinancetimecopulaPoint::scale(
  self : FinancetimecopulaPoint,
  s : Double,
) -> FinancetimecopulaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinancetimecopulaPoint::dot(
  self : FinancetimecopulaPoint,
  other : FinancetimecopulaPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinancetimecopulaPoint::cross(
  self : FinancetimecopulaPoint,
  other : FinancetimecopulaPoint,
) -> FinancetimecopulaPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinancetimecopulaPoint::norm(self : FinancetimecopulaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinancetimecopulaPoint::normalize(
  self : FinancetimecopulaPoint,
) -> FinancetimecopulaPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinancetimecopulaPoint::negate(
  self : FinancetimecopulaPoint,
) -> FinancetimecopulaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinancetimecopulaPoint::mid(
  self : FinancetimecopulaPoint,
  other : FinancetimecopulaPoint,
) -> FinancetimecopulaPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinancetimecopulaPoint::lerp(
  self : FinancetimecopulaPoint,
  other : FinancetimecopulaPoint,
  t : Double,
) -> FinancetimecopulaPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinancetimecopulaPoint::to_string(
  self : FinancetimecopulaPoint,
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
pub(all) struct FinancetimecopulaSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_time_copula_make_series(
  vals : Array[Double],
  name : String,
) -> FinancetimecopulaSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinancetimecopulaSeries::len(self : FinancetimecopulaSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn FinancetimecopulaSeries::sum(self : FinancetimecopulaSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinancetimecopulaSeries::mean(self : FinancetimecopulaSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinancetimecopulaSeries::min(self : FinancetimecopulaSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinancetimecopulaSeries::max(self : FinancetimecopulaSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinancetimecopulaSeries::range(self : FinancetimecopulaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinancetimecopulaSeries::variance(
  self : FinancetimecopulaSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinancetimecopulaSeries::std(self : FinancetimecopulaSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinancetimecopulaSeries::median(
  self : FinancetimecopulaSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinancetimecopulaSeries::scale(
  self : FinancetimecopulaSeries,
  f : Double,
) -> FinancetimecopulaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinancetimecopulaSeries::add(
  self : FinancetimecopulaSeries,
  other : FinancetimecopulaSeries,
) -> FinancetimecopulaSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinancetimecopulaSeries::sub(
  self : FinancetimecopulaSeries,
  other : FinancetimecopulaSeries,
) -> FinancetimecopulaSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinancetimecopulaSeries::normalize(
  self : FinancetimecopulaSeries,
) -> FinancetimecopulaSeries {
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
pub fn FinancetimecopulaSeries::cumsum(
  self : FinancetimecopulaSeries,
) -> FinancetimecopulaSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinancetimecopulaSeries::to_string(
  self : FinancetimecopulaSeries,
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
pub(all) struct FinancetimecopulaMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_time_copula_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinancetimecopulaMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_time_copula_matrix_identity(
  n : Int32,
) -> FinancetimecopulaMatrix {
  let m = finance_time_copula_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinancetimecopulaMatrix::get(
  self : FinancetimecopulaMatrix,
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
pub fn FinancetimecopulaMatrix::transpose(
  self : FinancetimecopulaMatrix,
) -> FinancetimecopulaMatrix {
  let result = finance_time_copula_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn FinancetimecopulaMatrix::add(
  self : FinancetimecopulaMatrix,
  other : FinancetimecopulaMatrix,
) -> FinancetimecopulaMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_time_copula_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn FinancetimecopulaMatrix::scale(
  self : FinancetimecopulaMatrix,
  s : Double,
) -> FinancetimecopulaMatrix {
  let result = finance_time_copula_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn FinancetimecopulaMatrix::multiply(
  self : FinancetimecopulaMatrix,
  other : FinancetimecopulaMatrix,
) -> FinancetimecopulaMatrix {
  if self.cols != other.rows {
    return finance_time_copula_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = finance_time_copula_make_matrix(self.rows, other.cols, 0.0)
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
pub fn FinancetimecopulaMatrix::trace(self : FinancetimecopulaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinancetimecopulaMatrix::det(self : FinancetimecopulaMatrix) -> Double {
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
pub fn FinancetimecopulaMatrix::norm(self : FinancetimecopulaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn FinancetimecopulaMatrix::to_string(
  self : FinancetimecopulaMatrix,
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
pub(all) struct FinancetimecopulaVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_time_copula_make_vector(
  comps : Array[Double],
) -> FinancetimecopulaVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_time_copula_vector_zero(dim : Int32) -> FinancetimecopulaVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinancetimecopulaVector::add(
  self : FinancetimecopulaVector,
  other : FinancetimecopulaVector,
) -> FinancetimecopulaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinancetimecopulaVector::sub(
  self : FinancetimecopulaVector,
  other : FinancetimecopulaVector,
) -> FinancetimecopulaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinancetimecopulaVector::scale(
  self : FinancetimecopulaVector,
  s : Double,
) -> FinancetimecopulaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinancetimecopulaVector::dot(
  self : FinancetimecopulaVector,
  other : FinancetimecopulaVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinancetimecopulaVector::norm(self : FinancetimecopulaVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinancetimecopulaVector::normalize(
  self : FinancetimecopulaVector,
) -> FinancetimecopulaVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinancetimecopulaVector::dist(
  self : FinancetimecopulaVector,
  other : FinancetimecopulaVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinancetimecopulaVector::to_string(
  self : FinancetimecopulaVector,
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
pub(all) struct FinancetimecopulaFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_frame_make(size : Int32) -> FinancetimecopulaFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaFrame::len(self : FinancetimecopulaFrame) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaFrame::get(
  self : FinancetimecopulaFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaFrame::set(
  self : FinancetimecopulaFrame,
  i : Int32,
  v : Double,
) -> FinancetimecopulaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaFrame::sum(self : FinancetimecopulaFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaFrame::mean(self : FinancetimecopulaFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaFrame::scale(
  self : FinancetimecopulaFrame,
  f : Double,
) -> FinancetimecopulaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaFrame::add(
  self : FinancetimecopulaFrame,
  other : FinancetimecopulaFrame,
) -> FinancetimecopulaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaFrame::copy(
  self : FinancetimecopulaFrame,
) -> FinancetimecopulaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaFrame::fill(
  self : FinancetimecopulaFrame,
  v : Double,
) -> FinancetimecopulaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaFrame::min(self : FinancetimecopulaFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaFrame::max(self : FinancetimecopulaFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaFrame::to_string(
  self : FinancetimecopulaFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_table_make(size : Int32) -> FinancetimecopulaTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaTable::len(self : FinancetimecopulaTable) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaTable::get(
  self : FinancetimecopulaTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaTable::set(
  self : FinancetimecopulaTable,
  i : Int32,
  v : Double,
) -> FinancetimecopulaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaTable::sum(self : FinancetimecopulaTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaTable::mean(self : FinancetimecopulaTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaTable::scale(
  self : FinancetimecopulaTable,
  f : Double,
) -> FinancetimecopulaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaTable::add(
  self : FinancetimecopulaTable,
  other : FinancetimecopulaTable,
) -> FinancetimecopulaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaTable::copy(
  self : FinancetimecopulaTable,
) -> FinancetimecopulaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaTable::fill(
  self : FinancetimecopulaTable,
  v : Double,
) -> FinancetimecopulaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaTable::min(self : FinancetimecopulaTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaTable::max(self : FinancetimecopulaTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaTable::to_string(
  self : FinancetimecopulaTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_graphn_make(size : Int32) -> FinancetimecopulaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaGraphN::len(self : FinancetimecopulaGraphN) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaGraphN::get(
  self : FinancetimecopulaGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaGraphN::set(
  self : FinancetimecopulaGraphN,
  i : Int32,
  v : Double,
) -> FinancetimecopulaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaGraphN::sum(self : FinancetimecopulaGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaGraphN::mean(self : FinancetimecopulaGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaGraphN::scale(
  self : FinancetimecopulaGraphN,
  f : Double,
) -> FinancetimecopulaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaGraphN::add(
  self : FinancetimecopulaGraphN,
  other : FinancetimecopulaGraphN,
) -> FinancetimecopulaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaGraphN::copy(
  self : FinancetimecopulaGraphN,
) -> FinancetimecopulaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaGraphN::fill(
  self : FinancetimecopulaGraphN,
  v : Double,
) -> FinancetimecopulaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaGraphN::min(self : FinancetimecopulaGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaGraphN::max(self : FinancetimecopulaGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaGraphN::to_string(
  self : FinancetimecopulaGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_node_make(size : Int32) -> FinancetimecopulaNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaNode::len(self : FinancetimecopulaNode) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaNode::get(
  self : FinancetimecopulaNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaNode::set(
  self : FinancetimecopulaNode,
  i : Int32,
  v : Double,
) -> FinancetimecopulaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaNode::sum(self : FinancetimecopulaNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaNode::mean(self : FinancetimecopulaNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaNode::scale(
  self : FinancetimecopulaNode,
  f : Double,
) -> FinancetimecopulaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaNode::add(
  self : FinancetimecopulaNode,
  other : FinancetimecopulaNode,
) -> FinancetimecopulaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaNode::copy(
  self : FinancetimecopulaNode,
) -> FinancetimecopulaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaNode::fill(
  self : FinancetimecopulaNode,
  v : Double,
) -> FinancetimecopulaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaNode::min(self : FinancetimecopulaNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaNode::max(self : FinancetimecopulaNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaNode::to_string(self : FinancetimecopulaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_edge_make(size : Int32) -> FinancetimecopulaEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaEdge::len(self : FinancetimecopulaEdge) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaEdge::get(
  self : FinancetimecopulaEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaEdge::set(
  self : FinancetimecopulaEdge,
  i : Int32,
  v : Double,
) -> FinancetimecopulaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaEdge::sum(self : FinancetimecopulaEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaEdge::mean(self : FinancetimecopulaEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaEdge::scale(
  self : FinancetimecopulaEdge,
  f : Double,
) -> FinancetimecopulaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaEdge::add(
  self : FinancetimecopulaEdge,
  other : FinancetimecopulaEdge,
) -> FinancetimecopulaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaEdge::copy(
  self : FinancetimecopulaEdge,
) -> FinancetimecopulaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaEdge::fill(
  self : FinancetimecopulaEdge,
  v : Double,
) -> FinancetimecopulaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaEdge::min(self : FinancetimecopulaEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaEdge::max(self : FinancetimecopulaEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaEdge::to_string(self : FinancetimecopulaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_path_make(size : Int32) -> FinancetimecopulaPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaPath::len(self : FinancetimecopulaPath) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaPath::get(
  self : FinancetimecopulaPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaPath::set(
  self : FinancetimecopulaPath,
  i : Int32,
  v : Double,
) -> FinancetimecopulaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaPath::sum(self : FinancetimecopulaPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaPath::mean(self : FinancetimecopulaPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaPath::scale(
  self : FinancetimecopulaPath,
  f : Double,
) -> FinancetimecopulaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaPath::add(
  self : FinancetimecopulaPath,
  other : FinancetimecopulaPath,
) -> FinancetimecopulaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaPath::copy(
  self : FinancetimecopulaPath,
) -> FinancetimecopulaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaPath::fill(
  self : FinancetimecopulaPath,
  v : Double,
) -> FinancetimecopulaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaPath::min(self : FinancetimecopulaPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaPath::max(self : FinancetimecopulaPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaPath::to_string(self : FinancetimecopulaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_cluster_make(
  size : Int32,
) -> FinancetimecopulaCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaCluster::len(self : FinancetimecopulaCluster) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaCluster::get(
  self : FinancetimecopulaCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaCluster::set(
  self : FinancetimecopulaCluster,
  i : Int32,
  v : Double,
) -> FinancetimecopulaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaCluster::sum(self : FinancetimecopulaCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaCluster::mean(
  self : FinancetimecopulaCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaCluster::scale(
  self : FinancetimecopulaCluster,
  f : Double,
) -> FinancetimecopulaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaCluster::add(
  self : FinancetimecopulaCluster,
  other : FinancetimecopulaCluster,
) -> FinancetimecopulaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaCluster::copy(
  self : FinancetimecopulaCluster,
) -> FinancetimecopulaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaCluster::fill(
  self : FinancetimecopulaCluster,
  v : Double,
) -> FinancetimecopulaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaCluster::min(self : FinancetimecopulaCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaCluster::max(self : FinancetimecopulaCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaCluster::to_string(
  self : FinancetimecopulaCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_model_make(size : Int32) -> FinancetimecopulaModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaModel::len(self : FinancetimecopulaModel) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaModel::get(
  self : FinancetimecopulaModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaModel::set(
  self : FinancetimecopulaModel,
  i : Int32,
  v : Double,
) -> FinancetimecopulaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaModel::sum(self : FinancetimecopulaModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaModel::mean(self : FinancetimecopulaModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaModel::scale(
  self : FinancetimecopulaModel,
  f : Double,
) -> FinancetimecopulaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaModel::add(
  self : FinancetimecopulaModel,
  other : FinancetimecopulaModel,
) -> FinancetimecopulaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaModel::copy(
  self : FinancetimecopulaModel,
) -> FinancetimecopulaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaModel::fill(
  self : FinancetimecopulaModel,
  v : Double,
) -> FinancetimecopulaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaModel::min(self : FinancetimecopulaModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaModel::max(self : FinancetimecopulaModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaModel::to_string(
  self : FinancetimecopulaModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_layer_make(size : Int32) -> FinancetimecopulaLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaLayer::len(self : FinancetimecopulaLayer) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaLayer::get(
  self : FinancetimecopulaLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaLayer::set(
  self : FinancetimecopulaLayer,
  i : Int32,
  v : Double,
) -> FinancetimecopulaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaLayer::sum(self : FinancetimecopulaLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaLayer::mean(self : FinancetimecopulaLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaLayer::scale(
  self : FinancetimecopulaLayer,
  f : Double,
) -> FinancetimecopulaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaLayer::add(
  self : FinancetimecopulaLayer,
  other : FinancetimecopulaLayer,
) -> FinancetimecopulaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaLayer::copy(
  self : FinancetimecopulaLayer,
) -> FinancetimecopulaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaLayer::fill(
  self : FinancetimecopulaLayer,
  v : Double,
) -> FinancetimecopulaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaLayer::min(self : FinancetimecopulaLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaLayer::max(self : FinancetimecopulaLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaLayer::to_string(
  self : FinancetimecopulaLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_buffer_make(size : Int32) -> FinancetimecopulaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaBuffer::len(self : FinancetimecopulaBuffer) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaBuffer::get(
  self : FinancetimecopulaBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaBuffer::set(
  self : FinancetimecopulaBuffer,
  i : Int32,
  v : Double,
) -> FinancetimecopulaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaBuffer::sum(self : FinancetimecopulaBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaBuffer::mean(self : FinancetimecopulaBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaBuffer::scale(
  self : FinancetimecopulaBuffer,
  f : Double,
) -> FinancetimecopulaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaBuffer::add(
  self : FinancetimecopulaBuffer,
  other : FinancetimecopulaBuffer,
) -> FinancetimecopulaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaBuffer::copy(
  self : FinancetimecopulaBuffer,
) -> FinancetimecopulaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaBuffer::fill(
  self : FinancetimecopulaBuffer,
  v : Double,
) -> FinancetimecopulaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaBuffer::min(self : FinancetimecopulaBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaBuffer::max(self : FinancetimecopulaBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaBuffer::to_string(
  self : FinancetimecopulaBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_cursor_make(size : Int32) -> FinancetimecopulaCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaCursor::len(self : FinancetimecopulaCursor) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaCursor::get(
  self : FinancetimecopulaCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaCursor::set(
  self : FinancetimecopulaCursor,
  i : Int32,
  v : Double,
) -> FinancetimecopulaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaCursor::sum(self : FinancetimecopulaCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaCursor::mean(self : FinancetimecopulaCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaCursor::scale(
  self : FinancetimecopulaCursor,
  f : Double,
) -> FinancetimecopulaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaCursor::add(
  self : FinancetimecopulaCursor,
  other : FinancetimecopulaCursor,
) -> FinancetimecopulaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaCursor::copy(
  self : FinancetimecopulaCursor,
) -> FinancetimecopulaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaCursor::fill(
  self : FinancetimecopulaCursor,
  v : Double,
) -> FinancetimecopulaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaCursor::min(self : FinancetimecopulaCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaCursor::max(self : FinancetimecopulaCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaCursor::to_string(
  self : FinancetimecopulaCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_view_make(size : Int32) -> FinancetimecopulaView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaView::len(self : FinancetimecopulaView) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaView::get(
  self : FinancetimecopulaView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaView::set(
  self : FinancetimecopulaView,
  i : Int32,
  v : Double,
) -> FinancetimecopulaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaView::sum(self : FinancetimecopulaView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaView::mean(self : FinancetimecopulaView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaView::scale(
  self : FinancetimecopulaView,
  f : Double,
) -> FinancetimecopulaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaView::add(
  self : FinancetimecopulaView,
  other : FinancetimecopulaView,
) -> FinancetimecopulaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaView::copy(
  self : FinancetimecopulaView,
) -> FinancetimecopulaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaView::fill(
  self : FinancetimecopulaView,
  v : Double,
) -> FinancetimecopulaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaView::min(self : FinancetimecopulaView) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaView::max(self : FinancetimecopulaView) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaView::to_string(self : FinancetimecopulaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_range_make(size : Int32) -> FinancetimecopulaRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaRange::len(self : FinancetimecopulaRange) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaRange::get(
  self : FinancetimecopulaRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaRange::set(
  self : FinancetimecopulaRange,
  i : Int32,
  v : Double,
) -> FinancetimecopulaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaRange::sum(self : FinancetimecopulaRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaRange::mean(self : FinancetimecopulaRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaRange::scale(
  self : FinancetimecopulaRange,
  f : Double,
) -> FinancetimecopulaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaRange::add(
  self : FinancetimecopulaRange,
  other : FinancetimecopulaRange,
) -> FinancetimecopulaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaRange::copy(
  self : FinancetimecopulaRange,
) -> FinancetimecopulaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaRange::fill(
  self : FinancetimecopulaRange,
  v : Double,
) -> FinancetimecopulaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaRange::min(self : FinancetimecopulaRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaRange::max(self : FinancetimecopulaRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaRange::to_string(
  self : FinancetimecopulaRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimecopulaSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_copula_slice_make(size : Int32) -> FinancetimecopulaSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimecopulaSlice::len(self : FinancetimecopulaSlice) -> Int32 {
  self.size
}

///|
pub fn FinancetimecopulaSlice::get(
  self : FinancetimecopulaSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimecopulaSlice::set(
  self : FinancetimecopulaSlice,
  i : Int32,
  v : Double,
) -> FinancetimecopulaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaSlice::sum(self : FinancetimecopulaSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimecopulaSlice::mean(self : FinancetimecopulaSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimecopulaSlice::scale(
  self : FinancetimecopulaSlice,
  f : Double,
) -> FinancetimecopulaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaSlice::add(
  self : FinancetimecopulaSlice,
  other : FinancetimecopulaSlice,
) -> FinancetimecopulaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimecopulaSlice::copy(
  self : FinancetimecopulaSlice,
) -> FinancetimecopulaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaSlice::fill(
  self : FinancetimecopulaSlice,
  v : Double,
) -> FinancetimecopulaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimecopulaSlice::min(self : FinancetimecopulaSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimecopulaSlice::max(self : FinancetimecopulaSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimecopulaSlice::to_string(
  self : FinancetimecopulaSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
