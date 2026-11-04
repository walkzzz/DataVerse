///|
///===
/// extcore/stats_dist_cauchy
pub(all) struct StatsdistcauchyPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_dist_cauchy_make_point(
  x : Double,
  y : Double,
) -> StatsdistcauchyPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_dist_cauchy_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatsdistcauchyPoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatsdistcauchyPoint::x(self : StatsdistcauchyPoint) -> Double {
  self.x
}

///|
pub fn StatsdistcauchyPoint::y(self : StatsdistcauchyPoint) -> Double {
  self.y
}

///|
pub fn StatsdistcauchyPoint::z(self : StatsdistcauchyPoint) -> Double {
  self.z
}

///|
pub fn StatsdistcauchyPoint::label(self : StatsdistcauchyPoint) -> Int32 {
  self.label
}

///|
pub fn StatsdistcauchyPoint::dist(
  self : StatsdistcauchyPoint,
  other : StatsdistcauchyPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatsdistcauchyPoint::add(
  self : StatsdistcauchyPoint,
  other : StatsdistcauchyPoint,
) -> StatsdistcauchyPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatsdistcauchyPoint::sub(
  self : StatsdistcauchyPoint,
  other : StatsdistcauchyPoint,
) -> StatsdistcauchyPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatsdistcauchyPoint::scale(
  self : StatsdistcauchyPoint,
  s : Double,
) -> StatsdistcauchyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatsdistcauchyPoint::dot(
  self : StatsdistcauchyPoint,
  other : StatsdistcauchyPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatsdistcauchyPoint::cross(
  self : StatsdistcauchyPoint,
  other : StatsdistcauchyPoint,
) -> StatsdistcauchyPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatsdistcauchyPoint::norm(self : StatsdistcauchyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatsdistcauchyPoint::normalize(
  self : StatsdistcauchyPoint,
) -> StatsdistcauchyPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdistcauchyPoint::negate(
  self : StatsdistcauchyPoint,
) -> StatsdistcauchyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatsdistcauchyPoint::mid(
  self : StatsdistcauchyPoint,
  other : StatsdistcauchyPoint,
) -> StatsdistcauchyPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatsdistcauchyPoint::lerp(
  self : StatsdistcauchyPoint,
  other : StatsdistcauchyPoint,
  t : Double,
) -> StatsdistcauchyPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatsdistcauchyPoint::to_string(self : StatsdistcauchyPoint) -> String {
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
pub(all) struct StatsdistcauchySeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_dist_cauchy_make_series(
  vals : Array[Double],
  name : String,
) -> StatsdistcauchySeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatsdistcauchySeries::len(self : StatsdistcauchySeries) -> Int32 {
  self.vals.length()
}

///|
pub fn StatsdistcauchySeries::sum(self : StatsdistcauchySeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatsdistcauchySeries::mean(self : StatsdistcauchySeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatsdistcauchySeries::min(self : StatsdistcauchySeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatsdistcauchySeries::max(self : StatsdistcauchySeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatsdistcauchySeries::range(self : StatsdistcauchySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatsdistcauchySeries::variance(self : StatsdistcauchySeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatsdistcauchySeries::std(self : StatsdistcauchySeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatsdistcauchySeries::median(self : StatsdistcauchySeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatsdistcauchySeries::scale(
  self : StatsdistcauchySeries,
  f : Double,
) -> StatsdistcauchySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatsdistcauchySeries::add(
  self : StatsdistcauchySeries,
  other : StatsdistcauchySeries,
) -> StatsdistcauchySeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdistcauchySeries::sub(
  self : StatsdistcauchySeries,
  other : StatsdistcauchySeries,
) -> StatsdistcauchySeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdistcauchySeries::normalize(
  self : StatsdistcauchySeries,
) -> StatsdistcauchySeries {
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
pub fn StatsdistcauchySeries::cumsum(
  self : StatsdistcauchySeries,
) -> StatsdistcauchySeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatsdistcauchySeries::to_string(self : StatsdistcauchySeries) -> String {
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
pub(all) struct StatsdistcauchyMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_dist_cauchy_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatsdistcauchyMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_dist_cauchy_matrix_identity(n : Int32) -> StatsdistcauchyMatrix {
  let m = stats_dist_cauchy_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatsdistcauchyMatrix::get(
  self : StatsdistcauchyMatrix,
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
pub fn StatsdistcauchyMatrix::transpose(
  self : StatsdistcauchyMatrix,
) -> StatsdistcauchyMatrix {
  let result = stats_dist_cauchy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdistcauchyMatrix::add(
  self : StatsdistcauchyMatrix,
  other : StatsdistcauchyMatrix,
) -> StatsdistcauchyMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_dist_cauchy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdistcauchyMatrix::scale(
  self : StatsdistcauchyMatrix,
  s : Double,
) -> StatsdistcauchyMatrix {
  let result = stats_dist_cauchy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatsdistcauchyMatrix::multiply(
  self : StatsdistcauchyMatrix,
  other : StatsdistcauchyMatrix,
) -> StatsdistcauchyMatrix {
  if self.cols != other.rows {
    return stats_dist_cauchy_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_dist_cauchy_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatsdistcauchyMatrix::trace(self : StatsdistcauchyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatsdistcauchyMatrix::det(self : StatsdistcauchyMatrix) -> Double {
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
pub fn StatsdistcauchyMatrix::norm(self : StatsdistcauchyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn StatsdistcauchyMatrix::to_string(self : StatsdistcauchyMatrix) -> String {
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
pub(all) struct StatsdistcauchyVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_dist_cauchy_make_vector(
  comps : Array[Double],
) -> StatsdistcauchyVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_dist_cauchy_vector_zero(dim : Int32) -> StatsdistcauchyVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatsdistcauchyVector::add(
  self : StatsdistcauchyVector,
  other : StatsdistcauchyVector,
) -> StatsdistcauchyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdistcauchyVector::sub(
  self : StatsdistcauchyVector,
  other : StatsdistcauchyVector,
) -> StatsdistcauchyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdistcauchyVector::scale(
  self : StatsdistcauchyVector,
  s : Double,
) -> StatsdistcauchyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatsdistcauchyVector::dot(
  self : StatsdistcauchyVector,
  other : StatsdistcauchyVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatsdistcauchyVector::norm(self : StatsdistcauchyVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatsdistcauchyVector::normalize(
  self : StatsdistcauchyVector,
) -> StatsdistcauchyVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdistcauchyVector::dist(
  self : StatsdistcauchyVector,
  other : StatsdistcauchyVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatsdistcauchyVector::to_string(self : StatsdistcauchyVector) -> String {
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
pub(all) struct StatsdistcauchyFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_frame_make(size : Int32) -> StatsdistcauchyFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyFrame::len(self : StatsdistcauchyFrame) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyFrame::get(
  self : StatsdistcauchyFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyFrame::set(
  self : StatsdistcauchyFrame,
  i : Int32,
  v : Double,
) -> StatsdistcauchyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyFrame::sum(self : StatsdistcauchyFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyFrame::mean(self : StatsdistcauchyFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyFrame::scale(
  self : StatsdistcauchyFrame,
  f : Double,
) -> StatsdistcauchyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyFrame::add(
  self : StatsdistcauchyFrame,
  other : StatsdistcauchyFrame,
) -> StatsdistcauchyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyFrame::copy(
  self : StatsdistcauchyFrame,
) -> StatsdistcauchyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyFrame::fill(
  self : StatsdistcauchyFrame,
  v : Double,
) -> StatsdistcauchyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyFrame::min(self : StatsdistcauchyFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyFrame::max(self : StatsdistcauchyFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyFrame::to_string(self : StatsdistcauchyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_table_make(size : Int32) -> StatsdistcauchyTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyTable::len(self : StatsdistcauchyTable) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyTable::get(
  self : StatsdistcauchyTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyTable::set(
  self : StatsdistcauchyTable,
  i : Int32,
  v : Double,
) -> StatsdistcauchyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyTable::sum(self : StatsdistcauchyTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyTable::mean(self : StatsdistcauchyTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyTable::scale(
  self : StatsdistcauchyTable,
  f : Double,
) -> StatsdistcauchyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyTable::add(
  self : StatsdistcauchyTable,
  other : StatsdistcauchyTable,
) -> StatsdistcauchyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyTable::copy(
  self : StatsdistcauchyTable,
) -> StatsdistcauchyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyTable::fill(
  self : StatsdistcauchyTable,
  v : Double,
) -> StatsdistcauchyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyTable::min(self : StatsdistcauchyTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyTable::max(self : StatsdistcauchyTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyTable::to_string(self : StatsdistcauchyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_graphn_make(size : Int32) -> StatsdistcauchyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyGraphN::len(self : StatsdistcauchyGraphN) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyGraphN::get(
  self : StatsdistcauchyGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyGraphN::set(
  self : StatsdistcauchyGraphN,
  i : Int32,
  v : Double,
) -> StatsdistcauchyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyGraphN::sum(self : StatsdistcauchyGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyGraphN::mean(self : StatsdistcauchyGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyGraphN::scale(
  self : StatsdistcauchyGraphN,
  f : Double,
) -> StatsdistcauchyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyGraphN::add(
  self : StatsdistcauchyGraphN,
  other : StatsdistcauchyGraphN,
) -> StatsdistcauchyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyGraphN::copy(
  self : StatsdistcauchyGraphN,
) -> StatsdistcauchyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyGraphN::fill(
  self : StatsdistcauchyGraphN,
  v : Double,
) -> StatsdistcauchyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyGraphN::min(self : StatsdistcauchyGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyGraphN::max(self : StatsdistcauchyGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyGraphN::to_string(self : StatsdistcauchyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_node_make(size : Int32) -> StatsdistcauchyNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyNode::len(self : StatsdistcauchyNode) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyNode::get(
  self : StatsdistcauchyNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyNode::set(
  self : StatsdistcauchyNode,
  i : Int32,
  v : Double,
) -> StatsdistcauchyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyNode::sum(self : StatsdistcauchyNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyNode::mean(self : StatsdistcauchyNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyNode::scale(
  self : StatsdistcauchyNode,
  f : Double,
) -> StatsdistcauchyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyNode::add(
  self : StatsdistcauchyNode,
  other : StatsdistcauchyNode,
) -> StatsdistcauchyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyNode::copy(
  self : StatsdistcauchyNode,
) -> StatsdistcauchyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyNode::fill(
  self : StatsdistcauchyNode,
  v : Double,
) -> StatsdistcauchyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyNode::min(self : StatsdistcauchyNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyNode::max(self : StatsdistcauchyNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyNode::to_string(self : StatsdistcauchyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_edge_make(size : Int32) -> StatsdistcauchyEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyEdge::len(self : StatsdistcauchyEdge) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyEdge::get(
  self : StatsdistcauchyEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyEdge::set(
  self : StatsdistcauchyEdge,
  i : Int32,
  v : Double,
) -> StatsdistcauchyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyEdge::sum(self : StatsdistcauchyEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyEdge::mean(self : StatsdistcauchyEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyEdge::scale(
  self : StatsdistcauchyEdge,
  f : Double,
) -> StatsdistcauchyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyEdge::add(
  self : StatsdistcauchyEdge,
  other : StatsdistcauchyEdge,
) -> StatsdistcauchyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyEdge::copy(
  self : StatsdistcauchyEdge,
) -> StatsdistcauchyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyEdge::fill(
  self : StatsdistcauchyEdge,
  v : Double,
) -> StatsdistcauchyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyEdge::min(self : StatsdistcauchyEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyEdge::max(self : StatsdistcauchyEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyEdge::to_string(self : StatsdistcauchyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_path_make(size : Int32) -> StatsdistcauchyPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyPath::len(self : StatsdistcauchyPath) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyPath::get(
  self : StatsdistcauchyPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyPath::set(
  self : StatsdistcauchyPath,
  i : Int32,
  v : Double,
) -> StatsdistcauchyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyPath::sum(self : StatsdistcauchyPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyPath::mean(self : StatsdistcauchyPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyPath::scale(
  self : StatsdistcauchyPath,
  f : Double,
) -> StatsdistcauchyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyPath::add(
  self : StatsdistcauchyPath,
  other : StatsdistcauchyPath,
) -> StatsdistcauchyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyPath::copy(
  self : StatsdistcauchyPath,
) -> StatsdistcauchyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyPath::fill(
  self : StatsdistcauchyPath,
  v : Double,
) -> StatsdistcauchyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyPath::min(self : StatsdistcauchyPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyPath::max(self : StatsdistcauchyPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyPath::to_string(self : StatsdistcauchyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_cluster_make(size : Int32) -> StatsdistcauchyCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyCluster::len(self : StatsdistcauchyCluster) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyCluster::get(
  self : StatsdistcauchyCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyCluster::set(
  self : StatsdistcauchyCluster,
  i : Int32,
  v : Double,
) -> StatsdistcauchyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyCluster::sum(self : StatsdistcauchyCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyCluster::mean(self : StatsdistcauchyCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyCluster::scale(
  self : StatsdistcauchyCluster,
  f : Double,
) -> StatsdistcauchyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyCluster::add(
  self : StatsdistcauchyCluster,
  other : StatsdistcauchyCluster,
) -> StatsdistcauchyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyCluster::copy(
  self : StatsdistcauchyCluster,
) -> StatsdistcauchyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyCluster::fill(
  self : StatsdistcauchyCluster,
  v : Double,
) -> StatsdistcauchyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyCluster::min(self : StatsdistcauchyCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyCluster::max(self : StatsdistcauchyCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyCluster::to_string(
  self : StatsdistcauchyCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_model_make(size : Int32) -> StatsdistcauchyModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyModel::len(self : StatsdistcauchyModel) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyModel::get(
  self : StatsdistcauchyModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyModel::set(
  self : StatsdistcauchyModel,
  i : Int32,
  v : Double,
) -> StatsdistcauchyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyModel::sum(self : StatsdistcauchyModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyModel::mean(self : StatsdistcauchyModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyModel::scale(
  self : StatsdistcauchyModel,
  f : Double,
) -> StatsdistcauchyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyModel::add(
  self : StatsdistcauchyModel,
  other : StatsdistcauchyModel,
) -> StatsdistcauchyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyModel::copy(
  self : StatsdistcauchyModel,
) -> StatsdistcauchyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyModel::fill(
  self : StatsdistcauchyModel,
  v : Double,
) -> StatsdistcauchyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyModel::min(self : StatsdistcauchyModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyModel::max(self : StatsdistcauchyModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyModel::to_string(self : StatsdistcauchyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_layer_make(size : Int32) -> StatsdistcauchyLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyLayer::len(self : StatsdistcauchyLayer) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyLayer::get(
  self : StatsdistcauchyLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyLayer::set(
  self : StatsdistcauchyLayer,
  i : Int32,
  v : Double,
) -> StatsdistcauchyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyLayer::sum(self : StatsdistcauchyLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyLayer::mean(self : StatsdistcauchyLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyLayer::scale(
  self : StatsdistcauchyLayer,
  f : Double,
) -> StatsdistcauchyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyLayer::add(
  self : StatsdistcauchyLayer,
  other : StatsdistcauchyLayer,
) -> StatsdistcauchyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyLayer::copy(
  self : StatsdistcauchyLayer,
) -> StatsdistcauchyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyLayer::fill(
  self : StatsdistcauchyLayer,
  v : Double,
) -> StatsdistcauchyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyLayer::min(self : StatsdistcauchyLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyLayer::max(self : StatsdistcauchyLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyLayer::to_string(self : StatsdistcauchyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_buffer_make(size : Int32) -> StatsdistcauchyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyBuffer::len(self : StatsdistcauchyBuffer) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyBuffer::get(
  self : StatsdistcauchyBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyBuffer::set(
  self : StatsdistcauchyBuffer,
  i : Int32,
  v : Double,
) -> StatsdistcauchyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyBuffer::sum(self : StatsdistcauchyBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyBuffer::mean(self : StatsdistcauchyBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyBuffer::scale(
  self : StatsdistcauchyBuffer,
  f : Double,
) -> StatsdistcauchyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyBuffer::add(
  self : StatsdistcauchyBuffer,
  other : StatsdistcauchyBuffer,
) -> StatsdistcauchyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyBuffer::copy(
  self : StatsdistcauchyBuffer,
) -> StatsdistcauchyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyBuffer::fill(
  self : StatsdistcauchyBuffer,
  v : Double,
) -> StatsdistcauchyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyBuffer::min(self : StatsdistcauchyBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyBuffer::max(self : StatsdistcauchyBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyBuffer::to_string(self : StatsdistcauchyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_cursor_make(size : Int32) -> StatsdistcauchyCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyCursor::len(self : StatsdistcauchyCursor) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyCursor::get(
  self : StatsdistcauchyCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyCursor::set(
  self : StatsdistcauchyCursor,
  i : Int32,
  v : Double,
) -> StatsdistcauchyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyCursor::sum(self : StatsdistcauchyCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyCursor::mean(self : StatsdistcauchyCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyCursor::scale(
  self : StatsdistcauchyCursor,
  f : Double,
) -> StatsdistcauchyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyCursor::add(
  self : StatsdistcauchyCursor,
  other : StatsdistcauchyCursor,
) -> StatsdistcauchyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyCursor::copy(
  self : StatsdistcauchyCursor,
) -> StatsdistcauchyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyCursor::fill(
  self : StatsdistcauchyCursor,
  v : Double,
) -> StatsdistcauchyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyCursor::min(self : StatsdistcauchyCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyCursor::max(self : StatsdistcauchyCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyCursor::to_string(self : StatsdistcauchyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_view_make(size : Int32) -> StatsdistcauchyView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyView::len(self : StatsdistcauchyView) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyView::get(
  self : StatsdistcauchyView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyView::set(
  self : StatsdistcauchyView,
  i : Int32,
  v : Double,
) -> StatsdistcauchyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyView::sum(self : StatsdistcauchyView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyView::mean(self : StatsdistcauchyView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyView::scale(
  self : StatsdistcauchyView,
  f : Double,
) -> StatsdistcauchyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyView::add(
  self : StatsdistcauchyView,
  other : StatsdistcauchyView,
) -> StatsdistcauchyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyView::copy(
  self : StatsdistcauchyView,
) -> StatsdistcauchyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyView::fill(
  self : StatsdistcauchyView,
  v : Double,
) -> StatsdistcauchyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyView::min(self : StatsdistcauchyView) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyView::max(self : StatsdistcauchyView) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyView::to_string(self : StatsdistcauchyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchyRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_range_make(size : Int32) -> StatsdistcauchyRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchyRange::len(self : StatsdistcauchyRange) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchyRange::get(
  self : StatsdistcauchyRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchyRange::set(
  self : StatsdistcauchyRange,
  i : Int32,
  v : Double,
) -> StatsdistcauchyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyRange::sum(self : StatsdistcauchyRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchyRange::mean(self : StatsdistcauchyRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchyRange::scale(
  self : StatsdistcauchyRange,
  f : Double,
) -> StatsdistcauchyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyRange::add(
  self : StatsdistcauchyRange,
  other : StatsdistcauchyRange,
) -> StatsdistcauchyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchyRange::copy(
  self : StatsdistcauchyRange,
) -> StatsdistcauchyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyRange::fill(
  self : StatsdistcauchyRange,
  v : Double,
) -> StatsdistcauchyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchyRange::min(self : StatsdistcauchyRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchyRange::max(self : StatsdistcauchyRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchyRange::to_string(self : StatsdistcauchyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistcauchySlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_cauchy_slice_make(size : Int32) -> StatsdistcauchySlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistcauchySlice::len(self : StatsdistcauchySlice) -> Int32 {
  self.size
}

///|
pub fn StatsdistcauchySlice::get(
  self : StatsdistcauchySlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistcauchySlice::set(
  self : StatsdistcauchySlice,
  i : Int32,
  v : Double,
) -> StatsdistcauchySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchySlice::sum(self : StatsdistcauchySlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistcauchySlice::mean(self : StatsdistcauchySlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistcauchySlice::scale(
  self : StatsdistcauchySlice,
  f : Double,
) -> StatsdistcauchySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchySlice::add(
  self : StatsdistcauchySlice,
  other : StatsdistcauchySlice,
) -> StatsdistcauchySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistcauchySlice::copy(
  self : StatsdistcauchySlice,
) -> StatsdistcauchySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchySlice::fill(
  self : StatsdistcauchySlice,
  v : Double,
) -> StatsdistcauchySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistcauchySlice::min(self : StatsdistcauchySlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistcauchySlice::max(self : StatsdistcauchySlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistcauchySlice::to_string(self : StatsdistcauchySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
