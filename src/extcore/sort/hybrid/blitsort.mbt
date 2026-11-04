///|
///===
/// extcore/sort_hybrid_blitsort
pub(all) struct SorthybridblitsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn sort_hybrid_blitsort_make_point(
  x : Double,
  y : Double,
) -> SorthybridblitsortPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn sort_hybrid_blitsort_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SorthybridblitsortPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SorthybridblitsortPoint::x(self : SorthybridblitsortPoint) -> Double {
  self.x
}

///|
pub fn SorthybridblitsortPoint::y(self : SorthybridblitsortPoint) -> Double {
  self.y
}

///|
pub fn SorthybridblitsortPoint::z(self : SorthybridblitsortPoint) -> Double {
  self.z
}

///|
pub fn SorthybridblitsortPoint::label(self : SorthybridblitsortPoint) -> Int32 {
  self.label
}

///|
pub fn SorthybridblitsortPoint::dist(
  self : SorthybridblitsortPoint,
  other : SorthybridblitsortPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SorthybridblitsortPoint::add(
  self : SorthybridblitsortPoint,
  other : SorthybridblitsortPoint,
) -> SorthybridblitsortPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SorthybridblitsortPoint::sub(
  self : SorthybridblitsortPoint,
  other : SorthybridblitsortPoint,
) -> SorthybridblitsortPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SorthybridblitsortPoint::scale(
  self : SorthybridblitsortPoint,
  s : Double,
) -> SorthybridblitsortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SorthybridblitsortPoint::dot(
  self : SorthybridblitsortPoint,
  other : SorthybridblitsortPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SorthybridblitsortPoint::cross(
  self : SorthybridblitsortPoint,
  other : SorthybridblitsortPoint,
) -> SorthybridblitsortPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SorthybridblitsortPoint::norm(self : SorthybridblitsortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SorthybridblitsortPoint::normalize(
  self : SorthybridblitsortPoint,
) -> SorthybridblitsortPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SorthybridblitsortPoint::negate(
  self : SorthybridblitsortPoint,
) -> SorthybridblitsortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SorthybridblitsortPoint::mid(
  self : SorthybridblitsortPoint,
  other : SorthybridblitsortPoint,
) -> SorthybridblitsortPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SorthybridblitsortPoint::lerp(
  self : SorthybridblitsortPoint,
  other : SorthybridblitsortPoint,
  t : Double,
) -> SorthybridblitsortPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SorthybridblitsortPoint::to_string(
  self : SorthybridblitsortPoint,
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
pub(all) struct SorthybridblitsortSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn sort_hybrid_blitsort_make_series(
  vals : Array[Double],
  name : String,
) -> SorthybridblitsortSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SorthybridblitsortSeries::len(self : SorthybridblitsortSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn SorthybridblitsortSeries::sum(self : SorthybridblitsortSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SorthybridblitsortSeries::mean(
  self : SorthybridblitsortSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SorthybridblitsortSeries::min(self : SorthybridblitsortSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SorthybridblitsortSeries::max(self : SorthybridblitsortSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SorthybridblitsortSeries::range(
  self : SorthybridblitsortSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SorthybridblitsortSeries::variance(
  self : SorthybridblitsortSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SorthybridblitsortSeries::std(self : SorthybridblitsortSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SorthybridblitsortSeries::median(
  self : SorthybridblitsortSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SorthybridblitsortSeries::scale(
  self : SorthybridblitsortSeries,
  f : Double,
) -> SorthybridblitsortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SorthybridblitsortSeries::add(
  self : SorthybridblitsortSeries,
  other : SorthybridblitsortSeries,
) -> SorthybridblitsortSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SorthybridblitsortSeries::sub(
  self : SorthybridblitsortSeries,
  other : SorthybridblitsortSeries,
) -> SorthybridblitsortSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SorthybridblitsortSeries::normalize(
  self : SorthybridblitsortSeries,
) -> SorthybridblitsortSeries {
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
pub fn SorthybridblitsortSeries::cumsum(
  self : SorthybridblitsortSeries,
) -> SorthybridblitsortSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SorthybridblitsortSeries::to_string(
  self : SorthybridblitsortSeries,
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
pub(all) struct SorthybridblitsortMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn sort_hybrid_blitsort_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SorthybridblitsortMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn sort_hybrid_blitsort_matrix_identity(
  n : Int32,
) -> SorthybridblitsortMatrix {
  let m = sort_hybrid_blitsort_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SorthybridblitsortMatrix::get(
  self : SorthybridblitsortMatrix,
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
pub fn SorthybridblitsortMatrix::transpose(
  self : SorthybridblitsortMatrix,
) -> SorthybridblitsortMatrix {
  let result = sort_hybrid_blitsort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SorthybridblitsortMatrix::add(
  self : SorthybridblitsortMatrix,
  other : SorthybridblitsortMatrix,
) -> SorthybridblitsortMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = sort_hybrid_blitsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SorthybridblitsortMatrix::scale(
  self : SorthybridblitsortMatrix,
  s : Double,
) -> SorthybridblitsortMatrix {
  let result = sort_hybrid_blitsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SorthybridblitsortMatrix::multiply(
  self : SorthybridblitsortMatrix,
  other : SorthybridblitsortMatrix,
) -> SorthybridblitsortMatrix {
  if self.cols != other.rows {
    return sort_hybrid_blitsort_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = sort_hybrid_blitsort_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SorthybridblitsortMatrix::trace(
  self : SorthybridblitsortMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SorthybridblitsortMatrix::det(self : SorthybridblitsortMatrix) -> Double {
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
pub fn SorthybridblitsortMatrix::norm(
  self : SorthybridblitsortMatrix,
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
pub fn SorthybridblitsortMatrix::to_string(
  self : SorthybridblitsortMatrix,
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
pub(all) struct SorthybridblitsortVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn sort_hybrid_blitsort_make_vector(
  comps : Array[Double],
) -> SorthybridblitsortVector {
  { comps, dim: comps.length(), }
}

///|
pub fn sort_hybrid_blitsort_vector_zero(
  dim : Int32,
) -> SorthybridblitsortVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SorthybridblitsortVector::add(
  self : SorthybridblitsortVector,
  other : SorthybridblitsortVector,
) -> SorthybridblitsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SorthybridblitsortVector::sub(
  self : SorthybridblitsortVector,
  other : SorthybridblitsortVector,
) -> SorthybridblitsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SorthybridblitsortVector::scale(
  self : SorthybridblitsortVector,
  s : Double,
) -> SorthybridblitsortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SorthybridblitsortVector::dot(
  self : SorthybridblitsortVector,
  other : SorthybridblitsortVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SorthybridblitsortVector::norm(
  self : SorthybridblitsortVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SorthybridblitsortVector::normalize(
  self : SorthybridblitsortVector,
) -> SorthybridblitsortVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SorthybridblitsortVector::dist(
  self : SorthybridblitsortVector,
  other : SorthybridblitsortVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SorthybridblitsortVector::to_string(
  self : SorthybridblitsortVector,
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
pub(all) struct SorthybridblitsortFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_frame_make(size : Int32) -> SorthybridblitsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortFrame::len(self : SorthybridblitsortFrame) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortFrame::get(
  self : SorthybridblitsortFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortFrame::set(
  self : SorthybridblitsortFrame,
  i : Int32,
  v : Double,
) -> SorthybridblitsortFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortFrame::sum(self : SorthybridblitsortFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortFrame::mean(self : SorthybridblitsortFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortFrame::scale(
  self : SorthybridblitsortFrame,
  f : Double,
) -> SorthybridblitsortFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortFrame::add(
  self : SorthybridblitsortFrame,
  other : SorthybridblitsortFrame,
) -> SorthybridblitsortFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortFrame::copy(
  self : SorthybridblitsortFrame,
) -> SorthybridblitsortFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortFrame::fill(
  self : SorthybridblitsortFrame,
  v : Double,
) -> SorthybridblitsortFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortFrame::min(self : SorthybridblitsortFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortFrame::max(self : SorthybridblitsortFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortFrame::to_string(
  self : SorthybridblitsortFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_table_make(size : Int32) -> SorthybridblitsortTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortTable::len(self : SorthybridblitsortTable) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortTable::get(
  self : SorthybridblitsortTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortTable::set(
  self : SorthybridblitsortTable,
  i : Int32,
  v : Double,
) -> SorthybridblitsortTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortTable::sum(self : SorthybridblitsortTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortTable::mean(self : SorthybridblitsortTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortTable::scale(
  self : SorthybridblitsortTable,
  f : Double,
) -> SorthybridblitsortTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortTable::add(
  self : SorthybridblitsortTable,
  other : SorthybridblitsortTable,
) -> SorthybridblitsortTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortTable::copy(
  self : SorthybridblitsortTable,
) -> SorthybridblitsortTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortTable::fill(
  self : SorthybridblitsortTable,
  v : Double,
) -> SorthybridblitsortTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortTable::min(self : SorthybridblitsortTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortTable::max(self : SorthybridblitsortTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortTable::to_string(
  self : SorthybridblitsortTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_graphn_make(
  size : Int32,
) -> SorthybridblitsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortGraphN::len(self : SorthybridblitsortGraphN) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortGraphN::get(
  self : SorthybridblitsortGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortGraphN::set(
  self : SorthybridblitsortGraphN,
  i : Int32,
  v : Double,
) -> SorthybridblitsortGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortGraphN::sum(self : SorthybridblitsortGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortGraphN::mean(
  self : SorthybridblitsortGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortGraphN::scale(
  self : SorthybridblitsortGraphN,
  f : Double,
) -> SorthybridblitsortGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortGraphN::add(
  self : SorthybridblitsortGraphN,
  other : SorthybridblitsortGraphN,
) -> SorthybridblitsortGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortGraphN::copy(
  self : SorthybridblitsortGraphN,
) -> SorthybridblitsortGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortGraphN::fill(
  self : SorthybridblitsortGraphN,
  v : Double,
) -> SorthybridblitsortGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortGraphN::min(self : SorthybridblitsortGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortGraphN::max(self : SorthybridblitsortGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortGraphN::to_string(
  self : SorthybridblitsortGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_node_make(size : Int32) -> SorthybridblitsortNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortNode::len(self : SorthybridblitsortNode) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortNode::get(
  self : SorthybridblitsortNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortNode::set(
  self : SorthybridblitsortNode,
  i : Int32,
  v : Double,
) -> SorthybridblitsortNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortNode::sum(self : SorthybridblitsortNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortNode::mean(self : SorthybridblitsortNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortNode::scale(
  self : SorthybridblitsortNode,
  f : Double,
) -> SorthybridblitsortNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortNode::add(
  self : SorthybridblitsortNode,
  other : SorthybridblitsortNode,
) -> SorthybridblitsortNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortNode::copy(
  self : SorthybridblitsortNode,
) -> SorthybridblitsortNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortNode::fill(
  self : SorthybridblitsortNode,
  v : Double,
) -> SorthybridblitsortNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortNode::min(self : SorthybridblitsortNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortNode::max(self : SorthybridblitsortNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortNode::to_string(
  self : SorthybridblitsortNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_edge_make(size : Int32) -> SorthybridblitsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortEdge::len(self : SorthybridblitsortEdge) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortEdge::get(
  self : SorthybridblitsortEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortEdge::set(
  self : SorthybridblitsortEdge,
  i : Int32,
  v : Double,
) -> SorthybridblitsortEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortEdge::sum(self : SorthybridblitsortEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortEdge::mean(self : SorthybridblitsortEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortEdge::scale(
  self : SorthybridblitsortEdge,
  f : Double,
) -> SorthybridblitsortEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortEdge::add(
  self : SorthybridblitsortEdge,
  other : SorthybridblitsortEdge,
) -> SorthybridblitsortEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortEdge::copy(
  self : SorthybridblitsortEdge,
) -> SorthybridblitsortEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortEdge::fill(
  self : SorthybridblitsortEdge,
  v : Double,
) -> SorthybridblitsortEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortEdge::min(self : SorthybridblitsortEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortEdge::max(self : SorthybridblitsortEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortEdge::to_string(
  self : SorthybridblitsortEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_path_make(size : Int32) -> SorthybridblitsortPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortPath::len(self : SorthybridblitsortPath) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortPath::get(
  self : SorthybridblitsortPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortPath::set(
  self : SorthybridblitsortPath,
  i : Int32,
  v : Double,
) -> SorthybridblitsortPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortPath::sum(self : SorthybridblitsortPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortPath::mean(self : SorthybridblitsortPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortPath::scale(
  self : SorthybridblitsortPath,
  f : Double,
) -> SorthybridblitsortPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortPath::add(
  self : SorthybridblitsortPath,
  other : SorthybridblitsortPath,
) -> SorthybridblitsortPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortPath::copy(
  self : SorthybridblitsortPath,
) -> SorthybridblitsortPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortPath::fill(
  self : SorthybridblitsortPath,
  v : Double,
) -> SorthybridblitsortPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortPath::min(self : SorthybridblitsortPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortPath::max(self : SorthybridblitsortPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortPath::to_string(
  self : SorthybridblitsortPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_cluster_make(
  size : Int32,
) -> SorthybridblitsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortCluster::len(
  self : SorthybridblitsortCluster,
) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortCluster::get(
  self : SorthybridblitsortCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortCluster::set(
  self : SorthybridblitsortCluster,
  i : Int32,
  v : Double,
) -> SorthybridblitsortCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortCluster::sum(
  self : SorthybridblitsortCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortCluster::mean(
  self : SorthybridblitsortCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortCluster::scale(
  self : SorthybridblitsortCluster,
  f : Double,
) -> SorthybridblitsortCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortCluster::add(
  self : SorthybridblitsortCluster,
  other : SorthybridblitsortCluster,
) -> SorthybridblitsortCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortCluster::copy(
  self : SorthybridblitsortCluster,
) -> SorthybridblitsortCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortCluster::fill(
  self : SorthybridblitsortCluster,
  v : Double,
) -> SorthybridblitsortCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortCluster::min(
  self : SorthybridblitsortCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortCluster::max(
  self : SorthybridblitsortCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortCluster::to_string(
  self : SorthybridblitsortCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_model_make(size : Int32) -> SorthybridblitsortModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortModel::len(self : SorthybridblitsortModel) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortModel::get(
  self : SorthybridblitsortModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortModel::set(
  self : SorthybridblitsortModel,
  i : Int32,
  v : Double,
) -> SorthybridblitsortModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortModel::sum(self : SorthybridblitsortModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortModel::mean(self : SorthybridblitsortModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortModel::scale(
  self : SorthybridblitsortModel,
  f : Double,
) -> SorthybridblitsortModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortModel::add(
  self : SorthybridblitsortModel,
  other : SorthybridblitsortModel,
) -> SorthybridblitsortModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortModel::copy(
  self : SorthybridblitsortModel,
) -> SorthybridblitsortModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortModel::fill(
  self : SorthybridblitsortModel,
  v : Double,
) -> SorthybridblitsortModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortModel::min(self : SorthybridblitsortModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortModel::max(self : SorthybridblitsortModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortModel::to_string(
  self : SorthybridblitsortModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_layer_make(size : Int32) -> SorthybridblitsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortLayer::len(self : SorthybridblitsortLayer) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortLayer::get(
  self : SorthybridblitsortLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortLayer::set(
  self : SorthybridblitsortLayer,
  i : Int32,
  v : Double,
) -> SorthybridblitsortLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortLayer::sum(self : SorthybridblitsortLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortLayer::mean(self : SorthybridblitsortLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortLayer::scale(
  self : SorthybridblitsortLayer,
  f : Double,
) -> SorthybridblitsortLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortLayer::add(
  self : SorthybridblitsortLayer,
  other : SorthybridblitsortLayer,
) -> SorthybridblitsortLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortLayer::copy(
  self : SorthybridblitsortLayer,
) -> SorthybridblitsortLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortLayer::fill(
  self : SorthybridblitsortLayer,
  v : Double,
) -> SorthybridblitsortLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortLayer::min(self : SorthybridblitsortLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortLayer::max(self : SorthybridblitsortLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortLayer::to_string(
  self : SorthybridblitsortLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_buffer_make(
  size : Int32,
) -> SorthybridblitsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortBuffer::len(self : SorthybridblitsortBuffer) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortBuffer::get(
  self : SorthybridblitsortBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortBuffer::set(
  self : SorthybridblitsortBuffer,
  i : Int32,
  v : Double,
) -> SorthybridblitsortBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortBuffer::sum(self : SorthybridblitsortBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortBuffer::mean(
  self : SorthybridblitsortBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortBuffer::scale(
  self : SorthybridblitsortBuffer,
  f : Double,
) -> SorthybridblitsortBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortBuffer::add(
  self : SorthybridblitsortBuffer,
  other : SorthybridblitsortBuffer,
) -> SorthybridblitsortBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortBuffer::copy(
  self : SorthybridblitsortBuffer,
) -> SorthybridblitsortBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortBuffer::fill(
  self : SorthybridblitsortBuffer,
  v : Double,
) -> SorthybridblitsortBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortBuffer::min(self : SorthybridblitsortBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortBuffer::max(self : SorthybridblitsortBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortBuffer::to_string(
  self : SorthybridblitsortBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_cursor_make(
  size : Int32,
) -> SorthybridblitsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortCursor::len(self : SorthybridblitsortCursor) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortCursor::get(
  self : SorthybridblitsortCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortCursor::set(
  self : SorthybridblitsortCursor,
  i : Int32,
  v : Double,
) -> SorthybridblitsortCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortCursor::sum(self : SorthybridblitsortCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortCursor::mean(
  self : SorthybridblitsortCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortCursor::scale(
  self : SorthybridblitsortCursor,
  f : Double,
) -> SorthybridblitsortCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortCursor::add(
  self : SorthybridblitsortCursor,
  other : SorthybridblitsortCursor,
) -> SorthybridblitsortCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortCursor::copy(
  self : SorthybridblitsortCursor,
) -> SorthybridblitsortCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortCursor::fill(
  self : SorthybridblitsortCursor,
  v : Double,
) -> SorthybridblitsortCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortCursor::min(self : SorthybridblitsortCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortCursor::max(self : SorthybridblitsortCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortCursor::to_string(
  self : SorthybridblitsortCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_view_make(size : Int32) -> SorthybridblitsortView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortView::len(self : SorthybridblitsortView) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortView::get(
  self : SorthybridblitsortView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortView::set(
  self : SorthybridblitsortView,
  i : Int32,
  v : Double,
) -> SorthybridblitsortView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortView::sum(self : SorthybridblitsortView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortView::mean(self : SorthybridblitsortView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortView::scale(
  self : SorthybridblitsortView,
  f : Double,
) -> SorthybridblitsortView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortView::add(
  self : SorthybridblitsortView,
  other : SorthybridblitsortView,
) -> SorthybridblitsortView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortView::copy(
  self : SorthybridblitsortView,
) -> SorthybridblitsortView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortView::fill(
  self : SorthybridblitsortView,
  v : Double,
) -> SorthybridblitsortView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortView::min(self : SorthybridblitsortView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortView::max(self : SorthybridblitsortView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortView::to_string(
  self : SorthybridblitsortView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_range_make(size : Int32) -> SorthybridblitsortRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortRange::len(self : SorthybridblitsortRange) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortRange::get(
  self : SorthybridblitsortRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortRange::set(
  self : SorthybridblitsortRange,
  i : Int32,
  v : Double,
) -> SorthybridblitsortRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortRange::sum(self : SorthybridblitsortRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortRange::mean(self : SorthybridblitsortRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortRange::scale(
  self : SorthybridblitsortRange,
  f : Double,
) -> SorthybridblitsortRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortRange::add(
  self : SorthybridblitsortRange,
  other : SorthybridblitsortRange,
) -> SorthybridblitsortRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortRange::copy(
  self : SorthybridblitsortRange,
) -> SorthybridblitsortRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortRange::fill(
  self : SorthybridblitsortRange,
  v : Double,
) -> SorthybridblitsortRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortRange::min(self : SorthybridblitsortRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortRange::max(self : SorthybridblitsortRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortRange::to_string(
  self : SorthybridblitsortRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridblitsortSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_blitsort_slice_make(size : Int32) -> SorthybridblitsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridblitsortSlice::len(self : SorthybridblitsortSlice) -> Int32 {
  self.size
}

///|
pub fn SorthybridblitsortSlice::get(
  self : SorthybridblitsortSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridblitsortSlice::set(
  self : SorthybridblitsortSlice,
  i : Int32,
  v : Double,
) -> SorthybridblitsortSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortSlice::sum(self : SorthybridblitsortSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridblitsortSlice::mean(self : SorthybridblitsortSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridblitsortSlice::scale(
  self : SorthybridblitsortSlice,
  f : Double,
) -> SorthybridblitsortSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortSlice::add(
  self : SorthybridblitsortSlice,
  other : SorthybridblitsortSlice,
) -> SorthybridblitsortSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridblitsortSlice::copy(
  self : SorthybridblitsortSlice,
) -> SorthybridblitsortSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortSlice::fill(
  self : SorthybridblitsortSlice,
  v : Double,
) -> SorthybridblitsortSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridblitsortSlice::min(self : SorthybridblitsortSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridblitsortSlice::max(self : SorthybridblitsortSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridblitsortSlice::to_string(
  self : SorthybridblitsortSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
