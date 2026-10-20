///===
/// extcore/db_store_matrix

pub(all) struct DbstorematrixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_matrix_make_point(x : Double, y : Double) -> DbstorematrixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_matrix_make_point3(x : Double, y : Double, z : Double) -> DbstorematrixPoint {
  { x, y, z, label: 0 }
}

pub fn DbstorematrixPoint::x(self : DbstorematrixPoint) -> Double { self.x }

pub fn DbstorematrixPoint::y(self : DbstorematrixPoint) -> Double { self.y }

pub fn DbstorematrixPoint::z(self : DbstorematrixPoint) -> Double { self.z }

pub fn DbstorematrixPoint::label(self : DbstorematrixPoint) -> Int { self.label }

pub fn DbstorematrixPoint::dist(self : DbstorematrixPoint, other : DbstorematrixPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstorematrixPoint::add(self : DbstorematrixPoint, other : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstorematrixPoint::sub(self : DbstorematrixPoint, other : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstorematrixPoint::scale(self : DbstorematrixPoint, s : Double) -> DbstorematrixPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstorematrixPoint::dot(self : DbstorematrixPoint, other : DbstorematrixPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstorematrixPoint::cross(self : DbstorematrixPoint, other : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstorematrixPoint::norm(self : DbstorematrixPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstorematrixPoint::normalize(self : DbstorematrixPoint) -> DbstorematrixPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorematrixPoint::negate(self : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstorematrixPoint::mid(self : DbstorematrixPoint, other : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstorematrixPoint::lerp(self : DbstorematrixPoint, other : DbstorematrixPoint, t : Double) -> DbstorematrixPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstorematrixPoint::to_string(self : DbstorematrixPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstorematrixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_matrix_make_series(vals : Array[Double], name : String) -> DbstorematrixSeries {
  { vals, name, meta: 0 }
}

pub fn DbstorematrixSeries::len(self : DbstorematrixSeries) -> Int { self.vals.length() }

pub fn DbstorematrixSeries::sum(self : DbstorematrixSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstorematrixSeries::mean(self : DbstorematrixSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstorematrixSeries::min(self : DbstorematrixSeries) -> Double { @_common.min(self.vals) }

pub fn DbstorematrixSeries::max(self : DbstorematrixSeries) -> Double { @_common.max(self.vals) }

pub fn DbstorematrixSeries::range(self : DbstorematrixSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstorematrixSeries::variance(self : DbstorematrixSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstorematrixSeries::std(self : DbstorematrixSeries) -> Double { @_common.std(self.vals) }

pub fn DbstorematrixSeries::median(self : DbstorematrixSeries) -> Double { @_common.median(self.vals) }

pub fn DbstorematrixSeries::scale(self : DbstorematrixSeries, f : Double) -> DbstorematrixSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstorematrixSeries::add(self : DbstorematrixSeries, other : DbstorematrixSeries) -> DbstorematrixSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstorematrixSeries::sub(self : DbstorematrixSeries, other : DbstorematrixSeries) -> DbstorematrixSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstorematrixSeries::normalize(self : DbstorematrixSeries) -> DbstorematrixSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstorematrixSeries::cumsum(self : DbstorematrixSeries) -> DbstorematrixSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstorematrixSeries::to_string(self : DbstorematrixSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorematrixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_matrix_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorematrixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_matrix_matrix_identity(n : Int) -> DbstorematrixMatrix {
  let m = db_store_matrix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstorematrixMatrix::get(self : DbstorematrixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstorematrixMatrix::transpose(self : DbstorematrixMatrix) -> DbstorematrixMatrix {
  let result = db_store_matrix_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstorematrixMatrix::add(self : DbstorematrixMatrix, other : DbstorematrixMatrix) -> DbstorematrixMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstorematrixMatrix::scale(self : DbstorematrixMatrix, s : Double) -> DbstorematrixMatrix {
  let result = db_store_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstorematrixMatrix::multiply(self : DbstorematrixMatrix, other : DbstorematrixMatrix) -> DbstorematrixMatrix {
  if self.cols != other.rows { return db_store_matrix_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_matrix_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstorematrixMatrix::trace(self : DbstorematrixMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstorematrixMatrix::det(self : DbstorematrixMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstorematrixMatrix::norm(self : DbstorematrixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstorematrixMatrix::to_string(self : DbstorematrixMatrix) -> String {
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

pub(all) struct DbstorematrixVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_matrix_make_vector(comps : Array[Double]) -> DbstorematrixVector {
  { comps, dim: comps.length() }
}

pub fn db_store_matrix_vector_zero(dim : Int) -> DbstorematrixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstorematrixVector::add(self : DbstorematrixVector, other : DbstorematrixVector) -> DbstorematrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorematrixVector::sub(self : DbstorematrixVector, other : DbstorematrixVector) -> DbstorematrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorematrixVector::scale(self : DbstorematrixVector, s : Double) -> DbstorematrixVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstorematrixVector::dot(self : DbstorematrixVector, other : DbstorematrixVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstorematrixVector::norm(self : DbstorematrixVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstorematrixVector::normalize(self : DbstorematrixVector) -> DbstorematrixVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorematrixVector::dist(self : DbstorematrixVector, other : DbstorematrixVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstorematrixVector::to_string(self : DbstorematrixVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorematrixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_frame_make(size : Int) -> DbstorematrixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixFrame::len(self : DbstorematrixFrame) -> Int { self.size }

pub fn DbstorematrixFrame::get(self : DbstorematrixFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixFrame::set(self : DbstorematrixFrame, i : Int, v : Double) -> DbstorematrixFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixFrame::sum(self : DbstorematrixFrame) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixFrame::mean(self : DbstorematrixFrame) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixFrame::scale(self : DbstorematrixFrame, f : Double) -> DbstorematrixFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixFrame::add(self : DbstorematrixFrame, other : DbstorematrixFrame) -> DbstorematrixFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixFrame::copy(self : DbstorematrixFrame) -> DbstorematrixFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixFrame::fill(self : DbstorematrixFrame, v : Double) -> DbstorematrixFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixFrame::min(self : DbstorematrixFrame) -> Double { @_common.min(self.data) }

pub fn DbstorematrixFrame::max(self : DbstorematrixFrame) -> Double { @_common.max(self.data) }

pub fn DbstorematrixFrame::to_string(self : DbstorematrixFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_table_make(size : Int) -> DbstorematrixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixTable::len(self : DbstorematrixTable) -> Int { self.size }

pub fn DbstorematrixTable::get(self : DbstorematrixTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixTable::set(self : DbstorematrixTable, i : Int, v : Double) -> DbstorematrixTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixTable::sum(self : DbstorematrixTable) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixTable::mean(self : DbstorematrixTable) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixTable::scale(self : DbstorematrixTable, f : Double) -> DbstorematrixTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixTable::add(self : DbstorematrixTable, other : DbstorematrixTable) -> DbstorematrixTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixTable::copy(self : DbstorematrixTable) -> DbstorematrixTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixTable::fill(self : DbstorematrixTable, v : Double) -> DbstorematrixTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixTable::min(self : DbstorematrixTable) -> Double { @_common.min(self.data) }

pub fn DbstorematrixTable::max(self : DbstorematrixTable) -> Double { @_common.max(self.data) }

pub fn DbstorematrixTable::to_string(self : DbstorematrixTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_graphn_make(size : Int) -> DbstorematrixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixGraphN::len(self : DbstorematrixGraphN) -> Int { self.size }

pub fn DbstorematrixGraphN::get(self : DbstorematrixGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixGraphN::set(self : DbstorematrixGraphN, i : Int, v : Double) -> DbstorematrixGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixGraphN::sum(self : DbstorematrixGraphN) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixGraphN::mean(self : DbstorematrixGraphN) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixGraphN::scale(self : DbstorematrixGraphN, f : Double) -> DbstorematrixGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixGraphN::add(self : DbstorematrixGraphN, other : DbstorematrixGraphN) -> DbstorematrixGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixGraphN::copy(self : DbstorematrixGraphN) -> DbstorematrixGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixGraphN::fill(self : DbstorematrixGraphN, v : Double) -> DbstorematrixGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixGraphN::min(self : DbstorematrixGraphN) -> Double { @_common.min(self.data) }

pub fn DbstorematrixGraphN::max(self : DbstorematrixGraphN) -> Double { @_common.max(self.data) }

pub fn DbstorematrixGraphN::to_string(self : DbstorematrixGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_node_make(size : Int) -> DbstorematrixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixNode::len(self : DbstorematrixNode) -> Int { self.size }

pub fn DbstorematrixNode::get(self : DbstorematrixNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixNode::set(self : DbstorematrixNode, i : Int, v : Double) -> DbstorematrixNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixNode::sum(self : DbstorematrixNode) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixNode::mean(self : DbstorematrixNode) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixNode::scale(self : DbstorematrixNode, f : Double) -> DbstorematrixNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixNode::add(self : DbstorematrixNode, other : DbstorematrixNode) -> DbstorematrixNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixNode::copy(self : DbstorematrixNode) -> DbstorematrixNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixNode::fill(self : DbstorematrixNode, v : Double) -> DbstorematrixNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixNode::min(self : DbstorematrixNode) -> Double { @_common.min(self.data) }

pub fn DbstorematrixNode::max(self : DbstorematrixNode) -> Double { @_common.max(self.data) }

pub fn DbstorematrixNode::to_string(self : DbstorematrixNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_edge_make(size : Int) -> DbstorematrixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixEdge::len(self : DbstorematrixEdge) -> Int { self.size }

pub fn DbstorematrixEdge::get(self : DbstorematrixEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixEdge::set(self : DbstorematrixEdge, i : Int, v : Double) -> DbstorematrixEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixEdge::sum(self : DbstorematrixEdge) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixEdge::mean(self : DbstorematrixEdge) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixEdge::scale(self : DbstorematrixEdge, f : Double) -> DbstorematrixEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixEdge::add(self : DbstorematrixEdge, other : DbstorematrixEdge) -> DbstorematrixEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixEdge::copy(self : DbstorematrixEdge) -> DbstorematrixEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixEdge::fill(self : DbstorematrixEdge, v : Double) -> DbstorematrixEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixEdge::min(self : DbstorematrixEdge) -> Double { @_common.min(self.data) }

pub fn DbstorematrixEdge::max(self : DbstorematrixEdge) -> Double { @_common.max(self.data) }

pub fn DbstorematrixEdge::to_string(self : DbstorematrixEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_path_make(size : Int) -> DbstorematrixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixPath::len(self : DbstorematrixPath) -> Int { self.size }

pub fn DbstorematrixPath::get(self : DbstorematrixPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixPath::set(self : DbstorematrixPath, i : Int, v : Double) -> DbstorematrixPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixPath::sum(self : DbstorematrixPath) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixPath::mean(self : DbstorematrixPath) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixPath::scale(self : DbstorematrixPath, f : Double) -> DbstorematrixPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixPath::add(self : DbstorematrixPath, other : DbstorematrixPath) -> DbstorematrixPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixPath::copy(self : DbstorematrixPath) -> DbstorematrixPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixPath::fill(self : DbstorematrixPath, v : Double) -> DbstorematrixPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixPath::min(self : DbstorematrixPath) -> Double { @_common.min(self.data) }

pub fn DbstorematrixPath::max(self : DbstorematrixPath) -> Double { @_common.max(self.data) }

pub fn DbstorematrixPath::to_string(self : DbstorematrixPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_cluster_make(size : Int) -> DbstorematrixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixCluster::len(self : DbstorematrixCluster) -> Int { self.size }

pub fn DbstorematrixCluster::get(self : DbstorematrixCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixCluster::set(self : DbstorematrixCluster, i : Int, v : Double) -> DbstorematrixCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixCluster::sum(self : DbstorematrixCluster) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixCluster::mean(self : DbstorematrixCluster) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixCluster::scale(self : DbstorematrixCluster, f : Double) -> DbstorematrixCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixCluster::add(self : DbstorematrixCluster, other : DbstorematrixCluster) -> DbstorematrixCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixCluster::copy(self : DbstorematrixCluster) -> DbstorematrixCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixCluster::fill(self : DbstorematrixCluster, v : Double) -> DbstorematrixCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixCluster::min(self : DbstorematrixCluster) -> Double { @_common.min(self.data) }

pub fn DbstorematrixCluster::max(self : DbstorematrixCluster) -> Double { @_common.max(self.data) }

pub fn DbstorematrixCluster::to_string(self : DbstorematrixCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_model_make(size : Int) -> DbstorematrixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixModel::len(self : DbstorematrixModel) -> Int { self.size }

pub fn DbstorematrixModel::get(self : DbstorematrixModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixModel::set(self : DbstorematrixModel, i : Int, v : Double) -> DbstorematrixModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixModel::sum(self : DbstorematrixModel) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixModel::mean(self : DbstorematrixModel) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixModel::scale(self : DbstorematrixModel, f : Double) -> DbstorematrixModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixModel::add(self : DbstorematrixModel, other : DbstorematrixModel) -> DbstorematrixModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixModel::copy(self : DbstorematrixModel) -> DbstorematrixModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixModel::fill(self : DbstorematrixModel, v : Double) -> DbstorematrixModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixModel::min(self : DbstorematrixModel) -> Double { @_common.min(self.data) }

pub fn DbstorematrixModel::max(self : DbstorematrixModel) -> Double { @_common.max(self.data) }

pub fn DbstorematrixModel::to_string(self : DbstorematrixModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_layer_make(size : Int) -> DbstorematrixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixLayer::len(self : DbstorematrixLayer) -> Int { self.size }

pub fn DbstorematrixLayer::get(self : DbstorematrixLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixLayer::set(self : DbstorematrixLayer, i : Int, v : Double) -> DbstorematrixLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixLayer::sum(self : DbstorematrixLayer) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixLayer::mean(self : DbstorematrixLayer) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixLayer::scale(self : DbstorematrixLayer, f : Double) -> DbstorematrixLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixLayer::add(self : DbstorematrixLayer, other : DbstorematrixLayer) -> DbstorematrixLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixLayer::copy(self : DbstorematrixLayer) -> DbstorematrixLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixLayer::fill(self : DbstorematrixLayer, v : Double) -> DbstorematrixLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixLayer::min(self : DbstorematrixLayer) -> Double { @_common.min(self.data) }

pub fn DbstorematrixLayer::max(self : DbstorematrixLayer) -> Double { @_common.max(self.data) }

pub fn DbstorematrixLayer::to_string(self : DbstorematrixLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_buffer_make(size : Int) -> DbstorematrixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixBuffer::len(self : DbstorematrixBuffer) -> Int { self.size }

pub fn DbstorematrixBuffer::get(self : DbstorematrixBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixBuffer::set(self : DbstorematrixBuffer, i : Int, v : Double) -> DbstorematrixBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixBuffer::sum(self : DbstorematrixBuffer) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixBuffer::mean(self : DbstorematrixBuffer) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixBuffer::scale(self : DbstorematrixBuffer, f : Double) -> DbstorematrixBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixBuffer::add(self : DbstorematrixBuffer, other : DbstorematrixBuffer) -> DbstorematrixBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixBuffer::copy(self : DbstorematrixBuffer) -> DbstorematrixBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixBuffer::fill(self : DbstorematrixBuffer, v : Double) -> DbstorematrixBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixBuffer::min(self : DbstorematrixBuffer) -> Double { @_common.min(self.data) }

pub fn DbstorematrixBuffer::max(self : DbstorematrixBuffer) -> Double { @_common.max(self.data) }

pub fn DbstorematrixBuffer::to_string(self : DbstorematrixBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_cursor_make(size : Int) -> DbstorematrixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixCursor::len(self : DbstorematrixCursor) -> Int { self.size }

pub fn DbstorematrixCursor::get(self : DbstorematrixCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixCursor::set(self : DbstorematrixCursor, i : Int, v : Double) -> DbstorematrixCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixCursor::sum(self : DbstorematrixCursor) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixCursor::mean(self : DbstorematrixCursor) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixCursor::scale(self : DbstorematrixCursor, f : Double) -> DbstorematrixCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixCursor::add(self : DbstorematrixCursor, other : DbstorematrixCursor) -> DbstorematrixCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixCursor::copy(self : DbstorematrixCursor) -> DbstorematrixCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixCursor::fill(self : DbstorematrixCursor, v : Double) -> DbstorematrixCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixCursor::min(self : DbstorematrixCursor) -> Double { @_common.min(self.data) }

pub fn DbstorematrixCursor::max(self : DbstorematrixCursor) -> Double { @_common.max(self.data) }

pub fn DbstorematrixCursor::to_string(self : DbstorematrixCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_view_make(size : Int) -> DbstorematrixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixView::len(self : DbstorematrixView) -> Int { self.size }

pub fn DbstorematrixView::get(self : DbstorematrixView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixView::set(self : DbstorematrixView, i : Int, v : Double) -> DbstorematrixView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixView::sum(self : DbstorematrixView) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixView::mean(self : DbstorematrixView) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixView::scale(self : DbstorematrixView, f : Double) -> DbstorematrixView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixView::add(self : DbstorematrixView, other : DbstorematrixView) -> DbstorematrixView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixView::copy(self : DbstorematrixView) -> DbstorematrixView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixView::fill(self : DbstorematrixView, v : Double) -> DbstorematrixView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixView::min(self : DbstorematrixView) -> Double { @_common.min(self.data) }

pub fn DbstorematrixView::max(self : DbstorematrixView) -> Double { @_common.max(self.data) }

pub fn DbstorematrixView::to_string(self : DbstorematrixView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_range_make(size : Int) -> DbstorematrixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixRange::len(self : DbstorematrixRange) -> Int { self.size }

pub fn DbstorematrixRange::get(self : DbstorematrixRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixRange::set(self : DbstorematrixRange, i : Int, v : Double) -> DbstorematrixRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixRange::sum(self : DbstorematrixRange) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixRange::mean(self : DbstorematrixRange) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixRange::scale(self : DbstorematrixRange, f : Double) -> DbstorematrixRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixRange::add(self : DbstorematrixRange, other : DbstorematrixRange) -> DbstorematrixRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixRange::copy(self : DbstorematrixRange) -> DbstorematrixRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixRange::fill(self : DbstorematrixRange, v : Double) -> DbstorematrixRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixRange::min(self : DbstorematrixRange) -> Double { @_common.min(self.data) }

pub fn DbstorematrixRange::max(self : DbstorematrixRange) -> Double { @_common.max(self.data) }

pub fn DbstorematrixRange::to_string(self : DbstorematrixRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorematrixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_slice_make(size : Int) -> DbstorematrixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorematrixSlice::len(self : DbstorematrixSlice) -> Int { self.size }

pub fn DbstorematrixSlice::get(self : DbstorematrixSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorematrixSlice::set(self : DbstorematrixSlice, i : Int, v : Double) -> DbstorematrixSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorematrixSlice::sum(self : DbstorematrixSlice) -> Double { @_common.sum(self.data) }

pub fn DbstorematrixSlice::mean(self : DbstorematrixSlice) -> Double { @_common.mean(self.data) }

pub fn DbstorematrixSlice::scale(self : DbstorematrixSlice, f : Double) -> DbstorematrixSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorematrixSlice::add(self : DbstorematrixSlice, other : DbstorematrixSlice) -> DbstorematrixSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorematrixSlice::copy(self : DbstorematrixSlice) -> DbstorematrixSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorematrixSlice::fill(self : DbstorematrixSlice, v : Double) -> DbstorematrixSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorematrixSlice::min(self : DbstorematrixSlice) -> Double { @_common.min(self.data) }

pub fn DbstorematrixSlice::max(self : DbstorematrixSlice) -> Double { @_common.max(self.data) }

pub fn DbstorematrixSlice::to_string(self : DbstorematrixSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

