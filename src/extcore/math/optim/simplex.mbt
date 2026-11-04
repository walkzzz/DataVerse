///|
///===
/// extcore/math_simplex
pub(all) struct MathsimplexPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn math_simplex_make_point(x : Double, y : Double) -> MathsimplexPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn math_simplex_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MathsimplexPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MathsimplexPoint::x(self : MathsimplexPoint) -> Double {
  self.x
}

///|
pub fn MathsimplexPoint::y(self : MathsimplexPoint) -> Double {
  self.y
}

///|
pub fn MathsimplexPoint::z(self : MathsimplexPoint) -> Double {
  self.z
}

///|
pub fn MathsimplexPoint::label(self : MathsimplexPoint) -> Int32 {
  self.label
}

///|
pub fn MathsimplexPoint::dist(
  self : MathsimplexPoint,
  other : MathsimplexPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MathsimplexPoint::add(
  self : MathsimplexPoint,
  other : MathsimplexPoint,
) -> MathsimplexPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MathsimplexPoint::sub(
  self : MathsimplexPoint,
  other : MathsimplexPoint,
) -> MathsimplexPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MathsimplexPoint::scale(
  self : MathsimplexPoint,
  s : Double,
) -> MathsimplexPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MathsimplexPoint::dot(
  self : MathsimplexPoint,
  other : MathsimplexPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MathsimplexPoint::cross(
  self : MathsimplexPoint,
  other : MathsimplexPoint,
) -> MathsimplexPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MathsimplexPoint::norm(self : MathsimplexPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MathsimplexPoint::normalize(self : MathsimplexPoint) -> MathsimplexPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathsimplexPoint::negate(self : MathsimplexPoint) -> MathsimplexPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MathsimplexPoint::mid(
  self : MathsimplexPoint,
  other : MathsimplexPoint,
) -> MathsimplexPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MathsimplexPoint::lerp(
  self : MathsimplexPoint,
  other : MathsimplexPoint,
  t : Double,
) -> MathsimplexPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MathsimplexPoint::to_string(self : MathsimplexPoint) -> String {
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
pub(all) struct MathsimplexSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn math_simplex_make_series(
  vals : Array[Double],
  name : String,
) -> MathsimplexSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MathsimplexSeries::len(self : MathsimplexSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MathsimplexSeries::sum(self : MathsimplexSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MathsimplexSeries::mean(self : MathsimplexSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MathsimplexSeries::min(self : MathsimplexSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MathsimplexSeries::max(self : MathsimplexSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MathsimplexSeries::range(self : MathsimplexSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MathsimplexSeries::variance(self : MathsimplexSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MathsimplexSeries::std(self : MathsimplexSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MathsimplexSeries::median(self : MathsimplexSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MathsimplexSeries::scale(
  self : MathsimplexSeries,
  f : Double,
) -> MathsimplexSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MathsimplexSeries::add(
  self : MathsimplexSeries,
  other : MathsimplexSeries,
) -> MathsimplexSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathsimplexSeries::sub(
  self : MathsimplexSeries,
  other : MathsimplexSeries,
) -> MathsimplexSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathsimplexSeries::normalize(
  self : MathsimplexSeries,
) -> MathsimplexSeries {
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
pub fn MathsimplexSeries::cumsum(self : MathsimplexSeries) -> MathsimplexSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MathsimplexSeries::to_string(self : MathsimplexSeries) -> String {
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
pub(all) struct MathsimplexMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn math_simplex_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MathsimplexMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn math_simplex_matrix_identity(n : Int32) -> MathsimplexMatrix {
  let m = math_simplex_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MathsimplexMatrix::get(
  self : MathsimplexMatrix,
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
pub fn MathsimplexMatrix::transpose(
  self : MathsimplexMatrix,
) -> MathsimplexMatrix {
  let result = math_simplex_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MathsimplexMatrix::add(
  self : MathsimplexMatrix,
  other : MathsimplexMatrix,
) -> MathsimplexMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = math_simplex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MathsimplexMatrix::scale(
  self : MathsimplexMatrix,
  s : Double,
) -> MathsimplexMatrix {
  let result = math_simplex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MathsimplexMatrix::multiply(
  self : MathsimplexMatrix,
  other : MathsimplexMatrix,
) -> MathsimplexMatrix {
  if self.cols != other.rows {
    return math_simplex_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = math_simplex_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MathsimplexMatrix::trace(self : MathsimplexMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MathsimplexMatrix::det(self : MathsimplexMatrix) -> Double {
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
pub fn MathsimplexMatrix::norm(self : MathsimplexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MathsimplexMatrix::to_string(self : MathsimplexMatrix) -> String {
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
pub(all) struct MathsimplexVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn math_simplex_make_vector(comps : Array[Double]) -> MathsimplexVector {
  { comps, dim: comps.length(), }
}

///|
pub fn math_simplex_vector_zero(dim : Int32) -> MathsimplexVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MathsimplexVector::add(
  self : MathsimplexVector,
  other : MathsimplexVector,
) -> MathsimplexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathsimplexVector::sub(
  self : MathsimplexVector,
  other : MathsimplexVector,
) -> MathsimplexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathsimplexVector::scale(
  self : MathsimplexVector,
  s : Double,
) -> MathsimplexVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MathsimplexVector::dot(
  self : MathsimplexVector,
  other : MathsimplexVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MathsimplexVector::norm(self : MathsimplexVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MathsimplexVector::normalize(
  self : MathsimplexVector,
) -> MathsimplexVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathsimplexVector::dist(
  self : MathsimplexVector,
  other : MathsimplexVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MathsimplexVector::to_string(self : MathsimplexVector) -> String {
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
pub(all) struct MathsimplexFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_frame_make(size : Int32) -> MathsimplexFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexFrame::len(self : MathsimplexFrame) -> Int32 {
  self.size
}

///|
pub fn MathsimplexFrame::get(self : MathsimplexFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexFrame::set(
  self : MathsimplexFrame,
  i : Int32,
  v : Double,
) -> MathsimplexFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexFrame::sum(self : MathsimplexFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexFrame::mean(self : MathsimplexFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexFrame::scale(
  self : MathsimplexFrame,
  f : Double,
) -> MathsimplexFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexFrame::add(
  self : MathsimplexFrame,
  other : MathsimplexFrame,
) -> MathsimplexFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexFrame::copy(self : MathsimplexFrame) -> MathsimplexFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexFrame::fill(
  self : MathsimplexFrame,
  v : Double,
) -> MathsimplexFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexFrame::min(self : MathsimplexFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexFrame::max(self : MathsimplexFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexFrame::to_string(self : MathsimplexFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_table_make(size : Int32) -> MathsimplexTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexTable::len(self : MathsimplexTable) -> Int32 {
  self.size
}

///|
pub fn MathsimplexTable::get(self : MathsimplexTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexTable::set(
  self : MathsimplexTable,
  i : Int32,
  v : Double,
) -> MathsimplexTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexTable::sum(self : MathsimplexTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexTable::mean(self : MathsimplexTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexTable::scale(
  self : MathsimplexTable,
  f : Double,
) -> MathsimplexTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexTable::add(
  self : MathsimplexTable,
  other : MathsimplexTable,
) -> MathsimplexTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexTable::copy(self : MathsimplexTable) -> MathsimplexTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexTable::fill(
  self : MathsimplexTable,
  v : Double,
) -> MathsimplexTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexTable::min(self : MathsimplexTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexTable::max(self : MathsimplexTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexTable::to_string(self : MathsimplexTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_graphn_make(size : Int32) -> MathsimplexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexGraphN::len(self : MathsimplexGraphN) -> Int32 {
  self.size
}

///|
pub fn MathsimplexGraphN::get(self : MathsimplexGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexGraphN::set(
  self : MathsimplexGraphN,
  i : Int32,
  v : Double,
) -> MathsimplexGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexGraphN::sum(self : MathsimplexGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexGraphN::mean(self : MathsimplexGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexGraphN::scale(
  self : MathsimplexGraphN,
  f : Double,
) -> MathsimplexGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexGraphN::add(
  self : MathsimplexGraphN,
  other : MathsimplexGraphN,
) -> MathsimplexGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexGraphN::copy(self : MathsimplexGraphN) -> MathsimplexGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexGraphN::fill(
  self : MathsimplexGraphN,
  v : Double,
) -> MathsimplexGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexGraphN::min(self : MathsimplexGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexGraphN::max(self : MathsimplexGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexGraphN::to_string(self : MathsimplexGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_node_make(size : Int32) -> MathsimplexNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexNode::len(self : MathsimplexNode) -> Int32 {
  self.size
}

///|
pub fn MathsimplexNode::get(self : MathsimplexNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexNode::set(
  self : MathsimplexNode,
  i : Int32,
  v : Double,
) -> MathsimplexNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexNode::sum(self : MathsimplexNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexNode::mean(self : MathsimplexNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexNode::scale(
  self : MathsimplexNode,
  f : Double,
) -> MathsimplexNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexNode::add(
  self : MathsimplexNode,
  other : MathsimplexNode,
) -> MathsimplexNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexNode::copy(self : MathsimplexNode) -> MathsimplexNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexNode::fill(
  self : MathsimplexNode,
  v : Double,
) -> MathsimplexNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexNode::min(self : MathsimplexNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexNode::max(self : MathsimplexNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexNode::to_string(self : MathsimplexNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_edge_make(size : Int32) -> MathsimplexEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexEdge::len(self : MathsimplexEdge) -> Int32 {
  self.size
}

///|
pub fn MathsimplexEdge::get(self : MathsimplexEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexEdge::set(
  self : MathsimplexEdge,
  i : Int32,
  v : Double,
) -> MathsimplexEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexEdge::sum(self : MathsimplexEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexEdge::mean(self : MathsimplexEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexEdge::scale(
  self : MathsimplexEdge,
  f : Double,
) -> MathsimplexEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexEdge::add(
  self : MathsimplexEdge,
  other : MathsimplexEdge,
) -> MathsimplexEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexEdge::copy(self : MathsimplexEdge) -> MathsimplexEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexEdge::fill(
  self : MathsimplexEdge,
  v : Double,
) -> MathsimplexEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexEdge::min(self : MathsimplexEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexEdge::max(self : MathsimplexEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexEdge::to_string(self : MathsimplexEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_path_make(size : Int32) -> MathsimplexPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexPath::len(self : MathsimplexPath) -> Int32 {
  self.size
}

///|
pub fn MathsimplexPath::get(self : MathsimplexPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexPath::set(
  self : MathsimplexPath,
  i : Int32,
  v : Double,
) -> MathsimplexPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexPath::sum(self : MathsimplexPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexPath::mean(self : MathsimplexPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexPath::scale(
  self : MathsimplexPath,
  f : Double,
) -> MathsimplexPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexPath::add(
  self : MathsimplexPath,
  other : MathsimplexPath,
) -> MathsimplexPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexPath::copy(self : MathsimplexPath) -> MathsimplexPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexPath::fill(
  self : MathsimplexPath,
  v : Double,
) -> MathsimplexPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexPath::min(self : MathsimplexPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexPath::max(self : MathsimplexPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexPath::to_string(self : MathsimplexPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_cluster_make(size : Int32) -> MathsimplexCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexCluster::len(self : MathsimplexCluster) -> Int32 {
  self.size
}

///|
pub fn MathsimplexCluster::get(self : MathsimplexCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexCluster::set(
  self : MathsimplexCluster,
  i : Int32,
  v : Double,
) -> MathsimplexCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexCluster::sum(self : MathsimplexCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexCluster::mean(self : MathsimplexCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexCluster::scale(
  self : MathsimplexCluster,
  f : Double,
) -> MathsimplexCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexCluster::add(
  self : MathsimplexCluster,
  other : MathsimplexCluster,
) -> MathsimplexCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexCluster::copy(
  self : MathsimplexCluster,
) -> MathsimplexCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexCluster::fill(
  self : MathsimplexCluster,
  v : Double,
) -> MathsimplexCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexCluster::min(self : MathsimplexCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexCluster::max(self : MathsimplexCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexCluster::to_string(self : MathsimplexCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_model_make(size : Int32) -> MathsimplexModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexModel::len(self : MathsimplexModel) -> Int32 {
  self.size
}

///|
pub fn MathsimplexModel::get(self : MathsimplexModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexModel::set(
  self : MathsimplexModel,
  i : Int32,
  v : Double,
) -> MathsimplexModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexModel::sum(self : MathsimplexModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexModel::mean(self : MathsimplexModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexModel::scale(
  self : MathsimplexModel,
  f : Double,
) -> MathsimplexModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexModel::add(
  self : MathsimplexModel,
  other : MathsimplexModel,
) -> MathsimplexModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexModel::copy(self : MathsimplexModel) -> MathsimplexModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexModel::fill(
  self : MathsimplexModel,
  v : Double,
) -> MathsimplexModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexModel::min(self : MathsimplexModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexModel::max(self : MathsimplexModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexModel::to_string(self : MathsimplexModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_layer_make(size : Int32) -> MathsimplexLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexLayer::len(self : MathsimplexLayer) -> Int32 {
  self.size
}

///|
pub fn MathsimplexLayer::get(self : MathsimplexLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexLayer::set(
  self : MathsimplexLayer,
  i : Int32,
  v : Double,
) -> MathsimplexLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexLayer::sum(self : MathsimplexLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexLayer::mean(self : MathsimplexLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexLayer::scale(
  self : MathsimplexLayer,
  f : Double,
) -> MathsimplexLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexLayer::add(
  self : MathsimplexLayer,
  other : MathsimplexLayer,
) -> MathsimplexLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexLayer::copy(self : MathsimplexLayer) -> MathsimplexLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexLayer::fill(
  self : MathsimplexLayer,
  v : Double,
) -> MathsimplexLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexLayer::min(self : MathsimplexLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexLayer::max(self : MathsimplexLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexLayer::to_string(self : MathsimplexLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_buffer_make(size : Int32) -> MathsimplexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexBuffer::len(self : MathsimplexBuffer) -> Int32 {
  self.size
}

///|
pub fn MathsimplexBuffer::get(self : MathsimplexBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexBuffer::set(
  self : MathsimplexBuffer,
  i : Int32,
  v : Double,
) -> MathsimplexBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexBuffer::sum(self : MathsimplexBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexBuffer::mean(self : MathsimplexBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexBuffer::scale(
  self : MathsimplexBuffer,
  f : Double,
) -> MathsimplexBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexBuffer::add(
  self : MathsimplexBuffer,
  other : MathsimplexBuffer,
) -> MathsimplexBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexBuffer::copy(self : MathsimplexBuffer) -> MathsimplexBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexBuffer::fill(
  self : MathsimplexBuffer,
  v : Double,
) -> MathsimplexBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexBuffer::min(self : MathsimplexBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexBuffer::max(self : MathsimplexBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexBuffer::to_string(self : MathsimplexBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_cursor_make(size : Int32) -> MathsimplexCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexCursor::len(self : MathsimplexCursor) -> Int32 {
  self.size
}

///|
pub fn MathsimplexCursor::get(self : MathsimplexCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexCursor::set(
  self : MathsimplexCursor,
  i : Int32,
  v : Double,
) -> MathsimplexCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexCursor::sum(self : MathsimplexCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexCursor::mean(self : MathsimplexCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexCursor::scale(
  self : MathsimplexCursor,
  f : Double,
) -> MathsimplexCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexCursor::add(
  self : MathsimplexCursor,
  other : MathsimplexCursor,
) -> MathsimplexCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexCursor::copy(self : MathsimplexCursor) -> MathsimplexCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexCursor::fill(
  self : MathsimplexCursor,
  v : Double,
) -> MathsimplexCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexCursor::min(self : MathsimplexCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexCursor::max(self : MathsimplexCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexCursor::to_string(self : MathsimplexCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_view_make(size : Int32) -> MathsimplexView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexView::len(self : MathsimplexView) -> Int32 {
  self.size
}

///|
pub fn MathsimplexView::get(self : MathsimplexView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexView::set(
  self : MathsimplexView,
  i : Int32,
  v : Double,
) -> MathsimplexView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexView::sum(self : MathsimplexView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexView::mean(self : MathsimplexView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexView::scale(
  self : MathsimplexView,
  f : Double,
) -> MathsimplexView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexView::add(
  self : MathsimplexView,
  other : MathsimplexView,
) -> MathsimplexView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexView::copy(self : MathsimplexView) -> MathsimplexView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexView::fill(
  self : MathsimplexView,
  v : Double,
) -> MathsimplexView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexView::min(self : MathsimplexView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexView::max(self : MathsimplexView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexView::to_string(self : MathsimplexView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_range_make(size : Int32) -> MathsimplexRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexRange::len(self : MathsimplexRange) -> Int32 {
  self.size
}

///|
pub fn MathsimplexRange::get(self : MathsimplexRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexRange::set(
  self : MathsimplexRange,
  i : Int32,
  v : Double,
) -> MathsimplexRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexRange::sum(self : MathsimplexRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexRange::mean(self : MathsimplexRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexRange::scale(
  self : MathsimplexRange,
  f : Double,
) -> MathsimplexRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexRange::add(
  self : MathsimplexRange,
  other : MathsimplexRange,
) -> MathsimplexRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexRange::copy(self : MathsimplexRange) -> MathsimplexRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexRange::fill(
  self : MathsimplexRange,
  v : Double,
) -> MathsimplexRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexRange::min(self : MathsimplexRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexRange::max(self : MathsimplexRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexRange::to_string(self : MathsimplexRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathsimplexSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_simplex_slice_make(size : Int32) -> MathsimplexSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathsimplexSlice::len(self : MathsimplexSlice) -> Int32 {
  self.size
}

///|
pub fn MathsimplexSlice::get(self : MathsimplexSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathsimplexSlice::set(
  self : MathsimplexSlice,
  i : Int32,
  v : Double,
) -> MathsimplexSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexSlice::sum(self : MathsimplexSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathsimplexSlice::mean(self : MathsimplexSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathsimplexSlice::scale(
  self : MathsimplexSlice,
  f : Double,
) -> MathsimplexSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexSlice::add(
  self : MathsimplexSlice,
  other : MathsimplexSlice,
) -> MathsimplexSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathsimplexSlice::copy(self : MathsimplexSlice) -> MathsimplexSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexSlice::fill(
  self : MathsimplexSlice,
  v : Double,
) -> MathsimplexSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathsimplexSlice::min(self : MathsimplexSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathsimplexSlice::max(self : MathsimplexSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathsimplexSlice::to_string(self : MathsimplexSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
