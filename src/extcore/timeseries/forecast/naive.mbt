///|
///===
/// extcore/timeseries_forecast_naive
pub(all) struct TimeseriesforecastnaivePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn timeseries_forecast_naive_make_point(
  x : Double,
  y : Double,
) -> TimeseriesforecastnaivePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn timeseries_forecast_naive_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> TimeseriesforecastnaivePoint {
  { x, y, z, label: 0, }
}

///|
pub fn TimeseriesforecastnaivePoint::x(
  self : TimeseriesforecastnaivePoint,
) -> Double {
  self.x
}

///|
pub fn TimeseriesforecastnaivePoint::y(
  self : TimeseriesforecastnaivePoint,
) -> Double {
  self.y
}

///|
pub fn TimeseriesforecastnaivePoint::z(
  self : TimeseriesforecastnaivePoint,
) -> Double {
  self.z
}

///|
pub fn TimeseriesforecastnaivePoint::label(
  self : TimeseriesforecastnaivePoint,
) -> Int32 {
  self.label
}

///|
pub fn TimeseriesforecastnaivePoint::dist(
  self : TimeseriesforecastnaivePoint,
  other : TimeseriesforecastnaivePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn TimeseriesforecastnaivePoint::add(
  self : TimeseriesforecastnaivePoint,
  other : TimeseriesforecastnaivePoint,
) -> TimeseriesforecastnaivePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn TimeseriesforecastnaivePoint::sub(
  self : TimeseriesforecastnaivePoint,
  other : TimeseriesforecastnaivePoint,
) -> TimeseriesforecastnaivePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn TimeseriesforecastnaivePoint::scale(
  self : TimeseriesforecastnaivePoint,
  s : Double,
) -> TimeseriesforecastnaivePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn TimeseriesforecastnaivePoint::dot(
  self : TimeseriesforecastnaivePoint,
  other : TimeseriesforecastnaivePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn TimeseriesforecastnaivePoint::cross(
  self : TimeseriesforecastnaivePoint,
  other : TimeseriesforecastnaivePoint,
) -> TimeseriesforecastnaivePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn TimeseriesforecastnaivePoint::norm(
  self : TimeseriesforecastnaivePoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn TimeseriesforecastnaivePoint::normalize(
  self : TimeseriesforecastnaivePoint,
) -> TimeseriesforecastnaivePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn TimeseriesforecastnaivePoint::negate(
  self : TimeseriesforecastnaivePoint,
) -> TimeseriesforecastnaivePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn TimeseriesforecastnaivePoint::mid(
  self : TimeseriesforecastnaivePoint,
  other : TimeseriesforecastnaivePoint,
) -> TimeseriesforecastnaivePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn TimeseriesforecastnaivePoint::lerp(
  self : TimeseriesforecastnaivePoint,
  other : TimeseriesforecastnaivePoint,
  t : Double,
) -> TimeseriesforecastnaivePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn TimeseriesforecastnaivePoint::to_string(
  self : TimeseriesforecastnaivePoint,
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
pub(all) struct TimeseriesforecastnaiveSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn timeseries_forecast_naive_make_series(
  vals : Array[Double],
  name : String,
) -> TimeseriesforecastnaiveSeries {
  { vals, name, meta: 0, }
}

///|
pub fn TimeseriesforecastnaiveSeries::len(
  self : TimeseriesforecastnaiveSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn TimeseriesforecastnaiveSeries::sum(
  self : TimeseriesforecastnaiveSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn TimeseriesforecastnaiveSeries::mean(
  self : TimeseriesforecastnaiveSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn TimeseriesforecastnaiveSeries::min(
  self : TimeseriesforecastnaiveSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn TimeseriesforecastnaiveSeries::max(
  self : TimeseriesforecastnaiveSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn TimeseriesforecastnaiveSeries::range(
  self : TimeseriesforecastnaiveSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn TimeseriesforecastnaiveSeries::variance(
  self : TimeseriesforecastnaiveSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn TimeseriesforecastnaiveSeries::std(
  self : TimeseriesforecastnaiveSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn TimeseriesforecastnaiveSeries::median(
  self : TimeseriesforecastnaiveSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn TimeseriesforecastnaiveSeries::scale(
  self : TimeseriesforecastnaiveSeries,
  f : Double,
) -> TimeseriesforecastnaiveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn TimeseriesforecastnaiveSeries::add(
  self : TimeseriesforecastnaiveSeries,
  other : TimeseriesforecastnaiveSeries,
) -> TimeseriesforecastnaiveSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn TimeseriesforecastnaiveSeries::sub(
  self : TimeseriesforecastnaiveSeries,
  other : TimeseriesforecastnaiveSeries,
) -> TimeseriesforecastnaiveSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn TimeseriesforecastnaiveSeries::normalize(
  self : TimeseriesforecastnaiveSeries,
) -> TimeseriesforecastnaiveSeries {
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
pub fn TimeseriesforecastnaiveSeries::cumsum(
  self : TimeseriesforecastnaiveSeries,
) -> TimeseriesforecastnaiveSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn TimeseriesforecastnaiveSeries::to_string(
  self : TimeseriesforecastnaiveSeries,
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
pub(all) struct TimeseriesforecastnaiveMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn timeseries_forecast_naive_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> TimeseriesforecastnaiveMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn timeseries_forecast_naive_matrix_identity(
  n : Int32,
) -> TimeseriesforecastnaiveMatrix {
  let m = timeseries_forecast_naive_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn TimeseriesforecastnaiveMatrix::get(
  self : TimeseriesforecastnaiveMatrix,
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
pub fn TimeseriesforecastnaiveMatrix::transpose(
  self : TimeseriesforecastnaiveMatrix,
) -> TimeseriesforecastnaiveMatrix {
  let result = timeseries_forecast_naive_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn TimeseriesforecastnaiveMatrix::add(
  self : TimeseriesforecastnaiveMatrix,
  other : TimeseriesforecastnaiveMatrix,
) -> TimeseriesforecastnaiveMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = timeseries_forecast_naive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn TimeseriesforecastnaiveMatrix::scale(
  self : TimeseriesforecastnaiveMatrix,
  s : Double,
) -> TimeseriesforecastnaiveMatrix {
  let result = timeseries_forecast_naive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn TimeseriesforecastnaiveMatrix::multiply(
  self : TimeseriesforecastnaiveMatrix,
  other : TimeseriesforecastnaiveMatrix,
) -> TimeseriesforecastnaiveMatrix {
  if self.cols != other.rows {
    return timeseries_forecast_naive_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = timeseries_forecast_naive_make_matrix(self.rows, other.cols, 0.0)
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
pub fn TimeseriesforecastnaiveMatrix::trace(
  self : TimeseriesforecastnaiveMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn TimeseriesforecastnaiveMatrix::det(
  self : TimeseriesforecastnaiveMatrix,
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
pub fn TimeseriesforecastnaiveMatrix::norm(
  self : TimeseriesforecastnaiveMatrix,
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
pub fn TimeseriesforecastnaiveMatrix::to_string(
  self : TimeseriesforecastnaiveMatrix,
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
pub(all) struct TimeseriesforecastnaiveVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn timeseries_forecast_naive_make_vector(
  comps : Array[Double],
) -> TimeseriesforecastnaiveVector {
  { comps, dim: comps.length(), }
}

///|
pub fn timeseries_forecast_naive_vector_zero(
  dim : Int32,
) -> TimeseriesforecastnaiveVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn TimeseriesforecastnaiveVector::add(
  self : TimeseriesforecastnaiveVector,
  other : TimeseriesforecastnaiveVector,
) -> TimeseriesforecastnaiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn TimeseriesforecastnaiveVector::sub(
  self : TimeseriesforecastnaiveVector,
  other : TimeseriesforecastnaiveVector,
) -> TimeseriesforecastnaiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn TimeseriesforecastnaiveVector::scale(
  self : TimeseriesforecastnaiveVector,
  s : Double,
) -> TimeseriesforecastnaiveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn TimeseriesforecastnaiveVector::dot(
  self : TimeseriesforecastnaiveVector,
  other : TimeseriesforecastnaiveVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn TimeseriesforecastnaiveVector::norm(
  self : TimeseriesforecastnaiveVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn TimeseriesforecastnaiveVector::normalize(
  self : TimeseriesforecastnaiveVector,
) -> TimeseriesforecastnaiveVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn TimeseriesforecastnaiveVector::dist(
  self : TimeseriesforecastnaiveVector,
  other : TimeseriesforecastnaiveVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn TimeseriesforecastnaiveVector::to_string(
  self : TimeseriesforecastnaiveVector,
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
pub(all) struct TimeseriesforecastnaiveFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_frame_make(
  size : Int32,
) -> TimeseriesforecastnaiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveFrame::len(
  self : TimeseriesforecastnaiveFrame,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveFrame::get(
  self : TimeseriesforecastnaiveFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveFrame::set(
  self : TimeseriesforecastnaiveFrame,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveFrame::sum(
  self : TimeseriesforecastnaiveFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveFrame::mean(
  self : TimeseriesforecastnaiveFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveFrame::scale(
  self : TimeseriesforecastnaiveFrame,
  f : Double,
) -> TimeseriesforecastnaiveFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveFrame::add(
  self : TimeseriesforecastnaiveFrame,
  other : TimeseriesforecastnaiveFrame,
) -> TimeseriesforecastnaiveFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveFrame::copy(
  self : TimeseriesforecastnaiveFrame,
) -> TimeseriesforecastnaiveFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveFrame::fill(
  self : TimeseriesforecastnaiveFrame,
  v : Double,
) -> TimeseriesforecastnaiveFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveFrame::min(
  self : TimeseriesforecastnaiveFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveFrame::max(
  self : TimeseriesforecastnaiveFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveFrame::to_string(
  self : TimeseriesforecastnaiveFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_table_make(
  size : Int32,
) -> TimeseriesforecastnaiveTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveTable::len(
  self : TimeseriesforecastnaiveTable,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveTable::get(
  self : TimeseriesforecastnaiveTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveTable::set(
  self : TimeseriesforecastnaiveTable,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveTable::sum(
  self : TimeseriesforecastnaiveTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveTable::mean(
  self : TimeseriesforecastnaiveTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveTable::scale(
  self : TimeseriesforecastnaiveTable,
  f : Double,
) -> TimeseriesforecastnaiveTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveTable::add(
  self : TimeseriesforecastnaiveTable,
  other : TimeseriesforecastnaiveTable,
) -> TimeseriesforecastnaiveTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveTable::copy(
  self : TimeseriesforecastnaiveTable,
) -> TimeseriesforecastnaiveTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveTable::fill(
  self : TimeseriesforecastnaiveTable,
  v : Double,
) -> TimeseriesforecastnaiveTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveTable::min(
  self : TimeseriesforecastnaiveTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveTable::max(
  self : TimeseriesforecastnaiveTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveTable::to_string(
  self : TimeseriesforecastnaiveTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_graphn_make(
  size : Int32,
) -> TimeseriesforecastnaiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveGraphN::len(
  self : TimeseriesforecastnaiveGraphN,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveGraphN::get(
  self : TimeseriesforecastnaiveGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveGraphN::set(
  self : TimeseriesforecastnaiveGraphN,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveGraphN::sum(
  self : TimeseriesforecastnaiveGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveGraphN::mean(
  self : TimeseriesforecastnaiveGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveGraphN::scale(
  self : TimeseriesforecastnaiveGraphN,
  f : Double,
) -> TimeseriesforecastnaiveGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveGraphN::add(
  self : TimeseriesforecastnaiveGraphN,
  other : TimeseriesforecastnaiveGraphN,
) -> TimeseriesforecastnaiveGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveGraphN::copy(
  self : TimeseriesforecastnaiveGraphN,
) -> TimeseriesforecastnaiveGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveGraphN::fill(
  self : TimeseriesforecastnaiveGraphN,
  v : Double,
) -> TimeseriesforecastnaiveGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveGraphN::min(
  self : TimeseriesforecastnaiveGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveGraphN::max(
  self : TimeseriesforecastnaiveGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveGraphN::to_string(
  self : TimeseriesforecastnaiveGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_node_make(
  size : Int32,
) -> TimeseriesforecastnaiveNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveNode::len(
  self : TimeseriesforecastnaiveNode,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveNode::get(
  self : TimeseriesforecastnaiveNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveNode::set(
  self : TimeseriesforecastnaiveNode,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveNode::sum(
  self : TimeseriesforecastnaiveNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveNode::mean(
  self : TimeseriesforecastnaiveNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveNode::scale(
  self : TimeseriesforecastnaiveNode,
  f : Double,
) -> TimeseriesforecastnaiveNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveNode::add(
  self : TimeseriesforecastnaiveNode,
  other : TimeseriesforecastnaiveNode,
) -> TimeseriesforecastnaiveNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveNode::copy(
  self : TimeseriesforecastnaiveNode,
) -> TimeseriesforecastnaiveNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveNode::fill(
  self : TimeseriesforecastnaiveNode,
  v : Double,
) -> TimeseriesforecastnaiveNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveNode::min(
  self : TimeseriesforecastnaiveNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveNode::max(
  self : TimeseriesforecastnaiveNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveNode::to_string(
  self : TimeseriesforecastnaiveNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_edge_make(
  size : Int32,
) -> TimeseriesforecastnaiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveEdge::len(
  self : TimeseriesforecastnaiveEdge,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveEdge::get(
  self : TimeseriesforecastnaiveEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveEdge::set(
  self : TimeseriesforecastnaiveEdge,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveEdge::sum(
  self : TimeseriesforecastnaiveEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveEdge::mean(
  self : TimeseriesforecastnaiveEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveEdge::scale(
  self : TimeseriesforecastnaiveEdge,
  f : Double,
) -> TimeseriesforecastnaiveEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveEdge::add(
  self : TimeseriesforecastnaiveEdge,
  other : TimeseriesforecastnaiveEdge,
) -> TimeseriesforecastnaiveEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveEdge::copy(
  self : TimeseriesforecastnaiveEdge,
) -> TimeseriesforecastnaiveEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveEdge::fill(
  self : TimeseriesforecastnaiveEdge,
  v : Double,
) -> TimeseriesforecastnaiveEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveEdge::min(
  self : TimeseriesforecastnaiveEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveEdge::max(
  self : TimeseriesforecastnaiveEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveEdge::to_string(
  self : TimeseriesforecastnaiveEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaivePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_path_make(
  size : Int32,
) -> TimeseriesforecastnaivePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaivePath::len(
  self : TimeseriesforecastnaivePath,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaivePath::get(
  self : TimeseriesforecastnaivePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaivePath::set(
  self : TimeseriesforecastnaivePath,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaivePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaivePath::sum(
  self : TimeseriesforecastnaivePath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaivePath::mean(
  self : TimeseriesforecastnaivePath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaivePath::scale(
  self : TimeseriesforecastnaivePath,
  f : Double,
) -> TimeseriesforecastnaivePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaivePath::add(
  self : TimeseriesforecastnaivePath,
  other : TimeseriesforecastnaivePath,
) -> TimeseriesforecastnaivePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaivePath::copy(
  self : TimeseriesforecastnaivePath,
) -> TimeseriesforecastnaivePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaivePath::fill(
  self : TimeseriesforecastnaivePath,
  v : Double,
) -> TimeseriesforecastnaivePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaivePath::min(
  self : TimeseriesforecastnaivePath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaivePath::max(
  self : TimeseriesforecastnaivePath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaivePath::to_string(
  self : TimeseriesforecastnaivePath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_cluster_make(
  size : Int32,
) -> TimeseriesforecastnaiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveCluster::len(
  self : TimeseriesforecastnaiveCluster,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveCluster::get(
  self : TimeseriesforecastnaiveCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveCluster::set(
  self : TimeseriesforecastnaiveCluster,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveCluster::sum(
  self : TimeseriesforecastnaiveCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveCluster::mean(
  self : TimeseriesforecastnaiveCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveCluster::scale(
  self : TimeseriesforecastnaiveCluster,
  f : Double,
) -> TimeseriesforecastnaiveCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveCluster::add(
  self : TimeseriesforecastnaiveCluster,
  other : TimeseriesforecastnaiveCluster,
) -> TimeseriesforecastnaiveCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveCluster::copy(
  self : TimeseriesforecastnaiveCluster,
) -> TimeseriesforecastnaiveCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveCluster::fill(
  self : TimeseriesforecastnaiveCluster,
  v : Double,
) -> TimeseriesforecastnaiveCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveCluster::min(
  self : TimeseriesforecastnaiveCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveCluster::max(
  self : TimeseriesforecastnaiveCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveCluster::to_string(
  self : TimeseriesforecastnaiveCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_model_make(
  size : Int32,
) -> TimeseriesforecastnaiveModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveModel::len(
  self : TimeseriesforecastnaiveModel,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveModel::get(
  self : TimeseriesforecastnaiveModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveModel::set(
  self : TimeseriesforecastnaiveModel,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveModel::sum(
  self : TimeseriesforecastnaiveModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveModel::mean(
  self : TimeseriesforecastnaiveModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveModel::scale(
  self : TimeseriesforecastnaiveModel,
  f : Double,
) -> TimeseriesforecastnaiveModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveModel::add(
  self : TimeseriesforecastnaiveModel,
  other : TimeseriesforecastnaiveModel,
) -> TimeseriesforecastnaiveModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveModel::copy(
  self : TimeseriesforecastnaiveModel,
) -> TimeseriesforecastnaiveModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveModel::fill(
  self : TimeseriesforecastnaiveModel,
  v : Double,
) -> TimeseriesforecastnaiveModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveModel::min(
  self : TimeseriesforecastnaiveModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveModel::max(
  self : TimeseriesforecastnaiveModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveModel::to_string(
  self : TimeseriesforecastnaiveModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_layer_make(
  size : Int32,
) -> TimeseriesforecastnaiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveLayer::len(
  self : TimeseriesforecastnaiveLayer,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveLayer::get(
  self : TimeseriesforecastnaiveLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveLayer::set(
  self : TimeseriesforecastnaiveLayer,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveLayer::sum(
  self : TimeseriesforecastnaiveLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveLayer::mean(
  self : TimeseriesforecastnaiveLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveLayer::scale(
  self : TimeseriesforecastnaiveLayer,
  f : Double,
) -> TimeseriesforecastnaiveLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveLayer::add(
  self : TimeseriesforecastnaiveLayer,
  other : TimeseriesforecastnaiveLayer,
) -> TimeseriesforecastnaiveLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveLayer::copy(
  self : TimeseriesforecastnaiveLayer,
) -> TimeseriesforecastnaiveLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveLayer::fill(
  self : TimeseriesforecastnaiveLayer,
  v : Double,
) -> TimeseriesforecastnaiveLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveLayer::min(
  self : TimeseriesforecastnaiveLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveLayer::max(
  self : TimeseriesforecastnaiveLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveLayer::to_string(
  self : TimeseriesforecastnaiveLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_buffer_make(
  size : Int32,
) -> TimeseriesforecastnaiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveBuffer::len(
  self : TimeseriesforecastnaiveBuffer,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveBuffer::get(
  self : TimeseriesforecastnaiveBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveBuffer::set(
  self : TimeseriesforecastnaiveBuffer,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveBuffer::sum(
  self : TimeseriesforecastnaiveBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveBuffer::mean(
  self : TimeseriesforecastnaiveBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveBuffer::scale(
  self : TimeseriesforecastnaiveBuffer,
  f : Double,
) -> TimeseriesforecastnaiveBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveBuffer::add(
  self : TimeseriesforecastnaiveBuffer,
  other : TimeseriesforecastnaiveBuffer,
) -> TimeseriesforecastnaiveBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveBuffer::copy(
  self : TimeseriesforecastnaiveBuffer,
) -> TimeseriesforecastnaiveBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveBuffer::fill(
  self : TimeseriesforecastnaiveBuffer,
  v : Double,
) -> TimeseriesforecastnaiveBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveBuffer::min(
  self : TimeseriesforecastnaiveBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveBuffer::max(
  self : TimeseriesforecastnaiveBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveBuffer::to_string(
  self : TimeseriesforecastnaiveBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_cursor_make(
  size : Int32,
) -> TimeseriesforecastnaiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveCursor::len(
  self : TimeseriesforecastnaiveCursor,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveCursor::get(
  self : TimeseriesforecastnaiveCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveCursor::set(
  self : TimeseriesforecastnaiveCursor,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveCursor::sum(
  self : TimeseriesforecastnaiveCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveCursor::mean(
  self : TimeseriesforecastnaiveCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveCursor::scale(
  self : TimeseriesforecastnaiveCursor,
  f : Double,
) -> TimeseriesforecastnaiveCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveCursor::add(
  self : TimeseriesforecastnaiveCursor,
  other : TimeseriesforecastnaiveCursor,
) -> TimeseriesforecastnaiveCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveCursor::copy(
  self : TimeseriesforecastnaiveCursor,
) -> TimeseriesforecastnaiveCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveCursor::fill(
  self : TimeseriesforecastnaiveCursor,
  v : Double,
) -> TimeseriesforecastnaiveCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveCursor::min(
  self : TimeseriesforecastnaiveCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveCursor::max(
  self : TimeseriesforecastnaiveCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveCursor::to_string(
  self : TimeseriesforecastnaiveCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_view_make(
  size : Int32,
) -> TimeseriesforecastnaiveView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveView::len(
  self : TimeseriesforecastnaiveView,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveView::get(
  self : TimeseriesforecastnaiveView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveView::set(
  self : TimeseriesforecastnaiveView,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveView::sum(
  self : TimeseriesforecastnaiveView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveView::mean(
  self : TimeseriesforecastnaiveView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveView::scale(
  self : TimeseriesforecastnaiveView,
  f : Double,
) -> TimeseriesforecastnaiveView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveView::add(
  self : TimeseriesforecastnaiveView,
  other : TimeseriesforecastnaiveView,
) -> TimeseriesforecastnaiveView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveView::copy(
  self : TimeseriesforecastnaiveView,
) -> TimeseriesforecastnaiveView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveView::fill(
  self : TimeseriesforecastnaiveView,
  v : Double,
) -> TimeseriesforecastnaiveView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveView::min(
  self : TimeseriesforecastnaiveView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveView::max(
  self : TimeseriesforecastnaiveView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveView::to_string(
  self : TimeseriesforecastnaiveView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_range_make(
  size : Int32,
) -> TimeseriesforecastnaiveRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveRange::len(
  self : TimeseriesforecastnaiveRange,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveRange::get(
  self : TimeseriesforecastnaiveRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveRange::set(
  self : TimeseriesforecastnaiveRange,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveRange::sum(
  self : TimeseriesforecastnaiveRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveRange::mean(
  self : TimeseriesforecastnaiveRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveRange::scale(
  self : TimeseriesforecastnaiveRange,
  f : Double,
) -> TimeseriesforecastnaiveRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveRange::add(
  self : TimeseriesforecastnaiveRange,
  other : TimeseriesforecastnaiveRange,
) -> TimeseriesforecastnaiveRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveRange::copy(
  self : TimeseriesforecastnaiveRange,
) -> TimeseriesforecastnaiveRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveRange::fill(
  self : TimeseriesforecastnaiveRange,
  v : Double,
) -> TimeseriesforecastnaiveRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveRange::min(
  self : TimeseriesforecastnaiveRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveRange::max(
  self : TimeseriesforecastnaiveRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveRange::to_string(
  self : TimeseriesforecastnaiveRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastnaiveSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_naive_slice_make(
  size : Int32,
) -> TimeseriesforecastnaiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastnaiveSlice::len(
  self : TimeseriesforecastnaiveSlice,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastnaiveSlice::get(
  self : TimeseriesforecastnaiveSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastnaiveSlice::set(
  self : TimeseriesforecastnaiveSlice,
  i : Int32,
  v : Double,
) -> TimeseriesforecastnaiveSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveSlice::sum(
  self : TimeseriesforecastnaiveSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastnaiveSlice::mean(
  self : TimeseriesforecastnaiveSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastnaiveSlice::scale(
  self : TimeseriesforecastnaiveSlice,
  f : Double,
) -> TimeseriesforecastnaiveSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveSlice::add(
  self : TimeseriesforecastnaiveSlice,
  other : TimeseriesforecastnaiveSlice,
) -> TimeseriesforecastnaiveSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveSlice::copy(
  self : TimeseriesforecastnaiveSlice,
) -> TimeseriesforecastnaiveSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveSlice::fill(
  self : TimeseriesforecastnaiveSlice,
  v : Double,
) -> TimeseriesforecastnaiveSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastnaiveSlice::min(
  self : TimeseriesforecastnaiveSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastnaiveSlice::max(
  self : TimeseriesforecastnaiveSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastnaiveSlice::to_string(
  self : TimeseriesforecastnaiveSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
