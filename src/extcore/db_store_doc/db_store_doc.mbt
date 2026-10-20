///===
/// extcore/db_store_doc

pub(all) struct DbstoredocPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_doc_make_point(x : Double, y : Double) -> DbstoredocPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_doc_make_point3(x : Double, y : Double, z : Double) -> DbstoredocPoint {
  { x, y, z, label: 0 }
}

pub fn DbstoredocPoint::x(self : DbstoredocPoint) -> Double { self.x }

pub fn DbstoredocPoint::y(self : DbstoredocPoint) -> Double { self.y }

pub fn DbstoredocPoint::z(self : DbstoredocPoint) -> Double { self.z }

pub fn DbstoredocPoint::label(self : DbstoredocPoint) -> Int { self.label }

pub fn DbstoredocPoint::dist(self : DbstoredocPoint, other : DbstoredocPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstoredocPoint::add(self : DbstoredocPoint, other : DbstoredocPoint) -> DbstoredocPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstoredocPoint::sub(self : DbstoredocPoint, other : DbstoredocPoint) -> DbstoredocPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstoredocPoint::scale(self : DbstoredocPoint, s : Double) -> DbstoredocPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstoredocPoint::dot(self : DbstoredocPoint, other : DbstoredocPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstoredocPoint::cross(self : DbstoredocPoint, other : DbstoredocPoint) -> DbstoredocPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstoredocPoint::norm(self : DbstoredocPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstoredocPoint::normalize(self : DbstoredocPoint) -> DbstoredocPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoredocPoint::negate(self : DbstoredocPoint) -> DbstoredocPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstoredocPoint::mid(self : DbstoredocPoint, other : DbstoredocPoint) -> DbstoredocPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstoredocPoint::lerp(self : DbstoredocPoint, other : DbstoredocPoint, t : Double) -> DbstoredocPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstoredocPoint::to_string(self : DbstoredocPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstoredocSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_doc_make_series(vals : Array[Double], name : String) -> DbstoredocSeries {
  { vals, name, meta: 0 }
}

pub fn DbstoredocSeries::len(self : DbstoredocSeries) -> Int { self.vals.length() }

pub fn DbstoredocSeries::sum(self : DbstoredocSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstoredocSeries::mean(self : DbstoredocSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstoredocSeries::min(self : DbstoredocSeries) -> Double { @_common.min(self.vals) }

pub fn DbstoredocSeries::max(self : DbstoredocSeries) -> Double { @_common.max(self.vals) }

pub fn DbstoredocSeries::range(self : DbstoredocSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstoredocSeries::variance(self : DbstoredocSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstoredocSeries::std(self : DbstoredocSeries) -> Double { @_common.std(self.vals) }

pub fn DbstoredocSeries::median(self : DbstoredocSeries) -> Double { @_common.median(self.vals) }

pub fn DbstoredocSeries::scale(self : DbstoredocSeries, f : Double) -> DbstoredocSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstoredocSeries::add(self : DbstoredocSeries, other : DbstoredocSeries) -> DbstoredocSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstoredocSeries::sub(self : DbstoredocSeries, other : DbstoredocSeries) -> DbstoredocSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstoredocSeries::normalize(self : DbstoredocSeries) -> DbstoredocSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstoredocSeries::cumsum(self : DbstoredocSeries) -> DbstoredocSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstoredocSeries::to_string(self : DbstoredocSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoredocMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_doc_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoredocMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_doc_matrix_identity(n : Int) -> DbstoredocMatrix {
  let m = db_store_doc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstoredocMatrix::get(self : DbstoredocMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstoredocMatrix::transpose(self : DbstoredocMatrix) -> DbstoredocMatrix {
  let result = db_store_doc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstoredocMatrix::add(self : DbstoredocMatrix, other : DbstoredocMatrix) -> DbstoredocMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_doc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstoredocMatrix::scale(self : DbstoredocMatrix, s : Double) -> DbstoredocMatrix {
  let result = db_store_doc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstoredocMatrix::multiply(self : DbstoredocMatrix, other : DbstoredocMatrix) -> DbstoredocMatrix {
  if self.cols != other.rows { return db_store_doc_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_doc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstoredocMatrix::trace(self : DbstoredocMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstoredocMatrix::det(self : DbstoredocMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstoredocMatrix::norm(self : DbstoredocMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstoredocMatrix::to_string(self : DbstoredocMatrix) -> String {
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

pub(all) struct DbstoredocVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_doc_make_vector(comps : Array[Double]) -> DbstoredocVector {
  { comps, dim: comps.length() }
}

pub fn db_store_doc_vector_zero(dim : Int) -> DbstoredocVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstoredocVector::add(self : DbstoredocVector, other : DbstoredocVector) -> DbstoredocVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoredocVector::sub(self : DbstoredocVector, other : DbstoredocVector) -> DbstoredocVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoredocVector::scale(self : DbstoredocVector, s : Double) -> DbstoredocVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstoredocVector::dot(self : DbstoredocVector, other : DbstoredocVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstoredocVector::norm(self : DbstoredocVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstoredocVector::normalize(self : DbstoredocVector) -> DbstoredocVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoredocVector::dist(self : DbstoredocVector, other : DbstoredocVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstoredocVector::to_string(self : DbstoredocVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoredocFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_frame_make(size : Int) -> DbstoredocFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocFrame::len(self : DbstoredocFrame) -> Int { self.size }

pub fn DbstoredocFrame::get(self : DbstoredocFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocFrame::set(self : DbstoredocFrame, i : Int, v : Double) -> DbstoredocFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocFrame::sum(self : DbstoredocFrame) -> Double { @_common.sum(self.data) }

pub fn DbstoredocFrame::mean(self : DbstoredocFrame) -> Double { @_common.mean(self.data) }

pub fn DbstoredocFrame::scale(self : DbstoredocFrame, f : Double) -> DbstoredocFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocFrame::add(self : DbstoredocFrame, other : DbstoredocFrame) -> DbstoredocFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocFrame::copy(self : DbstoredocFrame) -> DbstoredocFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocFrame::fill(self : DbstoredocFrame, v : Double) -> DbstoredocFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocFrame::min(self : DbstoredocFrame) -> Double { @_common.min(self.data) }

pub fn DbstoredocFrame::max(self : DbstoredocFrame) -> Double { @_common.max(self.data) }

pub fn DbstoredocFrame::to_string(self : DbstoredocFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_table_make(size : Int) -> DbstoredocTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocTable::len(self : DbstoredocTable) -> Int { self.size }

pub fn DbstoredocTable::get(self : DbstoredocTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocTable::set(self : DbstoredocTable, i : Int, v : Double) -> DbstoredocTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocTable::sum(self : DbstoredocTable) -> Double { @_common.sum(self.data) }

pub fn DbstoredocTable::mean(self : DbstoredocTable) -> Double { @_common.mean(self.data) }

pub fn DbstoredocTable::scale(self : DbstoredocTable, f : Double) -> DbstoredocTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocTable::add(self : DbstoredocTable, other : DbstoredocTable) -> DbstoredocTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocTable::copy(self : DbstoredocTable) -> DbstoredocTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocTable::fill(self : DbstoredocTable, v : Double) -> DbstoredocTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocTable::min(self : DbstoredocTable) -> Double { @_common.min(self.data) }

pub fn DbstoredocTable::max(self : DbstoredocTable) -> Double { @_common.max(self.data) }

pub fn DbstoredocTable::to_string(self : DbstoredocTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_graphn_make(size : Int) -> DbstoredocGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocGraphN::len(self : DbstoredocGraphN) -> Int { self.size }

pub fn DbstoredocGraphN::get(self : DbstoredocGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocGraphN::set(self : DbstoredocGraphN, i : Int, v : Double) -> DbstoredocGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocGraphN::sum(self : DbstoredocGraphN) -> Double { @_common.sum(self.data) }

pub fn DbstoredocGraphN::mean(self : DbstoredocGraphN) -> Double { @_common.mean(self.data) }

pub fn DbstoredocGraphN::scale(self : DbstoredocGraphN, f : Double) -> DbstoredocGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocGraphN::add(self : DbstoredocGraphN, other : DbstoredocGraphN) -> DbstoredocGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocGraphN::copy(self : DbstoredocGraphN) -> DbstoredocGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocGraphN::fill(self : DbstoredocGraphN, v : Double) -> DbstoredocGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocGraphN::min(self : DbstoredocGraphN) -> Double { @_common.min(self.data) }

pub fn DbstoredocGraphN::max(self : DbstoredocGraphN) -> Double { @_common.max(self.data) }

pub fn DbstoredocGraphN::to_string(self : DbstoredocGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_node_make(size : Int) -> DbstoredocNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocNode::len(self : DbstoredocNode) -> Int { self.size }

pub fn DbstoredocNode::get(self : DbstoredocNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocNode::set(self : DbstoredocNode, i : Int, v : Double) -> DbstoredocNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocNode::sum(self : DbstoredocNode) -> Double { @_common.sum(self.data) }

pub fn DbstoredocNode::mean(self : DbstoredocNode) -> Double { @_common.mean(self.data) }

pub fn DbstoredocNode::scale(self : DbstoredocNode, f : Double) -> DbstoredocNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocNode::add(self : DbstoredocNode, other : DbstoredocNode) -> DbstoredocNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocNode::copy(self : DbstoredocNode) -> DbstoredocNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocNode::fill(self : DbstoredocNode, v : Double) -> DbstoredocNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocNode::min(self : DbstoredocNode) -> Double { @_common.min(self.data) }

pub fn DbstoredocNode::max(self : DbstoredocNode) -> Double { @_common.max(self.data) }

pub fn DbstoredocNode::to_string(self : DbstoredocNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_edge_make(size : Int) -> DbstoredocEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocEdge::len(self : DbstoredocEdge) -> Int { self.size }

pub fn DbstoredocEdge::get(self : DbstoredocEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocEdge::set(self : DbstoredocEdge, i : Int, v : Double) -> DbstoredocEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocEdge::sum(self : DbstoredocEdge) -> Double { @_common.sum(self.data) }

pub fn DbstoredocEdge::mean(self : DbstoredocEdge) -> Double { @_common.mean(self.data) }

pub fn DbstoredocEdge::scale(self : DbstoredocEdge, f : Double) -> DbstoredocEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocEdge::add(self : DbstoredocEdge, other : DbstoredocEdge) -> DbstoredocEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocEdge::copy(self : DbstoredocEdge) -> DbstoredocEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocEdge::fill(self : DbstoredocEdge, v : Double) -> DbstoredocEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocEdge::min(self : DbstoredocEdge) -> Double { @_common.min(self.data) }

pub fn DbstoredocEdge::max(self : DbstoredocEdge) -> Double { @_common.max(self.data) }

pub fn DbstoredocEdge::to_string(self : DbstoredocEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_path_make(size : Int) -> DbstoredocPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocPath::len(self : DbstoredocPath) -> Int { self.size }

pub fn DbstoredocPath::get(self : DbstoredocPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocPath::set(self : DbstoredocPath, i : Int, v : Double) -> DbstoredocPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocPath::sum(self : DbstoredocPath) -> Double { @_common.sum(self.data) }

pub fn DbstoredocPath::mean(self : DbstoredocPath) -> Double { @_common.mean(self.data) }

pub fn DbstoredocPath::scale(self : DbstoredocPath, f : Double) -> DbstoredocPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocPath::add(self : DbstoredocPath, other : DbstoredocPath) -> DbstoredocPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocPath::copy(self : DbstoredocPath) -> DbstoredocPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocPath::fill(self : DbstoredocPath, v : Double) -> DbstoredocPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocPath::min(self : DbstoredocPath) -> Double { @_common.min(self.data) }

pub fn DbstoredocPath::max(self : DbstoredocPath) -> Double { @_common.max(self.data) }

pub fn DbstoredocPath::to_string(self : DbstoredocPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_cluster_make(size : Int) -> DbstoredocCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocCluster::len(self : DbstoredocCluster) -> Int { self.size }

pub fn DbstoredocCluster::get(self : DbstoredocCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocCluster::set(self : DbstoredocCluster, i : Int, v : Double) -> DbstoredocCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocCluster::sum(self : DbstoredocCluster) -> Double { @_common.sum(self.data) }

pub fn DbstoredocCluster::mean(self : DbstoredocCluster) -> Double { @_common.mean(self.data) }

pub fn DbstoredocCluster::scale(self : DbstoredocCluster, f : Double) -> DbstoredocCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocCluster::add(self : DbstoredocCluster, other : DbstoredocCluster) -> DbstoredocCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocCluster::copy(self : DbstoredocCluster) -> DbstoredocCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocCluster::fill(self : DbstoredocCluster, v : Double) -> DbstoredocCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocCluster::min(self : DbstoredocCluster) -> Double { @_common.min(self.data) }

pub fn DbstoredocCluster::max(self : DbstoredocCluster) -> Double { @_common.max(self.data) }

pub fn DbstoredocCluster::to_string(self : DbstoredocCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_model_make(size : Int) -> DbstoredocModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocModel::len(self : DbstoredocModel) -> Int { self.size }

pub fn DbstoredocModel::get(self : DbstoredocModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocModel::set(self : DbstoredocModel, i : Int, v : Double) -> DbstoredocModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocModel::sum(self : DbstoredocModel) -> Double { @_common.sum(self.data) }

pub fn DbstoredocModel::mean(self : DbstoredocModel) -> Double { @_common.mean(self.data) }

pub fn DbstoredocModel::scale(self : DbstoredocModel, f : Double) -> DbstoredocModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocModel::add(self : DbstoredocModel, other : DbstoredocModel) -> DbstoredocModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocModel::copy(self : DbstoredocModel) -> DbstoredocModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocModel::fill(self : DbstoredocModel, v : Double) -> DbstoredocModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocModel::min(self : DbstoredocModel) -> Double { @_common.min(self.data) }

pub fn DbstoredocModel::max(self : DbstoredocModel) -> Double { @_common.max(self.data) }

pub fn DbstoredocModel::to_string(self : DbstoredocModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_layer_make(size : Int) -> DbstoredocLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocLayer::len(self : DbstoredocLayer) -> Int { self.size }

pub fn DbstoredocLayer::get(self : DbstoredocLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocLayer::set(self : DbstoredocLayer, i : Int, v : Double) -> DbstoredocLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocLayer::sum(self : DbstoredocLayer) -> Double { @_common.sum(self.data) }

pub fn DbstoredocLayer::mean(self : DbstoredocLayer) -> Double { @_common.mean(self.data) }

pub fn DbstoredocLayer::scale(self : DbstoredocLayer, f : Double) -> DbstoredocLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocLayer::add(self : DbstoredocLayer, other : DbstoredocLayer) -> DbstoredocLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocLayer::copy(self : DbstoredocLayer) -> DbstoredocLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocLayer::fill(self : DbstoredocLayer, v : Double) -> DbstoredocLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocLayer::min(self : DbstoredocLayer) -> Double { @_common.min(self.data) }

pub fn DbstoredocLayer::max(self : DbstoredocLayer) -> Double { @_common.max(self.data) }

pub fn DbstoredocLayer::to_string(self : DbstoredocLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_buffer_make(size : Int) -> DbstoredocBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocBuffer::len(self : DbstoredocBuffer) -> Int { self.size }

pub fn DbstoredocBuffer::get(self : DbstoredocBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocBuffer::set(self : DbstoredocBuffer, i : Int, v : Double) -> DbstoredocBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocBuffer::sum(self : DbstoredocBuffer) -> Double { @_common.sum(self.data) }

pub fn DbstoredocBuffer::mean(self : DbstoredocBuffer) -> Double { @_common.mean(self.data) }

pub fn DbstoredocBuffer::scale(self : DbstoredocBuffer, f : Double) -> DbstoredocBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocBuffer::add(self : DbstoredocBuffer, other : DbstoredocBuffer) -> DbstoredocBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocBuffer::copy(self : DbstoredocBuffer) -> DbstoredocBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocBuffer::fill(self : DbstoredocBuffer, v : Double) -> DbstoredocBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocBuffer::min(self : DbstoredocBuffer) -> Double { @_common.min(self.data) }

pub fn DbstoredocBuffer::max(self : DbstoredocBuffer) -> Double { @_common.max(self.data) }

pub fn DbstoredocBuffer::to_string(self : DbstoredocBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_cursor_make(size : Int) -> DbstoredocCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocCursor::len(self : DbstoredocCursor) -> Int { self.size }

pub fn DbstoredocCursor::get(self : DbstoredocCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocCursor::set(self : DbstoredocCursor, i : Int, v : Double) -> DbstoredocCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocCursor::sum(self : DbstoredocCursor) -> Double { @_common.sum(self.data) }

pub fn DbstoredocCursor::mean(self : DbstoredocCursor) -> Double { @_common.mean(self.data) }

pub fn DbstoredocCursor::scale(self : DbstoredocCursor, f : Double) -> DbstoredocCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocCursor::add(self : DbstoredocCursor, other : DbstoredocCursor) -> DbstoredocCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocCursor::copy(self : DbstoredocCursor) -> DbstoredocCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocCursor::fill(self : DbstoredocCursor, v : Double) -> DbstoredocCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocCursor::min(self : DbstoredocCursor) -> Double { @_common.min(self.data) }

pub fn DbstoredocCursor::max(self : DbstoredocCursor) -> Double { @_common.max(self.data) }

pub fn DbstoredocCursor::to_string(self : DbstoredocCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_view_make(size : Int) -> DbstoredocView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocView::len(self : DbstoredocView) -> Int { self.size }

pub fn DbstoredocView::get(self : DbstoredocView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocView::set(self : DbstoredocView, i : Int, v : Double) -> DbstoredocView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocView::sum(self : DbstoredocView) -> Double { @_common.sum(self.data) }

pub fn DbstoredocView::mean(self : DbstoredocView) -> Double { @_common.mean(self.data) }

pub fn DbstoredocView::scale(self : DbstoredocView, f : Double) -> DbstoredocView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocView::add(self : DbstoredocView, other : DbstoredocView) -> DbstoredocView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocView::copy(self : DbstoredocView) -> DbstoredocView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocView::fill(self : DbstoredocView, v : Double) -> DbstoredocView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocView::min(self : DbstoredocView) -> Double { @_common.min(self.data) }

pub fn DbstoredocView::max(self : DbstoredocView) -> Double { @_common.max(self.data) }

pub fn DbstoredocView::to_string(self : DbstoredocView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_range_make(size : Int) -> DbstoredocRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocRange::len(self : DbstoredocRange) -> Int { self.size }

pub fn DbstoredocRange::get(self : DbstoredocRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocRange::set(self : DbstoredocRange, i : Int, v : Double) -> DbstoredocRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocRange::sum(self : DbstoredocRange) -> Double { @_common.sum(self.data) }

pub fn DbstoredocRange::mean(self : DbstoredocRange) -> Double { @_common.mean(self.data) }

pub fn DbstoredocRange::scale(self : DbstoredocRange, f : Double) -> DbstoredocRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocRange::add(self : DbstoredocRange, other : DbstoredocRange) -> DbstoredocRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocRange::copy(self : DbstoredocRange) -> DbstoredocRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocRange::fill(self : DbstoredocRange, v : Double) -> DbstoredocRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocRange::min(self : DbstoredocRange) -> Double { @_common.min(self.data) }

pub fn DbstoredocRange::max(self : DbstoredocRange) -> Double { @_common.max(self.data) }

pub fn DbstoredocRange::to_string(self : DbstoredocRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoredocSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_slice_make(size : Int) -> DbstoredocSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoredocSlice::len(self : DbstoredocSlice) -> Int { self.size }

pub fn DbstoredocSlice::get(self : DbstoredocSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoredocSlice::set(self : DbstoredocSlice, i : Int, v : Double) -> DbstoredocSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoredocSlice::sum(self : DbstoredocSlice) -> Double { @_common.sum(self.data) }

pub fn DbstoredocSlice::mean(self : DbstoredocSlice) -> Double { @_common.mean(self.data) }

pub fn DbstoredocSlice::scale(self : DbstoredocSlice, f : Double) -> DbstoredocSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoredocSlice::add(self : DbstoredocSlice, other : DbstoredocSlice) -> DbstoredocSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoredocSlice::copy(self : DbstoredocSlice) -> DbstoredocSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoredocSlice::fill(self : DbstoredocSlice, v : Double) -> DbstoredocSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoredocSlice::min(self : DbstoredocSlice) -> Double { @_common.min(self.data) }

pub fn DbstoredocSlice::max(self : DbstoredocSlice) -> Double { @_common.max(self.data) }

pub fn DbstoredocSlice::to_string(self : DbstoredocSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

