///===
/// extcore/signal_filter_kalman

pub(all) struct SignalfilterkalmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_kalman_make_point(x : Double, y : Double) -> SignalfilterkalmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_kalman_make_point3(x : Double, y : Double, z : Double) -> SignalfilterkalmanPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilterkalmanPoint::x(self : SignalfilterkalmanPoint) -> Double { self.x }

pub fn SignalfilterkalmanPoint::y(self : SignalfilterkalmanPoint) -> Double { self.y }

pub fn SignalfilterkalmanPoint::z(self : SignalfilterkalmanPoint) -> Double { self.z }

pub fn SignalfilterkalmanPoint::label(self : SignalfilterkalmanPoint) -> Int { self.label }

pub fn SignalfilterkalmanPoint::dist(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilterkalmanPoint::add(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilterkalmanPoint::sub(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilterkalmanPoint::scale(self : SignalfilterkalmanPoint, s : Double) -> SignalfilterkalmanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilterkalmanPoint::dot(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilterkalmanPoint::cross(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilterkalmanPoint::norm(self : SignalfilterkalmanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilterkalmanPoint::normalize(self : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterkalmanPoint::negate(self : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilterkalmanPoint::mid(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilterkalmanPoint::lerp(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint, t : Double) -> SignalfilterkalmanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilterkalmanPoint::to_string(self : SignalfilterkalmanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilterkalmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_kalman_make_series(vals : Array[Double], name : String) -> SignalfilterkalmanSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilterkalmanSeries::len(self : SignalfilterkalmanSeries) -> Int { self.vals.length() }

pub fn SignalfilterkalmanSeries::sum(self : SignalfilterkalmanSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilterkalmanSeries::mean(self : SignalfilterkalmanSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilterkalmanSeries::min(self : SignalfilterkalmanSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilterkalmanSeries::max(self : SignalfilterkalmanSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilterkalmanSeries::range(self : SignalfilterkalmanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilterkalmanSeries::variance(self : SignalfilterkalmanSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilterkalmanSeries::std(self : SignalfilterkalmanSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilterkalmanSeries::median(self : SignalfilterkalmanSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilterkalmanSeries::scale(self : SignalfilterkalmanSeries, f : Double) -> SignalfilterkalmanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilterkalmanSeries::add(self : SignalfilterkalmanSeries, other : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilterkalmanSeries::sub(self : SignalfilterkalmanSeries, other : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilterkalmanSeries::normalize(self : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilterkalmanSeries::cumsum(self : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilterkalmanSeries::to_string(self : SignalfilterkalmanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterkalmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_kalman_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterkalmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_kalman_matrix_identity(n : Int) -> SignalfilterkalmanMatrix {
  let m = signal_filter_kalman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilterkalmanMatrix::get(self : SignalfilterkalmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilterkalmanMatrix::transpose(self : SignalfilterkalmanMatrix) -> SignalfilterkalmanMatrix {
  let result = signal_filter_kalman_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilterkalmanMatrix::add(self : SignalfilterkalmanMatrix, other : SignalfilterkalmanMatrix) -> SignalfilterkalmanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_kalman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilterkalmanMatrix::scale(self : SignalfilterkalmanMatrix, s : Double) -> SignalfilterkalmanMatrix {
  let result = signal_filter_kalman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilterkalmanMatrix::multiply(self : SignalfilterkalmanMatrix, other : SignalfilterkalmanMatrix) -> SignalfilterkalmanMatrix {
  if self.cols != other.rows { return signal_filter_kalman_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_kalman_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalfilterkalmanMatrix::trace(self : SignalfilterkalmanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilterkalmanMatrix::det(self : SignalfilterkalmanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilterkalmanMatrix::norm(self : SignalfilterkalmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilterkalmanMatrix::to_string(self : SignalfilterkalmanMatrix) -> String {
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

pub(all) struct SignalfilterkalmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_kalman_make_vector(comps : Array[Double]) -> SignalfilterkalmanVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_kalman_vector_zero(dim : Int) -> SignalfilterkalmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilterkalmanVector::add(self : SignalfilterkalmanVector, other : SignalfilterkalmanVector) -> SignalfilterkalmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterkalmanVector::sub(self : SignalfilterkalmanVector, other : SignalfilterkalmanVector) -> SignalfilterkalmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterkalmanVector::scale(self : SignalfilterkalmanVector, s : Double) -> SignalfilterkalmanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilterkalmanVector::dot(self : SignalfilterkalmanVector, other : SignalfilterkalmanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilterkalmanVector::norm(self : SignalfilterkalmanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilterkalmanVector::normalize(self : SignalfilterkalmanVector) -> SignalfilterkalmanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterkalmanVector::dist(self : SignalfilterkalmanVector, other : SignalfilterkalmanVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilterkalmanVector::to_string(self : SignalfilterkalmanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterkalmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_frame_make(size : Int) -> SignalfilterkalmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanFrame::len(self : SignalfilterkalmanFrame) -> Int { self.size }

pub fn SignalfilterkalmanFrame::get(self : SignalfilterkalmanFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanFrame::set(self : SignalfilterkalmanFrame, i : Int, v : Double) -> SignalfilterkalmanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanFrame::sum(self : SignalfilterkalmanFrame) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanFrame::mean(self : SignalfilterkalmanFrame) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanFrame::scale(self : SignalfilterkalmanFrame, f : Double) -> SignalfilterkalmanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanFrame::add(self : SignalfilterkalmanFrame, other : SignalfilterkalmanFrame) -> SignalfilterkalmanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanFrame::copy(self : SignalfilterkalmanFrame) -> SignalfilterkalmanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanFrame::fill(self : SignalfilterkalmanFrame, v : Double) -> SignalfilterkalmanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanFrame::min(self : SignalfilterkalmanFrame) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanFrame::max(self : SignalfilterkalmanFrame) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanFrame::to_string(self : SignalfilterkalmanFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_table_make(size : Int) -> SignalfilterkalmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanTable::len(self : SignalfilterkalmanTable) -> Int { self.size }

pub fn SignalfilterkalmanTable::get(self : SignalfilterkalmanTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanTable::set(self : SignalfilterkalmanTable, i : Int, v : Double) -> SignalfilterkalmanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanTable::sum(self : SignalfilterkalmanTable) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanTable::mean(self : SignalfilterkalmanTable) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanTable::scale(self : SignalfilterkalmanTable, f : Double) -> SignalfilterkalmanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanTable::add(self : SignalfilterkalmanTable, other : SignalfilterkalmanTable) -> SignalfilterkalmanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanTable::copy(self : SignalfilterkalmanTable) -> SignalfilterkalmanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanTable::fill(self : SignalfilterkalmanTable, v : Double) -> SignalfilterkalmanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanTable::min(self : SignalfilterkalmanTable) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanTable::max(self : SignalfilterkalmanTable) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanTable::to_string(self : SignalfilterkalmanTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_graphn_make(size : Int) -> SignalfilterkalmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanGraphN::len(self : SignalfilterkalmanGraphN) -> Int { self.size }

pub fn SignalfilterkalmanGraphN::get(self : SignalfilterkalmanGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanGraphN::set(self : SignalfilterkalmanGraphN, i : Int, v : Double) -> SignalfilterkalmanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanGraphN::sum(self : SignalfilterkalmanGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanGraphN::mean(self : SignalfilterkalmanGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanGraphN::scale(self : SignalfilterkalmanGraphN, f : Double) -> SignalfilterkalmanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanGraphN::add(self : SignalfilterkalmanGraphN, other : SignalfilterkalmanGraphN) -> SignalfilterkalmanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanGraphN::copy(self : SignalfilterkalmanGraphN) -> SignalfilterkalmanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanGraphN::fill(self : SignalfilterkalmanGraphN, v : Double) -> SignalfilterkalmanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanGraphN::min(self : SignalfilterkalmanGraphN) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanGraphN::max(self : SignalfilterkalmanGraphN) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanGraphN::to_string(self : SignalfilterkalmanGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_node_make(size : Int) -> SignalfilterkalmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanNode::len(self : SignalfilterkalmanNode) -> Int { self.size }

pub fn SignalfilterkalmanNode::get(self : SignalfilterkalmanNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanNode::set(self : SignalfilterkalmanNode, i : Int, v : Double) -> SignalfilterkalmanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanNode::sum(self : SignalfilterkalmanNode) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanNode::mean(self : SignalfilterkalmanNode) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanNode::scale(self : SignalfilterkalmanNode, f : Double) -> SignalfilterkalmanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanNode::add(self : SignalfilterkalmanNode, other : SignalfilterkalmanNode) -> SignalfilterkalmanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanNode::copy(self : SignalfilterkalmanNode) -> SignalfilterkalmanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanNode::fill(self : SignalfilterkalmanNode, v : Double) -> SignalfilterkalmanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanNode::min(self : SignalfilterkalmanNode) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanNode::max(self : SignalfilterkalmanNode) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanNode::to_string(self : SignalfilterkalmanNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_edge_make(size : Int) -> SignalfilterkalmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanEdge::len(self : SignalfilterkalmanEdge) -> Int { self.size }

pub fn SignalfilterkalmanEdge::get(self : SignalfilterkalmanEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanEdge::set(self : SignalfilterkalmanEdge, i : Int, v : Double) -> SignalfilterkalmanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanEdge::sum(self : SignalfilterkalmanEdge) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanEdge::mean(self : SignalfilterkalmanEdge) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanEdge::scale(self : SignalfilterkalmanEdge, f : Double) -> SignalfilterkalmanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanEdge::add(self : SignalfilterkalmanEdge, other : SignalfilterkalmanEdge) -> SignalfilterkalmanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanEdge::copy(self : SignalfilterkalmanEdge) -> SignalfilterkalmanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanEdge::fill(self : SignalfilterkalmanEdge, v : Double) -> SignalfilterkalmanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanEdge::min(self : SignalfilterkalmanEdge) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanEdge::max(self : SignalfilterkalmanEdge) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanEdge::to_string(self : SignalfilterkalmanEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_path_make(size : Int) -> SignalfilterkalmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanPath::len(self : SignalfilterkalmanPath) -> Int { self.size }

pub fn SignalfilterkalmanPath::get(self : SignalfilterkalmanPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanPath::set(self : SignalfilterkalmanPath, i : Int, v : Double) -> SignalfilterkalmanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanPath::sum(self : SignalfilterkalmanPath) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanPath::mean(self : SignalfilterkalmanPath) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanPath::scale(self : SignalfilterkalmanPath, f : Double) -> SignalfilterkalmanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanPath::add(self : SignalfilterkalmanPath, other : SignalfilterkalmanPath) -> SignalfilterkalmanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanPath::copy(self : SignalfilterkalmanPath) -> SignalfilterkalmanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanPath::fill(self : SignalfilterkalmanPath, v : Double) -> SignalfilterkalmanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanPath::min(self : SignalfilterkalmanPath) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanPath::max(self : SignalfilterkalmanPath) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanPath::to_string(self : SignalfilterkalmanPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_cluster_make(size : Int) -> SignalfilterkalmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanCluster::len(self : SignalfilterkalmanCluster) -> Int { self.size }

pub fn SignalfilterkalmanCluster::get(self : SignalfilterkalmanCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanCluster::set(self : SignalfilterkalmanCluster, i : Int, v : Double) -> SignalfilterkalmanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanCluster::sum(self : SignalfilterkalmanCluster) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanCluster::mean(self : SignalfilterkalmanCluster) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanCluster::scale(self : SignalfilterkalmanCluster, f : Double) -> SignalfilterkalmanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanCluster::add(self : SignalfilterkalmanCluster, other : SignalfilterkalmanCluster) -> SignalfilterkalmanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanCluster::copy(self : SignalfilterkalmanCluster) -> SignalfilterkalmanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanCluster::fill(self : SignalfilterkalmanCluster, v : Double) -> SignalfilterkalmanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanCluster::min(self : SignalfilterkalmanCluster) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanCluster::max(self : SignalfilterkalmanCluster) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanCluster::to_string(self : SignalfilterkalmanCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_model_make(size : Int) -> SignalfilterkalmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanModel::len(self : SignalfilterkalmanModel) -> Int { self.size }

pub fn SignalfilterkalmanModel::get(self : SignalfilterkalmanModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanModel::set(self : SignalfilterkalmanModel, i : Int, v : Double) -> SignalfilterkalmanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanModel::sum(self : SignalfilterkalmanModel) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanModel::mean(self : SignalfilterkalmanModel) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanModel::scale(self : SignalfilterkalmanModel, f : Double) -> SignalfilterkalmanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanModel::add(self : SignalfilterkalmanModel, other : SignalfilterkalmanModel) -> SignalfilterkalmanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanModel::copy(self : SignalfilterkalmanModel) -> SignalfilterkalmanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanModel::fill(self : SignalfilterkalmanModel, v : Double) -> SignalfilterkalmanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanModel::min(self : SignalfilterkalmanModel) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanModel::max(self : SignalfilterkalmanModel) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanModel::to_string(self : SignalfilterkalmanModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_layer_make(size : Int) -> SignalfilterkalmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanLayer::len(self : SignalfilterkalmanLayer) -> Int { self.size }

pub fn SignalfilterkalmanLayer::get(self : SignalfilterkalmanLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanLayer::set(self : SignalfilterkalmanLayer, i : Int, v : Double) -> SignalfilterkalmanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanLayer::sum(self : SignalfilterkalmanLayer) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanLayer::mean(self : SignalfilterkalmanLayer) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanLayer::scale(self : SignalfilterkalmanLayer, f : Double) -> SignalfilterkalmanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanLayer::add(self : SignalfilterkalmanLayer, other : SignalfilterkalmanLayer) -> SignalfilterkalmanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanLayer::copy(self : SignalfilterkalmanLayer) -> SignalfilterkalmanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanLayer::fill(self : SignalfilterkalmanLayer, v : Double) -> SignalfilterkalmanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanLayer::min(self : SignalfilterkalmanLayer) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanLayer::max(self : SignalfilterkalmanLayer) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanLayer::to_string(self : SignalfilterkalmanLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_buffer_make(size : Int) -> SignalfilterkalmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanBuffer::len(self : SignalfilterkalmanBuffer) -> Int { self.size }

pub fn SignalfilterkalmanBuffer::get(self : SignalfilterkalmanBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanBuffer::set(self : SignalfilterkalmanBuffer, i : Int, v : Double) -> SignalfilterkalmanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanBuffer::sum(self : SignalfilterkalmanBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanBuffer::mean(self : SignalfilterkalmanBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanBuffer::scale(self : SignalfilterkalmanBuffer, f : Double) -> SignalfilterkalmanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanBuffer::add(self : SignalfilterkalmanBuffer, other : SignalfilterkalmanBuffer) -> SignalfilterkalmanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanBuffer::copy(self : SignalfilterkalmanBuffer) -> SignalfilterkalmanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanBuffer::fill(self : SignalfilterkalmanBuffer, v : Double) -> SignalfilterkalmanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanBuffer::min(self : SignalfilterkalmanBuffer) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanBuffer::max(self : SignalfilterkalmanBuffer) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanBuffer::to_string(self : SignalfilterkalmanBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_cursor_make(size : Int) -> SignalfilterkalmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanCursor::len(self : SignalfilterkalmanCursor) -> Int { self.size }

pub fn SignalfilterkalmanCursor::get(self : SignalfilterkalmanCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanCursor::set(self : SignalfilterkalmanCursor, i : Int, v : Double) -> SignalfilterkalmanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanCursor::sum(self : SignalfilterkalmanCursor) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanCursor::mean(self : SignalfilterkalmanCursor) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanCursor::scale(self : SignalfilterkalmanCursor, f : Double) -> SignalfilterkalmanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanCursor::add(self : SignalfilterkalmanCursor, other : SignalfilterkalmanCursor) -> SignalfilterkalmanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanCursor::copy(self : SignalfilterkalmanCursor) -> SignalfilterkalmanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanCursor::fill(self : SignalfilterkalmanCursor, v : Double) -> SignalfilterkalmanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanCursor::min(self : SignalfilterkalmanCursor) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanCursor::max(self : SignalfilterkalmanCursor) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanCursor::to_string(self : SignalfilterkalmanCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_view_make(size : Int) -> SignalfilterkalmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanView::len(self : SignalfilterkalmanView) -> Int { self.size }

pub fn SignalfilterkalmanView::get(self : SignalfilterkalmanView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanView::set(self : SignalfilterkalmanView, i : Int, v : Double) -> SignalfilterkalmanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanView::sum(self : SignalfilterkalmanView) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanView::mean(self : SignalfilterkalmanView) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanView::scale(self : SignalfilterkalmanView, f : Double) -> SignalfilterkalmanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanView::add(self : SignalfilterkalmanView, other : SignalfilterkalmanView) -> SignalfilterkalmanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanView::copy(self : SignalfilterkalmanView) -> SignalfilterkalmanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanView::fill(self : SignalfilterkalmanView, v : Double) -> SignalfilterkalmanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanView::min(self : SignalfilterkalmanView) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanView::max(self : SignalfilterkalmanView) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanView::to_string(self : SignalfilterkalmanView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_range_make(size : Int) -> SignalfilterkalmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanRange::len(self : SignalfilterkalmanRange) -> Int { self.size }

pub fn SignalfilterkalmanRange::get(self : SignalfilterkalmanRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanRange::set(self : SignalfilterkalmanRange, i : Int, v : Double) -> SignalfilterkalmanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanRange::sum(self : SignalfilterkalmanRange) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanRange::mean(self : SignalfilterkalmanRange) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanRange::scale(self : SignalfilterkalmanRange, f : Double) -> SignalfilterkalmanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanRange::add(self : SignalfilterkalmanRange, other : SignalfilterkalmanRange) -> SignalfilterkalmanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanRange::copy(self : SignalfilterkalmanRange) -> SignalfilterkalmanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanRange::fill(self : SignalfilterkalmanRange, v : Double) -> SignalfilterkalmanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanRange::min(self : SignalfilterkalmanRange) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanRange::max(self : SignalfilterkalmanRange) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanRange::to_string(self : SignalfilterkalmanRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_slice_make(size : Int) -> SignalfilterkalmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalfilterkalmanSlice::len(self : SignalfilterkalmanSlice) -> Int { self.size }

pub fn SignalfilterkalmanSlice::get(self : SignalfilterkalmanSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalfilterkalmanSlice::set(self : SignalfilterkalmanSlice, i : Int, v : Double) -> SignalfilterkalmanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanSlice::sum(self : SignalfilterkalmanSlice) -> Double { @_common.sum(self.data) }

pub fn SignalfilterkalmanSlice::mean(self : SignalfilterkalmanSlice) -> Double { @_common.mean(self.data) }

pub fn SignalfilterkalmanSlice::scale(self : SignalfilterkalmanSlice, f : Double) -> SignalfilterkalmanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanSlice::add(self : SignalfilterkalmanSlice, other : SignalfilterkalmanSlice) -> SignalfilterkalmanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalfilterkalmanSlice::copy(self : SignalfilterkalmanSlice) -> SignalfilterkalmanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanSlice::fill(self : SignalfilterkalmanSlice, v : Double) -> SignalfilterkalmanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalfilterkalmanSlice::min(self : SignalfilterkalmanSlice) -> Double { @_common.min(self.data) }

pub fn SignalfilterkalmanSlice::max(self : SignalfilterkalmanSlice) -> Double { @_common.max(self.data) }

pub fn SignalfilterkalmanSlice::to_string(self : SignalfilterkalmanSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

