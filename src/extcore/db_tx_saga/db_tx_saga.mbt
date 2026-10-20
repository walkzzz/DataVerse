///===
/// extcore/db_tx_saga

pub(all) struct DbtxsagaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_saga_make_point(x : Double, y : Double) -> DbtxsagaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_saga_make_point3(x : Double, y : Double, z : Double) -> DbtxsagaPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxsagaPoint::x(self : DbtxsagaPoint) -> Double { self.x }

pub fn DbtxsagaPoint::y(self : DbtxsagaPoint) -> Double { self.y }

pub fn DbtxsagaPoint::z(self : DbtxsagaPoint) -> Double { self.z }

pub fn DbtxsagaPoint::label(self : DbtxsagaPoint) -> Int { self.label }

pub fn DbtxsagaPoint::dist(self : DbtxsagaPoint, other : DbtxsagaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxsagaPoint::add(self : DbtxsagaPoint, other : DbtxsagaPoint) -> DbtxsagaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxsagaPoint::sub(self : DbtxsagaPoint, other : DbtxsagaPoint) -> DbtxsagaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxsagaPoint::scale(self : DbtxsagaPoint, s : Double) -> DbtxsagaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxsagaPoint::dot(self : DbtxsagaPoint, other : DbtxsagaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxsagaPoint::cross(self : DbtxsagaPoint, other : DbtxsagaPoint) -> DbtxsagaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxsagaPoint::norm(self : DbtxsagaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxsagaPoint::normalize(self : DbtxsagaPoint) -> DbtxsagaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxsagaPoint::negate(self : DbtxsagaPoint) -> DbtxsagaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxsagaPoint::mid(self : DbtxsagaPoint, other : DbtxsagaPoint) -> DbtxsagaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxsagaPoint::lerp(self : DbtxsagaPoint, other : DbtxsagaPoint, t : Double) -> DbtxsagaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxsagaPoint::to_string(self : DbtxsagaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxsagaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_saga_make_series(vals : Array[Double], name : String) -> DbtxsagaSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxsagaSeries::len(self : DbtxsagaSeries) -> Int { self.vals.length() }

pub fn DbtxsagaSeries::sum(self : DbtxsagaSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxsagaSeries::mean(self : DbtxsagaSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxsagaSeries::min(self : DbtxsagaSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxsagaSeries::max(self : DbtxsagaSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxsagaSeries::range(self : DbtxsagaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxsagaSeries::variance(self : DbtxsagaSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxsagaSeries::std(self : DbtxsagaSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxsagaSeries::median(self : DbtxsagaSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxsagaSeries::scale(self : DbtxsagaSeries, f : Double) -> DbtxsagaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxsagaSeries::add(self : DbtxsagaSeries, other : DbtxsagaSeries) -> DbtxsagaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxsagaSeries::sub(self : DbtxsagaSeries, other : DbtxsagaSeries) -> DbtxsagaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxsagaSeries::normalize(self : DbtxsagaSeries) -> DbtxsagaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxsagaSeries::cumsum(self : DbtxsagaSeries) -> DbtxsagaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxsagaSeries::to_string(self : DbtxsagaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxsagaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_saga_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxsagaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_saga_matrix_identity(n : Int) -> DbtxsagaMatrix {
  let m = db_tx_saga_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxsagaMatrix::get(self : DbtxsagaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxsagaMatrix::transpose(self : DbtxsagaMatrix) -> DbtxsagaMatrix {
  let result = db_tx_saga_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxsagaMatrix::add(self : DbtxsagaMatrix, other : DbtxsagaMatrix) -> DbtxsagaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_saga_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxsagaMatrix::scale(self : DbtxsagaMatrix, s : Double) -> DbtxsagaMatrix {
  let result = db_tx_saga_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxsagaMatrix::multiply(self : DbtxsagaMatrix, other : DbtxsagaMatrix) -> DbtxsagaMatrix {
  if self.cols != other.rows { return db_tx_saga_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_saga_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbtxsagaMatrix::trace(self : DbtxsagaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxsagaMatrix::det(self : DbtxsagaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxsagaMatrix::norm(self : DbtxsagaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxsagaMatrix::to_string(self : DbtxsagaMatrix) -> String {
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

pub(all) struct DbtxsagaVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_saga_make_vector(comps : Array[Double]) -> DbtxsagaVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_saga_vector_zero(dim : Int) -> DbtxsagaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxsagaVector::add(self : DbtxsagaVector, other : DbtxsagaVector) -> DbtxsagaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxsagaVector::sub(self : DbtxsagaVector, other : DbtxsagaVector) -> DbtxsagaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxsagaVector::scale(self : DbtxsagaVector, s : Double) -> DbtxsagaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxsagaVector::dot(self : DbtxsagaVector, other : DbtxsagaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxsagaVector::norm(self : DbtxsagaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxsagaVector::normalize(self : DbtxsagaVector) -> DbtxsagaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxsagaVector::dist(self : DbtxsagaVector, other : DbtxsagaVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxsagaVector::to_string(self : DbtxsagaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxsagaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_frame_make(size : Int) -> DbtxsagaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaFrame::len(self : DbtxsagaFrame) -> Int { self.size }

pub fn DbtxsagaFrame::get(self : DbtxsagaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaFrame::set(self : DbtxsagaFrame, i : Int, v : Double) -> DbtxsagaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaFrame::sum(self : DbtxsagaFrame) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaFrame::mean(self : DbtxsagaFrame) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaFrame::scale(self : DbtxsagaFrame, f : Double) -> DbtxsagaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaFrame::add(self : DbtxsagaFrame, other : DbtxsagaFrame) -> DbtxsagaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaFrame::copy(self : DbtxsagaFrame) -> DbtxsagaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaFrame::fill(self : DbtxsagaFrame, v : Double) -> DbtxsagaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaFrame::min(self : DbtxsagaFrame) -> Double { @_common.min(self.data) }

pub fn DbtxsagaFrame::max(self : DbtxsagaFrame) -> Double { @_common.max(self.data) }

pub fn DbtxsagaFrame::to_string(self : DbtxsagaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_table_make(size : Int) -> DbtxsagaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaTable::len(self : DbtxsagaTable) -> Int { self.size }

pub fn DbtxsagaTable::get(self : DbtxsagaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaTable::set(self : DbtxsagaTable, i : Int, v : Double) -> DbtxsagaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaTable::sum(self : DbtxsagaTable) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaTable::mean(self : DbtxsagaTable) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaTable::scale(self : DbtxsagaTable, f : Double) -> DbtxsagaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaTable::add(self : DbtxsagaTable, other : DbtxsagaTable) -> DbtxsagaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaTable::copy(self : DbtxsagaTable) -> DbtxsagaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaTable::fill(self : DbtxsagaTable, v : Double) -> DbtxsagaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaTable::min(self : DbtxsagaTable) -> Double { @_common.min(self.data) }

pub fn DbtxsagaTable::max(self : DbtxsagaTable) -> Double { @_common.max(self.data) }

pub fn DbtxsagaTable::to_string(self : DbtxsagaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_graphn_make(size : Int) -> DbtxsagaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaGraphN::len(self : DbtxsagaGraphN) -> Int { self.size }

pub fn DbtxsagaGraphN::get(self : DbtxsagaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaGraphN::set(self : DbtxsagaGraphN, i : Int, v : Double) -> DbtxsagaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaGraphN::sum(self : DbtxsagaGraphN) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaGraphN::mean(self : DbtxsagaGraphN) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaGraphN::scale(self : DbtxsagaGraphN, f : Double) -> DbtxsagaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaGraphN::add(self : DbtxsagaGraphN, other : DbtxsagaGraphN) -> DbtxsagaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaGraphN::copy(self : DbtxsagaGraphN) -> DbtxsagaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaGraphN::fill(self : DbtxsagaGraphN, v : Double) -> DbtxsagaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaGraphN::min(self : DbtxsagaGraphN) -> Double { @_common.min(self.data) }

pub fn DbtxsagaGraphN::max(self : DbtxsagaGraphN) -> Double { @_common.max(self.data) }

pub fn DbtxsagaGraphN::to_string(self : DbtxsagaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_node_make(size : Int) -> DbtxsagaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaNode::len(self : DbtxsagaNode) -> Int { self.size }

pub fn DbtxsagaNode::get(self : DbtxsagaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaNode::set(self : DbtxsagaNode, i : Int, v : Double) -> DbtxsagaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaNode::sum(self : DbtxsagaNode) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaNode::mean(self : DbtxsagaNode) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaNode::scale(self : DbtxsagaNode, f : Double) -> DbtxsagaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaNode::add(self : DbtxsagaNode, other : DbtxsagaNode) -> DbtxsagaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaNode::copy(self : DbtxsagaNode) -> DbtxsagaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaNode::fill(self : DbtxsagaNode, v : Double) -> DbtxsagaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaNode::min(self : DbtxsagaNode) -> Double { @_common.min(self.data) }

pub fn DbtxsagaNode::max(self : DbtxsagaNode) -> Double { @_common.max(self.data) }

pub fn DbtxsagaNode::to_string(self : DbtxsagaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_edge_make(size : Int) -> DbtxsagaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaEdge::len(self : DbtxsagaEdge) -> Int { self.size }

pub fn DbtxsagaEdge::get(self : DbtxsagaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaEdge::set(self : DbtxsagaEdge, i : Int, v : Double) -> DbtxsagaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaEdge::sum(self : DbtxsagaEdge) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaEdge::mean(self : DbtxsagaEdge) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaEdge::scale(self : DbtxsagaEdge, f : Double) -> DbtxsagaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaEdge::add(self : DbtxsagaEdge, other : DbtxsagaEdge) -> DbtxsagaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaEdge::copy(self : DbtxsagaEdge) -> DbtxsagaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaEdge::fill(self : DbtxsagaEdge, v : Double) -> DbtxsagaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaEdge::min(self : DbtxsagaEdge) -> Double { @_common.min(self.data) }

pub fn DbtxsagaEdge::max(self : DbtxsagaEdge) -> Double { @_common.max(self.data) }

pub fn DbtxsagaEdge::to_string(self : DbtxsagaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_path_make(size : Int) -> DbtxsagaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaPath::len(self : DbtxsagaPath) -> Int { self.size }

pub fn DbtxsagaPath::get(self : DbtxsagaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaPath::set(self : DbtxsagaPath, i : Int, v : Double) -> DbtxsagaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaPath::sum(self : DbtxsagaPath) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaPath::mean(self : DbtxsagaPath) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaPath::scale(self : DbtxsagaPath, f : Double) -> DbtxsagaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaPath::add(self : DbtxsagaPath, other : DbtxsagaPath) -> DbtxsagaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaPath::copy(self : DbtxsagaPath) -> DbtxsagaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaPath::fill(self : DbtxsagaPath, v : Double) -> DbtxsagaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaPath::min(self : DbtxsagaPath) -> Double { @_common.min(self.data) }

pub fn DbtxsagaPath::max(self : DbtxsagaPath) -> Double { @_common.max(self.data) }

pub fn DbtxsagaPath::to_string(self : DbtxsagaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_cluster_make(size : Int) -> DbtxsagaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaCluster::len(self : DbtxsagaCluster) -> Int { self.size }

pub fn DbtxsagaCluster::get(self : DbtxsagaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaCluster::set(self : DbtxsagaCluster, i : Int, v : Double) -> DbtxsagaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaCluster::sum(self : DbtxsagaCluster) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaCluster::mean(self : DbtxsagaCluster) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaCluster::scale(self : DbtxsagaCluster, f : Double) -> DbtxsagaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaCluster::add(self : DbtxsagaCluster, other : DbtxsagaCluster) -> DbtxsagaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaCluster::copy(self : DbtxsagaCluster) -> DbtxsagaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaCluster::fill(self : DbtxsagaCluster, v : Double) -> DbtxsagaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaCluster::min(self : DbtxsagaCluster) -> Double { @_common.min(self.data) }

pub fn DbtxsagaCluster::max(self : DbtxsagaCluster) -> Double { @_common.max(self.data) }

pub fn DbtxsagaCluster::to_string(self : DbtxsagaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_model_make(size : Int) -> DbtxsagaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaModel::len(self : DbtxsagaModel) -> Int { self.size }

pub fn DbtxsagaModel::get(self : DbtxsagaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaModel::set(self : DbtxsagaModel, i : Int, v : Double) -> DbtxsagaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaModel::sum(self : DbtxsagaModel) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaModel::mean(self : DbtxsagaModel) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaModel::scale(self : DbtxsagaModel, f : Double) -> DbtxsagaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaModel::add(self : DbtxsagaModel, other : DbtxsagaModel) -> DbtxsagaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaModel::copy(self : DbtxsagaModel) -> DbtxsagaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaModel::fill(self : DbtxsagaModel, v : Double) -> DbtxsagaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaModel::min(self : DbtxsagaModel) -> Double { @_common.min(self.data) }

pub fn DbtxsagaModel::max(self : DbtxsagaModel) -> Double { @_common.max(self.data) }

pub fn DbtxsagaModel::to_string(self : DbtxsagaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_layer_make(size : Int) -> DbtxsagaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaLayer::len(self : DbtxsagaLayer) -> Int { self.size }

pub fn DbtxsagaLayer::get(self : DbtxsagaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaLayer::set(self : DbtxsagaLayer, i : Int, v : Double) -> DbtxsagaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaLayer::sum(self : DbtxsagaLayer) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaLayer::mean(self : DbtxsagaLayer) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaLayer::scale(self : DbtxsagaLayer, f : Double) -> DbtxsagaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaLayer::add(self : DbtxsagaLayer, other : DbtxsagaLayer) -> DbtxsagaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaLayer::copy(self : DbtxsagaLayer) -> DbtxsagaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaLayer::fill(self : DbtxsagaLayer, v : Double) -> DbtxsagaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaLayer::min(self : DbtxsagaLayer) -> Double { @_common.min(self.data) }

pub fn DbtxsagaLayer::max(self : DbtxsagaLayer) -> Double { @_common.max(self.data) }

pub fn DbtxsagaLayer::to_string(self : DbtxsagaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_buffer_make(size : Int) -> DbtxsagaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaBuffer::len(self : DbtxsagaBuffer) -> Int { self.size }

pub fn DbtxsagaBuffer::get(self : DbtxsagaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaBuffer::set(self : DbtxsagaBuffer, i : Int, v : Double) -> DbtxsagaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaBuffer::sum(self : DbtxsagaBuffer) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaBuffer::mean(self : DbtxsagaBuffer) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaBuffer::scale(self : DbtxsagaBuffer, f : Double) -> DbtxsagaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaBuffer::add(self : DbtxsagaBuffer, other : DbtxsagaBuffer) -> DbtxsagaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaBuffer::copy(self : DbtxsagaBuffer) -> DbtxsagaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaBuffer::fill(self : DbtxsagaBuffer, v : Double) -> DbtxsagaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaBuffer::min(self : DbtxsagaBuffer) -> Double { @_common.min(self.data) }

pub fn DbtxsagaBuffer::max(self : DbtxsagaBuffer) -> Double { @_common.max(self.data) }

pub fn DbtxsagaBuffer::to_string(self : DbtxsagaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_cursor_make(size : Int) -> DbtxsagaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaCursor::len(self : DbtxsagaCursor) -> Int { self.size }

pub fn DbtxsagaCursor::get(self : DbtxsagaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaCursor::set(self : DbtxsagaCursor, i : Int, v : Double) -> DbtxsagaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaCursor::sum(self : DbtxsagaCursor) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaCursor::mean(self : DbtxsagaCursor) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaCursor::scale(self : DbtxsagaCursor, f : Double) -> DbtxsagaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaCursor::add(self : DbtxsagaCursor, other : DbtxsagaCursor) -> DbtxsagaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaCursor::copy(self : DbtxsagaCursor) -> DbtxsagaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaCursor::fill(self : DbtxsagaCursor, v : Double) -> DbtxsagaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaCursor::min(self : DbtxsagaCursor) -> Double { @_common.min(self.data) }

pub fn DbtxsagaCursor::max(self : DbtxsagaCursor) -> Double { @_common.max(self.data) }

pub fn DbtxsagaCursor::to_string(self : DbtxsagaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_view_make(size : Int) -> DbtxsagaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaView::len(self : DbtxsagaView) -> Int { self.size }

pub fn DbtxsagaView::get(self : DbtxsagaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaView::set(self : DbtxsagaView, i : Int, v : Double) -> DbtxsagaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaView::sum(self : DbtxsagaView) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaView::mean(self : DbtxsagaView) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaView::scale(self : DbtxsagaView, f : Double) -> DbtxsagaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaView::add(self : DbtxsagaView, other : DbtxsagaView) -> DbtxsagaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaView::copy(self : DbtxsagaView) -> DbtxsagaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaView::fill(self : DbtxsagaView, v : Double) -> DbtxsagaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaView::min(self : DbtxsagaView) -> Double { @_common.min(self.data) }

pub fn DbtxsagaView::max(self : DbtxsagaView) -> Double { @_common.max(self.data) }

pub fn DbtxsagaView::to_string(self : DbtxsagaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_range_make(size : Int) -> DbtxsagaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaRange::len(self : DbtxsagaRange) -> Int { self.size }

pub fn DbtxsagaRange::get(self : DbtxsagaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaRange::set(self : DbtxsagaRange, i : Int, v : Double) -> DbtxsagaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaRange::sum(self : DbtxsagaRange) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaRange::mean(self : DbtxsagaRange) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaRange::scale(self : DbtxsagaRange, f : Double) -> DbtxsagaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaRange::add(self : DbtxsagaRange, other : DbtxsagaRange) -> DbtxsagaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaRange::copy(self : DbtxsagaRange) -> DbtxsagaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaRange::fill(self : DbtxsagaRange, v : Double) -> DbtxsagaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaRange::min(self : DbtxsagaRange) -> Double { @_common.min(self.data) }

pub fn DbtxsagaRange::max(self : DbtxsagaRange) -> Double { @_common.max(self.data) }

pub fn DbtxsagaRange::to_string(self : DbtxsagaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxsagaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_slice_make(size : Int) -> DbtxsagaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxsagaSlice::len(self : DbtxsagaSlice) -> Int { self.size }

pub fn DbtxsagaSlice::get(self : DbtxsagaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxsagaSlice::set(self : DbtxsagaSlice, i : Int, v : Double) -> DbtxsagaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxsagaSlice::sum(self : DbtxsagaSlice) -> Double { @_common.sum(self.data) }

pub fn DbtxsagaSlice::mean(self : DbtxsagaSlice) -> Double { @_common.mean(self.data) }

pub fn DbtxsagaSlice::scale(self : DbtxsagaSlice, f : Double) -> DbtxsagaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxsagaSlice::add(self : DbtxsagaSlice, other : DbtxsagaSlice) -> DbtxsagaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxsagaSlice::copy(self : DbtxsagaSlice) -> DbtxsagaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxsagaSlice::fill(self : DbtxsagaSlice, v : Double) -> DbtxsagaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxsagaSlice::min(self : DbtxsagaSlice) -> Double { @_common.min(self.data) }

pub fn DbtxsagaSlice::max(self : DbtxsagaSlice) -> Double { @_common.max(self.data) }

pub fn DbtxsagaSlice::to_string(self : DbtxsagaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

