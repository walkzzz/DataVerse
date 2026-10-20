///===
/// extcore/stats_dist_lognormal

pub(all) struct StatsdistlognormalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_lognormal_make_point(x : Double, y : Double) -> StatsdistlognormalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_lognormal_make_point3(x : Double, y : Double, z : Double) -> StatsdistlognormalPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistlognormalPoint::x(self : StatsdistlognormalPoint) -> Double { self.x }

pub fn StatsdistlognormalPoint::y(self : StatsdistlognormalPoint) -> Double { self.y }

pub fn StatsdistlognormalPoint::z(self : StatsdistlognormalPoint) -> Double { self.z }

pub fn StatsdistlognormalPoint::label(self : StatsdistlognormalPoint) -> Int { self.label }

pub fn StatsdistlognormalPoint::dist(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistlognormalPoint::add(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistlognormalPoint::sub(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistlognormalPoint::scale(self : StatsdistlognormalPoint, s : Double) -> StatsdistlognormalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistlognormalPoint::dot(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistlognormalPoint::cross(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistlognormalPoint::norm(self : StatsdistlognormalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistlognormalPoint::normalize(self : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistlognormalPoint::negate(self : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistlognormalPoint::mid(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistlognormalPoint::lerp(self : StatsdistlognormalPoint, other : StatsdistlognormalPoint, t : Double) -> StatsdistlognormalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistlognormalPoint::to_string(self : StatsdistlognormalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistlognormalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_lognormal_make_series(vals : Array[Double], name : String) -> StatsdistlognormalSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistlognormalSeries::len(self : StatsdistlognormalSeries) -> Int { self.vals.length() }

pub fn StatsdistlognormalSeries::sum(self : StatsdistlognormalSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistlognormalSeries::mean(self : StatsdistlognormalSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistlognormalSeries::min(self : StatsdistlognormalSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistlognormalSeries::max(self : StatsdistlognormalSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistlognormalSeries::range(self : StatsdistlognormalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistlognormalSeries::variance(self : StatsdistlognormalSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistlognormalSeries::std(self : StatsdistlognormalSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistlognormalSeries::median(self : StatsdistlognormalSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistlognormalSeries::scale(self : StatsdistlognormalSeries, f : Double) -> StatsdistlognormalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistlognormalSeries::add(self : StatsdistlognormalSeries, other : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistlognormalSeries::sub(self : StatsdistlognormalSeries, other : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistlognormalSeries::normalize(self : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistlognormalSeries::cumsum(self : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistlognormalSeries::to_string(self : StatsdistlognormalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistlognormalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_lognormal_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistlognormalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_lognormal_matrix_identity(n : Int) -> StatsdistlognormalMatrix {
  let m = stats_dist_lognormal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistlognormalMatrix::get(self : StatsdistlognormalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistlognormalMatrix::transpose(self : StatsdistlognormalMatrix) -> StatsdistlognormalMatrix {
  let result = stats_dist_lognormal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistlognormalMatrix::add(self : StatsdistlognormalMatrix, other : StatsdistlognormalMatrix) -> StatsdistlognormalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_lognormal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistlognormalMatrix::scale(self : StatsdistlognormalMatrix, s : Double) -> StatsdistlognormalMatrix {
  let result = stats_dist_lognormal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistlognormalMatrix::multiply(self : StatsdistlognormalMatrix, other : StatsdistlognormalMatrix) -> StatsdistlognormalMatrix {
  if self.cols != other.rows { return stats_dist_lognormal_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_lognormal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsdistlognormalMatrix::trace(self : StatsdistlognormalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistlognormalMatrix::det(self : StatsdistlognormalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistlognormalMatrix::norm(self : StatsdistlognormalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistlognormalMatrix::to_string(self : StatsdistlognormalMatrix) -> String {
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

pub(all) struct StatsdistlognormalVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_lognormal_make_vector(comps : Array[Double]) -> StatsdistlognormalVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_lognormal_vector_zero(dim : Int) -> StatsdistlognormalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistlognormalVector::add(self : StatsdistlognormalVector, other : StatsdistlognormalVector) -> StatsdistlognormalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistlognormalVector::sub(self : StatsdistlognormalVector, other : StatsdistlognormalVector) -> StatsdistlognormalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistlognormalVector::scale(self : StatsdistlognormalVector, s : Double) -> StatsdistlognormalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistlognormalVector::dot(self : StatsdistlognormalVector, other : StatsdistlognormalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistlognormalVector::norm(self : StatsdistlognormalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistlognormalVector::normalize(self : StatsdistlognormalVector) -> StatsdistlognormalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistlognormalVector::dist(self : StatsdistlognormalVector, other : StatsdistlognormalVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistlognormalVector::to_string(self : StatsdistlognormalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistlognormalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_frame_make(size : Int) -> StatsdistlognormalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalFrame::len(self : StatsdistlognormalFrame) -> Int { self.size }

pub fn StatsdistlognormalFrame::get(self : StatsdistlognormalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalFrame::set(self : StatsdistlognormalFrame, i : Int, v : Double) -> StatsdistlognormalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalFrame::sum(self : StatsdistlognormalFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalFrame::mean(self : StatsdistlognormalFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalFrame::scale(self : StatsdistlognormalFrame, f : Double) -> StatsdistlognormalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalFrame::add(self : StatsdistlognormalFrame, other : StatsdistlognormalFrame) -> StatsdistlognormalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalFrame::copy(self : StatsdistlognormalFrame) -> StatsdistlognormalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalFrame::fill(self : StatsdistlognormalFrame, v : Double) -> StatsdistlognormalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalFrame::min(self : StatsdistlognormalFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalFrame::max(self : StatsdistlognormalFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalFrame::to_string(self : StatsdistlognormalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_table_make(size : Int) -> StatsdistlognormalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalTable::len(self : StatsdistlognormalTable) -> Int { self.size }

pub fn StatsdistlognormalTable::get(self : StatsdistlognormalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalTable::set(self : StatsdistlognormalTable, i : Int, v : Double) -> StatsdistlognormalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalTable::sum(self : StatsdistlognormalTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalTable::mean(self : StatsdistlognormalTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalTable::scale(self : StatsdistlognormalTable, f : Double) -> StatsdistlognormalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalTable::add(self : StatsdistlognormalTable, other : StatsdistlognormalTable) -> StatsdistlognormalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalTable::copy(self : StatsdistlognormalTable) -> StatsdistlognormalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalTable::fill(self : StatsdistlognormalTable, v : Double) -> StatsdistlognormalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalTable::min(self : StatsdistlognormalTable) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalTable::max(self : StatsdistlognormalTable) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalTable::to_string(self : StatsdistlognormalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_graphn_make(size : Int) -> StatsdistlognormalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalGraphN::len(self : StatsdistlognormalGraphN) -> Int { self.size }

pub fn StatsdistlognormalGraphN::get(self : StatsdistlognormalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalGraphN::set(self : StatsdistlognormalGraphN, i : Int, v : Double) -> StatsdistlognormalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalGraphN::sum(self : StatsdistlognormalGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalGraphN::mean(self : StatsdistlognormalGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalGraphN::scale(self : StatsdistlognormalGraphN, f : Double) -> StatsdistlognormalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalGraphN::add(self : StatsdistlognormalGraphN, other : StatsdistlognormalGraphN) -> StatsdistlognormalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalGraphN::copy(self : StatsdistlognormalGraphN) -> StatsdistlognormalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalGraphN::fill(self : StatsdistlognormalGraphN, v : Double) -> StatsdistlognormalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalGraphN::min(self : StatsdistlognormalGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalGraphN::max(self : StatsdistlognormalGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalGraphN::to_string(self : StatsdistlognormalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_node_make(size : Int) -> StatsdistlognormalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalNode::len(self : StatsdistlognormalNode) -> Int { self.size }

pub fn StatsdistlognormalNode::get(self : StatsdistlognormalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalNode::set(self : StatsdistlognormalNode, i : Int, v : Double) -> StatsdistlognormalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalNode::sum(self : StatsdistlognormalNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalNode::mean(self : StatsdistlognormalNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalNode::scale(self : StatsdistlognormalNode, f : Double) -> StatsdistlognormalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalNode::add(self : StatsdistlognormalNode, other : StatsdistlognormalNode) -> StatsdistlognormalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalNode::copy(self : StatsdistlognormalNode) -> StatsdistlognormalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalNode::fill(self : StatsdistlognormalNode, v : Double) -> StatsdistlognormalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalNode::min(self : StatsdistlognormalNode) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalNode::max(self : StatsdistlognormalNode) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalNode::to_string(self : StatsdistlognormalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_edge_make(size : Int) -> StatsdistlognormalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalEdge::len(self : StatsdistlognormalEdge) -> Int { self.size }

pub fn StatsdistlognormalEdge::get(self : StatsdistlognormalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalEdge::set(self : StatsdistlognormalEdge, i : Int, v : Double) -> StatsdistlognormalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalEdge::sum(self : StatsdistlognormalEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalEdge::mean(self : StatsdistlognormalEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalEdge::scale(self : StatsdistlognormalEdge, f : Double) -> StatsdistlognormalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalEdge::add(self : StatsdistlognormalEdge, other : StatsdistlognormalEdge) -> StatsdistlognormalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalEdge::copy(self : StatsdistlognormalEdge) -> StatsdistlognormalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalEdge::fill(self : StatsdistlognormalEdge, v : Double) -> StatsdistlognormalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalEdge::min(self : StatsdistlognormalEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalEdge::max(self : StatsdistlognormalEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalEdge::to_string(self : StatsdistlognormalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_path_make(size : Int) -> StatsdistlognormalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalPath::len(self : StatsdistlognormalPath) -> Int { self.size }

pub fn StatsdistlognormalPath::get(self : StatsdistlognormalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalPath::set(self : StatsdistlognormalPath, i : Int, v : Double) -> StatsdistlognormalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalPath::sum(self : StatsdistlognormalPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalPath::mean(self : StatsdistlognormalPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalPath::scale(self : StatsdistlognormalPath, f : Double) -> StatsdistlognormalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalPath::add(self : StatsdistlognormalPath, other : StatsdistlognormalPath) -> StatsdistlognormalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalPath::copy(self : StatsdistlognormalPath) -> StatsdistlognormalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalPath::fill(self : StatsdistlognormalPath, v : Double) -> StatsdistlognormalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalPath::min(self : StatsdistlognormalPath) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalPath::max(self : StatsdistlognormalPath) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalPath::to_string(self : StatsdistlognormalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_cluster_make(size : Int) -> StatsdistlognormalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalCluster::len(self : StatsdistlognormalCluster) -> Int { self.size }

pub fn StatsdistlognormalCluster::get(self : StatsdistlognormalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalCluster::set(self : StatsdistlognormalCluster, i : Int, v : Double) -> StatsdistlognormalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalCluster::sum(self : StatsdistlognormalCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalCluster::mean(self : StatsdistlognormalCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalCluster::scale(self : StatsdistlognormalCluster, f : Double) -> StatsdistlognormalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalCluster::add(self : StatsdistlognormalCluster, other : StatsdistlognormalCluster) -> StatsdistlognormalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalCluster::copy(self : StatsdistlognormalCluster) -> StatsdistlognormalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalCluster::fill(self : StatsdistlognormalCluster, v : Double) -> StatsdistlognormalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalCluster::min(self : StatsdistlognormalCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalCluster::max(self : StatsdistlognormalCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalCluster::to_string(self : StatsdistlognormalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_model_make(size : Int) -> StatsdistlognormalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalModel::len(self : StatsdistlognormalModel) -> Int { self.size }

pub fn StatsdistlognormalModel::get(self : StatsdistlognormalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalModel::set(self : StatsdistlognormalModel, i : Int, v : Double) -> StatsdistlognormalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalModel::sum(self : StatsdistlognormalModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalModel::mean(self : StatsdistlognormalModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalModel::scale(self : StatsdistlognormalModel, f : Double) -> StatsdistlognormalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalModel::add(self : StatsdistlognormalModel, other : StatsdistlognormalModel) -> StatsdistlognormalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalModel::copy(self : StatsdistlognormalModel) -> StatsdistlognormalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalModel::fill(self : StatsdistlognormalModel, v : Double) -> StatsdistlognormalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalModel::min(self : StatsdistlognormalModel) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalModel::max(self : StatsdistlognormalModel) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalModel::to_string(self : StatsdistlognormalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_layer_make(size : Int) -> StatsdistlognormalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalLayer::len(self : StatsdistlognormalLayer) -> Int { self.size }

pub fn StatsdistlognormalLayer::get(self : StatsdistlognormalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalLayer::set(self : StatsdistlognormalLayer, i : Int, v : Double) -> StatsdistlognormalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalLayer::sum(self : StatsdistlognormalLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalLayer::mean(self : StatsdistlognormalLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalLayer::scale(self : StatsdistlognormalLayer, f : Double) -> StatsdistlognormalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalLayer::add(self : StatsdistlognormalLayer, other : StatsdistlognormalLayer) -> StatsdistlognormalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalLayer::copy(self : StatsdistlognormalLayer) -> StatsdistlognormalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalLayer::fill(self : StatsdistlognormalLayer, v : Double) -> StatsdistlognormalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalLayer::min(self : StatsdistlognormalLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalLayer::max(self : StatsdistlognormalLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalLayer::to_string(self : StatsdistlognormalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_buffer_make(size : Int) -> StatsdistlognormalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalBuffer::len(self : StatsdistlognormalBuffer) -> Int { self.size }

pub fn StatsdistlognormalBuffer::get(self : StatsdistlognormalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalBuffer::set(self : StatsdistlognormalBuffer, i : Int, v : Double) -> StatsdistlognormalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalBuffer::sum(self : StatsdistlognormalBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalBuffer::mean(self : StatsdistlognormalBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalBuffer::scale(self : StatsdistlognormalBuffer, f : Double) -> StatsdistlognormalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalBuffer::add(self : StatsdistlognormalBuffer, other : StatsdistlognormalBuffer) -> StatsdistlognormalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalBuffer::copy(self : StatsdistlognormalBuffer) -> StatsdistlognormalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalBuffer::fill(self : StatsdistlognormalBuffer, v : Double) -> StatsdistlognormalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalBuffer::min(self : StatsdistlognormalBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalBuffer::max(self : StatsdistlognormalBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalBuffer::to_string(self : StatsdistlognormalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_cursor_make(size : Int) -> StatsdistlognormalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalCursor::len(self : StatsdistlognormalCursor) -> Int { self.size }

pub fn StatsdistlognormalCursor::get(self : StatsdistlognormalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalCursor::set(self : StatsdistlognormalCursor, i : Int, v : Double) -> StatsdistlognormalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalCursor::sum(self : StatsdistlognormalCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalCursor::mean(self : StatsdistlognormalCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalCursor::scale(self : StatsdistlognormalCursor, f : Double) -> StatsdistlognormalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalCursor::add(self : StatsdistlognormalCursor, other : StatsdistlognormalCursor) -> StatsdistlognormalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalCursor::copy(self : StatsdistlognormalCursor) -> StatsdistlognormalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalCursor::fill(self : StatsdistlognormalCursor, v : Double) -> StatsdistlognormalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalCursor::min(self : StatsdistlognormalCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalCursor::max(self : StatsdistlognormalCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalCursor::to_string(self : StatsdistlognormalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_view_make(size : Int) -> StatsdistlognormalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalView::len(self : StatsdistlognormalView) -> Int { self.size }

pub fn StatsdistlognormalView::get(self : StatsdistlognormalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalView::set(self : StatsdistlognormalView, i : Int, v : Double) -> StatsdistlognormalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalView::sum(self : StatsdistlognormalView) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalView::mean(self : StatsdistlognormalView) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalView::scale(self : StatsdistlognormalView, f : Double) -> StatsdistlognormalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalView::add(self : StatsdistlognormalView, other : StatsdistlognormalView) -> StatsdistlognormalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalView::copy(self : StatsdistlognormalView) -> StatsdistlognormalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalView::fill(self : StatsdistlognormalView, v : Double) -> StatsdistlognormalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalView::min(self : StatsdistlognormalView) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalView::max(self : StatsdistlognormalView) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalView::to_string(self : StatsdistlognormalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_range_make(size : Int) -> StatsdistlognormalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalRange::len(self : StatsdistlognormalRange) -> Int { self.size }

pub fn StatsdistlognormalRange::get(self : StatsdistlognormalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalRange::set(self : StatsdistlognormalRange, i : Int, v : Double) -> StatsdistlognormalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalRange::sum(self : StatsdistlognormalRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalRange::mean(self : StatsdistlognormalRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalRange::scale(self : StatsdistlognormalRange, f : Double) -> StatsdistlognormalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalRange::add(self : StatsdistlognormalRange, other : StatsdistlognormalRange) -> StatsdistlognormalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalRange::copy(self : StatsdistlognormalRange) -> StatsdistlognormalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalRange::fill(self : StatsdistlognormalRange, v : Double) -> StatsdistlognormalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalRange::min(self : StatsdistlognormalRange) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalRange::max(self : StatsdistlognormalRange) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalRange::to_string(self : StatsdistlognormalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_slice_make(size : Int) -> StatsdistlognormalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistlognormalSlice::len(self : StatsdistlognormalSlice) -> Int { self.size }

pub fn StatsdistlognormalSlice::get(self : StatsdistlognormalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistlognormalSlice::set(self : StatsdistlognormalSlice, i : Int, v : Double) -> StatsdistlognormalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalSlice::sum(self : StatsdistlognormalSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistlognormalSlice::mean(self : StatsdistlognormalSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistlognormalSlice::scale(self : StatsdistlognormalSlice, f : Double) -> StatsdistlognormalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalSlice::add(self : StatsdistlognormalSlice, other : StatsdistlognormalSlice) -> StatsdistlognormalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistlognormalSlice::copy(self : StatsdistlognormalSlice) -> StatsdistlognormalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalSlice::fill(self : StatsdistlognormalSlice, v : Double) -> StatsdistlognormalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistlognormalSlice::min(self : StatsdistlognormalSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistlognormalSlice::max(self : StatsdistlognormalSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistlognormalSlice::to_string(self : StatsdistlognormalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

