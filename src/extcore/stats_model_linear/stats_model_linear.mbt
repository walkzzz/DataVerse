///|
///===
/// extcore/stats_model_linear
pub(all) struct StatsmodellinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_model_linear_make_point(
  x : Double,
  y : Double,
) -> StatsmodellinearPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_model_linear_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatsmodellinearPoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatsmodellinearPoint::x(self : StatsmodellinearPoint) -> Double {
  self.x
}

///|
pub fn StatsmodellinearPoint::y(self : StatsmodellinearPoint) -> Double {
  self.y
}

///|
pub fn StatsmodellinearPoint::z(self : StatsmodellinearPoint) -> Double {
  self.z
}

///|
pub fn StatsmodellinearPoint::label(self : StatsmodellinearPoint) -> Int32 {
  self.label
}

///|
pub fn StatsmodellinearPoint::dist(
  self : StatsmodellinearPoint,
  other : StatsmodellinearPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatsmodellinearPoint::add(
  self : StatsmodellinearPoint,
  other : StatsmodellinearPoint,
) -> StatsmodellinearPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatsmodellinearPoint::sub(
  self : StatsmodellinearPoint,
  other : StatsmodellinearPoint,
) -> StatsmodellinearPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatsmodellinearPoint::scale(
  self : StatsmodellinearPoint,
  s : Double,
) -> StatsmodellinearPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatsmodellinearPoint::dot(
  self : StatsmodellinearPoint,
  other : StatsmodellinearPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatsmodellinearPoint::cross(
  self : StatsmodellinearPoint,
  other : StatsmodellinearPoint,
) -> StatsmodellinearPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatsmodellinearPoint::norm(self : StatsmodellinearPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatsmodellinearPoint::normalize(
  self : StatsmodellinearPoint,
) -> StatsmodellinearPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsmodellinearPoint::negate(
  self : StatsmodellinearPoint,
) -> StatsmodellinearPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatsmodellinearPoint::mid(
  self : StatsmodellinearPoint,
  other : StatsmodellinearPoint,
) -> StatsmodellinearPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatsmodellinearPoint::lerp(
  self : StatsmodellinearPoint,
  other : StatsmodellinearPoint,
  t : Double,
) -> StatsmodellinearPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatsmodellinearPoint::to_string(self : StatsmodellinearPoint) -> String {
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
pub(all) struct StatsmodellinearSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_model_linear_make_series(
  vals : Array[Double],
  name : String,
) -> StatsmodellinearSeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatsmodellinearSeries::len(self : StatsmodellinearSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn StatsmodellinearSeries::sum(self : StatsmodellinearSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatsmodellinearSeries::mean(self : StatsmodellinearSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatsmodellinearSeries::min(self : StatsmodellinearSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatsmodellinearSeries::max(self : StatsmodellinearSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatsmodellinearSeries::range(self : StatsmodellinearSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatsmodellinearSeries::variance(
  self : StatsmodellinearSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatsmodellinearSeries::std(self : StatsmodellinearSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatsmodellinearSeries::median(self : StatsmodellinearSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatsmodellinearSeries::scale(
  self : StatsmodellinearSeries,
  f : Double,
) -> StatsmodellinearSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatsmodellinearSeries::add(
  self : StatsmodellinearSeries,
  other : StatsmodellinearSeries,
) -> StatsmodellinearSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsmodellinearSeries::sub(
  self : StatsmodellinearSeries,
  other : StatsmodellinearSeries,
) -> StatsmodellinearSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsmodellinearSeries::normalize(
  self : StatsmodellinearSeries,
) -> StatsmodellinearSeries {
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
pub fn StatsmodellinearSeries::cumsum(
  self : StatsmodellinearSeries,
) -> StatsmodellinearSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatsmodellinearSeries::to_string(
  self : StatsmodellinearSeries,
) -> String {
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
pub(all) struct StatsmodellinearMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_model_linear_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatsmodellinearMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_model_linear_matrix_identity(n : Int32) -> StatsmodellinearMatrix {
  let m = stats_model_linear_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatsmodellinearMatrix::get(
  self : StatsmodellinearMatrix,
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
pub fn StatsmodellinearMatrix::transpose(
  self : StatsmodellinearMatrix,
) -> StatsmodellinearMatrix {
  let result = stats_model_linear_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatsmodellinearMatrix::add(
  self : StatsmodellinearMatrix,
  other : StatsmodellinearMatrix,
) -> StatsmodellinearMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_model_linear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatsmodellinearMatrix::scale(
  self : StatsmodellinearMatrix,
  s : Double,
) -> StatsmodellinearMatrix {
  let result = stats_model_linear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatsmodellinearMatrix::multiply(
  self : StatsmodellinearMatrix,
  other : StatsmodellinearMatrix,
) -> StatsmodellinearMatrix {
  if self.cols != other.rows {
    return stats_model_linear_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_model_linear_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatsmodellinearMatrix::trace(self : StatsmodellinearMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatsmodellinearMatrix::det(self : StatsmodellinearMatrix) -> Double {
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
pub fn StatsmodellinearMatrix::norm(self : StatsmodellinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn StatsmodellinearMatrix::to_string(
  self : StatsmodellinearMatrix,
) -> String {
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
pub(all) struct StatsmodellinearVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_model_linear_make_vector(
  comps : Array[Double],
) -> StatsmodellinearVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_model_linear_vector_zero(dim : Int32) -> StatsmodellinearVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatsmodellinearVector::add(
  self : StatsmodellinearVector,
  other : StatsmodellinearVector,
) -> StatsmodellinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsmodellinearVector::sub(
  self : StatsmodellinearVector,
  other : StatsmodellinearVector,
) -> StatsmodellinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsmodellinearVector::scale(
  self : StatsmodellinearVector,
  s : Double,
) -> StatsmodellinearVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatsmodellinearVector::dot(
  self : StatsmodellinearVector,
  other : StatsmodellinearVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatsmodellinearVector::norm(self : StatsmodellinearVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatsmodellinearVector::normalize(
  self : StatsmodellinearVector,
) -> StatsmodellinearVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsmodellinearVector::dist(
  self : StatsmodellinearVector,
  other : StatsmodellinearVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatsmodellinearVector::to_string(
  self : StatsmodellinearVector,
) -> String {
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
pub(all) struct StatsmodellinearFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_frame_make(size : Int32) -> StatsmodellinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearFrame::len(self : StatsmodellinearFrame) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearFrame::get(
  self : StatsmodellinearFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearFrame::set(
  self : StatsmodellinearFrame,
  i : Int32,
  v : Double,
) -> StatsmodellinearFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearFrame::sum(self : StatsmodellinearFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearFrame::mean(self : StatsmodellinearFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearFrame::scale(
  self : StatsmodellinearFrame,
  f : Double,
) -> StatsmodellinearFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearFrame::add(
  self : StatsmodellinearFrame,
  other : StatsmodellinearFrame,
) -> StatsmodellinearFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearFrame::copy(
  self : StatsmodellinearFrame,
) -> StatsmodellinearFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearFrame::fill(
  self : StatsmodellinearFrame,
  v : Double,
) -> StatsmodellinearFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearFrame::min(self : StatsmodellinearFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearFrame::max(self : StatsmodellinearFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearFrame::to_string(self : StatsmodellinearFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_table_make(size : Int32) -> StatsmodellinearTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearTable::len(self : StatsmodellinearTable) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearTable::get(
  self : StatsmodellinearTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearTable::set(
  self : StatsmodellinearTable,
  i : Int32,
  v : Double,
) -> StatsmodellinearTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearTable::sum(self : StatsmodellinearTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearTable::mean(self : StatsmodellinearTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearTable::scale(
  self : StatsmodellinearTable,
  f : Double,
) -> StatsmodellinearTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearTable::add(
  self : StatsmodellinearTable,
  other : StatsmodellinearTable,
) -> StatsmodellinearTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearTable::copy(
  self : StatsmodellinearTable,
) -> StatsmodellinearTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearTable::fill(
  self : StatsmodellinearTable,
  v : Double,
) -> StatsmodellinearTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearTable::min(self : StatsmodellinearTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearTable::max(self : StatsmodellinearTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearTable::to_string(self : StatsmodellinearTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_graphn_make(size : Int32) -> StatsmodellinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearGraphN::len(self : StatsmodellinearGraphN) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearGraphN::get(
  self : StatsmodellinearGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearGraphN::set(
  self : StatsmodellinearGraphN,
  i : Int32,
  v : Double,
) -> StatsmodellinearGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearGraphN::sum(self : StatsmodellinearGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearGraphN::mean(self : StatsmodellinearGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearGraphN::scale(
  self : StatsmodellinearGraphN,
  f : Double,
) -> StatsmodellinearGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearGraphN::add(
  self : StatsmodellinearGraphN,
  other : StatsmodellinearGraphN,
) -> StatsmodellinearGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearGraphN::copy(
  self : StatsmodellinearGraphN,
) -> StatsmodellinearGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearGraphN::fill(
  self : StatsmodellinearGraphN,
  v : Double,
) -> StatsmodellinearGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearGraphN::min(self : StatsmodellinearGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearGraphN::max(self : StatsmodellinearGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearGraphN::to_string(
  self : StatsmodellinearGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_node_make(size : Int32) -> StatsmodellinearNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearNode::len(self : StatsmodellinearNode) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearNode::get(
  self : StatsmodellinearNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearNode::set(
  self : StatsmodellinearNode,
  i : Int32,
  v : Double,
) -> StatsmodellinearNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearNode::sum(self : StatsmodellinearNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearNode::mean(self : StatsmodellinearNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearNode::scale(
  self : StatsmodellinearNode,
  f : Double,
) -> StatsmodellinearNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearNode::add(
  self : StatsmodellinearNode,
  other : StatsmodellinearNode,
) -> StatsmodellinearNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearNode::copy(
  self : StatsmodellinearNode,
) -> StatsmodellinearNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearNode::fill(
  self : StatsmodellinearNode,
  v : Double,
) -> StatsmodellinearNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearNode::min(self : StatsmodellinearNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearNode::max(self : StatsmodellinearNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearNode::to_string(self : StatsmodellinearNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_edge_make(size : Int32) -> StatsmodellinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearEdge::len(self : StatsmodellinearEdge) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearEdge::get(
  self : StatsmodellinearEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearEdge::set(
  self : StatsmodellinearEdge,
  i : Int32,
  v : Double,
) -> StatsmodellinearEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearEdge::sum(self : StatsmodellinearEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearEdge::mean(self : StatsmodellinearEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearEdge::scale(
  self : StatsmodellinearEdge,
  f : Double,
) -> StatsmodellinearEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearEdge::add(
  self : StatsmodellinearEdge,
  other : StatsmodellinearEdge,
) -> StatsmodellinearEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearEdge::copy(
  self : StatsmodellinearEdge,
) -> StatsmodellinearEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearEdge::fill(
  self : StatsmodellinearEdge,
  v : Double,
) -> StatsmodellinearEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearEdge::min(self : StatsmodellinearEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearEdge::max(self : StatsmodellinearEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearEdge::to_string(self : StatsmodellinearEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_path_make(size : Int32) -> StatsmodellinearPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearPath::len(self : StatsmodellinearPath) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearPath::get(
  self : StatsmodellinearPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearPath::set(
  self : StatsmodellinearPath,
  i : Int32,
  v : Double,
) -> StatsmodellinearPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearPath::sum(self : StatsmodellinearPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearPath::mean(self : StatsmodellinearPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearPath::scale(
  self : StatsmodellinearPath,
  f : Double,
) -> StatsmodellinearPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearPath::add(
  self : StatsmodellinearPath,
  other : StatsmodellinearPath,
) -> StatsmodellinearPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearPath::copy(
  self : StatsmodellinearPath,
) -> StatsmodellinearPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearPath::fill(
  self : StatsmodellinearPath,
  v : Double,
) -> StatsmodellinearPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearPath::min(self : StatsmodellinearPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearPath::max(self : StatsmodellinearPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearPath::to_string(self : StatsmodellinearPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_cluster_make(size : Int32) -> StatsmodellinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearCluster::len(self : StatsmodellinearCluster) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearCluster::get(
  self : StatsmodellinearCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearCluster::set(
  self : StatsmodellinearCluster,
  i : Int32,
  v : Double,
) -> StatsmodellinearCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearCluster::sum(self : StatsmodellinearCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearCluster::mean(self : StatsmodellinearCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearCluster::scale(
  self : StatsmodellinearCluster,
  f : Double,
) -> StatsmodellinearCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearCluster::add(
  self : StatsmodellinearCluster,
  other : StatsmodellinearCluster,
) -> StatsmodellinearCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearCluster::copy(
  self : StatsmodellinearCluster,
) -> StatsmodellinearCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearCluster::fill(
  self : StatsmodellinearCluster,
  v : Double,
) -> StatsmodellinearCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearCluster::min(self : StatsmodellinearCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearCluster::max(self : StatsmodellinearCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearCluster::to_string(
  self : StatsmodellinearCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_model_make(size : Int32) -> StatsmodellinearModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearModel::len(self : StatsmodellinearModel) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearModel::get(
  self : StatsmodellinearModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearModel::set(
  self : StatsmodellinearModel,
  i : Int32,
  v : Double,
) -> StatsmodellinearModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearModel::sum(self : StatsmodellinearModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearModel::mean(self : StatsmodellinearModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearModel::scale(
  self : StatsmodellinearModel,
  f : Double,
) -> StatsmodellinearModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearModel::add(
  self : StatsmodellinearModel,
  other : StatsmodellinearModel,
) -> StatsmodellinearModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearModel::copy(
  self : StatsmodellinearModel,
) -> StatsmodellinearModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearModel::fill(
  self : StatsmodellinearModel,
  v : Double,
) -> StatsmodellinearModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearModel::min(self : StatsmodellinearModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearModel::max(self : StatsmodellinearModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearModel::to_string(self : StatsmodellinearModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_layer_make(size : Int32) -> StatsmodellinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearLayer::len(self : StatsmodellinearLayer) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearLayer::get(
  self : StatsmodellinearLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearLayer::set(
  self : StatsmodellinearLayer,
  i : Int32,
  v : Double,
) -> StatsmodellinearLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearLayer::sum(self : StatsmodellinearLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearLayer::mean(self : StatsmodellinearLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearLayer::scale(
  self : StatsmodellinearLayer,
  f : Double,
) -> StatsmodellinearLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearLayer::add(
  self : StatsmodellinearLayer,
  other : StatsmodellinearLayer,
) -> StatsmodellinearLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearLayer::copy(
  self : StatsmodellinearLayer,
) -> StatsmodellinearLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearLayer::fill(
  self : StatsmodellinearLayer,
  v : Double,
) -> StatsmodellinearLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearLayer::min(self : StatsmodellinearLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearLayer::max(self : StatsmodellinearLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearLayer::to_string(self : StatsmodellinearLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_buffer_make(size : Int32) -> StatsmodellinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearBuffer::len(self : StatsmodellinearBuffer) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearBuffer::get(
  self : StatsmodellinearBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearBuffer::set(
  self : StatsmodellinearBuffer,
  i : Int32,
  v : Double,
) -> StatsmodellinearBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearBuffer::sum(self : StatsmodellinearBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearBuffer::mean(self : StatsmodellinearBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearBuffer::scale(
  self : StatsmodellinearBuffer,
  f : Double,
) -> StatsmodellinearBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearBuffer::add(
  self : StatsmodellinearBuffer,
  other : StatsmodellinearBuffer,
) -> StatsmodellinearBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearBuffer::copy(
  self : StatsmodellinearBuffer,
) -> StatsmodellinearBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearBuffer::fill(
  self : StatsmodellinearBuffer,
  v : Double,
) -> StatsmodellinearBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearBuffer::min(self : StatsmodellinearBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearBuffer::max(self : StatsmodellinearBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearBuffer::to_string(
  self : StatsmodellinearBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_cursor_make(size : Int32) -> StatsmodellinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearCursor::len(self : StatsmodellinearCursor) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearCursor::get(
  self : StatsmodellinearCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearCursor::set(
  self : StatsmodellinearCursor,
  i : Int32,
  v : Double,
) -> StatsmodellinearCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearCursor::sum(self : StatsmodellinearCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearCursor::mean(self : StatsmodellinearCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearCursor::scale(
  self : StatsmodellinearCursor,
  f : Double,
) -> StatsmodellinearCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearCursor::add(
  self : StatsmodellinearCursor,
  other : StatsmodellinearCursor,
) -> StatsmodellinearCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearCursor::copy(
  self : StatsmodellinearCursor,
) -> StatsmodellinearCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearCursor::fill(
  self : StatsmodellinearCursor,
  v : Double,
) -> StatsmodellinearCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearCursor::min(self : StatsmodellinearCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearCursor::max(self : StatsmodellinearCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearCursor::to_string(
  self : StatsmodellinearCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_view_make(size : Int32) -> StatsmodellinearView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearView::len(self : StatsmodellinearView) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearView::get(
  self : StatsmodellinearView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearView::set(
  self : StatsmodellinearView,
  i : Int32,
  v : Double,
) -> StatsmodellinearView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearView::sum(self : StatsmodellinearView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearView::mean(self : StatsmodellinearView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearView::scale(
  self : StatsmodellinearView,
  f : Double,
) -> StatsmodellinearView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearView::add(
  self : StatsmodellinearView,
  other : StatsmodellinearView,
) -> StatsmodellinearView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearView::copy(
  self : StatsmodellinearView,
) -> StatsmodellinearView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearView::fill(
  self : StatsmodellinearView,
  v : Double,
) -> StatsmodellinearView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearView::min(self : StatsmodellinearView) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearView::max(self : StatsmodellinearView) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearView::to_string(self : StatsmodellinearView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_range_make(size : Int32) -> StatsmodellinearRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearRange::len(self : StatsmodellinearRange) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearRange::get(
  self : StatsmodellinearRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearRange::set(
  self : StatsmodellinearRange,
  i : Int32,
  v : Double,
) -> StatsmodellinearRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearRange::sum(self : StatsmodellinearRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearRange::mean(self : StatsmodellinearRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearRange::scale(
  self : StatsmodellinearRange,
  f : Double,
) -> StatsmodellinearRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearRange::add(
  self : StatsmodellinearRange,
  other : StatsmodellinearRange,
) -> StatsmodellinearRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearRange::copy(
  self : StatsmodellinearRange,
) -> StatsmodellinearRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearRange::fill(
  self : StatsmodellinearRange,
  v : Double,
) -> StatsmodellinearRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearRange::min(self : StatsmodellinearRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearRange::max(self : StatsmodellinearRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearRange::to_string(self : StatsmodellinearRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsmodellinearSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_model_linear_slice_make(size : Int32) -> StatsmodellinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsmodellinearSlice::len(self : StatsmodellinearSlice) -> Int32 {
  self.size
}

///|
pub fn StatsmodellinearSlice::get(
  self : StatsmodellinearSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsmodellinearSlice::set(
  self : StatsmodellinearSlice,
  i : Int32,
  v : Double,
) -> StatsmodellinearSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearSlice::sum(self : StatsmodellinearSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsmodellinearSlice::mean(self : StatsmodellinearSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsmodellinearSlice::scale(
  self : StatsmodellinearSlice,
  f : Double,
) -> StatsmodellinearSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearSlice::add(
  self : StatsmodellinearSlice,
  other : StatsmodellinearSlice,
) -> StatsmodellinearSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsmodellinearSlice::copy(
  self : StatsmodellinearSlice,
) -> StatsmodellinearSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearSlice::fill(
  self : StatsmodellinearSlice,
  v : Double,
) -> StatsmodellinearSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsmodellinearSlice::min(self : StatsmodellinearSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsmodellinearSlice::max(self : StatsmodellinearSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsmodellinearSlice::to_string(self : StatsmodellinearSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
