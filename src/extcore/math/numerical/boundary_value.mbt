///|
///===
/// extcore/math_boundary_value
pub(all) struct MathboundaryvaluePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn math_boundary_value_make_point(
  x : Double,
  y : Double,
) -> MathboundaryvaluePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn math_boundary_value_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MathboundaryvaluePoint {
  { x, y, z, label: 0, }
}

///|
pub fn MathboundaryvaluePoint::x(self : MathboundaryvaluePoint) -> Double {
  self.x
}

///|
pub fn MathboundaryvaluePoint::y(self : MathboundaryvaluePoint) -> Double {
  self.y
}

///|
pub fn MathboundaryvaluePoint::z(self : MathboundaryvaluePoint) -> Double {
  self.z
}

///|
pub fn MathboundaryvaluePoint::label(self : MathboundaryvaluePoint) -> Int32 {
  self.label
}

///|
pub fn MathboundaryvaluePoint::dist(
  self : MathboundaryvaluePoint,
  other : MathboundaryvaluePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MathboundaryvaluePoint::add(
  self : MathboundaryvaluePoint,
  other : MathboundaryvaluePoint,
) -> MathboundaryvaluePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MathboundaryvaluePoint::sub(
  self : MathboundaryvaluePoint,
  other : MathboundaryvaluePoint,
) -> MathboundaryvaluePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MathboundaryvaluePoint::scale(
  self : MathboundaryvaluePoint,
  s : Double,
) -> MathboundaryvaluePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MathboundaryvaluePoint::dot(
  self : MathboundaryvaluePoint,
  other : MathboundaryvaluePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MathboundaryvaluePoint::cross(
  self : MathboundaryvaluePoint,
  other : MathboundaryvaluePoint,
) -> MathboundaryvaluePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MathboundaryvaluePoint::norm(self : MathboundaryvaluePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MathboundaryvaluePoint::normalize(
  self : MathboundaryvaluePoint,
) -> MathboundaryvaluePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathboundaryvaluePoint::negate(
  self : MathboundaryvaluePoint,
) -> MathboundaryvaluePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MathboundaryvaluePoint::mid(
  self : MathboundaryvaluePoint,
  other : MathboundaryvaluePoint,
) -> MathboundaryvaluePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MathboundaryvaluePoint::lerp(
  self : MathboundaryvaluePoint,
  other : MathboundaryvaluePoint,
  t : Double,
) -> MathboundaryvaluePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MathboundaryvaluePoint::to_string(
  self : MathboundaryvaluePoint,
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
pub(all) struct MathboundaryvalueSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn math_boundary_value_make_series(
  vals : Array[Double],
  name : String,
) -> MathboundaryvalueSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MathboundaryvalueSeries::len(self : MathboundaryvalueSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MathboundaryvalueSeries::sum(self : MathboundaryvalueSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MathboundaryvalueSeries::mean(self : MathboundaryvalueSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MathboundaryvalueSeries::min(self : MathboundaryvalueSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MathboundaryvalueSeries::max(self : MathboundaryvalueSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MathboundaryvalueSeries::range(self : MathboundaryvalueSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MathboundaryvalueSeries::variance(
  self : MathboundaryvalueSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MathboundaryvalueSeries::std(self : MathboundaryvalueSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MathboundaryvalueSeries::median(
  self : MathboundaryvalueSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MathboundaryvalueSeries::scale(
  self : MathboundaryvalueSeries,
  f : Double,
) -> MathboundaryvalueSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MathboundaryvalueSeries::add(
  self : MathboundaryvalueSeries,
  other : MathboundaryvalueSeries,
) -> MathboundaryvalueSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathboundaryvalueSeries::sub(
  self : MathboundaryvalueSeries,
  other : MathboundaryvalueSeries,
) -> MathboundaryvalueSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathboundaryvalueSeries::normalize(
  self : MathboundaryvalueSeries,
) -> MathboundaryvalueSeries {
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
pub fn MathboundaryvalueSeries::cumsum(
  self : MathboundaryvalueSeries,
) -> MathboundaryvalueSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MathboundaryvalueSeries::to_string(
  self : MathboundaryvalueSeries,
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
pub(all) struct MathboundaryvalueMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn math_boundary_value_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MathboundaryvalueMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn math_boundary_value_matrix_identity(
  n : Int32,
) -> MathboundaryvalueMatrix {
  let m = math_boundary_value_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MathboundaryvalueMatrix::get(
  self : MathboundaryvalueMatrix,
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
pub fn MathboundaryvalueMatrix::transpose(
  self : MathboundaryvalueMatrix,
) -> MathboundaryvalueMatrix {
  let result = math_boundary_value_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MathboundaryvalueMatrix::add(
  self : MathboundaryvalueMatrix,
  other : MathboundaryvalueMatrix,
) -> MathboundaryvalueMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = math_boundary_value_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MathboundaryvalueMatrix::scale(
  self : MathboundaryvalueMatrix,
  s : Double,
) -> MathboundaryvalueMatrix {
  let result = math_boundary_value_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MathboundaryvalueMatrix::multiply(
  self : MathboundaryvalueMatrix,
  other : MathboundaryvalueMatrix,
) -> MathboundaryvalueMatrix {
  if self.cols != other.rows {
    return math_boundary_value_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = math_boundary_value_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MathboundaryvalueMatrix::trace(self : MathboundaryvalueMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MathboundaryvalueMatrix::det(self : MathboundaryvalueMatrix) -> Double {
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
pub fn MathboundaryvalueMatrix::norm(self : MathboundaryvalueMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MathboundaryvalueMatrix::to_string(
  self : MathboundaryvalueMatrix,
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
pub(all) struct MathboundaryvalueVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn math_boundary_value_make_vector(
  comps : Array[Double],
) -> MathboundaryvalueVector {
  { comps, dim: comps.length(), }
}

///|
pub fn math_boundary_value_vector_zero(dim : Int32) -> MathboundaryvalueVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MathboundaryvalueVector::add(
  self : MathboundaryvalueVector,
  other : MathboundaryvalueVector,
) -> MathboundaryvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathboundaryvalueVector::sub(
  self : MathboundaryvalueVector,
  other : MathboundaryvalueVector,
) -> MathboundaryvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathboundaryvalueVector::scale(
  self : MathboundaryvalueVector,
  s : Double,
) -> MathboundaryvalueVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MathboundaryvalueVector::dot(
  self : MathboundaryvalueVector,
  other : MathboundaryvalueVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MathboundaryvalueVector::norm(self : MathboundaryvalueVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MathboundaryvalueVector::normalize(
  self : MathboundaryvalueVector,
) -> MathboundaryvalueVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathboundaryvalueVector::dist(
  self : MathboundaryvalueVector,
  other : MathboundaryvalueVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MathboundaryvalueVector::to_string(
  self : MathboundaryvalueVector,
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
pub(all) struct MathboundaryvalueFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_frame_make(size : Int32) -> MathboundaryvalueFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueFrame::len(self : MathboundaryvalueFrame) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueFrame::get(
  self : MathboundaryvalueFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueFrame::set(
  self : MathboundaryvalueFrame,
  i : Int32,
  v : Double,
) -> MathboundaryvalueFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueFrame::sum(self : MathboundaryvalueFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueFrame::mean(self : MathboundaryvalueFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueFrame::scale(
  self : MathboundaryvalueFrame,
  f : Double,
) -> MathboundaryvalueFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueFrame::add(
  self : MathboundaryvalueFrame,
  other : MathboundaryvalueFrame,
) -> MathboundaryvalueFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueFrame::copy(
  self : MathboundaryvalueFrame,
) -> MathboundaryvalueFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueFrame::fill(
  self : MathboundaryvalueFrame,
  v : Double,
) -> MathboundaryvalueFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueFrame::min(self : MathboundaryvalueFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueFrame::max(self : MathboundaryvalueFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueFrame::to_string(
  self : MathboundaryvalueFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_table_make(size : Int32) -> MathboundaryvalueTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueTable::len(self : MathboundaryvalueTable) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueTable::get(
  self : MathboundaryvalueTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueTable::set(
  self : MathboundaryvalueTable,
  i : Int32,
  v : Double,
) -> MathboundaryvalueTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueTable::sum(self : MathboundaryvalueTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueTable::mean(self : MathboundaryvalueTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueTable::scale(
  self : MathboundaryvalueTable,
  f : Double,
) -> MathboundaryvalueTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueTable::add(
  self : MathboundaryvalueTable,
  other : MathboundaryvalueTable,
) -> MathboundaryvalueTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueTable::copy(
  self : MathboundaryvalueTable,
) -> MathboundaryvalueTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueTable::fill(
  self : MathboundaryvalueTable,
  v : Double,
) -> MathboundaryvalueTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueTable::min(self : MathboundaryvalueTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueTable::max(self : MathboundaryvalueTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueTable::to_string(
  self : MathboundaryvalueTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_graphn_make(size : Int32) -> MathboundaryvalueGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueGraphN::len(self : MathboundaryvalueGraphN) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueGraphN::get(
  self : MathboundaryvalueGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueGraphN::set(
  self : MathboundaryvalueGraphN,
  i : Int32,
  v : Double,
) -> MathboundaryvalueGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueGraphN::sum(self : MathboundaryvalueGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueGraphN::mean(self : MathboundaryvalueGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueGraphN::scale(
  self : MathboundaryvalueGraphN,
  f : Double,
) -> MathboundaryvalueGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueGraphN::add(
  self : MathboundaryvalueGraphN,
  other : MathboundaryvalueGraphN,
) -> MathboundaryvalueGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueGraphN::copy(
  self : MathboundaryvalueGraphN,
) -> MathboundaryvalueGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueGraphN::fill(
  self : MathboundaryvalueGraphN,
  v : Double,
) -> MathboundaryvalueGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueGraphN::min(self : MathboundaryvalueGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueGraphN::max(self : MathboundaryvalueGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueGraphN::to_string(
  self : MathboundaryvalueGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_node_make(size : Int32) -> MathboundaryvalueNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueNode::len(self : MathboundaryvalueNode) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueNode::get(
  self : MathboundaryvalueNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueNode::set(
  self : MathboundaryvalueNode,
  i : Int32,
  v : Double,
) -> MathboundaryvalueNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueNode::sum(self : MathboundaryvalueNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueNode::mean(self : MathboundaryvalueNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueNode::scale(
  self : MathboundaryvalueNode,
  f : Double,
) -> MathboundaryvalueNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueNode::add(
  self : MathboundaryvalueNode,
  other : MathboundaryvalueNode,
) -> MathboundaryvalueNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueNode::copy(
  self : MathboundaryvalueNode,
) -> MathboundaryvalueNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueNode::fill(
  self : MathboundaryvalueNode,
  v : Double,
) -> MathboundaryvalueNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueNode::min(self : MathboundaryvalueNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueNode::max(self : MathboundaryvalueNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueNode::to_string(self : MathboundaryvalueNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_edge_make(size : Int32) -> MathboundaryvalueEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueEdge::len(self : MathboundaryvalueEdge) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueEdge::get(
  self : MathboundaryvalueEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueEdge::set(
  self : MathboundaryvalueEdge,
  i : Int32,
  v : Double,
) -> MathboundaryvalueEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueEdge::sum(self : MathboundaryvalueEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueEdge::mean(self : MathboundaryvalueEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueEdge::scale(
  self : MathboundaryvalueEdge,
  f : Double,
) -> MathboundaryvalueEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueEdge::add(
  self : MathboundaryvalueEdge,
  other : MathboundaryvalueEdge,
) -> MathboundaryvalueEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueEdge::copy(
  self : MathboundaryvalueEdge,
) -> MathboundaryvalueEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueEdge::fill(
  self : MathboundaryvalueEdge,
  v : Double,
) -> MathboundaryvalueEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueEdge::min(self : MathboundaryvalueEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueEdge::max(self : MathboundaryvalueEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueEdge::to_string(self : MathboundaryvalueEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvaluePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_path_make(size : Int32) -> MathboundaryvaluePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvaluePath::len(self : MathboundaryvaluePath) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvaluePath::get(
  self : MathboundaryvaluePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvaluePath::set(
  self : MathboundaryvaluePath,
  i : Int32,
  v : Double,
) -> MathboundaryvaluePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvaluePath::sum(self : MathboundaryvaluePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvaluePath::mean(self : MathboundaryvaluePath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvaluePath::scale(
  self : MathboundaryvaluePath,
  f : Double,
) -> MathboundaryvaluePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvaluePath::add(
  self : MathboundaryvaluePath,
  other : MathboundaryvaluePath,
) -> MathboundaryvaluePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvaluePath::copy(
  self : MathboundaryvaluePath,
) -> MathboundaryvaluePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvaluePath::fill(
  self : MathboundaryvaluePath,
  v : Double,
) -> MathboundaryvaluePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvaluePath::min(self : MathboundaryvaluePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvaluePath::max(self : MathboundaryvaluePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvaluePath::to_string(self : MathboundaryvaluePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_cluster_make(
  size : Int32,
) -> MathboundaryvalueCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueCluster::len(self : MathboundaryvalueCluster) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueCluster::get(
  self : MathboundaryvalueCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueCluster::set(
  self : MathboundaryvalueCluster,
  i : Int32,
  v : Double,
) -> MathboundaryvalueCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueCluster::sum(self : MathboundaryvalueCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueCluster::mean(
  self : MathboundaryvalueCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueCluster::scale(
  self : MathboundaryvalueCluster,
  f : Double,
) -> MathboundaryvalueCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueCluster::add(
  self : MathboundaryvalueCluster,
  other : MathboundaryvalueCluster,
) -> MathboundaryvalueCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueCluster::copy(
  self : MathboundaryvalueCluster,
) -> MathboundaryvalueCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueCluster::fill(
  self : MathboundaryvalueCluster,
  v : Double,
) -> MathboundaryvalueCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueCluster::min(self : MathboundaryvalueCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueCluster::max(self : MathboundaryvalueCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueCluster::to_string(
  self : MathboundaryvalueCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_model_make(size : Int32) -> MathboundaryvalueModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueModel::len(self : MathboundaryvalueModel) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueModel::get(
  self : MathboundaryvalueModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueModel::set(
  self : MathboundaryvalueModel,
  i : Int32,
  v : Double,
) -> MathboundaryvalueModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueModel::sum(self : MathboundaryvalueModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueModel::mean(self : MathboundaryvalueModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueModel::scale(
  self : MathboundaryvalueModel,
  f : Double,
) -> MathboundaryvalueModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueModel::add(
  self : MathboundaryvalueModel,
  other : MathboundaryvalueModel,
) -> MathboundaryvalueModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueModel::copy(
  self : MathboundaryvalueModel,
) -> MathboundaryvalueModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueModel::fill(
  self : MathboundaryvalueModel,
  v : Double,
) -> MathboundaryvalueModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueModel::min(self : MathboundaryvalueModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueModel::max(self : MathboundaryvalueModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueModel::to_string(
  self : MathboundaryvalueModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_layer_make(size : Int32) -> MathboundaryvalueLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueLayer::len(self : MathboundaryvalueLayer) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueLayer::get(
  self : MathboundaryvalueLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueLayer::set(
  self : MathboundaryvalueLayer,
  i : Int32,
  v : Double,
) -> MathboundaryvalueLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueLayer::sum(self : MathboundaryvalueLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueLayer::mean(self : MathboundaryvalueLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueLayer::scale(
  self : MathboundaryvalueLayer,
  f : Double,
) -> MathboundaryvalueLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueLayer::add(
  self : MathboundaryvalueLayer,
  other : MathboundaryvalueLayer,
) -> MathboundaryvalueLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueLayer::copy(
  self : MathboundaryvalueLayer,
) -> MathboundaryvalueLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueLayer::fill(
  self : MathboundaryvalueLayer,
  v : Double,
) -> MathboundaryvalueLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueLayer::min(self : MathboundaryvalueLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueLayer::max(self : MathboundaryvalueLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueLayer::to_string(
  self : MathboundaryvalueLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_buffer_make(size : Int32) -> MathboundaryvalueBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueBuffer::len(self : MathboundaryvalueBuffer) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueBuffer::get(
  self : MathboundaryvalueBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueBuffer::set(
  self : MathboundaryvalueBuffer,
  i : Int32,
  v : Double,
) -> MathboundaryvalueBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueBuffer::sum(self : MathboundaryvalueBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueBuffer::mean(self : MathboundaryvalueBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueBuffer::scale(
  self : MathboundaryvalueBuffer,
  f : Double,
) -> MathboundaryvalueBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueBuffer::add(
  self : MathboundaryvalueBuffer,
  other : MathboundaryvalueBuffer,
) -> MathboundaryvalueBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueBuffer::copy(
  self : MathboundaryvalueBuffer,
) -> MathboundaryvalueBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueBuffer::fill(
  self : MathboundaryvalueBuffer,
  v : Double,
) -> MathboundaryvalueBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueBuffer::min(self : MathboundaryvalueBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueBuffer::max(self : MathboundaryvalueBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueBuffer::to_string(
  self : MathboundaryvalueBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_cursor_make(size : Int32) -> MathboundaryvalueCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueCursor::len(self : MathboundaryvalueCursor) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueCursor::get(
  self : MathboundaryvalueCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueCursor::set(
  self : MathboundaryvalueCursor,
  i : Int32,
  v : Double,
) -> MathboundaryvalueCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueCursor::sum(self : MathboundaryvalueCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueCursor::mean(self : MathboundaryvalueCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueCursor::scale(
  self : MathboundaryvalueCursor,
  f : Double,
) -> MathboundaryvalueCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueCursor::add(
  self : MathboundaryvalueCursor,
  other : MathboundaryvalueCursor,
) -> MathboundaryvalueCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueCursor::copy(
  self : MathboundaryvalueCursor,
) -> MathboundaryvalueCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueCursor::fill(
  self : MathboundaryvalueCursor,
  v : Double,
) -> MathboundaryvalueCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueCursor::min(self : MathboundaryvalueCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueCursor::max(self : MathboundaryvalueCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueCursor::to_string(
  self : MathboundaryvalueCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_view_make(size : Int32) -> MathboundaryvalueView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueView::len(self : MathboundaryvalueView) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueView::get(
  self : MathboundaryvalueView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueView::set(
  self : MathboundaryvalueView,
  i : Int32,
  v : Double,
) -> MathboundaryvalueView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueView::sum(self : MathboundaryvalueView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueView::mean(self : MathboundaryvalueView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueView::scale(
  self : MathboundaryvalueView,
  f : Double,
) -> MathboundaryvalueView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueView::add(
  self : MathboundaryvalueView,
  other : MathboundaryvalueView,
) -> MathboundaryvalueView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueView::copy(
  self : MathboundaryvalueView,
) -> MathboundaryvalueView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueView::fill(
  self : MathboundaryvalueView,
  v : Double,
) -> MathboundaryvalueView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueView::min(self : MathboundaryvalueView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueView::max(self : MathboundaryvalueView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueView::to_string(self : MathboundaryvalueView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_range_make(size : Int32) -> MathboundaryvalueRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueRange::len(self : MathboundaryvalueRange) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueRange::get(
  self : MathboundaryvalueRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueRange::set(
  self : MathboundaryvalueRange,
  i : Int32,
  v : Double,
) -> MathboundaryvalueRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueRange::sum(self : MathboundaryvalueRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueRange::mean(self : MathboundaryvalueRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueRange::scale(
  self : MathboundaryvalueRange,
  f : Double,
) -> MathboundaryvalueRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueRange::add(
  self : MathboundaryvalueRange,
  other : MathboundaryvalueRange,
) -> MathboundaryvalueRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueRange::copy(
  self : MathboundaryvalueRange,
) -> MathboundaryvalueRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueRange::fill(
  self : MathboundaryvalueRange,
  v : Double,
) -> MathboundaryvalueRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueRange::min(self : MathboundaryvalueRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueRange::max(self : MathboundaryvalueRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueRange::to_string(
  self : MathboundaryvalueRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathboundaryvalueSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_boundary_value_slice_make(size : Int32) -> MathboundaryvalueSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathboundaryvalueSlice::len(self : MathboundaryvalueSlice) -> Int32 {
  self.size
}

///|
pub fn MathboundaryvalueSlice::get(
  self : MathboundaryvalueSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathboundaryvalueSlice::set(
  self : MathboundaryvalueSlice,
  i : Int32,
  v : Double,
) -> MathboundaryvalueSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueSlice::sum(self : MathboundaryvalueSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathboundaryvalueSlice::mean(self : MathboundaryvalueSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathboundaryvalueSlice::scale(
  self : MathboundaryvalueSlice,
  f : Double,
) -> MathboundaryvalueSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueSlice::add(
  self : MathboundaryvalueSlice,
  other : MathboundaryvalueSlice,
) -> MathboundaryvalueSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathboundaryvalueSlice::copy(
  self : MathboundaryvalueSlice,
) -> MathboundaryvalueSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueSlice::fill(
  self : MathboundaryvalueSlice,
  v : Double,
) -> MathboundaryvalueSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathboundaryvalueSlice::min(self : MathboundaryvalueSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathboundaryvalueSlice::max(self : MathboundaryvalueSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathboundaryvalueSlice::to_string(
  self : MathboundaryvalueSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
