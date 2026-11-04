///|
///===
/// extcore/crypto_asym_ecdsa
pub(all) struct CryptoasymecdsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn crypto_asym_ecdsa_make_point(
  x : Double,
  y : Double,
) -> CryptoasymecdsaPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn crypto_asym_ecdsa_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> CryptoasymecdsaPoint {
  { x, y, z, label: 0, }
}

///|
pub fn CryptoasymecdsaPoint::x(self : CryptoasymecdsaPoint) -> Double {
  self.x
}

///|
pub fn CryptoasymecdsaPoint::y(self : CryptoasymecdsaPoint) -> Double {
  self.y
}

///|
pub fn CryptoasymecdsaPoint::z(self : CryptoasymecdsaPoint) -> Double {
  self.z
}

///|
pub fn CryptoasymecdsaPoint::label(self : CryptoasymecdsaPoint) -> Int32 {
  self.label
}

///|
pub fn CryptoasymecdsaPoint::dist(
  self : CryptoasymecdsaPoint,
  other : CryptoasymecdsaPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn CryptoasymecdsaPoint::add(
  self : CryptoasymecdsaPoint,
  other : CryptoasymecdsaPoint,
) -> CryptoasymecdsaPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn CryptoasymecdsaPoint::sub(
  self : CryptoasymecdsaPoint,
  other : CryptoasymecdsaPoint,
) -> CryptoasymecdsaPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn CryptoasymecdsaPoint::scale(
  self : CryptoasymecdsaPoint,
  s : Double,
) -> CryptoasymecdsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn CryptoasymecdsaPoint::dot(
  self : CryptoasymecdsaPoint,
  other : CryptoasymecdsaPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn CryptoasymecdsaPoint::cross(
  self : CryptoasymecdsaPoint,
  other : CryptoasymecdsaPoint,
) -> CryptoasymecdsaPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn CryptoasymecdsaPoint::norm(self : CryptoasymecdsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn CryptoasymecdsaPoint::normalize(
  self : CryptoasymecdsaPoint,
) -> CryptoasymecdsaPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptoasymecdsaPoint::negate(
  self : CryptoasymecdsaPoint,
) -> CryptoasymecdsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn CryptoasymecdsaPoint::mid(
  self : CryptoasymecdsaPoint,
  other : CryptoasymecdsaPoint,
) -> CryptoasymecdsaPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn CryptoasymecdsaPoint::lerp(
  self : CryptoasymecdsaPoint,
  other : CryptoasymecdsaPoint,
  t : Double,
) -> CryptoasymecdsaPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn CryptoasymecdsaPoint::to_string(self : CryptoasymecdsaPoint) -> String {
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
pub(all) struct CryptoasymecdsaSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn crypto_asym_ecdsa_make_series(
  vals : Array[Double],
  name : String,
) -> CryptoasymecdsaSeries {
  { vals, name, meta: 0, }
}

///|
pub fn CryptoasymecdsaSeries::len(self : CryptoasymecdsaSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn CryptoasymecdsaSeries::sum(self : CryptoasymecdsaSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn CryptoasymecdsaSeries::mean(self : CryptoasymecdsaSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn CryptoasymecdsaSeries::min(self : CryptoasymecdsaSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn CryptoasymecdsaSeries::max(self : CryptoasymecdsaSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn CryptoasymecdsaSeries::range(self : CryptoasymecdsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn CryptoasymecdsaSeries::variance(self : CryptoasymecdsaSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn CryptoasymecdsaSeries::std(self : CryptoasymecdsaSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn CryptoasymecdsaSeries::median(self : CryptoasymecdsaSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn CryptoasymecdsaSeries::scale(
  self : CryptoasymecdsaSeries,
  f : Double,
) -> CryptoasymecdsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn CryptoasymecdsaSeries::add(
  self : CryptoasymecdsaSeries,
  other : CryptoasymecdsaSeries,
) -> CryptoasymecdsaSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptoasymecdsaSeries::sub(
  self : CryptoasymecdsaSeries,
  other : CryptoasymecdsaSeries,
) -> CryptoasymecdsaSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptoasymecdsaSeries::normalize(
  self : CryptoasymecdsaSeries,
) -> CryptoasymecdsaSeries {
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
pub fn CryptoasymecdsaSeries::cumsum(
  self : CryptoasymecdsaSeries,
) -> CryptoasymecdsaSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn CryptoasymecdsaSeries::to_string(self : CryptoasymecdsaSeries) -> String {
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
pub(all) struct CryptoasymecdsaMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn crypto_asym_ecdsa_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> CryptoasymecdsaMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn crypto_asym_ecdsa_matrix_identity(n : Int32) -> CryptoasymecdsaMatrix {
  let m = crypto_asym_ecdsa_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn CryptoasymecdsaMatrix::get(
  self : CryptoasymecdsaMatrix,
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
pub fn CryptoasymecdsaMatrix::transpose(
  self : CryptoasymecdsaMatrix,
) -> CryptoasymecdsaMatrix {
  let result = crypto_asym_ecdsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn CryptoasymecdsaMatrix::add(
  self : CryptoasymecdsaMatrix,
  other : CryptoasymecdsaMatrix,
) -> CryptoasymecdsaMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = crypto_asym_ecdsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn CryptoasymecdsaMatrix::scale(
  self : CryptoasymecdsaMatrix,
  s : Double,
) -> CryptoasymecdsaMatrix {
  let result = crypto_asym_ecdsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn CryptoasymecdsaMatrix::multiply(
  self : CryptoasymecdsaMatrix,
  other : CryptoasymecdsaMatrix,
) -> CryptoasymecdsaMatrix {
  if self.cols != other.rows {
    return crypto_asym_ecdsa_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = crypto_asym_ecdsa_make_matrix(self.rows, other.cols, 0.0)
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
pub fn CryptoasymecdsaMatrix::trace(self : CryptoasymecdsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn CryptoasymecdsaMatrix::det(self : CryptoasymecdsaMatrix) -> Double {
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
pub fn CryptoasymecdsaMatrix::norm(self : CryptoasymecdsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn CryptoasymecdsaMatrix::to_string(self : CryptoasymecdsaMatrix) -> String {
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
pub(all) struct CryptoasymecdsaVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn crypto_asym_ecdsa_make_vector(
  comps : Array[Double],
) -> CryptoasymecdsaVector {
  { comps, dim: comps.length(), }
}

///|
pub fn crypto_asym_ecdsa_vector_zero(dim : Int32) -> CryptoasymecdsaVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn CryptoasymecdsaVector::add(
  self : CryptoasymecdsaVector,
  other : CryptoasymecdsaVector,
) -> CryptoasymecdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptoasymecdsaVector::sub(
  self : CryptoasymecdsaVector,
  other : CryptoasymecdsaVector,
) -> CryptoasymecdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptoasymecdsaVector::scale(
  self : CryptoasymecdsaVector,
  s : Double,
) -> CryptoasymecdsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn CryptoasymecdsaVector::dot(
  self : CryptoasymecdsaVector,
  other : CryptoasymecdsaVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn CryptoasymecdsaVector::norm(self : CryptoasymecdsaVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn CryptoasymecdsaVector::normalize(
  self : CryptoasymecdsaVector,
) -> CryptoasymecdsaVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptoasymecdsaVector::dist(
  self : CryptoasymecdsaVector,
  other : CryptoasymecdsaVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn CryptoasymecdsaVector::to_string(self : CryptoasymecdsaVector) -> String {
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
pub(all) struct CryptoasymecdsaFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_frame_make(size : Int32) -> CryptoasymecdsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaFrame::len(self : CryptoasymecdsaFrame) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaFrame::get(
  self : CryptoasymecdsaFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaFrame::set(
  self : CryptoasymecdsaFrame,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaFrame::sum(self : CryptoasymecdsaFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaFrame::mean(self : CryptoasymecdsaFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaFrame::scale(
  self : CryptoasymecdsaFrame,
  f : Double,
) -> CryptoasymecdsaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaFrame::add(
  self : CryptoasymecdsaFrame,
  other : CryptoasymecdsaFrame,
) -> CryptoasymecdsaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaFrame::copy(
  self : CryptoasymecdsaFrame,
) -> CryptoasymecdsaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaFrame::fill(
  self : CryptoasymecdsaFrame,
  v : Double,
) -> CryptoasymecdsaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaFrame::min(self : CryptoasymecdsaFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaFrame::max(self : CryptoasymecdsaFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaFrame::to_string(self : CryptoasymecdsaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_table_make(size : Int32) -> CryptoasymecdsaTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaTable::len(self : CryptoasymecdsaTable) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaTable::get(
  self : CryptoasymecdsaTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaTable::set(
  self : CryptoasymecdsaTable,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaTable::sum(self : CryptoasymecdsaTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaTable::mean(self : CryptoasymecdsaTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaTable::scale(
  self : CryptoasymecdsaTable,
  f : Double,
) -> CryptoasymecdsaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaTable::add(
  self : CryptoasymecdsaTable,
  other : CryptoasymecdsaTable,
) -> CryptoasymecdsaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaTable::copy(
  self : CryptoasymecdsaTable,
) -> CryptoasymecdsaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaTable::fill(
  self : CryptoasymecdsaTable,
  v : Double,
) -> CryptoasymecdsaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaTable::min(self : CryptoasymecdsaTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaTable::max(self : CryptoasymecdsaTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaTable::to_string(self : CryptoasymecdsaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_graphn_make(size : Int32) -> CryptoasymecdsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaGraphN::len(self : CryptoasymecdsaGraphN) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaGraphN::get(
  self : CryptoasymecdsaGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaGraphN::set(
  self : CryptoasymecdsaGraphN,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaGraphN::sum(self : CryptoasymecdsaGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaGraphN::mean(self : CryptoasymecdsaGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaGraphN::scale(
  self : CryptoasymecdsaGraphN,
  f : Double,
) -> CryptoasymecdsaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaGraphN::add(
  self : CryptoasymecdsaGraphN,
  other : CryptoasymecdsaGraphN,
) -> CryptoasymecdsaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaGraphN::copy(
  self : CryptoasymecdsaGraphN,
) -> CryptoasymecdsaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaGraphN::fill(
  self : CryptoasymecdsaGraphN,
  v : Double,
) -> CryptoasymecdsaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaGraphN::min(self : CryptoasymecdsaGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaGraphN::max(self : CryptoasymecdsaGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaGraphN::to_string(self : CryptoasymecdsaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_node_make(size : Int32) -> CryptoasymecdsaNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaNode::len(self : CryptoasymecdsaNode) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaNode::get(
  self : CryptoasymecdsaNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaNode::set(
  self : CryptoasymecdsaNode,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaNode::sum(self : CryptoasymecdsaNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaNode::mean(self : CryptoasymecdsaNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaNode::scale(
  self : CryptoasymecdsaNode,
  f : Double,
) -> CryptoasymecdsaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaNode::add(
  self : CryptoasymecdsaNode,
  other : CryptoasymecdsaNode,
) -> CryptoasymecdsaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaNode::copy(
  self : CryptoasymecdsaNode,
) -> CryptoasymecdsaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaNode::fill(
  self : CryptoasymecdsaNode,
  v : Double,
) -> CryptoasymecdsaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaNode::min(self : CryptoasymecdsaNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaNode::max(self : CryptoasymecdsaNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaNode::to_string(self : CryptoasymecdsaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_edge_make(size : Int32) -> CryptoasymecdsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaEdge::len(self : CryptoasymecdsaEdge) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaEdge::get(
  self : CryptoasymecdsaEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaEdge::set(
  self : CryptoasymecdsaEdge,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaEdge::sum(self : CryptoasymecdsaEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaEdge::mean(self : CryptoasymecdsaEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaEdge::scale(
  self : CryptoasymecdsaEdge,
  f : Double,
) -> CryptoasymecdsaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaEdge::add(
  self : CryptoasymecdsaEdge,
  other : CryptoasymecdsaEdge,
) -> CryptoasymecdsaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaEdge::copy(
  self : CryptoasymecdsaEdge,
) -> CryptoasymecdsaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaEdge::fill(
  self : CryptoasymecdsaEdge,
  v : Double,
) -> CryptoasymecdsaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaEdge::min(self : CryptoasymecdsaEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaEdge::max(self : CryptoasymecdsaEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaEdge::to_string(self : CryptoasymecdsaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_path_make(size : Int32) -> CryptoasymecdsaPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaPath::len(self : CryptoasymecdsaPath) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaPath::get(
  self : CryptoasymecdsaPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaPath::set(
  self : CryptoasymecdsaPath,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaPath::sum(self : CryptoasymecdsaPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaPath::mean(self : CryptoasymecdsaPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaPath::scale(
  self : CryptoasymecdsaPath,
  f : Double,
) -> CryptoasymecdsaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaPath::add(
  self : CryptoasymecdsaPath,
  other : CryptoasymecdsaPath,
) -> CryptoasymecdsaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaPath::copy(
  self : CryptoasymecdsaPath,
) -> CryptoasymecdsaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaPath::fill(
  self : CryptoasymecdsaPath,
  v : Double,
) -> CryptoasymecdsaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaPath::min(self : CryptoasymecdsaPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaPath::max(self : CryptoasymecdsaPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaPath::to_string(self : CryptoasymecdsaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_cluster_make(size : Int32) -> CryptoasymecdsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaCluster::len(self : CryptoasymecdsaCluster) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaCluster::get(
  self : CryptoasymecdsaCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaCluster::set(
  self : CryptoasymecdsaCluster,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaCluster::sum(self : CryptoasymecdsaCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaCluster::mean(self : CryptoasymecdsaCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaCluster::scale(
  self : CryptoasymecdsaCluster,
  f : Double,
) -> CryptoasymecdsaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaCluster::add(
  self : CryptoasymecdsaCluster,
  other : CryptoasymecdsaCluster,
) -> CryptoasymecdsaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaCluster::copy(
  self : CryptoasymecdsaCluster,
) -> CryptoasymecdsaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaCluster::fill(
  self : CryptoasymecdsaCluster,
  v : Double,
) -> CryptoasymecdsaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaCluster::min(self : CryptoasymecdsaCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaCluster::max(self : CryptoasymecdsaCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaCluster::to_string(
  self : CryptoasymecdsaCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_model_make(size : Int32) -> CryptoasymecdsaModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaModel::len(self : CryptoasymecdsaModel) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaModel::get(
  self : CryptoasymecdsaModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaModel::set(
  self : CryptoasymecdsaModel,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaModel::sum(self : CryptoasymecdsaModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaModel::mean(self : CryptoasymecdsaModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaModel::scale(
  self : CryptoasymecdsaModel,
  f : Double,
) -> CryptoasymecdsaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaModel::add(
  self : CryptoasymecdsaModel,
  other : CryptoasymecdsaModel,
) -> CryptoasymecdsaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaModel::copy(
  self : CryptoasymecdsaModel,
) -> CryptoasymecdsaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaModel::fill(
  self : CryptoasymecdsaModel,
  v : Double,
) -> CryptoasymecdsaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaModel::min(self : CryptoasymecdsaModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaModel::max(self : CryptoasymecdsaModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaModel::to_string(self : CryptoasymecdsaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_layer_make(size : Int32) -> CryptoasymecdsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaLayer::len(self : CryptoasymecdsaLayer) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaLayer::get(
  self : CryptoasymecdsaLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaLayer::set(
  self : CryptoasymecdsaLayer,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaLayer::sum(self : CryptoasymecdsaLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaLayer::mean(self : CryptoasymecdsaLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaLayer::scale(
  self : CryptoasymecdsaLayer,
  f : Double,
) -> CryptoasymecdsaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaLayer::add(
  self : CryptoasymecdsaLayer,
  other : CryptoasymecdsaLayer,
) -> CryptoasymecdsaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaLayer::copy(
  self : CryptoasymecdsaLayer,
) -> CryptoasymecdsaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaLayer::fill(
  self : CryptoasymecdsaLayer,
  v : Double,
) -> CryptoasymecdsaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaLayer::min(self : CryptoasymecdsaLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaLayer::max(self : CryptoasymecdsaLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaLayer::to_string(self : CryptoasymecdsaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_buffer_make(size : Int32) -> CryptoasymecdsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaBuffer::len(self : CryptoasymecdsaBuffer) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaBuffer::get(
  self : CryptoasymecdsaBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaBuffer::set(
  self : CryptoasymecdsaBuffer,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaBuffer::sum(self : CryptoasymecdsaBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaBuffer::mean(self : CryptoasymecdsaBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaBuffer::scale(
  self : CryptoasymecdsaBuffer,
  f : Double,
) -> CryptoasymecdsaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaBuffer::add(
  self : CryptoasymecdsaBuffer,
  other : CryptoasymecdsaBuffer,
) -> CryptoasymecdsaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaBuffer::copy(
  self : CryptoasymecdsaBuffer,
) -> CryptoasymecdsaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaBuffer::fill(
  self : CryptoasymecdsaBuffer,
  v : Double,
) -> CryptoasymecdsaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaBuffer::min(self : CryptoasymecdsaBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaBuffer::max(self : CryptoasymecdsaBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaBuffer::to_string(self : CryptoasymecdsaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_cursor_make(size : Int32) -> CryptoasymecdsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaCursor::len(self : CryptoasymecdsaCursor) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaCursor::get(
  self : CryptoasymecdsaCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaCursor::set(
  self : CryptoasymecdsaCursor,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaCursor::sum(self : CryptoasymecdsaCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaCursor::mean(self : CryptoasymecdsaCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaCursor::scale(
  self : CryptoasymecdsaCursor,
  f : Double,
) -> CryptoasymecdsaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaCursor::add(
  self : CryptoasymecdsaCursor,
  other : CryptoasymecdsaCursor,
) -> CryptoasymecdsaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaCursor::copy(
  self : CryptoasymecdsaCursor,
) -> CryptoasymecdsaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaCursor::fill(
  self : CryptoasymecdsaCursor,
  v : Double,
) -> CryptoasymecdsaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaCursor::min(self : CryptoasymecdsaCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaCursor::max(self : CryptoasymecdsaCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaCursor::to_string(self : CryptoasymecdsaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_view_make(size : Int32) -> CryptoasymecdsaView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaView::len(self : CryptoasymecdsaView) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaView::get(
  self : CryptoasymecdsaView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaView::set(
  self : CryptoasymecdsaView,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaView::sum(self : CryptoasymecdsaView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaView::mean(self : CryptoasymecdsaView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaView::scale(
  self : CryptoasymecdsaView,
  f : Double,
) -> CryptoasymecdsaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaView::add(
  self : CryptoasymecdsaView,
  other : CryptoasymecdsaView,
) -> CryptoasymecdsaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaView::copy(
  self : CryptoasymecdsaView,
) -> CryptoasymecdsaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaView::fill(
  self : CryptoasymecdsaView,
  v : Double,
) -> CryptoasymecdsaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaView::min(self : CryptoasymecdsaView) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaView::max(self : CryptoasymecdsaView) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaView::to_string(self : CryptoasymecdsaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_range_make(size : Int32) -> CryptoasymecdsaRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaRange::len(self : CryptoasymecdsaRange) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaRange::get(
  self : CryptoasymecdsaRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaRange::set(
  self : CryptoasymecdsaRange,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaRange::sum(self : CryptoasymecdsaRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaRange::mean(self : CryptoasymecdsaRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaRange::scale(
  self : CryptoasymecdsaRange,
  f : Double,
) -> CryptoasymecdsaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaRange::add(
  self : CryptoasymecdsaRange,
  other : CryptoasymecdsaRange,
) -> CryptoasymecdsaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaRange::copy(
  self : CryptoasymecdsaRange,
) -> CryptoasymecdsaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaRange::fill(
  self : CryptoasymecdsaRange,
  v : Double,
) -> CryptoasymecdsaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaRange::min(self : CryptoasymecdsaRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaRange::max(self : CryptoasymecdsaRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaRange::to_string(self : CryptoasymecdsaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptoasymecdsaSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_ecdsa_slice_make(size : Int32) -> CryptoasymecdsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptoasymecdsaSlice::len(self : CryptoasymecdsaSlice) -> Int32 {
  self.size
}

///|
pub fn CryptoasymecdsaSlice::get(
  self : CryptoasymecdsaSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptoasymecdsaSlice::set(
  self : CryptoasymecdsaSlice,
  i : Int32,
  v : Double,
) -> CryptoasymecdsaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaSlice::sum(self : CryptoasymecdsaSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptoasymecdsaSlice::mean(self : CryptoasymecdsaSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptoasymecdsaSlice::scale(
  self : CryptoasymecdsaSlice,
  f : Double,
) -> CryptoasymecdsaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaSlice::add(
  self : CryptoasymecdsaSlice,
  other : CryptoasymecdsaSlice,
) -> CryptoasymecdsaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaSlice::copy(
  self : CryptoasymecdsaSlice,
) -> CryptoasymecdsaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaSlice::fill(
  self : CryptoasymecdsaSlice,
  v : Double,
) -> CryptoasymecdsaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptoasymecdsaSlice::min(self : CryptoasymecdsaSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptoasymecdsaSlice::max(self : CryptoasymecdsaSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptoasymecdsaSlice::to_string(self : CryptoasymecdsaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
