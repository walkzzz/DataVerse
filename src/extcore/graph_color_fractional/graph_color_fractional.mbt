///|
///===
/// extcore/graph_color_fractional
pub(all) struct GraphcolorfractionalPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_color_fractional_make_point(
  x : Double,
  y : Double,
) -> GraphcolorfractionalPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_color_fractional_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphcolorfractionalPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphcolorfractionalPoint::x(self : GraphcolorfractionalPoint) -> Double {
  self.x
}

///|
pub fn GraphcolorfractionalPoint::y(self : GraphcolorfractionalPoint) -> Double {
  self.y
}

///|
pub fn GraphcolorfractionalPoint::z(self : GraphcolorfractionalPoint) -> Double {
  self.z
}

///|
pub fn GraphcolorfractionalPoint::label(
  self : GraphcolorfractionalPoint,
) -> Int32 {
  self.label
}

///|
pub fn GraphcolorfractionalPoint::dist(
  self : GraphcolorfractionalPoint,
  other : GraphcolorfractionalPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphcolorfractionalPoint::add(
  self : GraphcolorfractionalPoint,
  other : GraphcolorfractionalPoint,
) -> GraphcolorfractionalPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphcolorfractionalPoint::sub(
  self : GraphcolorfractionalPoint,
  other : GraphcolorfractionalPoint,
) -> GraphcolorfractionalPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphcolorfractionalPoint::scale(
  self : GraphcolorfractionalPoint,
  s : Double,
) -> GraphcolorfractionalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphcolorfractionalPoint::dot(
  self : GraphcolorfractionalPoint,
  other : GraphcolorfractionalPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphcolorfractionalPoint::cross(
  self : GraphcolorfractionalPoint,
  other : GraphcolorfractionalPoint,
) -> GraphcolorfractionalPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphcolorfractionalPoint::norm(
  self : GraphcolorfractionalPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphcolorfractionalPoint::normalize(
  self : GraphcolorfractionalPoint,
) -> GraphcolorfractionalPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphcolorfractionalPoint::negate(
  self : GraphcolorfractionalPoint,
) -> GraphcolorfractionalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphcolorfractionalPoint::mid(
  self : GraphcolorfractionalPoint,
  other : GraphcolorfractionalPoint,
) -> GraphcolorfractionalPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphcolorfractionalPoint::lerp(
  self : GraphcolorfractionalPoint,
  other : GraphcolorfractionalPoint,
  t : Double,
) -> GraphcolorfractionalPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphcolorfractionalPoint::to_string(
  self : GraphcolorfractionalPoint,
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
pub(all) struct GraphcolorfractionalSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_color_fractional_make_series(
  vals : Array[Double],
  name : String,
) -> GraphcolorfractionalSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphcolorfractionalSeries::len(
  self : GraphcolorfractionalSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphcolorfractionalSeries::sum(
  self : GraphcolorfractionalSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphcolorfractionalSeries::mean(
  self : GraphcolorfractionalSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphcolorfractionalSeries::min(
  self : GraphcolorfractionalSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphcolorfractionalSeries::max(
  self : GraphcolorfractionalSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphcolorfractionalSeries::range(
  self : GraphcolorfractionalSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphcolorfractionalSeries::variance(
  self : GraphcolorfractionalSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphcolorfractionalSeries::std(
  self : GraphcolorfractionalSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphcolorfractionalSeries::median(
  self : GraphcolorfractionalSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphcolorfractionalSeries::scale(
  self : GraphcolorfractionalSeries,
  f : Double,
) -> GraphcolorfractionalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphcolorfractionalSeries::add(
  self : GraphcolorfractionalSeries,
  other : GraphcolorfractionalSeries,
) -> GraphcolorfractionalSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphcolorfractionalSeries::sub(
  self : GraphcolorfractionalSeries,
  other : GraphcolorfractionalSeries,
) -> GraphcolorfractionalSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphcolorfractionalSeries::normalize(
  self : GraphcolorfractionalSeries,
) -> GraphcolorfractionalSeries {
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
pub fn GraphcolorfractionalSeries::cumsum(
  self : GraphcolorfractionalSeries,
) -> GraphcolorfractionalSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphcolorfractionalSeries::to_string(
  self : GraphcolorfractionalSeries,
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
pub(all) struct GraphcolorfractionalMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_color_fractional_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphcolorfractionalMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_color_fractional_matrix_identity(
  n : Int32,
) -> GraphcolorfractionalMatrix {
  let m = graph_color_fractional_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphcolorfractionalMatrix::get(
  self : GraphcolorfractionalMatrix,
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
pub fn GraphcolorfractionalMatrix::transpose(
  self : GraphcolorfractionalMatrix,
) -> GraphcolorfractionalMatrix {
  let result = graph_color_fractional_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphcolorfractionalMatrix::add(
  self : GraphcolorfractionalMatrix,
  other : GraphcolorfractionalMatrix,
) -> GraphcolorfractionalMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_color_fractional_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphcolorfractionalMatrix::scale(
  self : GraphcolorfractionalMatrix,
  s : Double,
) -> GraphcolorfractionalMatrix {
  let result = graph_color_fractional_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphcolorfractionalMatrix::multiply(
  self : GraphcolorfractionalMatrix,
  other : GraphcolorfractionalMatrix,
) -> GraphcolorfractionalMatrix {
  if self.cols != other.rows {
    return graph_color_fractional_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_color_fractional_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphcolorfractionalMatrix::trace(
  self : GraphcolorfractionalMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphcolorfractionalMatrix::det(
  self : GraphcolorfractionalMatrix,
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
pub fn GraphcolorfractionalMatrix::norm(
  self : GraphcolorfractionalMatrix,
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
pub fn GraphcolorfractionalMatrix::to_string(
  self : GraphcolorfractionalMatrix,
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
pub(all) struct GraphcolorfractionalVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_color_fractional_make_vector(
  comps : Array[Double],
) -> GraphcolorfractionalVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_color_fractional_vector_zero(
  dim : Int32,
) -> GraphcolorfractionalVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphcolorfractionalVector::add(
  self : GraphcolorfractionalVector,
  other : GraphcolorfractionalVector,
) -> GraphcolorfractionalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphcolorfractionalVector::sub(
  self : GraphcolorfractionalVector,
  other : GraphcolorfractionalVector,
) -> GraphcolorfractionalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphcolorfractionalVector::scale(
  self : GraphcolorfractionalVector,
  s : Double,
) -> GraphcolorfractionalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphcolorfractionalVector::dot(
  self : GraphcolorfractionalVector,
  other : GraphcolorfractionalVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphcolorfractionalVector::norm(
  self : GraphcolorfractionalVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphcolorfractionalVector::normalize(
  self : GraphcolorfractionalVector,
) -> GraphcolorfractionalVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphcolorfractionalVector::dist(
  self : GraphcolorfractionalVector,
  other : GraphcolorfractionalVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphcolorfractionalVector::to_string(
  self : GraphcolorfractionalVector,
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
pub(all) struct GraphcolorfractionalFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_frame_make(
  size : Int32,
) -> GraphcolorfractionalFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalFrame::len(
  self : GraphcolorfractionalFrame,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalFrame::get(
  self : GraphcolorfractionalFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalFrame::set(
  self : GraphcolorfractionalFrame,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalFrame::sum(
  self : GraphcolorfractionalFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalFrame::mean(
  self : GraphcolorfractionalFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalFrame::scale(
  self : GraphcolorfractionalFrame,
  f : Double,
) -> GraphcolorfractionalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalFrame::add(
  self : GraphcolorfractionalFrame,
  other : GraphcolorfractionalFrame,
) -> GraphcolorfractionalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalFrame::copy(
  self : GraphcolorfractionalFrame,
) -> GraphcolorfractionalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalFrame::fill(
  self : GraphcolorfractionalFrame,
  v : Double,
) -> GraphcolorfractionalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalFrame::min(
  self : GraphcolorfractionalFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalFrame::max(
  self : GraphcolorfractionalFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalFrame::to_string(
  self : GraphcolorfractionalFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_table_make(
  size : Int32,
) -> GraphcolorfractionalTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalTable::len(
  self : GraphcolorfractionalTable,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalTable::get(
  self : GraphcolorfractionalTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalTable::set(
  self : GraphcolorfractionalTable,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalTable::sum(
  self : GraphcolorfractionalTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalTable::mean(
  self : GraphcolorfractionalTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalTable::scale(
  self : GraphcolorfractionalTable,
  f : Double,
) -> GraphcolorfractionalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalTable::add(
  self : GraphcolorfractionalTable,
  other : GraphcolorfractionalTable,
) -> GraphcolorfractionalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalTable::copy(
  self : GraphcolorfractionalTable,
) -> GraphcolorfractionalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalTable::fill(
  self : GraphcolorfractionalTable,
  v : Double,
) -> GraphcolorfractionalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalTable::min(
  self : GraphcolorfractionalTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalTable::max(
  self : GraphcolorfractionalTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalTable::to_string(
  self : GraphcolorfractionalTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_graphn_make(
  size : Int32,
) -> GraphcolorfractionalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalGraphN::len(
  self : GraphcolorfractionalGraphN,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalGraphN::get(
  self : GraphcolorfractionalGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalGraphN::set(
  self : GraphcolorfractionalGraphN,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalGraphN::sum(
  self : GraphcolorfractionalGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalGraphN::mean(
  self : GraphcolorfractionalGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalGraphN::scale(
  self : GraphcolorfractionalGraphN,
  f : Double,
) -> GraphcolorfractionalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalGraphN::add(
  self : GraphcolorfractionalGraphN,
  other : GraphcolorfractionalGraphN,
) -> GraphcolorfractionalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalGraphN::copy(
  self : GraphcolorfractionalGraphN,
) -> GraphcolorfractionalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalGraphN::fill(
  self : GraphcolorfractionalGraphN,
  v : Double,
) -> GraphcolorfractionalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalGraphN::min(
  self : GraphcolorfractionalGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalGraphN::max(
  self : GraphcolorfractionalGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalGraphN::to_string(
  self : GraphcolorfractionalGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_node_make(
  size : Int32,
) -> GraphcolorfractionalNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalNode::len(self : GraphcolorfractionalNode) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalNode::get(
  self : GraphcolorfractionalNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalNode::set(
  self : GraphcolorfractionalNode,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalNode::sum(self : GraphcolorfractionalNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalNode::mean(
  self : GraphcolorfractionalNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalNode::scale(
  self : GraphcolorfractionalNode,
  f : Double,
) -> GraphcolorfractionalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalNode::add(
  self : GraphcolorfractionalNode,
  other : GraphcolorfractionalNode,
) -> GraphcolorfractionalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalNode::copy(
  self : GraphcolorfractionalNode,
) -> GraphcolorfractionalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalNode::fill(
  self : GraphcolorfractionalNode,
  v : Double,
) -> GraphcolorfractionalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalNode::min(self : GraphcolorfractionalNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalNode::max(self : GraphcolorfractionalNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalNode::to_string(
  self : GraphcolorfractionalNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_edge_make(
  size : Int32,
) -> GraphcolorfractionalEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalEdge::len(self : GraphcolorfractionalEdge) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalEdge::get(
  self : GraphcolorfractionalEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalEdge::set(
  self : GraphcolorfractionalEdge,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalEdge::sum(self : GraphcolorfractionalEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalEdge::mean(
  self : GraphcolorfractionalEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalEdge::scale(
  self : GraphcolorfractionalEdge,
  f : Double,
) -> GraphcolorfractionalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalEdge::add(
  self : GraphcolorfractionalEdge,
  other : GraphcolorfractionalEdge,
) -> GraphcolorfractionalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalEdge::copy(
  self : GraphcolorfractionalEdge,
) -> GraphcolorfractionalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalEdge::fill(
  self : GraphcolorfractionalEdge,
  v : Double,
) -> GraphcolorfractionalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalEdge::min(self : GraphcolorfractionalEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalEdge::max(self : GraphcolorfractionalEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalEdge::to_string(
  self : GraphcolorfractionalEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_path_make(
  size : Int32,
) -> GraphcolorfractionalPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalPath::len(self : GraphcolorfractionalPath) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalPath::get(
  self : GraphcolorfractionalPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalPath::set(
  self : GraphcolorfractionalPath,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalPath::sum(self : GraphcolorfractionalPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalPath::mean(
  self : GraphcolorfractionalPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalPath::scale(
  self : GraphcolorfractionalPath,
  f : Double,
) -> GraphcolorfractionalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalPath::add(
  self : GraphcolorfractionalPath,
  other : GraphcolorfractionalPath,
) -> GraphcolorfractionalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalPath::copy(
  self : GraphcolorfractionalPath,
) -> GraphcolorfractionalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalPath::fill(
  self : GraphcolorfractionalPath,
  v : Double,
) -> GraphcolorfractionalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalPath::min(self : GraphcolorfractionalPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalPath::max(self : GraphcolorfractionalPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalPath::to_string(
  self : GraphcolorfractionalPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_cluster_make(
  size : Int32,
) -> GraphcolorfractionalCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalCluster::len(
  self : GraphcolorfractionalCluster,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalCluster::get(
  self : GraphcolorfractionalCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalCluster::set(
  self : GraphcolorfractionalCluster,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalCluster::sum(
  self : GraphcolorfractionalCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalCluster::mean(
  self : GraphcolorfractionalCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalCluster::scale(
  self : GraphcolorfractionalCluster,
  f : Double,
) -> GraphcolorfractionalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalCluster::add(
  self : GraphcolorfractionalCluster,
  other : GraphcolorfractionalCluster,
) -> GraphcolorfractionalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalCluster::copy(
  self : GraphcolorfractionalCluster,
) -> GraphcolorfractionalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalCluster::fill(
  self : GraphcolorfractionalCluster,
  v : Double,
) -> GraphcolorfractionalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalCluster::min(
  self : GraphcolorfractionalCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalCluster::max(
  self : GraphcolorfractionalCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalCluster::to_string(
  self : GraphcolorfractionalCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_model_make(
  size : Int32,
) -> GraphcolorfractionalModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalModel::len(
  self : GraphcolorfractionalModel,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalModel::get(
  self : GraphcolorfractionalModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalModel::set(
  self : GraphcolorfractionalModel,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalModel::sum(
  self : GraphcolorfractionalModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalModel::mean(
  self : GraphcolorfractionalModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalModel::scale(
  self : GraphcolorfractionalModel,
  f : Double,
) -> GraphcolorfractionalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalModel::add(
  self : GraphcolorfractionalModel,
  other : GraphcolorfractionalModel,
) -> GraphcolorfractionalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalModel::copy(
  self : GraphcolorfractionalModel,
) -> GraphcolorfractionalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalModel::fill(
  self : GraphcolorfractionalModel,
  v : Double,
) -> GraphcolorfractionalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalModel::min(
  self : GraphcolorfractionalModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalModel::max(
  self : GraphcolorfractionalModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalModel::to_string(
  self : GraphcolorfractionalModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_layer_make(
  size : Int32,
) -> GraphcolorfractionalLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalLayer::len(
  self : GraphcolorfractionalLayer,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalLayer::get(
  self : GraphcolorfractionalLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalLayer::set(
  self : GraphcolorfractionalLayer,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalLayer::sum(
  self : GraphcolorfractionalLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalLayer::mean(
  self : GraphcolorfractionalLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalLayer::scale(
  self : GraphcolorfractionalLayer,
  f : Double,
) -> GraphcolorfractionalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalLayer::add(
  self : GraphcolorfractionalLayer,
  other : GraphcolorfractionalLayer,
) -> GraphcolorfractionalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalLayer::copy(
  self : GraphcolorfractionalLayer,
) -> GraphcolorfractionalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalLayer::fill(
  self : GraphcolorfractionalLayer,
  v : Double,
) -> GraphcolorfractionalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalLayer::min(
  self : GraphcolorfractionalLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalLayer::max(
  self : GraphcolorfractionalLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalLayer::to_string(
  self : GraphcolorfractionalLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_buffer_make(
  size : Int32,
) -> GraphcolorfractionalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalBuffer::len(
  self : GraphcolorfractionalBuffer,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalBuffer::get(
  self : GraphcolorfractionalBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalBuffer::set(
  self : GraphcolorfractionalBuffer,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalBuffer::sum(
  self : GraphcolorfractionalBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalBuffer::mean(
  self : GraphcolorfractionalBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalBuffer::scale(
  self : GraphcolorfractionalBuffer,
  f : Double,
) -> GraphcolorfractionalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalBuffer::add(
  self : GraphcolorfractionalBuffer,
  other : GraphcolorfractionalBuffer,
) -> GraphcolorfractionalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalBuffer::copy(
  self : GraphcolorfractionalBuffer,
) -> GraphcolorfractionalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalBuffer::fill(
  self : GraphcolorfractionalBuffer,
  v : Double,
) -> GraphcolorfractionalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalBuffer::min(
  self : GraphcolorfractionalBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalBuffer::max(
  self : GraphcolorfractionalBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalBuffer::to_string(
  self : GraphcolorfractionalBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_cursor_make(
  size : Int32,
) -> GraphcolorfractionalCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalCursor::len(
  self : GraphcolorfractionalCursor,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalCursor::get(
  self : GraphcolorfractionalCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalCursor::set(
  self : GraphcolorfractionalCursor,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalCursor::sum(
  self : GraphcolorfractionalCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalCursor::mean(
  self : GraphcolorfractionalCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalCursor::scale(
  self : GraphcolorfractionalCursor,
  f : Double,
) -> GraphcolorfractionalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalCursor::add(
  self : GraphcolorfractionalCursor,
  other : GraphcolorfractionalCursor,
) -> GraphcolorfractionalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalCursor::copy(
  self : GraphcolorfractionalCursor,
) -> GraphcolorfractionalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalCursor::fill(
  self : GraphcolorfractionalCursor,
  v : Double,
) -> GraphcolorfractionalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalCursor::min(
  self : GraphcolorfractionalCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalCursor::max(
  self : GraphcolorfractionalCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalCursor::to_string(
  self : GraphcolorfractionalCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_view_make(
  size : Int32,
) -> GraphcolorfractionalView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalView::len(self : GraphcolorfractionalView) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalView::get(
  self : GraphcolorfractionalView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalView::set(
  self : GraphcolorfractionalView,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalView::sum(self : GraphcolorfractionalView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalView::mean(
  self : GraphcolorfractionalView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalView::scale(
  self : GraphcolorfractionalView,
  f : Double,
) -> GraphcolorfractionalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalView::add(
  self : GraphcolorfractionalView,
  other : GraphcolorfractionalView,
) -> GraphcolorfractionalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalView::copy(
  self : GraphcolorfractionalView,
) -> GraphcolorfractionalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalView::fill(
  self : GraphcolorfractionalView,
  v : Double,
) -> GraphcolorfractionalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalView::min(self : GraphcolorfractionalView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalView::max(self : GraphcolorfractionalView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalView::to_string(
  self : GraphcolorfractionalView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_range_make(
  size : Int32,
) -> GraphcolorfractionalRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalRange::len(
  self : GraphcolorfractionalRange,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalRange::get(
  self : GraphcolorfractionalRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalRange::set(
  self : GraphcolorfractionalRange,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalRange::sum(
  self : GraphcolorfractionalRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalRange::mean(
  self : GraphcolorfractionalRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalRange::scale(
  self : GraphcolorfractionalRange,
  f : Double,
) -> GraphcolorfractionalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalRange::add(
  self : GraphcolorfractionalRange,
  other : GraphcolorfractionalRange,
) -> GraphcolorfractionalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalRange::copy(
  self : GraphcolorfractionalRange,
) -> GraphcolorfractionalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalRange::fill(
  self : GraphcolorfractionalRange,
  v : Double,
) -> GraphcolorfractionalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalRange::min(
  self : GraphcolorfractionalRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalRange::max(
  self : GraphcolorfractionalRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalRange::to_string(
  self : GraphcolorfractionalRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorfractionalSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_fractional_slice_make(
  size : Int32,
) -> GraphcolorfractionalSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorfractionalSlice::len(
  self : GraphcolorfractionalSlice,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorfractionalSlice::get(
  self : GraphcolorfractionalSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorfractionalSlice::set(
  self : GraphcolorfractionalSlice,
  i : Int32,
  v : Double,
) -> GraphcolorfractionalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalSlice::sum(
  self : GraphcolorfractionalSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorfractionalSlice::mean(
  self : GraphcolorfractionalSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorfractionalSlice::scale(
  self : GraphcolorfractionalSlice,
  f : Double,
) -> GraphcolorfractionalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalSlice::add(
  self : GraphcolorfractionalSlice,
  other : GraphcolorfractionalSlice,
) -> GraphcolorfractionalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalSlice::copy(
  self : GraphcolorfractionalSlice,
) -> GraphcolorfractionalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalSlice::fill(
  self : GraphcolorfractionalSlice,
  v : Double,
) -> GraphcolorfractionalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorfractionalSlice::min(
  self : GraphcolorfractionalSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorfractionalSlice::max(
  self : GraphcolorfractionalSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorfractionalSlice::to_string(
  self : GraphcolorfractionalSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
