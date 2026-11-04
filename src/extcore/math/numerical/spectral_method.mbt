///|
///===
/// extcore/math_spectral_method
pub(all) struct MathspectralmethodPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn math_spectral_method_make_point(
  x : Double,
  y : Double,
) -> MathspectralmethodPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn math_spectral_method_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MathspectralmethodPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MathspectralmethodPoint::x(self : MathspectralmethodPoint) -> Double {
  self.x
}

///|
pub fn MathspectralmethodPoint::y(self : MathspectralmethodPoint) -> Double {
  self.y
}

///|
pub fn MathspectralmethodPoint::z(self : MathspectralmethodPoint) -> Double {
  self.z
}

///|
pub fn MathspectralmethodPoint::label(self : MathspectralmethodPoint) -> Int32 {
  self.label
}

///|
pub fn MathspectralmethodPoint::dist(
  self : MathspectralmethodPoint,
  other : MathspectralmethodPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MathspectralmethodPoint::add(
  self : MathspectralmethodPoint,
  other : MathspectralmethodPoint,
) -> MathspectralmethodPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MathspectralmethodPoint::sub(
  self : MathspectralmethodPoint,
  other : MathspectralmethodPoint,
) -> MathspectralmethodPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MathspectralmethodPoint::scale(
  self : MathspectralmethodPoint,
  s : Double,
) -> MathspectralmethodPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MathspectralmethodPoint::dot(
  self : MathspectralmethodPoint,
  other : MathspectralmethodPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MathspectralmethodPoint::cross(
  self : MathspectralmethodPoint,
  other : MathspectralmethodPoint,
) -> MathspectralmethodPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MathspectralmethodPoint::norm(self : MathspectralmethodPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MathspectralmethodPoint::normalize(
  self : MathspectralmethodPoint,
) -> MathspectralmethodPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathspectralmethodPoint::negate(
  self : MathspectralmethodPoint,
) -> MathspectralmethodPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MathspectralmethodPoint::mid(
  self : MathspectralmethodPoint,
  other : MathspectralmethodPoint,
) -> MathspectralmethodPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MathspectralmethodPoint::lerp(
  self : MathspectralmethodPoint,
  other : MathspectralmethodPoint,
  t : Double,
) -> MathspectralmethodPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MathspectralmethodPoint::to_string(
  self : MathspectralmethodPoint,
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
pub(all) struct MathspectralmethodSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn math_spectral_method_make_series(
  vals : Array[Double],
  name : String,
) -> MathspectralmethodSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MathspectralmethodSeries::len(self : MathspectralmethodSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MathspectralmethodSeries::sum(self : MathspectralmethodSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MathspectralmethodSeries::mean(
  self : MathspectralmethodSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MathspectralmethodSeries::min(self : MathspectralmethodSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MathspectralmethodSeries::max(self : MathspectralmethodSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MathspectralmethodSeries::range(
  self : MathspectralmethodSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MathspectralmethodSeries::variance(
  self : MathspectralmethodSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MathspectralmethodSeries::std(self : MathspectralmethodSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MathspectralmethodSeries::median(
  self : MathspectralmethodSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MathspectralmethodSeries::scale(
  self : MathspectralmethodSeries,
  f : Double,
) -> MathspectralmethodSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MathspectralmethodSeries::add(
  self : MathspectralmethodSeries,
  other : MathspectralmethodSeries,
) -> MathspectralmethodSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathspectralmethodSeries::sub(
  self : MathspectralmethodSeries,
  other : MathspectralmethodSeries,
) -> MathspectralmethodSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathspectralmethodSeries::normalize(
  self : MathspectralmethodSeries,
) -> MathspectralmethodSeries {
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
pub fn MathspectralmethodSeries::cumsum(
  self : MathspectralmethodSeries,
) -> MathspectralmethodSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MathspectralmethodSeries::to_string(
  self : MathspectralmethodSeries,
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
pub(all) struct MathspectralmethodMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn math_spectral_method_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MathspectralmethodMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn math_spectral_method_matrix_identity(
  n : Int32,
) -> MathspectralmethodMatrix {
  let m = math_spectral_method_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MathspectralmethodMatrix::get(
  self : MathspectralmethodMatrix,
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
pub fn MathspectralmethodMatrix::transpose(
  self : MathspectralmethodMatrix,
) -> MathspectralmethodMatrix {
  let result = math_spectral_method_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MathspectralmethodMatrix::add(
  self : MathspectralmethodMatrix,
  other : MathspectralmethodMatrix,
) -> MathspectralmethodMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = math_spectral_method_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MathspectralmethodMatrix::scale(
  self : MathspectralmethodMatrix,
  s : Double,
) -> MathspectralmethodMatrix {
  let result = math_spectral_method_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MathspectralmethodMatrix::multiply(
  self : MathspectralmethodMatrix,
  other : MathspectralmethodMatrix,
) -> MathspectralmethodMatrix {
  if self.cols != other.rows {
    return math_spectral_method_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = math_spectral_method_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MathspectralmethodMatrix::trace(
  self : MathspectralmethodMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MathspectralmethodMatrix::det(self : MathspectralmethodMatrix) -> Double {
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
pub fn MathspectralmethodMatrix::norm(
  self : MathspectralmethodMatrix,
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
pub fn MathspectralmethodMatrix::to_string(
  self : MathspectralmethodMatrix,
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
pub(all) struct MathspectralmethodVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn math_spectral_method_make_vector(
  comps : Array[Double],
) -> MathspectralmethodVector {
  { comps, dim: comps.length(), }
}

///|
pub fn math_spectral_method_vector_zero(
  dim : Int32,
) -> MathspectralmethodVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MathspectralmethodVector::add(
  self : MathspectralmethodVector,
  other : MathspectralmethodVector,
) -> MathspectralmethodVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathspectralmethodVector::sub(
  self : MathspectralmethodVector,
  other : MathspectralmethodVector,
) -> MathspectralmethodVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathspectralmethodVector::scale(
  self : MathspectralmethodVector,
  s : Double,
) -> MathspectralmethodVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MathspectralmethodVector::dot(
  self : MathspectralmethodVector,
  other : MathspectralmethodVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MathspectralmethodVector::norm(
  self : MathspectralmethodVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MathspectralmethodVector::normalize(
  self : MathspectralmethodVector,
) -> MathspectralmethodVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathspectralmethodVector::dist(
  self : MathspectralmethodVector,
  other : MathspectralmethodVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MathspectralmethodVector::to_string(
  self : MathspectralmethodVector,
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
pub(all) struct MathspectralmethodFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_frame_make(size : Int32) -> MathspectralmethodFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodFrame::len(self : MathspectralmethodFrame) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodFrame::get(
  self : MathspectralmethodFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodFrame::set(
  self : MathspectralmethodFrame,
  i : Int32,
  v : Double,
) -> MathspectralmethodFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodFrame::sum(self : MathspectralmethodFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodFrame::mean(self : MathspectralmethodFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodFrame::scale(
  self : MathspectralmethodFrame,
  f : Double,
) -> MathspectralmethodFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodFrame::add(
  self : MathspectralmethodFrame,
  other : MathspectralmethodFrame,
) -> MathspectralmethodFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodFrame::copy(
  self : MathspectralmethodFrame,
) -> MathspectralmethodFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodFrame::fill(
  self : MathspectralmethodFrame,
  v : Double,
) -> MathspectralmethodFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodFrame::min(self : MathspectralmethodFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodFrame::max(self : MathspectralmethodFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodFrame::to_string(
  self : MathspectralmethodFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_table_make(size : Int32) -> MathspectralmethodTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodTable::len(self : MathspectralmethodTable) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodTable::get(
  self : MathspectralmethodTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodTable::set(
  self : MathspectralmethodTable,
  i : Int32,
  v : Double,
) -> MathspectralmethodTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodTable::sum(self : MathspectralmethodTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodTable::mean(self : MathspectralmethodTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodTable::scale(
  self : MathspectralmethodTable,
  f : Double,
) -> MathspectralmethodTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodTable::add(
  self : MathspectralmethodTable,
  other : MathspectralmethodTable,
) -> MathspectralmethodTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodTable::copy(
  self : MathspectralmethodTable,
) -> MathspectralmethodTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodTable::fill(
  self : MathspectralmethodTable,
  v : Double,
) -> MathspectralmethodTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodTable::min(self : MathspectralmethodTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodTable::max(self : MathspectralmethodTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodTable::to_string(
  self : MathspectralmethodTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_graphn_make(
  size : Int32,
) -> MathspectralmethodGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodGraphN::len(self : MathspectralmethodGraphN) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodGraphN::get(
  self : MathspectralmethodGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodGraphN::set(
  self : MathspectralmethodGraphN,
  i : Int32,
  v : Double,
) -> MathspectralmethodGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodGraphN::sum(self : MathspectralmethodGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodGraphN::mean(
  self : MathspectralmethodGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodGraphN::scale(
  self : MathspectralmethodGraphN,
  f : Double,
) -> MathspectralmethodGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodGraphN::add(
  self : MathspectralmethodGraphN,
  other : MathspectralmethodGraphN,
) -> MathspectralmethodGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodGraphN::copy(
  self : MathspectralmethodGraphN,
) -> MathspectralmethodGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodGraphN::fill(
  self : MathspectralmethodGraphN,
  v : Double,
) -> MathspectralmethodGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodGraphN::min(self : MathspectralmethodGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodGraphN::max(self : MathspectralmethodGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodGraphN::to_string(
  self : MathspectralmethodGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_node_make(size : Int32) -> MathspectralmethodNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodNode::len(self : MathspectralmethodNode) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodNode::get(
  self : MathspectralmethodNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodNode::set(
  self : MathspectralmethodNode,
  i : Int32,
  v : Double,
) -> MathspectralmethodNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodNode::sum(self : MathspectralmethodNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodNode::mean(self : MathspectralmethodNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodNode::scale(
  self : MathspectralmethodNode,
  f : Double,
) -> MathspectralmethodNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodNode::add(
  self : MathspectralmethodNode,
  other : MathspectralmethodNode,
) -> MathspectralmethodNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodNode::copy(
  self : MathspectralmethodNode,
) -> MathspectralmethodNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodNode::fill(
  self : MathspectralmethodNode,
  v : Double,
) -> MathspectralmethodNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodNode::min(self : MathspectralmethodNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodNode::max(self : MathspectralmethodNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodNode::to_string(
  self : MathspectralmethodNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_edge_make(size : Int32) -> MathspectralmethodEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodEdge::len(self : MathspectralmethodEdge) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodEdge::get(
  self : MathspectralmethodEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodEdge::set(
  self : MathspectralmethodEdge,
  i : Int32,
  v : Double,
) -> MathspectralmethodEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodEdge::sum(self : MathspectralmethodEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodEdge::mean(self : MathspectralmethodEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodEdge::scale(
  self : MathspectralmethodEdge,
  f : Double,
) -> MathspectralmethodEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodEdge::add(
  self : MathspectralmethodEdge,
  other : MathspectralmethodEdge,
) -> MathspectralmethodEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodEdge::copy(
  self : MathspectralmethodEdge,
) -> MathspectralmethodEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodEdge::fill(
  self : MathspectralmethodEdge,
  v : Double,
) -> MathspectralmethodEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodEdge::min(self : MathspectralmethodEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodEdge::max(self : MathspectralmethodEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodEdge::to_string(
  self : MathspectralmethodEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_path_make(size : Int32) -> MathspectralmethodPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodPath::len(self : MathspectralmethodPath) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodPath::get(
  self : MathspectralmethodPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodPath::set(
  self : MathspectralmethodPath,
  i : Int32,
  v : Double,
) -> MathspectralmethodPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodPath::sum(self : MathspectralmethodPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodPath::mean(self : MathspectralmethodPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodPath::scale(
  self : MathspectralmethodPath,
  f : Double,
) -> MathspectralmethodPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodPath::add(
  self : MathspectralmethodPath,
  other : MathspectralmethodPath,
) -> MathspectralmethodPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodPath::copy(
  self : MathspectralmethodPath,
) -> MathspectralmethodPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodPath::fill(
  self : MathspectralmethodPath,
  v : Double,
) -> MathspectralmethodPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodPath::min(self : MathspectralmethodPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodPath::max(self : MathspectralmethodPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodPath::to_string(
  self : MathspectralmethodPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_cluster_make(
  size : Int32,
) -> MathspectralmethodCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodCluster::len(
  self : MathspectralmethodCluster,
) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodCluster::get(
  self : MathspectralmethodCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodCluster::set(
  self : MathspectralmethodCluster,
  i : Int32,
  v : Double,
) -> MathspectralmethodCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodCluster::sum(
  self : MathspectralmethodCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodCluster::mean(
  self : MathspectralmethodCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodCluster::scale(
  self : MathspectralmethodCluster,
  f : Double,
) -> MathspectralmethodCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodCluster::add(
  self : MathspectralmethodCluster,
  other : MathspectralmethodCluster,
) -> MathspectralmethodCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodCluster::copy(
  self : MathspectralmethodCluster,
) -> MathspectralmethodCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodCluster::fill(
  self : MathspectralmethodCluster,
  v : Double,
) -> MathspectralmethodCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodCluster::min(
  self : MathspectralmethodCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodCluster::max(
  self : MathspectralmethodCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodCluster::to_string(
  self : MathspectralmethodCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_model_make(size : Int32) -> MathspectralmethodModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodModel::len(self : MathspectralmethodModel) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodModel::get(
  self : MathspectralmethodModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodModel::set(
  self : MathspectralmethodModel,
  i : Int32,
  v : Double,
) -> MathspectralmethodModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodModel::sum(self : MathspectralmethodModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodModel::mean(self : MathspectralmethodModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodModel::scale(
  self : MathspectralmethodModel,
  f : Double,
) -> MathspectralmethodModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodModel::add(
  self : MathspectralmethodModel,
  other : MathspectralmethodModel,
) -> MathspectralmethodModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodModel::copy(
  self : MathspectralmethodModel,
) -> MathspectralmethodModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodModel::fill(
  self : MathspectralmethodModel,
  v : Double,
) -> MathspectralmethodModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodModel::min(self : MathspectralmethodModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodModel::max(self : MathspectralmethodModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodModel::to_string(
  self : MathspectralmethodModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_layer_make(size : Int32) -> MathspectralmethodLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodLayer::len(self : MathspectralmethodLayer) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodLayer::get(
  self : MathspectralmethodLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodLayer::set(
  self : MathspectralmethodLayer,
  i : Int32,
  v : Double,
) -> MathspectralmethodLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodLayer::sum(self : MathspectralmethodLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodLayer::mean(self : MathspectralmethodLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodLayer::scale(
  self : MathspectralmethodLayer,
  f : Double,
) -> MathspectralmethodLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodLayer::add(
  self : MathspectralmethodLayer,
  other : MathspectralmethodLayer,
) -> MathspectralmethodLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodLayer::copy(
  self : MathspectralmethodLayer,
) -> MathspectralmethodLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodLayer::fill(
  self : MathspectralmethodLayer,
  v : Double,
) -> MathspectralmethodLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodLayer::min(self : MathspectralmethodLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodLayer::max(self : MathspectralmethodLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodLayer::to_string(
  self : MathspectralmethodLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_buffer_make(
  size : Int32,
) -> MathspectralmethodBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodBuffer::len(self : MathspectralmethodBuffer) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodBuffer::get(
  self : MathspectralmethodBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodBuffer::set(
  self : MathspectralmethodBuffer,
  i : Int32,
  v : Double,
) -> MathspectralmethodBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodBuffer::sum(self : MathspectralmethodBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodBuffer::mean(
  self : MathspectralmethodBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodBuffer::scale(
  self : MathspectralmethodBuffer,
  f : Double,
) -> MathspectralmethodBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodBuffer::add(
  self : MathspectralmethodBuffer,
  other : MathspectralmethodBuffer,
) -> MathspectralmethodBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodBuffer::copy(
  self : MathspectralmethodBuffer,
) -> MathspectralmethodBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodBuffer::fill(
  self : MathspectralmethodBuffer,
  v : Double,
) -> MathspectralmethodBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodBuffer::min(self : MathspectralmethodBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodBuffer::max(self : MathspectralmethodBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodBuffer::to_string(
  self : MathspectralmethodBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_cursor_make(
  size : Int32,
) -> MathspectralmethodCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodCursor::len(self : MathspectralmethodCursor) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodCursor::get(
  self : MathspectralmethodCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodCursor::set(
  self : MathspectralmethodCursor,
  i : Int32,
  v : Double,
) -> MathspectralmethodCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodCursor::sum(self : MathspectralmethodCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodCursor::mean(
  self : MathspectralmethodCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodCursor::scale(
  self : MathspectralmethodCursor,
  f : Double,
) -> MathspectralmethodCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodCursor::add(
  self : MathspectralmethodCursor,
  other : MathspectralmethodCursor,
) -> MathspectralmethodCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodCursor::copy(
  self : MathspectralmethodCursor,
) -> MathspectralmethodCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodCursor::fill(
  self : MathspectralmethodCursor,
  v : Double,
) -> MathspectralmethodCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodCursor::min(self : MathspectralmethodCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodCursor::max(self : MathspectralmethodCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodCursor::to_string(
  self : MathspectralmethodCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_view_make(size : Int32) -> MathspectralmethodView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodView::len(self : MathspectralmethodView) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodView::get(
  self : MathspectralmethodView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodView::set(
  self : MathspectralmethodView,
  i : Int32,
  v : Double,
) -> MathspectralmethodView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodView::sum(self : MathspectralmethodView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodView::mean(self : MathspectralmethodView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodView::scale(
  self : MathspectralmethodView,
  f : Double,
) -> MathspectralmethodView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodView::add(
  self : MathspectralmethodView,
  other : MathspectralmethodView,
) -> MathspectralmethodView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodView::copy(
  self : MathspectralmethodView,
) -> MathspectralmethodView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodView::fill(
  self : MathspectralmethodView,
  v : Double,
) -> MathspectralmethodView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodView::min(self : MathspectralmethodView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodView::max(self : MathspectralmethodView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodView::to_string(
  self : MathspectralmethodView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_range_make(size : Int32) -> MathspectralmethodRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodRange::len(self : MathspectralmethodRange) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodRange::get(
  self : MathspectralmethodRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodRange::set(
  self : MathspectralmethodRange,
  i : Int32,
  v : Double,
) -> MathspectralmethodRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodRange::sum(self : MathspectralmethodRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodRange::mean(self : MathspectralmethodRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodRange::scale(
  self : MathspectralmethodRange,
  f : Double,
) -> MathspectralmethodRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodRange::add(
  self : MathspectralmethodRange,
  other : MathspectralmethodRange,
) -> MathspectralmethodRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodRange::copy(
  self : MathspectralmethodRange,
) -> MathspectralmethodRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodRange::fill(
  self : MathspectralmethodRange,
  v : Double,
) -> MathspectralmethodRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodRange::min(self : MathspectralmethodRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodRange::max(self : MathspectralmethodRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodRange::to_string(
  self : MathspectralmethodRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspectralmethodSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_spectral_method_slice_make(size : Int32) -> MathspectralmethodSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspectralmethodSlice::len(self : MathspectralmethodSlice) -> Int32 {
  self.size
}

///|
pub fn MathspectralmethodSlice::get(
  self : MathspectralmethodSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspectralmethodSlice::set(
  self : MathspectralmethodSlice,
  i : Int32,
  v : Double,
) -> MathspectralmethodSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodSlice::sum(self : MathspectralmethodSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspectralmethodSlice::mean(self : MathspectralmethodSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspectralmethodSlice::scale(
  self : MathspectralmethodSlice,
  f : Double,
) -> MathspectralmethodSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodSlice::add(
  self : MathspectralmethodSlice,
  other : MathspectralmethodSlice,
) -> MathspectralmethodSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspectralmethodSlice::copy(
  self : MathspectralmethodSlice,
) -> MathspectralmethodSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodSlice::fill(
  self : MathspectralmethodSlice,
  v : Double,
) -> MathspectralmethodSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspectralmethodSlice::min(self : MathspectralmethodSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspectralmethodSlice::max(self : MathspectralmethodSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspectralmethodSlice::to_string(
  self : MathspectralmethodSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
