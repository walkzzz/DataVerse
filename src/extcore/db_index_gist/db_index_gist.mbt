///===
/// extcore/db_index_gist

pub(all) struct DbindexgistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_gist_make_point(x : Double, y : Double) -> DbindexgistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_gist_make_point3(x : Double, y : Double, z : Double) -> DbindexgistPoint {
  { x, y, z, label: 0 }
}

pub fn DbindexgistPoint::x(self : DbindexgistPoint) -> Double { self.x }

pub fn DbindexgistPoint::y(self : DbindexgistPoint) -> Double { self.y }

pub fn DbindexgistPoint::z(self : DbindexgistPoint) -> Double { self.z }

pub fn DbindexgistPoint::label(self : DbindexgistPoint) -> Int { self.label }

pub fn DbindexgistPoint::dist(self : DbindexgistPoint, other : DbindexgistPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexgistPoint::add(self : DbindexgistPoint, other : DbindexgistPoint) -> DbindexgistPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexgistPoint::sub(self : DbindexgistPoint, other : DbindexgistPoint) -> DbindexgistPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexgistPoint::scale(self : DbindexgistPoint, s : Double) -> DbindexgistPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexgistPoint::dot(self : DbindexgistPoint, other : DbindexgistPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexgistPoint::cross(self : DbindexgistPoint, other : DbindexgistPoint) -> DbindexgistPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexgistPoint::norm(self : DbindexgistPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexgistPoint::normalize(self : DbindexgistPoint) -> DbindexgistPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexgistPoint::negate(self : DbindexgistPoint) -> DbindexgistPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexgistPoint::mid(self : DbindexgistPoint, other : DbindexgistPoint) -> DbindexgistPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexgistPoint::lerp(self : DbindexgistPoint, other : DbindexgistPoint, t : Double) -> DbindexgistPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexgistPoint::to_string(self : DbindexgistPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexgistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_gist_make_series(vals : Array[Double], name : String) -> DbindexgistSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexgistSeries::len(self : DbindexgistSeries) -> Int { self.vals.length() }

pub fn DbindexgistSeries::sum(self : DbindexgistSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexgistSeries::mean(self : DbindexgistSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexgistSeries::min(self : DbindexgistSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexgistSeries::max(self : DbindexgistSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexgistSeries::range(self : DbindexgistSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexgistSeries::variance(self : DbindexgistSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexgistSeries::std(self : DbindexgistSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexgistSeries::median(self : DbindexgistSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexgistSeries::scale(self : DbindexgistSeries, f : Double) -> DbindexgistSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexgistSeries::add(self : DbindexgistSeries, other : DbindexgistSeries) -> DbindexgistSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexgistSeries::sub(self : DbindexgistSeries, other : DbindexgistSeries) -> DbindexgistSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexgistSeries::normalize(self : DbindexgistSeries) -> DbindexgistSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexgistSeries::cumsum(self : DbindexgistSeries) -> DbindexgistSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexgistSeries::to_string(self : DbindexgistSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexgistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_gist_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexgistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_gist_matrix_identity(n : Int) -> DbindexgistMatrix {
  let m = db_index_gist_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexgistMatrix::get(self : DbindexgistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexgistMatrix::transpose(self : DbindexgistMatrix) -> DbindexgistMatrix {
  let result = db_index_gist_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexgistMatrix::add(self : DbindexgistMatrix, other : DbindexgistMatrix) -> DbindexgistMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_gist_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexgistMatrix::scale(self : DbindexgistMatrix, s : Double) -> DbindexgistMatrix {
  let result = db_index_gist_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexgistMatrix::multiply(self : DbindexgistMatrix, other : DbindexgistMatrix) -> DbindexgistMatrix {
  if self.cols != other.rows { return db_index_gist_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_gist_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbindexgistMatrix::trace(self : DbindexgistMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexgistMatrix::det(self : DbindexgistMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexgistMatrix::norm(self : DbindexgistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexgistMatrix::to_string(self : DbindexgistMatrix) -> String {
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

pub(all) struct DbindexgistVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_gist_make_vector(comps : Array[Double]) -> DbindexgistVector {
  { comps, dim: comps.length() }
}

pub fn db_index_gist_vector_zero(dim : Int) -> DbindexgistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexgistVector::add(self : DbindexgistVector, other : DbindexgistVector) -> DbindexgistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexgistVector::sub(self : DbindexgistVector, other : DbindexgistVector) -> DbindexgistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexgistVector::scale(self : DbindexgistVector, s : Double) -> DbindexgistVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexgistVector::dot(self : DbindexgistVector, other : DbindexgistVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexgistVector::norm(self : DbindexgistVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexgistVector::normalize(self : DbindexgistVector) -> DbindexgistVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexgistVector::dist(self : DbindexgistVector, other : DbindexgistVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexgistVector::to_string(self : DbindexgistVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexgistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_frame_make(size : Int) -> DbindexgistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistFrame::len(self : DbindexgistFrame) -> Int { self.size }

pub fn DbindexgistFrame::get(self : DbindexgistFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistFrame::set(self : DbindexgistFrame, i : Int, v : Double) -> DbindexgistFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistFrame::sum(self : DbindexgistFrame) -> Double { @_common.sum(self.data) }

pub fn DbindexgistFrame::mean(self : DbindexgistFrame) -> Double { @_common.mean(self.data) }

pub fn DbindexgistFrame::scale(self : DbindexgistFrame, f : Double) -> DbindexgistFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistFrame::add(self : DbindexgistFrame, other : DbindexgistFrame) -> DbindexgistFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistFrame::copy(self : DbindexgistFrame) -> DbindexgistFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistFrame::fill(self : DbindexgistFrame, v : Double) -> DbindexgistFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistFrame::min(self : DbindexgistFrame) -> Double { @_common.min(self.data) }

pub fn DbindexgistFrame::max(self : DbindexgistFrame) -> Double { @_common.max(self.data) }

pub fn DbindexgistFrame::to_string(self : DbindexgistFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_table_make(size : Int) -> DbindexgistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistTable::len(self : DbindexgistTable) -> Int { self.size }

pub fn DbindexgistTable::get(self : DbindexgistTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistTable::set(self : DbindexgistTable, i : Int, v : Double) -> DbindexgistTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistTable::sum(self : DbindexgistTable) -> Double { @_common.sum(self.data) }

pub fn DbindexgistTable::mean(self : DbindexgistTable) -> Double { @_common.mean(self.data) }

pub fn DbindexgistTable::scale(self : DbindexgistTable, f : Double) -> DbindexgistTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistTable::add(self : DbindexgistTable, other : DbindexgistTable) -> DbindexgistTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistTable::copy(self : DbindexgistTable) -> DbindexgistTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistTable::fill(self : DbindexgistTable, v : Double) -> DbindexgistTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistTable::min(self : DbindexgistTable) -> Double { @_common.min(self.data) }

pub fn DbindexgistTable::max(self : DbindexgistTable) -> Double { @_common.max(self.data) }

pub fn DbindexgistTable::to_string(self : DbindexgistTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_graphn_make(size : Int) -> DbindexgistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistGraphN::len(self : DbindexgistGraphN) -> Int { self.size }

pub fn DbindexgistGraphN::get(self : DbindexgistGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistGraphN::set(self : DbindexgistGraphN, i : Int, v : Double) -> DbindexgistGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistGraphN::sum(self : DbindexgistGraphN) -> Double { @_common.sum(self.data) }

pub fn DbindexgistGraphN::mean(self : DbindexgistGraphN) -> Double { @_common.mean(self.data) }

pub fn DbindexgistGraphN::scale(self : DbindexgistGraphN, f : Double) -> DbindexgistGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistGraphN::add(self : DbindexgistGraphN, other : DbindexgistGraphN) -> DbindexgistGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistGraphN::copy(self : DbindexgistGraphN) -> DbindexgistGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistGraphN::fill(self : DbindexgistGraphN, v : Double) -> DbindexgistGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistGraphN::min(self : DbindexgistGraphN) -> Double { @_common.min(self.data) }

pub fn DbindexgistGraphN::max(self : DbindexgistGraphN) -> Double { @_common.max(self.data) }

pub fn DbindexgistGraphN::to_string(self : DbindexgistGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_node_make(size : Int) -> DbindexgistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistNode::len(self : DbindexgistNode) -> Int { self.size }

pub fn DbindexgistNode::get(self : DbindexgistNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistNode::set(self : DbindexgistNode, i : Int, v : Double) -> DbindexgistNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistNode::sum(self : DbindexgistNode) -> Double { @_common.sum(self.data) }

pub fn DbindexgistNode::mean(self : DbindexgistNode) -> Double { @_common.mean(self.data) }

pub fn DbindexgistNode::scale(self : DbindexgistNode, f : Double) -> DbindexgistNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistNode::add(self : DbindexgistNode, other : DbindexgistNode) -> DbindexgistNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistNode::copy(self : DbindexgistNode) -> DbindexgistNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistNode::fill(self : DbindexgistNode, v : Double) -> DbindexgistNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistNode::min(self : DbindexgistNode) -> Double { @_common.min(self.data) }

pub fn DbindexgistNode::max(self : DbindexgistNode) -> Double { @_common.max(self.data) }

pub fn DbindexgistNode::to_string(self : DbindexgistNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_edge_make(size : Int) -> DbindexgistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistEdge::len(self : DbindexgistEdge) -> Int { self.size }

pub fn DbindexgistEdge::get(self : DbindexgistEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistEdge::set(self : DbindexgistEdge, i : Int, v : Double) -> DbindexgistEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistEdge::sum(self : DbindexgistEdge) -> Double { @_common.sum(self.data) }

pub fn DbindexgistEdge::mean(self : DbindexgistEdge) -> Double { @_common.mean(self.data) }

pub fn DbindexgistEdge::scale(self : DbindexgistEdge, f : Double) -> DbindexgistEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistEdge::add(self : DbindexgistEdge, other : DbindexgistEdge) -> DbindexgistEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistEdge::copy(self : DbindexgistEdge) -> DbindexgistEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistEdge::fill(self : DbindexgistEdge, v : Double) -> DbindexgistEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistEdge::min(self : DbindexgistEdge) -> Double { @_common.min(self.data) }

pub fn DbindexgistEdge::max(self : DbindexgistEdge) -> Double { @_common.max(self.data) }

pub fn DbindexgistEdge::to_string(self : DbindexgistEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_path_make(size : Int) -> DbindexgistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistPath::len(self : DbindexgistPath) -> Int { self.size }

pub fn DbindexgistPath::get(self : DbindexgistPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistPath::set(self : DbindexgistPath, i : Int, v : Double) -> DbindexgistPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistPath::sum(self : DbindexgistPath) -> Double { @_common.sum(self.data) }

pub fn DbindexgistPath::mean(self : DbindexgistPath) -> Double { @_common.mean(self.data) }

pub fn DbindexgistPath::scale(self : DbindexgistPath, f : Double) -> DbindexgistPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistPath::add(self : DbindexgistPath, other : DbindexgistPath) -> DbindexgistPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistPath::copy(self : DbindexgistPath) -> DbindexgistPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistPath::fill(self : DbindexgistPath, v : Double) -> DbindexgistPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistPath::min(self : DbindexgistPath) -> Double { @_common.min(self.data) }

pub fn DbindexgistPath::max(self : DbindexgistPath) -> Double { @_common.max(self.data) }

pub fn DbindexgistPath::to_string(self : DbindexgistPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_cluster_make(size : Int) -> DbindexgistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistCluster::len(self : DbindexgistCluster) -> Int { self.size }

pub fn DbindexgistCluster::get(self : DbindexgistCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistCluster::set(self : DbindexgistCluster, i : Int, v : Double) -> DbindexgistCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistCluster::sum(self : DbindexgistCluster) -> Double { @_common.sum(self.data) }

pub fn DbindexgistCluster::mean(self : DbindexgistCluster) -> Double { @_common.mean(self.data) }

pub fn DbindexgistCluster::scale(self : DbindexgistCluster, f : Double) -> DbindexgistCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistCluster::add(self : DbindexgistCluster, other : DbindexgistCluster) -> DbindexgistCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistCluster::copy(self : DbindexgistCluster) -> DbindexgistCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistCluster::fill(self : DbindexgistCluster, v : Double) -> DbindexgistCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistCluster::min(self : DbindexgistCluster) -> Double { @_common.min(self.data) }

pub fn DbindexgistCluster::max(self : DbindexgistCluster) -> Double { @_common.max(self.data) }

pub fn DbindexgistCluster::to_string(self : DbindexgistCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_model_make(size : Int) -> DbindexgistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistModel::len(self : DbindexgistModel) -> Int { self.size }

pub fn DbindexgistModel::get(self : DbindexgistModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistModel::set(self : DbindexgistModel, i : Int, v : Double) -> DbindexgistModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistModel::sum(self : DbindexgistModel) -> Double { @_common.sum(self.data) }

pub fn DbindexgistModel::mean(self : DbindexgistModel) -> Double { @_common.mean(self.data) }

pub fn DbindexgistModel::scale(self : DbindexgistModel, f : Double) -> DbindexgistModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistModel::add(self : DbindexgistModel, other : DbindexgistModel) -> DbindexgistModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistModel::copy(self : DbindexgistModel) -> DbindexgistModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistModel::fill(self : DbindexgistModel, v : Double) -> DbindexgistModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistModel::min(self : DbindexgistModel) -> Double { @_common.min(self.data) }

pub fn DbindexgistModel::max(self : DbindexgistModel) -> Double { @_common.max(self.data) }

pub fn DbindexgistModel::to_string(self : DbindexgistModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_layer_make(size : Int) -> DbindexgistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistLayer::len(self : DbindexgistLayer) -> Int { self.size }

pub fn DbindexgistLayer::get(self : DbindexgistLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistLayer::set(self : DbindexgistLayer, i : Int, v : Double) -> DbindexgistLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistLayer::sum(self : DbindexgistLayer) -> Double { @_common.sum(self.data) }

pub fn DbindexgistLayer::mean(self : DbindexgistLayer) -> Double { @_common.mean(self.data) }

pub fn DbindexgistLayer::scale(self : DbindexgistLayer, f : Double) -> DbindexgistLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistLayer::add(self : DbindexgistLayer, other : DbindexgistLayer) -> DbindexgistLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistLayer::copy(self : DbindexgistLayer) -> DbindexgistLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistLayer::fill(self : DbindexgistLayer, v : Double) -> DbindexgistLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistLayer::min(self : DbindexgistLayer) -> Double { @_common.min(self.data) }

pub fn DbindexgistLayer::max(self : DbindexgistLayer) -> Double { @_common.max(self.data) }

pub fn DbindexgistLayer::to_string(self : DbindexgistLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_buffer_make(size : Int) -> DbindexgistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistBuffer::len(self : DbindexgistBuffer) -> Int { self.size }

pub fn DbindexgistBuffer::get(self : DbindexgistBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistBuffer::set(self : DbindexgistBuffer, i : Int, v : Double) -> DbindexgistBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistBuffer::sum(self : DbindexgistBuffer) -> Double { @_common.sum(self.data) }

pub fn DbindexgistBuffer::mean(self : DbindexgistBuffer) -> Double { @_common.mean(self.data) }

pub fn DbindexgistBuffer::scale(self : DbindexgistBuffer, f : Double) -> DbindexgistBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistBuffer::add(self : DbindexgistBuffer, other : DbindexgistBuffer) -> DbindexgistBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistBuffer::copy(self : DbindexgistBuffer) -> DbindexgistBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistBuffer::fill(self : DbindexgistBuffer, v : Double) -> DbindexgistBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistBuffer::min(self : DbindexgistBuffer) -> Double { @_common.min(self.data) }

pub fn DbindexgistBuffer::max(self : DbindexgistBuffer) -> Double { @_common.max(self.data) }

pub fn DbindexgistBuffer::to_string(self : DbindexgistBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_cursor_make(size : Int) -> DbindexgistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistCursor::len(self : DbindexgistCursor) -> Int { self.size }

pub fn DbindexgistCursor::get(self : DbindexgistCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistCursor::set(self : DbindexgistCursor, i : Int, v : Double) -> DbindexgistCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistCursor::sum(self : DbindexgistCursor) -> Double { @_common.sum(self.data) }

pub fn DbindexgistCursor::mean(self : DbindexgistCursor) -> Double { @_common.mean(self.data) }

pub fn DbindexgistCursor::scale(self : DbindexgistCursor, f : Double) -> DbindexgistCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistCursor::add(self : DbindexgistCursor, other : DbindexgistCursor) -> DbindexgistCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistCursor::copy(self : DbindexgistCursor) -> DbindexgistCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistCursor::fill(self : DbindexgistCursor, v : Double) -> DbindexgistCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistCursor::min(self : DbindexgistCursor) -> Double { @_common.min(self.data) }

pub fn DbindexgistCursor::max(self : DbindexgistCursor) -> Double { @_common.max(self.data) }

pub fn DbindexgistCursor::to_string(self : DbindexgistCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_view_make(size : Int) -> DbindexgistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistView::len(self : DbindexgistView) -> Int { self.size }

pub fn DbindexgistView::get(self : DbindexgistView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistView::set(self : DbindexgistView, i : Int, v : Double) -> DbindexgistView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistView::sum(self : DbindexgistView) -> Double { @_common.sum(self.data) }

pub fn DbindexgistView::mean(self : DbindexgistView) -> Double { @_common.mean(self.data) }

pub fn DbindexgistView::scale(self : DbindexgistView, f : Double) -> DbindexgistView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistView::add(self : DbindexgistView, other : DbindexgistView) -> DbindexgistView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistView::copy(self : DbindexgistView) -> DbindexgistView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistView::fill(self : DbindexgistView, v : Double) -> DbindexgistView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistView::min(self : DbindexgistView) -> Double { @_common.min(self.data) }

pub fn DbindexgistView::max(self : DbindexgistView) -> Double { @_common.max(self.data) }

pub fn DbindexgistView::to_string(self : DbindexgistView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_range_make(size : Int) -> DbindexgistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistRange::len(self : DbindexgistRange) -> Int { self.size }

pub fn DbindexgistRange::get(self : DbindexgistRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistRange::set(self : DbindexgistRange, i : Int, v : Double) -> DbindexgistRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistRange::sum(self : DbindexgistRange) -> Double { @_common.sum(self.data) }

pub fn DbindexgistRange::mean(self : DbindexgistRange) -> Double { @_common.mean(self.data) }

pub fn DbindexgistRange::scale(self : DbindexgistRange, f : Double) -> DbindexgistRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistRange::add(self : DbindexgistRange, other : DbindexgistRange) -> DbindexgistRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistRange::copy(self : DbindexgistRange) -> DbindexgistRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistRange::fill(self : DbindexgistRange, v : Double) -> DbindexgistRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistRange::min(self : DbindexgistRange) -> Double { @_common.min(self.data) }

pub fn DbindexgistRange::max(self : DbindexgistRange) -> Double { @_common.max(self.data) }

pub fn DbindexgistRange::to_string(self : DbindexgistRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexgistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_slice_make(size : Int) -> DbindexgistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexgistSlice::len(self : DbindexgistSlice) -> Int { self.size }

pub fn DbindexgistSlice::get(self : DbindexgistSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexgistSlice::set(self : DbindexgistSlice, i : Int, v : Double) -> DbindexgistSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexgistSlice::sum(self : DbindexgistSlice) -> Double { @_common.sum(self.data) }

pub fn DbindexgistSlice::mean(self : DbindexgistSlice) -> Double { @_common.mean(self.data) }

pub fn DbindexgistSlice::scale(self : DbindexgistSlice, f : Double) -> DbindexgistSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexgistSlice::add(self : DbindexgistSlice, other : DbindexgistSlice) -> DbindexgistSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexgistSlice::copy(self : DbindexgistSlice) -> DbindexgistSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexgistSlice::fill(self : DbindexgistSlice, v : Double) -> DbindexgistSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexgistSlice::min(self : DbindexgistSlice) -> Double { @_common.min(self.data) }

pub fn DbindexgistSlice::max(self : DbindexgistSlice) -> Double { @_common.max(self.data) }

pub fn DbindexgistSlice::to_string(self : DbindexgistSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

