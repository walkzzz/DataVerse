///|
///===
/// extcore/ds_tree_lct
pub(all) struct DstreelctPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ds_tree_lct_make_point(x : Double, y : Double) -> DstreelctPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ds_tree_lct_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DstreelctPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DstreelctPoint::x(self : DstreelctPoint) -> Double {
  self.x
}

///|
pub fn DstreelctPoint::y(self : DstreelctPoint) -> Double {
  self.y
}

///|
pub fn DstreelctPoint::z(self : DstreelctPoint) -> Double {
  self.z
}

///|
pub fn DstreelctPoint::label(self : DstreelctPoint) -> Int32 {
  self.label
}

///|
pub fn DstreelctPoint::dist(
  self : DstreelctPoint,
  other : DstreelctPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DstreelctPoint::add(
  self : DstreelctPoint,
  other : DstreelctPoint,
) -> DstreelctPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DstreelctPoint::sub(
  self : DstreelctPoint,
  other : DstreelctPoint,
) -> DstreelctPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DstreelctPoint::scale(
  self : DstreelctPoint,
  s : Double,
) -> DstreelctPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DstreelctPoint::dot(
  self : DstreelctPoint,
  other : DstreelctPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DstreelctPoint::cross(
  self : DstreelctPoint,
  other : DstreelctPoint,
) -> DstreelctPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DstreelctPoint::norm(self : DstreelctPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DstreelctPoint::normalize(self : DstreelctPoint) -> DstreelctPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DstreelctPoint::negate(self : DstreelctPoint) -> DstreelctPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DstreelctPoint::mid(
  self : DstreelctPoint,
  other : DstreelctPoint,
) -> DstreelctPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DstreelctPoint::lerp(
  self : DstreelctPoint,
  other : DstreelctPoint,
  t : Double,
) -> DstreelctPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DstreelctPoint::to_string(self : DstreelctPoint) -> String {
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
pub(all) struct DstreelctSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ds_tree_lct_make_series(
  vals : Array[Double],
  name : String,
) -> DstreelctSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DstreelctSeries::len(self : DstreelctSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DstreelctSeries::sum(self : DstreelctSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DstreelctSeries::mean(self : DstreelctSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DstreelctSeries::min(self : DstreelctSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DstreelctSeries::max(self : DstreelctSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DstreelctSeries::range(self : DstreelctSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DstreelctSeries::variance(self : DstreelctSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DstreelctSeries::std(self : DstreelctSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DstreelctSeries::median(self : DstreelctSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DstreelctSeries::scale(
  self : DstreelctSeries,
  f : Double,
) -> DstreelctSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DstreelctSeries::add(
  self : DstreelctSeries,
  other : DstreelctSeries,
) -> DstreelctSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DstreelctSeries::sub(
  self : DstreelctSeries,
  other : DstreelctSeries,
) -> DstreelctSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DstreelctSeries::normalize(self : DstreelctSeries) -> DstreelctSeries {
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
pub fn DstreelctSeries::cumsum(self : DstreelctSeries) -> DstreelctSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DstreelctSeries::to_string(self : DstreelctSeries) -> String {
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
pub(all) struct DstreelctMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ds_tree_lct_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DstreelctMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ds_tree_lct_matrix_identity(n : Int32) -> DstreelctMatrix {
  let m = ds_tree_lct_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DstreelctMatrix::get(
  self : DstreelctMatrix,
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
pub fn DstreelctMatrix::transpose(self : DstreelctMatrix) -> DstreelctMatrix {
  let result = ds_tree_lct_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DstreelctMatrix::add(
  self : DstreelctMatrix,
  other : DstreelctMatrix,
) -> DstreelctMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ds_tree_lct_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DstreelctMatrix::scale(
  self : DstreelctMatrix,
  s : Double,
) -> DstreelctMatrix {
  let result = ds_tree_lct_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DstreelctMatrix::multiply(
  self : DstreelctMatrix,
  other : DstreelctMatrix,
) -> DstreelctMatrix {
  if self.cols != other.rows {
    return ds_tree_lct_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ds_tree_lct_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DstreelctMatrix::trace(self : DstreelctMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DstreelctMatrix::det(self : DstreelctMatrix) -> Double {
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
pub fn DstreelctMatrix::norm(self : DstreelctMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DstreelctMatrix::to_string(self : DstreelctMatrix) -> String {
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
pub(all) struct DstreelctVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ds_tree_lct_make_vector(comps : Array[Double]) -> DstreelctVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ds_tree_lct_vector_zero(dim : Int32) -> DstreelctVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DstreelctVector::add(
  self : DstreelctVector,
  other : DstreelctVector,
) -> DstreelctVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DstreelctVector::sub(
  self : DstreelctVector,
  other : DstreelctVector,
) -> DstreelctVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DstreelctVector::scale(
  self : DstreelctVector,
  s : Double,
) -> DstreelctVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DstreelctVector::dot(
  self : DstreelctVector,
  other : DstreelctVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DstreelctVector::norm(self : DstreelctVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DstreelctVector::normalize(self : DstreelctVector) -> DstreelctVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DstreelctVector::dist(
  self : DstreelctVector,
  other : DstreelctVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DstreelctVector::to_string(self : DstreelctVector) -> String {
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
pub(all) struct DstreelctFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_frame_make(size : Int32) -> DstreelctFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctFrame::len(self : DstreelctFrame) -> Int32 {
  self.size
}

///|
pub fn DstreelctFrame::get(self : DstreelctFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctFrame::set(
  self : DstreelctFrame,
  i : Int32,
  v : Double,
) -> DstreelctFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctFrame::sum(self : DstreelctFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctFrame::mean(self : DstreelctFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctFrame::scale(
  self : DstreelctFrame,
  f : Double,
) -> DstreelctFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctFrame::add(
  self : DstreelctFrame,
  other : DstreelctFrame,
) -> DstreelctFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctFrame::copy(self : DstreelctFrame) -> DstreelctFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctFrame::fill(
  self : DstreelctFrame,
  v : Double,
) -> DstreelctFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctFrame::min(self : DstreelctFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctFrame::max(self : DstreelctFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctFrame::to_string(self : DstreelctFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_table_make(size : Int32) -> DstreelctTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctTable::len(self : DstreelctTable) -> Int32 {
  self.size
}

///|
pub fn DstreelctTable::get(self : DstreelctTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctTable::set(
  self : DstreelctTable,
  i : Int32,
  v : Double,
) -> DstreelctTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctTable::sum(self : DstreelctTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctTable::mean(self : DstreelctTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctTable::scale(
  self : DstreelctTable,
  f : Double,
) -> DstreelctTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctTable::add(
  self : DstreelctTable,
  other : DstreelctTable,
) -> DstreelctTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctTable::copy(self : DstreelctTable) -> DstreelctTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctTable::fill(
  self : DstreelctTable,
  v : Double,
) -> DstreelctTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctTable::min(self : DstreelctTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctTable::max(self : DstreelctTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctTable::to_string(self : DstreelctTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_graphn_make(size : Int32) -> DstreelctGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctGraphN::len(self : DstreelctGraphN) -> Int32 {
  self.size
}

///|
pub fn DstreelctGraphN::get(self : DstreelctGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctGraphN::set(
  self : DstreelctGraphN,
  i : Int32,
  v : Double,
) -> DstreelctGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctGraphN::sum(self : DstreelctGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctGraphN::mean(self : DstreelctGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctGraphN::scale(
  self : DstreelctGraphN,
  f : Double,
) -> DstreelctGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctGraphN::add(
  self : DstreelctGraphN,
  other : DstreelctGraphN,
) -> DstreelctGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctGraphN::copy(self : DstreelctGraphN) -> DstreelctGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctGraphN::fill(
  self : DstreelctGraphN,
  v : Double,
) -> DstreelctGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctGraphN::min(self : DstreelctGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctGraphN::max(self : DstreelctGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctGraphN::to_string(self : DstreelctGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_node_make(size : Int32) -> DstreelctNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctNode::len(self : DstreelctNode) -> Int32 {
  self.size
}

///|
pub fn DstreelctNode::get(self : DstreelctNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctNode::set(
  self : DstreelctNode,
  i : Int32,
  v : Double,
) -> DstreelctNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctNode::sum(self : DstreelctNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctNode::mean(self : DstreelctNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctNode::scale(self : DstreelctNode, f : Double) -> DstreelctNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctNode::add(
  self : DstreelctNode,
  other : DstreelctNode,
) -> DstreelctNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctNode::copy(self : DstreelctNode) -> DstreelctNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctNode::fill(self : DstreelctNode, v : Double) -> DstreelctNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctNode::min(self : DstreelctNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctNode::max(self : DstreelctNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctNode::to_string(self : DstreelctNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_edge_make(size : Int32) -> DstreelctEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctEdge::len(self : DstreelctEdge) -> Int32 {
  self.size
}

///|
pub fn DstreelctEdge::get(self : DstreelctEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctEdge::set(
  self : DstreelctEdge,
  i : Int32,
  v : Double,
) -> DstreelctEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctEdge::sum(self : DstreelctEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctEdge::mean(self : DstreelctEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctEdge::scale(self : DstreelctEdge, f : Double) -> DstreelctEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctEdge::add(
  self : DstreelctEdge,
  other : DstreelctEdge,
) -> DstreelctEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctEdge::copy(self : DstreelctEdge) -> DstreelctEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctEdge::fill(self : DstreelctEdge, v : Double) -> DstreelctEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctEdge::min(self : DstreelctEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctEdge::max(self : DstreelctEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctEdge::to_string(self : DstreelctEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_path_make(size : Int32) -> DstreelctPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctPath::len(self : DstreelctPath) -> Int32 {
  self.size
}

///|
pub fn DstreelctPath::get(self : DstreelctPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctPath::set(
  self : DstreelctPath,
  i : Int32,
  v : Double,
) -> DstreelctPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctPath::sum(self : DstreelctPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctPath::mean(self : DstreelctPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctPath::scale(self : DstreelctPath, f : Double) -> DstreelctPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctPath::add(
  self : DstreelctPath,
  other : DstreelctPath,
) -> DstreelctPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctPath::copy(self : DstreelctPath) -> DstreelctPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctPath::fill(self : DstreelctPath, v : Double) -> DstreelctPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctPath::min(self : DstreelctPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctPath::max(self : DstreelctPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctPath::to_string(self : DstreelctPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_cluster_make(size : Int32) -> DstreelctCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctCluster::len(self : DstreelctCluster) -> Int32 {
  self.size
}

///|
pub fn DstreelctCluster::get(self : DstreelctCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctCluster::set(
  self : DstreelctCluster,
  i : Int32,
  v : Double,
) -> DstreelctCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctCluster::sum(self : DstreelctCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctCluster::mean(self : DstreelctCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctCluster::scale(
  self : DstreelctCluster,
  f : Double,
) -> DstreelctCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctCluster::add(
  self : DstreelctCluster,
  other : DstreelctCluster,
) -> DstreelctCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctCluster::copy(self : DstreelctCluster) -> DstreelctCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctCluster::fill(
  self : DstreelctCluster,
  v : Double,
) -> DstreelctCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctCluster::min(self : DstreelctCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctCluster::max(self : DstreelctCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctCluster::to_string(self : DstreelctCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_model_make(size : Int32) -> DstreelctModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctModel::len(self : DstreelctModel) -> Int32 {
  self.size
}

///|
pub fn DstreelctModel::get(self : DstreelctModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctModel::set(
  self : DstreelctModel,
  i : Int32,
  v : Double,
) -> DstreelctModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctModel::sum(self : DstreelctModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctModel::mean(self : DstreelctModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctModel::scale(
  self : DstreelctModel,
  f : Double,
) -> DstreelctModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctModel::add(
  self : DstreelctModel,
  other : DstreelctModel,
) -> DstreelctModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctModel::copy(self : DstreelctModel) -> DstreelctModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctModel::fill(
  self : DstreelctModel,
  v : Double,
) -> DstreelctModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctModel::min(self : DstreelctModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctModel::max(self : DstreelctModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctModel::to_string(self : DstreelctModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_layer_make(size : Int32) -> DstreelctLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctLayer::len(self : DstreelctLayer) -> Int32 {
  self.size
}

///|
pub fn DstreelctLayer::get(self : DstreelctLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctLayer::set(
  self : DstreelctLayer,
  i : Int32,
  v : Double,
) -> DstreelctLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctLayer::sum(self : DstreelctLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctLayer::mean(self : DstreelctLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctLayer::scale(
  self : DstreelctLayer,
  f : Double,
) -> DstreelctLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctLayer::add(
  self : DstreelctLayer,
  other : DstreelctLayer,
) -> DstreelctLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctLayer::copy(self : DstreelctLayer) -> DstreelctLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctLayer::fill(
  self : DstreelctLayer,
  v : Double,
) -> DstreelctLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctLayer::min(self : DstreelctLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctLayer::max(self : DstreelctLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctLayer::to_string(self : DstreelctLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_buffer_make(size : Int32) -> DstreelctBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctBuffer::len(self : DstreelctBuffer) -> Int32 {
  self.size
}

///|
pub fn DstreelctBuffer::get(self : DstreelctBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctBuffer::set(
  self : DstreelctBuffer,
  i : Int32,
  v : Double,
) -> DstreelctBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctBuffer::sum(self : DstreelctBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctBuffer::mean(self : DstreelctBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctBuffer::scale(
  self : DstreelctBuffer,
  f : Double,
) -> DstreelctBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctBuffer::add(
  self : DstreelctBuffer,
  other : DstreelctBuffer,
) -> DstreelctBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctBuffer::copy(self : DstreelctBuffer) -> DstreelctBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctBuffer::fill(
  self : DstreelctBuffer,
  v : Double,
) -> DstreelctBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctBuffer::min(self : DstreelctBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctBuffer::max(self : DstreelctBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctBuffer::to_string(self : DstreelctBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_cursor_make(size : Int32) -> DstreelctCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctCursor::len(self : DstreelctCursor) -> Int32 {
  self.size
}

///|
pub fn DstreelctCursor::get(self : DstreelctCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctCursor::set(
  self : DstreelctCursor,
  i : Int32,
  v : Double,
) -> DstreelctCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctCursor::sum(self : DstreelctCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctCursor::mean(self : DstreelctCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctCursor::scale(
  self : DstreelctCursor,
  f : Double,
) -> DstreelctCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctCursor::add(
  self : DstreelctCursor,
  other : DstreelctCursor,
) -> DstreelctCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctCursor::copy(self : DstreelctCursor) -> DstreelctCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctCursor::fill(
  self : DstreelctCursor,
  v : Double,
) -> DstreelctCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctCursor::min(self : DstreelctCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctCursor::max(self : DstreelctCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctCursor::to_string(self : DstreelctCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_view_make(size : Int32) -> DstreelctView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctView::len(self : DstreelctView) -> Int32 {
  self.size
}

///|
pub fn DstreelctView::get(self : DstreelctView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctView::set(
  self : DstreelctView,
  i : Int32,
  v : Double,
) -> DstreelctView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctView::sum(self : DstreelctView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctView::mean(self : DstreelctView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctView::scale(self : DstreelctView, f : Double) -> DstreelctView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctView::add(
  self : DstreelctView,
  other : DstreelctView,
) -> DstreelctView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctView::copy(self : DstreelctView) -> DstreelctView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctView::fill(self : DstreelctView, v : Double) -> DstreelctView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctView::min(self : DstreelctView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctView::max(self : DstreelctView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctView::to_string(self : DstreelctView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_range_make(size : Int32) -> DstreelctRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctRange::len(self : DstreelctRange) -> Int32 {
  self.size
}

///|
pub fn DstreelctRange::get(self : DstreelctRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctRange::set(
  self : DstreelctRange,
  i : Int32,
  v : Double,
) -> DstreelctRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctRange::sum(self : DstreelctRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctRange::mean(self : DstreelctRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctRange::scale(
  self : DstreelctRange,
  f : Double,
) -> DstreelctRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctRange::add(
  self : DstreelctRange,
  other : DstreelctRange,
) -> DstreelctRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctRange::copy(self : DstreelctRange) -> DstreelctRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctRange::fill(
  self : DstreelctRange,
  v : Double,
) -> DstreelctRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctRange::min(self : DstreelctRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctRange::max(self : DstreelctRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctRange::to_string(self : DstreelctRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DstreelctSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_tree_lct_slice_make(size : Int32) -> DstreelctSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DstreelctSlice::len(self : DstreelctSlice) -> Int32 {
  self.size
}

///|
pub fn DstreelctSlice::get(self : DstreelctSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DstreelctSlice::set(
  self : DstreelctSlice,
  i : Int32,
  v : Double,
) -> DstreelctSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctSlice::sum(self : DstreelctSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DstreelctSlice::mean(self : DstreelctSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DstreelctSlice::scale(
  self : DstreelctSlice,
  f : Double,
) -> DstreelctSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctSlice::add(
  self : DstreelctSlice,
  other : DstreelctSlice,
) -> DstreelctSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DstreelctSlice::copy(self : DstreelctSlice) -> DstreelctSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctSlice::fill(
  self : DstreelctSlice,
  v : Double,
) -> DstreelctSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DstreelctSlice::min(self : DstreelctSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DstreelctSlice::max(self : DstreelctSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DstreelctSlice::to_string(self : DstreelctSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
