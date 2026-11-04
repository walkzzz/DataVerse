///|
///===
/// extcore/stats_dist_hypergeo
pub(all) struct StatsdisthypergeoPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_dist_hypergeo_make_point(
  x : Double,
  y : Double,
) -> StatsdisthypergeoPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_dist_hypergeo_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatsdisthypergeoPoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatsdisthypergeoPoint::x(self : StatsdisthypergeoPoint) -> Double {
  self.x
}

///|
pub fn StatsdisthypergeoPoint::y(self : StatsdisthypergeoPoint) -> Double {
  self.y
}

///|
pub fn StatsdisthypergeoPoint::z(self : StatsdisthypergeoPoint) -> Double {
  self.z
}

///|
pub fn StatsdisthypergeoPoint::label(self : StatsdisthypergeoPoint) -> Int32 {
  self.label
}

///|
pub fn StatsdisthypergeoPoint::dist(
  self : StatsdisthypergeoPoint,
  other : StatsdisthypergeoPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatsdisthypergeoPoint::add(
  self : StatsdisthypergeoPoint,
  other : StatsdisthypergeoPoint,
) -> StatsdisthypergeoPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatsdisthypergeoPoint::sub(
  self : StatsdisthypergeoPoint,
  other : StatsdisthypergeoPoint,
) -> StatsdisthypergeoPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatsdisthypergeoPoint::scale(
  self : StatsdisthypergeoPoint,
  s : Double,
) -> StatsdisthypergeoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatsdisthypergeoPoint::dot(
  self : StatsdisthypergeoPoint,
  other : StatsdisthypergeoPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatsdisthypergeoPoint::cross(
  self : StatsdisthypergeoPoint,
  other : StatsdisthypergeoPoint,
) -> StatsdisthypergeoPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatsdisthypergeoPoint::norm(self : StatsdisthypergeoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatsdisthypergeoPoint::normalize(
  self : StatsdisthypergeoPoint,
) -> StatsdisthypergeoPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdisthypergeoPoint::negate(
  self : StatsdisthypergeoPoint,
) -> StatsdisthypergeoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatsdisthypergeoPoint::mid(
  self : StatsdisthypergeoPoint,
  other : StatsdisthypergeoPoint,
) -> StatsdisthypergeoPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatsdisthypergeoPoint::lerp(
  self : StatsdisthypergeoPoint,
  other : StatsdisthypergeoPoint,
  t : Double,
) -> StatsdisthypergeoPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatsdisthypergeoPoint::to_string(
  self : StatsdisthypergeoPoint,
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
pub(all) struct StatsdisthypergeoSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_dist_hypergeo_make_series(
  vals : Array[Double],
  name : String,
) -> StatsdisthypergeoSeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatsdisthypergeoSeries::len(self : StatsdisthypergeoSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn StatsdisthypergeoSeries::sum(self : StatsdisthypergeoSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatsdisthypergeoSeries::mean(self : StatsdisthypergeoSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatsdisthypergeoSeries::min(self : StatsdisthypergeoSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatsdisthypergeoSeries::max(self : StatsdisthypergeoSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatsdisthypergeoSeries::range(self : StatsdisthypergeoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatsdisthypergeoSeries::variance(
  self : StatsdisthypergeoSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatsdisthypergeoSeries::std(self : StatsdisthypergeoSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatsdisthypergeoSeries::median(
  self : StatsdisthypergeoSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatsdisthypergeoSeries::scale(
  self : StatsdisthypergeoSeries,
  f : Double,
) -> StatsdisthypergeoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatsdisthypergeoSeries::add(
  self : StatsdisthypergeoSeries,
  other : StatsdisthypergeoSeries,
) -> StatsdisthypergeoSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdisthypergeoSeries::sub(
  self : StatsdisthypergeoSeries,
  other : StatsdisthypergeoSeries,
) -> StatsdisthypergeoSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdisthypergeoSeries::normalize(
  self : StatsdisthypergeoSeries,
) -> StatsdisthypergeoSeries {
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
pub fn StatsdisthypergeoSeries::cumsum(
  self : StatsdisthypergeoSeries,
) -> StatsdisthypergeoSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatsdisthypergeoSeries::to_string(
  self : StatsdisthypergeoSeries,
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
pub(all) struct StatsdisthypergeoMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_dist_hypergeo_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatsdisthypergeoMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_dist_hypergeo_matrix_identity(
  n : Int32,
) -> StatsdisthypergeoMatrix {
  let m = stats_dist_hypergeo_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatsdisthypergeoMatrix::get(
  self : StatsdisthypergeoMatrix,
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
pub fn StatsdisthypergeoMatrix::transpose(
  self : StatsdisthypergeoMatrix,
) -> StatsdisthypergeoMatrix {
  let result = stats_dist_hypergeo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdisthypergeoMatrix::add(
  self : StatsdisthypergeoMatrix,
  other : StatsdisthypergeoMatrix,
) -> StatsdisthypergeoMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_dist_hypergeo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdisthypergeoMatrix::scale(
  self : StatsdisthypergeoMatrix,
  s : Double,
) -> StatsdisthypergeoMatrix {
  let result = stats_dist_hypergeo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatsdisthypergeoMatrix::multiply(
  self : StatsdisthypergeoMatrix,
  other : StatsdisthypergeoMatrix,
) -> StatsdisthypergeoMatrix {
  if self.cols != other.rows {
    return stats_dist_hypergeo_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_dist_hypergeo_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatsdisthypergeoMatrix::trace(self : StatsdisthypergeoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatsdisthypergeoMatrix::det(self : StatsdisthypergeoMatrix) -> Double {
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
pub fn StatsdisthypergeoMatrix::norm(self : StatsdisthypergeoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn StatsdisthypergeoMatrix::to_string(
  self : StatsdisthypergeoMatrix,
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
pub(all) struct StatsdisthypergeoVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_dist_hypergeo_make_vector(
  comps : Array[Double],
) -> StatsdisthypergeoVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_dist_hypergeo_vector_zero(dim : Int32) -> StatsdisthypergeoVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatsdisthypergeoVector::add(
  self : StatsdisthypergeoVector,
  other : StatsdisthypergeoVector,
) -> StatsdisthypergeoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdisthypergeoVector::sub(
  self : StatsdisthypergeoVector,
  other : StatsdisthypergeoVector,
) -> StatsdisthypergeoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdisthypergeoVector::scale(
  self : StatsdisthypergeoVector,
  s : Double,
) -> StatsdisthypergeoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatsdisthypergeoVector::dot(
  self : StatsdisthypergeoVector,
  other : StatsdisthypergeoVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatsdisthypergeoVector::norm(self : StatsdisthypergeoVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatsdisthypergeoVector::normalize(
  self : StatsdisthypergeoVector,
) -> StatsdisthypergeoVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdisthypergeoVector::dist(
  self : StatsdisthypergeoVector,
  other : StatsdisthypergeoVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatsdisthypergeoVector::to_string(
  self : StatsdisthypergeoVector,
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
pub(all) struct StatsdisthypergeoFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_frame_make(size : Int32) -> StatsdisthypergeoFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoFrame::len(self : StatsdisthypergeoFrame) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoFrame::get(
  self : StatsdisthypergeoFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoFrame::set(
  self : StatsdisthypergeoFrame,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoFrame::sum(self : StatsdisthypergeoFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoFrame::mean(self : StatsdisthypergeoFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoFrame::scale(
  self : StatsdisthypergeoFrame,
  f : Double,
) -> StatsdisthypergeoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoFrame::add(
  self : StatsdisthypergeoFrame,
  other : StatsdisthypergeoFrame,
) -> StatsdisthypergeoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoFrame::copy(
  self : StatsdisthypergeoFrame,
) -> StatsdisthypergeoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoFrame::fill(
  self : StatsdisthypergeoFrame,
  v : Double,
) -> StatsdisthypergeoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoFrame::min(self : StatsdisthypergeoFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoFrame::max(self : StatsdisthypergeoFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoFrame::to_string(
  self : StatsdisthypergeoFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_table_make(size : Int32) -> StatsdisthypergeoTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoTable::len(self : StatsdisthypergeoTable) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoTable::get(
  self : StatsdisthypergeoTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoTable::set(
  self : StatsdisthypergeoTable,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoTable::sum(self : StatsdisthypergeoTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoTable::mean(self : StatsdisthypergeoTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoTable::scale(
  self : StatsdisthypergeoTable,
  f : Double,
) -> StatsdisthypergeoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoTable::add(
  self : StatsdisthypergeoTable,
  other : StatsdisthypergeoTable,
) -> StatsdisthypergeoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoTable::copy(
  self : StatsdisthypergeoTable,
) -> StatsdisthypergeoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoTable::fill(
  self : StatsdisthypergeoTable,
  v : Double,
) -> StatsdisthypergeoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoTable::min(self : StatsdisthypergeoTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoTable::max(self : StatsdisthypergeoTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoTable::to_string(
  self : StatsdisthypergeoTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_graphn_make(size : Int32) -> StatsdisthypergeoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoGraphN::len(self : StatsdisthypergeoGraphN) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoGraphN::get(
  self : StatsdisthypergeoGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoGraphN::set(
  self : StatsdisthypergeoGraphN,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoGraphN::sum(self : StatsdisthypergeoGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoGraphN::mean(self : StatsdisthypergeoGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoGraphN::scale(
  self : StatsdisthypergeoGraphN,
  f : Double,
) -> StatsdisthypergeoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoGraphN::add(
  self : StatsdisthypergeoGraphN,
  other : StatsdisthypergeoGraphN,
) -> StatsdisthypergeoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoGraphN::copy(
  self : StatsdisthypergeoGraphN,
) -> StatsdisthypergeoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoGraphN::fill(
  self : StatsdisthypergeoGraphN,
  v : Double,
) -> StatsdisthypergeoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoGraphN::min(self : StatsdisthypergeoGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoGraphN::max(self : StatsdisthypergeoGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoGraphN::to_string(
  self : StatsdisthypergeoGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_node_make(size : Int32) -> StatsdisthypergeoNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoNode::len(self : StatsdisthypergeoNode) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoNode::get(
  self : StatsdisthypergeoNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoNode::set(
  self : StatsdisthypergeoNode,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoNode::sum(self : StatsdisthypergeoNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoNode::mean(self : StatsdisthypergeoNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoNode::scale(
  self : StatsdisthypergeoNode,
  f : Double,
) -> StatsdisthypergeoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoNode::add(
  self : StatsdisthypergeoNode,
  other : StatsdisthypergeoNode,
) -> StatsdisthypergeoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoNode::copy(
  self : StatsdisthypergeoNode,
) -> StatsdisthypergeoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoNode::fill(
  self : StatsdisthypergeoNode,
  v : Double,
) -> StatsdisthypergeoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoNode::min(self : StatsdisthypergeoNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoNode::max(self : StatsdisthypergeoNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoNode::to_string(self : StatsdisthypergeoNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_edge_make(size : Int32) -> StatsdisthypergeoEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoEdge::len(self : StatsdisthypergeoEdge) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoEdge::get(
  self : StatsdisthypergeoEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoEdge::set(
  self : StatsdisthypergeoEdge,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoEdge::sum(self : StatsdisthypergeoEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoEdge::mean(self : StatsdisthypergeoEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoEdge::scale(
  self : StatsdisthypergeoEdge,
  f : Double,
) -> StatsdisthypergeoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoEdge::add(
  self : StatsdisthypergeoEdge,
  other : StatsdisthypergeoEdge,
) -> StatsdisthypergeoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoEdge::copy(
  self : StatsdisthypergeoEdge,
) -> StatsdisthypergeoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoEdge::fill(
  self : StatsdisthypergeoEdge,
  v : Double,
) -> StatsdisthypergeoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoEdge::min(self : StatsdisthypergeoEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoEdge::max(self : StatsdisthypergeoEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoEdge::to_string(self : StatsdisthypergeoEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_path_make(size : Int32) -> StatsdisthypergeoPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoPath::len(self : StatsdisthypergeoPath) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoPath::get(
  self : StatsdisthypergeoPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoPath::set(
  self : StatsdisthypergeoPath,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoPath::sum(self : StatsdisthypergeoPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoPath::mean(self : StatsdisthypergeoPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoPath::scale(
  self : StatsdisthypergeoPath,
  f : Double,
) -> StatsdisthypergeoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoPath::add(
  self : StatsdisthypergeoPath,
  other : StatsdisthypergeoPath,
) -> StatsdisthypergeoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoPath::copy(
  self : StatsdisthypergeoPath,
) -> StatsdisthypergeoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoPath::fill(
  self : StatsdisthypergeoPath,
  v : Double,
) -> StatsdisthypergeoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoPath::min(self : StatsdisthypergeoPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoPath::max(self : StatsdisthypergeoPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoPath::to_string(self : StatsdisthypergeoPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_cluster_make(
  size : Int32,
) -> StatsdisthypergeoCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoCluster::len(self : StatsdisthypergeoCluster) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoCluster::get(
  self : StatsdisthypergeoCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoCluster::set(
  self : StatsdisthypergeoCluster,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoCluster::sum(self : StatsdisthypergeoCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoCluster::mean(
  self : StatsdisthypergeoCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoCluster::scale(
  self : StatsdisthypergeoCluster,
  f : Double,
) -> StatsdisthypergeoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoCluster::add(
  self : StatsdisthypergeoCluster,
  other : StatsdisthypergeoCluster,
) -> StatsdisthypergeoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoCluster::copy(
  self : StatsdisthypergeoCluster,
) -> StatsdisthypergeoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoCluster::fill(
  self : StatsdisthypergeoCluster,
  v : Double,
) -> StatsdisthypergeoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoCluster::min(self : StatsdisthypergeoCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoCluster::max(self : StatsdisthypergeoCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoCluster::to_string(
  self : StatsdisthypergeoCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_model_make(size : Int32) -> StatsdisthypergeoModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoModel::len(self : StatsdisthypergeoModel) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoModel::get(
  self : StatsdisthypergeoModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoModel::set(
  self : StatsdisthypergeoModel,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoModel::sum(self : StatsdisthypergeoModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoModel::mean(self : StatsdisthypergeoModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoModel::scale(
  self : StatsdisthypergeoModel,
  f : Double,
) -> StatsdisthypergeoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoModel::add(
  self : StatsdisthypergeoModel,
  other : StatsdisthypergeoModel,
) -> StatsdisthypergeoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoModel::copy(
  self : StatsdisthypergeoModel,
) -> StatsdisthypergeoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoModel::fill(
  self : StatsdisthypergeoModel,
  v : Double,
) -> StatsdisthypergeoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoModel::min(self : StatsdisthypergeoModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoModel::max(self : StatsdisthypergeoModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoModel::to_string(
  self : StatsdisthypergeoModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_layer_make(size : Int32) -> StatsdisthypergeoLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoLayer::len(self : StatsdisthypergeoLayer) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoLayer::get(
  self : StatsdisthypergeoLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoLayer::set(
  self : StatsdisthypergeoLayer,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoLayer::sum(self : StatsdisthypergeoLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoLayer::mean(self : StatsdisthypergeoLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoLayer::scale(
  self : StatsdisthypergeoLayer,
  f : Double,
) -> StatsdisthypergeoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoLayer::add(
  self : StatsdisthypergeoLayer,
  other : StatsdisthypergeoLayer,
) -> StatsdisthypergeoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoLayer::copy(
  self : StatsdisthypergeoLayer,
) -> StatsdisthypergeoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoLayer::fill(
  self : StatsdisthypergeoLayer,
  v : Double,
) -> StatsdisthypergeoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoLayer::min(self : StatsdisthypergeoLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoLayer::max(self : StatsdisthypergeoLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoLayer::to_string(
  self : StatsdisthypergeoLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_buffer_make(size : Int32) -> StatsdisthypergeoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoBuffer::len(self : StatsdisthypergeoBuffer) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoBuffer::get(
  self : StatsdisthypergeoBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoBuffer::set(
  self : StatsdisthypergeoBuffer,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoBuffer::sum(self : StatsdisthypergeoBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoBuffer::mean(self : StatsdisthypergeoBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoBuffer::scale(
  self : StatsdisthypergeoBuffer,
  f : Double,
) -> StatsdisthypergeoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoBuffer::add(
  self : StatsdisthypergeoBuffer,
  other : StatsdisthypergeoBuffer,
) -> StatsdisthypergeoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoBuffer::copy(
  self : StatsdisthypergeoBuffer,
) -> StatsdisthypergeoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoBuffer::fill(
  self : StatsdisthypergeoBuffer,
  v : Double,
) -> StatsdisthypergeoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoBuffer::min(self : StatsdisthypergeoBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoBuffer::max(self : StatsdisthypergeoBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoBuffer::to_string(
  self : StatsdisthypergeoBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_cursor_make(size : Int32) -> StatsdisthypergeoCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoCursor::len(self : StatsdisthypergeoCursor) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoCursor::get(
  self : StatsdisthypergeoCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoCursor::set(
  self : StatsdisthypergeoCursor,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoCursor::sum(self : StatsdisthypergeoCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoCursor::mean(self : StatsdisthypergeoCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoCursor::scale(
  self : StatsdisthypergeoCursor,
  f : Double,
) -> StatsdisthypergeoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoCursor::add(
  self : StatsdisthypergeoCursor,
  other : StatsdisthypergeoCursor,
) -> StatsdisthypergeoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoCursor::copy(
  self : StatsdisthypergeoCursor,
) -> StatsdisthypergeoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoCursor::fill(
  self : StatsdisthypergeoCursor,
  v : Double,
) -> StatsdisthypergeoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoCursor::min(self : StatsdisthypergeoCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoCursor::max(self : StatsdisthypergeoCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoCursor::to_string(
  self : StatsdisthypergeoCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_view_make(size : Int32) -> StatsdisthypergeoView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoView::len(self : StatsdisthypergeoView) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoView::get(
  self : StatsdisthypergeoView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoView::set(
  self : StatsdisthypergeoView,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoView::sum(self : StatsdisthypergeoView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoView::mean(self : StatsdisthypergeoView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoView::scale(
  self : StatsdisthypergeoView,
  f : Double,
) -> StatsdisthypergeoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoView::add(
  self : StatsdisthypergeoView,
  other : StatsdisthypergeoView,
) -> StatsdisthypergeoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoView::copy(
  self : StatsdisthypergeoView,
) -> StatsdisthypergeoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoView::fill(
  self : StatsdisthypergeoView,
  v : Double,
) -> StatsdisthypergeoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoView::min(self : StatsdisthypergeoView) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoView::max(self : StatsdisthypergeoView) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoView::to_string(self : StatsdisthypergeoView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_range_make(size : Int32) -> StatsdisthypergeoRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoRange::len(self : StatsdisthypergeoRange) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoRange::get(
  self : StatsdisthypergeoRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoRange::set(
  self : StatsdisthypergeoRange,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoRange::sum(self : StatsdisthypergeoRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoRange::mean(self : StatsdisthypergeoRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoRange::scale(
  self : StatsdisthypergeoRange,
  f : Double,
) -> StatsdisthypergeoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoRange::add(
  self : StatsdisthypergeoRange,
  other : StatsdisthypergeoRange,
) -> StatsdisthypergeoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoRange::copy(
  self : StatsdisthypergeoRange,
) -> StatsdisthypergeoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoRange::fill(
  self : StatsdisthypergeoRange,
  v : Double,
) -> StatsdisthypergeoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoRange::min(self : StatsdisthypergeoRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoRange::max(self : StatsdisthypergeoRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoRange::to_string(
  self : StatsdisthypergeoRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdisthypergeoSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_hypergeo_slice_make(size : Int32) -> StatsdisthypergeoSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdisthypergeoSlice::len(self : StatsdisthypergeoSlice) -> Int32 {
  self.size
}

///|
pub fn StatsdisthypergeoSlice::get(
  self : StatsdisthypergeoSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdisthypergeoSlice::set(
  self : StatsdisthypergeoSlice,
  i : Int32,
  v : Double,
) -> StatsdisthypergeoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoSlice::sum(self : StatsdisthypergeoSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdisthypergeoSlice::mean(self : StatsdisthypergeoSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdisthypergeoSlice::scale(
  self : StatsdisthypergeoSlice,
  f : Double,
) -> StatsdisthypergeoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoSlice::add(
  self : StatsdisthypergeoSlice,
  other : StatsdisthypergeoSlice,
) -> StatsdisthypergeoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoSlice::copy(
  self : StatsdisthypergeoSlice,
) -> StatsdisthypergeoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoSlice::fill(
  self : StatsdisthypergeoSlice,
  v : Double,
) -> StatsdisthypergeoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdisthypergeoSlice::min(self : StatsdisthypergeoSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdisthypergeoSlice::max(self : StatsdisthypergeoSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdisthypergeoSlice::to_string(
  self : StatsdisthypergeoSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
