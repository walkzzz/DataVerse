///===
/// extcore/stats_dist_normal

pub(all) struct StatsdistnormalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_normal_make_point(x : Double, y : Double) -> StatsdistnormalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_normal_make_point3(x : Double, y : Double, z : Double) -> StatsdistnormalPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistnormalPoint::x(self : StatsdistnormalPoint) -> Double { self.x }

pub fn StatsdistnormalPoint::y(self : StatsdistnormalPoint) -> Double { self.y }

pub fn StatsdistnormalPoint::z(self : StatsdistnormalPoint) -> Double { self.z }

pub fn StatsdistnormalPoint::label(self : StatsdistnormalPoint) -> Int { self.label }

pub fn StatsdistnormalPoint::dist(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistnormalPoint::add(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistnormalPoint::sub(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistnormalPoint::scale(self : StatsdistnormalPoint, s : Double) -> StatsdistnormalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistnormalPoint::dot(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistnormalPoint::cross(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistnormalPoint::norm(self : StatsdistnormalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistnormalPoint::normalize(self : StatsdistnormalPoint) -> StatsdistnormalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistnormalPoint::negate(self : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistnormalPoint::mid(self : StatsdistnormalPoint, other : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistnormalPoint::lerp(self : StatsdistnormalPoint, other : StatsdistnormalPoint, t : Double) -> StatsdistnormalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistnormalPoint::to_string(self : StatsdistnormalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistnormalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_normal_make_series(vals : Array[Double], name : String) -> StatsdistnormalSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistnormalSeries::len(self : StatsdistnormalSeries) -> Int { self.vals.length() }

pub fn StatsdistnormalSeries::sum(self : StatsdistnormalSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistnormalSeries::mean(self : StatsdistnormalSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistnormalSeries::min(self : StatsdistnormalSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistnormalSeries::max(self : StatsdistnormalSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistnormalSeries::range(self : StatsdistnormalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistnormalSeries::variance(self : StatsdistnormalSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistnormalSeries::std(self : StatsdistnormalSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistnormalSeries::median(self : StatsdistnormalSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistnormalSeries::scale(self : StatsdistnormalSeries, f : Double) -> StatsdistnormalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistnormalSeries::add(self : StatsdistnormalSeries, other : StatsdistnormalSeries) -> StatsdistnormalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistnormalSeries::sub(self : StatsdistnormalSeries, other : StatsdistnormalSeries) -> StatsdistnormalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistnormalSeries::normalize(self : StatsdistnormalSeries) -> StatsdistnormalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistnormalSeries::cumsum(self : StatsdistnormalSeries) -> StatsdistnormalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistnormalSeries::to_string(self : StatsdistnormalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistnormalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_normal_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistnormalMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn stats_dist_normal_matrix_identity(n : Int) -> StatsdistnormalMatrix {
  let m = stats_dist_normal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistnormalMatrix::get(self : StatsdistnormalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistnormalMatrix::transpose(self : StatsdistnormalMatrix) -> StatsdistnormalMatrix {
  let result = stats_dist_normal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistnormalMatrix::add(self : StatsdistnormalMatrix, other : StatsdistnormalMatrix) -> StatsdistnormalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_normal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistnormalMatrix::scale(self : StatsdistnormalMatrix, s : Double) -> StatsdistnormalMatrix {
  let result = stats_dist_normal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistnormalMatrix::multiply(self : StatsdistnormalMatrix, other : StatsdistnormalMatrix) -> StatsdistnormalMatrix {
  if self.cols != other.rows { return stats_dist_normal_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_normal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsdistnormalMatrix::trace(self : StatsdistnormalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistnormalMatrix::det(self : StatsdistnormalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistnormalMatrix::norm(self : StatsdistnormalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistnormalMatrix::to_string(self : StatsdistnormalMatrix) -> String {
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

pub(all) struct StatsdistnormalVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_normal_make_vector(comps : Array[Double]) -> StatsdistnormalVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_normal_vector_zero(dim : Int) -> StatsdistnormalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistnormalVector::add(self : StatsdistnormalVector, other : StatsdistnormalVector) -> StatsdistnormalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistnormalVector::sub(self : StatsdistnormalVector, other : StatsdistnormalVector) -> StatsdistnormalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistnormalVector::scale(self : StatsdistnormalVector, s : Double) -> StatsdistnormalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistnormalVector::dot(self : StatsdistnormalVector, other : StatsdistnormalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistnormalVector::norm(self : StatsdistnormalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistnormalVector::normalize(self : StatsdistnormalVector) -> StatsdistnormalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistnormalVector::dist(self : StatsdistnormalVector, other : StatsdistnormalVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistnormalVector::to_string(self : StatsdistnormalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistnormalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_frame_make(size : Int) -> StatsdistnormalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalFrame::len(self : StatsdistnormalFrame) -> Int { self.size }

pub fn StatsdistnormalFrame::get(self : StatsdistnormalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalFrame::set(self : StatsdistnormalFrame, i : Int, v : Double) -> StatsdistnormalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalFrame::sum(self : StatsdistnormalFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalFrame::mean(self : StatsdistnormalFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalFrame::scale(self : StatsdistnormalFrame, f : Double) -> StatsdistnormalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalFrame::add(self : StatsdistnormalFrame, other : StatsdistnormalFrame) -> StatsdistnormalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalFrame::copy(self : StatsdistnormalFrame) -> StatsdistnormalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalFrame::fill(self : StatsdistnormalFrame, v : Double) -> StatsdistnormalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalFrame::min(self : StatsdistnormalFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalFrame::max(self : StatsdistnormalFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalFrame::to_string(self : StatsdistnormalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_table_make(size : Int) -> StatsdistnormalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalTable::len(self : StatsdistnormalTable) -> Int { self.size }

pub fn StatsdistnormalTable::get(self : StatsdistnormalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalTable::set(self : StatsdistnormalTable, i : Int, v : Double) -> StatsdistnormalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalTable::sum(self : StatsdistnormalTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalTable::mean(self : StatsdistnormalTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalTable::scale(self : StatsdistnormalTable, f : Double) -> StatsdistnormalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalTable::add(self : StatsdistnormalTable, other : StatsdistnormalTable) -> StatsdistnormalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalTable::copy(self : StatsdistnormalTable) -> StatsdistnormalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalTable::fill(self : StatsdistnormalTable, v : Double) -> StatsdistnormalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalTable::min(self : StatsdistnormalTable) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalTable::max(self : StatsdistnormalTable) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalTable::to_string(self : StatsdistnormalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_graphn_make(size : Int) -> StatsdistnormalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalGraphN::len(self : StatsdistnormalGraphN) -> Int { self.size }

pub fn StatsdistnormalGraphN::get(self : StatsdistnormalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalGraphN::set(self : StatsdistnormalGraphN, i : Int, v : Double) -> StatsdistnormalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalGraphN::sum(self : StatsdistnormalGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalGraphN::mean(self : StatsdistnormalGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalGraphN::scale(self : StatsdistnormalGraphN, f : Double) -> StatsdistnormalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalGraphN::add(self : StatsdistnormalGraphN, other : StatsdistnormalGraphN) -> StatsdistnormalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalGraphN::copy(self : StatsdistnormalGraphN) -> StatsdistnormalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalGraphN::fill(self : StatsdistnormalGraphN, v : Double) -> StatsdistnormalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalGraphN::min(self : StatsdistnormalGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalGraphN::max(self : StatsdistnormalGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalGraphN::to_string(self : StatsdistnormalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_node_make(size : Int) -> StatsdistnormalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalNode::len(self : StatsdistnormalNode) -> Int { self.size }

pub fn StatsdistnormalNode::get(self : StatsdistnormalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalNode::set(self : StatsdistnormalNode, i : Int, v : Double) -> StatsdistnormalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalNode::sum(self : StatsdistnormalNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalNode::mean(self : StatsdistnormalNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalNode::scale(self : StatsdistnormalNode, f : Double) -> StatsdistnormalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalNode::add(self : StatsdistnormalNode, other : StatsdistnormalNode) -> StatsdistnormalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalNode::copy(self : StatsdistnormalNode) -> StatsdistnormalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalNode::fill(self : StatsdistnormalNode, v : Double) -> StatsdistnormalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalNode::min(self : StatsdistnormalNode) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalNode::max(self : StatsdistnormalNode) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalNode::to_string(self : StatsdistnormalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_edge_make(size : Int) -> StatsdistnormalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalEdge::len(self : StatsdistnormalEdge) -> Int { self.size }

pub fn StatsdistnormalEdge::get(self : StatsdistnormalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalEdge::set(self : StatsdistnormalEdge, i : Int, v : Double) -> StatsdistnormalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalEdge::sum(self : StatsdistnormalEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalEdge::mean(self : StatsdistnormalEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalEdge::scale(self : StatsdistnormalEdge, f : Double) -> StatsdistnormalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalEdge::add(self : StatsdistnormalEdge, other : StatsdistnormalEdge) -> StatsdistnormalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalEdge::copy(self : StatsdistnormalEdge) -> StatsdistnormalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalEdge::fill(self : StatsdistnormalEdge, v : Double) -> StatsdistnormalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalEdge::min(self : StatsdistnormalEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalEdge::max(self : StatsdistnormalEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalEdge::to_string(self : StatsdistnormalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_path_make(size : Int) -> StatsdistnormalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalPath::len(self : StatsdistnormalPath) -> Int { self.size }

pub fn StatsdistnormalPath::get(self : StatsdistnormalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalPath::set(self : StatsdistnormalPath, i : Int, v : Double) -> StatsdistnormalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalPath::sum(self : StatsdistnormalPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalPath::mean(self : StatsdistnormalPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalPath::scale(self : StatsdistnormalPath, f : Double) -> StatsdistnormalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalPath::add(self : StatsdistnormalPath, other : StatsdistnormalPath) -> StatsdistnormalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalPath::copy(self : StatsdistnormalPath) -> StatsdistnormalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalPath::fill(self : StatsdistnormalPath, v : Double) -> StatsdistnormalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalPath::min(self : StatsdistnormalPath) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalPath::max(self : StatsdistnormalPath) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalPath::to_string(self : StatsdistnormalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_cluster_make(size : Int) -> StatsdistnormalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalCluster::len(self : StatsdistnormalCluster) -> Int { self.size }

pub fn StatsdistnormalCluster::get(self : StatsdistnormalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalCluster::set(self : StatsdistnormalCluster, i : Int, v : Double) -> StatsdistnormalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalCluster::sum(self : StatsdistnormalCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalCluster::mean(self : StatsdistnormalCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalCluster::scale(self : StatsdistnormalCluster, f : Double) -> StatsdistnormalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalCluster::add(self : StatsdistnormalCluster, other : StatsdistnormalCluster) -> StatsdistnormalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalCluster::copy(self : StatsdistnormalCluster) -> StatsdistnormalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalCluster::fill(self : StatsdistnormalCluster, v : Double) -> StatsdistnormalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalCluster::min(self : StatsdistnormalCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalCluster::max(self : StatsdistnormalCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalCluster::to_string(self : StatsdistnormalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_model_make(size : Int) -> StatsdistnormalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalModel::len(self : StatsdistnormalModel) -> Int { self.size }

pub fn StatsdistnormalModel::get(self : StatsdistnormalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalModel::set(self : StatsdistnormalModel, i : Int, v : Double) -> StatsdistnormalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalModel::sum(self : StatsdistnormalModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalModel::mean(self : StatsdistnormalModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalModel::scale(self : StatsdistnormalModel, f : Double) -> StatsdistnormalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalModel::add(self : StatsdistnormalModel, other : StatsdistnormalModel) -> StatsdistnormalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalModel::copy(self : StatsdistnormalModel) -> StatsdistnormalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalModel::fill(self : StatsdistnormalModel, v : Double) -> StatsdistnormalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalModel::min(self : StatsdistnormalModel) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalModel::max(self : StatsdistnormalModel) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalModel::to_string(self : StatsdistnormalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_layer_make(size : Int) -> StatsdistnormalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalLayer::len(self : StatsdistnormalLayer) -> Int { self.size }

pub fn StatsdistnormalLayer::get(self : StatsdistnormalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalLayer::set(self : StatsdistnormalLayer, i : Int, v : Double) -> StatsdistnormalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalLayer::sum(self : StatsdistnormalLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalLayer::mean(self : StatsdistnormalLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalLayer::scale(self : StatsdistnormalLayer, f : Double) -> StatsdistnormalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalLayer::add(self : StatsdistnormalLayer, other : StatsdistnormalLayer) -> StatsdistnormalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalLayer::copy(self : StatsdistnormalLayer) -> StatsdistnormalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalLayer::fill(self : StatsdistnormalLayer, v : Double) -> StatsdistnormalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalLayer::min(self : StatsdistnormalLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalLayer::max(self : StatsdistnormalLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalLayer::to_string(self : StatsdistnormalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_buffer_make(size : Int) -> StatsdistnormalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalBuffer::len(self : StatsdistnormalBuffer) -> Int { self.size }

pub fn StatsdistnormalBuffer::get(self : StatsdistnormalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalBuffer::set(self : StatsdistnormalBuffer, i : Int, v : Double) -> StatsdistnormalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalBuffer::sum(self : StatsdistnormalBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalBuffer::mean(self : StatsdistnormalBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalBuffer::scale(self : StatsdistnormalBuffer, f : Double) -> StatsdistnormalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalBuffer::add(self : StatsdistnormalBuffer, other : StatsdistnormalBuffer) -> StatsdistnormalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalBuffer::copy(self : StatsdistnormalBuffer) -> StatsdistnormalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalBuffer::fill(self : StatsdistnormalBuffer, v : Double) -> StatsdistnormalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalBuffer::min(self : StatsdistnormalBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalBuffer::max(self : StatsdistnormalBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalBuffer::to_string(self : StatsdistnormalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_cursor_make(size : Int) -> StatsdistnormalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalCursor::len(self : StatsdistnormalCursor) -> Int { self.size }

pub fn StatsdistnormalCursor::get(self : StatsdistnormalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalCursor::set(self : StatsdistnormalCursor, i : Int, v : Double) -> StatsdistnormalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalCursor::sum(self : StatsdistnormalCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalCursor::mean(self : StatsdistnormalCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalCursor::scale(self : StatsdistnormalCursor, f : Double) -> StatsdistnormalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalCursor::add(self : StatsdistnormalCursor, other : StatsdistnormalCursor) -> StatsdistnormalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalCursor::copy(self : StatsdistnormalCursor) -> StatsdistnormalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalCursor::fill(self : StatsdistnormalCursor, v : Double) -> StatsdistnormalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalCursor::min(self : StatsdistnormalCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalCursor::max(self : StatsdistnormalCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalCursor::to_string(self : StatsdistnormalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_view_make(size : Int) -> StatsdistnormalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalView::len(self : StatsdistnormalView) -> Int { self.size }

pub fn StatsdistnormalView::get(self : StatsdistnormalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalView::set(self : StatsdistnormalView, i : Int, v : Double) -> StatsdistnormalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalView::sum(self : StatsdistnormalView) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalView::mean(self : StatsdistnormalView) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalView::scale(self : StatsdistnormalView, f : Double) -> StatsdistnormalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalView::add(self : StatsdistnormalView, other : StatsdistnormalView) -> StatsdistnormalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalView::copy(self : StatsdistnormalView) -> StatsdistnormalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalView::fill(self : StatsdistnormalView, v : Double) -> StatsdistnormalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalView::min(self : StatsdistnormalView) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalView::max(self : StatsdistnormalView) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalView::to_string(self : StatsdistnormalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_range_make(size : Int) -> StatsdistnormalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalRange::len(self : StatsdistnormalRange) -> Int { self.size }

pub fn StatsdistnormalRange::get(self : StatsdistnormalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalRange::set(self : StatsdistnormalRange, i : Int, v : Double) -> StatsdistnormalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalRange::sum(self : StatsdistnormalRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalRange::mean(self : StatsdistnormalRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalRange::scale(self : StatsdistnormalRange, f : Double) -> StatsdistnormalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalRange::add(self : StatsdistnormalRange, other : StatsdistnormalRange) -> StatsdistnormalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalRange::copy(self : StatsdistnormalRange) -> StatsdistnormalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalRange::fill(self : StatsdistnormalRange, v : Double) -> StatsdistnormalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalRange::min(self : StatsdistnormalRange) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalRange::max(self : StatsdistnormalRange) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalRange::to_string(self : StatsdistnormalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_slice_make(size : Int) -> StatsdistnormalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistnormalSlice::len(self : StatsdistnormalSlice) -> Int { self.size }

pub fn StatsdistnormalSlice::get(self : StatsdistnormalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistnormalSlice::set(self : StatsdistnormalSlice, i : Int, v : Double) -> StatsdistnormalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistnormalSlice::sum(self : StatsdistnormalSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistnormalSlice::mean(self : StatsdistnormalSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistnormalSlice::scale(self : StatsdistnormalSlice, f : Double) -> StatsdistnormalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalSlice::add(self : StatsdistnormalSlice, other : StatsdistnormalSlice) -> StatsdistnormalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistnormalSlice::copy(self : StatsdistnormalSlice) -> StatsdistnormalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalSlice::fill(self : StatsdistnormalSlice, v : Double) -> StatsdistnormalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistnormalSlice::min(self : StatsdistnormalSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistnormalSlice::max(self : StatsdistnormalSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistnormalSlice::to_string(self : StatsdistnormalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

