///|
///===
/// extcore/signal_window_rect
pub(all) struct SignalwindowrectPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn signal_window_rect_make_point(
  x : Double,
  y : Double,
) -> SignalwindowrectPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn signal_window_rect_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SignalwindowrectPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SignalwindowrectPoint::x(self : SignalwindowrectPoint) -> Double {
  self.x
}

///|
pub fn SignalwindowrectPoint::y(self : SignalwindowrectPoint) -> Double {
  self.y
}

///|
pub fn SignalwindowrectPoint::z(self : SignalwindowrectPoint) -> Double {
  self.z
}

///|
pub fn SignalwindowrectPoint::label(self : SignalwindowrectPoint) -> Int32 {
  self.label
}

///|
pub fn SignalwindowrectPoint::dist(
  self : SignalwindowrectPoint,
  other : SignalwindowrectPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SignalwindowrectPoint::add(
  self : SignalwindowrectPoint,
  other : SignalwindowrectPoint,
) -> SignalwindowrectPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SignalwindowrectPoint::sub(
  self : SignalwindowrectPoint,
  other : SignalwindowrectPoint,
) -> SignalwindowrectPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SignalwindowrectPoint::scale(
  self : SignalwindowrectPoint,
  s : Double,
) -> SignalwindowrectPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SignalwindowrectPoint::dot(
  self : SignalwindowrectPoint,
  other : SignalwindowrectPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SignalwindowrectPoint::cross(
  self : SignalwindowrectPoint,
  other : SignalwindowrectPoint,
) -> SignalwindowrectPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SignalwindowrectPoint::norm(self : SignalwindowrectPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SignalwindowrectPoint::normalize(
  self : SignalwindowrectPoint,
) -> SignalwindowrectPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalwindowrectPoint::negate(
  self : SignalwindowrectPoint,
) -> SignalwindowrectPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SignalwindowrectPoint::mid(
  self : SignalwindowrectPoint,
  other : SignalwindowrectPoint,
) -> SignalwindowrectPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SignalwindowrectPoint::lerp(
  self : SignalwindowrectPoint,
  other : SignalwindowrectPoint,
  t : Double,
) -> SignalwindowrectPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SignalwindowrectPoint::to_string(self : SignalwindowrectPoint) -> String {
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
pub(all) struct SignalwindowrectSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn signal_window_rect_make_series(
  vals : Array[Double],
  name : String,
) -> SignalwindowrectSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SignalwindowrectSeries::len(self : SignalwindowrectSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn SignalwindowrectSeries::sum(self : SignalwindowrectSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SignalwindowrectSeries::mean(self : SignalwindowrectSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SignalwindowrectSeries::min(self : SignalwindowrectSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SignalwindowrectSeries::max(self : SignalwindowrectSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SignalwindowrectSeries::range(self : SignalwindowrectSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SignalwindowrectSeries::variance(
  self : SignalwindowrectSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SignalwindowrectSeries::std(self : SignalwindowrectSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SignalwindowrectSeries::median(self : SignalwindowrectSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SignalwindowrectSeries::scale(
  self : SignalwindowrectSeries,
  f : Double,
) -> SignalwindowrectSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SignalwindowrectSeries::add(
  self : SignalwindowrectSeries,
  other : SignalwindowrectSeries,
) -> SignalwindowrectSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalwindowrectSeries::sub(
  self : SignalwindowrectSeries,
  other : SignalwindowrectSeries,
) -> SignalwindowrectSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalwindowrectSeries::normalize(
  self : SignalwindowrectSeries,
) -> SignalwindowrectSeries {
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
pub fn SignalwindowrectSeries::cumsum(
  self : SignalwindowrectSeries,
) -> SignalwindowrectSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SignalwindowrectSeries::to_string(
  self : SignalwindowrectSeries,
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
pub(all) struct SignalwindowrectMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn signal_window_rect_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SignalwindowrectMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn signal_window_rect_matrix_identity(n : Int32) -> SignalwindowrectMatrix {
  let m = signal_window_rect_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SignalwindowrectMatrix::get(
  self : SignalwindowrectMatrix,
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
pub fn SignalwindowrectMatrix::transpose(
  self : SignalwindowrectMatrix,
) -> SignalwindowrectMatrix {
  let result = signal_window_rect_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SignalwindowrectMatrix::add(
  self : SignalwindowrectMatrix,
  other : SignalwindowrectMatrix,
) -> SignalwindowrectMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = signal_window_rect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SignalwindowrectMatrix::scale(
  self : SignalwindowrectMatrix,
  s : Double,
) -> SignalwindowrectMatrix {
  let result = signal_window_rect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SignalwindowrectMatrix::multiply(
  self : SignalwindowrectMatrix,
  other : SignalwindowrectMatrix,
) -> SignalwindowrectMatrix {
  if self.cols != other.rows {
    return signal_window_rect_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = signal_window_rect_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SignalwindowrectMatrix::trace(self : SignalwindowrectMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SignalwindowrectMatrix::det(self : SignalwindowrectMatrix) -> Double {
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
pub fn SignalwindowrectMatrix::norm(self : SignalwindowrectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn SignalwindowrectMatrix::to_string(
  self : SignalwindowrectMatrix,
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
pub(all) struct SignalwindowrectVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn signal_window_rect_make_vector(
  comps : Array[Double],
) -> SignalwindowrectVector {
  { comps, dim: comps.length(), }
}

///|
pub fn signal_window_rect_vector_zero(dim : Int32) -> SignalwindowrectVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SignalwindowrectVector::add(
  self : SignalwindowrectVector,
  other : SignalwindowrectVector,
) -> SignalwindowrectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalwindowrectVector::sub(
  self : SignalwindowrectVector,
  other : SignalwindowrectVector,
) -> SignalwindowrectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalwindowrectVector::scale(
  self : SignalwindowrectVector,
  s : Double,
) -> SignalwindowrectVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SignalwindowrectVector::dot(
  self : SignalwindowrectVector,
  other : SignalwindowrectVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SignalwindowrectVector::norm(self : SignalwindowrectVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SignalwindowrectVector::normalize(
  self : SignalwindowrectVector,
) -> SignalwindowrectVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalwindowrectVector::dist(
  self : SignalwindowrectVector,
  other : SignalwindowrectVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SignalwindowrectVector::to_string(
  self : SignalwindowrectVector,
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
pub(all) struct SignalwindowrectFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_frame_make(size : Int32) -> SignalwindowrectFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectFrame::len(self : SignalwindowrectFrame) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectFrame::get(
  self : SignalwindowrectFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectFrame::set(
  self : SignalwindowrectFrame,
  i : Int32,
  v : Double,
) -> SignalwindowrectFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectFrame::sum(self : SignalwindowrectFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectFrame::mean(self : SignalwindowrectFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectFrame::scale(
  self : SignalwindowrectFrame,
  f : Double,
) -> SignalwindowrectFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectFrame::add(
  self : SignalwindowrectFrame,
  other : SignalwindowrectFrame,
) -> SignalwindowrectFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectFrame::copy(
  self : SignalwindowrectFrame,
) -> SignalwindowrectFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectFrame::fill(
  self : SignalwindowrectFrame,
  v : Double,
) -> SignalwindowrectFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectFrame::min(self : SignalwindowrectFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectFrame::max(self : SignalwindowrectFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectFrame::to_string(self : SignalwindowrectFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_table_make(size : Int32) -> SignalwindowrectTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectTable::len(self : SignalwindowrectTable) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectTable::get(
  self : SignalwindowrectTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectTable::set(
  self : SignalwindowrectTable,
  i : Int32,
  v : Double,
) -> SignalwindowrectTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectTable::sum(self : SignalwindowrectTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectTable::mean(self : SignalwindowrectTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectTable::scale(
  self : SignalwindowrectTable,
  f : Double,
) -> SignalwindowrectTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectTable::add(
  self : SignalwindowrectTable,
  other : SignalwindowrectTable,
) -> SignalwindowrectTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectTable::copy(
  self : SignalwindowrectTable,
) -> SignalwindowrectTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectTable::fill(
  self : SignalwindowrectTable,
  v : Double,
) -> SignalwindowrectTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectTable::min(self : SignalwindowrectTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectTable::max(self : SignalwindowrectTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectTable::to_string(self : SignalwindowrectTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_graphn_make(size : Int32) -> SignalwindowrectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectGraphN::len(self : SignalwindowrectGraphN) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectGraphN::get(
  self : SignalwindowrectGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectGraphN::set(
  self : SignalwindowrectGraphN,
  i : Int32,
  v : Double,
) -> SignalwindowrectGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectGraphN::sum(self : SignalwindowrectGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectGraphN::mean(self : SignalwindowrectGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectGraphN::scale(
  self : SignalwindowrectGraphN,
  f : Double,
) -> SignalwindowrectGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectGraphN::add(
  self : SignalwindowrectGraphN,
  other : SignalwindowrectGraphN,
) -> SignalwindowrectGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectGraphN::copy(
  self : SignalwindowrectGraphN,
) -> SignalwindowrectGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectGraphN::fill(
  self : SignalwindowrectGraphN,
  v : Double,
) -> SignalwindowrectGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectGraphN::min(self : SignalwindowrectGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectGraphN::max(self : SignalwindowrectGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectGraphN::to_string(
  self : SignalwindowrectGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_node_make(size : Int32) -> SignalwindowrectNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectNode::len(self : SignalwindowrectNode) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectNode::get(
  self : SignalwindowrectNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectNode::set(
  self : SignalwindowrectNode,
  i : Int32,
  v : Double,
) -> SignalwindowrectNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectNode::sum(self : SignalwindowrectNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectNode::mean(self : SignalwindowrectNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectNode::scale(
  self : SignalwindowrectNode,
  f : Double,
) -> SignalwindowrectNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectNode::add(
  self : SignalwindowrectNode,
  other : SignalwindowrectNode,
) -> SignalwindowrectNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectNode::copy(
  self : SignalwindowrectNode,
) -> SignalwindowrectNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectNode::fill(
  self : SignalwindowrectNode,
  v : Double,
) -> SignalwindowrectNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectNode::min(self : SignalwindowrectNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectNode::max(self : SignalwindowrectNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectNode::to_string(self : SignalwindowrectNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_edge_make(size : Int32) -> SignalwindowrectEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectEdge::len(self : SignalwindowrectEdge) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectEdge::get(
  self : SignalwindowrectEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectEdge::set(
  self : SignalwindowrectEdge,
  i : Int32,
  v : Double,
) -> SignalwindowrectEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectEdge::sum(self : SignalwindowrectEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectEdge::mean(self : SignalwindowrectEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectEdge::scale(
  self : SignalwindowrectEdge,
  f : Double,
) -> SignalwindowrectEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectEdge::add(
  self : SignalwindowrectEdge,
  other : SignalwindowrectEdge,
) -> SignalwindowrectEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectEdge::copy(
  self : SignalwindowrectEdge,
) -> SignalwindowrectEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectEdge::fill(
  self : SignalwindowrectEdge,
  v : Double,
) -> SignalwindowrectEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectEdge::min(self : SignalwindowrectEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectEdge::max(self : SignalwindowrectEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectEdge::to_string(self : SignalwindowrectEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_path_make(size : Int32) -> SignalwindowrectPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectPath::len(self : SignalwindowrectPath) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectPath::get(
  self : SignalwindowrectPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectPath::set(
  self : SignalwindowrectPath,
  i : Int32,
  v : Double,
) -> SignalwindowrectPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectPath::sum(self : SignalwindowrectPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectPath::mean(self : SignalwindowrectPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectPath::scale(
  self : SignalwindowrectPath,
  f : Double,
) -> SignalwindowrectPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectPath::add(
  self : SignalwindowrectPath,
  other : SignalwindowrectPath,
) -> SignalwindowrectPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectPath::copy(
  self : SignalwindowrectPath,
) -> SignalwindowrectPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectPath::fill(
  self : SignalwindowrectPath,
  v : Double,
) -> SignalwindowrectPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectPath::min(self : SignalwindowrectPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectPath::max(self : SignalwindowrectPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectPath::to_string(self : SignalwindowrectPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_cluster_make(size : Int32) -> SignalwindowrectCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectCluster::len(self : SignalwindowrectCluster) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectCluster::get(
  self : SignalwindowrectCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectCluster::set(
  self : SignalwindowrectCluster,
  i : Int32,
  v : Double,
) -> SignalwindowrectCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectCluster::sum(self : SignalwindowrectCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectCluster::mean(self : SignalwindowrectCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectCluster::scale(
  self : SignalwindowrectCluster,
  f : Double,
) -> SignalwindowrectCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectCluster::add(
  self : SignalwindowrectCluster,
  other : SignalwindowrectCluster,
) -> SignalwindowrectCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectCluster::copy(
  self : SignalwindowrectCluster,
) -> SignalwindowrectCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectCluster::fill(
  self : SignalwindowrectCluster,
  v : Double,
) -> SignalwindowrectCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectCluster::min(self : SignalwindowrectCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectCluster::max(self : SignalwindowrectCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectCluster::to_string(
  self : SignalwindowrectCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_model_make(size : Int32) -> SignalwindowrectModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectModel::len(self : SignalwindowrectModel) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectModel::get(
  self : SignalwindowrectModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectModel::set(
  self : SignalwindowrectModel,
  i : Int32,
  v : Double,
) -> SignalwindowrectModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectModel::sum(self : SignalwindowrectModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectModel::mean(self : SignalwindowrectModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectModel::scale(
  self : SignalwindowrectModel,
  f : Double,
) -> SignalwindowrectModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectModel::add(
  self : SignalwindowrectModel,
  other : SignalwindowrectModel,
) -> SignalwindowrectModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectModel::copy(
  self : SignalwindowrectModel,
) -> SignalwindowrectModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectModel::fill(
  self : SignalwindowrectModel,
  v : Double,
) -> SignalwindowrectModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectModel::min(self : SignalwindowrectModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectModel::max(self : SignalwindowrectModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectModel::to_string(self : SignalwindowrectModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_layer_make(size : Int32) -> SignalwindowrectLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectLayer::len(self : SignalwindowrectLayer) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectLayer::get(
  self : SignalwindowrectLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectLayer::set(
  self : SignalwindowrectLayer,
  i : Int32,
  v : Double,
) -> SignalwindowrectLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectLayer::sum(self : SignalwindowrectLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectLayer::mean(self : SignalwindowrectLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectLayer::scale(
  self : SignalwindowrectLayer,
  f : Double,
) -> SignalwindowrectLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectLayer::add(
  self : SignalwindowrectLayer,
  other : SignalwindowrectLayer,
) -> SignalwindowrectLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectLayer::copy(
  self : SignalwindowrectLayer,
) -> SignalwindowrectLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectLayer::fill(
  self : SignalwindowrectLayer,
  v : Double,
) -> SignalwindowrectLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectLayer::min(self : SignalwindowrectLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectLayer::max(self : SignalwindowrectLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectLayer::to_string(self : SignalwindowrectLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_buffer_make(size : Int32) -> SignalwindowrectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectBuffer::len(self : SignalwindowrectBuffer) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectBuffer::get(
  self : SignalwindowrectBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectBuffer::set(
  self : SignalwindowrectBuffer,
  i : Int32,
  v : Double,
) -> SignalwindowrectBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectBuffer::sum(self : SignalwindowrectBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectBuffer::mean(self : SignalwindowrectBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectBuffer::scale(
  self : SignalwindowrectBuffer,
  f : Double,
) -> SignalwindowrectBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectBuffer::add(
  self : SignalwindowrectBuffer,
  other : SignalwindowrectBuffer,
) -> SignalwindowrectBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectBuffer::copy(
  self : SignalwindowrectBuffer,
) -> SignalwindowrectBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectBuffer::fill(
  self : SignalwindowrectBuffer,
  v : Double,
) -> SignalwindowrectBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectBuffer::min(self : SignalwindowrectBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectBuffer::max(self : SignalwindowrectBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectBuffer::to_string(
  self : SignalwindowrectBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_cursor_make(size : Int32) -> SignalwindowrectCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectCursor::len(self : SignalwindowrectCursor) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectCursor::get(
  self : SignalwindowrectCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectCursor::set(
  self : SignalwindowrectCursor,
  i : Int32,
  v : Double,
) -> SignalwindowrectCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectCursor::sum(self : SignalwindowrectCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectCursor::mean(self : SignalwindowrectCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectCursor::scale(
  self : SignalwindowrectCursor,
  f : Double,
) -> SignalwindowrectCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectCursor::add(
  self : SignalwindowrectCursor,
  other : SignalwindowrectCursor,
) -> SignalwindowrectCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectCursor::copy(
  self : SignalwindowrectCursor,
) -> SignalwindowrectCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectCursor::fill(
  self : SignalwindowrectCursor,
  v : Double,
) -> SignalwindowrectCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectCursor::min(self : SignalwindowrectCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectCursor::max(self : SignalwindowrectCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectCursor::to_string(
  self : SignalwindowrectCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_view_make(size : Int32) -> SignalwindowrectView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectView::len(self : SignalwindowrectView) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectView::get(
  self : SignalwindowrectView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectView::set(
  self : SignalwindowrectView,
  i : Int32,
  v : Double,
) -> SignalwindowrectView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectView::sum(self : SignalwindowrectView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectView::mean(self : SignalwindowrectView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectView::scale(
  self : SignalwindowrectView,
  f : Double,
) -> SignalwindowrectView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectView::add(
  self : SignalwindowrectView,
  other : SignalwindowrectView,
) -> SignalwindowrectView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectView::copy(
  self : SignalwindowrectView,
) -> SignalwindowrectView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectView::fill(
  self : SignalwindowrectView,
  v : Double,
) -> SignalwindowrectView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectView::min(self : SignalwindowrectView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectView::max(self : SignalwindowrectView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectView::to_string(self : SignalwindowrectView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_range_make(size : Int32) -> SignalwindowrectRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectRange::len(self : SignalwindowrectRange) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectRange::get(
  self : SignalwindowrectRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectRange::set(
  self : SignalwindowrectRange,
  i : Int32,
  v : Double,
) -> SignalwindowrectRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectRange::sum(self : SignalwindowrectRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectRange::mean(self : SignalwindowrectRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectRange::scale(
  self : SignalwindowrectRange,
  f : Double,
) -> SignalwindowrectRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectRange::add(
  self : SignalwindowrectRange,
  other : SignalwindowrectRange,
) -> SignalwindowrectRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectRange::copy(
  self : SignalwindowrectRange,
) -> SignalwindowrectRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectRange::fill(
  self : SignalwindowrectRange,
  v : Double,
) -> SignalwindowrectRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectRange::min(self : SignalwindowrectRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectRange::max(self : SignalwindowrectRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectRange::to_string(self : SignalwindowrectRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalwindowrectSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_window_rect_slice_make(size : Int32) -> SignalwindowrectSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalwindowrectSlice::len(self : SignalwindowrectSlice) -> Int32 {
  self.size
}

///|
pub fn SignalwindowrectSlice::get(
  self : SignalwindowrectSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalwindowrectSlice::set(
  self : SignalwindowrectSlice,
  i : Int32,
  v : Double,
) -> SignalwindowrectSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectSlice::sum(self : SignalwindowrectSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalwindowrectSlice::mean(self : SignalwindowrectSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalwindowrectSlice::scale(
  self : SignalwindowrectSlice,
  f : Double,
) -> SignalwindowrectSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectSlice::add(
  self : SignalwindowrectSlice,
  other : SignalwindowrectSlice,
) -> SignalwindowrectSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalwindowrectSlice::copy(
  self : SignalwindowrectSlice,
) -> SignalwindowrectSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectSlice::fill(
  self : SignalwindowrectSlice,
  v : Double,
) -> SignalwindowrectSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalwindowrectSlice::min(self : SignalwindowrectSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalwindowrectSlice::max(self : SignalwindowrectSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalwindowrectSlice::to_string(self : SignalwindowrectSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
