///===
/// extcore/db_tx_mvcc

pub(all) struct DbtxmvccPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_mvcc_make_point(x : Double, y : Double) -> DbtxmvccPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_mvcc_make_point3(x : Double, y : Double, z : Double) -> DbtxmvccPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxmvccPoint::x(self : DbtxmvccPoint) -> Double { self.x }

pub fn DbtxmvccPoint::y(self : DbtxmvccPoint) -> Double { self.y }

pub fn DbtxmvccPoint::z(self : DbtxmvccPoint) -> Double { self.z }

pub fn DbtxmvccPoint::label(self : DbtxmvccPoint) -> Int { self.label }

pub fn DbtxmvccPoint::dist(self : DbtxmvccPoint, other : DbtxmvccPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxmvccPoint::add(self : DbtxmvccPoint, other : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxmvccPoint::sub(self : DbtxmvccPoint, other : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxmvccPoint::scale(self : DbtxmvccPoint, s : Double) -> DbtxmvccPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxmvccPoint::dot(self : DbtxmvccPoint, other : DbtxmvccPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxmvccPoint::cross(self : DbtxmvccPoint, other : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxmvccPoint::norm(self : DbtxmvccPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxmvccPoint::normalize(self : DbtxmvccPoint) -> DbtxmvccPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxmvccPoint::negate(self : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxmvccPoint::mid(self : DbtxmvccPoint, other : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxmvccPoint::lerp(self : DbtxmvccPoint, other : DbtxmvccPoint, t : Double) -> DbtxmvccPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxmvccPoint::to_string(self : DbtxmvccPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxmvccSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_mvcc_make_series(vals : Array[Double], name : String) -> DbtxmvccSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxmvccSeries::len(self : DbtxmvccSeries) -> Int { self.vals.length() }

pub fn DbtxmvccSeries::sum(self : DbtxmvccSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxmvccSeries::mean(self : DbtxmvccSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxmvccSeries::min(self : DbtxmvccSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxmvccSeries::max(self : DbtxmvccSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxmvccSeries::range(self : DbtxmvccSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxmvccSeries::variance(self : DbtxmvccSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxmvccSeries::std(self : DbtxmvccSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxmvccSeries::median(self : DbtxmvccSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxmvccSeries::scale(self : DbtxmvccSeries, f : Double) -> DbtxmvccSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxmvccSeries::add(self : DbtxmvccSeries, other : DbtxmvccSeries) -> DbtxmvccSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxmvccSeries::sub(self : DbtxmvccSeries, other : DbtxmvccSeries) -> DbtxmvccSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxmvccSeries::normalize(self : DbtxmvccSeries) -> DbtxmvccSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxmvccSeries::cumsum(self : DbtxmvccSeries) -> DbtxmvccSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxmvccSeries::to_string(self : DbtxmvccSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxmvccMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_mvcc_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxmvccMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_mvcc_matrix_identity(n : Int) -> DbtxmvccMatrix {
  let m = db_tx_mvcc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxmvccMatrix::get(self : DbtxmvccMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxmvccMatrix::transpose(self : DbtxmvccMatrix) -> DbtxmvccMatrix {
  let result = db_tx_mvcc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxmvccMatrix::add(self : DbtxmvccMatrix, other : DbtxmvccMatrix) -> DbtxmvccMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_mvcc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxmvccMatrix::scale(self : DbtxmvccMatrix, s : Double) -> DbtxmvccMatrix {
  let result = db_tx_mvcc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxmvccMatrix::multiply(self : DbtxmvccMatrix, other : DbtxmvccMatrix) -> DbtxmvccMatrix {
  if self.cols != other.rows { return db_tx_mvcc_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_mvcc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbtxmvccMatrix::trace(self : DbtxmvccMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxmvccMatrix::det(self : DbtxmvccMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxmvccMatrix::norm(self : DbtxmvccMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxmvccMatrix::to_string(self : DbtxmvccMatrix) -> String {
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

pub(all) struct DbtxmvccVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_mvcc_make_vector(comps : Array[Double]) -> DbtxmvccVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_mvcc_vector_zero(dim : Int) -> DbtxmvccVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxmvccVector::add(self : DbtxmvccVector, other : DbtxmvccVector) -> DbtxmvccVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxmvccVector::sub(self : DbtxmvccVector, other : DbtxmvccVector) -> DbtxmvccVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxmvccVector::scale(self : DbtxmvccVector, s : Double) -> DbtxmvccVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxmvccVector::dot(self : DbtxmvccVector, other : DbtxmvccVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxmvccVector::norm(self : DbtxmvccVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxmvccVector::normalize(self : DbtxmvccVector) -> DbtxmvccVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxmvccVector::dist(self : DbtxmvccVector, other : DbtxmvccVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxmvccVector::to_string(self : DbtxmvccVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxmvccFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_frame_make(size : Int) -> DbtxmvccFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccFrame::len(self : DbtxmvccFrame) -> Int { self.size }

pub fn DbtxmvccFrame::get(self : DbtxmvccFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccFrame::set(self : DbtxmvccFrame, i : Int, v : Double) -> DbtxmvccFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccFrame::sum(self : DbtxmvccFrame) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccFrame::mean(self : DbtxmvccFrame) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccFrame::scale(self : DbtxmvccFrame, f : Double) -> DbtxmvccFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccFrame::add(self : DbtxmvccFrame, other : DbtxmvccFrame) -> DbtxmvccFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccFrame::copy(self : DbtxmvccFrame) -> DbtxmvccFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccFrame::fill(self : DbtxmvccFrame, v : Double) -> DbtxmvccFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccFrame::min(self : DbtxmvccFrame) -> Double { @_common.min(self.data) }

pub fn DbtxmvccFrame::max(self : DbtxmvccFrame) -> Double { @_common.max(self.data) }

pub fn DbtxmvccFrame::to_string(self : DbtxmvccFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_table_make(size : Int) -> DbtxmvccTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccTable::len(self : DbtxmvccTable) -> Int { self.size }

pub fn DbtxmvccTable::get(self : DbtxmvccTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccTable::set(self : DbtxmvccTable, i : Int, v : Double) -> DbtxmvccTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccTable::sum(self : DbtxmvccTable) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccTable::mean(self : DbtxmvccTable) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccTable::scale(self : DbtxmvccTable, f : Double) -> DbtxmvccTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccTable::add(self : DbtxmvccTable, other : DbtxmvccTable) -> DbtxmvccTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccTable::copy(self : DbtxmvccTable) -> DbtxmvccTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccTable::fill(self : DbtxmvccTable, v : Double) -> DbtxmvccTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccTable::min(self : DbtxmvccTable) -> Double { @_common.min(self.data) }

pub fn DbtxmvccTable::max(self : DbtxmvccTable) -> Double { @_common.max(self.data) }

pub fn DbtxmvccTable::to_string(self : DbtxmvccTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_graphn_make(size : Int) -> DbtxmvccGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccGraphN::len(self : DbtxmvccGraphN) -> Int { self.size }

pub fn DbtxmvccGraphN::get(self : DbtxmvccGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccGraphN::set(self : DbtxmvccGraphN, i : Int, v : Double) -> DbtxmvccGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccGraphN::sum(self : DbtxmvccGraphN) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccGraphN::mean(self : DbtxmvccGraphN) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccGraphN::scale(self : DbtxmvccGraphN, f : Double) -> DbtxmvccGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccGraphN::add(self : DbtxmvccGraphN, other : DbtxmvccGraphN) -> DbtxmvccGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccGraphN::copy(self : DbtxmvccGraphN) -> DbtxmvccGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccGraphN::fill(self : DbtxmvccGraphN, v : Double) -> DbtxmvccGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccGraphN::min(self : DbtxmvccGraphN) -> Double { @_common.min(self.data) }

pub fn DbtxmvccGraphN::max(self : DbtxmvccGraphN) -> Double { @_common.max(self.data) }

pub fn DbtxmvccGraphN::to_string(self : DbtxmvccGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_node_make(size : Int) -> DbtxmvccNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccNode::len(self : DbtxmvccNode) -> Int { self.size }

pub fn DbtxmvccNode::get(self : DbtxmvccNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccNode::set(self : DbtxmvccNode, i : Int, v : Double) -> DbtxmvccNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccNode::sum(self : DbtxmvccNode) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccNode::mean(self : DbtxmvccNode) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccNode::scale(self : DbtxmvccNode, f : Double) -> DbtxmvccNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccNode::add(self : DbtxmvccNode, other : DbtxmvccNode) -> DbtxmvccNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccNode::copy(self : DbtxmvccNode) -> DbtxmvccNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccNode::fill(self : DbtxmvccNode, v : Double) -> DbtxmvccNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccNode::min(self : DbtxmvccNode) -> Double { @_common.min(self.data) }

pub fn DbtxmvccNode::max(self : DbtxmvccNode) -> Double { @_common.max(self.data) }

pub fn DbtxmvccNode::to_string(self : DbtxmvccNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_edge_make(size : Int) -> DbtxmvccEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccEdge::len(self : DbtxmvccEdge) -> Int { self.size }

pub fn DbtxmvccEdge::get(self : DbtxmvccEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccEdge::set(self : DbtxmvccEdge, i : Int, v : Double) -> DbtxmvccEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccEdge::sum(self : DbtxmvccEdge) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccEdge::mean(self : DbtxmvccEdge) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccEdge::scale(self : DbtxmvccEdge, f : Double) -> DbtxmvccEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccEdge::add(self : DbtxmvccEdge, other : DbtxmvccEdge) -> DbtxmvccEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccEdge::copy(self : DbtxmvccEdge) -> DbtxmvccEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccEdge::fill(self : DbtxmvccEdge, v : Double) -> DbtxmvccEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccEdge::min(self : DbtxmvccEdge) -> Double { @_common.min(self.data) }

pub fn DbtxmvccEdge::max(self : DbtxmvccEdge) -> Double { @_common.max(self.data) }

pub fn DbtxmvccEdge::to_string(self : DbtxmvccEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_path_make(size : Int) -> DbtxmvccPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccPath::len(self : DbtxmvccPath) -> Int { self.size }

pub fn DbtxmvccPath::get(self : DbtxmvccPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccPath::set(self : DbtxmvccPath, i : Int, v : Double) -> DbtxmvccPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccPath::sum(self : DbtxmvccPath) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccPath::mean(self : DbtxmvccPath) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccPath::scale(self : DbtxmvccPath, f : Double) -> DbtxmvccPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccPath::add(self : DbtxmvccPath, other : DbtxmvccPath) -> DbtxmvccPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccPath::copy(self : DbtxmvccPath) -> DbtxmvccPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccPath::fill(self : DbtxmvccPath, v : Double) -> DbtxmvccPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccPath::min(self : DbtxmvccPath) -> Double { @_common.min(self.data) }

pub fn DbtxmvccPath::max(self : DbtxmvccPath) -> Double { @_common.max(self.data) }

pub fn DbtxmvccPath::to_string(self : DbtxmvccPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_cluster_make(size : Int) -> DbtxmvccCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccCluster::len(self : DbtxmvccCluster) -> Int { self.size }

pub fn DbtxmvccCluster::get(self : DbtxmvccCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccCluster::set(self : DbtxmvccCluster, i : Int, v : Double) -> DbtxmvccCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccCluster::sum(self : DbtxmvccCluster) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccCluster::mean(self : DbtxmvccCluster) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccCluster::scale(self : DbtxmvccCluster, f : Double) -> DbtxmvccCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccCluster::add(self : DbtxmvccCluster, other : DbtxmvccCluster) -> DbtxmvccCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccCluster::copy(self : DbtxmvccCluster) -> DbtxmvccCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccCluster::fill(self : DbtxmvccCluster, v : Double) -> DbtxmvccCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccCluster::min(self : DbtxmvccCluster) -> Double { @_common.min(self.data) }

pub fn DbtxmvccCluster::max(self : DbtxmvccCluster) -> Double { @_common.max(self.data) }

pub fn DbtxmvccCluster::to_string(self : DbtxmvccCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_model_make(size : Int) -> DbtxmvccModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccModel::len(self : DbtxmvccModel) -> Int { self.size }

pub fn DbtxmvccModel::get(self : DbtxmvccModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccModel::set(self : DbtxmvccModel, i : Int, v : Double) -> DbtxmvccModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccModel::sum(self : DbtxmvccModel) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccModel::mean(self : DbtxmvccModel) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccModel::scale(self : DbtxmvccModel, f : Double) -> DbtxmvccModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccModel::add(self : DbtxmvccModel, other : DbtxmvccModel) -> DbtxmvccModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccModel::copy(self : DbtxmvccModel) -> DbtxmvccModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccModel::fill(self : DbtxmvccModel, v : Double) -> DbtxmvccModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccModel::min(self : DbtxmvccModel) -> Double { @_common.min(self.data) }

pub fn DbtxmvccModel::max(self : DbtxmvccModel) -> Double { @_common.max(self.data) }

pub fn DbtxmvccModel::to_string(self : DbtxmvccModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_layer_make(size : Int) -> DbtxmvccLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccLayer::len(self : DbtxmvccLayer) -> Int { self.size }

pub fn DbtxmvccLayer::get(self : DbtxmvccLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccLayer::set(self : DbtxmvccLayer, i : Int, v : Double) -> DbtxmvccLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccLayer::sum(self : DbtxmvccLayer) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccLayer::mean(self : DbtxmvccLayer) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccLayer::scale(self : DbtxmvccLayer, f : Double) -> DbtxmvccLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccLayer::add(self : DbtxmvccLayer, other : DbtxmvccLayer) -> DbtxmvccLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccLayer::copy(self : DbtxmvccLayer) -> DbtxmvccLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccLayer::fill(self : DbtxmvccLayer, v : Double) -> DbtxmvccLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccLayer::min(self : DbtxmvccLayer) -> Double { @_common.min(self.data) }

pub fn DbtxmvccLayer::max(self : DbtxmvccLayer) -> Double { @_common.max(self.data) }

pub fn DbtxmvccLayer::to_string(self : DbtxmvccLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_buffer_make(size : Int) -> DbtxmvccBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccBuffer::len(self : DbtxmvccBuffer) -> Int { self.size }

pub fn DbtxmvccBuffer::get(self : DbtxmvccBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccBuffer::set(self : DbtxmvccBuffer, i : Int, v : Double) -> DbtxmvccBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccBuffer::sum(self : DbtxmvccBuffer) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccBuffer::mean(self : DbtxmvccBuffer) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccBuffer::scale(self : DbtxmvccBuffer, f : Double) -> DbtxmvccBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccBuffer::add(self : DbtxmvccBuffer, other : DbtxmvccBuffer) -> DbtxmvccBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccBuffer::copy(self : DbtxmvccBuffer) -> DbtxmvccBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccBuffer::fill(self : DbtxmvccBuffer, v : Double) -> DbtxmvccBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccBuffer::min(self : DbtxmvccBuffer) -> Double { @_common.min(self.data) }

pub fn DbtxmvccBuffer::max(self : DbtxmvccBuffer) -> Double { @_common.max(self.data) }

pub fn DbtxmvccBuffer::to_string(self : DbtxmvccBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_cursor_make(size : Int) -> DbtxmvccCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccCursor::len(self : DbtxmvccCursor) -> Int { self.size }

pub fn DbtxmvccCursor::get(self : DbtxmvccCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccCursor::set(self : DbtxmvccCursor, i : Int, v : Double) -> DbtxmvccCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccCursor::sum(self : DbtxmvccCursor) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccCursor::mean(self : DbtxmvccCursor) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccCursor::scale(self : DbtxmvccCursor, f : Double) -> DbtxmvccCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccCursor::add(self : DbtxmvccCursor, other : DbtxmvccCursor) -> DbtxmvccCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccCursor::copy(self : DbtxmvccCursor) -> DbtxmvccCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccCursor::fill(self : DbtxmvccCursor, v : Double) -> DbtxmvccCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccCursor::min(self : DbtxmvccCursor) -> Double { @_common.min(self.data) }

pub fn DbtxmvccCursor::max(self : DbtxmvccCursor) -> Double { @_common.max(self.data) }

pub fn DbtxmvccCursor::to_string(self : DbtxmvccCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_view_make(size : Int) -> DbtxmvccView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccView::len(self : DbtxmvccView) -> Int { self.size }

pub fn DbtxmvccView::get(self : DbtxmvccView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccView::set(self : DbtxmvccView, i : Int, v : Double) -> DbtxmvccView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccView::sum(self : DbtxmvccView) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccView::mean(self : DbtxmvccView) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccView::scale(self : DbtxmvccView, f : Double) -> DbtxmvccView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccView::add(self : DbtxmvccView, other : DbtxmvccView) -> DbtxmvccView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccView::copy(self : DbtxmvccView) -> DbtxmvccView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccView::fill(self : DbtxmvccView, v : Double) -> DbtxmvccView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccView::min(self : DbtxmvccView) -> Double { @_common.min(self.data) }

pub fn DbtxmvccView::max(self : DbtxmvccView) -> Double { @_common.max(self.data) }

pub fn DbtxmvccView::to_string(self : DbtxmvccView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_range_make(size : Int) -> DbtxmvccRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccRange::len(self : DbtxmvccRange) -> Int { self.size }

pub fn DbtxmvccRange::get(self : DbtxmvccRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccRange::set(self : DbtxmvccRange, i : Int, v : Double) -> DbtxmvccRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccRange::sum(self : DbtxmvccRange) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccRange::mean(self : DbtxmvccRange) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccRange::scale(self : DbtxmvccRange, f : Double) -> DbtxmvccRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccRange::add(self : DbtxmvccRange, other : DbtxmvccRange) -> DbtxmvccRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccRange::copy(self : DbtxmvccRange) -> DbtxmvccRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccRange::fill(self : DbtxmvccRange, v : Double) -> DbtxmvccRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccRange::min(self : DbtxmvccRange) -> Double { @_common.min(self.data) }

pub fn DbtxmvccRange::max(self : DbtxmvccRange) -> Double { @_common.max(self.data) }

pub fn DbtxmvccRange::to_string(self : DbtxmvccRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxmvccSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_slice_make(size : Int) -> DbtxmvccSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxmvccSlice::len(self : DbtxmvccSlice) -> Int { self.size }

pub fn DbtxmvccSlice::get(self : DbtxmvccSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxmvccSlice::set(self : DbtxmvccSlice, i : Int, v : Double) -> DbtxmvccSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxmvccSlice::sum(self : DbtxmvccSlice) -> Double { @_common.sum(self.data) }

pub fn DbtxmvccSlice::mean(self : DbtxmvccSlice) -> Double { @_common.mean(self.data) }

pub fn DbtxmvccSlice::scale(self : DbtxmvccSlice, f : Double) -> DbtxmvccSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxmvccSlice::add(self : DbtxmvccSlice, other : DbtxmvccSlice) -> DbtxmvccSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxmvccSlice::copy(self : DbtxmvccSlice) -> DbtxmvccSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxmvccSlice::fill(self : DbtxmvccSlice, v : Double) -> DbtxmvccSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxmvccSlice::min(self : DbtxmvccSlice) -> Double { @_common.min(self.data) }

pub fn DbtxmvccSlice::max(self : DbtxmvccSlice) -> Double { @_common.max(self.data) }

pub fn DbtxmvccSlice::to_string(self : DbtxmvccSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

