///|
///===
/// extcore/sort_exchange_cocktail
pub(all) struct SortexchangecocktailPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn sort_exchange_cocktail_make_point(
  x : Double,
  y : Double,
) -> SortexchangecocktailPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn sort_exchange_cocktail_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SortexchangecocktailPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SortexchangecocktailPoint::x(self : SortexchangecocktailPoint) -> Double {
  self.x
}

///|
pub fn SortexchangecocktailPoint::y(self : SortexchangecocktailPoint) -> Double {
  self.y
}

///|
pub fn SortexchangecocktailPoint::z(self : SortexchangecocktailPoint) -> Double {
  self.z
}

///|
pub fn SortexchangecocktailPoint::label(
  self : SortexchangecocktailPoint,
) -> Int32 {
  self.label
}

///|
pub fn SortexchangecocktailPoint::dist(
  self : SortexchangecocktailPoint,
  other : SortexchangecocktailPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SortexchangecocktailPoint::add(
  self : SortexchangecocktailPoint,
  other : SortexchangecocktailPoint,
) -> SortexchangecocktailPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SortexchangecocktailPoint::sub(
  self : SortexchangecocktailPoint,
  other : SortexchangecocktailPoint,
) -> SortexchangecocktailPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SortexchangecocktailPoint::scale(
  self : SortexchangecocktailPoint,
  s : Double,
) -> SortexchangecocktailPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SortexchangecocktailPoint::dot(
  self : SortexchangecocktailPoint,
  other : SortexchangecocktailPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SortexchangecocktailPoint::cross(
  self : SortexchangecocktailPoint,
  other : SortexchangecocktailPoint,
) -> SortexchangecocktailPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SortexchangecocktailPoint::norm(
  self : SortexchangecocktailPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SortexchangecocktailPoint::normalize(
  self : SortexchangecocktailPoint,
) -> SortexchangecocktailPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortexchangecocktailPoint::negate(
  self : SortexchangecocktailPoint,
) -> SortexchangecocktailPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SortexchangecocktailPoint::mid(
  self : SortexchangecocktailPoint,
  other : SortexchangecocktailPoint,
) -> SortexchangecocktailPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SortexchangecocktailPoint::lerp(
  self : SortexchangecocktailPoint,
  other : SortexchangecocktailPoint,
  t : Double,
) -> SortexchangecocktailPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SortexchangecocktailPoint::to_string(
  self : SortexchangecocktailPoint,
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
pub(all) struct SortexchangecocktailSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn sort_exchange_cocktail_make_series(
  vals : Array[Double],
  name : String,
) -> SortexchangecocktailSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SortexchangecocktailSeries::len(
  self : SortexchangecocktailSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn SortexchangecocktailSeries::sum(
  self : SortexchangecocktailSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SortexchangecocktailSeries::mean(
  self : SortexchangecocktailSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SortexchangecocktailSeries::min(
  self : SortexchangecocktailSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SortexchangecocktailSeries::max(
  self : SortexchangecocktailSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SortexchangecocktailSeries::range(
  self : SortexchangecocktailSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SortexchangecocktailSeries::variance(
  self : SortexchangecocktailSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SortexchangecocktailSeries::std(
  self : SortexchangecocktailSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SortexchangecocktailSeries::median(
  self : SortexchangecocktailSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SortexchangecocktailSeries::scale(
  self : SortexchangecocktailSeries,
  f : Double,
) -> SortexchangecocktailSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SortexchangecocktailSeries::add(
  self : SortexchangecocktailSeries,
  other : SortexchangecocktailSeries,
) -> SortexchangecocktailSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortexchangecocktailSeries::sub(
  self : SortexchangecocktailSeries,
  other : SortexchangecocktailSeries,
) -> SortexchangecocktailSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortexchangecocktailSeries::normalize(
  self : SortexchangecocktailSeries,
) -> SortexchangecocktailSeries {
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
pub fn SortexchangecocktailSeries::cumsum(
  self : SortexchangecocktailSeries,
) -> SortexchangecocktailSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SortexchangecocktailSeries::to_string(
  self : SortexchangecocktailSeries,
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
pub(all) struct SortexchangecocktailMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn sort_exchange_cocktail_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SortexchangecocktailMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn sort_exchange_cocktail_matrix_identity(
  n : Int32,
) -> SortexchangecocktailMatrix {
  let m = sort_exchange_cocktail_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SortexchangecocktailMatrix::get(
  self : SortexchangecocktailMatrix,
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
pub fn SortexchangecocktailMatrix::transpose(
  self : SortexchangecocktailMatrix,
) -> SortexchangecocktailMatrix {
  let result = sort_exchange_cocktail_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SortexchangecocktailMatrix::add(
  self : SortexchangecocktailMatrix,
  other : SortexchangecocktailMatrix,
) -> SortexchangecocktailMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = sort_exchange_cocktail_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SortexchangecocktailMatrix::scale(
  self : SortexchangecocktailMatrix,
  s : Double,
) -> SortexchangecocktailMatrix {
  let result = sort_exchange_cocktail_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SortexchangecocktailMatrix::multiply(
  self : SortexchangecocktailMatrix,
  other : SortexchangecocktailMatrix,
) -> SortexchangecocktailMatrix {
  if self.cols != other.rows {
    return sort_exchange_cocktail_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = sort_exchange_cocktail_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SortexchangecocktailMatrix::trace(
  self : SortexchangecocktailMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SortexchangecocktailMatrix::det(
  self : SortexchangecocktailMatrix,
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
pub fn SortexchangecocktailMatrix::norm(
  self : SortexchangecocktailMatrix,
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
pub fn SortexchangecocktailMatrix::to_string(
  self : SortexchangecocktailMatrix,
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
pub(all) struct SortexchangecocktailVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn sort_exchange_cocktail_make_vector(
  comps : Array[Double],
) -> SortexchangecocktailVector {
  { comps, dim: comps.length(), }
}

///|
pub fn sort_exchange_cocktail_vector_zero(
  dim : Int32,
) -> SortexchangecocktailVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SortexchangecocktailVector::add(
  self : SortexchangecocktailVector,
  other : SortexchangecocktailVector,
) -> SortexchangecocktailVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortexchangecocktailVector::sub(
  self : SortexchangecocktailVector,
  other : SortexchangecocktailVector,
) -> SortexchangecocktailVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortexchangecocktailVector::scale(
  self : SortexchangecocktailVector,
  s : Double,
) -> SortexchangecocktailVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SortexchangecocktailVector::dot(
  self : SortexchangecocktailVector,
  other : SortexchangecocktailVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SortexchangecocktailVector::norm(
  self : SortexchangecocktailVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SortexchangecocktailVector::normalize(
  self : SortexchangecocktailVector,
) -> SortexchangecocktailVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortexchangecocktailVector::dist(
  self : SortexchangecocktailVector,
  other : SortexchangecocktailVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SortexchangecocktailVector::to_string(
  self : SortexchangecocktailVector,
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
pub(all) struct SortexchangecocktailFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_frame_make(
  size : Int32,
) -> SortexchangecocktailFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailFrame::len(
  self : SortexchangecocktailFrame,
) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailFrame::get(
  self : SortexchangecocktailFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailFrame::set(
  self : SortexchangecocktailFrame,
  i : Int32,
  v : Double,
) -> SortexchangecocktailFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailFrame::sum(
  self : SortexchangecocktailFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailFrame::mean(
  self : SortexchangecocktailFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailFrame::scale(
  self : SortexchangecocktailFrame,
  f : Double,
) -> SortexchangecocktailFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailFrame::add(
  self : SortexchangecocktailFrame,
  other : SortexchangecocktailFrame,
) -> SortexchangecocktailFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailFrame::copy(
  self : SortexchangecocktailFrame,
) -> SortexchangecocktailFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailFrame::fill(
  self : SortexchangecocktailFrame,
  v : Double,
) -> SortexchangecocktailFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailFrame::min(
  self : SortexchangecocktailFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailFrame::max(
  self : SortexchangecocktailFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailFrame::to_string(
  self : SortexchangecocktailFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_table_make(
  size : Int32,
) -> SortexchangecocktailTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailTable::len(
  self : SortexchangecocktailTable,
) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailTable::get(
  self : SortexchangecocktailTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailTable::set(
  self : SortexchangecocktailTable,
  i : Int32,
  v : Double,
) -> SortexchangecocktailTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailTable::sum(
  self : SortexchangecocktailTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailTable::mean(
  self : SortexchangecocktailTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailTable::scale(
  self : SortexchangecocktailTable,
  f : Double,
) -> SortexchangecocktailTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailTable::add(
  self : SortexchangecocktailTable,
  other : SortexchangecocktailTable,
) -> SortexchangecocktailTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailTable::copy(
  self : SortexchangecocktailTable,
) -> SortexchangecocktailTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailTable::fill(
  self : SortexchangecocktailTable,
  v : Double,
) -> SortexchangecocktailTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailTable::min(
  self : SortexchangecocktailTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailTable::max(
  self : SortexchangecocktailTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailTable::to_string(
  self : SortexchangecocktailTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_graphn_make(
  size : Int32,
) -> SortexchangecocktailGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailGraphN::len(
  self : SortexchangecocktailGraphN,
) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailGraphN::get(
  self : SortexchangecocktailGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailGraphN::set(
  self : SortexchangecocktailGraphN,
  i : Int32,
  v : Double,
) -> SortexchangecocktailGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailGraphN::sum(
  self : SortexchangecocktailGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailGraphN::mean(
  self : SortexchangecocktailGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailGraphN::scale(
  self : SortexchangecocktailGraphN,
  f : Double,
) -> SortexchangecocktailGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailGraphN::add(
  self : SortexchangecocktailGraphN,
  other : SortexchangecocktailGraphN,
) -> SortexchangecocktailGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailGraphN::copy(
  self : SortexchangecocktailGraphN,
) -> SortexchangecocktailGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailGraphN::fill(
  self : SortexchangecocktailGraphN,
  v : Double,
) -> SortexchangecocktailGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailGraphN::min(
  self : SortexchangecocktailGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailGraphN::max(
  self : SortexchangecocktailGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailGraphN::to_string(
  self : SortexchangecocktailGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_node_make(
  size : Int32,
) -> SortexchangecocktailNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailNode::len(self : SortexchangecocktailNode) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailNode::get(
  self : SortexchangecocktailNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailNode::set(
  self : SortexchangecocktailNode,
  i : Int32,
  v : Double,
) -> SortexchangecocktailNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailNode::sum(self : SortexchangecocktailNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailNode::mean(
  self : SortexchangecocktailNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailNode::scale(
  self : SortexchangecocktailNode,
  f : Double,
) -> SortexchangecocktailNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailNode::add(
  self : SortexchangecocktailNode,
  other : SortexchangecocktailNode,
) -> SortexchangecocktailNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailNode::copy(
  self : SortexchangecocktailNode,
) -> SortexchangecocktailNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailNode::fill(
  self : SortexchangecocktailNode,
  v : Double,
) -> SortexchangecocktailNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailNode::min(self : SortexchangecocktailNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailNode::max(self : SortexchangecocktailNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailNode::to_string(
  self : SortexchangecocktailNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_edge_make(
  size : Int32,
) -> SortexchangecocktailEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailEdge::len(self : SortexchangecocktailEdge) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailEdge::get(
  self : SortexchangecocktailEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailEdge::set(
  self : SortexchangecocktailEdge,
  i : Int32,
  v : Double,
) -> SortexchangecocktailEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailEdge::sum(self : SortexchangecocktailEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailEdge::mean(
  self : SortexchangecocktailEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailEdge::scale(
  self : SortexchangecocktailEdge,
  f : Double,
) -> SortexchangecocktailEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailEdge::add(
  self : SortexchangecocktailEdge,
  other : SortexchangecocktailEdge,
) -> SortexchangecocktailEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailEdge::copy(
  self : SortexchangecocktailEdge,
) -> SortexchangecocktailEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailEdge::fill(
  self : SortexchangecocktailEdge,
  v : Double,
) -> SortexchangecocktailEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailEdge::min(self : SortexchangecocktailEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailEdge::max(self : SortexchangecocktailEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailEdge::to_string(
  self : SortexchangecocktailEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_path_make(
  size : Int32,
) -> SortexchangecocktailPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailPath::len(self : SortexchangecocktailPath) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailPath::get(
  self : SortexchangecocktailPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailPath::set(
  self : SortexchangecocktailPath,
  i : Int32,
  v : Double,
) -> SortexchangecocktailPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailPath::sum(self : SortexchangecocktailPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailPath::mean(
  self : SortexchangecocktailPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailPath::scale(
  self : SortexchangecocktailPath,
  f : Double,
) -> SortexchangecocktailPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailPath::add(
  self : SortexchangecocktailPath,
  other : SortexchangecocktailPath,
) -> SortexchangecocktailPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailPath::copy(
  self : SortexchangecocktailPath,
) -> SortexchangecocktailPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailPath::fill(
  self : SortexchangecocktailPath,
  v : Double,
) -> SortexchangecocktailPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailPath::min(self : SortexchangecocktailPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailPath::max(self : SortexchangecocktailPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailPath::to_string(
  self : SortexchangecocktailPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_cluster_make(
  size : Int32,
) -> SortexchangecocktailCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailCluster::len(
  self : SortexchangecocktailCluster,
) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailCluster::get(
  self : SortexchangecocktailCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailCluster::set(
  self : SortexchangecocktailCluster,
  i : Int32,
  v : Double,
) -> SortexchangecocktailCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailCluster::sum(
  self : SortexchangecocktailCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailCluster::mean(
  self : SortexchangecocktailCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailCluster::scale(
  self : SortexchangecocktailCluster,
  f : Double,
) -> SortexchangecocktailCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailCluster::add(
  self : SortexchangecocktailCluster,
  other : SortexchangecocktailCluster,
) -> SortexchangecocktailCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailCluster::copy(
  self : SortexchangecocktailCluster,
) -> SortexchangecocktailCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailCluster::fill(
  self : SortexchangecocktailCluster,
  v : Double,
) -> SortexchangecocktailCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailCluster::min(
  self : SortexchangecocktailCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailCluster::max(
  self : SortexchangecocktailCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailCluster::to_string(
  self : SortexchangecocktailCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_model_make(
  size : Int32,
) -> SortexchangecocktailModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailModel::len(
  self : SortexchangecocktailModel,
) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailModel::get(
  self : SortexchangecocktailModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailModel::set(
  self : SortexchangecocktailModel,
  i : Int32,
  v : Double,
) -> SortexchangecocktailModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailModel::sum(
  self : SortexchangecocktailModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailModel::mean(
  self : SortexchangecocktailModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailModel::scale(
  self : SortexchangecocktailModel,
  f : Double,
) -> SortexchangecocktailModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailModel::add(
  self : SortexchangecocktailModel,
  other : SortexchangecocktailModel,
) -> SortexchangecocktailModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailModel::copy(
  self : SortexchangecocktailModel,
) -> SortexchangecocktailModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailModel::fill(
  self : SortexchangecocktailModel,
  v : Double,
) -> SortexchangecocktailModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailModel::min(
  self : SortexchangecocktailModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailModel::max(
  self : SortexchangecocktailModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailModel::to_string(
  self : SortexchangecocktailModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_layer_make(
  size : Int32,
) -> SortexchangecocktailLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailLayer::len(
  self : SortexchangecocktailLayer,
) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailLayer::get(
  self : SortexchangecocktailLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailLayer::set(
  self : SortexchangecocktailLayer,
  i : Int32,
  v : Double,
) -> SortexchangecocktailLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailLayer::sum(
  self : SortexchangecocktailLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailLayer::mean(
  self : SortexchangecocktailLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailLayer::scale(
  self : SortexchangecocktailLayer,
  f : Double,
) -> SortexchangecocktailLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailLayer::add(
  self : SortexchangecocktailLayer,
  other : SortexchangecocktailLayer,
) -> SortexchangecocktailLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailLayer::copy(
  self : SortexchangecocktailLayer,
) -> SortexchangecocktailLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailLayer::fill(
  self : SortexchangecocktailLayer,
  v : Double,
) -> SortexchangecocktailLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailLayer::min(
  self : SortexchangecocktailLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailLayer::max(
  self : SortexchangecocktailLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailLayer::to_string(
  self : SortexchangecocktailLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_buffer_make(
  size : Int32,
) -> SortexchangecocktailBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailBuffer::len(
  self : SortexchangecocktailBuffer,
) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailBuffer::get(
  self : SortexchangecocktailBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailBuffer::set(
  self : SortexchangecocktailBuffer,
  i : Int32,
  v : Double,
) -> SortexchangecocktailBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailBuffer::sum(
  self : SortexchangecocktailBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailBuffer::mean(
  self : SortexchangecocktailBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailBuffer::scale(
  self : SortexchangecocktailBuffer,
  f : Double,
) -> SortexchangecocktailBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailBuffer::add(
  self : SortexchangecocktailBuffer,
  other : SortexchangecocktailBuffer,
) -> SortexchangecocktailBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailBuffer::copy(
  self : SortexchangecocktailBuffer,
) -> SortexchangecocktailBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailBuffer::fill(
  self : SortexchangecocktailBuffer,
  v : Double,
) -> SortexchangecocktailBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailBuffer::min(
  self : SortexchangecocktailBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailBuffer::max(
  self : SortexchangecocktailBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailBuffer::to_string(
  self : SortexchangecocktailBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_cursor_make(
  size : Int32,
) -> SortexchangecocktailCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailCursor::len(
  self : SortexchangecocktailCursor,
) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailCursor::get(
  self : SortexchangecocktailCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailCursor::set(
  self : SortexchangecocktailCursor,
  i : Int32,
  v : Double,
) -> SortexchangecocktailCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailCursor::sum(
  self : SortexchangecocktailCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailCursor::mean(
  self : SortexchangecocktailCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailCursor::scale(
  self : SortexchangecocktailCursor,
  f : Double,
) -> SortexchangecocktailCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailCursor::add(
  self : SortexchangecocktailCursor,
  other : SortexchangecocktailCursor,
) -> SortexchangecocktailCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailCursor::copy(
  self : SortexchangecocktailCursor,
) -> SortexchangecocktailCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailCursor::fill(
  self : SortexchangecocktailCursor,
  v : Double,
) -> SortexchangecocktailCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailCursor::min(
  self : SortexchangecocktailCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailCursor::max(
  self : SortexchangecocktailCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailCursor::to_string(
  self : SortexchangecocktailCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_view_make(
  size : Int32,
) -> SortexchangecocktailView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailView::len(self : SortexchangecocktailView) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailView::get(
  self : SortexchangecocktailView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailView::set(
  self : SortexchangecocktailView,
  i : Int32,
  v : Double,
) -> SortexchangecocktailView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailView::sum(self : SortexchangecocktailView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailView::mean(
  self : SortexchangecocktailView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailView::scale(
  self : SortexchangecocktailView,
  f : Double,
) -> SortexchangecocktailView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailView::add(
  self : SortexchangecocktailView,
  other : SortexchangecocktailView,
) -> SortexchangecocktailView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailView::copy(
  self : SortexchangecocktailView,
) -> SortexchangecocktailView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailView::fill(
  self : SortexchangecocktailView,
  v : Double,
) -> SortexchangecocktailView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailView::min(self : SortexchangecocktailView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailView::max(self : SortexchangecocktailView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailView::to_string(
  self : SortexchangecocktailView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_range_make(
  size : Int32,
) -> SortexchangecocktailRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailRange::len(
  self : SortexchangecocktailRange,
) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailRange::get(
  self : SortexchangecocktailRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailRange::set(
  self : SortexchangecocktailRange,
  i : Int32,
  v : Double,
) -> SortexchangecocktailRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailRange::sum(
  self : SortexchangecocktailRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailRange::mean(
  self : SortexchangecocktailRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailRange::scale(
  self : SortexchangecocktailRange,
  f : Double,
) -> SortexchangecocktailRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailRange::add(
  self : SortexchangecocktailRange,
  other : SortexchangecocktailRange,
) -> SortexchangecocktailRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailRange::copy(
  self : SortexchangecocktailRange,
) -> SortexchangecocktailRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailRange::fill(
  self : SortexchangecocktailRange,
  v : Double,
) -> SortexchangecocktailRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailRange::min(
  self : SortexchangecocktailRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailRange::max(
  self : SortexchangecocktailRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailRange::to_string(
  self : SortexchangecocktailRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecocktailSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_cocktail_slice_make(
  size : Int32,
) -> SortexchangecocktailSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecocktailSlice::len(
  self : SortexchangecocktailSlice,
) -> Int32 {
  self.size
}

///|
pub fn SortexchangecocktailSlice::get(
  self : SortexchangecocktailSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecocktailSlice::set(
  self : SortexchangecocktailSlice,
  i : Int32,
  v : Double,
) -> SortexchangecocktailSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailSlice::sum(
  self : SortexchangecocktailSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecocktailSlice::mean(
  self : SortexchangecocktailSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecocktailSlice::scale(
  self : SortexchangecocktailSlice,
  f : Double,
) -> SortexchangecocktailSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailSlice::add(
  self : SortexchangecocktailSlice,
  other : SortexchangecocktailSlice,
) -> SortexchangecocktailSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecocktailSlice::copy(
  self : SortexchangecocktailSlice,
) -> SortexchangecocktailSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailSlice::fill(
  self : SortexchangecocktailSlice,
  v : Double,
) -> SortexchangecocktailSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecocktailSlice::min(
  self : SortexchangecocktailSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecocktailSlice::max(
  self : SortexchangecocktailSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecocktailSlice::to_string(
  self : SortexchangecocktailSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
