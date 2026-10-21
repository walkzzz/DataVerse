///|
///===
/// extcore/graph_flow_bipartite
pub(all) struct GraphflowbipartitePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_flow_bipartite_make_point(
  x : Double,
  y : Double,
) -> GraphflowbipartitePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_flow_bipartite_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphflowbipartitePoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphflowbipartitePoint::x(self : GraphflowbipartitePoint) -> Double {
  self.x
}

///|
pub fn GraphflowbipartitePoint::y(self : GraphflowbipartitePoint) -> Double {
  self.y
}

///|
pub fn GraphflowbipartitePoint::z(self : GraphflowbipartitePoint) -> Double {
  self.z
}

///|
pub fn GraphflowbipartitePoint::label(self : GraphflowbipartitePoint) -> Int32 {
  self.label
}

///|
pub fn GraphflowbipartitePoint::dist(
  self : GraphflowbipartitePoint,
  other : GraphflowbipartitePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphflowbipartitePoint::add(
  self : GraphflowbipartitePoint,
  other : GraphflowbipartitePoint,
) -> GraphflowbipartitePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphflowbipartitePoint::sub(
  self : GraphflowbipartitePoint,
  other : GraphflowbipartitePoint,
) -> GraphflowbipartitePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphflowbipartitePoint::scale(
  self : GraphflowbipartitePoint,
  s : Double,
) -> GraphflowbipartitePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphflowbipartitePoint::dot(
  self : GraphflowbipartitePoint,
  other : GraphflowbipartitePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphflowbipartitePoint::cross(
  self : GraphflowbipartitePoint,
  other : GraphflowbipartitePoint,
) -> GraphflowbipartitePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphflowbipartitePoint::norm(self : GraphflowbipartitePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphflowbipartitePoint::normalize(
  self : GraphflowbipartitePoint,
) -> GraphflowbipartitePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphflowbipartitePoint::negate(
  self : GraphflowbipartitePoint,
) -> GraphflowbipartitePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphflowbipartitePoint::mid(
  self : GraphflowbipartitePoint,
  other : GraphflowbipartitePoint,
) -> GraphflowbipartitePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphflowbipartitePoint::lerp(
  self : GraphflowbipartitePoint,
  other : GraphflowbipartitePoint,
  t : Double,
) -> GraphflowbipartitePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphflowbipartitePoint::to_string(
  self : GraphflowbipartitePoint,
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
pub(all) struct GraphflowbipartiteSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_flow_bipartite_make_series(
  vals : Array[Double],
  name : String,
) -> GraphflowbipartiteSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphflowbipartiteSeries::len(self : GraphflowbipartiteSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphflowbipartiteSeries::sum(self : GraphflowbipartiteSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphflowbipartiteSeries::mean(
  self : GraphflowbipartiteSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphflowbipartiteSeries::min(self : GraphflowbipartiteSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphflowbipartiteSeries::max(self : GraphflowbipartiteSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphflowbipartiteSeries::range(
  self : GraphflowbipartiteSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphflowbipartiteSeries::variance(
  self : GraphflowbipartiteSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphflowbipartiteSeries::std(self : GraphflowbipartiteSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphflowbipartiteSeries::median(
  self : GraphflowbipartiteSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphflowbipartiteSeries::scale(
  self : GraphflowbipartiteSeries,
  f : Double,
) -> GraphflowbipartiteSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphflowbipartiteSeries::add(
  self : GraphflowbipartiteSeries,
  other : GraphflowbipartiteSeries,
) -> GraphflowbipartiteSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphflowbipartiteSeries::sub(
  self : GraphflowbipartiteSeries,
  other : GraphflowbipartiteSeries,
) -> GraphflowbipartiteSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphflowbipartiteSeries::normalize(
  self : GraphflowbipartiteSeries,
) -> GraphflowbipartiteSeries {
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
pub fn GraphflowbipartiteSeries::cumsum(
  self : GraphflowbipartiteSeries,
) -> GraphflowbipartiteSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphflowbipartiteSeries::to_string(
  self : GraphflowbipartiteSeries,
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
pub(all) struct GraphflowbipartiteMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_flow_bipartite_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphflowbipartiteMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_flow_bipartite_matrix_identity(
  n : Int32,
) -> GraphflowbipartiteMatrix {
  let m = graph_flow_bipartite_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphflowbipartiteMatrix::get(
  self : GraphflowbipartiteMatrix,
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
pub fn GraphflowbipartiteMatrix::transpose(
  self : GraphflowbipartiteMatrix,
) -> GraphflowbipartiteMatrix {
  let result = graph_flow_bipartite_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphflowbipartiteMatrix::add(
  self : GraphflowbipartiteMatrix,
  other : GraphflowbipartiteMatrix,
) -> GraphflowbipartiteMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_flow_bipartite_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphflowbipartiteMatrix::scale(
  self : GraphflowbipartiteMatrix,
  s : Double,
) -> GraphflowbipartiteMatrix {
  let result = graph_flow_bipartite_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphflowbipartiteMatrix::multiply(
  self : GraphflowbipartiteMatrix,
  other : GraphflowbipartiteMatrix,
) -> GraphflowbipartiteMatrix {
  if self.cols != other.rows {
    return graph_flow_bipartite_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_flow_bipartite_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphflowbipartiteMatrix::trace(
  self : GraphflowbipartiteMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphflowbipartiteMatrix::det(self : GraphflowbipartiteMatrix) -> Double {
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
pub fn GraphflowbipartiteMatrix::norm(
  self : GraphflowbipartiteMatrix,
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
pub fn GraphflowbipartiteMatrix::to_string(
  self : GraphflowbipartiteMatrix,
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
pub(all) struct GraphflowbipartiteVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_flow_bipartite_make_vector(
  comps : Array[Double],
) -> GraphflowbipartiteVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_flow_bipartite_vector_zero(
  dim : Int32,
) -> GraphflowbipartiteVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphflowbipartiteVector::add(
  self : GraphflowbipartiteVector,
  other : GraphflowbipartiteVector,
) -> GraphflowbipartiteVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphflowbipartiteVector::sub(
  self : GraphflowbipartiteVector,
  other : GraphflowbipartiteVector,
) -> GraphflowbipartiteVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphflowbipartiteVector::scale(
  self : GraphflowbipartiteVector,
  s : Double,
) -> GraphflowbipartiteVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphflowbipartiteVector::dot(
  self : GraphflowbipartiteVector,
  other : GraphflowbipartiteVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphflowbipartiteVector::norm(
  self : GraphflowbipartiteVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphflowbipartiteVector::normalize(
  self : GraphflowbipartiteVector,
) -> GraphflowbipartiteVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphflowbipartiteVector::dist(
  self : GraphflowbipartiteVector,
  other : GraphflowbipartiteVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphflowbipartiteVector::to_string(
  self : GraphflowbipartiteVector,
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
pub(all) struct GraphflowbipartiteFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_frame_make(size : Int32) -> GraphflowbipartiteFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteFrame::len(self : GraphflowbipartiteFrame) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteFrame::get(
  self : GraphflowbipartiteFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteFrame::set(
  self : GraphflowbipartiteFrame,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteFrame::sum(self : GraphflowbipartiteFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteFrame::mean(self : GraphflowbipartiteFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteFrame::scale(
  self : GraphflowbipartiteFrame,
  f : Double,
) -> GraphflowbipartiteFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteFrame::add(
  self : GraphflowbipartiteFrame,
  other : GraphflowbipartiteFrame,
) -> GraphflowbipartiteFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteFrame::copy(
  self : GraphflowbipartiteFrame,
) -> GraphflowbipartiteFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteFrame::fill(
  self : GraphflowbipartiteFrame,
  v : Double,
) -> GraphflowbipartiteFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteFrame::min(self : GraphflowbipartiteFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteFrame::max(self : GraphflowbipartiteFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteFrame::to_string(
  self : GraphflowbipartiteFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_table_make(size : Int32) -> GraphflowbipartiteTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteTable::len(self : GraphflowbipartiteTable) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteTable::get(
  self : GraphflowbipartiteTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteTable::set(
  self : GraphflowbipartiteTable,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteTable::sum(self : GraphflowbipartiteTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteTable::mean(self : GraphflowbipartiteTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteTable::scale(
  self : GraphflowbipartiteTable,
  f : Double,
) -> GraphflowbipartiteTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteTable::add(
  self : GraphflowbipartiteTable,
  other : GraphflowbipartiteTable,
) -> GraphflowbipartiteTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteTable::copy(
  self : GraphflowbipartiteTable,
) -> GraphflowbipartiteTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteTable::fill(
  self : GraphflowbipartiteTable,
  v : Double,
) -> GraphflowbipartiteTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteTable::min(self : GraphflowbipartiteTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteTable::max(self : GraphflowbipartiteTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteTable::to_string(
  self : GraphflowbipartiteTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_graphn_make(
  size : Int32,
) -> GraphflowbipartiteGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteGraphN::len(self : GraphflowbipartiteGraphN) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteGraphN::get(
  self : GraphflowbipartiteGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteGraphN::set(
  self : GraphflowbipartiteGraphN,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteGraphN::sum(self : GraphflowbipartiteGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteGraphN::mean(
  self : GraphflowbipartiteGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteGraphN::scale(
  self : GraphflowbipartiteGraphN,
  f : Double,
) -> GraphflowbipartiteGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteGraphN::add(
  self : GraphflowbipartiteGraphN,
  other : GraphflowbipartiteGraphN,
) -> GraphflowbipartiteGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteGraphN::copy(
  self : GraphflowbipartiteGraphN,
) -> GraphflowbipartiteGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteGraphN::fill(
  self : GraphflowbipartiteGraphN,
  v : Double,
) -> GraphflowbipartiteGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteGraphN::min(self : GraphflowbipartiteGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteGraphN::max(self : GraphflowbipartiteGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteGraphN::to_string(
  self : GraphflowbipartiteGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_node_make(size : Int32) -> GraphflowbipartiteNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteNode::len(self : GraphflowbipartiteNode) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteNode::get(
  self : GraphflowbipartiteNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteNode::set(
  self : GraphflowbipartiteNode,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteNode::sum(self : GraphflowbipartiteNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteNode::mean(self : GraphflowbipartiteNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteNode::scale(
  self : GraphflowbipartiteNode,
  f : Double,
) -> GraphflowbipartiteNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteNode::add(
  self : GraphflowbipartiteNode,
  other : GraphflowbipartiteNode,
) -> GraphflowbipartiteNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteNode::copy(
  self : GraphflowbipartiteNode,
) -> GraphflowbipartiteNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteNode::fill(
  self : GraphflowbipartiteNode,
  v : Double,
) -> GraphflowbipartiteNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteNode::min(self : GraphflowbipartiteNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteNode::max(self : GraphflowbipartiteNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteNode::to_string(
  self : GraphflowbipartiteNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_edge_make(size : Int32) -> GraphflowbipartiteEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteEdge::len(self : GraphflowbipartiteEdge) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteEdge::get(
  self : GraphflowbipartiteEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteEdge::set(
  self : GraphflowbipartiteEdge,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteEdge::sum(self : GraphflowbipartiteEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteEdge::mean(self : GraphflowbipartiteEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteEdge::scale(
  self : GraphflowbipartiteEdge,
  f : Double,
) -> GraphflowbipartiteEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteEdge::add(
  self : GraphflowbipartiteEdge,
  other : GraphflowbipartiteEdge,
) -> GraphflowbipartiteEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteEdge::copy(
  self : GraphflowbipartiteEdge,
) -> GraphflowbipartiteEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteEdge::fill(
  self : GraphflowbipartiteEdge,
  v : Double,
) -> GraphflowbipartiteEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteEdge::min(self : GraphflowbipartiteEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteEdge::max(self : GraphflowbipartiteEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteEdge::to_string(
  self : GraphflowbipartiteEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartitePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_path_make(size : Int32) -> GraphflowbipartitePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartitePath::len(self : GraphflowbipartitePath) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartitePath::get(
  self : GraphflowbipartitePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartitePath::set(
  self : GraphflowbipartitePath,
  i : Int32,
  v : Double,
) -> GraphflowbipartitePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartitePath::sum(self : GraphflowbipartitePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartitePath::mean(self : GraphflowbipartitePath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartitePath::scale(
  self : GraphflowbipartitePath,
  f : Double,
) -> GraphflowbipartitePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartitePath::add(
  self : GraphflowbipartitePath,
  other : GraphflowbipartitePath,
) -> GraphflowbipartitePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartitePath::copy(
  self : GraphflowbipartitePath,
) -> GraphflowbipartitePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartitePath::fill(
  self : GraphflowbipartitePath,
  v : Double,
) -> GraphflowbipartitePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartitePath::min(self : GraphflowbipartitePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartitePath::max(self : GraphflowbipartitePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartitePath::to_string(
  self : GraphflowbipartitePath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_cluster_make(
  size : Int32,
) -> GraphflowbipartiteCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteCluster::len(
  self : GraphflowbipartiteCluster,
) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteCluster::get(
  self : GraphflowbipartiteCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteCluster::set(
  self : GraphflowbipartiteCluster,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteCluster::sum(
  self : GraphflowbipartiteCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteCluster::mean(
  self : GraphflowbipartiteCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteCluster::scale(
  self : GraphflowbipartiteCluster,
  f : Double,
) -> GraphflowbipartiteCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteCluster::add(
  self : GraphflowbipartiteCluster,
  other : GraphflowbipartiteCluster,
) -> GraphflowbipartiteCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteCluster::copy(
  self : GraphflowbipartiteCluster,
) -> GraphflowbipartiteCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteCluster::fill(
  self : GraphflowbipartiteCluster,
  v : Double,
) -> GraphflowbipartiteCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteCluster::min(
  self : GraphflowbipartiteCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteCluster::max(
  self : GraphflowbipartiteCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteCluster::to_string(
  self : GraphflowbipartiteCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_model_make(size : Int32) -> GraphflowbipartiteModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteModel::len(self : GraphflowbipartiteModel) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteModel::get(
  self : GraphflowbipartiteModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteModel::set(
  self : GraphflowbipartiteModel,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteModel::sum(self : GraphflowbipartiteModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteModel::mean(self : GraphflowbipartiteModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteModel::scale(
  self : GraphflowbipartiteModel,
  f : Double,
) -> GraphflowbipartiteModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteModel::add(
  self : GraphflowbipartiteModel,
  other : GraphflowbipartiteModel,
) -> GraphflowbipartiteModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteModel::copy(
  self : GraphflowbipartiteModel,
) -> GraphflowbipartiteModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteModel::fill(
  self : GraphflowbipartiteModel,
  v : Double,
) -> GraphflowbipartiteModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteModel::min(self : GraphflowbipartiteModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteModel::max(self : GraphflowbipartiteModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteModel::to_string(
  self : GraphflowbipartiteModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_layer_make(size : Int32) -> GraphflowbipartiteLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteLayer::len(self : GraphflowbipartiteLayer) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteLayer::get(
  self : GraphflowbipartiteLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteLayer::set(
  self : GraphflowbipartiteLayer,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteLayer::sum(self : GraphflowbipartiteLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteLayer::mean(self : GraphflowbipartiteLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteLayer::scale(
  self : GraphflowbipartiteLayer,
  f : Double,
) -> GraphflowbipartiteLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteLayer::add(
  self : GraphflowbipartiteLayer,
  other : GraphflowbipartiteLayer,
) -> GraphflowbipartiteLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteLayer::copy(
  self : GraphflowbipartiteLayer,
) -> GraphflowbipartiteLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteLayer::fill(
  self : GraphflowbipartiteLayer,
  v : Double,
) -> GraphflowbipartiteLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteLayer::min(self : GraphflowbipartiteLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteLayer::max(self : GraphflowbipartiteLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteLayer::to_string(
  self : GraphflowbipartiteLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_buffer_make(
  size : Int32,
) -> GraphflowbipartiteBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteBuffer::len(self : GraphflowbipartiteBuffer) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteBuffer::get(
  self : GraphflowbipartiteBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteBuffer::set(
  self : GraphflowbipartiteBuffer,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteBuffer::sum(self : GraphflowbipartiteBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteBuffer::mean(
  self : GraphflowbipartiteBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteBuffer::scale(
  self : GraphflowbipartiteBuffer,
  f : Double,
) -> GraphflowbipartiteBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteBuffer::add(
  self : GraphflowbipartiteBuffer,
  other : GraphflowbipartiteBuffer,
) -> GraphflowbipartiteBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteBuffer::copy(
  self : GraphflowbipartiteBuffer,
) -> GraphflowbipartiteBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteBuffer::fill(
  self : GraphflowbipartiteBuffer,
  v : Double,
) -> GraphflowbipartiteBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteBuffer::min(self : GraphflowbipartiteBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteBuffer::max(self : GraphflowbipartiteBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteBuffer::to_string(
  self : GraphflowbipartiteBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_cursor_make(
  size : Int32,
) -> GraphflowbipartiteCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteCursor::len(self : GraphflowbipartiteCursor) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteCursor::get(
  self : GraphflowbipartiteCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteCursor::set(
  self : GraphflowbipartiteCursor,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteCursor::sum(self : GraphflowbipartiteCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteCursor::mean(
  self : GraphflowbipartiteCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteCursor::scale(
  self : GraphflowbipartiteCursor,
  f : Double,
) -> GraphflowbipartiteCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteCursor::add(
  self : GraphflowbipartiteCursor,
  other : GraphflowbipartiteCursor,
) -> GraphflowbipartiteCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteCursor::copy(
  self : GraphflowbipartiteCursor,
) -> GraphflowbipartiteCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteCursor::fill(
  self : GraphflowbipartiteCursor,
  v : Double,
) -> GraphflowbipartiteCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteCursor::min(self : GraphflowbipartiteCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteCursor::max(self : GraphflowbipartiteCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteCursor::to_string(
  self : GraphflowbipartiteCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_view_make(size : Int32) -> GraphflowbipartiteView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteView::len(self : GraphflowbipartiteView) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteView::get(
  self : GraphflowbipartiteView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteView::set(
  self : GraphflowbipartiteView,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteView::sum(self : GraphflowbipartiteView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteView::mean(self : GraphflowbipartiteView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteView::scale(
  self : GraphflowbipartiteView,
  f : Double,
) -> GraphflowbipartiteView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteView::add(
  self : GraphflowbipartiteView,
  other : GraphflowbipartiteView,
) -> GraphflowbipartiteView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteView::copy(
  self : GraphflowbipartiteView,
) -> GraphflowbipartiteView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteView::fill(
  self : GraphflowbipartiteView,
  v : Double,
) -> GraphflowbipartiteView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteView::min(self : GraphflowbipartiteView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteView::max(self : GraphflowbipartiteView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteView::to_string(
  self : GraphflowbipartiteView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_range_make(size : Int32) -> GraphflowbipartiteRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteRange::len(self : GraphflowbipartiteRange) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteRange::get(
  self : GraphflowbipartiteRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteRange::set(
  self : GraphflowbipartiteRange,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteRange::sum(self : GraphflowbipartiteRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteRange::mean(self : GraphflowbipartiteRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteRange::scale(
  self : GraphflowbipartiteRange,
  f : Double,
) -> GraphflowbipartiteRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteRange::add(
  self : GraphflowbipartiteRange,
  other : GraphflowbipartiteRange,
) -> GraphflowbipartiteRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteRange::copy(
  self : GraphflowbipartiteRange,
) -> GraphflowbipartiteRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteRange::fill(
  self : GraphflowbipartiteRange,
  v : Double,
) -> GraphflowbipartiteRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteRange::min(self : GraphflowbipartiteRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteRange::max(self : GraphflowbipartiteRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteRange::to_string(
  self : GraphflowbipartiteRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphflowbipartiteSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_flow_bipartite_slice_make(size : Int32) -> GraphflowbipartiteSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphflowbipartiteSlice::len(self : GraphflowbipartiteSlice) -> Int32 {
  self.size
}

///|
pub fn GraphflowbipartiteSlice::get(
  self : GraphflowbipartiteSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphflowbipartiteSlice::set(
  self : GraphflowbipartiteSlice,
  i : Int32,
  v : Double,
) -> GraphflowbipartiteSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteSlice::sum(self : GraphflowbipartiteSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphflowbipartiteSlice::mean(self : GraphflowbipartiteSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphflowbipartiteSlice::scale(
  self : GraphflowbipartiteSlice,
  f : Double,
) -> GraphflowbipartiteSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteSlice::add(
  self : GraphflowbipartiteSlice,
  other : GraphflowbipartiteSlice,
) -> GraphflowbipartiteSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteSlice::copy(
  self : GraphflowbipartiteSlice,
) -> GraphflowbipartiteSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteSlice::fill(
  self : GraphflowbipartiteSlice,
  v : Double,
) -> GraphflowbipartiteSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphflowbipartiteSlice::min(self : GraphflowbipartiteSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphflowbipartiteSlice::max(self : GraphflowbipartiteSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphflowbipartiteSlice::to_string(
  self : GraphflowbipartiteSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
