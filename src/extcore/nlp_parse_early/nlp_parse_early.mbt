///|
///===
/// extcore/nlp_parse_early
pub(all) struct NlpparseearlyPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn nlp_parse_early_make_point(x : Double, y : Double) -> NlpparseearlyPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn nlp_parse_early_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NlpparseearlyPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NlpparseearlyPoint::x(self : NlpparseearlyPoint) -> Double {
  self.x
}

///|
pub fn NlpparseearlyPoint::y(self : NlpparseearlyPoint) -> Double {
  self.y
}

///|
pub fn NlpparseearlyPoint::z(self : NlpparseearlyPoint) -> Double {
  self.z
}

///|
pub fn NlpparseearlyPoint::label(self : NlpparseearlyPoint) -> Int32 {
  self.label
}

///|
pub fn NlpparseearlyPoint::dist(
  self : NlpparseearlyPoint,
  other : NlpparseearlyPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NlpparseearlyPoint::add(
  self : NlpparseearlyPoint,
  other : NlpparseearlyPoint,
) -> NlpparseearlyPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NlpparseearlyPoint::sub(
  self : NlpparseearlyPoint,
  other : NlpparseearlyPoint,
) -> NlpparseearlyPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NlpparseearlyPoint::scale(
  self : NlpparseearlyPoint,
  s : Double,
) -> NlpparseearlyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NlpparseearlyPoint::dot(
  self : NlpparseearlyPoint,
  other : NlpparseearlyPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NlpparseearlyPoint::cross(
  self : NlpparseearlyPoint,
  other : NlpparseearlyPoint,
) -> NlpparseearlyPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NlpparseearlyPoint::norm(self : NlpparseearlyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NlpparseearlyPoint::normalize(
  self : NlpparseearlyPoint,
) -> NlpparseearlyPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NlpparseearlyPoint::negate(
  self : NlpparseearlyPoint,
) -> NlpparseearlyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NlpparseearlyPoint::mid(
  self : NlpparseearlyPoint,
  other : NlpparseearlyPoint,
) -> NlpparseearlyPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NlpparseearlyPoint::lerp(
  self : NlpparseearlyPoint,
  other : NlpparseearlyPoint,
  t : Double,
) -> NlpparseearlyPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NlpparseearlyPoint::to_string(self : NlpparseearlyPoint) -> String {
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
pub(all) struct NlpparseearlySeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn nlp_parse_early_make_series(
  vals : Array[Double],
  name : String,
) -> NlpparseearlySeries {
  { vals, name, meta: 0, }
}

///|
pub fn NlpparseearlySeries::len(self : NlpparseearlySeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NlpparseearlySeries::sum(self : NlpparseearlySeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NlpparseearlySeries::mean(self : NlpparseearlySeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NlpparseearlySeries::min(self : NlpparseearlySeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NlpparseearlySeries::max(self : NlpparseearlySeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NlpparseearlySeries::range(self : NlpparseearlySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NlpparseearlySeries::variance(self : NlpparseearlySeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NlpparseearlySeries::std(self : NlpparseearlySeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NlpparseearlySeries::median(self : NlpparseearlySeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NlpparseearlySeries::scale(
  self : NlpparseearlySeries,
  f : Double,
) -> NlpparseearlySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NlpparseearlySeries::add(
  self : NlpparseearlySeries,
  other : NlpparseearlySeries,
) -> NlpparseearlySeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NlpparseearlySeries::sub(
  self : NlpparseearlySeries,
  other : NlpparseearlySeries,
) -> NlpparseearlySeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NlpparseearlySeries::normalize(
  self : NlpparseearlySeries,
) -> NlpparseearlySeries {
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
pub fn NlpparseearlySeries::cumsum(
  self : NlpparseearlySeries,
) -> NlpparseearlySeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NlpparseearlySeries::to_string(self : NlpparseearlySeries) -> String {
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
pub(all) struct NlpparseearlyMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn nlp_parse_early_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NlpparseearlyMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn nlp_parse_early_matrix_identity(n : Int32) -> NlpparseearlyMatrix {
  let m = nlp_parse_early_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NlpparseearlyMatrix::get(
  self : NlpparseearlyMatrix,
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
pub fn NlpparseearlyMatrix::transpose(
  self : NlpparseearlyMatrix,
) -> NlpparseearlyMatrix {
  let result = nlp_parse_early_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NlpparseearlyMatrix::add(
  self : NlpparseearlyMatrix,
  other : NlpparseearlyMatrix,
) -> NlpparseearlyMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = nlp_parse_early_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NlpparseearlyMatrix::scale(
  self : NlpparseearlyMatrix,
  s : Double,
) -> NlpparseearlyMatrix {
  let result = nlp_parse_early_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NlpparseearlyMatrix::multiply(
  self : NlpparseearlyMatrix,
  other : NlpparseearlyMatrix,
) -> NlpparseearlyMatrix {
  if self.cols != other.rows {
    return nlp_parse_early_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = nlp_parse_early_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NlpparseearlyMatrix::trace(self : NlpparseearlyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NlpparseearlyMatrix::det(self : NlpparseearlyMatrix) -> Double {
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
pub fn NlpparseearlyMatrix::norm(self : NlpparseearlyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NlpparseearlyMatrix::to_string(self : NlpparseearlyMatrix) -> String {
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
pub(all) struct NlpparseearlyVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn nlp_parse_early_make_vector(
  comps : Array[Double],
) -> NlpparseearlyVector {
  { comps, dim: comps.length(), }
}

///|
pub fn nlp_parse_early_vector_zero(dim : Int32) -> NlpparseearlyVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NlpparseearlyVector::add(
  self : NlpparseearlyVector,
  other : NlpparseearlyVector,
) -> NlpparseearlyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NlpparseearlyVector::sub(
  self : NlpparseearlyVector,
  other : NlpparseearlyVector,
) -> NlpparseearlyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NlpparseearlyVector::scale(
  self : NlpparseearlyVector,
  s : Double,
) -> NlpparseearlyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NlpparseearlyVector::dot(
  self : NlpparseearlyVector,
  other : NlpparseearlyVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NlpparseearlyVector::norm(self : NlpparseearlyVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NlpparseearlyVector::normalize(
  self : NlpparseearlyVector,
) -> NlpparseearlyVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NlpparseearlyVector::dist(
  self : NlpparseearlyVector,
  other : NlpparseearlyVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NlpparseearlyVector::to_string(self : NlpparseearlyVector) -> String {
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
pub(all) struct NlpparseearlyFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_frame_make(size : Int32) -> NlpparseearlyFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyFrame::len(self : NlpparseearlyFrame) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyFrame::get(self : NlpparseearlyFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyFrame::set(
  self : NlpparseearlyFrame,
  i : Int32,
  v : Double,
) -> NlpparseearlyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyFrame::sum(self : NlpparseearlyFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyFrame::mean(self : NlpparseearlyFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyFrame::scale(
  self : NlpparseearlyFrame,
  f : Double,
) -> NlpparseearlyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyFrame::add(
  self : NlpparseearlyFrame,
  other : NlpparseearlyFrame,
) -> NlpparseearlyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyFrame::copy(
  self : NlpparseearlyFrame,
) -> NlpparseearlyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyFrame::fill(
  self : NlpparseearlyFrame,
  v : Double,
) -> NlpparseearlyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyFrame::min(self : NlpparseearlyFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyFrame::max(self : NlpparseearlyFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyFrame::to_string(self : NlpparseearlyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_table_make(size : Int32) -> NlpparseearlyTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyTable::len(self : NlpparseearlyTable) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyTable::get(self : NlpparseearlyTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyTable::set(
  self : NlpparseearlyTable,
  i : Int32,
  v : Double,
) -> NlpparseearlyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyTable::sum(self : NlpparseearlyTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyTable::mean(self : NlpparseearlyTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyTable::scale(
  self : NlpparseearlyTable,
  f : Double,
) -> NlpparseearlyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyTable::add(
  self : NlpparseearlyTable,
  other : NlpparseearlyTable,
) -> NlpparseearlyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyTable::copy(
  self : NlpparseearlyTable,
) -> NlpparseearlyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyTable::fill(
  self : NlpparseearlyTable,
  v : Double,
) -> NlpparseearlyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyTable::min(self : NlpparseearlyTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyTable::max(self : NlpparseearlyTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyTable::to_string(self : NlpparseearlyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_graphn_make(size : Int32) -> NlpparseearlyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyGraphN::len(self : NlpparseearlyGraphN) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyGraphN::get(
  self : NlpparseearlyGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyGraphN::set(
  self : NlpparseearlyGraphN,
  i : Int32,
  v : Double,
) -> NlpparseearlyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyGraphN::sum(self : NlpparseearlyGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyGraphN::mean(self : NlpparseearlyGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyGraphN::scale(
  self : NlpparseearlyGraphN,
  f : Double,
) -> NlpparseearlyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyGraphN::add(
  self : NlpparseearlyGraphN,
  other : NlpparseearlyGraphN,
) -> NlpparseearlyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyGraphN::copy(
  self : NlpparseearlyGraphN,
) -> NlpparseearlyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyGraphN::fill(
  self : NlpparseearlyGraphN,
  v : Double,
) -> NlpparseearlyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyGraphN::min(self : NlpparseearlyGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyGraphN::max(self : NlpparseearlyGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyGraphN::to_string(self : NlpparseearlyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_node_make(size : Int32) -> NlpparseearlyNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyNode::len(self : NlpparseearlyNode) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyNode::get(self : NlpparseearlyNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyNode::set(
  self : NlpparseearlyNode,
  i : Int32,
  v : Double,
) -> NlpparseearlyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyNode::sum(self : NlpparseearlyNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyNode::mean(self : NlpparseearlyNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyNode::scale(
  self : NlpparseearlyNode,
  f : Double,
) -> NlpparseearlyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyNode::add(
  self : NlpparseearlyNode,
  other : NlpparseearlyNode,
) -> NlpparseearlyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyNode::copy(self : NlpparseearlyNode) -> NlpparseearlyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyNode::fill(
  self : NlpparseearlyNode,
  v : Double,
) -> NlpparseearlyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyNode::min(self : NlpparseearlyNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyNode::max(self : NlpparseearlyNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyNode::to_string(self : NlpparseearlyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_edge_make(size : Int32) -> NlpparseearlyEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyEdge::len(self : NlpparseearlyEdge) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyEdge::get(self : NlpparseearlyEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyEdge::set(
  self : NlpparseearlyEdge,
  i : Int32,
  v : Double,
) -> NlpparseearlyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyEdge::sum(self : NlpparseearlyEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyEdge::mean(self : NlpparseearlyEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyEdge::scale(
  self : NlpparseearlyEdge,
  f : Double,
) -> NlpparseearlyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyEdge::add(
  self : NlpparseearlyEdge,
  other : NlpparseearlyEdge,
) -> NlpparseearlyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyEdge::copy(self : NlpparseearlyEdge) -> NlpparseearlyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyEdge::fill(
  self : NlpparseearlyEdge,
  v : Double,
) -> NlpparseearlyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyEdge::min(self : NlpparseearlyEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyEdge::max(self : NlpparseearlyEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyEdge::to_string(self : NlpparseearlyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_path_make(size : Int32) -> NlpparseearlyPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyPath::len(self : NlpparseearlyPath) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyPath::get(self : NlpparseearlyPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyPath::set(
  self : NlpparseearlyPath,
  i : Int32,
  v : Double,
) -> NlpparseearlyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyPath::sum(self : NlpparseearlyPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyPath::mean(self : NlpparseearlyPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyPath::scale(
  self : NlpparseearlyPath,
  f : Double,
) -> NlpparseearlyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyPath::add(
  self : NlpparseearlyPath,
  other : NlpparseearlyPath,
) -> NlpparseearlyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyPath::copy(self : NlpparseearlyPath) -> NlpparseearlyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyPath::fill(
  self : NlpparseearlyPath,
  v : Double,
) -> NlpparseearlyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyPath::min(self : NlpparseearlyPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyPath::max(self : NlpparseearlyPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyPath::to_string(self : NlpparseearlyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_cluster_make(size : Int32) -> NlpparseearlyCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyCluster::len(self : NlpparseearlyCluster) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyCluster::get(
  self : NlpparseearlyCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyCluster::set(
  self : NlpparseearlyCluster,
  i : Int32,
  v : Double,
) -> NlpparseearlyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyCluster::sum(self : NlpparseearlyCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyCluster::mean(self : NlpparseearlyCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyCluster::scale(
  self : NlpparseearlyCluster,
  f : Double,
) -> NlpparseearlyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyCluster::add(
  self : NlpparseearlyCluster,
  other : NlpparseearlyCluster,
) -> NlpparseearlyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyCluster::copy(
  self : NlpparseearlyCluster,
) -> NlpparseearlyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyCluster::fill(
  self : NlpparseearlyCluster,
  v : Double,
) -> NlpparseearlyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyCluster::min(self : NlpparseearlyCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyCluster::max(self : NlpparseearlyCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyCluster::to_string(self : NlpparseearlyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_model_make(size : Int32) -> NlpparseearlyModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyModel::len(self : NlpparseearlyModel) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyModel::get(self : NlpparseearlyModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyModel::set(
  self : NlpparseearlyModel,
  i : Int32,
  v : Double,
) -> NlpparseearlyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyModel::sum(self : NlpparseearlyModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyModel::mean(self : NlpparseearlyModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyModel::scale(
  self : NlpparseearlyModel,
  f : Double,
) -> NlpparseearlyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyModel::add(
  self : NlpparseearlyModel,
  other : NlpparseearlyModel,
) -> NlpparseearlyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyModel::copy(
  self : NlpparseearlyModel,
) -> NlpparseearlyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyModel::fill(
  self : NlpparseearlyModel,
  v : Double,
) -> NlpparseearlyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyModel::min(self : NlpparseearlyModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyModel::max(self : NlpparseearlyModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyModel::to_string(self : NlpparseearlyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_layer_make(size : Int32) -> NlpparseearlyLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyLayer::len(self : NlpparseearlyLayer) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyLayer::get(self : NlpparseearlyLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyLayer::set(
  self : NlpparseearlyLayer,
  i : Int32,
  v : Double,
) -> NlpparseearlyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyLayer::sum(self : NlpparseearlyLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyLayer::mean(self : NlpparseearlyLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyLayer::scale(
  self : NlpparseearlyLayer,
  f : Double,
) -> NlpparseearlyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyLayer::add(
  self : NlpparseearlyLayer,
  other : NlpparseearlyLayer,
) -> NlpparseearlyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyLayer::copy(
  self : NlpparseearlyLayer,
) -> NlpparseearlyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyLayer::fill(
  self : NlpparseearlyLayer,
  v : Double,
) -> NlpparseearlyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyLayer::min(self : NlpparseearlyLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyLayer::max(self : NlpparseearlyLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyLayer::to_string(self : NlpparseearlyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_buffer_make(size : Int32) -> NlpparseearlyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyBuffer::len(self : NlpparseearlyBuffer) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyBuffer::get(
  self : NlpparseearlyBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyBuffer::set(
  self : NlpparseearlyBuffer,
  i : Int32,
  v : Double,
) -> NlpparseearlyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyBuffer::sum(self : NlpparseearlyBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyBuffer::mean(self : NlpparseearlyBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyBuffer::scale(
  self : NlpparseearlyBuffer,
  f : Double,
) -> NlpparseearlyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyBuffer::add(
  self : NlpparseearlyBuffer,
  other : NlpparseearlyBuffer,
) -> NlpparseearlyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyBuffer::copy(
  self : NlpparseearlyBuffer,
) -> NlpparseearlyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyBuffer::fill(
  self : NlpparseearlyBuffer,
  v : Double,
) -> NlpparseearlyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyBuffer::min(self : NlpparseearlyBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyBuffer::max(self : NlpparseearlyBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyBuffer::to_string(self : NlpparseearlyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_cursor_make(size : Int32) -> NlpparseearlyCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyCursor::len(self : NlpparseearlyCursor) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyCursor::get(
  self : NlpparseearlyCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyCursor::set(
  self : NlpparseearlyCursor,
  i : Int32,
  v : Double,
) -> NlpparseearlyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyCursor::sum(self : NlpparseearlyCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyCursor::mean(self : NlpparseearlyCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyCursor::scale(
  self : NlpparseearlyCursor,
  f : Double,
) -> NlpparseearlyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyCursor::add(
  self : NlpparseearlyCursor,
  other : NlpparseearlyCursor,
) -> NlpparseearlyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyCursor::copy(
  self : NlpparseearlyCursor,
) -> NlpparseearlyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyCursor::fill(
  self : NlpparseearlyCursor,
  v : Double,
) -> NlpparseearlyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyCursor::min(self : NlpparseearlyCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyCursor::max(self : NlpparseearlyCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyCursor::to_string(self : NlpparseearlyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_view_make(size : Int32) -> NlpparseearlyView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyView::len(self : NlpparseearlyView) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyView::get(self : NlpparseearlyView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyView::set(
  self : NlpparseearlyView,
  i : Int32,
  v : Double,
) -> NlpparseearlyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyView::sum(self : NlpparseearlyView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyView::mean(self : NlpparseearlyView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyView::scale(
  self : NlpparseearlyView,
  f : Double,
) -> NlpparseearlyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyView::add(
  self : NlpparseearlyView,
  other : NlpparseearlyView,
) -> NlpparseearlyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyView::copy(self : NlpparseearlyView) -> NlpparseearlyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyView::fill(
  self : NlpparseearlyView,
  v : Double,
) -> NlpparseearlyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyView::min(self : NlpparseearlyView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyView::max(self : NlpparseearlyView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyView::to_string(self : NlpparseearlyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlyRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_range_make(size : Int32) -> NlpparseearlyRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlyRange::len(self : NlpparseearlyRange) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlyRange::get(self : NlpparseearlyRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlyRange::set(
  self : NlpparseearlyRange,
  i : Int32,
  v : Double,
) -> NlpparseearlyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyRange::sum(self : NlpparseearlyRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlyRange::mean(self : NlpparseearlyRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlyRange::scale(
  self : NlpparseearlyRange,
  f : Double,
) -> NlpparseearlyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyRange::add(
  self : NlpparseearlyRange,
  other : NlpparseearlyRange,
) -> NlpparseearlyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlyRange::copy(
  self : NlpparseearlyRange,
) -> NlpparseearlyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyRange::fill(
  self : NlpparseearlyRange,
  v : Double,
) -> NlpparseearlyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlyRange::min(self : NlpparseearlyRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlyRange::max(self : NlpparseearlyRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlyRange::to_string(self : NlpparseearlyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseearlySlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_early_slice_make(size : Int32) -> NlpparseearlySlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseearlySlice::len(self : NlpparseearlySlice) -> Int32 {
  self.size
}

///|
pub fn NlpparseearlySlice::get(self : NlpparseearlySlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseearlySlice::set(
  self : NlpparseearlySlice,
  i : Int32,
  v : Double,
) -> NlpparseearlySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlySlice::sum(self : NlpparseearlySlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseearlySlice::mean(self : NlpparseearlySlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseearlySlice::scale(
  self : NlpparseearlySlice,
  f : Double,
) -> NlpparseearlySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlySlice::add(
  self : NlpparseearlySlice,
  other : NlpparseearlySlice,
) -> NlpparseearlySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseearlySlice::copy(
  self : NlpparseearlySlice,
) -> NlpparseearlySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlySlice::fill(
  self : NlpparseearlySlice,
  v : Double,
) -> NlpparseearlySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseearlySlice::min(self : NlpparseearlySlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseearlySlice::max(self : NlpparseearlySlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseearlySlice::to_string(self : NlpparseearlySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
