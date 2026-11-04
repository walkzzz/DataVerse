///|
///===
/// extcore/sort_dist_inplace
pub(all) struct SortdistinplacePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn sort_dist_inplace_make_point(
  x : Double,
  y : Double,
) -> SortdistinplacePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn sort_dist_inplace_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SortdistinplacePoint {
  { x, y, z, label: 0, }
}

///|
pub fn SortdistinplacePoint::x(self : SortdistinplacePoint) -> Double {
  self.x
}

///|
pub fn SortdistinplacePoint::y(self : SortdistinplacePoint) -> Double {
  self.y
}

///|
pub fn SortdistinplacePoint::z(self : SortdistinplacePoint) -> Double {
  self.z
}

///|
pub fn SortdistinplacePoint::label(self : SortdistinplacePoint) -> Int32 {
  self.label
}

///|
pub fn SortdistinplacePoint::dist(
  self : SortdistinplacePoint,
  other : SortdistinplacePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SortdistinplacePoint::add(
  self : SortdistinplacePoint,
  other : SortdistinplacePoint,
) -> SortdistinplacePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SortdistinplacePoint::sub(
  self : SortdistinplacePoint,
  other : SortdistinplacePoint,
) -> SortdistinplacePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SortdistinplacePoint::scale(
  self : SortdistinplacePoint,
  s : Double,
) -> SortdistinplacePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SortdistinplacePoint::dot(
  self : SortdistinplacePoint,
  other : SortdistinplacePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SortdistinplacePoint::cross(
  self : SortdistinplacePoint,
  other : SortdistinplacePoint,
) -> SortdistinplacePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SortdistinplacePoint::norm(self : SortdistinplacePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SortdistinplacePoint::normalize(
  self : SortdistinplacePoint,
) -> SortdistinplacePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortdistinplacePoint::negate(
  self : SortdistinplacePoint,
) -> SortdistinplacePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SortdistinplacePoint::mid(
  self : SortdistinplacePoint,
  other : SortdistinplacePoint,
) -> SortdistinplacePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SortdistinplacePoint::lerp(
  self : SortdistinplacePoint,
  other : SortdistinplacePoint,
  t : Double,
) -> SortdistinplacePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SortdistinplacePoint::to_string(self : SortdistinplacePoint) -> String {
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
pub(all) struct SortdistinplaceSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn sort_dist_inplace_make_series(
  vals : Array[Double],
  name : String,
) -> SortdistinplaceSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SortdistinplaceSeries::len(self : SortdistinplaceSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn SortdistinplaceSeries::sum(self : SortdistinplaceSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SortdistinplaceSeries::mean(self : SortdistinplaceSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SortdistinplaceSeries::min(self : SortdistinplaceSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SortdistinplaceSeries::max(self : SortdistinplaceSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SortdistinplaceSeries::range(self : SortdistinplaceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SortdistinplaceSeries::variance(self : SortdistinplaceSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SortdistinplaceSeries::std(self : SortdistinplaceSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SortdistinplaceSeries::median(self : SortdistinplaceSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SortdistinplaceSeries::scale(
  self : SortdistinplaceSeries,
  f : Double,
) -> SortdistinplaceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SortdistinplaceSeries::add(
  self : SortdistinplaceSeries,
  other : SortdistinplaceSeries,
) -> SortdistinplaceSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortdistinplaceSeries::sub(
  self : SortdistinplaceSeries,
  other : SortdistinplaceSeries,
) -> SortdistinplaceSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortdistinplaceSeries::normalize(
  self : SortdistinplaceSeries,
) -> SortdistinplaceSeries {
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
pub fn SortdistinplaceSeries::cumsum(
  self : SortdistinplaceSeries,
) -> SortdistinplaceSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SortdistinplaceSeries::to_string(self : SortdistinplaceSeries) -> String {
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
pub(all) struct SortdistinplaceMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn sort_dist_inplace_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SortdistinplaceMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn sort_dist_inplace_matrix_identity(n : Int32) -> SortdistinplaceMatrix {
  let m = sort_dist_inplace_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SortdistinplaceMatrix::get(
  self : SortdistinplaceMatrix,
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
pub fn SortdistinplaceMatrix::transpose(
  self : SortdistinplaceMatrix,
) -> SortdistinplaceMatrix {
  let result = sort_dist_inplace_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SortdistinplaceMatrix::add(
  self : SortdistinplaceMatrix,
  other : SortdistinplaceMatrix,
) -> SortdistinplaceMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = sort_dist_inplace_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SortdistinplaceMatrix::scale(
  self : SortdistinplaceMatrix,
  s : Double,
) -> SortdistinplaceMatrix {
  let result = sort_dist_inplace_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SortdistinplaceMatrix::multiply(
  self : SortdistinplaceMatrix,
  other : SortdistinplaceMatrix,
) -> SortdistinplaceMatrix {
  if self.cols != other.rows {
    return sort_dist_inplace_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = sort_dist_inplace_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SortdistinplaceMatrix::trace(self : SortdistinplaceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SortdistinplaceMatrix::det(self : SortdistinplaceMatrix) -> Double {
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
pub fn SortdistinplaceMatrix::norm(self : SortdistinplaceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn SortdistinplaceMatrix::to_string(self : SortdistinplaceMatrix) -> String {
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
pub(all) struct SortdistinplaceVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn sort_dist_inplace_make_vector(
  comps : Array[Double],
) -> SortdistinplaceVector {
  { comps, dim: comps.length(), }
}

///|
pub fn sort_dist_inplace_vector_zero(dim : Int32) -> SortdistinplaceVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SortdistinplaceVector::add(
  self : SortdistinplaceVector,
  other : SortdistinplaceVector,
) -> SortdistinplaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortdistinplaceVector::sub(
  self : SortdistinplaceVector,
  other : SortdistinplaceVector,
) -> SortdistinplaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortdistinplaceVector::scale(
  self : SortdistinplaceVector,
  s : Double,
) -> SortdistinplaceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SortdistinplaceVector::dot(
  self : SortdistinplaceVector,
  other : SortdistinplaceVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SortdistinplaceVector::norm(self : SortdistinplaceVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SortdistinplaceVector::normalize(
  self : SortdistinplaceVector,
) -> SortdistinplaceVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortdistinplaceVector::dist(
  self : SortdistinplaceVector,
  other : SortdistinplaceVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SortdistinplaceVector::to_string(self : SortdistinplaceVector) -> String {
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
pub(all) struct SortdistinplaceFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_frame_make(size : Int32) -> SortdistinplaceFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceFrame::len(self : SortdistinplaceFrame) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceFrame::get(
  self : SortdistinplaceFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceFrame::set(
  self : SortdistinplaceFrame,
  i : Int32,
  v : Double,
) -> SortdistinplaceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceFrame::sum(self : SortdistinplaceFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceFrame::mean(self : SortdistinplaceFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceFrame::scale(
  self : SortdistinplaceFrame,
  f : Double,
) -> SortdistinplaceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceFrame::add(
  self : SortdistinplaceFrame,
  other : SortdistinplaceFrame,
) -> SortdistinplaceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceFrame::copy(
  self : SortdistinplaceFrame,
) -> SortdistinplaceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceFrame::fill(
  self : SortdistinplaceFrame,
  v : Double,
) -> SortdistinplaceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceFrame::min(self : SortdistinplaceFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceFrame::max(self : SortdistinplaceFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceFrame::to_string(self : SortdistinplaceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_table_make(size : Int32) -> SortdistinplaceTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceTable::len(self : SortdistinplaceTable) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceTable::get(
  self : SortdistinplaceTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceTable::set(
  self : SortdistinplaceTable,
  i : Int32,
  v : Double,
) -> SortdistinplaceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceTable::sum(self : SortdistinplaceTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceTable::mean(self : SortdistinplaceTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceTable::scale(
  self : SortdistinplaceTable,
  f : Double,
) -> SortdistinplaceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceTable::add(
  self : SortdistinplaceTable,
  other : SortdistinplaceTable,
) -> SortdistinplaceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceTable::copy(
  self : SortdistinplaceTable,
) -> SortdistinplaceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceTable::fill(
  self : SortdistinplaceTable,
  v : Double,
) -> SortdistinplaceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceTable::min(self : SortdistinplaceTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceTable::max(self : SortdistinplaceTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceTable::to_string(self : SortdistinplaceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_graphn_make(size : Int32) -> SortdistinplaceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceGraphN::len(self : SortdistinplaceGraphN) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceGraphN::get(
  self : SortdistinplaceGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceGraphN::set(
  self : SortdistinplaceGraphN,
  i : Int32,
  v : Double,
) -> SortdistinplaceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceGraphN::sum(self : SortdistinplaceGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceGraphN::mean(self : SortdistinplaceGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceGraphN::scale(
  self : SortdistinplaceGraphN,
  f : Double,
) -> SortdistinplaceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceGraphN::add(
  self : SortdistinplaceGraphN,
  other : SortdistinplaceGraphN,
) -> SortdistinplaceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceGraphN::copy(
  self : SortdistinplaceGraphN,
) -> SortdistinplaceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceGraphN::fill(
  self : SortdistinplaceGraphN,
  v : Double,
) -> SortdistinplaceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceGraphN::min(self : SortdistinplaceGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceGraphN::max(self : SortdistinplaceGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceGraphN::to_string(self : SortdistinplaceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_node_make(size : Int32) -> SortdistinplaceNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceNode::len(self : SortdistinplaceNode) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceNode::get(
  self : SortdistinplaceNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceNode::set(
  self : SortdistinplaceNode,
  i : Int32,
  v : Double,
) -> SortdistinplaceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceNode::sum(self : SortdistinplaceNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceNode::mean(self : SortdistinplaceNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceNode::scale(
  self : SortdistinplaceNode,
  f : Double,
) -> SortdistinplaceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceNode::add(
  self : SortdistinplaceNode,
  other : SortdistinplaceNode,
) -> SortdistinplaceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceNode::copy(
  self : SortdistinplaceNode,
) -> SortdistinplaceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceNode::fill(
  self : SortdistinplaceNode,
  v : Double,
) -> SortdistinplaceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceNode::min(self : SortdistinplaceNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceNode::max(self : SortdistinplaceNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceNode::to_string(self : SortdistinplaceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_edge_make(size : Int32) -> SortdistinplaceEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceEdge::len(self : SortdistinplaceEdge) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceEdge::get(
  self : SortdistinplaceEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceEdge::set(
  self : SortdistinplaceEdge,
  i : Int32,
  v : Double,
) -> SortdistinplaceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceEdge::sum(self : SortdistinplaceEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceEdge::mean(self : SortdistinplaceEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceEdge::scale(
  self : SortdistinplaceEdge,
  f : Double,
) -> SortdistinplaceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceEdge::add(
  self : SortdistinplaceEdge,
  other : SortdistinplaceEdge,
) -> SortdistinplaceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceEdge::copy(
  self : SortdistinplaceEdge,
) -> SortdistinplaceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceEdge::fill(
  self : SortdistinplaceEdge,
  v : Double,
) -> SortdistinplaceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceEdge::min(self : SortdistinplaceEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceEdge::max(self : SortdistinplaceEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceEdge::to_string(self : SortdistinplaceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplacePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_path_make(size : Int32) -> SortdistinplacePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplacePath::len(self : SortdistinplacePath) -> Int32 {
  self.size
}

///|
pub fn SortdistinplacePath::get(
  self : SortdistinplacePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplacePath::set(
  self : SortdistinplacePath,
  i : Int32,
  v : Double,
) -> SortdistinplacePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplacePath::sum(self : SortdistinplacePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplacePath::mean(self : SortdistinplacePath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplacePath::scale(
  self : SortdistinplacePath,
  f : Double,
) -> SortdistinplacePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplacePath::add(
  self : SortdistinplacePath,
  other : SortdistinplacePath,
) -> SortdistinplacePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplacePath::copy(
  self : SortdistinplacePath,
) -> SortdistinplacePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplacePath::fill(
  self : SortdistinplacePath,
  v : Double,
) -> SortdistinplacePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplacePath::min(self : SortdistinplacePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplacePath::max(self : SortdistinplacePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplacePath::to_string(self : SortdistinplacePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_cluster_make(size : Int32) -> SortdistinplaceCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceCluster::len(self : SortdistinplaceCluster) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceCluster::get(
  self : SortdistinplaceCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceCluster::set(
  self : SortdistinplaceCluster,
  i : Int32,
  v : Double,
) -> SortdistinplaceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceCluster::sum(self : SortdistinplaceCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceCluster::mean(self : SortdistinplaceCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceCluster::scale(
  self : SortdistinplaceCluster,
  f : Double,
) -> SortdistinplaceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceCluster::add(
  self : SortdistinplaceCluster,
  other : SortdistinplaceCluster,
) -> SortdistinplaceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceCluster::copy(
  self : SortdistinplaceCluster,
) -> SortdistinplaceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceCluster::fill(
  self : SortdistinplaceCluster,
  v : Double,
) -> SortdistinplaceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceCluster::min(self : SortdistinplaceCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceCluster::max(self : SortdistinplaceCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceCluster::to_string(
  self : SortdistinplaceCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_model_make(size : Int32) -> SortdistinplaceModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceModel::len(self : SortdistinplaceModel) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceModel::get(
  self : SortdistinplaceModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceModel::set(
  self : SortdistinplaceModel,
  i : Int32,
  v : Double,
) -> SortdistinplaceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceModel::sum(self : SortdistinplaceModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceModel::mean(self : SortdistinplaceModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceModel::scale(
  self : SortdistinplaceModel,
  f : Double,
) -> SortdistinplaceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceModel::add(
  self : SortdistinplaceModel,
  other : SortdistinplaceModel,
) -> SortdistinplaceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceModel::copy(
  self : SortdistinplaceModel,
) -> SortdistinplaceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceModel::fill(
  self : SortdistinplaceModel,
  v : Double,
) -> SortdistinplaceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceModel::min(self : SortdistinplaceModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceModel::max(self : SortdistinplaceModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceModel::to_string(self : SortdistinplaceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_layer_make(size : Int32) -> SortdistinplaceLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceLayer::len(self : SortdistinplaceLayer) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceLayer::get(
  self : SortdistinplaceLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceLayer::set(
  self : SortdistinplaceLayer,
  i : Int32,
  v : Double,
) -> SortdistinplaceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceLayer::sum(self : SortdistinplaceLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceLayer::mean(self : SortdistinplaceLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceLayer::scale(
  self : SortdistinplaceLayer,
  f : Double,
) -> SortdistinplaceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceLayer::add(
  self : SortdistinplaceLayer,
  other : SortdistinplaceLayer,
) -> SortdistinplaceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceLayer::copy(
  self : SortdistinplaceLayer,
) -> SortdistinplaceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceLayer::fill(
  self : SortdistinplaceLayer,
  v : Double,
) -> SortdistinplaceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceLayer::min(self : SortdistinplaceLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceLayer::max(self : SortdistinplaceLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceLayer::to_string(self : SortdistinplaceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_buffer_make(size : Int32) -> SortdistinplaceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceBuffer::len(self : SortdistinplaceBuffer) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceBuffer::get(
  self : SortdistinplaceBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceBuffer::set(
  self : SortdistinplaceBuffer,
  i : Int32,
  v : Double,
) -> SortdistinplaceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceBuffer::sum(self : SortdistinplaceBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceBuffer::mean(self : SortdistinplaceBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceBuffer::scale(
  self : SortdistinplaceBuffer,
  f : Double,
) -> SortdistinplaceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceBuffer::add(
  self : SortdistinplaceBuffer,
  other : SortdistinplaceBuffer,
) -> SortdistinplaceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceBuffer::copy(
  self : SortdistinplaceBuffer,
) -> SortdistinplaceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceBuffer::fill(
  self : SortdistinplaceBuffer,
  v : Double,
) -> SortdistinplaceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceBuffer::min(self : SortdistinplaceBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceBuffer::max(self : SortdistinplaceBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceBuffer::to_string(self : SortdistinplaceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_cursor_make(size : Int32) -> SortdistinplaceCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceCursor::len(self : SortdistinplaceCursor) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceCursor::get(
  self : SortdistinplaceCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceCursor::set(
  self : SortdistinplaceCursor,
  i : Int32,
  v : Double,
) -> SortdistinplaceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceCursor::sum(self : SortdistinplaceCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceCursor::mean(self : SortdistinplaceCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceCursor::scale(
  self : SortdistinplaceCursor,
  f : Double,
) -> SortdistinplaceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceCursor::add(
  self : SortdistinplaceCursor,
  other : SortdistinplaceCursor,
) -> SortdistinplaceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceCursor::copy(
  self : SortdistinplaceCursor,
) -> SortdistinplaceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceCursor::fill(
  self : SortdistinplaceCursor,
  v : Double,
) -> SortdistinplaceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceCursor::min(self : SortdistinplaceCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceCursor::max(self : SortdistinplaceCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceCursor::to_string(self : SortdistinplaceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_view_make(size : Int32) -> SortdistinplaceView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceView::len(self : SortdistinplaceView) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceView::get(
  self : SortdistinplaceView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceView::set(
  self : SortdistinplaceView,
  i : Int32,
  v : Double,
) -> SortdistinplaceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceView::sum(self : SortdistinplaceView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceView::mean(self : SortdistinplaceView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceView::scale(
  self : SortdistinplaceView,
  f : Double,
) -> SortdistinplaceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceView::add(
  self : SortdistinplaceView,
  other : SortdistinplaceView,
) -> SortdistinplaceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceView::copy(
  self : SortdistinplaceView,
) -> SortdistinplaceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceView::fill(
  self : SortdistinplaceView,
  v : Double,
) -> SortdistinplaceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceView::min(self : SortdistinplaceView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceView::max(self : SortdistinplaceView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceView::to_string(self : SortdistinplaceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_range_make(size : Int32) -> SortdistinplaceRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceRange::len(self : SortdistinplaceRange) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceRange::get(
  self : SortdistinplaceRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceRange::set(
  self : SortdistinplaceRange,
  i : Int32,
  v : Double,
) -> SortdistinplaceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceRange::sum(self : SortdistinplaceRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceRange::mean(self : SortdistinplaceRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceRange::scale(
  self : SortdistinplaceRange,
  f : Double,
) -> SortdistinplaceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceRange::add(
  self : SortdistinplaceRange,
  other : SortdistinplaceRange,
) -> SortdistinplaceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceRange::copy(
  self : SortdistinplaceRange,
) -> SortdistinplaceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceRange::fill(
  self : SortdistinplaceRange,
  v : Double,
) -> SortdistinplaceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceRange::min(self : SortdistinplaceRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceRange::max(self : SortdistinplaceRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceRange::to_string(self : SortdistinplaceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistinplaceSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_inplace_slice_make(size : Int32) -> SortdistinplaceSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistinplaceSlice::len(self : SortdistinplaceSlice) -> Int32 {
  self.size
}

///|
pub fn SortdistinplaceSlice::get(
  self : SortdistinplaceSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistinplaceSlice::set(
  self : SortdistinplaceSlice,
  i : Int32,
  v : Double,
) -> SortdistinplaceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceSlice::sum(self : SortdistinplaceSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistinplaceSlice::mean(self : SortdistinplaceSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistinplaceSlice::scale(
  self : SortdistinplaceSlice,
  f : Double,
) -> SortdistinplaceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceSlice::add(
  self : SortdistinplaceSlice,
  other : SortdistinplaceSlice,
) -> SortdistinplaceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistinplaceSlice::copy(
  self : SortdistinplaceSlice,
) -> SortdistinplaceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceSlice::fill(
  self : SortdistinplaceSlice,
  v : Double,
) -> SortdistinplaceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistinplaceSlice::min(self : SortdistinplaceSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistinplaceSlice::max(self : SortdistinplaceSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistinplaceSlice::to_string(self : SortdistinplaceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
