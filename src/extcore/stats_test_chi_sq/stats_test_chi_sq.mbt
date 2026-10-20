///===
/// extcore/stats_test_chi_sq

pub(all) struct StatstestchisqPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_chi_sq_make_point(x : Double, y : Double) -> StatstestchisqPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_chi_sq_make_point3(x : Double, y : Double, z : Double) -> StatstestchisqPoint {
  { x, y, z, label: 0 }
}

pub fn StatstestchisqPoint::x(self : StatstestchisqPoint) -> Double { self.x }

pub fn StatstestchisqPoint::y(self : StatstestchisqPoint) -> Double { self.y }

pub fn StatstestchisqPoint::z(self : StatstestchisqPoint) -> Double { self.z }

pub fn StatstestchisqPoint::label(self : StatstestchisqPoint) -> Int { self.label }

pub fn StatstestchisqPoint::dist(self : StatstestchisqPoint, other : StatstestchisqPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestchisqPoint::add(self : StatstestchisqPoint, other : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestchisqPoint::sub(self : StatstestchisqPoint, other : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestchisqPoint::scale(self : StatstestchisqPoint, s : Double) -> StatstestchisqPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestchisqPoint::dot(self : StatstestchisqPoint, other : StatstestchisqPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestchisqPoint::cross(self : StatstestchisqPoint, other : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestchisqPoint::norm(self : StatstestchisqPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestchisqPoint::normalize(self : StatstestchisqPoint) -> StatstestchisqPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestchisqPoint::negate(self : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestchisqPoint::mid(self : StatstestchisqPoint, other : StatstestchisqPoint) -> StatstestchisqPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestchisqPoint::lerp(self : StatstestchisqPoint, other : StatstestchisqPoint, t : Double) -> StatstestchisqPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestchisqPoint::to_string(self : StatstestchisqPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestchisqSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_chi_sq_make_series(vals : Array[Double], name : String) -> StatstestchisqSeries {
  { vals, name, meta: 0 }
}

pub fn StatstestchisqSeries::len(self : StatstestchisqSeries) -> Int { self.vals.length() }

pub fn StatstestchisqSeries::sum(self : StatstestchisqSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestchisqSeries::mean(self : StatstestchisqSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestchisqSeries::min(self : StatstestchisqSeries) -> Double { @_common.min(self.vals) }

pub fn StatstestchisqSeries::max(self : StatstestchisqSeries) -> Double { @_common.max(self.vals) }

pub fn StatstestchisqSeries::range(self : StatstestchisqSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestchisqSeries::variance(self : StatstestchisqSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestchisqSeries::std(self : StatstestchisqSeries) -> Double { @_common.std(self.vals) }

pub fn StatstestchisqSeries::median(self : StatstestchisqSeries) -> Double { @_common.median(self.vals) }

pub fn StatstestchisqSeries::scale(self : StatstestchisqSeries, f : Double) -> StatstestchisqSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestchisqSeries::add(self : StatstestchisqSeries, other : StatstestchisqSeries) -> StatstestchisqSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestchisqSeries::sub(self : StatstestchisqSeries, other : StatstestchisqSeries) -> StatstestchisqSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestchisqSeries::normalize(self : StatstestchisqSeries) -> StatstestchisqSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestchisqSeries::cumsum(self : StatstestchisqSeries) -> StatstestchisqSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestchisqSeries::to_string(self : StatstestchisqSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestchisqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_chi_sq_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestchisqMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_chi_sq_matrix_identity(n : Int) -> StatstestchisqMatrix {
  let m = stats_test_chi_sq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestchisqMatrix::get(self : StatstestchisqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestchisqMatrix::transpose(self : StatstestchisqMatrix) -> StatstestchisqMatrix {
  let result = stats_test_chi_sq_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestchisqMatrix::add(self : StatstestchisqMatrix, other : StatstestchisqMatrix) -> StatstestchisqMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_chi_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestchisqMatrix::scale(self : StatstestchisqMatrix, s : Double) -> StatstestchisqMatrix {
  let result = stats_test_chi_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestchisqMatrix::multiply(self : StatstestchisqMatrix, other : StatstestchisqMatrix) -> StatstestchisqMatrix {
  if self.cols != other.rows { return stats_test_chi_sq_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_chi_sq_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatstestchisqMatrix::trace(self : StatstestchisqMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestchisqMatrix::det(self : StatstestchisqMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestchisqMatrix::norm(self : StatstestchisqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestchisqMatrix::to_string(self : StatstestchisqMatrix) -> String {
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

pub(all) struct StatstestchisqVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_chi_sq_make_vector(comps : Array[Double]) -> StatstestchisqVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_chi_sq_vector_zero(dim : Int) -> StatstestchisqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestchisqVector::add(self : StatstestchisqVector, other : StatstestchisqVector) -> StatstestchisqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestchisqVector::sub(self : StatstestchisqVector, other : StatstestchisqVector) -> StatstestchisqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestchisqVector::scale(self : StatstestchisqVector, s : Double) -> StatstestchisqVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestchisqVector::dot(self : StatstestchisqVector, other : StatstestchisqVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestchisqVector::norm(self : StatstestchisqVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestchisqVector::normalize(self : StatstestchisqVector) -> StatstestchisqVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestchisqVector::dist(self : StatstestchisqVector, other : StatstestchisqVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestchisqVector::to_string(self : StatstestchisqVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestchisqFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_frame_make(size : Int) -> StatstestchisqFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqFrame::len(self : StatstestchisqFrame) -> Int { self.size }

pub fn StatstestchisqFrame::get(self : StatstestchisqFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqFrame::set(self : StatstestchisqFrame, i : Int, v : Double) -> StatstestchisqFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqFrame::sum(self : StatstestchisqFrame) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqFrame::mean(self : StatstestchisqFrame) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqFrame::scale(self : StatstestchisqFrame, f : Double) -> StatstestchisqFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqFrame::add(self : StatstestchisqFrame, other : StatstestchisqFrame) -> StatstestchisqFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqFrame::copy(self : StatstestchisqFrame) -> StatstestchisqFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqFrame::fill(self : StatstestchisqFrame, v : Double) -> StatstestchisqFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqFrame::min(self : StatstestchisqFrame) -> Double { @_common.min(self.data) }

pub fn StatstestchisqFrame::max(self : StatstestchisqFrame) -> Double { @_common.max(self.data) }

pub fn StatstestchisqFrame::to_string(self : StatstestchisqFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_table_make(size : Int) -> StatstestchisqTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqTable::len(self : StatstestchisqTable) -> Int { self.size }

pub fn StatstestchisqTable::get(self : StatstestchisqTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqTable::set(self : StatstestchisqTable, i : Int, v : Double) -> StatstestchisqTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqTable::sum(self : StatstestchisqTable) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqTable::mean(self : StatstestchisqTable) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqTable::scale(self : StatstestchisqTable, f : Double) -> StatstestchisqTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqTable::add(self : StatstestchisqTable, other : StatstestchisqTable) -> StatstestchisqTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqTable::copy(self : StatstestchisqTable) -> StatstestchisqTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqTable::fill(self : StatstestchisqTable, v : Double) -> StatstestchisqTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqTable::min(self : StatstestchisqTable) -> Double { @_common.min(self.data) }

pub fn StatstestchisqTable::max(self : StatstestchisqTable) -> Double { @_common.max(self.data) }

pub fn StatstestchisqTable::to_string(self : StatstestchisqTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_graphn_make(size : Int) -> StatstestchisqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqGraphN::len(self : StatstestchisqGraphN) -> Int { self.size }

pub fn StatstestchisqGraphN::get(self : StatstestchisqGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqGraphN::set(self : StatstestchisqGraphN, i : Int, v : Double) -> StatstestchisqGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqGraphN::sum(self : StatstestchisqGraphN) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqGraphN::mean(self : StatstestchisqGraphN) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqGraphN::scale(self : StatstestchisqGraphN, f : Double) -> StatstestchisqGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqGraphN::add(self : StatstestchisqGraphN, other : StatstestchisqGraphN) -> StatstestchisqGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqGraphN::copy(self : StatstestchisqGraphN) -> StatstestchisqGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqGraphN::fill(self : StatstestchisqGraphN, v : Double) -> StatstestchisqGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqGraphN::min(self : StatstestchisqGraphN) -> Double { @_common.min(self.data) }

pub fn StatstestchisqGraphN::max(self : StatstestchisqGraphN) -> Double { @_common.max(self.data) }

pub fn StatstestchisqGraphN::to_string(self : StatstestchisqGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_node_make(size : Int) -> StatstestchisqNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqNode::len(self : StatstestchisqNode) -> Int { self.size }

pub fn StatstestchisqNode::get(self : StatstestchisqNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqNode::set(self : StatstestchisqNode, i : Int, v : Double) -> StatstestchisqNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqNode::sum(self : StatstestchisqNode) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqNode::mean(self : StatstestchisqNode) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqNode::scale(self : StatstestchisqNode, f : Double) -> StatstestchisqNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqNode::add(self : StatstestchisqNode, other : StatstestchisqNode) -> StatstestchisqNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqNode::copy(self : StatstestchisqNode) -> StatstestchisqNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqNode::fill(self : StatstestchisqNode, v : Double) -> StatstestchisqNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqNode::min(self : StatstestchisqNode) -> Double { @_common.min(self.data) }

pub fn StatstestchisqNode::max(self : StatstestchisqNode) -> Double { @_common.max(self.data) }

pub fn StatstestchisqNode::to_string(self : StatstestchisqNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_edge_make(size : Int) -> StatstestchisqEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqEdge::len(self : StatstestchisqEdge) -> Int { self.size }

pub fn StatstestchisqEdge::get(self : StatstestchisqEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqEdge::set(self : StatstestchisqEdge, i : Int, v : Double) -> StatstestchisqEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqEdge::sum(self : StatstestchisqEdge) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqEdge::mean(self : StatstestchisqEdge) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqEdge::scale(self : StatstestchisqEdge, f : Double) -> StatstestchisqEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqEdge::add(self : StatstestchisqEdge, other : StatstestchisqEdge) -> StatstestchisqEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqEdge::copy(self : StatstestchisqEdge) -> StatstestchisqEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqEdge::fill(self : StatstestchisqEdge, v : Double) -> StatstestchisqEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqEdge::min(self : StatstestchisqEdge) -> Double { @_common.min(self.data) }

pub fn StatstestchisqEdge::max(self : StatstestchisqEdge) -> Double { @_common.max(self.data) }

pub fn StatstestchisqEdge::to_string(self : StatstestchisqEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_path_make(size : Int) -> StatstestchisqPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqPath::len(self : StatstestchisqPath) -> Int { self.size }

pub fn StatstestchisqPath::get(self : StatstestchisqPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqPath::set(self : StatstestchisqPath, i : Int, v : Double) -> StatstestchisqPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqPath::sum(self : StatstestchisqPath) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqPath::mean(self : StatstestchisqPath) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqPath::scale(self : StatstestchisqPath, f : Double) -> StatstestchisqPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqPath::add(self : StatstestchisqPath, other : StatstestchisqPath) -> StatstestchisqPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqPath::copy(self : StatstestchisqPath) -> StatstestchisqPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqPath::fill(self : StatstestchisqPath, v : Double) -> StatstestchisqPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqPath::min(self : StatstestchisqPath) -> Double { @_common.min(self.data) }

pub fn StatstestchisqPath::max(self : StatstestchisqPath) -> Double { @_common.max(self.data) }

pub fn StatstestchisqPath::to_string(self : StatstestchisqPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_cluster_make(size : Int) -> StatstestchisqCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqCluster::len(self : StatstestchisqCluster) -> Int { self.size }

pub fn StatstestchisqCluster::get(self : StatstestchisqCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqCluster::set(self : StatstestchisqCluster, i : Int, v : Double) -> StatstestchisqCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqCluster::sum(self : StatstestchisqCluster) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqCluster::mean(self : StatstestchisqCluster) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqCluster::scale(self : StatstestchisqCluster, f : Double) -> StatstestchisqCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqCluster::add(self : StatstestchisqCluster, other : StatstestchisqCluster) -> StatstestchisqCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqCluster::copy(self : StatstestchisqCluster) -> StatstestchisqCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqCluster::fill(self : StatstestchisqCluster, v : Double) -> StatstestchisqCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqCluster::min(self : StatstestchisqCluster) -> Double { @_common.min(self.data) }

pub fn StatstestchisqCluster::max(self : StatstestchisqCluster) -> Double { @_common.max(self.data) }

pub fn StatstestchisqCluster::to_string(self : StatstestchisqCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_model_make(size : Int) -> StatstestchisqModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqModel::len(self : StatstestchisqModel) -> Int { self.size }

pub fn StatstestchisqModel::get(self : StatstestchisqModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqModel::set(self : StatstestchisqModel, i : Int, v : Double) -> StatstestchisqModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqModel::sum(self : StatstestchisqModel) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqModel::mean(self : StatstestchisqModel) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqModel::scale(self : StatstestchisqModel, f : Double) -> StatstestchisqModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqModel::add(self : StatstestchisqModel, other : StatstestchisqModel) -> StatstestchisqModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqModel::copy(self : StatstestchisqModel) -> StatstestchisqModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqModel::fill(self : StatstestchisqModel, v : Double) -> StatstestchisqModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqModel::min(self : StatstestchisqModel) -> Double { @_common.min(self.data) }

pub fn StatstestchisqModel::max(self : StatstestchisqModel) -> Double { @_common.max(self.data) }

pub fn StatstestchisqModel::to_string(self : StatstestchisqModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_layer_make(size : Int) -> StatstestchisqLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqLayer::len(self : StatstestchisqLayer) -> Int { self.size }

pub fn StatstestchisqLayer::get(self : StatstestchisqLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqLayer::set(self : StatstestchisqLayer, i : Int, v : Double) -> StatstestchisqLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqLayer::sum(self : StatstestchisqLayer) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqLayer::mean(self : StatstestchisqLayer) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqLayer::scale(self : StatstestchisqLayer, f : Double) -> StatstestchisqLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqLayer::add(self : StatstestchisqLayer, other : StatstestchisqLayer) -> StatstestchisqLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqLayer::copy(self : StatstestchisqLayer) -> StatstestchisqLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqLayer::fill(self : StatstestchisqLayer, v : Double) -> StatstestchisqLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqLayer::min(self : StatstestchisqLayer) -> Double { @_common.min(self.data) }

pub fn StatstestchisqLayer::max(self : StatstestchisqLayer) -> Double { @_common.max(self.data) }

pub fn StatstestchisqLayer::to_string(self : StatstestchisqLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_buffer_make(size : Int) -> StatstestchisqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqBuffer::len(self : StatstestchisqBuffer) -> Int { self.size }

pub fn StatstestchisqBuffer::get(self : StatstestchisqBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqBuffer::set(self : StatstestchisqBuffer, i : Int, v : Double) -> StatstestchisqBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqBuffer::sum(self : StatstestchisqBuffer) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqBuffer::mean(self : StatstestchisqBuffer) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqBuffer::scale(self : StatstestchisqBuffer, f : Double) -> StatstestchisqBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqBuffer::add(self : StatstestchisqBuffer, other : StatstestchisqBuffer) -> StatstestchisqBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqBuffer::copy(self : StatstestchisqBuffer) -> StatstestchisqBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqBuffer::fill(self : StatstestchisqBuffer, v : Double) -> StatstestchisqBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqBuffer::min(self : StatstestchisqBuffer) -> Double { @_common.min(self.data) }

pub fn StatstestchisqBuffer::max(self : StatstestchisqBuffer) -> Double { @_common.max(self.data) }

pub fn StatstestchisqBuffer::to_string(self : StatstestchisqBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_cursor_make(size : Int) -> StatstestchisqCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqCursor::len(self : StatstestchisqCursor) -> Int { self.size }

pub fn StatstestchisqCursor::get(self : StatstestchisqCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqCursor::set(self : StatstestchisqCursor, i : Int, v : Double) -> StatstestchisqCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqCursor::sum(self : StatstestchisqCursor) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqCursor::mean(self : StatstestchisqCursor) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqCursor::scale(self : StatstestchisqCursor, f : Double) -> StatstestchisqCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqCursor::add(self : StatstestchisqCursor, other : StatstestchisqCursor) -> StatstestchisqCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqCursor::copy(self : StatstestchisqCursor) -> StatstestchisqCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqCursor::fill(self : StatstestchisqCursor, v : Double) -> StatstestchisqCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqCursor::min(self : StatstestchisqCursor) -> Double { @_common.min(self.data) }

pub fn StatstestchisqCursor::max(self : StatstestchisqCursor) -> Double { @_common.max(self.data) }

pub fn StatstestchisqCursor::to_string(self : StatstestchisqCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_view_make(size : Int) -> StatstestchisqView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqView::len(self : StatstestchisqView) -> Int { self.size }

pub fn StatstestchisqView::get(self : StatstestchisqView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqView::set(self : StatstestchisqView, i : Int, v : Double) -> StatstestchisqView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqView::sum(self : StatstestchisqView) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqView::mean(self : StatstestchisqView) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqView::scale(self : StatstestchisqView, f : Double) -> StatstestchisqView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqView::add(self : StatstestchisqView, other : StatstestchisqView) -> StatstestchisqView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqView::copy(self : StatstestchisqView) -> StatstestchisqView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqView::fill(self : StatstestchisqView, v : Double) -> StatstestchisqView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqView::min(self : StatstestchisqView) -> Double { @_common.min(self.data) }

pub fn StatstestchisqView::max(self : StatstestchisqView) -> Double { @_common.max(self.data) }

pub fn StatstestchisqView::to_string(self : StatstestchisqView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_range_make(size : Int) -> StatstestchisqRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqRange::len(self : StatstestchisqRange) -> Int { self.size }

pub fn StatstestchisqRange::get(self : StatstestchisqRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqRange::set(self : StatstestchisqRange, i : Int, v : Double) -> StatstestchisqRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqRange::sum(self : StatstestchisqRange) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqRange::mean(self : StatstestchisqRange) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqRange::scale(self : StatstestchisqRange, f : Double) -> StatstestchisqRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqRange::add(self : StatstestchisqRange, other : StatstestchisqRange) -> StatstestchisqRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqRange::copy(self : StatstestchisqRange) -> StatstestchisqRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqRange::fill(self : StatstestchisqRange, v : Double) -> StatstestchisqRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqRange::min(self : StatstestchisqRange) -> Double { @_common.min(self.data) }

pub fn StatstestchisqRange::max(self : StatstestchisqRange) -> Double { @_common.max(self.data) }

pub fn StatstestchisqRange::to_string(self : StatstestchisqRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestchisqSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_chi_sq_slice_make(size : Int) -> StatstestchisqSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestchisqSlice::len(self : StatstestchisqSlice) -> Int { self.size }

pub fn StatstestchisqSlice::get(self : StatstestchisqSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestchisqSlice::set(self : StatstestchisqSlice, i : Int, v : Double) -> StatstestchisqSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestchisqSlice::sum(self : StatstestchisqSlice) -> Double { @_common.sum(self.data) }

pub fn StatstestchisqSlice::mean(self : StatstestchisqSlice) -> Double { @_common.mean(self.data) }

pub fn StatstestchisqSlice::scale(self : StatstestchisqSlice, f : Double) -> StatstestchisqSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestchisqSlice::add(self : StatstestchisqSlice, other : StatstestchisqSlice) -> StatstestchisqSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestchisqSlice::copy(self : StatstestchisqSlice) -> StatstestchisqSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestchisqSlice::fill(self : StatstestchisqSlice, v : Double) -> StatstestchisqSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestchisqSlice::min(self : StatstestchisqSlice) -> Double { @_common.min(self.data) }

pub fn StatstestchisqSlice::max(self : StatstestchisqSlice) -> Double { @_common.max(self.data) }

pub fn StatstestchisqSlice::to_string(self : StatstestchisqSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

