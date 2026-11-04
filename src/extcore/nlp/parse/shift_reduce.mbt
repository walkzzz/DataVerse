///|
///===
/// extcore/nlp_parse_shift_reduce
pub(all) struct NlpparseshiftreducePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn nlp_parse_shift_reduce_make_point(
  x : Double,
  y : Double,
) -> NlpparseshiftreducePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn nlp_parse_shift_reduce_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NlpparseshiftreducePoint {
  { x, y, z, label: 0, }
}

///|
pub fn NlpparseshiftreducePoint::x(self : NlpparseshiftreducePoint) -> Double {
  self.x
}

///|
pub fn NlpparseshiftreducePoint::y(self : NlpparseshiftreducePoint) -> Double {
  self.y
}

///|
pub fn NlpparseshiftreducePoint::z(self : NlpparseshiftreducePoint) -> Double {
  self.z
}

///|
pub fn NlpparseshiftreducePoint::label(
  self : NlpparseshiftreducePoint,
) -> Int32 {
  self.label
}

///|
pub fn NlpparseshiftreducePoint::dist(
  self : NlpparseshiftreducePoint,
  other : NlpparseshiftreducePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NlpparseshiftreducePoint::add(
  self : NlpparseshiftreducePoint,
  other : NlpparseshiftreducePoint,
) -> NlpparseshiftreducePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NlpparseshiftreducePoint::sub(
  self : NlpparseshiftreducePoint,
  other : NlpparseshiftreducePoint,
) -> NlpparseshiftreducePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NlpparseshiftreducePoint::scale(
  self : NlpparseshiftreducePoint,
  s : Double,
) -> NlpparseshiftreducePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NlpparseshiftreducePoint::dot(
  self : NlpparseshiftreducePoint,
  other : NlpparseshiftreducePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NlpparseshiftreducePoint::cross(
  self : NlpparseshiftreducePoint,
  other : NlpparseshiftreducePoint,
) -> NlpparseshiftreducePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NlpparseshiftreducePoint::norm(
  self : NlpparseshiftreducePoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NlpparseshiftreducePoint::normalize(
  self : NlpparseshiftreducePoint,
) -> NlpparseshiftreducePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NlpparseshiftreducePoint::negate(
  self : NlpparseshiftreducePoint,
) -> NlpparseshiftreducePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NlpparseshiftreducePoint::mid(
  self : NlpparseshiftreducePoint,
  other : NlpparseshiftreducePoint,
) -> NlpparseshiftreducePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NlpparseshiftreducePoint::lerp(
  self : NlpparseshiftreducePoint,
  other : NlpparseshiftreducePoint,
  t : Double,
) -> NlpparseshiftreducePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NlpparseshiftreducePoint::to_string(
  self : NlpparseshiftreducePoint,
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
pub(all) struct NlpparseshiftreduceSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn nlp_parse_shift_reduce_make_series(
  vals : Array[Double],
  name : String,
) -> NlpparseshiftreduceSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NlpparseshiftreduceSeries::len(
  self : NlpparseshiftreduceSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn NlpparseshiftreduceSeries::sum(
  self : NlpparseshiftreduceSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NlpparseshiftreduceSeries::mean(
  self : NlpparseshiftreduceSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NlpparseshiftreduceSeries::min(
  self : NlpparseshiftreduceSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NlpparseshiftreduceSeries::max(
  self : NlpparseshiftreduceSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NlpparseshiftreduceSeries::range(
  self : NlpparseshiftreduceSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NlpparseshiftreduceSeries::variance(
  self : NlpparseshiftreduceSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NlpparseshiftreduceSeries::std(
  self : NlpparseshiftreduceSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NlpparseshiftreduceSeries::median(
  self : NlpparseshiftreduceSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NlpparseshiftreduceSeries::scale(
  self : NlpparseshiftreduceSeries,
  f : Double,
) -> NlpparseshiftreduceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NlpparseshiftreduceSeries::add(
  self : NlpparseshiftreduceSeries,
  other : NlpparseshiftreduceSeries,
) -> NlpparseshiftreduceSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NlpparseshiftreduceSeries::sub(
  self : NlpparseshiftreduceSeries,
  other : NlpparseshiftreduceSeries,
) -> NlpparseshiftreduceSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NlpparseshiftreduceSeries::normalize(
  self : NlpparseshiftreduceSeries,
) -> NlpparseshiftreduceSeries {
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
pub fn NlpparseshiftreduceSeries::cumsum(
  self : NlpparseshiftreduceSeries,
) -> NlpparseshiftreduceSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NlpparseshiftreduceSeries::to_string(
  self : NlpparseshiftreduceSeries,
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
pub(all) struct NlpparseshiftreduceMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn nlp_parse_shift_reduce_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NlpparseshiftreduceMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn nlp_parse_shift_reduce_matrix_identity(
  n : Int32,
) -> NlpparseshiftreduceMatrix {
  let m = nlp_parse_shift_reduce_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NlpparseshiftreduceMatrix::get(
  self : NlpparseshiftreduceMatrix,
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
pub fn NlpparseshiftreduceMatrix::transpose(
  self : NlpparseshiftreduceMatrix,
) -> NlpparseshiftreduceMatrix {
  let result = nlp_parse_shift_reduce_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NlpparseshiftreduceMatrix::add(
  self : NlpparseshiftreduceMatrix,
  other : NlpparseshiftreduceMatrix,
) -> NlpparseshiftreduceMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = nlp_parse_shift_reduce_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NlpparseshiftreduceMatrix::scale(
  self : NlpparseshiftreduceMatrix,
  s : Double,
) -> NlpparseshiftreduceMatrix {
  let result = nlp_parse_shift_reduce_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NlpparseshiftreduceMatrix::multiply(
  self : NlpparseshiftreduceMatrix,
  other : NlpparseshiftreduceMatrix,
) -> NlpparseshiftreduceMatrix {
  if self.cols != other.rows {
    return nlp_parse_shift_reduce_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = nlp_parse_shift_reduce_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NlpparseshiftreduceMatrix::trace(
  self : NlpparseshiftreduceMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NlpparseshiftreduceMatrix::det(
  self : NlpparseshiftreduceMatrix,
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
pub fn NlpparseshiftreduceMatrix::norm(
  self : NlpparseshiftreduceMatrix,
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
pub fn NlpparseshiftreduceMatrix::to_string(
  self : NlpparseshiftreduceMatrix,
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
pub(all) struct NlpparseshiftreduceVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn nlp_parse_shift_reduce_make_vector(
  comps : Array[Double],
) -> NlpparseshiftreduceVector {
  { comps, dim: comps.length(), }
}

///|
pub fn nlp_parse_shift_reduce_vector_zero(
  dim : Int32,
) -> NlpparseshiftreduceVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NlpparseshiftreduceVector::add(
  self : NlpparseshiftreduceVector,
  other : NlpparseshiftreduceVector,
) -> NlpparseshiftreduceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NlpparseshiftreduceVector::sub(
  self : NlpparseshiftreduceVector,
  other : NlpparseshiftreduceVector,
) -> NlpparseshiftreduceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NlpparseshiftreduceVector::scale(
  self : NlpparseshiftreduceVector,
  s : Double,
) -> NlpparseshiftreduceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NlpparseshiftreduceVector::dot(
  self : NlpparseshiftreduceVector,
  other : NlpparseshiftreduceVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NlpparseshiftreduceVector::norm(
  self : NlpparseshiftreduceVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NlpparseshiftreduceVector::normalize(
  self : NlpparseshiftreduceVector,
) -> NlpparseshiftreduceVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NlpparseshiftreduceVector::dist(
  self : NlpparseshiftreduceVector,
  other : NlpparseshiftreduceVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NlpparseshiftreduceVector::to_string(
  self : NlpparseshiftreduceVector,
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
pub(all) struct NlpparseshiftreduceFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_frame_make(
  size : Int32,
) -> NlpparseshiftreduceFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceFrame::len(self : NlpparseshiftreduceFrame) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceFrame::get(
  self : NlpparseshiftreduceFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceFrame::set(
  self : NlpparseshiftreduceFrame,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceFrame::sum(self : NlpparseshiftreduceFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceFrame::mean(
  self : NlpparseshiftreduceFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceFrame::scale(
  self : NlpparseshiftreduceFrame,
  f : Double,
) -> NlpparseshiftreduceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceFrame::add(
  self : NlpparseshiftreduceFrame,
  other : NlpparseshiftreduceFrame,
) -> NlpparseshiftreduceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceFrame::copy(
  self : NlpparseshiftreduceFrame,
) -> NlpparseshiftreduceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceFrame::fill(
  self : NlpparseshiftreduceFrame,
  v : Double,
) -> NlpparseshiftreduceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceFrame::min(self : NlpparseshiftreduceFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceFrame::max(self : NlpparseshiftreduceFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceFrame::to_string(
  self : NlpparseshiftreduceFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_table_make(
  size : Int32,
) -> NlpparseshiftreduceTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceTable::len(self : NlpparseshiftreduceTable) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceTable::get(
  self : NlpparseshiftreduceTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceTable::set(
  self : NlpparseshiftreduceTable,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceTable::sum(self : NlpparseshiftreduceTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceTable::mean(
  self : NlpparseshiftreduceTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceTable::scale(
  self : NlpparseshiftreduceTable,
  f : Double,
) -> NlpparseshiftreduceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceTable::add(
  self : NlpparseshiftreduceTable,
  other : NlpparseshiftreduceTable,
) -> NlpparseshiftreduceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceTable::copy(
  self : NlpparseshiftreduceTable,
) -> NlpparseshiftreduceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceTable::fill(
  self : NlpparseshiftreduceTable,
  v : Double,
) -> NlpparseshiftreduceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceTable::min(self : NlpparseshiftreduceTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceTable::max(self : NlpparseshiftreduceTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceTable::to_string(
  self : NlpparseshiftreduceTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_graphn_make(
  size : Int32,
) -> NlpparseshiftreduceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceGraphN::len(
  self : NlpparseshiftreduceGraphN,
) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceGraphN::get(
  self : NlpparseshiftreduceGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceGraphN::set(
  self : NlpparseshiftreduceGraphN,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceGraphN::sum(
  self : NlpparseshiftreduceGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceGraphN::mean(
  self : NlpparseshiftreduceGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceGraphN::scale(
  self : NlpparseshiftreduceGraphN,
  f : Double,
) -> NlpparseshiftreduceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceGraphN::add(
  self : NlpparseshiftreduceGraphN,
  other : NlpparseshiftreduceGraphN,
) -> NlpparseshiftreduceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceGraphN::copy(
  self : NlpparseshiftreduceGraphN,
) -> NlpparseshiftreduceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceGraphN::fill(
  self : NlpparseshiftreduceGraphN,
  v : Double,
) -> NlpparseshiftreduceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceGraphN::min(
  self : NlpparseshiftreduceGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceGraphN::max(
  self : NlpparseshiftreduceGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceGraphN::to_string(
  self : NlpparseshiftreduceGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_node_make(
  size : Int32,
) -> NlpparseshiftreduceNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceNode::len(self : NlpparseshiftreduceNode) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceNode::get(
  self : NlpparseshiftreduceNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceNode::set(
  self : NlpparseshiftreduceNode,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceNode::sum(self : NlpparseshiftreduceNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceNode::mean(self : NlpparseshiftreduceNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceNode::scale(
  self : NlpparseshiftreduceNode,
  f : Double,
) -> NlpparseshiftreduceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceNode::add(
  self : NlpparseshiftreduceNode,
  other : NlpparseshiftreduceNode,
) -> NlpparseshiftreduceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceNode::copy(
  self : NlpparseshiftreduceNode,
) -> NlpparseshiftreduceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceNode::fill(
  self : NlpparseshiftreduceNode,
  v : Double,
) -> NlpparseshiftreduceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceNode::min(self : NlpparseshiftreduceNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceNode::max(self : NlpparseshiftreduceNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceNode::to_string(
  self : NlpparseshiftreduceNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_edge_make(
  size : Int32,
) -> NlpparseshiftreduceEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceEdge::len(self : NlpparseshiftreduceEdge) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceEdge::get(
  self : NlpparseshiftreduceEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceEdge::set(
  self : NlpparseshiftreduceEdge,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceEdge::sum(self : NlpparseshiftreduceEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceEdge::mean(self : NlpparseshiftreduceEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceEdge::scale(
  self : NlpparseshiftreduceEdge,
  f : Double,
) -> NlpparseshiftreduceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceEdge::add(
  self : NlpparseshiftreduceEdge,
  other : NlpparseshiftreduceEdge,
) -> NlpparseshiftreduceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceEdge::copy(
  self : NlpparseshiftreduceEdge,
) -> NlpparseshiftreduceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceEdge::fill(
  self : NlpparseshiftreduceEdge,
  v : Double,
) -> NlpparseshiftreduceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceEdge::min(self : NlpparseshiftreduceEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceEdge::max(self : NlpparseshiftreduceEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceEdge::to_string(
  self : NlpparseshiftreduceEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreducePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_path_make(
  size : Int32,
) -> NlpparseshiftreducePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreducePath::len(self : NlpparseshiftreducePath) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreducePath::get(
  self : NlpparseshiftreducePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreducePath::set(
  self : NlpparseshiftreducePath,
  i : Int32,
  v : Double,
) -> NlpparseshiftreducePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreducePath::sum(self : NlpparseshiftreducePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreducePath::mean(self : NlpparseshiftreducePath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreducePath::scale(
  self : NlpparseshiftreducePath,
  f : Double,
) -> NlpparseshiftreducePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreducePath::add(
  self : NlpparseshiftreducePath,
  other : NlpparseshiftreducePath,
) -> NlpparseshiftreducePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreducePath::copy(
  self : NlpparseshiftreducePath,
) -> NlpparseshiftreducePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreducePath::fill(
  self : NlpparseshiftreducePath,
  v : Double,
) -> NlpparseshiftreducePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreducePath::min(self : NlpparseshiftreducePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreducePath::max(self : NlpparseshiftreducePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreducePath::to_string(
  self : NlpparseshiftreducePath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_cluster_make(
  size : Int32,
) -> NlpparseshiftreduceCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceCluster::len(
  self : NlpparseshiftreduceCluster,
) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceCluster::get(
  self : NlpparseshiftreduceCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceCluster::set(
  self : NlpparseshiftreduceCluster,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceCluster::sum(
  self : NlpparseshiftreduceCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceCluster::mean(
  self : NlpparseshiftreduceCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceCluster::scale(
  self : NlpparseshiftreduceCluster,
  f : Double,
) -> NlpparseshiftreduceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceCluster::add(
  self : NlpparseshiftreduceCluster,
  other : NlpparseshiftreduceCluster,
) -> NlpparseshiftreduceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceCluster::copy(
  self : NlpparseshiftreduceCluster,
) -> NlpparseshiftreduceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceCluster::fill(
  self : NlpparseshiftreduceCluster,
  v : Double,
) -> NlpparseshiftreduceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceCluster::min(
  self : NlpparseshiftreduceCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceCluster::max(
  self : NlpparseshiftreduceCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceCluster::to_string(
  self : NlpparseshiftreduceCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_model_make(
  size : Int32,
) -> NlpparseshiftreduceModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceModel::len(self : NlpparseshiftreduceModel) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceModel::get(
  self : NlpparseshiftreduceModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceModel::set(
  self : NlpparseshiftreduceModel,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceModel::sum(self : NlpparseshiftreduceModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceModel::mean(
  self : NlpparseshiftreduceModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceModel::scale(
  self : NlpparseshiftreduceModel,
  f : Double,
) -> NlpparseshiftreduceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceModel::add(
  self : NlpparseshiftreduceModel,
  other : NlpparseshiftreduceModel,
) -> NlpparseshiftreduceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceModel::copy(
  self : NlpparseshiftreduceModel,
) -> NlpparseshiftreduceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceModel::fill(
  self : NlpparseshiftreduceModel,
  v : Double,
) -> NlpparseshiftreduceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceModel::min(self : NlpparseshiftreduceModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceModel::max(self : NlpparseshiftreduceModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceModel::to_string(
  self : NlpparseshiftreduceModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_layer_make(
  size : Int32,
) -> NlpparseshiftreduceLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceLayer::len(self : NlpparseshiftreduceLayer) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceLayer::get(
  self : NlpparseshiftreduceLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceLayer::set(
  self : NlpparseshiftreduceLayer,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceLayer::sum(self : NlpparseshiftreduceLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceLayer::mean(
  self : NlpparseshiftreduceLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceLayer::scale(
  self : NlpparseshiftreduceLayer,
  f : Double,
) -> NlpparseshiftreduceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceLayer::add(
  self : NlpparseshiftreduceLayer,
  other : NlpparseshiftreduceLayer,
) -> NlpparseshiftreduceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceLayer::copy(
  self : NlpparseshiftreduceLayer,
) -> NlpparseshiftreduceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceLayer::fill(
  self : NlpparseshiftreduceLayer,
  v : Double,
) -> NlpparseshiftreduceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceLayer::min(self : NlpparseshiftreduceLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceLayer::max(self : NlpparseshiftreduceLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceLayer::to_string(
  self : NlpparseshiftreduceLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_buffer_make(
  size : Int32,
) -> NlpparseshiftreduceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceBuffer::len(
  self : NlpparseshiftreduceBuffer,
) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceBuffer::get(
  self : NlpparseshiftreduceBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceBuffer::set(
  self : NlpparseshiftreduceBuffer,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceBuffer::sum(
  self : NlpparseshiftreduceBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceBuffer::mean(
  self : NlpparseshiftreduceBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceBuffer::scale(
  self : NlpparseshiftreduceBuffer,
  f : Double,
) -> NlpparseshiftreduceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceBuffer::add(
  self : NlpparseshiftreduceBuffer,
  other : NlpparseshiftreduceBuffer,
) -> NlpparseshiftreduceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceBuffer::copy(
  self : NlpparseshiftreduceBuffer,
) -> NlpparseshiftreduceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceBuffer::fill(
  self : NlpparseshiftreduceBuffer,
  v : Double,
) -> NlpparseshiftreduceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceBuffer::min(
  self : NlpparseshiftreduceBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceBuffer::max(
  self : NlpparseshiftreduceBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceBuffer::to_string(
  self : NlpparseshiftreduceBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_cursor_make(
  size : Int32,
) -> NlpparseshiftreduceCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceCursor::len(
  self : NlpparseshiftreduceCursor,
) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceCursor::get(
  self : NlpparseshiftreduceCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceCursor::set(
  self : NlpparseshiftreduceCursor,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceCursor::sum(
  self : NlpparseshiftreduceCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceCursor::mean(
  self : NlpparseshiftreduceCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceCursor::scale(
  self : NlpparseshiftreduceCursor,
  f : Double,
) -> NlpparseshiftreduceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceCursor::add(
  self : NlpparseshiftreduceCursor,
  other : NlpparseshiftreduceCursor,
) -> NlpparseshiftreduceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceCursor::copy(
  self : NlpparseshiftreduceCursor,
) -> NlpparseshiftreduceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceCursor::fill(
  self : NlpparseshiftreduceCursor,
  v : Double,
) -> NlpparseshiftreduceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceCursor::min(
  self : NlpparseshiftreduceCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceCursor::max(
  self : NlpparseshiftreduceCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceCursor::to_string(
  self : NlpparseshiftreduceCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_view_make(
  size : Int32,
) -> NlpparseshiftreduceView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceView::len(self : NlpparseshiftreduceView) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceView::get(
  self : NlpparseshiftreduceView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceView::set(
  self : NlpparseshiftreduceView,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceView::sum(self : NlpparseshiftreduceView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceView::mean(self : NlpparseshiftreduceView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceView::scale(
  self : NlpparseshiftreduceView,
  f : Double,
) -> NlpparseshiftreduceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceView::add(
  self : NlpparseshiftreduceView,
  other : NlpparseshiftreduceView,
) -> NlpparseshiftreduceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceView::copy(
  self : NlpparseshiftreduceView,
) -> NlpparseshiftreduceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceView::fill(
  self : NlpparseshiftreduceView,
  v : Double,
) -> NlpparseshiftreduceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceView::min(self : NlpparseshiftreduceView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceView::max(self : NlpparseshiftreduceView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceView::to_string(
  self : NlpparseshiftreduceView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_range_make(
  size : Int32,
) -> NlpparseshiftreduceRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceRange::len(self : NlpparseshiftreduceRange) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceRange::get(
  self : NlpparseshiftreduceRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceRange::set(
  self : NlpparseshiftreduceRange,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceRange::sum(self : NlpparseshiftreduceRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceRange::mean(
  self : NlpparseshiftreduceRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceRange::scale(
  self : NlpparseshiftreduceRange,
  f : Double,
) -> NlpparseshiftreduceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceRange::add(
  self : NlpparseshiftreduceRange,
  other : NlpparseshiftreduceRange,
) -> NlpparseshiftreduceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceRange::copy(
  self : NlpparseshiftreduceRange,
) -> NlpparseshiftreduceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceRange::fill(
  self : NlpparseshiftreduceRange,
  v : Double,
) -> NlpparseshiftreduceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceRange::min(self : NlpparseshiftreduceRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceRange::max(self : NlpparseshiftreduceRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceRange::to_string(
  self : NlpparseshiftreduceRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseshiftreduceSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_shift_reduce_slice_make(
  size : Int32,
) -> NlpparseshiftreduceSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseshiftreduceSlice::len(self : NlpparseshiftreduceSlice) -> Int32 {
  self.size
}

///|
pub fn NlpparseshiftreduceSlice::get(
  self : NlpparseshiftreduceSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseshiftreduceSlice::set(
  self : NlpparseshiftreduceSlice,
  i : Int32,
  v : Double,
) -> NlpparseshiftreduceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceSlice::sum(self : NlpparseshiftreduceSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseshiftreduceSlice::mean(
  self : NlpparseshiftreduceSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseshiftreduceSlice::scale(
  self : NlpparseshiftreduceSlice,
  f : Double,
) -> NlpparseshiftreduceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceSlice::add(
  self : NlpparseshiftreduceSlice,
  other : NlpparseshiftreduceSlice,
) -> NlpparseshiftreduceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceSlice::copy(
  self : NlpparseshiftreduceSlice,
) -> NlpparseshiftreduceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceSlice::fill(
  self : NlpparseshiftreduceSlice,
  v : Double,
) -> NlpparseshiftreduceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseshiftreduceSlice::min(self : NlpparseshiftreduceSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseshiftreduceSlice::max(self : NlpparseshiftreduceSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseshiftreduceSlice::to_string(
  self : NlpparseshiftreduceSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
