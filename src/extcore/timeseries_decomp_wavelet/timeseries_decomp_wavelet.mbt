///|
///===
/// extcore/timeseries_decomp_wavelet
pub(all) struct TimeseriesdecompwaveletPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn timeseries_decomp_wavelet_make_point(
  x : Double,
  y : Double,
) -> TimeseriesdecompwaveletPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn timeseries_decomp_wavelet_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> TimeseriesdecompwaveletPoint {
  { x, y, z, label: 0, }
}

///|
pub fn TimeseriesdecompwaveletPoint::x(
  self : TimeseriesdecompwaveletPoint,
) -> Double {
  self.x
}

///|
pub fn TimeseriesdecompwaveletPoint::y(
  self : TimeseriesdecompwaveletPoint,
) -> Double {
  self.y
}

///|
pub fn TimeseriesdecompwaveletPoint::z(
  self : TimeseriesdecompwaveletPoint,
) -> Double {
  self.z
}

///|
pub fn TimeseriesdecompwaveletPoint::label(
  self : TimeseriesdecompwaveletPoint,
) -> Int32 {
  self.label
}

///|
pub fn TimeseriesdecompwaveletPoint::dist(
  self : TimeseriesdecompwaveletPoint,
  other : TimeseriesdecompwaveletPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn TimeseriesdecompwaveletPoint::add(
  self : TimeseriesdecompwaveletPoint,
  other : TimeseriesdecompwaveletPoint,
) -> TimeseriesdecompwaveletPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn TimeseriesdecompwaveletPoint::sub(
  self : TimeseriesdecompwaveletPoint,
  other : TimeseriesdecompwaveletPoint,
) -> TimeseriesdecompwaveletPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn TimeseriesdecompwaveletPoint::scale(
  self : TimeseriesdecompwaveletPoint,
  s : Double,
) -> TimeseriesdecompwaveletPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn TimeseriesdecompwaveletPoint::dot(
  self : TimeseriesdecompwaveletPoint,
  other : TimeseriesdecompwaveletPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn TimeseriesdecompwaveletPoint::cross(
  self : TimeseriesdecompwaveletPoint,
  other : TimeseriesdecompwaveletPoint,
) -> TimeseriesdecompwaveletPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn TimeseriesdecompwaveletPoint::norm(
  self : TimeseriesdecompwaveletPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn TimeseriesdecompwaveletPoint::normalize(
  self : TimeseriesdecompwaveletPoint,
) -> TimeseriesdecompwaveletPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn TimeseriesdecompwaveletPoint::negate(
  self : TimeseriesdecompwaveletPoint,
) -> TimeseriesdecompwaveletPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn TimeseriesdecompwaveletPoint::mid(
  self : TimeseriesdecompwaveletPoint,
  other : TimeseriesdecompwaveletPoint,
) -> TimeseriesdecompwaveletPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn TimeseriesdecompwaveletPoint::lerp(
  self : TimeseriesdecompwaveletPoint,
  other : TimeseriesdecompwaveletPoint,
  t : Double,
) -> TimeseriesdecompwaveletPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn TimeseriesdecompwaveletPoint::to_string(
  self : TimeseriesdecompwaveletPoint,
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
pub(all) struct TimeseriesdecompwaveletSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn timeseries_decomp_wavelet_make_series(
  vals : Array[Double],
  name : String,
) -> TimeseriesdecompwaveletSeries {
  { vals, name, meta: 0, }
}

///|
pub fn TimeseriesdecompwaveletSeries::len(
  self : TimeseriesdecompwaveletSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn TimeseriesdecompwaveletSeries::sum(
  self : TimeseriesdecompwaveletSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn TimeseriesdecompwaveletSeries::mean(
  self : TimeseriesdecompwaveletSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn TimeseriesdecompwaveletSeries::min(
  self : TimeseriesdecompwaveletSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn TimeseriesdecompwaveletSeries::max(
  self : TimeseriesdecompwaveletSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn TimeseriesdecompwaveletSeries::range(
  self : TimeseriesdecompwaveletSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn TimeseriesdecompwaveletSeries::variance(
  self : TimeseriesdecompwaveletSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn TimeseriesdecompwaveletSeries::std(
  self : TimeseriesdecompwaveletSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn TimeseriesdecompwaveletSeries::median(
  self : TimeseriesdecompwaveletSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn TimeseriesdecompwaveletSeries::scale(
  self : TimeseriesdecompwaveletSeries,
  f : Double,
) -> TimeseriesdecompwaveletSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn TimeseriesdecompwaveletSeries::add(
  self : TimeseriesdecompwaveletSeries,
  other : TimeseriesdecompwaveletSeries,
) -> TimeseriesdecompwaveletSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn TimeseriesdecompwaveletSeries::sub(
  self : TimeseriesdecompwaveletSeries,
  other : TimeseriesdecompwaveletSeries,
) -> TimeseriesdecompwaveletSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn TimeseriesdecompwaveletSeries::normalize(
  self : TimeseriesdecompwaveletSeries,
) -> TimeseriesdecompwaveletSeries {
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
pub fn TimeseriesdecompwaveletSeries::cumsum(
  self : TimeseriesdecompwaveletSeries,
) -> TimeseriesdecompwaveletSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn TimeseriesdecompwaveletSeries::to_string(
  self : TimeseriesdecompwaveletSeries,
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
pub(all) struct TimeseriesdecompwaveletMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn timeseries_decomp_wavelet_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> TimeseriesdecompwaveletMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn timeseries_decomp_wavelet_matrix_identity(
  n : Int32,
) -> TimeseriesdecompwaveletMatrix {
  let m = timeseries_decomp_wavelet_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn TimeseriesdecompwaveletMatrix::get(
  self : TimeseriesdecompwaveletMatrix,
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
pub fn TimeseriesdecompwaveletMatrix::transpose(
  self : TimeseriesdecompwaveletMatrix,
) -> TimeseriesdecompwaveletMatrix {
  let result = timeseries_decomp_wavelet_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn TimeseriesdecompwaveletMatrix::add(
  self : TimeseriesdecompwaveletMatrix,
  other : TimeseriesdecompwaveletMatrix,
) -> TimeseriesdecompwaveletMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = timeseries_decomp_wavelet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn TimeseriesdecompwaveletMatrix::scale(
  self : TimeseriesdecompwaveletMatrix,
  s : Double,
) -> TimeseriesdecompwaveletMatrix {
  let result = timeseries_decomp_wavelet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn TimeseriesdecompwaveletMatrix::multiply(
  self : TimeseriesdecompwaveletMatrix,
  other : TimeseriesdecompwaveletMatrix,
) -> TimeseriesdecompwaveletMatrix {
  if self.cols != other.rows {
    return timeseries_decomp_wavelet_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = timeseries_decomp_wavelet_make_matrix(self.rows, other.cols, 0.0)
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
pub fn TimeseriesdecompwaveletMatrix::trace(
  self : TimeseriesdecompwaveletMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn TimeseriesdecompwaveletMatrix::det(
  self : TimeseriesdecompwaveletMatrix,
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
pub fn TimeseriesdecompwaveletMatrix::norm(
  self : TimeseriesdecompwaveletMatrix,
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
pub fn TimeseriesdecompwaveletMatrix::to_string(
  self : TimeseriesdecompwaveletMatrix,
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
pub(all) struct TimeseriesdecompwaveletVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn timeseries_decomp_wavelet_make_vector(
  comps : Array[Double],
) -> TimeseriesdecompwaveletVector {
  { comps, dim: comps.length(), }
}

///|
pub fn timeseries_decomp_wavelet_vector_zero(
  dim : Int32,
) -> TimeseriesdecompwaveletVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn TimeseriesdecompwaveletVector::add(
  self : TimeseriesdecompwaveletVector,
  other : TimeseriesdecompwaveletVector,
) -> TimeseriesdecompwaveletVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn TimeseriesdecompwaveletVector::sub(
  self : TimeseriesdecompwaveletVector,
  other : TimeseriesdecompwaveletVector,
) -> TimeseriesdecompwaveletVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn TimeseriesdecompwaveletVector::scale(
  self : TimeseriesdecompwaveletVector,
  s : Double,
) -> TimeseriesdecompwaveletVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn TimeseriesdecompwaveletVector::dot(
  self : TimeseriesdecompwaveletVector,
  other : TimeseriesdecompwaveletVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn TimeseriesdecompwaveletVector::norm(
  self : TimeseriesdecompwaveletVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn TimeseriesdecompwaveletVector::normalize(
  self : TimeseriesdecompwaveletVector,
) -> TimeseriesdecompwaveletVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn TimeseriesdecompwaveletVector::dist(
  self : TimeseriesdecompwaveletVector,
  other : TimeseriesdecompwaveletVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn TimeseriesdecompwaveletVector::to_string(
  self : TimeseriesdecompwaveletVector,
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
pub(all) struct TimeseriesdecompwaveletFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_frame_make(
  size : Int32,
) -> TimeseriesdecompwaveletFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletFrame::len(
  self : TimeseriesdecompwaveletFrame,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletFrame::get(
  self : TimeseriesdecompwaveletFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletFrame::set(
  self : TimeseriesdecompwaveletFrame,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletFrame::sum(
  self : TimeseriesdecompwaveletFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletFrame::mean(
  self : TimeseriesdecompwaveletFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletFrame::scale(
  self : TimeseriesdecompwaveletFrame,
  f : Double,
) -> TimeseriesdecompwaveletFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletFrame::add(
  self : TimeseriesdecompwaveletFrame,
  other : TimeseriesdecompwaveletFrame,
) -> TimeseriesdecompwaveletFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletFrame::copy(
  self : TimeseriesdecompwaveletFrame,
) -> TimeseriesdecompwaveletFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletFrame::fill(
  self : TimeseriesdecompwaveletFrame,
  v : Double,
) -> TimeseriesdecompwaveletFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletFrame::min(
  self : TimeseriesdecompwaveletFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletFrame::max(
  self : TimeseriesdecompwaveletFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletFrame::to_string(
  self : TimeseriesdecompwaveletFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_table_make(
  size : Int32,
) -> TimeseriesdecompwaveletTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletTable::len(
  self : TimeseriesdecompwaveletTable,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletTable::get(
  self : TimeseriesdecompwaveletTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletTable::set(
  self : TimeseriesdecompwaveletTable,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletTable::sum(
  self : TimeseriesdecompwaveletTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletTable::mean(
  self : TimeseriesdecompwaveletTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletTable::scale(
  self : TimeseriesdecompwaveletTable,
  f : Double,
) -> TimeseriesdecompwaveletTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletTable::add(
  self : TimeseriesdecompwaveletTable,
  other : TimeseriesdecompwaveletTable,
) -> TimeseriesdecompwaveletTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletTable::copy(
  self : TimeseriesdecompwaveletTable,
) -> TimeseriesdecompwaveletTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletTable::fill(
  self : TimeseriesdecompwaveletTable,
  v : Double,
) -> TimeseriesdecompwaveletTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletTable::min(
  self : TimeseriesdecompwaveletTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletTable::max(
  self : TimeseriesdecompwaveletTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletTable::to_string(
  self : TimeseriesdecompwaveletTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_graphn_make(
  size : Int32,
) -> TimeseriesdecompwaveletGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletGraphN::len(
  self : TimeseriesdecompwaveletGraphN,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletGraphN::get(
  self : TimeseriesdecompwaveletGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletGraphN::set(
  self : TimeseriesdecompwaveletGraphN,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletGraphN::sum(
  self : TimeseriesdecompwaveletGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletGraphN::mean(
  self : TimeseriesdecompwaveletGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletGraphN::scale(
  self : TimeseriesdecompwaveletGraphN,
  f : Double,
) -> TimeseriesdecompwaveletGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletGraphN::add(
  self : TimeseriesdecompwaveletGraphN,
  other : TimeseriesdecompwaveletGraphN,
) -> TimeseriesdecompwaveletGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletGraphN::copy(
  self : TimeseriesdecompwaveletGraphN,
) -> TimeseriesdecompwaveletGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletGraphN::fill(
  self : TimeseriesdecompwaveletGraphN,
  v : Double,
) -> TimeseriesdecompwaveletGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletGraphN::min(
  self : TimeseriesdecompwaveletGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletGraphN::max(
  self : TimeseriesdecompwaveletGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletGraphN::to_string(
  self : TimeseriesdecompwaveletGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_node_make(
  size : Int32,
) -> TimeseriesdecompwaveletNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletNode::len(
  self : TimeseriesdecompwaveletNode,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletNode::get(
  self : TimeseriesdecompwaveletNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletNode::set(
  self : TimeseriesdecompwaveletNode,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletNode::sum(
  self : TimeseriesdecompwaveletNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletNode::mean(
  self : TimeseriesdecompwaveletNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletNode::scale(
  self : TimeseriesdecompwaveletNode,
  f : Double,
) -> TimeseriesdecompwaveletNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletNode::add(
  self : TimeseriesdecompwaveletNode,
  other : TimeseriesdecompwaveletNode,
) -> TimeseriesdecompwaveletNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletNode::copy(
  self : TimeseriesdecompwaveletNode,
) -> TimeseriesdecompwaveletNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletNode::fill(
  self : TimeseriesdecompwaveletNode,
  v : Double,
) -> TimeseriesdecompwaveletNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletNode::min(
  self : TimeseriesdecompwaveletNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletNode::max(
  self : TimeseriesdecompwaveletNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletNode::to_string(
  self : TimeseriesdecompwaveletNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_edge_make(
  size : Int32,
) -> TimeseriesdecompwaveletEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletEdge::len(
  self : TimeseriesdecompwaveletEdge,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletEdge::get(
  self : TimeseriesdecompwaveletEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletEdge::set(
  self : TimeseriesdecompwaveletEdge,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletEdge::sum(
  self : TimeseriesdecompwaveletEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletEdge::mean(
  self : TimeseriesdecompwaveletEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletEdge::scale(
  self : TimeseriesdecompwaveletEdge,
  f : Double,
) -> TimeseriesdecompwaveletEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletEdge::add(
  self : TimeseriesdecompwaveletEdge,
  other : TimeseriesdecompwaveletEdge,
) -> TimeseriesdecompwaveletEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletEdge::copy(
  self : TimeseriesdecompwaveletEdge,
) -> TimeseriesdecompwaveletEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletEdge::fill(
  self : TimeseriesdecompwaveletEdge,
  v : Double,
) -> TimeseriesdecompwaveletEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletEdge::min(
  self : TimeseriesdecompwaveletEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletEdge::max(
  self : TimeseriesdecompwaveletEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletEdge::to_string(
  self : TimeseriesdecompwaveletEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_path_make(
  size : Int32,
) -> TimeseriesdecompwaveletPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletPath::len(
  self : TimeseriesdecompwaveletPath,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletPath::get(
  self : TimeseriesdecompwaveletPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletPath::set(
  self : TimeseriesdecompwaveletPath,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletPath::sum(
  self : TimeseriesdecompwaveletPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletPath::mean(
  self : TimeseriesdecompwaveletPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletPath::scale(
  self : TimeseriesdecompwaveletPath,
  f : Double,
) -> TimeseriesdecompwaveletPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletPath::add(
  self : TimeseriesdecompwaveletPath,
  other : TimeseriesdecompwaveletPath,
) -> TimeseriesdecompwaveletPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletPath::copy(
  self : TimeseriesdecompwaveletPath,
) -> TimeseriesdecompwaveletPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletPath::fill(
  self : TimeseriesdecompwaveletPath,
  v : Double,
) -> TimeseriesdecompwaveletPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletPath::min(
  self : TimeseriesdecompwaveletPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletPath::max(
  self : TimeseriesdecompwaveletPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletPath::to_string(
  self : TimeseriesdecompwaveletPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_cluster_make(
  size : Int32,
) -> TimeseriesdecompwaveletCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletCluster::len(
  self : TimeseriesdecompwaveletCluster,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletCluster::get(
  self : TimeseriesdecompwaveletCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletCluster::set(
  self : TimeseriesdecompwaveletCluster,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletCluster::sum(
  self : TimeseriesdecompwaveletCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletCluster::mean(
  self : TimeseriesdecompwaveletCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletCluster::scale(
  self : TimeseriesdecompwaveletCluster,
  f : Double,
) -> TimeseriesdecompwaveletCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletCluster::add(
  self : TimeseriesdecompwaveletCluster,
  other : TimeseriesdecompwaveletCluster,
) -> TimeseriesdecompwaveletCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletCluster::copy(
  self : TimeseriesdecompwaveletCluster,
) -> TimeseriesdecompwaveletCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletCluster::fill(
  self : TimeseriesdecompwaveletCluster,
  v : Double,
) -> TimeseriesdecompwaveletCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletCluster::min(
  self : TimeseriesdecompwaveletCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletCluster::max(
  self : TimeseriesdecompwaveletCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletCluster::to_string(
  self : TimeseriesdecompwaveletCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_model_make(
  size : Int32,
) -> TimeseriesdecompwaveletModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletModel::len(
  self : TimeseriesdecompwaveletModel,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletModel::get(
  self : TimeseriesdecompwaveletModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletModel::set(
  self : TimeseriesdecompwaveletModel,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletModel::sum(
  self : TimeseriesdecompwaveletModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletModel::mean(
  self : TimeseriesdecompwaveletModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletModel::scale(
  self : TimeseriesdecompwaveletModel,
  f : Double,
) -> TimeseriesdecompwaveletModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletModel::add(
  self : TimeseriesdecompwaveletModel,
  other : TimeseriesdecompwaveletModel,
) -> TimeseriesdecompwaveletModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletModel::copy(
  self : TimeseriesdecompwaveletModel,
) -> TimeseriesdecompwaveletModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletModel::fill(
  self : TimeseriesdecompwaveletModel,
  v : Double,
) -> TimeseriesdecompwaveletModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletModel::min(
  self : TimeseriesdecompwaveletModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletModel::max(
  self : TimeseriesdecompwaveletModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletModel::to_string(
  self : TimeseriesdecompwaveletModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_layer_make(
  size : Int32,
) -> TimeseriesdecompwaveletLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletLayer::len(
  self : TimeseriesdecompwaveletLayer,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletLayer::get(
  self : TimeseriesdecompwaveletLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletLayer::set(
  self : TimeseriesdecompwaveletLayer,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletLayer::sum(
  self : TimeseriesdecompwaveletLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletLayer::mean(
  self : TimeseriesdecompwaveletLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletLayer::scale(
  self : TimeseriesdecompwaveletLayer,
  f : Double,
) -> TimeseriesdecompwaveletLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletLayer::add(
  self : TimeseriesdecompwaveletLayer,
  other : TimeseriesdecompwaveletLayer,
) -> TimeseriesdecompwaveletLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletLayer::copy(
  self : TimeseriesdecompwaveletLayer,
) -> TimeseriesdecompwaveletLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletLayer::fill(
  self : TimeseriesdecompwaveletLayer,
  v : Double,
) -> TimeseriesdecompwaveletLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletLayer::min(
  self : TimeseriesdecompwaveletLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletLayer::max(
  self : TimeseriesdecompwaveletLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletLayer::to_string(
  self : TimeseriesdecompwaveletLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_buffer_make(
  size : Int32,
) -> TimeseriesdecompwaveletBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletBuffer::len(
  self : TimeseriesdecompwaveletBuffer,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletBuffer::get(
  self : TimeseriesdecompwaveletBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletBuffer::set(
  self : TimeseriesdecompwaveletBuffer,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletBuffer::sum(
  self : TimeseriesdecompwaveletBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletBuffer::mean(
  self : TimeseriesdecompwaveletBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletBuffer::scale(
  self : TimeseriesdecompwaveletBuffer,
  f : Double,
) -> TimeseriesdecompwaveletBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletBuffer::add(
  self : TimeseriesdecompwaveletBuffer,
  other : TimeseriesdecompwaveletBuffer,
) -> TimeseriesdecompwaveletBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletBuffer::copy(
  self : TimeseriesdecompwaveletBuffer,
) -> TimeseriesdecompwaveletBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletBuffer::fill(
  self : TimeseriesdecompwaveletBuffer,
  v : Double,
) -> TimeseriesdecompwaveletBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletBuffer::min(
  self : TimeseriesdecompwaveletBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletBuffer::max(
  self : TimeseriesdecompwaveletBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletBuffer::to_string(
  self : TimeseriesdecompwaveletBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_cursor_make(
  size : Int32,
) -> TimeseriesdecompwaveletCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletCursor::len(
  self : TimeseriesdecompwaveletCursor,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletCursor::get(
  self : TimeseriesdecompwaveletCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletCursor::set(
  self : TimeseriesdecompwaveletCursor,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletCursor::sum(
  self : TimeseriesdecompwaveletCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletCursor::mean(
  self : TimeseriesdecompwaveletCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletCursor::scale(
  self : TimeseriesdecompwaveletCursor,
  f : Double,
) -> TimeseriesdecompwaveletCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletCursor::add(
  self : TimeseriesdecompwaveletCursor,
  other : TimeseriesdecompwaveletCursor,
) -> TimeseriesdecompwaveletCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletCursor::copy(
  self : TimeseriesdecompwaveletCursor,
) -> TimeseriesdecompwaveletCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletCursor::fill(
  self : TimeseriesdecompwaveletCursor,
  v : Double,
) -> TimeseriesdecompwaveletCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletCursor::min(
  self : TimeseriesdecompwaveletCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletCursor::max(
  self : TimeseriesdecompwaveletCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletCursor::to_string(
  self : TimeseriesdecompwaveletCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_view_make(
  size : Int32,
) -> TimeseriesdecompwaveletView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletView::len(
  self : TimeseriesdecompwaveletView,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletView::get(
  self : TimeseriesdecompwaveletView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletView::set(
  self : TimeseriesdecompwaveletView,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletView::sum(
  self : TimeseriesdecompwaveletView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletView::mean(
  self : TimeseriesdecompwaveletView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletView::scale(
  self : TimeseriesdecompwaveletView,
  f : Double,
) -> TimeseriesdecompwaveletView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletView::add(
  self : TimeseriesdecompwaveletView,
  other : TimeseriesdecompwaveletView,
) -> TimeseriesdecompwaveletView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletView::copy(
  self : TimeseriesdecompwaveletView,
) -> TimeseriesdecompwaveletView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletView::fill(
  self : TimeseriesdecompwaveletView,
  v : Double,
) -> TimeseriesdecompwaveletView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletView::min(
  self : TimeseriesdecompwaveletView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletView::max(
  self : TimeseriesdecompwaveletView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletView::to_string(
  self : TimeseriesdecompwaveletView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_range_make(
  size : Int32,
) -> TimeseriesdecompwaveletRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletRange::len(
  self : TimeseriesdecompwaveletRange,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletRange::get(
  self : TimeseriesdecompwaveletRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletRange::set(
  self : TimeseriesdecompwaveletRange,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletRange::sum(
  self : TimeseriesdecompwaveletRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletRange::mean(
  self : TimeseriesdecompwaveletRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletRange::scale(
  self : TimeseriesdecompwaveletRange,
  f : Double,
) -> TimeseriesdecompwaveletRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletRange::add(
  self : TimeseriesdecompwaveletRange,
  other : TimeseriesdecompwaveletRange,
) -> TimeseriesdecompwaveletRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletRange::copy(
  self : TimeseriesdecompwaveletRange,
) -> TimeseriesdecompwaveletRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletRange::fill(
  self : TimeseriesdecompwaveletRange,
  v : Double,
) -> TimeseriesdecompwaveletRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletRange::min(
  self : TimeseriesdecompwaveletRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletRange::max(
  self : TimeseriesdecompwaveletRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletRange::to_string(
  self : TimeseriesdecompwaveletRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompwaveletSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_wavelet_slice_make(
  size : Int32,
) -> TimeseriesdecompwaveletSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompwaveletSlice::len(
  self : TimeseriesdecompwaveletSlice,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompwaveletSlice::get(
  self : TimeseriesdecompwaveletSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompwaveletSlice::set(
  self : TimeseriesdecompwaveletSlice,
  i : Int32,
  v : Double,
) -> TimeseriesdecompwaveletSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletSlice::sum(
  self : TimeseriesdecompwaveletSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompwaveletSlice::mean(
  self : TimeseriesdecompwaveletSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompwaveletSlice::scale(
  self : TimeseriesdecompwaveletSlice,
  f : Double,
) -> TimeseriesdecompwaveletSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletSlice::add(
  self : TimeseriesdecompwaveletSlice,
  other : TimeseriesdecompwaveletSlice,
) -> TimeseriesdecompwaveletSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletSlice::copy(
  self : TimeseriesdecompwaveletSlice,
) -> TimeseriesdecompwaveletSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletSlice::fill(
  self : TimeseriesdecompwaveletSlice,
  v : Double,
) -> TimeseriesdecompwaveletSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompwaveletSlice::min(
  self : TimeseriesdecompwaveletSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompwaveletSlice::max(
  self : TimeseriesdecompwaveletSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompwaveletSlice::to_string(
  self : TimeseriesdecompwaveletSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
