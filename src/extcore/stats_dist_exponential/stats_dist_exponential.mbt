///===
/// extcore/stats_dist_exponential

pub(all) struct StatsdistexponentialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_exponential_make_point(x : Double, y : Double) -> StatsdistexponentialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_exponential_make_point3(x : Double, y : Double, z : Double) -> StatsdistexponentialPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistexponentialPoint::x(self : StatsdistexponentialPoint) -> Double { self.x }

pub fn StatsdistexponentialPoint::y(self : StatsdistexponentialPoint) -> Double { self.y }

pub fn StatsdistexponentialPoint::z(self : StatsdistexponentialPoint) -> Double { self.z }

pub fn StatsdistexponentialPoint::label(self : StatsdistexponentialPoint) -> Int { self.label }

pub fn StatsdistexponentialPoint::dist(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistexponentialPoint::add(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistexponentialPoint::sub(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistexponentialPoint::scale(self : StatsdistexponentialPoint, s : Double) -> StatsdistexponentialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistexponentialPoint::dot(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistexponentialPoint::cross(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistexponentialPoint::norm(self : StatsdistexponentialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistexponentialPoint::normalize(self : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistexponentialPoint::negate(self : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistexponentialPoint::mid(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistexponentialPoint::lerp(self : StatsdistexponentialPoint, other : StatsdistexponentialPoint, t : Double) -> StatsdistexponentialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistexponentialPoint::to_string(self : StatsdistexponentialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistexponentialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_exponential_make_series(vals : Array[Double], name : String) -> StatsdistexponentialSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistexponentialSeries::len(self : StatsdistexponentialSeries) -> Int { self.vals.length() }

pub fn StatsdistexponentialSeries::sum(self : StatsdistexponentialSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistexponentialSeries::mean(self : StatsdistexponentialSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistexponentialSeries::min(self : StatsdistexponentialSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistexponentialSeries::max(self : StatsdistexponentialSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistexponentialSeries::range(self : StatsdistexponentialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistexponentialSeries::variance(self : StatsdistexponentialSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistexponentialSeries::std(self : StatsdistexponentialSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistexponentialSeries::median(self : StatsdistexponentialSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistexponentialSeries::scale(self : StatsdistexponentialSeries, f : Double) -> StatsdistexponentialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistexponentialSeries::add(self : StatsdistexponentialSeries, other : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistexponentialSeries::sub(self : StatsdistexponentialSeries, other : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistexponentialSeries::normalize(self : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistexponentialSeries::cumsum(self : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistexponentialSeries::to_string(self : StatsdistexponentialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistexponentialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_exponential_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistexponentialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_exponential_matrix_identity(n : Int) -> StatsdistexponentialMatrix {
  let m = stats_dist_exponential_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistexponentialMatrix::get(self : StatsdistexponentialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistexponentialMatrix::transpose(self : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  let result = stats_dist_exponential_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistexponentialMatrix::add(self : StatsdistexponentialMatrix, other : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_exponential_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistexponentialMatrix::scale(self : StatsdistexponentialMatrix, s : Double) -> StatsdistexponentialMatrix {
  let result = stats_dist_exponential_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistexponentialMatrix::multiply(self : StatsdistexponentialMatrix, other : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  if self.cols != other.rows { return stats_dist_exponential_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_exponential_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsdistexponentialMatrix::trace(self : StatsdistexponentialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistexponentialMatrix::det(self : StatsdistexponentialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistexponentialMatrix::norm(self : StatsdistexponentialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistexponentialMatrix::to_string(self : StatsdistexponentialMatrix) -> String {
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

pub(all) struct StatsdistexponentialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_exponential_make_vector(comps : Array[Double]) -> StatsdistexponentialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_exponential_vector_zero(dim : Int) -> StatsdistexponentialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistexponentialVector::add(self : StatsdistexponentialVector, other : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistexponentialVector::sub(self : StatsdistexponentialVector, other : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistexponentialVector::scale(self : StatsdistexponentialVector, s : Double) -> StatsdistexponentialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistexponentialVector::dot(self : StatsdistexponentialVector, other : StatsdistexponentialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistexponentialVector::norm(self : StatsdistexponentialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistexponentialVector::normalize(self : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistexponentialVector::dist(self : StatsdistexponentialVector, other : StatsdistexponentialVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistexponentialVector::to_string(self : StatsdistexponentialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistexponentialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_frame_make(size : Int) -> StatsdistexponentialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialFrame::len(self : StatsdistexponentialFrame) -> Int { self.size }

pub fn StatsdistexponentialFrame::get(self : StatsdistexponentialFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialFrame::set(self : StatsdistexponentialFrame, i : Int, v : Double) -> StatsdistexponentialFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialFrame::sum(self : StatsdistexponentialFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialFrame::mean(self : StatsdistexponentialFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialFrame::scale(self : StatsdistexponentialFrame, f : Double) -> StatsdistexponentialFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialFrame::add(self : StatsdistexponentialFrame, other : StatsdistexponentialFrame) -> StatsdistexponentialFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialFrame::copy(self : StatsdistexponentialFrame) -> StatsdistexponentialFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialFrame::fill(self : StatsdistexponentialFrame, v : Double) -> StatsdistexponentialFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialFrame::min(self : StatsdistexponentialFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialFrame::max(self : StatsdistexponentialFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialFrame::to_string(self : StatsdistexponentialFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_table_make(size : Int) -> StatsdistexponentialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialTable::len(self : StatsdistexponentialTable) -> Int { self.size }

pub fn StatsdistexponentialTable::get(self : StatsdistexponentialTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialTable::set(self : StatsdistexponentialTable, i : Int, v : Double) -> StatsdistexponentialTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialTable::sum(self : StatsdistexponentialTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialTable::mean(self : StatsdistexponentialTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialTable::scale(self : StatsdistexponentialTable, f : Double) -> StatsdistexponentialTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialTable::add(self : StatsdistexponentialTable, other : StatsdistexponentialTable) -> StatsdistexponentialTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialTable::copy(self : StatsdistexponentialTable) -> StatsdistexponentialTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialTable::fill(self : StatsdistexponentialTable, v : Double) -> StatsdistexponentialTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialTable::min(self : StatsdistexponentialTable) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialTable::max(self : StatsdistexponentialTable) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialTable::to_string(self : StatsdistexponentialTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_graphn_make(size : Int) -> StatsdistexponentialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialGraphN::len(self : StatsdistexponentialGraphN) -> Int { self.size }

pub fn StatsdistexponentialGraphN::get(self : StatsdistexponentialGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialGraphN::set(self : StatsdistexponentialGraphN, i : Int, v : Double) -> StatsdistexponentialGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialGraphN::sum(self : StatsdistexponentialGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialGraphN::mean(self : StatsdistexponentialGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialGraphN::scale(self : StatsdistexponentialGraphN, f : Double) -> StatsdistexponentialGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialGraphN::add(self : StatsdistexponentialGraphN, other : StatsdistexponentialGraphN) -> StatsdistexponentialGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialGraphN::copy(self : StatsdistexponentialGraphN) -> StatsdistexponentialGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialGraphN::fill(self : StatsdistexponentialGraphN, v : Double) -> StatsdistexponentialGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialGraphN::min(self : StatsdistexponentialGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialGraphN::max(self : StatsdistexponentialGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialGraphN::to_string(self : StatsdistexponentialGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_node_make(size : Int) -> StatsdistexponentialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialNode::len(self : StatsdistexponentialNode) -> Int { self.size }

pub fn StatsdistexponentialNode::get(self : StatsdistexponentialNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialNode::set(self : StatsdistexponentialNode, i : Int, v : Double) -> StatsdistexponentialNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialNode::sum(self : StatsdistexponentialNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialNode::mean(self : StatsdistexponentialNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialNode::scale(self : StatsdistexponentialNode, f : Double) -> StatsdistexponentialNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialNode::add(self : StatsdistexponentialNode, other : StatsdistexponentialNode) -> StatsdistexponentialNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialNode::copy(self : StatsdistexponentialNode) -> StatsdistexponentialNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialNode::fill(self : StatsdistexponentialNode, v : Double) -> StatsdistexponentialNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialNode::min(self : StatsdistexponentialNode) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialNode::max(self : StatsdistexponentialNode) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialNode::to_string(self : StatsdistexponentialNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_edge_make(size : Int) -> StatsdistexponentialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialEdge::len(self : StatsdistexponentialEdge) -> Int { self.size }

pub fn StatsdistexponentialEdge::get(self : StatsdistexponentialEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialEdge::set(self : StatsdistexponentialEdge, i : Int, v : Double) -> StatsdistexponentialEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialEdge::sum(self : StatsdistexponentialEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialEdge::mean(self : StatsdistexponentialEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialEdge::scale(self : StatsdistexponentialEdge, f : Double) -> StatsdistexponentialEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialEdge::add(self : StatsdistexponentialEdge, other : StatsdistexponentialEdge) -> StatsdistexponentialEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialEdge::copy(self : StatsdistexponentialEdge) -> StatsdistexponentialEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialEdge::fill(self : StatsdistexponentialEdge, v : Double) -> StatsdistexponentialEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialEdge::min(self : StatsdistexponentialEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialEdge::max(self : StatsdistexponentialEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialEdge::to_string(self : StatsdistexponentialEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_path_make(size : Int) -> StatsdistexponentialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialPath::len(self : StatsdistexponentialPath) -> Int { self.size }

pub fn StatsdistexponentialPath::get(self : StatsdistexponentialPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialPath::set(self : StatsdistexponentialPath, i : Int, v : Double) -> StatsdistexponentialPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialPath::sum(self : StatsdistexponentialPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialPath::mean(self : StatsdistexponentialPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialPath::scale(self : StatsdistexponentialPath, f : Double) -> StatsdistexponentialPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialPath::add(self : StatsdistexponentialPath, other : StatsdistexponentialPath) -> StatsdistexponentialPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialPath::copy(self : StatsdistexponentialPath) -> StatsdistexponentialPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialPath::fill(self : StatsdistexponentialPath, v : Double) -> StatsdistexponentialPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialPath::min(self : StatsdistexponentialPath) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialPath::max(self : StatsdistexponentialPath) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialPath::to_string(self : StatsdistexponentialPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_cluster_make(size : Int) -> StatsdistexponentialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialCluster::len(self : StatsdistexponentialCluster) -> Int { self.size }

pub fn StatsdistexponentialCluster::get(self : StatsdistexponentialCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialCluster::set(self : StatsdistexponentialCluster, i : Int, v : Double) -> StatsdistexponentialCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialCluster::sum(self : StatsdistexponentialCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialCluster::mean(self : StatsdistexponentialCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialCluster::scale(self : StatsdistexponentialCluster, f : Double) -> StatsdistexponentialCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialCluster::add(self : StatsdistexponentialCluster, other : StatsdistexponentialCluster) -> StatsdistexponentialCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialCluster::copy(self : StatsdistexponentialCluster) -> StatsdistexponentialCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialCluster::fill(self : StatsdistexponentialCluster, v : Double) -> StatsdistexponentialCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialCluster::min(self : StatsdistexponentialCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialCluster::max(self : StatsdistexponentialCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialCluster::to_string(self : StatsdistexponentialCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_model_make(size : Int) -> StatsdistexponentialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialModel::len(self : StatsdistexponentialModel) -> Int { self.size }

pub fn StatsdistexponentialModel::get(self : StatsdistexponentialModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialModel::set(self : StatsdistexponentialModel, i : Int, v : Double) -> StatsdistexponentialModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialModel::sum(self : StatsdistexponentialModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialModel::mean(self : StatsdistexponentialModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialModel::scale(self : StatsdistexponentialModel, f : Double) -> StatsdistexponentialModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialModel::add(self : StatsdistexponentialModel, other : StatsdistexponentialModel) -> StatsdistexponentialModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialModel::copy(self : StatsdistexponentialModel) -> StatsdistexponentialModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialModel::fill(self : StatsdistexponentialModel, v : Double) -> StatsdistexponentialModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialModel::min(self : StatsdistexponentialModel) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialModel::max(self : StatsdistexponentialModel) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialModel::to_string(self : StatsdistexponentialModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_layer_make(size : Int) -> StatsdistexponentialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialLayer::len(self : StatsdistexponentialLayer) -> Int { self.size }

pub fn StatsdistexponentialLayer::get(self : StatsdistexponentialLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialLayer::set(self : StatsdistexponentialLayer, i : Int, v : Double) -> StatsdistexponentialLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialLayer::sum(self : StatsdistexponentialLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialLayer::mean(self : StatsdistexponentialLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialLayer::scale(self : StatsdistexponentialLayer, f : Double) -> StatsdistexponentialLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialLayer::add(self : StatsdistexponentialLayer, other : StatsdistexponentialLayer) -> StatsdistexponentialLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialLayer::copy(self : StatsdistexponentialLayer) -> StatsdistexponentialLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialLayer::fill(self : StatsdistexponentialLayer, v : Double) -> StatsdistexponentialLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialLayer::min(self : StatsdistexponentialLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialLayer::max(self : StatsdistexponentialLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialLayer::to_string(self : StatsdistexponentialLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_buffer_make(size : Int) -> StatsdistexponentialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialBuffer::len(self : StatsdistexponentialBuffer) -> Int { self.size }

pub fn StatsdistexponentialBuffer::get(self : StatsdistexponentialBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialBuffer::set(self : StatsdistexponentialBuffer, i : Int, v : Double) -> StatsdistexponentialBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialBuffer::sum(self : StatsdistexponentialBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialBuffer::mean(self : StatsdistexponentialBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialBuffer::scale(self : StatsdistexponentialBuffer, f : Double) -> StatsdistexponentialBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialBuffer::add(self : StatsdistexponentialBuffer, other : StatsdistexponentialBuffer) -> StatsdistexponentialBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialBuffer::copy(self : StatsdistexponentialBuffer) -> StatsdistexponentialBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialBuffer::fill(self : StatsdistexponentialBuffer, v : Double) -> StatsdistexponentialBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialBuffer::min(self : StatsdistexponentialBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialBuffer::max(self : StatsdistexponentialBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialBuffer::to_string(self : StatsdistexponentialBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_cursor_make(size : Int) -> StatsdistexponentialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialCursor::len(self : StatsdistexponentialCursor) -> Int { self.size }

pub fn StatsdistexponentialCursor::get(self : StatsdistexponentialCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialCursor::set(self : StatsdistexponentialCursor, i : Int, v : Double) -> StatsdistexponentialCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialCursor::sum(self : StatsdistexponentialCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialCursor::mean(self : StatsdistexponentialCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialCursor::scale(self : StatsdistexponentialCursor, f : Double) -> StatsdistexponentialCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialCursor::add(self : StatsdistexponentialCursor, other : StatsdistexponentialCursor) -> StatsdistexponentialCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialCursor::copy(self : StatsdistexponentialCursor) -> StatsdistexponentialCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialCursor::fill(self : StatsdistexponentialCursor, v : Double) -> StatsdistexponentialCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialCursor::min(self : StatsdistexponentialCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialCursor::max(self : StatsdistexponentialCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialCursor::to_string(self : StatsdistexponentialCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_view_make(size : Int) -> StatsdistexponentialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialView::len(self : StatsdistexponentialView) -> Int { self.size }

pub fn StatsdistexponentialView::get(self : StatsdistexponentialView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialView::set(self : StatsdistexponentialView, i : Int, v : Double) -> StatsdistexponentialView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialView::sum(self : StatsdistexponentialView) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialView::mean(self : StatsdistexponentialView) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialView::scale(self : StatsdistexponentialView, f : Double) -> StatsdistexponentialView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialView::add(self : StatsdistexponentialView, other : StatsdistexponentialView) -> StatsdistexponentialView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialView::copy(self : StatsdistexponentialView) -> StatsdistexponentialView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialView::fill(self : StatsdistexponentialView, v : Double) -> StatsdistexponentialView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialView::min(self : StatsdistexponentialView) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialView::max(self : StatsdistexponentialView) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialView::to_string(self : StatsdistexponentialView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_range_make(size : Int) -> StatsdistexponentialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialRange::len(self : StatsdistexponentialRange) -> Int { self.size }

pub fn StatsdistexponentialRange::get(self : StatsdistexponentialRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialRange::set(self : StatsdistexponentialRange, i : Int, v : Double) -> StatsdistexponentialRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialRange::sum(self : StatsdistexponentialRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialRange::mean(self : StatsdistexponentialRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialRange::scale(self : StatsdistexponentialRange, f : Double) -> StatsdistexponentialRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialRange::add(self : StatsdistexponentialRange, other : StatsdistexponentialRange) -> StatsdistexponentialRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialRange::copy(self : StatsdistexponentialRange) -> StatsdistexponentialRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialRange::fill(self : StatsdistexponentialRange, v : Double) -> StatsdistexponentialRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialRange::min(self : StatsdistexponentialRange) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialRange::max(self : StatsdistexponentialRange) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialRange::to_string(self : StatsdistexponentialRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_slice_make(size : Int) -> StatsdistexponentialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistexponentialSlice::len(self : StatsdistexponentialSlice) -> Int { self.size }

pub fn StatsdistexponentialSlice::get(self : StatsdistexponentialSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistexponentialSlice::set(self : StatsdistexponentialSlice, i : Int, v : Double) -> StatsdistexponentialSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialSlice::sum(self : StatsdistexponentialSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistexponentialSlice::mean(self : StatsdistexponentialSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistexponentialSlice::scale(self : StatsdistexponentialSlice, f : Double) -> StatsdistexponentialSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialSlice::add(self : StatsdistexponentialSlice, other : StatsdistexponentialSlice) -> StatsdistexponentialSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistexponentialSlice::copy(self : StatsdistexponentialSlice) -> StatsdistexponentialSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialSlice::fill(self : StatsdistexponentialSlice, v : Double) -> StatsdistexponentialSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistexponentialSlice::min(self : StatsdistexponentialSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistexponentialSlice::max(self : StatsdistexponentialSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistexponentialSlice::to_string(self : StatsdistexponentialSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

