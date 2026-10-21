///|
///===
/// extcore/stats_dist_gamma
pub(all) struct StatsdistgammaPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn stats_dist_gamma_make_point(
  x : Double,
  y : Double,
) -> StatsdistgammaPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn stats_dist_gamma_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> StatsdistgammaPoint {
  { x, y, z, label: 0, }
}

///|
pub fn StatsdistgammaPoint::x(self : StatsdistgammaPoint) -> Double {
  self.x
}

///|
pub fn StatsdistgammaPoint::y(self : StatsdistgammaPoint) -> Double {
  self.y
}

///|
pub fn StatsdistgammaPoint::z(self : StatsdistgammaPoint) -> Double {
  self.z
}

///|
pub fn StatsdistgammaPoint::label(self : StatsdistgammaPoint) -> Int32 {
  self.label
}

///|
pub fn StatsdistgammaPoint::dist(
  self : StatsdistgammaPoint,
  other : StatsdistgammaPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn StatsdistgammaPoint::add(
  self : StatsdistgammaPoint,
  other : StatsdistgammaPoint,
) -> StatsdistgammaPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn StatsdistgammaPoint::sub(
  self : StatsdistgammaPoint,
  other : StatsdistgammaPoint,
) -> StatsdistgammaPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn StatsdistgammaPoint::scale(
  self : StatsdistgammaPoint,
  s : Double,
) -> StatsdistgammaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn StatsdistgammaPoint::dot(
  self : StatsdistgammaPoint,
  other : StatsdistgammaPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn StatsdistgammaPoint::cross(
  self : StatsdistgammaPoint,
  other : StatsdistgammaPoint,
) -> StatsdistgammaPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn StatsdistgammaPoint::norm(self : StatsdistgammaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn StatsdistgammaPoint::normalize(
  self : StatsdistgammaPoint,
) -> StatsdistgammaPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdistgammaPoint::negate(
  self : StatsdistgammaPoint,
) -> StatsdistgammaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn StatsdistgammaPoint::mid(
  self : StatsdistgammaPoint,
  other : StatsdistgammaPoint,
) -> StatsdistgammaPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn StatsdistgammaPoint::lerp(
  self : StatsdistgammaPoint,
  other : StatsdistgammaPoint,
  t : Double,
) -> StatsdistgammaPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn StatsdistgammaPoint::to_string(self : StatsdistgammaPoint) -> String {
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
pub(all) struct StatsdistgammaSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn stats_dist_gamma_make_series(
  vals : Array[Double],
  name : String,
) -> StatsdistgammaSeries {
  { vals, name, meta: 0, }
}

///|
pub fn StatsdistgammaSeries::len(self : StatsdistgammaSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn StatsdistgammaSeries::sum(self : StatsdistgammaSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn StatsdistgammaSeries::mean(self : StatsdistgammaSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn StatsdistgammaSeries::min(self : StatsdistgammaSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn StatsdistgammaSeries::max(self : StatsdistgammaSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn StatsdistgammaSeries::range(self : StatsdistgammaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn StatsdistgammaSeries::variance(self : StatsdistgammaSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn StatsdistgammaSeries::std(self : StatsdistgammaSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn StatsdistgammaSeries::median(self : StatsdistgammaSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn StatsdistgammaSeries::scale(
  self : StatsdistgammaSeries,
  f : Double,
) -> StatsdistgammaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn StatsdistgammaSeries::add(
  self : StatsdistgammaSeries,
  other : StatsdistgammaSeries,
) -> StatsdistgammaSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdistgammaSeries::sub(
  self : StatsdistgammaSeries,
  other : StatsdistgammaSeries,
) -> StatsdistgammaSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn StatsdistgammaSeries::normalize(
  self : StatsdistgammaSeries,
) -> StatsdistgammaSeries {
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
pub fn StatsdistgammaSeries::cumsum(
  self : StatsdistgammaSeries,
) -> StatsdistgammaSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn StatsdistgammaSeries::to_string(self : StatsdistgammaSeries) -> String {
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
pub(all) struct StatsdistgammaMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn stats_dist_gamma_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> StatsdistgammaMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn stats_dist_gamma_matrix_identity(n : Int32) -> StatsdistgammaMatrix {
  let m = stats_dist_gamma_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn StatsdistgammaMatrix::get(
  self : StatsdistgammaMatrix,
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
pub fn StatsdistgammaMatrix::transpose(
  self : StatsdistgammaMatrix,
) -> StatsdistgammaMatrix {
  let result = stats_dist_gamma_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdistgammaMatrix::add(
  self : StatsdistgammaMatrix,
  other : StatsdistgammaMatrix,
) -> StatsdistgammaMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = stats_dist_gamma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn StatsdistgammaMatrix::scale(
  self : StatsdistgammaMatrix,
  s : Double,
) -> StatsdistgammaMatrix {
  let result = stats_dist_gamma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn StatsdistgammaMatrix::multiply(
  self : StatsdistgammaMatrix,
  other : StatsdistgammaMatrix,
) -> StatsdistgammaMatrix {
  if self.cols != other.rows {
    return stats_dist_gamma_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = stats_dist_gamma_make_matrix(self.rows, other.cols, 0.0)
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
pub fn StatsdistgammaMatrix::trace(self : StatsdistgammaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn StatsdistgammaMatrix::det(self : StatsdistgammaMatrix) -> Double {
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
pub fn StatsdistgammaMatrix::norm(self : StatsdistgammaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn StatsdistgammaMatrix::to_string(self : StatsdistgammaMatrix) -> String {
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
pub(all) struct StatsdistgammaVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn stats_dist_gamma_make_vector(
  comps : Array[Double],
) -> StatsdistgammaVector {
  { comps, dim: comps.length(), }
}

///|
pub fn stats_dist_gamma_vector_zero(dim : Int32) -> StatsdistgammaVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn StatsdistgammaVector::add(
  self : StatsdistgammaVector,
  other : StatsdistgammaVector,
) -> StatsdistgammaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdistgammaVector::sub(
  self : StatsdistgammaVector,
  other : StatsdistgammaVector,
) -> StatsdistgammaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn StatsdistgammaVector::scale(
  self : StatsdistgammaVector,
  s : Double,
) -> StatsdistgammaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn StatsdistgammaVector::dot(
  self : StatsdistgammaVector,
  other : StatsdistgammaVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn StatsdistgammaVector::norm(self : StatsdistgammaVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn StatsdistgammaVector::normalize(
  self : StatsdistgammaVector,
) -> StatsdistgammaVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn StatsdistgammaVector::dist(
  self : StatsdistgammaVector,
  other : StatsdistgammaVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn StatsdistgammaVector::to_string(self : StatsdistgammaVector) -> String {
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
pub(all) struct StatsdistgammaFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_frame_make(size : Int32) -> StatsdistgammaFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaFrame::len(self : StatsdistgammaFrame) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaFrame::get(
  self : StatsdistgammaFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaFrame::set(
  self : StatsdistgammaFrame,
  i : Int32,
  v : Double,
) -> StatsdistgammaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaFrame::sum(self : StatsdistgammaFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaFrame::mean(self : StatsdistgammaFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaFrame::scale(
  self : StatsdistgammaFrame,
  f : Double,
) -> StatsdistgammaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaFrame::add(
  self : StatsdistgammaFrame,
  other : StatsdistgammaFrame,
) -> StatsdistgammaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaFrame::copy(
  self : StatsdistgammaFrame,
) -> StatsdistgammaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaFrame::fill(
  self : StatsdistgammaFrame,
  v : Double,
) -> StatsdistgammaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaFrame::min(self : StatsdistgammaFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaFrame::max(self : StatsdistgammaFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaFrame::to_string(self : StatsdistgammaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_table_make(size : Int32) -> StatsdistgammaTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaTable::len(self : StatsdistgammaTable) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaTable::get(
  self : StatsdistgammaTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaTable::set(
  self : StatsdistgammaTable,
  i : Int32,
  v : Double,
) -> StatsdistgammaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaTable::sum(self : StatsdistgammaTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaTable::mean(self : StatsdistgammaTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaTable::scale(
  self : StatsdistgammaTable,
  f : Double,
) -> StatsdistgammaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaTable::add(
  self : StatsdistgammaTable,
  other : StatsdistgammaTable,
) -> StatsdistgammaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaTable::copy(
  self : StatsdistgammaTable,
) -> StatsdistgammaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaTable::fill(
  self : StatsdistgammaTable,
  v : Double,
) -> StatsdistgammaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaTable::min(self : StatsdistgammaTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaTable::max(self : StatsdistgammaTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaTable::to_string(self : StatsdistgammaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_graphn_make(size : Int32) -> StatsdistgammaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaGraphN::len(self : StatsdistgammaGraphN) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaGraphN::get(
  self : StatsdistgammaGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaGraphN::set(
  self : StatsdistgammaGraphN,
  i : Int32,
  v : Double,
) -> StatsdistgammaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaGraphN::sum(self : StatsdistgammaGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaGraphN::mean(self : StatsdistgammaGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaGraphN::scale(
  self : StatsdistgammaGraphN,
  f : Double,
) -> StatsdistgammaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaGraphN::add(
  self : StatsdistgammaGraphN,
  other : StatsdistgammaGraphN,
) -> StatsdistgammaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaGraphN::copy(
  self : StatsdistgammaGraphN,
) -> StatsdistgammaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaGraphN::fill(
  self : StatsdistgammaGraphN,
  v : Double,
) -> StatsdistgammaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaGraphN::min(self : StatsdistgammaGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaGraphN::max(self : StatsdistgammaGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaGraphN::to_string(self : StatsdistgammaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_node_make(size : Int32) -> StatsdistgammaNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaNode::len(self : StatsdistgammaNode) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaNode::get(self : StatsdistgammaNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaNode::set(
  self : StatsdistgammaNode,
  i : Int32,
  v : Double,
) -> StatsdistgammaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaNode::sum(self : StatsdistgammaNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaNode::mean(self : StatsdistgammaNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaNode::scale(
  self : StatsdistgammaNode,
  f : Double,
) -> StatsdistgammaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaNode::add(
  self : StatsdistgammaNode,
  other : StatsdistgammaNode,
) -> StatsdistgammaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaNode::copy(
  self : StatsdistgammaNode,
) -> StatsdistgammaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaNode::fill(
  self : StatsdistgammaNode,
  v : Double,
) -> StatsdistgammaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaNode::min(self : StatsdistgammaNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaNode::max(self : StatsdistgammaNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaNode::to_string(self : StatsdistgammaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_edge_make(size : Int32) -> StatsdistgammaEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaEdge::len(self : StatsdistgammaEdge) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaEdge::get(self : StatsdistgammaEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaEdge::set(
  self : StatsdistgammaEdge,
  i : Int32,
  v : Double,
) -> StatsdistgammaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaEdge::sum(self : StatsdistgammaEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaEdge::mean(self : StatsdistgammaEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaEdge::scale(
  self : StatsdistgammaEdge,
  f : Double,
) -> StatsdistgammaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaEdge::add(
  self : StatsdistgammaEdge,
  other : StatsdistgammaEdge,
) -> StatsdistgammaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaEdge::copy(
  self : StatsdistgammaEdge,
) -> StatsdistgammaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaEdge::fill(
  self : StatsdistgammaEdge,
  v : Double,
) -> StatsdistgammaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaEdge::min(self : StatsdistgammaEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaEdge::max(self : StatsdistgammaEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaEdge::to_string(self : StatsdistgammaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_path_make(size : Int32) -> StatsdistgammaPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaPath::len(self : StatsdistgammaPath) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaPath::get(self : StatsdistgammaPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaPath::set(
  self : StatsdistgammaPath,
  i : Int32,
  v : Double,
) -> StatsdistgammaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaPath::sum(self : StatsdistgammaPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaPath::mean(self : StatsdistgammaPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaPath::scale(
  self : StatsdistgammaPath,
  f : Double,
) -> StatsdistgammaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaPath::add(
  self : StatsdistgammaPath,
  other : StatsdistgammaPath,
) -> StatsdistgammaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaPath::copy(
  self : StatsdistgammaPath,
) -> StatsdistgammaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaPath::fill(
  self : StatsdistgammaPath,
  v : Double,
) -> StatsdistgammaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaPath::min(self : StatsdistgammaPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaPath::max(self : StatsdistgammaPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaPath::to_string(self : StatsdistgammaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_cluster_make(size : Int32) -> StatsdistgammaCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaCluster::len(self : StatsdistgammaCluster) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaCluster::get(
  self : StatsdistgammaCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaCluster::set(
  self : StatsdistgammaCluster,
  i : Int32,
  v : Double,
) -> StatsdistgammaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaCluster::sum(self : StatsdistgammaCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaCluster::mean(self : StatsdistgammaCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaCluster::scale(
  self : StatsdistgammaCluster,
  f : Double,
) -> StatsdistgammaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaCluster::add(
  self : StatsdistgammaCluster,
  other : StatsdistgammaCluster,
) -> StatsdistgammaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaCluster::copy(
  self : StatsdistgammaCluster,
) -> StatsdistgammaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaCluster::fill(
  self : StatsdistgammaCluster,
  v : Double,
) -> StatsdistgammaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaCluster::min(self : StatsdistgammaCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaCluster::max(self : StatsdistgammaCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaCluster::to_string(self : StatsdistgammaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_model_make(size : Int32) -> StatsdistgammaModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaModel::len(self : StatsdistgammaModel) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaModel::get(
  self : StatsdistgammaModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaModel::set(
  self : StatsdistgammaModel,
  i : Int32,
  v : Double,
) -> StatsdistgammaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaModel::sum(self : StatsdistgammaModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaModel::mean(self : StatsdistgammaModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaModel::scale(
  self : StatsdistgammaModel,
  f : Double,
) -> StatsdistgammaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaModel::add(
  self : StatsdistgammaModel,
  other : StatsdistgammaModel,
) -> StatsdistgammaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaModel::copy(
  self : StatsdistgammaModel,
) -> StatsdistgammaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaModel::fill(
  self : StatsdistgammaModel,
  v : Double,
) -> StatsdistgammaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaModel::min(self : StatsdistgammaModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaModel::max(self : StatsdistgammaModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaModel::to_string(self : StatsdistgammaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_layer_make(size : Int32) -> StatsdistgammaLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaLayer::len(self : StatsdistgammaLayer) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaLayer::get(
  self : StatsdistgammaLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaLayer::set(
  self : StatsdistgammaLayer,
  i : Int32,
  v : Double,
) -> StatsdistgammaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaLayer::sum(self : StatsdistgammaLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaLayer::mean(self : StatsdistgammaLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaLayer::scale(
  self : StatsdistgammaLayer,
  f : Double,
) -> StatsdistgammaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaLayer::add(
  self : StatsdistgammaLayer,
  other : StatsdistgammaLayer,
) -> StatsdistgammaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaLayer::copy(
  self : StatsdistgammaLayer,
) -> StatsdistgammaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaLayer::fill(
  self : StatsdistgammaLayer,
  v : Double,
) -> StatsdistgammaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaLayer::min(self : StatsdistgammaLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaLayer::max(self : StatsdistgammaLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaLayer::to_string(self : StatsdistgammaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_buffer_make(size : Int32) -> StatsdistgammaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaBuffer::len(self : StatsdistgammaBuffer) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaBuffer::get(
  self : StatsdistgammaBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaBuffer::set(
  self : StatsdistgammaBuffer,
  i : Int32,
  v : Double,
) -> StatsdistgammaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaBuffer::sum(self : StatsdistgammaBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaBuffer::mean(self : StatsdistgammaBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaBuffer::scale(
  self : StatsdistgammaBuffer,
  f : Double,
) -> StatsdistgammaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaBuffer::add(
  self : StatsdistgammaBuffer,
  other : StatsdistgammaBuffer,
) -> StatsdistgammaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaBuffer::copy(
  self : StatsdistgammaBuffer,
) -> StatsdistgammaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaBuffer::fill(
  self : StatsdistgammaBuffer,
  v : Double,
) -> StatsdistgammaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaBuffer::min(self : StatsdistgammaBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaBuffer::max(self : StatsdistgammaBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaBuffer::to_string(self : StatsdistgammaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_cursor_make(size : Int32) -> StatsdistgammaCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaCursor::len(self : StatsdistgammaCursor) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaCursor::get(
  self : StatsdistgammaCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaCursor::set(
  self : StatsdistgammaCursor,
  i : Int32,
  v : Double,
) -> StatsdistgammaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaCursor::sum(self : StatsdistgammaCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaCursor::mean(self : StatsdistgammaCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaCursor::scale(
  self : StatsdistgammaCursor,
  f : Double,
) -> StatsdistgammaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaCursor::add(
  self : StatsdistgammaCursor,
  other : StatsdistgammaCursor,
) -> StatsdistgammaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaCursor::copy(
  self : StatsdistgammaCursor,
) -> StatsdistgammaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaCursor::fill(
  self : StatsdistgammaCursor,
  v : Double,
) -> StatsdistgammaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaCursor::min(self : StatsdistgammaCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaCursor::max(self : StatsdistgammaCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaCursor::to_string(self : StatsdistgammaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_view_make(size : Int32) -> StatsdistgammaView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaView::len(self : StatsdistgammaView) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaView::get(self : StatsdistgammaView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaView::set(
  self : StatsdistgammaView,
  i : Int32,
  v : Double,
) -> StatsdistgammaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaView::sum(self : StatsdistgammaView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaView::mean(self : StatsdistgammaView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaView::scale(
  self : StatsdistgammaView,
  f : Double,
) -> StatsdistgammaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaView::add(
  self : StatsdistgammaView,
  other : StatsdistgammaView,
) -> StatsdistgammaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaView::copy(
  self : StatsdistgammaView,
) -> StatsdistgammaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaView::fill(
  self : StatsdistgammaView,
  v : Double,
) -> StatsdistgammaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaView::min(self : StatsdistgammaView) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaView::max(self : StatsdistgammaView) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaView::to_string(self : StatsdistgammaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_range_make(size : Int32) -> StatsdistgammaRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaRange::len(self : StatsdistgammaRange) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaRange::get(
  self : StatsdistgammaRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaRange::set(
  self : StatsdistgammaRange,
  i : Int32,
  v : Double,
) -> StatsdistgammaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaRange::sum(self : StatsdistgammaRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaRange::mean(self : StatsdistgammaRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaRange::scale(
  self : StatsdistgammaRange,
  f : Double,
) -> StatsdistgammaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaRange::add(
  self : StatsdistgammaRange,
  other : StatsdistgammaRange,
) -> StatsdistgammaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaRange::copy(
  self : StatsdistgammaRange,
) -> StatsdistgammaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaRange::fill(
  self : StatsdistgammaRange,
  v : Double,
) -> StatsdistgammaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaRange::min(self : StatsdistgammaRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaRange::max(self : StatsdistgammaRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaRange::to_string(self : StatsdistgammaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct StatsdistgammaSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn stats_dist_gamma_slice_make(size : Int32) -> StatsdistgammaSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn StatsdistgammaSlice::len(self : StatsdistgammaSlice) -> Int32 {
  self.size
}

///|
pub fn StatsdistgammaSlice::get(
  self : StatsdistgammaSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn StatsdistgammaSlice::set(
  self : StatsdistgammaSlice,
  i : Int32,
  v : Double,
) -> StatsdistgammaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaSlice::sum(self : StatsdistgammaSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn StatsdistgammaSlice::mean(self : StatsdistgammaSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn StatsdistgammaSlice::scale(
  self : StatsdistgammaSlice,
  f : Double,
) -> StatsdistgammaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaSlice::add(
  self : StatsdistgammaSlice,
  other : StatsdistgammaSlice,
) -> StatsdistgammaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn StatsdistgammaSlice::copy(
  self : StatsdistgammaSlice,
) -> StatsdistgammaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaSlice::fill(
  self : StatsdistgammaSlice,
  v : Double,
) -> StatsdistgammaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn StatsdistgammaSlice::min(self : StatsdistgammaSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn StatsdistgammaSlice::max(self : StatsdistgammaSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn StatsdistgammaSlice::to_string(self : StatsdistgammaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
