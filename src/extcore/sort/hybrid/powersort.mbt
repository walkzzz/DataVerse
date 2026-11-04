///|
///===
/// extcore/sort_hybrid_powersort
pub(all) struct SorthybridpowersortPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn sort_hybrid_powersort_make_point(
  x : Double,
  y : Double,
) -> SorthybridpowersortPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn sort_hybrid_powersort_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SorthybridpowersortPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SorthybridpowersortPoint::x(self : SorthybridpowersortPoint) -> Double {
  self.x
}

///|
pub fn SorthybridpowersortPoint::y(self : SorthybridpowersortPoint) -> Double {
  self.y
}

///|
pub fn SorthybridpowersortPoint::z(self : SorthybridpowersortPoint) -> Double {
  self.z
}

///|
pub fn SorthybridpowersortPoint::label(
  self : SorthybridpowersortPoint,
) -> Int32 {
  self.label
}

///|
pub fn SorthybridpowersortPoint::dist(
  self : SorthybridpowersortPoint,
  other : SorthybridpowersortPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SorthybridpowersortPoint::add(
  self : SorthybridpowersortPoint,
  other : SorthybridpowersortPoint,
) -> SorthybridpowersortPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SorthybridpowersortPoint::sub(
  self : SorthybridpowersortPoint,
  other : SorthybridpowersortPoint,
) -> SorthybridpowersortPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SorthybridpowersortPoint::scale(
  self : SorthybridpowersortPoint,
  s : Double,
) -> SorthybridpowersortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SorthybridpowersortPoint::dot(
  self : SorthybridpowersortPoint,
  other : SorthybridpowersortPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SorthybridpowersortPoint::cross(
  self : SorthybridpowersortPoint,
  other : SorthybridpowersortPoint,
) -> SorthybridpowersortPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SorthybridpowersortPoint::norm(
  self : SorthybridpowersortPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SorthybridpowersortPoint::normalize(
  self : SorthybridpowersortPoint,
) -> SorthybridpowersortPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SorthybridpowersortPoint::negate(
  self : SorthybridpowersortPoint,
) -> SorthybridpowersortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SorthybridpowersortPoint::mid(
  self : SorthybridpowersortPoint,
  other : SorthybridpowersortPoint,
) -> SorthybridpowersortPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SorthybridpowersortPoint::lerp(
  self : SorthybridpowersortPoint,
  other : SorthybridpowersortPoint,
  t : Double,
) -> SorthybridpowersortPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SorthybridpowersortPoint::to_string(
  self : SorthybridpowersortPoint,
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
pub(all) struct SorthybridpowersortSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn sort_hybrid_powersort_make_series(
  vals : Array[Double],
  name : String,
) -> SorthybridpowersortSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SorthybridpowersortSeries::len(
  self : SorthybridpowersortSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn SorthybridpowersortSeries::sum(
  self : SorthybridpowersortSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SorthybridpowersortSeries::mean(
  self : SorthybridpowersortSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SorthybridpowersortSeries::min(
  self : SorthybridpowersortSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SorthybridpowersortSeries::max(
  self : SorthybridpowersortSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SorthybridpowersortSeries::range(
  self : SorthybridpowersortSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SorthybridpowersortSeries::variance(
  self : SorthybridpowersortSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SorthybridpowersortSeries::std(
  self : SorthybridpowersortSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SorthybridpowersortSeries::median(
  self : SorthybridpowersortSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SorthybridpowersortSeries::scale(
  self : SorthybridpowersortSeries,
  f : Double,
) -> SorthybridpowersortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SorthybridpowersortSeries::add(
  self : SorthybridpowersortSeries,
  other : SorthybridpowersortSeries,
) -> SorthybridpowersortSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SorthybridpowersortSeries::sub(
  self : SorthybridpowersortSeries,
  other : SorthybridpowersortSeries,
) -> SorthybridpowersortSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SorthybridpowersortSeries::normalize(
  self : SorthybridpowersortSeries,
) -> SorthybridpowersortSeries {
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
pub fn SorthybridpowersortSeries::cumsum(
  self : SorthybridpowersortSeries,
) -> SorthybridpowersortSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SorthybridpowersortSeries::to_string(
  self : SorthybridpowersortSeries,
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
pub(all) struct SorthybridpowersortMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn sort_hybrid_powersort_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SorthybridpowersortMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn sort_hybrid_powersort_matrix_identity(
  n : Int32,
) -> SorthybridpowersortMatrix {
  let m = sort_hybrid_powersort_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SorthybridpowersortMatrix::get(
  self : SorthybridpowersortMatrix,
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
pub fn SorthybridpowersortMatrix::transpose(
  self : SorthybridpowersortMatrix,
) -> SorthybridpowersortMatrix {
  let result = sort_hybrid_powersort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SorthybridpowersortMatrix::add(
  self : SorthybridpowersortMatrix,
  other : SorthybridpowersortMatrix,
) -> SorthybridpowersortMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = sort_hybrid_powersort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SorthybridpowersortMatrix::scale(
  self : SorthybridpowersortMatrix,
  s : Double,
) -> SorthybridpowersortMatrix {
  let result = sort_hybrid_powersort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SorthybridpowersortMatrix::multiply(
  self : SorthybridpowersortMatrix,
  other : SorthybridpowersortMatrix,
) -> SorthybridpowersortMatrix {
  if self.cols != other.rows {
    return sort_hybrid_powersort_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = sort_hybrid_powersort_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SorthybridpowersortMatrix::trace(
  self : SorthybridpowersortMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SorthybridpowersortMatrix::det(
  self : SorthybridpowersortMatrix,
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
pub fn SorthybridpowersortMatrix::norm(
  self : SorthybridpowersortMatrix,
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
pub fn SorthybridpowersortMatrix::to_string(
  self : SorthybridpowersortMatrix,
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
pub(all) struct SorthybridpowersortVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn sort_hybrid_powersort_make_vector(
  comps : Array[Double],
) -> SorthybridpowersortVector {
  { comps, dim: comps.length(), }
}

///|
pub fn sort_hybrid_powersort_vector_zero(
  dim : Int32,
) -> SorthybridpowersortVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SorthybridpowersortVector::add(
  self : SorthybridpowersortVector,
  other : SorthybridpowersortVector,
) -> SorthybridpowersortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SorthybridpowersortVector::sub(
  self : SorthybridpowersortVector,
  other : SorthybridpowersortVector,
) -> SorthybridpowersortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SorthybridpowersortVector::scale(
  self : SorthybridpowersortVector,
  s : Double,
) -> SorthybridpowersortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SorthybridpowersortVector::dot(
  self : SorthybridpowersortVector,
  other : SorthybridpowersortVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SorthybridpowersortVector::norm(
  self : SorthybridpowersortVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SorthybridpowersortVector::normalize(
  self : SorthybridpowersortVector,
) -> SorthybridpowersortVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SorthybridpowersortVector::dist(
  self : SorthybridpowersortVector,
  other : SorthybridpowersortVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SorthybridpowersortVector::to_string(
  self : SorthybridpowersortVector,
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
pub(all) struct SorthybridpowersortFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_frame_make(
  size : Int32,
) -> SorthybridpowersortFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortFrame::len(self : SorthybridpowersortFrame) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortFrame::get(
  self : SorthybridpowersortFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortFrame::set(
  self : SorthybridpowersortFrame,
  i : Int32,
  v : Double,
) -> SorthybridpowersortFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortFrame::sum(self : SorthybridpowersortFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortFrame::mean(
  self : SorthybridpowersortFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortFrame::scale(
  self : SorthybridpowersortFrame,
  f : Double,
) -> SorthybridpowersortFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortFrame::add(
  self : SorthybridpowersortFrame,
  other : SorthybridpowersortFrame,
) -> SorthybridpowersortFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortFrame::copy(
  self : SorthybridpowersortFrame,
) -> SorthybridpowersortFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortFrame::fill(
  self : SorthybridpowersortFrame,
  v : Double,
) -> SorthybridpowersortFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortFrame::min(self : SorthybridpowersortFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortFrame::max(self : SorthybridpowersortFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortFrame::to_string(
  self : SorthybridpowersortFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_table_make(
  size : Int32,
) -> SorthybridpowersortTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortTable::len(self : SorthybridpowersortTable) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortTable::get(
  self : SorthybridpowersortTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortTable::set(
  self : SorthybridpowersortTable,
  i : Int32,
  v : Double,
) -> SorthybridpowersortTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortTable::sum(self : SorthybridpowersortTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortTable::mean(
  self : SorthybridpowersortTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortTable::scale(
  self : SorthybridpowersortTable,
  f : Double,
) -> SorthybridpowersortTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortTable::add(
  self : SorthybridpowersortTable,
  other : SorthybridpowersortTable,
) -> SorthybridpowersortTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortTable::copy(
  self : SorthybridpowersortTable,
) -> SorthybridpowersortTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortTable::fill(
  self : SorthybridpowersortTable,
  v : Double,
) -> SorthybridpowersortTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortTable::min(self : SorthybridpowersortTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortTable::max(self : SorthybridpowersortTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortTable::to_string(
  self : SorthybridpowersortTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_graphn_make(
  size : Int32,
) -> SorthybridpowersortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortGraphN::len(
  self : SorthybridpowersortGraphN,
) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortGraphN::get(
  self : SorthybridpowersortGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortGraphN::set(
  self : SorthybridpowersortGraphN,
  i : Int32,
  v : Double,
) -> SorthybridpowersortGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortGraphN::sum(
  self : SorthybridpowersortGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortGraphN::mean(
  self : SorthybridpowersortGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortGraphN::scale(
  self : SorthybridpowersortGraphN,
  f : Double,
) -> SorthybridpowersortGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortGraphN::add(
  self : SorthybridpowersortGraphN,
  other : SorthybridpowersortGraphN,
) -> SorthybridpowersortGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortGraphN::copy(
  self : SorthybridpowersortGraphN,
) -> SorthybridpowersortGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortGraphN::fill(
  self : SorthybridpowersortGraphN,
  v : Double,
) -> SorthybridpowersortGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortGraphN::min(
  self : SorthybridpowersortGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortGraphN::max(
  self : SorthybridpowersortGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortGraphN::to_string(
  self : SorthybridpowersortGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_node_make(size : Int32) -> SorthybridpowersortNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortNode::len(self : SorthybridpowersortNode) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortNode::get(
  self : SorthybridpowersortNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortNode::set(
  self : SorthybridpowersortNode,
  i : Int32,
  v : Double,
) -> SorthybridpowersortNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortNode::sum(self : SorthybridpowersortNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortNode::mean(self : SorthybridpowersortNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortNode::scale(
  self : SorthybridpowersortNode,
  f : Double,
) -> SorthybridpowersortNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortNode::add(
  self : SorthybridpowersortNode,
  other : SorthybridpowersortNode,
) -> SorthybridpowersortNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortNode::copy(
  self : SorthybridpowersortNode,
) -> SorthybridpowersortNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortNode::fill(
  self : SorthybridpowersortNode,
  v : Double,
) -> SorthybridpowersortNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortNode::min(self : SorthybridpowersortNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortNode::max(self : SorthybridpowersortNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortNode::to_string(
  self : SorthybridpowersortNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_edge_make(size : Int32) -> SorthybridpowersortEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortEdge::len(self : SorthybridpowersortEdge) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortEdge::get(
  self : SorthybridpowersortEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortEdge::set(
  self : SorthybridpowersortEdge,
  i : Int32,
  v : Double,
) -> SorthybridpowersortEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortEdge::sum(self : SorthybridpowersortEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortEdge::mean(self : SorthybridpowersortEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortEdge::scale(
  self : SorthybridpowersortEdge,
  f : Double,
) -> SorthybridpowersortEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortEdge::add(
  self : SorthybridpowersortEdge,
  other : SorthybridpowersortEdge,
) -> SorthybridpowersortEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortEdge::copy(
  self : SorthybridpowersortEdge,
) -> SorthybridpowersortEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortEdge::fill(
  self : SorthybridpowersortEdge,
  v : Double,
) -> SorthybridpowersortEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortEdge::min(self : SorthybridpowersortEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortEdge::max(self : SorthybridpowersortEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortEdge::to_string(
  self : SorthybridpowersortEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_path_make(size : Int32) -> SorthybridpowersortPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortPath::len(self : SorthybridpowersortPath) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortPath::get(
  self : SorthybridpowersortPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortPath::set(
  self : SorthybridpowersortPath,
  i : Int32,
  v : Double,
) -> SorthybridpowersortPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortPath::sum(self : SorthybridpowersortPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortPath::mean(self : SorthybridpowersortPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortPath::scale(
  self : SorthybridpowersortPath,
  f : Double,
) -> SorthybridpowersortPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortPath::add(
  self : SorthybridpowersortPath,
  other : SorthybridpowersortPath,
) -> SorthybridpowersortPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortPath::copy(
  self : SorthybridpowersortPath,
) -> SorthybridpowersortPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortPath::fill(
  self : SorthybridpowersortPath,
  v : Double,
) -> SorthybridpowersortPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortPath::min(self : SorthybridpowersortPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortPath::max(self : SorthybridpowersortPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortPath::to_string(
  self : SorthybridpowersortPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_cluster_make(
  size : Int32,
) -> SorthybridpowersortCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortCluster::len(
  self : SorthybridpowersortCluster,
) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortCluster::get(
  self : SorthybridpowersortCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortCluster::set(
  self : SorthybridpowersortCluster,
  i : Int32,
  v : Double,
) -> SorthybridpowersortCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortCluster::sum(
  self : SorthybridpowersortCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortCluster::mean(
  self : SorthybridpowersortCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortCluster::scale(
  self : SorthybridpowersortCluster,
  f : Double,
) -> SorthybridpowersortCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortCluster::add(
  self : SorthybridpowersortCluster,
  other : SorthybridpowersortCluster,
) -> SorthybridpowersortCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortCluster::copy(
  self : SorthybridpowersortCluster,
) -> SorthybridpowersortCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortCluster::fill(
  self : SorthybridpowersortCluster,
  v : Double,
) -> SorthybridpowersortCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortCluster::min(
  self : SorthybridpowersortCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortCluster::max(
  self : SorthybridpowersortCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortCluster::to_string(
  self : SorthybridpowersortCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_model_make(
  size : Int32,
) -> SorthybridpowersortModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortModel::len(self : SorthybridpowersortModel) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortModel::get(
  self : SorthybridpowersortModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortModel::set(
  self : SorthybridpowersortModel,
  i : Int32,
  v : Double,
) -> SorthybridpowersortModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortModel::sum(self : SorthybridpowersortModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortModel::mean(
  self : SorthybridpowersortModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortModel::scale(
  self : SorthybridpowersortModel,
  f : Double,
) -> SorthybridpowersortModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortModel::add(
  self : SorthybridpowersortModel,
  other : SorthybridpowersortModel,
) -> SorthybridpowersortModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortModel::copy(
  self : SorthybridpowersortModel,
) -> SorthybridpowersortModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortModel::fill(
  self : SorthybridpowersortModel,
  v : Double,
) -> SorthybridpowersortModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortModel::min(self : SorthybridpowersortModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortModel::max(self : SorthybridpowersortModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortModel::to_string(
  self : SorthybridpowersortModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_layer_make(
  size : Int32,
) -> SorthybridpowersortLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortLayer::len(self : SorthybridpowersortLayer) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortLayer::get(
  self : SorthybridpowersortLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortLayer::set(
  self : SorthybridpowersortLayer,
  i : Int32,
  v : Double,
) -> SorthybridpowersortLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortLayer::sum(self : SorthybridpowersortLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortLayer::mean(
  self : SorthybridpowersortLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortLayer::scale(
  self : SorthybridpowersortLayer,
  f : Double,
) -> SorthybridpowersortLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortLayer::add(
  self : SorthybridpowersortLayer,
  other : SorthybridpowersortLayer,
) -> SorthybridpowersortLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortLayer::copy(
  self : SorthybridpowersortLayer,
) -> SorthybridpowersortLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortLayer::fill(
  self : SorthybridpowersortLayer,
  v : Double,
) -> SorthybridpowersortLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortLayer::min(self : SorthybridpowersortLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortLayer::max(self : SorthybridpowersortLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortLayer::to_string(
  self : SorthybridpowersortLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_buffer_make(
  size : Int32,
) -> SorthybridpowersortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortBuffer::len(
  self : SorthybridpowersortBuffer,
) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortBuffer::get(
  self : SorthybridpowersortBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortBuffer::set(
  self : SorthybridpowersortBuffer,
  i : Int32,
  v : Double,
) -> SorthybridpowersortBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortBuffer::sum(
  self : SorthybridpowersortBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortBuffer::mean(
  self : SorthybridpowersortBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortBuffer::scale(
  self : SorthybridpowersortBuffer,
  f : Double,
) -> SorthybridpowersortBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortBuffer::add(
  self : SorthybridpowersortBuffer,
  other : SorthybridpowersortBuffer,
) -> SorthybridpowersortBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortBuffer::copy(
  self : SorthybridpowersortBuffer,
) -> SorthybridpowersortBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortBuffer::fill(
  self : SorthybridpowersortBuffer,
  v : Double,
) -> SorthybridpowersortBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortBuffer::min(
  self : SorthybridpowersortBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortBuffer::max(
  self : SorthybridpowersortBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortBuffer::to_string(
  self : SorthybridpowersortBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_cursor_make(
  size : Int32,
) -> SorthybridpowersortCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortCursor::len(
  self : SorthybridpowersortCursor,
) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortCursor::get(
  self : SorthybridpowersortCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortCursor::set(
  self : SorthybridpowersortCursor,
  i : Int32,
  v : Double,
) -> SorthybridpowersortCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortCursor::sum(
  self : SorthybridpowersortCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortCursor::mean(
  self : SorthybridpowersortCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortCursor::scale(
  self : SorthybridpowersortCursor,
  f : Double,
) -> SorthybridpowersortCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortCursor::add(
  self : SorthybridpowersortCursor,
  other : SorthybridpowersortCursor,
) -> SorthybridpowersortCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortCursor::copy(
  self : SorthybridpowersortCursor,
) -> SorthybridpowersortCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortCursor::fill(
  self : SorthybridpowersortCursor,
  v : Double,
) -> SorthybridpowersortCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortCursor::min(
  self : SorthybridpowersortCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortCursor::max(
  self : SorthybridpowersortCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortCursor::to_string(
  self : SorthybridpowersortCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_view_make(size : Int32) -> SorthybridpowersortView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortView::len(self : SorthybridpowersortView) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortView::get(
  self : SorthybridpowersortView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortView::set(
  self : SorthybridpowersortView,
  i : Int32,
  v : Double,
) -> SorthybridpowersortView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortView::sum(self : SorthybridpowersortView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortView::mean(self : SorthybridpowersortView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortView::scale(
  self : SorthybridpowersortView,
  f : Double,
) -> SorthybridpowersortView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortView::add(
  self : SorthybridpowersortView,
  other : SorthybridpowersortView,
) -> SorthybridpowersortView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortView::copy(
  self : SorthybridpowersortView,
) -> SorthybridpowersortView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortView::fill(
  self : SorthybridpowersortView,
  v : Double,
) -> SorthybridpowersortView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortView::min(self : SorthybridpowersortView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortView::max(self : SorthybridpowersortView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortView::to_string(
  self : SorthybridpowersortView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_range_make(
  size : Int32,
) -> SorthybridpowersortRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortRange::len(self : SorthybridpowersortRange) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortRange::get(
  self : SorthybridpowersortRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortRange::set(
  self : SorthybridpowersortRange,
  i : Int32,
  v : Double,
) -> SorthybridpowersortRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortRange::sum(self : SorthybridpowersortRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortRange::mean(
  self : SorthybridpowersortRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortRange::scale(
  self : SorthybridpowersortRange,
  f : Double,
) -> SorthybridpowersortRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortRange::add(
  self : SorthybridpowersortRange,
  other : SorthybridpowersortRange,
) -> SorthybridpowersortRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortRange::copy(
  self : SorthybridpowersortRange,
) -> SorthybridpowersortRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortRange::fill(
  self : SorthybridpowersortRange,
  v : Double,
) -> SorthybridpowersortRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortRange::min(self : SorthybridpowersortRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortRange::max(self : SorthybridpowersortRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortRange::to_string(
  self : SorthybridpowersortRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridpowersortSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_powersort_slice_make(
  size : Int32,
) -> SorthybridpowersortSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridpowersortSlice::len(self : SorthybridpowersortSlice) -> Int32 {
  self.size
}

///|
pub fn SorthybridpowersortSlice::get(
  self : SorthybridpowersortSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridpowersortSlice::set(
  self : SorthybridpowersortSlice,
  i : Int32,
  v : Double,
) -> SorthybridpowersortSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortSlice::sum(self : SorthybridpowersortSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridpowersortSlice::mean(
  self : SorthybridpowersortSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridpowersortSlice::scale(
  self : SorthybridpowersortSlice,
  f : Double,
) -> SorthybridpowersortSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortSlice::add(
  self : SorthybridpowersortSlice,
  other : SorthybridpowersortSlice,
) -> SorthybridpowersortSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridpowersortSlice::copy(
  self : SorthybridpowersortSlice,
) -> SorthybridpowersortSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortSlice::fill(
  self : SorthybridpowersortSlice,
  v : Double,
) -> SorthybridpowersortSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridpowersortSlice::min(self : SorthybridpowersortSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridpowersortSlice::max(self : SorthybridpowersortSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridpowersortSlice::to_string(
  self : SorthybridpowersortSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
