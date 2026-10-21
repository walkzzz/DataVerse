///|
///===
/// extcore/ml_rl_sarsa
pub(all) struct MlrlsarsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ml_rl_sarsa_make_point(x : Double, y : Double) -> MlrlsarsaPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ml_rl_sarsa_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MlrlsarsaPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MlrlsarsaPoint::x(self : MlrlsarsaPoint) -> Double {
  self.x
}

///|
pub fn MlrlsarsaPoint::y(self : MlrlsarsaPoint) -> Double {
  self.y
}

///|
pub fn MlrlsarsaPoint::z(self : MlrlsarsaPoint) -> Double {
  self.z
}

///|
pub fn MlrlsarsaPoint::label(self : MlrlsarsaPoint) -> Int32 {
  self.label
}

///|
pub fn MlrlsarsaPoint::dist(
  self : MlrlsarsaPoint,
  other : MlrlsarsaPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MlrlsarsaPoint::add(
  self : MlrlsarsaPoint,
  other : MlrlsarsaPoint,
) -> MlrlsarsaPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MlrlsarsaPoint::sub(
  self : MlrlsarsaPoint,
  other : MlrlsarsaPoint,
) -> MlrlsarsaPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MlrlsarsaPoint::scale(
  self : MlrlsarsaPoint,
  s : Double,
) -> MlrlsarsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MlrlsarsaPoint::dot(
  self : MlrlsarsaPoint,
  other : MlrlsarsaPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MlrlsarsaPoint::cross(
  self : MlrlsarsaPoint,
  other : MlrlsarsaPoint,
) -> MlrlsarsaPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MlrlsarsaPoint::norm(self : MlrlsarsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MlrlsarsaPoint::normalize(self : MlrlsarsaPoint) -> MlrlsarsaPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlrlsarsaPoint::negate(self : MlrlsarsaPoint) -> MlrlsarsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MlrlsarsaPoint::mid(
  self : MlrlsarsaPoint,
  other : MlrlsarsaPoint,
) -> MlrlsarsaPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MlrlsarsaPoint::lerp(
  self : MlrlsarsaPoint,
  other : MlrlsarsaPoint,
  t : Double,
) -> MlrlsarsaPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MlrlsarsaPoint::to_string(self : MlrlsarsaPoint) -> String {
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
pub(all) struct MlrlsarsaSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ml_rl_sarsa_make_series(
  vals : Array[Double],
  name : String,
) -> MlrlsarsaSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MlrlsarsaSeries::len(self : MlrlsarsaSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MlrlsarsaSeries::sum(self : MlrlsarsaSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MlrlsarsaSeries::mean(self : MlrlsarsaSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MlrlsarsaSeries::min(self : MlrlsarsaSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MlrlsarsaSeries::max(self : MlrlsarsaSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MlrlsarsaSeries::range(self : MlrlsarsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MlrlsarsaSeries::variance(self : MlrlsarsaSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MlrlsarsaSeries::std(self : MlrlsarsaSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MlrlsarsaSeries::median(self : MlrlsarsaSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MlrlsarsaSeries::scale(
  self : MlrlsarsaSeries,
  f : Double,
) -> MlrlsarsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MlrlsarsaSeries::add(
  self : MlrlsarsaSeries,
  other : MlrlsarsaSeries,
) -> MlrlsarsaSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlrlsarsaSeries::sub(
  self : MlrlsarsaSeries,
  other : MlrlsarsaSeries,
) -> MlrlsarsaSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlrlsarsaSeries::normalize(self : MlrlsarsaSeries) -> MlrlsarsaSeries {
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
pub fn MlrlsarsaSeries::cumsum(self : MlrlsarsaSeries) -> MlrlsarsaSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MlrlsarsaSeries::to_string(self : MlrlsarsaSeries) -> String {
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
pub(all) struct MlrlsarsaMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ml_rl_sarsa_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MlrlsarsaMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ml_rl_sarsa_matrix_identity(n : Int32) -> MlrlsarsaMatrix {
  let m = ml_rl_sarsa_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MlrlsarsaMatrix::get(
  self : MlrlsarsaMatrix,
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
pub fn MlrlsarsaMatrix::transpose(self : MlrlsarsaMatrix) -> MlrlsarsaMatrix {
  let result = ml_rl_sarsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MlrlsarsaMatrix::add(
  self : MlrlsarsaMatrix,
  other : MlrlsarsaMatrix,
) -> MlrlsarsaMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ml_rl_sarsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MlrlsarsaMatrix::scale(
  self : MlrlsarsaMatrix,
  s : Double,
) -> MlrlsarsaMatrix {
  let result = ml_rl_sarsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MlrlsarsaMatrix::multiply(
  self : MlrlsarsaMatrix,
  other : MlrlsarsaMatrix,
) -> MlrlsarsaMatrix {
  if self.cols != other.rows {
    return ml_rl_sarsa_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ml_rl_sarsa_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MlrlsarsaMatrix::trace(self : MlrlsarsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MlrlsarsaMatrix::det(self : MlrlsarsaMatrix) -> Double {
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
pub fn MlrlsarsaMatrix::norm(self : MlrlsarsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MlrlsarsaMatrix::to_string(self : MlrlsarsaMatrix) -> String {
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
pub(all) struct MlrlsarsaVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ml_rl_sarsa_make_vector(comps : Array[Double]) -> MlrlsarsaVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ml_rl_sarsa_vector_zero(dim : Int32) -> MlrlsarsaVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MlrlsarsaVector::add(
  self : MlrlsarsaVector,
  other : MlrlsarsaVector,
) -> MlrlsarsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlrlsarsaVector::sub(
  self : MlrlsarsaVector,
  other : MlrlsarsaVector,
) -> MlrlsarsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlrlsarsaVector::scale(
  self : MlrlsarsaVector,
  s : Double,
) -> MlrlsarsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MlrlsarsaVector::dot(
  self : MlrlsarsaVector,
  other : MlrlsarsaVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MlrlsarsaVector::norm(self : MlrlsarsaVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MlrlsarsaVector::normalize(self : MlrlsarsaVector) -> MlrlsarsaVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlrlsarsaVector::dist(
  self : MlrlsarsaVector,
  other : MlrlsarsaVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MlrlsarsaVector::to_string(self : MlrlsarsaVector) -> String {
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
pub(all) struct MlrlsarsaFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_frame_make(size : Int32) -> MlrlsarsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaFrame::len(self : MlrlsarsaFrame) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaFrame::get(self : MlrlsarsaFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaFrame::set(
  self : MlrlsarsaFrame,
  i : Int32,
  v : Double,
) -> MlrlsarsaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaFrame::sum(self : MlrlsarsaFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaFrame::mean(self : MlrlsarsaFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaFrame::scale(
  self : MlrlsarsaFrame,
  f : Double,
) -> MlrlsarsaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaFrame::add(
  self : MlrlsarsaFrame,
  other : MlrlsarsaFrame,
) -> MlrlsarsaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaFrame::copy(self : MlrlsarsaFrame) -> MlrlsarsaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaFrame::fill(
  self : MlrlsarsaFrame,
  v : Double,
) -> MlrlsarsaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaFrame::min(self : MlrlsarsaFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaFrame::max(self : MlrlsarsaFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaFrame::to_string(self : MlrlsarsaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_table_make(size : Int32) -> MlrlsarsaTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaTable::len(self : MlrlsarsaTable) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaTable::get(self : MlrlsarsaTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaTable::set(
  self : MlrlsarsaTable,
  i : Int32,
  v : Double,
) -> MlrlsarsaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaTable::sum(self : MlrlsarsaTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaTable::mean(self : MlrlsarsaTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaTable::scale(
  self : MlrlsarsaTable,
  f : Double,
) -> MlrlsarsaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaTable::add(
  self : MlrlsarsaTable,
  other : MlrlsarsaTable,
) -> MlrlsarsaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaTable::copy(self : MlrlsarsaTable) -> MlrlsarsaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaTable::fill(
  self : MlrlsarsaTable,
  v : Double,
) -> MlrlsarsaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaTable::min(self : MlrlsarsaTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaTable::max(self : MlrlsarsaTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaTable::to_string(self : MlrlsarsaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_graphn_make(size : Int32) -> MlrlsarsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaGraphN::len(self : MlrlsarsaGraphN) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaGraphN::get(self : MlrlsarsaGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaGraphN::set(
  self : MlrlsarsaGraphN,
  i : Int32,
  v : Double,
) -> MlrlsarsaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaGraphN::sum(self : MlrlsarsaGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaGraphN::mean(self : MlrlsarsaGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaGraphN::scale(
  self : MlrlsarsaGraphN,
  f : Double,
) -> MlrlsarsaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaGraphN::add(
  self : MlrlsarsaGraphN,
  other : MlrlsarsaGraphN,
) -> MlrlsarsaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaGraphN::copy(self : MlrlsarsaGraphN) -> MlrlsarsaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaGraphN::fill(
  self : MlrlsarsaGraphN,
  v : Double,
) -> MlrlsarsaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaGraphN::min(self : MlrlsarsaGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaGraphN::max(self : MlrlsarsaGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaGraphN::to_string(self : MlrlsarsaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_node_make(size : Int32) -> MlrlsarsaNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaNode::len(self : MlrlsarsaNode) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaNode::get(self : MlrlsarsaNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaNode::set(
  self : MlrlsarsaNode,
  i : Int32,
  v : Double,
) -> MlrlsarsaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaNode::sum(self : MlrlsarsaNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaNode::mean(self : MlrlsarsaNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaNode::scale(self : MlrlsarsaNode, f : Double) -> MlrlsarsaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaNode::add(
  self : MlrlsarsaNode,
  other : MlrlsarsaNode,
) -> MlrlsarsaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaNode::copy(self : MlrlsarsaNode) -> MlrlsarsaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaNode::fill(self : MlrlsarsaNode, v : Double) -> MlrlsarsaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaNode::min(self : MlrlsarsaNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaNode::max(self : MlrlsarsaNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaNode::to_string(self : MlrlsarsaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_edge_make(size : Int32) -> MlrlsarsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaEdge::len(self : MlrlsarsaEdge) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaEdge::get(self : MlrlsarsaEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaEdge::set(
  self : MlrlsarsaEdge,
  i : Int32,
  v : Double,
) -> MlrlsarsaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaEdge::sum(self : MlrlsarsaEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaEdge::mean(self : MlrlsarsaEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaEdge::scale(self : MlrlsarsaEdge, f : Double) -> MlrlsarsaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaEdge::add(
  self : MlrlsarsaEdge,
  other : MlrlsarsaEdge,
) -> MlrlsarsaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaEdge::copy(self : MlrlsarsaEdge) -> MlrlsarsaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaEdge::fill(self : MlrlsarsaEdge, v : Double) -> MlrlsarsaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaEdge::min(self : MlrlsarsaEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaEdge::max(self : MlrlsarsaEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaEdge::to_string(self : MlrlsarsaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_path_make(size : Int32) -> MlrlsarsaPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaPath::len(self : MlrlsarsaPath) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaPath::get(self : MlrlsarsaPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaPath::set(
  self : MlrlsarsaPath,
  i : Int32,
  v : Double,
) -> MlrlsarsaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaPath::sum(self : MlrlsarsaPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaPath::mean(self : MlrlsarsaPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaPath::scale(self : MlrlsarsaPath, f : Double) -> MlrlsarsaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaPath::add(
  self : MlrlsarsaPath,
  other : MlrlsarsaPath,
) -> MlrlsarsaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaPath::copy(self : MlrlsarsaPath) -> MlrlsarsaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaPath::fill(self : MlrlsarsaPath, v : Double) -> MlrlsarsaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaPath::min(self : MlrlsarsaPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaPath::max(self : MlrlsarsaPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaPath::to_string(self : MlrlsarsaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_cluster_make(size : Int32) -> MlrlsarsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaCluster::len(self : MlrlsarsaCluster) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaCluster::get(self : MlrlsarsaCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaCluster::set(
  self : MlrlsarsaCluster,
  i : Int32,
  v : Double,
) -> MlrlsarsaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaCluster::sum(self : MlrlsarsaCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaCluster::mean(self : MlrlsarsaCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaCluster::scale(
  self : MlrlsarsaCluster,
  f : Double,
) -> MlrlsarsaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaCluster::add(
  self : MlrlsarsaCluster,
  other : MlrlsarsaCluster,
) -> MlrlsarsaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaCluster::copy(self : MlrlsarsaCluster) -> MlrlsarsaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaCluster::fill(
  self : MlrlsarsaCluster,
  v : Double,
) -> MlrlsarsaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaCluster::min(self : MlrlsarsaCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaCluster::max(self : MlrlsarsaCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaCluster::to_string(self : MlrlsarsaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_model_make(size : Int32) -> MlrlsarsaModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaModel::len(self : MlrlsarsaModel) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaModel::get(self : MlrlsarsaModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaModel::set(
  self : MlrlsarsaModel,
  i : Int32,
  v : Double,
) -> MlrlsarsaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaModel::sum(self : MlrlsarsaModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaModel::mean(self : MlrlsarsaModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaModel::scale(
  self : MlrlsarsaModel,
  f : Double,
) -> MlrlsarsaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaModel::add(
  self : MlrlsarsaModel,
  other : MlrlsarsaModel,
) -> MlrlsarsaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaModel::copy(self : MlrlsarsaModel) -> MlrlsarsaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaModel::fill(
  self : MlrlsarsaModel,
  v : Double,
) -> MlrlsarsaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaModel::min(self : MlrlsarsaModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaModel::max(self : MlrlsarsaModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaModel::to_string(self : MlrlsarsaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_layer_make(size : Int32) -> MlrlsarsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaLayer::len(self : MlrlsarsaLayer) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaLayer::get(self : MlrlsarsaLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaLayer::set(
  self : MlrlsarsaLayer,
  i : Int32,
  v : Double,
) -> MlrlsarsaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaLayer::sum(self : MlrlsarsaLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaLayer::mean(self : MlrlsarsaLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaLayer::scale(
  self : MlrlsarsaLayer,
  f : Double,
) -> MlrlsarsaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaLayer::add(
  self : MlrlsarsaLayer,
  other : MlrlsarsaLayer,
) -> MlrlsarsaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaLayer::copy(self : MlrlsarsaLayer) -> MlrlsarsaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaLayer::fill(
  self : MlrlsarsaLayer,
  v : Double,
) -> MlrlsarsaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaLayer::min(self : MlrlsarsaLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaLayer::max(self : MlrlsarsaLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaLayer::to_string(self : MlrlsarsaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_buffer_make(size : Int32) -> MlrlsarsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaBuffer::len(self : MlrlsarsaBuffer) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaBuffer::get(self : MlrlsarsaBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaBuffer::set(
  self : MlrlsarsaBuffer,
  i : Int32,
  v : Double,
) -> MlrlsarsaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaBuffer::sum(self : MlrlsarsaBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaBuffer::mean(self : MlrlsarsaBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaBuffer::scale(
  self : MlrlsarsaBuffer,
  f : Double,
) -> MlrlsarsaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaBuffer::add(
  self : MlrlsarsaBuffer,
  other : MlrlsarsaBuffer,
) -> MlrlsarsaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaBuffer::copy(self : MlrlsarsaBuffer) -> MlrlsarsaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaBuffer::fill(
  self : MlrlsarsaBuffer,
  v : Double,
) -> MlrlsarsaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaBuffer::min(self : MlrlsarsaBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaBuffer::max(self : MlrlsarsaBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaBuffer::to_string(self : MlrlsarsaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_cursor_make(size : Int32) -> MlrlsarsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaCursor::len(self : MlrlsarsaCursor) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaCursor::get(self : MlrlsarsaCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaCursor::set(
  self : MlrlsarsaCursor,
  i : Int32,
  v : Double,
) -> MlrlsarsaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaCursor::sum(self : MlrlsarsaCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaCursor::mean(self : MlrlsarsaCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaCursor::scale(
  self : MlrlsarsaCursor,
  f : Double,
) -> MlrlsarsaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaCursor::add(
  self : MlrlsarsaCursor,
  other : MlrlsarsaCursor,
) -> MlrlsarsaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaCursor::copy(self : MlrlsarsaCursor) -> MlrlsarsaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaCursor::fill(
  self : MlrlsarsaCursor,
  v : Double,
) -> MlrlsarsaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaCursor::min(self : MlrlsarsaCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaCursor::max(self : MlrlsarsaCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaCursor::to_string(self : MlrlsarsaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_view_make(size : Int32) -> MlrlsarsaView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaView::len(self : MlrlsarsaView) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaView::get(self : MlrlsarsaView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaView::set(
  self : MlrlsarsaView,
  i : Int32,
  v : Double,
) -> MlrlsarsaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaView::sum(self : MlrlsarsaView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaView::mean(self : MlrlsarsaView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaView::scale(self : MlrlsarsaView, f : Double) -> MlrlsarsaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaView::add(
  self : MlrlsarsaView,
  other : MlrlsarsaView,
) -> MlrlsarsaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaView::copy(self : MlrlsarsaView) -> MlrlsarsaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaView::fill(self : MlrlsarsaView, v : Double) -> MlrlsarsaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaView::min(self : MlrlsarsaView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaView::max(self : MlrlsarsaView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaView::to_string(self : MlrlsarsaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_range_make(size : Int32) -> MlrlsarsaRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaRange::len(self : MlrlsarsaRange) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaRange::get(self : MlrlsarsaRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaRange::set(
  self : MlrlsarsaRange,
  i : Int32,
  v : Double,
) -> MlrlsarsaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaRange::sum(self : MlrlsarsaRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaRange::mean(self : MlrlsarsaRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaRange::scale(
  self : MlrlsarsaRange,
  f : Double,
) -> MlrlsarsaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaRange::add(
  self : MlrlsarsaRange,
  other : MlrlsarsaRange,
) -> MlrlsarsaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaRange::copy(self : MlrlsarsaRange) -> MlrlsarsaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaRange::fill(
  self : MlrlsarsaRange,
  v : Double,
) -> MlrlsarsaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaRange::min(self : MlrlsarsaRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaRange::max(self : MlrlsarsaRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaRange::to_string(self : MlrlsarsaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlrlsarsaSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_rl_sarsa_slice_make(size : Int32) -> MlrlsarsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlrlsarsaSlice::len(self : MlrlsarsaSlice) -> Int32 {
  self.size
}

///|
pub fn MlrlsarsaSlice::get(self : MlrlsarsaSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlrlsarsaSlice::set(
  self : MlrlsarsaSlice,
  i : Int32,
  v : Double,
) -> MlrlsarsaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaSlice::sum(self : MlrlsarsaSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlrlsarsaSlice::mean(self : MlrlsarsaSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlrlsarsaSlice::scale(
  self : MlrlsarsaSlice,
  f : Double,
) -> MlrlsarsaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaSlice::add(
  self : MlrlsarsaSlice,
  other : MlrlsarsaSlice,
) -> MlrlsarsaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlrlsarsaSlice::copy(self : MlrlsarsaSlice) -> MlrlsarsaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaSlice::fill(
  self : MlrlsarsaSlice,
  v : Double,
) -> MlrlsarsaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlrlsarsaSlice::min(self : MlrlsarsaSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlrlsarsaSlice::max(self : MlrlsarsaSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlrlsarsaSlice::to_string(self : MlrlsarsaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
