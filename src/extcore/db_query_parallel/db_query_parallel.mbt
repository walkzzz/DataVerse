///===
/// extcore/db_query_parallel

pub(all) struct DbqueryparallelPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_parallel_make_point(x : Double, y : Double) -> DbqueryparallelPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_parallel_make_point3(x : Double, y : Double, z : Double) -> DbqueryparallelPoint {
  { x, y, z, label: 0 }
}

pub fn DbqueryparallelPoint::x(self : DbqueryparallelPoint) -> Double { self.x }

pub fn DbqueryparallelPoint::y(self : DbqueryparallelPoint) -> Double { self.y }

pub fn DbqueryparallelPoint::z(self : DbqueryparallelPoint) -> Double { self.z }

pub fn DbqueryparallelPoint::label(self : DbqueryparallelPoint) -> Int { self.label }

pub fn DbqueryparallelPoint::dist(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbqueryparallelPoint::add(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbqueryparallelPoint::sub(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbqueryparallelPoint::scale(self : DbqueryparallelPoint, s : Double) -> DbqueryparallelPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbqueryparallelPoint::dot(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbqueryparallelPoint::cross(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbqueryparallelPoint::norm(self : DbqueryparallelPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbqueryparallelPoint::normalize(self : DbqueryparallelPoint) -> DbqueryparallelPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryparallelPoint::negate(self : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbqueryparallelPoint::mid(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbqueryparallelPoint::lerp(self : DbqueryparallelPoint, other : DbqueryparallelPoint, t : Double) -> DbqueryparallelPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbqueryparallelPoint::to_string(self : DbqueryparallelPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbqueryparallelSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_parallel_make_series(vals : Array[Double], name : String) -> DbqueryparallelSeries {
  { vals, name, meta: 0 }
}

pub fn DbqueryparallelSeries::len(self : DbqueryparallelSeries) -> Int { self.vals.length() }

pub fn DbqueryparallelSeries::sum(self : DbqueryparallelSeries) -> Double { @_common.sum(self.vals) }

pub fn DbqueryparallelSeries::mean(self : DbqueryparallelSeries) -> Double { @_common.mean(self.vals) }

pub fn DbqueryparallelSeries::min(self : DbqueryparallelSeries) -> Double { @_common.min(self.vals) }

pub fn DbqueryparallelSeries::max(self : DbqueryparallelSeries) -> Double { @_common.max(self.vals) }

pub fn DbqueryparallelSeries::range(self : DbqueryparallelSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbqueryparallelSeries::variance(self : DbqueryparallelSeries) -> Double { @_common.variance(self.vals) }

pub fn DbqueryparallelSeries::std(self : DbqueryparallelSeries) -> Double { @_common.std(self.vals) }

pub fn DbqueryparallelSeries::median(self : DbqueryparallelSeries) -> Double { @_common.median(self.vals) }

pub fn DbqueryparallelSeries::scale(self : DbqueryparallelSeries, f : Double) -> DbqueryparallelSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbqueryparallelSeries::add(self : DbqueryparallelSeries, other : DbqueryparallelSeries) -> DbqueryparallelSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbqueryparallelSeries::sub(self : DbqueryparallelSeries, other : DbqueryparallelSeries) -> DbqueryparallelSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbqueryparallelSeries::normalize(self : DbqueryparallelSeries) -> DbqueryparallelSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbqueryparallelSeries::cumsum(self : DbqueryparallelSeries) -> DbqueryparallelSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbqueryparallelSeries::to_string(self : DbqueryparallelSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryparallelMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_parallel_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryparallelMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_parallel_matrix_identity(n : Int) -> DbqueryparallelMatrix {
  let m = db_query_parallel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbqueryparallelMatrix::get(self : DbqueryparallelMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbqueryparallelMatrix::transpose(self : DbqueryparallelMatrix) -> DbqueryparallelMatrix {
  let result = db_query_parallel_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbqueryparallelMatrix::add(self : DbqueryparallelMatrix, other : DbqueryparallelMatrix) -> DbqueryparallelMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_parallel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbqueryparallelMatrix::scale(self : DbqueryparallelMatrix, s : Double) -> DbqueryparallelMatrix {
  let result = db_query_parallel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbqueryparallelMatrix::multiply(self : DbqueryparallelMatrix, other : DbqueryparallelMatrix) -> DbqueryparallelMatrix {
  if self.cols != other.rows { return db_query_parallel_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_parallel_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DbqueryparallelMatrix::trace(self : DbqueryparallelMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbqueryparallelMatrix::det(self : DbqueryparallelMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbqueryparallelMatrix::norm(self : DbqueryparallelMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbqueryparallelMatrix::to_string(self : DbqueryparallelMatrix) -> String {
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

pub(all) struct DbqueryparallelVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_parallel_make_vector(comps : Array[Double]) -> DbqueryparallelVector {
  { comps, dim: comps.length() }
}

pub fn db_query_parallel_vector_zero(dim : Int) -> DbqueryparallelVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbqueryparallelVector::add(self : DbqueryparallelVector, other : DbqueryparallelVector) -> DbqueryparallelVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryparallelVector::sub(self : DbqueryparallelVector, other : DbqueryparallelVector) -> DbqueryparallelVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryparallelVector::scale(self : DbqueryparallelVector, s : Double) -> DbqueryparallelVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbqueryparallelVector::dot(self : DbqueryparallelVector, other : DbqueryparallelVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbqueryparallelVector::norm(self : DbqueryparallelVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbqueryparallelVector::normalize(self : DbqueryparallelVector) -> DbqueryparallelVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryparallelVector::dist(self : DbqueryparallelVector, other : DbqueryparallelVector) -> Double {
  self.sub(other).norm()
}

pub fn DbqueryparallelVector::to_string(self : DbqueryparallelVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryparallelFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_frame_make(size : Int) -> DbqueryparallelFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelFrame::len(self : DbqueryparallelFrame) -> Int { self.size }

pub fn DbqueryparallelFrame::get(self : DbqueryparallelFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelFrame::set(self : DbqueryparallelFrame, i : Int, v : Double) -> DbqueryparallelFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelFrame::sum(self : DbqueryparallelFrame) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelFrame::mean(self : DbqueryparallelFrame) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelFrame::scale(self : DbqueryparallelFrame, f : Double) -> DbqueryparallelFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelFrame::add(self : DbqueryparallelFrame, other : DbqueryparallelFrame) -> DbqueryparallelFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelFrame::copy(self : DbqueryparallelFrame) -> DbqueryparallelFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelFrame::fill(self : DbqueryparallelFrame, v : Double) -> DbqueryparallelFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelFrame::min(self : DbqueryparallelFrame) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelFrame::max(self : DbqueryparallelFrame) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelFrame::to_string(self : DbqueryparallelFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_table_make(size : Int) -> DbqueryparallelTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelTable::len(self : DbqueryparallelTable) -> Int { self.size }

pub fn DbqueryparallelTable::get(self : DbqueryparallelTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelTable::set(self : DbqueryparallelTable, i : Int, v : Double) -> DbqueryparallelTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelTable::sum(self : DbqueryparallelTable) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelTable::mean(self : DbqueryparallelTable) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelTable::scale(self : DbqueryparallelTable, f : Double) -> DbqueryparallelTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelTable::add(self : DbqueryparallelTable, other : DbqueryparallelTable) -> DbqueryparallelTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelTable::copy(self : DbqueryparallelTable) -> DbqueryparallelTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelTable::fill(self : DbqueryparallelTable, v : Double) -> DbqueryparallelTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelTable::min(self : DbqueryparallelTable) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelTable::max(self : DbqueryparallelTable) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelTable::to_string(self : DbqueryparallelTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_graphn_make(size : Int) -> DbqueryparallelGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelGraphN::len(self : DbqueryparallelGraphN) -> Int { self.size }

pub fn DbqueryparallelGraphN::get(self : DbqueryparallelGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelGraphN::set(self : DbqueryparallelGraphN, i : Int, v : Double) -> DbqueryparallelGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelGraphN::sum(self : DbqueryparallelGraphN) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelGraphN::mean(self : DbqueryparallelGraphN) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelGraphN::scale(self : DbqueryparallelGraphN, f : Double) -> DbqueryparallelGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelGraphN::add(self : DbqueryparallelGraphN, other : DbqueryparallelGraphN) -> DbqueryparallelGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelGraphN::copy(self : DbqueryparallelGraphN) -> DbqueryparallelGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelGraphN::fill(self : DbqueryparallelGraphN, v : Double) -> DbqueryparallelGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelGraphN::min(self : DbqueryparallelGraphN) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelGraphN::max(self : DbqueryparallelGraphN) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelGraphN::to_string(self : DbqueryparallelGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_node_make(size : Int) -> DbqueryparallelNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelNode::len(self : DbqueryparallelNode) -> Int { self.size }

pub fn DbqueryparallelNode::get(self : DbqueryparallelNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelNode::set(self : DbqueryparallelNode, i : Int, v : Double) -> DbqueryparallelNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelNode::sum(self : DbqueryparallelNode) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelNode::mean(self : DbqueryparallelNode) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelNode::scale(self : DbqueryparallelNode, f : Double) -> DbqueryparallelNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelNode::add(self : DbqueryparallelNode, other : DbqueryparallelNode) -> DbqueryparallelNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelNode::copy(self : DbqueryparallelNode) -> DbqueryparallelNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelNode::fill(self : DbqueryparallelNode, v : Double) -> DbqueryparallelNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelNode::min(self : DbqueryparallelNode) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelNode::max(self : DbqueryparallelNode) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelNode::to_string(self : DbqueryparallelNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_edge_make(size : Int) -> DbqueryparallelEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelEdge::len(self : DbqueryparallelEdge) -> Int { self.size }

pub fn DbqueryparallelEdge::get(self : DbqueryparallelEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelEdge::set(self : DbqueryparallelEdge, i : Int, v : Double) -> DbqueryparallelEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelEdge::sum(self : DbqueryparallelEdge) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelEdge::mean(self : DbqueryparallelEdge) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelEdge::scale(self : DbqueryparallelEdge, f : Double) -> DbqueryparallelEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelEdge::add(self : DbqueryparallelEdge, other : DbqueryparallelEdge) -> DbqueryparallelEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelEdge::copy(self : DbqueryparallelEdge) -> DbqueryparallelEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelEdge::fill(self : DbqueryparallelEdge, v : Double) -> DbqueryparallelEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelEdge::min(self : DbqueryparallelEdge) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelEdge::max(self : DbqueryparallelEdge) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelEdge::to_string(self : DbqueryparallelEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_path_make(size : Int) -> DbqueryparallelPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelPath::len(self : DbqueryparallelPath) -> Int { self.size }

pub fn DbqueryparallelPath::get(self : DbqueryparallelPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelPath::set(self : DbqueryparallelPath, i : Int, v : Double) -> DbqueryparallelPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelPath::sum(self : DbqueryparallelPath) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelPath::mean(self : DbqueryparallelPath) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelPath::scale(self : DbqueryparallelPath, f : Double) -> DbqueryparallelPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelPath::add(self : DbqueryparallelPath, other : DbqueryparallelPath) -> DbqueryparallelPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelPath::copy(self : DbqueryparallelPath) -> DbqueryparallelPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelPath::fill(self : DbqueryparallelPath, v : Double) -> DbqueryparallelPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelPath::min(self : DbqueryparallelPath) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelPath::max(self : DbqueryparallelPath) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelPath::to_string(self : DbqueryparallelPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_cluster_make(size : Int) -> DbqueryparallelCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelCluster::len(self : DbqueryparallelCluster) -> Int { self.size }

pub fn DbqueryparallelCluster::get(self : DbqueryparallelCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelCluster::set(self : DbqueryparallelCluster, i : Int, v : Double) -> DbqueryparallelCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelCluster::sum(self : DbqueryparallelCluster) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelCluster::mean(self : DbqueryparallelCluster) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelCluster::scale(self : DbqueryparallelCluster, f : Double) -> DbqueryparallelCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelCluster::add(self : DbqueryparallelCluster, other : DbqueryparallelCluster) -> DbqueryparallelCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelCluster::copy(self : DbqueryparallelCluster) -> DbqueryparallelCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelCluster::fill(self : DbqueryparallelCluster, v : Double) -> DbqueryparallelCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelCluster::min(self : DbqueryparallelCluster) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelCluster::max(self : DbqueryparallelCluster) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelCluster::to_string(self : DbqueryparallelCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_model_make(size : Int) -> DbqueryparallelModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelModel::len(self : DbqueryparallelModel) -> Int { self.size }

pub fn DbqueryparallelModel::get(self : DbqueryparallelModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelModel::set(self : DbqueryparallelModel, i : Int, v : Double) -> DbqueryparallelModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelModel::sum(self : DbqueryparallelModel) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelModel::mean(self : DbqueryparallelModel) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelModel::scale(self : DbqueryparallelModel, f : Double) -> DbqueryparallelModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelModel::add(self : DbqueryparallelModel, other : DbqueryparallelModel) -> DbqueryparallelModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelModel::copy(self : DbqueryparallelModel) -> DbqueryparallelModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelModel::fill(self : DbqueryparallelModel, v : Double) -> DbqueryparallelModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelModel::min(self : DbqueryparallelModel) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelModel::max(self : DbqueryparallelModel) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelModel::to_string(self : DbqueryparallelModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_layer_make(size : Int) -> DbqueryparallelLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelLayer::len(self : DbqueryparallelLayer) -> Int { self.size }

pub fn DbqueryparallelLayer::get(self : DbqueryparallelLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelLayer::set(self : DbqueryparallelLayer, i : Int, v : Double) -> DbqueryparallelLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelLayer::sum(self : DbqueryparallelLayer) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelLayer::mean(self : DbqueryparallelLayer) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelLayer::scale(self : DbqueryparallelLayer, f : Double) -> DbqueryparallelLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelLayer::add(self : DbqueryparallelLayer, other : DbqueryparallelLayer) -> DbqueryparallelLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelLayer::copy(self : DbqueryparallelLayer) -> DbqueryparallelLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelLayer::fill(self : DbqueryparallelLayer, v : Double) -> DbqueryparallelLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelLayer::min(self : DbqueryparallelLayer) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelLayer::max(self : DbqueryparallelLayer) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelLayer::to_string(self : DbqueryparallelLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_buffer_make(size : Int) -> DbqueryparallelBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelBuffer::len(self : DbqueryparallelBuffer) -> Int { self.size }

pub fn DbqueryparallelBuffer::get(self : DbqueryparallelBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelBuffer::set(self : DbqueryparallelBuffer, i : Int, v : Double) -> DbqueryparallelBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelBuffer::sum(self : DbqueryparallelBuffer) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelBuffer::mean(self : DbqueryparallelBuffer) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelBuffer::scale(self : DbqueryparallelBuffer, f : Double) -> DbqueryparallelBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelBuffer::add(self : DbqueryparallelBuffer, other : DbqueryparallelBuffer) -> DbqueryparallelBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelBuffer::copy(self : DbqueryparallelBuffer) -> DbqueryparallelBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelBuffer::fill(self : DbqueryparallelBuffer, v : Double) -> DbqueryparallelBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelBuffer::min(self : DbqueryparallelBuffer) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelBuffer::max(self : DbqueryparallelBuffer) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelBuffer::to_string(self : DbqueryparallelBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_cursor_make(size : Int) -> DbqueryparallelCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelCursor::len(self : DbqueryparallelCursor) -> Int { self.size }

pub fn DbqueryparallelCursor::get(self : DbqueryparallelCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelCursor::set(self : DbqueryparallelCursor, i : Int, v : Double) -> DbqueryparallelCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelCursor::sum(self : DbqueryparallelCursor) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelCursor::mean(self : DbqueryparallelCursor) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelCursor::scale(self : DbqueryparallelCursor, f : Double) -> DbqueryparallelCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelCursor::add(self : DbqueryparallelCursor, other : DbqueryparallelCursor) -> DbqueryparallelCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelCursor::copy(self : DbqueryparallelCursor) -> DbqueryparallelCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelCursor::fill(self : DbqueryparallelCursor, v : Double) -> DbqueryparallelCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelCursor::min(self : DbqueryparallelCursor) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelCursor::max(self : DbqueryparallelCursor) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelCursor::to_string(self : DbqueryparallelCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_view_make(size : Int) -> DbqueryparallelView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelView::len(self : DbqueryparallelView) -> Int { self.size }

pub fn DbqueryparallelView::get(self : DbqueryparallelView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelView::set(self : DbqueryparallelView, i : Int, v : Double) -> DbqueryparallelView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelView::sum(self : DbqueryparallelView) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelView::mean(self : DbqueryparallelView) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelView::scale(self : DbqueryparallelView, f : Double) -> DbqueryparallelView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelView::add(self : DbqueryparallelView, other : DbqueryparallelView) -> DbqueryparallelView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelView::copy(self : DbqueryparallelView) -> DbqueryparallelView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelView::fill(self : DbqueryparallelView, v : Double) -> DbqueryparallelView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelView::min(self : DbqueryparallelView) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelView::max(self : DbqueryparallelView) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelView::to_string(self : DbqueryparallelView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_range_make(size : Int) -> DbqueryparallelRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelRange::len(self : DbqueryparallelRange) -> Int { self.size }

pub fn DbqueryparallelRange::get(self : DbqueryparallelRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelRange::set(self : DbqueryparallelRange, i : Int, v : Double) -> DbqueryparallelRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelRange::sum(self : DbqueryparallelRange) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelRange::mean(self : DbqueryparallelRange) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelRange::scale(self : DbqueryparallelRange, f : Double) -> DbqueryparallelRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelRange::add(self : DbqueryparallelRange, other : DbqueryparallelRange) -> DbqueryparallelRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelRange::copy(self : DbqueryparallelRange) -> DbqueryparallelRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelRange::fill(self : DbqueryparallelRange, v : Double) -> DbqueryparallelRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelRange::min(self : DbqueryparallelRange) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelRange::max(self : DbqueryparallelRange) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelRange::to_string(self : DbqueryparallelRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_slice_make(size : Int) -> DbqueryparallelSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryparallelSlice::len(self : DbqueryparallelSlice) -> Int { self.size }

pub fn DbqueryparallelSlice::get(self : DbqueryparallelSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryparallelSlice::set(self : DbqueryparallelSlice, i : Int, v : Double) -> DbqueryparallelSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryparallelSlice::sum(self : DbqueryparallelSlice) -> Double { @_common.sum(self.data) }

pub fn DbqueryparallelSlice::mean(self : DbqueryparallelSlice) -> Double { @_common.mean(self.data) }

pub fn DbqueryparallelSlice::scale(self : DbqueryparallelSlice, f : Double) -> DbqueryparallelSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelSlice::add(self : DbqueryparallelSlice, other : DbqueryparallelSlice) -> DbqueryparallelSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryparallelSlice::copy(self : DbqueryparallelSlice) -> DbqueryparallelSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelSlice::fill(self : DbqueryparallelSlice, v : Double) -> DbqueryparallelSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryparallelSlice::min(self : DbqueryparallelSlice) -> Double { @_common.min(self.data) }

pub fn DbqueryparallelSlice::max(self : DbqueryparallelSlice) -> Double { @_common.max(self.data) }

pub fn DbqueryparallelSlice::to_string(self : DbqueryparallelSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

