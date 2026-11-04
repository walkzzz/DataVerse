///|
///===
/// extcore/physics_fluid_level_set
pub(all) struct PhysicsfluidlevelsetPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn physics_fluid_level_set_make_point(
  x : Double,
  y : Double,
) -> PhysicsfluidlevelsetPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn physics_fluid_level_set_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> PhysicsfluidlevelsetPoint {
  { x, y, z, label: 0, }
}

///|
pub fn PhysicsfluidlevelsetPoint::x(self : PhysicsfluidlevelsetPoint) -> Double {
  self.x
}

///|
pub fn PhysicsfluidlevelsetPoint::y(self : PhysicsfluidlevelsetPoint) -> Double {
  self.y
}

///|
pub fn PhysicsfluidlevelsetPoint::z(self : PhysicsfluidlevelsetPoint) -> Double {
  self.z
}

///|
pub fn PhysicsfluidlevelsetPoint::label(
  self : PhysicsfluidlevelsetPoint,
) -> Int32 {
  self.label
}

///|
pub fn PhysicsfluidlevelsetPoint::dist(
  self : PhysicsfluidlevelsetPoint,
  other : PhysicsfluidlevelsetPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn PhysicsfluidlevelsetPoint::add(
  self : PhysicsfluidlevelsetPoint,
  other : PhysicsfluidlevelsetPoint,
) -> PhysicsfluidlevelsetPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsfluidlevelsetPoint::sub(
  self : PhysicsfluidlevelsetPoint,
  other : PhysicsfluidlevelsetPoint,
) -> PhysicsfluidlevelsetPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsfluidlevelsetPoint::scale(
  self : PhysicsfluidlevelsetPoint,
  s : Double,
) -> PhysicsfluidlevelsetPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn PhysicsfluidlevelsetPoint::dot(
  self : PhysicsfluidlevelsetPoint,
  other : PhysicsfluidlevelsetPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn PhysicsfluidlevelsetPoint::cross(
  self : PhysicsfluidlevelsetPoint,
  other : PhysicsfluidlevelsetPoint,
) -> PhysicsfluidlevelsetPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn PhysicsfluidlevelsetPoint::norm(
  self : PhysicsfluidlevelsetPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn PhysicsfluidlevelsetPoint::normalize(
  self : PhysicsfluidlevelsetPoint,
) -> PhysicsfluidlevelsetPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsfluidlevelsetPoint::negate(
  self : PhysicsfluidlevelsetPoint,
) -> PhysicsfluidlevelsetPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn PhysicsfluidlevelsetPoint::mid(
  self : PhysicsfluidlevelsetPoint,
  other : PhysicsfluidlevelsetPoint,
) -> PhysicsfluidlevelsetPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn PhysicsfluidlevelsetPoint::lerp(
  self : PhysicsfluidlevelsetPoint,
  other : PhysicsfluidlevelsetPoint,
  t : Double,
) -> PhysicsfluidlevelsetPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn PhysicsfluidlevelsetPoint::to_string(
  self : PhysicsfluidlevelsetPoint,
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
pub(all) struct PhysicsfluidlevelsetSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn physics_fluid_level_set_make_series(
  vals : Array[Double],
  name : String,
) -> PhysicsfluidlevelsetSeries {
  { vals, name, meta: 0, }
}

///|
pub fn PhysicsfluidlevelsetSeries::len(
  self : PhysicsfluidlevelsetSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn PhysicsfluidlevelsetSeries::sum(
  self : PhysicsfluidlevelsetSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn PhysicsfluidlevelsetSeries::mean(
  self : PhysicsfluidlevelsetSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn PhysicsfluidlevelsetSeries::min(
  self : PhysicsfluidlevelsetSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn PhysicsfluidlevelsetSeries::max(
  self : PhysicsfluidlevelsetSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn PhysicsfluidlevelsetSeries::range(
  self : PhysicsfluidlevelsetSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn PhysicsfluidlevelsetSeries::variance(
  self : PhysicsfluidlevelsetSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn PhysicsfluidlevelsetSeries::std(
  self : PhysicsfluidlevelsetSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn PhysicsfluidlevelsetSeries::median(
  self : PhysicsfluidlevelsetSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn PhysicsfluidlevelsetSeries::scale(
  self : PhysicsfluidlevelsetSeries,
  f : Double,
) -> PhysicsfluidlevelsetSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn PhysicsfluidlevelsetSeries::add(
  self : PhysicsfluidlevelsetSeries,
  other : PhysicsfluidlevelsetSeries,
) -> PhysicsfluidlevelsetSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsfluidlevelsetSeries::sub(
  self : PhysicsfluidlevelsetSeries,
  other : PhysicsfluidlevelsetSeries,
) -> PhysicsfluidlevelsetSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsfluidlevelsetSeries::normalize(
  self : PhysicsfluidlevelsetSeries,
) -> PhysicsfluidlevelsetSeries {
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
pub fn PhysicsfluidlevelsetSeries::cumsum(
  self : PhysicsfluidlevelsetSeries,
) -> PhysicsfluidlevelsetSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn PhysicsfluidlevelsetSeries::to_string(
  self : PhysicsfluidlevelsetSeries,
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
pub(all) struct PhysicsfluidlevelsetMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn physics_fluid_level_set_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> PhysicsfluidlevelsetMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn physics_fluid_level_set_matrix_identity(
  n : Int32,
) -> PhysicsfluidlevelsetMatrix {
  let m = physics_fluid_level_set_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn PhysicsfluidlevelsetMatrix::get(
  self : PhysicsfluidlevelsetMatrix,
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
pub fn PhysicsfluidlevelsetMatrix::transpose(
  self : PhysicsfluidlevelsetMatrix,
) -> PhysicsfluidlevelsetMatrix {
  let result = physics_fluid_level_set_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsfluidlevelsetMatrix::add(
  self : PhysicsfluidlevelsetMatrix,
  other : PhysicsfluidlevelsetMatrix,
) -> PhysicsfluidlevelsetMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = physics_fluid_level_set_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsfluidlevelsetMatrix::scale(
  self : PhysicsfluidlevelsetMatrix,
  s : Double,
) -> PhysicsfluidlevelsetMatrix {
  let result = physics_fluid_level_set_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn PhysicsfluidlevelsetMatrix::multiply(
  self : PhysicsfluidlevelsetMatrix,
  other : PhysicsfluidlevelsetMatrix,
) -> PhysicsfluidlevelsetMatrix {
  if self.cols != other.rows {
    return physics_fluid_level_set_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = physics_fluid_level_set_make_matrix(self.rows, other.cols, 0.0)
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
pub fn PhysicsfluidlevelsetMatrix::trace(
  self : PhysicsfluidlevelsetMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn PhysicsfluidlevelsetMatrix::det(
  self : PhysicsfluidlevelsetMatrix,
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
pub fn PhysicsfluidlevelsetMatrix::norm(
  self : PhysicsfluidlevelsetMatrix,
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
pub fn PhysicsfluidlevelsetMatrix::to_string(
  self : PhysicsfluidlevelsetMatrix,
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
pub(all) struct PhysicsfluidlevelsetVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn physics_fluid_level_set_make_vector(
  comps : Array[Double],
) -> PhysicsfluidlevelsetVector {
  { comps, dim: comps.length(), }
}

///|
pub fn physics_fluid_level_set_vector_zero(
  dim : Int32,
) -> PhysicsfluidlevelsetVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn PhysicsfluidlevelsetVector::add(
  self : PhysicsfluidlevelsetVector,
  other : PhysicsfluidlevelsetVector,
) -> PhysicsfluidlevelsetVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsfluidlevelsetVector::sub(
  self : PhysicsfluidlevelsetVector,
  other : PhysicsfluidlevelsetVector,
) -> PhysicsfluidlevelsetVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsfluidlevelsetVector::scale(
  self : PhysicsfluidlevelsetVector,
  s : Double,
) -> PhysicsfluidlevelsetVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn PhysicsfluidlevelsetVector::dot(
  self : PhysicsfluidlevelsetVector,
  other : PhysicsfluidlevelsetVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn PhysicsfluidlevelsetVector::norm(
  self : PhysicsfluidlevelsetVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn PhysicsfluidlevelsetVector::normalize(
  self : PhysicsfluidlevelsetVector,
) -> PhysicsfluidlevelsetVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsfluidlevelsetVector::dist(
  self : PhysicsfluidlevelsetVector,
  other : PhysicsfluidlevelsetVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn PhysicsfluidlevelsetVector::to_string(
  self : PhysicsfluidlevelsetVector,
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
pub(all) struct PhysicsfluidlevelsetFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_frame_make(
  size : Int32,
) -> PhysicsfluidlevelsetFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetFrame::len(
  self : PhysicsfluidlevelsetFrame,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetFrame::get(
  self : PhysicsfluidlevelsetFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetFrame::set(
  self : PhysicsfluidlevelsetFrame,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetFrame::sum(
  self : PhysicsfluidlevelsetFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetFrame::mean(
  self : PhysicsfluidlevelsetFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetFrame::scale(
  self : PhysicsfluidlevelsetFrame,
  f : Double,
) -> PhysicsfluidlevelsetFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetFrame::add(
  self : PhysicsfluidlevelsetFrame,
  other : PhysicsfluidlevelsetFrame,
) -> PhysicsfluidlevelsetFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetFrame::copy(
  self : PhysicsfluidlevelsetFrame,
) -> PhysicsfluidlevelsetFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetFrame::fill(
  self : PhysicsfluidlevelsetFrame,
  v : Double,
) -> PhysicsfluidlevelsetFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetFrame::min(
  self : PhysicsfluidlevelsetFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetFrame::max(
  self : PhysicsfluidlevelsetFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetFrame::to_string(
  self : PhysicsfluidlevelsetFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_table_make(
  size : Int32,
) -> PhysicsfluidlevelsetTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetTable::len(
  self : PhysicsfluidlevelsetTable,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetTable::get(
  self : PhysicsfluidlevelsetTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetTable::set(
  self : PhysicsfluidlevelsetTable,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetTable::sum(
  self : PhysicsfluidlevelsetTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetTable::mean(
  self : PhysicsfluidlevelsetTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetTable::scale(
  self : PhysicsfluidlevelsetTable,
  f : Double,
) -> PhysicsfluidlevelsetTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetTable::add(
  self : PhysicsfluidlevelsetTable,
  other : PhysicsfluidlevelsetTable,
) -> PhysicsfluidlevelsetTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetTable::copy(
  self : PhysicsfluidlevelsetTable,
) -> PhysicsfluidlevelsetTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetTable::fill(
  self : PhysicsfluidlevelsetTable,
  v : Double,
) -> PhysicsfluidlevelsetTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetTable::min(
  self : PhysicsfluidlevelsetTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetTable::max(
  self : PhysicsfluidlevelsetTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetTable::to_string(
  self : PhysicsfluidlevelsetTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_graphn_make(
  size : Int32,
) -> PhysicsfluidlevelsetGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetGraphN::len(
  self : PhysicsfluidlevelsetGraphN,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetGraphN::get(
  self : PhysicsfluidlevelsetGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetGraphN::set(
  self : PhysicsfluidlevelsetGraphN,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetGraphN::sum(
  self : PhysicsfluidlevelsetGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetGraphN::mean(
  self : PhysicsfluidlevelsetGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetGraphN::scale(
  self : PhysicsfluidlevelsetGraphN,
  f : Double,
) -> PhysicsfluidlevelsetGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetGraphN::add(
  self : PhysicsfluidlevelsetGraphN,
  other : PhysicsfluidlevelsetGraphN,
) -> PhysicsfluidlevelsetGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetGraphN::copy(
  self : PhysicsfluidlevelsetGraphN,
) -> PhysicsfluidlevelsetGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetGraphN::fill(
  self : PhysicsfluidlevelsetGraphN,
  v : Double,
) -> PhysicsfluidlevelsetGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetGraphN::min(
  self : PhysicsfluidlevelsetGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetGraphN::max(
  self : PhysicsfluidlevelsetGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetGraphN::to_string(
  self : PhysicsfluidlevelsetGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_node_make(
  size : Int32,
) -> PhysicsfluidlevelsetNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetNode::len(self : PhysicsfluidlevelsetNode) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetNode::get(
  self : PhysicsfluidlevelsetNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetNode::set(
  self : PhysicsfluidlevelsetNode,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetNode::sum(self : PhysicsfluidlevelsetNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetNode::mean(
  self : PhysicsfluidlevelsetNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetNode::scale(
  self : PhysicsfluidlevelsetNode,
  f : Double,
) -> PhysicsfluidlevelsetNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetNode::add(
  self : PhysicsfluidlevelsetNode,
  other : PhysicsfluidlevelsetNode,
) -> PhysicsfluidlevelsetNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetNode::copy(
  self : PhysicsfluidlevelsetNode,
) -> PhysicsfluidlevelsetNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetNode::fill(
  self : PhysicsfluidlevelsetNode,
  v : Double,
) -> PhysicsfluidlevelsetNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetNode::min(self : PhysicsfluidlevelsetNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetNode::max(self : PhysicsfluidlevelsetNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetNode::to_string(
  self : PhysicsfluidlevelsetNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_edge_make(
  size : Int32,
) -> PhysicsfluidlevelsetEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetEdge::len(self : PhysicsfluidlevelsetEdge) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetEdge::get(
  self : PhysicsfluidlevelsetEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetEdge::set(
  self : PhysicsfluidlevelsetEdge,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetEdge::sum(self : PhysicsfluidlevelsetEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetEdge::mean(
  self : PhysicsfluidlevelsetEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetEdge::scale(
  self : PhysicsfluidlevelsetEdge,
  f : Double,
) -> PhysicsfluidlevelsetEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetEdge::add(
  self : PhysicsfluidlevelsetEdge,
  other : PhysicsfluidlevelsetEdge,
) -> PhysicsfluidlevelsetEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetEdge::copy(
  self : PhysicsfluidlevelsetEdge,
) -> PhysicsfluidlevelsetEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetEdge::fill(
  self : PhysicsfluidlevelsetEdge,
  v : Double,
) -> PhysicsfluidlevelsetEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetEdge::min(self : PhysicsfluidlevelsetEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetEdge::max(self : PhysicsfluidlevelsetEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetEdge::to_string(
  self : PhysicsfluidlevelsetEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_path_make(
  size : Int32,
) -> PhysicsfluidlevelsetPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetPath::len(self : PhysicsfluidlevelsetPath) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetPath::get(
  self : PhysicsfluidlevelsetPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetPath::set(
  self : PhysicsfluidlevelsetPath,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetPath::sum(self : PhysicsfluidlevelsetPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetPath::mean(
  self : PhysicsfluidlevelsetPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetPath::scale(
  self : PhysicsfluidlevelsetPath,
  f : Double,
) -> PhysicsfluidlevelsetPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetPath::add(
  self : PhysicsfluidlevelsetPath,
  other : PhysicsfluidlevelsetPath,
) -> PhysicsfluidlevelsetPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetPath::copy(
  self : PhysicsfluidlevelsetPath,
) -> PhysicsfluidlevelsetPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetPath::fill(
  self : PhysicsfluidlevelsetPath,
  v : Double,
) -> PhysicsfluidlevelsetPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetPath::min(self : PhysicsfluidlevelsetPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetPath::max(self : PhysicsfluidlevelsetPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetPath::to_string(
  self : PhysicsfluidlevelsetPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_cluster_make(
  size : Int32,
) -> PhysicsfluidlevelsetCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetCluster::len(
  self : PhysicsfluidlevelsetCluster,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetCluster::get(
  self : PhysicsfluidlevelsetCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetCluster::set(
  self : PhysicsfluidlevelsetCluster,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetCluster::sum(
  self : PhysicsfluidlevelsetCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetCluster::mean(
  self : PhysicsfluidlevelsetCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetCluster::scale(
  self : PhysicsfluidlevelsetCluster,
  f : Double,
) -> PhysicsfluidlevelsetCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetCluster::add(
  self : PhysicsfluidlevelsetCluster,
  other : PhysicsfluidlevelsetCluster,
) -> PhysicsfluidlevelsetCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetCluster::copy(
  self : PhysicsfluidlevelsetCluster,
) -> PhysicsfluidlevelsetCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetCluster::fill(
  self : PhysicsfluidlevelsetCluster,
  v : Double,
) -> PhysicsfluidlevelsetCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetCluster::min(
  self : PhysicsfluidlevelsetCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetCluster::max(
  self : PhysicsfluidlevelsetCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetCluster::to_string(
  self : PhysicsfluidlevelsetCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_model_make(
  size : Int32,
) -> PhysicsfluidlevelsetModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetModel::len(
  self : PhysicsfluidlevelsetModel,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetModel::get(
  self : PhysicsfluidlevelsetModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetModel::set(
  self : PhysicsfluidlevelsetModel,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetModel::sum(
  self : PhysicsfluidlevelsetModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetModel::mean(
  self : PhysicsfluidlevelsetModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetModel::scale(
  self : PhysicsfluidlevelsetModel,
  f : Double,
) -> PhysicsfluidlevelsetModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetModel::add(
  self : PhysicsfluidlevelsetModel,
  other : PhysicsfluidlevelsetModel,
) -> PhysicsfluidlevelsetModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetModel::copy(
  self : PhysicsfluidlevelsetModel,
) -> PhysicsfluidlevelsetModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetModel::fill(
  self : PhysicsfluidlevelsetModel,
  v : Double,
) -> PhysicsfluidlevelsetModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetModel::min(
  self : PhysicsfluidlevelsetModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetModel::max(
  self : PhysicsfluidlevelsetModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetModel::to_string(
  self : PhysicsfluidlevelsetModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_layer_make(
  size : Int32,
) -> PhysicsfluidlevelsetLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetLayer::len(
  self : PhysicsfluidlevelsetLayer,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetLayer::get(
  self : PhysicsfluidlevelsetLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetLayer::set(
  self : PhysicsfluidlevelsetLayer,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetLayer::sum(
  self : PhysicsfluidlevelsetLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetLayer::mean(
  self : PhysicsfluidlevelsetLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetLayer::scale(
  self : PhysicsfluidlevelsetLayer,
  f : Double,
) -> PhysicsfluidlevelsetLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetLayer::add(
  self : PhysicsfluidlevelsetLayer,
  other : PhysicsfluidlevelsetLayer,
) -> PhysicsfluidlevelsetLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetLayer::copy(
  self : PhysicsfluidlevelsetLayer,
) -> PhysicsfluidlevelsetLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetLayer::fill(
  self : PhysicsfluidlevelsetLayer,
  v : Double,
) -> PhysicsfluidlevelsetLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetLayer::min(
  self : PhysicsfluidlevelsetLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetLayer::max(
  self : PhysicsfluidlevelsetLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetLayer::to_string(
  self : PhysicsfluidlevelsetLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_buffer_make(
  size : Int32,
) -> PhysicsfluidlevelsetBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetBuffer::len(
  self : PhysicsfluidlevelsetBuffer,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetBuffer::get(
  self : PhysicsfluidlevelsetBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetBuffer::set(
  self : PhysicsfluidlevelsetBuffer,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetBuffer::sum(
  self : PhysicsfluidlevelsetBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetBuffer::mean(
  self : PhysicsfluidlevelsetBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetBuffer::scale(
  self : PhysicsfluidlevelsetBuffer,
  f : Double,
) -> PhysicsfluidlevelsetBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetBuffer::add(
  self : PhysicsfluidlevelsetBuffer,
  other : PhysicsfluidlevelsetBuffer,
) -> PhysicsfluidlevelsetBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetBuffer::copy(
  self : PhysicsfluidlevelsetBuffer,
) -> PhysicsfluidlevelsetBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetBuffer::fill(
  self : PhysicsfluidlevelsetBuffer,
  v : Double,
) -> PhysicsfluidlevelsetBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetBuffer::min(
  self : PhysicsfluidlevelsetBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetBuffer::max(
  self : PhysicsfluidlevelsetBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetBuffer::to_string(
  self : PhysicsfluidlevelsetBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_cursor_make(
  size : Int32,
) -> PhysicsfluidlevelsetCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetCursor::len(
  self : PhysicsfluidlevelsetCursor,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetCursor::get(
  self : PhysicsfluidlevelsetCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetCursor::set(
  self : PhysicsfluidlevelsetCursor,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetCursor::sum(
  self : PhysicsfluidlevelsetCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetCursor::mean(
  self : PhysicsfluidlevelsetCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetCursor::scale(
  self : PhysicsfluidlevelsetCursor,
  f : Double,
) -> PhysicsfluidlevelsetCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetCursor::add(
  self : PhysicsfluidlevelsetCursor,
  other : PhysicsfluidlevelsetCursor,
) -> PhysicsfluidlevelsetCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetCursor::copy(
  self : PhysicsfluidlevelsetCursor,
) -> PhysicsfluidlevelsetCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetCursor::fill(
  self : PhysicsfluidlevelsetCursor,
  v : Double,
) -> PhysicsfluidlevelsetCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetCursor::min(
  self : PhysicsfluidlevelsetCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetCursor::max(
  self : PhysicsfluidlevelsetCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetCursor::to_string(
  self : PhysicsfluidlevelsetCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_view_make(
  size : Int32,
) -> PhysicsfluidlevelsetView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetView::len(self : PhysicsfluidlevelsetView) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetView::get(
  self : PhysicsfluidlevelsetView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetView::set(
  self : PhysicsfluidlevelsetView,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetView::sum(self : PhysicsfluidlevelsetView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetView::mean(
  self : PhysicsfluidlevelsetView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetView::scale(
  self : PhysicsfluidlevelsetView,
  f : Double,
) -> PhysicsfluidlevelsetView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetView::add(
  self : PhysicsfluidlevelsetView,
  other : PhysicsfluidlevelsetView,
) -> PhysicsfluidlevelsetView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetView::copy(
  self : PhysicsfluidlevelsetView,
) -> PhysicsfluidlevelsetView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetView::fill(
  self : PhysicsfluidlevelsetView,
  v : Double,
) -> PhysicsfluidlevelsetView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetView::min(self : PhysicsfluidlevelsetView) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetView::max(self : PhysicsfluidlevelsetView) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetView::to_string(
  self : PhysicsfluidlevelsetView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_range_make(
  size : Int32,
) -> PhysicsfluidlevelsetRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetRange::len(
  self : PhysicsfluidlevelsetRange,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetRange::get(
  self : PhysicsfluidlevelsetRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetRange::set(
  self : PhysicsfluidlevelsetRange,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetRange::sum(
  self : PhysicsfluidlevelsetRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetRange::mean(
  self : PhysicsfluidlevelsetRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetRange::scale(
  self : PhysicsfluidlevelsetRange,
  f : Double,
) -> PhysicsfluidlevelsetRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetRange::add(
  self : PhysicsfluidlevelsetRange,
  other : PhysicsfluidlevelsetRange,
) -> PhysicsfluidlevelsetRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetRange::copy(
  self : PhysicsfluidlevelsetRange,
) -> PhysicsfluidlevelsetRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetRange::fill(
  self : PhysicsfluidlevelsetRange,
  v : Double,
) -> PhysicsfluidlevelsetRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetRange::min(
  self : PhysicsfluidlevelsetRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetRange::max(
  self : PhysicsfluidlevelsetRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetRange::to_string(
  self : PhysicsfluidlevelsetRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsfluidlevelsetSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_fluid_level_set_slice_make(
  size : Int32,
) -> PhysicsfluidlevelsetSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsfluidlevelsetSlice::len(
  self : PhysicsfluidlevelsetSlice,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsfluidlevelsetSlice::get(
  self : PhysicsfluidlevelsetSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsfluidlevelsetSlice::set(
  self : PhysicsfluidlevelsetSlice,
  i : Int32,
  v : Double,
) -> PhysicsfluidlevelsetSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetSlice::sum(
  self : PhysicsfluidlevelsetSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsfluidlevelsetSlice::mean(
  self : PhysicsfluidlevelsetSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsfluidlevelsetSlice::scale(
  self : PhysicsfluidlevelsetSlice,
  f : Double,
) -> PhysicsfluidlevelsetSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetSlice::add(
  self : PhysicsfluidlevelsetSlice,
  other : PhysicsfluidlevelsetSlice,
) -> PhysicsfluidlevelsetSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetSlice::copy(
  self : PhysicsfluidlevelsetSlice,
) -> PhysicsfluidlevelsetSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetSlice::fill(
  self : PhysicsfluidlevelsetSlice,
  v : Double,
) -> PhysicsfluidlevelsetSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsfluidlevelsetSlice::min(
  self : PhysicsfluidlevelsetSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsfluidlevelsetSlice::max(
  self : PhysicsfluidlevelsetSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsfluidlevelsetSlice::to_string(
  self : PhysicsfluidlevelsetSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
