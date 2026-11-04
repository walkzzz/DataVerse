///|
///===
/// extcore/signal_window_hann
pub(all) struct SignalwindowhannPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn signal_window_hann_make_point(
  x : Double,
  y : Double,
) -> SignalwindowhannPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn signal_window_hann_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SignalwindowhannPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SignalwindowhannPoint::x(self : SignalwindowhannPoint) -> Double {
  self.x
}

///|
pub fn SignalwindowhannPoint::y(self : SignalwindowhannPoint) -> Double {
  self.y
}

///|
pub fn SignalwindowhannPoint::z(self : SignalwindowhannPoint) -> Double {
  self.z
}

///|
pub fn SignalwindowhannPoint::label(self : SignalwindowhannPoint) -> Int32 {
  self.label
}

///|
pub fn SignalwindowhannPoint::dist(
  self : SignalwindowhannPoint,
  other : SignalwindowhannPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SignalwindowhannPoint::add(
  self : SignalwindowhannPoint,
  other : SignalwindowhannPoint,
) -> SignalwindowhannPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SignalwindowhannPoint::sub(
  self : SignalwindowhannPoint,
  other : SignalwindowhannPoint,
) -> SignalwindowhannPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SignalwindowhannPoint::scale(
  self : SignalwindowhannPoint,
  s : Double,
) -> SignalwindowhannPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SignalwindowhannPoint::dot(
  self : SignalwindowhannPoint,
  other : SignalwindowhannPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SignalwindowhannPoint::cross(
  self : SignalwindowhannPoint,
  other : SignalwindowhannPoint,
) -> SignalwindowhannPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SignalwindowhannPoint::norm(self : SignalwindowhannPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SignalwindowhannPoint::normalize(
  self : SignalwindowhannPoint,
) -> SignalwindowhannPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalwindowhannPoint::negate(
  self : SignalwindowhannPoint,
) -> SignalwindowhannPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SignalwindowhannPoint::mid(
  self : SignalwindowhannPoint,
  other : SignalwindowhannPoint,
) -> SignalwindowhannPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SignalwindowhannPoint::lerp(
  self : SignalwindowhannPoint,
  other : SignalwindowhannPoint,
  t : Double,
) -> SignalwindowhannPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SignalwindowhannPoint::to_string(self : SignalwindowhannPoint) -> String {
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
pub(all) struct SignalwindowhannSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn signal_window_hann_make_series(
  vals : Array[Double],
  name : String,
) -> SignalwindowhannSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SignalwindowhannSeries::len(self : SignalwindowhannSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn SignalwindowhannSeries::sum(self : SignalwindowhannSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SignalwindowhannSeries::mean(self : SignalwindowhannSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SignalwindowhannSeries::min(self : SignalwindowhannSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SignalwindowhannSeries::max(self : SignalwindowhannSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SignalwindowhannSeries::range(self : SignalwindowhannSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SignalwindowhannSeries::variance(
  self : SignalwindowhannSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SignalwindowhannSeries::std(self : SignalwindowhannSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SignalwindowhannSeries::median(self : SignalwindowhannSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SignalwindowhannSeries::scale(
  self : SignalwindowhannSeries,
  f : Double,
) -> SignalwindowhannSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SignalwindowhannSeries::add(
  self : SignalwindowhannSeries,
  other : SignalwindowhannSeries,
) -> SignalwindowhannSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalwindowhannSeries::sub(
  self : SignalwindowhannSeries,
  other : SignalwindowhannSeries,
) -> SignalwindowhannSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalwindowhannSeries::normalize(
  self : SignalwindowhannSeries,
) -> SignalwindowhannSeries {
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
pub fn SignalwindowhannSeries::cumsum(
  self : SignalwindowhannSeries,
) -> SignalwindowhannSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SignalwindowhannSeries::to_string(
  self : SignalwindowhannSeries,
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
pub(all) struct SignalwindowhannMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn signal_window_hann_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SignalwindowhannMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn signal_window_hann_matrix_identity(n : Int32) -> SignalwindowhannMatrix {
  let m = signal_window_hann_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SignalwindowhannMatrix::get(
  self : SignalwindowhannMatrix,
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
pub fn SignalwindowhannMatrix::transpose(
  self : SignalwindowhannMatrix,
) -> SignalwindowhannMatrix {
  let result = signal_window_hann_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SignalwindowhannMatrix::add(
  self : SignalwindowhannMatrix,
  other : SignalwindowhannMatrix,
) -> SignalwindowhannMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = signal_window_hann_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SignalwindowhannMatrix::scale(
  self : SignalwindowhannMatrix,
  s : Double,
) -> SignalwindowhannMatrix {
  let result = signal_window_hann_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SignalwindowhannMatrix::multiply(
  self : SignalwindowhannMatrix,
  other : SignalwindowhannMatrix,
) -> SignalwindowhannMatrix {
  if self.cols != other.rows {
    return signal_window_hann_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = signal_window_hann_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SignalwindowhannMatrix::trace(self : SignalwindowhannMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SignalwindowhannMatrix::det(self : SignalwindowhannMatrix) -> Double {
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
pub fn SignalwindowhannMatrix::norm(self : SignalwindowhannMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn SignalwindowhannMatrix::to_string(
  self : SignalwindowhannMatrix,
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
pub(all) struct SignalwindowhannVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn signal_window_hann_make_vector(
  comps : Array[Double],
) -> SignalwindowhannVector {
  { comps, dim: comps.length(), }
}

///|
pub fn signal_window_hann_vector_zero(dim : Int32) -> SignalwindowhannVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SignalwindowhannVector::add(
  self : SignalwindowhannVector,
  other : SignalwindowhannVector,
) -> SignalwindowhannVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalwindowhannVector::sub(
  self : SignalwindowhannVector,
  other : SignalwindowhannVector,
) -> SignalwindowhannVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalwindowhannVector::scale(
  self : SignalwindowhannVector,
  s : Double,
) -> SignalwindowhannVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SignalwindowhannVector::dot(
  self : SignalwindowhannVector,
  other : SignalwindowhannVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SignalwindowhannVector::norm(self : SignalwindowhannVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SignalwindowhannVector::normalize(
  self : SignalwindowhannVector,
) -> SignalwindowhannVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalwindowhannVector::dist(
  self : SignalwindowhannVector,
  other : SignalwindowhannVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SignalwindowhannVector::to_string(
  self : SignalwindowhannVector,
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
pub(all) struct SignalwindowhannFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_frame_make(size : Int32) -> SignalwindowhannFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannFrame::len(self : SignalwindowhannFrame) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannFrame::get(
  self : SignalwindowhannFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannFrame::set(
  self : SignalwindowhannFrame,
  i : Int32,
  v : Double,
) -> SignalwindowhannFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannFrame::sum(self : SignalwindowhannFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannFrame::mean(self : SignalwindowhannFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannFrame::scale(
  self : SignalwindowhannFrame,
  f : Double,
) -> SignalwindowhannFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannFrame::add(
  self : SignalwindowhannFrame,
  other : SignalwindowhannFrame,
) -> SignalwindowhannFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannFrame::copy(
  self : SignalwindowhannFrame,
) -> SignalwindowhannFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannFrame::fill(
  self : SignalwindowhannFrame,
  v : Double,
) -> SignalwindowhannFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannFrame::min(self : SignalwindowhannFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannFrame::max(self : SignalwindowhannFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannFrame::to_string(self : SignalwindowhannFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_table_make(size : Int32) -> SignalwindowhannTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannTable::len(self : SignalwindowhannTable) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannTable::get(
  self : SignalwindowhannTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannTable::set(
  self : SignalwindowhannTable,
  i : Int32,
  v : Double,
) -> SignalwindowhannTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannTable::sum(self : SignalwindowhannTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannTable::mean(self : SignalwindowhannTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannTable::scale(
  self : SignalwindowhannTable,
  f : Double,
) -> SignalwindowhannTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannTable::add(
  self : SignalwindowhannTable,
  other : SignalwindowhannTable,
) -> SignalwindowhannTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannTable::copy(
  self : SignalwindowhannTable,
) -> SignalwindowhannTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannTable::fill(
  self : SignalwindowhannTable,
  v : Double,
) -> SignalwindowhannTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannTable::min(self : SignalwindowhannTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannTable::max(self : SignalwindowhannTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannTable::to_string(self : SignalwindowhannTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_graphn_make(size : Int32) -> SignalwindowhannGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannGraphN::len(self : SignalwindowhannGraphN) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannGraphN::get(
  self : SignalwindowhannGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannGraphN::set(
  self : SignalwindowhannGraphN,
  i : Int32,
  v : Double,
) -> SignalwindowhannGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannGraphN::sum(self : SignalwindowhannGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannGraphN::mean(self : SignalwindowhannGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannGraphN::scale(
  self : SignalwindowhannGraphN,
  f : Double,
) -> SignalwindowhannGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannGraphN::add(
  self : SignalwindowhannGraphN,
  other : SignalwindowhannGraphN,
) -> SignalwindowhannGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannGraphN::copy(
  self : SignalwindowhannGraphN,
) -> SignalwindowhannGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannGraphN::fill(
  self : SignalwindowhannGraphN,
  v : Double,
) -> SignalwindowhannGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannGraphN::min(self : SignalwindowhannGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannGraphN::max(self : SignalwindowhannGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannGraphN::to_string(
  self : SignalwindowhannGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_node_make(size : Int32) -> SignalwindowhannNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannNode::len(self : SignalwindowhannNode) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannNode::get(
  self : SignalwindowhannNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannNode::set(
  self : SignalwindowhannNode,
  i : Int32,
  v : Double,
) -> SignalwindowhannNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannNode::sum(self : SignalwindowhannNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannNode::mean(self : SignalwindowhannNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannNode::scale(
  self : SignalwindowhannNode,
  f : Double,
) -> SignalwindowhannNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannNode::add(
  self : SignalwindowhannNode,
  other : SignalwindowhannNode,
) -> SignalwindowhannNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannNode::copy(
  self : SignalwindowhannNode,
) -> SignalwindowhannNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannNode::fill(
  self : SignalwindowhannNode,
  v : Double,
) -> SignalwindowhannNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannNode::min(self : SignalwindowhannNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannNode::max(self : SignalwindowhannNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannNode::to_string(self : SignalwindowhannNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_edge_make(size : Int32) -> SignalwindowhannEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannEdge::len(self : SignalwindowhannEdge) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannEdge::get(
  self : SignalwindowhannEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannEdge::set(
  self : SignalwindowhannEdge,
  i : Int32,
  v : Double,
) -> SignalwindowhannEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannEdge::sum(self : SignalwindowhannEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannEdge::mean(self : SignalwindowhannEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannEdge::scale(
  self : SignalwindowhannEdge,
  f : Double,
) -> SignalwindowhannEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannEdge::add(
  self : SignalwindowhannEdge,
  other : SignalwindowhannEdge,
) -> SignalwindowhannEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannEdge::copy(
  self : SignalwindowhannEdge,
) -> SignalwindowhannEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannEdge::fill(
  self : SignalwindowhannEdge,
  v : Double,
) -> SignalwindowhannEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannEdge::min(self : SignalwindowhannEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannEdge::max(self : SignalwindowhannEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannEdge::to_string(self : SignalwindowhannEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_path_make(size : Int32) -> SignalwindowhannPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannPath::len(self : SignalwindowhannPath) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannPath::get(
  self : SignalwindowhannPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannPath::set(
  self : SignalwindowhannPath,
  i : Int32,
  v : Double,
) -> SignalwindowhannPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannPath::sum(self : SignalwindowhannPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannPath::mean(self : SignalwindowhannPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannPath::scale(
  self : SignalwindowhannPath,
  f : Double,
) -> SignalwindowhannPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannPath::add(
  self : SignalwindowhannPath,
  other : SignalwindowhannPath,
) -> SignalwindowhannPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannPath::copy(
  self : SignalwindowhannPath,
) -> SignalwindowhannPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannPath::fill(
  self : SignalwindowhannPath,
  v : Double,
) -> SignalwindowhannPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannPath::min(self : SignalwindowhannPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannPath::max(self : SignalwindowhannPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannPath::to_string(self : SignalwindowhannPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_cluster_make(size : Int32) -> SignalwindowhannCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannCluster::len(self : SignalwindowhannCluster) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannCluster::get(
  self : SignalwindowhannCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannCluster::set(
  self : SignalwindowhannCluster,
  i : Int32,
  v : Double,
) -> SignalwindowhannCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannCluster::sum(self : SignalwindowhannCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannCluster::mean(self : SignalwindowhannCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannCluster::scale(
  self : SignalwindowhannCluster,
  f : Double,
) -> SignalwindowhannCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannCluster::add(
  self : SignalwindowhannCluster,
  other : SignalwindowhannCluster,
) -> SignalwindowhannCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannCluster::copy(
  self : SignalwindowhannCluster,
) -> SignalwindowhannCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannCluster::fill(
  self : SignalwindowhannCluster,
  v : Double,
) -> SignalwindowhannCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannCluster::min(self : SignalwindowhannCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannCluster::max(self : SignalwindowhannCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannCluster::to_string(
  self : SignalwindowhannCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_model_make(size : Int32) -> SignalwindowhannModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannModel::len(self : SignalwindowhannModel) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannModel::get(
  self : SignalwindowhannModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannModel::set(
  self : SignalwindowhannModel,
  i : Int32,
  v : Double,
) -> SignalwindowhannModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannModel::sum(self : SignalwindowhannModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannModel::mean(self : SignalwindowhannModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannModel::scale(
  self : SignalwindowhannModel,
  f : Double,
) -> SignalwindowhannModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannModel::add(
  self : SignalwindowhannModel,
  other : SignalwindowhannModel,
) -> SignalwindowhannModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannModel::copy(
  self : SignalwindowhannModel,
) -> SignalwindowhannModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannModel::fill(
  self : SignalwindowhannModel,
  v : Double,
) -> SignalwindowhannModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannModel::min(self : SignalwindowhannModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannModel::max(self : SignalwindowhannModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannModel::to_string(self : SignalwindowhannModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_layer_make(size : Int32) -> SignalwindowhannLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannLayer::len(self : SignalwindowhannLayer) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannLayer::get(
  self : SignalwindowhannLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannLayer::set(
  self : SignalwindowhannLayer,
  i : Int32,
  v : Double,
) -> SignalwindowhannLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannLayer::sum(self : SignalwindowhannLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannLayer::mean(self : SignalwindowhannLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannLayer::scale(
  self : SignalwindowhannLayer,
  f : Double,
) -> SignalwindowhannLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannLayer::add(
  self : SignalwindowhannLayer,
  other : SignalwindowhannLayer,
) -> SignalwindowhannLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannLayer::copy(
  self : SignalwindowhannLayer,
) -> SignalwindowhannLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannLayer::fill(
  self : SignalwindowhannLayer,
  v : Double,
) -> SignalwindowhannLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannLayer::min(self : SignalwindowhannLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannLayer::max(self : SignalwindowhannLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannLayer::to_string(self : SignalwindowhannLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_buffer_make(size : Int32) -> SignalwindowhannBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannBuffer::len(self : SignalwindowhannBuffer) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannBuffer::get(
  self : SignalwindowhannBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannBuffer::set(
  self : SignalwindowhannBuffer,
  i : Int32,
  v : Double,
) -> SignalwindowhannBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannBuffer::sum(self : SignalwindowhannBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannBuffer::mean(self : SignalwindowhannBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannBuffer::scale(
  self : SignalwindowhannBuffer,
  f : Double,
) -> SignalwindowhannBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannBuffer::add(
  self : SignalwindowhannBuffer,
  other : SignalwindowhannBuffer,
) -> SignalwindowhannBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannBuffer::copy(
  self : SignalwindowhannBuffer,
) -> SignalwindowhannBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannBuffer::fill(
  self : SignalwindowhannBuffer,
  v : Double,
) -> SignalwindowhannBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannBuffer::min(self : SignalwindowhannBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannBuffer::max(self : SignalwindowhannBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannBuffer::to_string(
  self : SignalwindowhannBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_cursor_make(size : Int32) -> SignalwindowhannCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannCursor::len(self : SignalwindowhannCursor) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannCursor::get(
  self : SignalwindowhannCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannCursor::set(
  self : SignalwindowhannCursor,
  i : Int32,
  v : Double,
) -> SignalwindowhannCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannCursor::sum(self : SignalwindowhannCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannCursor::mean(self : SignalwindowhannCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannCursor::scale(
  self : SignalwindowhannCursor,
  f : Double,
) -> SignalwindowhannCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannCursor::add(
  self : SignalwindowhannCursor,
  other : SignalwindowhannCursor,
) -> SignalwindowhannCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannCursor::copy(
  self : SignalwindowhannCursor,
) -> SignalwindowhannCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannCursor::fill(
  self : SignalwindowhannCursor,
  v : Double,
) -> SignalwindowhannCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannCursor::min(self : SignalwindowhannCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannCursor::max(self : SignalwindowhannCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannCursor::to_string(
  self : SignalwindowhannCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_view_make(size : Int32) -> SignalwindowhannView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannView::len(self : SignalwindowhannView) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannView::get(
  self : SignalwindowhannView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannView::set(
  self : SignalwindowhannView,
  i : Int32,
  v : Double,
) -> SignalwindowhannView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannView::sum(self : SignalwindowhannView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannView::mean(self : SignalwindowhannView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannView::scale(
  self : SignalwindowhannView,
  f : Double,
) -> SignalwindowhannView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannView::add(
  self : SignalwindowhannView,
  other : SignalwindowhannView,
) -> SignalwindowhannView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannView::copy(
  self : SignalwindowhannView,
) -> SignalwindowhannView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannView::fill(
  self : SignalwindowhannView,
  v : Double,
) -> SignalwindowhannView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannView::min(self : SignalwindowhannView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannView::max(self : SignalwindowhannView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannView::to_string(self : SignalwindowhannView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_range_make(size : Int32) -> SignalwindowhannRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannRange::len(self : SignalwindowhannRange) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannRange::get(
  self : SignalwindowhannRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannRange::set(
  self : SignalwindowhannRange,
  i : Int32,
  v : Double,
) -> SignalwindowhannRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannRange::sum(self : SignalwindowhannRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannRange::mean(self : SignalwindowhannRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannRange::scale(
  self : SignalwindowhannRange,
  f : Double,
) -> SignalwindowhannRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannRange::add(
  self : SignalwindowhannRange,
  other : SignalwindowhannRange,
) -> SignalwindowhannRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannRange::copy(
  self : SignalwindowhannRange,
) -> SignalwindowhannRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannRange::fill(
  self : SignalwindowhannRange,
  v : Double,
) -> SignalwindowhannRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannRange::min(self : SignalwindowhannRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannRange::max(self : SignalwindowhannRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannRange::to_string(self : SignalwindowhannRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowhannSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_hann_slice_make(size : Int32) -> SignalwindowhannSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowhannSlice::len(self : SignalwindowhannSlice) -> Int32 {
  self.size
}

///|
pub fn SignalwindowhannSlice::get(
  self : SignalwindowhannSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowhannSlice::set(
  self : SignalwindowhannSlice,
  i : Int32,
  v : Double,
) -> SignalwindowhannSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannSlice::sum(self : SignalwindowhannSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowhannSlice::mean(self : SignalwindowhannSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowhannSlice::scale(
  self : SignalwindowhannSlice,
  f : Double,
) -> SignalwindowhannSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannSlice::add(
  self : SignalwindowhannSlice,
  other : SignalwindowhannSlice,
) -> SignalwindowhannSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowhannSlice::copy(
  self : SignalwindowhannSlice,
) -> SignalwindowhannSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannSlice::fill(
  self : SignalwindowhannSlice,
  v : Double,
) -> SignalwindowhannSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowhannSlice::min(self : SignalwindowhannSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowhannSlice::max(self : SignalwindowhannSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowhannSlice::to_string(self : SignalwindowhannSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
