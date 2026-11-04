///|
///===
/// extcore/stats_test_f
pub(all) struct StatstestfPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_test_f_make_point(x : Double, y : Double) -> StatstestfPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_test_f_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatstestfPoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatstestfPoint::x(self : StatstestfPoint) -> Double {
  self.x
}

///|
pub fn StatstestfPoint::y(self : StatstestfPoint) -> Double {
  self.y
}

///|
pub fn StatstestfPoint::z(self : StatstestfPoint) -> Double {
  self.z
}

///|
pub fn StatstestfPoint::label(self : StatstestfPoint) -> Int32 {
  self.label
}

///|
pub fn StatstestfPoint::dist(
  self : StatstestfPoint,
  other : StatstestfPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatstestfPoint::add(
  self : StatstestfPoint,
  other : StatstestfPoint,
) -> StatstestfPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatstestfPoint::sub(
  self : StatstestfPoint,
  other : StatstestfPoint,
) -> StatstestfPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatstestfPoint::scale(
  self : StatstestfPoint,
  s : Double,
) -> StatstestfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatstestfPoint::dot(
  self : StatstestfPoint,
  other : StatstestfPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatstestfPoint::cross(
  self : StatstestfPoint,
  other : StatstestfPoint,
) -> StatstestfPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatstestfPoint::norm(self : StatstestfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatstestfPoint::normalize(self : StatstestfPoint) -> StatstestfPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatstestfPoint::negate(self : StatstestfPoint) -> StatstestfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatstestfPoint::mid(
  self : StatstestfPoint,
  other : StatstestfPoint,
) -> StatstestfPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatstestfPoint::lerp(
  self : StatstestfPoint,
  other : StatstestfPoint,
  t : Double,
) -> StatstestfPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatstestfPoint::to_string(self : StatstestfPoint) -> String {
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
pub(all) struct StatstestfSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_test_f_make_series(
  vals : Array[Double],
  name : String,
) -> StatstestfSeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatstestfSeries::len(self : StatstestfSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn StatstestfSeries::sum(self : StatstestfSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatstestfSeries::mean(self : StatstestfSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatstestfSeries::min(self : StatstestfSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatstestfSeries::max(self : StatstestfSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatstestfSeries::range(self : StatstestfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatstestfSeries::variance(self : StatstestfSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatstestfSeries::std(self : StatstestfSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatstestfSeries::median(self : StatstestfSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatstestfSeries::scale(
  self : StatstestfSeries,
  f : Double,
) -> StatstestfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatstestfSeries::add(
  self : StatstestfSeries,
  other : StatstestfSeries,
) -> StatstestfSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatstestfSeries::sub(
  self : StatstestfSeries,
  other : StatstestfSeries,
) -> StatstestfSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatstestfSeries::normalize(self : StatstestfSeries) -> StatstestfSeries {
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
pub fn StatstestfSeries::cumsum(self : StatstestfSeries) -> StatstestfSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatstestfSeries::to_string(self : StatstestfSeries) -> String {
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
pub(all) struct StatstestfMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_test_f_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatstestfMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_test_f_matrix_identity(n : Int32) -> StatstestfMatrix {
  let m = stats_test_f_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatstestfMatrix::get(
  self : StatstestfMatrix,
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
pub fn StatstestfMatrix::transpose(self : StatstestfMatrix) -> StatstestfMatrix {
  let result = stats_test_f_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatstestfMatrix::add(
  self : StatstestfMatrix,
  other : StatstestfMatrix,
) -> StatstestfMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_test_f_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatstestfMatrix::scale(
  self : StatstestfMatrix,
  s : Double,
) -> StatstestfMatrix {
  let result = stats_test_f_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatstestfMatrix::multiply(
  self : StatstestfMatrix,
  other : StatstestfMatrix,
) -> StatstestfMatrix {
  if self.cols != other.rows {
    return stats_test_f_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_test_f_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatstestfMatrix::trace(self : StatstestfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatstestfMatrix::det(self : StatstestfMatrix) -> Double {
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
pub fn StatstestfMatrix::norm(self : StatstestfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn StatstestfMatrix::to_string(self : StatstestfMatrix) -> String {
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
pub(all) struct StatstestfVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_test_f_make_vector(comps : Array[Double]) -> StatstestfVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_test_f_vector_zero(dim : Int32) -> StatstestfVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatstestfVector::add(
  self : StatstestfVector,
  other : StatstestfVector,
) -> StatstestfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatstestfVector::sub(
  self : StatstestfVector,
  other : StatstestfVector,
) -> StatstestfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatstestfVector::scale(
  self : StatstestfVector,
  s : Double,
) -> StatstestfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatstestfVector::dot(
  self : StatstestfVector,
  other : StatstestfVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatstestfVector::norm(self : StatstestfVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatstestfVector::normalize(self : StatstestfVector) -> StatstestfVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatstestfVector::dist(
  self : StatstestfVector,
  other : StatstestfVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatstestfVector::to_string(self : StatstestfVector) -> String {
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
pub(all) struct StatstestfFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_frame_make(size : Int32) -> StatstestfFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfFrame::len(self : StatstestfFrame) -> Int32 {
  self.size
}

///|
pub fn StatstestfFrame::get(self : StatstestfFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfFrame::set(
  self : StatstestfFrame,
  i : Int32,
  v : Double,
) -> StatstestfFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfFrame::sum(self : StatstestfFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfFrame::mean(self : StatstestfFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfFrame::scale(
  self : StatstestfFrame,
  f : Double,
) -> StatstestfFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfFrame::add(
  self : StatstestfFrame,
  other : StatstestfFrame,
) -> StatstestfFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfFrame::copy(self : StatstestfFrame) -> StatstestfFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfFrame::fill(
  self : StatstestfFrame,
  v : Double,
) -> StatstestfFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfFrame::min(self : StatstestfFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfFrame::max(self : StatstestfFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfFrame::to_string(self : StatstestfFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_table_make(size : Int32) -> StatstestfTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfTable::len(self : StatstestfTable) -> Int32 {
  self.size
}

///|
pub fn StatstestfTable::get(self : StatstestfTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfTable::set(
  self : StatstestfTable,
  i : Int32,
  v : Double,
) -> StatstestfTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfTable::sum(self : StatstestfTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfTable::mean(self : StatstestfTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfTable::scale(
  self : StatstestfTable,
  f : Double,
) -> StatstestfTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfTable::add(
  self : StatstestfTable,
  other : StatstestfTable,
) -> StatstestfTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfTable::copy(self : StatstestfTable) -> StatstestfTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfTable::fill(
  self : StatstestfTable,
  v : Double,
) -> StatstestfTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfTable::min(self : StatstestfTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfTable::max(self : StatstestfTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfTable::to_string(self : StatstestfTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_graphn_make(size : Int32) -> StatstestfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfGraphN::len(self : StatstestfGraphN) -> Int32 {
  self.size
}

///|
pub fn StatstestfGraphN::get(self : StatstestfGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfGraphN::set(
  self : StatstestfGraphN,
  i : Int32,
  v : Double,
) -> StatstestfGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfGraphN::sum(self : StatstestfGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfGraphN::mean(self : StatstestfGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfGraphN::scale(
  self : StatstestfGraphN,
  f : Double,
) -> StatstestfGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfGraphN::add(
  self : StatstestfGraphN,
  other : StatstestfGraphN,
) -> StatstestfGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfGraphN::copy(self : StatstestfGraphN) -> StatstestfGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfGraphN::fill(
  self : StatstestfGraphN,
  v : Double,
) -> StatstestfGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfGraphN::min(self : StatstestfGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfGraphN::max(self : StatstestfGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfGraphN::to_string(self : StatstestfGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_node_make(size : Int32) -> StatstestfNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfNode::len(self : StatstestfNode) -> Int32 {
  self.size
}

///|
pub fn StatstestfNode::get(self : StatstestfNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfNode::set(
  self : StatstestfNode,
  i : Int32,
  v : Double,
) -> StatstestfNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfNode::sum(self : StatstestfNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfNode::mean(self : StatstestfNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfNode::scale(
  self : StatstestfNode,
  f : Double,
) -> StatstestfNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfNode::add(
  self : StatstestfNode,
  other : StatstestfNode,
) -> StatstestfNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfNode::copy(self : StatstestfNode) -> StatstestfNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfNode::fill(
  self : StatstestfNode,
  v : Double,
) -> StatstestfNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfNode::min(self : StatstestfNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfNode::max(self : StatstestfNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfNode::to_string(self : StatstestfNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_edge_make(size : Int32) -> StatstestfEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfEdge::len(self : StatstestfEdge) -> Int32 {
  self.size
}

///|
pub fn StatstestfEdge::get(self : StatstestfEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfEdge::set(
  self : StatstestfEdge,
  i : Int32,
  v : Double,
) -> StatstestfEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfEdge::sum(self : StatstestfEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfEdge::mean(self : StatstestfEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfEdge::scale(
  self : StatstestfEdge,
  f : Double,
) -> StatstestfEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfEdge::add(
  self : StatstestfEdge,
  other : StatstestfEdge,
) -> StatstestfEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfEdge::copy(self : StatstestfEdge) -> StatstestfEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfEdge::fill(
  self : StatstestfEdge,
  v : Double,
) -> StatstestfEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfEdge::min(self : StatstestfEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfEdge::max(self : StatstestfEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfEdge::to_string(self : StatstestfEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_path_make(size : Int32) -> StatstestfPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfPath::len(self : StatstestfPath) -> Int32 {
  self.size
}

///|
pub fn StatstestfPath::get(self : StatstestfPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfPath::set(
  self : StatstestfPath,
  i : Int32,
  v : Double,
) -> StatstestfPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfPath::sum(self : StatstestfPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfPath::mean(self : StatstestfPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfPath::scale(
  self : StatstestfPath,
  f : Double,
) -> StatstestfPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfPath::add(
  self : StatstestfPath,
  other : StatstestfPath,
) -> StatstestfPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfPath::copy(self : StatstestfPath) -> StatstestfPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfPath::fill(
  self : StatstestfPath,
  v : Double,
) -> StatstestfPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfPath::min(self : StatstestfPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfPath::max(self : StatstestfPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfPath::to_string(self : StatstestfPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_cluster_make(size : Int32) -> StatstestfCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfCluster::len(self : StatstestfCluster) -> Int32 {
  self.size
}

///|
pub fn StatstestfCluster::get(self : StatstestfCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfCluster::set(
  self : StatstestfCluster,
  i : Int32,
  v : Double,
) -> StatstestfCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfCluster::sum(self : StatstestfCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfCluster::mean(self : StatstestfCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfCluster::scale(
  self : StatstestfCluster,
  f : Double,
) -> StatstestfCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfCluster::add(
  self : StatstestfCluster,
  other : StatstestfCluster,
) -> StatstestfCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfCluster::copy(self : StatstestfCluster) -> StatstestfCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfCluster::fill(
  self : StatstestfCluster,
  v : Double,
) -> StatstestfCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfCluster::min(self : StatstestfCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfCluster::max(self : StatstestfCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfCluster::to_string(self : StatstestfCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_model_make(size : Int32) -> StatstestfModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfModel::len(self : StatstestfModel) -> Int32 {
  self.size
}

///|
pub fn StatstestfModel::get(self : StatstestfModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfModel::set(
  self : StatstestfModel,
  i : Int32,
  v : Double,
) -> StatstestfModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfModel::sum(self : StatstestfModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfModel::mean(self : StatstestfModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfModel::scale(
  self : StatstestfModel,
  f : Double,
) -> StatstestfModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfModel::add(
  self : StatstestfModel,
  other : StatstestfModel,
) -> StatstestfModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfModel::copy(self : StatstestfModel) -> StatstestfModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfModel::fill(
  self : StatstestfModel,
  v : Double,
) -> StatstestfModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfModel::min(self : StatstestfModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfModel::max(self : StatstestfModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfModel::to_string(self : StatstestfModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_layer_make(size : Int32) -> StatstestfLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfLayer::len(self : StatstestfLayer) -> Int32 {
  self.size
}

///|
pub fn StatstestfLayer::get(self : StatstestfLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfLayer::set(
  self : StatstestfLayer,
  i : Int32,
  v : Double,
) -> StatstestfLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfLayer::sum(self : StatstestfLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfLayer::mean(self : StatstestfLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfLayer::scale(
  self : StatstestfLayer,
  f : Double,
) -> StatstestfLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfLayer::add(
  self : StatstestfLayer,
  other : StatstestfLayer,
) -> StatstestfLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfLayer::copy(self : StatstestfLayer) -> StatstestfLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfLayer::fill(
  self : StatstestfLayer,
  v : Double,
) -> StatstestfLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfLayer::min(self : StatstestfLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfLayer::max(self : StatstestfLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfLayer::to_string(self : StatstestfLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_buffer_make(size : Int32) -> StatstestfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfBuffer::len(self : StatstestfBuffer) -> Int32 {
  self.size
}

///|
pub fn StatstestfBuffer::get(self : StatstestfBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfBuffer::set(
  self : StatstestfBuffer,
  i : Int32,
  v : Double,
) -> StatstestfBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfBuffer::sum(self : StatstestfBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfBuffer::mean(self : StatstestfBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfBuffer::scale(
  self : StatstestfBuffer,
  f : Double,
) -> StatstestfBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfBuffer::add(
  self : StatstestfBuffer,
  other : StatstestfBuffer,
) -> StatstestfBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfBuffer::copy(self : StatstestfBuffer) -> StatstestfBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfBuffer::fill(
  self : StatstestfBuffer,
  v : Double,
) -> StatstestfBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfBuffer::min(self : StatstestfBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfBuffer::max(self : StatstestfBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfBuffer::to_string(self : StatstestfBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_cursor_make(size : Int32) -> StatstestfCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfCursor::len(self : StatstestfCursor) -> Int32 {
  self.size
}

///|
pub fn StatstestfCursor::get(self : StatstestfCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfCursor::set(
  self : StatstestfCursor,
  i : Int32,
  v : Double,
) -> StatstestfCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfCursor::sum(self : StatstestfCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfCursor::mean(self : StatstestfCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfCursor::scale(
  self : StatstestfCursor,
  f : Double,
) -> StatstestfCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfCursor::add(
  self : StatstestfCursor,
  other : StatstestfCursor,
) -> StatstestfCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfCursor::copy(self : StatstestfCursor) -> StatstestfCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfCursor::fill(
  self : StatstestfCursor,
  v : Double,
) -> StatstestfCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfCursor::min(self : StatstestfCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfCursor::max(self : StatstestfCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfCursor::to_string(self : StatstestfCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_view_make(size : Int32) -> StatstestfView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfView::len(self : StatstestfView) -> Int32 {
  self.size
}

///|
pub fn StatstestfView::get(self : StatstestfView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfView::set(
  self : StatstestfView,
  i : Int32,
  v : Double,
) -> StatstestfView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfView::sum(self : StatstestfView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfView::mean(self : StatstestfView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfView::scale(
  self : StatstestfView,
  f : Double,
) -> StatstestfView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfView::add(
  self : StatstestfView,
  other : StatstestfView,
) -> StatstestfView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfView::copy(self : StatstestfView) -> StatstestfView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfView::fill(
  self : StatstestfView,
  v : Double,
) -> StatstestfView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfView::min(self : StatstestfView) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfView::max(self : StatstestfView) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfView::to_string(self : StatstestfView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_range_make(size : Int32) -> StatstestfRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfRange::len(self : StatstestfRange) -> Int32 {
  self.size
}

///|
pub fn StatstestfRange::get(self : StatstestfRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfRange::set(
  self : StatstestfRange,
  i : Int32,
  v : Double,
) -> StatstestfRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfRange::sum(self : StatstestfRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfRange::mean(self : StatstestfRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfRange::scale(
  self : StatstestfRange,
  f : Double,
) -> StatstestfRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfRange::add(
  self : StatstestfRange,
  other : StatstestfRange,
) -> StatstestfRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfRange::copy(self : StatstestfRange) -> StatstestfRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfRange::fill(
  self : StatstestfRange,
  v : Double,
) -> StatstestfRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfRange::min(self : StatstestfRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfRange::max(self : StatstestfRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfRange::to_string(self : StatstestfRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestfSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_f_slice_make(size : Int32) -> StatstestfSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestfSlice::len(self : StatstestfSlice) -> Int32 {
  self.size
}

///|
pub fn StatstestfSlice::get(self : StatstestfSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestfSlice::set(
  self : StatstestfSlice,
  i : Int32,
  v : Double,
) -> StatstestfSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfSlice::sum(self : StatstestfSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestfSlice::mean(self : StatstestfSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestfSlice::scale(
  self : StatstestfSlice,
  f : Double,
) -> StatstestfSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfSlice::add(
  self : StatstestfSlice,
  other : StatstestfSlice,
) -> StatstestfSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestfSlice::copy(self : StatstestfSlice) -> StatstestfSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfSlice::fill(
  self : StatstestfSlice,
  v : Double,
) -> StatstestfSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestfSlice::min(self : StatstestfSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestfSlice::max(self : StatstestfSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestfSlice::to_string(self : StatstestfSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
