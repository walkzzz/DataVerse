///===
/// extcore/db_query_distributed

pub(all) struct DbquerydistributedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_distributed_make_point(x : Double, y : Double) -> DbquerydistributedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_distributed_make_point3(x : Double, y : Double, z : Double) -> DbquerydistributedPoint {
  { x, y, z, label: 0 }
}

pub fn DbquerydistributedPoint::x(self : DbquerydistributedPoint) -> Double { self.x }

pub fn DbquerydistributedPoint::y(self : DbquerydistributedPoint) -> Double { self.y }

pub fn DbquerydistributedPoint::z(self : DbquerydistributedPoint) -> Double { self.z }

pub fn DbquerydistributedPoint::label(self : DbquerydistributedPoint) -> Int { self.label }

pub fn DbquerydistributedPoint::dist(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbquerydistributedPoint::add(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbquerydistributedPoint::sub(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbquerydistributedPoint::scale(self : DbquerydistributedPoint, s : Double) -> DbquerydistributedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbquerydistributedPoint::dot(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbquerydistributedPoint::cross(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbquerydistributedPoint::norm(self : DbquerydistributedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbquerydistributedPoint::normalize(self : DbquerydistributedPoint) -> DbquerydistributedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerydistributedPoint::negate(self : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbquerydistributedPoint::mid(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbquerydistributedPoint::lerp(self : DbquerydistributedPoint, other : DbquerydistributedPoint, t : Double) -> DbquerydistributedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbquerydistributedPoint::to_string(self : DbquerydistributedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbquerydistributedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_distributed_make_series(vals : Array[Double], name : String) -> DbquerydistributedSeries {
  { vals, name, meta: 0 }
}

pub fn DbquerydistributedSeries::len(self : DbquerydistributedSeries) -> Int { self.vals.length() }

pub fn DbquerydistributedSeries::sum(self : DbquerydistributedSeries) -> Double { @_common.sum(self.vals) }

pub fn DbquerydistributedSeries::mean(self : DbquerydistributedSeries) -> Double { @_common.mean(self.vals) }

pub fn DbquerydistributedSeries::min(self : DbquerydistributedSeries) -> Double { @_common.min(self.vals) }

pub fn DbquerydistributedSeries::max(self : DbquerydistributedSeries) -> Double { @_common.max(self.vals) }

pub fn DbquerydistributedSeries::range(self : DbquerydistributedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbquerydistributedSeries::variance(self : DbquerydistributedSeries) -> Double { @_common.variance(self.vals) }

pub fn DbquerydistributedSeries::std(self : DbquerydistributedSeries) -> Double { @_common.std(self.vals) }

pub fn DbquerydistributedSeries::median(self : DbquerydistributedSeries) -> Double { @_common.median(self.vals) }

pub fn DbquerydistributedSeries::scale(self : DbquerydistributedSeries, f : Double) -> DbquerydistributedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbquerydistributedSeries::add(self : DbquerydistributedSeries, other : DbquerydistributedSeries) -> DbquerydistributedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbquerydistributedSeries::sub(self : DbquerydistributedSeries, other : DbquerydistributedSeries) -> DbquerydistributedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbquerydistributedSeries::normalize(self : DbquerydistributedSeries) -> DbquerydistributedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbquerydistributedSeries::cumsum(self : DbquerydistributedSeries) -> DbquerydistributedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbquerydistributedSeries::to_string(self : DbquerydistributedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerydistributedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_distributed_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerydistributedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_distributed_matrix_identity(n : Int) -> DbquerydistributedMatrix {
  let m = db_query_distributed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbquerydistributedMatrix::get(self : DbquerydistributedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbquerydistributedMatrix::transpose(self : DbquerydistributedMatrix) -> DbquerydistributedMatrix {
  let result = db_query_distributed_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbquerydistributedMatrix::add(self : DbquerydistributedMatrix, other : DbquerydistributedMatrix) -> DbquerydistributedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_distributed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbquerydistributedMatrix::scale(self : DbquerydistributedMatrix, s : Double) -> DbquerydistributedMatrix {
  let result = db_query_distributed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbquerydistributedMatrix::multiply(self : DbquerydistributedMatrix, other : DbquerydistributedMatrix) -> DbquerydistributedMatrix {
  if self.cols != other.rows { return db_query_distributed_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_distributed_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbquerydistributedMatrix::trace(self : DbquerydistributedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbquerydistributedMatrix::det(self : DbquerydistributedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbquerydistributedMatrix::norm(self : DbquerydistributedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbquerydistributedMatrix::to_string(self : DbquerydistributedMatrix) -> String {
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

pub(all) struct DbquerydistributedVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_distributed_make_vector(comps : Array[Double]) -> DbquerydistributedVector {
  { comps, dim: comps.length() }
}

pub fn db_query_distributed_vector_zero(dim : Int) -> DbquerydistributedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbquerydistributedVector::add(self : DbquerydistributedVector, other : DbquerydistributedVector) -> DbquerydistributedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerydistributedVector::sub(self : DbquerydistributedVector, other : DbquerydistributedVector) -> DbquerydistributedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerydistributedVector::scale(self : DbquerydistributedVector, s : Double) -> DbquerydistributedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbquerydistributedVector::dot(self : DbquerydistributedVector, other : DbquerydistributedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbquerydistributedVector::norm(self : DbquerydistributedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbquerydistributedVector::normalize(self : DbquerydistributedVector) -> DbquerydistributedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerydistributedVector::dist(self : DbquerydistributedVector, other : DbquerydistributedVector) -> Double {
  self.sub(other).norm()
}

pub fn DbquerydistributedVector::to_string(self : DbquerydistributedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerydistributedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_frame_make(size : Int) -> DbquerydistributedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedFrame::len(self : DbquerydistributedFrame) -> Int { self.size }

pub fn DbquerydistributedFrame::get(self : DbquerydistributedFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedFrame::set(self : DbquerydistributedFrame, i : Int, v : Double) -> DbquerydistributedFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedFrame::sum(self : DbquerydistributedFrame) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedFrame::mean(self : DbquerydistributedFrame) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedFrame::scale(self : DbquerydistributedFrame, f : Double) -> DbquerydistributedFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedFrame::add(self : DbquerydistributedFrame, other : DbquerydistributedFrame) -> DbquerydistributedFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedFrame::copy(self : DbquerydistributedFrame) -> DbquerydistributedFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedFrame::fill(self : DbquerydistributedFrame, v : Double) -> DbquerydistributedFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedFrame::min(self : DbquerydistributedFrame) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedFrame::max(self : DbquerydistributedFrame) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedFrame::to_string(self : DbquerydistributedFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_table_make(size : Int) -> DbquerydistributedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedTable::len(self : DbquerydistributedTable) -> Int { self.size }

pub fn DbquerydistributedTable::get(self : DbquerydistributedTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedTable::set(self : DbquerydistributedTable, i : Int, v : Double) -> DbquerydistributedTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedTable::sum(self : DbquerydistributedTable) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedTable::mean(self : DbquerydistributedTable) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedTable::scale(self : DbquerydistributedTable, f : Double) -> DbquerydistributedTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedTable::add(self : DbquerydistributedTable, other : DbquerydistributedTable) -> DbquerydistributedTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedTable::copy(self : DbquerydistributedTable) -> DbquerydistributedTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedTable::fill(self : DbquerydistributedTable, v : Double) -> DbquerydistributedTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedTable::min(self : DbquerydistributedTable) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedTable::max(self : DbquerydistributedTable) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedTable::to_string(self : DbquerydistributedTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_graphn_make(size : Int) -> DbquerydistributedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedGraphN::len(self : DbquerydistributedGraphN) -> Int { self.size }

pub fn DbquerydistributedGraphN::get(self : DbquerydistributedGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedGraphN::set(self : DbquerydistributedGraphN, i : Int, v : Double) -> DbquerydistributedGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedGraphN::sum(self : DbquerydistributedGraphN) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedGraphN::mean(self : DbquerydistributedGraphN) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedGraphN::scale(self : DbquerydistributedGraphN, f : Double) -> DbquerydistributedGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedGraphN::add(self : DbquerydistributedGraphN, other : DbquerydistributedGraphN) -> DbquerydistributedGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedGraphN::copy(self : DbquerydistributedGraphN) -> DbquerydistributedGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedGraphN::fill(self : DbquerydistributedGraphN, v : Double) -> DbquerydistributedGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedGraphN::min(self : DbquerydistributedGraphN) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedGraphN::max(self : DbquerydistributedGraphN) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedGraphN::to_string(self : DbquerydistributedGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_node_make(size : Int) -> DbquerydistributedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedNode::len(self : DbquerydistributedNode) -> Int { self.size }

pub fn DbquerydistributedNode::get(self : DbquerydistributedNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedNode::set(self : DbquerydistributedNode, i : Int, v : Double) -> DbquerydistributedNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedNode::sum(self : DbquerydistributedNode) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedNode::mean(self : DbquerydistributedNode) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedNode::scale(self : DbquerydistributedNode, f : Double) -> DbquerydistributedNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedNode::add(self : DbquerydistributedNode, other : DbquerydistributedNode) -> DbquerydistributedNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedNode::copy(self : DbquerydistributedNode) -> DbquerydistributedNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedNode::fill(self : DbquerydistributedNode, v : Double) -> DbquerydistributedNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedNode::min(self : DbquerydistributedNode) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedNode::max(self : DbquerydistributedNode) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedNode::to_string(self : DbquerydistributedNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_edge_make(size : Int) -> DbquerydistributedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedEdge::len(self : DbquerydistributedEdge) -> Int { self.size }

pub fn DbquerydistributedEdge::get(self : DbquerydistributedEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedEdge::set(self : DbquerydistributedEdge, i : Int, v : Double) -> DbquerydistributedEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedEdge::sum(self : DbquerydistributedEdge) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedEdge::mean(self : DbquerydistributedEdge) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedEdge::scale(self : DbquerydistributedEdge, f : Double) -> DbquerydistributedEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedEdge::add(self : DbquerydistributedEdge, other : DbquerydistributedEdge) -> DbquerydistributedEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedEdge::copy(self : DbquerydistributedEdge) -> DbquerydistributedEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedEdge::fill(self : DbquerydistributedEdge, v : Double) -> DbquerydistributedEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedEdge::min(self : DbquerydistributedEdge) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedEdge::max(self : DbquerydistributedEdge) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedEdge::to_string(self : DbquerydistributedEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_path_make(size : Int) -> DbquerydistributedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedPath::len(self : DbquerydistributedPath) -> Int { self.size }

pub fn DbquerydistributedPath::get(self : DbquerydistributedPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedPath::set(self : DbquerydistributedPath, i : Int, v : Double) -> DbquerydistributedPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedPath::sum(self : DbquerydistributedPath) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedPath::mean(self : DbquerydistributedPath) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedPath::scale(self : DbquerydistributedPath, f : Double) -> DbquerydistributedPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedPath::add(self : DbquerydistributedPath, other : DbquerydistributedPath) -> DbquerydistributedPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedPath::copy(self : DbquerydistributedPath) -> DbquerydistributedPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedPath::fill(self : DbquerydistributedPath, v : Double) -> DbquerydistributedPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedPath::min(self : DbquerydistributedPath) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedPath::max(self : DbquerydistributedPath) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedPath::to_string(self : DbquerydistributedPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_cluster_make(size : Int) -> DbquerydistributedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedCluster::len(self : DbquerydistributedCluster) -> Int { self.size }

pub fn DbquerydistributedCluster::get(self : DbquerydistributedCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedCluster::set(self : DbquerydistributedCluster, i : Int, v : Double) -> DbquerydistributedCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedCluster::sum(self : DbquerydistributedCluster) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedCluster::mean(self : DbquerydistributedCluster) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedCluster::scale(self : DbquerydistributedCluster, f : Double) -> DbquerydistributedCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedCluster::add(self : DbquerydistributedCluster, other : DbquerydistributedCluster) -> DbquerydistributedCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedCluster::copy(self : DbquerydistributedCluster) -> DbquerydistributedCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedCluster::fill(self : DbquerydistributedCluster, v : Double) -> DbquerydistributedCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedCluster::min(self : DbquerydistributedCluster) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedCluster::max(self : DbquerydistributedCluster) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedCluster::to_string(self : DbquerydistributedCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_model_make(size : Int) -> DbquerydistributedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedModel::len(self : DbquerydistributedModel) -> Int { self.size }

pub fn DbquerydistributedModel::get(self : DbquerydistributedModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedModel::set(self : DbquerydistributedModel, i : Int, v : Double) -> DbquerydistributedModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedModel::sum(self : DbquerydistributedModel) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedModel::mean(self : DbquerydistributedModel) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedModel::scale(self : DbquerydistributedModel, f : Double) -> DbquerydistributedModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedModel::add(self : DbquerydistributedModel, other : DbquerydistributedModel) -> DbquerydistributedModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedModel::copy(self : DbquerydistributedModel) -> DbquerydistributedModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedModel::fill(self : DbquerydistributedModel, v : Double) -> DbquerydistributedModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedModel::min(self : DbquerydistributedModel) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedModel::max(self : DbquerydistributedModel) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedModel::to_string(self : DbquerydistributedModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_layer_make(size : Int) -> DbquerydistributedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedLayer::len(self : DbquerydistributedLayer) -> Int { self.size }

pub fn DbquerydistributedLayer::get(self : DbquerydistributedLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedLayer::set(self : DbquerydistributedLayer, i : Int, v : Double) -> DbquerydistributedLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedLayer::sum(self : DbquerydistributedLayer) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedLayer::mean(self : DbquerydistributedLayer) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedLayer::scale(self : DbquerydistributedLayer, f : Double) -> DbquerydistributedLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedLayer::add(self : DbquerydistributedLayer, other : DbquerydistributedLayer) -> DbquerydistributedLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedLayer::copy(self : DbquerydistributedLayer) -> DbquerydistributedLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedLayer::fill(self : DbquerydistributedLayer, v : Double) -> DbquerydistributedLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedLayer::min(self : DbquerydistributedLayer) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedLayer::max(self : DbquerydistributedLayer) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedLayer::to_string(self : DbquerydistributedLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_buffer_make(size : Int) -> DbquerydistributedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedBuffer::len(self : DbquerydistributedBuffer) -> Int { self.size }

pub fn DbquerydistributedBuffer::get(self : DbquerydistributedBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedBuffer::set(self : DbquerydistributedBuffer, i : Int, v : Double) -> DbquerydistributedBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedBuffer::sum(self : DbquerydistributedBuffer) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedBuffer::mean(self : DbquerydistributedBuffer) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedBuffer::scale(self : DbquerydistributedBuffer, f : Double) -> DbquerydistributedBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedBuffer::add(self : DbquerydistributedBuffer, other : DbquerydistributedBuffer) -> DbquerydistributedBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedBuffer::copy(self : DbquerydistributedBuffer) -> DbquerydistributedBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedBuffer::fill(self : DbquerydistributedBuffer, v : Double) -> DbquerydistributedBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedBuffer::min(self : DbquerydistributedBuffer) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedBuffer::max(self : DbquerydistributedBuffer) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedBuffer::to_string(self : DbquerydistributedBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_cursor_make(size : Int) -> DbquerydistributedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedCursor::len(self : DbquerydistributedCursor) -> Int { self.size }

pub fn DbquerydistributedCursor::get(self : DbquerydistributedCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedCursor::set(self : DbquerydistributedCursor, i : Int, v : Double) -> DbquerydistributedCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedCursor::sum(self : DbquerydistributedCursor) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedCursor::mean(self : DbquerydistributedCursor) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedCursor::scale(self : DbquerydistributedCursor, f : Double) -> DbquerydistributedCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedCursor::add(self : DbquerydistributedCursor, other : DbquerydistributedCursor) -> DbquerydistributedCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedCursor::copy(self : DbquerydistributedCursor) -> DbquerydistributedCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedCursor::fill(self : DbquerydistributedCursor, v : Double) -> DbquerydistributedCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedCursor::min(self : DbquerydistributedCursor) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedCursor::max(self : DbquerydistributedCursor) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedCursor::to_string(self : DbquerydistributedCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_view_make(size : Int) -> DbquerydistributedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedView::len(self : DbquerydistributedView) -> Int { self.size }

pub fn DbquerydistributedView::get(self : DbquerydistributedView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedView::set(self : DbquerydistributedView, i : Int, v : Double) -> DbquerydistributedView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedView::sum(self : DbquerydistributedView) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedView::mean(self : DbquerydistributedView) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedView::scale(self : DbquerydistributedView, f : Double) -> DbquerydistributedView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedView::add(self : DbquerydistributedView, other : DbquerydistributedView) -> DbquerydistributedView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedView::copy(self : DbquerydistributedView) -> DbquerydistributedView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedView::fill(self : DbquerydistributedView, v : Double) -> DbquerydistributedView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedView::min(self : DbquerydistributedView) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedView::max(self : DbquerydistributedView) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedView::to_string(self : DbquerydistributedView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_range_make(size : Int) -> DbquerydistributedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedRange::len(self : DbquerydistributedRange) -> Int { self.size }

pub fn DbquerydistributedRange::get(self : DbquerydistributedRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedRange::set(self : DbquerydistributedRange, i : Int, v : Double) -> DbquerydistributedRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedRange::sum(self : DbquerydistributedRange) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedRange::mean(self : DbquerydistributedRange) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedRange::scale(self : DbquerydistributedRange, f : Double) -> DbquerydistributedRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedRange::add(self : DbquerydistributedRange, other : DbquerydistributedRange) -> DbquerydistributedRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedRange::copy(self : DbquerydistributedRange) -> DbquerydistributedRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedRange::fill(self : DbquerydistributedRange, v : Double) -> DbquerydistributedRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedRange::min(self : DbquerydistributedRange) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedRange::max(self : DbquerydistributedRange) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedRange::to_string(self : DbquerydistributedRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_slice_make(size : Int) -> DbquerydistributedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerydistributedSlice::len(self : DbquerydistributedSlice) -> Int { self.size }

pub fn DbquerydistributedSlice::get(self : DbquerydistributedSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerydistributedSlice::set(self : DbquerydistributedSlice, i : Int, v : Double) -> DbquerydistributedSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerydistributedSlice::sum(self : DbquerydistributedSlice) -> Double { @_common.sum(self.data) }

pub fn DbquerydistributedSlice::mean(self : DbquerydistributedSlice) -> Double { @_common.mean(self.data) }

pub fn DbquerydistributedSlice::scale(self : DbquerydistributedSlice, f : Double) -> DbquerydistributedSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedSlice::add(self : DbquerydistributedSlice, other : DbquerydistributedSlice) -> DbquerydistributedSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerydistributedSlice::copy(self : DbquerydistributedSlice) -> DbquerydistributedSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedSlice::fill(self : DbquerydistributedSlice, v : Double) -> DbquerydistributedSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerydistributedSlice::min(self : DbquerydistributedSlice) -> Double { @_common.min(self.data) }

pub fn DbquerydistributedSlice::max(self : DbquerydistributedSlice) -> Double { @_common.max(self.data) }

pub fn DbquerydistributedSlice::to_string(self : DbquerydistributedSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

