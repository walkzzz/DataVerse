///|
///===
/// extcore/sort_dist_bucket
pub(all) struct SortdistbucketPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn sort_dist_bucket_make_point(
  x : Double,
  y : Double,
) -> SortdistbucketPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn sort_dist_bucket_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SortdistbucketPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SortdistbucketPoint::x(self : SortdistbucketPoint) -> Double {
  self.x
}

///|
pub fn SortdistbucketPoint::y(self : SortdistbucketPoint) -> Double {
  self.y
}

///|
pub fn SortdistbucketPoint::z(self : SortdistbucketPoint) -> Double {
  self.z
}

///|
pub fn SortdistbucketPoint::label(self : SortdistbucketPoint) -> Int32 {
  self.label
}

///|
pub fn SortdistbucketPoint::dist(
  self : SortdistbucketPoint,
  other : SortdistbucketPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SortdistbucketPoint::add(
  self : SortdistbucketPoint,
  other : SortdistbucketPoint,
) -> SortdistbucketPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SortdistbucketPoint::sub(
  self : SortdistbucketPoint,
  other : SortdistbucketPoint,
) -> SortdistbucketPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SortdistbucketPoint::scale(
  self : SortdistbucketPoint,
  s : Double,
) -> SortdistbucketPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SortdistbucketPoint::dot(
  self : SortdistbucketPoint,
  other : SortdistbucketPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SortdistbucketPoint::cross(
  self : SortdistbucketPoint,
  other : SortdistbucketPoint,
) -> SortdistbucketPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SortdistbucketPoint::norm(self : SortdistbucketPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SortdistbucketPoint::normalize(
  self : SortdistbucketPoint,
) -> SortdistbucketPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortdistbucketPoint::negate(
  self : SortdistbucketPoint,
) -> SortdistbucketPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SortdistbucketPoint::mid(
  self : SortdistbucketPoint,
  other : SortdistbucketPoint,
) -> SortdistbucketPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SortdistbucketPoint::lerp(
  self : SortdistbucketPoint,
  other : SortdistbucketPoint,
  t : Double,
) -> SortdistbucketPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SortdistbucketPoint::to_string(self : SortdistbucketPoint) -> String {
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
pub(all) struct SortdistbucketSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn sort_dist_bucket_make_series(
  vals : Array[Double],
  name : String,
) -> SortdistbucketSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SortdistbucketSeries::len(self : SortdistbucketSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn SortdistbucketSeries::sum(self : SortdistbucketSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SortdistbucketSeries::mean(self : SortdistbucketSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SortdistbucketSeries::min(self : SortdistbucketSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SortdistbucketSeries::max(self : SortdistbucketSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SortdistbucketSeries::range(self : SortdistbucketSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SortdistbucketSeries::variance(self : SortdistbucketSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SortdistbucketSeries::std(self : SortdistbucketSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SortdistbucketSeries::median(self : SortdistbucketSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SortdistbucketSeries::scale(
  self : SortdistbucketSeries,
  f : Double,
) -> SortdistbucketSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SortdistbucketSeries::add(
  self : SortdistbucketSeries,
  other : SortdistbucketSeries,
) -> SortdistbucketSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortdistbucketSeries::sub(
  self : SortdistbucketSeries,
  other : SortdistbucketSeries,
) -> SortdistbucketSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortdistbucketSeries::normalize(
  self : SortdistbucketSeries,
) -> SortdistbucketSeries {
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
pub fn SortdistbucketSeries::cumsum(
  self : SortdistbucketSeries,
) -> SortdistbucketSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SortdistbucketSeries::to_string(self : SortdistbucketSeries) -> String {
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
pub(all) struct SortdistbucketMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn sort_dist_bucket_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SortdistbucketMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn sort_dist_bucket_matrix_identity(n : Int32) -> SortdistbucketMatrix {
  let m = sort_dist_bucket_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SortdistbucketMatrix::get(
  self : SortdistbucketMatrix,
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
pub fn SortdistbucketMatrix::transpose(
  self : SortdistbucketMatrix,
) -> SortdistbucketMatrix {
  let result = sort_dist_bucket_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SortdistbucketMatrix::add(
  self : SortdistbucketMatrix,
  other : SortdistbucketMatrix,
) -> SortdistbucketMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = sort_dist_bucket_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SortdistbucketMatrix::scale(
  self : SortdistbucketMatrix,
  s : Double,
) -> SortdistbucketMatrix {
  let result = sort_dist_bucket_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SortdistbucketMatrix::multiply(
  self : SortdistbucketMatrix,
  other : SortdistbucketMatrix,
) -> SortdistbucketMatrix {
  if self.cols != other.rows {
    return sort_dist_bucket_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = sort_dist_bucket_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SortdistbucketMatrix::trace(self : SortdistbucketMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SortdistbucketMatrix::det(self : SortdistbucketMatrix) -> Double {
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
pub fn SortdistbucketMatrix::norm(self : SortdistbucketMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn SortdistbucketMatrix::to_string(self : SortdistbucketMatrix) -> String {
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
pub(all) struct SortdistbucketVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn sort_dist_bucket_make_vector(
  comps : Array[Double],
) -> SortdistbucketVector {
  { comps, dim: comps.length(), }
}

///|
pub fn sort_dist_bucket_vector_zero(dim : Int32) -> SortdistbucketVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SortdistbucketVector::add(
  self : SortdistbucketVector,
  other : SortdistbucketVector,
) -> SortdistbucketVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortdistbucketVector::sub(
  self : SortdistbucketVector,
  other : SortdistbucketVector,
) -> SortdistbucketVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortdistbucketVector::scale(
  self : SortdistbucketVector,
  s : Double,
) -> SortdistbucketVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SortdistbucketVector::dot(
  self : SortdistbucketVector,
  other : SortdistbucketVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SortdistbucketVector::norm(self : SortdistbucketVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SortdistbucketVector::normalize(
  self : SortdistbucketVector,
) -> SortdistbucketVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortdistbucketVector::dist(
  self : SortdistbucketVector,
  other : SortdistbucketVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SortdistbucketVector::to_string(self : SortdistbucketVector) -> String {
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
pub(all) struct SortdistbucketFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_frame_make(size : Int32) -> SortdistbucketFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketFrame::len(self : SortdistbucketFrame) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketFrame::get(
  self : SortdistbucketFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketFrame::set(
  self : SortdistbucketFrame,
  i : Int32,
  v : Double,
) -> SortdistbucketFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketFrame::sum(self : SortdistbucketFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketFrame::mean(self : SortdistbucketFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketFrame::scale(
  self : SortdistbucketFrame,
  f : Double,
) -> SortdistbucketFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketFrame::add(
  self : SortdistbucketFrame,
  other : SortdistbucketFrame,
) -> SortdistbucketFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketFrame::copy(
  self : SortdistbucketFrame,
) -> SortdistbucketFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketFrame::fill(
  self : SortdistbucketFrame,
  v : Double,
) -> SortdistbucketFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketFrame::min(self : SortdistbucketFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketFrame::max(self : SortdistbucketFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketFrame::to_string(self : SortdistbucketFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_table_make(size : Int32) -> SortdistbucketTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketTable::len(self : SortdistbucketTable) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketTable::get(
  self : SortdistbucketTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketTable::set(
  self : SortdistbucketTable,
  i : Int32,
  v : Double,
) -> SortdistbucketTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketTable::sum(self : SortdistbucketTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketTable::mean(self : SortdistbucketTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketTable::scale(
  self : SortdistbucketTable,
  f : Double,
) -> SortdistbucketTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketTable::add(
  self : SortdistbucketTable,
  other : SortdistbucketTable,
) -> SortdistbucketTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketTable::copy(
  self : SortdistbucketTable,
) -> SortdistbucketTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketTable::fill(
  self : SortdistbucketTable,
  v : Double,
) -> SortdistbucketTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketTable::min(self : SortdistbucketTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketTable::max(self : SortdistbucketTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketTable::to_string(self : SortdistbucketTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_graphn_make(size : Int32) -> SortdistbucketGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketGraphN::len(self : SortdistbucketGraphN) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketGraphN::get(
  self : SortdistbucketGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketGraphN::set(
  self : SortdistbucketGraphN,
  i : Int32,
  v : Double,
) -> SortdistbucketGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketGraphN::sum(self : SortdistbucketGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketGraphN::mean(self : SortdistbucketGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketGraphN::scale(
  self : SortdistbucketGraphN,
  f : Double,
) -> SortdistbucketGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketGraphN::add(
  self : SortdistbucketGraphN,
  other : SortdistbucketGraphN,
) -> SortdistbucketGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketGraphN::copy(
  self : SortdistbucketGraphN,
) -> SortdistbucketGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketGraphN::fill(
  self : SortdistbucketGraphN,
  v : Double,
) -> SortdistbucketGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketGraphN::min(self : SortdistbucketGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketGraphN::max(self : SortdistbucketGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketGraphN::to_string(self : SortdistbucketGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_node_make(size : Int32) -> SortdistbucketNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketNode::len(self : SortdistbucketNode) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketNode::get(self : SortdistbucketNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketNode::set(
  self : SortdistbucketNode,
  i : Int32,
  v : Double,
) -> SortdistbucketNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketNode::sum(self : SortdistbucketNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketNode::mean(self : SortdistbucketNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketNode::scale(
  self : SortdistbucketNode,
  f : Double,
) -> SortdistbucketNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketNode::add(
  self : SortdistbucketNode,
  other : SortdistbucketNode,
) -> SortdistbucketNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketNode::copy(
  self : SortdistbucketNode,
) -> SortdistbucketNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketNode::fill(
  self : SortdistbucketNode,
  v : Double,
) -> SortdistbucketNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketNode::min(self : SortdistbucketNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketNode::max(self : SortdistbucketNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketNode::to_string(self : SortdistbucketNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_edge_make(size : Int32) -> SortdistbucketEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketEdge::len(self : SortdistbucketEdge) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketEdge::get(self : SortdistbucketEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketEdge::set(
  self : SortdistbucketEdge,
  i : Int32,
  v : Double,
) -> SortdistbucketEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketEdge::sum(self : SortdistbucketEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketEdge::mean(self : SortdistbucketEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketEdge::scale(
  self : SortdistbucketEdge,
  f : Double,
) -> SortdistbucketEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketEdge::add(
  self : SortdistbucketEdge,
  other : SortdistbucketEdge,
) -> SortdistbucketEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketEdge::copy(
  self : SortdistbucketEdge,
) -> SortdistbucketEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketEdge::fill(
  self : SortdistbucketEdge,
  v : Double,
) -> SortdistbucketEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketEdge::min(self : SortdistbucketEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketEdge::max(self : SortdistbucketEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketEdge::to_string(self : SortdistbucketEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_path_make(size : Int32) -> SortdistbucketPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketPath::len(self : SortdistbucketPath) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketPath::get(self : SortdistbucketPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketPath::set(
  self : SortdistbucketPath,
  i : Int32,
  v : Double,
) -> SortdistbucketPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketPath::sum(self : SortdistbucketPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketPath::mean(self : SortdistbucketPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketPath::scale(
  self : SortdistbucketPath,
  f : Double,
) -> SortdistbucketPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketPath::add(
  self : SortdistbucketPath,
  other : SortdistbucketPath,
) -> SortdistbucketPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketPath::copy(
  self : SortdistbucketPath,
) -> SortdistbucketPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketPath::fill(
  self : SortdistbucketPath,
  v : Double,
) -> SortdistbucketPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketPath::min(self : SortdistbucketPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketPath::max(self : SortdistbucketPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketPath::to_string(self : SortdistbucketPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_cluster_make(size : Int32) -> SortdistbucketCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketCluster::len(self : SortdistbucketCluster) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketCluster::get(
  self : SortdistbucketCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketCluster::set(
  self : SortdistbucketCluster,
  i : Int32,
  v : Double,
) -> SortdistbucketCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketCluster::sum(self : SortdistbucketCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketCluster::mean(self : SortdistbucketCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketCluster::scale(
  self : SortdistbucketCluster,
  f : Double,
) -> SortdistbucketCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketCluster::add(
  self : SortdistbucketCluster,
  other : SortdistbucketCluster,
) -> SortdistbucketCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketCluster::copy(
  self : SortdistbucketCluster,
) -> SortdistbucketCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketCluster::fill(
  self : SortdistbucketCluster,
  v : Double,
) -> SortdistbucketCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketCluster::min(self : SortdistbucketCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketCluster::max(self : SortdistbucketCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketCluster::to_string(self : SortdistbucketCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_model_make(size : Int32) -> SortdistbucketModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketModel::len(self : SortdistbucketModel) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketModel::get(
  self : SortdistbucketModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketModel::set(
  self : SortdistbucketModel,
  i : Int32,
  v : Double,
) -> SortdistbucketModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketModel::sum(self : SortdistbucketModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketModel::mean(self : SortdistbucketModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketModel::scale(
  self : SortdistbucketModel,
  f : Double,
) -> SortdistbucketModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketModel::add(
  self : SortdistbucketModel,
  other : SortdistbucketModel,
) -> SortdistbucketModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketModel::copy(
  self : SortdistbucketModel,
) -> SortdistbucketModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketModel::fill(
  self : SortdistbucketModel,
  v : Double,
) -> SortdistbucketModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketModel::min(self : SortdistbucketModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketModel::max(self : SortdistbucketModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketModel::to_string(self : SortdistbucketModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_layer_make(size : Int32) -> SortdistbucketLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketLayer::len(self : SortdistbucketLayer) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketLayer::get(
  self : SortdistbucketLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketLayer::set(
  self : SortdistbucketLayer,
  i : Int32,
  v : Double,
) -> SortdistbucketLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketLayer::sum(self : SortdistbucketLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketLayer::mean(self : SortdistbucketLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketLayer::scale(
  self : SortdistbucketLayer,
  f : Double,
) -> SortdistbucketLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketLayer::add(
  self : SortdistbucketLayer,
  other : SortdistbucketLayer,
) -> SortdistbucketLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketLayer::copy(
  self : SortdistbucketLayer,
) -> SortdistbucketLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketLayer::fill(
  self : SortdistbucketLayer,
  v : Double,
) -> SortdistbucketLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketLayer::min(self : SortdistbucketLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketLayer::max(self : SortdistbucketLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketLayer::to_string(self : SortdistbucketLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_buffer_make(size : Int32) -> SortdistbucketBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketBuffer::len(self : SortdistbucketBuffer) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketBuffer::get(
  self : SortdistbucketBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketBuffer::set(
  self : SortdistbucketBuffer,
  i : Int32,
  v : Double,
) -> SortdistbucketBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketBuffer::sum(self : SortdistbucketBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketBuffer::mean(self : SortdistbucketBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketBuffer::scale(
  self : SortdistbucketBuffer,
  f : Double,
) -> SortdistbucketBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketBuffer::add(
  self : SortdistbucketBuffer,
  other : SortdistbucketBuffer,
) -> SortdistbucketBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketBuffer::copy(
  self : SortdistbucketBuffer,
) -> SortdistbucketBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketBuffer::fill(
  self : SortdistbucketBuffer,
  v : Double,
) -> SortdistbucketBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketBuffer::min(self : SortdistbucketBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketBuffer::max(self : SortdistbucketBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketBuffer::to_string(self : SortdistbucketBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_cursor_make(size : Int32) -> SortdistbucketCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketCursor::len(self : SortdistbucketCursor) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketCursor::get(
  self : SortdistbucketCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketCursor::set(
  self : SortdistbucketCursor,
  i : Int32,
  v : Double,
) -> SortdistbucketCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketCursor::sum(self : SortdistbucketCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketCursor::mean(self : SortdistbucketCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketCursor::scale(
  self : SortdistbucketCursor,
  f : Double,
) -> SortdistbucketCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketCursor::add(
  self : SortdistbucketCursor,
  other : SortdistbucketCursor,
) -> SortdistbucketCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketCursor::copy(
  self : SortdistbucketCursor,
) -> SortdistbucketCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketCursor::fill(
  self : SortdistbucketCursor,
  v : Double,
) -> SortdistbucketCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketCursor::min(self : SortdistbucketCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketCursor::max(self : SortdistbucketCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketCursor::to_string(self : SortdistbucketCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_view_make(size : Int32) -> SortdistbucketView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketView::len(self : SortdistbucketView) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketView::get(self : SortdistbucketView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketView::set(
  self : SortdistbucketView,
  i : Int32,
  v : Double,
) -> SortdistbucketView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketView::sum(self : SortdistbucketView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketView::mean(self : SortdistbucketView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketView::scale(
  self : SortdistbucketView,
  f : Double,
) -> SortdistbucketView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketView::add(
  self : SortdistbucketView,
  other : SortdistbucketView,
) -> SortdistbucketView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketView::copy(
  self : SortdistbucketView,
) -> SortdistbucketView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketView::fill(
  self : SortdistbucketView,
  v : Double,
) -> SortdistbucketView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketView::min(self : SortdistbucketView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketView::max(self : SortdistbucketView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketView::to_string(self : SortdistbucketView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_range_make(size : Int32) -> SortdistbucketRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketRange::len(self : SortdistbucketRange) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketRange::get(
  self : SortdistbucketRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketRange::set(
  self : SortdistbucketRange,
  i : Int32,
  v : Double,
) -> SortdistbucketRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketRange::sum(self : SortdistbucketRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketRange::mean(self : SortdistbucketRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketRange::scale(
  self : SortdistbucketRange,
  f : Double,
) -> SortdistbucketRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketRange::add(
  self : SortdistbucketRange,
  other : SortdistbucketRange,
) -> SortdistbucketRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketRange::copy(
  self : SortdistbucketRange,
) -> SortdistbucketRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketRange::fill(
  self : SortdistbucketRange,
  v : Double,
) -> SortdistbucketRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketRange::min(self : SortdistbucketRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketRange::max(self : SortdistbucketRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketRange::to_string(self : SortdistbucketRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortdistbucketSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_dist_bucket_slice_make(size : Int32) -> SortdistbucketSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortdistbucketSlice::len(self : SortdistbucketSlice) -> Int32 {
  self.size
}

///|
pub fn SortdistbucketSlice::get(
  self : SortdistbucketSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortdistbucketSlice::set(
  self : SortdistbucketSlice,
  i : Int32,
  v : Double,
) -> SortdistbucketSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketSlice::sum(self : SortdistbucketSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortdistbucketSlice::mean(self : SortdistbucketSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortdistbucketSlice::scale(
  self : SortdistbucketSlice,
  f : Double,
) -> SortdistbucketSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketSlice::add(
  self : SortdistbucketSlice,
  other : SortdistbucketSlice,
) -> SortdistbucketSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortdistbucketSlice::copy(
  self : SortdistbucketSlice,
) -> SortdistbucketSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketSlice::fill(
  self : SortdistbucketSlice,
  v : Double,
) -> SortdistbucketSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortdistbucketSlice::min(self : SortdistbucketSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortdistbucketSlice::max(self : SortdistbucketSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortdistbucketSlice::to_string(self : SortdistbucketSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
