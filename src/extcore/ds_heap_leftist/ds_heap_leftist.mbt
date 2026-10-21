///|
///===
/// extcore/ds_heap_leftist
pub(all) struct DsheapleftistPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ds_heap_leftist_make_point(x : Double, y : Double) -> DsheapleftistPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ds_heap_leftist_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DsheapleftistPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DsheapleftistPoint::x(self : DsheapleftistPoint) -> Double {
  self.x
}

///|
pub fn DsheapleftistPoint::y(self : DsheapleftistPoint) -> Double {
  self.y
}

///|
pub fn DsheapleftistPoint::z(self : DsheapleftistPoint) -> Double {
  self.z
}

///|
pub fn DsheapleftistPoint::label(self : DsheapleftistPoint) -> Int32 {
  self.label
}

///|
pub fn DsheapleftistPoint::dist(
  self : DsheapleftistPoint,
  other : DsheapleftistPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DsheapleftistPoint::add(
  self : DsheapleftistPoint,
  other : DsheapleftistPoint,
) -> DsheapleftistPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DsheapleftistPoint::sub(
  self : DsheapleftistPoint,
  other : DsheapleftistPoint,
) -> DsheapleftistPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DsheapleftistPoint::scale(
  self : DsheapleftistPoint,
  s : Double,
) -> DsheapleftistPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DsheapleftistPoint::dot(
  self : DsheapleftistPoint,
  other : DsheapleftistPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DsheapleftistPoint::cross(
  self : DsheapleftistPoint,
  other : DsheapleftistPoint,
) -> DsheapleftistPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DsheapleftistPoint::norm(self : DsheapleftistPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DsheapleftistPoint::normalize(
  self : DsheapleftistPoint,
) -> DsheapleftistPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DsheapleftistPoint::negate(
  self : DsheapleftistPoint,
) -> DsheapleftistPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DsheapleftistPoint::mid(
  self : DsheapleftistPoint,
  other : DsheapleftistPoint,
) -> DsheapleftistPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DsheapleftistPoint::lerp(
  self : DsheapleftistPoint,
  other : DsheapleftistPoint,
  t : Double,
) -> DsheapleftistPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DsheapleftistPoint::to_string(self : DsheapleftistPoint) -> String {
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
pub(all) struct DsheapleftistSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ds_heap_leftist_make_series(
  vals : Array[Double],
  name : String,
) -> DsheapleftistSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DsheapleftistSeries::len(self : DsheapleftistSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DsheapleftistSeries::sum(self : DsheapleftistSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DsheapleftistSeries::mean(self : DsheapleftistSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DsheapleftistSeries::min(self : DsheapleftistSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DsheapleftistSeries::max(self : DsheapleftistSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DsheapleftistSeries::range(self : DsheapleftistSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DsheapleftistSeries::variance(self : DsheapleftistSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DsheapleftistSeries::std(self : DsheapleftistSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DsheapleftistSeries::median(self : DsheapleftistSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DsheapleftistSeries::scale(
  self : DsheapleftistSeries,
  f : Double,
) -> DsheapleftistSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DsheapleftistSeries::add(
  self : DsheapleftistSeries,
  other : DsheapleftistSeries,
) -> DsheapleftistSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DsheapleftistSeries::sub(
  self : DsheapleftistSeries,
  other : DsheapleftistSeries,
) -> DsheapleftistSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DsheapleftistSeries::normalize(
  self : DsheapleftistSeries,
) -> DsheapleftistSeries {
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
pub fn DsheapleftistSeries::cumsum(
  self : DsheapleftistSeries,
) -> DsheapleftistSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DsheapleftistSeries::to_string(self : DsheapleftistSeries) -> String {
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
pub(all) struct DsheapleftistMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ds_heap_leftist_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DsheapleftistMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ds_heap_leftist_matrix_identity(n : Int32) -> DsheapleftistMatrix {
  let m = ds_heap_leftist_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DsheapleftistMatrix::get(
  self : DsheapleftistMatrix,
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
pub fn DsheapleftistMatrix::transpose(
  self : DsheapleftistMatrix,
) -> DsheapleftistMatrix {
  let result = ds_heap_leftist_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DsheapleftistMatrix::add(
  self : DsheapleftistMatrix,
  other : DsheapleftistMatrix,
) -> DsheapleftistMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ds_heap_leftist_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DsheapleftistMatrix::scale(
  self : DsheapleftistMatrix,
  s : Double,
) -> DsheapleftistMatrix {
  let result = ds_heap_leftist_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DsheapleftistMatrix::multiply(
  self : DsheapleftistMatrix,
  other : DsheapleftistMatrix,
) -> DsheapleftistMatrix {
  if self.cols != other.rows {
    return ds_heap_leftist_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ds_heap_leftist_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DsheapleftistMatrix::trace(self : DsheapleftistMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DsheapleftistMatrix::det(self : DsheapleftistMatrix) -> Double {
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
pub fn DsheapleftistMatrix::norm(self : DsheapleftistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DsheapleftistMatrix::to_string(self : DsheapleftistMatrix) -> String {
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
pub(all) struct DsheapleftistVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ds_heap_leftist_make_vector(
  comps : Array[Double],
) -> DsheapleftistVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ds_heap_leftist_vector_zero(dim : Int32) -> DsheapleftistVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DsheapleftistVector::add(
  self : DsheapleftistVector,
  other : DsheapleftistVector,
) -> DsheapleftistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DsheapleftistVector::sub(
  self : DsheapleftistVector,
  other : DsheapleftistVector,
) -> DsheapleftistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DsheapleftistVector::scale(
  self : DsheapleftistVector,
  s : Double,
) -> DsheapleftistVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DsheapleftistVector::dot(
  self : DsheapleftistVector,
  other : DsheapleftistVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DsheapleftistVector::norm(self : DsheapleftistVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DsheapleftistVector::normalize(
  self : DsheapleftistVector,
) -> DsheapleftistVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DsheapleftistVector::dist(
  self : DsheapleftistVector,
  other : DsheapleftistVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DsheapleftistVector::to_string(self : DsheapleftistVector) -> String {
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
pub(all) struct DsheapleftistFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_frame_make(size : Int32) -> DsheapleftistFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistFrame::len(self : DsheapleftistFrame) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistFrame::get(self : DsheapleftistFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistFrame::set(
  self : DsheapleftistFrame,
  i : Int32,
  v : Double,
) -> DsheapleftistFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistFrame::sum(self : DsheapleftistFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistFrame::mean(self : DsheapleftistFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistFrame::scale(
  self : DsheapleftistFrame,
  f : Double,
) -> DsheapleftistFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistFrame::add(
  self : DsheapleftistFrame,
  other : DsheapleftistFrame,
) -> DsheapleftistFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistFrame::copy(
  self : DsheapleftistFrame,
) -> DsheapleftistFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistFrame::fill(
  self : DsheapleftistFrame,
  v : Double,
) -> DsheapleftistFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistFrame::min(self : DsheapleftistFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistFrame::max(self : DsheapleftistFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistFrame::to_string(self : DsheapleftistFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_table_make(size : Int32) -> DsheapleftistTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistTable::len(self : DsheapleftistTable) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistTable::get(self : DsheapleftistTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistTable::set(
  self : DsheapleftistTable,
  i : Int32,
  v : Double,
) -> DsheapleftistTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistTable::sum(self : DsheapleftistTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistTable::mean(self : DsheapleftistTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistTable::scale(
  self : DsheapleftistTable,
  f : Double,
) -> DsheapleftistTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistTable::add(
  self : DsheapleftistTable,
  other : DsheapleftistTable,
) -> DsheapleftistTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistTable::copy(
  self : DsheapleftistTable,
) -> DsheapleftistTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistTable::fill(
  self : DsheapleftistTable,
  v : Double,
) -> DsheapleftistTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistTable::min(self : DsheapleftistTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistTable::max(self : DsheapleftistTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistTable::to_string(self : DsheapleftistTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_graphn_make(size : Int32) -> DsheapleftistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistGraphN::len(self : DsheapleftistGraphN) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistGraphN::get(
  self : DsheapleftistGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistGraphN::set(
  self : DsheapleftistGraphN,
  i : Int32,
  v : Double,
) -> DsheapleftistGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistGraphN::sum(self : DsheapleftistGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistGraphN::mean(self : DsheapleftistGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistGraphN::scale(
  self : DsheapleftistGraphN,
  f : Double,
) -> DsheapleftistGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistGraphN::add(
  self : DsheapleftistGraphN,
  other : DsheapleftistGraphN,
) -> DsheapleftistGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistGraphN::copy(
  self : DsheapleftistGraphN,
) -> DsheapleftistGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistGraphN::fill(
  self : DsheapleftistGraphN,
  v : Double,
) -> DsheapleftistGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistGraphN::min(self : DsheapleftistGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistGraphN::max(self : DsheapleftistGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistGraphN::to_string(self : DsheapleftistGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_node_make(size : Int32) -> DsheapleftistNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistNode::len(self : DsheapleftistNode) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistNode::get(self : DsheapleftistNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistNode::set(
  self : DsheapleftistNode,
  i : Int32,
  v : Double,
) -> DsheapleftistNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistNode::sum(self : DsheapleftistNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistNode::mean(self : DsheapleftistNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistNode::scale(
  self : DsheapleftistNode,
  f : Double,
) -> DsheapleftistNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistNode::add(
  self : DsheapleftistNode,
  other : DsheapleftistNode,
) -> DsheapleftistNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistNode::copy(self : DsheapleftistNode) -> DsheapleftistNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistNode::fill(
  self : DsheapleftistNode,
  v : Double,
) -> DsheapleftistNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistNode::min(self : DsheapleftistNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistNode::max(self : DsheapleftistNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistNode::to_string(self : DsheapleftistNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_edge_make(size : Int32) -> DsheapleftistEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistEdge::len(self : DsheapleftistEdge) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistEdge::get(self : DsheapleftistEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistEdge::set(
  self : DsheapleftistEdge,
  i : Int32,
  v : Double,
) -> DsheapleftistEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistEdge::sum(self : DsheapleftistEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistEdge::mean(self : DsheapleftistEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistEdge::scale(
  self : DsheapleftistEdge,
  f : Double,
) -> DsheapleftistEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistEdge::add(
  self : DsheapleftistEdge,
  other : DsheapleftistEdge,
) -> DsheapleftistEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistEdge::copy(self : DsheapleftistEdge) -> DsheapleftistEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistEdge::fill(
  self : DsheapleftistEdge,
  v : Double,
) -> DsheapleftistEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistEdge::min(self : DsheapleftistEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistEdge::max(self : DsheapleftistEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistEdge::to_string(self : DsheapleftistEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_path_make(size : Int32) -> DsheapleftistPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistPath::len(self : DsheapleftistPath) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistPath::get(self : DsheapleftistPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistPath::set(
  self : DsheapleftistPath,
  i : Int32,
  v : Double,
) -> DsheapleftistPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistPath::sum(self : DsheapleftistPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistPath::mean(self : DsheapleftistPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistPath::scale(
  self : DsheapleftistPath,
  f : Double,
) -> DsheapleftistPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistPath::add(
  self : DsheapleftistPath,
  other : DsheapleftistPath,
) -> DsheapleftistPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistPath::copy(self : DsheapleftistPath) -> DsheapleftistPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistPath::fill(
  self : DsheapleftistPath,
  v : Double,
) -> DsheapleftistPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistPath::min(self : DsheapleftistPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistPath::max(self : DsheapleftistPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistPath::to_string(self : DsheapleftistPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_cluster_make(size : Int32) -> DsheapleftistCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistCluster::len(self : DsheapleftistCluster) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistCluster::get(
  self : DsheapleftistCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistCluster::set(
  self : DsheapleftistCluster,
  i : Int32,
  v : Double,
) -> DsheapleftistCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistCluster::sum(self : DsheapleftistCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistCluster::mean(self : DsheapleftistCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistCluster::scale(
  self : DsheapleftistCluster,
  f : Double,
) -> DsheapleftistCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistCluster::add(
  self : DsheapleftistCluster,
  other : DsheapleftistCluster,
) -> DsheapleftistCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistCluster::copy(
  self : DsheapleftistCluster,
) -> DsheapleftistCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistCluster::fill(
  self : DsheapleftistCluster,
  v : Double,
) -> DsheapleftistCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistCluster::min(self : DsheapleftistCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistCluster::max(self : DsheapleftistCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistCluster::to_string(self : DsheapleftistCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_model_make(size : Int32) -> DsheapleftistModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistModel::len(self : DsheapleftistModel) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistModel::get(self : DsheapleftistModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistModel::set(
  self : DsheapleftistModel,
  i : Int32,
  v : Double,
) -> DsheapleftistModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistModel::sum(self : DsheapleftistModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistModel::mean(self : DsheapleftistModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistModel::scale(
  self : DsheapleftistModel,
  f : Double,
) -> DsheapleftistModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistModel::add(
  self : DsheapleftistModel,
  other : DsheapleftistModel,
) -> DsheapleftistModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistModel::copy(
  self : DsheapleftistModel,
) -> DsheapleftistModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistModel::fill(
  self : DsheapleftistModel,
  v : Double,
) -> DsheapleftistModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistModel::min(self : DsheapleftistModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistModel::max(self : DsheapleftistModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistModel::to_string(self : DsheapleftistModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_layer_make(size : Int32) -> DsheapleftistLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistLayer::len(self : DsheapleftistLayer) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistLayer::get(self : DsheapleftistLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistLayer::set(
  self : DsheapleftistLayer,
  i : Int32,
  v : Double,
) -> DsheapleftistLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistLayer::sum(self : DsheapleftistLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistLayer::mean(self : DsheapleftistLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistLayer::scale(
  self : DsheapleftistLayer,
  f : Double,
) -> DsheapleftistLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistLayer::add(
  self : DsheapleftistLayer,
  other : DsheapleftistLayer,
) -> DsheapleftistLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistLayer::copy(
  self : DsheapleftistLayer,
) -> DsheapleftistLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistLayer::fill(
  self : DsheapleftistLayer,
  v : Double,
) -> DsheapleftistLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistLayer::min(self : DsheapleftistLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistLayer::max(self : DsheapleftistLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistLayer::to_string(self : DsheapleftistLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_buffer_make(size : Int32) -> DsheapleftistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistBuffer::len(self : DsheapleftistBuffer) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistBuffer::get(
  self : DsheapleftistBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistBuffer::set(
  self : DsheapleftistBuffer,
  i : Int32,
  v : Double,
) -> DsheapleftistBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistBuffer::sum(self : DsheapleftistBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistBuffer::mean(self : DsheapleftistBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistBuffer::scale(
  self : DsheapleftistBuffer,
  f : Double,
) -> DsheapleftistBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistBuffer::add(
  self : DsheapleftistBuffer,
  other : DsheapleftistBuffer,
) -> DsheapleftistBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistBuffer::copy(
  self : DsheapleftistBuffer,
) -> DsheapleftistBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistBuffer::fill(
  self : DsheapleftistBuffer,
  v : Double,
) -> DsheapleftistBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistBuffer::min(self : DsheapleftistBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistBuffer::max(self : DsheapleftistBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistBuffer::to_string(self : DsheapleftistBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_cursor_make(size : Int32) -> DsheapleftistCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistCursor::len(self : DsheapleftistCursor) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistCursor::get(
  self : DsheapleftistCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistCursor::set(
  self : DsheapleftistCursor,
  i : Int32,
  v : Double,
) -> DsheapleftistCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistCursor::sum(self : DsheapleftistCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistCursor::mean(self : DsheapleftistCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistCursor::scale(
  self : DsheapleftistCursor,
  f : Double,
) -> DsheapleftistCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistCursor::add(
  self : DsheapleftistCursor,
  other : DsheapleftistCursor,
) -> DsheapleftistCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistCursor::copy(
  self : DsheapleftistCursor,
) -> DsheapleftistCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistCursor::fill(
  self : DsheapleftistCursor,
  v : Double,
) -> DsheapleftistCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistCursor::min(self : DsheapleftistCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistCursor::max(self : DsheapleftistCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistCursor::to_string(self : DsheapleftistCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_view_make(size : Int32) -> DsheapleftistView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistView::len(self : DsheapleftistView) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistView::get(self : DsheapleftistView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistView::set(
  self : DsheapleftistView,
  i : Int32,
  v : Double,
) -> DsheapleftistView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistView::sum(self : DsheapleftistView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistView::mean(self : DsheapleftistView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistView::scale(
  self : DsheapleftistView,
  f : Double,
) -> DsheapleftistView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistView::add(
  self : DsheapleftistView,
  other : DsheapleftistView,
) -> DsheapleftistView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistView::copy(self : DsheapleftistView) -> DsheapleftistView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistView::fill(
  self : DsheapleftistView,
  v : Double,
) -> DsheapleftistView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistView::min(self : DsheapleftistView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistView::max(self : DsheapleftistView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistView::to_string(self : DsheapleftistView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_range_make(size : Int32) -> DsheapleftistRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistRange::len(self : DsheapleftistRange) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistRange::get(self : DsheapleftistRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistRange::set(
  self : DsheapleftistRange,
  i : Int32,
  v : Double,
) -> DsheapleftistRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistRange::sum(self : DsheapleftistRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistRange::mean(self : DsheapleftistRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistRange::scale(
  self : DsheapleftistRange,
  f : Double,
) -> DsheapleftistRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistRange::add(
  self : DsheapleftistRange,
  other : DsheapleftistRange,
) -> DsheapleftistRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistRange::copy(
  self : DsheapleftistRange,
) -> DsheapleftistRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistRange::fill(
  self : DsheapleftistRange,
  v : Double,
) -> DsheapleftistRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistRange::min(self : DsheapleftistRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistRange::max(self : DsheapleftistRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistRange::to_string(self : DsheapleftistRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsheapleftistSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_heap_leftist_slice_make(size : Int32) -> DsheapleftistSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsheapleftistSlice::len(self : DsheapleftistSlice) -> Int32 {
  self.size
}

///|
pub fn DsheapleftistSlice::get(self : DsheapleftistSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsheapleftistSlice::set(
  self : DsheapleftistSlice,
  i : Int32,
  v : Double,
) -> DsheapleftistSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistSlice::sum(self : DsheapleftistSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsheapleftistSlice::mean(self : DsheapleftistSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsheapleftistSlice::scale(
  self : DsheapleftistSlice,
  f : Double,
) -> DsheapleftistSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistSlice::add(
  self : DsheapleftistSlice,
  other : DsheapleftistSlice,
) -> DsheapleftistSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsheapleftistSlice::copy(
  self : DsheapleftistSlice,
) -> DsheapleftistSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistSlice::fill(
  self : DsheapleftistSlice,
  v : Double,
) -> DsheapleftistSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsheapleftistSlice::min(self : DsheapleftistSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsheapleftistSlice::max(self : DsheapleftistSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsheapleftistSlice::to_string(self : DsheapleftistSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
