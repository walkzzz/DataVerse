///|
///===
/// extcore/image_feature_harris
pub(all) struct ImagefeatureharrisPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn image_feature_harris_make_point(
  x : Double,
  y : Double,
) -> ImagefeatureharrisPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn image_feature_harris_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ImagefeatureharrisPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ImagefeatureharrisPoint::x(self : ImagefeatureharrisPoint) -> Double {
  self.x
}

///|
pub fn ImagefeatureharrisPoint::y(self : ImagefeatureharrisPoint) -> Double {
  self.y
}

///|
pub fn ImagefeatureharrisPoint::z(self : ImagefeatureharrisPoint) -> Double {
  self.z
}

///|
pub fn ImagefeatureharrisPoint::label(self : ImagefeatureharrisPoint) -> Int32 {
  self.label
}

///|
pub fn ImagefeatureharrisPoint::dist(
  self : ImagefeatureharrisPoint,
  other : ImagefeatureharrisPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ImagefeatureharrisPoint::add(
  self : ImagefeatureharrisPoint,
  other : ImagefeatureharrisPoint,
) -> ImagefeatureharrisPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ImagefeatureharrisPoint::sub(
  self : ImagefeatureharrisPoint,
  other : ImagefeatureharrisPoint,
) -> ImagefeatureharrisPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ImagefeatureharrisPoint::scale(
  self : ImagefeatureharrisPoint,
  s : Double,
) -> ImagefeatureharrisPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ImagefeatureharrisPoint::dot(
  self : ImagefeatureharrisPoint,
  other : ImagefeatureharrisPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ImagefeatureharrisPoint::cross(
  self : ImagefeatureharrisPoint,
  other : ImagefeatureharrisPoint,
) -> ImagefeatureharrisPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ImagefeatureharrisPoint::norm(self : ImagefeatureharrisPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ImagefeatureharrisPoint::normalize(
  self : ImagefeatureharrisPoint,
) -> ImagefeatureharrisPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefeatureharrisPoint::negate(
  self : ImagefeatureharrisPoint,
) -> ImagefeatureharrisPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ImagefeatureharrisPoint::mid(
  self : ImagefeatureharrisPoint,
  other : ImagefeatureharrisPoint,
) -> ImagefeatureharrisPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ImagefeatureharrisPoint::lerp(
  self : ImagefeatureharrisPoint,
  other : ImagefeatureharrisPoint,
  t : Double,
) -> ImagefeatureharrisPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ImagefeatureharrisPoint::to_string(
  self : ImagefeatureharrisPoint,
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
pub(all) struct ImagefeatureharrisSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn image_feature_harris_make_series(
  vals : Array[Double],
  name : String,
) -> ImagefeatureharrisSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ImagefeatureharrisSeries::len(self : ImagefeatureharrisSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ImagefeatureharrisSeries::sum(self : ImagefeatureharrisSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ImagefeatureharrisSeries::mean(
  self : ImagefeatureharrisSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ImagefeatureharrisSeries::min(self : ImagefeatureharrisSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ImagefeatureharrisSeries::max(self : ImagefeatureharrisSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ImagefeatureharrisSeries::range(
  self : ImagefeatureharrisSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ImagefeatureharrisSeries::variance(
  self : ImagefeatureharrisSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ImagefeatureharrisSeries::std(self : ImagefeatureharrisSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ImagefeatureharrisSeries::median(
  self : ImagefeatureharrisSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ImagefeatureharrisSeries::scale(
  self : ImagefeatureharrisSeries,
  f : Double,
) -> ImagefeatureharrisSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ImagefeatureharrisSeries::add(
  self : ImagefeatureharrisSeries,
  other : ImagefeatureharrisSeries,
) -> ImagefeatureharrisSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefeatureharrisSeries::sub(
  self : ImagefeatureharrisSeries,
  other : ImagefeatureharrisSeries,
) -> ImagefeatureharrisSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagefeatureharrisSeries::normalize(
  self : ImagefeatureharrisSeries,
) -> ImagefeatureharrisSeries {
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
pub fn ImagefeatureharrisSeries::cumsum(
  self : ImagefeatureharrisSeries,
) -> ImagefeatureharrisSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ImagefeatureharrisSeries::to_string(
  self : ImagefeatureharrisSeries,
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
pub(all) struct ImagefeatureharrisMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn image_feature_harris_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ImagefeatureharrisMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn image_feature_harris_matrix_identity(
  n : Int32,
) -> ImagefeatureharrisMatrix {
  let m = image_feature_harris_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ImagefeatureharrisMatrix::get(
  self : ImagefeatureharrisMatrix,
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
pub fn ImagefeatureharrisMatrix::transpose(
  self : ImagefeatureharrisMatrix,
) -> ImagefeatureharrisMatrix {
  let result = image_feature_harris_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefeatureharrisMatrix::add(
  self : ImagefeatureharrisMatrix,
  other : ImagefeatureharrisMatrix,
) -> ImagefeatureharrisMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = image_feature_harris_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ImagefeatureharrisMatrix::scale(
  self : ImagefeatureharrisMatrix,
  s : Double,
) -> ImagefeatureharrisMatrix {
  let result = image_feature_harris_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ImagefeatureharrisMatrix::multiply(
  self : ImagefeatureharrisMatrix,
  other : ImagefeatureharrisMatrix,
) -> ImagefeatureharrisMatrix {
  if self.cols != other.rows {
    return image_feature_harris_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = image_feature_harris_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ImagefeatureharrisMatrix::trace(
  self : ImagefeatureharrisMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ImagefeatureharrisMatrix::det(self : ImagefeatureharrisMatrix) -> Double {
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
pub fn ImagefeatureharrisMatrix::norm(
  self : ImagefeatureharrisMatrix,
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
pub fn ImagefeatureharrisMatrix::to_string(
  self : ImagefeatureharrisMatrix,
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
pub(all) struct ImagefeatureharrisVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn image_feature_harris_make_vector(
  comps : Array[Double],
) -> ImagefeatureharrisVector {
  { comps, dim: comps.length(), }
}

///|
pub fn image_feature_harris_vector_zero(
  dim : Int32,
) -> ImagefeatureharrisVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ImagefeatureharrisVector::add(
  self : ImagefeatureharrisVector,
  other : ImagefeatureharrisVector,
) -> ImagefeatureharrisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefeatureharrisVector::sub(
  self : ImagefeatureharrisVector,
  other : ImagefeatureharrisVector,
) -> ImagefeatureharrisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagefeatureharrisVector::scale(
  self : ImagefeatureharrisVector,
  s : Double,
) -> ImagefeatureharrisVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ImagefeatureharrisVector::dot(
  self : ImagefeatureharrisVector,
  other : ImagefeatureharrisVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ImagefeatureharrisVector::norm(
  self : ImagefeatureharrisVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ImagefeatureharrisVector::normalize(
  self : ImagefeatureharrisVector,
) -> ImagefeatureharrisVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagefeatureharrisVector::dist(
  self : ImagefeatureharrisVector,
  other : ImagefeatureharrisVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ImagefeatureharrisVector::to_string(
  self : ImagefeatureharrisVector,
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
pub(all) struct ImagefeatureharrisFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_frame_make(size : Int32) -> ImagefeatureharrisFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisFrame::len(self : ImagefeatureharrisFrame) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisFrame::get(
  self : ImagefeatureharrisFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisFrame::set(
  self : ImagefeatureharrisFrame,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisFrame::sum(self : ImagefeatureharrisFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisFrame::mean(self : ImagefeatureharrisFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisFrame::scale(
  self : ImagefeatureharrisFrame,
  f : Double,
) -> ImagefeatureharrisFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisFrame::add(
  self : ImagefeatureharrisFrame,
  other : ImagefeatureharrisFrame,
) -> ImagefeatureharrisFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisFrame::copy(
  self : ImagefeatureharrisFrame,
) -> ImagefeatureharrisFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisFrame::fill(
  self : ImagefeatureharrisFrame,
  v : Double,
) -> ImagefeatureharrisFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisFrame::min(self : ImagefeatureharrisFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisFrame::max(self : ImagefeatureharrisFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisFrame::to_string(
  self : ImagefeatureharrisFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_table_make(size : Int32) -> ImagefeatureharrisTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisTable::len(self : ImagefeatureharrisTable) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisTable::get(
  self : ImagefeatureharrisTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisTable::set(
  self : ImagefeatureharrisTable,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisTable::sum(self : ImagefeatureharrisTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisTable::mean(self : ImagefeatureharrisTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisTable::scale(
  self : ImagefeatureharrisTable,
  f : Double,
) -> ImagefeatureharrisTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisTable::add(
  self : ImagefeatureharrisTable,
  other : ImagefeatureharrisTable,
) -> ImagefeatureharrisTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisTable::copy(
  self : ImagefeatureharrisTable,
) -> ImagefeatureharrisTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisTable::fill(
  self : ImagefeatureharrisTable,
  v : Double,
) -> ImagefeatureharrisTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisTable::min(self : ImagefeatureharrisTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisTable::max(self : ImagefeatureharrisTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisTable::to_string(
  self : ImagefeatureharrisTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_graphn_make(
  size : Int32,
) -> ImagefeatureharrisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisGraphN::len(self : ImagefeatureharrisGraphN) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisGraphN::get(
  self : ImagefeatureharrisGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisGraphN::set(
  self : ImagefeatureharrisGraphN,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisGraphN::sum(self : ImagefeatureharrisGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisGraphN::mean(
  self : ImagefeatureharrisGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisGraphN::scale(
  self : ImagefeatureharrisGraphN,
  f : Double,
) -> ImagefeatureharrisGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisGraphN::add(
  self : ImagefeatureharrisGraphN,
  other : ImagefeatureharrisGraphN,
) -> ImagefeatureharrisGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisGraphN::copy(
  self : ImagefeatureharrisGraphN,
) -> ImagefeatureharrisGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisGraphN::fill(
  self : ImagefeatureharrisGraphN,
  v : Double,
) -> ImagefeatureharrisGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisGraphN::min(self : ImagefeatureharrisGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisGraphN::max(self : ImagefeatureharrisGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisGraphN::to_string(
  self : ImagefeatureharrisGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_node_make(size : Int32) -> ImagefeatureharrisNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisNode::len(self : ImagefeatureharrisNode) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisNode::get(
  self : ImagefeatureharrisNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisNode::set(
  self : ImagefeatureharrisNode,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisNode::sum(self : ImagefeatureharrisNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisNode::mean(self : ImagefeatureharrisNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisNode::scale(
  self : ImagefeatureharrisNode,
  f : Double,
) -> ImagefeatureharrisNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisNode::add(
  self : ImagefeatureharrisNode,
  other : ImagefeatureharrisNode,
) -> ImagefeatureharrisNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisNode::copy(
  self : ImagefeatureharrisNode,
) -> ImagefeatureharrisNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisNode::fill(
  self : ImagefeatureharrisNode,
  v : Double,
) -> ImagefeatureharrisNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisNode::min(self : ImagefeatureharrisNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisNode::max(self : ImagefeatureharrisNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisNode::to_string(
  self : ImagefeatureharrisNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_edge_make(size : Int32) -> ImagefeatureharrisEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisEdge::len(self : ImagefeatureharrisEdge) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisEdge::get(
  self : ImagefeatureharrisEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisEdge::set(
  self : ImagefeatureharrisEdge,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisEdge::sum(self : ImagefeatureharrisEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisEdge::mean(self : ImagefeatureharrisEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisEdge::scale(
  self : ImagefeatureharrisEdge,
  f : Double,
) -> ImagefeatureharrisEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisEdge::add(
  self : ImagefeatureharrisEdge,
  other : ImagefeatureharrisEdge,
) -> ImagefeatureharrisEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisEdge::copy(
  self : ImagefeatureharrisEdge,
) -> ImagefeatureharrisEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisEdge::fill(
  self : ImagefeatureharrisEdge,
  v : Double,
) -> ImagefeatureharrisEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisEdge::min(self : ImagefeatureharrisEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisEdge::max(self : ImagefeatureharrisEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisEdge::to_string(
  self : ImagefeatureharrisEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_path_make(size : Int32) -> ImagefeatureharrisPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisPath::len(self : ImagefeatureharrisPath) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisPath::get(
  self : ImagefeatureharrisPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisPath::set(
  self : ImagefeatureharrisPath,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisPath::sum(self : ImagefeatureharrisPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisPath::mean(self : ImagefeatureharrisPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisPath::scale(
  self : ImagefeatureharrisPath,
  f : Double,
) -> ImagefeatureharrisPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisPath::add(
  self : ImagefeatureharrisPath,
  other : ImagefeatureharrisPath,
) -> ImagefeatureharrisPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisPath::copy(
  self : ImagefeatureharrisPath,
) -> ImagefeatureharrisPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisPath::fill(
  self : ImagefeatureharrisPath,
  v : Double,
) -> ImagefeatureharrisPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisPath::min(self : ImagefeatureharrisPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisPath::max(self : ImagefeatureharrisPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisPath::to_string(
  self : ImagefeatureharrisPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_cluster_make(
  size : Int32,
) -> ImagefeatureharrisCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisCluster::len(
  self : ImagefeatureharrisCluster,
) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisCluster::get(
  self : ImagefeatureharrisCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisCluster::set(
  self : ImagefeatureharrisCluster,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisCluster::sum(
  self : ImagefeatureharrisCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisCluster::mean(
  self : ImagefeatureharrisCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisCluster::scale(
  self : ImagefeatureharrisCluster,
  f : Double,
) -> ImagefeatureharrisCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisCluster::add(
  self : ImagefeatureharrisCluster,
  other : ImagefeatureharrisCluster,
) -> ImagefeatureharrisCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisCluster::copy(
  self : ImagefeatureharrisCluster,
) -> ImagefeatureharrisCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisCluster::fill(
  self : ImagefeatureharrisCluster,
  v : Double,
) -> ImagefeatureharrisCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisCluster::min(
  self : ImagefeatureharrisCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisCluster::max(
  self : ImagefeatureharrisCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisCluster::to_string(
  self : ImagefeatureharrisCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_model_make(size : Int32) -> ImagefeatureharrisModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisModel::len(self : ImagefeatureharrisModel) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisModel::get(
  self : ImagefeatureharrisModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisModel::set(
  self : ImagefeatureharrisModel,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisModel::sum(self : ImagefeatureharrisModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisModel::mean(self : ImagefeatureharrisModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisModel::scale(
  self : ImagefeatureharrisModel,
  f : Double,
) -> ImagefeatureharrisModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisModel::add(
  self : ImagefeatureharrisModel,
  other : ImagefeatureharrisModel,
) -> ImagefeatureharrisModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisModel::copy(
  self : ImagefeatureharrisModel,
) -> ImagefeatureharrisModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisModel::fill(
  self : ImagefeatureharrisModel,
  v : Double,
) -> ImagefeatureharrisModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisModel::min(self : ImagefeatureharrisModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisModel::max(self : ImagefeatureharrisModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisModel::to_string(
  self : ImagefeatureharrisModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_layer_make(size : Int32) -> ImagefeatureharrisLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisLayer::len(self : ImagefeatureharrisLayer) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisLayer::get(
  self : ImagefeatureharrisLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisLayer::set(
  self : ImagefeatureharrisLayer,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisLayer::sum(self : ImagefeatureharrisLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisLayer::mean(self : ImagefeatureharrisLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisLayer::scale(
  self : ImagefeatureharrisLayer,
  f : Double,
) -> ImagefeatureharrisLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisLayer::add(
  self : ImagefeatureharrisLayer,
  other : ImagefeatureharrisLayer,
) -> ImagefeatureharrisLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisLayer::copy(
  self : ImagefeatureharrisLayer,
) -> ImagefeatureharrisLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisLayer::fill(
  self : ImagefeatureharrisLayer,
  v : Double,
) -> ImagefeatureharrisLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisLayer::min(self : ImagefeatureharrisLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisLayer::max(self : ImagefeatureharrisLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisLayer::to_string(
  self : ImagefeatureharrisLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_buffer_make(
  size : Int32,
) -> ImagefeatureharrisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisBuffer::len(self : ImagefeatureharrisBuffer) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisBuffer::get(
  self : ImagefeatureharrisBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisBuffer::set(
  self : ImagefeatureharrisBuffer,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisBuffer::sum(self : ImagefeatureharrisBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisBuffer::mean(
  self : ImagefeatureharrisBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisBuffer::scale(
  self : ImagefeatureharrisBuffer,
  f : Double,
) -> ImagefeatureharrisBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisBuffer::add(
  self : ImagefeatureharrisBuffer,
  other : ImagefeatureharrisBuffer,
) -> ImagefeatureharrisBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisBuffer::copy(
  self : ImagefeatureharrisBuffer,
) -> ImagefeatureharrisBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisBuffer::fill(
  self : ImagefeatureharrisBuffer,
  v : Double,
) -> ImagefeatureharrisBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisBuffer::min(self : ImagefeatureharrisBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisBuffer::max(self : ImagefeatureharrisBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisBuffer::to_string(
  self : ImagefeatureharrisBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_cursor_make(
  size : Int32,
) -> ImagefeatureharrisCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisCursor::len(self : ImagefeatureharrisCursor) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisCursor::get(
  self : ImagefeatureharrisCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisCursor::set(
  self : ImagefeatureharrisCursor,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisCursor::sum(self : ImagefeatureharrisCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisCursor::mean(
  self : ImagefeatureharrisCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisCursor::scale(
  self : ImagefeatureharrisCursor,
  f : Double,
) -> ImagefeatureharrisCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisCursor::add(
  self : ImagefeatureharrisCursor,
  other : ImagefeatureharrisCursor,
) -> ImagefeatureharrisCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisCursor::copy(
  self : ImagefeatureharrisCursor,
) -> ImagefeatureharrisCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisCursor::fill(
  self : ImagefeatureharrisCursor,
  v : Double,
) -> ImagefeatureharrisCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisCursor::min(self : ImagefeatureharrisCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisCursor::max(self : ImagefeatureharrisCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisCursor::to_string(
  self : ImagefeatureharrisCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_view_make(size : Int32) -> ImagefeatureharrisView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisView::len(self : ImagefeatureharrisView) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisView::get(
  self : ImagefeatureharrisView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisView::set(
  self : ImagefeatureharrisView,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisView::sum(self : ImagefeatureharrisView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisView::mean(self : ImagefeatureharrisView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisView::scale(
  self : ImagefeatureharrisView,
  f : Double,
) -> ImagefeatureharrisView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisView::add(
  self : ImagefeatureharrisView,
  other : ImagefeatureharrisView,
) -> ImagefeatureharrisView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisView::copy(
  self : ImagefeatureharrisView,
) -> ImagefeatureharrisView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisView::fill(
  self : ImagefeatureharrisView,
  v : Double,
) -> ImagefeatureharrisView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisView::min(self : ImagefeatureharrisView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisView::max(self : ImagefeatureharrisView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisView::to_string(
  self : ImagefeatureharrisView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_range_make(size : Int32) -> ImagefeatureharrisRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisRange::len(self : ImagefeatureharrisRange) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisRange::get(
  self : ImagefeatureharrisRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisRange::set(
  self : ImagefeatureharrisRange,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisRange::sum(self : ImagefeatureharrisRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisRange::mean(self : ImagefeatureharrisRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisRange::scale(
  self : ImagefeatureharrisRange,
  f : Double,
) -> ImagefeatureharrisRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisRange::add(
  self : ImagefeatureharrisRange,
  other : ImagefeatureharrisRange,
) -> ImagefeatureharrisRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisRange::copy(
  self : ImagefeatureharrisRange,
) -> ImagefeatureharrisRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisRange::fill(
  self : ImagefeatureharrisRange,
  v : Double,
) -> ImagefeatureharrisRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisRange::min(self : ImagefeatureharrisRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisRange::max(self : ImagefeatureharrisRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisRange::to_string(
  self : ImagefeatureharrisRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagefeatureharrisSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_feature_harris_slice_make(size : Int32) -> ImagefeatureharrisSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagefeatureharrisSlice::len(self : ImagefeatureharrisSlice) -> Int32 {
  self.size
}

///|
pub fn ImagefeatureharrisSlice::get(
  self : ImagefeatureharrisSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagefeatureharrisSlice::set(
  self : ImagefeatureharrisSlice,
  i : Int32,
  v : Double,
) -> ImagefeatureharrisSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisSlice::sum(self : ImagefeatureharrisSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagefeatureharrisSlice::mean(self : ImagefeatureharrisSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagefeatureharrisSlice::scale(
  self : ImagefeatureharrisSlice,
  f : Double,
) -> ImagefeatureharrisSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisSlice::add(
  self : ImagefeatureharrisSlice,
  other : ImagefeatureharrisSlice,
) -> ImagefeatureharrisSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisSlice::copy(
  self : ImagefeatureharrisSlice,
) -> ImagefeatureharrisSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisSlice::fill(
  self : ImagefeatureharrisSlice,
  v : Double,
) -> ImagefeatureharrisSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagefeatureharrisSlice::min(self : ImagefeatureharrisSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagefeatureharrisSlice::max(self : ImagefeatureharrisSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagefeatureharrisSlice::to_string(
  self : ImagefeatureharrisSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
