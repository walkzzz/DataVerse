///|
///===
/// extcore/graph_color_backtrack
pub(all) struct GraphcolorbacktrackPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_color_backtrack_make_point(
  x : Double,
  y : Double,
) -> GraphcolorbacktrackPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_color_backtrack_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphcolorbacktrackPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphcolorbacktrackPoint::x(self : GraphcolorbacktrackPoint) -> Double {
  self.x
}

///|
pub fn GraphcolorbacktrackPoint::y(self : GraphcolorbacktrackPoint) -> Double {
  self.y
}

///|
pub fn GraphcolorbacktrackPoint::z(self : GraphcolorbacktrackPoint) -> Double {
  self.z
}

///|
pub fn GraphcolorbacktrackPoint::label(
  self : GraphcolorbacktrackPoint,
) -> Int32 {
  self.label
}

///|
pub fn GraphcolorbacktrackPoint::dist(
  self : GraphcolorbacktrackPoint,
  other : GraphcolorbacktrackPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphcolorbacktrackPoint::add(
  self : GraphcolorbacktrackPoint,
  other : GraphcolorbacktrackPoint,
) -> GraphcolorbacktrackPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphcolorbacktrackPoint::sub(
  self : GraphcolorbacktrackPoint,
  other : GraphcolorbacktrackPoint,
) -> GraphcolorbacktrackPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphcolorbacktrackPoint::scale(
  self : GraphcolorbacktrackPoint,
  s : Double,
) -> GraphcolorbacktrackPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphcolorbacktrackPoint::dot(
  self : GraphcolorbacktrackPoint,
  other : GraphcolorbacktrackPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphcolorbacktrackPoint::cross(
  self : GraphcolorbacktrackPoint,
  other : GraphcolorbacktrackPoint,
) -> GraphcolorbacktrackPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphcolorbacktrackPoint::norm(
  self : GraphcolorbacktrackPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphcolorbacktrackPoint::normalize(
  self : GraphcolorbacktrackPoint,
) -> GraphcolorbacktrackPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphcolorbacktrackPoint::negate(
  self : GraphcolorbacktrackPoint,
) -> GraphcolorbacktrackPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphcolorbacktrackPoint::mid(
  self : GraphcolorbacktrackPoint,
  other : GraphcolorbacktrackPoint,
) -> GraphcolorbacktrackPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphcolorbacktrackPoint::lerp(
  self : GraphcolorbacktrackPoint,
  other : GraphcolorbacktrackPoint,
  t : Double,
) -> GraphcolorbacktrackPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphcolorbacktrackPoint::to_string(
  self : GraphcolorbacktrackPoint,
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
pub(all) struct GraphcolorbacktrackSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_color_backtrack_make_series(
  vals : Array[Double],
  name : String,
) -> GraphcolorbacktrackSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphcolorbacktrackSeries::len(
  self : GraphcolorbacktrackSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphcolorbacktrackSeries::sum(
  self : GraphcolorbacktrackSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphcolorbacktrackSeries::mean(
  self : GraphcolorbacktrackSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphcolorbacktrackSeries::min(
  self : GraphcolorbacktrackSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphcolorbacktrackSeries::max(
  self : GraphcolorbacktrackSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphcolorbacktrackSeries::range(
  self : GraphcolorbacktrackSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphcolorbacktrackSeries::variance(
  self : GraphcolorbacktrackSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphcolorbacktrackSeries::std(
  self : GraphcolorbacktrackSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphcolorbacktrackSeries::median(
  self : GraphcolorbacktrackSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphcolorbacktrackSeries::scale(
  self : GraphcolorbacktrackSeries,
  f : Double,
) -> GraphcolorbacktrackSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphcolorbacktrackSeries::add(
  self : GraphcolorbacktrackSeries,
  other : GraphcolorbacktrackSeries,
) -> GraphcolorbacktrackSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphcolorbacktrackSeries::sub(
  self : GraphcolorbacktrackSeries,
  other : GraphcolorbacktrackSeries,
) -> GraphcolorbacktrackSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphcolorbacktrackSeries::normalize(
  self : GraphcolorbacktrackSeries,
) -> GraphcolorbacktrackSeries {
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
pub fn GraphcolorbacktrackSeries::cumsum(
  self : GraphcolorbacktrackSeries,
) -> GraphcolorbacktrackSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphcolorbacktrackSeries::to_string(
  self : GraphcolorbacktrackSeries,
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
pub(all) struct GraphcolorbacktrackMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_color_backtrack_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphcolorbacktrackMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_color_backtrack_matrix_identity(
  n : Int32,
) -> GraphcolorbacktrackMatrix {
  let m = graph_color_backtrack_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphcolorbacktrackMatrix::get(
  self : GraphcolorbacktrackMatrix,
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
pub fn GraphcolorbacktrackMatrix::transpose(
  self : GraphcolorbacktrackMatrix,
) -> GraphcolorbacktrackMatrix {
  let result = graph_color_backtrack_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphcolorbacktrackMatrix::add(
  self : GraphcolorbacktrackMatrix,
  other : GraphcolorbacktrackMatrix,
) -> GraphcolorbacktrackMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_color_backtrack_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphcolorbacktrackMatrix::scale(
  self : GraphcolorbacktrackMatrix,
  s : Double,
) -> GraphcolorbacktrackMatrix {
  let result = graph_color_backtrack_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphcolorbacktrackMatrix::multiply(
  self : GraphcolorbacktrackMatrix,
  other : GraphcolorbacktrackMatrix,
) -> GraphcolorbacktrackMatrix {
  if self.cols != other.rows {
    return graph_color_backtrack_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_color_backtrack_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphcolorbacktrackMatrix::trace(
  self : GraphcolorbacktrackMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphcolorbacktrackMatrix::det(
  self : GraphcolorbacktrackMatrix,
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
pub fn GraphcolorbacktrackMatrix::norm(
  self : GraphcolorbacktrackMatrix,
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
pub fn GraphcolorbacktrackMatrix::to_string(
  self : GraphcolorbacktrackMatrix,
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
pub(all) struct GraphcolorbacktrackVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_color_backtrack_make_vector(
  comps : Array[Double],
) -> GraphcolorbacktrackVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_color_backtrack_vector_zero(
  dim : Int32,
) -> GraphcolorbacktrackVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphcolorbacktrackVector::add(
  self : GraphcolorbacktrackVector,
  other : GraphcolorbacktrackVector,
) -> GraphcolorbacktrackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphcolorbacktrackVector::sub(
  self : GraphcolorbacktrackVector,
  other : GraphcolorbacktrackVector,
) -> GraphcolorbacktrackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphcolorbacktrackVector::scale(
  self : GraphcolorbacktrackVector,
  s : Double,
) -> GraphcolorbacktrackVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphcolorbacktrackVector::dot(
  self : GraphcolorbacktrackVector,
  other : GraphcolorbacktrackVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphcolorbacktrackVector::norm(
  self : GraphcolorbacktrackVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphcolorbacktrackVector::normalize(
  self : GraphcolorbacktrackVector,
) -> GraphcolorbacktrackVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphcolorbacktrackVector::dist(
  self : GraphcolorbacktrackVector,
  other : GraphcolorbacktrackVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphcolorbacktrackVector::to_string(
  self : GraphcolorbacktrackVector,
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
pub(all) struct GraphcolorbacktrackFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_frame_make(
  size : Int32,
) -> GraphcolorbacktrackFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackFrame::len(self : GraphcolorbacktrackFrame) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackFrame::get(
  self : GraphcolorbacktrackFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackFrame::set(
  self : GraphcolorbacktrackFrame,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackFrame::sum(self : GraphcolorbacktrackFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackFrame::mean(
  self : GraphcolorbacktrackFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackFrame::scale(
  self : GraphcolorbacktrackFrame,
  f : Double,
) -> GraphcolorbacktrackFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackFrame::add(
  self : GraphcolorbacktrackFrame,
  other : GraphcolorbacktrackFrame,
) -> GraphcolorbacktrackFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackFrame::copy(
  self : GraphcolorbacktrackFrame,
) -> GraphcolorbacktrackFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackFrame::fill(
  self : GraphcolorbacktrackFrame,
  v : Double,
) -> GraphcolorbacktrackFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackFrame::min(self : GraphcolorbacktrackFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackFrame::max(self : GraphcolorbacktrackFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackFrame::to_string(
  self : GraphcolorbacktrackFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_table_make(
  size : Int32,
) -> GraphcolorbacktrackTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackTable::len(self : GraphcolorbacktrackTable) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackTable::get(
  self : GraphcolorbacktrackTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackTable::set(
  self : GraphcolorbacktrackTable,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackTable::sum(self : GraphcolorbacktrackTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackTable::mean(
  self : GraphcolorbacktrackTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackTable::scale(
  self : GraphcolorbacktrackTable,
  f : Double,
) -> GraphcolorbacktrackTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackTable::add(
  self : GraphcolorbacktrackTable,
  other : GraphcolorbacktrackTable,
) -> GraphcolorbacktrackTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackTable::copy(
  self : GraphcolorbacktrackTable,
) -> GraphcolorbacktrackTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackTable::fill(
  self : GraphcolorbacktrackTable,
  v : Double,
) -> GraphcolorbacktrackTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackTable::min(self : GraphcolorbacktrackTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackTable::max(self : GraphcolorbacktrackTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackTable::to_string(
  self : GraphcolorbacktrackTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_graphn_make(
  size : Int32,
) -> GraphcolorbacktrackGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackGraphN::len(
  self : GraphcolorbacktrackGraphN,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackGraphN::get(
  self : GraphcolorbacktrackGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackGraphN::set(
  self : GraphcolorbacktrackGraphN,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackGraphN::sum(
  self : GraphcolorbacktrackGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackGraphN::mean(
  self : GraphcolorbacktrackGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackGraphN::scale(
  self : GraphcolorbacktrackGraphN,
  f : Double,
) -> GraphcolorbacktrackGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackGraphN::add(
  self : GraphcolorbacktrackGraphN,
  other : GraphcolorbacktrackGraphN,
) -> GraphcolorbacktrackGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackGraphN::copy(
  self : GraphcolorbacktrackGraphN,
) -> GraphcolorbacktrackGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackGraphN::fill(
  self : GraphcolorbacktrackGraphN,
  v : Double,
) -> GraphcolorbacktrackGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackGraphN::min(
  self : GraphcolorbacktrackGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackGraphN::max(
  self : GraphcolorbacktrackGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackGraphN::to_string(
  self : GraphcolorbacktrackGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_node_make(size : Int32) -> GraphcolorbacktrackNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackNode::len(self : GraphcolorbacktrackNode) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackNode::get(
  self : GraphcolorbacktrackNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackNode::set(
  self : GraphcolorbacktrackNode,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackNode::sum(self : GraphcolorbacktrackNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackNode::mean(self : GraphcolorbacktrackNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackNode::scale(
  self : GraphcolorbacktrackNode,
  f : Double,
) -> GraphcolorbacktrackNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackNode::add(
  self : GraphcolorbacktrackNode,
  other : GraphcolorbacktrackNode,
) -> GraphcolorbacktrackNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackNode::copy(
  self : GraphcolorbacktrackNode,
) -> GraphcolorbacktrackNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackNode::fill(
  self : GraphcolorbacktrackNode,
  v : Double,
) -> GraphcolorbacktrackNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackNode::min(self : GraphcolorbacktrackNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackNode::max(self : GraphcolorbacktrackNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackNode::to_string(
  self : GraphcolorbacktrackNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_edge_make(size : Int32) -> GraphcolorbacktrackEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackEdge::len(self : GraphcolorbacktrackEdge) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackEdge::get(
  self : GraphcolorbacktrackEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackEdge::set(
  self : GraphcolorbacktrackEdge,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackEdge::sum(self : GraphcolorbacktrackEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackEdge::mean(self : GraphcolorbacktrackEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackEdge::scale(
  self : GraphcolorbacktrackEdge,
  f : Double,
) -> GraphcolorbacktrackEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackEdge::add(
  self : GraphcolorbacktrackEdge,
  other : GraphcolorbacktrackEdge,
) -> GraphcolorbacktrackEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackEdge::copy(
  self : GraphcolorbacktrackEdge,
) -> GraphcolorbacktrackEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackEdge::fill(
  self : GraphcolorbacktrackEdge,
  v : Double,
) -> GraphcolorbacktrackEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackEdge::min(self : GraphcolorbacktrackEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackEdge::max(self : GraphcolorbacktrackEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackEdge::to_string(
  self : GraphcolorbacktrackEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_path_make(size : Int32) -> GraphcolorbacktrackPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackPath::len(self : GraphcolorbacktrackPath) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackPath::get(
  self : GraphcolorbacktrackPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackPath::set(
  self : GraphcolorbacktrackPath,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackPath::sum(self : GraphcolorbacktrackPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackPath::mean(self : GraphcolorbacktrackPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackPath::scale(
  self : GraphcolorbacktrackPath,
  f : Double,
) -> GraphcolorbacktrackPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackPath::add(
  self : GraphcolorbacktrackPath,
  other : GraphcolorbacktrackPath,
) -> GraphcolorbacktrackPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackPath::copy(
  self : GraphcolorbacktrackPath,
) -> GraphcolorbacktrackPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackPath::fill(
  self : GraphcolorbacktrackPath,
  v : Double,
) -> GraphcolorbacktrackPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackPath::min(self : GraphcolorbacktrackPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackPath::max(self : GraphcolorbacktrackPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackPath::to_string(
  self : GraphcolorbacktrackPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_cluster_make(
  size : Int32,
) -> GraphcolorbacktrackCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackCluster::len(
  self : GraphcolorbacktrackCluster,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackCluster::get(
  self : GraphcolorbacktrackCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackCluster::set(
  self : GraphcolorbacktrackCluster,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackCluster::sum(
  self : GraphcolorbacktrackCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackCluster::mean(
  self : GraphcolorbacktrackCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackCluster::scale(
  self : GraphcolorbacktrackCluster,
  f : Double,
) -> GraphcolorbacktrackCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackCluster::add(
  self : GraphcolorbacktrackCluster,
  other : GraphcolorbacktrackCluster,
) -> GraphcolorbacktrackCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackCluster::copy(
  self : GraphcolorbacktrackCluster,
) -> GraphcolorbacktrackCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackCluster::fill(
  self : GraphcolorbacktrackCluster,
  v : Double,
) -> GraphcolorbacktrackCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackCluster::min(
  self : GraphcolorbacktrackCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackCluster::max(
  self : GraphcolorbacktrackCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackCluster::to_string(
  self : GraphcolorbacktrackCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_model_make(
  size : Int32,
) -> GraphcolorbacktrackModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackModel::len(self : GraphcolorbacktrackModel) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackModel::get(
  self : GraphcolorbacktrackModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackModel::set(
  self : GraphcolorbacktrackModel,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackModel::sum(self : GraphcolorbacktrackModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackModel::mean(
  self : GraphcolorbacktrackModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackModel::scale(
  self : GraphcolorbacktrackModel,
  f : Double,
) -> GraphcolorbacktrackModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackModel::add(
  self : GraphcolorbacktrackModel,
  other : GraphcolorbacktrackModel,
) -> GraphcolorbacktrackModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackModel::copy(
  self : GraphcolorbacktrackModel,
) -> GraphcolorbacktrackModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackModel::fill(
  self : GraphcolorbacktrackModel,
  v : Double,
) -> GraphcolorbacktrackModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackModel::min(self : GraphcolorbacktrackModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackModel::max(self : GraphcolorbacktrackModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackModel::to_string(
  self : GraphcolorbacktrackModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_layer_make(
  size : Int32,
) -> GraphcolorbacktrackLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackLayer::len(self : GraphcolorbacktrackLayer) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackLayer::get(
  self : GraphcolorbacktrackLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackLayer::set(
  self : GraphcolorbacktrackLayer,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackLayer::sum(self : GraphcolorbacktrackLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackLayer::mean(
  self : GraphcolorbacktrackLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackLayer::scale(
  self : GraphcolorbacktrackLayer,
  f : Double,
) -> GraphcolorbacktrackLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackLayer::add(
  self : GraphcolorbacktrackLayer,
  other : GraphcolorbacktrackLayer,
) -> GraphcolorbacktrackLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackLayer::copy(
  self : GraphcolorbacktrackLayer,
) -> GraphcolorbacktrackLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackLayer::fill(
  self : GraphcolorbacktrackLayer,
  v : Double,
) -> GraphcolorbacktrackLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackLayer::min(self : GraphcolorbacktrackLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackLayer::max(self : GraphcolorbacktrackLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackLayer::to_string(
  self : GraphcolorbacktrackLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_buffer_make(
  size : Int32,
) -> GraphcolorbacktrackBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackBuffer::len(
  self : GraphcolorbacktrackBuffer,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackBuffer::get(
  self : GraphcolorbacktrackBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackBuffer::set(
  self : GraphcolorbacktrackBuffer,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackBuffer::sum(
  self : GraphcolorbacktrackBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackBuffer::mean(
  self : GraphcolorbacktrackBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackBuffer::scale(
  self : GraphcolorbacktrackBuffer,
  f : Double,
) -> GraphcolorbacktrackBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackBuffer::add(
  self : GraphcolorbacktrackBuffer,
  other : GraphcolorbacktrackBuffer,
) -> GraphcolorbacktrackBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackBuffer::copy(
  self : GraphcolorbacktrackBuffer,
) -> GraphcolorbacktrackBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackBuffer::fill(
  self : GraphcolorbacktrackBuffer,
  v : Double,
) -> GraphcolorbacktrackBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackBuffer::min(
  self : GraphcolorbacktrackBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackBuffer::max(
  self : GraphcolorbacktrackBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackBuffer::to_string(
  self : GraphcolorbacktrackBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_cursor_make(
  size : Int32,
) -> GraphcolorbacktrackCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackCursor::len(
  self : GraphcolorbacktrackCursor,
) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackCursor::get(
  self : GraphcolorbacktrackCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackCursor::set(
  self : GraphcolorbacktrackCursor,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackCursor::sum(
  self : GraphcolorbacktrackCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackCursor::mean(
  self : GraphcolorbacktrackCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackCursor::scale(
  self : GraphcolorbacktrackCursor,
  f : Double,
) -> GraphcolorbacktrackCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackCursor::add(
  self : GraphcolorbacktrackCursor,
  other : GraphcolorbacktrackCursor,
) -> GraphcolorbacktrackCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackCursor::copy(
  self : GraphcolorbacktrackCursor,
) -> GraphcolorbacktrackCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackCursor::fill(
  self : GraphcolorbacktrackCursor,
  v : Double,
) -> GraphcolorbacktrackCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackCursor::min(
  self : GraphcolorbacktrackCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackCursor::max(
  self : GraphcolorbacktrackCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackCursor::to_string(
  self : GraphcolorbacktrackCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_view_make(size : Int32) -> GraphcolorbacktrackView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackView::len(self : GraphcolorbacktrackView) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackView::get(
  self : GraphcolorbacktrackView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackView::set(
  self : GraphcolorbacktrackView,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackView::sum(self : GraphcolorbacktrackView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackView::mean(self : GraphcolorbacktrackView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackView::scale(
  self : GraphcolorbacktrackView,
  f : Double,
) -> GraphcolorbacktrackView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackView::add(
  self : GraphcolorbacktrackView,
  other : GraphcolorbacktrackView,
) -> GraphcolorbacktrackView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackView::copy(
  self : GraphcolorbacktrackView,
) -> GraphcolorbacktrackView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackView::fill(
  self : GraphcolorbacktrackView,
  v : Double,
) -> GraphcolorbacktrackView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackView::min(self : GraphcolorbacktrackView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackView::max(self : GraphcolorbacktrackView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackView::to_string(
  self : GraphcolorbacktrackView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_range_make(
  size : Int32,
) -> GraphcolorbacktrackRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackRange::len(self : GraphcolorbacktrackRange) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackRange::get(
  self : GraphcolorbacktrackRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackRange::set(
  self : GraphcolorbacktrackRange,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackRange::sum(self : GraphcolorbacktrackRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackRange::mean(
  self : GraphcolorbacktrackRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackRange::scale(
  self : GraphcolorbacktrackRange,
  f : Double,
) -> GraphcolorbacktrackRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackRange::add(
  self : GraphcolorbacktrackRange,
  other : GraphcolorbacktrackRange,
) -> GraphcolorbacktrackRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackRange::copy(
  self : GraphcolorbacktrackRange,
) -> GraphcolorbacktrackRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackRange::fill(
  self : GraphcolorbacktrackRange,
  v : Double,
) -> GraphcolorbacktrackRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackRange::min(self : GraphcolorbacktrackRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackRange::max(self : GraphcolorbacktrackRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackRange::to_string(
  self : GraphcolorbacktrackRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorbacktrackSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_backtrack_slice_make(
  size : Int32,
) -> GraphcolorbacktrackSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorbacktrackSlice::len(self : GraphcolorbacktrackSlice) -> Int32 {
  self.size
}

///|
pub fn GraphcolorbacktrackSlice::get(
  self : GraphcolorbacktrackSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorbacktrackSlice::set(
  self : GraphcolorbacktrackSlice,
  i : Int32,
  v : Double,
) -> GraphcolorbacktrackSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackSlice::sum(self : GraphcolorbacktrackSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorbacktrackSlice::mean(
  self : GraphcolorbacktrackSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorbacktrackSlice::scale(
  self : GraphcolorbacktrackSlice,
  f : Double,
) -> GraphcolorbacktrackSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackSlice::add(
  self : GraphcolorbacktrackSlice,
  other : GraphcolorbacktrackSlice,
) -> GraphcolorbacktrackSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackSlice::copy(
  self : GraphcolorbacktrackSlice,
) -> GraphcolorbacktrackSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackSlice::fill(
  self : GraphcolorbacktrackSlice,
  v : Double,
) -> GraphcolorbacktrackSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorbacktrackSlice::min(self : GraphcolorbacktrackSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorbacktrackSlice::max(self : GraphcolorbacktrackSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorbacktrackSlice::to_string(
  self : GraphcolorbacktrackSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
