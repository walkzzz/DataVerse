///|
///===
/// extcore/net_flow_congestion
pub(all) struct NetflowcongestionPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn net_flow_congestion_make_point(
  x : Double,
  y : Double,
) -> NetflowcongestionPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn net_flow_congestion_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NetflowcongestionPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NetflowcongestionPoint::x(self : NetflowcongestionPoint) -> Double {
  self.x
}

///|
pub fn NetflowcongestionPoint::y(self : NetflowcongestionPoint) -> Double {
  self.y
}

///|
pub fn NetflowcongestionPoint::z(self : NetflowcongestionPoint) -> Double {
  self.z
}

///|
pub fn NetflowcongestionPoint::label(self : NetflowcongestionPoint) -> Int32 {
  self.label
}

///|
pub fn NetflowcongestionPoint::dist(
  self : NetflowcongestionPoint,
  other : NetflowcongestionPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NetflowcongestionPoint::add(
  self : NetflowcongestionPoint,
  other : NetflowcongestionPoint,
) -> NetflowcongestionPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NetflowcongestionPoint::sub(
  self : NetflowcongestionPoint,
  other : NetflowcongestionPoint,
) -> NetflowcongestionPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NetflowcongestionPoint::scale(
  self : NetflowcongestionPoint,
  s : Double,
) -> NetflowcongestionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NetflowcongestionPoint::dot(
  self : NetflowcongestionPoint,
  other : NetflowcongestionPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NetflowcongestionPoint::cross(
  self : NetflowcongestionPoint,
  other : NetflowcongestionPoint,
) -> NetflowcongestionPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NetflowcongestionPoint::norm(self : NetflowcongestionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NetflowcongestionPoint::normalize(
  self : NetflowcongestionPoint,
) -> NetflowcongestionPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetflowcongestionPoint::negate(
  self : NetflowcongestionPoint,
) -> NetflowcongestionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NetflowcongestionPoint::mid(
  self : NetflowcongestionPoint,
  other : NetflowcongestionPoint,
) -> NetflowcongestionPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NetflowcongestionPoint::lerp(
  self : NetflowcongestionPoint,
  other : NetflowcongestionPoint,
  t : Double,
) -> NetflowcongestionPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NetflowcongestionPoint::to_string(
  self : NetflowcongestionPoint,
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
pub(all) struct NetflowcongestionSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn net_flow_congestion_make_series(
  vals : Array[Double],
  name : String,
) -> NetflowcongestionSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NetflowcongestionSeries::len(self : NetflowcongestionSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NetflowcongestionSeries::sum(self : NetflowcongestionSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NetflowcongestionSeries::mean(self : NetflowcongestionSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NetflowcongestionSeries::min(self : NetflowcongestionSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NetflowcongestionSeries::max(self : NetflowcongestionSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NetflowcongestionSeries::range(self : NetflowcongestionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NetflowcongestionSeries::variance(
  self : NetflowcongestionSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NetflowcongestionSeries::std(self : NetflowcongestionSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NetflowcongestionSeries::median(
  self : NetflowcongestionSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NetflowcongestionSeries::scale(
  self : NetflowcongestionSeries,
  f : Double,
) -> NetflowcongestionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NetflowcongestionSeries::add(
  self : NetflowcongestionSeries,
  other : NetflowcongestionSeries,
) -> NetflowcongestionSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetflowcongestionSeries::sub(
  self : NetflowcongestionSeries,
  other : NetflowcongestionSeries,
) -> NetflowcongestionSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetflowcongestionSeries::normalize(
  self : NetflowcongestionSeries,
) -> NetflowcongestionSeries {
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
pub fn NetflowcongestionSeries::cumsum(
  self : NetflowcongestionSeries,
) -> NetflowcongestionSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NetflowcongestionSeries::to_string(
  self : NetflowcongestionSeries,
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
pub(all) struct NetflowcongestionMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn net_flow_congestion_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NetflowcongestionMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn net_flow_congestion_matrix_identity(
  n : Int32,
) -> NetflowcongestionMatrix {
  let m = net_flow_congestion_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NetflowcongestionMatrix::get(
  self : NetflowcongestionMatrix,
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
pub fn NetflowcongestionMatrix::transpose(
  self : NetflowcongestionMatrix,
) -> NetflowcongestionMatrix {
  let result = net_flow_congestion_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NetflowcongestionMatrix::add(
  self : NetflowcongestionMatrix,
  other : NetflowcongestionMatrix,
) -> NetflowcongestionMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = net_flow_congestion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NetflowcongestionMatrix::scale(
  self : NetflowcongestionMatrix,
  s : Double,
) -> NetflowcongestionMatrix {
  let result = net_flow_congestion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NetflowcongestionMatrix::multiply(
  self : NetflowcongestionMatrix,
  other : NetflowcongestionMatrix,
) -> NetflowcongestionMatrix {
  if self.cols != other.rows {
    return net_flow_congestion_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = net_flow_congestion_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NetflowcongestionMatrix::trace(self : NetflowcongestionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NetflowcongestionMatrix::det(self : NetflowcongestionMatrix) -> Double {
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
pub fn NetflowcongestionMatrix::norm(self : NetflowcongestionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NetflowcongestionMatrix::to_string(
  self : NetflowcongestionMatrix,
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
pub(all) struct NetflowcongestionVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn net_flow_congestion_make_vector(
  comps : Array[Double],
) -> NetflowcongestionVector {
  { comps, dim: comps.length(), }
}

///|
pub fn net_flow_congestion_vector_zero(dim : Int32) -> NetflowcongestionVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NetflowcongestionVector::add(
  self : NetflowcongestionVector,
  other : NetflowcongestionVector,
) -> NetflowcongestionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetflowcongestionVector::sub(
  self : NetflowcongestionVector,
  other : NetflowcongestionVector,
) -> NetflowcongestionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetflowcongestionVector::scale(
  self : NetflowcongestionVector,
  s : Double,
) -> NetflowcongestionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NetflowcongestionVector::dot(
  self : NetflowcongestionVector,
  other : NetflowcongestionVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NetflowcongestionVector::norm(self : NetflowcongestionVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NetflowcongestionVector::normalize(
  self : NetflowcongestionVector,
) -> NetflowcongestionVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetflowcongestionVector::dist(
  self : NetflowcongestionVector,
  other : NetflowcongestionVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NetflowcongestionVector::to_string(
  self : NetflowcongestionVector,
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
pub(all) struct NetflowcongestionFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_frame_make(size : Int32) -> NetflowcongestionFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionFrame::len(self : NetflowcongestionFrame) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionFrame::get(
  self : NetflowcongestionFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionFrame::set(
  self : NetflowcongestionFrame,
  i : Int32,
  v : Double,
) -> NetflowcongestionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionFrame::sum(self : NetflowcongestionFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionFrame::mean(self : NetflowcongestionFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionFrame::scale(
  self : NetflowcongestionFrame,
  f : Double,
) -> NetflowcongestionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionFrame::add(
  self : NetflowcongestionFrame,
  other : NetflowcongestionFrame,
) -> NetflowcongestionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionFrame::copy(
  self : NetflowcongestionFrame,
) -> NetflowcongestionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionFrame::fill(
  self : NetflowcongestionFrame,
  v : Double,
) -> NetflowcongestionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionFrame::min(self : NetflowcongestionFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionFrame::max(self : NetflowcongestionFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionFrame::to_string(
  self : NetflowcongestionFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_table_make(size : Int32) -> NetflowcongestionTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionTable::len(self : NetflowcongestionTable) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionTable::get(
  self : NetflowcongestionTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionTable::set(
  self : NetflowcongestionTable,
  i : Int32,
  v : Double,
) -> NetflowcongestionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionTable::sum(self : NetflowcongestionTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionTable::mean(self : NetflowcongestionTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionTable::scale(
  self : NetflowcongestionTable,
  f : Double,
) -> NetflowcongestionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionTable::add(
  self : NetflowcongestionTable,
  other : NetflowcongestionTable,
) -> NetflowcongestionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionTable::copy(
  self : NetflowcongestionTable,
) -> NetflowcongestionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionTable::fill(
  self : NetflowcongestionTable,
  v : Double,
) -> NetflowcongestionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionTable::min(self : NetflowcongestionTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionTable::max(self : NetflowcongestionTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionTable::to_string(
  self : NetflowcongestionTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_graphn_make(size : Int32) -> NetflowcongestionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionGraphN::len(self : NetflowcongestionGraphN) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionGraphN::get(
  self : NetflowcongestionGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionGraphN::set(
  self : NetflowcongestionGraphN,
  i : Int32,
  v : Double,
) -> NetflowcongestionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionGraphN::sum(self : NetflowcongestionGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionGraphN::mean(self : NetflowcongestionGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionGraphN::scale(
  self : NetflowcongestionGraphN,
  f : Double,
) -> NetflowcongestionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionGraphN::add(
  self : NetflowcongestionGraphN,
  other : NetflowcongestionGraphN,
) -> NetflowcongestionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionGraphN::copy(
  self : NetflowcongestionGraphN,
) -> NetflowcongestionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionGraphN::fill(
  self : NetflowcongestionGraphN,
  v : Double,
) -> NetflowcongestionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionGraphN::min(self : NetflowcongestionGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionGraphN::max(self : NetflowcongestionGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionGraphN::to_string(
  self : NetflowcongestionGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_node_make(size : Int32) -> NetflowcongestionNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionNode::len(self : NetflowcongestionNode) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionNode::get(
  self : NetflowcongestionNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionNode::set(
  self : NetflowcongestionNode,
  i : Int32,
  v : Double,
) -> NetflowcongestionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionNode::sum(self : NetflowcongestionNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionNode::mean(self : NetflowcongestionNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionNode::scale(
  self : NetflowcongestionNode,
  f : Double,
) -> NetflowcongestionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionNode::add(
  self : NetflowcongestionNode,
  other : NetflowcongestionNode,
) -> NetflowcongestionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionNode::copy(
  self : NetflowcongestionNode,
) -> NetflowcongestionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionNode::fill(
  self : NetflowcongestionNode,
  v : Double,
) -> NetflowcongestionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionNode::min(self : NetflowcongestionNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionNode::max(self : NetflowcongestionNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionNode::to_string(self : NetflowcongestionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_edge_make(size : Int32) -> NetflowcongestionEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionEdge::len(self : NetflowcongestionEdge) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionEdge::get(
  self : NetflowcongestionEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionEdge::set(
  self : NetflowcongestionEdge,
  i : Int32,
  v : Double,
) -> NetflowcongestionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionEdge::sum(self : NetflowcongestionEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionEdge::mean(self : NetflowcongestionEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionEdge::scale(
  self : NetflowcongestionEdge,
  f : Double,
) -> NetflowcongestionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionEdge::add(
  self : NetflowcongestionEdge,
  other : NetflowcongestionEdge,
) -> NetflowcongestionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionEdge::copy(
  self : NetflowcongestionEdge,
) -> NetflowcongestionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionEdge::fill(
  self : NetflowcongestionEdge,
  v : Double,
) -> NetflowcongestionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionEdge::min(self : NetflowcongestionEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionEdge::max(self : NetflowcongestionEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionEdge::to_string(self : NetflowcongestionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_path_make(size : Int32) -> NetflowcongestionPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionPath::len(self : NetflowcongestionPath) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionPath::get(
  self : NetflowcongestionPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionPath::set(
  self : NetflowcongestionPath,
  i : Int32,
  v : Double,
) -> NetflowcongestionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionPath::sum(self : NetflowcongestionPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionPath::mean(self : NetflowcongestionPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionPath::scale(
  self : NetflowcongestionPath,
  f : Double,
) -> NetflowcongestionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionPath::add(
  self : NetflowcongestionPath,
  other : NetflowcongestionPath,
) -> NetflowcongestionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionPath::copy(
  self : NetflowcongestionPath,
) -> NetflowcongestionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionPath::fill(
  self : NetflowcongestionPath,
  v : Double,
) -> NetflowcongestionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionPath::min(self : NetflowcongestionPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionPath::max(self : NetflowcongestionPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionPath::to_string(self : NetflowcongestionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_cluster_make(
  size : Int32,
) -> NetflowcongestionCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionCluster::len(self : NetflowcongestionCluster) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionCluster::get(
  self : NetflowcongestionCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionCluster::set(
  self : NetflowcongestionCluster,
  i : Int32,
  v : Double,
) -> NetflowcongestionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionCluster::sum(self : NetflowcongestionCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionCluster::mean(
  self : NetflowcongestionCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionCluster::scale(
  self : NetflowcongestionCluster,
  f : Double,
) -> NetflowcongestionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionCluster::add(
  self : NetflowcongestionCluster,
  other : NetflowcongestionCluster,
) -> NetflowcongestionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionCluster::copy(
  self : NetflowcongestionCluster,
) -> NetflowcongestionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionCluster::fill(
  self : NetflowcongestionCluster,
  v : Double,
) -> NetflowcongestionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionCluster::min(self : NetflowcongestionCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionCluster::max(self : NetflowcongestionCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionCluster::to_string(
  self : NetflowcongestionCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_model_make(size : Int32) -> NetflowcongestionModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionModel::len(self : NetflowcongestionModel) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionModel::get(
  self : NetflowcongestionModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionModel::set(
  self : NetflowcongestionModel,
  i : Int32,
  v : Double,
) -> NetflowcongestionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionModel::sum(self : NetflowcongestionModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionModel::mean(self : NetflowcongestionModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionModel::scale(
  self : NetflowcongestionModel,
  f : Double,
) -> NetflowcongestionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionModel::add(
  self : NetflowcongestionModel,
  other : NetflowcongestionModel,
) -> NetflowcongestionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionModel::copy(
  self : NetflowcongestionModel,
) -> NetflowcongestionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionModel::fill(
  self : NetflowcongestionModel,
  v : Double,
) -> NetflowcongestionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionModel::min(self : NetflowcongestionModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionModel::max(self : NetflowcongestionModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionModel::to_string(
  self : NetflowcongestionModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_layer_make(size : Int32) -> NetflowcongestionLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionLayer::len(self : NetflowcongestionLayer) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionLayer::get(
  self : NetflowcongestionLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionLayer::set(
  self : NetflowcongestionLayer,
  i : Int32,
  v : Double,
) -> NetflowcongestionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionLayer::sum(self : NetflowcongestionLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionLayer::mean(self : NetflowcongestionLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionLayer::scale(
  self : NetflowcongestionLayer,
  f : Double,
) -> NetflowcongestionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionLayer::add(
  self : NetflowcongestionLayer,
  other : NetflowcongestionLayer,
) -> NetflowcongestionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionLayer::copy(
  self : NetflowcongestionLayer,
) -> NetflowcongestionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionLayer::fill(
  self : NetflowcongestionLayer,
  v : Double,
) -> NetflowcongestionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionLayer::min(self : NetflowcongestionLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionLayer::max(self : NetflowcongestionLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionLayer::to_string(
  self : NetflowcongestionLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_buffer_make(size : Int32) -> NetflowcongestionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionBuffer::len(self : NetflowcongestionBuffer) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionBuffer::get(
  self : NetflowcongestionBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionBuffer::set(
  self : NetflowcongestionBuffer,
  i : Int32,
  v : Double,
) -> NetflowcongestionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionBuffer::sum(self : NetflowcongestionBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionBuffer::mean(self : NetflowcongestionBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionBuffer::scale(
  self : NetflowcongestionBuffer,
  f : Double,
) -> NetflowcongestionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionBuffer::add(
  self : NetflowcongestionBuffer,
  other : NetflowcongestionBuffer,
) -> NetflowcongestionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionBuffer::copy(
  self : NetflowcongestionBuffer,
) -> NetflowcongestionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionBuffer::fill(
  self : NetflowcongestionBuffer,
  v : Double,
) -> NetflowcongestionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionBuffer::min(self : NetflowcongestionBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionBuffer::max(self : NetflowcongestionBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionBuffer::to_string(
  self : NetflowcongestionBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_cursor_make(size : Int32) -> NetflowcongestionCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionCursor::len(self : NetflowcongestionCursor) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionCursor::get(
  self : NetflowcongestionCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionCursor::set(
  self : NetflowcongestionCursor,
  i : Int32,
  v : Double,
) -> NetflowcongestionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionCursor::sum(self : NetflowcongestionCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionCursor::mean(self : NetflowcongestionCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionCursor::scale(
  self : NetflowcongestionCursor,
  f : Double,
) -> NetflowcongestionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionCursor::add(
  self : NetflowcongestionCursor,
  other : NetflowcongestionCursor,
) -> NetflowcongestionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionCursor::copy(
  self : NetflowcongestionCursor,
) -> NetflowcongestionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionCursor::fill(
  self : NetflowcongestionCursor,
  v : Double,
) -> NetflowcongestionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionCursor::min(self : NetflowcongestionCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionCursor::max(self : NetflowcongestionCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionCursor::to_string(
  self : NetflowcongestionCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_view_make(size : Int32) -> NetflowcongestionView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionView::len(self : NetflowcongestionView) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionView::get(
  self : NetflowcongestionView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionView::set(
  self : NetflowcongestionView,
  i : Int32,
  v : Double,
) -> NetflowcongestionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionView::sum(self : NetflowcongestionView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionView::mean(self : NetflowcongestionView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionView::scale(
  self : NetflowcongestionView,
  f : Double,
) -> NetflowcongestionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionView::add(
  self : NetflowcongestionView,
  other : NetflowcongestionView,
) -> NetflowcongestionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionView::copy(
  self : NetflowcongestionView,
) -> NetflowcongestionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionView::fill(
  self : NetflowcongestionView,
  v : Double,
) -> NetflowcongestionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionView::min(self : NetflowcongestionView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionView::max(self : NetflowcongestionView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionView::to_string(self : NetflowcongestionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_range_make(size : Int32) -> NetflowcongestionRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionRange::len(self : NetflowcongestionRange) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionRange::get(
  self : NetflowcongestionRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionRange::set(
  self : NetflowcongestionRange,
  i : Int32,
  v : Double,
) -> NetflowcongestionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionRange::sum(self : NetflowcongestionRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionRange::mean(self : NetflowcongestionRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionRange::scale(
  self : NetflowcongestionRange,
  f : Double,
) -> NetflowcongestionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionRange::add(
  self : NetflowcongestionRange,
  other : NetflowcongestionRange,
) -> NetflowcongestionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionRange::copy(
  self : NetflowcongestionRange,
) -> NetflowcongestionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionRange::fill(
  self : NetflowcongestionRange,
  v : Double,
) -> NetflowcongestionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionRange::min(self : NetflowcongestionRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionRange::max(self : NetflowcongestionRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionRange::to_string(
  self : NetflowcongestionRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowcongestionSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_congestion_slice_make(size : Int32) -> NetflowcongestionSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowcongestionSlice::len(self : NetflowcongestionSlice) -> Int32 {
  self.size
}

///|
pub fn NetflowcongestionSlice::get(
  self : NetflowcongestionSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowcongestionSlice::set(
  self : NetflowcongestionSlice,
  i : Int32,
  v : Double,
) -> NetflowcongestionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionSlice::sum(self : NetflowcongestionSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowcongestionSlice::mean(self : NetflowcongestionSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowcongestionSlice::scale(
  self : NetflowcongestionSlice,
  f : Double,
) -> NetflowcongestionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionSlice::add(
  self : NetflowcongestionSlice,
  other : NetflowcongestionSlice,
) -> NetflowcongestionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowcongestionSlice::copy(
  self : NetflowcongestionSlice,
) -> NetflowcongestionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionSlice::fill(
  self : NetflowcongestionSlice,
  v : Double,
) -> NetflowcongestionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowcongestionSlice::min(self : NetflowcongestionSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowcongestionSlice::max(self : NetflowcongestionSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowcongestionSlice::to_string(
  self : NetflowcongestionSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
