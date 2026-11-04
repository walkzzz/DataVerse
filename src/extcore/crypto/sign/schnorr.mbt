///|
///===
/// extcore/crypto_sign_schnorr
pub(all) struct CryptosignschnorrPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn crypto_sign_schnorr_make_point(
  x : Double,
  y : Double,
) -> CryptosignschnorrPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn crypto_sign_schnorr_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> CryptosignschnorrPoint {
  { x, y, z, label: 0, }
}

///|
pub fn CryptosignschnorrPoint::x(self : CryptosignschnorrPoint) -> Double {
  self.x
}

///|
pub fn CryptosignschnorrPoint::y(self : CryptosignschnorrPoint) -> Double {
  self.y
}

///|
pub fn CryptosignschnorrPoint::z(self : CryptosignschnorrPoint) -> Double {
  self.z
}

///|
pub fn CryptosignschnorrPoint::label(self : CryptosignschnorrPoint) -> Int32 {
  self.label
}

///|
pub fn CryptosignschnorrPoint::dist(
  self : CryptosignschnorrPoint,
  other : CryptosignschnorrPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn CryptosignschnorrPoint::add(
  self : CryptosignschnorrPoint,
  other : CryptosignschnorrPoint,
) -> CryptosignschnorrPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn CryptosignschnorrPoint::sub(
  self : CryptosignschnorrPoint,
  other : CryptosignschnorrPoint,
) -> CryptosignschnorrPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn CryptosignschnorrPoint::scale(
  self : CryptosignschnorrPoint,
  s : Double,
) -> CryptosignschnorrPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn CryptosignschnorrPoint::dot(
  self : CryptosignschnorrPoint,
  other : CryptosignschnorrPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn CryptosignschnorrPoint::cross(
  self : CryptosignschnorrPoint,
  other : CryptosignschnorrPoint,
) -> CryptosignschnorrPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn CryptosignschnorrPoint::norm(self : CryptosignschnorrPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn CryptosignschnorrPoint::normalize(
  self : CryptosignschnorrPoint,
) -> CryptosignschnorrPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosignschnorrPoint::negate(
  self : CryptosignschnorrPoint,
) -> CryptosignschnorrPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn CryptosignschnorrPoint::mid(
  self : CryptosignschnorrPoint,
  other : CryptosignschnorrPoint,
) -> CryptosignschnorrPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn CryptosignschnorrPoint::lerp(
  self : CryptosignschnorrPoint,
  other : CryptosignschnorrPoint,
  t : Double,
) -> CryptosignschnorrPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn CryptosignschnorrPoint::to_string(
  self : CryptosignschnorrPoint,
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
pub(all) struct CryptosignschnorrSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn crypto_sign_schnorr_make_series(
  vals : Array[Double],
  name : String,
) -> CryptosignschnorrSeries {
  { vals, name, meta: 0, }
}

///|
pub fn CryptosignschnorrSeries::len(self : CryptosignschnorrSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn CryptosignschnorrSeries::sum(self : CryptosignschnorrSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn CryptosignschnorrSeries::mean(self : CryptosignschnorrSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn CryptosignschnorrSeries::min(self : CryptosignschnorrSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn CryptosignschnorrSeries::max(self : CryptosignschnorrSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn CryptosignschnorrSeries::range(self : CryptosignschnorrSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn CryptosignschnorrSeries::variance(
  self : CryptosignschnorrSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn CryptosignschnorrSeries::std(self : CryptosignschnorrSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn CryptosignschnorrSeries::median(
  self : CryptosignschnorrSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn CryptosignschnorrSeries::scale(
  self : CryptosignschnorrSeries,
  f : Double,
) -> CryptosignschnorrSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn CryptosignschnorrSeries::add(
  self : CryptosignschnorrSeries,
  other : CryptosignschnorrSeries,
) -> CryptosignschnorrSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosignschnorrSeries::sub(
  self : CryptosignschnorrSeries,
  other : CryptosignschnorrSeries,
) -> CryptosignschnorrSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosignschnorrSeries::normalize(
  self : CryptosignschnorrSeries,
) -> CryptosignschnorrSeries {
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
pub fn CryptosignschnorrSeries::cumsum(
  self : CryptosignschnorrSeries,
) -> CryptosignschnorrSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn CryptosignschnorrSeries::to_string(
  self : CryptosignschnorrSeries,
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
pub(all) struct CryptosignschnorrMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn crypto_sign_schnorr_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> CryptosignschnorrMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn crypto_sign_schnorr_matrix_identity(
  n : Int32,
) -> CryptosignschnorrMatrix {
  let m = crypto_sign_schnorr_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn CryptosignschnorrMatrix::get(
  self : CryptosignschnorrMatrix,
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
pub fn CryptosignschnorrMatrix::transpose(
  self : CryptosignschnorrMatrix,
) -> CryptosignschnorrMatrix {
  let result = crypto_sign_schnorr_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosignschnorrMatrix::add(
  self : CryptosignschnorrMatrix,
  other : CryptosignschnorrMatrix,
) -> CryptosignschnorrMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = crypto_sign_schnorr_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosignschnorrMatrix::scale(
  self : CryptosignschnorrMatrix,
  s : Double,
) -> CryptosignschnorrMatrix {
  let result = crypto_sign_schnorr_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn CryptosignschnorrMatrix::multiply(
  self : CryptosignschnorrMatrix,
  other : CryptosignschnorrMatrix,
) -> CryptosignschnorrMatrix {
  if self.cols != other.rows {
    return crypto_sign_schnorr_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = crypto_sign_schnorr_make_matrix(self.rows, other.cols, 0.0)
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
pub fn CryptosignschnorrMatrix::trace(self : CryptosignschnorrMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn CryptosignschnorrMatrix::det(self : CryptosignschnorrMatrix) -> Double {
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
pub fn CryptosignschnorrMatrix::norm(self : CryptosignschnorrMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn CryptosignschnorrMatrix::to_string(
  self : CryptosignschnorrMatrix,
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
pub(all) struct CryptosignschnorrVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn crypto_sign_schnorr_make_vector(
  comps : Array[Double],
) -> CryptosignschnorrVector {
  { comps, dim: comps.length(), }
}

///|
pub fn crypto_sign_schnorr_vector_zero(dim : Int32) -> CryptosignschnorrVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn CryptosignschnorrVector::add(
  self : CryptosignschnorrVector,
  other : CryptosignschnorrVector,
) -> CryptosignschnorrVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosignschnorrVector::sub(
  self : CryptosignschnorrVector,
  other : CryptosignschnorrVector,
) -> CryptosignschnorrVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosignschnorrVector::scale(
  self : CryptosignschnorrVector,
  s : Double,
) -> CryptosignschnorrVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn CryptosignschnorrVector::dot(
  self : CryptosignschnorrVector,
  other : CryptosignschnorrVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn CryptosignschnorrVector::norm(self : CryptosignschnorrVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn CryptosignschnorrVector::normalize(
  self : CryptosignschnorrVector,
) -> CryptosignschnorrVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosignschnorrVector::dist(
  self : CryptosignschnorrVector,
  other : CryptosignschnorrVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn CryptosignschnorrVector::to_string(
  self : CryptosignschnorrVector,
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
pub(all) struct CryptosignschnorrFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_frame_make(size : Int32) -> CryptosignschnorrFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrFrame::len(self : CryptosignschnorrFrame) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrFrame::get(
  self : CryptosignschnorrFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrFrame::set(
  self : CryptosignschnorrFrame,
  i : Int32,
  v : Double,
) -> CryptosignschnorrFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrFrame::sum(self : CryptosignschnorrFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrFrame::mean(self : CryptosignschnorrFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrFrame::scale(
  self : CryptosignschnorrFrame,
  f : Double,
) -> CryptosignschnorrFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrFrame::add(
  self : CryptosignschnorrFrame,
  other : CryptosignschnorrFrame,
) -> CryptosignschnorrFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrFrame::copy(
  self : CryptosignschnorrFrame,
) -> CryptosignschnorrFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrFrame::fill(
  self : CryptosignschnorrFrame,
  v : Double,
) -> CryptosignschnorrFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrFrame::min(self : CryptosignschnorrFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrFrame::max(self : CryptosignschnorrFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrFrame::to_string(
  self : CryptosignschnorrFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_table_make(size : Int32) -> CryptosignschnorrTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrTable::len(self : CryptosignschnorrTable) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrTable::get(
  self : CryptosignschnorrTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrTable::set(
  self : CryptosignschnorrTable,
  i : Int32,
  v : Double,
) -> CryptosignschnorrTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrTable::sum(self : CryptosignschnorrTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrTable::mean(self : CryptosignschnorrTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrTable::scale(
  self : CryptosignschnorrTable,
  f : Double,
) -> CryptosignschnorrTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrTable::add(
  self : CryptosignschnorrTable,
  other : CryptosignschnorrTable,
) -> CryptosignschnorrTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrTable::copy(
  self : CryptosignschnorrTable,
) -> CryptosignschnorrTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrTable::fill(
  self : CryptosignschnorrTable,
  v : Double,
) -> CryptosignschnorrTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrTable::min(self : CryptosignschnorrTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrTable::max(self : CryptosignschnorrTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrTable::to_string(
  self : CryptosignschnorrTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_graphn_make(size : Int32) -> CryptosignschnorrGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrGraphN::len(self : CryptosignschnorrGraphN) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrGraphN::get(
  self : CryptosignschnorrGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrGraphN::set(
  self : CryptosignschnorrGraphN,
  i : Int32,
  v : Double,
) -> CryptosignschnorrGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrGraphN::sum(self : CryptosignschnorrGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrGraphN::mean(self : CryptosignschnorrGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrGraphN::scale(
  self : CryptosignschnorrGraphN,
  f : Double,
) -> CryptosignschnorrGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrGraphN::add(
  self : CryptosignschnorrGraphN,
  other : CryptosignschnorrGraphN,
) -> CryptosignschnorrGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrGraphN::copy(
  self : CryptosignschnorrGraphN,
) -> CryptosignschnorrGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrGraphN::fill(
  self : CryptosignschnorrGraphN,
  v : Double,
) -> CryptosignschnorrGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrGraphN::min(self : CryptosignschnorrGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrGraphN::max(self : CryptosignschnorrGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrGraphN::to_string(
  self : CryptosignschnorrGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_node_make(size : Int32) -> CryptosignschnorrNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrNode::len(self : CryptosignschnorrNode) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrNode::get(
  self : CryptosignschnorrNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrNode::set(
  self : CryptosignschnorrNode,
  i : Int32,
  v : Double,
) -> CryptosignschnorrNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrNode::sum(self : CryptosignschnorrNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrNode::mean(self : CryptosignschnorrNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrNode::scale(
  self : CryptosignschnorrNode,
  f : Double,
) -> CryptosignschnorrNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrNode::add(
  self : CryptosignschnorrNode,
  other : CryptosignschnorrNode,
) -> CryptosignschnorrNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrNode::copy(
  self : CryptosignschnorrNode,
) -> CryptosignschnorrNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrNode::fill(
  self : CryptosignschnorrNode,
  v : Double,
) -> CryptosignschnorrNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrNode::min(self : CryptosignschnorrNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrNode::max(self : CryptosignschnorrNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrNode::to_string(self : CryptosignschnorrNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_edge_make(size : Int32) -> CryptosignschnorrEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrEdge::len(self : CryptosignschnorrEdge) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrEdge::get(
  self : CryptosignschnorrEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrEdge::set(
  self : CryptosignschnorrEdge,
  i : Int32,
  v : Double,
) -> CryptosignschnorrEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrEdge::sum(self : CryptosignschnorrEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrEdge::mean(self : CryptosignschnorrEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrEdge::scale(
  self : CryptosignschnorrEdge,
  f : Double,
) -> CryptosignschnorrEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrEdge::add(
  self : CryptosignschnorrEdge,
  other : CryptosignschnorrEdge,
) -> CryptosignschnorrEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrEdge::copy(
  self : CryptosignschnorrEdge,
) -> CryptosignschnorrEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrEdge::fill(
  self : CryptosignschnorrEdge,
  v : Double,
) -> CryptosignschnorrEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrEdge::min(self : CryptosignschnorrEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrEdge::max(self : CryptosignschnorrEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrEdge::to_string(self : CryptosignschnorrEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_path_make(size : Int32) -> CryptosignschnorrPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrPath::len(self : CryptosignschnorrPath) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrPath::get(
  self : CryptosignschnorrPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrPath::set(
  self : CryptosignschnorrPath,
  i : Int32,
  v : Double,
) -> CryptosignschnorrPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrPath::sum(self : CryptosignschnorrPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrPath::mean(self : CryptosignschnorrPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrPath::scale(
  self : CryptosignschnorrPath,
  f : Double,
) -> CryptosignschnorrPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrPath::add(
  self : CryptosignschnorrPath,
  other : CryptosignschnorrPath,
) -> CryptosignschnorrPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrPath::copy(
  self : CryptosignschnorrPath,
) -> CryptosignschnorrPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrPath::fill(
  self : CryptosignschnorrPath,
  v : Double,
) -> CryptosignschnorrPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrPath::min(self : CryptosignschnorrPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrPath::max(self : CryptosignschnorrPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrPath::to_string(self : CryptosignschnorrPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_cluster_make(
  size : Int32,
) -> CryptosignschnorrCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrCluster::len(self : CryptosignschnorrCluster) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrCluster::get(
  self : CryptosignschnorrCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrCluster::set(
  self : CryptosignschnorrCluster,
  i : Int32,
  v : Double,
) -> CryptosignschnorrCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrCluster::sum(self : CryptosignschnorrCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrCluster::mean(
  self : CryptosignschnorrCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrCluster::scale(
  self : CryptosignschnorrCluster,
  f : Double,
) -> CryptosignschnorrCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrCluster::add(
  self : CryptosignschnorrCluster,
  other : CryptosignschnorrCluster,
) -> CryptosignschnorrCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrCluster::copy(
  self : CryptosignschnorrCluster,
) -> CryptosignschnorrCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrCluster::fill(
  self : CryptosignschnorrCluster,
  v : Double,
) -> CryptosignschnorrCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrCluster::min(self : CryptosignschnorrCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrCluster::max(self : CryptosignschnorrCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrCluster::to_string(
  self : CryptosignschnorrCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_model_make(size : Int32) -> CryptosignschnorrModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrModel::len(self : CryptosignschnorrModel) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrModel::get(
  self : CryptosignschnorrModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrModel::set(
  self : CryptosignschnorrModel,
  i : Int32,
  v : Double,
) -> CryptosignschnorrModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrModel::sum(self : CryptosignschnorrModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrModel::mean(self : CryptosignschnorrModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrModel::scale(
  self : CryptosignschnorrModel,
  f : Double,
) -> CryptosignschnorrModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrModel::add(
  self : CryptosignschnorrModel,
  other : CryptosignschnorrModel,
) -> CryptosignschnorrModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrModel::copy(
  self : CryptosignschnorrModel,
) -> CryptosignschnorrModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrModel::fill(
  self : CryptosignschnorrModel,
  v : Double,
) -> CryptosignschnorrModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrModel::min(self : CryptosignschnorrModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrModel::max(self : CryptosignschnorrModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrModel::to_string(
  self : CryptosignschnorrModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_layer_make(size : Int32) -> CryptosignschnorrLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrLayer::len(self : CryptosignschnorrLayer) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrLayer::get(
  self : CryptosignschnorrLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrLayer::set(
  self : CryptosignschnorrLayer,
  i : Int32,
  v : Double,
) -> CryptosignschnorrLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrLayer::sum(self : CryptosignschnorrLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrLayer::mean(self : CryptosignschnorrLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrLayer::scale(
  self : CryptosignschnorrLayer,
  f : Double,
) -> CryptosignschnorrLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrLayer::add(
  self : CryptosignschnorrLayer,
  other : CryptosignschnorrLayer,
) -> CryptosignschnorrLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrLayer::copy(
  self : CryptosignschnorrLayer,
) -> CryptosignschnorrLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrLayer::fill(
  self : CryptosignschnorrLayer,
  v : Double,
) -> CryptosignschnorrLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrLayer::min(self : CryptosignschnorrLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrLayer::max(self : CryptosignschnorrLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrLayer::to_string(
  self : CryptosignschnorrLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_buffer_make(size : Int32) -> CryptosignschnorrBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrBuffer::len(self : CryptosignschnorrBuffer) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrBuffer::get(
  self : CryptosignschnorrBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrBuffer::set(
  self : CryptosignschnorrBuffer,
  i : Int32,
  v : Double,
) -> CryptosignschnorrBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrBuffer::sum(self : CryptosignschnorrBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrBuffer::mean(self : CryptosignschnorrBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrBuffer::scale(
  self : CryptosignschnorrBuffer,
  f : Double,
) -> CryptosignschnorrBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrBuffer::add(
  self : CryptosignschnorrBuffer,
  other : CryptosignschnorrBuffer,
) -> CryptosignschnorrBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrBuffer::copy(
  self : CryptosignschnorrBuffer,
) -> CryptosignschnorrBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrBuffer::fill(
  self : CryptosignschnorrBuffer,
  v : Double,
) -> CryptosignschnorrBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrBuffer::min(self : CryptosignschnorrBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrBuffer::max(self : CryptosignschnorrBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrBuffer::to_string(
  self : CryptosignschnorrBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_cursor_make(size : Int32) -> CryptosignschnorrCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrCursor::len(self : CryptosignschnorrCursor) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrCursor::get(
  self : CryptosignschnorrCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrCursor::set(
  self : CryptosignschnorrCursor,
  i : Int32,
  v : Double,
) -> CryptosignschnorrCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrCursor::sum(self : CryptosignschnorrCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrCursor::mean(self : CryptosignschnorrCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrCursor::scale(
  self : CryptosignschnorrCursor,
  f : Double,
) -> CryptosignschnorrCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrCursor::add(
  self : CryptosignschnorrCursor,
  other : CryptosignschnorrCursor,
) -> CryptosignschnorrCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrCursor::copy(
  self : CryptosignschnorrCursor,
) -> CryptosignschnorrCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrCursor::fill(
  self : CryptosignschnorrCursor,
  v : Double,
) -> CryptosignschnorrCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrCursor::min(self : CryptosignschnorrCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrCursor::max(self : CryptosignschnorrCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrCursor::to_string(
  self : CryptosignschnorrCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_view_make(size : Int32) -> CryptosignschnorrView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrView::len(self : CryptosignschnorrView) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrView::get(
  self : CryptosignschnorrView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrView::set(
  self : CryptosignschnorrView,
  i : Int32,
  v : Double,
) -> CryptosignschnorrView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrView::sum(self : CryptosignschnorrView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrView::mean(self : CryptosignschnorrView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrView::scale(
  self : CryptosignschnorrView,
  f : Double,
) -> CryptosignschnorrView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrView::add(
  self : CryptosignschnorrView,
  other : CryptosignschnorrView,
) -> CryptosignschnorrView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrView::copy(
  self : CryptosignschnorrView,
) -> CryptosignschnorrView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrView::fill(
  self : CryptosignschnorrView,
  v : Double,
) -> CryptosignschnorrView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrView::min(self : CryptosignschnorrView) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrView::max(self : CryptosignschnorrView) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrView::to_string(self : CryptosignschnorrView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_range_make(size : Int32) -> CryptosignschnorrRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrRange::len(self : CryptosignschnorrRange) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrRange::get(
  self : CryptosignschnorrRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrRange::set(
  self : CryptosignschnorrRange,
  i : Int32,
  v : Double,
) -> CryptosignschnorrRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrRange::sum(self : CryptosignschnorrRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrRange::mean(self : CryptosignschnorrRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrRange::scale(
  self : CryptosignschnorrRange,
  f : Double,
) -> CryptosignschnorrRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrRange::add(
  self : CryptosignschnorrRange,
  other : CryptosignschnorrRange,
) -> CryptosignschnorrRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrRange::copy(
  self : CryptosignschnorrRange,
) -> CryptosignschnorrRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrRange::fill(
  self : CryptosignschnorrRange,
  v : Double,
) -> CryptosignschnorrRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrRange::min(self : CryptosignschnorrRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrRange::max(self : CryptosignschnorrRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrRange::to_string(
  self : CryptosignschnorrRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignschnorrSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_schnorr_slice_make(size : Int32) -> CryptosignschnorrSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignschnorrSlice::len(self : CryptosignschnorrSlice) -> Int32 {
  self.size
}

///|
pub fn CryptosignschnorrSlice::get(
  self : CryptosignschnorrSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignschnorrSlice::set(
  self : CryptosignschnorrSlice,
  i : Int32,
  v : Double,
) -> CryptosignschnorrSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrSlice::sum(self : CryptosignschnorrSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignschnorrSlice::mean(self : CryptosignschnorrSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignschnorrSlice::scale(
  self : CryptosignschnorrSlice,
  f : Double,
) -> CryptosignschnorrSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrSlice::add(
  self : CryptosignschnorrSlice,
  other : CryptosignschnorrSlice,
) -> CryptosignschnorrSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignschnorrSlice::copy(
  self : CryptosignschnorrSlice,
) -> CryptosignschnorrSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrSlice::fill(
  self : CryptosignschnorrSlice,
  v : Double,
) -> CryptosignschnorrSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignschnorrSlice::min(self : CryptosignschnorrSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignschnorrSlice::max(self : CryptosignschnorrSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignschnorrSlice::to_string(
  self : CryptosignschnorrSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
