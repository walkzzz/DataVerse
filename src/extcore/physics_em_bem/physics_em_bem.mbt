///|
///===
/// extcore/physics_em_bem
pub(all) struct PhysicsembemPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn physics_em_bem_make_point(x : Double, y : Double) -> PhysicsembemPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn physics_em_bem_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> PhysicsembemPoint {
  { x, y, z, label: 0, }
}

///|
pub fn PhysicsembemPoint::x(self : PhysicsembemPoint) -> Double {
  self.x
}

///|
pub fn PhysicsembemPoint::y(self : PhysicsembemPoint) -> Double {
  self.y
}

///|
pub fn PhysicsembemPoint::z(self : PhysicsembemPoint) -> Double {
  self.z
}

///|
pub fn PhysicsembemPoint::label(self : PhysicsembemPoint) -> Int32 {
  self.label
}

///|
pub fn PhysicsembemPoint::dist(
  self : PhysicsembemPoint,
  other : PhysicsembemPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn PhysicsembemPoint::add(
  self : PhysicsembemPoint,
  other : PhysicsembemPoint,
) -> PhysicsembemPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsembemPoint::sub(
  self : PhysicsembemPoint,
  other : PhysicsembemPoint,
) -> PhysicsembemPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsembemPoint::scale(
  self : PhysicsembemPoint,
  s : Double,
) -> PhysicsembemPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn PhysicsembemPoint::dot(
  self : PhysicsembemPoint,
  other : PhysicsembemPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn PhysicsembemPoint::cross(
  self : PhysicsembemPoint,
  other : PhysicsembemPoint,
) -> PhysicsembemPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn PhysicsembemPoint::norm(self : PhysicsembemPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn PhysicsembemPoint::normalize(
  self : PhysicsembemPoint,
) -> PhysicsembemPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsembemPoint::negate(self : PhysicsembemPoint) -> PhysicsembemPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn PhysicsembemPoint::mid(
  self : PhysicsembemPoint,
  other : PhysicsembemPoint,
) -> PhysicsembemPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn PhysicsembemPoint::lerp(
  self : PhysicsembemPoint,
  other : PhysicsembemPoint,
  t : Double,
) -> PhysicsembemPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn PhysicsembemPoint::to_string(self : PhysicsembemPoint) -> String {
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
pub(all) struct PhysicsembemSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn physics_em_bem_make_series(
  vals : Array[Double],
  name : String,
) -> PhysicsembemSeries {
  { vals, name, meta: 0, }
}

///|
pub fn PhysicsembemSeries::len(self : PhysicsembemSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn PhysicsembemSeries::sum(self : PhysicsembemSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn PhysicsembemSeries::mean(self : PhysicsembemSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn PhysicsembemSeries::min(self : PhysicsembemSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn PhysicsembemSeries::max(self : PhysicsembemSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn PhysicsembemSeries::range(self : PhysicsembemSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn PhysicsembemSeries::variance(self : PhysicsembemSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn PhysicsembemSeries::std(self : PhysicsembemSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn PhysicsembemSeries::median(self : PhysicsembemSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn PhysicsembemSeries::scale(
  self : PhysicsembemSeries,
  f : Double,
) -> PhysicsembemSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn PhysicsembemSeries::add(
  self : PhysicsembemSeries,
  other : PhysicsembemSeries,
) -> PhysicsembemSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsembemSeries::sub(
  self : PhysicsembemSeries,
  other : PhysicsembemSeries,
) -> PhysicsembemSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsembemSeries::normalize(
  self : PhysicsembemSeries,
) -> PhysicsembemSeries {
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
pub fn PhysicsembemSeries::cumsum(
  self : PhysicsembemSeries,
) -> PhysicsembemSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn PhysicsembemSeries::to_string(self : PhysicsembemSeries) -> String {
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
pub(all) struct PhysicsembemMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn physics_em_bem_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> PhysicsembemMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn physics_em_bem_matrix_identity(n : Int32) -> PhysicsembemMatrix {
  let m = physics_em_bem_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn PhysicsembemMatrix::get(
  self : PhysicsembemMatrix,
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
pub fn PhysicsembemMatrix::transpose(
  self : PhysicsembemMatrix,
) -> PhysicsembemMatrix {
  let result = physics_em_bem_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsembemMatrix::add(
  self : PhysicsembemMatrix,
  other : PhysicsembemMatrix,
) -> PhysicsembemMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = physics_em_bem_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsembemMatrix::scale(
  self : PhysicsembemMatrix,
  s : Double,
) -> PhysicsembemMatrix {
  let result = physics_em_bem_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn PhysicsembemMatrix::multiply(
  self : PhysicsembemMatrix,
  other : PhysicsembemMatrix,
) -> PhysicsembemMatrix {
  if self.cols != other.rows {
    return physics_em_bem_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = physics_em_bem_make_matrix(self.rows, other.cols, 0.0)
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
pub fn PhysicsembemMatrix::trace(self : PhysicsembemMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn PhysicsembemMatrix::det(self : PhysicsembemMatrix) -> Double {
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
pub fn PhysicsembemMatrix::norm(self : PhysicsembemMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn PhysicsembemMatrix::to_string(self : PhysicsembemMatrix) -> String {
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
pub(all) struct PhysicsembemVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn physics_em_bem_make_vector(comps : Array[Double]) -> PhysicsembemVector {
  { comps, dim: comps.length(), }
}

///|
pub fn physics_em_bem_vector_zero(dim : Int32) -> PhysicsembemVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn PhysicsembemVector::add(
  self : PhysicsembemVector,
  other : PhysicsembemVector,
) -> PhysicsembemVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsembemVector::sub(
  self : PhysicsembemVector,
  other : PhysicsembemVector,
) -> PhysicsembemVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsembemVector::scale(
  self : PhysicsembemVector,
  s : Double,
) -> PhysicsembemVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn PhysicsembemVector::dot(
  self : PhysicsembemVector,
  other : PhysicsembemVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn PhysicsembemVector::norm(self : PhysicsembemVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn PhysicsembemVector::normalize(
  self : PhysicsembemVector,
) -> PhysicsembemVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsembemVector::dist(
  self : PhysicsembemVector,
  other : PhysicsembemVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn PhysicsembemVector::to_string(self : PhysicsembemVector) -> String {
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
pub(all) struct PhysicsembemFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_frame_make(size : Int32) -> PhysicsembemFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemFrame::len(self : PhysicsembemFrame) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemFrame::get(self : PhysicsembemFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemFrame::set(
  self : PhysicsembemFrame,
  i : Int32,
  v : Double,
) -> PhysicsembemFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemFrame::sum(self : PhysicsembemFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemFrame::mean(self : PhysicsembemFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemFrame::scale(
  self : PhysicsembemFrame,
  f : Double,
) -> PhysicsembemFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemFrame::add(
  self : PhysicsembemFrame,
  other : PhysicsembemFrame,
) -> PhysicsembemFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemFrame::copy(self : PhysicsembemFrame) -> PhysicsembemFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemFrame::fill(
  self : PhysicsembemFrame,
  v : Double,
) -> PhysicsembemFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemFrame::min(self : PhysicsembemFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemFrame::max(self : PhysicsembemFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemFrame::to_string(self : PhysicsembemFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_table_make(size : Int32) -> PhysicsembemTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemTable::len(self : PhysicsembemTable) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemTable::get(self : PhysicsembemTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemTable::set(
  self : PhysicsembemTable,
  i : Int32,
  v : Double,
) -> PhysicsembemTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemTable::sum(self : PhysicsembemTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemTable::mean(self : PhysicsembemTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemTable::scale(
  self : PhysicsembemTable,
  f : Double,
) -> PhysicsembemTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemTable::add(
  self : PhysicsembemTable,
  other : PhysicsembemTable,
) -> PhysicsembemTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemTable::copy(self : PhysicsembemTable) -> PhysicsembemTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemTable::fill(
  self : PhysicsembemTable,
  v : Double,
) -> PhysicsembemTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemTable::min(self : PhysicsembemTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemTable::max(self : PhysicsembemTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemTable::to_string(self : PhysicsembemTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_graphn_make(size : Int32) -> PhysicsembemGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemGraphN::len(self : PhysicsembemGraphN) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemGraphN::get(self : PhysicsembemGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemGraphN::set(
  self : PhysicsembemGraphN,
  i : Int32,
  v : Double,
) -> PhysicsembemGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemGraphN::sum(self : PhysicsembemGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemGraphN::mean(self : PhysicsembemGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemGraphN::scale(
  self : PhysicsembemGraphN,
  f : Double,
) -> PhysicsembemGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemGraphN::add(
  self : PhysicsembemGraphN,
  other : PhysicsembemGraphN,
) -> PhysicsembemGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemGraphN::copy(
  self : PhysicsembemGraphN,
) -> PhysicsembemGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemGraphN::fill(
  self : PhysicsembemGraphN,
  v : Double,
) -> PhysicsembemGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemGraphN::min(self : PhysicsembemGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemGraphN::max(self : PhysicsembemGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemGraphN::to_string(self : PhysicsembemGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_node_make(size : Int32) -> PhysicsembemNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemNode::len(self : PhysicsembemNode) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemNode::get(self : PhysicsembemNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemNode::set(
  self : PhysicsembemNode,
  i : Int32,
  v : Double,
) -> PhysicsembemNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemNode::sum(self : PhysicsembemNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemNode::mean(self : PhysicsembemNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemNode::scale(
  self : PhysicsembemNode,
  f : Double,
) -> PhysicsembemNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemNode::add(
  self : PhysicsembemNode,
  other : PhysicsembemNode,
) -> PhysicsembemNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemNode::copy(self : PhysicsembemNode) -> PhysicsembemNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemNode::fill(
  self : PhysicsembemNode,
  v : Double,
) -> PhysicsembemNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemNode::min(self : PhysicsembemNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemNode::max(self : PhysicsembemNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemNode::to_string(self : PhysicsembemNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_edge_make(size : Int32) -> PhysicsembemEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemEdge::len(self : PhysicsembemEdge) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemEdge::get(self : PhysicsembemEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemEdge::set(
  self : PhysicsembemEdge,
  i : Int32,
  v : Double,
) -> PhysicsembemEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemEdge::sum(self : PhysicsembemEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemEdge::mean(self : PhysicsembemEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemEdge::scale(
  self : PhysicsembemEdge,
  f : Double,
) -> PhysicsembemEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemEdge::add(
  self : PhysicsembemEdge,
  other : PhysicsembemEdge,
) -> PhysicsembemEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemEdge::copy(self : PhysicsembemEdge) -> PhysicsembemEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemEdge::fill(
  self : PhysicsembemEdge,
  v : Double,
) -> PhysicsembemEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemEdge::min(self : PhysicsembemEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemEdge::max(self : PhysicsembemEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemEdge::to_string(self : PhysicsembemEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_path_make(size : Int32) -> PhysicsembemPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemPath::len(self : PhysicsembemPath) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemPath::get(self : PhysicsembemPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemPath::set(
  self : PhysicsembemPath,
  i : Int32,
  v : Double,
) -> PhysicsembemPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemPath::sum(self : PhysicsembemPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemPath::mean(self : PhysicsembemPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemPath::scale(
  self : PhysicsembemPath,
  f : Double,
) -> PhysicsembemPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemPath::add(
  self : PhysicsembemPath,
  other : PhysicsembemPath,
) -> PhysicsembemPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemPath::copy(self : PhysicsembemPath) -> PhysicsembemPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemPath::fill(
  self : PhysicsembemPath,
  v : Double,
) -> PhysicsembemPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemPath::min(self : PhysicsembemPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemPath::max(self : PhysicsembemPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemPath::to_string(self : PhysicsembemPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_cluster_make(size : Int32) -> PhysicsembemCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemCluster::len(self : PhysicsembemCluster) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemCluster::get(
  self : PhysicsembemCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemCluster::set(
  self : PhysicsembemCluster,
  i : Int32,
  v : Double,
) -> PhysicsembemCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemCluster::sum(self : PhysicsembemCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemCluster::mean(self : PhysicsembemCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemCluster::scale(
  self : PhysicsembemCluster,
  f : Double,
) -> PhysicsembemCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemCluster::add(
  self : PhysicsembemCluster,
  other : PhysicsembemCluster,
) -> PhysicsembemCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemCluster::copy(
  self : PhysicsembemCluster,
) -> PhysicsembemCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemCluster::fill(
  self : PhysicsembemCluster,
  v : Double,
) -> PhysicsembemCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemCluster::min(self : PhysicsembemCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemCluster::max(self : PhysicsembemCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemCluster::to_string(self : PhysicsembemCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_model_make(size : Int32) -> PhysicsembemModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemModel::len(self : PhysicsembemModel) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemModel::get(self : PhysicsembemModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemModel::set(
  self : PhysicsembemModel,
  i : Int32,
  v : Double,
) -> PhysicsembemModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemModel::sum(self : PhysicsembemModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemModel::mean(self : PhysicsembemModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemModel::scale(
  self : PhysicsembemModel,
  f : Double,
) -> PhysicsembemModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemModel::add(
  self : PhysicsembemModel,
  other : PhysicsembemModel,
) -> PhysicsembemModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemModel::copy(self : PhysicsembemModel) -> PhysicsembemModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemModel::fill(
  self : PhysicsembemModel,
  v : Double,
) -> PhysicsembemModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemModel::min(self : PhysicsembemModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemModel::max(self : PhysicsembemModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemModel::to_string(self : PhysicsembemModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_layer_make(size : Int32) -> PhysicsembemLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemLayer::len(self : PhysicsembemLayer) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemLayer::get(self : PhysicsembemLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemLayer::set(
  self : PhysicsembemLayer,
  i : Int32,
  v : Double,
) -> PhysicsembemLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemLayer::sum(self : PhysicsembemLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemLayer::mean(self : PhysicsembemLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemLayer::scale(
  self : PhysicsembemLayer,
  f : Double,
) -> PhysicsembemLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemLayer::add(
  self : PhysicsembemLayer,
  other : PhysicsembemLayer,
) -> PhysicsembemLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemLayer::copy(self : PhysicsembemLayer) -> PhysicsembemLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemLayer::fill(
  self : PhysicsembemLayer,
  v : Double,
) -> PhysicsembemLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemLayer::min(self : PhysicsembemLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemLayer::max(self : PhysicsembemLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemLayer::to_string(self : PhysicsembemLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_buffer_make(size : Int32) -> PhysicsembemBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemBuffer::len(self : PhysicsembemBuffer) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemBuffer::get(self : PhysicsembemBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemBuffer::set(
  self : PhysicsembemBuffer,
  i : Int32,
  v : Double,
) -> PhysicsembemBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemBuffer::sum(self : PhysicsembemBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemBuffer::mean(self : PhysicsembemBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemBuffer::scale(
  self : PhysicsembemBuffer,
  f : Double,
) -> PhysicsembemBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemBuffer::add(
  self : PhysicsembemBuffer,
  other : PhysicsembemBuffer,
) -> PhysicsembemBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemBuffer::copy(
  self : PhysicsembemBuffer,
) -> PhysicsembemBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemBuffer::fill(
  self : PhysicsembemBuffer,
  v : Double,
) -> PhysicsembemBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemBuffer::min(self : PhysicsembemBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemBuffer::max(self : PhysicsembemBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemBuffer::to_string(self : PhysicsembemBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_cursor_make(size : Int32) -> PhysicsembemCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemCursor::len(self : PhysicsembemCursor) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemCursor::get(self : PhysicsembemCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemCursor::set(
  self : PhysicsembemCursor,
  i : Int32,
  v : Double,
) -> PhysicsembemCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemCursor::sum(self : PhysicsembemCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemCursor::mean(self : PhysicsembemCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemCursor::scale(
  self : PhysicsembemCursor,
  f : Double,
) -> PhysicsembemCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemCursor::add(
  self : PhysicsembemCursor,
  other : PhysicsembemCursor,
) -> PhysicsembemCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemCursor::copy(
  self : PhysicsembemCursor,
) -> PhysicsembemCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemCursor::fill(
  self : PhysicsembemCursor,
  v : Double,
) -> PhysicsembemCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemCursor::min(self : PhysicsembemCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemCursor::max(self : PhysicsembemCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemCursor::to_string(self : PhysicsembemCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_view_make(size : Int32) -> PhysicsembemView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemView::len(self : PhysicsembemView) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemView::get(self : PhysicsembemView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemView::set(
  self : PhysicsembemView,
  i : Int32,
  v : Double,
) -> PhysicsembemView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemView::sum(self : PhysicsembemView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemView::mean(self : PhysicsembemView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemView::scale(
  self : PhysicsembemView,
  f : Double,
) -> PhysicsembemView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemView::add(
  self : PhysicsembemView,
  other : PhysicsembemView,
) -> PhysicsembemView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemView::copy(self : PhysicsembemView) -> PhysicsembemView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemView::fill(
  self : PhysicsembemView,
  v : Double,
) -> PhysicsembemView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemView::min(self : PhysicsembemView) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemView::max(self : PhysicsembemView) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemView::to_string(self : PhysicsembemView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_range_make(size : Int32) -> PhysicsembemRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemRange::len(self : PhysicsembemRange) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemRange::get(self : PhysicsembemRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemRange::set(
  self : PhysicsembemRange,
  i : Int32,
  v : Double,
) -> PhysicsembemRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemRange::sum(self : PhysicsembemRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemRange::mean(self : PhysicsembemRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemRange::scale(
  self : PhysicsembemRange,
  f : Double,
) -> PhysicsembemRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemRange::add(
  self : PhysicsembemRange,
  other : PhysicsembemRange,
) -> PhysicsembemRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemRange::copy(self : PhysicsembemRange) -> PhysicsembemRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemRange::fill(
  self : PhysicsembemRange,
  v : Double,
) -> PhysicsembemRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemRange::min(self : PhysicsembemRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemRange::max(self : PhysicsembemRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemRange::to_string(self : PhysicsembemRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsembemSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_bem_slice_make(size : Int32) -> PhysicsembemSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsembemSlice::len(self : PhysicsembemSlice) -> Int32 {
  self.size
}

///|
pub fn PhysicsembemSlice::get(self : PhysicsembemSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsembemSlice::set(
  self : PhysicsembemSlice,
  i : Int32,
  v : Double,
) -> PhysicsembemSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemSlice::sum(self : PhysicsembemSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsembemSlice::mean(self : PhysicsembemSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsembemSlice::scale(
  self : PhysicsembemSlice,
  f : Double,
) -> PhysicsembemSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemSlice::add(
  self : PhysicsembemSlice,
  other : PhysicsembemSlice,
) -> PhysicsembemSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsembemSlice::copy(self : PhysicsembemSlice) -> PhysicsembemSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemSlice::fill(
  self : PhysicsembemSlice,
  v : Double,
) -> PhysicsembemSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsembemSlice::min(self : PhysicsembemSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsembemSlice::max(self : PhysicsembemSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsembemSlice::to_string(self : PhysicsembemSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
