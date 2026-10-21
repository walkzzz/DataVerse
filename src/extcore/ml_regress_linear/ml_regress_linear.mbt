///|
///===
/// extcore/ml_regress_linear
pub(all) struct MlregresslinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ml_regress_linear_make_point(
  x : Double,
  y : Double,
) -> MlregresslinearPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ml_regress_linear_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MlregresslinearPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MlregresslinearPoint::x(self : MlregresslinearPoint) -> Double {
  self.x
}

///|
pub fn MlregresslinearPoint::y(self : MlregresslinearPoint) -> Double {
  self.y
}

///|
pub fn MlregresslinearPoint::z(self : MlregresslinearPoint) -> Double {
  self.z
}

///|
pub fn MlregresslinearPoint::label(self : MlregresslinearPoint) -> Int32 {
  self.label
}

///|
pub fn MlregresslinearPoint::dist(
  self : MlregresslinearPoint,
  other : MlregresslinearPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MlregresslinearPoint::add(
  self : MlregresslinearPoint,
  other : MlregresslinearPoint,
) -> MlregresslinearPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MlregresslinearPoint::sub(
  self : MlregresslinearPoint,
  other : MlregresslinearPoint,
) -> MlregresslinearPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MlregresslinearPoint::scale(
  self : MlregresslinearPoint,
  s : Double,
) -> MlregresslinearPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MlregresslinearPoint::dot(
  self : MlregresslinearPoint,
  other : MlregresslinearPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MlregresslinearPoint::cross(
  self : MlregresslinearPoint,
  other : MlregresslinearPoint,
) -> MlregresslinearPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MlregresslinearPoint::norm(self : MlregresslinearPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MlregresslinearPoint::normalize(
  self : MlregresslinearPoint,
) -> MlregresslinearPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlregresslinearPoint::negate(
  self : MlregresslinearPoint,
) -> MlregresslinearPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MlregresslinearPoint::mid(
  self : MlregresslinearPoint,
  other : MlregresslinearPoint,
) -> MlregresslinearPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MlregresslinearPoint::lerp(
  self : MlregresslinearPoint,
  other : MlregresslinearPoint,
  t : Double,
) -> MlregresslinearPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MlregresslinearPoint::to_string(self : MlregresslinearPoint) -> String {
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
pub(all) struct MlregresslinearSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ml_regress_linear_make_series(
  vals : Array[Double],
  name : String,
) -> MlregresslinearSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MlregresslinearSeries::len(self : MlregresslinearSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MlregresslinearSeries::sum(self : MlregresslinearSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MlregresslinearSeries::mean(self : MlregresslinearSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MlregresslinearSeries::min(self : MlregresslinearSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MlregresslinearSeries::max(self : MlregresslinearSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MlregresslinearSeries::range(self : MlregresslinearSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MlregresslinearSeries::variance(self : MlregresslinearSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MlregresslinearSeries::std(self : MlregresslinearSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MlregresslinearSeries::median(self : MlregresslinearSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MlregresslinearSeries::scale(
  self : MlregresslinearSeries,
  f : Double,
) -> MlregresslinearSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MlregresslinearSeries::add(
  self : MlregresslinearSeries,
  other : MlregresslinearSeries,
) -> MlregresslinearSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlregresslinearSeries::sub(
  self : MlregresslinearSeries,
  other : MlregresslinearSeries,
) -> MlregresslinearSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlregresslinearSeries::normalize(
  self : MlregresslinearSeries,
) -> MlregresslinearSeries {
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
pub fn MlregresslinearSeries::cumsum(
  self : MlregresslinearSeries,
) -> MlregresslinearSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MlregresslinearSeries::to_string(self : MlregresslinearSeries) -> String {
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
pub(all) struct MlregresslinearMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ml_regress_linear_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MlregresslinearMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ml_regress_linear_matrix_identity(n : Int32) -> MlregresslinearMatrix {
  let m = ml_regress_linear_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MlregresslinearMatrix::get(
  self : MlregresslinearMatrix,
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
pub fn MlregresslinearMatrix::transpose(
  self : MlregresslinearMatrix,
) -> MlregresslinearMatrix {
  let result = ml_regress_linear_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MlregresslinearMatrix::add(
  self : MlregresslinearMatrix,
  other : MlregresslinearMatrix,
) -> MlregresslinearMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ml_regress_linear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MlregresslinearMatrix::scale(
  self : MlregresslinearMatrix,
  s : Double,
) -> MlregresslinearMatrix {
  let result = ml_regress_linear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MlregresslinearMatrix::multiply(
  self : MlregresslinearMatrix,
  other : MlregresslinearMatrix,
) -> MlregresslinearMatrix {
  if self.cols != other.rows {
    return ml_regress_linear_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ml_regress_linear_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MlregresslinearMatrix::trace(self : MlregresslinearMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MlregresslinearMatrix::det(self : MlregresslinearMatrix) -> Double {
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
pub fn MlregresslinearMatrix::norm(self : MlregresslinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MlregresslinearMatrix::to_string(self : MlregresslinearMatrix) -> String {
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
pub(all) struct MlregresslinearVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ml_regress_linear_make_vector(
  comps : Array[Double],
) -> MlregresslinearVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ml_regress_linear_vector_zero(dim : Int32) -> MlregresslinearVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MlregresslinearVector::add(
  self : MlregresslinearVector,
  other : MlregresslinearVector,
) -> MlregresslinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlregresslinearVector::sub(
  self : MlregresslinearVector,
  other : MlregresslinearVector,
) -> MlregresslinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlregresslinearVector::scale(
  self : MlregresslinearVector,
  s : Double,
) -> MlregresslinearVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MlregresslinearVector::dot(
  self : MlregresslinearVector,
  other : MlregresslinearVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MlregresslinearVector::norm(self : MlregresslinearVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MlregresslinearVector::normalize(
  self : MlregresslinearVector,
) -> MlregresslinearVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlregresslinearVector::dist(
  self : MlregresslinearVector,
  other : MlregresslinearVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MlregresslinearVector::to_string(self : MlregresslinearVector) -> String {
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
pub(all) struct MlregresslinearFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_frame_make(size : Int32) -> MlregresslinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearFrame::len(self : MlregresslinearFrame) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearFrame::get(
  self : MlregresslinearFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearFrame::set(
  self : MlregresslinearFrame,
  i : Int32,
  v : Double,
) -> MlregresslinearFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearFrame::sum(self : MlregresslinearFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearFrame::mean(self : MlregresslinearFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearFrame::scale(
  self : MlregresslinearFrame,
  f : Double,
) -> MlregresslinearFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearFrame::add(
  self : MlregresslinearFrame,
  other : MlregresslinearFrame,
) -> MlregresslinearFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearFrame::copy(
  self : MlregresslinearFrame,
) -> MlregresslinearFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearFrame::fill(
  self : MlregresslinearFrame,
  v : Double,
) -> MlregresslinearFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearFrame::min(self : MlregresslinearFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearFrame::max(self : MlregresslinearFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearFrame::to_string(self : MlregresslinearFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_table_make(size : Int32) -> MlregresslinearTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearTable::len(self : MlregresslinearTable) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearTable::get(
  self : MlregresslinearTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearTable::set(
  self : MlregresslinearTable,
  i : Int32,
  v : Double,
) -> MlregresslinearTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearTable::sum(self : MlregresslinearTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearTable::mean(self : MlregresslinearTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearTable::scale(
  self : MlregresslinearTable,
  f : Double,
) -> MlregresslinearTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearTable::add(
  self : MlregresslinearTable,
  other : MlregresslinearTable,
) -> MlregresslinearTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearTable::copy(
  self : MlregresslinearTable,
) -> MlregresslinearTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearTable::fill(
  self : MlregresslinearTable,
  v : Double,
) -> MlregresslinearTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearTable::min(self : MlregresslinearTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearTable::max(self : MlregresslinearTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearTable::to_string(self : MlregresslinearTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_graphn_make(size : Int32) -> MlregresslinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearGraphN::len(self : MlregresslinearGraphN) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearGraphN::get(
  self : MlregresslinearGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearGraphN::set(
  self : MlregresslinearGraphN,
  i : Int32,
  v : Double,
) -> MlregresslinearGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearGraphN::sum(self : MlregresslinearGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearGraphN::mean(self : MlregresslinearGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearGraphN::scale(
  self : MlregresslinearGraphN,
  f : Double,
) -> MlregresslinearGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearGraphN::add(
  self : MlregresslinearGraphN,
  other : MlregresslinearGraphN,
) -> MlregresslinearGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearGraphN::copy(
  self : MlregresslinearGraphN,
) -> MlregresslinearGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearGraphN::fill(
  self : MlregresslinearGraphN,
  v : Double,
) -> MlregresslinearGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearGraphN::min(self : MlregresslinearGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearGraphN::max(self : MlregresslinearGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearGraphN::to_string(self : MlregresslinearGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_node_make(size : Int32) -> MlregresslinearNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearNode::len(self : MlregresslinearNode) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearNode::get(
  self : MlregresslinearNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearNode::set(
  self : MlregresslinearNode,
  i : Int32,
  v : Double,
) -> MlregresslinearNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearNode::sum(self : MlregresslinearNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearNode::mean(self : MlregresslinearNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearNode::scale(
  self : MlregresslinearNode,
  f : Double,
) -> MlregresslinearNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearNode::add(
  self : MlregresslinearNode,
  other : MlregresslinearNode,
) -> MlregresslinearNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearNode::copy(
  self : MlregresslinearNode,
) -> MlregresslinearNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearNode::fill(
  self : MlregresslinearNode,
  v : Double,
) -> MlregresslinearNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearNode::min(self : MlregresslinearNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearNode::max(self : MlregresslinearNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearNode::to_string(self : MlregresslinearNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_edge_make(size : Int32) -> MlregresslinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearEdge::len(self : MlregresslinearEdge) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearEdge::get(
  self : MlregresslinearEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearEdge::set(
  self : MlregresslinearEdge,
  i : Int32,
  v : Double,
) -> MlregresslinearEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearEdge::sum(self : MlregresslinearEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearEdge::mean(self : MlregresslinearEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearEdge::scale(
  self : MlregresslinearEdge,
  f : Double,
) -> MlregresslinearEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearEdge::add(
  self : MlregresslinearEdge,
  other : MlregresslinearEdge,
) -> MlregresslinearEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearEdge::copy(
  self : MlregresslinearEdge,
) -> MlregresslinearEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearEdge::fill(
  self : MlregresslinearEdge,
  v : Double,
) -> MlregresslinearEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearEdge::min(self : MlregresslinearEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearEdge::max(self : MlregresslinearEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearEdge::to_string(self : MlregresslinearEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_path_make(size : Int32) -> MlregresslinearPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearPath::len(self : MlregresslinearPath) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearPath::get(
  self : MlregresslinearPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearPath::set(
  self : MlregresslinearPath,
  i : Int32,
  v : Double,
) -> MlregresslinearPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearPath::sum(self : MlregresslinearPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearPath::mean(self : MlregresslinearPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearPath::scale(
  self : MlregresslinearPath,
  f : Double,
) -> MlregresslinearPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearPath::add(
  self : MlregresslinearPath,
  other : MlregresslinearPath,
) -> MlregresslinearPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearPath::copy(
  self : MlregresslinearPath,
) -> MlregresslinearPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearPath::fill(
  self : MlregresslinearPath,
  v : Double,
) -> MlregresslinearPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearPath::min(self : MlregresslinearPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearPath::max(self : MlregresslinearPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearPath::to_string(self : MlregresslinearPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_cluster_make(size : Int32) -> MlregresslinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearCluster::len(self : MlregresslinearCluster) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearCluster::get(
  self : MlregresslinearCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearCluster::set(
  self : MlregresslinearCluster,
  i : Int32,
  v : Double,
) -> MlregresslinearCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearCluster::sum(self : MlregresslinearCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearCluster::mean(self : MlregresslinearCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearCluster::scale(
  self : MlregresslinearCluster,
  f : Double,
) -> MlregresslinearCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearCluster::add(
  self : MlregresslinearCluster,
  other : MlregresslinearCluster,
) -> MlregresslinearCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearCluster::copy(
  self : MlregresslinearCluster,
) -> MlregresslinearCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearCluster::fill(
  self : MlregresslinearCluster,
  v : Double,
) -> MlregresslinearCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearCluster::min(self : MlregresslinearCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearCluster::max(self : MlregresslinearCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearCluster::to_string(
  self : MlregresslinearCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_model_make(size : Int32) -> MlregresslinearModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearModel::len(self : MlregresslinearModel) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearModel::get(
  self : MlregresslinearModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearModel::set(
  self : MlregresslinearModel,
  i : Int32,
  v : Double,
) -> MlregresslinearModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearModel::sum(self : MlregresslinearModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearModel::mean(self : MlregresslinearModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearModel::scale(
  self : MlregresslinearModel,
  f : Double,
) -> MlregresslinearModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearModel::add(
  self : MlregresslinearModel,
  other : MlregresslinearModel,
) -> MlregresslinearModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearModel::copy(
  self : MlregresslinearModel,
) -> MlregresslinearModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearModel::fill(
  self : MlregresslinearModel,
  v : Double,
) -> MlregresslinearModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearModel::min(self : MlregresslinearModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearModel::max(self : MlregresslinearModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearModel::to_string(self : MlregresslinearModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_layer_make(size : Int32) -> MlregresslinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearLayer::len(self : MlregresslinearLayer) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearLayer::get(
  self : MlregresslinearLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearLayer::set(
  self : MlregresslinearLayer,
  i : Int32,
  v : Double,
) -> MlregresslinearLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearLayer::sum(self : MlregresslinearLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearLayer::mean(self : MlregresslinearLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearLayer::scale(
  self : MlregresslinearLayer,
  f : Double,
) -> MlregresslinearLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearLayer::add(
  self : MlregresslinearLayer,
  other : MlregresslinearLayer,
) -> MlregresslinearLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearLayer::copy(
  self : MlregresslinearLayer,
) -> MlregresslinearLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearLayer::fill(
  self : MlregresslinearLayer,
  v : Double,
) -> MlregresslinearLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearLayer::min(self : MlregresslinearLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearLayer::max(self : MlregresslinearLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearLayer::to_string(self : MlregresslinearLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_buffer_make(size : Int32) -> MlregresslinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearBuffer::len(self : MlregresslinearBuffer) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearBuffer::get(
  self : MlregresslinearBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearBuffer::set(
  self : MlregresslinearBuffer,
  i : Int32,
  v : Double,
) -> MlregresslinearBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearBuffer::sum(self : MlregresslinearBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearBuffer::mean(self : MlregresslinearBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearBuffer::scale(
  self : MlregresslinearBuffer,
  f : Double,
) -> MlregresslinearBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearBuffer::add(
  self : MlregresslinearBuffer,
  other : MlregresslinearBuffer,
) -> MlregresslinearBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearBuffer::copy(
  self : MlregresslinearBuffer,
) -> MlregresslinearBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearBuffer::fill(
  self : MlregresslinearBuffer,
  v : Double,
) -> MlregresslinearBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearBuffer::min(self : MlregresslinearBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearBuffer::max(self : MlregresslinearBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearBuffer::to_string(self : MlregresslinearBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_cursor_make(size : Int32) -> MlregresslinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearCursor::len(self : MlregresslinearCursor) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearCursor::get(
  self : MlregresslinearCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearCursor::set(
  self : MlregresslinearCursor,
  i : Int32,
  v : Double,
) -> MlregresslinearCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearCursor::sum(self : MlregresslinearCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearCursor::mean(self : MlregresslinearCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearCursor::scale(
  self : MlregresslinearCursor,
  f : Double,
) -> MlregresslinearCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearCursor::add(
  self : MlregresslinearCursor,
  other : MlregresslinearCursor,
) -> MlregresslinearCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearCursor::copy(
  self : MlregresslinearCursor,
) -> MlregresslinearCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearCursor::fill(
  self : MlregresslinearCursor,
  v : Double,
) -> MlregresslinearCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearCursor::min(self : MlregresslinearCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearCursor::max(self : MlregresslinearCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearCursor::to_string(self : MlregresslinearCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_view_make(size : Int32) -> MlregresslinearView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearView::len(self : MlregresslinearView) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearView::get(
  self : MlregresslinearView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearView::set(
  self : MlregresslinearView,
  i : Int32,
  v : Double,
) -> MlregresslinearView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearView::sum(self : MlregresslinearView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearView::mean(self : MlregresslinearView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearView::scale(
  self : MlregresslinearView,
  f : Double,
) -> MlregresslinearView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearView::add(
  self : MlregresslinearView,
  other : MlregresslinearView,
) -> MlregresslinearView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearView::copy(
  self : MlregresslinearView,
) -> MlregresslinearView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearView::fill(
  self : MlregresslinearView,
  v : Double,
) -> MlregresslinearView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearView::min(self : MlregresslinearView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearView::max(self : MlregresslinearView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearView::to_string(self : MlregresslinearView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_range_make(size : Int32) -> MlregresslinearRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearRange::len(self : MlregresslinearRange) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearRange::get(
  self : MlregresslinearRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearRange::set(
  self : MlregresslinearRange,
  i : Int32,
  v : Double,
) -> MlregresslinearRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearRange::sum(self : MlregresslinearRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearRange::mean(self : MlregresslinearRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearRange::scale(
  self : MlregresslinearRange,
  f : Double,
) -> MlregresslinearRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearRange::add(
  self : MlregresslinearRange,
  other : MlregresslinearRange,
) -> MlregresslinearRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearRange::copy(
  self : MlregresslinearRange,
) -> MlregresslinearRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearRange::fill(
  self : MlregresslinearRange,
  v : Double,
) -> MlregresslinearRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearRange::min(self : MlregresslinearRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearRange::max(self : MlregresslinearRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearRange::to_string(self : MlregresslinearRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlregresslinearSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_regress_linear_slice_make(size : Int32) -> MlregresslinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlregresslinearSlice::len(self : MlregresslinearSlice) -> Int32 {
  self.size
}

///|
pub fn MlregresslinearSlice::get(
  self : MlregresslinearSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlregresslinearSlice::set(
  self : MlregresslinearSlice,
  i : Int32,
  v : Double,
) -> MlregresslinearSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearSlice::sum(self : MlregresslinearSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlregresslinearSlice::mean(self : MlregresslinearSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlregresslinearSlice::scale(
  self : MlregresslinearSlice,
  f : Double,
) -> MlregresslinearSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearSlice::add(
  self : MlregresslinearSlice,
  other : MlregresslinearSlice,
) -> MlregresslinearSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlregresslinearSlice::copy(
  self : MlregresslinearSlice,
) -> MlregresslinearSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearSlice::fill(
  self : MlregresslinearSlice,
  v : Double,
) -> MlregresslinearSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlregresslinearSlice::min(self : MlregresslinearSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlregresslinearSlice::max(self : MlregresslinearSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlregresslinearSlice::to_string(self : MlregresslinearSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
