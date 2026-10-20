///===
/// extcore/stats_dist_chi_sq

pub(all) struct StatsdistchisqPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_chi_sq_make_point(x : Double, y : Double) -> StatsdistchisqPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_chi_sq_make_point3(x : Double, y : Double, z : Double) -> StatsdistchisqPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistchisqPoint::x(self : StatsdistchisqPoint) -> Double { self.x }

pub fn StatsdistchisqPoint::y(self : StatsdistchisqPoint) -> Double { self.y }

pub fn StatsdistchisqPoint::z(self : StatsdistchisqPoint) -> Double { self.z }

pub fn StatsdistchisqPoint::label(self : StatsdistchisqPoint) -> Int { self.label }

pub fn StatsdistchisqPoint::dist(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistchisqPoint::add(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistchisqPoint::sub(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistchisqPoint::scale(self : StatsdistchisqPoint, s : Double) -> StatsdistchisqPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistchisqPoint::dot(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistchisqPoint::cross(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistchisqPoint::norm(self : StatsdistchisqPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistchisqPoint::normalize(self : StatsdistchisqPoint) -> StatsdistchisqPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistchisqPoint::negate(self : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistchisqPoint::mid(self : StatsdistchisqPoint, other : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistchisqPoint::lerp(self : StatsdistchisqPoint, other : StatsdistchisqPoint, t : Double) -> StatsdistchisqPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistchisqPoint::to_string(self : StatsdistchisqPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistchisqSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_chi_sq_make_series(vals : Array[Double], name : String) -> StatsdistchisqSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistchisqSeries::len(self : StatsdistchisqSeries) -> Int { self.vals.length() }

pub fn StatsdistchisqSeries::sum(self : StatsdistchisqSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistchisqSeries::mean(self : StatsdistchisqSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistchisqSeries::min(self : StatsdistchisqSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistchisqSeries::max(self : StatsdistchisqSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistchisqSeries::range(self : StatsdistchisqSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistchisqSeries::variance(self : StatsdistchisqSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistchisqSeries::std(self : StatsdistchisqSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistchisqSeries::median(self : StatsdistchisqSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistchisqSeries::scale(self : StatsdistchisqSeries, f : Double) -> StatsdistchisqSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistchisqSeries::add(self : StatsdistchisqSeries, other : StatsdistchisqSeries) -> StatsdistchisqSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistchisqSeries::sub(self : StatsdistchisqSeries, other : StatsdistchisqSeries) -> StatsdistchisqSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistchisqSeries::normalize(self : StatsdistchisqSeries) -> StatsdistchisqSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistchisqSeries::cumsum(self : StatsdistchisqSeries) -> StatsdistchisqSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistchisqSeries::to_string(self : StatsdistchisqSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistchisqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_chi_sq_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistchisqMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_chi_sq_matrix_identity(n : Int) -> StatsdistchisqMatrix {
  let m = stats_dist_chi_sq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistchisqMatrix::get(self : StatsdistchisqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistchisqMatrix::transpose(self : StatsdistchisqMatrix) -> StatsdistchisqMatrix {
  let result = stats_dist_chi_sq_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistchisqMatrix::add(self : StatsdistchisqMatrix, other : StatsdistchisqMatrix) -> StatsdistchisqMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_chi_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistchisqMatrix::scale(self : StatsdistchisqMatrix, s : Double) -> StatsdistchisqMatrix {
  let result = stats_dist_chi_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistchisqMatrix::multiply(self : StatsdistchisqMatrix, other : StatsdistchisqMatrix) -> StatsdistchisqMatrix {
  if self.cols != other.rows { return stats_dist_chi_sq_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_chi_sq_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistchisqMatrix::trace(self : StatsdistchisqMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistchisqMatrix::det(self : StatsdistchisqMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistchisqMatrix::norm(self : StatsdistchisqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistchisqMatrix::to_string(self : StatsdistchisqMatrix) -> String {
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

pub(all) struct StatsdistchisqVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_chi_sq_make_vector(comps : Array[Double]) -> StatsdistchisqVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_chi_sq_vector_zero(dim : Int) -> StatsdistchisqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistchisqVector::add(self : StatsdistchisqVector, other : StatsdistchisqVector) -> StatsdistchisqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistchisqVector::sub(self : StatsdistchisqVector, other : StatsdistchisqVector) -> StatsdistchisqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistchisqVector::scale(self : StatsdistchisqVector, s : Double) -> StatsdistchisqVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistchisqVector::dot(self : StatsdistchisqVector, other : StatsdistchisqVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistchisqVector::norm(self : StatsdistchisqVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistchisqVector::normalize(self : StatsdistchisqVector) -> StatsdistchisqVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistchisqVector::dist(self : StatsdistchisqVector, other : StatsdistchisqVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistchisqVector::to_string(self : StatsdistchisqVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistchisqFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_frame_make(size : Int) -> StatsdistchisqFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqFrame::len(self : StatsdistchisqFrame) -> Int { self.size }

pub fn StatsdistchisqFrame::get(self : StatsdistchisqFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqFrame::set(self : StatsdistchisqFrame, i : Int, v : Double) -> StatsdistchisqFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqFrame::sum(self : StatsdistchisqFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqFrame::mean(self : StatsdistchisqFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqFrame::scale(self : StatsdistchisqFrame, f : Double) -> StatsdistchisqFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqFrame::add(self : StatsdistchisqFrame, other : StatsdistchisqFrame) -> StatsdistchisqFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqFrame::copy(self : StatsdistchisqFrame) -> StatsdistchisqFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqFrame::fill(self : StatsdistchisqFrame, v : Double) -> StatsdistchisqFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqFrame::min(self : StatsdistchisqFrame) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqFrame::max(self : StatsdistchisqFrame) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqFrame::to_string(self : StatsdistchisqFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_table_make(size : Int) -> StatsdistchisqTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqTable::len(self : StatsdistchisqTable) -> Int { self.size }

pub fn StatsdistchisqTable::get(self : StatsdistchisqTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqTable::set(self : StatsdistchisqTable, i : Int, v : Double) -> StatsdistchisqTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqTable::sum(self : StatsdistchisqTable) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqTable::mean(self : StatsdistchisqTable) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqTable::scale(self : StatsdistchisqTable, f : Double) -> StatsdistchisqTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqTable::add(self : StatsdistchisqTable, other : StatsdistchisqTable) -> StatsdistchisqTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqTable::copy(self : StatsdistchisqTable) -> StatsdistchisqTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqTable::fill(self : StatsdistchisqTable, v : Double) -> StatsdistchisqTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqTable::min(self : StatsdistchisqTable) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqTable::max(self : StatsdistchisqTable) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqTable::to_string(self : StatsdistchisqTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_graphn_make(size : Int) -> StatsdistchisqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqGraphN::len(self : StatsdistchisqGraphN) -> Int { self.size }

pub fn StatsdistchisqGraphN::get(self : StatsdistchisqGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqGraphN::set(self : StatsdistchisqGraphN, i : Int, v : Double) -> StatsdistchisqGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqGraphN::sum(self : StatsdistchisqGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqGraphN::mean(self : StatsdistchisqGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqGraphN::scale(self : StatsdistchisqGraphN, f : Double) -> StatsdistchisqGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqGraphN::add(self : StatsdistchisqGraphN, other : StatsdistchisqGraphN) -> StatsdistchisqGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqGraphN::copy(self : StatsdistchisqGraphN) -> StatsdistchisqGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqGraphN::fill(self : StatsdistchisqGraphN, v : Double) -> StatsdistchisqGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqGraphN::min(self : StatsdistchisqGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqGraphN::max(self : StatsdistchisqGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqGraphN::to_string(self : StatsdistchisqGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_node_make(size : Int) -> StatsdistchisqNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqNode::len(self : StatsdistchisqNode) -> Int { self.size }

pub fn StatsdistchisqNode::get(self : StatsdistchisqNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqNode::set(self : StatsdistchisqNode, i : Int, v : Double) -> StatsdistchisqNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqNode::sum(self : StatsdistchisqNode) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqNode::mean(self : StatsdistchisqNode) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqNode::scale(self : StatsdistchisqNode, f : Double) -> StatsdistchisqNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqNode::add(self : StatsdistchisqNode, other : StatsdistchisqNode) -> StatsdistchisqNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqNode::copy(self : StatsdistchisqNode) -> StatsdistchisqNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqNode::fill(self : StatsdistchisqNode, v : Double) -> StatsdistchisqNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqNode::min(self : StatsdistchisqNode) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqNode::max(self : StatsdistchisqNode) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqNode::to_string(self : StatsdistchisqNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_edge_make(size : Int) -> StatsdistchisqEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqEdge::len(self : StatsdistchisqEdge) -> Int { self.size }

pub fn StatsdistchisqEdge::get(self : StatsdistchisqEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqEdge::set(self : StatsdistchisqEdge, i : Int, v : Double) -> StatsdistchisqEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqEdge::sum(self : StatsdistchisqEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqEdge::mean(self : StatsdistchisqEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqEdge::scale(self : StatsdistchisqEdge, f : Double) -> StatsdistchisqEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqEdge::add(self : StatsdistchisqEdge, other : StatsdistchisqEdge) -> StatsdistchisqEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqEdge::copy(self : StatsdistchisqEdge) -> StatsdistchisqEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqEdge::fill(self : StatsdistchisqEdge, v : Double) -> StatsdistchisqEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqEdge::min(self : StatsdistchisqEdge) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqEdge::max(self : StatsdistchisqEdge) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqEdge::to_string(self : StatsdistchisqEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_path_make(size : Int) -> StatsdistchisqPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqPath::len(self : StatsdistchisqPath) -> Int { self.size }

pub fn StatsdistchisqPath::get(self : StatsdistchisqPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqPath::set(self : StatsdistchisqPath, i : Int, v : Double) -> StatsdistchisqPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqPath::sum(self : StatsdistchisqPath) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqPath::mean(self : StatsdistchisqPath) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqPath::scale(self : StatsdistchisqPath, f : Double) -> StatsdistchisqPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqPath::add(self : StatsdistchisqPath, other : StatsdistchisqPath) -> StatsdistchisqPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqPath::copy(self : StatsdistchisqPath) -> StatsdistchisqPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqPath::fill(self : StatsdistchisqPath, v : Double) -> StatsdistchisqPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqPath::min(self : StatsdistchisqPath) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqPath::max(self : StatsdistchisqPath) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqPath::to_string(self : StatsdistchisqPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_cluster_make(size : Int) -> StatsdistchisqCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqCluster::len(self : StatsdistchisqCluster) -> Int { self.size }

pub fn StatsdistchisqCluster::get(self : StatsdistchisqCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqCluster::set(self : StatsdistchisqCluster, i : Int, v : Double) -> StatsdistchisqCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqCluster::sum(self : StatsdistchisqCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqCluster::mean(self : StatsdistchisqCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqCluster::scale(self : StatsdistchisqCluster, f : Double) -> StatsdistchisqCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqCluster::add(self : StatsdistchisqCluster, other : StatsdistchisqCluster) -> StatsdistchisqCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqCluster::copy(self : StatsdistchisqCluster) -> StatsdistchisqCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqCluster::fill(self : StatsdistchisqCluster, v : Double) -> StatsdistchisqCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqCluster::min(self : StatsdistchisqCluster) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqCluster::max(self : StatsdistchisqCluster) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqCluster::to_string(self : StatsdistchisqCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_model_make(size : Int) -> StatsdistchisqModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqModel::len(self : StatsdistchisqModel) -> Int { self.size }

pub fn StatsdistchisqModel::get(self : StatsdistchisqModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqModel::set(self : StatsdistchisqModel, i : Int, v : Double) -> StatsdistchisqModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqModel::sum(self : StatsdistchisqModel) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqModel::mean(self : StatsdistchisqModel) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqModel::scale(self : StatsdistchisqModel, f : Double) -> StatsdistchisqModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqModel::add(self : StatsdistchisqModel, other : StatsdistchisqModel) -> StatsdistchisqModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqModel::copy(self : StatsdistchisqModel) -> StatsdistchisqModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqModel::fill(self : StatsdistchisqModel, v : Double) -> StatsdistchisqModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqModel::min(self : StatsdistchisqModel) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqModel::max(self : StatsdistchisqModel) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqModel::to_string(self : StatsdistchisqModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_layer_make(size : Int) -> StatsdistchisqLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqLayer::len(self : StatsdistchisqLayer) -> Int { self.size }

pub fn StatsdistchisqLayer::get(self : StatsdistchisqLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqLayer::set(self : StatsdistchisqLayer, i : Int, v : Double) -> StatsdistchisqLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqLayer::sum(self : StatsdistchisqLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqLayer::mean(self : StatsdistchisqLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqLayer::scale(self : StatsdistchisqLayer, f : Double) -> StatsdistchisqLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqLayer::add(self : StatsdistchisqLayer, other : StatsdistchisqLayer) -> StatsdistchisqLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqLayer::copy(self : StatsdistchisqLayer) -> StatsdistchisqLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqLayer::fill(self : StatsdistchisqLayer, v : Double) -> StatsdistchisqLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqLayer::min(self : StatsdistchisqLayer) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqLayer::max(self : StatsdistchisqLayer) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqLayer::to_string(self : StatsdistchisqLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_buffer_make(size : Int) -> StatsdistchisqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqBuffer::len(self : StatsdistchisqBuffer) -> Int { self.size }

pub fn StatsdistchisqBuffer::get(self : StatsdistchisqBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqBuffer::set(self : StatsdistchisqBuffer, i : Int, v : Double) -> StatsdistchisqBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqBuffer::sum(self : StatsdistchisqBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqBuffer::mean(self : StatsdistchisqBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqBuffer::scale(self : StatsdistchisqBuffer, f : Double) -> StatsdistchisqBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqBuffer::add(self : StatsdistchisqBuffer, other : StatsdistchisqBuffer) -> StatsdistchisqBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqBuffer::copy(self : StatsdistchisqBuffer) -> StatsdistchisqBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqBuffer::fill(self : StatsdistchisqBuffer, v : Double) -> StatsdistchisqBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqBuffer::min(self : StatsdistchisqBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqBuffer::max(self : StatsdistchisqBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqBuffer::to_string(self : StatsdistchisqBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_cursor_make(size : Int) -> StatsdistchisqCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqCursor::len(self : StatsdistchisqCursor) -> Int { self.size }

pub fn StatsdistchisqCursor::get(self : StatsdistchisqCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqCursor::set(self : StatsdistchisqCursor, i : Int, v : Double) -> StatsdistchisqCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqCursor::sum(self : StatsdistchisqCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqCursor::mean(self : StatsdistchisqCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqCursor::scale(self : StatsdistchisqCursor, f : Double) -> StatsdistchisqCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqCursor::add(self : StatsdistchisqCursor, other : StatsdistchisqCursor) -> StatsdistchisqCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqCursor::copy(self : StatsdistchisqCursor) -> StatsdistchisqCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqCursor::fill(self : StatsdistchisqCursor, v : Double) -> StatsdistchisqCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqCursor::min(self : StatsdistchisqCursor) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqCursor::max(self : StatsdistchisqCursor) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqCursor::to_string(self : StatsdistchisqCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_view_make(size : Int) -> StatsdistchisqView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqView::len(self : StatsdistchisqView) -> Int { self.size }

pub fn StatsdistchisqView::get(self : StatsdistchisqView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqView::set(self : StatsdistchisqView, i : Int, v : Double) -> StatsdistchisqView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqView::sum(self : StatsdistchisqView) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqView::mean(self : StatsdistchisqView) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqView::scale(self : StatsdistchisqView, f : Double) -> StatsdistchisqView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqView::add(self : StatsdistchisqView, other : StatsdistchisqView) -> StatsdistchisqView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqView::copy(self : StatsdistchisqView) -> StatsdistchisqView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqView::fill(self : StatsdistchisqView, v : Double) -> StatsdistchisqView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqView::min(self : StatsdistchisqView) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqView::max(self : StatsdistchisqView) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqView::to_string(self : StatsdistchisqView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_range_make(size : Int) -> StatsdistchisqRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqRange::len(self : StatsdistchisqRange) -> Int { self.size }

pub fn StatsdistchisqRange::get(self : StatsdistchisqRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqRange::set(self : StatsdistchisqRange, i : Int, v : Double) -> StatsdistchisqRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqRange::sum(self : StatsdistchisqRange) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqRange::mean(self : StatsdistchisqRange) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqRange::scale(self : StatsdistchisqRange, f : Double) -> StatsdistchisqRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqRange::add(self : StatsdistchisqRange, other : StatsdistchisqRange) -> StatsdistchisqRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqRange::copy(self : StatsdistchisqRange) -> StatsdistchisqRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqRange::fill(self : StatsdistchisqRange, v : Double) -> StatsdistchisqRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqRange::min(self : StatsdistchisqRange) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqRange::max(self : StatsdistchisqRange) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqRange::to_string(self : StatsdistchisqRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_slice_make(size : Int) -> StatsdistchisqSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdistchisqSlice::len(self : StatsdistchisqSlice) -> Int { self.size }

pub fn StatsdistchisqSlice::get(self : StatsdistchisqSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdistchisqSlice::set(self : StatsdistchisqSlice, i : Int, v : Double) -> StatsdistchisqSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdistchisqSlice::sum(self : StatsdistchisqSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdistchisqSlice::mean(self : StatsdistchisqSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdistchisqSlice::scale(self : StatsdistchisqSlice, f : Double) -> StatsdistchisqSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqSlice::add(self : StatsdistchisqSlice, other : StatsdistchisqSlice) -> StatsdistchisqSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdistchisqSlice::copy(self : StatsdistchisqSlice) -> StatsdistchisqSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqSlice::fill(self : StatsdistchisqSlice, v : Double) -> StatsdistchisqSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdistchisqSlice::min(self : StatsdistchisqSlice) -> Double { @_common.min(self.data) }

pub fn StatsdistchisqSlice::max(self : StatsdistchisqSlice) -> Double { @_common.max(self.data) }

pub fn StatsdistchisqSlice::to_string(self : StatsdistchisqSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

