///|
///===
/// extcore/crypto_sign_ecdsa
pub(all) struct CryptosignecdsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn crypto_sign_ecdsa_make_point(
  x : Double,
  y : Double,
) -> CryptosignecdsaPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn crypto_sign_ecdsa_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> CryptosignecdsaPoint {
  { x, y, z, label: 0, }
}

///|
pub fn CryptosignecdsaPoint::x(self : CryptosignecdsaPoint) -> Double {
  self.x
}

///|
pub fn CryptosignecdsaPoint::y(self : CryptosignecdsaPoint) -> Double {
  self.y
}

///|
pub fn CryptosignecdsaPoint::z(self : CryptosignecdsaPoint) -> Double {
  self.z
}

///|
pub fn CryptosignecdsaPoint::label(self : CryptosignecdsaPoint) -> Int32 {
  self.label
}

///|
pub fn CryptosignecdsaPoint::dist(
  self : CryptosignecdsaPoint,
  other : CryptosignecdsaPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn CryptosignecdsaPoint::add(
  self : CryptosignecdsaPoint,
  other : CryptosignecdsaPoint,
) -> CryptosignecdsaPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn CryptosignecdsaPoint::sub(
  self : CryptosignecdsaPoint,
  other : CryptosignecdsaPoint,
) -> CryptosignecdsaPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn CryptosignecdsaPoint::scale(
  self : CryptosignecdsaPoint,
  s : Double,
) -> CryptosignecdsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn CryptosignecdsaPoint::dot(
  self : CryptosignecdsaPoint,
  other : CryptosignecdsaPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn CryptosignecdsaPoint::cross(
  self : CryptosignecdsaPoint,
  other : CryptosignecdsaPoint,
) -> CryptosignecdsaPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn CryptosignecdsaPoint::norm(self : CryptosignecdsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn CryptosignecdsaPoint::normalize(
  self : CryptosignecdsaPoint,
) -> CryptosignecdsaPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosignecdsaPoint::negate(
  self : CryptosignecdsaPoint,
) -> CryptosignecdsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn CryptosignecdsaPoint::mid(
  self : CryptosignecdsaPoint,
  other : CryptosignecdsaPoint,
) -> CryptosignecdsaPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn CryptosignecdsaPoint::lerp(
  self : CryptosignecdsaPoint,
  other : CryptosignecdsaPoint,
  t : Double,
) -> CryptosignecdsaPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn CryptosignecdsaPoint::to_string(self : CryptosignecdsaPoint) -> String {
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
pub(all) struct CryptosignecdsaSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn crypto_sign_ecdsa_make_series(
  vals : Array[Double],
  name : String,
) -> CryptosignecdsaSeries {
  { vals, name, meta: 0, }
}

///|
pub fn CryptosignecdsaSeries::len(self : CryptosignecdsaSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn CryptosignecdsaSeries::sum(self : CryptosignecdsaSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn CryptosignecdsaSeries::mean(self : CryptosignecdsaSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn CryptosignecdsaSeries::min(self : CryptosignecdsaSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn CryptosignecdsaSeries::max(self : CryptosignecdsaSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn CryptosignecdsaSeries::range(self : CryptosignecdsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn CryptosignecdsaSeries::variance(self : CryptosignecdsaSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn CryptosignecdsaSeries::std(self : CryptosignecdsaSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn CryptosignecdsaSeries::median(self : CryptosignecdsaSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn CryptosignecdsaSeries::scale(
  self : CryptosignecdsaSeries,
  f : Double,
) -> CryptosignecdsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn CryptosignecdsaSeries::add(
  self : CryptosignecdsaSeries,
  other : CryptosignecdsaSeries,
) -> CryptosignecdsaSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosignecdsaSeries::sub(
  self : CryptosignecdsaSeries,
  other : CryptosignecdsaSeries,
) -> CryptosignecdsaSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosignecdsaSeries::normalize(
  self : CryptosignecdsaSeries,
) -> CryptosignecdsaSeries {
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
pub fn CryptosignecdsaSeries::cumsum(
  self : CryptosignecdsaSeries,
) -> CryptosignecdsaSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn CryptosignecdsaSeries::to_string(self : CryptosignecdsaSeries) -> String {
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
pub(all) struct CryptosignecdsaMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn crypto_sign_ecdsa_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> CryptosignecdsaMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn crypto_sign_ecdsa_matrix_identity(n : Int32) -> CryptosignecdsaMatrix {
  let m = crypto_sign_ecdsa_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn CryptosignecdsaMatrix::get(
  self : CryptosignecdsaMatrix,
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
pub fn CryptosignecdsaMatrix::transpose(
  self : CryptosignecdsaMatrix,
) -> CryptosignecdsaMatrix {
  let result = crypto_sign_ecdsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosignecdsaMatrix::add(
  self : CryptosignecdsaMatrix,
  other : CryptosignecdsaMatrix,
) -> CryptosignecdsaMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = crypto_sign_ecdsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosignecdsaMatrix::scale(
  self : CryptosignecdsaMatrix,
  s : Double,
) -> CryptosignecdsaMatrix {
  let result = crypto_sign_ecdsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn CryptosignecdsaMatrix::multiply(
  self : CryptosignecdsaMatrix,
  other : CryptosignecdsaMatrix,
) -> CryptosignecdsaMatrix {
  if self.cols != other.rows {
    return crypto_sign_ecdsa_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = crypto_sign_ecdsa_make_matrix(self.rows, other.cols, 0.0)
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
pub fn CryptosignecdsaMatrix::trace(self : CryptosignecdsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn CryptosignecdsaMatrix::det(self : CryptosignecdsaMatrix) -> Double {
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
pub fn CryptosignecdsaMatrix::norm(self : CryptosignecdsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn CryptosignecdsaMatrix::to_string(self : CryptosignecdsaMatrix) -> String {
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
pub(all) struct CryptosignecdsaVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn crypto_sign_ecdsa_make_vector(
  comps : Array[Double],
) -> CryptosignecdsaVector {
  { comps, dim: comps.length(), }
}

///|
pub fn crypto_sign_ecdsa_vector_zero(dim : Int32) -> CryptosignecdsaVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn CryptosignecdsaVector::add(
  self : CryptosignecdsaVector,
  other : CryptosignecdsaVector,
) -> CryptosignecdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosignecdsaVector::sub(
  self : CryptosignecdsaVector,
  other : CryptosignecdsaVector,
) -> CryptosignecdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosignecdsaVector::scale(
  self : CryptosignecdsaVector,
  s : Double,
) -> CryptosignecdsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn CryptosignecdsaVector::dot(
  self : CryptosignecdsaVector,
  other : CryptosignecdsaVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn CryptosignecdsaVector::norm(self : CryptosignecdsaVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn CryptosignecdsaVector::normalize(
  self : CryptosignecdsaVector,
) -> CryptosignecdsaVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosignecdsaVector::dist(
  self : CryptosignecdsaVector,
  other : CryptosignecdsaVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn CryptosignecdsaVector::to_string(self : CryptosignecdsaVector) -> String {
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
pub(all) struct CryptosignecdsaFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_frame_make(size : Int32) -> CryptosignecdsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaFrame::len(self : CryptosignecdsaFrame) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaFrame::get(
  self : CryptosignecdsaFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaFrame::set(
  self : CryptosignecdsaFrame,
  i : Int32,
  v : Double,
) -> CryptosignecdsaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaFrame::sum(self : CryptosignecdsaFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaFrame::mean(self : CryptosignecdsaFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaFrame::scale(
  self : CryptosignecdsaFrame,
  f : Double,
) -> CryptosignecdsaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaFrame::add(
  self : CryptosignecdsaFrame,
  other : CryptosignecdsaFrame,
) -> CryptosignecdsaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaFrame::copy(
  self : CryptosignecdsaFrame,
) -> CryptosignecdsaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaFrame::fill(
  self : CryptosignecdsaFrame,
  v : Double,
) -> CryptosignecdsaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaFrame::min(self : CryptosignecdsaFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaFrame::max(self : CryptosignecdsaFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaFrame::to_string(self : CryptosignecdsaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_table_make(size : Int32) -> CryptosignecdsaTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaTable::len(self : CryptosignecdsaTable) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaTable::get(
  self : CryptosignecdsaTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaTable::set(
  self : CryptosignecdsaTable,
  i : Int32,
  v : Double,
) -> CryptosignecdsaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaTable::sum(self : CryptosignecdsaTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaTable::mean(self : CryptosignecdsaTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaTable::scale(
  self : CryptosignecdsaTable,
  f : Double,
) -> CryptosignecdsaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaTable::add(
  self : CryptosignecdsaTable,
  other : CryptosignecdsaTable,
) -> CryptosignecdsaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaTable::copy(
  self : CryptosignecdsaTable,
) -> CryptosignecdsaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaTable::fill(
  self : CryptosignecdsaTable,
  v : Double,
) -> CryptosignecdsaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaTable::min(self : CryptosignecdsaTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaTable::max(self : CryptosignecdsaTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaTable::to_string(self : CryptosignecdsaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_graphn_make(size : Int32) -> CryptosignecdsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaGraphN::len(self : CryptosignecdsaGraphN) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaGraphN::get(
  self : CryptosignecdsaGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaGraphN::set(
  self : CryptosignecdsaGraphN,
  i : Int32,
  v : Double,
) -> CryptosignecdsaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaGraphN::sum(self : CryptosignecdsaGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaGraphN::mean(self : CryptosignecdsaGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaGraphN::scale(
  self : CryptosignecdsaGraphN,
  f : Double,
) -> CryptosignecdsaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaGraphN::add(
  self : CryptosignecdsaGraphN,
  other : CryptosignecdsaGraphN,
) -> CryptosignecdsaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaGraphN::copy(
  self : CryptosignecdsaGraphN,
) -> CryptosignecdsaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaGraphN::fill(
  self : CryptosignecdsaGraphN,
  v : Double,
) -> CryptosignecdsaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaGraphN::min(self : CryptosignecdsaGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaGraphN::max(self : CryptosignecdsaGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaGraphN::to_string(self : CryptosignecdsaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_node_make(size : Int32) -> CryptosignecdsaNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaNode::len(self : CryptosignecdsaNode) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaNode::get(
  self : CryptosignecdsaNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaNode::set(
  self : CryptosignecdsaNode,
  i : Int32,
  v : Double,
) -> CryptosignecdsaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaNode::sum(self : CryptosignecdsaNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaNode::mean(self : CryptosignecdsaNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaNode::scale(
  self : CryptosignecdsaNode,
  f : Double,
) -> CryptosignecdsaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaNode::add(
  self : CryptosignecdsaNode,
  other : CryptosignecdsaNode,
) -> CryptosignecdsaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaNode::copy(
  self : CryptosignecdsaNode,
) -> CryptosignecdsaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaNode::fill(
  self : CryptosignecdsaNode,
  v : Double,
) -> CryptosignecdsaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaNode::min(self : CryptosignecdsaNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaNode::max(self : CryptosignecdsaNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaNode::to_string(self : CryptosignecdsaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_edge_make(size : Int32) -> CryptosignecdsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaEdge::len(self : CryptosignecdsaEdge) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaEdge::get(
  self : CryptosignecdsaEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaEdge::set(
  self : CryptosignecdsaEdge,
  i : Int32,
  v : Double,
) -> CryptosignecdsaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaEdge::sum(self : CryptosignecdsaEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaEdge::mean(self : CryptosignecdsaEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaEdge::scale(
  self : CryptosignecdsaEdge,
  f : Double,
) -> CryptosignecdsaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaEdge::add(
  self : CryptosignecdsaEdge,
  other : CryptosignecdsaEdge,
) -> CryptosignecdsaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaEdge::copy(
  self : CryptosignecdsaEdge,
) -> CryptosignecdsaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaEdge::fill(
  self : CryptosignecdsaEdge,
  v : Double,
) -> CryptosignecdsaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaEdge::min(self : CryptosignecdsaEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaEdge::max(self : CryptosignecdsaEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaEdge::to_string(self : CryptosignecdsaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_path_make(size : Int32) -> CryptosignecdsaPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaPath::len(self : CryptosignecdsaPath) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaPath::get(
  self : CryptosignecdsaPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaPath::set(
  self : CryptosignecdsaPath,
  i : Int32,
  v : Double,
) -> CryptosignecdsaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaPath::sum(self : CryptosignecdsaPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaPath::mean(self : CryptosignecdsaPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaPath::scale(
  self : CryptosignecdsaPath,
  f : Double,
) -> CryptosignecdsaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaPath::add(
  self : CryptosignecdsaPath,
  other : CryptosignecdsaPath,
) -> CryptosignecdsaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaPath::copy(
  self : CryptosignecdsaPath,
) -> CryptosignecdsaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaPath::fill(
  self : CryptosignecdsaPath,
  v : Double,
) -> CryptosignecdsaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaPath::min(self : CryptosignecdsaPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaPath::max(self : CryptosignecdsaPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaPath::to_string(self : CryptosignecdsaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_cluster_make(size : Int32) -> CryptosignecdsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaCluster::len(self : CryptosignecdsaCluster) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaCluster::get(
  self : CryptosignecdsaCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaCluster::set(
  self : CryptosignecdsaCluster,
  i : Int32,
  v : Double,
) -> CryptosignecdsaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaCluster::sum(self : CryptosignecdsaCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaCluster::mean(self : CryptosignecdsaCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaCluster::scale(
  self : CryptosignecdsaCluster,
  f : Double,
) -> CryptosignecdsaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaCluster::add(
  self : CryptosignecdsaCluster,
  other : CryptosignecdsaCluster,
) -> CryptosignecdsaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaCluster::copy(
  self : CryptosignecdsaCluster,
) -> CryptosignecdsaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaCluster::fill(
  self : CryptosignecdsaCluster,
  v : Double,
) -> CryptosignecdsaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaCluster::min(self : CryptosignecdsaCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaCluster::max(self : CryptosignecdsaCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaCluster::to_string(
  self : CryptosignecdsaCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_model_make(size : Int32) -> CryptosignecdsaModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaModel::len(self : CryptosignecdsaModel) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaModel::get(
  self : CryptosignecdsaModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaModel::set(
  self : CryptosignecdsaModel,
  i : Int32,
  v : Double,
) -> CryptosignecdsaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaModel::sum(self : CryptosignecdsaModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaModel::mean(self : CryptosignecdsaModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaModel::scale(
  self : CryptosignecdsaModel,
  f : Double,
) -> CryptosignecdsaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaModel::add(
  self : CryptosignecdsaModel,
  other : CryptosignecdsaModel,
) -> CryptosignecdsaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaModel::copy(
  self : CryptosignecdsaModel,
) -> CryptosignecdsaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaModel::fill(
  self : CryptosignecdsaModel,
  v : Double,
) -> CryptosignecdsaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaModel::min(self : CryptosignecdsaModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaModel::max(self : CryptosignecdsaModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaModel::to_string(self : CryptosignecdsaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_layer_make(size : Int32) -> CryptosignecdsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaLayer::len(self : CryptosignecdsaLayer) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaLayer::get(
  self : CryptosignecdsaLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaLayer::set(
  self : CryptosignecdsaLayer,
  i : Int32,
  v : Double,
) -> CryptosignecdsaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaLayer::sum(self : CryptosignecdsaLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaLayer::mean(self : CryptosignecdsaLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaLayer::scale(
  self : CryptosignecdsaLayer,
  f : Double,
) -> CryptosignecdsaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaLayer::add(
  self : CryptosignecdsaLayer,
  other : CryptosignecdsaLayer,
) -> CryptosignecdsaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaLayer::copy(
  self : CryptosignecdsaLayer,
) -> CryptosignecdsaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaLayer::fill(
  self : CryptosignecdsaLayer,
  v : Double,
) -> CryptosignecdsaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaLayer::min(self : CryptosignecdsaLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaLayer::max(self : CryptosignecdsaLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaLayer::to_string(self : CryptosignecdsaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_buffer_make(size : Int32) -> CryptosignecdsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaBuffer::len(self : CryptosignecdsaBuffer) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaBuffer::get(
  self : CryptosignecdsaBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaBuffer::set(
  self : CryptosignecdsaBuffer,
  i : Int32,
  v : Double,
) -> CryptosignecdsaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaBuffer::sum(self : CryptosignecdsaBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaBuffer::mean(self : CryptosignecdsaBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaBuffer::scale(
  self : CryptosignecdsaBuffer,
  f : Double,
) -> CryptosignecdsaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaBuffer::add(
  self : CryptosignecdsaBuffer,
  other : CryptosignecdsaBuffer,
) -> CryptosignecdsaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaBuffer::copy(
  self : CryptosignecdsaBuffer,
) -> CryptosignecdsaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaBuffer::fill(
  self : CryptosignecdsaBuffer,
  v : Double,
) -> CryptosignecdsaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaBuffer::min(self : CryptosignecdsaBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaBuffer::max(self : CryptosignecdsaBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaBuffer::to_string(self : CryptosignecdsaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_cursor_make(size : Int32) -> CryptosignecdsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaCursor::len(self : CryptosignecdsaCursor) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaCursor::get(
  self : CryptosignecdsaCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaCursor::set(
  self : CryptosignecdsaCursor,
  i : Int32,
  v : Double,
) -> CryptosignecdsaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaCursor::sum(self : CryptosignecdsaCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaCursor::mean(self : CryptosignecdsaCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaCursor::scale(
  self : CryptosignecdsaCursor,
  f : Double,
) -> CryptosignecdsaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaCursor::add(
  self : CryptosignecdsaCursor,
  other : CryptosignecdsaCursor,
) -> CryptosignecdsaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaCursor::copy(
  self : CryptosignecdsaCursor,
) -> CryptosignecdsaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaCursor::fill(
  self : CryptosignecdsaCursor,
  v : Double,
) -> CryptosignecdsaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaCursor::min(self : CryptosignecdsaCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaCursor::max(self : CryptosignecdsaCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaCursor::to_string(self : CryptosignecdsaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_view_make(size : Int32) -> CryptosignecdsaView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaView::len(self : CryptosignecdsaView) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaView::get(
  self : CryptosignecdsaView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaView::set(
  self : CryptosignecdsaView,
  i : Int32,
  v : Double,
) -> CryptosignecdsaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaView::sum(self : CryptosignecdsaView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaView::mean(self : CryptosignecdsaView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaView::scale(
  self : CryptosignecdsaView,
  f : Double,
) -> CryptosignecdsaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaView::add(
  self : CryptosignecdsaView,
  other : CryptosignecdsaView,
) -> CryptosignecdsaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaView::copy(
  self : CryptosignecdsaView,
) -> CryptosignecdsaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaView::fill(
  self : CryptosignecdsaView,
  v : Double,
) -> CryptosignecdsaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaView::min(self : CryptosignecdsaView) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaView::max(self : CryptosignecdsaView) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaView::to_string(self : CryptosignecdsaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_range_make(size : Int32) -> CryptosignecdsaRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaRange::len(self : CryptosignecdsaRange) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaRange::get(
  self : CryptosignecdsaRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaRange::set(
  self : CryptosignecdsaRange,
  i : Int32,
  v : Double,
) -> CryptosignecdsaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaRange::sum(self : CryptosignecdsaRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaRange::mean(self : CryptosignecdsaRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaRange::scale(
  self : CryptosignecdsaRange,
  f : Double,
) -> CryptosignecdsaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaRange::add(
  self : CryptosignecdsaRange,
  other : CryptosignecdsaRange,
) -> CryptosignecdsaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaRange::copy(
  self : CryptosignecdsaRange,
) -> CryptosignecdsaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaRange::fill(
  self : CryptosignecdsaRange,
  v : Double,
) -> CryptosignecdsaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaRange::min(self : CryptosignecdsaRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaRange::max(self : CryptosignecdsaRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaRange::to_string(self : CryptosignecdsaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignecdsaSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ecdsa_slice_make(size : Int32) -> CryptosignecdsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignecdsaSlice::len(self : CryptosignecdsaSlice) -> Int32 {
  self.size
}

///|
pub fn CryptosignecdsaSlice::get(
  self : CryptosignecdsaSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignecdsaSlice::set(
  self : CryptosignecdsaSlice,
  i : Int32,
  v : Double,
) -> CryptosignecdsaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaSlice::sum(self : CryptosignecdsaSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignecdsaSlice::mean(self : CryptosignecdsaSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignecdsaSlice::scale(
  self : CryptosignecdsaSlice,
  f : Double,
) -> CryptosignecdsaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaSlice::add(
  self : CryptosignecdsaSlice,
  other : CryptosignecdsaSlice,
) -> CryptosignecdsaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignecdsaSlice::copy(
  self : CryptosignecdsaSlice,
) -> CryptosignecdsaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaSlice::fill(
  self : CryptosignecdsaSlice,
  v : Double,
) -> CryptosignecdsaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignecdsaSlice::min(self : CryptosignecdsaSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignecdsaSlice::max(self : CryptosignecdsaSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignecdsaSlice::to_string(self : CryptosignecdsaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
