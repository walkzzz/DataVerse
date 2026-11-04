///|
///===
/// extcore/crypto_hash_ripemd
pub(all) struct CryptohashripemdPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn crypto_hash_ripemd_make_point(
  x : Double,
  y : Double,
) -> CryptohashripemdPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn crypto_hash_ripemd_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> CryptohashripemdPoint {
  { x, y, z, label: 0, }
}

///|
pub fn CryptohashripemdPoint::x(self : CryptohashripemdPoint) -> Double {
  self.x
}

///|
pub fn CryptohashripemdPoint::y(self : CryptohashripemdPoint) -> Double {
  self.y
}

///|
pub fn CryptohashripemdPoint::z(self : CryptohashripemdPoint) -> Double {
  self.z
}

///|
pub fn CryptohashripemdPoint::label(self : CryptohashripemdPoint) -> Int32 {
  self.label
}

///|
pub fn CryptohashripemdPoint::dist(
  self : CryptohashripemdPoint,
  other : CryptohashripemdPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn CryptohashripemdPoint::add(
  self : CryptohashripemdPoint,
  other : CryptohashripemdPoint,
) -> CryptohashripemdPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn CryptohashripemdPoint::sub(
  self : CryptohashripemdPoint,
  other : CryptohashripemdPoint,
) -> CryptohashripemdPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn CryptohashripemdPoint::scale(
  self : CryptohashripemdPoint,
  s : Double,
) -> CryptohashripemdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn CryptohashripemdPoint::dot(
  self : CryptohashripemdPoint,
  other : CryptohashripemdPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn CryptohashripemdPoint::cross(
  self : CryptohashripemdPoint,
  other : CryptohashripemdPoint,
) -> CryptohashripemdPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn CryptohashripemdPoint::norm(self : CryptohashripemdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn CryptohashripemdPoint::normalize(
  self : CryptohashripemdPoint,
) -> CryptohashripemdPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptohashripemdPoint::negate(
  self : CryptohashripemdPoint,
) -> CryptohashripemdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn CryptohashripemdPoint::mid(
  self : CryptohashripemdPoint,
  other : CryptohashripemdPoint,
) -> CryptohashripemdPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn CryptohashripemdPoint::lerp(
  self : CryptohashripemdPoint,
  other : CryptohashripemdPoint,
  t : Double,
) -> CryptohashripemdPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn CryptohashripemdPoint::to_string(self : CryptohashripemdPoint) -> String {
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
pub(all) struct CryptohashripemdSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn crypto_hash_ripemd_make_series(
  vals : Array[Double],
  name : String,
) -> CryptohashripemdSeries {
  { vals, name, meta: 0, }
}

///|
pub fn CryptohashripemdSeries::len(self : CryptohashripemdSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn CryptohashripemdSeries::sum(self : CryptohashripemdSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn CryptohashripemdSeries::mean(self : CryptohashripemdSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn CryptohashripemdSeries::min(self : CryptohashripemdSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn CryptohashripemdSeries::max(self : CryptohashripemdSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn CryptohashripemdSeries::range(self : CryptohashripemdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn CryptohashripemdSeries::variance(
  self : CryptohashripemdSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn CryptohashripemdSeries::std(self : CryptohashripemdSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn CryptohashripemdSeries::median(self : CryptohashripemdSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn CryptohashripemdSeries::scale(
  self : CryptohashripemdSeries,
  f : Double,
) -> CryptohashripemdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn CryptohashripemdSeries::add(
  self : CryptohashripemdSeries,
  other : CryptohashripemdSeries,
) -> CryptohashripemdSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptohashripemdSeries::sub(
  self : CryptohashripemdSeries,
  other : CryptohashripemdSeries,
) -> CryptohashripemdSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptohashripemdSeries::normalize(
  self : CryptohashripemdSeries,
) -> CryptohashripemdSeries {
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
pub fn CryptohashripemdSeries::cumsum(
  self : CryptohashripemdSeries,
) -> CryptohashripemdSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn CryptohashripemdSeries::to_string(
  self : CryptohashripemdSeries,
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
pub(all) struct CryptohashripemdMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn crypto_hash_ripemd_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> CryptohashripemdMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn crypto_hash_ripemd_matrix_identity(n : Int32) -> CryptohashripemdMatrix {
  let m = crypto_hash_ripemd_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn CryptohashripemdMatrix::get(
  self : CryptohashripemdMatrix,
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
pub fn CryptohashripemdMatrix::transpose(
  self : CryptohashripemdMatrix,
) -> CryptohashripemdMatrix {
  let result = crypto_hash_ripemd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn CryptohashripemdMatrix::add(
  self : CryptohashripemdMatrix,
  other : CryptohashripemdMatrix,
) -> CryptohashripemdMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = crypto_hash_ripemd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn CryptohashripemdMatrix::scale(
  self : CryptohashripemdMatrix,
  s : Double,
) -> CryptohashripemdMatrix {
  let result = crypto_hash_ripemd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn CryptohashripemdMatrix::multiply(
  self : CryptohashripemdMatrix,
  other : CryptohashripemdMatrix,
) -> CryptohashripemdMatrix {
  if self.cols != other.rows {
    return crypto_hash_ripemd_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = crypto_hash_ripemd_make_matrix(self.rows, other.cols, 0.0)
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
pub fn CryptohashripemdMatrix::trace(self : CryptohashripemdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn CryptohashripemdMatrix::det(self : CryptohashripemdMatrix) -> Double {
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
pub fn CryptohashripemdMatrix::norm(self : CryptohashripemdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn CryptohashripemdMatrix::to_string(
  self : CryptohashripemdMatrix,
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
pub(all) struct CryptohashripemdVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn crypto_hash_ripemd_make_vector(
  comps : Array[Double],
) -> CryptohashripemdVector {
  { comps, dim: comps.length(), }
}

///|
pub fn crypto_hash_ripemd_vector_zero(dim : Int32) -> CryptohashripemdVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn CryptohashripemdVector::add(
  self : CryptohashripemdVector,
  other : CryptohashripemdVector,
) -> CryptohashripemdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptohashripemdVector::sub(
  self : CryptohashripemdVector,
  other : CryptohashripemdVector,
) -> CryptohashripemdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptohashripemdVector::scale(
  self : CryptohashripemdVector,
  s : Double,
) -> CryptohashripemdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn CryptohashripemdVector::dot(
  self : CryptohashripemdVector,
  other : CryptohashripemdVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn CryptohashripemdVector::norm(self : CryptohashripemdVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn CryptohashripemdVector::normalize(
  self : CryptohashripemdVector,
) -> CryptohashripemdVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptohashripemdVector::dist(
  self : CryptohashripemdVector,
  other : CryptohashripemdVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn CryptohashripemdVector::to_string(
  self : CryptohashripemdVector,
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
pub(all) struct CryptohashripemdFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_frame_make(size : Int32) -> CryptohashripemdFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdFrame::len(self : CryptohashripemdFrame) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdFrame::get(
  self : CryptohashripemdFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdFrame::set(
  self : CryptohashripemdFrame,
  i : Int32,
  v : Double,
) -> CryptohashripemdFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdFrame::sum(self : CryptohashripemdFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdFrame::mean(self : CryptohashripemdFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdFrame::scale(
  self : CryptohashripemdFrame,
  f : Double,
) -> CryptohashripemdFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdFrame::add(
  self : CryptohashripemdFrame,
  other : CryptohashripemdFrame,
) -> CryptohashripemdFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdFrame::copy(
  self : CryptohashripemdFrame,
) -> CryptohashripemdFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdFrame::fill(
  self : CryptohashripemdFrame,
  v : Double,
) -> CryptohashripemdFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdFrame::min(self : CryptohashripemdFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdFrame::max(self : CryptohashripemdFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdFrame::to_string(self : CryptohashripemdFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_table_make(size : Int32) -> CryptohashripemdTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdTable::len(self : CryptohashripemdTable) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdTable::get(
  self : CryptohashripemdTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdTable::set(
  self : CryptohashripemdTable,
  i : Int32,
  v : Double,
) -> CryptohashripemdTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdTable::sum(self : CryptohashripemdTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdTable::mean(self : CryptohashripemdTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdTable::scale(
  self : CryptohashripemdTable,
  f : Double,
) -> CryptohashripemdTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdTable::add(
  self : CryptohashripemdTable,
  other : CryptohashripemdTable,
) -> CryptohashripemdTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdTable::copy(
  self : CryptohashripemdTable,
) -> CryptohashripemdTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdTable::fill(
  self : CryptohashripemdTable,
  v : Double,
) -> CryptohashripemdTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdTable::min(self : CryptohashripemdTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdTable::max(self : CryptohashripemdTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdTable::to_string(self : CryptohashripemdTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_graphn_make(size : Int32) -> CryptohashripemdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdGraphN::len(self : CryptohashripemdGraphN) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdGraphN::get(
  self : CryptohashripemdGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdGraphN::set(
  self : CryptohashripemdGraphN,
  i : Int32,
  v : Double,
) -> CryptohashripemdGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdGraphN::sum(self : CryptohashripemdGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdGraphN::mean(self : CryptohashripemdGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdGraphN::scale(
  self : CryptohashripemdGraphN,
  f : Double,
) -> CryptohashripemdGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdGraphN::add(
  self : CryptohashripemdGraphN,
  other : CryptohashripemdGraphN,
) -> CryptohashripemdGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdGraphN::copy(
  self : CryptohashripemdGraphN,
) -> CryptohashripemdGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdGraphN::fill(
  self : CryptohashripemdGraphN,
  v : Double,
) -> CryptohashripemdGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdGraphN::min(self : CryptohashripemdGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdGraphN::max(self : CryptohashripemdGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdGraphN::to_string(
  self : CryptohashripemdGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_node_make(size : Int32) -> CryptohashripemdNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdNode::len(self : CryptohashripemdNode) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdNode::get(
  self : CryptohashripemdNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdNode::set(
  self : CryptohashripemdNode,
  i : Int32,
  v : Double,
) -> CryptohashripemdNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdNode::sum(self : CryptohashripemdNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdNode::mean(self : CryptohashripemdNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdNode::scale(
  self : CryptohashripemdNode,
  f : Double,
) -> CryptohashripemdNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdNode::add(
  self : CryptohashripemdNode,
  other : CryptohashripemdNode,
) -> CryptohashripemdNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdNode::copy(
  self : CryptohashripemdNode,
) -> CryptohashripemdNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdNode::fill(
  self : CryptohashripemdNode,
  v : Double,
) -> CryptohashripemdNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdNode::min(self : CryptohashripemdNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdNode::max(self : CryptohashripemdNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdNode::to_string(self : CryptohashripemdNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_edge_make(size : Int32) -> CryptohashripemdEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdEdge::len(self : CryptohashripemdEdge) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdEdge::get(
  self : CryptohashripemdEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdEdge::set(
  self : CryptohashripemdEdge,
  i : Int32,
  v : Double,
) -> CryptohashripemdEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdEdge::sum(self : CryptohashripemdEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdEdge::mean(self : CryptohashripemdEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdEdge::scale(
  self : CryptohashripemdEdge,
  f : Double,
) -> CryptohashripemdEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdEdge::add(
  self : CryptohashripemdEdge,
  other : CryptohashripemdEdge,
) -> CryptohashripemdEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdEdge::copy(
  self : CryptohashripemdEdge,
) -> CryptohashripemdEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdEdge::fill(
  self : CryptohashripemdEdge,
  v : Double,
) -> CryptohashripemdEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdEdge::min(self : CryptohashripemdEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdEdge::max(self : CryptohashripemdEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdEdge::to_string(self : CryptohashripemdEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_path_make(size : Int32) -> CryptohashripemdPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdPath::len(self : CryptohashripemdPath) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdPath::get(
  self : CryptohashripemdPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdPath::set(
  self : CryptohashripemdPath,
  i : Int32,
  v : Double,
) -> CryptohashripemdPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdPath::sum(self : CryptohashripemdPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdPath::mean(self : CryptohashripemdPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdPath::scale(
  self : CryptohashripemdPath,
  f : Double,
) -> CryptohashripemdPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdPath::add(
  self : CryptohashripemdPath,
  other : CryptohashripemdPath,
) -> CryptohashripemdPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdPath::copy(
  self : CryptohashripemdPath,
) -> CryptohashripemdPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdPath::fill(
  self : CryptohashripemdPath,
  v : Double,
) -> CryptohashripemdPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdPath::min(self : CryptohashripemdPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdPath::max(self : CryptohashripemdPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdPath::to_string(self : CryptohashripemdPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_cluster_make(size : Int32) -> CryptohashripemdCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdCluster::len(self : CryptohashripemdCluster) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdCluster::get(
  self : CryptohashripemdCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdCluster::set(
  self : CryptohashripemdCluster,
  i : Int32,
  v : Double,
) -> CryptohashripemdCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdCluster::sum(self : CryptohashripemdCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdCluster::mean(self : CryptohashripemdCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdCluster::scale(
  self : CryptohashripemdCluster,
  f : Double,
) -> CryptohashripemdCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdCluster::add(
  self : CryptohashripemdCluster,
  other : CryptohashripemdCluster,
) -> CryptohashripemdCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdCluster::copy(
  self : CryptohashripemdCluster,
) -> CryptohashripemdCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdCluster::fill(
  self : CryptohashripemdCluster,
  v : Double,
) -> CryptohashripemdCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdCluster::min(self : CryptohashripemdCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdCluster::max(self : CryptohashripemdCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdCluster::to_string(
  self : CryptohashripemdCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_model_make(size : Int32) -> CryptohashripemdModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdModel::len(self : CryptohashripemdModel) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdModel::get(
  self : CryptohashripemdModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdModel::set(
  self : CryptohashripemdModel,
  i : Int32,
  v : Double,
) -> CryptohashripemdModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdModel::sum(self : CryptohashripemdModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdModel::mean(self : CryptohashripemdModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdModel::scale(
  self : CryptohashripemdModel,
  f : Double,
) -> CryptohashripemdModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdModel::add(
  self : CryptohashripemdModel,
  other : CryptohashripemdModel,
) -> CryptohashripemdModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdModel::copy(
  self : CryptohashripemdModel,
) -> CryptohashripemdModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdModel::fill(
  self : CryptohashripemdModel,
  v : Double,
) -> CryptohashripemdModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdModel::min(self : CryptohashripemdModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdModel::max(self : CryptohashripemdModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdModel::to_string(self : CryptohashripemdModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_layer_make(size : Int32) -> CryptohashripemdLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdLayer::len(self : CryptohashripemdLayer) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdLayer::get(
  self : CryptohashripemdLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdLayer::set(
  self : CryptohashripemdLayer,
  i : Int32,
  v : Double,
) -> CryptohashripemdLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdLayer::sum(self : CryptohashripemdLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdLayer::mean(self : CryptohashripemdLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdLayer::scale(
  self : CryptohashripemdLayer,
  f : Double,
) -> CryptohashripemdLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdLayer::add(
  self : CryptohashripemdLayer,
  other : CryptohashripemdLayer,
) -> CryptohashripemdLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdLayer::copy(
  self : CryptohashripemdLayer,
) -> CryptohashripemdLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdLayer::fill(
  self : CryptohashripemdLayer,
  v : Double,
) -> CryptohashripemdLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdLayer::min(self : CryptohashripemdLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdLayer::max(self : CryptohashripemdLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdLayer::to_string(self : CryptohashripemdLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_buffer_make(size : Int32) -> CryptohashripemdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdBuffer::len(self : CryptohashripemdBuffer) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdBuffer::get(
  self : CryptohashripemdBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdBuffer::set(
  self : CryptohashripemdBuffer,
  i : Int32,
  v : Double,
) -> CryptohashripemdBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdBuffer::sum(self : CryptohashripemdBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdBuffer::mean(self : CryptohashripemdBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdBuffer::scale(
  self : CryptohashripemdBuffer,
  f : Double,
) -> CryptohashripemdBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdBuffer::add(
  self : CryptohashripemdBuffer,
  other : CryptohashripemdBuffer,
) -> CryptohashripemdBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdBuffer::copy(
  self : CryptohashripemdBuffer,
) -> CryptohashripemdBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdBuffer::fill(
  self : CryptohashripemdBuffer,
  v : Double,
) -> CryptohashripemdBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdBuffer::min(self : CryptohashripemdBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdBuffer::max(self : CryptohashripemdBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdBuffer::to_string(
  self : CryptohashripemdBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_cursor_make(size : Int32) -> CryptohashripemdCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdCursor::len(self : CryptohashripemdCursor) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdCursor::get(
  self : CryptohashripemdCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdCursor::set(
  self : CryptohashripemdCursor,
  i : Int32,
  v : Double,
) -> CryptohashripemdCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdCursor::sum(self : CryptohashripemdCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdCursor::mean(self : CryptohashripemdCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdCursor::scale(
  self : CryptohashripemdCursor,
  f : Double,
) -> CryptohashripemdCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdCursor::add(
  self : CryptohashripemdCursor,
  other : CryptohashripemdCursor,
) -> CryptohashripemdCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdCursor::copy(
  self : CryptohashripemdCursor,
) -> CryptohashripemdCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdCursor::fill(
  self : CryptohashripemdCursor,
  v : Double,
) -> CryptohashripemdCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdCursor::min(self : CryptohashripemdCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdCursor::max(self : CryptohashripemdCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdCursor::to_string(
  self : CryptohashripemdCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_view_make(size : Int32) -> CryptohashripemdView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdView::len(self : CryptohashripemdView) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdView::get(
  self : CryptohashripemdView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdView::set(
  self : CryptohashripemdView,
  i : Int32,
  v : Double,
) -> CryptohashripemdView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdView::sum(self : CryptohashripemdView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdView::mean(self : CryptohashripemdView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdView::scale(
  self : CryptohashripemdView,
  f : Double,
) -> CryptohashripemdView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdView::add(
  self : CryptohashripemdView,
  other : CryptohashripemdView,
) -> CryptohashripemdView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdView::copy(
  self : CryptohashripemdView,
) -> CryptohashripemdView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdView::fill(
  self : CryptohashripemdView,
  v : Double,
) -> CryptohashripemdView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdView::min(self : CryptohashripemdView) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdView::max(self : CryptohashripemdView) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdView::to_string(self : CryptohashripemdView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_range_make(size : Int32) -> CryptohashripemdRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdRange::len(self : CryptohashripemdRange) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdRange::get(
  self : CryptohashripemdRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdRange::set(
  self : CryptohashripemdRange,
  i : Int32,
  v : Double,
) -> CryptohashripemdRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdRange::sum(self : CryptohashripemdRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdRange::mean(self : CryptohashripemdRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdRange::scale(
  self : CryptohashripemdRange,
  f : Double,
) -> CryptohashripemdRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdRange::add(
  self : CryptohashripemdRange,
  other : CryptohashripemdRange,
) -> CryptohashripemdRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdRange::copy(
  self : CryptohashripemdRange,
) -> CryptohashripemdRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdRange::fill(
  self : CryptohashripemdRange,
  v : Double,
) -> CryptohashripemdRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdRange::min(self : CryptohashripemdRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdRange::max(self : CryptohashripemdRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdRange::to_string(self : CryptohashripemdRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptohashripemdSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_ripemd_slice_make(size : Int32) -> CryptohashripemdSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptohashripemdSlice::len(self : CryptohashripemdSlice) -> Int32 {
  self.size
}

///|
pub fn CryptohashripemdSlice::get(
  self : CryptohashripemdSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptohashripemdSlice::set(
  self : CryptohashripemdSlice,
  i : Int32,
  v : Double,
) -> CryptohashripemdSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdSlice::sum(self : CryptohashripemdSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptohashripemdSlice::mean(self : CryptohashripemdSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptohashripemdSlice::scale(
  self : CryptohashripemdSlice,
  f : Double,
) -> CryptohashripemdSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdSlice::add(
  self : CryptohashripemdSlice,
  other : CryptohashripemdSlice,
) -> CryptohashripemdSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptohashripemdSlice::copy(
  self : CryptohashripemdSlice,
) -> CryptohashripemdSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdSlice::fill(
  self : CryptohashripemdSlice,
  v : Double,
) -> CryptohashripemdSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptohashripemdSlice::min(self : CryptohashripemdSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptohashripemdSlice::max(self : CryptohashripemdSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptohashripemdSlice::to_string(self : CryptohashripemdSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
