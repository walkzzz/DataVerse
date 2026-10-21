///|
///===
/// extcore/timeseries_holt
pub(all) struct TimeseriesholtPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn timeseries_holt_make_point(
  x : Double,
  y : Double,
) -> TimeseriesholtPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn timeseries_holt_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> TimeseriesholtPoint {
  { x, y, z, label: 0, }
}

///|
pub fn TimeseriesholtPoint::x(self : TimeseriesholtPoint) -> Double {
  self.x
}

///|
pub fn TimeseriesholtPoint::y(self : TimeseriesholtPoint) -> Double {
  self.y
}

///|
pub fn TimeseriesholtPoint::z(self : TimeseriesholtPoint) -> Double {
  self.z
}

///|
pub fn TimeseriesholtPoint::label(self : TimeseriesholtPoint) -> Int32 {
  self.label
}

///|
pub fn TimeseriesholtPoint::dist(
  self : TimeseriesholtPoint,
  other : TimeseriesholtPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn TimeseriesholtPoint::add(
  self : TimeseriesholtPoint,
  other : TimeseriesholtPoint,
) -> TimeseriesholtPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn TimeseriesholtPoint::sub(
  self : TimeseriesholtPoint,
  other : TimeseriesholtPoint,
) -> TimeseriesholtPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn TimeseriesholtPoint::scale(
  self : TimeseriesholtPoint,
  s : Double,
) -> TimeseriesholtPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn TimeseriesholtPoint::dot(
  self : TimeseriesholtPoint,
  other : TimeseriesholtPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn TimeseriesholtPoint::cross(
  self : TimeseriesholtPoint,
  other : TimeseriesholtPoint,
) -> TimeseriesholtPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn TimeseriesholtPoint::norm(self : TimeseriesholtPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn TimeseriesholtPoint::normalize(
  self : TimeseriesholtPoint,
) -> TimeseriesholtPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn TimeseriesholtPoint::negate(
  self : TimeseriesholtPoint,
) -> TimeseriesholtPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn TimeseriesholtPoint::mid(
  self : TimeseriesholtPoint,
  other : TimeseriesholtPoint,
) -> TimeseriesholtPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn TimeseriesholtPoint::lerp(
  self : TimeseriesholtPoint,
  other : TimeseriesholtPoint,
  t : Double,
) -> TimeseriesholtPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn TimeseriesholtPoint::to_string(self : TimeseriesholtPoint) -> String {
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
pub(all) struct TimeseriesholtSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn timeseries_holt_make_series(
  vals : Array[Double],
  name : String,
) -> TimeseriesholtSeries {
  { vals, name, meta: 0, }
}

///|
pub fn TimeseriesholtSeries::len(self : TimeseriesholtSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn TimeseriesholtSeries::sum(self : TimeseriesholtSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn TimeseriesholtSeries::mean(self : TimeseriesholtSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn TimeseriesholtSeries::min(self : TimeseriesholtSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn TimeseriesholtSeries::max(self : TimeseriesholtSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn TimeseriesholtSeries::range(self : TimeseriesholtSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn TimeseriesholtSeries::variance(self : TimeseriesholtSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn TimeseriesholtSeries::std(self : TimeseriesholtSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn TimeseriesholtSeries::median(self : TimeseriesholtSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn TimeseriesholtSeries::scale(
  self : TimeseriesholtSeries,
  f : Double,
) -> TimeseriesholtSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn TimeseriesholtSeries::add(
  self : TimeseriesholtSeries,
  other : TimeseriesholtSeries,
) -> TimeseriesholtSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn TimeseriesholtSeries::sub(
  self : TimeseriesholtSeries,
  other : TimeseriesholtSeries,
) -> TimeseriesholtSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn TimeseriesholtSeries::normalize(
  self : TimeseriesholtSeries,
) -> TimeseriesholtSeries {
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
pub fn TimeseriesholtSeries::cumsum(
  self : TimeseriesholtSeries,
) -> TimeseriesholtSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn TimeseriesholtSeries::to_string(self : TimeseriesholtSeries) -> String {
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
pub(all) struct TimeseriesholtMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn timeseries_holt_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> TimeseriesholtMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn timeseries_holt_matrix_identity(n : Int32) -> TimeseriesholtMatrix {
  let m = timeseries_holt_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn TimeseriesholtMatrix::get(
  self : TimeseriesholtMatrix,
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
pub fn TimeseriesholtMatrix::transpose(
  self : TimeseriesholtMatrix,
) -> TimeseriesholtMatrix {
  let result = timeseries_holt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn TimeseriesholtMatrix::add(
  self : TimeseriesholtMatrix,
  other : TimeseriesholtMatrix,
) -> TimeseriesholtMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = timeseries_holt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn TimeseriesholtMatrix::scale(
  self : TimeseriesholtMatrix,
  s : Double,
) -> TimeseriesholtMatrix {
  let result = timeseries_holt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn TimeseriesholtMatrix::multiply(
  self : TimeseriesholtMatrix,
  other : TimeseriesholtMatrix,
) -> TimeseriesholtMatrix {
  if self.cols != other.rows {
    return timeseries_holt_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = timeseries_holt_make_matrix(self.rows, other.cols, 0.0)
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
pub fn TimeseriesholtMatrix::trace(self : TimeseriesholtMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn TimeseriesholtMatrix::det(self : TimeseriesholtMatrix) -> Double {
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
pub fn TimeseriesholtMatrix::norm(self : TimeseriesholtMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn TimeseriesholtMatrix::to_string(self : TimeseriesholtMatrix) -> String {
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
pub(all) struct TimeseriesholtVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn timeseries_holt_make_vector(
  comps : Array[Double],
) -> TimeseriesholtVector {
  { comps, dim: comps.length(), }
}

///|
pub fn timeseries_holt_vector_zero(dim : Int32) -> TimeseriesholtVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn TimeseriesholtVector::add(
  self : TimeseriesholtVector,
  other : TimeseriesholtVector,
) -> TimeseriesholtVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn TimeseriesholtVector::sub(
  self : TimeseriesholtVector,
  other : TimeseriesholtVector,
) -> TimeseriesholtVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn TimeseriesholtVector::scale(
  self : TimeseriesholtVector,
  s : Double,
) -> TimeseriesholtVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn TimeseriesholtVector::dot(
  self : TimeseriesholtVector,
  other : TimeseriesholtVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn TimeseriesholtVector::norm(self : TimeseriesholtVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn TimeseriesholtVector::normalize(
  self : TimeseriesholtVector,
) -> TimeseriesholtVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn TimeseriesholtVector::dist(
  self : TimeseriesholtVector,
  other : TimeseriesholtVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn TimeseriesholtVector::to_string(self : TimeseriesholtVector) -> String {
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
pub(all) struct TimeseriesholtFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_frame_make(size : Int32) -> TimeseriesholtFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtFrame::len(self : TimeseriesholtFrame) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtFrame::get(
  self : TimeseriesholtFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtFrame::set(
  self : TimeseriesholtFrame,
  i : Int32,
  v : Double,
) -> TimeseriesholtFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtFrame::sum(self : TimeseriesholtFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtFrame::mean(self : TimeseriesholtFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtFrame::scale(
  self : TimeseriesholtFrame,
  f : Double,
) -> TimeseriesholtFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtFrame::add(
  self : TimeseriesholtFrame,
  other : TimeseriesholtFrame,
) -> TimeseriesholtFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtFrame::copy(
  self : TimeseriesholtFrame,
) -> TimeseriesholtFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtFrame::fill(
  self : TimeseriesholtFrame,
  v : Double,
) -> TimeseriesholtFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtFrame::min(self : TimeseriesholtFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtFrame::max(self : TimeseriesholtFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtFrame::to_string(self : TimeseriesholtFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_table_make(size : Int32) -> TimeseriesholtTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtTable::len(self : TimeseriesholtTable) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtTable::get(
  self : TimeseriesholtTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtTable::set(
  self : TimeseriesholtTable,
  i : Int32,
  v : Double,
) -> TimeseriesholtTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtTable::sum(self : TimeseriesholtTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtTable::mean(self : TimeseriesholtTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtTable::scale(
  self : TimeseriesholtTable,
  f : Double,
) -> TimeseriesholtTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtTable::add(
  self : TimeseriesholtTable,
  other : TimeseriesholtTable,
) -> TimeseriesholtTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtTable::copy(
  self : TimeseriesholtTable,
) -> TimeseriesholtTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtTable::fill(
  self : TimeseriesholtTable,
  v : Double,
) -> TimeseriesholtTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtTable::min(self : TimeseriesholtTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtTable::max(self : TimeseriesholtTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtTable::to_string(self : TimeseriesholtTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_graphn_make(size : Int32) -> TimeseriesholtGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtGraphN::len(self : TimeseriesholtGraphN) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtGraphN::get(
  self : TimeseriesholtGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtGraphN::set(
  self : TimeseriesholtGraphN,
  i : Int32,
  v : Double,
) -> TimeseriesholtGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtGraphN::sum(self : TimeseriesholtGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtGraphN::mean(self : TimeseriesholtGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtGraphN::scale(
  self : TimeseriesholtGraphN,
  f : Double,
) -> TimeseriesholtGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtGraphN::add(
  self : TimeseriesholtGraphN,
  other : TimeseriesholtGraphN,
) -> TimeseriesholtGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtGraphN::copy(
  self : TimeseriesholtGraphN,
) -> TimeseriesholtGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtGraphN::fill(
  self : TimeseriesholtGraphN,
  v : Double,
) -> TimeseriesholtGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtGraphN::min(self : TimeseriesholtGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtGraphN::max(self : TimeseriesholtGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtGraphN::to_string(self : TimeseriesholtGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_node_make(size : Int32) -> TimeseriesholtNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtNode::len(self : TimeseriesholtNode) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtNode::get(self : TimeseriesholtNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtNode::set(
  self : TimeseriesholtNode,
  i : Int32,
  v : Double,
) -> TimeseriesholtNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtNode::sum(self : TimeseriesholtNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtNode::mean(self : TimeseriesholtNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtNode::scale(
  self : TimeseriesholtNode,
  f : Double,
) -> TimeseriesholtNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtNode::add(
  self : TimeseriesholtNode,
  other : TimeseriesholtNode,
) -> TimeseriesholtNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtNode::copy(
  self : TimeseriesholtNode,
) -> TimeseriesholtNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtNode::fill(
  self : TimeseriesholtNode,
  v : Double,
) -> TimeseriesholtNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtNode::min(self : TimeseriesholtNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtNode::max(self : TimeseriesholtNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtNode::to_string(self : TimeseriesholtNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_edge_make(size : Int32) -> TimeseriesholtEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtEdge::len(self : TimeseriesholtEdge) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtEdge::get(self : TimeseriesholtEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtEdge::set(
  self : TimeseriesholtEdge,
  i : Int32,
  v : Double,
) -> TimeseriesholtEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtEdge::sum(self : TimeseriesholtEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtEdge::mean(self : TimeseriesholtEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtEdge::scale(
  self : TimeseriesholtEdge,
  f : Double,
) -> TimeseriesholtEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtEdge::add(
  self : TimeseriesholtEdge,
  other : TimeseriesholtEdge,
) -> TimeseriesholtEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtEdge::copy(
  self : TimeseriesholtEdge,
) -> TimeseriesholtEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtEdge::fill(
  self : TimeseriesholtEdge,
  v : Double,
) -> TimeseriesholtEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtEdge::min(self : TimeseriesholtEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtEdge::max(self : TimeseriesholtEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtEdge::to_string(self : TimeseriesholtEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_path_make(size : Int32) -> TimeseriesholtPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtPath::len(self : TimeseriesholtPath) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtPath::get(self : TimeseriesholtPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtPath::set(
  self : TimeseriesholtPath,
  i : Int32,
  v : Double,
) -> TimeseriesholtPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtPath::sum(self : TimeseriesholtPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtPath::mean(self : TimeseriesholtPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtPath::scale(
  self : TimeseriesholtPath,
  f : Double,
) -> TimeseriesholtPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtPath::add(
  self : TimeseriesholtPath,
  other : TimeseriesholtPath,
) -> TimeseriesholtPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtPath::copy(
  self : TimeseriesholtPath,
) -> TimeseriesholtPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtPath::fill(
  self : TimeseriesholtPath,
  v : Double,
) -> TimeseriesholtPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtPath::min(self : TimeseriesholtPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtPath::max(self : TimeseriesholtPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtPath::to_string(self : TimeseriesholtPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_cluster_make(size : Int32) -> TimeseriesholtCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtCluster::len(self : TimeseriesholtCluster) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtCluster::get(
  self : TimeseriesholtCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtCluster::set(
  self : TimeseriesholtCluster,
  i : Int32,
  v : Double,
) -> TimeseriesholtCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtCluster::sum(self : TimeseriesholtCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtCluster::mean(self : TimeseriesholtCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtCluster::scale(
  self : TimeseriesholtCluster,
  f : Double,
) -> TimeseriesholtCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtCluster::add(
  self : TimeseriesholtCluster,
  other : TimeseriesholtCluster,
) -> TimeseriesholtCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtCluster::copy(
  self : TimeseriesholtCluster,
) -> TimeseriesholtCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtCluster::fill(
  self : TimeseriesholtCluster,
  v : Double,
) -> TimeseriesholtCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtCluster::min(self : TimeseriesholtCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtCluster::max(self : TimeseriesholtCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtCluster::to_string(self : TimeseriesholtCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_model_make(size : Int32) -> TimeseriesholtModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtModel::len(self : TimeseriesholtModel) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtModel::get(
  self : TimeseriesholtModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtModel::set(
  self : TimeseriesholtModel,
  i : Int32,
  v : Double,
) -> TimeseriesholtModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtModel::sum(self : TimeseriesholtModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtModel::mean(self : TimeseriesholtModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtModel::scale(
  self : TimeseriesholtModel,
  f : Double,
) -> TimeseriesholtModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtModel::add(
  self : TimeseriesholtModel,
  other : TimeseriesholtModel,
) -> TimeseriesholtModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtModel::copy(
  self : TimeseriesholtModel,
) -> TimeseriesholtModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtModel::fill(
  self : TimeseriesholtModel,
  v : Double,
) -> TimeseriesholtModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtModel::min(self : TimeseriesholtModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtModel::max(self : TimeseriesholtModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtModel::to_string(self : TimeseriesholtModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_layer_make(size : Int32) -> TimeseriesholtLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtLayer::len(self : TimeseriesholtLayer) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtLayer::get(
  self : TimeseriesholtLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtLayer::set(
  self : TimeseriesholtLayer,
  i : Int32,
  v : Double,
) -> TimeseriesholtLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtLayer::sum(self : TimeseriesholtLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtLayer::mean(self : TimeseriesholtLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtLayer::scale(
  self : TimeseriesholtLayer,
  f : Double,
) -> TimeseriesholtLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtLayer::add(
  self : TimeseriesholtLayer,
  other : TimeseriesholtLayer,
) -> TimeseriesholtLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtLayer::copy(
  self : TimeseriesholtLayer,
) -> TimeseriesholtLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtLayer::fill(
  self : TimeseriesholtLayer,
  v : Double,
) -> TimeseriesholtLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtLayer::min(self : TimeseriesholtLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtLayer::max(self : TimeseriesholtLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtLayer::to_string(self : TimeseriesholtLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_buffer_make(size : Int32) -> TimeseriesholtBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtBuffer::len(self : TimeseriesholtBuffer) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtBuffer::get(
  self : TimeseriesholtBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtBuffer::set(
  self : TimeseriesholtBuffer,
  i : Int32,
  v : Double,
) -> TimeseriesholtBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtBuffer::sum(self : TimeseriesholtBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtBuffer::mean(self : TimeseriesholtBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtBuffer::scale(
  self : TimeseriesholtBuffer,
  f : Double,
) -> TimeseriesholtBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtBuffer::add(
  self : TimeseriesholtBuffer,
  other : TimeseriesholtBuffer,
) -> TimeseriesholtBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtBuffer::copy(
  self : TimeseriesholtBuffer,
) -> TimeseriesholtBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtBuffer::fill(
  self : TimeseriesholtBuffer,
  v : Double,
) -> TimeseriesholtBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtBuffer::min(self : TimeseriesholtBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtBuffer::max(self : TimeseriesholtBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtBuffer::to_string(self : TimeseriesholtBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_cursor_make(size : Int32) -> TimeseriesholtCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtCursor::len(self : TimeseriesholtCursor) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtCursor::get(
  self : TimeseriesholtCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtCursor::set(
  self : TimeseriesholtCursor,
  i : Int32,
  v : Double,
) -> TimeseriesholtCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtCursor::sum(self : TimeseriesholtCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtCursor::mean(self : TimeseriesholtCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtCursor::scale(
  self : TimeseriesholtCursor,
  f : Double,
) -> TimeseriesholtCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtCursor::add(
  self : TimeseriesholtCursor,
  other : TimeseriesholtCursor,
) -> TimeseriesholtCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtCursor::copy(
  self : TimeseriesholtCursor,
) -> TimeseriesholtCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtCursor::fill(
  self : TimeseriesholtCursor,
  v : Double,
) -> TimeseriesholtCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtCursor::min(self : TimeseriesholtCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtCursor::max(self : TimeseriesholtCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtCursor::to_string(self : TimeseriesholtCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_view_make(size : Int32) -> TimeseriesholtView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtView::len(self : TimeseriesholtView) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtView::get(self : TimeseriesholtView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtView::set(
  self : TimeseriesholtView,
  i : Int32,
  v : Double,
) -> TimeseriesholtView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtView::sum(self : TimeseriesholtView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtView::mean(self : TimeseriesholtView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtView::scale(
  self : TimeseriesholtView,
  f : Double,
) -> TimeseriesholtView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtView::add(
  self : TimeseriesholtView,
  other : TimeseriesholtView,
) -> TimeseriesholtView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtView::copy(
  self : TimeseriesholtView,
) -> TimeseriesholtView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtView::fill(
  self : TimeseriesholtView,
  v : Double,
) -> TimeseriesholtView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtView::min(self : TimeseriesholtView) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtView::max(self : TimeseriesholtView) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtView::to_string(self : TimeseriesholtView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_range_make(size : Int32) -> TimeseriesholtRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtRange::len(self : TimeseriesholtRange) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtRange::get(
  self : TimeseriesholtRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtRange::set(
  self : TimeseriesholtRange,
  i : Int32,
  v : Double,
) -> TimeseriesholtRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtRange::sum(self : TimeseriesholtRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtRange::mean(self : TimeseriesholtRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtRange::scale(
  self : TimeseriesholtRange,
  f : Double,
) -> TimeseriesholtRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtRange::add(
  self : TimeseriesholtRange,
  other : TimeseriesholtRange,
) -> TimeseriesholtRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtRange::copy(
  self : TimeseriesholtRange,
) -> TimeseriesholtRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtRange::fill(
  self : TimeseriesholtRange,
  v : Double,
) -> TimeseriesholtRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtRange::min(self : TimeseriesholtRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtRange::max(self : TimeseriesholtRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtRange::to_string(self : TimeseriesholtRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesholtSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_holt_slice_make(size : Int32) -> TimeseriesholtSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesholtSlice::len(self : TimeseriesholtSlice) -> Int32 {
  self.size
}

///|
pub fn TimeseriesholtSlice::get(
  self : TimeseriesholtSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesholtSlice::set(
  self : TimeseriesholtSlice,
  i : Int32,
  v : Double,
) -> TimeseriesholtSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtSlice::sum(self : TimeseriesholtSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesholtSlice::mean(self : TimeseriesholtSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesholtSlice::scale(
  self : TimeseriesholtSlice,
  f : Double,
) -> TimeseriesholtSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtSlice::add(
  self : TimeseriesholtSlice,
  other : TimeseriesholtSlice,
) -> TimeseriesholtSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesholtSlice::copy(
  self : TimeseriesholtSlice,
) -> TimeseriesholtSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtSlice::fill(
  self : TimeseriesholtSlice,
  v : Double,
) -> TimeseriesholtSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesholtSlice::min(self : TimeseriesholtSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesholtSlice::max(self : TimeseriesholtSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesholtSlice::to_string(self : TimeseriesholtSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
