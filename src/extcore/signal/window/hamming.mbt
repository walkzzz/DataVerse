///|
///===
/// extcore/signal_window_hamming
pub(all) struct SignalwindowhammingPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn signal_window_hamming_make_point(
  x : Double,
  y : Double,
) -> SignalwindowhammingPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn signal_window_hamming_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SignalwindowhammingPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SignalwindowhammingPoint::x(self : SignalwindowhammingPoint) -> Double {
  self.x
}

///|
pub fn SignalwindowhammingPoint::y(self : SignalwindowhammingPoint) -> Double {
  self.y
}

///|
pub fn SignalwindowhammingPoint::z(self : SignalwindowhammingPoint) -> Double {
  self.z
}

///|
pub fn SignalwindowhammingPoint::label(
  self : SignalwindowhammingPoint,
) -> Int32 {
  self.label
}

///|
pub fn SignalwindowhammingPoint::dist(
  self : SignalwindowhammingPoint,
  other : SignalwindowhammingPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SignalwindowhammingPoint::add(
  self : SignalwindowhammingPoint,
  other : SignalwindowhammingPoint,
) -> SignalwindowhammingPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SignalwindowhammingPoint::sub(
  self : SignalwindowhammingPoint,
  other : SignalwindowhammingPoint,
) -> SignalwindowhammingPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SignalwindowhammingPoint::scale(
  self : SignalwindowhammingPoint,
  s : Double,
) -> SignalwindowhammingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SignalwindowhammingPoint::dot(
  self : SignalwindowhammingPoint,
  other : SignalwindowhammingPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SignalwindowhammingPoint::cross(
  self : SignalwindowhammingPoint,
  other : SignalwindowhammingPoint,
) -> SignalwindowhammingPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SignalwindowhammingPoint::norm(
  self : SignalwindowhammingPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SignalwindowhammingPoint::normalize(
  self : SignalwindowhammingPoint,
) -> SignalwindowhammingPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalwindowhammingPoint::negate(
  self : SignalwindowhammingPoint,
) -> SignalwindowhammingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SignalwindowhammingPoint::mid(
  self : SignalwindowhammingPoint,
  other : SignalwindowhammingPoint,
) -> SignalwindowhammingPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SignalwindowhammingPoint::lerp(
  self : SignalwindowhammingPoint,
  other : SignalwindowhammingPoint,
  t : Double,
) -> SignalwindowhammingPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SignalwindowhammingPoint::to_string(
  self : SignalwindowhammingPoint,
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
pub(all) struct SignalwindowhammingSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn signal_window_hamming_make_series(
  vals : Array[Double],
  name : String,
) -> SignalwindowhammingSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SignalwindowhammingSeries::len(
  self : SignalwindowhammingSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn SignalwindowhammingSeries::sum(
  self : SignalwindowhammingSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SignalwindowhammingSeries::mean(
  self : SignalwindowhammingSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SignalwindowhammingSeries::min(
  self : SignalwindowhammingSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SignalwindowhammingSeries::max(
  self : SignalwindowhammingSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SignalwindowhammingSeries::range(
  self : SignalwindowhammingSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SignalwindowhammingSeries::variance(
  self : SignalwindowhammingSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SignalwindowhammingSeries::std(
  self : SignalwindowhammingSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SignalwindowhammingSeries::median(
  self : SignalwindowhammingSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SignalwindowhammingSeries::scale(
  self : SignalwindowhammingSeries,
  f : Double,
) -> SignalwindowhammingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SignalwindowhammingSeries::add(
  self : SignalwindowhammingSeries,
  other : SignalwindowhammingSeries,
) -> SignalwindowhammingSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalwindowhammingSeries::sub(
  self : SignalwindowhammingSeries,
  other : SignalwindowhammingSeries,
) -> SignalwindowhammingSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalwindowhammingSeries::normalize(
  self : SignalwindowhammingSeries,
) -> SignalwindowhammingSeries {
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
pub fn SignalwindowhammingSeries::cumsum(
  self : SignalwindowhammingSeries,
) -> SignalwindowhammingSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SignalwindowhammingSeries::to_string(
  self : SignalwindowhammingSeries,
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
pub(all) struct SignalwindowhammingMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn signal_window_hamming_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SignalwindowhammingMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn signal_window_hamming_matrix_identity(
  n : Int32,
) -> SignalwindowhammingMatrix {
  let m = signal_window_hamming_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SignalwindowhammingMatrix::get(
  self : SignalwindowhammingMatrix,
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
pub fn SignalwindowhammingMatrix::transpose(
  self : SignalwindowhammingMatrix,
) -> SignalwindowhammingMatrix {
  let result = signal_window_hamming_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SignalwindowhammingMatrix::add(
  self : SignalwindowhammingMatrix,
  other : SignalwindowhammingMatrix,
) -> SignalwindowhammingMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = signal_window_hamming_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SignalwindowhammingMatrix::scale(
  self : SignalwindowhammingMatrix,
  s : Double,
) -> SignalwindowhammingMatrix {
  let result = signal_window_hamming_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SignalwindowhammingMatrix::multiply(
  self : SignalwindowhammingMatrix,
  other : SignalwindowhammingMatrix,
) -> SignalwindowhammingMatrix {
  if self.cols != other.rows {
    return signal_window_hamming_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = signal_window_hamming_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SignalwindowhammingMatrix::trace(
  self : SignalwindowhammingMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SignalwindowhammingMatrix::det(
  self : SignalwindowhammingMatrix,
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
pub fn SignalwindowhammingMatrix::norm(
  self : SignalwindowhammingMatrix,
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
pub fn SignalwindowhammingMatrix::to_string(
  self : SignalwindowhammingMatrix,
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
pub(all) struct SignalwindowhammingVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn signal_window_hamming_make_vector(
  comps : Array[Double],
) -> SignalwindowhammingVector {
  { comps, dim: comps.length(), }
}

///|
pub fn signal_window_hamming_vector_zero(
  dim : Int32,
) -> SignalwindowhammingVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SignalwindowhammingVector::add(
  self : SignalwindowhammingVector,
  other : SignalwindowhammingVector,
) -> SignalwindowhammingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalwindowhammingVector::sub(
  self : SignalwindowhammingVector,
  other : SignalwindowhammingVector,
) -> SignalwindowhammingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalwindowhammingVector::scale(
  self : SignalwindowhammingVector,
  s : Double,
) -> SignalwindowhammingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SignalwindowhammingVector::dot(
  self : SignalwindowhammingVector,
  other : SignalwindowhammingVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SignalwindowhammingVector::norm(
  self : SignalwindowhammingVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SignalwindowhammingVector::normalize(
  self : SignalwindowhammingVector,
) -> SignalwindowhammingVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalwindowhammingVector::dist(
  self : SignalwindowhammingVector,
  other : SignalwindowhammingVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SignalwindowhammingVector::to_string(
  self : SignalwindowhammingVector,
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
pub(all) struct SignalwindowhammingFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_frame_make(
  size : Int32,
) -> SignalwindowhammingFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingFrame::len(self : SignalwindowhammingFrame) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingFrame::get(
  self : SignalwindowhammingFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingFrame::set(
  self : SignalwindowhammingFrame,
  i : Int32,
  v : Double,
) -> SignalwindowhammingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingFrame::sum(self : SignalwindowhammingFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingFrame::mean(
  self : SignalwindowhammingFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingFrame::scale(
  self : SignalwindowhammingFrame,
  f : Double,
) -> SignalwindowhammingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingFrame::add(
  self : SignalwindowhammingFrame,
  other : SignalwindowhammingFrame,
) -> SignalwindowhammingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingFrame::copy(
  self : SignalwindowhammingFrame,
) -> SignalwindowhammingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingFrame::fill(
  self : SignalwindowhammingFrame,
  v : Double,
) -> SignalwindowhammingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingFrame::min(self : SignalwindowhammingFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingFrame::max(self : SignalwindowhammingFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingFrame::to_string(
  self : SignalwindowhammingFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_table_make(
  size : Int32,
) -> SignalwindowhammingTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingTable::len(self : SignalwindowhammingTable) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingTable::get(
  self : SignalwindowhammingTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingTable::set(
  self : SignalwindowhammingTable,
  i : Int32,
  v : Double,
) -> SignalwindowhammingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingTable::sum(self : SignalwindowhammingTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingTable::mean(
  self : SignalwindowhammingTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingTable::scale(
  self : SignalwindowhammingTable,
  f : Double,
) -> SignalwindowhammingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingTable::add(
  self : SignalwindowhammingTable,
  other : SignalwindowhammingTable,
) -> SignalwindowhammingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingTable::copy(
  self : SignalwindowhammingTable,
) -> SignalwindowhammingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingTable::fill(
  self : SignalwindowhammingTable,
  v : Double,
) -> SignalwindowhammingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingTable::min(self : SignalwindowhammingTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingTable::max(self : SignalwindowhammingTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingTable::to_string(
  self : SignalwindowhammingTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_graphn_make(
  size : Int32,
) -> SignalwindowhammingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingGraphN::len(
  self : SignalwindowhammingGraphN,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingGraphN::get(
  self : SignalwindowhammingGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingGraphN::set(
  self : SignalwindowhammingGraphN,
  i : Int32,
  v : Double,
) -> SignalwindowhammingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingGraphN::sum(
  self : SignalwindowhammingGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingGraphN::mean(
  self : SignalwindowhammingGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingGraphN::scale(
  self : SignalwindowhammingGraphN,
  f : Double,
) -> SignalwindowhammingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingGraphN::add(
  self : SignalwindowhammingGraphN,
  other : SignalwindowhammingGraphN,
) -> SignalwindowhammingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingGraphN::copy(
  self : SignalwindowhammingGraphN,
) -> SignalwindowhammingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingGraphN::fill(
  self : SignalwindowhammingGraphN,
  v : Double,
) -> SignalwindowhammingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingGraphN::min(
  self : SignalwindowhammingGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingGraphN::max(
  self : SignalwindowhammingGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingGraphN::to_string(
  self : SignalwindowhammingGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_node_make(size : Int32) -> SignalwindowhammingNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingNode::len(self : SignalwindowhammingNode) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingNode::get(
  self : SignalwindowhammingNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingNode::set(
  self : SignalwindowhammingNode,
  i : Int32,
  v : Double,
) -> SignalwindowhammingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingNode::sum(self : SignalwindowhammingNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingNode::mean(self : SignalwindowhammingNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingNode::scale(
  self : SignalwindowhammingNode,
  f : Double,
) -> SignalwindowhammingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingNode::add(
  self : SignalwindowhammingNode,
  other : SignalwindowhammingNode,
) -> SignalwindowhammingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingNode::copy(
  self : SignalwindowhammingNode,
) -> SignalwindowhammingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingNode::fill(
  self : SignalwindowhammingNode,
  v : Double,
) -> SignalwindowhammingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingNode::min(self : SignalwindowhammingNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingNode::max(self : SignalwindowhammingNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingNode::to_string(
  self : SignalwindowhammingNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_edge_make(size : Int32) -> SignalwindowhammingEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingEdge::len(self : SignalwindowhammingEdge) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingEdge::get(
  self : SignalwindowhammingEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingEdge::set(
  self : SignalwindowhammingEdge,
  i : Int32,
  v : Double,
) -> SignalwindowhammingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingEdge::sum(self : SignalwindowhammingEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingEdge::mean(self : SignalwindowhammingEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingEdge::scale(
  self : SignalwindowhammingEdge,
  f : Double,
) -> SignalwindowhammingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingEdge::add(
  self : SignalwindowhammingEdge,
  other : SignalwindowhammingEdge,
) -> SignalwindowhammingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingEdge::copy(
  self : SignalwindowhammingEdge,
) -> SignalwindowhammingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingEdge::fill(
  self : SignalwindowhammingEdge,
  v : Double,
) -> SignalwindowhammingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingEdge::min(self : SignalwindowhammingEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingEdge::max(self : SignalwindowhammingEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingEdge::to_string(
  self : SignalwindowhammingEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_path_make(size : Int32) -> SignalwindowhammingPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingPath::len(self : SignalwindowhammingPath) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingPath::get(
  self : SignalwindowhammingPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingPath::set(
  self : SignalwindowhammingPath,
  i : Int32,
  v : Double,
) -> SignalwindowhammingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingPath::sum(self : SignalwindowhammingPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingPath::mean(self : SignalwindowhammingPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingPath::scale(
  self : SignalwindowhammingPath,
  f : Double,
) -> SignalwindowhammingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingPath::add(
  self : SignalwindowhammingPath,
  other : SignalwindowhammingPath,
) -> SignalwindowhammingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingPath::copy(
  self : SignalwindowhammingPath,
) -> SignalwindowhammingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingPath::fill(
  self : SignalwindowhammingPath,
  v : Double,
) -> SignalwindowhammingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingPath::min(self : SignalwindowhammingPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingPath::max(self : SignalwindowhammingPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingPath::to_string(
  self : SignalwindowhammingPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_cluster_make(
  size : Int32,
) -> SignalwindowhammingCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingCluster::len(
  self : SignalwindowhammingCluster,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingCluster::get(
  self : SignalwindowhammingCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingCluster::set(
  self : SignalwindowhammingCluster,
  i : Int32,
  v : Double,
) -> SignalwindowhammingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingCluster::sum(
  self : SignalwindowhammingCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingCluster::mean(
  self : SignalwindowhammingCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingCluster::scale(
  self : SignalwindowhammingCluster,
  f : Double,
) -> SignalwindowhammingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingCluster::add(
  self : SignalwindowhammingCluster,
  other : SignalwindowhammingCluster,
) -> SignalwindowhammingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingCluster::copy(
  self : SignalwindowhammingCluster,
) -> SignalwindowhammingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingCluster::fill(
  self : SignalwindowhammingCluster,
  v : Double,
) -> SignalwindowhammingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingCluster::min(
  self : SignalwindowhammingCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingCluster::max(
  self : SignalwindowhammingCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingCluster::to_string(
  self : SignalwindowhammingCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_model_make(
  size : Int32,
) -> SignalwindowhammingModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingModel::len(self : SignalwindowhammingModel) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingModel::get(
  self : SignalwindowhammingModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingModel::set(
  self : SignalwindowhammingModel,
  i : Int32,
  v : Double,
) -> SignalwindowhammingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingModel::sum(self : SignalwindowhammingModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingModel::mean(
  self : SignalwindowhammingModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingModel::scale(
  self : SignalwindowhammingModel,
  f : Double,
) -> SignalwindowhammingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingModel::add(
  self : SignalwindowhammingModel,
  other : SignalwindowhammingModel,
) -> SignalwindowhammingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingModel::copy(
  self : SignalwindowhammingModel,
) -> SignalwindowhammingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingModel::fill(
  self : SignalwindowhammingModel,
  v : Double,
) -> SignalwindowhammingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingModel::min(self : SignalwindowhammingModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingModel::max(self : SignalwindowhammingModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingModel::to_string(
  self : SignalwindowhammingModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_layer_make(
  size : Int32,
) -> SignalwindowhammingLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingLayer::len(self : SignalwindowhammingLayer) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingLayer::get(
  self : SignalwindowhammingLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingLayer::set(
  self : SignalwindowhammingLayer,
  i : Int32,
  v : Double,
) -> SignalwindowhammingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingLayer::sum(self : SignalwindowhammingLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingLayer::mean(
  self : SignalwindowhammingLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingLayer::scale(
  self : SignalwindowhammingLayer,
  f : Double,
) -> SignalwindowhammingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingLayer::add(
  self : SignalwindowhammingLayer,
  other : SignalwindowhammingLayer,
) -> SignalwindowhammingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingLayer::copy(
  self : SignalwindowhammingLayer,
) -> SignalwindowhammingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingLayer::fill(
  self : SignalwindowhammingLayer,
  v : Double,
) -> SignalwindowhammingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingLayer::min(self : SignalwindowhammingLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingLayer::max(self : SignalwindowhammingLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingLayer::to_string(
  self : SignalwindowhammingLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_buffer_make(
  size : Int32,
) -> SignalwindowhammingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingBuffer::len(
  self : SignalwindowhammingBuffer,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingBuffer::get(
  self : SignalwindowhammingBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingBuffer::set(
  self : SignalwindowhammingBuffer,
  i : Int32,
  v : Double,
) -> SignalwindowhammingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingBuffer::sum(
  self : SignalwindowhammingBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingBuffer::mean(
  self : SignalwindowhammingBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingBuffer::scale(
  self : SignalwindowhammingBuffer,
  f : Double,
) -> SignalwindowhammingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingBuffer::add(
  self : SignalwindowhammingBuffer,
  other : SignalwindowhammingBuffer,
) -> SignalwindowhammingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingBuffer::copy(
  self : SignalwindowhammingBuffer,
) -> SignalwindowhammingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingBuffer::fill(
  self : SignalwindowhammingBuffer,
  v : Double,
) -> SignalwindowhammingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingBuffer::min(
  self : SignalwindowhammingBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingBuffer::max(
  self : SignalwindowhammingBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingBuffer::to_string(
  self : SignalwindowhammingBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_cursor_make(
  size : Int32,
) -> SignalwindowhammingCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingCursor::len(
  self : SignalwindowhammingCursor,
) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingCursor::get(
  self : SignalwindowhammingCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingCursor::set(
  self : SignalwindowhammingCursor,
  i : Int32,
  v : Double,
) -> SignalwindowhammingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingCursor::sum(
  self : SignalwindowhammingCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingCursor::mean(
  self : SignalwindowhammingCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingCursor::scale(
  self : SignalwindowhammingCursor,
  f : Double,
) -> SignalwindowhammingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingCursor::add(
  self : SignalwindowhammingCursor,
  other : SignalwindowhammingCursor,
) -> SignalwindowhammingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingCursor::copy(
  self : SignalwindowhammingCursor,
) -> SignalwindowhammingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingCursor::fill(
  self : SignalwindowhammingCursor,
  v : Double,
) -> SignalwindowhammingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingCursor::min(
  self : SignalwindowhammingCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingCursor::max(
  self : SignalwindowhammingCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingCursor::to_string(
  self : SignalwindowhammingCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_view_make(size : Int32) -> SignalwindowhammingView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingView::len(self : SignalwindowhammingView) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingView::get(
  self : SignalwindowhammingView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingView::set(
  self : SignalwindowhammingView,
  i : Int32,
  v : Double,
) -> SignalwindowhammingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingView::sum(self : SignalwindowhammingView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingView::mean(self : SignalwindowhammingView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingView::scale(
  self : SignalwindowhammingView,
  f : Double,
) -> SignalwindowhammingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingView::add(
  self : SignalwindowhammingView,
  other : SignalwindowhammingView,
) -> SignalwindowhammingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingView::copy(
  self : SignalwindowhammingView,
) -> SignalwindowhammingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingView::fill(
  self : SignalwindowhammingView,
  v : Double,
) -> SignalwindowhammingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingView::min(self : SignalwindowhammingView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingView::max(self : SignalwindowhammingView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingView::to_string(
  self : SignalwindowhammingView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_range_make(
  size : Int32,
) -> SignalwindowhammingRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingRange::len(self : SignalwindowhammingRange) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingRange::get(
  self : SignalwindowhammingRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingRange::set(
  self : SignalwindowhammingRange,
  i : Int32,
  v : Double,
) -> SignalwindowhammingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingRange::sum(self : SignalwindowhammingRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingRange::mean(
  self : SignalwindowhammingRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingRange::scale(
  self : SignalwindowhammingRange,
  f : Double,
) -> SignalwindowhammingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingRange::add(
  self : SignalwindowhammingRange,
  other : SignalwindowhammingRange,
) -> SignalwindowhammingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingRange::copy(
  self : SignalwindowhammingRange,
) -> SignalwindowhammingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingRange::fill(
  self : SignalwindowhammingRange,
  v : Double,
) -> SignalwindowhammingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingRange::min(self : SignalwindowhammingRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingRange::max(self : SignalwindowhammingRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingRange::to_string(
  self : SignalwindowhammingRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhammingSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hamming_slice_make(
  size : Int32,
) -> SignalwindowhammingSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhammingSlice::len(self : SignalwindowhammingSlice) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhammingSlice::get(
  self : SignalwindowhammingSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhammingSlice::set(
  self : SignalwindowhammingSlice,
  i : Int32,
  v : Double,
) -> SignalwindowhammingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingSlice::sum(self : SignalwindowhammingSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhammingSlice::mean(
  self : SignalwindowhammingSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhammingSlice::scale(
  self : SignalwindowhammingSlice,
  f : Double,
) -> SignalwindowhammingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingSlice::add(
  self : SignalwindowhammingSlice,
  other : SignalwindowhammingSlice,
) -> SignalwindowhammingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhammingSlice::copy(
  self : SignalwindowhammingSlice,
) -> SignalwindowhammingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingSlice::fill(
  self : SignalwindowhammingSlice,
  v : Double,
) -> SignalwindowhammingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhammingSlice::min(self : SignalwindowhammingSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhammingSlice::max(self : SignalwindowhammingSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhammingSlice::to_string(
  self : SignalwindowhammingSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
