///|
///===
/// extcore/sort_dist_lsd
pub(all) struct SortdistlsdPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn sort_dist_lsd_make_point(x : Double, y : Double) -> SortdistlsdPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn sort_dist_lsd_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SortdistlsdPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SortdistlsdPoint::x(self : SortdistlsdPoint) -> Double {
  self.x
}

///|
pub fn SortdistlsdPoint::y(self : SortdistlsdPoint) -> Double {
  self.y
}

///|
pub fn SortdistlsdPoint::z(self : SortdistlsdPoint) -> Double {
  self.z
}

///|
pub fn SortdistlsdPoint::label(self : SortdistlsdPoint) -> Int32 {
  self.label
}

///|
pub fn SortdistlsdPoint::dist(
  self : SortdistlsdPoint,
  other : SortdistlsdPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SortdistlsdPoint::add(
  self : SortdistlsdPoint,
  other : SortdistlsdPoint,
) -> SortdistlsdPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SortdistlsdPoint::sub(
  self : SortdistlsdPoint,
  other : SortdistlsdPoint,
) -> SortdistlsdPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SortdistlsdPoint::scale(
  self : SortdistlsdPoint,
  s : Double,
) -> SortdistlsdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SortdistlsdPoint::dot(
  self : SortdistlsdPoint,
  other : SortdistlsdPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SortdistlsdPoint::cross(
  self : SortdistlsdPoint,
  other : SortdistlsdPoint,
) -> SortdistlsdPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SortdistlsdPoint::norm(self : SortdistlsdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SortdistlsdPoint::normalize(self : SortdistlsdPoint) -> SortdistlsdPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortdistlsdPoint::negate(self : SortdistlsdPoint) -> SortdistlsdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SortdistlsdPoint::mid(
  self : SortdistlsdPoint,
  other : SortdistlsdPoint,
) -> SortdistlsdPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SortdistlsdPoint::lerp(
  self : SortdistlsdPoint,
  other : SortdistlsdPoint,
  t : Double,
) -> SortdistlsdPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SortdistlsdPoint::to_string(self : SortdistlsdPoint) -> String {
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
pub(all) struct SortdistlsdSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn sort_dist_lsd_make_series(
  vals : Array[Double],
  name : String,
) -> SortdistlsdSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SortdistlsdSeries::len(self : SortdistlsdSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn SortdistlsdSeries::sum(self : SortdistlsdSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SortdistlsdSeries::mean(self : SortdistlsdSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SortdistlsdSeries::min(self : SortdistlsdSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SortdistlsdSeries::max(self : SortdistlsdSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SortdistlsdSeries::range(self : SortdistlsdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SortdistlsdSeries::variance(self : SortdistlsdSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SortdistlsdSeries::std(self : SortdistlsdSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SortdistlsdSeries::median(self : SortdistlsdSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SortdistlsdSeries::scale(
  self : SortdistlsdSeries,
  f : Double,
) -> SortdistlsdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SortdistlsdSeries::add(
  self : SortdistlsdSeries,
  other : SortdistlsdSeries,
) -> SortdistlsdSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortdistlsdSeries::sub(
  self : SortdistlsdSeries,
  other : SortdistlsdSeries,
) -> SortdistlsdSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortdistlsdSeries::normalize(
  self : SortdistlsdSeries,
) -> SortdistlsdSeries {
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
pub fn SortdistlsdSeries::cumsum(self : SortdistlsdSeries) -> SortdistlsdSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SortdistlsdSeries::to_string(self : SortdistlsdSeries) -> String {
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
pub(all) struct SortdistlsdMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn sort_dist_lsd_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SortdistlsdMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn sort_dist_lsd_matrix_identity(n : Int32) -> SortdistlsdMatrix {
  let m = sort_dist_lsd_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SortdistlsdMatrix::get(
  self : SortdistlsdMatrix,
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
pub fn SortdistlsdMatrix::transpose(
  self : SortdistlsdMatrix,
) -> SortdistlsdMatrix {
  let result = sort_dist_lsd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SortdistlsdMatrix::add(
  self : SortdistlsdMatrix,
  other : SortdistlsdMatrix,
) -> SortdistlsdMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = sort_dist_lsd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SortdistlsdMatrix::scale(
  self : SortdistlsdMatrix,
  s : Double,
) -> SortdistlsdMatrix {
  let result = sort_dist_lsd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SortdistlsdMatrix::multiply(
  self : SortdistlsdMatrix,
  other : SortdistlsdMatrix,
) -> SortdistlsdMatrix {
  if self.cols != other.rows {
    return sort_dist_lsd_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = sort_dist_lsd_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SortdistlsdMatrix::trace(self : SortdistlsdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SortdistlsdMatrix::det(self : SortdistlsdMatrix) -> Double {
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
pub fn SortdistlsdMatrix::norm(self : SortdistlsdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn SortdistlsdMatrix::to_string(self : SortdistlsdMatrix) -> String {
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
pub(all) struct SortdistlsdVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn sort_dist_lsd_make_vector(comps : Array[Double]) -> SortdistlsdVector {
  { comps, dim: comps.length(), }
}

///|
pub fn sort_dist_lsd_vector_zero(dim : Int32) -> SortdistlsdVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SortdistlsdVector::add(
  self : SortdistlsdVector,
  other : SortdistlsdVector,
) -> SortdistlsdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortdistlsdVector::sub(
  self : SortdistlsdVector,
  other : SortdistlsdVector,
) -> SortdistlsdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortdistlsdVector::scale(
  self : SortdistlsdVector,
  s : Double,
) -> SortdistlsdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SortdistlsdVector::dot(
  self : SortdistlsdVector,
  other : SortdistlsdVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SortdistlsdVector::norm(self : SortdistlsdVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SortdistlsdVector::normalize(
  self : SortdistlsdVector,
) -> SortdistlsdVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortdistlsdVector::dist(
  self : SortdistlsdVector,
  other : SortdistlsdVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SortdistlsdVector::to_string(self : SortdistlsdVector) -> String {
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
pub(all) struct SortdistlsdFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_frame_make(size : Int32) -> SortdistlsdFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdFrame::len(self : SortdistlsdFrame) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdFrame::get(self : SortdistlsdFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdFrame::set(
  self : SortdistlsdFrame,
  i : Int32,
  v : Double,
) -> SortdistlsdFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdFrame::sum(self : SortdistlsdFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdFrame::mean(self : SortdistlsdFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdFrame::scale(
  self : SortdistlsdFrame,
  f : Double,
) -> SortdistlsdFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdFrame::add(
  self : SortdistlsdFrame,
  other : SortdistlsdFrame,
) -> SortdistlsdFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdFrame::copy(self : SortdistlsdFrame) -> SortdistlsdFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdFrame::fill(
  self : SortdistlsdFrame,
  v : Double,
) -> SortdistlsdFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdFrame::min(self : SortdistlsdFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdFrame::max(self : SortdistlsdFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdFrame::to_string(self : SortdistlsdFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_table_make(size : Int32) -> SortdistlsdTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdTable::len(self : SortdistlsdTable) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdTable::get(self : SortdistlsdTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdTable::set(
  self : SortdistlsdTable,
  i : Int32,
  v : Double,
) -> SortdistlsdTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdTable::sum(self : SortdistlsdTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdTable::mean(self : SortdistlsdTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdTable::scale(
  self : SortdistlsdTable,
  f : Double,
) -> SortdistlsdTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdTable::add(
  self : SortdistlsdTable,
  other : SortdistlsdTable,
) -> SortdistlsdTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdTable::copy(self : SortdistlsdTable) -> SortdistlsdTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdTable::fill(
  self : SortdistlsdTable,
  v : Double,
) -> SortdistlsdTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdTable::min(self : SortdistlsdTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdTable::max(self : SortdistlsdTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdTable::to_string(self : SortdistlsdTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_graphn_make(size : Int32) -> SortdistlsdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdGraphN::len(self : SortdistlsdGraphN) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdGraphN::get(self : SortdistlsdGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdGraphN::set(
  self : SortdistlsdGraphN,
  i : Int32,
  v : Double,
) -> SortdistlsdGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdGraphN::sum(self : SortdistlsdGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdGraphN::mean(self : SortdistlsdGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdGraphN::scale(
  self : SortdistlsdGraphN,
  f : Double,
) -> SortdistlsdGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdGraphN::add(
  self : SortdistlsdGraphN,
  other : SortdistlsdGraphN,
) -> SortdistlsdGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdGraphN::copy(self : SortdistlsdGraphN) -> SortdistlsdGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdGraphN::fill(
  self : SortdistlsdGraphN,
  v : Double,
) -> SortdistlsdGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdGraphN::min(self : SortdistlsdGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdGraphN::max(self : SortdistlsdGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdGraphN::to_string(self : SortdistlsdGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_node_make(size : Int32) -> SortdistlsdNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdNode::len(self : SortdistlsdNode) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdNode::get(self : SortdistlsdNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdNode::set(
  self : SortdistlsdNode,
  i : Int32,
  v : Double,
) -> SortdistlsdNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdNode::sum(self : SortdistlsdNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdNode::mean(self : SortdistlsdNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdNode::scale(
  self : SortdistlsdNode,
  f : Double,
) -> SortdistlsdNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdNode::add(
  self : SortdistlsdNode,
  other : SortdistlsdNode,
) -> SortdistlsdNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdNode::copy(self : SortdistlsdNode) -> SortdistlsdNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdNode::fill(
  self : SortdistlsdNode,
  v : Double,
) -> SortdistlsdNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdNode::min(self : SortdistlsdNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdNode::max(self : SortdistlsdNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdNode::to_string(self : SortdistlsdNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_edge_make(size : Int32) -> SortdistlsdEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdEdge::len(self : SortdistlsdEdge) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdEdge::get(self : SortdistlsdEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdEdge::set(
  self : SortdistlsdEdge,
  i : Int32,
  v : Double,
) -> SortdistlsdEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdEdge::sum(self : SortdistlsdEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdEdge::mean(self : SortdistlsdEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdEdge::scale(
  self : SortdistlsdEdge,
  f : Double,
) -> SortdistlsdEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdEdge::add(
  self : SortdistlsdEdge,
  other : SortdistlsdEdge,
) -> SortdistlsdEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdEdge::copy(self : SortdistlsdEdge) -> SortdistlsdEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdEdge::fill(
  self : SortdistlsdEdge,
  v : Double,
) -> SortdistlsdEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdEdge::min(self : SortdistlsdEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdEdge::max(self : SortdistlsdEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdEdge::to_string(self : SortdistlsdEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_path_make(size : Int32) -> SortdistlsdPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdPath::len(self : SortdistlsdPath) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdPath::get(self : SortdistlsdPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdPath::set(
  self : SortdistlsdPath,
  i : Int32,
  v : Double,
) -> SortdistlsdPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdPath::sum(self : SortdistlsdPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdPath::mean(self : SortdistlsdPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdPath::scale(
  self : SortdistlsdPath,
  f : Double,
) -> SortdistlsdPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdPath::add(
  self : SortdistlsdPath,
  other : SortdistlsdPath,
) -> SortdistlsdPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdPath::copy(self : SortdistlsdPath) -> SortdistlsdPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdPath::fill(
  self : SortdistlsdPath,
  v : Double,
) -> SortdistlsdPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdPath::min(self : SortdistlsdPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdPath::max(self : SortdistlsdPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdPath::to_string(self : SortdistlsdPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_cluster_make(size : Int32) -> SortdistlsdCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdCluster::len(self : SortdistlsdCluster) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdCluster::get(self : SortdistlsdCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdCluster::set(
  self : SortdistlsdCluster,
  i : Int32,
  v : Double,
) -> SortdistlsdCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdCluster::sum(self : SortdistlsdCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdCluster::mean(self : SortdistlsdCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdCluster::scale(
  self : SortdistlsdCluster,
  f : Double,
) -> SortdistlsdCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdCluster::add(
  self : SortdistlsdCluster,
  other : SortdistlsdCluster,
) -> SortdistlsdCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdCluster::copy(
  self : SortdistlsdCluster,
) -> SortdistlsdCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdCluster::fill(
  self : SortdistlsdCluster,
  v : Double,
) -> SortdistlsdCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdCluster::min(self : SortdistlsdCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdCluster::max(self : SortdistlsdCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdCluster::to_string(self : SortdistlsdCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_model_make(size : Int32) -> SortdistlsdModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdModel::len(self : SortdistlsdModel) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdModel::get(self : SortdistlsdModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdModel::set(
  self : SortdistlsdModel,
  i : Int32,
  v : Double,
) -> SortdistlsdModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdModel::sum(self : SortdistlsdModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdModel::mean(self : SortdistlsdModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdModel::scale(
  self : SortdistlsdModel,
  f : Double,
) -> SortdistlsdModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdModel::add(
  self : SortdistlsdModel,
  other : SortdistlsdModel,
) -> SortdistlsdModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdModel::copy(self : SortdistlsdModel) -> SortdistlsdModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdModel::fill(
  self : SortdistlsdModel,
  v : Double,
) -> SortdistlsdModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdModel::min(self : SortdistlsdModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdModel::max(self : SortdistlsdModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdModel::to_string(self : SortdistlsdModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_layer_make(size : Int32) -> SortdistlsdLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdLayer::len(self : SortdistlsdLayer) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdLayer::get(self : SortdistlsdLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdLayer::set(
  self : SortdistlsdLayer,
  i : Int32,
  v : Double,
) -> SortdistlsdLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdLayer::sum(self : SortdistlsdLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdLayer::mean(self : SortdistlsdLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdLayer::scale(
  self : SortdistlsdLayer,
  f : Double,
) -> SortdistlsdLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdLayer::add(
  self : SortdistlsdLayer,
  other : SortdistlsdLayer,
) -> SortdistlsdLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdLayer::copy(self : SortdistlsdLayer) -> SortdistlsdLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdLayer::fill(
  self : SortdistlsdLayer,
  v : Double,
) -> SortdistlsdLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdLayer::min(self : SortdistlsdLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdLayer::max(self : SortdistlsdLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdLayer::to_string(self : SortdistlsdLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_buffer_make(size : Int32) -> SortdistlsdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdBuffer::len(self : SortdistlsdBuffer) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdBuffer::get(self : SortdistlsdBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdBuffer::set(
  self : SortdistlsdBuffer,
  i : Int32,
  v : Double,
) -> SortdistlsdBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdBuffer::sum(self : SortdistlsdBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdBuffer::mean(self : SortdistlsdBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdBuffer::scale(
  self : SortdistlsdBuffer,
  f : Double,
) -> SortdistlsdBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdBuffer::add(
  self : SortdistlsdBuffer,
  other : SortdistlsdBuffer,
) -> SortdistlsdBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdBuffer::copy(self : SortdistlsdBuffer) -> SortdistlsdBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdBuffer::fill(
  self : SortdistlsdBuffer,
  v : Double,
) -> SortdistlsdBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdBuffer::min(self : SortdistlsdBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdBuffer::max(self : SortdistlsdBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdBuffer::to_string(self : SortdistlsdBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_cursor_make(size : Int32) -> SortdistlsdCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdCursor::len(self : SortdistlsdCursor) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdCursor::get(self : SortdistlsdCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdCursor::set(
  self : SortdistlsdCursor,
  i : Int32,
  v : Double,
) -> SortdistlsdCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdCursor::sum(self : SortdistlsdCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdCursor::mean(self : SortdistlsdCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdCursor::scale(
  self : SortdistlsdCursor,
  f : Double,
) -> SortdistlsdCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdCursor::add(
  self : SortdistlsdCursor,
  other : SortdistlsdCursor,
) -> SortdistlsdCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdCursor::copy(self : SortdistlsdCursor) -> SortdistlsdCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdCursor::fill(
  self : SortdistlsdCursor,
  v : Double,
) -> SortdistlsdCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdCursor::min(self : SortdistlsdCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdCursor::max(self : SortdistlsdCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdCursor::to_string(self : SortdistlsdCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_view_make(size : Int32) -> SortdistlsdView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdView::len(self : SortdistlsdView) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdView::get(self : SortdistlsdView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdView::set(
  self : SortdistlsdView,
  i : Int32,
  v : Double,
) -> SortdistlsdView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdView::sum(self : SortdistlsdView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdView::mean(self : SortdistlsdView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdView::scale(
  self : SortdistlsdView,
  f : Double,
) -> SortdistlsdView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdView::add(
  self : SortdistlsdView,
  other : SortdistlsdView,
) -> SortdistlsdView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdView::copy(self : SortdistlsdView) -> SortdistlsdView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdView::fill(
  self : SortdistlsdView,
  v : Double,
) -> SortdistlsdView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdView::min(self : SortdistlsdView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdView::max(self : SortdistlsdView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdView::to_string(self : SortdistlsdView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_range_make(size : Int32) -> SortdistlsdRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdRange::len(self : SortdistlsdRange) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdRange::get(self : SortdistlsdRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdRange::set(
  self : SortdistlsdRange,
  i : Int32,
  v : Double,
) -> SortdistlsdRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdRange::sum(self : SortdistlsdRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdRange::mean(self : SortdistlsdRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdRange::scale(
  self : SortdistlsdRange,
  f : Double,
) -> SortdistlsdRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdRange::add(
  self : SortdistlsdRange,
  other : SortdistlsdRange,
) -> SortdistlsdRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdRange::copy(self : SortdistlsdRange) -> SortdistlsdRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdRange::fill(
  self : SortdistlsdRange,
  v : Double,
) -> SortdistlsdRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdRange::min(self : SortdistlsdRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdRange::max(self : SortdistlsdRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdRange::to_string(self : SortdistlsdRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistlsdSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_lsd_slice_make(size : Int32) -> SortdistlsdSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistlsdSlice::len(self : SortdistlsdSlice) -> Int32 {
  self.size
}

///|
pub fn SortdistlsdSlice::get(self : SortdistlsdSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistlsdSlice::set(
  self : SortdistlsdSlice,
  i : Int32,
  v : Double,
) -> SortdistlsdSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdSlice::sum(self : SortdistlsdSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistlsdSlice::mean(self : SortdistlsdSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistlsdSlice::scale(
  self : SortdistlsdSlice,
  f : Double,
) -> SortdistlsdSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdSlice::add(
  self : SortdistlsdSlice,
  other : SortdistlsdSlice,
) -> SortdistlsdSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistlsdSlice::copy(self : SortdistlsdSlice) -> SortdistlsdSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdSlice::fill(
  self : SortdistlsdSlice,
  v : Double,
) -> SortdistlsdSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistlsdSlice::min(self : SortdistlsdSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistlsdSlice::max(self : SortdistlsdSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistlsdSlice::to_string(self : SortdistlsdSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
