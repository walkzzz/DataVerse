///|
///===
/// extcore/crypto_hash_md5
pub(all) struct Cryptohashmd5Point {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn crypto_hash_md5_make_point(x : Double, y : Double) -> Cryptohashmd5Point {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn crypto_hash_md5_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> Cryptohashmd5Point {
  { x, y, z, label: 0, }
}

///|
pub fn Cryptohashmd5Point::x(self : Cryptohashmd5Point) -> Double {
  self.x
}

///|
pub fn Cryptohashmd5Point::y(self : Cryptohashmd5Point) -> Double {
  self.y
}

///|
pub fn Cryptohashmd5Point::z(self : Cryptohashmd5Point) -> Double {
  self.z
}

///|
pub fn Cryptohashmd5Point::label(self : Cryptohashmd5Point) -> Int32 {
  self.label
}

///|
pub fn Cryptohashmd5Point::dist(
  self : Cryptohashmd5Point,
  other : Cryptohashmd5Point,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn Cryptohashmd5Point::add(
  self : Cryptohashmd5Point,
  other : Cryptohashmd5Point,
) -> Cryptohashmd5Point {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn Cryptohashmd5Point::sub(
  self : Cryptohashmd5Point,
  other : Cryptohashmd5Point,
) -> Cryptohashmd5Point {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn Cryptohashmd5Point::scale(
  self : Cryptohashmd5Point,
  s : Double,
) -> Cryptohashmd5Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn Cryptohashmd5Point::dot(
  self : Cryptohashmd5Point,
  other : Cryptohashmd5Point,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn Cryptohashmd5Point::cross(
  self : Cryptohashmd5Point,
  other : Cryptohashmd5Point,
) -> Cryptohashmd5Point {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn Cryptohashmd5Point::norm(self : Cryptohashmd5Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn Cryptohashmd5Point::normalize(
  self : Cryptohashmd5Point,
) -> Cryptohashmd5Point {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Cryptohashmd5Point::negate(
  self : Cryptohashmd5Point,
) -> Cryptohashmd5Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn Cryptohashmd5Point::mid(
  self : Cryptohashmd5Point,
  other : Cryptohashmd5Point,
) -> Cryptohashmd5Point {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn Cryptohashmd5Point::lerp(
  self : Cryptohashmd5Point,
  other : Cryptohashmd5Point,
  t : Double,
) -> Cryptohashmd5Point {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn Cryptohashmd5Point::to_string(self : Cryptohashmd5Point) -> String {
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
pub(all) struct Cryptohashmd5Series {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn crypto_hash_md5_make_series(
  vals : Array[Double],
  name : String,
) -> Cryptohashmd5Series {
  { vals, name, meta: 0, }
}

///|
pub fn Cryptohashmd5Series::len(self : Cryptohashmd5Series) -> Int32 {
  self.vals.length()
}

///|
pub fn Cryptohashmd5Series::sum(self : Cryptohashmd5Series) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn Cryptohashmd5Series::mean(self : Cryptohashmd5Series) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn Cryptohashmd5Series::min(self : Cryptohashmd5Series) -> Double {
  @_common.min(self.vals)
}

///|
pub fn Cryptohashmd5Series::max(self : Cryptohashmd5Series) -> Double {
  @_common.max(self.vals)
}

///|
pub fn Cryptohashmd5Series::range(self : Cryptohashmd5Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn Cryptohashmd5Series::variance(self : Cryptohashmd5Series) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn Cryptohashmd5Series::std(self : Cryptohashmd5Series) -> Double {
  @_common.std(self.vals)
}

///|
pub fn Cryptohashmd5Series::median(self : Cryptohashmd5Series) -> Double {
  @_common.median(self.vals)
}

///|
pub fn Cryptohashmd5Series::scale(
  self : Cryptohashmd5Series,
  f : Double,
) -> Cryptohashmd5Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn Cryptohashmd5Series::add(
  self : Cryptohashmd5Series,
  other : Cryptohashmd5Series,
) -> Cryptohashmd5Series {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Cryptohashmd5Series::sub(
  self : Cryptohashmd5Series,
  other : Cryptohashmd5Series,
) -> Cryptohashmd5Series {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Cryptohashmd5Series::normalize(
  self : Cryptohashmd5Series,
) -> Cryptohashmd5Series {
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
pub fn Cryptohashmd5Series::cumsum(
  self : Cryptohashmd5Series,
) -> Cryptohashmd5Series {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn Cryptohashmd5Series::to_string(self : Cryptohashmd5Series) -> String {
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
pub(all) struct Cryptohashmd5Matrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn crypto_hash_md5_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Cryptohashmd5Matrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn crypto_hash_md5_matrix_identity(n : Int32) -> Cryptohashmd5Matrix {
  let m = crypto_hash_md5_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn Cryptohashmd5Matrix::get(
  self : Cryptohashmd5Matrix,
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
pub fn Cryptohashmd5Matrix::transpose(
  self : Cryptohashmd5Matrix,
) -> Cryptohashmd5Matrix {
  let result = crypto_hash_md5_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn Cryptohashmd5Matrix::add(
  self : Cryptohashmd5Matrix,
  other : Cryptohashmd5Matrix,
) -> Cryptohashmd5Matrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = crypto_hash_md5_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn Cryptohashmd5Matrix::scale(
  self : Cryptohashmd5Matrix,
  s : Double,
) -> Cryptohashmd5Matrix {
  let result = crypto_hash_md5_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn Cryptohashmd5Matrix::multiply(
  self : Cryptohashmd5Matrix,
  other : Cryptohashmd5Matrix,
) -> Cryptohashmd5Matrix {
  if self.cols != other.rows {
    return crypto_hash_md5_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = crypto_hash_md5_make_matrix(self.rows, other.cols, 0.0)
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
pub fn Cryptohashmd5Matrix::trace(self : Cryptohashmd5Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn Cryptohashmd5Matrix::det(self : Cryptohashmd5Matrix) -> Double {
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
pub fn Cryptohashmd5Matrix::norm(self : Cryptohashmd5Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn Cryptohashmd5Matrix::to_string(self : Cryptohashmd5Matrix) -> String {
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
pub(all) struct Cryptohashmd5Vector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn crypto_hash_md5_make_vector(
  comps : Array[Double],
) -> Cryptohashmd5Vector {
  { comps, dim: comps.length(), }
}

///|
pub fn crypto_hash_md5_vector_zero(dim : Int32) -> Cryptohashmd5Vector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn Cryptohashmd5Vector::add(
  self : Cryptohashmd5Vector,
  other : Cryptohashmd5Vector,
) -> Cryptohashmd5Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Cryptohashmd5Vector::sub(
  self : Cryptohashmd5Vector,
  other : Cryptohashmd5Vector,
) -> Cryptohashmd5Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Cryptohashmd5Vector::scale(
  self : Cryptohashmd5Vector,
  s : Double,
) -> Cryptohashmd5Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn Cryptohashmd5Vector::dot(
  self : Cryptohashmd5Vector,
  other : Cryptohashmd5Vector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn Cryptohashmd5Vector::norm(self : Cryptohashmd5Vector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn Cryptohashmd5Vector::normalize(
  self : Cryptohashmd5Vector,
) -> Cryptohashmd5Vector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Cryptohashmd5Vector::dist(
  self : Cryptohashmd5Vector,
  other : Cryptohashmd5Vector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn Cryptohashmd5Vector::to_string(self : Cryptohashmd5Vector) -> String {
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
pub(all) struct Cryptohashmd5Frame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_frame_make(size : Int32) -> Cryptohashmd5Frame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Frame::len(self : Cryptohashmd5Frame) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Frame::get(self : Cryptohashmd5Frame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Frame::set(
  self : Cryptohashmd5Frame,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Frame::sum(self : Cryptohashmd5Frame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Frame::mean(self : Cryptohashmd5Frame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Frame::scale(
  self : Cryptohashmd5Frame,
  f : Double,
) -> Cryptohashmd5Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Frame::add(
  self : Cryptohashmd5Frame,
  other : Cryptohashmd5Frame,
) -> Cryptohashmd5Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Frame::copy(
  self : Cryptohashmd5Frame,
) -> Cryptohashmd5Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Frame::fill(
  self : Cryptohashmd5Frame,
  v : Double,
) -> Cryptohashmd5Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Frame::min(self : Cryptohashmd5Frame) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Frame::max(self : Cryptohashmd5Frame) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Frame::to_string(self : Cryptohashmd5Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5Table {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_table_make(size : Int32) -> Cryptohashmd5Table {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Table::len(self : Cryptohashmd5Table) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Table::get(self : Cryptohashmd5Table, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Table::set(
  self : Cryptohashmd5Table,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Table::sum(self : Cryptohashmd5Table) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Table::mean(self : Cryptohashmd5Table) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Table::scale(
  self : Cryptohashmd5Table,
  f : Double,
) -> Cryptohashmd5Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Table::add(
  self : Cryptohashmd5Table,
  other : Cryptohashmd5Table,
) -> Cryptohashmd5Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Table::copy(
  self : Cryptohashmd5Table,
) -> Cryptohashmd5Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Table::fill(
  self : Cryptohashmd5Table,
  v : Double,
) -> Cryptohashmd5Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Table::min(self : Cryptohashmd5Table) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Table::max(self : Cryptohashmd5Table) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Table::to_string(self : Cryptohashmd5Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5GraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_graphn_make(size : Int32) -> Cryptohashmd5GraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5GraphN::len(self : Cryptohashmd5GraphN) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5GraphN::get(
  self : Cryptohashmd5GraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5GraphN::set(
  self : Cryptohashmd5GraphN,
  i : Int32,
  v : Double,
) -> Cryptohashmd5GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5GraphN::sum(self : Cryptohashmd5GraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5GraphN::mean(self : Cryptohashmd5GraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5GraphN::scale(
  self : Cryptohashmd5GraphN,
  f : Double,
) -> Cryptohashmd5GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5GraphN::add(
  self : Cryptohashmd5GraphN,
  other : Cryptohashmd5GraphN,
) -> Cryptohashmd5GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5GraphN::copy(
  self : Cryptohashmd5GraphN,
) -> Cryptohashmd5GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5GraphN::fill(
  self : Cryptohashmd5GraphN,
  v : Double,
) -> Cryptohashmd5GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5GraphN::min(self : Cryptohashmd5GraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5GraphN::max(self : Cryptohashmd5GraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5GraphN::to_string(self : Cryptohashmd5GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5Node {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_node_make(size : Int32) -> Cryptohashmd5Node {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Node::len(self : Cryptohashmd5Node) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Node::get(self : Cryptohashmd5Node, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Node::set(
  self : Cryptohashmd5Node,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Node::sum(self : Cryptohashmd5Node) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Node::mean(self : Cryptohashmd5Node) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Node::scale(
  self : Cryptohashmd5Node,
  f : Double,
) -> Cryptohashmd5Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Node::add(
  self : Cryptohashmd5Node,
  other : Cryptohashmd5Node,
) -> Cryptohashmd5Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Node::copy(self : Cryptohashmd5Node) -> Cryptohashmd5Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Node::fill(
  self : Cryptohashmd5Node,
  v : Double,
) -> Cryptohashmd5Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Node::min(self : Cryptohashmd5Node) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Node::max(self : Cryptohashmd5Node) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Node::to_string(self : Cryptohashmd5Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5Edge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_edge_make(size : Int32) -> Cryptohashmd5Edge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Edge::len(self : Cryptohashmd5Edge) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Edge::get(self : Cryptohashmd5Edge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Edge::set(
  self : Cryptohashmd5Edge,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Edge::sum(self : Cryptohashmd5Edge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Edge::mean(self : Cryptohashmd5Edge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Edge::scale(
  self : Cryptohashmd5Edge,
  f : Double,
) -> Cryptohashmd5Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Edge::add(
  self : Cryptohashmd5Edge,
  other : Cryptohashmd5Edge,
) -> Cryptohashmd5Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Edge::copy(self : Cryptohashmd5Edge) -> Cryptohashmd5Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Edge::fill(
  self : Cryptohashmd5Edge,
  v : Double,
) -> Cryptohashmd5Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Edge::min(self : Cryptohashmd5Edge) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Edge::max(self : Cryptohashmd5Edge) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Edge::to_string(self : Cryptohashmd5Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5Path {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_path_make(size : Int32) -> Cryptohashmd5Path {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Path::len(self : Cryptohashmd5Path) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Path::get(self : Cryptohashmd5Path, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Path::set(
  self : Cryptohashmd5Path,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Path::sum(self : Cryptohashmd5Path) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Path::mean(self : Cryptohashmd5Path) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Path::scale(
  self : Cryptohashmd5Path,
  f : Double,
) -> Cryptohashmd5Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Path::add(
  self : Cryptohashmd5Path,
  other : Cryptohashmd5Path,
) -> Cryptohashmd5Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Path::copy(self : Cryptohashmd5Path) -> Cryptohashmd5Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Path::fill(
  self : Cryptohashmd5Path,
  v : Double,
) -> Cryptohashmd5Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Path::min(self : Cryptohashmd5Path) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Path::max(self : Cryptohashmd5Path) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Path::to_string(self : Cryptohashmd5Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5Cluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_cluster_make(size : Int32) -> Cryptohashmd5Cluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Cluster::len(self : Cryptohashmd5Cluster) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Cluster::get(
  self : Cryptohashmd5Cluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Cluster::set(
  self : Cryptohashmd5Cluster,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Cluster::sum(self : Cryptohashmd5Cluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Cluster::mean(self : Cryptohashmd5Cluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Cluster::scale(
  self : Cryptohashmd5Cluster,
  f : Double,
) -> Cryptohashmd5Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Cluster::add(
  self : Cryptohashmd5Cluster,
  other : Cryptohashmd5Cluster,
) -> Cryptohashmd5Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Cluster::copy(
  self : Cryptohashmd5Cluster,
) -> Cryptohashmd5Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Cluster::fill(
  self : Cryptohashmd5Cluster,
  v : Double,
) -> Cryptohashmd5Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Cluster::min(self : Cryptohashmd5Cluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Cluster::max(self : Cryptohashmd5Cluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Cluster::to_string(self : Cryptohashmd5Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5Model {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_model_make(size : Int32) -> Cryptohashmd5Model {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Model::len(self : Cryptohashmd5Model) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Model::get(self : Cryptohashmd5Model, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Model::set(
  self : Cryptohashmd5Model,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Model::sum(self : Cryptohashmd5Model) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Model::mean(self : Cryptohashmd5Model) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Model::scale(
  self : Cryptohashmd5Model,
  f : Double,
) -> Cryptohashmd5Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Model::add(
  self : Cryptohashmd5Model,
  other : Cryptohashmd5Model,
) -> Cryptohashmd5Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Model::copy(
  self : Cryptohashmd5Model,
) -> Cryptohashmd5Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Model::fill(
  self : Cryptohashmd5Model,
  v : Double,
) -> Cryptohashmd5Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Model::min(self : Cryptohashmd5Model) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Model::max(self : Cryptohashmd5Model) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Model::to_string(self : Cryptohashmd5Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5Layer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_layer_make(size : Int32) -> Cryptohashmd5Layer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Layer::len(self : Cryptohashmd5Layer) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Layer::get(self : Cryptohashmd5Layer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Layer::set(
  self : Cryptohashmd5Layer,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Layer::sum(self : Cryptohashmd5Layer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Layer::mean(self : Cryptohashmd5Layer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Layer::scale(
  self : Cryptohashmd5Layer,
  f : Double,
) -> Cryptohashmd5Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Layer::add(
  self : Cryptohashmd5Layer,
  other : Cryptohashmd5Layer,
) -> Cryptohashmd5Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Layer::copy(
  self : Cryptohashmd5Layer,
) -> Cryptohashmd5Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Layer::fill(
  self : Cryptohashmd5Layer,
  v : Double,
) -> Cryptohashmd5Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Layer::min(self : Cryptohashmd5Layer) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Layer::max(self : Cryptohashmd5Layer) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Layer::to_string(self : Cryptohashmd5Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5Buffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_buffer_make(size : Int32) -> Cryptohashmd5Buffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Buffer::len(self : Cryptohashmd5Buffer) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Buffer::get(
  self : Cryptohashmd5Buffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Buffer::set(
  self : Cryptohashmd5Buffer,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Buffer::sum(self : Cryptohashmd5Buffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Buffer::mean(self : Cryptohashmd5Buffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Buffer::scale(
  self : Cryptohashmd5Buffer,
  f : Double,
) -> Cryptohashmd5Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Buffer::add(
  self : Cryptohashmd5Buffer,
  other : Cryptohashmd5Buffer,
) -> Cryptohashmd5Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Buffer::copy(
  self : Cryptohashmd5Buffer,
) -> Cryptohashmd5Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Buffer::fill(
  self : Cryptohashmd5Buffer,
  v : Double,
) -> Cryptohashmd5Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Buffer::min(self : Cryptohashmd5Buffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Buffer::max(self : Cryptohashmd5Buffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Buffer::to_string(self : Cryptohashmd5Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5Cursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_cursor_make(size : Int32) -> Cryptohashmd5Cursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Cursor::len(self : Cryptohashmd5Cursor) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Cursor::get(
  self : Cryptohashmd5Cursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Cursor::set(
  self : Cryptohashmd5Cursor,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Cursor::sum(self : Cryptohashmd5Cursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Cursor::mean(self : Cryptohashmd5Cursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Cursor::scale(
  self : Cryptohashmd5Cursor,
  f : Double,
) -> Cryptohashmd5Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Cursor::add(
  self : Cryptohashmd5Cursor,
  other : Cryptohashmd5Cursor,
) -> Cryptohashmd5Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Cursor::copy(
  self : Cryptohashmd5Cursor,
) -> Cryptohashmd5Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Cursor::fill(
  self : Cryptohashmd5Cursor,
  v : Double,
) -> Cryptohashmd5Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Cursor::min(self : Cryptohashmd5Cursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Cursor::max(self : Cryptohashmd5Cursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Cursor::to_string(self : Cryptohashmd5Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5View {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_view_make(size : Int32) -> Cryptohashmd5View {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5View::len(self : Cryptohashmd5View) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5View::get(self : Cryptohashmd5View, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5View::set(
  self : Cryptohashmd5View,
  i : Int32,
  v : Double,
) -> Cryptohashmd5View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5View::sum(self : Cryptohashmd5View) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5View::mean(self : Cryptohashmd5View) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5View::scale(
  self : Cryptohashmd5View,
  f : Double,
) -> Cryptohashmd5View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5View::add(
  self : Cryptohashmd5View,
  other : Cryptohashmd5View,
) -> Cryptohashmd5View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5View::copy(self : Cryptohashmd5View) -> Cryptohashmd5View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5View::fill(
  self : Cryptohashmd5View,
  v : Double,
) -> Cryptohashmd5View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5View::min(self : Cryptohashmd5View) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5View::max(self : Cryptohashmd5View) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5View::to_string(self : Cryptohashmd5View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5Range {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_range_make(size : Int32) -> Cryptohashmd5Range {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Range::len(self : Cryptohashmd5Range) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Range::get(self : Cryptohashmd5Range, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Range::set(
  self : Cryptohashmd5Range,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Range::sum(self : Cryptohashmd5Range) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Range::mean(self : Cryptohashmd5Range) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Range::scale(
  self : Cryptohashmd5Range,
  f : Double,
) -> Cryptohashmd5Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Range::add(
  self : Cryptohashmd5Range,
  other : Cryptohashmd5Range,
) -> Cryptohashmd5Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Range::copy(
  self : Cryptohashmd5Range,
) -> Cryptohashmd5Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Range::fill(
  self : Cryptohashmd5Range,
  v : Double,
) -> Cryptohashmd5Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Range::min(self : Cryptohashmd5Range) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Range::max(self : Cryptohashmd5Range) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Range::to_string(self : Cryptohashmd5Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Cryptohashmd5Slice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_hash_md5_slice_make(size : Int32) -> Cryptohashmd5Slice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Cryptohashmd5Slice::len(self : Cryptohashmd5Slice) -> Int32 {
  self.size
}

///|
pub fn Cryptohashmd5Slice::get(self : Cryptohashmd5Slice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Cryptohashmd5Slice::set(
  self : Cryptohashmd5Slice,
  i : Int32,
  v : Double,
) -> Cryptohashmd5Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Slice::sum(self : Cryptohashmd5Slice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Cryptohashmd5Slice::mean(self : Cryptohashmd5Slice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Cryptohashmd5Slice::scale(
  self : Cryptohashmd5Slice,
  f : Double,
) -> Cryptohashmd5Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Slice::add(
  self : Cryptohashmd5Slice,
  other : Cryptohashmd5Slice,
) -> Cryptohashmd5Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Slice::copy(
  self : Cryptohashmd5Slice,
) -> Cryptohashmd5Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Slice::fill(
  self : Cryptohashmd5Slice,
  v : Double,
) -> Cryptohashmd5Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Cryptohashmd5Slice::min(self : Cryptohashmd5Slice) -> Double {
  @_common.min(self.data)
}

///|
pub fn Cryptohashmd5Slice::max(self : Cryptohashmd5Slice) -> Double {
  @_common.max(self.data)
}

///|
pub fn Cryptohashmd5Slice::to_string(self : Cryptohashmd5Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
