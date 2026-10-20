///===
/// extcore/db_tx_lock

pub(all) struct DbtxlockPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_lock_make_point(x : Double, y : Double) -> DbtxlockPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_lock_make_point3(x : Double, y : Double, z : Double) -> DbtxlockPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxlockPoint::x(self : DbtxlockPoint) -> Double { self.x }

pub fn DbtxlockPoint::y(self : DbtxlockPoint) -> Double { self.y }

pub fn DbtxlockPoint::z(self : DbtxlockPoint) -> Double { self.z }

pub fn DbtxlockPoint::label(self : DbtxlockPoint) -> Int { self.label }

pub fn DbtxlockPoint::dist(self : DbtxlockPoint, other : DbtxlockPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxlockPoint::add(self : DbtxlockPoint, other : DbtxlockPoint) -> DbtxlockPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxlockPoint::sub(self : DbtxlockPoint, other : DbtxlockPoint) -> DbtxlockPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxlockPoint::scale(self : DbtxlockPoint, s : Double) -> DbtxlockPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxlockPoint::dot(self : DbtxlockPoint, other : DbtxlockPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxlockPoint::cross(self : DbtxlockPoint, other : DbtxlockPoint) -> DbtxlockPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxlockPoint::norm(self : DbtxlockPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxlockPoint::normalize(self : DbtxlockPoint) -> DbtxlockPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxlockPoint::negate(self : DbtxlockPoint) -> DbtxlockPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxlockPoint::mid(self : DbtxlockPoint, other : DbtxlockPoint) -> DbtxlockPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxlockPoint::lerp(self : DbtxlockPoint, other : DbtxlockPoint, t : Double) -> DbtxlockPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxlockPoint::to_string(self : DbtxlockPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxlockSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_lock_make_series(vals : Array[Double], name : String) -> DbtxlockSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxlockSeries::len(self : DbtxlockSeries) -> Int { self.vals.length() }

pub fn DbtxlockSeries::sum(self : DbtxlockSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxlockSeries::mean(self : DbtxlockSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxlockSeries::min(self : DbtxlockSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxlockSeries::max(self : DbtxlockSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxlockSeries::range(self : DbtxlockSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxlockSeries::variance(self : DbtxlockSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxlockSeries::std(self : DbtxlockSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxlockSeries::median(self : DbtxlockSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxlockSeries::scale(self : DbtxlockSeries, f : Double) -> DbtxlockSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxlockSeries::add(self : DbtxlockSeries, other : DbtxlockSeries) -> DbtxlockSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxlockSeries::sub(self : DbtxlockSeries, other : DbtxlockSeries) -> DbtxlockSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxlockSeries::normalize(self : DbtxlockSeries) -> DbtxlockSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxlockSeries::cumsum(self : DbtxlockSeries) -> DbtxlockSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxlockSeries::to_string(self : DbtxlockSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxlockMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_lock_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxlockMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn db_tx_lock_matrix_identity(n : Int) -> DbtxlockMatrix {
  let m = db_tx_lock_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxlockMatrix::get(self : DbtxlockMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxlockMatrix::transpose(self : DbtxlockMatrix) -> DbtxlockMatrix {
  let result = db_tx_lock_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxlockMatrix::add(self : DbtxlockMatrix, other : DbtxlockMatrix) -> DbtxlockMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_lock_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxlockMatrix::scale(self : DbtxlockMatrix, s : Double) -> DbtxlockMatrix {
  let result = db_tx_lock_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxlockMatrix::multiply(self : DbtxlockMatrix, other : DbtxlockMatrix) -> DbtxlockMatrix {
  if self.cols != other.rows { return db_tx_lock_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_lock_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DbtxlockMatrix::trace(self : DbtxlockMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxlockMatrix::det(self : DbtxlockMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxlockMatrix::norm(self : DbtxlockMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxlockMatrix::to_string(self : DbtxlockMatrix) -> String {
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

pub(all) struct DbtxlockVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_lock_make_vector(comps : Array[Double]) -> DbtxlockVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_lock_vector_zero(dim : Int) -> DbtxlockVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxlockVector::add(self : DbtxlockVector, other : DbtxlockVector) -> DbtxlockVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxlockVector::sub(self : DbtxlockVector, other : DbtxlockVector) -> DbtxlockVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxlockVector::scale(self : DbtxlockVector, s : Double) -> DbtxlockVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxlockVector::dot(self : DbtxlockVector, other : DbtxlockVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxlockVector::norm(self : DbtxlockVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxlockVector::normalize(self : DbtxlockVector) -> DbtxlockVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxlockVector::dist(self : DbtxlockVector, other : DbtxlockVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxlockVector::to_string(self : DbtxlockVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxlockFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_frame_make(size : Int) -> DbtxlockFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockFrame::len(self : DbtxlockFrame) -> Int { self.size }

pub fn DbtxlockFrame::get(self : DbtxlockFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockFrame::set(self : DbtxlockFrame, i : Int, v : Double) -> DbtxlockFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockFrame::sum(self : DbtxlockFrame) -> Double { @_common.sum(self.data) }

pub fn DbtxlockFrame::mean(self : DbtxlockFrame) -> Double { @_common.mean(self.data) }

pub fn DbtxlockFrame::scale(self : DbtxlockFrame, f : Double) -> DbtxlockFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockFrame::add(self : DbtxlockFrame, other : DbtxlockFrame) -> DbtxlockFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockFrame::copy(self : DbtxlockFrame) -> DbtxlockFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockFrame::fill(self : DbtxlockFrame, v : Double) -> DbtxlockFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockFrame::min(self : DbtxlockFrame) -> Double { @_common.min(self.data) }

pub fn DbtxlockFrame::max(self : DbtxlockFrame) -> Double { @_common.max(self.data) }

pub fn DbtxlockFrame::to_string(self : DbtxlockFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_table_make(size : Int) -> DbtxlockTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockTable::len(self : DbtxlockTable) -> Int { self.size }

pub fn DbtxlockTable::get(self : DbtxlockTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockTable::set(self : DbtxlockTable, i : Int, v : Double) -> DbtxlockTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockTable::sum(self : DbtxlockTable) -> Double { @_common.sum(self.data) }

pub fn DbtxlockTable::mean(self : DbtxlockTable) -> Double { @_common.mean(self.data) }

pub fn DbtxlockTable::scale(self : DbtxlockTable, f : Double) -> DbtxlockTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockTable::add(self : DbtxlockTable, other : DbtxlockTable) -> DbtxlockTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockTable::copy(self : DbtxlockTable) -> DbtxlockTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockTable::fill(self : DbtxlockTable, v : Double) -> DbtxlockTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockTable::min(self : DbtxlockTable) -> Double { @_common.min(self.data) }

pub fn DbtxlockTable::max(self : DbtxlockTable) -> Double { @_common.max(self.data) }

pub fn DbtxlockTable::to_string(self : DbtxlockTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_graphn_make(size : Int) -> DbtxlockGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockGraphN::len(self : DbtxlockGraphN) -> Int { self.size }

pub fn DbtxlockGraphN::get(self : DbtxlockGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockGraphN::set(self : DbtxlockGraphN, i : Int, v : Double) -> DbtxlockGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockGraphN::sum(self : DbtxlockGraphN) -> Double { @_common.sum(self.data) }

pub fn DbtxlockGraphN::mean(self : DbtxlockGraphN) -> Double { @_common.mean(self.data) }

pub fn DbtxlockGraphN::scale(self : DbtxlockGraphN, f : Double) -> DbtxlockGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockGraphN::add(self : DbtxlockGraphN, other : DbtxlockGraphN) -> DbtxlockGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockGraphN::copy(self : DbtxlockGraphN) -> DbtxlockGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockGraphN::fill(self : DbtxlockGraphN, v : Double) -> DbtxlockGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockGraphN::min(self : DbtxlockGraphN) -> Double { @_common.min(self.data) }

pub fn DbtxlockGraphN::max(self : DbtxlockGraphN) -> Double { @_common.max(self.data) }

pub fn DbtxlockGraphN::to_string(self : DbtxlockGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_node_make(size : Int) -> DbtxlockNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockNode::len(self : DbtxlockNode) -> Int { self.size }

pub fn DbtxlockNode::get(self : DbtxlockNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockNode::set(self : DbtxlockNode, i : Int, v : Double) -> DbtxlockNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockNode::sum(self : DbtxlockNode) -> Double { @_common.sum(self.data) }

pub fn DbtxlockNode::mean(self : DbtxlockNode) -> Double { @_common.mean(self.data) }

pub fn DbtxlockNode::scale(self : DbtxlockNode, f : Double) -> DbtxlockNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockNode::add(self : DbtxlockNode, other : DbtxlockNode) -> DbtxlockNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockNode::copy(self : DbtxlockNode) -> DbtxlockNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockNode::fill(self : DbtxlockNode, v : Double) -> DbtxlockNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockNode::min(self : DbtxlockNode) -> Double { @_common.min(self.data) }

pub fn DbtxlockNode::max(self : DbtxlockNode) -> Double { @_common.max(self.data) }

pub fn DbtxlockNode::to_string(self : DbtxlockNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_edge_make(size : Int) -> DbtxlockEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockEdge::len(self : DbtxlockEdge) -> Int { self.size }

pub fn DbtxlockEdge::get(self : DbtxlockEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockEdge::set(self : DbtxlockEdge, i : Int, v : Double) -> DbtxlockEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockEdge::sum(self : DbtxlockEdge) -> Double { @_common.sum(self.data) }

pub fn DbtxlockEdge::mean(self : DbtxlockEdge) -> Double { @_common.mean(self.data) }

pub fn DbtxlockEdge::scale(self : DbtxlockEdge, f : Double) -> DbtxlockEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockEdge::add(self : DbtxlockEdge, other : DbtxlockEdge) -> DbtxlockEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockEdge::copy(self : DbtxlockEdge) -> DbtxlockEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockEdge::fill(self : DbtxlockEdge, v : Double) -> DbtxlockEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockEdge::min(self : DbtxlockEdge) -> Double { @_common.min(self.data) }

pub fn DbtxlockEdge::max(self : DbtxlockEdge) -> Double { @_common.max(self.data) }

pub fn DbtxlockEdge::to_string(self : DbtxlockEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_path_make(size : Int) -> DbtxlockPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockPath::len(self : DbtxlockPath) -> Int { self.size }

pub fn DbtxlockPath::get(self : DbtxlockPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockPath::set(self : DbtxlockPath, i : Int, v : Double) -> DbtxlockPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockPath::sum(self : DbtxlockPath) -> Double { @_common.sum(self.data) }

pub fn DbtxlockPath::mean(self : DbtxlockPath) -> Double { @_common.mean(self.data) }

pub fn DbtxlockPath::scale(self : DbtxlockPath, f : Double) -> DbtxlockPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockPath::add(self : DbtxlockPath, other : DbtxlockPath) -> DbtxlockPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockPath::copy(self : DbtxlockPath) -> DbtxlockPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockPath::fill(self : DbtxlockPath, v : Double) -> DbtxlockPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockPath::min(self : DbtxlockPath) -> Double { @_common.min(self.data) }

pub fn DbtxlockPath::max(self : DbtxlockPath) -> Double { @_common.max(self.data) }

pub fn DbtxlockPath::to_string(self : DbtxlockPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_cluster_make(size : Int) -> DbtxlockCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockCluster::len(self : DbtxlockCluster) -> Int { self.size }

pub fn DbtxlockCluster::get(self : DbtxlockCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockCluster::set(self : DbtxlockCluster, i : Int, v : Double) -> DbtxlockCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockCluster::sum(self : DbtxlockCluster) -> Double { @_common.sum(self.data) }

pub fn DbtxlockCluster::mean(self : DbtxlockCluster) -> Double { @_common.mean(self.data) }

pub fn DbtxlockCluster::scale(self : DbtxlockCluster, f : Double) -> DbtxlockCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockCluster::add(self : DbtxlockCluster, other : DbtxlockCluster) -> DbtxlockCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockCluster::copy(self : DbtxlockCluster) -> DbtxlockCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockCluster::fill(self : DbtxlockCluster, v : Double) -> DbtxlockCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockCluster::min(self : DbtxlockCluster) -> Double { @_common.min(self.data) }

pub fn DbtxlockCluster::max(self : DbtxlockCluster) -> Double { @_common.max(self.data) }

pub fn DbtxlockCluster::to_string(self : DbtxlockCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_model_make(size : Int) -> DbtxlockModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockModel::len(self : DbtxlockModel) -> Int { self.size }

pub fn DbtxlockModel::get(self : DbtxlockModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockModel::set(self : DbtxlockModel, i : Int, v : Double) -> DbtxlockModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockModel::sum(self : DbtxlockModel) -> Double { @_common.sum(self.data) }

pub fn DbtxlockModel::mean(self : DbtxlockModel) -> Double { @_common.mean(self.data) }

pub fn DbtxlockModel::scale(self : DbtxlockModel, f : Double) -> DbtxlockModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockModel::add(self : DbtxlockModel, other : DbtxlockModel) -> DbtxlockModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockModel::copy(self : DbtxlockModel) -> DbtxlockModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockModel::fill(self : DbtxlockModel, v : Double) -> DbtxlockModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockModel::min(self : DbtxlockModel) -> Double { @_common.min(self.data) }

pub fn DbtxlockModel::max(self : DbtxlockModel) -> Double { @_common.max(self.data) }

pub fn DbtxlockModel::to_string(self : DbtxlockModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_layer_make(size : Int) -> DbtxlockLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockLayer::len(self : DbtxlockLayer) -> Int { self.size }

pub fn DbtxlockLayer::get(self : DbtxlockLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockLayer::set(self : DbtxlockLayer, i : Int, v : Double) -> DbtxlockLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockLayer::sum(self : DbtxlockLayer) -> Double { @_common.sum(self.data) }

pub fn DbtxlockLayer::mean(self : DbtxlockLayer) -> Double { @_common.mean(self.data) }

pub fn DbtxlockLayer::scale(self : DbtxlockLayer, f : Double) -> DbtxlockLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockLayer::add(self : DbtxlockLayer, other : DbtxlockLayer) -> DbtxlockLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockLayer::copy(self : DbtxlockLayer) -> DbtxlockLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockLayer::fill(self : DbtxlockLayer, v : Double) -> DbtxlockLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockLayer::min(self : DbtxlockLayer) -> Double { @_common.min(self.data) }

pub fn DbtxlockLayer::max(self : DbtxlockLayer) -> Double { @_common.max(self.data) }

pub fn DbtxlockLayer::to_string(self : DbtxlockLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_buffer_make(size : Int) -> DbtxlockBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockBuffer::len(self : DbtxlockBuffer) -> Int { self.size }

pub fn DbtxlockBuffer::get(self : DbtxlockBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockBuffer::set(self : DbtxlockBuffer, i : Int, v : Double) -> DbtxlockBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockBuffer::sum(self : DbtxlockBuffer) -> Double { @_common.sum(self.data) }

pub fn DbtxlockBuffer::mean(self : DbtxlockBuffer) -> Double { @_common.mean(self.data) }

pub fn DbtxlockBuffer::scale(self : DbtxlockBuffer, f : Double) -> DbtxlockBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockBuffer::add(self : DbtxlockBuffer, other : DbtxlockBuffer) -> DbtxlockBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockBuffer::copy(self : DbtxlockBuffer) -> DbtxlockBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockBuffer::fill(self : DbtxlockBuffer, v : Double) -> DbtxlockBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockBuffer::min(self : DbtxlockBuffer) -> Double { @_common.min(self.data) }

pub fn DbtxlockBuffer::max(self : DbtxlockBuffer) -> Double { @_common.max(self.data) }

pub fn DbtxlockBuffer::to_string(self : DbtxlockBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_cursor_make(size : Int) -> DbtxlockCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockCursor::len(self : DbtxlockCursor) -> Int { self.size }

pub fn DbtxlockCursor::get(self : DbtxlockCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockCursor::set(self : DbtxlockCursor, i : Int, v : Double) -> DbtxlockCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockCursor::sum(self : DbtxlockCursor) -> Double { @_common.sum(self.data) }

pub fn DbtxlockCursor::mean(self : DbtxlockCursor) -> Double { @_common.mean(self.data) }

pub fn DbtxlockCursor::scale(self : DbtxlockCursor, f : Double) -> DbtxlockCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockCursor::add(self : DbtxlockCursor, other : DbtxlockCursor) -> DbtxlockCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockCursor::copy(self : DbtxlockCursor) -> DbtxlockCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockCursor::fill(self : DbtxlockCursor, v : Double) -> DbtxlockCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockCursor::min(self : DbtxlockCursor) -> Double { @_common.min(self.data) }

pub fn DbtxlockCursor::max(self : DbtxlockCursor) -> Double { @_common.max(self.data) }

pub fn DbtxlockCursor::to_string(self : DbtxlockCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_view_make(size : Int) -> DbtxlockView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockView::len(self : DbtxlockView) -> Int { self.size }

pub fn DbtxlockView::get(self : DbtxlockView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockView::set(self : DbtxlockView, i : Int, v : Double) -> DbtxlockView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockView::sum(self : DbtxlockView) -> Double { @_common.sum(self.data) }

pub fn DbtxlockView::mean(self : DbtxlockView) -> Double { @_common.mean(self.data) }

pub fn DbtxlockView::scale(self : DbtxlockView, f : Double) -> DbtxlockView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockView::add(self : DbtxlockView, other : DbtxlockView) -> DbtxlockView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockView::copy(self : DbtxlockView) -> DbtxlockView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockView::fill(self : DbtxlockView, v : Double) -> DbtxlockView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockView::min(self : DbtxlockView) -> Double { @_common.min(self.data) }

pub fn DbtxlockView::max(self : DbtxlockView) -> Double { @_common.max(self.data) }

pub fn DbtxlockView::to_string(self : DbtxlockView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_range_make(size : Int) -> DbtxlockRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockRange::len(self : DbtxlockRange) -> Int { self.size }

pub fn DbtxlockRange::get(self : DbtxlockRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockRange::set(self : DbtxlockRange, i : Int, v : Double) -> DbtxlockRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockRange::sum(self : DbtxlockRange) -> Double { @_common.sum(self.data) }

pub fn DbtxlockRange::mean(self : DbtxlockRange) -> Double { @_common.mean(self.data) }

pub fn DbtxlockRange::scale(self : DbtxlockRange, f : Double) -> DbtxlockRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockRange::add(self : DbtxlockRange, other : DbtxlockRange) -> DbtxlockRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockRange::copy(self : DbtxlockRange) -> DbtxlockRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockRange::fill(self : DbtxlockRange, v : Double) -> DbtxlockRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockRange::min(self : DbtxlockRange) -> Double { @_common.min(self.data) }

pub fn DbtxlockRange::max(self : DbtxlockRange) -> Double { @_common.max(self.data) }

pub fn DbtxlockRange::to_string(self : DbtxlockRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxlockSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_slice_make(size : Int) -> DbtxlockSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxlockSlice::len(self : DbtxlockSlice) -> Int { self.size }

pub fn DbtxlockSlice::get(self : DbtxlockSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxlockSlice::set(self : DbtxlockSlice, i : Int, v : Double) -> DbtxlockSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxlockSlice::sum(self : DbtxlockSlice) -> Double { @_common.sum(self.data) }

pub fn DbtxlockSlice::mean(self : DbtxlockSlice) -> Double { @_common.mean(self.data) }

pub fn DbtxlockSlice::scale(self : DbtxlockSlice, f : Double) -> DbtxlockSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxlockSlice::add(self : DbtxlockSlice, other : DbtxlockSlice) -> DbtxlockSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxlockSlice::copy(self : DbtxlockSlice) -> DbtxlockSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxlockSlice::fill(self : DbtxlockSlice, v : Double) -> DbtxlockSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxlockSlice::min(self : DbtxlockSlice) -> Double { @_common.min(self.data) }

pub fn DbtxlockSlice::max(self : DbtxlockSlice) -> Double { @_common.max(self.data) }

pub fn DbtxlockSlice::to_string(self : DbtxlockSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

