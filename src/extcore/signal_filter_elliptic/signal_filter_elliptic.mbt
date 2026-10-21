///|
///===
/// extcore/signal_filter_elliptic
pub(all) struct SignalfilterellipticPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn signal_filter_elliptic_make_point(
  x : Double,
  y : Double,
) -> SignalfilterellipticPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn signal_filter_elliptic_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SignalfilterellipticPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SignalfilterellipticPoint::x(self : SignalfilterellipticPoint) -> Double {
  self.x
}

///|
pub fn SignalfilterellipticPoint::y(self : SignalfilterellipticPoint) -> Double {
  self.y
}

///|
pub fn SignalfilterellipticPoint::z(self : SignalfilterellipticPoint) -> Double {
  self.z
}

///|
pub fn SignalfilterellipticPoint::label(
  self : SignalfilterellipticPoint,
) -> Int32 {
  self.label
}

///|
pub fn SignalfilterellipticPoint::dist(
  self : SignalfilterellipticPoint,
  other : SignalfilterellipticPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SignalfilterellipticPoint::add(
  self : SignalfilterellipticPoint,
  other : SignalfilterellipticPoint,
) -> SignalfilterellipticPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SignalfilterellipticPoint::sub(
  self : SignalfilterellipticPoint,
  other : SignalfilterellipticPoint,
) -> SignalfilterellipticPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SignalfilterellipticPoint::scale(
  self : SignalfilterellipticPoint,
  s : Double,
) -> SignalfilterellipticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SignalfilterellipticPoint::dot(
  self : SignalfilterellipticPoint,
  other : SignalfilterellipticPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SignalfilterellipticPoint::cross(
  self : SignalfilterellipticPoint,
  other : SignalfilterellipticPoint,
) -> SignalfilterellipticPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SignalfilterellipticPoint::norm(
  self : SignalfilterellipticPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SignalfilterellipticPoint::normalize(
  self : SignalfilterellipticPoint,
) -> SignalfilterellipticPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalfilterellipticPoint::negate(
  self : SignalfilterellipticPoint,
) -> SignalfilterellipticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SignalfilterellipticPoint::mid(
  self : SignalfilterellipticPoint,
  other : SignalfilterellipticPoint,
) -> SignalfilterellipticPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SignalfilterellipticPoint::lerp(
  self : SignalfilterellipticPoint,
  other : SignalfilterellipticPoint,
  t : Double,
) -> SignalfilterellipticPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SignalfilterellipticPoint::to_string(
  self : SignalfilterellipticPoint,
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
pub(all) struct SignalfilterellipticSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn signal_filter_elliptic_make_series(
  vals : Array[Double],
  name : String,
) -> SignalfilterellipticSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SignalfilterellipticSeries::len(
  self : SignalfilterellipticSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn SignalfilterellipticSeries::sum(
  self : SignalfilterellipticSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SignalfilterellipticSeries::mean(
  self : SignalfilterellipticSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SignalfilterellipticSeries::min(
  self : SignalfilterellipticSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SignalfilterellipticSeries::max(
  self : SignalfilterellipticSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SignalfilterellipticSeries::range(
  self : SignalfilterellipticSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SignalfilterellipticSeries::variance(
  self : SignalfilterellipticSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SignalfilterellipticSeries::std(
  self : SignalfilterellipticSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SignalfilterellipticSeries::median(
  self : SignalfilterellipticSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SignalfilterellipticSeries::scale(
  self : SignalfilterellipticSeries,
  f : Double,
) -> SignalfilterellipticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SignalfilterellipticSeries::add(
  self : SignalfilterellipticSeries,
  other : SignalfilterellipticSeries,
) -> SignalfilterellipticSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalfilterellipticSeries::sub(
  self : SignalfilterellipticSeries,
  other : SignalfilterellipticSeries,
) -> SignalfilterellipticSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalfilterellipticSeries::normalize(
  self : SignalfilterellipticSeries,
) -> SignalfilterellipticSeries {
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
pub fn SignalfilterellipticSeries::cumsum(
  self : SignalfilterellipticSeries,
) -> SignalfilterellipticSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SignalfilterellipticSeries::to_string(
  self : SignalfilterellipticSeries,
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
pub(all) struct SignalfilterellipticMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn signal_filter_elliptic_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SignalfilterellipticMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn signal_filter_elliptic_matrix_identity(
  n : Int32,
) -> SignalfilterellipticMatrix {
  let m = signal_filter_elliptic_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SignalfilterellipticMatrix::get(
  self : SignalfilterellipticMatrix,
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
pub fn SignalfilterellipticMatrix::transpose(
  self : SignalfilterellipticMatrix,
) -> SignalfilterellipticMatrix {
  let result = signal_filter_elliptic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SignalfilterellipticMatrix::add(
  self : SignalfilterellipticMatrix,
  other : SignalfilterellipticMatrix,
) -> SignalfilterellipticMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = signal_filter_elliptic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SignalfilterellipticMatrix::scale(
  self : SignalfilterellipticMatrix,
  s : Double,
) -> SignalfilterellipticMatrix {
  let result = signal_filter_elliptic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SignalfilterellipticMatrix::multiply(
  self : SignalfilterellipticMatrix,
  other : SignalfilterellipticMatrix,
) -> SignalfilterellipticMatrix {
  if self.cols != other.rows {
    return signal_filter_elliptic_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = signal_filter_elliptic_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SignalfilterellipticMatrix::trace(
  self : SignalfilterellipticMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SignalfilterellipticMatrix::det(
  self : SignalfilterellipticMatrix,
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
pub fn SignalfilterellipticMatrix::norm(
  self : SignalfilterellipticMatrix,
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
pub fn SignalfilterellipticMatrix::to_string(
  self : SignalfilterellipticMatrix,
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
pub(all) struct SignalfilterellipticVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn signal_filter_elliptic_make_vector(
  comps : Array[Double],
) -> SignalfilterellipticVector {
  { comps, dim: comps.length(), }
}

///|
pub fn signal_filter_elliptic_vector_zero(
  dim : Int32,
) -> SignalfilterellipticVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SignalfilterellipticVector::add(
  self : SignalfilterellipticVector,
  other : SignalfilterellipticVector,
) -> SignalfilterellipticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalfilterellipticVector::sub(
  self : SignalfilterellipticVector,
  other : SignalfilterellipticVector,
) -> SignalfilterellipticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalfilterellipticVector::scale(
  self : SignalfilterellipticVector,
  s : Double,
) -> SignalfilterellipticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SignalfilterellipticVector::dot(
  self : SignalfilterellipticVector,
  other : SignalfilterellipticVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SignalfilterellipticVector::norm(
  self : SignalfilterellipticVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SignalfilterellipticVector::normalize(
  self : SignalfilterellipticVector,
) -> SignalfilterellipticVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalfilterellipticVector::dist(
  self : SignalfilterellipticVector,
  other : SignalfilterellipticVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SignalfilterellipticVector::to_string(
  self : SignalfilterellipticVector,
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
pub(all) struct SignalfilterellipticFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_frame_make(
  size : Int32,
) -> SignalfilterellipticFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticFrame::len(
  self : SignalfilterellipticFrame,
) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticFrame::get(
  self : SignalfilterellipticFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticFrame::set(
  self : SignalfilterellipticFrame,
  i : Int32,
  v : Double,
) -> SignalfilterellipticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticFrame::sum(
  self : SignalfilterellipticFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticFrame::mean(
  self : SignalfilterellipticFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticFrame::scale(
  self : SignalfilterellipticFrame,
  f : Double,
) -> SignalfilterellipticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticFrame::add(
  self : SignalfilterellipticFrame,
  other : SignalfilterellipticFrame,
) -> SignalfilterellipticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticFrame::copy(
  self : SignalfilterellipticFrame,
) -> SignalfilterellipticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticFrame::fill(
  self : SignalfilterellipticFrame,
  v : Double,
) -> SignalfilterellipticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticFrame::min(
  self : SignalfilterellipticFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticFrame::max(
  self : SignalfilterellipticFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticFrame::to_string(
  self : SignalfilterellipticFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_table_make(
  size : Int32,
) -> SignalfilterellipticTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticTable::len(
  self : SignalfilterellipticTable,
) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticTable::get(
  self : SignalfilterellipticTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticTable::set(
  self : SignalfilterellipticTable,
  i : Int32,
  v : Double,
) -> SignalfilterellipticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticTable::sum(
  self : SignalfilterellipticTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticTable::mean(
  self : SignalfilterellipticTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticTable::scale(
  self : SignalfilterellipticTable,
  f : Double,
) -> SignalfilterellipticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticTable::add(
  self : SignalfilterellipticTable,
  other : SignalfilterellipticTable,
) -> SignalfilterellipticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticTable::copy(
  self : SignalfilterellipticTable,
) -> SignalfilterellipticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticTable::fill(
  self : SignalfilterellipticTable,
  v : Double,
) -> SignalfilterellipticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticTable::min(
  self : SignalfilterellipticTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticTable::max(
  self : SignalfilterellipticTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticTable::to_string(
  self : SignalfilterellipticTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_graphn_make(
  size : Int32,
) -> SignalfilterellipticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticGraphN::len(
  self : SignalfilterellipticGraphN,
) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticGraphN::get(
  self : SignalfilterellipticGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticGraphN::set(
  self : SignalfilterellipticGraphN,
  i : Int32,
  v : Double,
) -> SignalfilterellipticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticGraphN::sum(
  self : SignalfilterellipticGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticGraphN::mean(
  self : SignalfilterellipticGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticGraphN::scale(
  self : SignalfilterellipticGraphN,
  f : Double,
) -> SignalfilterellipticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticGraphN::add(
  self : SignalfilterellipticGraphN,
  other : SignalfilterellipticGraphN,
) -> SignalfilterellipticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticGraphN::copy(
  self : SignalfilterellipticGraphN,
) -> SignalfilterellipticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticGraphN::fill(
  self : SignalfilterellipticGraphN,
  v : Double,
) -> SignalfilterellipticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticGraphN::min(
  self : SignalfilterellipticGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticGraphN::max(
  self : SignalfilterellipticGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticGraphN::to_string(
  self : SignalfilterellipticGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_node_make(
  size : Int32,
) -> SignalfilterellipticNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticNode::len(self : SignalfilterellipticNode) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticNode::get(
  self : SignalfilterellipticNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticNode::set(
  self : SignalfilterellipticNode,
  i : Int32,
  v : Double,
) -> SignalfilterellipticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticNode::sum(self : SignalfilterellipticNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticNode::mean(
  self : SignalfilterellipticNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticNode::scale(
  self : SignalfilterellipticNode,
  f : Double,
) -> SignalfilterellipticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticNode::add(
  self : SignalfilterellipticNode,
  other : SignalfilterellipticNode,
) -> SignalfilterellipticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticNode::copy(
  self : SignalfilterellipticNode,
) -> SignalfilterellipticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticNode::fill(
  self : SignalfilterellipticNode,
  v : Double,
) -> SignalfilterellipticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticNode::min(self : SignalfilterellipticNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticNode::max(self : SignalfilterellipticNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticNode::to_string(
  self : SignalfilterellipticNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_edge_make(
  size : Int32,
) -> SignalfilterellipticEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticEdge::len(self : SignalfilterellipticEdge) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticEdge::get(
  self : SignalfilterellipticEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticEdge::set(
  self : SignalfilterellipticEdge,
  i : Int32,
  v : Double,
) -> SignalfilterellipticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticEdge::sum(self : SignalfilterellipticEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticEdge::mean(
  self : SignalfilterellipticEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticEdge::scale(
  self : SignalfilterellipticEdge,
  f : Double,
) -> SignalfilterellipticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticEdge::add(
  self : SignalfilterellipticEdge,
  other : SignalfilterellipticEdge,
) -> SignalfilterellipticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticEdge::copy(
  self : SignalfilterellipticEdge,
) -> SignalfilterellipticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticEdge::fill(
  self : SignalfilterellipticEdge,
  v : Double,
) -> SignalfilterellipticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticEdge::min(self : SignalfilterellipticEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticEdge::max(self : SignalfilterellipticEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticEdge::to_string(
  self : SignalfilterellipticEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_path_make(
  size : Int32,
) -> SignalfilterellipticPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticPath::len(self : SignalfilterellipticPath) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticPath::get(
  self : SignalfilterellipticPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticPath::set(
  self : SignalfilterellipticPath,
  i : Int32,
  v : Double,
) -> SignalfilterellipticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticPath::sum(self : SignalfilterellipticPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticPath::mean(
  self : SignalfilterellipticPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticPath::scale(
  self : SignalfilterellipticPath,
  f : Double,
) -> SignalfilterellipticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticPath::add(
  self : SignalfilterellipticPath,
  other : SignalfilterellipticPath,
) -> SignalfilterellipticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticPath::copy(
  self : SignalfilterellipticPath,
) -> SignalfilterellipticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticPath::fill(
  self : SignalfilterellipticPath,
  v : Double,
) -> SignalfilterellipticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticPath::min(self : SignalfilterellipticPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticPath::max(self : SignalfilterellipticPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticPath::to_string(
  self : SignalfilterellipticPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_cluster_make(
  size : Int32,
) -> SignalfilterellipticCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticCluster::len(
  self : SignalfilterellipticCluster,
) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticCluster::get(
  self : SignalfilterellipticCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticCluster::set(
  self : SignalfilterellipticCluster,
  i : Int32,
  v : Double,
) -> SignalfilterellipticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticCluster::sum(
  self : SignalfilterellipticCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticCluster::mean(
  self : SignalfilterellipticCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticCluster::scale(
  self : SignalfilterellipticCluster,
  f : Double,
) -> SignalfilterellipticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticCluster::add(
  self : SignalfilterellipticCluster,
  other : SignalfilterellipticCluster,
) -> SignalfilterellipticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticCluster::copy(
  self : SignalfilterellipticCluster,
) -> SignalfilterellipticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticCluster::fill(
  self : SignalfilterellipticCluster,
  v : Double,
) -> SignalfilterellipticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticCluster::min(
  self : SignalfilterellipticCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticCluster::max(
  self : SignalfilterellipticCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticCluster::to_string(
  self : SignalfilterellipticCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_model_make(
  size : Int32,
) -> SignalfilterellipticModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticModel::len(
  self : SignalfilterellipticModel,
) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticModel::get(
  self : SignalfilterellipticModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticModel::set(
  self : SignalfilterellipticModel,
  i : Int32,
  v : Double,
) -> SignalfilterellipticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticModel::sum(
  self : SignalfilterellipticModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticModel::mean(
  self : SignalfilterellipticModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticModel::scale(
  self : SignalfilterellipticModel,
  f : Double,
) -> SignalfilterellipticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticModel::add(
  self : SignalfilterellipticModel,
  other : SignalfilterellipticModel,
) -> SignalfilterellipticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticModel::copy(
  self : SignalfilterellipticModel,
) -> SignalfilterellipticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticModel::fill(
  self : SignalfilterellipticModel,
  v : Double,
) -> SignalfilterellipticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticModel::min(
  self : SignalfilterellipticModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticModel::max(
  self : SignalfilterellipticModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticModel::to_string(
  self : SignalfilterellipticModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_layer_make(
  size : Int32,
) -> SignalfilterellipticLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticLayer::len(
  self : SignalfilterellipticLayer,
) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticLayer::get(
  self : SignalfilterellipticLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticLayer::set(
  self : SignalfilterellipticLayer,
  i : Int32,
  v : Double,
) -> SignalfilterellipticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticLayer::sum(
  self : SignalfilterellipticLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticLayer::mean(
  self : SignalfilterellipticLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticLayer::scale(
  self : SignalfilterellipticLayer,
  f : Double,
) -> SignalfilterellipticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticLayer::add(
  self : SignalfilterellipticLayer,
  other : SignalfilterellipticLayer,
) -> SignalfilterellipticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticLayer::copy(
  self : SignalfilterellipticLayer,
) -> SignalfilterellipticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticLayer::fill(
  self : SignalfilterellipticLayer,
  v : Double,
) -> SignalfilterellipticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticLayer::min(
  self : SignalfilterellipticLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticLayer::max(
  self : SignalfilterellipticLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticLayer::to_string(
  self : SignalfilterellipticLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_buffer_make(
  size : Int32,
) -> SignalfilterellipticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticBuffer::len(
  self : SignalfilterellipticBuffer,
) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticBuffer::get(
  self : SignalfilterellipticBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticBuffer::set(
  self : SignalfilterellipticBuffer,
  i : Int32,
  v : Double,
) -> SignalfilterellipticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticBuffer::sum(
  self : SignalfilterellipticBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticBuffer::mean(
  self : SignalfilterellipticBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticBuffer::scale(
  self : SignalfilterellipticBuffer,
  f : Double,
) -> SignalfilterellipticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticBuffer::add(
  self : SignalfilterellipticBuffer,
  other : SignalfilterellipticBuffer,
) -> SignalfilterellipticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticBuffer::copy(
  self : SignalfilterellipticBuffer,
) -> SignalfilterellipticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticBuffer::fill(
  self : SignalfilterellipticBuffer,
  v : Double,
) -> SignalfilterellipticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticBuffer::min(
  self : SignalfilterellipticBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticBuffer::max(
  self : SignalfilterellipticBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticBuffer::to_string(
  self : SignalfilterellipticBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_cursor_make(
  size : Int32,
) -> SignalfilterellipticCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticCursor::len(
  self : SignalfilterellipticCursor,
) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticCursor::get(
  self : SignalfilterellipticCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticCursor::set(
  self : SignalfilterellipticCursor,
  i : Int32,
  v : Double,
) -> SignalfilterellipticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticCursor::sum(
  self : SignalfilterellipticCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticCursor::mean(
  self : SignalfilterellipticCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticCursor::scale(
  self : SignalfilterellipticCursor,
  f : Double,
) -> SignalfilterellipticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticCursor::add(
  self : SignalfilterellipticCursor,
  other : SignalfilterellipticCursor,
) -> SignalfilterellipticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticCursor::copy(
  self : SignalfilterellipticCursor,
) -> SignalfilterellipticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticCursor::fill(
  self : SignalfilterellipticCursor,
  v : Double,
) -> SignalfilterellipticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticCursor::min(
  self : SignalfilterellipticCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticCursor::max(
  self : SignalfilterellipticCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticCursor::to_string(
  self : SignalfilterellipticCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_view_make(
  size : Int32,
) -> SignalfilterellipticView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticView::len(self : SignalfilterellipticView) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticView::get(
  self : SignalfilterellipticView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticView::set(
  self : SignalfilterellipticView,
  i : Int32,
  v : Double,
) -> SignalfilterellipticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticView::sum(self : SignalfilterellipticView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticView::mean(
  self : SignalfilterellipticView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticView::scale(
  self : SignalfilterellipticView,
  f : Double,
) -> SignalfilterellipticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticView::add(
  self : SignalfilterellipticView,
  other : SignalfilterellipticView,
) -> SignalfilterellipticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticView::copy(
  self : SignalfilterellipticView,
) -> SignalfilterellipticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticView::fill(
  self : SignalfilterellipticView,
  v : Double,
) -> SignalfilterellipticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticView::min(self : SignalfilterellipticView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticView::max(self : SignalfilterellipticView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticView::to_string(
  self : SignalfilterellipticView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_range_make(
  size : Int32,
) -> SignalfilterellipticRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticRange::len(
  self : SignalfilterellipticRange,
) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticRange::get(
  self : SignalfilterellipticRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticRange::set(
  self : SignalfilterellipticRange,
  i : Int32,
  v : Double,
) -> SignalfilterellipticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticRange::sum(
  self : SignalfilterellipticRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticRange::mean(
  self : SignalfilterellipticRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticRange::scale(
  self : SignalfilterellipticRange,
  f : Double,
) -> SignalfilterellipticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticRange::add(
  self : SignalfilterellipticRange,
  other : SignalfilterellipticRange,
) -> SignalfilterellipticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticRange::copy(
  self : SignalfilterellipticRange,
) -> SignalfilterellipticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticRange::fill(
  self : SignalfilterellipticRange,
  v : Double,
) -> SignalfilterellipticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticRange::min(
  self : SignalfilterellipticRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticRange::max(
  self : SignalfilterellipticRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticRange::to_string(
  self : SignalfilterellipticRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalfilterellipticSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_elliptic_slice_make(
  size : Int32,
) -> SignalfilterellipticSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalfilterellipticSlice::len(
  self : SignalfilterellipticSlice,
) -> Int32 {
  self.size
}

///|
pub fn SignalfilterellipticSlice::get(
  self : SignalfilterellipticSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalfilterellipticSlice::set(
  self : SignalfilterellipticSlice,
  i : Int32,
  v : Double,
) -> SignalfilterellipticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticSlice::sum(
  self : SignalfilterellipticSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalfilterellipticSlice::mean(
  self : SignalfilterellipticSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalfilterellipticSlice::scale(
  self : SignalfilterellipticSlice,
  f : Double,
) -> SignalfilterellipticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticSlice::add(
  self : SignalfilterellipticSlice,
  other : SignalfilterellipticSlice,
) -> SignalfilterellipticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalfilterellipticSlice::copy(
  self : SignalfilterellipticSlice,
) -> SignalfilterellipticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticSlice::fill(
  self : SignalfilterellipticSlice,
  v : Double,
) -> SignalfilterellipticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalfilterellipticSlice::min(
  self : SignalfilterellipticSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalfilterellipticSlice::max(
  self : SignalfilterellipticSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalfilterellipticSlice::to_string(
  self : SignalfilterellipticSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
