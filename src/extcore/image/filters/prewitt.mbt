///|
///===
/// extcore/image_filter_prewitt
pub(all) struct ImagefilterprewittPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn image_filter_prewitt_make_point(
  x : Double,
  y : Double,
) -> ImagefilterprewittPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn image_filter_prewitt_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ImagefilterprewittPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ImagefilterprewittPoint::x(self : ImagefilterprewittPoint) -> Double {
  self.x
}

///|
pub fn ImagefilterprewittPoint::y(self : ImagefilterprewittPoint) -> Double {
  self.y
}

///|
pub fn ImagefilterprewittPoint::z(self : ImagefilterprewittPoint) -> Double {
  self.z
}

///|
pub fn ImagefilterprewittPoint::label(self : ImagefilterprewittPoint) -> Int32 {
  self.label
}

///|
pub fn ImagefilterprewittPoint::dist(
  self : ImagefilterprewittPoint,
  other : ImagefilterprewittPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ImagefilterprewittPoint::add(
  self : ImagefilterprewittPoint,
  other : ImagefilterprewittPoint,
) -> ImagefilterprewittPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ImagefilterprewittPoint::sub(
  self : ImagefilterprewittPoint,
  other : ImagefilterprewittPoint,
) -> ImagefilterprewittPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ImagefilterprewittPoint::scale(
  self : ImagefilterprewittPoint,
  s : Double,
) -> ImagefilterprewittPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ImagefilterprewittPoint::dot(
  self : ImagefilterprewittPoint,
  other : ImagefilterprewittPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ImagefilterprewittPoint::cross(
  self : ImagefilterprewittPoint,
  other : ImagefilterprewittPoint,
) -> ImagefilterprewittPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ImagefilterprewittPoint::norm(self : ImagefilterprewittPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ImagefilterprewittPoint::normalize(
  self : ImagefilterprewittPoint,
) -> ImagefilterprewittPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefilterprewittPoint::negate(
  self : ImagefilterprewittPoint,
) -> ImagefilterprewittPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ImagefilterprewittPoint::mid(
  self : ImagefilterprewittPoint,
  other : ImagefilterprewittPoint,
) -> ImagefilterprewittPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ImagefilterprewittPoint::lerp(
  self : ImagefilterprewittPoint,
  other : ImagefilterprewittPoint,
  t : Double,
) -> ImagefilterprewittPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ImagefilterprewittPoint::to_string(
  self : ImagefilterprewittPoint,
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
pub(all) struct ImagefilterprewittSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn image_filter_prewitt_make_series(
  vals : Array[Double],
  name : String,
) -> ImagefilterprewittSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ImagefilterprewittSeries::len(self : ImagefilterprewittSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ImagefilterprewittSeries::sum(self : ImagefilterprewittSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ImagefilterprewittSeries::mean(
  self : ImagefilterprewittSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ImagefilterprewittSeries::min(self : ImagefilterprewittSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ImagefilterprewittSeries::max(self : ImagefilterprewittSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ImagefilterprewittSeries::range(
  self : ImagefilterprewittSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ImagefilterprewittSeries::variance(
  self : ImagefilterprewittSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ImagefilterprewittSeries::std(self : ImagefilterprewittSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ImagefilterprewittSeries::median(
  self : ImagefilterprewittSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ImagefilterprewittSeries::scale(
  self : ImagefilterprewittSeries,
  f : Double,
) -> ImagefilterprewittSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ImagefilterprewittSeries::add(
  self : ImagefilterprewittSeries,
  other : ImagefilterprewittSeries,
) -> ImagefilterprewittSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefilterprewittSeries::sub(
  self : ImagefilterprewittSeries,
  other : ImagefilterprewittSeries,
) -> ImagefilterprewittSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefilterprewittSeries::normalize(
  self : ImagefilterprewittSeries,
) -> ImagefilterprewittSeries {
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
pub fn ImagefilterprewittSeries::cumsum(
  self : ImagefilterprewittSeries,
) -> ImagefilterprewittSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ImagefilterprewittSeries::to_string(
  self : ImagefilterprewittSeries,
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
pub(all) struct ImagefilterprewittMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn image_filter_prewitt_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ImagefilterprewittMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn image_filter_prewitt_matrix_identity(
  n : Int32,
) -> ImagefilterprewittMatrix {
  let m = image_filter_prewitt_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ImagefilterprewittMatrix::get(
  self : ImagefilterprewittMatrix,
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
pub fn ImagefilterprewittMatrix::transpose(
  self : ImagefilterprewittMatrix,
) -> ImagefilterprewittMatrix {
  let result = image_filter_prewitt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefilterprewittMatrix::add(
  self : ImagefilterprewittMatrix,
  other : ImagefilterprewittMatrix,
) -> ImagefilterprewittMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = image_filter_prewitt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefilterprewittMatrix::scale(
  self : ImagefilterprewittMatrix,
  s : Double,
) -> ImagefilterprewittMatrix {
  let result = image_filter_prewitt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ImagefilterprewittMatrix::multiply(
  self : ImagefilterprewittMatrix,
  other : ImagefilterprewittMatrix,
) -> ImagefilterprewittMatrix {
  if self.cols != other.rows {
    return image_filter_prewitt_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = image_filter_prewitt_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ImagefilterprewittMatrix::trace(
  self : ImagefilterprewittMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ImagefilterprewittMatrix::det(self : ImagefilterprewittMatrix) -> Double {
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
pub fn ImagefilterprewittMatrix::norm(
  self : ImagefilterprewittMatrix,
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
pub fn ImagefilterprewittMatrix::to_string(
  self : ImagefilterprewittMatrix,
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
pub(all) struct ImagefilterprewittVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn image_filter_prewitt_make_vector(
  comps : Array[Double],
) -> ImagefilterprewittVector {
  { comps, dim: comps.length(), }
}

///|
pub fn image_filter_prewitt_vector_zero(
  dim : Int32,
) -> ImagefilterprewittVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ImagefilterprewittVector::add(
  self : ImagefilterprewittVector,
  other : ImagefilterprewittVector,
) -> ImagefilterprewittVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefilterprewittVector::sub(
  self : ImagefilterprewittVector,
  other : ImagefilterprewittVector,
) -> ImagefilterprewittVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefilterprewittVector::scale(
  self : ImagefilterprewittVector,
  s : Double,
) -> ImagefilterprewittVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ImagefilterprewittVector::dot(
  self : ImagefilterprewittVector,
  other : ImagefilterprewittVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ImagefilterprewittVector::norm(
  self : ImagefilterprewittVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ImagefilterprewittVector::normalize(
  self : ImagefilterprewittVector,
) -> ImagefilterprewittVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefilterprewittVector::dist(
  self : ImagefilterprewittVector,
  other : ImagefilterprewittVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ImagefilterprewittVector::to_string(
  self : ImagefilterprewittVector,
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
pub(all) struct ImagefilterprewittFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_frame_make(size : Int32) -> ImagefilterprewittFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittFrame::len(self : ImagefilterprewittFrame) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittFrame::get(
  self : ImagefilterprewittFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittFrame::set(
  self : ImagefilterprewittFrame,
  i : Int32,
  v : Double,
) -> ImagefilterprewittFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittFrame::sum(self : ImagefilterprewittFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittFrame::mean(self : ImagefilterprewittFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittFrame::scale(
  self : ImagefilterprewittFrame,
  f : Double,
) -> ImagefilterprewittFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittFrame::add(
  self : ImagefilterprewittFrame,
  other : ImagefilterprewittFrame,
) -> ImagefilterprewittFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittFrame::copy(
  self : ImagefilterprewittFrame,
) -> ImagefilterprewittFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittFrame::fill(
  self : ImagefilterprewittFrame,
  v : Double,
) -> ImagefilterprewittFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittFrame::min(self : ImagefilterprewittFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittFrame::max(self : ImagefilterprewittFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittFrame::to_string(
  self : ImagefilterprewittFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_table_make(size : Int32) -> ImagefilterprewittTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittTable::len(self : ImagefilterprewittTable) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittTable::get(
  self : ImagefilterprewittTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittTable::set(
  self : ImagefilterprewittTable,
  i : Int32,
  v : Double,
) -> ImagefilterprewittTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittTable::sum(self : ImagefilterprewittTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittTable::mean(self : ImagefilterprewittTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittTable::scale(
  self : ImagefilterprewittTable,
  f : Double,
) -> ImagefilterprewittTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittTable::add(
  self : ImagefilterprewittTable,
  other : ImagefilterprewittTable,
) -> ImagefilterprewittTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittTable::copy(
  self : ImagefilterprewittTable,
) -> ImagefilterprewittTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittTable::fill(
  self : ImagefilterprewittTable,
  v : Double,
) -> ImagefilterprewittTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittTable::min(self : ImagefilterprewittTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittTable::max(self : ImagefilterprewittTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittTable::to_string(
  self : ImagefilterprewittTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_graphn_make(
  size : Int32,
) -> ImagefilterprewittGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittGraphN::len(self : ImagefilterprewittGraphN) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittGraphN::get(
  self : ImagefilterprewittGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittGraphN::set(
  self : ImagefilterprewittGraphN,
  i : Int32,
  v : Double,
) -> ImagefilterprewittGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittGraphN::sum(self : ImagefilterprewittGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittGraphN::mean(
  self : ImagefilterprewittGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittGraphN::scale(
  self : ImagefilterprewittGraphN,
  f : Double,
) -> ImagefilterprewittGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittGraphN::add(
  self : ImagefilterprewittGraphN,
  other : ImagefilterprewittGraphN,
) -> ImagefilterprewittGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittGraphN::copy(
  self : ImagefilterprewittGraphN,
) -> ImagefilterprewittGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittGraphN::fill(
  self : ImagefilterprewittGraphN,
  v : Double,
) -> ImagefilterprewittGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittGraphN::min(self : ImagefilterprewittGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittGraphN::max(self : ImagefilterprewittGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittGraphN::to_string(
  self : ImagefilterprewittGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_node_make(size : Int32) -> ImagefilterprewittNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittNode::len(self : ImagefilterprewittNode) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittNode::get(
  self : ImagefilterprewittNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittNode::set(
  self : ImagefilterprewittNode,
  i : Int32,
  v : Double,
) -> ImagefilterprewittNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittNode::sum(self : ImagefilterprewittNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittNode::mean(self : ImagefilterprewittNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittNode::scale(
  self : ImagefilterprewittNode,
  f : Double,
) -> ImagefilterprewittNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittNode::add(
  self : ImagefilterprewittNode,
  other : ImagefilterprewittNode,
) -> ImagefilterprewittNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittNode::copy(
  self : ImagefilterprewittNode,
) -> ImagefilterprewittNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittNode::fill(
  self : ImagefilterprewittNode,
  v : Double,
) -> ImagefilterprewittNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittNode::min(self : ImagefilterprewittNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittNode::max(self : ImagefilterprewittNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittNode::to_string(
  self : ImagefilterprewittNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_edge_make(size : Int32) -> ImagefilterprewittEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittEdge::len(self : ImagefilterprewittEdge) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittEdge::get(
  self : ImagefilterprewittEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittEdge::set(
  self : ImagefilterprewittEdge,
  i : Int32,
  v : Double,
) -> ImagefilterprewittEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittEdge::sum(self : ImagefilterprewittEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittEdge::mean(self : ImagefilterprewittEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittEdge::scale(
  self : ImagefilterprewittEdge,
  f : Double,
) -> ImagefilterprewittEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittEdge::add(
  self : ImagefilterprewittEdge,
  other : ImagefilterprewittEdge,
) -> ImagefilterprewittEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittEdge::copy(
  self : ImagefilterprewittEdge,
) -> ImagefilterprewittEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittEdge::fill(
  self : ImagefilterprewittEdge,
  v : Double,
) -> ImagefilterprewittEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittEdge::min(self : ImagefilterprewittEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittEdge::max(self : ImagefilterprewittEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittEdge::to_string(
  self : ImagefilterprewittEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_path_make(size : Int32) -> ImagefilterprewittPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittPath::len(self : ImagefilterprewittPath) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittPath::get(
  self : ImagefilterprewittPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittPath::set(
  self : ImagefilterprewittPath,
  i : Int32,
  v : Double,
) -> ImagefilterprewittPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittPath::sum(self : ImagefilterprewittPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittPath::mean(self : ImagefilterprewittPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittPath::scale(
  self : ImagefilterprewittPath,
  f : Double,
) -> ImagefilterprewittPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittPath::add(
  self : ImagefilterprewittPath,
  other : ImagefilterprewittPath,
) -> ImagefilterprewittPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittPath::copy(
  self : ImagefilterprewittPath,
) -> ImagefilterprewittPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittPath::fill(
  self : ImagefilterprewittPath,
  v : Double,
) -> ImagefilterprewittPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittPath::min(self : ImagefilterprewittPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittPath::max(self : ImagefilterprewittPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittPath::to_string(
  self : ImagefilterprewittPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_cluster_make(
  size : Int32,
) -> ImagefilterprewittCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittCluster::len(
  self : ImagefilterprewittCluster,
) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittCluster::get(
  self : ImagefilterprewittCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittCluster::set(
  self : ImagefilterprewittCluster,
  i : Int32,
  v : Double,
) -> ImagefilterprewittCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittCluster::sum(
  self : ImagefilterprewittCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittCluster::mean(
  self : ImagefilterprewittCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittCluster::scale(
  self : ImagefilterprewittCluster,
  f : Double,
) -> ImagefilterprewittCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittCluster::add(
  self : ImagefilterprewittCluster,
  other : ImagefilterprewittCluster,
) -> ImagefilterprewittCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittCluster::copy(
  self : ImagefilterprewittCluster,
) -> ImagefilterprewittCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittCluster::fill(
  self : ImagefilterprewittCluster,
  v : Double,
) -> ImagefilterprewittCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittCluster::min(
  self : ImagefilterprewittCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittCluster::max(
  self : ImagefilterprewittCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittCluster::to_string(
  self : ImagefilterprewittCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_model_make(size : Int32) -> ImagefilterprewittModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittModel::len(self : ImagefilterprewittModel) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittModel::get(
  self : ImagefilterprewittModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittModel::set(
  self : ImagefilterprewittModel,
  i : Int32,
  v : Double,
) -> ImagefilterprewittModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittModel::sum(self : ImagefilterprewittModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittModel::mean(self : ImagefilterprewittModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittModel::scale(
  self : ImagefilterprewittModel,
  f : Double,
) -> ImagefilterprewittModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittModel::add(
  self : ImagefilterprewittModel,
  other : ImagefilterprewittModel,
) -> ImagefilterprewittModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittModel::copy(
  self : ImagefilterprewittModel,
) -> ImagefilterprewittModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittModel::fill(
  self : ImagefilterprewittModel,
  v : Double,
) -> ImagefilterprewittModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittModel::min(self : ImagefilterprewittModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittModel::max(self : ImagefilterprewittModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittModel::to_string(
  self : ImagefilterprewittModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_layer_make(size : Int32) -> ImagefilterprewittLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittLayer::len(self : ImagefilterprewittLayer) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittLayer::get(
  self : ImagefilterprewittLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittLayer::set(
  self : ImagefilterprewittLayer,
  i : Int32,
  v : Double,
) -> ImagefilterprewittLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittLayer::sum(self : ImagefilterprewittLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittLayer::mean(self : ImagefilterprewittLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittLayer::scale(
  self : ImagefilterprewittLayer,
  f : Double,
) -> ImagefilterprewittLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittLayer::add(
  self : ImagefilterprewittLayer,
  other : ImagefilterprewittLayer,
) -> ImagefilterprewittLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittLayer::copy(
  self : ImagefilterprewittLayer,
) -> ImagefilterprewittLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittLayer::fill(
  self : ImagefilterprewittLayer,
  v : Double,
) -> ImagefilterprewittLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittLayer::min(self : ImagefilterprewittLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittLayer::max(self : ImagefilterprewittLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittLayer::to_string(
  self : ImagefilterprewittLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_buffer_make(
  size : Int32,
) -> ImagefilterprewittBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittBuffer::len(self : ImagefilterprewittBuffer) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittBuffer::get(
  self : ImagefilterprewittBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittBuffer::set(
  self : ImagefilterprewittBuffer,
  i : Int32,
  v : Double,
) -> ImagefilterprewittBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittBuffer::sum(self : ImagefilterprewittBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittBuffer::mean(
  self : ImagefilterprewittBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittBuffer::scale(
  self : ImagefilterprewittBuffer,
  f : Double,
) -> ImagefilterprewittBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittBuffer::add(
  self : ImagefilterprewittBuffer,
  other : ImagefilterprewittBuffer,
) -> ImagefilterprewittBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittBuffer::copy(
  self : ImagefilterprewittBuffer,
) -> ImagefilterprewittBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittBuffer::fill(
  self : ImagefilterprewittBuffer,
  v : Double,
) -> ImagefilterprewittBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittBuffer::min(self : ImagefilterprewittBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittBuffer::max(self : ImagefilterprewittBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittBuffer::to_string(
  self : ImagefilterprewittBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_cursor_make(
  size : Int32,
) -> ImagefilterprewittCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittCursor::len(self : ImagefilterprewittCursor) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittCursor::get(
  self : ImagefilterprewittCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittCursor::set(
  self : ImagefilterprewittCursor,
  i : Int32,
  v : Double,
) -> ImagefilterprewittCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittCursor::sum(self : ImagefilterprewittCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittCursor::mean(
  self : ImagefilterprewittCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittCursor::scale(
  self : ImagefilterprewittCursor,
  f : Double,
) -> ImagefilterprewittCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittCursor::add(
  self : ImagefilterprewittCursor,
  other : ImagefilterprewittCursor,
) -> ImagefilterprewittCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittCursor::copy(
  self : ImagefilterprewittCursor,
) -> ImagefilterprewittCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittCursor::fill(
  self : ImagefilterprewittCursor,
  v : Double,
) -> ImagefilterprewittCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittCursor::min(self : ImagefilterprewittCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittCursor::max(self : ImagefilterprewittCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittCursor::to_string(
  self : ImagefilterprewittCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_view_make(size : Int32) -> ImagefilterprewittView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittView::len(self : ImagefilterprewittView) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittView::get(
  self : ImagefilterprewittView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittView::set(
  self : ImagefilterprewittView,
  i : Int32,
  v : Double,
) -> ImagefilterprewittView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittView::sum(self : ImagefilterprewittView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittView::mean(self : ImagefilterprewittView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittView::scale(
  self : ImagefilterprewittView,
  f : Double,
) -> ImagefilterprewittView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittView::add(
  self : ImagefilterprewittView,
  other : ImagefilterprewittView,
) -> ImagefilterprewittView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittView::copy(
  self : ImagefilterprewittView,
) -> ImagefilterprewittView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittView::fill(
  self : ImagefilterprewittView,
  v : Double,
) -> ImagefilterprewittView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittView::min(self : ImagefilterprewittView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittView::max(self : ImagefilterprewittView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittView::to_string(
  self : ImagefilterprewittView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_range_make(size : Int32) -> ImagefilterprewittRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittRange::len(self : ImagefilterprewittRange) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittRange::get(
  self : ImagefilterprewittRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittRange::set(
  self : ImagefilterprewittRange,
  i : Int32,
  v : Double,
) -> ImagefilterprewittRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittRange::sum(self : ImagefilterprewittRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittRange::mean(self : ImagefilterprewittRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittRange::scale(
  self : ImagefilterprewittRange,
  f : Double,
) -> ImagefilterprewittRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittRange::add(
  self : ImagefilterprewittRange,
  other : ImagefilterprewittRange,
) -> ImagefilterprewittRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittRange::copy(
  self : ImagefilterprewittRange,
) -> ImagefilterprewittRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittRange::fill(
  self : ImagefilterprewittRange,
  v : Double,
) -> ImagefilterprewittRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittRange::min(self : ImagefilterprewittRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittRange::max(self : ImagefilterprewittRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittRange::to_string(
  self : ImagefilterprewittRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefilterprewittSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_filter_prewitt_slice_make(size : Int32) -> ImagefilterprewittSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefilterprewittSlice::len(self : ImagefilterprewittSlice) -> Int32 {
  self.size
}

///|
pub fn ImagefilterprewittSlice::get(
  self : ImagefilterprewittSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefilterprewittSlice::set(
  self : ImagefilterprewittSlice,
  i : Int32,
  v : Double,
) -> ImagefilterprewittSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittSlice::sum(self : ImagefilterprewittSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefilterprewittSlice::mean(self : ImagefilterprewittSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefilterprewittSlice::scale(
  self : ImagefilterprewittSlice,
  f : Double,
) -> ImagefilterprewittSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittSlice::add(
  self : ImagefilterprewittSlice,
  other : ImagefilterprewittSlice,
) -> ImagefilterprewittSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefilterprewittSlice::copy(
  self : ImagefilterprewittSlice,
) -> ImagefilterprewittSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittSlice::fill(
  self : ImagefilterprewittSlice,
  v : Double,
) -> ImagefilterprewittSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefilterprewittSlice::min(self : ImagefilterprewittSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefilterprewittSlice::max(self : ImagefilterprewittSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefilterprewittSlice::to_string(
  self : ImagefilterprewittSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
