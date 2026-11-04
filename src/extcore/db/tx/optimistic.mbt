///|
///===
/// extcore/db_tx_optimistic
pub(all) struct DbtxoptimisticPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn db_tx_optimistic_make_point(
  x : Double,
  y : Double,
) -> DbtxoptimisticPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn db_tx_optimistic_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DbtxoptimisticPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DbtxoptimisticPoint::x(self : DbtxoptimisticPoint) -> Double {
  self.x
}

///|
pub fn DbtxoptimisticPoint::y(self : DbtxoptimisticPoint) -> Double {
  self.y
}

///|
pub fn DbtxoptimisticPoint::z(self : DbtxoptimisticPoint) -> Double {
  self.z
}

///|
pub fn DbtxoptimisticPoint::label(self : DbtxoptimisticPoint) -> Int32 {
  self.label
}

///|
pub fn DbtxoptimisticPoint::dist(
  self : DbtxoptimisticPoint,
  other : DbtxoptimisticPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DbtxoptimisticPoint::add(
  self : DbtxoptimisticPoint,
  other : DbtxoptimisticPoint,
) -> DbtxoptimisticPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DbtxoptimisticPoint::sub(
  self : DbtxoptimisticPoint,
  other : DbtxoptimisticPoint,
) -> DbtxoptimisticPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DbtxoptimisticPoint::scale(
  self : DbtxoptimisticPoint,
  s : Double,
) -> DbtxoptimisticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DbtxoptimisticPoint::dot(
  self : DbtxoptimisticPoint,
  other : DbtxoptimisticPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DbtxoptimisticPoint::cross(
  self : DbtxoptimisticPoint,
  other : DbtxoptimisticPoint,
) -> DbtxoptimisticPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DbtxoptimisticPoint::norm(self : DbtxoptimisticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DbtxoptimisticPoint::normalize(
  self : DbtxoptimisticPoint,
) -> DbtxoptimisticPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbtxoptimisticPoint::negate(
  self : DbtxoptimisticPoint,
) -> DbtxoptimisticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DbtxoptimisticPoint::mid(
  self : DbtxoptimisticPoint,
  other : DbtxoptimisticPoint,
) -> DbtxoptimisticPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DbtxoptimisticPoint::lerp(
  self : DbtxoptimisticPoint,
  other : DbtxoptimisticPoint,
  t : Double,
) -> DbtxoptimisticPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DbtxoptimisticPoint::to_string(self : DbtxoptimisticPoint) -> String {
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
pub(all) struct DbtxoptimisticSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn db_tx_optimistic_make_series(
  vals : Array[Double],
  name : String,
) -> DbtxoptimisticSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DbtxoptimisticSeries::len(self : DbtxoptimisticSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DbtxoptimisticSeries::sum(self : DbtxoptimisticSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DbtxoptimisticSeries::mean(self : DbtxoptimisticSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DbtxoptimisticSeries::min(self : DbtxoptimisticSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DbtxoptimisticSeries::max(self : DbtxoptimisticSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DbtxoptimisticSeries::range(self : DbtxoptimisticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DbtxoptimisticSeries::variance(self : DbtxoptimisticSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DbtxoptimisticSeries::std(self : DbtxoptimisticSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DbtxoptimisticSeries::median(self : DbtxoptimisticSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DbtxoptimisticSeries::scale(
  self : DbtxoptimisticSeries,
  f : Double,
) -> DbtxoptimisticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DbtxoptimisticSeries::add(
  self : DbtxoptimisticSeries,
  other : DbtxoptimisticSeries,
) -> DbtxoptimisticSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbtxoptimisticSeries::sub(
  self : DbtxoptimisticSeries,
  other : DbtxoptimisticSeries,
) -> DbtxoptimisticSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbtxoptimisticSeries::normalize(
  self : DbtxoptimisticSeries,
) -> DbtxoptimisticSeries {
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
pub fn DbtxoptimisticSeries::cumsum(
  self : DbtxoptimisticSeries,
) -> DbtxoptimisticSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DbtxoptimisticSeries::to_string(self : DbtxoptimisticSeries) -> String {
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
pub(all) struct DbtxoptimisticMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn db_tx_optimistic_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DbtxoptimisticMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn db_tx_optimistic_matrix_identity(n : Int32) -> DbtxoptimisticMatrix {
  let m = db_tx_optimistic_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DbtxoptimisticMatrix::get(
  self : DbtxoptimisticMatrix,
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
pub fn DbtxoptimisticMatrix::transpose(
  self : DbtxoptimisticMatrix,
) -> DbtxoptimisticMatrix {
  let result = db_tx_optimistic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DbtxoptimisticMatrix::add(
  self : DbtxoptimisticMatrix,
  other : DbtxoptimisticMatrix,
) -> DbtxoptimisticMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = db_tx_optimistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DbtxoptimisticMatrix::scale(
  self : DbtxoptimisticMatrix,
  s : Double,
) -> DbtxoptimisticMatrix {
  let result = db_tx_optimistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DbtxoptimisticMatrix::multiply(
  self : DbtxoptimisticMatrix,
  other : DbtxoptimisticMatrix,
) -> DbtxoptimisticMatrix {
  if self.cols != other.rows {
    return db_tx_optimistic_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = db_tx_optimistic_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DbtxoptimisticMatrix::trace(self : DbtxoptimisticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DbtxoptimisticMatrix::det(self : DbtxoptimisticMatrix) -> Double {
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
pub fn DbtxoptimisticMatrix::norm(self : DbtxoptimisticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DbtxoptimisticMatrix::to_string(self : DbtxoptimisticMatrix) -> String {
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
pub(all) struct DbtxoptimisticVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn db_tx_optimistic_make_vector(
  comps : Array[Double],
) -> DbtxoptimisticVector {
  { comps, dim: comps.length(), }
}

///|
pub fn db_tx_optimistic_vector_zero(dim : Int32) -> DbtxoptimisticVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DbtxoptimisticVector::add(
  self : DbtxoptimisticVector,
  other : DbtxoptimisticVector,
) -> DbtxoptimisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbtxoptimisticVector::sub(
  self : DbtxoptimisticVector,
  other : DbtxoptimisticVector,
) -> DbtxoptimisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbtxoptimisticVector::scale(
  self : DbtxoptimisticVector,
  s : Double,
) -> DbtxoptimisticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DbtxoptimisticVector::dot(
  self : DbtxoptimisticVector,
  other : DbtxoptimisticVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DbtxoptimisticVector::norm(self : DbtxoptimisticVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DbtxoptimisticVector::normalize(
  self : DbtxoptimisticVector,
) -> DbtxoptimisticVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbtxoptimisticVector::dist(
  self : DbtxoptimisticVector,
  other : DbtxoptimisticVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DbtxoptimisticVector::to_string(self : DbtxoptimisticVector) -> String {
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
pub(all) struct DbtxoptimisticFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_frame_make(size : Int32) -> DbtxoptimisticFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticFrame::len(self : DbtxoptimisticFrame) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticFrame::get(
  self : DbtxoptimisticFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticFrame::set(
  self : DbtxoptimisticFrame,
  i : Int32,
  v : Double,
) -> DbtxoptimisticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticFrame::sum(self : DbtxoptimisticFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticFrame::mean(self : DbtxoptimisticFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticFrame::scale(
  self : DbtxoptimisticFrame,
  f : Double,
) -> DbtxoptimisticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticFrame::add(
  self : DbtxoptimisticFrame,
  other : DbtxoptimisticFrame,
) -> DbtxoptimisticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticFrame::copy(
  self : DbtxoptimisticFrame,
) -> DbtxoptimisticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticFrame::fill(
  self : DbtxoptimisticFrame,
  v : Double,
) -> DbtxoptimisticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticFrame::min(self : DbtxoptimisticFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticFrame::max(self : DbtxoptimisticFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticFrame::to_string(self : DbtxoptimisticFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_table_make(size : Int32) -> DbtxoptimisticTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticTable::len(self : DbtxoptimisticTable) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticTable::get(
  self : DbtxoptimisticTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticTable::set(
  self : DbtxoptimisticTable,
  i : Int32,
  v : Double,
) -> DbtxoptimisticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticTable::sum(self : DbtxoptimisticTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticTable::mean(self : DbtxoptimisticTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticTable::scale(
  self : DbtxoptimisticTable,
  f : Double,
) -> DbtxoptimisticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticTable::add(
  self : DbtxoptimisticTable,
  other : DbtxoptimisticTable,
) -> DbtxoptimisticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticTable::copy(
  self : DbtxoptimisticTable,
) -> DbtxoptimisticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticTable::fill(
  self : DbtxoptimisticTable,
  v : Double,
) -> DbtxoptimisticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticTable::min(self : DbtxoptimisticTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticTable::max(self : DbtxoptimisticTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticTable::to_string(self : DbtxoptimisticTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_graphn_make(size : Int32) -> DbtxoptimisticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticGraphN::len(self : DbtxoptimisticGraphN) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticGraphN::get(
  self : DbtxoptimisticGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticGraphN::set(
  self : DbtxoptimisticGraphN,
  i : Int32,
  v : Double,
) -> DbtxoptimisticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticGraphN::sum(self : DbtxoptimisticGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticGraphN::mean(self : DbtxoptimisticGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticGraphN::scale(
  self : DbtxoptimisticGraphN,
  f : Double,
) -> DbtxoptimisticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticGraphN::add(
  self : DbtxoptimisticGraphN,
  other : DbtxoptimisticGraphN,
) -> DbtxoptimisticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticGraphN::copy(
  self : DbtxoptimisticGraphN,
) -> DbtxoptimisticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticGraphN::fill(
  self : DbtxoptimisticGraphN,
  v : Double,
) -> DbtxoptimisticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticGraphN::min(self : DbtxoptimisticGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticGraphN::max(self : DbtxoptimisticGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticGraphN::to_string(self : DbtxoptimisticGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_node_make(size : Int32) -> DbtxoptimisticNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticNode::len(self : DbtxoptimisticNode) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticNode::get(self : DbtxoptimisticNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticNode::set(
  self : DbtxoptimisticNode,
  i : Int32,
  v : Double,
) -> DbtxoptimisticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticNode::sum(self : DbtxoptimisticNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticNode::mean(self : DbtxoptimisticNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticNode::scale(
  self : DbtxoptimisticNode,
  f : Double,
) -> DbtxoptimisticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticNode::add(
  self : DbtxoptimisticNode,
  other : DbtxoptimisticNode,
) -> DbtxoptimisticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticNode::copy(
  self : DbtxoptimisticNode,
) -> DbtxoptimisticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticNode::fill(
  self : DbtxoptimisticNode,
  v : Double,
) -> DbtxoptimisticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticNode::min(self : DbtxoptimisticNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticNode::max(self : DbtxoptimisticNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticNode::to_string(self : DbtxoptimisticNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_edge_make(size : Int32) -> DbtxoptimisticEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticEdge::len(self : DbtxoptimisticEdge) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticEdge::get(self : DbtxoptimisticEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticEdge::set(
  self : DbtxoptimisticEdge,
  i : Int32,
  v : Double,
) -> DbtxoptimisticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticEdge::sum(self : DbtxoptimisticEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticEdge::mean(self : DbtxoptimisticEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticEdge::scale(
  self : DbtxoptimisticEdge,
  f : Double,
) -> DbtxoptimisticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticEdge::add(
  self : DbtxoptimisticEdge,
  other : DbtxoptimisticEdge,
) -> DbtxoptimisticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticEdge::copy(
  self : DbtxoptimisticEdge,
) -> DbtxoptimisticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticEdge::fill(
  self : DbtxoptimisticEdge,
  v : Double,
) -> DbtxoptimisticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticEdge::min(self : DbtxoptimisticEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticEdge::max(self : DbtxoptimisticEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticEdge::to_string(self : DbtxoptimisticEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_path_make(size : Int32) -> DbtxoptimisticPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticPath::len(self : DbtxoptimisticPath) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticPath::get(self : DbtxoptimisticPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticPath::set(
  self : DbtxoptimisticPath,
  i : Int32,
  v : Double,
) -> DbtxoptimisticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticPath::sum(self : DbtxoptimisticPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticPath::mean(self : DbtxoptimisticPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticPath::scale(
  self : DbtxoptimisticPath,
  f : Double,
) -> DbtxoptimisticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticPath::add(
  self : DbtxoptimisticPath,
  other : DbtxoptimisticPath,
) -> DbtxoptimisticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticPath::copy(
  self : DbtxoptimisticPath,
) -> DbtxoptimisticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticPath::fill(
  self : DbtxoptimisticPath,
  v : Double,
) -> DbtxoptimisticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticPath::min(self : DbtxoptimisticPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticPath::max(self : DbtxoptimisticPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticPath::to_string(self : DbtxoptimisticPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_cluster_make(size : Int32) -> DbtxoptimisticCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticCluster::len(self : DbtxoptimisticCluster) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticCluster::get(
  self : DbtxoptimisticCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticCluster::set(
  self : DbtxoptimisticCluster,
  i : Int32,
  v : Double,
) -> DbtxoptimisticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticCluster::sum(self : DbtxoptimisticCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticCluster::mean(self : DbtxoptimisticCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticCluster::scale(
  self : DbtxoptimisticCluster,
  f : Double,
) -> DbtxoptimisticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticCluster::add(
  self : DbtxoptimisticCluster,
  other : DbtxoptimisticCluster,
) -> DbtxoptimisticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticCluster::copy(
  self : DbtxoptimisticCluster,
) -> DbtxoptimisticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticCluster::fill(
  self : DbtxoptimisticCluster,
  v : Double,
) -> DbtxoptimisticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticCluster::min(self : DbtxoptimisticCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticCluster::max(self : DbtxoptimisticCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticCluster::to_string(self : DbtxoptimisticCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_model_make(size : Int32) -> DbtxoptimisticModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticModel::len(self : DbtxoptimisticModel) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticModel::get(
  self : DbtxoptimisticModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticModel::set(
  self : DbtxoptimisticModel,
  i : Int32,
  v : Double,
) -> DbtxoptimisticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticModel::sum(self : DbtxoptimisticModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticModel::mean(self : DbtxoptimisticModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticModel::scale(
  self : DbtxoptimisticModel,
  f : Double,
) -> DbtxoptimisticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticModel::add(
  self : DbtxoptimisticModel,
  other : DbtxoptimisticModel,
) -> DbtxoptimisticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticModel::copy(
  self : DbtxoptimisticModel,
) -> DbtxoptimisticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticModel::fill(
  self : DbtxoptimisticModel,
  v : Double,
) -> DbtxoptimisticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticModel::min(self : DbtxoptimisticModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticModel::max(self : DbtxoptimisticModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticModel::to_string(self : DbtxoptimisticModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_layer_make(size : Int32) -> DbtxoptimisticLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticLayer::len(self : DbtxoptimisticLayer) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticLayer::get(
  self : DbtxoptimisticLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticLayer::set(
  self : DbtxoptimisticLayer,
  i : Int32,
  v : Double,
) -> DbtxoptimisticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticLayer::sum(self : DbtxoptimisticLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticLayer::mean(self : DbtxoptimisticLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticLayer::scale(
  self : DbtxoptimisticLayer,
  f : Double,
) -> DbtxoptimisticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticLayer::add(
  self : DbtxoptimisticLayer,
  other : DbtxoptimisticLayer,
) -> DbtxoptimisticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticLayer::copy(
  self : DbtxoptimisticLayer,
) -> DbtxoptimisticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticLayer::fill(
  self : DbtxoptimisticLayer,
  v : Double,
) -> DbtxoptimisticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticLayer::min(self : DbtxoptimisticLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticLayer::max(self : DbtxoptimisticLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticLayer::to_string(self : DbtxoptimisticLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_buffer_make(size : Int32) -> DbtxoptimisticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticBuffer::len(self : DbtxoptimisticBuffer) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticBuffer::get(
  self : DbtxoptimisticBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticBuffer::set(
  self : DbtxoptimisticBuffer,
  i : Int32,
  v : Double,
) -> DbtxoptimisticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticBuffer::sum(self : DbtxoptimisticBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticBuffer::mean(self : DbtxoptimisticBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticBuffer::scale(
  self : DbtxoptimisticBuffer,
  f : Double,
) -> DbtxoptimisticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticBuffer::add(
  self : DbtxoptimisticBuffer,
  other : DbtxoptimisticBuffer,
) -> DbtxoptimisticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticBuffer::copy(
  self : DbtxoptimisticBuffer,
) -> DbtxoptimisticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticBuffer::fill(
  self : DbtxoptimisticBuffer,
  v : Double,
) -> DbtxoptimisticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticBuffer::min(self : DbtxoptimisticBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticBuffer::max(self : DbtxoptimisticBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticBuffer::to_string(self : DbtxoptimisticBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_cursor_make(size : Int32) -> DbtxoptimisticCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticCursor::len(self : DbtxoptimisticCursor) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticCursor::get(
  self : DbtxoptimisticCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticCursor::set(
  self : DbtxoptimisticCursor,
  i : Int32,
  v : Double,
) -> DbtxoptimisticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticCursor::sum(self : DbtxoptimisticCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticCursor::mean(self : DbtxoptimisticCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticCursor::scale(
  self : DbtxoptimisticCursor,
  f : Double,
) -> DbtxoptimisticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticCursor::add(
  self : DbtxoptimisticCursor,
  other : DbtxoptimisticCursor,
) -> DbtxoptimisticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticCursor::copy(
  self : DbtxoptimisticCursor,
) -> DbtxoptimisticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticCursor::fill(
  self : DbtxoptimisticCursor,
  v : Double,
) -> DbtxoptimisticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticCursor::min(self : DbtxoptimisticCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticCursor::max(self : DbtxoptimisticCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticCursor::to_string(self : DbtxoptimisticCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_view_make(size : Int32) -> DbtxoptimisticView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticView::len(self : DbtxoptimisticView) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticView::get(self : DbtxoptimisticView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticView::set(
  self : DbtxoptimisticView,
  i : Int32,
  v : Double,
) -> DbtxoptimisticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticView::sum(self : DbtxoptimisticView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticView::mean(self : DbtxoptimisticView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticView::scale(
  self : DbtxoptimisticView,
  f : Double,
) -> DbtxoptimisticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticView::add(
  self : DbtxoptimisticView,
  other : DbtxoptimisticView,
) -> DbtxoptimisticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticView::copy(
  self : DbtxoptimisticView,
) -> DbtxoptimisticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticView::fill(
  self : DbtxoptimisticView,
  v : Double,
) -> DbtxoptimisticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticView::min(self : DbtxoptimisticView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticView::max(self : DbtxoptimisticView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticView::to_string(self : DbtxoptimisticView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_range_make(size : Int32) -> DbtxoptimisticRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticRange::len(self : DbtxoptimisticRange) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticRange::get(
  self : DbtxoptimisticRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticRange::set(
  self : DbtxoptimisticRange,
  i : Int32,
  v : Double,
) -> DbtxoptimisticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticRange::sum(self : DbtxoptimisticRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticRange::mean(self : DbtxoptimisticRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticRange::scale(
  self : DbtxoptimisticRange,
  f : Double,
) -> DbtxoptimisticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticRange::add(
  self : DbtxoptimisticRange,
  other : DbtxoptimisticRange,
) -> DbtxoptimisticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticRange::copy(
  self : DbtxoptimisticRange,
) -> DbtxoptimisticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticRange::fill(
  self : DbtxoptimisticRange,
  v : Double,
) -> DbtxoptimisticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticRange::min(self : DbtxoptimisticRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticRange::max(self : DbtxoptimisticRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticRange::to_string(self : DbtxoptimisticRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbtxoptimisticSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_optimistic_slice_make(size : Int32) -> DbtxoptimisticSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbtxoptimisticSlice::len(self : DbtxoptimisticSlice) -> Int32 {
  self.size
}

///|
pub fn DbtxoptimisticSlice::get(
  self : DbtxoptimisticSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbtxoptimisticSlice::set(
  self : DbtxoptimisticSlice,
  i : Int32,
  v : Double,
) -> DbtxoptimisticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticSlice::sum(self : DbtxoptimisticSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbtxoptimisticSlice::mean(self : DbtxoptimisticSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbtxoptimisticSlice::scale(
  self : DbtxoptimisticSlice,
  f : Double,
) -> DbtxoptimisticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticSlice::add(
  self : DbtxoptimisticSlice,
  other : DbtxoptimisticSlice,
) -> DbtxoptimisticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbtxoptimisticSlice::copy(
  self : DbtxoptimisticSlice,
) -> DbtxoptimisticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticSlice::fill(
  self : DbtxoptimisticSlice,
  v : Double,
) -> DbtxoptimisticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbtxoptimisticSlice::min(self : DbtxoptimisticSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbtxoptimisticSlice::max(self : DbtxoptimisticSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbtxoptimisticSlice::to_string(self : DbtxoptimisticSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
