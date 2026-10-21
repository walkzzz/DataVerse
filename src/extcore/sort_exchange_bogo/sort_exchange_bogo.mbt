///|
///===
/// extcore/sort_exchange_bogo
pub(all) struct SortexchangebogoPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn sort_exchange_bogo_make_point(
  x : Double,
  y : Double,
) -> SortexchangebogoPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn sort_exchange_bogo_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SortexchangebogoPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SortexchangebogoPoint::x(self : SortexchangebogoPoint) -> Double {
  self.x
}

///|
pub fn SortexchangebogoPoint::y(self : SortexchangebogoPoint) -> Double {
  self.y
}

///|
pub fn SortexchangebogoPoint::z(self : SortexchangebogoPoint) -> Double {
  self.z
}

///|
pub fn SortexchangebogoPoint::label(self : SortexchangebogoPoint) -> Int32 {
  self.label
}

///|
pub fn SortexchangebogoPoint::dist(
  self : SortexchangebogoPoint,
  other : SortexchangebogoPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SortexchangebogoPoint::add(
  self : SortexchangebogoPoint,
  other : SortexchangebogoPoint,
) -> SortexchangebogoPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SortexchangebogoPoint::sub(
  self : SortexchangebogoPoint,
  other : SortexchangebogoPoint,
) -> SortexchangebogoPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SortexchangebogoPoint::scale(
  self : SortexchangebogoPoint,
  s : Double,
) -> SortexchangebogoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SortexchangebogoPoint::dot(
  self : SortexchangebogoPoint,
  other : SortexchangebogoPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SortexchangebogoPoint::cross(
  self : SortexchangebogoPoint,
  other : SortexchangebogoPoint,
) -> SortexchangebogoPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SortexchangebogoPoint::norm(self : SortexchangebogoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SortexchangebogoPoint::normalize(
  self : SortexchangebogoPoint,
) -> SortexchangebogoPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortexchangebogoPoint::negate(
  self : SortexchangebogoPoint,
) -> SortexchangebogoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SortexchangebogoPoint::mid(
  self : SortexchangebogoPoint,
  other : SortexchangebogoPoint,
) -> SortexchangebogoPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SortexchangebogoPoint::lerp(
  self : SortexchangebogoPoint,
  other : SortexchangebogoPoint,
  t : Double,
) -> SortexchangebogoPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SortexchangebogoPoint::to_string(self : SortexchangebogoPoint) -> String {
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
pub(all) struct SortexchangebogoSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn sort_exchange_bogo_make_series(
  vals : Array[Double],
  name : String,
) -> SortexchangebogoSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SortexchangebogoSeries::len(self : SortexchangebogoSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn SortexchangebogoSeries::sum(self : SortexchangebogoSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SortexchangebogoSeries::mean(self : SortexchangebogoSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SortexchangebogoSeries::min(self : SortexchangebogoSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SortexchangebogoSeries::max(self : SortexchangebogoSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SortexchangebogoSeries::range(self : SortexchangebogoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SortexchangebogoSeries::variance(
  self : SortexchangebogoSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SortexchangebogoSeries::std(self : SortexchangebogoSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SortexchangebogoSeries::median(self : SortexchangebogoSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SortexchangebogoSeries::scale(
  self : SortexchangebogoSeries,
  f : Double,
) -> SortexchangebogoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SortexchangebogoSeries::add(
  self : SortexchangebogoSeries,
  other : SortexchangebogoSeries,
) -> SortexchangebogoSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortexchangebogoSeries::sub(
  self : SortexchangebogoSeries,
  other : SortexchangebogoSeries,
) -> SortexchangebogoSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortexchangebogoSeries::normalize(
  self : SortexchangebogoSeries,
) -> SortexchangebogoSeries {
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
pub fn SortexchangebogoSeries::cumsum(
  self : SortexchangebogoSeries,
) -> SortexchangebogoSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SortexchangebogoSeries::to_string(
  self : SortexchangebogoSeries,
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
pub(all) struct SortexchangebogoMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn sort_exchange_bogo_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SortexchangebogoMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn sort_exchange_bogo_matrix_identity(n : Int32) -> SortexchangebogoMatrix {
  let m = sort_exchange_bogo_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SortexchangebogoMatrix::get(
  self : SortexchangebogoMatrix,
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
pub fn SortexchangebogoMatrix::transpose(
  self : SortexchangebogoMatrix,
) -> SortexchangebogoMatrix {
  let result = sort_exchange_bogo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SortexchangebogoMatrix::add(
  self : SortexchangebogoMatrix,
  other : SortexchangebogoMatrix,
) -> SortexchangebogoMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = sort_exchange_bogo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SortexchangebogoMatrix::scale(
  self : SortexchangebogoMatrix,
  s : Double,
) -> SortexchangebogoMatrix {
  let result = sort_exchange_bogo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SortexchangebogoMatrix::multiply(
  self : SortexchangebogoMatrix,
  other : SortexchangebogoMatrix,
) -> SortexchangebogoMatrix {
  if self.cols != other.rows {
    return sort_exchange_bogo_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = sort_exchange_bogo_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SortexchangebogoMatrix::trace(self : SortexchangebogoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SortexchangebogoMatrix::det(self : SortexchangebogoMatrix) -> Double {
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
pub fn SortexchangebogoMatrix::norm(self : SortexchangebogoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn SortexchangebogoMatrix::to_string(
  self : SortexchangebogoMatrix,
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
pub(all) struct SortexchangebogoVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn sort_exchange_bogo_make_vector(
  comps : Array[Double],
) -> SortexchangebogoVector {
  { comps, dim: comps.length(), }
}

///|
pub fn sort_exchange_bogo_vector_zero(dim : Int32) -> SortexchangebogoVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SortexchangebogoVector::add(
  self : SortexchangebogoVector,
  other : SortexchangebogoVector,
) -> SortexchangebogoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortexchangebogoVector::sub(
  self : SortexchangebogoVector,
  other : SortexchangebogoVector,
) -> SortexchangebogoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortexchangebogoVector::scale(
  self : SortexchangebogoVector,
  s : Double,
) -> SortexchangebogoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SortexchangebogoVector::dot(
  self : SortexchangebogoVector,
  other : SortexchangebogoVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SortexchangebogoVector::norm(self : SortexchangebogoVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SortexchangebogoVector::normalize(
  self : SortexchangebogoVector,
) -> SortexchangebogoVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortexchangebogoVector::dist(
  self : SortexchangebogoVector,
  other : SortexchangebogoVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SortexchangebogoVector::to_string(
  self : SortexchangebogoVector,
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
pub(all) struct SortexchangebogoFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_frame_make(size : Int32) -> SortexchangebogoFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoFrame::len(self : SortexchangebogoFrame) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoFrame::get(
  self : SortexchangebogoFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoFrame::set(
  self : SortexchangebogoFrame,
  i : Int32,
  v : Double,
) -> SortexchangebogoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoFrame::sum(self : SortexchangebogoFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoFrame::mean(self : SortexchangebogoFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoFrame::scale(
  self : SortexchangebogoFrame,
  f : Double,
) -> SortexchangebogoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoFrame::add(
  self : SortexchangebogoFrame,
  other : SortexchangebogoFrame,
) -> SortexchangebogoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoFrame::copy(
  self : SortexchangebogoFrame,
) -> SortexchangebogoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoFrame::fill(
  self : SortexchangebogoFrame,
  v : Double,
) -> SortexchangebogoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoFrame::min(self : SortexchangebogoFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoFrame::max(self : SortexchangebogoFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoFrame::to_string(self : SortexchangebogoFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_table_make(size : Int32) -> SortexchangebogoTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoTable::len(self : SortexchangebogoTable) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoTable::get(
  self : SortexchangebogoTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoTable::set(
  self : SortexchangebogoTable,
  i : Int32,
  v : Double,
) -> SortexchangebogoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoTable::sum(self : SortexchangebogoTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoTable::mean(self : SortexchangebogoTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoTable::scale(
  self : SortexchangebogoTable,
  f : Double,
) -> SortexchangebogoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoTable::add(
  self : SortexchangebogoTable,
  other : SortexchangebogoTable,
) -> SortexchangebogoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoTable::copy(
  self : SortexchangebogoTable,
) -> SortexchangebogoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoTable::fill(
  self : SortexchangebogoTable,
  v : Double,
) -> SortexchangebogoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoTable::min(self : SortexchangebogoTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoTable::max(self : SortexchangebogoTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoTable::to_string(self : SortexchangebogoTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_graphn_make(size : Int32) -> SortexchangebogoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoGraphN::len(self : SortexchangebogoGraphN) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoGraphN::get(
  self : SortexchangebogoGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoGraphN::set(
  self : SortexchangebogoGraphN,
  i : Int32,
  v : Double,
) -> SortexchangebogoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoGraphN::sum(self : SortexchangebogoGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoGraphN::mean(self : SortexchangebogoGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoGraphN::scale(
  self : SortexchangebogoGraphN,
  f : Double,
) -> SortexchangebogoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoGraphN::add(
  self : SortexchangebogoGraphN,
  other : SortexchangebogoGraphN,
) -> SortexchangebogoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoGraphN::copy(
  self : SortexchangebogoGraphN,
) -> SortexchangebogoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoGraphN::fill(
  self : SortexchangebogoGraphN,
  v : Double,
) -> SortexchangebogoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoGraphN::min(self : SortexchangebogoGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoGraphN::max(self : SortexchangebogoGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoGraphN::to_string(
  self : SortexchangebogoGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_node_make(size : Int32) -> SortexchangebogoNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoNode::len(self : SortexchangebogoNode) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoNode::get(
  self : SortexchangebogoNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoNode::set(
  self : SortexchangebogoNode,
  i : Int32,
  v : Double,
) -> SortexchangebogoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoNode::sum(self : SortexchangebogoNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoNode::mean(self : SortexchangebogoNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoNode::scale(
  self : SortexchangebogoNode,
  f : Double,
) -> SortexchangebogoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoNode::add(
  self : SortexchangebogoNode,
  other : SortexchangebogoNode,
) -> SortexchangebogoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoNode::copy(
  self : SortexchangebogoNode,
) -> SortexchangebogoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoNode::fill(
  self : SortexchangebogoNode,
  v : Double,
) -> SortexchangebogoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoNode::min(self : SortexchangebogoNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoNode::max(self : SortexchangebogoNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoNode::to_string(self : SortexchangebogoNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_edge_make(size : Int32) -> SortexchangebogoEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoEdge::len(self : SortexchangebogoEdge) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoEdge::get(
  self : SortexchangebogoEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoEdge::set(
  self : SortexchangebogoEdge,
  i : Int32,
  v : Double,
) -> SortexchangebogoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoEdge::sum(self : SortexchangebogoEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoEdge::mean(self : SortexchangebogoEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoEdge::scale(
  self : SortexchangebogoEdge,
  f : Double,
) -> SortexchangebogoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoEdge::add(
  self : SortexchangebogoEdge,
  other : SortexchangebogoEdge,
) -> SortexchangebogoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoEdge::copy(
  self : SortexchangebogoEdge,
) -> SortexchangebogoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoEdge::fill(
  self : SortexchangebogoEdge,
  v : Double,
) -> SortexchangebogoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoEdge::min(self : SortexchangebogoEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoEdge::max(self : SortexchangebogoEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoEdge::to_string(self : SortexchangebogoEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_path_make(size : Int32) -> SortexchangebogoPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoPath::len(self : SortexchangebogoPath) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoPath::get(
  self : SortexchangebogoPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoPath::set(
  self : SortexchangebogoPath,
  i : Int32,
  v : Double,
) -> SortexchangebogoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoPath::sum(self : SortexchangebogoPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoPath::mean(self : SortexchangebogoPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoPath::scale(
  self : SortexchangebogoPath,
  f : Double,
) -> SortexchangebogoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoPath::add(
  self : SortexchangebogoPath,
  other : SortexchangebogoPath,
) -> SortexchangebogoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoPath::copy(
  self : SortexchangebogoPath,
) -> SortexchangebogoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoPath::fill(
  self : SortexchangebogoPath,
  v : Double,
) -> SortexchangebogoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoPath::min(self : SortexchangebogoPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoPath::max(self : SortexchangebogoPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoPath::to_string(self : SortexchangebogoPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_cluster_make(size : Int32) -> SortexchangebogoCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoCluster::len(self : SortexchangebogoCluster) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoCluster::get(
  self : SortexchangebogoCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoCluster::set(
  self : SortexchangebogoCluster,
  i : Int32,
  v : Double,
) -> SortexchangebogoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoCluster::sum(self : SortexchangebogoCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoCluster::mean(self : SortexchangebogoCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoCluster::scale(
  self : SortexchangebogoCluster,
  f : Double,
) -> SortexchangebogoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoCluster::add(
  self : SortexchangebogoCluster,
  other : SortexchangebogoCluster,
) -> SortexchangebogoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoCluster::copy(
  self : SortexchangebogoCluster,
) -> SortexchangebogoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoCluster::fill(
  self : SortexchangebogoCluster,
  v : Double,
) -> SortexchangebogoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoCluster::min(self : SortexchangebogoCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoCluster::max(self : SortexchangebogoCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoCluster::to_string(
  self : SortexchangebogoCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_model_make(size : Int32) -> SortexchangebogoModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoModel::len(self : SortexchangebogoModel) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoModel::get(
  self : SortexchangebogoModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoModel::set(
  self : SortexchangebogoModel,
  i : Int32,
  v : Double,
) -> SortexchangebogoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoModel::sum(self : SortexchangebogoModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoModel::mean(self : SortexchangebogoModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoModel::scale(
  self : SortexchangebogoModel,
  f : Double,
) -> SortexchangebogoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoModel::add(
  self : SortexchangebogoModel,
  other : SortexchangebogoModel,
) -> SortexchangebogoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoModel::copy(
  self : SortexchangebogoModel,
) -> SortexchangebogoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoModel::fill(
  self : SortexchangebogoModel,
  v : Double,
) -> SortexchangebogoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoModel::min(self : SortexchangebogoModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoModel::max(self : SortexchangebogoModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoModel::to_string(self : SortexchangebogoModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_layer_make(size : Int32) -> SortexchangebogoLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoLayer::len(self : SortexchangebogoLayer) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoLayer::get(
  self : SortexchangebogoLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoLayer::set(
  self : SortexchangebogoLayer,
  i : Int32,
  v : Double,
) -> SortexchangebogoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoLayer::sum(self : SortexchangebogoLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoLayer::mean(self : SortexchangebogoLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoLayer::scale(
  self : SortexchangebogoLayer,
  f : Double,
) -> SortexchangebogoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoLayer::add(
  self : SortexchangebogoLayer,
  other : SortexchangebogoLayer,
) -> SortexchangebogoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoLayer::copy(
  self : SortexchangebogoLayer,
) -> SortexchangebogoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoLayer::fill(
  self : SortexchangebogoLayer,
  v : Double,
) -> SortexchangebogoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoLayer::min(self : SortexchangebogoLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoLayer::max(self : SortexchangebogoLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoLayer::to_string(self : SortexchangebogoLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_buffer_make(size : Int32) -> SortexchangebogoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoBuffer::len(self : SortexchangebogoBuffer) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoBuffer::get(
  self : SortexchangebogoBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoBuffer::set(
  self : SortexchangebogoBuffer,
  i : Int32,
  v : Double,
) -> SortexchangebogoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoBuffer::sum(self : SortexchangebogoBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoBuffer::mean(self : SortexchangebogoBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoBuffer::scale(
  self : SortexchangebogoBuffer,
  f : Double,
) -> SortexchangebogoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoBuffer::add(
  self : SortexchangebogoBuffer,
  other : SortexchangebogoBuffer,
) -> SortexchangebogoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoBuffer::copy(
  self : SortexchangebogoBuffer,
) -> SortexchangebogoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoBuffer::fill(
  self : SortexchangebogoBuffer,
  v : Double,
) -> SortexchangebogoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoBuffer::min(self : SortexchangebogoBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoBuffer::max(self : SortexchangebogoBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoBuffer::to_string(
  self : SortexchangebogoBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_cursor_make(size : Int32) -> SortexchangebogoCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoCursor::len(self : SortexchangebogoCursor) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoCursor::get(
  self : SortexchangebogoCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoCursor::set(
  self : SortexchangebogoCursor,
  i : Int32,
  v : Double,
) -> SortexchangebogoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoCursor::sum(self : SortexchangebogoCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoCursor::mean(self : SortexchangebogoCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoCursor::scale(
  self : SortexchangebogoCursor,
  f : Double,
) -> SortexchangebogoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoCursor::add(
  self : SortexchangebogoCursor,
  other : SortexchangebogoCursor,
) -> SortexchangebogoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoCursor::copy(
  self : SortexchangebogoCursor,
) -> SortexchangebogoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoCursor::fill(
  self : SortexchangebogoCursor,
  v : Double,
) -> SortexchangebogoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoCursor::min(self : SortexchangebogoCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoCursor::max(self : SortexchangebogoCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoCursor::to_string(
  self : SortexchangebogoCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_view_make(size : Int32) -> SortexchangebogoView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoView::len(self : SortexchangebogoView) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoView::get(
  self : SortexchangebogoView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoView::set(
  self : SortexchangebogoView,
  i : Int32,
  v : Double,
) -> SortexchangebogoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoView::sum(self : SortexchangebogoView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoView::mean(self : SortexchangebogoView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoView::scale(
  self : SortexchangebogoView,
  f : Double,
) -> SortexchangebogoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoView::add(
  self : SortexchangebogoView,
  other : SortexchangebogoView,
) -> SortexchangebogoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoView::copy(
  self : SortexchangebogoView,
) -> SortexchangebogoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoView::fill(
  self : SortexchangebogoView,
  v : Double,
) -> SortexchangebogoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoView::min(self : SortexchangebogoView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoView::max(self : SortexchangebogoView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoView::to_string(self : SortexchangebogoView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_range_make(size : Int32) -> SortexchangebogoRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoRange::len(self : SortexchangebogoRange) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoRange::get(
  self : SortexchangebogoRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoRange::set(
  self : SortexchangebogoRange,
  i : Int32,
  v : Double,
) -> SortexchangebogoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoRange::sum(self : SortexchangebogoRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoRange::mean(self : SortexchangebogoRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoRange::scale(
  self : SortexchangebogoRange,
  f : Double,
) -> SortexchangebogoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoRange::add(
  self : SortexchangebogoRange,
  other : SortexchangebogoRange,
) -> SortexchangebogoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoRange::copy(
  self : SortexchangebogoRange,
) -> SortexchangebogoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoRange::fill(
  self : SortexchangebogoRange,
  v : Double,
) -> SortexchangebogoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoRange::min(self : SortexchangebogoRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoRange::max(self : SortexchangebogoRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoRange::to_string(self : SortexchangebogoRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangebogoSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_bogo_slice_make(size : Int32) -> SortexchangebogoSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangebogoSlice::len(self : SortexchangebogoSlice) -> Int32 {
  self.size
}

///|
pub fn SortexchangebogoSlice::get(
  self : SortexchangebogoSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangebogoSlice::set(
  self : SortexchangebogoSlice,
  i : Int32,
  v : Double,
) -> SortexchangebogoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoSlice::sum(self : SortexchangebogoSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangebogoSlice::mean(self : SortexchangebogoSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangebogoSlice::scale(
  self : SortexchangebogoSlice,
  f : Double,
) -> SortexchangebogoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoSlice::add(
  self : SortexchangebogoSlice,
  other : SortexchangebogoSlice,
) -> SortexchangebogoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangebogoSlice::copy(
  self : SortexchangebogoSlice,
) -> SortexchangebogoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoSlice::fill(
  self : SortexchangebogoSlice,
  v : Double,
) -> SortexchangebogoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangebogoSlice::min(self : SortexchangebogoSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangebogoSlice::max(self : SortexchangebogoSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangebogoSlice::to_string(self : SortexchangebogoSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
