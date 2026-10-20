///===
/// extcore/stats_dist_poisson

pub(all) struct StatsdistpoissonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_poisson_make_point(x : Double, y : Double) -> StatsdistpoissonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_poisson_make_point3(x : Double, y : Double, z : Double) -> StatsdistpoissonPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistpoissonPoint::x(self : StatsdistpoissonPoint) -> Double { self.x }

pub fn StatsdistpoissonPoint::y(self : StatsdistpoissonPoint) -> Double { self.y }

pub fn StatsdistpoissonPoint::z(self : StatsdistpoissonPoint) -> Double { self.z }

pub fn StatsdistpoissonPoint::label(self : StatsdistpoissonPoint) -> Int { self.label }

pub fn StatsdistpoissonPoint::dist(self : StatsdistpoissonPoint, other : StatsdistpoissonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistpoissonPoint::add(self : StatsdistpoissonPoint, other : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistpoissonPoint::sub(self : StatsdistpoissonPoint, other : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistpoissonPoint::scale(self : StatsdistpoissonPoint, s : Double) -> StatsdistpoissonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistpoissonPoint::dot(self : StatsdistpoissonPoint, other : StatsdistpoissonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistpoissonPoint::cross(self : StatsdistpoissonPoint, other : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistpoissonPoint::norm(self : StatsdistpoissonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistpoissonPoint::normalize(self : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistpoissonPoint::negate(self : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistpoissonPoint::mid(self : StatsdistpoissonPoint, other : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistpoissonPoint::lerp(self : StatsdistpoissonPoint, other : StatsdistpoissonPoint, t : Double) -> StatsdistpoissonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistpoissonPoint::to_string(self : StatsdistpoissonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistpoissonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_poisson_make_series(vals : Array[Double], name : String) -> StatsdistpoissonSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistpoissonSeries::len(self : StatsdistpoissonSeries) -> Int { self.vals.length() }

pub fn StatsdistpoissonSeries::sum(self : StatsdistpoissonSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistpoissonSeries::mean(self : StatsdistpoissonSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistpoissonSeries::min(self : StatsdistpoissonSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistpoissonSeries::max(self : StatsdistpoissonSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistpoissonSeries::range(self : StatsdistpoissonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistpoissonSeries::variance(self : StatsdistpoissonSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistpoissonSeries::std(self : StatsdistpoissonSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistpoissonSeries::median(self : StatsdistpoissonSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistpoissonSeries::scale(self : StatsdistpoissonSeries, f : Double) -> StatsdistpoissonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistpoissonSeries::add(self : StatsdistpoissonSeries, other : StatsdistpoissonSeries) -> StatsdistpoissonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistpoissonSeries::sub(self : StatsdistpoissonSeries, other : StatsdistpoissonSeries) -> StatsdistpoissonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistpoissonSeries::normalize(self : StatsdistpoissonSeries) -> StatsdistpoissonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistpoissonSeries::cumsum(self : StatsdistpoissonSeries) -> StatsdistpoissonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistpoissonSeries::to_string(self : StatsdistpoissonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistpoissonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_poisson_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistpoissonMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn stats_dist_poisson_matrix_identity(n : Int) -> StatsdistpoissonMatrix {
  let m = stats_dist_poisson_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistpoissonMatrix::get(self : StatsdistpoissonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistpoissonMatrix::transpose(self : StatsdistpoissonMatrix) -> StatsdistpoissonMatrix {
  let result = stats_dist_poisson_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistpoissonMatrix::add(self : StatsdistpoissonMatrix, other : StatsdistpoissonMatrix) -> StatsdistpoissonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_poisson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistpoissonMatrix::scale(self : StatsdistpoissonMatrix, s : Double) -> StatsdistpoissonMatrix {
  let result = stats_dist_poisson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistpoissonMatrix::multiply(self : StatsdistpoissonMatrix, other : StatsdistpoissonMatrix) -> StatsdistpoissonMatrix {
  if self.cols != other.rows { return stats_dist_poisson_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_poisson_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsdistpoissonMatrix::trace(self : StatsdistpoissonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistpoissonMatrix::det(self : StatsdistpoissonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistpoissonMatrix::norm(self : StatsdistpoissonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistpoissonMatrix::to_string(self : StatsdistpoissonMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct StatsdistpoissonVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_poisson_make_vector(comps : Array[Double]) -> StatsdistpoissonVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_poisson_vector_zero(dim : Int) -> StatsdistpoissonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistpoissonVector::add(self : StatsdistpoissonVector, other : StatsdistpoissonVector) -> StatsdistpoissonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistpoissonVector::sub(self : StatsdistpoissonVector, other : StatsdistpoissonVector) -> StatsdistpoissonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistpoissonVector::scale(self : StatsdistpoissonVector, s : Double) -> StatsdistpoissonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistpoissonVector::dot(self : StatsdistpoissonVector, other : StatsdistpoissonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistpoissonVector::norm(self : StatsdistpoissonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistpoissonVector::normalize(self : StatsdistpoissonVector) -> StatsdistpoissonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistpoissonVector::dist(self : StatsdistpoissonVector, other : StatsdistpoissonVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistpoissonVector::to_string(self : StatsdistpoissonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistpoissonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_frame_make(size : Int) -> StatsdistpoissonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonFrame::len(self : StatsdistpoissonFrame) -> Int { self.size }

pub fn StatsdistpoissonFrame::get(self : StatsdistpoissonFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonFrame::set(self : StatsdistpoissonFrame, i : Int, v : Double) -> StatsdistpoissonFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonFrame::sum(self : StatsdistpoissonFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonFrame::mean(self : StatsdistpoissonFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonFrame::scale(self : StatsdistpoissonFrame, f : Double) -> StatsdistpoissonFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonFrame::add(self : StatsdistpoissonFrame, other : StatsdistpoissonFrame) -> StatsdistpoissonFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonFrame::copy(self : StatsdistpoissonFrame) -> StatsdistpoissonFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonFrame::fill(self : StatsdistpoissonFrame, v : Double) -> StatsdistpoissonFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonFrame::min(self : StatsdistpoissonFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonFrame::max(self : StatsdistpoissonFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonFrame::to_string(self : StatsdistpoissonFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_table_make(size : Int) -> StatsdistpoissonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonTable::len(self : StatsdistpoissonTable) -> Int { self.size }

pub fn StatsdistpoissonTable::get(self : StatsdistpoissonTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonTable::set(self : StatsdistpoissonTable, i : Int, v : Double) -> StatsdistpoissonTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonTable::sum(self : StatsdistpoissonTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonTable::mean(self : StatsdistpoissonTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonTable::scale(self : StatsdistpoissonTable, f : Double) -> StatsdistpoissonTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonTable::add(self : StatsdistpoissonTable, other : StatsdistpoissonTable) -> StatsdistpoissonTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonTable::copy(self : StatsdistpoissonTable) -> StatsdistpoissonTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonTable::fill(self : StatsdistpoissonTable, v : Double) -> StatsdistpoissonTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonTable::min(self : StatsdistpoissonTable) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonTable::max(self : StatsdistpoissonTable) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonTable::to_string(self : StatsdistpoissonTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_graphn_make(size : Int) -> StatsdistpoissonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonGraphN::len(self : StatsdistpoissonGraphN) -> Int { self.size }

pub fn StatsdistpoissonGraphN::get(self : StatsdistpoissonGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonGraphN::set(self : StatsdistpoissonGraphN, i : Int, v : Double) -> StatsdistpoissonGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonGraphN::sum(self : StatsdistpoissonGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonGraphN::mean(self : StatsdistpoissonGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonGraphN::scale(self : StatsdistpoissonGraphN, f : Double) -> StatsdistpoissonGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonGraphN::add(self : StatsdistpoissonGraphN, other : StatsdistpoissonGraphN) -> StatsdistpoissonGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonGraphN::copy(self : StatsdistpoissonGraphN) -> StatsdistpoissonGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonGraphN::fill(self : StatsdistpoissonGraphN, v : Double) -> StatsdistpoissonGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonGraphN::min(self : StatsdistpoissonGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonGraphN::max(self : StatsdistpoissonGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonGraphN::to_string(self : StatsdistpoissonGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_node_make(size : Int) -> StatsdistpoissonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonNode::len(self : StatsdistpoissonNode) -> Int { self.size }

pub fn StatsdistpoissonNode::get(self : StatsdistpoissonNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonNode::set(self : StatsdistpoissonNode, i : Int, v : Double) -> StatsdistpoissonNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonNode::sum(self : StatsdistpoissonNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonNode::mean(self : StatsdistpoissonNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonNode::scale(self : StatsdistpoissonNode, f : Double) -> StatsdistpoissonNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonNode::add(self : StatsdistpoissonNode, other : StatsdistpoissonNode) -> StatsdistpoissonNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonNode::copy(self : StatsdistpoissonNode) -> StatsdistpoissonNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonNode::fill(self : StatsdistpoissonNode, v : Double) -> StatsdistpoissonNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonNode::min(self : StatsdistpoissonNode) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonNode::max(self : StatsdistpoissonNode) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonNode::to_string(self : StatsdistpoissonNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_edge_make(size : Int) -> StatsdistpoissonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonEdge::len(self : StatsdistpoissonEdge) -> Int { self.size }

pub fn StatsdistpoissonEdge::get(self : StatsdistpoissonEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonEdge::set(self : StatsdistpoissonEdge, i : Int, v : Double) -> StatsdistpoissonEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonEdge::sum(self : StatsdistpoissonEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonEdge::mean(self : StatsdistpoissonEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonEdge::scale(self : StatsdistpoissonEdge, f : Double) -> StatsdistpoissonEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonEdge::add(self : StatsdistpoissonEdge, other : StatsdistpoissonEdge) -> StatsdistpoissonEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonEdge::copy(self : StatsdistpoissonEdge) -> StatsdistpoissonEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonEdge::fill(self : StatsdistpoissonEdge, v : Double) -> StatsdistpoissonEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonEdge::min(self : StatsdistpoissonEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonEdge::max(self : StatsdistpoissonEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonEdge::to_string(self : StatsdistpoissonEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_path_make(size : Int) -> StatsdistpoissonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonPath::len(self : StatsdistpoissonPath) -> Int { self.size }

pub fn StatsdistpoissonPath::get(self : StatsdistpoissonPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonPath::set(self : StatsdistpoissonPath, i : Int, v : Double) -> StatsdistpoissonPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonPath::sum(self : StatsdistpoissonPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonPath::mean(self : StatsdistpoissonPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonPath::scale(self : StatsdistpoissonPath, f : Double) -> StatsdistpoissonPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonPath::add(self : StatsdistpoissonPath, other : StatsdistpoissonPath) -> StatsdistpoissonPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonPath::copy(self : StatsdistpoissonPath) -> StatsdistpoissonPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonPath::fill(self : StatsdistpoissonPath, v : Double) -> StatsdistpoissonPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonPath::min(self : StatsdistpoissonPath) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonPath::max(self : StatsdistpoissonPath) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonPath::to_string(self : StatsdistpoissonPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_cluster_make(size : Int) -> StatsdistpoissonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonCluster::len(self : StatsdistpoissonCluster) -> Int { self.size }

pub fn StatsdistpoissonCluster::get(self : StatsdistpoissonCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonCluster::set(self : StatsdistpoissonCluster, i : Int, v : Double) -> StatsdistpoissonCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonCluster::sum(self : StatsdistpoissonCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonCluster::mean(self : StatsdistpoissonCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonCluster::scale(self : StatsdistpoissonCluster, f : Double) -> StatsdistpoissonCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonCluster::add(self : StatsdistpoissonCluster, other : StatsdistpoissonCluster) -> StatsdistpoissonCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonCluster::copy(self : StatsdistpoissonCluster) -> StatsdistpoissonCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonCluster::fill(self : StatsdistpoissonCluster, v : Double) -> StatsdistpoissonCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonCluster::min(self : StatsdistpoissonCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonCluster::max(self : StatsdistpoissonCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonCluster::to_string(self : StatsdistpoissonCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_model_make(size : Int) -> StatsdistpoissonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonModel::len(self : StatsdistpoissonModel) -> Int { self.size }

pub fn StatsdistpoissonModel::get(self : StatsdistpoissonModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonModel::set(self : StatsdistpoissonModel, i : Int, v : Double) -> StatsdistpoissonModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonModel::sum(self : StatsdistpoissonModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonModel::mean(self : StatsdistpoissonModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonModel::scale(self : StatsdistpoissonModel, f : Double) -> StatsdistpoissonModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonModel::add(self : StatsdistpoissonModel, other : StatsdistpoissonModel) -> StatsdistpoissonModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonModel::copy(self : StatsdistpoissonModel) -> StatsdistpoissonModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonModel::fill(self : StatsdistpoissonModel, v : Double) -> StatsdistpoissonModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonModel::min(self : StatsdistpoissonModel) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonModel::max(self : StatsdistpoissonModel) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonModel::to_string(self : StatsdistpoissonModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_layer_make(size : Int) -> StatsdistpoissonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonLayer::len(self : StatsdistpoissonLayer) -> Int { self.size }

pub fn StatsdistpoissonLayer::get(self : StatsdistpoissonLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonLayer::set(self : StatsdistpoissonLayer, i : Int, v : Double) -> StatsdistpoissonLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonLayer::sum(self : StatsdistpoissonLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonLayer::mean(self : StatsdistpoissonLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonLayer::scale(self : StatsdistpoissonLayer, f : Double) -> StatsdistpoissonLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonLayer::add(self : StatsdistpoissonLayer, other : StatsdistpoissonLayer) -> StatsdistpoissonLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonLayer::copy(self : StatsdistpoissonLayer) -> StatsdistpoissonLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonLayer::fill(self : StatsdistpoissonLayer, v : Double) -> StatsdistpoissonLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonLayer::min(self : StatsdistpoissonLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonLayer::max(self : StatsdistpoissonLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonLayer::to_string(self : StatsdistpoissonLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_buffer_make(size : Int) -> StatsdistpoissonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonBuffer::len(self : StatsdistpoissonBuffer) -> Int { self.size }

pub fn StatsdistpoissonBuffer::get(self : StatsdistpoissonBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonBuffer::set(self : StatsdistpoissonBuffer, i : Int, v : Double) -> StatsdistpoissonBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonBuffer::sum(self : StatsdistpoissonBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonBuffer::mean(self : StatsdistpoissonBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonBuffer::scale(self : StatsdistpoissonBuffer, f : Double) -> StatsdistpoissonBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonBuffer::add(self : StatsdistpoissonBuffer, other : StatsdistpoissonBuffer) -> StatsdistpoissonBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonBuffer::copy(self : StatsdistpoissonBuffer) -> StatsdistpoissonBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonBuffer::fill(self : StatsdistpoissonBuffer, v : Double) -> StatsdistpoissonBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonBuffer::min(self : StatsdistpoissonBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonBuffer::max(self : StatsdistpoissonBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonBuffer::to_string(self : StatsdistpoissonBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_cursor_make(size : Int) -> StatsdistpoissonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonCursor::len(self : StatsdistpoissonCursor) -> Int { self.size }

pub fn StatsdistpoissonCursor::get(self : StatsdistpoissonCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonCursor::set(self : StatsdistpoissonCursor, i : Int, v : Double) -> StatsdistpoissonCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonCursor::sum(self : StatsdistpoissonCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonCursor::mean(self : StatsdistpoissonCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonCursor::scale(self : StatsdistpoissonCursor, f : Double) -> StatsdistpoissonCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonCursor::add(self : StatsdistpoissonCursor, other : StatsdistpoissonCursor) -> StatsdistpoissonCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonCursor::copy(self : StatsdistpoissonCursor) -> StatsdistpoissonCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonCursor::fill(self : StatsdistpoissonCursor, v : Double) -> StatsdistpoissonCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonCursor::min(self : StatsdistpoissonCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonCursor::max(self : StatsdistpoissonCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonCursor::to_string(self : StatsdistpoissonCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_view_make(size : Int) -> StatsdistpoissonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonView::len(self : StatsdistpoissonView) -> Int { self.size }

pub fn StatsdistpoissonView::get(self : StatsdistpoissonView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonView::set(self : StatsdistpoissonView, i : Int, v : Double) -> StatsdistpoissonView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonView::sum(self : StatsdistpoissonView) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonView::mean(self : StatsdistpoissonView) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonView::scale(self : StatsdistpoissonView, f : Double) -> StatsdistpoissonView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonView::add(self : StatsdistpoissonView, other : StatsdistpoissonView) -> StatsdistpoissonView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonView::copy(self : StatsdistpoissonView) -> StatsdistpoissonView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonView::fill(self : StatsdistpoissonView, v : Double) -> StatsdistpoissonView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonView::min(self : StatsdistpoissonView) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonView::max(self : StatsdistpoissonView) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonView::to_string(self : StatsdistpoissonView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_range_make(size : Int) -> StatsdistpoissonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonRange::len(self : StatsdistpoissonRange) -> Int { self.size }

pub fn StatsdistpoissonRange::get(self : StatsdistpoissonRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonRange::set(self : StatsdistpoissonRange, i : Int, v : Double) -> StatsdistpoissonRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonRange::sum(self : StatsdistpoissonRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonRange::mean(self : StatsdistpoissonRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonRange::scale(self : StatsdistpoissonRange, f : Double) -> StatsdistpoissonRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonRange::add(self : StatsdistpoissonRange, other : StatsdistpoissonRange) -> StatsdistpoissonRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonRange::copy(self : StatsdistpoissonRange) -> StatsdistpoissonRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonRange::fill(self : StatsdistpoissonRange, v : Double) -> StatsdistpoissonRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonRange::min(self : StatsdistpoissonRange) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonRange::max(self : StatsdistpoissonRange) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonRange::to_string(self : StatsdistpoissonRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_slice_make(size : Int) -> StatsdistpoissonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistpoissonSlice::len(self : StatsdistpoissonSlice) -> Int { self.size }

pub fn StatsdistpoissonSlice::get(self : StatsdistpoissonSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistpoissonSlice::set(self : StatsdistpoissonSlice, i : Int, v : Double) -> StatsdistpoissonSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonSlice::sum(self : StatsdistpoissonSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistpoissonSlice::mean(self : StatsdistpoissonSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistpoissonSlice::scale(self : StatsdistpoissonSlice, f : Double) -> StatsdistpoissonSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonSlice::add(self : StatsdistpoissonSlice, other : StatsdistpoissonSlice) -> StatsdistpoissonSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistpoissonSlice::copy(self : StatsdistpoissonSlice) -> StatsdistpoissonSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonSlice::fill(self : StatsdistpoissonSlice, v : Double) -> StatsdistpoissonSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistpoissonSlice::min(self : StatsdistpoissonSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistpoissonSlice::max(self : StatsdistpoissonSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistpoissonSlice::to_string(self : StatsdistpoissonSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

