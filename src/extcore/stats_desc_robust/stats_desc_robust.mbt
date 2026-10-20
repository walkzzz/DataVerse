///===
/// extcore/stats_desc_robust

pub(all) struct StatsdescrobustPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_robust_make_point(x : Double, y : Double) -> StatsdescrobustPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_robust_make_point3(x : Double, y : Double, z : Double) -> StatsdescrobustPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdescrobustPoint::x(self : StatsdescrobustPoint) -> Double { self.x }

pub fn StatsdescrobustPoint::y(self : StatsdescrobustPoint) -> Double { self.y }

pub fn StatsdescrobustPoint::z(self : StatsdescrobustPoint) -> Double { self.z }

pub fn StatsdescrobustPoint::label(self : StatsdescrobustPoint) -> Int { self.label }

pub fn StatsdescrobustPoint::dist(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdescrobustPoint::add(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdescrobustPoint::sub(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdescrobustPoint::scale(self : StatsdescrobustPoint, s : Double) -> StatsdescrobustPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdescrobustPoint::dot(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdescrobustPoint::cross(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdescrobustPoint::norm(self : StatsdescrobustPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdescrobustPoint::normalize(self : StatsdescrobustPoint) -> StatsdescrobustPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescrobustPoint::negate(self : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdescrobustPoint::mid(self : StatsdescrobustPoint, other : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdescrobustPoint::lerp(self : StatsdescrobustPoint, other : StatsdescrobustPoint, t : Double) -> StatsdescrobustPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdescrobustPoint::to_string(self : StatsdescrobustPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdescrobustSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_robust_make_series(vals : Array[Double], name : String) -> StatsdescrobustSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdescrobustSeries::len(self : StatsdescrobustSeries) -> Int { self.vals.length() }

pub fn StatsdescrobustSeries::sum(self : StatsdescrobustSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdescrobustSeries::mean(self : StatsdescrobustSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdescrobustSeries::min(self : StatsdescrobustSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdescrobustSeries::max(self : StatsdescrobustSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdescrobustSeries::range(self : StatsdescrobustSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdescrobustSeries::variance(self : StatsdescrobustSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdescrobustSeries::std(self : StatsdescrobustSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdescrobustSeries::median(self : StatsdescrobustSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdescrobustSeries::scale(self : StatsdescrobustSeries, f : Double) -> StatsdescrobustSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdescrobustSeries::add(self : StatsdescrobustSeries, other : StatsdescrobustSeries) -> StatsdescrobustSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdescrobustSeries::sub(self : StatsdescrobustSeries, other : StatsdescrobustSeries) -> StatsdescrobustSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdescrobustSeries::normalize(self : StatsdescrobustSeries) -> StatsdescrobustSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdescrobustSeries::cumsum(self : StatsdescrobustSeries) -> StatsdescrobustSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdescrobustSeries::to_string(self : StatsdescrobustSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescrobustMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_robust_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescrobustMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn stats_desc_robust_matrix_identity(n : Int) -> StatsdescrobustMatrix {
  let m = stats_desc_robust_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdescrobustMatrix::get(self : StatsdescrobustMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdescrobustMatrix::transpose(self : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  let result = stats_desc_robust_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdescrobustMatrix::add(self : StatsdescrobustMatrix, other : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_desc_robust_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdescrobustMatrix::scale(self : StatsdescrobustMatrix, s : Double) -> StatsdescrobustMatrix {
  let result = stats_desc_robust_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdescrobustMatrix::multiply(self : StatsdescrobustMatrix, other : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  if self.cols != other.rows { return stats_desc_robust_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_desc_robust_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsdescrobustMatrix::trace(self : StatsdescrobustMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdescrobustMatrix::det(self : StatsdescrobustMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdescrobustMatrix::norm(self : StatsdescrobustMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdescrobustMatrix::to_string(self : StatsdescrobustMatrix) -> String {
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

pub(all) struct StatsdescrobustVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_robust_make_vector(comps : Array[Double]) -> StatsdescrobustVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_robust_vector_zero(dim : Int) -> StatsdescrobustVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdescrobustVector::add(self : StatsdescrobustVector, other : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescrobustVector::sub(self : StatsdescrobustVector, other : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescrobustVector::scale(self : StatsdescrobustVector, s : Double) -> StatsdescrobustVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdescrobustVector::dot(self : StatsdescrobustVector, other : StatsdescrobustVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdescrobustVector::norm(self : StatsdescrobustVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdescrobustVector::normalize(self : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescrobustVector::dist(self : StatsdescrobustVector, other : StatsdescrobustVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdescrobustVector::to_string(self : StatsdescrobustVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescrobustFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_frame_make(size : Int) -> StatsdescrobustFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustFrame::len(self : StatsdescrobustFrame) -> Int { self.size }

pub fn StatsdescrobustFrame::get(self : StatsdescrobustFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustFrame::set(self : StatsdescrobustFrame, i : Int, v : Double) -> StatsdescrobustFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustFrame::sum(self : StatsdescrobustFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustFrame::mean(self : StatsdescrobustFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustFrame::scale(self : StatsdescrobustFrame, f : Double) -> StatsdescrobustFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustFrame::add(self : StatsdescrobustFrame, other : StatsdescrobustFrame) -> StatsdescrobustFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustFrame::copy(self : StatsdescrobustFrame) -> StatsdescrobustFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustFrame::fill(self : StatsdescrobustFrame, v : Double) -> StatsdescrobustFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustFrame::min(self : StatsdescrobustFrame) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustFrame::max(self : StatsdescrobustFrame) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustFrame::to_string(self : StatsdescrobustFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_table_make(size : Int) -> StatsdescrobustTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustTable::len(self : StatsdescrobustTable) -> Int { self.size }

pub fn StatsdescrobustTable::get(self : StatsdescrobustTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustTable::set(self : StatsdescrobustTable, i : Int, v : Double) -> StatsdescrobustTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustTable::sum(self : StatsdescrobustTable) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustTable::mean(self : StatsdescrobustTable) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustTable::scale(self : StatsdescrobustTable, f : Double) -> StatsdescrobustTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustTable::add(self : StatsdescrobustTable, other : StatsdescrobustTable) -> StatsdescrobustTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustTable::copy(self : StatsdescrobustTable) -> StatsdescrobustTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustTable::fill(self : StatsdescrobustTable, v : Double) -> StatsdescrobustTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustTable::min(self : StatsdescrobustTable) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustTable::max(self : StatsdescrobustTable) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustTable::to_string(self : StatsdescrobustTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_graphn_make(size : Int) -> StatsdescrobustGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustGraphN::len(self : StatsdescrobustGraphN) -> Int { self.size }

pub fn StatsdescrobustGraphN::get(self : StatsdescrobustGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustGraphN::set(self : StatsdescrobustGraphN, i : Int, v : Double) -> StatsdescrobustGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustGraphN::sum(self : StatsdescrobustGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustGraphN::mean(self : StatsdescrobustGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustGraphN::scale(self : StatsdescrobustGraphN, f : Double) -> StatsdescrobustGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustGraphN::add(self : StatsdescrobustGraphN, other : StatsdescrobustGraphN) -> StatsdescrobustGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustGraphN::copy(self : StatsdescrobustGraphN) -> StatsdescrobustGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustGraphN::fill(self : StatsdescrobustGraphN, v : Double) -> StatsdescrobustGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustGraphN::min(self : StatsdescrobustGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustGraphN::max(self : StatsdescrobustGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustGraphN::to_string(self : StatsdescrobustGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_node_make(size : Int) -> StatsdescrobustNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustNode::len(self : StatsdescrobustNode) -> Int { self.size }

pub fn StatsdescrobustNode::get(self : StatsdescrobustNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustNode::set(self : StatsdescrobustNode, i : Int, v : Double) -> StatsdescrobustNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustNode::sum(self : StatsdescrobustNode) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustNode::mean(self : StatsdescrobustNode) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustNode::scale(self : StatsdescrobustNode, f : Double) -> StatsdescrobustNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustNode::add(self : StatsdescrobustNode, other : StatsdescrobustNode) -> StatsdescrobustNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustNode::copy(self : StatsdescrobustNode) -> StatsdescrobustNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustNode::fill(self : StatsdescrobustNode, v : Double) -> StatsdescrobustNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustNode::min(self : StatsdescrobustNode) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustNode::max(self : StatsdescrobustNode) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustNode::to_string(self : StatsdescrobustNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_edge_make(size : Int) -> StatsdescrobustEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustEdge::len(self : StatsdescrobustEdge) -> Int { self.size }

pub fn StatsdescrobustEdge::get(self : StatsdescrobustEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustEdge::set(self : StatsdescrobustEdge, i : Int, v : Double) -> StatsdescrobustEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustEdge::sum(self : StatsdescrobustEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustEdge::mean(self : StatsdescrobustEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustEdge::scale(self : StatsdescrobustEdge, f : Double) -> StatsdescrobustEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustEdge::add(self : StatsdescrobustEdge, other : StatsdescrobustEdge) -> StatsdescrobustEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustEdge::copy(self : StatsdescrobustEdge) -> StatsdescrobustEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustEdge::fill(self : StatsdescrobustEdge, v : Double) -> StatsdescrobustEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustEdge::min(self : StatsdescrobustEdge) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustEdge::max(self : StatsdescrobustEdge) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustEdge::to_string(self : StatsdescrobustEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_path_make(size : Int) -> StatsdescrobustPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustPath::len(self : StatsdescrobustPath) -> Int { self.size }

pub fn StatsdescrobustPath::get(self : StatsdescrobustPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustPath::set(self : StatsdescrobustPath, i : Int, v : Double) -> StatsdescrobustPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustPath::sum(self : StatsdescrobustPath) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustPath::mean(self : StatsdescrobustPath) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustPath::scale(self : StatsdescrobustPath, f : Double) -> StatsdescrobustPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustPath::add(self : StatsdescrobustPath, other : StatsdescrobustPath) -> StatsdescrobustPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustPath::copy(self : StatsdescrobustPath) -> StatsdescrobustPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustPath::fill(self : StatsdescrobustPath, v : Double) -> StatsdescrobustPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustPath::min(self : StatsdescrobustPath) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustPath::max(self : StatsdescrobustPath) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustPath::to_string(self : StatsdescrobustPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_cluster_make(size : Int) -> StatsdescrobustCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustCluster::len(self : StatsdescrobustCluster) -> Int { self.size }

pub fn StatsdescrobustCluster::get(self : StatsdescrobustCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustCluster::set(self : StatsdescrobustCluster, i : Int, v : Double) -> StatsdescrobustCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustCluster::sum(self : StatsdescrobustCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustCluster::mean(self : StatsdescrobustCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustCluster::scale(self : StatsdescrobustCluster, f : Double) -> StatsdescrobustCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustCluster::add(self : StatsdescrobustCluster, other : StatsdescrobustCluster) -> StatsdescrobustCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustCluster::copy(self : StatsdescrobustCluster) -> StatsdescrobustCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustCluster::fill(self : StatsdescrobustCluster, v : Double) -> StatsdescrobustCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustCluster::min(self : StatsdescrobustCluster) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustCluster::max(self : StatsdescrobustCluster) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustCluster::to_string(self : StatsdescrobustCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_model_make(size : Int) -> StatsdescrobustModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustModel::len(self : StatsdescrobustModel) -> Int { self.size }

pub fn StatsdescrobustModel::get(self : StatsdescrobustModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustModel::set(self : StatsdescrobustModel, i : Int, v : Double) -> StatsdescrobustModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustModel::sum(self : StatsdescrobustModel) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustModel::mean(self : StatsdescrobustModel) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustModel::scale(self : StatsdescrobustModel, f : Double) -> StatsdescrobustModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustModel::add(self : StatsdescrobustModel, other : StatsdescrobustModel) -> StatsdescrobustModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustModel::copy(self : StatsdescrobustModel) -> StatsdescrobustModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustModel::fill(self : StatsdescrobustModel, v : Double) -> StatsdescrobustModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustModel::min(self : StatsdescrobustModel) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustModel::max(self : StatsdescrobustModel) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustModel::to_string(self : StatsdescrobustModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_layer_make(size : Int) -> StatsdescrobustLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustLayer::len(self : StatsdescrobustLayer) -> Int { self.size }

pub fn StatsdescrobustLayer::get(self : StatsdescrobustLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustLayer::set(self : StatsdescrobustLayer, i : Int, v : Double) -> StatsdescrobustLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustLayer::sum(self : StatsdescrobustLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustLayer::mean(self : StatsdescrobustLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustLayer::scale(self : StatsdescrobustLayer, f : Double) -> StatsdescrobustLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustLayer::add(self : StatsdescrobustLayer, other : StatsdescrobustLayer) -> StatsdescrobustLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustLayer::copy(self : StatsdescrobustLayer) -> StatsdescrobustLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustLayer::fill(self : StatsdescrobustLayer, v : Double) -> StatsdescrobustLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustLayer::min(self : StatsdescrobustLayer) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustLayer::max(self : StatsdescrobustLayer) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustLayer::to_string(self : StatsdescrobustLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_buffer_make(size : Int) -> StatsdescrobustBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustBuffer::len(self : StatsdescrobustBuffer) -> Int { self.size }

pub fn StatsdescrobustBuffer::get(self : StatsdescrobustBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustBuffer::set(self : StatsdescrobustBuffer, i : Int, v : Double) -> StatsdescrobustBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustBuffer::sum(self : StatsdescrobustBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustBuffer::mean(self : StatsdescrobustBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustBuffer::scale(self : StatsdescrobustBuffer, f : Double) -> StatsdescrobustBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustBuffer::add(self : StatsdescrobustBuffer, other : StatsdescrobustBuffer) -> StatsdescrobustBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustBuffer::copy(self : StatsdescrobustBuffer) -> StatsdescrobustBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustBuffer::fill(self : StatsdescrobustBuffer, v : Double) -> StatsdescrobustBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustBuffer::min(self : StatsdescrobustBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustBuffer::max(self : StatsdescrobustBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustBuffer::to_string(self : StatsdescrobustBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_cursor_make(size : Int) -> StatsdescrobustCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustCursor::len(self : StatsdescrobustCursor) -> Int { self.size }

pub fn StatsdescrobustCursor::get(self : StatsdescrobustCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustCursor::set(self : StatsdescrobustCursor, i : Int, v : Double) -> StatsdescrobustCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustCursor::sum(self : StatsdescrobustCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustCursor::mean(self : StatsdescrobustCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustCursor::scale(self : StatsdescrobustCursor, f : Double) -> StatsdescrobustCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustCursor::add(self : StatsdescrobustCursor, other : StatsdescrobustCursor) -> StatsdescrobustCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustCursor::copy(self : StatsdescrobustCursor) -> StatsdescrobustCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustCursor::fill(self : StatsdescrobustCursor, v : Double) -> StatsdescrobustCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustCursor::min(self : StatsdescrobustCursor) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustCursor::max(self : StatsdescrobustCursor) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustCursor::to_string(self : StatsdescrobustCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_view_make(size : Int) -> StatsdescrobustView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustView::len(self : StatsdescrobustView) -> Int { self.size }

pub fn StatsdescrobustView::get(self : StatsdescrobustView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustView::set(self : StatsdescrobustView, i : Int, v : Double) -> StatsdescrobustView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustView::sum(self : StatsdescrobustView) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustView::mean(self : StatsdescrobustView) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustView::scale(self : StatsdescrobustView, f : Double) -> StatsdescrobustView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustView::add(self : StatsdescrobustView, other : StatsdescrobustView) -> StatsdescrobustView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustView::copy(self : StatsdescrobustView) -> StatsdescrobustView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustView::fill(self : StatsdescrobustView, v : Double) -> StatsdescrobustView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustView::min(self : StatsdescrobustView) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustView::max(self : StatsdescrobustView) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustView::to_string(self : StatsdescrobustView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_range_make(size : Int) -> StatsdescrobustRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustRange::len(self : StatsdescrobustRange) -> Int { self.size }

pub fn StatsdescrobustRange::get(self : StatsdescrobustRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustRange::set(self : StatsdescrobustRange, i : Int, v : Double) -> StatsdescrobustRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustRange::sum(self : StatsdescrobustRange) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustRange::mean(self : StatsdescrobustRange) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustRange::scale(self : StatsdescrobustRange, f : Double) -> StatsdescrobustRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustRange::add(self : StatsdescrobustRange, other : StatsdescrobustRange) -> StatsdescrobustRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustRange::copy(self : StatsdescrobustRange) -> StatsdescrobustRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustRange::fill(self : StatsdescrobustRange, v : Double) -> StatsdescrobustRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustRange::min(self : StatsdescrobustRange) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustRange::max(self : StatsdescrobustRange) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustRange::to_string(self : StatsdescrobustRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_slice_make(size : Int) -> StatsdescrobustSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescrobustSlice::len(self : StatsdescrobustSlice) -> Int { self.size }

pub fn StatsdescrobustSlice::get(self : StatsdescrobustSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescrobustSlice::set(self : StatsdescrobustSlice, i : Int, v : Double) -> StatsdescrobustSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescrobustSlice::sum(self : StatsdescrobustSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdescrobustSlice::mean(self : StatsdescrobustSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdescrobustSlice::scale(self : StatsdescrobustSlice, f : Double) -> StatsdescrobustSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustSlice::add(self : StatsdescrobustSlice, other : StatsdescrobustSlice) -> StatsdescrobustSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescrobustSlice::copy(self : StatsdescrobustSlice) -> StatsdescrobustSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustSlice::fill(self : StatsdescrobustSlice, v : Double) -> StatsdescrobustSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescrobustSlice::min(self : StatsdescrobustSlice) -> Double { @_common.min(self.data) }

pub fn StatsdescrobustSlice::max(self : StatsdescrobustSlice) -> Double { @_common.max(self.data) }

pub fn StatsdescrobustSlice::to_string(self : StatsdescrobustSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

