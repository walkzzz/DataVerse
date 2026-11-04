///|
///===
/// extcore/finance_time_extreme
pub(all) struct FinancetimeextremePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_time_extreme_make_point(
  x : Double,
  y : Double,
) -> FinancetimeextremePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_time_extreme_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinancetimeextremePoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinancetimeextremePoint::x(self : FinancetimeextremePoint) -> Double {
  self.x
}

///|
pub fn FinancetimeextremePoint::y(self : FinancetimeextremePoint) -> Double {
  self.y
}

///|
pub fn FinancetimeextremePoint::z(self : FinancetimeextremePoint) -> Double {
  self.z
}

///|
pub fn FinancetimeextremePoint::label(self : FinancetimeextremePoint) -> Int32 {
  self.label
}

///|
pub fn FinancetimeextremePoint::dist(
  self : FinancetimeextremePoint,
  other : FinancetimeextremePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinancetimeextremePoint::add(
  self : FinancetimeextremePoint,
  other : FinancetimeextremePoint,
) -> FinancetimeextremePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinancetimeextremePoint::sub(
  self : FinancetimeextremePoint,
  other : FinancetimeextremePoint,
) -> FinancetimeextremePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinancetimeextremePoint::scale(
  self : FinancetimeextremePoint,
  s : Double,
) -> FinancetimeextremePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinancetimeextremePoint::dot(
  self : FinancetimeextremePoint,
  other : FinancetimeextremePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinancetimeextremePoint::cross(
  self : FinancetimeextremePoint,
  other : FinancetimeextremePoint,
) -> FinancetimeextremePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinancetimeextremePoint::norm(self : FinancetimeextremePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinancetimeextremePoint::normalize(
  self : FinancetimeextremePoint,
) -> FinancetimeextremePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinancetimeextremePoint::negate(
  self : FinancetimeextremePoint,
) -> FinancetimeextremePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinancetimeextremePoint::mid(
  self : FinancetimeextremePoint,
  other : FinancetimeextremePoint,
) -> FinancetimeextremePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinancetimeextremePoint::lerp(
  self : FinancetimeextremePoint,
  other : FinancetimeextremePoint,
  t : Double,
) -> FinancetimeextremePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinancetimeextremePoint::to_string(
  self : FinancetimeextremePoint,
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
pub(all) struct FinancetimeextremeSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_time_extreme_make_series(
  vals : Array[Double],
  name : String,
) -> FinancetimeextremeSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinancetimeextremeSeries::len(self : FinancetimeextremeSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn FinancetimeextremeSeries::sum(self : FinancetimeextremeSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinancetimeextremeSeries::mean(
  self : FinancetimeextremeSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinancetimeextremeSeries::min(self : FinancetimeextremeSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinancetimeextremeSeries::max(self : FinancetimeextremeSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinancetimeextremeSeries::range(
  self : FinancetimeextremeSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinancetimeextremeSeries::variance(
  self : FinancetimeextremeSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinancetimeextremeSeries::std(self : FinancetimeextremeSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinancetimeextremeSeries::median(
  self : FinancetimeextremeSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinancetimeextremeSeries::scale(
  self : FinancetimeextremeSeries,
  f : Double,
) -> FinancetimeextremeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinancetimeextremeSeries::add(
  self : FinancetimeextremeSeries,
  other : FinancetimeextremeSeries,
) -> FinancetimeextremeSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinancetimeextremeSeries::sub(
  self : FinancetimeextremeSeries,
  other : FinancetimeextremeSeries,
) -> FinancetimeextremeSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinancetimeextremeSeries::normalize(
  self : FinancetimeextremeSeries,
) -> FinancetimeextremeSeries {
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
pub fn FinancetimeextremeSeries::cumsum(
  self : FinancetimeextremeSeries,
) -> FinancetimeextremeSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinancetimeextremeSeries::to_string(
  self : FinancetimeextremeSeries,
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
pub(all) struct FinancetimeextremeMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_time_extreme_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinancetimeextremeMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_time_extreme_matrix_identity(
  n : Int32,
) -> FinancetimeextremeMatrix {
  let m = finance_time_extreme_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinancetimeextremeMatrix::get(
  self : FinancetimeextremeMatrix,
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
pub fn FinancetimeextremeMatrix::transpose(
  self : FinancetimeextremeMatrix,
) -> FinancetimeextremeMatrix {
  let result = finance_time_extreme_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn FinancetimeextremeMatrix::add(
  self : FinancetimeextremeMatrix,
  other : FinancetimeextremeMatrix,
) -> FinancetimeextremeMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_time_extreme_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn FinancetimeextremeMatrix::scale(
  self : FinancetimeextremeMatrix,
  s : Double,
) -> FinancetimeextremeMatrix {
  let result = finance_time_extreme_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn FinancetimeextremeMatrix::multiply(
  self : FinancetimeextremeMatrix,
  other : FinancetimeextremeMatrix,
) -> FinancetimeextremeMatrix {
  if self.cols != other.rows {
    return finance_time_extreme_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = finance_time_extreme_make_matrix(self.rows, other.cols, 0.0)
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
pub fn FinancetimeextremeMatrix::trace(
  self : FinancetimeextremeMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinancetimeextremeMatrix::det(self : FinancetimeextremeMatrix) -> Double {
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
pub fn FinancetimeextremeMatrix::norm(
  self : FinancetimeextremeMatrix,
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
pub fn FinancetimeextremeMatrix::to_string(
  self : FinancetimeextremeMatrix,
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
pub(all) struct FinancetimeextremeVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_time_extreme_make_vector(
  comps : Array[Double],
) -> FinancetimeextremeVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_time_extreme_vector_zero(
  dim : Int32,
) -> FinancetimeextremeVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinancetimeextremeVector::add(
  self : FinancetimeextremeVector,
  other : FinancetimeextremeVector,
) -> FinancetimeextremeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinancetimeextremeVector::sub(
  self : FinancetimeextremeVector,
  other : FinancetimeextremeVector,
) -> FinancetimeextremeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinancetimeextremeVector::scale(
  self : FinancetimeextremeVector,
  s : Double,
) -> FinancetimeextremeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinancetimeextremeVector::dot(
  self : FinancetimeextremeVector,
  other : FinancetimeextremeVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinancetimeextremeVector::norm(
  self : FinancetimeextremeVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinancetimeextremeVector::normalize(
  self : FinancetimeextremeVector,
) -> FinancetimeextremeVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinancetimeextremeVector::dist(
  self : FinancetimeextremeVector,
  other : FinancetimeextremeVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinancetimeextremeVector::to_string(
  self : FinancetimeextremeVector,
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
pub(all) struct FinancetimeextremeFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_frame_make(size : Int32) -> FinancetimeextremeFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeFrame::len(self : FinancetimeextremeFrame) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeFrame::get(
  self : FinancetimeextremeFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeFrame::set(
  self : FinancetimeextremeFrame,
  i : Int32,
  v : Double,
) -> FinancetimeextremeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeFrame::sum(self : FinancetimeextremeFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeFrame::mean(self : FinancetimeextremeFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeFrame::scale(
  self : FinancetimeextremeFrame,
  f : Double,
) -> FinancetimeextremeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeFrame::add(
  self : FinancetimeextremeFrame,
  other : FinancetimeextremeFrame,
) -> FinancetimeextremeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeFrame::copy(
  self : FinancetimeextremeFrame,
) -> FinancetimeextremeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeFrame::fill(
  self : FinancetimeextremeFrame,
  v : Double,
) -> FinancetimeextremeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeFrame::min(self : FinancetimeextremeFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeFrame::max(self : FinancetimeextremeFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeFrame::to_string(
  self : FinancetimeextremeFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_table_make(size : Int32) -> FinancetimeextremeTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeTable::len(self : FinancetimeextremeTable) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeTable::get(
  self : FinancetimeextremeTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeTable::set(
  self : FinancetimeextremeTable,
  i : Int32,
  v : Double,
) -> FinancetimeextremeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeTable::sum(self : FinancetimeextremeTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeTable::mean(self : FinancetimeextremeTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeTable::scale(
  self : FinancetimeextremeTable,
  f : Double,
) -> FinancetimeextremeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeTable::add(
  self : FinancetimeextremeTable,
  other : FinancetimeextremeTable,
) -> FinancetimeextremeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeTable::copy(
  self : FinancetimeextremeTable,
) -> FinancetimeextremeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeTable::fill(
  self : FinancetimeextremeTable,
  v : Double,
) -> FinancetimeextremeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeTable::min(self : FinancetimeextremeTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeTable::max(self : FinancetimeextremeTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeTable::to_string(
  self : FinancetimeextremeTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_graphn_make(
  size : Int32,
) -> FinancetimeextremeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeGraphN::len(self : FinancetimeextremeGraphN) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeGraphN::get(
  self : FinancetimeextremeGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeGraphN::set(
  self : FinancetimeextremeGraphN,
  i : Int32,
  v : Double,
) -> FinancetimeextremeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeGraphN::sum(self : FinancetimeextremeGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeGraphN::mean(
  self : FinancetimeextremeGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeGraphN::scale(
  self : FinancetimeextremeGraphN,
  f : Double,
) -> FinancetimeextremeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeGraphN::add(
  self : FinancetimeextremeGraphN,
  other : FinancetimeextremeGraphN,
) -> FinancetimeextremeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeGraphN::copy(
  self : FinancetimeextremeGraphN,
) -> FinancetimeextremeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeGraphN::fill(
  self : FinancetimeextremeGraphN,
  v : Double,
) -> FinancetimeextremeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeGraphN::min(self : FinancetimeextremeGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeGraphN::max(self : FinancetimeextremeGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeGraphN::to_string(
  self : FinancetimeextremeGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_node_make(size : Int32) -> FinancetimeextremeNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeNode::len(self : FinancetimeextremeNode) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeNode::get(
  self : FinancetimeextremeNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeNode::set(
  self : FinancetimeextremeNode,
  i : Int32,
  v : Double,
) -> FinancetimeextremeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeNode::sum(self : FinancetimeextremeNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeNode::mean(self : FinancetimeextremeNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeNode::scale(
  self : FinancetimeextremeNode,
  f : Double,
) -> FinancetimeextremeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeNode::add(
  self : FinancetimeextremeNode,
  other : FinancetimeextremeNode,
) -> FinancetimeextremeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeNode::copy(
  self : FinancetimeextremeNode,
) -> FinancetimeextremeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeNode::fill(
  self : FinancetimeextremeNode,
  v : Double,
) -> FinancetimeextremeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeNode::min(self : FinancetimeextremeNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeNode::max(self : FinancetimeextremeNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeNode::to_string(
  self : FinancetimeextremeNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_edge_make(size : Int32) -> FinancetimeextremeEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeEdge::len(self : FinancetimeextremeEdge) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeEdge::get(
  self : FinancetimeextremeEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeEdge::set(
  self : FinancetimeextremeEdge,
  i : Int32,
  v : Double,
) -> FinancetimeextremeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeEdge::sum(self : FinancetimeextremeEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeEdge::mean(self : FinancetimeextremeEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeEdge::scale(
  self : FinancetimeextremeEdge,
  f : Double,
) -> FinancetimeextremeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeEdge::add(
  self : FinancetimeextremeEdge,
  other : FinancetimeextremeEdge,
) -> FinancetimeextremeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeEdge::copy(
  self : FinancetimeextremeEdge,
) -> FinancetimeextremeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeEdge::fill(
  self : FinancetimeextremeEdge,
  v : Double,
) -> FinancetimeextremeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeEdge::min(self : FinancetimeextremeEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeEdge::max(self : FinancetimeextremeEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeEdge::to_string(
  self : FinancetimeextremeEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_path_make(size : Int32) -> FinancetimeextremePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremePath::len(self : FinancetimeextremePath) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremePath::get(
  self : FinancetimeextremePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremePath::set(
  self : FinancetimeextremePath,
  i : Int32,
  v : Double,
) -> FinancetimeextremePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremePath::sum(self : FinancetimeextremePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremePath::mean(self : FinancetimeextremePath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremePath::scale(
  self : FinancetimeextremePath,
  f : Double,
) -> FinancetimeextremePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremePath::add(
  self : FinancetimeextremePath,
  other : FinancetimeextremePath,
) -> FinancetimeextremePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremePath::copy(
  self : FinancetimeextremePath,
) -> FinancetimeextremePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremePath::fill(
  self : FinancetimeextremePath,
  v : Double,
) -> FinancetimeextremePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremePath::min(self : FinancetimeextremePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremePath::max(self : FinancetimeextremePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremePath::to_string(
  self : FinancetimeextremePath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_cluster_make(
  size : Int32,
) -> FinancetimeextremeCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeCluster::len(
  self : FinancetimeextremeCluster,
) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeCluster::get(
  self : FinancetimeextremeCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeCluster::set(
  self : FinancetimeextremeCluster,
  i : Int32,
  v : Double,
) -> FinancetimeextremeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeCluster::sum(
  self : FinancetimeextremeCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeCluster::mean(
  self : FinancetimeextremeCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeCluster::scale(
  self : FinancetimeextremeCluster,
  f : Double,
) -> FinancetimeextremeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeCluster::add(
  self : FinancetimeextremeCluster,
  other : FinancetimeextremeCluster,
) -> FinancetimeextremeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeCluster::copy(
  self : FinancetimeextremeCluster,
) -> FinancetimeextremeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeCluster::fill(
  self : FinancetimeextremeCluster,
  v : Double,
) -> FinancetimeextremeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeCluster::min(
  self : FinancetimeextremeCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeCluster::max(
  self : FinancetimeextremeCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeCluster::to_string(
  self : FinancetimeextremeCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_model_make(size : Int32) -> FinancetimeextremeModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeModel::len(self : FinancetimeextremeModel) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeModel::get(
  self : FinancetimeextremeModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeModel::set(
  self : FinancetimeextremeModel,
  i : Int32,
  v : Double,
) -> FinancetimeextremeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeModel::sum(self : FinancetimeextremeModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeModel::mean(self : FinancetimeextremeModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeModel::scale(
  self : FinancetimeextremeModel,
  f : Double,
) -> FinancetimeextremeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeModel::add(
  self : FinancetimeextremeModel,
  other : FinancetimeextremeModel,
) -> FinancetimeextremeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeModel::copy(
  self : FinancetimeextremeModel,
) -> FinancetimeextremeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeModel::fill(
  self : FinancetimeextremeModel,
  v : Double,
) -> FinancetimeextremeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeModel::min(self : FinancetimeextremeModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeModel::max(self : FinancetimeextremeModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeModel::to_string(
  self : FinancetimeextremeModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_layer_make(size : Int32) -> FinancetimeextremeLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeLayer::len(self : FinancetimeextremeLayer) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeLayer::get(
  self : FinancetimeextremeLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeLayer::set(
  self : FinancetimeextremeLayer,
  i : Int32,
  v : Double,
) -> FinancetimeextremeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeLayer::sum(self : FinancetimeextremeLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeLayer::mean(self : FinancetimeextremeLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeLayer::scale(
  self : FinancetimeextremeLayer,
  f : Double,
) -> FinancetimeextremeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeLayer::add(
  self : FinancetimeextremeLayer,
  other : FinancetimeextremeLayer,
) -> FinancetimeextremeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeLayer::copy(
  self : FinancetimeextremeLayer,
) -> FinancetimeextremeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeLayer::fill(
  self : FinancetimeextremeLayer,
  v : Double,
) -> FinancetimeextremeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeLayer::min(self : FinancetimeextremeLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeLayer::max(self : FinancetimeextremeLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeLayer::to_string(
  self : FinancetimeextremeLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_buffer_make(
  size : Int32,
) -> FinancetimeextremeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeBuffer::len(self : FinancetimeextremeBuffer) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeBuffer::get(
  self : FinancetimeextremeBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeBuffer::set(
  self : FinancetimeextremeBuffer,
  i : Int32,
  v : Double,
) -> FinancetimeextremeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeBuffer::sum(self : FinancetimeextremeBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeBuffer::mean(
  self : FinancetimeextremeBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeBuffer::scale(
  self : FinancetimeextremeBuffer,
  f : Double,
) -> FinancetimeextremeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeBuffer::add(
  self : FinancetimeextremeBuffer,
  other : FinancetimeextremeBuffer,
) -> FinancetimeextremeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeBuffer::copy(
  self : FinancetimeextremeBuffer,
) -> FinancetimeextremeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeBuffer::fill(
  self : FinancetimeextremeBuffer,
  v : Double,
) -> FinancetimeextremeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeBuffer::min(self : FinancetimeextremeBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeBuffer::max(self : FinancetimeextremeBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeBuffer::to_string(
  self : FinancetimeextremeBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_cursor_make(
  size : Int32,
) -> FinancetimeextremeCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeCursor::len(self : FinancetimeextremeCursor) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeCursor::get(
  self : FinancetimeextremeCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeCursor::set(
  self : FinancetimeextremeCursor,
  i : Int32,
  v : Double,
) -> FinancetimeextremeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeCursor::sum(self : FinancetimeextremeCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeCursor::mean(
  self : FinancetimeextremeCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeCursor::scale(
  self : FinancetimeextremeCursor,
  f : Double,
) -> FinancetimeextremeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeCursor::add(
  self : FinancetimeextremeCursor,
  other : FinancetimeextremeCursor,
) -> FinancetimeextremeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeCursor::copy(
  self : FinancetimeextremeCursor,
) -> FinancetimeextremeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeCursor::fill(
  self : FinancetimeextremeCursor,
  v : Double,
) -> FinancetimeextremeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeCursor::min(self : FinancetimeextremeCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeCursor::max(self : FinancetimeextremeCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeCursor::to_string(
  self : FinancetimeextremeCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_view_make(size : Int32) -> FinancetimeextremeView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeView::len(self : FinancetimeextremeView) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeView::get(
  self : FinancetimeextremeView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeView::set(
  self : FinancetimeextremeView,
  i : Int32,
  v : Double,
) -> FinancetimeextremeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeView::sum(self : FinancetimeextremeView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeView::mean(self : FinancetimeextremeView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeView::scale(
  self : FinancetimeextremeView,
  f : Double,
) -> FinancetimeextremeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeView::add(
  self : FinancetimeextremeView,
  other : FinancetimeextremeView,
) -> FinancetimeextremeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeView::copy(
  self : FinancetimeextremeView,
) -> FinancetimeextremeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeView::fill(
  self : FinancetimeextremeView,
  v : Double,
) -> FinancetimeextremeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeView::min(self : FinancetimeextremeView) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeView::max(self : FinancetimeextremeView) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeView::to_string(
  self : FinancetimeextremeView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_range_make(size : Int32) -> FinancetimeextremeRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeRange::len(self : FinancetimeextremeRange) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeRange::get(
  self : FinancetimeextremeRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeRange::set(
  self : FinancetimeextremeRange,
  i : Int32,
  v : Double,
) -> FinancetimeextremeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeRange::sum(self : FinancetimeextremeRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeRange::mean(self : FinancetimeextremeRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeRange::scale(
  self : FinancetimeextremeRange,
  f : Double,
) -> FinancetimeextremeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeRange::add(
  self : FinancetimeextremeRange,
  other : FinancetimeextremeRange,
) -> FinancetimeextremeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeRange::copy(
  self : FinancetimeextremeRange,
) -> FinancetimeextremeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeRange::fill(
  self : FinancetimeextremeRange,
  v : Double,
) -> FinancetimeextremeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeRange::min(self : FinancetimeextremeRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeRange::max(self : FinancetimeextremeRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeRange::to_string(
  self : FinancetimeextremeRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinancetimeextremeSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_time_extreme_slice_make(size : Int32) -> FinancetimeextremeSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinancetimeextremeSlice::len(self : FinancetimeextremeSlice) -> Int32 {
  self.size
}

///|
pub fn FinancetimeextremeSlice::get(
  self : FinancetimeextremeSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinancetimeextremeSlice::set(
  self : FinancetimeextremeSlice,
  i : Int32,
  v : Double,
) -> FinancetimeextremeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeSlice::sum(self : FinancetimeextremeSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinancetimeextremeSlice::mean(self : FinancetimeextremeSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinancetimeextremeSlice::scale(
  self : FinancetimeextremeSlice,
  f : Double,
) -> FinancetimeextremeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeSlice::add(
  self : FinancetimeextremeSlice,
  other : FinancetimeextremeSlice,
) -> FinancetimeextremeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinancetimeextremeSlice::copy(
  self : FinancetimeextremeSlice,
) -> FinancetimeextremeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeSlice::fill(
  self : FinancetimeextremeSlice,
  v : Double,
) -> FinancetimeextremeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinancetimeextremeSlice::min(self : FinancetimeextremeSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinancetimeextremeSlice::max(self : FinancetimeextremeSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinancetimeextremeSlice::to_string(
  self : FinancetimeextremeSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
