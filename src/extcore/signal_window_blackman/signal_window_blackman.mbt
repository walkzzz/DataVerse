///===
/// extcore/signal_window_blackman

pub(all) struct SignalwindowblackmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_blackman_make_point(x : Double, y : Double) -> SignalwindowblackmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_blackman_make_point3(x : Double, y : Double, z : Double) -> SignalwindowblackmanPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowblackmanPoint::x(self : SignalwindowblackmanPoint) -> Double { self.x }

pub fn SignalwindowblackmanPoint::y(self : SignalwindowblackmanPoint) -> Double { self.y }

pub fn SignalwindowblackmanPoint::z(self : SignalwindowblackmanPoint) -> Double { self.z }

pub fn SignalwindowblackmanPoint::label(self : SignalwindowblackmanPoint) -> Int { self.label }

pub fn SignalwindowblackmanPoint::dist(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowblackmanPoint::add(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowblackmanPoint::sub(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowblackmanPoint::scale(self : SignalwindowblackmanPoint, s : Double) -> SignalwindowblackmanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowblackmanPoint::dot(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowblackmanPoint::cross(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowblackmanPoint::norm(self : SignalwindowblackmanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowblackmanPoint::normalize(self : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowblackmanPoint::negate(self : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowblackmanPoint::mid(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowblackmanPoint::lerp(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint, t : Double) -> SignalwindowblackmanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowblackmanPoint::to_string(self : SignalwindowblackmanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowblackmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_blackman_make_series(vals : Array[Double], name : String) -> SignalwindowblackmanSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowblackmanSeries::len(self : SignalwindowblackmanSeries) -> Int { self.vals.length() }

pub fn SignalwindowblackmanSeries::sum(self : SignalwindowblackmanSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowblackmanSeries::mean(self : SignalwindowblackmanSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowblackmanSeries::min(self : SignalwindowblackmanSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowblackmanSeries::max(self : SignalwindowblackmanSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowblackmanSeries::range(self : SignalwindowblackmanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowblackmanSeries::variance(self : SignalwindowblackmanSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowblackmanSeries::std(self : SignalwindowblackmanSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowblackmanSeries::median(self : SignalwindowblackmanSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowblackmanSeries::scale(self : SignalwindowblackmanSeries, f : Double) -> SignalwindowblackmanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowblackmanSeries::add(self : SignalwindowblackmanSeries, other : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowblackmanSeries::sub(self : SignalwindowblackmanSeries, other : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowblackmanSeries::normalize(self : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowblackmanSeries::cumsum(self : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowblackmanSeries::to_string(self : SignalwindowblackmanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowblackmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_blackman_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowblackmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_blackman_matrix_identity(n : Int) -> SignalwindowblackmanMatrix {
  let m = signal_window_blackman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowblackmanMatrix::get(self : SignalwindowblackmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowblackmanMatrix::transpose(self : SignalwindowblackmanMatrix) -> SignalwindowblackmanMatrix {
  let result = signal_window_blackman_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowblackmanMatrix::add(self : SignalwindowblackmanMatrix, other : SignalwindowblackmanMatrix) -> SignalwindowblackmanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_blackman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowblackmanMatrix::scale(self : SignalwindowblackmanMatrix, s : Double) -> SignalwindowblackmanMatrix {
  let result = signal_window_blackman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowblackmanMatrix::multiply(self : SignalwindowblackmanMatrix, other : SignalwindowblackmanMatrix) -> SignalwindowblackmanMatrix {
  if self.cols != other.rows { return signal_window_blackman_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_blackman_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn SignalwindowblackmanMatrix::trace(self : SignalwindowblackmanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowblackmanMatrix::det(self : SignalwindowblackmanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowblackmanMatrix::norm(self : SignalwindowblackmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowblackmanMatrix::to_string(self : SignalwindowblackmanMatrix) -> String {
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

pub(all) struct SignalwindowblackmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_blackman_make_vector(comps : Array[Double]) -> SignalwindowblackmanVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_blackman_vector_zero(dim : Int) -> SignalwindowblackmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowblackmanVector::add(self : SignalwindowblackmanVector, other : SignalwindowblackmanVector) -> SignalwindowblackmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowblackmanVector::sub(self : SignalwindowblackmanVector, other : SignalwindowblackmanVector) -> SignalwindowblackmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowblackmanVector::scale(self : SignalwindowblackmanVector, s : Double) -> SignalwindowblackmanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowblackmanVector::dot(self : SignalwindowblackmanVector, other : SignalwindowblackmanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowblackmanVector::norm(self : SignalwindowblackmanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowblackmanVector::normalize(self : SignalwindowblackmanVector) -> SignalwindowblackmanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowblackmanVector::dist(self : SignalwindowblackmanVector, other : SignalwindowblackmanVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowblackmanVector::to_string(self : SignalwindowblackmanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowblackmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_frame_make(size : Int) -> SignalwindowblackmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanFrame::len(self : SignalwindowblackmanFrame) -> Int { self.size }

pub fn SignalwindowblackmanFrame::get(self : SignalwindowblackmanFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanFrame::set(self : SignalwindowblackmanFrame, i : Int, v : Double) -> SignalwindowblackmanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanFrame::sum(self : SignalwindowblackmanFrame) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanFrame::mean(self : SignalwindowblackmanFrame) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanFrame::scale(self : SignalwindowblackmanFrame, f : Double) -> SignalwindowblackmanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanFrame::add(self : SignalwindowblackmanFrame, other : SignalwindowblackmanFrame) -> SignalwindowblackmanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanFrame::copy(self : SignalwindowblackmanFrame) -> SignalwindowblackmanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanFrame::fill(self : SignalwindowblackmanFrame, v : Double) -> SignalwindowblackmanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanFrame::min(self : SignalwindowblackmanFrame) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanFrame::max(self : SignalwindowblackmanFrame) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanFrame::to_string(self : SignalwindowblackmanFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_table_make(size : Int) -> SignalwindowblackmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanTable::len(self : SignalwindowblackmanTable) -> Int { self.size }

pub fn SignalwindowblackmanTable::get(self : SignalwindowblackmanTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanTable::set(self : SignalwindowblackmanTable, i : Int, v : Double) -> SignalwindowblackmanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanTable::sum(self : SignalwindowblackmanTable) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanTable::mean(self : SignalwindowblackmanTable) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanTable::scale(self : SignalwindowblackmanTable, f : Double) -> SignalwindowblackmanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanTable::add(self : SignalwindowblackmanTable, other : SignalwindowblackmanTable) -> SignalwindowblackmanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanTable::copy(self : SignalwindowblackmanTable) -> SignalwindowblackmanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanTable::fill(self : SignalwindowblackmanTable, v : Double) -> SignalwindowblackmanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanTable::min(self : SignalwindowblackmanTable) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanTable::max(self : SignalwindowblackmanTable) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanTable::to_string(self : SignalwindowblackmanTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_graphn_make(size : Int) -> SignalwindowblackmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanGraphN::len(self : SignalwindowblackmanGraphN) -> Int { self.size }

pub fn SignalwindowblackmanGraphN::get(self : SignalwindowblackmanGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanGraphN::set(self : SignalwindowblackmanGraphN, i : Int, v : Double) -> SignalwindowblackmanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanGraphN::sum(self : SignalwindowblackmanGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanGraphN::mean(self : SignalwindowblackmanGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanGraphN::scale(self : SignalwindowblackmanGraphN, f : Double) -> SignalwindowblackmanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanGraphN::add(self : SignalwindowblackmanGraphN, other : SignalwindowblackmanGraphN) -> SignalwindowblackmanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanGraphN::copy(self : SignalwindowblackmanGraphN) -> SignalwindowblackmanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanGraphN::fill(self : SignalwindowblackmanGraphN, v : Double) -> SignalwindowblackmanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanGraphN::min(self : SignalwindowblackmanGraphN) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanGraphN::max(self : SignalwindowblackmanGraphN) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanGraphN::to_string(self : SignalwindowblackmanGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_node_make(size : Int) -> SignalwindowblackmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanNode::len(self : SignalwindowblackmanNode) -> Int { self.size }

pub fn SignalwindowblackmanNode::get(self : SignalwindowblackmanNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanNode::set(self : SignalwindowblackmanNode, i : Int, v : Double) -> SignalwindowblackmanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanNode::sum(self : SignalwindowblackmanNode) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanNode::mean(self : SignalwindowblackmanNode) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanNode::scale(self : SignalwindowblackmanNode, f : Double) -> SignalwindowblackmanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanNode::add(self : SignalwindowblackmanNode, other : SignalwindowblackmanNode) -> SignalwindowblackmanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanNode::copy(self : SignalwindowblackmanNode) -> SignalwindowblackmanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanNode::fill(self : SignalwindowblackmanNode, v : Double) -> SignalwindowblackmanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanNode::min(self : SignalwindowblackmanNode) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanNode::max(self : SignalwindowblackmanNode) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanNode::to_string(self : SignalwindowblackmanNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_edge_make(size : Int) -> SignalwindowblackmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanEdge::len(self : SignalwindowblackmanEdge) -> Int { self.size }

pub fn SignalwindowblackmanEdge::get(self : SignalwindowblackmanEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanEdge::set(self : SignalwindowblackmanEdge, i : Int, v : Double) -> SignalwindowblackmanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanEdge::sum(self : SignalwindowblackmanEdge) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanEdge::mean(self : SignalwindowblackmanEdge) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanEdge::scale(self : SignalwindowblackmanEdge, f : Double) -> SignalwindowblackmanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanEdge::add(self : SignalwindowblackmanEdge, other : SignalwindowblackmanEdge) -> SignalwindowblackmanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanEdge::copy(self : SignalwindowblackmanEdge) -> SignalwindowblackmanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanEdge::fill(self : SignalwindowblackmanEdge, v : Double) -> SignalwindowblackmanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanEdge::min(self : SignalwindowblackmanEdge) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanEdge::max(self : SignalwindowblackmanEdge) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanEdge::to_string(self : SignalwindowblackmanEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_path_make(size : Int) -> SignalwindowblackmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanPath::len(self : SignalwindowblackmanPath) -> Int { self.size }

pub fn SignalwindowblackmanPath::get(self : SignalwindowblackmanPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanPath::set(self : SignalwindowblackmanPath, i : Int, v : Double) -> SignalwindowblackmanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanPath::sum(self : SignalwindowblackmanPath) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanPath::mean(self : SignalwindowblackmanPath) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanPath::scale(self : SignalwindowblackmanPath, f : Double) -> SignalwindowblackmanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanPath::add(self : SignalwindowblackmanPath, other : SignalwindowblackmanPath) -> SignalwindowblackmanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanPath::copy(self : SignalwindowblackmanPath) -> SignalwindowblackmanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanPath::fill(self : SignalwindowblackmanPath, v : Double) -> SignalwindowblackmanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanPath::min(self : SignalwindowblackmanPath) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanPath::max(self : SignalwindowblackmanPath) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanPath::to_string(self : SignalwindowblackmanPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_cluster_make(size : Int) -> SignalwindowblackmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanCluster::len(self : SignalwindowblackmanCluster) -> Int { self.size }

pub fn SignalwindowblackmanCluster::get(self : SignalwindowblackmanCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanCluster::set(self : SignalwindowblackmanCluster, i : Int, v : Double) -> SignalwindowblackmanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanCluster::sum(self : SignalwindowblackmanCluster) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanCluster::mean(self : SignalwindowblackmanCluster) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanCluster::scale(self : SignalwindowblackmanCluster, f : Double) -> SignalwindowblackmanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanCluster::add(self : SignalwindowblackmanCluster, other : SignalwindowblackmanCluster) -> SignalwindowblackmanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanCluster::copy(self : SignalwindowblackmanCluster) -> SignalwindowblackmanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanCluster::fill(self : SignalwindowblackmanCluster, v : Double) -> SignalwindowblackmanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanCluster::min(self : SignalwindowblackmanCluster) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanCluster::max(self : SignalwindowblackmanCluster) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanCluster::to_string(self : SignalwindowblackmanCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_model_make(size : Int) -> SignalwindowblackmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanModel::len(self : SignalwindowblackmanModel) -> Int { self.size }

pub fn SignalwindowblackmanModel::get(self : SignalwindowblackmanModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanModel::set(self : SignalwindowblackmanModel, i : Int, v : Double) -> SignalwindowblackmanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanModel::sum(self : SignalwindowblackmanModel) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanModel::mean(self : SignalwindowblackmanModel) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanModel::scale(self : SignalwindowblackmanModel, f : Double) -> SignalwindowblackmanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanModel::add(self : SignalwindowblackmanModel, other : SignalwindowblackmanModel) -> SignalwindowblackmanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanModel::copy(self : SignalwindowblackmanModel) -> SignalwindowblackmanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanModel::fill(self : SignalwindowblackmanModel, v : Double) -> SignalwindowblackmanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanModel::min(self : SignalwindowblackmanModel) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanModel::max(self : SignalwindowblackmanModel) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanModel::to_string(self : SignalwindowblackmanModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_layer_make(size : Int) -> SignalwindowblackmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanLayer::len(self : SignalwindowblackmanLayer) -> Int { self.size }

pub fn SignalwindowblackmanLayer::get(self : SignalwindowblackmanLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanLayer::set(self : SignalwindowblackmanLayer, i : Int, v : Double) -> SignalwindowblackmanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanLayer::sum(self : SignalwindowblackmanLayer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanLayer::mean(self : SignalwindowblackmanLayer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanLayer::scale(self : SignalwindowblackmanLayer, f : Double) -> SignalwindowblackmanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanLayer::add(self : SignalwindowblackmanLayer, other : SignalwindowblackmanLayer) -> SignalwindowblackmanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanLayer::copy(self : SignalwindowblackmanLayer) -> SignalwindowblackmanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanLayer::fill(self : SignalwindowblackmanLayer, v : Double) -> SignalwindowblackmanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanLayer::min(self : SignalwindowblackmanLayer) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanLayer::max(self : SignalwindowblackmanLayer) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanLayer::to_string(self : SignalwindowblackmanLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_buffer_make(size : Int) -> SignalwindowblackmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanBuffer::len(self : SignalwindowblackmanBuffer) -> Int { self.size }

pub fn SignalwindowblackmanBuffer::get(self : SignalwindowblackmanBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanBuffer::set(self : SignalwindowblackmanBuffer, i : Int, v : Double) -> SignalwindowblackmanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanBuffer::sum(self : SignalwindowblackmanBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanBuffer::mean(self : SignalwindowblackmanBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanBuffer::scale(self : SignalwindowblackmanBuffer, f : Double) -> SignalwindowblackmanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanBuffer::add(self : SignalwindowblackmanBuffer, other : SignalwindowblackmanBuffer) -> SignalwindowblackmanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanBuffer::copy(self : SignalwindowblackmanBuffer) -> SignalwindowblackmanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanBuffer::fill(self : SignalwindowblackmanBuffer, v : Double) -> SignalwindowblackmanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanBuffer::min(self : SignalwindowblackmanBuffer) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanBuffer::max(self : SignalwindowblackmanBuffer) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanBuffer::to_string(self : SignalwindowblackmanBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_cursor_make(size : Int) -> SignalwindowblackmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanCursor::len(self : SignalwindowblackmanCursor) -> Int { self.size }

pub fn SignalwindowblackmanCursor::get(self : SignalwindowblackmanCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanCursor::set(self : SignalwindowblackmanCursor, i : Int, v : Double) -> SignalwindowblackmanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanCursor::sum(self : SignalwindowblackmanCursor) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanCursor::mean(self : SignalwindowblackmanCursor) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanCursor::scale(self : SignalwindowblackmanCursor, f : Double) -> SignalwindowblackmanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanCursor::add(self : SignalwindowblackmanCursor, other : SignalwindowblackmanCursor) -> SignalwindowblackmanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanCursor::copy(self : SignalwindowblackmanCursor) -> SignalwindowblackmanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanCursor::fill(self : SignalwindowblackmanCursor, v : Double) -> SignalwindowblackmanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanCursor::min(self : SignalwindowblackmanCursor) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanCursor::max(self : SignalwindowblackmanCursor) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanCursor::to_string(self : SignalwindowblackmanCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_view_make(size : Int) -> SignalwindowblackmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanView::len(self : SignalwindowblackmanView) -> Int { self.size }

pub fn SignalwindowblackmanView::get(self : SignalwindowblackmanView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanView::set(self : SignalwindowblackmanView, i : Int, v : Double) -> SignalwindowblackmanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanView::sum(self : SignalwindowblackmanView) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanView::mean(self : SignalwindowblackmanView) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanView::scale(self : SignalwindowblackmanView, f : Double) -> SignalwindowblackmanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanView::add(self : SignalwindowblackmanView, other : SignalwindowblackmanView) -> SignalwindowblackmanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanView::copy(self : SignalwindowblackmanView) -> SignalwindowblackmanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanView::fill(self : SignalwindowblackmanView, v : Double) -> SignalwindowblackmanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanView::min(self : SignalwindowblackmanView) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanView::max(self : SignalwindowblackmanView) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanView::to_string(self : SignalwindowblackmanView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_range_make(size : Int) -> SignalwindowblackmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanRange::len(self : SignalwindowblackmanRange) -> Int { self.size }

pub fn SignalwindowblackmanRange::get(self : SignalwindowblackmanRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanRange::set(self : SignalwindowblackmanRange, i : Int, v : Double) -> SignalwindowblackmanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanRange::sum(self : SignalwindowblackmanRange) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanRange::mean(self : SignalwindowblackmanRange) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanRange::scale(self : SignalwindowblackmanRange, f : Double) -> SignalwindowblackmanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanRange::add(self : SignalwindowblackmanRange, other : SignalwindowblackmanRange) -> SignalwindowblackmanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanRange::copy(self : SignalwindowblackmanRange) -> SignalwindowblackmanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanRange::fill(self : SignalwindowblackmanRange, v : Double) -> SignalwindowblackmanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanRange::min(self : SignalwindowblackmanRange) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanRange::max(self : SignalwindowblackmanRange) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanRange::to_string(self : SignalwindowblackmanRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_slice_make(size : Int) -> SignalwindowblackmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowblackmanSlice::len(self : SignalwindowblackmanSlice) -> Int { self.size }

pub fn SignalwindowblackmanSlice::get(self : SignalwindowblackmanSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowblackmanSlice::set(self : SignalwindowblackmanSlice, i : Int, v : Double) -> SignalwindowblackmanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanSlice::sum(self : SignalwindowblackmanSlice) -> Double { @_common.sum(self.data) }

pub fn SignalwindowblackmanSlice::mean(self : SignalwindowblackmanSlice) -> Double { @_common.mean(self.data) }

pub fn SignalwindowblackmanSlice::scale(self : SignalwindowblackmanSlice, f : Double) -> SignalwindowblackmanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanSlice::add(self : SignalwindowblackmanSlice, other : SignalwindowblackmanSlice) -> SignalwindowblackmanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowblackmanSlice::copy(self : SignalwindowblackmanSlice) -> SignalwindowblackmanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanSlice::fill(self : SignalwindowblackmanSlice, v : Double) -> SignalwindowblackmanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowblackmanSlice::min(self : SignalwindowblackmanSlice) -> Double { @_common.min(self.data) }

pub fn SignalwindowblackmanSlice::max(self : SignalwindowblackmanSlice) -> Double { @_common.max(self.data) }

pub fn SignalwindowblackmanSlice::to_string(self : SignalwindowblackmanSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

