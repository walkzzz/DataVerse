///===
/// extcore/db_query_window

pub(all) struct DbquerywindowPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_window_make_point(x : Double, y : Double) -> DbquerywindowPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_window_make_point3(x : Double, y : Double, z : Double) -> DbquerywindowPoint {
  { x, y, z, label: 0 }
}

pub fn DbquerywindowPoint::x(self : DbquerywindowPoint) -> Double { self.x }

pub fn DbquerywindowPoint::y(self : DbquerywindowPoint) -> Double { self.y }

pub fn DbquerywindowPoint::z(self : DbquerywindowPoint) -> Double { self.z }

pub fn DbquerywindowPoint::label(self : DbquerywindowPoint) -> Int { self.label }

pub fn DbquerywindowPoint::dist(self : DbquerywindowPoint, other : DbquerywindowPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbquerywindowPoint::add(self : DbquerywindowPoint, other : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbquerywindowPoint::sub(self : DbquerywindowPoint, other : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbquerywindowPoint::scale(self : DbquerywindowPoint, s : Double) -> DbquerywindowPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbquerywindowPoint::dot(self : DbquerywindowPoint, other : DbquerywindowPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbquerywindowPoint::cross(self : DbquerywindowPoint, other : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbquerywindowPoint::norm(self : DbquerywindowPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbquerywindowPoint::normalize(self : DbquerywindowPoint) -> DbquerywindowPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerywindowPoint::negate(self : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbquerywindowPoint::mid(self : DbquerywindowPoint, other : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbquerywindowPoint::lerp(self : DbquerywindowPoint, other : DbquerywindowPoint, t : Double) -> DbquerywindowPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbquerywindowPoint::to_string(self : DbquerywindowPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbquerywindowSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_window_make_series(vals : Array[Double], name : String) -> DbquerywindowSeries {
  { vals, name, meta: 0 }
}

pub fn DbquerywindowSeries::len(self : DbquerywindowSeries) -> Int { self.vals.length() }

pub fn DbquerywindowSeries::sum(self : DbquerywindowSeries) -> Double { @_common.sum(self.vals) }

pub fn DbquerywindowSeries::mean(self : DbquerywindowSeries) -> Double { @_common.mean(self.vals) }

pub fn DbquerywindowSeries::min(self : DbquerywindowSeries) -> Double { @_common.min(self.vals) }

pub fn DbquerywindowSeries::max(self : DbquerywindowSeries) -> Double { @_common.max(self.vals) }

pub fn DbquerywindowSeries::range(self : DbquerywindowSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbquerywindowSeries::variance(self : DbquerywindowSeries) -> Double { @_common.variance(self.vals) }

pub fn DbquerywindowSeries::std(self : DbquerywindowSeries) -> Double { @_common.std(self.vals) }

pub fn DbquerywindowSeries::median(self : DbquerywindowSeries) -> Double { @_common.median(self.vals) }

pub fn DbquerywindowSeries::scale(self : DbquerywindowSeries, f : Double) -> DbquerywindowSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbquerywindowSeries::add(self : DbquerywindowSeries, other : DbquerywindowSeries) -> DbquerywindowSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbquerywindowSeries::sub(self : DbquerywindowSeries, other : DbquerywindowSeries) -> DbquerywindowSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbquerywindowSeries::normalize(self : DbquerywindowSeries) -> DbquerywindowSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbquerywindowSeries::cumsum(self : DbquerywindowSeries) -> DbquerywindowSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbquerywindowSeries::to_string(self : DbquerywindowSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerywindowMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_window_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerywindowMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_window_matrix_identity(n : Int) -> DbquerywindowMatrix {
  let m = db_query_window_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbquerywindowMatrix::get(self : DbquerywindowMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbquerywindowMatrix::transpose(self : DbquerywindowMatrix) -> DbquerywindowMatrix {
  let result = db_query_window_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbquerywindowMatrix::add(self : DbquerywindowMatrix, other : DbquerywindowMatrix) -> DbquerywindowMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_window_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbquerywindowMatrix::scale(self : DbquerywindowMatrix, s : Double) -> DbquerywindowMatrix {
  let result = db_query_window_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbquerywindowMatrix::multiply(self : DbquerywindowMatrix, other : DbquerywindowMatrix) -> DbquerywindowMatrix {
  if self.cols != other.rows { return db_query_window_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_window_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DbquerywindowMatrix::trace(self : DbquerywindowMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbquerywindowMatrix::det(self : DbquerywindowMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbquerywindowMatrix::norm(self : DbquerywindowMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbquerywindowMatrix::to_string(self : DbquerywindowMatrix) -> String {
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

pub(all) struct DbquerywindowVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_window_make_vector(comps : Array[Double]) -> DbquerywindowVector {
  { comps, dim: comps.length() }
}

pub fn db_query_window_vector_zero(dim : Int) -> DbquerywindowVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbquerywindowVector::add(self : DbquerywindowVector, other : DbquerywindowVector) -> DbquerywindowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerywindowVector::sub(self : DbquerywindowVector, other : DbquerywindowVector) -> DbquerywindowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerywindowVector::scale(self : DbquerywindowVector, s : Double) -> DbquerywindowVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbquerywindowVector::dot(self : DbquerywindowVector, other : DbquerywindowVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbquerywindowVector::norm(self : DbquerywindowVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbquerywindowVector::normalize(self : DbquerywindowVector) -> DbquerywindowVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerywindowVector::dist(self : DbquerywindowVector, other : DbquerywindowVector) -> Double {
  self.sub(other).norm()
}

pub fn DbquerywindowVector::to_string(self : DbquerywindowVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerywindowFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_frame_make(size : Int) -> DbquerywindowFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowFrame::len(self : DbquerywindowFrame) -> Int { self.size }

pub fn DbquerywindowFrame::get(self : DbquerywindowFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowFrame::set(self : DbquerywindowFrame, i : Int, v : Double) -> DbquerywindowFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowFrame::sum(self : DbquerywindowFrame) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowFrame::mean(self : DbquerywindowFrame) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowFrame::scale(self : DbquerywindowFrame, f : Double) -> DbquerywindowFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowFrame::add(self : DbquerywindowFrame, other : DbquerywindowFrame) -> DbquerywindowFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowFrame::copy(self : DbquerywindowFrame) -> DbquerywindowFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowFrame::fill(self : DbquerywindowFrame, v : Double) -> DbquerywindowFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowFrame::min(self : DbquerywindowFrame) -> Double { @_common.min(self.data) }

pub fn DbquerywindowFrame::max(self : DbquerywindowFrame) -> Double { @_common.max(self.data) }

pub fn DbquerywindowFrame::to_string(self : DbquerywindowFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_table_make(size : Int) -> DbquerywindowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowTable::len(self : DbquerywindowTable) -> Int { self.size }

pub fn DbquerywindowTable::get(self : DbquerywindowTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowTable::set(self : DbquerywindowTable, i : Int, v : Double) -> DbquerywindowTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowTable::sum(self : DbquerywindowTable) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowTable::mean(self : DbquerywindowTable) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowTable::scale(self : DbquerywindowTable, f : Double) -> DbquerywindowTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowTable::add(self : DbquerywindowTable, other : DbquerywindowTable) -> DbquerywindowTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowTable::copy(self : DbquerywindowTable) -> DbquerywindowTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowTable::fill(self : DbquerywindowTable, v : Double) -> DbquerywindowTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowTable::min(self : DbquerywindowTable) -> Double { @_common.min(self.data) }

pub fn DbquerywindowTable::max(self : DbquerywindowTable) -> Double { @_common.max(self.data) }

pub fn DbquerywindowTable::to_string(self : DbquerywindowTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_graphn_make(size : Int) -> DbquerywindowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowGraphN::len(self : DbquerywindowGraphN) -> Int { self.size }

pub fn DbquerywindowGraphN::get(self : DbquerywindowGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowGraphN::set(self : DbquerywindowGraphN, i : Int, v : Double) -> DbquerywindowGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowGraphN::sum(self : DbquerywindowGraphN) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowGraphN::mean(self : DbquerywindowGraphN) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowGraphN::scale(self : DbquerywindowGraphN, f : Double) -> DbquerywindowGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowGraphN::add(self : DbquerywindowGraphN, other : DbquerywindowGraphN) -> DbquerywindowGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowGraphN::copy(self : DbquerywindowGraphN) -> DbquerywindowGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowGraphN::fill(self : DbquerywindowGraphN, v : Double) -> DbquerywindowGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowGraphN::min(self : DbquerywindowGraphN) -> Double { @_common.min(self.data) }

pub fn DbquerywindowGraphN::max(self : DbquerywindowGraphN) -> Double { @_common.max(self.data) }

pub fn DbquerywindowGraphN::to_string(self : DbquerywindowGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_node_make(size : Int) -> DbquerywindowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowNode::len(self : DbquerywindowNode) -> Int { self.size }

pub fn DbquerywindowNode::get(self : DbquerywindowNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowNode::set(self : DbquerywindowNode, i : Int, v : Double) -> DbquerywindowNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowNode::sum(self : DbquerywindowNode) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowNode::mean(self : DbquerywindowNode) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowNode::scale(self : DbquerywindowNode, f : Double) -> DbquerywindowNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowNode::add(self : DbquerywindowNode, other : DbquerywindowNode) -> DbquerywindowNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowNode::copy(self : DbquerywindowNode) -> DbquerywindowNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowNode::fill(self : DbquerywindowNode, v : Double) -> DbquerywindowNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowNode::min(self : DbquerywindowNode) -> Double { @_common.min(self.data) }

pub fn DbquerywindowNode::max(self : DbquerywindowNode) -> Double { @_common.max(self.data) }

pub fn DbquerywindowNode::to_string(self : DbquerywindowNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_edge_make(size : Int) -> DbquerywindowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowEdge::len(self : DbquerywindowEdge) -> Int { self.size }

pub fn DbquerywindowEdge::get(self : DbquerywindowEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowEdge::set(self : DbquerywindowEdge, i : Int, v : Double) -> DbquerywindowEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowEdge::sum(self : DbquerywindowEdge) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowEdge::mean(self : DbquerywindowEdge) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowEdge::scale(self : DbquerywindowEdge, f : Double) -> DbquerywindowEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowEdge::add(self : DbquerywindowEdge, other : DbquerywindowEdge) -> DbquerywindowEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowEdge::copy(self : DbquerywindowEdge) -> DbquerywindowEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowEdge::fill(self : DbquerywindowEdge, v : Double) -> DbquerywindowEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowEdge::min(self : DbquerywindowEdge) -> Double { @_common.min(self.data) }

pub fn DbquerywindowEdge::max(self : DbquerywindowEdge) -> Double { @_common.max(self.data) }

pub fn DbquerywindowEdge::to_string(self : DbquerywindowEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_path_make(size : Int) -> DbquerywindowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowPath::len(self : DbquerywindowPath) -> Int { self.size }

pub fn DbquerywindowPath::get(self : DbquerywindowPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowPath::set(self : DbquerywindowPath, i : Int, v : Double) -> DbquerywindowPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowPath::sum(self : DbquerywindowPath) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowPath::mean(self : DbquerywindowPath) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowPath::scale(self : DbquerywindowPath, f : Double) -> DbquerywindowPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowPath::add(self : DbquerywindowPath, other : DbquerywindowPath) -> DbquerywindowPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowPath::copy(self : DbquerywindowPath) -> DbquerywindowPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowPath::fill(self : DbquerywindowPath, v : Double) -> DbquerywindowPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowPath::min(self : DbquerywindowPath) -> Double { @_common.min(self.data) }

pub fn DbquerywindowPath::max(self : DbquerywindowPath) -> Double { @_common.max(self.data) }

pub fn DbquerywindowPath::to_string(self : DbquerywindowPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_cluster_make(size : Int) -> DbquerywindowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowCluster::len(self : DbquerywindowCluster) -> Int { self.size }

pub fn DbquerywindowCluster::get(self : DbquerywindowCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowCluster::set(self : DbquerywindowCluster, i : Int, v : Double) -> DbquerywindowCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowCluster::sum(self : DbquerywindowCluster) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowCluster::mean(self : DbquerywindowCluster) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowCluster::scale(self : DbquerywindowCluster, f : Double) -> DbquerywindowCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowCluster::add(self : DbquerywindowCluster, other : DbquerywindowCluster) -> DbquerywindowCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowCluster::copy(self : DbquerywindowCluster) -> DbquerywindowCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowCluster::fill(self : DbquerywindowCluster, v : Double) -> DbquerywindowCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowCluster::min(self : DbquerywindowCluster) -> Double { @_common.min(self.data) }

pub fn DbquerywindowCluster::max(self : DbquerywindowCluster) -> Double { @_common.max(self.data) }

pub fn DbquerywindowCluster::to_string(self : DbquerywindowCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_model_make(size : Int) -> DbquerywindowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowModel::len(self : DbquerywindowModel) -> Int { self.size }

pub fn DbquerywindowModel::get(self : DbquerywindowModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowModel::set(self : DbquerywindowModel, i : Int, v : Double) -> DbquerywindowModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowModel::sum(self : DbquerywindowModel) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowModel::mean(self : DbquerywindowModel) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowModel::scale(self : DbquerywindowModel, f : Double) -> DbquerywindowModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowModel::add(self : DbquerywindowModel, other : DbquerywindowModel) -> DbquerywindowModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowModel::copy(self : DbquerywindowModel) -> DbquerywindowModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowModel::fill(self : DbquerywindowModel, v : Double) -> DbquerywindowModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowModel::min(self : DbquerywindowModel) -> Double { @_common.min(self.data) }

pub fn DbquerywindowModel::max(self : DbquerywindowModel) -> Double { @_common.max(self.data) }

pub fn DbquerywindowModel::to_string(self : DbquerywindowModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_layer_make(size : Int) -> DbquerywindowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowLayer::len(self : DbquerywindowLayer) -> Int { self.size }

pub fn DbquerywindowLayer::get(self : DbquerywindowLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowLayer::set(self : DbquerywindowLayer, i : Int, v : Double) -> DbquerywindowLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowLayer::sum(self : DbquerywindowLayer) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowLayer::mean(self : DbquerywindowLayer) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowLayer::scale(self : DbquerywindowLayer, f : Double) -> DbquerywindowLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowLayer::add(self : DbquerywindowLayer, other : DbquerywindowLayer) -> DbquerywindowLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowLayer::copy(self : DbquerywindowLayer) -> DbquerywindowLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowLayer::fill(self : DbquerywindowLayer, v : Double) -> DbquerywindowLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowLayer::min(self : DbquerywindowLayer) -> Double { @_common.min(self.data) }

pub fn DbquerywindowLayer::max(self : DbquerywindowLayer) -> Double { @_common.max(self.data) }

pub fn DbquerywindowLayer::to_string(self : DbquerywindowLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_buffer_make(size : Int) -> DbquerywindowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowBuffer::len(self : DbquerywindowBuffer) -> Int { self.size }

pub fn DbquerywindowBuffer::get(self : DbquerywindowBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowBuffer::set(self : DbquerywindowBuffer, i : Int, v : Double) -> DbquerywindowBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowBuffer::sum(self : DbquerywindowBuffer) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowBuffer::mean(self : DbquerywindowBuffer) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowBuffer::scale(self : DbquerywindowBuffer, f : Double) -> DbquerywindowBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowBuffer::add(self : DbquerywindowBuffer, other : DbquerywindowBuffer) -> DbquerywindowBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowBuffer::copy(self : DbquerywindowBuffer) -> DbquerywindowBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowBuffer::fill(self : DbquerywindowBuffer, v : Double) -> DbquerywindowBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowBuffer::min(self : DbquerywindowBuffer) -> Double { @_common.min(self.data) }

pub fn DbquerywindowBuffer::max(self : DbquerywindowBuffer) -> Double { @_common.max(self.data) }

pub fn DbquerywindowBuffer::to_string(self : DbquerywindowBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_cursor_make(size : Int) -> DbquerywindowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowCursor::len(self : DbquerywindowCursor) -> Int { self.size }

pub fn DbquerywindowCursor::get(self : DbquerywindowCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowCursor::set(self : DbquerywindowCursor, i : Int, v : Double) -> DbquerywindowCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowCursor::sum(self : DbquerywindowCursor) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowCursor::mean(self : DbquerywindowCursor) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowCursor::scale(self : DbquerywindowCursor, f : Double) -> DbquerywindowCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowCursor::add(self : DbquerywindowCursor, other : DbquerywindowCursor) -> DbquerywindowCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowCursor::copy(self : DbquerywindowCursor) -> DbquerywindowCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowCursor::fill(self : DbquerywindowCursor, v : Double) -> DbquerywindowCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowCursor::min(self : DbquerywindowCursor) -> Double { @_common.min(self.data) }

pub fn DbquerywindowCursor::max(self : DbquerywindowCursor) -> Double { @_common.max(self.data) }

pub fn DbquerywindowCursor::to_string(self : DbquerywindowCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_view_make(size : Int) -> DbquerywindowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowView::len(self : DbquerywindowView) -> Int { self.size }

pub fn DbquerywindowView::get(self : DbquerywindowView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowView::set(self : DbquerywindowView, i : Int, v : Double) -> DbquerywindowView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowView::sum(self : DbquerywindowView) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowView::mean(self : DbquerywindowView) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowView::scale(self : DbquerywindowView, f : Double) -> DbquerywindowView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowView::add(self : DbquerywindowView, other : DbquerywindowView) -> DbquerywindowView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowView::copy(self : DbquerywindowView) -> DbquerywindowView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowView::fill(self : DbquerywindowView, v : Double) -> DbquerywindowView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowView::min(self : DbquerywindowView) -> Double { @_common.min(self.data) }

pub fn DbquerywindowView::max(self : DbquerywindowView) -> Double { @_common.max(self.data) }

pub fn DbquerywindowView::to_string(self : DbquerywindowView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_range_make(size : Int) -> DbquerywindowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowRange::len(self : DbquerywindowRange) -> Int { self.size }

pub fn DbquerywindowRange::get(self : DbquerywindowRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowRange::set(self : DbquerywindowRange, i : Int, v : Double) -> DbquerywindowRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowRange::sum(self : DbquerywindowRange) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowRange::mean(self : DbquerywindowRange) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowRange::scale(self : DbquerywindowRange, f : Double) -> DbquerywindowRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowRange::add(self : DbquerywindowRange, other : DbquerywindowRange) -> DbquerywindowRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowRange::copy(self : DbquerywindowRange) -> DbquerywindowRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowRange::fill(self : DbquerywindowRange, v : Double) -> DbquerywindowRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowRange::min(self : DbquerywindowRange) -> Double { @_common.min(self.data) }

pub fn DbquerywindowRange::max(self : DbquerywindowRange) -> Double { @_common.max(self.data) }

pub fn DbquerywindowRange::to_string(self : DbquerywindowRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerywindowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_slice_make(size : Int) -> DbquerywindowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerywindowSlice::len(self : DbquerywindowSlice) -> Int { self.size }

pub fn DbquerywindowSlice::get(self : DbquerywindowSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerywindowSlice::set(self : DbquerywindowSlice, i : Int, v : Double) -> DbquerywindowSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerywindowSlice::sum(self : DbquerywindowSlice) -> Double { @_common.sum(self.data) }

pub fn DbquerywindowSlice::mean(self : DbquerywindowSlice) -> Double { @_common.mean(self.data) }

pub fn DbquerywindowSlice::scale(self : DbquerywindowSlice, f : Double) -> DbquerywindowSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerywindowSlice::add(self : DbquerywindowSlice, other : DbquerywindowSlice) -> DbquerywindowSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerywindowSlice::copy(self : DbquerywindowSlice) -> DbquerywindowSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerywindowSlice::fill(self : DbquerywindowSlice, v : Double) -> DbquerywindowSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerywindowSlice::min(self : DbquerywindowSlice) -> Double { @_common.min(self.data) }

pub fn DbquerywindowSlice::max(self : DbquerywindowSlice) -> Double { @_common.max(self.data) }

pub fn DbquerywindowSlice::to_string(self : DbquerywindowSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

