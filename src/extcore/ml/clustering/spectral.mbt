///|
///===
/// extcore/ml_cluster_spectral
pub(all) struct MlclusterspectralPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ml_cluster_spectral_make_point(
  x : Double,
  y : Double,
) -> MlclusterspectralPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ml_cluster_spectral_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MlclusterspectralPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MlclusterspectralPoint::x(self : MlclusterspectralPoint) -> Double {
  self.x
}

///|
pub fn MlclusterspectralPoint::y(self : MlclusterspectralPoint) -> Double {
  self.y
}

///|
pub fn MlclusterspectralPoint::z(self : MlclusterspectralPoint) -> Double {
  self.z
}

///|
pub fn MlclusterspectralPoint::label(self : MlclusterspectralPoint) -> Int32 {
  self.label
}

///|
pub fn MlclusterspectralPoint::dist(
  self : MlclusterspectralPoint,
  other : MlclusterspectralPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MlclusterspectralPoint::add(
  self : MlclusterspectralPoint,
  other : MlclusterspectralPoint,
) -> MlclusterspectralPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MlclusterspectralPoint::sub(
  self : MlclusterspectralPoint,
  other : MlclusterspectralPoint,
) -> MlclusterspectralPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MlclusterspectralPoint::scale(
  self : MlclusterspectralPoint,
  s : Double,
) -> MlclusterspectralPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MlclusterspectralPoint::dot(
  self : MlclusterspectralPoint,
  other : MlclusterspectralPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MlclusterspectralPoint::cross(
  self : MlclusterspectralPoint,
  other : MlclusterspectralPoint,
) -> MlclusterspectralPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MlclusterspectralPoint::norm(self : MlclusterspectralPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MlclusterspectralPoint::normalize(
  self : MlclusterspectralPoint,
) -> MlclusterspectralPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlclusterspectralPoint::negate(
  self : MlclusterspectralPoint,
) -> MlclusterspectralPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MlclusterspectralPoint::mid(
  self : MlclusterspectralPoint,
  other : MlclusterspectralPoint,
) -> MlclusterspectralPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MlclusterspectralPoint::lerp(
  self : MlclusterspectralPoint,
  other : MlclusterspectralPoint,
  t : Double,
) -> MlclusterspectralPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MlclusterspectralPoint::to_string(
  self : MlclusterspectralPoint,
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
pub(all) struct MlclusterspectralSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ml_cluster_spectral_make_series(
  vals : Array[Double],
  name : String,
) -> MlclusterspectralSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MlclusterspectralSeries::len(self : MlclusterspectralSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MlclusterspectralSeries::sum(self : MlclusterspectralSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MlclusterspectralSeries::mean(self : MlclusterspectralSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MlclusterspectralSeries::min(self : MlclusterspectralSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MlclusterspectralSeries::max(self : MlclusterspectralSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MlclusterspectralSeries::range(self : MlclusterspectralSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MlclusterspectralSeries::variance(
  self : MlclusterspectralSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MlclusterspectralSeries::std(self : MlclusterspectralSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MlclusterspectralSeries::median(
  self : MlclusterspectralSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MlclusterspectralSeries::scale(
  self : MlclusterspectralSeries,
  f : Double,
) -> MlclusterspectralSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MlclusterspectralSeries::add(
  self : MlclusterspectralSeries,
  other : MlclusterspectralSeries,
) -> MlclusterspectralSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlclusterspectralSeries::sub(
  self : MlclusterspectralSeries,
  other : MlclusterspectralSeries,
) -> MlclusterspectralSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MlclusterspectralSeries::normalize(
  self : MlclusterspectralSeries,
) -> MlclusterspectralSeries {
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
pub fn MlclusterspectralSeries::cumsum(
  self : MlclusterspectralSeries,
) -> MlclusterspectralSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MlclusterspectralSeries::to_string(
  self : MlclusterspectralSeries,
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
pub(all) struct MlclusterspectralMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ml_cluster_spectral_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MlclusterspectralMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ml_cluster_spectral_matrix_identity(
  n : Int32,
) -> MlclusterspectralMatrix {
  let m = ml_cluster_spectral_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MlclusterspectralMatrix::get(
  self : MlclusterspectralMatrix,
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
pub fn MlclusterspectralMatrix::transpose(
  self : MlclusterspectralMatrix,
) -> MlclusterspectralMatrix {
  let result = ml_cluster_spectral_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MlclusterspectralMatrix::add(
  self : MlclusterspectralMatrix,
  other : MlclusterspectralMatrix,
) -> MlclusterspectralMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ml_cluster_spectral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MlclusterspectralMatrix::scale(
  self : MlclusterspectralMatrix,
  s : Double,
) -> MlclusterspectralMatrix {
  let result = ml_cluster_spectral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MlclusterspectralMatrix::multiply(
  self : MlclusterspectralMatrix,
  other : MlclusterspectralMatrix,
) -> MlclusterspectralMatrix {
  if self.cols != other.rows {
    return ml_cluster_spectral_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ml_cluster_spectral_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MlclusterspectralMatrix::trace(self : MlclusterspectralMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MlclusterspectralMatrix::det(self : MlclusterspectralMatrix) -> Double {
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
pub fn MlclusterspectralMatrix::norm(self : MlclusterspectralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MlclusterspectralMatrix::to_string(
  self : MlclusterspectralMatrix,
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
pub(all) struct MlclusterspectralVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ml_cluster_spectral_make_vector(
  comps : Array[Double],
) -> MlclusterspectralVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ml_cluster_spectral_vector_zero(dim : Int32) -> MlclusterspectralVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MlclusterspectralVector::add(
  self : MlclusterspectralVector,
  other : MlclusterspectralVector,
) -> MlclusterspectralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlclusterspectralVector::sub(
  self : MlclusterspectralVector,
  other : MlclusterspectralVector,
) -> MlclusterspectralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MlclusterspectralVector::scale(
  self : MlclusterspectralVector,
  s : Double,
) -> MlclusterspectralVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MlclusterspectralVector::dot(
  self : MlclusterspectralVector,
  other : MlclusterspectralVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MlclusterspectralVector::norm(self : MlclusterspectralVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MlclusterspectralVector::normalize(
  self : MlclusterspectralVector,
) -> MlclusterspectralVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MlclusterspectralVector::dist(
  self : MlclusterspectralVector,
  other : MlclusterspectralVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MlclusterspectralVector::to_string(
  self : MlclusterspectralVector,
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
pub(all) struct MlclusterspectralFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_frame_make(size : Int32) -> MlclusterspectralFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralFrame::len(self : MlclusterspectralFrame) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralFrame::get(
  self : MlclusterspectralFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralFrame::set(
  self : MlclusterspectralFrame,
  i : Int32,
  v : Double,
) -> MlclusterspectralFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralFrame::sum(self : MlclusterspectralFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralFrame::mean(self : MlclusterspectralFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralFrame::scale(
  self : MlclusterspectralFrame,
  f : Double,
) -> MlclusterspectralFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralFrame::add(
  self : MlclusterspectralFrame,
  other : MlclusterspectralFrame,
) -> MlclusterspectralFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralFrame::copy(
  self : MlclusterspectralFrame,
) -> MlclusterspectralFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralFrame::fill(
  self : MlclusterspectralFrame,
  v : Double,
) -> MlclusterspectralFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralFrame::min(self : MlclusterspectralFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralFrame::max(self : MlclusterspectralFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralFrame::to_string(
  self : MlclusterspectralFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_table_make(size : Int32) -> MlclusterspectralTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralTable::len(self : MlclusterspectralTable) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralTable::get(
  self : MlclusterspectralTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralTable::set(
  self : MlclusterspectralTable,
  i : Int32,
  v : Double,
) -> MlclusterspectralTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralTable::sum(self : MlclusterspectralTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralTable::mean(self : MlclusterspectralTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralTable::scale(
  self : MlclusterspectralTable,
  f : Double,
) -> MlclusterspectralTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralTable::add(
  self : MlclusterspectralTable,
  other : MlclusterspectralTable,
) -> MlclusterspectralTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralTable::copy(
  self : MlclusterspectralTable,
) -> MlclusterspectralTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralTable::fill(
  self : MlclusterspectralTable,
  v : Double,
) -> MlclusterspectralTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralTable::min(self : MlclusterspectralTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralTable::max(self : MlclusterspectralTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralTable::to_string(
  self : MlclusterspectralTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_graphn_make(size : Int32) -> MlclusterspectralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralGraphN::len(self : MlclusterspectralGraphN) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralGraphN::get(
  self : MlclusterspectralGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralGraphN::set(
  self : MlclusterspectralGraphN,
  i : Int32,
  v : Double,
) -> MlclusterspectralGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralGraphN::sum(self : MlclusterspectralGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralGraphN::mean(self : MlclusterspectralGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralGraphN::scale(
  self : MlclusterspectralGraphN,
  f : Double,
) -> MlclusterspectralGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralGraphN::add(
  self : MlclusterspectralGraphN,
  other : MlclusterspectralGraphN,
) -> MlclusterspectralGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralGraphN::copy(
  self : MlclusterspectralGraphN,
) -> MlclusterspectralGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralGraphN::fill(
  self : MlclusterspectralGraphN,
  v : Double,
) -> MlclusterspectralGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralGraphN::min(self : MlclusterspectralGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralGraphN::max(self : MlclusterspectralGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralGraphN::to_string(
  self : MlclusterspectralGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_node_make(size : Int32) -> MlclusterspectralNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralNode::len(self : MlclusterspectralNode) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralNode::get(
  self : MlclusterspectralNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralNode::set(
  self : MlclusterspectralNode,
  i : Int32,
  v : Double,
) -> MlclusterspectralNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralNode::sum(self : MlclusterspectralNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralNode::mean(self : MlclusterspectralNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralNode::scale(
  self : MlclusterspectralNode,
  f : Double,
) -> MlclusterspectralNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralNode::add(
  self : MlclusterspectralNode,
  other : MlclusterspectralNode,
) -> MlclusterspectralNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralNode::copy(
  self : MlclusterspectralNode,
) -> MlclusterspectralNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralNode::fill(
  self : MlclusterspectralNode,
  v : Double,
) -> MlclusterspectralNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralNode::min(self : MlclusterspectralNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralNode::max(self : MlclusterspectralNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralNode::to_string(self : MlclusterspectralNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_edge_make(size : Int32) -> MlclusterspectralEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralEdge::len(self : MlclusterspectralEdge) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralEdge::get(
  self : MlclusterspectralEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralEdge::set(
  self : MlclusterspectralEdge,
  i : Int32,
  v : Double,
) -> MlclusterspectralEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralEdge::sum(self : MlclusterspectralEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralEdge::mean(self : MlclusterspectralEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralEdge::scale(
  self : MlclusterspectralEdge,
  f : Double,
) -> MlclusterspectralEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralEdge::add(
  self : MlclusterspectralEdge,
  other : MlclusterspectralEdge,
) -> MlclusterspectralEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralEdge::copy(
  self : MlclusterspectralEdge,
) -> MlclusterspectralEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralEdge::fill(
  self : MlclusterspectralEdge,
  v : Double,
) -> MlclusterspectralEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralEdge::min(self : MlclusterspectralEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralEdge::max(self : MlclusterspectralEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralEdge::to_string(self : MlclusterspectralEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_path_make(size : Int32) -> MlclusterspectralPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralPath::len(self : MlclusterspectralPath) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralPath::get(
  self : MlclusterspectralPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralPath::set(
  self : MlclusterspectralPath,
  i : Int32,
  v : Double,
) -> MlclusterspectralPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralPath::sum(self : MlclusterspectralPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralPath::mean(self : MlclusterspectralPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralPath::scale(
  self : MlclusterspectralPath,
  f : Double,
) -> MlclusterspectralPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralPath::add(
  self : MlclusterspectralPath,
  other : MlclusterspectralPath,
) -> MlclusterspectralPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralPath::copy(
  self : MlclusterspectralPath,
) -> MlclusterspectralPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralPath::fill(
  self : MlclusterspectralPath,
  v : Double,
) -> MlclusterspectralPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralPath::min(self : MlclusterspectralPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralPath::max(self : MlclusterspectralPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralPath::to_string(self : MlclusterspectralPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_cluster_make(
  size : Int32,
) -> MlclusterspectralCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralCluster::len(self : MlclusterspectralCluster) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralCluster::get(
  self : MlclusterspectralCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralCluster::set(
  self : MlclusterspectralCluster,
  i : Int32,
  v : Double,
) -> MlclusterspectralCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralCluster::sum(self : MlclusterspectralCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralCluster::mean(
  self : MlclusterspectralCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralCluster::scale(
  self : MlclusterspectralCluster,
  f : Double,
) -> MlclusterspectralCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralCluster::add(
  self : MlclusterspectralCluster,
  other : MlclusterspectralCluster,
) -> MlclusterspectralCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralCluster::copy(
  self : MlclusterspectralCluster,
) -> MlclusterspectralCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralCluster::fill(
  self : MlclusterspectralCluster,
  v : Double,
) -> MlclusterspectralCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralCluster::min(self : MlclusterspectralCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralCluster::max(self : MlclusterspectralCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralCluster::to_string(
  self : MlclusterspectralCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_model_make(size : Int32) -> MlclusterspectralModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralModel::len(self : MlclusterspectralModel) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralModel::get(
  self : MlclusterspectralModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralModel::set(
  self : MlclusterspectralModel,
  i : Int32,
  v : Double,
) -> MlclusterspectralModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralModel::sum(self : MlclusterspectralModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralModel::mean(self : MlclusterspectralModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralModel::scale(
  self : MlclusterspectralModel,
  f : Double,
) -> MlclusterspectralModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralModel::add(
  self : MlclusterspectralModel,
  other : MlclusterspectralModel,
) -> MlclusterspectralModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralModel::copy(
  self : MlclusterspectralModel,
) -> MlclusterspectralModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralModel::fill(
  self : MlclusterspectralModel,
  v : Double,
) -> MlclusterspectralModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralModel::min(self : MlclusterspectralModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralModel::max(self : MlclusterspectralModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralModel::to_string(
  self : MlclusterspectralModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_layer_make(size : Int32) -> MlclusterspectralLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralLayer::len(self : MlclusterspectralLayer) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralLayer::get(
  self : MlclusterspectralLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralLayer::set(
  self : MlclusterspectralLayer,
  i : Int32,
  v : Double,
) -> MlclusterspectralLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralLayer::sum(self : MlclusterspectralLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralLayer::mean(self : MlclusterspectralLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralLayer::scale(
  self : MlclusterspectralLayer,
  f : Double,
) -> MlclusterspectralLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralLayer::add(
  self : MlclusterspectralLayer,
  other : MlclusterspectralLayer,
) -> MlclusterspectralLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralLayer::copy(
  self : MlclusterspectralLayer,
) -> MlclusterspectralLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralLayer::fill(
  self : MlclusterspectralLayer,
  v : Double,
) -> MlclusterspectralLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralLayer::min(self : MlclusterspectralLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralLayer::max(self : MlclusterspectralLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralLayer::to_string(
  self : MlclusterspectralLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_buffer_make(size : Int32) -> MlclusterspectralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralBuffer::len(self : MlclusterspectralBuffer) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralBuffer::get(
  self : MlclusterspectralBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralBuffer::set(
  self : MlclusterspectralBuffer,
  i : Int32,
  v : Double,
) -> MlclusterspectralBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralBuffer::sum(self : MlclusterspectralBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralBuffer::mean(self : MlclusterspectralBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralBuffer::scale(
  self : MlclusterspectralBuffer,
  f : Double,
) -> MlclusterspectralBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralBuffer::add(
  self : MlclusterspectralBuffer,
  other : MlclusterspectralBuffer,
) -> MlclusterspectralBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralBuffer::copy(
  self : MlclusterspectralBuffer,
) -> MlclusterspectralBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralBuffer::fill(
  self : MlclusterspectralBuffer,
  v : Double,
) -> MlclusterspectralBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralBuffer::min(self : MlclusterspectralBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralBuffer::max(self : MlclusterspectralBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralBuffer::to_string(
  self : MlclusterspectralBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_cursor_make(size : Int32) -> MlclusterspectralCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralCursor::len(self : MlclusterspectralCursor) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralCursor::get(
  self : MlclusterspectralCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralCursor::set(
  self : MlclusterspectralCursor,
  i : Int32,
  v : Double,
) -> MlclusterspectralCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralCursor::sum(self : MlclusterspectralCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralCursor::mean(self : MlclusterspectralCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralCursor::scale(
  self : MlclusterspectralCursor,
  f : Double,
) -> MlclusterspectralCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralCursor::add(
  self : MlclusterspectralCursor,
  other : MlclusterspectralCursor,
) -> MlclusterspectralCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralCursor::copy(
  self : MlclusterspectralCursor,
) -> MlclusterspectralCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralCursor::fill(
  self : MlclusterspectralCursor,
  v : Double,
) -> MlclusterspectralCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralCursor::min(self : MlclusterspectralCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralCursor::max(self : MlclusterspectralCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralCursor::to_string(
  self : MlclusterspectralCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_view_make(size : Int32) -> MlclusterspectralView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralView::len(self : MlclusterspectralView) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralView::get(
  self : MlclusterspectralView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralView::set(
  self : MlclusterspectralView,
  i : Int32,
  v : Double,
) -> MlclusterspectralView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralView::sum(self : MlclusterspectralView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralView::mean(self : MlclusterspectralView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralView::scale(
  self : MlclusterspectralView,
  f : Double,
) -> MlclusterspectralView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralView::add(
  self : MlclusterspectralView,
  other : MlclusterspectralView,
) -> MlclusterspectralView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralView::copy(
  self : MlclusterspectralView,
) -> MlclusterspectralView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralView::fill(
  self : MlclusterspectralView,
  v : Double,
) -> MlclusterspectralView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralView::min(self : MlclusterspectralView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralView::max(self : MlclusterspectralView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralView::to_string(self : MlclusterspectralView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_range_make(size : Int32) -> MlclusterspectralRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralRange::len(self : MlclusterspectralRange) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralRange::get(
  self : MlclusterspectralRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralRange::set(
  self : MlclusterspectralRange,
  i : Int32,
  v : Double,
) -> MlclusterspectralRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralRange::sum(self : MlclusterspectralRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralRange::mean(self : MlclusterspectralRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralRange::scale(
  self : MlclusterspectralRange,
  f : Double,
) -> MlclusterspectralRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralRange::add(
  self : MlclusterspectralRange,
  other : MlclusterspectralRange,
) -> MlclusterspectralRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralRange::copy(
  self : MlclusterspectralRange,
) -> MlclusterspectralRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralRange::fill(
  self : MlclusterspectralRange,
  v : Double,
) -> MlclusterspectralRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralRange::min(self : MlclusterspectralRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralRange::max(self : MlclusterspectralRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralRange::to_string(
  self : MlclusterspectralRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MlclusterspectralSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ml_cluster_spectral_slice_make(size : Int32) -> MlclusterspectralSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MlclusterspectralSlice::len(self : MlclusterspectralSlice) -> Int32 {
  self.size
}

///|
pub fn MlclusterspectralSlice::get(
  self : MlclusterspectralSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MlclusterspectralSlice::set(
  self : MlclusterspectralSlice,
  i : Int32,
  v : Double,
) -> MlclusterspectralSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralSlice::sum(self : MlclusterspectralSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MlclusterspectralSlice::mean(self : MlclusterspectralSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MlclusterspectralSlice::scale(
  self : MlclusterspectralSlice,
  f : Double,
) -> MlclusterspectralSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralSlice::add(
  self : MlclusterspectralSlice,
  other : MlclusterspectralSlice,
) -> MlclusterspectralSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MlclusterspectralSlice::copy(
  self : MlclusterspectralSlice,
) -> MlclusterspectralSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralSlice::fill(
  self : MlclusterspectralSlice,
  v : Double,
) -> MlclusterspectralSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MlclusterspectralSlice::min(self : MlclusterspectralSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MlclusterspectralSlice::max(self : MlclusterspectralSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MlclusterspectralSlice::to_string(
  self : MlclusterspectralSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
