///|
///===
/// extcore/math_approx_least_sq
pub(all) struct MathapproxleastsqPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn math_approx_least_sq_make_point(
  x : Double,
  y : Double,
) -> MathapproxleastsqPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn math_approx_least_sq_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MathapproxleastsqPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MathapproxleastsqPoint::x(self : MathapproxleastsqPoint) -> Double {
  self.x
}

///|
pub fn MathapproxleastsqPoint::y(self : MathapproxleastsqPoint) -> Double {
  self.y
}

///|
pub fn MathapproxleastsqPoint::z(self : MathapproxleastsqPoint) -> Double {
  self.z
}

///|
pub fn MathapproxleastsqPoint::label(self : MathapproxleastsqPoint) -> Int32 {
  self.label
}

///|
pub fn MathapproxleastsqPoint::dist(
  self : MathapproxleastsqPoint,
  other : MathapproxleastsqPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MathapproxleastsqPoint::add(
  self : MathapproxleastsqPoint,
  other : MathapproxleastsqPoint,
) -> MathapproxleastsqPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MathapproxleastsqPoint::sub(
  self : MathapproxleastsqPoint,
  other : MathapproxleastsqPoint,
) -> MathapproxleastsqPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MathapproxleastsqPoint::scale(
  self : MathapproxleastsqPoint,
  s : Double,
) -> MathapproxleastsqPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MathapproxleastsqPoint::dot(
  self : MathapproxleastsqPoint,
  other : MathapproxleastsqPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MathapproxleastsqPoint::cross(
  self : MathapproxleastsqPoint,
  other : MathapproxleastsqPoint,
) -> MathapproxleastsqPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MathapproxleastsqPoint::norm(self : MathapproxleastsqPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MathapproxleastsqPoint::normalize(
  self : MathapproxleastsqPoint,
) -> MathapproxleastsqPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathapproxleastsqPoint::negate(
  self : MathapproxleastsqPoint,
) -> MathapproxleastsqPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MathapproxleastsqPoint::mid(
  self : MathapproxleastsqPoint,
  other : MathapproxleastsqPoint,
) -> MathapproxleastsqPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MathapproxleastsqPoint::lerp(
  self : MathapproxleastsqPoint,
  other : MathapproxleastsqPoint,
  t : Double,
) -> MathapproxleastsqPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MathapproxleastsqPoint::to_string(
  self : MathapproxleastsqPoint,
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
pub(all) struct MathapproxleastsqSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn math_approx_least_sq_make_series(
  vals : Array[Double],
  name : String,
) -> MathapproxleastsqSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MathapproxleastsqSeries::len(self : MathapproxleastsqSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MathapproxleastsqSeries::sum(self : MathapproxleastsqSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MathapproxleastsqSeries::mean(self : MathapproxleastsqSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MathapproxleastsqSeries::min(self : MathapproxleastsqSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MathapproxleastsqSeries::max(self : MathapproxleastsqSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MathapproxleastsqSeries::range(self : MathapproxleastsqSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MathapproxleastsqSeries::variance(
  self : MathapproxleastsqSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MathapproxleastsqSeries::std(self : MathapproxleastsqSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MathapproxleastsqSeries::median(
  self : MathapproxleastsqSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MathapproxleastsqSeries::scale(
  self : MathapproxleastsqSeries,
  f : Double,
) -> MathapproxleastsqSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MathapproxleastsqSeries::add(
  self : MathapproxleastsqSeries,
  other : MathapproxleastsqSeries,
) -> MathapproxleastsqSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathapproxleastsqSeries::sub(
  self : MathapproxleastsqSeries,
  other : MathapproxleastsqSeries,
) -> MathapproxleastsqSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathapproxleastsqSeries::normalize(
  self : MathapproxleastsqSeries,
) -> MathapproxleastsqSeries {
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
pub fn MathapproxleastsqSeries::cumsum(
  self : MathapproxleastsqSeries,
) -> MathapproxleastsqSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MathapproxleastsqSeries::to_string(
  self : MathapproxleastsqSeries,
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
pub(all) struct MathapproxleastsqMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn math_approx_least_sq_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MathapproxleastsqMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn math_approx_least_sq_matrix_identity(
  n : Int32,
) -> MathapproxleastsqMatrix {
  let m = math_approx_least_sq_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MathapproxleastsqMatrix::get(
  self : MathapproxleastsqMatrix,
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
pub fn MathapproxleastsqMatrix::transpose(
  self : MathapproxleastsqMatrix,
) -> MathapproxleastsqMatrix {
  let result = math_approx_least_sq_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MathapproxleastsqMatrix::add(
  self : MathapproxleastsqMatrix,
  other : MathapproxleastsqMatrix,
) -> MathapproxleastsqMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = math_approx_least_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MathapproxleastsqMatrix::scale(
  self : MathapproxleastsqMatrix,
  s : Double,
) -> MathapproxleastsqMatrix {
  let result = math_approx_least_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MathapproxleastsqMatrix::multiply(
  self : MathapproxleastsqMatrix,
  other : MathapproxleastsqMatrix,
) -> MathapproxleastsqMatrix {
  if self.cols != other.rows {
    return math_approx_least_sq_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = math_approx_least_sq_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MathapproxleastsqMatrix::trace(self : MathapproxleastsqMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MathapproxleastsqMatrix::det(self : MathapproxleastsqMatrix) -> Double {
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
pub fn MathapproxleastsqMatrix::norm(self : MathapproxleastsqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MathapproxleastsqMatrix::to_string(
  self : MathapproxleastsqMatrix,
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
pub(all) struct MathapproxleastsqVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn math_approx_least_sq_make_vector(
  comps : Array[Double],
) -> MathapproxleastsqVector {
  { comps, dim: comps.length(), }
}

///|
pub fn math_approx_least_sq_vector_zero(dim : Int32) -> MathapproxleastsqVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MathapproxleastsqVector::add(
  self : MathapproxleastsqVector,
  other : MathapproxleastsqVector,
) -> MathapproxleastsqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathapproxleastsqVector::sub(
  self : MathapproxleastsqVector,
  other : MathapproxleastsqVector,
) -> MathapproxleastsqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathapproxleastsqVector::scale(
  self : MathapproxleastsqVector,
  s : Double,
) -> MathapproxleastsqVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MathapproxleastsqVector::dot(
  self : MathapproxleastsqVector,
  other : MathapproxleastsqVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MathapproxleastsqVector::norm(self : MathapproxleastsqVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MathapproxleastsqVector::normalize(
  self : MathapproxleastsqVector,
) -> MathapproxleastsqVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathapproxleastsqVector::dist(
  self : MathapproxleastsqVector,
  other : MathapproxleastsqVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MathapproxleastsqVector::to_string(
  self : MathapproxleastsqVector,
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
pub(all) struct MathapproxleastsqFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_frame_make(size : Int32) -> MathapproxleastsqFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqFrame::len(self : MathapproxleastsqFrame) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqFrame::get(
  self : MathapproxleastsqFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqFrame::set(
  self : MathapproxleastsqFrame,
  i : Int32,
  v : Double,
) -> MathapproxleastsqFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqFrame::sum(self : MathapproxleastsqFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqFrame::mean(self : MathapproxleastsqFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqFrame::scale(
  self : MathapproxleastsqFrame,
  f : Double,
) -> MathapproxleastsqFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqFrame::add(
  self : MathapproxleastsqFrame,
  other : MathapproxleastsqFrame,
) -> MathapproxleastsqFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqFrame::copy(
  self : MathapproxleastsqFrame,
) -> MathapproxleastsqFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqFrame::fill(
  self : MathapproxleastsqFrame,
  v : Double,
) -> MathapproxleastsqFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqFrame::min(self : MathapproxleastsqFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqFrame::max(self : MathapproxleastsqFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqFrame::to_string(
  self : MathapproxleastsqFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_table_make(size : Int32) -> MathapproxleastsqTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqTable::len(self : MathapproxleastsqTable) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqTable::get(
  self : MathapproxleastsqTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqTable::set(
  self : MathapproxleastsqTable,
  i : Int32,
  v : Double,
) -> MathapproxleastsqTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqTable::sum(self : MathapproxleastsqTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqTable::mean(self : MathapproxleastsqTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqTable::scale(
  self : MathapproxleastsqTable,
  f : Double,
) -> MathapproxleastsqTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqTable::add(
  self : MathapproxleastsqTable,
  other : MathapproxleastsqTable,
) -> MathapproxleastsqTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqTable::copy(
  self : MathapproxleastsqTable,
) -> MathapproxleastsqTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqTable::fill(
  self : MathapproxleastsqTable,
  v : Double,
) -> MathapproxleastsqTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqTable::min(self : MathapproxleastsqTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqTable::max(self : MathapproxleastsqTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqTable::to_string(
  self : MathapproxleastsqTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_graphn_make(
  size : Int32,
) -> MathapproxleastsqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqGraphN::len(self : MathapproxleastsqGraphN) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqGraphN::get(
  self : MathapproxleastsqGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqGraphN::set(
  self : MathapproxleastsqGraphN,
  i : Int32,
  v : Double,
) -> MathapproxleastsqGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqGraphN::sum(self : MathapproxleastsqGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqGraphN::mean(self : MathapproxleastsqGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqGraphN::scale(
  self : MathapproxleastsqGraphN,
  f : Double,
) -> MathapproxleastsqGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqGraphN::add(
  self : MathapproxleastsqGraphN,
  other : MathapproxleastsqGraphN,
) -> MathapproxleastsqGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqGraphN::copy(
  self : MathapproxleastsqGraphN,
) -> MathapproxleastsqGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqGraphN::fill(
  self : MathapproxleastsqGraphN,
  v : Double,
) -> MathapproxleastsqGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqGraphN::min(self : MathapproxleastsqGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqGraphN::max(self : MathapproxleastsqGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqGraphN::to_string(
  self : MathapproxleastsqGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_node_make(size : Int32) -> MathapproxleastsqNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqNode::len(self : MathapproxleastsqNode) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqNode::get(
  self : MathapproxleastsqNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqNode::set(
  self : MathapproxleastsqNode,
  i : Int32,
  v : Double,
) -> MathapproxleastsqNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqNode::sum(self : MathapproxleastsqNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqNode::mean(self : MathapproxleastsqNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqNode::scale(
  self : MathapproxleastsqNode,
  f : Double,
) -> MathapproxleastsqNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqNode::add(
  self : MathapproxleastsqNode,
  other : MathapproxleastsqNode,
) -> MathapproxleastsqNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqNode::copy(
  self : MathapproxleastsqNode,
) -> MathapproxleastsqNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqNode::fill(
  self : MathapproxleastsqNode,
  v : Double,
) -> MathapproxleastsqNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqNode::min(self : MathapproxleastsqNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqNode::max(self : MathapproxleastsqNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqNode::to_string(self : MathapproxleastsqNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_edge_make(size : Int32) -> MathapproxleastsqEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqEdge::len(self : MathapproxleastsqEdge) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqEdge::get(
  self : MathapproxleastsqEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqEdge::set(
  self : MathapproxleastsqEdge,
  i : Int32,
  v : Double,
) -> MathapproxleastsqEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqEdge::sum(self : MathapproxleastsqEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqEdge::mean(self : MathapproxleastsqEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqEdge::scale(
  self : MathapproxleastsqEdge,
  f : Double,
) -> MathapproxleastsqEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqEdge::add(
  self : MathapproxleastsqEdge,
  other : MathapproxleastsqEdge,
) -> MathapproxleastsqEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqEdge::copy(
  self : MathapproxleastsqEdge,
) -> MathapproxleastsqEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqEdge::fill(
  self : MathapproxleastsqEdge,
  v : Double,
) -> MathapproxleastsqEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqEdge::min(self : MathapproxleastsqEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqEdge::max(self : MathapproxleastsqEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqEdge::to_string(self : MathapproxleastsqEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_path_make(size : Int32) -> MathapproxleastsqPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqPath::len(self : MathapproxleastsqPath) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqPath::get(
  self : MathapproxleastsqPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqPath::set(
  self : MathapproxleastsqPath,
  i : Int32,
  v : Double,
) -> MathapproxleastsqPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqPath::sum(self : MathapproxleastsqPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqPath::mean(self : MathapproxleastsqPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqPath::scale(
  self : MathapproxleastsqPath,
  f : Double,
) -> MathapproxleastsqPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqPath::add(
  self : MathapproxleastsqPath,
  other : MathapproxleastsqPath,
) -> MathapproxleastsqPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqPath::copy(
  self : MathapproxleastsqPath,
) -> MathapproxleastsqPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqPath::fill(
  self : MathapproxleastsqPath,
  v : Double,
) -> MathapproxleastsqPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqPath::min(self : MathapproxleastsqPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqPath::max(self : MathapproxleastsqPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqPath::to_string(self : MathapproxleastsqPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_cluster_make(
  size : Int32,
) -> MathapproxleastsqCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqCluster::len(self : MathapproxleastsqCluster) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqCluster::get(
  self : MathapproxleastsqCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqCluster::set(
  self : MathapproxleastsqCluster,
  i : Int32,
  v : Double,
) -> MathapproxleastsqCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqCluster::sum(self : MathapproxleastsqCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqCluster::mean(
  self : MathapproxleastsqCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqCluster::scale(
  self : MathapproxleastsqCluster,
  f : Double,
) -> MathapproxleastsqCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqCluster::add(
  self : MathapproxleastsqCluster,
  other : MathapproxleastsqCluster,
) -> MathapproxleastsqCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqCluster::copy(
  self : MathapproxleastsqCluster,
) -> MathapproxleastsqCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqCluster::fill(
  self : MathapproxleastsqCluster,
  v : Double,
) -> MathapproxleastsqCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqCluster::min(self : MathapproxleastsqCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqCluster::max(self : MathapproxleastsqCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqCluster::to_string(
  self : MathapproxleastsqCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_model_make(size : Int32) -> MathapproxleastsqModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqModel::len(self : MathapproxleastsqModel) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqModel::get(
  self : MathapproxleastsqModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqModel::set(
  self : MathapproxleastsqModel,
  i : Int32,
  v : Double,
) -> MathapproxleastsqModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqModel::sum(self : MathapproxleastsqModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqModel::mean(self : MathapproxleastsqModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqModel::scale(
  self : MathapproxleastsqModel,
  f : Double,
) -> MathapproxleastsqModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqModel::add(
  self : MathapproxleastsqModel,
  other : MathapproxleastsqModel,
) -> MathapproxleastsqModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqModel::copy(
  self : MathapproxleastsqModel,
) -> MathapproxleastsqModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqModel::fill(
  self : MathapproxleastsqModel,
  v : Double,
) -> MathapproxleastsqModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqModel::min(self : MathapproxleastsqModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqModel::max(self : MathapproxleastsqModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqModel::to_string(
  self : MathapproxleastsqModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_layer_make(size : Int32) -> MathapproxleastsqLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqLayer::len(self : MathapproxleastsqLayer) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqLayer::get(
  self : MathapproxleastsqLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqLayer::set(
  self : MathapproxleastsqLayer,
  i : Int32,
  v : Double,
) -> MathapproxleastsqLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqLayer::sum(self : MathapproxleastsqLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqLayer::mean(self : MathapproxleastsqLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqLayer::scale(
  self : MathapproxleastsqLayer,
  f : Double,
) -> MathapproxleastsqLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqLayer::add(
  self : MathapproxleastsqLayer,
  other : MathapproxleastsqLayer,
) -> MathapproxleastsqLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqLayer::copy(
  self : MathapproxleastsqLayer,
) -> MathapproxleastsqLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqLayer::fill(
  self : MathapproxleastsqLayer,
  v : Double,
) -> MathapproxleastsqLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqLayer::min(self : MathapproxleastsqLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqLayer::max(self : MathapproxleastsqLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqLayer::to_string(
  self : MathapproxleastsqLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_buffer_make(
  size : Int32,
) -> MathapproxleastsqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqBuffer::len(self : MathapproxleastsqBuffer) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqBuffer::get(
  self : MathapproxleastsqBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqBuffer::set(
  self : MathapproxleastsqBuffer,
  i : Int32,
  v : Double,
) -> MathapproxleastsqBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqBuffer::sum(self : MathapproxleastsqBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqBuffer::mean(self : MathapproxleastsqBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqBuffer::scale(
  self : MathapproxleastsqBuffer,
  f : Double,
) -> MathapproxleastsqBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqBuffer::add(
  self : MathapproxleastsqBuffer,
  other : MathapproxleastsqBuffer,
) -> MathapproxleastsqBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqBuffer::copy(
  self : MathapproxleastsqBuffer,
) -> MathapproxleastsqBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqBuffer::fill(
  self : MathapproxleastsqBuffer,
  v : Double,
) -> MathapproxleastsqBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqBuffer::min(self : MathapproxleastsqBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqBuffer::max(self : MathapproxleastsqBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqBuffer::to_string(
  self : MathapproxleastsqBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_cursor_make(
  size : Int32,
) -> MathapproxleastsqCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqCursor::len(self : MathapproxleastsqCursor) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqCursor::get(
  self : MathapproxleastsqCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqCursor::set(
  self : MathapproxleastsqCursor,
  i : Int32,
  v : Double,
) -> MathapproxleastsqCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqCursor::sum(self : MathapproxleastsqCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqCursor::mean(self : MathapproxleastsqCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqCursor::scale(
  self : MathapproxleastsqCursor,
  f : Double,
) -> MathapproxleastsqCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqCursor::add(
  self : MathapproxleastsqCursor,
  other : MathapproxleastsqCursor,
) -> MathapproxleastsqCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqCursor::copy(
  self : MathapproxleastsqCursor,
) -> MathapproxleastsqCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqCursor::fill(
  self : MathapproxleastsqCursor,
  v : Double,
) -> MathapproxleastsqCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqCursor::min(self : MathapproxleastsqCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqCursor::max(self : MathapproxleastsqCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqCursor::to_string(
  self : MathapproxleastsqCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_view_make(size : Int32) -> MathapproxleastsqView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqView::len(self : MathapproxleastsqView) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqView::get(
  self : MathapproxleastsqView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqView::set(
  self : MathapproxleastsqView,
  i : Int32,
  v : Double,
) -> MathapproxleastsqView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqView::sum(self : MathapproxleastsqView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqView::mean(self : MathapproxleastsqView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqView::scale(
  self : MathapproxleastsqView,
  f : Double,
) -> MathapproxleastsqView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqView::add(
  self : MathapproxleastsqView,
  other : MathapproxleastsqView,
) -> MathapproxleastsqView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqView::copy(
  self : MathapproxleastsqView,
) -> MathapproxleastsqView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqView::fill(
  self : MathapproxleastsqView,
  v : Double,
) -> MathapproxleastsqView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqView::min(self : MathapproxleastsqView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqView::max(self : MathapproxleastsqView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqView::to_string(self : MathapproxleastsqView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_range_make(size : Int32) -> MathapproxleastsqRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqRange::len(self : MathapproxleastsqRange) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqRange::get(
  self : MathapproxleastsqRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqRange::set(
  self : MathapproxleastsqRange,
  i : Int32,
  v : Double,
) -> MathapproxleastsqRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqRange::sum(self : MathapproxleastsqRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqRange::mean(self : MathapproxleastsqRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqRange::scale(
  self : MathapproxleastsqRange,
  f : Double,
) -> MathapproxleastsqRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqRange::add(
  self : MathapproxleastsqRange,
  other : MathapproxleastsqRange,
) -> MathapproxleastsqRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqRange::copy(
  self : MathapproxleastsqRange,
) -> MathapproxleastsqRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqRange::fill(
  self : MathapproxleastsqRange,
  v : Double,
) -> MathapproxleastsqRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqRange::min(self : MathapproxleastsqRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqRange::max(self : MathapproxleastsqRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqRange::to_string(
  self : MathapproxleastsqRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathapproxleastsqSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_approx_least_sq_slice_make(size : Int32) -> MathapproxleastsqSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathapproxleastsqSlice::len(self : MathapproxleastsqSlice) -> Int32 {
  self.size
}

///|
pub fn MathapproxleastsqSlice::get(
  self : MathapproxleastsqSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathapproxleastsqSlice::set(
  self : MathapproxleastsqSlice,
  i : Int32,
  v : Double,
) -> MathapproxleastsqSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqSlice::sum(self : MathapproxleastsqSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathapproxleastsqSlice::mean(self : MathapproxleastsqSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathapproxleastsqSlice::scale(
  self : MathapproxleastsqSlice,
  f : Double,
) -> MathapproxleastsqSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqSlice::add(
  self : MathapproxleastsqSlice,
  other : MathapproxleastsqSlice,
) -> MathapproxleastsqSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathapproxleastsqSlice::copy(
  self : MathapproxleastsqSlice,
) -> MathapproxleastsqSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqSlice::fill(
  self : MathapproxleastsqSlice,
  v : Double,
) -> MathapproxleastsqSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathapproxleastsqSlice::min(self : MathapproxleastsqSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathapproxleastsqSlice::max(self : MathapproxleastsqSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathapproxleastsqSlice::to_string(
  self : MathapproxleastsqSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
