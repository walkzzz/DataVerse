///|
///===
/// extcore/bio_seq_align_pairwise
pub(all) struct BioseqalignpairwisePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn bio_seq_align_pairwise_make_point(
  x : Double,
  y : Double,
) -> BioseqalignpairwisePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn bio_seq_align_pairwise_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> BioseqalignpairwisePoint {
  { x, y, z, label: 0, }
}

///|
pub fn BioseqalignpairwisePoint::x(self : BioseqalignpairwisePoint) -> Double {
  self.x
}

///|
pub fn BioseqalignpairwisePoint::y(self : BioseqalignpairwisePoint) -> Double {
  self.y
}

///|
pub fn BioseqalignpairwisePoint::z(self : BioseqalignpairwisePoint) -> Double {
  self.z
}

///|
pub fn BioseqalignpairwisePoint::label(
  self : BioseqalignpairwisePoint,
) -> Int32 {
  self.label
}

///|
pub fn BioseqalignpairwisePoint::dist(
  self : BioseqalignpairwisePoint,
  other : BioseqalignpairwisePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn BioseqalignpairwisePoint::add(
  self : BioseqalignpairwisePoint,
  other : BioseqalignpairwisePoint,
) -> BioseqalignpairwisePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn BioseqalignpairwisePoint::sub(
  self : BioseqalignpairwisePoint,
  other : BioseqalignpairwisePoint,
) -> BioseqalignpairwisePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn BioseqalignpairwisePoint::scale(
  self : BioseqalignpairwisePoint,
  s : Double,
) -> BioseqalignpairwisePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn BioseqalignpairwisePoint::dot(
  self : BioseqalignpairwisePoint,
  other : BioseqalignpairwisePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn BioseqalignpairwisePoint::cross(
  self : BioseqalignpairwisePoint,
  other : BioseqalignpairwisePoint,
) -> BioseqalignpairwisePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn BioseqalignpairwisePoint::norm(
  self : BioseqalignpairwisePoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn BioseqalignpairwisePoint::normalize(
  self : BioseqalignpairwisePoint,
) -> BioseqalignpairwisePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BioseqalignpairwisePoint::negate(
  self : BioseqalignpairwisePoint,
) -> BioseqalignpairwisePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn BioseqalignpairwisePoint::mid(
  self : BioseqalignpairwisePoint,
  other : BioseqalignpairwisePoint,
) -> BioseqalignpairwisePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn BioseqalignpairwisePoint::lerp(
  self : BioseqalignpairwisePoint,
  other : BioseqalignpairwisePoint,
  t : Double,
) -> BioseqalignpairwisePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn BioseqalignpairwisePoint::to_string(
  self : BioseqalignpairwisePoint,
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
pub(all) struct BioseqalignpairwiseSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn bio_seq_align_pairwise_make_series(
  vals : Array[Double],
  name : String,
) -> BioseqalignpairwiseSeries {
  { vals, name, meta: 0, }
}

///|
pub fn BioseqalignpairwiseSeries::len(
  self : BioseqalignpairwiseSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn BioseqalignpairwiseSeries::sum(
  self : BioseqalignpairwiseSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn BioseqalignpairwiseSeries::mean(
  self : BioseqalignpairwiseSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn BioseqalignpairwiseSeries::min(
  self : BioseqalignpairwiseSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn BioseqalignpairwiseSeries::max(
  self : BioseqalignpairwiseSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn BioseqalignpairwiseSeries::range(
  self : BioseqalignpairwiseSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn BioseqalignpairwiseSeries::variance(
  self : BioseqalignpairwiseSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn BioseqalignpairwiseSeries::std(
  self : BioseqalignpairwiseSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn BioseqalignpairwiseSeries::median(
  self : BioseqalignpairwiseSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn BioseqalignpairwiseSeries::scale(
  self : BioseqalignpairwiseSeries,
  f : Double,
) -> BioseqalignpairwiseSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn BioseqalignpairwiseSeries::add(
  self : BioseqalignpairwiseSeries,
  other : BioseqalignpairwiseSeries,
) -> BioseqalignpairwiseSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BioseqalignpairwiseSeries::sub(
  self : BioseqalignpairwiseSeries,
  other : BioseqalignpairwiseSeries,
) -> BioseqalignpairwiseSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BioseqalignpairwiseSeries::normalize(
  self : BioseqalignpairwiseSeries,
) -> BioseqalignpairwiseSeries {
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
pub fn BioseqalignpairwiseSeries::cumsum(
  self : BioseqalignpairwiseSeries,
) -> BioseqalignpairwiseSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn BioseqalignpairwiseSeries::to_string(
  self : BioseqalignpairwiseSeries,
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
pub(all) struct BioseqalignpairwiseMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn bio_seq_align_pairwise_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> BioseqalignpairwiseMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn bio_seq_align_pairwise_matrix_identity(
  n : Int32,
) -> BioseqalignpairwiseMatrix {
  let m = bio_seq_align_pairwise_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn BioseqalignpairwiseMatrix::get(
  self : BioseqalignpairwiseMatrix,
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
pub fn BioseqalignpairwiseMatrix::transpose(
  self : BioseqalignpairwiseMatrix,
) -> BioseqalignpairwiseMatrix {
  let result = bio_seq_align_pairwise_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn BioseqalignpairwiseMatrix::add(
  self : BioseqalignpairwiseMatrix,
  other : BioseqalignpairwiseMatrix,
) -> BioseqalignpairwiseMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = bio_seq_align_pairwise_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn BioseqalignpairwiseMatrix::scale(
  self : BioseqalignpairwiseMatrix,
  s : Double,
) -> BioseqalignpairwiseMatrix {
  let result = bio_seq_align_pairwise_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn BioseqalignpairwiseMatrix::multiply(
  self : BioseqalignpairwiseMatrix,
  other : BioseqalignpairwiseMatrix,
) -> BioseqalignpairwiseMatrix {
  if self.cols != other.rows {
    return bio_seq_align_pairwise_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = bio_seq_align_pairwise_make_matrix(self.rows, other.cols, 0.0)
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
pub fn BioseqalignpairwiseMatrix::trace(
  self : BioseqalignpairwiseMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn BioseqalignpairwiseMatrix::det(
  self : BioseqalignpairwiseMatrix,
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
pub fn BioseqalignpairwiseMatrix::norm(
  self : BioseqalignpairwiseMatrix,
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
pub fn BioseqalignpairwiseMatrix::to_string(
  self : BioseqalignpairwiseMatrix,
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
pub(all) struct BioseqalignpairwiseVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn bio_seq_align_pairwise_make_vector(
  comps : Array[Double],
) -> BioseqalignpairwiseVector {
  { comps, dim: comps.length(), }
}

///|
pub fn bio_seq_align_pairwise_vector_zero(
  dim : Int32,
) -> BioseqalignpairwiseVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn BioseqalignpairwiseVector::add(
  self : BioseqalignpairwiseVector,
  other : BioseqalignpairwiseVector,
) -> BioseqalignpairwiseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BioseqalignpairwiseVector::sub(
  self : BioseqalignpairwiseVector,
  other : BioseqalignpairwiseVector,
) -> BioseqalignpairwiseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BioseqalignpairwiseVector::scale(
  self : BioseqalignpairwiseVector,
  s : Double,
) -> BioseqalignpairwiseVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn BioseqalignpairwiseVector::dot(
  self : BioseqalignpairwiseVector,
  other : BioseqalignpairwiseVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn BioseqalignpairwiseVector::norm(
  self : BioseqalignpairwiseVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn BioseqalignpairwiseVector::normalize(
  self : BioseqalignpairwiseVector,
) -> BioseqalignpairwiseVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BioseqalignpairwiseVector::dist(
  self : BioseqalignpairwiseVector,
  other : BioseqalignpairwiseVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn BioseqalignpairwiseVector::to_string(
  self : BioseqalignpairwiseVector,
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
pub(all) struct BioseqalignpairwiseFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_frame_make(
  size : Int32,
) -> BioseqalignpairwiseFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseFrame::len(self : BioseqalignpairwiseFrame) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseFrame::get(
  self : BioseqalignpairwiseFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseFrame::set(
  self : BioseqalignpairwiseFrame,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseFrame::sum(self : BioseqalignpairwiseFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseFrame::mean(
  self : BioseqalignpairwiseFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseFrame::scale(
  self : BioseqalignpairwiseFrame,
  f : Double,
) -> BioseqalignpairwiseFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseFrame::add(
  self : BioseqalignpairwiseFrame,
  other : BioseqalignpairwiseFrame,
) -> BioseqalignpairwiseFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseFrame::copy(
  self : BioseqalignpairwiseFrame,
) -> BioseqalignpairwiseFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseFrame::fill(
  self : BioseqalignpairwiseFrame,
  v : Double,
) -> BioseqalignpairwiseFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseFrame::min(self : BioseqalignpairwiseFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseFrame::max(self : BioseqalignpairwiseFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseFrame::to_string(
  self : BioseqalignpairwiseFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_table_make(
  size : Int32,
) -> BioseqalignpairwiseTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseTable::len(self : BioseqalignpairwiseTable) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseTable::get(
  self : BioseqalignpairwiseTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseTable::set(
  self : BioseqalignpairwiseTable,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseTable::sum(self : BioseqalignpairwiseTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseTable::mean(
  self : BioseqalignpairwiseTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseTable::scale(
  self : BioseqalignpairwiseTable,
  f : Double,
) -> BioseqalignpairwiseTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseTable::add(
  self : BioseqalignpairwiseTable,
  other : BioseqalignpairwiseTable,
) -> BioseqalignpairwiseTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseTable::copy(
  self : BioseqalignpairwiseTable,
) -> BioseqalignpairwiseTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseTable::fill(
  self : BioseqalignpairwiseTable,
  v : Double,
) -> BioseqalignpairwiseTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseTable::min(self : BioseqalignpairwiseTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseTable::max(self : BioseqalignpairwiseTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseTable::to_string(
  self : BioseqalignpairwiseTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_graphn_make(
  size : Int32,
) -> BioseqalignpairwiseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseGraphN::len(
  self : BioseqalignpairwiseGraphN,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseGraphN::get(
  self : BioseqalignpairwiseGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseGraphN::set(
  self : BioseqalignpairwiseGraphN,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseGraphN::sum(
  self : BioseqalignpairwiseGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseGraphN::mean(
  self : BioseqalignpairwiseGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseGraphN::scale(
  self : BioseqalignpairwiseGraphN,
  f : Double,
) -> BioseqalignpairwiseGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseGraphN::add(
  self : BioseqalignpairwiseGraphN,
  other : BioseqalignpairwiseGraphN,
) -> BioseqalignpairwiseGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseGraphN::copy(
  self : BioseqalignpairwiseGraphN,
) -> BioseqalignpairwiseGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseGraphN::fill(
  self : BioseqalignpairwiseGraphN,
  v : Double,
) -> BioseqalignpairwiseGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseGraphN::min(
  self : BioseqalignpairwiseGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseGraphN::max(
  self : BioseqalignpairwiseGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseGraphN::to_string(
  self : BioseqalignpairwiseGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_node_make(
  size : Int32,
) -> BioseqalignpairwiseNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseNode::len(self : BioseqalignpairwiseNode) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseNode::get(
  self : BioseqalignpairwiseNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseNode::set(
  self : BioseqalignpairwiseNode,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseNode::sum(self : BioseqalignpairwiseNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseNode::mean(self : BioseqalignpairwiseNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseNode::scale(
  self : BioseqalignpairwiseNode,
  f : Double,
) -> BioseqalignpairwiseNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseNode::add(
  self : BioseqalignpairwiseNode,
  other : BioseqalignpairwiseNode,
) -> BioseqalignpairwiseNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseNode::copy(
  self : BioseqalignpairwiseNode,
) -> BioseqalignpairwiseNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseNode::fill(
  self : BioseqalignpairwiseNode,
  v : Double,
) -> BioseqalignpairwiseNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseNode::min(self : BioseqalignpairwiseNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseNode::max(self : BioseqalignpairwiseNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseNode::to_string(
  self : BioseqalignpairwiseNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_edge_make(
  size : Int32,
) -> BioseqalignpairwiseEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseEdge::len(self : BioseqalignpairwiseEdge) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseEdge::get(
  self : BioseqalignpairwiseEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseEdge::set(
  self : BioseqalignpairwiseEdge,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseEdge::sum(self : BioseqalignpairwiseEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseEdge::mean(self : BioseqalignpairwiseEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseEdge::scale(
  self : BioseqalignpairwiseEdge,
  f : Double,
) -> BioseqalignpairwiseEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseEdge::add(
  self : BioseqalignpairwiseEdge,
  other : BioseqalignpairwiseEdge,
) -> BioseqalignpairwiseEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseEdge::copy(
  self : BioseqalignpairwiseEdge,
) -> BioseqalignpairwiseEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseEdge::fill(
  self : BioseqalignpairwiseEdge,
  v : Double,
) -> BioseqalignpairwiseEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseEdge::min(self : BioseqalignpairwiseEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseEdge::max(self : BioseqalignpairwiseEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseEdge::to_string(
  self : BioseqalignpairwiseEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwisePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_path_make(
  size : Int32,
) -> BioseqalignpairwisePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwisePath::len(self : BioseqalignpairwisePath) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwisePath::get(
  self : BioseqalignpairwisePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwisePath::set(
  self : BioseqalignpairwisePath,
  i : Int32,
  v : Double,
) -> BioseqalignpairwisePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwisePath::sum(self : BioseqalignpairwisePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwisePath::mean(self : BioseqalignpairwisePath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwisePath::scale(
  self : BioseqalignpairwisePath,
  f : Double,
) -> BioseqalignpairwisePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwisePath::add(
  self : BioseqalignpairwisePath,
  other : BioseqalignpairwisePath,
) -> BioseqalignpairwisePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwisePath::copy(
  self : BioseqalignpairwisePath,
) -> BioseqalignpairwisePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwisePath::fill(
  self : BioseqalignpairwisePath,
  v : Double,
) -> BioseqalignpairwisePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwisePath::min(self : BioseqalignpairwisePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwisePath::max(self : BioseqalignpairwisePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwisePath::to_string(
  self : BioseqalignpairwisePath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_cluster_make(
  size : Int32,
) -> BioseqalignpairwiseCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseCluster::len(
  self : BioseqalignpairwiseCluster,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseCluster::get(
  self : BioseqalignpairwiseCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseCluster::set(
  self : BioseqalignpairwiseCluster,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseCluster::sum(
  self : BioseqalignpairwiseCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseCluster::mean(
  self : BioseqalignpairwiseCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseCluster::scale(
  self : BioseqalignpairwiseCluster,
  f : Double,
) -> BioseqalignpairwiseCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseCluster::add(
  self : BioseqalignpairwiseCluster,
  other : BioseqalignpairwiseCluster,
) -> BioseqalignpairwiseCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseCluster::copy(
  self : BioseqalignpairwiseCluster,
) -> BioseqalignpairwiseCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseCluster::fill(
  self : BioseqalignpairwiseCluster,
  v : Double,
) -> BioseqalignpairwiseCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseCluster::min(
  self : BioseqalignpairwiseCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseCluster::max(
  self : BioseqalignpairwiseCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseCluster::to_string(
  self : BioseqalignpairwiseCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_model_make(
  size : Int32,
) -> BioseqalignpairwiseModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseModel::len(self : BioseqalignpairwiseModel) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseModel::get(
  self : BioseqalignpairwiseModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseModel::set(
  self : BioseqalignpairwiseModel,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseModel::sum(self : BioseqalignpairwiseModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseModel::mean(
  self : BioseqalignpairwiseModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseModel::scale(
  self : BioseqalignpairwiseModel,
  f : Double,
) -> BioseqalignpairwiseModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseModel::add(
  self : BioseqalignpairwiseModel,
  other : BioseqalignpairwiseModel,
) -> BioseqalignpairwiseModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseModel::copy(
  self : BioseqalignpairwiseModel,
) -> BioseqalignpairwiseModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseModel::fill(
  self : BioseqalignpairwiseModel,
  v : Double,
) -> BioseqalignpairwiseModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseModel::min(self : BioseqalignpairwiseModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseModel::max(self : BioseqalignpairwiseModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseModel::to_string(
  self : BioseqalignpairwiseModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_layer_make(
  size : Int32,
) -> BioseqalignpairwiseLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseLayer::len(self : BioseqalignpairwiseLayer) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseLayer::get(
  self : BioseqalignpairwiseLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseLayer::set(
  self : BioseqalignpairwiseLayer,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseLayer::sum(self : BioseqalignpairwiseLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseLayer::mean(
  self : BioseqalignpairwiseLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseLayer::scale(
  self : BioseqalignpairwiseLayer,
  f : Double,
) -> BioseqalignpairwiseLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseLayer::add(
  self : BioseqalignpairwiseLayer,
  other : BioseqalignpairwiseLayer,
) -> BioseqalignpairwiseLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseLayer::copy(
  self : BioseqalignpairwiseLayer,
) -> BioseqalignpairwiseLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseLayer::fill(
  self : BioseqalignpairwiseLayer,
  v : Double,
) -> BioseqalignpairwiseLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseLayer::min(self : BioseqalignpairwiseLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseLayer::max(self : BioseqalignpairwiseLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseLayer::to_string(
  self : BioseqalignpairwiseLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_buffer_make(
  size : Int32,
) -> BioseqalignpairwiseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseBuffer::len(
  self : BioseqalignpairwiseBuffer,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseBuffer::get(
  self : BioseqalignpairwiseBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseBuffer::set(
  self : BioseqalignpairwiseBuffer,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseBuffer::sum(
  self : BioseqalignpairwiseBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseBuffer::mean(
  self : BioseqalignpairwiseBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseBuffer::scale(
  self : BioseqalignpairwiseBuffer,
  f : Double,
) -> BioseqalignpairwiseBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseBuffer::add(
  self : BioseqalignpairwiseBuffer,
  other : BioseqalignpairwiseBuffer,
) -> BioseqalignpairwiseBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseBuffer::copy(
  self : BioseqalignpairwiseBuffer,
) -> BioseqalignpairwiseBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseBuffer::fill(
  self : BioseqalignpairwiseBuffer,
  v : Double,
) -> BioseqalignpairwiseBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseBuffer::min(
  self : BioseqalignpairwiseBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseBuffer::max(
  self : BioseqalignpairwiseBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseBuffer::to_string(
  self : BioseqalignpairwiseBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_cursor_make(
  size : Int32,
) -> BioseqalignpairwiseCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseCursor::len(
  self : BioseqalignpairwiseCursor,
) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseCursor::get(
  self : BioseqalignpairwiseCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseCursor::set(
  self : BioseqalignpairwiseCursor,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseCursor::sum(
  self : BioseqalignpairwiseCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseCursor::mean(
  self : BioseqalignpairwiseCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseCursor::scale(
  self : BioseqalignpairwiseCursor,
  f : Double,
) -> BioseqalignpairwiseCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseCursor::add(
  self : BioseqalignpairwiseCursor,
  other : BioseqalignpairwiseCursor,
) -> BioseqalignpairwiseCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseCursor::copy(
  self : BioseqalignpairwiseCursor,
) -> BioseqalignpairwiseCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseCursor::fill(
  self : BioseqalignpairwiseCursor,
  v : Double,
) -> BioseqalignpairwiseCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseCursor::min(
  self : BioseqalignpairwiseCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseCursor::max(
  self : BioseqalignpairwiseCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseCursor::to_string(
  self : BioseqalignpairwiseCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_view_make(
  size : Int32,
) -> BioseqalignpairwiseView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseView::len(self : BioseqalignpairwiseView) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseView::get(
  self : BioseqalignpairwiseView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseView::set(
  self : BioseqalignpairwiseView,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseView::sum(self : BioseqalignpairwiseView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseView::mean(self : BioseqalignpairwiseView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseView::scale(
  self : BioseqalignpairwiseView,
  f : Double,
) -> BioseqalignpairwiseView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseView::add(
  self : BioseqalignpairwiseView,
  other : BioseqalignpairwiseView,
) -> BioseqalignpairwiseView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseView::copy(
  self : BioseqalignpairwiseView,
) -> BioseqalignpairwiseView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseView::fill(
  self : BioseqalignpairwiseView,
  v : Double,
) -> BioseqalignpairwiseView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseView::min(self : BioseqalignpairwiseView) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseView::max(self : BioseqalignpairwiseView) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseView::to_string(
  self : BioseqalignpairwiseView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_range_make(
  size : Int32,
) -> BioseqalignpairwiseRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseRange::len(self : BioseqalignpairwiseRange) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseRange::get(
  self : BioseqalignpairwiseRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseRange::set(
  self : BioseqalignpairwiseRange,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseRange::sum(self : BioseqalignpairwiseRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseRange::mean(
  self : BioseqalignpairwiseRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseRange::scale(
  self : BioseqalignpairwiseRange,
  f : Double,
) -> BioseqalignpairwiseRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseRange::add(
  self : BioseqalignpairwiseRange,
  other : BioseqalignpairwiseRange,
) -> BioseqalignpairwiseRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseRange::copy(
  self : BioseqalignpairwiseRange,
) -> BioseqalignpairwiseRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseRange::fill(
  self : BioseqalignpairwiseRange,
  v : Double,
) -> BioseqalignpairwiseRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseRange::min(self : BioseqalignpairwiseRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseRange::max(self : BioseqalignpairwiseRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseRange::to_string(
  self : BioseqalignpairwiseRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BioseqalignpairwiseSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_seq_align_pairwise_slice_make(
  size : Int32,
) -> BioseqalignpairwiseSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BioseqalignpairwiseSlice::len(self : BioseqalignpairwiseSlice) -> Int32 {
  self.size
}

///|
pub fn BioseqalignpairwiseSlice::get(
  self : BioseqalignpairwiseSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BioseqalignpairwiseSlice::set(
  self : BioseqalignpairwiseSlice,
  i : Int32,
  v : Double,
) -> BioseqalignpairwiseSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseSlice::sum(self : BioseqalignpairwiseSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BioseqalignpairwiseSlice::mean(
  self : BioseqalignpairwiseSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BioseqalignpairwiseSlice::scale(
  self : BioseqalignpairwiseSlice,
  f : Double,
) -> BioseqalignpairwiseSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseSlice::add(
  self : BioseqalignpairwiseSlice,
  other : BioseqalignpairwiseSlice,
) -> BioseqalignpairwiseSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseSlice::copy(
  self : BioseqalignpairwiseSlice,
) -> BioseqalignpairwiseSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseSlice::fill(
  self : BioseqalignpairwiseSlice,
  v : Double,
) -> BioseqalignpairwiseSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BioseqalignpairwiseSlice::min(self : BioseqalignpairwiseSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn BioseqalignpairwiseSlice::max(self : BioseqalignpairwiseSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn BioseqalignpairwiseSlice::to_string(
  self : BioseqalignpairwiseSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
