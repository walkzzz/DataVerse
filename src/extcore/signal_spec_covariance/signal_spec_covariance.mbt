///|
///===
/// extcore/signal_spec_covariance
pub(all) struct SignalspeccovariancePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn signal_spec_covariance_make_point(
  x : Double,
  y : Double,
) -> SignalspeccovariancePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn signal_spec_covariance_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SignalspeccovariancePoint {
  { x, y, z, label: 0, }
}

///|
pub fn SignalspeccovariancePoint::x(self : SignalspeccovariancePoint) -> Double {
  self.x
}

///|
pub fn SignalspeccovariancePoint::y(self : SignalspeccovariancePoint) -> Double {
  self.y
}

///|
pub fn SignalspeccovariancePoint::z(self : SignalspeccovariancePoint) -> Double {
  self.z
}

///|
pub fn SignalspeccovariancePoint::label(
  self : SignalspeccovariancePoint,
) -> Int32 {
  self.label
}

///|
pub fn SignalspeccovariancePoint::dist(
  self : SignalspeccovariancePoint,
  other : SignalspeccovariancePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SignalspeccovariancePoint::add(
  self : SignalspeccovariancePoint,
  other : SignalspeccovariancePoint,
) -> SignalspeccovariancePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SignalspeccovariancePoint::sub(
  self : SignalspeccovariancePoint,
  other : SignalspeccovariancePoint,
) -> SignalspeccovariancePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SignalspeccovariancePoint::scale(
  self : SignalspeccovariancePoint,
  s : Double,
) -> SignalspeccovariancePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SignalspeccovariancePoint::dot(
  self : SignalspeccovariancePoint,
  other : SignalspeccovariancePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SignalspeccovariancePoint::cross(
  self : SignalspeccovariancePoint,
  other : SignalspeccovariancePoint,
) -> SignalspeccovariancePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SignalspeccovariancePoint::norm(
  self : SignalspeccovariancePoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SignalspeccovariancePoint::normalize(
  self : SignalspeccovariancePoint,
) -> SignalspeccovariancePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalspeccovariancePoint::negate(
  self : SignalspeccovariancePoint,
) -> SignalspeccovariancePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SignalspeccovariancePoint::mid(
  self : SignalspeccovariancePoint,
  other : SignalspeccovariancePoint,
) -> SignalspeccovariancePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SignalspeccovariancePoint::lerp(
  self : SignalspeccovariancePoint,
  other : SignalspeccovariancePoint,
  t : Double,
) -> SignalspeccovariancePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SignalspeccovariancePoint::to_string(
  self : SignalspeccovariancePoint,
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
pub(all) struct SignalspeccovarianceSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn signal_spec_covariance_make_series(
  vals : Array[Double],
  name : String,
) -> SignalspeccovarianceSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SignalspeccovarianceSeries::len(
  self : SignalspeccovarianceSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn SignalspeccovarianceSeries::sum(
  self : SignalspeccovarianceSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SignalspeccovarianceSeries::mean(
  self : SignalspeccovarianceSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SignalspeccovarianceSeries::min(
  self : SignalspeccovarianceSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SignalspeccovarianceSeries::max(
  self : SignalspeccovarianceSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SignalspeccovarianceSeries::range(
  self : SignalspeccovarianceSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SignalspeccovarianceSeries::variance(
  self : SignalspeccovarianceSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SignalspeccovarianceSeries::std(
  self : SignalspeccovarianceSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SignalspeccovarianceSeries::median(
  self : SignalspeccovarianceSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SignalspeccovarianceSeries::scale(
  self : SignalspeccovarianceSeries,
  f : Double,
) -> SignalspeccovarianceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SignalspeccovarianceSeries::add(
  self : SignalspeccovarianceSeries,
  other : SignalspeccovarianceSeries,
) -> SignalspeccovarianceSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalspeccovarianceSeries::sub(
  self : SignalspeccovarianceSeries,
  other : SignalspeccovarianceSeries,
) -> SignalspeccovarianceSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SignalspeccovarianceSeries::normalize(
  self : SignalspeccovarianceSeries,
) -> SignalspeccovarianceSeries {
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
pub fn SignalspeccovarianceSeries::cumsum(
  self : SignalspeccovarianceSeries,
) -> SignalspeccovarianceSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SignalspeccovarianceSeries::to_string(
  self : SignalspeccovarianceSeries,
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
pub(all) struct SignalspeccovarianceMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn signal_spec_covariance_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SignalspeccovarianceMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn signal_spec_covariance_matrix_identity(
  n : Int32,
) -> SignalspeccovarianceMatrix {
  let m = signal_spec_covariance_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SignalspeccovarianceMatrix::get(
  self : SignalspeccovarianceMatrix,
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
pub fn SignalspeccovarianceMatrix::transpose(
  self : SignalspeccovarianceMatrix,
) -> SignalspeccovarianceMatrix {
  let result = signal_spec_covariance_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SignalspeccovarianceMatrix::add(
  self : SignalspeccovarianceMatrix,
  other : SignalspeccovarianceMatrix,
) -> SignalspeccovarianceMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = signal_spec_covariance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SignalspeccovarianceMatrix::scale(
  self : SignalspeccovarianceMatrix,
  s : Double,
) -> SignalspeccovarianceMatrix {
  let result = signal_spec_covariance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SignalspeccovarianceMatrix::multiply(
  self : SignalspeccovarianceMatrix,
  other : SignalspeccovarianceMatrix,
) -> SignalspeccovarianceMatrix {
  if self.cols != other.rows {
    return signal_spec_covariance_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = signal_spec_covariance_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SignalspeccovarianceMatrix::trace(
  self : SignalspeccovarianceMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SignalspeccovarianceMatrix::det(
  self : SignalspeccovarianceMatrix,
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
pub fn SignalspeccovarianceMatrix::norm(
  self : SignalspeccovarianceMatrix,
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
pub fn SignalspeccovarianceMatrix::to_string(
  self : SignalspeccovarianceMatrix,
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
pub(all) struct SignalspeccovarianceVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn signal_spec_covariance_make_vector(
  comps : Array[Double],
) -> SignalspeccovarianceVector {
  { comps, dim: comps.length(), }
}

///|
pub fn signal_spec_covariance_vector_zero(
  dim : Int32,
) -> SignalspeccovarianceVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SignalspeccovarianceVector::add(
  self : SignalspeccovarianceVector,
  other : SignalspeccovarianceVector,
) -> SignalspeccovarianceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalspeccovarianceVector::sub(
  self : SignalspeccovarianceVector,
  other : SignalspeccovarianceVector,
) -> SignalspeccovarianceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SignalspeccovarianceVector::scale(
  self : SignalspeccovarianceVector,
  s : Double,
) -> SignalspeccovarianceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SignalspeccovarianceVector::dot(
  self : SignalspeccovarianceVector,
  other : SignalspeccovarianceVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SignalspeccovarianceVector::norm(
  self : SignalspeccovarianceVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SignalspeccovarianceVector::normalize(
  self : SignalspeccovarianceVector,
) -> SignalspeccovarianceVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SignalspeccovarianceVector::dist(
  self : SignalspeccovarianceVector,
  other : SignalspeccovarianceVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SignalspeccovarianceVector::to_string(
  self : SignalspeccovarianceVector,
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
pub(all) struct SignalspeccovarianceFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_frame_make(
  size : Int32,
) -> SignalspeccovarianceFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceFrame::len(
  self : SignalspeccovarianceFrame,
) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceFrame::get(
  self : SignalspeccovarianceFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceFrame::set(
  self : SignalspeccovarianceFrame,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceFrame::sum(
  self : SignalspeccovarianceFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceFrame::mean(
  self : SignalspeccovarianceFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceFrame::scale(
  self : SignalspeccovarianceFrame,
  f : Double,
) -> SignalspeccovarianceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceFrame::add(
  self : SignalspeccovarianceFrame,
  other : SignalspeccovarianceFrame,
) -> SignalspeccovarianceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceFrame::copy(
  self : SignalspeccovarianceFrame,
) -> SignalspeccovarianceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceFrame::fill(
  self : SignalspeccovarianceFrame,
  v : Double,
) -> SignalspeccovarianceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceFrame::min(
  self : SignalspeccovarianceFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceFrame::max(
  self : SignalspeccovarianceFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceFrame::to_string(
  self : SignalspeccovarianceFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_table_make(
  size : Int32,
) -> SignalspeccovarianceTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceTable::len(
  self : SignalspeccovarianceTable,
) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceTable::get(
  self : SignalspeccovarianceTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceTable::set(
  self : SignalspeccovarianceTable,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceTable::sum(
  self : SignalspeccovarianceTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceTable::mean(
  self : SignalspeccovarianceTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceTable::scale(
  self : SignalspeccovarianceTable,
  f : Double,
) -> SignalspeccovarianceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceTable::add(
  self : SignalspeccovarianceTable,
  other : SignalspeccovarianceTable,
) -> SignalspeccovarianceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceTable::copy(
  self : SignalspeccovarianceTable,
) -> SignalspeccovarianceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceTable::fill(
  self : SignalspeccovarianceTable,
  v : Double,
) -> SignalspeccovarianceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceTable::min(
  self : SignalspeccovarianceTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceTable::max(
  self : SignalspeccovarianceTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceTable::to_string(
  self : SignalspeccovarianceTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_graphn_make(
  size : Int32,
) -> SignalspeccovarianceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceGraphN::len(
  self : SignalspeccovarianceGraphN,
) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceGraphN::get(
  self : SignalspeccovarianceGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceGraphN::set(
  self : SignalspeccovarianceGraphN,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceGraphN::sum(
  self : SignalspeccovarianceGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceGraphN::mean(
  self : SignalspeccovarianceGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceGraphN::scale(
  self : SignalspeccovarianceGraphN,
  f : Double,
) -> SignalspeccovarianceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceGraphN::add(
  self : SignalspeccovarianceGraphN,
  other : SignalspeccovarianceGraphN,
) -> SignalspeccovarianceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceGraphN::copy(
  self : SignalspeccovarianceGraphN,
) -> SignalspeccovarianceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceGraphN::fill(
  self : SignalspeccovarianceGraphN,
  v : Double,
) -> SignalspeccovarianceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceGraphN::min(
  self : SignalspeccovarianceGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceGraphN::max(
  self : SignalspeccovarianceGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceGraphN::to_string(
  self : SignalspeccovarianceGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_node_make(
  size : Int32,
) -> SignalspeccovarianceNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceNode::len(self : SignalspeccovarianceNode) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceNode::get(
  self : SignalspeccovarianceNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceNode::set(
  self : SignalspeccovarianceNode,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceNode::sum(self : SignalspeccovarianceNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceNode::mean(
  self : SignalspeccovarianceNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceNode::scale(
  self : SignalspeccovarianceNode,
  f : Double,
) -> SignalspeccovarianceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceNode::add(
  self : SignalspeccovarianceNode,
  other : SignalspeccovarianceNode,
) -> SignalspeccovarianceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceNode::copy(
  self : SignalspeccovarianceNode,
) -> SignalspeccovarianceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceNode::fill(
  self : SignalspeccovarianceNode,
  v : Double,
) -> SignalspeccovarianceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceNode::min(self : SignalspeccovarianceNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceNode::max(self : SignalspeccovarianceNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceNode::to_string(
  self : SignalspeccovarianceNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_edge_make(
  size : Int32,
) -> SignalspeccovarianceEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceEdge::len(self : SignalspeccovarianceEdge) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceEdge::get(
  self : SignalspeccovarianceEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceEdge::set(
  self : SignalspeccovarianceEdge,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceEdge::sum(self : SignalspeccovarianceEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceEdge::mean(
  self : SignalspeccovarianceEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceEdge::scale(
  self : SignalspeccovarianceEdge,
  f : Double,
) -> SignalspeccovarianceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceEdge::add(
  self : SignalspeccovarianceEdge,
  other : SignalspeccovarianceEdge,
) -> SignalspeccovarianceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceEdge::copy(
  self : SignalspeccovarianceEdge,
) -> SignalspeccovarianceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceEdge::fill(
  self : SignalspeccovarianceEdge,
  v : Double,
) -> SignalspeccovarianceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceEdge::min(self : SignalspeccovarianceEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceEdge::max(self : SignalspeccovarianceEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceEdge::to_string(
  self : SignalspeccovarianceEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovariancePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_path_make(
  size : Int32,
) -> SignalspeccovariancePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovariancePath::len(self : SignalspeccovariancePath) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovariancePath::get(
  self : SignalspeccovariancePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovariancePath::set(
  self : SignalspeccovariancePath,
  i : Int32,
  v : Double,
) -> SignalspeccovariancePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovariancePath::sum(self : SignalspeccovariancePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovariancePath::mean(
  self : SignalspeccovariancePath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovariancePath::scale(
  self : SignalspeccovariancePath,
  f : Double,
) -> SignalspeccovariancePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovariancePath::add(
  self : SignalspeccovariancePath,
  other : SignalspeccovariancePath,
) -> SignalspeccovariancePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovariancePath::copy(
  self : SignalspeccovariancePath,
) -> SignalspeccovariancePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovariancePath::fill(
  self : SignalspeccovariancePath,
  v : Double,
) -> SignalspeccovariancePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovariancePath::min(self : SignalspeccovariancePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovariancePath::max(self : SignalspeccovariancePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovariancePath::to_string(
  self : SignalspeccovariancePath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_cluster_make(
  size : Int32,
) -> SignalspeccovarianceCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceCluster::len(
  self : SignalspeccovarianceCluster,
) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceCluster::get(
  self : SignalspeccovarianceCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceCluster::set(
  self : SignalspeccovarianceCluster,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceCluster::sum(
  self : SignalspeccovarianceCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceCluster::mean(
  self : SignalspeccovarianceCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceCluster::scale(
  self : SignalspeccovarianceCluster,
  f : Double,
) -> SignalspeccovarianceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceCluster::add(
  self : SignalspeccovarianceCluster,
  other : SignalspeccovarianceCluster,
) -> SignalspeccovarianceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceCluster::copy(
  self : SignalspeccovarianceCluster,
) -> SignalspeccovarianceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceCluster::fill(
  self : SignalspeccovarianceCluster,
  v : Double,
) -> SignalspeccovarianceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceCluster::min(
  self : SignalspeccovarianceCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceCluster::max(
  self : SignalspeccovarianceCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceCluster::to_string(
  self : SignalspeccovarianceCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_model_make(
  size : Int32,
) -> SignalspeccovarianceModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceModel::len(
  self : SignalspeccovarianceModel,
) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceModel::get(
  self : SignalspeccovarianceModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceModel::set(
  self : SignalspeccovarianceModel,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceModel::sum(
  self : SignalspeccovarianceModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceModel::mean(
  self : SignalspeccovarianceModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceModel::scale(
  self : SignalspeccovarianceModel,
  f : Double,
) -> SignalspeccovarianceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceModel::add(
  self : SignalspeccovarianceModel,
  other : SignalspeccovarianceModel,
) -> SignalspeccovarianceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceModel::copy(
  self : SignalspeccovarianceModel,
) -> SignalspeccovarianceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceModel::fill(
  self : SignalspeccovarianceModel,
  v : Double,
) -> SignalspeccovarianceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceModel::min(
  self : SignalspeccovarianceModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceModel::max(
  self : SignalspeccovarianceModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceModel::to_string(
  self : SignalspeccovarianceModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_layer_make(
  size : Int32,
) -> SignalspeccovarianceLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceLayer::len(
  self : SignalspeccovarianceLayer,
) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceLayer::get(
  self : SignalspeccovarianceLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceLayer::set(
  self : SignalspeccovarianceLayer,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceLayer::sum(
  self : SignalspeccovarianceLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceLayer::mean(
  self : SignalspeccovarianceLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceLayer::scale(
  self : SignalspeccovarianceLayer,
  f : Double,
) -> SignalspeccovarianceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceLayer::add(
  self : SignalspeccovarianceLayer,
  other : SignalspeccovarianceLayer,
) -> SignalspeccovarianceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceLayer::copy(
  self : SignalspeccovarianceLayer,
) -> SignalspeccovarianceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceLayer::fill(
  self : SignalspeccovarianceLayer,
  v : Double,
) -> SignalspeccovarianceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceLayer::min(
  self : SignalspeccovarianceLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceLayer::max(
  self : SignalspeccovarianceLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceLayer::to_string(
  self : SignalspeccovarianceLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_buffer_make(
  size : Int32,
) -> SignalspeccovarianceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceBuffer::len(
  self : SignalspeccovarianceBuffer,
) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceBuffer::get(
  self : SignalspeccovarianceBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceBuffer::set(
  self : SignalspeccovarianceBuffer,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceBuffer::sum(
  self : SignalspeccovarianceBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceBuffer::mean(
  self : SignalspeccovarianceBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceBuffer::scale(
  self : SignalspeccovarianceBuffer,
  f : Double,
) -> SignalspeccovarianceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceBuffer::add(
  self : SignalspeccovarianceBuffer,
  other : SignalspeccovarianceBuffer,
) -> SignalspeccovarianceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceBuffer::copy(
  self : SignalspeccovarianceBuffer,
) -> SignalspeccovarianceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceBuffer::fill(
  self : SignalspeccovarianceBuffer,
  v : Double,
) -> SignalspeccovarianceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceBuffer::min(
  self : SignalspeccovarianceBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceBuffer::max(
  self : SignalspeccovarianceBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceBuffer::to_string(
  self : SignalspeccovarianceBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_cursor_make(
  size : Int32,
) -> SignalspeccovarianceCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceCursor::len(
  self : SignalspeccovarianceCursor,
) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceCursor::get(
  self : SignalspeccovarianceCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceCursor::set(
  self : SignalspeccovarianceCursor,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceCursor::sum(
  self : SignalspeccovarianceCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceCursor::mean(
  self : SignalspeccovarianceCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceCursor::scale(
  self : SignalspeccovarianceCursor,
  f : Double,
) -> SignalspeccovarianceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceCursor::add(
  self : SignalspeccovarianceCursor,
  other : SignalspeccovarianceCursor,
) -> SignalspeccovarianceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceCursor::copy(
  self : SignalspeccovarianceCursor,
) -> SignalspeccovarianceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceCursor::fill(
  self : SignalspeccovarianceCursor,
  v : Double,
) -> SignalspeccovarianceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceCursor::min(
  self : SignalspeccovarianceCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceCursor::max(
  self : SignalspeccovarianceCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceCursor::to_string(
  self : SignalspeccovarianceCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_view_make(
  size : Int32,
) -> SignalspeccovarianceView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceView::len(self : SignalspeccovarianceView) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceView::get(
  self : SignalspeccovarianceView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceView::set(
  self : SignalspeccovarianceView,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceView::sum(self : SignalspeccovarianceView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceView::mean(
  self : SignalspeccovarianceView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceView::scale(
  self : SignalspeccovarianceView,
  f : Double,
) -> SignalspeccovarianceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceView::add(
  self : SignalspeccovarianceView,
  other : SignalspeccovarianceView,
) -> SignalspeccovarianceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceView::copy(
  self : SignalspeccovarianceView,
) -> SignalspeccovarianceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceView::fill(
  self : SignalspeccovarianceView,
  v : Double,
) -> SignalspeccovarianceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceView::min(self : SignalspeccovarianceView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceView::max(self : SignalspeccovarianceView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceView::to_string(
  self : SignalspeccovarianceView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_range_make(
  size : Int32,
) -> SignalspeccovarianceRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceRange::len(
  self : SignalspeccovarianceRange,
) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceRange::get(
  self : SignalspeccovarianceRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceRange::set(
  self : SignalspeccovarianceRange,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceRange::sum(
  self : SignalspeccovarianceRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceRange::mean(
  self : SignalspeccovarianceRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceRange::scale(
  self : SignalspeccovarianceRange,
  f : Double,
) -> SignalspeccovarianceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceRange::add(
  self : SignalspeccovarianceRange,
  other : SignalspeccovarianceRange,
) -> SignalspeccovarianceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceRange::copy(
  self : SignalspeccovarianceRange,
) -> SignalspeccovarianceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceRange::fill(
  self : SignalspeccovarianceRange,
  v : Double,
) -> SignalspeccovarianceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceRange::min(
  self : SignalspeccovarianceRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceRange::max(
  self : SignalspeccovarianceRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceRange::to_string(
  self : SignalspeccovarianceRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SignalspeccovarianceSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_spec_covariance_slice_make(
  size : Int32,
) -> SignalspeccovarianceSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SignalspeccovarianceSlice::len(
  self : SignalspeccovarianceSlice,
) -> Int32 {
  self.size
}

///|
pub fn SignalspeccovarianceSlice::get(
  self : SignalspeccovarianceSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SignalspeccovarianceSlice::set(
  self : SignalspeccovarianceSlice,
  i : Int32,
  v : Double,
) -> SignalspeccovarianceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceSlice::sum(
  self : SignalspeccovarianceSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SignalspeccovarianceSlice::mean(
  self : SignalspeccovarianceSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SignalspeccovarianceSlice::scale(
  self : SignalspeccovarianceSlice,
  f : Double,
) -> SignalspeccovarianceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceSlice::add(
  self : SignalspeccovarianceSlice,
  other : SignalspeccovarianceSlice,
) -> SignalspeccovarianceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceSlice::copy(
  self : SignalspeccovarianceSlice,
) -> SignalspeccovarianceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceSlice::fill(
  self : SignalspeccovarianceSlice,
  v : Double,
) -> SignalspeccovarianceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SignalspeccovarianceSlice::min(
  self : SignalspeccovarianceSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SignalspeccovarianceSlice::max(
  self : SignalspeccovarianceSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SignalspeccovarianceSlice::to_string(
  self : SignalspeccovarianceSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
