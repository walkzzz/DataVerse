///|
///===
/// extcore/sort_compare_insertion
pub(all) struct SortcompareinsertionPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn sort_compare_insertion_make_point(
  x : Double,
  y : Double,
) -> SortcompareinsertionPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn sort_compare_insertion_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SortcompareinsertionPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SortcompareinsertionPoint::x(self : SortcompareinsertionPoint) -> Double {
  self.x
}

///|
pub fn SortcompareinsertionPoint::y(self : SortcompareinsertionPoint) -> Double {
  self.y
}

///|
pub fn SortcompareinsertionPoint::z(self : SortcompareinsertionPoint) -> Double {
  self.z
}

///|
pub fn SortcompareinsertionPoint::label(
  self : SortcompareinsertionPoint,
) -> Int32 {
  self.label
}

///|
pub fn SortcompareinsertionPoint::dist(
  self : SortcompareinsertionPoint,
  other : SortcompareinsertionPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SortcompareinsertionPoint::add(
  self : SortcompareinsertionPoint,
  other : SortcompareinsertionPoint,
) -> SortcompareinsertionPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SortcompareinsertionPoint::sub(
  self : SortcompareinsertionPoint,
  other : SortcompareinsertionPoint,
) -> SortcompareinsertionPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SortcompareinsertionPoint::scale(
  self : SortcompareinsertionPoint,
  s : Double,
) -> SortcompareinsertionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SortcompareinsertionPoint::dot(
  self : SortcompareinsertionPoint,
  other : SortcompareinsertionPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SortcompareinsertionPoint::cross(
  self : SortcompareinsertionPoint,
  other : SortcompareinsertionPoint,
) -> SortcompareinsertionPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SortcompareinsertionPoint::norm(
  self : SortcompareinsertionPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SortcompareinsertionPoint::normalize(
  self : SortcompareinsertionPoint,
) -> SortcompareinsertionPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortcompareinsertionPoint::negate(
  self : SortcompareinsertionPoint,
) -> SortcompareinsertionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SortcompareinsertionPoint::mid(
  self : SortcompareinsertionPoint,
  other : SortcompareinsertionPoint,
) -> SortcompareinsertionPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SortcompareinsertionPoint::lerp(
  self : SortcompareinsertionPoint,
  other : SortcompareinsertionPoint,
  t : Double,
) -> SortcompareinsertionPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SortcompareinsertionPoint::to_string(
  self : SortcompareinsertionPoint,
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
pub(all) struct SortcompareinsertionSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn sort_compare_insertion_make_series(
  vals : Array[Double],
  name : String,
) -> SortcompareinsertionSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SortcompareinsertionSeries::len(
  self : SortcompareinsertionSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn SortcompareinsertionSeries::sum(
  self : SortcompareinsertionSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SortcompareinsertionSeries::mean(
  self : SortcompareinsertionSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SortcompareinsertionSeries::min(
  self : SortcompareinsertionSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SortcompareinsertionSeries::max(
  self : SortcompareinsertionSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SortcompareinsertionSeries::range(
  self : SortcompareinsertionSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SortcompareinsertionSeries::variance(
  self : SortcompareinsertionSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SortcompareinsertionSeries::std(
  self : SortcompareinsertionSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SortcompareinsertionSeries::median(
  self : SortcompareinsertionSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SortcompareinsertionSeries::scale(
  self : SortcompareinsertionSeries,
  f : Double,
) -> SortcompareinsertionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SortcompareinsertionSeries::add(
  self : SortcompareinsertionSeries,
  other : SortcompareinsertionSeries,
) -> SortcompareinsertionSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortcompareinsertionSeries::sub(
  self : SortcompareinsertionSeries,
  other : SortcompareinsertionSeries,
) -> SortcompareinsertionSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortcompareinsertionSeries::normalize(
  self : SortcompareinsertionSeries,
) -> SortcompareinsertionSeries {
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
pub fn SortcompareinsertionSeries::cumsum(
  self : SortcompareinsertionSeries,
) -> SortcompareinsertionSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SortcompareinsertionSeries::to_string(
  self : SortcompareinsertionSeries,
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
pub(all) struct SortcompareinsertionMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn sort_compare_insertion_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SortcompareinsertionMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn sort_compare_insertion_matrix_identity(
  n : Int32,
) -> SortcompareinsertionMatrix {
  let m = sort_compare_insertion_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SortcompareinsertionMatrix::get(
  self : SortcompareinsertionMatrix,
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
pub fn SortcompareinsertionMatrix::transpose(
  self : SortcompareinsertionMatrix,
) -> SortcompareinsertionMatrix {
  let result = sort_compare_insertion_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SortcompareinsertionMatrix::add(
  self : SortcompareinsertionMatrix,
  other : SortcompareinsertionMatrix,
) -> SortcompareinsertionMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = sort_compare_insertion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SortcompareinsertionMatrix::scale(
  self : SortcompareinsertionMatrix,
  s : Double,
) -> SortcompareinsertionMatrix {
  let result = sort_compare_insertion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SortcompareinsertionMatrix::multiply(
  self : SortcompareinsertionMatrix,
  other : SortcompareinsertionMatrix,
) -> SortcompareinsertionMatrix {
  if self.cols != other.rows {
    return sort_compare_insertion_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = sort_compare_insertion_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SortcompareinsertionMatrix::trace(
  self : SortcompareinsertionMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SortcompareinsertionMatrix::det(
  self : SortcompareinsertionMatrix,
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
pub fn SortcompareinsertionMatrix::norm(
  self : SortcompareinsertionMatrix,
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
pub fn SortcompareinsertionMatrix::to_string(
  self : SortcompareinsertionMatrix,
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
pub(all) struct SortcompareinsertionVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn sort_compare_insertion_make_vector(
  comps : Array[Double],
) -> SortcompareinsertionVector {
  { comps, dim: comps.length(), }
}

///|
pub fn sort_compare_insertion_vector_zero(
  dim : Int32,
) -> SortcompareinsertionVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SortcompareinsertionVector::add(
  self : SortcompareinsertionVector,
  other : SortcompareinsertionVector,
) -> SortcompareinsertionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortcompareinsertionVector::sub(
  self : SortcompareinsertionVector,
  other : SortcompareinsertionVector,
) -> SortcompareinsertionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortcompareinsertionVector::scale(
  self : SortcompareinsertionVector,
  s : Double,
) -> SortcompareinsertionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SortcompareinsertionVector::dot(
  self : SortcompareinsertionVector,
  other : SortcompareinsertionVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SortcompareinsertionVector::norm(
  self : SortcompareinsertionVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SortcompareinsertionVector::normalize(
  self : SortcompareinsertionVector,
) -> SortcompareinsertionVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortcompareinsertionVector::dist(
  self : SortcompareinsertionVector,
  other : SortcompareinsertionVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SortcompareinsertionVector::to_string(
  self : SortcompareinsertionVector,
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
pub(all) struct SortcompareinsertionFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_frame_make(
  size : Int32,
) -> SortcompareinsertionFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionFrame::len(
  self : SortcompareinsertionFrame,
) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionFrame::get(
  self : SortcompareinsertionFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionFrame::set(
  self : SortcompareinsertionFrame,
  i : Int32,
  v : Double,
) -> SortcompareinsertionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionFrame::sum(
  self : SortcompareinsertionFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionFrame::mean(
  self : SortcompareinsertionFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionFrame::scale(
  self : SortcompareinsertionFrame,
  f : Double,
) -> SortcompareinsertionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionFrame::add(
  self : SortcompareinsertionFrame,
  other : SortcompareinsertionFrame,
) -> SortcompareinsertionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionFrame::copy(
  self : SortcompareinsertionFrame,
) -> SortcompareinsertionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionFrame::fill(
  self : SortcompareinsertionFrame,
  v : Double,
) -> SortcompareinsertionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionFrame::min(
  self : SortcompareinsertionFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionFrame::max(
  self : SortcompareinsertionFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionFrame::to_string(
  self : SortcompareinsertionFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_table_make(
  size : Int32,
) -> SortcompareinsertionTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionTable::len(
  self : SortcompareinsertionTable,
) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionTable::get(
  self : SortcompareinsertionTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionTable::set(
  self : SortcompareinsertionTable,
  i : Int32,
  v : Double,
) -> SortcompareinsertionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionTable::sum(
  self : SortcompareinsertionTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionTable::mean(
  self : SortcompareinsertionTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionTable::scale(
  self : SortcompareinsertionTable,
  f : Double,
) -> SortcompareinsertionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionTable::add(
  self : SortcompareinsertionTable,
  other : SortcompareinsertionTable,
) -> SortcompareinsertionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionTable::copy(
  self : SortcompareinsertionTable,
) -> SortcompareinsertionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionTable::fill(
  self : SortcompareinsertionTable,
  v : Double,
) -> SortcompareinsertionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionTable::min(
  self : SortcompareinsertionTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionTable::max(
  self : SortcompareinsertionTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionTable::to_string(
  self : SortcompareinsertionTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_graphn_make(
  size : Int32,
) -> SortcompareinsertionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionGraphN::len(
  self : SortcompareinsertionGraphN,
) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionGraphN::get(
  self : SortcompareinsertionGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionGraphN::set(
  self : SortcompareinsertionGraphN,
  i : Int32,
  v : Double,
) -> SortcompareinsertionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionGraphN::sum(
  self : SortcompareinsertionGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionGraphN::mean(
  self : SortcompareinsertionGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionGraphN::scale(
  self : SortcompareinsertionGraphN,
  f : Double,
) -> SortcompareinsertionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionGraphN::add(
  self : SortcompareinsertionGraphN,
  other : SortcompareinsertionGraphN,
) -> SortcompareinsertionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionGraphN::copy(
  self : SortcompareinsertionGraphN,
) -> SortcompareinsertionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionGraphN::fill(
  self : SortcompareinsertionGraphN,
  v : Double,
) -> SortcompareinsertionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionGraphN::min(
  self : SortcompareinsertionGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionGraphN::max(
  self : SortcompareinsertionGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionGraphN::to_string(
  self : SortcompareinsertionGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_node_make(
  size : Int32,
) -> SortcompareinsertionNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionNode::len(self : SortcompareinsertionNode) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionNode::get(
  self : SortcompareinsertionNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionNode::set(
  self : SortcompareinsertionNode,
  i : Int32,
  v : Double,
) -> SortcompareinsertionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionNode::sum(self : SortcompareinsertionNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionNode::mean(
  self : SortcompareinsertionNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionNode::scale(
  self : SortcompareinsertionNode,
  f : Double,
) -> SortcompareinsertionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionNode::add(
  self : SortcompareinsertionNode,
  other : SortcompareinsertionNode,
) -> SortcompareinsertionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionNode::copy(
  self : SortcompareinsertionNode,
) -> SortcompareinsertionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionNode::fill(
  self : SortcompareinsertionNode,
  v : Double,
) -> SortcompareinsertionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionNode::min(self : SortcompareinsertionNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionNode::max(self : SortcompareinsertionNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionNode::to_string(
  self : SortcompareinsertionNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_edge_make(
  size : Int32,
) -> SortcompareinsertionEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionEdge::len(self : SortcompareinsertionEdge) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionEdge::get(
  self : SortcompareinsertionEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionEdge::set(
  self : SortcompareinsertionEdge,
  i : Int32,
  v : Double,
) -> SortcompareinsertionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionEdge::sum(self : SortcompareinsertionEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionEdge::mean(
  self : SortcompareinsertionEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionEdge::scale(
  self : SortcompareinsertionEdge,
  f : Double,
) -> SortcompareinsertionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionEdge::add(
  self : SortcompareinsertionEdge,
  other : SortcompareinsertionEdge,
) -> SortcompareinsertionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionEdge::copy(
  self : SortcompareinsertionEdge,
) -> SortcompareinsertionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionEdge::fill(
  self : SortcompareinsertionEdge,
  v : Double,
) -> SortcompareinsertionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionEdge::min(self : SortcompareinsertionEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionEdge::max(self : SortcompareinsertionEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionEdge::to_string(
  self : SortcompareinsertionEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_path_make(
  size : Int32,
) -> SortcompareinsertionPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionPath::len(self : SortcompareinsertionPath) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionPath::get(
  self : SortcompareinsertionPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionPath::set(
  self : SortcompareinsertionPath,
  i : Int32,
  v : Double,
) -> SortcompareinsertionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionPath::sum(self : SortcompareinsertionPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionPath::mean(
  self : SortcompareinsertionPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionPath::scale(
  self : SortcompareinsertionPath,
  f : Double,
) -> SortcompareinsertionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionPath::add(
  self : SortcompareinsertionPath,
  other : SortcompareinsertionPath,
) -> SortcompareinsertionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionPath::copy(
  self : SortcompareinsertionPath,
) -> SortcompareinsertionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionPath::fill(
  self : SortcompareinsertionPath,
  v : Double,
) -> SortcompareinsertionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionPath::min(self : SortcompareinsertionPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionPath::max(self : SortcompareinsertionPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionPath::to_string(
  self : SortcompareinsertionPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_cluster_make(
  size : Int32,
) -> SortcompareinsertionCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionCluster::len(
  self : SortcompareinsertionCluster,
) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionCluster::get(
  self : SortcompareinsertionCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionCluster::set(
  self : SortcompareinsertionCluster,
  i : Int32,
  v : Double,
) -> SortcompareinsertionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionCluster::sum(
  self : SortcompareinsertionCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionCluster::mean(
  self : SortcompareinsertionCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionCluster::scale(
  self : SortcompareinsertionCluster,
  f : Double,
) -> SortcompareinsertionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionCluster::add(
  self : SortcompareinsertionCluster,
  other : SortcompareinsertionCluster,
) -> SortcompareinsertionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionCluster::copy(
  self : SortcompareinsertionCluster,
) -> SortcompareinsertionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionCluster::fill(
  self : SortcompareinsertionCluster,
  v : Double,
) -> SortcompareinsertionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionCluster::min(
  self : SortcompareinsertionCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionCluster::max(
  self : SortcompareinsertionCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionCluster::to_string(
  self : SortcompareinsertionCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_model_make(
  size : Int32,
) -> SortcompareinsertionModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionModel::len(
  self : SortcompareinsertionModel,
) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionModel::get(
  self : SortcompareinsertionModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionModel::set(
  self : SortcompareinsertionModel,
  i : Int32,
  v : Double,
) -> SortcompareinsertionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionModel::sum(
  self : SortcompareinsertionModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionModel::mean(
  self : SortcompareinsertionModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionModel::scale(
  self : SortcompareinsertionModel,
  f : Double,
) -> SortcompareinsertionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionModel::add(
  self : SortcompareinsertionModel,
  other : SortcompareinsertionModel,
) -> SortcompareinsertionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionModel::copy(
  self : SortcompareinsertionModel,
) -> SortcompareinsertionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionModel::fill(
  self : SortcompareinsertionModel,
  v : Double,
) -> SortcompareinsertionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionModel::min(
  self : SortcompareinsertionModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionModel::max(
  self : SortcompareinsertionModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionModel::to_string(
  self : SortcompareinsertionModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_layer_make(
  size : Int32,
) -> SortcompareinsertionLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionLayer::len(
  self : SortcompareinsertionLayer,
) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionLayer::get(
  self : SortcompareinsertionLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionLayer::set(
  self : SortcompareinsertionLayer,
  i : Int32,
  v : Double,
) -> SortcompareinsertionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionLayer::sum(
  self : SortcompareinsertionLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionLayer::mean(
  self : SortcompareinsertionLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionLayer::scale(
  self : SortcompareinsertionLayer,
  f : Double,
) -> SortcompareinsertionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionLayer::add(
  self : SortcompareinsertionLayer,
  other : SortcompareinsertionLayer,
) -> SortcompareinsertionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionLayer::copy(
  self : SortcompareinsertionLayer,
) -> SortcompareinsertionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionLayer::fill(
  self : SortcompareinsertionLayer,
  v : Double,
) -> SortcompareinsertionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionLayer::min(
  self : SortcompareinsertionLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionLayer::max(
  self : SortcompareinsertionLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionLayer::to_string(
  self : SortcompareinsertionLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_buffer_make(
  size : Int32,
) -> SortcompareinsertionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionBuffer::len(
  self : SortcompareinsertionBuffer,
) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionBuffer::get(
  self : SortcompareinsertionBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionBuffer::set(
  self : SortcompareinsertionBuffer,
  i : Int32,
  v : Double,
) -> SortcompareinsertionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionBuffer::sum(
  self : SortcompareinsertionBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionBuffer::mean(
  self : SortcompareinsertionBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionBuffer::scale(
  self : SortcompareinsertionBuffer,
  f : Double,
) -> SortcompareinsertionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionBuffer::add(
  self : SortcompareinsertionBuffer,
  other : SortcompareinsertionBuffer,
) -> SortcompareinsertionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionBuffer::copy(
  self : SortcompareinsertionBuffer,
) -> SortcompareinsertionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionBuffer::fill(
  self : SortcompareinsertionBuffer,
  v : Double,
) -> SortcompareinsertionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionBuffer::min(
  self : SortcompareinsertionBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionBuffer::max(
  self : SortcompareinsertionBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionBuffer::to_string(
  self : SortcompareinsertionBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_cursor_make(
  size : Int32,
) -> SortcompareinsertionCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionCursor::len(
  self : SortcompareinsertionCursor,
) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionCursor::get(
  self : SortcompareinsertionCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionCursor::set(
  self : SortcompareinsertionCursor,
  i : Int32,
  v : Double,
) -> SortcompareinsertionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionCursor::sum(
  self : SortcompareinsertionCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionCursor::mean(
  self : SortcompareinsertionCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionCursor::scale(
  self : SortcompareinsertionCursor,
  f : Double,
) -> SortcompareinsertionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionCursor::add(
  self : SortcompareinsertionCursor,
  other : SortcompareinsertionCursor,
) -> SortcompareinsertionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionCursor::copy(
  self : SortcompareinsertionCursor,
) -> SortcompareinsertionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionCursor::fill(
  self : SortcompareinsertionCursor,
  v : Double,
) -> SortcompareinsertionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionCursor::min(
  self : SortcompareinsertionCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionCursor::max(
  self : SortcompareinsertionCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionCursor::to_string(
  self : SortcompareinsertionCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_view_make(
  size : Int32,
) -> SortcompareinsertionView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionView::len(self : SortcompareinsertionView) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionView::get(
  self : SortcompareinsertionView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionView::set(
  self : SortcompareinsertionView,
  i : Int32,
  v : Double,
) -> SortcompareinsertionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionView::sum(self : SortcompareinsertionView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionView::mean(
  self : SortcompareinsertionView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionView::scale(
  self : SortcompareinsertionView,
  f : Double,
) -> SortcompareinsertionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionView::add(
  self : SortcompareinsertionView,
  other : SortcompareinsertionView,
) -> SortcompareinsertionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionView::copy(
  self : SortcompareinsertionView,
) -> SortcompareinsertionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionView::fill(
  self : SortcompareinsertionView,
  v : Double,
) -> SortcompareinsertionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionView::min(self : SortcompareinsertionView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionView::max(self : SortcompareinsertionView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionView::to_string(
  self : SortcompareinsertionView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_range_make(
  size : Int32,
) -> SortcompareinsertionRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionRange::len(
  self : SortcompareinsertionRange,
) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionRange::get(
  self : SortcompareinsertionRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionRange::set(
  self : SortcompareinsertionRange,
  i : Int32,
  v : Double,
) -> SortcompareinsertionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionRange::sum(
  self : SortcompareinsertionRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionRange::mean(
  self : SortcompareinsertionRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionRange::scale(
  self : SortcompareinsertionRange,
  f : Double,
) -> SortcompareinsertionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionRange::add(
  self : SortcompareinsertionRange,
  other : SortcompareinsertionRange,
) -> SortcompareinsertionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionRange::copy(
  self : SortcompareinsertionRange,
) -> SortcompareinsertionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionRange::fill(
  self : SortcompareinsertionRange,
  v : Double,
) -> SortcompareinsertionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionRange::min(
  self : SortcompareinsertionRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionRange::max(
  self : SortcompareinsertionRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionRange::to_string(
  self : SortcompareinsertionRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortcompareinsertionSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_compare_insertion_slice_make(
  size : Int32,
) -> SortcompareinsertionSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortcompareinsertionSlice::len(
  self : SortcompareinsertionSlice,
) -> Int32 {
  self.size
}

///|
pub fn SortcompareinsertionSlice::get(
  self : SortcompareinsertionSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortcompareinsertionSlice::set(
  self : SortcompareinsertionSlice,
  i : Int32,
  v : Double,
) -> SortcompareinsertionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionSlice::sum(
  self : SortcompareinsertionSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortcompareinsertionSlice::mean(
  self : SortcompareinsertionSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortcompareinsertionSlice::scale(
  self : SortcompareinsertionSlice,
  f : Double,
) -> SortcompareinsertionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionSlice::add(
  self : SortcompareinsertionSlice,
  other : SortcompareinsertionSlice,
) -> SortcompareinsertionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortcompareinsertionSlice::copy(
  self : SortcompareinsertionSlice,
) -> SortcompareinsertionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionSlice::fill(
  self : SortcompareinsertionSlice,
  v : Double,
) -> SortcompareinsertionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortcompareinsertionSlice::min(
  self : SortcompareinsertionSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortcompareinsertionSlice::max(
  self : SortcompareinsertionSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortcompareinsertionSlice::to_string(
  self : SortcompareinsertionSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
