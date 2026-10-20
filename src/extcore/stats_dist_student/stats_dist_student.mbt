///===
/// extcore/stats_dist_student

pub(all) struct StatsdiststudentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_student_make_point(x : Double, y : Double) -> StatsdiststudentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_student_make_point3(x : Double, y : Double, z : Double) -> StatsdiststudentPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdiststudentPoint::x(self : StatsdiststudentPoint) -> Double { self.x }

pub fn StatsdiststudentPoint::y(self : StatsdiststudentPoint) -> Double { self.y }

pub fn StatsdiststudentPoint::z(self : StatsdiststudentPoint) -> Double { self.z }

pub fn StatsdiststudentPoint::label(self : StatsdiststudentPoint) -> Int { self.label }

pub fn StatsdiststudentPoint::dist(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdiststudentPoint::add(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdiststudentPoint::sub(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdiststudentPoint::scale(self : StatsdiststudentPoint, s : Double) -> StatsdiststudentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdiststudentPoint::dot(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdiststudentPoint::cross(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdiststudentPoint::norm(self : StatsdiststudentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdiststudentPoint::normalize(self : StatsdiststudentPoint) -> StatsdiststudentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdiststudentPoint::negate(self : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdiststudentPoint::mid(self : StatsdiststudentPoint, other : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdiststudentPoint::lerp(self : StatsdiststudentPoint, other : StatsdiststudentPoint, t : Double) -> StatsdiststudentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdiststudentPoint::to_string(self : StatsdiststudentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdiststudentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_student_make_series(vals : Array[Double], name : String) -> StatsdiststudentSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdiststudentSeries::len(self : StatsdiststudentSeries) -> Int { self.vals.length() }

pub fn StatsdiststudentSeries::sum(self : StatsdiststudentSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdiststudentSeries::mean(self : StatsdiststudentSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdiststudentSeries::min(self : StatsdiststudentSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdiststudentSeries::max(self : StatsdiststudentSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdiststudentSeries::range(self : StatsdiststudentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdiststudentSeries::variance(self : StatsdiststudentSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdiststudentSeries::std(self : StatsdiststudentSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdiststudentSeries::median(self : StatsdiststudentSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdiststudentSeries::scale(self : StatsdiststudentSeries, f : Double) -> StatsdiststudentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdiststudentSeries::add(self : StatsdiststudentSeries, other : StatsdiststudentSeries) -> StatsdiststudentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdiststudentSeries::sub(self : StatsdiststudentSeries, other : StatsdiststudentSeries) -> StatsdiststudentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdiststudentSeries::normalize(self : StatsdiststudentSeries) -> StatsdiststudentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdiststudentSeries::cumsum(self : StatsdiststudentSeries) -> StatsdiststudentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdiststudentSeries::to_string(self : StatsdiststudentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdiststudentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_student_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdiststudentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_student_matrix_identity(n : Int) -> StatsdiststudentMatrix {
  let m = stats_dist_student_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdiststudentMatrix::get(self : StatsdiststudentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdiststudentMatrix::transpose(self : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  let result = stats_dist_student_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdiststudentMatrix::add(self : StatsdiststudentMatrix, other : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_student_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdiststudentMatrix::scale(self : StatsdiststudentMatrix, s : Double) -> StatsdiststudentMatrix {
  let result = stats_dist_student_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdiststudentMatrix::multiply(self : StatsdiststudentMatrix, other : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  if self.cols != other.rows { return stats_dist_student_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_student_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdiststudentMatrix::trace(self : StatsdiststudentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdiststudentMatrix::det(self : StatsdiststudentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdiststudentMatrix::norm(self : StatsdiststudentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdiststudentMatrix::to_string(self : StatsdiststudentMatrix) -> String {
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

pub(all) struct StatsdiststudentVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_student_make_vector(comps : Array[Double]) -> StatsdiststudentVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_student_vector_zero(dim : Int) -> StatsdiststudentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdiststudentVector::add(self : StatsdiststudentVector, other : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdiststudentVector::sub(self : StatsdiststudentVector, other : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdiststudentVector::scale(self : StatsdiststudentVector, s : Double) -> StatsdiststudentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdiststudentVector::dot(self : StatsdiststudentVector, other : StatsdiststudentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdiststudentVector::norm(self : StatsdiststudentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdiststudentVector::normalize(self : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdiststudentVector::dist(self : StatsdiststudentVector, other : StatsdiststudentVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdiststudentVector::to_string(self : StatsdiststudentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdiststudentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_frame_make(size : Int) -> StatsdiststudentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentFrame::len(self : StatsdiststudentFrame) -> Int { self.size }

pub fn StatsdiststudentFrame::get(self : StatsdiststudentFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentFrame::set(self : StatsdiststudentFrame, i : Int, v : Double) -> StatsdiststudentFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentFrame::sum(self : StatsdiststudentFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentFrame::mean(self : StatsdiststudentFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentFrame::scale(self : StatsdiststudentFrame, f : Double) -> StatsdiststudentFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentFrame::add(self : StatsdiststudentFrame, other : StatsdiststudentFrame) -> StatsdiststudentFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentFrame::copy(self : StatsdiststudentFrame) -> StatsdiststudentFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentFrame::fill(self : StatsdiststudentFrame, v : Double) -> StatsdiststudentFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentFrame::min(self : StatsdiststudentFrame) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentFrame::max(self : StatsdiststudentFrame) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentFrame::to_string(self : StatsdiststudentFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_table_make(size : Int) -> StatsdiststudentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentTable::len(self : StatsdiststudentTable) -> Int { self.size }

pub fn StatsdiststudentTable::get(self : StatsdiststudentTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentTable::set(self : StatsdiststudentTable, i : Int, v : Double) -> StatsdiststudentTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentTable::sum(self : StatsdiststudentTable) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentTable::mean(self : StatsdiststudentTable) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentTable::scale(self : StatsdiststudentTable, f : Double) -> StatsdiststudentTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentTable::add(self : StatsdiststudentTable, other : StatsdiststudentTable) -> StatsdiststudentTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentTable::copy(self : StatsdiststudentTable) -> StatsdiststudentTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentTable::fill(self : StatsdiststudentTable, v : Double) -> StatsdiststudentTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentTable::min(self : StatsdiststudentTable) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentTable::max(self : StatsdiststudentTable) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentTable::to_string(self : StatsdiststudentTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_graphn_make(size : Int) -> StatsdiststudentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentGraphN::len(self : StatsdiststudentGraphN) -> Int { self.size }

pub fn StatsdiststudentGraphN::get(self : StatsdiststudentGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentGraphN::set(self : StatsdiststudentGraphN, i : Int, v : Double) -> StatsdiststudentGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentGraphN::sum(self : StatsdiststudentGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentGraphN::mean(self : StatsdiststudentGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentGraphN::scale(self : StatsdiststudentGraphN, f : Double) -> StatsdiststudentGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentGraphN::add(self : StatsdiststudentGraphN, other : StatsdiststudentGraphN) -> StatsdiststudentGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentGraphN::copy(self : StatsdiststudentGraphN) -> StatsdiststudentGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentGraphN::fill(self : StatsdiststudentGraphN, v : Double) -> StatsdiststudentGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentGraphN::min(self : StatsdiststudentGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentGraphN::max(self : StatsdiststudentGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentGraphN::to_string(self : StatsdiststudentGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_node_make(size : Int) -> StatsdiststudentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentNode::len(self : StatsdiststudentNode) -> Int { self.size }

pub fn StatsdiststudentNode::get(self : StatsdiststudentNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentNode::set(self : StatsdiststudentNode, i : Int, v : Double) -> StatsdiststudentNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentNode::sum(self : StatsdiststudentNode) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentNode::mean(self : StatsdiststudentNode) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentNode::scale(self : StatsdiststudentNode, f : Double) -> StatsdiststudentNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentNode::add(self : StatsdiststudentNode, other : StatsdiststudentNode) -> StatsdiststudentNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentNode::copy(self : StatsdiststudentNode) -> StatsdiststudentNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentNode::fill(self : StatsdiststudentNode, v : Double) -> StatsdiststudentNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentNode::min(self : StatsdiststudentNode) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentNode::max(self : StatsdiststudentNode) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentNode::to_string(self : StatsdiststudentNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_edge_make(size : Int) -> StatsdiststudentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentEdge::len(self : StatsdiststudentEdge) -> Int { self.size }

pub fn StatsdiststudentEdge::get(self : StatsdiststudentEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentEdge::set(self : StatsdiststudentEdge, i : Int, v : Double) -> StatsdiststudentEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentEdge::sum(self : StatsdiststudentEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentEdge::mean(self : StatsdiststudentEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentEdge::scale(self : StatsdiststudentEdge, f : Double) -> StatsdiststudentEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentEdge::add(self : StatsdiststudentEdge, other : StatsdiststudentEdge) -> StatsdiststudentEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentEdge::copy(self : StatsdiststudentEdge) -> StatsdiststudentEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentEdge::fill(self : StatsdiststudentEdge, v : Double) -> StatsdiststudentEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentEdge::min(self : StatsdiststudentEdge) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentEdge::max(self : StatsdiststudentEdge) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentEdge::to_string(self : StatsdiststudentEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_path_make(size : Int) -> StatsdiststudentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentPath::len(self : StatsdiststudentPath) -> Int { self.size }

pub fn StatsdiststudentPath::get(self : StatsdiststudentPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentPath::set(self : StatsdiststudentPath, i : Int, v : Double) -> StatsdiststudentPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentPath::sum(self : StatsdiststudentPath) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentPath::mean(self : StatsdiststudentPath) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentPath::scale(self : StatsdiststudentPath, f : Double) -> StatsdiststudentPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentPath::add(self : StatsdiststudentPath, other : StatsdiststudentPath) -> StatsdiststudentPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentPath::copy(self : StatsdiststudentPath) -> StatsdiststudentPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentPath::fill(self : StatsdiststudentPath, v : Double) -> StatsdiststudentPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentPath::min(self : StatsdiststudentPath) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentPath::max(self : StatsdiststudentPath) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentPath::to_string(self : StatsdiststudentPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_cluster_make(size : Int) -> StatsdiststudentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentCluster::len(self : StatsdiststudentCluster) -> Int { self.size }

pub fn StatsdiststudentCluster::get(self : StatsdiststudentCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentCluster::set(self : StatsdiststudentCluster, i : Int, v : Double) -> StatsdiststudentCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentCluster::sum(self : StatsdiststudentCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentCluster::mean(self : StatsdiststudentCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentCluster::scale(self : StatsdiststudentCluster, f : Double) -> StatsdiststudentCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentCluster::add(self : StatsdiststudentCluster, other : StatsdiststudentCluster) -> StatsdiststudentCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentCluster::copy(self : StatsdiststudentCluster) -> StatsdiststudentCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentCluster::fill(self : StatsdiststudentCluster, v : Double) -> StatsdiststudentCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentCluster::min(self : StatsdiststudentCluster) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentCluster::max(self : StatsdiststudentCluster) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentCluster::to_string(self : StatsdiststudentCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_model_make(size : Int) -> StatsdiststudentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentModel::len(self : StatsdiststudentModel) -> Int { self.size }

pub fn StatsdiststudentModel::get(self : StatsdiststudentModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentModel::set(self : StatsdiststudentModel, i : Int, v : Double) -> StatsdiststudentModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentModel::sum(self : StatsdiststudentModel) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentModel::mean(self : StatsdiststudentModel) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentModel::scale(self : StatsdiststudentModel, f : Double) -> StatsdiststudentModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentModel::add(self : StatsdiststudentModel, other : StatsdiststudentModel) -> StatsdiststudentModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentModel::copy(self : StatsdiststudentModel) -> StatsdiststudentModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentModel::fill(self : StatsdiststudentModel, v : Double) -> StatsdiststudentModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentModel::min(self : StatsdiststudentModel) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentModel::max(self : StatsdiststudentModel) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentModel::to_string(self : StatsdiststudentModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_layer_make(size : Int) -> StatsdiststudentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentLayer::len(self : StatsdiststudentLayer) -> Int { self.size }

pub fn StatsdiststudentLayer::get(self : StatsdiststudentLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentLayer::set(self : StatsdiststudentLayer, i : Int, v : Double) -> StatsdiststudentLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentLayer::sum(self : StatsdiststudentLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentLayer::mean(self : StatsdiststudentLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentLayer::scale(self : StatsdiststudentLayer, f : Double) -> StatsdiststudentLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentLayer::add(self : StatsdiststudentLayer, other : StatsdiststudentLayer) -> StatsdiststudentLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentLayer::copy(self : StatsdiststudentLayer) -> StatsdiststudentLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentLayer::fill(self : StatsdiststudentLayer, v : Double) -> StatsdiststudentLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentLayer::min(self : StatsdiststudentLayer) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentLayer::max(self : StatsdiststudentLayer) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentLayer::to_string(self : StatsdiststudentLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_buffer_make(size : Int) -> StatsdiststudentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentBuffer::len(self : StatsdiststudentBuffer) -> Int { self.size }

pub fn StatsdiststudentBuffer::get(self : StatsdiststudentBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentBuffer::set(self : StatsdiststudentBuffer, i : Int, v : Double) -> StatsdiststudentBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentBuffer::sum(self : StatsdiststudentBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentBuffer::mean(self : StatsdiststudentBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentBuffer::scale(self : StatsdiststudentBuffer, f : Double) -> StatsdiststudentBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentBuffer::add(self : StatsdiststudentBuffer, other : StatsdiststudentBuffer) -> StatsdiststudentBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentBuffer::copy(self : StatsdiststudentBuffer) -> StatsdiststudentBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentBuffer::fill(self : StatsdiststudentBuffer, v : Double) -> StatsdiststudentBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentBuffer::min(self : StatsdiststudentBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentBuffer::max(self : StatsdiststudentBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentBuffer::to_string(self : StatsdiststudentBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_cursor_make(size : Int) -> StatsdiststudentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentCursor::len(self : StatsdiststudentCursor) -> Int { self.size }

pub fn StatsdiststudentCursor::get(self : StatsdiststudentCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentCursor::set(self : StatsdiststudentCursor, i : Int, v : Double) -> StatsdiststudentCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentCursor::sum(self : StatsdiststudentCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentCursor::mean(self : StatsdiststudentCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentCursor::scale(self : StatsdiststudentCursor, f : Double) -> StatsdiststudentCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentCursor::add(self : StatsdiststudentCursor, other : StatsdiststudentCursor) -> StatsdiststudentCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentCursor::copy(self : StatsdiststudentCursor) -> StatsdiststudentCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentCursor::fill(self : StatsdiststudentCursor, v : Double) -> StatsdiststudentCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentCursor::min(self : StatsdiststudentCursor) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentCursor::max(self : StatsdiststudentCursor) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentCursor::to_string(self : StatsdiststudentCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_view_make(size : Int) -> StatsdiststudentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentView::len(self : StatsdiststudentView) -> Int { self.size }

pub fn StatsdiststudentView::get(self : StatsdiststudentView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentView::set(self : StatsdiststudentView, i : Int, v : Double) -> StatsdiststudentView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentView::sum(self : StatsdiststudentView) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentView::mean(self : StatsdiststudentView) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentView::scale(self : StatsdiststudentView, f : Double) -> StatsdiststudentView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentView::add(self : StatsdiststudentView, other : StatsdiststudentView) -> StatsdiststudentView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentView::copy(self : StatsdiststudentView) -> StatsdiststudentView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentView::fill(self : StatsdiststudentView, v : Double) -> StatsdiststudentView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentView::min(self : StatsdiststudentView) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentView::max(self : StatsdiststudentView) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentView::to_string(self : StatsdiststudentView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_range_make(size : Int) -> StatsdiststudentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentRange::len(self : StatsdiststudentRange) -> Int { self.size }

pub fn StatsdiststudentRange::get(self : StatsdiststudentRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentRange::set(self : StatsdiststudentRange, i : Int, v : Double) -> StatsdiststudentRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentRange::sum(self : StatsdiststudentRange) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentRange::mean(self : StatsdiststudentRange) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentRange::scale(self : StatsdiststudentRange, f : Double) -> StatsdiststudentRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentRange::add(self : StatsdiststudentRange, other : StatsdiststudentRange) -> StatsdiststudentRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentRange::copy(self : StatsdiststudentRange) -> StatsdiststudentRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentRange::fill(self : StatsdiststudentRange, v : Double) -> StatsdiststudentRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentRange::min(self : StatsdiststudentRange) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentRange::max(self : StatsdiststudentRange) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentRange::to_string(self : StatsdiststudentRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_slice_make(size : Int) -> StatsdiststudentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdiststudentSlice::len(self : StatsdiststudentSlice) -> Int { self.size }

pub fn StatsdiststudentSlice::get(self : StatsdiststudentSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdiststudentSlice::set(self : StatsdiststudentSlice, i : Int, v : Double) -> StatsdiststudentSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdiststudentSlice::sum(self : StatsdiststudentSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdiststudentSlice::mean(self : StatsdiststudentSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdiststudentSlice::scale(self : StatsdiststudentSlice, f : Double) -> StatsdiststudentSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentSlice::add(self : StatsdiststudentSlice, other : StatsdiststudentSlice) -> StatsdiststudentSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdiststudentSlice::copy(self : StatsdiststudentSlice) -> StatsdiststudentSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentSlice::fill(self : StatsdiststudentSlice, v : Double) -> StatsdiststudentSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdiststudentSlice::min(self : StatsdiststudentSlice) -> Double { @_common.min(self.data) }

pub fn StatsdiststudentSlice::max(self : StatsdiststudentSlice) -> Double { @_common.max(self.data) }

pub fn StatsdiststudentSlice::to_string(self : StatsdiststudentSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

