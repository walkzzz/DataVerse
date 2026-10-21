///|
///===
/// extcore/crypto_asym_sm9
pub(all) struct Cryptoasymsm9Point {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn crypto_asym_sm9_make_point(x : Double, y : Double) -> Cryptoasymsm9Point {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn crypto_asym_sm9_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> Cryptoasymsm9Point {
  { x, y, z, label: 0, }
}

///|
pub fn Cryptoasymsm9Point::x(self : Cryptoasymsm9Point) -> Double {
  self.x
}

///|
pub fn Cryptoasymsm9Point::y(self : Cryptoasymsm9Point) -> Double {
  self.y
}

///|
pub fn Cryptoasymsm9Point::z(self : Cryptoasymsm9Point) -> Double {
  self.z
}

///|
pub fn Cryptoasymsm9Point::label(self : Cryptoasymsm9Point) -> Int32 {
  self.label
}

///|
pub fn Cryptoasymsm9Point::dist(
  self : Cryptoasymsm9Point,
  other : Cryptoasymsm9Point,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn Cryptoasymsm9Point::add(
  self : Cryptoasymsm9Point,
  other : Cryptoasymsm9Point,
) -> Cryptoasymsm9Point {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn Cryptoasymsm9Point::sub(
  self : Cryptoasymsm9Point,
  other : Cryptoasymsm9Point,
) -> Cryptoasymsm9Point {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn Cryptoasymsm9Point::scale(
  self : Cryptoasymsm9Point,
  s : Double,
) -> Cryptoasymsm9Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn Cryptoasymsm9Point::dot(
  self : Cryptoasymsm9Point,
  other : Cryptoasymsm9Point,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn Cryptoasymsm9Point::cross(
  self : Cryptoasymsm9Point,
  other : Cryptoasymsm9Point,
) -> Cryptoasymsm9Point {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn Cryptoasymsm9Point::norm(self : Cryptoasymsm9Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn Cryptoasymsm9Point::normalize(
  self : Cryptoasymsm9Point,
) -> Cryptoasymsm9Point {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Cryptoasymsm9Point::negate(
  self : Cryptoasymsm9Point,
) -> Cryptoasymsm9Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn Cryptoasymsm9Point::mid(
  self : Cryptoasymsm9Point,
  other : Cryptoasymsm9Point,
) -> Cryptoasymsm9Point {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn Cryptoasymsm9Point::lerp(
  self : Cryptoasymsm9Point,
  other : Cryptoasymsm9Point,
  t : Double,
) -> Cryptoasymsm9Point {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn Cryptoasymsm9Point::to_string(self : Cryptoasymsm9Point) -> String {
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
pub(all) struct Cryptoasymsm9Series {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn crypto_asym_sm9_make_series(
  vals : Array[Double],
  name : String,
) -> Cryptoasymsm9Series {
  { vals, name, meta: 0, }
}

///|
pub fn Cryptoasymsm9Series::len(self : Cryptoasymsm9Series) -> Int32 {
  self.vals.length()
}

///|
pub fn Cryptoasymsm9Series::sum(self : Cryptoasymsm9Series) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn Cryptoasymsm9Series::mean(self : Cryptoasymsm9Series) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn Cryptoasymsm9Series::min(self : Cryptoasymsm9Series) -> Double {
  @_common.min(self.vals)
}

///|
pub fn Cryptoasymsm9Series::max(self : Cryptoasymsm9Series) -> Double {
  @_common.max(self.vals)
}

///|
pub fn Cryptoasymsm9Series::range(self : Cryptoasymsm9Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn Cryptoasymsm9Series::variance(self : Cryptoasymsm9Series) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn Cryptoasymsm9Series::std(self : Cryptoasymsm9Series) -> Double {
  @_common.std(self.vals)
}

///|
pub fn Cryptoasymsm9Series::median(self : Cryptoasymsm9Series) -> Double {
  @_common.median(self.vals)
}

///|
pub fn Cryptoasymsm9Series::scale(
  self : Cryptoasymsm9Series,
  f : Double,
) -> Cryptoasymsm9Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn Cryptoasymsm9Series::add(
  self : Cryptoasymsm9Series,
  other : Cryptoasymsm9Series,
) -> Cryptoasymsm9Series {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Cryptoasymsm9Series::sub(
  self : Cryptoasymsm9Series,
  other : Cryptoasymsm9Series,
) -> Cryptoasymsm9Series {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Cryptoasymsm9Series::normalize(
  self : Cryptoasymsm9Series,
) -> Cryptoasymsm9Series {
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
pub fn Cryptoasymsm9Series::cumsum(
  self : Cryptoasymsm9Series,
) -> Cryptoasymsm9Series {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn Cryptoasymsm9Series::to_string(self : Cryptoasymsm9Series) -> String {
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
pub(all) struct Cryptoasymsm9Matrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn crypto_asym_sm9_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Cryptoasymsm9Matrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn crypto_asym_sm9_matrix_identity(n : Int32) -> Cryptoasymsm9Matrix {
  let m = crypto_asym_sm9_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn Cryptoasymsm9Matrix::get(
  self : Cryptoasymsm9Matrix,
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
pub fn Cryptoasymsm9Matrix::transpose(
  self : Cryptoasymsm9Matrix,
) -> Cryptoasymsm9Matrix {
  let result = crypto_asym_sm9_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn Cryptoasymsm9Matrix::add(
  self : Cryptoasymsm9Matrix,
  other : Cryptoasymsm9Matrix,
) -> Cryptoasymsm9Matrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = crypto_asym_sm9_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn Cryptoasymsm9Matrix::scale(
  self : Cryptoasymsm9Matrix,
  s : Double,
) -> Cryptoasymsm9Matrix {
  let result = crypto_asym_sm9_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn Cryptoasymsm9Matrix::multiply(
  self : Cryptoasymsm9Matrix,
  other : Cryptoasymsm9Matrix,
) -> Cryptoasymsm9Matrix {
  if self.cols != other.rows {
    return crypto_asym_sm9_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = crypto_asym_sm9_make_matrix(self.rows, other.cols, 0.0)
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
pub fn Cryptoasymsm9Matrix::trace(self : Cryptoasymsm9Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn Cryptoasymsm9Matrix::det(self : Cryptoasymsm9Matrix) -> Double {
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
pub fn Cryptoasymsm9Matrix::norm(self : Cryptoasymsm9Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn Cryptoasymsm9Matrix::to_string(self : Cryptoasymsm9Matrix) -> String {
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
pub(all) struct Cryptoasymsm9Vector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn crypto_asym_sm9_make_vector(
  comps : Array[Double],
) -> Cryptoasymsm9Vector {
  { comps, dim: comps.length(), }
}

///|
pub fn crypto_asym_sm9_vector_zero(dim : Int32) -> Cryptoasymsm9Vector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn Cryptoasymsm9Vector::add(
  self : Cryptoasymsm9Vector,
  other : Cryptoasymsm9Vector,
) -> Cryptoasymsm9Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Cryptoasymsm9Vector::sub(
  self : Cryptoasymsm9Vector,
  other : Cryptoasymsm9Vector,
) -> Cryptoasymsm9Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Cryptoasymsm9Vector::scale(
  self : Cryptoasymsm9Vector,
  s : Double,
) -> Cryptoasymsm9Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn Cryptoasymsm9Vector::dot(
  self : Cryptoasymsm9Vector,
  other : Cryptoasymsm9Vector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn Cryptoasymsm9Vector::norm(self : Cryptoasymsm9Vector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn Cryptoasymsm9Vector::normalize(
  self : Cryptoasymsm9Vector,
) -> Cryptoasymsm9Vector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Cryptoasymsm9Vector::dist(
  self : Cryptoasymsm9Vector,
  other : Cryptoasymsm9Vector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn Cryptoasymsm9Vector::to_string(self : Cryptoasymsm9Vector) -> String {
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
pub(all) struct Cryptoasymsm9Frame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_frame_make(size : Int32) -> Cryptoasymsm9Frame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Frame::len(self : Cryptoasymsm9Frame) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Frame::get(self : Cryptoasymsm9Frame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Frame::set(
  self : Cryptoasymsm9Frame,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Frame::sum(self : Cryptoasymsm9Frame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Frame::mean(self : Cryptoasymsm9Frame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Frame::scale(
  self : Cryptoasymsm9Frame,
  f : Double,
) -> Cryptoasymsm9Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Frame::add(
  self : Cryptoasymsm9Frame,
  other : Cryptoasymsm9Frame,
) -> Cryptoasymsm9Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Frame::copy(
  self : Cryptoasymsm9Frame,
) -> Cryptoasymsm9Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Frame::fill(
  self : Cryptoasymsm9Frame,
  v : Double,
) -> Cryptoasymsm9Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Frame::min(self : Cryptoasymsm9Frame) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Frame::max(self : Cryptoasymsm9Frame) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Frame::to_string(self : Cryptoasymsm9Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9Table {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_table_make(size : Int32) -> Cryptoasymsm9Table {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Table::len(self : Cryptoasymsm9Table) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Table::get(self : Cryptoasymsm9Table, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Table::set(
  self : Cryptoasymsm9Table,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Table::sum(self : Cryptoasymsm9Table) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Table::mean(self : Cryptoasymsm9Table) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Table::scale(
  self : Cryptoasymsm9Table,
  f : Double,
) -> Cryptoasymsm9Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Table::add(
  self : Cryptoasymsm9Table,
  other : Cryptoasymsm9Table,
) -> Cryptoasymsm9Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Table::copy(
  self : Cryptoasymsm9Table,
) -> Cryptoasymsm9Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Table::fill(
  self : Cryptoasymsm9Table,
  v : Double,
) -> Cryptoasymsm9Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Table::min(self : Cryptoasymsm9Table) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Table::max(self : Cryptoasymsm9Table) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Table::to_string(self : Cryptoasymsm9Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9GraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_graphn_make(size : Int32) -> Cryptoasymsm9GraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9GraphN::len(self : Cryptoasymsm9GraphN) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9GraphN::get(
  self : Cryptoasymsm9GraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9GraphN::set(
  self : Cryptoasymsm9GraphN,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9GraphN::sum(self : Cryptoasymsm9GraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9GraphN::mean(self : Cryptoasymsm9GraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9GraphN::scale(
  self : Cryptoasymsm9GraphN,
  f : Double,
) -> Cryptoasymsm9GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9GraphN::add(
  self : Cryptoasymsm9GraphN,
  other : Cryptoasymsm9GraphN,
) -> Cryptoasymsm9GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9GraphN::copy(
  self : Cryptoasymsm9GraphN,
) -> Cryptoasymsm9GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9GraphN::fill(
  self : Cryptoasymsm9GraphN,
  v : Double,
) -> Cryptoasymsm9GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9GraphN::min(self : Cryptoasymsm9GraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9GraphN::max(self : Cryptoasymsm9GraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9GraphN::to_string(self : Cryptoasymsm9GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9Node {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_node_make(size : Int32) -> Cryptoasymsm9Node {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Node::len(self : Cryptoasymsm9Node) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Node::get(self : Cryptoasymsm9Node, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Node::set(
  self : Cryptoasymsm9Node,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Node::sum(self : Cryptoasymsm9Node) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Node::mean(self : Cryptoasymsm9Node) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Node::scale(
  self : Cryptoasymsm9Node,
  f : Double,
) -> Cryptoasymsm9Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Node::add(
  self : Cryptoasymsm9Node,
  other : Cryptoasymsm9Node,
) -> Cryptoasymsm9Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Node::copy(self : Cryptoasymsm9Node) -> Cryptoasymsm9Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Node::fill(
  self : Cryptoasymsm9Node,
  v : Double,
) -> Cryptoasymsm9Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Node::min(self : Cryptoasymsm9Node) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Node::max(self : Cryptoasymsm9Node) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Node::to_string(self : Cryptoasymsm9Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9Edge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_edge_make(size : Int32) -> Cryptoasymsm9Edge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Edge::len(self : Cryptoasymsm9Edge) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Edge::get(self : Cryptoasymsm9Edge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Edge::set(
  self : Cryptoasymsm9Edge,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Edge::sum(self : Cryptoasymsm9Edge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Edge::mean(self : Cryptoasymsm9Edge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Edge::scale(
  self : Cryptoasymsm9Edge,
  f : Double,
) -> Cryptoasymsm9Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Edge::add(
  self : Cryptoasymsm9Edge,
  other : Cryptoasymsm9Edge,
) -> Cryptoasymsm9Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Edge::copy(self : Cryptoasymsm9Edge) -> Cryptoasymsm9Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Edge::fill(
  self : Cryptoasymsm9Edge,
  v : Double,
) -> Cryptoasymsm9Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Edge::min(self : Cryptoasymsm9Edge) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Edge::max(self : Cryptoasymsm9Edge) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Edge::to_string(self : Cryptoasymsm9Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9Path {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_path_make(size : Int32) -> Cryptoasymsm9Path {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Path::len(self : Cryptoasymsm9Path) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Path::get(self : Cryptoasymsm9Path, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Path::set(
  self : Cryptoasymsm9Path,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Path::sum(self : Cryptoasymsm9Path) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Path::mean(self : Cryptoasymsm9Path) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Path::scale(
  self : Cryptoasymsm9Path,
  f : Double,
) -> Cryptoasymsm9Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Path::add(
  self : Cryptoasymsm9Path,
  other : Cryptoasymsm9Path,
) -> Cryptoasymsm9Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Path::copy(self : Cryptoasymsm9Path) -> Cryptoasymsm9Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Path::fill(
  self : Cryptoasymsm9Path,
  v : Double,
) -> Cryptoasymsm9Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Path::min(self : Cryptoasymsm9Path) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Path::max(self : Cryptoasymsm9Path) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Path::to_string(self : Cryptoasymsm9Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9Cluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_cluster_make(size : Int32) -> Cryptoasymsm9Cluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Cluster::len(self : Cryptoasymsm9Cluster) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Cluster::get(
  self : Cryptoasymsm9Cluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Cluster::set(
  self : Cryptoasymsm9Cluster,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Cluster::sum(self : Cryptoasymsm9Cluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Cluster::mean(self : Cryptoasymsm9Cluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Cluster::scale(
  self : Cryptoasymsm9Cluster,
  f : Double,
) -> Cryptoasymsm9Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Cluster::add(
  self : Cryptoasymsm9Cluster,
  other : Cryptoasymsm9Cluster,
) -> Cryptoasymsm9Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Cluster::copy(
  self : Cryptoasymsm9Cluster,
) -> Cryptoasymsm9Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Cluster::fill(
  self : Cryptoasymsm9Cluster,
  v : Double,
) -> Cryptoasymsm9Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Cluster::min(self : Cryptoasymsm9Cluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Cluster::max(self : Cryptoasymsm9Cluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Cluster::to_string(self : Cryptoasymsm9Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9Model {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_model_make(size : Int32) -> Cryptoasymsm9Model {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Model::len(self : Cryptoasymsm9Model) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Model::get(self : Cryptoasymsm9Model, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Model::set(
  self : Cryptoasymsm9Model,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Model::sum(self : Cryptoasymsm9Model) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Model::mean(self : Cryptoasymsm9Model) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Model::scale(
  self : Cryptoasymsm9Model,
  f : Double,
) -> Cryptoasymsm9Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Model::add(
  self : Cryptoasymsm9Model,
  other : Cryptoasymsm9Model,
) -> Cryptoasymsm9Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Model::copy(
  self : Cryptoasymsm9Model,
) -> Cryptoasymsm9Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Model::fill(
  self : Cryptoasymsm9Model,
  v : Double,
) -> Cryptoasymsm9Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Model::min(self : Cryptoasymsm9Model) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Model::max(self : Cryptoasymsm9Model) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Model::to_string(self : Cryptoasymsm9Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9Layer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_layer_make(size : Int32) -> Cryptoasymsm9Layer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Layer::len(self : Cryptoasymsm9Layer) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Layer::get(self : Cryptoasymsm9Layer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Layer::set(
  self : Cryptoasymsm9Layer,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Layer::sum(self : Cryptoasymsm9Layer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Layer::mean(self : Cryptoasymsm9Layer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Layer::scale(
  self : Cryptoasymsm9Layer,
  f : Double,
) -> Cryptoasymsm9Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Layer::add(
  self : Cryptoasymsm9Layer,
  other : Cryptoasymsm9Layer,
) -> Cryptoasymsm9Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Layer::copy(
  self : Cryptoasymsm9Layer,
) -> Cryptoasymsm9Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Layer::fill(
  self : Cryptoasymsm9Layer,
  v : Double,
) -> Cryptoasymsm9Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Layer::min(self : Cryptoasymsm9Layer) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Layer::max(self : Cryptoasymsm9Layer) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Layer::to_string(self : Cryptoasymsm9Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9Buffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_buffer_make(size : Int32) -> Cryptoasymsm9Buffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Buffer::len(self : Cryptoasymsm9Buffer) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Buffer::get(
  self : Cryptoasymsm9Buffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Buffer::set(
  self : Cryptoasymsm9Buffer,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Buffer::sum(self : Cryptoasymsm9Buffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Buffer::mean(self : Cryptoasymsm9Buffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Buffer::scale(
  self : Cryptoasymsm9Buffer,
  f : Double,
) -> Cryptoasymsm9Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Buffer::add(
  self : Cryptoasymsm9Buffer,
  other : Cryptoasymsm9Buffer,
) -> Cryptoasymsm9Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Buffer::copy(
  self : Cryptoasymsm9Buffer,
) -> Cryptoasymsm9Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Buffer::fill(
  self : Cryptoasymsm9Buffer,
  v : Double,
) -> Cryptoasymsm9Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Buffer::min(self : Cryptoasymsm9Buffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Buffer::max(self : Cryptoasymsm9Buffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Buffer::to_string(self : Cryptoasymsm9Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9Cursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_cursor_make(size : Int32) -> Cryptoasymsm9Cursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Cursor::len(self : Cryptoasymsm9Cursor) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Cursor::get(
  self : Cryptoasymsm9Cursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Cursor::set(
  self : Cryptoasymsm9Cursor,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Cursor::sum(self : Cryptoasymsm9Cursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Cursor::mean(self : Cryptoasymsm9Cursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Cursor::scale(
  self : Cryptoasymsm9Cursor,
  f : Double,
) -> Cryptoasymsm9Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Cursor::add(
  self : Cryptoasymsm9Cursor,
  other : Cryptoasymsm9Cursor,
) -> Cryptoasymsm9Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Cursor::copy(
  self : Cryptoasymsm9Cursor,
) -> Cryptoasymsm9Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Cursor::fill(
  self : Cryptoasymsm9Cursor,
  v : Double,
) -> Cryptoasymsm9Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Cursor::min(self : Cryptoasymsm9Cursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Cursor::max(self : Cryptoasymsm9Cursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Cursor::to_string(self : Cryptoasymsm9Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9View {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_view_make(size : Int32) -> Cryptoasymsm9View {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9View::len(self : Cryptoasymsm9View) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9View::get(self : Cryptoasymsm9View, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9View::set(
  self : Cryptoasymsm9View,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9View::sum(self : Cryptoasymsm9View) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9View::mean(self : Cryptoasymsm9View) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9View::scale(
  self : Cryptoasymsm9View,
  f : Double,
) -> Cryptoasymsm9View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9View::add(
  self : Cryptoasymsm9View,
  other : Cryptoasymsm9View,
) -> Cryptoasymsm9View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9View::copy(self : Cryptoasymsm9View) -> Cryptoasymsm9View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9View::fill(
  self : Cryptoasymsm9View,
  v : Double,
) -> Cryptoasymsm9View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9View::min(self : Cryptoasymsm9View) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9View::max(self : Cryptoasymsm9View) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9View::to_string(self : Cryptoasymsm9View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9Range {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_range_make(size : Int32) -> Cryptoasymsm9Range {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Range::len(self : Cryptoasymsm9Range) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Range::get(self : Cryptoasymsm9Range, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Range::set(
  self : Cryptoasymsm9Range,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Range::sum(self : Cryptoasymsm9Range) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Range::mean(self : Cryptoasymsm9Range) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Range::scale(
  self : Cryptoasymsm9Range,
  f : Double,
) -> Cryptoasymsm9Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Range::add(
  self : Cryptoasymsm9Range,
  other : Cryptoasymsm9Range,
) -> Cryptoasymsm9Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Range::copy(
  self : Cryptoasymsm9Range,
) -> Cryptoasymsm9Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Range::fill(
  self : Cryptoasymsm9Range,
  v : Double,
) -> Cryptoasymsm9Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Range::min(self : Cryptoasymsm9Range) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Range::max(self : Cryptoasymsm9Range) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Range::to_string(self : Cryptoasymsm9Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptoasymsm9Slice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_asym_sm9_slice_make(size : Int32) -> Cryptoasymsm9Slice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptoasymsm9Slice::len(self : Cryptoasymsm9Slice) -> Int32 {
  self.size
}

///|
pub fn Cryptoasymsm9Slice::get(self : Cryptoasymsm9Slice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptoasymsm9Slice::set(
  self : Cryptoasymsm9Slice,
  i : Int32,
  v : Double,
) -> Cryptoasymsm9Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Slice::sum(self : Cryptoasymsm9Slice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptoasymsm9Slice::mean(self : Cryptoasymsm9Slice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptoasymsm9Slice::scale(
  self : Cryptoasymsm9Slice,
  f : Double,
) -> Cryptoasymsm9Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Slice::add(
  self : Cryptoasymsm9Slice,
  other : Cryptoasymsm9Slice,
) -> Cryptoasymsm9Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Slice::copy(
  self : Cryptoasymsm9Slice,
) -> Cryptoasymsm9Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Slice::fill(
  self : Cryptoasymsm9Slice,
  v : Double,
) -> Cryptoasymsm9Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptoasymsm9Slice::min(self : Cryptoasymsm9Slice) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptoasymsm9Slice::max(self : Cryptoasymsm9Slice) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptoasymsm9Slice::to_string(self : Cryptoasymsm9Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
