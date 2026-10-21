///|
///===
/// extcore/opt_grad_nadam
pub(all) struct OptgradnadamPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn opt_grad_nadam_make_point(x : Double, y : Double) -> OptgradnadamPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn opt_grad_nadam_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> OptgradnadamPoint {
  { x, y, z, label: 0, }
}

///|
pub fn OptgradnadamPoint::x(self : OptgradnadamPoint) -> Double {
  self.x
}

///|
pub fn OptgradnadamPoint::y(self : OptgradnadamPoint) -> Double {
  self.y
}

///|
pub fn OptgradnadamPoint::z(self : OptgradnadamPoint) -> Double {
  self.z
}

///|
pub fn OptgradnadamPoint::label(self : OptgradnadamPoint) -> Int32 {
  self.label
}

///|
pub fn OptgradnadamPoint::dist(
  self : OptgradnadamPoint,
  other : OptgradnadamPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn OptgradnadamPoint::add(
  self : OptgradnadamPoint,
  other : OptgradnadamPoint,
) -> OptgradnadamPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn OptgradnadamPoint::sub(
  self : OptgradnadamPoint,
  other : OptgradnadamPoint,
) -> OptgradnadamPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn OptgradnadamPoint::scale(
  self : OptgradnadamPoint,
  s : Double,
) -> OptgradnadamPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn OptgradnadamPoint::dot(
  self : OptgradnadamPoint,
  other : OptgradnadamPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn OptgradnadamPoint::cross(
  self : OptgradnadamPoint,
  other : OptgradnadamPoint,
) -> OptgradnadamPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn OptgradnadamPoint::norm(self : OptgradnadamPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn OptgradnadamPoint::normalize(
  self : OptgradnadamPoint,
) -> OptgradnadamPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn OptgradnadamPoint::negate(self : OptgradnadamPoint) -> OptgradnadamPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn OptgradnadamPoint::mid(
  self : OptgradnadamPoint,
  other : OptgradnadamPoint,
) -> OptgradnadamPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn OptgradnadamPoint::lerp(
  self : OptgradnadamPoint,
  other : OptgradnadamPoint,
  t : Double,
) -> OptgradnadamPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn OptgradnadamPoint::to_string(self : OptgradnadamPoint) -> String {
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
pub(all) struct OptgradnadamSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn opt_grad_nadam_make_series(
  vals : Array[Double],
  name : String,
) -> OptgradnadamSeries {
  { vals, name, meta: 0, }
}

///|
pub fn OptgradnadamSeries::len(self : OptgradnadamSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn OptgradnadamSeries::sum(self : OptgradnadamSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn OptgradnadamSeries::mean(self : OptgradnadamSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn OptgradnadamSeries::min(self : OptgradnadamSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn OptgradnadamSeries::max(self : OptgradnadamSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn OptgradnadamSeries::range(self : OptgradnadamSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn OptgradnadamSeries::variance(self : OptgradnadamSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn OptgradnadamSeries::std(self : OptgradnadamSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn OptgradnadamSeries::median(self : OptgradnadamSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn OptgradnadamSeries::scale(
  self : OptgradnadamSeries,
  f : Double,
) -> OptgradnadamSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn OptgradnadamSeries::add(
  self : OptgradnadamSeries,
  other : OptgradnadamSeries,
) -> OptgradnadamSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn OptgradnadamSeries::sub(
  self : OptgradnadamSeries,
  other : OptgradnadamSeries,
) -> OptgradnadamSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn OptgradnadamSeries::normalize(
  self : OptgradnadamSeries,
) -> OptgradnadamSeries {
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
pub fn OptgradnadamSeries::cumsum(
  self : OptgradnadamSeries,
) -> OptgradnadamSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn OptgradnadamSeries::to_string(self : OptgradnadamSeries) -> String {
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
pub(all) struct OptgradnadamMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn opt_grad_nadam_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> OptgradnadamMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn opt_grad_nadam_matrix_identity(n : Int32) -> OptgradnadamMatrix {
  let m = opt_grad_nadam_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn OptgradnadamMatrix::get(
  self : OptgradnadamMatrix,
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
pub fn OptgradnadamMatrix::transpose(
  self : OptgradnadamMatrix,
) -> OptgradnadamMatrix {
  let result = opt_grad_nadam_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn OptgradnadamMatrix::add(
  self : OptgradnadamMatrix,
  other : OptgradnadamMatrix,
) -> OptgradnadamMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = opt_grad_nadam_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn OptgradnadamMatrix::scale(
  self : OptgradnadamMatrix,
  s : Double,
) -> OptgradnadamMatrix {
  let result = opt_grad_nadam_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn OptgradnadamMatrix::multiply(
  self : OptgradnadamMatrix,
  other : OptgradnadamMatrix,
) -> OptgradnadamMatrix {
  if self.cols != other.rows {
    return opt_grad_nadam_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = opt_grad_nadam_make_matrix(self.rows, other.cols, 0.0)
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
pub fn OptgradnadamMatrix::trace(self : OptgradnadamMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn OptgradnadamMatrix::det(self : OptgradnadamMatrix) -> Double {
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
pub fn OptgradnadamMatrix::norm(self : OptgradnadamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn OptgradnadamMatrix::to_string(self : OptgradnadamMatrix) -> String {
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
pub(all) struct OptgradnadamVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn opt_grad_nadam_make_vector(comps : Array[Double]) -> OptgradnadamVector {
  { comps, dim: comps.length(), }
}

///|
pub fn opt_grad_nadam_vector_zero(dim : Int32) -> OptgradnadamVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn OptgradnadamVector::add(
  self : OptgradnadamVector,
  other : OptgradnadamVector,
) -> OptgradnadamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn OptgradnadamVector::sub(
  self : OptgradnadamVector,
  other : OptgradnadamVector,
) -> OptgradnadamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn OptgradnadamVector::scale(
  self : OptgradnadamVector,
  s : Double,
) -> OptgradnadamVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn OptgradnadamVector::dot(
  self : OptgradnadamVector,
  other : OptgradnadamVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn OptgradnadamVector::norm(self : OptgradnadamVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn OptgradnadamVector::normalize(
  self : OptgradnadamVector,
) -> OptgradnadamVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn OptgradnadamVector::dist(
  self : OptgradnadamVector,
  other : OptgradnadamVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn OptgradnadamVector::to_string(self : OptgradnadamVector) -> String {
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
pub(all) struct OptgradnadamFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_frame_make(size : Int32) -> OptgradnadamFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamFrame::len(self : OptgradnadamFrame) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamFrame::get(self : OptgradnadamFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamFrame::set(
  self : OptgradnadamFrame,
  i : Int32,
  v : Double,
) -> OptgradnadamFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamFrame::sum(self : OptgradnadamFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamFrame::mean(self : OptgradnadamFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamFrame::scale(
  self : OptgradnadamFrame,
  f : Double,
) -> OptgradnadamFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamFrame::add(
  self : OptgradnadamFrame,
  other : OptgradnadamFrame,
) -> OptgradnadamFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamFrame::copy(self : OptgradnadamFrame) -> OptgradnadamFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamFrame::fill(
  self : OptgradnadamFrame,
  v : Double,
) -> OptgradnadamFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamFrame::min(self : OptgradnadamFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamFrame::max(self : OptgradnadamFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamFrame::to_string(self : OptgradnadamFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_table_make(size : Int32) -> OptgradnadamTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamTable::len(self : OptgradnadamTable) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamTable::get(self : OptgradnadamTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamTable::set(
  self : OptgradnadamTable,
  i : Int32,
  v : Double,
) -> OptgradnadamTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamTable::sum(self : OptgradnadamTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamTable::mean(self : OptgradnadamTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamTable::scale(
  self : OptgradnadamTable,
  f : Double,
) -> OptgradnadamTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamTable::add(
  self : OptgradnadamTable,
  other : OptgradnadamTable,
) -> OptgradnadamTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamTable::copy(self : OptgradnadamTable) -> OptgradnadamTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamTable::fill(
  self : OptgradnadamTable,
  v : Double,
) -> OptgradnadamTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamTable::min(self : OptgradnadamTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamTable::max(self : OptgradnadamTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamTable::to_string(self : OptgradnadamTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_graphn_make(size : Int32) -> OptgradnadamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamGraphN::len(self : OptgradnadamGraphN) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamGraphN::get(self : OptgradnadamGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamGraphN::set(
  self : OptgradnadamGraphN,
  i : Int32,
  v : Double,
) -> OptgradnadamGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamGraphN::sum(self : OptgradnadamGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamGraphN::mean(self : OptgradnadamGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamGraphN::scale(
  self : OptgradnadamGraphN,
  f : Double,
) -> OptgradnadamGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamGraphN::add(
  self : OptgradnadamGraphN,
  other : OptgradnadamGraphN,
) -> OptgradnadamGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamGraphN::copy(
  self : OptgradnadamGraphN,
) -> OptgradnadamGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamGraphN::fill(
  self : OptgradnadamGraphN,
  v : Double,
) -> OptgradnadamGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamGraphN::min(self : OptgradnadamGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamGraphN::max(self : OptgradnadamGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamGraphN::to_string(self : OptgradnadamGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_node_make(size : Int32) -> OptgradnadamNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamNode::len(self : OptgradnadamNode) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamNode::get(self : OptgradnadamNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamNode::set(
  self : OptgradnadamNode,
  i : Int32,
  v : Double,
) -> OptgradnadamNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamNode::sum(self : OptgradnadamNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamNode::mean(self : OptgradnadamNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamNode::scale(
  self : OptgradnadamNode,
  f : Double,
) -> OptgradnadamNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamNode::add(
  self : OptgradnadamNode,
  other : OptgradnadamNode,
) -> OptgradnadamNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamNode::copy(self : OptgradnadamNode) -> OptgradnadamNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamNode::fill(
  self : OptgradnadamNode,
  v : Double,
) -> OptgradnadamNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamNode::min(self : OptgradnadamNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamNode::max(self : OptgradnadamNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamNode::to_string(self : OptgradnadamNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_edge_make(size : Int32) -> OptgradnadamEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamEdge::len(self : OptgradnadamEdge) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamEdge::get(self : OptgradnadamEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamEdge::set(
  self : OptgradnadamEdge,
  i : Int32,
  v : Double,
) -> OptgradnadamEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamEdge::sum(self : OptgradnadamEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamEdge::mean(self : OptgradnadamEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamEdge::scale(
  self : OptgradnadamEdge,
  f : Double,
) -> OptgradnadamEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamEdge::add(
  self : OptgradnadamEdge,
  other : OptgradnadamEdge,
) -> OptgradnadamEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamEdge::copy(self : OptgradnadamEdge) -> OptgradnadamEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamEdge::fill(
  self : OptgradnadamEdge,
  v : Double,
) -> OptgradnadamEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamEdge::min(self : OptgradnadamEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamEdge::max(self : OptgradnadamEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamEdge::to_string(self : OptgradnadamEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_path_make(size : Int32) -> OptgradnadamPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamPath::len(self : OptgradnadamPath) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamPath::get(self : OptgradnadamPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamPath::set(
  self : OptgradnadamPath,
  i : Int32,
  v : Double,
) -> OptgradnadamPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamPath::sum(self : OptgradnadamPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamPath::mean(self : OptgradnadamPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamPath::scale(
  self : OptgradnadamPath,
  f : Double,
) -> OptgradnadamPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamPath::add(
  self : OptgradnadamPath,
  other : OptgradnadamPath,
) -> OptgradnadamPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamPath::copy(self : OptgradnadamPath) -> OptgradnadamPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamPath::fill(
  self : OptgradnadamPath,
  v : Double,
) -> OptgradnadamPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamPath::min(self : OptgradnadamPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamPath::max(self : OptgradnadamPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamPath::to_string(self : OptgradnadamPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_cluster_make(size : Int32) -> OptgradnadamCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamCluster::len(self : OptgradnadamCluster) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamCluster::get(
  self : OptgradnadamCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamCluster::set(
  self : OptgradnadamCluster,
  i : Int32,
  v : Double,
) -> OptgradnadamCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamCluster::sum(self : OptgradnadamCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamCluster::mean(self : OptgradnadamCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamCluster::scale(
  self : OptgradnadamCluster,
  f : Double,
) -> OptgradnadamCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamCluster::add(
  self : OptgradnadamCluster,
  other : OptgradnadamCluster,
) -> OptgradnadamCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamCluster::copy(
  self : OptgradnadamCluster,
) -> OptgradnadamCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamCluster::fill(
  self : OptgradnadamCluster,
  v : Double,
) -> OptgradnadamCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamCluster::min(self : OptgradnadamCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamCluster::max(self : OptgradnadamCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamCluster::to_string(self : OptgradnadamCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_model_make(size : Int32) -> OptgradnadamModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamModel::len(self : OptgradnadamModel) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamModel::get(self : OptgradnadamModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamModel::set(
  self : OptgradnadamModel,
  i : Int32,
  v : Double,
) -> OptgradnadamModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamModel::sum(self : OptgradnadamModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamModel::mean(self : OptgradnadamModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamModel::scale(
  self : OptgradnadamModel,
  f : Double,
) -> OptgradnadamModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamModel::add(
  self : OptgradnadamModel,
  other : OptgradnadamModel,
) -> OptgradnadamModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamModel::copy(self : OptgradnadamModel) -> OptgradnadamModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamModel::fill(
  self : OptgradnadamModel,
  v : Double,
) -> OptgradnadamModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamModel::min(self : OptgradnadamModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamModel::max(self : OptgradnadamModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamModel::to_string(self : OptgradnadamModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_layer_make(size : Int32) -> OptgradnadamLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamLayer::len(self : OptgradnadamLayer) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamLayer::get(self : OptgradnadamLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamLayer::set(
  self : OptgradnadamLayer,
  i : Int32,
  v : Double,
) -> OptgradnadamLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamLayer::sum(self : OptgradnadamLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamLayer::mean(self : OptgradnadamLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamLayer::scale(
  self : OptgradnadamLayer,
  f : Double,
) -> OptgradnadamLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamLayer::add(
  self : OptgradnadamLayer,
  other : OptgradnadamLayer,
) -> OptgradnadamLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamLayer::copy(self : OptgradnadamLayer) -> OptgradnadamLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamLayer::fill(
  self : OptgradnadamLayer,
  v : Double,
) -> OptgradnadamLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamLayer::min(self : OptgradnadamLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamLayer::max(self : OptgradnadamLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamLayer::to_string(self : OptgradnadamLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_buffer_make(size : Int32) -> OptgradnadamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamBuffer::len(self : OptgradnadamBuffer) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamBuffer::get(self : OptgradnadamBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamBuffer::set(
  self : OptgradnadamBuffer,
  i : Int32,
  v : Double,
) -> OptgradnadamBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamBuffer::sum(self : OptgradnadamBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamBuffer::mean(self : OptgradnadamBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamBuffer::scale(
  self : OptgradnadamBuffer,
  f : Double,
) -> OptgradnadamBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamBuffer::add(
  self : OptgradnadamBuffer,
  other : OptgradnadamBuffer,
) -> OptgradnadamBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamBuffer::copy(
  self : OptgradnadamBuffer,
) -> OptgradnadamBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamBuffer::fill(
  self : OptgradnadamBuffer,
  v : Double,
) -> OptgradnadamBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamBuffer::min(self : OptgradnadamBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamBuffer::max(self : OptgradnadamBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamBuffer::to_string(self : OptgradnadamBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_cursor_make(size : Int32) -> OptgradnadamCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamCursor::len(self : OptgradnadamCursor) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamCursor::get(self : OptgradnadamCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamCursor::set(
  self : OptgradnadamCursor,
  i : Int32,
  v : Double,
) -> OptgradnadamCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamCursor::sum(self : OptgradnadamCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamCursor::mean(self : OptgradnadamCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamCursor::scale(
  self : OptgradnadamCursor,
  f : Double,
) -> OptgradnadamCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamCursor::add(
  self : OptgradnadamCursor,
  other : OptgradnadamCursor,
) -> OptgradnadamCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamCursor::copy(
  self : OptgradnadamCursor,
) -> OptgradnadamCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamCursor::fill(
  self : OptgradnadamCursor,
  v : Double,
) -> OptgradnadamCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamCursor::min(self : OptgradnadamCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamCursor::max(self : OptgradnadamCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamCursor::to_string(self : OptgradnadamCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_view_make(size : Int32) -> OptgradnadamView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamView::len(self : OptgradnadamView) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamView::get(self : OptgradnadamView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamView::set(
  self : OptgradnadamView,
  i : Int32,
  v : Double,
) -> OptgradnadamView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamView::sum(self : OptgradnadamView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamView::mean(self : OptgradnadamView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamView::scale(
  self : OptgradnadamView,
  f : Double,
) -> OptgradnadamView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamView::add(
  self : OptgradnadamView,
  other : OptgradnadamView,
) -> OptgradnadamView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamView::copy(self : OptgradnadamView) -> OptgradnadamView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamView::fill(
  self : OptgradnadamView,
  v : Double,
) -> OptgradnadamView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamView::min(self : OptgradnadamView) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamView::max(self : OptgradnadamView) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamView::to_string(self : OptgradnadamView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_range_make(size : Int32) -> OptgradnadamRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamRange::len(self : OptgradnadamRange) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamRange::get(self : OptgradnadamRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamRange::set(
  self : OptgradnadamRange,
  i : Int32,
  v : Double,
) -> OptgradnadamRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamRange::sum(self : OptgradnadamRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamRange::mean(self : OptgradnadamRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamRange::scale(
  self : OptgradnadamRange,
  f : Double,
) -> OptgradnadamRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamRange::add(
  self : OptgradnadamRange,
  other : OptgradnadamRange,
) -> OptgradnadamRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamRange::copy(self : OptgradnadamRange) -> OptgradnadamRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamRange::fill(
  self : OptgradnadamRange,
  v : Double,
) -> OptgradnadamRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamRange::min(self : OptgradnadamRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamRange::max(self : OptgradnadamRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamRange::to_string(self : OptgradnadamRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradnadamSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_nadam_slice_make(size : Int32) -> OptgradnadamSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradnadamSlice::len(self : OptgradnadamSlice) -> Int32 {
  self.size
}

///|
pub fn OptgradnadamSlice::get(self : OptgradnadamSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradnadamSlice::set(
  self : OptgradnadamSlice,
  i : Int32,
  v : Double,
) -> OptgradnadamSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamSlice::sum(self : OptgradnadamSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradnadamSlice::mean(self : OptgradnadamSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradnadamSlice::scale(
  self : OptgradnadamSlice,
  f : Double,
) -> OptgradnadamSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamSlice::add(
  self : OptgradnadamSlice,
  other : OptgradnadamSlice,
) -> OptgradnadamSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradnadamSlice::copy(self : OptgradnadamSlice) -> OptgradnadamSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamSlice::fill(
  self : OptgradnadamSlice,
  v : Double,
) -> OptgradnadamSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradnadamSlice::min(self : OptgradnadamSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradnadamSlice::max(self : OptgradnadamSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradnadamSlice::to_string(self : OptgradnadamSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
