///===
/// extcore/stats_model_mixed

pub(all) struct StatsmodelmixedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_mixed_make_point(x : Double, y : Double) -> StatsmodelmixedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_mixed_make_point3(x : Double, y : Double, z : Double) -> StatsmodelmixedPoint {
  { x, y, z, label: 0 }
}

pub fn StatsmodelmixedPoint::x(self : StatsmodelmixedPoint) -> Double { self.x }

pub fn StatsmodelmixedPoint::y(self : StatsmodelmixedPoint) -> Double { self.y }

pub fn StatsmodelmixedPoint::z(self : StatsmodelmixedPoint) -> Double { self.z }

pub fn StatsmodelmixedPoint::label(self : StatsmodelmixedPoint) -> Int { self.label }

pub fn StatsmodelmixedPoint::dist(self : StatsmodelmixedPoint, other : StatsmodelmixedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsmodelmixedPoint::add(self : StatsmodelmixedPoint, other : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsmodelmixedPoint::sub(self : StatsmodelmixedPoint, other : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsmodelmixedPoint::scale(self : StatsmodelmixedPoint, s : Double) -> StatsmodelmixedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsmodelmixedPoint::dot(self : StatsmodelmixedPoint, other : StatsmodelmixedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsmodelmixedPoint::cross(self : StatsmodelmixedPoint, other : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsmodelmixedPoint::norm(self : StatsmodelmixedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsmodelmixedPoint::normalize(self : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodelmixedPoint::negate(self : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsmodelmixedPoint::mid(self : StatsmodelmixedPoint, other : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsmodelmixedPoint::lerp(self : StatsmodelmixedPoint, other : StatsmodelmixedPoint, t : Double) -> StatsmodelmixedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsmodelmixedPoint::to_string(self : StatsmodelmixedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsmodelmixedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_mixed_make_series(vals : Array[Double], name : String) -> StatsmodelmixedSeries {
  { vals, name, meta: 0 }
}

pub fn StatsmodelmixedSeries::len(self : StatsmodelmixedSeries) -> Int { self.vals.length() }

pub fn StatsmodelmixedSeries::sum(self : StatsmodelmixedSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsmodelmixedSeries::mean(self : StatsmodelmixedSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsmodelmixedSeries::min(self : StatsmodelmixedSeries) -> Double { @_common.min(self.vals) }

pub fn StatsmodelmixedSeries::max(self : StatsmodelmixedSeries) -> Double { @_common.max(self.vals) }

pub fn StatsmodelmixedSeries::range(self : StatsmodelmixedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsmodelmixedSeries::variance(self : StatsmodelmixedSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsmodelmixedSeries::std(self : StatsmodelmixedSeries) -> Double { @_common.std(self.vals) }

pub fn StatsmodelmixedSeries::median(self : StatsmodelmixedSeries) -> Double { @_common.median(self.vals) }

pub fn StatsmodelmixedSeries::scale(self : StatsmodelmixedSeries, f : Double) -> StatsmodelmixedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsmodelmixedSeries::add(self : StatsmodelmixedSeries, other : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsmodelmixedSeries::sub(self : StatsmodelmixedSeries, other : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsmodelmixedSeries::normalize(self : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsmodelmixedSeries::cumsum(self : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsmodelmixedSeries::to_string(self : StatsmodelmixedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelmixedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_mixed_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodelmixedMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn stats_model_mixed_matrix_identity(n : Int) -> StatsmodelmixedMatrix {
  let m = stats_model_mixed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsmodelmixedMatrix::get(self : StatsmodelmixedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsmodelmixedMatrix::transpose(self : StatsmodelmixedMatrix) -> StatsmodelmixedMatrix {
  let result = stats_model_mixed_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsmodelmixedMatrix::add(self : StatsmodelmixedMatrix, other : StatsmodelmixedMatrix) -> StatsmodelmixedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_model_mixed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsmodelmixedMatrix::scale(self : StatsmodelmixedMatrix, s : Double) -> StatsmodelmixedMatrix {
  let result = stats_model_mixed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsmodelmixedMatrix::multiply(self : StatsmodelmixedMatrix, other : StatsmodelmixedMatrix) -> StatsmodelmixedMatrix {
  if self.cols != other.rows { return stats_model_mixed_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_model_mixed_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsmodelmixedMatrix::trace(self : StatsmodelmixedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsmodelmixedMatrix::det(self : StatsmodelmixedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsmodelmixedMatrix::norm(self : StatsmodelmixedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsmodelmixedMatrix::to_string(self : StatsmodelmixedMatrix) -> String {
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

pub(all) struct StatsmodelmixedVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_mixed_make_vector(comps : Array[Double]) -> StatsmodelmixedVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_mixed_vector_zero(dim : Int) -> StatsmodelmixedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsmodelmixedVector::add(self : StatsmodelmixedVector, other : StatsmodelmixedVector) -> StatsmodelmixedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodelmixedVector::sub(self : StatsmodelmixedVector, other : StatsmodelmixedVector) -> StatsmodelmixedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodelmixedVector::scale(self : StatsmodelmixedVector, s : Double) -> StatsmodelmixedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsmodelmixedVector::dot(self : StatsmodelmixedVector, other : StatsmodelmixedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsmodelmixedVector::norm(self : StatsmodelmixedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsmodelmixedVector::normalize(self : StatsmodelmixedVector) -> StatsmodelmixedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodelmixedVector::dist(self : StatsmodelmixedVector, other : StatsmodelmixedVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsmodelmixedVector::to_string(self : StatsmodelmixedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelmixedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_frame_make(size : Int) -> StatsmodelmixedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedFrame::len(self : StatsmodelmixedFrame) -> Int { self.size }

pub fn StatsmodelmixedFrame::get(self : StatsmodelmixedFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedFrame::set(self : StatsmodelmixedFrame, i : Int, v : Double) -> StatsmodelmixedFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedFrame::sum(self : StatsmodelmixedFrame) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedFrame::mean(self : StatsmodelmixedFrame) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedFrame::scale(self : StatsmodelmixedFrame, f : Double) -> StatsmodelmixedFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedFrame::add(self : StatsmodelmixedFrame, other : StatsmodelmixedFrame) -> StatsmodelmixedFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedFrame::copy(self : StatsmodelmixedFrame) -> StatsmodelmixedFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedFrame::fill(self : StatsmodelmixedFrame, v : Double) -> StatsmodelmixedFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedFrame::min(self : StatsmodelmixedFrame) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedFrame::max(self : StatsmodelmixedFrame) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedFrame::to_string(self : StatsmodelmixedFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_table_make(size : Int) -> StatsmodelmixedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedTable::len(self : StatsmodelmixedTable) -> Int { self.size }

pub fn StatsmodelmixedTable::get(self : StatsmodelmixedTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedTable::set(self : StatsmodelmixedTable, i : Int, v : Double) -> StatsmodelmixedTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedTable::sum(self : StatsmodelmixedTable) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedTable::mean(self : StatsmodelmixedTable) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedTable::scale(self : StatsmodelmixedTable, f : Double) -> StatsmodelmixedTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedTable::add(self : StatsmodelmixedTable, other : StatsmodelmixedTable) -> StatsmodelmixedTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedTable::copy(self : StatsmodelmixedTable) -> StatsmodelmixedTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedTable::fill(self : StatsmodelmixedTable, v : Double) -> StatsmodelmixedTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedTable::min(self : StatsmodelmixedTable) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedTable::max(self : StatsmodelmixedTable) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedTable::to_string(self : StatsmodelmixedTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_graphn_make(size : Int) -> StatsmodelmixedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedGraphN::len(self : StatsmodelmixedGraphN) -> Int { self.size }

pub fn StatsmodelmixedGraphN::get(self : StatsmodelmixedGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedGraphN::set(self : StatsmodelmixedGraphN, i : Int, v : Double) -> StatsmodelmixedGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedGraphN::sum(self : StatsmodelmixedGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedGraphN::mean(self : StatsmodelmixedGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedGraphN::scale(self : StatsmodelmixedGraphN, f : Double) -> StatsmodelmixedGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedGraphN::add(self : StatsmodelmixedGraphN, other : StatsmodelmixedGraphN) -> StatsmodelmixedGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedGraphN::copy(self : StatsmodelmixedGraphN) -> StatsmodelmixedGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedGraphN::fill(self : StatsmodelmixedGraphN, v : Double) -> StatsmodelmixedGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedGraphN::min(self : StatsmodelmixedGraphN) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedGraphN::max(self : StatsmodelmixedGraphN) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedGraphN::to_string(self : StatsmodelmixedGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_node_make(size : Int) -> StatsmodelmixedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedNode::len(self : StatsmodelmixedNode) -> Int { self.size }

pub fn StatsmodelmixedNode::get(self : StatsmodelmixedNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedNode::set(self : StatsmodelmixedNode, i : Int, v : Double) -> StatsmodelmixedNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedNode::sum(self : StatsmodelmixedNode) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedNode::mean(self : StatsmodelmixedNode) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedNode::scale(self : StatsmodelmixedNode, f : Double) -> StatsmodelmixedNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedNode::add(self : StatsmodelmixedNode, other : StatsmodelmixedNode) -> StatsmodelmixedNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedNode::copy(self : StatsmodelmixedNode) -> StatsmodelmixedNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedNode::fill(self : StatsmodelmixedNode, v : Double) -> StatsmodelmixedNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedNode::min(self : StatsmodelmixedNode) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedNode::max(self : StatsmodelmixedNode) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedNode::to_string(self : StatsmodelmixedNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_edge_make(size : Int) -> StatsmodelmixedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedEdge::len(self : StatsmodelmixedEdge) -> Int { self.size }

pub fn StatsmodelmixedEdge::get(self : StatsmodelmixedEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedEdge::set(self : StatsmodelmixedEdge, i : Int, v : Double) -> StatsmodelmixedEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedEdge::sum(self : StatsmodelmixedEdge) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedEdge::mean(self : StatsmodelmixedEdge) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedEdge::scale(self : StatsmodelmixedEdge, f : Double) -> StatsmodelmixedEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedEdge::add(self : StatsmodelmixedEdge, other : StatsmodelmixedEdge) -> StatsmodelmixedEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedEdge::copy(self : StatsmodelmixedEdge) -> StatsmodelmixedEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedEdge::fill(self : StatsmodelmixedEdge, v : Double) -> StatsmodelmixedEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedEdge::min(self : StatsmodelmixedEdge) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedEdge::max(self : StatsmodelmixedEdge) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedEdge::to_string(self : StatsmodelmixedEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_path_make(size : Int) -> StatsmodelmixedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedPath::len(self : StatsmodelmixedPath) -> Int { self.size }

pub fn StatsmodelmixedPath::get(self : StatsmodelmixedPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedPath::set(self : StatsmodelmixedPath, i : Int, v : Double) -> StatsmodelmixedPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedPath::sum(self : StatsmodelmixedPath) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedPath::mean(self : StatsmodelmixedPath) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedPath::scale(self : StatsmodelmixedPath, f : Double) -> StatsmodelmixedPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedPath::add(self : StatsmodelmixedPath, other : StatsmodelmixedPath) -> StatsmodelmixedPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedPath::copy(self : StatsmodelmixedPath) -> StatsmodelmixedPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedPath::fill(self : StatsmodelmixedPath, v : Double) -> StatsmodelmixedPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedPath::min(self : StatsmodelmixedPath) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedPath::max(self : StatsmodelmixedPath) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedPath::to_string(self : StatsmodelmixedPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_cluster_make(size : Int) -> StatsmodelmixedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedCluster::len(self : StatsmodelmixedCluster) -> Int { self.size }

pub fn StatsmodelmixedCluster::get(self : StatsmodelmixedCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedCluster::set(self : StatsmodelmixedCluster, i : Int, v : Double) -> StatsmodelmixedCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedCluster::sum(self : StatsmodelmixedCluster) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedCluster::mean(self : StatsmodelmixedCluster) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedCluster::scale(self : StatsmodelmixedCluster, f : Double) -> StatsmodelmixedCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedCluster::add(self : StatsmodelmixedCluster, other : StatsmodelmixedCluster) -> StatsmodelmixedCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedCluster::copy(self : StatsmodelmixedCluster) -> StatsmodelmixedCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedCluster::fill(self : StatsmodelmixedCluster, v : Double) -> StatsmodelmixedCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedCluster::min(self : StatsmodelmixedCluster) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedCluster::max(self : StatsmodelmixedCluster) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedCluster::to_string(self : StatsmodelmixedCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_model_make(size : Int) -> StatsmodelmixedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedModel::len(self : StatsmodelmixedModel) -> Int { self.size }

pub fn StatsmodelmixedModel::get(self : StatsmodelmixedModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedModel::set(self : StatsmodelmixedModel, i : Int, v : Double) -> StatsmodelmixedModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedModel::sum(self : StatsmodelmixedModel) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedModel::mean(self : StatsmodelmixedModel) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedModel::scale(self : StatsmodelmixedModel, f : Double) -> StatsmodelmixedModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedModel::add(self : StatsmodelmixedModel, other : StatsmodelmixedModel) -> StatsmodelmixedModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedModel::copy(self : StatsmodelmixedModel) -> StatsmodelmixedModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedModel::fill(self : StatsmodelmixedModel, v : Double) -> StatsmodelmixedModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedModel::min(self : StatsmodelmixedModel) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedModel::max(self : StatsmodelmixedModel) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedModel::to_string(self : StatsmodelmixedModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_layer_make(size : Int) -> StatsmodelmixedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedLayer::len(self : StatsmodelmixedLayer) -> Int { self.size }

pub fn StatsmodelmixedLayer::get(self : StatsmodelmixedLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedLayer::set(self : StatsmodelmixedLayer, i : Int, v : Double) -> StatsmodelmixedLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedLayer::sum(self : StatsmodelmixedLayer) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedLayer::mean(self : StatsmodelmixedLayer) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedLayer::scale(self : StatsmodelmixedLayer, f : Double) -> StatsmodelmixedLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedLayer::add(self : StatsmodelmixedLayer, other : StatsmodelmixedLayer) -> StatsmodelmixedLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedLayer::copy(self : StatsmodelmixedLayer) -> StatsmodelmixedLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedLayer::fill(self : StatsmodelmixedLayer, v : Double) -> StatsmodelmixedLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedLayer::min(self : StatsmodelmixedLayer) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedLayer::max(self : StatsmodelmixedLayer) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedLayer::to_string(self : StatsmodelmixedLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_buffer_make(size : Int) -> StatsmodelmixedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedBuffer::len(self : StatsmodelmixedBuffer) -> Int { self.size }

pub fn StatsmodelmixedBuffer::get(self : StatsmodelmixedBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedBuffer::set(self : StatsmodelmixedBuffer, i : Int, v : Double) -> StatsmodelmixedBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedBuffer::sum(self : StatsmodelmixedBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedBuffer::mean(self : StatsmodelmixedBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedBuffer::scale(self : StatsmodelmixedBuffer, f : Double) -> StatsmodelmixedBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedBuffer::add(self : StatsmodelmixedBuffer, other : StatsmodelmixedBuffer) -> StatsmodelmixedBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedBuffer::copy(self : StatsmodelmixedBuffer) -> StatsmodelmixedBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedBuffer::fill(self : StatsmodelmixedBuffer, v : Double) -> StatsmodelmixedBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedBuffer::min(self : StatsmodelmixedBuffer) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedBuffer::max(self : StatsmodelmixedBuffer) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedBuffer::to_string(self : StatsmodelmixedBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_cursor_make(size : Int) -> StatsmodelmixedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedCursor::len(self : StatsmodelmixedCursor) -> Int { self.size }

pub fn StatsmodelmixedCursor::get(self : StatsmodelmixedCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedCursor::set(self : StatsmodelmixedCursor, i : Int, v : Double) -> StatsmodelmixedCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedCursor::sum(self : StatsmodelmixedCursor) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedCursor::mean(self : StatsmodelmixedCursor) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedCursor::scale(self : StatsmodelmixedCursor, f : Double) -> StatsmodelmixedCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedCursor::add(self : StatsmodelmixedCursor, other : StatsmodelmixedCursor) -> StatsmodelmixedCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedCursor::copy(self : StatsmodelmixedCursor) -> StatsmodelmixedCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedCursor::fill(self : StatsmodelmixedCursor, v : Double) -> StatsmodelmixedCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedCursor::min(self : StatsmodelmixedCursor) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedCursor::max(self : StatsmodelmixedCursor) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedCursor::to_string(self : StatsmodelmixedCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_view_make(size : Int) -> StatsmodelmixedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedView::len(self : StatsmodelmixedView) -> Int { self.size }

pub fn StatsmodelmixedView::get(self : StatsmodelmixedView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedView::set(self : StatsmodelmixedView, i : Int, v : Double) -> StatsmodelmixedView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedView::sum(self : StatsmodelmixedView) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedView::mean(self : StatsmodelmixedView) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedView::scale(self : StatsmodelmixedView, f : Double) -> StatsmodelmixedView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedView::add(self : StatsmodelmixedView, other : StatsmodelmixedView) -> StatsmodelmixedView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedView::copy(self : StatsmodelmixedView) -> StatsmodelmixedView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedView::fill(self : StatsmodelmixedView, v : Double) -> StatsmodelmixedView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedView::min(self : StatsmodelmixedView) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedView::max(self : StatsmodelmixedView) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedView::to_string(self : StatsmodelmixedView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_range_make(size : Int) -> StatsmodelmixedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedRange::len(self : StatsmodelmixedRange) -> Int { self.size }

pub fn StatsmodelmixedRange::get(self : StatsmodelmixedRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedRange::set(self : StatsmodelmixedRange, i : Int, v : Double) -> StatsmodelmixedRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedRange::sum(self : StatsmodelmixedRange) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedRange::mean(self : StatsmodelmixedRange) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedRange::scale(self : StatsmodelmixedRange, f : Double) -> StatsmodelmixedRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedRange::add(self : StatsmodelmixedRange, other : StatsmodelmixedRange) -> StatsmodelmixedRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedRange::copy(self : StatsmodelmixedRange) -> StatsmodelmixedRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedRange::fill(self : StatsmodelmixedRange, v : Double) -> StatsmodelmixedRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedRange::min(self : StatsmodelmixedRange) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedRange::max(self : StatsmodelmixedRange) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedRange::to_string(self : StatsmodelmixedRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_slice_make(size : Int) -> StatsmodelmixedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelmixedSlice::len(self : StatsmodelmixedSlice) -> Int { self.size }

pub fn StatsmodelmixedSlice::get(self : StatsmodelmixedSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelmixedSlice::set(self : StatsmodelmixedSlice, i : Int, v : Double) -> StatsmodelmixedSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedSlice::sum(self : StatsmodelmixedSlice) -> Double { @_common.sum(self.data) }

pub fn StatsmodelmixedSlice::mean(self : StatsmodelmixedSlice) -> Double { @_common.mean(self.data) }

pub fn StatsmodelmixedSlice::scale(self : StatsmodelmixedSlice, f : Double) -> StatsmodelmixedSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedSlice::add(self : StatsmodelmixedSlice, other : StatsmodelmixedSlice) -> StatsmodelmixedSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelmixedSlice::copy(self : StatsmodelmixedSlice) -> StatsmodelmixedSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedSlice::fill(self : StatsmodelmixedSlice, v : Double) -> StatsmodelmixedSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelmixedSlice::min(self : StatsmodelmixedSlice) -> Double { @_common.min(self.data) }

pub fn StatsmodelmixedSlice::max(self : StatsmodelmixedSlice) -> Double { @_common.max(self.data) }

pub fn StatsmodelmixedSlice::to_string(self : StatsmodelmixedSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

