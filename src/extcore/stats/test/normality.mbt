///|
///===
/// extcore/stats_test_normality
pub(all) struct StatstestnormalityPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_test_normality_make_point(
  x : Double,
  y : Double,
) -> StatstestnormalityPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_test_normality_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatstestnormalityPoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatstestnormalityPoint::x(self : StatstestnormalityPoint) -> Double {
  self.x
}

///|
pub fn StatstestnormalityPoint::y(self : StatstestnormalityPoint) -> Double {
  self.y
}

///|
pub fn StatstestnormalityPoint::z(self : StatstestnormalityPoint) -> Double {
  self.z
}

///|
pub fn StatstestnormalityPoint::label(self : StatstestnormalityPoint) -> Int32 {
  self.label
}

///|
pub fn StatstestnormalityPoint::dist(
  self : StatstestnormalityPoint,
  other : StatstestnormalityPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatstestnormalityPoint::add(
  self : StatstestnormalityPoint,
  other : StatstestnormalityPoint,
) -> StatstestnormalityPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatstestnormalityPoint::sub(
  self : StatstestnormalityPoint,
  other : StatstestnormalityPoint,
) -> StatstestnormalityPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatstestnormalityPoint::scale(
  self : StatstestnormalityPoint,
  s : Double,
) -> StatstestnormalityPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatstestnormalityPoint::dot(
  self : StatstestnormalityPoint,
  other : StatstestnormalityPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatstestnormalityPoint::cross(
  self : StatstestnormalityPoint,
  other : StatstestnormalityPoint,
) -> StatstestnormalityPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatstestnormalityPoint::norm(self : StatstestnormalityPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatstestnormalityPoint::normalize(
  self : StatstestnormalityPoint,
) -> StatstestnormalityPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatstestnormalityPoint::negate(
  self : StatstestnormalityPoint,
) -> StatstestnormalityPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatstestnormalityPoint::mid(
  self : StatstestnormalityPoint,
  other : StatstestnormalityPoint,
) -> StatstestnormalityPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatstestnormalityPoint::lerp(
  self : StatstestnormalityPoint,
  other : StatstestnormalityPoint,
  t : Double,
) -> StatstestnormalityPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatstestnormalityPoint::to_string(
  self : StatstestnormalityPoint,
) -> String {
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
pub(all) struct StatstestnormalitySeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_test_normality_make_series(
  vals : Array[Double],
  name : String,
) -> StatstestnormalitySeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatstestnormalitySeries::len(self : StatstestnormalitySeries) -> Int32 {
  self.vals.length()
}

///|
pub fn StatstestnormalitySeries::sum(self : StatstestnormalitySeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatstestnormalitySeries::mean(
  self : StatstestnormalitySeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatstestnormalitySeries::min(self : StatstestnormalitySeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatstestnormalitySeries::max(self : StatstestnormalitySeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatstestnormalitySeries::range(
  self : StatstestnormalitySeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatstestnormalitySeries::variance(
  self : StatstestnormalitySeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatstestnormalitySeries::std(self : StatstestnormalitySeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatstestnormalitySeries::median(
  self : StatstestnormalitySeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatstestnormalitySeries::scale(
  self : StatstestnormalitySeries,
  f : Double,
) -> StatstestnormalitySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatstestnormalitySeries::add(
  self : StatstestnormalitySeries,
  other : StatstestnormalitySeries,
) -> StatstestnormalitySeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatstestnormalitySeries::sub(
  self : StatstestnormalitySeries,
  other : StatstestnormalitySeries,
) -> StatstestnormalitySeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatstestnormalitySeries::normalize(
  self : StatstestnormalitySeries,
) -> StatstestnormalitySeries {
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
pub fn StatstestnormalitySeries::cumsum(
  self : StatstestnormalitySeries,
) -> StatstestnormalitySeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatstestnormalitySeries::to_string(
  self : StatstestnormalitySeries,
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
pub(all) struct StatstestnormalityMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_test_normality_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatstestnormalityMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_test_normality_matrix_identity(
  n : Int32,
) -> StatstestnormalityMatrix {
  let m = stats_test_normality_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatstestnormalityMatrix::get(
  self : StatstestnormalityMatrix,
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
pub fn StatstestnormalityMatrix::transpose(
  self : StatstestnormalityMatrix,
) -> StatstestnormalityMatrix {
  let result = stats_test_normality_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatstestnormalityMatrix::add(
  self : StatstestnormalityMatrix,
  other : StatstestnormalityMatrix,
) -> StatstestnormalityMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_test_normality_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatstestnormalityMatrix::scale(
  self : StatstestnormalityMatrix,
  s : Double,
) -> StatstestnormalityMatrix {
  let result = stats_test_normality_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatstestnormalityMatrix::multiply(
  self : StatstestnormalityMatrix,
  other : StatstestnormalityMatrix,
) -> StatstestnormalityMatrix {
  if self.cols != other.rows {
    return stats_test_normality_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_test_normality_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatstestnormalityMatrix::trace(
  self : StatstestnormalityMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatstestnormalityMatrix::det(self : StatstestnormalityMatrix) -> Double {
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
pub fn StatstestnormalityMatrix::norm(
  self : StatstestnormalityMatrix,
) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn StatstestnormalityMatrix::to_string(
  self : StatstestnormalityMatrix,
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
pub(all) struct StatstestnormalityVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_test_normality_make_vector(
  comps : Array[Double],
) -> StatstestnormalityVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_test_normality_vector_zero(
  dim : Int32,
) -> StatstestnormalityVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatstestnormalityVector::add(
  self : StatstestnormalityVector,
  other : StatstestnormalityVector,
) -> StatstestnormalityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatstestnormalityVector::sub(
  self : StatstestnormalityVector,
  other : StatstestnormalityVector,
) -> StatstestnormalityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatstestnormalityVector::scale(
  self : StatstestnormalityVector,
  s : Double,
) -> StatstestnormalityVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatstestnormalityVector::dot(
  self : StatstestnormalityVector,
  other : StatstestnormalityVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatstestnormalityVector::norm(
  self : StatstestnormalityVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatstestnormalityVector::normalize(
  self : StatstestnormalityVector,
) -> StatstestnormalityVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatstestnormalityVector::dist(
  self : StatstestnormalityVector,
  other : StatstestnormalityVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatstestnormalityVector::to_string(
  self : StatstestnormalityVector,
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
pub(all) struct StatstestnormalityFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_frame_make(size : Int32) -> StatstestnormalityFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityFrame::len(self : StatstestnormalityFrame) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityFrame::get(
  self : StatstestnormalityFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityFrame::set(
  self : StatstestnormalityFrame,
  i : Int32,
  v : Double,
) -> StatstestnormalityFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityFrame::sum(self : StatstestnormalityFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityFrame::mean(self : StatstestnormalityFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityFrame::scale(
  self : StatstestnormalityFrame,
  f : Double,
) -> StatstestnormalityFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityFrame::add(
  self : StatstestnormalityFrame,
  other : StatstestnormalityFrame,
) -> StatstestnormalityFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityFrame::copy(
  self : StatstestnormalityFrame,
) -> StatstestnormalityFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityFrame::fill(
  self : StatstestnormalityFrame,
  v : Double,
) -> StatstestnormalityFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityFrame::min(self : StatstestnormalityFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityFrame::max(self : StatstestnormalityFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityFrame::to_string(
  self : StatstestnormalityFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_table_make(size : Int32) -> StatstestnormalityTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityTable::len(self : StatstestnormalityTable) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityTable::get(
  self : StatstestnormalityTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityTable::set(
  self : StatstestnormalityTable,
  i : Int32,
  v : Double,
) -> StatstestnormalityTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityTable::sum(self : StatstestnormalityTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityTable::mean(self : StatstestnormalityTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityTable::scale(
  self : StatstestnormalityTable,
  f : Double,
) -> StatstestnormalityTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityTable::add(
  self : StatstestnormalityTable,
  other : StatstestnormalityTable,
) -> StatstestnormalityTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityTable::copy(
  self : StatstestnormalityTable,
) -> StatstestnormalityTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityTable::fill(
  self : StatstestnormalityTable,
  v : Double,
) -> StatstestnormalityTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityTable::min(self : StatstestnormalityTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityTable::max(self : StatstestnormalityTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityTable::to_string(
  self : StatstestnormalityTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_graphn_make(
  size : Int32,
) -> StatstestnormalityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityGraphN::len(self : StatstestnormalityGraphN) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityGraphN::get(
  self : StatstestnormalityGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityGraphN::set(
  self : StatstestnormalityGraphN,
  i : Int32,
  v : Double,
) -> StatstestnormalityGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityGraphN::sum(self : StatstestnormalityGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityGraphN::mean(
  self : StatstestnormalityGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityGraphN::scale(
  self : StatstestnormalityGraphN,
  f : Double,
) -> StatstestnormalityGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityGraphN::add(
  self : StatstestnormalityGraphN,
  other : StatstestnormalityGraphN,
) -> StatstestnormalityGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityGraphN::copy(
  self : StatstestnormalityGraphN,
) -> StatstestnormalityGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityGraphN::fill(
  self : StatstestnormalityGraphN,
  v : Double,
) -> StatstestnormalityGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityGraphN::min(self : StatstestnormalityGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityGraphN::max(self : StatstestnormalityGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityGraphN::to_string(
  self : StatstestnormalityGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_node_make(size : Int32) -> StatstestnormalityNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityNode::len(self : StatstestnormalityNode) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityNode::get(
  self : StatstestnormalityNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityNode::set(
  self : StatstestnormalityNode,
  i : Int32,
  v : Double,
) -> StatstestnormalityNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityNode::sum(self : StatstestnormalityNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityNode::mean(self : StatstestnormalityNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityNode::scale(
  self : StatstestnormalityNode,
  f : Double,
) -> StatstestnormalityNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityNode::add(
  self : StatstestnormalityNode,
  other : StatstestnormalityNode,
) -> StatstestnormalityNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityNode::copy(
  self : StatstestnormalityNode,
) -> StatstestnormalityNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityNode::fill(
  self : StatstestnormalityNode,
  v : Double,
) -> StatstestnormalityNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityNode::min(self : StatstestnormalityNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityNode::max(self : StatstestnormalityNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityNode::to_string(
  self : StatstestnormalityNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_edge_make(size : Int32) -> StatstestnormalityEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityEdge::len(self : StatstestnormalityEdge) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityEdge::get(
  self : StatstestnormalityEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityEdge::set(
  self : StatstestnormalityEdge,
  i : Int32,
  v : Double,
) -> StatstestnormalityEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityEdge::sum(self : StatstestnormalityEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityEdge::mean(self : StatstestnormalityEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityEdge::scale(
  self : StatstestnormalityEdge,
  f : Double,
) -> StatstestnormalityEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityEdge::add(
  self : StatstestnormalityEdge,
  other : StatstestnormalityEdge,
) -> StatstestnormalityEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityEdge::copy(
  self : StatstestnormalityEdge,
) -> StatstestnormalityEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityEdge::fill(
  self : StatstestnormalityEdge,
  v : Double,
) -> StatstestnormalityEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityEdge::min(self : StatstestnormalityEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityEdge::max(self : StatstestnormalityEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityEdge::to_string(
  self : StatstestnormalityEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_path_make(size : Int32) -> StatstestnormalityPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityPath::len(self : StatstestnormalityPath) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityPath::get(
  self : StatstestnormalityPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityPath::set(
  self : StatstestnormalityPath,
  i : Int32,
  v : Double,
) -> StatstestnormalityPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityPath::sum(self : StatstestnormalityPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityPath::mean(self : StatstestnormalityPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityPath::scale(
  self : StatstestnormalityPath,
  f : Double,
) -> StatstestnormalityPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityPath::add(
  self : StatstestnormalityPath,
  other : StatstestnormalityPath,
) -> StatstestnormalityPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityPath::copy(
  self : StatstestnormalityPath,
) -> StatstestnormalityPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityPath::fill(
  self : StatstestnormalityPath,
  v : Double,
) -> StatstestnormalityPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityPath::min(self : StatstestnormalityPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityPath::max(self : StatstestnormalityPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityPath::to_string(
  self : StatstestnormalityPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_cluster_make(
  size : Int32,
) -> StatstestnormalityCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityCluster::len(
  self : StatstestnormalityCluster,
) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityCluster::get(
  self : StatstestnormalityCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityCluster::set(
  self : StatstestnormalityCluster,
  i : Int32,
  v : Double,
) -> StatstestnormalityCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityCluster::sum(
  self : StatstestnormalityCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityCluster::mean(
  self : StatstestnormalityCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityCluster::scale(
  self : StatstestnormalityCluster,
  f : Double,
) -> StatstestnormalityCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityCluster::add(
  self : StatstestnormalityCluster,
  other : StatstestnormalityCluster,
) -> StatstestnormalityCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityCluster::copy(
  self : StatstestnormalityCluster,
) -> StatstestnormalityCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityCluster::fill(
  self : StatstestnormalityCluster,
  v : Double,
) -> StatstestnormalityCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityCluster::min(
  self : StatstestnormalityCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityCluster::max(
  self : StatstestnormalityCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityCluster::to_string(
  self : StatstestnormalityCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_model_make(size : Int32) -> StatstestnormalityModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityModel::len(self : StatstestnormalityModel) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityModel::get(
  self : StatstestnormalityModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityModel::set(
  self : StatstestnormalityModel,
  i : Int32,
  v : Double,
) -> StatstestnormalityModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityModel::sum(self : StatstestnormalityModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityModel::mean(self : StatstestnormalityModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityModel::scale(
  self : StatstestnormalityModel,
  f : Double,
) -> StatstestnormalityModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityModel::add(
  self : StatstestnormalityModel,
  other : StatstestnormalityModel,
) -> StatstestnormalityModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityModel::copy(
  self : StatstestnormalityModel,
) -> StatstestnormalityModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityModel::fill(
  self : StatstestnormalityModel,
  v : Double,
) -> StatstestnormalityModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityModel::min(self : StatstestnormalityModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityModel::max(self : StatstestnormalityModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityModel::to_string(
  self : StatstestnormalityModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_layer_make(size : Int32) -> StatstestnormalityLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityLayer::len(self : StatstestnormalityLayer) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityLayer::get(
  self : StatstestnormalityLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityLayer::set(
  self : StatstestnormalityLayer,
  i : Int32,
  v : Double,
) -> StatstestnormalityLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityLayer::sum(self : StatstestnormalityLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityLayer::mean(self : StatstestnormalityLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityLayer::scale(
  self : StatstestnormalityLayer,
  f : Double,
) -> StatstestnormalityLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityLayer::add(
  self : StatstestnormalityLayer,
  other : StatstestnormalityLayer,
) -> StatstestnormalityLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityLayer::copy(
  self : StatstestnormalityLayer,
) -> StatstestnormalityLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityLayer::fill(
  self : StatstestnormalityLayer,
  v : Double,
) -> StatstestnormalityLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityLayer::min(self : StatstestnormalityLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityLayer::max(self : StatstestnormalityLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityLayer::to_string(
  self : StatstestnormalityLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_buffer_make(
  size : Int32,
) -> StatstestnormalityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityBuffer::len(self : StatstestnormalityBuffer) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityBuffer::get(
  self : StatstestnormalityBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityBuffer::set(
  self : StatstestnormalityBuffer,
  i : Int32,
  v : Double,
) -> StatstestnormalityBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityBuffer::sum(self : StatstestnormalityBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityBuffer::mean(
  self : StatstestnormalityBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityBuffer::scale(
  self : StatstestnormalityBuffer,
  f : Double,
) -> StatstestnormalityBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityBuffer::add(
  self : StatstestnormalityBuffer,
  other : StatstestnormalityBuffer,
) -> StatstestnormalityBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityBuffer::copy(
  self : StatstestnormalityBuffer,
) -> StatstestnormalityBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityBuffer::fill(
  self : StatstestnormalityBuffer,
  v : Double,
) -> StatstestnormalityBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityBuffer::min(self : StatstestnormalityBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityBuffer::max(self : StatstestnormalityBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityBuffer::to_string(
  self : StatstestnormalityBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_cursor_make(
  size : Int32,
) -> StatstestnormalityCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityCursor::len(self : StatstestnormalityCursor) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityCursor::get(
  self : StatstestnormalityCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityCursor::set(
  self : StatstestnormalityCursor,
  i : Int32,
  v : Double,
) -> StatstestnormalityCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityCursor::sum(self : StatstestnormalityCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityCursor::mean(
  self : StatstestnormalityCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityCursor::scale(
  self : StatstestnormalityCursor,
  f : Double,
) -> StatstestnormalityCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityCursor::add(
  self : StatstestnormalityCursor,
  other : StatstestnormalityCursor,
) -> StatstestnormalityCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityCursor::copy(
  self : StatstestnormalityCursor,
) -> StatstestnormalityCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityCursor::fill(
  self : StatstestnormalityCursor,
  v : Double,
) -> StatstestnormalityCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityCursor::min(self : StatstestnormalityCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityCursor::max(self : StatstestnormalityCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityCursor::to_string(
  self : StatstestnormalityCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_view_make(size : Int32) -> StatstestnormalityView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityView::len(self : StatstestnormalityView) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityView::get(
  self : StatstestnormalityView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityView::set(
  self : StatstestnormalityView,
  i : Int32,
  v : Double,
) -> StatstestnormalityView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityView::sum(self : StatstestnormalityView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityView::mean(self : StatstestnormalityView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityView::scale(
  self : StatstestnormalityView,
  f : Double,
) -> StatstestnormalityView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityView::add(
  self : StatstestnormalityView,
  other : StatstestnormalityView,
) -> StatstestnormalityView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityView::copy(
  self : StatstestnormalityView,
) -> StatstestnormalityView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityView::fill(
  self : StatstestnormalityView,
  v : Double,
) -> StatstestnormalityView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityView::min(self : StatstestnormalityView) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityView::max(self : StatstestnormalityView) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityView::to_string(
  self : StatstestnormalityView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalityRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_range_make(size : Int32) -> StatstestnormalityRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalityRange::len(self : StatstestnormalityRange) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalityRange::get(
  self : StatstestnormalityRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalityRange::set(
  self : StatstestnormalityRange,
  i : Int32,
  v : Double,
) -> StatstestnormalityRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityRange::sum(self : StatstestnormalityRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalityRange::mean(self : StatstestnormalityRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalityRange::scale(
  self : StatstestnormalityRange,
  f : Double,
) -> StatstestnormalityRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityRange::add(
  self : StatstestnormalityRange,
  other : StatstestnormalityRange,
) -> StatstestnormalityRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalityRange::copy(
  self : StatstestnormalityRange,
) -> StatstestnormalityRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityRange::fill(
  self : StatstestnormalityRange,
  v : Double,
) -> StatstestnormalityRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalityRange::min(self : StatstestnormalityRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalityRange::max(self : StatstestnormalityRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalityRange::to_string(
  self : StatstestnormalityRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatstestnormalitySlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_test_normality_slice_make(size : Int32) -> StatstestnormalitySlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatstestnormalitySlice::len(self : StatstestnormalitySlice) -> Int32 {
  self.size
}

///|
pub fn StatstestnormalitySlice::get(
  self : StatstestnormalitySlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatstestnormalitySlice::set(
  self : StatstestnormalitySlice,
  i : Int32,
  v : Double,
) -> StatstestnormalitySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalitySlice::sum(self : StatstestnormalitySlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatstestnormalitySlice::mean(self : StatstestnormalitySlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatstestnormalitySlice::scale(
  self : StatstestnormalitySlice,
  f : Double,
) -> StatstestnormalitySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalitySlice::add(
  self : StatstestnormalitySlice,
  other : StatstestnormalitySlice,
) -> StatstestnormalitySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatstestnormalitySlice::copy(
  self : StatstestnormalitySlice,
) -> StatstestnormalitySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalitySlice::fill(
  self : StatstestnormalitySlice,
  v : Double,
) -> StatstestnormalitySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatstestnormalitySlice::min(self : StatstestnormalitySlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatstestnormalitySlice::max(self : StatstestnormalitySlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatstestnormalitySlice::to_string(
  self : StatstestnormalitySlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
