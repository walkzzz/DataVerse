///===
/// extcore/stats_test_t

pub(all) struct StatstesttPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_t_make_point(x : Double, y : Double) -> StatstesttPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_t_make_point3(x : Double, y : Double, z : Double) -> StatstesttPoint {
  { x, y, z, label: 0 }
}

pub fn StatstesttPoint::x(self : StatstesttPoint) -> Double { self.x }

pub fn StatstesttPoint::y(self : StatstesttPoint) -> Double { self.y }

pub fn StatstesttPoint::z(self : StatstesttPoint) -> Double { self.z }

pub fn StatstesttPoint::label(self : StatstesttPoint) -> Int { self.label }

pub fn StatstesttPoint::dist(self : StatstesttPoint, other : StatstesttPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstesttPoint::add(self : StatstesttPoint, other : StatstesttPoint) -> StatstesttPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstesttPoint::sub(self : StatstesttPoint, other : StatstesttPoint) -> StatstesttPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstesttPoint::scale(self : StatstesttPoint, s : Double) -> StatstesttPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstesttPoint::dot(self : StatstesttPoint, other : StatstesttPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstesttPoint::cross(self : StatstesttPoint, other : StatstesttPoint) -> StatstesttPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstesttPoint::norm(self : StatstesttPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstesttPoint::normalize(self : StatstesttPoint) -> StatstesttPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstesttPoint::negate(self : StatstesttPoint) -> StatstesttPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstesttPoint::mid(self : StatstesttPoint, other : StatstesttPoint) -> StatstesttPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstesttPoint::lerp(self : StatstesttPoint, other : StatstesttPoint, t : Double) -> StatstesttPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstesttPoint::to_string(self : StatstesttPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstesttSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_t_make_series(vals : Array[Double], name : String) -> StatstesttSeries {
  { vals, name, meta: 0 }
}

pub fn StatstesttSeries::len(self : StatstesttSeries) -> Int { self.vals.length() }

pub fn StatstesttSeries::sum(self : StatstesttSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstesttSeries::mean(self : StatstesttSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstesttSeries::min(self : StatstesttSeries) -> Double { @_common.min(self.vals) }

pub fn StatstesttSeries::max(self : StatstesttSeries) -> Double { @_common.max(self.vals) }

pub fn StatstesttSeries::range(self : StatstesttSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstesttSeries::variance(self : StatstesttSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstesttSeries::std(self : StatstesttSeries) -> Double { @_common.std(self.vals) }

pub fn StatstesttSeries::median(self : StatstesttSeries) -> Double { @_common.median(self.vals) }

pub fn StatstesttSeries::scale(self : StatstesttSeries, f : Double) -> StatstesttSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstesttSeries::add(self : StatstesttSeries, other : StatstesttSeries) -> StatstesttSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstesttSeries::sub(self : StatstesttSeries, other : StatstesttSeries) -> StatstesttSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstesttSeries::normalize(self : StatstesttSeries) -> StatstesttSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstesttSeries::cumsum(self : StatstesttSeries) -> StatstesttSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstesttSeries::to_string(self : StatstesttSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstesttMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_t_make_matrix(rows : Int, cols : Int, val : Double) -> StatstesttMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_t_matrix_identity(n : Int) -> StatstesttMatrix {
  let m = stats_test_t_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstesttMatrix::get(self : StatstesttMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstesttMatrix::transpose(self : StatstesttMatrix) -> StatstesttMatrix {
  let result = stats_test_t_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstesttMatrix::add(self : StatstesttMatrix, other : StatstesttMatrix) -> StatstesttMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_t_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstesttMatrix::scale(self : StatstesttMatrix, s : Double) -> StatstesttMatrix {
  let result = stats_test_t_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstesttMatrix::multiply(self : StatstesttMatrix, other : StatstesttMatrix) -> StatstesttMatrix {
  if self.cols != other.rows { return stats_test_t_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_t_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatstesttMatrix::trace(self : StatstesttMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstesttMatrix::det(self : StatstesttMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstesttMatrix::norm(self : StatstesttMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstesttMatrix::to_string(self : StatstesttMatrix) -> String {
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

pub(all) struct StatstesttVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_t_make_vector(comps : Array[Double]) -> StatstesttVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_t_vector_zero(dim : Int) -> StatstesttVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstesttVector::add(self : StatstesttVector, other : StatstesttVector) -> StatstesttVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstesttVector::sub(self : StatstesttVector, other : StatstesttVector) -> StatstesttVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstesttVector::scale(self : StatstesttVector, s : Double) -> StatstesttVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstesttVector::dot(self : StatstesttVector, other : StatstesttVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstesttVector::norm(self : StatstesttVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstesttVector::normalize(self : StatstesttVector) -> StatstesttVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstesttVector::dist(self : StatstesttVector, other : StatstesttVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstesttVector::to_string(self : StatstesttVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstesttFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_frame_make(size : Int) -> StatstesttFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttFrame::len(self : StatstesttFrame) -> Int { self.size }

pub fn StatstesttFrame::get(self : StatstesttFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttFrame::set(self : StatstesttFrame, i : Int, v : Double) -> StatstesttFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttFrame::sum(self : StatstesttFrame) -> Double { @_common.sum(self.data) }

pub fn StatstesttFrame::mean(self : StatstesttFrame) -> Double { @_common.mean(self.data) }

pub fn StatstesttFrame::scale(self : StatstesttFrame, f : Double) -> StatstesttFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttFrame::add(self : StatstesttFrame, other : StatstesttFrame) -> StatstesttFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttFrame::copy(self : StatstesttFrame) -> StatstesttFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttFrame::fill(self : StatstesttFrame, v : Double) -> StatstesttFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttFrame::min(self : StatstesttFrame) -> Double { @_common.min(self.data) }

pub fn StatstesttFrame::max(self : StatstesttFrame) -> Double { @_common.max(self.data) }

pub fn StatstesttFrame::to_string(self : StatstesttFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_table_make(size : Int) -> StatstesttTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttTable::len(self : StatstesttTable) -> Int { self.size }

pub fn StatstesttTable::get(self : StatstesttTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttTable::set(self : StatstesttTable, i : Int, v : Double) -> StatstesttTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttTable::sum(self : StatstesttTable) -> Double { @_common.sum(self.data) }

pub fn StatstesttTable::mean(self : StatstesttTable) -> Double { @_common.mean(self.data) }

pub fn StatstesttTable::scale(self : StatstesttTable, f : Double) -> StatstesttTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttTable::add(self : StatstesttTable, other : StatstesttTable) -> StatstesttTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttTable::copy(self : StatstesttTable) -> StatstesttTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttTable::fill(self : StatstesttTable, v : Double) -> StatstesttTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttTable::min(self : StatstesttTable) -> Double { @_common.min(self.data) }

pub fn StatstesttTable::max(self : StatstesttTable) -> Double { @_common.max(self.data) }

pub fn StatstesttTable::to_string(self : StatstesttTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_graphn_make(size : Int) -> StatstesttGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttGraphN::len(self : StatstesttGraphN) -> Int { self.size }

pub fn StatstesttGraphN::get(self : StatstesttGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttGraphN::set(self : StatstesttGraphN, i : Int, v : Double) -> StatstesttGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttGraphN::sum(self : StatstesttGraphN) -> Double { @_common.sum(self.data) }

pub fn StatstesttGraphN::mean(self : StatstesttGraphN) -> Double { @_common.mean(self.data) }

pub fn StatstesttGraphN::scale(self : StatstesttGraphN, f : Double) -> StatstesttGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttGraphN::add(self : StatstesttGraphN, other : StatstesttGraphN) -> StatstesttGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttGraphN::copy(self : StatstesttGraphN) -> StatstesttGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttGraphN::fill(self : StatstesttGraphN, v : Double) -> StatstesttGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttGraphN::min(self : StatstesttGraphN) -> Double { @_common.min(self.data) }

pub fn StatstesttGraphN::max(self : StatstesttGraphN) -> Double { @_common.max(self.data) }

pub fn StatstesttGraphN::to_string(self : StatstesttGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_node_make(size : Int) -> StatstesttNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttNode::len(self : StatstesttNode) -> Int { self.size }

pub fn StatstesttNode::get(self : StatstesttNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttNode::set(self : StatstesttNode, i : Int, v : Double) -> StatstesttNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttNode::sum(self : StatstesttNode) -> Double { @_common.sum(self.data) }

pub fn StatstesttNode::mean(self : StatstesttNode) -> Double { @_common.mean(self.data) }

pub fn StatstesttNode::scale(self : StatstesttNode, f : Double) -> StatstesttNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttNode::add(self : StatstesttNode, other : StatstesttNode) -> StatstesttNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttNode::copy(self : StatstesttNode) -> StatstesttNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttNode::fill(self : StatstesttNode, v : Double) -> StatstesttNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttNode::min(self : StatstesttNode) -> Double { @_common.min(self.data) }

pub fn StatstesttNode::max(self : StatstesttNode) -> Double { @_common.max(self.data) }

pub fn StatstesttNode::to_string(self : StatstesttNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_edge_make(size : Int) -> StatstesttEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttEdge::len(self : StatstesttEdge) -> Int { self.size }

pub fn StatstesttEdge::get(self : StatstesttEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttEdge::set(self : StatstesttEdge, i : Int, v : Double) -> StatstesttEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttEdge::sum(self : StatstesttEdge) -> Double { @_common.sum(self.data) }

pub fn StatstesttEdge::mean(self : StatstesttEdge) -> Double { @_common.mean(self.data) }

pub fn StatstesttEdge::scale(self : StatstesttEdge, f : Double) -> StatstesttEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttEdge::add(self : StatstesttEdge, other : StatstesttEdge) -> StatstesttEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttEdge::copy(self : StatstesttEdge) -> StatstesttEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttEdge::fill(self : StatstesttEdge, v : Double) -> StatstesttEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttEdge::min(self : StatstesttEdge) -> Double { @_common.min(self.data) }

pub fn StatstesttEdge::max(self : StatstesttEdge) -> Double { @_common.max(self.data) }

pub fn StatstesttEdge::to_string(self : StatstesttEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_path_make(size : Int) -> StatstesttPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttPath::len(self : StatstesttPath) -> Int { self.size }

pub fn StatstesttPath::get(self : StatstesttPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttPath::set(self : StatstesttPath, i : Int, v : Double) -> StatstesttPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttPath::sum(self : StatstesttPath) -> Double { @_common.sum(self.data) }

pub fn StatstesttPath::mean(self : StatstesttPath) -> Double { @_common.mean(self.data) }

pub fn StatstesttPath::scale(self : StatstesttPath, f : Double) -> StatstesttPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttPath::add(self : StatstesttPath, other : StatstesttPath) -> StatstesttPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttPath::copy(self : StatstesttPath) -> StatstesttPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttPath::fill(self : StatstesttPath, v : Double) -> StatstesttPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttPath::min(self : StatstesttPath) -> Double { @_common.min(self.data) }

pub fn StatstesttPath::max(self : StatstesttPath) -> Double { @_common.max(self.data) }

pub fn StatstesttPath::to_string(self : StatstesttPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_cluster_make(size : Int) -> StatstesttCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttCluster::len(self : StatstesttCluster) -> Int { self.size }

pub fn StatstesttCluster::get(self : StatstesttCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttCluster::set(self : StatstesttCluster, i : Int, v : Double) -> StatstesttCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttCluster::sum(self : StatstesttCluster) -> Double { @_common.sum(self.data) }

pub fn StatstesttCluster::mean(self : StatstesttCluster) -> Double { @_common.mean(self.data) }

pub fn StatstesttCluster::scale(self : StatstesttCluster, f : Double) -> StatstesttCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttCluster::add(self : StatstesttCluster, other : StatstesttCluster) -> StatstesttCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttCluster::copy(self : StatstesttCluster) -> StatstesttCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttCluster::fill(self : StatstesttCluster, v : Double) -> StatstesttCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttCluster::min(self : StatstesttCluster) -> Double { @_common.min(self.data) }

pub fn StatstesttCluster::max(self : StatstesttCluster) -> Double { @_common.max(self.data) }

pub fn StatstesttCluster::to_string(self : StatstesttCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_model_make(size : Int) -> StatstesttModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttModel::len(self : StatstesttModel) -> Int { self.size }

pub fn StatstesttModel::get(self : StatstesttModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttModel::set(self : StatstesttModel, i : Int, v : Double) -> StatstesttModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttModel::sum(self : StatstesttModel) -> Double { @_common.sum(self.data) }

pub fn StatstesttModel::mean(self : StatstesttModel) -> Double { @_common.mean(self.data) }

pub fn StatstesttModel::scale(self : StatstesttModel, f : Double) -> StatstesttModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttModel::add(self : StatstesttModel, other : StatstesttModel) -> StatstesttModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttModel::copy(self : StatstesttModel) -> StatstesttModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttModel::fill(self : StatstesttModel, v : Double) -> StatstesttModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttModel::min(self : StatstesttModel) -> Double { @_common.min(self.data) }

pub fn StatstesttModel::max(self : StatstesttModel) -> Double { @_common.max(self.data) }

pub fn StatstesttModel::to_string(self : StatstesttModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_layer_make(size : Int) -> StatstesttLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttLayer::len(self : StatstesttLayer) -> Int { self.size }

pub fn StatstesttLayer::get(self : StatstesttLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttLayer::set(self : StatstesttLayer, i : Int, v : Double) -> StatstesttLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttLayer::sum(self : StatstesttLayer) -> Double { @_common.sum(self.data) }

pub fn StatstesttLayer::mean(self : StatstesttLayer) -> Double { @_common.mean(self.data) }

pub fn StatstesttLayer::scale(self : StatstesttLayer, f : Double) -> StatstesttLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttLayer::add(self : StatstesttLayer, other : StatstesttLayer) -> StatstesttLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttLayer::copy(self : StatstesttLayer) -> StatstesttLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttLayer::fill(self : StatstesttLayer, v : Double) -> StatstesttLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttLayer::min(self : StatstesttLayer) -> Double { @_common.min(self.data) }

pub fn StatstesttLayer::max(self : StatstesttLayer) -> Double { @_common.max(self.data) }

pub fn StatstesttLayer::to_string(self : StatstesttLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_buffer_make(size : Int) -> StatstesttBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttBuffer::len(self : StatstesttBuffer) -> Int { self.size }

pub fn StatstesttBuffer::get(self : StatstesttBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttBuffer::set(self : StatstesttBuffer, i : Int, v : Double) -> StatstesttBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttBuffer::sum(self : StatstesttBuffer) -> Double { @_common.sum(self.data) }

pub fn StatstesttBuffer::mean(self : StatstesttBuffer) -> Double { @_common.mean(self.data) }

pub fn StatstesttBuffer::scale(self : StatstesttBuffer, f : Double) -> StatstesttBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttBuffer::add(self : StatstesttBuffer, other : StatstesttBuffer) -> StatstesttBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttBuffer::copy(self : StatstesttBuffer) -> StatstesttBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttBuffer::fill(self : StatstesttBuffer, v : Double) -> StatstesttBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttBuffer::min(self : StatstesttBuffer) -> Double { @_common.min(self.data) }

pub fn StatstesttBuffer::max(self : StatstesttBuffer) -> Double { @_common.max(self.data) }

pub fn StatstesttBuffer::to_string(self : StatstesttBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_cursor_make(size : Int) -> StatstesttCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttCursor::len(self : StatstesttCursor) -> Int { self.size }

pub fn StatstesttCursor::get(self : StatstesttCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttCursor::set(self : StatstesttCursor, i : Int, v : Double) -> StatstesttCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttCursor::sum(self : StatstesttCursor) -> Double { @_common.sum(self.data) }

pub fn StatstesttCursor::mean(self : StatstesttCursor) -> Double { @_common.mean(self.data) }

pub fn StatstesttCursor::scale(self : StatstesttCursor, f : Double) -> StatstesttCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttCursor::add(self : StatstesttCursor, other : StatstesttCursor) -> StatstesttCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttCursor::copy(self : StatstesttCursor) -> StatstesttCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttCursor::fill(self : StatstesttCursor, v : Double) -> StatstesttCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttCursor::min(self : StatstesttCursor) -> Double { @_common.min(self.data) }

pub fn StatstesttCursor::max(self : StatstesttCursor) -> Double { @_common.max(self.data) }

pub fn StatstesttCursor::to_string(self : StatstesttCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_view_make(size : Int) -> StatstesttView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttView::len(self : StatstesttView) -> Int { self.size }

pub fn StatstesttView::get(self : StatstesttView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttView::set(self : StatstesttView, i : Int, v : Double) -> StatstesttView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttView::sum(self : StatstesttView) -> Double { @_common.sum(self.data) }

pub fn StatstesttView::mean(self : StatstesttView) -> Double { @_common.mean(self.data) }

pub fn StatstesttView::scale(self : StatstesttView, f : Double) -> StatstesttView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttView::add(self : StatstesttView, other : StatstesttView) -> StatstesttView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttView::copy(self : StatstesttView) -> StatstesttView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttView::fill(self : StatstesttView, v : Double) -> StatstesttView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttView::min(self : StatstesttView) -> Double { @_common.min(self.data) }

pub fn StatstesttView::max(self : StatstesttView) -> Double { @_common.max(self.data) }

pub fn StatstesttView::to_string(self : StatstesttView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_range_make(size : Int) -> StatstesttRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttRange::len(self : StatstesttRange) -> Int { self.size }

pub fn StatstesttRange::get(self : StatstesttRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttRange::set(self : StatstesttRange, i : Int, v : Double) -> StatstesttRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttRange::sum(self : StatstesttRange) -> Double { @_common.sum(self.data) }

pub fn StatstesttRange::mean(self : StatstesttRange) -> Double { @_common.mean(self.data) }

pub fn StatstesttRange::scale(self : StatstesttRange, f : Double) -> StatstesttRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttRange::add(self : StatstesttRange, other : StatstesttRange) -> StatstesttRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttRange::copy(self : StatstesttRange) -> StatstesttRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttRange::fill(self : StatstesttRange, v : Double) -> StatstesttRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttRange::min(self : StatstesttRange) -> Double { @_common.min(self.data) }

pub fn StatstesttRange::max(self : StatstesttRange) -> Double { @_common.max(self.data) }

pub fn StatstesttRange::to_string(self : StatstesttRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstesttSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_slice_make(size : Int) -> StatstesttSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstesttSlice::len(self : StatstesttSlice) -> Int { self.size }

pub fn StatstesttSlice::get(self : StatstesttSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstesttSlice::set(self : StatstesttSlice, i : Int, v : Double) -> StatstesttSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstesttSlice::sum(self : StatstesttSlice) -> Double { @_common.sum(self.data) }

pub fn StatstesttSlice::mean(self : StatstesttSlice) -> Double { @_common.mean(self.data) }

pub fn StatstesttSlice::scale(self : StatstesttSlice, f : Double) -> StatstesttSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstesttSlice::add(self : StatstesttSlice, other : StatstesttSlice) -> StatstesttSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstesttSlice::copy(self : StatstesttSlice) -> StatstesttSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstesttSlice::fill(self : StatstesttSlice, v : Double) -> StatstesttSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstesttSlice::min(self : StatstesttSlice) -> Double { @_common.min(self.data) }

pub fn StatstesttSlice::max(self : StatstesttSlice) -> Double { @_common.max(self.data) }

pub fn StatstesttSlice::to_string(self : StatstesttSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

