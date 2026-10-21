///|
///===
/// extcore/net_sec_firewall
pub(all) struct NetsecfirewallPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn net_sec_firewall_make_point(
  x : Double,
  y : Double,
) -> NetsecfirewallPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn net_sec_firewall_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NetsecfirewallPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NetsecfirewallPoint::x(self : NetsecfirewallPoint) -> Double {
  self.x
}

///|
pub fn NetsecfirewallPoint::y(self : NetsecfirewallPoint) -> Double {
  self.y
}

///|
pub fn NetsecfirewallPoint::z(self : NetsecfirewallPoint) -> Double {
  self.z
}

///|
pub fn NetsecfirewallPoint::label(self : NetsecfirewallPoint) -> Int32 {
  self.label
}

///|
pub fn NetsecfirewallPoint::dist(
  self : NetsecfirewallPoint,
  other : NetsecfirewallPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NetsecfirewallPoint::add(
  self : NetsecfirewallPoint,
  other : NetsecfirewallPoint,
) -> NetsecfirewallPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NetsecfirewallPoint::sub(
  self : NetsecfirewallPoint,
  other : NetsecfirewallPoint,
) -> NetsecfirewallPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NetsecfirewallPoint::scale(
  self : NetsecfirewallPoint,
  s : Double,
) -> NetsecfirewallPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NetsecfirewallPoint::dot(
  self : NetsecfirewallPoint,
  other : NetsecfirewallPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NetsecfirewallPoint::cross(
  self : NetsecfirewallPoint,
  other : NetsecfirewallPoint,
) -> NetsecfirewallPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NetsecfirewallPoint::norm(self : NetsecfirewallPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NetsecfirewallPoint::normalize(
  self : NetsecfirewallPoint,
) -> NetsecfirewallPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetsecfirewallPoint::negate(
  self : NetsecfirewallPoint,
) -> NetsecfirewallPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NetsecfirewallPoint::mid(
  self : NetsecfirewallPoint,
  other : NetsecfirewallPoint,
) -> NetsecfirewallPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NetsecfirewallPoint::lerp(
  self : NetsecfirewallPoint,
  other : NetsecfirewallPoint,
  t : Double,
) -> NetsecfirewallPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NetsecfirewallPoint::to_string(self : NetsecfirewallPoint) -> String {
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
pub(all) struct NetsecfirewallSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn net_sec_firewall_make_series(
  vals : Array[Double],
  name : String,
) -> NetsecfirewallSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NetsecfirewallSeries::len(self : NetsecfirewallSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NetsecfirewallSeries::sum(self : NetsecfirewallSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NetsecfirewallSeries::mean(self : NetsecfirewallSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NetsecfirewallSeries::min(self : NetsecfirewallSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NetsecfirewallSeries::max(self : NetsecfirewallSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NetsecfirewallSeries::range(self : NetsecfirewallSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NetsecfirewallSeries::variance(self : NetsecfirewallSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NetsecfirewallSeries::std(self : NetsecfirewallSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NetsecfirewallSeries::median(self : NetsecfirewallSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NetsecfirewallSeries::scale(
  self : NetsecfirewallSeries,
  f : Double,
) -> NetsecfirewallSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NetsecfirewallSeries::add(
  self : NetsecfirewallSeries,
  other : NetsecfirewallSeries,
) -> NetsecfirewallSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetsecfirewallSeries::sub(
  self : NetsecfirewallSeries,
  other : NetsecfirewallSeries,
) -> NetsecfirewallSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetsecfirewallSeries::normalize(
  self : NetsecfirewallSeries,
) -> NetsecfirewallSeries {
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
pub fn NetsecfirewallSeries::cumsum(
  self : NetsecfirewallSeries,
) -> NetsecfirewallSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NetsecfirewallSeries::to_string(self : NetsecfirewallSeries) -> String {
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
pub(all) struct NetsecfirewallMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn net_sec_firewall_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NetsecfirewallMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn net_sec_firewall_matrix_identity(n : Int32) -> NetsecfirewallMatrix {
  let m = net_sec_firewall_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NetsecfirewallMatrix::get(
  self : NetsecfirewallMatrix,
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
pub fn NetsecfirewallMatrix::transpose(
  self : NetsecfirewallMatrix,
) -> NetsecfirewallMatrix {
  let result = net_sec_firewall_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NetsecfirewallMatrix::add(
  self : NetsecfirewallMatrix,
  other : NetsecfirewallMatrix,
) -> NetsecfirewallMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = net_sec_firewall_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NetsecfirewallMatrix::scale(
  self : NetsecfirewallMatrix,
  s : Double,
) -> NetsecfirewallMatrix {
  let result = net_sec_firewall_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NetsecfirewallMatrix::multiply(
  self : NetsecfirewallMatrix,
  other : NetsecfirewallMatrix,
) -> NetsecfirewallMatrix {
  if self.cols != other.rows {
    return net_sec_firewall_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = net_sec_firewall_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NetsecfirewallMatrix::trace(self : NetsecfirewallMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NetsecfirewallMatrix::det(self : NetsecfirewallMatrix) -> Double {
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
pub fn NetsecfirewallMatrix::norm(self : NetsecfirewallMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NetsecfirewallMatrix::to_string(self : NetsecfirewallMatrix) -> String {
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
pub(all) struct NetsecfirewallVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn net_sec_firewall_make_vector(
  comps : Array[Double],
) -> NetsecfirewallVector {
  { comps, dim: comps.length(), }
}

///|
pub fn net_sec_firewall_vector_zero(dim : Int32) -> NetsecfirewallVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NetsecfirewallVector::add(
  self : NetsecfirewallVector,
  other : NetsecfirewallVector,
) -> NetsecfirewallVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetsecfirewallVector::sub(
  self : NetsecfirewallVector,
  other : NetsecfirewallVector,
) -> NetsecfirewallVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetsecfirewallVector::scale(
  self : NetsecfirewallVector,
  s : Double,
) -> NetsecfirewallVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NetsecfirewallVector::dot(
  self : NetsecfirewallVector,
  other : NetsecfirewallVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NetsecfirewallVector::norm(self : NetsecfirewallVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NetsecfirewallVector::normalize(
  self : NetsecfirewallVector,
) -> NetsecfirewallVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetsecfirewallVector::dist(
  self : NetsecfirewallVector,
  other : NetsecfirewallVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NetsecfirewallVector::to_string(self : NetsecfirewallVector) -> String {
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
pub(all) struct NetsecfirewallFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_frame_make(size : Int32) -> NetsecfirewallFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallFrame::len(self : NetsecfirewallFrame) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallFrame::get(
  self : NetsecfirewallFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallFrame::set(
  self : NetsecfirewallFrame,
  i : Int32,
  v : Double,
) -> NetsecfirewallFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallFrame::sum(self : NetsecfirewallFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallFrame::mean(self : NetsecfirewallFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallFrame::scale(
  self : NetsecfirewallFrame,
  f : Double,
) -> NetsecfirewallFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallFrame::add(
  self : NetsecfirewallFrame,
  other : NetsecfirewallFrame,
) -> NetsecfirewallFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallFrame::copy(
  self : NetsecfirewallFrame,
) -> NetsecfirewallFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallFrame::fill(
  self : NetsecfirewallFrame,
  v : Double,
) -> NetsecfirewallFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallFrame::min(self : NetsecfirewallFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallFrame::max(self : NetsecfirewallFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallFrame::to_string(self : NetsecfirewallFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_table_make(size : Int32) -> NetsecfirewallTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallTable::len(self : NetsecfirewallTable) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallTable::get(
  self : NetsecfirewallTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallTable::set(
  self : NetsecfirewallTable,
  i : Int32,
  v : Double,
) -> NetsecfirewallTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallTable::sum(self : NetsecfirewallTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallTable::mean(self : NetsecfirewallTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallTable::scale(
  self : NetsecfirewallTable,
  f : Double,
) -> NetsecfirewallTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallTable::add(
  self : NetsecfirewallTable,
  other : NetsecfirewallTable,
) -> NetsecfirewallTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallTable::copy(
  self : NetsecfirewallTable,
) -> NetsecfirewallTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallTable::fill(
  self : NetsecfirewallTable,
  v : Double,
) -> NetsecfirewallTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallTable::min(self : NetsecfirewallTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallTable::max(self : NetsecfirewallTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallTable::to_string(self : NetsecfirewallTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_graphn_make(size : Int32) -> NetsecfirewallGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallGraphN::len(self : NetsecfirewallGraphN) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallGraphN::get(
  self : NetsecfirewallGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallGraphN::set(
  self : NetsecfirewallGraphN,
  i : Int32,
  v : Double,
) -> NetsecfirewallGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallGraphN::sum(self : NetsecfirewallGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallGraphN::mean(self : NetsecfirewallGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallGraphN::scale(
  self : NetsecfirewallGraphN,
  f : Double,
) -> NetsecfirewallGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallGraphN::add(
  self : NetsecfirewallGraphN,
  other : NetsecfirewallGraphN,
) -> NetsecfirewallGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallGraphN::copy(
  self : NetsecfirewallGraphN,
) -> NetsecfirewallGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallGraphN::fill(
  self : NetsecfirewallGraphN,
  v : Double,
) -> NetsecfirewallGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallGraphN::min(self : NetsecfirewallGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallGraphN::max(self : NetsecfirewallGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallGraphN::to_string(self : NetsecfirewallGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_node_make(size : Int32) -> NetsecfirewallNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallNode::len(self : NetsecfirewallNode) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallNode::get(self : NetsecfirewallNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallNode::set(
  self : NetsecfirewallNode,
  i : Int32,
  v : Double,
) -> NetsecfirewallNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallNode::sum(self : NetsecfirewallNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallNode::mean(self : NetsecfirewallNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallNode::scale(
  self : NetsecfirewallNode,
  f : Double,
) -> NetsecfirewallNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallNode::add(
  self : NetsecfirewallNode,
  other : NetsecfirewallNode,
) -> NetsecfirewallNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallNode::copy(
  self : NetsecfirewallNode,
) -> NetsecfirewallNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallNode::fill(
  self : NetsecfirewallNode,
  v : Double,
) -> NetsecfirewallNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallNode::min(self : NetsecfirewallNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallNode::max(self : NetsecfirewallNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallNode::to_string(self : NetsecfirewallNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_edge_make(size : Int32) -> NetsecfirewallEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallEdge::len(self : NetsecfirewallEdge) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallEdge::get(self : NetsecfirewallEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallEdge::set(
  self : NetsecfirewallEdge,
  i : Int32,
  v : Double,
) -> NetsecfirewallEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallEdge::sum(self : NetsecfirewallEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallEdge::mean(self : NetsecfirewallEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallEdge::scale(
  self : NetsecfirewallEdge,
  f : Double,
) -> NetsecfirewallEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallEdge::add(
  self : NetsecfirewallEdge,
  other : NetsecfirewallEdge,
) -> NetsecfirewallEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallEdge::copy(
  self : NetsecfirewallEdge,
) -> NetsecfirewallEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallEdge::fill(
  self : NetsecfirewallEdge,
  v : Double,
) -> NetsecfirewallEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallEdge::min(self : NetsecfirewallEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallEdge::max(self : NetsecfirewallEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallEdge::to_string(self : NetsecfirewallEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_path_make(size : Int32) -> NetsecfirewallPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallPath::len(self : NetsecfirewallPath) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallPath::get(self : NetsecfirewallPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallPath::set(
  self : NetsecfirewallPath,
  i : Int32,
  v : Double,
) -> NetsecfirewallPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallPath::sum(self : NetsecfirewallPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallPath::mean(self : NetsecfirewallPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallPath::scale(
  self : NetsecfirewallPath,
  f : Double,
) -> NetsecfirewallPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallPath::add(
  self : NetsecfirewallPath,
  other : NetsecfirewallPath,
) -> NetsecfirewallPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallPath::copy(
  self : NetsecfirewallPath,
) -> NetsecfirewallPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallPath::fill(
  self : NetsecfirewallPath,
  v : Double,
) -> NetsecfirewallPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallPath::min(self : NetsecfirewallPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallPath::max(self : NetsecfirewallPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallPath::to_string(self : NetsecfirewallPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_cluster_make(size : Int32) -> NetsecfirewallCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallCluster::len(self : NetsecfirewallCluster) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallCluster::get(
  self : NetsecfirewallCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallCluster::set(
  self : NetsecfirewallCluster,
  i : Int32,
  v : Double,
) -> NetsecfirewallCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallCluster::sum(self : NetsecfirewallCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallCluster::mean(self : NetsecfirewallCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallCluster::scale(
  self : NetsecfirewallCluster,
  f : Double,
) -> NetsecfirewallCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallCluster::add(
  self : NetsecfirewallCluster,
  other : NetsecfirewallCluster,
) -> NetsecfirewallCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallCluster::copy(
  self : NetsecfirewallCluster,
) -> NetsecfirewallCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallCluster::fill(
  self : NetsecfirewallCluster,
  v : Double,
) -> NetsecfirewallCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallCluster::min(self : NetsecfirewallCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallCluster::max(self : NetsecfirewallCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallCluster::to_string(self : NetsecfirewallCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_model_make(size : Int32) -> NetsecfirewallModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallModel::len(self : NetsecfirewallModel) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallModel::get(
  self : NetsecfirewallModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallModel::set(
  self : NetsecfirewallModel,
  i : Int32,
  v : Double,
) -> NetsecfirewallModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallModel::sum(self : NetsecfirewallModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallModel::mean(self : NetsecfirewallModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallModel::scale(
  self : NetsecfirewallModel,
  f : Double,
) -> NetsecfirewallModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallModel::add(
  self : NetsecfirewallModel,
  other : NetsecfirewallModel,
) -> NetsecfirewallModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallModel::copy(
  self : NetsecfirewallModel,
) -> NetsecfirewallModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallModel::fill(
  self : NetsecfirewallModel,
  v : Double,
) -> NetsecfirewallModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallModel::min(self : NetsecfirewallModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallModel::max(self : NetsecfirewallModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallModel::to_string(self : NetsecfirewallModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_layer_make(size : Int32) -> NetsecfirewallLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallLayer::len(self : NetsecfirewallLayer) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallLayer::get(
  self : NetsecfirewallLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallLayer::set(
  self : NetsecfirewallLayer,
  i : Int32,
  v : Double,
) -> NetsecfirewallLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallLayer::sum(self : NetsecfirewallLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallLayer::mean(self : NetsecfirewallLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallLayer::scale(
  self : NetsecfirewallLayer,
  f : Double,
) -> NetsecfirewallLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallLayer::add(
  self : NetsecfirewallLayer,
  other : NetsecfirewallLayer,
) -> NetsecfirewallLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallLayer::copy(
  self : NetsecfirewallLayer,
) -> NetsecfirewallLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallLayer::fill(
  self : NetsecfirewallLayer,
  v : Double,
) -> NetsecfirewallLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallLayer::min(self : NetsecfirewallLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallLayer::max(self : NetsecfirewallLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallLayer::to_string(self : NetsecfirewallLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_buffer_make(size : Int32) -> NetsecfirewallBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallBuffer::len(self : NetsecfirewallBuffer) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallBuffer::get(
  self : NetsecfirewallBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallBuffer::set(
  self : NetsecfirewallBuffer,
  i : Int32,
  v : Double,
) -> NetsecfirewallBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallBuffer::sum(self : NetsecfirewallBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallBuffer::mean(self : NetsecfirewallBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallBuffer::scale(
  self : NetsecfirewallBuffer,
  f : Double,
) -> NetsecfirewallBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallBuffer::add(
  self : NetsecfirewallBuffer,
  other : NetsecfirewallBuffer,
) -> NetsecfirewallBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallBuffer::copy(
  self : NetsecfirewallBuffer,
) -> NetsecfirewallBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallBuffer::fill(
  self : NetsecfirewallBuffer,
  v : Double,
) -> NetsecfirewallBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallBuffer::min(self : NetsecfirewallBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallBuffer::max(self : NetsecfirewallBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallBuffer::to_string(self : NetsecfirewallBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_cursor_make(size : Int32) -> NetsecfirewallCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallCursor::len(self : NetsecfirewallCursor) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallCursor::get(
  self : NetsecfirewallCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallCursor::set(
  self : NetsecfirewallCursor,
  i : Int32,
  v : Double,
) -> NetsecfirewallCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallCursor::sum(self : NetsecfirewallCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallCursor::mean(self : NetsecfirewallCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallCursor::scale(
  self : NetsecfirewallCursor,
  f : Double,
) -> NetsecfirewallCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallCursor::add(
  self : NetsecfirewallCursor,
  other : NetsecfirewallCursor,
) -> NetsecfirewallCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallCursor::copy(
  self : NetsecfirewallCursor,
) -> NetsecfirewallCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallCursor::fill(
  self : NetsecfirewallCursor,
  v : Double,
) -> NetsecfirewallCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallCursor::min(self : NetsecfirewallCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallCursor::max(self : NetsecfirewallCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallCursor::to_string(self : NetsecfirewallCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_view_make(size : Int32) -> NetsecfirewallView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallView::len(self : NetsecfirewallView) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallView::get(self : NetsecfirewallView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallView::set(
  self : NetsecfirewallView,
  i : Int32,
  v : Double,
) -> NetsecfirewallView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallView::sum(self : NetsecfirewallView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallView::mean(self : NetsecfirewallView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallView::scale(
  self : NetsecfirewallView,
  f : Double,
) -> NetsecfirewallView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallView::add(
  self : NetsecfirewallView,
  other : NetsecfirewallView,
) -> NetsecfirewallView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallView::copy(
  self : NetsecfirewallView,
) -> NetsecfirewallView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallView::fill(
  self : NetsecfirewallView,
  v : Double,
) -> NetsecfirewallView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallView::min(self : NetsecfirewallView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallView::max(self : NetsecfirewallView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallView::to_string(self : NetsecfirewallView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_range_make(size : Int32) -> NetsecfirewallRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallRange::len(self : NetsecfirewallRange) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallRange::get(
  self : NetsecfirewallRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallRange::set(
  self : NetsecfirewallRange,
  i : Int32,
  v : Double,
) -> NetsecfirewallRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallRange::sum(self : NetsecfirewallRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallRange::mean(self : NetsecfirewallRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallRange::scale(
  self : NetsecfirewallRange,
  f : Double,
) -> NetsecfirewallRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallRange::add(
  self : NetsecfirewallRange,
  other : NetsecfirewallRange,
) -> NetsecfirewallRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallRange::copy(
  self : NetsecfirewallRange,
) -> NetsecfirewallRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallRange::fill(
  self : NetsecfirewallRange,
  v : Double,
) -> NetsecfirewallRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallRange::min(self : NetsecfirewallRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallRange::max(self : NetsecfirewallRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallRange::to_string(self : NetsecfirewallRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecfirewallSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_firewall_slice_make(size : Int32) -> NetsecfirewallSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecfirewallSlice::len(self : NetsecfirewallSlice) -> Int32 {
  self.size
}

///|
pub fn NetsecfirewallSlice::get(
  self : NetsecfirewallSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecfirewallSlice::set(
  self : NetsecfirewallSlice,
  i : Int32,
  v : Double,
) -> NetsecfirewallSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallSlice::sum(self : NetsecfirewallSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecfirewallSlice::mean(self : NetsecfirewallSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecfirewallSlice::scale(
  self : NetsecfirewallSlice,
  f : Double,
) -> NetsecfirewallSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallSlice::add(
  self : NetsecfirewallSlice,
  other : NetsecfirewallSlice,
) -> NetsecfirewallSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecfirewallSlice::copy(
  self : NetsecfirewallSlice,
) -> NetsecfirewallSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallSlice::fill(
  self : NetsecfirewallSlice,
  v : Double,
) -> NetsecfirewallSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecfirewallSlice::min(self : NetsecfirewallSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecfirewallSlice::max(self : NetsecfirewallSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecfirewallSlice::to_string(self : NetsecfirewallSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
