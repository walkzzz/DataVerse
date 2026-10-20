///===
/// extcore/db_index_vector

pub(all) struct DbindexvectorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_vector_make_point(x : Double, y : Double) -> DbindexvectorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_vector_make_point3(x : Double, y : Double, z : Double) -> DbindexvectorPoint {
  { x, y, z, label: 0 }
}

pub fn DbindexvectorPoint::x(self : DbindexvectorPoint) -> Double { self.x }

pub fn DbindexvectorPoint::y(self : DbindexvectorPoint) -> Double { self.y }

pub fn DbindexvectorPoint::z(self : DbindexvectorPoint) -> Double { self.z }

pub fn DbindexvectorPoint::label(self : DbindexvectorPoint) -> Int { self.label }

pub fn DbindexvectorPoint::dist(self : DbindexvectorPoint, other : DbindexvectorPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexvectorPoint::add(self : DbindexvectorPoint, other : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexvectorPoint::sub(self : DbindexvectorPoint, other : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexvectorPoint::scale(self : DbindexvectorPoint, s : Double) -> DbindexvectorPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexvectorPoint::dot(self : DbindexvectorPoint, other : DbindexvectorPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexvectorPoint::cross(self : DbindexvectorPoint, other : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexvectorPoint::norm(self : DbindexvectorPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexvectorPoint::normalize(self : DbindexvectorPoint) -> DbindexvectorPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexvectorPoint::negate(self : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexvectorPoint::mid(self : DbindexvectorPoint, other : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexvectorPoint::lerp(self : DbindexvectorPoint, other : DbindexvectorPoint, t : Double) -> DbindexvectorPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexvectorPoint::to_string(self : DbindexvectorPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexvectorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_vector_make_series(vals : Array[Double], name : String) -> DbindexvectorSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexvectorSeries::len(self : DbindexvectorSeries) -> Int { self.vals.length() }

pub fn DbindexvectorSeries::sum(self : DbindexvectorSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexvectorSeries::mean(self : DbindexvectorSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexvectorSeries::min(self : DbindexvectorSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexvectorSeries::max(self : DbindexvectorSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexvectorSeries::range(self : DbindexvectorSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexvectorSeries::variance(self : DbindexvectorSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexvectorSeries::std(self : DbindexvectorSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexvectorSeries::median(self : DbindexvectorSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexvectorSeries::scale(self : DbindexvectorSeries, f : Double) -> DbindexvectorSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexvectorSeries::add(self : DbindexvectorSeries, other : DbindexvectorSeries) -> DbindexvectorSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexvectorSeries::sub(self : DbindexvectorSeries, other : DbindexvectorSeries) -> DbindexvectorSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexvectorSeries::normalize(self : DbindexvectorSeries) -> DbindexvectorSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexvectorSeries::cumsum(self : DbindexvectorSeries) -> DbindexvectorSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexvectorSeries::to_string(self : DbindexvectorSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexvectorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_vector_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexvectorMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn db_index_vector_matrix_identity(n : Int) -> DbindexvectorMatrix {
  let m = db_index_vector_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexvectorMatrix::get(self : DbindexvectorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexvectorMatrix::transpose(self : DbindexvectorMatrix) -> DbindexvectorMatrix {
  let result = db_index_vector_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexvectorMatrix::add(self : DbindexvectorMatrix, other : DbindexvectorMatrix) -> DbindexvectorMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_vector_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexvectorMatrix::scale(self : DbindexvectorMatrix, s : Double) -> DbindexvectorMatrix {
  let result = db_index_vector_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexvectorMatrix::multiply(self : DbindexvectorMatrix, other : DbindexvectorMatrix) -> DbindexvectorMatrix {
  if self.cols != other.rows { return db_index_vector_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_vector_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DbindexvectorMatrix::trace(self : DbindexvectorMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexvectorMatrix::det(self : DbindexvectorMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexvectorMatrix::norm(self : DbindexvectorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexvectorMatrix::to_string(self : DbindexvectorMatrix) -> String {
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

pub(all) struct DbindexvectorVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_vector_make_vector(comps : Array[Double]) -> DbindexvectorVector {
  { comps, dim: comps.length() }
}

pub fn db_index_vector_vector_zero(dim : Int) -> DbindexvectorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexvectorVector::add(self : DbindexvectorVector, other : DbindexvectorVector) -> DbindexvectorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexvectorVector::sub(self : DbindexvectorVector, other : DbindexvectorVector) -> DbindexvectorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexvectorVector::scale(self : DbindexvectorVector, s : Double) -> DbindexvectorVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexvectorVector::dot(self : DbindexvectorVector, other : DbindexvectorVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexvectorVector::norm(self : DbindexvectorVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexvectorVector::normalize(self : DbindexvectorVector) -> DbindexvectorVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexvectorVector::dist(self : DbindexvectorVector, other : DbindexvectorVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexvectorVector::to_string(self : DbindexvectorVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexvectorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_frame_make(size : Int) -> DbindexvectorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorFrame::len(self : DbindexvectorFrame) -> Int { self.size }

pub fn DbindexvectorFrame::get(self : DbindexvectorFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorFrame::set(self : DbindexvectorFrame, i : Int, v : Double) -> DbindexvectorFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorFrame::sum(self : DbindexvectorFrame) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorFrame::mean(self : DbindexvectorFrame) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorFrame::scale(self : DbindexvectorFrame, f : Double) -> DbindexvectorFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorFrame::add(self : DbindexvectorFrame, other : DbindexvectorFrame) -> DbindexvectorFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorFrame::copy(self : DbindexvectorFrame) -> DbindexvectorFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorFrame::fill(self : DbindexvectorFrame, v : Double) -> DbindexvectorFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorFrame::min(self : DbindexvectorFrame) -> Double { @_common.min(self.data) }

pub fn DbindexvectorFrame::max(self : DbindexvectorFrame) -> Double { @_common.max(self.data) }

pub fn DbindexvectorFrame::to_string(self : DbindexvectorFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_table_make(size : Int) -> DbindexvectorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorTable::len(self : DbindexvectorTable) -> Int { self.size }

pub fn DbindexvectorTable::get(self : DbindexvectorTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorTable::set(self : DbindexvectorTable, i : Int, v : Double) -> DbindexvectorTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorTable::sum(self : DbindexvectorTable) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorTable::mean(self : DbindexvectorTable) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorTable::scale(self : DbindexvectorTable, f : Double) -> DbindexvectorTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorTable::add(self : DbindexvectorTable, other : DbindexvectorTable) -> DbindexvectorTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorTable::copy(self : DbindexvectorTable) -> DbindexvectorTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorTable::fill(self : DbindexvectorTable, v : Double) -> DbindexvectorTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorTable::min(self : DbindexvectorTable) -> Double { @_common.min(self.data) }

pub fn DbindexvectorTable::max(self : DbindexvectorTable) -> Double { @_common.max(self.data) }

pub fn DbindexvectorTable::to_string(self : DbindexvectorTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_graphn_make(size : Int) -> DbindexvectorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorGraphN::len(self : DbindexvectorGraphN) -> Int { self.size }

pub fn DbindexvectorGraphN::get(self : DbindexvectorGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorGraphN::set(self : DbindexvectorGraphN, i : Int, v : Double) -> DbindexvectorGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorGraphN::sum(self : DbindexvectorGraphN) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorGraphN::mean(self : DbindexvectorGraphN) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorGraphN::scale(self : DbindexvectorGraphN, f : Double) -> DbindexvectorGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorGraphN::add(self : DbindexvectorGraphN, other : DbindexvectorGraphN) -> DbindexvectorGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorGraphN::copy(self : DbindexvectorGraphN) -> DbindexvectorGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorGraphN::fill(self : DbindexvectorGraphN, v : Double) -> DbindexvectorGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorGraphN::min(self : DbindexvectorGraphN) -> Double { @_common.min(self.data) }

pub fn DbindexvectorGraphN::max(self : DbindexvectorGraphN) -> Double { @_common.max(self.data) }

pub fn DbindexvectorGraphN::to_string(self : DbindexvectorGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_node_make(size : Int) -> DbindexvectorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorNode::len(self : DbindexvectorNode) -> Int { self.size }

pub fn DbindexvectorNode::get(self : DbindexvectorNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorNode::set(self : DbindexvectorNode, i : Int, v : Double) -> DbindexvectorNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorNode::sum(self : DbindexvectorNode) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorNode::mean(self : DbindexvectorNode) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorNode::scale(self : DbindexvectorNode, f : Double) -> DbindexvectorNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorNode::add(self : DbindexvectorNode, other : DbindexvectorNode) -> DbindexvectorNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorNode::copy(self : DbindexvectorNode) -> DbindexvectorNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorNode::fill(self : DbindexvectorNode, v : Double) -> DbindexvectorNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorNode::min(self : DbindexvectorNode) -> Double { @_common.min(self.data) }

pub fn DbindexvectorNode::max(self : DbindexvectorNode) -> Double { @_common.max(self.data) }

pub fn DbindexvectorNode::to_string(self : DbindexvectorNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_edge_make(size : Int) -> DbindexvectorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorEdge::len(self : DbindexvectorEdge) -> Int { self.size }

pub fn DbindexvectorEdge::get(self : DbindexvectorEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorEdge::set(self : DbindexvectorEdge, i : Int, v : Double) -> DbindexvectorEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorEdge::sum(self : DbindexvectorEdge) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorEdge::mean(self : DbindexvectorEdge) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorEdge::scale(self : DbindexvectorEdge, f : Double) -> DbindexvectorEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorEdge::add(self : DbindexvectorEdge, other : DbindexvectorEdge) -> DbindexvectorEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorEdge::copy(self : DbindexvectorEdge) -> DbindexvectorEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorEdge::fill(self : DbindexvectorEdge, v : Double) -> DbindexvectorEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorEdge::min(self : DbindexvectorEdge) -> Double { @_common.min(self.data) }

pub fn DbindexvectorEdge::max(self : DbindexvectorEdge) -> Double { @_common.max(self.data) }

pub fn DbindexvectorEdge::to_string(self : DbindexvectorEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_path_make(size : Int) -> DbindexvectorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorPath::len(self : DbindexvectorPath) -> Int { self.size }

pub fn DbindexvectorPath::get(self : DbindexvectorPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorPath::set(self : DbindexvectorPath, i : Int, v : Double) -> DbindexvectorPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorPath::sum(self : DbindexvectorPath) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorPath::mean(self : DbindexvectorPath) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorPath::scale(self : DbindexvectorPath, f : Double) -> DbindexvectorPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorPath::add(self : DbindexvectorPath, other : DbindexvectorPath) -> DbindexvectorPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorPath::copy(self : DbindexvectorPath) -> DbindexvectorPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorPath::fill(self : DbindexvectorPath, v : Double) -> DbindexvectorPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorPath::min(self : DbindexvectorPath) -> Double { @_common.min(self.data) }

pub fn DbindexvectorPath::max(self : DbindexvectorPath) -> Double { @_common.max(self.data) }

pub fn DbindexvectorPath::to_string(self : DbindexvectorPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_cluster_make(size : Int) -> DbindexvectorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorCluster::len(self : DbindexvectorCluster) -> Int { self.size }

pub fn DbindexvectorCluster::get(self : DbindexvectorCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorCluster::set(self : DbindexvectorCluster, i : Int, v : Double) -> DbindexvectorCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorCluster::sum(self : DbindexvectorCluster) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorCluster::mean(self : DbindexvectorCluster) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorCluster::scale(self : DbindexvectorCluster, f : Double) -> DbindexvectorCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorCluster::add(self : DbindexvectorCluster, other : DbindexvectorCluster) -> DbindexvectorCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorCluster::copy(self : DbindexvectorCluster) -> DbindexvectorCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorCluster::fill(self : DbindexvectorCluster, v : Double) -> DbindexvectorCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorCluster::min(self : DbindexvectorCluster) -> Double { @_common.min(self.data) }

pub fn DbindexvectorCluster::max(self : DbindexvectorCluster) -> Double { @_common.max(self.data) }

pub fn DbindexvectorCluster::to_string(self : DbindexvectorCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_model_make(size : Int) -> DbindexvectorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorModel::len(self : DbindexvectorModel) -> Int { self.size }

pub fn DbindexvectorModel::get(self : DbindexvectorModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorModel::set(self : DbindexvectorModel, i : Int, v : Double) -> DbindexvectorModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorModel::sum(self : DbindexvectorModel) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorModel::mean(self : DbindexvectorModel) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorModel::scale(self : DbindexvectorModel, f : Double) -> DbindexvectorModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorModel::add(self : DbindexvectorModel, other : DbindexvectorModel) -> DbindexvectorModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorModel::copy(self : DbindexvectorModel) -> DbindexvectorModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorModel::fill(self : DbindexvectorModel, v : Double) -> DbindexvectorModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorModel::min(self : DbindexvectorModel) -> Double { @_common.min(self.data) }

pub fn DbindexvectorModel::max(self : DbindexvectorModel) -> Double { @_common.max(self.data) }

pub fn DbindexvectorModel::to_string(self : DbindexvectorModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_layer_make(size : Int) -> DbindexvectorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorLayer::len(self : DbindexvectorLayer) -> Int { self.size }

pub fn DbindexvectorLayer::get(self : DbindexvectorLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorLayer::set(self : DbindexvectorLayer, i : Int, v : Double) -> DbindexvectorLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorLayer::sum(self : DbindexvectorLayer) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorLayer::mean(self : DbindexvectorLayer) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorLayer::scale(self : DbindexvectorLayer, f : Double) -> DbindexvectorLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorLayer::add(self : DbindexvectorLayer, other : DbindexvectorLayer) -> DbindexvectorLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorLayer::copy(self : DbindexvectorLayer) -> DbindexvectorLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorLayer::fill(self : DbindexvectorLayer, v : Double) -> DbindexvectorLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorLayer::min(self : DbindexvectorLayer) -> Double { @_common.min(self.data) }

pub fn DbindexvectorLayer::max(self : DbindexvectorLayer) -> Double { @_common.max(self.data) }

pub fn DbindexvectorLayer::to_string(self : DbindexvectorLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_buffer_make(size : Int) -> DbindexvectorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorBuffer::len(self : DbindexvectorBuffer) -> Int { self.size }

pub fn DbindexvectorBuffer::get(self : DbindexvectorBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorBuffer::set(self : DbindexvectorBuffer, i : Int, v : Double) -> DbindexvectorBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorBuffer::sum(self : DbindexvectorBuffer) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorBuffer::mean(self : DbindexvectorBuffer) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorBuffer::scale(self : DbindexvectorBuffer, f : Double) -> DbindexvectorBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorBuffer::add(self : DbindexvectorBuffer, other : DbindexvectorBuffer) -> DbindexvectorBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorBuffer::copy(self : DbindexvectorBuffer) -> DbindexvectorBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorBuffer::fill(self : DbindexvectorBuffer, v : Double) -> DbindexvectorBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorBuffer::min(self : DbindexvectorBuffer) -> Double { @_common.min(self.data) }

pub fn DbindexvectorBuffer::max(self : DbindexvectorBuffer) -> Double { @_common.max(self.data) }

pub fn DbindexvectorBuffer::to_string(self : DbindexvectorBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_cursor_make(size : Int) -> DbindexvectorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorCursor::len(self : DbindexvectorCursor) -> Int { self.size }

pub fn DbindexvectorCursor::get(self : DbindexvectorCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorCursor::set(self : DbindexvectorCursor, i : Int, v : Double) -> DbindexvectorCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorCursor::sum(self : DbindexvectorCursor) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorCursor::mean(self : DbindexvectorCursor) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorCursor::scale(self : DbindexvectorCursor, f : Double) -> DbindexvectorCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorCursor::add(self : DbindexvectorCursor, other : DbindexvectorCursor) -> DbindexvectorCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorCursor::copy(self : DbindexvectorCursor) -> DbindexvectorCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorCursor::fill(self : DbindexvectorCursor, v : Double) -> DbindexvectorCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorCursor::min(self : DbindexvectorCursor) -> Double { @_common.min(self.data) }

pub fn DbindexvectorCursor::max(self : DbindexvectorCursor) -> Double { @_common.max(self.data) }

pub fn DbindexvectorCursor::to_string(self : DbindexvectorCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_view_make(size : Int) -> DbindexvectorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorView::len(self : DbindexvectorView) -> Int { self.size }

pub fn DbindexvectorView::get(self : DbindexvectorView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorView::set(self : DbindexvectorView, i : Int, v : Double) -> DbindexvectorView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorView::sum(self : DbindexvectorView) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorView::mean(self : DbindexvectorView) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorView::scale(self : DbindexvectorView, f : Double) -> DbindexvectorView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorView::add(self : DbindexvectorView, other : DbindexvectorView) -> DbindexvectorView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorView::copy(self : DbindexvectorView) -> DbindexvectorView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorView::fill(self : DbindexvectorView, v : Double) -> DbindexvectorView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorView::min(self : DbindexvectorView) -> Double { @_common.min(self.data) }

pub fn DbindexvectorView::max(self : DbindexvectorView) -> Double { @_common.max(self.data) }

pub fn DbindexvectorView::to_string(self : DbindexvectorView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_range_make(size : Int) -> DbindexvectorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorRange::len(self : DbindexvectorRange) -> Int { self.size }

pub fn DbindexvectorRange::get(self : DbindexvectorRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorRange::set(self : DbindexvectorRange, i : Int, v : Double) -> DbindexvectorRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorRange::sum(self : DbindexvectorRange) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorRange::mean(self : DbindexvectorRange) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorRange::scale(self : DbindexvectorRange, f : Double) -> DbindexvectorRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorRange::add(self : DbindexvectorRange, other : DbindexvectorRange) -> DbindexvectorRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorRange::copy(self : DbindexvectorRange) -> DbindexvectorRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorRange::fill(self : DbindexvectorRange, v : Double) -> DbindexvectorRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorRange::min(self : DbindexvectorRange) -> Double { @_common.min(self.data) }

pub fn DbindexvectorRange::max(self : DbindexvectorRange) -> Double { @_common.max(self.data) }

pub fn DbindexvectorRange::to_string(self : DbindexvectorRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexvectorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_slice_make(size : Int) -> DbindexvectorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexvectorSlice::len(self : DbindexvectorSlice) -> Int { self.size }

pub fn DbindexvectorSlice::get(self : DbindexvectorSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexvectorSlice::set(self : DbindexvectorSlice, i : Int, v : Double) -> DbindexvectorSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexvectorSlice::sum(self : DbindexvectorSlice) -> Double { @_common.sum(self.data) }

pub fn DbindexvectorSlice::mean(self : DbindexvectorSlice) -> Double { @_common.mean(self.data) }

pub fn DbindexvectorSlice::scale(self : DbindexvectorSlice, f : Double) -> DbindexvectorSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexvectorSlice::add(self : DbindexvectorSlice, other : DbindexvectorSlice) -> DbindexvectorSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexvectorSlice::copy(self : DbindexvectorSlice) -> DbindexvectorSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexvectorSlice::fill(self : DbindexvectorSlice, v : Double) -> DbindexvectorSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexvectorSlice::min(self : DbindexvectorSlice) -> Double { @_common.min(self.data) }

pub fn DbindexvectorSlice::max(self : DbindexvectorSlice) -> Double { @_common.max(self.data) }

pub fn DbindexvectorSlice::to_string(self : DbindexvectorSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

