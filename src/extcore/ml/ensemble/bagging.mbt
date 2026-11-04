///|
///===
/// extcore/ml_ensemble_bagging
pub(all) struct MlensemblebaggingPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ml_ensemble_bagging_make_point(
  x : Double,
  y : Double,
) -> MlensemblebaggingPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ml_ensemble_bagging_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MlensemblebaggingPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MlensemblebaggingPoint::x(self : MlensemblebaggingPoint) -> Double {
  self.x
}

///|
pub fn MlensemblebaggingPoint::y(self : MlensemblebaggingPoint) -> Double {
  self.y
}

///|
pub fn MlensemblebaggingPoint::z(self : MlensemblebaggingPoint) -> Double {
  self.z
}

///|
pub fn MlensemblebaggingPoint::label(self : MlensemblebaggingPoint) -> Int32 {
  self.label
}

///|
pub fn MlensemblebaggingPoint::dist(
  self : MlensemblebaggingPoint,
  other : MlensemblebaggingPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MlensemblebaggingPoint::add(
  self : MlensemblebaggingPoint,
  other : MlensemblebaggingPoint,
) -> MlensemblebaggingPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MlensemblebaggingPoint::sub(
  self : MlensemblebaggingPoint,
  other : MlensemblebaggingPoint,
) -> MlensemblebaggingPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MlensemblebaggingPoint::scale(
  self : MlensemblebaggingPoint,
  s : Double,
) -> MlensemblebaggingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MlensemblebaggingPoint::dot(
  self : MlensemblebaggingPoint,
  other : MlensemblebaggingPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MlensemblebaggingPoint::cross(
  self : MlensemblebaggingPoint,
  other : MlensemblebaggingPoint,
) -> MlensemblebaggingPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MlensemblebaggingPoint::norm(self : MlensemblebaggingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MlensemblebaggingPoint::normalize(
  self : MlensemblebaggingPoint,
) -> MlensemblebaggingPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlensemblebaggingPoint::negate(
  self : MlensemblebaggingPoint,
) -> MlensemblebaggingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MlensemblebaggingPoint::mid(
  self : MlensemblebaggingPoint,
  other : MlensemblebaggingPoint,
) -> MlensemblebaggingPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MlensemblebaggingPoint::lerp(
  self : MlensemblebaggingPoint,
  other : MlensemblebaggingPoint,
  t : Double,
) -> MlensemblebaggingPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MlensemblebaggingPoint::to_string(
  self : MlensemblebaggingPoint,
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
pub(all) struct MlensemblebaggingSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ml_ensemble_bagging_make_series(
  vals : Array[Double],
  name : String,
) -> MlensemblebaggingSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MlensemblebaggingSeries::len(self : MlensemblebaggingSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MlensemblebaggingSeries::sum(self : MlensemblebaggingSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MlensemblebaggingSeries::mean(self : MlensemblebaggingSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MlensemblebaggingSeries::min(self : MlensemblebaggingSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MlensemblebaggingSeries::max(self : MlensemblebaggingSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MlensemblebaggingSeries::range(self : MlensemblebaggingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MlensemblebaggingSeries::variance(
  self : MlensemblebaggingSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MlensemblebaggingSeries::std(self : MlensemblebaggingSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MlensemblebaggingSeries::median(
  self : MlensemblebaggingSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MlensemblebaggingSeries::scale(
  self : MlensemblebaggingSeries,
  f : Double,
) -> MlensemblebaggingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MlensemblebaggingSeries::add(
  self : MlensemblebaggingSeries,
  other : MlensemblebaggingSeries,
) -> MlensemblebaggingSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlensemblebaggingSeries::sub(
  self : MlensemblebaggingSeries,
  other : MlensemblebaggingSeries,
) -> MlensemblebaggingSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlensemblebaggingSeries::normalize(
  self : MlensemblebaggingSeries,
) -> MlensemblebaggingSeries {
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
pub fn MlensemblebaggingSeries::cumsum(
  self : MlensemblebaggingSeries,
) -> MlensemblebaggingSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MlensemblebaggingSeries::to_string(
  self : MlensemblebaggingSeries,
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
pub(all) struct MlensemblebaggingMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ml_ensemble_bagging_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MlensemblebaggingMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ml_ensemble_bagging_matrix_identity(
  n : Int32,
) -> MlensemblebaggingMatrix {
  let m = ml_ensemble_bagging_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MlensemblebaggingMatrix::get(
  self : MlensemblebaggingMatrix,
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
pub fn MlensemblebaggingMatrix::transpose(
  self : MlensemblebaggingMatrix,
) -> MlensemblebaggingMatrix {
  let result = ml_ensemble_bagging_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MlensemblebaggingMatrix::add(
  self : MlensemblebaggingMatrix,
  other : MlensemblebaggingMatrix,
) -> MlensemblebaggingMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ml_ensemble_bagging_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MlensemblebaggingMatrix::scale(
  self : MlensemblebaggingMatrix,
  s : Double,
) -> MlensemblebaggingMatrix {
  let result = ml_ensemble_bagging_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MlensemblebaggingMatrix::multiply(
  self : MlensemblebaggingMatrix,
  other : MlensemblebaggingMatrix,
) -> MlensemblebaggingMatrix {
  if self.cols != other.rows {
    return ml_ensemble_bagging_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ml_ensemble_bagging_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MlensemblebaggingMatrix::trace(self : MlensemblebaggingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MlensemblebaggingMatrix::det(self : MlensemblebaggingMatrix) -> Double {
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
pub fn MlensemblebaggingMatrix::norm(self : MlensemblebaggingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MlensemblebaggingMatrix::to_string(
  self : MlensemblebaggingMatrix,
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
pub(all) struct MlensemblebaggingVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ml_ensemble_bagging_make_vector(
  comps : Array[Double],
) -> MlensemblebaggingVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ml_ensemble_bagging_vector_zero(dim : Int32) -> MlensemblebaggingVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MlensemblebaggingVector::add(
  self : MlensemblebaggingVector,
  other : MlensemblebaggingVector,
) -> MlensemblebaggingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlensemblebaggingVector::sub(
  self : MlensemblebaggingVector,
  other : MlensemblebaggingVector,
) -> MlensemblebaggingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlensemblebaggingVector::scale(
  self : MlensemblebaggingVector,
  s : Double,
) -> MlensemblebaggingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MlensemblebaggingVector::dot(
  self : MlensemblebaggingVector,
  other : MlensemblebaggingVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MlensemblebaggingVector::norm(self : MlensemblebaggingVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MlensemblebaggingVector::normalize(
  self : MlensemblebaggingVector,
) -> MlensemblebaggingVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlensemblebaggingVector::dist(
  self : MlensemblebaggingVector,
  other : MlensemblebaggingVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MlensemblebaggingVector::to_string(
  self : MlensemblebaggingVector,
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
pub(all) struct MlensemblebaggingFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_frame_make(size : Int32) -> MlensemblebaggingFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingFrame::len(self : MlensemblebaggingFrame) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingFrame::get(
  self : MlensemblebaggingFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingFrame::set(
  self : MlensemblebaggingFrame,
  i : Int32,
  v : Double,
) -> MlensemblebaggingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingFrame::sum(self : MlensemblebaggingFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingFrame::mean(self : MlensemblebaggingFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingFrame::scale(
  self : MlensemblebaggingFrame,
  f : Double,
) -> MlensemblebaggingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingFrame::add(
  self : MlensemblebaggingFrame,
  other : MlensemblebaggingFrame,
) -> MlensemblebaggingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingFrame::copy(
  self : MlensemblebaggingFrame,
) -> MlensemblebaggingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingFrame::fill(
  self : MlensemblebaggingFrame,
  v : Double,
) -> MlensemblebaggingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingFrame::min(self : MlensemblebaggingFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingFrame::max(self : MlensemblebaggingFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingFrame::to_string(
  self : MlensemblebaggingFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_table_make(size : Int32) -> MlensemblebaggingTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingTable::len(self : MlensemblebaggingTable) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingTable::get(
  self : MlensemblebaggingTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingTable::set(
  self : MlensemblebaggingTable,
  i : Int32,
  v : Double,
) -> MlensemblebaggingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingTable::sum(self : MlensemblebaggingTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingTable::mean(self : MlensemblebaggingTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingTable::scale(
  self : MlensemblebaggingTable,
  f : Double,
) -> MlensemblebaggingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingTable::add(
  self : MlensemblebaggingTable,
  other : MlensemblebaggingTable,
) -> MlensemblebaggingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingTable::copy(
  self : MlensemblebaggingTable,
) -> MlensemblebaggingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingTable::fill(
  self : MlensemblebaggingTable,
  v : Double,
) -> MlensemblebaggingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingTable::min(self : MlensemblebaggingTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingTable::max(self : MlensemblebaggingTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingTable::to_string(
  self : MlensemblebaggingTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_graphn_make(size : Int32) -> MlensemblebaggingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingGraphN::len(self : MlensemblebaggingGraphN) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingGraphN::get(
  self : MlensemblebaggingGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingGraphN::set(
  self : MlensemblebaggingGraphN,
  i : Int32,
  v : Double,
) -> MlensemblebaggingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingGraphN::sum(self : MlensemblebaggingGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingGraphN::mean(self : MlensemblebaggingGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingGraphN::scale(
  self : MlensemblebaggingGraphN,
  f : Double,
) -> MlensemblebaggingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingGraphN::add(
  self : MlensemblebaggingGraphN,
  other : MlensemblebaggingGraphN,
) -> MlensemblebaggingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingGraphN::copy(
  self : MlensemblebaggingGraphN,
) -> MlensemblebaggingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingGraphN::fill(
  self : MlensemblebaggingGraphN,
  v : Double,
) -> MlensemblebaggingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingGraphN::min(self : MlensemblebaggingGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingGraphN::max(self : MlensemblebaggingGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingGraphN::to_string(
  self : MlensemblebaggingGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_node_make(size : Int32) -> MlensemblebaggingNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingNode::len(self : MlensemblebaggingNode) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingNode::get(
  self : MlensemblebaggingNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingNode::set(
  self : MlensemblebaggingNode,
  i : Int32,
  v : Double,
) -> MlensemblebaggingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingNode::sum(self : MlensemblebaggingNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingNode::mean(self : MlensemblebaggingNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingNode::scale(
  self : MlensemblebaggingNode,
  f : Double,
) -> MlensemblebaggingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingNode::add(
  self : MlensemblebaggingNode,
  other : MlensemblebaggingNode,
) -> MlensemblebaggingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingNode::copy(
  self : MlensemblebaggingNode,
) -> MlensemblebaggingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingNode::fill(
  self : MlensemblebaggingNode,
  v : Double,
) -> MlensemblebaggingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingNode::min(self : MlensemblebaggingNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingNode::max(self : MlensemblebaggingNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingNode::to_string(self : MlensemblebaggingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_edge_make(size : Int32) -> MlensemblebaggingEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingEdge::len(self : MlensemblebaggingEdge) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingEdge::get(
  self : MlensemblebaggingEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingEdge::set(
  self : MlensemblebaggingEdge,
  i : Int32,
  v : Double,
) -> MlensemblebaggingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingEdge::sum(self : MlensemblebaggingEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingEdge::mean(self : MlensemblebaggingEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingEdge::scale(
  self : MlensemblebaggingEdge,
  f : Double,
) -> MlensemblebaggingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingEdge::add(
  self : MlensemblebaggingEdge,
  other : MlensemblebaggingEdge,
) -> MlensemblebaggingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingEdge::copy(
  self : MlensemblebaggingEdge,
) -> MlensemblebaggingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingEdge::fill(
  self : MlensemblebaggingEdge,
  v : Double,
) -> MlensemblebaggingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingEdge::min(self : MlensemblebaggingEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingEdge::max(self : MlensemblebaggingEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingEdge::to_string(self : MlensemblebaggingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_path_make(size : Int32) -> MlensemblebaggingPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingPath::len(self : MlensemblebaggingPath) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingPath::get(
  self : MlensemblebaggingPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingPath::set(
  self : MlensemblebaggingPath,
  i : Int32,
  v : Double,
) -> MlensemblebaggingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingPath::sum(self : MlensemblebaggingPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingPath::mean(self : MlensemblebaggingPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingPath::scale(
  self : MlensemblebaggingPath,
  f : Double,
) -> MlensemblebaggingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingPath::add(
  self : MlensemblebaggingPath,
  other : MlensemblebaggingPath,
) -> MlensemblebaggingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingPath::copy(
  self : MlensemblebaggingPath,
) -> MlensemblebaggingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingPath::fill(
  self : MlensemblebaggingPath,
  v : Double,
) -> MlensemblebaggingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingPath::min(self : MlensemblebaggingPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingPath::max(self : MlensemblebaggingPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingPath::to_string(self : MlensemblebaggingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_cluster_make(
  size : Int32,
) -> MlensemblebaggingCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingCluster::len(self : MlensemblebaggingCluster) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingCluster::get(
  self : MlensemblebaggingCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingCluster::set(
  self : MlensemblebaggingCluster,
  i : Int32,
  v : Double,
) -> MlensemblebaggingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingCluster::sum(self : MlensemblebaggingCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingCluster::mean(
  self : MlensemblebaggingCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingCluster::scale(
  self : MlensemblebaggingCluster,
  f : Double,
) -> MlensemblebaggingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingCluster::add(
  self : MlensemblebaggingCluster,
  other : MlensemblebaggingCluster,
) -> MlensemblebaggingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingCluster::copy(
  self : MlensemblebaggingCluster,
) -> MlensemblebaggingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingCluster::fill(
  self : MlensemblebaggingCluster,
  v : Double,
) -> MlensemblebaggingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingCluster::min(self : MlensemblebaggingCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingCluster::max(self : MlensemblebaggingCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingCluster::to_string(
  self : MlensemblebaggingCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_model_make(size : Int32) -> MlensemblebaggingModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingModel::len(self : MlensemblebaggingModel) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingModel::get(
  self : MlensemblebaggingModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingModel::set(
  self : MlensemblebaggingModel,
  i : Int32,
  v : Double,
) -> MlensemblebaggingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingModel::sum(self : MlensemblebaggingModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingModel::mean(self : MlensemblebaggingModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingModel::scale(
  self : MlensemblebaggingModel,
  f : Double,
) -> MlensemblebaggingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingModel::add(
  self : MlensemblebaggingModel,
  other : MlensemblebaggingModel,
) -> MlensemblebaggingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingModel::copy(
  self : MlensemblebaggingModel,
) -> MlensemblebaggingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingModel::fill(
  self : MlensemblebaggingModel,
  v : Double,
) -> MlensemblebaggingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingModel::min(self : MlensemblebaggingModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingModel::max(self : MlensemblebaggingModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingModel::to_string(
  self : MlensemblebaggingModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_layer_make(size : Int32) -> MlensemblebaggingLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingLayer::len(self : MlensemblebaggingLayer) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingLayer::get(
  self : MlensemblebaggingLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingLayer::set(
  self : MlensemblebaggingLayer,
  i : Int32,
  v : Double,
) -> MlensemblebaggingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingLayer::sum(self : MlensemblebaggingLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingLayer::mean(self : MlensemblebaggingLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingLayer::scale(
  self : MlensemblebaggingLayer,
  f : Double,
) -> MlensemblebaggingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingLayer::add(
  self : MlensemblebaggingLayer,
  other : MlensemblebaggingLayer,
) -> MlensemblebaggingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingLayer::copy(
  self : MlensemblebaggingLayer,
) -> MlensemblebaggingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingLayer::fill(
  self : MlensemblebaggingLayer,
  v : Double,
) -> MlensemblebaggingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingLayer::min(self : MlensemblebaggingLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingLayer::max(self : MlensemblebaggingLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingLayer::to_string(
  self : MlensemblebaggingLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_buffer_make(size : Int32) -> MlensemblebaggingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingBuffer::len(self : MlensemblebaggingBuffer) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingBuffer::get(
  self : MlensemblebaggingBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingBuffer::set(
  self : MlensemblebaggingBuffer,
  i : Int32,
  v : Double,
) -> MlensemblebaggingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingBuffer::sum(self : MlensemblebaggingBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingBuffer::mean(self : MlensemblebaggingBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingBuffer::scale(
  self : MlensemblebaggingBuffer,
  f : Double,
) -> MlensemblebaggingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingBuffer::add(
  self : MlensemblebaggingBuffer,
  other : MlensemblebaggingBuffer,
) -> MlensemblebaggingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingBuffer::copy(
  self : MlensemblebaggingBuffer,
) -> MlensemblebaggingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingBuffer::fill(
  self : MlensemblebaggingBuffer,
  v : Double,
) -> MlensemblebaggingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingBuffer::min(self : MlensemblebaggingBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingBuffer::max(self : MlensemblebaggingBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingBuffer::to_string(
  self : MlensemblebaggingBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_cursor_make(size : Int32) -> MlensemblebaggingCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingCursor::len(self : MlensemblebaggingCursor) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingCursor::get(
  self : MlensemblebaggingCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingCursor::set(
  self : MlensemblebaggingCursor,
  i : Int32,
  v : Double,
) -> MlensemblebaggingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingCursor::sum(self : MlensemblebaggingCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingCursor::mean(self : MlensemblebaggingCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingCursor::scale(
  self : MlensemblebaggingCursor,
  f : Double,
) -> MlensemblebaggingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingCursor::add(
  self : MlensemblebaggingCursor,
  other : MlensemblebaggingCursor,
) -> MlensemblebaggingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingCursor::copy(
  self : MlensemblebaggingCursor,
) -> MlensemblebaggingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingCursor::fill(
  self : MlensemblebaggingCursor,
  v : Double,
) -> MlensemblebaggingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingCursor::min(self : MlensemblebaggingCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingCursor::max(self : MlensemblebaggingCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingCursor::to_string(
  self : MlensemblebaggingCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_view_make(size : Int32) -> MlensemblebaggingView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingView::len(self : MlensemblebaggingView) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingView::get(
  self : MlensemblebaggingView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingView::set(
  self : MlensemblebaggingView,
  i : Int32,
  v : Double,
) -> MlensemblebaggingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingView::sum(self : MlensemblebaggingView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingView::mean(self : MlensemblebaggingView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingView::scale(
  self : MlensemblebaggingView,
  f : Double,
) -> MlensemblebaggingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingView::add(
  self : MlensemblebaggingView,
  other : MlensemblebaggingView,
) -> MlensemblebaggingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingView::copy(
  self : MlensemblebaggingView,
) -> MlensemblebaggingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingView::fill(
  self : MlensemblebaggingView,
  v : Double,
) -> MlensemblebaggingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingView::min(self : MlensemblebaggingView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingView::max(self : MlensemblebaggingView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingView::to_string(self : MlensemblebaggingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_range_make(size : Int32) -> MlensemblebaggingRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingRange::len(self : MlensemblebaggingRange) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingRange::get(
  self : MlensemblebaggingRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingRange::set(
  self : MlensemblebaggingRange,
  i : Int32,
  v : Double,
) -> MlensemblebaggingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingRange::sum(self : MlensemblebaggingRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingRange::mean(self : MlensemblebaggingRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingRange::scale(
  self : MlensemblebaggingRange,
  f : Double,
) -> MlensemblebaggingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingRange::add(
  self : MlensemblebaggingRange,
  other : MlensemblebaggingRange,
) -> MlensemblebaggingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingRange::copy(
  self : MlensemblebaggingRange,
) -> MlensemblebaggingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingRange::fill(
  self : MlensemblebaggingRange,
  v : Double,
) -> MlensemblebaggingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingRange::min(self : MlensemblebaggingRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingRange::max(self : MlensemblebaggingRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingRange::to_string(
  self : MlensemblebaggingRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlensemblebaggingSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_ensemble_bagging_slice_make(size : Int32) -> MlensemblebaggingSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlensemblebaggingSlice::len(self : MlensemblebaggingSlice) -> Int32 {
  self.size
}

///|
pub fn MlensemblebaggingSlice::get(
  self : MlensemblebaggingSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlensemblebaggingSlice::set(
  self : MlensemblebaggingSlice,
  i : Int32,
  v : Double,
) -> MlensemblebaggingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingSlice::sum(self : MlensemblebaggingSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlensemblebaggingSlice::mean(self : MlensemblebaggingSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlensemblebaggingSlice::scale(
  self : MlensemblebaggingSlice,
  f : Double,
) -> MlensemblebaggingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingSlice::add(
  self : MlensemblebaggingSlice,
  other : MlensemblebaggingSlice,
) -> MlensemblebaggingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlensemblebaggingSlice::copy(
  self : MlensemblebaggingSlice,
) -> MlensemblebaggingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingSlice::fill(
  self : MlensemblebaggingSlice,
  v : Double,
) -> MlensemblebaggingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlensemblebaggingSlice::min(self : MlensemblebaggingSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlensemblebaggingSlice::max(self : MlensemblebaggingSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlensemblebaggingSlice::to_string(
  self : MlensemblebaggingSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
