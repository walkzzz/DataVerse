///|
///===
/// extcore/image_filter_median
pub(all) struct ImagefiltermedianPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn image_filter_median_make_point(
  x : Double,
  y : Double,
) -> ImagefiltermedianPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn image_filter_median_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ImagefiltermedianPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ImagefiltermedianPoint::x(self : ImagefiltermedianPoint) -> Double {
  self.x
}

///|
pub fn ImagefiltermedianPoint::y(self : ImagefiltermedianPoint) -> Double {
  self.y
}

///|
pub fn ImagefiltermedianPoint::z(self : ImagefiltermedianPoint) -> Double {
  self.z
}

///|
pub fn ImagefiltermedianPoint::label(self : ImagefiltermedianPoint) -> Int32 {
  self.label
}

///|
pub fn ImagefiltermedianPoint::dist(
  self : ImagefiltermedianPoint,
  other : ImagefiltermedianPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ImagefiltermedianPoint::add(
  self : ImagefiltermedianPoint,
  other : ImagefiltermedianPoint,
) -> ImagefiltermedianPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ImagefiltermedianPoint::sub(
  self : ImagefiltermedianPoint,
  other : ImagefiltermedianPoint,
) -> ImagefiltermedianPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ImagefiltermedianPoint::scale(
  self : ImagefiltermedianPoint,
  s : Double,
) -> ImagefiltermedianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ImagefiltermedianPoint::dot(
  self : ImagefiltermedianPoint,
  other : ImagefiltermedianPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ImagefiltermedianPoint::cross(
  self : ImagefiltermedianPoint,
  other : ImagefiltermedianPoint,
) -> ImagefiltermedianPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ImagefiltermedianPoint::norm(self : ImagefiltermedianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ImagefiltermedianPoint::normalize(
  self : ImagefiltermedianPoint,
) -> ImagefiltermedianPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefiltermedianPoint::negate(
  self : ImagefiltermedianPoint,
) -> ImagefiltermedianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ImagefiltermedianPoint::mid(
  self : ImagefiltermedianPoint,
  other : ImagefiltermedianPoint,
) -> ImagefiltermedianPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ImagefiltermedianPoint::lerp(
  self : ImagefiltermedianPoint,
  other : ImagefiltermedianPoint,
  t : Double,
) -> ImagefiltermedianPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ImagefiltermedianPoint::to_string(
  self : ImagefiltermedianPoint,
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
pub(all) struct ImagefiltermedianSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn image_filter_median_make_series(
  vals : Array[Double],
  name : String,
) -> ImagefiltermedianSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ImagefiltermedianSeries::len(self : ImagefiltermedianSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ImagefiltermedianSeries::sum(self : ImagefiltermedianSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ImagefiltermedianSeries::mean(self : ImagefiltermedianSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ImagefiltermedianSeries::min(self : ImagefiltermedianSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ImagefiltermedianSeries::max(self : ImagefiltermedianSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ImagefiltermedianSeries::range(self : ImagefiltermedianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ImagefiltermedianSeries::variance(
  self : ImagefiltermedianSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ImagefiltermedianSeries::std(self : ImagefiltermedianSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ImagefiltermedianSeries::median(
  self : ImagefiltermedianSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ImagefiltermedianSeries::scale(
  self : ImagefiltermedianSeries,
  f : Double,
) -> ImagefiltermedianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ImagefiltermedianSeries::add(
  self : ImagefiltermedianSeries,
  other : ImagefiltermedianSeries,
) -> ImagefiltermedianSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefiltermedianSeries::sub(
  self : ImagefiltermedianSeries,
  other : ImagefiltermedianSeries,
) -> ImagefiltermedianSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefiltermedianSeries::normalize(
  self : ImagefiltermedianSeries,
) -> ImagefiltermedianSeries {
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
pub fn ImagefiltermedianSeries::cumsum(
  self : ImagefiltermedianSeries,
) -> ImagefiltermedianSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ImagefiltermedianSeries::to_string(
  self : ImagefiltermedianSeries,
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
pub(all) struct ImagefiltermedianMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn image_filter_median_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ImagefiltermedianMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn image_filter_median_matrix_identity(
  n : Int32,
) -> ImagefiltermedianMatrix {
  let m = image_filter_median_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ImagefiltermedianMatrix::get(
  self : ImagefiltermedianMatrix,
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
pub fn ImagefiltermedianMatrix::transpose(
  self : ImagefiltermedianMatrix,
) -> ImagefiltermedianMatrix {
  let result = image_filter_median_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefiltermedianMatrix::add(
  self : ImagefiltermedianMatrix,
  other : ImagefiltermedianMatrix,
) -> ImagefiltermedianMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = image_filter_median_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefiltermedianMatrix::scale(
  self : ImagefiltermedianMatrix,
  s : Double,
) -> ImagefiltermedianMatrix {
  let result = image_filter_median_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ImagefiltermedianMatrix::multiply(
  self : ImagefiltermedianMatrix,
  other : ImagefiltermedianMatrix,
) -> ImagefiltermedianMatrix {
  if self.cols != other.rows {
    return image_filter_median_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = image_filter_median_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ImagefiltermedianMatrix::trace(self : ImagefiltermedianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ImagefiltermedianMatrix::det(self : ImagefiltermedianMatrix) -> Double {
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
pub fn ImagefiltermedianMatrix::norm(self : ImagefiltermedianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ImagefiltermedianMatrix::to_string(
  self : ImagefiltermedianMatrix,
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
pub(all) struct ImagefiltermedianVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn image_filter_median_make_vector(
  comps : Array[Double],
) -> ImagefiltermedianVector {
  { comps, dim: comps.length(), }
}

///|
pub fn image_filter_median_vector_zero(dim : Int32) -> ImagefiltermedianVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ImagefiltermedianVector::add(
  self : ImagefiltermedianVector,
  other : ImagefiltermedianVector,
) -> ImagefiltermedianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefiltermedianVector::sub(
  self : ImagefiltermedianVector,
  other : ImagefiltermedianVector,
) -> ImagefiltermedianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefiltermedianVector::scale(
  self : ImagefiltermedianVector,
  s : Double,
) -> ImagefiltermedianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ImagefiltermedianVector::dot(
  self : ImagefiltermedianVector,
  other : ImagefiltermedianVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ImagefiltermedianVector::norm(self : ImagefiltermedianVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ImagefiltermedianVector::normalize(
  self : ImagefiltermedianVector,
) -> ImagefiltermedianVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefiltermedianVector::dist(
  self : ImagefiltermedianVector,
  other : ImagefiltermedianVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ImagefiltermedianVector::to_string(
  self : ImagefiltermedianVector,
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
pub(all) struct ImagefiltermedianFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_frame_make(size : Int32) -> ImagefiltermedianFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianFrame::len(self : ImagefiltermedianFrame) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianFrame::get(
  self : ImagefiltermedianFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianFrame::set(
  self : ImagefiltermedianFrame,
  i : Int32,
  v : Double,
) -> ImagefiltermedianFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianFrame::sum(self : ImagefiltermedianFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianFrame::mean(self : ImagefiltermedianFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianFrame::scale(
  self : ImagefiltermedianFrame,
  f : Double,
) -> ImagefiltermedianFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianFrame::add(
  self : ImagefiltermedianFrame,
  other : ImagefiltermedianFrame,
) -> ImagefiltermedianFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianFrame::copy(
  self : ImagefiltermedianFrame,
) -> ImagefiltermedianFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianFrame::fill(
  self : ImagefiltermedianFrame,
  v : Double,
) -> ImagefiltermedianFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianFrame::min(self : ImagefiltermedianFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianFrame::max(self : ImagefiltermedianFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianFrame::to_string(
  self : ImagefiltermedianFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_table_make(size : Int32) -> ImagefiltermedianTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianTable::len(self : ImagefiltermedianTable) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianTable::get(
  self : ImagefiltermedianTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianTable::set(
  self : ImagefiltermedianTable,
  i : Int32,
  v : Double,
) -> ImagefiltermedianTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianTable::sum(self : ImagefiltermedianTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianTable::mean(self : ImagefiltermedianTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianTable::scale(
  self : ImagefiltermedianTable,
  f : Double,
) -> ImagefiltermedianTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianTable::add(
  self : ImagefiltermedianTable,
  other : ImagefiltermedianTable,
) -> ImagefiltermedianTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianTable::copy(
  self : ImagefiltermedianTable,
) -> ImagefiltermedianTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianTable::fill(
  self : ImagefiltermedianTable,
  v : Double,
) -> ImagefiltermedianTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianTable::min(self : ImagefiltermedianTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianTable::max(self : ImagefiltermedianTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianTable::to_string(
  self : ImagefiltermedianTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_graphn_make(size : Int32) -> ImagefiltermedianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianGraphN::len(self : ImagefiltermedianGraphN) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianGraphN::get(
  self : ImagefiltermedianGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianGraphN::set(
  self : ImagefiltermedianGraphN,
  i : Int32,
  v : Double,
) -> ImagefiltermedianGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianGraphN::sum(self : ImagefiltermedianGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianGraphN::mean(self : ImagefiltermedianGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianGraphN::scale(
  self : ImagefiltermedianGraphN,
  f : Double,
) -> ImagefiltermedianGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianGraphN::add(
  self : ImagefiltermedianGraphN,
  other : ImagefiltermedianGraphN,
) -> ImagefiltermedianGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianGraphN::copy(
  self : ImagefiltermedianGraphN,
) -> ImagefiltermedianGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianGraphN::fill(
  self : ImagefiltermedianGraphN,
  v : Double,
) -> ImagefiltermedianGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianGraphN::min(self : ImagefiltermedianGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianGraphN::max(self : ImagefiltermedianGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianGraphN::to_string(
  self : ImagefiltermedianGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_node_make(size : Int32) -> ImagefiltermedianNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianNode::len(self : ImagefiltermedianNode) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianNode::get(
  self : ImagefiltermedianNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianNode::set(
  self : ImagefiltermedianNode,
  i : Int32,
  v : Double,
) -> ImagefiltermedianNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianNode::sum(self : ImagefiltermedianNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianNode::mean(self : ImagefiltermedianNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianNode::scale(
  self : ImagefiltermedianNode,
  f : Double,
) -> ImagefiltermedianNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianNode::add(
  self : ImagefiltermedianNode,
  other : ImagefiltermedianNode,
) -> ImagefiltermedianNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianNode::copy(
  self : ImagefiltermedianNode,
) -> ImagefiltermedianNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianNode::fill(
  self : ImagefiltermedianNode,
  v : Double,
) -> ImagefiltermedianNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianNode::min(self : ImagefiltermedianNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianNode::max(self : ImagefiltermedianNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianNode::to_string(self : ImagefiltermedianNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_edge_make(size : Int32) -> ImagefiltermedianEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianEdge::len(self : ImagefiltermedianEdge) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianEdge::get(
  self : ImagefiltermedianEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianEdge::set(
  self : ImagefiltermedianEdge,
  i : Int32,
  v : Double,
) -> ImagefiltermedianEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianEdge::sum(self : ImagefiltermedianEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianEdge::mean(self : ImagefiltermedianEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianEdge::scale(
  self : ImagefiltermedianEdge,
  f : Double,
) -> ImagefiltermedianEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianEdge::add(
  self : ImagefiltermedianEdge,
  other : ImagefiltermedianEdge,
) -> ImagefiltermedianEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianEdge::copy(
  self : ImagefiltermedianEdge,
) -> ImagefiltermedianEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianEdge::fill(
  self : ImagefiltermedianEdge,
  v : Double,
) -> ImagefiltermedianEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianEdge::min(self : ImagefiltermedianEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianEdge::max(self : ImagefiltermedianEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianEdge::to_string(self : ImagefiltermedianEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_path_make(size : Int32) -> ImagefiltermedianPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianPath::len(self : ImagefiltermedianPath) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianPath::get(
  self : ImagefiltermedianPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianPath::set(
  self : ImagefiltermedianPath,
  i : Int32,
  v : Double,
) -> ImagefiltermedianPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianPath::sum(self : ImagefiltermedianPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianPath::mean(self : ImagefiltermedianPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianPath::scale(
  self : ImagefiltermedianPath,
  f : Double,
) -> ImagefiltermedianPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianPath::add(
  self : ImagefiltermedianPath,
  other : ImagefiltermedianPath,
) -> ImagefiltermedianPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianPath::copy(
  self : ImagefiltermedianPath,
) -> ImagefiltermedianPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianPath::fill(
  self : ImagefiltermedianPath,
  v : Double,
) -> ImagefiltermedianPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianPath::min(self : ImagefiltermedianPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianPath::max(self : ImagefiltermedianPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianPath::to_string(self : ImagefiltermedianPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_cluster_make(
  size : Int32,
) -> ImagefiltermedianCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianCluster::len(self : ImagefiltermedianCluster) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianCluster::get(
  self : ImagefiltermedianCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianCluster::set(
  self : ImagefiltermedianCluster,
  i : Int32,
  v : Double,
) -> ImagefiltermedianCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianCluster::sum(self : ImagefiltermedianCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianCluster::mean(
  self : ImagefiltermedianCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianCluster::scale(
  self : ImagefiltermedianCluster,
  f : Double,
) -> ImagefiltermedianCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianCluster::add(
  self : ImagefiltermedianCluster,
  other : ImagefiltermedianCluster,
) -> ImagefiltermedianCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianCluster::copy(
  self : ImagefiltermedianCluster,
) -> ImagefiltermedianCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianCluster::fill(
  self : ImagefiltermedianCluster,
  v : Double,
) -> ImagefiltermedianCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianCluster::min(self : ImagefiltermedianCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianCluster::max(self : ImagefiltermedianCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianCluster::to_string(
  self : ImagefiltermedianCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_model_make(size : Int32) -> ImagefiltermedianModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianModel::len(self : ImagefiltermedianModel) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianModel::get(
  self : ImagefiltermedianModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianModel::set(
  self : ImagefiltermedianModel,
  i : Int32,
  v : Double,
) -> ImagefiltermedianModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianModel::sum(self : ImagefiltermedianModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianModel::mean(self : ImagefiltermedianModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianModel::scale(
  self : ImagefiltermedianModel,
  f : Double,
) -> ImagefiltermedianModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianModel::add(
  self : ImagefiltermedianModel,
  other : ImagefiltermedianModel,
) -> ImagefiltermedianModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianModel::copy(
  self : ImagefiltermedianModel,
) -> ImagefiltermedianModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianModel::fill(
  self : ImagefiltermedianModel,
  v : Double,
) -> ImagefiltermedianModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianModel::min(self : ImagefiltermedianModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianModel::max(self : ImagefiltermedianModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianModel::to_string(
  self : ImagefiltermedianModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_layer_make(size : Int32) -> ImagefiltermedianLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianLayer::len(self : ImagefiltermedianLayer) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianLayer::get(
  self : ImagefiltermedianLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianLayer::set(
  self : ImagefiltermedianLayer,
  i : Int32,
  v : Double,
) -> ImagefiltermedianLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianLayer::sum(self : ImagefiltermedianLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianLayer::mean(self : ImagefiltermedianLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianLayer::scale(
  self : ImagefiltermedianLayer,
  f : Double,
) -> ImagefiltermedianLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianLayer::add(
  self : ImagefiltermedianLayer,
  other : ImagefiltermedianLayer,
) -> ImagefiltermedianLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianLayer::copy(
  self : ImagefiltermedianLayer,
) -> ImagefiltermedianLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianLayer::fill(
  self : ImagefiltermedianLayer,
  v : Double,
) -> ImagefiltermedianLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianLayer::min(self : ImagefiltermedianLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianLayer::max(self : ImagefiltermedianLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianLayer::to_string(
  self : ImagefiltermedianLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_buffer_make(size : Int32) -> ImagefiltermedianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianBuffer::len(self : ImagefiltermedianBuffer) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianBuffer::get(
  self : ImagefiltermedianBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianBuffer::set(
  self : ImagefiltermedianBuffer,
  i : Int32,
  v : Double,
) -> ImagefiltermedianBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianBuffer::sum(self : ImagefiltermedianBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianBuffer::mean(self : ImagefiltermedianBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianBuffer::scale(
  self : ImagefiltermedianBuffer,
  f : Double,
) -> ImagefiltermedianBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianBuffer::add(
  self : ImagefiltermedianBuffer,
  other : ImagefiltermedianBuffer,
) -> ImagefiltermedianBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianBuffer::copy(
  self : ImagefiltermedianBuffer,
) -> ImagefiltermedianBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianBuffer::fill(
  self : ImagefiltermedianBuffer,
  v : Double,
) -> ImagefiltermedianBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianBuffer::min(self : ImagefiltermedianBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianBuffer::max(self : ImagefiltermedianBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianBuffer::to_string(
  self : ImagefiltermedianBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_cursor_make(size : Int32) -> ImagefiltermedianCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianCursor::len(self : ImagefiltermedianCursor) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianCursor::get(
  self : ImagefiltermedianCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianCursor::set(
  self : ImagefiltermedianCursor,
  i : Int32,
  v : Double,
) -> ImagefiltermedianCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianCursor::sum(self : ImagefiltermedianCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianCursor::mean(self : ImagefiltermedianCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianCursor::scale(
  self : ImagefiltermedianCursor,
  f : Double,
) -> ImagefiltermedianCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianCursor::add(
  self : ImagefiltermedianCursor,
  other : ImagefiltermedianCursor,
) -> ImagefiltermedianCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianCursor::copy(
  self : ImagefiltermedianCursor,
) -> ImagefiltermedianCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianCursor::fill(
  self : ImagefiltermedianCursor,
  v : Double,
) -> ImagefiltermedianCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianCursor::min(self : ImagefiltermedianCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianCursor::max(self : ImagefiltermedianCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianCursor::to_string(
  self : ImagefiltermedianCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_view_make(size : Int32) -> ImagefiltermedianView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianView::len(self : ImagefiltermedianView) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianView::get(
  self : ImagefiltermedianView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianView::set(
  self : ImagefiltermedianView,
  i : Int32,
  v : Double,
) -> ImagefiltermedianView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianView::sum(self : ImagefiltermedianView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianView::mean(self : ImagefiltermedianView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianView::scale(
  self : ImagefiltermedianView,
  f : Double,
) -> ImagefiltermedianView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianView::add(
  self : ImagefiltermedianView,
  other : ImagefiltermedianView,
) -> ImagefiltermedianView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianView::copy(
  self : ImagefiltermedianView,
) -> ImagefiltermedianView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianView::fill(
  self : ImagefiltermedianView,
  v : Double,
) -> ImagefiltermedianView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianView::min(self : ImagefiltermedianView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianView::max(self : ImagefiltermedianView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianView::to_string(self : ImagefiltermedianView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_range_make(size : Int32) -> ImagefiltermedianRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianRange::len(self : ImagefiltermedianRange) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianRange::get(
  self : ImagefiltermedianRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianRange::set(
  self : ImagefiltermedianRange,
  i : Int32,
  v : Double,
) -> ImagefiltermedianRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianRange::sum(self : ImagefiltermedianRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianRange::mean(self : ImagefiltermedianRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianRange::scale(
  self : ImagefiltermedianRange,
  f : Double,
) -> ImagefiltermedianRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianRange::add(
  self : ImagefiltermedianRange,
  other : ImagefiltermedianRange,
) -> ImagefiltermedianRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianRange::copy(
  self : ImagefiltermedianRange,
) -> ImagefiltermedianRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianRange::fill(
  self : ImagefiltermedianRange,
  v : Double,
) -> ImagefiltermedianRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianRange::min(self : ImagefiltermedianRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianRange::max(self : ImagefiltermedianRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianRange::to_string(
  self : ImagefiltermedianRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefiltermedianSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_median_slice_make(size : Int32) -> ImagefiltermedianSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefiltermedianSlice::len(self : ImagefiltermedianSlice) -> Int32 {
  self.size
}

///|
pub fn ImagefiltermedianSlice::get(
  self : ImagefiltermedianSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefiltermedianSlice::set(
  self : ImagefiltermedianSlice,
  i : Int32,
  v : Double,
) -> ImagefiltermedianSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianSlice::sum(self : ImagefiltermedianSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefiltermedianSlice::mean(self : ImagefiltermedianSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefiltermedianSlice::scale(
  self : ImagefiltermedianSlice,
  f : Double,
) -> ImagefiltermedianSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianSlice::add(
  self : ImagefiltermedianSlice,
  other : ImagefiltermedianSlice,
) -> ImagefiltermedianSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefiltermedianSlice::copy(
  self : ImagefiltermedianSlice,
) -> ImagefiltermedianSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianSlice::fill(
  self : ImagefiltermedianSlice,
  v : Double,
) -> ImagefiltermedianSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefiltermedianSlice::min(self : ImagefiltermedianSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefiltermedianSlice::max(self : ImagefiltermedianSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefiltermedianSlice::to_string(
  self : ImagefiltermedianSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
