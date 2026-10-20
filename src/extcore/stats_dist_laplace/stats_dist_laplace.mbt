///===
/// extcore/stats_dist_laplace

pub(all) struct StatsdistlaplacePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_laplace_make_point(x : Double, y : Double) -> StatsdistlaplacePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_laplace_make_point3(x : Double, y : Double, z : Double) -> StatsdistlaplacePoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistlaplacePoint::x(self : StatsdistlaplacePoint) -> Double { self.x }

pub fn StatsdistlaplacePoint::y(self : StatsdistlaplacePoint) -> Double { self.y }

pub fn StatsdistlaplacePoint::z(self : StatsdistlaplacePoint) -> Double { self.z }

pub fn StatsdistlaplacePoint::label(self : StatsdistlaplacePoint) -> Int { self.label }

pub fn StatsdistlaplacePoint::dist(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistlaplacePoint::add(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistlaplacePoint::sub(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistlaplacePoint::scale(self : StatsdistlaplacePoint, s : Double) -> StatsdistlaplacePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistlaplacePoint::dot(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistlaplacePoint::cross(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistlaplacePoint::norm(self : StatsdistlaplacePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistlaplacePoint::normalize(self : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistlaplacePoint::negate(self : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistlaplacePoint::mid(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistlaplacePoint::lerp(self : StatsdistlaplacePoint, other : StatsdistlaplacePoint, t : Double) -> StatsdistlaplacePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistlaplacePoint::to_string(self : StatsdistlaplacePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistlaplaceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_laplace_make_series(vals : Array[Double], name : String) -> StatsdistlaplaceSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistlaplaceSeries::len(self : StatsdistlaplaceSeries) -> Int { self.vals.length() }

pub fn StatsdistlaplaceSeries::sum(self : StatsdistlaplaceSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistlaplaceSeries::mean(self : StatsdistlaplaceSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistlaplaceSeries::min(self : StatsdistlaplaceSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistlaplaceSeries::max(self : StatsdistlaplaceSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistlaplaceSeries::range(self : StatsdistlaplaceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistlaplaceSeries::variance(self : StatsdistlaplaceSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistlaplaceSeries::std(self : StatsdistlaplaceSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistlaplaceSeries::median(self : StatsdistlaplaceSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistlaplaceSeries::scale(self : StatsdistlaplaceSeries, f : Double) -> StatsdistlaplaceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistlaplaceSeries::add(self : StatsdistlaplaceSeries, other : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistlaplaceSeries::sub(self : StatsdistlaplaceSeries, other : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistlaplaceSeries::normalize(self : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistlaplaceSeries::cumsum(self : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistlaplaceSeries::to_string(self : StatsdistlaplaceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistlaplaceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_laplace_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistlaplaceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_laplace_matrix_identity(n : Int) -> StatsdistlaplaceMatrix {
  let m = stats_dist_laplace_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistlaplaceMatrix::get(self : StatsdistlaplaceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistlaplaceMatrix::transpose(self : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  let result = stats_dist_laplace_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistlaplaceMatrix::add(self : StatsdistlaplaceMatrix, other : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_laplace_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistlaplaceMatrix::scale(self : StatsdistlaplaceMatrix, s : Double) -> StatsdistlaplaceMatrix {
  let result = stats_dist_laplace_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistlaplaceMatrix::multiply(self : StatsdistlaplaceMatrix, other : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  if self.cols != other.rows { return stats_dist_laplace_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_laplace_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsdistlaplaceMatrix::trace(self : StatsdistlaplaceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistlaplaceMatrix::det(self : StatsdistlaplaceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistlaplaceMatrix::norm(self : StatsdistlaplaceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistlaplaceMatrix::to_string(self : StatsdistlaplaceMatrix) -> String {
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

pub(all) struct StatsdistlaplaceVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_laplace_make_vector(comps : Array[Double]) -> StatsdistlaplaceVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_laplace_vector_zero(dim : Int) -> StatsdistlaplaceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistlaplaceVector::add(self : StatsdistlaplaceVector, other : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistlaplaceVector::sub(self : StatsdistlaplaceVector, other : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistlaplaceVector::scale(self : StatsdistlaplaceVector, s : Double) -> StatsdistlaplaceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistlaplaceVector::dot(self : StatsdistlaplaceVector, other : StatsdistlaplaceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistlaplaceVector::norm(self : StatsdistlaplaceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistlaplaceVector::normalize(self : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistlaplaceVector::dist(self : StatsdistlaplaceVector, other : StatsdistlaplaceVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistlaplaceVector::to_string(self : StatsdistlaplaceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistlaplaceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_frame_make(size : Int) -> StatsdistlaplaceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceFrame::len(self : StatsdistlaplaceFrame) -> Int { self.size }

pub fn StatsdistlaplaceFrame::get(self : StatsdistlaplaceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceFrame::set(self : StatsdistlaplaceFrame, i : Int, v : Double) -> StatsdistlaplaceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceFrame::sum(self : StatsdistlaplaceFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceFrame::mean(self : StatsdistlaplaceFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceFrame::scale(self : StatsdistlaplaceFrame, f : Double) -> StatsdistlaplaceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceFrame::add(self : StatsdistlaplaceFrame, other : StatsdistlaplaceFrame) -> StatsdistlaplaceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceFrame::copy(self : StatsdistlaplaceFrame) -> StatsdistlaplaceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceFrame::fill(self : StatsdistlaplaceFrame, v : Double) -> StatsdistlaplaceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceFrame::min(self : StatsdistlaplaceFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceFrame::max(self : StatsdistlaplaceFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceFrame::to_string(self : StatsdistlaplaceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_table_make(size : Int) -> StatsdistlaplaceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceTable::len(self : StatsdistlaplaceTable) -> Int { self.size }

pub fn StatsdistlaplaceTable::get(self : StatsdistlaplaceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceTable::set(self : StatsdistlaplaceTable, i : Int, v : Double) -> StatsdistlaplaceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceTable::sum(self : StatsdistlaplaceTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceTable::mean(self : StatsdistlaplaceTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceTable::scale(self : StatsdistlaplaceTable, f : Double) -> StatsdistlaplaceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceTable::add(self : StatsdistlaplaceTable, other : StatsdistlaplaceTable) -> StatsdistlaplaceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceTable::copy(self : StatsdistlaplaceTable) -> StatsdistlaplaceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceTable::fill(self : StatsdistlaplaceTable, v : Double) -> StatsdistlaplaceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceTable::min(self : StatsdistlaplaceTable) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceTable::max(self : StatsdistlaplaceTable) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceTable::to_string(self : StatsdistlaplaceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_graphn_make(size : Int) -> StatsdistlaplaceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceGraphN::len(self : StatsdistlaplaceGraphN) -> Int { self.size }

pub fn StatsdistlaplaceGraphN::get(self : StatsdistlaplaceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceGraphN::set(self : StatsdistlaplaceGraphN, i : Int, v : Double) -> StatsdistlaplaceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceGraphN::sum(self : StatsdistlaplaceGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceGraphN::mean(self : StatsdistlaplaceGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceGraphN::scale(self : StatsdistlaplaceGraphN, f : Double) -> StatsdistlaplaceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceGraphN::add(self : StatsdistlaplaceGraphN, other : StatsdistlaplaceGraphN) -> StatsdistlaplaceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceGraphN::copy(self : StatsdistlaplaceGraphN) -> StatsdistlaplaceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceGraphN::fill(self : StatsdistlaplaceGraphN, v : Double) -> StatsdistlaplaceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceGraphN::min(self : StatsdistlaplaceGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceGraphN::max(self : StatsdistlaplaceGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceGraphN::to_string(self : StatsdistlaplaceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_node_make(size : Int) -> StatsdistlaplaceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceNode::len(self : StatsdistlaplaceNode) -> Int { self.size }

pub fn StatsdistlaplaceNode::get(self : StatsdistlaplaceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceNode::set(self : StatsdistlaplaceNode, i : Int, v : Double) -> StatsdistlaplaceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceNode::sum(self : StatsdistlaplaceNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceNode::mean(self : StatsdistlaplaceNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceNode::scale(self : StatsdistlaplaceNode, f : Double) -> StatsdistlaplaceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceNode::add(self : StatsdistlaplaceNode, other : StatsdistlaplaceNode) -> StatsdistlaplaceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceNode::copy(self : StatsdistlaplaceNode) -> StatsdistlaplaceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceNode::fill(self : StatsdistlaplaceNode, v : Double) -> StatsdistlaplaceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceNode::min(self : StatsdistlaplaceNode) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceNode::max(self : StatsdistlaplaceNode) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceNode::to_string(self : StatsdistlaplaceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_edge_make(size : Int) -> StatsdistlaplaceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceEdge::len(self : StatsdistlaplaceEdge) -> Int { self.size }

pub fn StatsdistlaplaceEdge::get(self : StatsdistlaplaceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceEdge::set(self : StatsdistlaplaceEdge, i : Int, v : Double) -> StatsdistlaplaceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceEdge::sum(self : StatsdistlaplaceEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceEdge::mean(self : StatsdistlaplaceEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceEdge::scale(self : StatsdistlaplaceEdge, f : Double) -> StatsdistlaplaceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceEdge::add(self : StatsdistlaplaceEdge, other : StatsdistlaplaceEdge) -> StatsdistlaplaceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceEdge::copy(self : StatsdistlaplaceEdge) -> StatsdistlaplaceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceEdge::fill(self : StatsdistlaplaceEdge, v : Double) -> StatsdistlaplaceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceEdge::min(self : StatsdistlaplaceEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceEdge::max(self : StatsdistlaplaceEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceEdge::to_string(self : StatsdistlaplaceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplacePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_path_make(size : Int) -> StatsdistlaplacePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplacePath::len(self : StatsdistlaplacePath) -> Int { self.size }

pub fn StatsdistlaplacePath::get(self : StatsdistlaplacePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplacePath::set(self : StatsdistlaplacePath, i : Int, v : Double) -> StatsdistlaplacePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplacePath::sum(self : StatsdistlaplacePath) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplacePath::mean(self : StatsdistlaplacePath) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplacePath::scale(self : StatsdistlaplacePath, f : Double) -> StatsdistlaplacePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplacePath::add(self : StatsdistlaplacePath, other : StatsdistlaplacePath) -> StatsdistlaplacePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplacePath::copy(self : StatsdistlaplacePath) -> StatsdistlaplacePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplacePath::fill(self : StatsdistlaplacePath, v : Double) -> StatsdistlaplacePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplacePath::min(self : StatsdistlaplacePath) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplacePath::max(self : StatsdistlaplacePath) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplacePath::to_string(self : StatsdistlaplacePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_cluster_make(size : Int) -> StatsdistlaplaceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceCluster::len(self : StatsdistlaplaceCluster) -> Int { self.size }

pub fn StatsdistlaplaceCluster::get(self : StatsdistlaplaceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceCluster::set(self : StatsdistlaplaceCluster, i : Int, v : Double) -> StatsdistlaplaceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceCluster::sum(self : StatsdistlaplaceCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceCluster::mean(self : StatsdistlaplaceCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceCluster::scale(self : StatsdistlaplaceCluster, f : Double) -> StatsdistlaplaceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceCluster::add(self : StatsdistlaplaceCluster, other : StatsdistlaplaceCluster) -> StatsdistlaplaceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceCluster::copy(self : StatsdistlaplaceCluster) -> StatsdistlaplaceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceCluster::fill(self : StatsdistlaplaceCluster, v : Double) -> StatsdistlaplaceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceCluster::min(self : StatsdistlaplaceCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceCluster::max(self : StatsdistlaplaceCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceCluster::to_string(self : StatsdistlaplaceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_model_make(size : Int) -> StatsdistlaplaceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceModel::len(self : StatsdistlaplaceModel) -> Int { self.size }

pub fn StatsdistlaplaceModel::get(self : StatsdistlaplaceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceModel::set(self : StatsdistlaplaceModel, i : Int, v : Double) -> StatsdistlaplaceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceModel::sum(self : StatsdistlaplaceModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceModel::mean(self : StatsdistlaplaceModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceModel::scale(self : StatsdistlaplaceModel, f : Double) -> StatsdistlaplaceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceModel::add(self : StatsdistlaplaceModel, other : StatsdistlaplaceModel) -> StatsdistlaplaceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceModel::copy(self : StatsdistlaplaceModel) -> StatsdistlaplaceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceModel::fill(self : StatsdistlaplaceModel, v : Double) -> StatsdistlaplaceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceModel::min(self : StatsdistlaplaceModel) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceModel::max(self : StatsdistlaplaceModel) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceModel::to_string(self : StatsdistlaplaceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_layer_make(size : Int) -> StatsdistlaplaceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceLayer::len(self : StatsdistlaplaceLayer) -> Int { self.size }

pub fn StatsdistlaplaceLayer::get(self : StatsdistlaplaceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceLayer::set(self : StatsdistlaplaceLayer, i : Int, v : Double) -> StatsdistlaplaceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceLayer::sum(self : StatsdistlaplaceLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceLayer::mean(self : StatsdistlaplaceLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceLayer::scale(self : StatsdistlaplaceLayer, f : Double) -> StatsdistlaplaceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceLayer::add(self : StatsdistlaplaceLayer, other : StatsdistlaplaceLayer) -> StatsdistlaplaceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceLayer::copy(self : StatsdistlaplaceLayer) -> StatsdistlaplaceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceLayer::fill(self : StatsdistlaplaceLayer, v : Double) -> StatsdistlaplaceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceLayer::min(self : StatsdistlaplaceLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceLayer::max(self : StatsdistlaplaceLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceLayer::to_string(self : StatsdistlaplaceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_buffer_make(size : Int) -> StatsdistlaplaceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceBuffer::len(self : StatsdistlaplaceBuffer) -> Int { self.size }

pub fn StatsdistlaplaceBuffer::get(self : StatsdistlaplaceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceBuffer::set(self : StatsdistlaplaceBuffer, i : Int, v : Double) -> StatsdistlaplaceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceBuffer::sum(self : StatsdistlaplaceBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceBuffer::mean(self : StatsdistlaplaceBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceBuffer::scale(self : StatsdistlaplaceBuffer, f : Double) -> StatsdistlaplaceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceBuffer::add(self : StatsdistlaplaceBuffer, other : StatsdistlaplaceBuffer) -> StatsdistlaplaceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceBuffer::copy(self : StatsdistlaplaceBuffer) -> StatsdistlaplaceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceBuffer::fill(self : StatsdistlaplaceBuffer, v : Double) -> StatsdistlaplaceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceBuffer::min(self : StatsdistlaplaceBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceBuffer::max(self : StatsdistlaplaceBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceBuffer::to_string(self : StatsdistlaplaceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_cursor_make(size : Int) -> StatsdistlaplaceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceCursor::len(self : StatsdistlaplaceCursor) -> Int { self.size }

pub fn StatsdistlaplaceCursor::get(self : StatsdistlaplaceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceCursor::set(self : StatsdistlaplaceCursor, i : Int, v : Double) -> StatsdistlaplaceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceCursor::sum(self : StatsdistlaplaceCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceCursor::mean(self : StatsdistlaplaceCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceCursor::scale(self : StatsdistlaplaceCursor, f : Double) -> StatsdistlaplaceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceCursor::add(self : StatsdistlaplaceCursor, other : StatsdistlaplaceCursor) -> StatsdistlaplaceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceCursor::copy(self : StatsdistlaplaceCursor) -> StatsdistlaplaceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceCursor::fill(self : StatsdistlaplaceCursor, v : Double) -> StatsdistlaplaceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceCursor::min(self : StatsdistlaplaceCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceCursor::max(self : StatsdistlaplaceCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceCursor::to_string(self : StatsdistlaplaceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_view_make(size : Int) -> StatsdistlaplaceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceView::len(self : StatsdistlaplaceView) -> Int { self.size }

pub fn StatsdistlaplaceView::get(self : StatsdistlaplaceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceView::set(self : StatsdistlaplaceView, i : Int, v : Double) -> StatsdistlaplaceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceView::sum(self : StatsdistlaplaceView) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceView::mean(self : StatsdistlaplaceView) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceView::scale(self : StatsdistlaplaceView, f : Double) -> StatsdistlaplaceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceView::add(self : StatsdistlaplaceView, other : StatsdistlaplaceView) -> StatsdistlaplaceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceView::copy(self : StatsdistlaplaceView) -> StatsdistlaplaceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceView::fill(self : StatsdistlaplaceView, v : Double) -> StatsdistlaplaceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceView::min(self : StatsdistlaplaceView) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceView::max(self : StatsdistlaplaceView) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceView::to_string(self : StatsdistlaplaceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_range_make(size : Int) -> StatsdistlaplaceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceRange::len(self : StatsdistlaplaceRange) -> Int { self.size }

pub fn StatsdistlaplaceRange::get(self : StatsdistlaplaceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceRange::set(self : StatsdistlaplaceRange, i : Int, v : Double) -> StatsdistlaplaceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceRange::sum(self : StatsdistlaplaceRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceRange::mean(self : StatsdistlaplaceRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceRange::scale(self : StatsdistlaplaceRange, f : Double) -> StatsdistlaplaceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceRange::add(self : StatsdistlaplaceRange, other : StatsdistlaplaceRange) -> StatsdistlaplaceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceRange::copy(self : StatsdistlaplaceRange) -> StatsdistlaplaceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceRange::fill(self : StatsdistlaplaceRange, v : Double) -> StatsdistlaplaceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceRange::min(self : StatsdistlaplaceRange) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceRange::max(self : StatsdistlaplaceRange) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceRange::to_string(self : StatsdistlaplaceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_slice_make(size : Int) -> StatsdistlaplaceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlaplaceSlice::len(self : StatsdistlaplaceSlice) -> Int { self.size }

pub fn StatsdistlaplaceSlice::get(self : StatsdistlaplaceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlaplaceSlice::set(self : StatsdistlaplaceSlice, i : Int, v : Double) -> StatsdistlaplaceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceSlice::sum(self : StatsdistlaplaceSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistlaplaceSlice::mean(self : StatsdistlaplaceSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistlaplaceSlice::scale(self : StatsdistlaplaceSlice, f : Double) -> StatsdistlaplaceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceSlice::add(self : StatsdistlaplaceSlice, other : StatsdistlaplaceSlice) -> StatsdistlaplaceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlaplaceSlice::copy(self : StatsdistlaplaceSlice) -> StatsdistlaplaceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceSlice::fill(self : StatsdistlaplaceSlice, v : Double) -> StatsdistlaplaceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlaplaceSlice::min(self : StatsdistlaplaceSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistlaplaceSlice::max(self : StatsdistlaplaceSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistlaplaceSlice::to_string(self : StatsdistlaplaceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

