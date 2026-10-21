///|
///===
/// extcore/graph_connect_articulation
pub(all) struct GraphconnectarticulationPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_connect_articulation_make_point(
  x : Double,
  y : Double,
) -> GraphconnectarticulationPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_connect_articulation_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphconnectarticulationPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphconnectarticulationPoint::x(
  self : GraphconnectarticulationPoint,
) -> Double {
  self.x
}

///|
pub fn GraphconnectarticulationPoint::y(
  self : GraphconnectarticulationPoint,
) -> Double {
  self.y
}

///|
pub fn GraphconnectarticulationPoint::z(
  self : GraphconnectarticulationPoint,
) -> Double {
  self.z
}

///|
pub fn GraphconnectarticulationPoint::label(
  self : GraphconnectarticulationPoint,
) -> Int32 {
  self.label
}

///|
pub fn GraphconnectarticulationPoint::dist(
  self : GraphconnectarticulationPoint,
  other : GraphconnectarticulationPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphconnectarticulationPoint::add(
  self : GraphconnectarticulationPoint,
  other : GraphconnectarticulationPoint,
) -> GraphconnectarticulationPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphconnectarticulationPoint::sub(
  self : GraphconnectarticulationPoint,
  other : GraphconnectarticulationPoint,
) -> GraphconnectarticulationPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphconnectarticulationPoint::scale(
  self : GraphconnectarticulationPoint,
  s : Double,
) -> GraphconnectarticulationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphconnectarticulationPoint::dot(
  self : GraphconnectarticulationPoint,
  other : GraphconnectarticulationPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphconnectarticulationPoint::cross(
  self : GraphconnectarticulationPoint,
  other : GraphconnectarticulationPoint,
) -> GraphconnectarticulationPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphconnectarticulationPoint::norm(
  self : GraphconnectarticulationPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphconnectarticulationPoint::normalize(
  self : GraphconnectarticulationPoint,
) -> GraphconnectarticulationPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphconnectarticulationPoint::negate(
  self : GraphconnectarticulationPoint,
) -> GraphconnectarticulationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphconnectarticulationPoint::mid(
  self : GraphconnectarticulationPoint,
  other : GraphconnectarticulationPoint,
) -> GraphconnectarticulationPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphconnectarticulationPoint::lerp(
  self : GraphconnectarticulationPoint,
  other : GraphconnectarticulationPoint,
  t : Double,
) -> GraphconnectarticulationPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphconnectarticulationPoint::to_string(
  self : GraphconnectarticulationPoint,
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
pub(all) struct GraphconnectarticulationSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_connect_articulation_make_series(
  vals : Array[Double],
  name : String,
) -> GraphconnectarticulationSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphconnectarticulationSeries::len(
  self : GraphconnectarticulationSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphconnectarticulationSeries::sum(
  self : GraphconnectarticulationSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphconnectarticulationSeries::mean(
  self : GraphconnectarticulationSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphconnectarticulationSeries::min(
  self : GraphconnectarticulationSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphconnectarticulationSeries::max(
  self : GraphconnectarticulationSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphconnectarticulationSeries::range(
  self : GraphconnectarticulationSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphconnectarticulationSeries::variance(
  self : GraphconnectarticulationSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphconnectarticulationSeries::std(
  self : GraphconnectarticulationSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphconnectarticulationSeries::median(
  self : GraphconnectarticulationSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphconnectarticulationSeries::scale(
  self : GraphconnectarticulationSeries,
  f : Double,
) -> GraphconnectarticulationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphconnectarticulationSeries::add(
  self : GraphconnectarticulationSeries,
  other : GraphconnectarticulationSeries,
) -> GraphconnectarticulationSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphconnectarticulationSeries::sub(
  self : GraphconnectarticulationSeries,
  other : GraphconnectarticulationSeries,
) -> GraphconnectarticulationSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphconnectarticulationSeries::normalize(
  self : GraphconnectarticulationSeries,
) -> GraphconnectarticulationSeries {
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
pub fn GraphconnectarticulationSeries::cumsum(
  self : GraphconnectarticulationSeries,
) -> GraphconnectarticulationSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphconnectarticulationSeries::to_string(
  self : GraphconnectarticulationSeries,
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
pub(all) struct GraphconnectarticulationMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_connect_articulation_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphconnectarticulationMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_connect_articulation_matrix_identity(
  n : Int32,
) -> GraphconnectarticulationMatrix {
  let m = graph_connect_articulation_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphconnectarticulationMatrix::get(
  self : GraphconnectarticulationMatrix,
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
pub fn GraphconnectarticulationMatrix::transpose(
  self : GraphconnectarticulationMatrix,
) -> GraphconnectarticulationMatrix {
  let result = graph_connect_articulation_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphconnectarticulationMatrix::add(
  self : GraphconnectarticulationMatrix,
  other : GraphconnectarticulationMatrix,
) -> GraphconnectarticulationMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_connect_articulation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphconnectarticulationMatrix::scale(
  self : GraphconnectarticulationMatrix,
  s : Double,
) -> GraphconnectarticulationMatrix {
  let result = graph_connect_articulation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphconnectarticulationMatrix::multiply(
  self : GraphconnectarticulationMatrix,
  other : GraphconnectarticulationMatrix,
) -> GraphconnectarticulationMatrix {
  if self.cols != other.rows {
    return graph_connect_articulation_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_connect_articulation_make_matrix(
    self.rows,
    other.cols,
    0.0,
  )
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
pub fn GraphconnectarticulationMatrix::trace(
  self : GraphconnectarticulationMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphconnectarticulationMatrix::det(
  self : GraphconnectarticulationMatrix,
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
pub fn GraphconnectarticulationMatrix::norm(
  self : GraphconnectarticulationMatrix,
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
pub fn GraphconnectarticulationMatrix::to_string(
  self : GraphconnectarticulationMatrix,
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
pub(all) struct GraphconnectarticulationVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_connect_articulation_make_vector(
  comps : Array[Double],
) -> GraphconnectarticulationVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_connect_articulation_vector_zero(
  dim : Int32,
) -> GraphconnectarticulationVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphconnectarticulationVector::add(
  self : GraphconnectarticulationVector,
  other : GraphconnectarticulationVector,
) -> GraphconnectarticulationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphconnectarticulationVector::sub(
  self : GraphconnectarticulationVector,
  other : GraphconnectarticulationVector,
) -> GraphconnectarticulationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphconnectarticulationVector::scale(
  self : GraphconnectarticulationVector,
  s : Double,
) -> GraphconnectarticulationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphconnectarticulationVector::dot(
  self : GraphconnectarticulationVector,
  other : GraphconnectarticulationVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphconnectarticulationVector::norm(
  self : GraphconnectarticulationVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphconnectarticulationVector::normalize(
  self : GraphconnectarticulationVector,
) -> GraphconnectarticulationVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphconnectarticulationVector::dist(
  self : GraphconnectarticulationVector,
  other : GraphconnectarticulationVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphconnectarticulationVector::to_string(
  self : GraphconnectarticulationVector,
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
pub(all) struct GraphconnectarticulationFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_frame_make(
  size : Int32,
) -> GraphconnectarticulationFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationFrame::len(
  self : GraphconnectarticulationFrame,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationFrame::get(
  self : GraphconnectarticulationFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationFrame::set(
  self : GraphconnectarticulationFrame,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationFrame::sum(
  self : GraphconnectarticulationFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationFrame::mean(
  self : GraphconnectarticulationFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationFrame::scale(
  self : GraphconnectarticulationFrame,
  f : Double,
) -> GraphconnectarticulationFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationFrame::add(
  self : GraphconnectarticulationFrame,
  other : GraphconnectarticulationFrame,
) -> GraphconnectarticulationFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationFrame::copy(
  self : GraphconnectarticulationFrame,
) -> GraphconnectarticulationFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationFrame::fill(
  self : GraphconnectarticulationFrame,
  v : Double,
) -> GraphconnectarticulationFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationFrame::min(
  self : GraphconnectarticulationFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationFrame::max(
  self : GraphconnectarticulationFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationFrame::to_string(
  self : GraphconnectarticulationFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_table_make(
  size : Int32,
) -> GraphconnectarticulationTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationTable::len(
  self : GraphconnectarticulationTable,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationTable::get(
  self : GraphconnectarticulationTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationTable::set(
  self : GraphconnectarticulationTable,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationTable::sum(
  self : GraphconnectarticulationTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationTable::mean(
  self : GraphconnectarticulationTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationTable::scale(
  self : GraphconnectarticulationTable,
  f : Double,
) -> GraphconnectarticulationTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationTable::add(
  self : GraphconnectarticulationTable,
  other : GraphconnectarticulationTable,
) -> GraphconnectarticulationTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationTable::copy(
  self : GraphconnectarticulationTable,
) -> GraphconnectarticulationTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationTable::fill(
  self : GraphconnectarticulationTable,
  v : Double,
) -> GraphconnectarticulationTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationTable::min(
  self : GraphconnectarticulationTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationTable::max(
  self : GraphconnectarticulationTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationTable::to_string(
  self : GraphconnectarticulationTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_graphn_make(
  size : Int32,
) -> GraphconnectarticulationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationGraphN::len(
  self : GraphconnectarticulationGraphN,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationGraphN::get(
  self : GraphconnectarticulationGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationGraphN::set(
  self : GraphconnectarticulationGraphN,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationGraphN::sum(
  self : GraphconnectarticulationGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationGraphN::mean(
  self : GraphconnectarticulationGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationGraphN::scale(
  self : GraphconnectarticulationGraphN,
  f : Double,
) -> GraphconnectarticulationGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationGraphN::add(
  self : GraphconnectarticulationGraphN,
  other : GraphconnectarticulationGraphN,
) -> GraphconnectarticulationGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationGraphN::copy(
  self : GraphconnectarticulationGraphN,
) -> GraphconnectarticulationGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationGraphN::fill(
  self : GraphconnectarticulationGraphN,
  v : Double,
) -> GraphconnectarticulationGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationGraphN::min(
  self : GraphconnectarticulationGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationGraphN::max(
  self : GraphconnectarticulationGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationGraphN::to_string(
  self : GraphconnectarticulationGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_node_make(
  size : Int32,
) -> GraphconnectarticulationNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationNode::len(
  self : GraphconnectarticulationNode,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationNode::get(
  self : GraphconnectarticulationNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationNode::set(
  self : GraphconnectarticulationNode,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationNode::sum(
  self : GraphconnectarticulationNode,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationNode::mean(
  self : GraphconnectarticulationNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationNode::scale(
  self : GraphconnectarticulationNode,
  f : Double,
) -> GraphconnectarticulationNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationNode::add(
  self : GraphconnectarticulationNode,
  other : GraphconnectarticulationNode,
) -> GraphconnectarticulationNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationNode::copy(
  self : GraphconnectarticulationNode,
) -> GraphconnectarticulationNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationNode::fill(
  self : GraphconnectarticulationNode,
  v : Double,
) -> GraphconnectarticulationNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationNode::min(
  self : GraphconnectarticulationNode,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationNode::max(
  self : GraphconnectarticulationNode,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationNode::to_string(
  self : GraphconnectarticulationNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_edge_make(
  size : Int32,
) -> GraphconnectarticulationEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationEdge::len(
  self : GraphconnectarticulationEdge,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationEdge::get(
  self : GraphconnectarticulationEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationEdge::set(
  self : GraphconnectarticulationEdge,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationEdge::sum(
  self : GraphconnectarticulationEdge,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationEdge::mean(
  self : GraphconnectarticulationEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationEdge::scale(
  self : GraphconnectarticulationEdge,
  f : Double,
) -> GraphconnectarticulationEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationEdge::add(
  self : GraphconnectarticulationEdge,
  other : GraphconnectarticulationEdge,
) -> GraphconnectarticulationEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationEdge::copy(
  self : GraphconnectarticulationEdge,
) -> GraphconnectarticulationEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationEdge::fill(
  self : GraphconnectarticulationEdge,
  v : Double,
) -> GraphconnectarticulationEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationEdge::min(
  self : GraphconnectarticulationEdge,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationEdge::max(
  self : GraphconnectarticulationEdge,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationEdge::to_string(
  self : GraphconnectarticulationEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_path_make(
  size : Int32,
) -> GraphconnectarticulationPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationPath::len(
  self : GraphconnectarticulationPath,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationPath::get(
  self : GraphconnectarticulationPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationPath::set(
  self : GraphconnectarticulationPath,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationPath::sum(
  self : GraphconnectarticulationPath,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationPath::mean(
  self : GraphconnectarticulationPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationPath::scale(
  self : GraphconnectarticulationPath,
  f : Double,
) -> GraphconnectarticulationPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationPath::add(
  self : GraphconnectarticulationPath,
  other : GraphconnectarticulationPath,
) -> GraphconnectarticulationPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationPath::copy(
  self : GraphconnectarticulationPath,
) -> GraphconnectarticulationPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationPath::fill(
  self : GraphconnectarticulationPath,
  v : Double,
) -> GraphconnectarticulationPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationPath::min(
  self : GraphconnectarticulationPath,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationPath::max(
  self : GraphconnectarticulationPath,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationPath::to_string(
  self : GraphconnectarticulationPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_cluster_make(
  size : Int32,
) -> GraphconnectarticulationCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationCluster::len(
  self : GraphconnectarticulationCluster,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationCluster::get(
  self : GraphconnectarticulationCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationCluster::set(
  self : GraphconnectarticulationCluster,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationCluster::sum(
  self : GraphconnectarticulationCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationCluster::mean(
  self : GraphconnectarticulationCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationCluster::scale(
  self : GraphconnectarticulationCluster,
  f : Double,
) -> GraphconnectarticulationCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationCluster::add(
  self : GraphconnectarticulationCluster,
  other : GraphconnectarticulationCluster,
) -> GraphconnectarticulationCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationCluster::copy(
  self : GraphconnectarticulationCluster,
) -> GraphconnectarticulationCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationCluster::fill(
  self : GraphconnectarticulationCluster,
  v : Double,
) -> GraphconnectarticulationCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationCluster::min(
  self : GraphconnectarticulationCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationCluster::max(
  self : GraphconnectarticulationCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationCluster::to_string(
  self : GraphconnectarticulationCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_model_make(
  size : Int32,
) -> GraphconnectarticulationModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationModel::len(
  self : GraphconnectarticulationModel,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationModel::get(
  self : GraphconnectarticulationModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationModel::set(
  self : GraphconnectarticulationModel,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationModel::sum(
  self : GraphconnectarticulationModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationModel::mean(
  self : GraphconnectarticulationModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationModel::scale(
  self : GraphconnectarticulationModel,
  f : Double,
) -> GraphconnectarticulationModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationModel::add(
  self : GraphconnectarticulationModel,
  other : GraphconnectarticulationModel,
) -> GraphconnectarticulationModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationModel::copy(
  self : GraphconnectarticulationModel,
) -> GraphconnectarticulationModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationModel::fill(
  self : GraphconnectarticulationModel,
  v : Double,
) -> GraphconnectarticulationModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationModel::min(
  self : GraphconnectarticulationModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationModel::max(
  self : GraphconnectarticulationModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationModel::to_string(
  self : GraphconnectarticulationModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_layer_make(
  size : Int32,
) -> GraphconnectarticulationLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationLayer::len(
  self : GraphconnectarticulationLayer,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationLayer::get(
  self : GraphconnectarticulationLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationLayer::set(
  self : GraphconnectarticulationLayer,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationLayer::sum(
  self : GraphconnectarticulationLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationLayer::mean(
  self : GraphconnectarticulationLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationLayer::scale(
  self : GraphconnectarticulationLayer,
  f : Double,
) -> GraphconnectarticulationLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationLayer::add(
  self : GraphconnectarticulationLayer,
  other : GraphconnectarticulationLayer,
) -> GraphconnectarticulationLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationLayer::copy(
  self : GraphconnectarticulationLayer,
) -> GraphconnectarticulationLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationLayer::fill(
  self : GraphconnectarticulationLayer,
  v : Double,
) -> GraphconnectarticulationLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationLayer::min(
  self : GraphconnectarticulationLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationLayer::max(
  self : GraphconnectarticulationLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationLayer::to_string(
  self : GraphconnectarticulationLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_buffer_make(
  size : Int32,
) -> GraphconnectarticulationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationBuffer::len(
  self : GraphconnectarticulationBuffer,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationBuffer::get(
  self : GraphconnectarticulationBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationBuffer::set(
  self : GraphconnectarticulationBuffer,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationBuffer::sum(
  self : GraphconnectarticulationBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationBuffer::mean(
  self : GraphconnectarticulationBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationBuffer::scale(
  self : GraphconnectarticulationBuffer,
  f : Double,
) -> GraphconnectarticulationBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationBuffer::add(
  self : GraphconnectarticulationBuffer,
  other : GraphconnectarticulationBuffer,
) -> GraphconnectarticulationBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationBuffer::copy(
  self : GraphconnectarticulationBuffer,
) -> GraphconnectarticulationBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationBuffer::fill(
  self : GraphconnectarticulationBuffer,
  v : Double,
) -> GraphconnectarticulationBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationBuffer::min(
  self : GraphconnectarticulationBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationBuffer::max(
  self : GraphconnectarticulationBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationBuffer::to_string(
  self : GraphconnectarticulationBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_cursor_make(
  size : Int32,
) -> GraphconnectarticulationCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationCursor::len(
  self : GraphconnectarticulationCursor,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationCursor::get(
  self : GraphconnectarticulationCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationCursor::set(
  self : GraphconnectarticulationCursor,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationCursor::sum(
  self : GraphconnectarticulationCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationCursor::mean(
  self : GraphconnectarticulationCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationCursor::scale(
  self : GraphconnectarticulationCursor,
  f : Double,
) -> GraphconnectarticulationCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationCursor::add(
  self : GraphconnectarticulationCursor,
  other : GraphconnectarticulationCursor,
) -> GraphconnectarticulationCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationCursor::copy(
  self : GraphconnectarticulationCursor,
) -> GraphconnectarticulationCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationCursor::fill(
  self : GraphconnectarticulationCursor,
  v : Double,
) -> GraphconnectarticulationCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationCursor::min(
  self : GraphconnectarticulationCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationCursor::max(
  self : GraphconnectarticulationCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationCursor::to_string(
  self : GraphconnectarticulationCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_view_make(
  size : Int32,
) -> GraphconnectarticulationView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationView::len(
  self : GraphconnectarticulationView,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationView::get(
  self : GraphconnectarticulationView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationView::set(
  self : GraphconnectarticulationView,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationView::sum(
  self : GraphconnectarticulationView,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationView::mean(
  self : GraphconnectarticulationView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationView::scale(
  self : GraphconnectarticulationView,
  f : Double,
) -> GraphconnectarticulationView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationView::add(
  self : GraphconnectarticulationView,
  other : GraphconnectarticulationView,
) -> GraphconnectarticulationView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationView::copy(
  self : GraphconnectarticulationView,
) -> GraphconnectarticulationView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationView::fill(
  self : GraphconnectarticulationView,
  v : Double,
) -> GraphconnectarticulationView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationView::min(
  self : GraphconnectarticulationView,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationView::max(
  self : GraphconnectarticulationView,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationView::to_string(
  self : GraphconnectarticulationView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_range_make(
  size : Int32,
) -> GraphconnectarticulationRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationRange::len(
  self : GraphconnectarticulationRange,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationRange::get(
  self : GraphconnectarticulationRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationRange::set(
  self : GraphconnectarticulationRange,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationRange::sum(
  self : GraphconnectarticulationRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationRange::mean(
  self : GraphconnectarticulationRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationRange::scale(
  self : GraphconnectarticulationRange,
  f : Double,
) -> GraphconnectarticulationRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationRange::add(
  self : GraphconnectarticulationRange,
  other : GraphconnectarticulationRange,
) -> GraphconnectarticulationRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationRange::copy(
  self : GraphconnectarticulationRange,
) -> GraphconnectarticulationRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationRange::fill(
  self : GraphconnectarticulationRange,
  v : Double,
) -> GraphconnectarticulationRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationRange::min(
  self : GraphconnectarticulationRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationRange::max(
  self : GraphconnectarticulationRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationRange::to_string(
  self : GraphconnectarticulationRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphconnectarticulationSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_connect_articulation_slice_make(
  size : Int32,
) -> GraphconnectarticulationSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphconnectarticulationSlice::len(
  self : GraphconnectarticulationSlice,
) -> Int32 {
  self.size
}

///|
pub fn GraphconnectarticulationSlice::get(
  self : GraphconnectarticulationSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphconnectarticulationSlice::set(
  self : GraphconnectarticulationSlice,
  i : Int32,
  v : Double,
) -> GraphconnectarticulationSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationSlice::sum(
  self : GraphconnectarticulationSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphconnectarticulationSlice::mean(
  self : GraphconnectarticulationSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphconnectarticulationSlice::scale(
  self : GraphconnectarticulationSlice,
  f : Double,
) -> GraphconnectarticulationSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationSlice::add(
  self : GraphconnectarticulationSlice,
  other : GraphconnectarticulationSlice,
) -> GraphconnectarticulationSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationSlice::copy(
  self : GraphconnectarticulationSlice,
) -> GraphconnectarticulationSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationSlice::fill(
  self : GraphconnectarticulationSlice,
  v : Double,
) -> GraphconnectarticulationSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphconnectarticulationSlice::min(
  self : GraphconnectarticulationSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphconnectarticulationSlice::max(
  self : GraphconnectarticulationSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphconnectarticulationSlice::to_string(
  self : GraphconnectarticulationSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
