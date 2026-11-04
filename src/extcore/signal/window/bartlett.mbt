///|
///===
/// extcore/signal_window_bartlett
pub(all) struct SignalwindowbartlettPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn signal_window_bartlett_make_point(
  x : Double,
  y : Double,
) -> SignalwindowbartlettPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn signal_window_bartlett_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SignalwindowbartlettPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SignalwindowbartlettPoint::x(self : SignalwindowbartlettPoint) -> Double {
  self.x
}

///|
pub fn SignalwindowbartlettPoint::y(self : SignalwindowbartlettPoint) -> Double {
  self.y
}

///|
pub fn SignalwindowbartlettPoint::z(self : SignalwindowbartlettPoint) -> Double {
  self.z
}

///|
pub fn SignalwindowbartlettPoint::label(
  self : SignalwindowbartlettPoint,
) -> Int32 {
  self.label
}

///|
pub fn SignalwindowbartlettPoint::dist(
  self : SignalwindowbartlettPoint,
  other : SignalwindowbartlettPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SignalwindowbartlettPoint::add(
  self : SignalwindowbartlettPoint,
  other : SignalwindowbartlettPoint,
) -> SignalwindowbartlettPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SignalwindowbartlettPoint::sub(
  self : SignalwindowbartlettPoint,
  other : SignalwindowbartlettPoint,
) -> SignalwindowbartlettPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SignalwindowbartlettPoint::scale(
  self : SignalwindowbartlettPoint,
  s : Double,
) -> SignalwindowbartlettPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SignalwindowbartlettPoint::dot(
  self : SignalwindowbartlettPoint,
  other : SignalwindowbartlettPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SignalwindowbartlettPoint::cross(
  self : SignalwindowbartlettPoint,
  other : SignalwindowbartlettPoint,
) -> SignalwindowbartlettPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SignalwindowbartlettPoint::norm(
  self : SignalwindowbartlettPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SignalwindowbartlettPoint::normalize(
  self : SignalwindowbartlettPoint,
) -> SignalwindowbartlettPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalwindowbartlettPoint::negate(
  self : SignalwindowbartlettPoint,
) -> SignalwindowbartlettPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SignalwindowbartlettPoint::mid(
  self : SignalwindowbartlettPoint,
  other : SignalwindowbartlettPoint,
) -> SignalwindowbartlettPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SignalwindowbartlettPoint::lerp(
  self : SignalwindowbartlettPoint,
  other : SignalwindowbartlettPoint,
  t : Double,
) -> SignalwindowbartlettPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SignalwindowbartlettPoint::to_string(
  self : SignalwindowbartlettPoint,
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
pub(all) struct SignalwindowbartlettSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn signal_window_bartlett_make_series(
  vals : Array[Double],
  name : String,
) -> SignalwindowbartlettSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SignalwindowbartlettSeries::len(
  self : SignalwindowbartlettSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn SignalwindowbartlettSeries::sum(
  self : SignalwindowbartlettSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SignalwindowbartlettSeries::mean(
  self : SignalwindowbartlettSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SignalwindowbartlettSeries::min(
  self : SignalwindowbartlettSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SignalwindowbartlettSeries::max(
  self : SignalwindowbartlettSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SignalwindowbartlettSeries::range(
  self : SignalwindowbartlettSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SignalwindowbartlettSeries::variance(
  self : SignalwindowbartlettSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SignalwindowbartlettSeries::std(
  self : SignalwindowbartlettSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SignalwindowbartlettSeries::median(
  self : SignalwindowbartlettSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SignalwindowbartlettSeries::scale(
  self : SignalwindowbartlettSeries,
  f : Double,
) -> SignalwindowbartlettSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SignalwindowbartlettSeries::add(
  self : SignalwindowbartlettSeries,
  other : SignalwindowbartlettSeries,
) -> SignalwindowbartlettSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalwindowbartlettSeries::sub(
  self : SignalwindowbartlettSeries,
  other : SignalwindowbartlettSeries,
) -> SignalwindowbartlettSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalwindowbartlettSeries::normalize(
  self : SignalwindowbartlettSeries,
) -> SignalwindowbartlettSeries {
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
pub fn SignalwindowbartlettSeries::cumsum(
  self : SignalwindowbartlettSeries,
) -> SignalwindowbartlettSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SignalwindowbartlettSeries::to_string(
  self : SignalwindowbartlettSeries,
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
pub(all) struct SignalwindowbartlettMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn signal_window_bartlett_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SignalwindowbartlettMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn signal_window_bartlett_matrix_identity(
  n : Int32,
) -> SignalwindowbartlettMatrix {
  let m = signal_window_bartlett_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SignalwindowbartlettMatrix::get(
  self : SignalwindowbartlettMatrix,
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
pub fn SignalwindowbartlettMatrix::transpose(
  self : SignalwindowbartlettMatrix,
) -> SignalwindowbartlettMatrix {
  let result = signal_window_bartlett_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SignalwindowbartlettMatrix::add(
  self : SignalwindowbartlettMatrix,
  other : SignalwindowbartlettMatrix,
) -> SignalwindowbartlettMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = signal_window_bartlett_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SignalwindowbartlettMatrix::scale(
  self : SignalwindowbartlettMatrix,
  s : Double,
) -> SignalwindowbartlettMatrix {
  let result = signal_window_bartlett_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SignalwindowbartlettMatrix::multiply(
  self : SignalwindowbartlettMatrix,
  other : SignalwindowbartlettMatrix,
) -> SignalwindowbartlettMatrix {
  if self.cols != other.rows {
    return signal_window_bartlett_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = signal_window_bartlett_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SignalwindowbartlettMatrix::trace(
  self : SignalwindowbartlettMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SignalwindowbartlettMatrix::det(
  self : SignalwindowbartlettMatrix,
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
pub fn SignalwindowbartlettMatrix::norm(
  self : SignalwindowbartlettMatrix,
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
pub fn SignalwindowbartlettMatrix::to_string(
  self : SignalwindowbartlettMatrix,
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
pub(all) struct SignalwindowbartlettVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn signal_window_bartlett_make_vector(
  comps : Array[Double],
) -> SignalwindowbartlettVector {
  { comps, dim: comps.length(), }
}

///|
pub fn signal_window_bartlett_vector_zero(
  dim : Int32,
) -> SignalwindowbartlettVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SignalwindowbartlettVector::add(
  self : SignalwindowbartlettVector,
  other : SignalwindowbartlettVector,
) -> SignalwindowbartlettVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalwindowbartlettVector::sub(
  self : SignalwindowbartlettVector,
  other : SignalwindowbartlettVector,
) -> SignalwindowbartlettVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalwindowbartlettVector::scale(
  self : SignalwindowbartlettVector,
  s : Double,
) -> SignalwindowbartlettVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SignalwindowbartlettVector::dot(
  self : SignalwindowbartlettVector,
  other : SignalwindowbartlettVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SignalwindowbartlettVector::norm(
  self : SignalwindowbartlettVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SignalwindowbartlettVector::normalize(
  self : SignalwindowbartlettVector,
) -> SignalwindowbartlettVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalwindowbartlettVector::dist(
  self : SignalwindowbartlettVector,
  other : SignalwindowbartlettVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SignalwindowbartlettVector::to_string(
  self : SignalwindowbartlettVector,
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
pub(all) struct SignalwindowbartlettFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_frame_make(
  size : Int32,
) -> SignalwindowbartlettFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettFrame::len(
  self : SignalwindowbartlettFrame,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettFrame::get(
  self : SignalwindowbartlettFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettFrame::set(
  self : SignalwindowbartlettFrame,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettFrame::sum(
  self : SignalwindowbartlettFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettFrame::mean(
  self : SignalwindowbartlettFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettFrame::scale(
  self : SignalwindowbartlettFrame,
  f : Double,
) -> SignalwindowbartlettFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettFrame::add(
  self : SignalwindowbartlettFrame,
  other : SignalwindowbartlettFrame,
) -> SignalwindowbartlettFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettFrame::copy(
  self : SignalwindowbartlettFrame,
) -> SignalwindowbartlettFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettFrame::fill(
  self : SignalwindowbartlettFrame,
  v : Double,
) -> SignalwindowbartlettFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettFrame::min(
  self : SignalwindowbartlettFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettFrame::max(
  self : SignalwindowbartlettFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettFrame::to_string(
  self : SignalwindowbartlettFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_table_make(
  size : Int32,
) -> SignalwindowbartlettTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettTable::len(
  self : SignalwindowbartlettTable,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettTable::get(
  self : SignalwindowbartlettTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettTable::set(
  self : SignalwindowbartlettTable,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettTable::sum(
  self : SignalwindowbartlettTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettTable::mean(
  self : SignalwindowbartlettTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettTable::scale(
  self : SignalwindowbartlettTable,
  f : Double,
) -> SignalwindowbartlettTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettTable::add(
  self : SignalwindowbartlettTable,
  other : SignalwindowbartlettTable,
) -> SignalwindowbartlettTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettTable::copy(
  self : SignalwindowbartlettTable,
) -> SignalwindowbartlettTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettTable::fill(
  self : SignalwindowbartlettTable,
  v : Double,
) -> SignalwindowbartlettTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettTable::min(
  self : SignalwindowbartlettTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettTable::max(
  self : SignalwindowbartlettTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettTable::to_string(
  self : SignalwindowbartlettTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_graphn_make(
  size : Int32,
) -> SignalwindowbartlettGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettGraphN::len(
  self : SignalwindowbartlettGraphN,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettGraphN::get(
  self : SignalwindowbartlettGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettGraphN::set(
  self : SignalwindowbartlettGraphN,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettGraphN::sum(
  self : SignalwindowbartlettGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettGraphN::mean(
  self : SignalwindowbartlettGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettGraphN::scale(
  self : SignalwindowbartlettGraphN,
  f : Double,
) -> SignalwindowbartlettGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettGraphN::add(
  self : SignalwindowbartlettGraphN,
  other : SignalwindowbartlettGraphN,
) -> SignalwindowbartlettGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettGraphN::copy(
  self : SignalwindowbartlettGraphN,
) -> SignalwindowbartlettGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettGraphN::fill(
  self : SignalwindowbartlettGraphN,
  v : Double,
) -> SignalwindowbartlettGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettGraphN::min(
  self : SignalwindowbartlettGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettGraphN::max(
  self : SignalwindowbartlettGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettGraphN::to_string(
  self : SignalwindowbartlettGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_node_make(
  size : Int32,
) -> SignalwindowbartlettNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettNode::len(self : SignalwindowbartlettNode) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettNode::get(
  self : SignalwindowbartlettNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettNode::set(
  self : SignalwindowbartlettNode,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettNode::sum(self : SignalwindowbartlettNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettNode::mean(
  self : SignalwindowbartlettNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettNode::scale(
  self : SignalwindowbartlettNode,
  f : Double,
) -> SignalwindowbartlettNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettNode::add(
  self : SignalwindowbartlettNode,
  other : SignalwindowbartlettNode,
) -> SignalwindowbartlettNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettNode::copy(
  self : SignalwindowbartlettNode,
) -> SignalwindowbartlettNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettNode::fill(
  self : SignalwindowbartlettNode,
  v : Double,
) -> SignalwindowbartlettNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettNode::min(self : SignalwindowbartlettNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettNode::max(self : SignalwindowbartlettNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettNode::to_string(
  self : SignalwindowbartlettNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_edge_make(
  size : Int32,
) -> SignalwindowbartlettEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettEdge::len(self : SignalwindowbartlettEdge) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettEdge::get(
  self : SignalwindowbartlettEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettEdge::set(
  self : SignalwindowbartlettEdge,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettEdge::sum(self : SignalwindowbartlettEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettEdge::mean(
  self : SignalwindowbartlettEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettEdge::scale(
  self : SignalwindowbartlettEdge,
  f : Double,
) -> SignalwindowbartlettEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettEdge::add(
  self : SignalwindowbartlettEdge,
  other : SignalwindowbartlettEdge,
) -> SignalwindowbartlettEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettEdge::copy(
  self : SignalwindowbartlettEdge,
) -> SignalwindowbartlettEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettEdge::fill(
  self : SignalwindowbartlettEdge,
  v : Double,
) -> SignalwindowbartlettEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettEdge::min(self : SignalwindowbartlettEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettEdge::max(self : SignalwindowbartlettEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettEdge::to_string(
  self : SignalwindowbartlettEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_path_make(
  size : Int32,
) -> SignalwindowbartlettPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettPath::len(self : SignalwindowbartlettPath) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettPath::get(
  self : SignalwindowbartlettPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettPath::set(
  self : SignalwindowbartlettPath,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettPath::sum(self : SignalwindowbartlettPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettPath::mean(
  self : SignalwindowbartlettPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettPath::scale(
  self : SignalwindowbartlettPath,
  f : Double,
) -> SignalwindowbartlettPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettPath::add(
  self : SignalwindowbartlettPath,
  other : SignalwindowbartlettPath,
) -> SignalwindowbartlettPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettPath::copy(
  self : SignalwindowbartlettPath,
) -> SignalwindowbartlettPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettPath::fill(
  self : SignalwindowbartlettPath,
  v : Double,
) -> SignalwindowbartlettPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettPath::min(self : SignalwindowbartlettPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettPath::max(self : SignalwindowbartlettPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettPath::to_string(
  self : SignalwindowbartlettPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_cluster_make(
  size : Int32,
) -> SignalwindowbartlettCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettCluster::len(
  self : SignalwindowbartlettCluster,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettCluster::get(
  self : SignalwindowbartlettCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettCluster::set(
  self : SignalwindowbartlettCluster,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettCluster::sum(
  self : SignalwindowbartlettCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettCluster::mean(
  self : SignalwindowbartlettCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettCluster::scale(
  self : SignalwindowbartlettCluster,
  f : Double,
) -> SignalwindowbartlettCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettCluster::add(
  self : SignalwindowbartlettCluster,
  other : SignalwindowbartlettCluster,
) -> SignalwindowbartlettCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettCluster::copy(
  self : SignalwindowbartlettCluster,
) -> SignalwindowbartlettCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettCluster::fill(
  self : SignalwindowbartlettCluster,
  v : Double,
) -> SignalwindowbartlettCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettCluster::min(
  self : SignalwindowbartlettCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettCluster::max(
  self : SignalwindowbartlettCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettCluster::to_string(
  self : SignalwindowbartlettCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_model_make(
  size : Int32,
) -> SignalwindowbartlettModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettModel::len(
  self : SignalwindowbartlettModel,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettModel::get(
  self : SignalwindowbartlettModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettModel::set(
  self : SignalwindowbartlettModel,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettModel::sum(
  self : SignalwindowbartlettModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettModel::mean(
  self : SignalwindowbartlettModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettModel::scale(
  self : SignalwindowbartlettModel,
  f : Double,
) -> SignalwindowbartlettModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettModel::add(
  self : SignalwindowbartlettModel,
  other : SignalwindowbartlettModel,
) -> SignalwindowbartlettModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettModel::copy(
  self : SignalwindowbartlettModel,
) -> SignalwindowbartlettModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettModel::fill(
  self : SignalwindowbartlettModel,
  v : Double,
) -> SignalwindowbartlettModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettModel::min(
  self : SignalwindowbartlettModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettModel::max(
  self : SignalwindowbartlettModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettModel::to_string(
  self : SignalwindowbartlettModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_layer_make(
  size : Int32,
) -> SignalwindowbartlettLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettLayer::len(
  self : SignalwindowbartlettLayer,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettLayer::get(
  self : SignalwindowbartlettLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettLayer::set(
  self : SignalwindowbartlettLayer,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettLayer::sum(
  self : SignalwindowbartlettLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettLayer::mean(
  self : SignalwindowbartlettLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettLayer::scale(
  self : SignalwindowbartlettLayer,
  f : Double,
) -> SignalwindowbartlettLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettLayer::add(
  self : SignalwindowbartlettLayer,
  other : SignalwindowbartlettLayer,
) -> SignalwindowbartlettLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettLayer::copy(
  self : SignalwindowbartlettLayer,
) -> SignalwindowbartlettLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettLayer::fill(
  self : SignalwindowbartlettLayer,
  v : Double,
) -> SignalwindowbartlettLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettLayer::min(
  self : SignalwindowbartlettLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettLayer::max(
  self : SignalwindowbartlettLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettLayer::to_string(
  self : SignalwindowbartlettLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_buffer_make(
  size : Int32,
) -> SignalwindowbartlettBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettBuffer::len(
  self : SignalwindowbartlettBuffer,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettBuffer::get(
  self : SignalwindowbartlettBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettBuffer::set(
  self : SignalwindowbartlettBuffer,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettBuffer::sum(
  self : SignalwindowbartlettBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettBuffer::mean(
  self : SignalwindowbartlettBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettBuffer::scale(
  self : SignalwindowbartlettBuffer,
  f : Double,
) -> SignalwindowbartlettBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettBuffer::add(
  self : SignalwindowbartlettBuffer,
  other : SignalwindowbartlettBuffer,
) -> SignalwindowbartlettBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettBuffer::copy(
  self : SignalwindowbartlettBuffer,
) -> SignalwindowbartlettBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettBuffer::fill(
  self : SignalwindowbartlettBuffer,
  v : Double,
) -> SignalwindowbartlettBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettBuffer::min(
  self : SignalwindowbartlettBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettBuffer::max(
  self : SignalwindowbartlettBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettBuffer::to_string(
  self : SignalwindowbartlettBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_cursor_make(
  size : Int32,
) -> SignalwindowbartlettCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettCursor::len(
  self : SignalwindowbartlettCursor,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettCursor::get(
  self : SignalwindowbartlettCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettCursor::set(
  self : SignalwindowbartlettCursor,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettCursor::sum(
  self : SignalwindowbartlettCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettCursor::mean(
  self : SignalwindowbartlettCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettCursor::scale(
  self : SignalwindowbartlettCursor,
  f : Double,
) -> SignalwindowbartlettCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettCursor::add(
  self : SignalwindowbartlettCursor,
  other : SignalwindowbartlettCursor,
) -> SignalwindowbartlettCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettCursor::copy(
  self : SignalwindowbartlettCursor,
) -> SignalwindowbartlettCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettCursor::fill(
  self : SignalwindowbartlettCursor,
  v : Double,
) -> SignalwindowbartlettCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettCursor::min(
  self : SignalwindowbartlettCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettCursor::max(
  self : SignalwindowbartlettCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettCursor::to_string(
  self : SignalwindowbartlettCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_view_make(
  size : Int32,
) -> SignalwindowbartlettView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettView::len(self : SignalwindowbartlettView) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettView::get(
  self : SignalwindowbartlettView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettView::set(
  self : SignalwindowbartlettView,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettView::sum(self : SignalwindowbartlettView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettView::mean(
  self : SignalwindowbartlettView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettView::scale(
  self : SignalwindowbartlettView,
  f : Double,
) -> SignalwindowbartlettView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettView::add(
  self : SignalwindowbartlettView,
  other : SignalwindowbartlettView,
) -> SignalwindowbartlettView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettView::copy(
  self : SignalwindowbartlettView,
) -> SignalwindowbartlettView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettView::fill(
  self : SignalwindowbartlettView,
  v : Double,
) -> SignalwindowbartlettView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettView::min(self : SignalwindowbartlettView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettView::max(self : SignalwindowbartlettView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettView::to_string(
  self : SignalwindowbartlettView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_range_make(
  size : Int32,
) -> SignalwindowbartlettRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettRange::len(
  self : SignalwindowbartlettRange,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettRange::get(
  self : SignalwindowbartlettRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettRange::set(
  self : SignalwindowbartlettRange,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettRange::sum(
  self : SignalwindowbartlettRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettRange::mean(
  self : SignalwindowbartlettRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettRange::scale(
  self : SignalwindowbartlettRange,
  f : Double,
) -> SignalwindowbartlettRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettRange::add(
  self : SignalwindowbartlettRange,
  other : SignalwindowbartlettRange,
) -> SignalwindowbartlettRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettRange::copy(
  self : SignalwindowbartlettRange,
) -> SignalwindowbartlettRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettRange::fill(
  self : SignalwindowbartlettRange,
  v : Double,
) -> SignalwindowbartlettRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettRange::min(
  self : SignalwindowbartlettRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettRange::max(
  self : SignalwindowbartlettRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettRange::to_string(
  self : SignalwindowbartlettRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowbartlettSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_bartlett_slice_make(
  size : Int32,
) -> SignalwindowbartlettSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowbartlettSlice::len(
  self : SignalwindowbartlettSlice,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowbartlettSlice::get(
  self : SignalwindowbartlettSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowbartlettSlice::set(
  self : SignalwindowbartlettSlice,
  i : Int32,
  v : Double,
) -> SignalwindowbartlettSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettSlice::sum(
  self : SignalwindowbartlettSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowbartlettSlice::mean(
  self : SignalwindowbartlettSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowbartlettSlice::scale(
  self : SignalwindowbartlettSlice,
  f : Double,
) -> SignalwindowbartlettSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettSlice::add(
  self : SignalwindowbartlettSlice,
  other : SignalwindowbartlettSlice,
) -> SignalwindowbartlettSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettSlice::copy(
  self : SignalwindowbartlettSlice,
) -> SignalwindowbartlettSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettSlice::fill(
  self : SignalwindowbartlettSlice,
  v : Double,
) -> SignalwindowbartlettSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowbartlettSlice::min(
  self : SignalwindowbartlettSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowbartlettSlice::max(
  self : SignalwindowbartlettSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowbartlettSlice::to_string(
  self : SignalwindowbartlettSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
