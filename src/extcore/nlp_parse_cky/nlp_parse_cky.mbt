///|
///===
/// extcore/nlp_parse_cky
pub(all) struct NlpparseckyPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn nlp_parse_cky_make_point(x : Double, y : Double) -> NlpparseckyPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn nlp_parse_cky_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NlpparseckyPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NlpparseckyPoint::x(self : NlpparseckyPoint) -> Double {
  self.x
}

///|
pub fn NlpparseckyPoint::y(self : NlpparseckyPoint) -> Double {
  self.y
}

///|
pub fn NlpparseckyPoint::z(self : NlpparseckyPoint) -> Double {
  self.z
}

///|
pub fn NlpparseckyPoint::label(self : NlpparseckyPoint) -> Int32 {
  self.label
}

///|
pub fn NlpparseckyPoint::dist(
  self : NlpparseckyPoint,
  other : NlpparseckyPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NlpparseckyPoint::add(
  self : NlpparseckyPoint,
  other : NlpparseckyPoint,
) -> NlpparseckyPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NlpparseckyPoint::sub(
  self : NlpparseckyPoint,
  other : NlpparseckyPoint,
) -> NlpparseckyPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NlpparseckyPoint::scale(
  self : NlpparseckyPoint,
  s : Double,
) -> NlpparseckyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NlpparseckyPoint::dot(
  self : NlpparseckyPoint,
  other : NlpparseckyPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NlpparseckyPoint::cross(
  self : NlpparseckyPoint,
  other : NlpparseckyPoint,
) -> NlpparseckyPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NlpparseckyPoint::norm(self : NlpparseckyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NlpparseckyPoint::normalize(self : NlpparseckyPoint) -> NlpparseckyPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NlpparseckyPoint::negate(self : NlpparseckyPoint) -> NlpparseckyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NlpparseckyPoint::mid(
  self : NlpparseckyPoint,
  other : NlpparseckyPoint,
) -> NlpparseckyPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NlpparseckyPoint::lerp(
  self : NlpparseckyPoint,
  other : NlpparseckyPoint,
  t : Double,
) -> NlpparseckyPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NlpparseckyPoint::to_string(self : NlpparseckyPoint) -> String {
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
pub(all) struct NlpparseckySeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn nlp_parse_cky_make_series(
  vals : Array[Double],
  name : String,
) -> NlpparseckySeries {
  { vals, name, meta: 0, }
}

///|
pub fn NlpparseckySeries::len(self : NlpparseckySeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NlpparseckySeries::sum(self : NlpparseckySeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NlpparseckySeries::mean(self : NlpparseckySeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NlpparseckySeries::min(self : NlpparseckySeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NlpparseckySeries::max(self : NlpparseckySeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NlpparseckySeries::range(self : NlpparseckySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NlpparseckySeries::variance(self : NlpparseckySeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NlpparseckySeries::std(self : NlpparseckySeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NlpparseckySeries::median(self : NlpparseckySeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NlpparseckySeries::scale(
  self : NlpparseckySeries,
  f : Double,
) -> NlpparseckySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NlpparseckySeries::add(
  self : NlpparseckySeries,
  other : NlpparseckySeries,
) -> NlpparseckySeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NlpparseckySeries::sub(
  self : NlpparseckySeries,
  other : NlpparseckySeries,
) -> NlpparseckySeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NlpparseckySeries::normalize(
  self : NlpparseckySeries,
) -> NlpparseckySeries {
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
pub fn NlpparseckySeries::cumsum(self : NlpparseckySeries) -> NlpparseckySeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NlpparseckySeries::to_string(self : NlpparseckySeries) -> String {
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
pub(all) struct NlpparseckyMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn nlp_parse_cky_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NlpparseckyMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn nlp_parse_cky_matrix_identity(n : Int32) -> NlpparseckyMatrix {
  let m = nlp_parse_cky_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NlpparseckyMatrix::get(
  self : NlpparseckyMatrix,
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
pub fn NlpparseckyMatrix::transpose(
  self : NlpparseckyMatrix,
) -> NlpparseckyMatrix {
  let result = nlp_parse_cky_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NlpparseckyMatrix::add(
  self : NlpparseckyMatrix,
  other : NlpparseckyMatrix,
) -> NlpparseckyMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = nlp_parse_cky_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NlpparseckyMatrix::scale(
  self : NlpparseckyMatrix,
  s : Double,
) -> NlpparseckyMatrix {
  let result = nlp_parse_cky_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NlpparseckyMatrix::multiply(
  self : NlpparseckyMatrix,
  other : NlpparseckyMatrix,
) -> NlpparseckyMatrix {
  if self.cols != other.rows {
    return nlp_parse_cky_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = nlp_parse_cky_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NlpparseckyMatrix::trace(self : NlpparseckyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NlpparseckyMatrix::det(self : NlpparseckyMatrix) -> Double {
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
pub fn NlpparseckyMatrix::norm(self : NlpparseckyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NlpparseckyMatrix::to_string(self : NlpparseckyMatrix) -> String {
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
pub(all) struct NlpparseckyVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn nlp_parse_cky_make_vector(comps : Array[Double]) -> NlpparseckyVector {
  { comps, dim: comps.length(), }
}

///|
pub fn nlp_parse_cky_vector_zero(dim : Int32) -> NlpparseckyVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NlpparseckyVector::add(
  self : NlpparseckyVector,
  other : NlpparseckyVector,
) -> NlpparseckyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NlpparseckyVector::sub(
  self : NlpparseckyVector,
  other : NlpparseckyVector,
) -> NlpparseckyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NlpparseckyVector::scale(
  self : NlpparseckyVector,
  s : Double,
) -> NlpparseckyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NlpparseckyVector::dot(
  self : NlpparseckyVector,
  other : NlpparseckyVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NlpparseckyVector::norm(self : NlpparseckyVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NlpparseckyVector::normalize(
  self : NlpparseckyVector,
) -> NlpparseckyVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NlpparseckyVector::dist(
  self : NlpparseckyVector,
  other : NlpparseckyVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NlpparseckyVector::to_string(self : NlpparseckyVector) -> String {
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
pub(all) struct NlpparseckyFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_frame_make(size : Int32) -> NlpparseckyFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyFrame::len(self : NlpparseckyFrame) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyFrame::get(self : NlpparseckyFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyFrame::set(
  self : NlpparseckyFrame,
  i : Int32,
  v : Double,
) -> NlpparseckyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyFrame::sum(self : NlpparseckyFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyFrame::mean(self : NlpparseckyFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyFrame::scale(
  self : NlpparseckyFrame,
  f : Double,
) -> NlpparseckyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyFrame::add(
  self : NlpparseckyFrame,
  other : NlpparseckyFrame,
) -> NlpparseckyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyFrame::copy(self : NlpparseckyFrame) -> NlpparseckyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyFrame::fill(
  self : NlpparseckyFrame,
  v : Double,
) -> NlpparseckyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyFrame::min(self : NlpparseckyFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyFrame::max(self : NlpparseckyFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyFrame::to_string(self : NlpparseckyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_table_make(size : Int32) -> NlpparseckyTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyTable::len(self : NlpparseckyTable) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyTable::get(self : NlpparseckyTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyTable::set(
  self : NlpparseckyTable,
  i : Int32,
  v : Double,
) -> NlpparseckyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyTable::sum(self : NlpparseckyTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyTable::mean(self : NlpparseckyTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyTable::scale(
  self : NlpparseckyTable,
  f : Double,
) -> NlpparseckyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyTable::add(
  self : NlpparseckyTable,
  other : NlpparseckyTable,
) -> NlpparseckyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyTable::copy(self : NlpparseckyTable) -> NlpparseckyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyTable::fill(
  self : NlpparseckyTable,
  v : Double,
) -> NlpparseckyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyTable::min(self : NlpparseckyTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyTable::max(self : NlpparseckyTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyTable::to_string(self : NlpparseckyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_graphn_make(size : Int32) -> NlpparseckyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyGraphN::len(self : NlpparseckyGraphN) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyGraphN::get(self : NlpparseckyGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyGraphN::set(
  self : NlpparseckyGraphN,
  i : Int32,
  v : Double,
) -> NlpparseckyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyGraphN::sum(self : NlpparseckyGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyGraphN::mean(self : NlpparseckyGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyGraphN::scale(
  self : NlpparseckyGraphN,
  f : Double,
) -> NlpparseckyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyGraphN::add(
  self : NlpparseckyGraphN,
  other : NlpparseckyGraphN,
) -> NlpparseckyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyGraphN::copy(self : NlpparseckyGraphN) -> NlpparseckyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyGraphN::fill(
  self : NlpparseckyGraphN,
  v : Double,
) -> NlpparseckyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyGraphN::min(self : NlpparseckyGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyGraphN::max(self : NlpparseckyGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyGraphN::to_string(self : NlpparseckyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_node_make(size : Int32) -> NlpparseckyNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyNode::len(self : NlpparseckyNode) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyNode::get(self : NlpparseckyNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyNode::set(
  self : NlpparseckyNode,
  i : Int32,
  v : Double,
) -> NlpparseckyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyNode::sum(self : NlpparseckyNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyNode::mean(self : NlpparseckyNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyNode::scale(
  self : NlpparseckyNode,
  f : Double,
) -> NlpparseckyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyNode::add(
  self : NlpparseckyNode,
  other : NlpparseckyNode,
) -> NlpparseckyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyNode::copy(self : NlpparseckyNode) -> NlpparseckyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyNode::fill(
  self : NlpparseckyNode,
  v : Double,
) -> NlpparseckyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyNode::min(self : NlpparseckyNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyNode::max(self : NlpparseckyNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyNode::to_string(self : NlpparseckyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_edge_make(size : Int32) -> NlpparseckyEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyEdge::len(self : NlpparseckyEdge) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyEdge::get(self : NlpparseckyEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyEdge::set(
  self : NlpparseckyEdge,
  i : Int32,
  v : Double,
) -> NlpparseckyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyEdge::sum(self : NlpparseckyEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyEdge::mean(self : NlpparseckyEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyEdge::scale(
  self : NlpparseckyEdge,
  f : Double,
) -> NlpparseckyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyEdge::add(
  self : NlpparseckyEdge,
  other : NlpparseckyEdge,
) -> NlpparseckyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyEdge::copy(self : NlpparseckyEdge) -> NlpparseckyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyEdge::fill(
  self : NlpparseckyEdge,
  v : Double,
) -> NlpparseckyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyEdge::min(self : NlpparseckyEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyEdge::max(self : NlpparseckyEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyEdge::to_string(self : NlpparseckyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_path_make(size : Int32) -> NlpparseckyPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyPath::len(self : NlpparseckyPath) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyPath::get(self : NlpparseckyPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyPath::set(
  self : NlpparseckyPath,
  i : Int32,
  v : Double,
) -> NlpparseckyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyPath::sum(self : NlpparseckyPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyPath::mean(self : NlpparseckyPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyPath::scale(
  self : NlpparseckyPath,
  f : Double,
) -> NlpparseckyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyPath::add(
  self : NlpparseckyPath,
  other : NlpparseckyPath,
) -> NlpparseckyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyPath::copy(self : NlpparseckyPath) -> NlpparseckyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyPath::fill(
  self : NlpparseckyPath,
  v : Double,
) -> NlpparseckyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyPath::min(self : NlpparseckyPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyPath::max(self : NlpparseckyPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyPath::to_string(self : NlpparseckyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_cluster_make(size : Int32) -> NlpparseckyCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyCluster::len(self : NlpparseckyCluster) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyCluster::get(self : NlpparseckyCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyCluster::set(
  self : NlpparseckyCluster,
  i : Int32,
  v : Double,
) -> NlpparseckyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyCluster::sum(self : NlpparseckyCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyCluster::mean(self : NlpparseckyCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyCluster::scale(
  self : NlpparseckyCluster,
  f : Double,
) -> NlpparseckyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyCluster::add(
  self : NlpparseckyCluster,
  other : NlpparseckyCluster,
) -> NlpparseckyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyCluster::copy(
  self : NlpparseckyCluster,
) -> NlpparseckyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyCluster::fill(
  self : NlpparseckyCluster,
  v : Double,
) -> NlpparseckyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyCluster::min(self : NlpparseckyCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyCluster::max(self : NlpparseckyCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyCluster::to_string(self : NlpparseckyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_model_make(size : Int32) -> NlpparseckyModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyModel::len(self : NlpparseckyModel) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyModel::get(self : NlpparseckyModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyModel::set(
  self : NlpparseckyModel,
  i : Int32,
  v : Double,
) -> NlpparseckyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyModel::sum(self : NlpparseckyModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyModel::mean(self : NlpparseckyModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyModel::scale(
  self : NlpparseckyModel,
  f : Double,
) -> NlpparseckyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyModel::add(
  self : NlpparseckyModel,
  other : NlpparseckyModel,
) -> NlpparseckyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyModel::copy(self : NlpparseckyModel) -> NlpparseckyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyModel::fill(
  self : NlpparseckyModel,
  v : Double,
) -> NlpparseckyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyModel::min(self : NlpparseckyModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyModel::max(self : NlpparseckyModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyModel::to_string(self : NlpparseckyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_layer_make(size : Int32) -> NlpparseckyLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyLayer::len(self : NlpparseckyLayer) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyLayer::get(self : NlpparseckyLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyLayer::set(
  self : NlpparseckyLayer,
  i : Int32,
  v : Double,
) -> NlpparseckyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyLayer::sum(self : NlpparseckyLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyLayer::mean(self : NlpparseckyLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyLayer::scale(
  self : NlpparseckyLayer,
  f : Double,
) -> NlpparseckyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyLayer::add(
  self : NlpparseckyLayer,
  other : NlpparseckyLayer,
) -> NlpparseckyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyLayer::copy(self : NlpparseckyLayer) -> NlpparseckyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyLayer::fill(
  self : NlpparseckyLayer,
  v : Double,
) -> NlpparseckyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyLayer::min(self : NlpparseckyLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyLayer::max(self : NlpparseckyLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyLayer::to_string(self : NlpparseckyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_buffer_make(size : Int32) -> NlpparseckyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyBuffer::len(self : NlpparseckyBuffer) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyBuffer::get(self : NlpparseckyBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyBuffer::set(
  self : NlpparseckyBuffer,
  i : Int32,
  v : Double,
) -> NlpparseckyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyBuffer::sum(self : NlpparseckyBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyBuffer::mean(self : NlpparseckyBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyBuffer::scale(
  self : NlpparseckyBuffer,
  f : Double,
) -> NlpparseckyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyBuffer::add(
  self : NlpparseckyBuffer,
  other : NlpparseckyBuffer,
) -> NlpparseckyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyBuffer::copy(self : NlpparseckyBuffer) -> NlpparseckyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyBuffer::fill(
  self : NlpparseckyBuffer,
  v : Double,
) -> NlpparseckyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyBuffer::min(self : NlpparseckyBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyBuffer::max(self : NlpparseckyBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyBuffer::to_string(self : NlpparseckyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_cursor_make(size : Int32) -> NlpparseckyCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyCursor::len(self : NlpparseckyCursor) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyCursor::get(self : NlpparseckyCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyCursor::set(
  self : NlpparseckyCursor,
  i : Int32,
  v : Double,
) -> NlpparseckyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyCursor::sum(self : NlpparseckyCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyCursor::mean(self : NlpparseckyCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyCursor::scale(
  self : NlpparseckyCursor,
  f : Double,
) -> NlpparseckyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyCursor::add(
  self : NlpparseckyCursor,
  other : NlpparseckyCursor,
) -> NlpparseckyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyCursor::copy(self : NlpparseckyCursor) -> NlpparseckyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyCursor::fill(
  self : NlpparseckyCursor,
  v : Double,
) -> NlpparseckyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyCursor::min(self : NlpparseckyCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyCursor::max(self : NlpparseckyCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyCursor::to_string(self : NlpparseckyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_view_make(size : Int32) -> NlpparseckyView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyView::len(self : NlpparseckyView) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyView::get(self : NlpparseckyView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyView::set(
  self : NlpparseckyView,
  i : Int32,
  v : Double,
) -> NlpparseckyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyView::sum(self : NlpparseckyView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyView::mean(self : NlpparseckyView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyView::scale(
  self : NlpparseckyView,
  f : Double,
) -> NlpparseckyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyView::add(
  self : NlpparseckyView,
  other : NlpparseckyView,
) -> NlpparseckyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyView::copy(self : NlpparseckyView) -> NlpparseckyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyView::fill(
  self : NlpparseckyView,
  v : Double,
) -> NlpparseckyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyView::min(self : NlpparseckyView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyView::max(self : NlpparseckyView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyView::to_string(self : NlpparseckyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckyRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_range_make(size : Int32) -> NlpparseckyRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckyRange::len(self : NlpparseckyRange) -> Int32 {
  self.size
}

///|
pub fn NlpparseckyRange::get(self : NlpparseckyRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckyRange::set(
  self : NlpparseckyRange,
  i : Int32,
  v : Double,
) -> NlpparseckyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyRange::sum(self : NlpparseckyRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckyRange::mean(self : NlpparseckyRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckyRange::scale(
  self : NlpparseckyRange,
  f : Double,
) -> NlpparseckyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyRange::add(
  self : NlpparseckyRange,
  other : NlpparseckyRange,
) -> NlpparseckyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckyRange::copy(self : NlpparseckyRange) -> NlpparseckyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyRange::fill(
  self : NlpparseckyRange,
  v : Double,
) -> NlpparseckyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckyRange::min(self : NlpparseckyRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckyRange::max(self : NlpparseckyRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckyRange::to_string(self : NlpparseckyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NlpparseckySlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn nlp_parse_cky_slice_make(size : Int32) -> NlpparseckySlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NlpparseckySlice::len(self : NlpparseckySlice) -> Int32 {
  self.size
}

///|
pub fn NlpparseckySlice::get(self : NlpparseckySlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NlpparseckySlice::set(
  self : NlpparseckySlice,
  i : Int32,
  v : Double,
) -> NlpparseckySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckySlice::sum(self : NlpparseckySlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NlpparseckySlice::mean(self : NlpparseckySlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NlpparseckySlice::scale(
  self : NlpparseckySlice,
  f : Double,
) -> NlpparseckySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckySlice::add(
  self : NlpparseckySlice,
  other : NlpparseckySlice,
) -> NlpparseckySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NlpparseckySlice::copy(self : NlpparseckySlice) -> NlpparseckySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckySlice::fill(
  self : NlpparseckySlice,
  v : Double,
) -> NlpparseckySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NlpparseckySlice::min(self : NlpparseckySlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NlpparseckySlice::max(self : NlpparseckySlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NlpparseckySlice::to_string(self : NlpparseckySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
