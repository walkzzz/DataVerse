///|
///===
/// extcore/bio_seq_align_local
pub(all) struct BioseqalignlocalPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn bio_seq_align_local_make_point(
  x : Double,
  y : Double,
) -> BioseqalignlocalPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn bio_seq_align_local_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> BioseqalignlocalPoint {
  { x, y, z, label: 0, }
}

///|
pub fn BioseqalignlocalPoint::x(self : BioseqalignlocalPoint) -> Double {
  self.x
}

///|
pub fn BioseqalignlocalPoint::y(self : BioseqalignlocalPoint) -> Double {
  self.y
}

///|
pub fn BioseqalignlocalPoint::z(self : BioseqalignlocalPoint) -> Double {
  self.z
}

///|
pub fn BioseqalignlocalPoint::label(self : BioseqalignlocalPoint) -> Int32 {
  self.label
}

///|
pub fn BioseqalignlocalPoint::dist(
  self : BioseqalignlocalPoint,
  other : BioseqalignlocalPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn BioseqalignlocalPoint::add(
  self : BioseqalignlocalPoint,
  other : BioseqalignlocalPoint,
) -> BioseqalignlocalPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn BioseqalignlocalPoint::sub(
  self : BioseqalignlocalPoint,
  other : BioseqalignlocalPoint,
) -> BioseqalignlocalPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn BioseqalignlocalPoint::scale(
  self : BioseqalignlocalPoint,
  s : Double,
) -> BioseqalignlocalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn BioseqalignlocalPoint::dot(
  self : BioseqalignlocalPoint,
  other : BioseqalignlocalPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn BioseqalignlocalPoint::cross(
  self : BioseqalignlocalPoint,
  other : BioseqalignlocalPoint,
) -> BioseqalignlocalPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn BioseqalignlocalPoint::norm(self : BioseqalignlocalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn BioseqalignlocalPoint::normalize(
  self : BioseqalignlocalPoint,
) -> BioseqalignlocalPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BioseqalignlocalPoint::negate(
  self : BioseqalignlocalPoint,
) -> BioseqalignlocalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn BioseqalignlocalPoint::mid(
  self : BioseqalignlocalPoint,
  other : BioseqalignlocalPoint,
) -> BioseqalignlocalPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn BioseqalignlocalPoint::lerp(
  self : BioseqalignlocalPoint,
  other : BioseqalignlocalPoint,
  t : Double,
) -> BioseqalignlocalPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn BioseqalignlocalPoint::to_string(self : BioseqalignlocalPoint) -> String {
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
pub(all) struct BioseqalignlocalSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn bio_seq_align_local_make_series(
  vals : Array[Double],
  name : String,
) -> BioseqalignlocalSeries {
  { vals, name, meta: 0, }
}

///|
pub fn BioseqalignlocalSeries::len(self : BioseqalignlocalSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn BioseqalignlocalSeries::sum(self : BioseqalignlocalSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn BioseqalignlocalSeries::mean(self : BioseqalignlocalSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn BioseqalignlocalSeries::min(self : BioseqalignlocalSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn BioseqalignlocalSeries::max(self : BioseqalignlocalSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn BioseqalignlocalSeries::range(self : BioseqalignlocalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn BioseqalignlocalSeries::variance(
  self : BioseqalignlocalSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn BioseqalignlocalSeries::std(self : BioseqalignlocalSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn BioseqalignlocalSeries::median(self : BioseqalignlocalSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn BioseqalignlocalSeries::scale(
  self : BioseqalignlocalSeries,
  f : Double,
) -> BioseqalignlocalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn BioseqalignlocalSeries::add(
  self : BioseqalignlocalSeries,
  other : BioseqalignlocalSeries,
) -> BioseqalignlocalSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BioseqalignlocalSeries::sub(
  self : BioseqalignlocalSeries,
  other : BioseqalignlocalSeries,
) -> BioseqalignlocalSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BioseqalignlocalSeries::normalize(
  self : BioseqalignlocalSeries,
) -> BioseqalignlocalSeries {
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
pub fn BioseqalignlocalSeries::cumsum(
  self : BioseqalignlocalSeries,
) -> BioseqalignlocalSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn BioseqalignlocalSeries::to_string(
  self : BioseqalignlocalSeries,
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
pub(all) struct BioseqalignlocalMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn bio_seq_align_local_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> BioseqalignlocalMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn bio_seq_align_local_matrix_identity(n : Int32) -> BioseqalignlocalMatrix {
  let m = bio_seq_align_local_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn BioseqalignlocalMatrix::get(
  self : BioseqalignlocalMatrix,
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
pub fn BioseqalignlocalMatrix::transpose(
  self : BioseqalignlocalMatrix,
) -> BioseqalignlocalMatrix {
  let result = bio_seq_align_local_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn BioseqalignlocalMatrix::add(
  self : BioseqalignlocalMatrix,
  other : BioseqalignlocalMatrix,
) -> BioseqalignlocalMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = bio_seq_align_local_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn BioseqalignlocalMatrix::scale(
  self : BioseqalignlocalMatrix,
  s : Double,
) -> BioseqalignlocalMatrix {
  let result = bio_seq_align_local_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn BioseqalignlocalMatrix::multiply(
  self : BioseqalignlocalMatrix,
  other : BioseqalignlocalMatrix,
) -> BioseqalignlocalMatrix {
  if self.cols != other.rows {
    return bio_seq_align_local_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = bio_seq_align_local_make_matrix(self.rows, other.cols, 0.0)
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
pub fn BioseqalignlocalMatrix::trace(self : BioseqalignlocalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn BioseqalignlocalMatrix::det(self : BioseqalignlocalMatrix) -> Double {
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
pub fn BioseqalignlocalMatrix::norm(self : BioseqalignlocalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn BioseqalignlocalMatrix::to_string(
  self : BioseqalignlocalMatrix,
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
pub(all) struct BioseqalignlocalVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn bio_seq_align_local_make_vector(
  comps : Array[Double],
) -> BioseqalignlocalVector {
  { comps, dim: comps.length(), }
}

///|
pub fn bio_seq_align_local_vector_zero(dim : Int32) -> BioseqalignlocalVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn BioseqalignlocalVector::add(
  self : BioseqalignlocalVector,
  other : BioseqalignlocalVector,
) -> BioseqalignlocalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BioseqalignlocalVector::sub(
  self : BioseqalignlocalVector,
  other : BioseqalignlocalVector,
) -> BioseqalignlocalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BioseqalignlocalVector::scale(
  self : BioseqalignlocalVector,
  s : Double,
) -> BioseqalignlocalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn BioseqalignlocalVector::dot(
  self : BioseqalignlocalVector,
  other : BioseqalignlocalVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn BioseqalignlocalVector::norm(self : BioseqalignlocalVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn BioseqalignlocalVector::normalize(
  self : BioseqalignlocalVector,
) -> BioseqalignlocalVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BioseqalignlocalVector::dist(
  self : BioseqalignlocalVector,
  other : BioseqalignlocalVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn BioseqalignlocalVector::to_string(
  self : BioseqalignlocalVector,
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
pub(all) struct BioseqalignlocalFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_frame_make(size : Int32) -> BioseqalignlocalFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalFrame::len(self : BioseqalignlocalFrame) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalFrame::get(
  self : BioseqalignlocalFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalFrame::set(
  self : BioseqalignlocalFrame,
  i : Int32,
  v : Double,
) -> BioseqalignlocalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalFrame::sum(self : BioseqalignlocalFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalFrame::mean(self : BioseqalignlocalFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalFrame::scale(
  self : BioseqalignlocalFrame,
  f : Double,
) -> BioseqalignlocalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalFrame::add(
  self : BioseqalignlocalFrame,
  other : BioseqalignlocalFrame,
) -> BioseqalignlocalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalFrame::copy(
  self : BioseqalignlocalFrame,
) -> BioseqalignlocalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalFrame::fill(
  self : BioseqalignlocalFrame,
  v : Double,
) -> BioseqalignlocalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalFrame::min(self : BioseqalignlocalFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalFrame::max(self : BioseqalignlocalFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalFrame::to_string(self : BioseqalignlocalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_table_make(size : Int32) -> BioseqalignlocalTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalTable::len(self : BioseqalignlocalTable) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalTable::get(
  self : BioseqalignlocalTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalTable::set(
  self : BioseqalignlocalTable,
  i : Int32,
  v : Double,
) -> BioseqalignlocalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalTable::sum(self : BioseqalignlocalTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalTable::mean(self : BioseqalignlocalTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalTable::scale(
  self : BioseqalignlocalTable,
  f : Double,
) -> BioseqalignlocalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalTable::add(
  self : BioseqalignlocalTable,
  other : BioseqalignlocalTable,
) -> BioseqalignlocalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalTable::copy(
  self : BioseqalignlocalTable,
) -> BioseqalignlocalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalTable::fill(
  self : BioseqalignlocalTable,
  v : Double,
) -> BioseqalignlocalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalTable::min(self : BioseqalignlocalTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalTable::max(self : BioseqalignlocalTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalTable::to_string(self : BioseqalignlocalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_graphn_make(size : Int32) -> BioseqalignlocalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalGraphN::len(self : BioseqalignlocalGraphN) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalGraphN::get(
  self : BioseqalignlocalGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalGraphN::set(
  self : BioseqalignlocalGraphN,
  i : Int32,
  v : Double,
) -> BioseqalignlocalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalGraphN::sum(self : BioseqalignlocalGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalGraphN::mean(self : BioseqalignlocalGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalGraphN::scale(
  self : BioseqalignlocalGraphN,
  f : Double,
) -> BioseqalignlocalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalGraphN::add(
  self : BioseqalignlocalGraphN,
  other : BioseqalignlocalGraphN,
) -> BioseqalignlocalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalGraphN::copy(
  self : BioseqalignlocalGraphN,
) -> BioseqalignlocalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalGraphN::fill(
  self : BioseqalignlocalGraphN,
  v : Double,
) -> BioseqalignlocalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalGraphN::min(self : BioseqalignlocalGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalGraphN::max(self : BioseqalignlocalGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalGraphN::to_string(
  self : BioseqalignlocalGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_node_make(size : Int32) -> BioseqalignlocalNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalNode::len(self : BioseqalignlocalNode) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalNode::get(
  self : BioseqalignlocalNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalNode::set(
  self : BioseqalignlocalNode,
  i : Int32,
  v : Double,
) -> BioseqalignlocalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalNode::sum(self : BioseqalignlocalNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalNode::mean(self : BioseqalignlocalNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalNode::scale(
  self : BioseqalignlocalNode,
  f : Double,
) -> BioseqalignlocalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalNode::add(
  self : BioseqalignlocalNode,
  other : BioseqalignlocalNode,
) -> BioseqalignlocalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalNode::copy(
  self : BioseqalignlocalNode,
) -> BioseqalignlocalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalNode::fill(
  self : BioseqalignlocalNode,
  v : Double,
) -> BioseqalignlocalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalNode::min(self : BioseqalignlocalNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalNode::max(self : BioseqalignlocalNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalNode::to_string(self : BioseqalignlocalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_edge_make(size : Int32) -> BioseqalignlocalEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalEdge::len(self : BioseqalignlocalEdge) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalEdge::get(
  self : BioseqalignlocalEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalEdge::set(
  self : BioseqalignlocalEdge,
  i : Int32,
  v : Double,
) -> BioseqalignlocalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalEdge::sum(self : BioseqalignlocalEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalEdge::mean(self : BioseqalignlocalEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalEdge::scale(
  self : BioseqalignlocalEdge,
  f : Double,
) -> BioseqalignlocalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalEdge::add(
  self : BioseqalignlocalEdge,
  other : BioseqalignlocalEdge,
) -> BioseqalignlocalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalEdge::copy(
  self : BioseqalignlocalEdge,
) -> BioseqalignlocalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalEdge::fill(
  self : BioseqalignlocalEdge,
  v : Double,
) -> BioseqalignlocalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalEdge::min(self : BioseqalignlocalEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalEdge::max(self : BioseqalignlocalEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalEdge::to_string(self : BioseqalignlocalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_path_make(size : Int32) -> BioseqalignlocalPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalPath::len(self : BioseqalignlocalPath) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalPath::get(
  self : BioseqalignlocalPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalPath::set(
  self : BioseqalignlocalPath,
  i : Int32,
  v : Double,
) -> BioseqalignlocalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalPath::sum(self : BioseqalignlocalPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalPath::mean(self : BioseqalignlocalPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalPath::scale(
  self : BioseqalignlocalPath,
  f : Double,
) -> BioseqalignlocalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalPath::add(
  self : BioseqalignlocalPath,
  other : BioseqalignlocalPath,
) -> BioseqalignlocalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalPath::copy(
  self : BioseqalignlocalPath,
) -> BioseqalignlocalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalPath::fill(
  self : BioseqalignlocalPath,
  v : Double,
) -> BioseqalignlocalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalPath::min(self : BioseqalignlocalPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalPath::max(self : BioseqalignlocalPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalPath::to_string(self : BioseqalignlocalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_cluster_make(
  size : Int32,
) -> BioseqalignlocalCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalCluster::len(self : BioseqalignlocalCluster) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalCluster::get(
  self : BioseqalignlocalCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalCluster::set(
  self : BioseqalignlocalCluster,
  i : Int32,
  v : Double,
) -> BioseqalignlocalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalCluster::sum(self : BioseqalignlocalCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalCluster::mean(self : BioseqalignlocalCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalCluster::scale(
  self : BioseqalignlocalCluster,
  f : Double,
) -> BioseqalignlocalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalCluster::add(
  self : BioseqalignlocalCluster,
  other : BioseqalignlocalCluster,
) -> BioseqalignlocalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalCluster::copy(
  self : BioseqalignlocalCluster,
) -> BioseqalignlocalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalCluster::fill(
  self : BioseqalignlocalCluster,
  v : Double,
) -> BioseqalignlocalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalCluster::min(self : BioseqalignlocalCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalCluster::max(self : BioseqalignlocalCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalCluster::to_string(
  self : BioseqalignlocalCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_model_make(size : Int32) -> BioseqalignlocalModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalModel::len(self : BioseqalignlocalModel) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalModel::get(
  self : BioseqalignlocalModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalModel::set(
  self : BioseqalignlocalModel,
  i : Int32,
  v : Double,
) -> BioseqalignlocalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalModel::sum(self : BioseqalignlocalModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalModel::mean(self : BioseqalignlocalModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalModel::scale(
  self : BioseqalignlocalModel,
  f : Double,
) -> BioseqalignlocalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalModel::add(
  self : BioseqalignlocalModel,
  other : BioseqalignlocalModel,
) -> BioseqalignlocalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalModel::copy(
  self : BioseqalignlocalModel,
) -> BioseqalignlocalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalModel::fill(
  self : BioseqalignlocalModel,
  v : Double,
) -> BioseqalignlocalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalModel::min(self : BioseqalignlocalModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalModel::max(self : BioseqalignlocalModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalModel::to_string(self : BioseqalignlocalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_layer_make(size : Int32) -> BioseqalignlocalLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalLayer::len(self : BioseqalignlocalLayer) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalLayer::get(
  self : BioseqalignlocalLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalLayer::set(
  self : BioseqalignlocalLayer,
  i : Int32,
  v : Double,
) -> BioseqalignlocalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalLayer::sum(self : BioseqalignlocalLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalLayer::mean(self : BioseqalignlocalLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalLayer::scale(
  self : BioseqalignlocalLayer,
  f : Double,
) -> BioseqalignlocalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalLayer::add(
  self : BioseqalignlocalLayer,
  other : BioseqalignlocalLayer,
) -> BioseqalignlocalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalLayer::copy(
  self : BioseqalignlocalLayer,
) -> BioseqalignlocalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalLayer::fill(
  self : BioseqalignlocalLayer,
  v : Double,
) -> BioseqalignlocalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalLayer::min(self : BioseqalignlocalLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalLayer::max(self : BioseqalignlocalLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalLayer::to_string(self : BioseqalignlocalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_buffer_make(size : Int32) -> BioseqalignlocalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalBuffer::len(self : BioseqalignlocalBuffer) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalBuffer::get(
  self : BioseqalignlocalBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalBuffer::set(
  self : BioseqalignlocalBuffer,
  i : Int32,
  v : Double,
) -> BioseqalignlocalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalBuffer::sum(self : BioseqalignlocalBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalBuffer::mean(self : BioseqalignlocalBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalBuffer::scale(
  self : BioseqalignlocalBuffer,
  f : Double,
) -> BioseqalignlocalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalBuffer::add(
  self : BioseqalignlocalBuffer,
  other : BioseqalignlocalBuffer,
) -> BioseqalignlocalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalBuffer::copy(
  self : BioseqalignlocalBuffer,
) -> BioseqalignlocalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalBuffer::fill(
  self : BioseqalignlocalBuffer,
  v : Double,
) -> BioseqalignlocalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalBuffer::min(self : BioseqalignlocalBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalBuffer::max(self : BioseqalignlocalBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalBuffer::to_string(
  self : BioseqalignlocalBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_cursor_make(size : Int32) -> BioseqalignlocalCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalCursor::len(self : BioseqalignlocalCursor) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalCursor::get(
  self : BioseqalignlocalCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalCursor::set(
  self : BioseqalignlocalCursor,
  i : Int32,
  v : Double,
) -> BioseqalignlocalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalCursor::sum(self : BioseqalignlocalCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalCursor::mean(self : BioseqalignlocalCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalCursor::scale(
  self : BioseqalignlocalCursor,
  f : Double,
) -> BioseqalignlocalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalCursor::add(
  self : BioseqalignlocalCursor,
  other : BioseqalignlocalCursor,
) -> BioseqalignlocalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalCursor::copy(
  self : BioseqalignlocalCursor,
) -> BioseqalignlocalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalCursor::fill(
  self : BioseqalignlocalCursor,
  v : Double,
) -> BioseqalignlocalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalCursor::min(self : BioseqalignlocalCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalCursor::max(self : BioseqalignlocalCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalCursor::to_string(
  self : BioseqalignlocalCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_view_make(size : Int32) -> BioseqalignlocalView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalView::len(self : BioseqalignlocalView) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalView::get(
  self : BioseqalignlocalView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalView::set(
  self : BioseqalignlocalView,
  i : Int32,
  v : Double,
) -> BioseqalignlocalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalView::sum(self : BioseqalignlocalView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalView::mean(self : BioseqalignlocalView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalView::scale(
  self : BioseqalignlocalView,
  f : Double,
) -> BioseqalignlocalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalView::add(
  self : BioseqalignlocalView,
  other : BioseqalignlocalView,
) -> BioseqalignlocalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalView::copy(
  self : BioseqalignlocalView,
) -> BioseqalignlocalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalView::fill(
  self : BioseqalignlocalView,
  v : Double,
) -> BioseqalignlocalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalView::min(self : BioseqalignlocalView) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalView::max(self : BioseqalignlocalView) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalView::to_string(self : BioseqalignlocalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_range_make(size : Int32) -> BioseqalignlocalRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalRange::len(self : BioseqalignlocalRange) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalRange::get(
  self : BioseqalignlocalRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalRange::set(
  self : BioseqalignlocalRange,
  i : Int32,
  v : Double,
) -> BioseqalignlocalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalRange::sum(self : BioseqalignlocalRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalRange::mean(self : BioseqalignlocalRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalRange::scale(
  self : BioseqalignlocalRange,
  f : Double,
) -> BioseqalignlocalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalRange::add(
  self : BioseqalignlocalRange,
  other : BioseqalignlocalRange,
) -> BioseqalignlocalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalRange::copy(
  self : BioseqalignlocalRange,
) -> BioseqalignlocalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalRange::fill(
  self : BioseqalignlocalRange,
  v : Double,
) -> BioseqalignlocalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalRange::min(self : BioseqalignlocalRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalRange::max(self : BioseqalignlocalRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalRange::to_string(self : BioseqalignlocalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignlocalSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_local_slice_make(size : Int32) -> BioseqalignlocalSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignlocalSlice::len(self : BioseqalignlocalSlice) -> Int32 {
  self.size
}

///|
pub fn BioseqalignlocalSlice::get(
  self : BioseqalignlocalSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignlocalSlice::set(
  self : BioseqalignlocalSlice,
  i : Int32,
  v : Double,
) -> BioseqalignlocalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalSlice::sum(self : BioseqalignlocalSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignlocalSlice::mean(self : BioseqalignlocalSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignlocalSlice::scale(
  self : BioseqalignlocalSlice,
  f : Double,
) -> BioseqalignlocalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalSlice::add(
  self : BioseqalignlocalSlice,
  other : BioseqalignlocalSlice,
) -> BioseqalignlocalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignlocalSlice::copy(
  self : BioseqalignlocalSlice,
) -> BioseqalignlocalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalSlice::fill(
  self : BioseqalignlocalSlice,
  v : Double,
) -> BioseqalignlocalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignlocalSlice::min(self : BioseqalignlocalSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignlocalSlice::max(self : BioseqalignlocalSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignlocalSlice::to_string(self : BioseqalignlocalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
