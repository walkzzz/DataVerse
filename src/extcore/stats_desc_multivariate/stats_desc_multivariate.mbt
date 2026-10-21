///|
///===
/// extcore/stats_desc_multivariate
pub(all) struct StatsdescmultivariatePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_desc_multivariate_make_point(
  x : Double,
  y : Double,
) -> StatsdescmultivariatePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_desc_multivariate_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatsdescmultivariatePoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatsdescmultivariatePoint::x(
  self : StatsdescmultivariatePoint,
) -> Double {
  self.x
}

///|
pub fn StatsdescmultivariatePoint::y(
  self : StatsdescmultivariatePoint,
) -> Double {
  self.y
}

///|
pub fn StatsdescmultivariatePoint::z(
  self : StatsdescmultivariatePoint,
) -> Double {
  self.z
}

///|
pub fn StatsdescmultivariatePoint::label(
  self : StatsdescmultivariatePoint,
) -> Int32 {
  self.label
}

///|
pub fn StatsdescmultivariatePoint::dist(
  self : StatsdescmultivariatePoint,
  other : StatsdescmultivariatePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatsdescmultivariatePoint::add(
  self : StatsdescmultivariatePoint,
  other : StatsdescmultivariatePoint,
) -> StatsdescmultivariatePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatsdescmultivariatePoint::sub(
  self : StatsdescmultivariatePoint,
  other : StatsdescmultivariatePoint,
) -> StatsdescmultivariatePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatsdescmultivariatePoint::scale(
  self : StatsdescmultivariatePoint,
  s : Double,
) -> StatsdescmultivariatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatsdescmultivariatePoint::dot(
  self : StatsdescmultivariatePoint,
  other : StatsdescmultivariatePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatsdescmultivariatePoint::cross(
  self : StatsdescmultivariatePoint,
  other : StatsdescmultivariatePoint,
) -> StatsdescmultivariatePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatsdescmultivariatePoint::norm(
  self : StatsdescmultivariatePoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatsdescmultivariatePoint::normalize(
  self : StatsdescmultivariatePoint,
) -> StatsdescmultivariatePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdescmultivariatePoint::negate(
  self : StatsdescmultivariatePoint,
) -> StatsdescmultivariatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatsdescmultivariatePoint::mid(
  self : StatsdescmultivariatePoint,
  other : StatsdescmultivariatePoint,
) -> StatsdescmultivariatePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatsdescmultivariatePoint::lerp(
  self : StatsdescmultivariatePoint,
  other : StatsdescmultivariatePoint,
  t : Double,
) -> StatsdescmultivariatePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatsdescmultivariatePoint::to_string(
  self : StatsdescmultivariatePoint,
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
pub(all) struct StatsdescmultivariateSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_desc_multivariate_make_series(
  vals : Array[Double],
  name : String,
) -> StatsdescmultivariateSeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatsdescmultivariateSeries::len(
  self : StatsdescmultivariateSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn StatsdescmultivariateSeries::sum(
  self : StatsdescmultivariateSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatsdescmultivariateSeries::mean(
  self : StatsdescmultivariateSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatsdescmultivariateSeries::min(
  self : StatsdescmultivariateSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatsdescmultivariateSeries::max(
  self : StatsdescmultivariateSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatsdescmultivariateSeries::range(
  self : StatsdescmultivariateSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatsdescmultivariateSeries::variance(
  self : StatsdescmultivariateSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatsdescmultivariateSeries::std(
  self : StatsdescmultivariateSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatsdescmultivariateSeries::median(
  self : StatsdescmultivariateSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatsdescmultivariateSeries::scale(
  self : StatsdescmultivariateSeries,
  f : Double,
) -> StatsdescmultivariateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatsdescmultivariateSeries::add(
  self : StatsdescmultivariateSeries,
  other : StatsdescmultivariateSeries,
) -> StatsdescmultivariateSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdescmultivariateSeries::sub(
  self : StatsdescmultivariateSeries,
  other : StatsdescmultivariateSeries,
) -> StatsdescmultivariateSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdescmultivariateSeries::normalize(
  self : StatsdescmultivariateSeries,
) -> StatsdescmultivariateSeries {
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
pub fn StatsdescmultivariateSeries::cumsum(
  self : StatsdescmultivariateSeries,
) -> StatsdescmultivariateSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatsdescmultivariateSeries::to_string(
  self : StatsdescmultivariateSeries,
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
pub(all) struct StatsdescmultivariateMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_desc_multivariate_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatsdescmultivariateMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_desc_multivariate_matrix_identity(
  n : Int32,
) -> StatsdescmultivariateMatrix {
  let m = stats_desc_multivariate_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatsdescmultivariateMatrix::get(
  self : StatsdescmultivariateMatrix,
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
pub fn StatsdescmultivariateMatrix::transpose(
  self : StatsdescmultivariateMatrix,
) -> StatsdescmultivariateMatrix {
  let result = stats_desc_multivariate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdescmultivariateMatrix::add(
  self : StatsdescmultivariateMatrix,
  other : StatsdescmultivariateMatrix,
) -> StatsdescmultivariateMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_desc_multivariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdescmultivariateMatrix::scale(
  self : StatsdescmultivariateMatrix,
  s : Double,
) -> StatsdescmultivariateMatrix {
  let result = stats_desc_multivariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatsdescmultivariateMatrix::multiply(
  self : StatsdescmultivariateMatrix,
  other : StatsdescmultivariateMatrix,
) -> StatsdescmultivariateMatrix {
  if self.cols != other.rows {
    return stats_desc_multivariate_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_desc_multivariate_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatsdescmultivariateMatrix::trace(
  self : StatsdescmultivariateMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatsdescmultivariateMatrix::det(
  self : StatsdescmultivariateMatrix,
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
pub fn StatsdescmultivariateMatrix::norm(
  self : StatsdescmultivariateMatrix,
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
pub fn StatsdescmultivariateMatrix::to_string(
  self : StatsdescmultivariateMatrix,
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
pub(all) struct StatsdescmultivariateVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_desc_multivariate_make_vector(
  comps : Array[Double],
) -> StatsdescmultivariateVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_desc_multivariate_vector_zero(
  dim : Int32,
) -> StatsdescmultivariateVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatsdescmultivariateVector::add(
  self : StatsdescmultivariateVector,
  other : StatsdescmultivariateVector,
) -> StatsdescmultivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdescmultivariateVector::sub(
  self : StatsdescmultivariateVector,
  other : StatsdescmultivariateVector,
) -> StatsdescmultivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdescmultivariateVector::scale(
  self : StatsdescmultivariateVector,
  s : Double,
) -> StatsdescmultivariateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatsdescmultivariateVector::dot(
  self : StatsdescmultivariateVector,
  other : StatsdescmultivariateVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatsdescmultivariateVector::norm(
  self : StatsdescmultivariateVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatsdescmultivariateVector::normalize(
  self : StatsdescmultivariateVector,
) -> StatsdescmultivariateVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdescmultivariateVector::dist(
  self : StatsdescmultivariateVector,
  other : StatsdescmultivariateVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatsdescmultivariateVector::to_string(
  self : StatsdescmultivariateVector,
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
pub(all) struct StatsdescmultivariateFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_frame_make(
  size : Int32,
) -> StatsdescmultivariateFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateFrame::len(
  self : StatsdescmultivariateFrame,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateFrame::get(
  self : StatsdescmultivariateFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateFrame::set(
  self : StatsdescmultivariateFrame,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateFrame::sum(
  self : StatsdescmultivariateFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateFrame::mean(
  self : StatsdescmultivariateFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateFrame::scale(
  self : StatsdescmultivariateFrame,
  f : Double,
) -> StatsdescmultivariateFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateFrame::add(
  self : StatsdescmultivariateFrame,
  other : StatsdescmultivariateFrame,
) -> StatsdescmultivariateFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateFrame::copy(
  self : StatsdescmultivariateFrame,
) -> StatsdescmultivariateFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateFrame::fill(
  self : StatsdescmultivariateFrame,
  v : Double,
) -> StatsdescmultivariateFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateFrame::min(
  self : StatsdescmultivariateFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateFrame::max(
  self : StatsdescmultivariateFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateFrame::to_string(
  self : StatsdescmultivariateFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_table_make(
  size : Int32,
) -> StatsdescmultivariateTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateTable::len(
  self : StatsdescmultivariateTable,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateTable::get(
  self : StatsdescmultivariateTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateTable::set(
  self : StatsdescmultivariateTable,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateTable::sum(
  self : StatsdescmultivariateTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateTable::mean(
  self : StatsdescmultivariateTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateTable::scale(
  self : StatsdescmultivariateTable,
  f : Double,
) -> StatsdescmultivariateTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateTable::add(
  self : StatsdescmultivariateTable,
  other : StatsdescmultivariateTable,
) -> StatsdescmultivariateTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateTable::copy(
  self : StatsdescmultivariateTable,
) -> StatsdescmultivariateTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateTable::fill(
  self : StatsdescmultivariateTable,
  v : Double,
) -> StatsdescmultivariateTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateTable::min(
  self : StatsdescmultivariateTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateTable::max(
  self : StatsdescmultivariateTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateTable::to_string(
  self : StatsdescmultivariateTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_graphn_make(
  size : Int32,
) -> StatsdescmultivariateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateGraphN::len(
  self : StatsdescmultivariateGraphN,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateGraphN::get(
  self : StatsdescmultivariateGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateGraphN::set(
  self : StatsdescmultivariateGraphN,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateGraphN::sum(
  self : StatsdescmultivariateGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateGraphN::mean(
  self : StatsdescmultivariateGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateGraphN::scale(
  self : StatsdescmultivariateGraphN,
  f : Double,
) -> StatsdescmultivariateGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateGraphN::add(
  self : StatsdescmultivariateGraphN,
  other : StatsdescmultivariateGraphN,
) -> StatsdescmultivariateGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateGraphN::copy(
  self : StatsdescmultivariateGraphN,
) -> StatsdescmultivariateGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateGraphN::fill(
  self : StatsdescmultivariateGraphN,
  v : Double,
) -> StatsdescmultivariateGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateGraphN::min(
  self : StatsdescmultivariateGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateGraphN::max(
  self : StatsdescmultivariateGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateGraphN::to_string(
  self : StatsdescmultivariateGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_node_make(
  size : Int32,
) -> StatsdescmultivariateNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateNode::len(
  self : StatsdescmultivariateNode,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateNode::get(
  self : StatsdescmultivariateNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateNode::set(
  self : StatsdescmultivariateNode,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateNode::sum(
  self : StatsdescmultivariateNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateNode::mean(
  self : StatsdescmultivariateNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateNode::scale(
  self : StatsdescmultivariateNode,
  f : Double,
) -> StatsdescmultivariateNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateNode::add(
  self : StatsdescmultivariateNode,
  other : StatsdescmultivariateNode,
) -> StatsdescmultivariateNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateNode::copy(
  self : StatsdescmultivariateNode,
) -> StatsdescmultivariateNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateNode::fill(
  self : StatsdescmultivariateNode,
  v : Double,
) -> StatsdescmultivariateNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateNode::min(
  self : StatsdescmultivariateNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateNode::max(
  self : StatsdescmultivariateNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateNode::to_string(
  self : StatsdescmultivariateNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_edge_make(
  size : Int32,
) -> StatsdescmultivariateEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateEdge::len(
  self : StatsdescmultivariateEdge,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateEdge::get(
  self : StatsdescmultivariateEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateEdge::set(
  self : StatsdescmultivariateEdge,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateEdge::sum(
  self : StatsdescmultivariateEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateEdge::mean(
  self : StatsdescmultivariateEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateEdge::scale(
  self : StatsdescmultivariateEdge,
  f : Double,
) -> StatsdescmultivariateEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateEdge::add(
  self : StatsdescmultivariateEdge,
  other : StatsdescmultivariateEdge,
) -> StatsdescmultivariateEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateEdge::copy(
  self : StatsdescmultivariateEdge,
) -> StatsdescmultivariateEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateEdge::fill(
  self : StatsdescmultivariateEdge,
  v : Double,
) -> StatsdescmultivariateEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateEdge::min(
  self : StatsdescmultivariateEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateEdge::max(
  self : StatsdescmultivariateEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateEdge::to_string(
  self : StatsdescmultivariateEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariatePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_path_make(
  size : Int32,
) -> StatsdescmultivariatePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariatePath::len(
  self : StatsdescmultivariatePath,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariatePath::get(
  self : StatsdescmultivariatePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariatePath::set(
  self : StatsdescmultivariatePath,
  i : Int32,
  v : Double,
) -> StatsdescmultivariatePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariatePath::sum(
  self : StatsdescmultivariatePath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariatePath::mean(
  self : StatsdescmultivariatePath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariatePath::scale(
  self : StatsdescmultivariatePath,
  f : Double,
) -> StatsdescmultivariatePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariatePath::add(
  self : StatsdescmultivariatePath,
  other : StatsdescmultivariatePath,
) -> StatsdescmultivariatePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariatePath::copy(
  self : StatsdescmultivariatePath,
) -> StatsdescmultivariatePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariatePath::fill(
  self : StatsdescmultivariatePath,
  v : Double,
) -> StatsdescmultivariatePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariatePath::min(
  self : StatsdescmultivariatePath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariatePath::max(
  self : StatsdescmultivariatePath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariatePath::to_string(
  self : StatsdescmultivariatePath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_cluster_make(
  size : Int32,
) -> StatsdescmultivariateCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateCluster::len(
  self : StatsdescmultivariateCluster,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateCluster::get(
  self : StatsdescmultivariateCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateCluster::set(
  self : StatsdescmultivariateCluster,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateCluster::sum(
  self : StatsdescmultivariateCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateCluster::mean(
  self : StatsdescmultivariateCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateCluster::scale(
  self : StatsdescmultivariateCluster,
  f : Double,
) -> StatsdescmultivariateCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateCluster::add(
  self : StatsdescmultivariateCluster,
  other : StatsdescmultivariateCluster,
) -> StatsdescmultivariateCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateCluster::copy(
  self : StatsdescmultivariateCluster,
) -> StatsdescmultivariateCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateCluster::fill(
  self : StatsdescmultivariateCluster,
  v : Double,
) -> StatsdescmultivariateCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateCluster::min(
  self : StatsdescmultivariateCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateCluster::max(
  self : StatsdescmultivariateCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateCluster::to_string(
  self : StatsdescmultivariateCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_model_make(
  size : Int32,
) -> StatsdescmultivariateModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateModel::len(
  self : StatsdescmultivariateModel,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateModel::get(
  self : StatsdescmultivariateModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateModel::set(
  self : StatsdescmultivariateModel,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateModel::sum(
  self : StatsdescmultivariateModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateModel::mean(
  self : StatsdescmultivariateModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateModel::scale(
  self : StatsdescmultivariateModel,
  f : Double,
) -> StatsdescmultivariateModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateModel::add(
  self : StatsdescmultivariateModel,
  other : StatsdescmultivariateModel,
) -> StatsdescmultivariateModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateModel::copy(
  self : StatsdescmultivariateModel,
) -> StatsdescmultivariateModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateModel::fill(
  self : StatsdescmultivariateModel,
  v : Double,
) -> StatsdescmultivariateModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateModel::min(
  self : StatsdescmultivariateModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateModel::max(
  self : StatsdescmultivariateModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateModel::to_string(
  self : StatsdescmultivariateModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_layer_make(
  size : Int32,
) -> StatsdescmultivariateLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateLayer::len(
  self : StatsdescmultivariateLayer,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateLayer::get(
  self : StatsdescmultivariateLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateLayer::set(
  self : StatsdescmultivariateLayer,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateLayer::sum(
  self : StatsdescmultivariateLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateLayer::mean(
  self : StatsdescmultivariateLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateLayer::scale(
  self : StatsdescmultivariateLayer,
  f : Double,
) -> StatsdescmultivariateLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateLayer::add(
  self : StatsdescmultivariateLayer,
  other : StatsdescmultivariateLayer,
) -> StatsdescmultivariateLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateLayer::copy(
  self : StatsdescmultivariateLayer,
) -> StatsdescmultivariateLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateLayer::fill(
  self : StatsdescmultivariateLayer,
  v : Double,
) -> StatsdescmultivariateLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateLayer::min(
  self : StatsdescmultivariateLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateLayer::max(
  self : StatsdescmultivariateLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateLayer::to_string(
  self : StatsdescmultivariateLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_buffer_make(
  size : Int32,
) -> StatsdescmultivariateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateBuffer::len(
  self : StatsdescmultivariateBuffer,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateBuffer::get(
  self : StatsdescmultivariateBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateBuffer::set(
  self : StatsdescmultivariateBuffer,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateBuffer::sum(
  self : StatsdescmultivariateBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateBuffer::mean(
  self : StatsdescmultivariateBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateBuffer::scale(
  self : StatsdescmultivariateBuffer,
  f : Double,
) -> StatsdescmultivariateBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateBuffer::add(
  self : StatsdescmultivariateBuffer,
  other : StatsdescmultivariateBuffer,
) -> StatsdescmultivariateBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateBuffer::copy(
  self : StatsdescmultivariateBuffer,
) -> StatsdescmultivariateBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateBuffer::fill(
  self : StatsdescmultivariateBuffer,
  v : Double,
) -> StatsdescmultivariateBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateBuffer::min(
  self : StatsdescmultivariateBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateBuffer::max(
  self : StatsdescmultivariateBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateBuffer::to_string(
  self : StatsdescmultivariateBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_cursor_make(
  size : Int32,
) -> StatsdescmultivariateCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateCursor::len(
  self : StatsdescmultivariateCursor,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateCursor::get(
  self : StatsdescmultivariateCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateCursor::set(
  self : StatsdescmultivariateCursor,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateCursor::sum(
  self : StatsdescmultivariateCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateCursor::mean(
  self : StatsdescmultivariateCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateCursor::scale(
  self : StatsdescmultivariateCursor,
  f : Double,
) -> StatsdescmultivariateCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateCursor::add(
  self : StatsdescmultivariateCursor,
  other : StatsdescmultivariateCursor,
) -> StatsdescmultivariateCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateCursor::copy(
  self : StatsdescmultivariateCursor,
) -> StatsdescmultivariateCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateCursor::fill(
  self : StatsdescmultivariateCursor,
  v : Double,
) -> StatsdescmultivariateCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateCursor::min(
  self : StatsdescmultivariateCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateCursor::max(
  self : StatsdescmultivariateCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateCursor::to_string(
  self : StatsdescmultivariateCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_view_make(
  size : Int32,
) -> StatsdescmultivariateView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateView::len(
  self : StatsdescmultivariateView,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateView::get(
  self : StatsdescmultivariateView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateView::set(
  self : StatsdescmultivariateView,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateView::sum(
  self : StatsdescmultivariateView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateView::mean(
  self : StatsdescmultivariateView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateView::scale(
  self : StatsdescmultivariateView,
  f : Double,
) -> StatsdescmultivariateView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateView::add(
  self : StatsdescmultivariateView,
  other : StatsdescmultivariateView,
) -> StatsdescmultivariateView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateView::copy(
  self : StatsdescmultivariateView,
) -> StatsdescmultivariateView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateView::fill(
  self : StatsdescmultivariateView,
  v : Double,
) -> StatsdescmultivariateView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateView::min(
  self : StatsdescmultivariateView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateView::max(
  self : StatsdescmultivariateView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateView::to_string(
  self : StatsdescmultivariateView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_range_make(
  size : Int32,
) -> StatsdescmultivariateRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateRange::len(
  self : StatsdescmultivariateRange,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateRange::get(
  self : StatsdescmultivariateRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateRange::set(
  self : StatsdescmultivariateRange,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateRange::sum(
  self : StatsdescmultivariateRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateRange::mean(
  self : StatsdescmultivariateRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateRange::scale(
  self : StatsdescmultivariateRange,
  f : Double,
) -> StatsdescmultivariateRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateRange::add(
  self : StatsdescmultivariateRange,
  other : StatsdescmultivariateRange,
) -> StatsdescmultivariateRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateRange::copy(
  self : StatsdescmultivariateRange,
) -> StatsdescmultivariateRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateRange::fill(
  self : StatsdescmultivariateRange,
  v : Double,
) -> StatsdescmultivariateRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateRange::min(
  self : StatsdescmultivariateRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateRange::max(
  self : StatsdescmultivariateRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateRange::to_string(
  self : StatsdescmultivariateRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescmultivariateSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_multivariate_slice_make(
  size : Int32,
) -> StatsdescmultivariateSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescmultivariateSlice::len(
  self : StatsdescmultivariateSlice,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescmultivariateSlice::get(
  self : StatsdescmultivariateSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescmultivariateSlice::set(
  self : StatsdescmultivariateSlice,
  i : Int32,
  v : Double,
) -> StatsdescmultivariateSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateSlice::sum(
  self : StatsdescmultivariateSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescmultivariateSlice::mean(
  self : StatsdescmultivariateSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescmultivariateSlice::scale(
  self : StatsdescmultivariateSlice,
  f : Double,
) -> StatsdescmultivariateSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateSlice::add(
  self : StatsdescmultivariateSlice,
  other : StatsdescmultivariateSlice,
) -> StatsdescmultivariateSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateSlice::copy(
  self : StatsdescmultivariateSlice,
) -> StatsdescmultivariateSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateSlice::fill(
  self : StatsdescmultivariateSlice,
  v : Double,
) -> StatsdescmultivariateSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescmultivariateSlice::min(
  self : StatsdescmultivariateSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescmultivariateSlice::max(
  self : StatsdescmultivariateSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescmultivariateSlice::to_string(
  self : StatsdescmultivariateSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
