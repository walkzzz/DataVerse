///|
///===
/// extcore/sort_hybrid_splaysort
pub(all) struct SorthybridsplaysortPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn sort_hybrid_splaysort_make_point(
  x : Double,
  y : Double,
) -> SorthybridsplaysortPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn sort_hybrid_splaysort_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SorthybridsplaysortPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SorthybridsplaysortPoint::x(self : SorthybridsplaysortPoint) -> Double {
  self.x
}

///|
pub fn SorthybridsplaysortPoint::y(self : SorthybridsplaysortPoint) -> Double {
  self.y
}

///|
pub fn SorthybridsplaysortPoint::z(self : SorthybridsplaysortPoint) -> Double {
  self.z
}

///|
pub fn SorthybridsplaysortPoint::label(
  self : SorthybridsplaysortPoint,
) -> Int32 {
  self.label
}

///|
pub fn SorthybridsplaysortPoint::dist(
  self : SorthybridsplaysortPoint,
  other : SorthybridsplaysortPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SorthybridsplaysortPoint::add(
  self : SorthybridsplaysortPoint,
  other : SorthybridsplaysortPoint,
) -> SorthybridsplaysortPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SorthybridsplaysortPoint::sub(
  self : SorthybridsplaysortPoint,
  other : SorthybridsplaysortPoint,
) -> SorthybridsplaysortPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SorthybridsplaysortPoint::scale(
  self : SorthybridsplaysortPoint,
  s : Double,
) -> SorthybridsplaysortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SorthybridsplaysortPoint::dot(
  self : SorthybridsplaysortPoint,
  other : SorthybridsplaysortPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SorthybridsplaysortPoint::cross(
  self : SorthybridsplaysortPoint,
  other : SorthybridsplaysortPoint,
) -> SorthybridsplaysortPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SorthybridsplaysortPoint::norm(
  self : SorthybridsplaysortPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SorthybridsplaysortPoint::normalize(
  self : SorthybridsplaysortPoint,
) -> SorthybridsplaysortPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SorthybridsplaysortPoint::negate(
  self : SorthybridsplaysortPoint,
) -> SorthybridsplaysortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SorthybridsplaysortPoint::mid(
  self : SorthybridsplaysortPoint,
  other : SorthybridsplaysortPoint,
) -> SorthybridsplaysortPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SorthybridsplaysortPoint::lerp(
  self : SorthybridsplaysortPoint,
  other : SorthybridsplaysortPoint,
  t : Double,
) -> SorthybridsplaysortPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SorthybridsplaysortPoint::to_string(
  self : SorthybridsplaysortPoint,
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
pub(all) struct SorthybridsplaysortSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn sort_hybrid_splaysort_make_series(
  vals : Array[Double],
  name : String,
) -> SorthybridsplaysortSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SorthybridsplaysortSeries::len(
  self : SorthybridsplaysortSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn SorthybridsplaysortSeries::sum(
  self : SorthybridsplaysortSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SorthybridsplaysortSeries::mean(
  self : SorthybridsplaysortSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SorthybridsplaysortSeries::min(
  self : SorthybridsplaysortSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SorthybridsplaysortSeries::max(
  self : SorthybridsplaysortSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SorthybridsplaysortSeries::range(
  self : SorthybridsplaysortSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SorthybridsplaysortSeries::variance(
  self : SorthybridsplaysortSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SorthybridsplaysortSeries::std(
  self : SorthybridsplaysortSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SorthybridsplaysortSeries::median(
  self : SorthybridsplaysortSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SorthybridsplaysortSeries::scale(
  self : SorthybridsplaysortSeries,
  f : Double,
) -> SorthybridsplaysortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SorthybridsplaysortSeries::add(
  self : SorthybridsplaysortSeries,
  other : SorthybridsplaysortSeries,
) -> SorthybridsplaysortSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SorthybridsplaysortSeries::sub(
  self : SorthybridsplaysortSeries,
  other : SorthybridsplaysortSeries,
) -> SorthybridsplaysortSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SorthybridsplaysortSeries::normalize(
  self : SorthybridsplaysortSeries,
) -> SorthybridsplaysortSeries {
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
pub fn SorthybridsplaysortSeries::cumsum(
  self : SorthybridsplaysortSeries,
) -> SorthybridsplaysortSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SorthybridsplaysortSeries::to_string(
  self : SorthybridsplaysortSeries,
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
pub(all) struct SorthybridsplaysortMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn sort_hybrid_splaysort_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SorthybridsplaysortMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn sort_hybrid_splaysort_matrix_identity(
  n : Int32,
) -> SorthybridsplaysortMatrix {
  let m = sort_hybrid_splaysort_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SorthybridsplaysortMatrix::get(
  self : SorthybridsplaysortMatrix,
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
pub fn SorthybridsplaysortMatrix::transpose(
  self : SorthybridsplaysortMatrix,
) -> SorthybridsplaysortMatrix {
  let result = sort_hybrid_splaysort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SorthybridsplaysortMatrix::add(
  self : SorthybridsplaysortMatrix,
  other : SorthybridsplaysortMatrix,
) -> SorthybridsplaysortMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = sort_hybrid_splaysort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SorthybridsplaysortMatrix::scale(
  self : SorthybridsplaysortMatrix,
  s : Double,
) -> SorthybridsplaysortMatrix {
  let result = sort_hybrid_splaysort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SorthybridsplaysortMatrix::multiply(
  self : SorthybridsplaysortMatrix,
  other : SorthybridsplaysortMatrix,
) -> SorthybridsplaysortMatrix {
  if self.cols != other.rows {
    return sort_hybrid_splaysort_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = sort_hybrid_splaysort_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SorthybridsplaysortMatrix::trace(
  self : SorthybridsplaysortMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SorthybridsplaysortMatrix::det(
  self : SorthybridsplaysortMatrix,
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
pub fn SorthybridsplaysortMatrix::norm(
  self : SorthybridsplaysortMatrix,
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
pub fn SorthybridsplaysortMatrix::to_string(
  self : SorthybridsplaysortMatrix,
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
pub(all) struct SorthybridsplaysortVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn sort_hybrid_splaysort_make_vector(
  comps : Array[Double],
) -> SorthybridsplaysortVector {
  { comps, dim: comps.length(), }
}

///|
pub fn sort_hybrid_splaysort_vector_zero(
  dim : Int32,
) -> SorthybridsplaysortVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SorthybridsplaysortVector::add(
  self : SorthybridsplaysortVector,
  other : SorthybridsplaysortVector,
) -> SorthybridsplaysortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SorthybridsplaysortVector::sub(
  self : SorthybridsplaysortVector,
  other : SorthybridsplaysortVector,
) -> SorthybridsplaysortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SorthybridsplaysortVector::scale(
  self : SorthybridsplaysortVector,
  s : Double,
) -> SorthybridsplaysortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SorthybridsplaysortVector::dot(
  self : SorthybridsplaysortVector,
  other : SorthybridsplaysortVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SorthybridsplaysortVector::norm(
  self : SorthybridsplaysortVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SorthybridsplaysortVector::normalize(
  self : SorthybridsplaysortVector,
) -> SorthybridsplaysortVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SorthybridsplaysortVector::dist(
  self : SorthybridsplaysortVector,
  other : SorthybridsplaysortVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SorthybridsplaysortVector::to_string(
  self : SorthybridsplaysortVector,
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
pub(all) struct SorthybridsplaysortFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_frame_make(
  size : Int32,
) -> SorthybridsplaysortFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortFrame::len(self : SorthybridsplaysortFrame) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortFrame::get(
  self : SorthybridsplaysortFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortFrame::set(
  self : SorthybridsplaysortFrame,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortFrame::sum(self : SorthybridsplaysortFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortFrame::mean(
  self : SorthybridsplaysortFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortFrame::scale(
  self : SorthybridsplaysortFrame,
  f : Double,
) -> SorthybridsplaysortFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortFrame::add(
  self : SorthybridsplaysortFrame,
  other : SorthybridsplaysortFrame,
) -> SorthybridsplaysortFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortFrame::copy(
  self : SorthybridsplaysortFrame,
) -> SorthybridsplaysortFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortFrame::fill(
  self : SorthybridsplaysortFrame,
  v : Double,
) -> SorthybridsplaysortFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortFrame::min(self : SorthybridsplaysortFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortFrame::max(self : SorthybridsplaysortFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortFrame::to_string(
  self : SorthybridsplaysortFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_table_make(
  size : Int32,
) -> SorthybridsplaysortTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortTable::len(self : SorthybridsplaysortTable) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortTable::get(
  self : SorthybridsplaysortTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortTable::set(
  self : SorthybridsplaysortTable,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortTable::sum(self : SorthybridsplaysortTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortTable::mean(
  self : SorthybridsplaysortTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortTable::scale(
  self : SorthybridsplaysortTable,
  f : Double,
) -> SorthybridsplaysortTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortTable::add(
  self : SorthybridsplaysortTable,
  other : SorthybridsplaysortTable,
) -> SorthybridsplaysortTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortTable::copy(
  self : SorthybridsplaysortTable,
) -> SorthybridsplaysortTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortTable::fill(
  self : SorthybridsplaysortTable,
  v : Double,
) -> SorthybridsplaysortTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortTable::min(self : SorthybridsplaysortTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortTable::max(self : SorthybridsplaysortTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortTable::to_string(
  self : SorthybridsplaysortTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_graphn_make(
  size : Int32,
) -> SorthybridsplaysortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortGraphN::len(
  self : SorthybridsplaysortGraphN,
) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortGraphN::get(
  self : SorthybridsplaysortGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortGraphN::set(
  self : SorthybridsplaysortGraphN,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortGraphN::sum(
  self : SorthybridsplaysortGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortGraphN::mean(
  self : SorthybridsplaysortGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortGraphN::scale(
  self : SorthybridsplaysortGraphN,
  f : Double,
) -> SorthybridsplaysortGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortGraphN::add(
  self : SorthybridsplaysortGraphN,
  other : SorthybridsplaysortGraphN,
) -> SorthybridsplaysortGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortGraphN::copy(
  self : SorthybridsplaysortGraphN,
) -> SorthybridsplaysortGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortGraphN::fill(
  self : SorthybridsplaysortGraphN,
  v : Double,
) -> SorthybridsplaysortGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortGraphN::min(
  self : SorthybridsplaysortGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortGraphN::max(
  self : SorthybridsplaysortGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortGraphN::to_string(
  self : SorthybridsplaysortGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_node_make(size : Int32) -> SorthybridsplaysortNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortNode::len(self : SorthybridsplaysortNode) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortNode::get(
  self : SorthybridsplaysortNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortNode::set(
  self : SorthybridsplaysortNode,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortNode::sum(self : SorthybridsplaysortNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortNode::mean(self : SorthybridsplaysortNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortNode::scale(
  self : SorthybridsplaysortNode,
  f : Double,
) -> SorthybridsplaysortNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortNode::add(
  self : SorthybridsplaysortNode,
  other : SorthybridsplaysortNode,
) -> SorthybridsplaysortNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortNode::copy(
  self : SorthybridsplaysortNode,
) -> SorthybridsplaysortNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortNode::fill(
  self : SorthybridsplaysortNode,
  v : Double,
) -> SorthybridsplaysortNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortNode::min(self : SorthybridsplaysortNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortNode::max(self : SorthybridsplaysortNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortNode::to_string(
  self : SorthybridsplaysortNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_edge_make(size : Int32) -> SorthybridsplaysortEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortEdge::len(self : SorthybridsplaysortEdge) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortEdge::get(
  self : SorthybridsplaysortEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortEdge::set(
  self : SorthybridsplaysortEdge,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortEdge::sum(self : SorthybridsplaysortEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortEdge::mean(self : SorthybridsplaysortEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortEdge::scale(
  self : SorthybridsplaysortEdge,
  f : Double,
) -> SorthybridsplaysortEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortEdge::add(
  self : SorthybridsplaysortEdge,
  other : SorthybridsplaysortEdge,
) -> SorthybridsplaysortEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortEdge::copy(
  self : SorthybridsplaysortEdge,
) -> SorthybridsplaysortEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortEdge::fill(
  self : SorthybridsplaysortEdge,
  v : Double,
) -> SorthybridsplaysortEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortEdge::min(self : SorthybridsplaysortEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortEdge::max(self : SorthybridsplaysortEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortEdge::to_string(
  self : SorthybridsplaysortEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_path_make(size : Int32) -> SorthybridsplaysortPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortPath::len(self : SorthybridsplaysortPath) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortPath::get(
  self : SorthybridsplaysortPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortPath::set(
  self : SorthybridsplaysortPath,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortPath::sum(self : SorthybridsplaysortPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortPath::mean(self : SorthybridsplaysortPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortPath::scale(
  self : SorthybridsplaysortPath,
  f : Double,
) -> SorthybridsplaysortPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortPath::add(
  self : SorthybridsplaysortPath,
  other : SorthybridsplaysortPath,
) -> SorthybridsplaysortPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortPath::copy(
  self : SorthybridsplaysortPath,
) -> SorthybridsplaysortPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortPath::fill(
  self : SorthybridsplaysortPath,
  v : Double,
) -> SorthybridsplaysortPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortPath::min(self : SorthybridsplaysortPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortPath::max(self : SorthybridsplaysortPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortPath::to_string(
  self : SorthybridsplaysortPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_cluster_make(
  size : Int32,
) -> SorthybridsplaysortCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortCluster::len(
  self : SorthybridsplaysortCluster,
) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortCluster::get(
  self : SorthybridsplaysortCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortCluster::set(
  self : SorthybridsplaysortCluster,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortCluster::sum(
  self : SorthybridsplaysortCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortCluster::mean(
  self : SorthybridsplaysortCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortCluster::scale(
  self : SorthybridsplaysortCluster,
  f : Double,
) -> SorthybridsplaysortCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortCluster::add(
  self : SorthybridsplaysortCluster,
  other : SorthybridsplaysortCluster,
) -> SorthybridsplaysortCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortCluster::copy(
  self : SorthybridsplaysortCluster,
) -> SorthybridsplaysortCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortCluster::fill(
  self : SorthybridsplaysortCluster,
  v : Double,
) -> SorthybridsplaysortCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortCluster::min(
  self : SorthybridsplaysortCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortCluster::max(
  self : SorthybridsplaysortCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortCluster::to_string(
  self : SorthybridsplaysortCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_model_make(
  size : Int32,
) -> SorthybridsplaysortModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortModel::len(self : SorthybridsplaysortModel) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortModel::get(
  self : SorthybridsplaysortModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortModel::set(
  self : SorthybridsplaysortModel,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortModel::sum(self : SorthybridsplaysortModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortModel::mean(
  self : SorthybridsplaysortModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortModel::scale(
  self : SorthybridsplaysortModel,
  f : Double,
) -> SorthybridsplaysortModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortModel::add(
  self : SorthybridsplaysortModel,
  other : SorthybridsplaysortModel,
) -> SorthybridsplaysortModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortModel::copy(
  self : SorthybridsplaysortModel,
) -> SorthybridsplaysortModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortModel::fill(
  self : SorthybridsplaysortModel,
  v : Double,
) -> SorthybridsplaysortModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortModel::min(self : SorthybridsplaysortModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortModel::max(self : SorthybridsplaysortModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortModel::to_string(
  self : SorthybridsplaysortModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_layer_make(
  size : Int32,
) -> SorthybridsplaysortLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortLayer::len(self : SorthybridsplaysortLayer) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortLayer::get(
  self : SorthybridsplaysortLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortLayer::set(
  self : SorthybridsplaysortLayer,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortLayer::sum(self : SorthybridsplaysortLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortLayer::mean(
  self : SorthybridsplaysortLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortLayer::scale(
  self : SorthybridsplaysortLayer,
  f : Double,
) -> SorthybridsplaysortLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortLayer::add(
  self : SorthybridsplaysortLayer,
  other : SorthybridsplaysortLayer,
) -> SorthybridsplaysortLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortLayer::copy(
  self : SorthybridsplaysortLayer,
) -> SorthybridsplaysortLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortLayer::fill(
  self : SorthybridsplaysortLayer,
  v : Double,
) -> SorthybridsplaysortLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortLayer::min(self : SorthybridsplaysortLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortLayer::max(self : SorthybridsplaysortLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortLayer::to_string(
  self : SorthybridsplaysortLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_buffer_make(
  size : Int32,
) -> SorthybridsplaysortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortBuffer::len(
  self : SorthybridsplaysortBuffer,
) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortBuffer::get(
  self : SorthybridsplaysortBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortBuffer::set(
  self : SorthybridsplaysortBuffer,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortBuffer::sum(
  self : SorthybridsplaysortBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortBuffer::mean(
  self : SorthybridsplaysortBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortBuffer::scale(
  self : SorthybridsplaysortBuffer,
  f : Double,
) -> SorthybridsplaysortBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortBuffer::add(
  self : SorthybridsplaysortBuffer,
  other : SorthybridsplaysortBuffer,
) -> SorthybridsplaysortBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortBuffer::copy(
  self : SorthybridsplaysortBuffer,
) -> SorthybridsplaysortBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortBuffer::fill(
  self : SorthybridsplaysortBuffer,
  v : Double,
) -> SorthybridsplaysortBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortBuffer::min(
  self : SorthybridsplaysortBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortBuffer::max(
  self : SorthybridsplaysortBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortBuffer::to_string(
  self : SorthybridsplaysortBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_cursor_make(
  size : Int32,
) -> SorthybridsplaysortCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortCursor::len(
  self : SorthybridsplaysortCursor,
) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortCursor::get(
  self : SorthybridsplaysortCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortCursor::set(
  self : SorthybridsplaysortCursor,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortCursor::sum(
  self : SorthybridsplaysortCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortCursor::mean(
  self : SorthybridsplaysortCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortCursor::scale(
  self : SorthybridsplaysortCursor,
  f : Double,
) -> SorthybridsplaysortCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortCursor::add(
  self : SorthybridsplaysortCursor,
  other : SorthybridsplaysortCursor,
) -> SorthybridsplaysortCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortCursor::copy(
  self : SorthybridsplaysortCursor,
) -> SorthybridsplaysortCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortCursor::fill(
  self : SorthybridsplaysortCursor,
  v : Double,
) -> SorthybridsplaysortCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortCursor::min(
  self : SorthybridsplaysortCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortCursor::max(
  self : SorthybridsplaysortCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortCursor::to_string(
  self : SorthybridsplaysortCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_view_make(size : Int32) -> SorthybridsplaysortView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortView::len(self : SorthybridsplaysortView) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortView::get(
  self : SorthybridsplaysortView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortView::set(
  self : SorthybridsplaysortView,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortView::sum(self : SorthybridsplaysortView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortView::mean(self : SorthybridsplaysortView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortView::scale(
  self : SorthybridsplaysortView,
  f : Double,
) -> SorthybridsplaysortView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortView::add(
  self : SorthybridsplaysortView,
  other : SorthybridsplaysortView,
) -> SorthybridsplaysortView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortView::copy(
  self : SorthybridsplaysortView,
) -> SorthybridsplaysortView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortView::fill(
  self : SorthybridsplaysortView,
  v : Double,
) -> SorthybridsplaysortView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortView::min(self : SorthybridsplaysortView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortView::max(self : SorthybridsplaysortView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortView::to_string(
  self : SorthybridsplaysortView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_range_make(
  size : Int32,
) -> SorthybridsplaysortRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortRange::len(self : SorthybridsplaysortRange) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortRange::get(
  self : SorthybridsplaysortRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortRange::set(
  self : SorthybridsplaysortRange,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortRange::sum(self : SorthybridsplaysortRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortRange::mean(
  self : SorthybridsplaysortRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortRange::scale(
  self : SorthybridsplaysortRange,
  f : Double,
) -> SorthybridsplaysortRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortRange::add(
  self : SorthybridsplaysortRange,
  other : SorthybridsplaysortRange,
) -> SorthybridsplaysortRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortRange::copy(
  self : SorthybridsplaysortRange,
) -> SorthybridsplaysortRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortRange::fill(
  self : SorthybridsplaysortRange,
  v : Double,
) -> SorthybridsplaysortRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortRange::min(self : SorthybridsplaysortRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortRange::max(self : SorthybridsplaysortRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortRange::to_string(
  self : SorthybridsplaysortRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SorthybridsplaysortSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_hybrid_splaysort_slice_make(
  size : Int32,
) -> SorthybridsplaysortSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SorthybridsplaysortSlice::len(self : SorthybridsplaysortSlice) -> Int32 {
  self.size
}

///|
pub fn SorthybridsplaysortSlice::get(
  self : SorthybridsplaysortSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SorthybridsplaysortSlice::set(
  self : SorthybridsplaysortSlice,
  i : Int32,
  v : Double,
) -> SorthybridsplaysortSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortSlice::sum(self : SorthybridsplaysortSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SorthybridsplaysortSlice::mean(
  self : SorthybridsplaysortSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SorthybridsplaysortSlice::scale(
  self : SorthybridsplaysortSlice,
  f : Double,
) -> SorthybridsplaysortSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortSlice::add(
  self : SorthybridsplaysortSlice,
  other : SorthybridsplaysortSlice,
) -> SorthybridsplaysortSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortSlice::copy(
  self : SorthybridsplaysortSlice,
) -> SorthybridsplaysortSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortSlice::fill(
  self : SorthybridsplaysortSlice,
  v : Double,
) -> SorthybridsplaysortSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SorthybridsplaysortSlice::min(self : SorthybridsplaysortSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SorthybridsplaysortSlice::max(self : SorthybridsplaysortSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SorthybridsplaysortSlice::to_string(
  self : SorthybridsplaysortSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
