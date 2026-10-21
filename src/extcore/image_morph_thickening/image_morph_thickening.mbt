///|
///===
/// extcore/image_morph_thickening
pub(all) struct ImagemorphthickeningPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn image_morph_thickening_make_point(
  x : Double,
  y : Double,
) -> ImagemorphthickeningPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn image_morph_thickening_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ImagemorphthickeningPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ImagemorphthickeningPoint::x(self : ImagemorphthickeningPoint) -> Double {
  self.x
}

///|
pub fn ImagemorphthickeningPoint::y(self : ImagemorphthickeningPoint) -> Double {
  self.y
}

///|
pub fn ImagemorphthickeningPoint::z(self : ImagemorphthickeningPoint) -> Double {
  self.z
}

///|
pub fn ImagemorphthickeningPoint::label(
  self : ImagemorphthickeningPoint,
) -> Int32 {
  self.label
}

///|
pub fn ImagemorphthickeningPoint::dist(
  self : ImagemorphthickeningPoint,
  other : ImagemorphthickeningPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ImagemorphthickeningPoint::add(
  self : ImagemorphthickeningPoint,
  other : ImagemorphthickeningPoint,
) -> ImagemorphthickeningPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ImagemorphthickeningPoint::sub(
  self : ImagemorphthickeningPoint,
  other : ImagemorphthickeningPoint,
) -> ImagemorphthickeningPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ImagemorphthickeningPoint::scale(
  self : ImagemorphthickeningPoint,
  s : Double,
) -> ImagemorphthickeningPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ImagemorphthickeningPoint::dot(
  self : ImagemorphthickeningPoint,
  other : ImagemorphthickeningPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ImagemorphthickeningPoint::cross(
  self : ImagemorphthickeningPoint,
  other : ImagemorphthickeningPoint,
) -> ImagemorphthickeningPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ImagemorphthickeningPoint::norm(
  self : ImagemorphthickeningPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ImagemorphthickeningPoint::normalize(
  self : ImagemorphthickeningPoint,
) -> ImagemorphthickeningPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagemorphthickeningPoint::negate(
  self : ImagemorphthickeningPoint,
) -> ImagemorphthickeningPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ImagemorphthickeningPoint::mid(
  self : ImagemorphthickeningPoint,
  other : ImagemorphthickeningPoint,
) -> ImagemorphthickeningPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ImagemorphthickeningPoint::lerp(
  self : ImagemorphthickeningPoint,
  other : ImagemorphthickeningPoint,
  t : Double,
) -> ImagemorphthickeningPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ImagemorphthickeningPoint::to_string(
  self : ImagemorphthickeningPoint,
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
pub(all) struct ImagemorphthickeningSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn image_morph_thickening_make_series(
  vals : Array[Double],
  name : String,
) -> ImagemorphthickeningSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ImagemorphthickeningSeries::len(
  self : ImagemorphthickeningSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn ImagemorphthickeningSeries::sum(
  self : ImagemorphthickeningSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ImagemorphthickeningSeries::mean(
  self : ImagemorphthickeningSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ImagemorphthickeningSeries::min(
  self : ImagemorphthickeningSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ImagemorphthickeningSeries::max(
  self : ImagemorphthickeningSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ImagemorphthickeningSeries::range(
  self : ImagemorphthickeningSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ImagemorphthickeningSeries::variance(
  self : ImagemorphthickeningSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ImagemorphthickeningSeries::std(
  self : ImagemorphthickeningSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ImagemorphthickeningSeries::median(
  self : ImagemorphthickeningSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ImagemorphthickeningSeries::scale(
  self : ImagemorphthickeningSeries,
  f : Double,
) -> ImagemorphthickeningSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ImagemorphthickeningSeries::add(
  self : ImagemorphthickeningSeries,
  other : ImagemorphthickeningSeries,
) -> ImagemorphthickeningSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagemorphthickeningSeries::sub(
  self : ImagemorphthickeningSeries,
  other : ImagemorphthickeningSeries,
) -> ImagemorphthickeningSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ImagemorphthickeningSeries::normalize(
  self : ImagemorphthickeningSeries,
) -> ImagemorphthickeningSeries {
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
pub fn ImagemorphthickeningSeries::cumsum(
  self : ImagemorphthickeningSeries,
) -> ImagemorphthickeningSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ImagemorphthickeningSeries::to_string(
  self : ImagemorphthickeningSeries,
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
pub(all) struct ImagemorphthickeningMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn image_morph_thickening_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ImagemorphthickeningMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn image_morph_thickening_matrix_identity(
  n : Int32,
) -> ImagemorphthickeningMatrix {
  let m = image_morph_thickening_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ImagemorphthickeningMatrix::get(
  self : ImagemorphthickeningMatrix,
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
pub fn ImagemorphthickeningMatrix::transpose(
  self : ImagemorphthickeningMatrix,
) -> ImagemorphthickeningMatrix {
  let result = image_morph_thickening_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ImagemorphthickeningMatrix::add(
  self : ImagemorphthickeningMatrix,
  other : ImagemorphthickeningMatrix,
) -> ImagemorphthickeningMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = image_morph_thickening_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ImagemorphthickeningMatrix::scale(
  self : ImagemorphthickeningMatrix,
  s : Double,
) -> ImagemorphthickeningMatrix {
  let result = image_morph_thickening_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ImagemorphthickeningMatrix::multiply(
  self : ImagemorphthickeningMatrix,
  other : ImagemorphthickeningMatrix,
) -> ImagemorphthickeningMatrix {
  if self.cols != other.rows {
    return image_morph_thickening_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = image_morph_thickening_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ImagemorphthickeningMatrix::trace(
  self : ImagemorphthickeningMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ImagemorphthickeningMatrix::det(
  self : ImagemorphthickeningMatrix,
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
pub fn ImagemorphthickeningMatrix::norm(
  self : ImagemorphthickeningMatrix,
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
pub fn ImagemorphthickeningMatrix::to_string(
  self : ImagemorphthickeningMatrix,
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
pub(all) struct ImagemorphthickeningVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn image_morph_thickening_make_vector(
  comps : Array[Double],
) -> ImagemorphthickeningVector {
  { comps, dim: comps.length(), }
}

///|
pub fn image_morph_thickening_vector_zero(
  dim : Int32,
) -> ImagemorphthickeningVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ImagemorphthickeningVector::add(
  self : ImagemorphthickeningVector,
  other : ImagemorphthickeningVector,
) -> ImagemorphthickeningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagemorphthickeningVector::sub(
  self : ImagemorphthickeningVector,
  other : ImagemorphthickeningVector,
) -> ImagemorphthickeningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ImagemorphthickeningVector::scale(
  self : ImagemorphthickeningVector,
  s : Double,
) -> ImagemorphthickeningVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ImagemorphthickeningVector::dot(
  self : ImagemorphthickeningVector,
  other : ImagemorphthickeningVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ImagemorphthickeningVector::norm(
  self : ImagemorphthickeningVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ImagemorphthickeningVector::normalize(
  self : ImagemorphthickeningVector,
) -> ImagemorphthickeningVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ImagemorphthickeningVector::dist(
  self : ImagemorphthickeningVector,
  other : ImagemorphthickeningVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ImagemorphthickeningVector::to_string(
  self : ImagemorphthickeningVector,
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
pub(all) struct ImagemorphthickeningFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_frame_make(
  size : Int32,
) -> ImagemorphthickeningFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningFrame::len(
  self : ImagemorphthickeningFrame,
) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningFrame::get(
  self : ImagemorphthickeningFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningFrame::set(
  self : ImagemorphthickeningFrame,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningFrame::sum(
  self : ImagemorphthickeningFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningFrame::mean(
  self : ImagemorphthickeningFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningFrame::scale(
  self : ImagemorphthickeningFrame,
  f : Double,
) -> ImagemorphthickeningFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningFrame::add(
  self : ImagemorphthickeningFrame,
  other : ImagemorphthickeningFrame,
) -> ImagemorphthickeningFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningFrame::copy(
  self : ImagemorphthickeningFrame,
) -> ImagemorphthickeningFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningFrame::fill(
  self : ImagemorphthickeningFrame,
  v : Double,
) -> ImagemorphthickeningFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningFrame::min(
  self : ImagemorphthickeningFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningFrame::max(
  self : ImagemorphthickeningFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningFrame::to_string(
  self : ImagemorphthickeningFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_table_make(
  size : Int32,
) -> ImagemorphthickeningTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningTable::len(
  self : ImagemorphthickeningTable,
) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningTable::get(
  self : ImagemorphthickeningTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningTable::set(
  self : ImagemorphthickeningTable,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningTable::sum(
  self : ImagemorphthickeningTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningTable::mean(
  self : ImagemorphthickeningTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningTable::scale(
  self : ImagemorphthickeningTable,
  f : Double,
) -> ImagemorphthickeningTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningTable::add(
  self : ImagemorphthickeningTable,
  other : ImagemorphthickeningTable,
) -> ImagemorphthickeningTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningTable::copy(
  self : ImagemorphthickeningTable,
) -> ImagemorphthickeningTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningTable::fill(
  self : ImagemorphthickeningTable,
  v : Double,
) -> ImagemorphthickeningTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningTable::min(
  self : ImagemorphthickeningTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningTable::max(
  self : ImagemorphthickeningTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningTable::to_string(
  self : ImagemorphthickeningTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_graphn_make(
  size : Int32,
) -> ImagemorphthickeningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningGraphN::len(
  self : ImagemorphthickeningGraphN,
) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningGraphN::get(
  self : ImagemorphthickeningGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningGraphN::set(
  self : ImagemorphthickeningGraphN,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningGraphN::sum(
  self : ImagemorphthickeningGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningGraphN::mean(
  self : ImagemorphthickeningGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningGraphN::scale(
  self : ImagemorphthickeningGraphN,
  f : Double,
) -> ImagemorphthickeningGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningGraphN::add(
  self : ImagemorphthickeningGraphN,
  other : ImagemorphthickeningGraphN,
) -> ImagemorphthickeningGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningGraphN::copy(
  self : ImagemorphthickeningGraphN,
) -> ImagemorphthickeningGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningGraphN::fill(
  self : ImagemorphthickeningGraphN,
  v : Double,
) -> ImagemorphthickeningGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningGraphN::min(
  self : ImagemorphthickeningGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningGraphN::max(
  self : ImagemorphthickeningGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningGraphN::to_string(
  self : ImagemorphthickeningGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_node_make(
  size : Int32,
) -> ImagemorphthickeningNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningNode::len(self : ImagemorphthickeningNode) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningNode::get(
  self : ImagemorphthickeningNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningNode::set(
  self : ImagemorphthickeningNode,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningNode::sum(self : ImagemorphthickeningNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningNode::mean(
  self : ImagemorphthickeningNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningNode::scale(
  self : ImagemorphthickeningNode,
  f : Double,
) -> ImagemorphthickeningNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningNode::add(
  self : ImagemorphthickeningNode,
  other : ImagemorphthickeningNode,
) -> ImagemorphthickeningNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningNode::copy(
  self : ImagemorphthickeningNode,
) -> ImagemorphthickeningNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningNode::fill(
  self : ImagemorphthickeningNode,
  v : Double,
) -> ImagemorphthickeningNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningNode::min(self : ImagemorphthickeningNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningNode::max(self : ImagemorphthickeningNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningNode::to_string(
  self : ImagemorphthickeningNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_edge_make(
  size : Int32,
) -> ImagemorphthickeningEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningEdge::len(self : ImagemorphthickeningEdge) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningEdge::get(
  self : ImagemorphthickeningEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningEdge::set(
  self : ImagemorphthickeningEdge,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningEdge::sum(self : ImagemorphthickeningEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningEdge::mean(
  self : ImagemorphthickeningEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningEdge::scale(
  self : ImagemorphthickeningEdge,
  f : Double,
) -> ImagemorphthickeningEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningEdge::add(
  self : ImagemorphthickeningEdge,
  other : ImagemorphthickeningEdge,
) -> ImagemorphthickeningEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningEdge::copy(
  self : ImagemorphthickeningEdge,
) -> ImagemorphthickeningEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningEdge::fill(
  self : ImagemorphthickeningEdge,
  v : Double,
) -> ImagemorphthickeningEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningEdge::min(self : ImagemorphthickeningEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningEdge::max(self : ImagemorphthickeningEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningEdge::to_string(
  self : ImagemorphthickeningEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_path_make(
  size : Int32,
) -> ImagemorphthickeningPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningPath::len(self : ImagemorphthickeningPath) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningPath::get(
  self : ImagemorphthickeningPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningPath::set(
  self : ImagemorphthickeningPath,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningPath::sum(self : ImagemorphthickeningPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningPath::mean(
  self : ImagemorphthickeningPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningPath::scale(
  self : ImagemorphthickeningPath,
  f : Double,
) -> ImagemorphthickeningPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningPath::add(
  self : ImagemorphthickeningPath,
  other : ImagemorphthickeningPath,
) -> ImagemorphthickeningPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningPath::copy(
  self : ImagemorphthickeningPath,
) -> ImagemorphthickeningPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningPath::fill(
  self : ImagemorphthickeningPath,
  v : Double,
) -> ImagemorphthickeningPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningPath::min(self : ImagemorphthickeningPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningPath::max(self : ImagemorphthickeningPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningPath::to_string(
  self : ImagemorphthickeningPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_cluster_make(
  size : Int32,
) -> ImagemorphthickeningCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningCluster::len(
  self : ImagemorphthickeningCluster,
) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningCluster::get(
  self : ImagemorphthickeningCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningCluster::set(
  self : ImagemorphthickeningCluster,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningCluster::sum(
  self : ImagemorphthickeningCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningCluster::mean(
  self : ImagemorphthickeningCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningCluster::scale(
  self : ImagemorphthickeningCluster,
  f : Double,
) -> ImagemorphthickeningCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningCluster::add(
  self : ImagemorphthickeningCluster,
  other : ImagemorphthickeningCluster,
) -> ImagemorphthickeningCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningCluster::copy(
  self : ImagemorphthickeningCluster,
) -> ImagemorphthickeningCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningCluster::fill(
  self : ImagemorphthickeningCluster,
  v : Double,
) -> ImagemorphthickeningCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningCluster::min(
  self : ImagemorphthickeningCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningCluster::max(
  self : ImagemorphthickeningCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningCluster::to_string(
  self : ImagemorphthickeningCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_model_make(
  size : Int32,
) -> ImagemorphthickeningModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningModel::len(
  self : ImagemorphthickeningModel,
) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningModel::get(
  self : ImagemorphthickeningModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningModel::set(
  self : ImagemorphthickeningModel,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningModel::sum(
  self : ImagemorphthickeningModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningModel::mean(
  self : ImagemorphthickeningModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningModel::scale(
  self : ImagemorphthickeningModel,
  f : Double,
) -> ImagemorphthickeningModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningModel::add(
  self : ImagemorphthickeningModel,
  other : ImagemorphthickeningModel,
) -> ImagemorphthickeningModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningModel::copy(
  self : ImagemorphthickeningModel,
) -> ImagemorphthickeningModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningModel::fill(
  self : ImagemorphthickeningModel,
  v : Double,
) -> ImagemorphthickeningModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningModel::min(
  self : ImagemorphthickeningModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningModel::max(
  self : ImagemorphthickeningModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningModel::to_string(
  self : ImagemorphthickeningModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_layer_make(
  size : Int32,
) -> ImagemorphthickeningLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningLayer::len(
  self : ImagemorphthickeningLayer,
) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningLayer::get(
  self : ImagemorphthickeningLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningLayer::set(
  self : ImagemorphthickeningLayer,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningLayer::sum(
  self : ImagemorphthickeningLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningLayer::mean(
  self : ImagemorphthickeningLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningLayer::scale(
  self : ImagemorphthickeningLayer,
  f : Double,
) -> ImagemorphthickeningLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningLayer::add(
  self : ImagemorphthickeningLayer,
  other : ImagemorphthickeningLayer,
) -> ImagemorphthickeningLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningLayer::copy(
  self : ImagemorphthickeningLayer,
) -> ImagemorphthickeningLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningLayer::fill(
  self : ImagemorphthickeningLayer,
  v : Double,
) -> ImagemorphthickeningLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningLayer::min(
  self : ImagemorphthickeningLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningLayer::max(
  self : ImagemorphthickeningLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningLayer::to_string(
  self : ImagemorphthickeningLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_buffer_make(
  size : Int32,
) -> ImagemorphthickeningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningBuffer::len(
  self : ImagemorphthickeningBuffer,
) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningBuffer::get(
  self : ImagemorphthickeningBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningBuffer::set(
  self : ImagemorphthickeningBuffer,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningBuffer::sum(
  self : ImagemorphthickeningBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningBuffer::mean(
  self : ImagemorphthickeningBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningBuffer::scale(
  self : ImagemorphthickeningBuffer,
  f : Double,
) -> ImagemorphthickeningBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningBuffer::add(
  self : ImagemorphthickeningBuffer,
  other : ImagemorphthickeningBuffer,
) -> ImagemorphthickeningBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningBuffer::copy(
  self : ImagemorphthickeningBuffer,
) -> ImagemorphthickeningBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningBuffer::fill(
  self : ImagemorphthickeningBuffer,
  v : Double,
) -> ImagemorphthickeningBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningBuffer::min(
  self : ImagemorphthickeningBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningBuffer::max(
  self : ImagemorphthickeningBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningBuffer::to_string(
  self : ImagemorphthickeningBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_cursor_make(
  size : Int32,
) -> ImagemorphthickeningCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningCursor::len(
  self : ImagemorphthickeningCursor,
) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningCursor::get(
  self : ImagemorphthickeningCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningCursor::set(
  self : ImagemorphthickeningCursor,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningCursor::sum(
  self : ImagemorphthickeningCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningCursor::mean(
  self : ImagemorphthickeningCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningCursor::scale(
  self : ImagemorphthickeningCursor,
  f : Double,
) -> ImagemorphthickeningCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningCursor::add(
  self : ImagemorphthickeningCursor,
  other : ImagemorphthickeningCursor,
) -> ImagemorphthickeningCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningCursor::copy(
  self : ImagemorphthickeningCursor,
) -> ImagemorphthickeningCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningCursor::fill(
  self : ImagemorphthickeningCursor,
  v : Double,
) -> ImagemorphthickeningCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningCursor::min(
  self : ImagemorphthickeningCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningCursor::max(
  self : ImagemorphthickeningCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningCursor::to_string(
  self : ImagemorphthickeningCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_view_make(
  size : Int32,
) -> ImagemorphthickeningView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningView::len(self : ImagemorphthickeningView) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningView::get(
  self : ImagemorphthickeningView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningView::set(
  self : ImagemorphthickeningView,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningView::sum(self : ImagemorphthickeningView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningView::mean(
  self : ImagemorphthickeningView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningView::scale(
  self : ImagemorphthickeningView,
  f : Double,
) -> ImagemorphthickeningView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningView::add(
  self : ImagemorphthickeningView,
  other : ImagemorphthickeningView,
) -> ImagemorphthickeningView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningView::copy(
  self : ImagemorphthickeningView,
) -> ImagemorphthickeningView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningView::fill(
  self : ImagemorphthickeningView,
  v : Double,
) -> ImagemorphthickeningView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningView::min(self : ImagemorphthickeningView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningView::max(self : ImagemorphthickeningView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningView::to_string(
  self : ImagemorphthickeningView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_range_make(
  size : Int32,
) -> ImagemorphthickeningRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningRange::len(
  self : ImagemorphthickeningRange,
) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningRange::get(
  self : ImagemorphthickeningRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningRange::set(
  self : ImagemorphthickeningRange,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningRange::sum(
  self : ImagemorphthickeningRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningRange::mean(
  self : ImagemorphthickeningRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningRange::scale(
  self : ImagemorphthickeningRange,
  f : Double,
) -> ImagemorphthickeningRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningRange::add(
  self : ImagemorphthickeningRange,
  other : ImagemorphthickeningRange,
) -> ImagemorphthickeningRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningRange::copy(
  self : ImagemorphthickeningRange,
) -> ImagemorphthickeningRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningRange::fill(
  self : ImagemorphthickeningRange,
  v : Double,
) -> ImagemorphthickeningRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningRange::min(
  self : ImagemorphthickeningRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningRange::max(
  self : ImagemorphthickeningRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningRange::to_string(
  self : ImagemorphthickeningRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ImagemorphthickeningSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn image_morph_thickening_slice_make(
  size : Int32,
) -> ImagemorphthickeningSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ImagemorphthickeningSlice::len(
  self : ImagemorphthickeningSlice,
) -> Int32 {
  self.size
}

///|
pub fn ImagemorphthickeningSlice::get(
  self : ImagemorphthickeningSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ImagemorphthickeningSlice::set(
  self : ImagemorphthickeningSlice,
  i : Int32,
  v : Double,
) -> ImagemorphthickeningSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningSlice::sum(
  self : ImagemorphthickeningSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ImagemorphthickeningSlice::mean(
  self : ImagemorphthickeningSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ImagemorphthickeningSlice::scale(
  self : ImagemorphthickeningSlice,
  f : Double,
) -> ImagemorphthickeningSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningSlice::add(
  self : ImagemorphthickeningSlice,
  other : ImagemorphthickeningSlice,
) -> ImagemorphthickeningSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningSlice::copy(
  self : ImagemorphthickeningSlice,
) -> ImagemorphthickeningSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningSlice::fill(
  self : ImagemorphthickeningSlice,
  v : Double,
) -> ImagemorphthickeningSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ImagemorphthickeningSlice::min(
  self : ImagemorphthickeningSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ImagemorphthickeningSlice::max(
  self : ImagemorphthickeningSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ImagemorphthickeningSlice::to_string(
  self : ImagemorphthickeningSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
