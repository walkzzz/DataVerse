///===
/// extcore/db_tx_timestamp

pub(all) struct DbtxtimestampPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_timestamp_make_point(x : Double, y : Double) -> DbtxtimestampPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_timestamp_make_point3(x : Double, y : Double, z : Double) -> DbtxtimestampPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxtimestampPoint::x(self : DbtxtimestampPoint) -> Double { self.x }

pub fn DbtxtimestampPoint::y(self : DbtxtimestampPoint) -> Double { self.y }

pub fn DbtxtimestampPoint::z(self : DbtxtimestampPoint) -> Double { self.z }

pub fn DbtxtimestampPoint::label(self : DbtxtimestampPoint) -> Int { self.label }

pub fn DbtxtimestampPoint::dist(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxtimestampPoint::add(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxtimestampPoint::sub(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxtimestampPoint::scale(self : DbtxtimestampPoint, s : Double) -> DbtxtimestampPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxtimestampPoint::dot(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxtimestampPoint::cross(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxtimestampPoint::norm(self : DbtxtimestampPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxtimestampPoint::normalize(self : DbtxtimestampPoint) -> DbtxtimestampPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxtimestampPoint::negate(self : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxtimestampPoint::mid(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxtimestampPoint::lerp(self : DbtxtimestampPoint, other : DbtxtimestampPoint, t : Double) -> DbtxtimestampPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxtimestampPoint::to_string(self : DbtxtimestampPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxtimestampSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_timestamp_make_series(vals : Array[Double], name : String) -> DbtxtimestampSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxtimestampSeries::len(self : DbtxtimestampSeries) -> Int { self.vals.length() }

pub fn DbtxtimestampSeries::sum(self : DbtxtimestampSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxtimestampSeries::mean(self : DbtxtimestampSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxtimestampSeries::min(self : DbtxtimestampSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxtimestampSeries::max(self : DbtxtimestampSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxtimestampSeries::range(self : DbtxtimestampSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxtimestampSeries::variance(self : DbtxtimestampSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxtimestampSeries::std(self : DbtxtimestampSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxtimestampSeries::median(self : DbtxtimestampSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxtimestampSeries::scale(self : DbtxtimestampSeries, f : Double) -> DbtxtimestampSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxtimestampSeries::add(self : DbtxtimestampSeries, other : DbtxtimestampSeries) -> DbtxtimestampSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxtimestampSeries::sub(self : DbtxtimestampSeries, other : DbtxtimestampSeries) -> DbtxtimestampSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxtimestampSeries::normalize(self : DbtxtimestampSeries) -> DbtxtimestampSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxtimestampSeries::cumsum(self : DbtxtimestampSeries) -> DbtxtimestampSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxtimestampSeries::to_string(self : DbtxtimestampSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxtimestampMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_timestamp_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxtimestampMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_timestamp_matrix_identity(n : Int) -> DbtxtimestampMatrix {
  let m = db_tx_timestamp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxtimestampMatrix::get(self : DbtxtimestampMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxtimestampMatrix::transpose(self : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  let result = db_tx_timestamp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxtimestampMatrix::add(self : DbtxtimestampMatrix, other : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_timestamp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxtimestampMatrix::scale(self : DbtxtimestampMatrix, s : Double) -> DbtxtimestampMatrix {
  let result = db_tx_timestamp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxtimestampMatrix::multiply(self : DbtxtimestampMatrix, other : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  if self.cols != other.rows { return db_tx_timestamp_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_timestamp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DbtxtimestampMatrix::trace(self : DbtxtimestampMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxtimestampMatrix::det(self : DbtxtimestampMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxtimestampMatrix::norm(self : DbtxtimestampMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxtimestampMatrix::to_string(self : DbtxtimestampMatrix) -> String {
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

pub(all) struct DbtxtimestampVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_timestamp_make_vector(comps : Array[Double]) -> DbtxtimestampVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_timestamp_vector_zero(dim : Int) -> DbtxtimestampVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxtimestampVector::add(self : DbtxtimestampVector, other : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxtimestampVector::sub(self : DbtxtimestampVector, other : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxtimestampVector::scale(self : DbtxtimestampVector, s : Double) -> DbtxtimestampVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxtimestampVector::dot(self : DbtxtimestampVector, other : DbtxtimestampVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxtimestampVector::norm(self : DbtxtimestampVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxtimestampVector::normalize(self : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxtimestampVector::dist(self : DbtxtimestampVector, other : DbtxtimestampVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxtimestampVector::to_string(self : DbtxtimestampVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxtimestampFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_frame_make(size : Int) -> DbtxtimestampFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampFrame::len(self : DbtxtimestampFrame) -> Int { self.size }

pub fn DbtxtimestampFrame::get(self : DbtxtimestampFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampFrame::set(self : DbtxtimestampFrame, i : Int, v : Double) -> DbtxtimestampFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampFrame::sum(self : DbtxtimestampFrame) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampFrame::mean(self : DbtxtimestampFrame) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampFrame::scale(self : DbtxtimestampFrame, f : Double) -> DbtxtimestampFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampFrame::add(self : DbtxtimestampFrame, other : DbtxtimestampFrame) -> DbtxtimestampFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampFrame::copy(self : DbtxtimestampFrame) -> DbtxtimestampFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampFrame::fill(self : DbtxtimestampFrame, v : Double) -> DbtxtimestampFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampFrame::min(self : DbtxtimestampFrame) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampFrame::max(self : DbtxtimestampFrame) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampFrame::to_string(self : DbtxtimestampFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_table_make(size : Int) -> DbtxtimestampTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampTable::len(self : DbtxtimestampTable) -> Int { self.size }

pub fn DbtxtimestampTable::get(self : DbtxtimestampTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampTable::set(self : DbtxtimestampTable, i : Int, v : Double) -> DbtxtimestampTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampTable::sum(self : DbtxtimestampTable) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampTable::mean(self : DbtxtimestampTable) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampTable::scale(self : DbtxtimestampTable, f : Double) -> DbtxtimestampTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampTable::add(self : DbtxtimestampTable, other : DbtxtimestampTable) -> DbtxtimestampTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampTable::copy(self : DbtxtimestampTable) -> DbtxtimestampTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampTable::fill(self : DbtxtimestampTable, v : Double) -> DbtxtimestampTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampTable::min(self : DbtxtimestampTable) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampTable::max(self : DbtxtimestampTable) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampTable::to_string(self : DbtxtimestampTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_graphn_make(size : Int) -> DbtxtimestampGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampGraphN::len(self : DbtxtimestampGraphN) -> Int { self.size }

pub fn DbtxtimestampGraphN::get(self : DbtxtimestampGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampGraphN::set(self : DbtxtimestampGraphN, i : Int, v : Double) -> DbtxtimestampGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampGraphN::sum(self : DbtxtimestampGraphN) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampGraphN::mean(self : DbtxtimestampGraphN) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampGraphN::scale(self : DbtxtimestampGraphN, f : Double) -> DbtxtimestampGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampGraphN::add(self : DbtxtimestampGraphN, other : DbtxtimestampGraphN) -> DbtxtimestampGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampGraphN::copy(self : DbtxtimestampGraphN) -> DbtxtimestampGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampGraphN::fill(self : DbtxtimestampGraphN, v : Double) -> DbtxtimestampGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampGraphN::min(self : DbtxtimestampGraphN) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampGraphN::max(self : DbtxtimestampGraphN) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampGraphN::to_string(self : DbtxtimestampGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_node_make(size : Int) -> DbtxtimestampNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampNode::len(self : DbtxtimestampNode) -> Int { self.size }

pub fn DbtxtimestampNode::get(self : DbtxtimestampNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampNode::set(self : DbtxtimestampNode, i : Int, v : Double) -> DbtxtimestampNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampNode::sum(self : DbtxtimestampNode) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampNode::mean(self : DbtxtimestampNode) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampNode::scale(self : DbtxtimestampNode, f : Double) -> DbtxtimestampNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampNode::add(self : DbtxtimestampNode, other : DbtxtimestampNode) -> DbtxtimestampNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampNode::copy(self : DbtxtimestampNode) -> DbtxtimestampNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampNode::fill(self : DbtxtimestampNode, v : Double) -> DbtxtimestampNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampNode::min(self : DbtxtimestampNode) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampNode::max(self : DbtxtimestampNode) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampNode::to_string(self : DbtxtimestampNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_edge_make(size : Int) -> DbtxtimestampEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampEdge::len(self : DbtxtimestampEdge) -> Int { self.size }

pub fn DbtxtimestampEdge::get(self : DbtxtimestampEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampEdge::set(self : DbtxtimestampEdge, i : Int, v : Double) -> DbtxtimestampEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampEdge::sum(self : DbtxtimestampEdge) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampEdge::mean(self : DbtxtimestampEdge) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampEdge::scale(self : DbtxtimestampEdge, f : Double) -> DbtxtimestampEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampEdge::add(self : DbtxtimestampEdge, other : DbtxtimestampEdge) -> DbtxtimestampEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampEdge::copy(self : DbtxtimestampEdge) -> DbtxtimestampEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampEdge::fill(self : DbtxtimestampEdge, v : Double) -> DbtxtimestampEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampEdge::min(self : DbtxtimestampEdge) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampEdge::max(self : DbtxtimestampEdge) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampEdge::to_string(self : DbtxtimestampEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_path_make(size : Int) -> DbtxtimestampPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampPath::len(self : DbtxtimestampPath) -> Int { self.size }

pub fn DbtxtimestampPath::get(self : DbtxtimestampPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampPath::set(self : DbtxtimestampPath, i : Int, v : Double) -> DbtxtimestampPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampPath::sum(self : DbtxtimestampPath) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampPath::mean(self : DbtxtimestampPath) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampPath::scale(self : DbtxtimestampPath, f : Double) -> DbtxtimestampPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampPath::add(self : DbtxtimestampPath, other : DbtxtimestampPath) -> DbtxtimestampPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampPath::copy(self : DbtxtimestampPath) -> DbtxtimestampPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampPath::fill(self : DbtxtimestampPath, v : Double) -> DbtxtimestampPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampPath::min(self : DbtxtimestampPath) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampPath::max(self : DbtxtimestampPath) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampPath::to_string(self : DbtxtimestampPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_cluster_make(size : Int) -> DbtxtimestampCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampCluster::len(self : DbtxtimestampCluster) -> Int { self.size }

pub fn DbtxtimestampCluster::get(self : DbtxtimestampCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampCluster::set(self : DbtxtimestampCluster, i : Int, v : Double) -> DbtxtimestampCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampCluster::sum(self : DbtxtimestampCluster) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampCluster::mean(self : DbtxtimestampCluster) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampCluster::scale(self : DbtxtimestampCluster, f : Double) -> DbtxtimestampCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampCluster::add(self : DbtxtimestampCluster, other : DbtxtimestampCluster) -> DbtxtimestampCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampCluster::copy(self : DbtxtimestampCluster) -> DbtxtimestampCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampCluster::fill(self : DbtxtimestampCluster, v : Double) -> DbtxtimestampCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampCluster::min(self : DbtxtimestampCluster) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampCluster::max(self : DbtxtimestampCluster) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampCluster::to_string(self : DbtxtimestampCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_model_make(size : Int) -> DbtxtimestampModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampModel::len(self : DbtxtimestampModel) -> Int { self.size }

pub fn DbtxtimestampModel::get(self : DbtxtimestampModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampModel::set(self : DbtxtimestampModel, i : Int, v : Double) -> DbtxtimestampModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampModel::sum(self : DbtxtimestampModel) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampModel::mean(self : DbtxtimestampModel) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampModel::scale(self : DbtxtimestampModel, f : Double) -> DbtxtimestampModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampModel::add(self : DbtxtimestampModel, other : DbtxtimestampModel) -> DbtxtimestampModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampModel::copy(self : DbtxtimestampModel) -> DbtxtimestampModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampModel::fill(self : DbtxtimestampModel, v : Double) -> DbtxtimestampModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampModel::min(self : DbtxtimestampModel) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampModel::max(self : DbtxtimestampModel) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampModel::to_string(self : DbtxtimestampModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_layer_make(size : Int) -> DbtxtimestampLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampLayer::len(self : DbtxtimestampLayer) -> Int { self.size }

pub fn DbtxtimestampLayer::get(self : DbtxtimestampLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampLayer::set(self : DbtxtimestampLayer, i : Int, v : Double) -> DbtxtimestampLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampLayer::sum(self : DbtxtimestampLayer) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampLayer::mean(self : DbtxtimestampLayer) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampLayer::scale(self : DbtxtimestampLayer, f : Double) -> DbtxtimestampLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampLayer::add(self : DbtxtimestampLayer, other : DbtxtimestampLayer) -> DbtxtimestampLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampLayer::copy(self : DbtxtimestampLayer) -> DbtxtimestampLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampLayer::fill(self : DbtxtimestampLayer, v : Double) -> DbtxtimestampLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampLayer::min(self : DbtxtimestampLayer) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampLayer::max(self : DbtxtimestampLayer) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampLayer::to_string(self : DbtxtimestampLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_buffer_make(size : Int) -> DbtxtimestampBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampBuffer::len(self : DbtxtimestampBuffer) -> Int { self.size }

pub fn DbtxtimestampBuffer::get(self : DbtxtimestampBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampBuffer::set(self : DbtxtimestampBuffer, i : Int, v : Double) -> DbtxtimestampBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampBuffer::sum(self : DbtxtimestampBuffer) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampBuffer::mean(self : DbtxtimestampBuffer) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampBuffer::scale(self : DbtxtimestampBuffer, f : Double) -> DbtxtimestampBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampBuffer::add(self : DbtxtimestampBuffer, other : DbtxtimestampBuffer) -> DbtxtimestampBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampBuffer::copy(self : DbtxtimestampBuffer) -> DbtxtimestampBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampBuffer::fill(self : DbtxtimestampBuffer, v : Double) -> DbtxtimestampBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampBuffer::min(self : DbtxtimestampBuffer) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampBuffer::max(self : DbtxtimestampBuffer) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampBuffer::to_string(self : DbtxtimestampBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_cursor_make(size : Int) -> DbtxtimestampCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampCursor::len(self : DbtxtimestampCursor) -> Int { self.size }

pub fn DbtxtimestampCursor::get(self : DbtxtimestampCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampCursor::set(self : DbtxtimestampCursor, i : Int, v : Double) -> DbtxtimestampCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampCursor::sum(self : DbtxtimestampCursor) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampCursor::mean(self : DbtxtimestampCursor) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampCursor::scale(self : DbtxtimestampCursor, f : Double) -> DbtxtimestampCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampCursor::add(self : DbtxtimestampCursor, other : DbtxtimestampCursor) -> DbtxtimestampCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampCursor::copy(self : DbtxtimestampCursor) -> DbtxtimestampCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampCursor::fill(self : DbtxtimestampCursor, v : Double) -> DbtxtimestampCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampCursor::min(self : DbtxtimestampCursor) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampCursor::max(self : DbtxtimestampCursor) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampCursor::to_string(self : DbtxtimestampCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_view_make(size : Int) -> DbtxtimestampView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampView::len(self : DbtxtimestampView) -> Int { self.size }

pub fn DbtxtimestampView::get(self : DbtxtimestampView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampView::set(self : DbtxtimestampView, i : Int, v : Double) -> DbtxtimestampView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampView::sum(self : DbtxtimestampView) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampView::mean(self : DbtxtimestampView) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampView::scale(self : DbtxtimestampView, f : Double) -> DbtxtimestampView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampView::add(self : DbtxtimestampView, other : DbtxtimestampView) -> DbtxtimestampView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampView::copy(self : DbtxtimestampView) -> DbtxtimestampView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampView::fill(self : DbtxtimestampView, v : Double) -> DbtxtimestampView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampView::min(self : DbtxtimestampView) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampView::max(self : DbtxtimestampView) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampView::to_string(self : DbtxtimestampView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_range_make(size : Int) -> DbtxtimestampRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampRange::len(self : DbtxtimestampRange) -> Int { self.size }

pub fn DbtxtimestampRange::get(self : DbtxtimestampRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampRange::set(self : DbtxtimestampRange, i : Int, v : Double) -> DbtxtimestampRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampRange::sum(self : DbtxtimestampRange) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampRange::mean(self : DbtxtimestampRange) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampRange::scale(self : DbtxtimestampRange, f : Double) -> DbtxtimestampRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampRange::add(self : DbtxtimestampRange, other : DbtxtimestampRange) -> DbtxtimestampRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampRange::copy(self : DbtxtimestampRange) -> DbtxtimestampRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampRange::fill(self : DbtxtimestampRange, v : Double) -> DbtxtimestampRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampRange::min(self : DbtxtimestampRange) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampRange::max(self : DbtxtimestampRange) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampRange::to_string(self : DbtxtimestampRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_slice_make(size : Int) -> DbtxtimestampSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxtimestampSlice::len(self : DbtxtimestampSlice) -> Int { self.size }

pub fn DbtxtimestampSlice::get(self : DbtxtimestampSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxtimestampSlice::set(self : DbtxtimestampSlice, i : Int, v : Double) -> DbtxtimestampSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxtimestampSlice::sum(self : DbtxtimestampSlice) -> Double { @_common.sum(self.data) }

pub fn DbtxtimestampSlice::mean(self : DbtxtimestampSlice) -> Double { @_common.mean(self.data) }

pub fn DbtxtimestampSlice::scale(self : DbtxtimestampSlice, f : Double) -> DbtxtimestampSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampSlice::add(self : DbtxtimestampSlice, other : DbtxtimestampSlice) -> DbtxtimestampSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxtimestampSlice::copy(self : DbtxtimestampSlice) -> DbtxtimestampSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampSlice::fill(self : DbtxtimestampSlice, v : Double) -> DbtxtimestampSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxtimestampSlice::min(self : DbtxtimestampSlice) -> Double { @_common.min(self.data) }

pub fn DbtxtimestampSlice::max(self : DbtxtimestampSlice) -> Double { @_common.max(self.data) }

pub fn DbtxtimestampSlice::to_string(self : DbtxtimestampSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

