///|
///===
/// extcore/finance_risk_var
pub(all) struct FinanceriskvarPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn finance_risk_var_make_point(
  x : Double,
  y : Double,
) -> FinanceriskvarPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn finance_risk_var_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> FinanceriskvarPoint {
  { x, y, z, label: 0, }
}

///|
pub fn FinanceriskvarPoint::x(self : FinanceriskvarPoint) -> Double {
  self.x
}

///|
pub fn FinanceriskvarPoint::y(self : FinanceriskvarPoint) -> Double {
  self.y
}

///|
pub fn FinanceriskvarPoint::z(self : FinanceriskvarPoint) -> Double {
  self.z
}

///|
pub fn FinanceriskvarPoint::label(self : FinanceriskvarPoint) -> Int32 {
  self.label
}

///|
pub fn FinanceriskvarPoint::dist(
  self : FinanceriskvarPoint,
  other : FinanceriskvarPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn FinanceriskvarPoint::add(
  self : FinanceriskvarPoint,
  other : FinanceriskvarPoint,
) -> FinanceriskvarPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn FinanceriskvarPoint::sub(
  self : FinanceriskvarPoint,
  other : FinanceriskvarPoint,
) -> FinanceriskvarPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn FinanceriskvarPoint::scale(
  self : FinanceriskvarPoint,
  s : Double,
) -> FinanceriskvarPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn FinanceriskvarPoint::dot(
  self : FinanceriskvarPoint,
  other : FinanceriskvarPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn FinanceriskvarPoint::cross(
  self : FinanceriskvarPoint,
  other : FinanceriskvarPoint,
) -> FinanceriskvarPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn FinanceriskvarPoint::norm(self : FinanceriskvarPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn FinanceriskvarPoint::normalize(
  self : FinanceriskvarPoint,
) -> FinanceriskvarPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceriskvarPoint::negate(
  self : FinanceriskvarPoint,
) -> FinanceriskvarPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn FinanceriskvarPoint::mid(
  self : FinanceriskvarPoint,
  other : FinanceriskvarPoint,
) -> FinanceriskvarPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn FinanceriskvarPoint::lerp(
  self : FinanceriskvarPoint,
  other : FinanceriskvarPoint,
  t : Double,
) -> FinanceriskvarPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn FinanceriskvarPoint::to_string(self : FinanceriskvarPoint) -> String {
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
pub(all) struct FinanceriskvarSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn finance_risk_var_make_series(
  vals : Array[Double],
  name : String,
) -> FinanceriskvarSeries {
  { vals, name, meta: 0, }
}

///|
pub fn FinanceriskvarSeries::len(self : FinanceriskvarSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn FinanceriskvarSeries::sum(self : FinanceriskvarSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn FinanceriskvarSeries::mean(self : FinanceriskvarSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn FinanceriskvarSeries::min(self : FinanceriskvarSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn FinanceriskvarSeries::max(self : FinanceriskvarSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn FinanceriskvarSeries::range(self : FinanceriskvarSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn FinanceriskvarSeries::variance(self : FinanceriskvarSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn FinanceriskvarSeries::std(self : FinanceriskvarSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn FinanceriskvarSeries::median(self : FinanceriskvarSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn FinanceriskvarSeries::scale(
  self : FinanceriskvarSeries,
  f : Double,
) -> FinanceriskvarSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn FinanceriskvarSeries::add(
  self : FinanceriskvarSeries,
  other : FinanceriskvarSeries,
) -> FinanceriskvarSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceriskvarSeries::sub(
  self : FinanceriskvarSeries,
  other : FinanceriskvarSeries,
) -> FinanceriskvarSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn FinanceriskvarSeries::normalize(
  self : FinanceriskvarSeries,
) -> FinanceriskvarSeries {
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
pub fn FinanceriskvarSeries::cumsum(
  self : FinanceriskvarSeries,
) -> FinanceriskvarSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn FinanceriskvarSeries::to_string(self : FinanceriskvarSeries) -> String {
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
pub(all) struct FinanceriskvarMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn finance_risk_var_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> FinanceriskvarMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn finance_risk_var_matrix_identity(n : Int32) -> FinanceriskvarMatrix {
  let m = finance_risk_var_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn FinanceriskvarMatrix::get(
  self : FinanceriskvarMatrix,
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
pub fn FinanceriskvarMatrix::transpose(
  self : FinanceriskvarMatrix,
) -> FinanceriskvarMatrix {
  let result = finance_risk_var_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceriskvarMatrix::add(
  self : FinanceriskvarMatrix,
  other : FinanceriskvarMatrix,
) -> FinanceriskvarMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = finance_risk_var_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn FinanceriskvarMatrix::scale(
  self : FinanceriskvarMatrix,
  s : Double,
) -> FinanceriskvarMatrix {
  let result = finance_risk_var_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn FinanceriskvarMatrix::multiply(
  self : FinanceriskvarMatrix,
  other : FinanceriskvarMatrix,
) -> FinanceriskvarMatrix {
  if self.cols != other.rows {
    return finance_risk_var_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = finance_risk_var_make_matrix(self.rows, other.cols, 0.0)
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
pub fn FinanceriskvarMatrix::trace(self : FinanceriskvarMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn FinanceriskvarMatrix::det(self : FinanceriskvarMatrix) -> Double {
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
pub fn FinanceriskvarMatrix::norm(self : FinanceriskvarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn FinanceriskvarMatrix::to_string(self : FinanceriskvarMatrix) -> String {
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
pub(all) struct FinanceriskvarVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn finance_risk_var_make_vector(
  comps : Array[Double],
) -> FinanceriskvarVector {
  { comps, dim: comps.length(), }
}

///|
pub fn finance_risk_var_vector_zero(dim : Int32) -> FinanceriskvarVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn FinanceriskvarVector::add(
  self : FinanceriskvarVector,
  other : FinanceriskvarVector,
) -> FinanceriskvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceriskvarVector::sub(
  self : FinanceriskvarVector,
  other : FinanceriskvarVector,
) -> FinanceriskvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn FinanceriskvarVector::scale(
  self : FinanceriskvarVector,
  s : Double,
) -> FinanceriskvarVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn FinanceriskvarVector::dot(
  self : FinanceriskvarVector,
  other : FinanceriskvarVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn FinanceriskvarVector::norm(self : FinanceriskvarVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn FinanceriskvarVector::normalize(
  self : FinanceriskvarVector,
) -> FinanceriskvarVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn FinanceriskvarVector::dist(
  self : FinanceriskvarVector,
  other : FinanceriskvarVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn FinanceriskvarVector::to_string(self : FinanceriskvarVector) -> String {
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
pub(all) struct FinanceriskvarFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_frame_make(size : Int32) -> FinanceriskvarFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarFrame::len(self : FinanceriskvarFrame) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarFrame::get(
  self : FinanceriskvarFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarFrame::set(
  self : FinanceriskvarFrame,
  i : Int32,
  v : Double,
) -> FinanceriskvarFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarFrame::sum(self : FinanceriskvarFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarFrame::mean(self : FinanceriskvarFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarFrame::scale(
  self : FinanceriskvarFrame,
  f : Double,
) -> FinanceriskvarFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarFrame::add(
  self : FinanceriskvarFrame,
  other : FinanceriskvarFrame,
) -> FinanceriskvarFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarFrame::copy(
  self : FinanceriskvarFrame,
) -> FinanceriskvarFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarFrame::fill(
  self : FinanceriskvarFrame,
  v : Double,
) -> FinanceriskvarFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarFrame::min(self : FinanceriskvarFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarFrame::max(self : FinanceriskvarFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarFrame::to_string(self : FinanceriskvarFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_table_make(size : Int32) -> FinanceriskvarTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarTable::len(self : FinanceriskvarTable) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarTable::get(
  self : FinanceriskvarTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarTable::set(
  self : FinanceriskvarTable,
  i : Int32,
  v : Double,
) -> FinanceriskvarTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarTable::sum(self : FinanceriskvarTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarTable::mean(self : FinanceriskvarTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarTable::scale(
  self : FinanceriskvarTable,
  f : Double,
) -> FinanceriskvarTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarTable::add(
  self : FinanceriskvarTable,
  other : FinanceriskvarTable,
) -> FinanceriskvarTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarTable::copy(
  self : FinanceriskvarTable,
) -> FinanceriskvarTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarTable::fill(
  self : FinanceriskvarTable,
  v : Double,
) -> FinanceriskvarTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarTable::min(self : FinanceriskvarTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarTable::max(self : FinanceriskvarTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarTable::to_string(self : FinanceriskvarTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_graphn_make(size : Int32) -> FinanceriskvarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarGraphN::len(self : FinanceriskvarGraphN) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarGraphN::get(
  self : FinanceriskvarGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarGraphN::set(
  self : FinanceriskvarGraphN,
  i : Int32,
  v : Double,
) -> FinanceriskvarGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarGraphN::sum(self : FinanceriskvarGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarGraphN::mean(self : FinanceriskvarGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarGraphN::scale(
  self : FinanceriskvarGraphN,
  f : Double,
) -> FinanceriskvarGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarGraphN::add(
  self : FinanceriskvarGraphN,
  other : FinanceriskvarGraphN,
) -> FinanceriskvarGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarGraphN::copy(
  self : FinanceriskvarGraphN,
) -> FinanceriskvarGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarGraphN::fill(
  self : FinanceriskvarGraphN,
  v : Double,
) -> FinanceriskvarGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarGraphN::min(self : FinanceriskvarGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarGraphN::max(self : FinanceriskvarGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarGraphN::to_string(self : FinanceriskvarGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_node_make(size : Int32) -> FinanceriskvarNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarNode::len(self : FinanceriskvarNode) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarNode::get(self : FinanceriskvarNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarNode::set(
  self : FinanceriskvarNode,
  i : Int32,
  v : Double,
) -> FinanceriskvarNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarNode::sum(self : FinanceriskvarNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarNode::mean(self : FinanceriskvarNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarNode::scale(
  self : FinanceriskvarNode,
  f : Double,
) -> FinanceriskvarNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarNode::add(
  self : FinanceriskvarNode,
  other : FinanceriskvarNode,
) -> FinanceriskvarNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarNode::copy(
  self : FinanceriskvarNode,
) -> FinanceriskvarNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarNode::fill(
  self : FinanceriskvarNode,
  v : Double,
) -> FinanceriskvarNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarNode::min(self : FinanceriskvarNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarNode::max(self : FinanceriskvarNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarNode::to_string(self : FinanceriskvarNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_edge_make(size : Int32) -> FinanceriskvarEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarEdge::len(self : FinanceriskvarEdge) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarEdge::get(self : FinanceriskvarEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarEdge::set(
  self : FinanceriskvarEdge,
  i : Int32,
  v : Double,
) -> FinanceriskvarEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarEdge::sum(self : FinanceriskvarEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarEdge::mean(self : FinanceriskvarEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarEdge::scale(
  self : FinanceriskvarEdge,
  f : Double,
) -> FinanceriskvarEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarEdge::add(
  self : FinanceriskvarEdge,
  other : FinanceriskvarEdge,
) -> FinanceriskvarEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarEdge::copy(
  self : FinanceriskvarEdge,
) -> FinanceriskvarEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarEdge::fill(
  self : FinanceriskvarEdge,
  v : Double,
) -> FinanceriskvarEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarEdge::min(self : FinanceriskvarEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarEdge::max(self : FinanceriskvarEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarEdge::to_string(self : FinanceriskvarEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_path_make(size : Int32) -> FinanceriskvarPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarPath::len(self : FinanceriskvarPath) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarPath::get(self : FinanceriskvarPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarPath::set(
  self : FinanceriskvarPath,
  i : Int32,
  v : Double,
) -> FinanceriskvarPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarPath::sum(self : FinanceriskvarPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarPath::mean(self : FinanceriskvarPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarPath::scale(
  self : FinanceriskvarPath,
  f : Double,
) -> FinanceriskvarPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarPath::add(
  self : FinanceriskvarPath,
  other : FinanceriskvarPath,
) -> FinanceriskvarPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarPath::copy(
  self : FinanceriskvarPath,
) -> FinanceriskvarPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarPath::fill(
  self : FinanceriskvarPath,
  v : Double,
) -> FinanceriskvarPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarPath::min(self : FinanceriskvarPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarPath::max(self : FinanceriskvarPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarPath::to_string(self : FinanceriskvarPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_cluster_make(size : Int32) -> FinanceriskvarCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarCluster::len(self : FinanceriskvarCluster) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarCluster::get(
  self : FinanceriskvarCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarCluster::set(
  self : FinanceriskvarCluster,
  i : Int32,
  v : Double,
) -> FinanceriskvarCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarCluster::sum(self : FinanceriskvarCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarCluster::mean(self : FinanceriskvarCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarCluster::scale(
  self : FinanceriskvarCluster,
  f : Double,
) -> FinanceriskvarCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarCluster::add(
  self : FinanceriskvarCluster,
  other : FinanceriskvarCluster,
) -> FinanceriskvarCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarCluster::copy(
  self : FinanceriskvarCluster,
) -> FinanceriskvarCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarCluster::fill(
  self : FinanceriskvarCluster,
  v : Double,
) -> FinanceriskvarCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarCluster::min(self : FinanceriskvarCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarCluster::max(self : FinanceriskvarCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarCluster::to_string(self : FinanceriskvarCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_model_make(size : Int32) -> FinanceriskvarModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarModel::len(self : FinanceriskvarModel) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarModel::get(
  self : FinanceriskvarModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarModel::set(
  self : FinanceriskvarModel,
  i : Int32,
  v : Double,
) -> FinanceriskvarModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarModel::sum(self : FinanceriskvarModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarModel::mean(self : FinanceriskvarModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarModel::scale(
  self : FinanceriskvarModel,
  f : Double,
) -> FinanceriskvarModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarModel::add(
  self : FinanceriskvarModel,
  other : FinanceriskvarModel,
) -> FinanceriskvarModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarModel::copy(
  self : FinanceriskvarModel,
) -> FinanceriskvarModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarModel::fill(
  self : FinanceriskvarModel,
  v : Double,
) -> FinanceriskvarModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarModel::min(self : FinanceriskvarModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarModel::max(self : FinanceriskvarModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarModel::to_string(self : FinanceriskvarModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_layer_make(size : Int32) -> FinanceriskvarLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarLayer::len(self : FinanceriskvarLayer) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarLayer::get(
  self : FinanceriskvarLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarLayer::set(
  self : FinanceriskvarLayer,
  i : Int32,
  v : Double,
) -> FinanceriskvarLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarLayer::sum(self : FinanceriskvarLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarLayer::mean(self : FinanceriskvarLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarLayer::scale(
  self : FinanceriskvarLayer,
  f : Double,
) -> FinanceriskvarLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarLayer::add(
  self : FinanceriskvarLayer,
  other : FinanceriskvarLayer,
) -> FinanceriskvarLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarLayer::copy(
  self : FinanceriskvarLayer,
) -> FinanceriskvarLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarLayer::fill(
  self : FinanceriskvarLayer,
  v : Double,
) -> FinanceriskvarLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarLayer::min(self : FinanceriskvarLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarLayer::max(self : FinanceriskvarLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarLayer::to_string(self : FinanceriskvarLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_buffer_make(size : Int32) -> FinanceriskvarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarBuffer::len(self : FinanceriskvarBuffer) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarBuffer::get(
  self : FinanceriskvarBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarBuffer::set(
  self : FinanceriskvarBuffer,
  i : Int32,
  v : Double,
) -> FinanceriskvarBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarBuffer::sum(self : FinanceriskvarBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarBuffer::mean(self : FinanceriskvarBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarBuffer::scale(
  self : FinanceriskvarBuffer,
  f : Double,
) -> FinanceriskvarBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarBuffer::add(
  self : FinanceriskvarBuffer,
  other : FinanceriskvarBuffer,
) -> FinanceriskvarBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarBuffer::copy(
  self : FinanceriskvarBuffer,
) -> FinanceriskvarBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarBuffer::fill(
  self : FinanceriskvarBuffer,
  v : Double,
) -> FinanceriskvarBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarBuffer::min(self : FinanceriskvarBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarBuffer::max(self : FinanceriskvarBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarBuffer::to_string(self : FinanceriskvarBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_cursor_make(size : Int32) -> FinanceriskvarCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarCursor::len(self : FinanceriskvarCursor) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarCursor::get(
  self : FinanceriskvarCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarCursor::set(
  self : FinanceriskvarCursor,
  i : Int32,
  v : Double,
) -> FinanceriskvarCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarCursor::sum(self : FinanceriskvarCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarCursor::mean(self : FinanceriskvarCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarCursor::scale(
  self : FinanceriskvarCursor,
  f : Double,
) -> FinanceriskvarCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarCursor::add(
  self : FinanceriskvarCursor,
  other : FinanceriskvarCursor,
) -> FinanceriskvarCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarCursor::copy(
  self : FinanceriskvarCursor,
) -> FinanceriskvarCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarCursor::fill(
  self : FinanceriskvarCursor,
  v : Double,
) -> FinanceriskvarCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarCursor::min(self : FinanceriskvarCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarCursor::max(self : FinanceriskvarCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarCursor::to_string(self : FinanceriskvarCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_view_make(size : Int32) -> FinanceriskvarView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarView::len(self : FinanceriskvarView) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarView::get(self : FinanceriskvarView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarView::set(
  self : FinanceriskvarView,
  i : Int32,
  v : Double,
) -> FinanceriskvarView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarView::sum(self : FinanceriskvarView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarView::mean(self : FinanceriskvarView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarView::scale(
  self : FinanceriskvarView,
  f : Double,
) -> FinanceriskvarView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarView::add(
  self : FinanceriskvarView,
  other : FinanceriskvarView,
) -> FinanceriskvarView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarView::copy(
  self : FinanceriskvarView,
) -> FinanceriskvarView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarView::fill(
  self : FinanceriskvarView,
  v : Double,
) -> FinanceriskvarView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarView::min(self : FinanceriskvarView) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarView::max(self : FinanceriskvarView) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarView::to_string(self : FinanceriskvarView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_range_make(size : Int32) -> FinanceriskvarRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarRange::len(self : FinanceriskvarRange) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarRange::get(
  self : FinanceriskvarRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarRange::set(
  self : FinanceriskvarRange,
  i : Int32,
  v : Double,
) -> FinanceriskvarRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarRange::sum(self : FinanceriskvarRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarRange::mean(self : FinanceriskvarRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarRange::scale(
  self : FinanceriskvarRange,
  f : Double,
) -> FinanceriskvarRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarRange::add(
  self : FinanceriskvarRange,
  other : FinanceriskvarRange,
) -> FinanceriskvarRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarRange::copy(
  self : FinanceriskvarRange,
) -> FinanceriskvarRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarRange::fill(
  self : FinanceriskvarRange,
  v : Double,
) -> FinanceriskvarRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarRange::min(self : FinanceriskvarRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarRange::max(self : FinanceriskvarRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarRange::to_string(self : FinanceriskvarRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct FinanceriskvarSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn finance_risk_var_slice_make(size : Int32) -> FinanceriskvarSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn FinanceriskvarSlice::len(self : FinanceriskvarSlice) -> Int32 {
  self.size
}

///|
pub fn FinanceriskvarSlice::get(
  self : FinanceriskvarSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn FinanceriskvarSlice::set(
  self : FinanceriskvarSlice,
  i : Int32,
  v : Double,
) -> FinanceriskvarSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarSlice::sum(self : FinanceriskvarSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn FinanceriskvarSlice::mean(self : FinanceriskvarSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn FinanceriskvarSlice::scale(
  self : FinanceriskvarSlice,
  f : Double,
) -> FinanceriskvarSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarSlice::add(
  self : FinanceriskvarSlice,
  other : FinanceriskvarSlice,
) -> FinanceriskvarSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn FinanceriskvarSlice::copy(
  self : FinanceriskvarSlice,
) -> FinanceriskvarSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarSlice::fill(
  self : FinanceriskvarSlice,
  v : Double,
) -> FinanceriskvarSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn FinanceriskvarSlice::min(self : FinanceriskvarSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn FinanceriskvarSlice::max(self : FinanceriskvarSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn FinanceriskvarSlice::to_string(self : FinanceriskvarSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
