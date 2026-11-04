///|
///===
/// extcore/graph_search_bidirectional
pub(all) struct GraphsearchbidirectionalPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_search_bidirectional_make_point(
  x : Double,
  y : Double,
) -> GraphsearchbidirectionalPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_search_bidirectional_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphsearchbidirectionalPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphsearchbidirectionalPoint::x(
  self : GraphsearchbidirectionalPoint,
) -> Double {
  self.x
}

///|
pub fn GraphsearchbidirectionalPoint::y(
  self : GraphsearchbidirectionalPoint,
) -> Double {
  self.y
}

///|
pub fn GraphsearchbidirectionalPoint::z(
  self : GraphsearchbidirectionalPoint,
) -> Double {
  self.z
}

///|
pub fn GraphsearchbidirectionalPoint::label(
  self : GraphsearchbidirectionalPoint,
) -> Int32 {
  self.label
}

///|
pub fn GraphsearchbidirectionalPoint::dist(
  self : GraphsearchbidirectionalPoint,
  other : GraphsearchbidirectionalPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphsearchbidirectionalPoint::add(
  self : GraphsearchbidirectionalPoint,
  other : GraphsearchbidirectionalPoint,
) -> GraphsearchbidirectionalPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphsearchbidirectionalPoint::sub(
  self : GraphsearchbidirectionalPoint,
  other : GraphsearchbidirectionalPoint,
) -> GraphsearchbidirectionalPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphsearchbidirectionalPoint::scale(
  self : GraphsearchbidirectionalPoint,
  s : Double,
) -> GraphsearchbidirectionalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphsearchbidirectionalPoint::dot(
  self : GraphsearchbidirectionalPoint,
  other : GraphsearchbidirectionalPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphsearchbidirectionalPoint::cross(
  self : GraphsearchbidirectionalPoint,
  other : GraphsearchbidirectionalPoint,
) -> GraphsearchbidirectionalPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphsearchbidirectionalPoint::norm(
  self : GraphsearchbidirectionalPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphsearchbidirectionalPoint::normalize(
  self : GraphsearchbidirectionalPoint,
) -> GraphsearchbidirectionalPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphsearchbidirectionalPoint::negate(
  self : GraphsearchbidirectionalPoint,
) -> GraphsearchbidirectionalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphsearchbidirectionalPoint::mid(
  self : GraphsearchbidirectionalPoint,
  other : GraphsearchbidirectionalPoint,
) -> GraphsearchbidirectionalPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphsearchbidirectionalPoint::lerp(
  self : GraphsearchbidirectionalPoint,
  other : GraphsearchbidirectionalPoint,
  t : Double,
) -> GraphsearchbidirectionalPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphsearchbidirectionalPoint::to_string(
  self : GraphsearchbidirectionalPoint,
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
pub(all) struct GraphsearchbidirectionalSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_search_bidirectional_make_series(
  vals : Array[Double],
  name : String,
) -> GraphsearchbidirectionalSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphsearchbidirectionalSeries::len(
  self : GraphsearchbidirectionalSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphsearchbidirectionalSeries::sum(
  self : GraphsearchbidirectionalSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphsearchbidirectionalSeries::mean(
  self : GraphsearchbidirectionalSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphsearchbidirectionalSeries::min(
  self : GraphsearchbidirectionalSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphsearchbidirectionalSeries::max(
  self : GraphsearchbidirectionalSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphsearchbidirectionalSeries::range(
  self : GraphsearchbidirectionalSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphsearchbidirectionalSeries::variance(
  self : GraphsearchbidirectionalSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphsearchbidirectionalSeries::std(
  self : GraphsearchbidirectionalSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphsearchbidirectionalSeries::median(
  self : GraphsearchbidirectionalSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphsearchbidirectionalSeries::scale(
  self : GraphsearchbidirectionalSeries,
  f : Double,
) -> GraphsearchbidirectionalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphsearchbidirectionalSeries::add(
  self : GraphsearchbidirectionalSeries,
  other : GraphsearchbidirectionalSeries,
) -> GraphsearchbidirectionalSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphsearchbidirectionalSeries::sub(
  self : GraphsearchbidirectionalSeries,
  other : GraphsearchbidirectionalSeries,
) -> GraphsearchbidirectionalSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphsearchbidirectionalSeries::normalize(
  self : GraphsearchbidirectionalSeries,
) -> GraphsearchbidirectionalSeries {
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
pub fn GraphsearchbidirectionalSeries::cumsum(
  self : GraphsearchbidirectionalSeries,
) -> GraphsearchbidirectionalSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphsearchbidirectionalSeries::to_string(
  self : GraphsearchbidirectionalSeries,
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
pub(all) struct GraphsearchbidirectionalMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_search_bidirectional_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphsearchbidirectionalMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_search_bidirectional_matrix_identity(
  n : Int32,
) -> GraphsearchbidirectionalMatrix {
  let m = graph_search_bidirectional_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphsearchbidirectionalMatrix::get(
  self : GraphsearchbidirectionalMatrix,
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
pub fn GraphsearchbidirectionalMatrix::transpose(
  self : GraphsearchbidirectionalMatrix,
) -> GraphsearchbidirectionalMatrix {
  let result = graph_search_bidirectional_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphsearchbidirectionalMatrix::add(
  self : GraphsearchbidirectionalMatrix,
  other : GraphsearchbidirectionalMatrix,
) -> GraphsearchbidirectionalMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_search_bidirectional_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphsearchbidirectionalMatrix::scale(
  self : GraphsearchbidirectionalMatrix,
  s : Double,
) -> GraphsearchbidirectionalMatrix {
  let result = graph_search_bidirectional_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphsearchbidirectionalMatrix::multiply(
  self : GraphsearchbidirectionalMatrix,
  other : GraphsearchbidirectionalMatrix,
) -> GraphsearchbidirectionalMatrix {
  if self.cols != other.rows {
    return graph_search_bidirectional_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_search_bidirectional_make_matrix(
    self.rows,
    other.cols,
    0.0,
  )
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
pub fn GraphsearchbidirectionalMatrix::trace(
  self : GraphsearchbidirectionalMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphsearchbidirectionalMatrix::det(
  self : GraphsearchbidirectionalMatrix,
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
pub fn GraphsearchbidirectionalMatrix::norm(
  self : GraphsearchbidirectionalMatrix,
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
pub fn GraphsearchbidirectionalMatrix::to_string(
  self : GraphsearchbidirectionalMatrix,
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
pub(all) struct GraphsearchbidirectionalVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_search_bidirectional_make_vector(
  comps : Array[Double],
) -> GraphsearchbidirectionalVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_search_bidirectional_vector_zero(
  dim : Int32,
) -> GraphsearchbidirectionalVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphsearchbidirectionalVector::add(
  self : GraphsearchbidirectionalVector,
  other : GraphsearchbidirectionalVector,
) -> GraphsearchbidirectionalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphsearchbidirectionalVector::sub(
  self : GraphsearchbidirectionalVector,
  other : GraphsearchbidirectionalVector,
) -> GraphsearchbidirectionalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphsearchbidirectionalVector::scale(
  self : GraphsearchbidirectionalVector,
  s : Double,
) -> GraphsearchbidirectionalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphsearchbidirectionalVector::dot(
  self : GraphsearchbidirectionalVector,
  other : GraphsearchbidirectionalVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphsearchbidirectionalVector::norm(
  self : GraphsearchbidirectionalVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphsearchbidirectionalVector::normalize(
  self : GraphsearchbidirectionalVector,
) -> GraphsearchbidirectionalVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphsearchbidirectionalVector::dist(
  self : GraphsearchbidirectionalVector,
  other : GraphsearchbidirectionalVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphsearchbidirectionalVector::to_string(
  self : GraphsearchbidirectionalVector,
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
pub(all) struct GraphsearchbidirectionalFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_frame_make(
  size : Int32,
) -> GraphsearchbidirectionalFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalFrame::len(
  self : GraphsearchbidirectionalFrame,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalFrame::get(
  self : GraphsearchbidirectionalFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalFrame::set(
  self : GraphsearchbidirectionalFrame,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalFrame::sum(
  self : GraphsearchbidirectionalFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalFrame::mean(
  self : GraphsearchbidirectionalFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalFrame::scale(
  self : GraphsearchbidirectionalFrame,
  f : Double,
) -> GraphsearchbidirectionalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalFrame::add(
  self : GraphsearchbidirectionalFrame,
  other : GraphsearchbidirectionalFrame,
) -> GraphsearchbidirectionalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalFrame::copy(
  self : GraphsearchbidirectionalFrame,
) -> GraphsearchbidirectionalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalFrame::fill(
  self : GraphsearchbidirectionalFrame,
  v : Double,
) -> GraphsearchbidirectionalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalFrame::min(
  self : GraphsearchbidirectionalFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalFrame::max(
  self : GraphsearchbidirectionalFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalFrame::to_string(
  self : GraphsearchbidirectionalFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_table_make(
  size : Int32,
) -> GraphsearchbidirectionalTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalTable::len(
  self : GraphsearchbidirectionalTable,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalTable::get(
  self : GraphsearchbidirectionalTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalTable::set(
  self : GraphsearchbidirectionalTable,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalTable::sum(
  self : GraphsearchbidirectionalTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalTable::mean(
  self : GraphsearchbidirectionalTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalTable::scale(
  self : GraphsearchbidirectionalTable,
  f : Double,
) -> GraphsearchbidirectionalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalTable::add(
  self : GraphsearchbidirectionalTable,
  other : GraphsearchbidirectionalTable,
) -> GraphsearchbidirectionalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalTable::copy(
  self : GraphsearchbidirectionalTable,
) -> GraphsearchbidirectionalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalTable::fill(
  self : GraphsearchbidirectionalTable,
  v : Double,
) -> GraphsearchbidirectionalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalTable::min(
  self : GraphsearchbidirectionalTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalTable::max(
  self : GraphsearchbidirectionalTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalTable::to_string(
  self : GraphsearchbidirectionalTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_graphn_make(
  size : Int32,
) -> GraphsearchbidirectionalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalGraphN::len(
  self : GraphsearchbidirectionalGraphN,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalGraphN::get(
  self : GraphsearchbidirectionalGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalGraphN::set(
  self : GraphsearchbidirectionalGraphN,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalGraphN::sum(
  self : GraphsearchbidirectionalGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalGraphN::mean(
  self : GraphsearchbidirectionalGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalGraphN::scale(
  self : GraphsearchbidirectionalGraphN,
  f : Double,
) -> GraphsearchbidirectionalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalGraphN::add(
  self : GraphsearchbidirectionalGraphN,
  other : GraphsearchbidirectionalGraphN,
) -> GraphsearchbidirectionalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalGraphN::copy(
  self : GraphsearchbidirectionalGraphN,
) -> GraphsearchbidirectionalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalGraphN::fill(
  self : GraphsearchbidirectionalGraphN,
  v : Double,
) -> GraphsearchbidirectionalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalGraphN::min(
  self : GraphsearchbidirectionalGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalGraphN::max(
  self : GraphsearchbidirectionalGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalGraphN::to_string(
  self : GraphsearchbidirectionalGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_node_make(
  size : Int32,
) -> GraphsearchbidirectionalNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalNode::len(
  self : GraphsearchbidirectionalNode,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalNode::get(
  self : GraphsearchbidirectionalNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalNode::set(
  self : GraphsearchbidirectionalNode,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalNode::sum(
  self : GraphsearchbidirectionalNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalNode::mean(
  self : GraphsearchbidirectionalNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalNode::scale(
  self : GraphsearchbidirectionalNode,
  f : Double,
) -> GraphsearchbidirectionalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalNode::add(
  self : GraphsearchbidirectionalNode,
  other : GraphsearchbidirectionalNode,
) -> GraphsearchbidirectionalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalNode::copy(
  self : GraphsearchbidirectionalNode,
) -> GraphsearchbidirectionalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalNode::fill(
  self : GraphsearchbidirectionalNode,
  v : Double,
) -> GraphsearchbidirectionalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalNode::min(
  self : GraphsearchbidirectionalNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalNode::max(
  self : GraphsearchbidirectionalNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalNode::to_string(
  self : GraphsearchbidirectionalNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_edge_make(
  size : Int32,
) -> GraphsearchbidirectionalEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalEdge::len(
  self : GraphsearchbidirectionalEdge,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalEdge::get(
  self : GraphsearchbidirectionalEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalEdge::set(
  self : GraphsearchbidirectionalEdge,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalEdge::sum(
  self : GraphsearchbidirectionalEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalEdge::mean(
  self : GraphsearchbidirectionalEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalEdge::scale(
  self : GraphsearchbidirectionalEdge,
  f : Double,
) -> GraphsearchbidirectionalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalEdge::add(
  self : GraphsearchbidirectionalEdge,
  other : GraphsearchbidirectionalEdge,
) -> GraphsearchbidirectionalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalEdge::copy(
  self : GraphsearchbidirectionalEdge,
) -> GraphsearchbidirectionalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalEdge::fill(
  self : GraphsearchbidirectionalEdge,
  v : Double,
) -> GraphsearchbidirectionalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalEdge::min(
  self : GraphsearchbidirectionalEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalEdge::max(
  self : GraphsearchbidirectionalEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalEdge::to_string(
  self : GraphsearchbidirectionalEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_path_make(
  size : Int32,
) -> GraphsearchbidirectionalPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalPath::len(
  self : GraphsearchbidirectionalPath,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalPath::get(
  self : GraphsearchbidirectionalPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalPath::set(
  self : GraphsearchbidirectionalPath,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalPath::sum(
  self : GraphsearchbidirectionalPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalPath::mean(
  self : GraphsearchbidirectionalPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalPath::scale(
  self : GraphsearchbidirectionalPath,
  f : Double,
) -> GraphsearchbidirectionalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalPath::add(
  self : GraphsearchbidirectionalPath,
  other : GraphsearchbidirectionalPath,
) -> GraphsearchbidirectionalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalPath::copy(
  self : GraphsearchbidirectionalPath,
) -> GraphsearchbidirectionalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalPath::fill(
  self : GraphsearchbidirectionalPath,
  v : Double,
) -> GraphsearchbidirectionalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalPath::min(
  self : GraphsearchbidirectionalPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalPath::max(
  self : GraphsearchbidirectionalPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalPath::to_string(
  self : GraphsearchbidirectionalPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_cluster_make(
  size : Int32,
) -> GraphsearchbidirectionalCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalCluster::len(
  self : GraphsearchbidirectionalCluster,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalCluster::get(
  self : GraphsearchbidirectionalCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalCluster::set(
  self : GraphsearchbidirectionalCluster,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalCluster::sum(
  self : GraphsearchbidirectionalCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalCluster::mean(
  self : GraphsearchbidirectionalCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalCluster::scale(
  self : GraphsearchbidirectionalCluster,
  f : Double,
) -> GraphsearchbidirectionalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalCluster::add(
  self : GraphsearchbidirectionalCluster,
  other : GraphsearchbidirectionalCluster,
) -> GraphsearchbidirectionalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalCluster::copy(
  self : GraphsearchbidirectionalCluster,
) -> GraphsearchbidirectionalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalCluster::fill(
  self : GraphsearchbidirectionalCluster,
  v : Double,
) -> GraphsearchbidirectionalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalCluster::min(
  self : GraphsearchbidirectionalCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalCluster::max(
  self : GraphsearchbidirectionalCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalCluster::to_string(
  self : GraphsearchbidirectionalCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_model_make(
  size : Int32,
) -> GraphsearchbidirectionalModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalModel::len(
  self : GraphsearchbidirectionalModel,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalModel::get(
  self : GraphsearchbidirectionalModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalModel::set(
  self : GraphsearchbidirectionalModel,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalModel::sum(
  self : GraphsearchbidirectionalModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalModel::mean(
  self : GraphsearchbidirectionalModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalModel::scale(
  self : GraphsearchbidirectionalModel,
  f : Double,
) -> GraphsearchbidirectionalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalModel::add(
  self : GraphsearchbidirectionalModel,
  other : GraphsearchbidirectionalModel,
) -> GraphsearchbidirectionalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalModel::copy(
  self : GraphsearchbidirectionalModel,
) -> GraphsearchbidirectionalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalModel::fill(
  self : GraphsearchbidirectionalModel,
  v : Double,
) -> GraphsearchbidirectionalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalModel::min(
  self : GraphsearchbidirectionalModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalModel::max(
  self : GraphsearchbidirectionalModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalModel::to_string(
  self : GraphsearchbidirectionalModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_layer_make(
  size : Int32,
) -> GraphsearchbidirectionalLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalLayer::len(
  self : GraphsearchbidirectionalLayer,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalLayer::get(
  self : GraphsearchbidirectionalLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalLayer::set(
  self : GraphsearchbidirectionalLayer,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalLayer::sum(
  self : GraphsearchbidirectionalLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalLayer::mean(
  self : GraphsearchbidirectionalLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalLayer::scale(
  self : GraphsearchbidirectionalLayer,
  f : Double,
) -> GraphsearchbidirectionalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalLayer::add(
  self : GraphsearchbidirectionalLayer,
  other : GraphsearchbidirectionalLayer,
) -> GraphsearchbidirectionalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalLayer::copy(
  self : GraphsearchbidirectionalLayer,
) -> GraphsearchbidirectionalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalLayer::fill(
  self : GraphsearchbidirectionalLayer,
  v : Double,
) -> GraphsearchbidirectionalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalLayer::min(
  self : GraphsearchbidirectionalLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalLayer::max(
  self : GraphsearchbidirectionalLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalLayer::to_string(
  self : GraphsearchbidirectionalLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_buffer_make(
  size : Int32,
) -> GraphsearchbidirectionalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalBuffer::len(
  self : GraphsearchbidirectionalBuffer,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalBuffer::get(
  self : GraphsearchbidirectionalBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalBuffer::set(
  self : GraphsearchbidirectionalBuffer,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalBuffer::sum(
  self : GraphsearchbidirectionalBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalBuffer::mean(
  self : GraphsearchbidirectionalBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalBuffer::scale(
  self : GraphsearchbidirectionalBuffer,
  f : Double,
) -> GraphsearchbidirectionalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalBuffer::add(
  self : GraphsearchbidirectionalBuffer,
  other : GraphsearchbidirectionalBuffer,
) -> GraphsearchbidirectionalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalBuffer::copy(
  self : GraphsearchbidirectionalBuffer,
) -> GraphsearchbidirectionalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalBuffer::fill(
  self : GraphsearchbidirectionalBuffer,
  v : Double,
) -> GraphsearchbidirectionalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalBuffer::min(
  self : GraphsearchbidirectionalBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalBuffer::max(
  self : GraphsearchbidirectionalBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalBuffer::to_string(
  self : GraphsearchbidirectionalBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_cursor_make(
  size : Int32,
) -> GraphsearchbidirectionalCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalCursor::len(
  self : GraphsearchbidirectionalCursor,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalCursor::get(
  self : GraphsearchbidirectionalCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalCursor::set(
  self : GraphsearchbidirectionalCursor,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalCursor::sum(
  self : GraphsearchbidirectionalCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalCursor::mean(
  self : GraphsearchbidirectionalCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalCursor::scale(
  self : GraphsearchbidirectionalCursor,
  f : Double,
) -> GraphsearchbidirectionalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalCursor::add(
  self : GraphsearchbidirectionalCursor,
  other : GraphsearchbidirectionalCursor,
) -> GraphsearchbidirectionalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalCursor::copy(
  self : GraphsearchbidirectionalCursor,
) -> GraphsearchbidirectionalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalCursor::fill(
  self : GraphsearchbidirectionalCursor,
  v : Double,
) -> GraphsearchbidirectionalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalCursor::min(
  self : GraphsearchbidirectionalCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalCursor::max(
  self : GraphsearchbidirectionalCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalCursor::to_string(
  self : GraphsearchbidirectionalCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_view_make(
  size : Int32,
) -> GraphsearchbidirectionalView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalView::len(
  self : GraphsearchbidirectionalView,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalView::get(
  self : GraphsearchbidirectionalView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalView::set(
  self : GraphsearchbidirectionalView,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalView::sum(
  self : GraphsearchbidirectionalView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalView::mean(
  self : GraphsearchbidirectionalView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalView::scale(
  self : GraphsearchbidirectionalView,
  f : Double,
) -> GraphsearchbidirectionalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalView::add(
  self : GraphsearchbidirectionalView,
  other : GraphsearchbidirectionalView,
) -> GraphsearchbidirectionalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalView::copy(
  self : GraphsearchbidirectionalView,
) -> GraphsearchbidirectionalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalView::fill(
  self : GraphsearchbidirectionalView,
  v : Double,
) -> GraphsearchbidirectionalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalView::min(
  self : GraphsearchbidirectionalView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalView::max(
  self : GraphsearchbidirectionalView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalView::to_string(
  self : GraphsearchbidirectionalView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_range_make(
  size : Int32,
) -> GraphsearchbidirectionalRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalRange::len(
  self : GraphsearchbidirectionalRange,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalRange::get(
  self : GraphsearchbidirectionalRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalRange::set(
  self : GraphsearchbidirectionalRange,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalRange::sum(
  self : GraphsearchbidirectionalRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalRange::mean(
  self : GraphsearchbidirectionalRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalRange::scale(
  self : GraphsearchbidirectionalRange,
  f : Double,
) -> GraphsearchbidirectionalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalRange::add(
  self : GraphsearchbidirectionalRange,
  other : GraphsearchbidirectionalRange,
) -> GraphsearchbidirectionalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalRange::copy(
  self : GraphsearchbidirectionalRange,
) -> GraphsearchbidirectionalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalRange::fill(
  self : GraphsearchbidirectionalRange,
  v : Double,
) -> GraphsearchbidirectionalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalRange::min(
  self : GraphsearchbidirectionalRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalRange::max(
  self : GraphsearchbidirectionalRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalRange::to_string(
  self : GraphsearchbidirectionalRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchbidirectionalSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_bidirectional_slice_make(
  size : Int32,
) -> GraphsearchbidirectionalSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchbidirectionalSlice::len(
  self : GraphsearchbidirectionalSlice,
) -> Int32 {
  self.size
}

///|
pub fn GraphsearchbidirectionalSlice::get(
  self : GraphsearchbidirectionalSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchbidirectionalSlice::set(
  self : GraphsearchbidirectionalSlice,
  i : Int32,
  v : Double,
) -> GraphsearchbidirectionalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalSlice::sum(
  self : GraphsearchbidirectionalSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchbidirectionalSlice::mean(
  self : GraphsearchbidirectionalSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchbidirectionalSlice::scale(
  self : GraphsearchbidirectionalSlice,
  f : Double,
) -> GraphsearchbidirectionalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalSlice::add(
  self : GraphsearchbidirectionalSlice,
  other : GraphsearchbidirectionalSlice,
) -> GraphsearchbidirectionalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalSlice::copy(
  self : GraphsearchbidirectionalSlice,
) -> GraphsearchbidirectionalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalSlice::fill(
  self : GraphsearchbidirectionalSlice,
  v : Double,
) -> GraphsearchbidirectionalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchbidirectionalSlice::min(
  self : GraphsearchbidirectionalSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchbidirectionalSlice::max(
  self : GraphsearchbidirectionalSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchbidirectionalSlice::to_string(
  self : GraphsearchbidirectionalSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
