///|
///===
/// extcore/physics_fluid_stokes
pub(all) struct PhysicsfluidstokesPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn physics_fluid_stokes_make_point(
  x : Double,
  y : Double,
) -> PhysicsfluidstokesPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn physics_fluid_stokes_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> PhysicsfluidstokesPoint {
  { x, y, z, label: 0, }
}

///|
pub fn PhysicsfluidstokesPoint::x(self : PhysicsfluidstokesPoint) -> Double {
  self.x
}

///|
pub fn PhysicsfluidstokesPoint::y(self : PhysicsfluidstokesPoint) -> Double {
  self.y
}

///|
pub fn PhysicsfluidstokesPoint::z(self : PhysicsfluidstokesPoint) -> Double {
  self.z
}

///|
pub fn PhysicsfluidstokesPoint::label(self : PhysicsfluidstokesPoint) -> Int32 {
  self.label
}

///|
pub fn PhysicsfluidstokesPoint::dist(
  self : PhysicsfluidstokesPoint,
  other : PhysicsfluidstokesPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn PhysicsfluidstokesPoint::add(
  self : PhysicsfluidstokesPoint,
  other : PhysicsfluidstokesPoint,
) -> PhysicsfluidstokesPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsfluidstokesPoint::sub(
  self : PhysicsfluidstokesPoint,
  other : PhysicsfluidstokesPoint,
) -> PhysicsfluidstokesPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsfluidstokesPoint::scale(
  self : PhysicsfluidstokesPoint,
  s : Double,
) -> PhysicsfluidstokesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn PhysicsfluidstokesPoint::dot(
  self : PhysicsfluidstokesPoint,
  other : PhysicsfluidstokesPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn PhysicsfluidstokesPoint::cross(
  self : PhysicsfluidstokesPoint,
  other : PhysicsfluidstokesPoint,
) -> PhysicsfluidstokesPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn PhysicsfluidstokesPoint::norm(self : PhysicsfluidstokesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn PhysicsfluidstokesPoint::normalize(
  self : PhysicsfluidstokesPoint,
) -> PhysicsfluidstokesPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsfluidstokesPoint::negate(
  self : PhysicsfluidstokesPoint,
) -> PhysicsfluidstokesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn PhysicsfluidstokesPoint::mid(
  self : PhysicsfluidstokesPoint,
  other : PhysicsfluidstokesPoint,
) -> PhysicsfluidstokesPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn PhysicsfluidstokesPoint::lerp(
  self : PhysicsfluidstokesPoint,
  other : PhysicsfluidstokesPoint,
  t : Double,
) -> PhysicsfluidstokesPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn PhysicsfluidstokesPoint::to_string(
  self : PhysicsfluidstokesPoint,
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
pub(all) struct PhysicsfluidstokesSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn physics_fluid_stokes_make_series(
  vals : Array[Double],
  name : String,
) -> PhysicsfluidstokesSeries {
  { vals, name, meta: 0, }
}

///|
pub fn PhysicsfluidstokesSeries::len(self : PhysicsfluidstokesSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn PhysicsfluidstokesSeries::sum(self : PhysicsfluidstokesSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn PhysicsfluidstokesSeries::mean(
  self : PhysicsfluidstokesSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn PhysicsfluidstokesSeries::min(self : PhysicsfluidstokesSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn PhysicsfluidstokesSeries::max(self : PhysicsfluidstokesSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn PhysicsfluidstokesSeries::range(
  self : PhysicsfluidstokesSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn PhysicsfluidstokesSeries::variance(
  self : PhysicsfluidstokesSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn PhysicsfluidstokesSeries::std(self : PhysicsfluidstokesSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn PhysicsfluidstokesSeries::median(
  self : PhysicsfluidstokesSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn PhysicsfluidstokesSeries::scale(
  self : PhysicsfluidstokesSeries,
  f : Double,
) -> PhysicsfluidstokesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn PhysicsfluidstokesSeries::add(
  self : PhysicsfluidstokesSeries,
  other : PhysicsfluidstokesSeries,
) -> PhysicsfluidstokesSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsfluidstokesSeries::sub(
  self : PhysicsfluidstokesSeries,
  other : PhysicsfluidstokesSeries,
) -> PhysicsfluidstokesSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsfluidstokesSeries::normalize(
  self : PhysicsfluidstokesSeries,
) -> PhysicsfluidstokesSeries {
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
pub fn PhysicsfluidstokesSeries::cumsum(
  self : PhysicsfluidstokesSeries,
) -> PhysicsfluidstokesSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn PhysicsfluidstokesSeries::to_string(
  self : PhysicsfluidstokesSeries,
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
pub(all) struct PhysicsfluidstokesMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn physics_fluid_stokes_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> PhysicsfluidstokesMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn physics_fluid_stokes_matrix_identity(
  n : Int32,
) -> PhysicsfluidstokesMatrix {
  let m = physics_fluid_stokes_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn PhysicsfluidstokesMatrix::get(
  self : PhysicsfluidstokesMatrix,
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
pub fn PhysicsfluidstokesMatrix::transpose(
  self : PhysicsfluidstokesMatrix,
) -> PhysicsfluidstokesMatrix {
  let result = physics_fluid_stokes_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsfluidstokesMatrix::add(
  self : PhysicsfluidstokesMatrix,
  other : PhysicsfluidstokesMatrix,
) -> PhysicsfluidstokesMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = physics_fluid_stokes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsfluidstokesMatrix::scale(
  self : PhysicsfluidstokesMatrix,
  s : Double,
) -> PhysicsfluidstokesMatrix {
  let result = physics_fluid_stokes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn PhysicsfluidstokesMatrix::multiply(
  self : PhysicsfluidstokesMatrix,
  other : PhysicsfluidstokesMatrix,
) -> PhysicsfluidstokesMatrix {
  if self.cols != other.rows {
    return physics_fluid_stokes_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = physics_fluid_stokes_make_matrix(self.rows, other.cols, 0.0)
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
pub fn PhysicsfluidstokesMatrix::trace(
  self : PhysicsfluidstokesMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn PhysicsfluidstokesMatrix::det(self : PhysicsfluidstokesMatrix) -> Double {
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
pub fn PhysicsfluidstokesMatrix::norm(
  self : PhysicsfluidstokesMatrix,
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
pub fn PhysicsfluidstokesMatrix::to_string(
  self : PhysicsfluidstokesMatrix,
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
pub(all) struct PhysicsfluidstokesVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn physics_fluid_stokes_make_vector(
  comps : Array[Double],
) -> PhysicsfluidstokesVector {
  { comps, dim: comps.length(), }
}

///|
pub fn physics_fluid_stokes_vector_zero(
  dim : Int32,
) -> PhysicsfluidstokesVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn PhysicsfluidstokesVector::add(
  self : PhysicsfluidstokesVector,
  other : PhysicsfluidstokesVector,
) -> PhysicsfluidstokesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsfluidstokesVector::sub(
  self : PhysicsfluidstokesVector,
  other : PhysicsfluidstokesVector,
) -> PhysicsfluidstokesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsfluidstokesVector::scale(
  self : PhysicsfluidstokesVector,
  s : Double,
) -> PhysicsfluidstokesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn PhysicsfluidstokesVector::dot(
  self : PhysicsfluidstokesVector,
  other : PhysicsfluidstokesVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn PhysicsfluidstokesVector::norm(
  self : PhysicsfluidstokesVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn PhysicsfluidstokesVector::normalize(
  self : PhysicsfluidstokesVector,
) -> PhysicsfluidstokesVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsfluidstokesVector::dist(
  self : PhysicsfluidstokesVector,
  other : PhysicsfluidstokesVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn PhysicsfluidstokesVector::to_string(
  self : PhysicsfluidstokesVector,
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
pub(all) struct PhysicsfluidstokesFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_frame_make(size : Int32) -> PhysicsfluidstokesFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesFrame::len(self : PhysicsfluidstokesFrame) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesFrame::get(
  self : PhysicsfluidstokesFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesFrame::set(
  self : PhysicsfluidstokesFrame,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesFrame::sum(self : PhysicsfluidstokesFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesFrame::mean(self : PhysicsfluidstokesFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesFrame::scale(
  self : PhysicsfluidstokesFrame,
  f : Double,
) -> PhysicsfluidstokesFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesFrame::add(
  self : PhysicsfluidstokesFrame,
  other : PhysicsfluidstokesFrame,
) -> PhysicsfluidstokesFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesFrame::copy(
  self : PhysicsfluidstokesFrame,
) -> PhysicsfluidstokesFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesFrame::fill(
  self : PhysicsfluidstokesFrame,
  v : Double,
) -> PhysicsfluidstokesFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesFrame::min(self : PhysicsfluidstokesFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesFrame::max(self : PhysicsfluidstokesFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesFrame::to_string(
  self : PhysicsfluidstokesFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_table_make(size : Int32) -> PhysicsfluidstokesTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesTable::len(self : PhysicsfluidstokesTable) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesTable::get(
  self : PhysicsfluidstokesTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesTable::set(
  self : PhysicsfluidstokesTable,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesTable::sum(self : PhysicsfluidstokesTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesTable::mean(self : PhysicsfluidstokesTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesTable::scale(
  self : PhysicsfluidstokesTable,
  f : Double,
) -> PhysicsfluidstokesTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesTable::add(
  self : PhysicsfluidstokesTable,
  other : PhysicsfluidstokesTable,
) -> PhysicsfluidstokesTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesTable::copy(
  self : PhysicsfluidstokesTable,
) -> PhysicsfluidstokesTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesTable::fill(
  self : PhysicsfluidstokesTable,
  v : Double,
) -> PhysicsfluidstokesTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesTable::min(self : PhysicsfluidstokesTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesTable::max(self : PhysicsfluidstokesTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesTable::to_string(
  self : PhysicsfluidstokesTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_graphn_make(
  size : Int32,
) -> PhysicsfluidstokesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesGraphN::len(self : PhysicsfluidstokesGraphN) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesGraphN::get(
  self : PhysicsfluidstokesGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesGraphN::set(
  self : PhysicsfluidstokesGraphN,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesGraphN::sum(self : PhysicsfluidstokesGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesGraphN::mean(
  self : PhysicsfluidstokesGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesGraphN::scale(
  self : PhysicsfluidstokesGraphN,
  f : Double,
) -> PhysicsfluidstokesGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesGraphN::add(
  self : PhysicsfluidstokesGraphN,
  other : PhysicsfluidstokesGraphN,
) -> PhysicsfluidstokesGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesGraphN::copy(
  self : PhysicsfluidstokesGraphN,
) -> PhysicsfluidstokesGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesGraphN::fill(
  self : PhysicsfluidstokesGraphN,
  v : Double,
) -> PhysicsfluidstokesGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesGraphN::min(self : PhysicsfluidstokesGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesGraphN::max(self : PhysicsfluidstokesGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesGraphN::to_string(
  self : PhysicsfluidstokesGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_node_make(size : Int32) -> PhysicsfluidstokesNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesNode::len(self : PhysicsfluidstokesNode) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesNode::get(
  self : PhysicsfluidstokesNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesNode::set(
  self : PhysicsfluidstokesNode,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesNode::sum(self : PhysicsfluidstokesNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesNode::mean(self : PhysicsfluidstokesNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesNode::scale(
  self : PhysicsfluidstokesNode,
  f : Double,
) -> PhysicsfluidstokesNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesNode::add(
  self : PhysicsfluidstokesNode,
  other : PhysicsfluidstokesNode,
) -> PhysicsfluidstokesNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesNode::copy(
  self : PhysicsfluidstokesNode,
) -> PhysicsfluidstokesNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesNode::fill(
  self : PhysicsfluidstokesNode,
  v : Double,
) -> PhysicsfluidstokesNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesNode::min(self : PhysicsfluidstokesNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesNode::max(self : PhysicsfluidstokesNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesNode::to_string(
  self : PhysicsfluidstokesNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_edge_make(size : Int32) -> PhysicsfluidstokesEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesEdge::len(self : PhysicsfluidstokesEdge) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesEdge::get(
  self : PhysicsfluidstokesEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesEdge::set(
  self : PhysicsfluidstokesEdge,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesEdge::sum(self : PhysicsfluidstokesEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesEdge::mean(self : PhysicsfluidstokesEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesEdge::scale(
  self : PhysicsfluidstokesEdge,
  f : Double,
) -> PhysicsfluidstokesEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesEdge::add(
  self : PhysicsfluidstokesEdge,
  other : PhysicsfluidstokesEdge,
) -> PhysicsfluidstokesEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesEdge::copy(
  self : PhysicsfluidstokesEdge,
) -> PhysicsfluidstokesEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesEdge::fill(
  self : PhysicsfluidstokesEdge,
  v : Double,
) -> PhysicsfluidstokesEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesEdge::min(self : PhysicsfluidstokesEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesEdge::max(self : PhysicsfluidstokesEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesEdge::to_string(
  self : PhysicsfluidstokesEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_path_make(size : Int32) -> PhysicsfluidstokesPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesPath::len(self : PhysicsfluidstokesPath) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesPath::get(
  self : PhysicsfluidstokesPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesPath::set(
  self : PhysicsfluidstokesPath,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesPath::sum(self : PhysicsfluidstokesPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesPath::mean(self : PhysicsfluidstokesPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesPath::scale(
  self : PhysicsfluidstokesPath,
  f : Double,
) -> PhysicsfluidstokesPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesPath::add(
  self : PhysicsfluidstokesPath,
  other : PhysicsfluidstokesPath,
) -> PhysicsfluidstokesPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesPath::copy(
  self : PhysicsfluidstokesPath,
) -> PhysicsfluidstokesPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesPath::fill(
  self : PhysicsfluidstokesPath,
  v : Double,
) -> PhysicsfluidstokesPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesPath::min(self : PhysicsfluidstokesPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesPath::max(self : PhysicsfluidstokesPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesPath::to_string(
  self : PhysicsfluidstokesPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_cluster_make(
  size : Int32,
) -> PhysicsfluidstokesCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesCluster::len(
  self : PhysicsfluidstokesCluster,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesCluster::get(
  self : PhysicsfluidstokesCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesCluster::set(
  self : PhysicsfluidstokesCluster,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesCluster::sum(
  self : PhysicsfluidstokesCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesCluster::mean(
  self : PhysicsfluidstokesCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesCluster::scale(
  self : PhysicsfluidstokesCluster,
  f : Double,
) -> PhysicsfluidstokesCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesCluster::add(
  self : PhysicsfluidstokesCluster,
  other : PhysicsfluidstokesCluster,
) -> PhysicsfluidstokesCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesCluster::copy(
  self : PhysicsfluidstokesCluster,
) -> PhysicsfluidstokesCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesCluster::fill(
  self : PhysicsfluidstokesCluster,
  v : Double,
) -> PhysicsfluidstokesCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesCluster::min(
  self : PhysicsfluidstokesCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesCluster::max(
  self : PhysicsfluidstokesCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesCluster::to_string(
  self : PhysicsfluidstokesCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_model_make(size : Int32) -> PhysicsfluidstokesModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesModel::len(self : PhysicsfluidstokesModel) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesModel::get(
  self : PhysicsfluidstokesModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesModel::set(
  self : PhysicsfluidstokesModel,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesModel::sum(self : PhysicsfluidstokesModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesModel::mean(self : PhysicsfluidstokesModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesModel::scale(
  self : PhysicsfluidstokesModel,
  f : Double,
) -> PhysicsfluidstokesModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesModel::add(
  self : PhysicsfluidstokesModel,
  other : PhysicsfluidstokesModel,
) -> PhysicsfluidstokesModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesModel::copy(
  self : PhysicsfluidstokesModel,
) -> PhysicsfluidstokesModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesModel::fill(
  self : PhysicsfluidstokesModel,
  v : Double,
) -> PhysicsfluidstokesModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesModel::min(self : PhysicsfluidstokesModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesModel::max(self : PhysicsfluidstokesModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesModel::to_string(
  self : PhysicsfluidstokesModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_layer_make(size : Int32) -> PhysicsfluidstokesLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesLayer::len(self : PhysicsfluidstokesLayer) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesLayer::get(
  self : PhysicsfluidstokesLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesLayer::set(
  self : PhysicsfluidstokesLayer,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesLayer::sum(self : PhysicsfluidstokesLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesLayer::mean(self : PhysicsfluidstokesLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesLayer::scale(
  self : PhysicsfluidstokesLayer,
  f : Double,
) -> PhysicsfluidstokesLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesLayer::add(
  self : PhysicsfluidstokesLayer,
  other : PhysicsfluidstokesLayer,
) -> PhysicsfluidstokesLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesLayer::copy(
  self : PhysicsfluidstokesLayer,
) -> PhysicsfluidstokesLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesLayer::fill(
  self : PhysicsfluidstokesLayer,
  v : Double,
) -> PhysicsfluidstokesLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesLayer::min(self : PhysicsfluidstokesLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesLayer::max(self : PhysicsfluidstokesLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesLayer::to_string(
  self : PhysicsfluidstokesLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_buffer_make(
  size : Int32,
) -> PhysicsfluidstokesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesBuffer::len(self : PhysicsfluidstokesBuffer) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesBuffer::get(
  self : PhysicsfluidstokesBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesBuffer::set(
  self : PhysicsfluidstokesBuffer,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesBuffer::sum(self : PhysicsfluidstokesBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesBuffer::mean(
  self : PhysicsfluidstokesBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesBuffer::scale(
  self : PhysicsfluidstokesBuffer,
  f : Double,
) -> PhysicsfluidstokesBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesBuffer::add(
  self : PhysicsfluidstokesBuffer,
  other : PhysicsfluidstokesBuffer,
) -> PhysicsfluidstokesBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesBuffer::copy(
  self : PhysicsfluidstokesBuffer,
) -> PhysicsfluidstokesBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesBuffer::fill(
  self : PhysicsfluidstokesBuffer,
  v : Double,
) -> PhysicsfluidstokesBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesBuffer::min(self : PhysicsfluidstokesBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesBuffer::max(self : PhysicsfluidstokesBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesBuffer::to_string(
  self : PhysicsfluidstokesBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_cursor_make(
  size : Int32,
) -> PhysicsfluidstokesCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesCursor::len(self : PhysicsfluidstokesCursor) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesCursor::get(
  self : PhysicsfluidstokesCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesCursor::set(
  self : PhysicsfluidstokesCursor,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesCursor::sum(self : PhysicsfluidstokesCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesCursor::mean(
  self : PhysicsfluidstokesCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesCursor::scale(
  self : PhysicsfluidstokesCursor,
  f : Double,
) -> PhysicsfluidstokesCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesCursor::add(
  self : PhysicsfluidstokesCursor,
  other : PhysicsfluidstokesCursor,
) -> PhysicsfluidstokesCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesCursor::copy(
  self : PhysicsfluidstokesCursor,
) -> PhysicsfluidstokesCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesCursor::fill(
  self : PhysicsfluidstokesCursor,
  v : Double,
) -> PhysicsfluidstokesCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesCursor::min(self : PhysicsfluidstokesCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesCursor::max(self : PhysicsfluidstokesCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesCursor::to_string(
  self : PhysicsfluidstokesCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_view_make(size : Int32) -> PhysicsfluidstokesView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesView::len(self : PhysicsfluidstokesView) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesView::get(
  self : PhysicsfluidstokesView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesView::set(
  self : PhysicsfluidstokesView,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesView::sum(self : PhysicsfluidstokesView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesView::mean(self : PhysicsfluidstokesView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesView::scale(
  self : PhysicsfluidstokesView,
  f : Double,
) -> PhysicsfluidstokesView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesView::add(
  self : PhysicsfluidstokesView,
  other : PhysicsfluidstokesView,
) -> PhysicsfluidstokesView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesView::copy(
  self : PhysicsfluidstokesView,
) -> PhysicsfluidstokesView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesView::fill(
  self : PhysicsfluidstokesView,
  v : Double,
) -> PhysicsfluidstokesView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesView::min(self : PhysicsfluidstokesView) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesView::max(self : PhysicsfluidstokesView) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesView::to_string(
  self : PhysicsfluidstokesView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_range_make(size : Int32) -> PhysicsfluidstokesRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesRange::len(self : PhysicsfluidstokesRange) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesRange::get(
  self : PhysicsfluidstokesRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesRange::set(
  self : PhysicsfluidstokesRange,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesRange::sum(self : PhysicsfluidstokesRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesRange::mean(self : PhysicsfluidstokesRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesRange::scale(
  self : PhysicsfluidstokesRange,
  f : Double,
) -> PhysicsfluidstokesRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesRange::add(
  self : PhysicsfluidstokesRange,
  other : PhysicsfluidstokesRange,
) -> PhysicsfluidstokesRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesRange::copy(
  self : PhysicsfluidstokesRange,
) -> PhysicsfluidstokesRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesRange::fill(
  self : PhysicsfluidstokesRange,
  v : Double,
) -> PhysicsfluidstokesRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesRange::min(self : PhysicsfluidstokesRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesRange::max(self : PhysicsfluidstokesRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesRange::to_string(
  self : PhysicsfluidstokesRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidstokesSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_stokes_slice_make(size : Int32) -> PhysicsfluidstokesSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidstokesSlice::len(self : PhysicsfluidstokesSlice) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidstokesSlice::get(
  self : PhysicsfluidstokesSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidstokesSlice::set(
  self : PhysicsfluidstokesSlice,
  i : Int32,
  v : Double,
) -> PhysicsfluidstokesSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesSlice::sum(self : PhysicsfluidstokesSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidstokesSlice::mean(self : PhysicsfluidstokesSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidstokesSlice::scale(
  self : PhysicsfluidstokesSlice,
  f : Double,
) -> PhysicsfluidstokesSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesSlice::add(
  self : PhysicsfluidstokesSlice,
  other : PhysicsfluidstokesSlice,
) -> PhysicsfluidstokesSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesSlice::copy(
  self : PhysicsfluidstokesSlice,
) -> PhysicsfluidstokesSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesSlice::fill(
  self : PhysicsfluidstokesSlice,
  v : Double,
) -> PhysicsfluidstokesSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidstokesSlice::min(self : PhysicsfluidstokesSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidstokesSlice::max(self : PhysicsfluidstokesSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidstokesSlice::to_string(
  self : PhysicsfluidstokesSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
