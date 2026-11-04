///|
///===
/// extcore/db_query_aggregate
pub(all) struct DbqueryaggregatePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn db_query_aggregate_make_point(
  x : Double,
  y : Double,
) -> DbqueryaggregatePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn db_query_aggregate_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DbqueryaggregatePoint {
  { x, y, z, label: 0, }
}

///|
pub fn DbqueryaggregatePoint::x(self : DbqueryaggregatePoint) -> Double {
  self.x
}

///|
pub fn DbqueryaggregatePoint::y(self : DbqueryaggregatePoint) -> Double {
  self.y
}

///|
pub fn DbqueryaggregatePoint::z(self : DbqueryaggregatePoint) -> Double {
  self.z
}

///|
pub fn DbqueryaggregatePoint::label(self : DbqueryaggregatePoint) -> Int32 {
  self.label
}

///|
pub fn DbqueryaggregatePoint::dist(
  self : DbqueryaggregatePoint,
  other : DbqueryaggregatePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DbqueryaggregatePoint::add(
  self : DbqueryaggregatePoint,
  other : DbqueryaggregatePoint,
) -> DbqueryaggregatePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DbqueryaggregatePoint::sub(
  self : DbqueryaggregatePoint,
  other : DbqueryaggregatePoint,
) -> DbqueryaggregatePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DbqueryaggregatePoint::scale(
  self : DbqueryaggregatePoint,
  s : Double,
) -> DbqueryaggregatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DbqueryaggregatePoint::dot(
  self : DbqueryaggregatePoint,
  other : DbqueryaggregatePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DbqueryaggregatePoint::cross(
  self : DbqueryaggregatePoint,
  other : DbqueryaggregatePoint,
) -> DbqueryaggregatePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DbqueryaggregatePoint::norm(self : DbqueryaggregatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DbqueryaggregatePoint::normalize(
  self : DbqueryaggregatePoint,
) -> DbqueryaggregatePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbqueryaggregatePoint::negate(
  self : DbqueryaggregatePoint,
) -> DbqueryaggregatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DbqueryaggregatePoint::mid(
  self : DbqueryaggregatePoint,
  other : DbqueryaggregatePoint,
) -> DbqueryaggregatePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DbqueryaggregatePoint::lerp(
  self : DbqueryaggregatePoint,
  other : DbqueryaggregatePoint,
  t : Double,
) -> DbqueryaggregatePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DbqueryaggregatePoint::to_string(self : DbqueryaggregatePoint) -> String {
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
pub(all) struct DbqueryaggregateSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn db_query_aggregate_make_series(
  vals : Array[Double],
  name : String,
) -> DbqueryaggregateSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DbqueryaggregateSeries::len(self : DbqueryaggregateSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DbqueryaggregateSeries::sum(self : DbqueryaggregateSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DbqueryaggregateSeries::mean(self : DbqueryaggregateSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DbqueryaggregateSeries::min(self : DbqueryaggregateSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DbqueryaggregateSeries::max(self : DbqueryaggregateSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DbqueryaggregateSeries::range(self : DbqueryaggregateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DbqueryaggregateSeries::variance(
  self : DbqueryaggregateSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DbqueryaggregateSeries::std(self : DbqueryaggregateSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DbqueryaggregateSeries::median(self : DbqueryaggregateSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DbqueryaggregateSeries::scale(
  self : DbqueryaggregateSeries,
  f : Double,
) -> DbqueryaggregateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DbqueryaggregateSeries::add(
  self : DbqueryaggregateSeries,
  other : DbqueryaggregateSeries,
) -> DbqueryaggregateSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbqueryaggregateSeries::sub(
  self : DbqueryaggregateSeries,
  other : DbqueryaggregateSeries,
) -> DbqueryaggregateSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbqueryaggregateSeries::normalize(
  self : DbqueryaggregateSeries,
) -> DbqueryaggregateSeries {
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
pub fn DbqueryaggregateSeries::cumsum(
  self : DbqueryaggregateSeries,
) -> DbqueryaggregateSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DbqueryaggregateSeries::to_string(
  self : DbqueryaggregateSeries,
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
pub(all) struct DbqueryaggregateMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn db_query_aggregate_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DbqueryaggregateMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn db_query_aggregate_matrix_identity(n : Int32) -> DbqueryaggregateMatrix {
  let m = db_query_aggregate_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DbqueryaggregateMatrix::get(
  self : DbqueryaggregateMatrix,
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
pub fn DbqueryaggregateMatrix::transpose(
  self : DbqueryaggregateMatrix,
) -> DbqueryaggregateMatrix {
  let result = db_query_aggregate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DbqueryaggregateMatrix::add(
  self : DbqueryaggregateMatrix,
  other : DbqueryaggregateMatrix,
) -> DbqueryaggregateMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = db_query_aggregate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DbqueryaggregateMatrix::scale(
  self : DbqueryaggregateMatrix,
  s : Double,
) -> DbqueryaggregateMatrix {
  let result = db_query_aggregate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DbqueryaggregateMatrix::multiply(
  self : DbqueryaggregateMatrix,
  other : DbqueryaggregateMatrix,
) -> DbqueryaggregateMatrix {
  if self.cols != other.rows {
    return db_query_aggregate_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = db_query_aggregate_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DbqueryaggregateMatrix::trace(self : DbqueryaggregateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DbqueryaggregateMatrix::det(self : DbqueryaggregateMatrix) -> Double {
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
pub fn DbqueryaggregateMatrix::norm(self : DbqueryaggregateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DbqueryaggregateMatrix::to_string(
  self : DbqueryaggregateMatrix,
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
pub(all) struct DbqueryaggregateVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn db_query_aggregate_make_vector(
  comps : Array[Double],
) -> DbqueryaggregateVector {
  { comps, dim: comps.length(), }
}

///|
pub fn db_query_aggregate_vector_zero(dim : Int32) -> DbqueryaggregateVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DbqueryaggregateVector::add(
  self : DbqueryaggregateVector,
  other : DbqueryaggregateVector,
) -> DbqueryaggregateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbqueryaggregateVector::sub(
  self : DbqueryaggregateVector,
  other : DbqueryaggregateVector,
) -> DbqueryaggregateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbqueryaggregateVector::scale(
  self : DbqueryaggregateVector,
  s : Double,
) -> DbqueryaggregateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DbqueryaggregateVector::dot(
  self : DbqueryaggregateVector,
  other : DbqueryaggregateVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DbqueryaggregateVector::norm(self : DbqueryaggregateVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DbqueryaggregateVector::normalize(
  self : DbqueryaggregateVector,
) -> DbqueryaggregateVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbqueryaggregateVector::dist(
  self : DbqueryaggregateVector,
  other : DbqueryaggregateVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DbqueryaggregateVector::to_string(
  self : DbqueryaggregateVector,
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
pub(all) struct DbqueryaggregateFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_frame_make(size : Int32) -> DbqueryaggregateFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateFrame::len(self : DbqueryaggregateFrame) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateFrame::get(
  self : DbqueryaggregateFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateFrame::set(
  self : DbqueryaggregateFrame,
  i : Int32,
  v : Double,
) -> DbqueryaggregateFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateFrame::sum(self : DbqueryaggregateFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateFrame::mean(self : DbqueryaggregateFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateFrame::scale(
  self : DbqueryaggregateFrame,
  f : Double,
) -> DbqueryaggregateFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateFrame::add(
  self : DbqueryaggregateFrame,
  other : DbqueryaggregateFrame,
) -> DbqueryaggregateFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateFrame::copy(
  self : DbqueryaggregateFrame,
) -> DbqueryaggregateFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateFrame::fill(
  self : DbqueryaggregateFrame,
  v : Double,
) -> DbqueryaggregateFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateFrame::min(self : DbqueryaggregateFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateFrame::max(self : DbqueryaggregateFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateFrame::to_string(self : DbqueryaggregateFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_table_make(size : Int32) -> DbqueryaggregateTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateTable::len(self : DbqueryaggregateTable) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateTable::get(
  self : DbqueryaggregateTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateTable::set(
  self : DbqueryaggregateTable,
  i : Int32,
  v : Double,
) -> DbqueryaggregateTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateTable::sum(self : DbqueryaggregateTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateTable::mean(self : DbqueryaggregateTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateTable::scale(
  self : DbqueryaggregateTable,
  f : Double,
) -> DbqueryaggregateTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateTable::add(
  self : DbqueryaggregateTable,
  other : DbqueryaggregateTable,
) -> DbqueryaggregateTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateTable::copy(
  self : DbqueryaggregateTable,
) -> DbqueryaggregateTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateTable::fill(
  self : DbqueryaggregateTable,
  v : Double,
) -> DbqueryaggregateTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateTable::min(self : DbqueryaggregateTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateTable::max(self : DbqueryaggregateTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateTable::to_string(self : DbqueryaggregateTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_graphn_make(size : Int32) -> DbqueryaggregateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateGraphN::len(self : DbqueryaggregateGraphN) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateGraphN::get(
  self : DbqueryaggregateGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateGraphN::set(
  self : DbqueryaggregateGraphN,
  i : Int32,
  v : Double,
) -> DbqueryaggregateGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateGraphN::sum(self : DbqueryaggregateGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateGraphN::mean(self : DbqueryaggregateGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateGraphN::scale(
  self : DbqueryaggregateGraphN,
  f : Double,
) -> DbqueryaggregateGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateGraphN::add(
  self : DbqueryaggregateGraphN,
  other : DbqueryaggregateGraphN,
) -> DbqueryaggregateGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateGraphN::copy(
  self : DbqueryaggregateGraphN,
) -> DbqueryaggregateGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateGraphN::fill(
  self : DbqueryaggregateGraphN,
  v : Double,
) -> DbqueryaggregateGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateGraphN::min(self : DbqueryaggregateGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateGraphN::max(self : DbqueryaggregateGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateGraphN::to_string(
  self : DbqueryaggregateGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_node_make(size : Int32) -> DbqueryaggregateNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateNode::len(self : DbqueryaggregateNode) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateNode::get(
  self : DbqueryaggregateNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateNode::set(
  self : DbqueryaggregateNode,
  i : Int32,
  v : Double,
) -> DbqueryaggregateNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateNode::sum(self : DbqueryaggregateNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateNode::mean(self : DbqueryaggregateNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateNode::scale(
  self : DbqueryaggregateNode,
  f : Double,
) -> DbqueryaggregateNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateNode::add(
  self : DbqueryaggregateNode,
  other : DbqueryaggregateNode,
) -> DbqueryaggregateNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateNode::copy(
  self : DbqueryaggregateNode,
) -> DbqueryaggregateNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateNode::fill(
  self : DbqueryaggregateNode,
  v : Double,
) -> DbqueryaggregateNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateNode::min(self : DbqueryaggregateNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateNode::max(self : DbqueryaggregateNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateNode::to_string(self : DbqueryaggregateNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_edge_make(size : Int32) -> DbqueryaggregateEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateEdge::len(self : DbqueryaggregateEdge) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateEdge::get(
  self : DbqueryaggregateEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateEdge::set(
  self : DbqueryaggregateEdge,
  i : Int32,
  v : Double,
) -> DbqueryaggregateEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateEdge::sum(self : DbqueryaggregateEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateEdge::mean(self : DbqueryaggregateEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateEdge::scale(
  self : DbqueryaggregateEdge,
  f : Double,
) -> DbqueryaggregateEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateEdge::add(
  self : DbqueryaggregateEdge,
  other : DbqueryaggregateEdge,
) -> DbqueryaggregateEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateEdge::copy(
  self : DbqueryaggregateEdge,
) -> DbqueryaggregateEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateEdge::fill(
  self : DbqueryaggregateEdge,
  v : Double,
) -> DbqueryaggregateEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateEdge::min(self : DbqueryaggregateEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateEdge::max(self : DbqueryaggregateEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateEdge::to_string(self : DbqueryaggregateEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregatePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_path_make(size : Int32) -> DbqueryaggregatePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregatePath::len(self : DbqueryaggregatePath) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregatePath::get(
  self : DbqueryaggregatePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregatePath::set(
  self : DbqueryaggregatePath,
  i : Int32,
  v : Double,
) -> DbqueryaggregatePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregatePath::sum(self : DbqueryaggregatePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregatePath::mean(self : DbqueryaggregatePath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregatePath::scale(
  self : DbqueryaggregatePath,
  f : Double,
) -> DbqueryaggregatePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregatePath::add(
  self : DbqueryaggregatePath,
  other : DbqueryaggregatePath,
) -> DbqueryaggregatePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregatePath::copy(
  self : DbqueryaggregatePath,
) -> DbqueryaggregatePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregatePath::fill(
  self : DbqueryaggregatePath,
  v : Double,
) -> DbqueryaggregatePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregatePath::min(self : DbqueryaggregatePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregatePath::max(self : DbqueryaggregatePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregatePath::to_string(self : DbqueryaggregatePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_cluster_make(size : Int32) -> DbqueryaggregateCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateCluster::len(self : DbqueryaggregateCluster) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateCluster::get(
  self : DbqueryaggregateCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateCluster::set(
  self : DbqueryaggregateCluster,
  i : Int32,
  v : Double,
) -> DbqueryaggregateCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateCluster::sum(self : DbqueryaggregateCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateCluster::mean(self : DbqueryaggregateCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateCluster::scale(
  self : DbqueryaggregateCluster,
  f : Double,
) -> DbqueryaggregateCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateCluster::add(
  self : DbqueryaggregateCluster,
  other : DbqueryaggregateCluster,
) -> DbqueryaggregateCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateCluster::copy(
  self : DbqueryaggregateCluster,
) -> DbqueryaggregateCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateCluster::fill(
  self : DbqueryaggregateCluster,
  v : Double,
) -> DbqueryaggregateCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateCluster::min(self : DbqueryaggregateCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateCluster::max(self : DbqueryaggregateCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateCluster::to_string(
  self : DbqueryaggregateCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_model_make(size : Int32) -> DbqueryaggregateModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateModel::len(self : DbqueryaggregateModel) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateModel::get(
  self : DbqueryaggregateModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateModel::set(
  self : DbqueryaggregateModel,
  i : Int32,
  v : Double,
) -> DbqueryaggregateModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateModel::sum(self : DbqueryaggregateModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateModel::mean(self : DbqueryaggregateModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateModel::scale(
  self : DbqueryaggregateModel,
  f : Double,
) -> DbqueryaggregateModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateModel::add(
  self : DbqueryaggregateModel,
  other : DbqueryaggregateModel,
) -> DbqueryaggregateModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateModel::copy(
  self : DbqueryaggregateModel,
) -> DbqueryaggregateModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateModel::fill(
  self : DbqueryaggregateModel,
  v : Double,
) -> DbqueryaggregateModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateModel::min(self : DbqueryaggregateModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateModel::max(self : DbqueryaggregateModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateModel::to_string(self : DbqueryaggregateModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_layer_make(size : Int32) -> DbqueryaggregateLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateLayer::len(self : DbqueryaggregateLayer) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateLayer::get(
  self : DbqueryaggregateLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateLayer::set(
  self : DbqueryaggregateLayer,
  i : Int32,
  v : Double,
) -> DbqueryaggregateLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateLayer::sum(self : DbqueryaggregateLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateLayer::mean(self : DbqueryaggregateLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateLayer::scale(
  self : DbqueryaggregateLayer,
  f : Double,
) -> DbqueryaggregateLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateLayer::add(
  self : DbqueryaggregateLayer,
  other : DbqueryaggregateLayer,
) -> DbqueryaggregateLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateLayer::copy(
  self : DbqueryaggregateLayer,
) -> DbqueryaggregateLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateLayer::fill(
  self : DbqueryaggregateLayer,
  v : Double,
) -> DbqueryaggregateLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateLayer::min(self : DbqueryaggregateLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateLayer::max(self : DbqueryaggregateLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateLayer::to_string(self : DbqueryaggregateLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_buffer_make(size : Int32) -> DbqueryaggregateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateBuffer::len(self : DbqueryaggregateBuffer) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateBuffer::get(
  self : DbqueryaggregateBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateBuffer::set(
  self : DbqueryaggregateBuffer,
  i : Int32,
  v : Double,
) -> DbqueryaggregateBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateBuffer::sum(self : DbqueryaggregateBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateBuffer::mean(self : DbqueryaggregateBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateBuffer::scale(
  self : DbqueryaggregateBuffer,
  f : Double,
) -> DbqueryaggregateBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateBuffer::add(
  self : DbqueryaggregateBuffer,
  other : DbqueryaggregateBuffer,
) -> DbqueryaggregateBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateBuffer::copy(
  self : DbqueryaggregateBuffer,
) -> DbqueryaggregateBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateBuffer::fill(
  self : DbqueryaggregateBuffer,
  v : Double,
) -> DbqueryaggregateBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateBuffer::min(self : DbqueryaggregateBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateBuffer::max(self : DbqueryaggregateBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateBuffer::to_string(
  self : DbqueryaggregateBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_cursor_make(size : Int32) -> DbqueryaggregateCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateCursor::len(self : DbqueryaggregateCursor) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateCursor::get(
  self : DbqueryaggregateCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateCursor::set(
  self : DbqueryaggregateCursor,
  i : Int32,
  v : Double,
) -> DbqueryaggregateCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateCursor::sum(self : DbqueryaggregateCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateCursor::mean(self : DbqueryaggregateCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateCursor::scale(
  self : DbqueryaggregateCursor,
  f : Double,
) -> DbqueryaggregateCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateCursor::add(
  self : DbqueryaggregateCursor,
  other : DbqueryaggregateCursor,
) -> DbqueryaggregateCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateCursor::copy(
  self : DbqueryaggregateCursor,
) -> DbqueryaggregateCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateCursor::fill(
  self : DbqueryaggregateCursor,
  v : Double,
) -> DbqueryaggregateCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateCursor::min(self : DbqueryaggregateCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateCursor::max(self : DbqueryaggregateCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateCursor::to_string(
  self : DbqueryaggregateCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_view_make(size : Int32) -> DbqueryaggregateView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateView::len(self : DbqueryaggregateView) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateView::get(
  self : DbqueryaggregateView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateView::set(
  self : DbqueryaggregateView,
  i : Int32,
  v : Double,
) -> DbqueryaggregateView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateView::sum(self : DbqueryaggregateView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateView::mean(self : DbqueryaggregateView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateView::scale(
  self : DbqueryaggregateView,
  f : Double,
) -> DbqueryaggregateView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateView::add(
  self : DbqueryaggregateView,
  other : DbqueryaggregateView,
) -> DbqueryaggregateView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateView::copy(
  self : DbqueryaggregateView,
) -> DbqueryaggregateView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateView::fill(
  self : DbqueryaggregateView,
  v : Double,
) -> DbqueryaggregateView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateView::min(self : DbqueryaggregateView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateView::max(self : DbqueryaggregateView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateView::to_string(self : DbqueryaggregateView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_range_make(size : Int32) -> DbqueryaggregateRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateRange::len(self : DbqueryaggregateRange) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateRange::get(
  self : DbqueryaggregateRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateRange::set(
  self : DbqueryaggregateRange,
  i : Int32,
  v : Double,
) -> DbqueryaggregateRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateRange::sum(self : DbqueryaggregateRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateRange::mean(self : DbqueryaggregateRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateRange::scale(
  self : DbqueryaggregateRange,
  f : Double,
) -> DbqueryaggregateRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateRange::add(
  self : DbqueryaggregateRange,
  other : DbqueryaggregateRange,
) -> DbqueryaggregateRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateRange::copy(
  self : DbqueryaggregateRange,
) -> DbqueryaggregateRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateRange::fill(
  self : DbqueryaggregateRange,
  v : Double,
) -> DbqueryaggregateRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateRange::min(self : DbqueryaggregateRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateRange::max(self : DbqueryaggregateRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateRange::to_string(self : DbqueryaggregateRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbqueryaggregateSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_aggregate_slice_make(size : Int32) -> DbqueryaggregateSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbqueryaggregateSlice::len(self : DbqueryaggregateSlice) -> Int32 {
  self.size
}

///|
pub fn DbqueryaggregateSlice::get(
  self : DbqueryaggregateSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbqueryaggregateSlice::set(
  self : DbqueryaggregateSlice,
  i : Int32,
  v : Double,
) -> DbqueryaggregateSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateSlice::sum(self : DbqueryaggregateSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbqueryaggregateSlice::mean(self : DbqueryaggregateSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbqueryaggregateSlice::scale(
  self : DbqueryaggregateSlice,
  f : Double,
) -> DbqueryaggregateSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateSlice::add(
  self : DbqueryaggregateSlice,
  other : DbqueryaggregateSlice,
) -> DbqueryaggregateSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbqueryaggregateSlice::copy(
  self : DbqueryaggregateSlice,
) -> DbqueryaggregateSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateSlice::fill(
  self : DbqueryaggregateSlice,
  v : Double,
) -> DbqueryaggregateSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbqueryaggregateSlice::min(self : DbqueryaggregateSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbqueryaggregateSlice::max(self : DbqueryaggregateSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbqueryaggregateSlice::to_string(self : DbqueryaggregateSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
