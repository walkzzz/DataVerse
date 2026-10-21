///|
///===
/// extcore/bio_seq_align_global
pub(all) struct BioseqalignglobalPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn bio_seq_align_global_make_point(
  x : Double,
  y : Double,
) -> BioseqalignglobalPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn bio_seq_align_global_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> BioseqalignglobalPoint {
  { x, y, z, label: 0, }
}

///|
pub fn BioseqalignglobalPoint::x(self : BioseqalignglobalPoint) -> Double {
  self.x
}

///|
pub fn BioseqalignglobalPoint::y(self : BioseqalignglobalPoint) -> Double {
  self.y
}

///|
pub fn BioseqalignglobalPoint::z(self : BioseqalignglobalPoint) -> Double {
  self.z
}

///|
pub fn BioseqalignglobalPoint::label(self : BioseqalignglobalPoint) -> Int32 {
  self.label
}

///|
pub fn BioseqalignglobalPoint::dist(
  self : BioseqalignglobalPoint,
  other : BioseqalignglobalPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn BioseqalignglobalPoint::add(
  self : BioseqalignglobalPoint,
  other : BioseqalignglobalPoint,
) -> BioseqalignglobalPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn BioseqalignglobalPoint::sub(
  self : BioseqalignglobalPoint,
  other : BioseqalignglobalPoint,
) -> BioseqalignglobalPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn BioseqalignglobalPoint::scale(
  self : BioseqalignglobalPoint,
  s : Double,
) -> BioseqalignglobalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn BioseqalignglobalPoint::dot(
  self : BioseqalignglobalPoint,
  other : BioseqalignglobalPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn BioseqalignglobalPoint::cross(
  self : BioseqalignglobalPoint,
  other : BioseqalignglobalPoint,
) -> BioseqalignglobalPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn BioseqalignglobalPoint::norm(self : BioseqalignglobalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn BioseqalignglobalPoint::normalize(
  self : BioseqalignglobalPoint,
) -> BioseqalignglobalPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BioseqalignglobalPoint::negate(
  self : BioseqalignglobalPoint,
) -> BioseqalignglobalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn BioseqalignglobalPoint::mid(
  self : BioseqalignglobalPoint,
  other : BioseqalignglobalPoint,
) -> BioseqalignglobalPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn BioseqalignglobalPoint::lerp(
  self : BioseqalignglobalPoint,
  other : BioseqalignglobalPoint,
  t : Double,
) -> BioseqalignglobalPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn BioseqalignglobalPoint::to_string(
  self : BioseqalignglobalPoint,
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
pub(all) struct BioseqalignglobalSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn bio_seq_align_global_make_series(
  vals : Array[Double],
  name : String,
) -> BioseqalignglobalSeries {
  { vals, name, meta: 0, }
}

///|
pub fn BioseqalignglobalSeries::len(self : BioseqalignglobalSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn BioseqalignglobalSeries::sum(self : BioseqalignglobalSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn BioseqalignglobalSeries::mean(self : BioseqalignglobalSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn BioseqalignglobalSeries::min(self : BioseqalignglobalSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn BioseqalignglobalSeries::max(self : BioseqalignglobalSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn BioseqalignglobalSeries::range(self : BioseqalignglobalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn BioseqalignglobalSeries::variance(
  self : BioseqalignglobalSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn BioseqalignglobalSeries::std(self : BioseqalignglobalSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn BioseqalignglobalSeries::median(
  self : BioseqalignglobalSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn BioseqalignglobalSeries::scale(
  self : BioseqalignglobalSeries,
  f : Double,
) -> BioseqalignglobalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn BioseqalignglobalSeries::add(
  self : BioseqalignglobalSeries,
  other : BioseqalignglobalSeries,
) -> BioseqalignglobalSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BioseqalignglobalSeries::sub(
  self : BioseqalignglobalSeries,
  other : BioseqalignglobalSeries,
) -> BioseqalignglobalSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BioseqalignglobalSeries::normalize(
  self : BioseqalignglobalSeries,
) -> BioseqalignglobalSeries {
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
pub fn BioseqalignglobalSeries::cumsum(
  self : BioseqalignglobalSeries,
) -> BioseqalignglobalSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn BioseqalignglobalSeries::to_string(
  self : BioseqalignglobalSeries,
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
pub(all) struct BioseqalignglobalMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn bio_seq_align_global_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> BioseqalignglobalMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn bio_seq_align_global_matrix_identity(
  n : Int32,
) -> BioseqalignglobalMatrix {
  let m = bio_seq_align_global_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn BioseqalignglobalMatrix::get(
  self : BioseqalignglobalMatrix,
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
pub fn BioseqalignglobalMatrix::transpose(
  self : BioseqalignglobalMatrix,
) -> BioseqalignglobalMatrix {
  let result = bio_seq_align_global_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn BioseqalignglobalMatrix::add(
  self : BioseqalignglobalMatrix,
  other : BioseqalignglobalMatrix,
) -> BioseqalignglobalMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = bio_seq_align_global_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn BioseqalignglobalMatrix::scale(
  self : BioseqalignglobalMatrix,
  s : Double,
) -> BioseqalignglobalMatrix {
  let result = bio_seq_align_global_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn BioseqalignglobalMatrix::multiply(
  self : BioseqalignglobalMatrix,
  other : BioseqalignglobalMatrix,
) -> BioseqalignglobalMatrix {
  if self.cols != other.rows {
    return bio_seq_align_global_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = bio_seq_align_global_make_matrix(self.rows, other.cols, 0.0)
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
pub fn BioseqalignglobalMatrix::trace(self : BioseqalignglobalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn BioseqalignglobalMatrix::det(self : BioseqalignglobalMatrix) -> Double {
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
pub fn BioseqalignglobalMatrix::norm(self : BioseqalignglobalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn BioseqalignglobalMatrix::to_string(
  self : BioseqalignglobalMatrix,
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
pub(all) struct BioseqalignglobalVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn bio_seq_align_global_make_vector(
  comps : Array[Double],
) -> BioseqalignglobalVector {
  { comps, dim: comps.length(), }
}

///|
pub fn bio_seq_align_global_vector_zero(dim : Int32) -> BioseqalignglobalVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn BioseqalignglobalVector::add(
  self : BioseqalignglobalVector,
  other : BioseqalignglobalVector,
) -> BioseqalignglobalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BioseqalignglobalVector::sub(
  self : BioseqalignglobalVector,
  other : BioseqalignglobalVector,
) -> BioseqalignglobalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BioseqalignglobalVector::scale(
  self : BioseqalignglobalVector,
  s : Double,
) -> BioseqalignglobalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn BioseqalignglobalVector::dot(
  self : BioseqalignglobalVector,
  other : BioseqalignglobalVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn BioseqalignglobalVector::norm(self : BioseqalignglobalVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn BioseqalignglobalVector::normalize(
  self : BioseqalignglobalVector,
) -> BioseqalignglobalVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BioseqalignglobalVector::dist(
  self : BioseqalignglobalVector,
  other : BioseqalignglobalVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn BioseqalignglobalVector::to_string(
  self : BioseqalignglobalVector,
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
pub(all) struct BioseqalignglobalFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_frame_make(size : Int32) -> BioseqalignglobalFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalFrame::len(self : BioseqalignglobalFrame) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalFrame::get(
  self : BioseqalignglobalFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalFrame::set(
  self : BioseqalignglobalFrame,
  i : Int32,
  v : Double,
) -> BioseqalignglobalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalFrame::sum(self : BioseqalignglobalFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalFrame::mean(self : BioseqalignglobalFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalFrame::scale(
  self : BioseqalignglobalFrame,
  f : Double,
) -> BioseqalignglobalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalFrame::add(
  self : BioseqalignglobalFrame,
  other : BioseqalignglobalFrame,
) -> BioseqalignglobalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalFrame::copy(
  self : BioseqalignglobalFrame,
) -> BioseqalignglobalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalFrame::fill(
  self : BioseqalignglobalFrame,
  v : Double,
) -> BioseqalignglobalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalFrame::min(self : BioseqalignglobalFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalFrame::max(self : BioseqalignglobalFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalFrame::to_string(
  self : BioseqalignglobalFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_table_make(size : Int32) -> BioseqalignglobalTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalTable::len(self : BioseqalignglobalTable) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalTable::get(
  self : BioseqalignglobalTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalTable::set(
  self : BioseqalignglobalTable,
  i : Int32,
  v : Double,
) -> BioseqalignglobalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalTable::sum(self : BioseqalignglobalTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalTable::mean(self : BioseqalignglobalTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalTable::scale(
  self : BioseqalignglobalTable,
  f : Double,
) -> BioseqalignglobalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalTable::add(
  self : BioseqalignglobalTable,
  other : BioseqalignglobalTable,
) -> BioseqalignglobalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalTable::copy(
  self : BioseqalignglobalTable,
) -> BioseqalignglobalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalTable::fill(
  self : BioseqalignglobalTable,
  v : Double,
) -> BioseqalignglobalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalTable::min(self : BioseqalignglobalTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalTable::max(self : BioseqalignglobalTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalTable::to_string(
  self : BioseqalignglobalTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_graphn_make(
  size : Int32,
) -> BioseqalignglobalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalGraphN::len(self : BioseqalignglobalGraphN) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalGraphN::get(
  self : BioseqalignglobalGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalGraphN::set(
  self : BioseqalignglobalGraphN,
  i : Int32,
  v : Double,
) -> BioseqalignglobalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalGraphN::sum(self : BioseqalignglobalGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalGraphN::mean(self : BioseqalignglobalGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalGraphN::scale(
  self : BioseqalignglobalGraphN,
  f : Double,
) -> BioseqalignglobalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalGraphN::add(
  self : BioseqalignglobalGraphN,
  other : BioseqalignglobalGraphN,
) -> BioseqalignglobalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalGraphN::copy(
  self : BioseqalignglobalGraphN,
) -> BioseqalignglobalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalGraphN::fill(
  self : BioseqalignglobalGraphN,
  v : Double,
) -> BioseqalignglobalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalGraphN::min(self : BioseqalignglobalGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalGraphN::max(self : BioseqalignglobalGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalGraphN::to_string(
  self : BioseqalignglobalGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_node_make(size : Int32) -> BioseqalignglobalNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalNode::len(self : BioseqalignglobalNode) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalNode::get(
  self : BioseqalignglobalNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalNode::set(
  self : BioseqalignglobalNode,
  i : Int32,
  v : Double,
) -> BioseqalignglobalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalNode::sum(self : BioseqalignglobalNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalNode::mean(self : BioseqalignglobalNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalNode::scale(
  self : BioseqalignglobalNode,
  f : Double,
) -> BioseqalignglobalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalNode::add(
  self : BioseqalignglobalNode,
  other : BioseqalignglobalNode,
) -> BioseqalignglobalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalNode::copy(
  self : BioseqalignglobalNode,
) -> BioseqalignglobalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalNode::fill(
  self : BioseqalignglobalNode,
  v : Double,
) -> BioseqalignglobalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalNode::min(self : BioseqalignglobalNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalNode::max(self : BioseqalignglobalNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalNode::to_string(self : BioseqalignglobalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_edge_make(size : Int32) -> BioseqalignglobalEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalEdge::len(self : BioseqalignglobalEdge) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalEdge::get(
  self : BioseqalignglobalEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalEdge::set(
  self : BioseqalignglobalEdge,
  i : Int32,
  v : Double,
) -> BioseqalignglobalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalEdge::sum(self : BioseqalignglobalEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalEdge::mean(self : BioseqalignglobalEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalEdge::scale(
  self : BioseqalignglobalEdge,
  f : Double,
) -> BioseqalignglobalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalEdge::add(
  self : BioseqalignglobalEdge,
  other : BioseqalignglobalEdge,
) -> BioseqalignglobalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalEdge::copy(
  self : BioseqalignglobalEdge,
) -> BioseqalignglobalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalEdge::fill(
  self : BioseqalignglobalEdge,
  v : Double,
) -> BioseqalignglobalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalEdge::min(self : BioseqalignglobalEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalEdge::max(self : BioseqalignglobalEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalEdge::to_string(self : BioseqalignglobalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_path_make(size : Int32) -> BioseqalignglobalPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalPath::len(self : BioseqalignglobalPath) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalPath::get(
  self : BioseqalignglobalPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalPath::set(
  self : BioseqalignglobalPath,
  i : Int32,
  v : Double,
) -> BioseqalignglobalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalPath::sum(self : BioseqalignglobalPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalPath::mean(self : BioseqalignglobalPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalPath::scale(
  self : BioseqalignglobalPath,
  f : Double,
) -> BioseqalignglobalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalPath::add(
  self : BioseqalignglobalPath,
  other : BioseqalignglobalPath,
) -> BioseqalignglobalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalPath::copy(
  self : BioseqalignglobalPath,
) -> BioseqalignglobalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalPath::fill(
  self : BioseqalignglobalPath,
  v : Double,
) -> BioseqalignglobalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalPath::min(self : BioseqalignglobalPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalPath::max(self : BioseqalignglobalPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalPath::to_string(self : BioseqalignglobalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_cluster_make(
  size : Int32,
) -> BioseqalignglobalCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalCluster::len(self : BioseqalignglobalCluster) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalCluster::get(
  self : BioseqalignglobalCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalCluster::set(
  self : BioseqalignglobalCluster,
  i : Int32,
  v : Double,
) -> BioseqalignglobalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalCluster::sum(self : BioseqalignglobalCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalCluster::mean(
  self : BioseqalignglobalCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalCluster::scale(
  self : BioseqalignglobalCluster,
  f : Double,
) -> BioseqalignglobalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalCluster::add(
  self : BioseqalignglobalCluster,
  other : BioseqalignglobalCluster,
) -> BioseqalignglobalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalCluster::copy(
  self : BioseqalignglobalCluster,
) -> BioseqalignglobalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalCluster::fill(
  self : BioseqalignglobalCluster,
  v : Double,
) -> BioseqalignglobalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalCluster::min(self : BioseqalignglobalCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalCluster::max(self : BioseqalignglobalCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalCluster::to_string(
  self : BioseqalignglobalCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_model_make(size : Int32) -> BioseqalignglobalModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalModel::len(self : BioseqalignglobalModel) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalModel::get(
  self : BioseqalignglobalModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalModel::set(
  self : BioseqalignglobalModel,
  i : Int32,
  v : Double,
) -> BioseqalignglobalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalModel::sum(self : BioseqalignglobalModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalModel::mean(self : BioseqalignglobalModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalModel::scale(
  self : BioseqalignglobalModel,
  f : Double,
) -> BioseqalignglobalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalModel::add(
  self : BioseqalignglobalModel,
  other : BioseqalignglobalModel,
) -> BioseqalignglobalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalModel::copy(
  self : BioseqalignglobalModel,
) -> BioseqalignglobalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalModel::fill(
  self : BioseqalignglobalModel,
  v : Double,
) -> BioseqalignglobalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalModel::min(self : BioseqalignglobalModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalModel::max(self : BioseqalignglobalModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalModel::to_string(
  self : BioseqalignglobalModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_layer_make(size : Int32) -> BioseqalignglobalLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalLayer::len(self : BioseqalignglobalLayer) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalLayer::get(
  self : BioseqalignglobalLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalLayer::set(
  self : BioseqalignglobalLayer,
  i : Int32,
  v : Double,
) -> BioseqalignglobalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalLayer::sum(self : BioseqalignglobalLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalLayer::mean(self : BioseqalignglobalLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalLayer::scale(
  self : BioseqalignglobalLayer,
  f : Double,
) -> BioseqalignglobalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalLayer::add(
  self : BioseqalignglobalLayer,
  other : BioseqalignglobalLayer,
) -> BioseqalignglobalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalLayer::copy(
  self : BioseqalignglobalLayer,
) -> BioseqalignglobalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalLayer::fill(
  self : BioseqalignglobalLayer,
  v : Double,
) -> BioseqalignglobalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalLayer::min(self : BioseqalignglobalLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalLayer::max(self : BioseqalignglobalLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalLayer::to_string(
  self : BioseqalignglobalLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_buffer_make(
  size : Int32,
) -> BioseqalignglobalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalBuffer::len(self : BioseqalignglobalBuffer) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalBuffer::get(
  self : BioseqalignglobalBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalBuffer::set(
  self : BioseqalignglobalBuffer,
  i : Int32,
  v : Double,
) -> BioseqalignglobalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalBuffer::sum(self : BioseqalignglobalBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalBuffer::mean(self : BioseqalignglobalBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalBuffer::scale(
  self : BioseqalignglobalBuffer,
  f : Double,
) -> BioseqalignglobalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalBuffer::add(
  self : BioseqalignglobalBuffer,
  other : BioseqalignglobalBuffer,
) -> BioseqalignglobalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalBuffer::copy(
  self : BioseqalignglobalBuffer,
) -> BioseqalignglobalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalBuffer::fill(
  self : BioseqalignglobalBuffer,
  v : Double,
) -> BioseqalignglobalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalBuffer::min(self : BioseqalignglobalBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalBuffer::max(self : BioseqalignglobalBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalBuffer::to_string(
  self : BioseqalignglobalBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_cursor_make(
  size : Int32,
) -> BioseqalignglobalCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalCursor::len(self : BioseqalignglobalCursor) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalCursor::get(
  self : BioseqalignglobalCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalCursor::set(
  self : BioseqalignglobalCursor,
  i : Int32,
  v : Double,
) -> BioseqalignglobalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalCursor::sum(self : BioseqalignglobalCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalCursor::mean(self : BioseqalignglobalCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalCursor::scale(
  self : BioseqalignglobalCursor,
  f : Double,
) -> BioseqalignglobalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalCursor::add(
  self : BioseqalignglobalCursor,
  other : BioseqalignglobalCursor,
) -> BioseqalignglobalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalCursor::copy(
  self : BioseqalignglobalCursor,
) -> BioseqalignglobalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalCursor::fill(
  self : BioseqalignglobalCursor,
  v : Double,
) -> BioseqalignglobalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalCursor::min(self : BioseqalignglobalCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalCursor::max(self : BioseqalignglobalCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalCursor::to_string(
  self : BioseqalignglobalCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_view_make(size : Int32) -> BioseqalignglobalView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalView::len(self : BioseqalignglobalView) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalView::get(
  self : BioseqalignglobalView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalView::set(
  self : BioseqalignglobalView,
  i : Int32,
  v : Double,
) -> BioseqalignglobalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalView::sum(self : BioseqalignglobalView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalView::mean(self : BioseqalignglobalView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalView::scale(
  self : BioseqalignglobalView,
  f : Double,
) -> BioseqalignglobalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalView::add(
  self : BioseqalignglobalView,
  other : BioseqalignglobalView,
) -> BioseqalignglobalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalView::copy(
  self : BioseqalignglobalView,
) -> BioseqalignglobalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalView::fill(
  self : BioseqalignglobalView,
  v : Double,
) -> BioseqalignglobalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalView::min(self : BioseqalignglobalView) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalView::max(self : BioseqalignglobalView) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalView::to_string(self : BioseqalignglobalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_range_make(size : Int32) -> BioseqalignglobalRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalRange::len(self : BioseqalignglobalRange) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalRange::get(
  self : BioseqalignglobalRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalRange::set(
  self : BioseqalignglobalRange,
  i : Int32,
  v : Double,
) -> BioseqalignglobalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalRange::sum(self : BioseqalignglobalRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalRange::mean(self : BioseqalignglobalRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalRange::scale(
  self : BioseqalignglobalRange,
  f : Double,
) -> BioseqalignglobalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalRange::add(
  self : BioseqalignglobalRange,
  other : BioseqalignglobalRange,
) -> BioseqalignglobalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalRange::copy(
  self : BioseqalignglobalRange,
) -> BioseqalignglobalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalRange::fill(
  self : BioseqalignglobalRange,
  v : Double,
) -> BioseqalignglobalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalRange::min(self : BioseqalignglobalRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalRange::max(self : BioseqalignglobalRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalRange::to_string(
  self : BioseqalignglobalRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignglobalSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_global_slice_make(size : Int32) -> BioseqalignglobalSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignglobalSlice::len(self : BioseqalignglobalSlice) -> Int32 {
  self.size
}

///|
pub fn BioseqalignglobalSlice::get(
  self : BioseqalignglobalSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignglobalSlice::set(
  self : BioseqalignglobalSlice,
  i : Int32,
  v : Double,
) -> BioseqalignglobalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalSlice::sum(self : BioseqalignglobalSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignglobalSlice::mean(self : BioseqalignglobalSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignglobalSlice::scale(
  self : BioseqalignglobalSlice,
  f : Double,
) -> BioseqalignglobalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalSlice::add(
  self : BioseqalignglobalSlice,
  other : BioseqalignglobalSlice,
) -> BioseqalignglobalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignglobalSlice::copy(
  self : BioseqalignglobalSlice,
) -> BioseqalignglobalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalSlice::fill(
  self : BioseqalignglobalSlice,
  v : Double,
) -> BioseqalignglobalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignglobalSlice::min(self : BioseqalignglobalSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignglobalSlice::max(self : BioseqalignglobalSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignglobalSlice::to_string(
  self : BioseqalignglobalSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
