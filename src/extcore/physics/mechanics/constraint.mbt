///|
///===
/// extcore/physics_mechanics_constraint
pub(all) struct PhysicsmechanicsconstraintPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn physics_mechanics_constraint_make_point(
  x : Double,
  y : Double,
) -> PhysicsmechanicsconstraintPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn physics_mechanics_constraint_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> PhysicsmechanicsconstraintPoint {
  { x, y, z, label: 0, }
}

///|
pub fn PhysicsmechanicsconstraintPoint::x(
  self : PhysicsmechanicsconstraintPoint,
) -> Double {
  self.x
}

///|
pub fn PhysicsmechanicsconstraintPoint::y(
  self : PhysicsmechanicsconstraintPoint,
) -> Double {
  self.y
}

///|
pub fn PhysicsmechanicsconstraintPoint::z(
  self : PhysicsmechanicsconstraintPoint,
) -> Double {
  self.z
}

///|
pub fn PhysicsmechanicsconstraintPoint::label(
  self : PhysicsmechanicsconstraintPoint,
) -> Int32 {
  self.label
}

///|
pub fn PhysicsmechanicsconstraintPoint::dist(
  self : PhysicsmechanicsconstraintPoint,
  other : PhysicsmechanicsconstraintPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn PhysicsmechanicsconstraintPoint::add(
  self : PhysicsmechanicsconstraintPoint,
  other : PhysicsmechanicsconstraintPoint,
) -> PhysicsmechanicsconstraintPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsmechanicsconstraintPoint::sub(
  self : PhysicsmechanicsconstraintPoint,
  other : PhysicsmechanicsconstraintPoint,
) -> PhysicsmechanicsconstraintPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsmechanicsconstraintPoint::scale(
  self : PhysicsmechanicsconstraintPoint,
  s : Double,
) -> PhysicsmechanicsconstraintPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn PhysicsmechanicsconstraintPoint::dot(
  self : PhysicsmechanicsconstraintPoint,
  other : PhysicsmechanicsconstraintPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn PhysicsmechanicsconstraintPoint::cross(
  self : PhysicsmechanicsconstraintPoint,
  other : PhysicsmechanicsconstraintPoint,
) -> PhysicsmechanicsconstraintPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn PhysicsmechanicsconstraintPoint::norm(
  self : PhysicsmechanicsconstraintPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn PhysicsmechanicsconstraintPoint::normalize(
  self : PhysicsmechanicsconstraintPoint,
) -> PhysicsmechanicsconstraintPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsmechanicsconstraintPoint::negate(
  self : PhysicsmechanicsconstraintPoint,
) -> PhysicsmechanicsconstraintPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn PhysicsmechanicsconstraintPoint::mid(
  self : PhysicsmechanicsconstraintPoint,
  other : PhysicsmechanicsconstraintPoint,
) -> PhysicsmechanicsconstraintPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn PhysicsmechanicsconstraintPoint::lerp(
  self : PhysicsmechanicsconstraintPoint,
  other : PhysicsmechanicsconstraintPoint,
  t : Double,
) -> PhysicsmechanicsconstraintPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn PhysicsmechanicsconstraintPoint::to_string(
  self : PhysicsmechanicsconstraintPoint,
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
pub(all) struct PhysicsmechanicsconstraintSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn physics_mechanics_constraint_make_series(
  vals : Array[Double],
  name : String,
) -> PhysicsmechanicsconstraintSeries {
  { vals, name, meta: 0, }
}

///|
pub fn PhysicsmechanicsconstraintSeries::len(
  self : PhysicsmechanicsconstraintSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn PhysicsmechanicsconstraintSeries::sum(
  self : PhysicsmechanicsconstraintSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn PhysicsmechanicsconstraintSeries::mean(
  self : PhysicsmechanicsconstraintSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn PhysicsmechanicsconstraintSeries::min(
  self : PhysicsmechanicsconstraintSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn PhysicsmechanicsconstraintSeries::max(
  self : PhysicsmechanicsconstraintSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn PhysicsmechanicsconstraintSeries::range(
  self : PhysicsmechanicsconstraintSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn PhysicsmechanicsconstraintSeries::variance(
  self : PhysicsmechanicsconstraintSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn PhysicsmechanicsconstraintSeries::std(
  self : PhysicsmechanicsconstraintSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn PhysicsmechanicsconstraintSeries::median(
  self : PhysicsmechanicsconstraintSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn PhysicsmechanicsconstraintSeries::scale(
  self : PhysicsmechanicsconstraintSeries,
  f : Double,
) -> PhysicsmechanicsconstraintSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn PhysicsmechanicsconstraintSeries::add(
  self : PhysicsmechanicsconstraintSeries,
  other : PhysicsmechanicsconstraintSeries,
) -> PhysicsmechanicsconstraintSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsmechanicsconstraintSeries::sub(
  self : PhysicsmechanicsconstraintSeries,
  other : PhysicsmechanicsconstraintSeries,
) -> PhysicsmechanicsconstraintSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsmechanicsconstraintSeries::normalize(
  self : PhysicsmechanicsconstraintSeries,
) -> PhysicsmechanicsconstraintSeries {
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
pub fn PhysicsmechanicsconstraintSeries::cumsum(
  self : PhysicsmechanicsconstraintSeries,
) -> PhysicsmechanicsconstraintSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn PhysicsmechanicsconstraintSeries::to_string(
  self : PhysicsmechanicsconstraintSeries,
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
pub(all) struct PhysicsmechanicsconstraintMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn physics_mechanics_constraint_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> PhysicsmechanicsconstraintMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn physics_mechanics_constraint_matrix_identity(
  n : Int32,
) -> PhysicsmechanicsconstraintMatrix {
  let m = physics_mechanics_constraint_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn PhysicsmechanicsconstraintMatrix::get(
  self : PhysicsmechanicsconstraintMatrix,
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
pub fn PhysicsmechanicsconstraintMatrix::transpose(
  self : PhysicsmechanicsconstraintMatrix,
) -> PhysicsmechanicsconstraintMatrix {
  let result = physics_mechanics_constraint_make_matrix(
    self.cols,
    self.rows,
    0.0,
  )
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsmechanicsconstraintMatrix::add(
  self : PhysicsmechanicsconstraintMatrix,
  other : PhysicsmechanicsconstraintMatrix,
) -> PhysicsmechanicsconstraintMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = physics_mechanics_constraint_make_matrix(
    self.rows,
    self.cols,
    0.0,
  )
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsmechanicsconstraintMatrix::scale(
  self : PhysicsmechanicsconstraintMatrix,
  s : Double,
) -> PhysicsmechanicsconstraintMatrix {
  let result = physics_mechanics_constraint_make_matrix(
    self.rows,
    self.cols,
    0.0,
  )
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn PhysicsmechanicsconstraintMatrix::multiply(
  self : PhysicsmechanicsconstraintMatrix,
  other : PhysicsmechanicsconstraintMatrix,
) -> PhysicsmechanicsconstraintMatrix {
  if self.cols != other.rows {
    return physics_mechanics_constraint_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = physics_mechanics_constraint_make_matrix(
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
pub fn PhysicsmechanicsconstraintMatrix::trace(
  self : PhysicsmechanicsconstraintMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn PhysicsmechanicsconstraintMatrix::det(
  self : PhysicsmechanicsconstraintMatrix,
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
pub fn PhysicsmechanicsconstraintMatrix::norm(
  self : PhysicsmechanicsconstraintMatrix,
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
pub fn PhysicsmechanicsconstraintMatrix::to_string(
  self : PhysicsmechanicsconstraintMatrix,
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
pub(all) struct PhysicsmechanicsconstraintVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn physics_mechanics_constraint_make_vector(
  comps : Array[Double],
) -> PhysicsmechanicsconstraintVector {
  { comps, dim: comps.length(), }
}

///|
pub fn physics_mechanics_constraint_vector_zero(
  dim : Int32,
) -> PhysicsmechanicsconstraintVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn PhysicsmechanicsconstraintVector::add(
  self : PhysicsmechanicsconstraintVector,
  other : PhysicsmechanicsconstraintVector,
) -> PhysicsmechanicsconstraintVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsmechanicsconstraintVector::sub(
  self : PhysicsmechanicsconstraintVector,
  other : PhysicsmechanicsconstraintVector,
) -> PhysicsmechanicsconstraintVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsmechanicsconstraintVector::scale(
  self : PhysicsmechanicsconstraintVector,
  s : Double,
) -> PhysicsmechanicsconstraintVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn PhysicsmechanicsconstraintVector::dot(
  self : PhysicsmechanicsconstraintVector,
  other : PhysicsmechanicsconstraintVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn PhysicsmechanicsconstraintVector::norm(
  self : PhysicsmechanicsconstraintVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn PhysicsmechanicsconstraintVector::normalize(
  self : PhysicsmechanicsconstraintVector,
) -> PhysicsmechanicsconstraintVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsmechanicsconstraintVector::dist(
  self : PhysicsmechanicsconstraintVector,
  other : PhysicsmechanicsconstraintVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn PhysicsmechanicsconstraintVector::to_string(
  self : PhysicsmechanicsconstraintVector,
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
pub(all) struct PhysicsmechanicsconstraintFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_frame_make(
  size : Int32,
) -> PhysicsmechanicsconstraintFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintFrame::len(
  self : PhysicsmechanicsconstraintFrame,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintFrame::get(
  self : PhysicsmechanicsconstraintFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintFrame::set(
  self : PhysicsmechanicsconstraintFrame,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintFrame::sum(
  self : PhysicsmechanicsconstraintFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintFrame::mean(
  self : PhysicsmechanicsconstraintFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintFrame::scale(
  self : PhysicsmechanicsconstraintFrame,
  f : Double,
) -> PhysicsmechanicsconstraintFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintFrame::add(
  self : PhysicsmechanicsconstraintFrame,
  other : PhysicsmechanicsconstraintFrame,
) -> PhysicsmechanicsconstraintFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintFrame::copy(
  self : PhysicsmechanicsconstraintFrame,
) -> PhysicsmechanicsconstraintFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintFrame::fill(
  self : PhysicsmechanicsconstraintFrame,
  v : Double,
) -> PhysicsmechanicsconstraintFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintFrame::min(
  self : PhysicsmechanicsconstraintFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintFrame::max(
  self : PhysicsmechanicsconstraintFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintFrame::to_string(
  self : PhysicsmechanicsconstraintFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_table_make(
  size : Int32,
) -> PhysicsmechanicsconstraintTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintTable::len(
  self : PhysicsmechanicsconstraintTable,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintTable::get(
  self : PhysicsmechanicsconstraintTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintTable::set(
  self : PhysicsmechanicsconstraintTable,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintTable::sum(
  self : PhysicsmechanicsconstraintTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintTable::mean(
  self : PhysicsmechanicsconstraintTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintTable::scale(
  self : PhysicsmechanicsconstraintTable,
  f : Double,
) -> PhysicsmechanicsconstraintTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintTable::add(
  self : PhysicsmechanicsconstraintTable,
  other : PhysicsmechanicsconstraintTable,
) -> PhysicsmechanicsconstraintTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintTable::copy(
  self : PhysicsmechanicsconstraintTable,
) -> PhysicsmechanicsconstraintTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintTable::fill(
  self : PhysicsmechanicsconstraintTable,
  v : Double,
) -> PhysicsmechanicsconstraintTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintTable::min(
  self : PhysicsmechanicsconstraintTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintTable::max(
  self : PhysicsmechanicsconstraintTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintTable::to_string(
  self : PhysicsmechanicsconstraintTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_graphn_make(
  size : Int32,
) -> PhysicsmechanicsconstraintGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintGraphN::len(
  self : PhysicsmechanicsconstraintGraphN,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintGraphN::get(
  self : PhysicsmechanicsconstraintGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintGraphN::set(
  self : PhysicsmechanicsconstraintGraphN,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintGraphN::sum(
  self : PhysicsmechanicsconstraintGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintGraphN::mean(
  self : PhysicsmechanicsconstraintGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintGraphN::scale(
  self : PhysicsmechanicsconstraintGraphN,
  f : Double,
) -> PhysicsmechanicsconstraintGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintGraphN::add(
  self : PhysicsmechanicsconstraintGraphN,
  other : PhysicsmechanicsconstraintGraphN,
) -> PhysicsmechanicsconstraintGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintGraphN::copy(
  self : PhysicsmechanicsconstraintGraphN,
) -> PhysicsmechanicsconstraintGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintGraphN::fill(
  self : PhysicsmechanicsconstraintGraphN,
  v : Double,
) -> PhysicsmechanicsconstraintGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintGraphN::min(
  self : PhysicsmechanicsconstraintGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintGraphN::max(
  self : PhysicsmechanicsconstraintGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintGraphN::to_string(
  self : PhysicsmechanicsconstraintGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_node_make(
  size : Int32,
) -> PhysicsmechanicsconstraintNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintNode::len(
  self : PhysicsmechanicsconstraintNode,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintNode::get(
  self : PhysicsmechanicsconstraintNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintNode::set(
  self : PhysicsmechanicsconstraintNode,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintNode::sum(
  self : PhysicsmechanicsconstraintNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintNode::mean(
  self : PhysicsmechanicsconstraintNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintNode::scale(
  self : PhysicsmechanicsconstraintNode,
  f : Double,
) -> PhysicsmechanicsconstraintNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintNode::add(
  self : PhysicsmechanicsconstraintNode,
  other : PhysicsmechanicsconstraintNode,
) -> PhysicsmechanicsconstraintNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintNode::copy(
  self : PhysicsmechanicsconstraintNode,
) -> PhysicsmechanicsconstraintNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintNode::fill(
  self : PhysicsmechanicsconstraintNode,
  v : Double,
) -> PhysicsmechanicsconstraintNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintNode::min(
  self : PhysicsmechanicsconstraintNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintNode::max(
  self : PhysicsmechanicsconstraintNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintNode::to_string(
  self : PhysicsmechanicsconstraintNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_edge_make(
  size : Int32,
) -> PhysicsmechanicsconstraintEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintEdge::len(
  self : PhysicsmechanicsconstraintEdge,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintEdge::get(
  self : PhysicsmechanicsconstraintEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintEdge::set(
  self : PhysicsmechanicsconstraintEdge,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintEdge::sum(
  self : PhysicsmechanicsconstraintEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintEdge::mean(
  self : PhysicsmechanicsconstraintEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintEdge::scale(
  self : PhysicsmechanicsconstraintEdge,
  f : Double,
) -> PhysicsmechanicsconstraintEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintEdge::add(
  self : PhysicsmechanicsconstraintEdge,
  other : PhysicsmechanicsconstraintEdge,
) -> PhysicsmechanicsconstraintEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintEdge::copy(
  self : PhysicsmechanicsconstraintEdge,
) -> PhysicsmechanicsconstraintEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintEdge::fill(
  self : PhysicsmechanicsconstraintEdge,
  v : Double,
) -> PhysicsmechanicsconstraintEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintEdge::min(
  self : PhysicsmechanicsconstraintEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintEdge::max(
  self : PhysicsmechanicsconstraintEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintEdge::to_string(
  self : PhysicsmechanicsconstraintEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_path_make(
  size : Int32,
) -> PhysicsmechanicsconstraintPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintPath::len(
  self : PhysicsmechanicsconstraintPath,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintPath::get(
  self : PhysicsmechanicsconstraintPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintPath::set(
  self : PhysicsmechanicsconstraintPath,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintPath::sum(
  self : PhysicsmechanicsconstraintPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintPath::mean(
  self : PhysicsmechanicsconstraintPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintPath::scale(
  self : PhysicsmechanicsconstraintPath,
  f : Double,
) -> PhysicsmechanicsconstraintPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintPath::add(
  self : PhysicsmechanicsconstraintPath,
  other : PhysicsmechanicsconstraintPath,
) -> PhysicsmechanicsconstraintPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintPath::copy(
  self : PhysicsmechanicsconstraintPath,
) -> PhysicsmechanicsconstraintPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintPath::fill(
  self : PhysicsmechanicsconstraintPath,
  v : Double,
) -> PhysicsmechanicsconstraintPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintPath::min(
  self : PhysicsmechanicsconstraintPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintPath::max(
  self : PhysicsmechanicsconstraintPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintPath::to_string(
  self : PhysicsmechanicsconstraintPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_cluster_make(
  size : Int32,
) -> PhysicsmechanicsconstraintCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintCluster::len(
  self : PhysicsmechanicsconstraintCluster,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintCluster::get(
  self : PhysicsmechanicsconstraintCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintCluster::set(
  self : PhysicsmechanicsconstraintCluster,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintCluster::sum(
  self : PhysicsmechanicsconstraintCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintCluster::mean(
  self : PhysicsmechanicsconstraintCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintCluster::scale(
  self : PhysicsmechanicsconstraintCluster,
  f : Double,
) -> PhysicsmechanicsconstraintCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintCluster::add(
  self : PhysicsmechanicsconstraintCluster,
  other : PhysicsmechanicsconstraintCluster,
) -> PhysicsmechanicsconstraintCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintCluster::copy(
  self : PhysicsmechanicsconstraintCluster,
) -> PhysicsmechanicsconstraintCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintCluster::fill(
  self : PhysicsmechanicsconstraintCluster,
  v : Double,
) -> PhysicsmechanicsconstraintCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintCluster::min(
  self : PhysicsmechanicsconstraintCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintCluster::max(
  self : PhysicsmechanicsconstraintCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintCluster::to_string(
  self : PhysicsmechanicsconstraintCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_model_make(
  size : Int32,
) -> PhysicsmechanicsconstraintModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintModel::len(
  self : PhysicsmechanicsconstraintModel,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintModel::get(
  self : PhysicsmechanicsconstraintModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintModel::set(
  self : PhysicsmechanicsconstraintModel,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintModel::sum(
  self : PhysicsmechanicsconstraintModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintModel::mean(
  self : PhysicsmechanicsconstraintModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintModel::scale(
  self : PhysicsmechanicsconstraintModel,
  f : Double,
) -> PhysicsmechanicsconstraintModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintModel::add(
  self : PhysicsmechanicsconstraintModel,
  other : PhysicsmechanicsconstraintModel,
) -> PhysicsmechanicsconstraintModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintModel::copy(
  self : PhysicsmechanicsconstraintModel,
) -> PhysicsmechanicsconstraintModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintModel::fill(
  self : PhysicsmechanicsconstraintModel,
  v : Double,
) -> PhysicsmechanicsconstraintModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintModel::min(
  self : PhysicsmechanicsconstraintModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintModel::max(
  self : PhysicsmechanicsconstraintModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintModel::to_string(
  self : PhysicsmechanicsconstraintModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_layer_make(
  size : Int32,
) -> PhysicsmechanicsconstraintLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintLayer::len(
  self : PhysicsmechanicsconstraintLayer,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintLayer::get(
  self : PhysicsmechanicsconstraintLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintLayer::set(
  self : PhysicsmechanicsconstraintLayer,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintLayer::sum(
  self : PhysicsmechanicsconstraintLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintLayer::mean(
  self : PhysicsmechanicsconstraintLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintLayer::scale(
  self : PhysicsmechanicsconstraintLayer,
  f : Double,
) -> PhysicsmechanicsconstraintLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintLayer::add(
  self : PhysicsmechanicsconstraintLayer,
  other : PhysicsmechanicsconstraintLayer,
) -> PhysicsmechanicsconstraintLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintLayer::copy(
  self : PhysicsmechanicsconstraintLayer,
) -> PhysicsmechanicsconstraintLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintLayer::fill(
  self : PhysicsmechanicsconstraintLayer,
  v : Double,
) -> PhysicsmechanicsconstraintLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintLayer::min(
  self : PhysicsmechanicsconstraintLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintLayer::max(
  self : PhysicsmechanicsconstraintLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintLayer::to_string(
  self : PhysicsmechanicsconstraintLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_buffer_make(
  size : Int32,
) -> PhysicsmechanicsconstraintBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintBuffer::len(
  self : PhysicsmechanicsconstraintBuffer,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintBuffer::get(
  self : PhysicsmechanicsconstraintBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintBuffer::set(
  self : PhysicsmechanicsconstraintBuffer,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintBuffer::sum(
  self : PhysicsmechanicsconstraintBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintBuffer::mean(
  self : PhysicsmechanicsconstraintBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintBuffer::scale(
  self : PhysicsmechanicsconstraintBuffer,
  f : Double,
) -> PhysicsmechanicsconstraintBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintBuffer::add(
  self : PhysicsmechanicsconstraintBuffer,
  other : PhysicsmechanicsconstraintBuffer,
) -> PhysicsmechanicsconstraintBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintBuffer::copy(
  self : PhysicsmechanicsconstraintBuffer,
) -> PhysicsmechanicsconstraintBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintBuffer::fill(
  self : PhysicsmechanicsconstraintBuffer,
  v : Double,
) -> PhysicsmechanicsconstraintBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintBuffer::min(
  self : PhysicsmechanicsconstraintBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintBuffer::max(
  self : PhysicsmechanicsconstraintBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintBuffer::to_string(
  self : PhysicsmechanicsconstraintBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_cursor_make(
  size : Int32,
) -> PhysicsmechanicsconstraintCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintCursor::len(
  self : PhysicsmechanicsconstraintCursor,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintCursor::get(
  self : PhysicsmechanicsconstraintCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintCursor::set(
  self : PhysicsmechanicsconstraintCursor,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintCursor::sum(
  self : PhysicsmechanicsconstraintCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintCursor::mean(
  self : PhysicsmechanicsconstraintCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintCursor::scale(
  self : PhysicsmechanicsconstraintCursor,
  f : Double,
) -> PhysicsmechanicsconstraintCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintCursor::add(
  self : PhysicsmechanicsconstraintCursor,
  other : PhysicsmechanicsconstraintCursor,
) -> PhysicsmechanicsconstraintCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintCursor::copy(
  self : PhysicsmechanicsconstraintCursor,
) -> PhysicsmechanicsconstraintCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintCursor::fill(
  self : PhysicsmechanicsconstraintCursor,
  v : Double,
) -> PhysicsmechanicsconstraintCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintCursor::min(
  self : PhysicsmechanicsconstraintCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintCursor::max(
  self : PhysicsmechanicsconstraintCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintCursor::to_string(
  self : PhysicsmechanicsconstraintCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_view_make(
  size : Int32,
) -> PhysicsmechanicsconstraintView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintView::len(
  self : PhysicsmechanicsconstraintView,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintView::get(
  self : PhysicsmechanicsconstraintView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintView::set(
  self : PhysicsmechanicsconstraintView,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintView::sum(
  self : PhysicsmechanicsconstraintView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintView::mean(
  self : PhysicsmechanicsconstraintView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintView::scale(
  self : PhysicsmechanicsconstraintView,
  f : Double,
) -> PhysicsmechanicsconstraintView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintView::add(
  self : PhysicsmechanicsconstraintView,
  other : PhysicsmechanicsconstraintView,
) -> PhysicsmechanicsconstraintView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintView::copy(
  self : PhysicsmechanicsconstraintView,
) -> PhysicsmechanicsconstraintView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintView::fill(
  self : PhysicsmechanicsconstraintView,
  v : Double,
) -> PhysicsmechanicsconstraintView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintView::min(
  self : PhysicsmechanicsconstraintView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintView::max(
  self : PhysicsmechanicsconstraintView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintView::to_string(
  self : PhysicsmechanicsconstraintView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_range_make(
  size : Int32,
) -> PhysicsmechanicsconstraintRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintRange::len(
  self : PhysicsmechanicsconstraintRange,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintRange::get(
  self : PhysicsmechanicsconstraintRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintRange::set(
  self : PhysicsmechanicsconstraintRange,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintRange::sum(
  self : PhysicsmechanicsconstraintRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintRange::mean(
  self : PhysicsmechanicsconstraintRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintRange::scale(
  self : PhysicsmechanicsconstraintRange,
  f : Double,
) -> PhysicsmechanicsconstraintRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintRange::add(
  self : PhysicsmechanicsconstraintRange,
  other : PhysicsmechanicsconstraintRange,
) -> PhysicsmechanicsconstraintRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintRange::copy(
  self : PhysicsmechanicsconstraintRange,
) -> PhysicsmechanicsconstraintRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintRange::fill(
  self : PhysicsmechanicsconstraintRange,
  v : Double,
) -> PhysicsmechanicsconstraintRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintRange::min(
  self : PhysicsmechanicsconstraintRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintRange::max(
  self : PhysicsmechanicsconstraintRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintRange::to_string(
  self : PhysicsmechanicsconstraintRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsconstraintSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_constraint_slice_make(
  size : Int32,
) -> PhysicsmechanicsconstraintSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsconstraintSlice::len(
  self : PhysicsmechanicsconstraintSlice,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsconstraintSlice::get(
  self : PhysicsmechanicsconstraintSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsconstraintSlice::set(
  self : PhysicsmechanicsconstraintSlice,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsconstraintSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintSlice::sum(
  self : PhysicsmechanicsconstraintSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsconstraintSlice::mean(
  self : PhysicsmechanicsconstraintSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsconstraintSlice::scale(
  self : PhysicsmechanicsconstraintSlice,
  f : Double,
) -> PhysicsmechanicsconstraintSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintSlice::add(
  self : PhysicsmechanicsconstraintSlice,
  other : PhysicsmechanicsconstraintSlice,
) -> PhysicsmechanicsconstraintSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintSlice::copy(
  self : PhysicsmechanicsconstraintSlice,
) -> PhysicsmechanicsconstraintSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintSlice::fill(
  self : PhysicsmechanicsconstraintSlice,
  v : Double,
) -> PhysicsmechanicsconstraintSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsconstraintSlice::min(
  self : PhysicsmechanicsconstraintSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsconstraintSlice::max(
  self : PhysicsmechanicsconstraintSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsconstraintSlice::to_string(
  self : PhysicsmechanicsconstraintSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
