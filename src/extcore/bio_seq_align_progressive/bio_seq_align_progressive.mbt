///|
///===
/// extcore/bio_seq_align_progressive
pub(all) struct BioseqalignprogressivePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn bio_seq_align_progressive_make_point(
  x : Double,
  y : Double,
) -> BioseqalignprogressivePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn bio_seq_align_progressive_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> BioseqalignprogressivePoint {
  { x, y, z, label: 0, }
}

///|
pub fn BioseqalignprogressivePoint::x(
  self : BioseqalignprogressivePoint,
) -> Double {
  self.x
}

///|
pub fn BioseqalignprogressivePoint::y(
  self : BioseqalignprogressivePoint,
) -> Double {
  self.y
}

///|
pub fn BioseqalignprogressivePoint::z(
  self : BioseqalignprogressivePoint,
) -> Double {
  self.z
}

///|
pub fn BioseqalignprogressivePoint::label(
  self : BioseqalignprogressivePoint,
) -> Int32 {
  self.label
}

///|
pub fn BioseqalignprogressivePoint::dist(
  self : BioseqalignprogressivePoint,
  other : BioseqalignprogressivePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn BioseqalignprogressivePoint::add(
  self : BioseqalignprogressivePoint,
  other : BioseqalignprogressivePoint,
) -> BioseqalignprogressivePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn BioseqalignprogressivePoint::sub(
  self : BioseqalignprogressivePoint,
  other : BioseqalignprogressivePoint,
) -> BioseqalignprogressivePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn BioseqalignprogressivePoint::scale(
  self : BioseqalignprogressivePoint,
  s : Double,
) -> BioseqalignprogressivePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn BioseqalignprogressivePoint::dot(
  self : BioseqalignprogressivePoint,
  other : BioseqalignprogressivePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn BioseqalignprogressivePoint::cross(
  self : BioseqalignprogressivePoint,
  other : BioseqalignprogressivePoint,
) -> BioseqalignprogressivePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn BioseqalignprogressivePoint::norm(
  self : BioseqalignprogressivePoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn BioseqalignprogressivePoint::normalize(
  self : BioseqalignprogressivePoint,
) -> BioseqalignprogressivePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BioseqalignprogressivePoint::negate(
  self : BioseqalignprogressivePoint,
) -> BioseqalignprogressivePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn BioseqalignprogressivePoint::mid(
  self : BioseqalignprogressivePoint,
  other : BioseqalignprogressivePoint,
) -> BioseqalignprogressivePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn BioseqalignprogressivePoint::lerp(
  self : BioseqalignprogressivePoint,
  other : BioseqalignprogressivePoint,
  t : Double,
) -> BioseqalignprogressivePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn BioseqalignprogressivePoint::to_string(
  self : BioseqalignprogressivePoint,
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
pub(all) struct BioseqalignprogressiveSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn bio_seq_align_progressive_make_series(
  vals : Array[Double],
  name : String,
) -> BioseqalignprogressiveSeries {
  { vals, name, meta: 0, }
}

///|
pub fn BioseqalignprogressiveSeries::len(
  self : BioseqalignprogressiveSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn BioseqalignprogressiveSeries::sum(
  self : BioseqalignprogressiveSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn BioseqalignprogressiveSeries::mean(
  self : BioseqalignprogressiveSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn BioseqalignprogressiveSeries::min(
  self : BioseqalignprogressiveSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn BioseqalignprogressiveSeries::max(
  self : BioseqalignprogressiveSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn BioseqalignprogressiveSeries::range(
  self : BioseqalignprogressiveSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn BioseqalignprogressiveSeries::variance(
  self : BioseqalignprogressiveSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn BioseqalignprogressiveSeries::std(
  self : BioseqalignprogressiveSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn BioseqalignprogressiveSeries::median(
  self : BioseqalignprogressiveSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn BioseqalignprogressiveSeries::scale(
  self : BioseqalignprogressiveSeries,
  f : Double,
) -> BioseqalignprogressiveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn BioseqalignprogressiveSeries::add(
  self : BioseqalignprogressiveSeries,
  other : BioseqalignprogressiveSeries,
) -> BioseqalignprogressiveSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BioseqalignprogressiveSeries::sub(
  self : BioseqalignprogressiveSeries,
  other : BioseqalignprogressiveSeries,
) -> BioseqalignprogressiveSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BioseqalignprogressiveSeries::normalize(
  self : BioseqalignprogressiveSeries,
) -> BioseqalignprogressiveSeries {
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
pub fn BioseqalignprogressiveSeries::cumsum(
  self : BioseqalignprogressiveSeries,
) -> BioseqalignprogressiveSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn BioseqalignprogressiveSeries::to_string(
  self : BioseqalignprogressiveSeries,
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
pub(all) struct BioseqalignprogressiveMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn bio_seq_align_progressive_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> BioseqalignprogressiveMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn bio_seq_align_progressive_matrix_identity(
  n : Int32,
) -> BioseqalignprogressiveMatrix {
  let m = bio_seq_align_progressive_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn BioseqalignprogressiveMatrix::get(
  self : BioseqalignprogressiveMatrix,
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
pub fn BioseqalignprogressiveMatrix::transpose(
  self : BioseqalignprogressiveMatrix,
) -> BioseqalignprogressiveMatrix {
  let result = bio_seq_align_progressive_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn BioseqalignprogressiveMatrix::add(
  self : BioseqalignprogressiveMatrix,
  other : BioseqalignprogressiveMatrix,
) -> BioseqalignprogressiveMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = bio_seq_align_progressive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn BioseqalignprogressiveMatrix::scale(
  self : BioseqalignprogressiveMatrix,
  s : Double,
) -> BioseqalignprogressiveMatrix {
  let result = bio_seq_align_progressive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn BioseqalignprogressiveMatrix::multiply(
  self : BioseqalignprogressiveMatrix,
  other : BioseqalignprogressiveMatrix,
) -> BioseqalignprogressiveMatrix {
  if self.cols != other.rows {
    return bio_seq_align_progressive_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = bio_seq_align_progressive_make_matrix(self.rows, other.cols, 0.0)
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
pub fn BioseqalignprogressiveMatrix::trace(
  self : BioseqalignprogressiveMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn BioseqalignprogressiveMatrix::det(
  self : BioseqalignprogressiveMatrix,
) -> Double {
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
pub fn BioseqalignprogressiveMatrix::norm(
  self : BioseqalignprogressiveMatrix,
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
pub fn BioseqalignprogressiveMatrix::to_string(
  self : BioseqalignprogressiveMatrix,
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
pub(all) struct BioseqalignprogressiveVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn bio_seq_align_progressive_make_vector(
  comps : Array[Double],
) -> BioseqalignprogressiveVector {
  { comps, dim: comps.length(), }
}

///|
pub fn bio_seq_align_progressive_vector_zero(
  dim : Int32,
) -> BioseqalignprogressiveVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn BioseqalignprogressiveVector::add(
  self : BioseqalignprogressiveVector,
  other : BioseqalignprogressiveVector,
) -> BioseqalignprogressiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BioseqalignprogressiveVector::sub(
  self : BioseqalignprogressiveVector,
  other : BioseqalignprogressiveVector,
) -> BioseqalignprogressiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BioseqalignprogressiveVector::scale(
  self : BioseqalignprogressiveVector,
  s : Double,
) -> BioseqalignprogressiveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn BioseqalignprogressiveVector::dot(
  self : BioseqalignprogressiveVector,
  other : BioseqalignprogressiveVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn BioseqalignprogressiveVector::norm(
  self : BioseqalignprogressiveVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn BioseqalignprogressiveVector::normalize(
  self : BioseqalignprogressiveVector,
) -> BioseqalignprogressiveVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BioseqalignprogressiveVector::dist(
  self : BioseqalignprogressiveVector,
  other : BioseqalignprogressiveVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn BioseqalignprogressiveVector::to_string(
  self : BioseqalignprogressiveVector,
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
pub(all) struct BioseqalignprogressiveFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_frame_make(
  size : Int32,
) -> BioseqalignprogressiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveFrame::len(
  self : BioseqalignprogressiveFrame,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveFrame::get(
  self : BioseqalignprogressiveFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveFrame::set(
  self : BioseqalignprogressiveFrame,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveFrame::sum(
  self : BioseqalignprogressiveFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveFrame::mean(
  self : BioseqalignprogressiveFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveFrame::scale(
  self : BioseqalignprogressiveFrame,
  f : Double,
) -> BioseqalignprogressiveFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveFrame::add(
  self : BioseqalignprogressiveFrame,
  other : BioseqalignprogressiveFrame,
) -> BioseqalignprogressiveFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveFrame::copy(
  self : BioseqalignprogressiveFrame,
) -> BioseqalignprogressiveFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveFrame::fill(
  self : BioseqalignprogressiveFrame,
  v : Double,
) -> BioseqalignprogressiveFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveFrame::min(
  self : BioseqalignprogressiveFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveFrame::max(
  self : BioseqalignprogressiveFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveFrame::to_string(
  self : BioseqalignprogressiveFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_table_make(
  size : Int32,
) -> BioseqalignprogressiveTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveTable::len(
  self : BioseqalignprogressiveTable,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveTable::get(
  self : BioseqalignprogressiveTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveTable::set(
  self : BioseqalignprogressiveTable,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveTable::sum(
  self : BioseqalignprogressiveTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveTable::mean(
  self : BioseqalignprogressiveTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveTable::scale(
  self : BioseqalignprogressiveTable,
  f : Double,
) -> BioseqalignprogressiveTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveTable::add(
  self : BioseqalignprogressiveTable,
  other : BioseqalignprogressiveTable,
) -> BioseqalignprogressiveTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveTable::copy(
  self : BioseqalignprogressiveTable,
) -> BioseqalignprogressiveTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveTable::fill(
  self : BioseqalignprogressiveTable,
  v : Double,
) -> BioseqalignprogressiveTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveTable::min(
  self : BioseqalignprogressiveTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveTable::max(
  self : BioseqalignprogressiveTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveTable::to_string(
  self : BioseqalignprogressiveTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_graphn_make(
  size : Int32,
) -> BioseqalignprogressiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveGraphN::len(
  self : BioseqalignprogressiveGraphN,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveGraphN::get(
  self : BioseqalignprogressiveGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveGraphN::set(
  self : BioseqalignprogressiveGraphN,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveGraphN::sum(
  self : BioseqalignprogressiveGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveGraphN::mean(
  self : BioseqalignprogressiveGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveGraphN::scale(
  self : BioseqalignprogressiveGraphN,
  f : Double,
) -> BioseqalignprogressiveGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveGraphN::add(
  self : BioseqalignprogressiveGraphN,
  other : BioseqalignprogressiveGraphN,
) -> BioseqalignprogressiveGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveGraphN::copy(
  self : BioseqalignprogressiveGraphN,
) -> BioseqalignprogressiveGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveGraphN::fill(
  self : BioseqalignprogressiveGraphN,
  v : Double,
) -> BioseqalignprogressiveGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveGraphN::min(
  self : BioseqalignprogressiveGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveGraphN::max(
  self : BioseqalignprogressiveGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveGraphN::to_string(
  self : BioseqalignprogressiveGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_node_make(
  size : Int32,
) -> BioseqalignprogressiveNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveNode::len(
  self : BioseqalignprogressiveNode,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveNode::get(
  self : BioseqalignprogressiveNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveNode::set(
  self : BioseqalignprogressiveNode,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveNode::sum(
  self : BioseqalignprogressiveNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveNode::mean(
  self : BioseqalignprogressiveNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveNode::scale(
  self : BioseqalignprogressiveNode,
  f : Double,
) -> BioseqalignprogressiveNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveNode::add(
  self : BioseqalignprogressiveNode,
  other : BioseqalignprogressiveNode,
) -> BioseqalignprogressiveNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveNode::copy(
  self : BioseqalignprogressiveNode,
) -> BioseqalignprogressiveNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveNode::fill(
  self : BioseqalignprogressiveNode,
  v : Double,
) -> BioseqalignprogressiveNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveNode::min(
  self : BioseqalignprogressiveNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveNode::max(
  self : BioseqalignprogressiveNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveNode::to_string(
  self : BioseqalignprogressiveNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_edge_make(
  size : Int32,
) -> BioseqalignprogressiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveEdge::len(
  self : BioseqalignprogressiveEdge,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveEdge::get(
  self : BioseqalignprogressiveEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveEdge::set(
  self : BioseqalignprogressiveEdge,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveEdge::sum(
  self : BioseqalignprogressiveEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveEdge::mean(
  self : BioseqalignprogressiveEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveEdge::scale(
  self : BioseqalignprogressiveEdge,
  f : Double,
) -> BioseqalignprogressiveEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveEdge::add(
  self : BioseqalignprogressiveEdge,
  other : BioseqalignprogressiveEdge,
) -> BioseqalignprogressiveEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveEdge::copy(
  self : BioseqalignprogressiveEdge,
) -> BioseqalignprogressiveEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveEdge::fill(
  self : BioseqalignprogressiveEdge,
  v : Double,
) -> BioseqalignprogressiveEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveEdge::min(
  self : BioseqalignprogressiveEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveEdge::max(
  self : BioseqalignprogressiveEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveEdge::to_string(
  self : BioseqalignprogressiveEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressivePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_path_make(
  size : Int32,
) -> BioseqalignprogressivePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressivePath::len(
  self : BioseqalignprogressivePath,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressivePath::get(
  self : BioseqalignprogressivePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressivePath::set(
  self : BioseqalignprogressivePath,
  i : Int32,
  v : Double,
) -> BioseqalignprogressivePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressivePath::sum(
  self : BioseqalignprogressivePath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressivePath::mean(
  self : BioseqalignprogressivePath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressivePath::scale(
  self : BioseqalignprogressivePath,
  f : Double,
) -> BioseqalignprogressivePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressivePath::add(
  self : BioseqalignprogressivePath,
  other : BioseqalignprogressivePath,
) -> BioseqalignprogressivePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressivePath::copy(
  self : BioseqalignprogressivePath,
) -> BioseqalignprogressivePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressivePath::fill(
  self : BioseqalignprogressivePath,
  v : Double,
) -> BioseqalignprogressivePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressivePath::min(
  self : BioseqalignprogressivePath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressivePath::max(
  self : BioseqalignprogressivePath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressivePath::to_string(
  self : BioseqalignprogressivePath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_cluster_make(
  size : Int32,
) -> BioseqalignprogressiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveCluster::len(
  self : BioseqalignprogressiveCluster,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveCluster::get(
  self : BioseqalignprogressiveCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveCluster::set(
  self : BioseqalignprogressiveCluster,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveCluster::sum(
  self : BioseqalignprogressiveCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveCluster::mean(
  self : BioseqalignprogressiveCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveCluster::scale(
  self : BioseqalignprogressiveCluster,
  f : Double,
) -> BioseqalignprogressiveCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveCluster::add(
  self : BioseqalignprogressiveCluster,
  other : BioseqalignprogressiveCluster,
) -> BioseqalignprogressiveCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveCluster::copy(
  self : BioseqalignprogressiveCluster,
) -> BioseqalignprogressiveCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveCluster::fill(
  self : BioseqalignprogressiveCluster,
  v : Double,
) -> BioseqalignprogressiveCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveCluster::min(
  self : BioseqalignprogressiveCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveCluster::max(
  self : BioseqalignprogressiveCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveCluster::to_string(
  self : BioseqalignprogressiveCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_model_make(
  size : Int32,
) -> BioseqalignprogressiveModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveModel::len(
  self : BioseqalignprogressiveModel,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveModel::get(
  self : BioseqalignprogressiveModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveModel::set(
  self : BioseqalignprogressiveModel,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveModel::sum(
  self : BioseqalignprogressiveModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveModel::mean(
  self : BioseqalignprogressiveModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveModel::scale(
  self : BioseqalignprogressiveModel,
  f : Double,
) -> BioseqalignprogressiveModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveModel::add(
  self : BioseqalignprogressiveModel,
  other : BioseqalignprogressiveModel,
) -> BioseqalignprogressiveModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveModel::copy(
  self : BioseqalignprogressiveModel,
) -> BioseqalignprogressiveModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveModel::fill(
  self : BioseqalignprogressiveModel,
  v : Double,
) -> BioseqalignprogressiveModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveModel::min(
  self : BioseqalignprogressiveModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveModel::max(
  self : BioseqalignprogressiveModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveModel::to_string(
  self : BioseqalignprogressiveModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_layer_make(
  size : Int32,
) -> BioseqalignprogressiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveLayer::len(
  self : BioseqalignprogressiveLayer,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveLayer::get(
  self : BioseqalignprogressiveLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveLayer::set(
  self : BioseqalignprogressiveLayer,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveLayer::sum(
  self : BioseqalignprogressiveLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveLayer::mean(
  self : BioseqalignprogressiveLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveLayer::scale(
  self : BioseqalignprogressiveLayer,
  f : Double,
) -> BioseqalignprogressiveLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveLayer::add(
  self : BioseqalignprogressiveLayer,
  other : BioseqalignprogressiveLayer,
) -> BioseqalignprogressiveLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveLayer::copy(
  self : BioseqalignprogressiveLayer,
) -> BioseqalignprogressiveLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveLayer::fill(
  self : BioseqalignprogressiveLayer,
  v : Double,
) -> BioseqalignprogressiveLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveLayer::min(
  self : BioseqalignprogressiveLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveLayer::max(
  self : BioseqalignprogressiveLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveLayer::to_string(
  self : BioseqalignprogressiveLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_buffer_make(
  size : Int32,
) -> BioseqalignprogressiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveBuffer::len(
  self : BioseqalignprogressiveBuffer,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveBuffer::get(
  self : BioseqalignprogressiveBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveBuffer::set(
  self : BioseqalignprogressiveBuffer,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveBuffer::sum(
  self : BioseqalignprogressiveBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveBuffer::mean(
  self : BioseqalignprogressiveBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveBuffer::scale(
  self : BioseqalignprogressiveBuffer,
  f : Double,
) -> BioseqalignprogressiveBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveBuffer::add(
  self : BioseqalignprogressiveBuffer,
  other : BioseqalignprogressiveBuffer,
) -> BioseqalignprogressiveBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveBuffer::copy(
  self : BioseqalignprogressiveBuffer,
) -> BioseqalignprogressiveBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveBuffer::fill(
  self : BioseqalignprogressiveBuffer,
  v : Double,
) -> BioseqalignprogressiveBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveBuffer::min(
  self : BioseqalignprogressiveBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveBuffer::max(
  self : BioseqalignprogressiveBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveBuffer::to_string(
  self : BioseqalignprogressiveBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_cursor_make(
  size : Int32,
) -> BioseqalignprogressiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveCursor::len(
  self : BioseqalignprogressiveCursor,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveCursor::get(
  self : BioseqalignprogressiveCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveCursor::set(
  self : BioseqalignprogressiveCursor,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveCursor::sum(
  self : BioseqalignprogressiveCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveCursor::mean(
  self : BioseqalignprogressiveCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveCursor::scale(
  self : BioseqalignprogressiveCursor,
  f : Double,
) -> BioseqalignprogressiveCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveCursor::add(
  self : BioseqalignprogressiveCursor,
  other : BioseqalignprogressiveCursor,
) -> BioseqalignprogressiveCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveCursor::copy(
  self : BioseqalignprogressiveCursor,
) -> BioseqalignprogressiveCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveCursor::fill(
  self : BioseqalignprogressiveCursor,
  v : Double,
) -> BioseqalignprogressiveCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveCursor::min(
  self : BioseqalignprogressiveCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveCursor::max(
  self : BioseqalignprogressiveCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveCursor::to_string(
  self : BioseqalignprogressiveCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_view_make(
  size : Int32,
) -> BioseqalignprogressiveView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveView::len(
  self : BioseqalignprogressiveView,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveView::get(
  self : BioseqalignprogressiveView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveView::set(
  self : BioseqalignprogressiveView,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveView::sum(
  self : BioseqalignprogressiveView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveView::mean(
  self : BioseqalignprogressiveView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveView::scale(
  self : BioseqalignprogressiveView,
  f : Double,
) -> BioseqalignprogressiveView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveView::add(
  self : BioseqalignprogressiveView,
  other : BioseqalignprogressiveView,
) -> BioseqalignprogressiveView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveView::copy(
  self : BioseqalignprogressiveView,
) -> BioseqalignprogressiveView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveView::fill(
  self : BioseqalignprogressiveView,
  v : Double,
) -> BioseqalignprogressiveView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveView::min(
  self : BioseqalignprogressiveView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveView::max(
  self : BioseqalignprogressiveView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveView::to_string(
  self : BioseqalignprogressiveView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_range_make(
  size : Int32,
) -> BioseqalignprogressiveRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveRange::len(
  self : BioseqalignprogressiveRange,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveRange::get(
  self : BioseqalignprogressiveRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveRange::set(
  self : BioseqalignprogressiveRange,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveRange::sum(
  self : BioseqalignprogressiveRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveRange::mean(
  self : BioseqalignprogressiveRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveRange::scale(
  self : BioseqalignprogressiveRange,
  f : Double,
) -> BioseqalignprogressiveRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveRange::add(
  self : BioseqalignprogressiveRange,
  other : BioseqalignprogressiveRange,
) -> BioseqalignprogressiveRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveRange::copy(
  self : BioseqalignprogressiveRange,
) -> BioseqalignprogressiveRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveRange::fill(
  self : BioseqalignprogressiveRange,
  v : Double,
) -> BioseqalignprogressiveRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveRange::min(
  self : BioseqalignprogressiveRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveRange::max(
  self : BioseqalignprogressiveRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveRange::to_string(
  self : BioseqalignprogressiveRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignprogressiveSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_progressive_slice_make(
  size : Int32,
) -> BioseqalignprogressiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignprogressiveSlice::len(
  self : BioseqalignprogressiveSlice,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignprogressiveSlice::get(
  self : BioseqalignprogressiveSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignprogressiveSlice::set(
  self : BioseqalignprogressiveSlice,
  i : Int32,
  v : Double,
) -> BioseqalignprogressiveSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveSlice::sum(
  self : BioseqalignprogressiveSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignprogressiveSlice::mean(
  self : BioseqalignprogressiveSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignprogressiveSlice::scale(
  self : BioseqalignprogressiveSlice,
  f : Double,
) -> BioseqalignprogressiveSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveSlice::add(
  self : BioseqalignprogressiveSlice,
  other : BioseqalignprogressiveSlice,
) -> BioseqalignprogressiveSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveSlice::copy(
  self : BioseqalignprogressiveSlice,
) -> BioseqalignprogressiveSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveSlice::fill(
  self : BioseqalignprogressiveSlice,
  v : Double,
) -> BioseqalignprogressiveSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignprogressiveSlice::min(
  self : BioseqalignprogressiveSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignprogressiveSlice::max(
  self : BioseqalignprogressiveSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignprogressiveSlice::to_string(
  self : BioseqalignprogressiveSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
