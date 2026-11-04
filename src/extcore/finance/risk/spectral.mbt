///|
///===
/// extcore/finance_risk_spectral
pub(all) struct FinanceriskspectralPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_risk_spectral_make_point(
  x : Double,
  y : Double,
) -> FinanceriskspectralPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_risk_spectral_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinanceriskspectralPoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinanceriskspectralPoint::x(self : FinanceriskspectralPoint) -> Double {
  self.x
}

///|
pub fn FinanceriskspectralPoint::y(self : FinanceriskspectralPoint) -> Double {
  self.y
}

///|
pub fn FinanceriskspectralPoint::z(self : FinanceriskspectralPoint) -> Double {
  self.z
}

///|
pub fn FinanceriskspectralPoint::label(
  self : FinanceriskspectralPoint,
) -> Int32 {
  self.label
}

///|
pub fn FinanceriskspectralPoint::dist(
  self : FinanceriskspectralPoint,
  other : FinanceriskspectralPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinanceriskspectralPoint::add(
  self : FinanceriskspectralPoint,
  other : FinanceriskspectralPoint,
) -> FinanceriskspectralPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinanceriskspectralPoint::sub(
  self : FinanceriskspectralPoint,
  other : FinanceriskspectralPoint,
) -> FinanceriskspectralPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinanceriskspectralPoint::scale(
  self : FinanceriskspectralPoint,
  s : Double,
) -> FinanceriskspectralPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinanceriskspectralPoint::dot(
  self : FinanceriskspectralPoint,
  other : FinanceriskspectralPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinanceriskspectralPoint::cross(
  self : FinanceriskspectralPoint,
  other : FinanceriskspectralPoint,
) -> FinanceriskspectralPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinanceriskspectralPoint::norm(
  self : FinanceriskspectralPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinanceriskspectralPoint::normalize(
  self : FinanceriskspectralPoint,
) -> FinanceriskspectralPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceriskspectralPoint::negate(
  self : FinanceriskspectralPoint,
) -> FinanceriskspectralPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinanceriskspectralPoint::mid(
  self : FinanceriskspectralPoint,
  other : FinanceriskspectralPoint,
) -> FinanceriskspectralPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinanceriskspectralPoint::lerp(
  self : FinanceriskspectralPoint,
  other : FinanceriskspectralPoint,
  t : Double,
) -> FinanceriskspectralPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinanceriskspectralPoint::to_string(
  self : FinanceriskspectralPoint,
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
pub(all) struct FinanceriskspectralSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_risk_spectral_make_series(
  vals : Array[Double],
  name : String,
) -> FinanceriskspectralSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinanceriskspectralSeries::len(
  self : FinanceriskspectralSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn FinanceriskspectralSeries::sum(
  self : FinanceriskspectralSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinanceriskspectralSeries::mean(
  self : FinanceriskspectralSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinanceriskspectralSeries::min(
  self : FinanceriskspectralSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinanceriskspectralSeries::max(
  self : FinanceriskspectralSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinanceriskspectralSeries::range(
  self : FinanceriskspectralSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinanceriskspectralSeries::variance(
  self : FinanceriskspectralSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinanceriskspectralSeries::std(
  self : FinanceriskspectralSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinanceriskspectralSeries::median(
  self : FinanceriskspectralSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinanceriskspectralSeries::scale(
  self : FinanceriskspectralSeries,
  f : Double,
) -> FinanceriskspectralSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinanceriskspectralSeries::add(
  self : FinanceriskspectralSeries,
  other : FinanceriskspectralSeries,
) -> FinanceriskspectralSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceriskspectralSeries::sub(
  self : FinanceriskspectralSeries,
  other : FinanceriskspectralSeries,
) -> FinanceriskspectralSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceriskspectralSeries::normalize(
  self : FinanceriskspectralSeries,
) -> FinanceriskspectralSeries {
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
pub fn FinanceriskspectralSeries::cumsum(
  self : FinanceriskspectralSeries,
) -> FinanceriskspectralSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinanceriskspectralSeries::to_string(
  self : FinanceriskspectralSeries,
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
pub(all) struct FinanceriskspectralMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_risk_spectral_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinanceriskspectralMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_risk_spectral_matrix_identity(
  n : Int32,
) -> FinanceriskspectralMatrix {
  let m = finance_risk_spectral_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinanceriskspectralMatrix::get(
  self : FinanceriskspectralMatrix,
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
pub fn FinanceriskspectralMatrix::transpose(
  self : FinanceriskspectralMatrix,
) -> FinanceriskspectralMatrix {
  let result = finance_risk_spectral_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceriskspectralMatrix::add(
  self : FinanceriskspectralMatrix,
  other : FinanceriskspectralMatrix,
) -> FinanceriskspectralMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_risk_spectral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceriskspectralMatrix::scale(
  self : FinanceriskspectralMatrix,
  s : Double,
) -> FinanceriskspectralMatrix {
  let result = finance_risk_spectral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn FinanceriskspectralMatrix::multiply(
  self : FinanceriskspectralMatrix,
  other : FinanceriskspectralMatrix,
) -> FinanceriskspectralMatrix {
  if self.cols != other.rows {
    return finance_risk_spectral_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = finance_risk_spectral_make_matrix(self.rows, other.cols, 0.0)
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
pub fn FinanceriskspectralMatrix::trace(
  self : FinanceriskspectralMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinanceriskspectralMatrix::det(
  self : FinanceriskspectralMatrix,
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
pub fn FinanceriskspectralMatrix::norm(
  self : FinanceriskspectralMatrix,
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
pub fn FinanceriskspectralMatrix::to_string(
  self : FinanceriskspectralMatrix,
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
pub(all) struct FinanceriskspectralVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_risk_spectral_make_vector(
  comps : Array[Double],
) -> FinanceriskspectralVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_risk_spectral_vector_zero(
  dim : Int32,
) -> FinanceriskspectralVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinanceriskspectralVector::add(
  self : FinanceriskspectralVector,
  other : FinanceriskspectralVector,
) -> FinanceriskspectralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceriskspectralVector::sub(
  self : FinanceriskspectralVector,
  other : FinanceriskspectralVector,
) -> FinanceriskspectralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceriskspectralVector::scale(
  self : FinanceriskspectralVector,
  s : Double,
) -> FinanceriskspectralVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinanceriskspectralVector::dot(
  self : FinanceriskspectralVector,
  other : FinanceriskspectralVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinanceriskspectralVector::norm(
  self : FinanceriskspectralVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinanceriskspectralVector::normalize(
  self : FinanceriskspectralVector,
) -> FinanceriskspectralVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceriskspectralVector::dist(
  self : FinanceriskspectralVector,
  other : FinanceriskspectralVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinanceriskspectralVector::to_string(
  self : FinanceriskspectralVector,
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
pub(all) struct FinanceriskspectralFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_frame_make(
  size : Int32,
) -> FinanceriskspectralFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralFrame::len(self : FinanceriskspectralFrame) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralFrame::get(
  self : FinanceriskspectralFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralFrame::set(
  self : FinanceriskspectralFrame,
  i : Int32,
  v : Double,
) -> FinanceriskspectralFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralFrame::sum(self : FinanceriskspectralFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralFrame::mean(
  self : FinanceriskspectralFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralFrame::scale(
  self : FinanceriskspectralFrame,
  f : Double,
) -> FinanceriskspectralFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralFrame::add(
  self : FinanceriskspectralFrame,
  other : FinanceriskspectralFrame,
) -> FinanceriskspectralFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralFrame::copy(
  self : FinanceriskspectralFrame,
) -> FinanceriskspectralFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralFrame::fill(
  self : FinanceriskspectralFrame,
  v : Double,
) -> FinanceriskspectralFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralFrame::min(self : FinanceriskspectralFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralFrame::max(self : FinanceriskspectralFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralFrame::to_string(
  self : FinanceriskspectralFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_table_make(
  size : Int32,
) -> FinanceriskspectralTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralTable::len(self : FinanceriskspectralTable) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralTable::get(
  self : FinanceriskspectralTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralTable::set(
  self : FinanceriskspectralTable,
  i : Int32,
  v : Double,
) -> FinanceriskspectralTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralTable::sum(self : FinanceriskspectralTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralTable::mean(
  self : FinanceriskspectralTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralTable::scale(
  self : FinanceriskspectralTable,
  f : Double,
) -> FinanceriskspectralTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralTable::add(
  self : FinanceriskspectralTable,
  other : FinanceriskspectralTable,
) -> FinanceriskspectralTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralTable::copy(
  self : FinanceriskspectralTable,
) -> FinanceriskspectralTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralTable::fill(
  self : FinanceriskspectralTable,
  v : Double,
) -> FinanceriskspectralTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralTable::min(self : FinanceriskspectralTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralTable::max(self : FinanceriskspectralTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralTable::to_string(
  self : FinanceriskspectralTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_graphn_make(
  size : Int32,
) -> FinanceriskspectralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralGraphN::len(
  self : FinanceriskspectralGraphN,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralGraphN::get(
  self : FinanceriskspectralGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralGraphN::set(
  self : FinanceriskspectralGraphN,
  i : Int32,
  v : Double,
) -> FinanceriskspectralGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralGraphN::sum(
  self : FinanceriskspectralGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralGraphN::mean(
  self : FinanceriskspectralGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralGraphN::scale(
  self : FinanceriskspectralGraphN,
  f : Double,
) -> FinanceriskspectralGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralGraphN::add(
  self : FinanceriskspectralGraphN,
  other : FinanceriskspectralGraphN,
) -> FinanceriskspectralGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralGraphN::copy(
  self : FinanceriskspectralGraphN,
) -> FinanceriskspectralGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralGraphN::fill(
  self : FinanceriskspectralGraphN,
  v : Double,
) -> FinanceriskspectralGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralGraphN::min(
  self : FinanceriskspectralGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralGraphN::max(
  self : FinanceriskspectralGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralGraphN::to_string(
  self : FinanceriskspectralGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_node_make(size : Int32) -> FinanceriskspectralNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralNode::len(self : FinanceriskspectralNode) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralNode::get(
  self : FinanceriskspectralNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralNode::set(
  self : FinanceriskspectralNode,
  i : Int32,
  v : Double,
) -> FinanceriskspectralNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralNode::sum(self : FinanceriskspectralNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralNode::mean(self : FinanceriskspectralNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralNode::scale(
  self : FinanceriskspectralNode,
  f : Double,
) -> FinanceriskspectralNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralNode::add(
  self : FinanceriskspectralNode,
  other : FinanceriskspectralNode,
) -> FinanceriskspectralNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralNode::copy(
  self : FinanceriskspectralNode,
) -> FinanceriskspectralNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralNode::fill(
  self : FinanceriskspectralNode,
  v : Double,
) -> FinanceriskspectralNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralNode::min(self : FinanceriskspectralNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralNode::max(self : FinanceriskspectralNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralNode::to_string(
  self : FinanceriskspectralNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_edge_make(size : Int32) -> FinanceriskspectralEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralEdge::len(self : FinanceriskspectralEdge) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralEdge::get(
  self : FinanceriskspectralEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralEdge::set(
  self : FinanceriskspectralEdge,
  i : Int32,
  v : Double,
) -> FinanceriskspectralEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralEdge::sum(self : FinanceriskspectralEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralEdge::mean(self : FinanceriskspectralEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralEdge::scale(
  self : FinanceriskspectralEdge,
  f : Double,
) -> FinanceriskspectralEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralEdge::add(
  self : FinanceriskspectralEdge,
  other : FinanceriskspectralEdge,
) -> FinanceriskspectralEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralEdge::copy(
  self : FinanceriskspectralEdge,
) -> FinanceriskspectralEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralEdge::fill(
  self : FinanceriskspectralEdge,
  v : Double,
) -> FinanceriskspectralEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralEdge::min(self : FinanceriskspectralEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralEdge::max(self : FinanceriskspectralEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralEdge::to_string(
  self : FinanceriskspectralEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_path_make(size : Int32) -> FinanceriskspectralPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralPath::len(self : FinanceriskspectralPath) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralPath::get(
  self : FinanceriskspectralPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralPath::set(
  self : FinanceriskspectralPath,
  i : Int32,
  v : Double,
) -> FinanceriskspectralPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralPath::sum(self : FinanceriskspectralPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralPath::mean(self : FinanceriskspectralPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralPath::scale(
  self : FinanceriskspectralPath,
  f : Double,
) -> FinanceriskspectralPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralPath::add(
  self : FinanceriskspectralPath,
  other : FinanceriskspectralPath,
) -> FinanceriskspectralPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralPath::copy(
  self : FinanceriskspectralPath,
) -> FinanceriskspectralPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralPath::fill(
  self : FinanceriskspectralPath,
  v : Double,
) -> FinanceriskspectralPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralPath::min(self : FinanceriskspectralPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralPath::max(self : FinanceriskspectralPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralPath::to_string(
  self : FinanceriskspectralPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_cluster_make(
  size : Int32,
) -> FinanceriskspectralCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralCluster::len(
  self : FinanceriskspectralCluster,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralCluster::get(
  self : FinanceriskspectralCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralCluster::set(
  self : FinanceriskspectralCluster,
  i : Int32,
  v : Double,
) -> FinanceriskspectralCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralCluster::sum(
  self : FinanceriskspectralCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralCluster::mean(
  self : FinanceriskspectralCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralCluster::scale(
  self : FinanceriskspectralCluster,
  f : Double,
) -> FinanceriskspectralCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralCluster::add(
  self : FinanceriskspectralCluster,
  other : FinanceriskspectralCluster,
) -> FinanceriskspectralCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralCluster::copy(
  self : FinanceriskspectralCluster,
) -> FinanceriskspectralCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralCluster::fill(
  self : FinanceriskspectralCluster,
  v : Double,
) -> FinanceriskspectralCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralCluster::min(
  self : FinanceriskspectralCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralCluster::max(
  self : FinanceriskspectralCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralCluster::to_string(
  self : FinanceriskspectralCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_model_make(
  size : Int32,
) -> FinanceriskspectralModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralModel::len(self : FinanceriskspectralModel) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralModel::get(
  self : FinanceriskspectralModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralModel::set(
  self : FinanceriskspectralModel,
  i : Int32,
  v : Double,
) -> FinanceriskspectralModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralModel::sum(self : FinanceriskspectralModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralModel::mean(
  self : FinanceriskspectralModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralModel::scale(
  self : FinanceriskspectralModel,
  f : Double,
) -> FinanceriskspectralModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralModel::add(
  self : FinanceriskspectralModel,
  other : FinanceriskspectralModel,
) -> FinanceriskspectralModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralModel::copy(
  self : FinanceriskspectralModel,
) -> FinanceriskspectralModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralModel::fill(
  self : FinanceriskspectralModel,
  v : Double,
) -> FinanceriskspectralModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralModel::min(self : FinanceriskspectralModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralModel::max(self : FinanceriskspectralModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralModel::to_string(
  self : FinanceriskspectralModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_layer_make(
  size : Int32,
) -> FinanceriskspectralLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralLayer::len(self : FinanceriskspectralLayer) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralLayer::get(
  self : FinanceriskspectralLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralLayer::set(
  self : FinanceriskspectralLayer,
  i : Int32,
  v : Double,
) -> FinanceriskspectralLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralLayer::sum(self : FinanceriskspectralLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralLayer::mean(
  self : FinanceriskspectralLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralLayer::scale(
  self : FinanceriskspectralLayer,
  f : Double,
) -> FinanceriskspectralLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralLayer::add(
  self : FinanceriskspectralLayer,
  other : FinanceriskspectralLayer,
) -> FinanceriskspectralLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralLayer::copy(
  self : FinanceriskspectralLayer,
) -> FinanceriskspectralLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralLayer::fill(
  self : FinanceriskspectralLayer,
  v : Double,
) -> FinanceriskspectralLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralLayer::min(self : FinanceriskspectralLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralLayer::max(self : FinanceriskspectralLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralLayer::to_string(
  self : FinanceriskspectralLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_buffer_make(
  size : Int32,
) -> FinanceriskspectralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralBuffer::len(
  self : FinanceriskspectralBuffer,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralBuffer::get(
  self : FinanceriskspectralBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralBuffer::set(
  self : FinanceriskspectralBuffer,
  i : Int32,
  v : Double,
) -> FinanceriskspectralBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralBuffer::sum(
  self : FinanceriskspectralBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralBuffer::mean(
  self : FinanceriskspectralBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralBuffer::scale(
  self : FinanceriskspectralBuffer,
  f : Double,
) -> FinanceriskspectralBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralBuffer::add(
  self : FinanceriskspectralBuffer,
  other : FinanceriskspectralBuffer,
) -> FinanceriskspectralBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralBuffer::copy(
  self : FinanceriskspectralBuffer,
) -> FinanceriskspectralBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralBuffer::fill(
  self : FinanceriskspectralBuffer,
  v : Double,
) -> FinanceriskspectralBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralBuffer::min(
  self : FinanceriskspectralBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralBuffer::max(
  self : FinanceriskspectralBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralBuffer::to_string(
  self : FinanceriskspectralBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_cursor_make(
  size : Int32,
) -> FinanceriskspectralCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralCursor::len(
  self : FinanceriskspectralCursor,
) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralCursor::get(
  self : FinanceriskspectralCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralCursor::set(
  self : FinanceriskspectralCursor,
  i : Int32,
  v : Double,
) -> FinanceriskspectralCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralCursor::sum(
  self : FinanceriskspectralCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralCursor::mean(
  self : FinanceriskspectralCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralCursor::scale(
  self : FinanceriskspectralCursor,
  f : Double,
) -> FinanceriskspectralCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralCursor::add(
  self : FinanceriskspectralCursor,
  other : FinanceriskspectralCursor,
) -> FinanceriskspectralCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralCursor::copy(
  self : FinanceriskspectralCursor,
) -> FinanceriskspectralCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralCursor::fill(
  self : FinanceriskspectralCursor,
  v : Double,
) -> FinanceriskspectralCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralCursor::min(
  self : FinanceriskspectralCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralCursor::max(
  self : FinanceriskspectralCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralCursor::to_string(
  self : FinanceriskspectralCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_view_make(size : Int32) -> FinanceriskspectralView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralView::len(self : FinanceriskspectralView) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralView::get(
  self : FinanceriskspectralView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralView::set(
  self : FinanceriskspectralView,
  i : Int32,
  v : Double,
) -> FinanceriskspectralView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralView::sum(self : FinanceriskspectralView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralView::mean(self : FinanceriskspectralView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralView::scale(
  self : FinanceriskspectralView,
  f : Double,
) -> FinanceriskspectralView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralView::add(
  self : FinanceriskspectralView,
  other : FinanceriskspectralView,
) -> FinanceriskspectralView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralView::copy(
  self : FinanceriskspectralView,
) -> FinanceriskspectralView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralView::fill(
  self : FinanceriskspectralView,
  v : Double,
) -> FinanceriskspectralView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralView::min(self : FinanceriskspectralView) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralView::max(self : FinanceriskspectralView) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralView::to_string(
  self : FinanceriskspectralView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_range_make(
  size : Int32,
) -> FinanceriskspectralRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralRange::len(self : FinanceriskspectralRange) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralRange::get(
  self : FinanceriskspectralRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralRange::set(
  self : FinanceriskspectralRange,
  i : Int32,
  v : Double,
) -> FinanceriskspectralRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralRange::sum(self : FinanceriskspectralRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralRange::mean(
  self : FinanceriskspectralRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralRange::scale(
  self : FinanceriskspectralRange,
  f : Double,
) -> FinanceriskspectralRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralRange::add(
  self : FinanceriskspectralRange,
  other : FinanceriskspectralRange,
) -> FinanceriskspectralRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralRange::copy(
  self : FinanceriskspectralRange,
) -> FinanceriskspectralRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralRange::fill(
  self : FinanceriskspectralRange,
  v : Double,
) -> FinanceriskspectralRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralRange::min(self : FinanceriskspectralRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralRange::max(self : FinanceriskspectralRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralRange::to_string(
  self : FinanceriskspectralRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskspectralSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_spectral_slice_make(
  size : Int32,
) -> FinanceriskspectralSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskspectralSlice::len(self : FinanceriskspectralSlice) -> Int32 {
  self.size
}

///|
pub fn FinanceriskspectralSlice::get(
  self : FinanceriskspectralSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskspectralSlice::set(
  self : FinanceriskspectralSlice,
  i : Int32,
  v : Double,
) -> FinanceriskspectralSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralSlice::sum(self : FinanceriskspectralSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskspectralSlice::mean(
  self : FinanceriskspectralSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskspectralSlice::scale(
  self : FinanceriskspectralSlice,
  f : Double,
) -> FinanceriskspectralSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralSlice::add(
  self : FinanceriskspectralSlice,
  other : FinanceriskspectralSlice,
) -> FinanceriskspectralSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskspectralSlice::copy(
  self : FinanceriskspectralSlice,
) -> FinanceriskspectralSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralSlice::fill(
  self : FinanceriskspectralSlice,
  v : Double,
) -> FinanceriskspectralSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskspectralSlice::min(self : FinanceriskspectralSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskspectralSlice::max(self : FinanceriskspectralSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskspectralSlice::to_string(
  self : FinanceriskspectralSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
