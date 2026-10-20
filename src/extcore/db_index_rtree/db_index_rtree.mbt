///===
/// extcore/db_index_rtree

pub(all) struct DbindexrtreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_rtree_make_point(x : Double, y : Double) -> DbindexrtreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_rtree_make_point3(x : Double, y : Double, z : Double) -> DbindexrtreePoint {
  { x, y, z, label: 0 }
}

pub fn DbindexrtreePoint::x(self : DbindexrtreePoint) -> Double { self.x }

pub fn DbindexrtreePoint::y(self : DbindexrtreePoint) -> Double { self.y }

pub fn DbindexrtreePoint::z(self : DbindexrtreePoint) -> Double { self.z }

pub fn DbindexrtreePoint::label(self : DbindexrtreePoint) -> Int { self.label }

pub fn DbindexrtreePoint::dist(self : DbindexrtreePoint, other : DbindexrtreePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexrtreePoint::add(self : DbindexrtreePoint, other : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexrtreePoint::sub(self : DbindexrtreePoint, other : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexrtreePoint::scale(self : DbindexrtreePoint, s : Double) -> DbindexrtreePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexrtreePoint::dot(self : DbindexrtreePoint, other : DbindexrtreePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexrtreePoint::cross(self : DbindexrtreePoint, other : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexrtreePoint::norm(self : DbindexrtreePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexrtreePoint::normalize(self : DbindexrtreePoint) -> DbindexrtreePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexrtreePoint::negate(self : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexrtreePoint::mid(self : DbindexrtreePoint, other : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexrtreePoint::lerp(self : DbindexrtreePoint, other : DbindexrtreePoint, t : Double) -> DbindexrtreePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexrtreePoint::to_string(self : DbindexrtreePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexrtreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_rtree_make_series(vals : Array[Double], name : String) -> DbindexrtreeSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexrtreeSeries::len(self : DbindexrtreeSeries) -> Int { self.vals.length() }

pub fn DbindexrtreeSeries::sum(self : DbindexrtreeSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexrtreeSeries::mean(self : DbindexrtreeSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexrtreeSeries::min(self : DbindexrtreeSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexrtreeSeries::max(self : DbindexrtreeSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexrtreeSeries::range(self : DbindexrtreeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexrtreeSeries::variance(self : DbindexrtreeSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexrtreeSeries::std(self : DbindexrtreeSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexrtreeSeries::median(self : DbindexrtreeSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexrtreeSeries::scale(self : DbindexrtreeSeries, f : Double) -> DbindexrtreeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexrtreeSeries::add(self : DbindexrtreeSeries, other : DbindexrtreeSeries) -> DbindexrtreeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexrtreeSeries::sub(self : DbindexrtreeSeries, other : DbindexrtreeSeries) -> DbindexrtreeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexrtreeSeries::normalize(self : DbindexrtreeSeries) -> DbindexrtreeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexrtreeSeries::cumsum(self : DbindexrtreeSeries) -> DbindexrtreeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexrtreeSeries::to_string(self : DbindexrtreeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexrtreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_rtree_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexrtreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_rtree_matrix_identity(n : Int) -> DbindexrtreeMatrix {
  let m = db_index_rtree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexrtreeMatrix::get(self : DbindexrtreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexrtreeMatrix::transpose(self : DbindexrtreeMatrix) -> DbindexrtreeMatrix {
  let result = db_index_rtree_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexrtreeMatrix::add(self : DbindexrtreeMatrix, other : DbindexrtreeMatrix) -> DbindexrtreeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_rtree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexrtreeMatrix::scale(self : DbindexrtreeMatrix, s : Double) -> DbindexrtreeMatrix {
  let result = db_index_rtree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexrtreeMatrix::multiply(self : DbindexrtreeMatrix, other : DbindexrtreeMatrix) -> DbindexrtreeMatrix {
  if self.cols != other.rows { return db_index_rtree_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_rtree_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbindexrtreeMatrix::trace(self : DbindexrtreeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexrtreeMatrix::det(self : DbindexrtreeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexrtreeMatrix::norm(self : DbindexrtreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexrtreeMatrix::to_string(self : DbindexrtreeMatrix) -> String {
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

pub(all) struct DbindexrtreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_rtree_make_vector(comps : Array[Double]) -> DbindexrtreeVector {
  { comps, dim: comps.length() }
}

pub fn db_index_rtree_vector_zero(dim : Int) -> DbindexrtreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexrtreeVector::add(self : DbindexrtreeVector, other : DbindexrtreeVector) -> DbindexrtreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexrtreeVector::sub(self : DbindexrtreeVector, other : DbindexrtreeVector) -> DbindexrtreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexrtreeVector::scale(self : DbindexrtreeVector, s : Double) -> DbindexrtreeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexrtreeVector::dot(self : DbindexrtreeVector, other : DbindexrtreeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexrtreeVector::norm(self : DbindexrtreeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexrtreeVector::normalize(self : DbindexrtreeVector) -> DbindexrtreeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexrtreeVector::dist(self : DbindexrtreeVector, other : DbindexrtreeVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexrtreeVector::to_string(self : DbindexrtreeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexrtreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_frame_make(size : Int) -> DbindexrtreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeFrame::len(self : DbindexrtreeFrame) -> Int { self.size }

pub fn DbindexrtreeFrame::get(self : DbindexrtreeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeFrame::set(self : DbindexrtreeFrame, i : Int, v : Double) -> DbindexrtreeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeFrame::sum(self : DbindexrtreeFrame) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeFrame::mean(self : DbindexrtreeFrame) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeFrame::scale(self : DbindexrtreeFrame, f : Double) -> DbindexrtreeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeFrame::add(self : DbindexrtreeFrame, other : DbindexrtreeFrame) -> DbindexrtreeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeFrame::copy(self : DbindexrtreeFrame) -> DbindexrtreeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeFrame::fill(self : DbindexrtreeFrame, v : Double) -> DbindexrtreeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeFrame::min(self : DbindexrtreeFrame) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeFrame::max(self : DbindexrtreeFrame) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeFrame::to_string(self : DbindexrtreeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_table_make(size : Int) -> DbindexrtreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeTable::len(self : DbindexrtreeTable) -> Int { self.size }

pub fn DbindexrtreeTable::get(self : DbindexrtreeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeTable::set(self : DbindexrtreeTable, i : Int, v : Double) -> DbindexrtreeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeTable::sum(self : DbindexrtreeTable) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeTable::mean(self : DbindexrtreeTable) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeTable::scale(self : DbindexrtreeTable, f : Double) -> DbindexrtreeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeTable::add(self : DbindexrtreeTable, other : DbindexrtreeTable) -> DbindexrtreeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeTable::copy(self : DbindexrtreeTable) -> DbindexrtreeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeTable::fill(self : DbindexrtreeTable, v : Double) -> DbindexrtreeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeTable::min(self : DbindexrtreeTable) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeTable::max(self : DbindexrtreeTable) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeTable::to_string(self : DbindexrtreeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_graphn_make(size : Int) -> DbindexrtreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeGraphN::len(self : DbindexrtreeGraphN) -> Int { self.size }

pub fn DbindexrtreeGraphN::get(self : DbindexrtreeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeGraphN::set(self : DbindexrtreeGraphN, i : Int, v : Double) -> DbindexrtreeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeGraphN::sum(self : DbindexrtreeGraphN) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeGraphN::mean(self : DbindexrtreeGraphN) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeGraphN::scale(self : DbindexrtreeGraphN, f : Double) -> DbindexrtreeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeGraphN::add(self : DbindexrtreeGraphN, other : DbindexrtreeGraphN) -> DbindexrtreeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeGraphN::copy(self : DbindexrtreeGraphN) -> DbindexrtreeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeGraphN::fill(self : DbindexrtreeGraphN, v : Double) -> DbindexrtreeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeGraphN::min(self : DbindexrtreeGraphN) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeGraphN::max(self : DbindexrtreeGraphN) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeGraphN::to_string(self : DbindexrtreeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_node_make(size : Int) -> DbindexrtreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeNode::len(self : DbindexrtreeNode) -> Int { self.size }

pub fn DbindexrtreeNode::get(self : DbindexrtreeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeNode::set(self : DbindexrtreeNode, i : Int, v : Double) -> DbindexrtreeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeNode::sum(self : DbindexrtreeNode) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeNode::mean(self : DbindexrtreeNode) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeNode::scale(self : DbindexrtreeNode, f : Double) -> DbindexrtreeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeNode::add(self : DbindexrtreeNode, other : DbindexrtreeNode) -> DbindexrtreeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeNode::copy(self : DbindexrtreeNode) -> DbindexrtreeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeNode::fill(self : DbindexrtreeNode, v : Double) -> DbindexrtreeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeNode::min(self : DbindexrtreeNode) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeNode::max(self : DbindexrtreeNode) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeNode::to_string(self : DbindexrtreeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_edge_make(size : Int) -> DbindexrtreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeEdge::len(self : DbindexrtreeEdge) -> Int { self.size }

pub fn DbindexrtreeEdge::get(self : DbindexrtreeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeEdge::set(self : DbindexrtreeEdge, i : Int, v : Double) -> DbindexrtreeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeEdge::sum(self : DbindexrtreeEdge) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeEdge::mean(self : DbindexrtreeEdge) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeEdge::scale(self : DbindexrtreeEdge, f : Double) -> DbindexrtreeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeEdge::add(self : DbindexrtreeEdge, other : DbindexrtreeEdge) -> DbindexrtreeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeEdge::copy(self : DbindexrtreeEdge) -> DbindexrtreeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeEdge::fill(self : DbindexrtreeEdge, v : Double) -> DbindexrtreeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeEdge::min(self : DbindexrtreeEdge) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeEdge::max(self : DbindexrtreeEdge) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeEdge::to_string(self : DbindexrtreeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_path_make(size : Int) -> DbindexrtreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreePath::len(self : DbindexrtreePath) -> Int { self.size }

pub fn DbindexrtreePath::get(self : DbindexrtreePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreePath::set(self : DbindexrtreePath, i : Int, v : Double) -> DbindexrtreePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreePath::sum(self : DbindexrtreePath) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreePath::mean(self : DbindexrtreePath) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreePath::scale(self : DbindexrtreePath, f : Double) -> DbindexrtreePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreePath::add(self : DbindexrtreePath, other : DbindexrtreePath) -> DbindexrtreePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreePath::copy(self : DbindexrtreePath) -> DbindexrtreePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreePath::fill(self : DbindexrtreePath, v : Double) -> DbindexrtreePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreePath::min(self : DbindexrtreePath) -> Double { @_common.min(self.data) }

pub fn DbindexrtreePath::max(self : DbindexrtreePath) -> Double { @_common.max(self.data) }

pub fn DbindexrtreePath::to_string(self : DbindexrtreePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_cluster_make(size : Int) -> DbindexrtreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeCluster::len(self : DbindexrtreeCluster) -> Int { self.size }

pub fn DbindexrtreeCluster::get(self : DbindexrtreeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeCluster::set(self : DbindexrtreeCluster, i : Int, v : Double) -> DbindexrtreeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeCluster::sum(self : DbindexrtreeCluster) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeCluster::mean(self : DbindexrtreeCluster) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeCluster::scale(self : DbindexrtreeCluster, f : Double) -> DbindexrtreeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeCluster::add(self : DbindexrtreeCluster, other : DbindexrtreeCluster) -> DbindexrtreeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeCluster::copy(self : DbindexrtreeCluster) -> DbindexrtreeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeCluster::fill(self : DbindexrtreeCluster, v : Double) -> DbindexrtreeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeCluster::min(self : DbindexrtreeCluster) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeCluster::max(self : DbindexrtreeCluster) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeCluster::to_string(self : DbindexrtreeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_model_make(size : Int) -> DbindexrtreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeModel::len(self : DbindexrtreeModel) -> Int { self.size }

pub fn DbindexrtreeModel::get(self : DbindexrtreeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeModel::set(self : DbindexrtreeModel, i : Int, v : Double) -> DbindexrtreeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeModel::sum(self : DbindexrtreeModel) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeModel::mean(self : DbindexrtreeModel) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeModel::scale(self : DbindexrtreeModel, f : Double) -> DbindexrtreeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeModel::add(self : DbindexrtreeModel, other : DbindexrtreeModel) -> DbindexrtreeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeModel::copy(self : DbindexrtreeModel) -> DbindexrtreeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeModel::fill(self : DbindexrtreeModel, v : Double) -> DbindexrtreeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeModel::min(self : DbindexrtreeModel) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeModel::max(self : DbindexrtreeModel) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeModel::to_string(self : DbindexrtreeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_layer_make(size : Int) -> DbindexrtreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeLayer::len(self : DbindexrtreeLayer) -> Int { self.size }

pub fn DbindexrtreeLayer::get(self : DbindexrtreeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeLayer::set(self : DbindexrtreeLayer, i : Int, v : Double) -> DbindexrtreeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeLayer::sum(self : DbindexrtreeLayer) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeLayer::mean(self : DbindexrtreeLayer) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeLayer::scale(self : DbindexrtreeLayer, f : Double) -> DbindexrtreeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeLayer::add(self : DbindexrtreeLayer, other : DbindexrtreeLayer) -> DbindexrtreeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeLayer::copy(self : DbindexrtreeLayer) -> DbindexrtreeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeLayer::fill(self : DbindexrtreeLayer, v : Double) -> DbindexrtreeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeLayer::min(self : DbindexrtreeLayer) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeLayer::max(self : DbindexrtreeLayer) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeLayer::to_string(self : DbindexrtreeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_buffer_make(size : Int) -> DbindexrtreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeBuffer::len(self : DbindexrtreeBuffer) -> Int { self.size }

pub fn DbindexrtreeBuffer::get(self : DbindexrtreeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeBuffer::set(self : DbindexrtreeBuffer, i : Int, v : Double) -> DbindexrtreeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeBuffer::sum(self : DbindexrtreeBuffer) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeBuffer::mean(self : DbindexrtreeBuffer) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeBuffer::scale(self : DbindexrtreeBuffer, f : Double) -> DbindexrtreeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeBuffer::add(self : DbindexrtreeBuffer, other : DbindexrtreeBuffer) -> DbindexrtreeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeBuffer::copy(self : DbindexrtreeBuffer) -> DbindexrtreeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeBuffer::fill(self : DbindexrtreeBuffer, v : Double) -> DbindexrtreeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeBuffer::min(self : DbindexrtreeBuffer) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeBuffer::max(self : DbindexrtreeBuffer) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeBuffer::to_string(self : DbindexrtreeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_cursor_make(size : Int) -> DbindexrtreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeCursor::len(self : DbindexrtreeCursor) -> Int { self.size }

pub fn DbindexrtreeCursor::get(self : DbindexrtreeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeCursor::set(self : DbindexrtreeCursor, i : Int, v : Double) -> DbindexrtreeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeCursor::sum(self : DbindexrtreeCursor) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeCursor::mean(self : DbindexrtreeCursor) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeCursor::scale(self : DbindexrtreeCursor, f : Double) -> DbindexrtreeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeCursor::add(self : DbindexrtreeCursor, other : DbindexrtreeCursor) -> DbindexrtreeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeCursor::copy(self : DbindexrtreeCursor) -> DbindexrtreeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeCursor::fill(self : DbindexrtreeCursor, v : Double) -> DbindexrtreeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeCursor::min(self : DbindexrtreeCursor) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeCursor::max(self : DbindexrtreeCursor) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeCursor::to_string(self : DbindexrtreeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_view_make(size : Int) -> DbindexrtreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeView::len(self : DbindexrtreeView) -> Int { self.size }

pub fn DbindexrtreeView::get(self : DbindexrtreeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeView::set(self : DbindexrtreeView, i : Int, v : Double) -> DbindexrtreeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeView::sum(self : DbindexrtreeView) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeView::mean(self : DbindexrtreeView) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeView::scale(self : DbindexrtreeView, f : Double) -> DbindexrtreeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeView::add(self : DbindexrtreeView, other : DbindexrtreeView) -> DbindexrtreeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeView::copy(self : DbindexrtreeView) -> DbindexrtreeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeView::fill(self : DbindexrtreeView, v : Double) -> DbindexrtreeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeView::min(self : DbindexrtreeView) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeView::max(self : DbindexrtreeView) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeView::to_string(self : DbindexrtreeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_range_make(size : Int) -> DbindexrtreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeRange::len(self : DbindexrtreeRange) -> Int { self.size }

pub fn DbindexrtreeRange::get(self : DbindexrtreeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeRange::set(self : DbindexrtreeRange, i : Int, v : Double) -> DbindexrtreeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeRange::sum(self : DbindexrtreeRange) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeRange::mean(self : DbindexrtreeRange) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeRange::scale(self : DbindexrtreeRange, f : Double) -> DbindexrtreeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeRange::add(self : DbindexrtreeRange, other : DbindexrtreeRange) -> DbindexrtreeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeRange::copy(self : DbindexrtreeRange) -> DbindexrtreeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeRange::fill(self : DbindexrtreeRange, v : Double) -> DbindexrtreeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeRange::min(self : DbindexrtreeRange) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeRange::max(self : DbindexrtreeRange) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeRange::to_string(self : DbindexrtreeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_slice_make(size : Int) -> DbindexrtreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexrtreeSlice::len(self : DbindexrtreeSlice) -> Int { self.size }

pub fn DbindexrtreeSlice::get(self : DbindexrtreeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexrtreeSlice::set(self : DbindexrtreeSlice, i : Int, v : Double) -> DbindexrtreeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexrtreeSlice::sum(self : DbindexrtreeSlice) -> Double { @_common.sum(self.data) }

pub fn DbindexrtreeSlice::mean(self : DbindexrtreeSlice) -> Double { @_common.mean(self.data) }

pub fn DbindexrtreeSlice::scale(self : DbindexrtreeSlice, f : Double) -> DbindexrtreeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeSlice::add(self : DbindexrtreeSlice, other : DbindexrtreeSlice) -> DbindexrtreeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexrtreeSlice::copy(self : DbindexrtreeSlice) -> DbindexrtreeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeSlice::fill(self : DbindexrtreeSlice, v : Double) -> DbindexrtreeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexrtreeSlice::min(self : DbindexrtreeSlice) -> Double { @_common.min(self.data) }

pub fn DbindexrtreeSlice::max(self : DbindexrtreeSlice) -> Double { @_common.max(self.data) }

pub fn DbindexrtreeSlice::to_string(self : DbindexrtreeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

