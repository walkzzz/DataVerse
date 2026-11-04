///|
///===
/// extcore/stats_dist_f
pub(all) struct StatsdistfPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_dist_f_make_point(x : Double, y : Double) -> StatsdistfPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_dist_f_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatsdistfPoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatsdistfPoint::x(self : StatsdistfPoint) -> Double {
  self.x
}

///|
pub fn StatsdistfPoint::y(self : StatsdistfPoint) -> Double {
  self.y
}

///|
pub fn StatsdistfPoint::z(self : StatsdistfPoint) -> Double {
  self.z
}

///|
pub fn StatsdistfPoint::label(self : StatsdistfPoint) -> Int32 {
  self.label
}

///|
pub fn StatsdistfPoint::dist(
  self : StatsdistfPoint,
  other : StatsdistfPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatsdistfPoint::add(
  self : StatsdistfPoint,
  other : StatsdistfPoint,
) -> StatsdistfPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatsdistfPoint::sub(
  self : StatsdistfPoint,
  other : StatsdistfPoint,
) -> StatsdistfPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatsdistfPoint::scale(
  self : StatsdistfPoint,
  s : Double,
) -> StatsdistfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatsdistfPoint::dot(
  self : StatsdistfPoint,
  other : StatsdistfPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatsdistfPoint::cross(
  self : StatsdistfPoint,
  other : StatsdistfPoint,
) -> StatsdistfPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatsdistfPoint::norm(self : StatsdistfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatsdistfPoint::normalize(self : StatsdistfPoint) -> StatsdistfPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdistfPoint::negate(self : StatsdistfPoint) -> StatsdistfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatsdistfPoint::mid(
  self : StatsdistfPoint,
  other : StatsdistfPoint,
) -> StatsdistfPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatsdistfPoint::lerp(
  self : StatsdistfPoint,
  other : StatsdistfPoint,
  t : Double,
) -> StatsdistfPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatsdistfPoint::to_string(self : StatsdistfPoint) -> String {
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
pub(all) struct StatsdistfSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_dist_f_make_series(
  vals : Array[Double],
  name : String,
) -> StatsdistfSeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatsdistfSeries::len(self : StatsdistfSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn StatsdistfSeries::sum(self : StatsdistfSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatsdistfSeries::mean(self : StatsdistfSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatsdistfSeries::min(self : StatsdistfSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatsdistfSeries::max(self : StatsdistfSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatsdistfSeries::range(self : StatsdistfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatsdistfSeries::variance(self : StatsdistfSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatsdistfSeries::std(self : StatsdistfSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatsdistfSeries::median(self : StatsdistfSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatsdistfSeries::scale(
  self : StatsdistfSeries,
  f : Double,
) -> StatsdistfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatsdistfSeries::add(
  self : StatsdistfSeries,
  other : StatsdistfSeries,
) -> StatsdistfSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdistfSeries::sub(
  self : StatsdistfSeries,
  other : StatsdistfSeries,
) -> StatsdistfSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdistfSeries::normalize(self : StatsdistfSeries) -> StatsdistfSeries {
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
pub fn StatsdistfSeries::cumsum(self : StatsdistfSeries) -> StatsdistfSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatsdistfSeries::to_string(self : StatsdistfSeries) -> String {
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
pub(all) struct StatsdistfMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_dist_f_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatsdistfMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_dist_f_matrix_identity(n : Int32) -> StatsdistfMatrix {
  let m = stats_dist_f_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatsdistfMatrix::get(
  self : StatsdistfMatrix,
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
pub fn StatsdistfMatrix::transpose(self : StatsdistfMatrix) -> StatsdistfMatrix {
  let result = stats_dist_f_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdistfMatrix::add(
  self : StatsdistfMatrix,
  other : StatsdistfMatrix,
) -> StatsdistfMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_dist_f_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdistfMatrix::scale(
  self : StatsdistfMatrix,
  s : Double,
) -> StatsdistfMatrix {
  let result = stats_dist_f_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatsdistfMatrix::multiply(
  self : StatsdistfMatrix,
  other : StatsdistfMatrix,
) -> StatsdistfMatrix {
  if self.cols != other.rows {
    return stats_dist_f_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_dist_f_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatsdistfMatrix::trace(self : StatsdistfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatsdistfMatrix::det(self : StatsdistfMatrix) -> Double {
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
pub fn StatsdistfMatrix::norm(self : StatsdistfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn StatsdistfMatrix::to_string(self : StatsdistfMatrix) -> String {
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
pub(all) struct StatsdistfVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_dist_f_make_vector(comps : Array[Double]) -> StatsdistfVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_dist_f_vector_zero(dim : Int32) -> StatsdistfVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatsdistfVector::add(
  self : StatsdistfVector,
  other : StatsdistfVector,
) -> StatsdistfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdistfVector::sub(
  self : StatsdistfVector,
  other : StatsdistfVector,
) -> StatsdistfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdistfVector::scale(
  self : StatsdistfVector,
  s : Double,
) -> StatsdistfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatsdistfVector::dot(
  self : StatsdistfVector,
  other : StatsdistfVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatsdistfVector::norm(self : StatsdistfVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatsdistfVector::normalize(self : StatsdistfVector) -> StatsdistfVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdistfVector::dist(
  self : StatsdistfVector,
  other : StatsdistfVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatsdistfVector::to_string(self : StatsdistfVector) -> String {
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
pub(all) struct StatsdistfFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_frame_make(size : Int32) -> StatsdistfFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfFrame::len(self : StatsdistfFrame) -> Int32 {
  self.size
}

///|
pub fn StatsdistfFrame::get(self : StatsdistfFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfFrame::set(
  self : StatsdistfFrame,
  i : Int32,
  v : Double,
) -> StatsdistfFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfFrame::sum(self : StatsdistfFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfFrame::mean(self : StatsdistfFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfFrame::scale(
  self : StatsdistfFrame,
  f : Double,
) -> StatsdistfFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfFrame::add(
  self : StatsdistfFrame,
  other : StatsdistfFrame,
) -> StatsdistfFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfFrame::copy(self : StatsdistfFrame) -> StatsdistfFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfFrame::fill(
  self : StatsdistfFrame,
  v : Double,
) -> StatsdistfFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfFrame::min(self : StatsdistfFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfFrame::max(self : StatsdistfFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfFrame::to_string(self : StatsdistfFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_table_make(size : Int32) -> StatsdistfTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfTable::len(self : StatsdistfTable) -> Int32 {
  self.size
}

///|
pub fn StatsdistfTable::get(self : StatsdistfTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfTable::set(
  self : StatsdistfTable,
  i : Int32,
  v : Double,
) -> StatsdistfTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfTable::sum(self : StatsdistfTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfTable::mean(self : StatsdistfTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfTable::scale(
  self : StatsdistfTable,
  f : Double,
) -> StatsdistfTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfTable::add(
  self : StatsdistfTable,
  other : StatsdistfTable,
) -> StatsdistfTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfTable::copy(self : StatsdistfTable) -> StatsdistfTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfTable::fill(
  self : StatsdistfTable,
  v : Double,
) -> StatsdistfTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfTable::min(self : StatsdistfTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfTable::max(self : StatsdistfTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfTable::to_string(self : StatsdistfTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_graphn_make(size : Int32) -> StatsdistfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfGraphN::len(self : StatsdistfGraphN) -> Int32 {
  self.size
}

///|
pub fn StatsdistfGraphN::get(self : StatsdistfGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfGraphN::set(
  self : StatsdistfGraphN,
  i : Int32,
  v : Double,
) -> StatsdistfGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfGraphN::sum(self : StatsdistfGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfGraphN::mean(self : StatsdistfGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfGraphN::scale(
  self : StatsdistfGraphN,
  f : Double,
) -> StatsdistfGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfGraphN::add(
  self : StatsdistfGraphN,
  other : StatsdistfGraphN,
) -> StatsdistfGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfGraphN::copy(self : StatsdistfGraphN) -> StatsdistfGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfGraphN::fill(
  self : StatsdistfGraphN,
  v : Double,
) -> StatsdistfGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfGraphN::min(self : StatsdistfGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfGraphN::max(self : StatsdistfGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfGraphN::to_string(self : StatsdistfGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_node_make(size : Int32) -> StatsdistfNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfNode::len(self : StatsdistfNode) -> Int32 {
  self.size
}

///|
pub fn StatsdistfNode::get(self : StatsdistfNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfNode::set(
  self : StatsdistfNode,
  i : Int32,
  v : Double,
) -> StatsdistfNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfNode::sum(self : StatsdistfNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfNode::mean(self : StatsdistfNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfNode::scale(
  self : StatsdistfNode,
  f : Double,
) -> StatsdistfNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfNode::add(
  self : StatsdistfNode,
  other : StatsdistfNode,
) -> StatsdistfNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfNode::copy(self : StatsdistfNode) -> StatsdistfNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfNode::fill(
  self : StatsdistfNode,
  v : Double,
) -> StatsdistfNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfNode::min(self : StatsdistfNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfNode::max(self : StatsdistfNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfNode::to_string(self : StatsdistfNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_edge_make(size : Int32) -> StatsdistfEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfEdge::len(self : StatsdistfEdge) -> Int32 {
  self.size
}

///|
pub fn StatsdistfEdge::get(self : StatsdistfEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfEdge::set(
  self : StatsdistfEdge,
  i : Int32,
  v : Double,
) -> StatsdistfEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfEdge::sum(self : StatsdistfEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfEdge::mean(self : StatsdistfEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfEdge::scale(
  self : StatsdistfEdge,
  f : Double,
) -> StatsdistfEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfEdge::add(
  self : StatsdistfEdge,
  other : StatsdistfEdge,
) -> StatsdistfEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfEdge::copy(self : StatsdistfEdge) -> StatsdistfEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfEdge::fill(
  self : StatsdistfEdge,
  v : Double,
) -> StatsdistfEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfEdge::min(self : StatsdistfEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfEdge::max(self : StatsdistfEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfEdge::to_string(self : StatsdistfEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_path_make(size : Int32) -> StatsdistfPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfPath::len(self : StatsdistfPath) -> Int32 {
  self.size
}

///|
pub fn StatsdistfPath::get(self : StatsdistfPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfPath::set(
  self : StatsdistfPath,
  i : Int32,
  v : Double,
) -> StatsdistfPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfPath::sum(self : StatsdistfPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfPath::mean(self : StatsdistfPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfPath::scale(
  self : StatsdistfPath,
  f : Double,
) -> StatsdistfPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfPath::add(
  self : StatsdistfPath,
  other : StatsdistfPath,
) -> StatsdistfPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfPath::copy(self : StatsdistfPath) -> StatsdistfPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfPath::fill(
  self : StatsdistfPath,
  v : Double,
) -> StatsdistfPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfPath::min(self : StatsdistfPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfPath::max(self : StatsdistfPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfPath::to_string(self : StatsdistfPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_cluster_make(size : Int32) -> StatsdistfCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfCluster::len(self : StatsdistfCluster) -> Int32 {
  self.size
}

///|
pub fn StatsdistfCluster::get(self : StatsdistfCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfCluster::set(
  self : StatsdistfCluster,
  i : Int32,
  v : Double,
) -> StatsdistfCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfCluster::sum(self : StatsdistfCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfCluster::mean(self : StatsdistfCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfCluster::scale(
  self : StatsdistfCluster,
  f : Double,
) -> StatsdistfCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfCluster::add(
  self : StatsdistfCluster,
  other : StatsdistfCluster,
) -> StatsdistfCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfCluster::copy(self : StatsdistfCluster) -> StatsdistfCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfCluster::fill(
  self : StatsdistfCluster,
  v : Double,
) -> StatsdistfCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfCluster::min(self : StatsdistfCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfCluster::max(self : StatsdistfCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfCluster::to_string(self : StatsdistfCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_model_make(size : Int32) -> StatsdistfModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfModel::len(self : StatsdistfModel) -> Int32 {
  self.size
}

///|
pub fn StatsdistfModel::get(self : StatsdistfModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfModel::set(
  self : StatsdistfModel,
  i : Int32,
  v : Double,
) -> StatsdistfModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfModel::sum(self : StatsdistfModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfModel::mean(self : StatsdistfModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfModel::scale(
  self : StatsdistfModel,
  f : Double,
) -> StatsdistfModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfModel::add(
  self : StatsdistfModel,
  other : StatsdistfModel,
) -> StatsdistfModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfModel::copy(self : StatsdistfModel) -> StatsdistfModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfModel::fill(
  self : StatsdistfModel,
  v : Double,
) -> StatsdistfModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfModel::min(self : StatsdistfModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfModel::max(self : StatsdistfModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfModel::to_string(self : StatsdistfModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_layer_make(size : Int32) -> StatsdistfLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfLayer::len(self : StatsdistfLayer) -> Int32 {
  self.size
}

///|
pub fn StatsdistfLayer::get(self : StatsdistfLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfLayer::set(
  self : StatsdistfLayer,
  i : Int32,
  v : Double,
) -> StatsdistfLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfLayer::sum(self : StatsdistfLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfLayer::mean(self : StatsdistfLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfLayer::scale(
  self : StatsdistfLayer,
  f : Double,
) -> StatsdistfLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfLayer::add(
  self : StatsdistfLayer,
  other : StatsdistfLayer,
) -> StatsdistfLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfLayer::copy(self : StatsdistfLayer) -> StatsdistfLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfLayer::fill(
  self : StatsdistfLayer,
  v : Double,
) -> StatsdistfLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfLayer::min(self : StatsdistfLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfLayer::max(self : StatsdistfLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfLayer::to_string(self : StatsdistfLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_buffer_make(size : Int32) -> StatsdistfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfBuffer::len(self : StatsdistfBuffer) -> Int32 {
  self.size
}

///|
pub fn StatsdistfBuffer::get(self : StatsdistfBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfBuffer::set(
  self : StatsdistfBuffer,
  i : Int32,
  v : Double,
) -> StatsdistfBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfBuffer::sum(self : StatsdistfBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfBuffer::mean(self : StatsdistfBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfBuffer::scale(
  self : StatsdistfBuffer,
  f : Double,
) -> StatsdistfBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfBuffer::add(
  self : StatsdistfBuffer,
  other : StatsdistfBuffer,
) -> StatsdistfBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfBuffer::copy(self : StatsdistfBuffer) -> StatsdistfBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfBuffer::fill(
  self : StatsdistfBuffer,
  v : Double,
) -> StatsdistfBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfBuffer::min(self : StatsdistfBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfBuffer::max(self : StatsdistfBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfBuffer::to_string(self : StatsdistfBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_cursor_make(size : Int32) -> StatsdistfCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfCursor::len(self : StatsdistfCursor) -> Int32 {
  self.size
}

///|
pub fn StatsdistfCursor::get(self : StatsdistfCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfCursor::set(
  self : StatsdistfCursor,
  i : Int32,
  v : Double,
) -> StatsdistfCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfCursor::sum(self : StatsdistfCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfCursor::mean(self : StatsdistfCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfCursor::scale(
  self : StatsdistfCursor,
  f : Double,
) -> StatsdistfCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfCursor::add(
  self : StatsdistfCursor,
  other : StatsdistfCursor,
) -> StatsdistfCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfCursor::copy(self : StatsdistfCursor) -> StatsdistfCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfCursor::fill(
  self : StatsdistfCursor,
  v : Double,
) -> StatsdistfCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfCursor::min(self : StatsdistfCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfCursor::max(self : StatsdistfCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfCursor::to_string(self : StatsdistfCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_view_make(size : Int32) -> StatsdistfView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfView::len(self : StatsdistfView) -> Int32 {
  self.size
}

///|
pub fn StatsdistfView::get(self : StatsdistfView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfView::set(
  self : StatsdistfView,
  i : Int32,
  v : Double,
) -> StatsdistfView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfView::sum(self : StatsdistfView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfView::mean(self : StatsdistfView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfView::scale(
  self : StatsdistfView,
  f : Double,
) -> StatsdistfView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfView::add(
  self : StatsdistfView,
  other : StatsdistfView,
) -> StatsdistfView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfView::copy(self : StatsdistfView) -> StatsdistfView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfView::fill(
  self : StatsdistfView,
  v : Double,
) -> StatsdistfView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfView::min(self : StatsdistfView) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfView::max(self : StatsdistfView) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfView::to_string(self : StatsdistfView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_range_make(size : Int32) -> StatsdistfRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfRange::len(self : StatsdistfRange) -> Int32 {
  self.size
}

///|
pub fn StatsdistfRange::get(self : StatsdistfRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfRange::set(
  self : StatsdistfRange,
  i : Int32,
  v : Double,
) -> StatsdistfRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfRange::sum(self : StatsdistfRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfRange::mean(self : StatsdistfRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfRange::scale(
  self : StatsdistfRange,
  f : Double,
) -> StatsdistfRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfRange::add(
  self : StatsdistfRange,
  other : StatsdistfRange,
) -> StatsdistfRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfRange::copy(self : StatsdistfRange) -> StatsdistfRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfRange::fill(
  self : StatsdistfRange,
  v : Double,
) -> StatsdistfRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfRange::min(self : StatsdistfRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfRange::max(self : StatsdistfRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfRange::to_string(self : StatsdistfRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistfSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_f_slice_make(size : Int32) -> StatsdistfSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistfSlice::len(self : StatsdistfSlice) -> Int32 {
  self.size
}

///|
pub fn StatsdistfSlice::get(self : StatsdistfSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistfSlice::set(
  self : StatsdistfSlice,
  i : Int32,
  v : Double,
) -> StatsdistfSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfSlice::sum(self : StatsdistfSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistfSlice::mean(self : StatsdistfSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistfSlice::scale(
  self : StatsdistfSlice,
  f : Double,
) -> StatsdistfSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfSlice::add(
  self : StatsdistfSlice,
  other : StatsdistfSlice,
) -> StatsdistfSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistfSlice::copy(self : StatsdistfSlice) -> StatsdistfSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfSlice::fill(
  self : StatsdistfSlice,
  v : Double,
) -> StatsdistfSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistfSlice::min(self : StatsdistfSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistfSlice::max(self : StatsdistfSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistfSlice::to_string(self : StatsdistfSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
