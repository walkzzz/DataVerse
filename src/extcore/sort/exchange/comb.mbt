///|
///===
/// extcore/sort_exchange_comb
pub(all) struct SortexchangecombPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn sort_exchange_comb_make_point(
  x : Double,
  y : Double,
) -> SortexchangecombPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn sort_exchange_comb_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SortexchangecombPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SortexchangecombPoint::x(self : SortexchangecombPoint) -> Double {
  self.x
}

///|
pub fn SortexchangecombPoint::y(self : SortexchangecombPoint) -> Double {
  self.y
}

///|
pub fn SortexchangecombPoint::z(self : SortexchangecombPoint) -> Double {
  self.z
}

///|
pub fn SortexchangecombPoint::label(self : SortexchangecombPoint) -> Int32 {
  self.label
}

///|
pub fn SortexchangecombPoint::dist(
  self : SortexchangecombPoint,
  other : SortexchangecombPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SortexchangecombPoint::add(
  self : SortexchangecombPoint,
  other : SortexchangecombPoint,
) -> SortexchangecombPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SortexchangecombPoint::sub(
  self : SortexchangecombPoint,
  other : SortexchangecombPoint,
) -> SortexchangecombPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SortexchangecombPoint::scale(
  self : SortexchangecombPoint,
  s : Double,
) -> SortexchangecombPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SortexchangecombPoint::dot(
  self : SortexchangecombPoint,
  other : SortexchangecombPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SortexchangecombPoint::cross(
  self : SortexchangecombPoint,
  other : SortexchangecombPoint,
) -> SortexchangecombPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SortexchangecombPoint::norm(self : SortexchangecombPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SortexchangecombPoint::normalize(
  self : SortexchangecombPoint,
) -> SortexchangecombPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortexchangecombPoint::negate(
  self : SortexchangecombPoint,
) -> SortexchangecombPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SortexchangecombPoint::mid(
  self : SortexchangecombPoint,
  other : SortexchangecombPoint,
) -> SortexchangecombPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SortexchangecombPoint::lerp(
  self : SortexchangecombPoint,
  other : SortexchangecombPoint,
  t : Double,
) -> SortexchangecombPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SortexchangecombPoint::to_string(self : SortexchangecombPoint) -> String {
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
pub(all) struct SortexchangecombSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn sort_exchange_comb_make_series(
  vals : Array[Double],
  name : String,
) -> SortexchangecombSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SortexchangecombSeries::len(self : SortexchangecombSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn SortexchangecombSeries::sum(self : SortexchangecombSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SortexchangecombSeries::mean(self : SortexchangecombSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SortexchangecombSeries::min(self : SortexchangecombSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SortexchangecombSeries::max(self : SortexchangecombSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SortexchangecombSeries::range(self : SortexchangecombSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SortexchangecombSeries::variance(
  self : SortexchangecombSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SortexchangecombSeries::std(self : SortexchangecombSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SortexchangecombSeries::median(self : SortexchangecombSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SortexchangecombSeries::scale(
  self : SortexchangecombSeries,
  f : Double,
) -> SortexchangecombSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SortexchangecombSeries::add(
  self : SortexchangecombSeries,
  other : SortexchangecombSeries,
) -> SortexchangecombSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortexchangecombSeries::sub(
  self : SortexchangecombSeries,
  other : SortexchangecombSeries,
) -> SortexchangecombSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortexchangecombSeries::normalize(
  self : SortexchangecombSeries,
) -> SortexchangecombSeries {
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
pub fn SortexchangecombSeries::cumsum(
  self : SortexchangecombSeries,
) -> SortexchangecombSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SortexchangecombSeries::to_string(
  self : SortexchangecombSeries,
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
pub(all) struct SortexchangecombMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn sort_exchange_comb_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SortexchangecombMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn sort_exchange_comb_matrix_identity(n : Int32) -> SortexchangecombMatrix {
  let m = sort_exchange_comb_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SortexchangecombMatrix::get(
  self : SortexchangecombMatrix,
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
pub fn SortexchangecombMatrix::transpose(
  self : SortexchangecombMatrix,
) -> SortexchangecombMatrix {
  let result = sort_exchange_comb_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SortexchangecombMatrix::add(
  self : SortexchangecombMatrix,
  other : SortexchangecombMatrix,
) -> SortexchangecombMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = sort_exchange_comb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SortexchangecombMatrix::scale(
  self : SortexchangecombMatrix,
  s : Double,
) -> SortexchangecombMatrix {
  let result = sort_exchange_comb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SortexchangecombMatrix::multiply(
  self : SortexchangecombMatrix,
  other : SortexchangecombMatrix,
) -> SortexchangecombMatrix {
  if self.cols != other.rows {
    return sort_exchange_comb_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = sort_exchange_comb_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SortexchangecombMatrix::trace(self : SortexchangecombMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SortexchangecombMatrix::det(self : SortexchangecombMatrix) -> Double {
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
pub fn SortexchangecombMatrix::norm(self : SortexchangecombMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn SortexchangecombMatrix::to_string(
  self : SortexchangecombMatrix,
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
pub(all) struct SortexchangecombVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn sort_exchange_comb_make_vector(
  comps : Array[Double],
) -> SortexchangecombVector {
  { comps, dim: comps.length(), }
}

///|
pub fn sort_exchange_comb_vector_zero(dim : Int32) -> SortexchangecombVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SortexchangecombVector::add(
  self : SortexchangecombVector,
  other : SortexchangecombVector,
) -> SortexchangecombVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortexchangecombVector::sub(
  self : SortexchangecombVector,
  other : SortexchangecombVector,
) -> SortexchangecombVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortexchangecombVector::scale(
  self : SortexchangecombVector,
  s : Double,
) -> SortexchangecombVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SortexchangecombVector::dot(
  self : SortexchangecombVector,
  other : SortexchangecombVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SortexchangecombVector::norm(self : SortexchangecombVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SortexchangecombVector::normalize(
  self : SortexchangecombVector,
) -> SortexchangecombVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortexchangecombVector::dist(
  self : SortexchangecombVector,
  other : SortexchangecombVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SortexchangecombVector::to_string(
  self : SortexchangecombVector,
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
pub(all) struct SortexchangecombFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_frame_make(size : Int32) -> SortexchangecombFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombFrame::len(self : SortexchangecombFrame) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombFrame::get(
  self : SortexchangecombFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombFrame::set(
  self : SortexchangecombFrame,
  i : Int32,
  v : Double,
) -> SortexchangecombFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombFrame::sum(self : SortexchangecombFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombFrame::mean(self : SortexchangecombFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombFrame::scale(
  self : SortexchangecombFrame,
  f : Double,
) -> SortexchangecombFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombFrame::add(
  self : SortexchangecombFrame,
  other : SortexchangecombFrame,
) -> SortexchangecombFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombFrame::copy(
  self : SortexchangecombFrame,
) -> SortexchangecombFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombFrame::fill(
  self : SortexchangecombFrame,
  v : Double,
) -> SortexchangecombFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombFrame::min(self : SortexchangecombFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombFrame::max(self : SortexchangecombFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombFrame::to_string(self : SortexchangecombFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_table_make(size : Int32) -> SortexchangecombTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombTable::len(self : SortexchangecombTable) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombTable::get(
  self : SortexchangecombTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombTable::set(
  self : SortexchangecombTable,
  i : Int32,
  v : Double,
) -> SortexchangecombTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombTable::sum(self : SortexchangecombTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombTable::mean(self : SortexchangecombTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombTable::scale(
  self : SortexchangecombTable,
  f : Double,
) -> SortexchangecombTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombTable::add(
  self : SortexchangecombTable,
  other : SortexchangecombTable,
) -> SortexchangecombTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombTable::copy(
  self : SortexchangecombTable,
) -> SortexchangecombTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombTable::fill(
  self : SortexchangecombTable,
  v : Double,
) -> SortexchangecombTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombTable::min(self : SortexchangecombTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombTable::max(self : SortexchangecombTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombTable::to_string(self : SortexchangecombTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_graphn_make(size : Int32) -> SortexchangecombGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombGraphN::len(self : SortexchangecombGraphN) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombGraphN::get(
  self : SortexchangecombGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombGraphN::set(
  self : SortexchangecombGraphN,
  i : Int32,
  v : Double,
) -> SortexchangecombGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombGraphN::sum(self : SortexchangecombGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombGraphN::mean(self : SortexchangecombGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombGraphN::scale(
  self : SortexchangecombGraphN,
  f : Double,
) -> SortexchangecombGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombGraphN::add(
  self : SortexchangecombGraphN,
  other : SortexchangecombGraphN,
) -> SortexchangecombGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombGraphN::copy(
  self : SortexchangecombGraphN,
) -> SortexchangecombGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombGraphN::fill(
  self : SortexchangecombGraphN,
  v : Double,
) -> SortexchangecombGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombGraphN::min(self : SortexchangecombGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombGraphN::max(self : SortexchangecombGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombGraphN::to_string(
  self : SortexchangecombGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_node_make(size : Int32) -> SortexchangecombNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombNode::len(self : SortexchangecombNode) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombNode::get(
  self : SortexchangecombNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombNode::set(
  self : SortexchangecombNode,
  i : Int32,
  v : Double,
) -> SortexchangecombNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombNode::sum(self : SortexchangecombNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombNode::mean(self : SortexchangecombNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombNode::scale(
  self : SortexchangecombNode,
  f : Double,
) -> SortexchangecombNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombNode::add(
  self : SortexchangecombNode,
  other : SortexchangecombNode,
) -> SortexchangecombNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombNode::copy(
  self : SortexchangecombNode,
) -> SortexchangecombNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombNode::fill(
  self : SortexchangecombNode,
  v : Double,
) -> SortexchangecombNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombNode::min(self : SortexchangecombNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombNode::max(self : SortexchangecombNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombNode::to_string(self : SortexchangecombNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_edge_make(size : Int32) -> SortexchangecombEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombEdge::len(self : SortexchangecombEdge) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombEdge::get(
  self : SortexchangecombEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombEdge::set(
  self : SortexchangecombEdge,
  i : Int32,
  v : Double,
) -> SortexchangecombEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombEdge::sum(self : SortexchangecombEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombEdge::mean(self : SortexchangecombEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombEdge::scale(
  self : SortexchangecombEdge,
  f : Double,
) -> SortexchangecombEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombEdge::add(
  self : SortexchangecombEdge,
  other : SortexchangecombEdge,
) -> SortexchangecombEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombEdge::copy(
  self : SortexchangecombEdge,
) -> SortexchangecombEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombEdge::fill(
  self : SortexchangecombEdge,
  v : Double,
) -> SortexchangecombEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombEdge::min(self : SortexchangecombEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombEdge::max(self : SortexchangecombEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombEdge::to_string(self : SortexchangecombEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_path_make(size : Int32) -> SortexchangecombPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombPath::len(self : SortexchangecombPath) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombPath::get(
  self : SortexchangecombPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombPath::set(
  self : SortexchangecombPath,
  i : Int32,
  v : Double,
) -> SortexchangecombPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombPath::sum(self : SortexchangecombPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombPath::mean(self : SortexchangecombPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombPath::scale(
  self : SortexchangecombPath,
  f : Double,
) -> SortexchangecombPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombPath::add(
  self : SortexchangecombPath,
  other : SortexchangecombPath,
) -> SortexchangecombPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombPath::copy(
  self : SortexchangecombPath,
) -> SortexchangecombPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombPath::fill(
  self : SortexchangecombPath,
  v : Double,
) -> SortexchangecombPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombPath::min(self : SortexchangecombPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombPath::max(self : SortexchangecombPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombPath::to_string(self : SortexchangecombPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_cluster_make(size : Int32) -> SortexchangecombCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombCluster::len(self : SortexchangecombCluster) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombCluster::get(
  self : SortexchangecombCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombCluster::set(
  self : SortexchangecombCluster,
  i : Int32,
  v : Double,
) -> SortexchangecombCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombCluster::sum(self : SortexchangecombCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombCluster::mean(self : SortexchangecombCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombCluster::scale(
  self : SortexchangecombCluster,
  f : Double,
) -> SortexchangecombCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombCluster::add(
  self : SortexchangecombCluster,
  other : SortexchangecombCluster,
) -> SortexchangecombCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombCluster::copy(
  self : SortexchangecombCluster,
) -> SortexchangecombCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombCluster::fill(
  self : SortexchangecombCluster,
  v : Double,
) -> SortexchangecombCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombCluster::min(self : SortexchangecombCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombCluster::max(self : SortexchangecombCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombCluster::to_string(
  self : SortexchangecombCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_model_make(size : Int32) -> SortexchangecombModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombModel::len(self : SortexchangecombModel) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombModel::get(
  self : SortexchangecombModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombModel::set(
  self : SortexchangecombModel,
  i : Int32,
  v : Double,
) -> SortexchangecombModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombModel::sum(self : SortexchangecombModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombModel::mean(self : SortexchangecombModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombModel::scale(
  self : SortexchangecombModel,
  f : Double,
) -> SortexchangecombModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombModel::add(
  self : SortexchangecombModel,
  other : SortexchangecombModel,
) -> SortexchangecombModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombModel::copy(
  self : SortexchangecombModel,
) -> SortexchangecombModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombModel::fill(
  self : SortexchangecombModel,
  v : Double,
) -> SortexchangecombModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombModel::min(self : SortexchangecombModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombModel::max(self : SortexchangecombModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombModel::to_string(self : SortexchangecombModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_layer_make(size : Int32) -> SortexchangecombLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombLayer::len(self : SortexchangecombLayer) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombLayer::get(
  self : SortexchangecombLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombLayer::set(
  self : SortexchangecombLayer,
  i : Int32,
  v : Double,
) -> SortexchangecombLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombLayer::sum(self : SortexchangecombLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombLayer::mean(self : SortexchangecombLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombLayer::scale(
  self : SortexchangecombLayer,
  f : Double,
) -> SortexchangecombLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombLayer::add(
  self : SortexchangecombLayer,
  other : SortexchangecombLayer,
) -> SortexchangecombLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombLayer::copy(
  self : SortexchangecombLayer,
) -> SortexchangecombLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombLayer::fill(
  self : SortexchangecombLayer,
  v : Double,
) -> SortexchangecombLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombLayer::min(self : SortexchangecombLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombLayer::max(self : SortexchangecombLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombLayer::to_string(self : SortexchangecombLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_buffer_make(size : Int32) -> SortexchangecombBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombBuffer::len(self : SortexchangecombBuffer) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombBuffer::get(
  self : SortexchangecombBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombBuffer::set(
  self : SortexchangecombBuffer,
  i : Int32,
  v : Double,
) -> SortexchangecombBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombBuffer::sum(self : SortexchangecombBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombBuffer::mean(self : SortexchangecombBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombBuffer::scale(
  self : SortexchangecombBuffer,
  f : Double,
) -> SortexchangecombBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombBuffer::add(
  self : SortexchangecombBuffer,
  other : SortexchangecombBuffer,
) -> SortexchangecombBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombBuffer::copy(
  self : SortexchangecombBuffer,
) -> SortexchangecombBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombBuffer::fill(
  self : SortexchangecombBuffer,
  v : Double,
) -> SortexchangecombBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombBuffer::min(self : SortexchangecombBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombBuffer::max(self : SortexchangecombBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombBuffer::to_string(
  self : SortexchangecombBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_cursor_make(size : Int32) -> SortexchangecombCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombCursor::len(self : SortexchangecombCursor) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombCursor::get(
  self : SortexchangecombCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombCursor::set(
  self : SortexchangecombCursor,
  i : Int32,
  v : Double,
) -> SortexchangecombCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombCursor::sum(self : SortexchangecombCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombCursor::mean(self : SortexchangecombCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombCursor::scale(
  self : SortexchangecombCursor,
  f : Double,
) -> SortexchangecombCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombCursor::add(
  self : SortexchangecombCursor,
  other : SortexchangecombCursor,
) -> SortexchangecombCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombCursor::copy(
  self : SortexchangecombCursor,
) -> SortexchangecombCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombCursor::fill(
  self : SortexchangecombCursor,
  v : Double,
) -> SortexchangecombCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombCursor::min(self : SortexchangecombCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombCursor::max(self : SortexchangecombCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombCursor::to_string(
  self : SortexchangecombCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_view_make(size : Int32) -> SortexchangecombView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombView::len(self : SortexchangecombView) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombView::get(
  self : SortexchangecombView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombView::set(
  self : SortexchangecombView,
  i : Int32,
  v : Double,
) -> SortexchangecombView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombView::sum(self : SortexchangecombView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombView::mean(self : SortexchangecombView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombView::scale(
  self : SortexchangecombView,
  f : Double,
) -> SortexchangecombView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombView::add(
  self : SortexchangecombView,
  other : SortexchangecombView,
) -> SortexchangecombView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombView::copy(
  self : SortexchangecombView,
) -> SortexchangecombView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombView::fill(
  self : SortexchangecombView,
  v : Double,
) -> SortexchangecombView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombView::min(self : SortexchangecombView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombView::max(self : SortexchangecombView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombView::to_string(self : SortexchangecombView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_range_make(size : Int32) -> SortexchangecombRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombRange::len(self : SortexchangecombRange) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombRange::get(
  self : SortexchangecombRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombRange::set(
  self : SortexchangecombRange,
  i : Int32,
  v : Double,
) -> SortexchangecombRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombRange::sum(self : SortexchangecombRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombRange::mean(self : SortexchangecombRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombRange::scale(
  self : SortexchangecombRange,
  f : Double,
) -> SortexchangecombRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombRange::add(
  self : SortexchangecombRange,
  other : SortexchangecombRange,
) -> SortexchangecombRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombRange::copy(
  self : SortexchangecombRange,
) -> SortexchangecombRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombRange::fill(
  self : SortexchangecombRange,
  v : Double,
) -> SortexchangecombRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombRange::min(self : SortexchangecombRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombRange::max(self : SortexchangecombRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombRange::to_string(self : SortexchangecombRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangecombSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_comb_slice_make(size : Int32) -> SortexchangecombSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangecombSlice::len(self : SortexchangecombSlice) -> Int32 {
  self.size
}

///|
pub fn SortexchangecombSlice::get(
  self : SortexchangecombSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangecombSlice::set(
  self : SortexchangecombSlice,
  i : Int32,
  v : Double,
) -> SortexchangecombSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombSlice::sum(self : SortexchangecombSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangecombSlice::mean(self : SortexchangecombSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangecombSlice::scale(
  self : SortexchangecombSlice,
  f : Double,
) -> SortexchangecombSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombSlice::add(
  self : SortexchangecombSlice,
  other : SortexchangecombSlice,
) -> SortexchangecombSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangecombSlice::copy(
  self : SortexchangecombSlice,
) -> SortexchangecombSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombSlice::fill(
  self : SortexchangecombSlice,
  v : Double,
) -> SortexchangecombSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangecombSlice::min(self : SortexchangecombSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangecombSlice::max(self : SortexchangecombSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangecombSlice::to_string(self : SortexchangecombSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
