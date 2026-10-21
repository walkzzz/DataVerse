///|
///===
/// extcore/stats_desc_univariate
pub(all) struct StatsdescunivariatePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_desc_univariate_make_point(
  x : Double,
  y : Double,
) -> StatsdescunivariatePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_desc_univariate_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatsdescunivariatePoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatsdescunivariatePoint::x(self : StatsdescunivariatePoint) -> Double {
  self.x
}

///|
pub fn StatsdescunivariatePoint::y(self : StatsdescunivariatePoint) -> Double {
  self.y
}

///|
pub fn StatsdescunivariatePoint::z(self : StatsdescunivariatePoint) -> Double {
  self.z
}

///|
pub fn StatsdescunivariatePoint::label(
  self : StatsdescunivariatePoint,
) -> Int32 {
  self.label
}

///|
pub fn StatsdescunivariatePoint::dist(
  self : StatsdescunivariatePoint,
  other : StatsdescunivariatePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatsdescunivariatePoint::add(
  self : StatsdescunivariatePoint,
  other : StatsdescunivariatePoint,
) -> StatsdescunivariatePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatsdescunivariatePoint::sub(
  self : StatsdescunivariatePoint,
  other : StatsdescunivariatePoint,
) -> StatsdescunivariatePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatsdescunivariatePoint::scale(
  self : StatsdescunivariatePoint,
  s : Double,
) -> StatsdescunivariatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatsdescunivariatePoint::dot(
  self : StatsdescunivariatePoint,
  other : StatsdescunivariatePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatsdescunivariatePoint::cross(
  self : StatsdescunivariatePoint,
  other : StatsdescunivariatePoint,
) -> StatsdescunivariatePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatsdescunivariatePoint::norm(
  self : StatsdescunivariatePoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatsdescunivariatePoint::normalize(
  self : StatsdescunivariatePoint,
) -> StatsdescunivariatePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdescunivariatePoint::negate(
  self : StatsdescunivariatePoint,
) -> StatsdescunivariatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatsdescunivariatePoint::mid(
  self : StatsdescunivariatePoint,
  other : StatsdescunivariatePoint,
) -> StatsdescunivariatePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatsdescunivariatePoint::lerp(
  self : StatsdescunivariatePoint,
  other : StatsdescunivariatePoint,
  t : Double,
) -> StatsdescunivariatePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatsdescunivariatePoint::to_string(
  self : StatsdescunivariatePoint,
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
pub(all) struct StatsdescunivariateSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_desc_univariate_make_series(
  vals : Array[Double],
  name : String,
) -> StatsdescunivariateSeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatsdescunivariateSeries::len(
  self : StatsdescunivariateSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn StatsdescunivariateSeries::sum(
  self : StatsdescunivariateSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatsdescunivariateSeries::mean(
  self : StatsdescunivariateSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatsdescunivariateSeries::min(
  self : StatsdescunivariateSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatsdescunivariateSeries::max(
  self : StatsdescunivariateSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatsdescunivariateSeries::range(
  self : StatsdescunivariateSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatsdescunivariateSeries::variance(
  self : StatsdescunivariateSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatsdescunivariateSeries::std(
  self : StatsdescunivariateSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatsdescunivariateSeries::median(
  self : StatsdescunivariateSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatsdescunivariateSeries::scale(
  self : StatsdescunivariateSeries,
  f : Double,
) -> StatsdescunivariateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatsdescunivariateSeries::add(
  self : StatsdescunivariateSeries,
  other : StatsdescunivariateSeries,
) -> StatsdescunivariateSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdescunivariateSeries::sub(
  self : StatsdescunivariateSeries,
  other : StatsdescunivariateSeries,
) -> StatsdescunivariateSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdescunivariateSeries::normalize(
  self : StatsdescunivariateSeries,
) -> StatsdescunivariateSeries {
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
pub fn StatsdescunivariateSeries::cumsum(
  self : StatsdescunivariateSeries,
) -> StatsdescunivariateSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatsdescunivariateSeries::to_string(
  self : StatsdescunivariateSeries,
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
pub(all) struct StatsdescunivariateMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_desc_univariate_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatsdescunivariateMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_desc_univariate_matrix_identity(
  n : Int32,
) -> StatsdescunivariateMatrix {
  let m = stats_desc_univariate_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatsdescunivariateMatrix::get(
  self : StatsdescunivariateMatrix,
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
pub fn StatsdescunivariateMatrix::transpose(
  self : StatsdescunivariateMatrix,
) -> StatsdescunivariateMatrix {
  let result = stats_desc_univariate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdescunivariateMatrix::add(
  self : StatsdescunivariateMatrix,
  other : StatsdescunivariateMatrix,
) -> StatsdescunivariateMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_desc_univariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdescunivariateMatrix::scale(
  self : StatsdescunivariateMatrix,
  s : Double,
) -> StatsdescunivariateMatrix {
  let result = stats_desc_univariate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatsdescunivariateMatrix::multiply(
  self : StatsdescunivariateMatrix,
  other : StatsdescunivariateMatrix,
) -> StatsdescunivariateMatrix {
  if self.cols != other.rows {
    return stats_desc_univariate_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_desc_univariate_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatsdescunivariateMatrix::trace(
  self : StatsdescunivariateMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatsdescunivariateMatrix::det(
  self : StatsdescunivariateMatrix,
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
pub fn StatsdescunivariateMatrix::norm(
  self : StatsdescunivariateMatrix,
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
pub fn StatsdescunivariateMatrix::to_string(
  self : StatsdescunivariateMatrix,
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
pub(all) struct StatsdescunivariateVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_desc_univariate_make_vector(
  comps : Array[Double],
) -> StatsdescunivariateVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_desc_univariate_vector_zero(
  dim : Int32,
) -> StatsdescunivariateVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatsdescunivariateVector::add(
  self : StatsdescunivariateVector,
  other : StatsdescunivariateVector,
) -> StatsdescunivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdescunivariateVector::sub(
  self : StatsdescunivariateVector,
  other : StatsdescunivariateVector,
) -> StatsdescunivariateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdescunivariateVector::scale(
  self : StatsdescunivariateVector,
  s : Double,
) -> StatsdescunivariateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatsdescunivariateVector::dot(
  self : StatsdescunivariateVector,
  other : StatsdescunivariateVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatsdescunivariateVector::norm(
  self : StatsdescunivariateVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatsdescunivariateVector::normalize(
  self : StatsdescunivariateVector,
) -> StatsdescunivariateVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdescunivariateVector::dist(
  self : StatsdescunivariateVector,
  other : StatsdescunivariateVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatsdescunivariateVector::to_string(
  self : StatsdescunivariateVector,
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
pub(all) struct StatsdescunivariateFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_frame_make(
  size : Int32,
) -> StatsdescunivariateFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateFrame::len(self : StatsdescunivariateFrame) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateFrame::get(
  self : StatsdescunivariateFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateFrame::set(
  self : StatsdescunivariateFrame,
  i : Int32,
  v : Double,
) -> StatsdescunivariateFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateFrame::sum(self : StatsdescunivariateFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateFrame::mean(
  self : StatsdescunivariateFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateFrame::scale(
  self : StatsdescunivariateFrame,
  f : Double,
) -> StatsdescunivariateFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateFrame::add(
  self : StatsdescunivariateFrame,
  other : StatsdescunivariateFrame,
) -> StatsdescunivariateFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateFrame::copy(
  self : StatsdescunivariateFrame,
) -> StatsdescunivariateFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateFrame::fill(
  self : StatsdescunivariateFrame,
  v : Double,
) -> StatsdescunivariateFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateFrame::min(self : StatsdescunivariateFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateFrame::max(self : StatsdescunivariateFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateFrame::to_string(
  self : StatsdescunivariateFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_table_make(
  size : Int32,
) -> StatsdescunivariateTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateTable::len(self : StatsdescunivariateTable) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateTable::get(
  self : StatsdescunivariateTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateTable::set(
  self : StatsdescunivariateTable,
  i : Int32,
  v : Double,
) -> StatsdescunivariateTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateTable::sum(self : StatsdescunivariateTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateTable::mean(
  self : StatsdescunivariateTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateTable::scale(
  self : StatsdescunivariateTable,
  f : Double,
) -> StatsdescunivariateTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateTable::add(
  self : StatsdescunivariateTable,
  other : StatsdescunivariateTable,
) -> StatsdescunivariateTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateTable::copy(
  self : StatsdescunivariateTable,
) -> StatsdescunivariateTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateTable::fill(
  self : StatsdescunivariateTable,
  v : Double,
) -> StatsdescunivariateTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateTable::min(self : StatsdescunivariateTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateTable::max(self : StatsdescunivariateTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateTable::to_string(
  self : StatsdescunivariateTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_graphn_make(
  size : Int32,
) -> StatsdescunivariateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateGraphN::len(
  self : StatsdescunivariateGraphN,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateGraphN::get(
  self : StatsdescunivariateGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateGraphN::set(
  self : StatsdescunivariateGraphN,
  i : Int32,
  v : Double,
) -> StatsdescunivariateGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateGraphN::sum(
  self : StatsdescunivariateGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateGraphN::mean(
  self : StatsdescunivariateGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateGraphN::scale(
  self : StatsdescunivariateGraphN,
  f : Double,
) -> StatsdescunivariateGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateGraphN::add(
  self : StatsdescunivariateGraphN,
  other : StatsdescunivariateGraphN,
) -> StatsdescunivariateGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateGraphN::copy(
  self : StatsdescunivariateGraphN,
) -> StatsdescunivariateGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateGraphN::fill(
  self : StatsdescunivariateGraphN,
  v : Double,
) -> StatsdescunivariateGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateGraphN::min(
  self : StatsdescunivariateGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateGraphN::max(
  self : StatsdescunivariateGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateGraphN::to_string(
  self : StatsdescunivariateGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_node_make(size : Int32) -> StatsdescunivariateNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateNode::len(self : StatsdescunivariateNode) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateNode::get(
  self : StatsdescunivariateNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateNode::set(
  self : StatsdescunivariateNode,
  i : Int32,
  v : Double,
) -> StatsdescunivariateNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateNode::sum(self : StatsdescunivariateNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateNode::mean(self : StatsdescunivariateNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateNode::scale(
  self : StatsdescunivariateNode,
  f : Double,
) -> StatsdescunivariateNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateNode::add(
  self : StatsdescunivariateNode,
  other : StatsdescunivariateNode,
) -> StatsdescunivariateNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateNode::copy(
  self : StatsdescunivariateNode,
) -> StatsdescunivariateNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateNode::fill(
  self : StatsdescunivariateNode,
  v : Double,
) -> StatsdescunivariateNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateNode::min(self : StatsdescunivariateNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateNode::max(self : StatsdescunivariateNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateNode::to_string(
  self : StatsdescunivariateNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_edge_make(size : Int32) -> StatsdescunivariateEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateEdge::len(self : StatsdescunivariateEdge) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateEdge::get(
  self : StatsdescunivariateEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateEdge::set(
  self : StatsdescunivariateEdge,
  i : Int32,
  v : Double,
) -> StatsdescunivariateEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateEdge::sum(self : StatsdescunivariateEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateEdge::mean(self : StatsdescunivariateEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateEdge::scale(
  self : StatsdescunivariateEdge,
  f : Double,
) -> StatsdescunivariateEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateEdge::add(
  self : StatsdescunivariateEdge,
  other : StatsdescunivariateEdge,
) -> StatsdescunivariateEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateEdge::copy(
  self : StatsdescunivariateEdge,
) -> StatsdescunivariateEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateEdge::fill(
  self : StatsdescunivariateEdge,
  v : Double,
) -> StatsdescunivariateEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateEdge::min(self : StatsdescunivariateEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateEdge::max(self : StatsdescunivariateEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateEdge::to_string(
  self : StatsdescunivariateEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariatePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_path_make(size : Int32) -> StatsdescunivariatePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariatePath::len(self : StatsdescunivariatePath) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariatePath::get(
  self : StatsdescunivariatePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariatePath::set(
  self : StatsdescunivariatePath,
  i : Int32,
  v : Double,
) -> StatsdescunivariatePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariatePath::sum(self : StatsdescunivariatePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariatePath::mean(self : StatsdescunivariatePath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariatePath::scale(
  self : StatsdescunivariatePath,
  f : Double,
) -> StatsdescunivariatePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariatePath::add(
  self : StatsdescunivariatePath,
  other : StatsdescunivariatePath,
) -> StatsdescunivariatePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariatePath::copy(
  self : StatsdescunivariatePath,
) -> StatsdescunivariatePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariatePath::fill(
  self : StatsdescunivariatePath,
  v : Double,
) -> StatsdescunivariatePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariatePath::min(self : StatsdescunivariatePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariatePath::max(self : StatsdescunivariatePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariatePath::to_string(
  self : StatsdescunivariatePath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_cluster_make(
  size : Int32,
) -> StatsdescunivariateCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateCluster::len(
  self : StatsdescunivariateCluster,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateCluster::get(
  self : StatsdescunivariateCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateCluster::set(
  self : StatsdescunivariateCluster,
  i : Int32,
  v : Double,
) -> StatsdescunivariateCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateCluster::sum(
  self : StatsdescunivariateCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateCluster::mean(
  self : StatsdescunivariateCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateCluster::scale(
  self : StatsdescunivariateCluster,
  f : Double,
) -> StatsdescunivariateCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateCluster::add(
  self : StatsdescunivariateCluster,
  other : StatsdescunivariateCluster,
) -> StatsdescunivariateCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateCluster::copy(
  self : StatsdescunivariateCluster,
) -> StatsdescunivariateCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateCluster::fill(
  self : StatsdescunivariateCluster,
  v : Double,
) -> StatsdescunivariateCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateCluster::min(
  self : StatsdescunivariateCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateCluster::max(
  self : StatsdescunivariateCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateCluster::to_string(
  self : StatsdescunivariateCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_model_make(
  size : Int32,
) -> StatsdescunivariateModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateModel::len(self : StatsdescunivariateModel) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateModel::get(
  self : StatsdescunivariateModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateModel::set(
  self : StatsdescunivariateModel,
  i : Int32,
  v : Double,
) -> StatsdescunivariateModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateModel::sum(self : StatsdescunivariateModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateModel::mean(
  self : StatsdescunivariateModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateModel::scale(
  self : StatsdescunivariateModel,
  f : Double,
) -> StatsdescunivariateModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateModel::add(
  self : StatsdescunivariateModel,
  other : StatsdescunivariateModel,
) -> StatsdescunivariateModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateModel::copy(
  self : StatsdescunivariateModel,
) -> StatsdescunivariateModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateModel::fill(
  self : StatsdescunivariateModel,
  v : Double,
) -> StatsdescunivariateModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateModel::min(self : StatsdescunivariateModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateModel::max(self : StatsdescunivariateModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateModel::to_string(
  self : StatsdescunivariateModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_layer_make(
  size : Int32,
) -> StatsdescunivariateLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateLayer::len(self : StatsdescunivariateLayer) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateLayer::get(
  self : StatsdescunivariateLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateLayer::set(
  self : StatsdescunivariateLayer,
  i : Int32,
  v : Double,
) -> StatsdescunivariateLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateLayer::sum(self : StatsdescunivariateLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateLayer::mean(
  self : StatsdescunivariateLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateLayer::scale(
  self : StatsdescunivariateLayer,
  f : Double,
) -> StatsdescunivariateLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateLayer::add(
  self : StatsdescunivariateLayer,
  other : StatsdescunivariateLayer,
) -> StatsdescunivariateLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateLayer::copy(
  self : StatsdescunivariateLayer,
) -> StatsdescunivariateLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateLayer::fill(
  self : StatsdescunivariateLayer,
  v : Double,
) -> StatsdescunivariateLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateLayer::min(self : StatsdescunivariateLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateLayer::max(self : StatsdescunivariateLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateLayer::to_string(
  self : StatsdescunivariateLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_buffer_make(
  size : Int32,
) -> StatsdescunivariateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateBuffer::len(
  self : StatsdescunivariateBuffer,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateBuffer::get(
  self : StatsdescunivariateBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateBuffer::set(
  self : StatsdescunivariateBuffer,
  i : Int32,
  v : Double,
) -> StatsdescunivariateBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateBuffer::sum(
  self : StatsdescunivariateBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateBuffer::mean(
  self : StatsdescunivariateBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateBuffer::scale(
  self : StatsdescunivariateBuffer,
  f : Double,
) -> StatsdescunivariateBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateBuffer::add(
  self : StatsdescunivariateBuffer,
  other : StatsdescunivariateBuffer,
) -> StatsdescunivariateBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateBuffer::copy(
  self : StatsdescunivariateBuffer,
) -> StatsdescunivariateBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateBuffer::fill(
  self : StatsdescunivariateBuffer,
  v : Double,
) -> StatsdescunivariateBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateBuffer::min(
  self : StatsdescunivariateBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateBuffer::max(
  self : StatsdescunivariateBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateBuffer::to_string(
  self : StatsdescunivariateBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_cursor_make(
  size : Int32,
) -> StatsdescunivariateCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateCursor::len(
  self : StatsdescunivariateCursor,
) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateCursor::get(
  self : StatsdescunivariateCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateCursor::set(
  self : StatsdescunivariateCursor,
  i : Int32,
  v : Double,
) -> StatsdescunivariateCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateCursor::sum(
  self : StatsdescunivariateCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateCursor::mean(
  self : StatsdescunivariateCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateCursor::scale(
  self : StatsdescunivariateCursor,
  f : Double,
) -> StatsdescunivariateCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateCursor::add(
  self : StatsdescunivariateCursor,
  other : StatsdescunivariateCursor,
) -> StatsdescunivariateCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateCursor::copy(
  self : StatsdescunivariateCursor,
) -> StatsdescunivariateCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateCursor::fill(
  self : StatsdescunivariateCursor,
  v : Double,
) -> StatsdescunivariateCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateCursor::min(
  self : StatsdescunivariateCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateCursor::max(
  self : StatsdescunivariateCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateCursor::to_string(
  self : StatsdescunivariateCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_view_make(size : Int32) -> StatsdescunivariateView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateView::len(self : StatsdescunivariateView) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateView::get(
  self : StatsdescunivariateView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateView::set(
  self : StatsdescunivariateView,
  i : Int32,
  v : Double,
) -> StatsdescunivariateView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateView::sum(self : StatsdescunivariateView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateView::mean(self : StatsdescunivariateView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateView::scale(
  self : StatsdescunivariateView,
  f : Double,
) -> StatsdescunivariateView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateView::add(
  self : StatsdescunivariateView,
  other : StatsdescunivariateView,
) -> StatsdescunivariateView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateView::copy(
  self : StatsdescunivariateView,
) -> StatsdescunivariateView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateView::fill(
  self : StatsdescunivariateView,
  v : Double,
) -> StatsdescunivariateView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateView::min(self : StatsdescunivariateView) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateView::max(self : StatsdescunivariateView) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateView::to_string(
  self : StatsdescunivariateView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_range_make(
  size : Int32,
) -> StatsdescunivariateRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateRange::len(self : StatsdescunivariateRange) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateRange::get(
  self : StatsdescunivariateRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateRange::set(
  self : StatsdescunivariateRange,
  i : Int32,
  v : Double,
) -> StatsdescunivariateRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateRange::sum(self : StatsdescunivariateRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateRange::mean(
  self : StatsdescunivariateRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateRange::scale(
  self : StatsdescunivariateRange,
  f : Double,
) -> StatsdescunivariateRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateRange::add(
  self : StatsdescunivariateRange,
  other : StatsdescunivariateRange,
) -> StatsdescunivariateRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateRange::copy(
  self : StatsdescunivariateRange,
) -> StatsdescunivariateRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateRange::fill(
  self : StatsdescunivariateRange,
  v : Double,
) -> StatsdescunivariateRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateRange::min(self : StatsdescunivariateRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateRange::max(self : StatsdescunivariateRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateRange::to_string(
  self : StatsdescunivariateRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdescunivariateSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_desc_univariate_slice_make(
  size : Int32,
) -> StatsdescunivariateSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdescunivariateSlice::len(self : StatsdescunivariateSlice) -> Int32 {
  self.size
}

///|
pub fn StatsdescunivariateSlice::get(
  self : StatsdescunivariateSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdescunivariateSlice::set(
  self : StatsdescunivariateSlice,
  i : Int32,
  v : Double,
) -> StatsdescunivariateSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateSlice::sum(self : StatsdescunivariateSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdescunivariateSlice::mean(
  self : StatsdescunivariateSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdescunivariateSlice::scale(
  self : StatsdescunivariateSlice,
  f : Double,
) -> StatsdescunivariateSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateSlice::add(
  self : StatsdescunivariateSlice,
  other : StatsdescunivariateSlice,
) -> StatsdescunivariateSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdescunivariateSlice::copy(
  self : StatsdescunivariateSlice,
) -> StatsdescunivariateSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateSlice::fill(
  self : StatsdescunivariateSlice,
  v : Double,
) -> StatsdescunivariateSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdescunivariateSlice::min(self : StatsdescunivariateSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdescunivariateSlice::max(self : StatsdescunivariateSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdescunivariateSlice::to_string(
  self : StatsdescunivariateSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
