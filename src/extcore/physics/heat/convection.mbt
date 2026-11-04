///|
///===
/// extcore/physics_heat_convection
pub(all) struct PhysicsheatconvectionPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn physics_heat_convection_make_point(
  x : Double,
  y : Double,
) -> PhysicsheatconvectionPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn physics_heat_convection_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> PhysicsheatconvectionPoint {
  { x, y, z, label: 0, }
}

///|
pub fn PhysicsheatconvectionPoint::x(
  self : PhysicsheatconvectionPoint,
) -> Double {
  self.x
}

///|
pub fn PhysicsheatconvectionPoint::y(
  self : PhysicsheatconvectionPoint,
) -> Double {
  self.y
}

///|
pub fn PhysicsheatconvectionPoint::z(
  self : PhysicsheatconvectionPoint,
) -> Double {
  self.z
}

///|
pub fn PhysicsheatconvectionPoint::label(
  self : PhysicsheatconvectionPoint,
) -> Int32 {
  self.label
}

///|
pub fn PhysicsheatconvectionPoint::dist(
  self : PhysicsheatconvectionPoint,
  other : PhysicsheatconvectionPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn PhysicsheatconvectionPoint::add(
  self : PhysicsheatconvectionPoint,
  other : PhysicsheatconvectionPoint,
) -> PhysicsheatconvectionPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsheatconvectionPoint::sub(
  self : PhysicsheatconvectionPoint,
  other : PhysicsheatconvectionPoint,
) -> PhysicsheatconvectionPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsheatconvectionPoint::scale(
  self : PhysicsheatconvectionPoint,
  s : Double,
) -> PhysicsheatconvectionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn PhysicsheatconvectionPoint::dot(
  self : PhysicsheatconvectionPoint,
  other : PhysicsheatconvectionPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn PhysicsheatconvectionPoint::cross(
  self : PhysicsheatconvectionPoint,
  other : PhysicsheatconvectionPoint,
) -> PhysicsheatconvectionPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn PhysicsheatconvectionPoint::norm(
  self : PhysicsheatconvectionPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn PhysicsheatconvectionPoint::normalize(
  self : PhysicsheatconvectionPoint,
) -> PhysicsheatconvectionPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsheatconvectionPoint::negate(
  self : PhysicsheatconvectionPoint,
) -> PhysicsheatconvectionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn PhysicsheatconvectionPoint::mid(
  self : PhysicsheatconvectionPoint,
  other : PhysicsheatconvectionPoint,
) -> PhysicsheatconvectionPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn PhysicsheatconvectionPoint::lerp(
  self : PhysicsheatconvectionPoint,
  other : PhysicsheatconvectionPoint,
  t : Double,
) -> PhysicsheatconvectionPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn PhysicsheatconvectionPoint::to_string(
  self : PhysicsheatconvectionPoint,
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
pub(all) struct PhysicsheatconvectionSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn physics_heat_convection_make_series(
  vals : Array[Double],
  name : String,
) -> PhysicsheatconvectionSeries {
  { vals, name, meta: 0, }
}

///|
pub fn PhysicsheatconvectionSeries::len(
  self : PhysicsheatconvectionSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn PhysicsheatconvectionSeries::sum(
  self : PhysicsheatconvectionSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn PhysicsheatconvectionSeries::mean(
  self : PhysicsheatconvectionSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn PhysicsheatconvectionSeries::min(
  self : PhysicsheatconvectionSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn PhysicsheatconvectionSeries::max(
  self : PhysicsheatconvectionSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn PhysicsheatconvectionSeries::range(
  self : PhysicsheatconvectionSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn PhysicsheatconvectionSeries::variance(
  self : PhysicsheatconvectionSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn PhysicsheatconvectionSeries::std(
  self : PhysicsheatconvectionSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn PhysicsheatconvectionSeries::median(
  self : PhysicsheatconvectionSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn PhysicsheatconvectionSeries::scale(
  self : PhysicsheatconvectionSeries,
  f : Double,
) -> PhysicsheatconvectionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn PhysicsheatconvectionSeries::add(
  self : PhysicsheatconvectionSeries,
  other : PhysicsheatconvectionSeries,
) -> PhysicsheatconvectionSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsheatconvectionSeries::sub(
  self : PhysicsheatconvectionSeries,
  other : PhysicsheatconvectionSeries,
) -> PhysicsheatconvectionSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsheatconvectionSeries::normalize(
  self : PhysicsheatconvectionSeries,
) -> PhysicsheatconvectionSeries {
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
pub fn PhysicsheatconvectionSeries::cumsum(
  self : PhysicsheatconvectionSeries,
) -> PhysicsheatconvectionSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn PhysicsheatconvectionSeries::to_string(
  self : PhysicsheatconvectionSeries,
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
pub(all) struct PhysicsheatconvectionMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn physics_heat_convection_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> PhysicsheatconvectionMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn physics_heat_convection_matrix_identity(
  n : Int32,
) -> PhysicsheatconvectionMatrix {
  let m = physics_heat_convection_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn PhysicsheatconvectionMatrix::get(
  self : PhysicsheatconvectionMatrix,
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
pub fn PhysicsheatconvectionMatrix::transpose(
  self : PhysicsheatconvectionMatrix,
) -> PhysicsheatconvectionMatrix {
  let result = physics_heat_convection_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsheatconvectionMatrix::add(
  self : PhysicsheatconvectionMatrix,
  other : PhysicsheatconvectionMatrix,
) -> PhysicsheatconvectionMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = physics_heat_convection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsheatconvectionMatrix::scale(
  self : PhysicsheatconvectionMatrix,
  s : Double,
) -> PhysicsheatconvectionMatrix {
  let result = physics_heat_convection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn PhysicsheatconvectionMatrix::multiply(
  self : PhysicsheatconvectionMatrix,
  other : PhysicsheatconvectionMatrix,
) -> PhysicsheatconvectionMatrix {
  if self.cols != other.rows {
    return physics_heat_convection_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = physics_heat_convection_make_matrix(self.rows, other.cols, 0.0)
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
pub fn PhysicsheatconvectionMatrix::trace(
  self : PhysicsheatconvectionMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn PhysicsheatconvectionMatrix::det(
  self : PhysicsheatconvectionMatrix,
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
pub fn PhysicsheatconvectionMatrix::norm(
  self : PhysicsheatconvectionMatrix,
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
pub fn PhysicsheatconvectionMatrix::to_string(
  self : PhysicsheatconvectionMatrix,
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
pub(all) struct PhysicsheatconvectionVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn physics_heat_convection_make_vector(
  comps : Array[Double],
) -> PhysicsheatconvectionVector {
  { comps, dim: comps.length(), }
}

///|
pub fn physics_heat_convection_vector_zero(
  dim : Int32,
) -> PhysicsheatconvectionVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn PhysicsheatconvectionVector::add(
  self : PhysicsheatconvectionVector,
  other : PhysicsheatconvectionVector,
) -> PhysicsheatconvectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsheatconvectionVector::sub(
  self : PhysicsheatconvectionVector,
  other : PhysicsheatconvectionVector,
) -> PhysicsheatconvectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsheatconvectionVector::scale(
  self : PhysicsheatconvectionVector,
  s : Double,
) -> PhysicsheatconvectionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn PhysicsheatconvectionVector::dot(
  self : PhysicsheatconvectionVector,
  other : PhysicsheatconvectionVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn PhysicsheatconvectionVector::norm(
  self : PhysicsheatconvectionVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn PhysicsheatconvectionVector::normalize(
  self : PhysicsheatconvectionVector,
) -> PhysicsheatconvectionVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsheatconvectionVector::dist(
  self : PhysicsheatconvectionVector,
  other : PhysicsheatconvectionVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn PhysicsheatconvectionVector::to_string(
  self : PhysicsheatconvectionVector,
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
pub(all) struct PhysicsheatconvectionFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_frame_make(
  size : Int32,
) -> PhysicsheatconvectionFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionFrame::len(
  self : PhysicsheatconvectionFrame,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionFrame::get(
  self : PhysicsheatconvectionFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionFrame::set(
  self : PhysicsheatconvectionFrame,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionFrame::sum(
  self : PhysicsheatconvectionFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionFrame::mean(
  self : PhysicsheatconvectionFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionFrame::scale(
  self : PhysicsheatconvectionFrame,
  f : Double,
) -> PhysicsheatconvectionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionFrame::add(
  self : PhysicsheatconvectionFrame,
  other : PhysicsheatconvectionFrame,
) -> PhysicsheatconvectionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionFrame::copy(
  self : PhysicsheatconvectionFrame,
) -> PhysicsheatconvectionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionFrame::fill(
  self : PhysicsheatconvectionFrame,
  v : Double,
) -> PhysicsheatconvectionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionFrame::min(
  self : PhysicsheatconvectionFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionFrame::max(
  self : PhysicsheatconvectionFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionFrame::to_string(
  self : PhysicsheatconvectionFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_table_make(
  size : Int32,
) -> PhysicsheatconvectionTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionTable::len(
  self : PhysicsheatconvectionTable,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionTable::get(
  self : PhysicsheatconvectionTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionTable::set(
  self : PhysicsheatconvectionTable,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionTable::sum(
  self : PhysicsheatconvectionTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionTable::mean(
  self : PhysicsheatconvectionTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionTable::scale(
  self : PhysicsheatconvectionTable,
  f : Double,
) -> PhysicsheatconvectionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionTable::add(
  self : PhysicsheatconvectionTable,
  other : PhysicsheatconvectionTable,
) -> PhysicsheatconvectionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionTable::copy(
  self : PhysicsheatconvectionTable,
) -> PhysicsheatconvectionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionTable::fill(
  self : PhysicsheatconvectionTable,
  v : Double,
) -> PhysicsheatconvectionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionTable::min(
  self : PhysicsheatconvectionTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionTable::max(
  self : PhysicsheatconvectionTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionTable::to_string(
  self : PhysicsheatconvectionTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_graphn_make(
  size : Int32,
) -> PhysicsheatconvectionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionGraphN::len(
  self : PhysicsheatconvectionGraphN,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionGraphN::get(
  self : PhysicsheatconvectionGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionGraphN::set(
  self : PhysicsheatconvectionGraphN,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionGraphN::sum(
  self : PhysicsheatconvectionGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionGraphN::mean(
  self : PhysicsheatconvectionGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionGraphN::scale(
  self : PhysicsheatconvectionGraphN,
  f : Double,
) -> PhysicsheatconvectionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionGraphN::add(
  self : PhysicsheatconvectionGraphN,
  other : PhysicsheatconvectionGraphN,
) -> PhysicsheatconvectionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionGraphN::copy(
  self : PhysicsheatconvectionGraphN,
) -> PhysicsheatconvectionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionGraphN::fill(
  self : PhysicsheatconvectionGraphN,
  v : Double,
) -> PhysicsheatconvectionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionGraphN::min(
  self : PhysicsheatconvectionGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionGraphN::max(
  self : PhysicsheatconvectionGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionGraphN::to_string(
  self : PhysicsheatconvectionGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_node_make(
  size : Int32,
) -> PhysicsheatconvectionNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionNode::len(
  self : PhysicsheatconvectionNode,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionNode::get(
  self : PhysicsheatconvectionNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionNode::set(
  self : PhysicsheatconvectionNode,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionNode::sum(
  self : PhysicsheatconvectionNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionNode::mean(
  self : PhysicsheatconvectionNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionNode::scale(
  self : PhysicsheatconvectionNode,
  f : Double,
) -> PhysicsheatconvectionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionNode::add(
  self : PhysicsheatconvectionNode,
  other : PhysicsheatconvectionNode,
) -> PhysicsheatconvectionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionNode::copy(
  self : PhysicsheatconvectionNode,
) -> PhysicsheatconvectionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionNode::fill(
  self : PhysicsheatconvectionNode,
  v : Double,
) -> PhysicsheatconvectionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionNode::min(
  self : PhysicsheatconvectionNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionNode::max(
  self : PhysicsheatconvectionNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionNode::to_string(
  self : PhysicsheatconvectionNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_edge_make(
  size : Int32,
) -> PhysicsheatconvectionEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionEdge::len(
  self : PhysicsheatconvectionEdge,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionEdge::get(
  self : PhysicsheatconvectionEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionEdge::set(
  self : PhysicsheatconvectionEdge,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionEdge::sum(
  self : PhysicsheatconvectionEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionEdge::mean(
  self : PhysicsheatconvectionEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionEdge::scale(
  self : PhysicsheatconvectionEdge,
  f : Double,
) -> PhysicsheatconvectionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionEdge::add(
  self : PhysicsheatconvectionEdge,
  other : PhysicsheatconvectionEdge,
) -> PhysicsheatconvectionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionEdge::copy(
  self : PhysicsheatconvectionEdge,
) -> PhysicsheatconvectionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionEdge::fill(
  self : PhysicsheatconvectionEdge,
  v : Double,
) -> PhysicsheatconvectionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionEdge::min(
  self : PhysicsheatconvectionEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionEdge::max(
  self : PhysicsheatconvectionEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionEdge::to_string(
  self : PhysicsheatconvectionEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_path_make(
  size : Int32,
) -> PhysicsheatconvectionPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionPath::len(
  self : PhysicsheatconvectionPath,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionPath::get(
  self : PhysicsheatconvectionPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionPath::set(
  self : PhysicsheatconvectionPath,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionPath::sum(
  self : PhysicsheatconvectionPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionPath::mean(
  self : PhysicsheatconvectionPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionPath::scale(
  self : PhysicsheatconvectionPath,
  f : Double,
) -> PhysicsheatconvectionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionPath::add(
  self : PhysicsheatconvectionPath,
  other : PhysicsheatconvectionPath,
) -> PhysicsheatconvectionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionPath::copy(
  self : PhysicsheatconvectionPath,
) -> PhysicsheatconvectionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionPath::fill(
  self : PhysicsheatconvectionPath,
  v : Double,
) -> PhysicsheatconvectionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionPath::min(
  self : PhysicsheatconvectionPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionPath::max(
  self : PhysicsheatconvectionPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionPath::to_string(
  self : PhysicsheatconvectionPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_cluster_make(
  size : Int32,
) -> PhysicsheatconvectionCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionCluster::len(
  self : PhysicsheatconvectionCluster,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionCluster::get(
  self : PhysicsheatconvectionCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionCluster::set(
  self : PhysicsheatconvectionCluster,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionCluster::sum(
  self : PhysicsheatconvectionCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionCluster::mean(
  self : PhysicsheatconvectionCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionCluster::scale(
  self : PhysicsheatconvectionCluster,
  f : Double,
) -> PhysicsheatconvectionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionCluster::add(
  self : PhysicsheatconvectionCluster,
  other : PhysicsheatconvectionCluster,
) -> PhysicsheatconvectionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionCluster::copy(
  self : PhysicsheatconvectionCluster,
) -> PhysicsheatconvectionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionCluster::fill(
  self : PhysicsheatconvectionCluster,
  v : Double,
) -> PhysicsheatconvectionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionCluster::min(
  self : PhysicsheatconvectionCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionCluster::max(
  self : PhysicsheatconvectionCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionCluster::to_string(
  self : PhysicsheatconvectionCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_model_make(
  size : Int32,
) -> PhysicsheatconvectionModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionModel::len(
  self : PhysicsheatconvectionModel,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionModel::get(
  self : PhysicsheatconvectionModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionModel::set(
  self : PhysicsheatconvectionModel,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionModel::sum(
  self : PhysicsheatconvectionModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionModel::mean(
  self : PhysicsheatconvectionModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionModel::scale(
  self : PhysicsheatconvectionModel,
  f : Double,
) -> PhysicsheatconvectionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionModel::add(
  self : PhysicsheatconvectionModel,
  other : PhysicsheatconvectionModel,
) -> PhysicsheatconvectionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionModel::copy(
  self : PhysicsheatconvectionModel,
) -> PhysicsheatconvectionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionModel::fill(
  self : PhysicsheatconvectionModel,
  v : Double,
) -> PhysicsheatconvectionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionModel::min(
  self : PhysicsheatconvectionModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionModel::max(
  self : PhysicsheatconvectionModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionModel::to_string(
  self : PhysicsheatconvectionModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_layer_make(
  size : Int32,
) -> PhysicsheatconvectionLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionLayer::len(
  self : PhysicsheatconvectionLayer,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionLayer::get(
  self : PhysicsheatconvectionLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionLayer::set(
  self : PhysicsheatconvectionLayer,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionLayer::sum(
  self : PhysicsheatconvectionLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionLayer::mean(
  self : PhysicsheatconvectionLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionLayer::scale(
  self : PhysicsheatconvectionLayer,
  f : Double,
) -> PhysicsheatconvectionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionLayer::add(
  self : PhysicsheatconvectionLayer,
  other : PhysicsheatconvectionLayer,
) -> PhysicsheatconvectionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionLayer::copy(
  self : PhysicsheatconvectionLayer,
) -> PhysicsheatconvectionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionLayer::fill(
  self : PhysicsheatconvectionLayer,
  v : Double,
) -> PhysicsheatconvectionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionLayer::min(
  self : PhysicsheatconvectionLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionLayer::max(
  self : PhysicsheatconvectionLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionLayer::to_string(
  self : PhysicsheatconvectionLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_buffer_make(
  size : Int32,
) -> PhysicsheatconvectionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionBuffer::len(
  self : PhysicsheatconvectionBuffer,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionBuffer::get(
  self : PhysicsheatconvectionBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionBuffer::set(
  self : PhysicsheatconvectionBuffer,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionBuffer::sum(
  self : PhysicsheatconvectionBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionBuffer::mean(
  self : PhysicsheatconvectionBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionBuffer::scale(
  self : PhysicsheatconvectionBuffer,
  f : Double,
) -> PhysicsheatconvectionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionBuffer::add(
  self : PhysicsheatconvectionBuffer,
  other : PhysicsheatconvectionBuffer,
) -> PhysicsheatconvectionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionBuffer::copy(
  self : PhysicsheatconvectionBuffer,
) -> PhysicsheatconvectionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionBuffer::fill(
  self : PhysicsheatconvectionBuffer,
  v : Double,
) -> PhysicsheatconvectionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionBuffer::min(
  self : PhysicsheatconvectionBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionBuffer::max(
  self : PhysicsheatconvectionBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionBuffer::to_string(
  self : PhysicsheatconvectionBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_cursor_make(
  size : Int32,
) -> PhysicsheatconvectionCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionCursor::len(
  self : PhysicsheatconvectionCursor,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionCursor::get(
  self : PhysicsheatconvectionCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionCursor::set(
  self : PhysicsheatconvectionCursor,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionCursor::sum(
  self : PhysicsheatconvectionCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionCursor::mean(
  self : PhysicsheatconvectionCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionCursor::scale(
  self : PhysicsheatconvectionCursor,
  f : Double,
) -> PhysicsheatconvectionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionCursor::add(
  self : PhysicsheatconvectionCursor,
  other : PhysicsheatconvectionCursor,
) -> PhysicsheatconvectionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionCursor::copy(
  self : PhysicsheatconvectionCursor,
) -> PhysicsheatconvectionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionCursor::fill(
  self : PhysicsheatconvectionCursor,
  v : Double,
) -> PhysicsheatconvectionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionCursor::min(
  self : PhysicsheatconvectionCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionCursor::max(
  self : PhysicsheatconvectionCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionCursor::to_string(
  self : PhysicsheatconvectionCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_view_make(
  size : Int32,
) -> PhysicsheatconvectionView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionView::len(
  self : PhysicsheatconvectionView,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionView::get(
  self : PhysicsheatconvectionView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionView::set(
  self : PhysicsheatconvectionView,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionView::sum(
  self : PhysicsheatconvectionView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionView::mean(
  self : PhysicsheatconvectionView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionView::scale(
  self : PhysicsheatconvectionView,
  f : Double,
) -> PhysicsheatconvectionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionView::add(
  self : PhysicsheatconvectionView,
  other : PhysicsheatconvectionView,
) -> PhysicsheatconvectionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionView::copy(
  self : PhysicsheatconvectionView,
) -> PhysicsheatconvectionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionView::fill(
  self : PhysicsheatconvectionView,
  v : Double,
) -> PhysicsheatconvectionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionView::min(
  self : PhysicsheatconvectionView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionView::max(
  self : PhysicsheatconvectionView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionView::to_string(
  self : PhysicsheatconvectionView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_range_make(
  size : Int32,
) -> PhysicsheatconvectionRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionRange::len(
  self : PhysicsheatconvectionRange,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionRange::get(
  self : PhysicsheatconvectionRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionRange::set(
  self : PhysicsheatconvectionRange,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionRange::sum(
  self : PhysicsheatconvectionRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionRange::mean(
  self : PhysicsheatconvectionRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionRange::scale(
  self : PhysicsheatconvectionRange,
  f : Double,
) -> PhysicsheatconvectionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionRange::add(
  self : PhysicsheatconvectionRange,
  other : PhysicsheatconvectionRange,
) -> PhysicsheatconvectionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionRange::copy(
  self : PhysicsheatconvectionRange,
) -> PhysicsheatconvectionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionRange::fill(
  self : PhysicsheatconvectionRange,
  v : Double,
) -> PhysicsheatconvectionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionRange::min(
  self : PhysicsheatconvectionRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionRange::max(
  self : PhysicsheatconvectionRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionRange::to_string(
  self : PhysicsheatconvectionRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsheatconvectionSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_heat_convection_slice_make(
  size : Int32,
) -> PhysicsheatconvectionSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsheatconvectionSlice::len(
  self : PhysicsheatconvectionSlice,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsheatconvectionSlice::get(
  self : PhysicsheatconvectionSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsheatconvectionSlice::set(
  self : PhysicsheatconvectionSlice,
  i : Int32,
  v : Double,
) -> PhysicsheatconvectionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionSlice::sum(
  self : PhysicsheatconvectionSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsheatconvectionSlice::mean(
  self : PhysicsheatconvectionSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsheatconvectionSlice::scale(
  self : PhysicsheatconvectionSlice,
  f : Double,
) -> PhysicsheatconvectionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionSlice::add(
  self : PhysicsheatconvectionSlice,
  other : PhysicsheatconvectionSlice,
) -> PhysicsheatconvectionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionSlice::copy(
  self : PhysicsheatconvectionSlice,
) -> PhysicsheatconvectionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionSlice::fill(
  self : PhysicsheatconvectionSlice,
  v : Double,
) -> PhysicsheatconvectionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsheatconvectionSlice::min(
  self : PhysicsheatconvectionSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsheatconvectionSlice::max(
  self : PhysicsheatconvectionSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsheatconvectionSlice::to_string(
  self : PhysicsheatconvectionSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
