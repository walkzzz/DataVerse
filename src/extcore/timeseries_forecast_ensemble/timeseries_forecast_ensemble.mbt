///|
///===
/// extcore/timeseries_forecast_ensemble
pub(all) struct TimeseriesforecastensemblePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn timeseries_forecast_ensemble_make_point(
  x : Double,
  y : Double,
) -> TimeseriesforecastensemblePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn timeseries_forecast_ensemble_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> TimeseriesforecastensemblePoint {
  { x, y, z, label: 0, }
}

///|
pub fn TimeseriesforecastensemblePoint::x(
  self : TimeseriesforecastensemblePoint,
) -> Double {
  self.x
}

///|
pub fn TimeseriesforecastensemblePoint::y(
  self : TimeseriesforecastensemblePoint,
) -> Double {
  self.y
}

///|
pub fn TimeseriesforecastensemblePoint::z(
  self : TimeseriesforecastensemblePoint,
) -> Double {
  self.z
}

///|
pub fn TimeseriesforecastensemblePoint::label(
  self : TimeseriesforecastensemblePoint,
) -> Int32 {
  self.label
}

///|
pub fn TimeseriesforecastensemblePoint::dist(
  self : TimeseriesforecastensemblePoint,
  other : TimeseriesforecastensemblePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn TimeseriesforecastensemblePoint::add(
  self : TimeseriesforecastensemblePoint,
  other : TimeseriesforecastensemblePoint,
) -> TimeseriesforecastensemblePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn TimeseriesforecastensemblePoint::sub(
  self : TimeseriesforecastensemblePoint,
  other : TimeseriesforecastensemblePoint,
) -> TimeseriesforecastensemblePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn TimeseriesforecastensemblePoint::scale(
  self : TimeseriesforecastensemblePoint,
  s : Double,
) -> TimeseriesforecastensemblePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn TimeseriesforecastensemblePoint::dot(
  self : TimeseriesforecastensemblePoint,
  other : TimeseriesforecastensemblePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn TimeseriesforecastensemblePoint::cross(
  self : TimeseriesforecastensemblePoint,
  other : TimeseriesforecastensemblePoint,
) -> TimeseriesforecastensemblePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn TimeseriesforecastensemblePoint::norm(
  self : TimeseriesforecastensemblePoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn TimeseriesforecastensemblePoint::normalize(
  self : TimeseriesforecastensemblePoint,
) -> TimeseriesforecastensemblePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn TimeseriesforecastensemblePoint::negate(
  self : TimeseriesforecastensemblePoint,
) -> TimeseriesforecastensemblePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn TimeseriesforecastensemblePoint::mid(
  self : TimeseriesforecastensemblePoint,
  other : TimeseriesforecastensemblePoint,
) -> TimeseriesforecastensemblePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn TimeseriesforecastensemblePoint::lerp(
  self : TimeseriesforecastensemblePoint,
  other : TimeseriesforecastensemblePoint,
  t : Double,
) -> TimeseriesforecastensemblePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn TimeseriesforecastensemblePoint::to_string(
  self : TimeseriesforecastensemblePoint,
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
pub(all) struct TimeseriesforecastensembleSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn timeseries_forecast_ensemble_make_series(
  vals : Array[Double],
  name : String,
) -> TimeseriesforecastensembleSeries {
  { vals, name, meta: 0, }
}

///|
pub fn TimeseriesforecastensembleSeries::len(
  self : TimeseriesforecastensembleSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn TimeseriesforecastensembleSeries::sum(
  self : TimeseriesforecastensembleSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn TimeseriesforecastensembleSeries::mean(
  self : TimeseriesforecastensembleSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn TimeseriesforecastensembleSeries::min(
  self : TimeseriesforecastensembleSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn TimeseriesforecastensembleSeries::max(
  self : TimeseriesforecastensembleSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn TimeseriesforecastensembleSeries::range(
  self : TimeseriesforecastensembleSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn TimeseriesforecastensembleSeries::variance(
  self : TimeseriesforecastensembleSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn TimeseriesforecastensembleSeries::std(
  self : TimeseriesforecastensembleSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn TimeseriesforecastensembleSeries::median(
  self : TimeseriesforecastensembleSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn TimeseriesforecastensembleSeries::scale(
  self : TimeseriesforecastensembleSeries,
  f : Double,
) -> TimeseriesforecastensembleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn TimeseriesforecastensembleSeries::add(
  self : TimeseriesforecastensembleSeries,
  other : TimeseriesforecastensembleSeries,
) -> TimeseriesforecastensembleSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn TimeseriesforecastensembleSeries::sub(
  self : TimeseriesforecastensembleSeries,
  other : TimeseriesforecastensembleSeries,
) -> TimeseriesforecastensembleSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn TimeseriesforecastensembleSeries::normalize(
  self : TimeseriesforecastensembleSeries,
) -> TimeseriesforecastensembleSeries {
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
pub fn TimeseriesforecastensembleSeries::cumsum(
  self : TimeseriesforecastensembleSeries,
) -> TimeseriesforecastensembleSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn TimeseriesforecastensembleSeries::to_string(
  self : TimeseriesforecastensembleSeries,
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
pub(all) struct TimeseriesforecastensembleMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn timeseries_forecast_ensemble_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> TimeseriesforecastensembleMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn timeseries_forecast_ensemble_matrix_identity(
  n : Int32,
) -> TimeseriesforecastensembleMatrix {
  let m = timeseries_forecast_ensemble_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn TimeseriesforecastensembleMatrix::get(
  self : TimeseriesforecastensembleMatrix,
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
pub fn TimeseriesforecastensembleMatrix::transpose(
  self : TimeseriesforecastensembleMatrix,
) -> TimeseriesforecastensembleMatrix {
  let result = timeseries_forecast_ensemble_make_matrix(
    self.cols,
    self.rows,
    0.0,
  )
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn TimeseriesforecastensembleMatrix::add(
  self : TimeseriesforecastensembleMatrix,
  other : TimeseriesforecastensembleMatrix,
) -> TimeseriesforecastensembleMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = timeseries_forecast_ensemble_make_matrix(
    self.rows,
    self.cols,
    0.0,
  )
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn TimeseriesforecastensembleMatrix::scale(
  self : TimeseriesforecastensembleMatrix,
  s : Double,
) -> TimeseriesforecastensembleMatrix {
  let result = timeseries_forecast_ensemble_make_matrix(
    self.rows,
    self.cols,
    0.0,
  )
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn TimeseriesforecastensembleMatrix::multiply(
  self : TimeseriesforecastensembleMatrix,
  other : TimeseriesforecastensembleMatrix,
) -> TimeseriesforecastensembleMatrix {
  if self.cols != other.rows {
    return timeseries_forecast_ensemble_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = timeseries_forecast_ensemble_make_matrix(
    self.rows,
    other.cols,
    0.0,
  )
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
pub fn TimeseriesforecastensembleMatrix::trace(
  self : TimeseriesforecastensembleMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn TimeseriesforecastensembleMatrix::det(
  self : TimeseriesforecastensembleMatrix,
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
pub fn TimeseriesforecastensembleMatrix::norm(
  self : TimeseriesforecastensembleMatrix,
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
pub fn TimeseriesforecastensembleMatrix::to_string(
  self : TimeseriesforecastensembleMatrix,
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
pub(all) struct TimeseriesforecastensembleVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn timeseries_forecast_ensemble_make_vector(
  comps : Array[Double],
) -> TimeseriesforecastensembleVector {
  { comps, dim: comps.length(), }
}

///|
pub fn timeseries_forecast_ensemble_vector_zero(
  dim : Int32,
) -> TimeseriesforecastensembleVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn TimeseriesforecastensembleVector::add(
  self : TimeseriesforecastensembleVector,
  other : TimeseriesforecastensembleVector,
) -> TimeseriesforecastensembleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn TimeseriesforecastensembleVector::sub(
  self : TimeseriesforecastensembleVector,
  other : TimeseriesforecastensembleVector,
) -> TimeseriesforecastensembleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn TimeseriesforecastensembleVector::scale(
  self : TimeseriesforecastensembleVector,
  s : Double,
) -> TimeseriesforecastensembleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn TimeseriesforecastensembleVector::dot(
  self : TimeseriesforecastensembleVector,
  other : TimeseriesforecastensembleVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn TimeseriesforecastensembleVector::norm(
  self : TimeseriesforecastensembleVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn TimeseriesforecastensembleVector::normalize(
  self : TimeseriesforecastensembleVector,
) -> TimeseriesforecastensembleVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn TimeseriesforecastensembleVector::dist(
  self : TimeseriesforecastensembleVector,
  other : TimeseriesforecastensembleVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn TimeseriesforecastensembleVector::to_string(
  self : TimeseriesforecastensembleVector,
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
pub(all) struct TimeseriesforecastensembleFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_frame_make(
  size : Int32,
) -> TimeseriesforecastensembleFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleFrame::len(
  self : TimeseriesforecastensembleFrame,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleFrame::get(
  self : TimeseriesforecastensembleFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleFrame::set(
  self : TimeseriesforecastensembleFrame,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleFrame::sum(
  self : TimeseriesforecastensembleFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleFrame::mean(
  self : TimeseriesforecastensembleFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleFrame::scale(
  self : TimeseriesforecastensembleFrame,
  f : Double,
) -> TimeseriesforecastensembleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleFrame::add(
  self : TimeseriesforecastensembleFrame,
  other : TimeseriesforecastensembleFrame,
) -> TimeseriesforecastensembleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleFrame::copy(
  self : TimeseriesforecastensembleFrame,
) -> TimeseriesforecastensembleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleFrame::fill(
  self : TimeseriesforecastensembleFrame,
  v : Double,
) -> TimeseriesforecastensembleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleFrame::min(
  self : TimeseriesforecastensembleFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleFrame::max(
  self : TimeseriesforecastensembleFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleFrame::to_string(
  self : TimeseriesforecastensembleFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_table_make(
  size : Int32,
) -> TimeseriesforecastensembleTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleTable::len(
  self : TimeseriesforecastensembleTable,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleTable::get(
  self : TimeseriesforecastensembleTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleTable::set(
  self : TimeseriesforecastensembleTable,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleTable::sum(
  self : TimeseriesforecastensembleTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleTable::mean(
  self : TimeseriesforecastensembleTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleTable::scale(
  self : TimeseriesforecastensembleTable,
  f : Double,
) -> TimeseriesforecastensembleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleTable::add(
  self : TimeseriesforecastensembleTable,
  other : TimeseriesforecastensembleTable,
) -> TimeseriesforecastensembleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleTable::copy(
  self : TimeseriesforecastensembleTable,
) -> TimeseriesforecastensembleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleTable::fill(
  self : TimeseriesforecastensembleTable,
  v : Double,
) -> TimeseriesforecastensembleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleTable::min(
  self : TimeseriesforecastensembleTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleTable::max(
  self : TimeseriesforecastensembleTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleTable::to_string(
  self : TimeseriesforecastensembleTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_graphn_make(
  size : Int32,
) -> TimeseriesforecastensembleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleGraphN::len(
  self : TimeseriesforecastensembleGraphN,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleGraphN::get(
  self : TimeseriesforecastensembleGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleGraphN::set(
  self : TimeseriesforecastensembleGraphN,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleGraphN::sum(
  self : TimeseriesforecastensembleGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleGraphN::mean(
  self : TimeseriesforecastensembleGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleGraphN::scale(
  self : TimeseriesforecastensembleGraphN,
  f : Double,
) -> TimeseriesforecastensembleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleGraphN::add(
  self : TimeseriesforecastensembleGraphN,
  other : TimeseriesforecastensembleGraphN,
) -> TimeseriesforecastensembleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleGraphN::copy(
  self : TimeseriesforecastensembleGraphN,
) -> TimeseriesforecastensembleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleGraphN::fill(
  self : TimeseriesforecastensembleGraphN,
  v : Double,
) -> TimeseriesforecastensembleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleGraphN::min(
  self : TimeseriesforecastensembleGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleGraphN::max(
  self : TimeseriesforecastensembleGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleGraphN::to_string(
  self : TimeseriesforecastensembleGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_node_make(
  size : Int32,
) -> TimeseriesforecastensembleNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleNode::len(
  self : TimeseriesforecastensembleNode,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleNode::get(
  self : TimeseriesforecastensembleNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleNode::set(
  self : TimeseriesforecastensembleNode,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleNode::sum(
  self : TimeseriesforecastensembleNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleNode::mean(
  self : TimeseriesforecastensembleNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleNode::scale(
  self : TimeseriesforecastensembleNode,
  f : Double,
) -> TimeseriesforecastensembleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleNode::add(
  self : TimeseriesforecastensembleNode,
  other : TimeseriesforecastensembleNode,
) -> TimeseriesforecastensembleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleNode::copy(
  self : TimeseriesforecastensembleNode,
) -> TimeseriesforecastensembleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleNode::fill(
  self : TimeseriesforecastensembleNode,
  v : Double,
) -> TimeseriesforecastensembleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleNode::min(
  self : TimeseriesforecastensembleNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleNode::max(
  self : TimeseriesforecastensembleNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleNode::to_string(
  self : TimeseriesforecastensembleNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_edge_make(
  size : Int32,
) -> TimeseriesforecastensembleEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleEdge::len(
  self : TimeseriesforecastensembleEdge,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleEdge::get(
  self : TimeseriesforecastensembleEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleEdge::set(
  self : TimeseriesforecastensembleEdge,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleEdge::sum(
  self : TimeseriesforecastensembleEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleEdge::mean(
  self : TimeseriesforecastensembleEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleEdge::scale(
  self : TimeseriesforecastensembleEdge,
  f : Double,
) -> TimeseriesforecastensembleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleEdge::add(
  self : TimeseriesforecastensembleEdge,
  other : TimeseriesforecastensembleEdge,
) -> TimeseriesforecastensembleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleEdge::copy(
  self : TimeseriesforecastensembleEdge,
) -> TimeseriesforecastensembleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleEdge::fill(
  self : TimeseriesforecastensembleEdge,
  v : Double,
) -> TimeseriesforecastensembleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleEdge::min(
  self : TimeseriesforecastensembleEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleEdge::max(
  self : TimeseriesforecastensembleEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleEdge::to_string(
  self : TimeseriesforecastensembleEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensemblePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_path_make(
  size : Int32,
) -> TimeseriesforecastensemblePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensemblePath::len(
  self : TimeseriesforecastensemblePath,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensemblePath::get(
  self : TimeseriesforecastensemblePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensemblePath::set(
  self : TimeseriesforecastensemblePath,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensemblePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensemblePath::sum(
  self : TimeseriesforecastensemblePath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensemblePath::mean(
  self : TimeseriesforecastensemblePath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensemblePath::scale(
  self : TimeseriesforecastensemblePath,
  f : Double,
) -> TimeseriesforecastensemblePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensemblePath::add(
  self : TimeseriesforecastensemblePath,
  other : TimeseriesforecastensemblePath,
) -> TimeseriesforecastensemblePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensemblePath::copy(
  self : TimeseriesforecastensemblePath,
) -> TimeseriesforecastensemblePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensemblePath::fill(
  self : TimeseriesforecastensemblePath,
  v : Double,
) -> TimeseriesforecastensemblePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensemblePath::min(
  self : TimeseriesforecastensemblePath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensemblePath::max(
  self : TimeseriesforecastensemblePath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensemblePath::to_string(
  self : TimeseriesforecastensemblePath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_cluster_make(
  size : Int32,
) -> TimeseriesforecastensembleCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleCluster::len(
  self : TimeseriesforecastensembleCluster,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleCluster::get(
  self : TimeseriesforecastensembleCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleCluster::set(
  self : TimeseriesforecastensembleCluster,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleCluster::sum(
  self : TimeseriesforecastensembleCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleCluster::mean(
  self : TimeseriesforecastensembleCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleCluster::scale(
  self : TimeseriesforecastensembleCluster,
  f : Double,
) -> TimeseriesforecastensembleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleCluster::add(
  self : TimeseriesforecastensembleCluster,
  other : TimeseriesforecastensembleCluster,
) -> TimeseriesforecastensembleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleCluster::copy(
  self : TimeseriesforecastensembleCluster,
) -> TimeseriesforecastensembleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleCluster::fill(
  self : TimeseriesforecastensembleCluster,
  v : Double,
) -> TimeseriesforecastensembleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleCluster::min(
  self : TimeseriesforecastensembleCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleCluster::max(
  self : TimeseriesforecastensembleCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleCluster::to_string(
  self : TimeseriesforecastensembleCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_model_make(
  size : Int32,
) -> TimeseriesforecastensembleModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleModel::len(
  self : TimeseriesforecastensembleModel,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleModel::get(
  self : TimeseriesforecastensembleModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleModel::set(
  self : TimeseriesforecastensembleModel,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleModel::sum(
  self : TimeseriesforecastensembleModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleModel::mean(
  self : TimeseriesforecastensembleModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleModel::scale(
  self : TimeseriesforecastensembleModel,
  f : Double,
) -> TimeseriesforecastensembleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleModel::add(
  self : TimeseriesforecastensembleModel,
  other : TimeseriesforecastensembleModel,
) -> TimeseriesforecastensembleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleModel::copy(
  self : TimeseriesforecastensembleModel,
) -> TimeseriesforecastensembleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleModel::fill(
  self : TimeseriesforecastensembleModel,
  v : Double,
) -> TimeseriesforecastensembleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleModel::min(
  self : TimeseriesforecastensembleModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleModel::max(
  self : TimeseriesforecastensembleModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleModel::to_string(
  self : TimeseriesforecastensembleModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_layer_make(
  size : Int32,
) -> TimeseriesforecastensembleLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleLayer::len(
  self : TimeseriesforecastensembleLayer,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleLayer::get(
  self : TimeseriesforecastensembleLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleLayer::set(
  self : TimeseriesforecastensembleLayer,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleLayer::sum(
  self : TimeseriesforecastensembleLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleLayer::mean(
  self : TimeseriesforecastensembleLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleLayer::scale(
  self : TimeseriesforecastensembleLayer,
  f : Double,
) -> TimeseriesforecastensembleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleLayer::add(
  self : TimeseriesforecastensembleLayer,
  other : TimeseriesforecastensembleLayer,
) -> TimeseriesforecastensembleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleLayer::copy(
  self : TimeseriesforecastensembleLayer,
) -> TimeseriesforecastensembleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleLayer::fill(
  self : TimeseriesforecastensembleLayer,
  v : Double,
) -> TimeseriesforecastensembleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleLayer::min(
  self : TimeseriesforecastensembleLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleLayer::max(
  self : TimeseriesforecastensembleLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleLayer::to_string(
  self : TimeseriesforecastensembleLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_buffer_make(
  size : Int32,
) -> TimeseriesforecastensembleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleBuffer::len(
  self : TimeseriesforecastensembleBuffer,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleBuffer::get(
  self : TimeseriesforecastensembleBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleBuffer::set(
  self : TimeseriesforecastensembleBuffer,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleBuffer::sum(
  self : TimeseriesforecastensembleBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleBuffer::mean(
  self : TimeseriesforecastensembleBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleBuffer::scale(
  self : TimeseriesforecastensembleBuffer,
  f : Double,
) -> TimeseriesforecastensembleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleBuffer::add(
  self : TimeseriesforecastensembleBuffer,
  other : TimeseriesforecastensembleBuffer,
) -> TimeseriesforecastensembleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleBuffer::copy(
  self : TimeseriesforecastensembleBuffer,
) -> TimeseriesforecastensembleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleBuffer::fill(
  self : TimeseriesforecastensembleBuffer,
  v : Double,
) -> TimeseriesforecastensembleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleBuffer::min(
  self : TimeseriesforecastensembleBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleBuffer::max(
  self : TimeseriesforecastensembleBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleBuffer::to_string(
  self : TimeseriesforecastensembleBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_cursor_make(
  size : Int32,
) -> TimeseriesforecastensembleCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleCursor::len(
  self : TimeseriesforecastensembleCursor,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleCursor::get(
  self : TimeseriesforecastensembleCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleCursor::set(
  self : TimeseriesforecastensembleCursor,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleCursor::sum(
  self : TimeseriesforecastensembleCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleCursor::mean(
  self : TimeseriesforecastensembleCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleCursor::scale(
  self : TimeseriesforecastensembleCursor,
  f : Double,
) -> TimeseriesforecastensembleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleCursor::add(
  self : TimeseriesforecastensembleCursor,
  other : TimeseriesforecastensembleCursor,
) -> TimeseriesforecastensembleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleCursor::copy(
  self : TimeseriesforecastensembleCursor,
) -> TimeseriesforecastensembleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleCursor::fill(
  self : TimeseriesforecastensembleCursor,
  v : Double,
) -> TimeseriesforecastensembleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleCursor::min(
  self : TimeseriesforecastensembleCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleCursor::max(
  self : TimeseriesforecastensembleCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleCursor::to_string(
  self : TimeseriesforecastensembleCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_view_make(
  size : Int32,
) -> TimeseriesforecastensembleView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleView::len(
  self : TimeseriesforecastensembleView,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleView::get(
  self : TimeseriesforecastensembleView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleView::set(
  self : TimeseriesforecastensembleView,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleView::sum(
  self : TimeseriesforecastensembleView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleView::mean(
  self : TimeseriesforecastensembleView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleView::scale(
  self : TimeseriesforecastensembleView,
  f : Double,
) -> TimeseriesforecastensembleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleView::add(
  self : TimeseriesforecastensembleView,
  other : TimeseriesforecastensembleView,
) -> TimeseriesforecastensembleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleView::copy(
  self : TimeseriesforecastensembleView,
) -> TimeseriesforecastensembleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleView::fill(
  self : TimeseriesforecastensembleView,
  v : Double,
) -> TimeseriesforecastensembleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleView::min(
  self : TimeseriesforecastensembleView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleView::max(
  self : TimeseriesforecastensembleView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleView::to_string(
  self : TimeseriesforecastensembleView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_range_make(
  size : Int32,
) -> TimeseriesforecastensembleRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleRange::len(
  self : TimeseriesforecastensembleRange,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleRange::get(
  self : TimeseriesforecastensembleRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleRange::set(
  self : TimeseriesforecastensembleRange,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleRange::sum(
  self : TimeseriesforecastensembleRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleRange::mean(
  self : TimeseriesforecastensembleRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleRange::scale(
  self : TimeseriesforecastensembleRange,
  f : Double,
) -> TimeseriesforecastensembleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleRange::add(
  self : TimeseriesforecastensembleRange,
  other : TimeseriesforecastensembleRange,
) -> TimeseriesforecastensembleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleRange::copy(
  self : TimeseriesforecastensembleRange,
) -> TimeseriesforecastensembleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleRange::fill(
  self : TimeseriesforecastensembleRange,
  v : Double,
) -> TimeseriesforecastensembleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleRange::min(
  self : TimeseriesforecastensembleRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleRange::max(
  self : TimeseriesforecastensembleRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleRange::to_string(
  self : TimeseriesforecastensembleRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesforecastensembleSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_forecast_ensemble_slice_make(
  size : Int32,
) -> TimeseriesforecastensembleSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesforecastensembleSlice::len(
  self : TimeseriesforecastensembleSlice,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesforecastensembleSlice::get(
  self : TimeseriesforecastensembleSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesforecastensembleSlice::set(
  self : TimeseriesforecastensembleSlice,
  i : Int32,
  v : Double,
) -> TimeseriesforecastensembleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleSlice::sum(
  self : TimeseriesforecastensembleSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesforecastensembleSlice::mean(
  self : TimeseriesforecastensembleSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesforecastensembleSlice::scale(
  self : TimeseriesforecastensembleSlice,
  f : Double,
) -> TimeseriesforecastensembleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleSlice::add(
  self : TimeseriesforecastensembleSlice,
  other : TimeseriesforecastensembleSlice,
) -> TimeseriesforecastensembleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleSlice::copy(
  self : TimeseriesforecastensembleSlice,
) -> TimeseriesforecastensembleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleSlice::fill(
  self : TimeseriesforecastensembleSlice,
  v : Double,
) -> TimeseriesforecastensembleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesforecastensembleSlice::min(
  self : TimeseriesforecastensembleSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesforecastensembleSlice::max(
  self : TimeseriesforecastensembleSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesforecastensembleSlice::to_string(
  self : TimeseriesforecastensembleSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
