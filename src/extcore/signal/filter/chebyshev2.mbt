///|
///===
/// extcore/signal_filter_chebyshev2
pub(all) struct Signalfilterchebyshev2Point {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn signal_filter_chebyshev2_make_point(
  x : Double,
  y : Double,
) -> Signalfilterchebyshev2Point {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn signal_filter_chebyshev2_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> Signalfilterchebyshev2Point {
  { x, y, z, label: 0, }
}

///|
pub fn Signalfilterchebyshev2Point::x(
  self : Signalfilterchebyshev2Point,
) -> Double {
  self.x
}

///|
pub fn Signalfilterchebyshev2Point::y(
  self : Signalfilterchebyshev2Point,
) -> Double {
  self.y
}

///|
pub fn Signalfilterchebyshev2Point::z(
  self : Signalfilterchebyshev2Point,
) -> Double {
  self.z
}

///|
pub fn Signalfilterchebyshev2Point::label(
  self : Signalfilterchebyshev2Point,
) -> Int32 {
  self.label
}

///|
pub fn Signalfilterchebyshev2Point::dist(
  self : Signalfilterchebyshev2Point,
  other : Signalfilterchebyshev2Point,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn Signalfilterchebyshev2Point::add(
  self : Signalfilterchebyshev2Point,
  other : Signalfilterchebyshev2Point,
) -> Signalfilterchebyshev2Point {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn Signalfilterchebyshev2Point::sub(
  self : Signalfilterchebyshev2Point,
  other : Signalfilterchebyshev2Point,
) -> Signalfilterchebyshev2Point {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn Signalfilterchebyshev2Point::scale(
  self : Signalfilterchebyshev2Point,
  s : Double,
) -> Signalfilterchebyshev2Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn Signalfilterchebyshev2Point::dot(
  self : Signalfilterchebyshev2Point,
  other : Signalfilterchebyshev2Point,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn Signalfilterchebyshev2Point::cross(
  self : Signalfilterchebyshev2Point,
  other : Signalfilterchebyshev2Point,
) -> Signalfilterchebyshev2Point {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn Signalfilterchebyshev2Point::norm(
  self : Signalfilterchebyshev2Point,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn Signalfilterchebyshev2Point::normalize(
  self : Signalfilterchebyshev2Point,
) -> Signalfilterchebyshev2Point {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Signalfilterchebyshev2Point::negate(
  self : Signalfilterchebyshev2Point,
) -> Signalfilterchebyshev2Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn Signalfilterchebyshev2Point::mid(
  self : Signalfilterchebyshev2Point,
  other : Signalfilterchebyshev2Point,
) -> Signalfilterchebyshev2Point {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn Signalfilterchebyshev2Point::lerp(
  self : Signalfilterchebyshev2Point,
  other : Signalfilterchebyshev2Point,
  t : Double,
) -> Signalfilterchebyshev2Point {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn Signalfilterchebyshev2Point::to_string(
  self : Signalfilterchebyshev2Point,
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
pub(all) struct Signalfilterchebyshev2Series {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn signal_filter_chebyshev2_make_series(
  vals : Array[Double],
  name : String,
) -> Signalfilterchebyshev2Series {
  { vals, name, meta: 0, }
}

///|
pub fn Signalfilterchebyshev2Series::len(
  self : Signalfilterchebyshev2Series,
) -> Int32 {
  self.vals.length()
}

///|
pub fn Signalfilterchebyshev2Series::sum(
  self : Signalfilterchebyshev2Series,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn Signalfilterchebyshev2Series::mean(
  self : Signalfilterchebyshev2Series,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn Signalfilterchebyshev2Series::min(
  self : Signalfilterchebyshev2Series,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn Signalfilterchebyshev2Series::max(
  self : Signalfilterchebyshev2Series,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn Signalfilterchebyshev2Series::range(
  self : Signalfilterchebyshev2Series,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn Signalfilterchebyshev2Series::variance(
  self : Signalfilterchebyshev2Series,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn Signalfilterchebyshev2Series::std(
  self : Signalfilterchebyshev2Series,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn Signalfilterchebyshev2Series::median(
  self : Signalfilterchebyshev2Series,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn Signalfilterchebyshev2Series::scale(
  self : Signalfilterchebyshev2Series,
  f : Double,
) -> Signalfilterchebyshev2Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn Signalfilterchebyshev2Series::add(
  self : Signalfilterchebyshev2Series,
  other : Signalfilterchebyshev2Series,
) -> Signalfilterchebyshev2Series {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Signalfilterchebyshev2Series::sub(
  self : Signalfilterchebyshev2Series,
  other : Signalfilterchebyshev2Series,
) -> Signalfilterchebyshev2Series {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Signalfilterchebyshev2Series::normalize(
  self : Signalfilterchebyshev2Series,
) -> Signalfilterchebyshev2Series {
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
pub fn Signalfilterchebyshev2Series::cumsum(
  self : Signalfilterchebyshev2Series,
) -> Signalfilterchebyshev2Series {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn Signalfilterchebyshev2Series::to_string(
  self : Signalfilterchebyshev2Series,
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
pub(all) struct Signalfilterchebyshev2Matrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn signal_filter_chebyshev2_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Signalfilterchebyshev2Matrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn signal_filter_chebyshev2_matrix_identity(
  n : Int32,
) -> Signalfilterchebyshev2Matrix {
  let m = signal_filter_chebyshev2_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn Signalfilterchebyshev2Matrix::get(
  self : Signalfilterchebyshev2Matrix,
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
pub fn Signalfilterchebyshev2Matrix::transpose(
  self : Signalfilterchebyshev2Matrix,
) -> Signalfilterchebyshev2Matrix {
  let result = signal_filter_chebyshev2_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn Signalfilterchebyshev2Matrix::add(
  self : Signalfilterchebyshev2Matrix,
  other : Signalfilterchebyshev2Matrix,
) -> Signalfilterchebyshev2Matrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = signal_filter_chebyshev2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn Signalfilterchebyshev2Matrix::scale(
  self : Signalfilterchebyshev2Matrix,
  s : Double,
) -> Signalfilterchebyshev2Matrix {
  let result = signal_filter_chebyshev2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn Signalfilterchebyshev2Matrix::multiply(
  self : Signalfilterchebyshev2Matrix,
  other : Signalfilterchebyshev2Matrix,
) -> Signalfilterchebyshev2Matrix {
  if self.cols != other.rows {
    return signal_filter_chebyshev2_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = signal_filter_chebyshev2_make_matrix(self.rows, other.cols, 0.0)
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
pub fn Signalfilterchebyshev2Matrix::trace(
  self : Signalfilterchebyshev2Matrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn Signalfilterchebyshev2Matrix::det(
  self : Signalfilterchebyshev2Matrix,
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
pub fn Signalfilterchebyshev2Matrix::norm(
  self : Signalfilterchebyshev2Matrix,
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
pub fn Signalfilterchebyshev2Matrix::to_string(
  self : Signalfilterchebyshev2Matrix,
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
pub(all) struct Signalfilterchebyshev2Vector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn signal_filter_chebyshev2_make_vector(
  comps : Array[Double],
) -> Signalfilterchebyshev2Vector {
  { comps, dim: comps.length(), }
}

///|
pub fn signal_filter_chebyshev2_vector_zero(
  dim : Int32,
) -> Signalfilterchebyshev2Vector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn Signalfilterchebyshev2Vector::add(
  self : Signalfilterchebyshev2Vector,
  other : Signalfilterchebyshev2Vector,
) -> Signalfilterchebyshev2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Signalfilterchebyshev2Vector::sub(
  self : Signalfilterchebyshev2Vector,
  other : Signalfilterchebyshev2Vector,
) -> Signalfilterchebyshev2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Signalfilterchebyshev2Vector::scale(
  self : Signalfilterchebyshev2Vector,
  s : Double,
) -> Signalfilterchebyshev2Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn Signalfilterchebyshev2Vector::dot(
  self : Signalfilterchebyshev2Vector,
  other : Signalfilterchebyshev2Vector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn Signalfilterchebyshev2Vector::norm(
  self : Signalfilterchebyshev2Vector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn Signalfilterchebyshev2Vector::normalize(
  self : Signalfilterchebyshev2Vector,
) -> Signalfilterchebyshev2Vector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Signalfilterchebyshev2Vector::dist(
  self : Signalfilterchebyshev2Vector,
  other : Signalfilterchebyshev2Vector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn Signalfilterchebyshev2Vector::to_string(
  self : Signalfilterchebyshev2Vector,
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
pub(all) struct Signalfilterchebyshev2Frame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_frame_make(
  size : Int32,
) -> Signalfilterchebyshev2Frame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Frame::len(
  self : Signalfilterchebyshev2Frame,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Frame::get(
  self : Signalfilterchebyshev2Frame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Frame::set(
  self : Signalfilterchebyshev2Frame,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Frame::sum(
  self : Signalfilterchebyshev2Frame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Frame::mean(
  self : Signalfilterchebyshev2Frame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Frame::scale(
  self : Signalfilterchebyshev2Frame,
  f : Double,
) -> Signalfilterchebyshev2Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Frame::add(
  self : Signalfilterchebyshev2Frame,
  other : Signalfilterchebyshev2Frame,
) -> Signalfilterchebyshev2Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Frame::copy(
  self : Signalfilterchebyshev2Frame,
) -> Signalfilterchebyshev2Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Frame::fill(
  self : Signalfilterchebyshev2Frame,
  v : Double,
) -> Signalfilterchebyshev2Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Frame::min(
  self : Signalfilterchebyshev2Frame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Frame::max(
  self : Signalfilterchebyshev2Frame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Frame::to_string(
  self : Signalfilterchebyshev2Frame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2Table {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_table_make(
  size : Int32,
) -> Signalfilterchebyshev2Table {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Table::len(
  self : Signalfilterchebyshev2Table,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Table::get(
  self : Signalfilterchebyshev2Table,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Table::set(
  self : Signalfilterchebyshev2Table,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Table::sum(
  self : Signalfilterchebyshev2Table,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Table::mean(
  self : Signalfilterchebyshev2Table,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Table::scale(
  self : Signalfilterchebyshev2Table,
  f : Double,
) -> Signalfilterchebyshev2Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Table::add(
  self : Signalfilterchebyshev2Table,
  other : Signalfilterchebyshev2Table,
) -> Signalfilterchebyshev2Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Table::copy(
  self : Signalfilterchebyshev2Table,
) -> Signalfilterchebyshev2Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Table::fill(
  self : Signalfilterchebyshev2Table,
  v : Double,
) -> Signalfilterchebyshev2Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Table::min(
  self : Signalfilterchebyshev2Table,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Table::max(
  self : Signalfilterchebyshev2Table,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Table::to_string(
  self : Signalfilterchebyshev2Table,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2GraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_graphn_make(
  size : Int32,
) -> Signalfilterchebyshev2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2GraphN::len(
  self : Signalfilterchebyshev2GraphN,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2GraphN::get(
  self : Signalfilterchebyshev2GraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2GraphN::set(
  self : Signalfilterchebyshev2GraphN,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2GraphN::sum(
  self : Signalfilterchebyshev2GraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2GraphN::mean(
  self : Signalfilterchebyshev2GraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2GraphN::scale(
  self : Signalfilterchebyshev2GraphN,
  f : Double,
) -> Signalfilterchebyshev2GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2GraphN::add(
  self : Signalfilterchebyshev2GraphN,
  other : Signalfilterchebyshev2GraphN,
) -> Signalfilterchebyshev2GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2GraphN::copy(
  self : Signalfilterchebyshev2GraphN,
) -> Signalfilterchebyshev2GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2GraphN::fill(
  self : Signalfilterchebyshev2GraphN,
  v : Double,
) -> Signalfilterchebyshev2GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2GraphN::min(
  self : Signalfilterchebyshev2GraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2GraphN::max(
  self : Signalfilterchebyshev2GraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2GraphN::to_string(
  self : Signalfilterchebyshev2GraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2Node {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_node_make(
  size : Int32,
) -> Signalfilterchebyshev2Node {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Node::len(
  self : Signalfilterchebyshev2Node,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Node::get(
  self : Signalfilterchebyshev2Node,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Node::set(
  self : Signalfilterchebyshev2Node,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Node::sum(
  self : Signalfilterchebyshev2Node,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Node::mean(
  self : Signalfilterchebyshev2Node,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Node::scale(
  self : Signalfilterchebyshev2Node,
  f : Double,
) -> Signalfilterchebyshev2Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Node::add(
  self : Signalfilterchebyshev2Node,
  other : Signalfilterchebyshev2Node,
) -> Signalfilterchebyshev2Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Node::copy(
  self : Signalfilterchebyshev2Node,
) -> Signalfilterchebyshev2Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Node::fill(
  self : Signalfilterchebyshev2Node,
  v : Double,
) -> Signalfilterchebyshev2Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Node::min(
  self : Signalfilterchebyshev2Node,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Node::max(
  self : Signalfilterchebyshev2Node,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Node::to_string(
  self : Signalfilterchebyshev2Node,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2Edge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_edge_make(
  size : Int32,
) -> Signalfilterchebyshev2Edge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Edge::len(
  self : Signalfilterchebyshev2Edge,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Edge::get(
  self : Signalfilterchebyshev2Edge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Edge::set(
  self : Signalfilterchebyshev2Edge,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Edge::sum(
  self : Signalfilterchebyshev2Edge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Edge::mean(
  self : Signalfilterchebyshev2Edge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Edge::scale(
  self : Signalfilterchebyshev2Edge,
  f : Double,
) -> Signalfilterchebyshev2Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Edge::add(
  self : Signalfilterchebyshev2Edge,
  other : Signalfilterchebyshev2Edge,
) -> Signalfilterchebyshev2Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Edge::copy(
  self : Signalfilterchebyshev2Edge,
) -> Signalfilterchebyshev2Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Edge::fill(
  self : Signalfilterchebyshev2Edge,
  v : Double,
) -> Signalfilterchebyshev2Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Edge::min(
  self : Signalfilterchebyshev2Edge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Edge::max(
  self : Signalfilterchebyshev2Edge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Edge::to_string(
  self : Signalfilterchebyshev2Edge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2Path {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_path_make(
  size : Int32,
) -> Signalfilterchebyshev2Path {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Path::len(
  self : Signalfilterchebyshev2Path,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Path::get(
  self : Signalfilterchebyshev2Path,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Path::set(
  self : Signalfilterchebyshev2Path,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Path::sum(
  self : Signalfilterchebyshev2Path,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Path::mean(
  self : Signalfilterchebyshev2Path,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Path::scale(
  self : Signalfilterchebyshev2Path,
  f : Double,
) -> Signalfilterchebyshev2Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Path::add(
  self : Signalfilterchebyshev2Path,
  other : Signalfilterchebyshev2Path,
) -> Signalfilterchebyshev2Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Path::copy(
  self : Signalfilterchebyshev2Path,
) -> Signalfilterchebyshev2Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Path::fill(
  self : Signalfilterchebyshev2Path,
  v : Double,
) -> Signalfilterchebyshev2Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Path::min(
  self : Signalfilterchebyshev2Path,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Path::max(
  self : Signalfilterchebyshev2Path,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Path::to_string(
  self : Signalfilterchebyshev2Path,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2Cluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_cluster_make(
  size : Int32,
) -> Signalfilterchebyshev2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Cluster::len(
  self : Signalfilterchebyshev2Cluster,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Cluster::get(
  self : Signalfilterchebyshev2Cluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Cluster::set(
  self : Signalfilterchebyshev2Cluster,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Cluster::sum(
  self : Signalfilterchebyshev2Cluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Cluster::mean(
  self : Signalfilterchebyshev2Cluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Cluster::scale(
  self : Signalfilterchebyshev2Cluster,
  f : Double,
) -> Signalfilterchebyshev2Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Cluster::add(
  self : Signalfilterchebyshev2Cluster,
  other : Signalfilterchebyshev2Cluster,
) -> Signalfilterchebyshev2Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Cluster::copy(
  self : Signalfilterchebyshev2Cluster,
) -> Signalfilterchebyshev2Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Cluster::fill(
  self : Signalfilterchebyshev2Cluster,
  v : Double,
) -> Signalfilterchebyshev2Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Cluster::min(
  self : Signalfilterchebyshev2Cluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Cluster::max(
  self : Signalfilterchebyshev2Cluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Cluster::to_string(
  self : Signalfilterchebyshev2Cluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2Model {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_model_make(
  size : Int32,
) -> Signalfilterchebyshev2Model {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Model::len(
  self : Signalfilterchebyshev2Model,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Model::get(
  self : Signalfilterchebyshev2Model,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Model::set(
  self : Signalfilterchebyshev2Model,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Model::sum(
  self : Signalfilterchebyshev2Model,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Model::mean(
  self : Signalfilterchebyshev2Model,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Model::scale(
  self : Signalfilterchebyshev2Model,
  f : Double,
) -> Signalfilterchebyshev2Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Model::add(
  self : Signalfilterchebyshev2Model,
  other : Signalfilterchebyshev2Model,
) -> Signalfilterchebyshev2Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Model::copy(
  self : Signalfilterchebyshev2Model,
) -> Signalfilterchebyshev2Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Model::fill(
  self : Signalfilterchebyshev2Model,
  v : Double,
) -> Signalfilterchebyshev2Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Model::min(
  self : Signalfilterchebyshev2Model,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Model::max(
  self : Signalfilterchebyshev2Model,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Model::to_string(
  self : Signalfilterchebyshev2Model,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2Layer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_layer_make(
  size : Int32,
) -> Signalfilterchebyshev2Layer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Layer::len(
  self : Signalfilterchebyshev2Layer,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Layer::get(
  self : Signalfilterchebyshev2Layer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Layer::set(
  self : Signalfilterchebyshev2Layer,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Layer::sum(
  self : Signalfilterchebyshev2Layer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Layer::mean(
  self : Signalfilterchebyshev2Layer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Layer::scale(
  self : Signalfilterchebyshev2Layer,
  f : Double,
) -> Signalfilterchebyshev2Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Layer::add(
  self : Signalfilterchebyshev2Layer,
  other : Signalfilterchebyshev2Layer,
) -> Signalfilterchebyshev2Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Layer::copy(
  self : Signalfilterchebyshev2Layer,
) -> Signalfilterchebyshev2Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Layer::fill(
  self : Signalfilterchebyshev2Layer,
  v : Double,
) -> Signalfilterchebyshev2Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Layer::min(
  self : Signalfilterchebyshev2Layer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Layer::max(
  self : Signalfilterchebyshev2Layer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Layer::to_string(
  self : Signalfilterchebyshev2Layer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2Buffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_buffer_make(
  size : Int32,
) -> Signalfilterchebyshev2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Buffer::len(
  self : Signalfilterchebyshev2Buffer,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Buffer::get(
  self : Signalfilterchebyshev2Buffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Buffer::set(
  self : Signalfilterchebyshev2Buffer,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Buffer::sum(
  self : Signalfilterchebyshev2Buffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Buffer::mean(
  self : Signalfilterchebyshev2Buffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Buffer::scale(
  self : Signalfilterchebyshev2Buffer,
  f : Double,
) -> Signalfilterchebyshev2Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Buffer::add(
  self : Signalfilterchebyshev2Buffer,
  other : Signalfilterchebyshev2Buffer,
) -> Signalfilterchebyshev2Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Buffer::copy(
  self : Signalfilterchebyshev2Buffer,
) -> Signalfilterchebyshev2Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Buffer::fill(
  self : Signalfilterchebyshev2Buffer,
  v : Double,
) -> Signalfilterchebyshev2Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Buffer::min(
  self : Signalfilterchebyshev2Buffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Buffer::max(
  self : Signalfilterchebyshev2Buffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Buffer::to_string(
  self : Signalfilterchebyshev2Buffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2Cursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_cursor_make(
  size : Int32,
) -> Signalfilterchebyshev2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Cursor::len(
  self : Signalfilterchebyshev2Cursor,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Cursor::get(
  self : Signalfilterchebyshev2Cursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Cursor::set(
  self : Signalfilterchebyshev2Cursor,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Cursor::sum(
  self : Signalfilterchebyshev2Cursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Cursor::mean(
  self : Signalfilterchebyshev2Cursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Cursor::scale(
  self : Signalfilterchebyshev2Cursor,
  f : Double,
) -> Signalfilterchebyshev2Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Cursor::add(
  self : Signalfilterchebyshev2Cursor,
  other : Signalfilterchebyshev2Cursor,
) -> Signalfilterchebyshev2Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Cursor::copy(
  self : Signalfilterchebyshev2Cursor,
) -> Signalfilterchebyshev2Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Cursor::fill(
  self : Signalfilterchebyshev2Cursor,
  v : Double,
) -> Signalfilterchebyshev2Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Cursor::min(
  self : Signalfilterchebyshev2Cursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Cursor::max(
  self : Signalfilterchebyshev2Cursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Cursor::to_string(
  self : Signalfilterchebyshev2Cursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2View {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_view_make(
  size : Int32,
) -> Signalfilterchebyshev2View {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2View::len(
  self : Signalfilterchebyshev2View,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2View::get(
  self : Signalfilterchebyshev2View,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2View::set(
  self : Signalfilterchebyshev2View,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2View::sum(
  self : Signalfilterchebyshev2View,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2View::mean(
  self : Signalfilterchebyshev2View,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2View::scale(
  self : Signalfilterchebyshev2View,
  f : Double,
) -> Signalfilterchebyshev2View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2View::add(
  self : Signalfilterchebyshev2View,
  other : Signalfilterchebyshev2View,
) -> Signalfilterchebyshev2View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2View::copy(
  self : Signalfilterchebyshev2View,
) -> Signalfilterchebyshev2View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2View::fill(
  self : Signalfilterchebyshev2View,
  v : Double,
) -> Signalfilterchebyshev2View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2View::min(
  self : Signalfilterchebyshev2View,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2View::max(
  self : Signalfilterchebyshev2View,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2View::to_string(
  self : Signalfilterchebyshev2View,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2Range {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_range_make(
  size : Int32,
) -> Signalfilterchebyshev2Range {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Range::len(
  self : Signalfilterchebyshev2Range,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Range::get(
  self : Signalfilterchebyshev2Range,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Range::set(
  self : Signalfilterchebyshev2Range,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Range::sum(
  self : Signalfilterchebyshev2Range,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Range::mean(
  self : Signalfilterchebyshev2Range,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Range::scale(
  self : Signalfilterchebyshev2Range,
  f : Double,
) -> Signalfilterchebyshev2Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Range::add(
  self : Signalfilterchebyshev2Range,
  other : Signalfilterchebyshev2Range,
) -> Signalfilterchebyshev2Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Range::copy(
  self : Signalfilterchebyshev2Range,
) -> Signalfilterchebyshev2Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Range::fill(
  self : Signalfilterchebyshev2Range,
  v : Double,
) -> Signalfilterchebyshev2Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Range::min(
  self : Signalfilterchebyshev2Range,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Range::max(
  self : Signalfilterchebyshev2Range,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Range::to_string(
  self : Signalfilterchebyshev2Range,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Signalfilterchebyshev2Slice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn signal_filter_chebyshev2_slice_make(
  size : Int32,
) -> Signalfilterchebyshev2Slice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Signalfilterchebyshev2Slice::len(
  self : Signalfilterchebyshev2Slice,
) -> Int32 {
  self.size
}

///|
pub fn Signalfilterchebyshev2Slice::get(
  self : Signalfilterchebyshev2Slice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Signalfilterchebyshev2Slice::set(
  self : Signalfilterchebyshev2Slice,
  i : Int32,
  v : Double,
) -> Signalfilterchebyshev2Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Slice::sum(
  self : Signalfilterchebyshev2Slice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Signalfilterchebyshev2Slice::mean(
  self : Signalfilterchebyshev2Slice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Signalfilterchebyshev2Slice::scale(
  self : Signalfilterchebyshev2Slice,
  f : Double,
) -> Signalfilterchebyshev2Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Slice::add(
  self : Signalfilterchebyshev2Slice,
  other : Signalfilterchebyshev2Slice,
) -> Signalfilterchebyshev2Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Slice::copy(
  self : Signalfilterchebyshev2Slice,
) -> Signalfilterchebyshev2Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Slice::fill(
  self : Signalfilterchebyshev2Slice,
  v : Double,
) -> Signalfilterchebyshev2Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Signalfilterchebyshev2Slice::min(
  self : Signalfilterchebyshev2Slice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn Signalfilterchebyshev2Slice::max(
  self : Signalfilterchebyshev2Slice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn Signalfilterchebyshev2Slice::to_string(
  self : Signalfilterchebyshev2Slice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
