///|
///===
/// extcore/finance_risk_component
pub(all) struct FinanceriskcomponentPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_risk_component_make_point(
  x : Double,
  y : Double,
) -> FinanceriskcomponentPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_risk_component_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinanceriskcomponentPoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinanceriskcomponentPoint::x(self : FinanceriskcomponentPoint) -> Double {
  self.x
}

///|
pub fn FinanceriskcomponentPoint::y(self : FinanceriskcomponentPoint) -> Double {
  self.y
}

///|
pub fn FinanceriskcomponentPoint::z(self : FinanceriskcomponentPoint) -> Double {
  self.z
}

///|
pub fn FinanceriskcomponentPoint::label(
  self : FinanceriskcomponentPoint,
) -> Int32 {
  self.label
}

///|
pub fn FinanceriskcomponentPoint::dist(
  self : FinanceriskcomponentPoint,
  other : FinanceriskcomponentPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinanceriskcomponentPoint::add(
  self : FinanceriskcomponentPoint,
  other : FinanceriskcomponentPoint,
) -> FinanceriskcomponentPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinanceriskcomponentPoint::sub(
  self : FinanceriskcomponentPoint,
  other : FinanceriskcomponentPoint,
) -> FinanceriskcomponentPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinanceriskcomponentPoint::scale(
  self : FinanceriskcomponentPoint,
  s : Double,
) -> FinanceriskcomponentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinanceriskcomponentPoint::dot(
  self : FinanceriskcomponentPoint,
  other : FinanceriskcomponentPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinanceriskcomponentPoint::cross(
  self : FinanceriskcomponentPoint,
  other : FinanceriskcomponentPoint,
) -> FinanceriskcomponentPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinanceriskcomponentPoint::norm(
  self : FinanceriskcomponentPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinanceriskcomponentPoint::normalize(
  self : FinanceriskcomponentPoint,
) -> FinanceriskcomponentPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceriskcomponentPoint::negate(
  self : FinanceriskcomponentPoint,
) -> FinanceriskcomponentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinanceriskcomponentPoint::mid(
  self : FinanceriskcomponentPoint,
  other : FinanceriskcomponentPoint,
) -> FinanceriskcomponentPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinanceriskcomponentPoint::lerp(
  self : FinanceriskcomponentPoint,
  other : FinanceriskcomponentPoint,
  t : Double,
) -> FinanceriskcomponentPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinanceriskcomponentPoint::to_string(
  self : FinanceriskcomponentPoint,
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
pub(all) struct FinanceriskcomponentSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_risk_component_make_series(
  vals : Array[Double],
  name : String,
) -> FinanceriskcomponentSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinanceriskcomponentSeries::len(
  self : FinanceriskcomponentSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn FinanceriskcomponentSeries::sum(
  self : FinanceriskcomponentSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinanceriskcomponentSeries::mean(
  self : FinanceriskcomponentSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinanceriskcomponentSeries::min(
  self : FinanceriskcomponentSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinanceriskcomponentSeries::max(
  self : FinanceriskcomponentSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinanceriskcomponentSeries::range(
  self : FinanceriskcomponentSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinanceriskcomponentSeries::variance(
  self : FinanceriskcomponentSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinanceriskcomponentSeries::std(
  self : FinanceriskcomponentSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinanceriskcomponentSeries::median(
  self : FinanceriskcomponentSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinanceriskcomponentSeries::scale(
  self : FinanceriskcomponentSeries,
  f : Double,
) -> FinanceriskcomponentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinanceriskcomponentSeries::add(
  self : FinanceriskcomponentSeries,
  other : FinanceriskcomponentSeries,
) -> FinanceriskcomponentSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceriskcomponentSeries::sub(
  self : FinanceriskcomponentSeries,
  other : FinanceriskcomponentSeries,
) -> FinanceriskcomponentSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceriskcomponentSeries::normalize(
  self : FinanceriskcomponentSeries,
) -> FinanceriskcomponentSeries {
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
pub fn FinanceriskcomponentSeries::cumsum(
  self : FinanceriskcomponentSeries,
) -> FinanceriskcomponentSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinanceriskcomponentSeries::to_string(
  self : FinanceriskcomponentSeries,
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
pub(all) struct FinanceriskcomponentMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_risk_component_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinanceriskcomponentMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_risk_component_matrix_identity(
  n : Int32,
) -> FinanceriskcomponentMatrix {
  let m = finance_risk_component_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinanceriskcomponentMatrix::get(
  self : FinanceriskcomponentMatrix,
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
pub fn FinanceriskcomponentMatrix::transpose(
  self : FinanceriskcomponentMatrix,
) -> FinanceriskcomponentMatrix {
  let result = finance_risk_component_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceriskcomponentMatrix::add(
  self : FinanceriskcomponentMatrix,
  other : FinanceriskcomponentMatrix,
) -> FinanceriskcomponentMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_risk_component_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceriskcomponentMatrix::scale(
  self : FinanceriskcomponentMatrix,
  s : Double,
) -> FinanceriskcomponentMatrix {
  let result = finance_risk_component_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn FinanceriskcomponentMatrix::multiply(
  self : FinanceriskcomponentMatrix,
  other : FinanceriskcomponentMatrix,
) -> FinanceriskcomponentMatrix {
  if self.cols != other.rows {
    return finance_risk_component_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = finance_risk_component_make_matrix(self.rows, other.cols, 0.0)
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
pub fn FinanceriskcomponentMatrix::trace(
  self : FinanceriskcomponentMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinanceriskcomponentMatrix::det(
  self : FinanceriskcomponentMatrix,
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
pub fn FinanceriskcomponentMatrix::norm(
  self : FinanceriskcomponentMatrix,
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
pub fn FinanceriskcomponentMatrix::to_string(
  self : FinanceriskcomponentMatrix,
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
pub(all) struct FinanceriskcomponentVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_risk_component_make_vector(
  comps : Array[Double],
) -> FinanceriskcomponentVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_risk_component_vector_zero(
  dim : Int32,
) -> FinanceriskcomponentVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinanceriskcomponentVector::add(
  self : FinanceriskcomponentVector,
  other : FinanceriskcomponentVector,
) -> FinanceriskcomponentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceriskcomponentVector::sub(
  self : FinanceriskcomponentVector,
  other : FinanceriskcomponentVector,
) -> FinanceriskcomponentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceriskcomponentVector::scale(
  self : FinanceriskcomponentVector,
  s : Double,
) -> FinanceriskcomponentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinanceriskcomponentVector::dot(
  self : FinanceriskcomponentVector,
  other : FinanceriskcomponentVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinanceriskcomponentVector::norm(
  self : FinanceriskcomponentVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinanceriskcomponentVector::normalize(
  self : FinanceriskcomponentVector,
) -> FinanceriskcomponentVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceriskcomponentVector::dist(
  self : FinanceriskcomponentVector,
  other : FinanceriskcomponentVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinanceriskcomponentVector::to_string(
  self : FinanceriskcomponentVector,
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
pub(all) struct FinanceriskcomponentFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_frame_make(
  size : Int32,
) -> FinanceriskcomponentFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentFrame::len(
  self : FinanceriskcomponentFrame,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentFrame::get(
  self : FinanceriskcomponentFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentFrame::set(
  self : FinanceriskcomponentFrame,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentFrame::sum(
  self : FinanceriskcomponentFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentFrame::mean(
  self : FinanceriskcomponentFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentFrame::scale(
  self : FinanceriskcomponentFrame,
  f : Double,
) -> FinanceriskcomponentFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentFrame::add(
  self : FinanceriskcomponentFrame,
  other : FinanceriskcomponentFrame,
) -> FinanceriskcomponentFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentFrame::copy(
  self : FinanceriskcomponentFrame,
) -> FinanceriskcomponentFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentFrame::fill(
  self : FinanceriskcomponentFrame,
  v : Double,
) -> FinanceriskcomponentFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentFrame::min(
  self : FinanceriskcomponentFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentFrame::max(
  self : FinanceriskcomponentFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentFrame::to_string(
  self : FinanceriskcomponentFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_table_make(
  size : Int32,
) -> FinanceriskcomponentTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentTable::len(
  self : FinanceriskcomponentTable,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentTable::get(
  self : FinanceriskcomponentTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentTable::set(
  self : FinanceriskcomponentTable,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentTable::sum(
  self : FinanceriskcomponentTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentTable::mean(
  self : FinanceriskcomponentTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentTable::scale(
  self : FinanceriskcomponentTable,
  f : Double,
) -> FinanceriskcomponentTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentTable::add(
  self : FinanceriskcomponentTable,
  other : FinanceriskcomponentTable,
) -> FinanceriskcomponentTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentTable::copy(
  self : FinanceriskcomponentTable,
) -> FinanceriskcomponentTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentTable::fill(
  self : FinanceriskcomponentTable,
  v : Double,
) -> FinanceriskcomponentTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentTable::min(
  self : FinanceriskcomponentTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentTable::max(
  self : FinanceriskcomponentTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentTable::to_string(
  self : FinanceriskcomponentTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_graphn_make(
  size : Int32,
) -> FinanceriskcomponentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentGraphN::len(
  self : FinanceriskcomponentGraphN,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentGraphN::get(
  self : FinanceriskcomponentGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentGraphN::set(
  self : FinanceriskcomponentGraphN,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentGraphN::sum(
  self : FinanceriskcomponentGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentGraphN::mean(
  self : FinanceriskcomponentGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentGraphN::scale(
  self : FinanceriskcomponentGraphN,
  f : Double,
) -> FinanceriskcomponentGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentGraphN::add(
  self : FinanceriskcomponentGraphN,
  other : FinanceriskcomponentGraphN,
) -> FinanceriskcomponentGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentGraphN::copy(
  self : FinanceriskcomponentGraphN,
) -> FinanceriskcomponentGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentGraphN::fill(
  self : FinanceriskcomponentGraphN,
  v : Double,
) -> FinanceriskcomponentGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentGraphN::min(
  self : FinanceriskcomponentGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentGraphN::max(
  self : FinanceriskcomponentGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentGraphN::to_string(
  self : FinanceriskcomponentGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_node_make(
  size : Int32,
) -> FinanceriskcomponentNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentNode::len(self : FinanceriskcomponentNode) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentNode::get(
  self : FinanceriskcomponentNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentNode::set(
  self : FinanceriskcomponentNode,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentNode::sum(self : FinanceriskcomponentNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentNode::mean(
  self : FinanceriskcomponentNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentNode::scale(
  self : FinanceriskcomponentNode,
  f : Double,
) -> FinanceriskcomponentNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentNode::add(
  self : FinanceriskcomponentNode,
  other : FinanceriskcomponentNode,
) -> FinanceriskcomponentNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentNode::copy(
  self : FinanceriskcomponentNode,
) -> FinanceriskcomponentNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentNode::fill(
  self : FinanceriskcomponentNode,
  v : Double,
) -> FinanceriskcomponentNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentNode::min(self : FinanceriskcomponentNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentNode::max(self : FinanceriskcomponentNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentNode::to_string(
  self : FinanceriskcomponentNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_edge_make(
  size : Int32,
) -> FinanceriskcomponentEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentEdge::len(self : FinanceriskcomponentEdge) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentEdge::get(
  self : FinanceriskcomponentEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentEdge::set(
  self : FinanceriskcomponentEdge,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentEdge::sum(self : FinanceriskcomponentEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentEdge::mean(
  self : FinanceriskcomponentEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentEdge::scale(
  self : FinanceriskcomponentEdge,
  f : Double,
) -> FinanceriskcomponentEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentEdge::add(
  self : FinanceriskcomponentEdge,
  other : FinanceriskcomponentEdge,
) -> FinanceriskcomponentEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentEdge::copy(
  self : FinanceriskcomponentEdge,
) -> FinanceriskcomponentEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentEdge::fill(
  self : FinanceriskcomponentEdge,
  v : Double,
) -> FinanceriskcomponentEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentEdge::min(self : FinanceriskcomponentEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentEdge::max(self : FinanceriskcomponentEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentEdge::to_string(
  self : FinanceriskcomponentEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_path_make(
  size : Int32,
) -> FinanceriskcomponentPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentPath::len(self : FinanceriskcomponentPath) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentPath::get(
  self : FinanceriskcomponentPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentPath::set(
  self : FinanceriskcomponentPath,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentPath::sum(self : FinanceriskcomponentPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentPath::mean(
  self : FinanceriskcomponentPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentPath::scale(
  self : FinanceriskcomponentPath,
  f : Double,
) -> FinanceriskcomponentPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentPath::add(
  self : FinanceriskcomponentPath,
  other : FinanceriskcomponentPath,
) -> FinanceriskcomponentPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentPath::copy(
  self : FinanceriskcomponentPath,
) -> FinanceriskcomponentPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentPath::fill(
  self : FinanceriskcomponentPath,
  v : Double,
) -> FinanceriskcomponentPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentPath::min(self : FinanceriskcomponentPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentPath::max(self : FinanceriskcomponentPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentPath::to_string(
  self : FinanceriskcomponentPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_cluster_make(
  size : Int32,
) -> FinanceriskcomponentCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentCluster::len(
  self : FinanceriskcomponentCluster,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentCluster::get(
  self : FinanceriskcomponentCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentCluster::set(
  self : FinanceriskcomponentCluster,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentCluster::sum(
  self : FinanceriskcomponentCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentCluster::mean(
  self : FinanceriskcomponentCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentCluster::scale(
  self : FinanceriskcomponentCluster,
  f : Double,
) -> FinanceriskcomponentCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentCluster::add(
  self : FinanceriskcomponentCluster,
  other : FinanceriskcomponentCluster,
) -> FinanceriskcomponentCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentCluster::copy(
  self : FinanceriskcomponentCluster,
) -> FinanceriskcomponentCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentCluster::fill(
  self : FinanceriskcomponentCluster,
  v : Double,
) -> FinanceriskcomponentCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentCluster::min(
  self : FinanceriskcomponentCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentCluster::max(
  self : FinanceriskcomponentCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentCluster::to_string(
  self : FinanceriskcomponentCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_model_make(
  size : Int32,
) -> FinanceriskcomponentModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentModel::len(
  self : FinanceriskcomponentModel,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentModel::get(
  self : FinanceriskcomponentModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentModel::set(
  self : FinanceriskcomponentModel,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentModel::sum(
  self : FinanceriskcomponentModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentModel::mean(
  self : FinanceriskcomponentModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentModel::scale(
  self : FinanceriskcomponentModel,
  f : Double,
) -> FinanceriskcomponentModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentModel::add(
  self : FinanceriskcomponentModel,
  other : FinanceriskcomponentModel,
) -> FinanceriskcomponentModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentModel::copy(
  self : FinanceriskcomponentModel,
) -> FinanceriskcomponentModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentModel::fill(
  self : FinanceriskcomponentModel,
  v : Double,
) -> FinanceriskcomponentModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentModel::min(
  self : FinanceriskcomponentModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentModel::max(
  self : FinanceriskcomponentModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentModel::to_string(
  self : FinanceriskcomponentModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_layer_make(
  size : Int32,
) -> FinanceriskcomponentLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentLayer::len(
  self : FinanceriskcomponentLayer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentLayer::get(
  self : FinanceriskcomponentLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentLayer::set(
  self : FinanceriskcomponentLayer,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentLayer::sum(
  self : FinanceriskcomponentLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentLayer::mean(
  self : FinanceriskcomponentLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentLayer::scale(
  self : FinanceriskcomponentLayer,
  f : Double,
) -> FinanceriskcomponentLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentLayer::add(
  self : FinanceriskcomponentLayer,
  other : FinanceriskcomponentLayer,
) -> FinanceriskcomponentLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentLayer::copy(
  self : FinanceriskcomponentLayer,
) -> FinanceriskcomponentLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentLayer::fill(
  self : FinanceriskcomponentLayer,
  v : Double,
) -> FinanceriskcomponentLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentLayer::min(
  self : FinanceriskcomponentLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentLayer::max(
  self : FinanceriskcomponentLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentLayer::to_string(
  self : FinanceriskcomponentLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_buffer_make(
  size : Int32,
) -> FinanceriskcomponentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentBuffer::len(
  self : FinanceriskcomponentBuffer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentBuffer::get(
  self : FinanceriskcomponentBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentBuffer::set(
  self : FinanceriskcomponentBuffer,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentBuffer::sum(
  self : FinanceriskcomponentBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentBuffer::mean(
  self : FinanceriskcomponentBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentBuffer::scale(
  self : FinanceriskcomponentBuffer,
  f : Double,
) -> FinanceriskcomponentBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentBuffer::add(
  self : FinanceriskcomponentBuffer,
  other : FinanceriskcomponentBuffer,
) -> FinanceriskcomponentBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentBuffer::copy(
  self : FinanceriskcomponentBuffer,
) -> FinanceriskcomponentBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentBuffer::fill(
  self : FinanceriskcomponentBuffer,
  v : Double,
) -> FinanceriskcomponentBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentBuffer::min(
  self : FinanceriskcomponentBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentBuffer::max(
  self : FinanceriskcomponentBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentBuffer::to_string(
  self : FinanceriskcomponentBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_cursor_make(
  size : Int32,
) -> FinanceriskcomponentCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentCursor::len(
  self : FinanceriskcomponentCursor,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentCursor::get(
  self : FinanceriskcomponentCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentCursor::set(
  self : FinanceriskcomponentCursor,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentCursor::sum(
  self : FinanceriskcomponentCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentCursor::mean(
  self : FinanceriskcomponentCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentCursor::scale(
  self : FinanceriskcomponentCursor,
  f : Double,
) -> FinanceriskcomponentCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentCursor::add(
  self : FinanceriskcomponentCursor,
  other : FinanceriskcomponentCursor,
) -> FinanceriskcomponentCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentCursor::copy(
  self : FinanceriskcomponentCursor,
) -> FinanceriskcomponentCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentCursor::fill(
  self : FinanceriskcomponentCursor,
  v : Double,
) -> FinanceriskcomponentCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentCursor::min(
  self : FinanceriskcomponentCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentCursor::max(
  self : FinanceriskcomponentCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentCursor::to_string(
  self : FinanceriskcomponentCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_view_make(
  size : Int32,
) -> FinanceriskcomponentView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentView::len(self : FinanceriskcomponentView) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentView::get(
  self : FinanceriskcomponentView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentView::set(
  self : FinanceriskcomponentView,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentView::sum(self : FinanceriskcomponentView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentView::mean(
  self : FinanceriskcomponentView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentView::scale(
  self : FinanceriskcomponentView,
  f : Double,
) -> FinanceriskcomponentView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentView::add(
  self : FinanceriskcomponentView,
  other : FinanceriskcomponentView,
) -> FinanceriskcomponentView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentView::copy(
  self : FinanceriskcomponentView,
) -> FinanceriskcomponentView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentView::fill(
  self : FinanceriskcomponentView,
  v : Double,
) -> FinanceriskcomponentView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentView::min(self : FinanceriskcomponentView) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentView::max(self : FinanceriskcomponentView) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentView::to_string(
  self : FinanceriskcomponentView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_range_make(
  size : Int32,
) -> FinanceriskcomponentRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentRange::len(
  self : FinanceriskcomponentRange,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentRange::get(
  self : FinanceriskcomponentRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentRange::set(
  self : FinanceriskcomponentRange,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentRange::sum(
  self : FinanceriskcomponentRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentRange::mean(
  self : FinanceriskcomponentRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentRange::scale(
  self : FinanceriskcomponentRange,
  f : Double,
) -> FinanceriskcomponentRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentRange::add(
  self : FinanceriskcomponentRange,
  other : FinanceriskcomponentRange,
) -> FinanceriskcomponentRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentRange::copy(
  self : FinanceriskcomponentRange,
) -> FinanceriskcomponentRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentRange::fill(
  self : FinanceriskcomponentRange,
  v : Double,
) -> FinanceriskcomponentRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentRange::min(
  self : FinanceriskcomponentRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentRange::max(
  self : FinanceriskcomponentRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentRange::to_string(
  self : FinanceriskcomponentRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskcomponentSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_component_slice_make(
  size : Int32,
) -> FinanceriskcomponentSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskcomponentSlice::len(
  self : FinanceriskcomponentSlice,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskcomponentSlice::get(
  self : FinanceriskcomponentSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskcomponentSlice::set(
  self : FinanceriskcomponentSlice,
  i : Int32,
  v : Double,
) -> FinanceriskcomponentSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentSlice::sum(
  self : FinanceriskcomponentSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskcomponentSlice::mean(
  self : FinanceriskcomponentSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskcomponentSlice::scale(
  self : FinanceriskcomponentSlice,
  f : Double,
) -> FinanceriskcomponentSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentSlice::add(
  self : FinanceriskcomponentSlice,
  other : FinanceriskcomponentSlice,
) -> FinanceriskcomponentSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentSlice::copy(
  self : FinanceriskcomponentSlice,
) -> FinanceriskcomponentSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentSlice::fill(
  self : FinanceriskcomponentSlice,
  v : Double,
) -> FinanceriskcomponentSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskcomponentSlice::min(
  self : FinanceriskcomponentSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskcomponentSlice::max(
  self : FinanceriskcomponentSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskcomponentSlice::to_string(
  self : FinanceriskcomponentSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
