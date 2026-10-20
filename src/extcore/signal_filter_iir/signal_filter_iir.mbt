///===
/// extcore/signal_filter_iir

pub(all) struct SignalfilteriirPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_iir_make_point(x : Double, y : Double) -> SignalfilteriirPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_iir_make_point3(x : Double, y : Double, z : Double) -> SignalfilteriirPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilteriirPoint::x(self : SignalfilteriirPoint) -> Double { self.x }

pub fn SignalfilteriirPoint::y(self : SignalfilteriirPoint) -> Double { self.y }

pub fn SignalfilteriirPoint::z(self : SignalfilteriirPoint) -> Double { self.z }

pub fn SignalfilteriirPoint::label(self : SignalfilteriirPoint) -> Int { self.label }

pub fn SignalfilteriirPoint::dist(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilteriirPoint::add(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilteriirPoint::sub(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilteriirPoint::scale(self : SignalfilteriirPoint, s : Double) -> SignalfilteriirPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilteriirPoint::dot(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilteriirPoint::cross(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilteriirPoint::norm(self : SignalfilteriirPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilteriirPoint::normalize(self : SignalfilteriirPoint) -> SignalfilteriirPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilteriirPoint::negate(self : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilteriirPoint::mid(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilteriirPoint::lerp(self : SignalfilteriirPoint, other : SignalfilteriirPoint, t : Double) -> SignalfilteriirPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilteriirPoint::to_string(self : SignalfilteriirPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilteriirSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_iir_make_series(vals : Array[Double], name : String) -> SignalfilteriirSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilteriirSeries::len(self : SignalfilteriirSeries) -> Int { self.vals.length() }

pub fn SignalfilteriirSeries::sum(self : SignalfilteriirSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilteriirSeries::mean(self : SignalfilteriirSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilteriirSeries::min(self : SignalfilteriirSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilteriirSeries::max(self : SignalfilteriirSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilteriirSeries::range(self : SignalfilteriirSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilteriirSeries::variance(self : SignalfilteriirSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilteriirSeries::std(self : SignalfilteriirSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilteriirSeries::median(self : SignalfilteriirSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilteriirSeries::scale(self : SignalfilteriirSeries, f : Double) -> SignalfilteriirSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilteriirSeries::add(self : SignalfilteriirSeries, other : SignalfilteriirSeries) -> SignalfilteriirSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilteriirSeries::sub(self : SignalfilteriirSeries, other : SignalfilteriirSeries) -> SignalfilteriirSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilteriirSeries::normalize(self : SignalfilteriirSeries) -> SignalfilteriirSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilteriirSeries::cumsum(self : SignalfilteriirSeries) -> SignalfilteriirSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilteriirSeries::to_string(self : SignalfilteriirSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilteriirMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_iir_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilteriirMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_iir_matrix_identity(n : Int) -> SignalfilteriirMatrix {
  let m = signal_filter_iir_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilteriirMatrix::get(self : SignalfilteriirMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilteriirMatrix::transpose(self : SignalfilteriirMatrix) -> SignalfilteriirMatrix {
  let result = signal_filter_iir_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilteriirMatrix::add(self : SignalfilteriirMatrix, other : SignalfilteriirMatrix) -> SignalfilteriirMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_iir_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilteriirMatrix::scale(self : SignalfilteriirMatrix, s : Double) -> SignalfilteriirMatrix {
  let result = signal_filter_iir_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilteriirMatrix::multiply(self : SignalfilteriirMatrix, other : SignalfilteriirMatrix) -> SignalfilteriirMatrix {
  if self.cols != other.rows { return signal_filter_iir_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_iir_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalfilteriirMatrix::trace(self : SignalfilteriirMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilteriirMatrix::det(self : SignalfilteriirMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilteriirMatrix::norm(self : SignalfilteriirMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilteriirMatrix::to_string(self : SignalfilteriirMatrix) -> String {
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

pub(all) struct SignalfilteriirVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_iir_make_vector(comps : Array[Double]) -> SignalfilteriirVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_iir_vector_zero(dim : Int) -> SignalfilteriirVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilteriirVector::add(self : SignalfilteriirVector, other : SignalfilteriirVector) -> SignalfilteriirVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilteriirVector::sub(self : SignalfilteriirVector, other : SignalfilteriirVector) -> SignalfilteriirVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilteriirVector::scale(self : SignalfilteriirVector, s : Double) -> SignalfilteriirVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilteriirVector::dot(self : SignalfilteriirVector, other : SignalfilteriirVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilteriirVector::norm(self : SignalfilteriirVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilteriirVector::normalize(self : SignalfilteriirVector) -> SignalfilteriirVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilteriirVector::dist(self : SignalfilteriirVector, other : SignalfilteriirVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilteriirVector::to_string(self : SignalfilteriirVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilteriirFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_frame_make(size : Int) -> SignalfilteriirFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirFrame::len(self : SignalfilteriirFrame) -> Int { self.size }

pub fn SignalfilteriirFrame::get(self : SignalfilteriirFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirFrame::set(self : SignalfilteriirFrame, i : Int, v : Double) -> SignalfilteriirFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirFrame::sum(self : SignalfilteriirFrame) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirFrame::mean(self : SignalfilteriirFrame) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirFrame::scale(self : SignalfilteriirFrame, f : Double) -> SignalfilteriirFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirFrame::add(self : SignalfilteriirFrame, other : SignalfilteriirFrame) -> SignalfilteriirFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirFrame::copy(self : SignalfilteriirFrame) -> SignalfilteriirFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirFrame::fill(self : SignalfilteriirFrame, v : Double) -> SignalfilteriirFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirFrame::min(self : SignalfilteriirFrame) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirFrame::max(self : SignalfilteriirFrame) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirFrame::to_string(self : SignalfilteriirFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_table_make(size : Int) -> SignalfilteriirTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirTable::len(self : SignalfilteriirTable) -> Int { self.size }

pub fn SignalfilteriirTable::get(self : SignalfilteriirTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirTable::set(self : SignalfilteriirTable, i : Int, v : Double) -> SignalfilteriirTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirTable::sum(self : SignalfilteriirTable) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirTable::mean(self : SignalfilteriirTable) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirTable::scale(self : SignalfilteriirTable, f : Double) -> SignalfilteriirTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirTable::add(self : SignalfilteriirTable, other : SignalfilteriirTable) -> SignalfilteriirTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirTable::copy(self : SignalfilteriirTable) -> SignalfilteriirTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirTable::fill(self : SignalfilteriirTable, v : Double) -> SignalfilteriirTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirTable::min(self : SignalfilteriirTable) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirTable::max(self : SignalfilteriirTable) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirTable::to_string(self : SignalfilteriirTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_graphn_make(size : Int) -> SignalfilteriirGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirGraphN::len(self : SignalfilteriirGraphN) -> Int { self.size }

pub fn SignalfilteriirGraphN::get(self : SignalfilteriirGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirGraphN::set(self : SignalfilteriirGraphN, i : Int, v : Double) -> SignalfilteriirGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirGraphN::sum(self : SignalfilteriirGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirGraphN::mean(self : SignalfilteriirGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirGraphN::scale(self : SignalfilteriirGraphN, f : Double) -> SignalfilteriirGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirGraphN::add(self : SignalfilteriirGraphN, other : SignalfilteriirGraphN) -> SignalfilteriirGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirGraphN::copy(self : SignalfilteriirGraphN) -> SignalfilteriirGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirGraphN::fill(self : SignalfilteriirGraphN, v : Double) -> SignalfilteriirGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirGraphN::min(self : SignalfilteriirGraphN) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirGraphN::max(self : SignalfilteriirGraphN) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirGraphN::to_string(self : SignalfilteriirGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_node_make(size : Int) -> SignalfilteriirNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirNode::len(self : SignalfilteriirNode) -> Int { self.size }

pub fn SignalfilteriirNode::get(self : SignalfilteriirNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirNode::set(self : SignalfilteriirNode, i : Int, v : Double) -> SignalfilteriirNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirNode::sum(self : SignalfilteriirNode) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirNode::mean(self : SignalfilteriirNode) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirNode::scale(self : SignalfilteriirNode, f : Double) -> SignalfilteriirNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirNode::add(self : SignalfilteriirNode, other : SignalfilteriirNode) -> SignalfilteriirNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirNode::copy(self : SignalfilteriirNode) -> SignalfilteriirNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirNode::fill(self : SignalfilteriirNode, v : Double) -> SignalfilteriirNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirNode::min(self : SignalfilteriirNode) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirNode::max(self : SignalfilteriirNode) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirNode::to_string(self : SignalfilteriirNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_edge_make(size : Int) -> SignalfilteriirEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirEdge::len(self : SignalfilteriirEdge) -> Int { self.size }

pub fn SignalfilteriirEdge::get(self : SignalfilteriirEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirEdge::set(self : SignalfilteriirEdge, i : Int, v : Double) -> SignalfilteriirEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirEdge::sum(self : SignalfilteriirEdge) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirEdge::mean(self : SignalfilteriirEdge) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirEdge::scale(self : SignalfilteriirEdge, f : Double) -> SignalfilteriirEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirEdge::add(self : SignalfilteriirEdge, other : SignalfilteriirEdge) -> SignalfilteriirEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirEdge::copy(self : SignalfilteriirEdge) -> SignalfilteriirEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirEdge::fill(self : SignalfilteriirEdge, v : Double) -> SignalfilteriirEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirEdge::min(self : SignalfilteriirEdge) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirEdge::max(self : SignalfilteriirEdge) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirEdge::to_string(self : SignalfilteriirEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_path_make(size : Int) -> SignalfilteriirPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirPath::len(self : SignalfilteriirPath) -> Int { self.size }

pub fn SignalfilteriirPath::get(self : SignalfilteriirPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirPath::set(self : SignalfilteriirPath, i : Int, v : Double) -> SignalfilteriirPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirPath::sum(self : SignalfilteriirPath) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirPath::mean(self : SignalfilteriirPath) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirPath::scale(self : SignalfilteriirPath, f : Double) -> SignalfilteriirPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirPath::add(self : SignalfilteriirPath, other : SignalfilteriirPath) -> SignalfilteriirPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirPath::copy(self : SignalfilteriirPath) -> SignalfilteriirPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirPath::fill(self : SignalfilteriirPath, v : Double) -> SignalfilteriirPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirPath::min(self : SignalfilteriirPath) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirPath::max(self : SignalfilteriirPath) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirPath::to_string(self : SignalfilteriirPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_cluster_make(size : Int) -> SignalfilteriirCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirCluster::len(self : SignalfilteriirCluster) -> Int { self.size }

pub fn SignalfilteriirCluster::get(self : SignalfilteriirCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirCluster::set(self : SignalfilteriirCluster, i : Int, v : Double) -> SignalfilteriirCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirCluster::sum(self : SignalfilteriirCluster) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirCluster::mean(self : SignalfilteriirCluster) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirCluster::scale(self : SignalfilteriirCluster, f : Double) -> SignalfilteriirCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirCluster::add(self : SignalfilteriirCluster, other : SignalfilteriirCluster) -> SignalfilteriirCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirCluster::copy(self : SignalfilteriirCluster) -> SignalfilteriirCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirCluster::fill(self : SignalfilteriirCluster, v : Double) -> SignalfilteriirCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirCluster::min(self : SignalfilteriirCluster) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirCluster::max(self : SignalfilteriirCluster) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirCluster::to_string(self : SignalfilteriirCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_model_make(size : Int) -> SignalfilteriirModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirModel::len(self : SignalfilteriirModel) -> Int { self.size }

pub fn SignalfilteriirModel::get(self : SignalfilteriirModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirModel::set(self : SignalfilteriirModel, i : Int, v : Double) -> SignalfilteriirModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirModel::sum(self : SignalfilteriirModel) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirModel::mean(self : SignalfilteriirModel) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirModel::scale(self : SignalfilteriirModel, f : Double) -> SignalfilteriirModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirModel::add(self : SignalfilteriirModel, other : SignalfilteriirModel) -> SignalfilteriirModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirModel::copy(self : SignalfilteriirModel) -> SignalfilteriirModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirModel::fill(self : SignalfilteriirModel, v : Double) -> SignalfilteriirModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirModel::min(self : SignalfilteriirModel) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirModel::max(self : SignalfilteriirModel) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirModel::to_string(self : SignalfilteriirModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_layer_make(size : Int) -> SignalfilteriirLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirLayer::len(self : SignalfilteriirLayer) -> Int { self.size }

pub fn SignalfilteriirLayer::get(self : SignalfilteriirLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirLayer::set(self : SignalfilteriirLayer, i : Int, v : Double) -> SignalfilteriirLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirLayer::sum(self : SignalfilteriirLayer) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirLayer::mean(self : SignalfilteriirLayer) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirLayer::scale(self : SignalfilteriirLayer, f : Double) -> SignalfilteriirLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirLayer::add(self : SignalfilteriirLayer, other : SignalfilteriirLayer) -> SignalfilteriirLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirLayer::copy(self : SignalfilteriirLayer) -> SignalfilteriirLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirLayer::fill(self : SignalfilteriirLayer, v : Double) -> SignalfilteriirLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirLayer::min(self : SignalfilteriirLayer) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirLayer::max(self : SignalfilteriirLayer) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirLayer::to_string(self : SignalfilteriirLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_buffer_make(size : Int) -> SignalfilteriirBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirBuffer::len(self : SignalfilteriirBuffer) -> Int { self.size }

pub fn SignalfilteriirBuffer::get(self : SignalfilteriirBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirBuffer::set(self : SignalfilteriirBuffer, i : Int, v : Double) -> SignalfilteriirBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirBuffer::sum(self : SignalfilteriirBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirBuffer::mean(self : SignalfilteriirBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirBuffer::scale(self : SignalfilteriirBuffer, f : Double) -> SignalfilteriirBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirBuffer::add(self : SignalfilteriirBuffer, other : SignalfilteriirBuffer) -> SignalfilteriirBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirBuffer::copy(self : SignalfilteriirBuffer) -> SignalfilteriirBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirBuffer::fill(self : SignalfilteriirBuffer, v : Double) -> SignalfilteriirBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirBuffer::min(self : SignalfilteriirBuffer) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirBuffer::max(self : SignalfilteriirBuffer) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirBuffer::to_string(self : SignalfilteriirBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_cursor_make(size : Int) -> SignalfilteriirCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirCursor::len(self : SignalfilteriirCursor) -> Int { self.size }

pub fn SignalfilteriirCursor::get(self : SignalfilteriirCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirCursor::set(self : SignalfilteriirCursor, i : Int, v : Double) -> SignalfilteriirCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirCursor::sum(self : SignalfilteriirCursor) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirCursor::mean(self : SignalfilteriirCursor) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirCursor::scale(self : SignalfilteriirCursor, f : Double) -> SignalfilteriirCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirCursor::add(self : SignalfilteriirCursor, other : SignalfilteriirCursor) -> SignalfilteriirCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirCursor::copy(self : SignalfilteriirCursor) -> SignalfilteriirCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirCursor::fill(self : SignalfilteriirCursor, v : Double) -> SignalfilteriirCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirCursor::min(self : SignalfilteriirCursor) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirCursor::max(self : SignalfilteriirCursor) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirCursor::to_string(self : SignalfilteriirCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_view_make(size : Int) -> SignalfilteriirView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirView::len(self : SignalfilteriirView) -> Int { self.size }

pub fn SignalfilteriirView::get(self : SignalfilteriirView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirView::set(self : SignalfilteriirView, i : Int, v : Double) -> SignalfilteriirView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirView::sum(self : SignalfilteriirView) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirView::mean(self : SignalfilteriirView) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirView::scale(self : SignalfilteriirView, f : Double) -> SignalfilteriirView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirView::add(self : SignalfilteriirView, other : SignalfilteriirView) -> SignalfilteriirView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirView::copy(self : SignalfilteriirView) -> SignalfilteriirView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirView::fill(self : SignalfilteriirView, v : Double) -> SignalfilteriirView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirView::min(self : SignalfilteriirView) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirView::max(self : SignalfilteriirView) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirView::to_string(self : SignalfilteriirView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_range_make(size : Int) -> SignalfilteriirRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirRange::len(self : SignalfilteriirRange) -> Int { self.size }

pub fn SignalfilteriirRange::get(self : SignalfilteriirRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirRange::set(self : SignalfilteriirRange, i : Int, v : Double) -> SignalfilteriirRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirRange::sum(self : SignalfilteriirRange) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirRange::mean(self : SignalfilteriirRange) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirRange::scale(self : SignalfilteriirRange, f : Double) -> SignalfilteriirRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirRange::add(self : SignalfilteriirRange, other : SignalfilteriirRange) -> SignalfilteriirRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirRange::copy(self : SignalfilteriirRange) -> SignalfilteriirRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirRange::fill(self : SignalfilteriirRange, v : Double) -> SignalfilteriirRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirRange::min(self : SignalfilteriirRange) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirRange::max(self : SignalfilteriirRange) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirRange::to_string(self : SignalfilteriirRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_slice_make(size : Int) -> SignalfilteriirSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilteriirSlice::len(self : SignalfilteriirSlice) -> Int { self.size }

pub fn SignalfilteriirSlice::get(self : SignalfilteriirSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilteriirSlice::set(self : SignalfilteriirSlice, i : Int, v : Double) -> SignalfilteriirSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilteriirSlice::sum(self : SignalfilteriirSlice) -> Double { @_common.sum(self.data) }

pub fn SignalfilteriirSlice::mean(self : SignalfilteriirSlice) -> Double { @_common.mean(self.data) }

pub fn SignalfilteriirSlice::scale(self : SignalfilteriirSlice, f : Double) -> SignalfilteriirSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirSlice::add(self : SignalfilteriirSlice, other : SignalfilteriirSlice) -> SignalfilteriirSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilteriirSlice::copy(self : SignalfilteriirSlice) -> SignalfilteriirSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirSlice::fill(self : SignalfilteriirSlice, v : Double) -> SignalfilteriirSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilteriirSlice::min(self : SignalfilteriirSlice) -> Double { @_common.min(self.data) }

pub fn SignalfilteriirSlice::max(self : SignalfilteriirSlice) -> Double { @_common.max(self.data) }

pub fn SignalfilteriirSlice::to_string(self : SignalfilteriirSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

