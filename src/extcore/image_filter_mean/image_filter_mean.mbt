///|
///===
/// extcore/image_filter_mean
pub(all) struct ImagefiltermeanPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn image_filter_mean_make_point(
  x : Double,
  y : Double,
) -> ImagefiltermeanPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn image_filter_mean_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ImagefiltermeanPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ImagefiltermeanPoint::x(self : ImagefiltermeanPoint) -> Double {
  self.x
}

///|
pub fn ImagefiltermeanPoint::y(self : ImagefiltermeanPoint) -> Double {
  self.y
}

///|
pub fn ImagefiltermeanPoint::z(self : ImagefiltermeanPoint) -> Double {
  self.z
}

///|
pub fn ImagefiltermeanPoint::label(self : ImagefiltermeanPoint) -> Int32 {
  self.label
}

///|
pub fn ImagefiltermeanPoint::dist(
  self : ImagefiltermeanPoint,
  other : ImagefiltermeanPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ImagefiltermeanPoint::add(
  self : ImagefiltermeanPoint,
  other : ImagefiltermeanPoint,
) -> ImagefiltermeanPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ImagefiltermeanPoint::sub(
  self : ImagefiltermeanPoint,
  other : ImagefiltermeanPoint,
) -> ImagefiltermeanPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ImagefiltermeanPoint::scale(
  self : ImagefiltermeanPoint,
  s : Double,
) -> ImagefiltermeanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ImagefiltermeanPoint::dot(
  self : ImagefiltermeanPoint,
  other : ImagefiltermeanPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ImagefiltermeanPoint::cross(
  self : ImagefiltermeanPoint,
  other : ImagefiltermeanPoint,
) -> ImagefiltermeanPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ImagefiltermeanPoint::norm(self : ImagefiltermeanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ImagefiltermeanPoint::normalize(
  self : ImagefiltermeanPoint,
) -> ImagefiltermeanPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefiltermeanPoint::negate(
  self : ImagefiltermeanPoint,
) -> ImagefiltermeanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ImagefiltermeanPoint::mid(
  self : ImagefiltermeanPoint,
  other : ImagefiltermeanPoint,
) -> ImagefiltermeanPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ImagefiltermeanPoint::lerp(
  self : ImagefiltermeanPoint,
  other : ImagefiltermeanPoint,
  t : Double,
) -> ImagefiltermeanPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ImagefiltermeanPoint::to_string(self : ImagefiltermeanPoint) -> String {
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
pub(all) struct ImagefiltermeanSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn image_filter_mean_make_series(
  vals : Array[Double],
  name : String,
) -> ImagefiltermeanSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ImagefiltermeanSeries::len(self : ImagefiltermeanSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ImagefiltermeanSeries::sum(self : ImagefiltermeanSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ImagefiltermeanSeries::mean(self : ImagefiltermeanSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ImagefiltermeanSeries::min(self : ImagefiltermeanSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ImagefiltermeanSeries::max(self : ImagefiltermeanSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ImagefiltermeanSeries::range(self : ImagefiltermeanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ImagefiltermeanSeries::variance(self : ImagefiltermeanSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ImagefiltermeanSeries::std(self : ImagefiltermeanSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ImagefiltermeanSeries::median(self : ImagefiltermeanSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ImagefiltermeanSeries::scale(
  self : ImagefiltermeanSeries,
  f : Double,
) -> ImagefiltermeanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ImagefiltermeanSeries::add(
  self : ImagefiltermeanSeries,
  other : ImagefiltermeanSeries,
) -> ImagefiltermeanSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefiltermeanSeries::sub(
  self : ImagefiltermeanSeries,
  other : ImagefiltermeanSeries,
) -> ImagefiltermeanSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefiltermeanSeries::normalize(
  self : ImagefiltermeanSeries,
) -> ImagefiltermeanSeries {
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
pub fn ImagefiltermeanSeries::cumsum(
  self : ImagefiltermeanSeries,
) -> ImagefiltermeanSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ImagefiltermeanSeries::to_string(self : ImagefiltermeanSeries) -> String {
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
pub(all) struct ImagefiltermeanMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn image_filter_mean_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ImagefiltermeanMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn image_filter_mean_matrix_identity(n : Int32) -> ImagefiltermeanMatrix {
  let m = image_filter_mean_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ImagefiltermeanMatrix::get(
  self : ImagefiltermeanMatrix,
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
pub fn ImagefiltermeanMatrix::transpose(
  self : ImagefiltermeanMatrix,
) -> ImagefiltermeanMatrix {
  let result = image_filter_mean_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefiltermeanMatrix::add(
  self : ImagefiltermeanMatrix,
  other : ImagefiltermeanMatrix,
) -> ImagefiltermeanMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = image_filter_mean_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefiltermeanMatrix::scale(
  self : ImagefiltermeanMatrix,
  s : Double,
) -> ImagefiltermeanMatrix {
  let result = image_filter_mean_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ImagefiltermeanMatrix::multiply(
  self : ImagefiltermeanMatrix,
  other : ImagefiltermeanMatrix,
) -> ImagefiltermeanMatrix {
  if self.cols != other.rows {
    return image_filter_mean_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = image_filter_mean_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ImagefiltermeanMatrix::trace(self : ImagefiltermeanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ImagefiltermeanMatrix::det(self : ImagefiltermeanMatrix) -> Double {
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
pub fn ImagefiltermeanMatrix::norm(self : ImagefiltermeanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ImagefiltermeanMatrix::to_string(self : ImagefiltermeanMatrix) -> String {
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
pub(all) struct ImagefiltermeanVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn image_filter_mean_make_vector(
  comps : Array[Double],
) -> ImagefiltermeanVector {
  { comps, dim: comps.length(), }
}

///|
pub fn image_filter_mean_vector_zero(dim : Int32) -> ImagefiltermeanVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ImagefiltermeanVector::add(
  self : ImagefiltermeanVector,
  other : ImagefiltermeanVector,
) -> ImagefiltermeanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefiltermeanVector::sub(
  self : ImagefiltermeanVector,
  other : ImagefiltermeanVector,
) -> ImagefiltermeanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefiltermeanVector::scale(
  self : ImagefiltermeanVector,
  s : Double,
) -> ImagefiltermeanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ImagefiltermeanVector::dot(
  self : ImagefiltermeanVector,
  other : ImagefiltermeanVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ImagefiltermeanVector::norm(self : ImagefiltermeanVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ImagefiltermeanVector::normalize(
  self : ImagefiltermeanVector,
) -> ImagefiltermeanVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefiltermeanVector::dist(
  self : ImagefiltermeanVector,
  other : ImagefiltermeanVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ImagefiltermeanVector::to_string(self : ImagefiltermeanVector) -> String {
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
pub(all) struct ImagefiltermeanFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_frame_make(size : Int32) -> ImagefiltermeanFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanFrame::len(self : ImagefiltermeanFrame) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanFrame::get(
  self : ImagefiltermeanFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanFrame::set(
  self : ImagefiltermeanFrame,
  i : Int32,
  v : Double,
) -> ImagefiltermeanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanFrame::sum(self : ImagefiltermeanFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanFrame::mean(self : ImagefiltermeanFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanFrame::scale(
  self : ImagefiltermeanFrame,
  f : Double,
) -> ImagefiltermeanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanFrame::add(
  self : ImagefiltermeanFrame,
  other : ImagefiltermeanFrame,
) -> ImagefiltermeanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanFrame::copy(
  self : ImagefiltermeanFrame,
) -> ImagefiltermeanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanFrame::fill(
  self : ImagefiltermeanFrame,
  v : Double,
) -> ImagefiltermeanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanFrame::min(self : ImagefiltermeanFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanFrame::max(self : ImagefiltermeanFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanFrame::to_string(self : ImagefiltermeanFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_table_make(size : Int32) -> ImagefiltermeanTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanTable::len(self : ImagefiltermeanTable) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanTable::get(
  self : ImagefiltermeanTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanTable::set(
  self : ImagefiltermeanTable,
  i : Int32,
  v : Double,
) -> ImagefiltermeanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanTable::sum(self : ImagefiltermeanTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanTable::mean(self : ImagefiltermeanTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanTable::scale(
  self : ImagefiltermeanTable,
  f : Double,
) -> ImagefiltermeanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanTable::add(
  self : ImagefiltermeanTable,
  other : ImagefiltermeanTable,
) -> ImagefiltermeanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanTable::copy(
  self : ImagefiltermeanTable,
) -> ImagefiltermeanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanTable::fill(
  self : ImagefiltermeanTable,
  v : Double,
) -> ImagefiltermeanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanTable::min(self : ImagefiltermeanTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanTable::max(self : ImagefiltermeanTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanTable::to_string(self : ImagefiltermeanTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_graphn_make(size : Int32) -> ImagefiltermeanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanGraphN::len(self : ImagefiltermeanGraphN) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanGraphN::get(
  self : ImagefiltermeanGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanGraphN::set(
  self : ImagefiltermeanGraphN,
  i : Int32,
  v : Double,
) -> ImagefiltermeanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanGraphN::sum(self : ImagefiltermeanGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanGraphN::mean(self : ImagefiltermeanGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanGraphN::scale(
  self : ImagefiltermeanGraphN,
  f : Double,
) -> ImagefiltermeanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanGraphN::add(
  self : ImagefiltermeanGraphN,
  other : ImagefiltermeanGraphN,
) -> ImagefiltermeanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanGraphN::copy(
  self : ImagefiltermeanGraphN,
) -> ImagefiltermeanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanGraphN::fill(
  self : ImagefiltermeanGraphN,
  v : Double,
) -> ImagefiltermeanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanGraphN::min(self : ImagefiltermeanGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanGraphN::max(self : ImagefiltermeanGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanGraphN::to_string(self : ImagefiltermeanGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_node_make(size : Int32) -> ImagefiltermeanNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanNode::len(self : ImagefiltermeanNode) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanNode::get(
  self : ImagefiltermeanNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanNode::set(
  self : ImagefiltermeanNode,
  i : Int32,
  v : Double,
) -> ImagefiltermeanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanNode::sum(self : ImagefiltermeanNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanNode::mean(self : ImagefiltermeanNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanNode::scale(
  self : ImagefiltermeanNode,
  f : Double,
) -> ImagefiltermeanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanNode::add(
  self : ImagefiltermeanNode,
  other : ImagefiltermeanNode,
) -> ImagefiltermeanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanNode::copy(
  self : ImagefiltermeanNode,
) -> ImagefiltermeanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanNode::fill(
  self : ImagefiltermeanNode,
  v : Double,
) -> ImagefiltermeanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanNode::min(self : ImagefiltermeanNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanNode::max(self : ImagefiltermeanNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanNode::to_string(self : ImagefiltermeanNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_edge_make(size : Int32) -> ImagefiltermeanEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanEdge::len(self : ImagefiltermeanEdge) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanEdge::get(
  self : ImagefiltermeanEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanEdge::set(
  self : ImagefiltermeanEdge,
  i : Int32,
  v : Double,
) -> ImagefiltermeanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanEdge::sum(self : ImagefiltermeanEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanEdge::mean(self : ImagefiltermeanEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanEdge::scale(
  self : ImagefiltermeanEdge,
  f : Double,
) -> ImagefiltermeanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanEdge::add(
  self : ImagefiltermeanEdge,
  other : ImagefiltermeanEdge,
) -> ImagefiltermeanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanEdge::copy(
  self : ImagefiltermeanEdge,
) -> ImagefiltermeanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanEdge::fill(
  self : ImagefiltermeanEdge,
  v : Double,
) -> ImagefiltermeanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanEdge::min(self : ImagefiltermeanEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanEdge::max(self : ImagefiltermeanEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanEdge::to_string(self : ImagefiltermeanEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_path_make(size : Int32) -> ImagefiltermeanPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanPath::len(self : ImagefiltermeanPath) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanPath::get(
  self : ImagefiltermeanPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanPath::set(
  self : ImagefiltermeanPath,
  i : Int32,
  v : Double,
) -> ImagefiltermeanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanPath::sum(self : ImagefiltermeanPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanPath::mean(self : ImagefiltermeanPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanPath::scale(
  self : ImagefiltermeanPath,
  f : Double,
) -> ImagefiltermeanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanPath::add(
  self : ImagefiltermeanPath,
  other : ImagefiltermeanPath,
) -> ImagefiltermeanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanPath::copy(
  self : ImagefiltermeanPath,
) -> ImagefiltermeanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanPath::fill(
  self : ImagefiltermeanPath,
  v : Double,
) -> ImagefiltermeanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanPath::min(self : ImagefiltermeanPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanPath::max(self : ImagefiltermeanPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanPath::to_string(self : ImagefiltermeanPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_cluster_make(size : Int32) -> ImagefiltermeanCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanCluster::len(self : ImagefiltermeanCluster) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanCluster::get(
  self : ImagefiltermeanCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanCluster::set(
  self : ImagefiltermeanCluster,
  i : Int32,
  v : Double,
) -> ImagefiltermeanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanCluster::sum(self : ImagefiltermeanCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanCluster::mean(self : ImagefiltermeanCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanCluster::scale(
  self : ImagefiltermeanCluster,
  f : Double,
) -> ImagefiltermeanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanCluster::add(
  self : ImagefiltermeanCluster,
  other : ImagefiltermeanCluster,
) -> ImagefiltermeanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanCluster::copy(
  self : ImagefiltermeanCluster,
) -> ImagefiltermeanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanCluster::fill(
  self : ImagefiltermeanCluster,
  v : Double,
) -> ImagefiltermeanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanCluster::min(self : ImagefiltermeanCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanCluster::max(self : ImagefiltermeanCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanCluster::to_string(
  self : ImagefiltermeanCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_model_make(size : Int32) -> ImagefiltermeanModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanModel::len(self : ImagefiltermeanModel) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanModel::get(
  self : ImagefiltermeanModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanModel::set(
  self : ImagefiltermeanModel,
  i : Int32,
  v : Double,
) -> ImagefiltermeanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanModel::sum(self : ImagefiltermeanModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanModel::mean(self : ImagefiltermeanModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanModel::scale(
  self : ImagefiltermeanModel,
  f : Double,
) -> ImagefiltermeanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanModel::add(
  self : ImagefiltermeanModel,
  other : ImagefiltermeanModel,
) -> ImagefiltermeanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanModel::copy(
  self : ImagefiltermeanModel,
) -> ImagefiltermeanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanModel::fill(
  self : ImagefiltermeanModel,
  v : Double,
) -> ImagefiltermeanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanModel::min(self : ImagefiltermeanModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanModel::max(self : ImagefiltermeanModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanModel::to_string(self : ImagefiltermeanModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_layer_make(size : Int32) -> ImagefiltermeanLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanLayer::len(self : ImagefiltermeanLayer) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanLayer::get(
  self : ImagefiltermeanLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanLayer::set(
  self : ImagefiltermeanLayer,
  i : Int32,
  v : Double,
) -> ImagefiltermeanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanLayer::sum(self : ImagefiltermeanLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanLayer::mean(self : ImagefiltermeanLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanLayer::scale(
  self : ImagefiltermeanLayer,
  f : Double,
) -> ImagefiltermeanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanLayer::add(
  self : ImagefiltermeanLayer,
  other : ImagefiltermeanLayer,
) -> ImagefiltermeanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanLayer::copy(
  self : ImagefiltermeanLayer,
) -> ImagefiltermeanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanLayer::fill(
  self : ImagefiltermeanLayer,
  v : Double,
) -> ImagefiltermeanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanLayer::min(self : ImagefiltermeanLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanLayer::max(self : ImagefiltermeanLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanLayer::to_string(self : ImagefiltermeanLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_buffer_make(size : Int32) -> ImagefiltermeanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanBuffer::len(self : ImagefiltermeanBuffer) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanBuffer::get(
  self : ImagefiltermeanBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanBuffer::set(
  self : ImagefiltermeanBuffer,
  i : Int32,
  v : Double,
) -> ImagefiltermeanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanBuffer::sum(self : ImagefiltermeanBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanBuffer::mean(self : ImagefiltermeanBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanBuffer::scale(
  self : ImagefiltermeanBuffer,
  f : Double,
) -> ImagefiltermeanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanBuffer::add(
  self : ImagefiltermeanBuffer,
  other : ImagefiltermeanBuffer,
) -> ImagefiltermeanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanBuffer::copy(
  self : ImagefiltermeanBuffer,
) -> ImagefiltermeanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanBuffer::fill(
  self : ImagefiltermeanBuffer,
  v : Double,
) -> ImagefiltermeanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanBuffer::min(self : ImagefiltermeanBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanBuffer::max(self : ImagefiltermeanBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanBuffer::to_string(self : ImagefiltermeanBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_cursor_make(size : Int32) -> ImagefiltermeanCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanCursor::len(self : ImagefiltermeanCursor) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanCursor::get(
  self : ImagefiltermeanCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanCursor::set(
  self : ImagefiltermeanCursor,
  i : Int32,
  v : Double,
) -> ImagefiltermeanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanCursor::sum(self : ImagefiltermeanCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanCursor::mean(self : ImagefiltermeanCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanCursor::scale(
  self : ImagefiltermeanCursor,
  f : Double,
) -> ImagefiltermeanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanCursor::add(
  self : ImagefiltermeanCursor,
  other : ImagefiltermeanCursor,
) -> ImagefiltermeanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanCursor::copy(
  self : ImagefiltermeanCursor,
) -> ImagefiltermeanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanCursor::fill(
  self : ImagefiltermeanCursor,
  v : Double,
) -> ImagefiltermeanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanCursor::min(self : ImagefiltermeanCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanCursor::max(self : ImagefiltermeanCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanCursor::to_string(self : ImagefiltermeanCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_view_make(size : Int32) -> ImagefiltermeanView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanView::len(self : ImagefiltermeanView) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanView::get(
  self : ImagefiltermeanView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanView::set(
  self : ImagefiltermeanView,
  i : Int32,
  v : Double,
) -> ImagefiltermeanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanView::sum(self : ImagefiltermeanView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanView::mean(self : ImagefiltermeanView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanView::scale(
  self : ImagefiltermeanView,
  f : Double,
) -> ImagefiltermeanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanView::add(
  self : ImagefiltermeanView,
  other : ImagefiltermeanView,
) -> ImagefiltermeanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanView::copy(
  self : ImagefiltermeanView,
) -> ImagefiltermeanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanView::fill(
  self : ImagefiltermeanView,
  v : Double,
) -> ImagefiltermeanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanView::min(self : ImagefiltermeanView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanView::max(self : ImagefiltermeanView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanView::to_string(self : ImagefiltermeanView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_range_make(size : Int32) -> ImagefiltermeanRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanRange::len(self : ImagefiltermeanRange) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanRange::get(
  self : ImagefiltermeanRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanRange::set(
  self : ImagefiltermeanRange,
  i : Int32,
  v : Double,
) -> ImagefiltermeanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanRange::sum(self : ImagefiltermeanRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanRange::mean(self : ImagefiltermeanRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanRange::scale(
  self : ImagefiltermeanRange,
  f : Double,
) -> ImagefiltermeanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanRange::add(
  self : ImagefiltermeanRange,
  other : ImagefiltermeanRange,
) -> ImagefiltermeanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanRange::copy(
  self : ImagefiltermeanRange,
) -> ImagefiltermeanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanRange::fill(
  self : ImagefiltermeanRange,
  v : Double,
) -> ImagefiltermeanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanRange::min(self : ImagefiltermeanRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanRange::max(self : ImagefiltermeanRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanRange::to_string(self : ImagefiltermeanRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermeanSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_mean_slice_make(size : Int32) -> ImagefiltermeanSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermeanSlice::len(self : ImagefiltermeanSlice) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermeanSlice::get(
  self : ImagefiltermeanSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermeanSlice::set(
  self : ImagefiltermeanSlice,
  i : Int32,
  v : Double,
) -> ImagefiltermeanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanSlice::sum(self : ImagefiltermeanSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermeanSlice::mean(self : ImagefiltermeanSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermeanSlice::scale(
  self : ImagefiltermeanSlice,
  f : Double,
) -> ImagefiltermeanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanSlice::add(
  self : ImagefiltermeanSlice,
  other : ImagefiltermeanSlice,
) -> ImagefiltermeanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermeanSlice::copy(
  self : ImagefiltermeanSlice,
) -> ImagefiltermeanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanSlice::fill(
  self : ImagefiltermeanSlice,
  v : Double,
) -> ImagefiltermeanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermeanSlice::min(self : ImagefiltermeanSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermeanSlice::max(self : ImagefiltermeanSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermeanSlice::to_string(self : ImagefiltermeanSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
