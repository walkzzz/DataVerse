///|
///===
/// extcore/physics_mechanics_energy
pub(all) struct PhysicsmechanicsenergyPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn physics_mechanics_energy_make_point(
  x : Double,
  y : Double,
) -> PhysicsmechanicsenergyPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn physics_mechanics_energy_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> PhysicsmechanicsenergyPoint {
  { x, y, z, label: 0, }
}

///|
pub fn PhysicsmechanicsenergyPoint::x(
  self : PhysicsmechanicsenergyPoint,
) -> Double {
  self.x
}

///|
pub fn PhysicsmechanicsenergyPoint::y(
  self : PhysicsmechanicsenergyPoint,
) -> Double {
  self.y
}

///|
pub fn PhysicsmechanicsenergyPoint::z(
  self : PhysicsmechanicsenergyPoint,
) -> Double {
  self.z
}

///|
pub fn PhysicsmechanicsenergyPoint::label(
  self : PhysicsmechanicsenergyPoint,
) -> Int32 {
  self.label
}

///|
pub fn PhysicsmechanicsenergyPoint::dist(
  self : PhysicsmechanicsenergyPoint,
  other : PhysicsmechanicsenergyPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn PhysicsmechanicsenergyPoint::add(
  self : PhysicsmechanicsenergyPoint,
  other : PhysicsmechanicsenergyPoint,
) -> PhysicsmechanicsenergyPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsmechanicsenergyPoint::sub(
  self : PhysicsmechanicsenergyPoint,
  other : PhysicsmechanicsenergyPoint,
) -> PhysicsmechanicsenergyPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsmechanicsenergyPoint::scale(
  self : PhysicsmechanicsenergyPoint,
  s : Double,
) -> PhysicsmechanicsenergyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn PhysicsmechanicsenergyPoint::dot(
  self : PhysicsmechanicsenergyPoint,
  other : PhysicsmechanicsenergyPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn PhysicsmechanicsenergyPoint::cross(
  self : PhysicsmechanicsenergyPoint,
  other : PhysicsmechanicsenergyPoint,
) -> PhysicsmechanicsenergyPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn PhysicsmechanicsenergyPoint::norm(
  self : PhysicsmechanicsenergyPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn PhysicsmechanicsenergyPoint::normalize(
  self : PhysicsmechanicsenergyPoint,
) -> PhysicsmechanicsenergyPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsmechanicsenergyPoint::negate(
  self : PhysicsmechanicsenergyPoint,
) -> PhysicsmechanicsenergyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn PhysicsmechanicsenergyPoint::mid(
  self : PhysicsmechanicsenergyPoint,
  other : PhysicsmechanicsenergyPoint,
) -> PhysicsmechanicsenergyPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn PhysicsmechanicsenergyPoint::lerp(
  self : PhysicsmechanicsenergyPoint,
  other : PhysicsmechanicsenergyPoint,
  t : Double,
) -> PhysicsmechanicsenergyPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn PhysicsmechanicsenergyPoint::to_string(
  self : PhysicsmechanicsenergyPoint,
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
pub(all) struct PhysicsmechanicsenergySeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn physics_mechanics_energy_make_series(
  vals : Array[Double],
  name : String,
) -> PhysicsmechanicsenergySeries {
  { vals, name, meta: 0, }
}

///|
pub fn PhysicsmechanicsenergySeries::len(
  self : PhysicsmechanicsenergySeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn PhysicsmechanicsenergySeries::sum(
  self : PhysicsmechanicsenergySeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn PhysicsmechanicsenergySeries::mean(
  self : PhysicsmechanicsenergySeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn PhysicsmechanicsenergySeries::min(
  self : PhysicsmechanicsenergySeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn PhysicsmechanicsenergySeries::max(
  self : PhysicsmechanicsenergySeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn PhysicsmechanicsenergySeries::range(
  self : PhysicsmechanicsenergySeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn PhysicsmechanicsenergySeries::variance(
  self : PhysicsmechanicsenergySeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn PhysicsmechanicsenergySeries::std(
  self : PhysicsmechanicsenergySeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn PhysicsmechanicsenergySeries::median(
  self : PhysicsmechanicsenergySeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn PhysicsmechanicsenergySeries::scale(
  self : PhysicsmechanicsenergySeries,
  f : Double,
) -> PhysicsmechanicsenergySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn PhysicsmechanicsenergySeries::add(
  self : PhysicsmechanicsenergySeries,
  other : PhysicsmechanicsenergySeries,
) -> PhysicsmechanicsenergySeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsmechanicsenergySeries::sub(
  self : PhysicsmechanicsenergySeries,
  other : PhysicsmechanicsenergySeries,
) -> PhysicsmechanicsenergySeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsmechanicsenergySeries::normalize(
  self : PhysicsmechanicsenergySeries,
) -> PhysicsmechanicsenergySeries {
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
pub fn PhysicsmechanicsenergySeries::cumsum(
  self : PhysicsmechanicsenergySeries,
) -> PhysicsmechanicsenergySeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn PhysicsmechanicsenergySeries::to_string(
  self : PhysicsmechanicsenergySeries,
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
pub(all) struct PhysicsmechanicsenergyMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn physics_mechanics_energy_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> PhysicsmechanicsenergyMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn physics_mechanics_energy_matrix_identity(
  n : Int32,
) -> PhysicsmechanicsenergyMatrix {
  let m = physics_mechanics_energy_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn PhysicsmechanicsenergyMatrix::get(
  self : PhysicsmechanicsenergyMatrix,
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
pub fn PhysicsmechanicsenergyMatrix::transpose(
  self : PhysicsmechanicsenergyMatrix,
) -> PhysicsmechanicsenergyMatrix {
  let result = physics_mechanics_energy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsmechanicsenergyMatrix::add(
  self : PhysicsmechanicsenergyMatrix,
  other : PhysicsmechanicsenergyMatrix,
) -> PhysicsmechanicsenergyMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = physics_mechanics_energy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsmechanicsenergyMatrix::scale(
  self : PhysicsmechanicsenergyMatrix,
  s : Double,
) -> PhysicsmechanicsenergyMatrix {
  let result = physics_mechanics_energy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn PhysicsmechanicsenergyMatrix::multiply(
  self : PhysicsmechanicsenergyMatrix,
  other : PhysicsmechanicsenergyMatrix,
) -> PhysicsmechanicsenergyMatrix {
  if self.cols != other.rows {
    return physics_mechanics_energy_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = physics_mechanics_energy_make_matrix(self.rows, other.cols, 0.0)
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
pub fn PhysicsmechanicsenergyMatrix::trace(
  self : PhysicsmechanicsenergyMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn PhysicsmechanicsenergyMatrix::det(
  self : PhysicsmechanicsenergyMatrix,
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
pub fn PhysicsmechanicsenergyMatrix::norm(
  self : PhysicsmechanicsenergyMatrix,
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
pub fn PhysicsmechanicsenergyMatrix::to_string(
  self : PhysicsmechanicsenergyMatrix,
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
pub(all) struct PhysicsmechanicsenergyVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn physics_mechanics_energy_make_vector(
  comps : Array[Double],
) -> PhysicsmechanicsenergyVector {
  { comps, dim: comps.length(), }
}

///|
pub fn physics_mechanics_energy_vector_zero(
  dim : Int32,
) -> PhysicsmechanicsenergyVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn PhysicsmechanicsenergyVector::add(
  self : PhysicsmechanicsenergyVector,
  other : PhysicsmechanicsenergyVector,
) -> PhysicsmechanicsenergyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsmechanicsenergyVector::sub(
  self : PhysicsmechanicsenergyVector,
  other : PhysicsmechanicsenergyVector,
) -> PhysicsmechanicsenergyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsmechanicsenergyVector::scale(
  self : PhysicsmechanicsenergyVector,
  s : Double,
) -> PhysicsmechanicsenergyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn PhysicsmechanicsenergyVector::dot(
  self : PhysicsmechanicsenergyVector,
  other : PhysicsmechanicsenergyVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn PhysicsmechanicsenergyVector::norm(
  self : PhysicsmechanicsenergyVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn PhysicsmechanicsenergyVector::normalize(
  self : PhysicsmechanicsenergyVector,
) -> PhysicsmechanicsenergyVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsmechanicsenergyVector::dist(
  self : PhysicsmechanicsenergyVector,
  other : PhysicsmechanicsenergyVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn PhysicsmechanicsenergyVector::to_string(
  self : PhysicsmechanicsenergyVector,
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
pub(all) struct PhysicsmechanicsenergyFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_frame_make(
  size : Int32,
) -> PhysicsmechanicsenergyFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyFrame::len(
  self : PhysicsmechanicsenergyFrame,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyFrame::get(
  self : PhysicsmechanicsenergyFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyFrame::set(
  self : PhysicsmechanicsenergyFrame,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyFrame::sum(
  self : PhysicsmechanicsenergyFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyFrame::mean(
  self : PhysicsmechanicsenergyFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyFrame::scale(
  self : PhysicsmechanicsenergyFrame,
  f : Double,
) -> PhysicsmechanicsenergyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyFrame::add(
  self : PhysicsmechanicsenergyFrame,
  other : PhysicsmechanicsenergyFrame,
) -> PhysicsmechanicsenergyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyFrame::copy(
  self : PhysicsmechanicsenergyFrame,
) -> PhysicsmechanicsenergyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyFrame::fill(
  self : PhysicsmechanicsenergyFrame,
  v : Double,
) -> PhysicsmechanicsenergyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyFrame::min(
  self : PhysicsmechanicsenergyFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyFrame::max(
  self : PhysicsmechanicsenergyFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyFrame::to_string(
  self : PhysicsmechanicsenergyFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_table_make(
  size : Int32,
) -> PhysicsmechanicsenergyTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyTable::len(
  self : PhysicsmechanicsenergyTable,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyTable::get(
  self : PhysicsmechanicsenergyTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyTable::set(
  self : PhysicsmechanicsenergyTable,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyTable::sum(
  self : PhysicsmechanicsenergyTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyTable::mean(
  self : PhysicsmechanicsenergyTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyTable::scale(
  self : PhysicsmechanicsenergyTable,
  f : Double,
) -> PhysicsmechanicsenergyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyTable::add(
  self : PhysicsmechanicsenergyTable,
  other : PhysicsmechanicsenergyTable,
) -> PhysicsmechanicsenergyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyTable::copy(
  self : PhysicsmechanicsenergyTable,
) -> PhysicsmechanicsenergyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyTable::fill(
  self : PhysicsmechanicsenergyTable,
  v : Double,
) -> PhysicsmechanicsenergyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyTable::min(
  self : PhysicsmechanicsenergyTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyTable::max(
  self : PhysicsmechanicsenergyTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyTable::to_string(
  self : PhysicsmechanicsenergyTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_graphn_make(
  size : Int32,
) -> PhysicsmechanicsenergyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyGraphN::len(
  self : PhysicsmechanicsenergyGraphN,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyGraphN::get(
  self : PhysicsmechanicsenergyGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyGraphN::set(
  self : PhysicsmechanicsenergyGraphN,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyGraphN::sum(
  self : PhysicsmechanicsenergyGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyGraphN::mean(
  self : PhysicsmechanicsenergyGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyGraphN::scale(
  self : PhysicsmechanicsenergyGraphN,
  f : Double,
) -> PhysicsmechanicsenergyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyGraphN::add(
  self : PhysicsmechanicsenergyGraphN,
  other : PhysicsmechanicsenergyGraphN,
) -> PhysicsmechanicsenergyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyGraphN::copy(
  self : PhysicsmechanicsenergyGraphN,
) -> PhysicsmechanicsenergyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyGraphN::fill(
  self : PhysicsmechanicsenergyGraphN,
  v : Double,
) -> PhysicsmechanicsenergyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyGraphN::min(
  self : PhysicsmechanicsenergyGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyGraphN::max(
  self : PhysicsmechanicsenergyGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyGraphN::to_string(
  self : PhysicsmechanicsenergyGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_node_make(
  size : Int32,
) -> PhysicsmechanicsenergyNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyNode::len(
  self : PhysicsmechanicsenergyNode,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyNode::get(
  self : PhysicsmechanicsenergyNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyNode::set(
  self : PhysicsmechanicsenergyNode,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyNode::sum(
  self : PhysicsmechanicsenergyNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyNode::mean(
  self : PhysicsmechanicsenergyNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyNode::scale(
  self : PhysicsmechanicsenergyNode,
  f : Double,
) -> PhysicsmechanicsenergyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyNode::add(
  self : PhysicsmechanicsenergyNode,
  other : PhysicsmechanicsenergyNode,
) -> PhysicsmechanicsenergyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyNode::copy(
  self : PhysicsmechanicsenergyNode,
) -> PhysicsmechanicsenergyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyNode::fill(
  self : PhysicsmechanicsenergyNode,
  v : Double,
) -> PhysicsmechanicsenergyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyNode::min(
  self : PhysicsmechanicsenergyNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyNode::max(
  self : PhysicsmechanicsenergyNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyNode::to_string(
  self : PhysicsmechanicsenergyNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_edge_make(
  size : Int32,
) -> PhysicsmechanicsenergyEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyEdge::len(
  self : PhysicsmechanicsenergyEdge,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyEdge::get(
  self : PhysicsmechanicsenergyEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyEdge::set(
  self : PhysicsmechanicsenergyEdge,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyEdge::sum(
  self : PhysicsmechanicsenergyEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyEdge::mean(
  self : PhysicsmechanicsenergyEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyEdge::scale(
  self : PhysicsmechanicsenergyEdge,
  f : Double,
) -> PhysicsmechanicsenergyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyEdge::add(
  self : PhysicsmechanicsenergyEdge,
  other : PhysicsmechanicsenergyEdge,
) -> PhysicsmechanicsenergyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyEdge::copy(
  self : PhysicsmechanicsenergyEdge,
) -> PhysicsmechanicsenergyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyEdge::fill(
  self : PhysicsmechanicsenergyEdge,
  v : Double,
) -> PhysicsmechanicsenergyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyEdge::min(
  self : PhysicsmechanicsenergyEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyEdge::max(
  self : PhysicsmechanicsenergyEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyEdge::to_string(
  self : PhysicsmechanicsenergyEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_path_make(
  size : Int32,
) -> PhysicsmechanicsenergyPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyPath::len(
  self : PhysicsmechanicsenergyPath,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyPath::get(
  self : PhysicsmechanicsenergyPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyPath::set(
  self : PhysicsmechanicsenergyPath,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyPath::sum(
  self : PhysicsmechanicsenergyPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyPath::mean(
  self : PhysicsmechanicsenergyPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyPath::scale(
  self : PhysicsmechanicsenergyPath,
  f : Double,
) -> PhysicsmechanicsenergyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyPath::add(
  self : PhysicsmechanicsenergyPath,
  other : PhysicsmechanicsenergyPath,
) -> PhysicsmechanicsenergyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyPath::copy(
  self : PhysicsmechanicsenergyPath,
) -> PhysicsmechanicsenergyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyPath::fill(
  self : PhysicsmechanicsenergyPath,
  v : Double,
) -> PhysicsmechanicsenergyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyPath::min(
  self : PhysicsmechanicsenergyPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyPath::max(
  self : PhysicsmechanicsenergyPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyPath::to_string(
  self : PhysicsmechanicsenergyPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_cluster_make(
  size : Int32,
) -> PhysicsmechanicsenergyCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyCluster::len(
  self : PhysicsmechanicsenergyCluster,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyCluster::get(
  self : PhysicsmechanicsenergyCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyCluster::set(
  self : PhysicsmechanicsenergyCluster,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyCluster::sum(
  self : PhysicsmechanicsenergyCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyCluster::mean(
  self : PhysicsmechanicsenergyCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyCluster::scale(
  self : PhysicsmechanicsenergyCluster,
  f : Double,
) -> PhysicsmechanicsenergyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyCluster::add(
  self : PhysicsmechanicsenergyCluster,
  other : PhysicsmechanicsenergyCluster,
) -> PhysicsmechanicsenergyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyCluster::copy(
  self : PhysicsmechanicsenergyCluster,
) -> PhysicsmechanicsenergyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyCluster::fill(
  self : PhysicsmechanicsenergyCluster,
  v : Double,
) -> PhysicsmechanicsenergyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyCluster::min(
  self : PhysicsmechanicsenergyCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyCluster::max(
  self : PhysicsmechanicsenergyCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyCluster::to_string(
  self : PhysicsmechanicsenergyCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_model_make(
  size : Int32,
) -> PhysicsmechanicsenergyModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyModel::len(
  self : PhysicsmechanicsenergyModel,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyModel::get(
  self : PhysicsmechanicsenergyModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyModel::set(
  self : PhysicsmechanicsenergyModel,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyModel::sum(
  self : PhysicsmechanicsenergyModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyModel::mean(
  self : PhysicsmechanicsenergyModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyModel::scale(
  self : PhysicsmechanicsenergyModel,
  f : Double,
) -> PhysicsmechanicsenergyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyModel::add(
  self : PhysicsmechanicsenergyModel,
  other : PhysicsmechanicsenergyModel,
) -> PhysicsmechanicsenergyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyModel::copy(
  self : PhysicsmechanicsenergyModel,
) -> PhysicsmechanicsenergyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyModel::fill(
  self : PhysicsmechanicsenergyModel,
  v : Double,
) -> PhysicsmechanicsenergyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyModel::min(
  self : PhysicsmechanicsenergyModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyModel::max(
  self : PhysicsmechanicsenergyModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyModel::to_string(
  self : PhysicsmechanicsenergyModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_layer_make(
  size : Int32,
) -> PhysicsmechanicsenergyLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyLayer::len(
  self : PhysicsmechanicsenergyLayer,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyLayer::get(
  self : PhysicsmechanicsenergyLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyLayer::set(
  self : PhysicsmechanicsenergyLayer,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyLayer::sum(
  self : PhysicsmechanicsenergyLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyLayer::mean(
  self : PhysicsmechanicsenergyLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyLayer::scale(
  self : PhysicsmechanicsenergyLayer,
  f : Double,
) -> PhysicsmechanicsenergyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyLayer::add(
  self : PhysicsmechanicsenergyLayer,
  other : PhysicsmechanicsenergyLayer,
) -> PhysicsmechanicsenergyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyLayer::copy(
  self : PhysicsmechanicsenergyLayer,
) -> PhysicsmechanicsenergyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyLayer::fill(
  self : PhysicsmechanicsenergyLayer,
  v : Double,
) -> PhysicsmechanicsenergyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyLayer::min(
  self : PhysicsmechanicsenergyLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyLayer::max(
  self : PhysicsmechanicsenergyLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyLayer::to_string(
  self : PhysicsmechanicsenergyLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_buffer_make(
  size : Int32,
) -> PhysicsmechanicsenergyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyBuffer::len(
  self : PhysicsmechanicsenergyBuffer,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyBuffer::get(
  self : PhysicsmechanicsenergyBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyBuffer::set(
  self : PhysicsmechanicsenergyBuffer,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyBuffer::sum(
  self : PhysicsmechanicsenergyBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyBuffer::mean(
  self : PhysicsmechanicsenergyBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyBuffer::scale(
  self : PhysicsmechanicsenergyBuffer,
  f : Double,
) -> PhysicsmechanicsenergyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyBuffer::add(
  self : PhysicsmechanicsenergyBuffer,
  other : PhysicsmechanicsenergyBuffer,
) -> PhysicsmechanicsenergyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyBuffer::copy(
  self : PhysicsmechanicsenergyBuffer,
) -> PhysicsmechanicsenergyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyBuffer::fill(
  self : PhysicsmechanicsenergyBuffer,
  v : Double,
) -> PhysicsmechanicsenergyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyBuffer::min(
  self : PhysicsmechanicsenergyBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyBuffer::max(
  self : PhysicsmechanicsenergyBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyBuffer::to_string(
  self : PhysicsmechanicsenergyBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_cursor_make(
  size : Int32,
) -> PhysicsmechanicsenergyCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyCursor::len(
  self : PhysicsmechanicsenergyCursor,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyCursor::get(
  self : PhysicsmechanicsenergyCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyCursor::set(
  self : PhysicsmechanicsenergyCursor,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyCursor::sum(
  self : PhysicsmechanicsenergyCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyCursor::mean(
  self : PhysicsmechanicsenergyCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyCursor::scale(
  self : PhysicsmechanicsenergyCursor,
  f : Double,
) -> PhysicsmechanicsenergyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyCursor::add(
  self : PhysicsmechanicsenergyCursor,
  other : PhysicsmechanicsenergyCursor,
) -> PhysicsmechanicsenergyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyCursor::copy(
  self : PhysicsmechanicsenergyCursor,
) -> PhysicsmechanicsenergyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyCursor::fill(
  self : PhysicsmechanicsenergyCursor,
  v : Double,
) -> PhysicsmechanicsenergyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyCursor::min(
  self : PhysicsmechanicsenergyCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyCursor::max(
  self : PhysicsmechanicsenergyCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyCursor::to_string(
  self : PhysicsmechanicsenergyCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_view_make(
  size : Int32,
) -> PhysicsmechanicsenergyView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyView::len(
  self : PhysicsmechanicsenergyView,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyView::get(
  self : PhysicsmechanicsenergyView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyView::set(
  self : PhysicsmechanicsenergyView,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyView::sum(
  self : PhysicsmechanicsenergyView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyView::mean(
  self : PhysicsmechanicsenergyView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyView::scale(
  self : PhysicsmechanicsenergyView,
  f : Double,
) -> PhysicsmechanicsenergyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyView::add(
  self : PhysicsmechanicsenergyView,
  other : PhysicsmechanicsenergyView,
) -> PhysicsmechanicsenergyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyView::copy(
  self : PhysicsmechanicsenergyView,
) -> PhysicsmechanicsenergyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyView::fill(
  self : PhysicsmechanicsenergyView,
  v : Double,
) -> PhysicsmechanicsenergyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyView::min(
  self : PhysicsmechanicsenergyView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyView::max(
  self : PhysicsmechanicsenergyView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyView::to_string(
  self : PhysicsmechanicsenergyView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergyRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_range_make(
  size : Int32,
) -> PhysicsmechanicsenergyRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergyRange::len(
  self : PhysicsmechanicsenergyRange,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergyRange::get(
  self : PhysicsmechanicsenergyRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergyRange::set(
  self : PhysicsmechanicsenergyRange,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyRange::sum(
  self : PhysicsmechanicsenergyRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergyRange::mean(
  self : PhysicsmechanicsenergyRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergyRange::scale(
  self : PhysicsmechanicsenergyRange,
  f : Double,
) -> PhysicsmechanicsenergyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyRange::add(
  self : PhysicsmechanicsenergyRange,
  other : PhysicsmechanicsenergyRange,
) -> PhysicsmechanicsenergyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyRange::copy(
  self : PhysicsmechanicsenergyRange,
) -> PhysicsmechanicsenergyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyRange::fill(
  self : PhysicsmechanicsenergyRange,
  v : Double,
) -> PhysicsmechanicsenergyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergyRange::min(
  self : PhysicsmechanicsenergyRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergyRange::max(
  self : PhysicsmechanicsenergyRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergyRange::to_string(
  self : PhysicsmechanicsenergyRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsmechanicsenergySlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_mechanics_energy_slice_make(
  size : Int32,
) -> PhysicsmechanicsenergySlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsmechanicsenergySlice::len(
  self : PhysicsmechanicsenergySlice,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsmechanicsenergySlice::get(
  self : PhysicsmechanicsenergySlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsmechanicsenergySlice::set(
  self : PhysicsmechanicsenergySlice,
  i : Int32,
  v : Double,
) -> PhysicsmechanicsenergySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergySlice::sum(
  self : PhysicsmechanicsenergySlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsmechanicsenergySlice::mean(
  self : PhysicsmechanicsenergySlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsmechanicsenergySlice::scale(
  self : PhysicsmechanicsenergySlice,
  f : Double,
) -> PhysicsmechanicsenergySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergySlice::add(
  self : PhysicsmechanicsenergySlice,
  other : PhysicsmechanicsenergySlice,
) -> PhysicsmechanicsenergySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergySlice::copy(
  self : PhysicsmechanicsenergySlice,
) -> PhysicsmechanicsenergySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergySlice::fill(
  self : PhysicsmechanicsenergySlice,
  v : Double,
) -> PhysicsmechanicsenergySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsmechanicsenergySlice::min(
  self : PhysicsmechanicsenergySlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsmechanicsenergySlice::max(
  self : PhysicsmechanicsenergySlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsmechanicsenergySlice::to_string(
  self : PhysicsmechanicsenergySlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
