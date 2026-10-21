///|
///===
/// extcore/ds_hash_hopscotch
pub(all) struct DshashhopscotchPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ds_hash_hopscotch_make_point(
  x : Double,
  y : Double,
) -> DshashhopscotchPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ds_hash_hopscotch_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DshashhopscotchPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DshashhopscotchPoint::x(self : DshashhopscotchPoint) -> Double {
  self.x
}

///|
pub fn DshashhopscotchPoint::y(self : DshashhopscotchPoint) -> Double {
  self.y
}

///|
pub fn DshashhopscotchPoint::z(self : DshashhopscotchPoint) -> Double {
  self.z
}

///|
pub fn DshashhopscotchPoint::label(self : DshashhopscotchPoint) -> Int32 {
  self.label
}

///|
pub fn DshashhopscotchPoint::dist(
  self : DshashhopscotchPoint,
  other : DshashhopscotchPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DshashhopscotchPoint::add(
  self : DshashhopscotchPoint,
  other : DshashhopscotchPoint,
) -> DshashhopscotchPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DshashhopscotchPoint::sub(
  self : DshashhopscotchPoint,
  other : DshashhopscotchPoint,
) -> DshashhopscotchPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DshashhopscotchPoint::scale(
  self : DshashhopscotchPoint,
  s : Double,
) -> DshashhopscotchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DshashhopscotchPoint::dot(
  self : DshashhopscotchPoint,
  other : DshashhopscotchPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DshashhopscotchPoint::cross(
  self : DshashhopscotchPoint,
  other : DshashhopscotchPoint,
) -> DshashhopscotchPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DshashhopscotchPoint::norm(self : DshashhopscotchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DshashhopscotchPoint::normalize(
  self : DshashhopscotchPoint,
) -> DshashhopscotchPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DshashhopscotchPoint::negate(
  self : DshashhopscotchPoint,
) -> DshashhopscotchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DshashhopscotchPoint::mid(
  self : DshashhopscotchPoint,
  other : DshashhopscotchPoint,
) -> DshashhopscotchPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DshashhopscotchPoint::lerp(
  self : DshashhopscotchPoint,
  other : DshashhopscotchPoint,
  t : Double,
) -> DshashhopscotchPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DshashhopscotchPoint::to_string(self : DshashhopscotchPoint) -> String {
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
pub(all) struct DshashhopscotchSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ds_hash_hopscotch_make_series(
  vals : Array[Double],
  name : String,
) -> DshashhopscotchSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DshashhopscotchSeries::len(self : DshashhopscotchSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DshashhopscotchSeries::sum(self : DshashhopscotchSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DshashhopscotchSeries::mean(self : DshashhopscotchSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DshashhopscotchSeries::min(self : DshashhopscotchSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DshashhopscotchSeries::max(self : DshashhopscotchSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DshashhopscotchSeries::range(self : DshashhopscotchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DshashhopscotchSeries::variance(self : DshashhopscotchSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DshashhopscotchSeries::std(self : DshashhopscotchSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DshashhopscotchSeries::median(self : DshashhopscotchSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DshashhopscotchSeries::scale(
  self : DshashhopscotchSeries,
  f : Double,
) -> DshashhopscotchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DshashhopscotchSeries::add(
  self : DshashhopscotchSeries,
  other : DshashhopscotchSeries,
) -> DshashhopscotchSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DshashhopscotchSeries::sub(
  self : DshashhopscotchSeries,
  other : DshashhopscotchSeries,
) -> DshashhopscotchSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DshashhopscotchSeries::normalize(
  self : DshashhopscotchSeries,
) -> DshashhopscotchSeries {
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
pub fn DshashhopscotchSeries::cumsum(
  self : DshashhopscotchSeries,
) -> DshashhopscotchSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DshashhopscotchSeries::to_string(self : DshashhopscotchSeries) -> String {
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
pub(all) struct DshashhopscotchMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ds_hash_hopscotch_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DshashhopscotchMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ds_hash_hopscotch_matrix_identity(n : Int32) -> DshashhopscotchMatrix {
  let m = ds_hash_hopscotch_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DshashhopscotchMatrix::get(
  self : DshashhopscotchMatrix,
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
pub fn DshashhopscotchMatrix::transpose(
  self : DshashhopscotchMatrix,
) -> DshashhopscotchMatrix {
  let result = ds_hash_hopscotch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DshashhopscotchMatrix::add(
  self : DshashhopscotchMatrix,
  other : DshashhopscotchMatrix,
) -> DshashhopscotchMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ds_hash_hopscotch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DshashhopscotchMatrix::scale(
  self : DshashhopscotchMatrix,
  s : Double,
) -> DshashhopscotchMatrix {
  let result = ds_hash_hopscotch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DshashhopscotchMatrix::multiply(
  self : DshashhopscotchMatrix,
  other : DshashhopscotchMatrix,
) -> DshashhopscotchMatrix {
  if self.cols != other.rows {
    return ds_hash_hopscotch_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ds_hash_hopscotch_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DshashhopscotchMatrix::trace(self : DshashhopscotchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DshashhopscotchMatrix::det(self : DshashhopscotchMatrix) -> Double {
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
pub fn DshashhopscotchMatrix::norm(self : DshashhopscotchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DshashhopscotchMatrix::to_string(self : DshashhopscotchMatrix) -> String {
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
pub(all) struct DshashhopscotchVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ds_hash_hopscotch_make_vector(
  comps : Array[Double],
) -> DshashhopscotchVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ds_hash_hopscotch_vector_zero(dim : Int32) -> DshashhopscotchVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DshashhopscotchVector::add(
  self : DshashhopscotchVector,
  other : DshashhopscotchVector,
) -> DshashhopscotchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DshashhopscotchVector::sub(
  self : DshashhopscotchVector,
  other : DshashhopscotchVector,
) -> DshashhopscotchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DshashhopscotchVector::scale(
  self : DshashhopscotchVector,
  s : Double,
) -> DshashhopscotchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DshashhopscotchVector::dot(
  self : DshashhopscotchVector,
  other : DshashhopscotchVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DshashhopscotchVector::norm(self : DshashhopscotchVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DshashhopscotchVector::normalize(
  self : DshashhopscotchVector,
) -> DshashhopscotchVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DshashhopscotchVector::dist(
  self : DshashhopscotchVector,
  other : DshashhopscotchVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DshashhopscotchVector::to_string(self : DshashhopscotchVector) -> String {
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
pub(all) struct DshashhopscotchFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_frame_make(size : Int32) -> DshashhopscotchFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchFrame::len(self : DshashhopscotchFrame) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchFrame::get(
  self : DshashhopscotchFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchFrame::set(
  self : DshashhopscotchFrame,
  i : Int32,
  v : Double,
) -> DshashhopscotchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchFrame::sum(self : DshashhopscotchFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchFrame::mean(self : DshashhopscotchFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchFrame::scale(
  self : DshashhopscotchFrame,
  f : Double,
) -> DshashhopscotchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchFrame::add(
  self : DshashhopscotchFrame,
  other : DshashhopscotchFrame,
) -> DshashhopscotchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchFrame::copy(
  self : DshashhopscotchFrame,
) -> DshashhopscotchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchFrame::fill(
  self : DshashhopscotchFrame,
  v : Double,
) -> DshashhopscotchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchFrame::min(self : DshashhopscotchFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchFrame::max(self : DshashhopscotchFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchFrame::to_string(self : DshashhopscotchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_table_make(size : Int32) -> DshashhopscotchTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchTable::len(self : DshashhopscotchTable) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchTable::get(
  self : DshashhopscotchTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchTable::set(
  self : DshashhopscotchTable,
  i : Int32,
  v : Double,
) -> DshashhopscotchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchTable::sum(self : DshashhopscotchTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchTable::mean(self : DshashhopscotchTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchTable::scale(
  self : DshashhopscotchTable,
  f : Double,
) -> DshashhopscotchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchTable::add(
  self : DshashhopscotchTable,
  other : DshashhopscotchTable,
) -> DshashhopscotchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchTable::copy(
  self : DshashhopscotchTable,
) -> DshashhopscotchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchTable::fill(
  self : DshashhopscotchTable,
  v : Double,
) -> DshashhopscotchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchTable::min(self : DshashhopscotchTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchTable::max(self : DshashhopscotchTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchTable::to_string(self : DshashhopscotchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_graphn_make(size : Int32) -> DshashhopscotchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchGraphN::len(self : DshashhopscotchGraphN) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchGraphN::get(
  self : DshashhopscotchGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchGraphN::set(
  self : DshashhopscotchGraphN,
  i : Int32,
  v : Double,
) -> DshashhopscotchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchGraphN::sum(self : DshashhopscotchGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchGraphN::mean(self : DshashhopscotchGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchGraphN::scale(
  self : DshashhopscotchGraphN,
  f : Double,
) -> DshashhopscotchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchGraphN::add(
  self : DshashhopscotchGraphN,
  other : DshashhopscotchGraphN,
) -> DshashhopscotchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchGraphN::copy(
  self : DshashhopscotchGraphN,
) -> DshashhopscotchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchGraphN::fill(
  self : DshashhopscotchGraphN,
  v : Double,
) -> DshashhopscotchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchGraphN::min(self : DshashhopscotchGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchGraphN::max(self : DshashhopscotchGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchGraphN::to_string(self : DshashhopscotchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_node_make(size : Int32) -> DshashhopscotchNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchNode::len(self : DshashhopscotchNode) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchNode::get(
  self : DshashhopscotchNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchNode::set(
  self : DshashhopscotchNode,
  i : Int32,
  v : Double,
) -> DshashhopscotchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchNode::sum(self : DshashhopscotchNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchNode::mean(self : DshashhopscotchNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchNode::scale(
  self : DshashhopscotchNode,
  f : Double,
) -> DshashhopscotchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchNode::add(
  self : DshashhopscotchNode,
  other : DshashhopscotchNode,
) -> DshashhopscotchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchNode::copy(
  self : DshashhopscotchNode,
) -> DshashhopscotchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchNode::fill(
  self : DshashhopscotchNode,
  v : Double,
) -> DshashhopscotchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchNode::min(self : DshashhopscotchNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchNode::max(self : DshashhopscotchNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchNode::to_string(self : DshashhopscotchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_edge_make(size : Int32) -> DshashhopscotchEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchEdge::len(self : DshashhopscotchEdge) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchEdge::get(
  self : DshashhopscotchEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchEdge::set(
  self : DshashhopscotchEdge,
  i : Int32,
  v : Double,
) -> DshashhopscotchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchEdge::sum(self : DshashhopscotchEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchEdge::mean(self : DshashhopscotchEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchEdge::scale(
  self : DshashhopscotchEdge,
  f : Double,
) -> DshashhopscotchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchEdge::add(
  self : DshashhopscotchEdge,
  other : DshashhopscotchEdge,
) -> DshashhopscotchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchEdge::copy(
  self : DshashhopscotchEdge,
) -> DshashhopscotchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchEdge::fill(
  self : DshashhopscotchEdge,
  v : Double,
) -> DshashhopscotchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchEdge::min(self : DshashhopscotchEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchEdge::max(self : DshashhopscotchEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchEdge::to_string(self : DshashhopscotchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_path_make(size : Int32) -> DshashhopscotchPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchPath::len(self : DshashhopscotchPath) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchPath::get(
  self : DshashhopscotchPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchPath::set(
  self : DshashhopscotchPath,
  i : Int32,
  v : Double,
) -> DshashhopscotchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchPath::sum(self : DshashhopscotchPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchPath::mean(self : DshashhopscotchPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchPath::scale(
  self : DshashhopscotchPath,
  f : Double,
) -> DshashhopscotchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchPath::add(
  self : DshashhopscotchPath,
  other : DshashhopscotchPath,
) -> DshashhopscotchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchPath::copy(
  self : DshashhopscotchPath,
) -> DshashhopscotchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchPath::fill(
  self : DshashhopscotchPath,
  v : Double,
) -> DshashhopscotchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchPath::min(self : DshashhopscotchPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchPath::max(self : DshashhopscotchPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchPath::to_string(self : DshashhopscotchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_cluster_make(size : Int32) -> DshashhopscotchCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchCluster::len(self : DshashhopscotchCluster) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchCluster::get(
  self : DshashhopscotchCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchCluster::set(
  self : DshashhopscotchCluster,
  i : Int32,
  v : Double,
) -> DshashhopscotchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchCluster::sum(self : DshashhopscotchCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchCluster::mean(self : DshashhopscotchCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchCluster::scale(
  self : DshashhopscotchCluster,
  f : Double,
) -> DshashhopscotchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchCluster::add(
  self : DshashhopscotchCluster,
  other : DshashhopscotchCluster,
) -> DshashhopscotchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchCluster::copy(
  self : DshashhopscotchCluster,
) -> DshashhopscotchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchCluster::fill(
  self : DshashhopscotchCluster,
  v : Double,
) -> DshashhopscotchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchCluster::min(self : DshashhopscotchCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchCluster::max(self : DshashhopscotchCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchCluster::to_string(
  self : DshashhopscotchCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_model_make(size : Int32) -> DshashhopscotchModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchModel::len(self : DshashhopscotchModel) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchModel::get(
  self : DshashhopscotchModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchModel::set(
  self : DshashhopscotchModel,
  i : Int32,
  v : Double,
) -> DshashhopscotchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchModel::sum(self : DshashhopscotchModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchModel::mean(self : DshashhopscotchModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchModel::scale(
  self : DshashhopscotchModel,
  f : Double,
) -> DshashhopscotchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchModel::add(
  self : DshashhopscotchModel,
  other : DshashhopscotchModel,
) -> DshashhopscotchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchModel::copy(
  self : DshashhopscotchModel,
) -> DshashhopscotchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchModel::fill(
  self : DshashhopscotchModel,
  v : Double,
) -> DshashhopscotchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchModel::min(self : DshashhopscotchModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchModel::max(self : DshashhopscotchModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchModel::to_string(self : DshashhopscotchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_layer_make(size : Int32) -> DshashhopscotchLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchLayer::len(self : DshashhopscotchLayer) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchLayer::get(
  self : DshashhopscotchLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchLayer::set(
  self : DshashhopscotchLayer,
  i : Int32,
  v : Double,
) -> DshashhopscotchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchLayer::sum(self : DshashhopscotchLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchLayer::mean(self : DshashhopscotchLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchLayer::scale(
  self : DshashhopscotchLayer,
  f : Double,
) -> DshashhopscotchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchLayer::add(
  self : DshashhopscotchLayer,
  other : DshashhopscotchLayer,
) -> DshashhopscotchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchLayer::copy(
  self : DshashhopscotchLayer,
) -> DshashhopscotchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchLayer::fill(
  self : DshashhopscotchLayer,
  v : Double,
) -> DshashhopscotchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchLayer::min(self : DshashhopscotchLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchLayer::max(self : DshashhopscotchLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchLayer::to_string(self : DshashhopscotchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_buffer_make(size : Int32) -> DshashhopscotchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchBuffer::len(self : DshashhopscotchBuffer) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchBuffer::get(
  self : DshashhopscotchBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchBuffer::set(
  self : DshashhopscotchBuffer,
  i : Int32,
  v : Double,
) -> DshashhopscotchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchBuffer::sum(self : DshashhopscotchBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchBuffer::mean(self : DshashhopscotchBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchBuffer::scale(
  self : DshashhopscotchBuffer,
  f : Double,
) -> DshashhopscotchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchBuffer::add(
  self : DshashhopscotchBuffer,
  other : DshashhopscotchBuffer,
) -> DshashhopscotchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchBuffer::copy(
  self : DshashhopscotchBuffer,
) -> DshashhopscotchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchBuffer::fill(
  self : DshashhopscotchBuffer,
  v : Double,
) -> DshashhopscotchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchBuffer::min(self : DshashhopscotchBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchBuffer::max(self : DshashhopscotchBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchBuffer::to_string(self : DshashhopscotchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_cursor_make(size : Int32) -> DshashhopscotchCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchCursor::len(self : DshashhopscotchCursor) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchCursor::get(
  self : DshashhopscotchCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchCursor::set(
  self : DshashhopscotchCursor,
  i : Int32,
  v : Double,
) -> DshashhopscotchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchCursor::sum(self : DshashhopscotchCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchCursor::mean(self : DshashhopscotchCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchCursor::scale(
  self : DshashhopscotchCursor,
  f : Double,
) -> DshashhopscotchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchCursor::add(
  self : DshashhopscotchCursor,
  other : DshashhopscotchCursor,
) -> DshashhopscotchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchCursor::copy(
  self : DshashhopscotchCursor,
) -> DshashhopscotchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchCursor::fill(
  self : DshashhopscotchCursor,
  v : Double,
) -> DshashhopscotchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchCursor::min(self : DshashhopscotchCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchCursor::max(self : DshashhopscotchCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchCursor::to_string(self : DshashhopscotchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_view_make(size : Int32) -> DshashhopscotchView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchView::len(self : DshashhopscotchView) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchView::get(
  self : DshashhopscotchView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchView::set(
  self : DshashhopscotchView,
  i : Int32,
  v : Double,
) -> DshashhopscotchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchView::sum(self : DshashhopscotchView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchView::mean(self : DshashhopscotchView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchView::scale(
  self : DshashhopscotchView,
  f : Double,
) -> DshashhopscotchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchView::add(
  self : DshashhopscotchView,
  other : DshashhopscotchView,
) -> DshashhopscotchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchView::copy(
  self : DshashhopscotchView,
) -> DshashhopscotchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchView::fill(
  self : DshashhopscotchView,
  v : Double,
) -> DshashhopscotchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchView::min(self : DshashhopscotchView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchView::max(self : DshashhopscotchView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchView::to_string(self : DshashhopscotchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_range_make(size : Int32) -> DshashhopscotchRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchRange::len(self : DshashhopscotchRange) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchRange::get(
  self : DshashhopscotchRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchRange::set(
  self : DshashhopscotchRange,
  i : Int32,
  v : Double,
) -> DshashhopscotchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchRange::sum(self : DshashhopscotchRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchRange::mean(self : DshashhopscotchRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchRange::scale(
  self : DshashhopscotchRange,
  f : Double,
) -> DshashhopscotchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchRange::add(
  self : DshashhopscotchRange,
  other : DshashhopscotchRange,
) -> DshashhopscotchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchRange::copy(
  self : DshashhopscotchRange,
) -> DshashhopscotchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchRange::fill(
  self : DshashhopscotchRange,
  v : Double,
) -> DshashhopscotchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchRange::min(self : DshashhopscotchRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchRange::max(self : DshashhopscotchRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchRange::to_string(self : DshashhopscotchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashhopscotchSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_hopscotch_slice_make(size : Int32) -> DshashhopscotchSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashhopscotchSlice::len(self : DshashhopscotchSlice) -> Int32 {
  self.size
}

///|
pub fn DshashhopscotchSlice::get(
  self : DshashhopscotchSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashhopscotchSlice::set(
  self : DshashhopscotchSlice,
  i : Int32,
  v : Double,
) -> DshashhopscotchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchSlice::sum(self : DshashhopscotchSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashhopscotchSlice::mean(self : DshashhopscotchSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashhopscotchSlice::scale(
  self : DshashhopscotchSlice,
  f : Double,
) -> DshashhopscotchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchSlice::add(
  self : DshashhopscotchSlice,
  other : DshashhopscotchSlice,
) -> DshashhopscotchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashhopscotchSlice::copy(
  self : DshashhopscotchSlice,
) -> DshashhopscotchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchSlice::fill(
  self : DshashhopscotchSlice,
  v : Double,
) -> DshashhopscotchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashhopscotchSlice::min(self : DshashhopscotchSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashhopscotchSlice::max(self : DshashhopscotchSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashhopscotchSlice::to_string(self : DshashhopscotchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
