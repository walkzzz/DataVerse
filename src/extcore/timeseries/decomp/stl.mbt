///|
///===
/// extcore/timeseries_decomp_stl
pub(all) struct TimeseriesdecompstlPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn timeseries_decomp_stl_make_point(
  x : Double,
  y : Double,
) -> TimeseriesdecompstlPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn timeseries_decomp_stl_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> TimeseriesdecompstlPoint {
  { x, y, z, label: 0, }
}

///|
pub fn TimeseriesdecompstlPoint::x(self : TimeseriesdecompstlPoint) -> Double {
  self.x
}

///|
pub fn TimeseriesdecompstlPoint::y(self : TimeseriesdecompstlPoint) -> Double {
  self.y
}

///|
pub fn TimeseriesdecompstlPoint::z(self : TimeseriesdecompstlPoint) -> Double {
  self.z
}

///|
pub fn TimeseriesdecompstlPoint::label(
  self : TimeseriesdecompstlPoint,
) -> Int32 {
  self.label
}

///|
pub fn TimeseriesdecompstlPoint::dist(
  self : TimeseriesdecompstlPoint,
  other : TimeseriesdecompstlPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn TimeseriesdecompstlPoint::add(
  self : TimeseriesdecompstlPoint,
  other : TimeseriesdecompstlPoint,
) -> TimeseriesdecompstlPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn TimeseriesdecompstlPoint::sub(
  self : TimeseriesdecompstlPoint,
  other : TimeseriesdecompstlPoint,
) -> TimeseriesdecompstlPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn TimeseriesdecompstlPoint::scale(
  self : TimeseriesdecompstlPoint,
  s : Double,
) -> TimeseriesdecompstlPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn TimeseriesdecompstlPoint::dot(
  self : TimeseriesdecompstlPoint,
  other : TimeseriesdecompstlPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn TimeseriesdecompstlPoint::cross(
  self : TimeseriesdecompstlPoint,
  other : TimeseriesdecompstlPoint,
) -> TimeseriesdecompstlPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn TimeseriesdecompstlPoint::norm(
  self : TimeseriesdecompstlPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn TimeseriesdecompstlPoint::normalize(
  self : TimeseriesdecompstlPoint,
) -> TimeseriesdecompstlPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn TimeseriesdecompstlPoint::negate(
  self : TimeseriesdecompstlPoint,
) -> TimeseriesdecompstlPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn TimeseriesdecompstlPoint::mid(
  self : TimeseriesdecompstlPoint,
  other : TimeseriesdecompstlPoint,
) -> TimeseriesdecompstlPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn TimeseriesdecompstlPoint::lerp(
  self : TimeseriesdecompstlPoint,
  other : TimeseriesdecompstlPoint,
  t : Double,
) -> TimeseriesdecompstlPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn TimeseriesdecompstlPoint::to_string(
  self : TimeseriesdecompstlPoint,
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
pub(all) struct TimeseriesdecompstlSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn timeseries_decomp_stl_make_series(
  vals : Array[Double],
  name : String,
) -> TimeseriesdecompstlSeries {
  { vals, name, meta: 0, }
}

///|
pub fn TimeseriesdecompstlSeries::len(
  self : TimeseriesdecompstlSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn TimeseriesdecompstlSeries::sum(
  self : TimeseriesdecompstlSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn TimeseriesdecompstlSeries::mean(
  self : TimeseriesdecompstlSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn TimeseriesdecompstlSeries::min(
  self : TimeseriesdecompstlSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn TimeseriesdecompstlSeries::max(
  self : TimeseriesdecompstlSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn TimeseriesdecompstlSeries::range(
  self : TimeseriesdecompstlSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn TimeseriesdecompstlSeries::variance(
  self : TimeseriesdecompstlSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn TimeseriesdecompstlSeries::std(
  self : TimeseriesdecompstlSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn TimeseriesdecompstlSeries::median(
  self : TimeseriesdecompstlSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn TimeseriesdecompstlSeries::scale(
  self : TimeseriesdecompstlSeries,
  f : Double,
) -> TimeseriesdecompstlSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn TimeseriesdecompstlSeries::add(
  self : TimeseriesdecompstlSeries,
  other : TimeseriesdecompstlSeries,
) -> TimeseriesdecompstlSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn TimeseriesdecompstlSeries::sub(
  self : TimeseriesdecompstlSeries,
  other : TimeseriesdecompstlSeries,
) -> TimeseriesdecompstlSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn TimeseriesdecompstlSeries::normalize(
  self : TimeseriesdecompstlSeries,
) -> TimeseriesdecompstlSeries {
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
pub fn TimeseriesdecompstlSeries::cumsum(
  self : TimeseriesdecompstlSeries,
) -> TimeseriesdecompstlSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn TimeseriesdecompstlSeries::to_string(
  self : TimeseriesdecompstlSeries,
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
pub(all) struct TimeseriesdecompstlMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn timeseries_decomp_stl_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> TimeseriesdecompstlMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn timeseries_decomp_stl_matrix_identity(
  n : Int32,
) -> TimeseriesdecompstlMatrix {
  let m = timeseries_decomp_stl_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn TimeseriesdecompstlMatrix::get(
  self : TimeseriesdecompstlMatrix,
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
pub fn TimeseriesdecompstlMatrix::transpose(
  self : TimeseriesdecompstlMatrix,
) -> TimeseriesdecompstlMatrix {
  let result = timeseries_decomp_stl_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn TimeseriesdecompstlMatrix::add(
  self : TimeseriesdecompstlMatrix,
  other : TimeseriesdecompstlMatrix,
) -> TimeseriesdecompstlMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = timeseries_decomp_stl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn TimeseriesdecompstlMatrix::scale(
  self : TimeseriesdecompstlMatrix,
  s : Double,
) -> TimeseriesdecompstlMatrix {
  let result = timeseries_decomp_stl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn TimeseriesdecompstlMatrix::multiply(
  self : TimeseriesdecompstlMatrix,
  other : TimeseriesdecompstlMatrix,
) -> TimeseriesdecompstlMatrix {
  if self.cols != other.rows {
    return timeseries_decomp_stl_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = timeseries_decomp_stl_make_matrix(self.rows, other.cols, 0.0)
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
pub fn TimeseriesdecompstlMatrix::trace(
  self : TimeseriesdecompstlMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn TimeseriesdecompstlMatrix::det(
  self : TimeseriesdecompstlMatrix,
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
pub fn TimeseriesdecompstlMatrix::norm(
  self : TimeseriesdecompstlMatrix,
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
pub fn TimeseriesdecompstlMatrix::to_string(
  self : TimeseriesdecompstlMatrix,
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
pub(all) struct TimeseriesdecompstlVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn timeseries_decomp_stl_make_vector(
  comps : Array[Double],
) -> TimeseriesdecompstlVector {
  { comps, dim: comps.length(), }
}

///|
pub fn timeseries_decomp_stl_vector_zero(
  dim : Int32,
) -> TimeseriesdecompstlVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn TimeseriesdecompstlVector::add(
  self : TimeseriesdecompstlVector,
  other : TimeseriesdecompstlVector,
) -> TimeseriesdecompstlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn TimeseriesdecompstlVector::sub(
  self : TimeseriesdecompstlVector,
  other : TimeseriesdecompstlVector,
) -> TimeseriesdecompstlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn TimeseriesdecompstlVector::scale(
  self : TimeseriesdecompstlVector,
  s : Double,
) -> TimeseriesdecompstlVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn TimeseriesdecompstlVector::dot(
  self : TimeseriesdecompstlVector,
  other : TimeseriesdecompstlVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn TimeseriesdecompstlVector::norm(
  self : TimeseriesdecompstlVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn TimeseriesdecompstlVector::normalize(
  self : TimeseriesdecompstlVector,
) -> TimeseriesdecompstlVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn TimeseriesdecompstlVector::dist(
  self : TimeseriesdecompstlVector,
  other : TimeseriesdecompstlVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn TimeseriesdecompstlVector::to_string(
  self : TimeseriesdecompstlVector,
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
pub(all) struct TimeseriesdecompstlFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_frame_make(
  size : Int32,
) -> TimeseriesdecompstlFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlFrame::len(self : TimeseriesdecompstlFrame) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlFrame::get(
  self : TimeseriesdecompstlFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlFrame::set(
  self : TimeseriesdecompstlFrame,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlFrame::sum(self : TimeseriesdecompstlFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlFrame::mean(
  self : TimeseriesdecompstlFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlFrame::scale(
  self : TimeseriesdecompstlFrame,
  f : Double,
) -> TimeseriesdecompstlFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlFrame::add(
  self : TimeseriesdecompstlFrame,
  other : TimeseriesdecompstlFrame,
) -> TimeseriesdecompstlFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlFrame::copy(
  self : TimeseriesdecompstlFrame,
) -> TimeseriesdecompstlFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlFrame::fill(
  self : TimeseriesdecompstlFrame,
  v : Double,
) -> TimeseriesdecompstlFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlFrame::min(self : TimeseriesdecompstlFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlFrame::max(self : TimeseriesdecompstlFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlFrame::to_string(
  self : TimeseriesdecompstlFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_table_make(
  size : Int32,
) -> TimeseriesdecompstlTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlTable::len(self : TimeseriesdecompstlTable) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlTable::get(
  self : TimeseriesdecompstlTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlTable::set(
  self : TimeseriesdecompstlTable,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlTable::sum(self : TimeseriesdecompstlTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlTable::mean(
  self : TimeseriesdecompstlTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlTable::scale(
  self : TimeseriesdecompstlTable,
  f : Double,
) -> TimeseriesdecompstlTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlTable::add(
  self : TimeseriesdecompstlTable,
  other : TimeseriesdecompstlTable,
) -> TimeseriesdecompstlTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlTable::copy(
  self : TimeseriesdecompstlTable,
) -> TimeseriesdecompstlTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlTable::fill(
  self : TimeseriesdecompstlTable,
  v : Double,
) -> TimeseriesdecompstlTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlTable::min(self : TimeseriesdecompstlTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlTable::max(self : TimeseriesdecompstlTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlTable::to_string(
  self : TimeseriesdecompstlTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_graphn_make(
  size : Int32,
) -> TimeseriesdecompstlGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlGraphN::len(
  self : TimeseriesdecompstlGraphN,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlGraphN::get(
  self : TimeseriesdecompstlGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlGraphN::set(
  self : TimeseriesdecompstlGraphN,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlGraphN::sum(
  self : TimeseriesdecompstlGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlGraphN::mean(
  self : TimeseriesdecompstlGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlGraphN::scale(
  self : TimeseriesdecompstlGraphN,
  f : Double,
) -> TimeseriesdecompstlGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlGraphN::add(
  self : TimeseriesdecompstlGraphN,
  other : TimeseriesdecompstlGraphN,
) -> TimeseriesdecompstlGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlGraphN::copy(
  self : TimeseriesdecompstlGraphN,
) -> TimeseriesdecompstlGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlGraphN::fill(
  self : TimeseriesdecompstlGraphN,
  v : Double,
) -> TimeseriesdecompstlGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlGraphN::min(
  self : TimeseriesdecompstlGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlGraphN::max(
  self : TimeseriesdecompstlGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlGraphN::to_string(
  self : TimeseriesdecompstlGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_node_make(size : Int32) -> TimeseriesdecompstlNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlNode::len(self : TimeseriesdecompstlNode) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlNode::get(
  self : TimeseriesdecompstlNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlNode::set(
  self : TimeseriesdecompstlNode,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlNode::sum(self : TimeseriesdecompstlNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlNode::mean(self : TimeseriesdecompstlNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlNode::scale(
  self : TimeseriesdecompstlNode,
  f : Double,
) -> TimeseriesdecompstlNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlNode::add(
  self : TimeseriesdecompstlNode,
  other : TimeseriesdecompstlNode,
) -> TimeseriesdecompstlNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlNode::copy(
  self : TimeseriesdecompstlNode,
) -> TimeseriesdecompstlNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlNode::fill(
  self : TimeseriesdecompstlNode,
  v : Double,
) -> TimeseriesdecompstlNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlNode::min(self : TimeseriesdecompstlNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlNode::max(self : TimeseriesdecompstlNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlNode::to_string(
  self : TimeseriesdecompstlNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_edge_make(size : Int32) -> TimeseriesdecompstlEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlEdge::len(self : TimeseriesdecompstlEdge) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlEdge::get(
  self : TimeseriesdecompstlEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlEdge::set(
  self : TimeseriesdecompstlEdge,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlEdge::sum(self : TimeseriesdecompstlEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlEdge::mean(self : TimeseriesdecompstlEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlEdge::scale(
  self : TimeseriesdecompstlEdge,
  f : Double,
) -> TimeseriesdecompstlEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlEdge::add(
  self : TimeseriesdecompstlEdge,
  other : TimeseriesdecompstlEdge,
) -> TimeseriesdecompstlEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlEdge::copy(
  self : TimeseriesdecompstlEdge,
) -> TimeseriesdecompstlEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlEdge::fill(
  self : TimeseriesdecompstlEdge,
  v : Double,
) -> TimeseriesdecompstlEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlEdge::min(self : TimeseriesdecompstlEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlEdge::max(self : TimeseriesdecompstlEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlEdge::to_string(
  self : TimeseriesdecompstlEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_path_make(size : Int32) -> TimeseriesdecompstlPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlPath::len(self : TimeseriesdecompstlPath) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlPath::get(
  self : TimeseriesdecompstlPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlPath::set(
  self : TimeseriesdecompstlPath,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlPath::sum(self : TimeseriesdecompstlPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlPath::mean(self : TimeseriesdecompstlPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlPath::scale(
  self : TimeseriesdecompstlPath,
  f : Double,
) -> TimeseriesdecompstlPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlPath::add(
  self : TimeseriesdecompstlPath,
  other : TimeseriesdecompstlPath,
) -> TimeseriesdecompstlPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlPath::copy(
  self : TimeseriesdecompstlPath,
) -> TimeseriesdecompstlPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlPath::fill(
  self : TimeseriesdecompstlPath,
  v : Double,
) -> TimeseriesdecompstlPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlPath::min(self : TimeseriesdecompstlPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlPath::max(self : TimeseriesdecompstlPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlPath::to_string(
  self : TimeseriesdecompstlPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_cluster_make(
  size : Int32,
) -> TimeseriesdecompstlCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlCluster::len(
  self : TimeseriesdecompstlCluster,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlCluster::get(
  self : TimeseriesdecompstlCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlCluster::set(
  self : TimeseriesdecompstlCluster,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlCluster::sum(
  self : TimeseriesdecompstlCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlCluster::mean(
  self : TimeseriesdecompstlCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlCluster::scale(
  self : TimeseriesdecompstlCluster,
  f : Double,
) -> TimeseriesdecompstlCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlCluster::add(
  self : TimeseriesdecompstlCluster,
  other : TimeseriesdecompstlCluster,
) -> TimeseriesdecompstlCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlCluster::copy(
  self : TimeseriesdecompstlCluster,
) -> TimeseriesdecompstlCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlCluster::fill(
  self : TimeseriesdecompstlCluster,
  v : Double,
) -> TimeseriesdecompstlCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlCluster::min(
  self : TimeseriesdecompstlCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlCluster::max(
  self : TimeseriesdecompstlCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlCluster::to_string(
  self : TimeseriesdecompstlCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_model_make(
  size : Int32,
) -> TimeseriesdecompstlModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlModel::len(self : TimeseriesdecompstlModel) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlModel::get(
  self : TimeseriesdecompstlModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlModel::set(
  self : TimeseriesdecompstlModel,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlModel::sum(self : TimeseriesdecompstlModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlModel::mean(
  self : TimeseriesdecompstlModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlModel::scale(
  self : TimeseriesdecompstlModel,
  f : Double,
) -> TimeseriesdecompstlModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlModel::add(
  self : TimeseriesdecompstlModel,
  other : TimeseriesdecompstlModel,
) -> TimeseriesdecompstlModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlModel::copy(
  self : TimeseriesdecompstlModel,
) -> TimeseriesdecompstlModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlModel::fill(
  self : TimeseriesdecompstlModel,
  v : Double,
) -> TimeseriesdecompstlModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlModel::min(self : TimeseriesdecompstlModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlModel::max(self : TimeseriesdecompstlModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlModel::to_string(
  self : TimeseriesdecompstlModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_layer_make(
  size : Int32,
) -> TimeseriesdecompstlLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlLayer::len(self : TimeseriesdecompstlLayer) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlLayer::get(
  self : TimeseriesdecompstlLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlLayer::set(
  self : TimeseriesdecompstlLayer,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlLayer::sum(self : TimeseriesdecompstlLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlLayer::mean(
  self : TimeseriesdecompstlLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlLayer::scale(
  self : TimeseriesdecompstlLayer,
  f : Double,
) -> TimeseriesdecompstlLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlLayer::add(
  self : TimeseriesdecompstlLayer,
  other : TimeseriesdecompstlLayer,
) -> TimeseriesdecompstlLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlLayer::copy(
  self : TimeseriesdecompstlLayer,
) -> TimeseriesdecompstlLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlLayer::fill(
  self : TimeseriesdecompstlLayer,
  v : Double,
) -> TimeseriesdecompstlLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlLayer::min(self : TimeseriesdecompstlLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlLayer::max(self : TimeseriesdecompstlLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlLayer::to_string(
  self : TimeseriesdecompstlLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_buffer_make(
  size : Int32,
) -> TimeseriesdecompstlBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlBuffer::len(
  self : TimeseriesdecompstlBuffer,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlBuffer::get(
  self : TimeseriesdecompstlBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlBuffer::set(
  self : TimeseriesdecompstlBuffer,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlBuffer::sum(
  self : TimeseriesdecompstlBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlBuffer::mean(
  self : TimeseriesdecompstlBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlBuffer::scale(
  self : TimeseriesdecompstlBuffer,
  f : Double,
) -> TimeseriesdecompstlBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlBuffer::add(
  self : TimeseriesdecompstlBuffer,
  other : TimeseriesdecompstlBuffer,
) -> TimeseriesdecompstlBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlBuffer::copy(
  self : TimeseriesdecompstlBuffer,
) -> TimeseriesdecompstlBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlBuffer::fill(
  self : TimeseriesdecompstlBuffer,
  v : Double,
) -> TimeseriesdecompstlBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlBuffer::min(
  self : TimeseriesdecompstlBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlBuffer::max(
  self : TimeseriesdecompstlBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlBuffer::to_string(
  self : TimeseriesdecompstlBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_cursor_make(
  size : Int32,
) -> TimeseriesdecompstlCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlCursor::len(
  self : TimeseriesdecompstlCursor,
) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlCursor::get(
  self : TimeseriesdecompstlCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlCursor::set(
  self : TimeseriesdecompstlCursor,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlCursor::sum(
  self : TimeseriesdecompstlCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlCursor::mean(
  self : TimeseriesdecompstlCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlCursor::scale(
  self : TimeseriesdecompstlCursor,
  f : Double,
) -> TimeseriesdecompstlCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlCursor::add(
  self : TimeseriesdecompstlCursor,
  other : TimeseriesdecompstlCursor,
) -> TimeseriesdecompstlCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlCursor::copy(
  self : TimeseriesdecompstlCursor,
) -> TimeseriesdecompstlCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlCursor::fill(
  self : TimeseriesdecompstlCursor,
  v : Double,
) -> TimeseriesdecompstlCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlCursor::min(
  self : TimeseriesdecompstlCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlCursor::max(
  self : TimeseriesdecompstlCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlCursor::to_string(
  self : TimeseriesdecompstlCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_view_make(size : Int32) -> TimeseriesdecompstlView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlView::len(self : TimeseriesdecompstlView) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlView::get(
  self : TimeseriesdecompstlView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlView::set(
  self : TimeseriesdecompstlView,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlView::sum(self : TimeseriesdecompstlView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlView::mean(self : TimeseriesdecompstlView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlView::scale(
  self : TimeseriesdecompstlView,
  f : Double,
) -> TimeseriesdecompstlView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlView::add(
  self : TimeseriesdecompstlView,
  other : TimeseriesdecompstlView,
) -> TimeseriesdecompstlView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlView::copy(
  self : TimeseriesdecompstlView,
) -> TimeseriesdecompstlView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlView::fill(
  self : TimeseriesdecompstlView,
  v : Double,
) -> TimeseriesdecompstlView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlView::min(self : TimeseriesdecompstlView) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlView::max(self : TimeseriesdecompstlView) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlView::to_string(
  self : TimeseriesdecompstlView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_range_make(
  size : Int32,
) -> TimeseriesdecompstlRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlRange::len(self : TimeseriesdecompstlRange) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlRange::get(
  self : TimeseriesdecompstlRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlRange::set(
  self : TimeseriesdecompstlRange,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlRange::sum(self : TimeseriesdecompstlRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlRange::mean(
  self : TimeseriesdecompstlRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlRange::scale(
  self : TimeseriesdecompstlRange,
  f : Double,
) -> TimeseriesdecompstlRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlRange::add(
  self : TimeseriesdecompstlRange,
  other : TimeseriesdecompstlRange,
) -> TimeseriesdecompstlRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlRange::copy(
  self : TimeseriesdecompstlRange,
) -> TimeseriesdecompstlRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlRange::fill(
  self : TimeseriesdecompstlRange,
  v : Double,
) -> TimeseriesdecompstlRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlRange::min(self : TimeseriesdecompstlRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlRange::max(self : TimeseriesdecompstlRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlRange::to_string(
  self : TimeseriesdecompstlRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct TimeseriesdecompstlSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn timeseries_decomp_stl_slice_make(
  size : Int32,
) -> TimeseriesdecompstlSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn TimeseriesdecompstlSlice::len(self : TimeseriesdecompstlSlice) -> Int32 {
  self.size
}

///|
pub fn TimeseriesdecompstlSlice::get(
  self : TimeseriesdecompstlSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn TimeseriesdecompstlSlice::set(
  self : TimeseriesdecompstlSlice,
  i : Int32,
  v : Double,
) -> TimeseriesdecompstlSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlSlice::sum(self : TimeseriesdecompstlSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn TimeseriesdecompstlSlice::mean(
  self : TimeseriesdecompstlSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn TimeseriesdecompstlSlice::scale(
  self : TimeseriesdecompstlSlice,
  f : Double,
) -> TimeseriesdecompstlSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlSlice::add(
  self : TimeseriesdecompstlSlice,
  other : TimeseriesdecompstlSlice,
) -> TimeseriesdecompstlSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlSlice::copy(
  self : TimeseriesdecompstlSlice,
) -> TimeseriesdecompstlSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlSlice::fill(
  self : TimeseriesdecompstlSlice,
  v : Double,
) -> TimeseriesdecompstlSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn TimeseriesdecompstlSlice::min(self : TimeseriesdecompstlSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn TimeseriesdecompstlSlice::max(self : TimeseriesdecompstlSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn TimeseriesdecompstlSlice::to_string(
  self : TimeseriesdecompstlSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
