///|
///===
/// extcore/physics_em_electrostatic
pub(all) struct PhysicsemelectrostaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn physics_em_electrostatic_make_point(
  x : Double,
  y : Double,
) -> PhysicsemelectrostaticPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn physics_em_electrostatic_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> PhysicsemelectrostaticPoint {
  { x, y, z, label: 0, }
}

///|
pub fn PhysicsemelectrostaticPoint::x(
  self : PhysicsemelectrostaticPoint,
) -> Double {
  self.x
}

///|
pub fn PhysicsemelectrostaticPoint::y(
  self : PhysicsemelectrostaticPoint,
) -> Double {
  self.y
}

///|
pub fn PhysicsemelectrostaticPoint::z(
  self : PhysicsemelectrostaticPoint,
) -> Double {
  self.z
}

///|
pub fn PhysicsemelectrostaticPoint::label(
  self : PhysicsemelectrostaticPoint,
) -> Int32 {
  self.label
}

///|
pub fn PhysicsemelectrostaticPoint::dist(
  self : PhysicsemelectrostaticPoint,
  other : PhysicsemelectrostaticPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn PhysicsemelectrostaticPoint::add(
  self : PhysicsemelectrostaticPoint,
  other : PhysicsemelectrostaticPoint,
) -> PhysicsemelectrostaticPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsemelectrostaticPoint::sub(
  self : PhysicsemelectrostaticPoint,
  other : PhysicsemelectrostaticPoint,
) -> PhysicsemelectrostaticPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsemelectrostaticPoint::scale(
  self : PhysicsemelectrostaticPoint,
  s : Double,
) -> PhysicsemelectrostaticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn PhysicsemelectrostaticPoint::dot(
  self : PhysicsemelectrostaticPoint,
  other : PhysicsemelectrostaticPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn PhysicsemelectrostaticPoint::cross(
  self : PhysicsemelectrostaticPoint,
  other : PhysicsemelectrostaticPoint,
) -> PhysicsemelectrostaticPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn PhysicsemelectrostaticPoint::norm(
  self : PhysicsemelectrostaticPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn PhysicsemelectrostaticPoint::normalize(
  self : PhysicsemelectrostaticPoint,
) -> PhysicsemelectrostaticPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsemelectrostaticPoint::negate(
  self : PhysicsemelectrostaticPoint,
) -> PhysicsemelectrostaticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn PhysicsemelectrostaticPoint::mid(
  self : PhysicsemelectrostaticPoint,
  other : PhysicsemelectrostaticPoint,
) -> PhysicsemelectrostaticPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn PhysicsemelectrostaticPoint::lerp(
  self : PhysicsemelectrostaticPoint,
  other : PhysicsemelectrostaticPoint,
  t : Double,
) -> PhysicsemelectrostaticPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn PhysicsemelectrostaticPoint::to_string(
  self : PhysicsemelectrostaticPoint,
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
pub(all) struct PhysicsemelectrostaticSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn physics_em_electrostatic_make_series(
  vals : Array[Double],
  name : String,
) -> PhysicsemelectrostaticSeries {
  { vals, name, meta: 0, }
}

///|
pub fn PhysicsemelectrostaticSeries::len(
  self : PhysicsemelectrostaticSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn PhysicsemelectrostaticSeries::sum(
  self : PhysicsemelectrostaticSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn PhysicsemelectrostaticSeries::mean(
  self : PhysicsemelectrostaticSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn PhysicsemelectrostaticSeries::min(
  self : PhysicsemelectrostaticSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn PhysicsemelectrostaticSeries::max(
  self : PhysicsemelectrostaticSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn PhysicsemelectrostaticSeries::range(
  self : PhysicsemelectrostaticSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn PhysicsemelectrostaticSeries::variance(
  self : PhysicsemelectrostaticSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn PhysicsemelectrostaticSeries::std(
  self : PhysicsemelectrostaticSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn PhysicsemelectrostaticSeries::median(
  self : PhysicsemelectrostaticSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn PhysicsemelectrostaticSeries::scale(
  self : PhysicsemelectrostaticSeries,
  f : Double,
) -> PhysicsemelectrostaticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn PhysicsemelectrostaticSeries::add(
  self : PhysicsemelectrostaticSeries,
  other : PhysicsemelectrostaticSeries,
) -> PhysicsemelectrostaticSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsemelectrostaticSeries::sub(
  self : PhysicsemelectrostaticSeries,
  other : PhysicsemelectrostaticSeries,
) -> PhysicsemelectrostaticSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsemelectrostaticSeries::normalize(
  self : PhysicsemelectrostaticSeries,
) -> PhysicsemelectrostaticSeries {
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
pub fn PhysicsemelectrostaticSeries::cumsum(
  self : PhysicsemelectrostaticSeries,
) -> PhysicsemelectrostaticSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn PhysicsemelectrostaticSeries::to_string(
  self : PhysicsemelectrostaticSeries,
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
pub(all) struct PhysicsemelectrostaticMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn physics_em_electrostatic_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> PhysicsemelectrostaticMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn physics_em_electrostatic_matrix_identity(
  n : Int32,
) -> PhysicsemelectrostaticMatrix {
  let m = physics_em_electrostatic_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn PhysicsemelectrostaticMatrix::get(
  self : PhysicsemelectrostaticMatrix,
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
pub fn PhysicsemelectrostaticMatrix::transpose(
  self : PhysicsemelectrostaticMatrix,
) -> PhysicsemelectrostaticMatrix {
  let result = physics_em_electrostatic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsemelectrostaticMatrix::add(
  self : PhysicsemelectrostaticMatrix,
  other : PhysicsemelectrostaticMatrix,
) -> PhysicsemelectrostaticMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = physics_em_electrostatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsemelectrostaticMatrix::scale(
  self : PhysicsemelectrostaticMatrix,
  s : Double,
) -> PhysicsemelectrostaticMatrix {
  let result = physics_em_electrostatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn PhysicsemelectrostaticMatrix::multiply(
  self : PhysicsemelectrostaticMatrix,
  other : PhysicsemelectrostaticMatrix,
) -> PhysicsemelectrostaticMatrix {
  if self.cols != other.rows {
    return physics_em_electrostatic_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = physics_em_electrostatic_make_matrix(self.rows, other.cols, 0.0)
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
pub fn PhysicsemelectrostaticMatrix::trace(
  self : PhysicsemelectrostaticMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn PhysicsemelectrostaticMatrix::det(
  self : PhysicsemelectrostaticMatrix,
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
pub fn PhysicsemelectrostaticMatrix::norm(
  self : PhysicsemelectrostaticMatrix,
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
pub fn PhysicsemelectrostaticMatrix::to_string(
  self : PhysicsemelectrostaticMatrix,
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
pub(all) struct PhysicsemelectrostaticVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn physics_em_electrostatic_make_vector(
  comps : Array[Double],
) -> PhysicsemelectrostaticVector {
  { comps, dim: comps.length(), }
}

///|
pub fn physics_em_electrostatic_vector_zero(
  dim : Int32,
) -> PhysicsemelectrostaticVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn PhysicsemelectrostaticVector::add(
  self : PhysicsemelectrostaticVector,
  other : PhysicsemelectrostaticVector,
) -> PhysicsemelectrostaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsemelectrostaticVector::sub(
  self : PhysicsemelectrostaticVector,
  other : PhysicsemelectrostaticVector,
) -> PhysicsemelectrostaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsemelectrostaticVector::scale(
  self : PhysicsemelectrostaticVector,
  s : Double,
) -> PhysicsemelectrostaticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn PhysicsemelectrostaticVector::dot(
  self : PhysicsemelectrostaticVector,
  other : PhysicsemelectrostaticVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn PhysicsemelectrostaticVector::norm(
  self : PhysicsemelectrostaticVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn PhysicsemelectrostaticVector::normalize(
  self : PhysicsemelectrostaticVector,
) -> PhysicsemelectrostaticVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsemelectrostaticVector::dist(
  self : PhysicsemelectrostaticVector,
  other : PhysicsemelectrostaticVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn PhysicsemelectrostaticVector::to_string(
  self : PhysicsemelectrostaticVector,
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
pub(all) struct PhysicsemelectrostaticFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_frame_make(
  size : Int32,
) -> PhysicsemelectrostaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticFrame::len(
  self : PhysicsemelectrostaticFrame,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticFrame::get(
  self : PhysicsemelectrostaticFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticFrame::set(
  self : PhysicsemelectrostaticFrame,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticFrame::sum(
  self : PhysicsemelectrostaticFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticFrame::mean(
  self : PhysicsemelectrostaticFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticFrame::scale(
  self : PhysicsemelectrostaticFrame,
  f : Double,
) -> PhysicsemelectrostaticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticFrame::add(
  self : PhysicsemelectrostaticFrame,
  other : PhysicsemelectrostaticFrame,
) -> PhysicsemelectrostaticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticFrame::copy(
  self : PhysicsemelectrostaticFrame,
) -> PhysicsemelectrostaticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticFrame::fill(
  self : PhysicsemelectrostaticFrame,
  v : Double,
) -> PhysicsemelectrostaticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticFrame::min(
  self : PhysicsemelectrostaticFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticFrame::max(
  self : PhysicsemelectrostaticFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticFrame::to_string(
  self : PhysicsemelectrostaticFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_table_make(
  size : Int32,
) -> PhysicsemelectrostaticTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticTable::len(
  self : PhysicsemelectrostaticTable,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticTable::get(
  self : PhysicsemelectrostaticTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticTable::set(
  self : PhysicsemelectrostaticTable,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticTable::sum(
  self : PhysicsemelectrostaticTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticTable::mean(
  self : PhysicsemelectrostaticTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticTable::scale(
  self : PhysicsemelectrostaticTable,
  f : Double,
) -> PhysicsemelectrostaticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticTable::add(
  self : PhysicsemelectrostaticTable,
  other : PhysicsemelectrostaticTable,
) -> PhysicsemelectrostaticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticTable::copy(
  self : PhysicsemelectrostaticTable,
) -> PhysicsemelectrostaticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticTable::fill(
  self : PhysicsemelectrostaticTable,
  v : Double,
) -> PhysicsemelectrostaticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticTable::min(
  self : PhysicsemelectrostaticTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticTable::max(
  self : PhysicsemelectrostaticTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticTable::to_string(
  self : PhysicsemelectrostaticTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_graphn_make(
  size : Int32,
) -> PhysicsemelectrostaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticGraphN::len(
  self : PhysicsemelectrostaticGraphN,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticGraphN::get(
  self : PhysicsemelectrostaticGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticGraphN::set(
  self : PhysicsemelectrostaticGraphN,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticGraphN::sum(
  self : PhysicsemelectrostaticGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticGraphN::mean(
  self : PhysicsemelectrostaticGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticGraphN::scale(
  self : PhysicsemelectrostaticGraphN,
  f : Double,
) -> PhysicsemelectrostaticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticGraphN::add(
  self : PhysicsemelectrostaticGraphN,
  other : PhysicsemelectrostaticGraphN,
) -> PhysicsemelectrostaticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticGraphN::copy(
  self : PhysicsemelectrostaticGraphN,
) -> PhysicsemelectrostaticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticGraphN::fill(
  self : PhysicsemelectrostaticGraphN,
  v : Double,
) -> PhysicsemelectrostaticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticGraphN::min(
  self : PhysicsemelectrostaticGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticGraphN::max(
  self : PhysicsemelectrostaticGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticGraphN::to_string(
  self : PhysicsemelectrostaticGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_node_make(
  size : Int32,
) -> PhysicsemelectrostaticNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticNode::len(
  self : PhysicsemelectrostaticNode,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticNode::get(
  self : PhysicsemelectrostaticNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticNode::set(
  self : PhysicsemelectrostaticNode,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticNode::sum(
  self : PhysicsemelectrostaticNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticNode::mean(
  self : PhysicsemelectrostaticNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticNode::scale(
  self : PhysicsemelectrostaticNode,
  f : Double,
) -> PhysicsemelectrostaticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticNode::add(
  self : PhysicsemelectrostaticNode,
  other : PhysicsemelectrostaticNode,
) -> PhysicsemelectrostaticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticNode::copy(
  self : PhysicsemelectrostaticNode,
) -> PhysicsemelectrostaticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticNode::fill(
  self : PhysicsemelectrostaticNode,
  v : Double,
) -> PhysicsemelectrostaticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticNode::min(
  self : PhysicsemelectrostaticNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticNode::max(
  self : PhysicsemelectrostaticNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticNode::to_string(
  self : PhysicsemelectrostaticNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_edge_make(
  size : Int32,
) -> PhysicsemelectrostaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticEdge::len(
  self : PhysicsemelectrostaticEdge,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticEdge::get(
  self : PhysicsemelectrostaticEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticEdge::set(
  self : PhysicsemelectrostaticEdge,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticEdge::sum(
  self : PhysicsemelectrostaticEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticEdge::mean(
  self : PhysicsemelectrostaticEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticEdge::scale(
  self : PhysicsemelectrostaticEdge,
  f : Double,
) -> PhysicsemelectrostaticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticEdge::add(
  self : PhysicsemelectrostaticEdge,
  other : PhysicsemelectrostaticEdge,
) -> PhysicsemelectrostaticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticEdge::copy(
  self : PhysicsemelectrostaticEdge,
) -> PhysicsemelectrostaticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticEdge::fill(
  self : PhysicsemelectrostaticEdge,
  v : Double,
) -> PhysicsemelectrostaticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticEdge::min(
  self : PhysicsemelectrostaticEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticEdge::max(
  self : PhysicsemelectrostaticEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticEdge::to_string(
  self : PhysicsemelectrostaticEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_path_make(
  size : Int32,
) -> PhysicsemelectrostaticPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticPath::len(
  self : PhysicsemelectrostaticPath,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticPath::get(
  self : PhysicsemelectrostaticPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticPath::set(
  self : PhysicsemelectrostaticPath,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticPath::sum(
  self : PhysicsemelectrostaticPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticPath::mean(
  self : PhysicsemelectrostaticPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticPath::scale(
  self : PhysicsemelectrostaticPath,
  f : Double,
) -> PhysicsemelectrostaticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticPath::add(
  self : PhysicsemelectrostaticPath,
  other : PhysicsemelectrostaticPath,
) -> PhysicsemelectrostaticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticPath::copy(
  self : PhysicsemelectrostaticPath,
) -> PhysicsemelectrostaticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticPath::fill(
  self : PhysicsemelectrostaticPath,
  v : Double,
) -> PhysicsemelectrostaticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticPath::min(
  self : PhysicsemelectrostaticPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticPath::max(
  self : PhysicsemelectrostaticPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticPath::to_string(
  self : PhysicsemelectrostaticPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_cluster_make(
  size : Int32,
) -> PhysicsemelectrostaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticCluster::len(
  self : PhysicsemelectrostaticCluster,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticCluster::get(
  self : PhysicsemelectrostaticCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticCluster::set(
  self : PhysicsemelectrostaticCluster,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticCluster::sum(
  self : PhysicsemelectrostaticCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticCluster::mean(
  self : PhysicsemelectrostaticCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticCluster::scale(
  self : PhysicsemelectrostaticCluster,
  f : Double,
) -> PhysicsemelectrostaticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticCluster::add(
  self : PhysicsemelectrostaticCluster,
  other : PhysicsemelectrostaticCluster,
) -> PhysicsemelectrostaticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticCluster::copy(
  self : PhysicsemelectrostaticCluster,
) -> PhysicsemelectrostaticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticCluster::fill(
  self : PhysicsemelectrostaticCluster,
  v : Double,
) -> PhysicsemelectrostaticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticCluster::min(
  self : PhysicsemelectrostaticCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticCluster::max(
  self : PhysicsemelectrostaticCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticCluster::to_string(
  self : PhysicsemelectrostaticCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_model_make(
  size : Int32,
) -> PhysicsemelectrostaticModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticModel::len(
  self : PhysicsemelectrostaticModel,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticModel::get(
  self : PhysicsemelectrostaticModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticModel::set(
  self : PhysicsemelectrostaticModel,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticModel::sum(
  self : PhysicsemelectrostaticModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticModel::mean(
  self : PhysicsemelectrostaticModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticModel::scale(
  self : PhysicsemelectrostaticModel,
  f : Double,
) -> PhysicsemelectrostaticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticModel::add(
  self : PhysicsemelectrostaticModel,
  other : PhysicsemelectrostaticModel,
) -> PhysicsemelectrostaticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticModel::copy(
  self : PhysicsemelectrostaticModel,
) -> PhysicsemelectrostaticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticModel::fill(
  self : PhysicsemelectrostaticModel,
  v : Double,
) -> PhysicsemelectrostaticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticModel::min(
  self : PhysicsemelectrostaticModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticModel::max(
  self : PhysicsemelectrostaticModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticModel::to_string(
  self : PhysicsemelectrostaticModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_layer_make(
  size : Int32,
) -> PhysicsemelectrostaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticLayer::len(
  self : PhysicsemelectrostaticLayer,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticLayer::get(
  self : PhysicsemelectrostaticLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticLayer::set(
  self : PhysicsemelectrostaticLayer,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticLayer::sum(
  self : PhysicsemelectrostaticLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticLayer::mean(
  self : PhysicsemelectrostaticLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticLayer::scale(
  self : PhysicsemelectrostaticLayer,
  f : Double,
) -> PhysicsemelectrostaticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticLayer::add(
  self : PhysicsemelectrostaticLayer,
  other : PhysicsemelectrostaticLayer,
) -> PhysicsemelectrostaticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticLayer::copy(
  self : PhysicsemelectrostaticLayer,
) -> PhysicsemelectrostaticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticLayer::fill(
  self : PhysicsemelectrostaticLayer,
  v : Double,
) -> PhysicsemelectrostaticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticLayer::min(
  self : PhysicsemelectrostaticLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticLayer::max(
  self : PhysicsemelectrostaticLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticLayer::to_string(
  self : PhysicsemelectrostaticLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_buffer_make(
  size : Int32,
) -> PhysicsemelectrostaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticBuffer::len(
  self : PhysicsemelectrostaticBuffer,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticBuffer::get(
  self : PhysicsemelectrostaticBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticBuffer::set(
  self : PhysicsemelectrostaticBuffer,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticBuffer::sum(
  self : PhysicsemelectrostaticBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticBuffer::mean(
  self : PhysicsemelectrostaticBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticBuffer::scale(
  self : PhysicsemelectrostaticBuffer,
  f : Double,
) -> PhysicsemelectrostaticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticBuffer::add(
  self : PhysicsemelectrostaticBuffer,
  other : PhysicsemelectrostaticBuffer,
) -> PhysicsemelectrostaticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticBuffer::copy(
  self : PhysicsemelectrostaticBuffer,
) -> PhysicsemelectrostaticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticBuffer::fill(
  self : PhysicsemelectrostaticBuffer,
  v : Double,
) -> PhysicsemelectrostaticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticBuffer::min(
  self : PhysicsemelectrostaticBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticBuffer::max(
  self : PhysicsemelectrostaticBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticBuffer::to_string(
  self : PhysicsemelectrostaticBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_cursor_make(
  size : Int32,
) -> PhysicsemelectrostaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticCursor::len(
  self : PhysicsemelectrostaticCursor,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticCursor::get(
  self : PhysicsemelectrostaticCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticCursor::set(
  self : PhysicsemelectrostaticCursor,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticCursor::sum(
  self : PhysicsemelectrostaticCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticCursor::mean(
  self : PhysicsemelectrostaticCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticCursor::scale(
  self : PhysicsemelectrostaticCursor,
  f : Double,
) -> PhysicsemelectrostaticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticCursor::add(
  self : PhysicsemelectrostaticCursor,
  other : PhysicsemelectrostaticCursor,
) -> PhysicsemelectrostaticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticCursor::copy(
  self : PhysicsemelectrostaticCursor,
) -> PhysicsemelectrostaticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticCursor::fill(
  self : PhysicsemelectrostaticCursor,
  v : Double,
) -> PhysicsemelectrostaticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticCursor::min(
  self : PhysicsemelectrostaticCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticCursor::max(
  self : PhysicsemelectrostaticCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticCursor::to_string(
  self : PhysicsemelectrostaticCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_view_make(
  size : Int32,
) -> PhysicsemelectrostaticView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticView::len(
  self : PhysicsemelectrostaticView,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticView::get(
  self : PhysicsemelectrostaticView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticView::set(
  self : PhysicsemelectrostaticView,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticView::sum(
  self : PhysicsemelectrostaticView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticView::mean(
  self : PhysicsemelectrostaticView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticView::scale(
  self : PhysicsemelectrostaticView,
  f : Double,
) -> PhysicsemelectrostaticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticView::add(
  self : PhysicsemelectrostaticView,
  other : PhysicsemelectrostaticView,
) -> PhysicsemelectrostaticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticView::copy(
  self : PhysicsemelectrostaticView,
) -> PhysicsemelectrostaticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticView::fill(
  self : PhysicsemelectrostaticView,
  v : Double,
) -> PhysicsemelectrostaticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticView::min(
  self : PhysicsemelectrostaticView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticView::max(
  self : PhysicsemelectrostaticView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticView::to_string(
  self : PhysicsemelectrostaticView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_range_make(
  size : Int32,
) -> PhysicsemelectrostaticRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticRange::len(
  self : PhysicsemelectrostaticRange,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticRange::get(
  self : PhysicsemelectrostaticRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticRange::set(
  self : PhysicsemelectrostaticRange,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticRange::sum(
  self : PhysicsemelectrostaticRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticRange::mean(
  self : PhysicsemelectrostaticRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticRange::scale(
  self : PhysicsemelectrostaticRange,
  f : Double,
) -> PhysicsemelectrostaticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticRange::add(
  self : PhysicsemelectrostaticRange,
  other : PhysicsemelectrostaticRange,
) -> PhysicsemelectrostaticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticRange::copy(
  self : PhysicsemelectrostaticRange,
) -> PhysicsemelectrostaticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticRange::fill(
  self : PhysicsemelectrostaticRange,
  v : Double,
) -> PhysicsemelectrostaticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticRange::min(
  self : PhysicsemelectrostaticRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticRange::max(
  self : PhysicsemelectrostaticRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticRange::to_string(
  self : PhysicsemelectrostaticRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemelectrostaticSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_electrostatic_slice_make(
  size : Int32,
) -> PhysicsemelectrostaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemelectrostaticSlice::len(
  self : PhysicsemelectrostaticSlice,
) -> Int32 {
  self.size
}

///|
pub fn PhysicsemelectrostaticSlice::get(
  self : PhysicsemelectrostaticSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemelectrostaticSlice::set(
  self : PhysicsemelectrostaticSlice,
  i : Int32,
  v : Double,
) -> PhysicsemelectrostaticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticSlice::sum(
  self : PhysicsemelectrostaticSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemelectrostaticSlice::mean(
  self : PhysicsemelectrostaticSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemelectrostaticSlice::scale(
  self : PhysicsemelectrostaticSlice,
  f : Double,
) -> PhysicsemelectrostaticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticSlice::add(
  self : PhysicsemelectrostaticSlice,
  other : PhysicsemelectrostaticSlice,
) -> PhysicsemelectrostaticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticSlice::copy(
  self : PhysicsemelectrostaticSlice,
) -> PhysicsemelectrostaticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticSlice::fill(
  self : PhysicsemelectrostaticSlice,
  v : Double,
) -> PhysicsemelectrostaticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemelectrostaticSlice::min(
  self : PhysicsemelectrostaticSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemelectrostaticSlice::max(
  self : PhysicsemelectrostaticSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemelectrostaticSlice::to_string(
  self : PhysicsemelectrostaticSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
