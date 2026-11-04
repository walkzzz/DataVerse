///|
///===
/// extcore/stats_model_glm
pub(all) struct StatsmodelglmPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_model_glm_make_point(x : Double, y : Double) -> StatsmodelglmPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_model_glm_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatsmodelglmPoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatsmodelglmPoint::x(self : StatsmodelglmPoint) -> Double {
  self.x
}

///|
pub fn StatsmodelglmPoint::y(self : StatsmodelglmPoint) -> Double {
  self.y
}

///|
pub fn StatsmodelglmPoint::z(self : StatsmodelglmPoint) -> Double {
  self.z
}

///|
pub fn StatsmodelglmPoint::label(self : StatsmodelglmPoint) -> Int32 {
  self.label
}

///|
pub fn StatsmodelglmPoint::dist(
  self : StatsmodelglmPoint,
  other : StatsmodelglmPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatsmodelglmPoint::add(
  self : StatsmodelglmPoint,
  other : StatsmodelglmPoint,
) -> StatsmodelglmPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatsmodelglmPoint::sub(
  self : StatsmodelglmPoint,
  other : StatsmodelglmPoint,
) -> StatsmodelglmPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatsmodelglmPoint::scale(
  self : StatsmodelglmPoint,
  s : Double,
) -> StatsmodelglmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatsmodelglmPoint::dot(
  self : StatsmodelglmPoint,
  other : StatsmodelglmPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatsmodelglmPoint::cross(
  self : StatsmodelglmPoint,
  other : StatsmodelglmPoint,
) -> StatsmodelglmPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatsmodelglmPoint::norm(self : StatsmodelglmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatsmodelglmPoint::normalize(
  self : StatsmodelglmPoint,
) -> StatsmodelglmPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsmodelglmPoint::negate(
  self : StatsmodelglmPoint,
) -> StatsmodelglmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatsmodelglmPoint::mid(
  self : StatsmodelglmPoint,
  other : StatsmodelglmPoint,
) -> StatsmodelglmPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatsmodelglmPoint::lerp(
  self : StatsmodelglmPoint,
  other : StatsmodelglmPoint,
  t : Double,
) -> StatsmodelglmPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatsmodelglmPoint::to_string(self : StatsmodelglmPoint) -> String {
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
pub(all) struct StatsmodelglmSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_model_glm_make_series(
  vals : Array[Double],
  name : String,
) -> StatsmodelglmSeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatsmodelglmSeries::len(self : StatsmodelglmSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn StatsmodelglmSeries::sum(self : StatsmodelglmSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatsmodelglmSeries::mean(self : StatsmodelglmSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatsmodelglmSeries::min(self : StatsmodelglmSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatsmodelglmSeries::max(self : StatsmodelglmSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatsmodelglmSeries::range(self : StatsmodelglmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatsmodelglmSeries::variance(self : StatsmodelglmSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatsmodelglmSeries::std(self : StatsmodelglmSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatsmodelglmSeries::median(self : StatsmodelglmSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatsmodelglmSeries::scale(
  self : StatsmodelglmSeries,
  f : Double,
) -> StatsmodelglmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatsmodelglmSeries::add(
  self : StatsmodelglmSeries,
  other : StatsmodelglmSeries,
) -> StatsmodelglmSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsmodelglmSeries::sub(
  self : StatsmodelglmSeries,
  other : StatsmodelglmSeries,
) -> StatsmodelglmSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsmodelglmSeries::normalize(
  self : StatsmodelglmSeries,
) -> StatsmodelglmSeries {
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
pub fn StatsmodelglmSeries::cumsum(
  self : StatsmodelglmSeries,
) -> StatsmodelglmSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatsmodelglmSeries::to_string(self : StatsmodelglmSeries) -> String {
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
pub(all) struct StatsmodelglmMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_model_glm_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatsmodelglmMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_model_glm_matrix_identity(n : Int32) -> StatsmodelglmMatrix {
  let m = stats_model_glm_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatsmodelglmMatrix::get(
  self : StatsmodelglmMatrix,
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
pub fn StatsmodelglmMatrix::transpose(
  self : StatsmodelglmMatrix,
) -> StatsmodelglmMatrix {
  let result = stats_model_glm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatsmodelglmMatrix::add(
  self : StatsmodelglmMatrix,
  other : StatsmodelglmMatrix,
) -> StatsmodelglmMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_model_glm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatsmodelglmMatrix::scale(
  self : StatsmodelglmMatrix,
  s : Double,
) -> StatsmodelglmMatrix {
  let result = stats_model_glm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatsmodelglmMatrix::multiply(
  self : StatsmodelglmMatrix,
  other : StatsmodelglmMatrix,
) -> StatsmodelglmMatrix {
  if self.cols != other.rows {
    return stats_model_glm_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_model_glm_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatsmodelglmMatrix::trace(self : StatsmodelglmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatsmodelglmMatrix::det(self : StatsmodelglmMatrix) -> Double {
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
pub fn StatsmodelglmMatrix::norm(self : StatsmodelglmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn StatsmodelglmMatrix::to_string(self : StatsmodelglmMatrix) -> String {
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
pub(all) struct StatsmodelglmVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_model_glm_make_vector(
  comps : Array[Double],
) -> StatsmodelglmVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_model_glm_vector_zero(dim : Int32) -> StatsmodelglmVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatsmodelglmVector::add(
  self : StatsmodelglmVector,
  other : StatsmodelglmVector,
) -> StatsmodelglmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsmodelglmVector::sub(
  self : StatsmodelglmVector,
  other : StatsmodelglmVector,
) -> StatsmodelglmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsmodelglmVector::scale(
  self : StatsmodelglmVector,
  s : Double,
) -> StatsmodelglmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatsmodelglmVector::dot(
  self : StatsmodelglmVector,
  other : StatsmodelglmVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatsmodelglmVector::norm(self : StatsmodelglmVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatsmodelglmVector::normalize(
  self : StatsmodelglmVector,
) -> StatsmodelglmVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsmodelglmVector::dist(
  self : StatsmodelglmVector,
  other : StatsmodelglmVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatsmodelglmVector::to_string(self : StatsmodelglmVector) -> String {
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
pub(all) struct StatsmodelglmFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_frame_make(size : Int32) -> StatsmodelglmFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmFrame::len(self : StatsmodelglmFrame) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmFrame::get(self : StatsmodelglmFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmFrame::set(
  self : StatsmodelglmFrame,
  i : Int32,
  v : Double,
) -> StatsmodelglmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmFrame::sum(self : StatsmodelglmFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmFrame::mean(self : StatsmodelglmFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmFrame::scale(
  self : StatsmodelglmFrame,
  f : Double,
) -> StatsmodelglmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmFrame::add(
  self : StatsmodelglmFrame,
  other : StatsmodelglmFrame,
) -> StatsmodelglmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmFrame::copy(
  self : StatsmodelglmFrame,
) -> StatsmodelglmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmFrame::fill(
  self : StatsmodelglmFrame,
  v : Double,
) -> StatsmodelglmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmFrame::min(self : StatsmodelglmFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmFrame::max(self : StatsmodelglmFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmFrame::to_string(self : StatsmodelglmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_table_make(size : Int32) -> StatsmodelglmTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmTable::len(self : StatsmodelglmTable) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmTable::get(self : StatsmodelglmTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmTable::set(
  self : StatsmodelglmTable,
  i : Int32,
  v : Double,
) -> StatsmodelglmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmTable::sum(self : StatsmodelglmTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmTable::mean(self : StatsmodelglmTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmTable::scale(
  self : StatsmodelglmTable,
  f : Double,
) -> StatsmodelglmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmTable::add(
  self : StatsmodelglmTable,
  other : StatsmodelglmTable,
) -> StatsmodelglmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmTable::copy(
  self : StatsmodelglmTable,
) -> StatsmodelglmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmTable::fill(
  self : StatsmodelglmTable,
  v : Double,
) -> StatsmodelglmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmTable::min(self : StatsmodelglmTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmTable::max(self : StatsmodelglmTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmTable::to_string(self : StatsmodelglmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_graphn_make(size : Int32) -> StatsmodelglmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmGraphN::len(self : StatsmodelglmGraphN) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmGraphN::get(
  self : StatsmodelglmGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmGraphN::set(
  self : StatsmodelglmGraphN,
  i : Int32,
  v : Double,
) -> StatsmodelglmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmGraphN::sum(self : StatsmodelglmGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmGraphN::mean(self : StatsmodelglmGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmGraphN::scale(
  self : StatsmodelglmGraphN,
  f : Double,
) -> StatsmodelglmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmGraphN::add(
  self : StatsmodelglmGraphN,
  other : StatsmodelglmGraphN,
) -> StatsmodelglmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmGraphN::copy(
  self : StatsmodelglmGraphN,
) -> StatsmodelglmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmGraphN::fill(
  self : StatsmodelglmGraphN,
  v : Double,
) -> StatsmodelglmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmGraphN::min(self : StatsmodelglmGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmGraphN::max(self : StatsmodelglmGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmGraphN::to_string(self : StatsmodelglmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_node_make(size : Int32) -> StatsmodelglmNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmNode::len(self : StatsmodelglmNode) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmNode::get(self : StatsmodelglmNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmNode::set(
  self : StatsmodelglmNode,
  i : Int32,
  v : Double,
) -> StatsmodelglmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmNode::sum(self : StatsmodelglmNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmNode::mean(self : StatsmodelglmNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmNode::scale(
  self : StatsmodelglmNode,
  f : Double,
) -> StatsmodelglmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmNode::add(
  self : StatsmodelglmNode,
  other : StatsmodelglmNode,
) -> StatsmodelglmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmNode::copy(self : StatsmodelglmNode) -> StatsmodelglmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmNode::fill(
  self : StatsmodelglmNode,
  v : Double,
) -> StatsmodelglmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmNode::min(self : StatsmodelglmNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmNode::max(self : StatsmodelglmNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmNode::to_string(self : StatsmodelglmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_edge_make(size : Int32) -> StatsmodelglmEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmEdge::len(self : StatsmodelglmEdge) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmEdge::get(self : StatsmodelglmEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmEdge::set(
  self : StatsmodelglmEdge,
  i : Int32,
  v : Double,
) -> StatsmodelglmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmEdge::sum(self : StatsmodelglmEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmEdge::mean(self : StatsmodelglmEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmEdge::scale(
  self : StatsmodelglmEdge,
  f : Double,
) -> StatsmodelglmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmEdge::add(
  self : StatsmodelglmEdge,
  other : StatsmodelglmEdge,
) -> StatsmodelglmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmEdge::copy(self : StatsmodelglmEdge) -> StatsmodelglmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmEdge::fill(
  self : StatsmodelglmEdge,
  v : Double,
) -> StatsmodelglmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmEdge::min(self : StatsmodelglmEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmEdge::max(self : StatsmodelglmEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmEdge::to_string(self : StatsmodelglmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_path_make(size : Int32) -> StatsmodelglmPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmPath::len(self : StatsmodelglmPath) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmPath::get(self : StatsmodelglmPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmPath::set(
  self : StatsmodelglmPath,
  i : Int32,
  v : Double,
) -> StatsmodelglmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmPath::sum(self : StatsmodelglmPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmPath::mean(self : StatsmodelglmPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmPath::scale(
  self : StatsmodelglmPath,
  f : Double,
) -> StatsmodelglmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmPath::add(
  self : StatsmodelglmPath,
  other : StatsmodelglmPath,
) -> StatsmodelglmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmPath::copy(self : StatsmodelglmPath) -> StatsmodelglmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmPath::fill(
  self : StatsmodelglmPath,
  v : Double,
) -> StatsmodelglmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmPath::min(self : StatsmodelglmPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmPath::max(self : StatsmodelglmPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmPath::to_string(self : StatsmodelglmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_cluster_make(size : Int32) -> StatsmodelglmCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmCluster::len(self : StatsmodelglmCluster) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmCluster::get(
  self : StatsmodelglmCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmCluster::set(
  self : StatsmodelglmCluster,
  i : Int32,
  v : Double,
) -> StatsmodelglmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmCluster::sum(self : StatsmodelglmCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmCluster::mean(self : StatsmodelglmCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmCluster::scale(
  self : StatsmodelglmCluster,
  f : Double,
) -> StatsmodelglmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmCluster::add(
  self : StatsmodelglmCluster,
  other : StatsmodelglmCluster,
) -> StatsmodelglmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmCluster::copy(
  self : StatsmodelglmCluster,
) -> StatsmodelglmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmCluster::fill(
  self : StatsmodelglmCluster,
  v : Double,
) -> StatsmodelglmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmCluster::min(self : StatsmodelglmCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmCluster::max(self : StatsmodelglmCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmCluster::to_string(self : StatsmodelglmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_model_make(size : Int32) -> StatsmodelglmModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmModel::len(self : StatsmodelglmModel) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmModel::get(self : StatsmodelglmModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmModel::set(
  self : StatsmodelglmModel,
  i : Int32,
  v : Double,
) -> StatsmodelglmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmModel::sum(self : StatsmodelglmModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmModel::mean(self : StatsmodelglmModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmModel::scale(
  self : StatsmodelglmModel,
  f : Double,
) -> StatsmodelglmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmModel::add(
  self : StatsmodelglmModel,
  other : StatsmodelglmModel,
) -> StatsmodelglmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmModel::copy(
  self : StatsmodelglmModel,
) -> StatsmodelglmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmModel::fill(
  self : StatsmodelglmModel,
  v : Double,
) -> StatsmodelglmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmModel::min(self : StatsmodelglmModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmModel::max(self : StatsmodelglmModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmModel::to_string(self : StatsmodelglmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_layer_make(size : Int32) -> StatsmodelglmLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmLayer::len(self : StatsmodelglmLayer) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmLayer::get(self : StatsmodelglmLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmLayer::set(
  self : StatsmodelglmLayer,
  i : Int32,
  v : Double,
) -> StatsmodelglmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmLayer::sum(self : StatsmodelglmLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmLayer::mean(self : StatsmodelglmLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmLayer::scale(
  self : StatsmodelglmLayer,
  f : Double,
) -> StatsmodelglmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmLayer::add(
  self : StatsmodelglmLayer,
  other : StatsmodelglmLayer,
) -> StatsmodelglmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmLayer::copy(
  self : StatsmodelglmLayer,
) -> StatsmodelglmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmLayer::fill(
  self : StatsmodelglmLayer,
  v : Double,
) -> StatsmodelglmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmLayer::min(self : StatsmodelglmLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmLayer::max(self : StatsmodelglmLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmLayer::to_string(self : StatsmodelglmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_buffer_make(size : Int32) -> StatsmodelglmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmBuffer::len(self : StatsmodelglmBuffer) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmBuffer::get(
  self : StatsmodelglmBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmBuffer::set(
  self : StatsmodelglmBuffer,
  i : Int32,
  v : Double,
) -> StatsmodelglmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmBuffer::sum(self : StatsmodelglmBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmBuffer::mean(self : StatsmodelglmBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmBuffer::scale(
  self : StatsmodelglmBuffer,
  f : Double,
) -> StatsmodelglmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmBuffer::add(
  self : StatsmodelglmBuffer,
  other : StatsmodelglmBuffer,
) -> StatsmodelglmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmBuffer::copy(
  self : StatsmodelglmBuffer,
) -> StatsmodelglmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmBuffer::fill(
  self : StatsmodelglmBuffer,
  v : Double,
) -> StatsmodelglmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmBuffer::min(self : StatsmodelglmBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmBuffer::max(self : StatsmodelglmBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmBuffer::to_string(self : StatsmodelglmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_cursor_make(size : Int32) -> StatsmodelglmCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmCursor::len(self : StatsmodelglmCursor) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmCursor::get(
  self : StatsmodelglmCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmCursor::set(
  self : StatsmodelglmCursor,
  i : Int32,
  v : Double,
) -> StatsmodelglmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmCursor::sum(self : StatsmodelglmCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmCursor::mean(self : StatsmodelglmCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmCursor::scale(
  self : StatsmodelglmCursor,
  f : Double,
) -> StatsmodelglmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmCursor::add(
  self : StatsmodelglmCursor,
  other : StatsmodelglmCursor,
) -> StatsmodelglmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmCursor::copy(
  self : StatsmodelglmCursor,
) -> StatsmodelglmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmCursor::fill(
  self : StatsmodelglmCursor,
  v : Double,
) -> StatsmodelglmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmCursor::min(self : StatsmodelglmCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmCursor::max(self : StatsmodelglmCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmCursor::to_string(self : StatsmodelglmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_view_make(size : Int32) -> StatsmodelglmView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmView::len(self : StatsmodelglmView) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmView::get(self : StatsmodelglmView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmView::set(
  self : StatsmodelglmView,
  i : Int32,
  v : Double,
) -> StatsmodelglmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmView::sum(self : StatsmodelglmView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmView::mean(self : StatsmodelglmView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmView::scale(
  self : StatsmodelglmView,
  f : Double,
) -> StatsmodelglmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmView::add(
  self : StatsmodelglmView,
  other : StatsmodelglmView,
) -> StatsmodelglmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmView::copy(self : StatsmodelglmView) -> StatsmodelglmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmView::fill(
  self : StatsmodelglmView,
  v : Double,
) -> StatsmodelglmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmView::min(self : StatsmodelglmView) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmView::max(self : StatsmodelglmView) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmView::to_string(self : StatsmodelglmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_range_make(size : Int32) -> StatsmodelglmRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmRange::len(self : StatsmodelglmRange) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmRange::get(self : StatsmodelglmRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmRange::set(
  self : StatsmodelglmRange,
  i : Int32,
  v : Double,
) -> StatsmodelglmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmRange::sum(self : StatsmodelglmRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmRange::mean(self : StatsmodelglmRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmRange::scale(
  self : StatsmodelglmRange,
  f : Double,
) -> StatsmodelglmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmRange::add(
  self : StatsmodelglmRange,
  other : StatsmodelglmRange,
) -> StatsmodelglmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmRange::copy(
  self : StatsmodelglmRange,
) -> StatsmodelglmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmRange::fill(
  self : StatsmodelglmRange,
  v : Double,
) -> StatsmodelglmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmRange::min(self : StatsmodelglmRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmRange::max(self : StatsmodelglmRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmRange::to_string(self : StatsmodelglmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodelglmSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_glm_slice_make(size : Int32) -> StatsmodelglmSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodelglmSlice::len(self : StatsmodelglmSlice) -> Int32 {
  self.size
}

///|
pub fn StatsmodelglmSlice::get(self : StatsmodelglmSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodelglmSlice::set(
  self : StatsmodelglmSlice,
  i : Int32,
  v : Double,
) -> StatsmodelglmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmSlice::sum(self : StatsmodelglmSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodelglmSlice::mean(self : StatsmodelglmSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodelglmSlice::scale(
  self : StatsmodelglmSlice,
  f : Double,
) -> StatsmodelglmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmSlice::add(
  self : StatsmodelglmSlice,
  other : StatsmodelglmSlice,
) -> StatsmodelglmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodelglmSlice::copy(
  self : StatsmodelglmSlice,
) -> StatsmodelglmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmSlice::fill(
  self : StatsmodelglmSlice,
  v : Double,
) -> StatsmodelglmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodelglmSlice::min(self : StatsmodelglmSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodelglmSlice::max(self : StatsmodelglmSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodelglmSlice::to_string(self : StatsmodelglmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
