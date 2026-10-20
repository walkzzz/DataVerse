///===
/// extcore/db_query_group

pub(all) struct DbquerygroupPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_group_make_point(x : Double, y : Double) -> DbquerygroupPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_group_make_point3(x : Double, y : Double, z : Double) -> DbquerygroupPoint {
  { x, y, z, label: 0 }
}

pub fn DbquerygroupPoint::x(self : DbquerygroupPoint) -> Double { self.x }

pub fn DbquerygroupPoint::y(self : DbquerygroupPoint) -> Double { self.y }

pub fn DbquerygroupPoint::z(self : DbquerygroupPoint) -> Double { self.z }

pub fn DbquerygroupPoint::label(self : DbquerygroupPoint) -> Int { self.label }

pub fn DbquerygroupPoint::dist(self : DbquerygroupPoint, other : DbquerygroupPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbquerygroupPoint::add(self : DbquerygroupPoint, other : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbquerygroupPoint::sub(self : DbquerygroupPoint, other : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbquerygroupPoint::scale(self : DbquerygroupPoint, s : Double) -> DbquerygroupPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbquerygroupPoint::dot(self : DbquerygroupPoint, other : DbquerygroupPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbquerygroupPoint::cross(self : DbquerygroupPoint, other : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbquerygroupPoint::norm(self : DbquerygroupPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbquerygroupPoint::normalize(self : DbquerygroupPoint) -> DbquerygroupPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerygroupPoint::negate(self : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbquerygroupPoint::mid(self : DbquerygroupPoint, other : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbquerygroupPoint::lerp(self : DbquerygroupPoint, other : DbquerygroupPoint, t : Double) -> DbquerygroupPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbquerygroupPoint::to_string(self : DbquerygroupPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbquerygroupSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_group_make_series(vals : Array[Double], name : String) -> DbquerygroupSeries {
  { vals, name, meta: 0 }
}

pub fn DbquerygroupSeries::len(self : DbquerygroupSeries) -> Int { self.vals.length() }

pub fn DbquerygroupSeries::sum(self : DbquerygroupSeries) -> Double { @_common.sum(self.vals) }

pub fn DbquerygroupSeries::mean(self : DbquerygroupSeries) -> Double { @_common.mean(self.vals) }

pub fn DbquerygroupSeries::min(self : DbquerygroupSeries) -> Double { @_common.min(self.vals) }

pub fn DbquerygroupSeries::max(self : DbquerygroupSeries) -> Double { @_common.max(self.vals) }

pub fn DbquerygroupSeries::range(self : DbquerygroupSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbquerygroupSeries::variance(self : DbquerygroupSeries) -> Double { @_common.variance(self.vals) }

pub fn DbquerygroupSeries::std(self : DbquerygroupSeries) -> Double { @_common.std(self.vals) }

pub fn DbquerygroupSeries::median(self : DbquerygroupSeries) -> Double { @_common.median(self.vals) }

pub fn DbquerygroupSeries::scale(self : DbquerygroupSeries, f : Double) -> DbquerygroupSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbquerygroupSeries::add(self : DbquerygroupSeries, other : DbquerygroupSeries) -> DbquerygroupSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbquerygroupSeries::sub(self : DbquerygroupSeries, other : DbquerygroupSeries) -> DbquerygroupSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbquerygroupSeries::normalize(self : DbquerygroupSeries) -> DbquerygroupSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbquerygroupSeries::cumsum(self : DbquerygroupSeries) -> DbquerygroupSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbquerygroupSeries::to_string(self : DbquerygroupSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerygroupMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_group_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerygroupMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_group_matrix_identity(n : Int) -> DbquerygroupMatrix {
  let m = db_query_group_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbquerygroupMatrix::get(self : DbquerygroupMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbquerygroupMatrix::transpose(self : DbquerygroupMatrix) -> DbquerygroupMatrix {
  let result = db_query_group_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbquerygroupMatrix::add(self : DbquerygroupMatrix, other : DbquerygroupMatrix) -> DbquerygroupMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_group_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbquerygroupMatrix::scale(self : DbquerygroupMatrix, s : Double) -> DbquerygroupMatrix {
  let result = db_query_group_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbquerygroupMatrix::multiply(self : DbquerygroupMatrix, other : DbquerygroupMatrix) -> DbquerygroupMatrix {
  if self.cols != other.rows { return db_query_group_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_group_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbquerygroupMatrix::trace(self : DbquerygroupMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbquerygroupMatrix::det(self : DbquerygroupMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbquerygroupMatrix::norm(self : DbquerygroupMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbquerygroupMatrix::to_string(self : DbquerygroupMatrix) -> String {
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

pub(all) struct DbquerygroupVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_group_make_vector(comps : Array[Double]) -> DbquerygroupVector {
  { comps, dim: comps.length() }
}

pub fn db_query_group_vector_zero(dim : Int) -> DbquerygroupVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbquerygroupVector::add(self : DbquerygroupVector, other : DbquerygroupVector) -> DbquerygroupVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerygroupVector::sub(self : DbquerygroupVector, other : DbquerygroupVector) -> DbquerygroupVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerygroupVector::scale(self : DbquerygroupVector, s : Double) -> DbquerygroupVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbquerygroupVector::dot(self : DbquerygroupVector, other : DbquerygroupVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbquerygroupVector::norm(self : DbquerygroupVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbquerygroupVector::normalize(self : DbquerygroupVector) -> DbquerygroupVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerygroupVector::dist(self : DbquerygroupVector, other : DbquerygroupVector) -> Double {
  self.sub(other).norm()
}

pub fn DbquerygroupVector::to_string(self : DbquerygroupVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerygroupFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_frame_make(size : Int) -> DbquerygroupFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupFrame::len(self : DbquerygroupFrame) -> Int { self.size }

pub fn DbquerygroupFrame::get(self : DbquerygroupFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupFrame::set(self : DbquerygroupFrame, i : Int, v : Double) -> DbquerygroupFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupFrame::sum(self : DbquerygroupFrame) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupFrame::mean(self : DbquerygroupFrame) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupFrame::scale(self : DbquerygroupFrame, f : Double) -> DbquerygroupFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupFrame::add(self : DbquerygroupFrame, other : DbquerygroupFrame) -> DbquerygroupFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupFrame::copy(self : DbquerygroupFrame) -> DbquerygroupFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupFrame::fill(self : DbquerygroupFrame, v : Double) -> DbquerygroupFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupFrame::min(self : DbquerygroupFrame) -> Double { @_common.min(self.data) }

pub fn DbquerygroupFrame::max(self : DbquerygroupFrame) -> Double { @_common.max(self.data) }

pub fn DbquerygroupFrame::to_string(self : DbquerygroupFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_table_make(size : Int) -> DbquerygroupTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupTable::len(self : DbquerygroupTable) -> Int { self.size }

pub fn DbquerygroupTable::get(self : DbquerygroupTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupTable::set(self : DbquerygroupTable, i : Int, v : Double) -> DbquerygroupTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupTable::sum(self : DbquerygroupTable) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupTable::mean(self : DbquerygroupTable) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupTable::scale(self : DbquerygroupTable, f : Double) -> DbquerygroupTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupTable::add(self : DbquerygroupTable, other : DbquerygroupTable) -> DbquerygroupTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupTable::copy(self : DbquerygroupTable) -> DbquerygroupTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupTable::fill(self : DbquerygroupTable, v : Double) -> DbquerygroupTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupTable::min(self : DbquerygroupTable) -> Double { @_common.min(self.data) }

pub fn DbquerygroupTable::max(self : DbquerygroupTable) -> Double { @_common.max(self.data) }

pub fn DbquerygroupTable::to_string(self : DbquerygroupTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_graphn_make(size : Int) -> DbquerygroupGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupGraphN::len(self : DbquerygroupGraphN) -> Int { self.size }

pub fn DbquerygroupGraphN::get(self : DbquerygroupGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupGraphN::set(self : DbquerygroupGraphN, i : Int, v : Double) -> DbquerygroupGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupGraphN::sum(self : DbquerygroupGraphN) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupGraphN::mean(self : DbquerygroupGraphN) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupGraphN::scale(self : DbquerygroupGraphN, f : Double) -> DbquerygroupGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupGraphN::add(self : DbquerygroupGraphN, other : DbquerygroupGraphN) -> DbquerygroupGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupGraphN::copy(self : DbquerygroupGraphN) -> DbquerygroupGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupGraphN::fill(self : DbquerygroupGraphN, v : Double) -> DbquerygroupGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupGraphN::min(self : DbquerygroupGraphN) -> Double { @_common.min(self.data) }

pub fn DbquerygroupGraphN::max(self : DbquerygroupGraphN) -> Double { @_common.max(self.data) }

pub fn DbquerygroupGraphN::to_string(self : DbquerygroupGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_node_make(size : Int) -> DbquerygroupNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupNode::len(self : DbquerygroupNode) -> Int { self.size }

pub fn DbquerygroupNode::get(self : DbquerygroupNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupNode::set(self : DbquerygroupNode, i : Int, v : Double) -> DbquerygroupNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupNode::sum(self : DbquerygroupNode) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupNode::mean(self : DbquerygroupNode) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupNode::scale(self : DbquerygroupNode, f : Double) -> DbquerygroupNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupNode::add(self : DbquerygroupNode, other : DbquerygroupNode) -> DbquerygroupNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupNode::copy(self : DbquerygroupNode) -> DbquerygroupNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupNode::fill(self : DbquerygroupNode, v : Double) -> DbquerygroupNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupNode::min(self : DbquerygroupNode) -> Double { @_common.min(self.data) }

pub fn DbquerygroupNode::max(self : DbquerygroupNode) -> Double { @_common.max(self.data) }

pub fn DbquerygroupNode::to_string(self : DbquerygroupNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_edge_make(size : Int) -> DbquerygroupEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupEdge::len(self : DbquerygroupEdge) -> Int { self.size }

pub fn DbquerygroupEdge::get(self : DbquerygroupEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupEdge::set(self : DbquerygroupEdge, i : Int, v : Double) -> DbquerygroupEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupEdge::sum(self : DbquerygroupEdge) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupEdge::mean(self : DbquerygroupEdge) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupEdge::scale(self : DbquerygroupEdge, f : Double) -> DbquerygroupEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupEdge::add(self : DbquerygroupEdge, other : DbquerygroupEdge) -> DbquerygroupEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupEdge::copy(self : DbquerygroupEdge) -> DbquerygroupEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupEdge::fill(self : DbquerygroupEdge, v : Double) -> DbquerygroupEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupEdge::min(self : DbquerygroupEdge) -> Double { @_common.min(self.data) }

pub fn DbquerygroupEdge::max(self : DbquerygroupEdge) -> Double { @_common.max(self.data) }

pub fn DbquerygroupEdge::to_string(self : DbquerygroupEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_path_make(size : Int) -> DbquerygroupPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupPath::len(self : DbquerygroupPath) -> Int { self.size }

pub fn DbquerygroupPath::get(self : DbquerygroupPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupPath::set(self : DbquerygroupPath, i : Int, v : Double) -> DbquerygroupPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupPath::sum(self : DbquerygroupPath) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupPath::mean(self : DbquerygroupPath) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupPath::scale(self : DbquerygroupPath, f : Double) -> DbquerygroupPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupPath::add(self : DbquerygroupPath, other : DbquerygroupPath) -> DbquerygroupPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupPath::copy(self : DbquerygroupPath) -> DbquerygroupPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupPath::fill(self : DbquerygroupPath, v : Double) -> DbquerygroupPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupPath::min(self : DbquerygroupPath) -> Double { @_common.min(self.data) }

pub fn DbquerygroupPath::max(self : DbquerygroupPath) -> Double { @_common.max(self.data) }

pub fn DbquerygroupPath::to_string(self : DbquerygroupPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_cluster_make(size : Int) -> DbquerygroupCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupCluster::len(self : DbquerygroupCluster) -> Int { self.size }

pub fn DbquerygroupCluster::get(self : DbquerygroupCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupCluster::set(self : DbquerygroupCluster, i : Int, v : Double) -> DbquerygroupCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupCluster::sum(self : DbquerygroupCluster) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupCluster::mean(self : DbquerygroupCluster) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupCluster::scale(self : DbquerygroupCluster, f : Double) -> DbquerygroupCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupCluster::add(self : DbquerygroupCluster, other : DbquerygroupCluster) -> DbquerygroupCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupCluster::copy(self : DbquerygroupCluster) -> DbquerygroupCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupCluster::fill(self : DbquerygroupCluster, v : Double) -> DbquerygroupCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupCluster::min(self : DbquerygroupCluster) -> Double { @_common.min(self.data) }

pub fn DbquerygroupCluster::max(self : DbquerygroupCluster) -> Double { @_common.max(self.data) }

pub fn DbquerygroupCluster::to_string(self : DbquerygroupCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_model_make(size : Int) -> DbquerygroupModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupModel::len(self : DbquerygroupModel) -> Int { self.size }

pub fn DbquerygroupModel::get(self : DbquerygroupModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupModel::set(self : DbquerygroupModel, i : Int, v : Double) -> DbquerygroupModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupModel::sum(self : DbquerygroupModel) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupModel::mean(self : DbquerygroupModel) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupModel::scale(self : DbquerygroupModel, f : Double) -> DbquerygroupModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupModel::add(self : DbquerygroupModel, other : DbquerygroupModel) -> DbquerygroupModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupModel::copy(self : DbquerygroupModel) -> DbquerygroupModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupModel::fill(self : DbquerygroupModel, v : Double) -> DbquerygroupModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupModel::min(self : DbquerygroupModel) -> Double { @_common.min(self.data) }

pub fn DbquerygroupModel::max(self : DbquerygroupModel) -> Double { @_common.max(self.data) }

pub fn DbquerygroupModel::to_string(self : DbquerygroupModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_layer_make(size : Int) -> DbquerygroupLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupLayer::len(self : DbquerygroupLayer) -> Int { self.size }

pub fn DbquerygroupLayer::get(self : DbquerygroupLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupLayer::set(self : DbquerygroupLayer, i : Int, v : Double) -> DbquerygroupLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupLayer::sum(self : DbquerygroupLayer) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupLayer::mean(self : DbquerygroupLayer) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupLayer::scale(self : DbquerygroupLayer, f : Double) -> DbquerygroupLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupLayer::add(self : DbquerygroupLayer, other : DbquerygroupLayer) -> DbquerygroupLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupLayer::copy(self : DbquerygroupLayer) -> DbquerygroupLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupLayer::fill(self : DbquerygroupLayer, v : Double) -> DbquerygroupLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupLayer::min(self : DbquerygroupLayer) -> Double { @_common.min(self.data) }

pub fn DbquerygroupLayer::max(self : DbquerygroupLayer) -> Double { @_common.max(self.data) }

pub fn DbquerygroupLayer::to_string(self : DbquerygroupLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_buffer_make(size : Int) -> DbquerygroupBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupBuffer::len(self : DbquerygroupBuffer) -> Int { self.size }

pub fn DbquerygroupBuffer::get(self : DbquerygroupBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupBuffer::set(self : DbquerygroupBuffer, i : Int, v : Double) -> DbquerygroupBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupBuffer::sum(self : DbquerygroupBuffer) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupBuffer::mean(self : DbquerygroupBuffer) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupBuffer::scale(self : DbquerygroupBuffer, f : Double) -> DbquerygroupBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupBuffer::add(self : DbquerygroupBuffer, other : DbquerygroupBuffer) -> DbquerygroupBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupBuffer::copy(self : DbquerygroupBuffer) -> DbquerygroupBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupBuffer::fill(self : DbquerygroupBuffer, v : Double) -> DbquerygroupBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupBuffer::min(self : DbquerygroupBuffer) -> Double { @_common.min(self.data) }

pub fn DbquerygroupBuffer::max(self : DbquerygroupBuffer) -> Double { @_common.max(self.data) }

pub fn DbquerygroupBuffer::to_string(self : DbquerygroupBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_cursor_make(size : Int) -> DbquerygroupCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupCursor::len(self : DbquerygroupCursor) -> Int { self.size }

pub fn DbquerygroupCursor::get(self : DbquerygroupCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupCursor::set(self : DbquerygroupCursor, i : Int, v : Double) -> DbquerygroupCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupCursor::sum(self : DbquerygroupCursor) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupCursor::mean(self : DbquerygroupCursor) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupCursor::scale(self : DbquerygroupCursor, f : Double) -> DbquerygroupCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupCursor::add(self : DbquerygroupCursor, other : DbquerygroupCursor) -> DbquerygroupCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupCursor::copy(self : DbquerygroupCursor) -> DbquerygroupCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupCursor::fill(self : DbquerygroupCursor, v : Double) -> DbquerygroupCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupCursor::min(self : DbquerygroupCursor) -> Double { @_common.min(self.data) }

pub fn DbquerygroupCursor::max(self : DbquerygroupCursor) -> Double { @_common.max(self.data) }

pub fn DbquerygroupCursor::to_string(self : DbquerygroupCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_view_make(size : Int) -> DbquerygroupView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupView::len(self : DbquerygroupView) -> Int { self.size }

pub fn DbquerygroupView::get(self : DbquerygroupView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupView::set(self : DbquerygroupView, i : Int, v : Double) -> DbquerygroupView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupView::sum(self : DbquerygroupView) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupView::mean(self : DbquerygroupView) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupView::scale(self : DbquerygroupView, f : Double) -> DbquerygroupView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupView::add(self : DbquerygroupView, other : DbquerygroupView) -> DbquerygroupView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupView::copy(self : DbquerygroupView) -> DbquerygroupView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupView::fill(self : DbquerygroupView, v : Double) -> DbquerygroupView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupView::min(self : DbquerygroupView) -> Double { @_common.min(self.data) }

pub fn DbquerygroupView::max(self : DbquerygroupView) -> Double { @_common.max(self.data) }

pub fn DbquerygroupView::to_string(self : DbquerygroupView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_range_make(size : Int) -> DbquerygroupRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupRange::len(self : DbquerygroupRange) -> Int { self.size }

pub fn DbquerygroupRange::get(self : DbquerygroupRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupRange::set(self : DbquerygroupRange, i : Int, v : Double) -> DbquerygroupRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupRange::sum(self : DbquerygroupRange) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupRange::mean(self : DbquerygroupRange) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupRange::scale(self : DbquerygroupRange, f : Double) -> DbquerygroupRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupRange::add(self : DbquerygroupRange, other : DbquerygroupRange) -> DbquerygroupRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupRange::copy(self : DbquerygroupRange) -> DbquerygroupRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupRange::fill(self : DbquerygroupRange, v : Double) -> DbquerygroupRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupRange::min(self : DbquerygroupRange) -> Double { @_common.min(self.data) }

pub fn DbquerygroupRange::max(self : DbquerygroupRange) -> Double { @_common.max(self.data) }

pub fn DbquerygroupRange::to_string(self : DbquerygroupRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbquerygroupSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_slice_make(size : Int) -> DbquerygroupSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbquerygroupSlice::len(self : DbquerygroupSlice) -> Int { self.size }

pub fn DbquerygroupSlice::get(self : DbquerygroupSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbquerygroupSlice::set(self : DbquerygroupSlice, i : Int, v : Double) -> DbquerygroupSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbquerygroupSlice::sum(self : DbquerygroupSlice) -> Double { @_common.sum(self.data) }

pub fn DbquerygroupSlice::mean(self : DbquerygroupSlice) -> Double { @_common.mean(self.data) }

pub fn DbquerygroupSlice::scale(self : DbquerygroupSlice, f : Double) -> DbquerygroupSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbquerygroupSlice::add(self : DbquerygroupSlice, other : DbquerygroupSlice) -> DbquerygroupSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbquerygroupSlice::copy(self : DbquerygroupSlice) -> DbquerygroupSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbquerygroupSlice::fill(self : DbquerygroupSlice, v : Double) -> DbquerygroupSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbquerygroupSlice::min(self : DbquerygroupSlice) -> Double { @_common.min(self.data) }

pub fn DbquerygroupSlice::max(self : DbquerygroupSlice) -> Double { @_common.max(self.data) }

pub fn DbquerygroupSlice::to_string(self : DbquerygroupSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

