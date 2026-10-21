///|
///===
/// extcore/signal_spec_multitaper
pub(all) struct SignalspecmultitaperPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn signal_spec_multitaper_make_point(
  x : Double,
  y : Double,
) -> SignalspecmultitaperPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn signal_spec_multitaper_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SignalspecmultitaperPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SignalspecmultitaperPoint::x(self : SignalspecmultitaperPoint) -> Double {
  self.x
}

///|
pub fn SignalspecmultitaperPoint::y(self : SignalspecmultitaperPoint) -> Double {
  self.y
}

///|
pub fn SignalspecmultitaperPoint::z(self : SignalspecmultitaperPoint) -> Double {
  self.z
}

///|
pub fn SignalspecmultitaperPoint::label(
  self : SignalspecmultitaperPoint,
) -> Int32 {
  self.label
}

///|
pub fn SignalspecmultitaperPoint::dist(
  self : SignalspecmultitaperPoint,
  other : SignalspecmultitaperPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SignalspecmultitaperPoint::add(
  self : SignalspecmultitaperPoint,
  other : SignalspecmultitaperPoint,
) -> SignalspecmultitaperPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SignalspecmultitaperPoint::sub(
  self : SignalspecmultitaperPoint,
  other : SignalspecmultitaperPoint,
) -> SignalspecmultitaperPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SignalspecmultitaperPoint::scale(
  self : SignalspecmultitaperPoint,
  s : Double,
) -> SignalspecmultitaperPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SignalspecmultitaperPoint::dot(
  self : SignalspecmultitaperPoint,
  other : SignalspecmultitaperPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SignalspecmultitaperPoint::cross(
  self : SignalspecmultitaperPoint,
  other : SignalspecmultitaperPoint,
) -> SignalspecmultitaperPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SignalspecmultitaperPoint::norm(
  self : SignalspecmultitaperPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SignalspecmultitaperPoint::normalize(
  self : SignalspecmultitaperPoint,
) -> SignalspecmultitaperPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalspecmultitaperPoint::negate(
  self : SignalspecmultitaperPoint,
) -> SignalspecmultitaperPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SignalspecmultitaperPoint::mid(
  self : SignalspecmultitaperPoint,
  other : SignalspecmultitaperPoint,
) -> SignalspecmultitaperPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SignalspecmultitaperPoint::lerp(
  self : SignalspecmultitaperPoint,
  other : SignalspecmultitaperPoint,
  t : Double,
) -> SignalspecmultitaperPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SignalspecmultitaperPoint::to_string(
  self : SignalspecmultitaperPoint,
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
pub(all) struct SignalspecmultitaperSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn signal_spec_multitaper_make_series(
  vals : Array[Double],
  name : String,
) -> SignalspecmultitaperSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SignalspecmultitaperSeries::len(
  self : SignalspecmultitaperSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn SignalspecmultitaperSeries::sum(
  self : SignalspecmultitaperSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SignalspecmultitaperSeries::mean(
  self : SignalspecmultitaperSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SignalspecmultitaperSeries::min(
  self : SignalspecmultitaperSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SignalspecmultitaperSeries::max(
  self : SignalspecmultitaperSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SignalspecmultitaperSeries::range(
  self : SignalspecmultitaperSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SignalspecmultitaperSeries::variance(
  self : SignalspecmultitaperSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SignalspecmultitaperSeries::std(
  self : SignalspecmultitaperSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SignalspecmultitaperSeries::median(
  self : SignalspecmultitaperSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SignalspecmultitaperSeries::scale(
  self : SignalspecmultitaperSeries,
  f : Double,
) -> SignalspecmultitaperSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SignalspecmultitaperSeries::add(
  self : SignalspecmultitaperSeries,
  other : SignalspecmultitaperSeries,
) -> SignalspecmultitaperSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalspecmultitaperSeries::sub(
  self : SignalspecmultitaperSeries,
  other : SignalspecmultitaperSeries,
) -> SignalspecmultitaperSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalspecmultitaperSeries::normalize(
  self : SignalspecmultitaperSeries,
) -> SignalspecmultitaperSeries {
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
pub fn SignalspecmultitaperSeries::cumsum(
  self : SignalspecmultitaperSeries,
) -> SignalspecmultitaperSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SignalspecmultitaperSeries::to_string(
  self : SignalspecmultitaperSeries,
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
pub(all) struct SignalspecmultitaperMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn signal_spec_multitaper_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SignalspecmultitaperMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn signal_spec_multitaper_matrix_identity(
  n : Int32,
) -> SignalspecmultitaperMatrix {
  let m = signal_spec_multitaper_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SignalspecmultitaperMatrix::get(
  self : SignalspecmultitaperMatrix,
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
pub fn SignalspecmultitaperMatrix::transpose(
  self : SignalspecmultitaperMatrix,
) -> SignalspecmultitaperMatrix {
  let result = signal_spec_multitaper_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SignalspecmultitaperMatrix::add(
  self : SignalspecmultitaperMatrix,
  other : SignalspecmultitaperMatrix,
) -> SignalspecmultitaperMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = signal_spec_multitaper_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SignalspecmultitaperMatrix::scale(
  self : SignalspecmultitaperMatrix,
  s : Double,
) -> SignalspecmultitaperMatrix {
  let result = signal_spec_multitaper_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SignalspecmultitaperMatrix::multiply(
  self : SignalspecmultitaperMatrix,
  other : SignalspecmultitaperMatrix,
) -> SignalspecmultitaperMatrix {
  if self.cols != other.rows {
    return signal_spec_multitaper_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = signal_spec_multitaper_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SignalspecmultitaperMatrix::trace(
  self : SignalspecmultitaperMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SignalspecmultitaperMatrix::det(
  self : SignalspecmultitaperMatrix,
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
pub fn SignalspecmultitaperMatrix::norm(
  self : SignalspecmultitaperMatrix,
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
pub fn SignalspecmultitaperMatrix::to_string(
  self : SignalspecmultitaperMatrix,
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
pub(all) struct SignalspecmultitaperVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn signal_spec_multitaper_make_vector(
  comps : Array[Double],
) -> SignalspecmultitaperVector {
  { comps, dim: comps.length(), }
}

///|
pub fn signal_spec_multitaper_vector_zero(
  dim : Int32,
) -> SignalspecmultitaperVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SignalspecmultitaperVector::add(
  self : SignalspecmultitaperVector,
  other : SignalspecmultitaperVector,
) -> SignalspecmultitaperVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalspecmultitaperVector::sub(
  self : SignalspecmultitaperVector,
  other : SignalspecmultitaperVector,
) -> SignalspecmultitaperVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalspecmultitaperVector::scale(
  self : SignalspecmultitaperVector,
  s : Double,
) -> SignalspecmultitaperVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SignalspecmultitaperVector::dot(
  self : SignalspecmultitaperVector,
  other : SignalspecmultitaperVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SignalspecmultitaperVector::norm(
  self : SignalspecmultitaperVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SignalspecmultitaperVector::normalize(
  self : SignalspecmultitaperVector,
) -> SignalspecmultitaperVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalspecmultitaperVector::dist(
  self : SignalspecmultitaperVector,
  other : SignalspecmultitaperVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SignalspecmultitaperVector::to_string(
  self : SignalspecmultitaperVector,
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
pub(all) struct SignalspecmultitaperFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_frame_make(
  size : Int32,
) -> SignalspecmultitaperFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperFrame::len(
  self : SignalspecmultitaperFrame,
) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperFrame::get(
  self : SignalspecmultitaperFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperFrame::set(
  self : SignalspecmultitaperFrame,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperFrame::sum(
  self : SignalspecmultitaperFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperFrame::mean(
  self : SignalspecmultitaperFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperFrame::scale(
  self : SignalspecmultitaperFrame,
  f : Double,
) -> SignalspecmultitaperFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperFrame::add(
  self : SignalspecmultitaperFrame,
  other : SignalspecmultitaperFrame,
) -> SignalspecmultitaperFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperFrame::copy(
  self : SignalspecmultitaperFrame,
) -> SignalspecmultitaperFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperFrame::fill(
  self : SignalspecmultitaperFrame,
  v : Double,
) -> SignalspecmultitaperFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperFrame::min(
  self : SignalspecmultitaperFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperFrame::max(
  self : SignalspecmultitaperFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperFrame::to_string(
  self : SignalspecmultitaperFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_table_make(
  size : Int32,
) -> SignalspecmultitaperTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperTable::len(
  self : SignalspecmultitaperTable,
) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperTable::get(
  self : SignalspecmultitaperTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperTable::set(
  self : SignalspecmultitaperTable,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperTable::sum(
  self : SignalspecmultitaperTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperTable::mean(
  self : SignalspecmultitaperTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperTable::scale(
  self : SignalspecmultitaperTable,
  f : Double,
) -> SignalspecmultitaperTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperTable::add(
  self : SignalspecmultitaperTable,
  other : SignalspecmultitaperTable,
) -> SignalspecmultitaperTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperTable::copy(
  self : SignalspecmultitaperTable,
) -> SignalspecmultitaperTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperTable::fill(
  self : SignalspecmultitaperTable,
  v : Double,
) -> SignalspecmultitaperTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperTable::min(
  self : SignalspecmultitaperTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperTable::max(
  self : SignalspecmultitaperTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperTable::to_string(
  self : SignalspecmultitaperTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_graphn_make(
  size : Int32,
) -> SignalspecmultitaperGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperGraphN::len(
  self : SignalspecmultitaperGraphN,
) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperGraphN::get(
  self : SignalspecmultitaperGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperGraphN::set(
  self : SignalspecmultitaperGraphN,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperGraphN::sum(
  self : SignalspecmultitaperGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperGraphN::mean(
  self : SignalspecmultitaperGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperGraphN::scale(
  self : SignalspecmultitaperGraphN,
  f : Double,
) -> SignalspecmultitaperGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperGraphN::add(
  self : SignalspecmultitaperGraphN,
  other : SignalspecmultitaperGraphN,
) -> SignalspecmultitaperGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperGraphN::copy(
  self : SignalspecmultitaperGraphN,
) -> SignalspecmultitaperGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperGraphN::fill(
  self : SignalspecmultitaperGraphN,
  v : Double,
) -> SignalspecmultitaperGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperGraphN::min(
  self : SignalspecmultitaperGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperGraphN::max(
  self : SignalspecmultitaperGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperGraphN::to_string(
  self : SignalspecmultitaperGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_node_make(
  size : Int32,
) -> SignalspecmultitaperNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperNode::len(self : SignalspecmultitaperNode) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperNode::get(
  self : SignalspecmultitaperNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperNode::set(
  self : SignalspecmultitaperNode,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperNode::sum(self : SignalspecmultitaperNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperNode::mean(
  self : SignalspecmultitaperNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperNode::scale(
  self : SignalspecmultitaperNode,
  f : Double,
) -> SignalspecmultitaperNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperNode::add(
  self : SignalspecmultitaperNode,
  other : SignalspecmultitaperNode,
) -> SignalspecmultitaperNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperNode::copy(
  self : SignalspecmultitaperNode,
) -> SignalspecmultitaperNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperNode::fill(
  self : SignalspecmultitaperNode,
  v : Double,
) -> SignalspecmultitaperNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperNode::min(self : SignalspecmultitaperNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperNode::max(self : SignalspecmultitaperNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperNode::to_string(
  self : SignalspecmultitaperNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_edge_make(
  size : Int32,
) -> SignalspecmultitaperEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperEdge::len(self : SignalspecmultitaperEdge) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperEdge::get(
  self : SignalspecmultitaperEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperEdge::set(
  self : SignalspecmultitaperEdge,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperEdge::sum(self : SignalspecmultitaperEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperEdge::mean(
  self : SignalspecmultitaperEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperEdge::scale(
  self : SignalspecmultitaperEdge,
  f : Double,
) -> SignalspecmultitaperEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperEdge::add(
  self : SignalspecmultitaperEdge,
  other : SignalspecmultitaperEdge,
) -> SignalspecmultitaperEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperEdge::copy(
  self : SignalspecmultitaperEdge,
) -> SignalspecmultitaperEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperEdge::fill(
  self : SignalspecmultitaperEdge,
  v : Double,
) -> SignalspecmultitaperEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperEdge::min(self : SignalspecmultitaperEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperEdge::max(self : SignalspecmultitaperEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperEdge::to_string(
  self : SignalspecmultitaperEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_path_make(
  size : Int32,
) -> SignalspecmultitaperPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperPath::len(self : SignalspecmultitaperPath) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperPath::get(
  self : SignalspecmultitaperPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperPath::set(
  self : SignalspecmultitaperPath,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperPath::sum(self : SignalspecmultitaperPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperPath::mean(
  self : SignalspecmultitaperPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperPath::scale(
  self : SignalspecmultitaperPath,
  f : Double,
) -> SignalspecmultitaperPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperPath::add(
  self : SignalspecmultitaperPath,
  other : SignalspecmultitaperPath,
) -> SignalspecmultitaperPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperPath::copy(
  self : SignalspecmultitaperPath,
) -> SignalspecmultitaperPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperPath::fill(
  self : SignalspecmultitaperPath,
  v : Double,
) -> SignalspecmultitaperPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperPath::min(self : SignalspecmultitaperPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperPath::max(self : SignalspecmultitaperPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperPath::to_string(
  self : SignalspecmultitaperPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_cluster_make(
  size : Int32,
) -> SignalspecmultitaperCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperCluster::len(
  self : SignalspecmultitaperCluster,
) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperCluster::get(
  self : SignalspecmultitaperCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperCluster::set(
  self : SignalspecmultitaperCluster,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperCluster::sum(
  self : SignalspecmultitaperCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperCluster::mean(
  self : SignalspecmultitaperCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperCluster::scale(
  self : SignalspecmultitaperCluster,
  f : Double,
) -> SignalspecmultitaperCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperCluster::add(
  self : SignalspecmultitaperCluster,
  other : SignalspecmultitaperCluster,
) -> SignalspecmultitaperCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperCluster::copy(
  self : SignalspecmultitaperCluster,
) -> SignalspecmultitaperCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperCluster::fill(
  self : SignalspecmultitaperCluster,
  v : Double,
) -> SignalspecmultitaperCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperCluster::min(
  self : SignalspecmultitaperCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperCluster::max(
  self : SignalspecmultitaperCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperCluster::to_string(
  self : SignalspecmultitaperCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_model_make(
  size : Int32,
) -> SignalspecmultitaperModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperModel::len(
  self : SignalspecmultitaperModel,
) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperModel::get(
  self : SignalspecmultitaperModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperModel::set(
  self : SignalspecmultitaperModel,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperModel::sum(
  self : SignalspecmultitaperModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperModel::mean(
  self : SignalspecmultitaperModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperModel::scale(
  self : SignalspecmultitaperModel,
  f : Double,
) -> SignalspecmultitaperModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperModel::add(
  self : SignalspecmultitaperModel,
  other : SignalspecmultitaperModel,
) -> SignalspecmultitaperModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperModel::copy(
  self : SignalspecmultitaperModel,
) -> SignalspecmultitaperModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperModel::fill(
  self : SignalspecmultitaperModel,
  v : Double,
) -> SignalspecmultitaperModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperModel::min(
  self : SignalspecmultitaperModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperModel::max(
  self : SignalspecmultitaperModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperModel::to_string(
  self : SignalspecmultitaperModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_layer_make(
  size : Int32,
) -> SignalspecmultitaperLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperLayer::len(
  self : SignalspecmultitaperLayer,
) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperLayer::get(
  self : SignalspecmultitaperLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperLayer::set(
  self : SignalspecmultitaperLayer,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperLayer::sum(
  self : SignalspecmultitaperLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperLayer::mean(
  self : SignalspecmultitaperLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperLayer::scale(
  self : SignalspecmultitaperLayer,
  f : Double,
) -> SignalspecmultitaperLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperLayer::add(
  self : SignalspecmultitaperLayer,
  other : SignalspecmultitaperLayer,
) -> SignalspecmultitaperLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperLayer::copy(
  self : SignalspecmultitaperLayer,
) -> SignalspecmultitaperLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperLayer::fill(
  self : SignalspecmultitaperLayer,
  v : Double,
) -> SignalspecmultitaperLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperLayer::min(
  self : SignalspecmultitaperLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperLayer::max(
  self : SignalspecmultitaperLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperLayer::to_string(
  self : SignalspecmultitaperLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_buffer_make(
  size : Int32,
) -> SignalspecmultitaperBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperBuffer::len(
  self : SignalspecmultitaperBuffer,
) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperBuffer::get(
  self : SignalspecmultitaperBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperBuffer::set(
  self : SignalspecmultitaperBuffer,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperBuffer::sum(
  self : SignalspecmultitaperBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperBuffer::mean(
  self : SignalspecmultitaperBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperBuffer::scale(
  self : SignalspecmultitaperBuffer,
  f : Double,
) -> SignalspecmultitaperBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperBuffer::add(
  self : SignalspecmultitaperBuffer,
  other : SignalspecmultitaperBuffer,
) -> SignalspecmultitaperBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperBuffer::copy(
  self : SignalspecmultitaperBuffer,
) -> SignalspecmultitaperBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperBuffer::fill(
  self : SignalspecmultitaperBuffer,
  v : Double,
) -> SignalspecmultitaperBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperBuffer::min(
  self : SignalspecmultitaperBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperBuffer::max(
  self : SignalspecmultitaperBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperBuffer::to_string(
  self : SignalspecmultitaperBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_cursor_make(
  size : Int32,
) -> SignalspecmultitaperCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperCursor::len(
  self : SignalspecmultitaperCursor,
) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperCursor::get(
  self : SignalspecmultitaperCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperCursor::set(
  self : SignalspecmultitaperCursor,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperCursor::sum(
  self : SignalspecmultitaperCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperCursor::mean(
  self : SignalspecmultitaperCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperCursor::scale(
  self : SignalspecmultitaperCursor,
  f : Double,
) -> SignalspecmultitaperCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperCursor::add(
  self : SignalspecmultitaperCursor,
  other : SignalspecmultitaperCursor,
) -> SignalspecmultitaperCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperCursor::copy(
  self : SignalspecmultitaperCursor,
) -> SignalspecmultitaperCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperCursor::fill(
  self : SignalspecmultitaperCursor,
  v : Double,
) -> SignalspecmultitaperCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperCursor::min(
  self : SignalspecmultitaperCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperCursor::max(
  self : SignalspecmultitaperCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperCursor::to_string(
  self : SignalspecmultitaperCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_view_make(
  size : Int32,
) -> SignalspecmultitaperView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperView::len(self : SignalspecmultitaperView) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperView::get(
  self : SignalspecmultitaperView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperView::set(
  self : SignalspecmultitaperView,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperView::sum(self : SignalspecmultitaperView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperView::mean(
  self : SignalspecmultitaperView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperView::scale(
  self : SignalspecmultitaperView,
  f : Double,
) -> SignalspecmultitaperView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperView::add(
  self : SignalspecmultitaperView,
  other : SignalspecmultitaperView,
) -> SignalspecmultitaperView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperView::copy(
  self : SignalspecmultitaperView,
) -> SignalspecmultitaperView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperView::fill(
  self : SignalspecmultitaperView,
  v : Double,
) -> SignalspecmultitaperView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperView::min(self : SignalspecmultitaperView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperView::max(self : SignalspecmultitaperView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperView::to_string(
  self : SignalspecmultitaperView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_range_make(
  size : Int32,
) -> SignalspecmultitaperRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperRange::len(
  self : SignalspecmultitaperRange,
) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperRange::get(
  self : SignalspecmultitaperRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperRange::set(
  self : SignalspecmultitaperRange,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperRange::sum(
  self : SignalspecmultitaperRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperRange::mean(
  self : SignalspecmultitaperRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperRange::scale(
  self : SignalspecmultitaperRange,
  f : Double,
) -> SignalspecmultitaperRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperRange::add(
  self : SignalspecmultitaperRange,
  other : SignalspecmultitaperRange,
) -> SignalspecmultitaperRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperRange::copy(
  self : SignalspecmultitaperRange,
) -> SignalspecmultitaperRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperRange::fill(
  self : SignalspecmultitaperRange,
  v : Double,
) -> SignalspecmultitaperRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperRange::min(
  self : SignalspecmultitaperRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperRange::max(
  self : SignalspecmultitaperRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperRange::to_string(
  self : SignalspecmultitaperRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspecmultitaperSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_multitaper_slice_make(
  size : Int32,
) -> SignalspecmultitaperSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspecmultitaperSlice::len(
  self : SignalspecmultitaperSlice,
) -> Int32 {
  self.size
}

///|
pub fn SignalspecmultitaperSlice::get(
  self : SignalspecmultitaperSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspecmultitaperSlice::set(
  self : SignalspecmultitaperSlice,
  i : Int32,
  v : Double,
) -> SignalspecmultitaperSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperSlice::sum(
  self : SignalspecmultitaperSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspecmultitaperSlice::mean(
  self : SignalspecmultitaperSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspecmultitaperSlice::scale(
  self : SignalspecmultitaperSlice,
  f : Double,
) -> SignalspecmultitaperSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperSlice::add(
  self : SignalspecmultitaperSlice,
  other : SignalspecmultitaperSlice,
) -> SignalspecmultitaperSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperSlice::copy(
  self : SignalspecmultitaperSlice,
) -> SignalspecmultitaperSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperSlice::fill(
  self : SignalspecmultitaperSlice,
  v : Double,
) -> SignalspecmultitaperSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspecmultitaperSlice::min(
  self : SignalspecmultitaperSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspecmultitaperSlice::max(
  self : SignalspecmultitaperSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspecmultitaperSlice::to_string(
  self : SignalspecmultitaperSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
