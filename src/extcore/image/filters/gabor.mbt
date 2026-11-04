///|
///===
/// extcore/image_filter_gabor
pub(all) struct ImagefiltergaborPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn image_filter_gabor_make_point(
  x : Double,
  y : Double,
) -> ImagefiltergaborPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn image_filter_gabor_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ImagefiltergaborPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ImagefiltergaborPoint::x(self : ImagefiltergaborPoint) -> Double {
  self.x
}

///|
pub fn ImagefiltergaborPoint::y(self : ImagefiltergaborPoint) -> Double {
  self.y
}

///|
pub fn ImagefiltergaborPoint::z(self : ImagefiltergaborPoint) -> Double {
  self.z
}

///|
pub fn ImagefiltergaborPoint::label(self : ImagefiltergaborPoint) -> Int32 {
  self.label
}

///|
pub fn ImagefiltergaborPoint::dist(
  self : ImagefiltergaborPoint,
  other : ImagefiltergaborPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ImagefiltergaborPoint::add(
  self : ImagefiltergaborPoint,
  other : ImagefiltergaborPoint,
) -> ImagefiltergaborPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ImagefiltergaborPoint::sub(
  self : ImagefiltergaborPoint,
  other : ImagefiltergaborPoint,
) -> ImagefiltergaborPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ImagefiltergaborPoint::scale(
  self : ImagefiltergaborPoint,
  s : Double,
) -> ImagefiltergaborPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ImagefiltergaborPoint::dot(
  self : ImagefiltergaborPoint,
  other : ImagefiltergaborPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ImagefiltergaborPoint::cross(
  self : ImagefiltergaborPoint,
  other : ImagefiltergaborPoint,
) -> ImagefiltergaborPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ImagefiltergaborPoint::norm(self : ImagefiltergaborPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ImagefiltergaborPoint::normalize(
  self : ImagefiltergaborPoint,
) -> ImagefiltergaborPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefiltergaborPoint::negate(
  self : ImagefiltergaborPoint,
) -> ImagefiltergaborPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ImagefiltergaborPoint::mid(
  self : ImagefiltergaborPoint,
  other : ImagefiltergaborPoint,
) -> ImagefiltergaborPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ImagefiltergaborPoint::lerp(
  self : ImagefiltergaborPoint,
  other : ImagefiltergaborPoint,
  t : Double,
) -> ImagefiltergaborPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ImagefiltergaborPoint::to_string(self : ImagefiltergaborPoint) -> String {
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
pub(all) struct ImagefiltergaborSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn image_filter_gabor_make_series(
  vals : Array[Double],
  name : String,
) -> ImagefiltergaborSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ImagefiltergaborSeries::len(self : ImagefiltergaborSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ImagefiltergaborSeries::sum(self : ImagefiltergaborSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ImagefiltergaborSeries::mean(self : ImagefiltergaborSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ImagefiltergaborSeries::min(self : ImagefiltergaborSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ImagefiltergaborSeries::max(self : ImagefiltergaborSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ImagefiltergaborSeries::range(self : ImagefiltergaborSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ImagefiltergaborSeries::variance(
  self : ImagefiltergaborSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ImagefiltergaborSeries::std(self : ImagefiltergaborSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ImagefiltergaborSeries::median(self : ImagefiltergaborSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ImagefiltergaborSeries::scale(
  self : ImagefiltergaborSeries,
  f : Double,
) -> ImagefiltergaborSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ImagefiltergaborSeries::add(
  self : ImagefiltergaborSeries,
  other : ImagefiltergaborSeries,
) -> ImagefiltergaborSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefiltergaborSeries::sub(
  self : ImagefiltergaborSeries,
  other : ImagefiltergaborSeries,
) -> ImagefiltergaborSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefiltergaborSeries::normalize(
  self : ImagefiltergaborSeries,
) -> ImagefiltergaborSeries {
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
pub fn ImagefiltergaborSeries::cumsum(
  self : ImagefiltergaborSeries,
) -> ImagefiltergaborSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ImagefiltergaborSeries::to_string(
  self : ImagefiltergaborSeries,
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
pub(all) struct ImagefiltergaborMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn image_filter_gabor_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ImagefiltergaborMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn image_filter_gabor_matrix_identity(n : Int32) -> ImagefiltergaborMatrix {
  let m = image_filter_gabor_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ImagefiltergaborMatrix::get(
  self : ImagefiltergaborMatrix,
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
pub fn ImagefiltergaborMatrix::transpose(
  self : ImagefiltergaborMatrix,
) -> ImagefiltergaborMatrix {
  let result = image_filter_gabor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefiltergaborMatrix::add(
  self : ImagefiltergaborMatrix,
  other : ImagefiltergaborMatrix,
) -> ImagefiltergaborMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = image_filter_gabor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefiltergaborMatrix::scale(
  self : ImagefiltergaborMatrix,
  s : Double,
) -> ImagefiltergaborMatrix {
  let result = image_filter_gabor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ImagefiltergaborMatrix::multiply(
  self : ImagefiltergaborMatrix,
  other : ImagefiltergaborMatrix,
) -> ImagefiltergaborMatrix {
  if self.cols != other.rows {
    return image_filter_gabor_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = image_filter_gabor_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ImagefiltergaborMatrix::trace(self : ImagefiltergaborMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ImagefiltergaborMatrix::det(self : ImagefiltergaborMatrix) -> Double {
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
pub fn ImagefiltergaborMatrix::norm(self : ImagefiltergaborMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ImagefiltergaborMatrix::to_string(
  self : ImagefiltergaborMatrix,
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
pub(all) struct ImagefiltergaborVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn image_filter_gabor_make_vector(
  comps : Array[Double],
) -> ImagefiltergaborVector {
  { comps, dim: comps.length(), }
}

///|
pub fn image_filter_gabor_vector_zero(dim : Int32) -> ImagefiltergaborVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ImagefiltergaborVector::add(
  self : ImagefiltergaborVector,
  other : ImagefiltergaborVector,
) -> ImagefiltergaborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefiltergaborVector::sub(
  self : ImagefiltergaborVector,
  other : ImagefiltergaborVector,
) -> ImagefiltergaborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefiltergaborVector::scale(
  self : ImagefiltergaborVector,
  s : Double,
) -> ImagefiltergaborVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ImagefiltergaborVector::dot(
  self : ImagefiltergaborVector,
  other : ImagefiltergaborVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ImagefiltergaborVector::norm(self : ImagefiltergaborVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ImagefiltergaborVector::normalize(
  self : ImagefiltergaborVector,
) -> ImagefiltergaborVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefiltergaborVector::dist(
  self : ImagefiltergaborVector,
  other : ImagefiltergaborVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ImagefiltergaborVector::to_string(
  self : ImagefiltergaborVector,
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
pub(all) struct ImagefiltergaborFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_frame_make(size : Int32) -> ImagefiltergaborFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborFrame::len(self : ImagefiltergaborFrame) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborFrame::get(
  self : ImagefiltergaborFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborFrame::set(
  self : ImagefiltergaborFrame,
  i : Int32,
  v : Double,
) -> ImagefiltergaborFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborFrame::sum(self : ImagefiltergaborFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborFrame::mean(self : ImagefiltergaborFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborFrame::scale(
  self : ImagefiltergaborFrame,
  f : Double,
) -> ImagefiltergaborFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborFrame::add(
  self : ImagefiltergaborFrame,
  other : ImagefiltergaborFrame,
) -> ImagefiltergaborFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborFrame::copy(
  self : ImagefiltergaborFrame,
) -> ImagefiltergaborFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborFrame::fill(
  self : ImagefiltergaborFrame,
  v : Double,
) -> ImagefiltergaborFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborFrame::min(self : ImagefiltergaborFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborFrame::max(self : ImagefiltergaborFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborFrame::to_string(self : ImagefiltergaborFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_table_make(size : Int32) -> ImagefiltergaborTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborTable::len(self : ImagefiltergaborTable) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborTable::get(
  self : ImagefiltergaborTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborTable::set(
  self : ImagefiltergaborTable,
  i : Int32,
  v : Double,
) -> ImagefiltergaborTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborTable::sum(self : ImagefiltergaborTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborTable::mean(self : ImagefiltergaborTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborTable::scale(
  self : ImagefiltergaborTable,
  f : Double,
) -> ImagefiltergaborTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborTable::add(
  self : ImagefiltergaborTable,
  other : ImagefiltergaborTable,
) -> ImagefiltergaborTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborTable::copy(
  self : ImagefiltergaborTable,
) -> ImagefiltergaborTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborTable::fill(
  self : ImagefiltergaborTable,
  v : Double,
) -> ImagefiltergaborTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborTable::min(self : ImagefiltergaborTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborTable::max(self : ImagefiltergaborTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborTable::to_string(self : ImagefiltergaborTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_graphn_make(size : Int32) -> ImagefiltergaborGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborGraphN::len(self : ImagefiltergaborGraphN) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborGraphN::get(
  self : ImagefiltergaborGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborGraphN::set(
  self : ImagefiltergaborGraphN,
  i : Int32,
  v : Double,
) -> ImagefiltergaborGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborGraphN::sum(self : ImagefiltergaborGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborGraphN::mean(self : ImagefiltergaborGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborGraphN::scale(
  self : ImagefiltergaborGraphN,
  f : Double,
) -> ImagefiltergaborGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborGraphN::add(
  self : ImagefiltergaborGraphN,
  other : ImagefiltergaborGraphN,
) -> ImagefiltergaborGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborGraphN::copy(
  self : ImagefiltergaborGraphN,
) -> ImagefiltergaborGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborGraphN::fill(
  self : ImagefiltergaborGraphN,
  v : Double,
) -> ImagefiltergaborGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborGraphN::min(self : ImagefiltergaborGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborGraphN::max(self : ImagefiltergaborGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborGraphN::to_string(
  self : ImagefiltergaborGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_node_make(size : Int32) -> ImagefiltergaborNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborNode::len(self : ImagefiltergaborNode) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborNode::get(
  self : ImagefiltergaborNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborNode::set(
  self : ImagefiltergaborNode,
  i : Int32,
  v : Double,
) -> ImagefiltergaborNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborNode::sum(self : ImagefiltergaborNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborNode::mean(self : ImagefiltergaborNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborNode::scale(
  self : ImagefiltergaborNode,
  f : Double,
) -> ImagefiltergaborNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborNode::add(
  self : ImagefiltergaborNode,
  other : ImagefiltergaborNode,
) -> ImagefiltergaborNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborNode::copy(
  self : ImagefiltergaborNode,
) -> ImagefiltergaborNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborNode::fill(
  self : ImagefiltergaborNode,
  v : Double,
) -> ImagefiltergaborNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborNode::min(self : ImagefiltergaborNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborNode::max(self : ImagefiltergaborNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborNode::to_string(self : ImagefiltergaborNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_edge_make(size : Int32) -> ImagefiltergaborEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborEdge::len(self : ImagefiltergaborEdge) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborEdge::get(
  self : ImagefiltergaborEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborEdge::set(
  self : ImagefiltergaborEdge,
  i : Int32,
  v : Double,
) -> ImagefiltergaborEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborEdge::sum(self : ImagefiltergaborEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborEdge::mean(self : ImagefiltergaborEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborEdge::scale(
  self : ImagefiltergaborEdge,
  f : Double,
) -> ImagefiltergaborEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborEdge::add(
  self : ImagefiltergaborEdge,
  other : ImagefiltergaborEdge,
) -> ImagefiltergaborEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborEdge::copy(
  self : ImagefiltergaborEdge,
) -> ImagefiltergaborEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborEdge::fill(
  self : ImagefiltergaborEdge,
  v : Double,
) -> ImagefiltergaborEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborEdge::min(self : ImagefiltergaborEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborEdge::max(self : ImagefiltergaborEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborEdge::to_string(self : ImagefiltergaborEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_path_make(size : Int32) -> ImagefiltergaborPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborPath::len(self : ImagefiltergaborPath) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborPath::get(
  self : ImagefiltergaborPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborPath::set(
  self : ImagefiltergaborPath,
  i : Int32,
  v : Double,
) -> ImagefiltergaborPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborPath::sum(self : ImagefiltergaborPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborPath::mean(self : ImagefiltergaborPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborPath::scale(
  self : ImagefiltergaborPath,
  f : Double,
) -> ImagefiltergaborPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborPath::add(
  self : ImagefiltergaborPath,
  other : ImagefiltergaborPath,
) -> ImagefiltergaborPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborPath::copy(
  self : ImagefiltergaborPath,
) -> ImagefiltergaborPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborPath::fill(
  self : ImagefiltergaborPath,
  v : Double,
) -> ImagefiltergaborPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborPath::min(self : ImagefiltergaborPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborPath::max(self : ImagefiltergaborPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborPath::to_string(self : ImagefiltergaborPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_cluster_make(size : Int32) -> ImagefiltergaborCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborCluster::len(self : ImagefiltergaborCluster) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborCluster::get(
  self : ImagefiltergaborCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborCluster::set(
  self : ImagefiltergaborCluster,
  i : Int32,
  v : Double,
) -> ImagefiltergaborCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborCluster::sum(self : ImagefiltergaborCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborCluster::mean(self : ImagefiltergaborCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborCluster::scale(
  self : ImagefiltergaborCluster,
  f : Double,
) -> ImagefiltergaborCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborCluster::add(
  self : ImagefiltergaborCluster,
  other : ImagefiltergaborCluster,
) -> ImagefiltergaborCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborCluster::copy(
  self : ImagefiltergaborCluster,
) -> ImagefiltergaborCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborCluster::fill(
  self : ImagefiltergaborCluster,
  v : Double,
) -> ImagefiltergaborCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborCluster::min(self : ImagefiltergaborCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborCluster::max(self : ImagefiltergaborCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborCluster::to_string(
  self : ImagefiltergaborCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_model_make(size : Int32) -> ImagefiltergaborModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborModel::len(self : ImagefiltergaborModel) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborModel::get(
  self : ImagefiltergaborModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborModel::set(
  self : ImagefiltergaborModel,
  i : Int32,
  v : Double,
) -> ImagefiltergaborModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborModel::sum(self : ImagefiltergaborModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborModel::mean(self : ImagefiltergaborModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborModel::scale(
  self : ImagefiltergaborModel,
  f : Double,
) -> ImagefiltergaborModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborModel::add(
  self : ImagefiltergaborModel,
  other : ImagefiltergaborModel,
) -> ImagefiltergaborModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborModel::copy(
  self : ImagefiltergaborModel,
) -> ImagefiltergaborModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborModel::fill(
  self : ImagefiltergaborModel,
  v : Double,
) -> ImagefiltergaborModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborModel::min(self : ImagefiltergaborModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborModel::max(self : ImagefiltergaborModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborModel::to_string(self : ImagefiltergaborModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_layer_make(size : Int32) -> ImagefiltergaborLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborLayer::len(self : ImagefiltergaborLayer) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborLayer::get(
  self : ImagefiltergaborLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborLayer::set(
  self : ImagefiltergaborLayer,
  i : Int32,
  v : Double,
) -> ImagefiltergaborLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborLayer::sum(self : ImagefiltergaborLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborLayer::mean(self : ImagefiltergaborLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborLayer::scale(
  self : ImagefiltergaborLayer,
  f : Double,
) -> ImagefiltergaborLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborLayer::add(
  self : ImagefiltergaborLayer,
  other : ImagefiltergaborLayer,
) -> ImagefiltergaborLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborLayer::copy(
  self : ImagefiltergaborLayer,
) -> ImagefiltergaborLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborLayer::fill(
  self : ImagefiltergaborLayer,
  v : Double,
) -> ImagefiltergaborLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborLayer::min(self : ImagefiltergaborLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborLayer::max(self : ImagefiltergaborLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborLayer::to_string(self : ImagefiltergaborLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_buffer_make(size : Int32) -> ImagefiltergaborBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborBuffer::len(self : ImagefiltergaborBuffer) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborBuffer::get(
  self : ImagefiltergaborBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborBuffer::set(
  self : ImagefiltergaborBuffer,
  i : Int32,
  v : Double,
) -> ImagefiltergaborBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborBuffer::sum(self : ImagefiltergaborBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborBuffer::mean(self : ImagefiltergaborBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborBuffer::scale(
  self : ImagefiltergaborBuffer,
  f : Double,
) -> ImagefiltergaborBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborBuffer::add(
  self : ImagefiltergaborBuffer,
  other : ImagefiltergaborBuffer,
) -> ImagefiltergaborBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborBuffer::copy(
  self : ImagefiltergaborBuffer,
) -> ImagefiltergaborBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborBuffer::fill(
  self : ImagefiltergaborBuffer,
  v : Double,
) -> ImagefiltergaborBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborBuffer::min(self : ImagefiltergaborBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborBuffer::max(self : ImagefiltergaborBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborBuffer::to_string(
  self : ImagefiltergaborBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_cursor_make(size : Int32) -> ImagefiltergaborCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborCursor::len(self : ImagefiltergaborCursor) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborCursor::get(
  self : ImagefiltergaborCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborCursor::set(
  self : ImagefiltergaborCursor,
  i : Int32,
  v : Double,
) -> ImagefiltergaborCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborCursor::sum(self : ImagefiltergaborCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborCursor::mean(self : ImagefiltergaborCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborCursor::scale(
  self : ImagefiltergaborCursor,
  f : Double,
) -> ImagefiltergaborCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborCursor::add(
  self : ImagefiltergaborCursor,
  other : ImagefiltergaborCursor,
) -> ImagefiltergaborCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborCursor::copy(
  self : ImagefiltergaborCursor,
) -> ImagefiltergaborCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborCursor::fill(
  self : ImagefiltergaborCursor,
  v : Double,
) -> ImagefiltergaborCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborCursor::min(self : ImagefiltergaborCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborCursor::max(self : ImagefiltergaborCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborCursor::to_string(
  self : ImagefiltergaborCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_view_make(size : Int32) -> ImagefiltergaborView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborView::len(self : ImagefiltergaborView) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborView::get(
  self : ImagefiltergaborView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborView::set(
  self : ImagefiltergaborView,
  i : Int32,
  v : Double,
) -> ImagefiltergaborView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborView::sum(self : ImagefiltergaborView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborView::mean(self : ImagefiltergaborView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborView::scale(
  self : ImagefiltergaborView,
  f : Double,
) -> ImagefiltergaborView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborView::add(
  self : ImagefiltergaborView,
  other : ImagefiltergaborView,
) -> ImagefiltergaborView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborView::copy(
  self : ImagefiltergaborView,
) -> ImagefiltergaborView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborView::fill(
  self : ImagefiltergaborView,
  v : Double,
) -> ImagefiltergaborView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborView::min(self : ImagefiltergaborView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborView::max(self : ImagefiltergaborView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborView::to_string(self : ImagefiltergaborView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_range_make(size : Int32) -> ImagefiltergaborRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborRange::len(self : ImagefiltergaborRange) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborRange::get(
  self : ImagefiltergaborRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborRange::set(
  self : ImagefiltergaborRange,
  i : Int32,
  v : Double,
) -> ImagefiltergaborRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborRange::sum(self : ImagefiltergaborRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborRange::mean(self : ImagefiltergaborRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborRange::scale(
  self : ImagefiltergaborRange,
  f : Double,
) -> ImagefiltergaborRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborRange::add(
  self : ImagefiltergaborRange,
  other : ImagefiltergaborRange,
) -> ImagefiltergaborRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborRange::copy(
  self : ImagefiltergaborRange,
) -> ImagefiltergaborRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborRange::fill(
  self : ImagefiltergaborRange,
  v : Double,
) -> ImagefiltergaborRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborRange::min(self : ImagefiltergaborRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborRange::max(self : ImagefiltergaborRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborRange::to_string(self : ImagefiltergaborRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltergaborSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_gabor_slice_make(size : Int32) -> ImagefiltergaborSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltergaborSlice::len(self : ImagefiltergaborSlice) -> Int32 {
  self.size
}

///|
pub fn ImagefiltergaborSlice::get(
  self : ImagefiltergaborSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltergaborSlice::set(
  self : ImagefiltergaborSlice,
  i : Int32,
  v : Double,
) -> ImagefiltergaborSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborSlice::sum(self : ImagefiltergaborSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltergaborSlice::mean(self : ImagefiltergaborSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltergaborSlice::scale(
  self : ImagefiltergaborSlice,
  f : Double,
) -> ImagefiltergaborSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborSlice::add(
  self : ImagefiltergaborSlice,
  other : ImagefiltergaborSlice,
) -> ImagefiltergaborSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltergaborSlice::copy(
  self : ImagefiltergaborSlice,
) -> ImagefiltergaborSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborSlice::fill(
  self : ImagefiltergaborSlice,
  v : Double,
) -> ImagefiltergaborSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltergaborSlice::min(self : ImagefiltergaborSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltergaborSlice::max(self : ImagefiltergaborSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltergaborSlice::to_string(self : ImagefiltergaborSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
