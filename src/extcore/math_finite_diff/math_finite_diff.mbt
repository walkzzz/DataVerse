///|
///===
/// extcore/math_finite_diff
pub(all) struct MathfinitediffPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn math_finite_diff_make_point(
  x : Double,
  y : Double,
) -> MathfinitediffPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn math_finite_diff_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MathfinitediffPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MathfinitediffPoint::x(self : MathfinitediffPoint) -> Double {
  self.x
}

///|
pub fn MathfinitediffPoint::y(self : MathfinitediffPoint) -> Double {
  self.y
}

///|
pub fn MathfinitediffPoint::z(self : MathfinitediffPoint) -> Double {
  self.z
}

///|
pub fn MathfinitediffPoint::label(self : MathfinitediffPoint) -> Int32 {
  self.label
}

///|
pub fn MathfinitediffPoint::dist(
  self : MathfinitediffPoint,
  other : MathfinitediffPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MathfinitediffPoint::add(
  self : MathfinitediffPoint,
  other : MathfinitediffPoint,
) -> MathfinitediffPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MathfinitediffPoint::sub(
  self : MathfinitediffPoint,
  other : MathfinitediffPoint,
) -> MathfinitediffPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MathfinitediffPoint::scale(
  self : MathfinitediffPoint,
  s : Double,
) -> MathfinitediffPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MathfinitediffPoint::dot(
  self : MathfinitediffPoint,
  other : MathfinitediffPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MathfinitediffPoint::cross(
  self : MathfinitediffPoint,
  other : MathfinitediffPoint,
) -> MathfinitediffPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MathfinitediffPoint::norm(self : MathfinitediffPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MathfinitediffPoint::normalize(
  self : MathfinitediffPoint,
) -> MathfinitediffPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathfinitediffPoint::negate(
  self : MathfinitediffPoint,
) -> MathfinitediffPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MathfinitediffPoint::mid(
  self : MathfinitediffPoint,
  other : MathfinitediffPoint,
) -> MathfinitediffPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MathfinitediffPoint::lerp(
  self : MathfinitediffPoint,
  other : MathfinitediffPoint,
  t : Double,
) -> MathfinitediffPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MathfinitediffPoint::to_string(self : MathfinitediffPoint) -> String {
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
pub(all) struct MathfinitediffSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn math_finite_diff_make_series(
  vals : Array[Double],
  name : String,
) -> MathfinitediffSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MathfinitediffSeries::len(self : MathfinitediffSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MathfinitediffSeries::sum(self : MathfinitediffSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MathfinitediffSeries::mean(self : MathfinitediffSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MathfinitediffSeries::min(self : MathfinitediffSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MathfinitediffSeries::max(self : MathfinitediffSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MathfinitediffSeries::range(self : MathfinitediffSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MathfinitediffSeries::variance(self : MathfinitediffSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MathfinitediffSeries::std(self : MathfinitediffSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MathfinitediffSeries::median(self : MathfinitediffSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MathfinitediffSeries::scale(
  self : MathfinitediffSeries,
  f : Double,
) -> MathfinitediffSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MathfinitediffSeries::add(
  self : MathfinitediffSeries,
  other : MathfinitediffSeries,
) -> MathfinitediffSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathfinitediffSeries::sub(
  self : MathfinitediffSeries,
  other : MathfinitediffSeries,
) -> MathfinitediffSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathfinitediffSeries::normalize(
  self : MathfinitediffSeries,
) -> MathfinitediffSeries {
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
pub fn MathfinitediffSeries::cumsum(
  self : MathfinitediffSeries,
) -> MathfinitediffSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MathfinitediffSeries::to_string(self : MathfinitediffSeries) -> String {
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
pub(all) struct MathfinitediffMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn math_finite_diff_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MathfinitediffMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn math_finite_diff_matrix_identity(n : Int32) -> MathfinitediffMatrix {
  let m = math_finite_diff_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MathfinitediffMatrix::get(
  self : MathfinitediffMatrix,
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
pub fn MathfinitediffMatrix::transpose(
  self : MathfinitediffMatrix,
) -> MathfinitediffMatrix {
  let result = math_finite_diff_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MathfinitediffMatrix::add(
  self : MathfinitediffMatrix,
  other : MathfinitediffMatrix,
) -> MathfinitediffMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = math_finite_diff_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MathfinitediffMatrix::scale(
  self : MathfinitediffMatrix,
  s : Double,
) -> MathfinitediffMatrix {
  let result = math_finite_diff_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MathfinitediffMatrix::multiply(
  self : MathfinitediffMatrix,
  other : MathfinitediffMatrix,
) -> MathfinitediffMatrix {
  if self.cols != other.rows {
    return math_finite_diff_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = math_finite_diff_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MathfinitediffMatrix::trace(self : MathfinitediffMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MathfinitediffMatrix::det(self : MathfinitediffMatrix) -> Double {
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
pub fn MathfinitediffMatrix::norm(self : MathfinitediffMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MathfinitediffMatrix::to_string(self : MathfinitediffMatrix) -> String {
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
pub(all) struct MathfinitediffVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn math_finite_diff_make_vector(
  comps : Array[Double],
) -> MathfinitediffVector {
  { comps, dim: comps.length(), }
}

///|
pub fn math_finite_diff_vector_zero(dim : Int32) -> MathfinitediffVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MathfinitediffVector::add(
  self : MathfinitediffVector,
  other : MathfinitediffVector,
) -> MathfinitediffVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathfinitediffVector::sub(
  self : MathfinitediffVector,
  other : MathfinitediffVector,
) -> MathfinitediffVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathfinitediffVector::scale(
  self : MathfinitediffVector,
  s : Double,
) -> MathfinitediffVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MathfinitediffVector::dot(
  self : MathfinitediffVector,
  other : MathfinitediffVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MathfinitediffVector::norm(self : MathfinitediffVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MathfinitediffVector::normalize(
  self : MathfinitediffVector,
) -> MathfinitediffVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathfinitediffVector::dist(
  self : MathfinitediffVector,
  other : MathfinitediffVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MathfinitediffVector::to_string(self : MathfinitediffVector) -> String {
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
pub(all) struct MathfinitediffFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_frame_make(size : Int32) -> MathfinitediffFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffFrame::len(self : MathfinitediffFrame) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffFrame::get(
  self : MathfinitediffFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffFrame::set(
  self : MathfinitediffFrame,
  i : Int32,
  v : Double,
) -> MathfinitediffFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffFrame::sum(self : MathfinitediffFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffFrame::mean(self : MathfinitediffFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffFrame::scale(
  self : MathfinitediffFrame,
  f : Double,
) -> MathfinitediffFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffFrame::add(
  self : MathfinitediffFrame,
  other : MathfinitediffFrame,
) -> MathfinitediffFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffFrame::copy(
  self : MathfinitediffFrame,
) -> MathfinitediffFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffFrame::fill(
  self : MathfinitediffFrame,
  v : Double,
) -> MathfinitediffFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffFrame::min(self : MathfinitediffFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffFrame::max(self : MathfinitediffFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffFrame::to_string(self : MathfinitediffFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_table_make(size : Int32) -> MathfinitediffTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffTable::len(self : MathfinitediffTable) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffTable::get(
  self : MathfinitediffTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffTable::set(
  self : MathfinitediffTable,
  i : Int32,
  v : Double,
) -> MathfinitediffTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffTable::sum(self : MathfinitediffTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffTable::mean(self : MathfinitediffTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffTable::scale(
  self : MathfinitediffTable,
  f : Double,
) -> MathfinitediffTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffTable::add(
  self : MathfinitediffTable,
  other : MathfinitediffTable,
) -> MathfinitediffTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffTable::copy(
  self : MathfinitediffTable,
) -> MathfinitediffTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffTable::fill(
  self : MathfinitediffTable,
  v : Double,
) -> MathfinitediffTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffTable::min(self : MathfinitediffTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffTable::max(self : MathfinitediffTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffTable::to_string(self : MathfinitediffTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_graphn_make(size : Int32) -> MathfinitediffGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffGraphN::len(self : MathfinitediffGraphN) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffGraphN::get(
  self : MathfinitediffGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffGraphN::set(
  self : MathfinitediffGraphN,
  i : Int32,
  v : Double,
) -> MathfinitediffGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffGraphN::sum(self : MathfinitediffGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffGraphN::mean(self : MathfinitediffGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffGraphN::scale(
  self : MathfinitediffGraphN,
  f : Double,
) -> MathfinitediffGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffGraphN::add(
  self : MathfinitediffGraphN,
  other : MathfinitediffGraphN,
) -> MathfinitediffGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffGraphN::copy(
  self : MathfinitediffGraphN,
) -> MathfinitediffGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffGraphN::fill(
  self : MathfinitediffGraphN,
  v : Double,
) -> MathfinitediffGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffGraphN::min(self : MathfinitediffGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffGraphN::max(self : MathfinitediffGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffGraphN::to_string(self : MathfinitediffGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_node_make(size : Int32) -> MathfinitediffNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffNode::len(self : MathfinitediffNode) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffNode::get(self : MathfinitediffNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffNode::set(
  self : MathfinitediffNode,
  i : Int32,
  v : Double,
) -> MathfinitediffNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffNode::sum(self : MathfinitediffNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffNode::mean(self : MathfinitediffNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffNode::scale(
  self : MathfinitediffNode,
  f : Double,
) -> MathfinitediffNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffNode::add(
  self : MathfinitediffNode,
  other : MathfinitediffNode,
) -> MathfinitediffNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffNode::copy(
  self : MathfinitediffNode,
) -> MathfinitediffNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffNode::fill(
  self : MathfinitediffNode,
  v : Double,
) -> MathfinitediffNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffNode::min(self : MathfinitediffNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffNode::max(self : MathfinitediffNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffNode::to_string(self : MathfinitediffNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_edge_make(size : Int32) -> MathfinitediffEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffEdge::len(self : MathfinitediffEdge) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffEdge::get(self : MathfinitediffEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffEdge::set(
  self : MathfinitediffEdge,
  i : Int32,
  v : Double,
) -> MathfinitediffEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffEdge::sum(self : MathfinitediffEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffEdge::mean(self : MathfinitediffEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffEdge::scale(
  self : MathfinitediffEdge,
  f : Double,
) -> MathfinitediffEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffEdge::add(
  self : MathfinitediffEdge,
  other : MathfinitediffEdge,
) -> MathfinitediffEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffEdge::copy(
  self : MathfinitediffEdge,
) -> MathfinitediffEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffEdge::fill(
  self : MathfinitediffEdge,
  v : Double,
) -> MathfinitediffEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffEdge::min(self : MathfinitediffEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffEdge::max(self : MathfinitediffEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffEdge::to_string(self : MathfinitediffEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_path_make(size : Int32) -> MathfinitediffPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffPath::len(self : MathfinitediffPath) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffPath::get(self : MathfinitediffPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffPath::set(
  self : MathfinitediffPath,
  i : Int32,
  v : Double,
) -> MathfinitediffPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffPath::sum(self : MathfinitediffPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffPath::mean(self : MathfinitediffPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffPath::scale(
  self : MathfinitediffPath,
  f : Double,
) -> MathfinitediffPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffPath::add(
  self : MathfinitediffPath,
  other : MathfinitediffPath,
) -> MathfinitediffPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffPath::copy(
  self : MathfinitediffPath,
) -> MathfinitediffPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffPath::fill(
  self : MathfinitediffPath,
  v : Double,
) -> MathfinitediffPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffPath::min(self : MathfinitediffPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffPath::max(self : MathfinitediffPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffPath::to_string(self : MathfinitediffPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_cluster_make(size : Int32) -> MathfinitediffCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffCluster::len(self : MathfinitediffCluster) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffCluster::get(
  self : MathfinitediffCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffCluster::set(
  self : MathfinitediffCluster,
  i : Int32,
  v : Double,
) -> MathfinitediffCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffCluster::sum(self : MathfinitediffCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffCluster::mean(self : MathfinitediffCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffCluster::scale(
  self : MathfinitediffCluster,
  f : Double,
) -> MathfinitediffCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffCluster::add(
  self : MathfinitediffCluster,
  other : MathfinitediffCluster,
) -> MathfinitediffCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffCluster::copy(
  self : MathfinitediffCluster,
) -> MathfinitediffCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffCluster::fill(
  self : MathfinitediffCluster,
  v : Double,
) -> MathfinitediffCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffCluster::min(self : MathfinitediffCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffCluster::max(self : MathfinitediffCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffCluster::to_string(self : MathfinitediffCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_model_make(size : Int32) -> MathfinitediffModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffModel::len(self : MathfinitediffModel) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffModel::get(
  self : MathfinitediffModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffModel::set(
  self : MathfinitediffModel,
  i : Int32,
  v : Double,
) -> MathfinitediffModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffModel::sum(self : MathfinitediffModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffModel::mean(self : MathfinitediffModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffModel::scale(
  self : MathfinitediffModel,
  f : Double,
) -> MathfinitediffModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffModel::add(
  self : MathfinitediffModel,
  other : MathfinitediffModel,
) -> MathfinitediffModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffModel::copy(
  self : MathfinitediffModel,
) -> MathfinitediffModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffModel::fill(
  self : MathfinitediffModel,
  v : Double,
) -> MathfinitediffModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffModel::min(self : MathfinitediffModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffModel::max(self : MathfinitediffModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffModel::to_string(self : MathfinitediffModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_layer_make(size : Int32) -> MathfinitediffLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffLayer::len(self : MathfinitediffLayer) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffLayer::get(
  self : MathfinitediffLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffLayer::set(
  self : MathfinitediffLayer,
  i : Int32,
  v : Double,
) -> MathfinitediffLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffLayer::sum(self : MathfinitediffLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffLayer::mean(self : MathfinitediffLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffLayer::scale(
  self : MathfinitediffLayer,
  f : Double,
) -> MathfinitediffLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffLayer::add(
  self : MathfinitediffLayer,
  other : MathfinitediffLayer,
) -> MathfinitediffLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffLayer::copy(
  self : MathfinitediffLayer,
) -> MathfinitediffLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffLayer::fill(
  self : MathfinitediffLayer,
  v : Double,
) -> MathfinitediffLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffLayer::min(self : MathfinitediffLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffLayer::max(self : MathfinitediffLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffLayer::to_string(self : MathfinitediffLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_buffer_make(size : Int32) -> MathfinitediffBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffBuffer::len(self : MathfinitediffBuffer) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffBuffer::get(
  self : MathfinitediffBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffBuffer::set(
  self : MathfinitediffBuffer,
  i : Int32,
  v : Double,
) -> MathfinitediffBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffBuffer::sum(self : MathfinitediffBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffBuffer::mean(self : MathfinitediffBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffBuffer::scale(
  self : MathfinitediffBuffer,
  f : Double,
) -> MathfinitediffBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffBuffer::add(
  self : MathfinitediffBuffer,
  other : MathfinitediffBuffer,
) -> MathfinitediffBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffBuffer::copy(
  self : MathfinitediffBuffer,
) -> MathfinitediffBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffBuffer::fill(
  self : MathfinitediffBuffer,
  v : Double,
) -> MathfinitediffBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffBuffer::min(self : MathfinitediffBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffBuffer::max(self : MathfinitediffBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffBuffer::to_string(self : MathfinitediffBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_cursor_make(size : Int32) -> MathfinitediffCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffCursor::len(self : MathfinitediffCursor) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffCursor::get(
  self : MathfinitediffCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffCursor::set(
  self : MathfinitediffCursor,
  i : Int32,
  v : Double,
) -> MathfinitediffCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffCursor::sum(self : MathfinitediffCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffCursor::mean(self : MathfinitediffCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffCursor::scale(
  self : MathfinitediffCursor,
  f : Double,
) -> MathfinitediffCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffCursor::add(
  self : MathfinitediffCursor,
  other : MathfinitediffCursor,
) -> MathfinitediffCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffCursor::copy(
  self : MathfinitediffCursor,
) -> MathfinitediffCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffCursor::fill(
  self : MathfinitediffCursor,
  v : Double,
) -> MathfinitediffCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffCursor::min(self : MathfinitediffCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffCursor::max(self : MathfinitediffCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffCursor::to_string(self : MathfinitediffCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_view_make(size : Int32) -> MathfinitediffView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffView::len(self : MathfinitediffView) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffView::get(self : MathfinitediffView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffView::set(
  self : MathfinitediffView,
  i : Int32,
  v : Double,
) -> MathfinitediffView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffView::sum(self : MathfinitediffView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffView::mean(self : MathfinitediffView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffView::scale(
  self : MathfinitediffView,
  f : Double,
) -> MathfinitediffView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffView::add(
  self : MathfinitediffView,
  other : MathfinitediffView,
) -> MathfinitediffView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffView::copy(
  self : MathfinitediffView,
) -> MathfinitediffView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffView::fill(
  self : MathfinitediffView,
  v : Double,
) -> MathfinitediffView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffView::min(self : MathfinitediffView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffView::max(self : MathfinitediffView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffView::to_string(self : MathfinitediffView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_range_make(size : Int32) -> MathfinitediffRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffRange::len(self : MathfinitediffRange) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffRange::get(
  self : MathfinitediffRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffRange::set(
  self : MathfinitediffRange,
  i : Int32,
  v : Double,
) -> MathfinitediffRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffRange::sum(self : MathfinitediffRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffRange::mean(self : MathfinitediffRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffRange::scale(
  self : MathfinitediffRange,
  f : Double,
) -> MathfinitediffRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffRange::add(
  self : MathfinitediffRange,
  other : MathfinitediffRange,
) -> MathfinitediffRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffRange::copy(
  self : MathfinitediffRange,
) -> MathfinitediffRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffRange::fill(
  self : MathfinitediffRange,
  v : Double,
) -> MathfinitediffRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffRange::min(self : MathfinitediffRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffRange::max(self : MathfinitediffRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffRange::to_string(self : MathfinitediffRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathfinitediffSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_finite_diff_slice_make(size : Int32) -> MathfinitediffSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathfinitediffSlice::len(self : MathfinitediffSlice) -> Int32 {
  self.size
}

///|
pub fn MathfinitediffSlice::get(
  self : MathfinitediffSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathfinitediffSlice::set(
  self : MathfinitediffSlice,
  i : Int32,
  v : Double,
) -> MathfinitediffSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffSlice::sum(self : MathfinitediffSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathfinitediffSlice::mean(self : MathfinitediffSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathfinitediffSlice::scale(
  self : MathfinitediffSlice,
  f : Double,
) -> MathfinitediffSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffSlice::add(
  self : MathfinitediffSlice,
  other : MathfinitediffSlice,
) -> MathfinitediffSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathfinitediffSlice::copy(
  self : MathfinitediffSlice,
) -> MathfinitediffSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffSlice::fill(
  self : MathfinitediffSlice,
  v : Double,
) -> MathfinitediffSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathfinitediffSlice::min(self : MathfinitediffSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathfinitediffSlice::max(self : MathfinitediffSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathfinitediffSlice::to_string(self : MathfinitediffSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
