///|
///===
/// extcore/math_special_hypergeo
pub(all) struct MathspecialhypergeoPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn math_special_hypergeo_make_point(
  x : Double,
  y : Double,
) -> MathspecialhypergeoPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn math_special_hypergeo_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MathspecialhypergeoPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MathspecialhypergeoPoint::x(self : MathspecialhypergeoPoint) -> Double {
  self.x
}

///|
pub fn MathspecialhypergeoPoint::y(self : MathspecialhypergeoPoint) -> Double {
  self.y
}

///|
pub fn MathspecialhypergeoPoint::z(self : MathspecialhypergeoPoint) -> Double {
  self.z
}

///|
pub fn MathspecialhypergeoPoint::label(
  self : MathspecialhypergeoPoint,
) -> Int32 {
  self.label
}

///|
pub fn MathspecialhypergeoPoint::dist(
  self : MathspecialhypergeoPoint,
  other : MathspecialhypergeoPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MathspecialhypergeoPoint::add(
  self : MathspecialhypergeoPoint,
  other : MathspecialhypergeoPoint,
) -> MathspecialhypergeoPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MathspecialhypergeoPoint::sub(
  self : MathspecialhypergeoPoint,
  other : MathspecialhypergeoPoint,
) -> MathspecialhypergeoPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MathspecialhypergeoPoint::scale(
  self : MathspecialhypergeoPoint,
  s : Double,
) -> MathspecialhypergeoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MathspecialhypergeoPoint::dot(
  self : MathspecialhypergeoPoint,
  other : MathspecialhypergeoPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MathspecialhypergeoPoint::cross(
  self : MathspecialhypergeoPoint,
  other : MathspecialhypergeoPoint,
) -> MathspecialhypergeoPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MathspecialhypergeoPoint::norm(
  self : MathspecialhypergeoPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MathspecialhypergeoPoint::normalize(
  self : MathspecialhypergeoPoint,
) -> MathspecialhypergeoPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathspecialhypergeoPoint::negate(
  self : MathspecialhypergeoPoint,
) -> MathspecialhypergeoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MathspecialhypergeoPoint::mid(
  self : MathspecialhypergeoPoint,
  other : MathspecialhypergeoPoint,
) -> MathspecialhypergeoPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MathspecialhypergeoPoint::lerp(
  self : MathspecialhypergeoPoint,
  other : MathspecialhypergeoPoint,
  t : Double,
) -> MathspecialhypergeoPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MathspecialhypergeoPoint::to_string(
  self : MathspecialhypergeoPoint,
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
pub(all) struct MathspecialhypergeoSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn math_special_hypergeo_make_series(
  vals : Array[Double],
  name : String,
) -> MathspecialhypergeoSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MathspecialhypergeoSeries::len(
  self : MathspecialhypergeoSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn MathspecialhypergeoSeries::sum(
  self : MathspecialhypergeoSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MathspecialhypergeoSeries::mean(
  self : MathspecialhypergeoSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MathspecialhypergeoSeries::min(
  self : MathspecialhypergeoSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MathspecialhypergeoSeries::max(
  self : MathspecialhypergeoSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MathspecialhypergeoSeries::range(
  self : MathspecialhypergeoSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MathspecialhypergeoSeries::variance(
  self : MathspecialhypergeoSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MathspecialhypergeoSeries::std(
  self : MathspecialhypergeoSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MathspecialhypergeoSeries::median(
  self : MathspecialhypergeoSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MathspecialhypergeoSeries::scale(
  self : MathspecialhypergeoSeries,
  f : Double,
) -> MathspecialhypergeoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MathspecialhypergeoSeries::add(
  self : MathspecialhypergeoSeries,
  other : MathspecialhypergeoSeries,
) -> MathspecialhypergeoSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathspecialhypergeoSeries::sub(
  self : MathspecialhypergeoSeries,
  other : MathspecialhypergeoSeries,
) -> MathspecialhypergeoSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathspecialhypergeoSeries::normalize(
  self : MathspecialhypergeoSeries,
) -> MathspecialhypergeoSeries {
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
pub fn MathspecialhypergeoSeries::cumsum(
  self : MathspecialhypergeoSeries,
) -> MathspecialhypergeoSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MathspecialhypergeoSeries::to_string(
  self : MathspecialhypergeoSeries,
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
pub(all) struct MathspecialhypergeoMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn math_special_hypergeo_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MathspecialhypergeoMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn math_special_hypergeo_matrix_identity(
  n : Int32,
) -> MathspecialhypergeoMatrix {
  let m = math_special_hypergeo_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MathspecialhypergeoMatrix::get(
  self : MathspecialhypergeoMatrix,
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
pub fn MathspecialhypergeoMatrix::transpose(
  self : MathspecialhypergeoMatrix,
) -> MathspecialhypergeoMatrix {
  let result = math_special_hypergeo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MathspecialhypergeoMatrix::add(
  self : MathspecialhypergeoMatrix,
  other : MathspecialhypergeoMatrix,
) -> MathspecialhypergeoMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = math_special_hypergeo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MathspecialhypergeoMatrix::scale(
  self : MathspecialhypergeoMatrix,
  s : Double,
) -> MathspecialhypergeoMatrix {
  let result = math_special_hypergeo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MathspecialhypergeoMatrix::multiply(
  self : MathspecialhypergeoMatrix,
  other : MathspecialhypergeoMatrix,
) -> MathspecialhypergeoMatrix {
  if self.cols != other.rows {
    return math_special_hypergeo_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = math_special_hypergeo_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MathspecialhypergeoMatrix::trace(
  self : MathspecialhypergeoMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MathspecialhypergeoMatrix::det(
  self : MathspecialhypergeoMatrix,
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
pub fn MathspecialhypergeoMatrix::norm(
  self : MathspecialhypergeoMatrix,
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
pub fn MathspecialhypergeoMatrix::to_string(
  self : MathspecialhypergeoMatrix,
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
pub(all) struct MathspecialhypergeoVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn math_special_hypergeo_make_vector(
  comps : Array[Double],
) -> MathspecialhypergeoVector {
  { comps, dim: comps.length(), }
}

///|
pub fn math_special_hypergeo_vector_zero(
  dim : Int32,
) -> MathspecialhypergeoVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MathspecialhypergeoVector::add(
  self : MathspecialhypergeoVector,
  other : MathspecialhypergeoVector,
) -> MathspecialhypergeoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathspecialhypergeoVector::sub(
  self : MathspecialhypergeoVector,
  other : MathspecialhypergeoVector,
) -> MathspecialhypergeoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathspecialhypergeoVector::scale(
  self : MathspecialhypergeoVector,
  s : Double,
) -> MathspecialhypergeoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MathspecialhypergeoVector::dot(
  self : MathspecialhypergeoVector,
  other : MathspecialhypergeoVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MathspecialhypergeoVector::norm(
  self : MathspecialhypergeoVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MathspecialhypergeoVector::normalize(
  self : MathspecialhypergeoVector,
) -> MathspecialhypergeoVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathspecialhypergeoVector::dist(
  self : MathspecialhypergeoVector,
  other : MathspecialhypergeoVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MathspecialhypergeoVector::to_string(
  self : MathspecialhypergeoVector,
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
pub(all) struct MathspecialhypergeoFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_frame_make(
  size : Int32,
) -> MathspecialhypergeoFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoFrame::len(self : MathspecialhypergeoFrame) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoFrame::get(
  self : MathspecialhypergeoFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoFrame::set(
  self : MathspecialhypergeoFrame,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoFrame::sum(self : MathspecialhypergeoFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoFrame::mean(
  self : MathspecialhypergeoFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoFrame::scale(
  self : MathspecialhypergeoFrame,
  f : Double,
) -> MathspecialhypergeoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoFrame::add(
  self : MathspecialhypergeoFrame,
  other : MathspecialhypergeoFrame,
) -> MathspecialhypergeoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoFrame::copy(
  self : MathspecialhypergeoFrame,
) -> MathspecialhypergeoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoFrame::fill(
  self : MathspecialhypergeoFrame,
  v : Double,
) -> MathspecialhypergeoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoFrame::min(self : MathspecialhypergeoFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoFrame::max(self : MathspecialhypergeoFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoFrame::to_string(
  self : MathspecialhypergeoFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_table_make(
  size : Int32,
) -> MathspecialhypergeoTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoTable::len(self : MathspecialhypergeoTable) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoTable::get(
  self : MathspecialhypergeoTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoTable::set(
  self : MathspecialhypergeoTable,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoTable::sum(self : MathspecialhypergeoTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoTable::mean(
  self : MathspecialhypergeoTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoTable::scale(
  self : MathspecialhypergeoTable,
  f : Double,
) -> MathspecialhypergeoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoTable::add(
  self : MathspecialhypergeoTable,
  other : MathspecialhypergeoTable,
) -> MathspecialhypergeoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoTable::copy(
  self : MathspecialhypergeoTable,
) -> MathspecialhypergeoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoTable::fill(
  self : MathspecialhypergeoTable,
  v : Double,
) -> MathspecialhypergeoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoTable::min(self : MathspecialhypergeoTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoTable::max(self : MathspecialhypergeoTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoTable::to_string(
  self : MathspecialhypergeoTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_graphn_make(
  size : Int32,
) -> MathspecialhypergeoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoGraphN::len(
  self : MathspecialhypergeoGraphN,
) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoGraphN::get(
  self : MathspecialhypergeoGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoGraphN::set(
  self : MathspecialhypergeoGraphN,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoGraphN::sum(
  self : MathspecialhypergeoGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoGraphN::mean(
  self : MathspecialhypergeoGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoGraphN::scale(
  self : MathspecialhypergeoGraphN,
  f : Double,
) -> MathspecialhypergeoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoGraphN::add(
  self : MathspecialhypergeoGraphN,
  other : MathspecialhypergeoGraphN,
) -> MathspecialhypergeoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoGraphN::copy(
  self : MathspecialhypergeoGraphN,
) -> MathspecialhypergeoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoGraphN::fill(
  self : MathspecialhypergeoGraphN,
  v : Double,
) -> MathspecialhypergeoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoGraphN::min(
  self : MathspecialhypergeoGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoGraphN::max(
  self : MathspecialhypergeoGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoGraphN::to_string(
  self : MathspecialhypergeoGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_node_make(size : Int32) -> MathspecialhypergeoNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoNode::len(self : MathspecialhypergeoNode) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoNode::get(
  self : MathspecialhypergeoNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoNode::set(
  self : MathspecialhypergeoNode,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoNode::sum(self : MathspecialhypergeoNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoNode::mean(self : MathspecialhypergeoNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoNode::scale(
  self : MathspecialhypergeoNode,
  f : Double,
) -> MathspecialhypergeoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoNode::add(
  self : MathspecialhypergeoNode,
  other : MathspecialhypergeoNode,
) -> MathspecialhypergeoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoNode::copy(
  self : MathspecialhypergeoNode,
) -> MathspecialhypergeoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoNode::fill(
  self : MathspecialhypergeoNode,
  v : Double,
) -> MathspecialhypergeoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoNode::min(self : MathspecialhypergeoNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoNode::max(self : MathspecialhypergeoNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoNode::to_string(
  self : MathspecialhypergeoNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_edge_make(size : Int32) -> MathspecialhypergeoEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoEdge::len(self : MathspecialhypergeoEdge) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoEdge::get(
  self : MathspecialhypergeoEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoEdge::set(
  self : MathspecialhypergeoEdge,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoEdge::sum(self : MathspecialhypergeoEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoEdge::mean(self : MathspecialhypergeoEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoEdge::scale(
  self : MathspecialhypergeoEdge,
  f : Double,
) -> MathspecialhypergeoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoEdge::add(
  self : MathspecialhypergeoEdge,
  other : MathspecialhypergeoEdge,
) -> MathspecialhypergeoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoEdge::copy(
  self : MathspecialhypergeoEdge,
) -> MathspecialhypergeoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoEdge::fill(
  self : MathspecialhypergeoEdge,
  v : Double,
) -> MathspecialhypergeoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoEdge::min(self : MathspecialhypergeoEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoEdge::max(self : MathspecialhypergeoEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoEdge::to_string(
  self : MathspecialhypergeoEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_path_make(size : Int32) -> MathspecialhypergeoPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoPath::len(self : MathspecialhypergeoPath) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoPath::get(
  self : MathspecialhypergeoPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoPath::set(
  self : MathspecialhypergeoPath,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoPath::sum(self : MathspecialhypergeoPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoPath::mean(self : MathspecialhypergeoPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoPath::scale(
  self : MathspecialhypergeoPath,
  f : Double,
) -> MathspecialhypergeoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoPath::add(
  self : MathspecialhypergeoPath,
  other : MathspecialhypergeoPath,
) -> MathspecialhypergeoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoPath::copy(
  self : MathspecialhypergeoPath,
) -> MathspecialhypergeoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoPath::fill(
  self : MathspecialhypergeoPath,
  v : Double,
) -> MathspecialhypergeoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoPath::min(self : MathspecialhypergeoPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoPath::max(self : MathspecialhypergeoPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoPath::to_string(
  self : MathspecialhypergeoPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_cluster_make(
  size : Int32,
) -> MathspecialhypergeoCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoCluster::len(
  self : MathspecialhypergeoCluster,
) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoCluster::get(
  self : MathspecialhypergeoCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoCluster::set(
  self : MathspecialhypergeoCluster,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoCluster::sum(
  self : MathspecialhypergeoCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoCluster::mean(
  self : MathspecialhypergeoCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoCluster::scale(
  self : MathspecialhypergeoCluster,
  f : Double,
) -> MathspecialhypergeoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoCluster::add(
  self : MathspecialhypergeoCluster,
  other : MathspecialhypergeoCluster,
) -> MathspecialhypergeoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoCluster::copy(
  self : MathspecialhypergeoCluster,
) -> MathspecialhypergeoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoCluster::fill(
  self : MathspecialhypergeoCluster,
  v : Double,
) -> MathspecialhypergeoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoCluster::min(
  self : MathspecialhypergeoCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoCluster::max(
  self : MathspecialhypergeoCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoCluster::to_string(
  self : MathspecialhypergeoCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_model_make(
  size : Int32,
) -> MathspecialhypergeoModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoModel::len(self : MathspecialhypergeoModel) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoModel::get(
  self : MathspecialhypergeoModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoModel::set(
  self : MathspecialhypergeoModel,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoModel::sum(self : MathspecialhypergeoModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoModel::mean(
  self : MathspecialhypergeoModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoModel::scale(
  self : MathspecialhypergeoModel,
  f : Double,
) -> MathspecialhypergeoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoModel::add(
  self : MathspecialhypergeoModel,
  other : MathspecialhypergeoModel,
) -> MathspecialhypergeoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoModel::copy(
  self : MathspecialhypergeoModel,
) -> MathspecialhypergeoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoModel::fill(
  self : MathspecialhypergeoModel,
  v : Double,
) -> MathspecialhypergeoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoModel::min(self : MathspecialhypergeoModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoModel::max(self : MathspecialhypergeoModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoModel::to_string(
  self : MathspecialhypergeoModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_layer_make(
  size : Int32,
) -> MathspecialhypergeoLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoLayer::len(self : MathspecialhypergeoLayer) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoLayer::get(
  self : MathspecialhypergeoLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoLayer::set(
  self : MathspecialhypergeoLayer,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoLayer::sum(self : MathspecialhypergeoLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoLayer::mean(
  self : MathspecialhypergeoLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoLayer::scale(
  self : MathspecialhypergeoLayer,
  f : Double,
) -> MathspecialhypergeoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoLayer::add(
  self : MathspecialhypergeoLayer,
  other : MathspecialhypergeoLayer,
) -> MathspecialhypergeoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoLayer::copy(
  self : MathspecialhypergeoLayer,
) -> MathspecialhypergeoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoLayer::fill(
  self : MathspecialhypergeoLayer,
  v : Double,
) -> MathspecialhypergeoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoLayer::min(self : MathspecialhypergeoLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoLayer::max(self : MathspecialhypergeoLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoLayer::to_string(
  self : MathspecialhypergeoLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_buffer_make(
  size : Int32,
) -> MathspecialhypergeoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoBuffer::len(
  self : MathspecialhypergeoBuffer,
) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoBuffer::get(
  self : MathspecialhypergeoBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoBuffer::set(
  self : MathspecialhypergeoBuffer,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoBuffer::sum(
  self : MathspecialhypergeoBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoBuffer::mean(
  self : MathspecialhypergeoBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoBuffer::scale(
  self : MathspecialhypergeoBuffer,
  f : Double,
) -> MathspecialhypergeoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoBuffer::add(
  self : MathspecialhypergeoBuffer,
  other : MathspecialhypergeoBuffer,
) -> MathspecialhypergeoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoBuffer::copy(
  self : MathspecialhypergeoBuffer,
) -> MathspecialhypergeoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoBuffer::fill(
  self : MathspecialhypergeoBuffer,
  v : Double,
) -> MathspecialhypergeoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoBuffer::min(
  self : MathspecialhypergeoBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoBuffer::max(
  self : MathspecialhypergeoBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoBuffer::to_string(
  self : MathspecialhypergeoBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_cursor_make(
  size : Int32,
) -> MathspecialhypergeoCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoCursor::len(
  self : MathspecialhypergeoCursor,
) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoCursor::get(
  self : MathspecialhypergeoCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoCursor::set(
  self : MathspecialhypergeoCursor,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoCursor::sum(
  self : MathspecialhypergeoCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoCursor::mean(
  self : MathspecialhypergeoCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoCursor::scale(
  self : MathspecialhypergeoCursor,
  f : Double,
) -> MathspecialhypergeoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoCursor::add(
  self : MathspecialhypergeoCursor,
  other : MathspecialhypergeoCursor,
) -> MathspecialhypergeoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoCursor::copy(
  self : MathspecialhypergeoCursor,
) -> MathspecialhypergeoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoCursor::fill(
  self : MathspecialhypergeoCursor,
  v : Double,
) -> MathspecialhypergeoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoCursor::min(
  self : MathspecialhypergeoCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoCursor::max(
  self : MathspecialhypergeoCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoCursor::to_string(
  self : MathspecialhypergeoCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_view_make(size : Int32) -> MathspecialhypergeoView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoView::len(self : MathspecialhypergeoView) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoView::get(
  self : MathspecialhypergeoView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoView::set(
  self : MathspecialhypergeoView,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoView::sum(self : MathspecialhypergeoView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoView::mean(self : MathspecialhypergeoView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoView::scale(
  self : MathspecialhypergeoView,
  f : Double,
) -> MathspecialhypergeoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoView::add(
  self : MathspecialhypergeoView,
  other : MathspecialhypergeoView,
) -> MathspecialhypergeoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoView::copy(
  self : MathspecialhypergeoView,
) -> MathspecialhypergeoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoView::fill(
  self : MathspecialhypergeoView,
  v : Double,
) -> MathspecialhypergeoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoView::min(self : MathspecialhypergeoView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoView::max(self : MathspecialhypergeoView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoView::to_string(
  self : MathspecialhypergeoView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_range_make(
  size : Int32,
) -> MathspecialhypergeoRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoRange::len(self : MathspecialhypergeoRange) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoRange::get(
  self : MathspecialhypergeoRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoRange::set(
  self : MathspecialhypergeoRange,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoRange::sum(self : MathspecialhypergeoRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoRange::mean(
  self : MathspecialhypergeoRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoRange::scale(
  self : MathspecialhypergeoRange,
  f : Double,
) -> MathspecialhypergeoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoRange::add(
  self : MathspecialhypergeoRange,
  other : MathspecialhypergeoRange,
) -> MathspecialhypergeoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoRange::copy(
  self : MathspecialhypergeoRange,
) -> MathspecialhypergeoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoRange::fill(
  self : MathspecialhypergeoRange,
  v : Double,
) -> MathspecialhypergeoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoRange::min(self : MathspecialhypergeoRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoRange::max(self : MathspecialhypergeoRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoRange::to_string(
  self : MathspecialhypergeoRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialhypergeoSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_hypergeo_slice_make(
  size : Int32,
) -> MathspecialhypergeoSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialhypergeoSlice::len(self : MathspecialhypergeoSlice) -> Int32 {
  self.size
}

///|
pub fn MathspecialhypergeoSlice::get(
  self : MathspecialhypergeoSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialhypergeoSlice::set(
  self : MathspecialhypergeoSlice,
  i : Int32,
  v : Double,
) -> MathspecialhypergeoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoSlice::sum(self : MathspecialhypergeoSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialhypergeoSlice::mean(
  self : MathspecialhypergeoSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialhypergeoSlice::scale(
  self : MathspecialhypergeoSlice,
  f : Double,
) -> MathspecialhypergeoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoSlice::add(
  self : MathspecialhypergeoSlice,
  other : MathspecialhypergeoSlice,
) -> MathspecialhypergeoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoSlice::copy(
  self : MathspecialhypergeoSlice,
) -> MathspecialhypergeoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoSlice::fill(
  self : MathspecialhypergeoSlice,
  v : Double,
) -> MathspecialhypergeoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialhypergeoSlice::min(self : MathspecialhypergeoSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialhypergeoSlice::max(self : MathspecialhypergeoSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialhypergeoSlice::to_string(
  self : MathspecialhypergeoSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
