///===
/// extcore/db_store_graph

pub(all) struct DbstoregraphPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_graph_make_point(x : Double, y : Double) -> DbstoregraphPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_graph_make_point3(x : Double, y : Double, z : Double) -> DbstoregraphPoint {
  { x, y, z, label: 0 }
}

pub fn DbstoregraphPoint::x(self : DbstoregraphPoint) -> Double { self.x }

pub fn DbstoregraphPoint::y(self : DbstoregraphPoint) -> Double { self.y }

pub fn DbstoregraphPoint::z(self : DbstoregraphPoint) -> Double { self.z }

pub fn DbstoregraphPoint::label(self : DbstoregraphPoint) -> Int { self.label }

pub fn DbstoregraphPoint::dist(self : DbstoregraphPoint, other : DbstoregraphPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstoregraphPoint::add(self : DbstoregraphPoint, other : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstoregraphPoint::sub(self : DbstoregraphPoint, other : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstoregraphPoint::scale(self : DbstoregraphPoint, s : Double) -> DbstoregraphPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstoregraphPoint::dot(self : DbstoregraphPoint, other : DbstoregraphPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstoregraphPoint::cross(self : DbstoregraphPoint, other : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstoregraphPoint::norm(self : DbstoregraphPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstoregraphPoint::normalize(self : DbstoregraphPoint) -> DbstoregraphPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoregraphPoint::negate(self : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstoregraphPoint::mid(self : DbstoregraphPoint, other : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstoregraphPoint::lerp(self : DbstoregraphPoint, other : DbstoregraphPoint, t : Double) -> DbstoregraphPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstoregraphPoint::to_string(self : DbstoregraphPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstoregraphSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_graph_make_series(vals : Array[Double], name : String) -> DbstoregraphSeries {
  { vals, name, meta: 0 }
}

pub fn DbstoregraphSeries::len(self : DbstoregraphSeries) -> Int { self.vals.length() }

pub fn DbstoregraphSeries::sum(self : DbstoregraphSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstoregraphSeries::mean(self : DbstoregraphSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstoregraphSeries::min(self : DbstoregraphSeries) -> Double { @_common.min(self.vals) }

pub fn DbstoregraphSeries::max(self : DbstoregraphSeries) -> Double { @_common.max(self.vals) }

pub fn DbstoregraphSeries::range(self : DbstoregraphSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstoregraphSeries::variance(self : DbstoregraphSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstoregraphSeries::std(self : DbstoregraphSeries) -> Double { @_common.std(self.vals) }

pub fn DbstoregraphSeries::median(self : DbstoregraphSeries) -> Double { @_common.median(self.vals) }

pub fn DbstoregraphSeries::scale(self : DbstoregraphSeries, f : Double) -> DbstoregraphSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstoregraphSeries::add(self : DbstoregraphSeries, other : DbstoregraphSeries) -> DbstoregraphSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstoregraphSeries::sub(self : DbstoregraphSeries, other : DbstoregraphSeries) -> DbstoregraphSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstoregraphSeries::normalize(self : DbstoregraphSeries) -> DbstoregraphSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstoregraphSeries::cumsum(self : DbstoregraphSeries) -> DbstoregraphSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstoregraphSeries::to_string(self : DbstoregraphSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoregraphMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_graph_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoregraphMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_graph_matrix_identity(n : Int) -> DbstoregraphMatrix {
  let m = db_store_graph_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstoregraphMatrix::get(self : DbstoregraphMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstoregraphMatrix::transpose(self : DbstoregraphMatrix) -> DbstoregraphMatrix {
  let result = db_store_graph_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstoregraphMatrix::add(self : DbstoregraphMatrix, other : DbstoregraphMatrix) -> DbstoregraphMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_graph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstoregraphMatrix::scale(self : DbstoregraphMatrix, s : Double) -> DbstoregraphMatrix {
  let result = db_store_graph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstoregraphMatrix::multiply(self : DbstoregraphMatrix, other : DbstoregraphMatrix) -> DbstoregraphMatrix {
  if self.cols != other.rows { return db_store_graph_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_graph_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DbstoregraphMatrix::trace(self : DbstoregraphMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstoregraphMatrix::det(self : DbstoregraphMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstoregraphMatrix::norm(self : DbstoregraphMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstoregraphMatrix::to_string(self : DbstoregraphMatrix) -> String {
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

pub(all) struct DbstoregraphVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_graph_make_vector(comps : Array[Double]) -> DbstoregraphVector {
  { comps, dim: comps.length() }
}

pub fn db_store_graph_vector_zero(dim : Int) -> DbstoregraphVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstoregraphVector::add(self : DbstoregraphVector, other : DbstoregraphVector) -> DbstoregraphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoregraphVector::sub(self : DbstoregraphVector, other : DbstoregraphVector) -> DbstoregraphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoregraphVector::scale(self : DbstoregraphVector, s : Double) -> DbstoregraphVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstoregraphVector::dot(self : DbstoregraphVector, other : DbstoregraphVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstoregraphVector::norm(self : DbstoregraphVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstoregraphVector::normalize(self : DbstoregraphVector) -> DbstoregraphVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoregraphVector::dist(self : DbstoregraphVector, other : DbstoregraphVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstoregraphVector::to_string(self : DbstoregraphVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoregraphFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_frame_make(size : Int) -> DbstoregraphFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphFrame::len(self : DbstoregraphFrame) -> Int { self.size }

pub fn DbstoregraphFrame::get(self : DbstoregraphFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphFrame::set(self : DbstoregraphFrame, i : Int, v : Double) -> DbstoregraphFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphFrame::sum(self : DbstoregraphFrame) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphFrame::mean(self : DbstoregraphFrame) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphFrame::scale(self : DbstoregraphFrame, f : Double) -> DbstoregraphFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphFrame::add(self : DbstoregraphFrame, other : DbstoregraphFrame) -> DbstoregraphFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphFrame::copy(self : DbstoregraphFrame) -> DbstoregraphFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphFrame::fill(self : DbstoregraphFrame, v : Double) -> DbstoregraphFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphFrame::min(self : DbstoregraphFrame) -> Double { @_common.min(self.data) }

pub fn DbstoregraphFrame::max(self : DbstoregraphFrame) -> Double { @_common.max(self.data) }

pub fn DbstoregraphFrame::to_string(self : DbstoregraphFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_table_make(size : Int) -> DbstoregraphTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphTable::len(self : DbstoregraphTable) -> Int { self.size }

pub fn DbstoregraphTable::get(self : DbstoregraphTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphTable::set(self : DbstoregraphTable, i : Int, v : Double) -> DbstoregraphTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphTable::sum(self : DbstoregraphTable) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphTable::mean(self : DbstoregraphTable) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphTable::scale(self : DbstoregraphTable, f : Double) -> DbstoregraphTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphTable::add(self : DbstoregraphTable, other : DbstoregraphTable) -> DbstoregraphTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphTable::copy(self : DbstoregraphTable) -> DbstoregraphTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphTable::fill(self : DbstoregraphTable, v : Double) -> DbstoregraphTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphTable::min(self : DbstoregraphTable) -> Double { @_common.min(self.data) }

pub fn DbstoregraphTable::max(self : DbstoregraphTable) -> Double { @_common.max(self.data) }

pub fn DbstoregraphTable::to_string(self : DbstoregraphTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_graphn_make(size : Int) -> DbstoregraphGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphGraphN::len(self : DbstoregraphGraphN) -> Int { self.size }

pub fn DbstoregraphGraphN::get(self : DbstoregraphGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphGraphN::set(self : DbstoregraphGraphN, i : Int, v : Double) -> DbstoregraphGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphGraphN::sum(self : DbstoregraphGraphN) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphGraphN::mean(self : DbstoregraphGraphN) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphGraphN::scale(self : DbstoregraphGraphN, f : Double) -> DbstoregraphGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphGraphN::add(self : DbstoregraphGraphN, other : DbstoregraphGraphN) -> DbstoregraphGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphGraphN::copy(self : DbstoregraphGraphN) -> DbstoregraphGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphGraphN::fill(self : DbstoregraphGraphN, v : Double) -> DbstoregraphGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphGraphN::min(self : DbstoregraphGraphN) -> Double { @_common.min(self.data) }

pub fn DbstoregraphGraphN::max(self : DbstoregraphGraphN) -> Double { @_common.max(self.data) }

pub fn DbstoregraphGraphN::to_string(self : DbstoregraphGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_node_make(size : Int) -> DbstoregraphNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphNode::len(self : DbstoregraphNode) -> Int { self.size }

pub fn DbstoregraphNode::get(self : DbstoregraphNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphNode::set(self : DbstoregraphNode, i : Int, v : Double) -> DbstoregraphNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphNode::sum(self : DbstoregraphNode) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphNode::mean(self : DbstoregraphNode) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphNode::scale(self : DbstoregraphNode, f : Double) -> DbstoregraphNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphNode::add(self : DbstoregraphNode, other : DbstoregraphNode) -> DbstoregraphNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphNode::copy(self : DbstoregraphNode) -> DbstoregraphNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphNode::fill(self : DbstoregraphNode, v : Double) -> DbstoregraphNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphNode::min(self : DbstoregraphNode) -> Double { @_common.min(self.data) }

pub fn DbstoregraphNode::max(self : DbstoregraphNode) -> Double { @_common.max(self.data) }

pub fn DbstoregraphNode::to_string(self : DbstoregraphNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_edge_make(size : Int) -> DbstoregraphEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphEdge::len(self : DbstoregraphEdge) -> Int { self.size }

pub fn DbstoregraphEdge::get(self : DbstoregraphEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphEdge::set(self : DbstoregraphEdge, i : Int, v : Double) -> DbstoregraphEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphEdge::sum(self : DbstoregraphEdge) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphEdge::mean(self : DbstoregraphEdge) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphEdge::scale(self : DbstoregraphEdge, f : Double) -> DbstoregraphEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphEdge::add(self : DbstoregraphEdge, other : DbstoregraphEdge) -> DbstoregraphEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphEdge::copy(self : DbstoregraphEdge) -> DbstoregraphEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphEdge::fill(self : DbstoregraphEdge, v : Double) -> DbstoregraphEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphEdge::min(self : DbstoregraphEdge) -> Double { @_common.min(self.data) }

pub fn DbstoregraphEdge::max(self : DbstoregraphEdge) -> Double { @_common.max(self.data) }

pub fn DbstoregraphEdge::to_string(self : DbstoregraphEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_path_make(size : Int) -> DbstoregraphPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphPath::len(self : DbstoregraphPath) -> Int { self.size }

pub fn DbstoregraphPath::get(self : DbstoregraphPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphPath::set(self : DbstoregraphPath, i : Int, v : Double) -> DbstoregraphPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphPath::sum(self : DbstoregraphPath) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphPath::mean(self : DbstoregraphPath) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphPath::scale(self : DbstoregraphPath, f : Double) -> DbstoregraphPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphPath::add(self : DbstoregraphPath, other : DbstoregraphPath) -> DbstoregraphPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphPath::copy(self : DbstoregraphPath) -> DbstoregraphPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphPath::fill(self : DbstoregraphPath, v : Double) -> DbstoregraphPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphPath::min(self : DbstoregraphPath) -> Double { @_common.min(self.data) }

pub fn DbstoregraphPath::max(self : DbstoregraphPath) -> Double { @_common.max(self.data) }

pub fn DbstoregraphPath::to_string(self : DbstoregraphPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_cluster_make(size : Int) -> DbstoregraphCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphCluster::len(self : DbstoregraphCluster) -> Int { self.size }

pub fn DbstoregraphCluster::get(self : DbstoregraphCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphCluster::set(self : DbstoregraphCluster, i : Int, v : Double) -> DbstoregraphCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphCluster::sum(self : DbstoregraphCluster) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphCluster::mean(self : DbstoregraphCluster) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphCluster::scale(self : DbstoregraphCluster, f : Double) -> DbstoregraphCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphCluster::add(self : DbstoregraphCluster, other : DbstoregraphCluster) -> DbstoregraphCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphCluster::copy(self : DbstoregraphCluster) -> DbstoregraphCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphCluster::fill(self : DbstoregraphCluster, v : Double) -> DbstoregraphCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphCluster::min(self : DbstoregraphCluster) -> Double { @_common.min(self.data) }

pub fn DbstoregraphCluster::max(self : DbstoregraphCluster) -> Double { @_common.max(self.data) }

pub fn DbstoregraphCluster::to_string(self : DbstoregraphCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_model_make(size : Int) -> DbstoregraphModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphModel::len(self : DbstoregraphModel) -> Int { self.size }

pub fn DbstoregraphModel::get(self : DbstoregraphModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphModel::set(self : DbstoregraphModel, i : Int, v : Double) -> DbstoregraphModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphModel::sum(self : DbstoregraphModel) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphModel::mean(self : DbstoregraphModel) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphModel::scale(self : DbstoregraphModel, f : Double) -> DbstoregraphModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphModel::add(self : DbstoregraphModel, other : DbstoregraphModel) -> DbstoregraphModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphModel::copy(self : DbstoregraphModel) -> DbstoregraphModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphModel::fill(self : DbstoregraphModel, v : Double) -> DbstoregraphModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphModel::min(self : DbstoregraphModel) -> Double { @_common.min(self.data) }

pub fn DbstoregraphModel::max(self : DbstoregraphModel) -> Double { @_common.max(self.data) }

pub fn DbstoregraphModel::to_string(self : DbstoregraphModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_layer_make(size : Int) -> DbstoregraphLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphLayer::len(self : DbstoregraphLayer) -> Int { self.size }

pub fn DbstoregraphLayer::get(self : DbstoregraphLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphLayer::set(self : DbstoregraphLayer, i : Int, v : Double) -> DbstoregraphLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphLayer::sum(self : DbstoregraphLayer) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphLayer::mean(self : DbstoregraphLayer) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphLayer::scale(self : DbstoregraphLayer, f : Double) -> DbstoregraphLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphLayer::add(self : DbstoregraphLayer, other : DbstoregraphLayer) -> DbstoregraphLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphLayer::copy(self : DbstoregraphLayer) -> DbstoregraphLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphLayer::fill(self : DbstoregraphLayer, v : Double) -> DbstoregraphLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphLayer::min(self : DbstoregraphLayer) -> Double { @_common.min(self.data) }

pub fn DbstoregraphLayer::max(self : DbstoregraphLayer) -> Double { @_common.max(self.data) }

pub fn DbstoregraphLayer::to_string(self : DbstoregraphLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_buffer_make(size : Int) -> DbstoregraphBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphBuffer::len(self : DbstoregraphBuffer) -> Int { self.size }

pub fn DbstoregraphBuffer::get(self : DbstoregraphBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphBuffer::set(self : DbstoregraphBuffer, i : Int, v : Double) -> DbstoregraphBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphBuffer::sum(self : DbstoregraphBuffer) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphBuffer::mean(self : DbstoregraphBuffer) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphBuffer::scale(self : DbstoregraphBuffer, f : Double) -> DbstoregraphBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphBuffer::add(self : DbstoregraphBuffer, other : DbstoregraphBuffer) -> DbstoregraphBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphBuffer::copy(self : DbstoregraphBuffer) -> DbstoregraphBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphBuffer::fill(self : DbstoregraphBuffer, v : Double) -> DbstoregraphBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphBuffer::min(self : DbstoregraphBuffer) -> Double { @_common.min(self.data) }

pub fn DbstoregraphBuffer::max(self : DbstoregraphBuffer) -> Double { @_common.max(self.data) }

pub fn DbstoregraphBuffer::to_string(self : DbstoregraphBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_cursor_make(size : Int) -> DbstoregraphCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphCursor::len(self : DbstoregraphCursor) -> Int { self.size }

pub fn DbstoregraphCursor::get(self : DbstoregraphCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphCursor::set(self : DbstoregraphCursor, i : Int, v : Double) -> DbstoregraphCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphCursor::sum(self : DbstoregraphCursor) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphCursor::mean(self : DbstoregraphCursor) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphCursor::scale(self : DbstoregraphCursor, f : Double) -> DbstoregraphCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphCursor::add(self : DbstoregraphCursor, other : DbstoregraphCursor) -> DbstoregraphCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphCursor::copy(self : DbstoregraphCursor) -> DbstoregraphCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphCursor::fill(self : DbstoregraphCursor, v : Double) -> DbstoregraphCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphCursor::min(self : DbstoregraphCursor) -> Double { @_common.min(self.data) }

pub fn DbstoregraphCursor::max(self : DbstoregraphCursor) -> Double { @_common.max(self.data) }

pub fn DbstoregraphCursor::to_string(self : DbstoregraphCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_view_make(size : Int) -> DbstoregraphView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphView::len(self : DbstoregraphView) -> Int { self.size }

pub fn DbstoregraphView::get(self : DbstoregraphView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphView::set(self : DbstoregraphView, i : Int, v : Double) -> DbstoregraphView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphView::sum(self : DbstoregraphView) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphView::mean(self : DbstoregraphView) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphView::scale(self : DbstoregraphView, f : Double) -> DbstoregraphView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphView::add(self : DbstoregraphView, other : DbstoregraphView) -> DbstoregraphView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphView::copy(self : DbstoregraphView) -> DbstoregraphView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphView::fill(self : DbstoregraphView, v : Double) -> DbstoregraphView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphView::min(self : DbstoregraphView) -> Double { @_common.min(self.data) }

pub fn DbstoregraphView::max(self : DbstoregraphView) -> Double { @_common.max(self.data) }

pub fn DbstoregraphView::to_string(self : DbstoregraphView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_range_make(size : Int) -> DbstoregraphRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphRange::len(self : DbstoregraphRange) -> Int { self.size }

pub fn DbstoregraphRange::get(self : DbstoregraphRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphRange::set(self : DbstoregraphRange, i : Int, v : Double) -> DbstoregraphRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphRange::sum(self : DbstoregraphRange) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphRange::mean(self : DbstoregraphRange) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphRange::scale(self : DbstoregraphRange, f : Double) -> DbstoregraphRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphRange::add(self : DbstoregraphRange, other : DbstoregraphRange) -> DbstoregraphRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphRange::copy(self : DbstoregraphRange) -> DbstoregraphRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphRange::fill(self : DbstoregraphRange, v : Double) -> DbstoregraphRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphRange::min(self : DbstoregraphRange) -> Double { @_common.min(self.data) }

pub fn DbstoregraphRange::max(self : DbstoregraphRange) -> Double { @_common.max(self.data) }

pub fn DbstoregraphRange::to_string(self : DbstoregraphRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoregraphSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_slice_make(size : Int) -> DbstoregraphSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoregraphSlice::len(self : DbstoregraphSlice) -> Int { self.size }

pub fn DbstoregraphSlice::get(self : DbstoregraphSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoregraphSlice::set(self : DbstoregraphSlice, i : Int, v : Double) -> DbstoregraphSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoregraphSlice::sum(self : DbstoregraphSlice) -> Double { @_common.sum(self.data) }

pub fn DbstoregraphSlice::mean(self : DbstoregraphSlice) -> Double { @_common.mean(self.data) }

pub fn DbstoregraphSlice::scale(self : DbstoregraphSlice, f : Double) -> DbstoregraphSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoregraphSlice::add(self : DbstoregraphSlice, other : DbstoregraphSlice) -> DbstoregraphSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoregraphSlice::copy(self : DbstoregraphSlice) -> DbstoregraphSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoregraphSlice::fill(self : DbstoregraphSlice, v : Double) -> DbstoregraphSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoregraphSlice::min(self : DbstoregraphSlice) -> Double { @_common.min(self.data) }

pub fn DbstoregraphSlice::max(self : DbstoregraphSlice) -> Double { @_common.max(self.data) }

pub fn DbstoregraphSlice::to_string(self : DbstoregraphSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

