///|
///===
/// extcore/ml_neural_gan
pub(all) struct MlneuralganPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ml_neural_gan_make_point(x : Double, y : Double) -> MlneuralganPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ml_neural_gan_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MlneuralganPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MlneuralganPoint::x(self : MlneuralganPoint) -> Double {
  self.x
}

///|
pub fn MlneuralganPoint::y(self : MlneuralganPoint) -> Double {
  self.y
}

///|
pub fn MlneuralganPoint::z(self : MlneuralganPoint) -> Double {
  self.z
}

///|
pub fn MlneuralganPoint::label(self : MlneuralganPoint) -> Int32 {
  self.label
}

///|
pub fn MlneuralganPoint::dist(
  self : MlneuralganPoint,
  other : MlneuralganPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MlneuralganPoint::add(
  self : MlneuralganPoint,
  other : MlneuralganPoint,
) -> MlneuralganPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MlneuralganPoint::sub(
  self : MlneuralganPoint,
  other : MlneuralganPoint,
) -> MlneuralganPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MlneuralganPoint::scale(
  self : MlneuralganPoint,
  s : Double,
) -> MlneuralganPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MlneuralganPoint::dot(
  self : MlneuralganPoint,
  other : MlneuralganPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MlneuralganPoint::cross(
  self : MlneuralganPoint,
  other : MlneuralganPoint,
) -> MlneuralganPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MlneuralganPoint::norm(self : MlneuralganPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MlneuralganPoint::normalize(self : MlneuralganPoint) -> MlneuralganPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlneuralganPoint::negate(self : MlneuralganPoint) -> MlneuralganPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MlneuralganPoint::mid(
  self : MlneuralganPoint,
  other : MlneuralganPoint,
) -> MlneuralganPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MlneuralganPoint::lerp(
  self : MlneuralganPoint,
  other : MlneuralganPoint,
  t : Double,
) -> MlneuralganPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MlneuralganPoint::to_string(self : MlneuralganPoint) -> String {
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
pub(all) struct MlneuralganSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ml_neural_gan_make_series(
  vals : Array[Double],
  name : String,
) -> MlneuralganSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MlneuralganSeries::len(self : MlneuralganSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MlneuralganSeries::sum(self : MlneuralganSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MlneuralganSeries::mean(self : MlneuralganSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MlneuralganSeries::min(self : MlneuralganSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MlneuralganSeries::max(self : MlneuralganSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MlneuralganSeries::range(self : MlneuralganSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MlneuralganSeries::variance(self : MlneuralganSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MlneuralganSeries::std(self : MlneuralganSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MlneuralganSeries::median(self : MlneuralganSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MlneuralganSeries::scale(
  self : MlneuralganSeries,
  f : Double,
) -> MlneuralganSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MlneuralganSeries::add(
  self : MlneuralganSeries,
  other : MlneuralganSeries,
) -> MlneuralganSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlneuralganSeries::sub(
  self : MlneuralganSeries,
  other : MlneuralganSeries,
) -> MlneuralganSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlneuralganSeries::normalize(
  self : MlneuralganSeries,
) -> MlneuralganSeries {
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
pub fn MlneuralganSeries::cumsum(self : MlneuralganSeries) -> MlneuralganSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MlneuralganSeries::to_string(self : MlneuralganSeries) -> String {
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
pub(all) struct MlneuralganMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ml_neural_gan_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MlneuralganMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ml_neural_gan_matrix_identity(n : Int32) -> MlneuralganMatrix {
  let m = ml_neural_gan_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MlneuralganMatrix::get(
  self : MlneuralganMatrix,
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
pub fn MlneuralganMatrix::transpose(
  self : MlneuralganMatrix,
) -> MlneuralganMatrix {
  let result = ml_neural_gan_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MlneuralganMatrix::add(
  self : MlneuralganMatrix,
  other : MlneuralganMatrix,
) -> MlneuralganMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ml_neural_gan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MlneuralganMatrix::scale(
  self : MlneuralganMatrix,
  s : Double,
) -> MlneuralganMatrix {
  let result = ml_neural_gan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MlneuralganMatrix::multiply(
  self : MlneuralganMatrix,
  other : MlneuralganMatrix,
) -> MlneuralganMatrix {
  if self.cols != other.rows {
    return ml_neural_gan_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ml_neural_gan_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MlneuralganMatrix::trace(self : MlneuralganMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MlneuralganMatrix::det(self : MlneuralganMatrix) -> Double {
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
pub fn MlneuralganMatrix::norm(self : MlneuralganMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MlneuralganMatrix::to_string(self : MlneuralganMatrix) -> String {
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
pub(all) struct MlneuralganVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ml_neural_gan_make_vector(comps : Array[Double]) -> MlneuralganVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ml_neural_gan_vector_zero(dim : Int32) -> MlneuralganVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MlneuralganVector::add(
  self : MlneuralganVector,
  other : MlneuralganVector,
) -> MlneuralganVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlneuralganVector::sub(
  self : MlneuralganVector,
  other : MlneuralganVector,
) -> MlneuralganVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlneuralganVector::scale(
  self : MlneuralganVector,
  s : Double,
) -> MlneuralganVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MlneuralganVector::dot(
  self : MlneuralganVector,
  other : MlneuralganVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MlneuralganVector::norm(self : MlneuralganVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MlneuralganVector::normalize(
  self : MlneuralganVector,
) -> MlneuralganVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlneuralganVector::dist(
  self : MlneuralganVector,
  other : MlneuralganVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MlneuralganVector::to_string(self : MlneuralganVector) -> String {
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
pub(all) struct MlneuralganFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_frame_make(size : Int32) -> MlneuralganFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganFrame::len(self : MlneuralganFrame) -> Int32 {
  self.size
}

///|
pub fn MlneuralganFrame::get(self : MlneuralganFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganFrame::set(
  self : MlneuralganFrame,
  i : Int32,
  v : Double,
) -> MlneuralganFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganFrame::sum(self : MlneuralganFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganFrame::mean(self : MlneuralganFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganFrame::scale(
  self : MlneuralganFrame,
  f : Double,
) -> MlneuralganFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganFrame::add(
  self : MlneuralganFrame,
  other : MlneuralganFrame,
) -> MlneuralganFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganFrame::copy(self : MlneuralganFrame) -> MlneuralganFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganFrame::fill(
  self : MlneuralganFrame,
  v : Double,
) -> MlneuralganFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganFrame::min(self : MlneuralganFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganFrame::max(self : MlneuralganFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganFrame::to_string(self : MlneuralganFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_table_make(size : Int32) -> MlneuralganTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganTable::len(self : MlneuralganTable) -> Int32 {
  self.size
}

///|
pub fn MlneuralganTable::get(self : MlneuralganTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganTable::set(
  self : MlneuralganTable,
  i : Int32,
  v : Double,
) -> MlneuralganTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganTable::sum(self : MlneuralganTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganTable::mean(self : MlneuralganTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganTable::scale(
  self : MlneuralganTable,
  f : Double,
) -> MlneuralganTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganTable::add(
  self : MlneuralganTable,
  other : MlneuralganTable,
) -> MlneuralganTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganTable::copy(self : MlneuralganTable) -> MlneuralganTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganTable::fill(
  self : MlneuralganTable,
  v : Double,
) -> MlneuralganTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganTable::min(self : MlneuralganTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganTable::max(self : MlneuralganTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganTable::to_string(self : MlneuralganTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_graphn_make(size : Int32) -> MlneuralganGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganGraphN::len(self : MlneuralganGraphN) -> Int32 {
  self.size
}

///|
pub fn MlneuralganGraphN::get(self : MlneuralganGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganGraphN::set(
  self : MlneuralganGraphN,
  i : Int32,
  v : Double,
) -> MlneuralganGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganGraphN::sum(self : MlneuralganGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganGraphN::mean(self : MlneuralganGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganGraphN::scale(
  self : MlneuralganGraphN,
  f : Double,
) -> MlneuralganGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganGraphN::add(
  self : MlneuralganGraphN,
  other : MlneuralganGraphN,
) -> MlneuralganGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganGraphN::copy(self : MlneuralganGraphN) -> MlneuralganGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganGraphN::fill(
  self : MlneuralganGraphN,
  v : Double,
) -> MlneuralganGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganGraphN::min(self : MlneuralganGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganGraphN::max(self : MlneuralganGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganGraphN::to_string(self : MlneuralganGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_node_make(size : Int32) -> MlneuralganNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganNode::len(self : MlneuralganNode) -> Int32 {
  self.size
}

///|
pub fn MlneuralganNode::get(self : MlneuralganNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganNode::set(
  self : MlneuralganNode,
  i : Int32,
  v : Double,
) -> MlneuralganNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganNode::sum(self : MlneuralganNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganNode::mean(self : MlneuralganNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganNode::scale(
  self : MlneuralganNode,
  f : Double,
) -> MlneuralganNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganNode::add(
  self : MlneuralganNode,
  other : MlneuralganNode,
) -> MlneuralganNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganNode::copy(self : MlneuralganNode) -> MlneuralganNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganNode::fill(
  self : MlneuralganNode,
  v : Double,
) -> MlneuralganNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganNode::min(self : MlneuralganNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganNode::max(self : MlneuralganNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganNode::to_string(self : MlneuralganNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_edge_make(size : Int32) -> MlneuralganEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganEdge::len(self : MlneuralganEdge) -> Int32 {
  self.size
}

///|
pub fn MlneuralganEdge::get(self : MlneuralganEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganEdge::set(
  self : MlneuralganEdge,
  i : Int32,
  v : Double,
) -> MlneuralganEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganEdge::sum(self : MlneuralganEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganEdge::mean(self : MlneuralganEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganEdge::scale(
  self : MlneuralganEdge,
  f : Double,
) -> MlneuralganEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganEdge::add(
  self : MlneuralganEdge,
  other : MlneuralganEdge,
) -> MlneuralganEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganEdge::copy(self : MlneuralganEdge) -> MlneuralganEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganEdge::fill(
  self : MlneuralganEdge,
  v : Double,
) -> MlneuralganEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganEdge::min(self : MlneuralganEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganEdge::max(self : MlneuralganEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganEdge::to_string(self : MlneuralganEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_path_make(size : Int32) -> MlneuralganPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganPath::len(self : MlneuralganPath) -> Int32 {
  self.size
}

///|
pub fn MlneuralganPath::get(self : MlneuralganPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganPath::set(
  self : MlneuralganPath,
  i : Int32,
  v : Double,
) -> MlneuralganPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganPath::sum(self : MlneuralganPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganPath::mean(self : MlneuralganPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganPath::scale(
  self : MlneuralganPath,
  f : Double,
) -> MlneuralganPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganPath::add(
  self : MlneuralganPath,
  other : MlneuralganPath,
) -> MlneuralganPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganPath::copy(self : MlneuralganPath) -> MlneuralganPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganPath::fill(
  self : MlneuralganPath,
  v : Double,
) -> MlneuralganPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganPath::min(self : MlneuralganPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganPath::max(self : MlneuralganPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganPath::to_string(self : MlneuralganPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_cluster_make(size : Int32) -> MlneuralganCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganCluster::len(self : MlneuralganCluster) -> Int32 {
  self.size
}

///|
pub fn MlneuralganCluster::get(self : MlneuralganCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganCluster::set(
  self : MlneuralganCluster,
  i : Int32,
  v : Double,
) -> MlneuralganCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganCluster::sum(self : MlneuralganCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganCluster::mean(self : MlneuralganCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganCluster::scale(
  self : MlneuralganCluster,
  f : Double,
) -> MlneuralganCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganCluster::add(
  self : MlneuralganCluster,
  other : MlneuralganCluster,
) -> MlneuralganCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganCluster::copy(
  self : MlneuralganCluster,
) -> MlneuralganCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganCluster::fill(
  self : MlneuralganCluster,
  v : Double,
) -> MlneuralganCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganCluster::min(self : MlneuralganCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganCluster::max(self : MlneuralganCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganCluster::to_string(self : MlneuralganCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_model_make(size : Int32) -> MlneuralganModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganModel::len(self : MlneuralganModel) -> Int32 {
  self.size
}

///|
pub fn MlneuralganModel::get(self : MlneuralganModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganModel::set(
  self : MlneuralganModel,
  i : Int32,
  v : Double,
) -> MlneuralganModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganModel::sum(self : MlneuralganModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganModel::mean(self : MlneuralganModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganModel::scale(
  self : MlneuralganModel,
  f : Double,
) -> MlneuralganModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganModel::add(
  self : MlneuralganModel,
  other : MlneuralganModel,
) -> MlneuralganModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganModel::copy(self : MlneuralganModel) -> MlneuralganModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganModel::fill(
  self : MlneuralganModel,
  v : Double,
) -> MlneuralganModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganModel::min(self : MlneuralganModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganModel::max(self : MlneuralganModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganModel::to_string(self : MlneuralganModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_layer_make(size : Int32) -> MlneuralganLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganLayer::len(self : MlneuralganLayer) -> Int32 {
  self.size
}

///|
pub fn MlneuralganLayer::get(self : MlneuralganLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganLayer::set(
  self : MlneuralganLayer,
  i : Int32,
  v : Double,
) -> MlneuralganLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganLayer::sum(self : MlneuralganLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganLayer::mean(self : MlneuralganLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganLayer::scale(
  self : MlneuralganLayer,
  f : Double,
) -> MlneuralganLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganLayer::add(
  self : MlneuralganLayer,
  other : MlneuralganLayer,
) -> MlneuralganLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganLayer::copy(self : MlneuralganLayer) -> MlneuralganLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganLayer::fill(
  self : MlneuralganLayer,
  v : Double,
) -> MlneuralganLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganLayer::min(self : MlneuralganLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganLayer::max(self : MlneuralganLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganLayer::to_string(self : MlneuralganLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_buffer_make(size : Int32) -> MlneuralganBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganBuffer::len(self : MlneuralganBuffer) -> Int32 {
  self.size
}

///|
pub fn MlneuralganBuffer::get(self : MlneuralganBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganBuffer::set(
  self : MlneuralganBuffer,
  i : Int32,
  v : Double,
) -> MlneuralganBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganBuffer::sum(self : MlneuralganBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganBuffer::mean(self : MlneuralganBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganBuffer::scale(
  self : MlneuralganBuffer,
  f : Double,
) -> MlneuralganBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganBuffer::add(
  self : MlneuralganBuffer,
  other : MlneuralganBuffer,
) -> MlneuralganBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganBuffer::copy(self : MlneuralganBuffer) -> MlneuralganBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganBuffer::fill(
  self : MlneuralganBuffer,
  v : Double,
) -> MlneuralganBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganBuffer::min(self : MlneuralganBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganBuffer::max(self : MlneuralganBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganBuffer::to_string(self : MlneuralganBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_cursor_make(size : Int32) -> MlneuralganCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganCursor::len(self : MlneuralganCursor) -> Int32 {
  self.size
}

///|
pub fn MlneuralganCursor::get(self : MlneuralganCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganCursor::set(
  self : MlneuralganCursor,
  i : Int32,
  v : Double,
) -> MlneuralganCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganCursor::sum(self : MlneuralganCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganCursor::mean(self : MlneuralganCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganCursor::scale(
  self : MlneuralganCursor,
  f : Double,
) -> MlneuralganCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganCursor::add(
  self : MlneuralganCursor,
  other : MlneuralganCursor,
) -> MlneuralganCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganCursor::copy(self : MlneuralganCursor) -> MlneuralganCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganCursor::fill(
  self : MlneuralganCursor,
  v : Double,
) -> MlneuralganCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganCursor::min(self : MlneuralganCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganCursor::max(self : MlneuralganCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganCursor::to_string(self : MlneuralganCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_view_make(size : Int32) -> MlneuralganView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganView::len(self : MlneuralganView) -> Int32 {
  self.size
}

///|
pub fn MlneuralganView::get(self : MlneuralganView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganView::set(
  self : MlneuralganView,
  i : Int32,
  v : Double,
) -> MlneuralganView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganView::sum(self : MlneuralganView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganView::mean(self : MlneuralganView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganView::scale(
  self : MlneuralganView,
  f : Double,
) -> MlneuralganView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganView::add(
  self : MlneuralganView,
  other : MlneuralganView,
) -> MlneuralganView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganView::copy(self : MlneuralganView) -> MlneuralganView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganView::fill(
  self : MlneuralganView,
  v : Double,
) -> MlneuralganView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganView::min(self : MlneuralganView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganView::max(self : MlneuralganView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganView::to_string(self : MlneuralganView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_range_make(size : Int32) -> MlneuralganRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganRange::len(self : MlneuralganRange) -> Int32 {
  self.size
}

///|
pub fn MlneuralganRange::get(self : MlneuralganRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganRange::set(
  self : MlneuralganRange,
  i : Int32,
  v : Double,
) -> MlneuralganRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganRange::sum(self : MlneuralganRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganRange::mean(self : MlneuralganRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganRange::scale(
  self : MlneuralganRange,
  f : Double,
) -> MlneuralganRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganRange::add(
  self : MlneuralganRange,
  other : MlneuralganRange,
) -> MlneuralganRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganRange::copy(self : MlneuralganRange) -> MlneuralganRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganRange::fill(
  self : MlneuralganRange,
  v : Double,
) -> MlneuralganRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganRange::min(self : MlneuralganRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganRange::max(self : MlneuralganRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganRange::to_string(self : MlneuralganRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlneuralganSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_neural_gan_slice_make(size : Int32) -> MlneuralganSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlneuralganSlice::len(self : MlneuralganSlice) -> Int32 {
  self.size
}

///|
pub fn MlneuralganSlice::get(self : MlneuralganSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlneuralganSlice::set(
  self : MlneuralganSlice,
  i : Int32,
  v : Double,
) -> MlneuralganSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganSlice::sum(self : MlneuralganSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlneuralganSlice::mean(self : MlneuralganSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlneuralganSlice::scale(
  self : MlneuralganSlice,
  f : Double,
) -> MlneuralganSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganSlice::add(
  self : MlneuralganSlice,
  other : MlneuralganSlice,
) -> MlneuralganSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlneuralganSlice::copy(self : MlneuralganSlice) -> MlneuralganSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganSlice::fill(
  self : MlneuralganSlice,
  v : Double,
) -> MlneuralganSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlneuralganSlice::min(self : MlneuralganSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlneuralganSlice::max(self : MlneuralganSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlneuralganSlice::to_string(self : MlneuralganSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
