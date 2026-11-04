///|
///===
/// extcore/graph_connect_biconnect
pub(all) struct GraphconnectbiconnectPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_connect_biconnect_make_point(
  x : Double,
  y : Double,
) -> GraphconnectbiconnectPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_connect_biconnect_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphconnectbiconnectPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphconnectbiconnectPoint::x(
  self : GraphconnectbiconnectPoint,
) -> Double {
  self.x
}

///|
pub fn GraphconnectbiconnectPoint::y(
  self : GraphconnectbiconnectPoint,
) -> Double {
  self.y
}

///|
pub fn GraphconnectbiconnectPoint::z(
  self : GraphconnectbiconnectPoint,
) -> Double {
  self.z
}

///|
pub fn GraphconnectbiconnectPoint::label(
  self : GraphconnectbiconnectPoint,
) -> Int32 {
  self.label
}

///|
pub fn GraphconnectbiconnectPoint::dist(
  self : GraphconnectbiconnectPoint,
  other : GraphconnectbiconnectPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphconnectbiconnectPoint::add(
  self : GraphconnectbiconnectPoint,
  other : GraphconnectbiconnectPoint,
) -> GraphconnectbiconnectPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphconnectbiconnectPoint::sub(
  self : GraphconnectbiconnectPoint,
  other : GraphconnectbiconnectPoint,
) -> GraphconnectbiconnectPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphconnectbiconnectPoint::scale(
  self : GraphconnectbiconnectPoint,
  s : Double,
) -> GraphconnectbiconnectPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphconnectbiconnectPoint::dot(
  self : GraphconnectbiconnectPoint,
  other : GraphconnectbiconnectPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphconnectbiconnectPoint::cross(
  self : GraphconnectbiconnectPoint,
  other : GraphconnectbiconnectPoint,
) -> GraphconnectbiconnectPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphconnectbiconnectPoint::norm(
  self : GraphconnectbiconnectPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphconnectbiconnectPoint::normalize(
  self : GraphconnectbiconnectPoint,
) -> GraphconnectbiconnectPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphconnectbiconnectPoint::negate(
  self : GraphconnectbiconnectPoint,
) -> GraphconnectbiconnectPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphconnectbiconnectPoint::mid(
  self : GraphconnectbiconnectPoint,
  other : GraphconnectbiconnectPoint,
) -> GraphconnectbiconnectPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphconnectbiconnectPoint::lerp(
  self : GraphconnectbiconnectPoint,
  other : GraphconnectbiconnectPoint,
  t : Double,
) -> GraphconnectbiconnectPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphconnectbiconnectPoint::to_string(
  self : GraphconnectbiconnectPoint,
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
pub(all) struct GraphconnectbiconnectSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_connect_biconnect_make_series(
  vals : Array[Double],
  name : String,
) -> GraphconnectbiconnectSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphconnectbiconnectSeries::len(
  self : GraphconnectbiconnectSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphconnectbiconnectSeries::sum(
  self : GraphconnectbiconnectSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphconnectbiconnectSeries::mean(
  self : GraphconnectbiconnectSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphconnectbiconnectSeries::min(
  self : GraphconnectbiconnectSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphconnectbiconnectSeries::max(
  self : GraphconnectbiconnectSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphconnectbiconnectSeries::range(
  self : GraphconnectbiconnectSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphconnectbiconnectSeries::variance(
  self : GraphconnectbiconnectSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphconnectbiconnectSeries::std(
  self : GraphconnectbiconnectSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphconnectbiconnectSeries::median(
  self : GraphconnectbiconnectSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphconnectbiconnectSeries::scale(
  self : GraphconnectbiconnectSeries,
  f : Double,
) -> GraphconnectbiconnectSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphconnectbiconnectSeries::add(
  self : GraphconnectbiconnectSeries,
  other : GraphconnectbiconnectSeries,
) -> GraphconnectbiconnectSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphconnectbiconnectSeries::sub(
  self : GraphconnectbiconnectSeries,
  other : GraphconnectbiconnectSeries,
) -> GraphconnectbiconnectSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphconnectbiconnectSeries::normalize(
  self : GraphconnectbiconnectSeries,
) -> GraphconnectbiconnectSeries {
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
pub fn GraphconnectbiconnectSeries::cumsum(
  self : GraphconnectbiconnectSeries,
) -> GraphconnectbiconnectSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphconnectbiconnectSeries::to_string(
  self : GraphconnectbiconnectSeries,
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
pub(all) struct GraphconnectbiconnectMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_connect_biconnect_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphconnectbiconnectMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_connect_biconnect_matrix_identity(
  n : Int32,
) -> GraphconnectbiconnectMatrix {
  let m = graph_connect_biconnect_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphconnectbiconnectMatrix::get(
  self : GraphconnectbiconnectMatrix,
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
pub fn GraphconnectbiconnectMatrix::transpose(
  self : GraphconnectbiconnectMatrix,
) -> GraphconnectbiconnectMatrix {
  let result = graph_connect_biconnect_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphconnectbiconnectMatrix::add(
  self : GraphconnectbiconnectMatrix,
  other : GraphconnectbiconnectMatrix,
) -> GraphconnectbiconnectMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_connect_biconnect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphconnectbiconnectMatrix::scale(
  self : GraphconnectbiconnectMatrix,
  s : Double,
) -> GraphconnectbiconnectMatrix {
  let result = graph_connect_biconnect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphconnectbiconnectMatrix::multiply(
  self : GraphconnectbiconnectMatrix,
  other : GraphconnectbiconnectMatrix,
) -> GraphconnectbiconnectMatrix {
  if self.cols != other.rows {
    return graph_connect_biconnect_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_connect_biconnect_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphconnectbiconnectMatrix::trace(
  self : GraphconnectbiconnectMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphconnectbiconnectMatrix::det(
  self : GraphconnectbiconnectMatrix,
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
pub fn GraphconnectbiconnectMatrix::norm(
  self : GraphconnectbiconnectMatrix,
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
pub fn GraphconnectbiconnectMatrix::to_string(
  self : GraphconnectbiconnectMatrix,
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
pub(all) struct GraphconnectbiconnectVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_connect_biconnect_make_vector(
  comps : Array[Double],
) -> GraphconnectbiconnectVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_connect_biconnect_vector_zero(
  dim : Int32,
) -> GraphconnectbiconnectVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphconnectbiconnectVector::add(
  self : GraphconnectbiconnectVector,
  other : GraphconnectbiconnectVector,
) -> GraphconnectbiconnectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphconnectbiconnectVector::sub(
  self : GraphconnectbiconnectVector,
  other : GraphconnectbiconnectVector,
) -> GraphconnectbiconnectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphconnectbiconnectVector::scale(
  self : GraphconnectbiconnectVector,
  s : Double,
) -> GraphconnectbiconnectVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphconnectbiconnectVector::dot(
  self : GraphconnectbiconnectVector,
  other : GraphconnectbiconnectVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphconnectbiconnectVector::norm(
  self : GraphconnectbiconnectVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphconnectbiconnectVector::normalize(
  self : GraphconnectbiconnectVector,
) -> GraphconnectbiconnectVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphconnectbiconnectVector::dist(
  self : GraphconnectbiconnectVector,
  other : GraphconnectbiconnectVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphconnectbiconnectVector::to_string(
  self : GraphconnectbiconnectVector,
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
pub(all) struct GraphconnectbiconnectFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_frame_make(
  size : Int32,
) -> GraphconnectbiconnectFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectFrame::len(
  self : GraphconnectbiconnectFrame,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectFrame::get(
  self : GraphconnectbiconnectFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectFrame::set(
  self : GraphconnectbiconnectFrame,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectFrame::sum(
  self : GraphconnectbiconnectFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectFrame::mean(
  self : GraphconnectbiconnectFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectFrame::scale(
  self : GraphconnectbiconnectFrame,
  f : Double,
) -> GraphconnectbiconnectFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectFrame::add(
  self : GraphconnectbiconnectFrame,
  other : GraphconnectbiconnectFrame,
) -> GraphconnectbiconnectFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectFrame::copy(
  self : GraphconnectbiconnectFrame,
) -> GraphconnectbiconnectFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectFrame::fill(
  self : GraphconnectbiconnectFrame,
  v : Double,
) -> GraphconnectbiconnectFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectFrame::min(
  self : GraphconnectbiconnectFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectFrame::max(
  self : GraphconnectbiconnectFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectFrame::to_string(
  self : GraphconnectbiconnectFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_table_make(
  size : Int32,
) -> GraphconnectbiconnectTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectTable::len(
  self : GraphconnectbiconnectTable,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectTable::get(
  self : GraphconnectbiconnectTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectTable::set(
  self : GraphconnectbiconnectTable,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectTable::sum(
  self : GraphconnectbiconnectTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectTable::mean(
  self : GraphconnectbiconnectTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectTable::scale(
  self : GraphconnectbiconnectTable,
  f : Double,
) -> GraphconnectbiconnectTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectTable::add(
  self : GraphconnectbiconnectTable,
  other : GraphconnectbiconnectTable,
) -> GraphconnectbiconnectTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectTable::copy(
  self : GraphconnectbiconnectTable,
) -> GraphconnectbiconnectTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectTable::fill(
  self : GraphconnectbiconnectTable,
  v : Double,
) -> GraphconnectbiconnectTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectTable::min(
  self : GraphconnectbiconnectTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectTable::max(
  self : GraphconnectbiconnectTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectTable::to_string(
  self : GraphconnectbiconnectTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_graphn_make(
  size : Int32,
) -> GraphconnectbiconnectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectGraphN::len(
  self : GraphconnectbiconnectGraphN,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectGraphN::get(
  self : GraphconnectbiconnectGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectGraphN::set(
  self : GraphconnectbiconnectGraphN,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectGraphN::sum(
  self : GraphconnectbiconnectGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectGraphN::mean(
  self : GraphconnectbiconnectGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectGraphN::scale(
  self : GraphconnectbiconnectGraphN,
  f : Double,
) -> GraphconnectbiconnectGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectGraphN::add(
  self : GraphconnectbiconnectGraphN,
  other : GraphconnectbiconnectGraphN,
) -> GraphconnectbiconnectGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectGraphN::copy(
  self : GraphconnectbiconnectGraphN,
) -> GraphconnectbiconnectGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectGraphN::fill(
  self : GraphconnectbiconnectGraphN,
  v : Double,
) -> GraphconnectbiconnectGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectGraphN::min(
  self : GraphconnectbiconnectGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectGraphN::max(
  self : GraphconnectbiconnectGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectGraphN::to_string(
  self : GraphconnectbiconnectGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_node_make(
  size : Int32,
) -> GraphconnectbiconnectNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectNode::len(
  self : GraphconnectbiconnectNode,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectNode::get(
  self : GraphconnectbiconnectNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectNode::set(
  self : GraphconnectbiconnectNode,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectNode::sum(
  self : GraphconnectbiconnectNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectNode::mean(
  self : GraphconnectbiconnectNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectNode::scale(
  self : GraphconnectbiconnectNode,
  f : Double,
) -> GraphconnectbiconnectNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectNode::add(
  self : GraphconnectbiconnectNode,
  other : GraphconnectbiconnectNode,
) -> GraphconnectbiconnectNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectNode::copy(
  self : GraphconnectbiconnectNode,
) -> GraphconnectbiconnectNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectNode::fill(
  self : GraphconnectbiconnectNode,
  v : Double,
) -> GraphconnectbiconnectNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectNode::min(
  self : GraphconnectbiconnectNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectNode::max(
  self : GraphconnectbiconnectNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectNode::to_string(
  self : GraphconnectbiconnectNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_edge_make(
  size : Int32,
) -> GraphconnectbiconnectEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectEdge::len(
  self : GraphconnectbiconnectEdge,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectEdge::get(
  self : GraphconnectbiconnectEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectEdge::set(
  self : GraphconnectbiconnectEdge,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectEdge::sum(
  self : GraphconnectbiconnectEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectEdge::mean(
  self : GraphconnectbiconnectEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectEdge::scale(
  self : GraphconnectbiconnectEdge,
  f : Double,
) -> GraphconnectbiconnectEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectEdge::add(
  self : GraphconnectbiconnectEdge,
  other : GraphconnectbiconnectEdge,
) -> GraphconnectbiconnectEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectEdge::copy(
  self : GraphconnectbiconnectEdge,
) -> GraphconnectbiconnectEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectEdge::fill(
  self : GraphconnectbiconnectEdge,
  v : Double,
) -> GraphconnectbiconnectEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectEdge::min(
  self : GraphconnectbiconnectEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectEdge::max(
  self : GraphconnectbiconnectEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectEdge::to_string(
  self : GraphconnectbiconnectEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_path_make(
  size : Int32,
) -> GraphconnectbiconnectPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectPath::len(
  self : GraphconnectbiconnectPath,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectPath::get(
  self : GraphconnectbiconnectPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectPath::set(
  self : GraphconnectbiconnectPath,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectPath::sum(
  self : GraphconnectbiconnectPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectPath::mean(
  self : GraphconnectbiconnectPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectPath::scale(
  self : GraphconnectbiconnectPath,
  f : Double,
) -> GraphconnectbiconnectPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectPath::add(
  self : GraphconnectbiconnectPath,
  other : GraphconnectbiconnectPath,
) -> GraphconnectbiconnectPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectPath::copy(
  self : GraphconnectbiconnectPath,
) -> GraphconnectbiconnectPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectPath::fill(
  self : GraphconnectbiconnectPath,
  v : Double,
) -> GraphconnectbiconnectPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectPath::min(
  self : GraphconnectbiconnectPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectPath::max(
  self : GraphconnectbiconnectPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectPath::to_string(
  self : GraphconnectbiconnectPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_cluster_make(
  size : Int32,
) -> GraphconnectbiconnectCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectCluster::len(
  self : GraphconnectbiconnectCluster,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectCluster::get(
  self : GraphconnectbiconnectCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectCluster::set(
  self : GraphconnectbiconnectCluster,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectCluster::sum(
  self : GraphconnectbiconnectCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectCluster::mean(
  self : GraphconnectbiconnectCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectCluster::scale(
  self : GraphconnectbiconnectCluster,
  f : Double,
) -> GraphconnectbiconnectCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectCluster::add(
  self : GraphconnectbiconnectCluster,
  other : GraphconnectbiconnectCluster,
) -> GraphconnectbiconnectCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectCluster::copy(
  self : GraphconnectbiconnectCluster,
) -> GraphconnectbiconnectCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectCluster::fill(
  self : GraphconnectbiconnectCluster,
  v : Double,
) -> GraphconnectbiconnectCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectCluster::min(
  self : GraphconnectbiconnectCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectCluster::max(
  self : GraphconnectbiconnectCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectCluster::to_string(
  self : GraphconnectbiconnectCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_model_make(
  size : Int32,
) -> GraphconnectbiconnectModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectModel::len(
  self : GraphconnectbiconnectModel,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectModel::get(
  self : GraphconnectbiconnectModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectModel::set(
  self : GraphconnectbiconnectModel,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectModel::sum(
  self : GraphconnectbiconnectModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectModel::mean(
  self : GraphconnectbiconnectModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectModel::scale(
  self : GraphconnectbiconnectModel,
  f : Double,
) -> GraphconnectbiconnectModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectModel::add(
  self : GraphconnectbiconnectModel,
  other : GraphconnectbiconnectModel,
) -> GraphconnectbiconnectModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectModel::copy(
  self : GraphconnectbiconnectModel,
) -> GraphconnectbiconnectModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectModel::fill(
  self : GraphconnectbiconnectModel,
  v : Double,
) -> GraphconnectbiconnectModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectModel::min(
  self : GraphconnectbiconnectModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectModel::max(
  self : GraphconnectbiconnectModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectModel::to_string(
  self : GraphconnectbiconnectModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_layer_make(
  size : Int32,
) -> GraphconnectbiconnectLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectLayer::len(
  self : GraphconnectbiconnectLayer,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectLayer::get(
  self : GraphconnectbiconnectLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectLayer::set(
  self : GraphconnectbiconnectLayer,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectLayer::sum(
  self : GraphconnectbiconnectLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectLayer::mean(
  self : GraphconnectbiconnectLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectLayer::scale(
  self : GraphconnectbiconnectLayer,
  f : Double,
) -> GraphconnectbiconnectLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectLayer::add(
  self : GraphconnectbiconnectLayer,
  other : GraphconnectbiconnectLayer,
) -> GraphconnectbiconnectLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectLayer::copy(
  self : GraphconnectbiconnectLayer,
) -> GraphconnectbiconnectLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectLayer::fill(
  self : GraphconnectbiconnectLayer,
  v : Double,
) -> GraphconnectbiconnectLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectLayer::min(
  self : GraphconnectbiconnectLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectLayer::max(
  self : GraphconnectbiconnectLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectLayer::to_string(
  self : GraphconnectbiconnectLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_buffer_make(
  size : Int32,
) -> GraphconnectbiconnectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectBuffer::len(
  self : GraphconnectbiconnectBuffer,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectBuffer::get(
  self : GraphconnectbiconnectBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectBuffer::set(
  self : GraphconnectbiconnectBuffer,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectBuffer::sum(
  self : GraphconnectbiconnectBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectBuffer::mean(
  self : GraphconnectbiconnectBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectBuffer::scale(
  self : GraphconnectbiconnectBuffer,
  f : Double,
) -> GraphconnectbiconnectBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectBuffer::add(
  self : GraphconnectbiconnectBuffer,
  other : GraphconnectbiconnectBuffer,
) -> GraphconnectbiconnectBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectBuffer::copy(
  self : GraphconnectbiconnectBuffer,
) -> GraphconnectbiconnectBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectBuffer::fill(
  self : GraphconnectbiconnectBuffer,
  v : Double,
) -> GraphconnectbiconnectBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectBuffer::min(
  self : GraphconnectbiconnectBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectBuffer::max(
  self : GraphconnectbiconnectBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectBuffer::to_string(
  self : GraphconnectbiconnectBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_cursor_make(
  size : Int32,
) -> GraphconnectbiconnectCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectCursor::len(
  self : GraphconnectbiconnectCursor,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectCursor::get(
  self : GraphconnectbiconnectCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectCursor::set(
  self : GraphconnectbiconnectCursor,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectCursor::sum(
  self : GraphconnectbiconnectCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectCursor::mean(
  self : GraphconnectbiconnectCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectCursor::scale(
  self : GraphconnectbiconnectCursor,
  f : Double,
) -> GraphconnectbiconnectCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectCursor::add(
  self : GraphconnectbiconnectCursor,
  other : GraphconnectbiconnectCursor,
) -> GraphconnectbiconnectCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectCursor::copy(
  self : GraphconnectbiconnectCursor,
) -> GraphconnectbiconnectCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectCursor::fill(
  self : GraphconnectbiconnectCursor,
  v : Double,
) -> GraphconnectbiconnectCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectCursor::min(
  self : GraphconnectbiconnectCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectCursor::max(
  self : GraphconnectbiconnectCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectCursor::to_string(
  self : GraphconnectbiconnectCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_view_make(
  size : Int32,
) -> GraphconnectbiconnectView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectView::len(
  self : GraphconnectbiconnectView,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectView::get(
  self : GraphconnectbiconnectView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectView::set(
  self : GraphconnectbiconnectView,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectView::sum(
  self : GraphconnectbiconnectView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectView::mean(
  self : GraphconnectbiconnectView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectView::scale(
  self : GraphconnectbiconnectView,
  f : Double,
) -> GraphconnectbiconnectView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectView::add(
  self : GraphconnectbiconnectView,
  other : GraphconnectbiconnectView,
) -> GraphconnectbiconnectView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectView::copy(
  self : GraphconnectbiconnectView,
) -> GraphconnectbiconnectView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectView::fill(
  self : GraphconnectbiconnectView,
  v : Double,
) -> GraphconnectbiconnectView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectView::min(
  self : GraphconnectbiconnectView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectView::max(
  self : GraphconnectbiconnectView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectView::to_string(
  self : GraphconnectbiconnectView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_range_make(
  size : Int32,
) -> GraphconnectbiconnectRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectRange::len(
  self : GraphconnectbiconnectRange,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectRange::get(
  self : GraphconnectbiconnectRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectRange::set(
  self : GraphconnectbiconnectRange,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectRange::sum(
  self : GraphconnectbiconnectRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectRange::mean(
  self : GraphconnectbiconnectRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectRange::scale(
  self : GraphconnectbiconnectRange,
  f : Double,
) -> GraphconnectbiconnectRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectRange::add(
  self : GraphconnectbiconnectRange,
  other : GraphconnectbiconnectRange,
) -> GraphconnectbiconnectRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectRange::copy(
  self : GraphconnectbiconnectRange,
) -> GraphconnectbiconnectRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectRange::fill(
  self : GraphconnectbiconnectRange,
  v : Double,
) -> GraphconnectbiconnectRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectRange::min(
  self : GraphconnectbiconnectRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectRange::max(
  self : GraphconnectbiconnectRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectRange::to_string(
  self : GraphconnectbiconnectRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectbiconnectSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_biconnect_slice_make(
  size : Int32,
) -> GraphconnectbiconnectSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectbiconnectSlice::len(
  self : GraphconnectbiconnectSlice,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectbiconnectSlice::get(
  self : GraphconnectbiconnectSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectbiconnectSlice::set(
  self : GraphconnectbiconnectSlice,
  i : Int32,
  v : Double,
) -> GraphconnectbiconnectSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectSlice::sum(
  self : GraphconnectbiconnectSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectbiconnectSlice::mean(
  self : GraphconnectbiconnectSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectbiconnectSlice::scale(
  self : GraphconnectbiconnectSlice,
  f : Double,
) -> GraphconnectbiconnectSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectSlice::add(
  self : GraphconnectbiconnectSlice,
  other : GraphconnectbiconnectSlice,
) -> GraphconnectbiconnectSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectSlice::copy(
  self : GraphconnectbiconnectSlice,
) -> GraphconnectbiconnectSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectSlice::fill(
  self : GraphconnectbiconnectSlice,
  v : Double,
) -> GraphconnectbiconnectSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectbiconnectSlice::min(
  self : GraphconnectbiconnectSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectbiconnectSlice::max(
  self : GraphconnectbiconnectSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectbiconnectSlice::to_string(
  self : GraphconnectbiconnectSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
