///===
/// extcore/signal_filter_median

pub(all) struct SignalfiltermedianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_median_make_point(x : Double, y : Double) -> SignalfiltermedianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_median_make_point3(x : Double, y : Double, z : Double) -> SignalfiltermedianPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfiltermedianPoint::x(self : SignalfiltermedianPoint) -> Double { self.x }

pub fn SignalfiltermedianPoint::y(self : SignalfiltermedianPoint) -> Double { self.y }

pub fn SignalfiltermedianPoint::z(self : SignalfiltermedianPoint) -> Double { self.z }

pub fn SignalfiltermedianPoint::label(self : SignalfiltermedianPoint) -> Int { self.label }

pub fn SignalfiltermedianPoint::dist(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfiltermedianPoint::add(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfiltermedianPoint::sub(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfiltermedianPoint::scale(self : SignalfiltermedianPoint, s : Double) -> SignalfiltermedianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfiltermedianPoint::dot(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfiltermedianPoint::cross(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfiltermedianPoint::norm(self : SignalfiltermedianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfiltermedianPoint::normalize(self : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfiltermedianPoint::negate(self : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfiltermedianPoint::mid(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfiltermedianPoint::lerp(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint, t : Double) -> SignalfiltermedianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfiltermedianPoint::to_string(self : SignalfiltermedianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfiltermedianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_median_make_series(vals : Array[Double], name : String) -> SignalfiltermedianSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfiltermedianSeries::len(self : SignalfiltermedianSeries) -> Int { self.vals.length() }

pub fn SignalfiltermedianSeries::sum(self : SignalfiltermedianSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfiltermedianSeries::mean(self : SignalfiltermedianSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfiltermedianSeries::min(self : SignalfiltermedianSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfiltermedianSeries::max(self : SignalfiltermedianSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfiltermedianSeries::range(self : SignalfiltermedianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfiltermedianSeries::variance(self : SignalfiltermedianSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfiltermedianSeries::std(self : SignalfiltermedianSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfiltermedianSeries::median(self : SignalfiltermedianSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfiltermedianSeries::scale(self : SignalfiltermedianSeries, f : Double) -> SignalfiltermedianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfiltermedianSeries::add(self : SignalfiltermedianSeries, other : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfiltermedianSeries::sub(self : SignalfiltermedianSeries, other : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfiltermedianSeries::normalize(self : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfiltermedianSeries::cumsum(self : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfiltermedianSeries::to_string(self : SignalfiltermedianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfiltermedianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_median_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfiltermedianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_median_matrix_identity(n : Int) -> SignalfiltermedianMatrix {
  let m = signal_filter_median_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfiltermedianMatrix::get(self : SignalfiltermedianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfiltermedianMatrix::transpose(self : SignalfiltermedianMatrix) -> SignalfiltermedianMatrix {
  let result = signal_filter_median_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfiltermedianMatrix::add(self : SignalfiltermedianMatrix, other : SignalfiltermedianMatrix) -> SignalfiltermedianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_median_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfiltermedianMatrix::scale(self : SignalfiltermedianMatrix, s : Double) -> SignalfiltermedianMatrix {
  let result = signal_filter_median_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfiltermedianMatrix::multiply(self : SignalfiltermedianMatrix, other : SignalfiltermedianMatrix) -> SignalfiltermedianMatrix {
  if self.cols != other.rows { return signal_filter_median_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_median_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalfiltermedianMatrix::trace(self : SignalfiltermedianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfiltermedianMatrix::det(self : SignalfiltermedianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfiltermedianMatrix::norm(self : SignalfiltermedianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfiltermedianMatrix::to_string(self : SignalfiltermedianMatrix) -> String {
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

pub(all) struct SignalfiltermedianVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_median_make_vector(comps : Array[Double]) -> SignalfiltermedianVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_median_vector_zero(dim : Int) -> SignalfiltermedianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfiltermedianVector::add(self : SignalfiltermedianVector, other : SignalfiltermedianVector) -> SignalfiltermedianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfiltermedianVector::sub(self : SignalfiltermedianVector, other : SignalfiltermedianVector) -> SignalfiltermedianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfiltermedianVector::scale(self : SignalfiltermedianVector, s : Double) -> SignalfiltermedianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfiltermedianVector::dot(self : SignalfiltermedianVector, other : SignalfiltermedianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfiltermedianVector::norm(self : SignalfiltermedianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfiltermedianVector::normalize(self : SignalfiltermedianVector) -> SignalfiltermedianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfiltermedianVector::dist(self : SignalfiltermedianVector, other : SignalfiltermedianVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfiltermedianVector::to_string(self : SignalfiltermedianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfiltermedianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_frame_make(size : Int) -> SignalfiltermedianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianFrame::len(self : SignalfiltermedianFrame) -> Int { self.size }

pub fn SignalfiltermedianFrame::get(self : SignalfiltermedianFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianFrame::set(self : SignalfiltermedianFrame, i : Int, v : Double) -> SignalfiltermedianFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianFrame::sum(self : SignalfiltermedianFrame) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianFrame::mean(self : SignalfiltermedianFrame) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianFrame::scale(self : SignalfiltermedianFrame, f : Double) -> SignalfiltermedianFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianFrame::add(self : SignalfiltermedianFrame, other : SignalfiltermedianFrame) -> SignalfiltermedianFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianFrame::copy(self : SignalfiltermedianFrame) -> SignalfiltermedianFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianFrame::fill(self : SignalfiltermedianFrame, v : Double) -> SignalfiltermedianFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianFrame::min(self : SignalfiltermedianFrame) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianFrame::max(self : SignalfiltermedianFrame) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianFrame::to_string(self : SignalfiltermedianFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_table_make(size : Int) -> SignalfiltermedianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianTable::len(self : SignalfiltermedianTable) -> Int { self.size }

pub fn SignalfiltermedianTable::get(self : SignalfiltermedianTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianTable::set(self : SignalfiltermedianTable, i : Int, v : Double) -> SignalfiltermedianTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianTable::sum(self : SignalfiltermedianTable) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianTable::mean(self : SignalfiltermedianTable) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianTable::scale(self : SignalfiltermedianTable, f : Double) -> SignalfiltermedianTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianTable::add(self : SignalfiltermedianTable, other : SignalfiltermedianTable) -> SignalfiltermedianTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianTable::copy(self : SignalfiltermedianTable) -> SignalfiltermedianTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianTable::fill(self : SignalfiltermedianTable, v : Double) -> SignalfiltermedianTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianTable::min(self : SignalfiltermedianTable) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianTable::max(self : SignalfiltermedianTable) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianTable::to_string(self : SignalfiltermedianTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_graphn_make(size : Int) -> SignalfiltermedianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianGraphN::len(self : SignalfiltermedianGraphN) -> Int { self.size }

pub fn SignalfiltermedianGraphN::get(self : SignalfiltermedianGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianGraphN::set(self : SignalfiltermedianGraphN, i : Int, v : Double) -> SignalfiltermedianGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianGraphN::sum(self : SignalfiltermedianGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianGraphN::mean(self : SignalfiltermedianGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianGraphN::scale(self : SignalfiltermedianGraphN, f : Double) -> SignalfiltermedianGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianGraphN::add(self : SignalfiltermedianGraphN, other : SignalfiltermedianGraphN) -> SignalfiltermedianGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianGraphN::copy(self : SignalfiltermedianGraphN) -> SignalfiltermedianGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianGraphN::fill(self : SignalfiltermedianGraphN, v : Double) -> SignalfiltermedianGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianGraphN::min(self : SignalfiltermedianGraphN) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianGraphN::max(self : SignalfiltermedianGraphN) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianGraphN::to_string(self : SignalfiltermedianGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_node_make(size : Int) -> SignalfiltermedianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianNode::len(self : SignalfiltermedianNode) -> Int { self.size }

pub fn SignalfiltermedianNode::get(self : SignalfiltermedianNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianNode::set(self : SignalfiltermedianNode, i : Int, v : Double) -> SignalfiltermedianNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianNode::sum(self : SignalfiltermedianNode) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianNode::mean(self : SignalfiltermedianNode) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianNode::scale(self : SignalfiltermedianNode, f : Double) -> SignalfiltermedianNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianNode::add(self : SignalfiltermedianNode, other : SignalfiltermedianNode) -> SignalfiltermedianNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianNode::copy(self : SignalfiltermedianNode) -> SignalfiltermedianNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianNode::fill(self : SignalfiltermedianNode, v : Double) -> SignalfiltermedianNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianNode::min(self : SignalfiltermedianNode) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianNode::max(self : SignalfiltermedianNode) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianNode::to_string(self : SignalfiltermedianNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_edge_make(size : Int) -> SignalfiltermedianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianEdge::len(self : SignalfiltermedianEdge) -> Int { self.size }

pub fn SignalfiltermedianEdge::get(self : SignalfiltermedianEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianEdge::set(self : SignalfiltermedianEdge, i : Int, v : Double) -> SignalfiltermedianEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianEdge::sum(self : SignalfiltermedianEdge) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianEdge::mean(self : SignalfiltermedianEdge) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianEdge::scale(self : SignalfiltermedianEdge, f : Double) -> SignalfiltermedianEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianEdge::add(self : SignalfiltermedianEdge, other : SignalfiltermedianEdge) -> SignalfiltermedianEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianEdge::copy(self : SignalfiltermedianEdge) -> SignalfiltermedianEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianEdge::fill(self : SignalfiltermedianEdge, v : Double) -> SignalfiltermedianEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianEdge::min(self : SignalfiltermedianEdge) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianEdge::max(self : SignalfiltermedianEdge) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianEdge::to_string(self : SignalfiltermedianEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_path_make(size : Int) -> SignalfiltermedianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianPath::len(self : SignalfiltermedianPath) -> Int { self.size }

pub fn SignalfiltermedianPath::get(self : SignalfiltermedianPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianPath::set(self : SignalfiltermedianPath, i : Int, v : Double) -> SignalfiltermedianPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianPath::sum(self : SignalfiltermedianPath) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianPath::mean(self : SignalfiltermedianPath) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianPath::scale(self : SignalfiltermedianPath, f : Double) -> SignalfiltermedianPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianPath::add(self : SignalfiltermedianPath, other : SignalfiltermedianPath) -> SignalfiltermedianPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianPath::copy(self : SignalfiltermedianPath) -> SignalfiltermedianPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianPath::fill(self : SignalfiltermedianPath, v : Double) -> SignalfiltermedianPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianPath::min(self : SignalfiltermedianPath) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianPath::max(self : SignalfiltermedianPath) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianPath::to_string(self : SignalfiltermedianPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_cluster_make(size : Int) -> SignalfiltermedianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianCluster::len(self : SignalfiltermedianCluster) -> Int { self.size }

pub fn SignalfiltermedianCluster::get(self : SignalfiltermedianCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianCluster::set(self : SignalfiltermedianCluster, i : Int, v : Double) -> SignalfiltermedianCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianCluster::sum(self : SignalfiltermedianCluster) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianCluster::mean(self : SignalfiltermedianCluster) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianCluster::scale(self : SignalfiltermedianCluster, f : Double) -> SignalfiltermedianCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianCluster::add(self : SignalfiltermedianCluster, other : SignalfiltermedianCluster) -> SignalfiltermedianCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianCluster::copy(self : SignalfiltermedianCluster) -> SignalfiltermedianCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianCluster::fill(self : SignalfiltermedianCluster, v : Double) -> SignalfiltermedianCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianCluster::min(self : SignalfiltermedianCluster) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianCluster::max(self : SignalfiltermedianCluster) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianCluster::to_string(self : SignalfiltermedianCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_model_make(size : Int) -> SignalfiltermedianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianModel::len(self : SignalfiltermedianModel) -> Int { self.size }

pub fn SignalfiltermedianModel::get(self : SignalfiltermedianModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianModel::set(self : SignalfiltermedianModel, i : Int, v : Double) -> SignalfiltermedianModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianModel::sum(self : SignalfiltermedianModel) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianModel::mean(self : SignalfiltermedianModel) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianModel::scale(self : SignalfiltermedianModel, f : Double) -> SignalfiltermedianModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianModel::add(self : SignalfiltermedianModel, other : SignalfiltermedianModel) -> SignalfiltermedianModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianModel::copy(self : SignalfiltermedianModel) -> SignalfiltermedianModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianModel::fill(self : SignalfiltermedianModel, v : Double) -> SignalfiltermedianModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianModel::min(self : SignalfiltermedianModel) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianModel::max(self : SignalfiltermedianModel) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianModel::to_string(self : SignalfiltermedianModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_layer_make(size : Int) -> SignalfiltermedianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianLayer::len(self : SignalfiltermedianLayer) -> Int { self.size }

pub fn SignalfiltermedianLayer::get(self : SignalfiltermedianLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianLayer::set(self : SignalfiltermedianLayer, i : Int, v : Double) -> SignalfiltermedianLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianLayer::sum(self : SignalfiltermedianLayer) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianLayer::mean(self : SignalfiltermedianLayer) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianLayer::scale(self : SignalfiltermedianLayer, f : Double) -> SignalfiltermedianLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianLayer::add(self : SignalfiltermedianLayer, other : SignalfiltermedianLayer) -> SignalfiltermedianLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianLayer::copy(self : SignalfiltermedianLayer) -> SignalfiltermedianLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianLayer::fill(self : SignalfiltermedianLayer, v : Double) -> SignalfiltermedianLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianLayer::min(self : SignalfiltermedianLayer) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianLayer::max(self : SignalfiltermedianLayer) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianLayer::to_string(self : SignalfiltermedianLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_buffer_make(size : Int) -> SignalfiltermedianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianBuffer::len(self : SignalfiltermedianBuffer) -> Int { self.size }

pub fn SignalfiltermedianBuffer::get(self : SignalfiltermedianBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianBuffer::set(self : SignalfiltermedianBuffer, i : Int, v : Double) -> SignalfiltermedianBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianBuffer::sum(self : SignalfiltermedianBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianBuffer::mean(self : SignalfiltermedianBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianBuffer::scale(self : SignalfiltermedianBuffer, f : Double) -> SignalfiltermedianBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianBuffer::add(self : SignalfiltermedianBuffer, other : SignalfiltermedianBuffer) -> SignalfiltermedianBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianBuffer::copy(self : SignalfiltermedianBuffer) -> SignalfiltermedianBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianBuffer::fill(self : SignalfiltermedianBuffer, v : Double) -> SignalfiltermedianBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianBuffer::min(self : SignalfiltermedianBuffer) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianBuffer::max(self : SignalfiltermedianBuffer) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianBuffer::to_string(self : SignalfiltermedianBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_cursor_make(size : Int) -> SignalfiltermedianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianCursor::len(self : SignalfiltermedianCursor) -> Int { self.size }

pub fn SignalfiltermedianCursor::get(self : SignalfiltermedianCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianCursor::set(self : SignalfiltermedianCursor, i : Int, v : Double) -> SignalfiltermedianCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianCursor::sum(self : SignalfiltermedianCursor) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianCursor::mean(self : SignalfiltermedianCursor) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianCursor::scale(self : SignalfiltermedianCursor, f : Double) -> SignalfiltermedianCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianCursor::add(self : SignalfiltermedianCursor, other : SignalfiltermedianCursor) -> SignalfiltermedianCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianCursor::copy(self : SignalfiltermedianCursor) -> SignalfiltermedianCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianCursor::fill(self : SignalfiltermedianCursor, v : Double) -> SignalfiltermedianCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianCursor::min(self : SignalfiltermedianCursor) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianCursor::max(self : SignalfiltermedianCursor) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianCursor::to_string(self : SignalfiltermedianCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_view_make(size : Int) -> SignalfiltermedianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianView::len(self : SignalfiltermedianView) -> Int { self.size }

pub fn SignalfiltermedianView::get(self : SignalfiltermedianView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianView::set(self : SignalfiltermedianView, i : Int, v : Double) -> SignalfiltermedianView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianView::sum(self : SignalfiltermedianView) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianView::mean(self : SignalfiltermedianView) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianView::scale(self : SignalfiltermedianView, f : Double) -> SignalfiltermedianView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianView::add(self : SignalfiltermedianView, other : SignalfiltermedianView) -> SignalfiltermedianView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianView::copy(self : SignalfiltermedianView) -> SignalfiltermedianView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianView::fill(self : SignalfiltermedianView, v : Double) -> SignalfiltermedianView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianView::min(self : SignalfiltermedianView) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianView::max(self : SignalfiltermedianView) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianView::to_string(self : SignalfiltermedianView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_range_make(size : Int) -> SignalfiltermedianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianRange::len(self : SignalfiltermedianRange) -> Int { self.size }

pub fn SignalfiltermedianRange::get(self : SignalfiltermedianRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianRange::set(self : SignalfiltermedianRange, i : Int, v : Double) -> SignalfiltermedianRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianRange::sum(self : SignalfiltermedianRange) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianRange::mean(self : SignalfiltermedianRange) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianRange::scale(self : SignalfiltermedianRange, f : Double) -> SignalfiltermedianRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianRange::add(self : SignalfiltermedianRange, other : SignalfiltermedianRange) -> SignalfiltermedianRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianRange::copy(self : SignalfiltermedianRange) -> SignalfiltermedianRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianRange::fill(self : SignalfiltermedianRange, v : Double) -> SignalfiltermedianRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianRange::min(self : SignalfiltermedianRange) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianRange::max(self : SignalfiltermedianRange) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianRange::to_string(self : SignalfiltermedianRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_slice_make(size : Int) -> SignalfiltermedianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfiltermedianSlice::len(self : SignalfiltermedianSlice) -> Int { self.size }

pub fn SignalfiltermedianSlice::get(self : SignalfiltermedianSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfiltermedianSlice::set(self : SignalfiltermedianSlice, i : Int, v : Double) -> SignalfiltermedianSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianSlice::sum(self : SignalfiltermedianSlice) -> Double { @_common.sum(self.data) }

pub fn SignalfiltermedianSlice::mean(self : SignalfiltermedianSlice) -> Double { @_common.mean(self.data) }

pub fn SignalfiltermedianSlice::scale(self : SignalfiltermedianSlice, f : Double) -> SignalfiltermedianSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianSlice::add(self : SignalfiltermedianSlice, other : SignalfiltermedianSlice) -> SignalfiltermedianSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfiltermedianSlice::copy(self : SignalfiltermedianSlice) -> SignalfiltermedianSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianSlice::fill(self : SignalfiltermedianSlice, v : Double) -> SignalfiltermedianSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfiltermedianSlice::min(self : SignalfiltermedianSlice) -> Double { @_common.min(self.data) }

pub fn SignalfiltermedianSlice::max(self : SignalfiltermedianSlice) -> Double { @_common.max(self.data) }

pub fn SignalfiltermedianSlice::to_string(self : SignalfiltermedianSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

