///|
///===
/// extcore/math_special_elliptic
pub(all) struct MathspecialellipticPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn math_special_elliptic_make_point(
  x : Double,
  y : Double,
) -> MathspecialellipticPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn math_special_elliptic_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MathspecialellipticPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MathspecialellipticPoint::x(self : MathspecialellipticPoint) -> Double {
  self.x
}

///|
pub fn MathspecialellipticPoint::y(self : MathspecialellipticPoint) -> Double {
  self.y
}

///|
pub fn MathspecialellipticPoint::z(self : MathspecialellipticPoint) -> Double {
  self.z
}

///|
pub fn MathspecialellipticPoint::label(
  self : MathspecialellipticPoint,
) -> Int32 {
  self.label
}

///|
pub fn MathspecialellipticPoint::dist(
  self : MathspecialellipticPoint,
  other : MathspecialellipticPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MathspecialellipticPoint::add(
  self : MathspecialellipticPoint,
  other : MathspecialellipticPoint,
) -> MathspecialellipticPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MathspecialellipticPoint::sub(
  self : MathspecialellipticPoint,
  other : MathspecialellipticPoint,
) -> MathspecialellipticPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MathspecialellipticPoint::scale(
  self : MathspecialellipticPoint,
  s : Double,
) -> MathspecialellipticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MathspecialellipticPoint::dot(
  self : MathspecialellipticPoint,
  other : MathspecialellipticPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MathspecialellipticPoint::cross(
  self : MathspecialellipticPoint,
  other : MathspecialellipticPoint,
) -> MathspecialellipticPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MathspecialellipticPoint::norm(
  self : MathspecialellipticPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MathspecialellipticPoint::normalize(
  self : MathspecialellipticPoint,
) -> MathspecialellipticPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathspecialellipticPoint::negate(
  self : MathspecialellipticPoint,
) -> MathspecialellipticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MathspecialellipticPoint::mid(
  self : MathspecialellipticPoint,
  other : MathspecialellipticPoint,
) -> MathspecialellipticPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MathspecialellipticPoint::lerp(
  self : MathspecialellipticPoint,
  other : MathspecialellipticPoint,
  t : Double,
) -> MathspecialellipticPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MathspecialellipticPoint::to_string(
  self : MathspecialellipticPoint,
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
pub(all) struct MathspecialellipticSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn math_special_elliptic_make_series(
  vals : Array[Double],
  name : String,
) -> MathspecialellipticSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MathspecialellipticSeries::len(
  self : MathspecialellipticSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn MathspecialellipticSeries::sum(
  self : MathspecialellipticSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MathspecialellipticSeries::mean(
  self : MathspecialellipticSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MathspecialellipticSeries::min(
  self : MathspecialellipticSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MathspecialellipticSeries::max(
  self : MathspecialellipticSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MathspecialellipticSeries::range(
  self : MathspecialellipticSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MathspecialellipticSeries::variance(
  self : MathspecialellipticSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MathspecialellipticSeries::std(
  self : MathspecialellipticSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MathspecialellipticSeries::median(
  self : MathspecialellipticSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MathspecialellipticSeries::scale(
  self : MathspecialellipticSeries,
  f : Double,
) -> MathspecialellipticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MathspecialellipticSeries::add(
  self : MathspecialellipticSeries,
  other : MathspecialellipticSeries,
) -> MathspecialellipticSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathspecialellipticSeries::sub(
  self : MathspecialellipticSeries,
  other : MathspecialellipticSeries,
) -> MathspecialellipticSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathspecialellipticSeries::normalize(
  self : MathspecialellipticSeries,
) -> MathspecialellipticSeries {
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
pub fn MathspecialellipticSeries::cumsum(
  self : MathspecialellipticSeries,
) -> MathspecialellipticSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MathspecialellipticSeries::to_string(
  self : MathspecialellipticSeries,
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
pub(all) struct MathspecialellipticMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn math_special_elliptic_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MathspecialellipticMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn math_special_elliptic_matrix_identity(
  n : Int32,
) -> MathspecialellipticMatrix {
  let m = math_special_elliptic_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MathspecialellipticMatrix::get(
  self : MathspecialellipticMatrix,
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
pub fn MathspecialellipticMatrix::transpose(
  self : MathspecialellipticMatrix,
) -> MathspecialellipticMatrix {
  let result = math_special_elliptic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MathspecialellipticMatrix::add(
  self : MathspecialellipticMatrix,
  other : MathspecialellipticMatrix,
) -> MathspecialellipticMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = math_special_elliptic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MathspecialellipticMatrix::scale(
  self : MathspecialellipticMatrix,
  s : Double,
) -> MathspecialellipticMatrix {
  let result = math_special_elliptic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MathspecialellipticMatrix::multiply(
  self : MathspecialellipticMatrix,
  other : MathspecialellipticMatrix,
) -> MathspecialellipticMatrix {
  if self.cols != other.rows {
    return math_special_elliptic_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = math_special_elliptic_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MathspecialellipticMatrix::trace(
  self : MathspecialellipticMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MathspecialellipticMatrix::det(
  self : MathspecialellipticMatrix,
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
pub fn MathspecialellipticMatrix::norm(
  self : MathspecialellipticMatrix,
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
pub fn MathspecialellipticMatrix::to_string(
  self : MathspecialellipticMatrix,
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
pub(all) struct MathspecialellipticVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn math_special_elliptic_make_vector(
  comps : Array[Double],
) -> MathspecialellipticVector {
  { comps, dim: comps.length(), }
}

///|
pub fn math_special_elliptic_vector_zero(
  dim : Int32,
) -> MathspecialellipticVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MathspecialellipticVector::add(
  self : MathspecialellipticVector,
  other : MathspecialellipticVector,
) -> MathspecialellipticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathspecialellipticVector::sub(
  self : MathspecialellipticVector,
  other : MathspecialellipticVector,
) -> MathspecialellipticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathspecialellipticVector::scale(
  self : MathspecialellipticVector,
  s : Double,
) -> MathspecialellipticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MathspecialellipticVector::dot(
  self : MathspecialellipticVector,
  other : MathspecialellipticVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MathspecialellipticVector::norm(
  self : MathspecialellipticVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MathspecialellipticVector::normalize(
  self : MathspecialellipticVector,
) -> MathspecialellipticVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathspecialellipticVector::dist(
  self : MathspecialellipticVector,
  other : MathspecialellipticVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MathspecialellipticVector::to_string(
  self : MathspecialellipticVector,
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
pub(all) struct MathspecialellipticFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_frame_make(
  size : Int32,
) -> MathspecialellipticFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticFrame::len(self : MathspecialellipticFrame) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticFrame::get(
  self : MathspecialellipticFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticFrame::set(
  self : MathspecialellipticFrame,
  i : Int32,
  v : Double,
) -> MathspecialellipticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticFrame::sum(self : MathspecialellipticFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticFrame::mean(
  self : MathspecialellipticFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticFrame::scale(
  self : MathspecialellipticFrame,
  f : Double,
) -> MathspecialellipticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticFrame::add(
  self : MathspecialellipticFrame,
  other : MathspecialellipticFrame,
) -> MathspecialellipticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticFrame::copy(
  self : MathspecialellipticFrame,
) -> MathspecialellipticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticFrame::fill(
  self : MathspecialellipticFrame,
  v : Double,
) -> MathspecialellipticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticFrame::min(self : MathspecialellipticFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticFrame::max(self : MathspecialellipticFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticFrame::to_string(
  self : MathspecialellipticFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_table_make(
  size : Int32,
) -> MathspecialellipticTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticTable::len(self : MathspecialellipticTable) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticTable::get(
  self : MathspecialellipticTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticTable::set(
  self : MathspecialellipticTable,
  i : Int32,
  v : Double,
) -> MathspecialellipticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticTable::sum(self : MathspecialellipticTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticTable::mean(
  self : MathspecialellipticTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticTable::scale(
  self : MathspecialellipticTable,
  f : Double,
) -> MathspecialellipticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticTable::add(
  self : MathspecialellipticTable,
  other : MathspecialellipticTable,
) -> MathspecialellipticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticTable::copy(
  self : MathspecialellipticTable,
) -> MathspecialellipticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticTable::fill(
  self : MathspecialellipticTable,
  v : Double,
) -> MathspecialellipticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticTable::min(self : MathspecialellipticTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticTable::max(self : MathspecialellipticTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticTable::to_string(
  self : MathspecialellipticTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_graphn_make(
  size : Int32,
) -> MathspecialellipticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticGraphN::len(
  self : MathspecialellipticGraphN,
) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticGraphN::get(
  self : MathspecialellipticGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticGraphN::set(
  self : MathspecialellipticGraphN,
  i : Int32,
  v : Double,
) -> MathspecialellipticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticGraphN::sum(
  self : MathspecialellipticGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticGraphN::mean(
  self : MathspecialellipticGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticGraphN::scale(
  self : MathspecialellipticGraphN,
  f : Double,
) -> MathspecialellipticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticGraphN::add(
  self : MathspecialellipticGraphN,
  other : MathspecialellipticGraphN,
) -> MathspecialellipticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticGraphN::copy(
  self : MathspecialellipticGraphN,
) -> MathspecialellipticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticGraphN::fill(
  self : MathspecialellipticGraphN,
  v : Double,
) -> MathspecialellipticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticGraphN::min(
  self : MathspecialellipticGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticGraphN::max(
  self : MathspecialellipticGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticGraphN::to_string(
  self : MathspecialellipticGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_node_make(size : Int32) -> MathspecialellipticNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticNode::len(self : MathspecialellipticNode) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticNode::get(
  self : MathspecialellipticNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticNode::set(
  self : MathspecialellipticNode,
  i : Int32,
  v : Double,
) -> MathspecialellipticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticNode::sum(self : MathspecialellipticNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticNode::mean(self : MathspecialellipticNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticNode::scale(
  self : MathspecialellipticNode,
  f : Double,
) -> MathspecialellipticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticNode::add(
  self : MathspecialellipticNode,
  other : MathspecialellipticNode,
) -> MathspecialellipticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticNode::copy(
  self : MathspecialellipticNode,
) -> MathspecialellipticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticNode::fill(
  self : MathspecialellipticNode,
  v : Double,
) -> MathspecialellipticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticNode::min(self : MathspecialellipticNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticNode::max(self : MathspecialellipticNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticNode::to_string(
  self : MathspecialellipticNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_edge_make(size : Int32) -> MathspecialellipticEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticEdge::len(self : MathspecialellipticEdge) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticEdge::get(
  self : MathspecialellipticEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticEdge::set(
  self : MathspecialellipticEdge,
  i : Int32,
  v : Double,
) -> MathspecialellipticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticEdge::sum(self : MathspecialellipticEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticEdge::mean(self : MathspecialellipticEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticEdge::scale(
  self : MathspecialellipticEdge,
  f : Double,
) -> MathspecialellipticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticEdge::add(
  self : MathspecialellipticEdge,
  other : MathspecialellipticEdge,
) -> MathspecialellipticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticEdge::copy(
  self : MathspecialellipticEdge,
) -> MathspecialellipticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticEdge::fill(
  self : MathspecialellipticEdge,
  v : Double,
) -> MathspecialellipticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticEdge::min(self : MathspecialellipticEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticEdge::max(self : MathspecialellipticEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticEdge::to_string(
  self : MathspecialellipticEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_path_make(size : Int32) -> MathspecialellipticPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticPath::len(self : MathspecialellipticPath) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticPath::get(
  self : MathspecialellipticPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticPath::set(
  self : MathspecialellipticPath,
  i : Int32,
  v : Double,
) -> MathspecialellipticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticPath::sum(self : MathspecialellipticPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticPath::mean(self : MathspecialellipticPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticPath::scale(
  self : MathspecialellipticPath,
  f : Double,
) -> MathspecialellipticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticPath::add(
  self : MathspecialellipticPath,
  other : MathspecialellipticPath,
) -> MathspecialellipticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticPath::copy(
  self : MathspecialellipticPath,
) -> MathspecialellipticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticPath::fill(
  self : MathspecialellipticPath,
  v : Double,
) -> MathspecialellipticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticPath::min(self : MathspecialellipticPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticPath::max(self : MathspecialellipticPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticPath::to_string(
  self : MathspecialellipticPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_cluster_make(
  size : Int32,
) -> MathspecialellipticCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticCluster::len(
  self : MathspecialellipticCluster,
) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticCluster::get(
  self : MathspecialellipticCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticCluster::set(
  self : MathspecialellipticCluster,
  i : Int32,
  v : Double,
) -> MathspecialellipticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticCluster::sum(
  self : MathspecialellipticCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticCluster::mean(
  self : MathspecialellipticCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticCluster::scale(
  self : MathspecialellipticCluster,
  f : Double,
) -> MathspecialellipticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticCluster::add(
  self : MathspecialellipticCluster,
  other : MathspecialellipticCluster,
) -> MathspecialellipticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticCluster::copy(
  self : MathspecialellipticCluster,
) -> MathspecialellipticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticCluster::fill(
  self : MathspecialellipticCluster,
  v : Double,
) -> MathspecialellipticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticCluster::min(
  self : MathspecialellipticCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticCluster::max(
  self : MathspecialellipticCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticCluster::to_string(
  self : MathspecialellipticCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_model_make(
  size : Int32,
) -> MathspecialellipticModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticModel::len(self : MathspecialellipticModel) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticModel::get(
  self : MathspecialellipticModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticModel::set(
  self : MathspecialellipticModel,
  i : Int32,
  v : Double,
) -> MathspecialellipticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticModel::sum(self : MathspecialellipticModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticModel::mean(
  self : MathspecialellipticModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticModel::scale(
  self : MathspecialellipticModel,
  f : Double,
) -> MathspecialellipticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticModel::add(
  self : MathspecialellipticModel,
  other : MathspecialellipticModel,
) -> MathspecialellipticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticModel::copy(
  self : MathspecialellipticModel,
) -> MathspecialellipticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticModel::fill(
  self : MathspecialellipticModel,
  v : Double,
) -> MathspecialellipticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticModel::min(self : MathspecialellipticModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticModel::max(self : MathspecialellipticModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticModel::to_string(
  self : MathspecialellipticModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_layer_make(
  size : Int32,
) -> MathspecialellipticLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticLayer::len(self : MathspecialellipticLayer) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticLayer::get(
  self : MathspecialellipticLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticLayer::set(
  self : MathspecialellipticLayer,
  i : Int32,
  v : Double,
) -> MathspecialellipticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticLayer::sum(self : MathspecialellipticLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticLayer::mean(
  self : MathspecialellipticLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticLayer::scale(
  self : MathspecialellipticLayer,
  f : Double,
) -> MathspecialellipticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticLayer::add(
  self : MathspecialellipticLayer,
  other : MathspecialellipticLayer,
) -> MathspecialellipticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticLayer::copy(
  self : MathspecialellipticLayer,
) -> MathspecialellipticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticLayer::fill(
  self : MathspecialellipticLayer,
  v : Double,
) -> MathspecialellipticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticLayer::min(self : MathspecialellipticLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticLayer::max(self : MathspecialellipticLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticLayer::to_string(
  self : MathspecialellipticLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_buffer_make(
  size : Int32,
) -> MathspecialellipticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticBuffer::len(
  self : MathspecialellipticBuffer,
) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticBuffer::get(
  self : MathspecialellipticBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticBuffer::set(
  self : MathspecialellipticBuffer,
  i : Int32,
  v : Double,
) -> MathspecialellipticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticBuffer::sum(
  self : MathspecialellipticBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticBuffer::mean(
  self : MathspecialellipticBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticBuffer::scale(
  self : MathspecialellipticBuffer,
  f : Double,
) -> MathspecialellipticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticBuffer::add(
  self : MathspecialellipticBuffer,
  other : MathspecialellipticBuffer,
) -> MathspecialellipticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticBuffer::copy(
  self : MathspecialellipticBuffer,
) -> MathspecialellipticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticBuffer::fill(
  self : MathspecialellipticBuffer,
  v : Double,
) -> MathspecialellipticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticBuffer::min(
  self : MathspecialellipticBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticBuffer::max(
  self : MathspecialellipticBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticBuffer::to_string(
  self : MathspecialellipticBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_cursor_make(
  size : Int32,
) -> MathspecialellipticCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticCursor::len(
  self : MathspecialellipticCursor,
) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticCursor::get(
  self : MathspecialellipticCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticCursor::set(
  self : MathspecialellipticCursor,
  i : Int32,
  v : Double,
) -> MathspecialellipticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticCursor::sum(
  self : MathspecialellipticCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticCursor::mean(
  self : MathspecialellipticCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticCursor::scale(
  self : MathspecialellipticCursor,
  f : Double,
) -> MathspecialellipticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticCursor::add(
  self : MathspecialellipticCursor,
  other : MathspecialellipticCursor,
) -> MathspecialellipticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticCursor::copy(
  self : MathspecialellipticCursor,
) -> MathspecialellipticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticCursor::fill(
  self : MathspecialellipticCursor,
  v : Double,
) -> MathspecialellipticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticCursor::min(
  self : MathspecialellipticCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticCursor::max(
  self : MathspecialellipticCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticCursor::to_string(
  self : MathspecialellipticCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_view_make(size : Int32) -> MathspecialellipticView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticView::len(self : MathspecialellipticView) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticView::get(
  self : MathspecialellipticView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticView::set(
  self : MathspecialellipticView,
  i : Int32,
  v : Double,
) -> MathspecialellipticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticView::sum(self : MathspecialellipticView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticView::mean(self : MathspecialellipticView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticView::scale(
  self : MathspecialellipticView,
  f : Double,
) -> MathspecialellipticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticView::add(
  self : MathspecialellipticView,
  other : MathspecialellipticView,
) -> MathspecialellipticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticView::copy(
  self : MathspecialellipticView,
) -> MathspecialellipticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticView::fill(
  self : MathspecialellipticView,
  v : Double,
) -> MathspecialellipticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticView::min(self : MathspecialellipticView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticView::max(self : MathspecialellipticView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticView::to_string(
  self : MathspecialellipticView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_range_make(
  size : Int32,
) -> MathspecialellipticRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticRange::len(self : MathspecialellipticRange) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticRange::get(
  self : MathspecialellipticRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticRange::set(
  self : MathspecialellipticRange,
  i : Int32,
  v : Double,
) -> MathspecialellipticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticRange::sum(self : MathspecialellipticRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticRange::mean(
  self : MathspecialellipticRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticRange::scale(
  self : MathspecialellipticRange,
  f : Double,
) -> MathspecialellipticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticRange::add(
  self : MathspecialellipticRange,
  other : MathspecialellipticRange,
) -> MathspecialellipticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticRange::copy(
  self : MathspecialellipticRange,
) -> MathspecialellipticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticRange::fill(
  self : MathspecialellipticRange,
  v : Double,
) -> MathspecialellipticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticRange::min(self : MathspecialellipticRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticRange::max(self : MathspecialellipticRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticRange::to_string(
  self : MathspecialellipticRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialellipticSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_elliptic_slice_make(
  size : Int32,
) -> MathspecialellipticSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialellipticSlice::len(self : MathspecialellipticSlice) -> Int32 {
  self.size
}

///|
pub fn MathspecialellipticSlice::get(
  self : MathspecialellipticSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialellipticSlice::set(
  self : MathspecialellipticSlice,
  i : Int32,
  v : Double,
) -> MathspecialellipticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticSlice::sum(self : MathspecialellipticSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialellipticSlice::mean(
  self : MathspecialellipticSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialellipticSlice::scale(
  self : MathspecialellipticSlice,
  f : Double,
) -> MathspecialellipticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticSlice::add(
  self : MathspecialellipticSlice,
  other : MathspecialellipticSlice,
) -> MathspecialellipticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialellipticSlice::copy(
  self : MathspecialellipticSlice,
) -> MathspecialellipticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticSlice::fill(
  self : MathspecialellipticSlice,
  v : Double,
) -> MathspecialellipticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialellipticSlice::min(self : MathspecialellipticSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialellipticSlice::max(self : MathspecialellipticSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialellipticSlice::to_string(
  self : MathspecialellipticSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
