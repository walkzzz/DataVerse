///|
///===
/// extcore/opt_grad_adagrad
pub(all) struct OptgradadagradPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn opt_grad_adagrad_make_point(
  x : Double,
  y : Double,
) -> OptgradadagradPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn opt_grad_adagrad_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> OptgradadagradPoint {
  { x, y, z, label: 0, }
}

///|
pub fn OptgradadagradPoint::x(self : OptgradadagradPoint) -> Double {
  self.x
}

///|
pub fn OptgradadagradPoint::y(self : OptgradadagradPoint) -> Double {
  self.y
}

///|
pub fn OptgradadagradPoint::z(self : OptgradadagradPoint) -> Double {
  self.z
}

///|
pub fn OptgradadagradPoint::label(self : OptgradadagradPoint) -> Int32 {
  self.label
}

///|
pub fn OptgradadagradPoint::dist(
  self : OptgradadagradPoint,
  other : OptgradadagradPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn OptgradadagradPoint::add(
  self : OptgradadagradPoint,
  other : OptgradadagradPoint,
) -> OptgradadagradPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn OptgradadagradPoint::sub(
  self : OptgradadagradPoint,
  other : OptgradadagradPoint,
) -> OptgradadagradPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn OptgradadagradPoint::scale(
  self : OptgradadagradPoint,
  s : Double,
) -> OptgradadagradPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn OptgradadagradPoint::dot(
  self : OptgradadagradPoint,
  other : OptgradadagradPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn OptgradadagradPoint::cross(
  self : OptgradadagradPoint,
  other : OptgradadagradPoint,
) -> OptgradadagradPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn OptgradadagradPoint::norm(self : OptgradadagradPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn OptgradadagradPoint::normalize(
  self : OptgradadagradPoint,
) -> OptgradadagradPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn OptgradadagradPoint::negate(
  self : OptgradadagradPoint,
) -> OptgradadagradPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn OptgradadagradPoint::mid(
  self : OptgradadagradPoint,
  other : OptgradadagradPoint,
) -> OptgradadagradPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn OptgradadagradPoint::lerp(
  self : OptgradadagradPoint,
  other : OptgradadagradPoint,
  t : Double,
) -> OptgradadagradPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn OptgradadagradPoint::to_string(self : OptgradadagradPoint) -> String {
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
pub(all) struct OptgradadagradSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn opt_grad_adagrad_make_series(
  vals : Array[Double],
  name : String,
) -> OptgradadagradSeries {
  { vals, name, meta: 0, }
}

///|
pub fn OptgradadagradSeries::len(self : OptgradadagradSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn OptgradadagradSeries::sum(self : OptgradadagradSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn OptgradadagradSeries::mean(self : OptgradadagradSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn OptgradadagradSeries::min(self : OptgradadagradSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn OptgradadagradSeries::max(self : OptgradadagradSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn OptgradadagradSeries::range(self : OptgradadagradSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn OptgradadagradSeries::variance(self : OptgradadagradSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn OptgradadagradSeries::std(self : OptgradadagradSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn OptgradadagradSeries::median(self : OptgradadagradSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn OptgradadagradSeries::scale(
  self : OptgradadagradSeries,
  f : Double,
) -> OptgradadagradSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn OptgradadagradSeries::add(
  self : OptgradadagradSeries,
  other : OptgradadagradSeries,
) -> OptgradadagradSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn OptgradadagradSeries::sub(
  self : OptgradadagradSeries,
  other : OptgradadagradSeries,
) -> OptgradadagradSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn OptgradadagradSeries::normalize(
  self : OptgradadagradSeries,
) -> OptgradadagradSeries {
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
pub fn OptgradadagradSeries::cumsum(
  self : OptgradadagradSeries,
) -> OptgradadagradSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn OptgradadagradSeries::to_string(self : OptgradadagradSeries) -> String {
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
pub(all) struct OptgradadagradMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn opt_grad_adagrad_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> OptgradadagradMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn opt_grad_adagrad_matrix_identity(n : Int32) -> OptgradadagradMatrix {
  let m = opt_grad_adagrad_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn OptgradadagradMatrix::get(
  self : OptgradadagradMatrix,
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
pub fn OptgradadagradMatrix::transpose(
  self : OptgradadagradMatrix,
) -> OptgradadagradMatrix {
  let result = opt_grad_adagrad_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn OptgradadagradMatrix::add(
  self : OptgradadagradMatrix,
  other : OptgradadagradMatrix,
) -> OptgradadagradMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = opt_grad_adagrad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn OptgradadagradMatrix::scale(
  self : OptgradadagradMatrix,
  s : Double,
) -> OptgradadagradMatrix {
  let result = opt_grad_adagrad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn OptgradadagradMatrix::multiply(
  self : OptgradadagradMatrix,
  other : OptgradadagradMatrix,
) -> OptgradadagradMatrix {
  if self.cols != other.rows {
    return opt_grad_adagrad_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = opt_grad_adagrad_make_matrix(self.rows, other.cols, 0.0)
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
pub fn OptgradadagradMatrix::trace(self : OptgradadagradMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn OptgradadagradMatrix::det(self : OptgradadagradMatrix) -> Double {
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
pub fn OptgradadagradMatrix::norm(self : OptgradadagradMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn OptgradadagradMatrix::to_string(self : OptgradadagradMatrix) -> String {
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
pub(all) struct OptgradadagradVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn opt_grad_adagrad_make_vector(
  comps : Array[Double],
) -> OptgradadagradVector {
  { comps, dim: comps.length(), }
}

///|
pub fn opt_grad_adagrad_vector_zero(dim : Int32) -> OptgradadagradVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn OptgradadagradVector::add(
  self : OptgradadagradVector,
  other : OptgradadagradVector,
) -> OptgradadagradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn OptgradadagradVector::sub(
  self : OptgradadagradVector,
  other : OptgradadagradVector,
) -> OptgradadagradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn OptgradadagradVector::scale(
  self : OptgradadagradVector,
  s : Double,
) -> OptgradadagradVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn OptgradadagradVector::dot(
  self : OptgradadagradVector,
  other : OptgradadagradVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn OptgradadagradVector::norm(self : OptgradadagradVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn OptgradadagradVector::normalize(
  self : OptgradadagradVector,
) -> OptgradadagradVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn OptgradadagradVector::dist(
  self : OptgradadagradVector,
  other : OptgradadagradVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn OptgradadagradVector::to_string(self : OptgradadagradVector) -> String {
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
pub(all) struct OptgradadagradFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_frame_make(size : Int32) -> OptgradadagradFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradFrame::len(self : OptgradadagradFrame) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradFrame::get(
  self : OptgradadagradFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradFrame::set(
  self : OptgradadagradFrame,
  i : Int32,
  v : Double,
) -> OptgradadagradFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradFrame::sum(self : OptgradadagradFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradFrame::mean(self : OptgradadagradFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradFrame::scale(
  self : OptgradadagradFrame,
  f : Double,
) -> OptgradadagradFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradFrame::add(
  self : OptgradadagradFrame,
  other : OptgradadagradFrame,
) -> OptgradadagradFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradFrame::copy(
  self : OptgradadagradFrame,
) -> OptgradadagradFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradFrame::fill(
  self : OptgradadagradFrame,
  v : Double,
) -> OptgradadagradFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradFrame::min(self : OptgradadagradFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradFrame::max(self : OptgradadagradFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradFrame::to_string(self : OptgradadagradFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_table_make(size : Int32) -> OptgradadagradTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradTable::len(self : OptgradadagradTable) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradTable::get(
  self : OptgradadagradTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradTable::set(
  self : OptgradadagradTable,
  i : Int32,
  v : Double,
) -> OptgradadagradTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradTable::sum(self : OptgradadagradTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradTable::mean(self : OptgradadagradTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradTable::scale(
  self : OptgradadagradTable,
  f : Double,
) -> OptgradadagradTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradTable::add(
  self : OptgradadagradTable,
  other : OptgradadagradTable,
) -> OptgradadagradTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradTable::copy(
  self : OptgradadagradTable,
) -> OptgradadagradTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradTable::fill(
  self : OptgradadagradTable,
  v : Double,
) -> OptgradadagradTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradTable::min(self : OptgradadagradTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradTable::max(self : OptgradadagradTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradTable::to_string(self : OptgradadagradTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_graphn_make(size : Int32) -> OptgradadagradGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradGraphN::len(self : OptgradadagradGraphN) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradGraphN::get(
  self : OptgradadagradGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradGraphN::set(
  self : OptgradadagradGraphN,
  i : Int32,
  v : Double,
) -> OptgradadagradGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradGraphN::sum(self : OptgradadagradGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradGraphN::mean(self : OptgradadagradGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradGraphN::scale(
  self : OptgradadagradGraphN,
  f : Double,
) -> OptgradadagradGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradGraphN::add(
  self : OptgradadagradGraphN,
  other : OptgradadagradGraphN,
) -> OptgradadagradGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradGraphN::copy(
  self : OptgradadagradGraphN,
) -> OptgradadagradGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradGraphN::fill(
  self : OptgradadagradGraphN,
  v : Double,
) -> OptgradadagradGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradGraphN::min(self : OptgradadagradGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradGraphN::max(self : OptgradadagradGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradGraphN::to_string(self : OptgradadagradGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_node_make(size : Int32) -> OptgradadagradNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradNode::len(self : OptgradadagradNode) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradNode::get(self : OptgradadagradNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradNode::set(
  self : OptgradadagradNode,
  i : Int32,
  v : Double,
) -> OptgradadagradNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradNode::sum(self : OptgradadagradNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradNode::mean(self : OptgradadagradNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradNode::scale(
  self : OptgradadagradNode,
  f : Double,
) -> OptgradadagradNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradNode::add(
  self : OptgradadagradNode,
  other : OptgradadagradNode,
) -> OptgradadagradNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradNode::copy(
  self : OptgradadagradNode,
) -> OptgradadagradNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradNode::fill(
  self : OptgradadagradNode,
  v : Double,
) -> OptgradadagradNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradNode::min(self : OptgradadagradNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradNode::max(self : OptgradadagradNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradNode::to_string(self : OptgradadagradNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_edge_make(size : Int32) -> OptgradadagradEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradEdge::len(self : OptgradadagradEdge) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradEdge::get(self : OptgradadagradEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradEdge::set(
  self : OptgradadagradEdge,
  i : Int32,
  v : Double,
) -> OptgradadagradEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradEdge::sum(self : OptgradadagradEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradEdge::mean(self : OptgradadagradEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradEdge::scale(
  self : OptgradadagradEdge,
  f : Double,
) -> OptgradadagradEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradEdge::add(
  self : OptgradadagradEdge,
  other : OptgradadagradEdge,
) -> OptgradadagradEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradEdge::copy(
  self : OptgradadagradEdge,
) -> OptgradadagradEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradEdge::fill(
  self : OptgradadagradEdge,
  v : Double,
) -> OptgradadagradEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradEdge::min(self : OptgradadagradEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradEdge::max(self : OptgradadagradEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradEdge::to_string(self : OptgradadagradEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_path_make(size : Int32) -> OptgradadagradPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradPath::len(self : OptgradadagradPath) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradPath::get(self : OptgradadagradPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradPath::set(
  self : OptgradadagradPath,
  i : Int32,
  v : Double,
) -> OptgradadagradPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradPath::sum(self : OptgradadagradPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradPath::mean(self : OptgradadagradPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradPath::scale(
  self : OptgradadagradPath,
  f : Double,
) -> OptgradadagradPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradPath::add(
  self : OptgradadagradPath,
  other : OptgradadagradPath,
) -> OptgradadagradPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradPath::copy(
  self : OptgradadagradPath,
) -> OptgradadagradPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradPath::fill(
  self : OptgradadagradPath,
  v : Double,
) -> OptgradadagradPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradPath::min(self : OptgradadagradPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradPath::max(self : OptgradadagradPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradPath::to_string(self : OptgradadagradPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_cluster_make(size : Int32) -> OptgradadagradCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradCluster::len(self : OptgradadagradCluster) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradCluster::get(
  self : OptgradadagradCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradCluster::set(
  self : OptgradadagradCluster,
  i : Int32,
  v : Double,
) -> OptgradadagradCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradCluster::sum(self : OptgradadagradCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradCluster::mean(self : OptgradadagradCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradCluster::scale(
  self : OptgradadagradCluster,
  f : Double,
) -> OptgradadagradCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradCluster::add(
  self : OptgradadagradCluster,
  other : OptgradadagradCluster,
) -> OptgradadagradCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradCluster::copy(
  self : OptgradadagradCluster,
) -> OptgradadagradCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradCluster::fill(
  self : OptgradadagradCluster,
  v : Double,
) -> OptgradadagradCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradCluster::min(self : OptgradadagradCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradCluster::max(self : OptgradadagradCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradCluster::to_string(self : OptgradadagradCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_model_make(size : Int32) -> OptgradadagradModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradModel::len(self : OptgradadagradModel) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradModel::get(
  self : OptgradadagradModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradModel::set(
  self : OptgradadagradModel,
  i : Int32,
  v : Double,
) -> OptgradadagradModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradModel::sum(self : OptgradadagradModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradModel::mean(self : OptgradadagradModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradModel::scale(
  self : OptgradadagradModel,
  f : Double,
) -> OptgradadagradModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradModel::add(
  self : OptgradadagradModel,
  other : OptgradadagradModel,
) -> OptgradadagradModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradModel::copy(
  self : OptgradadagradModel,
) -> OptgradadagradModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradModel::fill(
  self : OptgradadagradModel,
  v : Double,
) -> OptgradadagradModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradModel::min(self : OptgradadagradModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradModel::max(self : OptgradadagradModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradModel::to_string(self : OptgradadagradModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_layer_make(size : Int32) -> OptgradadagradLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradLayer::len(self : OptgradadagradLayer) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradLayer::get(
  self : OptgradadagradLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradLayer::set(
  self : OptgradadagradLayer,
  i : Int32,
  v : Double,
) -> OptgradadagradLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradLayer::sum(self : OptgradadagradLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradLayer::mean(self : OptgradadagradLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradLayer::scale(
  self : OptgradadagradLayer,
  f : Double,
) -> OptgradadagradLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradLayer::add(
  self : OptgradadagradLayer,
  other : OptgradadagradLayer,
) -> OptgradadagradLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradLayer::copy(
  self : OptgradadagradLayer,
) -> OptgradadagradLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradLayer::fill(
  self : OptgradadagradLayer,
  v : Double,
) -> OptgradadagradLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradLayer::min(self : OptgradadagradLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradLayer::max(self : OptgradadagradLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradLayer::to_string(self : OptgradadagradLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_buffer_make(size : Int32) -> OptgradadagradBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradBuffer::len(self : OptgradadagradBuffer) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradBuffer::get(
  self : OptgradadagradBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradBuffer::set(
  self : OptgradadagradBuffer,
  i : Int32,
  v : Double,
) -> OptgradadagradBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradBuffer::sum(self : OptgradadagradBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradBuffer::mean(self : OptgradadagradBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradBuffer::scale(
  self : OptgradadagradBuffer,
  f : Double,
) -> OptgradadagradBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradBuffer::add(
  self : OptgradadagradBuffer,
  other : OptgradadagradBuffer,
) -> OptgradadagradBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradBuffer::copy(
  self : OptgradadagradBuffer,
) -> OptgradadagradBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradBuffer::fill(
  self : OptgradadagradBuffer,
  v : Double,
) -> OptgradadagradBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradBuffer::min(self : OptgradadagradBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradBuffer::max(self : OptgradadagradBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradBuffer::to_string(self : OptgradadagradBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_cursor_make(size : Int32) -> OptgradadagradCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradCursor::len(self : OptgradadagradCursor) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradCursor::get(
  self : OptgradadagradCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradCursor::set(
  self : OptgradadagradCursor,
  i : Int32,
  v : Double,
) -> OptgradadagradCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradCursor::sum(self : OptgradadagradCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradCursor::mean(self : OptgradadagradCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradCursor::scale(
  self : OptgradadagradCursor,
  f : Double,
) -> OptgradadagradCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradCursor::add(
  self : OptgradadagradCursor,
  other : OptgradadagradCursor,
) -> OptgradadagradCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradCursor::copy(
  self : OptgradadagradCursor,
) -> OptgradadagradCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradCursor::fill(
  self : OptgradadagradCursor,
  v : Double,
) -> OptgradadagradCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradCursor::min(self : OptgradadagradCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradCursor::max(self : OptgradadagradCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradCursor::to_string(self : OptgradadagradCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_view_make(size : Int32) -> OptgradadagradView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradView::len(self : OptgradadagradView) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradView::get(self : OptgradadagradView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradView::set(
  self : OptgradadagradView,
  i : Int32,
  v : Double,
) -> OptgradadagradView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradView::sum(self : OptgradadagradView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradView::mean(self : OptgradadagradView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradView::scale(
  self : OptgradadagradView,
  f : Double,
) -> OptgradadagradView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradView::add(
  self : OptgradadagradView,
  other : OptgradadagradView,
) -> OptgradadagradView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradView::copy(
  self : OptgradadagradView,
) -> OptgradadagradView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradView::fill(
  self : OptgradadagradView,
  v : Double,
) -> OptgradadagradView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradView::min(self : OptgradadagradView) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradView::max(self : OptgradadagradView) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradView::to_string(self : OptgradadagradView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_range_make(size : Int32) -> OptgradadagradRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradRange::len(self : OptgradadagradRange) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradRange::get(
  self : OptgradadagradRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradRange::set(
  self : OptgradadagradRange,
  i : Int32,
  v : Double,
) -> OptgradadagradRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradRange::sum(self : OptgradadagradRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradRange::mean(self : OptgradadagradRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradRange::scale(
  self : OptgradadagradRange,
  f : Double,
) -> OptgradadagradRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradRange::add(
  self : OptgradadagradRange,
  other : OptgradadagradRange,
) -> OptgradadagradRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradRange::copy(
  self : OptgradadagradRange,
) -> OptgradadagradRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradRange::fill(
  self : OptgradadagradRange,
  v : Double,
) -> OptgradadagradRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradRange::min(self : OptgradadagradRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradRange::max(self : OptgradadagradRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradRange::to_string(self : OptgradadagradRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptgradadagradSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_grad_adagrad_slice_make(size : Int32) -> OptgradadagradSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptgradadagradSlice::len(self : OptgradadagradSlice) -> Int32 {
  self.size
}

///|
pub fn OptgradadagradSlice::get(
  self : OptgradadagradSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptgradadagradSlice::set(
  self : OptgradadagradSlice,
  i : Int32,
  v : Double,
) -> OptgradadagradSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradSlice::sum(self : OptgradadagradSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptgradadagradSlice::mean(self : OptgradadagradSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptgradadagradSlice::scale(
  self : OptgradadagradSlice,
  f : Double,
) -> OptgradadagradSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradSlice::add(
  self : OptgradadagradSlice,
  other : OptgradadagradSlice,
) -> OptgradadagradSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptgradadagradSlice::copy(
  self : OptgradadagradSlice,
) -> OptgradadagradSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradSlice::fill(
  self : OptgradadagradSlice,
  v : Double,
) -> OptgradadagradSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptgradadagradSlice::min(self : OptgradadagradSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptgradadagradSlice::max(self : OptgradadagradSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptgradadagradSlice::to_string(self : OptgradadagradSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
