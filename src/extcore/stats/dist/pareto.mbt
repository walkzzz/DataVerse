///|
///===
/// extcore/stats_dist_pareto
pub(all) struct StatsdistparetoPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_dist_pareto_make_point(
  x : Double,
  y : Double,
) -> StatsdistparetoPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_dist_pareto_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatsdistparetoPoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatsdistparetoPoint::x(self : StatsdistparetoPoint) -> Double {
  self.x
}

///|
pub fn StatsdistparetoPoint::y(self : StatsdistparetoPoint) -> Double {
  self.y
}

///|
pub fn StatsdistparetoPoint::z(self : StatsdistparetoPoint) -> Double {
  self.z
}

///|
pub fn StatsdistparetoPoint::label(self : StatsdistparetoPoint) -> Int32 {
  self.label
}

///|
pub fn StatsdistparetoPoint::dist(
  self : StatsdistparetoPoint,
  other : StatsdistparetoPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatsdistparetoPoint::add(
  self : StatsdistparetoPoint,
  other : StatsdistparetoPoint,
) -> StatsdistparetoPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatsdistparetoPoint::sub(
  self : StatsdistparetoPoint,
  other : StatsdistparetoPoint,
) -> StatsdistparetoPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatsdistparetoPoint::scale(
  self : StatsdistparetoPoint,
  s : Double,
) -> StatsdistparetoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatsdistparetoPoint::dot(
  self : StatsdistparetoPoint,
  other : StatsdistparetoPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatsdistparetoPoint::cross(
  self : StatsdistparetoPoint,
  other : StatsdistparetoPoint,
) -> StatsdistparetoPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatsdistparetoPoint::norm(self : StatsdistparetoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatsdistparetoPoint::normalize(
  self : StatsdistparetoPoint,
) -> StatsdistparetoPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdistparetoPoint::negate(
  self : StatsdistparetoPoint,
) -> StatsdistparetoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatsdistparetoPoint::mid(
  self : StatsdistparetoPoint,
  other : StatsdistparetoPoint,
) -> StatsdistparetoPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatsdistparetoPoint::lerp(
  self : StatsdistparetoPoint,
  other : StatsdistparetoPoint,
  t : Double,
) -> StatsdistparetoPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatsdistparetoPoint::to_string(self : StatsdistparetoPoint) -> String {
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
pub(all) struct StatsdistparetoSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_dist_pareto_make_series(
  vals : Array[Double],
  name : String,
) -> StatsdistparetoSeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatsdistparetoSeries::len(self : StatsdistparetoSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn StatsdistparetoSeries::sum(self : StatsdistparetoSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatsdistparetoSeries::mean(self : StatsdistparetoSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatsdistparetoSeries::min(self : StatsdistparetoSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatsdistparetoSeries::max(self : StatsdistparetoSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatsdistparetoSeries::range(self : StatsdistparetoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatsdistparetoSeries::variance(self : StatsdistparetoSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatsdistparetoSeries::std(self : StatsdistparetoSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatsdistparetoSeries::median(self : StatsdistparetoSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatsdistparetoSeries::scale(
  self : StatsdistparetoSeries,
  f : Double,
) -> StatsdistparetoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatsdistparetoSeries::add(
  self : StatsdistparetoSeries,
  other : StatsdistparetoSeries,
) -> StatsdistparetoSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdistparetoSeries::sub(
  self : StatsdistparetoSeries,
  other : StatsdistparetoSeries,
) -> StatsdistparetoSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdistparetoSeries::normalize(
  self : StatsdistparetoSeries,
) -> StatsdistparetoSeries {
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
pub fn StatsdistparetoSeries::cumsum(
  self : StatsdistparetoSeries,
) -> StatsdistparetoSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatsdistparetoSeries::to_string(self : StatsdistparetoSeries) -> String {
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
pub(all) struct StatsdistparetoMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_dist_pareto_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatsdistparetoMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_dist_pareto_matrix_identity(n : Int32) -> StatsdistparetoMatrix {
  let m = stats_dist_pareto_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatsdistparetoMatrix::get(
  self : StatsdistparetoMatrix,
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
pub fn StatsdistparetoMatrix::transpose(
  self : StatsdistparetoMatrix,
) -> StatsdistparetoMatrix {
  let result = stats_dist_pareto_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdistparetoMatrix::add(
  self : StatsdistparetoMatrix,
  other : StatsdistparetoMatrix,
) -> StatsdistparetoMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_dist_pareto_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdistparetoMatrix::scale(
  self : StatsdistparetoMatrix,
  s : Double,
) -> StatsdistparetoMatrix {
  let result = stats_dist_pareto_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatsdistparetoMatrix::multiply(
  self : StatsdistparetoMatrix,
  other : StatsdistparetoMatrix,
) -> StatsdistparetoMatrix {
  if self.cols != other.rows {
    return stats_dist_pareto_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_dist_pareto_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatsdistparetoMatrix::trace(self : StatsdistparetoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatsdistparetoMatrix::det(self : StatsdistparetoMatrix) -> Double {
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
pub fn StatsdistparetoMatrix::norm(self : StatsdistparetoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn StatsdistparetoMatrix::to_string(self : StatsdistparetoMatrix) -> String {
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
pub(all) struct StatsdistparetoVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_dist_pareto_make_vector(
  comps : Array[Double],
) -> StatsdistparetoVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_dist_pareto_vector_zero(dim : Int32) -> StatsdistparetoVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatsdistparetoVector::add(
  self : StatsdistparetoVector,
  other : StatsdistparetoVector,
) -> StatsdistparetoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdistparetoVector::sub(
  self : StatsdistparetoVector,
  other : StatsdistparetoVector,
) -> StatsdistparetoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdistparetoVector::scale(
  self : StatsdistparetoVector,
  s : Double,
) -> StatsdistparetoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatsdistparetoVector::dot(
  self : StatsdistparetoVector,
  other : StatsdistparetoVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatsdistparetoVector::norm(self : StatsdistparetoVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatsdistparetoVector::normalize(
  self : StatsdistparetoVector,
) -> StatsdistparetoVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdistparetoVector::dist(
  self : StatsdistparetoVector,
  other : StatsdistparetoVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatsdistparetoVector::to_string(self : StatsdistparetoVector) -> String {
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
pub(all) struct StatsdistparetoFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_frame_make(size : Int32) -> StatsdistparetoFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoFrame::len(self : StatsdistparetoFrame) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoFrame::get(
  self : StatsdistparetoFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoFrame::set(
  self : StatsdistparetoFrame,
  i : Int32,
  v : Double,
) -> StatsdistparetoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoFrame::sum(self : StatsdistparetoFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoFrame::mean(self : StatsdistparetoFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoFrame::scale(
  self : StatsdistparetoFrame,
  f : Double,
) -> StatsdistparetoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoFrame::add(
  self : StatsdistparetoFrame,
  other : StatsdistparetoFrame,
) -> StatsdistparetoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoFrame::copy(
  self : StatsdistparetoFrame,
) -> StatsdistparetoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoFrame::fill(
  self : StatsdistparetoFrame,
  v : Double,
) -> StatsdistparetoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoFrame::min(self : StatsdistparetoFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoFrame::max(self : StatsdistparetoFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoFrame::to_string(self : StatsdistparetoFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_table_make(size : Int32) -> StatsdistparetoTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoTable::len(self : StatsdistparetoTable) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoTable::get(
  self : StatsdistparetoTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoTable::set(
  self : StatsdistparetoTable,
  i : Int32,
  v : Double,
) -> StatsdistparetoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoTable::sum(self : StatsdistparetoTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoTable::mean(self : StatsdistparetoTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoTable::scale(
  self : StatsdistparetoTable,
  f : Double,
) -> StatsdistparetoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoTable::add(
  self : StatsdistparetoTable,
  other : StatsdistparetoTable,
) -> StatsdistparetoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoTable::copy(
  self : StatsdistparetoTable,
) -> StatsdistparetoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoTable::fill(
  self : StatsdistparetoTable,
  v : Double,
) -> StatsdistparetoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoTable::min(self : StatsdistparetoTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoTable::max(self : StatsdistparetoTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoTable::to_string(self : StatsdistparetoTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_graphn_make(size : Int32) -> StatsdistparetoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoGraphN::len(self : StatsdistparetoGraphN) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoGraphN::get(
  self : StatsdistparetoGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoGraphN::set(
  self : StatsdistparetoGraphN,
  i : Int32,
  v : Double,
) -> StatsdistparetoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoGraphN::sum(self : StatsdistparetoGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoGraphN::mean(self : StatsdistparetoGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoGraphN::scale(
  self : StatsdistparetoGraphN,
  f : Double,
) -> StatsdistparetoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoGraphN::add(
  self : StatsdistparetoGraphN,
  other : StatsdistparetoGraphN,
) -> StatsdistparetoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoGraphN::copy(
  self : StatsdistparetoGraphN,
) -> StatsdistparetoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoGraphN::fill(
  self : StatsdistparetoGraphN,
  v : Double,
) -> StatsdistparetoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoGraphN::min(self : StatsdistparetoGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoGraphN::max(self : StatsdistparetoGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoGraphN::to_string(self : StatsdistparetoGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_node_make(size : Int32) -> StatsdistparetoNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoNode::len(self : StatsdistparetoNode) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoNode::get(
  self : StatsdistparetoNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoNode::set(
  self : StatsdistparetoNode,
  i : Int32,
  v : Double,
) -> StatsdistparetoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoNode::sum(self : StatsdistparetoNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoNode::mean(self : StatsdistparetoNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoNode::scale(
  self : StatsdistparetoNode,
  f : Double,
) -> StatsdistparetoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoNode::add(
  self : StatsdistparetoNode,
  other : StatsdistparetoNode,
) -> StatsdistparetoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoNode::copy(
  self : StatsdistparetoNode,
) -> StatsdistparetoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoNode::fill(
  self : StatsdistparetoNode,
  v : Double,
) -> StatsdistparetoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoNode::min(self : StatsdistparetoNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoNode::max(self : StatsdistparetoNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoNode::to_string(self : StatsdistparetoNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_edge_make(size : Int32) -> StatsdistparetoEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoEdge::len(self : StatsdistparetoEdge) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoEdge::get(
  self : StatsdistparetoEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoEdge::set(
  self : StatsdistparetoEdge,
  i : Int32,
  v : Double,
) -> StatsdistparetoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoEdge::sum(self : StatsdistparetoEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoEdge::mean(self : StatsdistparetoEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoEdge::scale(
  self : StatsdistparetoEdge,
  f : Double,
) -> StatsdistparetoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoEdge::add(
  self : StatsdistparetoEdge,
  other : StatsdistparetoEdge,
) -> StatsdistparetoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoEdge::copy(
  self : StatsdistparetoEdge,
) -> StatsdistparetoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoEdge::fill(
  self : StatsdistparetoEdge,
  v : Double,
) -> StatsdistparetoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoEdge::min(self : StatsdistparetoEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoEdge::max(self : StatsdistparetoEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoEdge::to_string(self : StatsdistparetoEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_path_make(size : Int32) -> StatsdistparetoPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoPath::len(self : StatsdistparetoPath) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoPath::get(
  self : StatsdistparetoPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoPath::set(
  self : StatsdistparetoPath,
  i : Int32,
  v : Double,
) -> StatsdistparetoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoPath::sum(self : StatsdistparetoPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoPath::mean(self : StatsdistparetoPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoPath::scale(
  self : StatsdistparetoPath,
  f : Double,
) -> StatsdistparetoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoPath::add(
  self : StatsdistparetoPath,
  other : StatsdistparetoPath,
) -> StatsdistparetoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoPath::copy(
  self : StatsdistparetoPath,
) -> StatsdistparetoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoPath::fill(
  self : StatsdistparetoPath,
  v : Double,
) -> StatsdistparetoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoPath::min(self : StatsdistparetoPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoPath::max(self : StatsdistparetoPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoPath::to_string(self : StatsdistparetoPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_cluster_make(size : Int32) -> StatsdistparetoCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoCluster::len(self : StatsdistparetoCluster) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoCluster::get(
  self : StatsdistparetoCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoCluster::set(
  self : StatsdistparetoCluster,
  i : Int32,
  v : Double,
) -> StatsdistparetoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoCluster::sum(self : StatsdistparetoCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoCluster::mean(self : StatsdistparetoCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoCluster::scale(
  self : StatsdistparetoCluster,
  f : Double,
) -> StatsdistparetoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoCluster::add(
  self : StatsdistparetoCluster,
  other : StatsdistparetoCluster,
) -> StatsdistparetoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoCluster::copy(
  self : StatsdistparetoCluster,
) -> StatsdistparetoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoCluster::fill(
  self : StatsdistparetoCluster,
  v : Double,
) -> StatsdistparetoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoCluster::min(self : StatsdistparetoCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoCluster::max(self : StatsdistparetoCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoCluster::to_string(
  self : StatsdistparetoCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_model_make(size : Int32) -> StatsdistparetoModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoModel::len(self : StatsdistparetoModel) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoModel::get(
  self : StatsdistparetoModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoModel::set(
  self : StatsdistparetoModel,
  i : Int32,
  v : Double,
) -> StatsdistparetoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoModel::sum(self : StatsdistparetoModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoModel::mean(self : StatsdistparetoModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoModel::scale(
  self : StatsdistparetoModel,
  f : Double,
) -> StatsdistparetoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoModel::add(
  self : StatsdistparetoModel,
  other : StatsdistparetoModel,
) -> StatsdistparetoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoModel::copy(
  self : StatsdistparetoModel,
) -> StatsdistparetoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoModel::fill(
  self : StatsdistparetoModel,
  v : Double,
) -> StatsdistparetoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoModel::min(self : StatsdistparetoModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoModel::max(self : StatsdistparetoModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoModel::to_string(self : StatsdistparetoModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_layer_make(size : Int32) -> StatsdistparetoLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoLayer::len(self : StatsdistparetoLayer) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoLayer::get(
  self : StatsdistparetoLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoLayer::set(
  self : StatsdistparetoLayer,
  i : Int32,
  v : Double,
) -> StatsdistparetoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoLayer::sum(self : StatsdistparetoLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoLayer::mean(self : StatsdistparetoLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoLayer::scale(
  self : StatsdistparetoLayer,
  f : Double,
) -> StatsdistparetoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoLayer::add(
  self : StatsdistparetoLayer,
  other : StatsdistparetoLayer,
) -> StatsdistparetoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoLayer::copy(
  self : StatsdistparetoLayer,
) -> StatsdistparetoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoLayer::fill(
  self : StatsdistparetoLayer,
  v : Double,
) -> StatsdistparetoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoLayer::min(self : StatsdistparetoLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoLayer::max(self : StatsdistparetoLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoLayer::to_string(self : StatsdistparetoLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_buffer_make(size : Int32) -> StatsdistparetoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoBuffer::len(self : StatsdistparetoBuffer) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoBuffer::get(
  self : StatsdistparetoBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoBuffer::set(
  self : StatsdistparetoBuffer,
  i : Int32,
  v : Double,
) -> StatsdistparetoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoBuffer::sum(self : StatsdistparetoBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoBuffer::mean(self : StatsdistparetoBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoBuffer::scale(
  self : StatsdistparetoBuffer,
  f : Double,
) -> StatsdistparetoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoBuffer::add(
  self : StatsdistparetoBuffer,
  other : StatsdistparetoBuffer,
) -> StatsdistparetoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoBuffer::copy(
  self : StatsdistparetoBuffer,
) -> StatsdistparetoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoBuffer::fill(
  self : StatsdistparetoBuffer,
  v : Double,
) -> StatsdistparetoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoBuffer::min(self : StatsdistparetoBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoBuffer::max(self : StatsdistparetoBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoBuffer::to_string(self : StatsdistparetoBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_cursor_make(size : Int32) -> StatsdistparetoCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoCursor::len(self : StatsdistparetoCursor) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoCursor::get(
  self : StatsdistparetoCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoCursor::set(
  self : StatsdistparetoCursor,
  i : Int32,
  v : Double,
) -> StatsdistparetoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoCursor::sum(self : StatsdistparetoCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoCursor::mean(self : StatsdistparetoCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoCursor::scale(
  self : StatsdistparetoCursor,
  f : Double,
) -> StatsdistparetoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoCursor::add(
  self : StatsdistparetoCursor,
  other : StatsdistparetoCursor,
) -> StatsdistparetoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoCursor::copy(
  self : StatsdistparetoCursor,
) -> StatsdistparetoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoCursor::fill(
  self : StatsdistparetoCursor,
  v : Double,
) -> StatsdistparetoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoCursor::min(self : StatsdistparetoCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoCursor::max(self : StatsdistparetoCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoCursor::to_string(self : StatsdistparetoCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_view_make(size : Int32) -> StatsdistparetoView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoView::len(self : StatsdistparetoView) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoView::get(
  self : StatsdistparetoView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoView::set(
  self : StatsdistparetoView,
  i : Int32,
  v : Double,
) -> StatsdistparetoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoView::sum(self : StatsdistparetoView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoView::mean(self : StatsdistparetoView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoView::scale(
  self : StatsdistparetoView,
  f : Double,
) -> StatsdistparetoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoView::add(
  self : StatsdistparetoView,
  other : StatsdistparetoView,
) -> StatsdistparetoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoView::copy(
  self : StatsdistparetoView,
) -> StatsdistparetoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoView::fill(
  self : StatsdistparetoView,
  v : Double,
) -> StatsdistparetoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoView::min(self : StatsdistparetoView) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoView::max(self : StatsdistparetoView) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoView::to_string(self : StatsdistparetoView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_range_make(size : Int32) -> StatsdistparetoRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoRange::len(self : StatsdistparetoRange) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoRange::get(
  self : StatsdistparetoRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoRange::set(
  self : StatsdistparetoRange,
  i : Int32,
  v : Double,
) -> StatsdistparetoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoRange::sum(self : StatsdistparetoRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoRange::mean(self : StatsdistparetoRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoRange::scale(
  self : StatsdistparetoRange,
  f : Double,
) -> StatsdistparetoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoRange::add(
  self : StatsdistparetoRange,
  other : StatsdistparetoRange,
) -> StatsdistparetoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoRange::copy(
  self : StatsdistparetoRange,
) -> StatsdistparetoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoRange::fill(
  self : StatsdistparetoRange,
  v : Double,
) -> StatsdistparetoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoRange::min(self : StatsdistparetoRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoRange::max(self : StatsdistparetoRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoRange::to_string(self : StatsdistparetoRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistparetoSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_pareto_slice_make(size : Int32) -> StatsdistparetoSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistparetoSlice::len(self : StatsdistparetoSlice) -> Int32 {
  self.size
}

///|
pub fn StatsdistparetoSlice::get(
  self : StatsdistparetoSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistparetoSlice::set(
  self : StatsdistparetoSlice,
  i : Int32,
  v : Double,
) -> StatsdistparetoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoSlice::sum(self : StatsdistparetoSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistparetoSlice::mean(self : StatsdistparetoSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistparetoSlice::scale(
  self : StatsdistparetoSlice,
  f : Double,
) -> StatsdistparetoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoSlice::add(
  self : StatsdistparetoSlice,
  other : StatsdistparetoSlice,
) -> StatsdistparetoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistparetoSlice::copy(
  self : StatsdistparetoSlice,
) -> StatsdistparetoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoSlice::fill(
  self : StatsdistparetoSlice,
  v : Double,
) -> StatsdistparetoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistparetoSlice::min(self : StatsdistparetoSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistparetoSlice::max(self : StatsdistparetoSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistparetoSlice::to_string(self : StatsdistparetoSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
