///|
///===
/// extcore/crypto_sym_chacha
pub(all) struct CryptosymchachaPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn crypto_sym_chacha_make_point(
  x : Double,
  y : Double,
) -> CryptosymchachaPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn crypto_sym_chacha_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> CryptosymchachaPoint {
  { x, y, z, label: 0, }
}

///|
pub fn CryptosymchachaPoint::x(self : CryptosymchachaPoint) -> Double {
  self.x
}

///|
pub fn CryptosymchachaPoint::y(self : CryptosymchachaPoint) -> Double {
  self.y
}

///|
pub fn CryptosymchachaPoint::z(self : CryptosymchachaPoint) -> Double {
  self.z
}

///|
pub fn CryptosymchachaPoint::label(self : CryptosymchachaPoint) -> Int32 {
  self.label
}

///|
pub fn CryptosymchachaPoint::dist(
  self : CryptosymchachaPoint,
  other : CryptosymchachaPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn CryptosymchachaPoint::add(
  self : CryptosymchachaPoint,
  other : CryptosymchachaPoint,
) -> CryptosymchachaPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn CryptosymchachaPoint::sub(
  self : CryptosymchachaPoint,
  other : CryptosymchachaPoint,
) -> CryptosymchachaPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn CryptosymchachaPoint::scale(
  self : CryptosymchachaPoint,
  s : Double,
) -> CryptosymchachaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn CryptosymchachaPoint::dot(
  self : CryptosymchachaPoint,
  other : CryptosymchachaPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn CryptosymchachaPoint::cross(
  self : CryptosymchachaPoint,
  other : CryptosymchachaPoint,
) -> CryptosymchachaPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn CryptosymchachaPoint::norm(self : CryptosymchachaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn CryptosymchachaPoint::normalize(
  self : CryptosymchachaPoint,
) -> CryptosymchachaPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosymchachaPoint::negate(
  self : CryptosymchachaPoint,
) -> CryptosymchachaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn CryptosymchachaPoint::mid(
  self : CryptosymchachaPoint,
  other : CryptosymchachaPoint,
) -> CryptosymchachaPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn CryptosymchachaPoint::lerp(
  self : CryptosymchachaPoint,
  other : CryptosymchachaPoint,
  t : Double,
) -> CryptosymchachaPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn CryptosymchachaPoint::to_string(self : CryptosymchachaPoint) -> String {
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
pub(all) struct CryptosymchachaSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn crypto_sym_chacha_make_series(
  vals : Array[Double],
  name : String,
) -> CryptosymchachaSeries {
  { vals, name, meta: 0, }
}

///|
pub fn CryptosymchachaSeries::len(self : CryptosymchachaSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn CryptosymchachaSeries::sum(self : CryptosymchachaSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn CryptosymchachaSeries::mean(self : CryptosymchachaSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn CryptosymchachaSeries::min(self : CryptosymchachaSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn CryptosymchachaSeries::max(self : CryptosymchachaSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn CryptosymchachaSeries::range(self : CryptosymchachaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn CryptosymchachaSeries::variance(self : CryptosymchachaSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn CryptosymchachaSeries::std(self : CryptosymchachaSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn CryptosymchachaSeries::median(self : CryptosymchachaSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn CryptosymchachaSeries::scale(
  self : CryptosymchachaSeries,
  f : Double,
) -> CryptosymchachaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn CryptosymchachaSeries::add(
  self : CryptosymchachaSeries,
  other : CryptosymchachaSeries,
) -> CryptosymchachaSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosymchachaSeries::sub(
  self : CryptosymchachaSeries,
  other : CryptosymchachaSeries,
) -> CryptosymchachaSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosymchachaSeries::normalize(
  self : CryptosymchachaSeries,
) -> CryptosymchachaSeries {
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
pub fn CryptosymchachaSeries::cumsum(
  self : CryptosymchachaSeries,
) -> CryptosymchachaSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn CryptosymchachaSeries::to_string(self : CryptosymchachaSeries) -> String {
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
pub(all) struct CryptosymchachaMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn crypto_sym_chacha_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> CryptosymchachaMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn crypto_sym_chacha_matrix_identity(n : Int32) -> CryptosymchachaMatrix {
  let m = crypto_sym_chacha_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn CryptosymchachaMatrix::get(
  self : CryptosymchachaMatrix,
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
pub fn CryptosymchachaMatrix::transpose(
  self : CryptosymchachaMatrix,
) -> CryptosymchachaMatrix {
  let result = crypto_sym_chacha_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosymchachaMatrix::add(
  self : CryptosymchachaMatrix,
  other : CryptosymchachaMatrix,
) -> CryptosymchachaMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = crypto_sym_chacha_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosymchachaMatrix::scale(
  self : CryptosymchachaMatrix,
  s : Double,
) -> CryptosymchachaMatrix {
  let result = crypto_sym_chacha_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn CryptosymchachaMatrix::multiply(
  self : CryptosymchachaMatrix,
  other : CryptosymchachaMatrix,
) -> CryptosymchachaMatrix {
  if self.cols != other.rows {
    return crypto_sym_chacha_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = crypto_sym_chacha_make_matrix(self.rows, other.cols, 0.0)
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
pub fn CryptosymchachaMatrix::trace(self : CryptosymchachaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn CryptosymchachaMatrix::det(self : CryptosymchachaMatrix) -> Double {
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
pub fn CryptosymchachaMatrix::norm(self : CryptosymchachaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn CryptosymchachaMatrix::to_string(self : CryptosymchachaMatrix) -> String {
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
pub(all) struct CryptosymchachaVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn crypto_sym_chacha_make_vector(
  comps : Array[Double],
) -> CryptosymchachaVector {
  { comps, dim: comps.length(), }
}

///|
pub fn crypto_sym_chacha_vector_zero(dim : Int32) -> CryptosymchachaVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn CryptosymchachaVector::add(
  self : CryptosymchachaVector,
  other : CryptosymchachaVector,
) -> CryptosymchachaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosymchachaVector::sub(
  self : CryptosymchachaVector,
  other : CryptosymchachaVector,
) -> CryptosymchachaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosymchachaVector::scale(
  self : CryptosymchachaVector,
  s : Double,
) -> CryptosymchachaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn CryptosymchachaVector::dot(
  self : CryptosymchachaVector,
  other : CryptosymchachaVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn CryptosymchachaVector::norm(self : CryptosymchachaVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn CryptosymchachaVector::normalize(
  self : CryptosymchachaVector,
) -> CryptosymchachaVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosymchachaVector::dist(
  self : CryptosymchachaVector,
  other : CryptosymchachaVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn CryptosymchachaVector::to_string(self : CryptosymchachaVector) -> String {
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
pub(all) struct CryptosymchachaFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_frame_make(size : Int32) -> CryptosymchachaFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaFrame::len(self : CryptosymchachaFrame) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaFrame::get(
  self : CryptosymchachaFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaFrame::set(
  self : CryptosymchachaFrame,
  i : Int32,
  v : Double,
) -> CryptosymchachaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaFrame::sum(self : CryptosymchachaFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaFrame::mean(self : CryptosymchachaFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaFrame::scale(
  self : CryptosymchachaFrame,
  f : Double,
) -> CryptosymchachaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaFrame::add(
  self : CryptosymchachaFrame,
  other : CryptosymchachaFrame,
) -> CryptosymchachaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaFrame::copy(
  self : CryptosymchachaFrame,
) -> CryptosymchachaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaFrame::fill(
  self : CryptosymchachaFrame,
  v : Double,
) -> CryptosymchachaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaFrame::min(self : CryptosymchachaFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaFrame::max(self : CryptosymchachaFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaFrame::to_string(self : CryptosymchachaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_table_make(size : Int32) -> CryptosymchachaTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaTable::len(self : CryptosymchachaTable) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaTable::get(
  self : CryptosymchachaTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaTable::set(
  self : CryptosymchachaTable,
  i : Int32,
  v : Double,
) -> CryptosymchachaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaTable::sum(self : CryptosymchachaTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaTable::mean(self : CryptosymchachaTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaTable::scale(
  self : CryptosymchachaTable,
  f : Double,
) -> CryptosymchachaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaTable::add(
  self : CryptosymchachaTable,
  other : CryptosymchachaTable,
) -> CryptosymchachaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaTable::copy(
  self : CryptosymchachaTable,
) -> CryptosymchachaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaTable::fill(
  self : CryptosymchachaTable,
  v : Double,
) -> CryptosymchachaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaTable::min(self : CryptosymchachaTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaTable::max(self : CryptosymchachaTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaTable::to_string(self : CryptosymchachaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_graphn_make(size : Int32) -> CryptosymchachaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaGraphN::len(self : CryptosymchachaGraphN) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaGraphN::get(
  self : CryptosymchachaGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaGraphN::set(
  self : CryptosymchachaGraphN,
  i : Int32,
  v : Double,
) -> CryptosymchachaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaGraphN::sum(self : CryptosymchachaGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaGraphN::mean(self : CryptosymchachaGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaGraphN::scale(
  self : CryptosymchachaGraphN,
  f : Double,
) -> CryptosymchachaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaGraphN::add(
  self : CryptosymchachaGraphN,
  other : CryptosymchachaGraphN,
) -> CryptosymchachaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaGraphN::copy(
  self : CryptosymchachaGraphN,
) -> CryptosymchachaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaGraphN::fill(
  self : CryptosymchachaGraphN,
  v : Double,
) -> CryptosymchachaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaGraphN::min(self : CryptosymchachaGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaGraphN::max(self : CryptosymchachaGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaGraphN::to_string(self : CryptosymchachaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_node_make(size : Int32) -> CryptosymchachaNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaNode::len(self : CryptosymchachaNode) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaNode::get(
  self : CryptosymchachaNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaNode::set(
  self : CryptosymchachaNode,
  i : Int32,
  v : Double,
) -> CryptosymchachaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaNode::sum(self : CryptosymchachaNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaNode::mean(self : CryptosymchachaNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaNode::scale(
  self : CryptosymchachaNode,
  f : Double,
) -> CryptosymchachaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaNode::add(
  self : CryptosymchachaNode,
  other : CryptosymchachaNode,
) -> CryptosymchachaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaNode::copy(
  self : CryptosymchachaNode,
) -> CryptosymchachaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaNode::fill(
  self : CryptosymchachaNode,
  v : Double,
) -> CryptosymchachaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaNode::min(self : CryptosymchachaNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaNode::max(self : CryptosymchachaNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaNode::to_string(self : CryptosymchachaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_edge_make(size : Int32) -> CryptosymchachaEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaEdge::len(self : CryptosymchachaEdge) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaEdge::get(
  self : CryptosymchachaEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaEdge::set(
  self : CryptosymchachaEdge,
  i : Int32,
  v : Double,
) -> CryptosymchachaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaEdge::sum(self : CryptosymchachaEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaEdge::mean(self : CryptosymchachaEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaEdge::scale(
  self : CryptosymchachaEdge,
  f : Double,
) -> CryptosymchachaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaEdge::add(
  self : CryptosymchachaEdge,
  other : CryptosymchachaEdge,
) -> CryptosymchachaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaEdge::copy(
  self : CryptosymchachaEdge,
) -> CryptosymchachaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaEdge::fill(
  self : CryptosymchachaEdge,
  v : Double,
) -> CryptosymchachaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaEdge::min(self : CryptosymchachaEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaEdge::max(self : CryptosymchachaEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaEdge::to_string(self : CryptosymchachaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_path_make(size : Int32) -> CryptosymchachaPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaPath::len(self : CryptosymchachaPath) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaPath::get(
  self : CryptosymchachaPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaPath::set(
  self : CryptosymchachaPath,
  i : Int32,
  v : Double,
) -> CryptosymchachaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaPath::sum(self : CryptosymchachaPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaPath::mean(self : CryptosymchachaPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaPath::scale(
  self : CryptosymchachaPath,
  f : Double,
) -> CryptosymchachaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaPath::add(
  self : CryptosymchachaPath,
  other : CryptosymchachaPath,
) -> CryptosymchachaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaPath::copy(
  self : CryptosymchachaPath,
) -> CryptosymchachaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaPath::fill(
  self : CryptosymchachaPath,
  v : Double,
) -> CryptosymchachaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaPath::min(self : CryptosymchachaPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaPath::max(self : CryptosymchachaPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaPath::to_string(self : CryptosymchachaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_cluster_make(size : Int32) -> CryptosymchachaCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaCluster::len(self : CryptosymchachaCluster) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaCluster::get(
  self : CryptosymchachaCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaCluster::set(
  self : CryptosymchachaCluster,
  i : Int32,
  v : Double,
) -> CryptosymchachaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaCluster::sum(self : CryptosymchachaCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaCluster::mean(self : CryptosymchachaCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaCluster::scale(
  self : CryptosymchachaCluster,
  f : Double,
) -> CryptosymchachaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaCluster::add(
  self : CryptosymchachaCluster,
  other : CryptosymchachaCluster,
) -> CryptosymchachaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaCluster::copy(
  self : CryptosymchachaCluster,
) -> CryptosymchachaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaCluster::fill(
  self : CryptosymchachaCluster,
  v : Double,
) -> CryptosymchachaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaCluster::min(self : CryptosymchachaCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaCluster::max(self : CryptosymchachaCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaCluster::to_string(
  self : CryptosymchachaCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_model_make(size : Int32) -> CryptosymchachaModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaModel::len(self : CryptosymchachaModel) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaModel::get(
  self : CryptosymchachaModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaModel::set(
  self : CryptosymchachaModel,
  i : Int32,
  v : Double,
) -> CryptosymchachaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaModel::sum(self : CryptosymchachaModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaModel::mean(self : CryptosymchachaModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaModel::scale(
  self : CryptosymchachaModel,
  f : Double,
) -> CryptosymchachaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaModel::add(
  self : CryptosymchachaModel,
  other : CryptosymchachaModel,
) -> CryptosymchachaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaModel::copy(
  self : CryptosymchachaModel,
) -> CryptosymchachaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaModel::fill(
  self : CryptosymchachaModel,
  v : Double,
) -> CryptosymchachaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaModel::min(self : CryptosymchachaModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaModel::max(self : CryptosymchachaModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaModel::to_string(self : CryptosymchachaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_layer_make(size : Int32) -> CryptosymchachaLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaLayer::len(self : CryptosymchachaLayer) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaLayer::get(
  self : CryptosymchachaLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaLayer::set(
  self : CryptosymchachaLayer,
  i : Int32,
  v : Double,
) -> CryptosymchachaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaLayer::sum(self : CryptosymchachaLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaLayer::mean(self : CryptosymchachaLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaLayer::scale(
  self : CryptosymchachaLayer,
  f : Double,
) -> CryptosymchachaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaLayer::add(
  self : CryptosymchachaLayer,
  other : CryptosymchachaLayer,
) -> CryptosymchachaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaLayer::copy(
  self : CryptosymchachaLayer,
) -> CryptosymchachaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaLayer::fill(
  self : CryptosymchachaLayer,
  v : Double,
) -> CryptosymchachaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaLayer::min(self : CryptosymchachaLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaLayer::max(self : CryptosymchachaLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaLayer::to_string(self : CryptosymchachaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_buffer_make(size : Int32) -> CryptosymchachaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaBuffer::len(self : CryptosymchachaBuffer) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaBuffer::get(
  self : CryptosymchachaBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaBuffer::set(
  self : CryptosymchachaBuffer,
  i : Int32,
  v : Double,
) -> CryptosymchachaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaBuffer::sum(self : CryptosymchachaBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaBuffer::mean(self : CryptosymchachaBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaBuffer::scale(
  self : CryptosymchachaBuffer,
  f : Double,
) -> CryptosymchachaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaBuffer::add(
  self : CryptosymchachaBuffer,
  other : CryptosymchachaBuffer,
) -> CryptosymchachaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaBuffer::copy(
  self : CryptosymchachaBuffer,
) -> CryptosymchachaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaBuffer::fill(
  self : CryptosymchachaBuffer,
  v : Double,
) -> CryptosymchachaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaBuffer::min(self : CryptosymchachaBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaBuffer::max(self : CryptosymchachaBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaBuffer::to_string(self : CryptosymchachaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_cursor_make(size : Int32) -> CryptosymchachaCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaCursor::len(self : CryptosymchachaCursor) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaCursor::get(
  self : CryptosymchachaCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaCursor::set(
  self : CryptosymchachaCursor,
  i : Int32,
  v : Double,
) -> CryptosymchachaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaCursor::sum(self : CryptosymchachaCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaCursor::mean(self : CryptosymchachaCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaCursor::scale(
  self : CryptosymchachaCursor,
  f : Double,
) -> CryptosymchachaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaCursor::add(
  self : CryptosymchachaCursor,
  other : CryptosymchachaCursor,
) -> CryptosymchachaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaCursor::copy(
  self : CryptosymchachaCursor,
) -> CryptosymchachaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaCursor::fill(
  self : CryptosymchachaCursor,
  v : Double,
) -> CryptosymchachaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaCursor::min(self : CryptosymchachaCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaCursor::max(self : CryptosymchachaCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaCursor::to_string(self : CryptosymchachaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_view_make(size : Int32) -> CryptosymchachaView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaView::len(self : CryptosymchachaView) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaView::get(
  self : CryptosymchachaView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaView::set(
  self : CryptosymchachaView,
  i : Int32,
  v : Double,
) -> CryptosymchachaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaView::sum(self : CryptosymchachaView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaView::mean(self : CryptosymchachaView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaView::scale(
  self : CryptosymchachaView,
  f : Double,
) -> CryptosymchachaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaView::add(
  self : CryptosymchachaView,
  other : CryptosymchachaView,
) -> CryptosymchachaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaView::copy(
  self : CryptosymchachaView,
) -> CryptosymchachaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaView::fill(
  self : CryptosymchachaView,
  v : Double,
) -> CryptosymchachaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaView::min(self : CryptosymchachaView) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaView::max(self : CryptosymchachaView) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaView::to_string(self : CryptosymchachaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_range_make(size : Int32) -> CryptosymchachaRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaRange::len(self : CryptosymchachaRange) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaRange::get(
  self : CryptosymchachaRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaRange::set(
  self : CryptosymchachaRange,
  i : Int32,
  v : Double,
) -> CryptosymchachaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaRange::sum(self : CryptosymchachaRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaRange::mean(self : CryptosymchachaRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaRange::scale(
  self : CryptosymchachaRange,
  f : Double,
) -> CryptosymchachaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaRange::add(
  self : CryptosymchachaRange,
  other : CryptosymchachaRange,
) -> CryptosymchachaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaRange::copy(
  self : CryptosymchachaRange,
) -> CryptosymchachaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaRange::fill(
  self : CryptosymchachaRange,
  v : Double,
) -> CryptosymchachaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaRange::min(self : CryptosymchachaRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaRange::max(self : CryptosymchachaRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaRange::to_string(self : CryptosymchachaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymchachaSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_chacha_slice_make(size : Int32) -> CryptosymchachaSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymchachaSlice::len(self : CryptosymchachaSlice) -> Int32 {
  self.size
}

///|
pub fn CryptosymchachaSlice::get(
  self : CryptosymchachaSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymchachaSlice::set(
  self : CryptosymchachaSlice,
  i : Int32,
  v : Double,
) -> CryptosymchachaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaSlice::sum(self : CryptosymchachaSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymchachaSlice::mean(self : CryptosymchachaSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymchachaSlice::scale(
  self : CryptosymchachaSlice,
  f : Double,
) -> CryptosymchachaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaSlice::add(
  self : CryptosymchachaSlice,
  other : CryptosymchachaSlice,
) -> CryptosymchachaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymchachaSlice::copy(
  self : CryptosymchachaSlice,
) -> CryptosymchachaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaSlice::fill(
  self : CryptosymchachaSlice,
  v : Double,
) -> CryptosymchachaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymchachaSlice::min(self : CryptosymchachaSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymchachaSlice::max(self : CryptosymchachaSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymchachaSlice::to_string(self : CryptosymchachaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
