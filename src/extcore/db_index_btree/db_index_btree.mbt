///===
/// extcore/db_index_btree

pub(all) struct DbindexbtreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_btree_make_point(x : Double, y : Double) -> DbindexbtreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_btree_make_point3(x : Double, y : Double, z : Double) -> DbindexbtreePoint {
  { x, y, z, label: 0 }
}

pub fn DbindexbtreePoint::x(self : DbindexbtreePoint) -> Double { self.x }

pub fn DbindexbtreePoint::y(self : DbindexbtreePoint) -> Double { self.y }

pub fn DbindexbtreePoint::z(self : DbindexbtreePoint) -> Double { self.z }

pub fn DbindexbtreePoint::label(self : DbindexbtreePoint) -> Int { self.label }

pub fn DbindexbtreePoint::dist(self : DbindexbtreePoint, other : DbindexbtreePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexbtreePoint::add(self : DbindexbtreePoint, other : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexbtreePoint::sub(self : DbindexbtreePoint, other : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexbtreePoint::scale(self : DbindexbtreePoint, s : Double) -> DbindexbtreePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexbtreePoint::dot(self : DbindexbtreePoint, other : DbindexbtreePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexbtreePoint::cross(self : DbindexbtreePoint, other : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexbtreePoint::norm(self : DbindexbtreePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexbtreePoint::normalize(self : DbindexbtreePoint) -> DbindexbtreePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexbtreePoint::negate(self : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexbtreePoint::mid(self : DbindexbtreePoint, other : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexbtreePoint::lerp(self : DbindexbtreePoint, other : DbindexbtreePoint, t : Double) -> DbindexbtreePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexbtreePoint::to_string(self : DbindexbtreePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexbtreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_btree_make_series(vals : Array[Double], name : String) -> DbindexbtreeSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexbtreeSeries::len(self : DbindexbtreeSeries) -> Int { self.vals.length() }

pub fn DbindexbtreeSeries::sum(self : DbindexbtreeSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexbtreeSeries::mean(self : DbindexbtreeSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexbtreeSeries::min(self : DbindexbtreeSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexbtreeSeries::max(self : DbindexbtreeSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexbtreeSeries::range(self : DbindexbtreeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexbtreeSeries::variance(self : DbindexbtreeSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexbtreeSeries::std(self : DbindexbtreeSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexbtreeSeries::median(self : DbindexbtreeSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexbtreeSeries::scale(self : DbindexbtreeSeries, f : Double) -> DbindexbtreeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexbtreeSeries::add(self : DbindexbtreeSeries, other : DbindexbtreeSeries) -> DbindexbtreeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexbtreeSeries::sub(self : DbindexbtreeSeries, other : DbindexbtreeSeries) -> DbindexbtreeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexbtreeSeries::normalize(self : DbindexbtreeSeries) -> DbindexbtreeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexbtreeSeries::cumsum(self : DbindexbtreeSeries) -> DbindexbtreeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexbtreeSeries::to_string(self : DbindexbtreeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexbtreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_btree_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexbtreeMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn db_index_btree_matrix_identity(n : Int) -> DbindexbtreeMatrix {
  let m = db_index_btree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexbtreeMatrix::get(self : DbindexbtreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexbtreeMatrix::transpose(self : DbindexbtreeMatrix) -> DbindexbtreeMatrix {
  let result = db_index_btree_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexbtreeMatrix::add(self : DbindexbtreeMatrix, other : DbindexbtreeMatrix) -> DbindexbtreeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_btree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexbtreeMatrix::scale(self : DbindexbtreeMatrix, s : Double) -> DbindexbtreeMatrix {
  let result = db_index_btree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexbtreeMatrix::multiply(self : DbindexbtreeMatrix, other : DbindexbtreeMatrix) -> DbindexbtreeMatrix {
  if self.cols != other.rows { return db_index_btree_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_btree_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DbindexbtreeMatrix::trace(self : DbindexbtreeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexbtreeMatrix::det(self : DbindexbtreeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexbtreeMatrix::norm(self : DbindexbtreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexbtreeMatrix::to_string(self : DbindexbtreeMatrix) -> String {
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

pub(all) struct DbindexbtreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_btree_make_vector(comps : Array[Double]) -> DbindexbtreeVector {
  { comps, dim: comps.length() }
}

pub fn db_index_btree_vector_zero(dim : Int) -> DbindexbtreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexbtreeVector::add(self : DbindexbtreeVector, other : DbindexbtreeVector) -> DbindexbtreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexbtreeVector::sub(self : DbindexbtreeVector, other : DbindexbtreeVector) -> DbindexbtreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexbtreeVector::scale(self : DbindexbtreeVector, s : Double) -> DbindexbtreeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexbtreeVector::dot(self : DbindexbtreeVector, other : DbindexbtreeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexbtreeVector::norm(self : DbindexbtreeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexbtreeVector::normalize(self : DbindexbtreeVector) -> DbindexbtreeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexbtreeVector::dist(self : DbindexbtreeVector, other : DbindexbtreeVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexbtreeVector::to_string(self : DbindexbtreeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexbtreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_frame_make(size : Int) -> DbindexbtreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeFrame::len(self : DbindexbtreeFrame) -> Int { self.size }

pub fn DbindexbtreeFrame::get(self : DbindexbtreeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeFrame::set(self : DbindexbtreeFrame, i : Int, v : Double) -> DbindexbtreeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeFrame::sum(self : DbindexbtreeFrame) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeFrame::mean(self : DbindexbtreeFrame) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeFrame::scale(self : DbindexbtreeFrame, f : Double) -> DbindexbtreeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeFrame::add(self : DbindexbtreeFrame, other : DbindexbtreeFrame) -> DbindexbtreeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeFrame::copy(self : DbindexbtreeFrame) -> DbindexbtreeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeFrame::fill(self : DbindexbtreeFrame, v : Double) -> DbindexbtreeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeFrame::min(self : DbindexbtreeFrame) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeFrame::max(self : DbindexbtreeFrame) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeFrame::to_string(self : DbindexbtreeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_table_make(size : Int) -> DbindexbtreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeTable::len(self : DbindexbtreeTable) -> Int { self.size }

pub fn DbindexbtreeTable::get(self : DbindexbtreeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeTable::set(self : DbindexbtreeTable, i : Int, v : Double) -> DbindexbtreeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeTable::sum(self : DbindexbtreeTable) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeTable::mean(self : DbindexbtreeTable) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeTable::scale(self : DbindexbtreeTable, f : Double) -> DbindexbtreeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeTable::add(self : DbindexbtreeTable, other : DbindexbtreeTable) -> DbindexbtreeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeTable::copy(self : DbindexbtreeTable) -> DbindexbtreeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeTable::fill(self : DbindexbtreeTable, v : Double) -> DbindexbtreeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeTable::min(self : DbindexbtreeTable) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeTable::max(self : DbindexbtreeTable) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeTable::to_string(self : DbindexbtreeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_graphn_make(size : Int) -> DbindexbtreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeGraphN::len(self : DbindexbtreeGraphN) -> Int { self.size }

pub fn DbindexbtreeGraphN::get(self : DbindexbtreeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeGraphN::set(self : DbindexbtreeGraphN, i : Int, v : Double) -> DbindexbtreeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeGraphN::sum(self : DbindexbtreeGraphN) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeGraphN::mean(self : DbindexbtreeGraphN) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeGraphN::scale(self : DbindexbtreeGraphN, f : Double) -> DbindexbtreeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeGraphN::add(self : DbindexbtreeGraphN, other : DbindexbtreeGraphN) -> DbindexbtreeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeGraphN::copy(self : DbindexbtreeGraphN) -> DbindexbtreeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeGraphN::fill(self : DbindexbtreeGraphN, v : Double) -> DbindexbtreeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeGraphN::min(self : DbindexbtreeGraphN) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeGraphN::max(self : DbindexbtreeGraphN) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeGraphN::to_string(self : DbindexbtreeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_node_make(size : Int) -> DbindexbtreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeNode::len(self : DbindexbtreeNode) -> Int { self.size }

pub fn DbindexbtreeNode::get(self : DbindexbtreeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeNode::set(self : DbindexbtreeNode, i : Int, v : Double) -> DbindexbtreeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeNode::sum(self : DbindexbtreeNode) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeNode::mean(self : DbindexbtreeNode) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeNode::scale(self : DbindexbtreeNode, f : Double) -> DbindexbtreeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeNode::add(self : DbindexbtreeNode, other : DbindexbtreeNode) -> DbindexbtreeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeNode::copy(self : DbindexbtreeNode) -> DbindexbtreeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeNode::fill(self : DbindexbtreeNode, v : Double) -> DbindexbtreeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeNode::min(self : DbindexbtreeNode) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeNode::max(self : DbindexbtreeNode) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeNode::to_string(self : DbindexbtreeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_edge_make(size : Int) -> DbindexbtreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeEdge::len(self : DbindexbtreeEdge) -> Int { self.size }

pub fn DbindexbtreeEdge::get(self : DbindexbtreeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeEdge::set(self : DbindexbtreeEdge, i : Int, v : Double) -> DbindexbtreeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeEdge::sum(self : DbindexbtreeEdge) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeEdge::mean(self : DbindexbtreeEdge) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeEdge::scale(self : DbindexbtreeEdge, f : Double) -> DbindexbtreeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeEdge::add(self : DbindexbtreeEdge, other : DbindexbtreeEdge) -> DbindexbtreeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeEdge::copy(self : DbindexbtreeEdge) -> DbindexbtreeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeEdge::fill(self : DbindexbtreeEdge, v : Double) -> DbindexbtreeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeEdge::min(self : DbindexbtreeEdge) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeEdge::max(self : DbindexbtreeEdge) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeEdge::to_string(self : DbindexbtreeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_path_make(size : Int) -> DbindexbtreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreePath::len(self : DbindexbtreePath) -> Int { self.size }

pub fn DbindexbtreePath::get(self : DbindexbtreePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreePath::set(self : DbindexbtreePath, i : Int, v : Double) -> DbindexbtreePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreePath::sum(self : DbindexbtreePath) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreePath::mean(self : DbindexbtreePath) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreePath::scale(self : DbindexbtreePath, f : Double) -> DbindexbtreePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreePath::add(self : DbindexbtreePath, other : DbindexbtreePath) -> DbindexbtreePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreePath::copy(self : DbindexbtreePath) -> DbindexbtreePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreePath::fill(self : DbindexbtreePath, v : Double) -> DbindexbtreePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreePath::min(self : DbindexbtreePath) -> Double { @_common.min(self.data) }

pub fn DbindexbtreePath::max(self : DbindexbtreePath) -> Double { @_common.max(self.data) }

pub fn DbindexbtreePath::to_string(self : DbindexbtreePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_cluster_make(size : Int) -> DbindexbtreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeCluster::len(self : DbindexbtreeCluster) -> Int { self.size }

pub fn DbindexbtreeCluster::get(self : DbindexbtreeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeCluster::set(self : DbindexbtreeCluster, i : Int, v : Double) -> DbindexbtreeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeCluster::sum(self : DbindexbtreeCluster) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeCluster::mean(self : DbindexbtreeCluster) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeCluster::scale(self : DbindexbtreeCluster, f : Double) -> DbindexbtreeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeCluster::add(self : DbindexbtreeCluster, other : DbindexbtreeCluster) -> DbindexbtreeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeCluster::copy(self : DbindexbtreeCluster) -> DbindexbtreeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeCluster::fill(self : DbindexbtreeCluster, v : Double) -> DbindexbtreeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeCluster::min(self : DbindexbtreeCluster) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeCluster::max(self : DbindexbtreeCluster) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeCluster::to_string(self : DbindexbtreeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_model_make(size : Int) -> DbindexbtreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeModel::len(self : DbindexbtreeModel) -> Int { self.size }

pub fn DbindexbtreeModel::get(self : DbindexbtreeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeModel::set(self : DbindexbtreeModel, i : Int, v : Double) -> DbindexbtreeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeModel::sum(self : DbindexbtreeModel) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeModel::mean(self : DbindexbtreeModel) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeModel::scale(self : DbindexbtreeModel, f : Double) -> DbindexbtreeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeModel::add(self : DbindexbtreeModel, other : DbindexbtreeModel) -> DbindexbtreeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeModel::copy(self : DbindexbtreeModel) -> DbindexbtreeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeModel::fill(self : DbindexbtreeModel, v : Double) -> DbindexbtreeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeModel::min(self : DbindexbtreeModel) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeModel::max(self : DbindexbtreeModel) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeModel::to_string(self : DbindexbtreeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_layer_make(size : Int) -> DbindexbtreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeLayer::len(self : DbindexbtreeLayer) -> Int { self.size }

pub fn DbindexbtreeLayer::get(self : DbindexbtreeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeLayer::set(self : DbindexbtreeLayer, i : Int, v : Double) -> DbindexbtreeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeLayer::sum(self : DbindexbtreeLayer) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeLayer::mean(self : DbindexbtreeLayer) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeLayer::scale(self : DbindexbtreeLayer, f : Double) -> DbindexbtreeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeLayer::add(self : DbindexbtreeLayer, other : DbindexbtreeLayer) -> DbindexbtreeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeLayer::copy(self : DbindexbtreeLayer) -> DbindexbtreeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeLayer::fill(self : DbindexbtreeLayer, v : Double) -> DbindexbtreeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeLayer::min(self : DbindexbtreeLayer) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeLayer::max(self : DbindexbtreeLayer) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeLayer::to_string(self : DbindexbtreeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_buffer_make(size : Int) -> DbindexbtreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeBuffer::len(self : DbindexbtreeBuffer) -> Int { self.size }

pub fn DbindexbtreeBuffer::get(self : DbindexbtreeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeBuffer::set(self : DbindexbtreeBuffer, i : Int, v : Double) -> DbindexbtreeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeBuffer::sum(self : DbindexbtreeBuffer) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeBuffer::mean(self : DbindexbtreeBuffer) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeBuffer::scale(self : DbindexbtreeBuffer, f : Double) -> DbindexbtreeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeBuffer::add(self : DbindexbtreeBuffer, other : DbindexbtreeBuffer) -> DbindexbtreeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeBuffer::copy(self : DbindexbtreeBuffer) -> DbindexbtreeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeBuffer::fill(self : DbindexbtreeBuffer, v : Double) -> DbindexbtreeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeBuffer::min(self : DbindexbtreeBuffer) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeBuffer::max(self : DbindexbtreeBuffer) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeBuffer::to_string(self : DbindexbtreeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_cursor_make(size : Int) -> DbindexbtreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeCursor::len(self : DbindexbtreeCursor) -> Int { self.size }

pub fn DbindexbtreeCursor::get(self : DbindexbtreeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeCursor::set(self : DbindexbtreeCursor, i : Int, v : Double) -> DbindexbtreeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeCursor::sum(self : DbindexbtreeCursor) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeCursor::mean(self : DbindexbtreeCursor) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeCursor::scale(self : DbindexbtreeCursor, f : Double) -> DbindexbtreeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeCursor::add(self : DbindexbtreeCursor, other : DbindexbtreeCursor) -> DbindexbtreeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeCursor::copy(self : DbindexbtreeCursor) -> DbindexbtreeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeCursor::fill(self : DbindexbtreeCursor, v : Double) -> DbindexbtreeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeCursor::min(self : DbindexbtreeCursor) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeCursor::max(self : DbindexbtreeCursor) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeCursor::to_string(self : DbindexbtreeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_view_make(size : Int) -> DbindexbtreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeView::len(self : DbindexbtreeView) -> Int { self.size }

pub fn DbindexbtreeView::get(self : DbindexbtreeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeView::set(self : DbindexbtreeView, i : Int, v : Double) -> DbindexbtreeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeView::sum(self : DbindexbtreeView) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeView::mean(self : DbindexbtreeView) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeView::scale(self : DbindexbtreeView, f : Double) -> DbindexbtreeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeView::add(self : DbindexbtreeView, other : DbindexbtreeView) -> DbindexbtreeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeView::copy(self : DbindexbtreeView) -> DbindexbtreeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeView::fill(self : DbindexbtreeView, v : Double) -> DbindexbtreeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeView::min(self : DbindexbtreeView) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeView::max(self : DbindexbtreeView) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeView::to_string(self : DbindexbtreeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_range_make(size : Int) -> DbindexbtreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeRange::len(self : DbindexbtreeRange) -> Int { self.size }

pub fn DbindexbtreeRange::get(self : DbindexbtreeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeRange::set(self : DbindexbtreeRange, i : Int, v : Double) -> DbindexbtreeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeRange::sum(self : DbindexbtreeRange) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeRange::mean(self : DbindexbtreeRange) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeRange::scale(self : DbindexbtreeRange, f : Double) -> DbindexbtreeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeRange::add(self : DbindexbtreeRange, other : DbindexbtreeRange) -> DbindexbtreeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeRange::copy(self : DbindexbtreeRange) -> DbindexbtreeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeRange::fill(self : DbindexbtreeRange, v : Double) -> DbindexbtreeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeRange::min(self : DbindexbtreeRange) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeRange::max(self : DbindexbtreeRange) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeRange::to_string(self : DbindexbtreeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_slice_make(size : Int) -> DbindexbtreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbtreeSlice::len(self : DbindexbtreeSlice) -> Int { self.size }

pub fn DbindexbtreeSlice::get(self : DbindexbtreeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbtreeSlice::set(self : DbindexbtreeSlice, i : Int, v : Double) -> DbindexbtreeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbtreeSlice::sum(self : DbindexbtreeSlice) -> Double { @_common.sum(self.data) }

pub fn DbindexbtreeSlice::mean(self : DbindexbtreeSlice) -> Double { @_common.mean(self.data) }

pub fn DbindexbtreeSlice::scale(self : DbindexbtreeSlice, f : Double) -> DbindexbtreeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeSlice::add(self : DbindexbtreeSlice, other : DbindexbtreeSlice) -> DbindexbtreeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbtreeSlice::copy(self : DbindexbtreeSlice) -> DbindexbtreeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeSlice::fill(self : DbindexbtreeSlice, v : Double) -> DbindexbtreeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbtreeSlice::min(self : DbindexbtreeSlice) -> Double { @_common.min(self.data) }

pub fn DbindexbtreeSlice::max(self : DbindexbtreeSlice) -> Double { @_common.max(self.data) }

pub fn DbindexbtreeSlice::to_string(self : DbindexbtreeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

