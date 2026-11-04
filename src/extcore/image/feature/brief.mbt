///|
///===
/// extcore/image_feature_brief
pub(all) struct ImagefeaturebriefPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn image_feature_brief_make_point(
  x : Double,
  y : Double,
) -> ImagefeaturebriefPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn image_feature_brief_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ImagefeaturebriefPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ImagefeaturebriefPoint::x(self : ImagefeaturebriefPoint) -> Double {
  self.x
}

///|
pub fn ImagefeaturebriefPoint::y(self : ImagefeaturebriefPoint) -> Double {
  self.y
}

///|
pub fn ImagefeaturebriefPoint::z(self : ImagefeaturebriefPoint) -> Double {
  self.z
}

///|
pub fn ImagefeaturebriefPoint::label(self : ImagefeaturebriefPoint) -> Int32 {
  self.label
}

///|
pub fn ImagefeaturebriefPoint::dist(
  self : ImagefeaturebriefPoint,
  other : ImagefeaturebriefPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ImagefeaturebriefPoint::add(
  self : ImagefeaturebriefPoint,
  other : ImagefeaturebriefPoint,
) -> ImagefeaturebriefPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ImagefeaturebriefPoint::sub(
  self : ImagefeaturebriefPoint,
  other : ImagefeaturebriefPoint,
) -> ImagefeaturebriefPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ImagefeaturebriefPoint::scale(
  self : ImagefeaturebriefPoint,
  s : Double,
) -> ImagefeaturebriefPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ImagefeaturebriefPoint::dot(
  self : ImagefeaturebriefPoint,
  other : ImagefeaturebriefPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ImagefeaturebriefPoint::cross(
  self : ImagefeaturebriefPoint,
  other : ImagefeaturebriefPoint,
) -> ImagefeaturebriefPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ImagefeaturebriefPoint::norm(self : ImagefeaturebriefPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ImagefeaturebriefPoint::normalize(
  self : ImagefeaturebriefPoint,
) -> ImagefeaturebriefPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefeaturebriefPoint::negate(
  self : ImagefeaturebriefPoint,
) -> ImagefeaturebriefPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ImagefeaturebriefPoint::mid(
  self : ImagefeaturebriefPoint,
  other : ImagefeaturebriefPoint,
) -> ImagefeaturebriefPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ImagefeaturebriefPoint::lerp(
  self : ImagefeaturebriefPoint,
  other : ImagefeaturebriefPoint,
  t : Double,
) -> ImagefeaturebriefPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ImagefeaturebriefPoint::to_string(
  self : ImagefeaturebriefPoint,
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
pub(all) struct ImagefeaturebriefSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn image_feature_brief_make_series(
  vals : Array[Double],
  name : String,
) -> ImagefeaturebriefSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ImagefeaturebriefSeries::len(self : ImagefeaturebriefSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ImagefeaturebriefSeries::sum(self : ImagefeaturebriefSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ImagefeaturebriefSeries::mean(self : ImagefeaturebriefSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ImagefeaturebriefSeries::min(self : ImagefeaturebriefSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ImagefeaturebriefSeries::max(self : ImagefeaturebriefSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ImagefeaturebriefSeries::range(self : ImagefeaturebriefSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ImagefeaturebriefSeries::variance(
  self : ImagefeaturebriefSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ImagefeaturebriefSeries::std(self : ImagefeaturebriefSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ImagefeaturebriefSeries::median(
  self : ImagefeaturebriefSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ImagefeaturebriefSeries::scale(
  self : ImagefeaturebriefSeries,
  f : Double,
) -> ImagefeaturebriefSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ImagefeaturebriefSeries::add(
  self : ImagefeaturebriefSeries,
  other : ImagefeaturebriefSeries,
) -> ImagefeaturebriefSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefeaturebriefSeries::sub(
  self : ImagefeaturebriefSeries,
  other : ImagefeaturebriefSeries,
) -> ImagefeaturebriefSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefeaturebriefSeries::normalize(
  self : ImagefeaturebriefSeries,
) -> ImagefeaturebriefSeries {
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
pub fn ImagefeaturebriefSeries::cumsum(
  self : ImagefeaturebriefSeries,
) -> ImagefeaturebriefSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ImagefeaturebriefSeries::to_string(
  self : ImagefeaturebriefSeries,
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
pub(all) struct ImagefeaturebriefMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn image_feature_brief_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ImagefeaturebriefMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn image_feature_brief_matrix_identity(
  n : Int32,
) -> ImagefeaturebriefMatrix {
  let m = image_feature_brief_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ImagefeaturebriefMatrix::get(
  self : ImagefeaturebriefMatrix,
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
pub fn ImagefeaturebriefMatrix::transpose(
  self : ImagefeaturebriefMatrix,
) -> ImagefeaturebriefMatrix {
  let result = image_feature_brief_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefeaturebriefMatrix::add(
  self : ImagefeaturebriefMatrix,
  other : ImagefeaturebriefMatrix,
) -> ImagefeaturebriefMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = image_feature_brief_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefeaturebriefMatrix::scale(
  self : ImagefeaturebriefMatrix,
  s : Double,
) -> ImagefeaturebriefMatrix {
  let result = image_feature_brief_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ImagefeaturebriefMatrix::multiply(
  self : ImagefeaturebriefMatrix,
  other : ImagefeaturebriefMatrix,
) -> ImagefeaturebriefMatrix {
  if self.cols != other.rows {
    return image_feature_brief_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = image_feature_brief_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ImagefeaturebriefMatrix::trace(self : ImagefeaturebriefMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ImagefeaturebriefMatrix::det(self : ImagefeaturebriefMatrix) -> Double {
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
pub fn ImagefeaturebriefMatrix::norm(self : ImagefeaturebriefMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ImagefeaturebriefMatrix::to_string(
  self : ImagefeaturebriefMatrix,
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
pub(all) struct ImagefeaturebriefVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn image_feature_brief_make_vector(
  comps : Array[Double],
) -> ImagefeaturebriefVector {
  { comps, dim: comps.length(), }
}

///|
pub fn image_feature_brief_vector_zero(dim : Int32) -> ImagefeaturebriefVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ImagefeaturebriefVector::add(
  self : ImagefeaturebriefVector,
  other : ImagefeaturebriefVector,
) -> ImagefeaturebriefVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefeaturebriefVector::sub(
  self : ImagefeaturebriefVector,
  other : ImagefeaturebriefVector,
) -> ImagefeaturebriefVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefeaturebriefVector::scale(
  self : ImagefeaturebriefVector,
  s : Double,
) -> ImagefeaturebriefVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ImagefeaturebriefVector::dot(
  self : ImagefeaturebriefVector,
  other : ImagefeaturebriefVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ImagefeaturebriefVector::norm(self : ImagefeaturebriefVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ImagefeaturebriefVector::normalize(
  self : ImagefeaturebriefVector,
) -> ImagefeaturebriefVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefeaturebriefVector::dist(
  self : ImagefeaturebriefVector,
  other : ImagefeaturebriefVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ImagefeaturebriefVector::to_string(
  self : ImagefeaturebriefVector,
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
pub(all) struct ImagefeaturebriefFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_frame_make(size : Int32) -> ImagefeaturebriefFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefFrame::len(self : ImagefeaturebriefFrame) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefFrame::get(
  self : ImagefeaturebriefFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefFrame::set(
  self : ImagefeaturebriefFrame,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefFrame::sum(self : ImagefeaturebriefFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefFrame::mean(self : ImagefeaturebriefFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefFrame::scale(
  self : ImagefeaturebriefFrame,
  f : Double,
) -> ImagefeaturebriefFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefFrame::add(
  self : ImagefeaturebriefFrame,
  other : ImagefeaturebriefFrame,
) -> ImagefeaturebriefFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefFrame::copy(
  self : ImagefeaturebriefFrame,
) -> ImagefeaturebriefFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefFrame::fill(
  self : ImagefeaturebriefFrame,
  v : Double,
) -> ImagefeaturebriefFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefFrame::min(self : ImagefeaturebriefFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefFrame::max(self : ImagefeaturebriefFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefFrame::to_string(
  self : ImagefeaturebriefFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_table_make(size : Int32) -> ImagefeaturebriefTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefTable::len(self : ImagefeaturebriefTable) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefTable::get(
  self : ImagefeaturebriefTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefTable::set(
  self : ImagefeaturebriefTable,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefTable::sum(self : ImagefeaturebriefTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefTable::mean(self : ImagefeaturebriefTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefTable::scale(
  self : ImagefeaturebriefTable,
  f : Double,
) -> ImagefeaturebriefTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefTable::add(
  self : ImagefeaturebriefTable,
  other : ImagefeaturebriefTable,
) -> ImagefeaturebriefTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefTable::copy(
  self : ImagefeaturebriefTable,
) -> ImagefeaturebriefTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefTable::fill(
  self : ImagefeaturebriefTable,
  v : Double,
) -> ImagefeaturebriefTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefTable::min(self : ImagefeaturebriefTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefTable::max(self : ImagefeaturebriefTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefTable::to_string(
  self : ImagefeaturebriefTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_graphn_make(size : Int32) -> ImagefeaturebriefGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefGraphN::len(self : ImagefeaturebriefGraphN) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefGraphN::get(
  self : ImagefeaturebriefGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefGraphN::set(
  self : ImagefeaturebriefGraphN,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefGraphN::sum(self : ImagefeaturebriefGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefGraphN::mean(self : ImagefeaturebriefGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefGraphN::scale(
  self : ImagefeaturebriefGraphN,
  f : Double,
) -> ImagefeaturebriefGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefGraphN::add(
  self : ImagefeaturebriefGraphN,
  other : ImagefeaturebriefGraphN,
) -> ImagefeaturebriefGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefGraphN::copy(
  self : ImagefeaturebriefGraphN,
) -> ImagefeaturebriefGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefGraphN::fill(
  self : ImagefeaturebriefGraphN,
  v : Double,
) -> ImagefeaturebriefGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefGraphN::min(self : ImagefeaturebriefGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefGraphN::max(self : ImagefeaturebriefGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefGraphN::to_string(
  self : ImagefeaturebriefGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_node_make(size : Int32) -> ImagefeaturebriefNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefNode::len(self : ImagefeaturebriefNode) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefNode::get(
  self : ImagefeaturebriefNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefNode::set(
  self : ImagefeaturebriefNode,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefNode::sum(self : ImagefeaturebriefNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefNode::mean(self : ImagefeaturebriefNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefNode::scale(
  self : ImagefeaturebriefNode,
  f : Double,
) -> ImagefeaturebriefNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefNode::add(
  self : ImagefeaturebriefNode,
  other : ImagefeaturebriefNode,
) -> ImagefeaturebriefNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefNode::copy(
  self : ImagefeaturebriefNode,
) -> ImagefeaturebriefNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefNode::fill(
  self : ImagefeaturebriefNode,
  v : Double,
) -> ImagefeaturebriefNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefNode::min(self : ImagefeaturebriefNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefNode::max(self : ImagefeaturebriefNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefNode::to_string(self : ImagefeaturebriefNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_edge_make(size : Int32) -> ImagefeaturebriefEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefEdge::len(self : ImagefeaturebriefEdge) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefEdge::get(
  self : ImagefeaturebriefEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefEdge::set(
  self : ImagefeaturebriefEdge,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefEdge::sum(self : ImagefeaturebriefEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefEdge::mean(self : ImagefeaturebriefEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefEdge::scale(
  self : ImagefeaturebriefEdge,
  f : Double,
) -> ImagefeaturebriefEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefEdge::add(
  self : ImagefeaturebriefEdge,
  other : ImagefeaturebriefEdge,
) -> ImagefeaturebriefEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefEdge::copy(
  self : ImagefeaturebriefEdge,
) -> ImagefeaturebriefEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefEdge::fill(
  self : ImagefeaturebriefEdge,
  v : Double,
) -> ImagefeaturebriefEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefEdge::min(self : ImagefeaturebriefEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefEdge::max(self : ImagefeaturebriefEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefEdge::to_string(self : ImagefeaturebriefEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_path_make(size : Int32) -> ImagefeaturebriefPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefPath::len(self : ImagefeaturebriefPath) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefPath::get(
  self : ImagefeaturebriefPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefPath::set(
  self : ImagefeaturebriefPath,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefPath::sum(self : ImagefeaturebriefPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefPath::mean(self : ImagefeaturebriefPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefPath::scale(
  self : ImagefeaturebriefPath,
  f : Double,
) -> ImagefeaturebriefPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefPath::add(
  self : ImagefeaturebriefPath,
  other : ImagefeaturebriefPath,
) -> ImagefeaturebriefPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefPath::copy(
  self : ImagefeaturebriefPath,
) -> ImagefeaturebriefPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefPath::fill(
  self : ImagefeaturebriefPath,
  v : Double,
) -> ImagefeaturebriefPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefPath::min(self : ImagefeaturebriefPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefPath::max(self : ImagefeaturebriefPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefPath::to_string(self : ImagefeaturebriefPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_cluster_make(
  size : Int32,
) -> ImagefeaturebriefCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefCluster::len(self : ImagefeaturebriefCluster) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefCluster::get(
  self : ImagefeaturebriefCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefCluster::set(
  self : ImagefeaturebriefCluster,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefCluster::sum(self : ImagefeaturebriefCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefCluster::mean(
  self : ImagefeaturebriefCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefCluster::scale(
  self : ImagefeaturebriefCluster,
  f : Double,
) -> ImagefeaturebriefCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefCluster::add(
  self : ImagefeaturebriefCluster,
  other : ImagefeaturebriefCluster,
) -> ImagefeaturebriefCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefCluster::copy(
  self : ImagefeaturebriefCluster,
) -> ImagefeaturebriefCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefCluster::fill(
  self : ImagefeaturebriefCluster,
  v : Double,
) -> ImagefeaturebriefCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefCluster::min(self : ImagefeaturebriefCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefCluster::max(self : ImagefeaturebriefCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefCluster::to_string(
  self : ImagefeaturebriefCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_model_make(size : Int32) -> ImagefeaturebriefModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefModel::len(self : ImagefeaturebriefModel) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefModel::get(
  self : ImagefeaturebriefModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefModel::set(
  self : ImagefeaturebriefModel,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefModel::sum(self : ImagefeaturebriefModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefModel::mean(self : ImagefeaturebriefModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefModel::scale(
  self : ImagefeaturebriefModel,
  f : Double,
) -> ImagefeaturebriefModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefModel::add(
  self : ImagefeaturebriefModel,
  other : ImagefeaturebriefModel,
) -> ImagefeaturebriefModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefModel::copy(
  self : ImagefeaturebriefModel,
) -> ImagefeaturebriefModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefModel::fill(
  self : ImagefeaturebriefModel,
  v : Double,
) -> ImagefeaturebriefModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefModel::min(self : ImagefeaturebriefModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefModel::max(self : ImagefeaturebriefModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefModel::to_string(
  self : ImagefeaturebriefModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_layer_make(size : Int32) -> ImagefeaturebriefLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefLayer::len(self : ImagefeaturebriefLayer) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefLayer::get(
  self : ImagefeaturebriefLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefLayer::set(
  self : ImagefeaturebriefLayer,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefLayer::sum(self : ImagefeaturebriefLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefLayer::mean(self : ImagefeaturebriefLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefLayer::scale(
  self : ImagefeaturebriefLayer,
  f : Double,
) -> ImagefeaturebriefLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefLayer::add(
  self : ImagefeaturebriefLayer,
  other : ImagefeaturebriefLayer,
) -> ImagefeaturebriefLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefLayer::copy(
  self : ImagefeaturebriefLayer,
) -> ImagefeaturebriefLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefLayer::fill(
  self : ImagefeaturebriefLayer,
  v : Double,
) -> ImagefeaturebriefLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefLayer::min(self : ImagefeaturebriefLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefLayer::max(self : ImagefeaturebriefLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefLayer::to_string(
  self : ImagefeaturebriefLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_buffer_make(size : Int32) -> ImagefeaturebriefBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefBuffer::len(self : ImagefeaturebriefBuffer) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefBuffer::get(
  self : ImagefeaturebriefBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefBuffer::set(
  self : ImagefeaturebriefBuffer,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefBuffer::sum(self : ImagefeaturebriefBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefBuffer::mean(self : ImagefeaturebriefBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefBuffer::scale(
  self : ImagefeaturebriefBuffer,
  f : Double,
) -> ImagefeaturebriefBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefBuffer::add(
  self : ImagefeaturebriefBuffer,
  other : ImagefeaturebriefBuffer,
) -> ImagefeaturebriefBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefBuffer::copy(
  self : ImagefeaturebriefBuffer,
) -> ImagefeaturebriefBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefBuffer::fill(
  self : ImagefeaturebriefBuffer,
  v : Double,
) -> ImagefeaturebriefBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefBuffer::min(self : ImagefeaturebriefBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefBuffer::max(self : ImagefeaturebriefBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefBuffer::to_string(
  self : ImagefeaturebriefBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_cursor_make(size : Int32) -> ImagefeaturebriefCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefCursor::len(self : ImagefeaturebriefCursor) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefCursor::get(
  self : ImagefeaturebriefCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefCursor::set(
  self : ImagefeaturebriefCursor,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefCursor::sum(self : ImagefeaturebriefCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefCursor::mean(self : ImagefeaturebriefCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefCursor::scale(
  self : ImagefeaturebriefCursor,
  f : Double,
) -> ImagefeaturebriefCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefCursor::add(
  self : ImagefeaturebriefCursor,
  other : ImagefeaturebriefCursor,
) -> ImagefeaturebriefCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefCursor::copy(
  self : ImagefeaturebriefCursor,
) -> ImagefeaturebriefCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefCursor::fill(
  self : ImagefeaturebriefCursor,
  v : Double,
) -> ImagefeaturebriefCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefCursor::min(self : ImagefeaturebriefCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefCursor::max(self : ImagefeaturebriefCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefCursor::to_string(
  self : ImagefeaturebriefCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_view_make(size : Int32) -> ImagefeaturebriefView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefView::len(self : ImagefeaturebriefView) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefView::get(
  self : ImagefeaturebriefView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefView::set(
  self : ImagefeaturebriefView,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefView::sum(self : ImagefeaturebriefView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefView::mean(self : ImagefeaturebriefView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefView::scale(
  self : ImagefeaturebriefView,
  f : Double,
) -> ImagefeaturebriefView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefView::add(
  self : ImagefeaturebriefView,
  other : ImagefeaturebriefView,
) -> ImagefeaturebriefView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefView::copy(
  self : ImagefeaturebriefView,
) -> ImagefeaturebriefView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefView::fill(
  self : ImagefeaturebriefView,
  v : Double,
) -> ImagefeaturebriefView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefView::min(self : ImagefeaturebriefView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefView::max(self : ImagefeaturebriefView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefView::to_string(self : ImagefeaturebriefView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_range_make(size : Int32) -> ImagefeaturebriefRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefRange::len(self : ImagefeaturebriefRange) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefRange::get(
  self : ImagefeaturebriefRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefRange::set(
  self : ImagefeaturebriefRange,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefRange::sum(self : ImagefeaturebriefRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefRange::mean(self : ImagefeaturebriefRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefRange::scale(
  self : ImagefeaturebriefRange,
  f : Double,
) -> ImagefeaturebriefRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefRange::add(
  self : ImagefeaturebriefRange,
  other : ImagefeaturebriefRange,
) -> ImagefeaturebriefRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefRange::copy(
  self : ImagefeaturebriefRange,
) -> ImagefeaturebriefRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefRange::fill(
  self : ImagefeaturebriefRange,
  v : Double,
) -> ImagefeaturebriefRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefRange::min(self : ImagefeaturebriefRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefRange::max(self : ImagefeaturebriefRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefRange::to_string(
  self : ImagefeaturebriefRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeaturebriefSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_brief_slice_make(size : Int32) -> ImagefeaturebriefSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeaturebriefSlice::len(self : ImagefeaturebriefSlice) -> Int32 {
  self.size
}

///|
pub fn ImagefeaturebriefSlice::get(
  self : ImagefeaturebriefSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeaturebriefSlice::set(
  self : ImagefeaturebriefSlice,
  i : Int32,
  v : Double,
) -> ImagefeaturebriefSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefSlice::sum(self : ImagefeaturebriefSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeaturebriefSlice::mean(self : ImagefeaturebriefSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeaturebriefSlice::scale(
  self : ImagefeaturebriefSlice,
  f : Double,
) -> ImagefeaturebriefSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefSlice::add(
  self : ImagefeaturebriefSlice,
  other : ImagefeaturebriefSlice,
) -> ImagefeaturebriefSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefSlice::copy(
  self : ImagefeaturebriefSlice,
) -> ImagefeaturebriefSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefSlice::fill(
  self : ImagefeaturebriefSlice,
  v : Double,
) -> ImagefeaturebriefSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeaturebriefSlice::min(self : ImagefeaturebriefSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeaturebriefSlice::max(self : ImagefeaturebriefSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeaturebriefSlice::to_string(
  self : ImagefeaturebriefSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
