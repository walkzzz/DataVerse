///|
///===
/// extcore/stats_dist_multinomial
pub(all) struct StatsdistmultinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_dist_multinomial_make_point(
  x : Double,
  y : Double,
) -> StatsdistmultinomialPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_dist_multinomial_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatsdistmultinomialPoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatsdistmultinomialPoint::x(self : StatsdistmultinomialPoint) -> Double {
  self.x
}

///|
pub fn StatsdistmultinomialPoint::y(self : StatsdistmultinomialPoint) -> Double {
  self.y
}

///|
pub fn StatsdistmultinomialPoint::z(self : StatsdistmultinomialPoint) -> Double {
  self.z
}

///|
pub fn StatsdistmultinomialPoint::label(
  self : StatsdistmultinomialPoint,
) -> Int32 {
  self.label
}

///|
pub fn StatsdistmultinomialPoint::dist(
  self : StatsdistmultinomialPoint,
  other : StatsdistmultinomialPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatsdistmultinomialPoint::add(
  self : StatsdistmultinomialPoint,
  other : StatsdistmultinomialPoint,
) -> StatsdistmultinomialPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatsdistmultinomialPoint::sub(
  self : StatsdistmultinomialPoint,
  other : StatsdistmultinomialPoint,
) -> StatsdistmultinomialPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatsdistmultinomialPoint::scale(
  self : StatsdistmultinomialPoint,
  s : Double,
) -> StatsdistmultinomialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatsdistmultinomialPoint::dot(
  self : StatsdistmultinomialPoint,
  other : StatsdistmultinomialPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatsdistmultinomialPoint::cross(
  self : StatsdistmultinomialPoint,
  other : StatsdistmultinomialPoint,
) -> StatsdistmultinomialPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatsdistmultinomialPoint::norm(
  self : StatsdistmultinomialPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatsdistmultinomialPoint::normalize(
  self : StatsdistmultinomialPoint,
) -> StatsdistmultinomialPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdistmultinomialPoint::negate(
  self : StatsdistmultinomialPoint,
) -> StatsdistmultinomialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatsdistmultinomialPoint::mid(
  self : StatsdistmultinomialPoint,
  other : StatsdistmultinomialPoint,
) -> StatsdistmultinomialPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatsdistmultinomialPoint::lerp(
  self : StatsdistmultinomialPoint,
  other : StatsdistmultinomialPoint,
  t : Double,
) -> StatsdistmultinomialPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatsdistmultinomialPoint::to_string(
  self : StatsdistmultinomialPoint,
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
pub(all) struct StatsdistmultinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_dist_multinomial_make_series(
  vals : Array[Double],
  name : String,
) -> StatsdistmultinomialSeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatsdistmultinomialSeries::len(
  self : StatsdistmultinomialSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn StatsdistmultinomialSeries::sum(
  self : StatsdistmultinomialSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatsdistmultinomialSeries::mean(
  self : StatsdistmultinomialSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatsdistmultinomialSeries::min(
  self : StatsdistmultinomialSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatsdistmultinomialSeries::max(
  self : StatsdistmultinomialSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatsdistmultinomialSeries::range(
  self : StatsdistmultinomialSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatsdistmultinomialSeries::variance(
  self : StatsdistmultinomialSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatsdistmultinomialSeries::std(
  self : StatsdistmultinomialSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatsdistmultinomialSeries::median(
  self : StatsdistmultinomialSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatsdistmultinomialSeries::scale(
  self : StatsdistmultinomialSeries,
  f : Double,
) -> StatsdistmultinomialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatsdistmultinomialSeries::add(
  self : StatsdistmultinomialSeries,
  other : StatsdistmultinomialSeries,
) -> StatsdistmultinomialSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdistmultinomialSeries::sub(
  self : StatsdistmultinomialSeries,
  other : StatsdistmultinomialSeries,
) -> StatsdistmultinomialSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdistmultinomialSeries::normalize(
  self : StatsdistmultinomialSeries,
) -> StatsdistmultinomialSeries {
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
pub fn StatsdistmultinomialSeries::cumsum(
  self : StatsdistmultinomialSeries,
) -> StatsdistmultinomialSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatsdistmultinomialSeries::to_string(
  self : StatsdistmultinomialSeries,
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
pub(all) struct StatsdistmultinomialMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_dist_multinomial_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatsdistmultinomialMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_dist_multinomial_matrix_identity(
  n : Int32,
) -> StatsdistmultinomialMatrix {
  let m = stats_dist_multinomial_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatsdistmultinomialMatrix::get(
  self : StatsdistmultinomialMatrix,
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
pub fn StatsdistmultinomialMatrix::transpose(
  self : StatsdistmultinomialMatrix,
) -> StatsdistmultinomialMatrix {
  let result = stats_dist_multinomial_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdistmultinomialMatrix::add(
  self : StatsdistmultinomialMatrix,
  other : StatsdistmultinomialMatrix,
) -> StatsdistmultinomialMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_dist_multinomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdistmultinomialMatrix::scale(
  self : StatsdistmultinomialMatrix,
  s : Double,
) -> StatsdistmultinomialMatrix {
  let result = stats_dist_multinomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatsdistmultinomialMatrix::multiply(
  self : StatsdistmultinomialMatrix,
  other : StatsdistmultinomialMatrix,
) -> StatsdistmultinomialMatrix {
  if self.cols != other.rows {
    return stats_dist_multinomial_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_dist_multinomial_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatsdistmultinomialMatrix::trace(
  self : StatsdistmultinomialMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatsdistmultinomialMatrix::det(
  self : StatsdistmultinomialMatrix,
) -> Double {
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
pub fn StatsdistmultinomialMatrix::norm(
  self : StatsdistmultinomialMatrix,
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
pub fn StatsdistmultinomialMatrix::to_string(
  self : StatsdistmultinomialMatrix,
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
pub(all) struct StatsdistmultinomialVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_dist_multinomial_make_vector(
  comps : Array[Double],
) -> StatsdistmultinomialVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_dist_multinomial_vector_zero(
  dim : Int32,
) -> StatsdistmultinomialVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatsdistmultinomialVector::add(
  self : StatsdistmultinomialVector,
  other : StatsdistmultinomialVector,
) -> StatsdistmultinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdistmultinomialVector::sub(
  self : StatsdistmultinomialVector,
  other : StatsdistmultinomialVector,
) -> StatsdistmultinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdistmultinomialVector::scale(
  self : StatsdistmultinomialVector,
  s : Double,
) -> StatsdistmultinomialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatsdistmultinomialVector::dot(
  self : StatsdistmultinomialVector,
  other : StatsdistmultinomialVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatsdistmultinomialVector::norm(
  self : StatsdistmultinomialVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatsdistmultinomialVector::normalize(
  self : StatsdistmultinomialVector,
) -> StatsdistmultinomialVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdistmultinomialVector::dist(
  self : StatsdistmultinomialVector,
  other : StatsdistmultinomialVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatsdistmultinomialVector::to_string(
  self : StatsdistmultinomialVector,
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
pub(all) struct StatsdistmultinomialFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_frame_make(
  size : Int32,
) -> StatsdistmultinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialFrame::len(
  self : StatsdistmultinomialFrame,
) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialFrame::get(
  self : StatsdistmultinomialFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialFrame::set(
  self : StatsdistmultinomialFrame,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialFrame::sum(
  self : StatsdistmultinomialFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialFrame::mean(
  self : StatsdistmultinomialFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialFrame::scale(
  self : StatsdistmultinomialFrame,
  f : Double,
) -> StatsdistmultinomialFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialFrame::add(
  self : StatsdistmultinomialFrame,
  other : StatsdistmultinomialFrame,
) -> StatsdistmultinomialFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialFrame::copy(
  self : StatsdistmultinomialFrame,
) -> StatsdistmultinomialFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialFrame::fill(
  self : StatsdistmultinomialFrame,
  v : Double,
) -> StatsdistmultinomialFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialFrame::min(
  self : StatsdistmultinomialFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialFrame::max(
  self : StatsdistmultinomialFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialFrame::to_string(
  self : StatsdistmultinomialFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_table_make(
  size : Int32,
) -> StatsdistmultinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialTable::len(
  self : StatsdistmultinomialTable,
) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialTable::get(
  self : StatsdistmultinomialTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialTable::set(
  self : StatsdistmultinomialTable,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialTable::sum(
  self : StatsdistmultinomialTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialTable::mean(
  self : StatsdistmultinomialTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialTable::scale(
  self : StatsdistmultinomialTable,
  f : Double,
) -> StatsdistmultinomialTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialTable::add(
  self : StatsdistmultinomialTable,
  other : StatsdistmultinomialTable,
) -> StatsdistmultinomialTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialTable::copy(
  self : StatsdistmultinomialTable,
) -> StatsdistmultinomialTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialTable::fill(
  self : StatsdistmultinomialTable,
  v : Double,
) -> StatsdistmultinomialTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialTable::min(
  self : StatsdistmultinomialTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialTable::max(
  self : StatsdistmultinomialTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialTable::to_string(
  self : StatsdistmultinomialTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_graphn_make(
  size : Int32,
) -> StatsdistmultinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialGraphN::len(
  self : StatsdistmultinomialGraphN,
) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialGraphN::get(
  self : StatsdistmultinomialGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialGraphN::set(
  self : StatsdistmultinomialGraphN,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialGraphN::sum(
  self : StatsdistmultinomialGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialGraphN::mean(
  self : StatsdistmultinomialGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialGraphN::scale(
  self : StatsdistmultinomialGraphN,
  f : Double,
) -> StatsdistmultinomialGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialGraphN::add(
  self : StatsdistmultinomialGraphN,
  other : StatsdistmultinomialGraphN,
) -> StatsdistmultinomialGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialGraphN::copy(
  self : StatsdistmultinomialGraphN,
) -> StatsdistmultinomialGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialGraphN::fill(
  self : StatsdistmultinomialGraphN,
  v : Double,
) -> StatsdistmultinomialGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialGraphN::min(
  self : StatsdistmultinomialGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialGraphN::max(
  self : StatsdistmultinomialGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialGraphN::to_string(
  self : StatsdistmultinomialGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_node_make(
  size : Int32,
) -> StatsdistmultinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialNode::len(self : StatsdistmultinomialNode) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialNode::get(
  self : StatsdistmultinomialNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialNode::set(
  self : StatsdistmultinomialNode,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialNode::sum(self : StatsdistmultinomialNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialNode::mean(
  self : StatsdistmultinomialNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialNode::scale(
  self : StatsdistmultinomialNode,
  f : Double,
) -> StatsdistmultinomialNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialNode::add(
  self : StatsdistmultinomialNode,
  other : StatsdistmultinomialNode,
) -> StatsdistmultinomialNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialNode::copy(
  self : StatsdistmultinomialNode,
) -> StatsdistmultinomialNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialNode::fill(
  self : StatsdistmultinomialNode,
  v : Double,
) -> StatsdistmultinomialNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialNode::min(self : StatsdistmultinomialNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialNode::max(self : StatsdistmultinomialNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialNode::to_string(
  self : StatsdistmultinomialNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_edge_make(
  size : Int32,
) -> StatsdistmultinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialEdge::len(self : StatsdistmultinomialEdge) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialEdge::get(
  self : StatsdistmultinomialEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialEdge::set(
  self : StatsdistmultinomialEdge,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialEdge::sum(self : StatsdistmultinomialEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialEdge::mean(
  self : StatsdistmultinomialEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialEdge::scale(
  self : StatsdistmultinomialEdge,
  f : Double,
) -> StatsdistmultinomialEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialEdge::add(
  self : StatsdistmultinomialEdge,
  other : StatsdistmultinomialEdge,
) -> StatsdistmultinomialEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialEdge::copy(
  self : StatsdistmultinomialEdge,
) -> StatsdistmultinomialEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialEdge::fill(
  self : StatsdistmultinomialEdge,
  v : Double,
) -> StatsdistmultinomialEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialEdge::min(self : StatsdistmultinomialEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialEdge::max(self : StatsdistmultinomialEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialEdge::to_string(
  self : StatsdistmultinomialEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_path_make(
  size : Int32,
) -> StatsdistmultinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialPath::len(self : StatsdistmultinomialPath) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialPath::get(
  self : StatsdistmultinomialPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialPath::set(
  self : StatsdistmultinomialPath,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialPath::sum(self : StatsdistmultinomialPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialPath::mean(
  self : StatsdistmultinomialPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialPath::scale(
  self : StatsdistmultinomialPath,
  f : Double,
) -> StatsdistmultinomialPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialPath::add(
  self : StatsdistmultinomialPath,
  other : StatsdistmultinomialPath,
) -> StatsdistmultinomialPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialPath::copy(
  self : StatsdistmultinomialPath,
) -> StatsdistmultinomialPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialPath::fill(
  self : StatsdistmultinomialPath,
  v : Double,
) -> StatsdistmultinomialPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialPath::min(self : StatsdistmultinomialPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialPath::max(self : StatsdistmultinomialPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialPath::to_string(
  self : StatsdistmultinomialPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_cluster_make(
  size : Int32,
) -> StatsdistmultinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialCluster::len(
  self : StatsdistmultinomialCluster,
) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialCluster::get(
  self : StatsdistmultinomialCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialCluster::set(
  self : StatsdistmultinomialCluster,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialCluster::sum(
  self : StatsdistmultinomialCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialCluster::mean(
  self : StatsdistmultinomialCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialCluster::scale(
  self : StatsdistmultinomialCluster,
  f : Double,
) -> StatsdistmultinomialCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialCluster::add(
  self : StatsdistmultinomialCluster,
  other : StatsdistmultinomialCluster,
) -> StatsdistmultinomialCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialCluster::copy(
  self : StatsdistmultinomialCluster,
) -> StatsdistmultinomialCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialCluster::fill(
  self : StatsdistmultinomialCluster,
  v : Double,
) -> StatsdistmultinomialCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialCluster::min(
  self : StatsdistmultinomialCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialCluster::max(
  self : StatsdistmultinomialCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialCluster::to_string(
  self : StatsdistmultinomialCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_model_make(
  size : Int32,
) -> StatsdistmultinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialModel::len(
  self : StatsdistmultinomialModel,
) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialModel::get(
  self : StatsdistmultinomialModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialModel::set(
  self : StatsdistmultinomialModel,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialModel::sum(
  self : StatsdistmultinomialModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialModel::mean(
  self : StatsdistmultinomialModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialModel::scale(
  self : StatsdistmultinomialModel,
  f : Double,
) -> StatsdistmultinomialModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialModel::add(
  self : StatsdistmultinomialModel,
  other : StatsdistmultinomialModel,
) -> StatsdistmultinomialModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialModel::copy(
  self : StatsdistmultinomialModel,
) -> StatsdistmultinomialModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialModel::fill(
  self : StatsdistmultinomialModel,
  v : Double,
) -> StatsdistmultinomialModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialModel::min(
  self : StatsdistmultinomialModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialModel::max(
  self : StatsdistmultinomialModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialModel::to_string(
  self : StatsdistmultinomialModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_layer_make(
  size : Int32,
) -> StatsdistmultinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialLayer::len(
  self : StatsdistmultinomialLayer,
) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialLayer::get(
  self : StatsdistmultinomialLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialLayer::set(
  self : StatsdistmultinomialLayer,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialLayer::sum(
  self : StatsdistmultinomialLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialLayer::mean(
  self : StatsdistmultinomialLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialLayer::scale(
  self : StatsdistmultinomialLayer,
  f : Double,
) -> StatsdistmultinomialLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialLayer::add(
  self : StatsdistmultinomialLayer,
  other : StatsdistmultinomialLayer,
) -> StatsdistmultinomialLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialLayer::copy(
  self : StatsdistmultinomialLayer,
) -> StatsdistmultinomialLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialLayer::fill(
  self : StatsdistmultinomialLayer,
  v : Double,
) -> StatsdistmultinomialLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialLayer::min(
  self : StatsdistmultinomialLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialLayer::max(
  self : StatsdistmultinomialLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialLayer::to_string(
  self : StatsdistmultinomialLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_buffer_make(
  size : Int32,
) -> StatsdistmultinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialBuffer::len(
  self : StatsdistmultinomialBuffer,
) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialBuffer::get(
  self : StatsdistmultinomialBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialBuffer::set(
  self : StatsdistmultinomialBuffer,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialBuffer::sum(
  self : StatsdistmultinomialBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialBuffer::mean(
  self : StatsdistmultinomialBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialBuffer::scale(
  self : StatsdistmultinomialBuffer,
  f : Double,
) -> StatsdistmultinomialBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialBuffer::add(
  self : StatsdistmultinomialBuffer,
  other : StatsdistmultinomialBuffer,
) -> StatsdistmultinomialBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialBuffer::copy(
  self : StatsdistmultinomialBuffer,
) -> StatsdistmultinomialBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialBuffer::fill(
  self : StatsdistmultinomialBuffer,
  v : Double,
) -> StatsdistmultinomialBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialBuffer::min(
  self : StatsdistmultinomialBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialBuffer::max(
  self : StatsdistmultinomialBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialBuffer::to_string(
  self : StatsdistmultinomialBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_cursor_make(
  size : Int32,
) -> StatsdistmultinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialCursor::len(
  self : StatsdistmultinomialCursor,
) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialCursor::get(
  self : StatsdistmultinomialCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialCursor::set(
  self : StatsdistmultinomialCursor,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialCursor::sum(
  self : StatsdistmultinomialCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialCursor::mean(
  self : StatsdistmultinomialCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialCursor::scale(
  self : StatsdistmultinomialCursor,
  f : Double,
) -> StatsdistmultinomialCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialCursor::add(
  self : StatsdistmultinomialCursor,
  other : StatsdistmultinomialCursor,
) -> StatsdistmultinomialCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialCursor::copy(
  self : StatsdistmultinomialCursor,
) -> StatsdistmultinomialCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialCursor::fill(
  self : StatsdistmultinomialCursor,
  v : Double,
) -> StatsdistmultinomialCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialCursor::min(
  self : StatsdistmultinomialCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialCursor::max(
  self : StatsdistmultinomialCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialCursor::to_string(
  self : StatsdistmultinomialCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_view_make(
  size : Int32,
) -> StatsdistmultinomialView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialView::len(self : StatsdistmultinomialView) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialView::get(
  self : StatsdistmultinomialView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialView::set(
  self : StatsdistmultinomialView,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialView::sum(self : StatsdistmultinomialView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialView::mean(
  self : StatsdistmultinomialView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialView::scale(
  self : StatsdistmultinomialView,
  f : Double,
) -> StatsdistmultinomialView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialView::add(
  self : StatsdistmultinomialView,
  other : StatsdistmultinomialView,
) -> StatsdistmultinomialView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialView::copy(
  self : StatsdistmultinomialView,
) -> StatsdistmultinomialView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialView::fill(
  self : StatsdistmultinomialView,
  v : Double,
) -> StatsdistmultinomialView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialView::min(self : StatsdistmultinomialView) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialView::max(self : StatsdistmultinomialView) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialView::to_string(
  self : StatsdistmultinomialView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_range_make(
  size : Int32,
) -> StatsdistmultinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialRange::len(
  self : StatsdistmultinomialRange,
) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialRange::get(
  self : StatsdistmultinomialRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialRange::set(
  self : StatsdistmultinomialRange,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialRange::sum(
  self : StatsdistmultinomialRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialRange::mean(
  self : StatsdistmultinomialRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialRange::scale(
  self : StatsdistmultinomialRange,
  f : Double,
) -> StatsdistmultinomialRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialRange::add(
  self : StatsdistmultinomialRange,
  other : StatsdistmultinomialRange,
) -> StatsdistmultinomialRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialRange::copy(
  self : StatsdistmultinomialRange,
) -> StatsdistmultinomialRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialRange::fill(
  self : StatsdistmultinomialRange,
  v : Double,
) -> StatsdistmultinomialRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialRange::min(
  self : StatsdistmultinomialRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialRange::max(
  self : StatsdistmultinomialRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialRange::to_string(
  self : StatsdistmultinomialRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistmultinomialSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_multinomial_slice_make(
  size : Int32,
) -> StatsdistmultinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistmultinomialSlice::len(
  self : StatsdistmultinomialSlice,
) -> Int32 {
  self.size
}

///|
pub fn StatsdistmultinomialSlice::get(
  self : StatsdistmultinomialSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistmultinomialSlice::set(
  self : StatsdistmultinomialSlice,
  i : Int32,
  v : Double,
) -> StatsdistmultinomialSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialSlice::sum(
  self : StatsdistmultinomialSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistmultinomialSlice::mean(
  self : StatsdistmultinomialSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistmultinomialSlice::scale(
  self : StatsdistmultinomialSlice,
  f : Double,
) -> StatsdistmultinomialSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialSlice::add(
  self : StatsdistmultinomialSlice,
  other : StatsdistmultinomialSlice,
) -> StatsdistmultinomialSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialSlice::copy(
  self : StatsdistmultinomialSlice,
) -> StatsdistmultinomialSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialSlice::fill(
  self : StatsdistmultinomialSlice,
  v : Double,
) -> StatsdistmultinomialSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistmultinomialSlice::min(
  self : StatsdistmultinomialSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistmultinomialSlice::max(
  self : StatsdistmultinomialSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistmultinomialSlice::to_string(
  self : StatsdistmultinomialSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
