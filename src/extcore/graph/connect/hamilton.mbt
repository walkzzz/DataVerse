///|
///===
/// extcore/graph_connect_hamilton
pub(all) struct GraphconnecthamiltonPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_connect_hamilton_make_point(
  x : Double,
  y : Double,
) -> GraphconnecthamiltonPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_connect_hamilton_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphconnecthamiltonPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphconnecthamiltonPoint::x(self : GraphconnecthamiltonPoint) -> Double {
  self.x
}

///|
pub fn GraphconnecthamiltonPoint::y(self : GraphconnecthamiltonPoint) -> Double {
  self.y
}

///|
pub fn GraphconnecthamiltonPoint::z(self : GraphconnecthamiltonPoint) -> Double {
  self.z
}

///|
pub fn GraphconnecthamiltonPoint::label(
  self : GraphconnecthamiltonPoint,
) -> Int32 {
  self.label
}

///|
pub fn GraphconnecthamiltonPoint::dist(
  self : GraphconnecthamiltonPoint,
  other : GraphconnecthamiltonPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphconnecthamiltonPoint::add(
  self : GraphconnecthamiltonPoint,
  other : GraphconnecthamiltonPoint,
) -> GraphconnecthamiltonPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphconnecthamiltonPoint::sub(
  self : GraphconnecthamiltonPoint,
  other : GraphconnecthamiltonPoint,
) -> GraphconnecthamiltonPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphconnecthamiltonPoint::scale(
  self : GraphconnecthamiltonPoint,
  s : Double,
) -> GraphconnecthamiltonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphconnecthamiltonPoint::dot(
  self : GraphconnecthamiltonPoint,
  other : GraphconnecthamiltonPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphconnecthamiltonPoint::cross(
  self : GraphconnecthamiltonPoint,
  other : GraphconnecthamiltonPoint,
) -> GraphconnecthamiltonPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphconnecthamiltonPoint::norm(
  self : GraphconnecthamiltonPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphconnecthamiltonPoint::normalize(
  self : GraphconnecthamiltonPoint,
) -> GraphconnecthamiltonPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphconnecthamiltonPoint::negate(
  self : GraphconnecthamiltonPoint,
) -> GraphconnecthamiltonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphconnecthamiltonPoint::mid(
  self : GraphconnecthamiltonPoint,
  other : GraphconnecthamiltonPoint,
) -> GraphconnecthamiltonPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphconnecthamiltonPoint::lerp(
  self : GraphconnecthamiltonPoint,
  other : GraphconnecthamiltonPoint,
  t : Double,
) -> GraphconnecthamiltonPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphconnecthamiltonPoint::to_string(
  self : GraphconnecthamiltonPoint,
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
pub(all) struct GraphconnecthamiltonSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_connect_hamilton_make_series(
  vals : Array[Double],
  name : String,
) -> GraphconnecthamiltonSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphconnecthamiltonSeries::len(
  self : GraphconnecthamiltonSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphconnecthamiltonSeries::sum(
  self : GraphconnecthamiltonSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphconnecthamiltonSeries::mean(
  self : GraphconnecthamiltonSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphconnecthamiltonSeries::min(
  self : GraphconnecthamiltonSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphconnecthamiltonSeries::max(
  self : GraphconnecthamiltonSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphconnecthamiltonSeries::range(
  self : GraphconnecthamiltonSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphconnecthamiltonSeries::variance(
  self : GraphconnecthamiltonSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphconnecthamiltonSeries::std(
  self : GraphconnecthamiltonSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphconnecthamiltonSeries::median(
  self : GraphconnecthamiltonSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphconnecthamiltonSeries::scale(
  self : GraphconnecthamiltonSeries,
  f : Double,
) -> GraphconnecthamiltonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphconnecthamiltonSeries::add(
  self : GraphconnecthamiltonSeries,
  other : GraphconnecthamiltonSeries,
) -> GraphconnecthamiltonSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphconnecthamiltonSeries::sub(
  self : GraphconnecthamiltonSeries,
  other : GraphconnecthamiltonSeries,
) -> GraphconnecthamiltonSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphconnecthamiltonSeries::normalize(
  self : GraphconnecthamiltonSeries,
) -> GraphconnecthamiltonSeries {
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
pub fn GraphconnecthamiltonSeries::cumsum(
  self : GraphconnecthamiltonSeries,
) -> GraphconnecthamiltonSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphconnecthamiltonSeries::to_string(
  self : GraphconnecthamiltonSeries,
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
pub(all) struct GraphconnecthamiltonMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_connect_hamilton_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphconnecthamiltonMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_connect_hamilton_matrix_identity(
  n : Int32,
) -> GraphconnecthamiltonMatrix {
  let m = graph_connect_hamilton_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphconnecthamiltonMatrix::get(
  self : GraphconnecthamiltonMatrix,
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
pub fn GraphconnecthamiltonMatrix::transpose(
  self : GraphconnecthamiltonMatrix,
) -> GraphconnecthamiltonMatrix {
  let result = graph_connect_hamilton_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphconnecthamiltonMatrix::add(
  self : GraphconnecthamiltonMatrix,
  other : GraphconnecthamiltonMatrix,
) -> GraphconnecthamiltonMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_connect_hamilton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphconnecthamiltonMatrix::scale(
  self : GraphconnecthamiltonMatrix,
  s : Double,
) -> GraphconnecthamiltonMatrix {
  let result = graph_connect_hamilton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphconnecthamiltonMatrix::multiply(
  self : GraphconnecthamiltonMatrix,
  other : GraphconnecthamiltonMatrix,
) -> GraphconnecthamiltonMatrix {
  if self.cols != other.rows {
    return graph_connect_hamilton_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_connect_hamilton_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphconnecthamiltonMatrix::trace(
  self : GraphconnecthamiltonMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphconnecthamiltonMatrix::det(
  self : GraphconnecthamiltonMatrix,
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
pub fn GraphconnecthamiltonMatrix::norm(
  self : GraphconnecthamiltonMatrix,
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
pub fn GraphconnecthamiltonMatrix::to_string(
  self : GraphconnecthamiltonMatrix,
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
pub(all) struct GraphconnecthamiltonVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_connect_hamilton_make_vector(
  comps : Array[Double],
) -> GraphconnecthamiltonVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_connect_hamilton_vector_zero(
  dim : Int32,
) -> GraphconnecthamiltonVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphconnecthamiltonVector::add(
  self : GraphconnecthamiltonVector,
  other : GraphconnecthamiltonVector,
) -> GraphconnecthamiltonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphconnecthamiltonVector::sub(
  self : GraphconnecthamiltonVector,
  other : GraphconnecthamiltonVector,
) -> GraphconnecthamiltonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphconnecthamiltonVector::scale(
  self : GraphconnecthamiltonVector,
  s : Double,
) -> GraphconnecthamiltonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphconnecthamiltonVector::dot(
  self : GraphconnecthamiltonVector,
  other : GraphconnecthamiltonVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphconnecthamiltonVector::norm(
  self : GraphconnecthamiltonVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphconnecthamiltonVector::normalize(
  self : GraphconnecthamiltonVector,
) -> GraphconnecthamiltonVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphconnecthamiltonVector::dist(
  self : GraphconnecthamiltonVector,
  other : GraphconnecthamiltonVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphconnecthamiltonVector::to_string(
  self : GraphconnecthamiltonVector,
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
pub(all) struct GraphconnecthamiltonFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_frame_make(
  size : Int32,
) -> GraphconnecthamiltonFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonFrame::len(
  self : GraphconnecthamiltonFrame,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonFrame::get(
  self : GraphconnecthamiltonFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonFrame::set(
  self : GraphconnecthamiltonFrame,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonFrame::sum(
  self : GraphconnecthamiltonFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonFrame::mean(
  self : GraphconnecthamiltonFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonFrame::scale(
  self : GraphconnecthamiltonFrame,
  f : Double,
) -> GraphconnecthamiltonFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonFrame::add(
  self : GraphconnecthamiltonFrame,
  other : GraphconnecthamiltonFrame,
) -> GraphconnecthamiltonFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonFrame::copy(
  self : GraphconnecthamiltonFrame,
) -> GraphconnecthamiltonFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonFrame::fill(
  self : GraphconnecthamiltonFrame,
  v : Double,
) -> GraphconnecthamiltonFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonFrame::min(
  self : GraphconnecthamiltonFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonFrame::max(
  self : GraphconnecthamiltonFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonFrame::to_string(
  self : GraphconnecthamiltonFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_table_make(
  size : Int32,
) -> GraphconnecthamiltonTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonTable::len(
  self : GraphconnecthamiltonTable,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonTable::get(
  self : GraphconnecthamiltonTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonTable::set(
  self : GraphconnecthamiltonTable,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonTable::sum(
  self : GraphconnecthamiltonTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonTable::mean(
  self : GraphconnecthamiltonTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonTable::scale(
  self : GraphconnecthamiltonTable,
  f : Double,
) -> GraphconnecthamiltonTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonTable::add(
  self : GraphconnecthamiltonTable,
  other : GraphconnecthamiltonTable,
) -> GraphconnecthamiltonTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonTable::copy(
  self : GraphconnecthamiltonTable,
) -> GraphconnecthamiltonTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonTable::fill(
  self : GraphconnecthamiltonTable,
  v : Double,
) -> GraphconnecthamiltonTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonTable::min(
  self : GraphconnecthamiltonTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonTable::max(
  self : GraphconnecthamiltonTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonTable::to_string(
  self : GraphconnecthamiltonTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_graphn_make(
  size : Int32,
) -> GraphconnecthamiltonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonGraphN::len(
  self : GraphconnecthamiltonGraphN,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonGraphN::get(
  self : GraphconnecthamiltonGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonGraphN::set(
  self : GraphconnecthamiltonGraphN,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonGraphN::sum(
  self : GraphconnecthamiltonGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonGraphN::mean(
  self : GraphconnecthamiltonGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonGraphN::scale(
  self : GraphconnecthamiltonGraphN,
  f : Double,
) -> GraphconnecthamiltonGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonGraphN::add(
  self : GraphconnecthamiltonGraphN,
  other : GraphconnecthamiltonGraphN,
) -> GraphconnecthamiltonGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonGraphN::copy(
  self : GraphconnecthamiltonGraphN,
) -> GraphconnecthamiltonGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonGraphN::fill(
  self : GraphconnecthamiltonGraphN,
  v : Double,
) -> GraphconnecthamiltonGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonGraphN::min(
  self : GraphconnecthamiltonGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonGraphN::max(
  self : GraphconnecthamiltonGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonGraphN::to_string(
  self : GraphconnecthamiltonGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_node_make(
  size : Int32,
) -> GraphconnecthamiltonNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonNode::len(self : GraphconnecthamiltonNode) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonNode::get(
  self : GraphconnecthamiltonNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonNode::set(
  self : GraphconnecthamiltonNode,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonNode::sum(self : GraphconnecthamiltonNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonNode::mean(
  self : GraphconnecthamiltonNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonNode::scale(
  self : GraphconnecthamiltonNode,
  f : Double,
) -> GraphconnecthamiltonNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonNode::add(
  self : GraphconnecthamiltonNode,
  other : GraphconnecthamiltonNode,
) -> GraphconnecthamiltonNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonNode::copy(
  self : GraphconnecthamiltonNode,
) -> GraphconnecthamiltonNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonNode::fill(
  self : GraphconnecthamiltonNode,
  v : Double,
) -> GraphconnecthamiltonNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonNode::min(self : GraphconnecthamiltonNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonNode::max(self : GraphconnecthamiltonNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonNode::to_string(
  self : GraphconnecthamiltonNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_edge_make(
  size : Int32,
) -> GraphconnecthamiltonEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonEdge::len(self : GraphconnecthamiltonEdge) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonEdge::get(
  self : GraphconnecthamiltonEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonEdge::set(
  self : GraphconnecthamiltonEdge,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonEdge::sum(self : GraphconnecthamiltonEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonEdge::mean(
  self : GraphconnecthamiltonEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonEdge::scale(
  self : GraphconnecthamiltonEdge,
  f : Double,
) -> GraphconnecthamiltonEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonEdge::add(
  self : GraphconnecthamiltonEdge,
  other : GraphconnecthamiltonEdge,
) -> GraphconnecthamiltonEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonEdge::copy(
  self : GraphconnecthamiltonEdge,
) -> GraphconnecthamiltonEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonEdge::fill(
  self : GraphconnecthamiltonEdge,
  v : Double,
) -> GraphconnecthamiltonEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonEdge::min(self : GraphconnecthamiltonEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonEdge::max(self : GraphconnecthamiltonEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonEdge::to_string(
  self : GraphconnecthamiltonEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_path_make(
  size : Int32,
) -> GraphconnecthamiltonPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonPath::len(self : GraphconnecthamiltonPath) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonPath::get(
  self : GraphconnecthamiltonPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonPath::set(
  self : GraphconnecthamiltonPath,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonPath::sum(self : GraphconnecthamiltonPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonPath::mean(
  self : GraphconnecthamiltonPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonPath::scale(
  self : GraphconnecthamiltonPath,
  f : Double,
) -> GraphconnecthamiltonPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonPath::add(
  self : GraphconnecthamiltonPath,
  other : GraphconnecthamiltonPath,
) -> GraphconnecthamiltonPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonPath::copy(
  self : GraphconnecthamiltonPath,
) -> GraphconnecthamiltonPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonPath::fill(
  self : GraphconnecthamiltonPath,
  v : Double,
) -> GraphconnecthamiltonPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonPath::min(self : GraphconnecthamiltonPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonPath::max(self : GraphconnecthamiltonPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonPath::to_string(
  self : GraphconnecthamiltonPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_cluster_make(
  size : Int32,
) -> GraphconnecthamiltonCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonCluster::len(
  self : GraphconnecthamiltonCluster,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonCluster::get(
  self : GraphconnecthamiltonCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonCluster::set(
  self : GraphconnecthamiltonCluster,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonCluster::sum(
  self : GraphconnecthamiltonCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonCluster::mean(
  self : GraphconnecthamiltonCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonCluster::scale(
  self : GraphconnecthamiltonCluster,
  f : Double,
) -> GraphconnecthamiltonCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonCluster::add(
  self : GraphconnecthamiltonCluster,
  other : GraphconnecthamiltonCluster,
) -> GraphconnecthamiltonCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonCluster::copy(
  self : GraphconnecthamiltonCluster,
) -> GraphconnecthamiltonCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonCluster::fill(
  self : GraphconnecthamiltonCluster,
  v : Double,
) -> GraphconnecthamiltonCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonCluster::min(
  self : GraphconnecthamiltonCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonCluster::max(
  self : GraphconnecthamiltonCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonCluster::to_string(
  self : GraphconnecthamiltonCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_model_make(
  size : Int32,
) -> GraphconnecthamiltonModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonModel::len(
  self : GraphconnecthamiltonModel,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonModel::get(
  self : GraphconnecthamiltonModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonModel::set(
  self : GraphconnecthamiltonModel,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonModel::sum(
  self : GraphconnecthamiltonModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonModel::mean(
  self : GraphconnecthamiltonModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonModel::scale(
  self : GraphconnecthamiltonModel,
  f : Double,
) -> GraphconnecthamiltonModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonModel::add(
  self : GraphconnecthamiltonModel,
  other : GraphconnecthamiltonModel,
) -> GraphconnecthamiltonModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonModel::copy(
  self : GraphconnecthamiltonModel,
) -> GraphconnecthamiltonModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonModel::fill(
  self : GraphconnecthamiltonModel,
  v : Double,
) -> GraphconnecthamiltonModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonModel::min(
  self : GraphconnecthamiltonModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonModel::max(
  self : GraphconnecthamiltonModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonModel::to_string(
  self : GraphconnecthamiltonModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_layer_make(
  size : Int32,
) -> GraphconnecthamiltonLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonLayer::len(
  self : GraphconnecthamiltonLayer,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonLayer::get(
  self : GraphconnecthamiltonLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonLayer::set(
  self : GraphconnecthamiltonLayer,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonLayer::sum(
  self : GraphconnecthamiltonLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonLayer::mean(
  self : GraphconnecthamiltonLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonLayer::scale(
  self : GraphconnecthamiltonLayer,
  f : Double,
) -> GraphconnecthamiltonLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonLayer::add(
  self : GraphconnecthamiltonLayer,
  other : GraphconnecthamiltonLayer,
) -> GraphconnecthamiltonLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonLayer::copy(
  self : GraphconnecthamiltonLayer,
) -> GraphconnecthamiltonLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonLayer::fill(
  self : GraphconnecthamiltonLayer,
  v : Double,
) -> GraphconnecthamiltonLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonLayer::min(
  self : GraphconnecthamiltonLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonLayer::max(
  self : GraphconnecthamiltonLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonLayer::to_string(
  self : GraphconnecthamiltonLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_buffer_make(
  size : Int32,
) -> GraphconnecthamiltonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonBuffer::len(
  self : GraphconnecthamiltonBuffer,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonBuffer::get(
  self : GraphconnecthamiltonBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonBuffer::set(
  self : GraphconnecthamiltonBuffer,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonBuffer::sum(
  self : GraphconnecthamiltonBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonBuffer::mean(
  self : GraphconnecthamiltonBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonBuffer::scale(
  self : GraphconnecthamiltonBuffer,
  f : Double,
) -> GraphconnecthamiltonBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonBuffer::add(
  self : GraphconnecthamiltonBuffer,
  other : GraphconnecthamiltonBuffer,
) -> GraphconnecthamiltonBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonBuffer::copy(
  self : GraphconnecthamiltonBuffer,
) -> GraphconnecthamiltonBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonBuffer::fill(
  self : GraphconnecthamiltonBuffer,
  v : Double,
) -> GraphconnecthamiltonBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonBuffer::min(
  self : GraphconnecthamiltonBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonBuffer::max(
  self : GraphconnecthamiltonBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonBuffer::to_string(
  self : GraphconnecthamiltonBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_cursor_make(
  size : Int32,
) -> GraphconnecthamiltonCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonCursor::len(
  self : GraphconnecthamiltonCursor,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonCursor::get(
  self : GraphconnecthamiltonCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonCursor::set(
  self : GraphconnecthamiltonCursor,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonCursor::sum(
  self : GraphconnecthamiltonCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonCursor::mean(
  self : GraphconnecthamiltonCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonCursor::scale(
  self : GraphconnecthamiltonCursor,
  f : Double,
) -> GraphconnecthamiltonCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonCursor::add(
  self : GraphconnecthamiltonCursor,
  other : GraphconnecthamiltonCursor,
) -> GraphconnecthamiltonCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonCursor::copy(
  self : GraphconnecthamiltonCursor,
) -> GraphconnecthamiltonCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonCursor::fill(
  self : GraphconnecthamiltonCursor,
  v : Double,
) -> GraphconnecthamiltonCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonCursor::min(
  self : GraphconnecthamiltonCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonCursor::max(
  self : GraphconnecthamiltonCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonCursor::to_string(
  self : GraphconnecthamiltonCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_view_make(
  size : Int32,
) -> GraphconnecthamiltonView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonView::len(self : GraphconnecthamiltonView) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonView::get(
  self : GraphconnecthamiltonView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonView::set(
  self : GraphconnecthamiltonView,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonView::sum(self : GraphconnecthamiltonView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonView::mean(
  self : GraphconnecthamiltonView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonView::scale(
  self : GraphconnecthamiltonView,
  f : Double,
) -> GraphconnecthamiltonView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonView::add(
  self : GraphconnecthamiltonView,
  other : GraphconnecthamiltonView,
) -> GraphconnecthamiltonView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonView::copy(
  self : GraphconnecthamiltonView,
) -> GraphconnecthamiltonView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonView::fill(
  self : GraphconnecthamiltonView,
  v : Double,
) -> GraphconnecthamiltonView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonView::min(self : GraphconnecthamiltonView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonView::max(self : GraphconnecthamiltonView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonView::to_string(
  self : GraphconnecthamiltonView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_range_make(
  size : Int32,
) -> GraphconnecthamiltonRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonRange::len(
  self : GraphconnecthamiltonRange,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonRange::get(
  self : GraphconnecthamiltonRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonRange::set(
  self : GraphconnecthamiltonRange,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonRange::sum(
  self : GraphconnecthamiltonRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonRange::mean(
  self : GraphconnecthamiltonRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonRange::scale(
  self : GraphconnecthamiltonRange,
  f : Double,
) -> GraphconnecthamiltonRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonRange::add(
  self : GraphconnecthamiltonRange,
  other : GraphconnecthamiltonRange,
) -> GraphconnecthamiltonRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonRange::copy(
  self : GraphconnecthamiltonRange,
) -> GraphconnecthamiltonRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonRange::fill(
  self : GraphconnecthamiltonRange,
  v : Double,
) -> GraphconnecthamiltonRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonRange::min(
  self : GraphconnecthamiltonRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonRange::max(
  self : GraphconnecthamiltonRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonRange::to_string(
  self : GraphconnecthamiltonRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnecthamiltonSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_hamilton_slice_make(
  size : Int32,
) -> GraphconnecthamiltonSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnecthamiltonSlice::len(
  self : GraphconnecthamiltonSlice,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnecthamiltonSlice::get(
  self : GraphconnecthamiltonSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnecthamiltonSlice::set(
  self : GraphconnecthamiltonSlice,
  i : Int32,
  v : Double,
) -> GraphconnecthamiltonSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonSlice::sum(
  self : GraphconnecthamiltonSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnecthamiltonSlice::mean(
  self : GraphconnecthamiltonSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnecthamiltonSlice::scale(
  self : GraphconnecthamiltonSlice,
  f : Double,
) -> GraphconnecthamiltonSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonSlice::add(
  self : GraphconnecthamiltonSlice,
  other : GraphconnecthamiltonSlice,
) -> GraphconnecthamiltonSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonSlice::copy(
  self : GraphconnecthamiltonSlice,
) -> GraphconnecthamiltonSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonSlice::fill(
  self : GraphconnecthamiltonSlice,
  v : Double,
) -> GraphconnecthamiltonSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnecthamiltonSlice::min(
  self : GraphconnecthamiltonSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnecthamiltonSlice::max(
  self : GraphconnecthamiltonSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnecthamiltonSlice::to_string(
  self : GraphconnecthamiltonSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
