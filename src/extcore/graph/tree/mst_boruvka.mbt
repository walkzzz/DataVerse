///|
///===
/// extcore/graph_tree_mst_boruvka
pub(all) struct GraphtreemstboruvkaPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_tree_mst_boruvka_make_point(
  x : Double,
  y : Double,
) -> GraphtreemstboruvkaPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_tree_mst_boruvka_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphtreemstboruvkaPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphtreemstboruvkaPoint::x(self : GraphtreemstboruvkaPoint) -> Double {
  self.x
}

///|
pub fn GraphtreemstboruvkaPoint::y(self : GraphtreemstboruvkaPoint) -> Double {
  self.y
}

///|
pub fn GraphtreemstboruvkaPoint::z(self : GraphtreemstboruvkaPoint) -> Double {
  self.z
}

///|
pub fn GraphtreemstboruvkaPoint::label(
  self : GraphtreemstboruvkaPoint,
) -> Int32 {
  self.label
}

///|
pub fn GraphtreemstboruvkaPoint::dist(
  self : GraphtreemstboruvkaPoint,
  other : GraphtreemstboruvkaPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphtreemstboruvkaPoint::add(
  self : GraphtreemstboruvkaPoint,
  other : GraphtreemstboruvkaPoint,
) -> GraphtreemstboruvkaPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphtreemstboruvkaPoint::sub(
  self : GraphtreemstboruvkaPoint,
  other : GraphtreemstboruvkaPoint,
) -> GraphtreemstboruvkaPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphtreemstboruvkaPoint::scale(
  self : GraphtreemstboruvkaPoint,
  s : Double,
) -> GraphtreemstboruvkaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphtreemstboruvkaPoint::dot(
  self : GraphtreemstboruvkaPoint,
  other : GraphtreemstboruvkaPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphtreemstboruvkaPoint::cross(
  self : GraphtreemstboruvkaPoint,
  other : GraphtreemstboruvkaPoint,
) -> GraphtreemstboruvkaPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphtreemstboruvkaPoint::norm(
  self : GraphtreemstboruvkaPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphtreemstboruvkaPoint::normalize(
  self : GraphtreemstboruvkaPoint,
) -> GraphtreemstboruvkaPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphtreemstboruvkaPoint::negate(
  self : GraphtreemstboruvkaPoint,
) -> GraphtreemstboruvkaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphtreemstboruvkaPoint::mid(
  self : GraphtreemstboruvkaPoint,
  other : GraphtreemstboruvkaPoint,
) -> GraphtreemstboruvkaPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphtreemstboruvkaPoint::lerp(
  self : GraphtreemstboruvkaPoint,
  other : GraphtreemstboruvkaPoint,
  t : Double,
) -> GraphtreemstboruvkaPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphtreemstboruvkaPoint::to_string(
  self : GraphtreemstboruvkaPoint,
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
pub(all) struct GraphtreemstboruvkaSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_tree_mst_boruvka_make_series(
  vals : Array[Double],
  name : String,
) -> GraphtreemstboruvkaSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphtreemstboruvkaSeries::len(
  self : GraphtreemstboruvkaSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphtreemstboruvkaSeries::sum(
  self : GraphtreemstboruvkaSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphtreemstboruvkaSeries::mean(
  self : GraphtreemstboruvkaSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphtreemstboruvkaSeries::min(
  self : GraphtreemstboruvkaSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphtreemstboruvkaSeries::max(
  self : GraphtreemstboruvkaSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphtreemstboruvkaSeries::range(
  self : GraphtreemstboruvkaSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphtreemstboruvkaSeries::variance(
  self : GraphtreemstboruvkaSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphtreemstboruvkaSeries::std(
  self : GraphtreemstboruvkaSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphtreemstboruvkaSeries::median(
  self : GraphtreemstboruvkaSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphtreemstboruvkaSeries::scale(
  self : GraphtreemstboruvkaSeries,
  f : Double,
) -> GraphtreemstboruvkaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphtreemstboruvkaSeries::add(
  self : GraphtreemstboruvkaSeries,
  other : GraphtreemstboruvkaSeries,
) -> GraphtreemstboruvkaSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphtreemstboruvkaSeries::sub(
  self : GraphtreemstboruvkaSeries,
  other : GraphtreemstboruvkaSeries,
) -> GraphtreemstboruvkaSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphtreemstboruvkaSeries::normalize(
  self : GraphtreemstboruvkaSeries,
) -> GraphtreemstboruvkaSeries {
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
pub fn GraphtreemstboruvkaSeries::cumsum(
  self : GraphtreemstboruvkaSeries,
) -> GraphtreemstboruvkaSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphtreemstboruvkaSeries::to_string(
  self : GraphtreemstboruvkaSeries,
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
pub(all) struct GraphtreemstboruvkaMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_tree_mst_boruvka_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphtreemstboruvkaMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_tree_mst_boruvka_matrix_identity(
  n : Int32,
) -> GraphtreemstboruvkaMatrix {
  let m = graph_tree_mst_boruvka_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphtreemstboruvkaMatrix::get(
  self : GraphtreemstboruvkaMatrix,
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
pub fn GraphtreemstboruvkaMatrix::transpose(
  self : GraphtreemstboruvkaMatrix,
) -> GraphtreemstboruvkaMatrix {
  let result = graph_tree_mst_boruvka_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphtreemstboruvkaMatrix::add(
  self : GraphtreemstboruvkaMatrix,
  other : GraphtreemstboruvkaMatrix,
) -> GraphtreemstboruvkaMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_tree_mst_boruvka_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphtreemstboruvkaMatrix::scale(
  self : GraphtreemstboruvkaMatrix,
  s : Double,
) -> GraphtreemstboruvkaMatrix {
  let result = graph_tree_mst_boruvka_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphtreemstboruvkaMatrix::multiply(
  self : GraphtreemstboruvkaMatrix,
  other : GraphtreemstboruvkaMatrix,
) -> GraphtreemstboruvkaMatrix {
  if self.cols != other.rows {
    return graph_tree_mst_boruvka_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_tree_mst_boruvka_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphtreemstboruvkaMatrix::trace(
  self : GraphtreemstboruvkaMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphtreemstboruvkaMatrix::det(
  self : GraphtreemstboruvkaMatrix,
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
pub fn GraphtreemstboruvkaMatrix::norm(
  self : GraphtreemstboruvkaMatrix,
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
pub fn GraphtreemstboruvkaMatrix::to_string(
  self : GraphtreemstboruvkaMatrix,
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
pub(all) struct GraphtreemstboruvkaVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_tree_mst_boruvka_make_vector(
  comps : Array[Double],
) -> GraphtreemstboruvkaVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_tree_mst_boruvka_vector_zero(
  dim : Int32,
) -> GraphtreemstboruvkaVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphtreemstboruvkaVector::add(
  self : GraphtreemstboruvkaVector,
  other : GraphtreemstboruvkaVector,
) -> GraphtreemstboruvkaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphtreemstboruvkaVector::sub(
  self : GraphtreemstboruvkaVector,
  other : GraphtreemstboruvkaVector,
) -> GraphtreemstboruvkaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphtreemstboruvkaVector::scale(
  self : GraphtreemstboruvkaVector,
  s : Double,
) -> GraphtreemstboruvkaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphtreemstboruvkaVector::dot(
  self : GraphtreemstboruvkaVector,
  other : GraphtreemstboruvkaVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphtreemstboruvkaVector::norm(
  self : GraphtreemstboruvkaVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphtreemstboruvkaVector::normalize(
  self : GraphtreemstboruvkaVector,
) -> GraphtreemstboruvkaVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphtreemstboruvkaVector::dist(
  self : GraphtreemstboruvkaVector,
  other : GraphtreemstboruvkaVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphtreemstboruvkaVector::to_string(
  self : GraphtreemstboruvkaVector,
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
pub(all) struct GraphtreemstboruvkaFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_frame_make(
  size : Int32,
) -> GraphtreemstboruvkaFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaFrame::len(self : GraphtreemstboruvkaFrame) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaFrame::get(
  self : GraphtreemstboruvkaFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaFrame::set(
  self : GraphtreemstboruvkaFrame,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaFrame::sum(self : GraphtreemstboruvkaFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaFrame::mean(
  self : GraphtreemstboruvkaFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaFrame::scale(
  self : GraphtreemstboruvkaFrame,
  f : Double,
) -> GraphtreemstboruvkaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaFrame::add(
  self : GraphtreemstboruvkaFrame,
  other : GraphtreemstboruvkaFrame,
) -> GraphtreemstboruvkaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaFrame::copy(
  self : GraphtreemstboruvkaFrame,
) -> GraphtreemstboruvkaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaFrame::fill(
  self : GraphtreemstboruvkaFrame,
  v : Double,
) -> GraphtreemstboruvkaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaFrame::min(self : GraphtreemstboruvkaFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaFrame::max(self : GraphtreemstboruvkaFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaFrame::to_string(
  self : GraphtreemstboruvkaFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_table_make(
  size : Int32,
) -> GraphtreemstboruvkaTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaTable::len(self : GraphtreemstboruvkaTable) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaTable::get(
  self : GraphtreemstboruvkaTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaTable::set(
  self : GraphtreemstboruvkaTable,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaTable::sum(self : GraphtreemstboruvkaTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaTable::mean(
  self : GraphtreemstboruvkaTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaTable::scale(
  self : GraphtreemstboruvkaTable,
  f : Double,
) -> GraphtreemstboruvkaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaTable::add(
  self : GraphtreemstboruvkaTable,
  other : GraphtreemstboruvkaTable,
) -> GraphtreemstboruvkaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaTable::copy(
  self : GraphtreemstboruvkaTable,
) -> GraphtreemstboruvkaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaTable::fill(
  self : GraphtreemstboruvkaTable,
  v : Double,
) -> GraphtreemstboruvkaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaTable::min(self : GraphtreemstboruvkaTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaTable::max(self : GraphtreemstboruvkaTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaTable::to_string(
  self : GraphtreemstboruvkaTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_graphn_make(
  size : Int32,
) -> GraphtreemstboruvkaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaGraphN::len(
  self : GraphtreemstboruvkaGraphN,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaGraphN::get(
  self : GraphtreemstboruvkaGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaGraphN::set(
  self : GraphtreemstboruvkaGraphN,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaGraphN::sum(
  self : GraphtreemstboruvkaGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaGraphN::mean(
  self : GraphtreemstboruvkaGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaGraphN::scale(
  self : GraphtreemstboruvkaGraphN,
  f : Double,
) -> GraphtreemstboruvkaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaGraphN::add(
  self : GraphtreemstboruvkaGraphN,
  other : GraphtreemstboruvkaGraphN,
) -> GraphtreemstboruvkaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaGraphN::copy(
  self : GraphtreemstboruvkaGraphN,
) -> GraphtreemstboruvkaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaGraphN::fill(
  self : GraphtreemstboruvkaGraphN,
  v : Double,
) -> GraphtreemstboruvkaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaGraphN::min(
  self : GraphtreemstboruvkaGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaGraphN::max(
  self : GraphtreemstboruvkaGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaGraphN::to_string(
  self : GraphtreemstboruvkaGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_node_make(
  size : Int32,
) -> GraphtreemstboruvkaNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaNode::len(self : GraphtreemstboruvkaNode) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaNode::get(
  self : GraphtreemstboruvkaNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaNode::set(
  self : GraphtreemstboruvkaNode,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaNode::sum(self : GraphtreemstboruvkaNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaNode::mean(self : GraphtreemstboruvkaNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaNode::scale(
  self : GraphtreemstboruvkaNode,
  f : Double,
) -> GraphtreemstboruvkaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaNode::add(
  self : GraphtreemstboruvkaNode,
  other : GraphtreemstboruvkaNode,
) -> GraphtreemstboruvkaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaNode::copy(
  self : GraphtreemstboruvkaNode,
) -> GraphtreemstboruvkaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaNode::fill(
  self : GraphtreemstboruvkaNode,
  v : Double,
) -> GraphtreemstboruvkaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaNode::min(self : GraphtreemstboruvkaNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaNode::max(self : GraphtreemstboruvkaNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaNode::to_string(
  self : GraphtreemstboruvkaNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_edge_make(
  size : Int32,
) -> GraphtreemstboruvkaEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaEdge::len(self : GraphtreemstboruvkaEdge) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaEdge::get(
  self : GraphtreemstboruvkaEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaEdge::set(
  self : GraphtreemstboruvkaEdge,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaEdge::sum(self : GraphtreemstboruvkaEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaEdge::mean(self : GraphtreemstboruvkaEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaEdge::scale(
  self : GraphtreemstboruvkaEdge,
  f : Double,
) -> GraphtreemstboruvkaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaEdge::add(
  self : GraphtreemstboruvkaEdge,
  other : GraphtreemstboruvkaEdge,
) -> GraphtreemstboruvkaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaEdge::copy(
  self : GraphtreemstboruvkaEdge,
) -> GraphtreemstboruvkaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaEdge::fill(
  self : GraphtreemstboruvkaEdge,
  v : Double,
) -> GraphtreemstboruvkaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaEdge::min(self : GraphtreemstboruvkaEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaEdge::max(self : GraphtreemstboruvkaEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaEdge::to_string(
  self : GraphtreemstboruvkaEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_path_make(
  size : Int32,
) -> GraphtreemstboruvkaPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaPath::len(self : GraphtreemstboruvkaPath) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaPath::get(
  self : GraphtreemstboruvkaPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaPath::set(
  self : GraphtreemstboruvkaPath,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaPath::sum(self : GraphtreemstboruvkaPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaPath::mean(self : GraphtreemstboruvkaPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaPath::scale(
  self : GraphtreemstboruvkaPath,
  f : Double,
) -> GraphtreemstboruvkaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaPath::add(
  self : GraphtreemstboruvkaPath,
  other : GraphtreemstboruvkaPath,
) -> GraphtreemstboruvkaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaPath::copy(
  self : GraphtreemstboruvkaPath,
) -> GraphtreemstboruvkaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaPath::fill(
  self : GraphtreemstboruvkaPath,
  v : Double,
) -> GraphtreemstboruvkaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaPath::min(self : GraphtreemstboruvkaPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaPath::max(self : GraphtreemstboruvkaPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaPath::to_string(
  self : GraphtreemstboruvkaPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_cluster_make(
  size : Int32,
) -> GraphtreemstboruvkaCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaCluster::len(
  self : GraphtreemstboruvkaCluster,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaCluster::get(
  self : GraphtreemstboruvkaCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaCluster::set(
  self : GraphtreemstboruvkaCluster,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaCluster::sum(
  self : GraphtreemstboruvkaCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaCluster::mean(
  self : GraphtreemstboruvkaCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaCluster::scale(
  self : GraphtreemstboruvkaCluster,
  f : Double,
) -> GraphtreemstboruvkaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaCluster::add(
  self : GraphtreemstboruvkaCluster,
  other : GraphtreemstboruvkaCluster,
) -> GraphtreemstboruvkaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaCluster::copy(
  self : GraphtreemstboruvkaCluster,
) -> GraphtreemstboruvkaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaCluster::fill(
  self : GraphtreemstboruvkaCluster,
  v : Double,
) -> GraphtreemstboruvkaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaCluster::min(
  self : GraphtreemstboruvkaCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaCluster::max(
  self : GraphtreemstboruvkaCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaCluster::to_string(
  self : GraphtreemstboruvkaCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_model_make(
  size : Int32,
) -> GraphtreemstboruvkaModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaModel::len(self : GraphtreemstboruvkaModel) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaModel::get(
  self : GraphtreemstboruvkaModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaModel::set(
  self : GraphtreemstboruvkaModel,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaModel::sum(self : GraphtreemstboruvkaModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaModel::mean(
  self : GraphtreemstboruvkaModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaModel::scale(
  self : GraphtreemstboruvkaModel,
  f : Double,
) -> GraphtreemstboruvkaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaModel::add(
  self : GraphtreemstboruvkaModel,
  other : GraphtreemstboruvkaModel,
) -> GraphtreemstboruvkaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaModel::copy(
  self : GraphtreemstboruvkaModel,
) -> GraphtreemstboruvkaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaModel::fill(
  self : GraphtreemstboruvkaModel,
  v : Double,
) -> GraphtreemstboruvkaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaModel::min(self : GraphtreemstboruvkaModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaModel::max(self : GraphtreemstboruvkaModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaModel::to_string(
  self : GraphtreemstboruvkaModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_layer_make(
  size : Int32,
) -> GraphtreemstboruvkaLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaLayer::len(self : GraphtreemstboruvkaLayer) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaLayer::get(
  self : GraphtreemstboruvkaLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaLayer::set(
  self : GraphtreemstboruvkaLayer,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaLayer::sum(self : GraphtreemstboruvkaLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaLayer::mean(
  self : GraphtreemstboruvkaLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaLayer::scale(
  self : GraphtreemstboruvkaLayer,
  f : Double,
) -> GraphtreemstboruvkaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaLayer::add(
  self : GraphtreemstboruvkaLayer,
  other : GraphtreemstboruvkaLayer,
) -> GraphtreemstboruvkaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaLayer::copy(
  self : GraphtreemstboruvkaLayer,
) -> GraphtreemstboruvkaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaLayer::fill(
  self : GraphtreemstboruvkaLayer,
  v : Double,
) -> GraphtreemstboruvkaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaLayer::min(self : GraphtreemstboruvkaLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaLayer::max(self : GraphtreemstboruvkaLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaLayer::to_string(
  self : GraphtreemstboruvkaLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_buffer_make(
  size : Int32,
) -> GraphtreemstboruvkaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaBuffer::len(
  self : GraphtreemstboruvkaBuffer,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaBuffer::get(
  self : GraphtreemstboruvkaBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaBuffer::set(
  self : GraphtreemstboruvkaBuffer,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaBuffer::sum(
  self : GraphtreemstboruvkaBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaBuffer::mean(
  self : GraphtreemstboruvkaBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaBuffer::scale(
  self : GraphtreemstboruvkaBuffer,
  f : Double,
) -> GraphtreemstboruvkaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaBuffer::add(
  self : GraphtreemstboruvkaBuffer,
  other : GraphtreemstboruvkaBuffer,
) -> GraphtreemstboruvkaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaBuffer::copy(
  self : GraphtreemstboruvkaBuffer,
) -> GraphtreemstboruvkaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaBuffer::fill(
  self : GraphtreemstboruvkaBuffer,
  v : Double,
) -> GraphtreemstboruvkaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaBuffer::min(
  self : GraphtreemstboruvkaBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaBuffer::max(
  self : GraphtreemstboruvkaBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaBuffer::to_string(
  self : GraphtreemstboruvkaBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_cursor_make(
  size : Int32,
) -> GraphtreemstboruvkaCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaCursor::len(
  self : GraphtreemstboruvkaCursor,
) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaCursor::get(
  self : GraphtreemstboruvkaCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaCursor::set(
  self : GraphtreemstboruvkaCursor,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaCursor::sum(
  self : GraphtreemstboruvkaCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaCursor::mean(
  self : GraphtreemstboruvkaCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaCursor::scale(
  self : GraphtreemstboruvkaCursor,
  f : Double,
) -> GraphtreemstboruvkaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaCursor::add(
  self : GraphtreemstboruvkaCursor,
  other : GraphtreemstboruvkaCursor,
) -> GraphtreemstboruvkaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaCursor::copy(
  self : GraphtreemstboruvkaCursor,
) -> GraphtreemstboruvkaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaCursor::fill(
  self : GraphtreemstboruvkaCursor,
  v : Double,
) -> GraphtreemstboruvkaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaCursor::min(
  self : GraphtreemstboruvkaCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaCursor::max(
  self : GraphtreemstboruvkaCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaCursor::to_string(
  self : GraphtreemstboruvkaCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_view_make(
  size : Int32,
) -> GraphtreemstboruvkaView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaView::len(self : GraphtreemstboruvkaView) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaView::get(
  self : GraphtreemstboruvkaView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaView::set(
  self : GraphtreemstboruvkaView,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaView::sum(self : GraphtreemstboruvkaView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaView::mean(self : GraphtreemstboruvkaView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaView::scale(
  self : GraphtreemstboruvkaView,
  f : Double,
) -> GraphtreemstboruvkaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaView::add(
  self : GraphtreemstboruvkaView,
  other : GraphtreemstboruvkaView,
) -> GraphtreemstboruvkaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaView::copy(
  self : GraphtreemstboruvkaView,
) -> GraphtreemstboruvkaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaView::fill(
  self : GraphtreemstboruvkaView,
  v : Double,
) -> GraphtreemstboruvkaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaView::min(self : GraphtreemstboruvkaView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaView::max(self : GraphtreemstboruvkaView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaView::to_string(
  self : GraphtreemstboruvkaView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_range_make(
  size : Int32,
) -> GraphtreemstboruvkaRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaRange::len(self : GraphtreemstboruvkaRange) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaRange::get(
  self : GraphtreemstboruvkaRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaRange::set(
  self : GraphtreemstboruvkaRange,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaRange::sum(self : GraphtreemstboruvkaRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaRange::mean(
  self : GraphtreemstboruvkaRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaRange::scale(
  self : GraphtreemstboruvkaRange,
  f : Double,
) -> GraphtreemstboruvkaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaRange::add(
  self : GraphtreemstboruvkaRange,
  other : GraphtreemstboruvkaRange,
) -> GraphtreemstboruvkaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaRange::copy(
  self : GraphtreemstboruvkaRange,
) -> GraphtreemstboruvkaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaRange::fill(
  self : GraphtreemstboruvkaRange,
  v : Double,
) -> GraphtreemstboruvkaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaRange::min(self : GraphtreemstboruvkaRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaRange::max(self : GraphtreemstboruvkaRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaRange::to_string(
  self : GraphtreemstboruvkaRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreemstboruvkaSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_mst_boruvka_slice_make(
  size : Int32,
) -> GraphtreemstboruvkaSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreemstboruvkaSlice::len(self : GraphtreemstboruvkaSlice) -> Int32 {
  self.size
}

///|
pub fn GraphtreemstboruvkaSlice::get(
  self : GraphtreemstboruvkaSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreemstboruvkaSlice::set(
  self : GraphtreemstboruvkaSlice,
  i : Int32,
  v : Double,
) -> GraphtreemstboruvkaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaSlice::sum(self : GraphtreemstboruvkaSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreemstboruvkaSlice::mean(
  self : GraphtreemstboruvkaSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreemstboruvkaSlice::scale(
  self : GraphtreemstboruvkaSlice,
  f : Double,
) -> GraphtreemstboruvkaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaSlice::add(
  self : GraphtreemstboruvkaSlice,
  other : GraphtreemstboruvkaSlice,
) -> GraphtreemstboruvkaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaSlice::copy(
  self : GraphtreemstboruvkaSlice,
) -> GraphtreemstboruvkaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaSlice::fill(
  self : GraphtreemstboruvkaSlice,
  v : Double,
) -> GraphtreemstboruvkaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreemstboruvkaSlice::min(self : GraphtreemstboruvkaSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreemstboruvkaSlice::max(self : GraphtreemstboruvkaSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreemstboruvkaSlice::to_string(
  self : GraphtreemstboruvkaSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
