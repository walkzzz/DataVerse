///|
///===
/// extcore/ml_feature_lda
pub(all) struct MlfeatureldaPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ml_feature_lda_make_point(x : Double, y : Double) -> MlfeatureldaPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ml_feature_lda_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MlfeatureldaPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MlfeatureldaPoint::x(self : MlfeatureldaPoint) -> Double {
  self.x
}

///|
pub fn MlfeatureldaPoint::y(self : MlfeatureldaPoint) -> Double {
  self.y
}

///|
pub fn MlfeatureldaPoint::z(self : MlfeatureldaPoint) -> Double {
  self.z
}

///|
pub fn MlfeatureldaPoint::label(self : MlfeatureldaPoint) -> Int32 {
  self.label
}

///|
pub fn MlfeatureldaPoint::dist(
  self : MlfeatureldaPoint,
  other : MlfeatureldaPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MlfeatureldaPoint::add(
  self : MlfeatureldaPoint,
  other : MlfeatureldaPoint,
) -> MlfeatureldaPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MlfeatureldaPoint::sub(
  self : MlfeatureldaPoint,
  other : MlfeatureldaPoint,
) -> MlfeatureldaPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MlfeatureldaPoint::scale(
  self : MlfeatureldaPoint,
  s : Double,
) -> MlfeatureldaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MlfeatureldaPoint::dot(
  self : MlfeatureldaPoint,
  other : MlfeatureldaPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MlfeatureldaPoint::cross(
  self : MlfeatureldaPoint,
  other : MlfeatureldaPoint,
) -> MlfeatureldaPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MlfeatureldaPoint::norm(self : MlfeatureldaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MlfeatureldaPoint::normalize(
  self : MlfeatureldaPoint,
) -> MlfeatureldaPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlfeatureldaPoint::negate(self : MlfeatureldaPoint) -> MlfeatureldaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MlfeatureldaPoint::mid(
  self : MlfeatureldaPoint,
  other : MlfeatureldaPoint,
) -> MlfeatureldaPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MlfeatureldaPoint::lerp(
  self : MlfeatureldaPoint,
  other : MlfeatureldaPoint,
  t : Double,
) -> MlfeatureldaPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MlfeatureldaPoint::to_string(self : MlfeatureldaPoint) -> String {
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
pub(all) struct MlfeatureldaSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ml_feature_lda_make_series(
  vals : Array[Double],
  name : String,
) -> MlfeatureldaSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MlfeatureldaSeries::len(self : MlfeatureldaSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MlfeatureldaSeries::sum(self : MlfeatureldaSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MlfeatureldaSeries::mean(self : MlfeatureldaSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MlfeatureldaSeries::min(self : MlfeatureldaSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MlfeatureldaSeries::max(self : MlfeatureldaSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MlfeatureldaSeries::range(self : MlfeatureldaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MlfeatureldaSeries::variance(self : MlfeatureldaSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MlfeatureldaSeries::std(self : MlfeatureldaSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MlfeatureldaSeries::median(self : MlfeatureldaSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MlfeatureldaSeries::scale(
  self : MlfeatureldaSeries,
  f : Double,
) -> MlfeatureldaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MlfeatureldaSeries::add(
  self : MlfeatureldaSeries,
  other : MlfeatureldaSeries,
) -> MlfeatureldaSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlfeatureldaSeries::sub(
  self : MlfeatureldaSeries,
  other : MlfeatureldaSeries,
) -> MlfeatureldaSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlfeatureldaSeries::normalize(
  self : MlfeatureldaSeries,
) -> MlfeatureldaSeries {
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
pub fn MlfeatureldaSeries::cumsum(
  self : MlfeatureldaSeries,
) -> MlfeatureldaSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MlfeatureldaSeries::to_string(self : MlfeatureldaSeries) -> String {
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
pub(all) struct MlfeatureldaMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ml_feature_lda_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MlfeatureldaMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ml_feature_lda_matrix_identity(n : Int32) -> MlfeatureldaMatrix {
  let m = ml_feature_lda_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MlfeatureldaMatrix::get(
  self : MlfeatureldaMatrix,
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
pub fn MlfeatureldaMatrix::transpose(
  self : MlfeatureldaMatrix,
) -> MlfeatureldaMatrix {
  let result = ml_feature_lda_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MlfeatureldaMatrix::add(
  self : MlfeatureldaMatrix,
  other : MlfeatureldaMatrix,
) -> MlfeatureldaMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ml_feature_lda_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MlfeatureldaMatrix::scale(
  self : MlfeatureldaMatrix,
  s : Double,
) -> MlfeatureldaMatrix {
  let result = ml_feature_lda_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MlfeatureldaMatrix::multiply(
  self : MlfeatureldaMatrix,
  other : MlfeatureldaMatrix,
) -> MlfeatureldaMatrix {
  if self.cols != other.rows {
    return ml_feature_lda_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ml_feature_lda_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MlfeatureldaMatrix::trace(self : MlfeatureldaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MlfeatureldaMatrix::det(self : MlfeatureldaMatrix) -> Double {
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
pub fn MlfeatureldaMatrix::norm(self : MlfeatureldaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MlfeatureldaMatrix::to_string(self : MlfeatureldaMatrix) -> String {
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
pub(all) struct MlfeatureldaVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ml_feature_lda_make_vector(comps : Array[Double]) -> MlfeatureldaVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ml_feature_lda_vector_zero(dim : Int32) -> MlfeatureldaVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MlfeatureldaVector::add(
  self : MlfeatureldaVector,
  other : MlfeatureldaVector,
) -> MlfeatureldaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlfeatureldaVector::sub(
  self : MlfeatureldaVector,
  other : MlfeatureldaVector,
) -> MlfeatureldaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlfeatureldaVector::scale(
  self : MlfeatureldaVector,
  s : Double,
) -> MlfeatureldaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MlfeatureldaVector::dot(
  self : MlfeatureldaVector,
  other : MlfeatureldaVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MlfeatureldaVector::norm(self : MlfeatureldaVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MlfeatureldaVector::normalize(
  self : MlfeatureldaVector,
) -> MlfeatureldaVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlfeatureldaVector::dist(
  self : MlfeatureldaVector,
  other : MlfeatureldaVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MlfeatureldaVector::to_string(self : MlfeatureldaVector) -> String {
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
pub(all) struct MlfeatureldaFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_frame_make(size : Int32) -> MlfeatureldaFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaFrame::len(self : MlfeatureldaFrame) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaFrame::get(self : MlfeatureldaFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaFrame::set(
  self : MlfeatureldaFrame,
  i : Int32,
  v : Double,
) -> MlfeatureldaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaFrame::sum(self : MlfeatureldaFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaFrame::mean(self : MlfeatureldaFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaFrame::scale(
  self : MlfeatureldaFrame,
  f : Double,
) -> MlfeatureldaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaFrame::add(
  self : MlfeatureldaFrame,
  other : MlfeatureldaFrame,
) -> MlfeatureldaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaFrame::copy(self : MlfeatureldaFrame) -> MlfeatureldaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaFrame::fill(
  self : MlfeatureldaFrame,
  v : Double,
) -> MlfeatureldaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaFrame::min(self : MlfeatureldaFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaFrame::max(self : MlfeatureldaFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaFrame::to_string(self : MlfeatureldaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_table_make(size : Int32) -> MlfeatureldaTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaTable::len(self : MlfeatureldaTable) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaTable::get(self : MlfeatureldaTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaTable::set(
  self : MlfeatureldaTable,
  i : Int32,
  v : Double,
) -> MlfeatureldaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaTable::sum(self : MlfeatureldaTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaTable::mean(self : MlfeatureldaTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaTable::scale(
  self : MlfeatureldaTable,
  f : Double,
) -> MlfeatureldaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaTable::add(
  self : MlfeatureldaTable,
  other : MlfeatureldaTable,
) -> MlfeatureldaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaTable::copy(self : MlfeatureldaTable) -> MlfeatureldaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaTable::fill(
  self : MlfeatureldaTable,
  v : Double,
) -> MlfeatureldaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaTable::min(self : MlfeatureldaTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaTable::max(self : MlfeatureldaTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaTable::to_string(self : MlfeatureldaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_graphn_make(size : Int32) -> MlfeatureldaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaGraphN::len(self : MlfeatureldaGraphN) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaGraphN::get(self : MlfeatureldaGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaGraphN::set(
  self : MlfeatureldaGraphN,
  i : Int32,
  v : Double,
) -> MlfeatureldaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaGraphN::sum(self : MlfeatureldaGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaGraphN::mean(self : MlfeatureldaGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaGraphN::scale(
  self : MlfeatureldaGraphN,
  f : Double,
) -> MlfeatureldaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaGraphN::add(
  self : MlfeatureldaGraphN,
  other : MlfeatureldaGraphN,
) -> MlfeatureldaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaGraphN::copy(
  self : MlfeatureldaGraphN,
) -> MlfeatureldaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaGraphN::fill(
  self : MlfeatureldaGraphN,
  v : Double,
) -> MlfeatureldaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaGraphN::min(self : MlfeatureldaGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaGraphN::max(self : MlfeatureldaGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaGraphN::to_string(self : MlfeatureldaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_node_make(size : Int32) -> MlfeatureldaNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaNode::len(self : MlfeatureldaNode) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaNode::get(self : MlfeatureldaNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaNode::set(
  self : MlfeatureldaNode,
  i : Int32,
  v : Double,
) -> MlfeatureldaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaNode::sum(self : MlfeatureldaNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaNode::mean(self : MlfeatureldaNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaNode::scale(
  self : MlfeatureldaNode,
  f : Double,
) -> MlfeatureldaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaNode::add(
  self : MlfeatureldaNode,
  other : MlfeatureldaNode,
) -> MlfeatureldaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaNode::copy(self : MlfeatureldaNode) -> MlfeatureldaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaNode::fill(
  self : MlfeatureldaNode,
  v : Double,
) -> MlfeatureldaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaNode::min(self : MlfeatureldaNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaNode::max(self : MlfeatureldaNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaNode::to_string(self : MlfeatureldaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_edge_make(size : Int32) -> MlfeatureldaEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaEdge::len(self : MlfeatureldaEdge) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaEdge::get(self : MlfeatureldaEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaEdge::set(
  self : MlfeatureldaEdge,
  i : Int32,
  v : Double,
) -> MlfeatureldaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaEdge::sum(self : MlfeatureldaEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaEdge::mean(self : MlfeatureldaEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaEdge::scale(
  self : MlfeatureldaEdge,
  f : Double,
) -> MlfeatureldaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaEdge::add(
  self : MlfeatureldaEdge,
  other : MlfeatureldaEdge,
) -> MlfeatureldaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaEdge::copy(self : MlfeatureldaEdge) -> MlfeatureldaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaEdge::fill(
  self : MlfeatureldaEdge,
  v : Double,
) -> MlfeatureldaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaEdge::min(self : MlfeatureldaEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaEdge::max(self : MlfeatureldaEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaEdge::to_string(self : MlfeatureldaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_path_make(size : Int32) -> MlfeatureldaPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaPath::len(self : MlfeatureldaPath) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaPath::get(self : MlfeatureldaPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaPath::set(
  self : MlfeatureldaPath,
  i : Int32,
  v : Double,
) -> MlfeatureldaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaPath::sum(self : MlfeatureldaPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaPath::mean(self : MlfeatureldaPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaPath::scale(
  self : MlfeatureldaPath,
  f : Double,
) -> MlfeatureldaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaPath::add(
  self : MlfeatureldaPath,
  other : MlfeatureldaPath,
) -> MlfeatureldaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaPath::copy(self : MlfeatureldaPath) -> MlfeatureldaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaPath::fill(
  self : MlfeatureldaPath,
  v : Double,
) -> MlfeatureldaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaPath::min(self : MlfeatureldaPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaPath::max(self : MlfeatureldaPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaPath::to_string(self : MlfeatureldaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_cluster_make(size : Int32) -> MlfeatureldaCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaCluster::len(self : MlfeatureldaCluster) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaCluster::get(
  self : MlfeatureldaCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaCluster::set(
  self : MlfeatureldaCluster,
  i : Int32,
  v : Double,
) -> MlfeatureldaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaCluster::sum(self : MlfeatureldaCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaCluster::mean(self : MlfeatureldaCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaCluster::scale(
  self : MlfeatureldaCluster,
  f : Double,
) -> MlfeatureldaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaCluster::add(
  self : MlfeatureldaCluster,
  other : MlfeatureldaCluster,
) -> MlfeatureldaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaCluster::copy(
  self : MlfeatureldaCluster,
) -> MlfeatureldaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaCluster::fill(
  self : MlfeatureldaCluster,
  v : Double,
) -> MlfeatureldaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaCluster::min(self : MlfeatureldaCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaCluster::max(self : MlfeatureldaCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaCluster::to_string(self : MlfeatureldaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_model_make(size : Int32) -> MlfeatureldaModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaModel::len(self : MlfeatureldaModel) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaModel::get(self : MlfeatureldaModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaModel::set(
  self : MlfeatureldaModel,
  i : Int32,
  v : Double,
) -> MlfeatureldaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaModel::sum(self : MlfeatureldaModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaModel::mean(self : MlfeatureldaModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaModel::scale(
  self : MlfeatureldaModel,
  f : Double,
) -> MlfeatureldaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaModel::add(
  self : MlfeatureldaModel,
  other : MlfeatureldaModel,
) -> MlfeatureldaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaModel::copy(self : MlfeatureldaModel) -> MlfeatureldaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaModel::fill(
  self : MlfeatureldaModel,
  v : Double,
) -> MlfeatureldaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaModel::min(self : MlfeatureldaModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaModel::max(self : MlfeatureldaModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaModel::to_string(self : MlfeatureldaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_layer_make(size : Int32) -> MlfeatureldaLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaLayer::len(self : MlfeatureldaLayer) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaLayer::get(self : MlfeatureldaLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaLayer::set(
  self : MlfeatureldaLayer,
  i : Int32,
  v : Double,
) -> MlfeatureldaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaLayer::sum(self : MlfeatureldaLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaLayer::mean(self : MlfeatureldaLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaLayer::scale(
  self : MlfeatureldaLayer,
  f : Double,
) -> MlfeatureldaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaLayer::add(
  self : MlfeatureldaLayer,
  other : MlfeatureldaLayer,
) -> MlfeatureldaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaLayer::copy(self : MlfeatureldaLayer) -> MlfeatureldaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaLayer::fill(
  self : MlfeatureldaLayer,
  v : Double,
) -> MlfeatureldaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaLayer::min(self : MlfeatureldaLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaLayer::max(self : MlfeatureldaLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaLayer::to_string(self : MlfeatureldaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_buffer_make(size : Int32) -> MlfeatureldaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaBuffer::len(self : MlfeatureldaBuffer) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaBuffer::get(self : MlfeatureldaBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaBuffer::set(
  self : MlfeatureldaBuffer,
  i : Int32,
  v : Double,
) -> MlfeatureldaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaBuffer::sum(self : MlfeatureldaBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaBuffer::mean(self : MlfeatureldaBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaBuffer::scale(
  self : MlfeatureldaBuffer,
  f : Double,
) -> MlfeatureldaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaBuffer::add(
  self : MlfeatureldaBuffer,
  other : MlfeatureldaBuffer,
) -> MlfeatureldaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaBuffer::copy(
  self : MlfeatureldaBuffer,
) -> MlfeatureldaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaBuffer::fill(
  self : MlfeatureldaBuffer,
  v : Double,
) -> MlfeatureldaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaBuffer::min(self : MlfeatureldaBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaBuffer::max(self : MlfeatureldaBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaBuffer::to_string(self : MlfeatureldaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_cursor_make(size : Int32) -> MlfeatureldaCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaCursor::len(self : MlfeatureldaCursor) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaCursor::get(self : MlfeatureldaCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaCursor::set(
  self : MlfeatureldaCursor,
  i : Int32,
  v : Double,
) -> MlfeatureldaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaCursor::sum(self : MlfeatureldaCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaCursor::mean(self : MlfeatureldaCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaCursor::scale(
  self : MlfeatureldaCursor,
  f : Double,
) -> MlfeatureldaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaCursor::add(
  self : MlfeatureldaCursor,
  other : MlfeatureldaCursor,
) -> MlfeatureldaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaCursor::copy(
  self : MlfeatureldaCursor,
) -> MlfeatureldaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaCursor::fill(
  self : MlfeatureldaCursor,
  v : Double,
) -> MlfeatureldaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaCursor::min(self : MlfeatureldaCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaCursor::max(self : MlfeatureldaCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaCursor::to_string(self : MlfeatureldaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_view_make(size : Int32) -> MlfeatureldaView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaView::len(self : MlfeatureldaView) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaView::get(self : MlfeatureldaView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaView::set(
  self : MlfeatureldaView,
  i : Int32,
  v : Double,
) -> MlfeatureldaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaView::sum(self : MlfeatureldaView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaView::mean(self : MlfeatureldaView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaView::scale(
  self : MlfeatureldaView,
  f : Double,
) -> MlfeatureldaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaView::add(
  self : MlfeatureldaView,
  other : MlfeatureldaView,
) -> MlfeatureldaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaView::copy(self : MlfeatureldaView) -> MlfeatureldaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaView::fill(
  self : MlfeatureldaView,
  v : Double,
) -> MlfeatureldaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaView::min(self : MlfeatureldaView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaView::max(self : MlfeatureldaView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaView::to_string(self : MlfeatureldaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_range_make(size : Int32) -> MlfeatureldaRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaRange::len(self : MlfeatureldaRange) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaRange::get(self : MlfeatureldaRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaRange::set(
  self : MlfeatureldaRange,
  i : Int32,
  v : Double,
) -> MlfeatureldaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaRange::sum(self : MlfeatureldaRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaRange::mean(self : MlfeatureldaRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaRange::scale(
  self : MlfeatureldaRange,
  f : Double,
) -> MlfeatureldaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaRange::add(
  self : MlfeatureldaRange,
  other : MlfeatureldaRange,
) -> MlfeatureldaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaRange::copy(self : MlfeatureldaRange) -> MlfeatureldaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaRange::fill(
  self : MlfeatureldaRange,
  v : Double,
) -> MlfeatureldaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaRange::min(self : MlfeatureldaRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaRange::max(self : MlfeatureldaRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaRange::to_string(self : MlfeatureldaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlfeatureldaSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_feature_lda_slice_make(size : Int32) -> MlfeatureldaSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlfeatureldaSlice::len(self : MlfeatureldaSlice) -> Int32 {
  self.size
}

///|
pub fn MlfeatureldaSlice::get(self : MlfeatureldaSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlfeatureldaSlice::set(
  self : MlfeatureldaSlice,
  i : Int32,
  v : Double,
) -> MlfeatureldaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaSlice::sum(self : MlfeatureldaSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlfeatureldaSlice::mean(self : MlfeatureldaSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlfeatureldaSlice::scale(
  self : MlfeatureldaSlice,
  f : Double,
) -> MlfeatureldaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaSlice::add(
  self : MlfeatureldaSlice,
  other : MlfeatureldaSlice,
) -> MlfeatureldaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlfeatureldaSlice::copy(self : MlfeatureldaSlice) -> MlfeatureldaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaSlice::fill(
  self : MlfeatureldaSlice,
  v : Double,
) -> MlfeatureldaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlfeatureldaSlice::min(self : MlfeatureldaSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlfeatureldaSlice::max(self : MlfeatureldaSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlfeatureldaSlice::to_string(self : MlfeatureldaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
