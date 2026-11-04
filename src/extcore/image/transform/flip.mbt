///|
///===
/// extcore/image_transform_flip
pub(all) struct ImagetransformflipPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn image_transform_flip_make_point(
  x : Double,
  y : Double,
) -> ImagetransformflipPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn image_transform_flip_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ImagetransformflipPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ImagetransformflipPoint::x(self : ImagetransformflipPoint) -> Double {
  self.x
}

///|
pub fn ImagetransformflipPoint::y(self : ImagetransformflipPoint) -> Double {
  self.y
}

///|
pub fn ImagetransformflipPoint::z(self : ImagetransformflipPoint) -> Double {
  self.z
}

///|
pub fn ImagetransformflipPoint::label(self : ImagetransformflipPoint) -> Int32 {
  self.label
}

///|
pub fn ImagetransformflipPoint::dist(
  self : ImagetransformflipPoint,
  other : ImagetransformflipPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ImagetransformflipPoint::add(
  self : ImagetransformflipPoint,
  other : ImagetransformflipPoint,
) -> ImagetransformflipPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ImagetransformflipPoint::sub(
  self : ImagetransformflipPoint,
  other : ImagetransformflipPoint,
) -> ImagetransformflipPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ImagetransformflipPoint::scale(
  self : ImagetransformflipPoint,
  s : Double,
) -> ImagetransformflipPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ImagetransformflipPoint::dot(
  self : ImagetransformflipPoint,
  other : ImagetransformflipPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ImagetransformflipPoint::cross(
  self : ImagetransformflipPoint,
  other : ImagetransformflipPoint,
) -> ImagetransformflipPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ImagetransformflipPoint::norm(self : ImagetransformflipPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ImagetransformflipPoint::normalize(
  self : ImagetransformflipPoint,
) -> ImagetransformflipPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagetransformflipPoint::negate(
  self : ImagetransformflipPoint,
) -> ImagetransformflipPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ImagetransformflipPoint::mid(
  self : ImagetransformflipPoint,
  other : ImagetransformflipPoint,
) -> ImagetransformflipPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ImagetransformflipPoint::lerp(
  self : ImagetransformflipPoint,
  other : ImagetransformflipPoint,
  t : Double,
) -> ImagetransformflipPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ImagetransformflipPoint::to_string(
  self : ImagetransformflipPoint,
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
pub(all) struct ImagetransformflipSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn image_transform_flip_make_series(
  vals : Array[Double],
  name : String,
) -> ImagetransformflipSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ImagetransformflipSeries::len(self : ImagetransformflipSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ImagetransformflipSeries::sum(self : ImagetransformflipSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ImagetransformflipSeries::mean(
  self : ImagetransformflipSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ImagetransformflipSeries::min(self : ImagetransformflipSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ImagetransformflipSeries::max(self : ImagetransformflipSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ImagetransformflipSeries::range(
  self : ImagetransformflipSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ImagetransformflipSeries::variance(
  self : ImagetransformflipSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ImagetransformflipSeries::std(self : ImagetransformflipSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ImagetransformflipSeries::median(
  self : ImagetransformflipSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ImagetransformflipSeries::scale(
  self : ImagetransformflipSeries,
  f : Double,
) -> ImagetransformflipSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ImagetransformflipSeries::add(
  self : ImagetransformflipSeries,
  other : ImagetransformflipSeries,
) -> ImagetransformflipSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagetransformflipSeries::sub(
  self : ImagetransformflipSeries,
  other : ImagetransformflipSeries,
) -> ImagetransformflipSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagetransformflipSeries::normalize(
  self : ImagetransformflipSeries,
) -> ImagetransformflipSeries {
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
pub fn ImagetransformflipSeries::cumsum(
  self : ImagetransformflipSeries,
) -> ImagetransformflipSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ImagetransformflipSeries::to_string(
  self : ImagetransformflipSeries,
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
pub(all) struct ImagetransformflipMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn image_transform_flip_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ImagetransformflipMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn image_transform_flip_matrix_identity(
  n : Int32,
) -> ImagetransformflipMatrix {
  let m = image_transform_flip_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ImagetransformflipMatrix::get(
  self : ImagetransformflipMatrix,
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
pub fn ImagetransformflipMatrix::transpose(
  self : ImagetransformflipMatrix,
) -> ImagetransformflipMatrix {
  let result = image_transform_flip_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ImagetransformflipMatrix::add(
  self : ImagetransformflipMatrix,
  other : ImagetransformflipMatrix,
) -> ImagetransformflipMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = image_transform_flip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ImagetransformflipMatrix::scale(
  self : ImagetransformflipMatrix,
  s : Double,
) -> ImagetransformflipMatrix {
  let result = image_transform_flip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ImagetransformflipMatrix::multiply(
  self : ImagetransformflipMatrix,
  other : ImagetransformflipMatrix,
) -> ImagetransformflipMatrix {
  if self.cols != other.rows {
    return image_transform_flip_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = image_transform_flip_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ImagetransformflipMatrix::trace(
  self : ImagetransformflipMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ImagetransformflipMatrix::det(self : ImagetransformflipMatrix) -> Double {
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
pub fn ImagetransformflipMatrix::norm(
  self : ImagetransformflipMatrix,
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
pub fn ImagetransformflipMatrix::to_string(
  self : ImagetransformflipMatrix,
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
pub(all) struct ImagetransformflipVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn image_transform_flip_make_vector(
  comps : Array[Double],
) -> ImagetransformflipVector {
  { comps, dim: comps.length(), }
}

///|
pub fn image_transform_flip_vector_zero(
  dim : Int32,
) -> ImagetransformflipVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ImagetransformflipVector::add(
  self : ImagetransformflipVector,
  other : ImagetransformflipVector,
) -> ImagetransformflipVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagetransformflipVector::sub(
  self : ImagetransformflipVector,
  other : ImagetransformflipVector,
) -> ImagetransformflipVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagetransformflipVector::scale(
  self : ImagetransformflipVector,
  s : Double,
) -> ImagetransformflipVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ImagetransformflipVector::dot(
  self : ImagetransformflipVector,
  other : ImagetransformflipVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ImagetransformflipVector::norm(
  self : ImagetransformflipVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ImagetransformflipVector::normalize(
  self : ImagetransformflipVector,
) -> ImagetransformflipVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagetransformflipVector::dist(
  self : ImagetransformflipVector,
  other : ImagetransformflipVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ImagetransformflipVector::to_string(
  self : ImagetransformflipVector,
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
pub(all) struct ImagetransformflipFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_frame_make(size : Int32) -> ImagetransformflipFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipFrame::len(self : ImagetransformflipFrame) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipFrame::get(
  self : ImagetransformflipFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipFrame::set(
  self : ImagetransformflipFrame,
  i : Int32,
  v : Double,
) -> ImagetransformflipFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipFrame::sum(self : ImagetransformflipFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipFrame::mean(self : ImagetransformflipFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipFrame::scale(
  self : ImagetransformflipFrame,
  f : Double,
) -> ImagetransformflipFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipFrame::add(
  self : ImagetransformflipFrame,
  other : ImagetransformflipFrame,
) -> ImagetransformflipFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipFrame::copy(
  self : ImagetransformflipFrame,
) -> ImagetransformflipFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipFrame::fill(
  self : ImagetransformflipFrame,
  v : Double,
) -> ImagetransformflipFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipFrame::min(self : ImagetransformflipFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipFrame::max(self : ImagetransformflipFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipFrame::to_string(
  self : ImagetransformflipFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_table_make(size : Int32) -> ImagetransformflipTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipTable::len(self : ImagetransformflipTable) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipTable::get(
  self : ImagetransformflipTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipTable::set(
  self : ImagetransformflipTable,
  i : Int32,
  v : Double,
) -> ImagetransformflipTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipTable::sum(self : ImagetransformflipTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipTable::mean(self : ImagetransformflipTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipTable::scale(
  self : ImagetransformflipTable,
  f : Double,
) -> ImagetransformflipTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipTable::add(
  self : ImagetransformflipTable,
  other : ImagetransformflipTable,
) -> ImagetransformflipTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipTable::copy(
  self : ImagetransformflipTable,
) -> ImagetransformflipTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipTable::fill(
  self : ImagetransformflipTable,
  v : Double,
) -> ImagetransformflipTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipTable::min(self : ImagetransformflipTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipTable::max(self : ImagetransformflipTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipTable::to_string(
  self : ImagetransformflipTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_graphn_make(
  size : Int32,
) -> ImagetransformflipGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipGraphN::len(self : ImagetransformflipGraphN) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipGraphN::get(
  self : ImagetransformflipGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipGraphN::set(
  self : ImagetransformflipGraphN,
  i : Int32,
  v : Double,
) -> ImagetransformflipGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipGraphN::sum(self : ImagetransformflipGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipGraphN::mean(
  self : ImagetransformflipGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipGraphN::scale(
  self : ImagetransformflipGraphN,
  f : Double,
) -> ImagetransformflipGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipGraphN::add(
  self : ImagetransformflipGraphN,
  other : ImagetransformflipGraphN,
) -> ImagetransformflipGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipGraphN::copy(
  self : ImagetransformflipGraphN,
) -> ImagetransformflipGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipGraphN::fill(
  self : ImagetransformflipGraphN,
  v : Double,
) -> ImagetransformflipGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipGraphN::min(self : ImagetransformflipGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipGraphN::max(self : ImagetransformflipGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipGraphN::to_string(
  self : ImagetransformflipGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_node_make(size : Int32) -> ImagetransformflipNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipNode::len(self : ImagetransformflipNode) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipNode::get(
  self : ImagetransformflipNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipNode::set(
  self : ImagetransformflipNode,
  i : Int32,
  v : Double,
) -> ImagetransformflipNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipNode::sum(self : ImagetransformflipNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipNode::mean(self : ImagetransformflipNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipNode::scale(
  self : ImagetransformflipNode,
  f : Double,
) -> ImagetransformflipNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipNode::add(
  self : ImagetransformflipNode,
  other : ImagetransformflipNode,
) -> ImagetransformflipNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipNode::copy(
  self : ImagetransformflipNode,
) -> ImagetransformflipNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipNode::fill(
  self : ImagetransformflipNode,
  v : Double,
) -> ImagetransformflipNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipNode::min(self : ImagetransformflipNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipNode::max(self : ImagetransformflipNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipNode::to_string(
  self : ImagetransformflipNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_edge_make(size : Int32) -> ImagetransformflipEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipEdge::len(self : ImagetransformflipEdge) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipEdge::get(
  self : ImagetransformflipEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipEdge::set(
  self : ImagetransformflipEdge,
  i : Int32,
  v : Double,
) -> ImagetransformflipEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipEdge::sum(self : ImagetransformflipEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipEdge::mean(self : ImagetransformflipEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipEdge::scale(
  self : ImagetransformflipEdge,
  f : Double,
) -> ImagetransformflipEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipEdge::add(
  self : ImagetransformflipEdge,
  other : ImagetransformflipEdge,
) -> ImagetransformflipEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipEdge::copy(
  self : ImagetransformflipEdge,
) -> ImagetransformflipEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipEdge::fill(
  self : ImagetransformflipEdge,
  v : Double,
) -> ImagetransformflipEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipEdge::min(self : ImagetransformflipEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipEdge::max(self : ImagetransformflipEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipEdge::to_string(
  self : ImagetransformflipEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_path_make(size : Int32) -> ImagetransformflipPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipPath::len(self : ImagetransformflipPath) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipPath::get(
  self : ImagetransformflipPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipPath::set(
  self : ImagetransformflipPath,
  i : Int32,
  v : Double,
) -> ImagetransformflipPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipPath::sum(self : ImagetransformflipPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipPath::mean(self : ImagetransformflipPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipPath::scale(
  self : ImagetransformflipPath,
  f : Double,
) -> ImagetransformflipPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipPath::add(
  self : ImagetransformflipPath,
  other : ImagetransformflipPath,
) -> ImagetransformflipPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipPath::copy(
  self : ImagetransformflipPath,
) -> ImagetransformflipPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipPath::fill(
  self : ImagetransformflipPath,
  v : Double,
) -> ImagetransformflipPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipPath::min(self : ImagetransformflipPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipPath::max(self : ImagetransformflipPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipPath::to_string(
  self : ImagetransformflipPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_cluster_make(
  size : Int32,
) -> ImagetransformflipCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipCluster::len(
  self : ImagetransformflipCluster,
) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipCluster::get(
  self : ImagetransformflipCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipCluster::set(
  self : ImagetransformflipCluster,
  i : Int32,
  v : Double,
) -> ImagetransformflipCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipCluster::sum(
  self : ImagetransformflipCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipCluster::mean(
  self : ImagetransformflipCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipCluster::scale(
  self : ImagetransformflipCluster,
  f : Double,
) -> ImagetransformflipCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipCluster::add(
  self : ImagetransformflipCluster,
  other : ImagetransformflipCluster,
) -> ImagetransformflipCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipCluster::copy(
  self : ImagetransformflipCluster,
) -> ImagetransformflipCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipCluster::fill(
  self : ImagetransformflipCluster,
  v : Double,
) -> ImagetransformflipCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipCluster::min(
  self : ImagetransformflipCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipCluster::max(
  self : ImagetransformflipCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipCluster::to_string(
  self : ImagetransformflipCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_model_make(size : Int32) -> ImagetransformflipModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipModel::len(self : ImagetransformflipModel) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipModel::get(
  self : ImagetransformflipModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipModel::set(
  self : ImagetransformflipModel,
  i : Int32,
  v : Double,
) -> ImagetransformflipModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipModel::sum(self : ImagetransformflipModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipModel::mean(self : ImagetransformflipModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipModel::scale(
  self : ImagetransformflipModel,
  f : Double,
) -> ImagetransformflipModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipModel::add(
  self : ImagetransformflipModel,
  other : ImagetransformflipModel,
) -> ImagetransformflipModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipModel::copy(
  self : ImagetransformflipModel,
) -> ImagetransformflipModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipModel::fill(
  self : ImagetransformflipModel,
  v : Double,
) -> ImagetransformflipModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipModel::min(self : ImagetransformflipModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipModel::max(self : ImagetransformflipModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipModel::to_string(
  self : ImagetransformflipModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_layer_make(size : Int32) -> ImagetransformflipLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipLayer::len(self : ImagetransformflipLayer) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipLayer::get(
  self : ImagetransformflipLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipLayer::set(
  self : ImagetransformflipLayer,
  i : Int32,
  v : Double,
) -> ImagetransformflipLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipLayer::sum(self : ImagetransformflipLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipLayer::mean(self : ImagetransformflipLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipLayer::scale(
  self : ImagetransformflipLayer,
  f : Double,
) -> ImagetransformflipLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipLayer::add(
  self : ImagetransformflipLayer,
  other : ImagetransformflipLayer,
) -> ImagetransformflipLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipLayer::copy(
  self : ImagetransformflipLayer,
) -> ImagetransformflipLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipLayer::fill(
  self : ImagetransformflipLayer,
  v : Double,
) -> ImagetransformflipLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipLayer::min(self : ImagetransformflipLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipLayer::max(self : ImagetransformflipLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipLayer::to_string(
  self : ImagetransformflipLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_buffer_make(
  size : Int32,
) -> ImagetransformflipBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipBuffer::len(self : ImagetransformflipBuffer) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipBuffer::get(
  self : ImagetransformflipBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipBuffer::set(
  self : ImagetransformflipBuffer,
  i : Int32,
  v : Double,
) -> ImagetransformflipBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipBuffer::sum(self : ImagetransformflipBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipBuffer::mean(
  self : ImagetransformflipBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipBuffer::scale(
  self : ImagetransformflipBuffer,
  f : Double,
) -> ImagetransformflipBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipBuffer::add(
  self : ImagetransformflipBuffer,
  other : ImagetransformflipBuffer,
) -> ImagetransformflipBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipBuffer::copy(
  self : ImagetransformflipBuffer,
) -> ImagetransformflipBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipBuffer::fill(
  self : ImagetransformflipBuffer,
  v : Double,
) -> ImagetransformflipBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipBuffer::min(self : ImagetransformflipBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipBuffer::max(self : ImagetransformflipBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipBuffer::to_string(
  self : ImagetransformflipBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_cursor_make(
  size : Int32,
) -> ImagetransformflipCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipCursor::len(self : ImagetransformflipCursor) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipCursor::get(
  self : ImagetransformflipCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipCursor::set(
  self : ImagetransformflipCursor,
  i : Int32,
  v : Double,
) -> ImagetransformflipCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipCursor::sum(self : ImagetransformflipCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipCursor::mean(
  self : ImagetransformflipCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipCursor::scale(
  self : ImagetransformflipCursor,
  f : Double,
) -> ImagetransformflipCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipCursor::add(
  self : ImagetransformflipCursor,
  other : ImagetransformflipCursor,
) -> ImagetransformflipCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipCursor::copy(
  self : ImagetransformflipCursor,
) -> ImagetransformflipCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipCursor::fill(
  self : ImagetransformflipCursor,
  v : Double,
) -> ImagetransformflipCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipCursor::min(self : ImagetransformflipCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipCursor::max(self : ImagetransformflipCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipCursor::to_string(
  self : ImagetransformflipCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_view_make(size : Int32) -> ImagetransformflipView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipView::len(self : ImagetransformflipView) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipView::get(
  self : ImagetransformflipView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipView::set(
  self : ImagetransformflipView,
  i : Int32,
  v : Double,
) -> ImagetransformflipView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipView::sum(self : ImagetransformflipView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipView::mean(self : ImagetransformflipView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipView::scale(
  self : ImagetransformflipView,
  f : Double,
) -> ImagetransformflipView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipView::add(
  self : ImagetransformflipView,
  other : ImagetransformflipView,
) -> ImagetransformflipView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipView::copy(
  self : ImagetransformflipView,
) -> ImagetransformflipView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipView::fill(
  self : ImagetransformflipView,
  v : Double,
) -> ImagetransformflipView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipView::min(self : ImagetransformflipView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipView::max(self : ImagetransformflipView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipView::to_string(
  self : ImagetransformflipView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_range_make(size : Int32) -> ImagetransformflipRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipRange::len(self : ImagetransformflipRange) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipRange::get(
  self : ImagetransformflipRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipRange::set(
  self : ImagetransformflipRange,
  i : Int32,
  v : Double,
) -> ImagetransformflipRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipRange::sum(self : ImagetransformflipRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipRange::mean(self : ImagetransformflipRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipRange::scale(
  self : ImagetransformflipRange,
  f : Double,
) -> ImagetransformflipRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipRange::add(
  self : ImagetransformflipRange,
  other : ImagetransformflipRange,
) -> ImagetransformflipRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipRange::copy(
  self : ImagetransformflipRange,
) -> ImagetransformflipRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipRange::fill(
  self : ImagetransformflipRange,
  v : Double,
) -> ImagetransformflipRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipRange::min(self : ImagetransformflipRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipRange::max(self : ImagetransformflipRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipRange::to_string(
  self : ImagetransformflipRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagetransformflipSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_transform_flip_slice_make(size : Int32) -> ImagetransformflipSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagetransformflipSlice::len(self : ImagetransformflipSlice) -> Int32 {
  self.size
}

///|
pub fn ImagetransformflipSlice::get(
  self : ImagetransformflipSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagetransformflipSlice::set(
  self : ImagetransformflipSlice,
  i : Int32,
  v : Double,
) -> ImagetransformflipSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipSlice::sum(self : ImagetransformflipSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagetransformflipSlice::mean(self : ImagetransformflipSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagetransformflipSlice::scale(
  self : ImagetransformflipSlice,
  f : Double,
) -> ImagetransformflipSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipSlice::add(
  self : ImagetransformflipSlice,
  other : ImagetransformflipSlice,
) -> ImagetransformflipSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagetransformflipSlice::copy(
  self : ImagetransformflipSlice,
) -> ImagetransformflipSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipSlice::fill(
  self : ImagetransformflipSlice,
  v : Double,
) -> ImagetransformflipSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagetransformflipSlice::min(self : ImagetransformflipSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagetransformflipSlice::max(self : ImagetransformflipSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagetransformflipSlice::to_string(
  self : ImagetransformflipSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
