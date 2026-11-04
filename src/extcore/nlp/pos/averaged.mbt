///|
///===
/// extcore/nlp_pos_averaged
pub(all) struct NlpposaveragedPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn nlp_pos_averaged_make_point(
  x : Double,
  y : Double,
) -> NlpposaveragedPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn nlp_pos_averaged_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NlpposaveragedPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NlpposaveragedPoint::x(self : NlpposaveragedPoint) -> Double {
  self.x
}

///|
pub fn NlpposaveragedPoint::y(self : NlpposaveragedPoint) -> Double {
  self.y
}

///|
pub fn NlpposaveragedPoint::z(self : NlpposaveragedPoint) -> Double {
  self.z
}

///|
pub fn NlpposaveragedPoint::label(self : NlpposaveragedPoint) -> Int32 {
  self.label
}

///|
pub fn NlpposaveragedPoint::dist(
  self : NlpposaveragedPoint,
  other : NlpposaveragedPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NlpposaveragedPoint::add(
  self : NlpposaveragedPoint,
  other : NlpposaveragedPoint,
) -> NlpposaveragedPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NlpposaveragedPoint::sub(
  self : NlpposaveragedPoint,
  other : NlpposaveragedPoint,
) -> NlpposaveragedPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NlpposaveragedPoint::scale(
  self : NlpposaveragedPoint,
  s : Double,
) -> NlpposaveragedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NlpposaveragedPoint::dot(
  self : NlpposaveragedPoint,
  other : NlpposaveragedPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NlpposaveragedPoint::cross(
  self : NlpposaveragedPoint,
  other : NlpposaveragedPoint,
) -> NlpposaveragedPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NlpposaveragedPoint::norm(self : NlpposaveragedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NlpposaveragedPoint::normalize(
  self : NlpposaveragedPoint,
) -> NlpposaveragedPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NlpposaveragedPoint::negate(
  self : NlpposaveragedPoint,
) -> NlpposaveragedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NlpposaveragedPoint::mid(
  self : NlpposaveragedPoint,
  other : NlpposaveragedPoint,
) -> NlpposaveragedPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NlpposaveragedPoint::lerp(
  self : NlpposaveragedPoint,
  other : NlpposaveragedPoint,
  t : Double,
) -> NlpposaveragedPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NlpposaveragedPoint::to_string(self : NlpposaveragedPoint) -> String {
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
pub(all) struct NlpposaveragedSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn nlp_pos_averaged_make_series(
  vals : Array[Double],
  name : String,
) -> NlpposaveragedSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NlpposaveragedSeries::len(self : NlpposaveragedSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NlpposaveragedSeries::sum(self : NlpposaveragedSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NlpposaveragedSeries::mean(self : NlpposaveragedSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NlpposaveragedSeries::min(self : NlpposaveragedSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NlpposaveragedSeries::max(self : NlpposaveragedSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NlpposaveragedSeries::range(self : NlpposaveragedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NlpposaveragedSeries::variance(self : NlpposaveragedSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NlpposaveragedSeries::std(self : NlpposaveragedSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NlpposaveragedSeries::median(self : NlpposaveragedSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NlpposaveragedSeries::scale(
  self : NlpposaveragedSeries,
  f : Double,
) -> NlpposaveragedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NlpposaveragedSeries::add(
  self : NlpposaveragedSeries,
  other : NlpposaveragedSeries,
) -> NlpposaveragedSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NlpposaveragedSeries::sub(
  self : NlpposaveragedSeries,
  other : NlpposaveragedSeries,
) -> NlpposaveragedSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NlpposaveragedSeries::normalize(
  self : NlpposaveragedSeries,
) -> NlpposaveragedSeries {
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
pub fn NlpposaveragedSeries::cumsum(
  self : NlpposaveragedSeries,
) -> NlpposaveragedSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NlpposaveragedSeries::to_string(self : NlpposaveragedSeries) -> String {
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
pub(all) struct NlpposaveragedMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn nlp_pos_averaged_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NlpposaveragedMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn nlp_pos_averaged_matrix_identity(n : Int32) -> NlpposaveragedMatrix {
  let m = nlp_pos_averaged_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NlpposaveragedMatrix::get(
  self : NlpposaveragedMatrix,
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
pub fn NlpposaveragedMatrix::transpose(
  self : NlpposaveragedMatrix,
) -> NlpposaveragedMatrix {
  let result = nlp_pos_averaged_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NlpposaveragedMatrix::add(
  self : NlpposaveragedMatrix,
  other : NlpposaveragedMatrix,
) -> NlpposaveragedMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = nlp_pos_averaged_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NlpposaveragedMatrix::scale(
  self : NlpposaveragedMatrix,
  s : Double,
) -> NlpposaveragedMatrix {
  let result = nlp_pos_averaged_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NlpposaveragedMatrix::multiply(
  self : NlpposaveragedMatrix,
  other : NlpposaveragedMatrix,
) -> NlpposaveragedMatrix {
  if self.cols != other.rows {
    return nlp_pos_averaged_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = nlp_pos_averaged_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NlpposaveragedMatrix::trace(self : NlpposaveragedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NlpposaveragedMatrix::det(self : NlpposaveragedMatrix) -> Double {
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
pub fn NlpposaveragedMatrix::norm(self : NlpposaveragedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NlpposaveragedMatrix::to_string(self : NlpposaveragedMatrix) -> String {
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
pub(all) struct NlpposaveragedVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn nlp_pos_averaged_make_vector(
  comps : Array[Double],
) -> NlpposaveragedVector {
  { comps, dim: comps.length(), }
}

///|
pub fn nlp_pos_averaged_vector_zero(dim : Int32) -> NlpposaveragedVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NlpposaveragedVector::add(
  self : NlpposaveragedVector,
  other : NlpposaveragedVector,
) -> NlpposaveragedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NlpposaveragedVector::sub(
  self : NlpposaveragedVector,
  other : NlpposaveragedVector,
) -> NlpposaveragedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NlpposaveragedVector::scale(
  self : NlpposaveragedVector,
  s : Double,
) -> NlpposaveragedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NlpposaveragedVector::dot(
  self : NlpposaveragedVector,
  other : NlpposaveragedVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NlpposaveragedVector::norm(self : NlpposaveragedVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NlpposaveragedVector::normalize(
  self : NlpposaveragedVector,
) -> NlpposaveragedVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NlpposaveragedVector::dist(
  self : NlpposaveragedVector,
  other : NlpposaveragedVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NlpposaveragedVector::to_string(self : NlpposaveragedVector) -> String {
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
pub(all) struct NlpposaveragedFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_frame_make(size : Int32) -> NlpposaveragedFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedFrame::len(self : NlpposaveragedFrame) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedFrame::get(
  self : NlpposaveragedFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedFrame::set(
  self : NlpposaveragedFrame,
  i : Int32,
  v : Double,
) -> NlpposaveragedFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedFrame::sum(self : NlpposaveragedFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedFrame::mean(self : NlpposaveragedFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedFrame::scale(
  self : NlpposaveragedFrame,
  f : Double,
) -> NlpposaveragedFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedFrame::add(
  self : NlpposaveragedFrame,
  other : NlpposaveragedFrame,
) -> NlpposaveragedFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedFrame::copy(
  self : NlpposaveragedFrame,
) -> NlpposaveragedFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedFrame::fill(
  self : NlpposaveragedFrame,
  v : Double,
) -> NlpposaveragedFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedFrame::min(self : NlpposaveragedFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedFrame::max(self : NlpposaveragedFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedFrame::to_string(self : NlpposaveragedFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_table_make(size : Int32) -> NlpposaveragedTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedTable::len(self : NlpposaveragedTable) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedTable::get(
  self : NlpposaveragedTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedTable::set(
  self : NlpposaveragedTable,
  i : Int32,
  v : Double,
) -> NlpposaveragedTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedTable::sum(self : NlpposaveragedTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedTable::mean(self : NlpposaveragedTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedTable::scale(
  self : NlpposaveragedTable,
  f : Double,
) -> NlpposaveragedTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedTable::add(
  self : NlpposaveragedTable,
  other : NlpposaveragedTable,
) -> NlpposaveragedTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedTable::copy(
  self : NlpposaveragedTable,
) -> NlpposaveragedTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedTable::fill(
  self : NlpposaveragedTable,
  v : Double,
) -> NlpposaveragedTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedTable::min(self : NlpposaveragedTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedTable::max(self : NlpposaveragedTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedTable::to_string(self : NlpposaveragedTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_graphn_make(size : Int32) -> NlpposaveragedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedGraphN::len(self : NlpposaveragedGraphN) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedGraphN::get(
  self : NlpposaveragedGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedGraphN::set(
  self : NlpposaveragedGraphN,
  i : Int32,
  v : Double,
) -> NlpposaveragedGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedGraphN::sum(self : NlpposaveragedGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedGraphN::mean(self : NlpposaveragedGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedGraphN::scale(
  self : NlpposaveragedGraphN,
  f : Double,
) -> NlpposaveragedGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedGraphN::add(
  self : NlpposaveragedGraphN,
  other : NlpposaveragedGraphN,
) -> NlpposaveragedGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedGraphN::copy(
  self : NlpposaveragedGraphN,
) -> NlpposaveragedGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedGraphN::fill(
  self : NlpposaveragedGraphN,
  v : Double,
) -> NlpposaveragedGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedGraphN::min(self : NlpposaveragedGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedGraphN::max(self : NlpposaveragedGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedGraphN::to_string(self : NlpposaveragedGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_node_make(size : Int32) -> NlpposaveragedNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedNode::len(self : NlpposaveragedNode) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedNode::get(self : NlpposaveragedNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedNode::set(
  self : NlpposaveragedNode,
  i : Int32,
  v : Double,
) -> NlpposaveragedNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedNode::sum(self : NlpposaveragedNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedNode::mean(self : NlpposaveragedNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedNode::scale(
  self : NlpposaveragedNode,
  f : Double,
) -> NlpposaveragedNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedNode::add(
  self : NlpposaveragedNode,
  other : NlpposaveragedNode,
) -> NlpposaveragedNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedNode::copy(
  self : NlpposaveragedNode,
) -> NlpposaveragedNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedNode::fill(
  self : NlpposaveragedNode,
  v : Double,
) -> NlpposaveragedNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedNode::min(self : NlpposaveragedNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedNode::max(self : NlpposaveragedNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedNode::to_string(self : NlpposaveragedNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_edge_make(size : Int32) -> NlpposaveragedEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedEdge::len(self : NlpposaveragedEdge) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedEdge::get(self : NlpposaveragedEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedEdge::set(
  self : NlpposaveragedEdge,
  i : Int32,
  v : Double,
) -> NlpposaveragedEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedEdge::sum(self : NlpposaveragedEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedEdge::mean(self : NlpposaveragedEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedEdge::scale(
  self : NlpposaveragedEdge,
  f : Double,
) -> NlpposaveragedEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedEdge::add(
  self : NlpposaveragedEdge,
  other : NlpposaveragedEdge,
) -> NlpposaveragedEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedEdge::copy(
  self : NlpposaveragedEdge,
) -> NlpposaveragedEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedEdge::fill(
  self : NlpposaveragedEdge,
  v : Double,
) -> NlpposaveragedEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedEdge::min(self : NlpposaveragedEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedEdge::max(self : NlpposaveragedEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedEdge::to_string(self : NlpposaveragedEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_path_make(size : Int32) -> NlpposaveragedPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedPath::len(self : NlpposaveragedPath) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedPath::get(self : NlpposaveragedPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedPath::set(
  self : NlpposaveragedPath,
  i : Int32,
  v : Double,
) -> NlpposaveragedPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedPath::sum(self : NlpposaveragedPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedPath::mean(self : NlpposaveragedPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedPath::scale(
  self : NlpposaveragedPath,
  f : Double,
) -> NlpposaveragedPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedPath::add(
  self : NlpposaveragedPath,
  other : NlpposaveragedPath,
) -> NlpposaveragedPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedPath::copy(
  self : NlpposaveragedPath,
) -> NlpposaveragedPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedPath::fill(
  self : NlpposaveragedPath,
  v : Double,
) -> NlpposaveragedPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedPath::min(self : NlpposaveragedPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedPath::max(self : NlpposaveragedPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedPath::to_string(self : NlpposaveragedPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_cluster_make(size : Int32) -> NlpposaveragedCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedCluster::len(self : NlpposaveragedCluster) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedCluster::get(
  self : NlpposaveragedCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedCluster::set(
  self : NlpposaveragedCluster,
  i : Int32,
  v : Double,
) -> NlpposaveragedCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedCluster::sum(self : NlpposaveragedCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedCluster::mean(self : NlpposaveragedCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedCluster::scale(
  self : NlpposaveragedCluster,
  f : Double,
) -> NlpposaveragedCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedCluster::add(
  self : NlpposaveragedCluster,
  other : NlpposaveragedCluster,
) -> NlpposaveragedCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedCluster::copy(
  self : NlpposaveragedCluster,
) -> NlpposaveragedCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedCluster::fill(
  self : NlpposaveragedCluster,
  v : Double,
) -> NlpposaveragedCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedCluster::min(self : NlpposaveragedCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedCluster::max(self : NlpposaveragedCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedCluster::to_string(self : NlpposaveragedCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_model_make(size : Int32) -> NlpposaveragedModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedModel::len(self : NlpposaveragedModel) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedModel::get(
  self : NlpposaveragedModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedModel::set(
  self : NlpposaveragedModel,
  i : Int32,
  v : Double,
) -> NlpposaveragedModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedModel::sum(self : NlpposaveragedModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedModel::mean(self : NlpposaveragedModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedModel::scale(
  self : NlpposaveragedModel,
  f : Double,
) -> NlpposaveragedModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedModel::add(
  self : NlpposaveragedModel,
  other : NlpposaveragedModel,
) -> NlpposaveragedModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedModel::copy(
  self : NlpposaveragedModel,
) -> NlpposaveragedModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedModel::fill(
  self : NlpposaveragedModel,
  v : Double,
) -> NlpposaveragedModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedModel::min(self : NlpposaveragedModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedModel::max(self : NlpposaveragedModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedModel::to_string(self : NlpposaveragedModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_layer_make(size : Int32) -> NlpposaveragedLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedLayer::len(self : NlpposaveragedLayer) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedLayer::get(
  self : NlpposaveragedLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedLayer::set(
  self : NlpposaveragedLayer,
  i : Int32,
  v : Double,
) -> NlpposaveragedLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedLayer::sum(self : NlpposaveragedLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedLayer::mean(self : NlpposaveragedLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedLayer::scale(
  self : NlpposaveragedLayer,
  f : Double,
) -> NlpposaveragedLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedLayer::add(
  self : NlpposaveragedLayer,
  other : NlpposaveragedLayer,
) -> NlpposaveragedLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedLayer::copy(
  self : NlpposaveragedLayer,
) -> NlpposaveragedLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedLayer::fill(
  self : NlpposaveragedLayer,
  v : Double,
) -> NlpposaveragedLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedLayer::min(self : NlpposaveragedLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedLayer::max(self : NlpposaveragedLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedLayer::to_string(self : NlpposaveragedLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_buffer_make(size : Int32) -> NlpposaveragedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedBuffer::len(self : NlpposaveragedBuffer) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedBuffer::get(
  self : NlpposaveragedBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedBuffer::set(
  self : NlpposaveragedBuffer,
  i : Int32,
  v : Double,
) -> NlpposaveragedBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedBuffer::sum(self : NlpposaveragedBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedBuffer::mean(self : NlpposaveragedBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedBuffer::scale(
  self : NlpposaveragedBuffer,
  f : Double,
) -> NlpposaveragedBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedBuffer::add(
  self : NlpposaveragedBuffer,
  other : NlpposaveragedBuffer,
) -> NlpposaveragedBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedBuffer::copy(
  self : NlpposaveragedBuffer,
) -> NlpposaveragedBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedBuffer::fill(
  self : NlpposaveragedBuffer,
  v : Double,
) -> NlpposaveragedBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedBuffer::min(self : NlpposaveragedBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedBuffer::max(self : NlpposaveragedBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedBuffer::to_string(self : NlpposaveragedBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_cursor_make(size : Int32) -> NlpposaveragedCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedCursor::len(self : NlpposaveragedCursor) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedCursor::get(
  self : NlpposaveragedCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedCursor::set(
  self : NlpposaveragedCursor,
  i : Int32,
  v : Double,
) -> NlpposaveragedCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedCursor::sum(self : NlpposaveragedCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedCursor::mean(self : NlpposaveragedCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedCursor::scale(
  self : NlpposaveragedCursor,
  f : Double,
) -> NlpposaveragedCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedCursor::add(
  self : NlpposaveragedCursor,
  other : NlpposaveragedCursor,
) -> NlpposaveragedCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedCursor::copy(
  self : NlpposaveragedCursor,
) -> NlpposaveragedCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedCursor::fill(
  self : NlpposaveragedCursor,
  v : Double,
) -> NlpposaveragedCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedCursor::min(self : NlpposaveragedCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedCursor::max(self : NlpposaveragedCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedCursor::to_string(self : NlpposaveragedCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_view_make(size : Int32) -> NlpposaveragedView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedView::len(self : NlpposaveragedView) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedView::get(self : NlpposaveragedView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedView::set(
  self : NlpposaveragedView,
  i : Int32,
  v : Double,
) -> NlpposaveragedView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedView::sum(self : NlpposaveragedView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedView::mean(self : NlpposaveragedView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedView::scale(
  self : NlpposaveragedView,
  f : Double,
) -> NlpposaveragedView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedView::add(
  self : NlpposaveragedView,
  other : NlpposaveragedView,
) -> NlpposaveragedView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedView::copy(
  self : NlpposaveragedView,
) -> NlpposaveragedView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedView::fill(
  self : NlpposaveragedView,
  v : Double,
) -> NlpposaveragedView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedView::min(self : NlpposaveragedView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedView::max(self : NlpposaveragedView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedView::to_string(self : NlpposaveragedView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_range_make(size : Int32) -> NlpposaveragedRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedRange::len(self : NlpposaveragedRange) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedRange::get(
  self : NlpposaveragedRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedRange::set(
  self : NlpposaveragedRange,
  i : Int32,
  v : Double,
) -> NlpposaveragedRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedRange::sum(self : NlpposaveragedRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedRange::mean(self : NlpposaveragedRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedRange::scale(
  self : NlpposaveragedRange,
  f : Double,
) -> NlpposaveragedRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedRange::add(
  self : NlpposaveragedRange,
  other : NlpposaveragedRange,
) -> NlpposaveragedRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedRange::copy(
  self : NlpposaveragedRange,
) -> NlpposaveragedRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedRange::fill(
  self : NlpposaveragedRange,
  v : Double,
) -> NlpposaveragedRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedRange::min(self : NlpposaveragedRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedRange::max(self : NlpposaveragedRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedRange::to_string(self : NlpposaveragedRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpposaveragedSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_pos_averaged_slice_make(size : Int32) -> NlpposaveragedSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpposaveragedSlice::len(self : NlpposaveragedSlice) -> Int32 {
  self.size
}

///|
pub fn NlpposaveragedSlice::get(
  self : NlpposaveragedSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpposaveragedSlice::set(
  self : NlpposaveragedSlice,
  i : Int32,
  v : Double,
) -> NlpposaveragedSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedSlice::sum(self : NlpposaveragedSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpposaveragedSlice::mean(self : NlpposaveragedSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpposaveragedSlice::scale(
  self : NlpposaveragedSlice,
  f : Double,
) -> NlpposaveragedSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedSlice::add(
  self : NlpposaveragedSlice,
  other : NlpposaveragedSlice,
) -> NlpposaveragedSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpposaveragedSlice::copy(
  self : NlpposaveragedSlice,
) -> NlpposaveragedSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedSlice::fill(
  self : NlpposaveragedSlice,
  v : Double,
) -> NlpposaveragedSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpposaveragedSlice::min(self : NlpposaveragedSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpposaveragedSlice::max(self : NlpposaveragedSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpposaveragedSlice::to_string(self : NlpposaveragedSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
