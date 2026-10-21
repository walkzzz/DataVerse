///|
///===
/// extcore/opt_grad_momentum
pub(all) struct OptgradmomentumPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn opt_grad_momentum_make_point(
  x : Double,
  y : Double,
) -> OptgradmomentumPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn opt_grad_momentum_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> OptgradmomentumPoint {
  { x, y, z, label: 0, }
}

///|
pub fn OptgradmomentumPoint::x(self : OptgradmomentumPoint) -> Double {
  self.x
}

///|
pub fn OptgradmomentumPoint::y(self : OptgradmomentumPoint) -> Double {
  self.y
}

///|
pub fn OptgradmomentumPoint::z(self : OptgradmomentumPoint) -> Double {
  self.z
}

///|
pub fn OptgradmomentumPoint::label(self : OptgradmomentumPoint) -> Int32 {
  self.label
}

///|
pub fn OptgradmomentumPoint::dist(
  self : OptgradmomentumPoint,
  other : OptgradmomentumPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn OptgradmomentumPoint::add(
  self : OptgradmomentumPoint,
  other : OptgradmomentumPoint,
) -> OptgradmomentumPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn OptgradmomentumPoint::sub(
  self : OptgradmomentumPoint,
  other : OptgradmomentumPoint,
) -> OptgradmomentumPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn OptgradmomentumPoint::scale(
  self : OptgradmomentumPoint,
  s : Double,
) -> OptgradmomentumPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn OptgradmomentumPoint::dot(
  self : OptgradmomentumPoint,
  other : OptgradmomentumPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn OptgradmomentumPoint::cross(
  self : OptgradmomentumPoint,
  other : OptgradmomentumPoint,
) -> OptgradmomentumPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn OptgradmomentumPoint::norm(self : OptgradmomentumPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn OptgradmomentumPoint::normalize(
  self : OptgradmomentumPoint,
) -> OptgradmomentumPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn OptgradmomentumPoint::negate(
  self : OptgradmomentumPoint,
) -> OptgradmomentumPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn OptgradmomentumPoint::mid(
  self : OptgradmomentumPoint,
  other : OptgradmomentumPoint,
) -> OptgradmomentumPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn OptgradmomentumPoint::lerp(
  self : OptgradmomentumPoint,
  other : OptgradmomentumPoint,
  t : Double,
) -> OptgradmomentumPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn OptgradmomentumPoint::to_string(self : OptgradmomentumPoint) -> String {
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
pub(all) struct OptgradmomentumSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn opt_grad_momentum_make_series(
  vals : Array[Double],
  name : String,
) -> OptgradmomentumSeries {
  { vals, name, meta: 0, }
}

///|
pub fn OptgradmomentumSeries::len(self : OptgradmomentumSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn OptgradmomentumSeries::sum(self : OptgradmomentumSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn OptgradmomentumSeries::mean(self : OptgradmomentumSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn OptgradmomentumSeries::min(self : OptgradmomentumSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn OptgradmomentumSeries::max(self : OptgradmomentumSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn OptgradmomentumSeries::range(self : OptgradmomentumSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn OptgradmomentumSeries::variance(self : OptgradmomentumSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn OptgradmomentumSeries::std(self : OptgradmomentumSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn OptgradmomentumSeries::median(self : OptgradmomentumSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn OptgradmomentumSeries::scale(
  self : OptgradmomentumSeries,
  f : Double,
) -> OptgradmomentumSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn OptgradmomentumSeries::add(
  self : OptgradmomentumSeries,
  other : OptgradmomentumSeries,
) -> OptgradmomentumSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn OptgradmomentumSeries::sub(
  self : OptgradmomentumSeries,
  other : OptgradmomentumSeries,
) -> OptgradmomentumSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn OptgradmomentumSeries::normalize(
  self : OptgradmomentumSeries,
) -> OptgradmomentumSeries {
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
pub fn OptgradmomentumSeries::cumsum(
  self : OptgradmomentumSeries,
) -> OptgradmomentumSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn OptgradmomentumSeries::to_string(self : OptgradmomentumSeries) -> String {
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
pub(all) struct OptgradmomentumMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn opt_grad_momentum_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> OptgradmomentumMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn opt_grad_momentum_matrix_identity(n : Int32) -> OptgradmomentumMatrix {
  let m = opt_grad_momentum_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn OptgradmomentumMatrix::get(
  self : OptgradmomentumMatrix,
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
pub fn OptgradmomentumMatrix::transpose(
  self : OptgradmomentumMatrix,
) -> OptgradmomentumMatrix {
  let result = opt_grad_momentum_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn OptgradmomentumMatrix::add(
  self : OptgradmomentumMatrix,
  other : OptgradmomentumMatrix,
) -> OptgradmomentumMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = opt_grad_momentum_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn OptgradmomentumMatrix::scale(
  self : OptgradmomentumMatrix,
  s : Double,
) -> OptgradmomentumMatrix {
  let result = opt_grad_momentum_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn OptgradmomentumMatrix::multiply(
  self : OptgradmomentumMatrix,
  other : OptgradmomentumMatrix,
) -> OptgradmomentumMatrix {
  if self.cols != other.rows {
    return opt_grad_momentum_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = opt_grad_momentum_make_matrix(self.rows, other.cols, 0.0)
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
pub fn OptgradmomentumMatrix::trace(self : OptgradmomentumMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn OptgradmomentumMatrix::det(self : OptgradmomentumMatrix) -> Double {
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
pub fn OptgradmomentumMatrix::norm(self : OptgradmomentumMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn OptgradmomentumMatrix::to_string(self : OptgradmomentumMatrix) -> String {
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
pub(all) struct OptgradmomentumVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn opt_grad_momentum_make_vector(
  comps : Array[Double],
) -> OptgradmomentumVector {
  { comps, dim: comps.length(), }
}

///|
pub fn opt_grad_momentum_vector_zero(dim : Int32) -> OptgradmomentumVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn OptgradmomentumVector::add(
  self : OptgradmomentumVector,
  other : OptgradmomentumVector,
) -> OptgradmomentumVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn OptgradmomentumVector::sub(
  self : OptgradmomentumVector,
  other : OptgradmomentumVector,
) -> OptgradmomentumVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn OptgradmomentumVector::scale(
  self : OptgradmomentumVector,
  s : Double,
) -> OptgradmomentumVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn OptgradmomentumVector::dot(
  self : OptgradmomentumVector,
  other : OptgradmomentumVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn OptgradmomentumVector::norm(self : OptgradmomentumVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn OptgradmomentumVector::normalize(
  self : OptgradmomentumVector,
) -> OptgradmomentumVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn OptgradmomentumVector::dist(
  self : OptgradmomentumVector,
  other : OptgradmomentumVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn OptgradmomentumVector::to_string(self : OptgradmomentumVector) -> String {
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
pub(all) struct OptgradmomentumFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_frame_make(size : Int32) -> OptgradmomentumFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumFrame::len(self : OptgradmomentumFrame) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumFrame::get(
  self : OptgradmomentumFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumFrame::set(
  self : OptgradmomentumFrame,
  i : Int32,
  v : Double,
) -> OptgradmomentumFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumFrame::sum(self : OptgradmomentumFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumFrame::mean(self : OptgradmomentumFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumFrame::scale(
  self : OptgradmomentumFrame,
  f : Double,
) -> OptgradmomentumFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumFrame::add(
  self : OptgradmomentumFrame,
  other : OptgradmomentumFrame,
) -> OptgradmomentumFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumFrame::copy(
  self : OptgradmomentumFrame,
) -> OptgradmomentumFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumFrame::fill(
  self : OptgradmomentumFrame,
  v : Double,
) -> OptgradmomentumFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumFrame::min(self : OptgradmomentumFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumFrame::max(self : OptgradmomentumFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumFrame::to_string(self : OptgradmomentumFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_table_make(size : Int32) -> OptgradmomentumTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumTable::len(self : OptgradmomentumTable) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumTable::get(
  self : OptgradmomentumTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumTable::set(
  self : OptgradmomentumTable,
  i : Int32,
  v : Double,
) -> OptgradmomentumTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumTable::sum(self : OptgradmomentumTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumTable::mean(self : OptgradmomentumTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumTable::scale(
  self : OptgradmomentumTable,
  f : Double,
) -> OptgradmomentumTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumTable::add(
  self : OptgradmomentumTable,
  other : OptgradmomentumTable,
) -> OptgradmomentumTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumTable::copy(
  self : OptgradmomentumTable,
) -> OptgradmomentumTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumTable::fill(
  self : OptgradmomentumTable,
  v : Double,
) -> OptgradmomentumTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumTable::min(self : OptgradmomentumTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumTable::max(self : OptgradmomentumTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumTable::to_string(self : OptgradmomentumTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_graphn_make(size : Int32) -> OptgradmomentumGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumGraphN::len(self : OptgradmomentumGraphN) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumGraphN::get(
  self : OptgradmomentumGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumGraphN::set(
  self : OptgradmomentumGraphN,
  i : Int32,
  v : Double,
) -> OptgradmomentumGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumGraphN::sum(self : OptgradmomentumGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumGraphN::mean(self : OptgradmomentumGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumGraphN::scale(
  self : OptgradmomentumGraphN,
  f : Double,
) -> OptgradmomentumGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumGraphN::add(
  self : OptgradmomentumGraphN,
  other : OptgradmomentumGraphN,
) -> OptgradmomentumGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumGraphN::copy(
  self : OptgradmomentumGraphN,
) -> OptgradmomentumGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumGraphN::fill(
  self : OptgradmomentumGraphN,
  v : Double,
) -> OptgradmomentumGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumGraphN::min(self : OptgradmomentumGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumGraphN::max(self : OptgradmomentumGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumGraphN::to_string(self : OptgradmomentumGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_node_make(size : Int32) -> OptgradmomentumNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumNode::len(self : OptgradmomentumNode) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumNode::get(
  self : OptgradmomentumNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumNode::set(
  self : OptgradmomentumNode,
  i : Int32,
  v : Double,
) -> OptgradmomentumNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumNode::sum(self : OptgradmomentumNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumNode::mean(self : OptgradmomentumNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumNode::scale(
  self : OptgradmomentumNode,
  f : Double,
) -> OptgradmomentumNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumNode::add(
  self : OptgradmomentumNode,
  other : OptgradmomentumNode,
) -> OptgradmomentumNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumNode::copy(
  self : OptgradmomentumNode,
) -> OptgradmomentumNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumNode::fill(
  self : OptgradmomentumNode,
  v : Double,
) -> OptgradmomentumNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumNode::min(self : OptgradmomentumNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumNode::max(self : OptgradmomentumNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumNode::to_string(self : OptgradmomentumNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_edge_make(size : Int32) -> OptgradmomentumEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumEdge::len(self : OptgradmomentumEdge) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumEdge::get(
  self : OptgradmomentumEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumEdge::set(
  self : OptgradmomentumEdge,
  i : Int32,
  v : Double,
) -> OptgradmomentumEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumEdge::sum(self : OptgradmomentumEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumEdge::mean(self : OptgradmomentumEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumEdge::scale(
  self : OptgradmomentumEdge,
  f : Double,
) -> OptgradmomentumEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumEdge::add(
  self : OptgradmomentumEdge,
  other : OptgradmomentumEdge,
) -> OptgradmomentumEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumEdge::copy(
  self : OptgradmomentumEdge,
) -> OptgradmomentumEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumEdge::fill(
  self : OptgradmomentumEdge,
  v : Double,
) -> OptgradmomentumEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumEdge::min(self : OptgradmomentumEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumEdge::max(self : OptgradmomentumEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumEdge::to_string(self : OptgradmomentumEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_path_make(size : Int32) -> OptgradmomentumPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumPath::len(self : OptgradmomentumPath) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumPath::get(
  self : OptgradmomentumPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumPath::set(
  self : OptgradmomentumPath,
  i : Int32,
  v : Double,
) -> OptgradmomentumPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumPath::sum(self : OptgradmomentumPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumPath::mean(self : OptgradmomentumPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumPath::scale(
  self : OptgradmomentumPath,
  f : Double,
) -> OptgradmomentumPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumPath::add(
  self : OptgradmomentumPath,
  other : OptgradmomentumPath,
) -> OptgradmomentumPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumPath::copy(
  self : OptgradmomentumPath,
) -> OptgradmomentumPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumPath::fill(
  self : OptgradmomentumPath,
  v : Double,
) -> OptgradmomentumPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumPath::min(self : OptgradmomentumPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumPath::max(self : OptgradmomentumPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumPath::to_string(self : OptgradmomentumPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_cluster_make(size : Int32) -> OptgradmomentumCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumCluster::len(self : OptgradmomentumCluster) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumCluster::get(
  self : OptgradmomentumCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumCluster::set(
  self : OptgradmomentumCluster,
  i : Int32,
  v : Double,
) -> OptgradmomentumCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumCluster::sum(self : OptgradmomentumCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumCluster::mean(self : OptgradmomentumCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumCluster::scale(
  self : OptgradmomentumCluster,
  f : Double,
) -> OptgradmomentumCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumCluster::add(
  self : OptgradmomentumCluster,
  other : OptgradmomentumCluster,
) -> OptgradmomentumCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumCluster::copy(
  self : OptgradmomentumCluster,
) -> OptgradmomentumCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumCluster::fill(
  self : OptgradmomentumCluster,
  v : Double,
) -> OptgradmomentumCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumCluster::min(self : OptgradmomentumCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumCluster::max(self : OptgradmomentumCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumCluster::to_string(
  self : OptgradmomentumCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_model_make(size : Int32) -> OptgradmomentumModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumModel::len(self : OptgradmomentumModel) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumModel::get(
  self : OptgradmomentumModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumModel::set(
  self : OptgradmomentumModel,
  i : Int32,
  v : Double,
) -> OptgradmomentumModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumModel::sum(self : OptgradmomentumModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumModel::mean(self : OptgradmomentumModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumModel::scale(
  self : OptgradmomentumModel,
  f : Double,
) -> OptgradmomentumModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumModel::add(
  self : OptgradmomentumModel,
  other : OptgradmomentumModel,
) -> OptgradmomentumModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumModel::copy(
  self : OptgradmomentumModel,
) -> OptgradmomentumModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumModel::fill(
  self : OptgradmomentumModel,
  v : Double,
) -> OptgradmomentumModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumModel::min(self : OptgradmomentumModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumModel::max(self : OptgradmomentumModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumModel::to_string(self : OptgradmomentumModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_layer_make(size : Int32) -> OptgradmomentumLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumLayer::len(self : OptgradmomentumLayer) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumLayer::get(
  self : OptgradmomentumLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumLayer::set(
  self : OptgradmomentumLayer,
  i : Int32,
  v : Double,
) -> OptgradmomentumLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumLayer::sum(self : OptgradmomentumLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumLayer::mean(self : OptgradmomentumLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumLayer::scale(
  self : OptgradmomentumLayer,
  f : Double,
) -> OptgradmomentumLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumLayer::add(
  self : OptgradmomentumLayer,
  other : OptgradmomentumLayer,
) -> OptgradmomentumLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumLayer::copy(
  self : OptgradmomentumLayer,
) -> OptgradmomentumLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumLayer::fill(
  self : OptgradmomentumLayer,
  v : Double,
) -> OptgradmomentumLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumLayer::min(self : OptgradmomentumLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumLayer::max(self : OptgradmomentumLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumLayer::to_string(self : OptgradmomentumLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_buffer_make(size : Int32) -> OptgradmomentumBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumBuffer::len(self : OptgradmomentumBuffer) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumBuffer::get(
  self : OptgradmomentumBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumBuffer::set(
  self : OptgradmomentumBuffer,
  i : Int32,
  v : Double,
) -> OptgradmomentumBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumBuffer::sum(self : OptgradmomentumBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumBuffer::mean(self : OptgradmomentumBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumBuffer::scale(
  self : OptgradmomentumBuffer,
  f : Double,
) -> OptgradmomentumBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumBuffer::add(
  self : OptgradmomentumBuffer,
  other : OptgradmomentumBuffer,
) -> OptgradmomentumBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumBuffer::copy(
  self : OptgradmomentumBuffer,
) -> OptgradmomentumBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumBuffer::fill(
  self : OptgradmomentumBuffer,
  v : Double,
) -> OptgradmomentumBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumBuffer::min(self : OptgradmomentumBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumBuffer::max(self : OptgradmomentumBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumBuffer::to_string(self : OptgradmomentumBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_cursor_make(size : Int32) -> OptgradmomentumCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumCursor::len(self : OptgradmomentumCursor) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumCursor::get(
  self : OptgradmomentumCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumCursor::set(
  self : OptgradmomentumCursor,
  i : Int32,
  v : Double,
) -> OptgradmomentumCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumCursor::sum(self : OptgradmomentumCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumCursor::mean(self : OptgradmomentumCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumCursor::scale(
  self : OptgradmomentumCursor,
  f : Double,
) -> OptgradmomentumCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumCursor::add(
  self : OptgradmomentumCursor,
  other : OptgradmomentumCursor,
) -> OptgradmomentumCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumCursor::copy(
  self : OptgradmomentumCursor,
) -> OptgradmomentumCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumCursor::fill(
  self : OptgradmomentumCursor,
  v : Double,
) -> OptgradmomentumCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumCursor::min(self : OptgradmomentumCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumCursor::max(self : OptgradmomentumCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumCursor::to_string(self : OptgradmomentumCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_view_make(size : Int32) -> OptgradmomentumView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumView::len(self : OptgradmomentumView) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumView::get(
  self : OptgradmomentumView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumView::set(
  self : OptgradmomentumView,
  i : Int32,
  v : Double,
) -> OptgradmomentumView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumView::sum(self : OptgradmomentumView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumView::mean(self : OptgradmomentumView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumView::scale(
  self : OptgradmomentumView,
  f : Double,
) -> OptgradmomentumView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumView::add(
  self : OptgradmomentumView,
  other : OptgradmomentumView,
) -> OptgradmomentumView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumView::copy(
  self : OptgradmomentumView,
) -> OptgradmomentumView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumView::fill(
  self : OptgradmomentumView,
  v : Double,
) -> OptgradmomentumView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumView::min(self : OptgradmomentumView) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumView::max(self : OptgradmomentumView) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumView::to_string(self : OptgradmomentumView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_range_make(size : Int32) -> OptgradmomentumRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumRange::len(self : OptgradmomentumRange) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumRange::get(
  self : OptgradmomentumRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumRange::set(
  self : OptgradmomentumRange,
  i : Int32,
  v : Double,
) -> OptgradmomentumRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumRange::sum(self : OptgradmomentumRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumRange::mean(self : OptgradmomentumRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumRange::scale(
  self : OptgradmomentumRange,
  f : Double,
) -> OptgradmomentumRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumRange::add(
  self : OptgradmomentumRange,
  other : OptgradmomentumRange,
) -> OptgradmomentumRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumRange::copy(
  self : OptgradmomentumRange,
) -> OptgradmomentumRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumRange::fill(
  self : OptgradmomentumRange,
  v : Double,
) -> OptgradmomentumRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumRange::min(self : OptgradmomentumRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumRange::max(self : OptgradmomentumRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumRange::to_string(self : OptgradmomentumRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradmomentumSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_momentum_slice_make(size : Int32) -> OptgradmomentumSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradmomentumSlice::len(self : OptgradmomentumSlice) -> Int32 {
  self.size
}

///|
pub fn OptgradmomentumSlice::get(
  self : OptgradmomentumSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradmomentumSlice::set(
  self : OptgradmomentumSlice,
  i : Int32,
  v : Double,
) -> OptgradmomentumSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumSlice::sum(self : OptgradmomentumSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradmomentumSlice::mean(self : OptgradmomentumSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradmomentumSlice::scale(
  self : OptgradmomentumSlice,
  f : Double,
) -> OptgradmomentumSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumSlice::add(
  self : OptgradmomentumSlice,
  other : OptgradmomentumSlice,
) -> OptgradmomentumSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradmomentumSlice::copy(
  self : OptgradmomentumSlice,
) -> OptgradmomentumSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumSlice::fill(
  self : OptgradmomentumSlice,
  v : Double,
) -> OptgradmomentumSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradmomentumSlice::min(self : OptgradmomentumSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradmomentumSlice::max(self : OptgradmomentumSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradmomentumSlice::to_string(self : OptgradmomentumSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
