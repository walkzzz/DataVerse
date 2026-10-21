///|
///===
/// extcore/graph_tree_isomorphism
pub(all) struct GraphtreeisomorphismPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_tree_isomorphism_make_point(
  x : Double,
  y : Double,
) -> GraphtreeisomorphismPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_tree_isomorphism_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphtreeisomorphismPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphtreeisomorphismPoint::x(self : GraphtreeisomorphismPoint) -> Double {
  self.x
}

///|
pub fn GraphtreeisomorphismPoint::y(self : GraphtreeisomorphismPoint) -> Double {
  self.y
}

///|
pub fn GraphtreeisomorphismPoint::z(self : GraphtreeisomorphismPoint) -> Double {
  self.z
}

///|
pub fn GraphtreeisomorphismPoint::label(
  self : GraphtreeisomorphismPoint,
) -> Int32 {
  self.label
}

///|
pub fn GraphtreeisomorphismPoint::dist(
  self : GraphtreeisomorphismPoint,
  other : GraphtreeisomorphismPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphtreeisomorphismPoint::add(
  self : GraphtreeisomorphismPoint,
  other : GraphtreeisomorphismPoint,
) -> GraphtreeisomorphismPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphtreeisomorphismPoint::sub(
  self : GraphtreeisomorphismPoint,
  other : GraphtreeisomorphismPoint,
) -> GraphtreeisomorphismPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphtreeisomorphismPoint::scale(
  self : GraphtreeisomorphismPoint,
  s : Double,
) -> GraphtreeisomorphismPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphtreeisomorphismPoint::dot(
  self : GraphtreeisomorphismPoint,
  other : GraphtreeisomorphismPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphtreeisomorphismPoint::cross(
  self : GraphtreeisomorphismPoint,
  other : GraphtreeisomorphismPoint,
) -> GraphtreeisomorphismPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphtreeisomorphismPoint::norm(
  self : GraphtreeisomorphismPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphtreeisomorphismPoint::normalize(
  self : GraphtreeisomorphismPoint,
) -> GraphtreeisomorphismPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphtreeisomorphismPoint::negate(
  self : GraphtreeisomorphismPoint,
) -> GraphtreeisomorphismPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphtreeisomorphismPoint::mid(
  self : GraphtreeisomorphismPoint,
  other : GraphtreeisomorphismPoint,
) -> GraphtreeisomorphismPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphtreeisomorphismPoint::lerp(
  self : GraphtreeisomorphismPoint,
  other : GraphtreeisomorphismPoint,
  t : Double,
) -> GraphtreeisomorphismPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphtreeisomorphismPoint::to_string(
  self : GraphtreeisomorphismPoint,
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
pub(all) struct GraphtreeisomorphismSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_tree_isomorphism_make_series(
  vals : Array[Double],
  name : String,
) -> GraphtreeisomorphismSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphtreeisomorphismSeries::len(
  self : GraphtreeisomorphismSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphtreeisomorphismSeries::sum(
  self : GraphtreeisomorphismSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphtreeisomorphismSeries::mean(
  self : GraphtreeisomorphismSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphtreeisomorphismSeries::min(
  self : GraphtreeisomorphismSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphtreeisomorphismSeries::max(
  self : GraphtreeisomorphismSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphtreeisomorphismSeries::range(
  self : GraphtreeisomorphismSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphtreeisomorphismSeries::variance(
  self : GraphtreeisomorphismSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphtreeisomorphismSeries::std(
  self : GraphtreeisomorphismSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphtreeisomorphismSeries::median(
  self : GraphtreeisomorphismSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphtreeisomorphismSeries::scale(
  self : GraphtreeisomorphismSeries,
  f : Double,
) -> GraphtreeisomorphismSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphtreeisomorphismSeries::add(
  self : GraphtreeisomorphismSeries,
  other : GraphtreeisomorphismSeries,
) -> GraphtreeisomorphismSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphtreeisomorphismSeries::sub(
  self : GraphtreeisomorphismSeries,
  other : GraphtreeisomorphismSeries,
) -> GraphtreeisomorphismSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphtreeisomorphismSeries::normalize(
  self : GraphtreeisomorphismSeries,
) -> GraphtreeisomorphismSeries {
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
pub fn GraphtreeisomorphismSeries::cumsum(
  self : GraphtreeisomorphismSeries,
) -> GraphtreeisomorphismSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphtreeisomorphismSeries::to_string(
  self : GraphtreeisomorphismSeries,
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
pub(all) struct GraphtreeisomorphismMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_tree_isomorphism_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphtreeisomorphismMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_tree_isomorphism_matrix_identity(
  n : Int32,
) -> GraphtreeisomorphismMatrix {
  let m = graph_tree_isomorphism_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphtreeisomorphismMatrix::get(
  self : GraphtreeisomorphismMatrix,
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
pub fn GraphtreeisomorphismMatrix::transpose(
  self : GraphtreeisomorphismMatrix,
) -> GraphtreeisomorphismMatrix {
  let result = graph_tree_isomorphism_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphtreeisomorphismMatrix::add(
  self : GraphtreeisomorphismMatrix,
  other : GraphtreeisomorphismMatrix,
) -> GraphtreeisomorphismMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_tree_isomorphism_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphtreeisomorphismMatrix::scale(
  self : GraphtreeisomorphismMatrix,
  s : Double,
) -> GraphtreeisomorphismMatrix {
  let result = graph_tree_isomorphism_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphtreeisomorphismMatrix::multiply(
  self : GraphtreeisomorphismMatrix,
  other : GraphtreeisomorphismMatrix,
) -> GraphtreeisomorphismMatrix {
  if self.cols != other.rows {
    return graph_tree_isomorphism_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_tree_isomorphism_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphtreeisomorphismMatrix::trace(
  self : GraphtreeisomorphismMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphtreeisomorphismMatrix::det(
  self : GraphtreeisomorphismMatrix,
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
pub fn GraphtreeisomorphismMatrix::norm(
  self : GraphtreeisomorphismMatrix,
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
pub fn GraphtreeisomorphismMatrix::to_string(
  self : GraphtreeisomorphismMatrix,
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
pub(all) struct GraphtreeisomorphismVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_tree_isomorphism_make_vector(
  comps : Array[Double],
) -> GraphtreeisomorphismVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_tree_isomorphism_vector_zero(
  dim : Int32,
) -> GraphtreeisomorphismVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphtreeisomorphismVector::add(
  self : GraphtreeisomorphismVector,
  other : GraphtreeisomorphismVector,
) -> GraphtreeisomorphismVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphtreeisomorphismVector::sub(
  self : GraphtreeisomorphismVector,
  other : GraphtreeisomorphismVector,
) -> GraphtreeisomorphismVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphtreeisomorphismVector::scale(
  self : GraphtreeisomorphismVector,
  s : Double,
) -> GraphtreeisomorphismVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphtreeisomorphismVector::dot(
  self : GraphtreeisomorphismVector,
  other : GraphtreeisomorphismVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphtreeisomorphismVector::norm(
  self : GraphtreeisomorphismVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphtreeisomorphismVector::normalize(
  self : GraphtreeisomorphismVector,
) -> GraphtreeisomorphismVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphtreeisomorphismVector::dist(
  self : GraphtreeisomorphismVector,
  other : GraphtreeisomorphismVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphtreeisomorphismVector::to_string(
  self : GraphtreeisomorphismVector,
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
pub(all) struct GraphtreeisomorphismFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_frame_make(
  size : Int32,
) -> GraphtreeisomorphismFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismFrame::len(
  self : GraphtreeisomorphismFrame,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismFrame::get(
  self : GraphtreeisomorphismFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismFrame::set(
  self : GraphtreeisomorphismFrame,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismFrame::sum(
  self : GraphtreeisomorphismFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismFrame::mean(
  self : GraphtreeisomorphismFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismFrame::scale(
  self : GraphtreeisomorphismFrame,
  f : Double,
) -> GraphtreeisomorphismFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismFrame::add(
  self : GraphtreeisomorphismFrame,
  other : GraphtreeisomorphismFrame,
) -> GraphtreeisomorphismFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismFrame::copy(
  self : GraphtreeisomorphismFrame,
) -> GraphtreeisomorphismFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismFrame::fill(
  self : GraphtreeisomorphismFrame,
  v : Double,
) -> GraphtreeisomorphismFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismFrame::min(
  self : GraphtreeisomorphismFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismFrame::max(
  self : GraphtreeisomorphismFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismFrame::to_string(
  self : GraphtreeisomorphismFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_table_make(
  size : Int32,
) -> GraphtreeisomorphismTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismTable::len(
  self : GraphtreeisomorphismTable,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismTable::get(
  self : GraphtreeisomorphismTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismTable::set(
  self : GraphtreeisomorphismTable,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismTable::sum(
  self : GraphtreeisomorphismTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismTable::mean(
  self : GraphtreeisomorphismTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismTable::scale(
  self : GraphtreeisomorphismTable,
  f : Double,
) -> GraphtreeisomorphismTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismTable::add(
  self : GraphtreeisomorphismTable,
  other : GraphtreeisomorphismTable,
) -> GraphtreeisomorphismTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismTable::copy(
  self : GraphtreeisomorphismTable,
) -> GraphtreeisomorphismTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismTable::fill(
  self : GraphtreeisomorphismTable,
  v : Double,
) -> GraphtreeisomorphismTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismTable::min(
  self : GraphtreeisomorphismTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismTable::max(
  self : GraphtreeisomorphismTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismTable::to_string(
  self : GraphtreeisomorphismTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_graphn_make(
  size : Int32,
) -> GraphtreeisomorphismGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismGraphN::len(
  self : GraphtreeisomorphismGraphN,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismGraphN::get(
  self : GraphtreeisomorphismGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismGraphN::set(
  self : GraphtreeisomorphismGraphN,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismGraphN::sum(
  self : GraphtreeisomorphismGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismGraphN::mean(
  self : GraphtreeisomorphismGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismGraphN::scale(
  self : GraphtreeisomorphismGraphN,
  f : Double,
) -> GraphtreeisomorphismGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismGraphN::add(
  self : GraphtreeisomorphismGraphN,
  other : GraphtreeisomorphismGraphN,
) -> GraphtreeisomorphismGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismGraphN::copy(
  self : GraphtreeisomorphismGraphN,
) -> GraphtreeisomorphismGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismGraphN::fill(
  self : GraphtreeisomorphismGraphN,
  v : Double,
) -> GraphtreeisomorphismGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismGraphN::min(
  self : GraphtreeisomorphismGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismGraphN::max(
  self : GraphtreeisomorphismGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismGraphN::to_string(
  self : GraphtreeisomorphismGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_node_make(
  size : Int32,
) -> GraphtreeisomorphismNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismNode::len(self : GraphtreeisomorphismNode) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismNode::get(
  self : GraphtreeisomorphismNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismNode::set(
  self : GraphtreeisomorphismNode,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismNode::sum(self : GraphtreeisomorphismNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismNode::mean(
  self : GraphtreeisomorphismNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismNode::scale(
  self : GraphtreeisomorphismNode,
  f : Double,
) -> GraphtreeisomorphismNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismNode::add(
  self : GraphtreeisomorphismNode,
  other : GraphtreeisomorphismNode,
) -> GraphtreeisomorphismNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismNode::copy(
  self : GraphtreeisomorphismNode,
) -> GraphtreeisomorphismNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismNode::fill(
  self : GraphtreeisomorphismNode,
  v : Double,
) -> GraphtreeisomorphismNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismNode::min(self : GraphtreeisomorphismNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismNode::max(self : GraphtreeisomorphismNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismNode::to_string(
  self : GraphtreeisomorphismNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_edge_make(
  size : Int32,
) -> GraphtreeisomorphismEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismEdge::len(self : GraphtreeisomorphismEdge) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismEdge::get(
  self : GraphtreeisomorphismEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismEdge::set(
  self : GraphtreeisomorphismEdge,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismEdge::sum(self : GraphtreeisomorphismEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismEdge::mean(
  self : GraphtreeisomorphismEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismEdge::scale(
  self : GraphtreeisomorphismEdge,
  f : Double,
) -> GraphtreeisomorphismEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismEdge::add(
  self : GraphtreeisomorphismEdge,
  other : GraphtreeisomorphismEdge,
) -> GraphtreeisomorphismEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismEdge::copy(
  self : GraphtreeisomorphismEdge,
) -> GraphtreeisomorphismEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismEdge::fill(
  self : GraphtreeisomorphismEdge,
  v : Double,
) -> GraphtreeisomorphismEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismEdge::min(self : GraphtreeisomorphismEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismEdge::max(self : GraphtreeisomorphismEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismEdge::to_string(
  self : GraphtreeisomorphismEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_path_make(
  size : Int32,
) -> GraphtreeisomorphismPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismPath::len(self : GraphtreeisomorphismPath) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismPath::get(
  self : GraphtreeisomorphismPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismPath::set(
  self : GraphtreeisomorphismPath,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismPath::sum(self : GraphtreeisomorphismPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismPath::mean(
  self : GraphtreeisomorphismPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismPath::scale(
  self : GraphtreeisomorphismPath,
  f : Double,
) -> GraphtreeisomorphismPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismPath::add(
  self : GraphtreeisomorphismPath,
  other : GraphtreeisomorphismPath,
) -> GraphtreeisomorphismPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismPath::copy(
  self : GraphtreeisomorphismPath,
) -> GraphtreeisomorphismPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismPath::fill(
  self : GraphtreeisomorphismPath,
  v : Double,
) -> GraphtreeisomorphismPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismPath::min(self : GraphtreeisomorphismPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismPath::max(self : GraphtreeisomorphismPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismPath::to_string(
  self : GraphtreeisomorphismPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_cluster_make(
  size : Int32,
) -> GraphtreeisomorphismCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismCluster::len(
  self : GraphtreeisomorphismCluster,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismCluster::get(
  self : GraphtreeisomorphismCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismCluster::set(
  self : GraphtreeisomorphismCluster,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismCluster::sum(
  self : GraphtreeisomorphismCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismCluster::mean(
  self : GraphtreeisomorphismCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismCluster::scale(
  self : GraphtreeisomorphismCluster,
  f : Double,
) -> GraphtreeisomorphismCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismCluster::add(
  self : GraphtreeisomorphismCluster,
  other : GraphtreeisomorphismCluster,
) -> GraphtreeisomorphismCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismCluster::copy(
  self : GraphtreeisomorphismCluster,
) -> GraphtreeisomorphismCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismCluster::fill(
  self : GraphtreeisomorphismCluster,
  v : Double,
) -> GraphtreeisomorphismCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismCluster::min(
  self : GraphtreeisomorphismCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismCluster::max(
  self : GraphtreeisomorphismCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismCluster::to_string(
  self : GraphtreeisomorphismCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_model_make(
  size : Int32,
) -> GraphtreeisomorphismModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismModel::len(
  self : GraphtreeisomorphismModel,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismModel::get(
  self : GraphtreeisomorphismModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismModel::set(
  self : GraphtreeisomorphismModel,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismModel::sum(
  self : GraphtreeisomorphismModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismModel::mean(
  self : GraphtreeisomorphismModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismModel::scale(
  self : GraphtreeisomorphismModel,
  f : Double,
) -> GraphtreeisomorphismModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismModel::add(
  self : GraphtreeisomorphismModel,
  other : GraphtreeisomorphismModel,
) -> GraphtreeisomorphismModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismModel::copy(
  self : GraphtreeisomorphismModel,
) -> GraphtreeisomorphismModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismModel::fill(
  self : GraphtreeisomorphismModel,
  v : Double,
) -> GraphtreeisomorphismModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismModel::min(
  self : GraphtreeisomorphismModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismModel::max(
  self : GraphtreeisomorphismModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismModel::to_string(
  self : GraphtreeisomorphismModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_layer_make(
  size : Int32,
) -> GraphtreeisomorphismLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismLayer::len(
  self : GraphtreeisomorphismLayer,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismLayer::get(
  self : GraphtreeisomorphismLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismLayer::set(
  self : GraphtreeisomorphismLayer,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismLayer::sum(
  self : GraphtreeisomorphismLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismLayer::mean(
  self : GraphtreeisomorphismLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismLayer::scale(
  self : GraphtreeisomorphismLayer,
  f : Double,
) -> GraphtreeisomorphismLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismLayer::add(
  self : GraphtreeisomorphismLayer,
  other : GraphtreeisomorphismLayer,
) -> GraphtreeisomorphismLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismLayer::copy(
  self : GraphtreeisomorphismLayer,
) -> GraphtreeisomorphismLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismLayer::fill(
  self : GraphtreeisomorphismLayer,
  v : Double,
) -> GraphtreeisomorphismLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismLayer::min(
  self : GraphtreeisomorphismLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismLayer::max(
  self : GraphtreeisomorphismLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismLayer::to_string(
  self : GraphtreeisomorphismLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_buffer_make(
  size : Int32,
) -> GraphtreeisomorphismBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismBuffer::len(
  self : GraphtreeisomorphismBuffer,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismBuffer::get(
  self : GraphtreeisomorphismBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismBuffer::set(
  self : GraphtreeisomorphismBuffer,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismBuffer::sum(
  self : GraphtreeisomorphismBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismBuffer::mean(
  self : GraphtreeisomorphismBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismBuffer::scale(
  self : GraphtreeisomorphismBuffer,
  f : Double,
) -> GraphtreeisomorphismBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismBuffer::add(
  self : GraphtreeisomorphismBuffer,
  other : GraphtreeisomorphismBuffer,
) -> GraphtreeisomorphismBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismBuffer::copy(
  self : GraphtreeisomorphismBuffer,
) -> GraphtreeisomorphismBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismBuffer::fill(
  self : GraphtreeisomorphismBuffer,
  v : Double,
) -> GraphtreeisomorphismBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismBuffer::min(
  self : GraphtreeisomorphismBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismBuffer::max(
  self : GraphtreeisomorphismBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismBuffer::to_string(
  self : GraphtreeisomorphismBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_cursor_make(
  size : Int32,
) -> GraphtreeisomorphismCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismCursor::len(
  self : GraphtreeisomorphismCursor,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismCursor::get(
  self : GraphtreeisomorphismCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismCursor::set(
  self : GraphtreeisomorphismCursor,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismCursor::sum(
  self : GraphtreeisomorphismCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismCursor::mean(
  self : GraphtreeisomorphismCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismCursor::scale(
  self : GraphtreeisomorphismCursor,
  f : Double,
) -> GraphtreeisomorphismCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismCursor::add(
  self : GraphtreeisomorphismCursor,
  other : GraphtreeisomorphismCursor,
) -> GraphtreeisomorphismCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismCursor::copy(
  self : GraphtreeisomorphismCursor,
) -> GraphtreeisomorphismCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismCursor::fill(
  self : GraphtreeisomorphismCursor,
  v : Double,
) -> GraphtreeisomorphismCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismCursor::min(
  self : GraphtreeisomorphismCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismCursor::max(
  self : GraphtreeisomorphismCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismCursor::to_string(
  self : GraphtreeisomorphismCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_view_make(
  size : Int32,
) -> GraphtreeisomorphismView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismView::len(self : GraphtreeisomorphismView) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismView::get(
  self : GraphtreeisomorphismView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismView::set(
  self : GraphtreeisomorphismView,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismView::sum(self : GraphtreeisomorphismView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismView::mean(
  self : GraphtreeisomorphismView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismView::scale(
  self : GraphtreeisomorphismView,
  f : Double,
) -> GraphtreeisomorphismView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismView::add(
  self : GraphtreeisomorphismView,
  other : GraphtreeisomorphismView,
) -> GraphtreeisomorphismView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismView::copy(
  self : GraphtreeisomorphismView,
) -> GraphtreeisomorphismView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismView::fill(
  self : GraphtreeisomorphismView,
  v : Double,
) -> GraphtreeisomorphismView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismView::min(self : GraphtreeisomorphismView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismView::max(self : GraphtreeisomorphismView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismView::to_string(
  self : GraphtreeisomorphismView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_range_make(
  size : Int32,
) -> GraphtreeisomorphismRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismRange::len(
  self : GraphtreeisomorphismRange,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismRange::get(
  self : GraphtreeisomorphismRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismRange::set(
  self : GraphtreeisomorphismRange,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismRange::sum(
  self : GraphtreeisomorphismRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismRange::mean(
  self : GraphtreeisomorphismRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismRange::scale(
  self : GraphtreeisomorphismRange,
  f : Double,
) -> GraphtreeisomorphismRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismRange::add(
  self : GraphtreeisomorphismRange,
  other : GraphtreeisomorphismRange,
) -> GraphtreeisomorphismRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismRange::copy(
  self : GraphtreeisomorphismRange,
) -> GraphtreeisomorphismRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismRange::fill(
  self : GraphtreeisomorphismRange,
  v : Double,
) -> GraphtreeisomorphismRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismRange::min(
  self : GraphtreeisomorphismRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismRange::max(
  self : GraphtreeisomorphismRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismRange::to_string(
  self : GraphtreeisomorphismRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreeisomorphismSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_isomorphism_slice_make(
  size : Int32,
) -> GraphtreeisomorphismSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreeisomorphismSlice::len(
  self : GraphtreeisomorphismSlice,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreeisomorphismSlice::get(
  self : GraphtreeisomorphismSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreeisomorphismSlice::set(
  self : GraphtreeisomorphismSlice,
  i : Int32,
  v : Double,
) -> GraphtreeisomorphismSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismSlice::sum(
  self : GraphtreeisomorphismSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreeisomorphismSlice::mean(
  self : GraphtreeisomorphismSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreeisomorphismSlice::scale(
  self : GraphtreeisomorphismSlice,
  f : Double,
) -> GraphtreeisomorphismSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismSlice::add(
  self : GraphtreeisomorphismSlice,
  other : GraphtreeisomorphismSlice,
) -> GraphtreeisomorphismSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismSlice::copy(
  self : GraphtreeisomorphismSlice,
) -> GraphtreeisomorphismSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismSlice::fill(
  self : GraphtreeisomorphismSlice,
  v : Double,
) -> GraphtreeisomorphismSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreeisomorphismSlice::min(
  self : GraphtreeisomorphismSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreeisomorphismSlice::max(
  self : GraphtreeisomorphismSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreeisomorphismSlice::to_string(
  self : GraphtreeisomorphismSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
