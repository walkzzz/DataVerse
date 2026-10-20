///===
/// extcore/db_store_tensor

pub(all) struct DbstoretensorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_tensor_make_point(x : Double, y : Double) -> DbstoretensorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_tensor_make_point3(x : Double, y : Double, z : Double) -> DbstoretensorPoint {
  { x, y, z, label: 0 }
}

pub fn DbstoretensorPoint::x(self : DbstoretensorPoint) -> Double { self.x }

pub fn DbstoretensorPoint::y(self : DbstoretensorPoint) -> Double { self.y }

pub fn DbstoretensorPoint::z(self : DbstoretensorPoint) -> Double { self.z }

pub fn DbstoretensorPoint::label(self : DbstoretensorPoint) -> Int { self.label }

pub fn DbstoretensorPoint::dist(self : DbstoretensorPoint, other : DbstoretensorPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstoretensorPoint::add(self : DbstoretensorPoint, other : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstoretensorPoint::sub(self : DbstoretensorPoint, other : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstoretensorPoint::scale(self : DbstoretensorPoint, s : Double) -> DbstoretensorPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstoretensorPoint::dot(self : DbstoretensorPoint, other : DbstoretensorPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstoretensorPoint::cross(self : DbstoretensorPoint, other : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstoretensorPoint::norm(self : DbstoretensorPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstoretensorPoint::normalize(self : DbstoretensorPoint) -> DbstoretensorPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoretensorPoint::negate(self : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstoretensorPoint::mid(self : DbstoretensorPoint, other : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstoretensorPoint::lerp(self : DbstoretensorPoint, other : DbstoretensorPoint, t : Double) -> DbstoretensorPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstoretensorPoint::to_string(self : DbstoretensorPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstoretensorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_tensor_make_series(vals : Array[Double], name : String) -> DbstoretensorSeries {
  { vals, name, meta: 0 }
}

pub fn DbstoretensorSeries::len(self : DbstoretensorSeries) -> Int { self.vals.length() }

pub fn DbstoretensorSeries::sum(self : DbstoretensorSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstoretensorSeries::mean(self : DbstoretensorSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstoretensorSeries::min(self : DbstoretensorSeries) -> Double { @_common.min(self.vals) }

pub fn DbstoretensorSeries::max(self : DbstoretensorSeries) -> Double { @_common.max(self.vals) }

pub fn DbstoretensorSeries::range(self : DbstoretensorSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstoretensorSeries::variance(self : DbstoretensorSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstoretensorSeries::std(self : DbstoretensorSeries) -> Double { @_common.std(self.vals) }

pub fn DbstoretensorSeries::median(self : DbstoretensorSeries) -> Double { @_common.median(self.vals) }

pub fn DbstoretensorSeries::scale(self : DbstoretensorSeries, f : Double) -> DbstoretensorSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstoretensorSeries::add(self : DbstoretensorSeries, other : DbstoretensorSeries) -> DbstoretensorSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstoretensorSeries::sub(self : DbstoretensorSeries, other : DbstoretensorSeries) -> DbstoretensorSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstoretensorSeries::normalize(self : DbstoretensorSeries) -> DbstoretensorSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstoretensorSeries::cumsum(self : DbstoretensorSeries) -> DbstoretensorSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstoretensorSeries::to_string(self : DbstoretensorSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoretensorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_tensor_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoretensorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_tensor_matrix_identity(n : Int) -> DbstoretensorMatrix {
  let m = db_store_tensor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstoretensorMatrix::get(self : DbstoretensorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstoretensorMatrix::transpose(self : DbstoretensorMatrix) -> DbstoretensorMatrix {
  let result = db_store_tensor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstoretensorMatrix::add(self : DbstoretensorMatrix, other : DbstoretensorMatrix) -> DbstoretensorMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_tensor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstoretensorMatrix::scale(self : DbstoretensorMatrix, s : Double) -> DbstoretensorMatrix {
  let result = db_store_tensor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstoretensorMatrix::multiply(self : DbstoretensorMatrix, other : DbstoretensorMatrix) -> DbstoretensorMatrix {
  if self.cols != other.rows { return db_store_tensor_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_tensor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstoretensorMatrix::trace(self : DbstoretensorMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstoretensorMatrix::det(self : DbstoretensorMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstoretensorMatrix::norm(self : DbstoretensorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstoretensorMatrix::to_string(self : DbstoretensorMatrix) -> String {
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

pub(all) struct DbstoretensorVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_tensor_make_vector(comps : Array[Double]) -> DbstoretensorVector {
  { comps, dim: comps.length() }
}

pub fn db_store_tensor_vector_zero(dim : Int) -> DbstoretensorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstoretensorVector::add(self : DbstoretensorVector, other : DbstoretensorVector) -> DbstoretensorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoretensorVector::sub(self : DbstoretensorVector, other : DbstoretensorVector) -> DbstoretensorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoretensorVector::scale(self : DbstoretensorVector, s : Double) -> DbstoretensorVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstoretensorVector::dot(self : DbstoretensorVector, other : DbstoretensorVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstoretensorVector::norm(self : DbstoretensorVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstoretensorVector::normalize(self : DbstoretensorVector) -> DbstoretensorVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoretensorVector::dist(self : DbstoretensorVector, other : DbstoretensorVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstoretensorVector::to_string(self : DbstoretensorVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoretensorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_frame_make(size : Int) -> DbstoretensorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorFrame::len(self : DbstoretensorFrame) -> Int { self.size }

pub fn DbstoretensorFrame::get(self : DbstoretensorFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorFrame::set(self : DbstoretensorFrame, i : Int, v : Double) -> DbstoretensorFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorFrame::sum(self : DbstoretensorFrame) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorFrame::mean(self : DbstoretensorFrame) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorFrame::scale(self : DbstoretensorFrame, f : Double) -> DbstoretensorFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorFrame::add(self : DbstoretensorFrame, other : DbstoretensorFrame) -> DbstoretensorFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorFrame::copy(self : DbstoretensorFrame) -> DbstoretensorFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorFrame::fill(self : DbstoretensorFrame, v : Double) -> DbstoretensorFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorFrame::min(self : DbstoretensorFrame) -> Double { @_common.min(self.data) }

pub fn DbstoretensorFrame::max(self : DbstoretensorFrame) -> Double { @_common.max(self.data) }

pub fn DbstoretensorFrame::to_string(self : DbstoretensorFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_table_make(size : Int) -> DbstoretensorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorTable::len(self : DbstoretensorTable) -> Int { self.size }

pub fn DbstoretensorTable::get(self : DbstoretensorTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorTable::set(self : DbstoretensorTable, i : Int, v : Double) -> DbstoretensorTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorTable::sum(self : DbstoretensorTable) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorTable::mean(self : DbstoretensorTable) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorTable::scale(self : DbstoretensorTable, f : Double) -> DbstoretensorTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorTable::add(self : DbstoretensorTable, other : DbstoretensorTable) -> DbstoretensorTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorTable::copy(self : DbstoretensorTable) -> DbstoretensorTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorTable::fill(self : DbstoretensorTable, v : Double) -> DbstoretensorTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorTable::min(self : DbstoretensorTable) -> Double { @_common.min(self.data) }

pub fn DbstoretensorTable::max(self : DbstoretensorTable) -> Double { @_common.max(self.data) }

pub fn DbstoretensorTable::to_string(self : DbstoretensorTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_graphn_make(size : Int) -> DbstoretensorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorGraphN::len(self : DbstoretensorGraphN) -> Int { self.size }

pub fn DbstoretensorGraphN::get(self : DbstoretensorGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorGraphN::set(self : DbstoretensorGraphN, i : Int, v : Double) -> DbstoretensorGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorGraphN::sum(self : DbstoretensorGraphN) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorGraphN::mean(self : DbstoretensorGraphN) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorGraphN::scale(self : DbstoretensorGraphN, f : Double) -> DbstoretensorGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorGraphN::add(self : DbstoretensorGraphN, other : DbstoretensorGraphN) -> DbstoretensorGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorGraphN::copy(self : DbstoretensorGraphN) -> DbstoretensorGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorGraphN::fill(self : DbstoretensorGraphN, v : Double) -> DbstoretensorGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorGraphN::min(self : DbstoretensorGraphN) -> Double { @_common.min(self.data) }

pub fn DbstoretensorGraphN::max(self : DbstoretensorGraphN) -> Double { @_common.max(self.data) }

pub fn DbstoretensorGraphN::to_string(self : DbstoretensorGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_node_make(size : Int) -> DbstoretensorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorNode::len(self : DbstoretensorNode) -> Int { self.size }

pub fn DbstoretensorNode::get(self : DbstoretensorNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorNode::set(self : DbstoretensorNode, i : Int, v : Double) -> DbstoretensorNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorNode::sum(self : DbstoretensorNode) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorNode::mean(self : DbstoretensorNode) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorNode::scale(self : DbstoretensorNode, f : Double) -> DbstoretensorNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorNode::add(self : DbstoretensorNode, other : DbstoretensorNode) -> DbstoretensorNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorNode::copy(self : DbstoretensorNode) -> DbstoretensorNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorNode::fill(self : DbstoretensorNode, v : Double) -> DbstoretensorNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorNode::min(self : DbstoretensorNode) -> Double { @_common.min(self.data) }

pub fn DbstoretensorNode::max(self : DbstoretensorNode) -> Double { @_common.max(self.data) }

pub fn DbstoretensorNode::to_string(self : DbstoretensorNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_edge_make(size : Int) -> DbstoretensorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorEdge::len(self : DbstoretensorEdge) -> Int { self.size }

pub fn DbstoretensorEdge::get(self : DbstoretensorEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorEdge::set(self : DbstoretensorEdge, i : Int, v : Double) -> DbstoretensorEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorEdge::sum(self : DbstoretensorEdge) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorEdge::mean(self : DbstoretensorEdge) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorEdge::scale(self : DbstoretensorEdge, f : Double) -> DbstoretensorEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorEdge::add(self : DbstoretensorEdge, other : DbstoretensorEdge) -> DbstoretensorEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorEdge::copy(self : DbstoretensorEdge) -> DbstoretensorEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorEdge::fill(self : DbstoretensorEdge, v : Double) -> DbstoretensorEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorEdge::min(self : DbstoretensorEdge) -> Double { @_common.min(self.data) }

pub fn DbstoretensorEdge::max(self : DbstoretensorEdge) -> Double { @_common.max(self.data) }

pub fn DbstoretensorEdge::to_string(self : DbstoretensorEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_path_make(size : Int) -> DbstoretensorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorPath::len(self : DbstoretensorPath) -> Int { self.size }

pub fn DbstoretensorPath::get(self : DbstoretensorPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorPath::set(self : DbstoretensorPath, i : Int, v : Double) -> DbstoretensorPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorPath::sum(self : DbstoretensorPath) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorPath::mean(self : DbstoretensorPath) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorPath::scale(self : DbstoretensorPath, f : Double) -> DbstoretensorPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorPath::add(self : DbstoretensorPath, other : DbstoretensorPath) -> DbstoretensorPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorPath::copy(self : DbstoretensorPath) -> DbstoretensorPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorPath::fill(self : DbstoretensorPath, v : Double) -> DbstoretensorPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorPath::min(self : DbstoretensorPath) -> Double { @_common.min(self.data) }

pub fn DbstoretensorPath::max(self : DbstoretensorPath) -> Double { @_common.max(self.data) }

pub fn DbstoretensorPath::to_string(self : DbstoretensorPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_cluster_make(size : Int) -> DbstoretensorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorCluster::len(self : DbstoretensorCluster) -> Int { self.size }

pub fn DbstoretensorCluster::get(self : DbstoretensorCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorCluster::set(self : DbstoretensorCluster, i : Int, v : Double) -> DbstoretensorCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorCluster::sum(self : DbstoretensorCluster) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorCluster::mean(self : DbstoretensorCluster) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorCluster::scale(self : DbstoretensorCluster, f : Double) -> DbstoretensorCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorCluster::add(self : DbstoretensorCluster, other : DbstoretensorCluster) -> DbstoretensorCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorCluster::copy(self : DbstoretensorCluster) -> DbstoretensorCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorCluster::fill(self : DbstoretensorCluster, v : Double) -> DbstoretensorCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorCluster::min(self : DbstoretensorCluster) -> Double { @_common.min(self.data) }

pub fn DbstoretensorCluster::max(self : DbstoretensorCluster) -> Double { @_common.max(self.data) }

pub fn DbstoretensorCluster::to_string(self : DbstoretensorCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_model_make(size : Int) -> DbstoretensorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorModel::len(self : DbstoretensorModel) -> Int { self.size }

pub fn DbstoretensorModel::get(self : DbstoretensorModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorModel::set(self : DbstoretensorModel, i : Int, v : Double) -> DbstoretensorModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorModel::sum(self : DbstoretensorModel) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorModel::mean(self : DbstoretensorModel) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorModel::scale(self : DbstoretensorModel, f : Double) -> DbstoretensorModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorModel::add(self : DbstoretensorModel, other : DbstoretensorModel) -> DbstoretensorModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorModel::copy(self : DbstoretensorModel) -> DbstoretensorModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorModel::fill(self : DbstoretensorModel, v : Double) -> DbstoretensorModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorModel::min(self : DbstoretensorModel) -> Double { @_common.min(self.data) }

pub fn DbstoretensorModel::max(self : DbstoretensorModel) -> Double { @_common.max(self.data) }

pub fn DbstoretensorModel::to_string(self : DbstoretensorModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_layer_make(size : Int) -> DbstoretensorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorLayer::len(self : DbstoretensorLayer) -> Int { self.size }

pub fn DbstoretensorLayer::get(self : DbstoretensorLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorLayer::set(self : DbstoretensorLayer, i : Int, v : Double) -> DbstoretensorLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorLayer::sum(self : DbstoretensorLayer) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorLayer::mean(self : DbstoretensorLayer) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorLayer::scale(self : DbstoretensorLayer, f : Double) -> DbstoretensorLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorLayer::add(self : DbstoretensorLayer, other : DbstoretensorLayer) -> DbstoretensorLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorLayer::copy(self : DbstoretensorLayer) -> DbstoretensorLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorLayer::fill(self : DbstoretensorLayer, v : Double) -> DbstoretensorLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorLayer::min(self : DbstoretensorLayer) -> Double { @_common.min(self.data) }

pub fn DbstoretensorLayer::max(self : DbstoretensorLayer) -> Double { @_common.max(self.data) }

pub fn DbstoretensorLayer::to_string(self : DbstoretensorLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_buffer_make(size : Int) -> DbstoretensorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorBuffer::len(self : DbstoretensorBuffer) -> Int { self.size }

pub fn DbstoretensorBuffer::get(self : DbstoretensorBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorBuffer::set(self : DbstoretensorBuffer, i : Int, v : Double) -> DbstoretensorBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorBuffer::sum(self : DbstoretensorBuffer) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorBuffer::mean(self : DbstoretensorBuffer) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorBuffer::scale(self : DbstoretensorBuffer, f : Double) -> DbstoretensorBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorBuffer::add(self : DbstoretensorBuffer, other : DbstoretensorBuffer) -> DbstoretensorBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorBuffer::copy(self : DbstoretensorBuffer) -> DbstoretensorBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorBuffer::fill(self : DbstoretensorBuffer, v : Double) -> DbstoretensorBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorBuffer::min(self : DbstoretensorBuffer) -> Double { @_common.min(self.data) }

pub fn DbstoretensorBuffer::max(self : DbstoretensorBuffer) -> Double { @_common.max(self.data) }

pub fn DbstoretensorBuffer::to_string(self : DbstoretensorBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_cursor_make(size : Int) -> DbstoretensorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorCursor::len(self : DbstoretensorCursor) -> Int { self.size }

pub fn DbstoretensorCursor::get(self : DbstoretensorCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorCursor::set(self : DbstoretensorCursor, i : Int, v : Double) -> DbstoretensorCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorCursor::sum(self : DbstoretensorCursor) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorCursor::mean(self : DbstoretensorCursor) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorCursor::scale(self : DbstoretensorCursor, f : Double) -> DbstoretensorCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorCursor::add(self : DbstoretensorCursor, other : DbstoretensorCursor) -> DbstoretensorCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorCursor::copy(self : DbstoretensorCursor) -> DbstoretensorCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorCursor::fill(self : DbstoretensorCursor, v : Double) -> DbstoretensorCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorCursor::min(self : DbstoretensorCursor) -> Double { @_common.min(self.data) }

pub fn DbstoretensorCursor::max(self : DbstoretensorCursor) -> Double { @_common.max(self.data) }

pub fn DbstoretensorCursor::to_string(self : DbstoretensorCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_view_make(size : Int) -> DbstoretensorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorView::len(self : DbstoretensorView) -> Int { self.size }

pub fn DbstoretensorView::get(self : DbstoretensorView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorView::set(self : DbstoretensorView, i : Int, v : Double) -> DbstoretensorView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorView::sum(self : DbstoretensorView) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorView::mean(self : DbstoretensorView) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorView::scale(self : DbstoretensorView, f : Double) -> DbstoretensorView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorView::add(self : DbstoretensorView, other : DbstoretensorView) -> DbstoretensorView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorView::copy(self : DbstoretensorView) -> DbstoretensorView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorView::fill(self : DbstoretensorView, v : Double) -> DbstoretensorView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorView::min(self : DbstoretensorView) -> Double { @_common.min(self.data) }

pub fn DbstoretensorView::max(self : DbstoretensorView) -> Double { @_common.max(self.data) }

pub fn DbstoretensorView::to_string(self : DbstoretensorView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_range_make(size : Int) -> DbstoretensorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorRange::len(self : DbstoretensorRange) -> Int { self.size }

pub fn DbstoretensorRange::get(self : DbstoretensorRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorRange::set(self : DbstoretensorRange, i : Int, v : Double) -> DbstoretensorRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorRange::sum(self : DbstoretensorRange) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorRange::mean(self : DbstoretensorRange) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorRange::scale(self : DbstoretensorRange, f : Double) -> DbstoretensorRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorRange::add(self : DbstoretensorRange, other : DbstoretensorRange) -> DbstoretensorRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorRange::copy(self : DbstoretensorRange) -> DbstoretensorRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorRange::fill(self : DbstoretensorRange, v : Double) -> DbstoretensorRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorRange::min(self : DbstoretensorRange) -> Double { @_common.min(self.data) }

pub fn DbstoretensorRange::max(self : DbstoretensorRange) -> Double { @_common.max(self.data) }

pub fn DbstoretensorRange::to_string(self : DbstoretensorRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretensorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_slice_make(size : Int) -> DbstoretensorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretensorSlice::len(self : DbstoretensorSlice) -> Int { self.size }

pub fn DbstoretensorSlice::get(self : DbstoretensorSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretensorSlice::set(self : DbstoretensorSlice, i : Int, v : Double) -> DbstoretensorSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretensorSlice::sum(self : DbstoretensorSlice) -> Double { @_common.sum(self.data) }

pub fn DbstoretensorSlice::mean(self : DbstoretensorSlice) -> Double { @_common.mean(self.data) }

pub fn DbstoretensorSlice::scale(self : DbstoretensorSlice, f : Double) -> DbstoretensorSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretensorSlice::add(self : DbstoretensorSlice, other : DbstoretensorSlice) -> DbstoretensorSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretensorSlice::copy(self : DbstoretensorSlice) -> DbstoretensorSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretensorSlice::fill(self : DbstoretensorSlice, v : Double) -> DbstoretensorSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretensorSlice::min(self : DbstoretensorSlice) -> Double { @_common.min(self.data) }

pub fn DbstoretensorSlice::max(self : DbstoretensorSlice) -> Double { @_common.max(self.data) }

pub fn DbstoretensorSlice::to_string(self : DbstoretensorSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

